Return-Path: <netdev+bounces-151803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5F69F0F2E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD93188544C
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB221E1023;
	Fri, 13 Dec 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCOnrVcf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3253BE
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100401; cv=none; b=gUQ3JTkFLNdvcMT8j+afGyGsYP9MmjYzAWEcQWkBdkDXuqu78FSt1YwExSJwutO5GasNDTG4/HgpWO+q+OmXopK2aAsXl6OFZMhi/IRLhwOq+Zp7x6uvep11/BULsjr0QlsdX5OOQpwLtXYNymDH58v7Z0BJwMjIOkiQsVtBDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100401; c=relaxed/simple;
	bh=8t3CqT4L+pyXu4gyBrayeggEEZzLfFfguXe4Vda2pNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llTP7Kpfu0U+nmDdkokmMtjE+k29a8lOQ9QKgs1I+mLGEn+Oq866pq+tDqvs8G1Sy7sV+IF0tW4JUDCW8ZjBmHMYXEAhpV9s5v/hgL+U6wuPkYEYIS2ZQP0BpCyZ/D5wkRN6CwVPdkVauDrfE0q7f2T9MdS9q3r8MRwiuoWjnPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCOnrVcf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734100397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KU2teLFVS6HRst07JcL6nOOBpry3Mn9bWwH8A0NyRPM=;
	b=MCOnrVcfG2HXf+rBfJfUBoMgYKQWapk383aGuDQXM2O9oNophgRixWBSXd2pAQf2KzLwoV
	qDnCmNGuhxoFpdFQ9Jk/jGoIv1tJwm2VBlETSB6B5AWOvxxndfblXmLA2sVm/Ti1i6/w5D
	Lkmc7fkLzfyp4ljHfa+7JZePTes6ET8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-ZR2JtSKKMre8cZg6OjG-FA-1; Fri, 13 Dec 2024 09:33:16 -0500
X-MC-Unique: ZR2JtSKKMre8cZg6OjG-FA-1
X-Mimecast-MFC-AGG-ID: ZR2JtSKKMre8cZg6OjG-FA
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d899291908so53540726d6.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 06:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100395; x=1734705195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU2teLFVS6HRst07JcL6nOOBpry3Mn9bWwH8A0NyRPM=;
        b=rY9HGGRsG5JKGvhs09q9gUiEiWgCSH/xZY/zztaMLiwQpNUvvTARduLvbrKcdh/C5x
         pJCIT7u43qC5oxMsv0YZn6J6NU+8Lf0zJMkNvYb+mQZWkXBM432sqD/Gi0i/4ZbDSVCb
         /9ExTOQUDrWfrnHNL+gSrMH1+ucfra7i0CzmY/0UHyz/X2H1Dk0fJeTctnzn8YpnV+yT
         O/mZBrBp+l6Ob/fL6CrPPzKMobTG2+3s3nmFxeTKCYFKmj6hgNnpwzMEGvatbjTpS9xE
         HSAF5Wal8H9eJZVnSnEoLJpYk8YltVTo+L6sbmmvy3DnUiG2U9yttbRIQad1uCBaG8X7
         oE3A==
X-Gm-Message-State: AOJu0YwENiee1+s5AzSKZIiApoC8ZSzi8m2TEyii2Uy4vliSbjxJnus+
	XniUDzoUIFXKtMK2tOWVQ9JNTu66+fNNlGIQtBcd0xdzZKAVKHZ2faW1Z6nCDiNvXP54U4+bkUJ
	TNDupOZxYfafmXgLgkRQB14lE2EwviZtAn1UU0UPOo2ZpOQ2EW6UyF7DMaxdygKln
X-Gm-Gg: ASbGncsxH1QlJfbxB6yQu4k9UUi3ikvpyxoxjKxrl4PaZyxLBvfshc+smSaAPup5IME
	uK0m0Uzk4gj90gCKkYjwtGSTRJSZJ4BTdwzAzUnTiQSsuQwRhl7ybZZfqwRZE4xpLMkFMX2rSWE
	KKf0ZsMsup70OEnOhBRHV8RLCA55H7tYGGLXLSEEaPV2aFXqa76+kZ05hYHBSIhMeqstmYrvNNb
	Vr4Lr9Kc6gMTvaKa5JegC+9h95Lrp2b3UKfdydX4ElJg77snyenbmNRabIpANtZfe0ybZbs40o1
	6AHC1hV44up71/a9OYXAIMAbe3nmwCRl
