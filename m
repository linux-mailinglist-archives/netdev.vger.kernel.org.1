Return-Path: <netdev+bounces-173991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881BBA5CDDE
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 19:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0791894B17
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D470A263884;
	Tue, 11 Mar 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IdazDzR4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE5139E;
	Tue, 11 Mar 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717626; cv=none; b=OZBR+DL8bmLNqu5tdjm3LFuSQF1vGsZ1YiZerZt2pPJWvYoaSipDvBW24pZD9woY4bEflWWpLtRRetEvkuFixCWpY68bivJjRKmQ39ELrqeF+tD62KFaYtZ8IMwWX+gYzosGqE15IWYvkNY/ruG9i/S8dFjFLiTJ2OSqCrEyWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717626; c=relaxed/simple;
	bh=gW3RsZ9UvWbf5PVnqyH3ghnFbvfLXK+Yfqo77auSd0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnOm1HSg1GLQUhyiwmwdwg7HUjrNMYysO+DmWlmemc264qJY2SNbflcUg+l0onGt5Ik37ucwH6Ev2KXjLk++434eAJR0p66E1AOIDSCVhRhWtq1umWaE9RBIYbYtJMr8yX1OhUIpLKuayinfRCPuvn9vGXRqv3WJaptDNFxa/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IdazDzR4; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCCXIR028213;
	Tue, 11 Mar 2025 11:26:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
	kFjxWblFRxuI86eJXAdgvRABauXBajH0yEoJlormyQ=; b=IdazDzR4Mcr2dV/eS
	vJxHNZIwgfXT5Z1jDnT2BDRkycs/2Nu97E48SkOlmoyShkCdX1/JMuKMmS1xMrXG
	CmTZabDMb4Ze/e9kp3+swFcCirYeskRKqXgVqNjGod4Odl6emL6C+1vH5CcXOvBO
	JCe0FMUxRVNq7GxQpBIpgXJ/7Z03ksCM5AiAxNLfoDOZXmR3wl+2AGImW7Mg/iHx
	ppQ2Y66rUpBFCjn0f0+YhqIl23zv3Z/wr7qzKpWz1ww+dkHR/gY4+z0mTiG+Tiu+
	lB/XHUq1LBjpIRnlnqSIfGYeLxeIMW6R5ybovy7XyWdvpdgImxeI6UlGHnk2fMXZ
	bK89w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45aj57s71g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 11:26:48 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 11 Mar 2025 11:26:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 11 Mar 2025 11:26:47 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id B5A173F705D;
	Tue, 11 Mar 2025 11:26:40 -0700 (PDT)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <morbo@google.com>,
        <justinstitt@google.com>, <llvm@lists.linux.dev>, <horms@kernel.org>
CC: Sai Krishna <saikrishnag@marvell.com>, kernel test robot <lkp@intel.com>
Subject: [net-next PATCH v3 1/2] octeontx2-af: correct __iomem annotations flagged by Sparse
Date: Tue, 11 Mar 2025 23:56:30 +0530
Message-ID: <20250311182631.3224812-2-saikrishnag@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250311182631.3224812-1-saikrishnag@marvell.com>
References: <20250311182631.3224812-1-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fGoGFXnJnvCEHBVhlcbMGI-asT5wCF-E
X-Proofpoint-ORIG-GUID: fGoGFXnJnvCEHBVhlcbMGI-asT5wCF-E
X-Authority-Analysis: v=2.4 cv=FdvNxI+6 c=1 sm=1 tr=0 ts=67d08068 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=qTKUyOGkk11r6XT-fiUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_05,2025-03-11_02,2024-11-22_01

Sparse flagged a number of inconsistent usage of __iomem annotations.
This patch fixes some of the issues reported by kernel test robot.
These warning messages are address this by proper __iomem
annotations.

Warning messages flagged by Sparse:

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:611:24: sparse:
sparse: incorrect type in assignment (different address spaces) @@
expected void [noderef] __iomem *hwbase @@     got void * @@
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:611:24:
  sparse:     expected void [noderef] __iomem *hwbase
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:611:24:
  sparse:     got void *
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:620:56:
  sparse: sparse: cast removes address space '__iomem' of expression
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:671:35:
  sparse: sparse: incorrect type in argument 1 (different address spaces)
  @@ expected void volatile [noderef] __iomem *addr @@ got void *hwbase @@
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:671:35:
  sparse:     expected void volatile [noderef] __iomem *addr
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:671:35:
  sparse:     got void *hwbase
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1344:21:
  sparse: sparse: incorrect type in assignment (different address spaces)
  @@ expected unsigned long long [usertype] *ptr @@
  got void [noderef] __iomem * @@
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1344:21:
  sparse:     expected unsigned long long [usertype] *ptr
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1344:21:
  sparse:     got void [noderef] __iomem *
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1383:21:
  sparse: sparse: incorrect type in assignment (different address spaces)
  @@ expected unsigned long long [usertype] *ptr @@
  got void [noderef] __iomem * @@
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1383:21:
  sparse:     expected unsigned long long [usertype] *ptr
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1383:21:
  sparse:     got void [noderef] __iomem *
drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c: note:
  in included file
  (through drivers/net/ethernet/marvell/octeontx2/af/mbox.h,
  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h):

Flagged by Sparse on x86_64:
 drivers/net/ethernet/marvell/octeontx2/af/common.h:61:26: sparse:
 sparse: cast truncates bits from constant value (10000 becomes 0)

To address this increased the size of entry_sz in qmem_alloc(),
otherwise the value will be truncated to 0.

Reported-by: kernel test robot <lkp@intel.com>
Closes:
https://lore.kernel.org/oe-kbuild-all/202410221614.07o9QVjo-lkp@intel.com/
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/common.h   | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

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


