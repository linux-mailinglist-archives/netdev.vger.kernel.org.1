Return-Path: <netdev+bounces-143194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7FA9C15C7
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28861C22587
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5861CFEA3;
	Fri,  8 Nov 2024 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="g29+Pn0c"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23AA1CC161;
	Fri,  8 Nov 2024 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041867; cv=none; b=l8Yn+VLQGI2TiqSbBSCp0sIelx/5R1YuMAzsn6Z7kPUjvsFS7lEnU4soxpD1xScLe+Iey+l4j1dtpqMVtUx4ZFN37jidcEvXO2mQL4WZt3QWt/0kzc8GlPyRyRx8LoHruuptoGxlD0AC217ufrpP/G/DCvu5xL+CIooN4uN3FQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041867; c=relaxed/simple;
	bh=FvAwPBVnKNRu/ROer3NYIbY8mCXgpggHG5WoLGTuNxk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5Hw/qAH0ElZr09xhJ1rnY/3Se3ilj191XEL99Q+559rE+Ad4TbF/gQgjxNE8xCmeVpgXDgogh4lsN7x4ml16l8qlDKNb8fyEdUd/E0JXZ0TWAULgJ63wkIZWMnI1ORdB0kIFMPJa0EMrgbRfYXiqs+RAjj07DA7pg+khMcnvSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=g29+Pn0c; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A81ghcr019269;
	Thu, 7 Nov 2024 20:57:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
	W96tkDuDepCQCGFr/1x2zt5HT3oaoxcmHrNbcucX9A=; b=g29+Pn0c066pslVcy
	J3vaR/U/PedOZG8bVZPQWazVzly0ltBFAAtWzD3JL9XWWAOwFLBxuHk7Vn0ZpUgV
	5KqO5G0V0Lj687EIvyoQsQoxxW+6dMcjxxgv9eNYI633T8JHXdmzJnyqy3mfoRTy
	eBw/nyN8cKMwDDEpDNBQ/tu6hvhiwFpABk5Gz6ontUr5ztdO06lnTlC8IhJpUyy8
	0xXsKbperzHZZe9gcGkHeWKLoiEPkVeK/W66wua0chEs93s61s2eboidRUgcdtnd
	xD6MaOoWfjc1WoVfw9AYkems5MBAg1HpcXq7MocKcH6O3KlUgluG51q5o/1uKrsb
	hjfuA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42s97hra0y-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 20:57:36 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 20:57:34 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 20:57:34 -0800
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 66DF73F7044;
	Thu,  7 Nov 2024 20:57:30 -0800 (PST)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <sd@queasysnail.net>, <bbhushan2@marvell.com>
Subject: [net-next PATCH v9 4/8] cn10k-ipsec: Init hardware for outbound ipsec crypto offload
Date: Fri, 8 Nov 2024 10:27:04 +0530
Message-ID: <20241108045708.1205994-5-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108045708.1205994-1-bbhushan2@marvell.com>
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: U3YyXHJ8RLWjQoH5BDw89qT1iRvPZXc2
X-Proofpoint-GUID: U3YyXHJ8RLWjQoH5BDw89qT1iRvPZXc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

One crypto hardware logical function (cpt-lf) per netdev is
required for outbound ipsec crypto offload. Allocate, attach
and initialize one crypto hardware function when enabling
outbound ipsec crypto offload. Crypto hardware function will
be detached and freed on disabling outbound ipsec crypto
offload.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v8->v9:
 - Removed mutex lock to use hardware, now using hardware state

v5->v6:
 - "inline ipsec" replaced with "ipsec crypto offload" in
   description and comment.
 - Removed nixlf setup for crypto operation (added in v4) as
   that is default set, no need to set again in AF driver.
 - Add myself as maintainer for ipsec crypto offload

v4->v5:
 - Fixed un-initialized warning and pointer check
   (comment from Kalesh Anakkur Purayil)

v3->v4:
 - Added some other cleanup comment from Kalesh Anakkur Purayil
 - Fixed enabling nixlf for crypto operation

