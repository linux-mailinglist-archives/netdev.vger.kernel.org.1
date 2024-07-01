Return-Path: <netdev+bounces-108062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545191DB86
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A341C20F4D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943B353804;
	Mon,  1 Jul 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Rjbw9mtr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315C524C9;
	Mon,  1 Jul 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826465; cv=none; b=o5ekUuJit1T49V19JbChRaKKLDCfVq+jioxwCoMIffeUDGHeDUiI6IKxLXOw7+2ccOKuBDYrnzuHmM/uN7l/NucbIP+HN4EaK5Efr3J9TNgXMLzVazt/qJemzvNK96O3+d+5JWxfwIahqiCZj/8jWUtCgaub9DxXr1TowiTKJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826465; c=relaxed/simple;
	bh=FUidlms4reTKrj8tPZAIMM+XtHJztwJBqkxAH7otq/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcfdG05u5NKlY373EEG3mPq1Y4jNU5l9F7xLq1EwANN3iUt52nfsfOLotHY3ehnRQWlXvUpbnkppd1i46lnVYDLJISPwhg+ooZKp8h1Dm2SKf4AKMziF42uBq721a61R5otj5mLhL+Q8qhLeH4zFisSGjNUnRmDMOTC1zmB8jOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Rjbw9mtr; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4618vOGn021971;
	Mon, 1 Jul 2024 02:08:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
	2tqm7FQF6kM2u/o5QF4rgWJJH8NaYwwNv/fKL+Glrw=; b=Rjbw9mtrsfVh2HIs0
	JJ2bj9tesixhr5y2fp1dIhuyq9FCbGBED444T98B8EFcBtJ1hRV5kJ7c3R75zaoD
	fTQ1QHwIccuhXm9KbocY+j5EoirUU/UgTFAQ0LS2oHCCvrSa4B7DDR9In+Ul5HRp
	oKxRZgJHxQ9oU0soNhRZOsYNjG6sH8mfirYYEKXo8HYjxG8WD/zun0U30VLvHRQV
	G3BNxw2Lea4vxV5Cfrt1ZO/2RxvEUg/NI7KBSEczT6pY+Q2NDMOBRU3lrACa1XZU
	JjsZnJqCKuIhha36eXAWyygKGFKdcRNqNFPehKoLJSdSORRPZAys3107YTZYHceJ
	8IrRw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 403sdcg1n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 02:08:01 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 1 Jul 2024 02:08:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 1 Jul 2024 02:08:00 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id C1EB53F7074;
	Mon,  1 Jul 2024 02:07:56 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <schalla@marvell.com>
Subject: [PATCH net,2/6] octeontx2-af: reduce cpt flt interrupt vectors for cn10kb
Date: Mon, 1 Jul 2024 14:37:42 +0530
Message-ID: <20240701090746.2171565-3-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701090746.2171565-1-schalla@marvell.com>
References: <20240701090746.2171565-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3xqp-k5PngYfbLWB74-Bnzk2NOLgUgMk
X-Proofpoint-ORIG-GUID: 3xqp-k5PngYfbLWB74-Bnzk2NOLgUgMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_07,2024-06-28_01,2024-05-17_01

On new silicon(cn10kb), the number of FLT interrupt vectors has
been reduced. Hence, this patch modifies the code to make
it work for both cn10ka and cn10kb.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  5 +-
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 73 ++++++++++++++++---
 .../marvell/octeontx2/af/rvu_struct.h         |  5 +-
 3 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 4a77f6fe2622..41b46724cb3d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1848,8 +1848,9 @@ struct cpt_flt_eng_info_req {
 
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
index 98440a0241a2..38363ea56c6c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -37,6 +37,38 @@
 	(_rsp)->free_sts_##etype = free_sts;                        \
 })
 
