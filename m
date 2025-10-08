Return-Path: <netdev+bounces-228208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81022BC4C12
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 14:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8003AC3C2
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE5F204096;
	Wed,  8 Oct 2025 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETQIKGDA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7630E34BA5F
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925965; cv=none; b=nY6oT6u83R/5mPeavA1mljhOnlGGvfKySgDdjWWqGboRiRJl+CVgMvz1j7J5nvjy2Pawwumf14ZrJKDI+OlQdR6QUYYumO7blEGp1NeUvSrrn0aei9zbqfTn8ouL8eRs9eavtx0IbQvasy/Vfz0lJtdXO51hhOd9fFulXL5SlGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925965; c=relaxed/simple;
	bh=x0XZZU1OaKpn2nMKSA9PdSRHX1TkiUoMckyqrsuWkPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aDhig9JqWe7IzcH2GgvOmGmCwPVRFWVWSkG8kRSa2z4OIP8QFt7HgERFZQitcy5eL58haQqWUeTs07HZkttDpgs88NvygzMm68gWm8DcmZT/a6G49tqbL3B2qLZlvZj53imkJH5J5ElERnNkQ/RtuxkzZEDxVUek7K96QmLg/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETQIKGDA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759925962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7qdu835kPfFfzyTyOfVqLtXCbG7o1eNv44bcm15CEw=;
	b=ETQIKGDAYPwkvRdY+PEFy9GjGG9KwMjz85bbX72UFA2dqjqaJeLrkyGFclPvX7mQmQtoH9
	ezUHfZExeJhlTNOZXDjEKjHlGPIiPNaBq0KGLUxarj71hXxAjogtiXWpIeKUYaEhNwjuJf
	CWBUO4vSLtwhU8h/W94vMJAbahzvzr0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-45tG5T7rMiKjK3BfJP60dw-1; Wed, 08 Oct 2025 08:19:21 -0400
X-MC-Unique: 45tG5T7rMiKjK3BfJP60dw-1
X-Mimecast-MFC-AGG-ID: 45tG5T7rMiKjK3BfJP60dw_1759925960
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b4af88aba57so332138366b.3
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 05:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759925957; x=1760530757;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7qdu835kPfFfzyTyOfVqLtXCbG7o1eNv44bcm15CEw=;
        b=AD1tr653WD3sXxLmArop71VfMTFilOJ4t+84yZZgYAUFMZ0V/5VEYUENAv/M7yd+Xb
         kE6QbzafvrRwckTIk/OKde2z1WOegg2OXZaHtHidSD12i5PbGKL2HXF76dUOwAs+XPYq
         TomnD8pVCQ+NQENlCyoYEyGWZbufewB01aZRkNSkwoGpee3nf31BpQZA1wJ79OzrLLeq
         e0McZygUc8yr56jrZN3oAb9oN/2kq7UhQxe9/3+6G+kQWWiiSo4N6bBZaixEXuq98j5G
         Z682A3N+atvdqIHoC26zeag9FVtcXqg6O+x9nyHgEv330OBhOamtYVQMrdUtHOXRBZ1d
         as7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxPQKP+PD73RM2S+6jfPA9FJa0wYGjuOtkGlfqcMxic0W3EmRlDwxsSdOm0P9VTSwwsAwtoH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTW/3zf+Wixx1gX/iV2cldEBdbThCJtxqBuVuc7d+MnBS8tGb
	YTYEaXmatmVc+jV3XUyh4LH/RK/zjUd7lyV1WZyGcsxqrO34LD1Ky4iRghBgiTIFIjM4Swfw2Fh
	EAuQfgK0kBhcmIiSWqb6wMm/i5mMQF/PGEDf71ZmjSeI+ofJZBVkoZD7r6g==
