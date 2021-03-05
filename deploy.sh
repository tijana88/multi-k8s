docker build -t tijanasutara/multi-client:latest -t tijanasutara/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tijanasutara/multi-server:latest -t tijanasutara/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tijanasutara/multi-worker:latest -t tijanasutara/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tijanasutara/multi-client:latest
docker push tijanasutara/multi-server:latest
docker push tijanasutara/multi-worker:latest

docker push tijanasutara/multi-client:$SHA
docker push tijanasutara/multi-server:$SHA
docker push tijanasutara/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tijanasutara/multi-server:$SHA
kubectl set image deployments/client-deployment client=tijanasutara/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tijanasutara/multi-worker:$SHA