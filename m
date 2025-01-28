Return-Path: <netdev+bounces-161322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D06A20B21
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C3E3A868B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784641A38E4;
	Tue, 28 Jan 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="PVrtubZ4"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376519CCEC;
	Tue, 28 Jan 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070170; cv=none; b=ZsfITWWcMAW7e3tpJ7zkHQ51PD3LTW1B/ycjuWUyGteUDUlZHaR+uifRpFDPUGAlg6h1ypB++PJuYz7l5vcsDkEpiEyglXbyGd7vEjqvNKjexvCzpS4u1f4Q8syC8Cj63xb/ZJ4QXWT1IJGAUhy8/VRUiUSJuPzH4uNr/0lpFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070170; c=relaxed/simple;
	bh=cQm26A2r2B4pkQB1WSlu2i0TqGAguDpmJPl2biUcK9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l5gii342+70wyNVsbXGJ+LkhtrC5xmrwC9RxZkWgNdq6rFkwC0fp2ATuVTFfOF0lc0oL6kL7utbBZTd+Uot3QXZfzv+047FyE2HkyGKdCIswUjdaBWaYQ1Rdu9TdgcMJHYygX8RnE3M854BXJOoyAzu0/6M92B1wPakGiV8W9SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=PVrtubZ4; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tclRl-002o4T-OD; Tue, 28 Jan 2025 14:16:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=9R5OvuG4Ddv4DLQydiPu1JDwrmDM37Ahgjrn2vEoGdY=; b=PVrtubZ4VswtH+R19mJDVy3F8q
	rsj25XuYWWw8ljxvSQacddwZpfBN9e6YX9EtcCaM6tPu7D6atr6RDukF5qRr6Eridsxbb83rNJ4Ti
	T5eEtKiccKwDY0sdtdWVvohDlBbBJKS8z/42WHDjV58Db0lbt6uho8C5RWFkxpwMaEZ60Z6Wqsli5
	YNoJBMFkorKA5IDg/UFedBbN47YfV75W2/n90Z9Gmqb/6ZsMn7nbInWOuPhSw8fNRkx/aYhIelfms
	RRyoJLX2MucxNApkllCtL1E/wiJe9ODfaoe2kVkQcICslbSrMB7RDdnOZYU/J0IhxKhvm0gul/NC2
	vacFfaFg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tclRl-0006wF-9u; Tue, 28 Jan 2025 14:16:05 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tclRK-000mZg-9O; Tue, 28 Jan 2025 14:15:38 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 28 Jan 2025 14:15:29 +0100
Subject: [PATCH net v3 3/6] vsock/test: Introduce vsock_bind()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-vsock-transport-vs-autobind-v3-3-1cf57065b770@rbox.co>
References: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
In-Reply-To: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
 Michal Luczaj <mhal@rbox.co>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.2

Add a helper for socket()+bind(). Adapt callers.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/util.c       | 57 +++++++++++++++++-----------------------
 tools/testing/vsock/util.h       |  1 +
 tools/testing/vsock/vsock_test.c | 17 +-----------
 3 files changed, 26 insertions(+), 49 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 7058dc614c25f546fc3219d6b9ade2dcef21a9bd..6e36f9371532cfc75dd14131b84bf8393ca0952b 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -96,33 +96,43 @@ void vsock_wait_remote_close(int fd)
 	close(epollfd);
 }
 
-/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
-int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
+/* Create socket <type>, bind to <cid, port> and return the file descriptor. */
+int vsock_bind(unsigned int cid, unsigned int port, int type)
 {
-	struct sockaddr_vm sa_client = {
-		.svm_family = AF_VSOCK,
-		.svm_cid = VMADDR_CID_ANY,
-		.svm_port = bind_port,
-	};
-	struct sockaddr_vm sa_server = {
+	struct sockaddr_vm sa = {
 		.svm_family = AF_VSOCK,
 		.svm_cid = cid,
 		.svm_port = port,
 	};
+	int fd;
 
-	int client_fd, ret;
-
-	client_fd = socket(AF_VSOCK, type, 0);
-	if (client_fd < 0) {
+	fd = socket(AF_VSOCK, type, 0);
+	if (fd < 0) {
 		perror("socket");
 		exit(EXIT_FAILURE);
 	}
 
-	if (bind(client_fd, (struct sockaddr *)&sa_client, sizeof(sa_client))) {
+	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa))) {
 		perror("bind");
 		exit(EXIT_FAILURE);
 	}
 
+	return fd;
+}
+
+/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
+int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
+{
+	struct sockaddr_vm sa_server = {
+		.svm_family = AF_VSOCK,
+		.svm_cid = cid,
+		.svm_port = port,
+	};
+
+	int client_fd, ret;
+
+	client_fd = vsock_bind(VMADDR_CID_ANY, bind_port, type);
+
 	timeout_begin(TIMEOUT);
 	do {
 		ret = connect(client_fd, (struct sockaddr *)&sa_server, sizeof(sa_server));
@@ -192,28 +202,9 @@ int vsock_seqpacket_connect(unsigned int cid, unsigned int port)
 /* Listen on <cid, port> and return the file descriptor. */
 static int vsock_listen(unsigned int cid, unsigned int port, int type)
 {
-	union {
-		struct sockaddr sa;
-		struct sockaddr_vm svm;
-	} addr = {
-		.svm = {
-			.svm_family = AF_VSOCK,
-			.svm_port = port,
-			.svm_cid = cid,
-		},
-	};
 	int fd;
 
-	fd = socket(AF_VSOCK, type, 0);
-	if (fd < 0) {
-		perror("socket");
-		exit(EXIT_FAILURE);
-	}
-
-	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
-		perror("bind");
-		exit(EXIT_FAILURE);
-	}
+	fd = vsock_bind(cid, port, type);
 
 	if (listen(fd, 1) < 0) {
 		perror("listen");
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index e62f46b2b92a7916e83e1e623b43c811b077db3e..077842905bc3e7a4bbd22caba4b7bde976de2718 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -43,6 +43,7 @@ int vsock_connect(unsigned int cid, unsigned int port, int type);
 int vsock_accept(unsigned int cid, unsigned int port,
 		 struct sockaddr_vm *clientaddrp, int type);
 int vsock_stream_connect(unsigned int cid, unsigned int port);
+int vsock_bind(unsigned int cid, unsigned int port, int type);
 int vsock_bind_connect(unsigned int cid, unsigned int port,
 		       unsigned int bind_port, int type);
 int vsock_seqpacket_connect(unsigned int cid, unsigned int port);
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 1eebbc0d5f616bb1afab3ec3f9e59cb609f9f6e8..daa4f3ca9b6e7267d1bb14a7d43499da3bafb108 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -113,24 +113,9 @@ static void test_stream_bind_only_client(const struct test_opts *opts)
 
 static void test_stream_bind_only_server(const struct test_opts *opts)
 {
-	union {
-		struct sockaddr sa;
-		struct sockaddr_vm svm;
-	} addr = {
-		.svm = {
-			.svm_family = AF_VSOCK,
-			.svm_port = opts->peer_port,
-			.svm_cid = VMADDR_CID_ANY,
-		},
-	};
 	int fd;
 
-	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
-
-	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
-		perror("bind");
-		exit(EXIT_FAILURE);
-	}
+	fd = vsock_bind(VMADDR_CID_ANY, opts->peer_port, SOCK_STREAM);
 
 	/* Notify the client that the server is ready */
 	control_writeln("BIND");

-- 
2.48.1


