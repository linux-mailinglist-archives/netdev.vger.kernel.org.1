Return-Path: <netdev+bounces-152179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D379F3003
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21111636E6
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7C3204F7D;
	Mon, 16 Dec 2024 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="LZdKZ6Nb"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C96020459B
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350495; cv=none; b=AaZ0P6pdiud6UkORu1b1Cn8lCS1p4Iow9f+v43wa39DUQODMp6n1zh0m0euascK4yDzfaV1Utth7+ftng5Q9uee43JBhqw6T3VlCj2JmSEHO9QYroyV2jDgo61hH+ozV+3Y7wIZ44KbbWvCe15CVRTM3Ep9I3BpvQf9cgO1sHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350495; c=relaxed/simple;
	bh=hHlxz5tcTxVSymicUkt6BnPtDZk/8eyiSEHFHGWiFyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYjYnMlRotV2jt9koH3kOuLs1gM0EYFC3DaLLEmjycH7JUBV1DV+ML3ILQF4vogW2SMFyoKVRbe+rAbgoNvYxl+FDjkYJU/6CJy0ngVA9/avQai/3X0GqaSRlddUKNF70x7QpqLWM0IDPX8PZ4VqSPTZsDhzzyheaVbkgjnX9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=LZdKZ6Nb; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tN9mv-00FyzA-AU; Mon, 16 Dec 2024 13:01:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=ROdtQyGWoAFSxMg+9fHW+SP0Xf6iFxkFcuSiCX7uNvU=; b=LZdKZ6NbvM9NXe+l1pLobHsAEr
	2PyU6FbKrJKnSxuDM1LE9IQQDpIb46D3uJQn2woxVXazFOLumoM7Xxfsgt/8FsggyP7La9m2VxEX3
	ZHupIm+HRnJONV7t9R7fakAWXoviv/ctonz4WRBOqths/IQeZtVlZlMS7ICXNDAPu3acbR/nBV5Ue
	fPOardbQXEm8djl5SCk8yIC108nDP+IRW93HkBpELpyhE30RVvdQ+CSdwJ3LZTgJlB5R7OeEHTYxe
	duccxhTD0Ct9OZlAIRj79m8U+/8m31ElplUcB0HkLkVyYp6IC9bFL6QkxHtbNOO/smf3t1SUj/4xX
	cPgCuhQg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tN9mu-0007oj-VM; Mon, 16 Dec 2024 13:01:25 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tN9mk-00DDDe-Gr; Mon, 16 Dec 2024 13:01:14 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 16 Dec 2024 13:01:01 +0100
Subject: [PATCH net-next v2 5/6] vsock/test: Add test for sk_error_queue
 memory leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-test-vsock-leaks-v2-5-55e1405742fc@rbox.co>
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
In-Reply-To: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Ask for MSG_ZEROCOPY completion notification, but do not recv() it.
Test attempts to create a memory leak, kmemleak should be employed.

Fixed by commit fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 1a9bd81758675a0f2b9b6b0ad9271c45f89a4860..d2970198967e3a2d02ac461921b946e3b0498837 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1520,6 +1520,46 @@ static void test_stream_leak_acceptq_server(const struct test_opts *opts)
 	}
 }
 
+/* Test for a memory leak. User is expected to run kmemleak scan, see README. */
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
@@ -1655,6 +1695,11 @@ static struct test_case test_cases[] = {
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


