Return-Path: <netdev+bounces-154393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F59FD797
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 20:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9321884157
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7441F9A87;
	Fri, 27 Dec 2024 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LbnVbKLl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC7D1F941F;
	Fri, 27 Dec 2024 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735329307; cv=none; b=j2i/X6mrjPVobzV4BgyIT8HFHoWldpIGaxAhzAL7vpD0fe1yS+u65v5rHfkQ5ZiLhtM7QQdhurplt85rBiW2SubPmr7VThxc4hUH5ENopSOliKTuRUKOGv0u5gslmmjDMfcN7zoRD9c9oRO02YtW2uAq5d315m6lsEkDBmPTXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735329307; c=relaxed/simple;
	bh=2hHIwLrtsI6cJOCAdntkTbQ0xcAtLmEWljBJq7yEH4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nA27wZDMF+PKi7/ZZz9UTR0rGcihMhpXUvIiVHFYEArzyNa2qBSl7JGkBLd/Gbd99sx+I5tsYqneKhGtfGEfNq8BngQaUpmtQS7uToTvKDjGAVa07MIz7XXVfIU7c0pbJtxrDlu944MV45pA0jR0R89gCJ3DhlypO/YgbNCEjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LbnVbKLl; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BRIo7JQ031895;
	Fri, 27 Dec 2024 11:54:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
	KxVCxAcGPi6J7WL8FAKn/YyOVXhAFby+FScBLbRW10=; b=LbnVbKLliTt/YIVDB
	Wk8sKixh/xCeeZjMM5TN+60rZZYg1HoRu9WZBppa83D9kEthr8AlMTiK/L+bM3hO
	u0uVaEreUVrVltyQozlFuQLLmzs3p5sJs9dmGR5d1H8HjXAOo0TEiIcda7vP+S1w
	0E+g5Y/NnwTMB+xxReVaRJ42IeDi0qohJjPu3z9X3/91m2BbCoAUVw3GC6YipuLl
	73Xx41TUFI8Y0XDoKzuFC2xehbFfRAfAy+qpiV03OwVgwTli8alZQUCS1s2nytcj
	aamtVhEpIEfcV2nH0HIYHDxcrX/Q+2xdWxwCLOHLAJLyd6ZJSLhAvzSTK2SxvBos
	LdZUg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43sy1j18b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 11:54:55 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Dec 2024 11:54:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Dec 2024 11:54:54 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 6A8E83F703F;
	Fri, 27 Dec 2024 11:54:49 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v7 4/6] octeontx2-pf: CN20K mbox REQ/ACK implementation for NIC PF
Date: Sat, 28 Dec 2024 01:24:25 +0530
Message-ID: <20241227195427.185178-5-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241227195427.185178-1-saikrishnag@marvell.com>
References: <20241227195427.185178-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9bwO7mdJBIA74qiEglCG_Dez8EjdjrRR
X-Proofpoint-GUID: 9bwO7mdJBIA74qiEglCG_Dez8EjdjrRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This implementation uses separate trigger interrupts for request,
response messages against using trigger message data in CN10K.
This patch adds support for basic mbox implementation for CN20K
from NIC PF side.

Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 .../marvell/octeontx2/af/cn20k/struct.h       | 15 ++++
 .../ethernet/marvell/octeontx2/nic/Makefile   |  2 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.c    | 18 ++++-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |  1 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 63 +++++++++++++++
 .../ethernet/marvell/octeontx2/nic/cn20k.h    | 14 ++++
 .../marvell/octeontx2/nic/otx2_common.h       |  5 ++
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 80 +++++++++++++++----
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h |  4 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  6 ++
 10 files changed, 186 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
index fccad6e422e8..76ce3ec6da9c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
@@ -8,6 +8,21 @@
 #ifndef STRUCT_H
 #define STRUCT_H
 
