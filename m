Return-Path: <netdev+bounces-228195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDC9BC46C8
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 12:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480E53B9395
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 10:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F96F2F25E1;
	Wed,  8 Oct 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rCLoIrtU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE542F60D8
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920381; cv=none; b=ENUaYKADWgD2iT/jLAS/umScjvmuieQRWj1qW4aCYsfZB8e01eJ1KdIDnmEHipNObyq3X8CKbdTIUGtpeXakgmIYfG/ioHEbX7zQt3gRqf5MQDaKXSMtdpeN/PovnIbj1Wy1zHeMfZgf2dZmEdiQEfPKWIJxVx6KUgits8CtUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920381; c=relaxed/simple;
	bh=hLyq2Y02XYLZ0CgsHPEzkblDFsf+saob8IdPk+unP8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2n6Ku8wKkJUeqGuiMvwhjCoUCSGVUbKDG3YFkaVNRh4rnJmY7x5feQNmHxYxtI/ejreeFsUbsZluuuiI9S7SQ3kr+McgO9ubmT3zGtbQ07sPJ6sxGtbE4sxKxFcq8bO1CiYrqPNW8wAV20/MfuGr51/Wa9N4WveeLi1cWwZGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rCLoIrtU; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4df81016e59so68160731cf.3
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759920378; x=1760525178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeMukUCEkNXr9P8yFYMnCM/evUrszYLEmgjwRk4oT34=;
        b=rCLoIrtUyIkqHhxLigv1kIUVWwQlYTX6hX0PbIAoLM+e+lh1/WlWXNfNfFOLNGRePR
         ebLakU4G2RJj9jjpf0SfUs5Lyl78HtdDvTFRPezi99G5+1fA3y5wnThBdNSOqfwQV87H
         gwoPaZj/+2cruxLQzS2Ihzt9DEZs6hDUcTwAH8IMNnskyl2oWH9ePYU3tWBfY+rDydGc
         hnat64Orfm3RQ9e13hl9K26TDR+QE5nrTAT7LyDWO6BLGNJK1OgMRUQVqtS2JVPksmLy
         MkTlMr4O3EkGTZ7WsXLApbQVZvhxNXjeZMNWhlF8v+PrNmt23bqjEQY4TTPG5MX0FR4H
         GH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920378; x=1760525178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeMukUCEkNXr9P8yFYMnCM/evUrszYLEmgjwRk4oT34=;
        b=xMV6fzHX8E/31pIJinLRMekF6ARvoW0mte2ESpUKY6U2+xUVzoKEHPIuRGguXfVR5A
         hEExF/dkMB9tGjMw+obMrbNSi+C5z07SbB04oK01ZrIiF1nFbMbkWMQJ/UQjSgtuoGMd
         mS97wf2bJfTFIuKX1/wdwGEV3NglrEMXBHpWrB0Cxf8XT9293g0Q/M33Ic/6GB2VUvb3
         AGYxEgDQ8GbpNxZAMntnBY93F4XrjbiTPZSkRb9dNKnRrSSzKi/xGp9qwP/ydbEnMf0c
         13cOmlpSwsFm/Zu5RyVZU0gbJ5d5ihYCw/t4K5QZ+wnc6z68X5q5wchaBsdTDUeYLZJl
         G+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3MaN9uWey7GmQpM54g0q44qrmSImX4bnZ1djCZC58ZrkpsCkT9wcbKdKiWJs/+xESN+qp05Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YypGRi5KVKRc8JR2IbUmqwHNdlYXTKY8bM/oonNE/xdQBxqIYBR
	WorjgU35kdyWLj2Ey/laa6BWflDqIsjDIyiA1r7rGOcZYiq0l2ee/LY266X1GH4mhceIArO8PZj
	5SD1wKnve7aEEdp8URUASPlP7cVHFzg58VjAeznuN
X-Gm-Gg: ASbGncsSqfljTSbQ084IC+ZCUSQjltc4j3fqazQH3l58bXDlPreprYEes8Oo21Xgyvs
	X8S+j2twXL9ikI/wN0AUORm4URWSzirntWxxGPUzi5D7/NAJmR2MUMESNyYnySP0JCNzVfvoxmD
	UJjgI2u2BzUlduYQWsMOjsC0bijwUfIX5fMX/8B1oreTavFwMjK8E1dkmta9MjDvb+U/RWLq0kO
	59kZEj4LSRDWo69USbKK1evqt5mHfBCC3pWacXsoizE10ZgViscOFkhU+p94oBXRETUOppE
