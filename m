Return-Path: <netdev+bounces-127085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF479740E2
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685EB1F20ECB
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2B91A2643;
	Tue, 10 Sep 2024 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XP/8b/gd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AB19F464
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990096; cv=none; b=PcPqX8yXZE+YF9QsvLs+JntXNIWKePlEXJTFbrfZLZbVyMjPfsA3VTUjqc5Lg7Fv8BMUyOUHn2ieqGXCEBoeGJPSJKFkqTvSk61y9occ1VSMTMVV6gEJfj1pHbSI1clkgPNd2CEivI2slx2j2At80jem86HVl+D5WzzMAXqCwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990096; c=relaxed/simple;
	bh=dEHostxgrUQTfxhASbmMT98RPp6Eme+25p7K7TP/C9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFA5MeSytry94ohuA88i8Pg7jY3Q1bLe2l2EaUR5yvGYFxDcuf8JlfgE4/HXLnyI98n8G4/l0+FaV/E0KxfGDOXn8ROw3Phrn1iXjEz11SWXAYmBnToXaqb2Wc52BDtazicJcHivCKV/eoGQcGowTuiyBHMh0eBPTFnr42Xgz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XP/8b/gd; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5356a2460ceso30825e87.0
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 10:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725990093; x=1726594893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRvd6+FNEyRgwBjwqh7XCajCi24Jftv3RTG3UBcZB0o=;
        b=XP/8b/gdr9qyo119ZJd7yZQOxAJT1E6z9FItz4twBeIUGLqO68bMMc21dL3ASCpeVy
         WkZyVoFABON0GfrgU1ZI9rNq72Pb/Cn/Rm511gPQQhPbHnhCyNYfocwJfJU3SvNsn13C
         sGprounW+ls1TeBXa5pWi41oB+9zpGpKdASGaaQ14R6b2IW27gulGVlMJCuKb4JGqLxA
         pvRfCEpa4B48Bx9ctEmPk6TMnpmfTrnmzE2MwPtCCb0Y+aPmhRWnRodDJrnmnfasK6Jl
         Mwt5ytXYNGtPQ5HNKwRqgKdkN/8YdF4w9JWivzrc73xnjtYRYFjQv++rrgvp/wyqZONA
         WwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990093; x=1726594893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRvd6+FNEyRgwBjwqh7XCajCi24Jftv3RTG3UBcZB0o=;
        b=En9JPpZAoSMDyvRL1Slixg9Afx1KNLw8RW5MRr0+aDloT1XcEt8FvsN1NtSX2a/IU1
         zOY1FCnk5SJj5XOHVfLor1M08lMbOfDvQHLFtjI0xGjcAd0tDIwqv/E/SREFmXVhNN4Y
         pSJEAQVHO/OzqAZ5CeDKj6WCDUvEv6+pv6AerH6zlH5xA7WwQcgKAoxlnQH7frf366Ii
         kYbSI6DDyuCWYJwGeu1pDCN03/JvzIrg4iykl7To0b7zshrLHY8wz/iGz5v5zFF44W0o
         +BaGq8ujULipnLeCVwyEdwFsNpj20LwvJBBk7oczkdXb7UQsXrC8lnvmimPRudZNHn+L
         o30g==
X-Forwarded-Encrypted: i=1; AJvYcCWz51m/aCPTNozutv90f6UPOalxCtRO7eDv+dVD+yb6hmkRXhxzTsaC063BBkMJOvni7/E3cbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxikG6IlwqenckCkX+oI855ZZpqrOSLLSvnmdJNhTi7mPWobiDW
	K9N0A8G33A6OAGpSMl8tmjUq6aHpS17tHcj/mDTtxkowj9F72TZNgdDmfGeTzp1vWhCxBc4UVyI
	UJ4ONy/LKsUEDlCxARDqomrqSJch0bp0lSF+Y
