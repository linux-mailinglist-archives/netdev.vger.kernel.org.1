Return-Path: <netdev+bounces-152990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F106C9F688D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEA116D22B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3901DDC3C;
	Wed, 18 Dec 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="G0oUl7Mf"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0102F1D5CD1
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532394; cv=none; b=GiwIXnQZOJ6OGRfs3wCeZJ3+wGXiKJbl6u8GyOAVwP3e3hg1jhZTlnEmWBj41ojDbZIAYmtN0U/qm+ENmsBZJT5ozKd0LJAhTCZBmZODy35ISIxpkKP4i9LKGxib4JtIfaRN8dbqvzQq9lyX8RzcDrsjFkXOX9NLN56XBn7RhSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532394; c=relaxed/simple;
	bh=pCqB20bYEiilLuVE+ZIBxM0CmvJ7c9PgUBKKAOPJjY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2e40gcbhR702LXfnotN6CfAgiXXQOipXeJm5mVxZ1llE+qrApQSCt8ZtG2QcuwOk932tes5O2eu1prh2r2FdlVjYb2720DWkhnCh+/UOuD+lREN9KYTFN4zF+fN/VLZHQrOeD9Yfph7bIp5v7fr5A9e8MX90RKtkmpbjLLxBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=G0oUl7Mf; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tNv6s-004s1a-0D; Wed, 18 Dec 2024 15:33:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=NyKPYuYH7uL/k8hmW6w2GWsiUjuTi7eCrx3uElVJKnI=; b=G0oUl7MfRux+6HPPLHGEN6nqHq
	TQFyq+4DzL1uomtXgxt3r5gIY0poMT+DphAmFgUZB610IzpNTBMjLdGX5vZD2KZTV5iJDOaYYlhX/
	Sq5noLozO8+jcXPEO98IRY1jDVLEs91x66DjnJI//g8hL3BweoPtM9jz69wMI+D1+o1BEk/H9WhmP
	q0SqHLRzxKDKTTvNDIg2Wn46l2uNEmdm14b1QaHj4kgMuQRkBU8bFlDP1FWBmAonj3XqTanmXcGPU
	9jBsRrYUr2sYjdxNTHi04+AmMzb0y5+fpOCvFKs25aNMX5S0Ra6aDlZH6+tfnZ9WK4hL/AZloxHo/
	OhL55RSQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tNv6r-00071A-N4; Wed, 18 Dec 2024 15:33:09 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tNv6W-008Env-2l; Wed, 18 Dec 2024 15:32:48 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 18 Dec 2024 15:32:38 +0100
Subject: [PATCH net-next v3 5/7] vsock/test: Add test for accept_queue
 memory leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-test-vsock-leaks-v3-5-f1a4dcef9228@rbox.co>
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
In-Reply-To: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
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