v1->v2:           
 - Fix compilation error to build driver a module
 - Fix couple of compilation warnings

 MAINTAINERS                                   |   1 +
 .../ethernet/marvell/octeontx2/nic/Makefile   |   1 +
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 415 ++++++++++++++++++
 .../marvell/octeontx2/nic/cn10k_ipsec.h       | 109 +++++
 .../marvell/octeontx2/nic/otx2_common.h       |  18 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  14 +-
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  10 +-
 7 files changed, 566 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c51fd742cbc8..0c08dd97d063 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13810,6 +13810,7 @@ M:	Sunil Goutham <sgoutham@marvell.com>
 M:	Geetha sowjanya <gakula@marvell.com>
 M:	Subbaraya Sundeep <sbhatta@marvell.com>
 M:	hariprasad <hkelam@marvell.com>
+M:	Bharat Bhushan <bbhushan2@marvell.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/marvell/octeontx2/nic/
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index 64a97a0a10ed..183458b88802 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -13,5 +13,6 @@ rvu_nicvf-y := otx2_vf.o
 
 rvu_nicpf-$(CONFIG_DCB) += otx2_dcbnl.o
 rvu_nicpf-$(CONFIG_MACSEC) += cn10k_macsec.o
+rvu_nicpf-$(CONFIG_XFRM_OFFLOAD) += cn10k_ipsec.o
 
 ccflags-y += -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
