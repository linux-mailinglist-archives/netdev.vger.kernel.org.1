Return-Path: <netdev+bounces-50833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D467F743F
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80364B21521
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B62D286A2;
	Fri, 24 Nov 2023 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ISbUY0z6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC3619E;
	Fri, 24 Nov 2023 04:51:20 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO7Onsj003240;
	Fri, 24 Nov 2023 04:51:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=ZBqqilMCGzj+LccdO1fK5EdM4ywz+4kqK9phk4yT7PE=;
 b=ISbUY0z6e7XD1FtA1ftBBMHMkeZ+BAHBoq5uILz4wxjPGBNQCNHk5pZuX6b1iQwwueZX
 p+Ul6iEsofwI/o5NaFLm5inak69AukQQKeT13Gh1ctdVwrFnJc1NbnHLXJi+BZ0dQClG
 C3rW4jxhh4uPnTu2e5D9AJISn94qjpFcvqiNkYF/8ximr4dclmQQR+6LHPMjOTDb8w5/
 utk+j3TfAt0OH9+4K6uCjog7324m7R6IHwBXkuzl02X38MKp2GRz+IgU8YToLi37PNcH
 ELJzB+wT04Dd5EnlKEe/Y+DzxjhkhXVPyxIZoltLDayAMybVxyqJyTpwibV8fPEqhUR1 ig== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uhpxn69b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 04:51:12 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 24 Nov
 2023 04:51:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 24 Nov 2023 04:51:09 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 191C83F7040;
	Fri, 24 Nov 2023 04:51:04 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <linux-crypto@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bbrezillon@kernel.org>,
        <arno@natisbad.org>, <pabeni@redhat.com>, <edumazet@google.com>,
        <ndabilpuram@marvell.com>, <sgoutham@marvell.com>,
        <jerinj@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <schalla@marvell.com>
Subject: [PATCH net-next 03/10] crypto: octeontx2: add devlink option to set max_rxc_icb_cnt
Date: Fri, 24 Nov 2023 18:20:40 +0530
Message-ID: <20231124125047.2329693-4-schalla@marvell.com>
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
X-Proofpoint-ORIG-GUID: Jur8ncmhXJIECwD8Sb1_UfDZErHZG4b4
X-Proofpoint-GUID: Jur8ncmhXJIECwD8Sb1_UfDZErHZG4b4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02

On CN10KA B0/CN10KB HW, maximum icb entries that RX can use,
can be configured through HW CSR. This patch adds option
to set max icb entries through devlink parameter and also sets
max_rxc_icb_cnt to 0xc0 as default to match inline
inbound peak performance compared to other chip versions.
This patch also documents the devlink parameter under
Documentation/crypto/device_drivers.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 Documentation/crypto/device_drivers/index.rst |  9 ++++
 .../crypto/device_drivers/octeontx2.rst       | 25 +++++++++++
 Documentation/crypto/index.rst                |  1 +
 .../marvell/octeontx2/otx2_cpt_common.h       |  8 ++++
 .../marvell/octeontx2/otx2_cpt_devlink.c      | 44 +++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   | 20 +++++++++
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 14 ++++++
 .../ethernet/marvell/octeontx2/af/rvu_reg.h   |  1 +
 8 files changed, 122 insertions(+)
 create mode 100644 Documentation/crypto/device_drivers/index.rst
 create mode 100644 Documentation/crypto/device_drivers/octeontx2.rst

