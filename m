Return-Path: <netdev+bounces-243382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D21FC9E861
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 10:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C79C4E0EB8
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8752DFA5B;
	Wed,  3 Dec 2025 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk6IeChr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F552DF701
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754851; cv=none; b=pmZs6q/kNbu0/uIQXRg8wF0gTWSMVdI084Gn2rg+bI2SRVa+BfOK3j4IgQ50ZNhxBlyA7XOk61tcjLQWVPEr2kljn+FW/42qb1b8nbwU85fG9IBnkXyEjyv/nNRGAnrOohqFaO71q+0PqQu0/H9R325t0gng41+MqY4COnbXfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754851; c=relaxed/simple;
	bh=IT2goCZ9rdKgCFuOuFhcZua7F3KuujYzbbf+nm17Y0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eb/Ru1noGb9ISOf2mSqR+rU2LoqCi05M4KBHTnEPHyjk/4aULpYBDJ8bZOwPtOddC0wMqq2+NXIPuXI+mxREcGO1JEEyJZCYRaBvHxV/RYFds0tN+YlvXYRr5P5YGnoFXwXW0WeGggMnyjCI3f8PJmoP/U1EaT9AxeBl2Qk83rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rk6IeChr; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88043139c35so59210356d6.0
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 01:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764754847; x=1765359647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOCCooYX/P0AtyViyqyHM3T168L+EzFewWkmhlG/fG8=;
        b=Rk6IeChrCbTh0zRTDfubxFo6fcwu6jxkougpwSEt4p3e4agBaq096lycZ5e7dMiusI
         uSpyMSrN1fjqcYoW0Qy+0F3r9GNZQOrC5K43yCKysU2zMAiuVBSEcpMqAFMTh9gFtkEF
         0WKlV9aRmtUH8g7SiJPob/Q8+z4Dbe+kYk5q6wFlzkRo7GYIcBHn4yqyF/+Pgux2ZFkk
         7HB0/SVhbPMLC5LAAue5ae9t6sgaPQj8mjcLpw/7RWRdGp4K/A4US8bbIKBMC0un8f6M
         ll6z13FFHyOBXesOLGlsZtwPz+H9T3MD9HVTdSdXCxDBGaZD1ExpSNWevqc3K1tFWqVx
         DccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764754847; x=1765359647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NOCCooYX/P0AtyViyqyHM3T168L+EzFewWkmhlG/fG8=;
        b=hwme9pOKtRn7t2Ci2bEQJhmKvF20TQ2pE6LV1x756cR+6EguI8Lp/3136azZ3GPsAG
         pj1m/QcJi6MfDDWKeIHQkkOB1y5WDzSwRDmMua+o2X0vr1JZxOd5FOQSRjozl3ABBFQZ
         vtqTab+7BSq98pMmFfjWgmRPrfaQ4gLv+XtubBFatM+Y27ty5f/SzyxgDH5S2VaRCJts
         pZw8nARMyueSqJRfSd0fxGMO/8mNSorwt6Ijfq2GfnwS7Dxte3r6oESr5Zh2r5Kncc8Z
         tMw3tdySqIYxcWDtWYUK6Z+H4HY7ErBGCM/SwgrhnqIuMg7FryXsSmhBbHq+aHMHs2P6
         B4rA==
X-Forwarded-Encrypted: i=1; AJvYcCWMXcn3AJVt/LMORukFfJ6H5yPOO7ezdPsdbg24DoueqJUkQqKNp3Lod4RauG25IKKQVKa28Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGojvPXu+rZWPVrFU6DAXUlZBgHAAqL/HkR3kJ9QH+H6OfdEYz
	s1V6PZ1nkjXMpdXL5UO1B5ttzOLJjbptRJl41eqwUTxXe9sOnXoT7TgRgfKmxHWCXgPbaAQHe1Q
	cY0xEbLQnk9D6iI2jPnOHdhp0cS1p4hE=
X-Gm-Gg: ASbGncuXPFQXC52luibJR9iBTF+B4moqpw1bY7vqXRuC8iS3AKW8uZmyHOMeRb71Phm
	Cu2jhsxOB9Zu2Dj3KtGCPlpX6a18jI5sjHmf59m/qLg2u9o6+n4LBEDT1m9t0IEpQAaV2vTk/Ib
	RfkkcPVLtCpJ0gQC2ZnJekt5gvu8IhTQI1unDDqRduELdKGmelTT33B8VQu+MPqaR67FdjaJimr
	jpOcok5RBFwzxnAxKNFk2XRyuiXSkfKB7clLhUJm9ltF2D7FwxXic0FNKjd43ABOKx7z4k=
