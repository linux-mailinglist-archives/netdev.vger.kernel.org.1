Return-Path: <netdev+bounces-160068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CE9A18044
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B223ABC22
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C6C1F4293;
	Tue, 21 Jan 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="OBZfQ5ub"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409F49641
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470692; cv=none; b=BybLlOC4mbbcYy2LiTRkJEbaQvL895w/+/zUFGgzcQ3LyEGgwHPxBiSkueZKK3LyZ3lGx9D4Ln1AHGp27ZNCcqB4ANZg4pNyLDu2eTTd0bg2UiL8O4qW/6HNNC0+SMt6psxXMNh9MZX1Sk7/y69UfUzxWgLSyGVlW8DEP2RqMGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470692; c=relaxed/simple;
	bh=qFIrLLhtaGLW+UpU+e3C2A+Rex9rGXsCQ4oHv9PYVno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQf4iDGAPMNhwExVhsHS+tWipMsRr9VRaw4ecHNJhffGdXTjN+GgWJAFqf7cdyu0LDNa1PTMe/K2LdsahmR7iF4wuDjgMyOWcziMh3NpFheZXc5MHO745djhjPlpeAA9FC8f8IRqZ4SzLs7RRJCJaYpP59pNCz6fZAYoaIhkva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=OBZfQ5ub; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1taFUl-000mE2-Te; Tue, 21 Jan 2025 15:44:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=vpqpZdDRaBiPioDkT2UimA2lfxeJi+2zBZXlo7BOPuk=; b=OBZfQ5ub0lLL3pqtxdCdv1ohvz
	kXew4CCzN+1aB3A00EZkb9UsUbZ3DOvnJ3SzGzQtC/h2HAqwgLFVZmLSbYLqKuMBXnbDDI3YQXAP+
	4r4ff5B5tB1NqQq+9XPmOgL8ipGcz2LWoWaO+WZfO0gf+g4GVf5hpUIICRh7+/+mRBUukcdu+xYQm
	d7N0ddPzZkcDrQCj3Vew4XLggnqjFH2A+EwkUzlfxO6N6B6fszO8Yu13Y1R4VCsdcC9MyuO7EfPP/
	e82WrEEaWo1/bNtw9cKeWAEx02NoMxUdMa+tRDVRi/VQCdklvca6SnDShGqnQYqA/lD6/bf7IR8Py
	nkqQpH9g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1taFUk-0005jY-E7; Tue, 21 Jan 2025 15:44:46 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1taFUR-00AHot-Ds; Tue, 21 Jan 2025 15:44:27 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 21 Jan 2025 15:44:04 +0100
Subject: [PATCH net v2 3/6] vsock/test: Introduce vsock_bind()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-vsock-transport-vs-autobind-v2-3-aad6069a4e8c@rbox.co>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
In-Reply-To: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>, 
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Add a helper for socket()+bind(). Adapt callers.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/util.c       | 56 +++++++++++++++++-----------------------
 tools/testing/vsock/util.h       |  1 +
 tools/testing/vsock/vsock_test.c | 17 +-----------
 3 files changed, 25 insertions(+), 49 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 34e9dac0a105f8aeb8c9af379b080d5ce8cb2782..31ee1767c8b73c05cfd219c3d520a677df6e66a6 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -96,33 +96,42 @@ void vsock_wait_remote_close(int fd)
 	close(epollfd);
 }
 
-/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
-int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
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
@@ -192,28 +201,9 @@ int vsock_seqpacket_connect(unsigned int cid, unsigned int port)
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
index ba84d296d8b71e1bcba2abdad337e07aac45e75e..7736594a15d29449d98bd1e9e19c3acd1a623443 100644
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
index 48f17641ca504316d1199926149c9bd62eb2921d..28a5083bbfd600cf84a1a85cec2f272ce6912dd3 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -108,24 +108,9 @@ static void test_stream_bind_only_client(const struct test_opts *opts)
 
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


