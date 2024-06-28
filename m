Return-Path: <netdev+bounces-107759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C4291C3C1
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CFFAB21A53
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CE01C9ED3;
	Fri, 28 Jun 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lLJeKzD0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76691C9EC5;
	Fri, 28 Jun 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592312; cv=none; b=X70TOr0/j06IU5l5tEGQL80qngoh3sWJ6dT09ISGgLaHQt0EAIiexlgbrIo5b8PDhhtHXPSebZiMPrOmJHi493McYh/Cap/7ix1f/RIiq74+BtgW8+PekxxNt8a8XGV/wDY6nYjuVI3NDPb4c/F35/BvuPZ71lCtxIXIicMsjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592312; c=relaxed/simple;
	bh=QKxl8ZVBNRI9htAQwXQwRD+R1PdU09erLTRCZ4l7khY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OckdbUzyR2vyWCoIwGgOEzzk/6TLM3AgNb697aWQgi4rzEuwwNnfOqNsiabzqwhnn/Do1txFcAMlNEBnt//CBXHLRLWYv1EzNo6mkgKcPuZzoCRrrwJs1Gepr2LTCS3xm/OE0cA+P+S0QdN8+872Ccy35IyCYFfcK+mbCgM5brE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lLJeKzD0; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SA18RK027520;
	Fri, 28 Jun 2024 09:31:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=Uho6NtqjawxmhFTo3ricaRrYg88K9shZ62TUGanQ7DQ=; b=lLJ
	eKzD0Gmt2by9dO974L9TMMyU1smQxAnbw2SFhYi7EecjXZNP6bDHDgFOf+PHKr+n
	8I/+A58Mt2/NvziWcYsqXnxvC07wfjDjU8fJSMwDIi5Axq4XAYZYSHzr1TPxN/oL
	nGHGAMz774ZTnrEv9gvyJBbmAaSvonvZiuHgR8eOEb4TCQX8j3n6wsjY/On9o6fX
	yiu1j9qrkn/Fz8RVU1bWNFZudzHtbQDC/d4XGoR44rf3Mp+0aTw707+W4+scZtfG
	/MNhX8gAxTj3YN/ZpwGGPFEs5G7gVhvlWnjHtok7SILo3wd/SONoxJY5xHACjf2U
	/mcK2XN46XloYcuX7wA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 401c8hv2by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 09:31:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 28 Jun 2024 09:31:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 28 Jun 2024 09:31:42 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 4B23C3F705D;
	Fri, 28 Jun 2024 09:31:38 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Nithin Dabilpuram <ndabilpuram@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian
	<lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob
	<jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [net-next PATCH] octeontx2-af: Sync NIX and NPA contexts from NDC to LLC/DRAM
Date: Fri, 28 Jun 2024 22:01:26 +0530
Message-ID: <1719592286-24699-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: WXNgG1tZTxGWiMcDeKVK4QuODXrY3OvX
X-Proofpoint-ORIG-GUID: WXNgG1tZTxGWiMcDeKVK4QuODXrY3OvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_12,2024-06-28_01,2024-05-17_01

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Octeontx2 hardware uses Near Data Cache(NDC) block to cache
contexts in it so that access to LLC/DRAM can be avoided.
It is recommended in HRM to sync the NDC contents before
releasing/resetting LF resources. Hence implement NDC_SYNC
mailbox and sync contexts during driver teardown.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |  8 +++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    | 66 ++++++++++++++++++++++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.h    |  2 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 24 ++++++++
 6 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 4a77f6f..ebf84c2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -139,6 +139,7 @@ M(MSIX_OFFSET,		0x005, msix_offset, msg_req, msix_offset_rsp)	\
 M(VF_FLR,		0x006, vf_flr, msg_req, msg_rsp)		\
 M(PTP_OP,		0x007, ptp_op, ptp_req, ptp_rsp)		\
 M(GET_HW_CAP,		0x008, get_hw_cap, msg_req, get_hw_cap_rsp)	\
