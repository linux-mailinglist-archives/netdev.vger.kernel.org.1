Return-Path: <netdev+bounces-205516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 464D3AFF070
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136D91893813
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F310822A4E5;
	Wed,  9 Jul 2025 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="iBLrReOo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DB221567
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084391; cv=none; b=qeOHb7T6k861B8qMtk5VbB68VeK8j9Ng9+IKfQVPLiI5Ufx5wMNuNqC85S3rli6snHp5j4S1wnmNFEZ9joeYBnYovR3Oimigt/Xoc4oY2wlZkRwf1m7J6yLKZP/sYP282ez9V3bRdw0QtilmEi4TATuPjxcBmUpJLogwaEXO+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084391; c=relaxed/simple;
	bh=nuTqnsYcuYvafuidBh5283rvVIY9jSriV2yHttlgS3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giW+EmBSRgqCPo01ESWr4kvnJcluZC9FFt7pBXTYvu1JvHtsIdP56JlL/hypbG9TfdQKeEu/cCMx4ujDrjNG+N/YIXcOOzpBi31Pie6h4MWcZos2sCg0fIhOx5mJaYRba0YwJCqo1qedNRVFN6RPx1GUiGjhgXkYXf9V2E64jWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=iBLrReOo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235ea292956so2339055ad.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752084389; x=1752689189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysC5mho1VlRuLVrarXHBALbI6+JtPPI/S4pqHBToqQw=;
        b=iBLrReOoVhAZg5Kv8YQjhXIJqD8ZHG6u0wpu0WGAHMC1tyXtOpJ4HsY7L1s+NqACJi
         dPf2SZuEdB3CYpnKmvcFpNQajqamc2lURKL1TB/fSbfgh4/xKCnOC9TRzvCOHwUEtq0E
         4+RULUtWU+cC5hCgqAPBGpqBy3S09urAQAP3NeWBYr2hJ5kJDHeEQg54WmJrUzbT8mhg
         zbLTg0ycF90C4UU6a44fv/IRqyW5BWWHADUixH5KlFSIVgnrIFyn5QBXf+AZl7WA8b/1
         ZgF7fC4wggG0NWcosZrYICECPmUAoR2bOzGH/bvloA+lsY0hJQ2pfYWtUs12ccnjG2h5
         5w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752084389; x=1752689189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysC5mho1VlRuLVrarXHBALbI6+JtPPI/S4pqHBToqQw=;
        b=i+7ue6HD+LQeuIwM6irUC4lkwXwOMQ2Oi183cBMGF7mELjh4ZZJrn0oF/QiGnTUZRN
         KgsP4d19tO6koWMqPEzlIb8pU1DcokWo/h7+jP6B/F9MiUvYuae2FB71mztSpigkkJno
         a+K1wKyzlIiIBcG8MBxWygvif+GIbGi8PH+U3viSDmT810YCcuDCz2yMTRL8A13lPIjZ
         eRw2YBhP7p3tkvncuS4pHUfJU7rf2ihg92mZuLz0zE06pjyAeDOvEMfXwCr11PpkWrFP
         fqzh4T3oX3TAJc7ewtAohFPBY0JTo8rTrUxTlZKZ9wGDdipxdMsqmR9/TJJxa1XIY8nv
         fY3w==
X-Gm-Message-State: AOJu0YyQitM5B0knU2ei7xQ9WJEjI2WkgcRu9EztlRNv+0Yi1x529v0e
	aWFnO8vlCzHv8gF+ZO+u0BszVgrAgCvlD9fVcBghksDsgB6AJTTZrtyIXiB9qeS8Ig==
X-Gm-Gg: ASbGncs6/S6/E2AnHY2hGqbYdde8eM0BUh7j2lY0Avdgp0UNGSAk5VD8YTiWQJMm+ru
	SuCgbxK0jlZ5KXUT3bSZIyLC+UChz5E6UTQgzpBaiCBFNE5A0UyxidcysU/6YD+gTTpGU8rWSxh
	xZzr9pNf6xZ3V7bALewG9Z0kUXA2AeuUSAUa6f4sJSaehBX8M5KFjh3NIWA0/tVuaM4o4ZfpU1L
	PMorgRt4iskudmfisY7ZaITWRzwPzQNBsIrLFeibD368RK7i9tnyLmURsIweQ6W1oFthmLNxH8g
	hJU+ErS/dUq4bJ7jPwbpAm7giyCUSp2lfnY4SA0oKsUx0SfYqQYdKCU5rhk2/O+UL1PdGqjel/h
	ZDT1nd275kl6Anw==
X-Google-Smtp-Source: AGHT+IFIQkrxoOQKD3Mg49GUjiqX5R8BbHr7a7470jgjettBMy625yK8rwvnTHDnuDTs4PuBU2D/Ew==
X-Received: by 2002:a17:903:2291:b0:235:f298:cbb3 with SMTP id d9443c01a7336-23ddb1a51cdmr46457785ad.18.1752084389232;
        Wed, 09 Jul 2025 11:06:29 -0700 (PDT)
Received: from xps.dhcp.asu.edu (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455c420sm157145485ad.89.2025.07.09.11.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 11:06:28 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: xiyou.wangcong@gmail.com
Cc: netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	security@kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v2] net/sched: sch_qfq: Fix race condition on qfq_aggregate
Date: Wed,  9 Jul 2025 11:06:22 -0700
Message-ID: <20250709180622.757423-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aGwMBj5BBRuITOlA@pop-os.localdomain>
References: <aGwMBj5BBRuITOlA@pop-os.localdomain>
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

Reported-by: Xiang Mei <xmei5@asu.edu>
Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: Add Reported-by and Fixes tag 
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


