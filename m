Return-Path: <netdev+bounces-196535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A18AD5359
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34B818952E9
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116B7271441;
	Wed, 11 Jun 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="W0WNnZJl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE496273D6B
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639755; cv=none; b=DmMZKyvSzaUxiRoR8o0Ze2qZJKTVQ+Q77Q3gy8lZGBom1lUxuIEFehodOWuLeck0J7JxBJlG17YB3uucJ8oNK6Zf3IeVnbE807ke5jDbD9ln9ciA8z3i1e3z730fdwOAf5bnVQ+I6fKH0OLmeWz0Triy8rbZZ8xQ6ZEB6lB1V9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639755; c=relaxed/simple;
	bh=qKr0YRirCd3Kt2SxeApDGtXarwYYGWTnrPuu1pVEvss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSXq7ZkuT8WIFqenZJAKU7XKH/F7J7Xpv1mPf57iQgEb+JALBe59n2mydIeXblw8aHadbt2TxlsFvmOZxEmqPSYI7ib9SzfrOaOzId077pMylC/bTW3CKn+g28vJmjO35YTF83ZAIuNI2VdXT2rN7sQvZC5imtLx2VR08w+5s8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=W0WNnZJl; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B5qoY6013609;
	Wed, 11 Jun 2025 04:02:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=SBRcL5RsmG6OEollC5oOliMYT
	rcvvaPZwn4dQys7gYk=; b=W0WNnZJlEV3FlEhYUjq6OMCltB+xhvE4l7j3IZPFb
	Q/k+WNC/54l0V0Tzr3iFbAK9LhiREXCOWAPen9yaObpOqGsle4TfZiWwyFwEppKF
	IwrSbp6kMfvSUk3h3EFf8iKsvD+QXuygDnFG8snq188geCisgFDLf3B9TtJMpcWg
	jU2V/oowBk4bGBxpclJHc/JGhE6t1jLm2HIi6lG9tnsm4tRrnKe97X32VYI29RhM
	vosAs30JzTyBkz5j9t6TU/mQzNHGB/jw+sTOxsPXO1JXoDNUd7Pp+8/MnSBw00r6
	E7w4VAaoe4YRpLnp2F5Ttn7jZ9HAEGlJfgCXjUsmQP5Cw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47741jgjyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 04:02:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Jun 2025 04:02:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Jun 2025 04:02:24 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 058393F7069;
	Wed, 11 Jun 2025 04:02:19 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <saikrishnag@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v11 4/6] octeontx2-pf: CN20K mbox REQ/ACK implementation for NIC PF
Date: Wed, 11 Jun 2025 16:31:54 +0530
Message-ID: <1749639716-13868-5-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA5NCBTYWx0ZWRfX0rSc2lPR2hSd meVwAXzEQDxYJBDqCBccvt2MnSsFjc2BRntiuQf9r99QIW0YIprcsnG11chFU8xSYhRD/EXW9C2 M0sVf0G1860FuOKekUsPqrR2KWtqV7wnYw3ZqbxTD4AGw6bk5gaFcdTd9N3vlX4xInP353j4MW+
 pFq81/ZEglFaAV9y8PUD7KqSzqFUjYgg/mnqwXnAJbQOH3vEcYj3Ss6/EUUBv5LPqs7rrdhPh0m ziTeb/0q1mjPJgh0psHM3wPsa+zowpdRqDJzbOwrEZ9Wb4c39r0KTYH0eGTYhr3BX4ZVnK6r+X4 9VcGBPhEychYTuIQMR/vfaq/pW2TSj7z1zhRX0cBfGdTDLorz1LtgPq7azj1UksIphBNxExRG27
 9m0BS8uN0dRrxsWVNowGzRLh5av5mb/sPxZcSv39Y0s+UH/HjUoKzlkfLRrhDDzr7jb+l9mX
X-Proofpoint-GUID: NPxuTwuO-aolum2z6F_DU4wFUH2Ag_Mp
X-Proofpoint-ORIG-GUID: NPxuTwuO-aolum2z6F_DU4wFUH2Ag_Mp
X-Authority-Analysis: v=2.4 cv=eM4TjGp1 c=1 sm=1 tr=0 ts=68496241 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=P7SSE_Zdh55KHv_NWccA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01

From: Sai Krishna <saikrishnag@marvell.com>

This implementation uses separate trigger interrupts for request,
response messages against using trigger message data in CN10K.
This patch adds support for basic mbox implementation for CN20K
from NIC PF side.

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/struct.h   | 15 ++++
 .../net/ethernet/marvell/octeontx2/nic/Makefile    |  2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c | 18 +++--
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h |  1 +
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c | 63 +++++++++++++++++
 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h | 14 ++++
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |  5 ++
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 80 +++++++++++++++++-----
 .../net/ethernet/marvell/octeontx2/nic/otx2_reg.h  |  4 ++
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  6 ++
 10 files changed, 186 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn20k.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
