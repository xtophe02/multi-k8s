docker build -t xtophe02/multi-client:latest -t xtophe02/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t xtophe02/multi-server:latest -t xtophe02/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t xtophe02/multi-worker:latest -t xtophe02/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push xtophe02/multi-client:latest
docker push xtophe02/multi-server:latest
docker push xtophe02/multi-worker:latest

docker push xtophe02/multi-client:$GIT_SHA
docker push xtophe02/multi-server:$GIT_SHA
docker push xtophe02/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xtophe02/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=xtophe02/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=xtophe02/multi-worker:$GIT_SHA