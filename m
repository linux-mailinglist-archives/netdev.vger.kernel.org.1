Return-Path: <netdev+bounces-158665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D880BA12E50
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0BB3A3D58
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632C71DAC9C;
	Wed, 15 Jan 2025 22:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BgvD9JDv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E441D90CB
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980522; cv=none; b=S1mWTrF6acxtP4rnOAPNL9JEjj35CTZXE8x4vSa0heamSRjLlAV1jCO8g1rptpUM88HLaKqOUEGNOJ6yvj3k0w/YyGCeAT4uI34jfu3XyoXqcMyic2LMqZFNws7ot/HOnhaa2Mq3nVlVmcB1+yPpPStdad4TbXbOWmHZ/zSuo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980522; c=relaxed/simple;
	bh=evY5cdz2HW97Nzee+/eQ47i7nHKmI94MbYr+RrnCZ1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWhDwlP4lSQH0Njuli/+x5qHQDm9PxggeHZDqlZzRlxZZLgVomOA0d7vC/v0i3oemBl5UjLQ0VT1133Kte0xoKY0AJh8+pXJCinArbiM0z/s8LouI5jM7WCvoiPkTT/wBV/umAq9/igEe4T/GL5YDVTyDtcoJ0QnjbpLloYyz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BgvD9JDv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361d5730caso7325e9.1
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 14:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736980518; x=1737585318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ln86NpUQJ/PhG+ekdxLsU5MYVmG9vqm559GoHwLhEKU=;
        b=BgvD9JDvQDklk8mpP+m+fC1X6aCT8pVl1zPJ/QdSp4Cfc4oA7FjEiC7zaEdLiHFvKi
         9ffS3YE4fh+008yKRmqNmKZjeKFgjgFkXsRuznMziDpicYEpSNOW57fKqxL0806t/LZn
         Unl3KVdRxSd+oBSPXKyxZqai9jMEQ870H37+patnxZAsXAoocW9BWuEjkGmfyf4G/T1a
         2/plnAzMDK19V98Jc97kxM7itcLn/GnXFDnD8g8iO3kUoAbExZWO4JjD6788yEdL5hvD
         zK6K5Dfh7C3Miut/ipt9P8+hOuDDGtuce02BRx0JLvgEsJvkVCMraaK9vhBkDOIJ4vs6
         aHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736980518; x=1737585318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ln86NpUQJ/PhG+ekdxLsU5MYVmG9vqm559GoHwLhEKU=;
        b=jKp+j8uv46lFfQUSkUQ1dmULxR02CNA8QD7gK0K021JMO+p1fmugUy4EVC+9CRLOkZ
         R9RJMnXFq0s8/mxJH2e4oXXE+rE5ZXBKn4qd9HhWnGKVnFrVTI6H6hgyFOuG2JN7abOB
         v3YNC8hMfNVtxPkdcGU8vwxxxW4YQtcrRxQ5/QmiP/JYNwR5v3mSWdGF0mGHfe66gFjs
         TGBpQD/44vTj2BTu5kdkaiAtK1WujBVZaiVQbshuEZKeIZQXmNwH3/0PiNGxbC+KFUa1
         Irgxqg1bIr4vxD85S7716nN/cttyrU2kNaesSCSJ67gW7hcSA0bDPzkoW+4ZWhQunGlL
         TWYw==
X-Forwarded-Encrypted: i=1; AJvYcCXPvHtL7P5SFQV4Yx72ofJM0PFWPxfb+Qn8fvJf2XJK2FwToZHRnEL2YuX3Ed1dA4tg6ohhzOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9JVLzDdMEytD4NFrcTZPVKeihmAXjVXSqXmGoyT7KtNSUH9+W
	5T0aGCmvEnRNdP+SqVQ9x4Sqcv7YHwcariavWbnFLGLUxtUSIVRjwJxb428ytgny534NJdSarB7
	7j6bvjdg3Rv7u98p61OU6+sV/Oz/bcov3o/H2