X-Google-Smtp-Source: AGHT+IGmqjEsD+ZSK7Kq99lDy9iP1P9BexIFvYcppz62nH2Sql+mSbRPQjG2dYpHE6+f8ABvXv/fJnLDamZfLogRKw8=
X-Received: by 2002:a05:6512:b85:b0:535:68b2:9589 with SMTP id
 2adb3069b0e04-5367431fdeemr16812e87.2.1725990092431; Tue, 10 Sep 2024
 10:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828181011.1591242-1-namangulati@google.com>
 <ZtBQLqqMrpCLBMw1@LQ3V64L9R2> <CAMP57yW99Y+CS+h_bayj_hBfoGQE+bdfVHuwfHZ3q+KueTS+iw@mail.gmail.com>
 <30ddb66a-aeea-480d-bf79-38fc06ea45b0@uwaterloo.ca>
In-Reply-To: <30ddb66a-aeea-480d-bf79-38fc06ea45b0@uwaterloo.ca>
From: Naman Gulati <namangulati@google.com>
Date: Tue, 10 Sep 2024 10:41:21 -0700
Message-ID: <CAMP57yWQGKnHcn3gkPvz1bvPO=+VTvyMJ5OHZpp=WYX=CBhZvA@mail.gmail.com>
Subject: Re: [PATCH] Add provision to busyloop for events in ep_poll.
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Joe Damato <jdamato@fastly.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, skhawaja@google.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 5:46=E2=80=AFAM Martin Karsten <mkarsten@uwaterloo.c=
a> wrote:
>
> On 2024-09-04 01:52, Naman Gulati wrote:
> > Thanks all for the comments and apologies for the delay in replying.
> > Stan and Joe I=E2=80=99ve addressed some of the common concerns below.
> >
> > On Thu, Aug 29, 2024 at 3:40=E2=80=AFAM Joe Damato <jdamato@fastly.com>=
 wrote:
> >>
> >> On Wed, Aug 28, 2024 at 06:10:11PM +0000, Naman Gulati wrote:
> >>> NAPI busypolling in ep_busy_loop loops on napi_poll and checks for ne=
w
> >>> epoll events after every napi poll. Checking just for epoll events in=
 a
> >>> tight loop in the kernel context delivers latency gains to applicatio=
ns
> >>> that are not interested in napi busypolling with epoll.
> >>>
> >>> This patch adds an option to loop just for new events inside
> >>> ep_busy_loop, guarded by the EPIOCSPARAMS ioctl that controls epoll n=
api
> >>> busypolling.
> >>
> >> This makes an API change, so I think that linux-api@vger.kernel.org
> >> needs to be CC'd ?
> >>
> >>> A comparison with neper tcp_rr shows that busylooping for events in
> >>> epoll_wait boosted throughput by ~3-7% and reduced median latency by
> >>> ~10%.
> >>>
> >>> To demonstrate the latency and throughput improvements, a comparison =
was
> >>> made of neper tcp_rr running with:
> >>>      1. (baseline) No busylooping
> >>
> >> Is there NAPI-based steering to threads via SO_INCOMING_NAPI_ID in
> >> this case? More details, please, on locality. If there is no
> >> NAPI-based flow steering in this case, perhaps the improvements you
> >> are seeing are a result of both syscall overhead avoidance and data
> >> locality?
> >>
> >
> > The benchmarks were run with no NAPI steering.
> >
> > Regarding syscall overhead, I reproduced the above experiment with
> > mitigations=3Doff
> > and found similar results as above. Pointing to the fact that the
> > above gains are
> > materialized from more than just avoiding syscall overhead.
>
> I suppose the natural follow-up questions are:
>
> 1) Where do the gains come from? and
>
> 2) Would they materialize with a realistic application?
>
> System calls have some overhead even with mitigations=3Doff. In fact I
> understand on modern CPUs security mitigations are not that expensive to
> begin with? In a micro-benchmark that does nothing else but bouncing
> packets back and forth, this overhead might look more significant than
> in a realistic application?
>
> It seems your change does not eliminate any processing from each
> packet's path, but instead eliminates processing in between packet
> arrivals? This might lead to a small latency improvement, which might
> turn into a small throughput improvement in these micro-benchmarks, but
> that might quickly evaporate when an application has actual work to do
> in between packet arrivals.

