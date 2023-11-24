Return-Path: <netdev+bounces-50838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E477F7449
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4FE5B2150A
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85791EB3D;
	Fri, 24 Nov 2023 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PsOUAQS5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FECFD72;
	Fri, 24 Nov 2023 04:51:50 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO5PB57019083;
	Fri, 24 Nov 2023 04:51:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=3VBRJXRZy10KhCCSmifuBZFsDFkB99Wgd1wYXz/N82U=;
 b=PsOUAQS5bUbx7Ycsg4CNuNTGfIQH4rtXlvhCQ7rAllA+StkBk9Yi9Gd7fsHwsSvRccIQ
 BsqIVOSLwiqnSqYHq+88OrIT2BWL5cVIAX+cscIK3m19t3jBuVOnbT2T1qrVkroi9YHK
 f/x1rJt8F5eulom0uP+I5dEpIlrg7L2O3qEu0OdkuCXQowI4f3iKymn8QrnxmOuIL3GK
 7vFbkrcU+j46Pul8D8w7Viz6KaOGw/2DF+lM6ksJKUt3gBW8k2fUXB4P8nC0YbO942a5
 SX8XF/H6WOtMNqjdbOqFGbqcoLjEe0DHMbflWM6QPuIOmAoqK7ybf3eqUN+uB/OB4oof tA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uj7yku08q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 04:51:39 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 24 Nov
 2023 04:51:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 24 Nov 2023 04:51:38 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 0A6E53F7040;
	Fri, 24 Nov 2023 04:51:32 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <linux-crypto@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bbrezillon@kernel.org>,
        <arno@natisbad.org>, <pabeni@redhat.com>, <edumazet@google.com>,
        <ndabilpuram@marvell.com>, <sgoutham@marvell.com>,
        <jerinj@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <schalla@marvell.com>
Subject: [PATCH net-next 08/10] crypto: octeontx2: add ctx_val workaround
Date: Fri, 24 Nov 2023 18:20:45 +0530
Message-ID: <20231124125047.2329693-9-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124125047.2329693-1-schalla@marvell.com>
References: <20231124125047.2329693-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4eTCes8eHYPSUFPYymhm0jl41rRLAmY2
X-Proofpoint-ORIG-GUID: 4eTCes8eHYPSUFPYymhm0jl41rRLAmY2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02

HW has a errata that CPT HW may hit an issue, while processing CPT
instructions with CTX_VAL set and CTX_VAL not set. So, this patch
adds the code to always set the CTX_VAL as a workaround.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 drivers/crypto/marvell/octeontx2/cn10k_cpt.c  | 68 +++++++++++++++++++
 drivers/crypto/marvell/octeontx2/cn10k_cpt.h  | 24 +++++++
 .../marvell/octeontx2/otx2_cpt_hw_types.h     |  2 +
 .../marvell/octeontx2/otx2_cpt_reqmgr.h       |  2 +
 .../marvell/octeontx2/otx2_cptvf_algs.c       | 31 +++++++++
 .../marvell/octeontx2/otx2_cptvf_algs.h       |  5 ++
 .../marvell/octeontx2/otx2_cptvf_reqmgr.c     |  2 +-
 7 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
index b23ae3a020e0..a646aa01d5ef 100644
--- a/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
+++ b/drivers/crypto/marvell/octeontx2/cn10k_cpt.c
@@ -96,6 +96,74 @@ int cn10k_cptvf_lmtst_init(struct otx2_cptvf_dev *cptvf)
 }
 EXPORT_SYMBOL_NS_GPL(cn10k_cptvf_lmtst_init, CRYPTO_DEV_OCTEONTX2_CPT);
 
