Return-Path: <netdev+bounces-125783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D968896E8EE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AE02864BB
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 05:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3413B2BB;
	Fri,  6 Sep 2024 04:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="W2GxPO6N"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89EB53376;
	Fri,  6 Sep 2024 04:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725598741; cv=none; b=Dabe2hXI3qvTliSWezgJ4r9RwT0LmS8XX6NKAC6zzlw+47kltX5VF1j5eK25tcIS2E54UuIDyELkwIX2ZnxFU1cLsiwxMIVijSEwXFtIvrOC/OFzt9pTAFFkRBTa93qWKkkTNmBgbm/T258Wo4HxeuUJE9c+W66CVcLVwvaVDss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725598741; c=relaxed/simple;
	bh=ALtOr/yvwRsUSZIQfHRKAc9NNI/b66HvWYWhH2NBJ/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZFKPTOhcCpvPVNj7rzGFAVM0LWrX+Azdk9keCkZ9Dehc1ALaoTCL17e/krtDtPOvXNX86gr9fdjRkicB9S3iQNj/KKomqov+1EuUwPeDBFYiSEgaANcmWqs82JklMSEE2eWE8PqdQIhAsaIEy3YWMImjf347U65HVmh7BPF1HHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=W2GxPO6N; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4861IBGc005747;
	Thu, 5 Sep 2024 21:58:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=OgLgWktd5YuA9gsUsQMmuQZ
	wBllmUVl9+f1MkUXajUc=; b=W2GxPO6NOmouCfd6pAzK35bN3BoMg/hJxRIcfLX
	cwisU47XW30ThVtk2eJJr0MdA14hblbs17Nwnu5BIjKaJ+LGt1HoiSfHhHW+C2JQ
	MJWV1QSzg3gA6qFRabfasyGMIYJXJeMfh7CuYejleeTyvg251vkjNDb2EzGJgaLT
	0RGU1Dk1cz6eEVEoAYUxJ9GYxVKOO3Dkxq/jssq0aVBpp7llCPQ51cGBX0bXv+7x
	+PLMvGgRIs8fd68sLDBffJHDEAsjg7QS4DPz76Di5TtDSCITQMolqiwmoMiFmjd0
	i8y1mPRdcBX8BtDi/qOuBlDcJ7UBSqWP6mevuxLsc59uu8g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41fqxs0hj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 21:58:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 5 Sep 2024 21:58:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 21:58:45 -0700
Received: from naveenm-PowerEdge-T630.marvell.com (unknown [10.29.37.44])
	by maili.marvell.com (Postfix) with ESMTP id A447E3F704B;
	Thu,  5 Sep 2024 21:58:41 -0700 (PDT)
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>
CC: Naveen Mamindlapalli <naveenm@marvell.com>
Subject: [net PATCH] octeontx2-af: Modify SMQ flush sequence to drop packets
Date: Fri, 6 Sep 2024 10:28:38 +0530
Message-ID: <20240906045838.1620308-1-naveenm@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: eBdt-tzTL6n6W3M0ATpZmGcVvWNBBOGJ
X-Proofpoint-ORIG-GUID: eBdt-tzTL6n6W3M0ATpZmGcVvWNBBOGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01

The current implementation of SMQ flush sequence waits for the packets
in the TM pipeline to be transmitted out of the link. This sequence
doesn't succeed in HW when there is any issue with link such as lack of
link credits, link down or any other traffic that is fully occupying the
link bandwidth (QoS). This patch modifies the SMQ flush sequence to
drop the packets after TL1 level (SQM) instead of polling for the packets
to be sent out of RPM/CGX link.

