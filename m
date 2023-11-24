Return-Path: <netdev+bounces-50834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2686B7F7441
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A6CAB21577
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25016249E0;
	Fri, 24 Nov 2023 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MjI9H+hI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B94D72;
	Fri, 24 Nov 2023 04:51:27 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO7Onsk003240;
	Fri, 24 Nov 2023 04:51:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=VxUyJ3WLziSHYySqnfR1hb0MMjOm/T21H8nDVzUG9xc=;
 b=MjI9H+hIff8sa9sodjBZ9sTPXUg7rI9UMXNWGLRrztxAk6+EmGJpSyChUJ/4ceEU2w8s
 bJ5ncSAyL54+1b+0rLTSKo+DYeVnCwU/Lo1UQhs7fa/qjkY5031U10aXbnv4HIZK63I/
 g6W+L/ojWf4H6CZXQVmuqDIgPW1LeN66copH74fHolLri4vchZ4qmxLP7xKhKrWEDSEH
 1WFsOcoJnFTA4sPNLi89RMtZRfLGP0rs+Ct7WLnC0GsyW02MFkclPm8lO/9FDfxlicvz
 hdv//XTzf4NisiBLLgWxy8JZTxsf0aegJ1MLnuIlm3HE5nnvtA5o8Sv4r4sTsMPkY9+C 5g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uhpxn69b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 04:51:18 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 24 Nov
 2023 04:51:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 24 Nov 2023 04:51:15 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id A7D243F707D;
	Fri, 24 Nov 2023 04:51:10 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <linux-crypto@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bbrezillon@kernel.org>,
        <arno@natisbad.org>, <pabeni@redhat.com>, <edumazet@google.com>,
        <ndabilpuram@marvell.com>, <sgoutham@marvell.com>,
        <jerinj@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <schalla@marvell.com>
Subject: [PATCH net-next 04/10] crypto: octeontx2: add devlink option to set t106 mode
Date: Fri, 24 Nov 2023 18:20:41 +0530
Message-ID: <20231124125047.2329693-5-schalla@marvell.com>
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
X-Proofpoint-ORIG-GUID: ENFKydAOfEe8XT_HvbrNNOMloJ5-bX4A
X-Proofpoint-GUID: ENFKydAOfEe8XT_HvbrNNOMloJ5-bX4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02

On CN10KA B0/CN10KB, CPT scatter gather format has modified
to support multi-seg in inline IPsec. Due to this CPT requires
new firmware and doesn't work with CN10KA0/A1 firmware. To make
HW works in backward compatibility mode or works with CN10KA0/A1
firmware, a bit(T106_MODE) is introduced in HW CSR.

This patch adds devlink parameter for configuring T106_MODE.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 .../crypto/device_drivers/octeontx2.rst       |  4 ++
 .../marvell/octeontx2/otx2_cpt_common.h       |  8 +++
 .../marvell/octeontx2/otx2_cpt_devlink.c      | 50 +++++++++++++++++--
 .../marvell/octeontx2/otx2_cptpf_main.c       |  4 +-
 4 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/Documentation/crypto/device_drivers/octeontx2.rst b/Documentation/crypto/device_drivers/octeontx2.rst
index 0481bdcd77e9..288998c10b3d 100644
--- a/Documentation/crypto/device_drivers/octeontx2.rst
+++ b/Documentation/crypto/device_drivers/octeontx2.rst
@@ -23,3 +23,7 @@ The ``octeontx2`` driver implements the following driver-specific parameters.
      - u16
      - runtime
      - Configures maximum icb entries that HW can use in RX path.
+   * - ``t106_mode``
+     - u8
+     - runtime
+     - Used to configure CN10KA B0/CN10KB CPT to work as CN10KA A0/A1.
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
index 805b2adf0c22..bef78db15a89 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
@@ -200,6 +200,14 @@ static inline bool cpt_feature_rxc_icb_cnt(struct pci_dev *pdev)
 	return false;
 }
 
