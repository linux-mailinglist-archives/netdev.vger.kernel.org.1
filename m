Return-Path: <netdev+bounces-177527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D0DA7072E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3018C16CE5A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CCA25DCE0;
	Tue, 25 Mar 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dP2y91ry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBE725D553
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920825; cv=none; b=nGMaJFY7loHtTi5BiBww8i4bROyO+aVeUEf7//p0UzhvRSOn6q7PvIKluGDwuuLHx5QuSoOSClV1TsMgId4HENBdro5zHN2QR6qQbbdAkDgTJpsoN3lhevTZ+xvd9O956Rp36ehvS5AoNslKvFNRYOSO8ou665Cpbdp/iZAaRDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920825; c=relaxed/simple;
	bh=UOwLVkQkonzry7bkGGEaKcMSUG6D6nem6DLREYv5Hm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kbgp3fSHqToNaFSh4yOyv9ytB2JgI9aswnqpE5K5KPyfEFlaQbo55X6gkzWNMffZN4lh0GZZ9NrjhMxzxWmYAsWDqZVOvcbQSLnJFX3T4/Ovv/j9pekhTBjJJVEMpzBhk7GoYzmXP4bR9RQ43XlgcYyfxAd/4Jw7n8/NPHQsu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dP2y91ry; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2263428c8baso244165ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742920823; x=1743525623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzcunlF6wnrKASYtocX/K9ZqcfNy+ii4vXAg9PC3H4M=;
        b=dP2y91ryINNbhxxFl2vQIqfRyxiqFsUnVdw0ydzXdT/eiZJ6o4b28A35CLhScbJIkl
         cO9JsN+cKfq031AilW/G+FoFj8yEMl1fHNiPEB4eLAHJLsjLnOR6jyRB2T7xnnPxxmz8
         i5zVTpJ6yl4UiFQbdLsyqUzCktN5COPj7KqF8/zOSn4nU9cZeXfnYuQ4i2hxq4vSSGDr
         e4u+9DSoLyw5lf3+V38LfK5G363hwKdvV9sQhY5J0KHC8MwJMA4iLPFnrHB/WsWQM1iS
         aU3r8AktgkTD3C8NwdBaezXxy6vKz2RHyVG5GhiXSjh/InIhI9+fKM6qRyg2iqrGiJtI
         unXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920823; x=1743525623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzcunlF6wnrKASYtocX/K9ZqcfNy+ii4vXAg9PC3H4M=;
        b=SiIZo9PHoZTsBDEo11v1oUUrqpUO5tUuUEXBfjtOGmkZZoZK1sCL8EXQ7TSjiKrZq1
         poi9DNrl+yevFGVsycgb9saeXHN56xRJzsiuni2ymc9kSjQ9L8hNxbLWAYQlXls2Fboa
         12bZ1V9WPBAru2LRQDhoc7POZvAo7/ZaDgI/kbWyWiFFkTXzwGNIu/JeRthJV7zMyob+
         Vx6vivyn55aTc2AH259X35jDK+YMw1VKs2m8hgSp471jO537fSe1vERHBIojtUEUL/vs
         0s/thvwqDlm8yzCUclX5vKw16oLFu/c904FRK0jUH2Sk51WDttj+jCTgZ0RdxF3ujPZG
         q1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxoIEv4jZGM+x1gPKIvrXAaEJxNmvf25caDNaV7zDG+kwIAVOheSocn2NjrJg5so70IkwGt3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkk0IyjRCNUAKF5LjqwzIlvBisLtmh7pSIq0hGbNL/rO8EKSNo
	KuDm4GJDFoVUIpF7ktGeseNaXnI1htP2QkP40io8uW6ZoYVgjoFnkXjPiTri7VtHh5gL3vEiNPP
	sRj9OcEGmxxlSUBR8PglVmvLVLsoPHIlAjTAe
X-Gm-Gg: ASbGncvegyk3jAOodyUoQEVWSwf86bGL0GZmExMtsm2zJ7POyRziXoMdzUjJkMfk1Fs
	s07bpEp7JWHzAzlNubbuif3ZHN5esxUAGAKo9+s7lx8lRo2xHu5/6PoytoFd4Won6JRygYIswd4
	amKK885Buvbjrxo+1WH6oDWEwtLVF3Id55AgihwZD/THUorxyYz8EkBU5ZXQ0nzVkF
X-Google-Smtp-Source: AGHT+IEY0IdqmHVtfsYxHYtimAVp0FZIYmyupY5qvmLAtpmfOtXEKjDtWlVt+okqXY5F8t/DTDuKHn9Kx3xYLd7Hy+8=
X-Received: by 2002:a17:902:f707:b0:21f:3e29:9cd4 with SMTP id
 d9443c01a7336-2279832099dmr9382005ad.20.1742920822577; Tue, 25 Mar 2025
 09:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321021521.849856-1-skhawaja@google.com> <451afb5a-3fed-43d4-93cc-1008dd6c028f@uwaterloo.ca>
