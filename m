Return-Path: <netdev+bounces-123156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9678963E14
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582F61F2371D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2849418A936;
	Thu, 29 Aug 2024 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kobon4Kt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88F18A92B
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919008; cv=none; b=oRJ/BXO1L8aQWtkHO61CWQuTGPjgybn/xWus3hB7Ex9lVYUKZpfyFi1y9StAjrUY9xwEWnezABF8Hbo42utvisgDrrTtIov2bPByFaRM0GVCTHx2s1ox6dHsVlIG7K5do4H6o1KsTHHG2q5VOwL13Kw5n37YsuX0eIrDfaHNqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919008; c=relaxed/simple;
	bh=Kp8sHhzlu0a18sTulpLykdgkc/PNeIqSoSjcYHVUSEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fckmFAGp0dYLxJM+yeiAYAZNtOoZgaamw2HwzazxqdU9ZWXTe8EP5/uIvTl+oEbkLTzgoOWkaOzt6SbiW3WDIQZ/kSAvWJTRb9QXyyGVVrNCMw50ATSQcEwqlw6zlNktJ4cmYdpQoSwm3FDi3e4ACf5arUwtxqGFC/EuH2fogCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kobon4Kt; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T4Yxh2023415;
	Thu, 29 Aug 2024 01:09:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
	7tsSS4eSpMwRdzrgb9dxklxp9mWTUD+m5jBpdf4RvA=; b=kobon4KtU9D7iUP0P
	tSCe9WUJzNbkwPOd7c1hilL8s96RoZOz1MPbuTYWwvXjRNy+boA/35BiMj6xcJO9
	PJr5i+Nyag5TnN8DPwjw49VsiG+p7VHgu9KAmGWMe5UzKUH2xLeXNFnawUsYfcS9
	+8deLdMcSto6qxeB4ewyaviLtCMOYE8BHsYh6DTS/8OuBXfl2yMfOSmqfoN7sAqm
	2/1RYHedIcB7qGqz6vjsW6eapkBBqlDZGw9HT6FxkxDFEUQiJcvhfhlEbq8y5WdO
	XW604uTDO2XApSOGTzv23HtL9GiXBtpu45Sq8GwRzOmuXRFto/AWoYSNb3JxZe/j
	kBN2g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41aj340r38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 01:09:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 29 Aug 2024 01:09:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 01:09:46 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 8B9063F70A0;
	Thu, 29 Aug 2024 01:09:41 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <bbhushan2@marvell.com>,
        <ndabilpuram@marvell.com>, <schalla@marvell.com>
Subject: [PATCH net-next,v2,1/3] octeontx2-af: use dynamic interrupt vectors for CN10K
Date: Thu, 29 Aug 2024 13:39:33 +0530
Message-ID: <20240829080935.371281-2-schalla@marvell.com>
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
X-Proofpoint-GUID: ziXMdhfU-dujYKjknsl4t7purY2kZRcm
X-Proofpoint-ORIG-GUID: ziXMdhfU-dujYKjknsl4t7purY2kZRcm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01