+static inline bool cpt_feature_sgv2(struct pci_dev *pdev)
+{
+	if (!is_dev_otx2(pdev) && !is_dev_cn10ka_ax(pdev))
+		return true;
+
+	return false;
+}
+
 int otx2_cpt_send_ready_msg(struct otx2_mbox *mbox, struct pci_dev *pdev);
 int otx2_cpt_send_mbox_msg(struct otx2_mbox *mbox, struct pci_dev *pdev);
 
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c b/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
index e11f334600c7..322da826dc71 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
@@ -24,10 +24,7 @@ static int otx2_cpt_dl_egrp_delete(struct devlink *dl, u32 id,
 static int otx2_cpt_dl_uc_info(struct devlink *dl, u32 id,
 			       struct devlink_param_gset_ctx *ctx)
 {
-	struct otx2_cpt_devlink *cpt_dl = devlink_priv(dl);
-	struct otx2_cptpf_dev *cptpf = cpt_dl->cptpf;
-
-	otx2_cpt_print_uc_dbg_info(cptpf);
+	ctx->val.vstr[0] = '\0';
 
 	return 0;
 }
@@ -69,11 +66,50 @@ static int otx2_cpt_dl_max_rxc_icb_cnt_set(struct devlink *dl, u32 id,
 	return 0;
 }
 
+static int otx2_cpt_dl_t106_mode_get(struct devlink *dl, u32 id,
+				     struct devlink_param_gset_ctx *ctx)
+{
+	struct otx2_cpt_devlink *cpt_dl = devlink_priv(dl);
+	struct otx2_cptpf_dev *cptpf = cpt_dl->cptpf;
+	struct pci_dev *pdev = cptpf->pdev;
+	u64 reg_val = 0;
+
+	otx2_cpt_read_af_reg(&cptpf->afpf_mbox, pdev, CPT_AF_CTL, &reg_val,
+			     BLKADDR_CPT0);
+	ctx->val.vu8 = (reg_val >> 18) & 0x1;
+
+	return 0;
+}
+
+static int otx2_cpt_dl_t106_mode_set(struct devlink *dl, u32 id,
+				     struct devlink_param_gset_ctx *ctx)
+{
+	struct otx2_cpt_devlink *cpt_dl = devlink_priv(dl);
+	struct otx2_cptpf_dev *cptpf = cpt_dl->cptpf;
+	struct pci_dev *pdev = cptpf->pdev;
+	u64 reg_val = 0;
+
+	if (cptpf->enabled_vfs != 0 || cptpf->eng_grps.is_grps_created)
+		return -EPERM;
+
+	if (cpt_feature_sgv2(pdev)) {
+		otx2_cpt_read_af_reg(&cptpf->afpf_mbox, pdev, CPT_AF_CTL, &reg_val,
+				     BLKADDR_CPT0);
+		reg_val &= ~(0x1ULL << 18);
+		reg_val |= ((u64)ctx->val.vu8 & 0x1) << 18;
+		return otx2_cpt_write_af_reg(&cptpf->afpf_mbox, pdev, CPT_AF_CTL,
+					     reg_val, BLKADDR_CPT0);
+	}
+
+	return 0;
+}
+
 enum otx2_cpt_dl_param_id {
 	OTX2_CPT_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	OTX2_CPT_DEVLINK_PARAM_ID_EGRP_CREATE,
 	OTX2_CPT_DEVLINK_PARAM_ID_EGRP_DELETE,
 	OTX2_CPT_DEVLINK_PARAM_ID_MAX_RXC_ICB_CNT,
+	OTX2_CPT_DEVLINK_PARAM_ID_T106_MODE,
 };
 
 static const struct devlink_param otx2_cpt_dl_params[] = {
@@ -93,6 +129,11 @@ static const struct devlink_param otx2_cpt_dl_params[] = {
 			     otx2_cpt_dl_max_rxc_icb_cnt,
 			     otx2_cpt_dl_max_rxc_icb_cnt_set,
 			     NULL),
+	DEVLINK_PARAM_DRIVER(OTX2_CPT_DEVLINK_PARAM_ID_T106_MODE,
+			     "t106_mode", DEVLINK_PARAM_TYPE_U8,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     otx2_cpt_dl_t106_mode_get, otx2_cpt_dl_t106_mode_set,
+			     NULL),
 };
 
 static int otx2_cpt_dl_info_firmware_version_put(struct devlink_info_req *req,
@@ -164,7 +205,6 @@ int otx2_cpt_register_dl(struct otx2_cptpf_dev *cptpf)
 		devlink_free(dl);
 		return ret;
 	}
-
 	devlink_register(dl);
 
 	return 0;
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index c64c50a964ed..7d44b54659bf 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -600,10 +600,10 @@ static int cptpf_get_rid(struct pci_dev *pdev, struct otx2_cptpf_dev *cptpf)
 	}
 	otx2_cpt_read_af_reg(&cptpf->afpf_mbox, pdev, CPT_AF_CTL, &reg_val,
 			     BLKADDR_CPT0);
-	if ((is_dev_cn10ka_b0(pdev) && (reg_val & BIT_ULL(18))) ||
+	if ((cpt_feature_sgv2(pdev) && (reg_val & BIT_ULL(18))) ||
 	    is_dev_cn10ka_ax(pdev))
 		eng_grps->rid = CPT_UC_RID_CN10K_A;
-	else if (is_dev_cn10kb(pdev) || is_dev_cn10ka_b0(pdev))
+	else if (cpt_feature_sgv2(pdev))
 		eng_grps->rid = CPT_UC_RID_CN10K_B;
 
 	return 0;
-- 
2.25.1