X-Gm-Gg: ASbGnctC6bUUexv5kwlP9SjB0BaNqyPoU5Q0DtZMN7Jk9SPQiDa5hZo5FOtrKFRZjTp
	mv9GrWcrRivqMBNEUlnSf3my2omEhTDMrhnohOUL+RBUq7pOwOsSJ/IFklsTh2A8AU+mY1o3CM6
	/SF361XpBTC5TPN4uaqMuAFOGEQ2Vj8EKSJTRVdSUW+9i9Dcj++NtrBByQGcQpYIe2i5Y5+ctOI
	JmPjqPZpLpl9tRQlkuN1h1eREul9cjihx131jUuLMc+8t5rhL31vJZyn22CcpZdItppmRXXlOkm
	Qg6CFYEUV47+VHOlWPUuyLsRXRgo3TDmURn2r+7NGs2+pjGFdnihjZSqeo9G6rCi4VKegg==
X-Received: by 2002:a17:907:94c2:b0:b45:1063:fb62 with SMTP id a640c23a62f3a-b50aaba11a3mr361500066b.24.1759925957178;
        Wed, 08 Oct 2025 05:19:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGotG10iUJ9ygLnVd7e75iYIx2Tca46D0yMBF9TUxDfORkCTR/Oj1//1a/+1IeaUnddRsyVw==
X-Received: by 2002:a17:907:94c2:b0:b45:1063:fb62 with SMTP id a640c23a62f3a-b50aaba11a3mr361495066b.24.1759925956563;
        Wed, 08 Oct 2025 05:19:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b53bd62ac20sm69128066b.9.2025.10.08.05.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:19:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 930562785C3; Wed, 08 Oct 2025 14:11:58 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Kuniyuki
 Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH RFC net-next 5/5] net: dev_queue_xmit() llist adoption
In-Reply-To: <CANn89i+iHPB1UVS+qB95MLUXvq9KnbYPbbZvNW7f_d3XMfwD6w@mail.gmail.com>
References: <20251006193103.2684156-1-edumazet@google.com>
 <20251006193103.2684156-6-edumazet@google.com> <87wm55kcdr.fsf@toke.dk>
 <CANn89iKoMHvYsvmqHB2HmCPp3H8Mmz1FwDD1XmqM6oDJS9+vTA@mail.gmail.com>
 <87tt09k8se.fsf@toke.dk>
 <CANn89i+iHPB1UVS+qB95MLUXvq9KnbYPbbZvNW7f_d3XMfwD6w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 08 Oct 2025 14:11:58 +0200
Message-ID: <87ms61k2y9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> On Wed, Oct 8, 2025 at 3:05=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> Eric Dumazet <edumazet@google.com> writes:
>>
>> > On Wed, Oct 8, 2025 at 1:48=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
>> >>
>> >> Eric Dumazet <edumazet@google.com> writes:
>> >>
>> >> > Remove busylock spinlock and use a lockless list (llist)
>> >> > to reduce spinlock contention to the minimum.
>> >> >
>> >> > Idea is that only one cpu might spin on the qdisc spinlock,
>> >> > while others simply add their skb in the llist.
>> >> >
>> >> > After this patch, we get a 300 % improvement on heavy TX workloads.
>> >> > - Sending twice the number of packets per second.
>> >> > - While consuming 50 % less cycles.
>> >> >
>> >> > Tested:
>> >> >
>> >> > - Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
>> >> > - 100Gbit NIC, 30 TX queues with FQ packet scheduler.
>> >> > - echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid co=
ntention in mm)
>> >> > - 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"
>> >> >
>> >> > Before:
>> >> >
>> >> > 16 Mpps (41 Mpps if each thread is pinned to a different cpu)
>> >> >
>> >> > vmstat 2 5
>> >> > procs -----------memory---------- ---swap-- -----io---- -system-- -=
-----cpu-----
>> >> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs u=
s sy id wa st
>> >> > 243  0      0 2368988672  51036 1100852    0    0   146     1  242 =
  60  0  9 91  0  0
