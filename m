Return-Path: <netdev+bounces-173993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1D4A5CDE1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 19:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1B27AB8B3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283EA263F24;
	Tue, 11 Mar 2025 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Jofegoxr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97532263C6B;
	Tue, 11 Mar 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717629; cv=none; b=ax8s7aH00fWpztW4MpWSa9aqkSaw2nruPOTrEx+KGLWNKQEN/B+w/D8bBFXDuJMKIA+r1VwWy1plNGwKVM7ICeWxRb1yrIbxSYivAOwsMfIq3xM4qdpQj6QEF9Qv1yvPoimXWy7nBvv1rGM0mojpym5Od6AkILA4XhOU+iaOKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717629; c=relaxed/simple;
	bh=gRS9jKtKUzfHkoSdI6Gem96zAZ50zZcSJT5d8SgUYWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tEj+c3K4NhKyQeI6Pqnz+TmsGPnoF+qAiKRCt0SsT3KOus7t6CdTJTZD+GR44RDgV0GzCAwHQRYTg3TNke0RbmL1NJkCwMjReifglW2Ki1OvDdlvCQ6A1ZEU8L2K3F91b8K9UL6uCK7pt7kkRXyp4P0Olv8dKfaK22gWluSWGks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Jofegoxr; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BB5mva008060;
	Tue, 11 Mar 2025 11:26:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
	ZliaUORo2mS+3tGSox9M93MAPhOgwb28gKvGOyD+WI=; b=JofegoxrbcyEfkTyT
	gTVLh0uWIM7BytI0wwr/H3DK+U8ApG5uSUJ6sExAlqDjeeDrxc4S9wwJBFNj5NMM
	imleVpvIF/AKgHV+d7OLyPMXiNf+f4i+p98G6W6GgavuWbQftnf27bkEmOe2FxlD
	m4ZWPZCuyzlL44O9gUm7KnOILhoJ6s6j8qbsf7V/FfKJyZACoV6J/Ty8+TU5YtBo
	Llon+sTmuWLHV0ICJHjtr5WuGkKLRHusW4e5h0awtcY6lp06SdhQ2M2yWSKIqWFS
	4tcFWBJ9jNGOctR5/Af+rsM1lsjwQ0BwlgjFLC5Us7Svc18gp9DLH9E4iEjhDAHp
	dJeZQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45akyv10g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 11:26:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 11 Mar 2025 11:26:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 11 Mar 2025 11:26:53 -0700
Received: from hyd1425.marvell.com (unknown [10.29.37.152])
	by maili.marvell.com (Postfix) with ESMTP id 86A9E3F705D;
	Tue, 11 Mar 2025 11:26:47 -0700 (PDT)
From: Sai Krishna <saikrishnag@marvell.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <lcherian@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <morbo@google.com>,
        <justinstitt@google.com>, <llvm@lists.linux.dev>, <horms@kernel.org>
CC: Sai Krishna <saikrishnag@marvell.com>
Subject: [net-next PATCH v3 2/2] octeontx2-af: fix compiler warnings flagged by Sparse
Date: Tue, 11 Mar 2025 23:56:31 +0530
Message-ID: <20250311182631.3224812-3-saikrishnag@marvell.com>
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
X-Proofpoint-GUID: Y1HYLJbtlNAy1R1iF17vu3t8d7Nq5JKs
X-Proofpoint-ORIG-GUID: Y1HYLJbtlNAy1R1iF17vu3t8d7Nq5JKs
X-Authority-Analysis: v=2.4 cv=Rsc/LDmK c=1 sm=1 tr=0 ts=67d0806e cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=R40iJ15ohJ1Iz6L5NAgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_05,2025-03-11_02,2024-11-22_01

Sparse flagged a number of warnings while typecasting iomem
type to required data type.

For example, fwdata is just a shared memory data structure used
between firmware and kernel, thus remapping and typecasting
to required data type may not cause issue.

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c      | 12 +++++++-----
 .../net/ethernet/marvell/octeontx2/nic/otx2_common.c | 10 +++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index cd0d7b7774f1..c3a346cff05e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
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
-- 
2.25.1