This is a good point, and I was able to confirm this. I profiled the
changes in the
patch by fixing the number of threads and flows but scaling message sizes w=
ith
tcp_rr, using the notion that creating and processing large messages in tcp=
_rr
would take more time. As the message size increases from 1 B to MSS (4KB
in my setup), I found that the difference in latency and throughput diminis=
hes
between looping inside epoll vs looping on nonblocking epoll_wait in usersp=
ace.

Understandably, as the message sizes increase the application becomes the
bottleneck and the syscall overhead becomes marginal to the whole cost of t=
he
operation.

I also found that looping inside epoll yields latency and throughput
improvements again when message sizes increase past MSS. I believe this can
be rationalized as the cost of processing the packet in the application is =
then
amortized over the multiple transmitted segments and the system call overhe=
ad
becomes more prominent again.

This is some rough data showing the above
Setup: 5 threads on both client and server, 30 flows, mitigations=3Doff,
both server
and client using the same request/response size

Looping inside epoll:
Message Size  Throughput  Latency P50  Latency P90  Latency P99  Latency P9=
9.9
 1 B                   543971         57                 76
      93                  106
 250 B               501245         60                 77
    97                  109
 500 B               494467         60                 77
    93                  111
 1 KB                 486412         60                 77
     97                  114
 2 KB                 385125         77                 96
     114                123
 4 KB                 378612         78                 97
     119                129
 8 KB                 349214         83                109
    125                137
 16 KB               379276         156               202
  243                274
Looping in userspace:
Message Size  Throughput  Latency P50  Latency P90  Latency P99  Latency P9=
9.9
 1 B                   496296         59                 76
      95                   109
 250 B               468840         67                 77
    97                   111
 500 B               476804         61                 78
    97                   110
 1 KB                 464273         65                 79
    100                  115
 2 KB                 388334         76                 97
    114                  122
 4 KB                 377851         79                 98
    118                  124
 8 KB                 333718         91                115
   128                  141
 16 KB               354708         157               253
 307                  343

I also examined the perf traces for both looping setups and compared the
overhead delta between the invocation of epoll_wait in glibc and the invoca=
tion
of do_epoll_wait in the kernel to measure just the overhead of calling the
system call. With 1 B messages, looping in userspace had a higher overhead
in CPU cycles for invoking the syscall compared to looping inside epoll, ho=
wever
the overhead gap also shrinks as the message sizes increase and the syscall
overhead becomes increasingly marginal.

I believe testing with a benchmark like memcached and using napi steering
would confirm the same results, and I recognize now that most regular workl=
oads
won=E2=80=99t benefit from this patch.

>
> It would be good to know a little more about your experiments. You are
> referring to 5 threads, but does that mean 5 cores were busy on both
> client and server during the experiment? Which of client or server is
> the bottleneck? In your baseline experiment, are all 5 server cores
> busy? How many RX queues are in play and how is interrupt routing
> configured?

Apologies, should have been clearer in the description. The server and clie=
nt
were both using 5 threads to handle the connections without any CPU pinning=
.
I did however confirm that all threads used distinct cores from
scheduling traces
and there was no contention.
Both hosts had 32 queues with a napi instance per queue.

>
> Thanks,
> Martin
>
>

Given the above analysis it doesn=E2=80=99t make sense adding the extra kno=
bs to the
epoll interface for an optimization that's not widely applicable, therefore=
 this
patch can be considered as not needed.
Nonetheless, appreciate the feedback Joe and Martin.

