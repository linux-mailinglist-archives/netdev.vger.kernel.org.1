Return-Path: <netdev+bounces-206436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2E1B031C5
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 17:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0221896827
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 15:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EF827C145;
	Sun, 13 Jul 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ccth4yZX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6327A93A
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420717; cv=none; b=VICgK3fcoZSYo2cnjPuVuZnz04M7yAvKZEqu/KwNv0/pkiEv+5LhLSOSnj74b3A8XThi6kf1fw8V/YbVBV0qNK03JZN0o34j5tmdyPLQl2CRpaD7BGD+clzMFXKJMkJs7AbGWJ5VZYbJO8svv/Gf4TwXkoSqsNrhwSU7M0d2Y20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420717; c=relaxed/simple;
	bh=GEcS3ZO3puCljoaFKBG1LDBTw/mBxZ78+YM16GcAO8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQeBS9UeHTrlbiR3iXh5yzVbCbBuy6chZhywMtgezK6sVXUUnpUWUP38nHwlkjqODu9LYMpclW1mJf3AKHQ1NMJo4cwY6sY6Z7JKPjQd8HUR8RAAmE33qME2gz37ZyAxA0jfkCzjGn7B0o4rL3nyUked/kfy3HzfY93nBGZjlNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ccth4yZX; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DFUqOM028179;
	Sun, 13 Jul 2025 08:31:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=gOtsgZP4SVG+PgRESksfTK2Y1
	rNCquMLgfb1AiVYUDQ=; b=ccth4yZXU3bQiX1GKnOpSpeguKyrRFcD1f7IzHXOZ
	WSgcaKFY55KAWt76TkaaOsXIy9M5ZL9MFq0uuPShOCoDzqaXGW6PcM9a2vPJcJeP
	J+S41MXNXl8KmQLNY2dfWP3zR+nm5/rJFXr9SIh7ro1iE1BSJhxH7wDLyvb/rsZI
	GN8sfIck+7Cc5ejix6DWvpkjCfhWYcPQ4hFaFAcBDFgoZscSI962T6JEL7XrIjKy
	K8VsRREdXMX/y4aqs3etS0NVIQDdeWe/Eg+J8hTTAsUuUitnnZhBiPAuwDsI4YFM
	53jZJlZffR9i9tG5Ji+ZD630CPKuWprOuE7IdinNk/wGg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47v1farvj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 08:31:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 13 Jul 2025 08:31:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 13 Jul 2025 08:31:47 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 131795B6941;
	Sun, 13 Jul 2025 08:31:42 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 06/11] octeontx2-af: Skip NDC operations for cn20k
Date: Sun, 13 Jul 2025 21:01:04 +0530
Message-ID: <1752420669-2908-7-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1752420669-2908-1-git-send-email-sbhatta@marvell.com>
References: <1752420669-2908-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=N48pF39B c=1 sm=1 tr=0 ts=6873d164 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=GFmy-jf8mh29BVtaGncA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: YqU8Jq5-7wGNLsrvVMmk2AdfxkEAJ7b1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDEwOCBTYWx0ZWRfXzFeLVq3c9L2F fPVMSjGxLNnRmzVPgfIyHwSX8cfOUOdVHHav/gGVcG8hV/BRr7kMLFAOap4Ffl0Ttc8ge8qo4c5 moNn2s0hYtMntDCGNBUBvlMkwiM1eAxUIQo3BL3t0favdtQw3UotQHw+sdBrTwoy8kYSEaAQwc+
 3ePQVVRnaIU4dBC4R6dLw+fC6BfPK2jbhxBVSC4iLpn6NZZe96dWymR01TYkGYgFsO6fG0SKVVI 8P1TxjN9m5Z3LlyHNe3u+pHKrjicvJ5aF0qYOcb/PIatGVPR+s2x5IC4DoD9e90VFb9l1CONy6k oqAMTxz0Rl+/ozCzDgeJmcQmer2jA5WEjaDVXn7QKHi2ckC94mzXOT7pHqWp1JViOPdqPq1Cnou
 ME7y75dOjaaJeRBL+BbwQx2AfFFWCezrbzrsOUQx37txWCh415ozCEpiQLhjaYub6jdTMNA3