index fccad6e..76ce3ec 100644
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
index 69e0778..883e9f4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_OCTEONTX2_VF) += rvu_nicvf.o otx2_ptp.o
 obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
 
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
-               otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
+               otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
                otx2_devlink.o qos_sq.o qos.o otx2_xsk.o
 rvu_nicvf-y := otx2_vf.o
 rvu_rep-y := rep.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index 7f6a435..bec7d5b 100644
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
index e3f0bce..945ab10 100644
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
index 0000000..fdc4ce3
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
+	u64 pf_trig_val;
+
+	pf_trig_val = otx2_read64(pf, RVU_PF_INT) & 0x3ULL;
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
index 0000000..712bb2b
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
index 8ada34a..fd8ad96 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -33,6 +33,7 @@
 #include "qos.h"
 #include "rep.h"
 #include "cn10k_ipsec.h"
+#include "cn20k.h"
 
 /* IPv4 flag more fragment bit */
 #define IPV4_FLAG_MORE				0x20
@@ -62,6 +63,9 @@
 /* Number of segments per SG structure */
 #define MAX_SEGS_PER_SG 3
 
+irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq);
+irqreturn_t cn20k_pfaf_mbox_intr_handler(int irq, void *pf_irq);
+
 enum arua_mapped_qtypes {
 	AURA_NIX_RQ,
 	AURA_NIX_SQ,
@@ -367,6 +371,7 @@ struct dev_hw_ops {
 			     int size, int qidx);
 	int	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
 	void	(*aura_freeptr)(void *dev, int aura, u64 buf);
+	irqreturn_t (*pfaf_mbox_intr_handler)(int irq, void *pf_irq);
 };
 
 #define CN10K_MCS_SA_PER_SC	4
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 1dc3e05..95a65a7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1008,7 +1008,7 @@ static void otx2_pfaf_mbox_up_handler(struct work_struct *work)
 	otx2_mbox_msg_send(mbox, 0);
 }
 
-static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
+irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 {
 	struct otx2_nic *pf = (struct otx2_nic *)pf_irq;
 	struct mbox *mw = &pf->mbox;
@@ -1066,10 +1066,18 @@ static irqreturn_t otx2_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 
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
@@ -1082,10 +1090,24 @@ int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 	int err;
 
 	/* Register mailbox interrupt handler */
-	irq_name = &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
-	snprintf(irq_name, NAME_SIZE, "RVUPFAF Mbox");
-	err = request_irq(pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_AFPF_MBOX),
-			  otx2_pfaf_mbox_intr_handler, 0, irq_name, pf);
+	if (!is_cn20k(pf->pdev)) {
+		irq_name = &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
+		snprintf(irq_name, NAME_SIZE, "RVUPF%d AFPF Mbox",
+			 rvu_get_pf(pf->pdev, pf->pcifunc));
+		err = request_irq(pci_irq_vector
+				  (pf->pdev, RVU_PF_INT_VEC_AFPF_MBOX),
+				  pf->hw_ops->pfaf_mbox_intr_handler,
+				  0, irq_name, pf);
+	} else {
+		irq_name = &hw->irq_name[RVU_MBOX_PF_INT_VEC_AFPF_MBOX *
+						NAME_SIZE];
+		snprintf(irq_name, NAME_SIZE, "RVUPF%d AFPF Mbox",
+			 rvu_get_pf(pf->pdev, pf->pcifunc));
+		err = request_irq(pci_irq_vector
+				  (pf->pdev, RVU_MBOX_PF_INT_VEC_AFPF_MBOX),
+				  pf->hw_ops->pfaf_mbox_intr_handler,
+				  0, irq_name, pf);
+	}
 	if (err) {
 		dev_err(pf->dev,
 			"RVUPF: IRQ registration failed for PFAF mbox irq\n");
@@ -1095,8 +1117,14 @@ int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
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
@@ -1127,7 +1155,7 @@ void otx2_pfaf_mbox_destroy(struct otx2_nic *pf)
 		pf->mbox_wq = NULL;
 	}
 
-	if (mbox->mbox.hwbase)
+	if (mbox->mbox.hwbase && !is_cn20k(pf->pdev))
 		iounmap((void __iomem *)mbox->mbox.hwbase);
 
 	otx2_mbox_destroy(&mbox->mbox);
@@ -1147,12 +1175,20 @@ int otx2_pfaf_mbox_init(struct otx2_nic *pf)
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
@@ -3000,8 +3036,13 @@ int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf)
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
@@ -3010,6 +3051,11 @@ int otx2_init_rsrc(struct pci_dev *pdev, struct otx2_nic *pf)
 
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
index 858f084..901f8cf 100644
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
index 8a8b598..d2f6143 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -616,6 +616,12 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
2.7.4


