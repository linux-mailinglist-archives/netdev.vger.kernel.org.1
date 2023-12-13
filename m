Return-Path: <netdev+bounces-56245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C80480E3B8
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 06:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F006C1F21E43
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0373215ADF;
	Tue, 12 Dec 2023 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="M4oOhsuh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8E8CE;
	Mon, 11 Dec 2023 21:18:49 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBJmibi009602;
	Mon, 11 Dec 2023 21:18:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=iYSXhR5K7d67wkLmvCj+mk1Iw5Wk2ltlRH9HUzOcoII=; b=M4o
	OhsuhhgiNM6HmyWGVEXrdjmnz0xMpwCk2vQhE8EbMAAcwlP1iUxyBvXOjzn+cgG4
	qQa5YU95wAfmSNqri3Y+n6c3aZpLVfP5BfTxnI3C5kJ6NqJd9ZHonXP5rCixeT80
	qZRlZD8tCpAaSue7r/6rM1IG2nvtkvLt2oRRye0WrVGztS/bw8D9kfq2Padu6unl
	8zxvS0LUjt+HjNszEKv2uwYUa2+am5ygN5A8bFvi2kDpjRbM4RRXxZeKXkn1coCP
	UxI2/nUGXKoS+6fDvfGzcaZ99z1i6lg29iwH+13se5WQS6Z4FRcGuhwnmf3ULbb1
	9oB+p4Wmhi4J+TPU4ng==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uwyp4kp9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 21:18:40 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 11 Dec
 2023 21:18:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 11 Dec 2023 21:18:38 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 0B9DB3F709A;
	Mon, 11 Dec 2023 21:18:32 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <linux-crypto@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bbrezillon@kernel.org>,
        <arno@natisbad.org>, <pabeni@redhat.com>, <edumazet@google.com>,
        <corbet@lwn.net>, <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>,
        <ndabilpuram@marvell.com>, <schalla@marvell.com>
Subject: [PATCH net-next v2 10/10] crypto: octeontx2: support setting ctx ilen for inline CPT LF
Date: Tue, 12 Dec 2023 10:47:30 +0530
Message-ID: <20231212051730.386088-11-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212051730.386088-1-schalla@marvell.com>
References: <20231212051730.386088-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DjVzyjCZ0t4xnRYCuJBrkirnPHqd7zYA
X-Proofpoint-GUID: DjVzyjCZ0t4xnRYCuJBrkirnPHqd7zYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Provide an option in Inline IPsec configure mailbox to configure the
CPT_AF_LFX_CTL:CTX_ILEN for inline CPT LF attached to CPT RVU PF.
This is needed to set the ctx ilen to size of inbound SA for
HW errata IPBUCPT-38756. Not setting this would lead to new context's
not being fetched.

Also set FLR_FLUSH in CPT_LF_CTX_CTL for CPT LF's as workaround
for same errata.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 .../marvell/octeontx2/otx2_cpt_common.h       |  2 ++
 .../marvell/octeontx2/otx2_cpt_hw_types.h     |  4 ++-
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c | 32 +++++++++++++++++++
 drivers/crypto/marvell/octeontx2/otx2_cptlf.h | 19 +++++++++++
 .../marvell/octeontx2/otx2_cptpf_mbox.c       |  5 +++
 5 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
index 84ed8f35f11b..a2378c56705b 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
@@ -59,6 +59,8 @@ struct otx2_cpt_rx_inline_lf_cfg {
 	u32 credit_th;
 	u16 bpid;
 	u32 reserved;
+	u8 ctx_ilen_valid : 1;
+	u8 ctx_ilen : 7;
 };
 
 /*
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h
index 06bcf49ee379..7e746a4def86 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h
@@ -102,6 +102,7 @@
 #define OTX2_CPT_LF_Q_INST_PTR          (0x110)
 #define OTX2_CPT_LF_Q_GRP_PTR           (0x120)
 #define OTX2_CPT_LF_NQX(a)              (0x400 | (a) << 3)
+#define OTX2_CPT_LF_CTX_CTL             (0x500)
 #define OTX2_CPT_LF_CTX_FLUSH           (0x510)
 #define OTX2_CPT_LF_CTX_ERR             (0x520)
 #define OTX2_CPT_RVU_FUNC_BLKADDR_SHIFT 20
@@ -472,7 +473,8 @@ union otx2_cptx_af_lf_ctrl {
 		u64 cont_err:1;
 		u64 reserved_11_15:5;
 		u64 nixtx_en:1;
-		u64 reserved_17_47:31;
+		u64 ctx_ilen:3;
+		u64 reserved_17_47:28;
 		u64 grp:8;
 		u64 reserved_56_63:8;
 	} s;
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
index c3bafd9a11dd..777474d48ae4 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
@@ -106,6 +106,32 @@ static int cptlf_set_grp_and_pri(struct otx2_cptlfs_info *lfs,
 	return ret;
 }
 
+static int cptlf_set_ctx_ilen(struct otx2_cptlfs_info *lfs, int ctx_ilen)
+{
+	union otx2_cptx_af_lf_ctrl lf_ctrl;
+	struct otx2_cptlf_info *lf;
+	int slot, ret = 0;
+
+	for (slot = 0; slot < lfs->lfs_num; slot++) {
+		lf = &lfs->lf[slot];
+
+		ret = otx2_cpt_read_af_reg(lfs->mbox, lfs->pdev,
+					   CPT_AF_LFX_CTL(lf->slot),
+					   &lf_ctrl.u, lfs->blkaddr);
+		if (ret)
+			return ret;
+
+		lf_ctrl.s.ctx_ilen = ctx_ilen;
+
+		ret = otx2_cpt_write_af_reg(lfs->mbox, lfs->pdev,
+					    CPT_AF_LFX_CTL(lf->slot),
+					    lf_ctrl.u, lfs->blkaddr);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+
 static void cptlf_hw_init(struct otx2_cptlfs_info *lfs)
 {
 	/* Disable instruction queues */
