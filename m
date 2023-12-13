Return-Path: <netdev+bounces-55741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E0780C1C6
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 08:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD20280C67
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 07:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BBF2030A;
	Mon, 11 Dec 2023 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FzQO83M+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BF0D7;
	Sun, 10 Dec 2023 23:20:09 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BAMrXDq012812;
	Sun, 10 Dec 2023 23:19:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=N18/kp16RTpQI4FddQQeEqyZYd4XAmPWOcNzgVDTp4c=; b=FzQ
	O83M+VGC+rNJvlZQL5dmKR5vFIDD6+IptK71k1sOUDRoh/+nddaQe6+A8ZCmUuhk
	qQxzjGuL/xa5w89z/ctnGG3oZ+0LopYgpWPc/tofixbJ36WBt3lkKLfQDHDhGAPJ
	HURXbQeE2drHz7G+MVdOLYJDPmPmjYBmOHCqGjmFIjSJBxlCDn8EcogbY/mSKYwX
	jyHwbNipQ0w2KllN2NgyNYWrhoLfkJgM15Tnc4137Fzj7nChJULHal8qebtCsbUJ
	BHUffESVTAFUV5iYU8NaakD6xV6j7IaDEJPMl/Z4jW+YWxW5fzF6u5hk5WYoqeg4
	GXz9+1JJy2eUe85pSCw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uvrmjkmk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 10 Dec 2023 23:19:59 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 10 Dec
 2023 23:19:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 10 Dec 2023 23:19:57 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 8CC0E3F7098;
	Sun, 10 Dec 2023 23:19:51 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <linux-crypto@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bbrezillon@kernel.org>,
        <arno@natisbad.org>, <pabeni@redhat.com>, <edumazet@google.com>,
        <corbet@lwn.net>, <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>,
        <ndabilpuram@marvell.com>, <schalla@marvell.com>
Subject: [PATCH net-next v1 06/10] crypto: octeontx2: add LF reset on queue disable
Date: Mon, 11 Dec 2023 12:49:09 +0530
Message-ID: <20231211071913.151225-7-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211071913.151225-1-schalla@marvell.com>
References: <20231211071913.151225-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RsFBPCCpOSluKESU8lFy50uHhgtLagCu
X-Proofpoint-ORIG-GUID: RsFBPCCpOSluKESU8lFy50uHhgtLagCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

CPT LF must be reset and follow CPT LF disable sequence
suggested by HW team, when driver exits.
This patch adds code for the same.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 .../marvell/octeontx2/otx2_cpt_common.h       |  1 +
 .../marvell/octeontx2/otx2_cpt_mbox_common.c  | 26 +++++++
 drivers/crypto/marvell/octeontx2/otx2_cptlf.h | 77 ++++++++++++-------
 .../marvell/octeontx2/otx2_cptpf_mbox.c       |  9 ++-
 .../marvell/octeontx2/otx2_cptvf_mbox.c       |  2 +
 5 files changed, 86 insertions(+), 29 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
index 568efac3d8a6..f5e3392b9b19 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
@@ -232,5 +232,6 @@ int otx2_cpt_attach_rscrs_msg(struct otx2_cptlfs_info *lfs);
 int otx2_cpt_detach_rsrcs_msg(struct otx2_cptlfs_info *lfs);
 int otx2_cpt_msix_offset_msg(struct otx2_cptlfs_info *lfs);
 int otx2_cpt_sync_mbox_msg(struct otx2_mbox *mbox);
+int otx2_cpt_lf_reset_msg(struct otx2_cptlfs_info *lfs, int slot);
 
 #endif /* __OTX2_CPT_COMMON_H */
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c b/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
index 273ee5352a50..da8e4e4e7aed 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_mbox_common.c
@@ -229,3 +229,29 @@ int otx2_cpt_sync_mbox_msg(struct otx2_mbox *mbox)
 	return otx2_mbox_check_rsp_msgs(mbox, 0);
 }
 EXPORT_SYMBOL_NS_GPL(otx2_cpt_sync_mbox_msg, CRYPTO_DEV_OCTEONTX2_CPT);
