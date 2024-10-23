Return-Path: <netdev+bounces-138353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C39ACFF8
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F23E1F2175C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA951CEAB5;
	Wed, 23 Oct 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="R+W7u9xn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C481CEE8A;
	Wed, 23 Oct 2024 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700355; cv=none; b=J1TeycVXduKGA69/z3HrgXR3Q10YKp3jmOrJRUe2entMWcjyC/zots5ZWGVAcSjQUYN7nRNTdOAecjMkY6mxcFK4/ultu+DHdcc8Nyrbm0fNCW8pGkjoFngyy8Eyo/YTsdrKs1GjH+PZ06nnQ511bY8HnDySCRCyJAmrmHuomvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700355; c=relaxed/simple;
	bh=nGdhF1VNxg8i5ICJib+7JqwOTqOlw2gFv+79xMWe5EE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESx+nL2CVc8JvGPJQF4vrZdmXjOOM91n0oKjlW3iQSfrxaEi5wE0evtOyQk5LNdFOA0yLbj1YZ0HRppX2nd8HOYPGz74LM0Vpbr7JAEm4a3xoYEAKL6mE2i9JFFtD2CsZAj848FmfzkRq24HCdNUenvYH+M5i4ES0/VbvfFsYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=R+W7u9xn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBX5p0022336;
	Wed, 23 Oct 2024 09:19:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=O+2YXMRSVWGaJIdB3RkcmL6K6
	UrrZ+DrmrSE9+DJ8YM=; b=R+W7u9xnAHUzsLggWvypiD+eUgc3Ues+1vNxfy2sK
	lYNcpbKB+0vE6+kCGWkXPXoq/sM6YwsBCFgRkKCvT8WLOMLfKrlZsN5i4yQGCn3h
	F5YSf8ScVzL7C0v69ES0PfoDnDZMeS5K1ciqLmDKwuam+g4LiJxSFAR6SajY0RuY
	mGTeaGBfV0x3jXEqibceesMi0vD1yk3zoL+tOXa0iqurKBjQK77loTEj39Zvcyvg
	Q8dLYFj5b2kN0FtB7MqoidPpJU+nz0RyUW1836VEa1dmhdG0+szhYlbXVUYF9iZE
	ncCKBII7EzZuetbCjjF3zChHSKaRZRp3wafeKFNInslnA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42em2c2bku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 09:19:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 23 Oct 2024 09:19:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 23 Oct 2024 09:19:04 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id B910C3F706B;
	Wed, 23 Oct 2024 09:19:00 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v4 4/4] octeontx2-pf: Move shared APIs to header file
Date: Wed, 23 Oct 2024 21:48:43 +0530
Message-ID: <20241023161843.15543-5-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241023161843.15543-1-gakula@marvell.com>
References: <20241023161843.15543-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: LnoT46BWqbZRJWhK3r-Wg03aXrAHXoxw
X-Proofpoint-ORIG-GUID: LnoT46BWqbZRJWhK3r-Wg03aXrAHXoxw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Move mbox, hw resources and interrupt configuration functions to common
header file. So, that they can be used later by the RVU representor driver.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.h       | 11 ++++++++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 27 ++++++++++---------
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  4 +--
 3 files changed, 28 insertions(+), 14 deletions(-)

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
index 15ed1305fbf8..e6b03bad2dba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1008,7 +1008,7 @@ static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 	return IRQ_HANDLED;
 }
 
-static void otx2_disable_mbox_intr(struct otx2_nic *pf)
+void otx2_disable_mbox_intr(struct otx2_nic *pf)
 {
 	int vector = pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_AFPF_MBOX);
 
@@ -1017,7 +1017,7 @@ static void otx2_disable_mbox_intr(struct otx2_nic *pf)
 	free_irq(vector, pf);
 }
 
-static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
+int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 {
 	struct otx2_hw *hw = &pf->hw;
 	struct msg_req *req;
@@ -1061,7 +1061,7 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 	return 0;
 }
 
-static void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
+void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
 {
 	struct mbox *mbox = &pf->mbox;
 
@@ -1077,7 +1077,7 @@ static void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
 	otx2_mbox_destroy(&mbox->mbox_up);
 }
 
-static int otx2_pfaf_mbox_init(struct otx2_nic *pf)
+int otx2_pfaf_mbox_init(struct otx2_nic *pf)
 {
 	struct mbox *mbox = &pf->mbox;
 	void __iomem *hwbase;
@@ -1379,7 +1379,7 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
+irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
 {
 	struct otx2_cq_poll *cq_poll = (struct otx2_cq_poll *)cq_irq;
 	struct otx2_nic *pf = (struct otx2_nic *)cq_poll->dev;
@@ -1399,15 +1399,18 @@ static irqreturn_t otx2_cq_intr_handler(int irq, void *cq_irq)
 	return IRQ_HANDLED;
 }
 
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
@@ -1477,7 +1480,7 @@ static int otx2_get_rbuf_size(struct otx2_nic *pf, int mtu)
 	return ALIGN(rbuf_size, 2048);
 }
 
-static int otx2_init_hw_resources(struct otx2_nic *pf)
+int otx2_init_hw_resources(struct otx2_nic *pf)
 {
 	struct nix_lf_free_req *free_req;
 	struct mbox *mbox = &pf->mbox;
@@ -1602,7 +1605,7 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	return err;
 }
 
-static void otx2_free_hw_resources(struct otx2_nic *pf)
+void otx2_free_hw_resources(struct otx2_nic *pf)
 {
 	struct otx2_qset *qset = &pf->qset;
 	struct nix_lf_free_req *free_req;
@@ -2807,7 +2810,7 @@ static const struct net_device_ops otx2_netdev_ops = {
 	.ndo_set_vf_trust	= otx2_ndo_set_vf_trust,
 };
 
-static int otx2_wq_init(struct otx2_nic *pf)
+int otx2_wq_init(struct otx2_nic *pf)
 {
 	pf->otx2_wq = create_singlethread_workqueue("otx2_wq");
 	if (!pf->otx2_wq)
@@ -2818,7 +2821,7 @@ static int otx2_wq_init(struct otx2_nic *pf)
 	return 0;
 }
 
-static int otx2_check_pf_usable(struct otx2_nic *nic)
+int otx2_check_pf_usable(struct otx2_nic *nic)
 {
 	u64 rev;
 
@@ -2836,7 +2839,7 @@ static int otx2_check_pf_usable(struct otx2_nic *nic)
 	return 0;
 }
 
-static int otx2_realloc_msix_vectors(struct otx2_nic *pf)
+int otx2_realloc_msix_vectors(struct otx2_nic *pf)
 {
 	struct otx2_hw *hw = &pf->hw;
 	int num_vec, err;
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


