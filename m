Return-Path: <netdev+bounces-142903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E140A9C0ADF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F88284CEF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED482170CC;
	Thu,  7 Nov 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PrHlmHLF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638432170BD;
	Thu,  7 Nov 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995746; cv=none; b=lQjJO9THs2HjS9Sk5AKKqbg9DxylaHz8bYhQkAUL3OUEwBtpG2dwuqrvVjneI0kfLp8jnwomY4n0OFclZH+qtZGx8G4MqXVFYbG4gNZePgX4iKSKlOhhK2IGDfyDIYtYF74rposHT4STotdluGen9eOl0dYWicjBC/uYNJ0FJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995746; c=relaxed/simple;
	bh=E7aKA2/6FDh7Ei8qHsBcXi/Uocy8DlAqZa9kL4F4W8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfLfuRJlDL0BY6uGoys2o36LJDYF6XP8EWMvOt96uAvXceBDJhUnWRoHQCI4ztk8XaOuAxKE+6t9Zot+5QXaewjY4DZaHmfLh+cinj0P3j9A6ZLv+w+28ff6GeR8hRYndJsaEt9yJ5CSBMyeGpz12+TXEyUUpZMC9xhm0YAZ5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PrHlmHLF; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Ca4Bf018109;
	Thu, 7 Nov 2024 08:08:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=HYVxpZqSOP58kN8qN0COVM+ko
	/Mhwgb7ErsxijVRlig=; b=PrHlmHLFduDbyKDpCEiK+8CaS96q40H0gzSOFGlUQ
	vtDeFEInPRGTpE4k0tigK5qL8R2S7h7kiklXMzGJOqgKFZQIjJ+dXs0M9D/SazJS
	Tr8Epc2qcqmn790AiMtzycOsLop1RgFNg89TzbOpZXXky79sHSh2oJSZJKDFnafS
	Gvn+wagW5y9C11L5UgoDfq1x2P0RJl4rxsZJYbGtasKGuV0+iTTHi0/F78y+P8yL
	79R/2zB0POudycjKqu04oLhHUXL+XLpcK2mTRGpb0NdtLcbSlXZMC6Jsv3ynvvvt
	FpeVQ3ulHzu/z33WpnBTPDeidjRNOameraMPqBTbFd7eA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42rwpngh3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:08:58 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 08:08:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 08:08:56 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id E20343F7050;
	Thu,  7 Nov 2024 08:08:52 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v12 03/12] octeontx2-pf: Add basic net_device_ops
Date: Thu, 7 Nov 2024 21:38:30 +0530
Message-ID: <20241107160839.23707-4-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241107160839.23707-1-gakula@marvell.com>
References: <20241107160839.23707-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: NCImYnXRvAYHVdt-l75o9SYaBvILWWI4
X-Proofpoint-ORIG-GUID: NCImYnXRvAYHVdt-l75o9SYaBvILWWI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Implements basic set of net_device_ops.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  2 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         | 28 +++++++----
 .../marvell/octeontx2/nic/otx2_txrx.h         |  3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  2 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 46 +++++++++++++++++++
 5 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c35327a10bc9..41480e23ae4d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2116,7 +2116,7 @@ static netdev_tx_t otx2_xmit(struct sk_buff *skb, struct net_device *netdev)
 	sq = &pf->qset.sq[sq_idx];
 	txq = netdev_get_tx_queue(netdev, qidx);
 
