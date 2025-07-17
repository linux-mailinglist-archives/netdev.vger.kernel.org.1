Return-Path: <netdev+bounces-207970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E7CB092DB
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAEE07BE3FF
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1EF2FEE17;
	Thu, 17 Jul 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="G9F3KNFk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3E2FE31C
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772209; cv=none; b=ZXNSXbrRLXwztJmOL45YfzTk6DWBk9+EwhTHa33JLwX/USwi0lOD8HyiN2okZS5KI16F2Y8D9xMYISpCdbHFK7Jl6QU9AcTAscnHcF3LmebBfLcGEbhoShWHUu0pXEMw7i7sz1idY1Q4eI9X1TKTFFb7dndbMiIrgWpHWqsfuXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772209; c=relaxed/simple;
	bh=GEcS3ZO3puCljoaFKBG1LDBTw/mBxZ78+YM16GcAO8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqe6i3GMW0A5XKTG8ohCeEbNm/2UhmV7wxb07o6HhtGZigM1K0GyrcGGmE3TIbpCtt9ApA2Xwd68NDh56q67/KtggxdXfPiybPQwg2fwSf1K4uI7G1fVDMSVHAhEgjyqCnE3wPndTrG4XJej+poiJ/yNF7YYUleyDB1EtBi4euA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=G9F3KNFk; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9e7IQ019754;
	Thu, 17 Jul 2025 10:10:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=gOtsgZP4SVG+PgRESksfTK2Y1
	rNCquMLgfb1AiVYUDQ=; b=G9F3KNFkYfwg5CuSVoyzDb1epaRDSZq+x4gFKYs6G
	RPBsFT+GuE+YxFsItwCSHpPPBx+7Kh41z9lbhyCRz30Hp9lOMJWpvyot7DBLimIz
	Vi7LbxE7V331K0jOpBU1Ius3tzQcYWD5DiIBdn4c+W3Bz3t1ot7apLtpntty2Fna
	yDXHHT8v/7GHnrqZgIMnvIwpMYgfHSB9O/WLlIV0rdMp9VpxR9aNL9RAu1zD5F99
	LQzpXPV2644KZrsgNetI3jc/SzuR3LXZuDoAQcWo+9O/6ke8Vb0Mk5W5SIxaFk1x
	veVksvrpbi9m3bqse6EeF5TyMI18ySQtJsQWZUhHO2qnA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47xvpc96tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:09:59 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Jul 2025 10:09:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Jul 2025 10:09:58 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id B7BA03F7058;
	Thu, 17 Jul 2025 10:09:54 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 06/11] octeontx2-af: Skip NDC operations for cn20k
Date: Thu, 17 Jul 2025 22:37:38 +0530
Message-ID: <1752772063-6160-7-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
References: <1752772063-6160-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=U8ySDfru c=1 sm=1 tr=0 ts=68792e67 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=GFmy-jf8mh29BVtaGncA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: V9XZNkycXU_LVarLBmiccXjdraA0SJO-
X-Proofpoint-ORIG-GUID: V9XZNkycXU_LVarLBmiccXjdraA0SJO-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MiBTYWx0ZWRfX/uc9FY9bQd6p 8SNKStNBezQTB/Ua7MwCoYBG+2Qu1IyNL59r5Bx+1HLAeIp/B2A8xSrkIs8BIWY+FftKRpj7dTu iqFkPrk81SQZo53qv/6I8VVBXZr4Xop5oU79MlsiWHv2sShO5s4EWG4hd4EKgfEL7IrXpBkTB1y
 CEqwCvtGHUlCpbQ2JYk9GOUlbIxLz399gnUi+bZNxI+A1A4dsPqWMctiZ16jxN82U3DHoHhUCAW fHWhirk/eULTJ0TFv3WEHhVa+rANdBTBoqshQY/CylGQAwT3g9Mi8va0xQqUfcRgI/9+T28cFgP hgLfNtUiRPuF3RXrlc008DXby5X0rd+26InIPLCj/C1lUct1hwc2goVjnBO+7G1Hz2XHR/lxVKj
 AcH3IqnjnhgdSzRAHJWHtGF5Wux5Iv5EU+sYrrCRybcTThqZ5CIAwAoZ1usPlC4edum6RWPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01

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


