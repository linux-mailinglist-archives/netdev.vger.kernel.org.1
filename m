Return-Path: <netdev+bounces-193860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C3FAC611B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F2C1BC28B3
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 05:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5371DF26E;
	Wed, 28 May 2025 05:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MCzifsri"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E47382
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748409347; cv=none; b=I0wY8G8F9IenoH1rq6EACPi0zj6n1d1DCgvQfuyt0iL99EmBV0OBwvsPNtAgb5hBHnh21x57Cg60VOrAz4Ux00RiSsD1boDH51RoA4e553Z+DEoMk5oRIgsM2sPm9fCSjyWL38Iz3Bf9rnuSZ2umZyWFtMlM/1W4VieifTl6TTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748409347; c=relaxed/simple;
	bh=n8F9SNznn8uKcP4Hfgc77XgkszbpA9NZQ7cQSBT0ZR0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hXxSAvA9ovC8+KCbs1w4/LydHvbIE6X++ZoH45RUb5mAZrY6U7KSJxwLBBa0QvO6bIbgYrILXM7TXSPV9WzcGcSiyAz+fz1gjIGVHj4GGQxxKf+dppffTsUAJn+IkOIcNdDlnFBwhH2HQCQmLFNmQqiNf0iWJ0JhvRwvJXxWIFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MCzifsri; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S4wmRP002425;
	Tue, 27 May 2025 22:15:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=FyAEp/NmtX1W3qq+z6Szv7Il1goIly8Avi4ckAThKqM=; b=MCz
	ifsriy4yUUBLvwvzdwMzYLIZJ26muKn1vrhCjpXhYy/S4AFcexbG4n3lOvo+ulZI
	Yc5QHIohxLU96LAPIBa8W9ynlpxtGHq+IhBL8QoY111MIyBea6BLCpd0nYVxA4Dl
	hE9r0YN8mb6SjjDkt7tZ6MyGPm+puhGz3SgLENkWhTfHatbGuYciuj75AYl0Z3lk
	dlniHrkbt+v1IaYyoOpkjfTKN5M152xn1qPWn5fksdQHVbt0OQGQuHYd9CAG7iSK
	0xMfPsJftGHs8vs5vPmPxZ2qgzaaJkf6JXH/jNCi2V3gOY98dT3+XukDtEh7PUy0
	XL8guh9SCE3AhZJ85Hg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46wux8g0y7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 22:15:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 22:15:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 22:15:34 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id AA09F3F704B;
	Tue, 27 May 2025 22:15:29 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
        <saikrishnag@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>, <jerinj@marvell.com>
CC: <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net PATCH] octeontx2: Annotate mmio regions as __iomem
Date: Wed, 28 May 2025 10:45:27 +0530
Message-ID: <1748409327-25648-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA0NSBTYWx0ZWRfX+zwW2COrFXIG 7g7IuYYSgE/YieJoCPWtHc7obbqKtKIRb5iUnjL6y+ok0xllqkxLPZIuxOdfAr9jYMigFLq2Mto YOledgfDco1+059IFK+YNQF0m2Gx5oJnmY16pGjopqvb5Sdt4BpJubTrTEmtu+qANBYKVbUj4k6
 /cVgul6g/H1utz53SjZJr2M2n8drKNyGYiWxILGasNWCpZZbKYgal9hLMgxIFmTY31a3GV/BedC D5r66AoSRAEW5djHuF+JpaKfrUbpX9GSrsFFmbBxn9QpHs/nE4VIVV4BMFyVRwSO6K6rUeNgalO azbPXGK1tbfuFrsxrQBKOp+vxuShWg/FUSB58moErAt5u2b7lbZri2CKB2rbn7qmyBQZrVsIQ2P
 ap8QVVbBrI3ugE7sZejdGyu19vh9uYbrmT9+ZbU9oZeNLHE1TnNnA+6ejKicq4y0WXs7pk6/
X-Authority-Analysis: v=2.4 cv=CcII5Krl c=1 sm=1 tr=0 ts=68369bf8 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=pCkVVIg8AwnW8QNEWxUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: DHskEMQBAkCeNFwzLp5_sr2fmclrZ3gH
X-Proofpoint-GUID: DHskEMQBAkCeNFwzLp5_sr2fmclrZ3gH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_02,2025-05-27_01,2025-03-28_01

This patch removes unnecessary typecasts by marking the
mbox_regions array as __iomem since it is used to store
pointers to memory-mapped I/O (MMIO) regions. Also simplified
the call to readq() in PF driver by removing redundant type casts.

Fixes: 98c561116360 ("octeontx2-af: cn10k: Add mbox support for CN10K platform")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c      | 12 ++++++------
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c |  3 +--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 6575c42..5e0cc3a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2359,7 +2359,7 @@ static inline void rvu_afvf_mbox_up_handler(struct work_struct *work)
 	__rvu_mbox_up_handler(mwork, TYPE_AFVF);
 }
 
-static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
+static int rvu_get_mbox_regions(struct rvu *rvu, void __iomem **mbox_addr,
 				int num, int type, unsigned long *pf_bmap)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
@@ -2384,7 +2384,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 				bar4 = rvupf_read64(rvu, RVU_PF_VF_BAR4_ADDR);
 				bar4 += region * MBOX_SIZE;
 			}
-			mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+			mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
 			if (!mbox_addr[region])
 				goto error;
 		}
@@ -2407,7 +2407,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 					  RVU_AF_PF_BAR4_ADDR);
 			bar4 += region * MBOX_SIZE;
 		}
-		mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+		mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
 		if (!mbox_addr[region])
 			goto error;
 	}
@@ -2415,7 +2415,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 
 error:
 	while (region--)
-		iounmap((void __iomem *)mbox_addr[region]);
+		iounmap(mbox_addr[region]);
 	return -ENOMEM;
 }
 
@@ -2425,10 +2425,10 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
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
 
@@ -2451,7 +2451,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 
 	mutex_init(&rvu->mbox_lock);
 
-	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
+	mbox_regions = kcalloc(num, sizeof(void __iomem *), GFP_KERNEL);
 	if (!mbox_regions) {
 		err = -ENOMEM;
 		goto free_bitmap;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index b303a03..cd818d2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -596,8 +596,7 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
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


