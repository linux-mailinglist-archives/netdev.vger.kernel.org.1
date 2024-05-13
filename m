Return-Path: <netdev+bounces-95855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C88C3AFF
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929C628138C
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 05:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97347146589;
	Mon, 13 May 2024 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fZqEb0p4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A0146006;
	Mon, 13 May 2024 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715578572; cv=none; b=mW+Blb8NVDJPSeh3ZAujV6pykeVY/rtda6XweULBKM9TwT+zihut6EOmBr3Z2yVPOjpzLKpNSKwNtJZgaCm8zu7/X5ybamQwHqOpvRuW1f8aJxRRQGrI4kjn5XNpc7dlIx7m4sPOy9yk96y5yG8UxKTZtsB8fR7e/JCmy5t38yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715578572; c=relaxed/simple;
	bh=0MW3izvAN5CSh0AeIV4uZw/ezK49dhKeF/Xp5eo18DE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kOoZ9wLjSCsRs3iflb3m03rqi8cRhZ+ZS/fFuZVmc/ivHLhzGHp4vGdKmpuOUSyNDbiPYjiRLuOwue/vfZqoqMEG7jKKgdkkLgq/MLRGyTjdijnNyxTG06/tODdN1IwvWoEeA34GZfexI4UrsjbOpuYc4w7ByGwrHamerYqlHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fZqEb0p4; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44CNgern028960;
	Sun, 12 May 2024 22:35:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=lfDAhmTR4ONcOxt53sztJEQJJgjetclVFc1wVBwbqTg=; b=fZq
	Eb0p4krWq38M9KYSNGNAbCtxPuXit1l9SZxi64ujv7FGNh2TcOpsp5htvZH8aG+W
	PIyxjg53fx3rLI0Ox4MA5dCB58asUwCQ2lcH1Fb/yIWAvRBQOtFxnLX9BZ2F2h5g
	3U8La9UGUg7w5JcfDPlassIV4ukhlPA7nHiQnPQlickA7VkzHJZvxVZ2nvMu2YnL
	Bd6YF/9WjVrD5m+b3R1dIUjdVMwZ/rTahg7kaeBsR+s/V9zUm2wNZSJMY90ELYBo
	LaesUE09BbDPSr6WriRUDhpVnu+7Z8ROVKFysOanbv+HQelkJtZdoXmMHvFABk1l
	W+SLuShrPFE2gb8kTqg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y261juc8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 22:35:52 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 12 May 2024 22:35:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 22:35:51 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 055BB3F707E;
	Sun, 12 May 2024 22:35:47 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: [PATCH] octeontx2-pf: devlink params support to set TL1 round robin priority
Date: Mon, 13 May 2024 11:05:46 +0530
Message-ID: <20240513053546.4067-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: KuLBNIGxLyzk1SimnkDxsN34amPdPNUv
X-Proofpoint-ORIG-GUID: KuLBNIGxLyzk1SimnkDxsN34amPdPNUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_04,2024-05-10_02,2023-05-22_02

Added support for setting or modifying transmit level (tl1) round robin
priority at runtime via devlink params.

Octeontx2 and CN10K silicon's support five transmit levels (TL5 to TL1).
On each transmit level Hardware supports DWRR and strict priority,
depend on the configuration the hardware will choose the appropriate method
to select packets for the next level in the transmission process.

Tree topology for PF netdev:
               TL1
               |
               TL2
               |
               TL3
               |
               TL4
               |
               TL5
               |
             (PF send queues)

Tree topology with PF and VF netdev:
                TL1
              |     |
             TL2    TL2
              |      |
             TL3    TL3
              |      |
             TL4    TL4
              |      |
             TL5    TL5
              |      |
        (PF Sqs)   (VF Sqs)

HW allocates same TL1 for both PF and its VF since they share same
physical link. Driver configures TL2 schedulers with same priority When
packets from both the PF and VFs arrive at TL2, TL1 uses round robin
algorithm and picks packets based on their quantum value.

Current implementation uses a fixes DWRR priority, this patch allows
user to configure the same.

commands:
devlink -p dev param show pci/0002:02:00.0 name tl1_rr_prio

pci/0002:02:00.0:
  name tl1_rr_prio type driver-specific
    values:
      cmode runtime value 7

