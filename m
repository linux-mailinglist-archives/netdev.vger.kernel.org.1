Return-Path: <netdev+bounces-182535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8489A8904E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2364A3AAE31
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E938625;
	Tue, 15 Apr 2025 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="s0o9HgX9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30518F7D
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675419; cv=none; b=q19XJk7LS6/l56ARloSAZ0lQ1fPMbHU9bChu7QkX3KWFG62Hgm2jLbFn0aHQ9mgnOR3MdlzuHTFV7DXgm2h8jRgjel4C4VpIzRM1ix3xneqooprtP0+ZrLL6I2Jy4DBbECSZv/JNxjPkx+rqEppo/3/ZcqhgcCgKgfO5RJlNI1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675419; c=relaxed/simple;
	bh=x26DYNtnZB0VgM7+8nyncV/OJFCoH5Udh/zrzfXUs2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYSs5aX6rBKucwtmJUqtBY81ZIRvznAGSUEOS4u94iwHqSWutktFbLEV+pv47dULLM7C+msy1GxROTpuVK8+sLUHrAiSHB7dOfgjzzrXVXytQxJAPTo9uKpGKtuO7LWwF7GPkiDc3IEMW30HeSIrv3y33pmWqfNRI9OSagw1esA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=s0o9HgX9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2243803b776so72885295ad.0
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744675417; x=1745280217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AY0XVjw2fK7W6huM1ltZFLpS5zgaxK05zwKixh9hiP4=;
        b=s0o9HgX9OjXp9wuNEVAMwGHSCips0QWZhQkufPDy7pSyp+tHDH0drMDf8RQbYRG9HG
         zYLqGwGhMYaGi5zzgIfoBCzuT0D4NCFl6+0H+IEGa0CJdM4VXXSqyDs3Mmv3sOtRZ3A/
         48e09V5xNAQB6DUsL1euB02p9IDkFS8jCOD0QUZCZBRk6AnGTGb3PP9ZDBCV5n+isLwe
         Iky4Wyv6H1jmKzWYtsLzy0pMOBJNaU87R+Ooi+4nCxtOc0kr65Ztr7LhH6ODDg0iAI0e
         euoRcpl2LkL4QBiLjahpbwNDl31j/r6/9X5cRos++xxZBAMKOx4k527CafWWqapqpKXw
         vh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744675417; x=1745280217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY0XVjw2fK7W6huM1ltZFLpS5zgaxK05zwKixh9hiP4=;
        b=GOsucloYYAJNdU47689T7nBzmqMTUFor2ToixvMGmzWLFH4OCbA57wx84lHd9jEteF
         R04UkZk65i24gkKLv9y84hblCLJw0nIWCmGrCWuoEHVoc5WP1GAQ6HRFzkCHc4sOq6P0
         PgD3vAb6yhRcNcaSPohfiPbCH+PhcUabrgzAZp18ugxHJ38mralTJxi1wj/bVw1ZRKc9
         6nVaWQQKp+p+pzYs3bMHACRxoX9ElngOQn0oEqExokqE5ULcxkYARtIO+T+RKEnr2J0G
         AUZ1wQ353P+ZMC6fofykUSs1wIl4Q9fmm5N91rIN/DMEyvsyvtzHiMb1pdiaIrBxETFC
         +mbA==
X-Gm-Message-State: AOJu0Yww26ZY509rKXF15MWJIe0oUcKEBbs0kJ2f7os7QRXSr2vrNWKP
	sehDXSpXZKG9/K9v7F7y2TY/TDtHUpdE8g7Nelcp0WEzmA00ZMEKr4gZtAtbqsIJheF3m2gi+1g
	=
X-Gm-Gg: ASbGnctoFubOhSDn/K1iJyun6/SZ2jRRVOQB3DqDt3Rh87pHdu+03tindtvYNYwq25v
	da/WAwkwN1AysvGoG8t5JkdjxUhmZscomV9uTQ16BR6XTyoup1Ut/1YaJKmlXbvqb8J4WHl1tcO
	BEu+iwXwqxXRvsyTvsgso/dARXO+gGDkAanijsJCy2u6WinIJ4LJtImv1XqcaD8EsYDuDR5zRcJ
	vOfDqIomDKOddLycYWjfla3iqfbMf6TiSet00UHe0qrQT74W3p6h3HUPKDpvLnQIP0LmKrMiHxO
	Cm2ZNo+F87tKU3DCbTSBIWZRU8cHkBUh4q26SPbZpa6UNA3T+7v13akPbrwF55ozqPYdSjP1wNg
	=
