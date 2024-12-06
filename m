Return-Path: <netdev+bounces-149788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E2F9E7829
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637B9283C39
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 18:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6541D63D0;
	Fri,  6 Dec 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="NhHAKFYI"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387E1D515D
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510164; cv=none; b=m3fmBdKk5tsc9Ex/N9ZZAGGA7eLPQJcy37ffQW96Y7myk9MC2AEYN+/UmjJKjjE6Y9xzAG9Dz19QAI3gguFQd2PQCxEAByz6/eulQ6ny1naNfigq+r4gev14ZZfG7oiVhMpz0dkNcOH+PUpulLTcarZYCGV5mx3mN0NeB34ZkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510164; c=relaxed/simple;
	bh=pEGUBin/LsorY0ZPDZld9BOJ/tu57s2EIBTk/O6y/Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S60+AFtQe8RndLviG9qKFtrV+zHU4kRlGZyBi+VXet4zdOu0MAnMAcZTVM+lLza6APfPzh+X0YtBGvFRga/lzqAjLEJsaeQN7LBsfGl51j4yOmN6na+3APyT3ak/cWZhO4FnYSYVsgmRTKIQIS9O7LyFoE9vVBThFIGKR9iunFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=NhHAKFYI; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tJdBA-004OrT-7K; Fri, 06 Dec 2024 19:35:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=nxh02L6aDFisPrlSN5GEXJNL2ZIK2xxyPJNshoQVDFQ=; b=NhHAKFYI2rMuyAM6C04H+8dEKV
	fR7vv+OgTioL7WgHbSLAdShb3KcW25TFDV1t4+pX8N0Ol7nx2url/so/+Bj0IKx+fD7jaLyvYOozA
	iRK1r/ThVcWJjs/oechFAB8qAKEbMwnQzN+CBeeyskB69jwY/RufZ6wL1LzXHpu/X1+fYZ5IvFIFQ
	y9uCGMBm0OdSGAgkBZ99eNVvkTTbvLkrWWowfTlp5h82we5VYYP3tA0O2EO0FX6crSt/PrKXgRicI
	bwD6mbvWKWfY/Rl90IYOd95YdKwhl1rEbV5ugT8Mj34ZXHPsZQzdNopAY40cZIZrnquvlCbomB26h
	zj9TtFoQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tJdB9-0008G2-Od; Fri, 06 Dec 2024 19:35:51 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tJdAp-007yMC-Jh; Fri, 06 Dec 2024 19:35:31 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 06 Dec 2024 19:34:54 +0100
Subject: [PATCH net-next 4/4] vsock/test: Add test for MSG_ZEROCOPY
 completion memory leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-test-vsock-leaks-v1-4-c31e8c875797@rbox.co>
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
In-Reply-To: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Exercise the ENOMEM error path by attempting to hit net.core.optmem_max
limit on send().

Fixed by commit 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error
handling").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 66 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index f92c62b25a25d35ae63a77a0122a194051719169..6973e681490b363e3b9cedcf195844ba56da6f1d 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1552,6 +1552,67 @@ static void test_stream_msgzcopy_leak_errq_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void test_stream_msgzcopy_leak_zcskb_client(const struct test_opts *opts)
+{
+	char buf[1024] = { 0 };
+	ssize_t optmem_max;
+	int fd, res;
+	FILE *f;
+
+	f = fopen("/proc/sys/net/core/optmem_max", "r");
+	if (!f) {
+		perror("fopen(optmem_max)");
+		exit(EXIT_FAILURE);
+	}
+
+	if (fscanf(f, "%zd", &optmem_max) != 1 || optmem_max > ~0U / 2) {
+		fprintf(stderr, "fscanf(optmem_max) failed\n");
+		exit(EXIT_FAILURE);
+	}
+
+	fclose(f);
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	enable_so_zerocopy_check(fd);
+
+	/* The idea is to fail virtio_transport_init_zcopy_skb() by hitting
+	 * core.sysctl_optmem_max (sysctl net.core.optmem_max) limit check in
+	 * sock_omalloc().
+	 */
+	optmem_max *= 2;
+	errno = 0;
+	do {
+		res = send(fd, buf, sizeof(buf), MSG_ZEROCOPY);
+		optmem_max -= res;
+	} while (res > 0 && optmem_max > 0);
+
+	if (errno != ENOMEM) {
+		fprintf(stderr, "expected ENOMEM on send()\n");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
+static void test_stream_msgzcopy_leak_zcskb_server(const struct test_opts *opts)
+{
+	int fd;
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
@@ -1692,6 +1753,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_msgzcopy_leak_errq_client,
 		.run_server = test_stream_msgzcopy_leak_errq_server,
 	},
+	{
+		.name = "SOCK_STREAM MSG_ZEROCOPY leak completion skb",
+		.run_client = test_stream_msgzcopy_leak_zcskb_client,
+		.run_server = test_stream_msgzcopy_leak_zcskb_server,
+	},
 	{},
 };
 

-- 
2.47.1


