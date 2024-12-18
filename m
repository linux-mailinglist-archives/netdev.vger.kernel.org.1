Return-Path: <netdev+bounces-152989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595439F6890
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2F11893FE1
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052691DB363;
	Wed, 18 Dec 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="PMzG4BWy"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4D1B0417
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532393; cv=none; b=eocL5jSaZN4vUOf9o+N9ah+R+bDk2U6ZTP1A7Lz+nGEac+HGCysLgrN8fVJgC80BDzks5F/Wo5cYuHPlJ1csden2CtHDm3CyMrAQMc0OCLC6OzQms+MITkq+xwCxPn1X8YjGbu9+hXeS8GQMLBPGYInyRGGm55p0v5I5ebqfrLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532393; c=relaxed/simple;
	bh=OD040imbW2yV/0U8dRlyv9pGGxmj6Y+WphcRdZmXcus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBV+qRpFwitagpzTrJQkDrwsdniPE3ruzg6aGuURR+X/97sJpAM6zQsz1fBkCtTEVt4wnoveW7lMC1ZbX8PAcSXx2ikgLAMCp5q26MI1/tzzYC3vkcZtNmeyR83olip7hw0dyZwpJcv0t9ORCj8Fjd1YM1GWLrOIBakWHd9/Zgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=PMzG4BWy; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tNv6r-004ceB-1P; Wed, 18 Dec 2024 15:33:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=DJg1AzGG5wTXwMVaemQbEGXpC8TQCp81zUdC7bdHEvQ=; b=PMzG4BWyfIgNI76/GyompC8VU2
	Mb1BSlh0S7IEUCt90ocuf9d2osmBXyCNDg3Om7KLJiXasZYDlly9snTA60b4xvaEU6UK9Tpgno8m0
	AiPlbvivx7konHgT8ZSfEe3xOgITUepNNFbij278T7JsKBbZ3yJ/6XCKhB6Yte208KzSYSj1foWfu
	WmTBJKk4k6FqmbSLow0hcqKaN+FFlbQLm8GGJXib5fJ2MYKUXlQhtOMP3YJtv7EttRcT7H+yxMQNf
	fpH/3ozREkA3s/ifULJ9rXXZ3IqoWJHLtJj/zBJTR0lyK+VTtFaBdwSNcii0F0AyCTQeF9EnqN3o5
	8aL8xSVA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tNv6q-0000Qt-Ob; Wed, 18 Dec 2024 15:33:08 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tNv6W-008Env-B0; Wed, 18 Dec 2024 15:32:48 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 18 Dec 2024 15:32:39 +0100
Subject: [PATCH net-next v3 6/7] vsock/test: Add test for sk_error_queue
 memory leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-test-vsock-leaks-v3-6-f1a4dcef9228@rbox.co>
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
In-Reply-To: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Ask for MSG_ZEROCOPY completion notification, but do not recv() it.
Test attempts to create a memory leak, kmemleak should be employed.

Fixed by commit fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak").

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 2a8fcb062d9d207be988da5dd350e503ca20a143..2dec6290b075fb5f7be3a24a4d1372a980389c6a 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1521,6 +1521,46 @@ static void test_stream_leak_acceptq_server(const struct test_opts *opts)
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
@@ -1656,6 +1696,11 @@ static struct test_case test_cases[] = {
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


