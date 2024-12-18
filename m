Return-Path: <netdev+bounces-153012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF49F6941
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A708188DECD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FC51F238D;
	Wed, 18 Dec 2024 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="drC4rRF2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF91DE3DE;
	Wed, 18 Dec 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534009; cv=none; b=r/J7vM4bxz9xegvLjESBFExM0+qprDMR2cg+NZGGPRSpGzr/FyPtwLdwDoo/hMhkogvfBaaxpClsxt5g6IeT/muU3BnPL175icFbK4MsIYxbsckOxHv2HQfikxff4H5es55AGlsrWEulNjVUxsLDf891tSQT72Sv9N6fCuGlJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534009; c=relaxed/simple;
	bh=PNfoaQf/rHBRTjcyqNwK5ye0Y6vyr9zQQZg/VZj9Igw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J24qppjLJHpTka1wLd3GjwL5evmEXfIff19yijtpCZdvTvxHrU0q+Y5YrkTWAFSYdHgHo1yM/L3X1aKgZXzT76CCLFTR0RSIzAPWsqu3WbOiqWW+uTgt+3T14w25z986D8vNNeGckLi1i6+XIK9qSI7mdshD4/I2CnRbPNPzwnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=drC4rRF2; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIECPo2018326;
	Wed, 18 Dec 2024 06:59:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
	t31Y4JY+QHIJV0XSfAzotaKt8906DnUKnQXiH10JQY=; b=drC4rRF2L59h+cFw/
	A64AtAJgxKfxtgJ+cE751GCD4ZiV8SuT0Q4w67BcDhkPlP8yYeRY5MmblUnykGXn
	WeQ0qTha2LE9Z0/1iK2pFobA6j3YcnSWI49zEPpj2anRDcksy7a8PzjAhm+Hpaa3
	Oen9W5fz7KvzIB/9wwR6b84/VMkW6HVlllG/YrLvbUJTOKa8q2QqxDWZ2Pk38Mdp
	Rwguphgb41T63dYPPo9aw6VCreidGMvhbsn7SfOM+Yw2xvudLol/bkR3XUgZdwFb
	u77Jn7CU9zRxnFLUdM15gu5BxUdYKFItRL1CTDkuZZsP249X7DLiG5NYbVTFKmXh
	+1GHA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43kyxk836u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 06:59:57 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 06:59:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Dec 2024 06:59:55 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 0B8823F7053;
	Wed, 18 Dec 2024 06:59:50 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <kalesh-anakkur.purayil@broadcom.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v6 1/6] octeontx2: Set appropriate PF, VF masks and shifts based on silicon
Date: Wed, 18 Dec 2024 20:29:33 +0530
Message-ID: <20241218145938.3301279-2-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241218145938.3301279-1-saikrishnag@marvell.com>
References: <20241218145938.3301279-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: T6ZVTJ3AG4SAwVq9q8zUVjkohzCL2z7x
X-Proofpoint-ORIG-GUID: T6ZVTJ3AG4SAwVq9q8zUVjkohzCL2z7x
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
 .../marvell/octeontx2/nic/cn10k_ipsec.c       |  2 +-
 .../marvell/octeontx2/nic/cn10k_ipsec.h       |  2 +-
 .../marvell/octeontx2/nic/otx2_common.h       | 11 +------
 .../ethernet/marvell/octeontx2/nic/otx2_reg.h | 30 -------------------
 8 files changed, 32 insertions(+), 52 deletions(-)

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
index 005ca8a056c0..7d7fe0b70348 100644
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 09a5b5268205..60864c107c4c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -481,7 +481,7 @@ static int cn10k_outb_write_sa(struct otx2_nic *pf, struct qmem *sa_info)
 		goto set_available;
 
 	/* Trigger CTX flush to write dirty data back to DRAM */
-	reg_val = FIELD_PREP(CPT_LF_CTX_FLUSH, sa_iova >> 7);
+	reg_val = FIELD_PREP(CPT_LF_CTX_FLUSH_CPTR, sa_iova >> 7);
 	otx2_write64(pf, CN10K_CPT_LF_CTX_FLUSH, reg_val);
 
 set_available:
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
index 9965df0faa3e..43fbce0d6039 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
@@ -220,7 +220,7 @@ struct cpt_sg_s {
 #define CPT_LF_Q_SIZE_DIV40 GENMASK_ULL(14, 0)
 
 /* CPT LF CTX Flush Register */
-#define CPT_LF_CTX_FLUSH GENMASK_ULL(45, 0)
+#define CPT_LF_CTX_FLUSH_CPTR GENMASK_ULL(45, 0)
 
 #ifdef CONFIG_XFRM_OFFLOAD
 int cn10k_ipsec_init(struct net_device *netdev);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 65814e3dc93f..d44a6cc3e863 100644
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
@@ -890,21 +891,11 @@ MBOX_UP_MCS_MESSAGES
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


