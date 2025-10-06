Return-Path: <netdev+bounces-228023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8F2BBF199
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 21:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E1084EBFC1
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F2521FF41;
	Mon,  6 Oct 2025 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tWR6Pmnb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A71E412A
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779078; cv=none; b=TeJnGxHNyIzvanRUPHWxAUr06slLX4hCQvSf9/Q0S5BWpZElF4j+pmKEIkBb1ATQsv8UXghUYxLSIM9qUNjKOJD3fK5x/921H3vxN4lshjpwCunbx/ajSATUR2UkQ3gJNHEmuQd1ML8ALrPo2lHO9a50uFBi66SVGpSCIc6yGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779078; c=relaxed/simple;
	bh=KQMNlx3RNtXfyuX9jsq62HyVN573U2X7C1JGwhCsIc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cn/fOPC6TED61+NdBgOl1N+sDVbw3kYq2JUhJCEsjc7yR4XKWKqtO7r+GiOn3DWzg+kBxldgyjmJ75oOUyh8YXW0JUq8MgCivbQjJ+jLAf8Qn+N+FuXu0Y6+JQe8j3qLjv65SNaj+qpiKCQLjbB33ZiiSaK+gPryXwKPeR+zIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tWR6Pmnb; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-588c87efb7dso10450827137.2
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 12:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759779075; x=1760383875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5668pvtDn/NMzJvHaQVIGWhw4mJczN2cg3jNctRALX4=;
        b=tWR6Pmnb67osOwbR4GZJ/xLzCt8J9KDu+JKzaqkARGmi89hdcjsP/PPMoU9ZSmF03h
         KF6t4gSUmawA5qJAIsH8HimJu7wqmT6YnheqbQJ2AIs70WAqw2jBKu0v/uXSq4A6jjl2
         ho3Jm/M3g3n9r8TImm2XA4man7wuVxTQ8TgMMwFrSmbOHb491jEYbJBdTwSrutHpW4BQ
         XnQSwtwegn8fkl2iRK9Fkr1GKYEgbZuYaIRpbjIyzUULUF7Om8QXTN7oI9kU2NSolXq6
         N3N/Inc3B9l1Z55thidzZ0apZPCYOzOMSav54ZUPnywcAVQnvLZlee6osbyn7f8mu8R9
         ZDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759779075; x=1760383875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5668pvtDn/NMzJvHaQVIGWhw4mJczN2cg3jNctRALX4=;
        b=f7ZaqCHzmTZjQteQprncTRDcQwYfLdJ3WS/Y1W70OX4tg7VkKQ/1WN7RHFw//nFnNB
         DnDfe7DWY415Sw4Ar/xCo/zpC3wB59Y19ycVBEbxJONKqhJc1+TutjAQcSsj2iBusBy+
         +RcETZGNyFHwJC9fTdoB/s7YktAq0u58pxsNGMmNFt5B6P8wY7en/an8MJeS0tnsvvx3
         bzgu3+Zex9/ef5kDhipNLVquDgWNIY7nDlwriPJJ03aXUeRAgzjkk8+LzUGT0oIXOg9Z
         JO4iOjVTJ3yIeziVOkabBdxOe7Qr1GQhUQ7ocm9UkzneRGYF2aHz6UmIOR2ZEK1Lxlpm
         zyWg==
X-Forwarded-Encrypted: i=1; AJvYcCUDfns9ZPAYGSnfZ8Fk4ckHtoGx4mjo9lonbL+yi2uSrkTcdq9x6GPpPDNqM8+GCY7IbG2bs5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yz9jfpHXHO7bGbgCxIUexgeHrH9nrQ2chXFxYC1KfBh8b8nX
	R7SjbHkXiAR+NFHrAWi3GKxnTUMe6S1Kb3hX4CeF1eHfq46t9xQd2Pf2NbmUJn3v6tIcwkiS0p9
	AaSqeunjsDfBRMg==
