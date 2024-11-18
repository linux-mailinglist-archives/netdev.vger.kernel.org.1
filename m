Return-Path: <netdev+bounces-145889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7769D13DF
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D8A1F23A02
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668F61BD508;
	Mon, 18 Nov 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="inpzRqbm"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A21ABEA6;
	Mon, 18 Nov 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942122; cv=none; b=rM74k/SrZnveZVdYE7ylUXCRnBKKYWNHI/+F3ggoMRZjoO1hhdngsaLMSy0NFt3J5S6BhdKVKseFhicBgx/7bdXvlDwaq08QtJ4/eWKns3FadmXStYknadWb8RCqBArRDUQQ6pjVIVwC9KrYW6xFYmsyle/cgWCpWVSDhZLOvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942122; c=relaxed/simple;
	bh=pao1afUT03+vVeNTBjbh7+IRotwTl2qjTtNF2ebvAfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwDR9foQgkoUxSf7Mt1cQmWM9GDtClK37ByU/MSPIfirXVnqfCUv7NzfChqWS8zDHbgv7izaQP7rlh5ryQ6xYG5KvsiMJdBHNKWfZe1doYv/X824bryxGVVyJR6SnfFr3sPrGASWAk4+AJ44LCFfxPaBqCTZ6tk+wA7Wv+2wOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=inpzRqbm; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI80kh5024910;
	Mon, 18 Nov 2024 07:01:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=4
	KjEDauPbFs8I/oZz4iTVeurFP5cHnbNZcEi7SkeULk=; b=inpzRqbmAErPGfBOX
	6u4VUtNtM8GvcmedP1kOYD42TBuHUcOfvjtu05crgLPEYC7oDKYDaxiJGoz8Vml3
	f1VyyNURMXTEoL9joLrfNaheNnLiekBX48bfjVj5EWvVkv8IE0KuuZ0VlAXbEput
	BF66B+fNNbESSyLcqZUXE58cUJz3zlp1a/D/IcmF7J40VPw6aM6tUog+/GZ14F2k
	3SeSzQ8S9wHFklS+MavBgdZ7DIzYjcMdlSchPbpDfHjk9MjirW77mDgrJvQ7pScE
	FHBiJcZ6EeHOmcPsej+v+YTcvxvCvQoSXAiUBYTi9sSnG36U+BKQCV5g8vb+RWVY
	zJvlw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4301ps8paj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 07:01:49 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 18 Nov 2024 07:01:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 18 Nov 2024 07:01:48 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id DA7263F7041;
	Mon, 18 Nov 2024 07:01:43 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v4 3/6] octeontx2-af: CN20k mbox to support AF REQ/ACK functionality
Date: Mon, 18 Nov 2024 20:31:21 +0530
Message-ID: <20241118150124.984323-4-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118150124.984323-1-saikrishnag@marvell.com>
References: <20241118150124.984323-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: G8GzZQtbiHZKsRlJ59I50mOk15VJrE1o
X-Proofpoint-GUID: G8GzZQtbiHZKsRlJ59I50mOk15VJrE1o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

This implementation uses separate trigger interrupts for request,
response MBOX messages against using trigger message data in CN10K.
This patch adds support for basic mbox implementation for CN20K
from AF side.

Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/api.h |   8 +
 .../marvell/octeontx2/af/cn20k/mbox_init.c    | 212 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |  17 ++
 .../marvell/octeontx2/af/cn20k/struct.h       |  25 +++
 .../net/ethernet/marvell/octeontx2/af/mbox.c  |  83 ++++++-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  70 ++++--
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  16 +-
 .../marvell/octeontx2/nic/otx2_common.c       |  10 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   9 +-
 10 files changed, 417 insertions(+), 34 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
index b57bd38181aa..9436a4a4d815 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
@@ -15,8 +15,16 @@ struct ng_rvu {
 	struct qmem             *pf_mbox_addr;
 };
 
+struct rvu;
+
 /* Mbox related APIs */
 int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int num);
+int cn20k_register_afpf_mbox_intr(struct rvu *rvu);
 int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 			       int num, int type, unsigned long *pf_bmap);
+void cn20k_rvu_enable_mbox_intr(struct rvu *rvu);
+void cn20k_rvu_unregister_interrupts(struct rvu *rvu);
+void cn20k_free_mbox_memory(struct rvu *rvu);
+int cn20k_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
+		     void *reg_base, int direction, int ndevs);
 #endif /* CN20K_API_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
index 0e128013a03f..377e3f579184 100644
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
@@ -34,6 +165,48 @@ int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 	return 0;
 }
 
