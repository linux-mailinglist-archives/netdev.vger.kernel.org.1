Return-Path: <netdev+bounces-206460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF7B03322
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE7A1897936
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 21:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3D61F4631;
	Sun, 13 Jul 2025 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSohWOSN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEACA1CB31D
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752443289; cv=none; b=U/ppF4emmX38xMOoC83wRY2sIhfT9ERcJbP9t/dIUatx382gElFfawtk0TbMaAIaHLaDb0MOB7Dta+RYBxVkKImsG2o9Y5EqG+V4xZPwnS3pAu5/TpBVSCWiJMCyy2QRnDBNGzI6vycxVHnmyV10FHLj9uImeJvmKSIHV5O0NuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752443289; c=relaxed/simple;
	bh=4VhSIwyEiI4o0M56cg1gZd1CJC8AShdlN0bOIa+sWlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ae6jm2JXYbJI+wrJcvpgqOkQhIz0gk8AdZjyWdPeedK2KN2uKPaPCfNV3y1UP00e2kieCqdZ0WXmJnE5WNWhFZBy821Qt1g5+Fctchlc7QTfNAT4QjfeqFcyK0+m8thI5PraWiTCc58BYbkk9vrTLeUzigKzEeT7+soq3rsPQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSohWOSN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-75001b1bd76so867248b3a.2
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 14:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752443287; x=1753048087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU+3aamh1SAErHPNUnNCAZ2o/TuiCBn2EuwTYmcAp+Q=;
        b=NSohWOSNQPTdOItF/lp71/01rMHMRIN94YcR72H4STKYWbVtr4aRlpz4Td3ECHnSNR
         RVsODNUhSkjDt2TnHfRaHJ0BLi4cwWvJJx0qaQZzRv6RDIonbiLr1RG0EVfehUK7JShN
         CbCh+4teIhXFFT1EaGSqg95SHeGLQIgDDEz33gIJwejOFqvPelfSecfjAddtLCFeNY8h
         ja1G3GaCjqyiCI5zZWrRJdMYpPK0lJqH0O/y0eStXvvp89B/KCNv0Ui3EDlavyJaxFRE
         Hysmt7cQu5T3gHY+apDOUEezjlOqk+jTofJP7VPa9lBfBxP2pCEXLORjpFNj80sHVMlU
         F1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752443287; x=1753048087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mU+3aamh1SAErHPNUnNCAZ2o/TuiCBn2EuwTYmcAp+Q=;
        b=iwzq8gfKF71TSx//PVk0ajpSv5KWqW6/W0YbIiuX+SU8bpF067Gl0WS8KPVvsWWwOe
         OzWu2oeOoh8u/7zlOvreDRWOfyZQITn1IWjxfE+2x0topMvb1WAclxhKc7u4NtbeQEwy
         FrlfmK42F1Rs03jLeoKCorBTD0WASlqZo69ZmHLY0mzlTtAvaNevJiG7Vp2YDjOnTg4H
         /SLGyN9hkWNOKvYo2emZ6gq7l+xRsjCqxFyrSiPHKzy80kUct+2TrLJUZH1zS3QM81zQ
         sVUIMUczZADfs6xsGMsPV3XHll6pp6IGta1Jfv7U5aZ6ABp8+wFoAJ6vsdUqOABre2ck
         JYzw==
X-Gm-Message-State: AOJu0YwHUT8T5ejDfECLeYQ55hcRIIiGWM8KvXc/lxIVXbysnxOBMuzc
	2cqmdenGz21v4OsCS8LL3QSJF2trTgo8m0TBcYXMmgd00kQZbi21NCbemUK/Fw==
X-Gm-Gg: ASbGncvRxFIUu+32yA4urFabQ2TeCD0GQH7On35Yrq5IXLWJ3+CESFB9JBHrGYighRm
	fDEP8JWF9zUmCORecav5umjV6lMez32HlS0HrcRXhgARuP/fhIW+TD7R2ZJd6wqNtKLoHnezCj/
	b7aXtiN82s98r60pmb+84gspDCMHUxl+S2L5BmCcrclF0RX3mVVxO7nd7I4ChB3M/x0ZGJ6N6cI
	2tNrHcUY5WKl6CEcmnv4flgdy7W5qM90TjnHBlhlpj44OLe15I7PtfKjcP8BiohZ+BXTrWUXpeD
	Eb2fJm/5bj0T3sA0WHBq0ko1kzBfg5WQLLNm2MaRW8Iu7NySToczSKJjY10X81D98rRY+d5Ml0F
	YQb/yCG0FnEmdbAjpNxWtPS+HmAc=
X-Google-Smtp-Source: AGHT+IHfTsTe+Rzv0tJiiHeQz5pAmTRhWSCfV92t6C5diVbyOnnd1IedRb9QPAMAzTVqVNEhGwMd1w==
X-Received: by 2002:a05:6a21:338c:b0:216:1476:f5c with SMTP id adf61e73a8af0-23136860180mr15543203637.25.1752443286534;
        Sun, 13 Jul 2025 14:48:06 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b9d2:1ae4:8a66:82b2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f1fd0sm8628370a12.53.2025.07.13.14.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 14:48:05 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: [Patch v3 net 1/4] net_sched: Implement the right netem duplication behavior
Date: Sun, 13 Jul 2025 14:47:45 -0700
Message-Id: <20250713214748.1377876-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
References: <20250713214748.1377876-1-xiyou.wangcong@gmail.com>
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

Users can now confidently chain multiple netem qdiscs together to achieve
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


