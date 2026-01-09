Return-Path: <netdev+bounces-248554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AD0D0B4D8
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 17:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BDD930621C1
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3072C35A939;
	Fri,  9 Jan 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpDQHHWn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKJoPHBx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8C613D51E
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976357; cv=none; b=NEZKH11gyU99CmrR2p09dFF+tDfMrQevj0YDNionw3RRdoDHnw3VOaYk175deZ2gL4nDKl+oVnRIG7QDKLims+4BEInXn+0zf2l2ZRO7aMbHuk1cgugg1p1J6GGfZ3FeGDFa1hE1nhxmJ6Z2R3iB50nNPGs73XbhSh7Moin/ZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976357; c=relaxed/simple;
	bh=AhO0W3QqPyvRX+DZ7rtuWNPWm1Y+nD8N2kgT7qXsPh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGcru2ere64XsXBjrJpy50yeOjbv2I6j9vcnxKDv7hmiNbxc8KwRENkeMdiiBINI2dSwvHTGQMauvPdmW7dtV+kFRae8C5aSHt3kCNk6RoGjQ0jIs2hmRW1WyEAqxhq+9XkgIrzsUMQT6bRgHrjEqfzS1JKoH0odNrbqSiEulc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpDQHHWn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKJoPHBx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767976354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEreNKulSbEm1+LE8N+VyJH3RewoJdVfa+9kn/ikLWM=;
	b=gpDQHHWnWs+Pc6DM2K4UfVTQuoZ4zgsm2OMxa3xKyi9i7MAbXAB8DDuX4ds7pVfX07JEW3
	lBuKVw8rE2B9hbMb/mD2idjhw+ULgDrc4nYPIiaQqnwmYzXWasJP/hp6cSueNEzGLl9/5h
	8U+Mfp8LbI1RN7yYwRw97tbz0wsd+8k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-HpAfq6NKP3S4CBKEx4lumQ-1; Fri, 09 Jan 2026 11:32:33 -0500
X-MC-Unique: HpAfq6NKP3S4CBKEx4lumQ-1
X-Mimecast-MFC-AGG-ID: HpAfq6NKP3S4CBKEx4lumQ_1767976352
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64b9ee8a07eso5003292a12.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767976352; x=1768581152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEreNKulSbEm1+LE8N+VyJH3RewoJdVfa+9kn/ikLWM=;
        b=AKJoPHBxlTFLeVzJZU/RFVZsmxKhO1q3Air6ttgS9Mam1kM9gsmyORvTdU/o+BRW8P
         XRcgNRt2dPU5ppklSwa4FYZNklyLSVkbX7htPykKY6ci6Pp9ZqPH5GsDoswYE1h5m6GS
         KJ7VS401Eh4zW/+bRiAxgfhSQDQnKVnwkNAdXv35itLit2TkYmzN/js1HJfDFLycuLfa
         k4AeTV4dfLBr08u54zKFi/PsAE79XyzDym0wMAZ9O0aM6ypmzQR1JcHtyjdrmcwqjoZC
         64LhFKNz1e8+NK0jup+JNM23smjEN2fpQ+K+u/n16Pgepfj9PVapouyr/zIHjQpkTxnt
         1Ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767976352; x=1768581152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEreNKulSbEm1+LE8N+VyJH3RewoJdVfa+9kn/ikLWM=;
        b=sxUCTwa5EZKRD5AYFifGNGWYe9vNTBjz6VB4+Y+9a0KI/amMnkP91exaxLrSOn+W3c
         lRPyVlspmDINbHtwAtUSU3Ao22g8XVLH/xmm4+tJZf+TrHwyfMQNHdQPSe47LnH1um0W
         m4Vl14t0jHWp7+uVZngVLCKvZbnqyVggaFON+A5epiQur0qPbl9wdaEKaab9m9IDcNCu
         gHJvKL4krph1tk6QYlvbOh8klmG3TmJ0Q92S29vtmoGAFMWmV6VriL8Ja0inPyh72M5I
         zcFK3Q0bY7Tjk/4JuqHHrIyWNJiZz1oxwXb3aesb/HXFLVaesw2AUUBKlhcNzhuzkQpZ
         3wYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrirLCCEsPtaBqX8gnImPMjFAuBO05NxCIOxcIzqtFxMme83UPwksAeOWgYj/F+3758HCBgH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLWmKbyNUzRi1tCWhsJIwqd4HqxsbCQRpeR7YttFl569rgttM0
	t/LChTyf7r55lPs3XcrK4XjMh8k/dYprNNI6kGPrnjIfvXEGeanFKSJbDAG7xHvZpsuRxl3Zqpq
	OhsmOw63IrcyFgkHXSGnvYClj5IFKIYE8f0erh0BjJyquqI8Dp2L9JeQTYw==
