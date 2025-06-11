Return-Path: <netdev+bounces-196536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2CAD5324
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9F717949C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041AA273D7A;
	Wed, 11 Jun 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YNEz0MdR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CC273D7B
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639764; cv=none; b=We0egMkS/bWA8qaNe59ef2OywEf22i7UI17YV7YQdFCMRmKgi0U/pYNQPWwKjh1dTmFevatztDMGhcVdg7VTw1WanqTi/rO3Gs2mhKTreMAGuFWaqJaoGvyVNzr+D5WHcw6jQ6Ltw4JzOVw571wdYXFvAriO5ECSFT2h/C9QXEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639764; c=relaxed/simple;
	bh=JTYXtURZzP1b314NxDkbtws/PqqGqrkL63M6zBJjJSo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCostkUUMwtTu76RnVnt1KeRZB+Cmq/Ri+NlkHH0r+15Gtx/jh+nSmHVy0SzfCjdQldfDHIofjwKJed+kRcCNLYO98/tKYuO+14eCezUjexy2orvcne0nAL2G8i78oDDpc2JtMHfbeF/W8LiqglWCvtHoeJXHYa96lNiewIQBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YNEz0MdR; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ANUY7Z019755;
	Wed, 11 Jun 2025 04:02:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=0NVg/Pq3YC8dPK/M6YKSkUAzy
	PBCY1U2O3jAcVQi4IA=; b=YNEz0MdRuZkKsR14/PGV9dQi2AD/xWajckFWfqtcH
	heYk3JCKEjkCDZ3B1C6s3dShB9dkBPsrGTCKnv3HwGxktSWbzMqWlQDTHib/xTlb
	hl1MBeEU6QJEr/mOvDO9CC01W2faZp6UGR4zE9Rzf0kABqk+fWoPhE4na+05gq/n
	Vj3o9FcRBrTYHL1cNLNAGhiGp6fonHTd+4bsrNxbqiKZkSmoGu/JAmVN039OZ3Nr
	H3r6g1DaxCDdApgUXS+K1Ln46272FkAt3crLiT8i+R6DRpppvBt7Gu85yeY/UhBx
	NEsW49BjepjuHJMWjwGgj7pQp6ohAfJHKJ4t/sx09nt+Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 476xems9k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 04:02:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Jun 2025 04:02:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Jun 2025 04:02:14 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id EA7393F706F;
	Wed, 11 Jun 2025 04:02:09 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <saikrishnag@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v11 2/6] octeontx2-af: CN20k basic mbox operations and structures
Date: Wed, 11 Jun 2025 16:31:52 +0530
Message-ID: <1749639716-13868-3-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA5NCBTYWx0ZWRfX9Qhi+8hg5V7d +EGFHHjii77a1kkPmt66cG48tpqJc6u2Ut5AoLW7XtUabbvkgRhm6VsTlpBKYhcM21RqG1ML3NG p+SQUHsO6VcdPWqO73tvxwD7SfOw9B2vSH6yzXroU7d4Dnd0QkvKj7BC7fsCPAF4Tmh9TzGNGpL
 0n52xdZJ8I3yly2zerONw0IuUDgX8S4tWGEsChYCkzOq21//rLDbfkNL8q82AZpSjwkEBXmsKkn 1QxVZXz5KhG216beQISexY3mHT/0oOaZwbuvnfnYnejRnyZTUarmxauRoJLgPgVOyAQwn2GWavh Ta6ohfDX0z8nDFSfA0O4wLJoJvbu5NEWUmJJa356RJPJynM7Z3kGcQ4Eq5HXiTcr6HiRF61muf/
 p4NN55JePj9UjZWhQDF4HS0MyybjCq2j+oVNv45jNZ3sqsJPlPCEh9uZOI7s3QqUWL13NrdE
