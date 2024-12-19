Return-Path: <netdev+bounces-153297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE739F78EB
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5786F189426D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E101B2236EB;
	Thu, 19 Dec 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZTzzPEfn"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666E3222D7C
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601794; cv=none; b=W24sM79xyLG8Adf+4tGu+ooKlXRnWy0/qLZDWZsF9sF4EV84fFSgQJe3grMqR6lfn3cn7+T3RQTSb6sw/pAGUoqFpcxNLOdux2AvENsfy7fi+l56b3Qq/2WiG4WwBgtbrEuS6VHLzHEJPSjLYB2WBLhcuK7g8cKHJWBvSruVch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601794; c=relaxed/simple;
	bh=BpvmSZWkD+Q+VUfAd1c+g3ZJbsXbGCqS0jhubPooj4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SSzf5mPITmtvuSOJw3zptDcWJG6T36/vuK2wr4irc2AXOzaG88PbMVEKeXbkvIma1dSX3sWmRLG1Fb56aqhYnsashVZfjL1mO3xKosQIJBzRf9EFwJJZ7LvgNoT+u/PI7zr0lkPWAnFyc+e6N4vB4F+t7C9uZv7l+09CvjNwG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZTzzPEfn; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tODAE-007Npg-Q7; Thu, 19 Dec 2024 10:49:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=nXFlu9XM2xn6Pj98XqVxoZT90d1Orm7mGxwWyBbI/bc=; b=ZTzzPEfnzwwpquzIy4RGChmDN6
	mSWFA+ZjGID+CVdd0qSF9oMPCXf+MzqrzrGiROUQ9FpRAcsPukLKBFrBxLyeUuOxOGT894Izs7uhQ
	E45jMaU7pYWCpM4IYYy0DX1N+ALBPdoNrzpB7+7L0MaHGFm7xp7hWWOFPuCY12eBRCs0vfGKuFEVt
	8aJsBwXRWEIZsdotPtE7jB74ruIyswbkV7KrX6ZKRhx6EDXjTPIlwXHpNywmLY+SJNOwQzhcxFpKv
	fz7acU/EMnKHZfPNEQ0iJAe93q/DNMD2aymVoD4zGymus/hG9ZMF2YIoBokewkI9n5YGrBWjvtz3P
	P6y3U+yw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tODAE-0004rQ-E4; Thu, 19 Dec 2024 10:49:50 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tODA4-00BSZD-FZ; Thu, 19 Dec 2024 10:49:40 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 19 Dec 2024 10:49:32 +0100
Subject: [PATCH net-next v4 5/7] vsock/test: Add test for accept_queue
 memory leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-test-vsock-leaks-v4-5-a416e554d9d7@rbox.co>
References: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
In-Reply-To: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Attempt to enqueue a child after the queue was flushed, but before
SOCK_DONE flag has been set.

Test tries to produce a memory leak, kmemleak should be employed. Dealing
with a race condition, test by its very nature may lead to a false
negative.

Fixed by commit d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory
leak").

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 8bb2ab41c55f5c4d76e89903f80411915296c44e..2a8fcb062d9d207be988da5dd350e503ca20a143 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -29,6 +29,10 @@
 #include "control.h"
 #include "util.h"
 
+/* Basic messages for control_writeulong(), control_readulong() */
+#define CONTROL_CONTINUE	1
+#define CONTROL_DONE		0
+
 static void test_stream_connection_reset(const struct test_opts *opts)
 {
 	union {
@@ -1474,6 +1478,49 @@ static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
 	test_stream_credit_update_test(opts, false);
 }
 
+/* The goal of test leak_acceptq is to stress the race between connect() and
+ * close(listener). Implementation of client/server loops boils down to:
+ *
+ * client                server
+ * ------                ------
+ * write(CONTINUE)
+ *                       expect(CONTINUE)
+ *                       listen()
+ *                       write(LISTENING)
+ * expect(LISTENING)
+ * connect()             close()
+ */
+#define ACCEPTQ_LEAK_RACE_TIMEOUT 2 /* seconds */
+
+static void test_stream_leak_acceptq_client(const struct test_opts *opts)
+{
+	time_t tout;
+	int fd;
+
+	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
+	do {
+		control_writeulong(CONTROL_CONTINUE);
+
+		fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+		if (fd >= 0)
+			close(fd);
+	} while (current_nsec() < tout);
+
+	control_writeulong(CONTROL_DONE);
+}
+
+/* Test for a memory leak. User is expected to run kmemleak scan, see README. */
+static void test_stream_leak_acceptq_server(const struct test_opts *opts)
+{
+	int fd;
+
+	while (control_readulong() == CONTROL_CONTINUE) {
+		fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
+		control_writeln("LISTENING");
+		close(fd);
+	}
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1604,6 +1651,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_seqpacket_unsent_bytes_client,
 		.run_server = test_seqpacket_unsent_bytes_server,
 	},
+	{
+		.name = "SOCK_STREAM leak accept queue",
+		.run_client = test_stream_leak_acceptq_client,
+		.run_server = test_stream_leak_acceptq_server,
+	},
 	{},
 };
 

-- 
2.47.1


