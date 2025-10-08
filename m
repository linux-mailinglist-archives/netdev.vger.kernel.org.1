Return-Path: <netdev+bounces-228190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F4154BC43EF
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 12:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA4C34E6827
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 10:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22962F531A;
	Wed,  8 Oct 2025 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1duLa1U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE902571DA
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917961; cv=none; b=mejBN4e3XUYRhpbj6aEk1iT8kHm0EtLJrfSyoCm4X3yl+c5B+tnrJwMFhN3nVQM7PPsk5PhMrdtLGJJcjSqXku6dpJUgxgBnsO6P5YdxIToyGqRx8mgE8PouFY9dmWcOvVYTkUzXjwfVZEof2eBou2VBB9e9QSRD2jeahzvIGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917961; c=relaxed/simple;
	bh=bbcMF3ayi9MGw3EQBXJczdXhnCrlry2RGgA/FoZrUfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cNMU7b5ey2WmHTZq8M8C18oIbSG5PVNrF4PYavnZh2KQTAHv34EmMncOuwjGqW2mxFGU4hhTR2Li+s276nZbxpYa2bdpl7YQ63FIB/eN1Efrb9+RuRacaRXMJqvLvGCOJifbtQKO9gFkiGmdoNc9RjgHNuS43lnITECYDLv105Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1duLa1U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759917958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQabgruqldG3+5m8qlEyfINyo5ujNcgVb/2BD4/WBhU=;
	b=B1duLa1UrS3Rpqlx0ad8kX0tRd29bhbA+E2npLia0XcxtfXV3q9tvCTKz6T1VKLqQPrvLw
	qBMl83n0mzd0vHr5oMnBpdQ/9J5OxeS5YgTQnhM/Hm8riSIT3XvI7apXHjgYi2PAtie8Xo
	OOk0zsKTXleWLypa/mRlbp/BX8xrM8k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-s5u5h_jWPfCwWZWmfyRrZg-1; Wed, 08 Oct 2025 06:05:57 -0400
X-MC-Unique: s5u5h_jWPfCwWZWmfyRrZg-1
X-Mimecast-MFC-AGG-ID: s5u5h_jWPfCwWZWmfyRrZg_1759917956
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6349af0e766so10745758a12.3
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 03:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759917956; x=1760522756;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQabgruqldG3+5m8qlEyfINyo5ujNcgVb/2BD4/WBhU=;
        b=eFjLcEI1O83XPUyLmZ3xmuxpebGO3kgdUNuJkCKLpBfXkOh/zQyh4oGaalIlJk+UwD
         w8SEBow3apEdbaJzUuPRjZ9ay0U7HqLFDzQjYJoCtpj7Dsp/K7YiyKPedmNyS3XBQmF8
         2LER8NIEo9Oep4VirGbKO6/0a5n1e4oPndDIzCfIu0Al9/34ijfzr6v71HVhfw4up7PM
         mcwR3xB1Af6B1bzc25EqALazcexbTUQhYOnZe1QhFH8/OgQ+SjbklPYyUcNh6DvczIJb
         fD4yck7Xmh4BeU0BFJi56hMGePcuuhnrqf3ug1lj/svturYlQjRZj21VEAdiicwCkbRc
         qFHg==
X-Forwarded-Encrypted: i=1; AJvYcCUouPA2MzougEJhsXT7ypk+XgLTVnLHh/IwMGz8J0+DeXonUj9lUgQTP9CSsGLQIwEXufoZpYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysy/085+Pe5sQfijR48p0fbXUAXnj/ERlQRCVsr8KCPE1aqnDf
	GAfBjQvaKLurYneZ9VNotjoW4H9uTLxFSfzi8qWJblyeCPZFRXqZKpjCqZG4eUCcX5gNgb+cLL9
	3XZeBEpnAJB+KWNMx0UHT6MNc+rxip9nEL9R0L4m0PnyugqvnjBUF46MYqA==