X-Google-Smtp-Source: AGHT+IHVTM7eAvYWQBF0QERisi6jxb6m88j67Rkb66W8myxVC1BpmN0EIF/nGgvs2RXwGIhtF3r7vdGO3DsC3w==
X-Received: from vsvj18.prod.google.com ([2002:a05:6102:3e12:b0:5d5:d54c:ddd7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:1606:b0:59c:6e9d:23bb with SMTP id ada2fe7eead31-5d41d11312cmr5772292137.17.1759779075286;
 Mon, 06 Oct 2025 12:31:15 -0700 (PDT)
Date: Mon,  6 Oct 2025 19:31:03 +0000
In-Reply-To: <20251006193103.2684156-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006193103.2684156-6-edumazet@google.com>
Subject: [PATCH RFC net-next 5/5] net: dev_queue_xmit() llist adoption
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove busylock spinlock and use a lockless list (llist)
to reduce spinlock contention to the minimum.

Idea is that only one cpu might spin on the qdisc spinlock,
while others simply add their skb in the llist.

After this patch, we get a 300 % improvement on heavy TX workloads.
- Sending twice the number of packets per second.
- While consuming 50 % less cycles.

Tested:

- Dual Intel(R) Xeon(R) 6985P-C  (480 hyper threads).
- 100Gbit NIC, 30 TX queues with FQ packet scheduler.
- echo 64 >/sys/kernel/slab/skbuff_small_head/cpu_partial (avoid contention in mm)
- 240 concurrent "netperf -t UDP_STREAM -- -m 120 -n"

Before:

16 Mpps (41 Mpps if each thread is pinned to a different cpu)

vmstat 2 5
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
243  0      0 2368988672  51036 1100852    0    0   146     1  242   60  0  9 91  0  0
244  0      0 2368988672  51036 1100852    0    0   536    10 487745 14718  0 52 48  0  0
244  0      0 2368988672  51036 1100852    0    0   512     0 503067 46033  0 52 48  0  0
244  0      0 2368988672  51036 1100852    0    0   512     0 494807 12107  0 52 48  0  0
244  0      0 2368988672  51036 1100852    0    0   702    26 492845 10110  0 52 48  0  0

Lock contention (1 second sample taken on 8 cores)
perf lock record -C0-7 sleep 1; perf lock contention
 contended   total wait     max wait     avg wait         type   caller

    442111      6.79 s     162.47 ms     15.35 us     spinlock   dev_hard_start_xmit+0xcd
      5961      9.57 ms      8.12 us      1.60 us     spinlock   __dev_queue_xmit+0x3a0
       244    560.63 us      7.63 us      2.30 us     spinlock   do_softirq+0x5b
        13     25.09 us      3.21 us      1.93 us     spinlock   net_tx_action+0xf8

If netperf threads are pinned, spinlock stress is very high.
perf lock record -C0-7 sleep 1; perf lock contention
 contended   total wait     max wait     avg wait         type   caller

    964508      7.10 s     147.25 ms      7.36 us     spinlock   dev_hard_start_xmit+0xcd
       201    268.05 us      4.65 us      1.33 us     spinlock   __dev_queue_xmit+0x3a0
        12     26.05 us      3.84 us      2.17 us     spinlock   do_softirq+0x5b

@__dev_queue_xmit_ns:
[256, 512)            21 |                                                    |
[512, 1K)            631 |                                                    |
[1K, 2K)           27328 |@                                                   |
[2K, 4K)          265392 |@@@@@@@@@@@@@@@@                                    |
[4K, 8K)          417543 |@@@@@@@@@@@@@@@@@@@@@@@@@@                          |
[8K, 16K)         826292 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[16K, 32K)        733822 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
[32K, 64K)         19055 |@                                                   |
[64K, 128K)        17240 |@                                                   |
[128K, 256K)       25633 |@                                                   |
[256K, 512K)           4 |                                                    |

After:

29 Mpps (57 Mpps if each thread is pinned to a different cpu)

vmstat 2 5
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
78  0      0 2369573632  32896 1350988    0    0    22     0  331  254  0  8 92  0  0
75  0      0 2369573632  32896 1350988    0    0    22    50 425713 280199  0 23 76  0  0
104  0      0 2369573632  32896 1350988    0    0   290     0 430238 298247  0 23 76  0  0
86  0      0 2369573632  32896 1350988    0    0   132     0 428019 291865  0 24 76  0  0
90  0      0 2369573632  32896 1350988    0    0   502     0 422498 278672  0 23 76  0  0

perf lock record -C0-7 sleep 1; perf lock contention
 contended   total wait     max wait     avg wait         type   caller

      2524    116.15 ms    486.61 us     46.02 us     spinlock   __dev_queue_xmit+0x55b
      5821    107.18 ms    371.67 us     18.41 us     spinlock   dev_hard_start_xmit+0xcd
      2377      9.73 ms     35.86 us      4.09 us     spinlock   ___slab_alloc+0x4e0
       923      5.74 ms     20.91 us      6.22 us     spinlock   ___slab_alloc+0x5c9
       121      3.42 ms    193.05 us     28.24 us     spinlock   net_tx_action+0xf8
         6    564.33 us    167.60 us     94.05 us     spinlock   do_softirq+0x5b

If netperf threads are pinned (~54 Mpps)
perf lock record -C0-7 sleep 1; perf lock contention
     32907    316.98 ms    195.98 us      9.63 us     spinlock   dev_hard_start_xmit+0xcd
      4507     61.83 ms    212.73 us     13.72 us     spinlock   __dev_queue_xmit+0x554
      2781     23.53 ms     40.03 us      8.46 us     spinlock   ___slab_alloc+0x5c9
      3554     18.94 ms     34.69 us      5.33 us     spinlock   ___slab_alloc+0x4e0
       233      9.09 ms    215.70 us     38.99 us     spinlock   do_softirq+0x5b
       153    930.66 us     48.67 us      6.08 us     spinlock   net_tx_action+0xfd
        84    331.10 us     14.22 us      3.94 us     spinlock   ___slab_alloc+0x5c9
       140    323.71 us      9.94 us      2.31 us     spinlock   ___slab_alloc+0x4e0

@__dev_queue_xmit_ns:
[128, 256)       1539830 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                  |
[256, 512)       2299558 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)         483936 |@@@@@@@@@@                                          |
[1K, 2K)          265345 |@@@@@@                                              |
[2K, 4K)          145463 |@@@                                                 |
[4K, 8K)           54571 |@                                                   |
[8K, 16K)          10270 |                                                    |
[16K, 32K)          9385 |                                                    |
[32K, 64K)          7749 |                                                    |
[64K, 128K)        26799 |                                                    |
[128K, 256K)        2665 |                                                    |
[256K, 512K)         665 |                                                    |

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h |  4 +-
 net/core/dev.c            | 85 ++++++++++++++++++++++-----------------
 net/sched/sch_generic.c   |  5 ---
 3 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 31561291bc92fd70d4d3ca8f5f7dbc4c94c895a0..94966692ccdf51db085c236319705aecba8c30cf 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -115,7 +115,9 @@ struct Qdisc {
 	struct Qdisc            *next_sched;
 	struct sk_buff_head	skb_bad_txq;
 
-	spinlock_t		busylock ____cacheline_aligned_in_smp;
+	atomic_long_t		defer_count ____cacheline_aligned_in_smp;
+	struct llist_head	defer_list;
+
 	spinlock_t		seqlock;
 
 	struct rcu_head		rcu;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0ff178399b2d28ca2754b3f06d69a97f5d6dcf71..6094768bf3c028f0ad1e52b9b12b7258fa0ecff6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4125,9 +4125,10 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 				 struct net_device *dev,
 				 struct netdev_queue *txq)
 {
+	struct sk_buff *next, *to_free = NULL;
 	spinlock_t *root_lock = qdisc_lock(q);
-	struct sk_buff *to_free = NULL;
-	bool contended;
+	struct llist_node *ll_list, *first_n;
+	unsigned long defer_count = 0;
 	int rc;
 
 	qdisc_calculate_pkt_len(skb, q);
@@ -4167,61 +4168,73 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 		return rc;
 	}
 
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
+	first_n = READ_ONCE(q->defer_list.first);
+	do {
+		if (first_n && !defer_count) {
+			defer_count = atomic_long_inc_return(&q->defer_count);
+			if (unlikely(defer_count > q->limit)) {
+				kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
+				return NET_XMIT_DROP;
+			}
+		}
+		skb->ll_node.next = first_n;
+	} while (!try_cmpxchg(&q->defer_list.first, &first_n, &skb->ll_node));
+
+	/* If defer_list was not empty, we know the cpu which queued
+	 * the first skb will process the whole list for us.
 	 */
-	contended = qdisc_is_running(q) || IS_ENABLED(CONFIG_PREEMPT_RT);
-	if (unlikely(contended))
-		spin_lock(&q->busylock);
+	if (first_n)
+		return NET_XMIT_SUCCESS;
 
 	spin_lock(root_lock);
+
+	ll_list = llist_del_all(&q->defer_list);
+	/* There is a small race because we clear defer_count not atomically
+	 * with the prior llist_del_all(). This means defer_list could grow
+	 * over q->limit.
+	 */
+	atomic_long_set(&q->defer_count, 0);
+
+	ll_list = llist_reverse_order(ll_list);
+
 	if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state))) {
-		__qdisc_drop(skb, &to_free);
+		llist_for_each_entry_safe(skb, next, ll_list, ll_node)
+			__qdisc_drop(skb, &to_free);
 		rc = NET_XMIT_DROP;
-	} else if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
-		   qdisc_run_begin(q)) {
+		goto unlock;
+	}
+	rc = NET_XMIT_SUCCESS;
+	if ((q->flags & TCQ_F_CAN_BYPASS) && !qdisc_qlen(q) &&
+	    !llist_next(ll_list) && qdisc_run_begin(q)) {
 		/*
 		 * This is a work-conserving queue; there are no old skbs
 		 * waiting to be sent out; and the qdisc is not running -
 		 * xmit the skb directly.
 		 */
 
+		skb = llist_entry(ll_list, struct sk_buff, ll_node);
 		qdisc_bstats_update(q, skb);
-
-		if (sch_direct_xmit(skb, q, dev, txq, root_lock, true)) {
-			if (unlikely(contended)) {
-				spin_unlock(&q->busylock);
-				contended = false;
-			}
+		if (sch_direct_xmit(skb, q, dev, txq, root_lock, true))
 			__qdisc_run(q);
-		}
-
 		qdisc_run_end(q);
-		rc = NET_XMIT_SUCCESS;
 	} else {
-		rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
-		if (qdisc_run_begin(q)) {
-			if (unlikely(contended)) {
-				spin_unlock(&q->busylock);
-				contended = false;
-			}
-			__qdisc_run(q);
-			qdisc_run_end(q);
+		llist_for_each_entry_safe(skb, next, ll_list, ll_node) {
+			prefetch(next);
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
 
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index dfa8e8e667d24a435b0c9cb3c1f05c8075f63e89..d9a98d02a55fc361a223f3201e37b6a2b698bb5e 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -666,7 +666,6 @@ struct Qdisc noop_qdisc = {
 	.ops		=	&noop_qdisc_ops,
 	.q.lock		=	__SPIN_LOCK_UNLOCKED(noop_qdisc.q.lock),
 	.dev_queue	=	&noop_netdev_queue,
-	.busylock	=	__SPIN_LOCK_UNLOCKED(noop_qdisc.busylock),
 	.gso_skb = {
 		.next = (struct sk_buff *)&noop_qdisc.gso_skb,
 		.prev = (struct sk_buff *)&noop_qdisc.gso_skb,
@@ -970,10 +969,6 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 		}
 	}
 
-	spin_lock_init(&sch->busylock);
-	lockdep_set_class(&sch->busylock,
-			  dev->qdisc_tx_busylock ?: &qdisc_tx_busylock);
-
 	/* seqlock has the same scope of busylock, for NOLOCK qdisc */
 	spin_lock_init(&sch->seqlock);
 	lockdep_set_class(&sch->seqlock,
-- 
2.51.0.618.g983fd99d29-goog


