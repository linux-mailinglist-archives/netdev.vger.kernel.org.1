Return-Path: <netdev+bounces-127690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D7D9761B1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153FD1C21557
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857C418EFDB;
	Thu, 12 Sep 2024 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CWUs2wZf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3018BBBC;
	Thu, 12 Sep 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123249; cv=none; b=XVWKfwb39LVLCcCRNZWp4ONpqDIK7MXDBgqj3SCpjh3AmMaYgrNajD2AYrR6LuWNB7I/r5dD97b3m9bnr5GQa44wearMhwVnpF6wW/AgRke0CfrE39oM5q9dSe5yyYZNIQrypJPS66Pxa3Gviq1JGqHv5D4HaLxdoyAMn9RWDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123249; c=relaxed/simple;
	bh=a+OQEgihkbaNfjeZoKkfESFnRgk7yCwCS28l/yRiURA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKFYzNg4r8KY6Xt/Q6VimxORBbFyuI/JXXSpfXFEY3VoPBI9aKyhUr3/WQihJV9HDrpK4akuN0lKTkIg5tgxYQv31pvGJBNrRSvCQroBoB7ZGW1SX8/LPYcYHrhHJG2Rc2DyhLIm0a/soKvuGqH6ObBM6REB8jNxqlcy39zYg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CWUs2wZf; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C4PBoN002008;
	Wed, 11 Sep 2024 23:40:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=x96ALA0iQpCyhxiMwZcya8Gu2
	33B4pb5sf20hvT0qNI=; b=CWUs2wZfmzdcpq5REHVCTLSoxG/EWA4p4B3TNJXKS
	mREaI5M8OHgh6o+0jZM7IGBa9/sUM+wc2BHM0FKlzz+s1Q56pnuf3O8njh1vJ9XT
	lb8mvE7JSnOLP4gnVVX9HaV/kCq3wzWgQuq/rolBQ/YxOinb5dHPIW4kUdNyL7GT
	WcCAdpUDyVXK22mMO9aRVsP/rbhaQXCfV3aK6yGZ4SL6ior/CR7nM/ZNCscH8kbP
	oAg1ZE2ntGyP97MB+GLpSPvYz3DeOelwvgbGHlT5dyY0IWLM6EBCuEkYMoDqmqFj
	q7sPaYvqnJt266Ju5rOvU5X5vz1bblj/O/12kH7JDKE+g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41ks8prd2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 23:40:38 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Sep 2024 23:40:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 23:40:37 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id B368E5E6864;
	Wed, 11 Sep 2024 23:40:33 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v3 4/4] octeontx2-pf: Export common APIs
Date: Thu, 12 Sep 2024 12:10:17 +0530
Message-ID: <20240912064017.4429-5-gakula@marvell.com>
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
X-Proofpoint-ORIG-GUID: O2dByzhu19-uKOsm5SIP1l8RCr9cK-XD
X-Proofpoint-GUID: O2dByzhu19-uKOsm5SIP1l8RCr9cK-XD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Export mbox, hw resources and interrupt configuration functions.
So, that they can be used later by the RVU representor driver.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
v1-v2:
 - Dropped unrelated changes.

 .../marvell/octeontx2/nic/otx2_common.c       |  2 +
 .../marvell/octeontx2/nic/otx2_common.h       | 11 ++++++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 37 +++++++++++++------
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  4 +-
 4 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 34e76cfd941b..e38b3eea11f3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -246,6 +246,7 @@ int otx2_hw_set_mtu(struct otx2_nic *pfvf, int mtu)
 	mutex_unlock(&pfvf->mbox.lock);
 	return err;
 }
+EXPORT_SYMBOL(otx2_hw_set_mtu);
 
 int otx2_config_pause_frm(struct otx2_nic *pfvf)
 {
@@ -1782,6 +1783,7 @@ void otx2_free_cints(struct otx2_nic *pfvf, int n)
 		free_irq(vector, &qset->napi[qidx]);
 	}
 }
