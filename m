Return-Path: <netdev+bounces-149789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C5C9E782A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80049188683A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8524C1D90A5;
	Fri,  6 Dec 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="hB8S72tR"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1B1D54E9
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510164; cv=none; b=gIG7q2G55au0+yoIYs7+h0ytCpayIgSOBF9h5t9NSR88anSubAWzacH4/W4+TyvGXXyZeQrsu89ovTrOfjCpoFrTKwny1sN1puASneNo+NEv4YFCNca8AKptrAJLINfYLMbrN+Ge+faljmPX3JLuZ9sbyCrCKx+ZICea0VLHy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510164; c=relaxed/simple;
	bh=GuL9IZPlB88bC5UnrYah42ffJjbrxS7VQAQy21IiOVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=djBNGdIu6fE+6789qSSzXXF07ZCZD5g+gUup5JOpC0nn+AYJn0dEs/4vBsiNaAbsJeV6iNuPDxwD/a32mClYw7Tga+ETwuMFoaPnNr/Ec2+Mycz1cRC9LK0ZnDUHaJC2XdNKaQkteSQbWyfFSA4yb4UHQO5cfhD4Qwtrw9rbWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=hB8S72tR; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tJdBB-004OrY-9q
	for netdev@vger.kernel.org; Fri, 06 Dec 2024 19:35:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=3GUQyC2fj9R1fHqov0PL6k7C483BiZ76h8xmnsnDFNA=; b=hB8S72tRDbS/qFPYGNy2yTKf3C
	7q8gbQwoT42rkQ9/Kh8O5WwnlfmdXXOF48ulT5tpOcQpXfXDA/BtXRaa1Y4Gb6aRSHDrEB1maMhpr
	dmhWPdLY7Lt+clSN7brnQyxOahr5Iom1tq6LsgNxH4r1zqCFampY9gLDsKDMtAXa10qfRWcrIypC2
	IVOWflQSOJpF5I5IqOK0OHjRKEHJTLKoUoF3O9+hFQBcEw40LF/NbJvfymd38esEd56aEpKEccNt3
	NhtdKn6zRI6o+daFeOyPqUAT27NUf+2LRiolnsRT6xrmBbaoTLRZD6EEL9s+vhA2XZLzjXAnIDr5B
	sJjVE8Iw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tJdBA-00074I-Tf; Fri, 06 Dec 2024 19:35:53 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tJdAp-007yMC-3S; Fri, 06 Dec 2024 19:35:31 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 06 Dec 2024 19:34:52 +0100
Subject: [PATCH net-next 2/4] vsock/test: Add test for accept_queue memory
 leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-test-vsock-leaks-v1-2-c31e8c875797@rbox.co>
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
In-Reply-To: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Attempt to enqueue a child after the queue was flushed, but before
SOCK_DONE flag has been set.

Fixed by commit d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory
leak").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 38fd8d96eb83ef1bd45728cfaac6adb3c1e07cfe..48b6d970bcfa95f957facb7ba2e729a32d256b4a 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1474,6 +1474,45 @@ static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
 	test_stream_credit_update_test(opts, false);
 }
 
+#define ACCEPTQ_LEAK_RACE_TIMEOUT 2 /* seconds */
+
+static void test_stream_leak_acceptq_client(const struct test_opts *opts)
+{
+	struct sockaddr_vm addr = {
+		.svm_family = AF_VSOCK,
+		.svm_port = opts->peer_port,
+		.svm_cid = opts->peer_cid
+	};
+	time_t tout;
+	int fd;
+
+	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
+	do {
+		control_writeulong(1);
+
+		fd = socket(AF_VSOCK, SOCK_STREAM, 0);
+		if (fd < 0) {
+			perror("socket");
+			exit(EXIT_FAILURE);
+		}
+
+		connect(fd, (struct sockaddr *)&addr, sizeof(addr));
+		close(fd);
+	} while (current_nsec() < tout);
+
+	control_writeulong(0);
+}
+
+static void test_stream_leak_acceptq_server(const struct test_opts *opts)
+{
+	int fd;
+
+	while (control_readulong()) {
+		fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
+		close(fd);
+	}
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1604,6 +1643,11 @@ static struct test_case test_cases[] = {
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


