Return-Path: <netdev+bounces-188197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24782AAB812
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A05C7A7FFA
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694B2253F2;
	Tue,  6 May 2025 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkL7MrdS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0286D2868A6
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 00:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746490557; cv=none; b=RCDLJdfLV2tRtWNlc18cEH8glhPJgdC8WuNB+6yOTRoASbWuDyc2u2PTZ/cU7gtljpY00vPDhEGMeu3N8XzY95I3kHqRUNiQrbWD3pIU4+p6o6BLGKzpcZ3IO+7HVrcHlyxos6Io2aIotvic7jOxC+AFFzkVwwRO0Ytu0tft100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746490557; c=relaxed/simple;
	bh=7Q6BCSI5bwQKkg/xKqLozazxhHHVK1coX+qZehwtg7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IS3daDC7sn+pK75GPt14jW+oj+2Vwa5ypF5BWeAkc/Qs77CYugREVx8Ald5xyQy6T5++9MzWnntkeoioYp3C/gT2bTWvGUIelDcAJwBifnAyDT4QOOD0uITmpGzfdHydxV7352THD/JFgxcpapR0pm0x/nrPbMPWen5301/ymTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkL7MrdS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7399838db7fso5231898b3a.0
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 17:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746490555; x=1747095355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwanQU3bj0aSmZBwthN3TYs6sRJ/qMdlHFJ0EZDKFeI=;
        b=VkL7MrdSDq9TEYGvA+m1lUizUb7e5OaBSC3eMelW4y7htAHm5DpxFB4O1gQnE5qYDR
         rzOmzTYgHcv0se7xkhRPOjIKY+vWCPY3Ukc/Vtgba2Mr3V4OWuhatQngWyIFKREGoXiZ
         quB8aXXIwD9TxZK9sls6gUd0vbLfXjrSDg4639N9K5tVm5cecQk12IVcjOkqRa2BQrm7
         hgLZCUmoA5TqpK59V8EbQbUZFhBchpZYlr4S3nBWycyu8UodMTxYvBFuzZnuW4gq8fo7
         G4q2MTc4slAL32ep7Sbn+sgkHA/x8RrK3IjOsBkcSd3ECJ0W493fMNxhUfsfKIggiLjW
         Saog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746490555; x=1747095355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwanQU3bj0aSmZBwthN3TYs6sRJ/qMdlHFJ0EZDKFeI=;
        b=TkcTpFcvnIfLN15j57zRnBbjDwE6rik86aUw7eDsc0hgndO4J5No07c1plEwcb4WPj
         VTTB7f8ZT+W9A4c8I1hTqoq/9Wm5tt+wEgTMFhPD8R6OGdNTVWVPO/yscqherUKIkIIB
         RVkIdEU2mlDVercwcfhFNWtCd4d8D8DkXx3K6RBId7Uu7yA+UILrpdTkmzzh7okRYkwf
         8ylZG1w4GKpR9bksiZesY6mpTWl41U4CBC4wWENYFJ42NxhzTHJAiomdHJvPJz3NSztu
         fw/yLyGzReuL1qVstZ4pr9Pfevjw5RQXRlfAIKL4C8oRFYVpK++5wqANaATZ6aX5BGqc
         aW8A==
X-Gm-Message-State: AOJu0YxQk1Wlub7cOBmRUy7Ami0y4pAjCTn10/eOByOoqaD4Zr/T+blD
	w9Ll+TX+nPltHYzu0WPSXlcJkML+JKm/4rTNMVV5xoLQ6lpVLtNsA2N05WkN
X-Gm-Gg: ASbGncucFghbgUwUkPxaJJ3wo75Ye4xJP/g6s/igeATpNXrK7Nmj1987mBO/aoHzWbb
	LxsiK9HCzQCtr1TJXJRPdnN4hTos1HsWh3KQJBIg+zP51dg/4KYFmfpmlEfzPCYdfFseV36lhul
	17xk5iQBRwHi4K7rqJbAen5SoUkTaM/6Ig2ESH/TEmgr+fODOjTC2XKNtuqkrXnrbYnGe4W4/9j
	UIzI23iVijTLJXJTqnBNS/tAipDTQ9GeK6Q5nKzdf4SIW7USTeZsFoiPAsJPqWjHQgpN9AA64oN
	WX2bgMjH3eqsSZGxNklzO61vD4vBx9dsnMOVK2dbfE31XepHxtw=