new file mode 100644
index 000000000000..e09ce42075c7
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell IPSEC offload driver
+ *
+ * Copyright (C) 2024 Marvell.
+ */
+
+#include <net/xfrm.h>
+#include <linux/netdevice.h>
+#include <linux/bitfield.h>
+
+#include "otx2_common.h"
+#include "cn10k_ipsec.h"
+
+static bool is_dev_support_ipsec_offload(struct pci_dev *pdev)
+{
+	return is_dev_cn10ka_b0(pdev) || is_dev_cn10kb(pdev);
+}
+
+static bool cn10k_cpt_device_set_inuse(struct otx2_nic *pf)
+{
+	enum cn10k_cpt_hw_state_e state;
+
+	while (true) {
+		state = atomic_cmpxchg(&pf->ipsec.cpt_state,
+				       CN10K_CPT_HW_AVAILABLE,
+				       CN10K_CPT_HW_IN_USE);
+		if (state == CN10K_CPT_HW_AVAILABLE)
+			return true;
+		if (state == CN10K_CPT_HW_UNAVAILABLE)
+			return false;
+
+		mdelay(1);
+	}
+}
+
+static void cn10k_cpt_device_set_available(struct otx2_nic *pf)
+{
+	atomic_set(&pf->ipsec.cpt_state, CN10K_CPT_HW_AVAILABLE);
+}
+
+static void  cn10k_cpt_device_set_unavailable(struct otx2_nic *pf)
+{
+	atomic_set(&pf->ipsec.cpt_state, CN10K_CPT_HW_UNAVAILABLE);
+}
+
+static int cn10k_outb_cptlf_attach(struct otx2_nic *pf)
+{
+	struct rsrc_attach *attach;
+	int ret = -ENOMEM;
+
+	mutex_lock(&pf->mbox.lock);
+	/* Get memory to put this msg */
+	attach = otx2_mbox_alloc_msg_attach_resources(&pf->mbox);
+	if (!attach)
+		goto unlock;
+
+	attach->cptlfs = true;
+	attach->modify = true;
+
+	/* Send attach request to AF */
+	ret = otx2_sync_mbox_msg(&pf->mbox);
+
+unlock:
+	mutex_unlock(&pf->mbox.lock);
+	return ret;
+}
+
+static int cn10k_outb_cptlf_detach(struct otx2_nic *pf)
+{
+	struct rsrc_detach *detach;
+	int ret = -ENOMEM;
+
+	mutex_lock(&pf->mbox.lock);
+	detach = otx2_mbox_alloc_msg_detach_resources(&pf->mbox);
+	if (!detach)
+		goto unlock;
+
+	detach->partial = true;
+	detach->cptlfs = true;
+
+	/* Send detach request to AF */
+	ret = otx2_sync_mbox_msg(&pf->mbox);
+
+unlock:
+	mutex_unlock(&pf->mbox.lock);
+	return ret;
+}
+
+static int cn10k_outb_cptlf_alloc(struct otx2_nic *pf)
+{
+	struct cpt_lf_alloc_req_msg *req;
+	int ret = -ENOMEM;
+
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_cpt_lf_alloc(&pf->mbox);
+	if (!req)
+		goto unlock;
+
+	/* PF function */
+	req->nix_pf_func = pf->pcifunc;
+	/* Enable SE-IE Engine Group */
+	req->eng_grpmsk = 1 << CN10K_DEF_CPT_IPSEC_EGRP;
+
+	ret = otx2_sync_mbox_msg(&pf->mbox);
+
+unlock:
+	mutex_unlock(&pf->mbox.lock);
+	return ret;
+}
+
+static void cn10k_outb_cptlf_free(struct otx2_nic *pf)
+{
+	mutex_lock(&pf->mbox.lock);
+	otx2_mbox_alloc_msg_cpt_lf_free(&pf->mbox);
+	otx2_sync_mbox_msg(&pf->mbox);
+	mutex_unlock(&pf->mbox.lock);
+}
+
+static int cn10k_outb_cptlf_config(struct otx2_nic *pf)
+{
+	struct cpt_inline_ipsec_cfg_msg *req;
+	int ret = -ENOMEM;
+
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_cpt_inline_ipsec_cfg(&pf->mbox);
+	if (!req)
+		goto unlock;
+
+	req->dir = CPT_INLINE_OUTBOUND;
+	req->enable = 1;
+	req->nix_pf_func = pf->pcifunc;
+	ret = otx2_sync_mbox_msg(&pf->mbox);
+unlock:
+	mutex_unlock(&pf->mbox.lock);
+	return ret;
+}
+
+static void cn10k_outb_cptlf_iq_enable(struct otx2_nic *pf)
+{
+	u64 reg_val;
+
+	/* Set Execution Enable of instruction queue */
+	reg_val = otx2_read64(pf, CN10K_CPT_LF_INPROG);
+	reg_val |= BIT_ULL(16);
+	otx2_write64(pf, CN10K_CPT_LF_INPROG, reg_val);
+
+	/* Set iqueue's enqueuing */
+	reg_val = otx2_read64(pf, CN10K_CPT_LF_CTL);
+	reg_val |= BIT_ULL(0);
+	otx2_write64(pf, CN10K_CPT_LF_CTL, reg_val);
+}
+
+static void cn10k_outb_cptlf_iq_disable(struct otx2_nic *pf)
+{
+	u32 inflight, grb_cnt, gwb_cnt;
+	u32 nq_ptr, dq_ptr;
+	int timeout = 20;
+	u64 reg_val;
+	int cnt;
+
+	/* Disable instructions enqueuing */
+	otx2_write64(pf, CN10K_CPT_LF_CTL, 0ull);
+
+	/* Wait for instruction queue to become empty.
+	 * CPT_LF_INPROG.INFLIGHT count is zero
+	 */
+	do {
+		reg_val = otx2_read64(pf, CN10K_CPT_LF_INPROG);
+		inflight = FIELD_GET(CPT_LF_INPROG_INFLIGHT, reg_val);
+		if (!inflight)
+			break;
+
+		usleep_range(10000, 20000);
+		if (timeout-- < 0) {
+			netdev_err(pf->netdev, "Timeout to cleanup CPT IQ\n");
+			break;
+		}
+	} while (1);
+
+	/* Disable executions in the LF's queue,
+	 * the queue should be empty at this point
+	 */
+	reg_val &= ~BIT_ULL(16);
+	otx2_write64(pf, CN10K_CPT_LF_INPROG, reg_val);
+
+	/* Wait for instruction queue to become empty */
+	cnt = 0;
+	do {
+		reg_val = otx2_read64(pf, CN10K_CPT_LF_INPROG);
+		if (reg_val & BIT_ULL(31))
+			cnt = 0;
+		else
+			cnt++;
+		reg_val = otx2_read64(pf, CN10K_CPT_LF_Q_GRP_PTR);
+		nq_ptr = FIELD_GET(CPT_LF_Q_GRP_PTR_DQ_PTR, reg_val);
+		dq_ptr = FIELD_GET(CPT_LF_Q_GRP_PTR_DQ_PTR, reg_val);
+	} while ((cnt < 10) && (nq_ptr != dq_ptr));
+
+	cnt = 0;
+	do {
+		reg_val = otx2_read64(pf, CN10K_CPT_LF_INPROG);
+		inflight = FIELD_GET(CPT_LF_INPROG_INFLIGHT, reg_val);
+		grb_cnt = FIELD_GET(CPT_LF_INPROG_GRB_CNT, reg_val);
+		gwb_cnt = FIELD_GET(CPT_LF_INPROG_GWB_CNT, reg_val);
+		if (inflight == 0 && gwb_cnt < 40 &&
+		    (grb_cnt == 0 || grb_cnt == 40))
+			cnt++;
+		else
+			cnt = 0;
+	} while (cnt < 10);
+}
+
+/* Allocate memory for CPT outbound Instruction queue.
+ * Instruction queue memory format is:
+ *      -----------------------------
+ *     | Instruction Group memory    |
+ *     |  (CPT_LF_Q_SIZE[SIZE_DIV40] |
+ *     |   x 16 Bytes)               |
+ *     |                             |
+ *      ----------------------------- <-- CPT_LF_Q_BASE[ADDR]
+ *     | Flow Control (128 Bytes)    |
+ *     |                             |
+ *      -----------------------------
+ *     |  Instruction Memory         |
+ *     |  (CPT_LF_Q_SIZE[SIZE_DIV40] |
+ *     |   × 40 × 64 bytes)          |
+ *     |                             |
+ *      -----------------------------
+ */
+static int cn10k_outb_cptlf_iq_alloc(struct otx2_nic *pf)
+{
+	struct cn10k_cpt_inst_queue *iq = &pf->ipsec.iq;
+
+	iq->size = CN10K_CPT_INST_QLEN_BYTES + CN10K_CPT_Q_FC_LEN +
+		    CN10K_CPT_INST_GRP_QLEN_BYTES + OTX2_ALIGN;
+
+	iq->real_vaddr = dma_alloc_coherent(pf->dev, iq->size,
+					    &iq->real_dma_addr, GFP_KERNEL);
+	if (!iq->real_vaddr)
+		return -ENOMEM;
+
+	/* iq->vaddr/dma_addr points to Flow Control location */
+	iq->vaddr = iq->real_vaddr + CN10K_CPT_INST_GRP_QLEN_BYTES;
+	iq->dma_addr = iq->real_dma_addr + CN10K_CPT_INST_GRP_QLEN_BYTES;
+
+	/* Align pointers */
+	iq->vaddr = PTR_ALIGN(iq->vaddr, OTX2_ALIGN);
+	iq->dma_addr = PTR_ALIGN(iq->dma_addr, OTX2_ALIGN);
+	return 0;
+}
+
+static void cn10k_outb_cptlf_iq_free(struct otx2_nic *pf)
+{
+	struct cn10k_cpt_inst_queue *iq = &pf->ipsec.iq;
+
+	if (iq->real_vaddr)
+		dma_free_coherent(pf->dev, iq->size, iq->real_vaddr,
+				  iq->real_dma_addr);
+
+	iq->real_vaddr = NULL;
+	iq->vaddr = NULL;
+}
+
+static int cn10k_outb_cptlf_iq_init(struct otx2_nic *pf)
+{
+	u64 reg_val;
+	int ret;
+
+	/* Allocate Memory for CPT IQ */
+	ret = cn10k_outb_cptlf_iq_alloc(pf);
+	if (ret)
+		return ret;
+
+	/* Disable IQ */
+	cn10k_outb_cptlf_iq_disable(pf);
+
+	/* Set IQ base address */
+	otx2_write64(pf, CN10K_CPT_LF_Q_BASE, pf->ipsec.iq.dma_addr);
+
+	/* Set IQ size */
+	reg_val = FIELD_PREP(CPT_LF_Q_SIZE_DIV40, CN10K_CPT_SIZE_DIV40 +
+			     CN10K_CPT_EXTRA_SIZE_DIV40);
+	otx2_write64(pf, CN10K_CPT_LF_Q_SIZE, reg_val);
+
+	return 0;
+}
+
+static int cn10k_outb_cptlf_init(struct otx2_nic *pf)
+{
+	int ret;
+
+	/* Initialize CPTLF Instruction Queue (IQ) */
+	ret = cn10k_outb_cptlf_iq_init(pf);
+	if (ret)
+		return ret;
+
+	/* Configure CPTLF for outbound ipsec offload */
+	ret = cn10k_outb_cptlf_config(pf);
+	if (ret)
+		goto iq_clean;
+
+	/* Enable CPTLF IQ */
+	cn10k_outb_cptlf_iq_enable(pf);
+	return 0;
+iq_clean:
+	cn10k_outb_cptlf_iq_free(pf);
+	return ret;
+}
+
+static int cn10k_outb_cpt_init(struct net_device *netdev)
+{
+	struct otx2_nic *pf = netdev_priv(netdev);
+	int ret;
+
+	/* Attach a CPT LF for outbound ipsec offload */
+	ret = cn10k_outb_cptlf_attach(pf);
+	if (ret)
+		return ret;
+
+	/* Allocate a CPT LF for outbound ipsec offload */
+	ret = cn10k_outb_cptlf_alloc(pf);
+	if (ret)
+		goto detach;
+
+	/* Initialize the CPTLF for outbound ipsec offload */
+	ret = cn10k_outb_cptlf_init(pf);
+	if (ret)
+		goto lf_free;
+
+	pf->ipsec.io_addr = (__force u64)otx2_get_regaddr(pf,
+						CN10K_CPT_LF_NQX(0));
+
+	/* Set ipsec offload enabled for this device */
+	pf->flags |= OTX2_FLAG_IPSEC_OFFLOAD_ENABLED;
+
+	cn10k_cpt_device_set_available(pf);
+	return 0;
+
+lf_free:
+	cn10k_outb_cptlf_free(pf);
+detach:
+	cn10k_outb_cptlf_detach(pf);
+	return ret;
+}
+
+static int cn10k_outb_cpt_clean(struct otx2_nic *pf)
+{
+	int ret;
+
+	if (!cn10k_cpt_device_set_inuse(pf)) {
+		netdev_err(pf->netdev, "CPT LF device unavailable\n");
+		return -ENODEV;
+	}
+
+	/* Set ipsec offload disabled for this device */
+	pf->flags &= ~OTX2_FLAG_IPSEC_OFFLOAD_ENABLED;
+
+	/* Disable CPTLF Instruction Queue (IQ) */
+	cn10k_outb_cptlf_iq_disable(pf);
+
+	/* Set IQ base address and size to 0 */
+	otx2_write64(pf, CN10K_CPT_LF_Q_BASE, 0);
+	otx2_write64(pf, CN10K_CPT_LF_Q_SIZE, 0);
+
+	/* Free CPTLF IQ */
+	cn10k_outb_cptlf_iq_free(pf);
+
+	/* Free and detach CPT LF */
+	cn10k_outb_cptlf_free(pf);
+	ret = cn10k_outb_cptlf_detach(pf);
+	if (ret)
+		netdev_err(pf->netdev, "Failed to detach CPT LF\n");
+
+	cn10k_cpt_device_set_unavailable(pf);
+	return ret;
+}
+
+int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
+{
+	struct otx2_nic *pf = netdev_priv(netdev);
+
+	/* IPsec offload supported on cn10k */
+	if (!is_dev_support_ipsec_offload(pf->pdev))
+		return -EOPNOTSUPP;
+
+	/* Initialize CPT for outbound ipsec offload */
+	if (enable)
+		return cn10k_outb_cpt_init(netdev);
+
+	return cn10k_outb_cpt_clean(pf);
+}
+
+int cn10k_ipsec_init(struct net_device *netdev)
+{
+	struct otx2_nic *pf = netdev_priv(netdev);
+
+	if (!is_dev_support_ipsec_offload(pf->pdev))
+		return 0;
+
+	cn10k_cpt_device_set_unavailable(pf);
+	return 0;
+}
+EXPORT_SYMBOL(cn10k_ipsec_init);
+
+void cn10k_ipsec_clean(struct otx2_nic *pf)
+{
+	if (!is_dev_support_ipsec_offload(pf->pdev))
+		return;
+
+	if (!(pf->flags & OTX2_FLAG_IPSEC_OFFLOAD_ENABLED))
+		return;
+
+	cn10k_outb_cpt_clean(pf);
+}
+EXPORT_SYMBOL(cn10k_ipsec_clean);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
new file mode 100644
index 000000000000..f3eb5aee4b9d
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell IPSEC offload driver
+ *
+ * Copyright (C) 2024 Marvell.
+ */
+
+#ifndef CN10K_IPSEC_H
+#define CN10K_IPSEC_H
+
+#include <linux/types.h>
+
+/* CPT instruction size in bytes */
+#define CN10K_CPT_INST_SIZE	64
+
+/* CPT instruction (CPT_INST_S) queue length */
+#define CN10K_CPT_INST_QLEN	8200
+
+/* CPT instruction queue size passed to HW is in units of
+ * 40*CPT_INST_S messages.
+ */
+#define CN10K_CPT_SIZE_DIV40 (CN10K_CPT_INST_QLEN / 40)
+
+/* CPT needs 320 free entries */
+#define CN10K_CPT_INST_QLEN_EXTRA_BYTES	(320 * CN10K_CPT_INST_SIZE)
+#define CN10K_CPT_EXTRA_SIZE_DIV40	(320 / 40)
+
+/* CPT instruction queue length in bytes */
+#define CN10K_CPT_INST_QLEN_BYTES					\
+		((CN10K_CPT_SIZE_DIV40 * 40 * CN10K_CPT_INST_SIZE) +	\
+		CN10K_CPT_INST_QLEN_EXTRA_BYTES)
+
+/* CPT instruction group queue length in bytes */
+#define CN10K_CPT_INST_GRP_QLEN_BYTES					\
+		((CN10K_CPT_SIZE_DIV40 + CN10K_CPT_EXTRA_SIZE_DIV40) * 16)
+
+/* CPT FC length in bytes */
+#define CN10K_CPT_Q_FC_LEN 128
+
+/* Default CPT engine group for ipsec offload */
+#define CN10K_DEF_CPT_IPSEC_EGRP 1
+
+/* CN10K CPT LF registers */
+#define CPT_LFBASE			(BLKTYPE_CPT << RVU_FUNC_BLKADDR_SHIFT)
+#define CN10K_CPT_LF_CTL		(CPT_LFBASE | 0x10)
+#define CN10K_CPT_LF_INPROG		(CPT_LFBASE | 0x40)
+#define CN10K_CPT_LF_Q_BASE		(CPT_LFBASE | 0xf0)
+#define CN10K_CPT_LF_Q_SIZE		(CPT_LFBASE | 0x100)
+#define CN10K_CPT_LF_Q_INST_PTR		(CPT_LFBASE | 0x110)
+#define CN10K_CPT_LF_Q_GRP_PTR		(CPT_LFBASE | 0x120)
+#define CN10K_CPT_LF_NQX(a)		(CPT_LFBASE | 0x400 | (a) << 3)
+#define CN10K_CPT_LF_CTX_FLUSH		(CPT_LFBASE | 0x510)
+
+struct cn10k_cpt_inst_queue {
+	u8 *vaddr;
+	u8 *real_vaddr;
+	dma_addr_t dma_addr;
+	dma_addr_t real_dma_addr;
+	u32 size;
+};
+
+enum cn10k_cpt_hw_state_e {
+	CN10K_CPT_HW_UNAVAILABLE,
+	CN10K_CPT_HW_AVAILABLE,
+	CN10K_CPT_HW_IN_USE
+};
+
+struct cn10k_ipsec {
+	/* Outbound CPT */
+	u64 io_addr;
+	atomic_t cpt_state;
+	struct cn10k_cpt_inst_queue iq;
+};
+
+/* CPT LF_INPROG Register */
+#define CPT_LF_INPROG_INFLIGHT	GENMASK_ULL(8, 0)
+#define CPT_LF_INPROG_GRB_CNT	GENMASK_ULL(39, 32)
+#define CPT_LF_INPROG_GWB_CNT	GENMASK_ULL(47, 40)
+
+/* CPT LF_Q_GRP_PTR Register */
+#define CPT_LF_Q_GRP_PTR_DQ_PTR	GENMASK_ULL(14, 0)
+#define CPT_LF_Q_GRP_PTR_NQ_PTR	GENMASK_ULL(46, 32)
+
+/* CPT LF_Q_SIZE Register */
+#define CPT_LF_Q_BASE_ADDR GENMASK_ULL(52, 7)
+
+/* CPT LF_Q_SIZE Register */
+#define CPT_LF_Q_SIZE_DIV40 GENMASK_ULL(14, 0)
+
+#ifdef CONFIG_XFRM_OFFLOAD
+int cn10k_ipsec_init(struct net_device *netdev);
+void cn10k_ipsec_clean(struct otx2_nic *pf);
+int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable);
+#else
+static inline __maybe_unused int cn10k_ipsec_init(struct net_device *netdev)
+{
+	return 0;
+}
+
+static inline __maybe_unused void cn10k_ipsec_clean(struct otx2_nic *pf)
+{
+}
+
+static inline __maybe_unused
+int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
+{
+	return 0;
+}
+#endif
+#endif // CN10K_IPSEC_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 6c686a78b4a7..5b4bbca86b0e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -29,6 +29,7 @@
 #include "otx2_devlink.h"
 #include <rvu_trace.h>
 #include "qos.h"
