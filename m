Return-Path: <netdev+bounces-176615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD0A6B19C
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C08188E4ED
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C252A22AE49;
	Thu, 20 Mar 2025 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwX6qItL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3722A80A
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513154; cv=none; b=G7pXsIpEjb8UoO6HOtLLMeyXL3O449nBsUiRrjam+Df6tVPI+Kc9qjXQR6JxTmt0gYN1aH/mc8Qmeoac+QHhPRAbnW9fW4XYmY5r8zooZ35ngftv3Lgf60TPYcz6JJOSi0ztRCeNwU+3E5CDcXNZyhs3f1Jxim+Tq67wdSp7nOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513154; c=relaxed/simple;
	bh=hHIYHezDOoxCNpJNOVopdAZG9dE34xIK63RE3y96P7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ec82+slcy6FwCC9TKr4mDwWrwc5G+tFK7nw8DDFVXY/qOBDz6L83207vNqkNPLK9CwOINmvLL6TYYfbpeDLAfO1eP3tHYsBGnzT+CdQquThlfZPTmSKKA7yez/cFFowa1+I8Zi7KRIpxgICIM7A0yYD3sQmKzlFYbtTJ891y5TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwX6qItL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22622ddcc35so34797965ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513151; x=1743117951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwt8GGRRu6e4+a9i4CGYtv0iwbrJOPzYW8+muO/Prik=;
        b=NwX6qItLiZBF4qQJQuHDpQCtYW7s/eiZoon1hVtxtSwuAdFOd5exz1QNjIKHb7nz09
         Zq4ueLxRCYh2MtXOy2EmXiFLahRcvOdtIUrLvHbUY7Kjb4YorU3A+2CkHoK8WumSwnLQ
         i9ewzeIIBYQHykAZ6Ti0I3djQ/4yDP2qsnqKfNuquUW2y5Wkelql2DKUhjPW2gwB0Joy
         e2q4alJD07Efg45h8rK6Cp5GL0sYrgw2a6f5ezxt1Lfm/6yoSa8MmVq70nrQTniGaF0j
         uwW//L09AJ66XxvJ1lQCmmDIGdkIEMDMayj+NmAE7Guw7b95Kwe4QfrD2b5NObvv3d+I
         EVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513151; x=1743117951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwt8GGRRu6e4+a9i4CGYtv0iwbrJOPzYW8+muO/Prik=;
        b=rCIUZLVNNKaqVh3r6pURpmIN3OV60beJptMoUAICJJgudbbKuY8Om1A7qE9rQwuURW
         ep4/dKemmed0pV7ybyV8zV9zlOaDbNb/94d+t2cvJ7byq6T6hsecuka9cvD2l0Z3MmQU
         EPE51X49pNPRvzitfH9KeC3rwe6byXcFkEpwS3R75fQ2tYOlj5G3RpRJc8sWjQs7p1Z9
         OZ+NT9jCsv/jt9imfdnp11q2kskDysw6UGYaZzLaNy6M0HexPUSRH53eErRhHuPROaic
         mzVlnQT4YdkkXZB1nVQbmZ3/u0zWmYxr1ohT2UFD3zu0qcHOtEalQPeALhRshPAiMbiy
         QARw==
X-Gm-Message-State: AOJu0YzzEzgisUZK0N/xX/53dRoYJzwlN2J6B+rDodrGsJW2xbQodoWx
	X3kBkkfYm8ZwxPbWXxq5H3hMwtyHZpHGMXLHT1HScASG2liZQKwqCMSWlA==
X-Gm-Gg: ASbGncsy3kl7fI52KXbDDSCemU0pUHXoGS8x4BNNqCirVGY3HT82AeE/zJ0k0qjtYbJ
	WYOEfYoWafiVz1WDTA3h7ZZVZrHShz0t6FLXHbgjvFrlHXszbpTP0kH0pvFJrKTlDvYoHShu0jL
	WTvT7tipIBXtbdHD0zJA2nmnbpRX9dPcv6rcR7YdTZ9LHHjuk6sJFZXE9ekVyGZLvLMOL70a7sg
	TpUQRmtv04nyn4xObe4dcXnnY2mYYtBqO3T+bGZVFpWwfVO9yp7wpJYCzGbkSC2Uxgeyv7IGYUF
	rc/627xx/k6qb7d9V9VT05iRgAk4kEFG594H0jULQWp5HMFIx9jLijk=
X-Google-Smtp-Source: AGHT+IGyd300sXs8kHITPgTm8Jy5EFi8V1/6XJZOy8npHfYxNizoLBzkjCHV2uhDqc1dbf3m0A6T7w==
X-Received: by 2002:a17:902:e844:b0:220:e896:54e1 with SMTP id d9443c01a7336-22780d8c42emr17726075ad.26.1742513150959;
        Thu, 20 Mar 2025 16:25:50 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611ccf8sm416306b3a.120.2025.03.20.16.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:25:50 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 03/12] sch_hfsc: make hfsc_qlen_notify() idempotent
Date: Thu, 20 Mar 2025 16:25:30 -0700
Message-Id: <20250320232539.486091-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320232539.486091-1-xiyou.wangcong@gmail.com>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsc_qlen_notify() is not idempotent either and not friendly
to its callers, like fq_codel_dequeue(). Let's make it idempotent
to ease qdisc_tree_reduce_backlog() callers' life:

1. update_vf() decreases cl->cl_nactive, so we can check whether it is
non-zero before calling it.

2. eltree_remove() always removes RB node cl->el_node, but we can use
   RB_EMPTY_NODE() + RB_CLEAR_NODE() to make it safe.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_hfsc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index c287bf8423b4..ce5045eea065 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -203,7 +203,10 @@ eltree_insert(struct hfsc_class *cl)
 static inline void
 eltree_remove(struct hfsc_class *cl)
 {
-	rb_erase(&cl->el_node, &cl->sched->eligible);
+	if (!RB_EMPTY_NODE(&cl->el_node)) {
+		rb_erase(&cl->el_node, &cl->sched->eligible);
+		RB_CLEAR_NODE(&cl->el_node);
+	}
 }
 
 static inline void
@@ -1220,7 +1223,8 @@ hfsc_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	/* vttree is now handled in update_vf() so that update_vf(cl, 0, 0)
 	 * needs to be called explicitly to remove a class from vttree.
 	 */
-	update_vf(cl, 0, 0);
+	if (cl->cl_nactive)
+		update_vf(cl, 0, 0);
 	if (cl->cl_flags & HFSC_RSC)
 		eltree_remove(cl);
 }
-- 
2.34.1


