Return-Path: <netdev+bounces-228189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8BFBC429C
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 11:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8D34019EA
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB4D253944;
	Wed,  8 Oct 2025 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpsWx3Kz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766401FA178
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759915944; cv=none; b=KVmXtexuOrGQDcr3TV2DuGlywnZAOATiHobd7W9uMgRKXdaFVpeQACoOCVmcw1BWHw9vzXKYxxBTFyQ42uD58t9fTW+pI+XfrdPjOCIGro8LDAVhTA3VgJmeFRrftXExNLNJq8qv2FUsYgF5q0L2yKs8MURm1zpu5fsiPuFOM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759915944; c=relaxed/simple;
	bh=kcFRFnHiUfvJX6QCeslSVI/T46LiSXCYIgI25Avz64o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeDKMh8WVWaPDegbBaiDcpUyIigL8wGogmXKMZj/Oew960OdNcbA17+RiN7PbYn0hhHzxRUpd/0O+2CanBmdi8nVc+Ca1Eg3Ph0FWKzRIV9HJDdQAV4CJi1VqRA6QXY8F5Kb/t7cgTukaWYKgxXi6JgHM/S12I78i4iFnsFACVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jpsWx3Kz; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4de659d5a06so41630331cf.3
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759915941; x=1760520741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+Y1XChxuptDnax8MB4hbUIAk+N+4IH/76HoX35e/Y0=;
        b=jpsWx3KzaIK/6pHYtvC8kPdnmsupyF/xb017KdezTH1sq8MzMn8qG5SGyINby1bWD+
         j1rdqEVStmWISnsdhZqSZVP5XL/ciyXVnmpVLDwceWj0SeBZnrbNH9OJNsNuXwGgKrly
         8S9Nud2ZkUA9cPJuWwyOfoUrsw3onuUlv4AMzk/eERZkFHlz5mz19Z5Bt+gHU/YV5HFs
         adQVoiAbJ0erQsGKNkkczeNl3Q1w0CeqtyYfVODyqd8A/2agVlusV66H+9Q8vYEZrysT
         yb3+/7oF21lI4UJ6KF8aFZV5k8XcMo5Lsh1P+bgfW3Erlo3oR61Z0NzndHbldjbW2HAR
         9IEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759915941; x=1760520741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+Y1XChxuptDnax8MB4hbUIAk+N+4IH/76HoX35e/Y0=;
        b=PEbE0zIZgYEkOeqHuGKvLJ8OJAW3Ei3BfBkDHGeg6XNB+s1B40rpH+MawFc4Ys3knX
         jdjogEvReSDVYkdIkq99nRqiNJmNlHi02WZwb55l22nmrR2C+qvCTAgJc4YW3Rar9kzP
         LXH7lwgjWdMCKdYtbMZD26pRlQt9lDDmun3xOUmVualbjMag6C9abdOTI196v6wvZaLA
         zaUrcm8skBM1B6Ogo3qw8x29hvGKMEGyWrGomP+971mmgX9pbE1cCQsdCjvdqwm57SpT
         30TpdolVU3CAO44aL0Hc5pNpWaASUuREVhWBOym0HGn2zLjHpfYhM3erlZn5ZZR4o7Qw
         BsXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoJ3sUrjx5SPKQAala3AQau3uH0wW/5l416y1vrOE6tAyo+/Ov+yoN42fA1Y/8373ECMmA3j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaduxcnKBQlLP1SHnndxfh6HZ4HQKkrRAJpltlihgyib4GXYBS
	aDzQtQTmIytxVnter/tQcT7xB1PaSGbZEWtsga9e9wfoYgz4FJFz7QqtuM8L4O5zGXcyDz0NDxu
	5oMzQXDiiz849rRlgMGOOb4yO0nP3PLTlVdaI40Em
X-Gm-Gg: ASbGncs41+0LAL4w9y3Xhfi3ev+IZMOFJhC5NY+hawG1oq6lQQNWMDJUVoO+iZlxueK
	ceU0AcTFZK5ySjinFvxnH+ytk1Ati4slDlFtpsT4csPzlJc6Rgo8Qu4XeBmbbIkn9N80RrHAvZX
	Z2rl83zsPkWqrALG4+hwL15t8U6gilYp/tO6ERkoi/bWmXMpOfYcU1KxKg1Q02e0+8mZCf42k92
	yutAgcZZjT4QwCvkpdzLnmTtEsA28lvaHj3PfIP/MHKWnwYggwh5FupRqmwgr51SrKHMW/U
