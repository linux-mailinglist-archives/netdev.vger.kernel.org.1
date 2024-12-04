Return-Path: <netdev+bounces-149003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DAB9E3C40
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B730C28410C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A476F20B7FB;
	Wed,  4 Dec 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OmChIyBD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F61F756C;
	Wed,  4 Dec 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321336; cv=none; b=lWy6xSI1wMcfPCfimRQlU5kjjgDExDkkJMgWg93arvKtfEEXj1O43nPi7/i0L+NXa3Qh+wB7Zk7EoUQSEYLFEyUH4Wk1iW2CLN+x9YNBrYXVrxAdmS+FWWYd7j9Q9rfUDxnutuiMCKfDiryeN2uqPgCpIubDwvWiBmxkg8ciTSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321336; c=relaxed/simple;
	bh=HZqZkM2GKqfLDwS1p4B789JAJ4YQH14LqUw/xLqaORI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2i+tYjeuzRZxzk7EFsPxCzGPvP0tMIyrUAuwhPmqYsZqJqTOQjDZcTzQ2Q3zqFkBICH6XUJshAbBIZYfB0dwhl5tiZSHu5aDOrzFaqpzNLNqfFr3gSerY0SveegDHzFZ8F6FmCesRaUPZgdwx8mC5bTnmmctmUcOjdFAMZUwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OmChIyBD; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4CrgbG023424;
	Wed, 4 Dec 2024 06:08:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
	xz8ygxqgJSD2Av6cytPzS5tzXFudB/LscKUpqbjySo=; b=OmChIyBDvpSdvCgTG
	VvE/l9SuPMELG2ZTcu4fI9/MkvZ4IYXMPAYSnnmKpGZVP1evswe7pgCFwQXIrP3N
	vVSm5MToYADRT4BiEY0Odim/dAQkm4svSoQHy7225P2zlGQOpWyOZj/PYp0uoFOy
	jdZuq7ADJN4A78ID7Y/7YpHyVgrU/BgLXGVSpjmPm8hijG7OV7RtsgBVT+6PCUio
	BNTjP+RhUe/TxLNwdmJAl+w/m1yA+jAtKfyzeZtvsTsHEOJKMe8j+dNVWdNsaVuS
	ff/bVsMOgI0D8DK7kfCFrcoPZXmDCh70alyt+yJR7m/CQV45hv56HUNBUkCGfpbY
	b9z7w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43aqg2055y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 06:08:33 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Dec 2024 06:08:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Dec 2024 06:08:33 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id AB8415B6938;
	Wed,  4 Dec 2024 06:08:28 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v5 1/6] octeontx2: Set appropriate PF, VF masks and shifts based on silicon
Date: Wed, 4 Dec 2024 19:38:16 +0530
Message-ID: <20241204140821.1858263-2-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241204140821.1858263-1-saikrishnag@marvell.com>
References: <20241204140821.1858263-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fMZBWberOnCsmN8dEs5KroWKKnd5yZLu
X-Proofpoint-ORIG-GUID: fMZBWberOnCsmN8dEs5KroWKKnd5yZLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

Number of RVU PFs on CN20K silicon have increased to 96 from maximum
of 32 that were supported on earlier silicons. Every RVU PF and VF is
identified by HW using a 16bit PF_FUNC value. Due to the change in
Max number of PFs in CN20K, the bit encoding of this PF_FUNC has changed.

This patch handles the change by exporting PF,VF masks and shifts
present in mailbox module to all other modules.

Also moved the NIX AF register offset macros to other files which
will be posted in coming patches.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.c  | 15 ++++++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  5 ++++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  5 ----
 .../net/ethernet/marvell/octeontx2/af/rvu.h   | 14 +++++----
 .../marvell/octeontx2/nic/otx2_common.h       | 11 +------
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h | 30 -------------------
 6 files changed, 30 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 1e5aa5397504..791c468a10c5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -13,6 +13,21 @@
 #include "mbox.h"
 #include "rvu_trace.h"
 