>> >> > 244  0      0 2368988672  51036 1100852    0    0   536    10 48774=
5 14718  0 52 48  0  0
>> >> > 244  0      0 2368988672  51036 1100852    0    0   512     0 50306=
7 46033  0 52 48  0  0
>> >> > 244  0      0 2368988672  51036 1100852    0    0   512     0 49480=
7 12107  0 52 48  0  0
>> >> > 244  0      0 2368988672  51036 1100852    0    0   702    26 49284=
5 10110  0 52 48  0  0
>> >> >
>> >> > Lock contention (1 second sample taken on 8 cores)
>> >> > perf lock record -C0-7 sleep 1; perf lock contention
>> >> >  contended   total wait     max wait     avg wait         type   ca=
ller
>> >> >
>> >> >     442111      6.79 s     162.47 ms     15.35 us     spinlock   de=
v_hard_start_xmit+0xcd
>> >> >       5961      9.57 ms      8.12 us      1.60 us     spinlock   __=
dev_queue_xmit+0x3a0
>> >> >        244    560.63 us      7.63 us      2.30 us     spinlock   do=
_softirq+0x5b
>> >> >         13     25.09 us      3.21 us      1.93 us     spinlock   ne=
t_tx_action+0xf8
>> >> >
>> >> > If netperf threads are pinned, spinlock stress is very high.
>> >> > perf lock record -C0-7 sleep 1; perf lock contention
>> >> >  contended   total wait     max wait     avg wait         type   ca=
ller
>> >> >
>> >> >     964508      7.10 s     147.25 ms      7.36 us     spinlock   de=
v_hard_start_xmit+0xcd
>> >> >        201    268.05 us      4.65 us      1.33 us     spinlock   __=
dev_queue_xmit+0x3a0
>> >> >         12     26.05 us      3.84 us      2.17 us     spinlock   do=
_softirq+0x5b
>> >> >
>> >> > @__dev_queue_xmit_ns:
>> >> > [256, 512)            21 |                                         =
           |
>> >> > [512, 1K)            631 |                                         =
           |
>> >> > [1K, 2K)           27328 |@                                        =
           |
>> >> > [2K, 4K)          265392 |@@@@@@@@@@@@@@@@                         =
           |
>> >> > [4K, 8K)          417543 |@@@@@@@@@@@@@@@@@@@@@@@@@@               =
           |
>> >> > [8K, 16K)         826292 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@|
>> >> > [16K, 32K)        733822 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@      |
>> >> > [32K, 64K)         19055 |@                                        =
           |
>> >> > [64K, 128K)        17240 |@                                        =
           |
>> >> > [128K, 256K)       25633 |@                                        =
           |
>> >> > [256K, 512K)           4 |                                         =
           |
>> >> >
>> >> > After:
>> >> >
>> >> > 29 Mpps (57 Mpps if each thread is pinned to a different cpu)
>> >> >
>> >> > vmstat 2 5
>> >> > procs -----------memory---------- ---swap-- -----io---- -system-- -=
-----cpu-----
>> >> >  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs u=
s sy id wa st
>> >> > 78  0      0 2369573632  32896 1350988    0    0    22     0  331  =
254  0  8 92  0  0
>> >> > 75  0      0 2369573632  32896 1350988    0    0    22    50 425713=
 280199  0 23 76  0  0
>> >> > 104  0      0 2369573632  32896 1350988    0    0   290     0 43023=
8 298247  0 23 76  0  0
>> >> > 86  0      0 2369573632  32896 1350988    0    0   132     0 428019=
 291865  0 24 76  0  0
>> >> > 90  0      0 2369573632  32896 1350988    0    0   502     0 422498=
 278672  0 23 76  0  0
