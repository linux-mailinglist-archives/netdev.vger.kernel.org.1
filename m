Return-Path: <netdev+bounces-204353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71690AFA24B
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 00:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC143BE27A
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 22:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47156207DEE;
	Sat,  5 Jul 2025 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="ROGPJv7o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B5C18A6DF
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751755210; cv=none; b=FGHAPCDANP6XMatud9jgbQ/qsy/DEgCauiEPK9BAe0ai7rjqn8kn25qUsvvu7U4lbVti9ObJzuMogWcWwVSqBcKmhGHHBfnGIThAMi6YL2XPUAAwknZAYEYThEXFjJ6WMAtgXBRAmR1do9AwbdhY8odsOOhdEKoc9dF97UbqMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751755210; c=relaxed/simple;
	bh=ZLuTAu+QbDARevzHT9/6zx5Yi/hOJB6s7AWk9TEL90g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCH7R8xlDJoFG6aRknqed8bNoCORO4XqU9BGdKT0PBbc8yowK45TFL1vJO2vCb0AaTAPpxcQF3w5DobQzLcIwuKVfgRdDwnSOR/RmlkvQ7FJOH+6UPQ1NtTcXxc0a1X1q0R+MoY8DH+8usYFYDYCEaRbGZVz2Z1RX8v7Nz34n6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ROGPJv7o; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313cde344d4so1807339a91.0
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751755207; x=1752360007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+9/Wmb3x4S80ZiMfWx/6Gnq1a+X2gsN296vMRz02W8=;
        b=ROGPJv7oEjGHj1ciTSQfUHIrE1e+rFDE8aRDMs6ilLw31VWA3NMQnUVlDT41LnY9K4
         5SceL/m+zduTnKHeAaOFHOS+RMmO+antjAyXql9eKlDSdqyX8LoF8SRfJeA5bslzrLFJ
         bpM37QUqWoCBe1hgzFPU17FsKVjOLzI8PkGEDz9uOT4gfa8EQMJw+CLzpAaZj8GFK+Xc
         BEn08VJeArNLYMQ/m9W/BavxEHMW8k9Z66RvE8SFvL6eqh/ABI0s+OsCFDUtMbWm2/wr
         xgxIoL9s8Hx8bYZQOxukVgxgKp+6RlDH33I9BZxbqQcFk5LB09UgfaA/rZbJkw99Z2zi
         34oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751755207; x=1752360007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+9/Wmb3x4S80ZiMfWx/6Gnq1a+X2gsN296vMRz02W8=;
        b=Y4QiEXfF355tRGvl792iHKmN2CnOJjA80G8RdoUz+lIbgDPqFXgDziV2T6ReNdtVZO
         XlRdpLrS1/9cASztoBPsNIgoB6R2aT9gQaIxuQLH6JSJX+9lSMvQ+I5PSPcU8mHlY7Yu
         sqkokTBhxK/46iCWp71fiIMsoUeAUvhPsKI/Y4IiHlP9QgkgQiw9FIJVfwNjOU+QcsdS
         12CTRbQbG/+zBsdxwNlE7K+kJwemtM/bn/kk4iJIH/rZXkqjvoFcvoSxEYnEPrVVXwFC
         ex+pcHj/Mu0DhQi7/ZGwW6lcqJ6VA6A9IynYuYaELZcmY3eVcKBv9sTucN91Tc7mZ7+U
         pQfg==
X-Gm-Message-State: AOJu0YxOXhHD34Zgkez2wzufdLvAOHTGYdibY/OjGbzFYeru71xM00Sb
	ugz8lkMxSKYTCV/Sl8wuXhROWBq5J/Wui1IEdV17KERZmWzjXJAquxu8C+HJc1La/g==
X-Gm-Gg: ASbGncuLgJTc566WvWXGqm+1SxvB3ZiqNvLwpRLD3sVz+jdrOG2OyaAbbHSbTfVzCQt
	k4sAOEj5Od95aM8iiZJ3rY0+Epax3hzJDVkOrTspCnj0SvKMdbKaz55yZWy/dhECTFyjKEy4YuM
	V8SYV9hpPqRzWeebdnqpF2wCJBVVnwm0wqPUtF6HUWxTAUYceHEwzoss7QzGZGMy4SrSmYJXydh
	KgtN4vB5oKezbLwRG+AeNmBHnHQpkRGOmJ2u/hqol0xaUv50+zeKLmiHnRGrNpjsVmCI84ma4tK
	D2JEt+du0ulVy3i95FKQugki+mWG0nhtG1HGkL3SaNBjRi3A5L1gqroKMa6bNHeqAgaBgi4GniE
	PPFl3/zVoJUQb