This patch updates the driver to use a dynamic number of vectors instead
of a hard-coded value. This change accommodates the CN10KB, which has 2
vectors, unlike the previously supported chips that have 3 vectors.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  5 +-
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 89 ++++++++++++++++---
 .../marvell/octeontx2/af/rvu_struct.h         |  6 +-
 3 files changed, 80 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index ed2160cc5acb..6ea2f3071fe8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1856,8 +1856,9 @@ struct cpt_flt_eng_info_req {
 
 struct cpt_flt_eng_info_rsp {
 	struct mbox_msghdr hdr;
-	u64 flt_eng_map[CPT_10K_AF_INT_VEC_RVU];
-	u64 rcvrd_eng_map[CPT_10K_AF_INT_VEC_RVU];
+#define CPT_AF_MAX_FLT_INT_VECS 3
+	u64 flt_eng_map[CPT_AF_MAX_FLT_INT_VECS];
+	u64 rcvrd_eng_map[CPT_AF_MAX_FLT_INT_VECS];
 	u64 rsvd;
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index daf4b951e905..cd5b21cb0427 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -19,6 +19,9 @@
 /* Length of initial context fetch in 128 byte words */
 #define CPT_CTX_ILEN    1ULL
 
+/* Interrupt vector count of CPT RVU and RAS interrupts */
+#define CPT_10K_AF_RVU_RAS_INT_VEC_CNT  2
+
 #define cpt_get_eng_sts(e_min, e_max, rsp, etype)                   \
 ({                                                                  \
 	u64 free_sts = 0, busy_sts = 0;                             \
@@ -37,6 +40,41 @@
 	(_rsp)->free_sts_##etype = free_sts;                        \
 })
 
+#define MAX_AE  GENMASK_ULL(47, 32)
+#define MAX_IE  GENMASK_ULL(31, 16)
+#define MAX_SE  GENMASK_ULL(15, 0)
+
+static u16 cpt_max_engines_get(struct rvu *rvu)
+{
+	u16 max_ses, max_ies, max_aes;
+	u64 reg;
+
+	reg = rvu_read64(rvu, BLKADDR_CPT0, CPT_AF_CONSTANTS1);
+	max_ses = FIELD_GET(MAX_SE, reg);
+	max_ies = FIELD_GET(MAX_IE, reg);
+	max_aes = FIELD_GET(MAX_AE, reg);
+
+	return max_ses + max_ies + max_aes;
+}
+
+/* Number of flt interrupt vectors are depends on number of engines that the
+ * chip has. Each flt vector represents 64 engines.
+ */
+static int cpt_10k_flt_nvecs_get(struct rvu *rvu, u16 max_engs)
+{
+	int flt_vecs;
+
+	flt_vecs = DIV_ROUND_UP(max_engs, 64);
+
+	if (flt_vecs > CPT_10K_AF_INT_VEC_FLT_MAX) {
+		dev_warn_once(rvu->dev, "flt_vecs:%d exceeds the max vectors:%d\n",
+			      flt_vecs, CPT_10K_AF_INT_VEC_FLT_MAX);
+		flt_vecs = CPT_10K_AF_INT_VEC_FLT_MAX;
+	}
+
+	return flt_vecs;
+}
+
 static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
 {
 	struct rvu_block *block = ptr;
@@ -150,17 +188,26 @@ static void cpt_10k_unregister_interrupts(struct rvu_block *block, int off)
 {
 	struct rvu *rvu = block->rvu;
 	int blkaddr = block->addr;
-	int i;
+	int i, flt_vecs;
+	u16 max_engs;
+	u8 nr;
+
+	max_engs = cpt_max_engines_get(rvu);
+	flt_vecs = cpt_10k_flt_nvecs_get(rvu, max_engs);
 
 	/* Disable all CPT AF interrupts */
-	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(0), ~0ULL);
-	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(1), ~0ULL);
-	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(2), 0xFFFF);
+	for (i = CPT_10K_AF_INT_VEC_FLT0; i < flt_vecs; i++) {
+		nr = (max_engs > 64) ? 64 : max_engs;
+		max_engs -= nr;
+		rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(i),
+			    INTR_MASK(nr));
+	}
 
 	rvu_write64(rvu, blkaddr, CPT_AF_RVU_INT_ENA_W1C, 0x1);
 	rvu_write64(rvu, blkaddr, CPT_AF_RAS_INT_ENA_W1C, 0x1);
 