X-Proofpoint-GUID: p9bQacYQJv0eh7mIFu6N56pF62rEs40N
X-Authority-Analysis: v=2.4 cv=E6LNpbdl c=1 sm=1 tr=0 ts=68496237 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=uJAaftDJHW-bjuDCeqkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: p9bQacYQJv0eh7mIFu6N56pF62rEs40N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01

From: Sai Krishna <saikrishnag@marvell.com>

This patch adds basic mbox operation APIs and structures to add support
for mbox module on CN20k silicon. There are few CSR offsets, interrupts
changed between CN20k and prior Octeon series of devices.

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/Makefile |  2 +-
 .../net/ethernet/marvell/octeontx2/af/cn20k/api.h  | 23 ++++++
 .../marvell/octeontx2/af/cn20k/mbox_init.c         | 95 ++++++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/cn20k/reg.h  | 27 ++++++
 drivers/net/ethernet/marvell/octeontx2/af/mbox.c   |  3 +
 drivers/net/ethernet/marvell/octeontx2/af/mbox.h   |  7 ++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    | 76 ++++++++++++++---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    | 10 +++
 .../net/ethernet/marvell/octeontx2/af/rvu_struct.h |  6 +-
 9 files changed, 234 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index ccea378..532813d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
@@ -12,4 +12,4 @@ rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
 		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
 		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