+M(NDC_SYNC_OP,		0x009, ndc_sync_op, ndc_sync_op, msg_rsp)	\
 M(LMTST_TBL_SETUP,	0x00a, lmtst_tbl_setup, lmtst_tbl_setup_req,    \
 				msg_rsp)				\
 M(SET_VF_PERM,		0x00b, set_vf_perm, set_vf_perm, msg_rsp)	\
@@ -1716,6 +1717,13 @@ struct lmtst_tbl_setup_req {
 	u64 rsvd[4];
 };
 
+struct ndc_sync_op {
+	struct mbox_msghdr hdr;
+	u8 nix_lf_tx_sync;
+	u8 nix_lf_rx_sync;
+	u8 npa_lf_sync;
+};
+
 /* CPT mailbox error codes
  * Range 901 - 1000.
  */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ff78251..5a4f774 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2014,6 +2014,13 @@ int rvu_mbox_handler_vf_flr(struct rvu *rvu, struct msg_req *req,
 	return 0;
 }
 
+int rvu_ndc_sync(struct rvu *rvu, int lfblkaddr, int lfidx, u64 lfoffset)
+{
+	/* Sync cached info for this LF in NDC to LLC/DRAM */
+	rvu_write64(rvu, lfblkaddr, lfoffset, BIT_ULL(12) | lfidx);
+	return rvu_poll_reg(rvu, lfblkaddr, lfoffset, BIT_ULL(12), true);
+}
+
 int rvu_mbox_handler_get_hw_cap(struct rvu *rvu, struct msg_req *req,
 				struct get_hw_cap_rsp *rsp)
 {
@@ -2068,6 +2075,65 @@ int rvu_mbox_handler_set_vf_perm(struct rvu *rvu, struct set_vf_perm *req,
 	return 0;
 }
 
+int rvu_mbox_handler_ndc_sync_op(struct rvu *rvu,
+				 struct ndc_sync_op *req,
+				 struct msg_rsp *rsp)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+	u16 pcifunc = req->hdr.pcifunc;
+	int err, lfidx, lfblkaddr;
+
+	if (req->npa_lf_sync) {
+		/* Get NPA LF data */
+		lfblkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPA, pcifunc);
+		if (lfblkaddr < 0)
+			return NPA_AF_ERR_AF_LF_INVALID;
+
+		lfidx = rvu_get_lf(rvu, &hw->block[lfblkaddr], pcifunc, 0);
+		if (lfidx < 0)
+			return NPA_AF_ERR_AF_LF_INVALID;
+
+		/* Sync NPA NDC */
+		err = rvu_ndc_sync(rvu, lfblkaddr,
+				   lfidx, NPA_AF_NDC_SYNC);
+		if (err)
+			dev_err(rvu->dev,
+				"NDC-NPA sync failed for LF %u\n", lfidx);
+	}
+
+	if (!req->nix_lf_tx_sync && !req->nix_lf_rx_sync)
+		return 0;
+
+	/* Get NIX LF data */
+	lfblkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+	if (lfblkaddr < 0)
+		return NIX_AF_ERR_AF_LF_INVALID;
+
+	lfidx = rvu_get_lf(rvu, &hw->block[lfblkaddr], pcifunc, 0);
+	if (lfidx < 0)
+		return NIX_AF_ERR_AF_LF_INVALID;
+
+	if (req->nix_lf_tx_sync) {
+		/* Sync NIX TX NDC */
+		err = rvu_ndc_sync(rvu, lfblkaddr,
+				   lfidx, NIX_AF_NDC_TX_SYNC);
+		if (err)
+			dev_err(rvu->dev,
+				"NDC-NIX-TX sync fail for LF %u\n", lfidx);
+	}
+
+	if (req->nix_lf_rx_sync) {
+		/* Sync NIX RX NDC */
+		err = rvu_ndc_sync(rvu, lfblkaddr,
+				   lfidx, NIX_AF_NDC_RX_SYNC);
+		if (err)
+			dev_err(rvu->dev,
+				"NDC-NIX-RX sync failed for LF %u\n", lfidx);
+	}
+
+	return 0;
+}
+
 static int rvu_process_mbox_msg(struct otx2_mbox *mbox, int devid,
 				struct mbox_msghdr *req)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 3063a84..03ee93f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -800,6 +800,7 @@ int rvu_lf_reset(struct rvu *rvu, struct rvu_block *block, int lf);
 int rvu_get_blkaddr(struct rvu *rvu, int blktype, u16 pcifunc);
 int rvu_poll_reg(struct rvu *rvu, u64 block, u64 offset, u64 mask, bool zero);
 int rvu_get_num_lbk_chans(void);
