Return-Path: <netdev+bounces-243364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D95C9DFD8
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 07:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 134F54E0732
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 06:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D6A298CD5;
	Wed,  3 Dec 2025 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ44NscF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5E287245
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745041; cv=none; b=eT5hUbOlYDTEN5h+N5RJ6ajnU2VjC+QHYUPs8t3yr9ATXEVQQ9gto7gJ/Q4DNwS+f/n9YzJc3MkqKJc0eDZLMa845qI5Ev1DCLufnFjrZ6sUsbfII50gElvR4hACmAGt48l2uO/XQ/uJGKwQr9LGgSGLOZQDrs8v85wGeKS25/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745041; c=relaxed/simple;
	bh=XoirmMsIbUrnKVY219fDurnSiihr2y22Pj2lChd1308=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjB/KNGmtX+HPKDUyH+4ETxRUFAxT242BGMG0dnhOQpX8aOcq8oey2xTCmCD63SLEVKS5tXI+ytf/hJCgV4NK8p2Kq+w6M+MeNHKtVbrZT2oeuwLp82/BYK1xsMGvLRiaivLOJ/yS0cT+Q3FwAcLaA55awEWdLZZ9TVMBfyycqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ44NscF; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4511f736011so447483b6e.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 22:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764745039; x=1765349839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3ZaO7ityhgj467PTqGix8dihueLNbeOXZ/q7xCtxgk=;
        b=KZ44NscFv/WpVGaokybEg94XL0dEurcdBS0zwYnX36Kt21k88UHl6FzznHgydmtdHi
         WnLpsT+n5mFvNTsLcIancJaB6AX2dWiU3PDvWNpUQAONbrmlakB4ylEDv5fcZa2WpFdI
         oqSBEbxfdq57lMYFbMLdd06wUUxnuWkZ9sEektQ6+yfa1jS+4CG0iF1Hrrd/MYRwClpM
         qmok/gvZ0DaXjVrDFMqdvavrExvcpQ+9+/Gm6lsCpap6F5ukde1OImIov97mOYLJRjF7
         a3S0M0fAj3KEfliFg1EFCImFo8+vZgWoIkLQxse0tzcRRAVZ1yD43tsOACC52sI0lv3K
         M5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764745039; x=1765349839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+3ZaO7ityhgj467PTqGix8dihueLNbeOXZ/q7xCtxgk=;
        b=Egc36Inuoo/1l8A4YApKlVAX7/OatcJEAO2cBFf73SLIx/w4Ag1gFhCBJOtCdyWcob
         qkIEp17CDm3ZWonTo+BUHCqYxGOHQnp6+Kw4xj54GoMIjMKYZ+demeLotvRUSFxnrElS
         sViWnXfuoU5s4QFdZQVt/WeJs/hbqSh0k+Es5wHGn3veLvcDoqMY+g/RKotAUfE4/P7B
         /NX7PedMI3ZOGfLd9s0/0UvNT2ejc64QNAVr6RmrntIL15yiYYMygO1XjnSETl3DCWH+
         eS1ZiAV9AmmmSRoA/bPxhRWBtsHbBUqhH6DWUaguOK1UKAKYO3F0dCFccJxT8TaX3+yW
         EhQg==
X-Forwarded-Encrypted: i=1; AJvYcCWad4vV0Gjtg6mOHhNoRbmIzn3Ch0Jih/6gccEQx4jUmLxqVGe+SzGXRwkD+Lt2lJ5k/JL50FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfKgfXFXX8+n8kJtxGHET4WTFiEgMOV7UkMBu2NZWvA22WagZA
	H3lVTLV4zn3R6+ALIm2XRJ1Al4YGhw9+nMHMjazfcsExBPWhsnxxp42LVBc4ivZmquLb8jhNQQz
	4FRRgDgjT7P10CZvkmyKutIz41jpfysM=