+static struct mbox_ops cn20k_mbox_ops = {
+	.pf_intr_handler = cn20k_mbox_pf_common_intr_handler,
+};
+
+static int rvu_alloc_mbox_memory(struct rvu *rvu, int type,
+				 int ndevs, int mbox_size)
+{
+	struct qmem *mbox_addr;
+	dma_addr_t iova;
+	int pf, err;
+
+	/* Allocate contiguous memory for mailbox communication.
+	 * eg: AF <=> PFx mbox memory
+	 * This allocated memory is split into chunks of MBOX_SIZE
+	 * and setup into each of the RVU PFs. In HW this memory will
+	 * get aliased to an offset within BAR2 of those PFs.
+	 *
+	 * AF will access mbox memory using direct physical addresses
+	 * and PFs will access the same shared memory from BAR2.
+	 */
+
+	err = qmem_alloc(rvu->dev, &mbox_addr, ndevs, mbox_size);
+	if (err)
+		return -ENOMEM;
+
+	switch (type) {
+	case TYPE_AFPF:
+		rvu->ng_rvu->pf_mbox_addr = mbox_addr;
+		iova = (u64)mbox_addr->iova;
+		for (pf = 0; pf < ndevs; pf++) {
+			rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_AF_PFX_ADDR(pf),
+				    (u64)iova);
+			iova += mbox_size;
+		}
+		break;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int ndevs)
 {
 	int dev;
@@ -41,9 +214,48 @@ int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int ndevs)
 	if (!is_cn20k(rvu->pdev))
 		return 0;
 
+	rvu->ng_rvu->rvu_mbox_ops = &cn20k_mbox_ops;
+
 	for (dev = 0; dev < ndevs; dev++)
 		rvu_write64(rvu, BLKADDR_RVUM,
 			    RVU_MBOX_AF_PFX_CFG(dev), ilog2(MBOX_SIZE));
 
+	return rvu_alloc_mbox_memory(rvu, type, ndevs, MBOX_SIZE);
+}
+
+void cn20k_free_mbox_memory(struct rvu *rvu)
+{
+	qmem_free(rvu->dev, rvu->ng_rvu->pf_mbox_addr);
+}
+
+int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
+			    int blkaddr, int nixlf)
+{
+	int qints, hwctx_size, err;
+	u64 cfg, ctx_cfg;
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
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
index 58152a4024ec..df2d52567da7 100644
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
index 000000000000..fccad6e422e8
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
index 1e3e72107a9d..4ff3aa58d3d4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -46,8 +46,10 @@ void __otx2_mbox_reset(struct otx2_mbox *mbox, int devid)
 	mdev->rsp_size = 0;
 	tx_hdr->num_msgs = 0;
 	tx_hdr->msg_size = 0;
+	tx_hdr->sig = 0;
 	rx_hdr->num_msgs = 0;
 	rx_hdr->msg_size = 0;
+	rx_hdr->sig = 0;
 }
 EXPORT_SYMBOL(__otx2_mbox_reset);
 
@@ -71,9 +73,78 @@ void otx2_mbox_destroy(struct otx2_mbox *mbox)
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
@@ -252,7 +323,10 @@ static void otx2_mbox_msg_send_data(struct otx2_mbox *mbox, int devid, u64 data)
 
 	spin_lock(&mdev->mbox_lock);
 
-	tx_hdr->msg_size = mdev->msg_size;
+	if (!tx_hdr->sig) {
+		tx_hdr->msg_size = mdev->msg_size;
+		tx_hdr->num_msgs = mdev->num_msgs;
+	}
 
 	/* Reset header for next messages */
 	mdev->msg_size = 0;
@@ -266,7 +340,6 @@ static void otx2_mbox_msg_send_data(struct otx2_mbox *mbox, int devid, u64 data)
 	 * messages.  So this should be written after writing all the messages
 	 * to the shared memory.
 	 */
-	tx_hdr->num_msgs = mdev->num_msgs;
 	rx_hdr->num_msgs = 0;
 
 	trace_otx2_msg_send(mbox->pdev, tx_hdr->num_msgs, tx_hdr->msg_size);
