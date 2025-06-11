Return-Path: <netdev+bounces-196693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD2CAD5F94
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FD716E6D1
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 19:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86928853E;
	Wed, 11 Jun 2025 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Ej6iqr6w"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3592BDC03;
	Wed, 11 Jun 2025 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671850; cv=none; b=XxPOwVvUL6sWQS5Egbn6K44V7joCiKWytT15bgr/0MTd1ykLV6169dLr10lVfHgBQMa9+cQ/+pqHSNYaRVQ2XO8QOlPNa0TpYg9kHxoqghhhNDLija9RWYJsq98edWEQReIEgi5qDduCeGV2HUDpWOj7yl0vIuyXELhyWlPGRDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671850; c=relaxed/simple;
	bh=eeQeEYKaHhYr+Maa1kLsJ5dq174xCMqjaPKqjE8uStE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+M9CuqYrAs3iitF7wqGyVIl6q+spHKWdFp58QrfQ6sn2Hyhfxoe3qtg1fWxo7WSLGhBM6uUf1ccgW2D/z9jt9Wpu6HWKayT4xB9n6K+ShJX8AKY3Q8eMqw/L17vgLmMfJsfvp0nuaUSwSXZXlfI5f9BRoxXYAeLJI+24/cltCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Ej6iqr6w; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uPRZX-00BIDf-5o; Wed, 11 Jun 2025 21:57:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=a5J8eYpVuE7o2VJSMjWSJdlZvj2jMI+mcwHoJe+gsJc=; b=Ej6iqr6w0DXcnV/u6mIfzp/bYV
	WAtWU9WTzRV3+x0wEEuW/bHoqyPLrIy5YEzS1OTkrpM+TPGPJE/nk4IbtUVM8VCmV2FDcEwAqYoag
	JLmTkiUmpyuHABMnfz3U/1fn8LrFgVF4dzWtPaualNEIC99dCLuDFvyVC7sIEDPid1aygZGcCwUF2
	9vISyA9lWzkfq73DElyNxY3TBReJ+eRjtdW18yx2gFeDDieeK53TPlQ3l6GAS2vmJW1kPeaxn12Ez
	8JibnISN1VLXl0fmkzXmBoK50JlpOxZ392wOYndyWWfIMquoxuKHFrhBbl4+91QEZSZ3KEGszlIDi
	BISpl6sw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uPRZW-0005E8-R3; Wed, 11 Jun 2025 21:57:19 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uPRZH-00BycS-BQ; Wed, 11 Jun 2025 21:57:03 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 11 Jun 2025 21:56:50 +0200
Subject: [PATCH net-next v3 1/3] vsock/test: Introduce vsock_bind_try()
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-vsock-test-inc-cov-v3-1-5834060d9c20@rbox.co>
References: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
In-Reply-To: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Create a socket and bind() it. If binding failed, gracefully return an
error code while preserving `errno`.

Base vsock_bind() on top of it.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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