X-Google-Smtp-Source: AGHT+IG5X3U2zlRtOstucgK/C8iF9L9Kvov4l8/b/oevjI5iFUITSn3ejIUG+0zjaAvgLorAV6PVgoC9LUi6tlx7Bu4=
X-Received: by 2002:a05:622a:c6:b0:4d9:5ce:3746 with SMTP id
 d75a77b69052e-4e6ead57fadmr36479631cf.46.1759915940791; Wed, 08 Oct 2025
 02:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com> <20251006193103.2684156-6-edumazet@google.com>
 <87wm55kcdr.fsf@toke.dk>
In-Reply-To: <87wm55kcdr.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Oct 2025 02:32:09 -0700
X-Gm-Features: AS18NWDI6uXLKY4mw6C9TjpbR7gS43QNIOuTkg2NzR1acOwykaX8dcgmw8wWnnc
Message-ID: <CANn89iKoMHvYsvmqHB2HmCPp3H8Mmz1FwDD1XmqM6oDJS9+vTA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 5/5] net: dev_queue_xmit() llist adoption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 1:48=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > Remove busylock spinlock and use a lockless list (llist)
> > to reduce spinlock contention to the minimum.
> >
> > Idea is that only one cpu might spin on the qdisc spinlock,
> > while others simply add their skb in the llist.
> >
> > After this patch, we get a 300 % improvement on heavy TX workloads.
> > - Sending twice the number of packets per second.
> > - While consuming 50 % less cycles.
> >
> > Tested:
> >
> > - Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
> > - 100Gbit NIC, 30 TX queues with FQ packet scheduler.
> > - echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid conten=
tion in mm)
> > - 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"
> >
> > Before:
> >
> > 16 Mpps (41 Mpps if each thread is pinned to a different cpu)
> >
> > vmstat 2 5
> > procs -----------memory---------- ---swap-- -----io---- -system-- -----=
-cpu-----
> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy=
 id wa st
> > 243  0      0 2368988672  51036 1100852    0    0   146     1  242   60=
  0  9 91  0  0
> > 244  0      0 2368988672  51036 1100852    0    0   536    10 487745 14=
718  0 52 48  0  0
> > 244  0      0 2368988672  51036 1100852    0    0   512     0 503067 46=
033  0 52 48  0  0
> > 244  0      0 2368988672  51036 1100852    0    0   512     0 494807 12=
107  0 52 48  0  0
> > 244  0      0 2368988672  51036 1100852    0    0   702    26 492845 10=
110  0 52 48  0  0
> >
> > Lock contention (1 second sample taken on 8 cores)
> > perf lock record -C0-7 sleep 1; perf lock contention
> >  contended   total wait     max wait     avg wait         type   caller
> >
> >     442111      6.79 s     162.47 ms     15.35 us     spinlock   dev_ha=
rd_start_xmit+0xcd
> >       5961      9.57 ms      8.12 us      1.60 us     spinlock   __dev_=
queue_xmit+0x3a0
> >        244    560.63 us      7.63 us      2.30 us     spinlock   do_sof=
tirq+0x5b
> >         13     25.09 us      3.21 us      1.93 us     spinlock   net_tx=
_action+0xf8
> >
> > If netperf threads are pinned, spinlock stress is very high.
> > perf lock record -C0-7 sleep 1; perf lock contention
> >  contended   total wait     max wait     avg wait         type   caller
> >
> >     964508      7.10 s     147.25 ms      7.36 us     spinlock   dev_ha=
rd_start_xmit+0xcd
> >        201    268.05 us      4.65 us      1.33 us     spinlock   __dev_=
queue_xmit+0x3a0
> >         12     26.05 us      3.84 us      2.17 us     spinlock   do_sof=
tirq+0x5b
> >
> > @__dev_queue_xmit_ns:
> > [256, 512)            21 |                                             =
       |
> > [512, 1K)            631 |                                             =
       |
> > [1K, 2K)           27328 |@                                            =
       |
> > [2K, 4K)          265392 |@@@@@@@@@@@@@@@@                             =
       |
> > [4K, 8K)          417543 |@@@@@@@@@@@@@@@@@@@@@@@@@@                   =
       |
> > [8K, 16K)         826292 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@|
> > [16K, 32K)        733822 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@      |
> > [32K, 64K)         19055 |@                                            =
       |
> > [64K, 128K)        17240 |@                                            =
       |
> > [128K, 256K)       25633 |@                                            =
       |
> > [256K, 512K)           4 |                                             =
       |
> >
> > After:
> >
> > 29 Mpps (57 Mpps if each thread is pinned to a different cpu)
> >
> > vmstat 2 5
> > procs -----------memory---------- ---swap-- -----io---- -system-- -----=
-cpu-----
> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy=
 id wa st
> > 78  0      0 2369573632  32896 1350988    0    0    22     0  331  254 =
 0  8 92  0  0
