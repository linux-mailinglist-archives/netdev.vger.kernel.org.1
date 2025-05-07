Return-Path: <netdev+bounces-188546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CBEAAD480
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43AB21BC841D
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 04:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFF31DC07D;
	Wed,  7 May 2025 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="me/Qm7mz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78241D5146
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592581; cv=none; b=Dw8lTdrAM6zcq4UJM8AdGrGRKxCZutVMrn4/81zuKZMEiPjIc7mlChHEHMkCwBomXdUd8IX/NGEm9nqfa/Eq9aC2cb3UnDdj9p3Fc55w2BRFWZurUjkcQYg798NYq/R3tum4A+tVb0MI5Gt4p/gXWYn5kXNNXlT2ZAbdonQ0d88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592581; c=relaxed/simple;
	bh=tfAwR7hnGjZ7xs3Y51huiMwVCIlVbuMGQ32s4d99h1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UhQV7M/hC5m2K3/MaW5mMDtDZ7KLURCJkKKKvgs1XzXIt0CBKxpkUM1qkMfyBJZgCWGzFRDCiikLc6B3De6iRtJWw+u2SvkL4ryXyJWgBREGJ4rxWvSarX7vzZFTTixR7Z6+yYqHtS68YOjWE9J8mRK/pqbbL3pFJhu7urvfVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=me/Qm7mz; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af91fc1fa90so5774118a12.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 21:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746592579; x=1747197379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgMlV1A1A08Fqt1VsAPUuyyprb6U0nLJ0E5EwqqZxmw=;
        b=me/Qm7mziYJOMotlxrxOkl/aWcDorvCUksQpPtB/dM4CoDhZQ6b8wV6VY3Inmn81M2
         18e0n+gVIH1ZnAHFK2rkFW0qOOhv3V8ehuGqG+P33RKZj0ySZMvT9fzwJQ7CJ4GQFJNq
         tXDqJLyRMx0q90H60+FxWb+ASscTLyJD+pyWZmrwCDjOpnaj6RyvvBjGHr+Igx96iy0C
         OTZOxkBcpKTIqmTABJu18K776Mb1jySyK9HQIuLBIAy0ncCNoP+DqUd1eWqrIfR+8Whk
         8h7RD8sztH8tX92cW1CdDDc8ktZqistMB0wbfajq9LfBiMjgHPK5KnKX6OTeC5HmRgQI
         Pyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746592579; x=1747197379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgMlV1A1A08Fqt1VsAPUuyyprb6U0nLJ0E5EwqqZxmw=;
        b=EEotPA5FLht25eT2xh7rrgThbsvd2zh7gtMEKRPo8dA/wo9DVS3EZ23fYIYLTVmNdP
         Ko1nWr78fYs68mAaYcr7xvcJRFCQ7Uc7su1ZoBJ6SfBPy4JGoBTNQLxcPeYxnsl9vX99
         7GUQfkOFgJbNSLFyg2gbinsiY+QynL6sZRFob1vkT9b2uCceexxv9gZmR9B7l0KF35ej
         YfEcvZAsgFT+xeELEhoYPJnznECa9u2Qtk/UqkPwO9gBCtCkUldLuXTSFPZBu0mRGLyt
         +S+HQNu+iodutix7T8a0IZ+FgHI5rBfAgQOb+giLdbMWTTtQn7IxYflmQTPV/6zm7v2J
         ADVw==
X-Gm-Message-State: AOJu0YybAG1Vj/jamHBIKA/kjnCaTBJehATYfzbkh/sA/rl8l7hL6acU
	92FrQpQMJfgmMCRaA8Ng65c4RJJe7hPfw7I/7+zaMVS3YAwKxWCOSPlfjSUc
X-Gm-Gg: ASbGncvCKIft2TFMtQOnFYpomxUrra1S9gojNfrZgydT1fOG4wScvb0SafO8OhB1vd9
	tiaiw1VxPx5An0m0vu34992UYW/079ksj0+VxZevayvqxQMZ9jY6Iu+fuzgig2M8Fu1vW0mYzMz
	hPuhRcEhUNZUoJXVnDut4RpfZANfGRSWityzp4CS2DsUXWvsayXLaz+ycJhRVVVhv3yVjhcyMkn
	lmEdFLrRvccOsRFjQjPQfXqM2vDKiv7uCGZKQ+I4a50gcCbFUzryhp1mQLQgJ1T3iWT7PMfdtkb
	oNeH7Id2QdQO4FLRyMXtJXPV+fvSzbZX0CkhrHhvq35GSkd2iFDq6Eu0
X-Google-Smtp-Source: AGHT+IGYkjUcBlLw+b7GbNbxsygVmrtIEtua9UQoPhqq55dAu8Qjkm2pVh/YHjlv6m+GtGImvHaWpQ==
X-Received: by 2002:a05:6a20:c90d:b0:1ee:dded:e5b with SMTP id adf61e73a8af0-2148c40f940mr2978573637.24.1746592578553;
        Tue, 06 May 2025 21:36:18 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:734b:a7b9:d649:5d9e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902109dsm10350720b3a.106.2025.05.06.21.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 21:36:17 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	willsroot@protonmail.com,
	savy@syst3mfailure.io,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v2 1/2] net_sched: Flush gso_skb list too during ->change()
Date: Tue,  6 May 2025 21:35:58 -0700
Message-Id: <20250507043559.130022-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507043559.130022-1-xiyou.wangcong@gmail.com>
References: <20250507043559.130022-1-xiyou.wangcong@gmail.com>
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
sch->limit against sch->q.qlen.

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
 include/net/sch_generic.h | 15 +++++++++++++++
 net/sched/sch_codel.c     |  2 +-
 net/sched/sch_fq.c        |  2 +-
 net/sched/sch_fq_codel.c  |  2 +-
 net/sched/sch_fq_pie.c    |  2 +-
 net/sched/sch_hhf.c       |  2 +-
 net/sched/sch_pie.c       |  2 +-
 7 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d48c657191cd..1c05fed05f2b 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1031,6 +1031,21 @@ static inline struct sk_buff *__qdisc_dequeue_head(struct qdisc_skb_head *qh)
 	return skb;
 }
 
+static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch, bool direct)
+{
+	struct sk_buff *skb;
+
+	skb = __skb_dequeue(&sch->gso_skb);
+	if (skb) {
+		sch->q.qlen--;
+		return skb;
+	}
+	if (direct)
+		return __qdisc_dequeue_head(&sch->q);
+	else
+		return sch->dequeue(sch);
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
index f3b8203d3e85..df7fac95ab15 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -366,7 +366,7 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 
 	/* Drop excess packets if new limit is lower */
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = fq_pie_qdisc_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		len_dropped += qdisc_pkt_len(skb);
 		num_dropped += 1;
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 44d9efe1a96a..5aa434b46707 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -564,7 +564,7 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 	qlen = sch->q.qlen;
 	prev_backlog = sch->qstats.backlog;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = hhf_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
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


