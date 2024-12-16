Return-Path: <netdev+bounces-152175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 834AE9F2FFB
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148E11884FC1
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9B9204C00;
	Mon, 16 Dec 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="BJpsTkeX"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF3204680
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350487; cv=none; b=ez9eQrSmkRDgNDu1GW6CooRnmjM8iQW8k2VP1TMb2SwqV1CUkB7k/Pz3paXTACSDICjaNPi9fKKXUf5BAKPMUcQC0cWeEIXG9l8L6fajPtK40qj3n86faEArA0fyIj+lcoP6DB5brOntmdy1QI9AS8mXMZt8rfh2vDQfTup+2R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350487; c=relaxed/simple;
	bh=XfomszMmFIq6Y1tK8xdav/BMWjlKeVakOfSpjd7HEMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nbrd/FXB6EvafLd121c5wVR3TsJLi/kM3A6KP68kjadrO2XuQZXsN8S1Ku/5uwKta5bYfaaulFhLk7OnFxxgW/AskQ3h8yDTDlPPY6ayagqkOH51KLA/83eO7zSKqlFrKT86dmDQhP5iClr/1ih08HtJvk1mXu574dkIsM2lM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=BJpsTkeX; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tN9mt-00FlkN-3k; Mon, 16 Dec 2024 13:01:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=QjMJ9KU1Zu7fsKIXFX6pPbLiygSOfaJ1WiQH0I2fNxY=; b=BJpsTkeXj/Z1puWRYtHeR0E2RL
	vHTDmnfBcErFzp24nrwjaXAAn10SSXSyqS76YAwdr54FqDq4M1okxy7w/vn2k+nLT8sGb267s+wNR
	3fBBOnelNdwsUwlR16kmAmgbLH0bicaeFjnB8Q6tLru1itoqXx08QkyG04Vn3Ux01R5Pd0ctfrmC4
	C87jlRwYZOoC1PogiqbnEzKZncEuCedCKoPlOeJ7C7hb6ZXnVTmfRum39W4IqyD66uW4yrhfwC8eA
	uaYuZFWATafTD6rqWyJQsYgI6ZklcZKrJSqmLA1/nna2Vz4udvU++WWGDUYRhTakH5uszrxMwlsQ2
	oPFom8hQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tN9ms-0007oY-O0; Mon, 16 Dec 2024 13:01:22 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tN9mk-00DDDe-PE; Mon, 16 Dec 2024 13:01:14 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 16 Dec 2024 13:01:02 +0100
Subject: [PATCH net-next v2 6/6] vsock/test: Add test for MSG_ZEROCOPY
 completion memory leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-test-vsock-leaks-v2-6-55e1405742fc@rbox.co>
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
In-Reply-To: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Exercise the ENOMEM error path by attempting to hit net.core.optmem_max
limit on send().

Test aims to create a memory leak, kmemleak should be employed.

Fixed by commit 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error
handling").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 152 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d2970198967e3a2d02ac461921b946e3b0498837..8f145b6db77d904f3f888ec8fbe76298e7dd91de 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1560,6 +1560,153 @@ static void test_stream_msgzcopy_leak_errq_server(const struct test_opts *opts)
 	close(fd);
 }
 
+/* Test msgzcopy_leak_zcskb is meant to exercise sendmsg() error handling path,
+ * that might leak an skb. The idea is to fail virtio_transport_init_zcopy_skb()
+ * by hitting net.core.optmem_max limit in sock_omalloc(), specifically
+ *
+ *   vsock_connectible_sendmsg
+ *     virtio_transport_stream_enqueue
+ *       virtio_transport_send_pkt_info
+ *         virtio_transport_init_zcopy_skb
+ *         . msg_zerocopy_realloc
+ *         .   msg_zerocopy_alloc
+ *         .     sock_omalloc
+ *         .       sk_omem_alloc + size > sysctl_optmem_max
+ *         return -ENOMEM
+ *
+ * We abuse the implementation detail of net/socket.c:____sys_sendmsg().
+ * sk_omem_alloc can be precisely bumped by sock_kmalloc(), as it is used to
+ * fetch user-provided control data.
+ *
+ * While this approach works for now, it relies on assumptions regarding the
+ * implementation and configuration (for example, order of net.core.optmem_max
+ * can not exceed MAX_PAGE_ORDER), which may not hold in the future. A more
+ * resilient testing could be implemented by leveraging the Fault injection
+ * framework (CONFIG_FAULT_INJECTION), e.g.
+ *
+ *   client# echo N > /sys/kernel/debug/failslab/ignore-gfp-wait
+ *   client# echo 0 > /sys/kernel/debug/failslab/verbose
+ *
+ *   void client(const struct test_opts *opts)
+ *   {
+ *       char buf[16];
+ *       int f, s, i;
+ *
+ *       f = open("/proc/self/fail-nth", O_WRONLY);
+ *
+ *       for (i = 1; i < 32; i++) {
+ *           control_writeulong(CONTINUE);
+ *
+ *           s = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+ *           enable_so_zerocopy_check(s);
+ *
+ *           sprintf(buf, "%d", i);
+ *           write(f, buf, strlen(buf));
+ *
+ *           send(s, &(char){ 0 }, 1, MSG_ZEROCOPY);
+ *
+ *           write(f, "0", 1);
+ *           close(s);
+ *       }
+ *
+ *       control_writeulong(DONE);
+ *       close(f);
+ *   }
+ *
+ *   void server(const struct test_opts *opts)
+ *   {
+ *       int fd;
+ *
+ *       while (control_readulong() == CONTINUE) {
+ *           fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+ *           vsock_wait_remote_close(fd);
+ *           close(fd);
+ *       }
+ *   }
+ *
+ * Refer to Documentation/fault-injection/fault-injection.rst.
+ */
+#define MAX_PAGE_ORDER	10	/* usually */
+#define PAGE_SIZE	4096
+
+/* Test for a memory leak. User is expected to run kmemleak scan, see README. */
+static void test_stream_msgzcopy_leak_zcskb_client(const struct test_opts *opts)
+{
+	size_t optmem_max, ctl_len, chunk_size;
+	struct msghdr msg = { 0 };
+	struct iovec iov;
+	char *chunk;
+	int fd, res;
+	FILE *f;
+
+	f = fopen("/proc/sys/net/core/optmem_max", "r");
+	if (!f) {
+		perror("fopen(optmem_max)");
+		exit(EXIT_FAILURE);
+	}
+
+	if (fscanf(f, "%zu", &optmem_max) != 1) {
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
+	ctl_len = optmem_max - 1;
+	if (ctl_len > PAGE_SIZE << MAX_PAGE_ORDER) {
+		fprintf(stderr, "Try with net.core.optmem_max = 100000\n");
+		exit(EXIT_FAILURE);
+	}
+
+	chunk_size = CMSG_SPACE(ctl_len);
+	chunk = malloc(chunk_size);
+	if (!chunk) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+	memset(chunk, 0, chunk_size);
+
+	iov.iov_base = &(char){ 0 };
+	iov.iov_len = 1;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = chunk;
+	msg.msg_controllen = ctl_len;
+
+	errno = 0;
+	res = sendmsg(fd, &msg, MSG_ZEROCOPY);
+	if (res >= 0 || errno != ENOMEM) {
+		fprintf(stderr, "Expected ENOMEM, got errno=%d res=%d\n",
+			errno, res);
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
@@ -1700,6 +1847,11 @@ static struct test_case test_cases[] = {
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


