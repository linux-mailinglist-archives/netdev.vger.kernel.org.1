Return-Path: <netdev+bounces-123155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613A2963E13
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF6D280401
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D718A926;
	Thu, 29 Aug 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BO+1Ry+n"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A8018A6BC
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919005; cv=none; b=Z+hHzdcmgOMdNrAizmjINaX2cn73D1VOG9ak8aG6kwg5xqeJx21Xnz9ZVGUgClsQHTbOyFlswC5wjN6UJgRGT1/JvhVgGvTaU0tvpaE+rPzhngpg2Iw/WVX1MpQEhGqD026gtcLxaT3ixY4CScCfUjmBYnpBtyx2rkAbRNyFs9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919005; c=relaxed/simple;
	bh=kOsfXUKetERzwUj9CvrWUaDEdtG6Dtm+MNVZFZZ3Mec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGcP47BuRiTB/JY/LAnsOJ9tYajWSciBKy4709kVA6h/lfU27uNCyVFB8uYkRfKrcxE7WUGyrpC2xYKe+6UTI6XI0FXGTJLMUW99irOcRfAmgl2qab7CXpzEQJlVUOwWu+zIHftQb6/rdKp3DpPvsxDjkdw34f89NZokHJfKhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BO+1Ry+n; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T4YVAO022963;
	Thu, 29 Aug 2024 01:09:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
	PBazmtglE4ez1Gmy4g3xUjuCKNC/wVzHoleESjDwZg=; b=BO+1Ry+n9BWY202el
	aMwpAOwZC7/ow9M4UTwwM7/77Hc1xLoWeNg9fLTsF71lJGfWk5gPxhEs9mTQ0uQA
	iD+rqyU2WIVFz1f/jmy+JoM7V64GeptsXqihUN8Spo9IxXLKjkE6ZXCSJcDnIpvr
	H2z7r2m8SXLKi1q/Ux1NsumTgwOXQs8/8UqapQBhje7mhaiRv3HS0X59Fc8+9pt9
	wtr7XSsIOSfoqwNBMHz9rG9L003ShmGiEbH1VoLHFqgtLxh06hRFYCaDAjWNDk+z
	WD+yIx9wJQ6TteQEarr2iTxZqhKklbxQVyZlcSFEFwWpfVuYkG2QOBA550zD8ce/
	JYBpQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41aj340r3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 01:09:51 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 Aug 2024 01:09:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 01:09:50 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 6174F3F70A0;
	Thu, 29 Aug 2024 01:09:46 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <bbhushan2@marvell.com>,
        <ndabilpuram@marvell.com>, <schalla@marvell.com>
Subject: [PATCH net-next,v2,2/3] octeontx2-af: avoid RXC register access for CN10KB
Date: Thu, 29 Aug 2024 13:39:34 +0530
Message-ID: <20240829080935.371281-3-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829080935.371281-1-schalla@marvell.com>
References: <20240829080935.371281-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: CcvEYt0oWNDFOpW3HvvQxNw42IunFZ1y
X-Proofpoint-ORIG-GUID: CcvEYt0oWNDFOpW3HvvQxNw42IunFZ1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01

This patch modifies the driver to prevent access to RXC hardware
registers on the CN10KB, as RXC is not available on this chip.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h | 10 ++++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu_cpt.c | 17 ++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 03ee93fd9e94..64c9c9ee000d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -400,6 +400,7 @@ struct hw_cap {
 	bool	nix_multiple_dwrr_mtu;   /* Multiple DWRR_MTU to choose from */
 	bool	npc_hash_extract; /* Hash extract enabled ? */
 	bool	npc_exact_match_enabled; /* Exact match supported ? */
+	bool    cpt_rxc;   /* Is CPT-RXC supported */
 };
 
 struct rvu_hwinfo {
@@ -690,6 +691,15 @@ static inline bool is_cnf10ka_a0(struct rvu *rvu)
 	return false;
 }
 
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
index cd5b21cb0427..d44614a63a7b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -789,6 +789,8 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 
 static void get_ctx_pc(struct rvu *rvu, struct cpt_sts_rsp *rsp, int blkaddr)
 {
+	struct rvu_hwinfo *hw = rvu->hw;
+
 	if (is_rvu_otx2(rvu))
 		return;
 
@@ -812,14 +814,16 @@ static void get_ctx_pc(struct rvu *rvu, struct cpt_sts_rsp *rsp, int blkaddr)
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
@@ -1004,10 +1008,11 @@ int rvu_mbox_handler_cpt_flt_eng_info(struct rvu *rvu, struct cpt_flt_eng_info_r
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
@@ -1282,8 +1287,14 @@ int rvu_cpt_ctx_flush(struct rvu *rvu, u16 pcifunc)
 
 int rvu_cpt_init(struct rvu *rvu)
 {
+	struct rvu_hwinfo *hw = rvu->hw;
+
 	/* Retrieve CPT PF number */
 	rvu->cpt_pf_num = get_cpt_pf_num(rvu);
+	if (is_block_implemented(rvu->hw, BLKADDR_CPT0) && !is_rvu_otx2(rvu) &&
+	    !is_cn10kb(rvu))
+		hw->cap.cpt_rxc = true;
+
 	spin_lock_init(&rvu->cpt_intr_lock);
 
 	return 0;
-- 
2.25.1