> > 75  0      0 2369573632  32896 1350988    0    0    22    50 425713 280=
199  0 23 76  0  0
> > 104  0      0 2369573632  32896 1350988    0    0   290     0 430238 29=
8247  0 23 76  0  0
> > 86  0      0 2369573632  32896 1350988    0    0   132     0 428019 291=
865  0 24 76  0  0
> > 90  0      0 2369573632  32896 1350988    0    0   502     0 422498 278=
672  0 23 76  0  0
> >
> > perf lock record -C0-7 sleep 1; perf lock contention
> >  contended   total wait     max wait     avg wait         type   caller
> >
> >       2524    116.15 ms    486.61 us     46.02 us     spinlock   __dev_=
queue_xmit+0x55b
> >       5821    107.18 ms    371.67 us     18.41 us     spinlock   dev_ha=
rd_start_xmit+0xcd
> >       2377      9.73 ms     35.86 us      4.09 us     spinlock   ___sla=
b_alloc+0x4e0
> >        923      5.74 ms     20.91 us      6.22 us     spinlock   ___sla=
b_alloc+0x5c9
> >        121      3.42 ms    193.05 us     28.24 us     spinlock   net_tx=
_action+0xf8
> >          6    564.33 us    167.60 us     94.05 us     spinlock   do_sof=
tirq+0x5b
> >
> > If netperf threads are pinned (~54 Mpps)
> > perf lock record -C0-7 sleep 1; perf lock contention
> >      32907    316.98 ms    195.98 us      9.63 us     spinlock   dev_ha=
rd_start_xmit+0xcd
> >       4507     61.83 ms    212.73 us     13.72 us     spinlock   __dev_=
queue_xmit+0x554
> >       2781     23.53 ms     40.03 us      8.46 us     spinlock   ___sla=
b_alloc+0x5c9
> >       3554     18.94 ms     34.69 us      5.33 us     spinlock   ___sla=
b_alloc+0x4e0
> >        233      9.09 ms    215.70 us     38.99 us     spinlock   do_sof=
tirq+0x5b
> >        153    930.66 us     48.67 us      6.08 us     spinlock   net_tx=
_action+0xfd
> >         84    331.10 us     14.22 us      3.94 us     spinlock   ___sla=
b_alloc+0x5c9
> >        140    323.71 us      9.94 us      2.31 us     spinlock   ___sla=
b_alloc+0x4e0
> >
> > @__dev_queue_xmit_ns:
> > [128, 256)       1539830 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@           =
       |
> > [256, 512)       2299558 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@|
> > [512, 1K)         483936 |@@@@@@@@@@                                   =
       |
> > [1K, 2K)          265345 |@@@@@@                                       =
       |
> > [2K, 4K)          145463 |@@@                                          =
       |
> > [4K, 8K)           54571 |@                                            =
       |
> > [8K, 16K)          10270 |                                             =
       |
> > [16K, 32K)          9385 |                                             =
       |
> > [32K, 64K)          7749 |                                             =
       |
> > [64K, 128K)        26799 |                                             =
       |
> > [128K, 256K)        2665 |                                             =
       |