-		  rvu_rep.o
+		  rvu_rep.o cn20k/mbox_init.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
new file mode 100644
index 0000000..74d4580
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#ifndef CN20K_API_H
+#define CN20K_API_H
+
+#include "../rvu.h"
+
+struct ng_rvu {
+	struct mbox_ops         *rvu_mbox_ops;
+	struct qmem             *pf_mbox_addr;
+};
+
+/* Mbox related APIs */
+int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int num);
+int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
+			       int num, int type, unsigned long *pf_bmap);
+void cn20k_free_mbox_memory(struct rvu *rvu);
+#endif /* CN20K_API_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
new file mode 100644
index 0000000..77a0f86
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+
+#include "rvu_trace.h"
+#include "mbox.h"
+#include "reg.h"
+#include "api.h"
+
+int cn20k_rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
+			       int num, int type, unsigned long *pf_bmap)
+{
+	int region;
+	u64 bar;
+
+	for (region = 0; region < num; region++) {
+		if (!test_bit(region, pf_bmap))
+			continue;
+
+		bar = (u64)phys_to_virt((u64)rvu->ng_rvu->pf_mbox_addr->base);
+		bar += region * MBOX_SIZE;
+
+		mbox_addr[region] = (void *)bar;
+
+		if (!mbox_addr[region])
+			return -ENOMEM;
+	}
+	return 0;
+}
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
+int cn20k_rvu_mbox_init(struct rvu *rvu, int type, int ndevs)
+{
+	int dev;
+
+	if (!is_cn20k(rvu->pdev))
+		return 0;
+
+	for (dev = 0; dev < ndevs; dev++)
+		rvu_write64(rvu, BLKADDR_RVUM,
+			    RVU_MBOX_AF_PFX_CFG(dev), ilog2(MBOX_SIZE));
+
+	return rvu_alloc_mbox_memory(rvu, type, ndevs, MBOX_SIZE);
+}
+
+void cn20k_free_mbox_memory(struct rvu *rvu)
+{
+	if (!is_cn20k(rvu->pdev))
+		return;
+
+	qmem_free(rvu->dev, rvu->ng_rvu->pf_mbox_addr);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
new file mode 100644
index 0000000..58152a4
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2024 Marvell.
+ *
+ */
+
+#ifndef RVU_MBOX_REG_H
+#define RVU_MBOX_REG_H
+#include "../rvu.h"
+#include "../rvu_reg.h"
+
+/* RVUM block registers */
+#define RVU_PF_DISC				(0x0)
+#define RVU_PRIV_PFX_DISC(a)			(0x8000208 | (a) << 16)
+#define RVU_PRIV_HWVFX_DISC(a)			(0xD000000 | (a) << 12)
+
+/* Mbox Registers */
+/* RVU AF BAR0 Mbox registers for AF => PFx */
+#define RVU_MBOX_AF_PFX_ADDR(a)			(0x5000 | (a) << 4)
+#define RVU_MBOX_AF_PFX_CFG(a)			(0x6000 | (a) << 4)
+#define RVU_AF_BAR2_SEL				(0x9000000)
+#define RVU_AF_BAR2_PFID			(0x16400)
+#define NIX_CINTX_INT_W1S(a)			(0xd30 | (a) << 12)
+#define NIX_QINTX_CNT(a)			(0xc00 | (a) << 12)
+
+#endif /* RVU_MBOX_REG_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 7d21905..a70d55e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -10,8 +10,11 @@
 #include <linux/pci.h>
 
 #include "rvu_reg.h"
+#include "cn20k/reg.h"
+#include "cn20k/api.h"
 #include "mbox.h"
 #include "rvu_trace.h"
+#include "rvu.h"
 
 static const u16 msgs_offset = ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index a213b26..1e28759 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -50,6 +50,11 @@
 #define MBOX_DIR_PFVF_UP	6  /* PF sends messages to VF */
 #define MBOX_DIR_VFPF_UP	7  /* VF replies to PF */
 
+enum {
+	TYPE_AFVF,
+	TYPE_AFPF,
+};
+
 struct otx2_mbox_dev {
 	void	    *mbase;   /* This dev's mbox region */
 	void	    *hwbase;
@@ -78,6 +83,8 @@ struct otx2_mbox {
 struct mbox_hdr {
 	u64 msg_size;	/* Total msgs size embedded */
 	u16  num_msgs;   /* No of msgs embedded */
+	u16 opt_msg;
+	u8 sig;
 };
 
 /* Header which precedes every msg and is also part of it */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 61d80a2..348e23e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -20,6 +20,8 @@
 
 #include "rvu_trace.h"
 #include "rvu_npc_hash.h"
+#include "cn20k/reg.h"
+#include "cn20k/api.h"
 
 #define DRV_NAME	"rvu_af"
 #define DRV_STRING      "Marvell OcteonTX2 RVU Admin Function Driver"
@@ -34,10 +36,8 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 			 int type, int num,
 			 void (mbox_handler)(struct work_struct *),
 			 void (mbox_up_handler)(struct work_struct *));
-enum {
-	TYPE_AFVF,
-	TYPE_AFPF,
-};
+static irqreturn_t rvu_mbox_pf_intr_handler(int irq, void *rvu_irq);
+static irqreturn_t rvu_mbox_intr_handler(int irq, void *rvu_irq);
 
 /* Supported devices */
 static const struct pci_device_id rvu_id_table[] = {
@@ -2218,6 +2218,22 @@ static void __rvu_mbox_handler(struct rvu_work *mwork, int type, bool poll)
 
 	offset = mbox->rx_start + ALIGN(sizeof(*req_hdr), MBOX_MSG_ALIGN);
 
+	if (req_hdr->sig && !(is_rvu_otx2(rvu) || is_cn20k(rvu->pdev))) {
+		req_hdr->opt_msg = mw->mbox_wrk[devid].num_msgs;
+		rvu_write64(rvu, BLKADDR_NIX0, RVU_AF_BAR2_SEL,
+			    RVU_AF_BAR2_PFID);
+		if (type == TYPE_AFPF)
+			rvu_write64(rvu, BLKADDR_NIX0,
+				    AF_BAR2_ALIASX(0, NIX_CINTX_INT_W1S(devid)),
+				    0x1);
+		else
+			rvu_write64(rvu, BLKADDR_NIX0,
+				    AF_BAR2_ALIASX(0, NIX_QINTX_CNT(devid)),
+				    0x1);
+		usleep_range(5000, 6000);
+		goto done;
+	}
+
 	for (id = 0; id < mw->mbox_wrk[devid].num_msgs; id++) {
 		msg = mdev->mbase + offset;
 
@@ -2250,9 +2266,10 @@ static void __rvu_mbox_handler(struct rvu_work *mwork, int type, bool poll)
 				 err, otx2_mbox_id2name(msg->id),
 				 msg->id, devid);
 	}
+done:
 	mw->mbox_wrk[devid].num_msgs = 0;
 
-	if (poll)
+	if (!is_cn20k(mbox->pdev) && poll)
 		otx2_mbox_wait_for_zero(mbox, devid);
 
 	/* Send mbox responses to VF/PF */
@@ -2365,6 +2382,14 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void __iomem **mbox_addr,
 	int region;
 	u64 bar4;
 
+	/* For cn20k platform AF mailbox region is allocated by software
+	 * and the corresponding IOVA is programmed in hardware unlike earlier
+	 * silicons where software uses the hardware region after ioremap.
+	 */
+	if (is_cn20k(rvu->pdev))
+		return cn20k_rvu_get_mbox_regions(rvu, (void *)mbox_addr,
+						  num, type, pf_bmap);
+
 	/* For cn10k platform VF mailbox regions of a PF follows after the
 	 * PF <-> AF mailbox region. Whereas for Octeontx2 it is read from
 	 * RVU_PF_VF_BAR4_ADDR register.
@@ -2418,6 +2443,10 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void __iomem **mbox_addr,
 	return -ENOMEM;
 }
 
+static struct mbox_ops rvu_mbox_ops = {
+	.pf_intr_handler = rvu_mbox_pf_intr_handler,
+};
+
 static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 			 int type, int num,
 			 void (mbox_handler)(struct work_struct *),
@@ -2425,6 +2454,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 {
 	int err = -EINVAL, i, dir, dir_up;
 	void __iomem **mbox_regions;
+	struct ng_rvu *ng_rvu_mbox;
 	void __iomem *reg_base;
 	struct rvu_work *mwork;
 	unsigned long *pf_bmap;
@@ -2435,6 +2465,12 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	if (!pf_bmap)
 		return -ENOMEM;
 
+	ng_rvu_mbox = kzalloc(sizeof(*ng_rvu_mbox), GFP_KERNEL);
+	if (!ng_rvu_mbox) {
+		err = -ENOMEM;
+		goto free_bitmap;
+	}
+
 	/* RVU VFs */
 	if (type == TYPE_AFVF)
 		bitmap_set(pf_bmap, 0, num);
@@ -2448,12 +2484,20 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		}
 	}
 