+#include "cn10k_ipsec.h"
 
 /* IPv4 flag more fragment bit */
 #define IPV4_FLAG_MORE				0x20
@@ -39,6 +40,7 @@
 #define PCI_DEVID_OCTEONTX2_RVU_AFVF		0xA0F8
 
 #define PCI_SUBSYS_DEVID_96XX_RVU_PFVF		0xB200
+#define PCI_SUBSYS_DEVID_CN10K_A_RVU_PFVF	0xB900
 #define PCI_SUBSYS_DEVID_CN10K_B_RVU_PFVF	0xBD00
 
 /* PCI BAR nos */
@@ -466,6 +468,7 @@ struct otx2_nic {
 #define OTX2_FLAG_PTP_ONESTEP_SYNC		BIT_ULL(15)
 #define OTX2_FLAG_ADPTV_INT_COAL_ENABLED BIT_ULL(16)
 #define OTX2_FLAG_TC_MARK_ENABLED		BIT_ULL(17)
+#define OTX2_FLAG_IPSEC_OFFLOAD_ENABLED		BIT_ULL(18)
 	u64			flags;
 	u64			*cq_op_addr;
 
@@ -533,6 +536,9 @@ struct otx2_nic {
 #if IS_ENABLED(CONFIG_MACSEC)
 	struct cn10k_mcs_cfg	*macsec_cfg;
 #endif
+
+	/* Inline ipsec */
+	struct cn10k_ipsec	ipsec;
 };
 
 static inline bool is_otx2_lbkvf(struct pci_dev *pdev)
@@ -577,6 +583,15 @@ static inline bool is_dev_cn10kb(struct pci_dev *pdev)
 	return pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_B_RVU_PFVF;
 }
 
