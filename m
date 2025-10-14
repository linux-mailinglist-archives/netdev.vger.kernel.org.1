Return-Path: <netdev+bounces-229338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EAABDAC16
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 19:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BD564EACA3
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32133054E8;
	Tue, 14 Oct 2025 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2S38V1St"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DAE246BC7
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462358; cv=none; b=PptVZGnEkcukf/bm7uKf07Ij9/nh6ZTkg3rd85vTMGNbO2u1NHuK/+tyxdI5SjNGMT4Xd+GRI7dzwHr4LOjrvb4lESN3Z4Aj8pwSMFdQ0paa6k8vSEfwPEAzergwpnEf/n/2S4tNW1qHr51SOnIP63wRadWcPr4UUlm1WS8vUYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462358; c=relaxed/simple;
	bh=VMjW88j20h4R5ziCGW3QXDjapNLbKOlQ/grm0xHeDKc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LdOZjYhiGw06HME4xEBQzhCGFrdnBw53if3ImkZn/QeJGvfuco4UG9vOlZLIDoEycz986EPZbDpHi9D5MBZhBEtIaIDZW20IMwN16MAPHg+lQkPeA7fWBO9T74FSCEIN84SxZARkHsZ/eYFmxEplwLeSM7IAQXH3WwBYKyBB5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2S38V1St; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8892285b436so1240716485a.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760462356; x=1761067156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rxKCN7qEPKkSdQfPFsTIr7Ar6ZTs8tFGA4n4Qplwuk0=;
        b=2S38V1StAoANH2TOrcG4DX7iN/OX5GgMsluuR4rTHS78WcqvElzhjHLdOpfVs1TWKl
         +VaRaaEznBGYA9ArhM6lle1fuQPZFxen+UQpVFSvx9PoPddsa7/vLACprIg28YpEoB/i
         xR0wGBKF5Fj6vVesiVUKmrl81dyInJdsM1A1aIy3lC6+35ncygCzOcqKjyS9QTZEeIro
         LJvxYNAAGZNkMtvnpO+bKB7HuPDbsd+0Qz1HoE94bea25fAmFLNBf3Ir8f/ISNiWjqyk
         ZYvfDTK88mATEODBHFfs1A+SAWWdm4zfQUf6HQuKwtTqmz3LZD9pOtQhFBeNEDKdbBZ1
         vMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760462356; x=1761067156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxKCN7qEPKkSdQfPFsTIr7Ar6ZTs8tFGA4n4Qplwuk0=;
        b=EyfBPmFvBaxbMuO4GtLHCNAZs26ek39OECmsy14aP/oE8BKo6vPviGvbt2uaJ+fLf/
         ULxLr/YuwAJfO2nHQMQNoe78AbTE+KqRtmP/jmOh28EPE0vnAAv4MbXBDn7w7PbXYdd9
         VcV4QncMeutGQH13vYZJ71yomi0G+dcee6/lr1AXSpNwV5gqGOyx9KJFG05gYOgY+L7M
         IjaqUnHtcc152ExDjOixiAn2qKmkfLIiIc45vuKbZIh77SrJ7en1MoGqeoGyCPncYZen
         PKWxa/DAjlX+aygnn+EwZrA3XatHRd1l/6n1X4lmsobO2V8WJ3te4pvaQoMxZaOpjtY3
         6gyw==
X-Forwarded-Encrypted: i=1; AJvYcCVEZ4VkmRJ9WHtzhYEfyGPfaosPge+oBgmocGQAy5OE4wdy9+MDbv/80IXu1KlOVC85d0WzLX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnqYufrNUR/fr2TZp3MJAS8TpwU+auldhziinYdXUhqrh3W4OP
	UQ0kkvsSfQ3pub59nIdxpmZflFgzspZg+BTJ/8/IZ2ykQkaEC20G5aF3nMH3ckd986DJ4YpVnNI
	zDf6sj9ltYeg8Qw==
X-Google-Smtp-Source: AGHT+IFJbwrMmhnHooX93PMN4drli2a1PDHvNvNtatgGk3v34+8j7IWjEcV2EwsJH9XaqpOp3WMYTsH5H9mFVA==
X-Received: from qknop54.prod.google.com ([2002:a05:620a:5376:b0:85b:528e:1a32])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:708d:b0:862:dc6c:e7ec with SMTP id af79cd13be357-8834fe99853mr2550752085a.5.1760462355429;
 Tue, 14 Oct 2025 10:19:15 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:19:05 +0000
In-Reply-To: <20251014171907.3554413-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014171907.3554413-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/6] Revert "net/sched: Fix mirred deadlock on
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
index 738cd5b13c62..32e9961570b4 100644
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
index a64cef2c537e..0ff178399b2d 100644
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
index 1e008a228ebd..dfa8e8e667d2 100644
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
2.51.0.788.g6d19910ace-goog


