Return-Path: <netdev+bounces-161327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AC4A20B2A
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0554188725B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C3A1A2C0B;
	Tue, 28 Jan 2025 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="D6fzxsCH"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B981AA1FE;
	Tue, 28 Jan 2025 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070177; cv=none; b=GVZTA39v1M4HEzI/tokKGGJIKvZUmuxeHahS9mJusO1rj5qNM3Bxu36GM5mfSiQk9fEPOPXLaszb/tVymxwTGDW/gsgLSxWKu5rFwtDsyjH3PygkRtP7eEW6S2+UhuUsrRXFs3krayy0/3PvadHZ7LTEcmXpaCozLozJfVihJ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070177; c=relaxed/simple;
	bh=mCe91mZUInVshcV/ZonPnpAUaJIUZtPe5QieIg1rQPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gi+skbTZjv6jjxS1CQvi4SRmjfR/VuoaeQHGjhGV9R0Ta/gK2GGmNExO6WJgQDawckPafOxHJYoTIJ3V+Eu4vkkTgmPdAsDHzkVqDDCcWAVCYTtEXMZT8POPa7JYi2kh5rku8wCIiyUT/ZNdj/N9KRrZCTZr2Kh43Mw4Y9FqT0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=D6fzxsCH; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tclRr-002o5M-Qq; Tue, 28 Jan 2025 14:16:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=tekpfh1yrJU9RM9KvGgjy3RLhabpAVkbGFxAnwcQfbw=; b=D6fzxsCHyqZYPSqsGtVgikR3gj
	ir4NPzmMyBUZKj4yQF1ic4tLI3wc6Uw7hbYMPpoIXyegYHF1d7Hc8Z4WwVxE/r9/Q2JYoinF11Wv+
	1loGu39IfkL9BLt0f1WweAyhs/DEe1LlH+hGqslBwJIje83jyA3eDsnb6WQKc/2KFY7zR+FZHEdK7
	FngFelhusQwWbVMtZlW0YhNrZ0bpmPa9YEwEJzIba3DFFx8WUqQ4JIpawn+x9j2tRBkXfipUSAtm+
	SOBYZrS8RWUGxtkfHEHihhULO3zb9zBPZD4aPKKKoo2UgPUBC/ZSOPTZkbn4LQ47r7MCofh2cHymE
	Xx19k40w==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tclRm-0006wL-EA; Tue, 28 Jan 2025 14:16:06 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tclRK-000mZg-O7; Tue, 28 Jan 2025 14:15:38 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 28 Jan 2025 14:15:30 +0100
Subject: [PATCH net v3 4/6] vsock/test: Introduce vsock_connect_fd()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-vsock-transport-vs-autobind-v3-4-1cf57065b770@rbox.co>
References: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
In-Reply-To: <20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Distill timeout-guarded vsock_connect_fd(). Adapt callers.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/util.c | 45 +++++++++++++++++----------------------------
 tools/testing/vsock/util.h |  1 +
 2 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 6e36f9371532cfc75dd14131b84bf8393ca0952b..de25892f865f07672da0886be8bd1a429ade8b05 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -120,27 +120,33 @@ int vsock_bind(unsigned int cid, unsigned int port, int type)
 	return fd;
 }
 
-/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
-int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
+int vsock_connect_fd(int fd, unsigned int cid, unsigned int port)
 {
-	struct sockaddr_vm sa_server = {
+	struct sockaddr_vm sa = {
 		.svm_family = AF_VSOCK,
 		.svm_cid = cid,
 		.svm_port = port,
 	};
-
-	int client_fd, ret;
-
-	client_fd = vsock_bind(VMADDR_CID_ANY, bind_port, type);
+	int ret;
 
 	timeout_begin(TIMEOUT);
 	do {
-		ret = connect(client_fd, (struct sockaddr *)&sa_server, sizeof(sa_server));
+		ret = connect(fd, (struct sockaddr *)&sa, sizeof(sa));
 		timeout_check("connect");
 	} while (ret < 0 && errno == EINTR);
 	timeout_end();
 
-	if (ret < 0) {
+	return ret;
+}
+
+/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
+int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
+{
+	int client_fd;
+
+	client_fd = vsock_bind(VMADDR_CID_ANY, bind_port, type);
+
+	if (vsock_connect_fd(client_fd, cid, port)) {
 		perror("connect");
 		exit(EXIT_FAILURE);
 	}
@@ -151,17 +157,6 @@ int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_po
 /* Connect to <cid, port> and return the file descriptor. */
 int vsock_connect(unsigned int cid, unsigned int port, int type)
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
-	int ret;
 	int fd;
 
 	control_expectln("LISTENING");
@@ -172,20 +167,14 @@ int vsock_connect(unsigned int cid, unsigned int port, int type)
 		exit(EXIT_FAILURE);
 	}
 
-	timeout_begin(TIMEOUT);
-	do {
-		ret = connect(fd, &addr.sa, sizeof(addr.svm));
-		timeout_check("connect");
-	} while (ret < 0 && errno == EINTR);
-	timeout_end();
-
-	if (ret < 0) {
+	if (vsock_connect_fd(fd, cid, port)) {
 		int old_errno = errno;
 
 		close(fd);
 		fd = -1;
 		errno = old_errno;
 	}
+
 	return fd;
 }
 
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 077842905bc3e7a4bbd22caba4b7bde976de2718..d1f765ce3eeeed8f738630846bb47c4f3f6f946f 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -39,6 +39,7 @@ struct test_case {
 void init_signals(void);
 unsigned int parse_cid(const char *str);
 unsigned int parse_port(const char *str);
+int vsock_connect_fd(int fd, unsigned int cid, unsigned int port);
 int vsock_connect(unsigned int cid, unsigned int port, int type);
 int vsock_accept(unsigned int cid, unsigned int port,
 		 struct sockaddr_vm *clientaddrp, int type);

-- 
2.48.1


