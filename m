Return-Path: <netdev+bounces-228809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E3BD4057
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FE4F503027
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508E4315767;
	Mon, 13 Oct 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ar6JM4Vr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6730C63E
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367266; cv=none; b=PAvI3QgQL9Ga4vaTB/GWBxS7S/dwB5EN+6YAn0ig2GsDcxP+oz/5qrWRCLeIOsI5NUgZMuXFsZl1VPvOW+5SsLEgZ57OCwrzBtxB3Z46aGnJScrZ1cnsKp4S2GhxzNbMC0zJrpN3iREuBkRGonqjFM5CFmZ5aG9L3DfpjB5vyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367266; c=relaxed/simple;
	bh=h8k+Ju9Ll6qwREnE91ITXQPOMnzDGV9lHMTewp66ILs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T+J4IPLfzRKA5tVoaLogM/7ciHt4cr7FW5gJU4scPU5qArYoV+yuNtqzOLpMV2Ev7JC+Rhgy4OaWk5+M4EkTBT2S3DvvRQ0I3rEmoiJ6PjlW7pnT/PdoMGNVJRwFocZnXK1NjWo/KvNLgE+leq/MKBooqKbCLR23pdKbfiFFCPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ar6JM4Vr; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-78f28554393so230920016d6.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760367263; x=1760972063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mbnH3fDruZwPLY+aCr9UtQbP7MAEM3RXr5i56ltBskw=;
        b=Ar6JM4Vrf0L3efFWUO6sm7+JBx7d0L02KJ3yZM22VxXpHTo+VN63y0LwpRGV4E+uqA
         fLFNHuDobu+81CEJME85uM5I+wZpvJiyjtEhOOxy4sZfVZZYBsmAE6ju2PlTtYBedLDi
         dYwA5G+m547mTIljzVf/dL/1sm9EykwVP0qm9XCERtH8cyF7hh5MRyYIiTgljHxZz0hu
         X9KZ3ZXtRrIDUoUCd57uLF6MJ2WGoz9kvNpSXHkBejFOZK7tLEgwMrJvJSCTkzGpLvds
         a8mn4Bv7aWWYFIdblTHR1+zee6bPFr40NOAW5VKxF2XXq023QTki3NMnij0sAMGNbziK
         sdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367263; x=1760972063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbnH3fDruZwPLY+aCr9UtQbP7MAEM3RXr5i56ltBskw=;
        b=Z6wyr0IeUJY2m+QvPMbSgJ6IJD5EIxx9YefhpXHnXtdaQOOUOyWsAqquYU/bpjJCU/
         JmnaJLyMOmn8QH29LRrFJ0SSn3ILfcFuEWgWHMZj8/4lD19NFP9oIMv5dDL8W0XmcCd0
         Td5jTOgWPzZNpzNB70XGbWYKDJUo7GTIS/+u1hh5MuxpyFyw+woQ4V29gSuWh5l1VlIB
         CPEDxSw6YoL8RkLEE8H4ARUSXda7LMYZB+pVV5mCKHfLmj+71VIlfw6TC7R0MmnkPKVO
         UC0znP3l060UKYbnhTN/52sOn5iosLzSV3n8v0xkHgUNwWiDwVKDH+FWxOVr2HH345Dj
         tMRA==
X-Forwarded-Encrypted: i=1; AJvYcCXIWMpd6Fut9YnhEptlXJ8sgvOJ2vn7BUFmTKzaTVX4nBLR735rthIuLmJurLkibWInLENzvwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywkPesSGJLngZa28THt5x4YXy7o10AReNkBN68GgWNrPUm84Ku
	qsKVQRTNpl5+OBGHqQE5Aa+kWUv5oEySp0kwhxfhU02vq8SjDhe6zyqWK+8o/oYNX3mNr5iDVh3
	a+AoOrTtkhJjj3A==
X-Google-Smtp-Source: AGHT+IFxZdG+rLDMtp0iURwekizt76zBbzihKq/WaB2DzovAQjawBk3B6mWFlCR6aUCHDlWOoNaIqYrYrEEd3Q==
X-Received: from qvad26.prod.google.com ([2002:a0c:f11a:0:b0:87b:d24a:e2a5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5743:0:b0:802:3b85:ee17 with SMTP id 6a1803df08f44-87b2efdbee1mr259834816d6.58.1760367263441;
 Mon, 13 Oct 2025 07:54:23 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:54:14 +0000
In-Reply-To: <20251013145416.829707-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013145416.829707-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013145416.829707-4-edumazet@google.com>
Subject: [PATCH v1 net-next 3/5] Revert "net/sched: Fix mirred deadlock on
 device recursion"
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commits 0f022d32c3eca477fbf79a205243a6123ed0fe11
and 44180feaccf266d9b0b28cc4ceaac019817deb5c.

Prior patch in this series implemented loop detection
in act_mirred, we can remove q->owner to save some cycles
in the fast path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 1 -
 net/core/dev.c            | 6 ------
 net/sched/sch_generic.c   | 2 --
 3 files changed, 9 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 738cd5b13c62fb8501619625880b87991f3dc17c..32e9961570b467b6066f1bb2c00ff1a270e342bc 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -117,7 +117,6 @@ struct Qdisc {
 	struct qdisc_skb_head	q;
 	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue	qstats;
-	int                     owner;
 	unsigned long		state;
 	unsigned long		state2; /* must be written under qdisc spinlock */
 	struct Qdisc            *next_sched;
diff --git a/net/core/dev.c b/net/core/dev.c
index a64cef2c537e98ee87776e6f8d3ca3d98f0711b3..0ff178399b2d28ca2754b3f06d69a97f5d6dcf71 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4167,10 +4167,6 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 		return rc;
 	}
 
-	if (unlikely(READ_ONCE(q->owner) == smp_processor_id())) {
-		kfree_skb_reason(skb, SKB_DROP_REASON_TC_RECLASSIFY_LOOP);
-		return NET_XMIT_DROP;
-	}
 	/*
 	 * Heuristic to force contended enqueues to serialize on a
 	 * separate lock before trying to get qdisc main lock.
@@ -4210,9 +4206,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 		qdisc_run_end(q);
 		rc = NET_XMIT_SUCCESS;
 	} else {
-		WRITE_ONCE(q->owner, smp_processor_id());
 		rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
-		WRITE_ONCE(q->owner, -1);
 		if (qdisc_run_begin(q)) {
 			if (unlikely(contended)) {
 				spin_unlock(&q->busylock);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 1e008a228ebdf846d4ef7f83d655ac1142ec3596..dfa8e8e667d24a435b0c9cb3c1f05c8075f63e89 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -679,7 +679,6 @@ struct Qdisc noop_qdisc = {
 		.qlen = 0,
 		.lock = __SPIN_LOCK_UNLOCKED(noop_qdisc.skb_bad_txq.lock),
 	},
-	.owner = -1,
 };
 EXPORT_SYMBOL(noop_qdisc);
 
@@ -985,7 +984,6 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	sch->enqueue = ops->enqueue;
 	sch->dequeue = ops->dequeue;
 	sch->dev_queue = dev_queue;
-	sch->owner = -1;
 	netdev_hold(dev, &sch->dev_tracker, GFP_KERNEL);
 	refcount_set(&sch->refcnt, 1);
 
-- 
2.51.0.740.g6adb054d12-goog


