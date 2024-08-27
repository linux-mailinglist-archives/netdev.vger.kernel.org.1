Return-Path: <netdev+bounces-122137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437ED960041
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 06:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3932AB2196D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 04:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FC62260C;
	Tue, 27 Aug 2024 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZBMBBseH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC023BB
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 04:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724732747; cv=none; b=it5hqVpaAwNA3/o5NmXao5aU/Py9/GXYn48PzHNktsZQ/ERO3dpaZit8hNqCWBFqS3EgVA7yCSlJZI8uWoVj05QfzGwbiPhitrT9j2TsMkB10h2eY67GdHreJ7Iel47Q4W2dziOt/hCxqNSdn/iCprnHIrj7x5iNgW/+p5Ncouo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724732747; c=relaxed/simple;
	bh=LPyyW42pfhlUSUF/aJlWC5SIngyAXMpffDYZwt8IaK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mY1vOaotndJS0Nf815mxHG//xJYyRFNucqyyolgE3UW+Ki2BOIqyztDzNDb5G1PzCSrcbnF9WDpghw7DUkJ4YSqN1PQAgvpO+3q90zZU7Snzh9akgkWUSo0ASD+SunxzS0Vm9UUr/+Nqd8XoRBS0isyrUu7Nf4n+CGu5sr1/ClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZBMBBseH; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QN0Aas022034;
	Mon, 26 Aug 2024 21:25:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=2
	6LhUcn7kSRTp9dEDGgkudStBcOOILtdG2ad3mjIDSE=; b=ZBMBBseHSIFI8cBEv
	isBS53oPH9/gy7gT/5EtSpulGb86xbUGqbhO46515R9daDwAq0jDsNWakv7bjth+
	WRk1g0JG6PxRBS6QWjAJ6rND4deDb7HFHCtG0HGU08RH421YUr3Y7M1hbz8HmKxB
	psR78ZA37bVQA9Bpa8jRwQAAdlePlGIFB2xCSAXxdhYe6z1FEi3iq3rQhswiI2Zu
	rUrqfv73IWJm6QlF26FRCHYEepuaNgSVir19jyKBIfuK2oIlri+89Fmeq2Zj/mNd
	aqFGN2aFRWIzDoUI4+74sNQ5HaR3YE6CRccTpCotsKkImUfLRt1HFiTNHxWUkImO
	4IWbg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 418sy43att-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 21:25:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 Aug 2024 21:25:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 Aug 2024 21:25:22 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id BF7EC5C68E4;
	Mon, 26 Aug 2024 21:25:18 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <bbhushan2@marvell.com>,
        <ndabilpuram@marvell.com>
Subject: [PATCH net-next,1/2] octeontx2-af: reduce cpt flt interrupt vectors for CN10KB
Date: Tue, 27 Aug 2024 09:55:11 +0530
Message-ID: <20240827042512.216634-2-schalla@marvell.com>
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
X-Proofpoint-ORIG-GUID: DkikPcZSZI4QjR8cHQGSxrBL0oQVqKpx
X-Proofpoint-GUID: DkikPcZSZI4QjR8cHQGSxrBL0oQVqKpx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_03,2024-08-26_01,2024-05-17_01

On CN10KB, number of flt interrupt vectors are reduced to
2. So, modify the code accordingly for cn10k.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  5 +-
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 79 ++++++++++++++++---
 .../marvell/octeontx2/af/rvu_struct.h         |  6 +-
 3 files changed, 72 insertions(+), 18 deletions(-)

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
index 3e09d2285814..e56d27018828 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -37,6 +37,44 @@
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
+/* Number of flt interrupt vectors are depends on number of engines that the
+ * chip has. Each flt vector represents 64 engines.
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
+	if (flt_vecs > CPT_10K_AF_INT_VEC_FLT_MAX) {
+		dev_warn(rvu->dev, "flt_vecs(%d) exceeds the max vectors(%d)\n",
+			 flt_vecs, CPT_10K_AF_INT_VEC_FLT_MAX);
+		flt_vecs = CPT_10K_AF_INT_VEC_FLT_MAX;
+	}
+
+	return flt_vecs;
+}
+
 static irqreturn_t cpt_af_flt_intr_handler(int vec, void *ptr)
 {
 	struct rvu_block *block = ptr;
@@ -150,17 +188,25 @@ static void cpt_10k_unregister_interrupts(struct rvu_block *block, int off)
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
@@ -206,12 +252,17 @@ void rvu_cpt_unregister_interrupts(struct rvu *rvu)
 
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
@@ -229,20 +280,24 @@ static int cpt_10k_register_interrupts(struct rvu_block *block, int off)
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
@@ -928,7 +983,7 @@ int rvu_mbox_handler_cpt_flt_eng_info(struct rvu *rvu, struct cpt_flt_eng_info_r
 		return blkaddr;
 
 	block = &rvu->hw->block[blkaddr];
-	for (vec = 0; vec < CPT_10K_AF_INT_VEC_RVU; vec++) {
+	for (vec = 0; vec < cpt_10k_flt_nvecs_get(block->rvu); vec++) {
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


