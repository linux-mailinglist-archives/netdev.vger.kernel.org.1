Return-Path: <netdev+bounces-122345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CD1960C19
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 401C3B25CAA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AEB1C4605;
	Tue, 27 Aug 2024 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kev8+M1K"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B171BFDF3;
	Tue, 27 Aug 2024 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765570; cv=none; b=Y5n22hiBFwBUuflOiSNdc1SgAHXn4mK3AHDRYf3zbIPyWLbZcGORBkZLKLr1fneT/8aAIFAWxJl7C9U9n/jZl4xtQSmRA6A5cXFOyvBB7KpauGdOLIThr+Z3qVyte9bkcKx6aIQSpDxh2X6ToisQiTbGl/2sls0jCgIPYWJKDKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765570; c=relaxed/simple;
	bh=UkjEz/8ofJS90cweK60rbXBzkuRYPimwfTMHYvgVx4U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=facsMGwUqBhIr/k0f8V3kr8bzJ57bpr+bDXPCAbIF3bdfWnC9kjKRQzy3UZdLA8VZ66jhwguXdNxMwL3XUZJqR2nNircEQIIHC2vdVKaA1tqw50RfyCepuastbLNraMZ0Fi2otkEglL+EBqSENhSY3XfFp6CWNVfQWIzGfBK8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kev8+M1K; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R9Sgsv009407;
	Tue, 27 Aug 2024 06:32:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
	90O7HSh8ypOcBlmWVVrhZjIL/zQrm/UvJhB2H8IWxk=; b=kev8+M1KrZXEOu3zK
	ZXTSySoq8AxUDf4pDlcDZfDaxhiLtglYOKDdNq1iZlQLbsMDh+zqScqnMgORsBvO
	o6btfi4GYgb/WZ7CmqaaJFAZoJxb3wBFX0toshVLzfVpULBTaeGmcXEbnneOb+zz
	8kn7orgaLabt/ftni/paER7YTkDrde6KK63n0Xrrts9mnkCwuMwqP2a3eGM/4ZsX
	yMcGS035QFq84WA//hlPQ//g/xNx6mt/q64NgNNhG3cbY+TOffZOST/+jzqmTvZt
	k9HSxNKdzuMKmRPdoZE3i+YQtfydwWt7nb3pIep1MUbEulR/NHI3ba5GKPZT7PH7
	cDCCw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 419c6grrar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:32:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 Aug 2024 06:32:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 Aug 2024 06:32:32 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 116885C68E4;
	Tue, 27 Aug 2024 06:32:27 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>, <bharatb.linux@gmail.com>
Subject: [net-next PATCH v7 3/8] octeontx2-af: Disable backpressure between CPT and NIX
Date: Tue, 27 Aug 2024 19:02:05 +0530
Message-ID: <20240827133210.1418411-4-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827133210.1418411-1-bbhushan2@marvell.com>
References: <20240827133210.1418411-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kMjmJCsRs31Q6_7_ohXpxlFxRh0LTTyW
X-Proofpoint-GUID: kMjmJCsRs31Q6_7_ohXpxlFxRh0LTTyW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_07,2024-08-27_01,2024-05-17_01

NIX can assert backpressure to CPT on the NIX<=>CPT link.
Keep the backpressure disabled for now. NIX block anyways
handles backpressure asserted by MAC due to PFC or flow
control pkts.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v2->v3:
 - Added helper function to get channel
 - PFC enabled check moved to helper function

 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  4 ++
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 68 ++++++++++++++++---
 .../marvell/octeontx2/nic/otx2_common.c       | 44 ++++++++++--
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |  3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  3 +
 6 files changed, 106 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index ed2160cc5acb..833d9f676463 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -310,6 +310,10 @@ M(NIX_BANDPROF_FREE,	0x801e, nix_bandprof_free, nix_bandprof_free_req,   \
 				msg_rsp)				    \
 M(NIX_BANDPROF_GET_HWINFO, 0x801f, nix_bandprof_get_hwinfo, msg_req,		\
 				nix_bandprof_get_hwinfo_rsp)		    \