X-Gm-Gg: ASbGncsnhRiQe/Tsw7wmc3bfyZRV5QeJHfoOt0oKUpVPbVjILOi+xSQ0HAI8O3wVpxh
	ls+U77pVaH3u1k9RWaMDSF61IGBLN1W0g1vrlVKVQUuhDB13KO6iicn4/fQ+4nkuoVcuqHFP2Fa
	XcWjnHJpqDYvF8By4NHpEE0lm3ywcO0Hi9I5ehdhyT+No+Io0LJZK/Gznl7WrHy00sIfz5RyCmU
	dxBOTq6zLqlxDvYDV268MeYTyHmqKdpW5tntQozbSlRoLaUStWhm9gAaxgCFgkPqZS6xsQkz55e
	JewIw6x6V392uLu+3tVAclpgMOw02NXeM5WL/CHglkbNhv0O34vIpEhIdNdw6jjcNCqlGGR6
X-Received: by 2002:a05:6402:234b:b0:637:e5ce:76a9 with SMTP id 4fb4d7f45d1cf-639d5c3edb6mr2749698a12.23.1759917955453;
        Wed, 08 Oct 2025 03:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExFvmkKJ8QE6ZcAwyMZ5RmmkaSBl2gjQ9CNLBJFk8mMi+zfgZMktks19KbEgIcbWrMqKah8g==
X-Received: by 2002:a05:6402:234b:b0:637:e5ce:76a9 with SMTP id 4fb4d7f45d1cf-639d5c3edb6mr2749657a12.23.1759917954856;
        Wed, 08 Oct 2025 03:05:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788111e1dsm14272601a12.40.2025.10.08.03.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 03:05:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 306D02785A9; Wed, 08 Oct 2025 12:05:53 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki
 Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH RFC net-next 5/5] net: dev_queue_xmit() llist adoption
In-Reply-To: <CANn89iKoMHvYsvmqHB2HmCPp3H8Mmz1FwDD1XmqM6oDJS9+vTA@mail.gmail.com>
References: <20251006193103.2684156-1-edumazet@google.com>
 <20251006193103.2684156-6-edumazet@google.com> <87wm55kcdr.fsf@toke.dk>
 <CANn89iKoMHvYsvmqHB2HmCPp3H8Mmz1FwDD1XmqM6oDJS9+vTA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 08 Oct 2025 12:05:53 +0200
Message-ID: <87tt09k8se.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> On Wed, Oct 8, 2025 at 1:48=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> Eric Dumazet <edumazet@google.com> writes:
>>
>> > Remove busylock spinlock and use a lockless list (llist)
>> > to reduce spinlock contention to the minimum.
>> >
>> > Idea is that only one cpu might spin on the qdisc spinlock,
>> > while others simply add their skb in the llist.
>> >
>> > After this patch, we get a 300 % improvement on heavy TX workloads.
>> > - Sending twice the number of packets per second.
>> > - While consuming 50 % less cycles.
>> >
>> > Tested:
>> >
>> > - Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
>> > - 100Gbit NIC, 30 TX queues with FQ packet scheduler.
>> > - echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid conte=
ntion in mm)
>> > - 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"
>> >
>> > Before:
>> >
>> > 16 Mpps (41 Mpps if each thread is pinned to a different cpu)
>> >
>> > vmstat 2 5
>> > procs -----------memory---------- ---swap-- -----io---- -system-- ----=
--cpu-----
>> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us s=
y id wa st
>> > 243  0      0 2368988672  51036 1100852    0    0   146     1  242   6=
0  0  9 91  0  0
>> > 244  0      0 2368988672  51036 1100852    0    0   536    10 487745 1=
4718  0 52 48  0  0
>> > 244  0      0 2368988672  51036 1100852    0    0   512     0 503067 4=
6033  0 52 48  0  0
>> > 244  0      0 2368988672  51036 1100852    0    0   512     0 494807 1=
2107  0 52 48  0  0
>> > 244  0      0 2368988672  51036 1100852    0    0   702    26 492845 1=
0110  0 52 48  0  0
>> >
>> > Lock contention (1 second sample taken on 8 cores)
>> > perf lock record -C0-7 sleep 1; perf lock contention
>> >  contended   total wait     max wait     avg wait         type   caller
>> >
>> >     442111      6.79 s     162.47 ms     15.35 us     spinlock   dev_h=
ard_start_xmit+0xcd
>> >       5961      9.57 ms      8.12 us      1.60 us     spinlock   __dev=
_queue_xmit+0x3a0
>> >        244    560.63 us      7.63 us      2.30 us     spinlock   do_so=
ftirq+0x5b
>> >         13     25.09 us      3.21 us      1.93 us     spinlock   net_t=
x_action+0xf8
>> >
>> > If netperf threads are pinned, spinlock stress is very high.
>> > perf lock record -C0-7 sleep 1; perf lock contention
>> >  contended   total wait     max wait     avg wait         type   caller
>> >
>> >     964508      7.10 s     147.25 ms      7.36 us     spinlock   dev_h=
ard_start_xmit+0xcd
>> >        201    268.05 us      4.65 us      1.33 us     spinlock   __dev=
_queue_xmit+0x3a0
>> >         12     26.05 us      3.84 us      2.17 us     spinlock   do_so=
ftirq+0x5b
>> >
>> > @__dev_queue_xmit_ns:
>> > [256, 512)            21 |                                            =
        |