>> >> >
>> >> > perf lock record -C0-7 sleep 1; perf lock contention
>> >> >  contended   total wait     max wait     avg wait         type   ca=
ller
>> >> >
>> >> >       2524    116.15 ms    486.61 us     46.02 us     spinlock   __=
dev_queue_xmit+0x55b
>> >> >       5821    107.18 ms    371.67 us     18.41 us     spinlock   de=
v_hard_start_xmit+0xcd
>> >> >       2377      9.73 ms     35.86 us      4.09 us     spinlock   __=
_slab_alloc+0x4e0
>> >> >        923      5.74 ms     20.91 us      6.22 us     spinlock   __=
_slab_alloc+0x5c9
>> >> >        121      3.42 ms    193.05 us     28.24 us     spinlock   ne=
t_tx_action+0xf8
>> >> >          6    564.33 us    167.60 us     94.05 us     spinlock   do=
_softirq+0x5b
>> >> >
>> >> > If netperf threads are pinned (~54 Mpps)
>> >> > perf lock record -C0-7 sleep 1; perf lock contention
>> >> >      32907    316.98 ms    195.98 us      9.63 us     spinlock   de=
v_hard_start_xmit+0xcd
>> >> >       4507     61.83 ms    212.73 us     13.72 us     spinlock   __=
dev_queue_xmit+0x554
>> >> >       2781     23.53 ms     40.03 us      8.46 us     spinlock   __=
_slab_alloc+0x5c9
>> >> >       3554     18.94 ms     34.69 us      5.33 us     spinlock   __=
_slab_alloc+0x4e0
>> >> >        233      9.09 ms    215.70 us     38.99 us     spinlock   do=
_softirq+0x5b
>> >> >        153    930.66 us     48.67 us      6.08 us     spinlock   ne=
t_tx_action+0xfd
>> >> >         84    331.10 us     14.22 us      3.94 us     spinlock   __=
_slab_alloc+0x5c9
>> >> >        140    323.71 us      9.94 us      2.31 us     spinlock   __=
_slab_alloc+0x4e0
>> >> >
>> >> > @__dev_queue_xmit_ns:
>> >> > [128, 256)       1539830 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       =
           |
>> >> > [256, 512)       2299558 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@@@@@|
>> >> > [512, 1K)         483936 |@@@@@@@@@@                               =
           |
>> >> > [1K, 2K)          265345 |@@@@@@                                   =
           |
>> >> > [2K, 4K)          145463 |@@@                                      =
           |
>> >> > [4K, 8K)           54571 |@                                        =
           |
>> >> > [8K, 16K)          10270 |                                         =
           |
>> >> > [16K, 32K)          9385 |                                         =
           |
>> >> > [32K, 64K)          7749 |                                         =
           |
>> >> > [64K, 128K)        26799 |                                         =
           |
>> >> > [128K, 256K)        2665 |                                         =
           |
>> >> > [256K, 512K)         665 |                                         =
           |