+/*
+ * CN20k RVU PF MBOX Interrupt Vector Enumeration
+ *
+ * Vectors 0 - 3 are compatible with pre cn20k and hence
+ * existing macros are being reused.
+ */
+enum rvu_mbox_pf_int_vec_e {
+	RVU_MBOX_PF_INT_VEC_VFPF_MBOX0	= 0x4,
+	RVU_MBOX_PF_INT_VEC_VFPF_MBOX1	= 0x5,
+	RVU_MBOX_PF_INT_VEC_VFPF1_MBOX0	= 0x6,
+	RVU_MBOX_PF_INT_VEC_VFPF1_MBOX1	= 0x7,
+	RVU_MBOX_PF_INT_VEC_AFPF_MBOX	= 0x8,
+	RVU_MBOX_PF_INT_VEC_CNT		= 0x9,
+};
+
 /* RVU Admin function Interrupt Vector Enumeration */
 enum rvu_af_cn20k_int_vec_e {
 	RVU_AF_CN20K_INT_VEC_POISON		= 0x0,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index cb6513ab35e7..9791f10b7bd6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_OCTEONTX2_VF) += rvu_nicvf.o otx2_ptp.o
 obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
 
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
-               otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
+               otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
                otx2_devlink.o qos_sq.o qos.o
 rvu_nicvf-y := otx2_vf.o
 rvu_rep-y := rep.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index a15cc86635d6..bd7e2c669cac 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -14,6 +14,7 @@ static struct dev_hw_ops	otx2_hw_ops = {
 	.sqe_flush = otx2_sqe_flush,
 	.aura_freeptr = otx2_aura_freeptr,
 	.refill_pool_ptrs = otx2_refill_pool_ptrs,
+	.pfaf_mbox_intr_handler = otx2_pfaf_mbox_intr_handler,
 };
 
 static struct dev_hw_ops cn10k_hw_ops = {
@@ -21,8 +22,20 @@ static struct dev_hw_ops cn10k_hw_ops = {
 	.sqe_flush = cn10k_sqe_flush,
 	.aura_freeptr = cn10k_aura_freeptr,
 	.refill_pool_ptrs = cn10k_refill_pool_ptrs,
+	.pfaf_mbox_intr_handler = otx2_pfaf_mbox_intr_handler,
 };
 
+void otx2_init_hw_ops(struct otx2_nic *pfvf)
+{
+	if (!test_bit(CN10K_LMTST, &pfvf->hw.cap_flag)) {
+		pfvf->hw_ops = &otx2_hw_ops;
+		return;
+	}
+
+	pfvf->hw_ops = &cn10k_hw_ops;
+}
+EXPORT_SYMBOL(otx2_init_hw_ops);
+
 int cn10k_lmtst_init(struct otx2_nic *pfvf)
 {
 
@@ -30,12 +43,9 @@ int cn10k_lmtst_init(struct otx2_nic *pfvf)
 	struct otx2_lmt_info *lmt_info;
 	int err, cpu;
 
-	if (!test_bit(CN10K_LMTST, &pfvf->hw.cap_flag)) {
-		pfvf->hw_ops = &otx2_hw_ops;
+	if (!test_bit(CN10K_LMTST, &pfvf->hw.cap_flag))
 		return 0;
-	}
 
-	pfvf->hw_ops = &cn10k_hw_ops;
 	/* Total LMTLINES = num_online_cpus() * 32 (For Burst flush).*/
 	pfvf->tot_lmt_lines = (num_online_cpus() * LMT_BURST_SIZE);
 	pfvf->hw.lmt_info = alloc_percpu(struct otx2_lmt_info);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
index e3f0bce9908f..945ab10bd4ed 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
@@ -39,4 +39,5 @@ int cn10k_alloc_leaf_profile(struct otx2_nic *pfvf, u16 *leaf);
 int cn10k_set_ipolicer_rate(struct otx2_nic *pfvf, u16 profile,
 			    u32 burst, u64 rate, bool pps);
 int cn10k_free_leaf_profile(struct otx2_nic *pfvf, u16 leaf);
+void otx2_init_hw_ops(struct otx2_nic *pfvf);
 #endif /* CN10K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
new file mode 100644
index 000000000000..d7a5f5449d55
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Ethernet driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#include "otx2_common.h"
+#include "otx2_reg.h"
+#include "otx2_struct.h"
+#include "cn10k.h"
+
+static struct dev_hw_ops cn20k_hw_ops = {
+	.pfaf_mbox_intr_handler = cn20k_pfaf_mbox_intr_handler,
+};
+
+void cn20k_init(struct otx2_nic *pfvf)
+{
+	pfvf->hw_ops = &cn20k_hw_ops;
+}
+EXPORT_SYMBOL(cn20k_init);
+/* CN20K mbox AF => PFx irq handler */
+irqreturn_t cn20k_pfaf_mbox_intr_handler(int irq, void *pf_irq)
+{
+	struct otx2_nic *pf = pf_irq;
+	struct mbox *mw = &pf->mbox;
+	struct otx2_mbox_dev *mdev;
+	struct otx2_mbox *mbox;
+	struct mbox_hdr *hdr;
+	int pf_trig_val;
+
+	pf_trig_val = otx2_read64(pf, RVU_PF_INT) & 0x3;
+
+	/* Clear the IRQ */
+	otx2_write64(pf, RVU_PF_INT, pf_trig_val);
+
+	if (pf_trig_val & BIT_ULL(0)) {
+		mbox = &mw->mbox_up;
+		mdev = &mbox->dev[0];
+		otx2_sync_mbox_bbuf(mbox, 0);
+
+		hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+		if (hdr->num_msgs)
+			queue_work(pf->mbox_wq, &mw->mbox_up_wrk);
+
+		trace_otx2_msg_interrupt(pf->pdev, "UP message from AF to PF",
+					 BIT_ULL(0));
+	}
+
+	if (pf_trig_val & BIT_ULL(1)) {
+		mbox = &mw->mbox;
+		mdev = &mbox->dev[0];
+		otx2_sync_mbox_bbuf(mbox, 0);
+
+		hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+		if (hdr->num_msgs)
+			queue_work(pf->mbox_wq, &mw->mbox_wrk);
+		trace_otx2_msg_interrupt(pf->pdev, "DOWN reply from AF to PF",
+					 BIT_ULL(1));
+	}
+
+	return IRQ_HANDLED;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
new file mode 100644
index 000000000000..712bb2b5e2ae
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Ethernet driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#ifndef CN20K_H
+#define CN20K_H
+
+#include "otx2_common.h"
+
+void cn20k_init(struct otx2_nic *pfvf);
+#endif /* CN20K_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index d44a6cc3e863..fc1200f51215 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -32,6 +32,7 @@
 #include "qos.h"
 #include "rep.h"
 #include "cn10k_ipsec.h"
+#include "cn20k.h"
 
 /* IPv4 flag more fragment bit */
 #define IPV4_FLAG_MORE				0x20
@@ -61,6 +62,9 @@
 /* Number of segments per SG structure */
 #define MAX_SEGS_PER_SG 3
 
+irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq);
+irqreturn_t cn20k_pfaf_mbox_intr_handler(int irq, void *pf_irq);
+
 enum arua_mapped_qtypes {
 	AURA_NIX_RQ,
 	AURA_NIX_SQ,
@@ -359,6 +363,7 @@ struct dev_hw_ops {
 			     int size, int qidx);
 	int	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
 	void	(*aura_freeptr)(void *dev, int aura, u64 buf);
+	irqreturn_t (*pfaf_mbox_intr_handler)(int irq, void *pf_irq);
 };
 
 #define CN10K_MCS_SA_PER_SC	4
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 2ca120683834..d155ecd8993a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -992,7 +992,7 @@ static void otx2_pfaf_mbox_up_handler(struct work_struct *work)
 	otx2_mbox_msg_send(mbox, 0);
 }
 
-static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
+irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 {
 	struct otx2_nic *pf = (struct otx2_nic *)pf_irq;
 	struct mbox *mw = &pf->mbox;
@@ -1044,10 +1044,18 @@ static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 
 void otx2_disable_mbox_intr(struct otx2_nic *pf)
 {
-	int vector = pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_AFPF_MBOX);
+	int vector;
 
 	/* Disable AF => PF mailbox IRQ */
-	otx2_write64(pf, RVU_PF_INT_ENA_W1C, BIT_ULL(0));
+	if (!is_cn20k(pf->pdev)) {
+		vector = pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_AFPF_MBOX);
+		otx2_write64(pf, RVU_PF_INT_ENA_W1C, BIT_ULL(0));
+	} else {
+		vector = pci_irq_vector(pf->pdev,
+					RVU_MBOX_PF_INT_VEC_AFPF_MBOX);
+		otx2_write64(pf, RVU_PF_INT_ENA_W1C,
+			     BIT_ULL(0) | BIT_ULL(1));
+	}
 	free_irq(vector, pf);
 }
 EXPORT_SYMBOL(otx2_disable_mbox_intr);
