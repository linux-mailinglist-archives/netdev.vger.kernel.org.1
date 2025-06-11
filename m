Return-Path: <netdev+bounces-196533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA0AD5320
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3FF1719F6
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC8826056E;
	Wed, 11 Jun 2025 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kETL3DDC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E15A25BF11
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639751; cv=none; b=nJcY7eNrsqwYzZu1FI0X4L/dVEMcLKCCiXLp/O12ypqYecP4Bpl6XILlnF8/k46a0mA+T2NypBkhmrT719eaWqtL6cCQRRG4JhbGT2cx/EFxmI/ecTnSJ59+WLLVnlMN9zBrxRc3ca4/YWtxDvwpZXyc1qap2L6W/wPYYfbbflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639751; c=relaxed/simple;
	bh=9gE9unUtA9yLz5NvCNVqTZB1kh9Siz8a4ggotQc/eRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbfyXfB05kFOY10zZFaz1EmxRpRXU+DBzoPZLuZwTbklTo6ZGyLYmxryZCzE6F2TQf1vRw6B5Xu24MEqqiRvuO0vBRtyy4psWa5mMWCbRgBNCJZWQp0C3n8mDfMHi1y27IdX4gMh1w31GUbhyBj3DmYEd9jfIKuUTtTWBsyPDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kETL3DDC; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8Wn0N025175;
	Wed, 11 Jun 2025 04:02:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=XMSB8NdlBW8p0pgSydyomh1gw
	tCqQURB1rJDz4fbL2o=; b=kETL3DDCed677D2kt2aZCdd0abcJW3GuHMgfJGHKs
	Tu031CINR+1fSuhDiCneAvrI2wvnvxk3NPdaC1HhErdlWQQCufHMqLigNmKYtAH7
	FpXzPW81o4msNwxOgXbEOtXvjhRmmxVeVji6xBP8KABZbrD6qLaiQmozfWvj2/Iq
	VNrmwnI8eZ7BRssr0luYhA8S7A5u1o32s3er2HfhktvQQikvpu3wsEvj0YS5pASm
	1iCvyg43wyVNeJ/NYG7BWbT6a65G/Vfzaa04DrARRg7JdHkAZuyzrCglpO+JM5ne
	HhJkUohLjoiAH1V19ptYgUSfAa7AfFJtlVkxKa0wMjMZg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4769bn49j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 04:02:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Jun 2025 04:02:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Jun 2025 04:02:19 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 034D23F706B;
	Wed, 11 Jun 2025 04:02:14 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <saikrishnag@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v11 3/6] octeontx2-af: CN20k mbox to support AF REQ/ACK functionality
Date: Wed, 11 Jun 2025 16:31:53 +0530
Message-ID: <1749639716-13868-4-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1749639716-13868-1-git-send-email-sbhatta@marvell.com>
References: <1749639716-13868-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA5NCBTYWx0ZWRfX8wYwqafZU316 IB1IQIgfyRISMuKBK02hBEAZckMI1JJvtE/0KRgaw2wOqiy5P/ago903l/6KX6yX6xCtXJJGs6s xqC9WHQ8sfeDSYii/kijNj0rQW2oNyfMr3zA8cOJrER/mEDxcZhQKkbjZ4cmC8cGIg1rdNQ0KXL
 t+Irpqqufu+y1i5r+ubWrwLPmADd4VfpwwNS5P2z6NcTKh9lyPUe3PVUf8B6fbQD9gzwpcOON+K s49qrhxlntdH6drANfseimGozHVL5+NjrWDwxIlRIHym8TkTuyAlRQAUvFQUDNNw+FO+lTW3lBK ziMe5SYSNxYkKQma9ZIkEIutbojEyIvPwnNNALtUccEd9QVHzEOVV9Wh9Sq+E1JIWY9xDn4MFOg
 C4gZO9ie63CNFf5GcaGPEMxvWhEo7XlrgtQdbgnxtoZXOHNXTmdmDBYQtbn3aM/1k5bfK0zI