X-Google-Smtp-Source: AGHT+IH8t5CzAx7e7IXUVj3tTKWlWCXTe/yXHwss2uOcX8wO07O8y17Yrew7KuUJuovRb89gdfJeT5HNX4fhlSZW/cI=
X-Received: by 2002:ac8:7e96:0:b0:4e0:a9d6:d554 with SMTP id
 d75a77b69052e-4e6ead5427emr39493091cf.38.1759920377598; Wed, 08 Oct 2025
 03:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com> <20251006193103.2684156-6-edumazet@google.com>
 <87wm55kcdr.fsf@toke.dk> <CANn89iKoMHvYsvmqHB2HmCPp3H8Mmz1FwDD1XmqM6oDJS9+vTA@mail.gmail.com>
 <87tt09k8se.fsf@toke.dk>
In-Reply-To: <87tt09k8se.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Oct 2025 03:46:06 -0700
X-Gm-Features: AS18NWDDL7GL7o7b9o6GYAo8NFD3kocma1fvCP9H7L7vTWQAQ5xwHsWcvLgOkjw
Message-ID: <CANn89i+iHPB1UVS+qB95MLUXvq9KnbYPbbZvNW7f_d3XMfwD6w@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 5/5] net: dev_queue_xmit() llist adoption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 3:05=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > On Wed, Oct 8, 2025 at 1:48=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
> >>
> >> Eric Dumazet <edumazet@google.com> writes:
> >>
> >> > Remove busylock spinlock and use a lockless list (llist)
> >> > to reduce spinlock contention to the minimum.
> >> >
> >> > Idea is that only one cpu might spin on the qdisc spinlock,
> >> > while others simply add their skb in the llist.
> >> >
> >> > After this patch, we get a 300 % improvement on heavy TX workloads.
> >> > - Sending twice the number of packets per second.
> >> > - While consuming 50 % less cycles.
> >> >
> >> > Tested:
> >> >
> >> > - Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
> >> > - 100Gbit NIC, 30 TX queues with FQ packet scheduler.
> >> > - echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid con=
tention in mm)
> >> > - 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"
> >> >
> >> > Before:
> >> >
> >> > 16 Mpps (41 Mpps if each thread is pinned to a different cpu)
> >> >
> >> > vmstat 2 5
> >> > procs -----------memory---------- ---swap-- -----io---- -system-- --=
----cpu-----
> >> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us=
 sy id wa st
> >> > 243  0      0 2368988672  51036 1100852    0    0   146     1  242  =
 60  0  9 91  0  0
> >> > 244  0      0 2368988672  51036 1100852    0    0   536    10 487745=
 14718  0 52 48  0  0
> >> > 244  0      0 2368988672  51036 1100852    0    0   512     0 503067=
 46033  0 52 48  0  0
> >> > 244  0      0 2368988672  51036 1100852    0    0   512     0 494807=
 12107  0 52 48  0  0
> >> > 244  0      0 2368988672  51036 1100852    0    0   702    26 492845=
 10110  0 52 48  0  0
> >> >
> >> > Lock contention (1 second sample taken on 8 cores)
> >> > perf lock record -C0-7 sleep 1; perf lock contention
> >> >  contended   total wait     max wait     avg wait         type   cal=
ler
> >> >
> >> >     442111      6.79 s     162.47 ms     15.35 us     spinlock   dev=
_hard_start_xmit+0xcd
> >> >       5961      9.57 ms      8.12 us      1.60 us     spinlock   __d=
ev_queue_xmit+0x3a0
> >> >        244    560.63 us      7.63 us      2.30 us     spinlock   do_=
softirq+0x5b
> >> >         13     25.09 us      3.21 us      1.93 us     spinlock   net=
_tx_action+0xf8
> >> >
> >> > If netperf threads are pinned, spinlock stress is very high.
> >> > perf lock record -C0-7 sleep 1; perf lock contention
> >> >  contended   total wait     max wait     avg wait         type   cal=
ler
> >> >
> >> >     964508      7.10 s     147.25 ms      7.36 us     spinlock   dev=
_hard_start_xmit+0xcd
> >> >        201    268.05 us      4.65 us      1.33 us     spinlock   __d=
ev_queue_xmit+0x3a0
> >> >         12     26.05 us      3.84 us      2.17 us     spinlock   do_=
softirq+0x5b
> >> >
> >> > @__dev_queue_xmit_ns:
> >> > [256, 512)            21 |                                          =
          |