@@ -1060,10 +1068,24 @@ int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 	int err;
 
 	/* Register mailbox interrupt handler */
-	irq_name = &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
-	snprintf(irq_name, NAME_SIZE, "RVUPFAF Mbox");
-	err = request_irq(pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_AFPF_MBOX),
-			  otx2_pfaf_mbox_intr_handler, 0, irq_name, pf);
+	if (!is_cn20k(pf->pdev)) {
+		irq_name = &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
+		snprintf(irq_name, NAME_SIZE, "RVUPF%d AFPF Mbox",
+			 rvu_get_pf(pf->pcifunc));
+		err = request_irq(pci_irq_vector
+				  (pf->pdev, RVU_PF_INT_VEC_AFPF_MBOX),
+				  pf->hw_ops->pfaf_mbox_intr_handler,
+				  0, irq_name, pf);
+	} else {
+		irq_name = &hw->irq_name[RVU_MBOX_PF_INT_VEC_AFPF_MBOX *
+						NAME_SIZE];
+		snprintf(irq_name, NAME_SIZE, "RVUPF%d AFPF Mbox",
+			 rvu_get_pf(pf->pcifunc));
+		err = request_irq(pci_irq_vector
+				  (pf->pdev, RVU_MBOX_PF_INT_VEC_AFPF_MBOX),
+				  pf->hw_ops->pfaf_mbox_intr_handler,
+				  0, irq_name, pf);
+	}
 	if (err) {
 		dev_err(pf->dev,
 			"RVUPF: IRQ registration failed for PFAF mbox irq\n");
@@ -1073,8 +1095,14 @@ int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 	/* Enable mailbox interrupt for msgs coming from AF.
 	 * First clear to avoid spurious interrupts, if any.
 	 */
-	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
-	otx2_write64(pf, RVU_PF_INT_ENA_W1S, BIT_ULL(0));
+	if (!is_cn20k(pf->pdev)) {
+		otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
+		otx2_write64(pf, RVU_PF_INT_ENA_W1S, BIT_ULL(0));
+	} else {
+		otx2_write64(pf, RVU_PF_INT, BIT_ULL(0) | BIT_ULL(1));
+		otx2_write64(pf, RVU_PF_INT_ENA_W1S, BIT_ULL(0) |
+			     BIT_ULL(1));
+	}
 
 	if (!probe_af)
 		return 0;
@@ -1105,7 +1133,7 @@ void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
 		pf->mbox_wq = NULL;
 	}
 
