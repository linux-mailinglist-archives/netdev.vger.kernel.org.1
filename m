Return-Path: <netdev+bounces-142908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981E69C0AF1
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84301C232A3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83721643F;
	Thu,  7 Nov 2024 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Reyu24J+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE714217668;
	Thu,  7 Nov 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995769; cv=none; b=n9PFJJhV1OkT3g+E4XIpOJd9mWFsMiOOXydfJ9MJtu00ZH12de06EEwGO7VfRzwD48Im+HYo+agWFRXL7zQp9cblskjMDK+kBghQFCAm8tfvOQa7+XS8irgKKK9UkLsoeXQ2vfT89LMDaHzP4KVMEc++nhlur8XbzB3PypgrWF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995769; c=relaxed/simple;
	bh=uA7hqbBBRLbKjaHT7wR0Dc+/0sYdnXeMhSGWh1Us9Qo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sD61VyGDl4CNfEP6I06wrffoLTZSzuRAr1oX3jVuFGOsTgPQO0rhIeUYFkx9r5DvsLNu64UEeblFMmA8oZY1885Br92NdillnEwQV2hszZQxV9CI4GWAmjBMRDMOqyeWY3MZavPqGdDlrsEBVwZGehF03OhYpUBbYO60IBF1frw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Reyu24J+; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7B7Ye2012527;
	Thu, 7 Nov 2024 08:09:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=2HZeH74bJaiTQinvl5GbBjbAI
	eBgEfxR2ivFT1TNJs4=; b=Reyu24J+0B3dLn7tSjNR1kgo1rgGZms1+JoUGwYrE
	XRYO27R8tq4+K4vuhumVUQgFoYGApYlV4+lCoUxZwJwg14bdyJlHph5ipIe0G48Q
	bbXl/oldWY64hPxGMa2jxlllSJyRij8CP54gMRbNvgxBZO+N5vU+U29AtfC1AgaH
	Sb+QnI2rxOI621BlMMXNdhqwDHAp3YPreoYU84wQKa3MenedX+UOLrpi+Acdjo2J
	zOcijeKpQdHxLwwErzcTJW+W5odLlddUFVmQAzGVxgv2UmJ3A4PZU2A/scM1KwCb
	J54MVpCE90tUK2gWoZvHP6P3NhsGOyERB4PSe8kCLGF/Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42rvcw0pf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 08:09:17 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 08:09:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 08:09:16 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id BC9FC3F7050;
	Thu,  7 Nov 2024 08:09:12 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <jiri@resnulli.us>, <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v12 08/12] octeontx2-pf: Add representors for sdp MAC
Date: Thu, 7 Nov 2024 21:38:35 +0530
Message-ID: <20241107160839.23707-9-gakula@marvell.com>
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
X-Proofpoint-ORIG-GUID: ghPfrc2_UIc3tsY4exOPaRRT-n2B7gHR
X-Proofpoint-GUID: ghPfrc2_UIc3tsY4exOPaRRT-n2B7gHR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Hardware supports different types of MACs eg RPM, SDP, LBK.
LBK is for internal Tx->Rx HW loopback path. RPM and SDP MACs support
ingress/egress pkt IO on interfaces with different set of capabilities
like interface modes. At the time of netdev driver registration PF will
seek MAC related information from Admin function driver
'drivers/net/ethernet/marvell/octeontx2/af' and sets up ingress/egress
queues etc such that pkt IO on the channels of these different MACs is
possible. This patch add representors for SDP MAC.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../ethernet/marvell/octeontx2/af/common.h    |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  5 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  4 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |  2 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 50 +++++++++++++++----
 .../marvell/octeontx2/nic/otx2_common.h       | 27 +++++++---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 13 +++--
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  | 12 ++++-
 8 files changed, 88 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 2436c1ff9ba4..5d84386ed22d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -156,6 +156,7 @@ enum nix_scheduler {
 #define	NIC_HW_MIN_FRS			40
 #define	NIC_HW_MAX_FRS			9212
 #define	SDP_HW_MAX_FRS			65535
+#define	SDP_HW_MIN_FRS			16
 #define CN10K_LMAC_LINK_MAX_FRS		16380 /* 16k - FCS */
 #define CN10K_LBK_LINK_MAX_FRS		65535 /* 64k */
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 26cf42adf109..5d5a01dbbca1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -586,6 +586,9 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 	if (!is_pf_cgxmapped(rvu, pf) && type != NIX_INTF_TYPE_LBK)
 		return 0;
 
+	if (is_sdp_pfvf(pcifunc))
+		type = NIX_INTF_TYPE_SDP;
+
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
 	if (err)
@@ -4687,7 +4690,7 @@ static void nix_link_config(struct rvu *rvu, int blkaddr,
 	if (hw->sdp_links) {
 		link = hw->cgx_links + hw->lbk_links;
 		rvu_write64(rvu, blkaddr, NIX_AF_RX_LINKX_CFG(link),
-			    SDP_HW_MAX_FRS << 16 | NIC_HW_MIN_FRS);
+			    SDP_HW_MAX_FRS << 16 | SDP_HW_MIN_FRS);
 	}
 
 	/* Get MCS external bypass status for CN10K-B */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index 7417087b6db5..a15cc86635d6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -72,7 +72,7 @@ int cn10k_lmtst_init(struct otx2_nic *pfvf)
 }
 EXPORT_SYMBOL(cn10k_lmtst_init);
 