+static inline bool is_dev_cn10ka_b0(struct pci_dev *pdev)
+{
+	if (pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A_RVU_PFVF &&
+	    (pdev->revision & 0xFF) == 0x54)
+		return true;
+
+	return false;
+}
+
 static inline void otx2_setup_dev_hw_settings(struct otx2_nic *pfvf)
 {
 	struct otx2_hw *hw = &pfvf->hw;
@@ -626,6 +641,9 @@ static inline void __iomem *otx2_get_regaddr(struct otx2_nic *nic, u64 offset)
 	case BLKTYPE_NPA:
 		blkaddr = BLKADDR_NPA;
 		break;
+	case BLKTYPE_CPT:
+		blkaddr = BLKADDR_CPT0;
+		break;
 	default:
 		blkaddr = BLKADDR_RVUM;
 		break;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 3b443badf439..c3bc9ea75a2f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -26,6 +26,7 @@
 #include "cn10k.h"
 #include "qos.h"
 #include <rvu_trace.h>
+#include "cn10k_ipsec.h"
 
 #define DRV_NAME	"rvu_nicpf"
 #define DRV_STRING	"Marvell RVU NIC Physical Function Driver"
@@ -2225,6 +2226,10 @@ static int otx2_set_features(struct net_device *netdev,
 		return otx2_enable_rxvlan(pf,
 					  features & NETIF_F_HW_VLAN_CTAG_RX);
 
+	if (changed & NETIF_F_HW_ESP)
+		return cn10k_ipsec_ethtool_init(netdev,
+						features & NETIF_F_HW_ESP);
+
 	return otx2_handle_ntuple_tc_features(netdev, features);
 }
 
@@ -3112,10 +3117,14 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* reset CGX/RPM MAC stats */
 	otx2_reset_mac_stats(pf);
 
+	err = cn10k_ipsec_init(netdev);
+	if (err)
+		goto err_mcs_free;
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Failed to register netdevice\n");
-		goto err_mcs_free;
+		goto err_ipsec_clean;
 	}
 
 	err = otx2_wq_init(pf);
