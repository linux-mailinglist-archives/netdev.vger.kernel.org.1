Return-Path: <netdev+bounces-137136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5029A4806
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 22:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACE21C20B5D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 20:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99782208971;
	Fri, 18 Oct 2024 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KMbPMQeI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A120CCC5;
	Fri, 18 Oct 2024 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283484; cv=none; b=JqqtTjzPjU641jJEH7W2Rxo8aFKcP+TTnP4W1oXM7d9onMMs2sZzxOyOeuOXdAirCkU6/D8lVOmDiWU65ZTKCHpTM9cXTGvjElVun+1zply7uWg56stqpuKGBmW4dX4+y2Yhi0+n+EWmXp3lQt3s2QwWTcK7dfRyo8JnjR/CYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283484; c=relaxed/simple;
	bh=mdIVbytr6kIPewBcxaPOdfr9sudbKXGVgi+cW+YMGdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3A5iumLQUAE4kLpfhJ9giOaLjoqVNrCIURdWepN4yMxq9M3WKD5tAKEbeaq56nQl3AidwYtrluKrGsVH9WJoX2ypf5TrZ17/XcIJGArL86bTRDz7z++5fMcyRvXwHWNyF4M/czHPvVWuF4e0VO0G9McZe9xzM/D+SYcvXwjXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KMbPMQeI; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9R4H4008597;
	Fri, 18 Oct 2024 13:31:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
	xLZHCUdxSqURxF5tvaDu+NjdpoGZbV5gLB59XKQies=; b=KMbPMQeIOfBjfKYf5
	uFVF6KydtgHlZDlfxO4FgnzcFNJFjNk8+NMJ1ton5c8FqdWgHkBo1br42PN4ad69
	m7xBK0CD64JOB3dW1XzKcnzMjg3t4f+jQy2uu7kqyqpoBemQrWUyuxbi50f0/v3O
	PO2/bIPLjqrZVVP6ccziy6PeVuRfpY9O6hEaUNltVceJaLi46Hlj3jxFNnU+CqDi
	9R8cuzF1GCpgmYpGDS/g0HM+7tNNOcvst0j6A3Dy9l4ktF9xJAfU0XtIzer5KEq1
	SifHCbsXYSQnGscCLhENRFHEFUIbBoxNuLi0SI1Z0JRASs4UN8ooZrbKhAAvA8z0
	Vid5w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42bm18hjpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 13:31:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 18 Oct 2024 13:31:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 18 Oct 2024 13:31:09 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 5BF5E3F704C;
	Fri, 18 Oct 2024 13:31:05 -0700 (PDT)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH 1/6] octeontx2: Set appropriate PF, VF masks and shifts based on silicon
Date: Sat, 19 Oct 2024 02:00:53 +0530
Message-ID: <20241018203058.3641959-2-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018203058.3641959-1-saikrishnag@marvell.com>
References: <20241018203058.3641959-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SdNfn5iEoqBL1IR2AnWIH8lfNNcS4BWs
X-Proofpoint-ORIG-GUID: SdNfn5iEoqBL1IR2AnWIH8lfNNcS4BWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

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
index 6ea2f3071fe8..38a0badcdb68 100644
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
index 1a97fb9032fa..dcfc27a60b43 100644
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
index 5016ba82e142..938a911cbf1c 100644
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
@@ -819,7 +819,6 @@ int rvu_alloc_rsrc_contig(struct rsrc_bmap *rsrc, int nrsrc);
 void rvu_free_rsrc_contig(struct rsrc_bmap *rsrc, int nrsrc, int start);
 bool rvu_rsrc_check_contig(struct rsrc_bmap *rsrc, int nrsrc);
 u16 rvu_get_rsrc_mapcount(struct rvu_pfvf *pfvf, int blkaddr);
-int rvu_get_pf(u16 pcifunc);
 struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc);
 void rvu_get_pf_numvfs(struct rvu *rvu, int pf, int *numvfs, int *hwvf);
 bool is_block_implemented(struct rvu_hwinfo *hw, int blkaddr);
@@ -852,6 +851,11 @@ bool is_sdp_pfvf(u16 pcifunc);
 bool is_sdp_pf(u16 pcifunc);
 bool is_sdp_vf(struct rvu *rvu, u16 pcifunc);
 
+static inline int rvu_get_pf(u16 pcifunc)
+{
+	return (pcifunc >> RVU_PFVF_PF_SHIFT) & RVU_PFVF_PF_MASK;
+}
+
 /* CGX APIs */
 static inline bool is_pf_cgxmapped(struct rvu *rvu, u8 pf)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index f27a3456ae64..8e7ed3979f80 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -27,6 +27,7 @@
 #include "otx2_reg.h"
 #include "otx2_txrx.h"
 #include "otx2_devlink.h"
+#include <rvu.h>
 #include <rvu_trace.h>
 #include "qos.h"
 
@@ -873,21 +874,11 @@ MBOX_UP_MCS_MESSAGES
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