X-Gm-Gg: AY/fxX5U04lnH64DsSZQvS0cX4wr+V8cM1gE92B1CFZY4pu8avDFWry2H0a0z0C4kjU
	pH0S4IUAP+akZpH9zLsklCwaWYOEhJrLPEDhlh6dReO0nFK1ssd+AEC+Wb/lILQ0zurTK9md9ZY
	FK3Ymp1kbSR2mfgkASegSHDa3a4NlMx3ticEEOBS2yHIaImfd+K3Uk5A2ocMixh7qeBNe4xRfBX
	UUu2l8Q4tZ5671cx8jh3ZP3kjBT3c4WcntqPQH1SsTq7j4ZI7ZKJrBSlkcz+m5AmQt74Dj20z4b
	UWcye9m00k/V/PMgA1oP1HLP6sRRhQKyXv6HMyh/mNYNeq0pk/MTtLCT1K+tGRLmmUszf1YiJ3R
	iRC6P/xP3hXSDq4M=
X-Received: by 2002:a05:6402:5214:b0:649:afbf:ce4c with SMTP id 4fb4d7f45d1cf-65097dd19d0mr10206807a12.3.1767976351968;
        Fri, 09 Jan 2026 08:32:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh9F6wrxt+tH3YONGJ8MMPHym5YuR5cSOU8k+Xh+56gOqWbHHpSyrYloIioAY7C+cjecCrrw==
X-Received: by 2002:a05:6402:5214:b0:649:afbf:ce4c with SMTP id 4fb4d7f45d1cf-65097dd19d0mr10206768a12.3.1767976351430;
        Fri, 09 Jan 2026 08:32:31 -0800 (PST)
Received: from sgarzare-redhat ([193.207.176.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c0asm10815163a12.9.2026.01.09.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:32:30 -0800 (PST)
Date: Fri, 9 Jan 2026 17:32:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vsock/test: Add test for a linear and non-linear skb
 getting coalesced
Message-ID: <aWEqjjE1vb_t35lQ@sgarzare-redhat>
References: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
 <20260108-vsock-recv-coalescence-v1-2-26f97bb9a99b@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260108-vsock-recv-coalescence-v1-2-26f97bb9a99b@rbox.co>

On Thu, Jan 08, 2026 at 10:54:55AM +0100, Michal Luczaj wrote:
>Loopback transport can mangle data in rx queue when a linear skb is
>followed by a small MSG_ZEROCOPY packet.

Can we describe a bit more what the test is doing?

>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c          |  5 +++
> tools/testing/vsock/vsock_test_zerocopy.c | 67 +++++++++++++++++++++++++++++++
> tools/testing/vsock/vsock_test_zerocopy.h |  3 ++
> 3 files changed, 75 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index bbe3723babdc..21c8616100f1 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -2403,6 +2403,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_accepted_setsockopt_client,
> 		.run_server = test_stream_accepted_setsockopt_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM MSG_ZEROCOPY coalescence corruption",

This is essentially a regression test for virtio transport, so I'd add 
virtio in the test name.

>+		.run_client = test_stream_msgzcopy_mangle_client,
>+		.run_server = test_stream_msgzcopy_mangle_server,
>+	},
> 	{},
> };
>
>diff --git a/tools/testing/vsock/vsock_test_zerocopy.c b/tools/testing/vsock/vsock_test_zerocopy.c
>index 9d9a6cb9614a..6735a9d7525d 100644
>--- a/tools/testing/vsock/vsock_test_zerocopy.c
>+++ b/tools/testing/vsock/vsock_test_zerocopy.c
>@@ -9,11 +9,13 @@
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
>+#include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <unistd.h>
> #include <poll.h>
> #include <linux/errqueue.h>
> #include <linux/kernel.h>
>+#include <linux/sockios.h>
> #include <errno.h>
>
> #include "control.h"
>@@ -356,3 +358,68 @@ void test_stream_msgzcopy_empty_errq_server(const struct test_opts *opts)
> 	control_expectln("DONE");
> 	close(fd);
> }
>+
>+#define GOOD_COPY_LEN	128	/* net/vmw_vsock/virtio_transport_common.c */