-int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura)
+int cn10k_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura)
 {
 	struct nix_cn10k_aq_enq_req *aq;
 	struct otx2_nic *pfvf = dev;
@@ -88,7 +88,7 @@ int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura)
 	aq->sq.ena = 1;
 	aq->sq.smq = otx2_get_smq_idx(pfvf, qidx);
 	aq->sq.smq_rr_weight = mtu_to_dwrr_weight(pfvf, pfvf->tx_max_pktlen);
-	aq->sq.default_chan = pfvf->hw.tx_chan_base;
+	aq->sq.default_chan = pfvf->hw.tx_chan_base + chan_offset;
 	aq->sq.sqe_stype = NIX_STYPE_STF; /* Cache SQB */
 	aq->sq.sqb_aura = sqb_aura;
 	aq->sq.sq_int_ena = NIX_SQINT_BITS;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
index c1861f7de254..e3f0bce9908f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
@@ -26,7 +26,7 @@ static inline int mtu_to_dwrr_weight(struct otx2_nic *pfvf, int mtu)
 
 int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
 void cn10k_sqe_flush(void *dev, struct otx2_snd_queue *sq, int size, int qidx);
-int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura);
+int cn10k_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura);
 int cn10k_lmtst_init(struct otx2_nic *pfvf);
 int cn10k_free_all_ipolicers(struct otx2_nic *pfvf);
 int cn10k_alloc_matchall_ipolicer(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 8b6e60dde684..46a448030e64 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -253,7 +253,7 @@ int otx2_config_pause_frm(struct otx2_nic *pfvf)
 	struct cgx_pause_frm_cfg *req;
 	int err;
 
-	if (is_otx2_lbkvf(pfvf->pdev))
+	if (is_otx2_lbkvf(pfvf->pdev) || is_otx2_sdp_rep(pfvf->pdev))
 		return 0;
 
 	mutex_lock(&pfvf->mbox.lock);
@@ -647,12 +647,22 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 		req->reg[2] = NIX_AF_MDQX_SCHEDULE(schq);
 		req->regval[2] =  dwrr_val;
 	} else if (lvl == NIX_TXSCH_LVL_TL4) {
+		int sdp_chan =  hw->tx_chan_base + prio;
+
+		if (is_otx2_sdp_rep(pfvf->pdev))
+			prio = 0;
 		parent = schq_list[NIX_TXSCH_LVL_TL3][prio];
 		req->reg[0] = NIX_AF_TL4X_PARENT(schq);
 		req->regval[0] = (u64)parent << 16;
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL4X_SCHEDULE(schq);
 		req->regval[1] = dwrr_val;
+		if (is_otx2_sdp_rep(pfvf->pdev)) {
+			req->num_regs++;
+			req->reg[2] = NIX_AF_TL4X_SDP_LINK_CFG(schq);
+			req->regval[2] = BIT_ULL(12) | BIT_ULL(13) |
+					 (sdp_chan & 0xff);
+		}
 	} else if (lvl == NIX_TXSCH_LVL_TL3) {
 		parent = schq_list[NIX_TXSCH_LVL_TL2][prio];
 		req->reg[0] = NIX_AF_TL3X_PARENT(schq);
@@ -660,7 +670,8 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL3X_SCHEDULE(schq);
 		req->regval[1] = dwrr_val;
-		if (lvl == hw->txschq_link_cfg_lvl) {
+		if (lvl == hw->txschq_link_cfg_lvl &&
+		    !is_otx2_sdp_rep(pfvf->pdev)) {
 			req->num_regs++;
 			req->reg[2] = NIX_AF_TL3_TL2X_LINKX_CFG(schq, hw->tx_link);
 			/* Enable this queue and backpressure
@@ -677,7 +688,8 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 		req->reg[1] = NIX_AF_TL2X_SCHEDULE(schq);
 		req->regval[1] = (u64)hw->txschq_aggr_lvl_rr_prio << 24 | dwrr_val;
 
-		if (lvl == hw->txschq_link_cfg_lvl) {
+		if (lvl == hw->txschq_link_cfg_lvl &&
+		    !is_otx2_sdp_rep(pfvf->pdev)) {
 			req->num_regs++;
 			req->reg[2] = NIX_AF_TL3_TL2X_LINKX_CFG(schq, hw->tx_link);
 			/* Enable this queue and backpressure
@@ -736,6 +748,7 @@ EXPORT_SYMBOL(otx2_smq_flush);
 
 int otx2_txsch_alloc(struct otx2_nic *pfvf)
 {
+	int chan_cnt = pfvf->hw.tx_chan_cnt;
 	struct nix_txsch_alloc_req *req;
 	struct nix_txsch_alloc_rsp *rsp;
 	int lvl, schq, rc;
@@ -748,6 +761,12 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
 	/* Request one schq per level */
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++)
 		req->schq[lvl] = 1;
+
+	if (is_otx2_sdp_rep(pfvf->pdev) && chan_cnt > 1) {
+		req->schq[NIX_TXSCH_LVL_SMQ] = chan_cnt;
+		req->schq[NIX_TXSCH_LVL_TL4] = chan_cnt;
+	}
+
 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
 	if (rc)
 		return rc;
@@ -758,10 +777,12 @@ int otx2_txsch_alloc(struct otx2_nic *pfvf)
 		return PTR_ERR(rsp);
 
 	/* Setup transmit scheduler list */
-	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++)
+	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
+		pfvf->hw.txschq_cnt[lvl] = rsp->schq[lvl];
 		for (schq = 0; schq < rsp->schq[lvl]; schq++)
 			pfvf->hw.txschq_list[lvl][schq] =
 				rsp->schq_list[lvl][schq];
+	}
 
 	pfvf->hw.txschq_link_cfg_lvl = rsp->link_cfg_lvl;
 	pfvf->hw.txschq_aggr_lvl_rr_prio = rsp->aggr_lvl_rr_prio;