X-Proofpoint-ORIG-GUID: W-6PPiD_1PW9JluIrVnjWBJ0YqAooqZs
X-Proofpoint-GUID: W-6PPiD_1PW9JluIrVnjWBJ0YqAooqZs
X-Authority-Analysis: v=2.4 cv=ZuDtK87G c=1 sm=1 tr=0 ts=6849623c cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=AxTxMYBVTPKO8Xcpy6gA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01

From: Sai Krishna <saikrishnag@marvell.com>

This implementation uses separate trigger interrupts for request,
response MBOX messages against using trigger message data in CN10K.
This patch adds support for basic mbox implementation for CN20K
from AF side.

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/cn20k/api.h  |   5 +
 .../marvell/octeontx2/af/cn20k/mbox_init.c         | 172 +++++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/cn20k/reg.h  |  17 ++
 .../ethernet/marvell/octeontx2/af/cn20k/struct.h   |  25 +++
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   |  83 +++++++++-
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |   1 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |  57 +++++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |  16 +-
 8 files changed, 358 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
index 74d4580..5e3a105 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
@@ -20,4 +20,9 @@ int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int num);
 int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 			       int num, int type, unsigned long *pf_bmap);
 void cn20k_free_mbox_memory(struct rvu *rvu);
+int cn20k_register_afpf_mbox_intr(struct rvu *rvu);
+void cn20k_rvu_enable_mbox_intr(struct rvu *rvu);
+void cn20k_rvu_unregister_interrupts(struct rvu *rvu);
+int cn20k_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
+		     void *reg_base, int direction, int ndevs);
 #endif /* CN20K_API_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
index 77a0f86..5c63a85 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
@@ -13,6 +13,137 @@
 #include "reg.h"
 #include "api.h"
 
