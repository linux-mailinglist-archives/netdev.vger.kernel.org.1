Return-Path: <netdev+bounces-194053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20508AC725A
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 22:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBBFA220E0
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C251F540F;
	Wed, 28 May 2025 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="uUye5p/a"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953CDEEB2;
	Wed, 28 May 2025 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748465137; cv=none; b=Dll/ZR4T4ejGJUr0fE1Wif9oJGpDIyQDhj9yozZOdothdDp16Vqp43Nn+wEcOUxIRtUAGLEYzy/zrNbDUz9ctr7nt5gU+nMuPxSqKQoRS50Jw3lGLQEsRyTBY9M+EcxP0zKh6qgSKuUTk3lEMdQ4PdlOSe3SITO+bjMNUlzDWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748465137; c=relaxed/simple;
	bh=NcdrjLx4oWaixboovqCbP3Vk0W0oTn4ZkT108Lhg92c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3yFWorEyheyzaaWFC9g+T80WS/Z7JOZdLs7YvtXAF61xcbSxYuJkH2D6Pl0a7uYouQNzFnO2WocrqdavfhfB4btXp/xlddNobyeCHModDlM55j6iD8nIvwxSVJRHMcq4Oj+A6vR/OV6rWDL0POQjW7GtMBEql0D+N8kWNnmils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=uUye5p/a; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uKNeT-006kZW-Ks; Wed, 28 May 2025 22:45:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=kt9Uha7VD+eiIDEH9tVhjecT5DUzFtvpEIk/Ba7ATHs=; b=uUye5p/aEBLuHBfsRbzABNBl0p
	OvYdaFj2+DUxkplVQYSxQItd2DBYMAVWH1gmdOrO+AT54t1hW6so8tPudkwSCC0exyx12aPd3Mf4O
	XainsQxJZsHbahNFl/2sZ9rQl2e0hBQ1UO1Pd/hLS/fFx1R8GHorQ1sDp+XlCmv/ASkuqsI/p4x5o
	57R96zGXzv/z63dyfbL82N2yvzyk7ywyGfxSrvcw8gDUz9eYzWgTethQZRW0f1IVYMl5eSbU87oBy
	oFKEyJEdNjqt3SmA46Glve7d0drqKWjSJQC5rKXUhynntnieeaf+2moMhwND3jpEyWFyktavZfkFG
	BXvGNOiw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uKNeT-0005BX-2d; Wed, 28 May 2025 22:45:29 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uKNeB-00GEBu-75; Wed, 28 May 2025 22:45:11 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 28 May 2025 22:44:41 +0200
Subject: [PATCH RFC net-next v2 1/3] vsock/test: Introduce vsock_bind_try()
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-vsock-test-inc-cov-v2-1-8f655b40d57c@rbox.co>
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
In-Reply-To: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Create a socket and bind() it. If binding failed, gracefully return an
error code while preserving `errno`.

Base vsock_bind() on top of it.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/util.c | 24 +++++++++++++++++++++---
 tools/testing/vsock/util.h |  1 +
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 0c7e9cbcbc85cde9c8764fc3bb623cde2f6c77a6..b7b3fb2221c1682ecde58cf12e2f0b0ded1cff39 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -121,15 +121,17 @@ bool vsock_wait_sent(int fd)
 	return !ret;
 }
 
-/* Create socket <type>, bind to <cid, port> and return the file descriptor. */
-int vsock_bind(unsigned int cid, unsigned int port, int type)
+/* Create socket <type>, bind to <cid, port>.
+ * Return the file descriptor, or -1 on error.
+ */
+int vsock_bind_try(unsigned int cid, unsigned int port, int type)
 {
 	struct sockaddr_vm sa = {
 		.svm_family = AF_VSOCK,
 		.svm_cid = cid,
 		.svm_port = port,
 	};
-	int fd;
+	int fd, saved_errno;
 
 	fd = socket(AF_VSOCK, type, 0);
 	if (fd < 0) {
@@ -138,6 +140,22 @@ int vsock_bind(unsigned int cid, unsigned int port, int type)
 	}
 
 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa))) {
+		saved_errno = errno;
+		close(fd);
+		errno = saved_errno;
+		fd = -1;
+	}
+
+	return fd;
+}
+
+/* Create socket <type>, bind to <cid, port> and return the file descriptor. */
+int vsock_bind(unsigned int cid, unsigned int port, int type)
+{
+	int fd;
+
+	fd = vsock_bind_try(cid, port, type);
+	if (fd < 0) {
 		perror("bind");
 		exit(EXIT_FAILURE);
 	}
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index 5e2db67072d5053804a9bb93934b625ea78bcd7a..0afe7cbae12e5194172c639ccfbeb8b81f7c25ac 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -44,6 +44,7 @@ int vsock_connect(unsigned int cid, unsigned int port, int type);
 int vsock_accept(unsigned int cid, unsigned int port,
 		 struct sockaddr_vm *clientaddrp, int type);
 int vsock_stream_connect(unsigned int cid, unsigned int port);
+int vsock_bind_try(unsigned int cid, unsigned int port, int type);
 int vsock_bind(unsigned int cid, unsigned int port, int type);
 int vsock_bind_connect(unsigned int cid, unsigned int port,
 		       unsigned int bind_port, int type);

-- 
2.49.0


