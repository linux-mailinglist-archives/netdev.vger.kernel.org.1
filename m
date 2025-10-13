Return-Path: <netdev+bounces-228811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92ABBD3F5A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070251888F72
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9730C63F;
	Mon, 13 Oct 2025 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLCzkVjW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D8314D3D
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367270; cv=none; b=hv+ya0XVlLhfvlod/TkSfWHF5NqcR96ci5so9t4Qk49Q5CsW6xOQenyp/qys1rhbbMUVla+/c6Iq3yC1CGOGLdr6CxfVxH37ZRs61AUi2O3PPur1dpvfEDUOf27JSZlwE1j4Ip9hcnHk+RYB7vLrjGgr6IBvbFK2SI+9xpSeVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367270; c=relaxed/simple;
	bh=36vxmSB0z4FZZdNj4ex4IazgVJn4PPsBJJ+EiDXknQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NO+brA8gfjWEaHg9OMvjn32nKCuvmFClWEDtH8VyWe2iqHNUauD2zkG9otv3Yy1NfTmMWgPpQXU+IA8yZ1z8IBYQVlJpnCVNNa7E/E1j2wqoc96K22djfPzo0j83sALGuDbpBeuHvDesPK6mGwcmbMP3u7AbszNGVlDtH4CsQ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLCzkVjW; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-828bd08624aso2197671685a.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760367267; x=1760972067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KEDrbXMrSbEfZ/eySFCHgxAM/WnlXU9thvyc7fPFe8=;
        b=gLCzkVjWJHhCWPrrhngi4tqg5KqSLV16aktjv4OZaMgcF4RISsppghIXg9x3x0FcGw
         A5387/SZ06npCNHLKo8SMvf45HLKQOcfEBpeAeG0GQskxDkfpER3ZmcqsNbgYgTu+3ke
         pC5r/AcdVIZi0ZPHtRsuozV7jKWecQkwlLewS+fotiPjiVtS9vpxi27yHKz0QcMn9C0i
         jQs/HVU91R0BSZsIIN36lySCnQHMWyPGsFL3z1PKu5fdBMt+T9pmWPFmY0EzRR9OM0NY
         WVC4zINDbqgnV82loZcgJ2LaAHnKOw9Yj1if0MiOAhK8BDvQ6RuRDCgRZ6RyrmXdsKR/
         46gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367267; x=1760972067;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6KEDrbXMrSbEfZ/eySFCHgxAM/WnlXU9thvyc7fPFe8=;
        b=RLT79F4pF6RHpGfQNaNZgmXt+RgKd77ES3FB7oKjzeE2VoBhpVuqft/zTdsSO7fpPy
         qufOstjVjrsGlxE5IGCIrgWfbZ61gGFncaPhjqsInnvrrqSWNDm6bBBuLM7H177QwefA
         wxauNWTL9Ft/RSUTuAMWV80+3BSJ/X57sIr4hDMGryJMD7IpdBx4JBOMs1/o5b9d9spG
         oSfEL3VvStgHsCQlGHVJWO/UF0g+bIQj2Qqb1Ch6pX1F6Gqy1IgdhwOo+VU9GVLEZ0sA
         GBxUEe1jCzMFMpG+6PcwYU7R+ILuEGS4yQj2NK7OR5l2CknZobul7MWDVeJBDiw+brp2
         M4Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVtFM6UztuGhOMTxC1ajmMuOHunHMc3xJFGK0GUhJhdC9h1+xoVgZDQaBUk8O97B6SVv6cndfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTCIn4b2giOkHoLa5ucZ5fUtLgyktlw3GXAGt08IDFjg7fc0A2
	Kl8w+Cn1G/YGHotZxdpjgQNHo3ZDslcTGchhC4fJ2NOY1PpaPH2oZCLWiiM6kmZDdjQQmdF6UQI
	GYXfOdOBliXKxUA==
X-Google-Smtp-Source: AGHT+IGUS2fW9EhyvW7Br6IWWv3xe23xdD5cSbKplAXM0Iw78LPPGRXJpFh/9RYlgDdTiefN+1ZD0UsDnzA60g==
X-Received: from qtvx9.prod.google.com ([2002:ac8:4d49:0:b0:4b7:ad52:c8a6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:578a:b0:4d1:7a05:9328 with SMTP id d75a77b69052e-4e6eabf9191mr300676381cf.0.1760367266859;
 Mon, 13 Oct 2025 07:54:26 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:54:16 +0000
In-Reply-To: <20251013145416.829707-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013145416.829707-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013145416.829707-6-edumazet@google.com>
Subject: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
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
 net/core/dev.c            | 88 +++++++++++++++++++++++----------------
 net/sched/sch_generic.c   |  5 ---
 3 files changed, 55 insertions(+), 42 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 31561291bc92fd70d4d3ca8f5f7dbc4c94c895a0..94966692ccdf51db085c2363197=
05aecba8c30cf 100644
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
index 0ff178399b2d28ca2754b3f06d69a97f5d6dcf71..e281bae9b15046fa435c3a7cc9e=
aeb0b5609bab4 100644
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
@@ -4167,61 +4168,76 @@ static inline int __dev_xmit_skb(struct sk_buff *sk=
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
+	rc =3D NET_XMIT_SUCCESS;
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
-		rc =3D NET_XMIT_SUCCESS;
 	} else {
-		rc =3D dev_qdisc_enqueue(skb, q, &to_free, txq);
-		if (qdisc_run_begin(q)) {
-			if (unlikely(contended)) {
-				spin_unlock(&q->busylock);
-				contended =3D false;
-			}
-			__qdisc_run(q);
-			qdisc_run_end(q);
+		llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
+			prefetch(next);
+			skb_mark_not_on_list(skb);
+			dev_qdisc_enqueue(skb, q, &to_free, txq);
 		}
+		qdisc_run(q);
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
index dfa8e8e667d24a435b0c9cb3c1f05c8075f63e89..d9a98d02a55fc361a223f3201e3=
7b6a2b698bb5e 100644
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
2.51.0.740.g6adb054d12-goog