X-Google-Smtp-Source: AGHT+IHfVRKldFns9CQ0NyJkgicpwDI1/teYtDbou48JM60+7WaQTl4kfPhe5VttJJJGbHgROcFgAg==
X-Received: by 2002:a17:902:e788:b0:220:ff3f:6cba with SMTP id d9443c01a7336-22bea4eebccmr228350935ad.38.1744675416846;
        Mon, 14 Apr 2025 17:03:36 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c4db9sm7445615b3a.58.2025.04.14.17.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 17:03:36 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	gerrard.tai@starlabs.sg,
	pctammela@mojatatu.com
Subject: [RFC PATCH net 4/4] net_sched: qfq: Fix double list add in class with netem as child qdisc
Date: Mon, 14 Apr 2025 21:03:16 -0300
Message-ID: <20250415000316.3122018-5-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415000316.3122018-1-victor@mojatatu.com>
References: <20250415000316.3122018-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in Gerrard's report [1], there are use cases where a netem
child qdisc will make the parent qdisc's enqueue callback reentrant.
In the case of qfq, there won't be a UAF, but the code will add the same
classifier to the list twice, which will cause memory corruption.

This patch checks whether the class was already added to the
agg->active (cl_is_initialised) before doing the addition.

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_qfq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 687a932eb9b2..6180a5e19859 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -132,6 +132,7 @@ struct qfq_class {
 
 	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue qstats;
+	u8 cl_initialised;
 	struct net_rate_estimator __rcu *rate_est;
 	struct Qdisc *qdisc;
 	struct list_head alist;		/* Link for active-classes list. */
@@ -348,6 +349,7 @@ static void qfq_deactivate_class(struct qfq_sched *q, struct qfq_class *cl)
 
 
 	list_del_init(&cl->alist); /* remove from RR queue of the aggregate */
+	cl->cl_initialised = 0;
 	if (list_empty(&agg->active)) /* agg is now inactive */
 		qfq_deactivate_agg(q, agg);
 }
@@ -982,9 +984,10 @@ static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
 
 	cl->deficit -= (int) len;
 
-	if (cl->qdisc->q.qlen == 0) /* no more packets, remove from list */
+	if (cl->qdisc->q.qlen == 0) { /* no more packets, remove from list */
+		cl->cl_initialised = 0;
 		list_del_init(&cl->alist);
-	else if (cl->deficit < qdisc_pkt_len(cl->qdisc->ops->peek(cl->qdisc))) {
+	} else if (cl->deficit < qdisc_pkt_len(cl->qdisc->ops->peek(cl->qdisc))) {
 		cl->deficit += agg->lmax;
 		list_move_tail(&cl->alist, &agg->active);
 	}
@@ -1214,8 +1217,8 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct qfq_sched *q = qdisc_priv(sch);
 	struct qfq_class *cl;
 	struct qfq_aggregate *agg;
+	bool is_empty;
 	int err = 0;
-	bool first;
 
 	cl = qfq_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -1237,7 +1240,7 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	gso_segs = skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
-	first = !cl->qdisc->q.qlen;
+	is_empty = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		pr_debug("qfq_enqueue: enqueue failed %d\n", err);
@@ -1254,18 +1257,22 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	agg = cl->agg;
 	/* if the queue was not empty, then done here */
-	if (!first) {
+	if (!is_empty) {
 		if (unlikely(skb == cl->qdisc->ops->peek(cl->qdisc)) &&
 		    list_first_entry(&agg->active, struct qfq_class, alist)
 		    == cl && cl->deficit < len)
 			list_move_tail(&cl->alist, &agg->active);
 
+		return err;
+	/* cater for recursive call */
+	} else if (cl->cl_initialised) {
 		return err;
 	}
 
 	/* schedule class for service within the aggregate */
 	cl->deficit = agg->lmax;
 	list_add_tail(&cl->alist, &agg->active);
+	cl->cl_initialised = 1;
 
 	if (list_first_entry(&agg->active, struct qfq_class, alist) != cl ||
 	    q->in_serv_agg == agg)
-- 
2.34.1


