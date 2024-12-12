Return-Path: <netdev+bounces-151485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05599EFAE0
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE7B28923D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00161C5F07;
	Thu, 12 Dec 2024 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="PveC/+yQ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89829A9
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028038; cv=none; b=kHd4nO+Q5doCIuSwMKOhBi90xLlwyAr1q1xS9Nz/XF9SXmU5Lh5Ghz1JeseKxIOEheI0RS9WMUejlh1dRSpv68REhBF3IgTSJXjMfrUUaXJEF2kOO0sv0ff8lOl+X0/FZdbXWjwjN9jRp7hTTsNXju8LJewXOb3Giuzt3jlV8Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028038; c=relaxed/simple;
	bh=FnG+J/Wp62bxX3ldd6BC5tuPafZFRhP9HzSguDHNW54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbnflNqFd5U86zzvNLcBfqztDJvACEGxLJ+JrCDIiM3wJksxwGaS4Nvxp9qdCdfkAy3L9XkdVi9wsXUfRTQa6W0kWjMxdUk5paPaKSQQoQUVVuY3cLjRn9rFSyD1CFnT3vuCEt8GlIXj0TaOClswhyw6qVbJcFP+o8d5LuYJpQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=PveC/+yQ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tLntu-004pVy-G4; Thu, 12 Dec 2024 19:27:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=1IFzJZrnfUazJ2S/JyZtUkGO7B8rMbL+F7XzMidZm5I=; b=PveC/+yQxMhTPr20dOUBCigXnE
	wzqJS5WZzWfx+FGqIGLd1e8UOmnB1htCGeT3sCu7VzHyo1kCvxFBPFoFBLGNd+QZ3jIkCIdRKY6WO
	SUWRgYY509kcj7i43ApYUCwENHZwk6ARUa3G+VJof7rgOSlkBuP0bTDTpexCxBuqojvEsMGgH1DWL
	ii8LYPzUZc6npyuOS9HBRJXSvlt9p5GD70/vdPRP9QVdotFrT+YP0uhFxtMwlt3TdTxq19CfZGC1Y
	25PxnoGJTi1SY9qmA73TCiOfpo+0Oxz+16VesptRhUeaF9PG25yM49dp3Z7/4pjK1u+nHU6B1EOtZ
	tKRUsItA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tLntt-0006V8-JZ; Thu, 12 Dec 2024 19:27:01 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tLntY-008dGs-Qu; Thu, 12 Dec 2024 19:26:40 +0100
Message-ID: <aecfafb8-f556-4d7e-941d-2975f3f30396@rbox.co>
Date: Thu, 12 Dec 2024 19:26:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] vsock/test: Add test for MSG_ZEROCOPY
 completion memory leak
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <20241206-test-vsock-leaks-v1-4-c31e8c875797@rbox.co>
 <oipmjpvmvbksopq6ugfmad2bd6k6mkj34q3jef5fvz72f3xfow@ve7lrp5gx37c>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <oipmjpvmvbksopq6ugfmad2bd6k6mkj34q3jef5fvz72f3xfow@ve7lrp5gx37c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 16:36, Stefano Garzarella wrote:
> On Fri, Dec 06, 2024 at 07:34:54PM +0100, Michal Luczaj wrote:
>> [...]
>> +static void test_stream_msgzcopy_leak_zcskb_client(const struct test_opts *opts)
>> +{
>> +	char buf[1024] = { 0 };
>> +	ssize_t optmem_max;
>> +	int fd, res;
>> +	FILE *f;
>> +
>> +	f = fopen("/proc/sys/net/core/optmem_max", "r");
>> +	if (!f) {
>> +		perror("fopen(optmem_max)");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	if (fscanf(f, "%zd", &optmem_max) != 1 || optmem_max > ~0U / 2) {
>> +		fprintf(stderr, "fscanf(optmem_max) failed\n");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	fclose(f);
>> +
>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>> +	if (fd < 0) {
>> +		perror("connect");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	enable_so_zerocopy_check(fd);
>> +
>> +	/* The idea is to fail virtio_transport_init_zcopy_skb() by hitting
>> +	 * core.sysctl_optmem_max (sysctl net.core.optmem_max) limit check in
>> +	 * sock_omalloc().
>> +	 */
>> +	optmem_max *= 2;
>> +	errno = 0;
>> +	do {
>> +		res = send(fd, buf, sizeof(buf), MSG_ZEROCOPY);
>> +		optmem_max -= res;
>> +	} while (res > 0 && optmem_max > 0);
>> +
>> +	if (errno != ENOMEM) {
>> +		fprintf(stderr, "expected ENOMEM on send()\n");
> 
> This test is failing in my suite with this message (I added errno
> in the message that maybe we can add to understand better what we
> expect, and what we saw) [...]

Thanks, can reproduce. And I'm surprised it ever worked at all. What I did
is completely and utterly wrong :)

The idea was to exhaust sk_omem_alloc by growing some skbs. First thing
I've missed: no matter the size of the buffer being send(), sock_omalloc()
is always requested with size=0[*]. Sure, skb->truesize is non-zero, so it
does bump the counter, but it won't work as intended.

Then comes vhost transport: sk_omem_alloc won't stay incremented, because
skbs are processed and consumed. That's a race between transport and us.

So here's another desperate attempt to do it without elevated privileges:
exhaust sk_omem_alloc by abusing sendmsg()'s `sock_kmalloc(sock->sk,
ctl_len, GFP_KERNEL)`. Code below, tested under what I hope resembles your
nested setup, i.e.

L1$ --mode=server --peer-cid=4
L2$ --mode=client --peer-cid=2

L1$ --mode=client --peer-cid=4
L2$ --mode=server --peer-cid=2

Please let me know if it works for you.

That said, I really think this test should be scrapped. I'm afraid it will
break sooner or later. And since kmemleak needs root anyway, perhaps it's
better to use failslab fault injection for this?

[*] It's the only caller. Should @size be dropped from sock_omalloc()?

Sorry for the mess,
Michal

From 52cd25e49649f853e75ef82c90ff360ee0a54a50 Mon Sep 17 00:00:00 2001
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 4 Dec 2024 02:38:16 +0100
Subject: [PATCH] vsock/test: Add test for MSG_ZEROCOPY completion memory leak

Exercise the ENOMEM error path by attempting to hit net.core.optmem_max
limit on send().

Fixed by commit 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error
handling").

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 82 ++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 0a930803227a..d64e681f2904 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1552,6 +1552,83 @@ static void test_stream_msgzcopy_leak_errq_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void test_stream_msgzcopy_leak_zcskb_client(const struct test_opts *opts)
+{
+	size_t optmem_max, chunk_size;
+	struct msghdr msg = { 0 };
+	struct iovec iov = { 0 };
+	char *chunk, buf = 'x';
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
+	/* The idea is to fail virtio_transport_init_zcopy_skb() by hitting
+	 * core.sysctl_optmem_max (sysctl net.core.optmem_max) limit check in
+	 * sock_omalloc(sk, 0, GFP_KERNEL). Stuff sk->sk_omem_alloc with cmsg,
+	 * see net/socket.c:____sys_sendmsg().
+	 */
+
+	chunk_size = CMSG_SPACE(optmem_max - 1);
+	chunk = malloc(chunk_size);
+	if (!chunk) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+	memset(chunk, 0, chunk_size);
+
+	iov.iov_base = &buf;
+	iov.iov_len = 1;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = chunk;
+	msg.msg_controllen = optmem_max - 1;
+
+	errno = 0;
+	res = sendmsg(fd, &msg, MSG_ZEROCOPY);
+	if (res >= 0 || errno != ENOMEM) {
+		fprintf(stderr, "expected ENOMEM, got errno=%d res=%d\n",
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
@@ -1692,6 +1769,11 @@ static struct test_case test_cases[] = {
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