X-Google-Smtp-Source: AGHT+IH0GTfXgxLtb5fTckbfwSebOZ4k1HY2bkYE8Dw9rCyGClqv9pFcR4Jz0q5ZDDaRKd1de4+ALA==
X-Received: by 2002:a17:90b:55d0:b0:312:959:dc41 with SMTP id 98e67ed59e1d1-31aaddb4ad2mr10559395a91.27.1751755207344;
        Sat, 05 Jul 2025 15:40:07 -0700 (PDT)
Received: from xps.tailc0aff1.ts.net (129-219-8-64.nat.asu.edu. [129.219.8.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae3e4f0sm5468683a91.9.2025.07.05.15.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 15:40:06 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: xiyou.wangcong@gmail.com
Cc: netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	security@kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v1] net/sched: sch_qfq: Fix race condition on qfq_aggregate
Date: Sat,  5 Jul 2025 15:39:58 -0700
Message-ID: <20250705223958.4079242-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aGdevOopELhzlJvf@pop-os.localdomain>
References: <aGdevOopELhzlJvf@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A race condition can occur when 'agg' is modified in qfq_change_agg
(called during qfq_enqueue) while other threads access it
concurrently. For example, qfq_dump_class may trigger a NULL
dereference, and qfq_delete_class may cause a use-after-free.

This patch addresses the issue by:

1. Moved qfq_destroy_class into the critical section.

2. Added sch_tree_lock protection to qfq_dump_class and
qfq_dump_class_stats.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v1: Apply sch_tree_lock to avoid race conditions on qfq_aggregate.

 net/sched/sch_qfq.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 5e557b960..a2b321fec 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -412,7 +412,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	bool existing = false;
 	struct nlattr *tb[TCA_QFQ_MAX + 1];
 	struct qfq_aggregate *new_agg = NULL;
-	u32 weight, lmax, inv_w;
+	u32 weight, lmax, inv_w, old_weight, old_lmax;
 	int err;
 	int delta_w;
 
@@ -446,12 +446,16 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	inv_w = ONE_FP / weight;
 	weight = ONE_FP / inv_w;
 
-	if (cl != NULL &&
-	    lmax == cl->agg->lmax &&
-	    weight == cl->agg->class_weight)
-		return 0; /* nothing to change */
+	if (cl != NULL) {
+		sch_tree_lock(sch);
+		old_weight = cl->agg->class_weight;
+		old_lmax   = cl->agg->lmax;
+		sch_tree_unlock(sch);
+		if (lmax == old_lmax && weight == old_weight)
+			return 0; /* nothing to change */
+	}
 
-	delta_w = weight - (cl ? cl->agg->class_weight : 0);
+	delta_w = weight - (cl ? old_weight : 0);
 
 	if (q->wsum + delta_w > QFQ_MAX_WSUM) {
 		NL_SET_ERR_MSG_FMT_MOD(extack,
@@ -558,10 +562,10 @@ static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
 
 	qdisc_purge_queue(cl->qdisc);
 	qdisc_class_hash_remove(&q->clhash, &cl->common);
+	qfq_destroy_class(sch, cl);
 
 	sch_tree_unlock(sch);
 
-	qfq_destroy_class(sch, cl);
 	return 0;
 }
 
@@ -628,6 +632,7 @@ static int qfq_dump_class(struct Qdisc *sch, unsigned long arg,
 {
 	struct qfq_class *cl = (struct qfq_class *)arg;
 	struct nlattr *nest;
+	u32 class_weight, lmax;
 
 	tcm->tcm_parent	= TC_H_ROOT;
 	tcm->tcm_handle	= cl->common.classid;
@@ -636,8 +641,13 @@ static int qfq_dump_class(struct Qdisc *sch, unsigned long arg,
 	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (nest == NULL)
 		goto nla_put_failure;
-	if (nla_put_u32(skb, TCA_QFQ_WEIGHT, cl->agg->class_weight) ||
-	    nla_put_u32(skb, TCA_QFQ_LMAX, cl->agg->lmax))
+
+	sch_tree_lock(sch);
+	class_weight	= cl->agg->class_weight;
+	lmax		= cl->agg->lmax;
+	sch_tree_unlock(sch);
+	if (nla_put_u32(skb, TCA_QFQ_WEIGHT, class_weight) ||
+	    nla_put_u32(skb, TCA_QFQ_LMAX, lmax))
 		goto nla_put_failure;
 	return nla_nest_end(skb, nest);
 
@@ -654,8 +664,10 @@ static int qfq_dump_class_stats(struct Qdisc *sch, unsigned long arg,
 
 	memset(&xstats, 0, sizeof(xstats));
 
+	sch_tree_lock(sch);
 	xstats.weight = cl->agg->class_weight;
 	xstats.lmax = cl->agg->lmax;
+	sch_tree_unlock(sch);
 
 	if (gnet_stats_copy_basic(d, NULL, &cl->bstats, true) < 0 ||
 	    gnet_stats_copy_rate_est(d, &cl->rate_est) < 0 ||
-- 
2.43.0