X-Proofpoint-GUID: YqU8Jq5-7wGNLsrvVMmk2AdfxkEAJ7b1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01

From: Linu Cherian <lcherian@marvell.com>

For cn20k, NPA block doesn't use the general purpose
NDC (Near Coprocessor Bus Data cache Unit) for caching,
hence skip the NDC related operations.
Also refactor NDC configuration code to a helper function.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../marvell/octeontx2/af/rvu_debugfs.c        |  3 ++
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   | 29 ++++++++++++++-----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 296012a2f3de..7243592f0e43 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2743,6 +2743,9 @@ static void rvu_dbg_npa_init(struct rvu *rvu)
 			    &rvu_dbg_npa_aura_ctx_fops);
 	debugfs_create_file("pool_ctx", 0600, rvu->rvu_dbg.npa, rvu,
 			    &rvu_dbg_npa_pool_ctx_fops);
+
+	if (is_cn20k(rvu->pdev)) /* NDC not appliable for cn20k */
+		return;
 	debugfs_create_file("ndc_cache", 0600, rvu->rvu_dbg.npa, rvu,
 			    &rvu_dbg_npa_ndc_cache_fops);
 	debugfs_create_file("ndc_hits_miss", 0600, rvu->rvu_dbg.npa, rvu,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
index 4f5ca5ab13a4..e2a33e46b48a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npa.c
@@ -464,6 +464,23 @@ int rvu_mbox_handler_npa_lf_free(struct rvu *rvu, struct msg_req *req,
 	return 0;
 }
 
+static void npa_aq_ndc_config(struct rvu *rvu, struct rvu_block *block)
+{
+	u64 cfg;
+
+	if (is_cn20k(rvu->pdev)) /* NDC not applicable to cn20k */
+		return;
+
+	/* Do not bypass NDC cache */
+	cfg = rvu_read64(rvu, block->addr, NPA_AF_NDC_CFG);
+	cfg &= ~0x03DULL;
+#ifdef CONFIG_NDC_DIS_DYNAMIC_CACHING
+	/* Disable caching of stack pages */
+	cfg |= 0x10ULL;
+#endif
+	rvu_write64(rvu, block->addr, NPA_AF_NDC_CFG, cfg);
+}
+
 static int npa_aq_init(struct rvu *rvu, struct rvu_block *block)
 {
 	u64 cfg;
@@ -479,14 +496,7 @@ static int npa_aq_init(struct rvu *rvu, struct rvu_block *block)
 	rvu_write64(rvu, block->addr, NPA_AF_GEN_CFG, cfg);
 #endif
 
-	/* Do not bypass NDC cache */
-	cfg = rvu_read64(rvu, block->addr, NPA_AF_NDC_CFG);
-	cfg &= ~0x03DULL;
-#ifdef CONFIG_NDC_DIS_DYNAMIC_CACHING
-	/* Disable caching of stack pages */
-	cfg |= 0x10ULL;
-#endif
-	rvu_write64(rvu, block->addr, NPA_AF_NDC_CFG, cfg);
+	npa_aq_ndc_config(rvu, block);
 
 	/* For CN10K NPA BATCH DMA set 35 cache lines */
 	if (!is_rvu_otx2(rvu)) {
@@ -567,6 +577,9 @@ int rvu_ndc_fix_locked_cacheline(struct rvu *rvu, int blkaddr)
 	int bank, max_bank, line, max_line, err;
 	u64 reg, ndc_af_const;
 
+	if (is_cn20k(rvu->pdev)) /* NDC not applicable to cn20k */
+		return 0;
+
 	/* Set the ENABLE bit(63) to '0' */
 	reg = rvu_read64(rvu, blkaddr, NDC_AF_CAMS_RD_INTERVAL);
 	rvu_write64(rvu, blkaddr, NDC_AF_CAMS_RD_INTERVAL, reg & GENMASK_ULL(62, 0));
-- 
2.34.1


