Return-Path: <netdev+bounces-123154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7628963E12
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F474B2187D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2926B18A6A6;
	Thu, 29 Aug 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aHbD+2Y/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687B16EB50
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919004; cv=none; b=T0DMAouP0RfIKmx08kmOg/YfwrmV4r+UvSQcr4iFAM4TJR5wu9VA4oWZGUL5yWSI31TY2dYfpQzWzIsKk4SADLG4XxoZQPVzzRHFeHBxLI6ujHh+AB++cY4vxMUXYRfjyjsoQJ40IceerDMRjiTGLsmx1wMUwxnpFvN2GM41IdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919004; c=relaxed/simple;
	bh=EjWeQvj0yGL7CHmAG5hKQk/M4TOgg+0tDZ6I46QTZAI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjhmBQuqmlwLUnuuSvywUJH+VeqKFswUHPuid6JvP3iLXiwLBRgdaxRQc5k/ffe0EZydSb0b3Nkg0TKequUXCfMBScE/EkrR7I0Lng8VNqIDQvZPV2GgO6p+tLVnJkl0GmznsSyOn1iLAhCZV1XxMLsWhJUjijF0b8m1hB+Rq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=aHbD+2Y/; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T4YW5v023001;
	Thu, 29 Aug 2024 01:09:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	bN9yarcq0dwcyInPL2OY+ckL7lQqkfliKhVy+edIqU=; b=aHbD+2Y/MDdN5CANJ
	mOPf8EZsBeKtoj5DXSW9mU43V7bVky9mbDIGICbqd7Z4RFQ8QLKZYcP43GGDf611
	RfXs+RdHLEb8aD7qkVjDR/clj9HSMhZOoq+Os6T/oFPsGlDgep98UUvCSiUmoIEN
	zoecIvfwo8VKlxCypKIK8W0MVQcLsX6QAhq9xTJSvdV05t4guUFLSl3cWyEbkzBi
	wQEaIyp3IrjTe2Oe6m6eWmuCZlH5lh9erqgV01Z6IF842IpwXm17iGigdCDjf5Gn
	pWqtfS4H9rOg3Ahqgh2KzFTQ0fjvQqbzyQfvX9vtjvl8jk64Co+o90wHgqY0m/4B
	DI4vg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41aj340r3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 01:09:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 Aug 2024 01:09:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 01:09:55 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 38AC83F70A0;
	Thu, 29 Aug 2024 01:09:50 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <bbhushan2@marvell.com>,
        <ndabilpuram@marvell.com>, <schalla@marvell.com>
Subject: [PATCH net-next,v2,3/3] octeontx2-af: configure default CPT credits for CN10KA B0
Date: Thu, 29 Aug 2024 13:39:35 +0530
Message-ID: <20240829080935.371281-4-schalla@marvell.com>
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
X-Proofpoint-GUID: BCC7x9r-PMVl9snOa5vkcuwZdGDjx_Bm
X-Proofpoint-ORIG-GUID: BCC7x9r-PMVl9snOa5vkcuwZdGDjx_Bm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01

The maximum CPT credits that RXC can use are now configurable on CN10KA B0
through a hardware CSR. This patch sets the default value to optimize peak
performance, aligning it with other chip versions.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   | 20 +++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 18 +++++++++++++++++
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |  1 +
 3 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 64c9c9ee000d..43b1d83686d1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -691,6 +691,26 @@ static inline bool is_cnf10ka_a0(struct rvu *rvu)
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
 static inline bool is_cn10kb(struct rvu *rvu)
 {
 	struct pci_dev *pdev = rvu->pdev;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index d44614a63a7b..3c5bbaf12e59 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -22,6 +22,9 @@
 /* Interrupt vector count of CPT RVU and RAS interrupts */
 #define CPT_10K_AF_RVU_RAS_INT_VEC_CNT  2
 
+/* Default CPT_AF_RXC_CFG1:max_rxc_icb_cnt */
+#define CPT_DFLT_MAX_RXC_ICB_CNT  0xC0ULL
+
 #define cpt_get_eng_sts(e_min, e_max, rsp, etype)                   \
 ({                                                                  \
 	u64 free_sts = 0, busy_sts = 0;                             \
@@ -737,6 +740,7 @@ static bool validate_and_update_reg_offset(struct rvu *rvu,
 		case CPT_AF_BLK_RST:
 		case CPT_AF_CONSTANTS1:
 		case CPT_AF_CTX_FLUSH_TIMER:
+		case CPT_AF_RXC_CFG1:
 			return true;
 		}
 
@@ -1285,9 +1289,12 @@ int rvu_cpt_ctx_flush(struct rvu *rvu, u16 pcifunc)
 	return 0;
 }
 
+#define MAX_RXC_ICB_CNT  GENMASK_ULL(40, 32)
+
 int rvu_cpt_init(struct rvu *rvu)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
+	u64 reg_val;
 
 	/* Retrieve CPT PF number */
 	rvu->cpt_pf_num = get_cpt_pf_num(rvu);
@@ -1295,6 +1302,17 @@ int rvu_cpt_init(struct rvu *rvu)
 	    !is_cn10kb(rvu))
 		hw->cap.cpt_rxc = true;
 
+	if (hw->cap.cpt_rxc && !is_cn10ka_a0(rvu) && !is_cn10ka_a1(rvu)) {
+		/* Set CPT_AF_RXC_CFG1:max_rxc_icb_cnt to 0xc0 to not effect
+		 * inline inbound peak performance
+		 */
+		reg_val = rvu_read64(rvu, BLKADDR_CPT0, CPT_AF_RXC_CFG1);
+		reg_val &= ~MAX_RXC_ICB_CNT;
+		reg_val |= FIELD_PREP(MAX_RXC_ICB_CNT,
+				      CPT_DFLT_MAX_RXC_ICB_CNT);
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


