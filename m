Return-Path: <netdev+bounces-148823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8741C9E3359
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7485F166D2E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7119618CBF2;
	Wed,  4 Dec 2024 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="e3WJnOPu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB418BC3D;
	Wed,  4 Dec 2024 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291858; cv=none; b=Dj+i7Ic/ANNLJdMjw1jBwLddsUthWAYyliA003RSpXOLjlRG694Nwwi3kFm778eCl133hgg8vlvzyVSNUyGhaix+a989vxLqltAvmGOw0BELWdJUhx15Axj/ZY94XtYEOTnIHqAJsidEnfz7QRIrIAA8sNPgKDbkNY4DBlN+iKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291858; c=relaxed/simple;
	bh=X+BtlKPLlTQqgIFsZ55iJAUfQvcvAm1+kEdLUetJD+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZblsIwO8YH8VlI6v7mqHlOlsERLEc4Go8Le8ky7Gz1gYiig+pokQ+m4eWnp2e1ZnkKCdTTVysBD0wKYLD+RGCBRW2MNsJV3lPQxMYVk5ddWOuGQSRSP32ZY248hPFNsqtC3c/iwKrqnsNXe5CjPBKC4X4Qp6kfnm3AuMA5bSu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=e3WJnOPu; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B42i8N9027274;
	Tue, 3 Dec 2024 21:57:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
	xQQIHMFd+oO0R86CxxrrBEtvYUabdEyDFFFdI2tUrc=; b=e3WJnOPuP8aGKRa2E
	Lshcj2WvZ15q88HJRoU/ao7+fPbF9JlBLtXryN7yedOpysETYy8Ds6xtJVvJ4VSP
	Tr7jK1DfZLsTL9RpgbpxEc/ukoZp4L3NlvY+ypKLnurJuhG+34LWAGOWCxwc28zl
	txv9Iy9GDaCoKgU7+SAZ+Bn8cgFZTyHksgok38zGeab8ZNgIfsFFm30mga5kkgmi
	d2EICBqqrXscJvzVvMxQs1E6MhWreH374xosdDOUtoWHjNjk8eltP4MJzvelgJSn
	G5wefJr4pJaeZdU/xnNRpNkyyKnbEQXx3seMAUxQSpGecGUuNEpu4TwpNUdYpLc4
	35btQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43aejc0a1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 21:57:22 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 21:57:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 21:57:20 -0800
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 670013F7095;
	Tue,  3 Dec 2024 21:57:16 -0800 (PST)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <andrew+netdev@lunn.ch>, <richardcochran@gmail.com>,
        <bbhushan2@marvell.com>
Subject: [net-next PATCH v10 3/8] octeontx2-af: Disable backpressure between CPT and NIX
Date: Wed, 4 Dec 2024 11:26:54 +0530
Message-ID: <20241204055659.1700459-4-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204055659.1700459-1-bbhushan2@marvell.com>
References: <20241204055659.1700459-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9YMQmOgLrhrb6kO8zQetnr5e1WiULqo5
X-Proofpoint-ORIG-GUID: 9YMQmOgLrhrb6kO8zQetnr5e1WiULqo5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

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
index 62c07407eb94..005ca8a056c0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -313,6 +313,10 @@ M(NIX_BANDPROF_FREE,	0x801e, nix_bandprof_free, nix_bandprof_free_req,   \
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
index 5d5a01dbbca1..9080ae736d12 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -569,9 +569,17 @@ void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc)
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
@@ -579,6 +587,7 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 	struct rvu_pfvf *pfvf;
 	struct nix_hw *nix_hw;
 	struct nix_bp *bp;
+	u16 chan_v;
 	u64 cfg;
 
 	pf = rvu_get_pf(pcifunc);
@@ -589,6 +598,9 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
 	if (is_sdp_pfvf(pcifunc))
 		type = NIX_INTF_TYPE_SDP;
 
+	if (cpt_link && !rvu->hw->cpt_links)
+		return 0;
+
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	err = nix_get_struct_ptrs(rvu, pcifunc, &nix_hw, &blkaddr);
 	if (err)
@@ -597,8 +609,9 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
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
@@ -617,6 +630,20 @@ int rvu_mbox_handler_nix_bp_disable(struct rvu *rvu,
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
@@ -696,15 +723,17 @@ static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
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
@@ -717,6 +746,9 @@ int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
 	    type != NIX_INTF_TYPE_SDP)
 		return 0;
 
+	if (cpt_link && !rvu->hw->cpt_links)
+		return 0;
+
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
 
@@ -730,9 +762,11 @@ int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
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
@@ -750,6 +784,20 @@ int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
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
index 971115a5d2cc..4c8774899eaf 100644
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
@@ -1723,18 +1728,43 @@ int otx2_nix_config_bp(struct otx2_nic *pfvf, bool enable)
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
index bb78d825046d..37a32ac0dae7 100644
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
index 294fba58b670..f110dfa42360 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -435,6 +435,9 @@ static int otx2_dcbnl_ieee_setpfc(struct net_device *dev, struct ieee_pfc *pfc)
 		return err;
 	}
 
+	/* Default disable backpressure on NIX-CPT */
+	otx2_nix_cpt_config_bp(pfvf, false);
+
 	/* Request Per channel Bpids */
 	if (pfc->pfc_en)
 		otx2_nix_config_bp(pfvf, true);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index e310f99b1736..8ec0296dee84 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1551,6 +1551,9 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
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