X-Google-Smtp-Source: AGHT+IEst8jKgkFdU8mRg2R84iMD3tpz+P3Zglcl/DDRuz4mcMHxzQ5gtr6vuR0eXVlgeoTNd+Yeqyl/gzRUYa0BE+o=
X-Received: by 2002:a05:6214:450b:b0:7c2:d5b7:dd54 with SMTP id
 6a1803df08f44-888194b6ca8mr21077916d6.18.1764754846918; Wed, 03 Dec 2025
 01:40:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128134601.54678-1-kerneljasonxing@gmail.com>
 <20251128134601.54678-3-kerneljasonxing@gmail.com> <8fa70565-0f4a-4a73-a464-5530b2e29fa5@redhat.com>
 <CAL+tcoDk0f+p2mRV=2auuYfTLA-cPPe-1az7NfEnw+FFaPR5kA@mail.gmail.com>
 <CAL+tcoBMRdMevWCS1puVD4zEDt+69S6t2r6Ov8tw7zhgq_n=PA@mail.gmail.com> <92e34c61-550a-449f-b183-cd8917fc5f9b@redhat.com>
In-Reply-To: <92e34c61-550a-449f-b183-cd8917fc5f9b@redhat.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 3 Dec 2025 10:40:36 +0100
X-Gm-Features: AWmQ_bkjxhlG3TIuQkajuEJP996RM6T3-Kv9j7yyKdunldX43K9YtwHCr89sUXU
Message-ID: <CAJ8uoz2hjzea40-H3W5VAru7S+iFeVJ-2VoaFWjVqyFm3WpUKg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Dec 2025 at 10:25, Paolo Abeni <pabeni@redhat.com> wrote:
>
> On 12/3/25 7:56 AM, Jason Xing wrote:
> > On Sat, Nov 29, 2025 at 8:55=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> >> On Fri, Nov 28, 2025 at 10:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>> On 11/28/25 2:46 PM, Jason Xing wrote:
> >>>> From: Jason Xing <kernelxing@tencent.com>
> >>>>
> >>>> Use atomic_try_cmpxchg operations to replace spin lock. Technically
> >>>> CAS (Compare And Swap) is better than a coarse way like spin-lock
> >>>> especially when we only need to perform a few simple operations.
> >>>> Similar idea can also be found in the recent commit 100dfa74cad9
> >>>> ("net: dev_queue_xmit() llist adoption") that implements the lockles=
s
> >>>> logic with the help of try_cmpxchg.
> >>>>
> >>>> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >>>> ---
> >>>> Paolo, sorry that I didn't try to move the lock to struct xsk_queue
> >>>> because after investigation I reckon try_cmpxchg can add less overhe=
ad
> >>>> when multiple xsks contend at this point. So I hope this approach
> >>>> can be adopted.
> >>>
> >>> I still think that moving the lock would be preferable, because it ma=
kes
> >>> sense also from a maintenance perspective.
> >>
> >> I can see your point here. Sure, moving the lock is relatively easier
> >> to understand. But my take is that atomic changes here are not that
> >> hard to read :) It has the same effect as spin lock because it will
> >> atomically check, compare and set in try_cmpxchg().
> >>
> >>> Can you report the difference
> >>> you measure atomics vs moving the spin lock?
> >>
> >> No problem, hopefully I will give a detailed report next week because
> >> I'm going to apply it directly in production where we have multiple
> >> xsk sharing the same umem.
> >
> > I'm done with the test in production where a few applications rely on
> > multiple xsks sharing the same pool to send UDP packets. Here are
> > significant numbers from bcc tool that recorded the latency caused by
> > these particular functions:
> >
> > 1. use spin lock
> > $ sudo ./funclatency xsk_cq_reserve_locked
> > Tracing 1 functions for "xsk_cq_reserve_locked"... Hit Ctrl-C to end.
> > ^C
> >      nsecs               : count     distribution
> >          0 -> 1          : 0        |                                  =
      |
> >          2 -> 3          : 0        |                                  =
      |
> >          4 -> 7          : 0        |                                  =
      |
> >          8 -> 15         : 0        |                                  =
      |
> >         16 -> 31         : 0        |                                  =
      |
> >         32 -> 63         : 0        |                                  =
      |
> >         64 -> 127        : 0        |                                  =
      |
> >        128 -> 255        : 25308114 |**                                =
      |
> >        256 -> 511        : 283924647 |**********************           =
       |
> >        512 -> 1023       : 501589652 |*********************************=
*******|
> >       1024 -> 2047       : 93045664 |*******                           =
      |
> >       2048 -> 4095       : 746395   |                                  =
      |
> >       4096 -> 8191       : 424053   |                                  =
      |
> >       8192 -> 16383      : 1041     |                                  =
      |