In-Reply-To: <451afb5a-3fed-43d4-93cc-1008dd6c028f@uwaterloo.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 25 Mar 2025 09:40:10 -0700
X-Gm-Features: AQ5f1JobjXpjaxd7AGrr3Pw1PXAp9x0EuZRXLbWcjCsNINKQ19RVVNqBDmYh7qo
Message-ID: <CAAywjhSGp6CaHXsO5EDANPHA=wpOO2C=4819+75fLoSuFL2dHA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] Add support to do threaded napi busy poll
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 23, 2025 at 7:38=E2=80=AFPM Martin Karsten <mkarsten@uwaterloo.=
ca> wrote:
>
> On 2025-03-20 22:15, Samiullah Khawaja wrote:
> > Extend the already existing support of threaded napi poll to do continu=
ous
> > busy polling.
> >
> > This is used for doing continuous polling of napi to fetch descriptors
> > from backing RX/TX queues for low latency applications. Allow enabling
> > of threaded busypoll using netlink so this can be enabled on a set of
> > dedicated napis for low latency applications.
> >
> > Once enabled user can fetch the PID of the kthread doing NAPI polling
> > and set affinity, priority and scheduler for it depending on the
> > low-latency requirements.
> >
> > Currently threaded napi is only enabled at device level using sysfs. Ad=
d
> > support to enable/disable threaded mode for a napi individually. This
> > can be done using the netlink interface. Extend `napi-set` op in netlin=
k
> > spec that allows setting the `threaded` attribute of a napi.
> >
> > Extend the threaded attribute in napi struct to add an option to enable
> > continuous busy polling. Extend the netlink and sysfs interface to allo=
w
> > enabling/disabling threaded busypolling at device or individual napi
> > level.
> >
> > We use this for our AF_XDP based hard low-latency usecase with usecs
> > level latency requirement. For our usecase we want low jitter and stabl=
e
> > latency at P99.
> >
> > Following is an analysis and comparison of available (and compatible)
> > busy poll interfaces for a low latency usecase with stable P99. Please
> > note that the throughput and cpu efficiency is a non-goal.
> >
> > For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
> > description of the tool and how it tries to simulate the real workload
> > is following,
> >
> > - It sends UDP packets between 2 machines.
> > - The client machine sends packets at a fixed frequency. To maintain th=
e
> >    frequency of the packet being sent, we use open-loop sampling. That =
is
> >    the packets are sent in a separate thread.
> > - The server replies to the packet inline by reading the pkt from the
> >    recv ring and replies using the tx ring.
> > - To simulate the application processing time, we use a configurable
> >    delay in usecs on the client side after a reply is received from the
> >    server.
> >
> > The xdp_rr tool is posted separately as an RFC for tools/testing/selfte=
st.
>
> Thanks very much for sending the benchmark program and these specific
> experiments. I am able to build the tool and run the experiments in
> principle. While I don't have a complete picture yet, one observation
> seems already clear, so I want to report back on it.
Thanks for reproducing this Martin. Really appreciate you reviewing
this and your interest in this.
>
> > We use this tool with following napi polling configurations,
> >
> > - Interrupts only
> > - SO_BUSYPOLL (inline in the same thread where the client receives the
> >    packet).
> > - SO_BUSYPOLL (separate thread and separate core)
> > - Threaded NAPI busypoll
>
> The configurations that you describe as SO_BUSYPOLL here are not using
> the best busy-polling configuration. The best busy-polling strictly
> alternates between application processing and network polling. No
> asynchronous processing due to hardware irq delivery or softirq
> processing should happen.
>
> A high-level check is making sure that no softirq processing is reported
> for the relevant cores (see, e.g., "%soft" in sar -P <cores> -u ALL 1).
> In addition, interrupts can be counted in /proc/stat or /proc/interrupts.
>
> Unfortunately it is not always straightforward to enter this pattern. In
> this particular case, it seems that two pieces are missing:
>
> 1) Because the XPD socket is created with XDP_COPY, it is never marked
> with its corresponding napi_id. Without the socket being marked with a
> valid napi_id, sk_busy_loop (called from __xsk_recvmsg) never invokes
> napi_busy_loop. Instead the gro_flush_timeout/napi_defer_hard_irqs
> softirq loop controls packet delivery.
Nice catch. It seems a recent change broke the busy polling for AF_XDP
and there was a fix for the XDP_ZEROCOPY but the XDP_COPY remained
broken and seems in my experiments I didn't pick that up. During my
experimentation I confirmed that all experiment modes are invoking the
busypoll and not going through softirqs. I confirmed this through perf
traces. I sent out a fix for XDP_COPY busy polling here in the link
below. I will resent this for the net since the original commit has
already landed in 6.13.
https://lore.kernel.org/netdev/CAAywjhSEjaSgt7fCoiqJiMufGOi=3Doxa164_vTfk+3=
P43H60qwQ@mail.gmail.com/T/#t
>
> I found code at the end of xsk_bind in xsk.c that is conditional on xs->z=
c:
>
>         if (xs->zc && qid < dev->real_num_rx_queues) {
>                 struct netdev_rx_queue *rxq;
>
>                 rxq =3D __netif_get_rx_queue(dev, qid);
>                 if (rxq->napi)
>                         __sk_mark_napi_id_once(sk, rxq->napi->napi_id);
>         }
>
> I am not an expert on XDP sockets, so I don't know why that is or what
> would be an acceptable workaround/fix, but when I simply remove the
> check for xs->zc, the socket is being marked and napi_busy_loop is being
> called. But maybe there's a better way to accomplish this.
+1
>
> 2) SO_PREFER_BUSY_POLL needs to be set on the XDP socket to make sure
> that busy polling stays in control after napi_busy_loop, regardless of
> how many packets were found. Without this setting, the gro_flush_timeout
> timer is not extended in busy_poll_stop.
>
> With these two changes, both SO_BUSYPOLL alternatives perform noticeably
> better in my experiments and come closer to Threaded NAPI busypoll, so I
> was wondering if you could try that in your environment? While this
> might not change the big picture, I think it's important to fully
> understand and document the trade-offs.
I agree. In my experiments the SO_BUSYPOLL works properly, please see
the commit I mentioned above. But I will experiment with
SO_PREFER_BUSY_POLL to see whether it makes any significant change.
>
> Thanks,
> Martin
>

