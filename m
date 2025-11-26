Return-Path: <netdev+bounces-242032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB38C8BBB1
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821BA3BB542
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4E6343201;
	Wed, 26 Nov 2025 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFLu/6xw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF7342507
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186782; cv=none; b=CmpwNhonk7mXZsawVczSbtkoV7FevHVPxxySKASIO3q6Eakey0TlvRyQv/Y1ehVaVDQvHOwIb5sL8M0t01SSu5cVEcLPR5Cak+ojys5LabRehu/SZh6qkzfxWOXLOAXdmekaoU7AL2WxW0El9DqTR7jBDr8bjNWmIjYFMYmaAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186782; c=relaxed/simple;
	bh=wucZarDRK+70BLnRdOgqShKHlHmhkvJxhPceSa4/ycI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSN3IojSiawiqCXw0sKjK2eWcO5jlWq6CqOsnbYsLBloS9qRHFuDV5+unqq0VS64IxmhfKAkp3SZpsEGAMF5K7wbZYcpI7hL3eLT9OK4CP36FRFYRUvu96I+BZdea7aFx2Ownu3sr8WfK9yCjc3U7RaCzOTUpEzY2rEGFjAgq8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFLu/6xw; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-11b6bc976d6so1521942c88.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764186780; x=1764791580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gQCbpWPpARZsFARkDotP6tzn4NPnjKG8RslPICiuHg=;
        b=gFLu/6xw9LslczNMI+RrueN7njy/9jSMTglrzcX74MjzlYz5XmJ/RFiziAR+pCydPO
         dpAD7g8Snu1uPlkiyQF0WgqBc3plpN2fmqauYY501mtrKIPDJFyIPeiLjq6zUQvNBPtO
         hDtOO+F6SVCFo9rhDv3BDdilVXvu02lTkdkqCf9XzLmQgwloFcyic/vtGcCbcOaXJR+K
         gMbGWoIu+VhWlEa7GECtQtwv21XoW0//dR0pTowYN2afnj8VzKq7BJ7eyF1KOCeOzRma
         rfRrlL73ByRdbKsZBgKRq1bAStysL6ImaWoLctRToaqbaxaXy6UCXS6ixC9VuqHZ9KVG
         G1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186780; x=1764791580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7gQCbpWPpARZsFARkDotP6tzn4NPnjKG8RslPICiuHg=;
        b=F0r/YR2nViNA4U0WURzPwfk0qg+bS+qPwUcOYLtad8ZTPHms++Tf28f8gaBefvbo5i
         EKfvL0pLJrObg7OzszoiD9dm/97uRd4vYam9lMN/u8YUSpldUvns/upRAlYknMB+B4xg
         GeM1+a7/KDRGM5ORA24NFtnp4RIT7d8fSqeMs/i2kauQn01gjORzGBFcdYLApJ47HHL3
         JiZkvuGLIWFrOg7xLKlUfqHx2FSN8U7LMDcU68E2DkG2eHv89oQ9LNt+wxTsII35luNL
         QPM/n5R+xOc/eK9nmsG6R3VqpLbKOp/F4jTqfPVDZ/YmKqtuWBbyIfM+Fpbj55WSUVRW
         8A5Q==
X-Gm-Message-State: AOJu0YwcPEVUB3caSxSbwW81M4wcloPPmNyLDCri85Bxb3++0x4jfaH2
	JlgMPblzUcUo0JorAlfZ84rIOCTrcmRRJcJj01NE3PgZhyc47sC3aPamFWS9MAXy
X-Gm-Gg: ASbGncs6oFbH7vdvxvHfJxGGbHxHr7AFkaDRSPAIfqYwQkTGf5JWO4odp6s87E+lbNR
	SX2AsH/cDx7jjryUoo5RwyzKC6gHhpL05rchGHLQL2afhMvjz6lg3EEU6RF0ZYWq7oacTM+M9rQ
	wAK1zOZ0+eBJ8XXhQ/tHyiUkL60VVo1qeKzSyPmGNXMVSaWFaTiluU9W2Vq6aqvIoG7NaVMuAcy
	clF2nztD/C2VecOLSnrdbL+nFcCXqeScnAzmHHwDQ8zAmXLw4r1Qh7SlAMAmaaFJGCuqJ4CFSHT
	A1duTmJXLusENaWaNYdGNk3EhH8MwnlEpLVgD0rB5HfHKbyoramAP2B+hCSPRsqzeuWS7W0SihJ
	O2h7VcKUR3uIzBmrJ/ig65hHCz1Ym1dtd2ddBqUGClbUIYhGbR+8U3SDUcrMw8B1ePInafyFUV4
	PTCYr51hKGHIZZWDBbkQEkkjLY1gtn1N4A
