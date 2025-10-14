Return-Path: <netdev+bounces-229340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6307BDAC10
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A9C18A29C1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF31C305079;
	Tue, 14 Oct 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXqWmegE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE173074BE
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462361; cv=none; b=kcMJWHZfbH21khLFh2nDp9PuaL33ryEZx2GWvn6ysdo/sQ8MdUhnSTup5RHO6K2C76zhsqVvNIF+Mr24bzcuijjKTYQVfU1C363e0mky8sW3zD6Jb76oQ9ss6Bhr+T0pbM40WGH4v0B4lXIfn9+hsH4/wsURCGG7Gn2DpopAE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462361; c=relaxed/simple;
	bh=1h/+ZvRpkHOKvIpk8IdzSj1wbY3Yp/rHGZcmImj+PMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L/ScQa7p7OfRhEclDrYl66IPDB7ehyYpiv+x5o1pAhqqcL1BUSkXTwy4wADOlnlYEKvj9+pZxThzFqq3KgykGMcgOZ2/t1aN2gOVqyoVbgRtae+v7BWkmf/SuYAUj39uY4p7doTJLq24MXf8ZkItHcKeAiwAezdvKG4N/aX3k7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXqWmegE; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-78e5b6f1296so265122646d6.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760462358; x=1761067158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxiFUCkzUHas3SANcdVJBxc4qPBuJeivPRhnN6gdxq4=;
        b=TXqWmegEhvxjYaj05KEICVmV8KlFHuRcAu4K02g+G9M0t1LKGEV3kgjNbaILWeNvVS
         1HGnUTVOjBLsVXxXbcZeD5TaX+to81trLVRZ5hpDXJXZ8pbxo8fJn1eM8siO1H+wkFye
         g4YUyzeYL/RHLOMBH2RZJAc1aKDKQfkVzbsdY3hx4F33kN/RfOIHSDPAvp0ad3v6+ZAn
         nlDOocOz4Gc0Y7nFh7VsD7kq78fbuSBKeif/t+oWm1CuleTrB1x454aoTReF2uKMvpkL
         1FZ9XlatD65IodWeoB2Q6j4Q9kQaPgbYcfaOvL4oK4vG1QY2a7Mte1GTT/PeoLgZwSWP
         tI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760462358; x=1761067158;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YxiFUCkzUHas3SANcdVJBxc4qPBuJeivPRhnN6gdxq4=;
        b=T7RDhPKRR6iBTUPAoBPSKQZTT1oYyONSNozYZkiy/3fFFf13xXE9Mp9Ik7X2CLyL0s
         XRsjOA/6mqIGkpSw2M0vv3LXMgsK1IpPLx3mWKwok//pdH55vr04ckx1jQytmpSgh6lt
         XCcoNkNMKF8VqOnDfG5MN17Xguvpcqztz47kj9FLVxKJDhUbbysPUiC7vB/peQtEX8ZT
         v7pwGQtiTMkzgfXeuPo6o6AMMu5RMhiG6IOIPmsQD4jO76a4779eN1T+rES3Bqp9Fr+x
         lMsz7ZEKNrznmBR7IhTSHSrlStZf41mBXgOJJQqbA8msojD3hzMvetya/Dyds+/tLrde
         7AfA==
X-Forwarded-Encrypted: i=1; AJvYcCXfcltLK3GUqgr6OSJAUEEEo7DD4ACgBOhx9rZZ4k2lgR2hc9HXf8+xOs4XxEhYoC8PlmM3mHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LjlwkG46ALrRlfKZLaUlTJpbnWm+pmoCH3+A0LYAEmOmQOB4
	7B35fkCTCmolyZZaZE9SZTCsZvrY+t/AsdWrPJ4uELi+8ZZoyTcAY8hjpXSqfDFmb30aSQ9L6F/
	UE50WA0FR8XhlhQ==