X-Gm-Gg: ASbGncvVD3W/OpQfrxkJGB+S6emfFjIMdHbV8jiIvTxpCT3Wt7ZjL/D6c2ktExrnGt+
	5VJ4W3HN8UrgBH4qpvwF8Ha90acCmPCABBqDhTz0HiOBnuo8gJrStDGfH2iZl9o2dwy1zQFQ9ZR
	/TOoj+BEFuFmzeG+wtNmJ0bdT73w+ZYnYExbs2wyq9LDJfZt4thobBGhPQouMMvvIZdYkxKDDzx
	Ij5FwhBEP2C9yMIOYMSZlzIhETlOuaB6yBT5ROtW1fzLPRCwFdRwZDzH03Sg6Sh5Z6yyADMAx/d
	COST
X-Google-Smtp-Source: AGHT+IF3IfvypgUYGurMUCaHCYmA1wnqVLE+RKKdBUhWPmOdQLu/7KjC7A+Ywh7iqoKtRPMWrxltCg9QQ1Sb4HUoROg=
X-Received: by 2002:a05:6808:1393:b0:450:bc8e:cfcd with SMTP id
 5614622812f47-4535d2bab08mr3425962b6e.4.1764745038563; Tue, 02 Dec 2025
 22:57:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128134601.54678-1-kerneljasonxing@gmail.com>
 <20251128134601.54678-3-kerneljasonxing@gmail.com> <8fa70565-0f4a-4a73-a464-5530b2e29fa5@redhat.com>
 <CAL+tcoDk0f+p2mRV=2auuYfTLA-cPPe-1az7NfEnw+FFaPR5kA@mail.gmail.com>
In-Reply-To: <CAL+tcoDk0f+p2mRV=2auuYfTLA-cPPe-1az7NfEnw+FFaPR5kA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 3 Dec 2025 14:56:42 +0800
X-Gm-Features: AWmQ_bmz_RmDu8NKfFourl8O0AeCenJ_Jlz81wp6nL9V0Inc5hsglqP6YpwY3x0
Message-ID: <CAL+tcoBMRdMevWCS1puVD4zEDt+69S6t2r6Ov8tw7zhgq_n=PA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Sat, Nov 29, 2025 at 8:55=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Nov 28, 2025 at 10:20=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > On 11/28/25 2:46 PM, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Use atomic_try_cmpxchg operations to replace spin lock. Technically
> > > CAS (Compare And Swap) is better than a coarse way like spin-lock
> > > especially when we only need to perform a few simple operations.
> > > Similar idea can also be found in the recent commit 100dfa74cad9
> > > ("net: dev_queue_xmit() llist adoption") that implements the lockless
> > > logic with the help of try_cmpxchg.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > Paolo, sorry that I didn't try to move the lock to struct xsk_queue
> > > because after investigation I reckon try_cmpxchg can add less overhea=
d
> > > when multiple xsks contend at this point. So I hope this approach
> > > can be adopted.
> >
> > I still think that moving the lock would be preferable, because it make=
s
> > sense also from a maintenance perspective.
>
> I can see your point here. Sure, moving the lock is relatively easier
> to understand. But my take is that atomic changes here are not that
> hard to read :) It has the same effect as spin lock because it will
> atomically check, compare and set in try_cmpxchg().
>
> > Can you report the difference
> > you measure atomics vs moving the spin lock?
>
> No problem, hopefully I will give a detailed report next week because
> I'm going to apply it directly in production where we have multiple
> xsk sharing the same umem.

I'm done with the test in production where a few applications rely on
multiple xsks sharing the same pool to send UDP packets. Here are
significant numbers from bcc tool that recorded the latency caused by
these particular functions:

1. use spin lock
$ sudo ./funclatency xsk_cq_reserve_locked
Tracing 1 functions for "xsk_cq_reserve_locked"... Hit Ctrl-C to end.
^C
     nsecs               : count     distribution
         0 -> 1          : 0        |                                      =
  |
         2 -> 3          : 0        |                                      =
  |
         4 -> 7          : 0        |                                      =
  |
         8 -> 15         : 0        |                                      =
  |
        16 -> 31         : 0        |                                      =
  |
        32 -> 63         : 0        |                                      =
  |
        64 -> 127        : 0        |                                      =
  |
       128 -> 255        : 25308114 |**                                    =
  |
       256 -> 511        : 283924647 |**********************               =
   |
       512 -> 1023       : 501589652 |*************************************=
***|
      1024 -> 2047       : 93045664 |*******                               =
  |
      2048 -> 4095       : 746395   |                                      =
  |
      4096 -> 8191       : 424053   |                                      =
  |
      8192 -> 16383      : 1041     |                                      =
  |
     16384 -> 32767      : 0        |                                      =
  |
     32768 -> 65535      : 0        |                                      =
  |
     65536 -> 131071     : 0        |                                      =
  |
    131072 -> 262143     : 0        |                                      =
  |
    262144 -> 524287     : 0        |                                      =
  |
    524288 -> 1048575    : 6        |                                      =
  |
   1048576 -> 2097151    : 2        |                                      =
  |

avg =3D 664 nsecs, total: 601186432273 nsecs, count: 905039574

2. use atomic
$ sudo ./funclatency xsk_cq_cached_prod_reserve
Tracing 1 functions for "xsk_cq_cached_prod_reserve"... Hit Ctrl-C to end.
^C
     nsecs               : count     distribution
         0 -> 1          : 0        |                                      =
  |
         2 -> 3          : 0        |                                      =
  |
         4 -> 7          : 0        |                                      =
  |
         8 -> 15         : 0        |                                      =
  |
        16 -> 31         : 0        |                                      =
  |
        32 -> 63         : 0        |                                      =
  |
        64 -> 127        : 0        |                                      =
  |
       128 -> 255        : 109815401 |*********                            =
   |
       256 -> 511        : 485028947 |*************************************=
***|
       512 -> 1023       : 320121627 |**************************           =
   |
      1024 -> 2047       : 38538584 |***                                   =
  |
      2048 -> 4095       : 377026   |                                      =
  |
      4096 -> 8191       : 340961   |                                      =
  |
      8192 -> 16383      : 549      |                                      =
  |
     16384 -> 32767      : 0        |                                      =
  |
     32768 -> 65535      : 0        |                                      =
  |
     65536 -> 131071     : 0        |                                      =
  |
    131072 -> 262143     : 0        |                                      =
  |
    262144 -> 524287     : 0        |                                      =
  |
    524288 -> 1048575    : 10       |                                      =
  |

avg =3D 496 nsecs, total: 473682265261 nsecs, count: 954223105

And those numbers were verified over and over again which means they
are quite stable.

You can see that when using atomic, the avg is smaller and the count
of [128 -> 255] is larger, which shows better performance.

I will add the above numbers in the commit log after the merge window is op=
en.

>
> IMHO, in theory, atomics is way better than spin lock in contended
> cases since the protected area is small and fast.

I also spent time investigating the details of both approaches. Spin
lock uses something like atomic_try_cmpxchg first and then fallbacks
to slow path. That is more complicated than atomic. And the protected
area is small enough and simple calculations don't bother asking one
thread to set a few things and then wait.

>
> >
> > Have you tried moving cq_prod_lock, too?
>
> Not yet, thanks for reminding me. It should not affect the sending
> rate but the tx completion time, I think.

I also tried moving this lock, but sadly I noticed that in completion
time the lock was set which led to invalidation of the cache line of
another thread sending packets. It can be obviously proved by perf
cycles:ppp:
1. before
8.70% xsk_cq_cached_prod_reserve

2. after
12.31% xsk_cq_cached_prod_reserve

So I decided not to bring such a modification. Anyway, thanks for your
valuable suggestions and I learnt a lot from those interesting
experiments.

Thanks,
Jason