X-Google-Smtp-Source: AGHT+IGQWS6Y/0Ac4ZDpi3jGwzHvb1kbihv/FqQ33uAuFHzcvgpatX1P4FWMHvXRc87Tl+CQ0+l2Jw==
X-Received: by 2002:a05:7022:380a:b0:11b:c1fb:894 with SMTP id a92af1059eb24-11c94b7b929mr10331533c88.19.1764186779800;
        Wed, 26 Nov 2025 11:52:59 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db4a23sm101508235c88.2.2025.11.26.11.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:52:58 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	kuba@kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: [Patch net v5 3/9] net_sched: Implement the right netem duplication behavior
Date: Wed, 26 Nov 2025 11:52:38 -0800
Message-Id: <20251126195244.88124-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the old behavior, duplicated packets were sent back to the root qdisc,
which could create dangerous infinite loops in hierarchical setups -
imagine a scenario where each level of a multi-stage netem hierarchy kept
feeding duplicates back to the top, potentially causing system instability
or resource exhaustion.

The new behavior elegantly solves this by enqueueing duplicates to the same
qdisc that created them, ensuring that packet duplication occurs exactly
once per netem stage in a controlled, predictable manner. This change
enables users to safely construct complex network emulation scenarios using
netem hierarchies (like the 4x multiplication demonstrated in testing)
without worrying about runaway packet generation, while still preserving
the intended duplication effects.

Another advantage of this approach is that it eliminates the enqueue reentrant
behaviour which triggered many vulnerabilities. See the last patch in this
patchset which updates the test cases for such vulnerabilities.

Now users can confidently chain multiple netem qdiscs together to achieve
sophisticated network impairment combinations, knowing that each stage will
apply its effects exactly once to the packet flow, making network testing
scenarios more reliable and results more deterministic.

I tested netem packet duplication in two configurations:
1. Nest netem-to-netem hierarchy using parent/child attachment
2. Single netem using prio qdisc with netem leaf

Setup commands and results:

Single netem hierarchy (prio + netem):
  tc qdisc add dev lo root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
  tc filter add dev lo parent 1:0 protocol ip matchall classid 1:1
  tc qdisc add dev lo parent 1:1 handle 10: netem limit 4 duplicate 100%

Result: 2x packet multiplication (1→2 packets)
  2 echo requests + 4 echo replies = 6 total packets

Expected behavior: Only one netem stage exists in this hierarchy, so
1 ping becomes 2 packets (100% duplication). The 2 echo requests generate
2 echo replies, which also get duplicated to 4 replies, yielding the
predictable total of 6 packets (2 requests + 4 replies).

Nest netem hierarchy (netem + netem):
  tc qdisc add dev lo root handle 1: netem limit 1000 duplicate 100%
  tc qdisc add dev lo parent 1: handle 2: netem limit 1000 duplicate 100%

Result: 4x packet multiplication (1→2→4 packets)
  4 echo requests + 16 echo replies = 20 total packets

Expected behavior: Root netem duplicates 1 ping to 2 packets, child netem
receives 2 packets and duplicates each to create 4 total packets. Since
ping operates bidirectionally, 4 echo requests generate 4 echo replies,
which also get duplicated through the same hierarchy (4→8→16), resulting
in the predictable total of 20 packets (4 requests + 16 replies).

The new netem duplication behavior does not break the documented
semantics of "creates a copy of the packet before queuing." The man page
description remains true since duplication occurs before the queuing
process, creating both original and duplicate packets that are then
enqueued. The documentation does not specify which qdisc should receive
the duplicates, only that copying happens before queuing. The implementation
choice to enqueue duplicates to the same qdisc (rather than root) is an
internal detail that maintains the documented behavior while preventing
infinite loops in hierarchical configurations.

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Reported-by: William Liu <will@willsroot.io>
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_netem.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..191f64bd68ff 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -165,6 +165,7 @@ struct netem_sched_data {
  */
 struct netem_skb_cb {
 	u64	        time_to_send;
+	u8		duplicate : 1;
 };
 
 static inline struct netem_skb_cb *netem_skb_cb(struct sk_buff *skb)
@@ -460,8 +461,16 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
-		++count;
+	if (q->duplicate) {
+		bool dup = true;
+
+		if (netem_skb_cb(skb)->duplicate) {
+			netem_skb_cb(skb)->duplicate = 0;
+			dup = false;
+		}
+		if (dup && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+			++count;
+	}
 
 	/* Drop packet? */
 	if (loss_event(q)) {
@@ -532,17 +541,12 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	/*
-	 * If doing duplication then re-insert at top of the
-	 * qdisc tree, since parent queuer expects that only one
-	 * skb will be queued.
+	 * If doing duplication then re-insert at the same qdisc,
+	 * as going back to the root would induce loops.
 	 */
 	if (skb2) {
-		struct Qdisc *rootq = qdisc_root_bh(sch);
-		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
-
-		q->duplicate = 0;
-		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
+		netem_skb_cb(skb2)->duplicate = 1;
+		qdisc_enqueue(skb2, sch, to_free);
 		skb2 = NULL;
 	}
 
-- 
2.34.1