X-Gm-Gg: ASbGnct3HGNZspSnKqkWG11EZfcEDxEn7DHlri1eV+aDA861j/E/I7kzR2q7zmLbclg
	KcCOItIpXuK0VzBJNbBVYXZCHtzSEIulEgAMa8JUt9SDWoXhpGuJ8ESnz3c7cTpoT64z5q1k=
X-Google-Smtp-Source: AGHT+IH65eyZg+yZpq5KxyajTKYTZOQxU0OZT0wAchv3pRsP8eiu7akPLHHoWLQzh721bQeMCBJG1/XY9l/+xgQe2ic=
X-Received: by 2002:a05:600c:510f:b0:436:186e:13a6 with SMTP id
 5b1f17b1804b1-4388b32ffc2mr345035e9.6.1736980518355; Wed, 15 Jan 2025
 14:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102191227.2084046-1-skhawaja@google.com> <20250102164714.0d849aaf@kernel.org>
 <Z37RFvD03cctrtTO@LQ3V64L9R2> <CAAywjhTAvT+LPT8_saw41vV6SE+EWd-2gzCH1iP_0HOvdi=yEg@mail.gmail.com>
 <5971d10c-c8a3-43e7-88e3-674808ae39a3@uwaterloo.ca>
In-Reply-To: <5971d10c-c8a3-43e7-88e3-674808ae39a3@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 15 Jan 2025 14:35:07 -0800
X-Gm-Features: AbW1kvZaKxvkVjlvNvZsznGXDJ5wuTt9P9upPxJK9pISGNDXo1QWYjaSBZ0HSMQ
Message-ID: <CAAywjhQwNJuHE6T6caq9Y6DfDqrZo6CTP5ToSDHrcE4wZH_7YQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 1:54=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo.c=
a> wrote:
>
> On 2025-01-08 16:18, Samiullah Khawaja wrote:
> > On Wed, Jan 8, 2025 at 11:25=E2=80=AFAM Joe Damato <jdamato@fastly.com>=
 wrote:
> >>
> >> On Thu, Jan 02, 2025 at 04:47:14PM -0800, Jakub Kicinski wrote:
> >>> On Thu,  2 Jan 2025 19:12:24 +0000 Samiullah Khawaja wrote:
> >>>> Extend the already existing support of threaded napi poll to do cont=
inuous
> >>>> busypolling.
> >>>>
> >>>> This is used for doing continuous polling of napi to fetch descripto=
rs from
> >>>> backing RX/TX queues for low latency applications. Allow enabling of=
 threaded
