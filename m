Return-Path: <netdev+bounces-160070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2850AA18046
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576A83AC041
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF061F470A;
	Tue, 21 Jan 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="a912cDPd"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B691F3D55
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470693; cv=none; b=frBIXIYnYA7YbJsbrr6sedCBJmY/nAh0Tfr9y5cPy9SU/OvLANaWumt15BqUBCtuxh0SL5qsJEr/Mo6zJ0GXNVu2zN80eSH8deablomUGzHAG4oX8GujYCBK24G1vpY/Itygm7GbFG68gJxMPMHSPqLCuaxPkVCVLT+nC9ynmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470693; c=relaxed/simple;
	bh=sxUlaqsD6Whr1lX5YBXvbsm4Bl5KgtV/7baTpjSZb7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7Kk9+taL/5ulHAUicCTGt4nO9IQ47CQp9BdVDJOby9LivHPDPIJr4Oj4hQC59ajmSIs1cQWDg7c1fpn3FR2kwwR6VabTzdnCHi7C21kQpB4cDeLSXq7mRE1TncJ4KJCMVndHTKAXrmNmEHJLUjnEhPmlsp72MP/cNlRAd85HRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=a912cDPd; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1taFUm-000mED-Ka; Tue, 21 Jan 2025 15:44:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=HKOsEdRz59cBYM+g346+ZxiaUx/sxJBhpJ11wI9KxvQ=; b=a912cDPd4jxpuxSgksCd28JPkj
	+OE3gFKF2qQRYs1Y8GmDq4dQIqtOc09g+tih4qvbH9sOvfin0QzXxtf5XJeyLqSh2zynYekLbbcEN
	EtkfmYDl7s0tN4jJcN9bTbzC2G2VPxSJhUiYKIe+UnfCtEF5sNLUqUSd9d5utNPBaLG6zTJ3LI3S7
	jB21c8chJE84A/+uE2E0miJ6dLHyzBVAlNCQn2Azsak/7B0qOj9swkY2ds0X9E7ZXb/NRtIHyNFSS
	t6i5OECq3/mrnQArFo8sCyi3oNbpstgVABozyWcn9lO6OOhXRxegMki+dUjavs6UvfoPA4CatNTE1
	rGO+P2Fw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1taFUm-0005jl-73; Tue, 21 Jan 2025 15:44:48 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1taFUR-00AHot-Ui; Tue, 21 Jan 2025 15:44:28 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 21 Jan 2025 15:44:05 +0100
Subject: [PATCH net v2 4/6] vsock/test: Introduce vsock_connect_fd()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-vsock-transport-vs-autobind-v2-4-aad6069a4e8c@rbox.co>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
In-Reply-To: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>, 
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Distill timeout-guarded vsock_connect_fd(). Adapt callers.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/util.c | 45 +++++++++++++++++----------------------------
 tools/testing/vsock/util.h |  1 +
 2 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 31ee1767c8b73c05cfd219c3d520a677df6e66a6..7f7e45a6596c19b09176ea2851a490cdac0f115b 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -119,27 +119,33 @@ int vsock_bind(unsigned int cid, unsigned int port, int type)
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
@@ -150,17 +156,6 @@ int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_po
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
@@ -171,20 +166,14 @@ int vsock_connect(unsigned int cid, unsigned int port, int type)
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
index 7736594a15d29449d98bd1e9e19c3acd1a623443..817e11e483cd6596dd32d16061d801a66091c973 100644
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


