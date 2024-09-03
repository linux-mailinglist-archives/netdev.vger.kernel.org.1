Return-Path: <netdev+bounces-124530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26909969DEA
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A44B2118F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED71DA114;
	Tue,  3 Sep 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OsD0W7gf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23A1DA102;
	Tue,  3 Sep 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367277; cv=none; b=MXxoxEasDQBkyFeRrgjU8mIrtq//n+JSHuhYYWUfdwgFG4R/S9b066gZ062hZ7OWSxzFR5bhrPSQM8+7X2z5ZnRTmQvmatyQXPkuzPxO03OlyYxUhW98NDZn0wOWu0mcGQK85Lst4dI8X84311C6blx74VUPS3wRJZqw5P1xJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367277; c=relaxed/simple;
	bh=GvZu/7Zg001miOydt3i8YiOscj+ER+qtTCt47CrJfG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rdg723mxYtP2yh8xCFR8vJmoB+Gz3HCM0KMuOUgLe2iQwl3L4Gp+atKT6m9y16YZ8KIKEJp8BVDvm/+uyqQ1DQcaO9661MnqWVXL9sk5Az3AGrkCVFwRpzXm3p4pV9+hYOO6yaNib2rLnLADDfGOZYVOyTkxTB1tSkQlsMwHWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OsD0W7gf; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48396eH6019070;
	Tue, 3 Sep 2024 05:41:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=77bi3/0sz6UtJdUT9eY+XkD4M
	qoDoanzJOvfa++JCO0=; b=OsD0W7gfM5RbkHGoaRDhckMfl2uP0+N396jljTWuX
	BXlupBwPVkYpHcVl5tmCmBob7X0e8XgFyvUMuvlhJTp4jQtKDSfCB6DRlPyHArYl
	WfgypWbYcD1YI+coN3FI+BfMHFEllGmhAiN1xcDrupXvaTNYiE0PxYJXbshD+dnW
	bq1ug9YFGox/25FjZAcOMv3mWEu7IGhujltATpEojjOObw8DNj6bRhZV8D/b6aNt
	WUBBiGWOMWGDuhJQF3z6+wRijjmMZo5vIJ/n2ksGF72T2xhZRwp+DvGxQ9anQz+m
	4nGuGNrPeNi0/LBCJm6ScHP/kSp7/0xz3R/jfj631M43w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41dyhmrkv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 05:41:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Sep 2024 05:41:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Sep 2024 05:41:01 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 968553F70E4;
	Tue,  3 Sep 2024 05:40:57 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH 2/4] octeontx2-pf: Add new APIs for queue memory alloc/free.
Date: Tue, 3 Sep 2024 18:10:46 +0530
Message-ID: <20240903124048.14235-3-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240903124048.14235-1-gakula@marvell.com>
References: <20240903124048.14235-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8cVoSvQlHnC1UO3nhYS9LnoNr48j8z8O
X-Proofpoint-GUID: 8cVoSvQlHnC1UO3nhYS9LnoNr48j8z8O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01

Group the queue(RX/TX/CQ) memory allocation and free code to single APIs.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.h       |  2 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 56 +++++++++++++------
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index a47001a2b93f..df548aeffecf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -997,6 +997,8 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 int otx2_aura_init(struct otx2_nic *pfvf, int aura_id,
 		   int pool_id, int numptrs);
 int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf);
+void otx2_free_queue_mem(struct otx2_qset *qset);
+int otx2_alloc_queue_mem(struct otx2_nic *pf);
 
 /* RSS configuration APIs*/
 int otx2_rss_init(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 4cfeca5ca626..68addc975113 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1770,15 +1770,23 @@ static void otx2_dim_work(struct work_struct *w)
 	dim->state = DIM_START_MEASURE;
 }
 
-int otx2_open(struct net_device *netdev)
+void otx2_free_queue_mem(struct otx2_qset *qset)
+{
+	kfree(qset->sq);
+	qset->sq = NULL;
+	kfree(qset->cq);
+	qset->cq = NULL;
+	kfree(qset->rq);
+	qset->rq = NULL;
+	kfree(qset->napi);
+}
+EXPORT_SYMBOL(otx2_free_queue_mem);
+int otx2_alloc_queue_mem(struct otx2_nic *pf)
 {
-	struct otx2_nic *pf = netdev_priv(netdev);
-	struct otx2_cq_poll *cq_poll = NULL;
 	struct otx2_qset *qset = &pf->qset;
-	int err = 0, qidx, vec;
-	char *irq_name;
+	struct otx2_cq_poll *cq_poll;
+	int err = -ENOMEM;
 
-	netif_carrier_off(netdev);
 
 	/* RQ and SQs are mapped to different CQs,
 	 * so find out max CQ IRQs (i.e CINTs) needed.
@@ -1791,14 +1799,13 @@ int otx2_open(struct net_device *netdev)
 
 	qset->napi = kcalloc(pf->hw.cint_cnt, sizeof(*cq_poll), GFP_KERNEL);
 	if (!qset->napi)
-		return -ENOMEM;
+		return err;
 
 	/* CQ size of RQ */
 	qset->rqe_cnt = qset->rqe_cnt ? qset->rqe_cnt : Q_COUNT(Q_SIZE_256);
 	/* CQ size of SQ */
 	qset->sqe_cnt = qset->sqe_cnt ? qset->sqe_cnt : Q_COUNT(Q_SIZE_4K);
 
-	err = -ENOMEM;
 	qset->cq = kcalloc(pf->qset.cq_cnt,
 			   sizeof(struct otx2_cq_queue), GFP_KERNEL);
 	if (!qset->cq)
@@ -1814,6 +1821,28 @@ int otx2_open(struct net_device *netdev)
 	if (!qset->rq)
 		goto err_free_mem;
 
+	return 0;
+
+err_free_mem:
+	otx2_free_queue_mem(qset);
+	return err;
+}
+EXPORT_SYMBOL(otx2_alloc_queue_mem);
+
+int otx2_open(struct net_device *netdev)
+{
+	struct otx2_nic *pf = netdev_priv(netdev);
+	struct otx2_cq_poll *cq_poll = NULL;
+	struct otx2_qset *qset = &pf->qset;
+	int err = 0, qidx, vec;
+	char *irq_name;
+
+	netif_carrier_off(netdev);
+
+	err = otx2_alloc_queue_mem(pf);
+	if (err)
+		return err;
+
 	err = otx2_init_hw_resources(pf);
 	if (err)
 		goto err_free_mem;
@@ -1979,10 +2008,7 @@ int otx2_open(struct net_device *netdev)
 	otx2_disable_napi(pf);
 	otx2_free_hw_resources(pf);
 err_free_mem:
-	kfree(qset->sq);
-	kfree(qset->cq);
-	kfree(qset->rq);
-	kfree(qset->napi);
+	otx2_free_queue_mem(qset);
 	return err;
 }
 EXPORT_SYMBOL(otx2_open);
@@ -2047,11 +2073,7 @@ int otx2_stop(struct net_device *netdev)
 	for (qidx = 0; qidx < netdev->num_tx_queues; qidx++)
 		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, qidx));
 
-
-	kfree(qset->sq);
-	kfree(qset->cq);
-	kfree(qset->rq);
-	kfree(qset->napi);
+	otx2_free_queue_mem(qset);
 	/* Do not clear RQ/SQ ringsize settings */
 	memset_startat(qset, 0, sqe_cnt);
 	return 0;
-- 
2.25.1