+/* CN20K mbox PFx => AF irq handler */
+static irqreturn_t cn20k_mbox_pf_common_intr_handler(int irq, void *rvu_irq)
+{
+	struct rvu_irq_data *rvu_irq_data = rvu_irq;
+	struct rvu *rvu = rvu_irq_data->rvu;
+	u64 intr;
+
+	/* Clear interrupts */
+	intr = rvu_read64(rvu, BLKADDR_RVUM, rvu_irq_data->intr_status);
+	rvu_write64(rvu, BLKADDR_RVUM, rvu_irq_data->intr_status, intr);
+
+	if (intr)
+		trace_otx2_msg_interrupt(rvu->pdev, "PF(s) to AF", intr);
+
+	/* Sync with mbox memory region */
+	rmb();
+
+	rvu_irq_data->rvu_queue_work_hdlr(&rvu->afpf_wq_info,
+					  rvu_irq_data->start,
+					  rvu_irq_data->mdevs, intr);
+
+	return IRQ_HANDLED;
+}
+
+void cn20k_rvu_enable_mbox_intr(struct rvu *rvu)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+
+	/* Clear spurious irqs, if any */
+	rvu_write64(rvu, BLKADDR_RVUM,
+		    RVU_MBOX_AF_PFAF_INT(0), INTR_MASK(hw->total_pfs));
+
+	rvu_write64(rvu, BLKADDR_RVUM,
+		    RVU_MBOX_AF_PFAF_INT(1), INTR_MASK(hw->total_pfs - 64));
+
+	rvu_write64(rvu, BLKADDR_RVUM,
+		    RVU_MBOX_AF_PFAF1_INT(0), INTR_MASK(hw->total_pfs));
+
+	rvu_write64(rvu, BLKADDR_RVUM,
+		    RVU_MBOX_AF_PFAF1_INT(1), INTR_MASK(hw->total_pfs - 64));
+
+	/* Enable mailbox interrupt for all PFs except PF0 i.e AF itself */
+	rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF_INT_ENA_W1S(0),
+		    INTR_MASK(hw->total_pfs) & ~1ULL);
+
+	rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF_INT_ENA_W1S(1),
+		    INTR_MASK(hw->total_pfs - 64));
+
+	rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF1_INT_ENA_W1S(0),
+		    INTR_MASK(hw->total_pfs) & ~1ULL);
+
+	rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF1_INT_ENA_W1S(1),
+		    INTR_MASK(hw->total_pfs - 64));
+}
+
+void cn20k_rvu_unregister_interrupts(struct rvu *rvu)
+{
+	rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF_INT_ENA_W1C(0),
+		    INTR_MASK(rvu->hw->total_pfs) & ~1ULL);
+
+	rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF_INT_ENA_W1C(1),
+		    INTR_MASK(rvu->hw->total_pfs - 64));
+
+	rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF1_INT_ENA_W1C(0),
+		    INTR_MASK(rvu->hw->total_pfs) & ~1ULL);
+
+	rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFAF1_INT_ENA_W1C(1),
+		    INTR_MASK(rvu->hw->total_pfs - 64));
+}
+
+int cn20k_register_afpf_mbox_intr(struct rvu *rvu)
+{
+	struct rvu_irq_data *irq_data;
+	int intr_vec, ret, vec = 0;
+
+	/* irq data for 4 PF intr vectors */
+	irq_data = devm_kcalloc(rvu->dev, 4,
+				sizeof(struct rvu_irq_data), GFP_KERNEL);
+	if (!irq_data)
+		return -ENOMEM;
+
+	for (intr_vec = RVU_AF_CN20K_INT_VEC_PFAF_MBOX0; intr_vec <=
+				RVU_AF_CN20K_INT_VEC_PFAF1_MBOX1; intr_vec++,
+				vec++) {
+		switch (intr_vec) {
+		case RVU_AF_CN20K_INT_VEC_PFAF_MBOX0:
+			irq_data[vec].intr_status =
+						RVU_MBOX_AF_PFAF_INT(0);
+			irq_data[vec].start = 0;
+			irq_data[vec].mdevs = 64;
+			break;
+		case RVU_AF_CN20K_INT_VEC_PFAF_MBOX1:
+			irq_data[vec].intr_status =
+						RVU_MBOX_AF_PFAF_INT(1);
+			irq_data[vec].start = 64;
+			irq_data[vec].mdevs = 96;
+			break;
+		case RVU_AF_CN20K_INT_VEC_PFAF1_MBOX0:
+			irq_data[vec].intr_status =
+						RVU_MBOX_AF_PFAF1_INT(0);
+			irq_data[vec].start = 0;
+			irq_data[vec].mdevs = 64;
+			break;
+		case RVU_AF_CN20K_INT_VEC_PFAF1_MBOX1:
+			irq_data[vec].intr_status =
+						RVU_MBOX_AF_PFAF1_INT(1);
+			irq_data[vec].start = 64;
+			irq_data[vec].mdevs = 96;
+			break;
+		}
+		irq_data[vec].rvu_queue_work_hdlr = rvu_queue_work;
+		irq_data[vec].vec_num = intr_vec;
+		irq_data[vec].rvu = rvu;
+
+		/* Register mailbox interrupt handler */
+		sprintf(&rvu->irq_name[intr_vec * NAME_SIZE],
+			"RVUAF PFAF%d Mbox%d",
+			vec / 2, vec % 2);
+		ret = request_irq(pci_irq_vector(rvu->pdev, intr_vec),
+				  rvu->ng_rvu->rvu_mbox_ops->pf_intr_handler, 0,
+				  &rvu->irq_name[intr_vec * NAME_SIZE],
+				  &irq_data[vec]);
+		if (ret)
+			return ret;
+
+		rvu->irq_allocated[intr_vec] = true;
+	}
+
+	return 0;
+}
+
 int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 			       int num, int type, unsigned long *pf_bmap)
 {
@@ -72,6 +203,10 @@ static int rvu_alloc_mbox_memory(struct rvu *rvu, int type,
 	return 0;
 }
 
+static struct mbox_ops cn20k_mbox_ops = {
+	.pf_intr_handler = cn20k_mbox_pf_common_intr_handler,
+};
+
 int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int ndevs)
 {
 	int dev;
@@ -79,6 +214,8 @@ int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int ndevs)
 	if (!is_cn20k(rvu->pdev))
 		return 0;
 
+	rvu->ng_rvu->rvu_mbox_ops = &cn20k_mbox_ops;
+
 	for (dev = 0; dev < ndevs; dev++)
 		rvu_write64(rvu, BLKADDR_RVUM,
 			    RVU_MBOX_AF_PFX_CFG(dev), ilog2(MBOX_SIZE));