-	for (i = 0; i < CPT_10K_AF_INT_VEC_CNT; i++)
+	/* CPT AF interrupt vectors are flt_int, rvu_int and ras_int. */
+	for (i = 0; i < flt_vecs + CPT_10K_AF_RVU_RAS_INT_VEC_CNT; i++)
 		if (rvu->irq_allocated[off + i]) {
 			free_irq(pci_irq_vector(rvu->pdev, off + i), block);
 			rvu->irq_allocated[off + i] = false;
@@ -206,12 +253,18 @@ void rvu_cpt_unregister_interrupts(struct rvu *rvu)
 
 static int cpt_10k_register_interrupts(struct rvu_block *block, int off)
 {
+	int rvu_intr_vec, ras_intr_vec;
 	struct rvu *rvu = block->rvu;
 	int blkaddr = block->addr;
 	irq_handler_t flt_fn;
-	int i, ret;
+	int i, ret, flt_vecs;
+	u16 max_engs;
+	u8 nr;
+
+	max_engs = cpt_max_engines_get(rvu);
+	flt_vecs = cpt_10k_flt_nvecs_get(rvu, max_engs);
 
-	for (i = CPT_10K_AF_INT_VEC_FLT0; i < CPT_10K_AF_INT_VEC_RVU; i++) {
+	for (i = CPT_10K_AF_INT_VEC_FLT0; i < flt_vecs; i++) {
 		sprintf(&rvu->irq_name[(off + i) * NAME_SIZE], "CPTAF FLT%d", i);
 
 		switch (i) {
@@ -229,20 +282,24 @@ static int cpt_10k_register_interrupts(struct rvu_block *block, int off)
 						    flt_fn, &rvu->irq_name[(off + i) * NAME_SIZE]);
 		if (ret)
 			goto err;
-		if (i == CPT_10K_AF_INT_VEC_FLT2)
-			rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1S(i), 0xFFFF);
-		else
-			rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1S(i), ~0ULL);
+
+		nr = (max_engs > 64) ? 64 : max_engs;
+		max_engs -= nr;
+		rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1S(i),
+			    INTR_MASK(nr));
 	}
 
-	ret = rvu_cpt_do_register_interrupt(block, off + CPT_10K_AF_INT_VEC_RVU,
+	rvu_intr_vec = flt_vecs;
+	ras_intr_vec = rvu_intr_vec + 1;
+
+	ret = rvu_cpt_do_register_interrupt(block, off + rvu_intr_vec,
 					    rvu_cpt_af_rvu_intr_handler,
 					    "CPTAF RVU");
 	if (ret)
 		goto err;
 	rvu_write64(rvu, blkaddr, CPT_AF_RVU_INT_ENA_W1S, 0x1);
 
-	ret = rvu_cpt_do_register_interrupt(block, off + CPT_10K_AF_INT_VEC_RAS,
+	ret = rvu_cpt_do_register_interrupt(block, off + ras_intr_vec,
 					    rvu_cpt_af_ras_intr_handler,
 					    "CPTAF RAS");
 	if (ret)
@@ -921,13 +978,17 @@ int rvu_mbox_handler_cpt_flt_eng_info(struct rvu *rvu, struct cpt_flt_eng_info_r
 	struct rvu_block *block;
 	unsigned long flags;
 	int blkaddr, vec;
+	int flt_vecs;
+	u16 max_engs;
 
 	blkaddr = validate_and_get_cpt_blkaddr(req->blkaddr);
 	if (blkaddr < 0)
 		return blkaddr;
 
 	block = &rvu->hw->block[blkaddr];
-	for (vec = 0; vec < CPT_10K_AF_INT_VEC_RVU; vec++) {
+	max_engs = cpt_max_engines_get(rvu);
+	flt_vecs = cpt_10k_flt_nvecs_get(rvu, max_engs);
+	for (vec = 0; vec < flt_vecs; vec++) {
 		spin_lock_irqsave(&rvu->cpt_intr_lock, flags);
 		rsp->flt_eng_map[vec] = block->cpt_flt_eng_map[vec];
 		rsp->rcvrd_eng_map[vec] = block->cpt_rcvrd_eng_map[vec];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index 5ef406c7e8a4..fc8da2090657 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -71,13 +71,11 @@ enum cpt_af_int_vec_e {
 	CPT_AF_INT_VEC_CNT	= 0x4,
 };
 
-enum cpt_10k_af_int_vec_e {
+enum cpt_cn10k_flt_int_vec_e {
 	CPT_10K_AF_INT_VEC_FLT0	= 0x0,
 	CPT_10K_AF_INT_VEC_FLT1	= 0x1,
 	CPT_10K_AF_INT_VEC_FLT2	= 0x2,
-	CPT_10K_AF_INT_VEC_RVU	= 0x3,
-	CPT_10K_AF_INT_VEC_RAS	= 0x4,
-	CPT_10K_AF_INT_VEC_CNT	= 0x5,
+	CPT_10K_AF_INT_VEC_FLT_MAX = 0x3,
 };
 
 /* NPA Admin function Interrupt Vector Enumeration */
-- 
2.25.1


