Return-Path: <netdev+bounces-195771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1A1AD22FD
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FC41886FAF
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863520CCCA;
	Mon,  9 Jun 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VIa4WrcS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26163398B
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484342; cv=none; b=HTRGoXl4/XNUR9iSv9U4yDstCkYUghXYnzK7HeKCqchGvE1oEo254ENr4+2aAoJS2ukICqTVTss4ydZDrQvDj/x/rDCG3W+GCU+a0mGJK+0WSJ1rjCsgOHNnUTu7SrZ2G3tGsjpkO1z2HDJdlezy7Xf6MEz2KUNIVEUyJQL2yDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484342; c=relaxed/simple;
	bh=BSLdyxIsQ0xPel/VCm+GYlhzhJxRNONqXsYLib2yb8A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q9+wW/4iTTjeX7grdt1xA/GGuvbKGFozYL6oi+fQ1lL1ntLJT0npPiMAn9k3HScDX1Fln/Ql+t+V4WF864U1zIKDeQ7MX30Fs/bexOCrpuvIvIRkINbDjqLujRLuyzUP6qNtf4tA0EvovLL20uzZbSpojoupzx1f982u8L7sEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VIa4WrcS; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559DtYnr022492;
	Mon, 9 Jun 2025 08:52:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=8efMkTBIH8E6HBAki7mCyf7SfYu9z++iJiYfZmHbr/U=; b=VIa
	4WrcSU+Clgvo0Fx67YhJ/eAZV0uM4TvgmU2MSp3GkpmccagiVMtVU1ykTU2DQ9cT
	kxD87v7krldop5JHfk62tVzcLqW/JZQcS1ZAp53q4tAPWp3wBlqbFua9HIl35woe
	xRCBkZG/S+5Z55iHH9SW5IB0BxKp7CNlCgA/QuIq2uyhABzh7nLXvl9hZc96ZKGU
	g2qO78uqc90foj1uvuyNDMcPBlevC9Dn+TA5VAKnpe1/0m7Tfj8RZr79HIglnNrP
	5UE4AeFy/CsIhYxeVvGCzl2H63k8DFJM9lhiuphfdHzZ9nsAlzC/3TpfazQUQSpo
	OCkBkxbsvJ+sP2hKBSA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4760x2g8ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 08:52:11 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 08:52:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 08:52:11 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id DAA623F7075;
	Mon,  9 Jun 2025 08:52:06 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <bbhushan2@marvell.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH] octeontx2: Annotate mmio regions as __iomem
Date: Mon, 9 Jun 2025 21:21:49 +0530
Message-ID: <1749484309-3434-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: ztxZrNKGgovLyylFd451RUsd5JbDhLIo
X-Authority-Analysis: v=2.4 cv=dd2A3WXe c=1 sm=1 tr=0 ts=6847032c cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=pCkVVIg8AwnW8QNEWxUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ztxZrNKGgovLyylFd451RUsd5JbDhLIo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDExNyBTYWx0ZWRfX9RO97/kdLERP XRv+xUButnkFJZCIim8VKRiLULJcyZ6doeIkQ5nZkCmVXytWhjPGh8VSKCW4gq776bVwdmmPlgT XkbUDuFvG4XxA93pMZpGHOqqiDW1IHhdBPZIarcGRQlCGkUbKnCKOdZGaHaYyItfi36gLvaMSUI
 F4lgMxaH3KTTvIdivHYyyurw7lZKL9Knhkxx0sbnwAZiwSbLbjyMwBCYAKEUkgvSz6A7BRQOPcy t77hvkb8a8COWkPUmh/L2Bc8302HwhaZ39MI9+n3r/oge4o8idTcGd47qQlmzhl8rzqI074v4Vh 4CM38iSxHidG9xODTux3Yozl1JbEOtVkb6n9fAAMXqVDWhjngoid6m7r/RYXDAZz/Ibv9YklAZl
 WLE4atSPzYnfSILhBAlyuz7OV4zRAo7smwGOB5alUvXCVc23GBZR8YDjW3DhTCfb2Y9YmnTY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01

This patch removes unnecessary typecasts by marking the
mbox_regions array as __iomem since it is used to store
pointers to memory-mapped I/O (MMIO) regions. Also simplified
the call to readq() in PF driver by removing redundant type casts.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c      | 12 ++++++------
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c |  3 +--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index a8025f0..43eea74 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2364,7 +2364,7 @@ static inline void rvu_afvf_mbox_up_handler(struct work_struct *work)
 	__rvu_mbox_up_handler(mwork, TYPE_AFVF);
 }
 
-static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
+static int rvu_get_mbox_regions(struct rvu *rvu, void __iomem **mbox_addr,
 				int num, int type, unsigned long *pf_bmap)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
@@ -2389,7 +2389,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 				bar4 = rvupf_read64(rvu, RVU_PF_VF_BAR4_ADDR);
 				bar4 += region * MBOX_SIZE;
 			}
-			mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+			mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
 			if (!mbox_addr[region])
 				goto error;
 		}
@@ -2412,7 +2412,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 					  RVU_AF_PF_BAR4_ADDR);
 			bar4 += region * MBOX_SIZE;
 		}
-		mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+		mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
 		if (!mbox_addr[region])
 			goto error;
 	}
@@ -2420,7 +2420,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 
 error:
 	while (region--)
-		iounmap((void __iomem *)mbox_addr[region]);
+		iounmap(mbox_addr[region]);
 	return -ENOMEM;
 }
 
@@ -2430,10 +2430,10 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 			 void (mbox_up_handler)(struct work_struct *))
 {
 	int err = -EINVAL, i, dir, dir_up;
+	void __iomem **mbox_regions;
 	void __iomem *reg_base;
 	struct rvu_work *mwork;
 	unsigned long *pf_bmap;
-	void **mbox_regions;
 	const char *name;
 	u64 cfg;
 
@@ -2456,7 +2456,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 
 	mutex_init(&rvu->mbox_lock);
 
-	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
+	mbox_regions = kcalloc(num, sizeof(void __iomem *), GFP_KERNEL);
 	if (!mbox_regions) {
 		err = -ENOMEM;
 		goto free_bitmap;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 2c2a4af..07da4d6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -602,8 +602,7 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 		base = pci_resource_start(pf->pdev, PCI_MBOX_BAR_NUM) +
 		       MBOX_SIZE;
 	else
-		base = readq((void __iomem *)((u64)pf->reg_base +
-					      RVU_PF_VF_BAR4_ADDR));
+		base = readq(pf->reg_base + RVU_PF_VF_BAR4_ADDR);
 
 	hwbase = ioremap_wc(base, MBOX_SIZE * pf->total_vfs);
 	if (!hwbase) {
-- 
2.7.4