X-Received: by 2002:ad4:5767:0:b0:6d8:7db7:6d88 with SMTP id 6a1803df08f44-6dc8caa1257mr48520086d6.28.1734100395395;
        Fri, 13 Dec 2024 06:33:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXIqzh+7sKEvUd8JNKrcOzQTQFyJECn0IA+S6ZHOO8yTNhsr5NxPqHvbZPhdJzkjL2JxuBRw==
X-Received: by 2002:ad4:5767:0:b0:6d8:7db7:6d88 with SMTP id 6a1803df08f44-6dc8caa1257mr48519706d6.28.1734100394993;
        Fri, 13 Dec 2024 06:33:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8e0e8c1dfsm88841836d6.59.2024.12.13.06.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:33:14 -0800 (PST)
Date: Fri, 13 Dec 2024 15:33:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] vsock/test: Add test for MSG_ZEROCOPY
 completion memory leak
Message-ID: <z4b2cbflkvo6nqrcw4wx5usoisqkha4scszftfshceo5bkd3nj@34u53ajpaltf>
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <20241206-test-vsock-leaks-v1-4-c31e8c875797@rbox.co>
 <oipmjpvmvbksopq6ugfmad2bd6k6mkj34q3jef5fvz72f3xfow@ve7lrp5gx37c>
 <aecfafb8-f556-4d7e-941d-2975f3f30396@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aecfafb8-f556-4d7e-941d-2975f3f30396@rbox.co>

