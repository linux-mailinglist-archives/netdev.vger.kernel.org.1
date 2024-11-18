Return-Path: <netdev+bounces-145893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 169469D13E5
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CED31F2426C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3241C07DE;
	Mon, 18 Nov 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SZApLFji"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF251B21A0;
	Mon, 18 Nov 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942151; cv=none; b=Pm/L/HSIopKhOvNvXZ+6EPiuax0hquVoUUN2cxS+rYbSpIvvWidpBxg39yTLTvFmTIjYggoVJKxLkROuxqN9TulombRTaFimsYwKeRiPvxxSjS5CcxBEaG2ANjI5t7Z9o21ZXd3JefGT0DIXmv/4G/Ycj1AfF32iBkKXjtZhE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942151; c=relaxed/simple;
	bh=uc9tpeUfV1zAciBquOSiBlZcL3Eh+jGxCRv108Co8Jk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmWobqOvHWo36/I5q54idDPZl0HWyrTm91I0kV/ZHsy/DHvoBSg9sAMsa0NDCadVMEETTEcOhBN8NzIx8Z5j0Me1PbAkXu8NG/etO+1BJpTn++WrW5Wp7LbPZ9kbh4t7Tj7YOciTMsBBsXn5ZbNMAColH8vzpQAvdlN5e7ozQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SZApLFji; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI80wsw025334;
	Mon, 18 Nov 2024 07:02:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	UirFkeowe9OOh0x/Wy6ezyr1xP5nQ+Kkx9myb8YQYA=; b=SZApLFji57ShCkQiK
	Br8l0Hv/c9UzpcxP9Wvc3SeTrS+t3cWjPqiSARPQKMTAs65icZUC2wQ2uwIygE1l
	6YzGMk8Qde69ZUNmZppMAAl9BqUd4BdWhPdlbl/DguWFziT+FJNha5HeuDJZHz74
	Wyh3Q4Qyecuw8i1lGJsnpFalukxWlgAaxrDhZ9t4ZKzouXO2vSwqdLHGjPTFUJIE
	XLe8LoHQU6Is3zOX3sMoNAa6xqz2XHDUy6GSWHglv8Nur8xCywTPqIoJs89/9FWv
	I9nllRlOLvK0RX2qSxKnfR6lIM1qITUFyASUuU6tSZlRSDotm+5zIlm5sb7F2Xcs
	B4QaQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4301ps8pax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 07:02:16 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 18 Nov 2024 07:01:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 18 Nov 2024 07:01:58 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id EC04D3F7041;
	Mon, 18 Nov 2024 07:01:53 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v4 5/6] octeontx2-af: CN20K mbox implementation for AF's VF
Date: Mon, 18 Nov 2024 20:31:23 +0530
Message-ID: <20241118150124.984323-6-saikrishnag@marvell.com>
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
X-Proofpoint-ORIG-GUID: QOxSC0VryLlVfiZYieWpounMNYPhEsQE
X-Proofpoint-GUID: QOxSC0VryLlVfiZYieWpounMNYPhEsQE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

This patch implements the CN20k MBOX communication between AF and
AF's VFs. This implementation uses separate trigger interrupts
for request, response messages against using trigger message data in CN10K.

Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/api.h |   4 +
 .../marvell/octeontx2/af/cn20k/mbox_init.c    | 163 +++++++++++++++++-
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |  37 ++++
 .../net/ethernet/marvell/octeontx2/af/mbox.c  |  28 +++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  67 ++++---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   3 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    |  47 +++++
 .../marvell/octeontx2/nic/otx2_common.h       |  18 ++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |  15 ++
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  38 +++-
 11 files changed, 389 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
index 9436a4a4d815..0617bf5a56e9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
@@ -13,6 +13,7 @@
 struct ng_rvu {
 	struct mbox_ops         *rvu_mbox_ops;
 	struct qmem             *pf_mbox_addr;
+	struct qmem             *vf_mbox_addr;
 };
 
 struct rvu;
@@ -20,6 +21,7 @@ struct rvu;
 /* Mbox related APIs */
 int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int num);
 int cn20k_register_afpf_mbox_intr(struct rvu *rvu);
+int cn20k_register_afvf_mbox_intr(struct rvu *rvu, int pf_vec_start);
 int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 			       int num, int type, unsigned long *pf_bmap);
 void cn20k_rvu_enable_mbox_intr(struct rvu *rvu);
@@ -27,4 +29,6 @@ void cn20k_rvu_unregister_interrupts(struct rvu *rvu);
 void cn20k_free_mbox_memory(struct rvu *rvu);
 int cn20k_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
 		     void *reg_base, int direction, int ndevs);
+void cn20k_rvu_enable_afvf_intr(struct rvu *rvu, int vfs);
+void cn20k_rvu_disable_afvf_intr(struct rvu *rvu, int vfs);
 #endif /* CN20K_API_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
index 377e3f579184..bdf21dd672e4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
@@ -13,6 +13,91 @@
 #include "reg.h"
 #include "api.h"
 
