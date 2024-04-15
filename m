Return-Path: <netdev+bounces-88113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CC48A5CA4
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 23:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46B21F23838
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 21:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2032156988;
	Mon, 15 Apr 2024 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vnF+K6tU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751E15698B
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215256; cv=none; b=s9VTVZOocoZ+F5iSMx3tX8wFyx05pmiJTspoKfj0nY6G517LQBNvhyQURIxYmq43ZXetJuPO5ozkjf4IXTVYQVWLOK1w5yO3w4uz6Y7+pgnkJr5sGPkwDOTc6koiMwX4adbBOO624DYHE56mZXiZFBlJTL4dWDfg/9bgZkFGb04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215256; c=relaxed/simple;
	bh=+Rgoyfq/UWK5Wd6t8sltN5HvOvj/Ag/2cpHi8aCq+7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BqaXCftclonkzSEKv/wvznDP5DuEBYhXzRhJTqA4QnTZ6Mih7gLKcx5UHJyTZWYrG2JJbbg7DK0WcKj9lV3BnqjHKNDilnzCUIsxQPYwdqNR4eF1J3tqx0aHtT6bUGKD9PovMC3Z/WgJP5uN2EPUvQhF/lr/BDZKrtlZTRTICkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=vnF+K6tU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3ff14f249so28401345ad.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 14:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1713215253; x=1713820053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=io++w2syYAvewTWIvHlSjNKUrApibADwv6cCP9jP8kY=;
        b=vnF+K6tU+TfbDfI1GGgwFELvsd2Esc7GWGg6eXl3ROZBT3psvhWgUs2SxF46akZexe
         zNbw9f3GTDevuRLOZGS9x0rI6gRdFoxG9uKnj/cR0aVVV2k0nzAS2cc0tNz6EchPXOK2
         G3XohswCWSIYplso9hIgLRYTBdcVRFCluFgcUi9/hnUg83OBTATJhfataMeKYNRjXpqx
         V6WjfkqD06ydyyzVF7WWTsNBhWXzpJGlDwfKaq7pfRTGPNDyR3aGYrGGACJyvSZAuzgd
         9C+f0pV+2n51ec+honLdLtwHhwuwR7muRcPmp3g4AbOJqV+5+SOAbMoeKUprSprw7nc+
         OvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713215253; x=1713820053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=io++w2syYAvewTWIvHlSjNKUrApibADwv6cCP9jP8kY=;
        b=OLWI7+OV7oibtOONNqGuOhcK/vJ5E/BZoHu7HAlUkwXa77WcI+nECH5YGAhKrkW+qd
         99cAirPfKoq0fbBpJzwqLw3ypRlE2jbmQRl9D794fiiLAqY2OJ+gmpfk29asZoCQ1wDV
         Aq+XjAhSspQ3sX2jFbKUacLnkvhuMmxQTogVHeK65Q/036qv15ekQci7O9uS4yUowOzv
         IV/ieiDHPWdecG1Zj/OLmDSppR3KyBz456i9HWpw23LDeBLdth6Z6vqYRhmsZ6+/4jsx
         1tGwYTj4pQf0yN1WhqMWSeeZ6E7rASB2WKyGhbaUElYKsCQTbe2QigLkjN4rvT7pOBL6
         bqsw==
X-Forwarded-Encrypted: i=1; AJvYcCWIlDDYLo04EJ9fMgN3ueda9qE4W16s0J/6chZTiN1TDMLkE2Wh2/AzDUC6KBpQpL/VAnjMUretUFCYqdeXBcQGV35j+arh
X-Gm-Message-State: AOJu0YxFlv8bFUhFiglYIIekp6V9gG3BDi/M/qH5m6XwTjJBXNfkfMoX
	Uw8YtnSMYVyvggxedWQLUxiyrATfhISXFc0Es8mVS1oxH26xXbYkx3P7C8AiC9yHcOL4o+ISNDA
	=
X-Google-Smtp-Source: AGHT+IF1VyIvJezby232mSu4XaekgWptP07iThOVGW4juut5JhF6YNjQa+/aGAeuPiZPMtrGjVod/Q==
X-Received: by 2002:a17:902:d2c2:b0:1e2:45f3:2d57 with SMTP id n2-20020a170902d2c200b001e245f32d57mr206916plc.6.1713215253203;
        Mon, 15 Apr 2024 14:07:33 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c3:6d3a:2639:3444:5313:18de])
        by smtp.gmail.com with ESMTPSA id b18-20020a170903229200b001e21ddacb20sm8328239plh.297.2024.04.15.14.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:07:32 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	renmingshuai@huawei.com,
	pctammela@mojatatu.com