@@ -93,3 +230,38 @@ void cn20k_free_mbox_memory(struct rvu *rvu)
 
 	qmem_free(rvu->dev, rvu->ng_rvu->pf_mbox_addr);
 }
+
+int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
+			    int blkaddr, int nixlf)
+{
+	int qints, hwctx_size, err;
+	u64 cfg, ctx_cfg;
+
+	if (is_rvu_otx2(rvu) || is_cn20k(rvu->pdev))
+		return 0;
+
+	ctx_cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST3);
+	/* Alloc memory for CQINT's HW contexts */
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
+	qints = (cfg >> 24) & 0xFFF;
+	hwctx_size = 1UL << ((ctx_cfg >> 24) & 0xF);
+	err = qmem_alloc(rvu->dev, &pfvf->cq_ints_ctx, qints, hwctx_size);
+	if (err)
+		return -ENOMEM;
+
+	rvu_write64(rvu, blkaddr, NIX_AF_LFX_CINTS_BASE(nixlf),
+		    (u64)pfvf->cq_ints_ctx->iova);
+
+	/* Alloc memory for QINT's HW contexts */
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
+	qints = (cfg >> 12) & 0xFFF;
+	hwctx_size = 1UL << ((ctx_cfg >> 20) & 0xF);
+	err = qmem_alloc(rvu->dev, &pfvf->nix_qints_ctx, qints, hwctx_size);
+	if (err)
+		return -ENOMEM;
+
+	rvu_write64(rvu, blkaddr, NIX_AF_LFX_QINTS_BASE(nixlf),
+		    (u64)pfvf->nix_qints_ctx->iova);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
index 58152a4..df2d5256 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
@@ -19,6 +19,23 @@
 /* RVU AF BAR0 Mbox registers for AF => PFx */
 #define RVU_MBOX_AF_PFX_ADDR(a)			(0x5000 | (a) << 4)
 #define RVU_MBOX_AF_PFX_CFG(a)			(0x6000 | (a) << 4)
+#define RVU_MBOX_AF_AFPFX_TRIGX(a)		(0x9000 | (a) << 3)
+#define RVU_MBOX_AF_PFAF_INT(a)			(0x2980 | (a) << 6)
+#define RVU_MBOX_AF_PFAF_INT_W1S(a)		(0x2988 | (a) << 6)
+#define RVU_MBOX_AF_PFAF_INT_ENA_W1S(a)		(0x2990 | (a) << 6)
+#define RVU_MBOX_AF_PFAF_INT_ENA_W1C(a)		(0x2998 | (a) << 6)
+#define RVU_MBOX_AF_PFAF1_INT(a)		(0x29A0 | (a) << 6)
+#define RVU_MBOX_AF_PFAF1_INT_W1S(a)		(0x29A8 | (a) << 6)
+#define RVU_MBOX_AF_PFAF1_INT_ENA_W1S(a)	(0x29B0 | (a) << 6)
+#define RVU_MBOX_AF_PFAF1_INT_ENA_W1C(a)	(0x29B8 | (a) << 6)
+
+/* RVU PF => AF mbox registers */
+#define RVU_MBOX_PF_PFAF_TRIGX(a)		(0xC00 | (a) << 3)
+#define RVU_MBOX_PF_INT				(0xC20)
+#define RVU_MBOX_PF_INT_W1S			(0xC28)
+#define RVU_MBOX_PF_INT_ENA_W1S			(0xC30)
+#define RVU_MBOX_PF_INT_ENA_W1C			(0xC38)
+
 #define RVU_AF_BAR2_SEL				(0x9000000)
 #define RVU_AF_BAR2_PFID			(0x16400)
 #define NIX_CINTX_INT_W1S(a)			(0xd30 | (a) << 12)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