I think we don't need this, I mean we can eventually just send a single 
byte, no?

>+
>+void test_stream_msgzcopy_mangle_client(const struct test_opts *opts)
>+{
>+	char sbuf1[PAGE_SIZE + 1], sbuf2[GOOD_COPY_LEN];
>+	struct pollfd fds;
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	enable_so_zerocopy_check(fd);
>+
>+	memset(sbuf1, '1', sizeof(sbuf1));
>+	memset(sbuf2, '2', sizeof(sbuf2));
>+
>+	send_buf(fd, sbuf1, sizeof(sbuf1), 0, sizeof(sbuf1));
>+	send_buf(fd, sbuf2, sizeof(sbuf2), MSG_ZEROCOPY, sizeof(sbuf2));
>+
>+	fds.fd = fd;
>+	fds.events = 0;
>+
>+	if (poll(&fds, 1, -1) != 1 || !(fds.revents & POLLERR)) {
>+		perror("poll");
>+		exit(EXIT_FAILURE);
>+	}

Should we also call vsock_recv_completion() or we don't care about the 
result?

If we need it, maybe we can factor our the poll + 
vsock_recv_completion().

>+
>+	close(fd);
>+}
>+
>+static void recv_verify(int fd, char *buf, unsigned int len, char pattern)
>+{
>+	recv_buf(fd, buf, len, 0, len);
>+
>+	while (len--) {
>+		if (*buf++ != pattern) {
>+			fprintf(stderr, "Incorrect data received\n");
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+}
>+
>+void test_stream_msgzcopy_mangle_server(const struct test_opts *opts)
>+{
>+	char rbuf[PAGE_SIZE + 1];
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Wait, don't race the (buggy) skbs coalescence. */
>+	vsock_ioctl_int(fd, SIOCINQ, PAGE_SIZE + 1 + GOOD_COPY_LEN);

This is cool, another option is to add a barrier here (and after the 
poll), but yeah, this should be even better.

Thanks,
Stefano

>+
>+	recv_verify(fd, rbuf, PAGE_SIZE + 1, '1');
>+	recv_verify(fd, rbuf, GOOD_COPY_LEN, '2');
>+
>+	close(fd);
>+}
>diff --git a/tools/testing/vsock/vsock_test_zerocopy.h b/tools/testing/vsock/vsock_test_zerocopy.h
>index 3ef2579e024d..d46c91a69f16 100644
>--- a/tools/testing/vsock/vsock_test_zerocopy.h
>+++ b/tools/testing/vsock/vsock_test_zerocopy.h
>@@ -12,4 +12,7 @@ void test_seqpacket_msgzcopy_server(const struct test_opts *opts);
> void test_stream_msgzcopy_empty_errq_client(const struct test_opts *opts);
> void test_stream_msgzcopy_empty_errq_server(const struct test_opts 
> *opts);
>
>+void test_stream_msgzcopy_mangle_client(const struct test_opts *opts);
>+void test_stream_msgzcopy_mangle_server(const struct test_opts *opts);
>+
> #endif /* VSOCK_TEST_ZEROCOPY_H */
>
>-- 
>2.52.0
>