@@ -799,12 +820,15 @@ EXPORT_SYMBOL(otx2_txschq_free_one);
 
 void otx2_txschq_stop(struct otx2_nic *pfvf)
 {
-	int lvl, schq;
+	int lvl, schq, idx;
 
 	/* free non QOS TLx nodes */
-	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++)
-		otx2_txschq_free_one(pfvf, lvl,
-				     pfvf->hw.txschq_list[lvl][0]);
+	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
+		for (idx = 0; idx < pfvf->hw.txschq_cnt[lvl]; idx++) {
+			otx2_txschq_free_one(pfvf, lvl,
+					     pfvf->hw.txschq_list[lvl][idx]);
+		}
+	}
 
 	/* Clear the txschq list */
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
@@ -884,7 +908,7 @@ static int otx2_rq_init(struct otx2_nic *pfvf, u16 qidx, u16 lpb_aura)
 	return otx2_sync_mbox_msg(&pfvf->mbox);
 }
 
-int otx2_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura)
+int otx2_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura)
 {
 	struct otx2_nic *pfvf = dev;
 	struct otx2_snd_queue *sq;
@@ -903,7 +927,7 @@ int otx2_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura)
 	aq->sq.ena = 1;
 	aq->sq.smq = otx2_get_smq_idx(pfvf, qidx);
 	aq->sq.smq_rr_quantum = mtu_to_dwrr_weight(pfvf, pfvf->tx_max_pktlen);