+int rvu_ndc_sync(struct rvu *rvu, int lfblkid, int lfidx, u64 lfoffset);
 int rvu_get_blkaddr_from_slot(struct rvu *rvu, int blktype, u16 pcifunc,
 			      u16 global_slot, u16 *slot_in_block);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 00af888..4dbbaa7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2497,9 +2497,7 @@ static int nix_txschq_free(struct rvu *rvu, u16 pcifunc)
 	}
 	mutex_unlock(&rvu->rsrc_lock);
 
-	/* Sync cached info for this LF in NDC-TX to LLC/DRAM */
-	rvu_write64(rvu, blkaddr, NIX_AF_NDC_TX_SYNC, BIT_ULL(12) | nixlf);
-	err = rvu_poll_reg(rvu, blkaddr, NIX_AF_NDC_TX_SYNC, BIT_ULL(12), true);
+	err = rvu_ndc_sync(rvu, blkaddr, nixlf, NIX_AF_NDC_TX_SYNC);
 	if (err)
 		dev_err(rvu->dev, "NDC-TX sync failed for NIXLF %d\n", nixlf);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
index 5ec9265..d56be5f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
@@ -121,6 +121,7 @@
 #define NPA_AF_LF_RST                   (0x0020)
 #define NPA_AF_GEN_CFG                  (0x0030)
 #define NPA_AF_NDC_CFG                  (0x0040)
+#define NPA_AF_NDC_SYNC                 (0x0050)
 #define NPA_AF_INP_CTL                  (0x00D0)
 #define NPA_AF_ACTIVE_CYCLES_PC         (0x00F0)
 #define NPA_AF_AVG_DELAY                (0x0100)
@@ -239,6 +240,7 @@
 #define NIX_AF_RX_CPTX_INST_ADDR	(0x0310)
 #define NIX_AF_RX_CPTX_INST_QSEL(a)	(0x0320ull | (uint64_t)(a) << 3)
 #define NIX_AF_RX_CPTX_CREDIT(a)	(0x0360ull | (uint64_t)(a) << 3)
+#define NIX_AF_NDC_RX_SYNC		(0x03E0)
 #define NIX_AF_NDC_TX_SYNC		(0x03F0)
 #define NIX_AF_AQ_CFG			(0x0400)
 #define NIX_AF_AQ_BASE			(0x0410)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ff05ea2..5492dea 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3245,6 +3245,29 @@ static int otx2_sriov_configure(struct pci_dev *pdev, int numvfs)
 		return otx2_sriov_enable(pdev, numvfs);
 }
 
+static void otx2_ndc_sync(struct otx2_nic *pf)
+{
+	struct mbox *mbox = &pf->mbox;
+	struct ndc_sync_op *req;
+
+	mutex_lock(&mbox->lock);
+
+	req = otx2_mbox_alloc_msg_ndc_sync_op(mbox);
+	if (!req) {
+		mutex_unlock(&mbox->lock);
+		return;
+	}
+
+	req->nix_lf_tx_sync = 1;
+	req->nix_lf_rx_sync = 1;
+	req->npa_lf_sync = 1;
+
+	if (!otx2_sync_mbox_msg(mbox))
+		dev_err(pf->dev, "NDC sync operation failed\n");
+
+	mutex_unlock(&mbox->lock);
+}
+
 static void otx2_remove(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
@@ -3293,6 +3316,7 @@ static void otx2_remove(struct pci_dev *pdev)
 	otx2_mcam_flow_del(pf);
 	otx2_shutdown_tc(pf);
 	otx2_shutdown_qos(pf);
+	otx2_ndc_sync(pf);
 	otx2_detach_resources(&pf->mbox);
 	if (pf->hw.lmt_info)
 		free_percpu(pf->hw.lmt_info);
-- 
2.7.4