+static irqreturn_t cn20k_afvf_mbox_intr_handler(int irq, void *rvu_irq)
+{
+	struct rvu_irq_data *rvu_irq_data = rvu_irq;
+	struct rvu *rvu = rvu_irq_data->rvu;
+	u64 intr;
+
+	/* Sync with mbox memory region */
+	rmb();
+
+	/* Clear interrupts */
+	intr = rvupf_read64(rvu, rvu_irq_data->intr_status);
+	rvupf_write64(rvu, rvu_irq_data->intr_status, intr);
+
+	if (intr)
+		trace_otx2_msg_interrupt(rvu->pdev, "VF(s) to AF", intr);
+
+	rvu_irq_data->afvf_queue_work_hdlr(&rvu->afvf_wq_info, rvu_irq_data->start,
+					   rvu_irq_data->mdevs, intr);
+
+	return IRQ_HANDLED;
+}
+
+int cn20k_register_afvf_mbox_intr(struct rvu *rvu, int pf_vec_start)
+{
+	struct rvu_irq_data *irq_data;
+	int intr_vec, offset, vec = 0;
+	int err;
+
+	/* irq data for 4 VFPF intr vectors */
+	irq_data = devm_kcalloc(rvu->dev, 4,
+				sizeof(struct rvu_irq_data), GFP_KERNEL);
+	if (!irq_data)
+		return -ENOMEM;
+
+	for (intr_vec = RVU_MBOX_PF_INT_VEC_VFPF_MBOX0; intr_vec <=
+					RVU_MBOX_PF_INT_VEC_VFPF1_MBOX1;
+					intr_vec++, vec++) {
+		switch (intr_vec) {
+		case RVU_MBOX_PF_INT_VEC_VFPF_MBOX0:
+			irq_data[vec].intr_status =
+						RVU_MBOX_PF_VFPF_INTX(0);
+			irq_data[vec].start = 0;
+			irq_data[vec].mdevs = 64;
+			break;
+		case RVU_MBOX_PF_INT_VEC_VFPF_MBOX1:
+			irq_data[vec].intr_status =
+						RVU_MBOX_PF_VFPF_INTX(1);
+			irq_data[vec].start = 64;
+			irq_data[vec].mdevs = 64;
+			break;
+		case RVU_MBOX_PF_INT_VEC_VFPF1_MBOX0:
+			irq_data[vec].intr_status =
+						RVU_MBOX_PF_VFPF1_INTX(0);
+			irq_data[vec].start = 0;
+			irq_data[vec].mdevs = 64;
+			break;
+		case RVU_MBOX_PF_INT_VEC_VFPF1_MBOX1:
+			irq_data[vec].intr_status = RVU_MBOX_PF_VFPF1_INTX(1);
+			irq_data[vec].start = 64;
+			irq_data[vec].mdevs = 64;
+			break;
+		}
+		irq_data[vec].afvf_queue_work_hdlr =
+						rvu_queue_work;
+		offset = pf_vec_start + intr_vec;
+		irq_data[vec].vec_num = offset;
+		irq_data[vec].rvu = rvu;
+
+		sprintf(&rvu->irq_name[offset * NAME_SIZE], "RVUAF VFAF%d Mbox%d",
+			vec / 2, vec % 2);
+		err = request_irq(pci_irq_vector(rvu->pdev, offset),
+				  rvu->ng_rvu->rvu_mbox_ops->afvf_intr_handler, 0,
+				  &rvu->irq_name[offset * NAME_SIZE],
+				  &irq_data[vec]);
+		if (err) {
+			dev_err(rvu->dev,
+				"RVUAF: IRQ registration failed for AFVF mbox irq\n");
+			return err;
+		}
+		rvu->irq_allocated[offset] = true;
+	}
+
+	return 0;
+}
+
 /* CN20K mbox PFx => AF irq handler */
 static irqreturn_t cn20k_mbox_pf_common_intr_handler(int irq, void *rvu_irq)
 {
@@ -150,6 +235,21 @@ int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 	int region;
 	u64 bar;
 
+	if (type == TYPE_AFVF) {
+		for (region = 0; region < num; region++) {
+			if (!test_bit(region, pf_bmap))
+				continue;
+
+			bar = (u64)phys_to_virt((u64)rvu->ng_rvu->vf_mbox_addr->base);
+			bar += region * MBOX_SIZE;
+			mbox_addr[region] = (void *)bar;
+
+			if (!mbox_addr[region])
+				return -ENOMEM;
+		}
+		return 0;
+	}
+
 	for (region = 0; region < num; region++) {
 		if (!test_bit(region, pf_bmap))
 			continue;
@@ -167,6 +267,7 @@ int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 
 static struct mbox_ops cn20k_mbox_ops = {
 	.pf_intr_handler = cn20k_mbox_pf_common_intr_handler,
+	.afvf_intr_handler = cn20k_afvf_mbox_intr_handler,
 };
 
 static int rvu_alloc_mbox_memory(struct rvu *rvu, int type,
@@ -184,6 +285,9 @@ static int rvu_alloc_mbox_memory(struct rvu *rvu, int type,
 	 *
 	 * AF will access mbox memory using direct physical addresses
 	 * and PFs will access the same shared memory from BAR2.
+	 *
+	 * PF <=> VF mbox memory also works in the same fashion.
+	 * AFPF, PFVF requires IOVA to be used to maintain the mailbox msgs
 	 */
 
 	err = qmem_alloc(rvu->dev, &mbox_addr, ndevs, mbox_size);
@@ -200,6 +304,10 @@ static int rvu_alloc_mbox_memory(struct rvu *rvu, int type,
 			iova += mbox_size;
 		}
 		break;
+	case TYPE_AFVF:
+		rvu->ng_rvu->vf_mbox_addr = mbox_addr;
+		rvupf_write64(rvu, RVU_PF_VF_MBOX_ADDR, (u64)mbox_addr->iova);
+		break;
 	default:
 		return 0;
 	}
@@ -216,9 +324,13 @@ int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int ndevs)
 
 	rvu->ng_rvu->rvu_mbox_ops = &cn20k_mbox_ops;
 
-	for (dev = 0; dev < ndevs; dev++)
-		rvu_write64(rvu, BLKADDR_RVUM,
-			    RVU_MBOX_AF_PFX_CFG(dev), ilog2(MBOX_SIZE));
+	if (type == TYPE_AFVF) {
+		rvu_write64(rvu, BLKADDR_RVUM, RVU_MBOX_PF_VF_CFG, ilog2(MBOX_SIZE));
+	} else {
+		for (dev = 0; dev < ndevs; dev++)
+			rvu_write64(rvu, BLKADDR_RVUM,
+				    RVU_MBOX_AF_PFX_CFG(dev), ilog2(MBOX_SIZE));
+	}
 
 	return rvu_alloc_mbox_memory(rvu, type, ndevs, MBOX_SIZE);
 }
@@ -226,6 +338,51 @@ int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int ndevs)
 void cn20k_free_mbox_memory(struct rvu *rvu)
 {
 	qmem_free(rvu->dev, rvu->ng_rvu->pf_mbox_addr);
+	qmem_free(rvu->dev, rvu->ng_rvu->vf_mbox_addr);
+}
+
+void cn20k_rvu_disable_afvf_intr(struct rvu *rvu, int vfs)
+{
+	rvupf_write64(rvu, RVU_MBOX_PF_VFPF_INT_ENA_W1CX(0), INTR_MASK(vfs));
+	rvupf_write64(rvu, RVU_MBOX_PF_VFPF1_INT_ENA_W1CX(0), INTR_MASK(vfs));
+	rvupf_write64(rvu, RVU_PF_VFFLR_INT_ENA_W1CX(0), INTR_MASK(vfs));
+	rvupf_write64(rvu, RVU_PF_VFME_INT_ENA_W1CX(0), INTR_MASK(vfs));
+
+	if (vfs <= 64)
+		return;
+
+	rvupf_write64(rvu, RVU_MBOX_PF_VFPF_INT_ENA_W1CX(1), INTR_MASK(vfs - 64));
+	rvupf_write64(rvu, RVU_MBOX_PF_VFPF1_INT_ENA_W1CX(1), INTR_MASK(vfs - 64));
+	rvupf_write64(rvu, RVU_PF_VFFLR_INT_ENA_W1CX(1), INTR_MASK(vfs - 64));
+	rvupf_write64(rvu, RVU_PF_VFME_INT_ENA_W1CX(1), INTR_MASK(vfs - 64));
+}
+
+void cn20k_rvu_enable_afvf_intr(struct rvu *rvu, int vfs)
+{
+	/* Clear any pending interrupts and enable AF VF interrupts for
+	 * the first 64 VFs.
+	 */
+	rvupf_write64(rvu, RVU_MBOX_PF_VFPF_INTX(0), INTR_MASK(vfs));
+	rvupf_write64(rvu, RVU_MBOX_PF_VFPF_INT_ENA_W1SX(0), INTR_MASK(vfs));
+	rvupf_write64(rvu, RVU_MBOX_PF_VFPF1_INTX(0), INTR_MASK(vfs));
+	rvupf_write64(rvu, RVU_MBOX_PF_VFPF1_INT_ENA_W1SX(0), INTR_MASK(vfs));
+
+	/* FLR */
+	rvupf_write64(rvu, RVU_PF_VFFLR_INTX(0), INTR_MASK(vfs));
+	rvupf_write64(rvu, RVU_PF_VFFLR_INT_ENA_W1SX(0), INTR_MASK(vfs));
+
+	/* Same for remaining VFs, if any. */
+	if (vfs <= 64)
+		return;
+
+	rvupf_write64(rvu, RVU_MBOX_PF_VFPF_INTX(1), INTR_MASK(vfs - 64));
+	rvupf_write64(rvu, RVU_MBOX_PF_VFPF_INT_ENA_W1SX(1), INTR_MASK(vfs - 64));
+	rvupf_write64(rvu, RVU_MBOX_PF_VFPF1_INTX(1), INTR_MASK(vfs - 64));
+	rvupf_write64(rvu, RVU_MBOX_PF_VFPF1_INT_ENA_W1SX(1), INTR_MASK(vfs - 64));
+
+	rvupf_write64(rvu, RVU_PF_VFFLR_INTX(1), INTR_MASK(vfs - 64));
+	rvupf_write64(rvu, RVU_PF_VFFLR_INT_ENA_W1SX(1), INTR_MASK(vfs - 64));
+	rvupf_write64(rvu, RVU_PF_VFME_INT_ENA_W1SX(1), INTR_MASK(vfs - 64));
 }
 
 int rvu_alloc_cint_qint_mem(struct rvu *rvu, struct rvu_pfvf *pfvf,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
index df2d52567da7..affb39803120 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
@@ -41,4 +41,41 @@
 #define NIX_CINTX_INT_W1S(a)			(0xd30 | (a) << 12)
 #define NIX_QINTX_CNT(a)			(0xc00 | (a) << 12)
 
+#define RVU_MBOX_AF_VFAF_INT(a)			(0x3000 | (a) << 6)
+#define RVU_MBOX_AF_VFAF_INT_W1S(a)		(0x3008 | (a) << 6)
+#define RVU_MBOX_AF_VFAF_INT_ENA_W1S(a)		(0x3010 | (a) << 6)
+#define RVU_MBOX_AF_VFAF_INT_ENA_W1C(a)		(0x3018 | (a) << 6)
+#define RVU_MBOX_AF_VFAF_INT_ENA_W1C(a)		(0x3018 | (a) << 6)
+#define RVU_MBOX_AF_VFAF1_INT(a)		(0x3020 | (a) << 6)
+#define RVU_MBOX_AF_VFAF1_INT_W1S(a)		(0x3028 | (a) << 6)
+#define RVU_MBOX_AF_VFAF1_IN_ENA_W1S(a)		(0x3030 | (a) << 6)
+#define RVU_MBOX_AF_VFAF1_IN_ENA_W1C(a)		(0x3038 | (a) << 6)
+
+#define RVU_MBOX_AF_AFVFX_TRIG(a, b)		(0x10000 | (a) << 4 | (b) << 3)
+#define RVU_MBOX_AF_VFX_ADDR(a)			(0x20000 | (a) << 4)
+#define RVU_MBOX_AF_VFX_CFG(a)			(0x28000 | (a) << 4)
+
+#define RVU_MBOX_PF_VFX_PFVF_TRIGX(a)		(0x2000 | (a) << 3)
+
+#define RVU_MBOX_PF_VFPF_INTX(a)		(0x1000 | (a) << 3)
+#define RVU_MBOX_PF_VFPF_INT_W1SX(a)		(0x1020 | (a) << 3)
+#define RVU_MBOX_PF_VFPF_INT_ENA_W1SX(a)	(0x1040 | (a) << 3)
+#define RVU_MBOX_PF_VFPF_INT_ENA_W1CX(a)	(0x1060 | (a) << 3)
+
+#define RVU_MBOX_PF_VFPF1_INTX(a)		(0x1080 | (a) << 3)
+#define RVU_MBOX_PF_VFPF1_INT_W1SX(a)		(0x10a0 | (a) << 3)
+#define RVU_MBOX_PF_VFPF1_INT_ENA_W1SX(a)	(0x10c0 | (a) << 3)
+#define RVU_MBOX_PF_VFPF1_INT_ENA_W1CX(a)	(0x10e0 | (a) << 3)
+
+#define RVU_MBOX_PF_VF_ADDR			(0xC40)
+#define RVU_MBOX_PF_LMTLINE_ADDR		(0xC48)
+#define RVU_MBOX_PF_VF_CFG			(0xC60)
+
+#define RVU_MBOX_VF_VFPF_TRIGX(a)		(0x3000 | (a) << 3)
+#define RVU_MBOX_VF_INT				(0x20)
+#define RVU_MBOX_VF_INT_W1S			(0x28)
+#define RVU_MBOX_VF_INT_ENA_W1S			(0x30)
+#define RVU_MBOX_VF_INT_ENA_W1C			(0x38)
+
+#define RVU_MBOX_VF_VFAF_TRIGX(a)		(0x2000 | (a) << 3)
 #endif /* RVU_MBOX_REG_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 4ff3aa58d3d4..e142f8d99d77 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -76,26 +76,38 @@ EXPORT_SYMBOL(otx2_mbox_destroy);
 int cn20k_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
 		     void *reg_base, int direction, int ndevs)
 {
+	/* For CN20K, PF and VF bit encodings in PCIFUNC are changed.
+	 * Hence set the PF and VF masks here.
+	 */
+	rvu_pcifunc_pf_shift = 9;
+	rvu_pcifunc_pf_mask = 0x7F;
+	rvu_pcifunc_func_shift = 0;
+	rvu_pcifunc_func_mask = 0x1FF;
+
 	switch (direction) {
 	case MBOX_DIR_AFPF:
+	case MBOX_DIR_PFVF:
 		mbox->tx_start = MBOX_DOWN_TX_START;
 		mbox->rx_start = MBOX_DOWN_RX_START;
 		mbox->tx_size  = MBOX_DOWN_TX_SIZE;
 		mbox->rx_size  = MBOX_DOWN_RX_SIZE;
 		break;
 	case MBOX_DIR_PFAF:
+	case MBOX_DIR_VFPF:
 		mbox->tx_start = MBOX_DOWN_RX_START;
 		mbox->rx_start = MBOX_DOWN_TX_START;
 		mbox->tx_size  = MBOX_DOWN_RX_SIZE;
 		mbox->rx_size  = MBOX_DOWN_TX_SIZE;
 		break;
 	case MBOX_DIR_AFPF_UP:
+	case MBOX_DIR_PFVF_UP:
 		mbox->tx_start = MBOX_UP_TX_START;
 		mbox->rx_start = MBOX_UP_RX_START;
 		mbox->tx_size  = MBOX_UP_TX_SIZE;
 		mbox->rx_size  = MBOX_UP_RX_SIZE;
 		break;
 	case MBOX_DIR_PFAF_UP:
+	case MBOX_DIR_VFPF_UP:
 		mbox->tx_start = MBOX_UP_RX_START;
 		mbox->rx_start = MBOX_UP_TX_START;
 		mbox->tx_size  = MBOX_UP_RX_SIZE;
@@ -122,6 +134,22 @@ int cn20k_mbox_setup(struct otx2_mbox *mbox, struct pci_dev *pdev,
 		mbox->trigger = RVU_MBOX_PF_PFAF_TRIGX(1);
 		mbox->tr_shift = 0;
 		break;
+	case MBOX_DIR_PFVF:
+		mbox->trigger = RVU_MBOX_PF_VFX_PFVF_TRIGX(1);
+		mbox->tr_shift = 4;
+		break;
+	case MBOX_DIR_PFVF_UP:
+		mbox->trigger = RVU_MBOX_PF_VFX_PFVF_TRIGX(0);
+		mbox->tr_shift = 4;
+		break;
+	case MBOX_DIR_VFPF:
+		mbox->trigger = RVU_MBOX_VF_VFPF_TRIGX(0);
+		mbox->tr_shift = 0;
+		break;
+	case MBOX_DIR_VFPF_UP:
+		mbox->trigger = RVU_MBOX_VF_VFPF_TRIGX(1);
+		mbox->tr_shift = 0;
+		break;
 	default:
 		return -ENODEV;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 5ac549f16556..e79297c8c2b5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2441,6 +2441,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 
 static struct mbox_ops rvu_mbox_ops = {
 	.pf_intr_handler = rvu_mbox_pf_intr_handler,
+	.afvf_intr_handler = rvu_mbox_intr_handler,
 };
 
 static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
@@ -2984,6 +2985,10 @@ static int rvu_afvf_msix_vectors_num_ok(struct rvu *rvu)
 	 * VF interrupts can be handled. Offset equal to zero means
 	 * that PF vectors are not configured and overlapping AF vectors.
 	 */
+	if (is_cn20k(rvu->pdev))
+		return (pfvf->msix.max >= RVU_AF_CN20K_INT_VEC_CNT +
+			RVU_MBOX_PF_INT_VEC_CNT) && offset;
+
 	return (pfvf->msix.max >= RVU_AF_INT_VEC_CNT + RVU_PF_INT_VEC_CNT) &&
 	       offset;
 }
@@ -3092,34 +3097,40 @@ static int rvu_register_interrupts(struct rvu *rvu)
 	/* Get PF MSIX vectors offset. */
 	pf_vec_start = rvu_read64(rvu, BLKADDR_RVUM,
 				  RVU_PRIV_PFX_INT_CFG(0)) & 0x3ff;
+	if (!is_cn20k(rvu->pdev)) {
+		/* Register MBOX0 interrupt. */
+		offset = pf_vec_start + RVU_PF_INT_VEC_VFPF_MBOX0;
+		sprintf(&rvu->irq_name[offset * NAME_SIZE], "RVUAFVF Mbox0");
+		ret = request_irq(pci_irq_vector(rvu->pdev, offset),
+				  rvu->ng_rvu->rvu_mbox_ops->afvf_intr_handler, 0,
+				  &rvu->irq_name[offset * NAME_SIZE],
+				  rvu);
+		if (ret)
+			dev_err(rvu->dev,
+				"RVUAF: IRQ registration failed for Mbox0\n");
 
-	/* Register MBOX0 interrupt. */
-	offset = pf_vec_start + RVU_PF_INT_VEC_VFPF_MBOX0;
-	sprintf(&rvu->irq_name[offset * NAME_SIZE], "RVUAFVF Mbox0");
-	ret = request_irq(pci_irq_vector(rvu->pdev, offset),
-			  rvu_mbox_intr_handler, 0,
-			  &rvu->irq_name[offset * NAME_SIZE],
-			  rvu);
-	if (ret)
-		dev_err(rvu->dev,
-			"RVUAF: IRQ registration failed for Mbox0\n");
-
-	rvu->irq_allocated[offset] = true;
+		rvu->irq_allocated[offset] = true;
 
-	/* Register MBOX1 interrupt. MBOX1 IRQ number follows MBOX0 so
-	 * simply increment current offset by 1.
-	 */
-	offset = pf_vec_start + RVU_PF_INT_VEC_VFPF_MBOX1;
-	sprintf(&rvu->irq_name[offset * NAME_SIZE], "RVUAFVF Mbox1");
-	ret = request_irq(pci_irq_vector(rvu->pdev, offset),
-			  rvu_mbox_intr_handler, 0,
-			  &rvu->irq_name[offset * NAME_SIZE],
-			  rvu);
-	if (ret)
-		dev_err(rvu->dev,
-			"RVUAF: IRQ registration failed for Mbox1\n");
+		/* Register MBOX1 interrupt. MBOX1 IRQ number follows MBOX0 so
+		 * simply increment current offset by 1.
+		 */
+		offset = pf_vec_start + RVU_PF_INT_VEC_VFPF_MBOX1;
+		sprintf(&rvu->irq_name[offset * NAME_SIZE], "RVUAFVF Mbox1");
+		ret = request_irq(pci_irq_vector(rvu->pdev, offset),
+				  rvu->ng_rvu->rvu_mbox_ops->afvf_intr_handler, 0,
+				  &rvu->irq_name[offset * NAME_SIZE],
+				  rvu);
+		if (ret)
+			dev_err(rvu->dev,
+				"RVUAF: IRQ registration failed for Mbox1\n");
 
-	rvu->irq_allocated[offset] = true;
+		rvu->irq_allocated[offset] = true;
+	} else {
+		ret = cn20k_register_afvf_mbox_intr(rvu, pf_vec_start);
+		if (ret)
+			dev_err(rvu->dev,
+				"RVUAF: IRQ registration failed for Mbox\n");
+	}
 
 	/* Register FLR interrupt handler for AF's VFs */
 	offset = pf_vec_start + RVU_PF_INT_VEC_VFFLR0;
@@ -3230,6 +3241,9 @@ static void rvu_disable_afvf_intr(struct rvu *rvu)
 {
 	int vfs = rvu->vfs;
 
+	if (is_cn20k(rvu->pdev))
+		return cn20k_rvu_disable_afvf_intr(rvu, vfs);
+
 	rvupf_write64(rvu, RVU_PF_VFPF_MBOX_INT_ENA_W1CX(0), INTR_MASK(vfs));
 	rvupf_write64(rvu, RVU_PF_VFFLR_INT_ENA_W1CX(0), INTR_MASK(vfs));
 	rvupf_write64(rvu, RVU_PF_VFME_INT_ENA_W1CX(0), INTR_MASK(vfs));
@@ -3246,6 +3260,9 @@ static void rvu_enable_afvf_intr(struct rvu *rvu)
 {
 	int vfs = rvu->vfs;
 
+	if (is_cn20k(rvu->pdev))
+		return cn20k_rvu_enable_afvf_intr(rvu, vfs);
+
 	/* Clear any pending interrupts and enable AF VF interrupts for
 	 * the first 64 VFs.
 	 */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 7ba3401417a9..4756abdada5a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -451,6 +451,8 @@ struct rvu_irq_data {
 	u64 intr_status;
 	void (*rvu_queue_work_hdlr)(struct mbox_wq_info *mw, int first,
 				    int mdevs, u64 intr);
+	void (*afvf_queue_work_hdlr)(struct mbox_wq_info *mw, int first,
+				     int mdevs, u64 intr);
 	struct	rvu *rvu;
 	int vec_num;
 	int start;
@@ -459,6 +461,7 @@ struct rvu_irq_data {
 
 struct mbox_ops {
 	irqreturn_t (*pf_intr_handler)(int irq, void *rvu_irq);
+	irqreturn_t (*afvf_intr_handler)(int irq, void *rvu_irq);
 };
 
 struct channel_fwdata {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index d7a5f5449d55..ef37aa0564b5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -12,6 +12,7 @@
 
 static struct dev_hw_ops cn20k_hw_ops = {
 	.pfaf_mbox_intr_handler = cn20k_pfaf_mbox_intr_handler,
+	.vfaf_mbox_intr_handler = cn20k_vfaf_mbox_intr_handler,
 };
 
 void cn20k_init(struct otx2_nic *pfvf)
@@ -61,3 +62,49 @@ irqreturn_t cn20k_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 
 	return IRQ_HANDLED;
 }
+
+irqreturn_t cn20k_vfaf_mbox_intr_handler(int irq, void *vf_irq)
+{
+	struct otx2_nic *vf = vf_irq;
+	struct otx2_mbox_dev *mdev;
+	struct otx2_mbox *mbox;
+	struct mbox_hdr *hdr;
+	int vf_trig_val;
+
+	vf_trig_val = otx2_read64(vf, RVU_VF_INT) & 0x3;
+	/* Clear the IRQ */
+	otx2_write64(vf, RVU_VF_INT, vf_trig_val);
+
+	/* Read latest mbox data */
+	smp_rmb();
+
+	if (vf_trig_val & BIT_ULL(1)) {
+		/* Check for PF => VF response messages */
+		mbox = &vf->mbox.mbox;
+		mdev = &mbox->dev[0];
+		otx2_sync_mbox_bbuf(mbox, 0);
+
+		hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+		if (hdr->num_msgs)
+			queue_work(vf->mbox_wq, &vf->mbox.mbox_wrk);
+
+		trace_otx2_msg_interrupt(mbox->pdev, "DOWN reply from PF0 to VF",
+					 BIT_ULL(1));
+	}
+
+	if (vf_trig_val & BIT_ULL(0)) {
+		/* Check for PF => VF notification messages */
+		mbox = &vf->mbox.mbox_up;
+		mdev = &mbox->dev[0];
+		otx2_sync_mbox_bbuf(mbox, 0);
+
+		hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+		if (hdr->num_msgs)
+			queue_work(vf->mbox_wq, &vf->mbox.mbox_up_wrk);
+
+		trace_otx2_msg_interrupt(mbox->pdev, "UP message from PF0 to VF",
+					 BIT_ULL(0));
+	}
+
+	return IRQ_HANDLED;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 3875cfad8250..93cab5f845f3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -59,6 +59,8 @@
 
 irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq);
 irqreturn_t cn20k_pfaf_mbox_intr_handler(int irq, void *pf_irq);
+irqreturn_t cn20k_vfaf_mbox_intr_handler(int irq, void *vf_irq);
+irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq);
 
 enum arua_mapped_qtypes {
 	AURA_NIX_RQ,
@@ -238,6 +240,7 @@ struct otx2_hw {
 	u16			nix_msixoff; /* Offset of NIX vectors */
 	char			*irq_name;
 	cpumask_var_t           *affinity_mask;
+	struct pf_irq_data	*pfvf_irq_devid[4];
 
 	/* Stats */
 	struct otx2_dev_stats	dev_stats;
@@ -359,6 +362,7 @@ struct dev_hw_ops {
 	int	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
 	void	(*aura_freeptr)(void *dev, int aura, u64 buf);
 	irqreturn_t (*pfaf_mbox_intr_handler)(int irq, void *pf_irq);
+	irqreturn_t (*vfaf_mbox_intr_handler)(int irq, void *pf_irq);
 };
 
 #define CN10K_MCS_SA_PER_SC	4
@@ -426,6 +430,16 @@ struct cn10k_mcs_cfg {
 	struct list_head rxsc_list;
 };
 
+struct pf_irq_data {
+	u64 intr_status;
+	void (*pf_queue_work_hdlr)(struct mbox *mb, struct workqueue_struct *mw,
+				   int first, int mdevs, u64 intr);
+	struct otx2_nic *pf;
+	int vec_num;
+	int start;
+	int mdevs;
+};
+
 struct otx2_nic {
 	void __iomem		*reg_base;
 	struct net_device	*netdev;
@@ -468,6 +482,7 @@ struct otx2_nic {
 	struct mbox		*mbox_pfvf;
 	struct workqueue_struct *mbox_wq;
 	struct workqueue_struct *mbox_pfvf_wq;
+	struct qmem		*pfvf_mbox_addr;
 
 	u8			total_vfs;
 	u16			pcifunc; /* RVU PF_FUNC */
@@ -1145,4 +1160,7 @@ static inline int mcam_entry_cmp(const void *a, const void *b)
 {
 	return *(u16 *)a - *(u16 *)b;
 }
+
+void otx2_queue_vf_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
+			int first, int mdevs, u64 intr);
 #endif /* OTX2_COMMON_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index edc3cf227930..7d281be02389 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -292,8 +292,8 @@ static int otx2_pf_flr_init(struct otx2_nic *pf, int num_vfs)
 	return 0;
 }
 
-static void otx2_queue_vf_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
-			       int first, int mdevs, u64 intr)
+void otx2_queue_vf_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
+			int first, int mdevs, u64 intr)
 {
 	struct otx2_mbox_dev *mdev;
 	struct otx2_mbox *mbox;
@@ -537,7 +537,7 @@ static void otx2_pfvf_mbox_up_handler(struct work_struct *work)
 	}
 }
 
-static irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
+irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 {
 	struct otx2_nic *pf = (struct otx2_nic *)(pf_irq);
 	int vfs = pf->total_vfs;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
index 901f8cf7f27a..1cd576fd09c5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
@@ -44,6 +44,17 @@
 #define RVU_PF_VF_MBOX_ADDR                 (0xC40)
 #define RVU_PF_LMTLINE_ADDR                 (0xC48)
 
+#define RVU_MBOX_PF_VFX_PFVF_TRIGX(a)		(0x2000 | (a) << 3)
+#define RVU_MBOX_PF_VFPF_INTX(a)		(0x1000 | (a) << 3)
+#define RVU_MBOX_PF_VFPF_INT_W1SX(a)		(0x1020 | (a) << 3)
+#define RVU_MBOX_PF_VFPF_INT_ENA_W1SX(a)	(0x1040 | (a) << 3)
+#define RVU_MBOX_PF_VFPF_INT_ENA_W1CX(a)	(0x1060 | (a) << 3)
+
+#define RVU_MBOX_PF_VFPF1_INTX(a)		(0x1080 | (a) << 3)
+#define RVU_MBOX_PF_VFPF1_INT_W1SX(a)		(0x10a0 | (a) << 3)
+#define RVU_MBOX_PF_VFPF1_INT_ENA_W1SX(a)	(0x10c0 | (a) << 3)
+#define RVU_MBOX_PF_VFPF1_INT_ENA_W1CX(a)	(0x10e0 | (a) << 3)
+
 /* RVU VF registers */
 #define	RVU_VF_VFPF_MBOX0		    (0x00000)
 #define	RVU_VF_VFPF_MBOX1		    (0x00008)
@@ -61,6 +72,7 @@
 /* CN20K RVU_MBOX_E: RVU PF/VF MBOX Address Range Enumeration */
 #define RVU_MBOX_AF_PFX_ADDR(a)             (0x5000 | (a) << 4)
 #define RVU_PFX_FUNC_PFAF_MBOX		    (0x80000)
+#define RVU_PFX_FUNCX_VFAF_MBOX		    (0x40000)
 
 #define RVU_FUNC_BLKADDR_SHIFT		20
 #define RVU_FUNC_BLKADDR_MASK		0x1FULL
@@ -147,4 +159,7 @@
 #define LMT_LF_LMTLINEX(a)		(LMT_LFBASE | 0x000 | (a) << 12)
 #define LMT_LF_LMTCANCEL		(LMT_LFBASE | 0x400)
 
+/* CN20K registers */
+#define RVU_PF_DISC			(0x0)
+
 #endif /* OTX2_REG_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index ea3224379423..84bf0efd6677 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -239,6 +239,10 @@ static void otx2vf_disable_mbox_intr(struct otx2_nic *vf)
 
 	/* Disable VF => PF mailbox IRQ */
 	otx2_write64(vf, RVU_VF_INT_ENA_W1C, BIT_ULL(0));
+
+	if (is_cn20k(vf->pdev))
+		otx2_write64(vf, RVU_VF_INT_ENA_W1C, BIT_ULL(0) | BIT_ULL(1));
+
 	free_irq(vector, vf);
 }
 
@@ -251,9 +255,18 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_VF_INT_VEC_MBOX * NAME_SIZE];
-	snprintf(irq_name, NAME_SIZE, "RVUVFAF Mbox");
-	err = request_irq(pci_irq_vector(vf->pdev, RVU_VF_INT_VEC_MBOX),
-			  otx2vf_vfaf_mbox_intr_handler, 0, irq_name, vf);
+	snprintf(irq_name, NAME_SIZE, "RVUVF%d AFVF Mbox", ((vf->pcifunc &
+		 RVU_PFVF_FUNC_MASK) - 1));
+
+	if (!is_cn20k(vf->pdev)) {
+		err = request_irq(pci_irq_vector(vf->pdev, RVU_VF_INT_VEC_MBOX),
+				  otx2vf_vfaf_mbox_intr_handler, 0, irq_name, vf);
+	} else {
+		err = request_irq(pci_irq_vector(vf->pdev, RVU_VF_INT_VEC_MBOX),
+				  vf->hw_ops->vfaf_mbox_intr_handler, 0, irq_name,
+				  vf);
+	}
+
 	if (err) {
 		dev_err(vf->dev,
 			"RVUPF: IRQ registration failed for VFAF mbox irq\n");
@@ -263,8 +276,15 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 	/* Enable mailbox interrupt for msgs coming from PF.
 	 * First clear to avoid spurious interrupts, if any.
 	 */
-	otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
-	otx2_write64(vf, RVU_VF_INT_ENA_W1S, BIT_ULL(0));
+	if (!is_cn20k(vf->pdev)) {
+		otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
+		otx2_write64(vf, RVU_VF_INT_ENA_W1S, BIT_ULL(0));
+	} else {
+		otx2_write64(vf, RVU_VF_INT, BIT_ULL(0) | BIT_ULL(1) |
+			     BIT_ULL(2) | BIT_ULL(3));
+		otx2_write64(vf, RVU_VF_INT_ENA_W1S, BIT_ULL(0) |
+			     BIT_ULL(1) | BIT_ULL(2) | BIT_ULL(3));
+	}
 
 	if (!probe_pf)
 		return 0;
@@ -314,7 +334,13 @@ static int otx2vf_vfaf_mbox_init(struct otx2_nic *vf)
 	if (!vf->mbox_wq)
 		return -ENOMEM;
 
-	if (test_bit(CN10K_MBOX, &vf->hw.cap_flag)) {
+	/* For cn20k platform, VF mailbox region is in dram aliased from AF
+	 * VF MBOX ADDR, MBOX is a separate RVU block.
+	 */
+	if (is_cn20k(vf->pdev)) {
+		hwbase = vf->reg_base + RVU_VF_MBOX_REGION + ((u64)BLKADDR_MBOX <<
+			RVU_FUNC_BLKADDR_SHIFT);
+	} else if (test_bit(CN10K_MBOX, &vf->hw.cap_flag)) {
 		/* For cn10k platform, VF mailbox region is in its BAR2
 		 * register space
 		 */
-- 
2.25.1


