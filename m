Return-Path: <netdev+bounces-228181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D47BC3E8F
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 10:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9A5A4E3B43
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 08:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6BB2ECE86;
	Wed,  8 Oct 2025 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdempgFj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92DC4A33
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913305; cv=none; b=DDGl74/MVEOs/Uy/kJcRgx1qNFAzdMdLRofKQVoTzoUFmvcIe2TWXg4FY9EOLP6iKoQAYlR5k1jWJG+FgnR/Y+Y2aKRw1zlLwu2OFM9rKvpAZYUYBvFpa3lqGnvH5i7bbJiBuLlmxOHhEO8c1O+oaULOZauB3NNPcjJNiKZMKR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913305; c=relaxed/simple;
	bh=slutc4bGS2XCLAls3mVxkTUKXqyz4xqaXp7M9BE3ar4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y7xSIC4ckB7RyKb+WuFv/X+mpAp3ZyJqxYOocI/LEvQ7ZDOXKxkRg7vj6mlmHN84IxQvhXwTPZZOS5MEsGD38dugN2cFO736kfATPRBwV7YZo6Ze4VmjTEeYjSDHZJx3ItnEyo+q2Gwm+FxjzzTQgCOOQ/l7G6C9xiuoGZngHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdempgFj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759913302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTbhG1mXd1mRjdFREqAqTpDjPJSPDsi0SniSjSEQ3Eo=;
	b=GdempgFjxSgCrhp2ibGI6nkozRSth8sKPGR3hMnB10PlsY99z1azADfY317t8Havn9M257
	XSw5FL7n1NWIxPVSukyrZfiy+w6jcfPrwr7opY7Hdh+RmTdX7f86DZt3Hp+eVf7gkRtGry
	35RN77bc5Y8Fm88rKiAnx9h9wCTaYSg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-_jS0R4QfMEanaqBhXmIPxg-1; Wed, 08 Oct 2025 04:48:20 -0400
X-MC-Unique: _jS0R4QfMEanaqBhXmIPxg-1
X-Mimecast-MFC-AGG-ID: _jS0R4QfMEanaqBhXmIPxg_1759913300
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-634700fe857so728706a12.0
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 01:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913299; x=1760518099;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTbhG1mXd1mRjdFREqAqTpDjPJSPDsi0SniSjSEQ3Eo=;
        b=TmK9TD4N4b2g1onULAQJX3Luz1Cat58F59B3CN+RRr2EnWtxSyZ8tAoTH0E8n8yDaj
         QGxIrrI3DgzydCk0RV7mXHQiryYzt3MvaD+l9ZMASSm5KyjOo7lEqyftiVghoFDnIYt4
         bnm+O02REnFo8cqA2z5Ayzn/MlcXM2bkVy5AUus3xnZ8T4BiqadTnjBVc5lNmk/U0tHX
         /E7d+LrKJCxtwzUrVoNvpfKGon4KA6KIFgmckgUScbpB0hD8mVln6LCUWMUAiWYJpkNY
         l9unDB/tGT3NxSmt6pNbXXlH9XmdmGsT53kL7JpF2l+KPRlyS5TiNUFgoQJVw230CP/O
         9Wjg==
X-Forwarded-Encrypted: i=1; AJvYcCXBH6CRBX7Nr78eh8ihDsKnKwsVDDzk/8OTlCcoXUylmVm7iO5mBK17Gxm1xAPJwP0yKW9Scj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOoEQ+fuZbw25fz/VsohB937+GaiE74zkaEWyvT27AwfbLGWu
	26Afk+EEx/dhU+z1TYSgjcs6eVOONB2ZRjcykSx4a0CPffUMdlGE4Ooa4vic9FyfWcKGxkFvGi+
	TAHWXw0I2wNls0/OQE33zQ8MSJfVD4xg9b8kI/R4jsriboeX7ioTUqUNU+g==
X-Gm-Gg: ASbGncttQ/fDZ9XAg4PfjQMqoAlbqW3g6gTKczVDAQOmi10TVDIQBg0G8av2KjX3Xr+
	aFfZmGTd3PCml4vN6vNueWhelQiYC7RcSjofYuvD/fIniB3LgtFe/iwzUL91MVGwZw3edqbabgq
	vLDOxMhNK7IINiD4GPsCg1cYsiCNO6+8K2ZpYsrpw8GKtjSzQtc4qiBbHV1sYHlyIScOniy1PyJ
	NhxackUpKni3ZcKrZC+6cduadAehoD2OK1lUS0tZlPaWofMnaT4GFG0T3cnCTgowVSe87Ukp6v1
	IiHfSfBwvicakHTo2OV58dD6anqxuI2PG+e5wbtehwVSDg1q+N3nkjxjlZ69QfM1+g79wbrW
