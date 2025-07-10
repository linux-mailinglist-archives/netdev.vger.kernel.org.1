Return-Path: <netdev+bounces-205735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6563AFFEC3
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 12:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BCC1C85E45
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF792D5A1F;
	Thu, 10 Jul 2025 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="nOIp1/U3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A352D5A10
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142189; cv=none; b=a7fl31BGxZgA/0zCB9KVgPrp5fP43bpYj6ZThlFtfNVmTd13ZlxxH37BnJj0QWeRJyypajHrgGf4qa+9zE16gjcGIRJwQklFjdULeYDftJXXzPze/HGcHzrQXU6DebAZ2hVix1EXVGMv0B9lYJ/D52DeLpwnARnjwfpiB+8zvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142189; c=relaxed/simple;
	bh=uGb5z1puunsnCCyaT5e2323HswJ7HchHcTGcTl7LYpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmAXorO6fpb7FdDB0/Yp7X8R7chDktBkvDC3ZJTmAs8ptkNlJDTl0j66pGNokv76yzPZ3PMjCgzTffCWf4OBCTOrKV55YdWTzAflIiIPPNu8lXp3baDjQJgFaKsXO5Sad6L4Ji8E73z5xXDFd1sy3uAPRrDx6FOOi2hYQKrJlBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=nOIp1/U3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74b27c1481bso526324b3a.2
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 03:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752142187; x=1752746987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IUrw0IXmqX16TcWmQ7V7IGWA6zi9U/qCB2cW8nJ8SkA=;
        b=nOIp1/U3C+u8xoca3KzLv69TaC2yCTP4Mxooo5hxh/Ak4Hw3QeN9cgmBelpdAof1Je
         cgu/hXAf+A1t/wddSiw2ByXiDzwKnUwB/2cVOz1/ToOtWM+jE1YhdhW3KHt+GpZr4+Wh
         zywHKlHAtUTpMbPs3EyKXh9sTPcqUg0d/1Bj7wSoMHroIdzNyV7u1PMhHB3pBVIMfDSY
         xYHMPrCLf6rgN9WC+tQw4ekVFGuZ9or3ZpEadcUrM5/f9MKZWwqlLsK/91SIXGRvQKoc
         IcJ661HsFSZzHu3FzvFhOYJPXQkt8/t0QIZ7yHYshKS7LCNQJuQd2f0szp9W89qvvnDv
         eEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752142187; x=1752746987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUrw0IXmqX16TcWmQ7V7IGWA6zi9U/qCB2cW8nJ8SkA=;
        b=xO5LUCRXkYK6avc/G5CchsKF3ub/L/i2VIIfrSeGw7kCr9CdWJbfJDfIhZnQjzBdJr
         JnYlfwXofwEIPBW1OBjM2wKaaOsFm+612ZOGx26R0Zn6BqN+vbruetkol5WeYcPYsJ7h
         iOcY61s92Bccm3X0qpveeUxCuglMya6ZIB9H/9y1qqiT12+fZfH/Dml7Yb3uMfKQwT8H
         0msY4lOyH+dgi69r663KvHmkF/ymzOz/XnQJZwLFxS+w+6jXyPqwkyZXUwKxr1bcuA58
         e7fcUufeqw7ffvFiUsxvz/oVk2+bRi/MsBQpHClo4xPyZot+jVMLfWNUPAgHI0ppKDqP
         EXdQ==
X-Gm-Message-State: AOJu0Yz4G8LJ/nmVVUauoO5vryWDDLlenrmZ9hb+IWp0MrQ/hDrdRy2u
	wuqHY/i3rmT3A2B7a4T76SkgCmWHF4YTaocALKi6sIrbQ2SYb0oeopZfn6DYhItqgw==
X-Gm-Gg: ASbGnctdSVY37L1pYWbJaJ6H3HHEqX4i9yOTssWTAb8Ke0s+j0aoI5/bkWpdXTopkMk
	iwaXmhg1HvJRFVJGKdwh0Alsu7+2uf/ZutdCKs8wXBZZNUhBeOnR31h6kwStLszvOmv/W23uz0G
	ycCDzb2bEwkSsmmoC/O07ngNehugoLNbG9ZeM8yDC4ZaUkis9mgJcPK+i41xOpVm3AssIQmbduG
	FzJsNl7RMgaE0dXKM6bVjxOwj66LgCZhsCIQK8K8fxhmgbgtzUCr3Xbe+BUzyY4At+cu9maYxnX
	VDoL+NSJ6qxeM8aVSUzXZd2ZUpzIzOX7xO635XVkPLGeI4aj/sUYsWd4W2eEPaUPiBXsPMro9uW
	2aaTJJGYhLDaskA==
X-Google-Smtp-Source: AGHT+IF1EoBjMkMKYlicecVPELls0rWiAZ3hqt3PW+YAZAfNXJW/mgrr8l66mLe1FKocQi2mPiCbZw==
X-Received: by 2002:a05:6a21:9988:b0:216:1fc7:5d51 with SMTP id adf61e73a8af0-22cd8085875mr10001017637.37.1752142186935;
        Thu, 10 Jul 2025 03:09:46 -0700 (PDT)
Received: from xps.dhcp.asu.edu (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe72912asm1734645a12.71.2025.07.10.03.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:09:46 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: xiyou.wangcong@gmail.com
Cc: netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	security@kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v3] net/sched: sch_qfq: Fix race condition on qfq_aggregate
Date: Thu, 10 Jul 2025 03:09:42 -0700
Message-ID: <20250710100942.1274194-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
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

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v3: Remove Reported-by tag
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


