Return-Path: <netdev+bounces-153296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C8A9F78EE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1EA7A201B
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22DE223338;
	Thu, 19 Dec 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Lv2qifvw"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7AE222D67
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601793; cv=none; b=KcHhUgBJc8u4jt7IYydikk9WNLit8yH1ShW9HqUqNZzJXMapmRmyM3sfttIxptUrvnz2PNu9mSczTOj4wPcs5QOAAu+A6Xh8KU6lnsMsQw5JHTHBccdMiXmNGU/Q17nOZqpYs+oU1lpRwccL11QvYydr7qsRvRUaOMNeXa9iVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601793; c=relaxed/simple;
	bh=3eAePnfwqYNESTgHFOww/NPFPEG18gdAbQExjXxuUnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VtzYxakFpQLxBZjxvSgxfSOoV9Z5aX6x9AolU92CtvvITx+DXISEfh0Z2t5Z7eVoOov0C3YLWBfZ1yvbz/rSOCBtnWOQkeb8TGKPh8gjFX3cCc0395DYrC8VvIUf+VOU9ZWufu1eDmsPR/p3VJ/N1kwN7WkM3de0hG30/sPMO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Lv2qifvw; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tODAD-007NpV-KL; Thu, 19 Dec 2024 10:49:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=qJ6rfp97mx5WloVWAm7EujuRtbreW2+NNaOhtKxXWNA=; b=Lv2qifvwBWOyVJcEG2E0yva0gi
	7t6IxdQsurkYJeoGK75GA99OJeGf4kG3TUtkttUtl/mEs/bN0lualdUR1jNDQ+bm3+EzqGeVWZ0qB
	0xQXIiAK7hi5h1Rzs+mHpkfhpAFjCZrMCx76HghsFZNLdmmYrslFOAMaJ0lvPrSWtwBQL6/JjYtoH
	Nv22DNld9BOddXWGTec5kwIl4lE55VWRbSXsNGASTlXhlJcokybh6h9pA0ZfTfFnCWDeOPPL0h4Dk
	giKpfzKHZ15cPjQ2BMMMMft6sr6bOpaEq+BGF6DQoPgffHrp8VnV7uoEHEFzbOdC5uZPBv5pTsj0a
	glSNwWqA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tODAD-0004rI-BB; Thu, 19 Dec 2024 10:49:49 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tODA5-00BSZD-0Y; Thu, 19 Dec 2024 10:49:41 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 19 Dec 2024 10:49:34 +0100
Subject: [PATCH net-next v4 7/7] vsock/test: Add test for MSG_ZEROCOPY
 completion memory leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-test-vsock-leaks-v4-7-a416e554d9d7@rbox.co>
References: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
In-Reply-To: <20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Exercise the ENOMEM error path by attempting to hit net.core.optmem_max
limit on send().

Test aims to create a memory leak, kmemleak should be employed.

Fixed by commit 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error
handling").

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 152 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 2dec6290b075fb5f7be3a24a4d1372a980389c6a..1eebbc0d5f616bb1afab3ec3f9e59cb609f9f6e8 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1561,6 +1561,153 @@ static void test_stream_msgzcopy_leak_errq_server(const struct test_opts *opts)
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
+ *           control_writeulong(CONTROL_CONTINUE);
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
+ *       control_writeulong(CONTROL_DONE);
+ *       close(f);
+ *   }
+ *
+ *   void server(const struct test_opts *opts)
+ *   {
+ *       int fd;
+ *
+ *       while (control_readulong() == CONTROL_CONTINUE) {
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
@@ -1701,6 +1848,11 @@ static struct test_case test_cases[] = {
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