+/* Default values of PF and VF bit encodings in PCIFUNC for
+ * CN9XXX and CN10K series silicons.
+ */
+u16 rvu_pcifunc_pf_shift = 10;
+EXPORT_SYMBOL(rvu_pcifunc_pf_shift);
+
+u16 rvu_pcifunc_pf_mask = 0x3F;
+EXPORT_SYMBOL(rvu_pcifunc_pf_mask);
+
+u16 rvu_pcifunc_func_shift;
+EXPORT_SYMBOL(rvu_pcifunc_func_shift);
+
+u16 rvu_pcifunc_func_mask = 0x3FF;
+EXPORT_SYMBOL(rvu_pcifunc_func_mask);
+
 static const u16 msgs_offset = ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
 
 void __otx2_mbox_reset(struct otx2_mbox *mbox, int devid)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 62c07407eb94..9969615fb994 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -50,6 +50,11 @@
 #define MBOX_DIR_PFVF_UP	6  /* PF sends messages to VF */
 #define MBOX_DIR_VFPF_UP	7  /* VF replies to PF */
 
+extern u16 rvu_pcifunc_pf_shift;
+extern u16 rvu_pcifunc_pf_mask;
+extern u16 rvu_pcifunc_func_shift;
+extern u16 rvu_pcifunc_func_mask;
+
 struct otx2_mbox_dev {
 	void	    *mbase;   /* This dev's mbox region */
 	void	    *hwbase;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index cd0d7b7774f1..7c0f520d658b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -400,11 +400,6 @@ static void rvu_update_rsrc_map(struct rvu *rvu, struct rvu_pfvf *pfvf,
 	rvu_write64(rvu, BLKADDR_RVUM, reg | (devnum << 16), num_lfs);
 }
 
-inline int rvu_get_pf(u16 pcifunc)
-{
-	return (pcifunc >> RVU_PFVF_PF_SHIFT) & RVU_PFVF_PF_MASK;
-}
-
 void rvu_get_pf_numvfs(struct rvu *rvu, int pf, int *numvfs, int *hwvf)
 {
 	u64 cfg;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index a383b5ef5b2d..0f5017e93c6f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -41,10 +41,10 @@
 #define MAX_CPT_BLKS				2
 
 /* PF_FUNC */
-#define RVU_PFVF_PF_SHIFT	10
-#define RVU_PFVF_PF_MASK	0x3F
-#define RVU_PFVF_FUNC_SHIFT	0
-#define RVU_PFVF_FUNC_MASK	0x3FF
+#define RVU_PFVF_PF_SHIFT	rvu_pcifunc_pf_shift
+#define RVU_PFVF_PF_MASK	rvu_pcifunc_pf_mask
+#define RVU_PFVF_FUNC_SHIFT	rvu_pcifunc_func_shift
+#define RVU_PFVF_FUNC_MASK	rvu_pcifunc_func_mask
 
 #ifdef CONFIG_DEBUG_FS
 struct dump_ctx {
@@ -834,7 +834,6 @@ int rvu_alloc_rsrc_contig(struct rsrc_bmap *rsrc, int nrsrc);
 void rvu_free_rsrc_contig(struct rsrc_bmap *rsrc, int nrsrc, int start);
 bool rvu_rsrc_check_contig(struct rsrc_bmap *rsrc, int nrsrc);
 u16 rvu_get_rsrc_mapcount(struct rvu_pfvf *pfvf, int blkaddr);
-int rvu_get_pf(u16 pcifunc);
 struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc);
 void rvu_get_pf_numvfs(struct rvu *rvu, int pf, int *numvfs, int *hwvf);
 bool is_block_implemented(struct rvu_hwinfo *hw, int blkaddr);
@@ -875,6 +874,11 @@ static inline bool is_rep_dev(struct rvu *rvu, u16 pcifunc)
 	return false;
 }
 
+static inline int rvu_get_pf(u16 pcifunc)
+{
+	return (pcifunc >> RVU_PFVF_PF_SHIFT) & RVU_PFVF_PF_MASK;
+}
+
 /* CGX APIs */
 static inline bool is_pf_cgxmapped(struct rvu *rvu, u8 pf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 566848663fea..4681df652ff1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -27,6 +27,7 @@
 #include "otx2_reg.h"
 #include "otx2_txrx.h"
 #include "otx2_devlink.h"
+#include <rvu.h>
 #include <rvu_trace.h>
 #include "qos.h"
 #include "rep.h"
@@ -869,21 +870,11 @@ MBOX_UP_MCS_MESSAGES
 /* Time to wait before watchdog kicks off */
 #define OTX2_TX_TIMEOUT		(100 * HZ)
 
-#define	RVU_PFVF_PF_SHIFT	10
-#define	RVU_PFVF_PF_MASK	0x3F
-#define	RVU_PFVF_FUNC_SHIFT	0
-#define	RVU_PFVF_FUNC_MASK	0x3FF
-
 static inline bool is_otx2_vf(u16 pcifunc)
 {
 	return !!(pcifunc & RVU_PFVF_FUNC_MASK);
 }
 
-static inline int rvu_get_pf(u16 pcifunc)
-{
-	return (pcifunc >> RVU_PFVF_PF_SHIFT) & RVU_PFVF_PF_MASK;
-}
-
 static inline dma_addr_t otx2_dma_map_page(struct otx2_nic *pfvf,
 					   struct page *page,
 					   size_t offset, size_t size,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
index e3aee6e36215..858f084b9d47 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_reg.h
@@ -138,36 +138,6 @@
 #define	NIX_LF_CINTX_ENA_W1S(a)		(NIX_LFBASE | 0xD40 | (a) << 12)
 #define	NIX_LF_CINTX_ENA_W1C(a)		(NIX_LFBASE | 0xD50 | (a) << 12)
 
-/* NIX AF transmit scheduler registers */
-#define NIX_AF_SMQX_CFG(a)		(0x700 | (u64)(a) << 16)
-#define NIX_AF_TL4X_SDP_LINK_CFG(a)	(0xB10 | (u64)(a) << 16)
-#define NIX_AF_TL1X_SCHEDULE(a)		(0xC00 | (u64)(a) << 16)
-#define NIX_AF_TL1X_CIR(a)		(0xC20 | (u64)(a) << 16)
-#define NIX_AF_TL1X_TOPOLOGY(a)		(0xC80 | (u64)(a) << 16)
-#define NIX_AF_TL2X_PARENT(a)		(0xE88 | (u64)(a) << 16)
-#define NIX_AF_TL2X_SCHEDULE(a)		(0xE00 | (u64)(a) << 16)
-#define NIX_AF_TL2X_TOPOLOGY(a)		(0xE80 | (u64)(a) << 16)
-#define NIX_AF_TL2X_CIR(a)		(0xE20 | (u64)(a) << 16)
-#define NIX_AF_TL2X_PIR(a)		(0xE30 | (u64)(a) << 16)
-#define NIX_AF_TL3X_PARENT(a)		(0x1088 | (u64)(a) << 16)
-#define NIX_AF_TL3X_SCHEDULE(a)		(0x1000 | (u64)(a) << 16)
-#define NIX_AF_TL3X_SHAPE(a)		(0x1010 | (u64)(a) << 16)
-#define NIX_AF_TL3X_CIR(a)		(0x1020 | (u64)(a) << 16)
-#define NIX_AF_TL3X_PIR(a)		(0x1030 | (u64)(a) << 16)
-#define NIX_AF_TL3X_TOPOLOGY(a)		(0x1080 | (u64)(a) << 16)
-#define NIX_AF_TL4X_PARENT(a)		(0x1288 | (u64)(a) << 16)
-#define NIX_AF_TL4X_SCHEDULE(a)		(0x1200 | (u64)(a) << 16)
-#define NIX_AF_TL4X_SHAPE(a)		(0x1210 | (u64)(a) << 16)
-#define NIX_AF_TL4X_CIR(a)		(0x1220 | (u64)(a) << 16)
-#define NIX_AF_TL4X_PIR(a)		(0x1230 | (u64)(a) << 16)
-#define NIX_AF_TL4X_TOPOLOGY(a)		(0x1280 | (u64)(a) << 16)
-#define NIX_AF_MDQX_SCHEDULE(a)		(0x1400 | (u64)(a) << 16)
-#define NIX_AF_MDQX_SHAPE(a)		(0x1410 | (u64)(a) << 16)
-#define NIX_AF_MDQX_CIR(a)		(0x1420 | (u64)(a) << 16)
-#define NIX_AF_MDQX_PIR(a)		(0x1430 | (u64)(a) << 16)
-#define NIX_AF_MDQX_PARENT(a)		(0x1480 | (u64)(a) << 16)
-#define NIX_AF_TL3_TL2X_LINKX_CFG(a, b)	(0x1700 | (u64)(a) << 16 | (b) << 3)
-
 /* LMT LF registers */
 #define LMT_LFBASE			BIT_ULL(RVU_FUNC_BLKADDR_SHIFT)
 #define LMT_LF_LMTLINEX(a)		(LMT_LFBASE | 0x000 | (a) << 12)
-- 
2.25.1


