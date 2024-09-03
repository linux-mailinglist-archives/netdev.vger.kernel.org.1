Return-Path: <netdev+bounces-124531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AA7969DEC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159701F2434E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57DE201252;
	Tue,  3 Sep 2024 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Bb9lM40k"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029B41DA10D;
	Tue,  3 Sep 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367280; cv=none; b=SNWr7W6Lk8O0JlsnmjJYpf8qtUAKDMCW4fdYqBCjscjfoefnZHRLWcFxT14ecITr+wt2yHCvP1fLq2HhOlo88rLTVCFHDxMR8AHoLmvEvIV8GaG145ioQqCJ7Xwx+1u3wBVAcE18WWwM040j2wcAGbo9ErGFcLe8ZqqY9zGTN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367280; c=relaxed/simple;
	bh=/zbrHTDuE8i44HtzOkKfupk1xEJVwMghBMUXj9CE1u0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXnemxswXkjQV/B6zXrHjuuiNpv12nfh3EbKcfrrBrn+rGKriUMg4l6lQ/QKV1nprwk9ipNYyxnUdrMQlry3EwNjxJqo694+ngD2xEiOk6sOyggjWKF72K1RQvAQycY0gb9QYm32O6tM955S2uqZndpgDy2z0qI8chFrKEibvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Bb9lM40k; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48329TOd016347;
	Tue, 3 Sep 2024 05:41:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=EP9OJKbEd8AFPuI3BqF0SJ4Ty
	1z1Nud2IqC1Sicmpvk=; b=Bb9lM40k+dif1K4GUPyhJjKHsaCn8yEmKTF11DCEy
	Mixy8UOdfgQ0nFOHKxH24bTja3tENhbZcuhKm1eb6+AkWXwOVGkcA4hjZRdIXHs+
	PeJYKIFsZw6iUOAoQxt+dOkcJNSCd5DzsjoZ3ChfcboA7AdEj9/LhTlAZGcuTReq
	16bkAw7MAwGmRmJXa++B27bbMcMnM1Lek4qP16FYs7LIj5i42WKJpYHNujaRbh6g
	TS9JIqNqlQz28uY6iCt+ykraWnYjecmgRd8Wnhb1T7vmKVRTvnPQ62+994QPDggx
	+4a8+FBOxZWt7FBw04zL+aHlYe4+gOTG6TA9oNu/bxrTQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41dbv1ukc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 05:41:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Sep 2024 05:41:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Sep 2024 05:41:09 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 9CFEA3F70E6;
	Tue,  3 Sep 2024 05:41:05 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH 4/4] octeontx2-pf: Export common APIs
Date: Tue, 3 Sep 2024 18:10:48 +0530
Message-ID: <20240903124048.14235-5-gakula@marvell.com>
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
X-Proofpoint-GUID: h01DmNfNUjmWLZy80r9x6l7XpioOsOFp
X-Proofpoint-ORIG-GUID: h01DmNfNUjmWLZy80r9x6l7XpioOsOFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01

Export mbox, hw resources and interrupt configuration functions.
So, that they can be used later by the RVU representor driver.
  
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../marvell/octeontx2/nic/otx2_common.c       |  2 +
 .../marvell/octeontx2/nic/otx2_common.h       | 11 +++++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 40 +++++++++++++------
 .../marvell/octeontx2/nic/otx2_txrx.c         | 17 +++++---
 .../marvell/octeontx2/nic/otx2_txrx.h         |  3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  6 +--
 6 files changed, 56 insertions(+), 23 deletions(-)

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
index 5bb6db5a3a73..b4fa2c12721d 100644
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
@@ -1781,6 +1792,7 @@ void otx2_free_queue_mem(struct otx2_qset *qset)
 	kfree(qset->napi);
 }
 EXPORT_SYMBOL(otx2_free_queue_mem);