+	rvu->ng_rvu = ng_rvu_mbox;
+
+	rvu->ng_rvu->rvu_mbox_ops = &rvu_mbox_ops;
+
+	err = cn20k_rvu_mbox_init(rvu, type, num);
+	if (err)
+		goto free_mem;
+
 	mutex_init(&rvu->mbox_lock);
 
 	mbox_regions = kcalloc(num, sizeof(void __iomem *), GFP_KERNEL);
 	if (!mbox_regions) {
 		err = -ENOMEM;
-		goto free_bitmap;
+		goto free_qmem;
 	}
 
 	switch (type) {
@@ -2480,7 +2524,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	}
 
 	mw->mbox_wq = alloc_workqueue("%s",
-				      WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM,
+				      WQ_HIGHPRI | WQ_MEM_RECLAIM,
 				      num, name);
 	if (!mw->mbox_wq) {
 		err = -ENOMEM;
@@ -2532,6 +2576,10 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		iounmap((void __iomem *)mbox_regions[num]);
 free_regions:
 	kfree(mbox_regions);
+free_qmem:
+	cn20k_free_mbox_memory(rvu);
+free_mem:
+	kfree(rvu->ng_rvu);
 free_bitmap:
 	bitmap_free(pf_bmap);
 	return err;
@@ -2558,8 +2606,8 @@ static void rvu_mbox_destroy(struct mbox_wq_info *mw)
 	otx2_mbox_destroy(&mw->mbox_up);
 }
 