X-Google-Smtp-Source: AGHT+IHGQShdI1CniJrADx9I4+VgUdX5a1jVMiYs4pNgaoEFQ7RLoViLEjfioQL0Z/Rh60M/DpB2sTQ4chRmDw==
X-Received: from qvbnh3.prod.google.com ([2002:a05:6214:3903:b0:764:e1e8:571d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5aa1:0:b0:7ad:19a4:53e0 with SMTP id 6a1803df08f44-87b21041cdcmr275884896d6.26.1760462358494;
 Tue, 14 Oct 2025 10:19:18 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:19:07 +0000
In-Reply-To: <20251014171907.3554413-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014171907.3554413-7-edumazet@google.com>
Subject: [PATCH v2 net-next 6/6] net: dev_queue_xmit() llist adoption
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Remove busylock spinlock and use a lockless list (llist)
to reduce spinlock contention to the minimum.

Idea is that only one cpu might spin on the qdisc spinlock,
while others simply add their skb in the llist.

After this patch, we get a 300 % improvement on heavy TX workloads.
- Sending twice the number of packets per second.
- While consuming 50 % less cycles.

Note that this also allows in the future to submit batches
to various qdisc->enqueue() methods.

Tested:

- Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
- 100Gbit NIC, 30 TX queues with FQ packet scheduler.
- echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid contention=
 in mm)
- 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"

Before:

16 Mpps (41 Mpps if each thread is pinned to a different cpu)

vmstat 2 5
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu=
-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id =
wa st
243  0      0 2368988672  51036 1100852    0    0   146     1  242   60  0 =
 9 91  0  0
244  0      0 2368988672  51036 1100852    0    0   536    10 487745 14718 =
 0 52 48  0  0
244  0      0 2368988672  51036 1100852    0    0   512     0 503067 46033 =
 0 52 48  0  0
244  0      0 2368988672  51036 1100852    0    0   512     0 494807 12107 =
 0 52 48  0  0
244  0      0 2368988672  51036 1100852    0    0   702    26 492845 10110 =
 0 52 48  0  0

Lock contention (1 second sample taken on 8 cores)
perf lock record -C0-7 sleep 1; perf lock contention
 contended   total wait     max wait     avg wait         type   caller

    442111      6.79 s     162.47 ms     15.35 us     spinlock   dev_hard_s=
tart_xmit+0xcd
      5961      9.57 ms      8.12 us      1.60 us     spinlock   __dev_queu=
e_xmit+0x3a0
       244    560.63 us      7.63 us      2.30 us     spinlock   do_softirq=
+0x5b
        13     25.09 us      3.21 us      1.93 us     spinlock   net_tx_act=
ion+0xf8

If netperf threads are pinned, spinlock stress is very high.
perf lock record -C0-7 sleep 1; perf lock contention
 contended   total wait     max wait     avg wait         type   caller

    964508      7.10 s     147.25 ms      7.36 us     spinlock   dev_hard_s=
tart_xmit+0xcd
       201    268.05 us      4.65 us      1.33 us     spinlock   __dev_queu=
e_xmit+0x3a0
        12     26.05 us      3.84 us      2.17 us     spinlock   do_softirq=
+0x5b

@__dev_queue_xmit_ns:
[256, 512)            21 |                                                 =
   |
[512, 1K)            631 |                                                 =
   |
[1K, 2K)           27328 |@                                                =
   |
[2K, 4K)          265392 |@@@@@@@@@@@@@@@@                                 =
   |
[4K, 8K)          417543 |@@@@@@@@@@@@@@@@@@@@@@@@@@                       =
   |
[8K, 16K)         826292 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[16K, 32K)        733822 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   =
   |
[32K, 64K)         19055 |@                                                =
   |
[64K, 128K)        17240 |@                                                =
   |
[128K, 256K)       25633 |@                                                =
   |
[256K, 512K)           4 |                                                 =
   |

After:

29 Mpps (57 Mpps if each thread is pinned to a different cpu)

vmstat 2 5
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu=
-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id =
wa st
78  0      0 2369573632  32896 1350988    0    0    22     0  331  254  0  =
8 92  0  0
75  0      0 2369573632  32896 1350988    0    0    22    50 425713 280199 =
 0 23 76  0  0
104  0      0 2369573632  32896 1350988    0    0   290     0 430238 298247=
  0 23 76  0  0
86  0      0 2369573632  32896 1350988    0    0   132     0 428019 291865 =
 0 24 76  0  0
90  0      0 2369573632  32896 1350988    0    0   502     0 422498 278672 =
 0 23 76  0  0

perf lock record -C0-7 sleep 1; perf lock contention
 contended   total wait     max wait     avg wait         type   caller

      2524    116.15 ms    486.61 us     46.02 us     spinlock   __dev_queu=
e_xmit+0x55b
      5821    107.18 ms    371.67 us     18.41 us     spinlock   dev_hard_s=
tart_xmit+0xcd
      2377      9.73 ms     35.86 us      4.09 us     spinlock   ___slab_al=
loc+0x4e0
       923      5.74 ms     20.91 us      6.22 us     spinlock   ___slab_al=
loc+0x5c9
       121      3.42 ms    193.05 us     28.24 us     spinlock   net_tx_act=
ion+0xf8
         6    564.33 us    167.60 us     94.05 us     spinlock   do_softirq=
+0x5b

If netperf threads are pinned (~54 Mpps)
perf lock record -C0-7 sleep 1; perf lock contention
     32907    316.98 ms    195.98 us      9.63 us     spinlock   dev_hard_s=
tart_xmit+0xcd
      4507     61.83 ms    212.73 us     13.72 us     spinlock   __dev_queu=
e_xmit+0x554
      2781     23.53 ms     40.03 us      8.46 us     spinlock   ___slab_al=
loc+0x5c9
      3554     18.94 ms     34.69 us      5.33 us     spinlock   ___slab_al=
loc+0x4e0
       233      9.09 ms    215.70 us     38.99 us     spinlock   do_softirq=
+0x5b
       153    930.66 us     48.67 us      6.08 us     spinlock   net_tx_act=
ion+0xfd
        84    331.10 us     14.22 us      3.94 us     spinlock   ___slab_al=
loc+0x5c9
       140    323.71 us      9.94 us      2.31 us     spinlock   ___slab_al=
loc+0x4e0

@__dev_queue_xmit_ns:
[128, 256)       1539830 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               =
   |
[256, 512)       2299558 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[512, 1K)         483936 |@@@@@@@@@@                                       =
   |
[1K, 2K)          265345 |@@@@@@                                           =
   |
[2K, 4K)          145463 |@@@                                              =
   |
[4K, 8K)           54571 |@                                                =
   |
[8K, 16K)          10270 |                                                 =
   |
[16K, 32K)          9385 |                                                 =
   |
[32K, 64K)          7749 |                                                 =
   |
[64K, 128K)        26799 |                                                 =
   |
[128K, 256K)        2665 |                                                 =
   |
[256K, 512K)         665 |                                                 =
   |

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 include/net/sch_generic.h |  4 +-
 net/core/dev.c            | 91 ++++++++++++++++++++++++---------------
 net/sched/sch_generic.c   |  5 ---
 3 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 31561291bc92..94966692ccdf 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -115,7 +115,9 @@ struct Qdisc {
 	struct Qdisc            *next_sched;
 	struct sk_buff_head	skb_bad_txq;
=20
-	spinlock_t		busylock ____cacheline_aligned_in_smp;
+	atomic_long_t		defer_count ____cacheline_aligned_in_smp;
+	struct llist_head	defer_list;
+
 	spinlock_t		seqlock;
=20
 	struct rcu_head		rcu;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0ff178399b2d..4ac9a8262157 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4125,9 +4125,10 @@ static inline int __dev_xmit_skb(struct sk_buff *skb=
, struct Qdisc *q,
 				 struct net_device *dev,
 				 struct netdev_queue *txq)
 {
+	struct sk_buff *next, *to_free =3D NULL;
 	spinlock_t *root_lock =3D qdisc_lock(q);
-	struct sk_buff *to_free =3D NULL;
-	bool contended;
+	struct llist_node *ll_list, *first_n;
+	unsigned long defer_count =3D 0;
 	int rc;
=20
 	qdisc_calculate_pkt_len(skb, q);
@@ -4167,61 +4168,81 @@ static inline int __dev_xmit_skb(struct sk_buff *sk=
b, struct Qdisc *q,
 		return rc;
 	}
=20
-	/*
-	 * Heuristic to force contended enqueues to serialize on a
-	 * separate lock before trying to get qdisc main lock.
-	 * This permits qdisc->running owner to get the lock more
-	 * often and dequeue packets faster.
-	 * On PREEMPT_RT it is possible to preempt the qdisc owner during xmit
-	 * and then other tasks will only enqueue packets. The packets will be
-	 * sent after the qdisc owner is scheduled again. To prevent this
-	 * scenario the task always serialize on the lock.
+	/* Open code llist_add(&skb->ll_node, &q->defer_list) + queue limit.
+	 * In the try_cmpxchg() loop, we want to increment q->defer_count
+	 * at most once to limit the number of skbs in defer_list.
+	 * We perform the defer_count increment only if the list is not empty,
+	 * because some arches have slow atomic_long_inc_return().
+	 */
+	first_n =3D READ_ONCE(q->defer_list.first);
+	do {
+		if (first_n && !defer_count) {
+			defer_count =3D atomic_long_inc_return(&q->defer_count);
+			if (unlikely(defer_count > q->limit)) {
+				kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
+				return NET_XMIT_DROP;
+			}
+		}
+		skb->ll_node.next =3D first_n;
+	} while (!try_cmpxchg(&q->defer_list.first, &first_n, &skb->ll_node));
+
+	/* If defer_list was not empty, we know the cpu which queued
+	 * the first skb will process the whole list for us.
 	 */
-	contended =3D qdisc_is_running(q) || IS_ENABLED(CONFIG_PREEMPT_RT);
-	if (unlikely(contended))
-		spin_lock(&q->busylock);
+	if (first_n)
+		return NET_XMIT_SUCCESS;
=20
 	spin_lock(root_lock);
+
+	ll_list =3D llist_del_all(&q->defer_list);
+	/* There is a small race because we clear defer_count not atomically
+	 * with the prior llist_del_all(). This means defer_list could grow
+	 * over q->limit.
+	 */
+	atomic_long_set(&q->defer_count, 0);
+
+	ll_list =3D llist_reverse_order(ll_list);
+
 	if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
-		__qdisc_drop(skb, &to_free);
+		llist_for_each_entry_safe(skb, next, ll_list, ll_node)
+			__qdisc_drop(skb, &to_free);
 		rc =3D NET_XMIT_DROP;
-	} else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
-		   qdisc_run_begin(q)) {
+		goto unlock;
+	}
+	if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
+	    !llist_next(ll_list) && qdisc_run_begin(q)) {
 		/*
 		 * This is a work-conserving queue; there are no old skbs
 		 * waiting to be sent out; and the qdisc is not running -
 		 * xmit the skb directly.
 		 */
=20
+		DEBUG_NET_WARN_ON_ONCE(skb !=3D llist_entry(ll_list,
+							  struct sk_buff,
+							  ll_node));
 		qdisc_bstats_update(q, skb);
-
-		if (sch_direct_xmit(skb, q, dev, txq, root_lock, true)) {
-			if (unlikely(contended)) {
-				spin_unlock(&q->busylock);
-				contended =3D false;
-			}
+		if (sch_direct_xmit(skb, q, dev, txq, root_lock, true))
 			__qdisc_run(q);
-		}
-
 		qdisc_run_end(q);
 		rc =3D NET_XMIT_SUCCESS;
 	} else {
-		rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
-		if (qdisc_run_begin(q)) {
-			if (unlikely(contended)) {
-				spin_unlock(&q->busylock);
-				contended =3D false;
-			}
-			__qdisc_run(q);
-			qdisc_run_end(q);
+		int count =3D 0;
+
+		llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
+			prefetch(next);
+			skb_mark_not_on_list(skb);
+			rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
+			count++;
 		}
+		qdisc_run(q);
+		if (count !=3D 1)
+			rc =3D NET_XMIT_SUCCESS;
 	}