+void cn10k_cpt_hw_ctx_clear(struct pci_dev *pdev, struct cn10k_cpt_errata_ctx *er_ctx)
+{
+	u64 cptr_dma;
+
+	if (!is_dev_cn10ka_ax(pdev))
+		return;
+
+	cptr_dma = er_ctx->cptr_dma & ~(BIT_ULL(60));
+	cn10k_cpt_ctx_flush(pdev, cptr_dma, true);
+	dma_unmap_single(&pdev->dev, cptr_dma, CN10K_CPT_HW_CTX_SIZE,
+			 DMA_BIDIRECTIONAL);
+	kfree(er_ctx->hw_ctx);
+}
+EXPORT_SYMBOL_NS_GPL(cn10k_cpt_hw_ctx_clear, CRYPTO_DEV_OCTEONTX2_CPT);
+
+void cn10k_cpt_hw_ctx_set(union cn10k_cpt_hw_ctx *hctx, u16 ctx_sz)
+{
+	hctx->w0.aop_valid = 1;
+	hctx->w0.ctx_hdr_sz = 0;
+	hctx->w0.ctx_sz = ctx_sz;
+	hctx->w0.ctx_push_sz = 1;
+}
+EXPORT_SYMBOL_NS_GPL(cn10k_cpt_hw_ctx_set, CRYPTO_DEV_OCTEONTX2_CPT);
+
+int cn10k_cpt_hw_ctx_init(struct pci_dev *pdev, struct cn10k_cpt_errata_ctx *er_ctx)
+{
+	union cn10k_cpt_hw_ctx *hctx;
+	u64 cptr_dma;
+
+	er_ctx->cptr_dma = 0;
+	er_ctx->hw_ctx = NULL;
+
+	if (!is_dev_cn10ka_ax(pdev))
+		return 0;
+
+	hctx = kmalloc(CN10K_CPT_HW_CTX_SIZE, GFP_KERNEL);
+	if (unlikely(!hctx))
+		return -ENOMEM;
+	cptr_dma = dma_map_single(&pdev->dev, hctx, CN10K_CPT_HW_CTX_SIZE,
+				  DMA_BIDIRECTIONAL);
+
+	cn10k_cpt_hw_ctx_set(hctx, 1);
+	er_ctx->hw_ctx = hctx;
+	er_ctx->cptr_dma = cptr_dma | BIT_ULL(60);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cn10k_cpt_hw_ctx_init, CRYPTO_DEV_OCTEONTX2_CPT);
+
+void cn10k_cpt_ctx_flush(struct pci_dev *pdev, u64 cptr, bool inval)
+{
+	struct otx2_cptvf_dev *cptvf = pci_get_drvdata(pdev);
+	struct otx2_cptlfs_info *lfs = &cptvf->lfs;
+	u64 reg;
+
+	reg = (uintptr_t)cptr >> 7;
+	if (inval)
+		reg = reg | BIT_ULL(46);
+
+	otx2_cpt_write64(lfs->reg_base, lfs->blkaddr, lfs->lf[0].slot,
+			 OTX2_CPT_LF_CTX_FLUSH, reg);
+	/* Make sure that the FLUSH operation is complete */
+	wmb();
+	otx2_cpt_read64(lfs->reg_base, lfs->blkaddr, lfs->lf[0].slot,
+			OTX2_CPT_LF_CTX_ERR);
+}
+EXPORT_SYMBOL_NS_GPL(cn10k_cpt_ctx_flush, CRYPTO_DEV_OCTEONTX2_CPT);
+
 int cptvf_hw_ops_get(struct otx2_cptvf_dev *cptvf)
 {
 	if (!test_bit(CN10K_LMTST, &cptvf->cap_flag)) {
diff --git a/drivers/crypto/marvell/octeontx2/cn10k_cpt.h b/drivers/crypto/marvell/octeontx2/cn10k_cpt.h
index 0f714ee564f5..9d47387a7669 100644
--- a/drivers/crypto/marvell/octeontx2/cn10k_cpt.h
+++ b/drivers/crypto/marvell/octeontx2/cn10k_cpt.h
@@ -8,6 +8,26 @@
 #include "otx2_cptpf.h"
 #include "otx2_cptvf.h"
 
+#define CN10K_CPT_HW_CTX_SIZE  256
+
+union cn10k_cpt_hw_ctx {
+	u64 u;
+	struct {
+		u64 reserved_0_47:48;
+		u64 ctx_push_sz:7;
+		u64 reserved_55:1;
+		u64 ctx_hdr_sz:2;
+		u64 aop_valid:1;
+		u64 reserved_59:1;
+		u64 ctx_sz:4;
+	} w0;
+};
+
+struct cn10k_cpt_errata_ctx {
+	union cn10k_cpt_hw_ctx *hw_ctx;
+	u64 cptr_dma;
+};
+
 static inline u8 cn10k_cpt_get_compcode(union otx2_cpt_res_s *result)
 {
 	return ((struct cn10k_cpt_res_s *)result)->compcode;
@@ -30,6 +50,10 @@ static inline u8 otx2_cpt_get_uc_compcode(union otx2_cpt_res_s *result)
 
 int cn10k_cptpf_lmtst_init(struct otx2_cptpf_dev *cptpf);
 int cn10k_cptvf_lmtst_init(struct otx2_cptvf_dev *cptvf);
+void cn10k_cpt_ctx_flush(struct pci_dev *pdev, u64 cptr, bool inval);
+int cn10k_cpt_hw_ctx_init(struct pci_dev *pdev, struct cn10k_cpt_errata_ctx *er_ctx);
+void cn10k_cpt_hw_ctx_clear(struct pci_dev *pdev, struct cn10k_cpt_errata_ctx *er_ctx);
+void cn10k_cpt_hw_ctx_set(union cn10k_cpt_hw_ctx *hctx, u16 ctx_sz);
 int cptvf_hw_ops_get(struct otx2_cptvf_dev *cptvf);
 
 #endif /* __CN10K_CPTLF_H */
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h
index 756aee0c2b05..06bcf49ee379 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h
@@ -102,6 +102,8 @@
 #define OTX2_CPT_LF_Q_INST_PTR          (0x110)
 #define OTX2_CPT_LF_Q_GRP_PTR           (0x120)
 #define OTX2_CPT_LF_NQX(a)              (0x400 | (a) << 3)
+#define OTX2_CPT_LF_CTX_FLUSH           (0x510)
+#define OTX2_CPT_LF_CTX_ERR             (0x520)
 #define OTX2_CPT_RVU_FUNC_BLKADDR_SHIFT 20
 /* LMT LF registers */
 #define OTX2_CPT_LMT_LFBASE             BIT_ULL(OTX2_CPT_RVU_FUNC_BLKADDR_SHIFT)
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h
index fc5aca209837..7c990bb69ac5 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h
@@ -40,6 +40,8 @@ struct otx2_cptvf_request {
 	u32 param2;
 	u16 dlen;
 	union otx2_cpt_opcode opcode;
+	dma_addr_t cptr_dma;
+	void *cptr;
 };
 
 /*
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
index e27ddd3c4e55..1604fc58dc13 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c
@@ -17,6 +17,7 @@
 #include "otx2_cptvf.h"
 #include "otx2_cptvf_algs.h"
 #include "otx2_cpt_reqmgr.h"
+#include "cn10k_cpt.h"
 
 /* Size of salt in AES GCM mode */
 #define AES_GCM_SALT_SIZE 4
@@ -384,6 +385,9 @@ static inline int cpt_enc_dec(struct skcipher_request *req, u32 enc)
 	req_info->is_trunc_hmac = false;
 	req_info->ctrl.s.grp = otx2_cpt_get_kcrypto_eng_grp_num(pdev);
 
+	req_info->req.cptr = ctx->er_ctx.hw_ctx;
+	req_info->req.cptr_dma = ctx->er_ctx.cptr_dma;
+
 	/*
 	 * We perform an asynchronous send and once
 	 * the request is completed the driver would
@@ -530,6 +534,8 @@ static int otx2_cpt_enc_dec_init(struct crypto_skcipher *stfm)
 	struct otx2_cpt_enc_ctx *ctx = crypto_skcipher_ctx(stfm);
 	struct crypto_tfm *tfm = crypto_skcipher_tfm(stfm);
 	struct crypto_alg *alg = tfm->__crt_alg;
+	struct pci_dev *pdev;
+	int ret, cpu_num;
 
 	memset(ctx, 0, sizeof(*ctx));
 	/*
@@ -541,6 +547,15 @@ static int otx2_cpt_enc_dec_init(struct crypto_skcipher *stfm)
 		stfm, sizeof(struct otx2_cpt_req_ctx) +
 		      sizeof(struct skcipher_request));
 
+	ret = get_se_device(&pdev, &cpu_num);
+	if (ret)
+		return ret;
+
+	ctx->pdev = pdev;
+	ret = cn10k_cpt_hw_ctx_init(pdev, &ctx->er_ctx);
+	if (ret)
+		return ret;
+
 	return cpt_skcipher_fallback_init(ctx, alg);
 }
 
@@ -552,6 +567,7 @@ static void otx2_cpt_skcipher_exit(struct crypto_skcipher *tfm)
 		crypto_free_skcipher(ctx->fbk_cipher);
 		ctx->fbk_cipher = NULL;
 	}
+	cn10k_cpt_hw_ctx_clear(ctx->pdev, &ctx->er_ctx);
 }
 
 static int cpt_aead_fallback_init(struct otx2_cpt_aead_ctx *ctx,
@@ -576,6 +592,8 @@ static int cpt_aead_init(struct crypto_aead *atfm, u8 cipher_type, u8 mac_type)
 	struct otx2_cpt_aead_ctx *ctx = crypto_aead_ctx_dma(atfm);
 	struct crypto_tfm *tfm = crypto_aead_tfm(atfm);
 	struct crypto_alg *alg = tfm->__crt_alg;
+	struct pci_dev *pdev;
+	int ret, cpu_num;
 
 	ctx->cipher_type = cipher_type;
 	ctx->mac_type = mac_type;
@@ -632,6 +650,15 @@ static int cpt_aead_init(struct crypto_aead *atfm, u8 cipher_type, u8 mac_type)
 	}
 	crypto_aead_set_reqsize_dma(atfm, sizeof(struct otx2_cpt_req_ctx));
 
+	ret = get_se_device(&pdev, &cpu_num);
+	if (ret)
+		return ret;
+
+	ctx->pdev = pdev;
+	ret = cn10k_cpt_hw_ctx_init(pdev, &ctx->er_ctx);
+	if (ret)
+		return ret;
+
 	return cpt_aead_fallback_init(ctx, alg);
 }
 
@@ -694,6 +721,7 @@ static void otx2_cpt_aead_exit(struct crypto_aead *tfm)
 		crypto_free_aead(ctx->fbk_cipher);
 		ctx->fbk_cipher = NULL;
 	}
+	cn10k_cpt_hw_ctx_clear(ctx->pdev, &ctx->er_ctx);
 }
 
 static int otx2_cpt_aead_gcm_set_authsize(struct crypto_aead *tfm,
@@ -1299,6 +1327,9 @@ static int cpt_aead_enc_dec(struct aead_request *req, u8 reg_type, u8 enc)
 	req_info->is_enc = enc;
 	req_info->is_trunc_hmac = false;
 
+	req_info->req.cptr = ctx->er_ctx.hw_ctx;
+	req_info->req.cptr_dma = ctx->er_ctx.cptr_dma;
+
 	switch (reg_type) {
 	case OTX2_CPT_AEAD_ENC_DEC_REQ:
 		status = create_aead_input_list(req, enc);
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.h b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.h
index f04184bd1744..d29f84f01cee 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.h
@@ -9,6 +9,7 @@
 #include <crypto/skcipher.h>
 #include <crypto/aead.h>
 #include "otx2_cpt_common.h"
+#include "cn10k_cpt.h"
 
 #define OTX2_CPT_MAX_ENC_KEY_SIZE    32
 #define OTX2_CPT_MAX_HASH_KEY_SIZE   64
@@ -123,6 +124,8 @@ struct otx2_cpt_enc_ctx {
 	u8 key_type;
 	u8 enc_align_len;
 	struct crypto_skcipher *fbk_cipher;
+	struct pci_dev *pdev;
+	struct cn10k_cpt_errata_ctx er_ctx;
 };
 
 union otx2_cpt_offset_ctrl {
@@ -161,6 +164,8 @@ struct otx2_cpt_aead_ctx {
 	struct crypto_shash *hashalg;
 	struct otx2_cpt_sdesc *sdesc;
 	struct crypto_aead *fbk_cipher;
+	struct cn10k_cpt_errata_ctx er_ctx;
+	struct pci_dev *pdev;
 	u8 *ipad;
 	u8 *opad;
 	u32 enc_key_len;
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c
index 997a2eb60c66..5387c68f3c9d 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c
@@ -159,7 +159,7 @@ static int process_request(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 	cpu_to_be64s(&iq_cmd.cmd.u);
 	iq_cmd.dptr = info->dptr_baddr | info->gthr_sz << 60;
 	iq_cmd.rptr = info->rptr_baddr | info->sctr_sz << 60;
-	iq_cmd.cptr.u = 0;
+	iq_cmd.cptr.s.cptr = cpt_req->cptr_dma;
 	iq_cmd.cptr.s.grp = ctrl->s.grp;
 
 	/* Fill in the CPT_INST_S type command for HW interpretation */
-- 
2.25.1


