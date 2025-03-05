Return-Path: <netdev+bounces-171963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEA3A4FA90
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 10:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F42D3A95CF
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EA4202F99;
	Wed,  5 Mar 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jAP8dNVQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC77F1F3D30;
	Wed,  5 Mar 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168007; cv=none; b=DublnFlQfRieOtmwmupFQ9TlU5C+ucUVdfoml62B+d9H1s1ESsW5regxuIoDkFVYxJJ3pyl8oo54wWr+lCWITZh4Wj2JqMXHR/MeSs2/YJlz+MDW+TDpplF89mx3W9KRLNQLNBt4cT+VmbeWaruFZuNsF3wuLMPk+fJypgi6L58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168007; c=relaxed/simple;
	bh=FXfioV8CaRb4Kj7KM42BiGBBy9+db0YNett6CYn56Fs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ezNCdvOBBXyJ8PygjoFhMvTuStiyge3r0brHIIXB5D3UkrrudnWlOK7quYRYMPMbEYcfsfYIgGP1r0mq/EruRAvqQkbgHY6eJ+GZeVf1yvfj6/B13fA1haxgIUebCr4kCcg8CJ8vAbifyezHvxpBk6XyqHnsWvlVJhryVomMU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jAP8dNVQ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5253vexe028541;
	Wed, 5 Mar 2025 01:46:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=4XnuYIJ9q/vf3IyjBHXgo0K
	gvgu4V7P4DYMXtFG23GI=; b=jAP8dNVQ8OE4R4LGlU1l9pue0RxBYMfNf1Svwu7
	hCLb8aGBJDI+K7DHSqo/xqCFxNHMNDwSlvRvGcUG9NmJub0//rBb5fR+8B15PoRZ
	YvL3Q0+wwuKoU5+ZpDvceVMbWz8gZreV0L0Wz5xQQKWhffCI4htOhJrCK01YGUYX
	A/QxtyIkRdMDx1FwKn9qGTjXHnQkHJcbF1JCJHjJicilwhIFeLSrNxLW18fj0SR2
	pRfyIMFMLAA1ua+VpZtvRhzQrRX5EoDxEEWRevz28zE54qH453RePHaRel8X5y/4
	F83uhdNopvLNvnIo/tVIoaE5366QwrTp7ohfoE3lEJUXbzg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 456f5tgk7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 01:46:32 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 5 Mar 2025 01:46:31 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 5 Mar 2025 01:46:31 -0800
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 2414B3F705C;
	Wed,  5 Mar 2025 01:46:24 -0800 (PST)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <morbo@google.com>,
        <justinstitt@google.com>, <llvm@lists.linux.dev>
CC: Sai Krishna <saikrishnag@marvell.com>, kernel test robot <lkp@intel.com>
Subject: [net-next PATCH v2] octeontx2-af: fix build warnings flagged by clang, sparse ,kernel test robot
Date: Wed, 5 Mar 2025 15:16:23 +0530
Message-ID: <20250305094623.2819994-1-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6jqXsFNlzlCDwlEM9sofaMbTmMtiDIKX
X-Authority-Analysis: v=2.4 cv=JtULrN4C c=1 sm=1 tr=0 ts=67c81d78 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=mOT8R8ziQExDnPD9evEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 6jqXsFNlzlCDwlEM9sofaMbTmMtiDIKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_03,2025-03-05_01,2024-11-22_01

This cleanup patch avoids build warnings flagged by clang,
sparse, kernel test robot.

Warning reported by clang:
drivers/net/ethernet/marvell/octeontx2/af/rvu.c:2993:47:
warning: arithmetic between different enumeration types
('enum rvu_af_int_vec_e' and 'enum rvu_pf_int_vec_e')
[-Wenum-enum-conversion]
 2993 | return (pfvf->msix.max >= RVU_AF_INT_VEC_CNT +
RVU_PF_INT_VEC_CNT) &&

Reported-by: kernel test robot <lkp@intel.com>
Closes:
https://lore.kernel.org/oe-kbuild-all/202410221614.07o9QVjo-lkp@intel.com/
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/common.h |  2 +-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    | 14 ++++++++------
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   | 10 +++++-----
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  9 ++++-----
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index 406c59100a35..8a08bebf08c2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -39,7 +39,7 @@ struct qmem {
 	void            *base;
 	dma_addr_t	iova;
 	int		alloc_sz;
-	u16		entry_sz;
+	u32		entry_sz;
 	u8		align;
 	u32		qsize;
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index cd0d7b7774f1..c850ea5d1960 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -591,7 +591,7 @@ static void rvu_check_min_msix_vec(struct rvu *rvu, int nvecs, int pf, int vf)
 
 check_pf:
 	if (pf == 0)
-		min_vecs = RVU_AF_INT_VEC_CNT + RVU_PF_INT_VEC_CNT;
+		min_vecs = (int)RVU_AF_INT_VEC_CNT + (int)RVU_PF_INT_VEC_CNT;
 	else
 		min_vecs = RVU_PF_INT_VEC_CNT;
 
@@ -819,13 +819,14 @@ static int rvu_fwdata_init(struct rvu *rvu)
 		goto fail;
 
 	BUILD_BUG_ON(offsetof(struct rvu_fwdata, cgx_fw_data) > FWDATA_CGX_LMAC_OFFSET);
-	rvu->fwdata = ioremap_wc(fwdbase, sizeof(struct rvu_fwdata));
+	rvu->fwdata = (__force struct rvu_fwdata *)
+		ioremap_wc(fwdbase, sizeof(struct rvu_fwdata));
 	if (!rvu->fwdata)
 		goto fail;
 	if (!is_rvu_fwdata_valid(rvu)) {
 		dev_err(rvu->dev,
 			"Mismatch in 'fwdata' struct btw kernel and firmware\n");
-		iounmap(rvu->fwdata);
+		iounmap((void __iomem *)rvu->fwdata);
 		rvu->fwdata = NULL;
 		return -EINVAL;
 	}
@@ -838,7 +839,7 @@ static int rvu_fwdata_init(struct rvu *rvu)
 static void rvu_fwdata_exit(struct rvu *rvu)
 {
 	if (rvu->fwdata)
-		iounmap(rvu->fwdata);
+		iounmap((void __iomem *)rvu->fwdata);
 }
 
 static int rvu_setup_nix_hw_resource(struct rvu *rvu, int blkaddr)
@@ -2384,7 +2385,8 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 				bar4 = rvupf_read64(rvu, RVU_PF_VF_BAR4_ADDR);
 				bar4 += region * MBOX_SIZE;
 			}