On Thu, Dec 12, 2024 at 07:26:39PM +0100, Michal Luczaj wrote:
>On 12/10/24 16:36, Stefano Garzarella wrote:
>> On Fri, Dec 06, 2024 at 07:34:54PM +0100, Michal Luczaj wrote:
>>> [...]
>>> +static void test_stream_msgzcopy_leak_zcskb_client(const struct test_opts *opts)
>>> +{
>>> +	char buf[1024] = { 0 };
>>> +	ssize_t optmem_max;
>>> +	int fd, res;
>>> +	FILE *f;
>>> +
>>> +	f = fopen("/proc/sys/net/core/optmem_max", "r");
>>> +	if (!f) {
>>> +		perror("fopen(optmem_max)");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>> +
>>> +	if (fscanf(f, "%zd", &optmem_max) != 1 || optmem_max > ~0U / 2) {
>>> +		fprintf(stderr, "fscanf(optmem_max) failed\n");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>> +
>>> +	fclose(f);
>>> +
>>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>> +	if (fd < 0) {
>>> +		perror("connect");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>> +
>>> +	enable_so_zerocopy_check(fd);
>>> +
>>> +	/* The idea is to fail virtio_transport_init_zcopy_skb() by hitting
>>> +	 * core.sysctl_optmem_max (sysctl net.core.optmem_max) limit check in
>>> +	 * sock_omalloc().
>>> +	 */
>>> +	optmem_max *= 2;
>>> +	errno = 0;
>>> +	do {
>>> +		res = send(fd, buf, sizeof(buf), MSG_ZEROCOPY);
>>> +		optmem_max -= res;
>>> +	} while (res > 0 && optmem_max > 0);
>>> +
>>> +	if (errno != ENOMEM) {
>>> +		fprintf(stderr, "expected ENOMEM on send()\n");
>>
>> This test is failing in my suite with this message (I added errno
>> in the message that maybe we can add to understand better what we
>> expect, and what we saw) [...]
>
>Thanks, can reproduce. And I'm surprised it ever worked at all. What I did
>is completely and utterly wrong :)
>
>The idea was to exhaust sk_omem_alloc by growing some skbs. First thing
>I've missed: no matter the size of the buffer being send(), sock_omalloc()
>is always requested with size=0[*]. Sure, skb->truesize is non-zero, so it
>does bump the counter, but it won't work as intended.
>
>Then comes vhost transport: sk_omem_alloc won't stay incremented, because
>skbs are processed and consumed. That's a race between transport and us.

I see, thanks for the details!

>
>So here's another desperate attempt to do it without elevated privileges:
>exhaust sk_omem_alloc by abusing sendmsg()'s `sock_kmalloc(sock->sk,
>ctl_len, GFP_KERNEL)`. Code below, tested under what I hope resembles your
>nested setup, i.e.
>
>L1$ --mode=server --peer-cid=4
>L2$ --mode=client --peer-cid=2
>
>L1$ --mode=client --peer-cid=4
>L2$ --mode=server --peer-cid=2
>
>Please let me know if it works for you.

Yep, tested several times without failures.

>
>That said, I really think this test should be scrapped. I'm afraid it will
>break sooner or later. And since kmemleak needs root anyway, perhaps it's
>better to use failslab fault injection for this?

As you prefer!

I'd be for merging this new version, but I would ask you to put a
comment above the function with your concerns about possible failures
in the future and possibly how to implement it with more privileges.
If they happen we always have time to remove the test or extend it to
use more privileged things.

>
>[*] It's the only caller. Should @size be dropped from sock_omalloc()?

Oh, I see, more a question for net maintainer, but I'd agree with you.
So I think you can try sending a patch to net-next for that.

>
>Sorry for the mess,

Don't worry at all! Really appreciated your help with vsock fixes and
tests.

Stefano

>Michal
>
>From 52cd25e49649f853e75ef82c90ff360ee0a54a50 Mon Sep 17 00:00:00 2001
>From: Michal Luczaj <mhal@rbox.co>
>Date: Wed, 4 Dec 2024 02:38:16 +0100
>Subject: [PATCH] vsock/test: Add test for MSG_ZEROCOPY completion memory leak
>
>Exercise the ENOMEM error path by attempting to hit net.core.optmem_max
>limit on send().
>
>Fixed by commit 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error
>handling").
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 82 ++++++++++++++++++++++++++++++++
> 1 file changed, 82 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 0a930803227a..d64e681f2904 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1552,6 +1552,83 @@ static void test_stream_msgzcopy_leak_errq_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_stream_msgzcopy_leak_zcskb_client(const struct test_opts *opts)
>+{
>+	size_t optmem_max, chunk_size;
>+	struct msghdr msg = { 0 };
>+	struct iovec iov = { 0 };
>+	char *chunk, buf = 'x';
>+	int fd, res;
>+	FILE *f;
>+
>+	f = fopen("/proc/sys/net/core/optmem_max", "r");
>+	if (!f) {
>+		perror("fopen(optmem_max)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (fscanf(f, "%zu", &optmem_max) != 1) {
>+		fprintf(stderr, "fscanf(optmem_max) failed\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	fclose(f);
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	enable_so_zerocopy_check(fd);
>+
>+	/* The idea is to fail virtio_transport_init_zcopy_skb() by hitting
>+	 * core.sysctl_optmem_max (sysctl net.core.optmem_max) limit check in
>+	 * sock_omalloc(sk, 0, GFP_KERNEL). Stuff sk->sk_omem_alloc with cmsg,
>+	 * see net/socket.c:____sys_sendmsg().
>+	 */
>+
>+	chunk_size = CMSG_SPACE(optmem_max - 1);
>+	chunk = malloc(chunk_size);
>+	if (!chunk) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
>+	memset(chunk, 0, chunk_size);
>+
>+	iov.iov_base = &buf;
>+	iov.iov_len = 1;
>+
>+	msg.msg_iov = &iov;
>+	msg.msg_iovlen = 1;
>+	msg.msg_control = chunk;
>+	msg.msg_controllen = optmem_max - 1;
>+
>+	errno = 0;
>+	res = sendmsg(fd, &msg, MSG_ZEROCOPY);
>+	if (res >= 0 || errno != ENOMEM) {
>+		fprintf(stderr, "expected ENOMEM, got errno=%d res=%d\n",
>+			errno, res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+static void test_stream_msgzcopy_leak_zcskb_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	vsock_wait_remote_close(fd);
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1692,6 +1769,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_msgzcopy_leak_errq_client,
> 		.run_server = test_stream_msgzcopy_leak_errq_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM MSG_ZEROCOPY leak completion skb",
>+		.run_client = test_stream_msgzcopy_leak_zcskb_client,
>+		.run_server = test_stream_msgzcopy_leak_zcskb_server,
>+	},
> 	{},
> };
>
>-- 
>2.47.1
>
>