+M(NIX_CPT_BP_ENABLE,    0x8020, nix_cpt_bp_enable, nix_bp_cfg_req,	    \
+				nix_bp_cfg_rsp)				    \
+M(NIX_CPT_BP_DISABLE,   0x8021, nix_cpt_bp_disable, nix_bp_cfg_req,	    \
+				msg_rsp)				\
 M(NIX_READ_INLINE_IPSEC_CFG, 0x8023, nix_read_inline_ipsec_cfg,		\
 				msg_req, nix_inline_ipsec_cfg)		\
 M(NIX_MCAST_GRP_CREATE,	0x802b, nix_mcast_grp_create, nix_mcast_grp_create_req,	\
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 222f9e00b836..e5b3b6f7c7e7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -567,9 +567,17 @@ void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc)
 	mutex_unlock(&rvu->rsrc_lock);
 }
 
-int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
-				    struct nix_bp_cfg_req *req,
-				    struct msg_rsp *rsp)
+static u16 nix_get_channel(u16 chan, bool cpt_link)
+{
+	/* CPT channel for a given link channel is always
+	 * assumed to be BIT(11) set in link channel.
+	 */
+	return cpt_link ? chan | BIT(11) : chan;
+}
+
+static int nix_bp_disable(struct rvu *rvu,
+			  struct nix_bp_cfg_req *req,
+			  struct msg_rsp *rsp, bool cpt_link)
 {
 	u16 pcifunc = req->hdr.pcifunc;
 	int blkaddr, pf, type, err;
@@ -577,6 +585,7 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 	struct rvu_pfvf *pfvf;
 	struct nix_hw *nix_hw;
 	struct nix_bp *bp;
+	u16 chan_v;
 	u64 cfg;
 
 	pf = rvu_get_pf(pcifunc);
@@ -584,6 +593,9 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 	if (!is_pf_cgxmapped(rvu, pf) && type != NIX_INTF_TYPE_LBK)
 		return 0;
 
+	if (cpt_link && !rvu->hw->cpt_links)
+		return 0;
+
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
 	if (err)
@@ -592,8 +604,9 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 	bp = &nix_hw->bp;
 	chan_base = pfvf->rx_chan_base + req->chan_base;
 	for (chan = chan_base; chan < (chan_base + req->chan_cnt); chan++) {
-		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan));
-		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan),
+		chan_v = nix_get_channel(chan, cpt_link);
+		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v));
+		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
 			    cfg & ~BIT_ULL(16));
 
 		if (type == NIX_INTF_TYPE_LBK) {
@@ -612,6 +625,20 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 	return 0;
 }
 
+int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
+				    struct nix_bp_cfg_req *req,
+				    struct msg_rsp *rsp)
+{
+	return nix_bp_disable(rvu, req, rsp, false);
+}
+
+int rvu_mbox_handler_nix_cpt_bp_disable(struct rvu *rvu,
+					struct nix_bp_cfg_req *req,
+					struct msg_rsp *rsp)
+{
+	return nix_bp_disable(rvu, req, rsp, true);
+}
+
 static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
 			    int type, int chan_id)
 {
@@ -691,15 +718,17 @@ static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
 	return bpid;
 }
 
-int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
-				   struct nix_bp_cfg_req *req,
-				   struct nix_bp_cfg_rsp *rsp)
+static int nix_bp_enable(struct rvu *rvu,
+			 struct nix_bp_cfg_req *req,
+			 struct nix_bp_cfg_rsp *rsp,
+			 bool cpt_link)
 {
 	int blkaddr, pf, type, chan_id = 0;
 	u16 pcifunc = req->hdr.pcifunc;
 	struct rvu_pfvf *pfvf;
 	u16 chan_base, chan;
 	s16 bpid, bpid_base;
+	u16 chan_v;
 	u64 cfg;
 
 	pf = rvu_get_pf(pcifunc);
@@ -712,6 +741,9 @@ int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
 	    type != NIX_INTF_TYPE_SDP)
 		return 0;
 
+	if (cpt_link && !rvu->hw->cpt_links)
+		return 0;
+
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
 
@@ -725,9 +757,11 @@ int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
 			return -EINVAL;
 		}
 
-		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan));
+		chan_v = nix_get_channel(chan, cpt_link);
+
+		cfg = rvu_read64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v));
 		cfg &= ~GENMASK_ULL(8, 0);
-		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan),
+		rvu_write64(rvu, blkaddr, NIX_AF_RX_CHANX_CFG(chan_v),
 			    cfg | (bpid & GENMASK_ULL(8, 0)) | BIT_ULL(16));
 		chan_id++;
 		bpid = rvu_nix_get_bpid(rvu, req, type, chan_id);
@@ -745,6 +779,20 @@ int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
 	return 0;
 }
 