> >      16384 -> 32767      : 0        |                                  =
      |
> >      32768 -> 65535      : 0        |                                  =
      |
> >      65536 -> 131071     : 0        |                                  =
      |
> >     131072 -> 262143     : 0        |                                  =
      |
> >     262144 -> 524287     : 0        |                                  =
      |
> >     524288 -> 1048575    : 6        |                                  =
      |
> >    1048576 -> 2097151    : 2        |                                  =
      |
> >
> > avg =3D 664 nsecs, total: 601186432273 nsecs, count: 905039574
> >
> > 2. use atomic
> > $ sudo ./funclatency xsk_cq_cached_prod_reserve
> > Tracing 1 functions for "xsk_cq_cached_prod_reserve"... Hit Ctrl-C to e=
nd.
> > ^C
> >      nsecs               : count     distribution
> >          0 -> 1          : 0        |                                  =
      |
> >          2 -> 3          : 0        |                                  =
      |
> >          4 -> 7          : 0        |                                  =
      |
> >          8 -> 15         : 0        |                                  =
      |
> >         16 -> 31         : 0        |                                  =
      |
> >         32 -> 63         : 0        |                                  =
      |
> >         64 -> 127        : 0        |                                  =
      |
> >        128 -> 255        : 109815401 |*********                        =
       |
> >        256 -> 511        : 485028947 |*********************************=
*******|
> >        512 -> 1023       : 320121627 |**************************       =
       |
> >       1024 -> 2047       : 38538584 |***                               =
      |
> >       2048 -> 4095       : 377026   |                                  =
      |
> >       4096 -> 8191       : 340961   |                                  =
      |
> >       8192 -> 16383      : 549      |                                  =
      |
> >      16384 -> 32767      : 0        |                                  =
      |
> >      32768 -> 65535      : 0        |                                  =
      |
> >      65536 -> 131071     : 0        |                                  =
      |
> >     131072 -> 262143     : 0        |                                  =
      |
> >     262144 -> 524287     : 0        |                                  =
      |
> >     524288 -> 1048575    : 10       |                                  =
      |
> >
> > avg =3D 496 nsecs, total: 473682265261 nsecs, count: 954223105
> >
> > And those numbers were verified over and over again which means they
> > are quite stable.
> >
> > You can see that when using atomic, the avg is smaller and the count
> > of [128 -> 255] is larger, which shows better performance.
> >
> > I will add the above numbers in the commit log after the merge window i=
s open.
>
> It's not just a matter of performance. Spinlock additionally give you
> fairness and lockdep guarantees, beyond being easier to graps for
> however is going to touch this code in the future, while raw atomic none
> of them.
>
> From a maintainability perspective spinlocks are much more preferable.
>
> IMHO micro-benchmarking is not a strong enough argument to counter the
> spinlock adavantages: at very _least_ large performance gain should be
> observed in relevant test-cases and/or real live workloads.
>
> >>> Have you tried moving cq_prod_lock, too?
> >>
> >> Not yet, thanks for reminding me. It should not affect the sending
> >> rate but the tx completion time, I think.
> >
> > I also tried moving this lock, but sadly I noticed that in completion
> > time the lock was set which led to invalidation of the cache line of
> > another thread sending packets. It can be obviously proved by perf
> > cycles:ppp:
> > 1. before
> > 8.70% xsk_cq_cached_prod_reserve
> >
> > 2. after
> > 12.31% xsk_cq_cached_prod_reserve
> >
> > So I decided not to bring such a modification. Anyway, thanks for your
> > valuable suggestions and I learnt a lot from those interesting
> > experiments.
>
> The goal of such change would be reducing the number of touched
> cachelines; when I suggested the above, I did not dive into the producer
> specifics, I assumed the relevant producer data were inside the
> xsk_queue struct.
>
> It looks like the data is actually inside 'struct xdp_ring', so the
> producer lock should be moved there, specifically:
>
> struct xdp_ring {
>         u32 producer ____cacheline_aligned_in_smp;
>         spinlock_t producer_lock;
>         // ...

This struct is reflected to user space, so we should not put the spin
lock there. But you could put it in struct xsk_queue, but perhaps you
would want to call it something more generic as there would be a lock
present in all queues/rings, though you would only use it for the cq.
Some of the members in xsk_queue are nearly always used when
manipulating the ring, so the cache line should be hot.

I am just thinking aloud if this would be correct. There is one pool
per cq. When a pool is shared, the cq belonging to that pool is also
always shared, so I think that would be correct moving the lock from
the pool to the cq.

> I'm a bit lost in the structs indirection, but I think the above would
> be beneficial even for the ZC path.
>
> /P
>
>