-	if (mbox->mbox.hwbase)
+	if (mbox->mbox.hwbase && !is_cn20k(pf->pdev))
 		iounmap((void __iomem *)mbox->mbox.hwbase);
 
 	otx2_mbox_destroy(&mbox->mbox);
@@ -1125,12 +1153,20 @@ int otx2_pfaf_mbox_init(struct otx2_nic *pf)
 	if (!pf->mbox_wq)
 		return -ENOMEM;
 
-	/* Mailbox is a reserved memory (in RAM) region shared between
-	 * admin function (i.e AF) and this PF, shouldn't be mapped as
-	 * device memory to allow unaligned accesses.
+	/* For CN20K, AF allocates mbox memory in DRAM and writes PF
+	 * regions/offsets in RVU_MBOX_AF_PFX_ADDR, the RVU_PFX_FUNC_PFAF_MBOX
+	 * gives the aliased address to access AF/PF mailbox regions.
 	 */
-	hwbase = ioremap_wc(pci_resource_start(pf->pdev, PCI_MBOX_BAR_NUM),
-			    MBOX_SIZE);
+	if (is_cn20k(pf->pdev))
+		hwbase = pf->reg_base + RVU_PFX_FUNC_PFAF_MBOX +
+			((u64)BLKADDR_MBOX << RVU_FUNC_BLKADDR_SHIFT);
+	else
+		/* Mailbox is a reserved memory (in RAM) region shared between
+		 * admin function (i.e AF) and this PF, shouldn't be mapped as
+		 * device memory to allow unaligned accesses.
+		 */
+		hwbase = ioremap_wc(pci_resource_start
+				    (pf->pdev, PCI_MBOX_BAR_NUM), MBOX_SIZE);
 	if (!hwbase) {
 		dev_err(pf->dev, "Unable to map PFAF mailbox region\n");
 		err = -ENOMEM;
@@ -2985,8 +3021,13 @@ int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf)
 	if (err)
 		return err;
 