-static void rvu_queue_work(struct mbox_wq_info *mw, int first,
-			   int mdevs, u64 intr)
+void rvu_queue_work(struct mbox_wq_info *mw, int first,
+		    int mdevs, u64 intr)
 {
 	struct otx2_mbox_dev *mdev;
 	struct otx2_mbox *mbox;
@@ -2970,12 +3018,13 @@ static int rvu_register_interrupts(struct rvu *rvu)
 
 	/* Register mailbox interrupt handler */
 	sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], "RVUAF Mbox");
-	ret = request_irq(pci_irq_vector(rvu->pdev, RVU_AF_INT_VEC_MBOX),
-			  rvu_mbox_pf_intr_handler, 0,
+	ret = request_irq(pci_irq_vector
+			  (rvu->pdev, RVU_AF_INT_VEC_MBOX),
+			  rvu->ng_rvu->rvu_mbox_ops->pf_intr_handler, 0,
 			  &rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], rvu);
 	if (ret) {
 		dev_err(rvu->dev,
-			"RVUAF: IRQ registration failed for mbox irq\n");
+			"RVUAF: IRQ registration failed for mbox\n");
 		goto fail;
 	}
 
@@ -3483,6 +3532,9 @@ static void rvu_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 
 	devm_kfree(&pdev->dev, rvu->hw);
+	if (is_cn20k(rvu->pdev))
+		cn20k_free_mbox_memory(rvu);
+	kfree(rvu->ng_rvu);
 	devm_kfree(&pdev->dev, rvu);
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 5c179df..987edf0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -471,6 +471,10 @@ struct mbox_wq_info {
 	struct workqueue_struct *mbox_wq;
 };
 
+struct mbox_ops {
+	irqreturn_t (*pf_intr_handler)(int irq, void *rvu_irq);
+};
+
 struct channel_fwdata {
 	struct sdp_node_info info;
 	u8 valid;
@@ -636,6 +640,8 @@ struct rvu {
 	struct list_head	rep_evtq_head;
 	/* Representor event lock */
 	spinlock_t		rep_evtq_lock;
+
+	struct ng_rvu           *ng_rvu;
 };
 
 static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
@@ -935,6 +941,10 @@ int rvu_mbox_handler_ ## fn_name(struct rvu *, struct req *, struct rsp *);
 MBOX_MESSAGES
 #undef M
 
+/* Mbox APIs */
+void rvu_queue_work(struct mbox_wq_info *mw, int first,
+		    int mdevs, u64 intr);
+
 int rvu_cgx_init(struct rvu *rvu);
 int rvu_cgx_exit(struct rvu *rvu);
 void *rvu_cgx_pdata(u8 cgx_id, struct rvu *rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index 77ac94c..0596a3a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -33,7 +33,8 @@ enum rvu_block_addr_e {
 	BLKADDR_NDC_NIX1_RX	= 0x10ULL,
 	BLKADDR_NDC_NIX1_TX	= 0x11ULL,
 	BLKADDR_APR		= 0x16ULL,
-	BLK_COUNT		= 0x17ULL,
+	BLKADDR_MBOX		= 0x1bULL,
+	BLK_COUNT		= 0x1cULL,
 };
 
 /* RVU Block Type Enumeration */
@@ -49,7 +50,8 @@ enum rvu_block_type_e {
 	BLKTYPE_TIM  = 0x8,
 	BLKTYPE_CPT  = 0x9,
 	BLKTYPE_NDC  = 0xa,
-	BLKTYPE_MAX  = 0xa,
+	BLKTYPE_MBOX = 0x13,
+	BLKTYPE_MAX  = 0x13,
 };
 
 /* RVU Admin function Interrupt Vector Enumeration */
-- 
2.7.4