@@ -443,6 +469,12 @@ int otx2_cptlf_init(struct otx2_cptlfs_info *lfs, u8 eng_grp_mask, int pri,
 	if (ret)
 		goto free_iq;
 
+	if (lfs->ctx_ilen_ovrd) {
+		ret = cptlf_set_ctx_ilen(lfs, lfs->ctx_ilen);
+		if (ret)
+			goto free_iq;
+	}
+
 	return 0;
 
 free_iq:
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptlf.h b/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
index ffaca642b640..bd8604be2952 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptlf.h
@@ -121,6 +121,8 @@ struct otx2_cptlfs_info {
 	atomic_t state;         /* LF's state. started/reset */
 	int blkaddr;            /* CPT blkaddr: BLKADDR_CPT0/BLKADDR_CPT1 */
 	int global_slot;        /* Global slot across the blocks */
+	u8 ctx_ilen;
+	u8 ctx_ilen_ovrd;
 };
 
 static inline void otx2_cpt_free_instruction_queues(
@@ -310,6 +312,19 @@ static inline void otx2_cptlf_set_iqueue_exec(struct otx2_cptlf_info *lf,
 			 OTX2_CPT_LF_INPROG, lf_inprog.u);
 }
 
+static inline void otx2_cptlf_set_ctx_flr_flush(struct otx2_cptlf_info *lf)
+{
+	u8 blkaddr = lf->lfs->blkaddr;
+	u64 val;
+
+	val = otx2_cpt_read64(lf->lfs->reg_base, blkaddr, lf->slot,
+			      OTX2_CPT_LF_CTX_CTL);
+	val |= BIT_ULL(0);
+
+	otx2_cpt_write64(lf->lfs->reg_base, blkaddr, lf->slot,
+			 OTX2_CPT_LF_CTX_CTL, val);
+}
+
 static inline void otx2_cptlf_enable_iqueue_exec(struct otx2_cptlf_info *lf)
 {
 	otx2_cptlf_set_iqueue_exec(lf, true);
@@ -325,6 +340,10 @@ static inline void otx2_cptlf_enable_iqueues(struct otx2_cptlfs_info *lfs)
 	int slot;
 
 	for (slot = 0; slot < lfs->lfs_num; slot++) {
+		/* Enable flush on FLR for Errata */
+		if (is_dev_cn10kb(lfs->pdev))
+			otx2_cptlf_set_ctx_flr_flush(&lfs->lf[slot]);
+
 		otx2_cptlf_enable_iqueue_exec(&lfs->lf[slot]);
 		otx2_cptlf_enable_iqueue_enq(&lfs->lf[slot]);
 	}
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
index 5d63763db2af..ec1ac7e836a3 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_mbox.c
@@ -267,6 +267,9 @@ static int handle_msg_rx_inline_ipsec_lf_cfg(struct otx2_cptpf_dev *cptpf,
 	otx2_cptlf_set_dev_info(&cptpf->lfs, cptpf->pdev, cptpf->reg_base,
 				&cptpf->afpf_mbox, BLKADDR_CPT0);
 	cptpf->lfs.global_slot = 0;
+	cptpf->lfs.ctx_ilen_ovrd = cfg_req->ctx_ilen_valid;
+	cptpf->lfs.ctx_ilen = cfg_req->ctx_ilen;
+
 	ret = otx2_inline_cptlf_setup(cptpf, &cptpf->lfs, egrp, num_lfs);
 	if (ret) {
 		dev_err(&cptpf->pdev->dev, "Inline-Ipsec CPT0 LF setup failed.\n");
@@ -279,6 +282,8 @@ static int handle_msg_rx_inline_ipsec_lf_cfg(struct otx2_cptpf_dev *cptpf,
 					cptpf->reg_base, &cptpf->afpf_mbox,
 					BLKADDR_CPT1);
 		cptpf->cpt1_lfs.global_slot = num_lfs;
+		cptpf->cpt1_lfs.ctx_ilen_ovrd = cfg_req->ctx_ilen_valid;
+		cptpf->cpt1_lfs.ctx_ilen = cfg_req->ctx_ilen;
 		ret = otx2_inline_cptlf_setup(cptpf, &cptpf->cpt1_lfs, egrp,
 					      num_lfs);
 		if (ret) {
-- 
2.25.1