@@ -324,6 +397,7 @@ struct mbox_msghdr *otx2_mbox_alloc_msg_rsp(struct otx2_mbox *mbox, int devid,
 {
 	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
 	struct mbox_msghdr *msghdr = NULL;
+	struct mbox_hdr *mboxhdr = NULL;
 
 	spin_lock(&mdev->mbox_lock);
 	size = ALIGN(size, MBOX_MSG_ALIGN);
@@ -347,6 +421,11 @@ struct mbox_msghdr *otx2_mbox_alloc_msg_rsp(struct otx2_mbox *mbox, int devid,
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
index e5c9fcf113c4..745db2c07962 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -13,6 +13,7 @@
 
 #include "rvu_struct.h"
 #include "common.h"
+#include "cn20k/struct.h"
 
 #define MBOX_SIZE		SZ_64K
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index dcf9ad75b3e9..5ac549f16556 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -755,6 +755,11 @@ static void rvu_free_hw_resources(struct rvu *rvu)
 
 	rvu_reset_msix(rvu);
 	mutex_destroy(&rvu->rsrc_lock);
+
+	/* Free the QINT/CINt memory */
+	pfvf = &rvu->pf[RVU_AFPF];
+	qmem_free(rvu->dev, pfvf->nix_qints_ctx);
+	qmem_free(rvu->dev, pfvf->cq_ints_ctx);
 }
 
 static void rvu_setup_pfvf_macaddress(struct rvu *rvu)
@@ -814,13 +819,13 @@ static int rvu_fwdata_init(struct rvu *rvu)
 		goto fail;
 
 	BUILD_BUG_ON(offsetof(struct rvu_fwdata, cgx_fw_data) > FWDATA_CGX_LMAC_OFFSET);
-	rvu->fwdata = ioremap_wc(fwdbase, sizeof(struct rvu_fwdata));
+	rvu->fwdata = (__force struct rvu_fwdata *)ioremap_wc(fwdbase, sizeof(struct rvu_fwdata));
 	if (!rvu->fwdata)
 		goto fail;
 	if (!is_rvu_fwdata_valid(rvu)) {
 		dev_err(rvu->dev,
 			"Mismatch in 'fwdata' struct btw kernel and firmware\n");
-		iounmap(rvu->fwdata);
+		iounmap((void __iomem *)rvu->fwdata);
 		rvu->fwdata = NULL;
 		return -EINVAL;
 	}
@@ -833,7 +838,7 @@ static int rvu_fwdata_init(struct rvu *rvu)
 static void rvu_fwdata_exit(struct rvu *rvu)
 {
 	if (rvu->fwdata)
-		iounmap(rvu->fwdata);
+		iounmap((void __iomem *)rvu->fwdata);
 }
 
 static int rvu_setup_nix_hw_resource(struct rvu *rvu, int blkaddr)
@@ -2399,7 +2404,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 				bar4 = rvupf_read64(rvu, RVU_PF_VF_BAR4_ADDR);
 				bar4 += region * MBOX_SIZE;
 			}
-			mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+			mbox_addr[region] = (__force void *)ioremap_wc(bar4, MBOX_SIZE);
 			if (!mbox_addr[region])
 				goto error;
 		}
@@ -2422,7 +2427,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 					  RVU_AF_PF_BAR4_ADDR);
 			bar4 += region * MBOX_SIZE;
 		}
-		mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+		mbox_addr[region] = (__force void *)ioremap_wc(bar4, MBOX_SIZE);
 		if (!mbox_addr[region])
 			goto error;
 	}
@@ -2683,6 +2688,11 @@ static void rvu_enable_mbox_intr(struct rvu *rvu)
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
@@ -2936,9 +2946,12 @@ static void rvu_unregister_interrupts(struct rvu *rvu)
 
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
@@ -3001,20 +3014,30 @@ static int rvu_register_interrupts(struct rvu *rvu)
 		return ret;
 	}
 
-	/* Register mailbox interrupt handler */
-	sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], "RVUAF Mbox");
-	ret = request_irq(pci_irq_vector
-			  (rvu->pdev, RVU_AF_INT_VEC_MBOX),
-			  rvu->ng_rvu->rvu_mbox_ops->pf_intr_handler, 0,
-			  &rvu->irq_name[RVU_AF_INT_VEC_MBOX *
-			  NAME_SIZE], rvu);
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
@@ -3467,6 +3490,9 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ptp_start(rvu, rvu->fwdata->sclk, rvu->fwdata->ptp_ext_clk_rate,
 			  rvu->fwdata->ptp_ext_tstamp);
 
+	/* Alloc CINT and QINT memory */
+	rvu_alloc_cint_qint_mem(rvu, &rvu->pf[RVU_AFPF], BLKADDR_NIX0,
+				(rvu->hw->block[BLKADDR_NIX0].lf.max));
 	return 0;
 err_dl:
 	rvu_unregister_dl(rvu);
@@ -3518,6 +3544,8 @@ static void rvu_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 
 	devm_kfree(&pdev->dev, rvu->hw);
+	if (is_cn20k(rvu->pdev))
+		cn20k_free_mbox_memory(rvu);
 	kfree(rvu->ng_rvu);
 	devm_kfree(&pdev->dev, rvu);
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index d8c572611d21..7ba3401417a9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -47,6 +47,9 @@
 #define RVU_PFVF_FUNC_MASK	rvu_pcifunc_func_mask
 
 #ifdef CONFIG_DEBUG_FS