>> > [512, 1K)            631 |                                            =
        |
>> > [1K, 2K)           27328 |@                                           =
        |
>> > [2K, 4K)          265392 |@@@@@@@@@@@@@@@@                            =
        |
>> > [4K, 8K)          417543 |@@@@@@@@@@@@@@@@@@@@@@@@@@                  =
        |
>> > [8K, 16K)         826292 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@|
>> > [16K, 32K)        733822 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@      |
>> > [32K, 64K)         19055 |@                                           =
        |
>> > [64K, 128K)        17240 |@                                           =
        |
>> > [128K, 256K)       25633 |@                                           =
        |
>> > [256K, 512K)           4 |                                            =
        |
>> >
>> > After:
>> >
>> > 29 Mpps (57 Mpps if each thread is pinned to a different cpu)
>> >
>> > vmstat 2 5
>> > procs -----------memory---------- ---swap-- -----io---- -system-- ----=
--cpu-----
>> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us s=
y id wa st
>> > 78  0      0 2369573632  32896 1350988    0    0    22     0  331  254=
  0  8 92  0  0
>> > 75  0      0 2369573632  32896 1350988    0    0    22    50 425713 28=
0199  0 23 76  0  0
>> > 104  0      0 2369573632  32896 1350988    0    0   290     0 430238 2=
98247  0 23 76  0  0
>> > 86  0      0 2369573632  32896 1350988    0    0   132     0 428019 29=
1865  0 24 76  0  0
>> > 90  0      0 2369573632  32896 1350988    0    0   502     0 422498 27=
8672  0 23 76  0  0
>> >
>> > perf lock record -C0-7 sleep 1; perf lock contention
>> >  contended   total wait     max wait     avg wait         type   caller
>> >
>> >       2524    116.15 ms    486.61 us     46.02 us     spinlock   __dev=
_queue_xmit+0x55b
>> >       5821    107.18 ms    371.67 us     18.41 us     spinlock   dev_h=
ard_start_xmit+0xcd
>> >       2377      9.73 ms     35.86 us      4.09 us     spinlock   ___sl=
ab_alloc+0x4e0
>> >        923      5.74 ms     20.91 us      6.22 us     spinlock   ___sl=
ab_alloc+0x5c9
>> >        121      3.42 ms    193.05 us     28.24 us     spinlock   net_t=
x_action+0xf8
>> >          6    564.33 us    167.60 us     94.05 us     spinlock   do_so=
ftirq+0x5b
>> >
>> > If netperf threads are pinned (~54 Mpps)
>> > perf lock record -C0-7 sleep 1; perf lock contention
>> >      32907    316.98 ms    195.98 us      9.63 us     spinlock   dev_h=
ard_start_xmit+0xcd
>> >       4507     61.83 ms    212.73 us     13.72 us     spinlock   __dev=
_queue_xmit+0x554
>> >       2781     23.53 ms     40.03 us      8.46 us     spinlock   ___sl=
ab_alloc+0x5c9
>> >       3554     18.94 ms     34.69 us      5.33 us     spinlock   ___sl=
ab_alloc+0x4e0
>> >        233      9.09 ms    215.70 us     38.99 us     spinlock   do_so=
ftirq+0x5b
>> >        153    930.66 us     48.67 us      6.08 us     spinlock   net_t=
x_action+0xfd
>> >         84    331.10 us     14.22 us      3.94 us     spinlock   ___sl=
ab_alloc+0x5c9
>> >        140    323.71 us      9.94 us      2.31 us     spinlock   ___sl=
ab_alloc+0x4e0
>> >
>> > @__dev_queue_xmit_ns:
>> > [128, 256)       1539830 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          =
        |
