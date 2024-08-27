Return-Path: <netdev+bounces-122136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571F1960040
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 06:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF6B1C21022
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 04:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CB02260C;
	Tue, 27 Aug 2024 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IpDfXoMA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5B523BB
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724732738; cv=none; b=U/DIsvh+C9DXVI075+af4K8OOMOgS20/QwX7uHXq4GaGZvtYKip0bON6tAY5wBF6Rz/jtfwfASoehjLvdxAYZmVKPU9lZ+UgpKJzDgFXtll9Yq31xzgIP+0mJhBfbRCRREQTM4nQct3HYYHsVMG8Zbunxv72U9kO14JdRh6MyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724732738; c=relaxed/simple;
	bh=qAoIphJnAgHZC94D2KaEbbrWjI8u3EsvL+ItPyubzn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kas7Cc9hCSB9s1vYzt2Oc1Ac8e+YOZPhSAw5vGn6U/zThWDUg1a6pWraQtDoIrwmVk6B67AhaFDFO/m0r2eSPfcsYT9qZVJ+LOlFC0rJzg74Gyw5d8U6JoPBGuiHGZDbEdCg4izTNpa/966VxSWFcn0hh8agcqQwtg9P+M0WPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IpDfXoMA; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1vSRW027979;
	Mon, 26 Aug 2024 21:25:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
	J8ks/d3fhy4e4mgQkHA6d18/SpLzerT7vxL1yS6V1I=; b=IpDfXoMAcRjk1/Gw3
	+7JAQJtJLNAkK/XqsE7RiurwgSa+0dXVcVJgncJztMnJpsuDh7Irq7kKTuVSUKDi
	FP5o+MprzhrWI06i5+n8n8DUo8BAVBK1XwjcBquZhSQ8R7KZt+/5vSAvghaPPiNe
	u4om3roWd5Np0zOhTiExAtY9q1Cpm7uVKAQ62dfAUb4efbbx6sI5sPqOZfxJrImX
	HnE0peohuJuCAozq5o0g/ZSP1wNyc80dEQJQFG0w7hHGe1mqomAzBL2/n0wplj0a
	qyPEpvTVVSLv47kbvBQ8Kl3J40YeuwuwFTvfkQ9A7BdVmRCp/rg4ydrK3E/zdU/q
	q6orw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4195kggdmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 21:25:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 Aug 2024 21:25:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 Aug 2024 21:25:27 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 49BA55C68E4;
	Mon, 26 Aug 2024 21:25:23 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <bbhushan2@marvell.com>,
        <ndabilpuram@marvell.com>
Subject: [PATCH net-next,2/2] octeontx2-af: configure default CPT credits
Date: Tue, 27 Aug 2024 09:55:12 +0530
Message-ID: <20240827042512.216634-3-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827042512.216634-1-schalla@marvell.com>
References: <20240827042512.216634-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: M6pCiU8H28OEz2sx8p02n5VdTDDc6zk6
X-Proofpoint-ORIG-GUID: M6pCiU8H28OEz2sx8p02n5VdTDDc6zk6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_02,2024-08-26_01,2024-05-17_01

The maximum CPT credits that RX can use are now configurable through
a hardware CSR. This patch sets the default value to optimize peak
performance, aligning it with other chip versions.
This patch also adds changes to avoid RXC HW registers access on
CN10KB as RXC is not available on CN10KB.

Signed-off-by: Srujana Challa <schalla@marvell.com>
Signed-off-by: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   | 30 +++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 29 ++++++++++++++++--
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |  1 +
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 03ee93fd9e94..43b1d83686d1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -400,6 +400,7 @@ struct hw_cap {
 	bool	nix_multiple_dwrr_mtu;   /* Multiple DWRR_MTU to choose from */
 	bool	npc_hash_extract; /* Hash extract enabled ? */
 	bool	npc_exact_match_enabled; /* Exact match supported ? */
+	bool    cpt_rxc;   /* Is CPT-RXC supported */
 };
 
 struct rvu_hwinfo {
@@ -690,6 +691,35 @@ static inline bool is_cnf10ka_a0(struct rvu *rvu)
 	return false;
 }
 
+static inline bool is_cn10ka_a0(struct rvu *rvu)
+{
+	struct pci_dev *pdev = rvu->pdev;
+
+	if (pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A &&
+	    (pdev->revision & 0x0F) == 0x0)
+		return true;
+	return false;
+}
+
+static inline bool is_cn10ka_a1(struct rvu *rvu)
+{
+	struct pci_dev *pdev = rvu->pdev;
+
+	if (pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A &&
+	    (pdev->revision & 0x0F) == 0x1)
+		return true;
+	return false;
+}
+
+static inline bool is_cn10kb(struct rvu *rvu)
+{
+	struct pci_dev *pdev = rvu->pdev;
+
+	if (pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_B)
+		return true;
+	return false;
+}
+
 static inline bool is_rvu_npc_hash_extract_en(struct rvu *rvu)
 {
 	u64 npc_const3;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index e56d27018828..e0438b819309 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -728,6 +728,7 @@ static bool is_valid_offset(struct rvu *rvu, struct cpt_rd_wr_reg_msg *req)
 		case CPT_AF_BLK_RST:
 		case CPT_AF_CONSTANTS1:
 		case CPT_AF_CTX_FLUSH_TIMER:
+		case CPT_AF_RXC_CFG1:
 			return true;
 		}
 