X-Google-Smtp-Source: AGHT+IH/Gp09rrt6zJinlhCaGMWMeqVxx9sCg/yODl0g6+umyc3FnKbpcKZ7HHxM3GKMZRiO/mBjpg==
X-Received: by 2002:aa7:8c0d:0:b0:736:4d05:2e35 with SMTP id d2e1a72fcca58-74090e0e6fbmr1789907b3a.3.1746490554706;
        Mon, 05 May 2025 17:15:54 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405c2e7596sm7496824b3a.147.2025.05.05.17.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 17:15:54 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	willsroot@protonmail.com,
	savy@syst3mfailure.io,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 1/2] net_sched: Flush gso_skb list too during ->change()
Date: Mon,  5 May 2025 17:15:48 -0700
Message-Id: <20250506001549.65391-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506001549.65391-1-xiyou.wangcong@gmail.com>
References: <20250506001549.65391-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, when reducing a qdisc's limit via the ->change() operation, only
the main skb queue was trimmed, potentially leaving packets in the gso_skb
list. This could result in NULL pointer dereference when we only check
sch->q.qlen against sch->limit.

This patch introduces a new helper, qdisc_dequeue_internal(), which ensures
both the gso_skb list and the main queue are properly flushed when trimming
excess packets. All relevant qdiscs (codel, fq, fq_codel, fq_pie, hhf, pie)
are updated to use this helper in their ->change() routines.

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Fixes: d4b36210c2e6 ("net: pkt_sched: PIE AQM scheme")
Reported-by: Will <willsroot@protonmail.com>
Reported-by: Savy <savy@syst3mfailure.io>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 include/net/sch_generic.h | 14 ++++++++++++++
 net/sched/sch_codel.c     |  2 +-
 net/sched/sch_fq.c        |  2 +-
 net/sched/sch_fq_codel.c  |  2 +-
 net/sched/sch_fq_pie.c    |  2 +-
 net/sched/sch_hhf.c       |  2 +-
 net/sched/sch_pie.c       |  2 +-
 7 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d48c657191cd..81523a4fb01b 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1031,6 +1031,20 @@ static inline struct sk_buff *__qdisc_dequeue_head(struct qdisc_skb_head *qh)
 	return skb;
 }
 
+static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch, bool direct)
+{
+	struct sk_buff *skb;
+
+	skb = __skb_dequeue(&sch->gso_skb);
+	if (!skb) {
+		if (direct)
+			skb = __qdisc_dequeue_head(&sch->q);
+		else
+			skb = sch->dequeue(sch);
+	}
+	return skb;
+}
+
 static inline struct sk_buff *qdisc_dequeue_head(struct Qdisc *sch)
 {
 	struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 12dd71139da3..c93761040c6e 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -144,7 +144,7 @@ static int codel_change(struct Qdisc *sch, struct nlattr *opt,
 
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
 		dropped += qdisc_pkt_len(skb);
 		qdisc_qstats_backlog_dec(sch, skb);
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 2ca5332cfcc5..902ff5470607 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -1136,7 +1136,7 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		sch_tree_lock(sch);
 	}
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = fq_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		if (!skb)
 			break;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 6c9029f71e88..2a0f3a513bfa 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -441,7 +441,7 @@ static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt,
 
 	while (sch->q.qlen > sch->limit ||
 	       q->memory_usage > q->memory_limit) {
-		struct sk_buff *skb = fq_codel_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		q->cstats.drop_len += qdisc_pkt_len(skb);
 		rtnl_kfree_skbs(skb, skb);
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index f3b8203d3e85..a04554d01960 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -366,7 +366,7 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 
 	/* Drop excess packets if new limit is lower */
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = fq_pie_qdisc_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
 		len_dropped += qdisc_pkt_len(skb);
 		num_dropped += 1;
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 44d9efe1a96a..f4c2bebd3780 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -564,7 +564,7 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 	qlen = sch->q.qlen;
 	prev_backlog = sch->qstats.backlog;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = hhf_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
 		rtnl_kfree_skbs(skb, skb);
 	}
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 3771d000b30d..ff49a6c97033 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -195,7 +195,7 @@ static int pie_change(struct Qdisc *sch, struct nlattr *opt,
 	/* Drop excess packets if new limit is lower */
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
 		dropped += qdisc_pkt_len(skb);
 		qdisc_qstats_backlog_dec(sch, skb);
-- 
2.34.1


