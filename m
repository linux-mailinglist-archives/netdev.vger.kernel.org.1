Return-Path: <netdev+bounces-149790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA6C9E782B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8808E167E84
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E388C1D515D;
	Fri,  6 Dec 2024 18:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="X400tChL"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061241D54F2
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510165; cv=none; b=nmFa0YAepM0+eLuCQwM8RKkV75JB6SP7OZUqVzwid7ff1MIHbdLyfl1Z2cbgdsILnw4sZ4iHfF6XzKdTf610i//XGLe65u7xEY/29uBT1wxKxjuk/05ddwTPb4W7Ln89haoNxXdTDh9guPgRmsbTfIXf+ALlrhpnDksErIJ36BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510165; c=relaxed/simple;
	bh=wsKp3uqS8Ov1CEyMnU9L9U+kSqSydHz+G/75QJSgRV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nw5iYzApkRE+aMXgL70Tb49LwU760Pt9+t8IuwyVLjf1673sgVqMNjIwvhT+jB5XckcxjyBZhnpxDo9Spy24x5K6ahpmLF3uQZCKqf7sRmuEL1K1Dq6zwkVj3YB6bjYbNo9rr3gyrMOi5cYcRzBOpmFaOKs5xUjASIhVNCW/OP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=X400tChL; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tJdBC-004Ore-9k
	for netdev@vger.kernel.org; Fri, 06 Dec 2024 19:35:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=AxjTr2jFb+ZBM6cEB1PXWVwtMF0jyXQNRIDwRMMyA4I=; b=X400tChLX418sfLggKzceGBnoJ
	vLDQBEL6LwdswPRAEDFcn8iuVb2YUAwBIN4L/ToYlLTbyATgolUQmh8JZiguQBiJ2WFbCmg4yf2Je
	BWZbSNrGV80+3mI8WPNs7c3D9zKZfl2+/eBturRxpLeLIro2X5JRrHocnXdgK8YbaUCGTo9EaKcfn
	qMW1Tzs1jcLUF7wAV5djE3Zvgu9s9mQ1uzKrXCbNC41BME830ODInAOifRP1+EAjajJ6MiJcc8Gcq
	LVMthVzZ8qWH8QbZtMzM34/uG3BcrWl+VcTrsSmww2/EMZa3PMYhCKfW4ujQjVPFucCqvPB27rByD
	o+g+S5eg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tJdBB-00074O-Vb; Fri, 06 Dec 2024 19:35:54 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tJdAp-007yMC-BS; Fri, 06 Dec 2024 19:35:31 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 06 Dec 2024 19:34:53 +0100
Subject: [PATCH net-next 3/4] vsock/test: Add test for sk_error_queue
 memory leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-test-vsock-leaks-v1-3-c31e8c875797@rbox.co>
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
In-Reply-To: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Ask for MSG_ZEROCOPY completion notification, but never actually recv() it.

Fixed by commit fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 48b6d970bcfa95f957facb7ba2e729a32d256b4a..f92c62b25a25d35ae63a77a0122a194051719169 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1513,6 +1513,45 @@ static void test_stream_leak_acceptq_server(const struct test_opts *opts)
 	}
 }
 
+static void test_stream_msgzcopy_leak_errq_client(const struct test_opts *opts)
+{
+	struct pollfd fds = { 0 };
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	enable_so_zerocopy_check(fd);
+	send_byte(fd, 1, MSG_ZEROCOPY);
+
+	fds.fd = fd;
+	fds.events = 0;
+	if (poll(&fds, 1, -1) < 0) {
+		perror("poll");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
+static void test_stream_msgzcopy_leak_errq_server(const struct test_opts *opts)
+{
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	recv_byte(fd, 1, 0);
+	vsock_wait_remote_close(fd);
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1648,6 +1687,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_leak_acceptq_client,
 		.run_server = test_stream_leak_acceptq_server,
 	},
+	{
+		.name = "SOCK_STREAM MSG_ZEROCOPY leak MSG_ERRQUEUE",
+		.run_client = test_stream_msgzcopy_leak_errq_client,
+		.run_server = test_stream_msgzcopy_leak_errq_server,
+	},
 	{},
 };
 

-- 
2.47.1


