Return-Path: <netdev+bounces-127689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042699761AE
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FEF2863A2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3868E18BBA5;
	Thu, 12 Sep 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KT2N/BTU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D4189BB0;
	Thu, 12 Sep 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123247; cv=none; b=GUlT6zl6xlhYBEVlw5LgtKu06yuObFi9LNSe1q+oaq+dJQhz/PckxVXIHDsPe4WSWvpBlUoc+eJHAeE/6y/APu2SSBK2DkcqOhcMPvefshEj/FU17eXTrYg3OBuTuS95e6TdDBfmMrrO27wt7uc49sMNnzO20C3QpR1fgA0iwCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123247; c=relaxed/simple;
	bh=BTelHlLBjaEcqCSwrf7nEBs/56BW2IP5DlDtSKB/L1E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVmrLdwU7II3Y544M/CESau2RLFDS90A0ora+D5H+DwAMuRIAvXctrlYp4U+tF0kGOsABCPCIMREbmdqnZ1IjHe4h93+o218+u+oSU33aEMmB2IZNtyQ2Wf//zyKlIG5O2vEQkw2rpzaM9he0It8cunqqCRwxYEYcOqETKvj5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KT2N/BTU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C4PBoM002008;
	Wed, 11 Sep 2024 23:40:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=6fZymCe3ozioCX6BU2glDdKM3
	4UjRhxGcF/pnKeJq24=; b=KT2N/BTU5p+y7BY0oyM2+yxlO33Ym5I/a0fBQT3x0
	zk7bepCPdh35HzC+Gr9xVMONFYrk0u3zHFQiRbSRbznlj18KS9Cj7iJCy/QQ98C+
	SU8naBej9kAnWK3A+zUxX5iegtZf9uuAjX9F4EODIKNwT7oy3G6lyIgKKqldJtvB
	+yBxdUnrRb9iRp+SiqdR6xJfNLAE9Aj+WNMmLAKaaqIP6KmN1SBjZOPL7DcMi54m
	CeQCuHrzkGlKT3HiNBCZc9WZ8rVp4NdhuLBI88MD2DJQH62Vxq3VK32aIT4Qy3Y2
	xV28reYkvbH9dXZmWvzT1GwHZkR7MrElSVHLxb8WrwO3w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41ks8prd24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 23:40:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Sep 2024 23:40:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 23:40:29 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 160815E6864;
	Wed, 11 Sep 2024 23:40:25 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v3 2/4] octeontx2-pf: Add new APIs for queue memory alloc/free.
Date: Thu, 12 Sep 2024 12:10:15 +0530
Message-ID: <20240912064017.4429-3-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240912064017.4429-1-gakula@marvell.com>
References: <20240912064017.4429-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ewT5etLQFhITbtE_e5MeGzW79wA2UAll
X-Proofpoint-GUID: ewT5etLQFhITbtE_e5MeGzW79wA2UAll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Group the queue(RX/TX/CQ) memory allocation and free code to single APIs.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

---
v2-v3:
  - Added review tag.
  - Reset napi pointer to NULL.
v1-v2:
 - Removed unwanted variable.

 .../marvell/octeontx2/nic/otx2_common.h       |  2 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 55 +++++++++++++------
 2 files changed, 41 insertions(+), 16 deletions(-)

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
index 4cfeca5ca626..b7082a154c34 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1770,15 +1770,24 @@ static void otx2_dim_work(struct work_struct *w)
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
+	qset->napi = NULL;
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
@@ -1798,7 +1807,6 @@ int otx2_open(struct net_device *netdev)
 	/* CQ size of SQ */
 	qset->sqe_cnt = qset->sqe_cnt ? qset->sqe_cnt : Q_COUNT(Q_SIZE_4K);
 
-	err = -ENOMEM;
 	qset->cq = kcalloc(pf->qset.cq_cnt,
 			   sizeof(struct otx2_cq_queue), GFP_KERNEL);
 	if (!qset->cq)
@@ -1814,6 +1822,28 @@ int otx2_open(struct net_device *netdev)
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
@@ -1979,10 +2009,7 @@ int otx2_open(struct net_device *netdev)
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
@@ -2047,11 +2074,7 @@ int otx2_stop(struct net_device *netdev)
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