+
+int otx2_cpt_lf_reset_msg(struct otx2_cptlfs_info *lfs, int slot)
+{
+	struct otx2_mbox *mbox = lfs->mbox;
+	struct pci_dev *pdev = lfs->pdev;
+	struct cpt_lf_rst_req *req;
+	int ret;
+
+	req = (struct cpt_lf_rst_req *)otx2_mbox_alloc_msg_rsp(mbox, 0, sizeof(*req),
+							       sizeof(struct msg_rsp));
+	if (req == NULL) {
+		dev_err(&pdev->dev, "RVU MBOX failed to get message.\n");
+		return -EFAULT;
+	}
+
+	req->hdr.id = MBOX_MSG_CPT_LF_RESET;
+	req->hdr.sig = OTX2_MBOX_REQ_SIG;
+	req->hdr.pcifunc = 0;
+	req->slot = slot;
+	ret = otx2_cpt_send_mbox_msg(mbox, pdev);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(otx2_cpt_lf_reset_msg, CRYPTO_DEV_OCTEONTX2_CPT);
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptlf.h b/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
index 70138d65ba9e..8d6f10f67ac0 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
@@ -5,6 +5,7 @@
 #define __OTX2_CPTLF_H
 
 #include <linux/soc/marvell/octeontx2/asm.h>
+#include <linux/bitfield.h>
 #include <mbox.h>
 #include <rvu.h>
 #include "otx2_cpt_common.h"
@@ -118,6 +119,7 @@ struct otx2_cptlfs_info {
 	u8 kvf_limits;          /* Kernel crypto limits */
 	atomic_t state;         /* LF's state. started/reset */
 	int blkaddr;            /* CPT blkaddr: BLKADDR_CPT0/BLKADDR_CPT1 */
+	int global_slot;        /* Global slot across the blocks */
 };
 
 static inline void otx2_cpt_free_instruction_queues(
@@ -205,48 +207,71 @@ static inline void otx2_cptlf_set_iqueues_size(struct otx2_cptlfs_info *lfs)
 		otx2_cptlf_do_set_iqueue_size(&lfs->lf[slot]);
 }
 
+#define INFLIGHT   GENMASK_ULL(8, 0)
+#define GRB_CNT    GENMASK_ULL(39, 32)
+#define GWB_CNT    GENMASK_ULL(47, 40)
+#define XQ_XOR     GENMASK_ULL(63, 63)
+#define DQPTR      GENMASK_ULL(19, 0)
+#define NQPTR      GENMASK_ULL(51, 32)
+
 static inline void otx2_cptlf_do_disable_iqueue(struct otx2_cptlf_info *lf)
 {
-	union otx2_cptx_lf_ctl lf_ctl = { .u = 0x0 };
-	union otx2_cptx_lf_inprog lf_inprog;
+	void __iomem *reg_base = lf->lfs->reg_base;
+	struct pci_dev *pdev = lf->lfs->pdev;
 	u8 blkaddr = lf->lfs->blkaddr;
-	int timeout = 20;
+	int timeout = 1000000;
+	u64 inprog, inst_ptr;
+	u64 slot = lf->slot;
+	u64 qsize, pending;
+	int i = 0;
 
 	/* Disable instructions enqueuing */
-	otx2_cpt_write64(lf->lfs->reg_base, blkaddr, lf->slot,
-			 OTX2_CPT_LF_CTL, lf_ctl.u);
+	otx2_cpt_write64(reg_base, blkaddr, slot, OTX2_CPT_LF_CTL, 0x0);
 
-	/* Wait for instruction queue to become empty */
+	inprog = otx2_cpt_read64(reg_base, blkaddr, slot, OTX2_CPT_LF_INPROG);
+	inprog |= BIT_ULL(16);
+	otx2_cpt_write64(reg_base, blkaddr, slot, OTX2_CPT_LF_INPROG, inprog);
+
+	qsize = otx2_cpt_read64(reg_base, blkaddr, slot, OTX2_CPT_LF_Q_SIZE) & 0x7FFF;
+	do {
+		inst_ptr = otx2_cpt_read64(reg_base, blkaddr, slot, OTX2_CPT_LF_Q_INST_PTR);
+		pending = (FIELD_GET(XQ_XOR, inst_ptr) * qsize * 40) +
+			  FIELD_GET(NQPTR, inst_ptr) - FIELD_GET(DQPTR, inst_ptr);
+		udelay(1);
+		timeout--;
+	} while ((pending != 0) && (timeout != 0));
+
+	if (timeout == 0)
+		dev_warn(&pdev->dev, "TIMEOUT: CPT poll on pending instructions\n");
+
+	timeout = 1000000;
+	/* Wait for CPT queue to become execution-quiescent */
 	do {
-		lf_inprog.u = otx2_cpt_read64(lf->lfs->reg_base, blkaddr,
-					      lf->slot, OTX2_CPT_LF_INPROG);
-		if (!lf_inprog.s.inflight)
-			break;
-
-		usleep_range(10000, 20000);
-		if (timeout-- < 0) {
-			dev_err(&lf->lfs->pdev->dev,
-				"Error LF %d is still busy.\n", lf->slot);
-			break;
+		inprog = otx2_cpt_read64(reg_base, blkaddr, slot, OTX2_CPT_LF_INPROG);
+
+		if ((FIELD_GET(INFLIGHT, inprog) == 0) &&
+		    (FIELD_GET(GRB_CNT, inprog) == 0)) {
+			i++;
+		} else {
+			i = 0;
+			timeout--;
 		}
+	} while ((timeout != 0) && (i < 10));
 
-	} while (1);
-
-	/*
-	 * Disable executions in the LF's queue,
-	 * the queue should be empty at this point
-	 */
-	lf_inprog.s.eena = 0x0;
-	otx2_cpt_write64(lf->lfs->reg_base, blkaddr, lf->slot,
-			 OTX2_CPT_LF_INPROG, lf_inprog.u);
+	if (timeout == 0)
+		dev_warn(&pdev->dev, "TIMEOUT: CPT poll on inflight count\n");
+	/* Wait for 2 us to flush all queue writes to memory */
+	udelay(2);
 }
 
 static inline void otx2_cptlf_disable_iqueues(struct otx2_cptlfs_info *lfs)
 {
 	int slot;
 
-	for (slot = 0; slot < lfs->lfs_num; slot++)
+	for (slot = 0; slot < lfs->lfs_num; slot++) {
 		otx2_cptlf_do_disable_iqueue(&lfs->lf[slot]);
+		otx2_cpt_lf_reset_msg(lfs, lfs->global_slot + slot);
+	}
 }
 
 static inline void otx2_cptlf_set_iqueue_enq(struct otx2_cptlf_info *lf,
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
index 390ed146d309..a6f16438bd4a 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
@@ -201,8 +201,8 @@ static int handle_msg_rx_inline_ipsec_lf_cfg(struct otx2_cptpf_dev *cptpf,
 					     struct mbox_msghdr *req)
 {
 	struct otx2_cpt_rx_inline_lf_cfg *cfg_req;
+	int num_lfs = 1, ret;
 	u8 egrp;
-	int ret;
 
 	cfg_req = (struct otx2_cpt_rx_inline_lf_cfg *)req;
 	if (cptpf->lfs.lfs_num) {
@@ -223,8 +223,9 @@ static int handle_msg_rx_inline_ipsec_lf_cfg(struct otx2_cptpf_dev *cptpf,
 
 	otx2_cptlf_set_dev_info(&cptpf->lfs, cptpf->pdev, cptpf->reg_base,
 				&cptpf->afpf_mbox, BLKADDR_CPT0);
+	cptpf->lfs.global_slot = 0;
 	ret = otx2_cptlf_init(&cptpf->lfs, 1 << egrp, OTX2_CPT_QUEUE_HI_PRIO,
-			      1);
+			      num_lfs);
 	if (ret) {
 		dev_err(&cptpf->pdev->dev,
 			"LF configuration failed for RX inline ipsec.\n");
@@ -236,8 +237,9 @@ static int handle_msg_rx_inline_ipsec_lf_cfg(struct otx2_cptpf_dev *cptpf,
 		otx2_cptlf_set_dev_info(&cptpf->cpt1_lfs, cptpf->pdev,
 					cptpf->reg_base, &cptpf->afpf_mbox,
 					BLKADDR_CPT1);
+		cptpf->cpt1_lfs.global_slot = num_lfs;
 		ret = otx2_cptlf_init(&cptpf->cpt1_lfs, 1 << egrp,
-				      OTX2_CPT_QUEUE_HI_PRIO, 1);
+				      OTX2_CPT_QUEUE_HI_PRIO, num_lfs);
 		if (ret) {
 			dev_err(&cptpf->pdev->dev,
 				"LF configuration failed for RX inline ipsec.\n");
@@ -449,6 +451,7 @@ static void process_afpf_mbox_msg(struct otx2_cptpf_dev *cptpf,
 		break;
 	case MBOX_MSG_CPT_INLINE_IPSEC_CFG:
 	case MBOX_MSG_NIX_INLINE_IPSEC_CFG:
+	case MBOX_MSG_CPT_LF_RESET:
 		break;
 
 	default:
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c
index f68da1d08fdf..d9fa5f6e204d 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_mbox.c
@@ -133,6 +133,8 @@ static void process_pfvf_mbox_mbox_msg(struct otx2_cptvf_dev *cptvf,
 		memcpy(cptvf->eng_caps, eng_caps->eng_caps,
 		       sizeof(cptvf->eng_caps));
 		break;
+	case MBOX_MSG_CPT_LF_RESET:
+		break;
 	default:
 		dev_err(&cptvf->pdev->dev, "Unsupported msg %d received.\n",
 			msg->id);
-- 
2.25.1