Fixes: 5d9b976d4480 ("octeontx2-af: Support fixed transmit scheduler topology")
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
Reviewed-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  3 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 59 +++++++++++++++----
 2 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 03ee93fd9e94..db2db0738ee4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -319,6 +319,7 @@ struct nix_mark_format {
 
 /* smq(flush) to tl1 cir/pir info */
 struct nix_smq_tree_ctx {
+	u16 schq;
 	u64 cir_off;
 	u64 cir_val;
 	u64 pir_off;
@@ -328,8 +329,6 @@ struct nix_smq_tree_ctx {
 /* smq flush context */
 struct nix_smq_flush_ctx {
 	int smq;
-	u16 tl1_schq;
-	u16 tl2_schq;
 	struct nix_smq_tree_ctx smq_tree_ctx[NIX_TXSCH_LVL_CNT];
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 222f9e00b836..82832a24fbd8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2259,14 +2259,13 @@ static void nix_smq_flush_fill_ctx(struct rvu *rvu, int blkaddr, int smq,
 	schq = smq;
 	for (lvl = NIX_TXSCH_LVL_SMQ; lvl <= NIX_TXSCH_LVL_TL1; lvl++) {
 		smq_tree_ctx = &smq_flush_ctx->smq_tree_ctx[lvl];
+		smq_tree_ctx->schq = schq;
 		if (lvl == NIX_TXSCH_LVL_TL1) {
-			smq_flush_ctx->tl1_schq = schq;
 			smq_tree_ctx->cir_off = NIX_AF_TL1X_CIR(schq);
 			smq_tree_ctx->pir_off = 0;
 			smq_tree_ctx->pir_val = 0;
 			parent_off = 0;
 		} else if (lvl == NIX_TXSCH_LVL_TL2) {
-			smq_flush_ctx->tl2_schq = schq;
 			smq_tree_ctx->cir_off = NIX_AF_TL2X_CIR(schq);
 			smq_tree_ctx->pir_off = NIX_AF_TL2X_PIR(schq);
 			parent_off = NIX_AF_TL2X_PARENT(schq);
@@ -2301,8 +2300,8 @@ static void nix_smq_flush_enadis_xoff(struct rvu *rvu, int blkaddr,
 {
 	struct nix_txsch *txsch;
 	struct nix_hw *nix_hw;
+	int tl2, tl2_schq;
 	u64 regoff;
-	int tl2;
 
 	nix_hw = get_nix_hw(rvu->hw, blkaddr);
 	if (!nix_hw)
@@ -2310,16 +2309,17 @@ static void nix_smq_flush_enadis_xoff(struct rvu *rvu, int blkaddr,
 
 	/* loop through all TL2s with matching PF_FUNC */
 	txsch = &nix_hw->txsch[NIX_TXSCH_LVL_TL2];
+	tl2_schq = smq_flush_ctx->smq_tree_ctx[NIX_TXSCH_LVL_TL2].schq;
 	for (tl2 = 0; tl2 < txsch->schq.max; tl2++) {
 		/* skip the smq(flush) TL2 */
-		if (tl2 == smq_flush_ctx->tl2_schq)
+		if (tl2 == tl2_schq)
 			continue;
 		/* skip unused TL2s */
 		if (TXSCH_MAP_FLAGS(txsch->pfvf_map[tl2]) & NIX_TXSCHQ_FREE)
 			continue;
 		/* skip if PF_FUNC doesn't match */
 		if ((TXSCH_MAP_FUNC(txsch->pfvf_map[tl2]) & ~RVU_PFVF_FUNC_MASK) !=
-		    (TXSCH_MAP_FUNC(txsch->pfvf_map[smq_flush_ctx->tl2_schq] &
+		    (TXSCH_MAP_FUNC(txsch->pfvf_map[tl2_schq] &
 				    ~RVU_PFVF_FUNC_MASK)))
 			continue;
 		/* enable/disable XOFF */
@@ -2361,10 +2361,12 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 			 int smq, u16 pcifunc, int nixlf)
 {
 	struct nix_smq_flush_ctx *smq_flush_ctx;
+	int err, restore_tx_en = 0, i;
 	int pf = rvu_get_pf(pcifunc);
 	u8 cgx_id = 0, lmac_id = 0;
-	int err, restore_tx_en = 0;
-	u64 cfg;
+	u16 tl2_tl3_link_schq;
+	u8 link, link_level;
+	u64 cfg, bmap = 0;
 
 	if (!is_rvu_otx2(rvu)) {
 		/* Skip SMQ flush if pkt count is zero */
@@ -2388,16 +2390,38 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 	nix_smq_flush_enadis_xoff(rvu, blkaddr, smq_flush_ctx, true);
 	nix_smq_flush_enadis_rate(rvu, blkaddr, smq_flush_ctx, false);
 
-	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq));
-	/* Do SMQ flush and set enqueue xoff */
-	cfg |= BIT_ULL(50) | BIT_ULL(49);
-	rvu_write64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq), cfg);
-
 	/* Disable backpressure from physical link,
 	 * otherwise SMQ flush may stall.
 	 */
 	rvu_cgx_enadis_rx_bp(rvu, pf, false);
 
+	link_level = rvu_read64(rvu, blkaddr, NIX_AF_PSE_CHANNEL_LEVEL) & 0x01 ?
+			NIX_TXSCH_LVL_TL3 : NIX_TXSCH_LVL_TL2;
+	tl2_tl3_link_schq = smq_flush_ctx->smq_tree_ctx[link_level].schq;
+	link = smq_flush_ctx->smq_tree_ctx[NIX_TXSCH_LVL_TL1].schq;
+
+	/* SMQ set enqueue xoff */
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq));
+	cfg |= BIT_ULL(50);
+	rvu_write64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq), cfg);
+
+	/* Clear all NIX_AF_TL3_TL2_LINK_CFG[ENA] for the TL3/TL2 queue */
+	for (i = 0; i < (rvu->hw->cgx_links + rvu->hw->lbk_links); i++) {
+		cfg = rvu_read64(rvu, blkaddr,
+				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
+		if (!(cfg & BIT_ULL(12)))
+			continue;
+		bmap |= (1 << i);
+		cfg &= ~BIT_ULL(12);
+		rvu_write64(rvu, blkaddr,
+			    NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link), cfg);
+	}
+
+	/* Do SMQ flush and set enqueue xoff */
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq));
+	cfg |= BIT_ULL(50) | BIT_ULL(49);
+	rvu_write64(rvu, blkaddr, NIX_AF_SMQX_CFG(smq), cfg);
+
 	/* Wait for flush to complete */
 	err = rvu_poll_reg(rvu, blkaddr,
 			   NIX_AF_SMQX_CFG(smq), BIT_ULL(49), true);
@@ -2406,6 +2430,17 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
 			 "NIXLF%d: SMQ%d flush failed, txlink might be busy\n",
 			 nixlf, smq);
 
+	/* Set NIX_AF_TL3_TL2_LINKX_CFG[ENA] for the TL3/TL2 queue */
+	for (i = 0; i < (rvu->hw->cgx_links + rvu->hw->lbk_links); i++) {
+		if (!(bmap & (1 << i)))
+			continue;
+		cfg = rvu_read64(rvu, blkaddr,
+				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
+		cfg |= BIT_ULL(12);
+		rvu_write64(rvu, blkaddr,
+			    NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link), cfg);
+	}
+
 	/* clear XOFF on TL2s */
 	nix_smq_flush_enadis_rate(rvu, blkaddr, smq_flush_ctx, true);
 	nix_smq_flush_enadis_xoff(rvu, blkaddr, smq_flush_ctx, false);
-- 
2.34.1