new file mode 100644
index 0000000..fccad6e
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#ifndef STRUCT_H
+#define STRUCT_H
+
+/* RVU Admin function Interrupt Vector Enumeration */
+enum rvu_af_cn20k_int_vec_e {
+	RVU_AF_CN20K_INT_VEC_POISON		= 0x0,
+	RVU_AF_CN20K_INT_VEC_PFFLR0		= 0x1,
+	RVU_AF_CN20K_INT_VEC_PFFLR1		= 0x2,
+	RVU_AF_CN20K_INT_VEC_PFME0		= 0x3,
+	RVU_AF_CN20K_INT_VEC_PFME1		= 0x4,
+	RVU_AF_CN20K_INT_VEC_GEN		= 0x5,
+	RVU_AF_CN20K_INT_VEC_PFAF_MBOX0		= 0x6,
+	RVU_AF_CN20K_INT_VEC_PFAF_MBOX1		= 0x7,
+	RVU_AF_CN20K_INT_VEC_PFAF1_MBOX0	= 0x8,
+	RVU_AF_CN20K_INT_VEC_PFAF1_MBOX1	= 0x9,
+	RVU_AF_CN20K_INT_VEC_CNT		= 0xa,
+};
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index a70d55e..89324a3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -31,8 +31,10 @@ void __otx2_mbox_reset(struct otx2_mbox *mbox, int devid)
 	mdev->rsp_size = 0;
 	tx_hdr->num_msgs = 0;
 	tx_hdr->msg_size = 0;
+	tx_hdr->sig = 0;
 	rx_hdr->num_msgs = 0;
 	rx_hdr->msg_size = 0;
+	rx_hdr->sig = 0;
 }
 EXPORT_SYMBOL(__otx2_mbox_reset);
 
@@ -56,9 +58,78 @@ void otx2_mbox_destroy(struct otx2_mbox *mbox)
 }
 EXPORT_SYMBOL(otx2_mbox_destroy);
 
