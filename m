Return-Path: <netdev+bounces-152177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2999F3001
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBD61885810
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F20204C3A;
	Mon, 16 Dec 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="lWjjT3KJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACC520459B
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350489; cv=none; b=D18VX5q69sZBbt6fgXDzIlxmeeGstqKnbffbZmhtu5PIMu2ZalLbumayI5fnwGNCNsOoIIBhnqIU53W5fcRG49VXrK3MnNbdx48G2z3Yl0aVWkkEChgeUn9U4n2UpMf8Px5iBYSPXn8TGx6DGXvLF7kLnYurox0iukI/FqtlLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350489; c=relaxed/simple;
	bh=EuE4lelyyn7n3+gUDUX1NByVnx2UULvAQaelUrIN45k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QluuZPpW2ESk0StmBxJd+U4Ov0da9U8Ciwl2LAVthDmgiAu8zRXSraCVAfJFekLDz6rG17vEKiUilms1lg8VvG3o7ip7OAyTRSJSxA3diyEHwAZTVB+54fED77EsVz0rSN/IiNWnCClHK9GC9VkYNJeKnK/XmMYV9mDVwLHZVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=lWjjT3KJ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tN9mu-00FlkS-5j
	for netdev@vger.kernel.org; Mon, 16 Dec 2024 13:01:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=YTAXs4n5664u/8rAyj0Oqj4AYkyhAw2BsEW1I+mf/ak=; b=lWjjT3KJYdtwdi6+bAKnY9OTVK
	65dhMdVJtImf1ZrPvnQnTZ3qTs5oK3x7TqTReJuX6Keyw4ieX+kIyUeUiavtgElQP9AbACdm8uVCK
	6qG6np0J6OHo1IHb16tNvpA5mAn/eNcYG+TrmLXPRaOqSk0ChHSGaXMVGUTX2L/p4Ebtz+f0dP0U6
	sgDXRDe3u/oB//0H/yGLI7dw9TlFWICu250EpX2qZzMnJpSA85GscxOuhr07MA2pb49UmUWG3reTk
	qLinaMqxxEZ/+44UConE8mX1pnxmGPxPGkCo/OG1avBXNV14BAV/hJ2UIcbo74BbdlpMWBN7Dz9l8
	jfxmDjwg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tN9mt-0007od-Q3; Mon, 16 Dec 2024 13:01:23 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tN9mk-00DDDe-8o; Mon, 16 Dec 2024 13:01:14 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 16 Dec 2024 13:01:00 +0100
Subject: [PATCH net-next v2 4/6] vsock/test: Add test for accept_queue
 memory leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-test-vsock-leaks-v2-4-55e1405742fc@rbox.co>
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
In-Reply-To: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
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
 tools/testing/vsock/vsock_test.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 1ad1fbba10307c515e31816a2529befd547f7fd7..1a9bd81758675a0f2b9b6b0ad9271c45f89a4860 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1474,6 +1474,52 @@ static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
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
+#define CONTINUE	1
+#define DONE		0
+
+static void test_stream_leak_acceptq_client(const struct test_opts *opts)
+{
+	time_t tout;
+	int fd;
+
+	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
+	do {
+		control_writeulong(CONTINUE);
+
+		fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+		if (fd >= 0)
+			close(fd);
+	} while (current_nsec() < tout);
+
+	control_writeulong(DONE);
+}
+
+/* Test for a memory leak. User is expected to run kmemleak scan, see README. */
+static void test_stream_leak_acceptq_server(const struct test_opts *opts)
+{
+	int fd;
+
+	while (control_readulong() == CONTINUE) {
+		fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
+		control_writeln("LISTENING");
+		close(fd);
+	}
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1604,6 +1650,11 @@ static struct test_case test_cases[] = {
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