devlink dev param set pci/0002:02:00.0 name tl1_rr_prio value 6
cmode runtime

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  7 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 15 ++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 38 ++++++++-
 .../marvell/octeontx2/nic/otx2_common.c       |  4 +-
 .../marvell/octeontx2/nic/otx2_common.h       |  1 +
 .../marvell/octeontx2/nic/otx2_devlink.c      | 85 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/qos.c  | 18 +++-
 8 files changed, 162 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 4a77f6fe2622..cee9b9fac5b2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -311,6 +311,7 @@ M(NIX_BANDPROF_GET_HWINFO, 0x801f, nix_bandprof_get_hwinfo, msg_req,		\
 				nix_bandprof_get_hwinfo_rsp)		    \
 M(NIX_READ_INLINE_IPSEC_CFG, 0x8023, nix_read_inline_ipsec_cfg,		\
 				msg_req, nix_inline_ipsec_cfg)		\
+M(NIX_TL1_RR_PRIO,	0x8025, nix_tl1_rr_prio, nix_tl1_rr_prio_req, msg_rsp) \
 M(NIX_MCAST_GRP_CREATE,	0x802b, nix_mcast_grp_create, nix_mcast_grp_create_req,	\
 				nix_mcast_grp_create_rsp)			\
 M(NIX_MCAST_GRP_DESTROY, 0x802c, nix_mcast_grp_destroy, nix_mcast_grp_destroy_req,	\
@@ -844,6 +845,7 @@ enum nix_af_status {
 	NIX_AF_ERR_CQ_CTX_WRITE_ERR  = -429,
 	NIX_AF_ERR_AQ_CTX_RETRY_WRITE  = -430,
 	NIX_AF_ERR_LINK_CREDITS  = -431,
+	NIX_AF_ERR_TL1_RR_PRIO_PERM_DENIED  = -433,
 	NIX_AF_ERR_INVALID_BPID         = -434,
 	NIX_AF_ERR_INVALID_BPID_REQ     = -435,
 	NIX_AF_ERR_INVALID_MCAST_GRP	= -436,
@@ -1363,6 +1365,11 @@ struct nix_bandprof_get_hwinfo_rsp {
 	u32 policer_timeunit;
 };
 
+struct nix_tl1_rr_prio_req {
+	struct mbox_msghdr hdr;
+	u8 tl1_rr_prio;
+};
+
 /* NPC mbox message structs */
 
 #define NPC_MCAM_ENTRY_INVALID	0xFFFF
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ff78251f92d4..161ebb781978 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -808,6 +808,18 @@ static void rvu_setup_pfvf_macaddress(struct rvu *rvu)
 	}
 }
 