+EXPORT_SYMBOL(otx2_free_cints);
 
 void otx2_set_cints_affinity(struct otx2_nic *pfvf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index b36b87dae2cb..327254e578d5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1000,6 +1000,17 @@ int otx2_aura_init(struct otx2_nic *pfvf, int aura_id,
 int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf);
 void otx2_free_queue_mem(struct otx2_qset *qset);
 int otx2_alloc_queue_mem(struct otx2_nic *pf);
+int otx2_init_hw_resources(struct otx2_nic *pfvf);
+void otx2_free_hw_resources(struct otx2_nic *pf);
+int otx2_wq_init(struct otx2_nic *pf);
+int otx2_check_pf_usable(struct otx2_nic *pf);
+int otx2_pfaf_mbox_init(struct otx2_nic *pf);
+int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af);
+int otx2_realloc_msix_vectors(struct otx2_nic *pf);
+void otx2_pfaf_mbox_destroy(struct otx2_nic *pf);
+void otx2_disable_mbox_intr(struct otx2_nic *pf);
+void otx2_disable_napi(struct otx2_nic *pf);
+irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq);
 
 /* RSS configuration APIs*/
 int otx2_rss_init(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 962583277f7b..dfe76571984e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1008,7 +1008,7 @@ static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 	return IRQ_HANDLED;
 }
 
-static void otx2_disable_mbox_intr(struct otx2_nic *pf)
+void otx2_disable_mbox_intr(struct otx2_nic *pf)
 {
 	int vector = pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_AFPF_MBOX);
 
@@ -1016,8 +1016,9 @@ static void otx2_disable_mbox_intr(struct otx2_nic *pf)
 	otx2_write64(pf, RVU_PF_INT_ENA_W1C, BIT_ULL(0));
 	free_irq(vector, pf);
 }
+EXPORT_SYMBOL(otx2_disable_mbox_intr);
 
-static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
+int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 {
 	struct otx2_hw *hw = &pf->hw;
 	struct msg_req *req;
@@ -1060,8 +1061,9 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 
 	return 0;
 }
+EXPORT_SYMBOL(otx2_register_mbox_intr);
 
-static void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
+void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
 {
 	struct mbox *mbox = &pf->mbox;
 
@@ -1076,8 +1078,9 @@ static void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
 	otx2_mbox_destroy(&mbox->mbox);
 	otx2_mbox_destroy(&mbox->mbox_up);
 }
+EXPORT_SYMBOL(otx2_pfaf_mbox_destroy);
 
-static int otx2_pfaf_mbox_init(struct otx2_nic *pf)
+int otx2_pfaf_mbox_init(struct otx2_nic *pf)
 {
 	struct mbox *mbox = &pf->mbox;
 	void __iomem *hwbase;
@@ -1124,6 +1127,7 @@ static int otx2_pfaf_mbox_init(struct otx2_nic *pf)
 	otx2_pfaf_mbox_destroy(pf);
 	return err;
 }
