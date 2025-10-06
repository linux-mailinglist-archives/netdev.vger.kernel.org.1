Return-Path: <netdev+bounces-228021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A52BBF193
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 21:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B033B67D9
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 19:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2186256C8B;
	Mon,  6 Oct 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZwyeceV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32151A83F7
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779074; cv=none; b=MgY4C2DdbySWvGvNO4Doh76CS3j8fTYDiwcqaDpraIHyUBCainxwU4tigxsb12PEiCMQTBwYdomYGLRsJNXsPTQbO9AFz1Xd7eWfSQGLMLb4hS0Rf8c4/2wyIY2xHDH/Y/y8IaZOArq9YsEOcFiraWWLPD1RyMLKmjOqxtMwZ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779074; c=relaxed/simple;
	bh=J1oBx0ZtLan6lalY2W3LPrrCrLELQJudRHDjtzF6n6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aA2lzyWvvvyq1Iocsqw/CWOcrylu38dp0N9cmVsq+xhhH4UJEJjcACa+B/pWv+VNuybNC6+mi+wPMu+lusmmfMp0UwJ8mCSNK3mAZdoGSqgEuLMuQcRLkLbxD80yO5alFfa7Ez+y743uBWoESUNSh4ohDdv3CT1RKqlGDt0E0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZwyeceV; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-5b04cc12390so8358228137.2
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759779072; x=1760383872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh7fnu8CWlCuvWtcPf21V7m6+VwpF4QvBk9NVn8wwj4=;
        b=UZwyeceV+67DU7XdR6vHsKfbMJkekc5cxJHE2XvTELg+awgJiMzEj634ZKjZ1hUqAb
         Ckanz9vZu+nlTA2NnIRaNUKyAdSvn4YwFaEK5wWarrSpsf0W9H5EsV4Iwgln/Y2/SjqY
         uLPZgEK2LL8pT4qHdRZBoVF1Wri0Uim2ThrN4KydnpUh3uuqdDDeSIUma9Zp8oqFQZXr
         Cm6Y93StHAQTrwhVqbzeGjFXUQdppn5w6l8kjqk5272ohA8WQH72ZkEpfUZPBC6il5Ej
         ibldBHu+hMpl+NxZ7uL6cE3njWexUvpR3E90+vgZfv/D7MH5On64yKmUDeE/bpYB7Z2a
         TV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759779072; x=1760383872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh7fnu8CWlCuvWtcPf21V7m6+VwpF4QvBk9NVn8wwj4=;
        b=SQ9l4imXGq0gjhEuuZQohVntVUaHNOc7++aOWzL8sXOshfl2ea3yL+wTcX/zOb4bl1
         +2Lrx8UtzO9mpOHkVlTwLO+BewC0Z9fXuWhYUM9Dj4QlSrmDIJJ+ICuEFiPGGrq7loc+
         Myu+jujnS3U6rM3J/wZVE0lBlq+80vGyAzg0aGAr2o1DNHe2st/RLULodw4NwOyXkXs5
         VMysNjxgm/kzcwDOkOPSl5tWAuGnCShV5pl6wcXBfiawFTnNv55Ww3MNiuOlYYhbzs9R
         /3NBGdVPb/70AjqzW8evW2vTft8EZX300SjWgRvCrB++YUp1eljcKds6+INtY1tiZq4e
         vv8A==
X-Forwarded-Encrypted: i=1; AJvYcCVtepSTZcW3TGgBM/Wkf1fpXhtGNpACpxtg9dbc76aQd2y2i7jrxdCFHQ8GGG6/853+vNihy1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzu12i9DYuhjVziAl2AnHHTdhQEJTpcqPuUiPikmc0rXB++DIV
	PIdWzuQlOORSFdcaHEWSJLKSo+87GqxNI6h5Hw4Vldkhp4KHpOYyk5CQuvKraGu/3rnqECMcLJa
	wzUQOcPixfpvbuQ==
X-Google-Smtp-Source: AGHT+IFsPQVR+g/d4d0jTmrdXOHXTTPJLxjtHSYtrqyfU+gUlBaH6U7xaX1Xpmch4bEYVmtZfHpMn99BOXpi/A==
X-Received: from vsvc7.prod.google.com ([2002:a05:6102:3c87:b0:52d:f0b2:9b9e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:f09:b0:5a3:1889:a326 with SMTP id ada2fe7eead31-5d41cfc91e1mr5746209137.2.1759779071716;
 Mon, 06 Oct 2025 12:31:11 -0700 (PDT)
Date: Mon,  6 Oct 2025 19:31:01 +0000
In-Reply-To: <20251006193103.2684156-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251006193103.2684156-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006193103.2684156-4-edumazet@google.com>
Subject: [PATCH RFC net-next 3/5] Revert "net/sched: Fix mirred deadlock on
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
2.51.0.618.g983fd99d29-goog