+static void rvu_setup_pfvf_aggr_lvl_rr_prio(struct rvu *rvu)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+	struct rvu_pfvf *pfvf;
+	int pf;
+
+	for (pf = 0; pf < hw->total_pfs; pf++) {
+		pfvf = &rvu->pf[pf];
+		pfvf->tl1_rr_prio = TXSCH_TL1_DFLT_RR_PRIO;
+	}
+}
+
 static int rvu_fwdata_init(struct rvu *rvu)
 {
 	u64 fwdbase;
@@ -1141,6 +1153,9 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 	/* Assign MACs for CGX mapped functions */
 	rvu_setup_pfvf_macaddress(rvu);
 
+	/* Assign aggr level RR Priority */
+	rvu_setup_pfvf_aggr_lvl_rr_prio(rvu);
+
 	err = rvu_npa_init(rvu);
 	if (err) {
 		dev_err(rvu->dev, "%s: Failed to initialize npa\n", __func__);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 35834687e40f..af4ece89b4c2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -277,6 +277,7 @@ struct rvu_pfvf {
 	u64     lmt_map_ent_w1; /* Preseving the word1 of lmtst map table entry*/
 	unsigned long flags;
 	struct  sdp_node_info *sdp_info;
+	u8	tl1_rr_prio; /* RR PRIORITY set by PF */
 };
 
 enum rvu_pfvf_flags {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 00af8888e329..f9383c41f91a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2159,6 +2159,7 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = req->hdr.pcifunc;
+	struct rvu_pfvf *parent_pf;
 	int link, blkaddr, rc = 0;
 	int lvl, idx, start, end;
 	struct nix_txsch *txsch;
@@ -2175,6 +2176,8 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 	if (!nix_hw)
 		return NIX_AF_ERR_INVALID_NIXBLK;
 
+	parent_pf = &rvu->pf[rvu_get_pf(pcifunc)];
+
 	mutex_lock(&rvu->rsrc_lock);
 
 	/* Check if request is valid as per HW capabilities
@@ -2234,7 +2237,7 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 	}
 
 	rsp->aggr_level = hw->cap.nix_tx_aggr_lvl;
-	rsp->aggr_lvl_rr_prio = TXSCH_TL1_DFLT_RR_PRIO;
+	rsp->aggr_lvl_rr_prio = parent_pf->tl1_rr_prio;
 	rsp->link_cfg_lvl = rvu_read64(rvu, blkaddr,
 				       NIX_AF_PSE_CHANNEL_LEVEL) & 0x01 ?
 				       NIX_TXSCH_LVL_TL3 : NIX_TXSCH_LVL_TL2;
@@ -2666,6 +2669,7 @@ static bool is_txschq_shaping_valid(struct rvu_hwinfo *hw, int lvl, u64 reg)
 static void nix_tl1_default_cfg(struct rvu *rvu, struct nix_hw *nix_hw,
 				u16 pcifunc, int blkaddr)
 {
+	struct rvu_pfvf *parent_pf = &rvu->pf[rvu_get_pf(pcifunc)];
 	u32 *pfvf_map;
 	int schq;
 
@@ -2675,7 +2679,7 @@ static void nix_tl1_default_cfg(struct rvu *rvu, struct nix_hw *nix_hw,
 	if (TXSCH_MAP_FLAGS(pfvf_map[schq]) & NIX_TXSCHQ_CFG_DONE)
 		return;
 	rvu_write64(rvu, blkaddr, NIX_AF_TL1X_TOPOLOGY(schq),
-		    (TXSCH_TL1_DFLT_RR_PRIO << 1));
+		    (parent_pf->tl1_rr_prio << 1));
 
 	/* On OcteonTx2 the config was in bytes and newer silcons
 	 * it's changed to weight.
@@ -6497,3 +6501,33 @@ int rvu_mbox_handler_nix_mcast_grp_update(struct rvu *rvu,
 
 	return ret;
 }
+
+int rvu_mbox_handler_nix_tl1_rr_prio(struct rvu *rvu,
+				     struct nix_tl1_rr_prio_req *req,
+				     struct msg_rsp *rsp)
+{
+	u16 pcifunc = req->hdr.pcifunc;
+	int blkaddr, nixlf, schq, err;
+	struct rvu_pfvf *pfvf;
+	u16 regval;
+
+	err = nix_get_nixlf(rvu, pcifunc, &nixlf, &blkaddr);
+	if (err)
+		return err;
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+	/* Only PF is allowed */
+	if (is_vf(pcifunc))
+		return NIX_AF_ERR_TL1_RR_PRIO_PERM_DENIED;
+
+	pfvf->tl1_rr_prio = req->tl1_rr_prio;
+
+	/* update TL1 topology */
+	schq = nix_get_tx_link(rvu, pcifunc);
+	regval = rvu_read64(rvu, blkaddr, NIX_AF_TL1X_TOPOLOGY(schq));
+	regval &= ~GENMASK_ULL(4, 1);
+	regval |= pfvf->tl1_rr_prio << 1;
+	rvu_write64(rvu, blkaddr, NIX_AF_TL1X_TOPOLOGY(schq), regval);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index a85ac039d779..7adc74f95935 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -674,7 +674,7 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL2X_SCHEDULE(schq);
-		req->regval[1] = TXSCH_TL1_DFLT_RR_PRIO << 24 | dwrr_val;
+		req->regval[1] = hw->txschq_aggr_lvl_rr_prio << 24 | dwrr_val;
 
 		if (lvl == hw->txschq_link_cfg_lvl) {
 			req->num_regs++;
@@ -698,7 +698,7 @@ int otx2_txschq_config(struct otx2_nic *pfvf, int lvl, int prio, bool txschq_for
 
 		req->num_regs++;
 		req->reg[1] = NIX_AF_TL1X_TOPOLOGY(schq);
-		req->regval[1] = (TXSCH_TL1_DFLT_RR_PRIO << 1);
+		req->regval[1] = (hw->txschq_aggr_lvl_rr_prio << 1);
 
 		req->num_regs++;
 		req->reg[2] = NIX_AF_TL1X_CIR(schq);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 24fbbef265a6..85affc832c38 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1128,4 +1128,5 @@ u16 otx2_select_queue(struct net_device *netdev, struct sk_buff *skb,
 int otx2_get_txq_by_classid(struct otx2_nic *pfvf, u16 classid);
 void otx2_qos_config_txschq(struct otx2_nic *pfvf);
 void otx2_clean_qos_queues(struct otx2_nic *pfvf);
+bool otx2_is_qos_configured(struct otx2_nic *pfvf);
 #endif /* OTX2_COMMON_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 99ddf31269d9..42b4ccc093db 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -64,9 +64,89 @@ static int otx2_dl_mcam_count_get(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int otx2_dl_tl1_rr_prio_validate(struct devlink *devlink, u32 id,
+					union devlink_param_value val,
+					struct netlink_ext_ack *extack)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pf = otx2_dl->pfvf;
+
+	if (is_otx2_vf(pf->pcifunc)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "TL1RR PRIORITY setting not allowed on VFs");
+		return -EOPNOTSUPP;
+	}
+
+	if (otx2_is_qos_configured(pf)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "TL1RR PRIORITY setting not allowed after QOS config");
+		return -EOPNOTSUPP;
+	}
+
+	if (pci_num_vf(pf->pdev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "TL1RR PRIORITY setting not allowed as VFs are already attached");
+		return -EOPNOTSUPP;
+	}
+
+	if (val.vu8 > 7) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Valid priority range 0 - 7");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int otx2_dl_tl1_rr_prio_get(struct devlink *devlink, u32 id,
+				   struct devlink_param_gset_ctx *ctx)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+
+	ctx->val.vu8 = pfvf->hw.txschq_aggr_lvl_rr_prio;
+
+	return 0;
+}
+
+static int otx2_dl_tl1_rr_prio_set(struct devlink *devlink, u32 id,
+				   struct devlink_param_gset_ctx *ctx,
+				   struct netlink_ext_ack *extack)
+{
+	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
+	struct otx2_nic *pfvf = otx2_dl->pfvf;
+	struct nix_tl1_rr_prio_req *req;
+	bool if_up;
+	int err;
+
+	if_up = netif_running(pfvf->netdev);
+
+	/* send mailbox to AF */
+	mutex_lock(&pfvf->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_nix_tl1_rr_prio(&pfvf->mbox);
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
+		return -ENOMEM;
+	}
+
+	req->tl1_rr_prio = ctx->val.vu8;
+	err = otx2_sync_mbox_msg(&pfvf->mbox);
+	mutex_unlock(&pfvf->mbox.lock);
+
+	/* Reconfigure TL1/TL2 DWRR PRIORITY */
+	if (!err && if_up) {
+		otx2_stop(pfvf->netdev);
+		otx2_open(pfvf->netdev);
+	}
+
+	return err;
+}
+
 enum otx2_dl_param_id {
 	OTX2_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	OTX2_DEVLINK_PARAM_ID_MCAM_COUNT,
+	OTX2_DEVLINK_PARAM_ID_TL1_RR_PRIO,
 };
 
 static const struct devlink_param otx2_dl_params[] = {
@@ -75,6 +155,11 @@ static const struct devlink_param otx2_dl_params[] = {
 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			     otx2_dl_mcam_count_get, otx2_dl_mcam_count_set,
 			     otx2_dl_mcam_count_validate),
+	DEVLINK_PARAM_DRIVER(OTX2_DEVLINK_PARAM_ID_TL1_RR_PRIO,
+			     "tl1_rr_prio", DEVLINK_PARAM_TYPE_U8,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     otx2_dl_tl1_rr_prio_get, otx2_dl_tl1_rr_prio_set,
+			     otx2_dl_tl1_rr_prio_validate),
 };
 
 static const struct devlink_ops otx2_devlink_ops = {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 070711df612e..5b531da0ce53 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -176,9 +176,9 @@ static void __otx2_qos_txschq_cfg(struct otx2_nic *pfvf,
 		/* check if node is root */
 		if (node->qid == OTX2_QOS_QID_INNER && !node->parent) {
 			cfg->reg[num_regs] = NIX_AF_TL2X_SCHEDULE(node->schq);
-			cfg->regval[num_regs] =  TXSCH_TL1_DFLT_RR_PRIO << 24 |
-						 mtu_to_dwrr_weight(pfvf,
-								    pfvf->tx_max_pktlen);
+			cfg->regval[num_regs] =
+				(hw->txschq_aggr_lvl_rr_prio << 24) |
+				 mtu_to_dwrr_weight(pfvf, pfvf->tx_max_pktlen);
 			num_regs++;
 			goto txschq_cfg_out;
 		}
@@ -1723,6 +1723,18 @@ void otx2_qos_config_txschq(struct otx2_nic *pfvf)
 	otx2_qos_root_destroy(pfvf);
 }
 
+bool otx2_is_qos_configured(struct otx2_nic *pfvf)
+{
+	struct otx2_qos_node *root;
+
+	root = otx2_sw_node_find(pfvf, OTX2_QOS_ROOT_CLASSID);
+	if (!root)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(otx2_is_qos_configured);
+
 int otx2_setup_tc_htb(struct net_device *ndev, struct tc_htb_qopt_offload *htb)
 {
 	struct otx2_nic *pfvf = netdev_priv(ndev);
-- 
2.17.1