+EXPORT_SYMBOL(otx2_pfaf_mbox_init);
 
 static int otx2_cgx_config_linkevents(struct otx2_nic *pf, bool enable)
 {
@@ -1379,7 +1383,7 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
+irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
 {
 	struct otx2_cq_poll *cq_poll = (struct otx2_cq_poll *)cq_irq;
 	struct otx2_nic *pf = (struct otx2_nic *)cq_poll->dev;
@@ -1398,20 +1402,25 @@ static irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
 
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL(otx2_cq_intr_handler);
 
-static void otx2_disable_napi(struct otx2_nic *pf)
+void otx2_disable_napi(struct otx2_nic *pf)
 {
 	struct otx2_qset *qset = &pf->qset;
 	struct otx2_cq_poll *cq_poll;
+	struct work_struct *work;
 	int qidx;
 
 	for (qidx = 0; qidx < pf->hw.cint_cnt; qidx++) {
 		cq_poll = &qset->napi[qidx];
-		cancel_work_sync(&cq_poll->dim.work);
+		work = &cq_poll->dim.work;
+		if (work->func)
+			cancel_work_sync(work);
 		napi_disable(&cq_poll->napi);
 		netif_napi_del(&cq_poll->napi);
 	}
 }
+EXPORT_SYMBOL(otx2_disable_napi);
 
 static void otx2_free_cq_res(struct otx2_nic *pf)
 {
@@ -1477,7 +1486,7 @@ static int otx2_get_rbuf_size(struct otx2_nic *pf, int mtu)
 	return ALIGN(rbuf_size, 2048);
 }
 
-static int otx2_init_hw_resources(struct otx2_nic *pf)
+int otx2_init_hw_resources(struct otx2_nic *pf)
 {
 	struct nix_lf_free_req *free_req;
 	struct mbox *mbox = &pf->mbox;
@@ -1601,8 +1610,9 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	mutex_unlock(&mbox->lock);
 	return err;
 }
+EXPORT_SYMBOL(otx2_init_hw_resources);
 
-static void otx2_free_hw_resources(struct otx2_nic *pf)
+void otx2_free_hw_resources(struct otx2_nic *pf)
 {
 	struct otx2_qset *qset = &pf->qset;
 	struct nix_lf_free_req *free_req;
@@ -1688,6 +1698,7 @@ static void otx2_free_hw_resources(struct otx2_nic *pf)
 	}
 	mutex_unlock(&mbox->lock);
 }
+EXPORT_SYMBOL(otx2_free_hw_resources);
 
 static bool otx2_promisc_use_mce_list(struct otx2_nic *pfvf)
 {
@@ -2809,7 +2820,7 @@ static const struct net_device_ops otx2_netdev_ops = {
 	.ndo_set_vf_trust	= otx2_ndo_set_vf_trust,
 };
 
-static int otx2_wq_init(struct otx2_nic *pf)
+int otx2_wq_init(struct otx2_nic *pf)
 {
 	pf->otx2_wq = create_singlethread_workqueue("otx2_wq");
 	if (!pf->otx2_wq)
@@ -2820,7 +2831,7 @@ static int otx2_wq_init(struct otx2_nic *pf)
 	return 0;
 }
 
-static int otx2_check_pf_usable(struct otx2_nic *nic)
+int otx2_check_pf_usable(struct otx2_nic *nic)
 {
 	u64 rev;
 
@@ -2837,8 +2848,9 @@ static int otx2_check_pf_usable(struct otx2_nic *nic)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(otx2_check_pf_usable);
 
-static int otx2_realloc_msix_vectors(struct otx2_nic *pf)
+int otx2_realloc_msix_vectors(struct otx2_nic *pf)
 {
 	struct otx2_hw *hw = &pf->hw;
 	int num_vec, err;
@@ -2860,6 +2872,7 @@ static int otx2_realloc_msix_vectors(struct otx2_nic *pf)
 
 	return otx2_register_mbox_intr(pf, false);
 }
+EXPORT_SYMBOL(otx2_realloc_msix_vectors);
 
 static int otx2_sriov_vfcfg_init(struct otx2_nic *pf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 79a8acac6283..c4e6c78a8deb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -500,7 +500,7 @@ static const struct net_device_ops otx2vf_netdev_ops = {
 	.ndo_setup_tc = otx2_setup_tc,
 };
 
-static int otx2_wq_init(struct otx2_nic *vf)
+static int otx2_vf_wq_init(struct otx2_nic *vf)
 {
 	vf->otx2_wq = create_singlethread_workqueue("otx2vf_wq");
 	if (!vf->otx2_wq)
@@ -689,7 +689,7 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_ptp_destroy;
 	}
 
-	err = otx2_wq_init(vf);
+	err = otx2_vf_wq_init(vf);
 	if (err)
 		goto err_unreg_netdev;
 
-- 
2.25.1


