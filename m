Return-Path: <netdev+bounces-149007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF95D9E3C48
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC77D283466
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB920C498;
	Wed,  4 Dec 2024 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="kJ9Y9SDY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4809720C47C;
	Wed,  4 Dec 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321351; cv=none; b=axX3PZ3LTOX3TzUov76uAtHEcva6EcIZ6bTsPqTAGniYG0kLXSkpg9dxvJqD7qfBW2AneJtFbxgr2KLU2C67zPAS40oaF/1DJ5zdFBgGEORp5sbw7B4GTv2kYHVi4m838buoVDPtDzTYlxV1li19FkdcWJJzeF6rC+A3cYR+938=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321351; c=relaxed/simple;
	bh=xGZR8nNaeX1q1w1O74p4J1fbAer4MGFu5GeLzQcWN5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2S3z/Ix+LPDFR464vUOEMR4qENcHmkPsHvcMtBUNye7VySGin4KgIwAXvsxonz8pY0g6Duw/p7VPMR4pp12uu7rMod1ET8D3ysamNN1Y0EpTH/KV/BYyihickYhBa51jDmp3BQ7NjkqMwsbHKXCuInKErMvSFY9HshxjZ/0g98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=kJ9Y9SDY; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4AAORT012480;
	Wed, 4 Dec 2024 06:08:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
	2ApkeerCgSHedIl/2x27e4nULFNc90wDNCDmtwWvJU=; b=kJ9Y9SDYY15Zwy9k2
	OSViD4wYL9sQukKKuAdTOvJn9cbz3WlXU3MbBNsmr8NtYN+5s1vDWoyZU8J9geko
	I4Y//YmGWCr3JHezMmAkCwl4OkYK//lqyoTTbwUMaq5e/lRjrMFI+urhOHU623j8
	9zx6e3HzCU773tILMXar89U//Lx0Okag8lFTFNm7jo6Q19i5s6GQeq8xXu1OeymT
	DJzuSZ7pt0Z93npqCHhRteQSlKiUQ9TfG1pJC/tCl2W8lQQtnAfmWQZuqQbJUprl
	05wwBQT0rSU9KzezKCoTROnz5439Wf7HJswHeoNlm/7Kx73na5D2mIX1rBNq4bHo
	0e7Kg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43an3egcmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 06:08:59 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Dec 2024 06:08:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Dec 2024 06:08:57 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 568405B693D;
	Wed,  4 Dec 2024 06:08:53 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v5 6/6] octeontx2-pf: CN20K mbox implementation between PF-VF
Date: Wed, 4 Dec 2024 19:38:21 +0530
Message-ID: <20241204140821.1858263-7-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241204140821.1858263-1-saikrishnag@marvell.com>
References: <20241204140821.1858263-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BHzRZ3gz8paqAheHlf_YQzRALsRpE5BU
X-Proofpoint-ORIG-GUID: BHzRZ3gz8paqAheHlf_YQzRALsRpE5BU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This patch implements the CN20k MBOX communication between PF and
it's VFs. CN20K silicon got extra interrupt of MBOX response for trigger
interrupt. Also few of the CSR offsets got changed in CN20K against
prior series of silicons.

Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/common.h    |   2 +-
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 142 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   3 +
 .../marvell/octeontx2/nic/otx2_common.h       |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  59 ++++++--
 5 files changed, 194 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 5d84386ed22d..e78d55f77e42 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -39,7 +39,7 @@ struct qmem {
 	void            *base;
 	dma_addr_t	iova;
 	int		alloc_sz;
-	u16		entry_sz;
+	u32		entry_sz;
 	u8		align;
 	u32		qsize;
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index ef37aa0564b5..05f9129284c5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -13,6 +13,7 @@
 static struct dev_hw_ops cn20k_hw_ops = {
 	.pfaf_mbox_intr_handler = cn20k_pfaf_mbox_intr_handler,
 	.vfaf_mbox_intr_handler = cn20k_vfaf_mbox_intr_handler,
+	.pfvf_mbox_intr_handler = cn20k_pfvf_mbox_intr_handler,
 };
 
 void cn20k_init(struct otx2_nic *pfvf)
@@ -108,3 +109,144 @@ irqreturn_t cn20k_vfaf_mbox_intr_handler(int irq, void *vf_irq)
 
 	return IRQ_HANDLED;
 }
