Return-Path: <netdev+bounces-179178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF140A7B0B5
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7DB3BF68A
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12F2171E49;
	Thu,  3 Apr 2025 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu9sh0de"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713F81C3C08
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743714653; cv=none; b=JZWJuu0YbyqTv5EcHiViNfXdl0ST2YNTro2j3Qkvg3kJuyWNW3K8C57dVmsl/dt98nDF7p04tJ4B0L5uakdMY5Nf8U3tHi8K10lb5TyxcZjaPreJpIWlGP5U6R9YMVVFVmQjLdeY3N/oe9LZ2pE4lDIid6SixFw9Ya/fVxjWzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743714653; c=relaxed/simple;
	bh=ISaSMzrWByvy0aKtLbM0WfTd5Z2PAmIJUgiNxzgXeIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NzKZ48yS6nYvZRZG3dyIzCUHOB3jp89PCeHETIRwelvmczVKCeFzpAMd4hJluXXF9xm4glBJMV+ftmv7igqVT6jAsBbpWfEYBntY89ehad+yUWjrfrYYWKLrtGooMjlml1YC9GWcLX8ZIFW1G+zf0g+JWw2hf8qznuGVUeRf0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu9sh0de; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-227b650504fso14335505ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743714651; x=1744319451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcD927YR4xHTSf6FJJ2CaU42WhtYVC4m/9wxjMe4NXc=;
        b=Tu9sh0delW0CPG8mjFbVIZCpoiNNEPsmYQEbtOFYMk65KX+KiFnVLGLWjKPwg9Yo6E
         Gz2/o61kIjI1seQNHtM4AnlGeQcm2t4bDJZIO/gD8y2o1JkBoZqhg7nZLf/NdsGINVys
         h2wi9uuavJJVFRbyGaeIh8dLgw82I9RdE3VLFgX1Wf4j2mQTmefp7o2OVPPHd2rKY7zQ
         +CXhkKOIemkuwn2GGnJNWgrz6Pn8kQRBWZ/oHm5l0cOFKAije1b4H3Pcnbfjd0POS0hf
         XHz/Qig1DxUZxMIxEWU7pPKDF240yvUsFUdmLPTNsNI8WKk1RxXbj84bMl8uXOVWo7Sz
         i5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743714651; x=1744319451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcD927YR4xHTSf6FJJ2CaU42WhtYVC4m/9wxjMe4NXc=;
        b=mo6N8RR7Zwmr7O9xoLGr8JlCPLjEUQx6D5dDbeiIC7htXBYMBhjbnzCtqAUI24PNHr
         +o0daTxjFhLsQhFDE6suZD+tIQxflSkG/snARISYn2Pp583+GLvqySdI+/C8oCSaC8z4
         PA/u+7AsfyTy+ZMwFnCCH3Ayh3lC3JT6FErFr4hzcUALpE49bDHlB93UeeAmoU02x10r
         KfgFOU4F6hbg2TROV+O9jCkbj6Bw303y5Y2EPF6U6TsLqYuxtO321O2lmzcnhRMLvgEB
         4qJGZcT13iRSfauvuar/Xvy0pZX+uzY1tXyFbx9ALM355wI9Gr7F/rM1U4QXIOMboOGs
         F1GA==
X-Gm-Message-State: AOJu0YwmTdExnDNSsCFnxfVKNYAQvrRukYC/8vqwqEFsEAmodeA+zpON
	OCSuicOICc6If1NlgqHizQgyRaQUEA6Xv4Urr8W/HFUJv4HzQd77xyJbcQ==
X-Gm-Gg: ASbGncu9s0ZIRGRnNKJzLaT931oOT5blGCEZAe14aqRwMhuSVIKChlJt2WAHvEj2u6H
	L9WqhiC/nrbvvcl5HYHSAUFOD+wU61MGcrIQcWHbHAGApWEB01S2V5av/Xb59PFlsYi5mKbWtWU
	scwNnO65kF0HTSDi3riPWKy7GTT2xaFLja9Z4z6jKG+vjjPQKttAujMzReo+Y0XbZgIIcR4eBdm
	+toG0Ax3ZRtga1nV4y+LPv9s+fPgs9PUfzrwbxrXE7GZ6y4BxOh1ldB55F0qYh8j1oLJcfIh/sj
	Qqp6TnX8tHorR3KgUMq5YAoPd9vKv0lLvs6KRzTdADuS5n24m63861U=
X-Google-Smtp-Source: AGHT+IGiA3cCacbtXUuJ7MBg4zRL1kCQ3xNtpJhxQ/FXf/hzYFqOadSRILnE0M/Q115+R2gHmF1GfQ==
X-Received: by 2002:a17:902:f542:b0:224:1ec0:8a1d with SMTP id d9443c01a7336-22a8a080716mr6231485ad.30.1743714651261;
        Thu, 03 Apr 2025 14:10:51 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad831sm19367645ad.11.2025.04.03.14.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:10:50 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Gerrard Tai <gerrard.tai@starlabs.sg>
Subject: [Patch net v2 02/11] sch_drr: make drr_qlen_notify() idempotent
Date: Thu,  3 Apr 2025 14:10:24 -0700
Message-Id: <20250403211033.166059-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drr_qlen_notify() always deletes the DRR class from its active list
with list_del(), therefore, it is not idempotent and not friendly
to its callers, like fq_codel_dequeue().

Let's make it idempotent to ease qdisc_tree_reduce_backlog() callers'
life. Also change other list_del()'s to list_del_init() just to be
extra safe.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_drr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index c69b999fae17..e0a81d313aa7 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -105,6 +105,7 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		return -ENOBUFS;
 
 	gnet_stats_basic_sync_init(&cl->bstats);
+	INIT_LIST_HEAD(&cl->alist);
 	cl->common.classid = classid;
 	cl->quantum	   = quantum;
 	cl->qdisc	   = qdisc_create_dflt(sch->dev_queue,
@@ -229,7 +230,7 @@ static void drr_qlen_notify(struct Qdisc *csh, unsigned long arg)
 {
 	struct drr_class *cl = (struct drr_class *)arg;
 
-	list_del(&cl->alist);
+	list_del_init(&cl->alist);
 }
 
 static int drr_dump_class(struct Qdisc *sch, unsigned long arg,
@@ -390,7 +391,7 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 			if (unlikely(skb == NULL))
 				goto out;
 			if (cl->qdisc->q.qlen == 0)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 
 			bstats_update(&cl->bstats, skb);
 			qdisc_bstats_update(sch, skb);
@@ -431,7 +432,7 @@ static void drr_reset_qdisc(struct Qdisc *sch)
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
 			if (cl->qdisc->q.qlen)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 			qdisc_reset(cl->qdisc);
 		}
 	}
-- 
2.34.1


