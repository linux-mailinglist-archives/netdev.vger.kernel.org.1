Return-Path: <netdev+bounces-176618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8B8A6B19F
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2476A188ED29
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C913022B8A7;
	Thu, 20 Mar 2025 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwuV0x8D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9907A22A817
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513158; cv=none; b=gh2Ekgzt2XSvclZljf4csUTsB+wG/PkqKxFAuRcJ6anctrq4sVcKc/KVBGMEfPedtHGBH/M+p+95HDVS8LB66vfO3/SD5EpKh0lKVLl2Lwa1lZ33BTU0hHUBciqIIWiLwEl3aSVaiUJnAIM8uouvXQKRCXMnOnxXLrdgk+JPLgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513158; c=relaxed/simple;
	bh=rHX1QWU5eiWuX+n9VOOkmnkpZeMnmrL3na+ia443Bow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VU5t25GLyewaZCBvA9B7Qm/JhEI7zgerA0p7obaMu1PTa3x8LBDgDiJhH0whTz5pD3qnH1714kXhlGX/PhBID+PVhK/NjQyasPQMfLAjRyFlmmuQb25IbvbRbjaTagV5DsrQq8Ti7XQhGwjTcpcJ8VXUfg55USPfMce+eV2O8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwuV0x8D; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225a28a511eso30035745ad.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513152; x=1743117952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fImpDEeSKh+sUQxlOk8pcKlX1iFw4vWLG+z9axE+4/U=;
        b=XwuV0x8DotRDaQSBMNKPqROGfa2SFS1FhdscKWC6sCCuohUXhDR29JJOwgFs8tgnLt
         XooneweTZ1CfMne+nOWSPE5HI9acW1mAfxIT5BhMxLdSJPG+fxKqEEPw/0vxQz/vckks
         wh2vL8pmedR4J+LqTGIZxOB0QIsmUjL07/77p6/tihY9U2kxIr+OL3+tpMB6Hsaw4mlY
         9O5HOHOgl1ob3lBE+8gFycO6rkuIr6PqdYuf0lV74YEiH2mxh5qxcFApGB2U3B8RXm8x
         kaAJiqiE5rUO1Dz1nXClfBP2zW9qd9j7AVtJ5qqH0UaH8otC13T1JELJ9x7KWVDlF5tp
         ClcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513152; x=1743117952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fImpDEeSKh+sUQxlOk8pcKlX1iFw4vWLG+z9axE+4/U=;
        b=In20XOtY0cRlGio5i3n+YdrvrxdFSYUZBKv4FY6BYB/UQQv6dtYnlXpbhP9rLVvwem
         Ai828Sv/FtxhLOZOu0ue4ax91Dtm4/RDBFvkPvPolOwL484/v+UOaM2se0G91GVyi+7c
         ZcLO028DE3dkrVyrjO9W4iR5nCq9dUykhD5bwrQ+rpBKmztE/4BsdQ05nJCbekNGB5P4
         wQAOiyvk8SOz/eJNwRnytXAx2ykjlzc3ciqMBFtYFFnjtMcdavFzOCFmxqkZsXGjyJyL
         /J89VDgc+rK+XrlxB3hrRsUcOGPY8Q4cY50v4rlKuMu9Gbh7RXD1PuCvK94CLDFUVi6t
         BiGA==
X-Gm-Message-State: AOJu0Yza4XLCeViun9NiarX/hnm/B1X5Wo1cX57I4tiWKUmD4wMIT5Yz
	gV/TqmRJyTGBYia5pYnDKTra6eNjOrRrXO6HMBa6/YGuIOHJgLNyX1sxPA==
X-Gm-Gg: ASbGncup7J5GsHmC0ce6BHyyEfOJzeQ6ej93YmbqMB6CL+hAD4GlHhgDONsDBcQN+7U
	bLy00Bf/fMGTPhOYWSTs2eeTEtyTqkDqZyuMyMpyovwtMJy7vdoyA6S2oQfVBh0fEvYLTSI/1oI
	PdI3iHP70TIaSOKI4zZZ8u/AVEx+/XhGXPEkh1tRwbiG3xhfWfKIuprrafoW3vEB3kxCZJ/Rl0K
	qt7D+Drjqcl7Dnwi4NRMGAk8Ss3T4J9igSY+b4sn1U2kFDcBRNgBzW/4vpslfDhuegvSs8uqiyj
	VP3cPLWOweTuAAc0i5VfgBfIGfPCAee8ieF6Np09XE8C6j0g3pG18iM=
X-Google-Smtp-Source: AGHT+IGgJQDI4IHylZFIDtQP5faPt/mYI2tYEjIFxLVTRhgUOHA5NHIKoLBA0dN/FOSBRHbYiflSaw==
X-Received: by 2002:a05:6a20:3d89:b0:1f5:535c:82dc with SMTP id adf61e73a8af0-1fe4330dcf3mr2018511637.42.1742513152250;
        Thu, 20 Mar 2025 16:25:52 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611ccf8sm416306b3a.120.2025.03.20.16.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:25:51 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 04/12] sch_qfq: make qfq_qlen_notify() idempotent
Date: Thu, 20 Mar 2025 16:25:31 -0700
Message-Id: <20250320232539.486091-4-xiyou.wangcong@gmail.com>
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

qfq_qlen_notify() always deletes its class from its active list
with list_del_init() _and_ calls qfq_deactivate_agg() when the whole list
becomes empty.

To make it idempotent, just skip everything when it is not in the active
list.

Also change other list_del()'s to list_del_init() just to be extra safe.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_qfq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 6a07cdbdb9e1..9f8e1ada058c 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -347,7 +347,7 @@ static void qfq_deactivate_class(struct qfq_sched *q, struct qfq_class *cl)
 	struct qfq_aggregate *agg = cl->agg;
 
 
-	list_del(&cl->alist); /* remove from RR queue of the aggregate */
+	list_del_init(&cl->alist); /* remove from RR queue of the aggregate */
 	if (list_empty(&agg->active)) /* agg is now inactive */
 		qfq_deactivate_agg(q, agg);
 }
@@ -474,6 +474,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	gnet_stats_basic_sync_init(&cl->bstats);
 	cl->common.classid = classid;
 	cl->deficit = lmax;
+	INIT_LIST_HEAD(&cl->alist);
 
 	cl->qdisc = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
 				      classid, NULL);
@@ -982,7 +983,7 @@ static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
 	cl->deficit -= (int) len;
 
 	if (cl->qdisc->q.qlen == 0) /* no more packets, remove from list */
-		list_del(&cl->alist);
+		list_del_init(&cl->alist);
 	else if (cl->deficit < qdisc_pkt_len(cl->qdisc->ops->peek(cl->qdisc))) {
 		cl->deficit += agg->lmax;
 		list_move_tail(&cl->alist, &agg->active);
@@ -1415,6 +1416,8 @@ static void qfq_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	struct qfq_sched *q = qdisc_priv(sch);
 	struct qfq_class *cl = (struct qfq_class *)arg;
 
+	if (list_empty(&cl->alist))
+		return;
 	qfq_deactivate_class(q, cl);
 }
 
-- 
2.34.1