+
+void cn20k_enable_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
+{
+	/* Clear PF <=> VF mailbox IRQ */
+	otx2_write64(pf, RVU_MBOX_PF_VFPF_INTX(0), ~0ull);
+	otx2_write64(pf, RVU_MBOX_PF_VFPF_INTX(1), ~0ull);
+	otx2_write64(pf, RVU_MBOX_PF_VFPF1_INTX(0), ~0ull);
+	otx2_write64(pf, RVU_MBOX_PF_VFPF1_INTX(1), ~0ull);
+
+	/* Enable PF <=> VF mailbox IRQ */
+	otx2_write64(pf, RVU_MBOX_PF_VFPF_INT_ENA_W1SX(0), INTR_MASK(numvfs));
+	otx2_write64(pf, RVU_MBOX_PF_VFPF1_INT_ENA_W1SX(0), INTR_MASK(numvfs));
+	if (numvfs > 64) {
+		numvfs -= 64;
+		otx2_write64(pf, RVU_MBOX_PF_VFPF_INT_ENA_W1SX(1),
+			     INTR_MASK(numvfs));
+		otx2_write64(pf, RVU_MBOX_PF_VFPF1_INT_ENA_W1SX(1),
+			     INTR_MASK(numvfs));
+	}
+}
+
+void cn20k_disable_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
+{
+	int vector, intr_vec, vec = 0;
+
+	/* Disable PF <=> VF mailbox IRQ */
+	otx2_write64(pf, RVU_MBOX_PF_VFPF_INT_ENA_W1CX(0), ~0ull);
+	otx2_write64(pf, RVU_MBOX_PF_VFPF_INT_ENA_W1CX(1), ~0ull);
+	otx2_write64(pf, RVU_MBOX_PF_VFPF1_INT_ENA_W1CX(0), ~0ull);
+	otx2_write64(pf, RVU_MBOX_PF_VFPF1_INT_ENA_W1CX(1), ~0ull);
+
+	otx2_write64(pf, RVU_MBOX_PF_VFPF_INTX(0), ~0ull);
+	otx2_write64(pf, RVU_MBOX_PF_VFPF1_INTX(0), ~0ull);
+
+	if (numvfs > 64) {
+		otx2_write64(pf, RVU_MBOX_PF_VFPF_INTX(1), ~0ull);
+		otx2_write64(pf, RVU_MBOX_PF_VFPF1_INTX(1), ~0ull);
+	}
+
+	for (intr_vec = RVU_MBOX_PF_INT_VEC_VFPF_MBOX0; intr_vec <=
+			RVU_MBOX_PF_INT_VEC_VFPF1_MBOX1; intr_vec++, vec++) {
+		vector = pci_irq_vector(pf->pdev, intr_vec);
+		free_irq(vector, pf->hw.pfvf_irq_devid[vec]);
+	}
+}
+
+irqreturn_t cn20k_pfvf_mbox_intr_handler(int irq, void *pf_irq)
+{
+	struct pf_irq_data *irq_data = pf_irq;
+	struct otx2_nic *pf = irq_data->pf;
+	struct mbox *mbox;
+	u64 intr;
+
+	/* Sync with mbox memory region */
+	rmb();
+
+	/* Clear interrupts */
+	intr = otx2_read64(pf, irq_data->intr_status);
+	otx2_write64(pf, irq_data->intr_status, intr);
+	mbox = pf->mbox_pfvf;
+
+	if (intr)
+		trace_otx2_msg_interrupt(pf->pdev, "VF(s) to PF", intr);
+
+	irq_data->pf_queue_work_hdlr(mbox, pf->mbox_pfvf_wq, irq_data->start,
+				     irq_data->mdevs, intr);
+
+	return IRQ_HANDLED;
+}
+
+int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
+{
+	struct otx2_hw *hw = &pf->hw;
+	struct pf_irq_data *irq_data;
+	int intr_vec, ret, vec = 0;
+	char *irq_name;
+
+	/* irq data for 4 PF intr vectors */
+	irq_data = devm_kcalloc(pf->dev, 4,
+				sizeof(struct pf_irq_data), GFP_KERNEL);
+	if (!irq_data)
+		return -ENOMEM;
+
+	for (intr_vec = RVU_MBOX_PF_INT_VEC_VFPF_MBOX0; intr_vec <=
+			RVU_MBOX_PF_INT_VEC_VFPF1_MBOX1; intr_vec++, vec++) {
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
+			irq_data[vec].mdevs = 96;
+			break;
+		case RVU_MBOX_PF_INT_VEC_VFPF1_MBOX0:
+			irq_data[vec].intr_status =
+						RVU_MBOX_PF_VFPF1_INTX(0);
+			irq_data[vec].start = 0;
+			irq_data[vec].mdevs = 64;
+			break;
+		case RVU_MBOX_PF_INT_VEC_VFPF1_MBOX1:
+			irq_data[vec].intr_status =
+						RVU_MBOX_PF_VFPF1_INTX(1);
+			irq_data[vec].start = 64;
+			irq_data[vec].mdevs = 96;
+			break;
+		}
+		irq_data[vec].pf_queue_work_hdlr = otx2_queue_vf_work;
+		irq_data[vec].vec_num = intr_vec;
+		irq_data[vec].pf = pf;
+
+		/* Register mailbox interrupt handler */
+		irq_name = &hw->irq_name[intr_vec * NAME_SIZE];
+		if (pf->pcifunc)
+			snprintf(irq_name, NAME_SIZE,
+				 "RVUPF%d_VF%d Mbox%d", rvu_get_pf(pf->pcifunc),
+				 vec / 2, vec % 2);
+		else
+			snprintf(irq_name, NAME_SIZE, "RVUPF_VF%d Mbox%d",
+				 vec / 2, vec % 2);
+
+		hw->pfvf_irq_devid[vec] = &irq_data[vec];
+		ret = request_irq(pci_irq_vector(pf->pdev, intr_vec),
+				  pf->hw_ops->pfvf_mbox_intr_handler, 0,
+				  irq_name,
+				  &irq_data[vec]);
+		if (ret) {
+			dev_err(pf->dev,
+				"RVUPF: IRQ registration failed for PFVF mbox0 irq\n");
+			return ret;
+		}
+	}
+
+	cn20k_enable_pfvf_mbox_intr(pf, numvfs);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
index 712bb2b5e2ae..832adaf8c57f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
@@ -11,4 +11,7 @@
 #include "otx2_common.h"
 
 void cn20k_init(struct otx2_nic *pfvf);