@@ -3156,6 +3165,8 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	otx2_mcam_flow_del(pf);
 err_unreg_netdev:
 	unregister_netdev(netdev);
+err_ipsec_clean:
+	cn10k_ipsec_clean(pf);
 err_mcs_free:
 	cn10k_mcs_free(pf);
 err_del_mcam_entries:
@@ -3353,6 +3364,7 @@ static void otx2_remove(struct pci_dev *pdev)
 
 	otx2_unregister_dl(pf);
 	unregister_netdev(netdev);
+	cn10k_ipsec_clean(pf);
 	cn10k_mcs_free(pf);
 	otx2_sriov_disable(pf->pdev);
 	otx2_sriov_vfcfg_cleanup(pf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index c4e6c78a8deb..6a29319308ed 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -14,6 +14,7 @@
 #include "otx2_reg.h"
 #include "otx2_ptp.h"
 #include "cn10k.h"
+#include "cn10k_ipsec.h"
 
 #define DRV_NAME	"rvu_nicvf"
 #define DRV_STRING	"Marvell RVU NIC Virtual Function Driver"
@@ -683,10 +684,14 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		snprintf(netdev->name, sizeof(netdev->name), "lbk%d", n);
 	}
 
+	err = cn10k_ipsec_init(netdev);
+	if (err)
+		goto err_ptp_destroy;
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Failed to register netdevice\n");
-		goto err_ptp_destroy;
+		goto err_ipsec_clean;
 	}
 
 	err = otx2_vf_wq_init(vf);
@@ -720,6 +725,8 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	otx2_shutdown_tc(vf);
 err_unreg_netdev:
 	unregister_netdev(netdev);
+err_ipsec_clean:
+	cn10k_ipsec_clean(vf);
 err_ptp_destroy:
 	otx2_ptp_destroy(vf);
 err_detach_rsrc:
@@ -772,6 +779,7 @@ static void otx2vf_remove(struct pci_dev *pdev)
 	unregister_netdev(netdev);
 	if (vf->otx2_wq)
 		destroy_workqueue(vf->otx2_wq);
+	cn10k_ipsec_clean(vf);
 	otx2_ptp_destroy(vf);
 	otx2_mcam_flow_del(vf);
 	otx2_shutdown_tc(vf);
-- 
2.34.1