> > [256K, 512K)         665 |                                             =
       |
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> This is very cool! One question below, just to make sure I understand
> this correctly:
>
> > ---
> >  include/net/sch_generic.h |  4 +-
> >  net/core/dev.c            | 85 ++++++++++++++++++++++-----------------
> >  net/sched/sch_generic.c   |  5 ---
> >  3 files changed, 52 insertions(+), 42 deletions(-)
> >
> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> > index 31561291bc92fd70d4d3ca8f5f7dbc4c94c895a0..94966692ccdf51db085c236=
319705aecba8c30cf 100644
> > --- a/include/net/sch_generic.h
> > +++ b/include/net/sch_generic.h
> > @@ -115,7 +115,9 @@ struct Qdisc {
> >       struct Qdisc            *next_sched;
> >       struct sk_buff_head     skb_bad_txq;
> >
> > -     spinlock_t              busylock ____cacheline_aligned_in_smp;
> > +     atomic_long_t           defer_count ____cacheline_aligned_in_smp;
> > +     struct llist_head       defer_list;
> > +
> >       spinlock_t              seqlock;
> >
> >       struct rcu_head         rcu;
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 0ff178399b2d28ca2754b3f06d69a97f5d6dcf71..6094768bf3c028f0ad1e52b=
9b12b7258fa0ecff6 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4125,9 +4125,10 @@ static inline int __dev_xmit_skb(struct sk_buff =
*skb, struct Qdisc *q,
> >                                struct net_device *dev,
> >                                struct netdev_queue *txq)
> >  {
> > +     struct sk_buff *next, *to_free =3D NULL;
> >       spinlock_t *root_lock =3D qdisc_lock(q);
> > -     struct sk_buff *to_free =3D NULL;
> > -     bool contended;
> > +     struct llist_node *ll_list, *first_n;
> > +     unsigned long defer_count =3D 0;
> >       int rc;
> >
> >       qdisc_calculate_pkt_len(skb, q);
> > @@ -4167,61 +4168,73 @@ static inline int __dev_xmit_skb(struct sk_buff=
 *skb, struct Qdisc *q,
> >               return rc;
> >       }
> >
> > -     /*
> > -      * Heuristic to force contended enqueues to serialize on a
> > -      * separate lock before trying to get qdisc main lock.
> > -      * This permits qdisc->running owner to get the lock more
> > -      * often and dequeue packets faster.
> > -      * On PREEMPT_RT it is possible to preempt the qdisc owner during=
 xmit
> > -      * and then other tasks will only enqueue packets. The packets wi=
ll be
> > -      * sent after the qdisc owner is scheduled again. To prevent this
> > -      * scenario the task always serialize on the lock.
> > +     /* Open code llist_add(&skb->ll_node, &q->defer_list) + queue lim=
it.
> > +      * In the try_cmpxchg() loop, we want to increment q->defer_count
> > +      * at most once to limit the number of skbs in defer_list.
> > +      * We perform the defer_count increment only if the list is not e=
mpty,
> > +      * because some arches have slow atomic_long_inc_return().
> > +      */
> > +     first_n =3D READ_ONCE(q->defer_list.first);
> > +     do {
> > +             if (first_n && !defer_count) {
> > +                     defer_count =3D atomic_long_inc_return(&q->defer_=
count);
> > +                     if (unlikely(defer_count > q->limit)) {
> > +                             kfree_skb_reason(skb, SKB_DROP_REASON_QDI=
SC_DROP);
> > +                             return NET_XMIT_DROP;
> > +                     }
> > +             }
> > +             skb->ll_node.next =3D first_n;
> > +     } while (!try_cmpxchg(&q->defer_list.first, &first_n, &skb->ll_no=
de));
> > +
> > +     /* If defer_list was not empty, we know the cpu which queued
> > +      * the first skb will process the whole list for us.
> >        */
> > -     contended =3D qdisc_is_running(q) || IS_ENABLED(CONFIG_PREEMPT_RT=
);
> > -     if (unlikely(contended))
> > -             spin_lock(&q->busylock);
> > +     if (first_n)
> > +             return NET_XMIT_SUCCESS;
> >
> >       spin_lock(root_lock);
> > +
> > +     ll_list =3D llist_del_all(&q->defer_list);
> > +     /* There is a small race because we clear defer_count not atomica=
lly
> > +      * with the prior llist_del_all(). This means defer_list could gr=
ow
> > +      * over q->limit.
> > +      */
> > +     atomic_long_set(&q->defer_count, 0);
> > +
> > +     ll_list =3D llist_reverse_order(ll_list);
> > +
> >       if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
> > -             __qdisc_drop(skb, &to_free);
> > +             llist_for_each_entry_safe(skb, next, ll_list, ll_node)
> > +                     __qdisc_drop(skb, &to_free);
> >               rc =3D NET_XMIT_DROP;
> > -     } else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
> > -                qdisc_run_begin(q)) {
> > +             goto unlock;
> > +     }
> > +     rc =3D NET_XMIT_SUCCESS;
> > +     if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
> > +         !llist_next(ll_list) && qdisc_run_begin(q)) {
> >               /*
> >                * This is a work-conserving queue; there are no old skbs
> >                * waiting to be sent out; and the qdisc is not running -
> >                * xmit the skb directly.
> >                */
> >
> > +             skb =3D llist_entry(ll_list, struct sk_buff, ll_node);
>
> I was puzzled by this^. But AFAICT, the idea is that in the
> non-contended path we're in here (no other CPU enqueueing packets), we
> will still have added the skb to the llist before taking the root_lock,
> and here we pull it back off the list, right?
>
> Even though this is technically not needed (we'll always get the same
> skb back, I think?), so this is mostly for consistency(?)

Exactly. I guess we could instead add an assert like

diff --git a/net/core/dev.c b/net/core/dev.c
index 1a0baedc4f39e17efd21b0e48a7373a394bcbfa6..4f0e448558a6d2c070d93c47469=
8d904d0b864f6
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4135,7 +4135,7 @@ static inline int __dev_xmit_skb(struct sk_buff
*skb, struct Qdisc *q,
                 * xmit the skb directly.
                 */

-               skb =3D llist_entry(ll_list, struct sk_buff, ll_node);
+               DEBUG_NET_WARN_ON_ONCE(skb !=3D llist_entry(ll_list,
struct sk_buff, ll_node));
                qdisc_bstats_update(q, skb);
                if (sch_direct_xmit(skb, q, dev, txq, root_lock, true))
                        __qdisc_run(q);