> >> > [512, 1K)            631 |                                          =
          |
> >> > [1K, 2K)           27328 |@                                         =
          |
> >> > [2K, 4K)          265392 |@@@@@@@@@@@@@@@@                          =
          |
> >> > [4K, 8K)          417543 |@@@@@@@@@@@@@@@@@@@@@@@@@@                =
          |
> >> > [8K, 16K)         826292 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@|
> >> > [16K, 32K)        733822 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@      |
> >> > [32K, 64K)         19055 |@                                         =
          |
> >> > [64K, 128K)        17240 |@                                         =
          |
> >> > [128K, 256K)       25633 |@                                         =
          |
> >> > [256K, 512K)           4 |                                          =
          |
> >> >
> >> > After:
> >> >
> >> > 29 Mpps (57 Mpps if each thread is pinned to a different cpu)
> >> >
> >> > vmstat 2 5
> >> > procs -----------memory---------- ---swap-- -----io---- -system-- --=
----cpu-----
> >> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us=
 sy id wa st
> >> > 78  0      0 2369573632  32896 1350988    0    0    22     0  331  2=
54  0  8 92  0  0
> >> > 75  0      0 2369573632  32896 1350988    0    0    22    50 425713 =
280199  0 23 76  0  0
> >> > 104  0      0 2369573632  32896 1350988    0    0   290     0 430238=
 298247  0 23 76  0  0
> >> > 86  0      0 2369573632  32896 1350988    0    0   132     0 428019 =
291865  0 24 76  0  0
> >> > 90  0      0 2369573632  32896 1350988    0    0   502     0 422498 =
278672  0 23 76  0  0
> >> >
> >> > perf lock record -C0-7 sleep 1; perf lock contention
> >> >  contended   total wait     max wait     avg wait         type   cal=
ler
> >> >
> >> >       2524    116.15 ms    486.61 us     46.02 us     spinlock   __d=
ev_queue_xmit+0x55b
> >> >       5821    107.18 ms    371.67 us     18.41 us     spinlock   dev=
_hard_start_xmit+0xcd
> >> >       2377      9.73 ms     35.86 us      4.09 us     spinlock   ___=
slab_alloc+0x4e0
> >> >        923      5.74 ms     20.91 us      6.22 us     spinlock   ___=
slab_alloc+0x5c9
> >> >        121      3.42 ms    193.05 us     28.24 us     spinlock   net=
_tx_action+0xf8
> >> >          6    564.33 us    167.60 us     94.05 us     spinlock   do_=
softirq+0x5b
> >> >
> >> > If netperf threads are pinned (~54 Mpps)
> >> > perf lock record -C0-7 sleep 1; perf lock contention
> >> >      32907    316.98 ms    195.98 us      9.63 us     spinlock   dev=
_hard_start_xmit+0xcd
> >> >       4507     61.83 ms    212.73 us     13.72 us     spinlock   __d=
ev_queue_xmit+0x554
> >> >       2781     23.53 ms     40.03 us      8.46 us     spinlock   ___=
slab_alloc+0x5c9
> >> >       3554     18.94 ms     34.69 us      5.33 us     spinlock   ___=
slab_alloc+0x4e0
> >> >        233      9.09 ms    215.70 us     38.99 us     spinlock   do_=
softirq+0x5b
> >> >        153    930.66 us     48.67 us      6.08 us     spinlock   net=
_tx_action+0xfd
> >> >         84    331.10 us     14.22 us      3.94 us     spinlock   ___=
slab_alloc+0x5c9
> >> >        140    323.71 us      9.94 us      2.31 us     spinlock   ___=
slab_alloc+0x4e0
> >> >
> >> > @__dev_queue_xmit_ns:
> >> > [128, 256)       1539830 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        =
          |
> >> > [256, 512)       2299558 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@|
> >> > [512, 1K)         483936 |@@@@@@@@@@                                =
          |
> >> > [1K, 2K)          265345 |@@@@@@                                    =
          |
> >> > [2K, 4K)          145463 |@@@                                       =
          |
> >> > [4K, 8K)           54571 |@                                         =
          |
> >> > [8K, 16K)          10270 |                                          =
          |
