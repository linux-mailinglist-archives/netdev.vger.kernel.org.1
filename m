Return-Path: <netdev+bounces-159466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB585A15943
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4A63A89D8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858CA1B4F0E;
	Fri, 17 Jan 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="qlqGfWX+"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC81ABEA8
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151222; cv=none; b=oigNwT/AEaK7XEHTkv2ivEVyhU72rLyjKRQYIt8gAlpEYOTnX0SIGQAUV/8LYKkXlBiA+g8FEs9M4DLmW4+MqI8d1qtNDDXnEDK203lUWTPDcMpDlw3SCp0+KzfE4DyR+aVgb0AggpO0+WcGfqQPS0tlj3FQcZzDWmtaeVX8uVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151222; c=relaxed/simple;
	bh=N1rpXhpDAxKvR72WGSUVuwZyQ7pLT66spvjJsOPYAP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYkc4bflitmBSL7RfLvnJmxNsvOcJlRA3J+pXiSGttf1mL9ShW89SIFgvhxmVvfPr/C8s2SeRdJZSzZSqWiEVTGwILhr37vn1wbQF4F3xrGY9cz58VyiV+AX73GDGHT+4ivUyLLSxUwuXTxH34m2CNpNeH0nnf3Whh0OQ80XwW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=qlqGfWX+; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tYuO0-008tnH-0I; Fri, 17 Jan 2025 23:00:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=f863rsH4oB2jDNyGTa+fje+52f5FupXXD3xN2+ozrh4=; b=qlqGfWX+0IZWElkglHGZYgfn+7
	lQOAgbEXMVdH8bsNxK/kpx+JpNyY7mfLoCCZrZid7CSAroX8g9rbHy5eN3YFncCGTrtG5sk3FDAd+
	gdoX9UKfZ+5ICgIQuWHHf2z6sHGBMi21HGAxLxuP1oA4f7qnBcBwVmD6CJYOORobcrq8UxOSfPrYF
	fTsRjJVCLMcglJ9rh7SmvoVltGZDgrMul8PQS2m+VksT8by2Yzue4Hk0yYpeZsmhHDw9ggC10ZPL+
	MbPM+lre8C/+IJ7fnZdjzD6N5BAS4W51gsUmuO8g+hZ4V8d3ZRsben6FX0qzP5cP5x5ylRpH1f9mX
	6VnKFI/Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tYuNz-0004tm-Dr; Fri, 17 Jan 2025 23:00:15 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tYuNm-006md8-5j; Fri, 17 Jan 2025 23:00:02 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 17 Jan 2025 22:59:45 +0100
Subject: [PATCH net 5/5] vsock/test: Add test for connect() retries
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-vsock-transport-vs-autobind-v1-5-c802c803762d@rbox.co>
References: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
In-Reply-To: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>, 
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Deliberately fail a connect() attempt; expect error. Then verify that
subsequent attempt (using the same socket) can still succeed, rather than
fail outright.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 7f1916e23858b5ba407c34742a05b7bd6cfdcc10..712650f993e9df68ceb68ae02334c2775be09c7c 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1520,6 +1520,53 @@ static void test_seqpacket_transport_uaf_server(const struct test_opts *opts)
 	control_expectln("DONE");
 }
 
+static void test_stream_connect_retry_client(const struct test_opts *opts)
+{
+	struct sockaddr_vm addr = {
+		.svm_family = AF_VSOCK,
+		.svm_cid = opts->peer_cid,
+		.svm_port = opts->peer_port
+	};
+	int s, alen = sizeof(addr);
+
+	s = socket(AF_VSOCK, SOCK_STREAM, 0);
+	if (s < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (!connect(s, (struct sockaddr *)&addr, alen)) {
+		fprintf(stderr, "Unexpected connect() #1 success\n");
+		exit(EXIT_FAILURE);
+	}
+
+	control_writeln("LISTEN");
+	control_expectln("LISTENING");
+
+	if (connect(s, (struct sockaddr *)&addr, alen)) {
+		perror("connect() #2");
+		exit(EXIT_FAILURE);
+	}
+
+	close(s);
+}
+
+static void test_stream_connect_retry_server(const struct test_opts *opts)
+{
+	int fd;
+
+	control_expectln("LISTEN");
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	vsock_wait_remote_close(fd);
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1655,6 +1702,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_seqpacket_transport_uaf_client,
 		.run_server = test_seqpacket_transport_uaf_server,
 	},
+	{
+		.name = "connectible retry failed connect()",
+		.run_client = test_stream_connect_retry_client,
+		.run_server = test_stream_connect_retry_server,
+	},
 	{},
 };
 

-- 
2.47.1