+unlock:
 	spin_unlock(root_lock);
 	if (unlikely(to_free))
 		kfree_skb_list_reason(to_free,
 				      tcf_get_drop_reason(to_free));
-	if (unlikely(contended))
-		spin_unlock(&q->busylock);
 	return rc;
 }
=20
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index dfa8e8e667d2..d9a98d02a55f 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -666,7 +666,6 @@ struct Qdisc noop_qdisc =3D {
 	.ops		=3D	&noop_qdisc_ops,
 	.q.lock		=3D	__SPIN_LOCK_UNLOCKED(noop_qdisc.q.lock),
 	.dev_queue	=3D	&noop_netdev_queue,
-	.busylock	=3D	__SPIN_LOCK_UNLOCKED(noop_qdisc.busylock),
 	.gso_skb =3D {
 		.next =3D (struct sk_buff *)&noop_qdisc.gso_skb,
 		.prev =3D (struct sk_buff *)&noop_qdisc.gso_skb,
@@ -970,10 +969,6 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_que=
ue,
 		}
 	}
=20
-	spin_lock_init(&sch->busylock);
-	lockdep_set_class(&sch->busylock,
-			  dev->qdisc_tx_busylock ?: &qdisc_tx_busylock);
-
 	/* seqlock has the same scope of busylock, for NOLOCK qdisc */
 	spin_lock_init(&sch->seqlock);
 	lockdep_set_class(&sch->seqlock,
--=20
2.51.0.788.g6d19910ace-goog


