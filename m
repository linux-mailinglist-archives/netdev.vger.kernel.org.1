Return-Path: <netdev+bounces-250813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01805D39300
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 07:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85B9D303210E
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFAD25EFAE;
	Sun, 18 Jan 2026 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwt/zCL0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CEC1F9ECB
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768716970; cv=none; b=qVYNi3Z7R8pMGduJlM3JVX+oH0KJn2TFr+p2Ql/dlYF4qcxxFpviyekjZaNnodD9ZfPriv12xeId+MtuBajdtHVv5DuZRVjulhNG4LHenk//E0QD0R9jrtq36hm8NTVR36ZB8JimCz+W1pR6MYw4AV2eHtwuc6mzkIPEIqHEPHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768716970; c=relaxed/simple;
	bh=wxPSvdJT3qNlifROAAtu3blMPGzJgdwcoWXmmidk3/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlunbDWqPKULsLpiC5SUnzKcFGScsQ0CNY7ohvX0P+TH3WVtvBhWGqP/V0Yc39DSA1YqCfyhwBQLLREXJrrDJT004briutLGEABvD9YgY0DvrYmeSFQ4B2xnVKRphsrv6hUm1DqULUwpcGrzW+xmDUS1wjm/rjgaKvV8jgnCGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwt/zCL0; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so5016199eec.0
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 22:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768716964; x=1769321764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aWIX45XGXcat5/aXe+5q9hJgBOrGtFu2MeyW9M+Lkc=;
        b=dwt/zCL0TYHVI9jk+fE5zqlcTbI9hxG5lwoyIfobFxlUfXwq84YBG36n2T8Vw2Tgk4
         QVHvexZMsCZcLuiwBiH2ibYBE0BNG1nOcx/3SlssGN9dt0aDCJsJL4g3eaZ/2TT2HIyA
         mf10QibTZoHegOirJ8PBg8ClhM9HH9n4NocytP87ndofDGkPb1pAojKcqNRNek7QfiDv
         STWbHTpzerR7/1Wl9lpDaW0sNBMgSS0CyItzYN3BNQmQ8sk3tj3IySOBTlJDCC803w+6
         bAuZb9/l1dB3Ot6N2j1T+fbZQBEzDJG1VfFrhZdfVdr+i1m++lsVzfI5R2R6uVH/sm0P
         beeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768716964; x=1769321764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0aWIX45XGXcat5/aXe+5q9hJgBOrGtFu2MeyW9M+Lkc=;
        b=AjjgJ56GMAKAr3TCp88MRAhLojO8FrTSwC7oXo9/9no/D+Gp4/ij3j4Hhg7wqfnsmN
         t1vu1Vhhjw5ftlxG009Zfc9Hbu3Sw9nVtRdhPsohYsocdONZWN8xbpNHKkxciEApAi2a
         YUEa4psqyyAZ3aLUgvFd8840Q6YwzZlnVoSQ2ieW5i/CtsnC5VKEF2UgIA/9ToLRgh48
         4I7e2/vxWZl7cLFLjTgmaP/ptuIWS7B13jbQKNL5P8VoFPy9ASA9gDFZF7UgSjPTRxBU
         7hCbIjotEpwxMrt6rmi3KAYqzHeV/gMyoik6X1Hrtb17uZ4u99Gsl7v5emgzF+8m6UrE
         +QvQ==
X-Gm-Message-State: AOJu0YyqserFg8YuwUZ0G9P2l1wLaoqU5Znckv7vw/3ltzyc6AwTYWSO
	qP188m6eKB+jxNgcqVshcSY3V2fqdszcoIKMoH7/GYOXz5efK22pHd85eHJq/w==
X-Gm-Gg: AY/fxX7/b+RQhc0KtI4vRl3YKndO2UeLi+KlzvdbgwaMZ7Y/pPLvThNdOhu6jwinFI9
	NwMRF2TBMZOpxFyV5mN/mi0jvsFhv2EBMT/kxQxyKro/8iIIBmc9i8qwhN6JgkiluwfCEcDDO8A
	6qtvm066vpEjX0kc5fN7SIIQoQIff56lDsoA1My24osW0SxgsLxpbWZwwkyoR5LuCX8pnaMxZwR
	uBTq88OYDLbPNxaRAxCiVDJo/uX2APc6EzTfUJecAyHK9gRvZk5EipZPhwrLYi62CDXFJdVbK+H
	tnJl7S2H8YpfCMoCpcbgPHcVVF3YUDvYdPKEiGYTxf2jCB6kfQ/uJoKfERcVDfglIXwj8zllXGc
	kyBfSAC7eMIipDAFYhw/6W5jKj75Zt9D/JaEhafdRYRUfyeEzBDvz2KK+uQoHzi8O+CNTlOV+fF
	TXzebTuvAuW2ihEvfX
X-Received: by 2002:a05:7300:bc8a:b0:2b6:a580:c37e with SMTP id 5a478bee46e88-2b6b50025f5mr7842825eec.25.1768716963894;
        Sat, 17 Jan 2026 22:16:03 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:8fdd:4695:1309:5b93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm8163816eec.8.2026.01.17.22.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 22:16:02 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [Patch net v8 4/9] net_sched: Implement the right netem duplication behavior
Date: Sat, 17 Jan 2026 22:15:10 -0800
Message-Id: <20260118061515.930322-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
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