>> > [256, 512)       2299558 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@|
>> > [512, 1K)         483936 |@@@@@@@@@@                                  =
        |
>> > [1K, 2K)          265345 |@@@@@@                                      =
        |
>> > [2K, 4K)          145463 |@@@                                         =
        |
>> > [4K, 8K)           54571 |@                                           =
        |
>> > [8K, 16K)          10270 |                                            =
        |
>> > [16K, 32K)          9385 |                                            =
        |
>> > [32K, 64K)          7749 |                                            =
        |
>> > [64K, 128K)        26799 |                                            =
        |
>> > [128K, 256K)        2665 |                                            =
        |
>> > [256K, 512K)         665 |                                            =
        |
>> >
>> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>>
>> This is very cool! One question below, just to make sure I understand
>> this correctly:
>>
>> > ---
>> >  include/net/sch_generic.h |  4 +-
>> >  net/core/dev.c            | 85 ++++++++++++++++++++++-----------------
>> >  net/sched/sch_generic.c   |  5 ---
>> >  3 files changed, 52 insertions(+), 42 deletions(-)
>> >
>> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>> > index 31561291bc92fd70d4d3ca8f5f7dbc4c94c895a0..94966692ccdf51db085c23=
6319705aecba8c30cf 100644
>> > --- a/include/net/sch_generic.h
>> > +++ b/include/net/sch_generic.h
>> > @@ -115,7 +115,9 @@ struct Qdisc {
>> >       struct Qdisc            *next_sched;
>> >       struct sk_buff_head     skb_bad_txq;
>> >
>> > -     spinlock_t              busylock ____cacheline_aligned_in_smp;
>> > +     atomic_long_t           defer_count ____cacheline_aligned_in_smp;
>> > +     struct llist_head       defer_list;
>> > +
>> >       spinlock_t              seqlock;
>> >
>> >       struct rcu_head         rcu;
>> > diff --git a/net/core/dev.c b/net/core/dev.c
>> > index 0ff178399b2d28ca2754b3f06d69a97f5d6dcf71..6094768bf3c028f0ad1e52=
b9b12b7258fa0ecff6 100644
>> > --- a/net/core/dev.c
>> > +++ b/net/core/dev.c
>> > @@ -4125,9 +4125,10 @@ static inline int __dev_xmit_skb(struct sk_buff=
 *skb, struct Qdisc *q,
>> >                                struct net_device *dev,
>> >                                struct netdev_queue *txq)
>> >  {
>> > +     struct sk_buff *next, *to_free =3D NULL;
>> >       spinlock_t *root_lock =3D qdisc_lock(q);
>> > -     struct sk_buff *to_free =3D NULL;
>> > -     bool contended;
>> > +     struct llist_node *ll_list, *first_n;
>> > +     unsigned long defer_count =3D 0;
>> >       int rc;
>> >
>> >       qdisc_calculate_pkt_len(skb, q);
>> > @@ -4167,61 +4168,73 @@ static inline int __dev_xmit_skb(struct sk_buf=
f *skb, struct Qdisc *q,
>> >               return rc;
>> >       }
>> >
>> > -     /*
>> > -      * Heuristic to force contended enqueues to serialize on a
>> > -      * separate lock before trying to get qdisc main lock.
>> > -      * This permits qdisc->running owner to get the lock more
>> > -      * often and dequeue packets faster.
>> > -      * On PREEMPT_RT it is possible to preempt the qdisc owner durin=
g xmit
>> > -      * and then other tasks will only enqueue packets. The packets w=
ill be
>> > -      * sent after the qdisc owner is scheduled again. To prevent this
>> > -      * scenario the task always serialize on the lock.
>> > +     /* Open code llist_add(&skb->ll_node, &q->defer_list) + queue li=
mit.
>> > +      * In the try_cmpxchg() loop, we want to increment q->defer_count
>> > +      * at most once to limit the number of skbs in defer_list.
>> > +      * We perform the defer_count increment only if the list is not =
empty,
>> > +      * because some arches have slow atomic_long_inc_return().
>> > +      */
>> > +     first_n =3D READ_ONCE(q->defer_list.first);
>> > +     do {
>> > +             if (first_n && !defer_count) {
>> > +                     defer_count =3D atomic_long_inc_return(&q->defer=
_count);
>> > +                     if (unlikely(defer_count > q->limit)) {
>> > +                             kfree_skb_reason(skb, SKB_DROP_REASON_QD=
ISC_DROP);
>> > +                             return NET_XMIT_DROP;
>> > +                     }
>> > +             }
>> > +             skb->ll_node.next =3D first_n;
>> > +     } while (!try_cmpxchg(&q->defer_list.first, &first_n, &skb->ll_n=
ode));
>> > +
>> > +     /* If defer_list was not empty, we know the cpu which queued
>> > +      * the first skb will process the whole list for us.
>> >        */
>> > -     contended =3D qdisc_is_running(q) || IS_ENABLED(CONFIG_PREEMPT_R=
T);
>> > -     if (unlikely(contended))
>> > -             spin_lock(&q->busylock);
>> > +     if (first_n)
>> > +             return NET_XMIT_SUCCESS;
>> >
>> >       spin_lock(root_lock);
>> > +
>> > +     ll_list =3D llist_del_all(&q->defer_list);
>> > +     /* There is a small race because we clear defer_count not atomic=
ally
>> > +      * with the prior llist_del_all(). This means defer_list could g=
row
>> > +      * over q->limit.
>> > +      */
>> > +     atomic_long_set(&q->defer_count, 0);
>> > +
>> > +     ll_list =3D llist_reverse_order(ll_list);
>> > +
>> >       if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
>> > -             __qdisc_drop(skb, &to_free);
>> > +             llist_for_each_entry_safe(skb, next, ll_list, ll_node)
>> > +                     __qdisc_drop(skb, &to_free);
>> >               rc =3D NET_XMIT_DROP;
>> > -     } else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
>> > -                qdisc_run_begin(q)) {
>> > +             goto unlock;
>> > +     }
>> > +     rc =3D NET_XMIT_SUCCESS;
>> > +     if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
>> > +         !llist_next(ll_list) && qdisc_run_begin(q)) {
>> >               /*
>> >                * This is a work-conserving queue; there are no old skbs
>> >                * waiting to be sent out; and the qdisc is not running -
>> >                * xmit the skb directly.
>> >                */
>> >
>> > +             skb =3D llist_entry(ll_list, struct sk_buff, ll_node);
>>
>> I was puzzled by this^. But AFAICT, the idea is that in the
>> non-contended path we're in here (no other CPU enqueueing packets), we
>> will still have added the skb to the llist before taking the root_lock,
>> and here we pull it back off the list, right?
>>
>> Even though this is technically not needed (we'll always get the same
>> skb back, I think?), so this is mostly for consistency(?)
>
> Exactly. I guess we could instead add an assert like
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1a0baedc4f39e17efd21b0e48a7373a394bcbfa6..4f0e448558a6d2c070d93c474=
698d904d0b864f6
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4135,7 +4135,7 @@ static inline int __dev_xmit_skb(struct sk_buff
> *skb, struct Qdisc *q,
>                  * xmit the skb directly.
>                  */
>
> -               skb =3D llist_entry(ll_list, struct sk_buff, ll_node);
> +               DEBUG_NET_WARN_ON_ONCE(skb !=3D llist_entry(ll_list,
> struct sk_buff, ll_node));
>                 qdisc_bstats_update(q, skb);
>                 if (sch_direct_xmit(skb, q, dev, txq, root_lock, true))
>                         __qdisc_run(q);

OK, so thinking about this some more, isn't there a race between the

	if (first_n)
		return NET_XMIT_SUCCESS;

and taking the lock? I.e., two different CPUs can pass that check in
which case one of them will end up spinning on the lock, and by the time
it acquires it, there is no longer any guarantee that the skb on the
llist will be the same one that we started with? Or indeed that there
will be any skbs on the list at all?

In which case, shouldn't there be a:

if (unlikely(llist_empty(ll_list)))
	goto unlock;

after the llist_del_all() assignment inside the lock? (and we should
retain the skb =3D llist_entry()) assignment I was confused about).

Or am I missing some reason this can't happen?

-Toke