diff --git a/Documentation/crypto/device_drivers/index.rst b/Documentation/crypto/device_drivers/index.rst
new file mode 100644
index 000000000000..c81d311ac61b
--- /dev/null
+++ b/Documentation/crypto/device_drivers/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Hardware Device Driver Specific Documentation
+---------------------------------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   octeontx2
diff --git a/Documentation/crypto/device_drivers/octeontx2.rst b/Documentation/crypto/device_drivers/octeontx2.rst
new file mode 100644
index 000000000000..0481bdcd77e9
--- /dev/null
+++ b/Documentation/crypto/device_drivers/octeontx2.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+octeontx2 devlink support
+=========================
+
+This document describes the devlink features implemented by the ``octeontx2 CPT``
+device drivers.
+
+Parameters
+==========
+
+The ``octeontx2`` driver implements the following driver-specific parameters.
+
+.. list-table:: Driver-specific parameters implemented
+   :widths: 5 5 5 85
+
+   * - Name
+     - Type
+     - Mode
+     - Description
+   * - ``max_rxc_icb_cnt``
+     - u16
+     - runtime
+     - Configures maximum icb entries that HW can use in RX path.
diff --git a/Documentation/crypto/index.rst b/Documentation/crypto/index.rst
index da5d5ad2bdf3..945ca1505ad9 100644
--- a/Documentation/crypto/index.rst
+++ b/Documentation/crypto/index.rst
@@ -28,3 +28,4 @@ for cryptographic use cases, as well as programming examples.
    api
    api-samples
    descore-readme
+   device_drivers/index
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
index 9a2cbee5a834..805b2adf0c22 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_common.h
@@ -192,6 +192,14 @@ static inline void otx2_cpt_set_hw_caps(struct pci_dev *pdev,
 	}
 }
 
+static inline bool cpt_feature_rxc_icb_cnt(struct pci_dev *pdev)
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
index a2aba0b0d68a..e11f334600c7 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
@@ -32,10 +32,48 @@ static int otx2_cpt_dl_uc_info(struct devlink *dl, u32 id,
 	return 0;
 }
 
+static int otx2_cpt_dl_max_rxc_icb_cnt(struct devlink *dl, u32 id,
+				       struct devlink_param_gset_ctx *ctx)
+{
+	struct otx2_cpt_devlink *cpt_dl = devlink_priv(dl);
+	struct otx2_cptpf_dev *cptpf = cpt_dl->cptpf;
+	struct pci_dev *pdev = cptpf->pdev;
+	u64 reg_val = 0;
+
+	otx2_cpt_read_af_reg(&cptpf->afpf_mbox, pdev, CPT_AF_RXC_CFG1, &reg_val,
+			     BLKADDR_CPT0);
+	ctx->val.vu16 = (reg_val >> 32) & 0x1FF;
+
+	return 0;
+}
+
+static int otx2_cpt_dl_max_rxc_icb_cnt_set(struct devlink *dl, u32 id,
+					   struct devlink_param_gset_ctx *ctx)
+{
+	struct otx2_cpt_devlink *cpt_dl = devlink_priv(dl);
+	struct otx2_cptpf_dev *cptpf = cpt_dl->cptpf;
+	struct pci_dev *pdev = cptpf->pdev;
+	u64 reg_val = 0;
+
+	if (cptpf->enabled_vfs != 0)
+		return -EPERM;
+
+	if (cpt_feature_rxc_icb_cnt(pdev)) {
+		otx2_cpt_read_af_reg(&cptpf->afpf_mbox, pdev, CPT_AF_RXC_CFG1, &reg_val,
+				     BLKADDR_CPT0);
+		reg_val &= ~(0x1FFULL << 32);
+		reg_val |= (u64)ctx->val.vu16 << 32;
+		return otx2_cpt_write_af_reg(&cptpf->afpf_mbox, pdev, CPT_AF_RXC_CFG1,
+					     reg_val, BLKADDR_CPT0);
+	}
+	return 0;
+}
+
 enum otx2_cpt_dl_param_id {
 	OTX2_CPT_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	OTX2_CPT_DEVLINK_PARAM_ID_EGRP_CREATE,
 	OTX2_CPT_DEVLINK_PARAM_ID_EGRP_DELETE,
+	OTX2_CPT_DEVLINK_PARAM_ID_MAX_RXC_ICB_CNT,
 };
 
 static const struct devlink_param otx2_cpt_dl_params[] = {
@@ -49,6 +87,12 @@ static const struct devlink_param otx2_cpt_dl_params[] = {
 			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			     otx2_cpt_dl_uc_info, otx2_cpt_dl_egrp_delete,
 			     NULL),
+	DEVLINK_PARAM_DRIVER(OTX2_CPT_DEVLINK_PARAM_ID_MAX_RXC_ICB_CNT,
+			     "max_rxc_icb_cnt", DEVLINK_PARAM_TYPE_U16,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     otx2_cpt_dl_max_rxc_icb_cnt,
+			     otx2_cpt_dl_max_rxc_icb_cnt_set,
+			     NULL),
 };
 
 static int otx2_cpt_dl_info_firmware_version_put(struct devlink_info_req *req,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index c4d999ef5ab4..afc9a1c77513 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -646,6 +646,26 @@ static inline bool is_cnf10ka_a0(struct rvu *rvu)
 	return false;
 }
 