@@ -788,6 +789,8 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 
 static void get_ctx_pc(struct rvu *rvu, struct cpt_sts_rsp *rsp, int blkaddr)
 {
+	struct rvu_hwinfo *hw = rvu->hw;
+
 	if (is_rvu_otx2(rvu))
 		return;
 
@@ -811,14 +814,16 @@ static void get_ctx_pc(struct rvu *rvu, struct cpt_sts_rsp *rsp, int blkaddr)
 	rsp->ctx_err = rvu_read64(rvu, blkaddr, CPT_AF_CTX_ERR);
 	rsp->ctx_enc_id = rvu_read64(rvu, blkaddr, CPT_AF_CTX_ENC_ID);
 	rsp->ctx_flush_timer = rvu_read64(rvu, blkaddr, CPT_AF_CTX_FLUSH_TIMER);
+	rsp->x2p_link_cfg0 = rvu_read64(rvu, blkaddr, CPT_AF_X2PX_LINK_CFG(0));
+	rsp->x2p_link_cfg1 = rvu_read64(rvu, blkaddr, CPT_AF_X2PX_LINK_CFG(1));
 
+	if (!hw->cap.cpt_rxc)
+		return;
 	rsp->rxc_time = rvu_read64(rvu, blkaddr, CPT_AF_RXC_TIME);
 	rsp->rxc_time_cfg = rvu_read64(rvu, blkaddr, CPT_AF_RXC_TIME_CFG);
 	rsp->rxc_active_sts = rvu_read64(rvu, blkaddr, CPT_AF_RXC_ACTIVE_STS);
 	rsp->rxc_zombie_sts = rvu_read64(rvu, blkaddr, CPT_AF_RXC_ZOMBIE_STS);
 	rsp->rxc_dfrg = rvu_read64(rvu, blkaddr, CPT_AF_RXC_DFRG);
-	rsp->x2p_link_cfg0 = rvu_read64(rvu, blkaddr, CPT_AF_X2PX_LINK_CFG(0));
-	rsp->x2p_link_cfg1 = rvu_read64(rvu, blkaddr, CPT_AF_X2PX_LINK_CFG(1));
 }
 
 static void get_eng_sts(struct rvu *rvu, struct cpt_sts_rsp *rsp, int blkaddr)
@@ -999,10 +1004,11 @@ int rvu_mbox_handler_cpt_flt_eng_info(struct rvu *rvu, struct cpt_flt_eng_info_r
 static void cpt_rxc_teardown(struct rvu *rvu, int blkaddr)
 {
 	struct cpt_rxc_time_cfg_req req, prev;
+	struct rvu_hwinfo *hw = rvu->hw;
 	int timeout = 2000;
 	u64 reg;
 
-	if (is_rvu_otx2(rvu))
+	if (!hw->cap.cpt_rxc)
 		return;
 
 	/* Set time limit to minimum values, so that rxc entries will be
@@ -1277,8 +1283,25 @@ int rvu_cpt_ctx_flush(struct rvu *rvu, u16 pcifunc)
 
 int rvu_cpt_init(struct rvu *rvu)
 {
+	struct rvu_hwinfo *hw = rvu->hw;
+	u64 reg_val;
+
 	/* Retrieve CPT PF number */
 	rvu->cpt_pf_num = get_cpt_pf_num(rvu);
+	if (is_block_implemented(rvu->hw, BLKADDR_CPT0) && !is_rvu_otx2(rvu) &&
+	    !is_cn10kb(rvu))
+		hw->cap.cpt_rxc = true;
+
+	if (hw->cap.cpt_rxc && !is_cn10ka_a0(rvu) && !is_cn10ka_a1(rvu)) {
+		/* Set CPT_AF_RXC_CFG1:max_rxc_icb_cnt to 0xc0 to not effect
+		 * inline inbound peak performance
+		 */
+		reg_val = rvu_read64(rvu, BLKADDR_CPT0, CPT_AF_RXC_CFG1);
+		reg_val &= ~(0x1FFULL << 32);
+		reg_val |= 0xC0ULL << 32;
+		rvu_write64(rvu, BLKADDR_CPT0, CPT_AF_RXC_CFG1, reg_val);
+	}
+
 	spin_lock_init(&rvu->cpt_intr_lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
index d56be5fb7eb4..2b299fa85159 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
@@ -545,6 +545,7 @@
 #define CPT_AF_CTX_PSH_PC               (0x49450ull)
 #define CPT_AF_CTX_PSH_LATENCY_PC       (0x49458ull)
 #define CPT_AF_CTX_CAM_DATA(a)          (0x49800ull | (u64)(a) << 3)
+#define CPT_AF_RXC_CFG1                 (0x50000ull)
 #define CPT_AF_RXC_TIME                 (0x50010ull)
 #define CPT_AF_RXC_TIME_CFG             (0x50018ull)
 #define CPT_AF_RXC_DFRG                 (0x50020ull)
-- 
2.25.1