> >> > [16K, 32K)          9385 |                                          =
          |
> >> > [32K, 64K)          7749 |                                          =
          |
> >> > [64K, 128K)        26799 |                                          =
          |
> >> > [128K, 256K)        2665 |                                          =
          |
> >> > [256K, 512K)         665 |                                          =
          |
> >> >
> >> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >>
> >> This is very cool! One question below, just to make sure I understand
> >> this correctly:
> >>
> >> > ---
> >> >  include/net/sch_generic.h |  4 +-
> >> >  net/core/dev.c            | 85 ++++++++++++++++++++++--------------=
---
> >> >  net/sched/sch_generic.c   |  5 ---
> >> >  3 files changed, 52 insertions(+), 42 deletions(-)
> >> >
> >> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> >> > index 31561291bc92fd70d4d3ca8f5f7dbc4c94c895a0..94966692ccdf51db085c=
236319705aecba8c30cf 100644
> >> > --- a/include/net/sch_generic.h
> >> > +++ b/include/net/sch_generic.h
> >> > @@ -115,7 +115,9 @@ struct Qdisc {
> >> >       struct Qdisc            *next_sched;
> >> >       struct sk_buff_head     skb_bad_txq;
> >> >
> >> > -     spinlock_t              busylock ____cacheline_aligned_in_smp;
> >> > +     atomic_long_t           defer_count ____cacheline_aligned_in_s=
mp;
> >> > +     struct llist_head       defer_list;
> >> > +
> >> >       spinlock_t              seqlock;
> >> >
> >> >       struct rcu_head         rcu;
> >> > diff --git a/net/core/dev.c b/net/core/dev.c
> >> > index 0ff178399b2d28ca2754b3f06d69a97f5d6dcf71..6094768bf3c028f0ad1e=
52b9b12b7258fa0ecff6 100644
> >> > --- a/net/core/dev.c
> >> > +++ b/net/core/dev.c
> >> > @@ -4125,9 +4125,10 @@ static inline int __dev_xmit_skb(struct sk_bu=
ff *skb, struct Qdisc *q,
> >> >                                struct net_device *dev,
> >> >                                struct netdev_queue *txq)
> >> >  {
> >> > +     struct sk_buff *next, *to_free =3D NULL;
> >> >       spinlock_t *root_lock =3D qdisc_lock(q);
> >> > -     struct sk_buff *to_free =3D NULL;
> >> > -     bool contended;
> >> > +     struct llist_node *ll_list, *first_n;
> >> > +     unsigned long defer_count =3D 0;
> >> >       int rc;
> >> >
> >> >       qdisc_calculate_pkt_len(skb, q);
> >> > @@ -4167,61 +4168,73 @@ static inline int __dev_xmit_skb(struct sk_b=
uff *skb, struct Qdisc *q,
> >> >               return rc;
> >> >       }
> >> >
> >> > -     /*
> >> > -      * Heuristic to force contended enqueues to serialize on a
> >> > -      * separate lock before trying to get qdisc main lock.
> >> > -      * This permits qdisc->running owner to get the lock more
> >> > -      * often and dequeue packets faster.
> >> > -      * On PREEMPT_RT it is possible to preempt the qdisc owner dur=
ing xmit
> >> > -      * and then other tasks will only enqueue packets. The packets=
 will be
> >> > -      * sent after the qdisc owner is scheduled again. To prevent t=
his
> >> > -      * scenario the task always serialize on the lock.
> >> > +     /* Open code llist_add(&skb->ll_node, &q->defer_list) + queue =
limit.
> >> > +      * In the try_cmpxchg() loop, we want to increment q->defer_co=
unt
> >> > +      * at most once to limit the number of skbs in defer_list.
> >> > +      * We perform the defer_count increment only if the list is no=
t empty,
> >> > +      * because some arches have slow atomic_long_inc_return().
> >> > +      */
> >> > +     first_n =3D READ_ONCE(q->defer_list.first);
> >> > +     do {
> >> > +             if (first_n && !defer_count) {
> >> > +                     defer_count =3D atomic_long_inc_return(&q->def=
er_count);
> >> > +                     if (unlikely(defer_count > q->limit)) {
> >> > +                             kfree_skb_reason(skb, SKB_DROP_REASON_=
QDISC_DROP);
> >> > +                             return NET_XMIT_DROP;
> >> > +                     }
> >> > +             }
> >> > +             skb->ll_node.next =3D first_n;
> >> > +     } while (!try_cmpxchg(&q->defer_list.first, &first_n, &skb->ll=
_node));
> >> > +
> >> > +     /* If defer_list was not empty, we know the cpu which queued
> >> > +      * the first skb will process the whole list for us.
> >> >        */
> >> > -     contended =3D qdisc_is_running(q) || IS_ENABLED(CONFIG_PREEMPT=
_RT);
> >> > -     if (unlikely(contended))
> >> > -             spin_lock(&q->busylock);
> >> > +     if (first_n)
> >> > +             return NET_XMIT_SUCCESS;
> >> >
> >> >       spin_lock(root_lock);
> >> > +
> >> > +     ll_list =3D llist_del_all(&q->defer_list);
> >> > +     /* There is a small race because we clear defer_count not atom=
ically
> >> > +      * with the prior llist_del_all(). This means defer_list could=
 grow
> >> > +      * over q->limit.
> >> > +      */
> >> > +     atomic_long_set(&q->defer_count, 0);
> >> > +
> >> > +     ll_list =3D llist_reverse_order(ll_list);
> >> > +
> >> >       if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) =
{
> >> > -             __qdisc_drop(skb, &to_free);
> >> > +             llist_for_each_entry_safe(skb, next, ll_list, ll_node)
> >> > +                     __qdisc_drop(skb, &to_free);
> >> >               rc =3D NET_XMIT_DROP;
> >> > -     } else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
> >> > -                qdisc_run_begin(q)) {
> >> > +             goto unlock;
> >> > +     }
> >> > +     rc =3D NET_XMIT_SUCCESS;
> >> > +     if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
> >> > +         !llist_next(ll_list) && qdisc_run_begin(q)) {
> >> >               /*
> >> >                * This is a work-conserving queue; there are no old s=
kbs
> >> >                * waiting to be sent out; and the qdisc is not runnin=
g -
> >> >                * xmit the skb directly.
> >> >                */
> >> >
> >> > +             skb =3D llist_entry(ll_list, struct sk_buff, ll_node);
> >>
> >> I was puzzled by this^. But AFAICT, the idea is that in the
> >> non-contended path we're in here (no other CPU enqueueing packets), we
> >> will still have added the skb to the llist before taking the root_lock=
,
> >> and here we pull it back off the list, right?
> >>
> >> Even though this is technically not needed (we'll always get the same
> >> skb back, I think?), so this is mostly for consistency(?)
> >
> > Exactly. I guess we could instead add an assert like
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 1a0baedc4f39e17efd21b0e48a7373a394bcbfa6..4f0e448558a6d2c070d93c4=
74698d904d0b864f6
> > 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4135,7 +4135,7 @@ static inline int __dev_xmit_skb(struct sk_buff
> > *skb, struct Qdisc *q,
> >                  * xmit the skb directly.
> >                  */
> >
> > -               skb =3D llist_entry(ll_list, struct sk_buff, ll_node);
> > +               DEBUG_NET_WARN_ON_ONCE(skb !=3D llist_entry(ll_list,
> > struct sk_buff, ll_node));
> >                 qdisc_bstats_update(q, skb);
> >                 if (sch_direct_xmit(skb, q, dev, txq, root_lock, true))
> >                         __qdisc_run(q);
>
> OK, so thinking about this some more, isn't there a race between the
>
>         if (first_n)
>                 return NET_XMIT_SUCCESS;
>
> and taking the lock? I.e., two different CPUs can pass that check in
> which case one of them will end up spinning on the lock, and by the time
> it acquires it, there is no longer any guarantee that the skb on the
> llist will be the same one that we started with? Or indeed that there
> will be any skbs on the list at all?

Only one cpu can observe the list was empty.

This (spinlock)less list still has atomic guarantees, thanks to cmpxchg().

So after this only cpu passes the spinlock() barrier, the list has at
least one skb in it.

If there is a single skb in the list after the xchg() got it
atomically, then it must be its own skb.

>
> In which case, shouldn't there be a:
>
> if (unlikely(llist_empty(ll_list)))
>         goto unlock;
>
> after the llist_del_all() assignment inside the lock? (and we should
> retain the skb =3D llist_entry()) assignment I was confused about).
>
> Or am I missing some reason this can't happen?
>
> -Toke
>