-			mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+			mbox_addr[region] = (__force void *)
+				ioremap_wc(bar4, MBOX_SIZE);
 			if (!mbox_addr[region])
 				goto error;
 		}
@@ -2407,7 +2409,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 					  RVU_AF_PF_BAR4_ADDR);
 			bar4 += region * MBOX_SIZE;
 		}
-		mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+		mbox_addr[region] = (__force void *)ioremap_wc(bar4, MBOX_SIZE);
 		if (!mbox_addr[region])
 			goto error;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 2b49bfec7869..e0e592fd02f7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -29,10 +29,10 @@ static void otx2_nix_rq_op_stats(struct queue_stats *stats,
 	u64 incr = (u64)qidx << 32;
 	u64 *ptr;
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_RQ_OP_OCTS);
+	ptr = (__force u64 *)otx2_get_regaddr(pfvf, NIX_LF_RQ_OP_OCTS);
 	stats->bytes = otx2_atomic64_add(incr, ptr);
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_RQ_OP_PKTS);
+	ptr = (__force u64 *)otx2_get_regaddr(pfvf, NIX_LF_RQ_OP_PKTS);
 	stats->pkts = otx2_atomic64_add(incr, ptr);
 }
 
@@ -42,10 +42,10 @@ static void otx2_nix_sq_op_stats(struct queue_stats *stats,
 	u64 incr = (u64)qidx << 32;
 	u64 *ptr;
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_OCTS);
+	ptr = (__force u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_OCTS);
 	stats->bytes = otx2_atomic64_add(incr, ptr);
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_PKTS);
+	ptr = (__force u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_PKTS);
 	stats->pkts = otx2_atomic64_add(incr, ptr);
 }
 
@@ -853,7 +853,7 @@ void otx2_sqb_flush(struct otx2_nic *pfvf)
 	struct otx2_snd_queue *sq;
 	u64 incr, *ptr, val;
 
-	ptr = (u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_STATUS);
+	ptr = (__force u64 *)otx2_get_regaddr(pfvf, NIX_LF_SQ_OP_STATUS);
 	for (qidx = 0; qidx < otx2_get_total_tx_queues(pfvf); qidx++) {
 		sq = &pfvf->qset.sq[qidx];
 		if (!sq->sqb_ptrs)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index e1dde93e8af8..6c23d64e81f8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -595,8 +595,7 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 		base = pci_resource_start(pf->pdev, PCI_MBOX_BAR_NUM) +
 		       MBOX_SIZE;
 	else
-		base = readq((void __iomem *)((u64)pf->reg_base +
-					      RVU_PF_VF_BAR4_ADDR));
+		base = readq(pf->reg_base + RVU_PF_VF_BAR4_ADDR);
 
 	hwbase = ioremap_wc(base, MBOX_SIZE * pf->total_vfs);
 	if (!hwbase) {
@@ -645,7 +644,7 @@ static void otx2_pfvf_mbox_destroy(struct otx2_nic *pf)
 	}
 
 	if (mbox->mbox.hwbase)
-		iounmap(mbox->mbox.hwbase);
+		iounmap((void __iomem *)mbox->mbox.hwbase);
 
 	otx2_mbox_destroy(&mbox->mbox);
 }
@@ -1309,7 +1308,7 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 
 	/* CQ */
 	for (qidx = 0; qidx < pf->qset.cq_cnt; qidx++) {
-		ptr = otx2_get_regaddr(pf, NIX_LF_CQ_OP_INT);
+		ptr = (__force u64 *)otx2_get_regaddr(pf, NIX_LF_CQ_OP_INT);
 		val = otx2_atomic64_add((qidx << 44), ptr);
 
 		otx2_write64(pf, NIX_LF_CQ_OP_INT, (qidx << 44) |
@@ -1348,7 +1347,7 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 		 * these are fatal errors.
 		 */
 
-		ptr = otx2_get_regaddr(pf, NIX_LF_SQ_OP_INT);
+		ptr = (__force u64 *)otx2_get_regaddr(pf, NIX_LF_SQ_OP_INT);
 		val = otx2_atomic64_add((qidx << 44), ptr);
 		otx2_write64(pf, NIX_LF_SQ_OP_INT, (qidx << 44) |
 			     (val & NIX_SQINT_BITS));
-- 
2.25.1