+#define MAX_AE  GENMASK_ULL(47, 32)
+#define MAX_IE  GENMASK_ULL(31, 16)
+#define MAX_SE  GENMASK_ULL(15, 0)
+static u32 cpt_max_engines_get(struct rvu *rvu)
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
+/* Number of flt interrupt vectors are depends on number of engines that
+ * the chip has. Each flt vector represents 64 engines.
+ */
+static int cpt_10k_flt_nvecs_get(struct rvu *rvu)
+{
+	u32 max_engs;
+	int flt_vecs;
+
+	max_engs = cpt_max_engines_get(rvu);
+
+	flt_vecs = (max_engs / 64);
+	flt_vecs += (max_engs % 64) ? 1 : 0;
+
+	return flt_vecs;
+}
+
 static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
 {
 	struct rvu_block *block = ptr;
@@ -150,17 +182,25 @@ static void cpt_10k_unregister_interrupts(struct rvu_block *block, int off)
 {
 	struct rvu *rvu = block->rvu;
 	int blkaddr = block->addr;
+	u32 max_engs;
+	u8 nr;
 	int i;
 
+	max_engs = cpt_max_engines_get(rvu);
+
 	/* Disable all CPT AF interrupts */
-	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(0), ~0ULL);
-	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(1), ~0ULL);
-	rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(2), 0xFFFF);
+	for (i = CPT_10K_AF_INT_VEC_FLT0; i < cpt_10k_flt_nvecs_get(rvu); i++) {
+		nr = (max_engs > 64) ? 64 : max_engs;
+		max_engs -= nr;
+		rvu_write64(rvu, blkaddr, CPT_AF_FLTX_INT_ENA_W1C(i),
+			    INTR_MASK(nr));
+	}
 
 	rvu_write64(rvu, blkaddr, CPT_AF_RVU_INT_ENA_W1C, 0x1);
 	rvu_write64(rvu, blkaddr, CPT_AF_RAS_INT_ENA_W1C, 0x1);
 
-	for (i = 0; i < CPT_10K_AF_INT_VEC_CNT; i++)
+	/* CPT AF interrupt vectors are flt_int, rvu_int and ras_int. */
+	for (i = 0; i < cpt_10k_flt_nvecs_get(rvu) + 2; i++)
 		if (rvu->irq_allocated[off + i]) {
 			free_irq(pci_irq_vector(rvu->pdev, off + i), block);
 			rvu->irq_allocated[off + i] = false;
@@ -206,12 +246,17 @@ void rvu_cpt_unregister_interrupts(struct rvu *rvu)
 
 static int cpt_10k_register_interrupts(struct rvu_block *block, int off)
 {
+	int rvu_intr_vec, ras_intr_vec;
 	struct rvu *rvu = block->rvu;
 	int blkaddr = block->addr;
 	irq_handler_t flt_fn;
+	u32 max_engs;
 	int i, ret;
+	u8 nr;
+
+	max_engs = cpt_max_engines_get(rvu);
 
-	for (i = CPT_10K_AF_INT_VEC_FLT0; i < CPT_10K_AF_INT_VEC_RVU; i++) {
+	for (i = CPT_10K_AF_INT_VEC_FLT0; i < cpt_10k_flt_nvecs_get(rvu); i++) {
 		sprintf(&rvu->irq_name[(off + i) * NAME_SIZE], "CPTAF FLT%d", i);
 
 		switch (i) {
@@ -229,20 +274,24 @@ static int cpt_10k_register_interrupts(struct rvu_block *block, int off)
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
+	rvu_intr_vec = cpt_10k_flt_nvecs_get(rvu);
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
@@ -922,7 +971,7 @@ int rvu_mbox_handler_cpt_flt_eng_info(struct rvu *rvu, struct cpt_flt_eng_info_r
 		return blkaddr;
 
 	block = &rvu->hw->block[blkaddr];
-	for (vec = 0; vec < CPT_10K_AF_INT_VEC_RVU; vec++) {
+	for (vec = 0; vec < cpt_10k_flt_nvecs_get(block->rvu); vec++) {
 		spin_lock_irqsave(&rvu->cpt_intr_lock, flags);
 		rsp->flt_eng_map[vec] = block->cpt_flt_eng_map[vec];
 		rsp->rcvrd_eng_map[vec] = block->cpt_rcvrd_eng_map[vec];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index 5ef406c7e8a4..120776063e86 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -71,13 +71,10 @@ enum cpt_af_int_vec_e {
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
 };
 
 /* NPA Admin function Interrupt Vector Enumeration */
-- 
2.25.1


