Return-Path: <netdev+bounces-208360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC65B0B22C
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 00:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E3856139D
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10142367AB;
	Sat, 19 Jul 2025 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enyEj4hK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E221ABBD
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962653; cv=none; b=Cbc8TJxkoLOynDNUjh3aN2eqL7sf8hKFZPAgkuqNYjBXdnu80Aadzjch2zYB43pjrRlCcJLXsCxNHGGHOP8WcmYY+/kXBd3MpQ2iPpP4QB5mXxy2uII9NtdvsECRDFSj4cUSb6Dzr3BdbzgLVKJGe/lHSh/qbtsinA2M1IEiRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962653; c=relaxed/simple;
	bh=wucZarDRK+70BLnRdOgqShKHlHmhkvJxhPceSa4/ycI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3+rzBC3RVgt9Te104J54a6ZFqLtlL6DLXVNLRbDzo1z2xFLH4dB5o9KYGoNNyrnFQA9qIfjMNfGG75obQui/X0gB5pNB3/C8pROnP8JqEQYuwe4lLSnkTdNve+ft1156eQJvraOB6dsMazQXHUYWG5CmvdcL19csjKTNw4V6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enyEj4hK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso1761922b3a.0
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 15:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752962651; x=1753567451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gQCbpWPpARZsFARkDotP6tzn4NPnjKG8RslPICiuHg=;
        b=enyEj4hKT1heoEBvsXcyb5331u/abUBg5HzgUE9HTq4j8bLtnNwB67KF4KJB8P/23d
         g5XmC1qpBS9wVHjKpruSu5B6iHmYGFjKXaSeJ/bqKWgrKQbDu1ItJoF2JThlhw5WmqK3
         r5GOL1sSn28otwwEXOdbJfB2Y45TsnEc3lhNnMzZyMZMSDEyqGr8Q4gdwtAczKlVUMcC
         3BfRiyVdaTNnAE55xMMyZ4O7JBq2XyJu/xcIfDzT9HLRtTq4k+oR0HDSL35tbJPLDX1P
         8Py9Nj6iOy3OiYdZZ44/ZP99XzWjFCKOAC/9R59tmS4e4TdIKVcnHkGV+PP4qaa6LLIb
         4T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962651; x=1753567451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gQCbpWPpARZsFARkDotP6tzn4NPnjKG8RslPICiuHg=;
        b=p1CMT4WwdtyeVuioL9GxvFGFiDwNtTZVHPNNec4rnzujujKSQhFmMhzi4O+hcuZf5L
         RGJHyAPg6bPj2fkBRfUVK0SPGWW1T0cG+CqR1i8bCohHn7dJxV3iznR3ENdYQH6ZvDWW
         cY2Hop/vOLSp1CeCghV+ri8YoLhX9/bGGmUE+lMBUrjSPEO6lwLnDJljvNCcnIeHh9Ti
         5aGo29DaRtkohpeGQ9hnyQ+DVgRTYz9ngfDQmToNKWH1Gh18cFg1nss8qEm11k9gOUPm
         /nljE3an8Nwg947NcIM2z8n3sHF1MK4ZT6Ddfivj17CpFkMRh3uqEEsm+kkctylLppjv
         ptyA==
X-Gm-Message-State: AOJu0YznLsBRaZZDUKrVllcQLMARdtSVXfxOxg+SP0ryc1RNqr59Fh49
	W7FhlHyYxKrqXm0dhkrgNavX1b04xyWJYzqcUFy5Xwir0dYZD+s2Mz3egedQqg==
X-Gm-Gg: ASbGnctUN3Fhn17bSmK0IzizN0TGQj1rTFtGQq1rnUgQ971HbKCmDUIb21PHEZHVKTy
	AeZxBOHfibaWhlBH0r4KW4tKQfUT5rSzYrGG9lxgUW0XA/cNaNugRM/zzidIjwV95iAd64/2heH
	k01/slKLFrGppVP2JXtjIuVu87+iLsjlJb21Q8/zx85ELpSf9vlECgHdj6NlWAlbP0gcgrqX0G8
	kmwTdpROQfuuz/jfBkAg7E4/uj5yoz0k2gMRhM8gG2yKqj+QQWxTiDKZX3Fmx/dKjF+ENK2GrZm
	rtpYxLexCIxoeYZsb1S5J2bwQCoYfJR8raaVzGTB5AmeioZq/lKnCR9eUX3Ew/5gP8bQmTZOpqr
	qBhFoEZiCt5Y0DFwNJNTn1Y1W0Og=
X-Google-Smtp-Source: AGHT+IG11UAkLIBIYtvzeiue573UxUwhpeauv1bS+nJMNQuiZJKl+XN1m5bWs2iN9v2jiCxF7P51AA==
X-Received: by 2002:a05:6a21:329e:b0:239:eed:43a6 with SMTP id adf61e73a8af0-2390eed454emr17733996637.22.1752962650698;
        Sat, 19 Jul 2025 15:04:10 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b3bf:9327:8494:eee4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe6a09bsm3084040a12.3.2025.07.19.15.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:04:09 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: [Patch v4 net 1/6] net_sched: Implement the right netem duplication behavior
Date: Sat, 19 Jul 2025 15:03:36 -0700
Message-Id: <20250719220341.1615951-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
References: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
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