+int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
+				   struct nix_bp_cfg_req *req,
+				   struct nix_bp_cfg_rsp *rsp)
+{
+	return nix_bp_enable(rvu, req, rsp, false);
+}
+
+int rvu_mbox_handler_nix_cpt_bp_enable(struct rvu *rvu,
+				       struct nix_bp_cfg_req *req,
+				       struct nix_bp_cfg_rsp *rsp)
+{
+	return nix_bp_enable(rvu, req, rsp, true);
+}
+
 static void nix_setup_lso_tso_l3(struct rvu *rvu, int blkaddr,
 				 u64 format, bool v4, u64 *fidx)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 3f97f2c8ce3d..a7d67692e77e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -17,6 +17,11 @@
 #include "otx2_struct.h"
 #include "cn10k.h"
 
+static bool otx2_is_pfc_enabled(struct otx2_nic *pfvf)
+{
+	return IS_ENABLED(CONFIG_DCB) && !!pfvf->pfc_en;
+}
+
 static void otx2_nix_rq_op_stats(struct queue_stats *stats,
 				 struct otx2_nic *pfvf, int qidx)
 {
@@ -1694,18 +1699,43 @@ int otx2_nix_config_bp(struct otx2_nic *pfvf, bool enable)
 		return -ENOMEM;
 
 	req->chan_base = 0;
-#ifdef CONFIG_DCB
-	req->chan_cnt = pfvf->pfc_en ? IEEE_8021QAZ_MAX_TCS : 1;
-	req->bpid_per_chan = pfvf->pfc_en ? 1 : 0;
-#else
-	req->chan_cnt =  1;
-	req->bpid_per_chan = 0;
-#endif
+	if (otx2_is_pfc_enabled(pfvf)) {
+		req->chan_cnt = IEEE_8021QAZ_MAX_TCS;
+		req->bpid_per_chan = 1;
+	} else {
+		req->chan_cnt = 1;
+		req->bpid_per_chan = 0;
+	}
 
 	return otx2_sync_mbox_msg(&pfvf->mbox);
 }
 EXPORT_SYMBOL(otx2_nix_config_bp);
 
+int otx2_nix_cpt_config_bp(struct otx2_nic *pfvf, bool enable)
+{
+	struct nix_bp_cfg_req *req;
+
+	if (enable)
+		req = otx2_mbox_alloc_msg_nix_cpt_bp_enable(&pfvf->mbox);
+	else
+		req = otx2_mbox_alloc_msg_nix_cpt_bp_disable(&pfvf->mbox);
+
+	if (!req)
+		return -ENOMEM;
+
+	req->chan_base = 0;
+	if (otx2_is_pfc_enabled(pfvf)) {
+		req->chan_cnt = IEEE_8021QAZ_MAX_TCS;
+		req->bpid_per_chan = 1;
+	} else {
+		req->chan_cnt = 1;
+		req->bpid_per_chan = 0;
+	}
+
+	return otx2_sync_mbox_msg(&pfvf->mbox);
+}
+EXPORT_SYMBOL(otx2_nix_cpt_config_bp);
+
 /* Mbox message handlers */
 void mbox_handler_cgx_stats(struct otx2_nic *pfvf,
 			    struct cgx_stats_rsp *rsp)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index a791a046f1c9..21fe8297a050 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -985,6 +985,7 @@ int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 int otx2_rxtx_enable(struct otx2_nic *pfvf, bool enable);
 void otx2_ctx_disable(struct mbox *mbox, int type, bool npa);
 int otx2_nix_config_bp(struct otx2_nic *pfvf, bool enable);
+int otx2_nix_cpt_config_bp(struct otx2_nic *pfvf, bool enable);
 void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq, int qidx);
 void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq);
 int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index aa01110f04a3..d1489803de63 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -430,6 +430,9 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
 		return err;
 	}
 
+	/* Default disable backpressure on NIX-CPT */
+	otx2_nix_cpt_config_bp(pfvf, false);
+
 	/* Request Per channel Bpids */
 	if (pfc->pfc_en)
 		otx2_nix_config_bp(pfvf, true);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 5492dea547a1..4956404c86e2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1509,6 +1509,9 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	if (err)
 		goto err_free_npa_lf;
 
+	/* Default disable backpressure on NIX-CPT */
+	otx2_nix_cpt_config_bp(pf, false);
+
 	/* Enable backpressure for CGX mapped PF/VFs */
 	if (!is_otx2_lbkvf(pf->pdev))
 		otx2_nix_config_bp(pf, true);
-- 
2.34.1


