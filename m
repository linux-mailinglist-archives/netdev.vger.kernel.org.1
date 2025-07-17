Return-Path: <netdev+bounces-208025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43744B09710
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B915A1698
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7A72248A5;
	Thu, 17 Jul 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="g3H9YnSh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69099149C6F
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752793302; cv=none; b=WKcar9D1LbUGuxYIrRzdU54a9NB2BGjNdjAyo8l9J0NX/OCiknNbLAO+htXqj4U5DyGMgkBCqYcnR60N2XXCj1Uxl2+5GXFrxX3omoGZ8oT8VMxlS4aQnllJaTjWPLKk7V8TtKmpslxuDL6cAxRB5Es5B1HV4VQyo/LyfWFXbL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752793302; c=relaxed/simple;
	bh=7ZKRj9ZCQfggJhJjtmBsObNV+BL1oFP4t4H0B8fR248=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPhLJUgHJrHH9xCaLLUtQG/cSwsGcl8aTtQYI6GXIKCSiu17B6Se+6oWqI7EitPH2KSSqWI8GUJ6x55yZ3jHLiWQMFYTnRvgJzJ+m2s3u8hidHVEUx7ErVC337GokU+XjOhSmwAgqDUP2kNrV8n8WjMsjGrk/bOclp/t8GUupdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=g3H9YnSh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b56b1d301so1110530b3a.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 16:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752793299; x=1753398099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SVZP6W+azSTxvXLgHYUYrH9SWEjTZ1+PaY4TgxXNB48=;
        b=g3H9YnShrrdvRdV8AzcxCgy58YGu7zJ8TkTfb8DfVfgaKkRdIRKmh2ptc75MDzPeH+
         TYxfeWTDqMN0o+11vFTbnpo2xfCFg2YDwRFY/MUkFltw0dJRdYCMQp2EEa3IjT0UXBAr
         GA4r8RwTzhY4QAikjvGaJaJ/1Cy0KizdlM2f2Egq4/o8gSKQE3D5AiQRDdYrFJjnrvS7
         0CJHLRkgsOM3k2jLPOhNMnzrDRu+A3F3n9CZ7YOjBQl9NOLqnkKuncIFyJ8+4NOKG4xq
         d24ow6J8ojsX+w57wx/jpxlnDmMRo9Fm3mDY10kHwfifa1JczEYHWavK8YgwH7JfLcm0
         ZN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752793299; x=1753398099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVZP6W+azSTxvXLgHYUYrH9SWEjTZ1+PaY4TgxXNB48=;
        b=CjmYpfh51AYbanfA9jvTbRE6coD2nef4NglUScCHKBV/8cdgHIXvWgU3v9kan/oOP6
         N1JDQIXB3OyPvH/yaoE2+HPJQiF81HfGaRvzjIPJ/SnbcMZnUrANLMR53ziQKkdnTFy+
         nTagiOFI2OCxUZJHndA2GX8tkJuqOSkOqA9txxcQ2AmNX6e1vMrr4dsXsPQ86P3qVW6e
         T7v2cOaHPjhMWSSrUkUSz5+eXzfzpVq1BWDOH0I064X4RSp6DF/qZu3IzN3Zojs7r4pB
         TnkAspixgu66OWUIYl2J8AJO8WXCTLABDRohQEOZLDf62GoxpUbI9fbJzbe3UfkVxbk4
         wAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBJHysAjgYC3bvTzMz8RD+tXh7gHyB0e7FEjoC1cG+saryvS0Ccfj0DGSFe1QDpwBrByDz8k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMkMZTa8vIH8q6hlCcem1Wzy3Cjgeqbby8cRkIS1sSpCv4+TJ
	qWH4d/AXr75GSkTUycUx31u9RIpJZjgHM1+nQHe65aV288I31yPYGbtOcrlViyTuEQ==
