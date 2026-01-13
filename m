Return-Path: <netdev+bounces-249558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A1FD1AF28
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 901A3303F98D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE443359704;
	Tue, 13 Jan 2026 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhrpOso6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3F358D0A
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331219; cv=none; b=MOJPeT0RR0Di5/yF96GzeEJeh1kt1vdbh/xZH6MkUqBojLp3MCFI5i3Gk5/GJtp0FBHsfo4geidAtF53bo3uwTM417o7JeSKmrAcCsVLulPvkEEb1ooUvRNAMJvpP4btAqSFvkWmetMCP/k43dyYR00bMyde4xx0MRwxsYF+IcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331219; c=relaxed/simple;
	bh=wxPSvdJT3qNlifROAAtu3blMPGzJgdwcoWXmmidk3/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4ZutzAPUlJy+C4G4Za8yn/RnfLxBT/l9nGUTViFNqdTOcrsJq090FQ7s4jpIKTZxjorgS23Ymlb21bPrlTUouDZTk8hLLCWGi0hvEcf8kT75VEkxH0LXWFvEn4ljYHWK/Gfzv2RCcdWa1GZ7leFXY7oj/Uf8CMC6q1hab0QFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhrpOso6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f3d6990d6so1563914b3a.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768331217; x=1768936017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aWIX45XGXcat5/aXe+5q9hJgBOrGtFu2MeyW9M+Lkc=;
        b=AhrpOso6JgK5TdiWQ4tTSIvX5THrt07ZmaummySFIu7KLkUlkOgnV/zH6VAST82/xI
         OUbOwRHqReTtJfQn/2xy7Nk2Y5BjHFGFHFrJVSvVfouNAAaHUN1Ipqb0HpGE1ylmdXdM
         hZPXYfP8xI884BezEvhsC5BvU0c87vcPUNM+fVq6aiCNItdI6EXbqKkJN3qilmeIYn9R
         TSJsjFkzZWLib/QujpdwGQh2QDViWJEtv+XPuz94yrGDc62BTy+j4JH11IWrYvrdEvAn
         FqFN7f/QFR1ypPLmyBl01sBgdwotgO2Rzh6J4o++iH6J+5SrzUOGDFJDHpaQU2FbaCUQ
         drlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331217; x=1768936017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0aWIX45XGXcat5/aXe+5q9hJgBOrGtFu2MeyW9M+Lkc=;
        b=EzfLJGYcTZXTv/UUSa920KFPRO2MLmK2oJ0QZceinv+SX5gQ3Xsl6acF5rrxuS+AM4
         d9zoOv9gDUcL2VZb6RWWTOAAaD1loQRWkx4XUUTuaXamdkHw/mngiwFGuRjhFpZ/CTjz
         Qmm6DyPglQQkiHEtbcGPpx6IWeHdSbV4tMi1VMnmhvfbltlGiKHTcZDAHrSxwlDlFyPc
         U7lL3heTTM1yA3AcO1JpAvzJMco/iLREeldu94TRrb9OSfG9ZM2+BVKfgbfc+ZAt1rRg
         +jeB+r7ACByHy1NjvhFvITEqwEfHwO9F5L1o2dHYCXwPP+dG6kc7QwqXbAyvIxaUHOCQ
         MGag==
X-Gm-Message-State: AOJu0Yy3AS3IdXD5uppAnmmPRco86II5XxvbCoRnkmt0oYHrLZLULTwB
	qdvC3DqD7F5T4fsodHo6zxOxPYPHNpSMDjdiBwvzIaY3oglaza3yMuL6DaIWLg==
X-Gm-Gg: AY/fxX7t3xaSNmu7GxjAGHg+u6DNyNw2zoLFCfjS9MjZrASBzD1lejGefaRnf1QFuN0
	JeonVDHESiJsAH6TDqNXTHo3UjssF8t4Q5Z0HPJJxci5cvlkHWx7iIhHKSoN23hYJTzIFvDlVkg
	1WT1h9zSdrMQg9XagN3+GX4vQOeMdeZd816wq8YqKnGpcmP5rRdEx3Y29otVIDMKbMwFWyLAVfM
	wmounFeL8z+dwkXtcjgKcCrEXhEsnbdndK+e0B+0BJF3fSilTVgsj1sDXikBlETzRnTw+bUuXSG
	CFDNavoW7P5d/VdgVuI8m6xsXutwt3tr9ufPYf9B4tF13GP3K1IpekJ90Jp5A/CMxcvRARqf7Sb
	iG9yqSlwChqKKL+6D65LhaIcsfQCDiP2cprDy4u0Q1WGHJiCwWMyrp/lH+9PALXbYfhLrFn+0bs
	EBsJQP/UUb0g9fEC1P
X-Google-Smtp-Source: AGHT+IGOZ0ZfDBOEeMhelRWQ9GeJJ+UawsaOt6Rn7lIKJXKooDD9I3Dzt5/OP6zyDoQsKx0piIM8Yg==
X-Received: by 2002:a05:6a00:4288:b0:81f:4e0b:324e with SMTP id d2e1a72fcca58-81f4e0b3410mr7336261b3a.15.1768331217147;
        Tue, 13 Jan 2026 11:06:57 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:7269:2bf1:da7f:a929])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8058d144sm187780b3a.51.2026.01.13.11.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:06:56 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [Patch net v7 4/9] net_sched: Implement the right netem duplication behavior
Date: Tue, 13 Jan 2026 11:06:29 -0800
Message-Id: <20260113190634.681734-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
References: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
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
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_netem.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index a9ea40c13527..b9a6b12951b4 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -165,6 +165,7 @@ struct netem_sched_data {
  */
 struct netem_skb_cb {
 	u64	        time_to_send;
+	u8		duplicate : 1;
 };
 
 static inline struct netem_skb_cb *netem_skb_cb(struct sk_buff *skb)
@@ -461,8 +462,16 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
@@ -533,17 +542,15 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
+		unsigned int dup_len = qdisc_pkt_len(skb2);
 
-		q->duplicate = 0;
-		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
+		netem_skb_cb(skb2)->duplicate = 1;
+		if (qdisc_enqueue(skb2, sch, to_free) == NET_XMIT_SUCCESS)
+			qdisc_tree_reduce_backlog(sch, -1, -dup_len);
 		skb2 = NULL;
 	}
 
-- 
2.34.1