X-Received: by 2002:a17:907:3f95:b0:b41:c602:c75d with SMTP id a640c23a62f3a-b50bf7f13d2mr318090966b.31.1759913299364;
        Wed, 08 Oct 2025 01:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVqAfjq4LxFDs9fpk4P92hnsEZPBskzh6KcIalIEzeQeioo3oYIzHFchAM1IkqYa6HR/+n9A==
X-Received: by 2002:a17:907:3f95:b0:b41:c602:c75d with SMTP id a640c23a62f3a-b50bf7f13d2mr318086966b.31.1759913298843;
        Wed, 08 Oct 2025 01:48:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ff0sm1601952466b.5.2025.10.08.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:48:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 06AB0278598; Wed, 08 Oct 2025 10:48:17 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH RFC net-next 5/5] net: dev_queue_xmit() llist adoption
In-Reply-To: <20251006193103.2684156-6-edumazet@google.com>
References: <20251006193103.2684156-1-edumazet@google.com>
 <20251006193103.2684156-6-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 08 Oct 2025 10:48:16 +0200
Message-ID: <87wm55kcdr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> Remove busylock spinlock and use a lockless list (llist)
> to reduce spinlock contention to the minimum.
>
> Idea is that only one cpu might spin on the qdisc spinlock,
> while others simply add their skb in the llist.
>
> After this patch, we get a 300 % improvement on heavy TX workloads.
> - Sending twice the number of packets per second.
> - While consuming 50 % less cycles.
>
> Tested:
>
> - Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
> - 100Gbit NIC, 30 TX queues with FQ packet scheduler.
> - echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid contenti=
on in mm)
> - 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"
>
> Before:
>
> 16 Mpps (41 Mpps if each thread is pinned to a different cpu)
>
> vmstat 2 5
> procs -----------memory---------- ---swap-- -----io---- -system-- ------c=
pu-----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy i=
d wa st
> 243  0      0 2368988672  51036 1100852    0    0   146     1  242   60  =
0  9 91  0  0
> 244  0      0 2368988672  51036 1100852    0    0   536    10 487745 1471=
8  0 52 48  0  0
> 244  0      0 2368988672  51036 1100852    0    0   512     0 503067 4603=
3  0 52 48  0  0
> 244  0      0 2368988672  51036 1100852    0    0   512     0 494807 1210=
7  0 52 48  0  0
> 244  0      0 2368988672  51036 1100852    0    0   702    26 492845 1011=
0  0 52 48  0  0
>
> Lock contention (1 second sample taken on 8 cores)
> perf lock record -C0-7 sleep 1; perf lock contention
>  contended   total wait     max wait     avg wait         type   caller
>
>     442111      6.79 s     162.47 ms     15.35 us     spinlock   dev_hard=
_start_xmit+0xcd
>       5961      9.57 ms      8.12 us      1.60 us     spinlock   __dev_qu=
eue_xmit+0x3a0
>        244    560.63 us      7.63 us      2.30 us     spinlock   do_softi=
rq+0x5b
>         13     25.09 us      3.21 us      1.93 us     spinlock   net_tx_a=
ction+0xf8
>
> If netperf threads are pinned, spinlock stress is very high.
> perf lock record -C0-7 sleep 1; perf lock contention
>  contended   total wait     max wait     avg wait         type   caller
>
>     964508      7.10 s     147.25 ms      7.36 us     spinlock   dev_hard=
_start_xmit+0xcd
>        201    268.05 us      4.65 us      1.33 us     spinlock   __dev_qu=
eue_xmit+0x3a0
>         12     26.05 us      3.84 us      2.17 us     spinlock   do_softi=
rq+0x5b
>
> @__dev_queue_xmit_ns:
> [256, 512)            21 |                                               =
     |
> [512, 1K)            631 |                                               =
     |
> [1K, 2K)           27328 |@                                              =
     |
> [2K, 4K)          265392 |@@@@@@@@@@@@@@@@                               =
     |
> [4K, 8K)          417543 |@@@@@@@@@@@@@@@@@@@@@@@@@@                     =
     |
> [8K, 16K)         826292 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [16K, 32K)        733822 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ =
     |
