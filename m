Return-Path: <netdev+bounces-207224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7064DB064D3
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350B94E6C2D
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C155280337;
	Tue, 15 Jul 2025 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="W6GQYk8D"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C62417F8
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598977; cv=none; b=pOpi3SLdPlHX3WKRGa8bxHIo5Fv5HiXFQAWDveyrPKnbWjF3wyDnKECNCkyBOTMDoPngMmG9qVEnglAs31KDTYFlrPYMtlYvFXhAPlpzbHRqhiwrN6BXOsRervNxknRimHqtaQoAv3VC+4MOEAw4xeH8BMXqn7EEmG2cQjKlFb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598977; c=relaxed/simple;
	bh=GEcS3ZO3puCljoaFKBG1LDBTw/mBxZ78+YM16GcAO8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZG0DKvZeTFWXqEPdW7280gjY3OsNiKjczS3mYS28eMVFglKKkV1GycRGSKgKemT9BifAqHRIWk0Pp6Gh58EWY3Y2GHnPy55l6NanmyilflbNNYhCNUb2Gkk4/onT+I54O95uncQ+6dltaDgQ4SmIPnvdZriRuNl822945+h2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=W6GQYk8D reason="signature verification failed"; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FBnIrY031792;
	Tue, 15 Jul 2025 10:02:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=gOtsgZP4SVG+PgRESksfTK2Y1
	rNCquMLgfb1AiVYUDQ=; b=W6GQYk8DSrdov9IA60YWwTiURQFky8FgOkHgHXRFL
	2nLzr+Ou9AytmrXpYV6c0pdnBud0BNXOICVwBjiq+xpp4t9TzMjDbajUmZq81YWU
	QyO9TBBv8Gy/1Z6lLj8qcP/PdTuyxoN8QRFcJxyYhCAh4VNPnEgGsYBhBAVRnZVq
	5xwOx8Y6AnTixn+ITvvXtGNkv30Lh6c6iLb1PRNxHocAzpPTp9N79jbFhp3JmWtS
	cZSsgl4s+z0ncKTl7SwwnpcdZraC/uuUFmK/fFonfgpPyhbIkmLDJXFhc4DyJdGd
	uuitlP8hIEW2XAnz4PN+rvVxZT/EQJ6sBa/oJoKt8pscg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47wpevgr2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:02:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Jul 2025 10:02:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Jul 2025 10:02:47 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id D21035B692E;
	Tue, 15 Jul 2025 10:02:43 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, pabeni4redhat.com@mx0b-0016f401.pphosted.com,
        <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v2 06/11] octeontx2-af: Skip NDC operations for cn20k
Date: Tue, 15 Jul 2025 22:31:59 +0530
Message-ID: <1752598924-32705-7-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1752598924-32705-1-git-send-email-sbhatta@marvell.com>
References: <1752598924-32705-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: JIjq-_38BmMd-3KKE4TVSW9IEzqxE5t7
X-Proofpoint-ORIG-GUID: JIjq-_38BmMd-3KKE4TVSW9IEzqxE5t7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NiBTYWx0ZWRfXwUymeaUV4j+X vHrp2Zbw+5ff7Hxtu3rJAYmgUQAoC/2yGgF7kUi3zN6GeHBty8HDwJ0lPPm39Rr423S2s6MHXeW 5FNHTIB8u3BwHWVX4g0px8YKUiYlAfJTi6oo1/+Qpg+pI6CcEMws/okh7bw7jmQeu508T6vEcug
 eaZ1Ib7+tG0no04FfPwI99NSdrW0/jctbYTts3amQ2i1AaQErUNVhl3qOBc1ie2H8t1uR/uT0lN ds1QGLvRw7BGGYUeV2247QunGV0czjr/+FhF8qiWeVY6fmIinQW2nwxDN2qR2DTLGXMKfqwMFcX Wm2CJ4YkDnywp6xwUhILsmmSLP7I2EKpTrqTBj3WERMKsK8RSauzOOI6x78jm3Q2nashB2ojUv9
 WbFXO3LC+IzAFJZuPRlAMdmHvT0O1buCaOlx4TsmpUbPc1A1trtCblQCF+xnUk6SXTmZYpSf
X-Authority-Analysis: v=2.4 cv=Pav/hjhd c=1 sm=1 tr=0 ts=687689b9 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=GFmy-jf8mh29BVtaGncA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01

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


