Return-Path: <netdev+bounces-145888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36539D13DD
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BFA1F23C09
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2571B6D0D;
	Mon, 18 Nov 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SKM+wD+3"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630B1B394F;
	Mon, 18 Nov 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942116; cv=none; b=AQjfKO3rRHN9PviOflEz5Rog3WVuq6rh9pCroNFdNoYZFDhlbEK8EVrqoyF4PFc3aKTmYaaknCTV4oUwKlVsHAW4S2Eb2p5YCDTfrobKICjlalXi2c0dN1V8/MGHpsDS0LxA9oLCdVyEyY32UCWuGHR+REmhAKCowEipPRgfEQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942116; c=relaxed/simple;
	bh=kKGdmMo1zyhxg9QB9tookVwGaMFNqRAAGpP8aiTWZAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OF7R+y+etir3VHF94qHEdlScmJODfOaJxjO15x+xDsX5zX+GjfAH00QKwx857bZvl7aKx0UPYd14mOEd9VWRzzWsFG0Wireg+cE/itBCFxa2YDOT+/yHGjdMGFLW8XG1j6oNJCcYz7oNjDKhpXOcF/dRL/9yzxmjgk5qIPZXHjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SKM+wD+3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI80fkG024454;
	Mon, 18 Nov 2024 07:01:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
	t865r+97O8u+aVWC4+w5Y/d5A05jNQHVVSCTMyC9X0=; b=SKM+wD+3+fg7BjNad
	ATdP8O38U2T42wfZSt+rYLZBH4gjQVQvmFcn2ZO054ByCxgAifHTnt45jYMOt2QT
	0Pni9OVDIVVP4Ri/HSqwZFD7hr2iAL3eW/gQBS8HvnNBElGPjclgLEtrj6V2CT0R
	1A5Q4swJ3oJYsjs6WcPfY4CeUM6Iy4XTugyS2aIuvUb4iq6I45nX73VydamA55px
	mpkzph8hPaDIzVHu0PIU7TaZmNE2S51/gm1mk3DZXraMMdwXpEg0vPJp4BJORBr8
	nwgVHojF1/fjInYA2DdoKBWlkZLYSJiOAItwd1TN8Rv+ESvDKKN264tdTsVDWEUq
	J3o6A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4301ps8pa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 07:01:44 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 18 Nov 2024 07:01:43 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 18 Nov 2024 07:01:43 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id F09333F7041;
	Mon, 18 Nov 2024 07:01:38 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v4 2/6] octeontx2-af: CN20k basic mbox operations and structures
Date: Mon, 18 Nov 2024 20:31:20 +0530
Message-ID: <20241118150124.984323-3-saikrishnag@marvell.com>
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
X-Proofpoint-ORIG-GUID: U17bhG2mI2PNBNAN99aukN4Xqzn33D_O
X-Proofpoint-GUID: U17bhG2mI2PNBNAN99aukN4Xqzn33D_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

This patch adds basic mbox operation APIs and structures to add support
for mbox module on CN20k silicon. There are few CSR offsets, interrupts
changed between CN20k and prior Octeon series of devices.

Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |  2 +-
 .../ethernet/marvell/octeontx2/af/cn20k/api.h | 22 +++++++
 .../marvell/octeontx2/af/cn20k/mbox_init.c    | 49 ++++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h | 27 ++++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.c  |  3 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  7 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 65 +++++++++++++++----
 .../net/ethernet/marvell/octeontx2/af/rvu.h   | 20 ++++++
 .../marvell/octeontx2/af/rvu_struct.h         |  6 +-
 9 files changed, 186 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index ccea37847df8..532813d8d028 100644
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
index 000000000000..b57bd38181aa
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/api.h
@@ -0,0 +1,22 @@
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
+#endif /* CN20K_API_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
new file mode 100644
index 000000000000..0e128013a03f
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/mbox_init.c
@@ -0,0 +1,49 @@
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
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/reg.h
new file mode 100644
index 000000000000..58152a4024ec
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
index 791c468a10c5..1e3e72107a9d 100644
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
 
 /* Default values of PF and VF bit encodings in PCIFUNC for
  * CN9XXX and CN10K series silicons.
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 9969615fb994..e5c9fcf113c4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -55,6 +55,11 @@ extern u16 rvu_pcifunc_pf_mask;
 extern u16 rvu_pcifunc_func_shift;
 extern u16 rvu_pcifunc_func_mask;
 
+enum {
+	TYPE_AFVF,
+	TYPE_AFPF,
+};
+
 struct otx2_mbox_dev {
 	void	    *mbase;   /* This dev's mbox region */
 	void	    *hwbase;
@@ -83,6 +88,8 @@ struct otx2_mbox {
 struct mbox_hdr {
 	u64 msg_size;	/* Total msgs size embedded */
 	u16  num_msgs;   /* No of msgs embedded */
+	u16 opt_msg;
+	u8 sig;
 };
 
 /* Header which precedes every msg and is also part of it */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index dcfc27a60b43..dcf9ad75b3e9 100644
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
@@ -2212,6 +2212,22 @@ static void __rvu_mbox_handler(struct rvu_work *mwork, int type, bool poll)
 
 	offset = mbox->rx_start + ALIGN(sizeof(*req_hdr), MBOX_MSG_ALIGN);
 
+	if (req_hdr->sig) {
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
 
@@ -2245,9 +2261,10 @@ static void __rvu_mbox_handler(struct rvu_work *mwork, int type, bool poll)
 				 err, otx2_mbox_id2name(msg->id),
 				 msg->id, devid);
 	}