-	aq->sq.default_chan = pfvf->hw.tx_chan_base;
+	aq->sq.default_chan = pfvf->hw.tx_chan_base + chan_offset;
 	aq->sq.sqe_stype = NIX_STYPE_STF; /* Cache SQB */
 	aq->sq.sqb_aura = sqb_aura;
 	aq->sq.sq_int_ena = NIX_SQINT_BITS;
@@ -926,6 +950,7 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 	struct otx2_qset *qset = &pfvf->qset;
 	struct otx2_snd_queue *sq;
 	struct otx2_pool *pool;
+	u8 chan_offset;
 	int err;
 
 	pool = &pfvf->qset.pool[sqb_aura];
@@ -972,7 +997,8 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 	sq->stats.bytes = 0;
 	sq->stats.pkts = 0;
 
-	err = pfvf->hw_ops->sq_aq_init(pfvf, qidx, sqb_aura);
+	chan_offset = qidx % pfvf->hw.tx_chan_cnt;
+	err = pfvf->hw_ops->sq_aq_init(pfvf, qidx, chan_offset, sqb_aura);
 	if (err) {
 		kfree(sq->sg);
 		sq->sg = NULL;
@@ -1739,6 +1765,8 @@ void mbox_handler_nix_lf_alloc(struct otx2_nic *pfvf,
 	pfvf->hw.sqb_size = rsp->sqb_size;
 	pfvf->hw.rx_chan_base = rsp->rx_chan_base;
 	pfvf->hw.tx_chan_base = rsp->tx_chan_base;
+	pfvf->hw.rx_chan_cnt = rsp->rx_chan_cnt;
+	pfvf->hw.tx_chan_cnt = rsp->tx_chan_cnt;
 	pfvf->hw.lso_tsov4_idx = rsp->lso_tsov4_idx;
 	pfvf->hw.lso_tsov6_idx = rsp->lso_tsov6_idx;
 	pfvf->hw.cgx_links = rsp->cgx_links;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 962b10f1583a..be28a19ec2d4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -42,6 +42,8 @@
 #define PCI_SUBSYS_DEVID_96XX_RVU_PFVF		0xB200
 #define PCI_SUBSYS_DEVID_CN10K_B_RVU_PFVF	0xBD00
 
+#define PCI_DEVID_OCTEONTX2_SDP_REP		0xA0F7
+
 /* PCI BAR nos */
 #define PCI_CFG_REG_BAR_NUM                     2
 #define PCI_MBOX_BAR_NUM                        4
@@ -198,6 +200,7 @@ struct otx2_hw {
 
 	/* NIX */
 	u8			txschq_link_cfg_lvl;
+	u8			txschq_cnt[NIX_TXSCH_LVL_CNT];
 	u8			txschq_aggr_lvl_rr_prio;
 	u16			txschq_list[NIX_TXSCH_LVL_CNT][MAX_TXSCHQ_PER_FUNC];
 	u16			matchall_ipolicer;
@@ -208,6 +211,8 @@ struct otx2_hw {
 	/* HW settings, coalescing etc */
 	u16			rx_chan_base;
 	u16			tx_chan_base;
+	u8			rx_chan_cnt;
+	u8			tx_chan_cnt;
 	u16			cq_qcount_wait;
 	u16			cq_ecount_wait;
 	u16			rq_skid;
@@ -342,7 +347,8 @@ struct otx2_flow_config {
 };
 
 struct dev_hw_ops {
-	int	(*sq_aq_init)(void *dev, u16 qidx, u16 sqb_aura);
+	int	(*sq_aq_init)(void *dev, u16 qidx, u8 chan_offset,
+			      u16 sqb_aura);
 	void	(*sqe_flush)(void *dev, struct otx2_snd_queue *sq,
 			     int size, int qidx);
 	int	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
@@ -536,6 +542,11 @@ static inline bool is_96xx_B0(struct pci_dev *pdev)
 		(pdev->subsystem_device == PCI_SUBSYS_DEVID_96XX_RVU_PFVF);
 }
 
+static inline bool is_otx2_sdp_rep(struct pci_dev *pdev)
+{
+	return pdev->device == PCI_DEVID_OCTEONTX2_SDP_REP;
+}
+
 /* REVID for PCIe devices.
  * Bits 0..1: minor pass, bit 3..2: major pass
  * bits 7..4: midr id
@@ -898,15 +909,19 @@ static inline void otx2_dma_unmap_page(struct otx2_nic *pfvf,
 static inline u16 otx2_get_smq_idx(struct otx2_nic *pfvf, u16 qidx)
 {
 	u16 smq;
+	int idx;
+
 #ifdef CONFIG_DCB
 	if (qidx < NIX_PF_PFC_PRIO_MAX && pfvf->pfc_alloc_status[qidx])
 		return pfvf->pfc_schq_list[NIX_TXSCH_LVL_SMQ][qidx];
 #endif
 	/* check if qidx falls under QOS queues */
-	if (qidx >= pfvf->hw.non_qos_queues)
+	if (qidx >= pfvf->hw.non_qos_queues) {
 		smq = pfvf->qos.qid_to_sqmap[qidx - pfvf->hw.non_qos_queues];
-	else
-		smq = pfvf->hw.txschq_list[NIX_TXSCH_LVL_SMQ][0];
+	} else {
+		idx = qidx % pfvf->hw.txschq_cnt[NIX_TXSCH_LVL_SMQ];
+		smq = pfvf->hw.txschq_list[NIX_TXSCH_LVL_SMQ][idx];
+	}
 
 	return smq;
 }
@@ -973,8 +988,8 @@ int otx2_nix_config_bp(struct otx2_nic *pfvf, bool enable);
 void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq, int qidx);
 void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq);
 int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura);