+int cn20k_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
+		     void *reg_base, int direction, int ndevs)
+{
+	switch (direction) {
+	case MBOX_DIR_AFPF:
+		mbox->tx_start = MBOX_DOWN_TX_START;
+		mbox->rx_start = MBOX_DOWN_RX_START;
+		mbox->tx_size  = MBOX_DOWN_TX_SIZE;
+		mbox->rx_size  = MBOX_DOWN_RX_SIZE;
+		break;
+	case MBOX_DIR_PFAF:
+		mbox->tx_start = MBOX_DOWN_RX_START;
+		mbox->rx_start = MBOX_DOWN_TX_START;
+		mbox->tx_size  = MBOX_DOWN_RX_SIZE;
+		mbox->rx_size  = MBOX_DOWN_TX_SIZE;
+		break;
+	case MBOX_DIR_AFPF_UP:
+		mbox->tx_start = MBOX_UP_TX_START;
+		mbox->rx_start = MBOX_UP_RX_START;
+		mbox->tx_size  = MBOX_UP_TX_SIZE;
+		mbox->rx_size  = MBOX_UP_RX_SIZE;
+		break;
+	case MBOX_DIR_PFAF_UP:
+		mbox->tx_start = MBOX_UP_RX_START;
+		mbox->rx_start = MBOX_UP_TX_START;
+		mbox->tx_size  = MBOX_UP_RX_SIZE;
+		mbox->rx_size  = MBOX_UP_TX_SIZE;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	switch (direction) {
+	case MBOX_DIR_AFPF:
+		mbox->trigger = RVU_MBOX_AF_AFPFX_TRIGX(1);
+		mbox->tr_shift = 4;
+		break;
+	case MBOX_DIR_AFPF_UP:
+		mbox->trigger = RVU_MBOX_AF_AFPFX_TRIGX(0);
+		mbox->tr_shift = 4;
+		break;
+	case MBOX_DIR_PFAF:
+		mbox->trigger = RVU_MBOX_PF_PFAF_TRIGX(0);
+		mbox->tr_shift = 0;
+		break;
+	case MBOX_DIR_PFAF_UP:
+		mbox->trigger = RVU_MBOX_PF_PFAF_TRIGX(1);
+		mbox->tr_shift = 0;
+		break;
+	default:
+		return -ENODEV;
+	}
+	mbox->reg_base = reg_base;
+	mbox->pdev = pdev;
+
+	mbox->dev = kcalloc(ndevs, sizeof(struct otx2_mbox_dev), GFP_KERNEL);
+	if (!mbox->dev) {
+		otx2_mbox_destroy(mbox);
+		return -ENOMEM;
+	}
+	mbox->ndevs = ndevs;
+
+	return 0;
+}
+
 static int otx2_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
 			   void *reg_base, int direction, int ndevs)
 {
+	if (is_cn20k(pdev))
+		return cn20k_mbox_setup(mbox, pdev, reg_base,
+							direction, ndevs);
+
 	switch (direction) {
 	case MBOX_DIR_AFPF:
 	case MBOX_DIR_PFVF:
@@ -237,7 +308,10 @@ static void otx2_mbox_msg_send_data(struct otx2_mbox *mbox, int devid, u64 data)
 
 	spin_lock(&mdev->mbox_lock);
 
-	tx_hdr->msg_size = mdev->msg_size;
+	if (!tx_hdr->sig) {
+		tx_hdr->msg_size = mdev->msg_size;
+		tx_hdr->num_msgs = mdev->num_msgs;
+	}
 
 	/* Reset header for next messages */
 	mdev->msg_size = 0;
@@ -251,7 +325,6 @@ static void otx2_mbox_msg_send_data(struct otx2_mbox *mbox, int devid, u64 data)
 	 * messages.  So this should be written after writing all the messages
 	 * to the shared memory.
 	 */
-	tx_hdr->num_msgs = mdev->num_msgs;
 	rx_hdr->num_msgs = 0;
 
 	msg = (struct mbox_msghdr *)(hw_mbase + mbox->tx_start + msgs_offset);
@@ -312,6 +385,7 @@ struct mbox_msghdr *otx2_mbox_alloc_msg_rsp(struct otx2_mbox *mbox, int devid,
 {
 	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
 	struct mbox_msghdr *msghdr = NULL;
+	struct mbox_hdr *mboxhdr = NULL;
 
 	spin_lock(&mdev->mbox_lock);
 	size = ALIGN(size, MBOX_MSG_ALIGN);
@@ -335,6 +409,11 @@ struct mbox_msghdr *otx2_mbox_alloc_msg_rsp(struct otx2_mbox *mbox, int devid,
 	mdev->msg_size += size;
 	mdev->rsp_size += size_rsp;
 	msghdr->next_msgoff = mdev->msg_size + msgs_offset;
+
+	mboxhdr = mdev->mbase + mbox->tx_start;
+	/* Clear the msg header region */
+	memset(mboxhdr, 0, msgs_offset);
+
 exit:
 	spin_unlock(&mdev->mbox_lock);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 1e28759..b3562d6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -13,6 +13,7 @@
 
 #include "rvu_struct.h"
 #include "common.h"
+#include "cn20k/struct.h"
 
 #define MBOX_SIZE		SZ_64K
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 348e23e..c9e9ef4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -755,6 +755,11 @@ static void rvu_free_hw_resources(struct rvu *rvu)
 
 	rvu_reset_msix(rvu);
 	mutex_destroy(&rvu->rsrc_lock);
+
+	/* Free the QINT/CINT memory */
+	pfvf = &rvu->pf[RVU_AFPF];
+	qmem_free(rvu->dev, pfvf->nix_qints_ctx);
+	qmem_free(rvu->dev, pfvf->cq_ints_ctx);
 }
 
 static void rvu_setup_pfvf_macaddress(struct rvu *rvu)
@@ -2698,6 +2703,11 @@ static void rvu_enable_mbox_intr(struct rvu *rvu)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 
+	if (is_cn20k(rvu->pdev)) {
+		cn20k_rvu_enable_mbox_intr(rvu);
+		return;
+	}
+
 	/* Clear spurious irqs, if any */
 	rvu_write64(rvu, BLKADDR_RVUM,
 		    RVU_AF_PFAF_MBOX_INT, INTR_MASK(hw->total_pfs));
@@ -2951,9 +2961,12 @@ static void rvu_unregister_interrupts(struct rvu *rvu)
 
 	rvu_cpt_unregister_interrupts(rvu);
 
-	/* Disable the Mbox interrupt */
-	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT_ENA_W1C,
-		    INTR_MASK(rvu->hw->total_pfs) & ~1ULL);
+	if (!is_cn20k(rvu->pdev))
+		/* Disable the Mbox interrupt */
+		rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_PFAF_MBOX_INT_ENA_W1C,
+			    INTR_MASK(rvu->hw->total_pfs) & ~1ULL);
+	else
+		cn20k_rvu_unregister_interrupts(rvu);
 
 	/* Disable the PF FLR interrupt */
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_PFFLR_INT_ENA_W1C,
@@ -3016,19 +3029,30 @@ static int rvu_register_interrupts(struct rvu *rvu)
 		return ret;
 	}
 
-	/* Register mailbox interrupt handler */
-	sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], "RVUAF Mbox");
-	ret = request_irq(pci_irq_vector
-			  (rvu->pdev, RVU_AF_INT_VEC_MBOX),
-			  rvu->ng_rvu->rvu_mbox_ops->pf_intr_handler, 0,
-			  &rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], rvu);
-	if (ret) {
-		dev_err(rvu->dev,
-			"RVUAF: IRQ registration failed for mbox\n");
-		goto fail;
-	}
+	if (!is_cn20k(rvu->pdev)) {
+		/* Register mailbox interrupt handler */
+		sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE],
+			"RVUAF Mbox");
+		ret = request_irq(pci_irq_vector
+				  (rvu->pdev, RVU_AF_INT_VEC_MBOX),
+				  rvu->ng_rvu->rvu_mbox_ops->pf_intr_handler, 0,
+				  &rvu->irq_name[RVU_AF_INT_VEC_MBOX *
+				  NAME_SIZE], rvu);
+		if (ret) {
+			dev_err(rvu->dev,
+				"RVUAF: IRQ registration failed for mbox\n");
+			goto fail;
+		}
 