+int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs);
+void cn20k_disable_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs);
+void cn20k_enable_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs);
 #endif /* CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 93cab5f845f3..fe2d40e4c7a0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -60,6 +60,7 @@
 irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq);
 irqreturn_t cn20k_pfaf_mbox_intr_handler(int irq, void *pf_irq);
 irqreturn_t cn20k_vfaf_mbox_intr_handler(int irq, void *vf_irq);
+irqreturn_t cn20k_pfvf_mbox_intr_handler(int irq, void *pf_irq);
 irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq);
 
 enum arua_mapped_qtypes {
@@ -363,6 +364,7 @@ struct dev_hw_ops {
 	void	(*aura_freeptr)(void *dev, int aura, u64 buf);
 	irqreturn_t (*pfaf_mbox_intr_handler)(int irq, void *pf_irq);
 	irqreturn_t (*vfaf_mbox_intr_handler)(int irq, void *pf_irq);
+	irqreturn_t (*pfvf_mbox_intr_handler)(int irq, void *pf_irq);
 };
 
 #define CN10K_MCS_SA_PER_SC	4
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 7d281be02389..b470a3ef4181 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -566,6 +566,23 @@ irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 	return IRQ_HANDLED;
 }
 
+static void *cn20k_pfvf_mbox_alloc(struct otx2_nic *pf, int numvfs)
+{
+	struct qmem *mbox_addr;
+	int err;
+
+	err = qmem_alloc(&pf->pdev->dev, &mbox_addr, numvfs, MBOX_SIZE);
+	if (err) {
+		dev_err(pf->dev, "qmem alloc fail\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	otx2_write64(pf, RVU_PF_VF_MBOX_ADDR, (u64)mbox_addr->iova);
+	pf->pfvf_mbox_addr = mbox_addr;
+
+	return mbox_addr->base;
+}
+
 static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 {
 	void __iomem *hwbase;
@@ -587,19 +604,27 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 	if (!pf->mbox_pfvf_wq)
 		return -ENOMEM;
 
-	/* On CN10K platform, PF <-> VF mailbox region follows after
-	 * PF <-> AF mailbox region.
+	/* For CN20K, PF allocates mbox memory in DRAM and writes PF/VF
+	 * regions/offsets in RVU_PF_VF_MBOX_ADDR, the RVU_PFX_FUNC_PFAF_MBOX
+	 * gives the aliased address to access PF/VF mailbox regions.
 	 */
-	if (test_bit(CN10K_MBOX, &pf->hw.cap_flag))
-		base = pci_resource_start(pf->pdev, PCI_MBOX_BAR_NUM) +
-		       MBOX_SIZE;
-	else
-		base = readq((pf->reg_base + RVU_PF_VF_BAR4_ADDR));
+	if (is_cn20k(pf->pdev)) {
+		hwbase = (void __iomem *)cn20k_pfvf_mbox_alloc(pf, numvfs);
+	} else {
+		/* On CN10K platform, PF <-> VF mailbox region follows after
+		 * PF <-> AF mailbox region.
+		 */
+		if (test_bit(CN10K_MBOX, &pf->hw.cap_flag))
+			base = pci_resource_start(pf->pdev, PCI_MBOX_BAR_NUM) +
+						  MBOX_SIZE;
+		else
+			base = readq((pf->reg_base + RVU_PF_VF_BAR4_ADDR));
 
-	hwbase = ioremap_wc(base, MBOX_SIZE * pf->total_vfs);
-	if (!hwbase) {
-		err = -ENOMEM;
-		goto free_wq;
+		hwbase = ioremap_wc(base, MBOX_SIZE * pf->total_vfs);
+		if (!hwbase) {
+			err = -ENOMEM;
+			goto free_wq;
+		}
 	}
 
 	mbox = &pf->mbox_pfvf[0];
@@ -623,7 +648,7 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 	return 0;
 
 free_iomem:
-	if (hwbase)
+	if (hwbase && !(is_cn20k(pf->pdev)))
 		iounmap(hwbase);
 free_wq:
 	destroy_workqueue(pf->mbox_pfvf_wq);
@@ -642,8 +667,10 @@ static void otx2_pfvf_mbox_destroy(struct otx2_nic *pf)
 		pf->mbox_pfvf_wq = NULL;
 	}
 
-	if (mbox->mbox.hwbase)
+	if (mbox->mbox.hwbase && !is_cn20k(pf->pdev))
 		iounmap((void __iomem *)mbox->mbox.hwbase);
+	else
+		qmem_free(&pf->pdev->dev, pf->pfvf_mbox_addr);
 
 	otx2_mbox_destroy(&mbox->mbox);
 }
@@ -667,6 +694,9 @@ static void otx2_disable_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
 {
 	int vector;
 
+	if (is_cn20k(pf->pdev))
+		return cn20k_disable_pfvf_mbox_intr(pf, numvfs);
+
 	/* Disable PF <=> VF mailbox IRQ */
 	otx2_write64(pf, RVU_PF_VFPF_MBOX_INT_ENA_W1CX(0), ~0ull);
 	otx2_write64(pf, RVU_PF_VFPF_MBOX_INT_ENA_W1CX(1), ~0ull);
@@ -688,6 +718,9 @@ static int otx2_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
 	char *irq_name;
 	int err;
 
+	if (is_cn20k(pf->pdev))
+		return cn20k_register_pfvf_mbox_intr(pf, numvfs);
+
 	/* Register MBOX0 interrupt handler */
 	irq_name = &hw->irq_name[RVU_PF_INT_VEC_VFPF_MBOX0 * NAME_SIZE];
 	if (pf->pcifunc)
-- 
2.25.1