-	err = pci_alloc_irq_vectors(hw->pdev, RVU_PF_INT_VEC_CNT,
-				    RVU_PF_INT_VEC_CNT, PCI_IRQ_MSIX);
+	if (!is_cn20k(pf->pdev))
+		err = pci_alloc_irq_vectors(hw->pdev, RVU_PF_INT_VEC_CNT,
+					    RVU_PF_INT_VEC_CNT, PCI_IRQ_MSIX);
+	else
+		err = pci_alloc_irq_vectors(hw->pdev, RVU_MBOX_PF_INT_VEC_CNT,
+					    RVU_MBOX_PF_INT_VEC_CNT,
+					    PCI_IRQ_MSIX);
 	if (err < 0) {
 		dev_err(dev, "%s: Failed to alloc %d IRQ vectors\n",
 			__func__, num_vec);
@@ -2995,6 +3036,11 @@ int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf)
 
 	otx2_setup_dev_hw_settings(pf);
 
+	if (is_cn20k(pf->pdev))
+		cn20k_init(pf);
+	else
+		otx2_init_hw_ops(pf);
+
 	/* Init PF <=> AF mailbox stuff */
 	err = otx2_pfaf_mbox_init(pf);
 	if (err)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
index 858f084b9d47..901f8cf7f27a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
@@ -58,6 +58,10 @@
 #define	RVU_VF_MSIX_PBAX(a)		    (0xF0000 | (a) << 3)
 #define RVU_VF_MBOX_REGION                  (0xC0000)
 
+/* CN20K RVU_MBOX_E: RVU PF/VF MBOX Address Range Enumeration */
+#define RVU_MBOX_AF_PFX_ADDR(a)             (0x5000 | (a) << 4)
+#define RVU_PFX_FUNC_PFAF_MBOX		    (0x80000)
+
 #define RVU_FUNC_BLKADDR_SHIFT		20
 #define RVU_FUNC_BLKADDR_MASK		0x1FULL
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index e926c6ce96cf..9c69d06a36cd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -618,6 +618,12 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	otx2_setup_dev_hw_settings(vf);
+
+	if (is_cn20k(vf->pdev))
+		cn20k_init(vf);
+	else
+		otx2_init_hw_ops(vf);
+
 	/* Init VF <=> PF mailbox stuff */
 	err = otx2vf_vfaf_mbox_init(vf);
 	if (err)
-- 
2.25.1