-	rvu->irq_allocated[RVU_AF_INT_VEC_MBOX] = true;
+		rvu->irq_allocated[RVU_AF_INT_VEC_MBOX] = true;
+	} else {
+		ret = cn20k_register_afpf_mbox_intr(rvu);
+		if (ret) {
+			dev_err(rvu->dev,
+				"RVUAF: IRQ registration failed for mbox\n");
+			goto fail;
+		}
+	}
 
 	/* Enable mailbox interrupts from all PFs */
 	rvu_enable_mbox_intr(rvu);
@@ -3481,6 +3505,9 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ptp_start(rvu, rvu->fwdata->sclk, rvu->fwdata->ptp_ext_clk_rate,
 			  rvu->fwdata->ptp_ext_tstamp);
 
+	/* Alloc CINT and QINT memory */
+	rvu_alloc_cint_qint_mem(rvu, &rvu->pf[RVU_AFPF], BLKADDR_NIX0,
+				(rvu->hw->block[BLKADDR_NIX0].lf.max));
 	return 0;
 err_dl:
 	rvu_unregister_dl(rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 987edf0..3332dfd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -73,7 +73,10 @@ static inline int rvu_pcifunc_pf_mask(struct pci_dev *pdev)
 		return ~(RVU_OTX2_PFVF_PF_MASK << RVU_OTX2_PFVF_PF_SHIFT);
 }
 
+#define RVU_AFPF           25
+
 #ifdef CONFIG_DEBUG_FS
+
 struct dump_ctx {
 	int	lf;
 	int	id;
@@ -471,6 +474,16 @@ struct mbox_wq_info {
 	struct workqueue_struct *mbox_wq;
 };
 
+struct rvu_irq_data {
+	u64 intr_status;
+	void (*rvu_queue_work_hdlr)(struct mbox_wq_info *mw, int first,
+				    int mdevs, u64 intr);
+	struct	rvu *rvu;
+	int vec_num;
+	int start;
+	int mdevs;
+};
+
 struct mbox_ops {
 	irqreturn_t (*pf_intr_handler)(int irq, void *rvu_irq);
 };
@@ -999,7 +1012,8 @@ int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 pcifunc,
 int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
 				    u32 mcast_grp_idx, u16 mcam_index);
 void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc);
-
+int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
+			    int blkaddr, int nixlf);
 /* NPC APIs */
 void rvu_npc_freemem(struct rvu *rvu);
 int rvu_npc_get_pkind(struct rvu *rvu, u16 pf);
-- 
2.7.4


