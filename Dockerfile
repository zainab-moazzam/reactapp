FROM node:18-alpine AS build-stage 
WORKDIR /app 
COPY package*.json ./ 
RUN npm install 
COPY . . 
RUN npm run build  # Build the React app for production 
FROM nginx:alpine AS serve-stage 
COPY --from=build-stage /app/build /usr/share/nginx/html 
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"] 