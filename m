Return-Path: <netdev+bounces-125480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0015596D441
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2962280E1C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551061991D9;
	Thu,  5 Sep 2024 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BQ0ZQLEW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4961991C9;
	Thu,  5 Sep 2024 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529800; cv=none; b=KJRRcxz4lY3Np/LIUtcEEoKV1pTGtABweVnRKXGyBd9jay7pPsJTAe+xj7hzyrWSW5Oi68b/fqEniuRCjidUepIRJeWCTjvI/5ikRDd5h543g9loNhN3aBR+U9nLuBltGqHZYGDdglOUhRIpb2MqGZtaW/pxlr69LEnkb24azB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529800; c=relaxed/simple;
	bh=bBtZxYNWIPQcenUU9uTRZcBQ/I3gLWzWpAHTFGDdo+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuYQqFltlrCDOFTFVgUY7TCSPtxaVPuvq9N50m3eM8p9E7ETjEmGtRR5EJSWy8zqJyH/UOC6bbCGV6QUXj9TPmlkXKG1rFrflJvMCTb2fFNCdBJgpEbHdsCrKVrAKYdoQdGa/X9meid80BiwyY1Zd6lNrirPj6j7Wi6anbjEaEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BQ0ZQLEW; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48587aT7017352;
	Thu, 5 Sep 2024 02:49:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=j+7LOm4zSPTZXWb9yajtWv/4z
	y1SGCQMHjE8RQmTEe8=; b=BQ0ZQLEWCd0tiPFZUdt/IWtyF8Deo5+eoEXtPb9pD
	DmB5w0zmyhk2bCI+Iz599T8g1YQVeZywkABew1FqEnJcThC5EYbJvpDsqd4s6o7x
	j95q2wf5Tb5MNQUL4zaAp2llxh69+vfwn7jXemPYwUHRxF7yXpz98G/x5dnI1OY4
	XlfWutuk704m9r0U0gTa3yExE8tK6av/gNpBVu0miQtFxl7o7BWgKtnePnc9h+K+
	U1cuNNsyE3KfAhgymjIeWX1i/jIDK0YPmvEefbEA5mau38+tb7Ny/kY+r2wAZ9ci
	2GrOBZGidk0X6LSJUjv/UJF6KdgOjU4QhbfQmR5AbMzUw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41f8u48bhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 02:49:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Sep 2024 02:49:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 02:49:48 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id C195E5B6927;
	Thu,  5 Sep 2024 02:49:44 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v2 2/4] octeontx2-pf: Add new APIs for queue memory alloc/free.
Date: Thu, 5 Sep 2024 15:19:33 +0530
Message-ID: <20240905094935.26271-3-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240905094935.26271-1-gakula@marvell.com>
References: <20240905094935.26271-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KW1K8vW7sAwDQNCgLTYKe3fkLJOMc_1U
X-Proofpoint-GUID: KW1K8vW7sAwDQNCgLTYKe3fkLJOMc_1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_05,2024-09-04_01,2024-09-02_01

Group the queue(RX/TX/CQ) memory allocation and free code to single APIs.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.h       |  2 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 54 +++++++++++++------
 2 files changed, 40 insertions(+), 16 deletions(-)

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
index 4cfeca5ca626..6dfd6d1064ad 100644
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
+
+int otx2_alloc_queue_mem(struct otx2_nic *pf)
 {
-	struct otx2_nic *pf = netdev_priv(netdev);
-	struct otx2_cq_poll *cq_poll = NULL;
 	struct otx2_qset *qset = &pf->qset;
-	int err = 0, qidx, vec;
-	char *irq_name;
+	struct otx2_cq_poll *cq_poll;
 
-	netif_carrier_off(netdev);
 
 	/* RQ and SQs are mapped to different CQs,
 	 * so find out max CQ IRQs (i.e CINTs) needed.
@@ -1798,7 +1806,6 @@ int otx2_open(struct net_device *netdev)
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
+	return -ENOMEM;
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