>> >> >
>> >> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >>
>> >> This is very cool! One question below, just to make sure I understand
>> >> this correctly:
>> >>
>> >> > ---
>> >> >  include/net/sch_generic.h |  4 +-
>> >> >  net/core/dev.c            | 85 ++++++++++++++++++++++-------------=
----
>> >> >  net/sched/sch_generic.c   |  5 ---
>> >> >  3 files changed, 52 insertions(+), 42 deletions(-)
>> >> >
>> >> > diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>> >> > index 31561291bc92fd70d4d3ca8f5f7dbc4c94c895a0..94966692ccdf51db085=
c236319705aecba8c30cf 100644
>> >> > --- a/include/net/sch_generic.h
>> >> > +++ b/include/net/sch_generic.h
>> >> > @@ -115,7 +115,9 @@ struct Qdisc {
>> >> >       struct Qdisc            *next_sched;
>> >> >       struct sk_buff_head     skb_bad_txq;
>> >> >
>> >> > -     spinlock_t              busylock ____cacheline_aligned_in_smp;
>> >> > +     atomic_long_t           defer_count ____cacheline_aligned_in_=
smp;
>> >> > +     struct llist_head       defer_list;
>> >> > +
>> >> >       spinlock_t              seqlock;
>> >> >
>> >> >       struct rcu_head         rcu;
>> >> > diff --git a/net/core/dev.c b/net/core/dev.c
>> >> > index 0ff178399b2d28ca2754b3f06d69a97f5d6dcf71..6094768bf3c028f0ad1=
e52b9b12b7258fa0ecff6 100644
>> >> > --- a/net/core/dev.c
>> >> > +++ b/net/core/dev.c
>> >> > @@ -4125,9 +4125,10 @@ static inline int __dev_xmit_skb(struct sk_b=
uff *skb, struct Qdisc *q,
>> >> >                                struct net_device *dev,
>> >> >                                struct netdev_queue *txq)
>> >> >  {
>> >> > +     struct sk_buff *next, *to_free =3D NULL;
>> >> >       spinlock_t *root_lock =3D qdisc_lock(q);
>> >> > -     struct sk_buff *to_free =3D NULL;
>> >> > -     bool contended;
>> >> > +     struct llist_node *ll_list, *first_n;
>> >> > +     unsigned long defer_count =3D 0;
>> >> >       int rc;
>> >> >
>> >> >       qdisc_calculate_pkt_len(skb, q);
>> >> > @@ -4167,61 +4168,73 @@ static inline int __dev_xmit_skb(struct sk_=
buff *skb, struct Qdisc *q,
>> >> >               return rc;
>> >> >       }
>> >> >
>> >> > -     /*
>> >> > -      * Heuristic to force contended enqueues to serialize on a
>> >> > -      * separate lock before trying to get qdisc main lock.
>> >> > -      * This permits qdisc->running owner to get the lock more
>> >> > -      * often and dequeue packets faster.
>> >> > -      * On PREEMPT_RT it is possible to preempt the qdisc owner du=
ring xmit
>> >> > -      * and then other tasks will only enqueue packets. The packet=
s will be
>> >> > -      * sent after the qdisc owner is scheduled again. To prevent =
this
>> >> > -      * scenario the task always serialize on the lock.
>> >> > +     /* Open code llist_add(&skb->ll_node, &q->defer_list) + queue=
 limit.
>> >> > +      * In the try_cmpxchg() loop, we want to increment q->defer_c=
ount
>> >> > +      * at most once to limit the number of skbs in defer_list.
>> >> > +      * We perform the defer_count increment only if the list is n=
ot empty,
>> >> > +      * because some arches have slow atomic_long_inc_return().
>> >> > +      */
>> >> > +     first_n =3D READ_ONCE(q->defer_list.first);
>> >> > +     do {
>> >> > +             if (first_n && !defer_count) {
>> >> > +                     defer_count =3D atomic_long_inc_return(&q->de=
fer_count);
>> >> > +                     if (unlikely(defer_count > q->limit)) {
>> >> > +                             kfree_skb_reason(skb, SKB_DROP_REASON=
_QDISC_DROP);
>> >> > +                             return NET_XMIT_DROP;
>> >> > +                     }
>> >> > +             }
>> >> > +             skb->ll_node.next =3D first_n;
>> >> > +     } while (!try_cmpxchg(&q->defer_list.first, &first_n, &skb->l=
l_node));
>> >> > +
>> >> > +     /* If defer_list was not empty, we know the cpu which queued
>> >> > +      * the first skb will process the whole list for us.
>> >> >        */
>> >> > -     contended =3D qdisc_is_running(q) || IS_ENABLED(CONFIG_PREEMP=
T_RT);
>> >> > -     if (unlikely(contended))
>> >> > -             spin_lock(&q->busylock);
>> >> > +     if (first_n)
>> >> > +             return NET_XMIT_SUCCESS;
>> >> >
>> >> >       spin_lock(root_lock);
>> >> > +
>> >> > +     ll_list =3D llist_del_all(&q->defer_list);
>> >> > +     /* There is a small race because we clear defer_count not ato=
mically
>> >> > +      * with the prior llist_del_all(). This means defer_list coul=
d grow
>> >> > +      * over q->limit.
>> >> > +      */
>> >> > +     atomic_long_set(&q->defer_count, 0);
>> >> > +
>> >> > +     ll_list =3D llist_reverse_order(ll_list);
>> >> > +
>> >> >       if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state)))=
 {
>> >> > -             __qdisc_drop(skb, &to_free);
>> >> > +             llist_for_each_entry_safe(skb, next, ll_list, ll_node)
>> >> > +                     __qdisc_drop(skb, &to_free);
>> >> >               rc =3D NET_XMIT_DROP;
>> >> > -     } else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
>> >> > -                qdisc_run_begin(q)) {
>> >> > +             goto unlock;
>> >> > +     }
>> >> > +     rc =3D NET_XMIT_SUCCESS;
>> >> > +     if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
>> >> > +         !llist_next(ll_list) && qdisc_run_begin(q)) {
>> >> >               /*
>> >> >                * This is a work-conserving queue; there are no old =
skbs
>> >> >                * waiting to be sent out; and the qdisc is not runni=
ng -
>> >> >                * xmit the skb directly.
>> >> >                */
>> >> >
>> >> > +             skb =3D llist_entry(ll_list, struct sk_buff, ll_node);
>> >>
>> >> I was puzzled by this^. But AFAICT, the idea is that in the
>> >> non-contended path we're in here (no other CPU enqueueing packets), we
>> >> will still have added the skb to the llist before taking the root_loc=
k,
>> >> and here we pull it back off the list, right?
>> >>
>> >> Even though this is technically not needed (we'll always get the same
>> >> skb back, I think?), so this is mostly for consistency(?)
>> >
>> > Exactly. I guess we could instead add an assert like
>> >
>> > diff --git a/net/core/dev.c b/net/core/dev.c
>> > index 1a0baedc4f39e17efd21b0e48a7373a394bcbfa6..4f0e448558a6d2c070d93c=
474698d904d0b864f6
>> > 100644
>> > --- a/net/core/dev.c
>> > +++ b/net/core/dev.c
>> > @@ -4135,7 +4135,7 @@ static inline int __dev_xmit_skb(struct sk_buff
>> > *skb, struct Qdisc *q,
>> >                  * xmit the skb directly.
>> >                  */
>> >
>> > -               skb =3D llist_entry(ll_list, struct sk_buff, ll_node);
>> > +               DEBUG_NET_WARN_ON_ONCE(skb !=3D llist_entry(ll_list,
>> > struct sk_buff, ll_node));
>> >                 qdisc_bstats_update(q, skb);
>> >                 if (sch_direct_xmit(skb, q, dev, txq, root_lock, true))
>> >                         __qdisc_run(q);
>>
>> OK, so thinking about this some more, isn't there a race between the
>>
>>         if (first_n)
>>                 return NET_XMIT_SUCCESS;
>>
>> and taking the lock? I.e., two different CPUs can pass that check in
>> which case one of them will end up spinning on the lock, and by the time
>> it acquires it, there is no longer any guarantee that the skb on the
>> llist will be the same one that we started with? Or indeed that there
>> will be any skbs on the list at all?
>
> Only one cpu can observe the list was empty.
>
> This (spinlock)less list still has atomic guarantees, thanks to cmpxchg().

Ah, right, missed the bit where try_cmpxchg would update first_n if it
doesn't succeed...

> So after this only cpu passes the spinlock() barrier, the list has at
> least one skb in it.
>
> If there is a single skb in the list after the xchg() got it
> atomically, then it must be its own skb.

Gotcha! In that case I agree the DEBUG_NET_WARN_ON_ONCE() is clearer
than reassigning the skb pointer.

-Toke


