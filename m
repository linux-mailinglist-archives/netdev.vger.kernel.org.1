Return-Path: <netdev+bounces-137995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9F79AB655
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 20:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5F91C20CC4
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABA81CDFD1;
	Tue, 22 Oct 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KKOy7yDC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E651CDA25;
	Tue, 22 Oct 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623302; cv=none; b=Re2e1i5wu15JppGGKhiaKurz/kf6OYw2f+sftP/zu5671TwpF4sF9yZ35Ezjp9Iaea4pdM04Reh2QGzpvAqPg70HKzctsACeBKG/XeyuHHWzwddjlKMB8dSikQM71W+RpEHPZS6w81m6Ixe9g6wF/cCoYDHcdHlopaA2rkkN2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623302; c=relaxed/simple;
	bh=Sso6AS+yelqSl4LmNgrcBfSnOdzbWeLCP+A4wEx8STw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2zS6TAIYhvIeYPwVBqMxMtaeeRWzDYgWx+gSYTFon7QP7gNJH2kSmh8iYqKBaZ+/97mXEDlV23tIhYFDy/FsxCUeDniB3mPSD0k+9AoCPG6rqcpg69o8RV9rsLrtXGulfE9s96gK18Pv1E/g8utkRVeaCtBrl0MKHx84WxRtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KKOy7yDC; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MFU98t004127;
	Tue, 22 Oct 2024 11:54:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
	zdAkdplWcXxSRYswNZAXcgRm/cicuqcQR0EDOVYyYg=; b=KKOy7yDCekQaRO+Li
	Vp+TgOYfyS7iPPtGYlX7Z6JsN9ZDZyFg2LEMh6s7Zo3MkmplnYrEedEsKSRPzBOU
	0t7LRMKcyMMlgwd4EXFhZW8iD+512Su+NCAnUeP3MQGiK7ychr2fAHtPjjRrusub
	xTnRyA5SXKVDb1dlYZCqWppix1kDECE0Atiqi5I8WM7OZol3qwV0uGevdLLiu47W
	aMUoDix00i/9+wB9rdJbVUitYVfcio2IFswWQ8I4GXhDjQ6IP56Q+Ar330R69ohu
	1sIQyuKOnHmce9mFo1CJZMdy+OkcYqUkc+xJAt8ErGXStf0LtfjXHFvSQmhQx9Ge
	/3fvA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42eera0hy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 11:54:46 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Oct 2024 11:54:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Oct 2024 11:54:45 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id B1EB83F7067;
	Tue, 22 Oct 2024 11:54:41 -0700 (PDT)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v2 6/6] octeontx2-pf: CN20K mbox implementation between PF-VF
Date: Wed, 23 Oct 2024 00:24:10 +0530
Message-ID: <20241022185410.4036100-7-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022185410.4036100-1-saikrishnag@marvell.com>
References: <20241022185410.4036100-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: NdQ_hft3-LWBlS1_D7BubePoMjwNwcVV
X-Proofpoint-GUID: NdQ_hft3-LWBlS1_D7BubePoMjwNwcVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

This patch implements the CN20k MBOX communication between PF and
it's VFs. CN20K silicon got extra interrupt of MBOX response for trigger
interrupt. Also few of the CSR offsets got changed in CN20K against
prior series of silicons.

Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 142 ++++++++++++++++++
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   3 +
 .../marvell/octeontx2/nic/otx2_common.h       |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  59 ++++++--
 4 files changed, 193 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index 84ecbfb92449..6e47698ec5c7 100644
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
+	struct pf_irq_data *irq_data = (struct pf_irq_data *)(pf_irq);
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
index edebdd9ce1e1..e56df7aa1d57 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -57,6 +57,7 @@
 irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq);
 irqreturn_t cn20k_pfaf_mbox_intr_handler(int irq, void *pf_irq);
 irqreturn_t cn20k_vfaf_mbox_intr_handler(int irq, void *vf_irq);
+irqreturn_t cn20k_pfvf_mbox_intr_handler(int irq, void *pf_irq);
 irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq);
 
 enum arua_mapped_qtypes {
@@ -382,6 +383,7 @@ struct dev_hw_ops {
 	void	(*aura_freeptr)(void *dev, int aura, u64 buf);
 	irqreturn_t (*pfaf_mbox_intr_handler)(int irq, void *pf_irq);
 	irqreturn_t (*vfaf_mbox_intr_handler)(int irq, void *pf_irq);
+	irqreturn_t (*pfvf_mbox_intr_handler)(int irq, void *pf_irq);
 };
 
 #define CN10K_MCS_SA_PER_SC	4
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 148a5c91af55..1a7920327fd5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -565,6 +565,23 @@ irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
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
@@ -586,20 +603,28 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
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
-		base = readq((void __iomem *)((u64)pf->reg_base +
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
+			base = readq((void __iomem *)((u64)pf->reg_base +
 					      RVU_PF_VF_BAR4_ADDR));
 
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
 		iounmap(mbox->mbox.hwbase);
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