+static inline bool is_cn10ka_a0(struct rvu *rvu)
+{
+	struct pci_dev *pdev = rvu->pdev;
+
+	if (pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A &&
+	    (pdev->revision & 0x0F) == 0x0)
+		return true;
+	return false;
+}
+
+static inline bool is_cn10ka_a1(struct rvu *rvu)
+{
+	struct pci_dev *pdev = rvu->pdev;
+
+	if (pdev->subsystem_device == PCI_SUBSYS_DEVID_CN10K_A &&
+	    (pdev->revision & 0x0F) == 0x1)
+		return true;
+	return false;
+}
+
 static inline bool is_rvu_npc_hash_extract_en(struct rvu *rvu)
 {
 	u64 npc_const3;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index f047185f38e0..f36a5ee55ac3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -673,6 +673,7 @@ static bool is_valid_offset(struct rvu *rvu, struct cpt_rd_wr_reg_msg *req)
 		case CPT_AF_BLK_RST:
 		case CPT_AF_CONSTANTS1:
 		case CPT_AF_CTX_FLUSH_TIMER:
+		case CPT_AF_RXC_CFG1:
 			return true;
 		}
 
@@ -1213,8 +1214,21 @@ int rvu_cpt_ctx_flush(struct rvu *rvu, u16 pcifunc)
 
 int rvu_cpt_init(struct rvu *rvu)
 {
+	u64 reg_val;
+
 	/* Retrieve CPT PF number */
 	rvu->cpt_pf_num = get_cpt_pf_num(rvu);
+	if (is_block_implemented(rvu->hw, BLKADDR_CPT0) &&
+	    (!is_rvu_otx2(rvu) && !is_cn10ka_a0(rvu) && !is_cn10ka_a1(rvu))) {
+		/* Set CPT_AF_RXC_CFG1:max_rxc_icb_cnt to 0xc0 to not effect
+		 * inline inbound peak performance
+		 */
+		reg_val = rvu_read64(rvu, BLKADDR_CPT0, CPT_AF_RXC_CFG1);
+		reg_val &= ~(0x1FFULL << 32);
+		reg_val |= 0xC0ULL << 32;
+		rvu_write64(rvu, BLKADDR_CPT0, CPT_AF_RXC_CFG1, reg_val);
+	}
+
 	spin_lock_init(&rvu->cpt_intr_lock);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
index b42e631e52d0..b3f1442d5196 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.h
@@ -532,6 +532,7 @@
 #define CPT_AF_CTX_PSH_PC               (0x49450ull)
 #define CPT_AF_CTX_PSH_LATENCY_PC       (0x49458ull)
 #define CPT_AF_CTX_CAM_DATA(a)          (0x49800ull | (u64)(a) << 3)
+#define CPT_AF_RXC_CFG1                 (0x50000ull)
 #define CPT_AF_RXC_TIME                 (0x50010ull)
 #define CPT_AF_RXC_TIME_CFG             (0x50018ull)
 #define CPT_AF_RXC_DFRG                 (0x50020ull)
-- 
2.25.1