-int otx2_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura);
-int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura);
+int otx2_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura);
+int cn10k_sq_aq_init(void *dev, u16 qidx, u8 chan_offset, u16 sqb_aura);
 int otx2_alloc_buffer(struct otx2_nic *pfvf, struct otx2_cq_queue *cq,
 		      dma_addr_t *dma);
 int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 0d62f16af68b..e310f99b1736 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1591,10 +1591,15 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
 	}
 
 	for (lvl = 0; lvl < NIX_TXSCH_LVL_CNT; lvl++) {
-		err = otx2_txschq_config(pf, lvl, 0, false);
-		if (err) {
-			mutex_unlock(&mbox->lock);
-			goto err_free_nix_queues;
+		int idx;
+
+		for (idx = 0; idx < pf->hw.txschq_cnt[lvl]; idx++) {
+			err = otx2_txschq_config(pf, lvl, idx, false);
+			if (err) {
+				dev_err(pf->dev, "Failed to config TXSCH\n");
+				mutex_unlock(&mbox->lock);
+				goto err_free_nix_queues;
+			}
 		}
 	}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 0486fca8b573..839fc77c11b2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -21,6 +21,7 @@
 static const struct pci_device_id otx2_vf_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_RVU_AFVF) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_RVU_VF) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_SDP_REP) },
 	{ }
 };
 
@@ -371,7 +372,7 @@ static int otx2vf_open(struct net_device *netdev)
 
 	/* LBKs do not receive link events so tell everyone we are up here */
 	vf = netdev_priv(netdev);
-	if (is_otx2_lbkvf(vf->pdev)) {
+	if (is_otx2_lbkvf(vf->pdev) || is_otx2_sdp_rep(vf->pdev)) {
 		pr_info("%s NIC Link is UP\n", netdev->name);
 		netif_carrier_on(netdev);
 		netif_tx_start_all_queues(netdev);
@@ -683,6 +684,15 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		snprintf(netdev->name, sizeof(netdev->name), "lbk%d", n);
 	}
 
+	if (is_otx2_sdp_rep(vf->pdev)) {
+		int n;
+
+		n = vf->pcifunc & RVU_PFVF_FUNC_MASK;
+		n -= 1;
+		snprintf(netdev->name, sizeof(netdev->name), "sdp%d-%d",
+			 pdev->bus->number, n);
+	}
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Failed to register netdevice\n");
-- 
2.25.1