Subject: [PATCH net] net/sched: Fix mirred deadlock on device recursion
Date: Mon, 15 Apr 2024 18:07:28 -0300
Message-ID: <20240415210728.36949-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

When the mirred action is used on a classful egress qdisc and a packet is
mirrored or redirected to self we hit a qdisc lock deadlock.
See trace below.

[..... other info removed for brevity....]
[   82.890906]
[   82.890906] ============================================
[   82.890906] WARNING: possible recursive locking detected
[   82.890906] 6.8.0-05205-g77fadd89fe2d-dirty #213 Tainted: G        W
[   82.890906] --------------------------------------------
[   82.890906] ping/418 is trying to acquire lock:
[   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
__dev_queue_xmit+0x1778/0x3550
[   82.890906]
[   82.890906] but task is already holding lock:
[   82.890906] ffff888006994110 (&sch->q.lock){+.-.}-{3:3}, at:
__dev_queue_xmit+0x1778/0x3550
[   82.890906]
[   82.890906] other info that might help us debug this:
[   82.890906]  Possible unsafe locking scenario:
[   82.890906]
[   82.890906]        CPU0
[   82.890906]        ----
[   82.890906]   lock(&sch->q.lock);
[   82.890906]   lock(&sch->q.lock);
[   82.890906]
[   82.890906]  *** DEADLOCK ***
[   82.890906]
[..... other info removed for brevity....]

Example setup (eth0->eth0) to recreate
tc qdisc add dev eth0 root handle 1: htb default 30
tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
     action mirred egress redirect dev eth0

Another example(eth0->eth1->eth0) to recreate
tc qdisc add dev eth0 root handle 1: htb default 30
tc filter add dev eth0 handle 1: protocol ip prio 2 matchall \
     action mirred egress redirect dev eth1

tc qdisc add dev eth1 root handle 1: htb default 30
tc filter add dev eth1 handle 1: protocol ip prio 2 matchall \
     action mirred egress redirect dev eth0

We fix this by adding an owner field (CPU id) to struct Qdisc set after
root qdisc is entered. When the softirq enters it a second time, if the
qdisc owner is the same CPU, the packet is dropped to break the loop.

Reported-by: Mingshuai Ren <renmingshuai@huawei.com>
Closes: https://lore.kernel.org/netdev/20240314111713.5979-1-renmingshuai@huawei.com/
Fixes: 3bcb846ca4cf ("net: get rid of spin_trylock() in net_tx_action()")
Fixes: e578d9c02587 ("net: sched: use counter to break reclassify loops")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/sch_generic.h | 1 +
 net/core/dev.c            | 6 ++++++
 net/sched/sch_generic.c   | 1 +
 3 files changed, 8 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 76db6be16083..f561dfb79743 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -117,6 +117,7 @@ struct Qdisc {
 	struct qdisc_skb_head	q;
 	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue	qstats;
+	int                     owner;
 	unsigned long		state;
 	unsigned long		state2; /* must be written under qdisc spinlock */
 	struct Qdisc            *next_sched;
diff --git a/net/core/dev.c b/net/core/dev.c
index 854a3a28a8d8..f6c6e494f0a9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3808,6 +3808,10 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 		return rc;
 	}
 
+	if (unlikely(READ_ONCE(q->owner) == smp_processor_id())) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_TC_RECLASSIFY_LOOP);
+		return NET_XMIT_DROP;
+	}
 	/*
 	 * Heuristic to force contended enqueues to serialize on a
 	 * separate lock before trying to get qdisc main lock.
@@ -3847,7 +3851,9 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 		qdisc_run_end(q);
 		rc = NET_XMIT_SUCCESS;
 	} else {
+		WRITE_ONCE(q->owner, smp_processor_id());
 		rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
+		WRITE_ONCE(q->owner, -1);
 		if (qdisc_run_begin(q)) {
 			if (unlikely(contended)) {
 				spin_unlock(&q->busylock);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ff5336493777..4a2c763e2d11 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -974,6 +974,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	sch->enqueue = ops->enqueue;
 	sch->dequeue = ops->dequeue;
 	sch->dev_queue = dev_queue;
+	sch->owner = -1;
 	netdev_hold(dev, &sch->dev_tracker, GFP_KERNEL);
 	refcount_set(&sch->refcnt, 1);
 
-- 
2.34.1