X-Gm-Gg: ASbGnctaAPOi3CH9Z4Xv+hkWUVEoZWtYqnkG8xkMYavhKkrekYUP/zDKUml3EVT0Qwe
	DnCqr6H8VWTjtx7fErqB7gocUXtoziR7dgqHNq7+m8mYDt7Ikp9GiVh1oNTsc+aYSJ9hI76whNK
	/AD714PQxBJaEEPcgplOFj3fiPIeXYmm2P7JAkJRLVfQGY29GMgonM2KJIrly5cCVxllQ6IfV4p
	2kg+474nLcpsP4D14/qAAEfv/pjwdHz1Lw4rr6mcaxSxsxmNFu2/JRZIS41wedE1RCHwZJcCUOb
	qLzNeZ37zY0C/sxuZefJKqRNGOwsXZL2EJOdTj7ly+YOYJbZTTjmm86zU48Maf6y+oJrlHYFpCu
	eopPmAR36PNR6+/x2mj6wy1AkaIp7q0Yn7lZs8JrS+rYDgDMKWgJgdhOVr42X
X-Google-Smtp-Source: AGHT+IEYSMcU5A4NiaG4lo3Y4g0HWs+vdyRFs28fLpIYoJWYRKoTWFdQb4jx+4e10qwGJiYVKph62w==
X-Received: by 2002:a05:6a21:4593:b0:215:eafc:abd9 with SMTP id adf61e73a8af0-2381143f2cemr13218359637.14.1752793299555;
        Thu, 17 Jul 2025 16:01:39 -0700 (PDT)
Received: from xps.dhcp.asu.edu (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d4efsm72383b3a.107.2025.07.17.16.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 16:01:39 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: dan.carpenter@linaro.org
Cc: xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v1] net/sched: sch_qfq: Avoid triggering might_sleep in atomic context in qfq_delete_class
Date: Thu, 17 Jul 2025 16:01:28 -0700
Message-ID: <20250717230128.159766-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

might_sleep could be trigger in the atomic context in qfq_delete_class.

qfq_destroy_class was moved into atomic context locked
by sch_tree_lock to avoid a race condition bug on
qfq_aggregate. However, might_sleep could be triggered by
qfq_destroy_class, which introduced sleeping in atomic context (path:
qfq_destroy_class->qdisc_put->__qdisc_destroy->lockdep_unregister_key
->might_sleep).

Considering the race is on the qfq_aggregate objects, keeping
qfq_rm_from_agg in the lock but moving the left part out can solve
this issue.

Fixes: 5e28d5a3f774 ("net/sched: sch_qfq: Fix race condition on qfq_aggregate")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Link: https://patch.msgid.link/4a04e0cc-a64b-44e7-9213-2880ed641d77@sabinyo.mountain
---
v1: Avoid might_sleep in atomic context

 net/sched/sch_qfq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index f0eb70353744..2255355e51d3 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -536,9 +536,6 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 static void qfq_destroy_class(struct Qdisc *sch, struct qfq_class *cl)
 {
-	struct qfq_sched *q = qdisc_priv(sch);
-
-	qfq_rm_from_agg(q, cl);
 	gen_kill_estimator(&cl->rate_est);
 	qdisc_put(cl->qdisc);
 	kfree(cl);
@@ -559,10 +556,11 @@ static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
 
 	qdisc_purge_queue(cl->qdisc);
 	qdisc_class_hash_remove(&q->clhash, &cl->common);
-	qfq_destroy_class(sch, cl);
+	qfq_rm_from_agg(q, cl);
 
 	sch_tree_unlock(sch);
 
+	qfq_destroy_class(sch, cl);
 	return 0;
 }
 
@@ -1503,6 +1501,7 @@ static void qfq_destroy_qdisc(struct Qdisc *sch)
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry_safe(cl, next, &q->clhash.hash[i],
 					  common.hnode) {
+			qfq_rm_from_agg(q, cl);
 			qfq_destroy_class(sch, cl);
 		}
 	}
-- 
2.43.0