+
+#define RVU_AFPF           25
+
 struct dump_ctx {
 	int	lf;
 	int	id;
@@ -444,6 +447,16 @@ struct mbox_wq_info {
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
@@ -977,7 +990,8 @@ int rvu_nix_mcast_get_mce_index(struct rvu *rvu, u16 pcifunc,
 int rvu_nix_mcast_update_mcam_entry(struct rvu *rvu, u16 pcifunc,
 				    u32 mcast_grp_idx, u16 mcam_index);
 void rvu_nix_flr_free_bpids(struct rvu *rvu, u16 pcifunc);
-
+int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
+			    int blkaddr, int nixlf);
 /* NPC APIs */
 void rvu_npc_freemem(struct rvu *rvu);
 int rvu_npc_get_pkind(struct rvu *rvu, u16 pf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 523ecb798a7a..ae2276556707 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -22,10 +22,10 @@ static void otx2_nix_rq_op_stats(struct queue_stats *stats,
 	u64 incr = (u64)qidx << 32;
 	u64 *ptr;
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_RQ_OP_OCTS);
+	ptr = (__force u64 *)otx2_get_regaddr(pfvf, NIX_LF_RQ_OP_OCTS);
 	stats->bytes = otx2_atomic64_add(incr, ptr);
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_RQ_OP_PKTS);
+	ptr = (__force u64 *)otx2_get_regaddr(pfvf, NIX_LF_RQ_OP_PKTS);
 	stats->pkts = otx2_atomic64_add(incr, ptr);
 }
 
@@ -35,10 +35,10 @@ static void otx2_nix_sq_op_stats(struct queue_stats *stats,
 	u64 incr = (u64)qidx << 32;
 	u64 *ptr;
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_OCTS);
+	ptr = (__force u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_OCTS);
 	stats->bytes = otx2_atomic64_add(incr, ptr);
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_PKTS);
+	ptr = (__force u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_PKTS);
 	stats->pkts = otx2_atomic64_add(incr, ptr);
 }
 
@@ -846,7 +846,7 @@ void otx2_sqb_flush(struct otx2_nic *pfvf)
 	struct otx2_snd_queue *sq;
 	u64 incr, *ptr, val;
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_STATUS);
+	ptr = (__force u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_STATUS);
 	for (qidx = 0; qidx < otx2_get_total_tx_queues(pfvf); qidx++) {
 		sq = &pfvf->qset.sq[qidx];
 		if (!sq->sqb_ptrs)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index e310f99b1736..fde1a3f46297 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -594,8 +594,7 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 		base = pci_resource_start(pf->pdev, PCI_MBOX_BAR_NUM) +
 		       MBOX_SIZE;
 	else
-		base = readq((void __iomem *)((u64)pf->reg_base +
-					      RVU_PF_VF_BAR4_ADDR));
+		base = readq((pf->reg_base + RVU_PF_VF_BAR4_ADDR));
 
 	hwbase = ioremap_wc(base, MBOX_SIZE * pf->total_vfs);
 	if (!hwbase) {
@@ -644,7 +643,7 @@ static void otx2_pfvf_mbox_destroy(struct otx2_nic *pf)
 	}
 
 	if (mbox->mbox.hwbase)
-		iounmap(mbox->mbox.hwbase);
+		iounmap((void __iomem *)mbox->mbox.hwbase);
 
 	otx2_mbox_destroy(&mbox->mbox);
 }
@@ -1308,7 +1307,7 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 
 	/* CQ */
 	for (qidx = 0; qidx < pf->qset.cq_cnt; qidx++) {
-		ptr = otx2_get_regaddr(pf, NIX_LF_CQ_OP_INT);
+		ptr = (__force u64 *)otx2_get_regaddr(pf, NIX_LF_CQ_OP_INT);
 		val = otx2_atomic64_add((qidx << 44), ptr);
 
 		otx2_write64(pf, NIX_LF_CQ_OP_INT, (qidx << 44) |
@@ -1347,7 +1346,7 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 		 * these are fatal errors.
 		 */
 
-		ptr = otx2_get_regaddr(pf, NIX_LF_SQ_OP_INT);
+		ptr = (__force u64 *)otx2_get_regaddr(pf, NIX_LF_SQ_OP_INT);
 		val = otx2_atomic64_add((qidx << 44), ptr);
 		otx2_write64(pf, NIX_LF_SQ_OP_INT, (qidx << 44) |
 			     (val & NIX_SQINT_BITS));
-- 
2.25.1