+
 int otx2_alloc_queue_mem(struct otx2_nic *pf)
 {
 	struct otx2_qset *qset = &pf->qset;
@@ -2103,7 +2115,7 @@ static netdev_tx_t otx2_xmit(struct sk_buff *skb, struct net_device *netdev)
 	sq = &pf->qset.sq[sq_idx];
 	txq = netdev_get_tx_queue(netdev, qidx);
 
-	if (!otx2_sq_append_skb(netdev, sq, skb, qidx)) {
+	if (!otx2_sq_append_skb(pf, txq, sq, skb, qidx)) {
 		netif_tx_stop_queue(txq);
 
 		/* Check again, incase SQBs got freed up */
@@ -2808,7 +2820,7 @@ static const struct net_device_ops otx2_netdev_ops = {
 	.ndo_set_vf_trust	= otx2_ndo_set_vf_trust,
 };
 
-static int otx2_wq_init(struct otx2_nic *pf)
+int otx2_wq_init(struct otx2_nic *pf)
 {
 	pf->otx2_wq = create_singlethread_workqueue("otx2_wq");
 	if (!pf->otx2_wq)
@@ -2819,7 +2831,7 @@ static int otx2_wq_init(struct otx2_nic *pf)
 	return 0;
 }
 
-static int otx2_check_pf_usable(struct otx2_nic *nic)
+int otx2_check_pf_usable(struct otx2_nic *nic)
 {
 	u64 rev;
 
@@ -2836,8 +2848,9 @@ static int otx2_check_pf_usable(struct otx2_nic *nic)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(otx2_check_pf_usable);
 
-static int otx2_realloc_msix_vectors(struct otx2_nic *pf)
+int otx2_realloc_msix_vectors(struct otx2_nic *pf)
 {
 	struct otx2_hw *hw = &pf->hw;
 	int num_vec, err;
@@ -2859,6 +2872,7 @@ static int otx2_realloc_msix_vectors(struct otx2_nic *pf)
 
 	return otx2_register_mbox_intr(pf, false);
 }
+EXPORT_SYMBOL(otx2_realloc_msix_vectors);
 
 static int otx2_sriov_vfcfg_init(struct otx2_nic *pf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 3eb85949677a..fbd9fe98259f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -131,6 +131,7 @@ static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
 }
 
 static void otx2_snd_pkt_handler(struct otx2_nic *pfvf,
+				 struct net_device *ndev,
 				 struct otx2_cq_queue *cq,
 				 struct otx2_snd_queue *sq,
 				 struct nix_cqe_tx_s *cqe,
@@ -145,7 +146,7 @@ static void otx2_snd_pkt_handler(struct otx2_nic *pfvf,
 
 	if (unlikely(snd_comp->status) && netif_msg_tx_err(pfvf))
 		net_err_ratelimited("%s: TX%d: Error in send CQ status:%x\n",
-				    pfvf->netdev->name, cq->cint_idx,
+				    ndev->name, cq->cint_idx,
 				    snd_comp->status);
 
 	sg = &sq->sg[snd_comp->sqe_id];
@@ -453,6 +454,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 	int tx_pkts = 0, tx_bytes = 0, qidx;
 	struct otx2_snd_queue *sq;
 	struct nix_cqe_tx_s *cqe;
+	struct net_device *ndev;
 	int processed_cqe = 0;
 
 	if (cq->pend_cqe >= budget)
@@ -464,6 +466,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 process_cqe:
 	qidx = cq->cq_idx - pfvf->hw.rx_queues;
 	sq = &pfvf->qset.sq[qidx];
+	ndev = pfvf->netdev;
 
 	while (likely(processed_cqe < budget) && cq->pend_cqe) {
 		cqe = (struct nix_cqe_tx_s *)otx2_get_next_cqe(cq);
@@ -478,7 +481,8 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 		if (cq->cq_type == CQ_XDP)
 			otx2_xdp_snd_pkt_handler(pfvf, sq, cqe);
 		else
-			otx2_snd_pkt_handler(pfvf, cq, &pfvf->qset.sq[qidx],
+			otx2_snd_pkt_handler(pfvf, ndev, cq,
+					     &pfvf->qset.sq[qidx],
 					     cqe, budget, &tx_pkts, &tx_bytes);
 
 		cqe->hdr.cqe_type = NIX_XQE_TYPE_INVALID;
@@ -505,7 +509,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 		/* Check if queue was stopped earlier due to ring full */
 		smp_mb();
 		if (netif_tx_queue_stopped(txq) &&
-		    netif_carrier_ok(pfvf->netdev))
+		    netif_carrier_ok(ndev))
 			netif_tx_wake_queue(txq);
 	}
 	return 0;
@@ -594,6 +598,7 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 	}
 	return workdone;
 }
+EXPORT_SYMBOL(otx2_napi_handler);
 
 void otx2_sqe_flush(void *dev, struct otx2_snd_queue *sq,
 		    int size, int qidx)
@@ -1141,13 +1146,13 @@ static void otx2_set_txtstamp(struct otx2_nic *pfvf, struct sk_buff *skb,
 	}
 }
 
-bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
+bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
+			struct otx2_snd_queue *sq,
 			struct sk_buff *skb, u16 qidx)
 {
-	struct netdev_queue *txq = netdev_get_tx_queue(netdev, qidx);
-	struct otx2_nic *pfvf = netdev_priv(netdev);
 	int offset, num_segs, free_desc;
 	struct nix_sqe_hdr_s *sqe_hdr;
+	struct otx2_nic *pfvf = dev;
 
 	/* Check if there is enough room between producer
 	 * and consumer index.
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index 3f1d2655ff77..e1db5f961877 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -167,7 +167,8 @@ static inline u64 otx2_iova_to_phys(void *iommu_domain, dma_addr_t dma_addr)
 }
 
 int otx2_napi_handler(struct napi_struct *napi, int budget);
-bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
+bool otx2_sq_append_skb(void *dev, struct netdev_queue *txq,
+			struct otx2_snd_queue *sq,
 			struct sk_buff *skb, u16 qidx);
 void cn10k_sqe_flush(void *dev, struct otx2_snd_queue *sq,
 		     int size, int qidx);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 79a8acac6283..0486fca8b573 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -395,7 +395,7 @@ static netdev_tx_t otx2vf_xmit(struct sk_buff *skb, struct net_device *netdev)
 	sq = &vf->qset.sq[qidx];
 	txq = netdev_get_tx_queue(netdev, qidx);
 
-	if (!otx2_sq_append_skb(netdev, sq, skb, qidx)) {
+	if (!otx2_sq_append_skb(vf, txq, sq, skb, qidx)) {
 		netif_tx_stop_queue(txq);
 
 		/* Check again, incase SQBs got freed up */
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