-	if (!otx2_sq_append_skb(netdev, sq, skb, qidx)) {
+	if (!otx2_sq_append_skb(pf, txq, sq, skb, qidx)) {
 		netif_tx_stop_queue(txq);
 
 		/* Check again, incase SQBs got freed up */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 9b4e4c5b1468..04bc06a80e23 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -376,9 +376,11 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 	}
 	otx2_set_rxhash(pfvf, cqe, skb);
 
-	skb_record_rx_queue(skb, cq->cq_idx);
-	if (pfvf->netdev->features & NETIF_F_RXCSUM)
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	if (!(pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)) {
+		skb_record_rx_queue(skb, cq->cq_idx);
+		if (pfvf->netdev->features & NETIF_F_RXCSUM)
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
 
 	if (pfvf->flags & OTX2_FLAG_TC_MARK_ENABLED)
 		skb->mark = parse->match_id;
@@ -453,6 +455,7 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 	int tx_pkts = 0, tx_bytes = 0, qidx;
 	struct otx2_snd_queue *sq;
 	struct nix_cqe_tx_s *cqe;
+	struct net_device *ndev;
 	int processed_cqe = 0;
 
 	if (cq->pend_cqe >= budget)
@@ -493,6 +496,13 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 	otx2_write64(pfvf, NIX_LF_CQ_OP_DOOR,
 		     ((u64)cq->cq_idx << 32) | processed_cqe);
 
+#if IS_ENABLED(CONFIG_RVU_ESWITCH)
+	if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
+		ndev = pfvf->reps[qidx]->netdev;
+	else
+#endif
+		ndev = pfvf->netdev;
+
 	if (likely(tx_pkts)) {
 		struct netdev_queue *txq;
 
@@ -500,12 +510,14 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
 
 		if (qidx >= pfvf->hw.tx_queues)
 			qidx -= pfvf->hw.xdp_queues;
-		txq = netdev_get_tx_queue(pfvf->netdev, qidx);
+		if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
+			qidx = 0;
+		txq = netdev_get_tx_queue(ndev, qidx);
 		netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);
 		/* Check if queue was stopped earlier due to ring full */
 		smp_mb();
 		if (netif_tx_queue_stopped(txq) &&
-		    netif_carrier_ok(pfvf->netdev))
+		    netif_carrier_ok(ndev))
 			netif_tx_wake_queue(txq);
 	}
 	return 0;
@@ -1142,13 +1154,13 @@ static void otx2_set_txtstamp(struct otx2_nic *pfvf, struct sk_buff *skb,
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
index c4e6c78a8deb..0486fca8b573 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -395,7 +395,7 @@ static netdev_tx_t otx2vf_xmit(struct sk_buff *skb, struct net_device *netdev)
 	sq = &vf->qset.sq[qidx];
 	txq = netdev_get_tx_queue(netdev, qidx);
 
-	if (!otx2_sq_append_skb(netdev, sq, skb, qidx)) {
+	if (!otx2_sq_append_skb(vf, txq, sq, skb, qidx)) {
 		netif_tx_stop_queue(txq);
 
 		/* Check again, incase SQBs got freed up */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index fda01a485b61..d32f685bb25e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,51 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static netdev_tx_t rvu_rep_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct rep_dev *rep = netdev_priv(dev);
+	struct otx2_nic *pf = rep->mdev;
+	struct otx2_snd_queue *sq;
+	struct netdev_queue *txq;
+
+	sq = &pf->qset.sq[rep->rep_id];
+	txq = netdev_get_tx_queue(dev, 0);
+
+	if (!otx2_sq_append_skb(pf, txq, sq, skb, rep->rep_id)) {
+		netif_tx_stop_queue(txq);
+
+		/* Check again, in case SQBs got freed up */
+		smp_mb();
+		if (((sq->num_sqbs - *sq->aura_fc_addr) * sq->sqe_per_sqb)
+							> sq->sqe_thresh)
+			netif_tx_wake_queue(txq);
+
+		return NETDEV_TX_BUSY;
+	}
+	return NETDEV_TX_OK;
+}
+
+static int rvu_rep_open(struct net_device *dev)
+{
+	netif_carrier_on(dev);
+	netif_tx_start_all_queues(dev);
+	return 0;
+}
+
+static int rvu_rep_stop(struct net_device *dev)
+{
+	netif_carrier_off(dev);
+	netif_tx_disable(dev);
+
+	return 0;
+}
+
+static const struct net_device_ops rvu_rep_netdev_ops = {
+	.ndo_open		= rvu_rep_open,
+	.ndo_stop		= rvu_rep_stop,
+	.ndo_start_xmit		= rvu_rep_xmit,
+};
+
 static int rvu_rep_napi_init(struct otx2_nic *priv,
 			     struct netlink_ext_ack *extack)
 {
@@ -208,6 +253,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 
 		ndev->min_mtu = OTX2_MIN_MTU;
 		ndev->max_mtu = priv->hw.max_mtu;
+		ndev->netdev_ops = &rvu_rep_netdev_ops;
 		pcifunc = priv->rep_pf_map[rep_id];
 		rep->pcifunc = pcifunc;
 
-- 
2.25.1