> [32K, 64K)         19055 |@                                              =
     |
> [64K, 128K)        17240 |@                                              =
     |
> [128K, 256K)       25633 |@                                              =
     |
> [256K, 512K)           4 |                                               =
     |
>
> After:
>
> 29 Mpps (57 Mpps if each thread is pinned to a different cpu)
>
> vmstat 2 5
> procs -----------memory---------- ---swap-- -----io---- -system-- ------c=
pu-----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy i=
d wa st
> 78  0      0 2369573632  32896 1350988    0    0    22     0  331  254  0=
  8 92  0  0
> 75  0      0 2369573632  32896 1350988    0    0    22    50 425713 28019=
9  0 23 76  0  0
> 104  0      0 2369573632  32896 1350988    0    0   290     0 430238 2982=
47  0 23 76  0  0
> 86  0      0 2369573632  32896 1350988    0    0   132     0 428019 29186=
5  0 24 76  0  0
> 90  0      0 2369573632  32896 1350988    0    0   502     0 422498 27867=
2  0 23 76  0  0
>
> perf lock record -C0-7 sleep 1; perf lock contention
>  contended   total wait     max wait     avg wait         type   caller
>
>       2524    116.15 ms    486.61 us     46.02 us     spinlock   __dev_qu=
eue_xmit+0x55b
>       5821    107.18 ms    371.67 us     18.41 us     spinlock   dev_hard=
_start_xmit+0xcd
>       2377      9.73 ms     35.86 us      4.09 us     spinlock   ___slab_=
alloc+0x4e0
>        923      5.74 ms     20.91 us      6.22 us     spinlock   ___slab_=
alloc+0x5c9
>        121      3.42 ms    193.05 us     28.24 us     spinlock   net_tx_a=
ction+0xf8
>          6    564.33 us    167.60 us     94.05 us     spinlock   do_softi=
rq+0x5b
>
> If netperf threads are pinned (~54 Mpps)
> perf lock record -C0-7 sleep 1; perf lock contention
>      32907    316.98 ms    195.98 us      9.63 us     spinlock   dev_hard=
_start_xmit+0xcd
>       4507     61.83 ms    212.73 us     13.72 us     spinlock   __dev_qu=
eue_xmit+0x554
>       2781     23.53 ms     40.03 us      8.46 us     spinlock   ___slab_=
alloc+0x5c9
>       3554     18.94 ms     34.69 us      5.33 us     spinlock   ___slab_=
alloc+0x4e0
>        233      9.09 ms    215.70 us     38.99 us     spinlock   do_softi=
rq+0x5b
>        153    930.66 us     48.67 us      6.08 us     spinlock   net_tx_a=
ction+0xfd
>         84    331.10 us     14.22 us      3.94 us     spinlock   ___slab_=
alloc+0x5c9
>        140    323.71 us      9.94 us      2.31 us     spinlock   ___slab_=
alloc+0x4e0
>
> @__dev_queue_xmit_ns:
> [128, 256)       1539830 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             =
     |
> [256, 512)       2299558 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [512, 1K)         483936 |@@@@@@@@@@                                     =
     |
> [1K, 2K)          265345 |@@@@@@                                         =
     |
> [2K, 4K)          145463 |@@@                                            =
     |
> [4K, 8K)           54571 |@                                              =
     |
> [8K, 16K)          10270 |                                               =
     |
> [16K, 32K)          9385 |                                               =
     |
> [32K, 64K)          7749 |                                               =
     |
> [64K, 128K)        26799 |                                               =
     |
> [128K, 256K)        2665 |                                               =
     |
> [256K, 512K)         665 |                                               =
     |
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

This is very cool! One question below, just to make sure I understand
this correctly:

> ---
>  include/net/sch_generic.h |  4 +-
>  net/core/dev.c            | 85 ++++++++++++++++++++++-----------------
>  net/sched/sch_generic.c   |  5 ---
>  3 files changed, 52 insertions(+), 42 deletions(-)
>
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 31561291bc92fd70d4d3ca8f5f7dbc4c94c895a0..94966692ccdf51db085c23631=
9705aecba8c30cf 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -115,7 +115,9 @@ struct Qdisc {
>  	struct Qdisc            *next_sched;
>  	struct sk_buff_head	skb_bad_txq;
>=20=20
> -	spinlock_t		busylock ____cacheline_aligned_in_smp;
> +	atomic_long_t		defer_count ____cacheline_aligned_in_smp;
> +	struct llist_head	defer_list;
> +
>  	spinlock_t		seqlock;
>=20=20
>  	struct rcu_head		rcu;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0ff178399b2d28ca2754b3f06d69a97f5d6dcf71..6094768bf3c028f0ad1e52b9b=
12b7258fa0ecff6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4125,9 +4125,10 @@ static inline int __dev_xmit_skb(struct sk_buff *s=
kb, struct Qdisc *q,
>  				 struct net_device *dev,
>  				 struct netdev_queue *txq)
>  {
> +	struct sk_buff *next, *to_free =3D NULL;
>  	spinlock_t *root_lock =3D qdisc_lock(q);
> -	struct sk_buff *to_free =3D NULL;
> -	bool contended;
> +	struct llist_node *ll_list, *first_n;
> +	unsigned long defer_count =3D 0;
>  	int rc;
>=20=20
>  	qdisc_calculate_pkt_len(skb, q);
> @@ -4167,61 +4168,73 @@ static inline int __dev_xmit_skb(struct sk_buff *=
skb, struct Qdisc *q,
>  		return rc;
>  	}
>=20=20
> -	/*
> -	 * Heuristic to force contended enqueues to serialize on a
> -	 * separate lock before trying to get qdisc main lock.
> -	 * This permits qdisc->running owner to get the lock more
> -	 * often and dequeue packets faster.
> -	 * On PREEMPT_RT it is possible to preempt the qdisc owner during xmit
> -	 * and then other tasks will only enqueue packets. The packets will be
> -	 * sent after the qdisc owner is scheduled again. To prevent this
> -	 * scenario the task always serialize on the lock.
> +	/* Open code llist_add(&skb->ll_node, &q->defer_list) + queue limit.
> +	 * In the try_cmpxchg() loop, we want to increment q->defer_count
> +	 * at most once to limit the number of skbs in defer_list.
> +	 * We perform the defer_count increment only if the list is not empty,
> +	 * because some arches have slow atomic_long_inc_return().
> +	 */
> +	first_n =3D READ_ONCE(q->defer_list.first);
> +	do {
> +		if (first_n && !defer_count) {
> +			defer_count =3D atomic_long_inc_return(&q->defer_count);
> +			if (unlikely(defer_count > q->limit)) {
> +				kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
> +				return NET_XMIT_DROP;
> +			}
> +		}
> +		skb->ll_node.next =3D first_n;
> +	} while (!try_cmpxchg(&q->defer_list.first, &first_n, &skb->ll_node));
> +
> +	/* If defer_list was not empty, we know the cpu which queued
> +	 * the first skb will process the whole list for us.
>  	 */
> -	contended =3D qdisc_is_running(q) || IS_ENABLED(CONFIG_PREEMPT_RT);
> -	if (unlikely(contended))
> -		spin_lock(&q->busylock);
> +	if (first_n)
> +		return NET_XMIT_SUCCESS;
>=20=20
>  	spin_lock(root_lock);
> +
> +	ll_list =3D llist_del_all(&q->defer_list);
> +	/* There is a small race because we clear defer_count not atomically
> +	 * with the prior llist_del_all(). This means defer_list could grow
> +	 * over q->limit.
> +	 */
> +	atomic_long_set(&q->defer_count, 0);
> +
> +	ll_list =3D llist_reverse_order(ll_list);
> +
>  	if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
> -		__qdisc_drop(skb, &to_free);
> +		llist_for_each_entry_safe(skb, next, ll_list, ll_node)
> +			__qdisc_drop(skb, &to_free);
>  		rc =3D NET_XMIT_DROP;
> -	} else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
> -		   qdisc_run_begin(q)) {
> +		goto unlock;
> +	}
> +	rc =3D NET_XMIT_SUCCESS;
> +	if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
> +	    !llist_next(ll_list) && qdisc_run_begin(q)) {
>  		/*
>  		 * This is a work-conserving queue; there are no old skbs
>  		 * waiting to be sent out; and the qdisc is not running -
>  		 * xmit the skb directly.
>  		 */
>=20=20
> +		skb =3D llist_entry(ll_list, struct sk_buff, ll_node);

I was puzzled by this^. But AFAICT, the idea is that in the
non-contended path we're in here (no other CPU enqueueing packets), we
will still have added the skb to the llist before taking the root_lock,
and here we pull it back off the list, right?

Even though this is technically not needed (we'll always get the same
skb back, I think?), so this is mostly for consistency(?)

Assuming I got this right:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