+done:
 	mw->mbox_wrk[devid].num_msgs = 0;
 
-	if (poll)
+	if (!is_cn20k(mbox->pdev) && poll)
 		otx2_mbox_wait_for_zero(mbox, devid);
 
 	/* Send mbox responses to VF/PF */
@@ -2360,6 +2377,10 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 	int region;
 	u64 bar4;
 
+	if (is_cn20k(rvu->pdev))
+		return cn20k_rvu_get_mbox_regions(rvu, mbox_addr,
+						  num, type, pf_bmap);
+
 	/* For cn10k platform VF mailbox regions of a PF follows after the
 	 * PF <-> AF mailbox region. Whereas for Octeontx2 it is read from
 	 * RVU_PF_VF_BAR4_ADDR register.
@@ -2413,12 +2434,17 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 	return -ENOMEM;
 }
 
+static struct mbox_ops rvu_mbox_ops = {
+	.pf_intr_handler = rvu_mbox_pf_intr_handler,
+};
+
 static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 			 int type, int num,
 			 void (mbox_handler)(struct work_struct *),
 			 void (mbox_up_handler)(struct work_struct *))
 {
 	int err = -EINVAL, i, dir, dir_up;
+	struct ng_rvu *ng_rvu_mbox;
 	void __iomem *reg_base;
 	struct rvu_work *mwork;
 	unsigned long *pf_bmap;
@@ -2443,6 +2469,18 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		}
 	}
 
+	ng_rvu_mbox = kzalloc(sizeof(*ng_rvu_mbox), GFP_KERNEL);
+	if (!ng_rvu_mbox) {
+		err = -ENOMEM;
+		goto free_bitmap;
+	}
+
+	rvu->ng_rvu = ng_rvu_mbox;
+
+	rvu->ng_rvu->rvu_mbox_ops = &rvu_mbox_ops;
+
+	cn20k_rvu_mbox_init(rvu, type, num);
+
 	mutex_init(&rvu->mbox_lock);
 
 	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
@@ -2475,7 +2513,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	}
 
 	mw->mbox_wq = alloc_workqueue("%s",
-				      WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM,
+				      WQ_HIGHPRI | WQ_MEM_RECLAIM,
 				      num, name);
 	if (!mw->mbox_wq) {
 		err = -ENOMEM;
@@ -2553,8 +2591,8 @@ static void rvu_mbox_destroy(struct mbox_wq_info *mw)
 	otx2_mbox_destroy(&mw->mbox_up);
 }
 
-static void rvu_queue_work(struct mbox_wq_info *mw, int first,
-			   int mdevs, u64 intr)
+void rvu_queue_work(struct mbox_wq_info *mw, int first,
+		    int mdevs, u64 intr)
 {
 	struct otx2_mbox_dev *mdev;
 	struct otx2_mbox *mbox;
@@ -2965,12 +3003,14 @@ static int rvu_register_interrupts(struct rvu *rvu)
 
 	/* Register mailbox interrupt handler */
 	sprintf(&rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], "RVUAF Mbox");
-	ret = request_irq(pci_irq_vector(rvu->pdev, RVU_AF_INT_VEC_MBOX),
-			  rvu_mbox_pf_intr_handler, 0,
-			  &rvu->irq_name[RVU_AF_INT_VEC_MBOX * NAME_SIZE], rvu);
+	ret = request_irq(pci_irq_vector
+			  (rvu->pdev, RVU_AF_INT_VEC_MBOX),
+			  rvu->ng_rvu->rvu_mbox_ops->pf_intr_handler, 0,
+			  &rvu->irq_name[RVU_AF_INT_VEC_MBOX *
+			  NAME_SIZE], rvu);
 	if (ret) {
 		dev_err(rvu->dev,
-			"RVUAF: IRQ registration failed for mbox irq\n");
+			"RVUAF: IRQ registration failed for mbox\n");
 		goto fail;
 	}
 
@@ -3478,6 +3518,7 @@ static void rvu_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 
 	devm_kfree(&pdev->dev, rvu->hw);
+	kfree(rvu->ng_rvu);
 	devm_kfree(&pdev->dev, rvu);
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index bb747ab901fe..d8c572611d21 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -444,6 +444,10 @@ struct mbox_wq_info {
 	struct workqueue_struct *mbox_wq;
 };
 
+struct mbox_ops {
+	irqreturn_t (*pf_intr_handler)(int irq, void *rvu_irq);
+};
+
 struct channel_fwdata {
 	struct sdp_node_info info;
 	u8 valid;
@@ -609,6 +613,8 @@ struct rvu {
 	struct list_head	rep_evtq_head;
 	/* Representor event lock */
 	spinlock_t		rep_evtq_lock;
+
+	struct ng_rvu           *ng_rvu;
 };
 
 static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
@@ -898,11 +904,25 @@ static inline bool is_cgx_vf(struct rvu *rvu, u16 pcifunc)
 		is_pf_cgxmapped(rvu, rvu_get_pf(pcifunc)));
 }
 
+#define CN20K_CHIPID	0x20
+
+/*
+ * Silicon check for CN20K family
+ */
+static inline bool is_cn20k(struct pci_dev *pdev)
+{
+	return (pdev->subsystem_device & 0xFF) == CN20K_CHIPID;
+}
+
 #define M(_name, _id, fn_name, req, rsp)				\
 int rvu_mbox_handler_ ## fn_name(struct rvu *, struct req *, struct rsp *);
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
index 77ac94cb2ec4..0596a3ac4c12 100644
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
2.25.1