> >>>> busypoll using netlink so this can be enabled on a set of dedicated =
napis for
> >>>> low latency applications.
> >>>
> >>> This is lacking clear justification and experimental results
> >>> vs doing the same thing from user space.
> > Thanks for the response.
> >
> > The major benefit is that this is a one common way to enable busy
> > polling of descriptors on a particular napi. It is basically
> > independent of the userspace API and allows for enabling busy polling
> > on a subset, out of the complete list, of napi instances in a device
> > that can be shared among multiple processes/applications that have low
> > latency requirements. This allows for a dedicated subset of napi
> > instances that are configured for busy polling on a machine and
> > workload/jobs can target these napi instances.
> >
> > Once enabled, the relevant kthread can be queried using netlink
> > `get-napi` op. The thread priority, scheduler and any thread core
> > affinity can also be set. Any userspace application using a variety of
> > interfaces (AF_XDP, io_uring, xsk, epoll etc) can run on top of it
> > without any further complexity. For userspace driven napi busy
> > polling, one has to either use sysctls to setup busypolling that are
> > done at device level or use different interfaces depending on the use
> > cases,
> > - epoll params (or a sysctl that is system wide) for epoll based interf=
ace
> > - socket option (or sysctl that is system wide) for sk_recvmsg
> > - io_uring (I believe SQPOLL can be configured with it)
> >
> > Our application for this feature uses a userspace implementation of
> > TCP (https://github.com/Xilinx-CNS/onload) that interfaces with AF_XDP
> > to send/receive packets. We use neper (running with AF_XDP + userspace
> > TCP library) to measure latency improvements with and without napi
> > threaded busy poll. Our target application sends packets with a well
> > defined frequency with a couple of 100 bytes of RPC style
> > request/response.
>
> Let me also apologize for being late to the party. I am not always
> paying close attention to the list and did not see this until Joe
> flagged it for me.
Thanks for the reply.
>
> I have a couple of questions about your experiments. In general, I find
> this level of experiment description not sufficient for reproducibility.
> Ideally you point to complete scripts.
>
> A canonical problem with using network benchmarks like neper to assess
> network stack processing is that it typically inflates the relative
> importance of network stack processing, because there is not application
> processing involved
Agreed on your assessment and I went back to get some more info before
I could reply to this. Basically our use case is a very low latency, a
solid 14us RPCs with very small messages around 200 bytes with minimum
application processing. We have well defined traffic patterns for this
use case with a defined maximum number of packets per second to make
sure the latency is guaranteed. So to measure the performance of such
a use case, we basically picked up neper and used it to generate our
traffic pattern. While we are using neper, this does represent our
real world use case. Also In my experimentation, I am using neper with
the onload library that I mentioned earlier to interface with the NIC
using AF_XDP. In short we do want to get the maximum network stack
optimization where the packets are pulled off the descriptor queue
quickly..
>
> Were the experiments below run single-threaded?
Since we are waiting on some of the other features in our environment,
we are working with only 1 RX queue that has multiple flows running.
Both experiments have the same interrupt configuration, Also the
userspace process has affinity set to be closer to the core getting
the interrupts.
>
> > Test Environment:
> > Google C3 VMs running netdev-net/main kernel with idpf driver
> >
> > Without napi threaded busy poll (p50 at around 44us)
> > num_transactions=3D47918
> > latency_min=3D0.000018838
> > latency_max=3D0.333912365
> > latency_mean=3D0.000189570
> > latency_stddev=3D0.005859874
> > latency_p50=3D0.000043510
> > latency_p90=3D0.000053750
> > latency_p99=3D0.000058230
> > latency_p99.9=3D0.000184310
>
> What was the interrupt routing in the above base case?
>
> > With napi threaded busy poll (p50 around 14us)
> > latency_min=3D0.000012271
> > latency_max=3D0.209365389
> > latency_mean=3D0.000021611
> > latency_stddev=3D0.001166541
> > latency_p50=3D0.000013590
> > latency_p90=3D0.000019990
> > latency_p99=3D0.000023670
> > latency_p99.9=3D0.000027830
>
> How many cores are in play in this case?
Same in userspace. But napi has its own dedicated core polling on it
inside the kernel. Since napi is polled continuously, we don't enable
interrupts for this case as implemented in the patch. This is one of
the major reasons we cannot drive this from userspace and want napi
driven in a separate core independent of the application processing
logic. We don't want the latency drop while the thread that is driving
the napi goes back to userspace and handles some application logic or
packet processing that might be happening in onload.
>
> I am wondering whether your baseline effectively uses only one core, but
> your "threaded busy poll" case uses two? Then I am wondering whether a
> similar effect could be achieved by suitable interrupt and thread affinit=
y?
We tried doing this in earlier experiments by setting up proper
interrupt and thread affinity to make them closer and the 44us latency
is achieved using that. With non AF_XDP tests by enabling busypolling
at socket level using socketopt, we are only able to achieve around
20us, but P99 still suffers. This is mostly because the thread that is
driving the napi goes back to userspace to do application work. This
netlink based mechanism basically solves that and provides a UAPI
independent mechanism to enable busypolling for a napi. One can choose
to configure the napi thread core affinity and priority to share cores
with userspace processes if desired.
>
> Thanks,
> Martin
>
> [snip]
>

