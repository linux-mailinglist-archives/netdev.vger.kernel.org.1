Return-Path: <netdev+bounces-232801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA67C08F27
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0710B4E35AC
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7062F49FB;
	Sat, 25 Oct 2025 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BnX3OvTX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC00C2F39AF
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388429; cv=none; b=qkCP/wGP9WsegYXpuc5E9cbuwMCG7XJhMtEdQ2WBb54LejWczGf3okFtMXKMB+2aQDC8NZWhTRK0OizgLmDPnITv1Gk45NvA8SIDtWG/ggNRZzdplPaazxfcSdtEZL/tyJvPzR/joaxEi+UDYnKRytDfeR1TVi74HGjWH+CC4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388429; c=relaxed/simple;
	bh=G7W67MPG/IrUdRd+bXe6PfPkpnTwJkHeC8gOadafttI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DB7MsZ/NMxvbcUtcoICg1Gf/P8d41J0Sy14p5VClwIcQs/RdQ8DrCpxp59ogQ2HGYKyG2YwvMSTaZ4OcXBgkGUQ/+HBCBc4q/f/OJ762nfjhqtNiKWYqzcodNGyAjTeysMLJuN6XLGJa+xyJGaOkMyvw9FpgkK6uYv8DgrrkQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BnX3OvTX; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59P5xTkU399042;
	Sat, 25 Oct 2025 03:33:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=YV3p4fde68sGt840L+KnI6tdd
	lsx/BwsNHRLb8wAhzc=; b=BnX3OvTXTyAnE9w+ToEdP0jqlxOAdWK0cawzeUVBS
	2Vk1B+Qs5RS7Yf4t/iiXTlBa+C4SedeYkZqQvp9a1cFO7k9yCBjyVf/CodBky2s1
	Qt5oPyJ6Zvd2lIwLmmPk2FuQ+0Qj4qOUrOGcl+ws0Hxm4i9jtLlFgO0FRkyvF1qU
	7F7FLlu3HEqiJPZtEmz78ko+eT+PpUdEfyvA3WwAEV529DcC+WZsINSCjdDZRWOt
	RibZucXySojPhGViVviOIx2cXzWH+PpyDvpe5M4JplHajGdXZAqCGXuJA2/1XNoi
	70Z1Fv9I9m36jJN9lZ3hG4qEiTB/pAHp25rTDxyDk59xQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a0p2g8gy1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Oct 2025 03:33:40 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 25 Oct 2025 03:33:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 25 Oct 2025 03:33:52 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 33DB65B6921;
	Sat, 25 Oct 2025 03:33:34 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <saikrishnag@marvell.com>, <netdev@vger.kernel.org>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v4 06/11] octeontx2-af: Skip NDC operations for cn20k
Date: Sat, 25 Oct 2025 16:02:42 +0530
Message-ID: <1761388367-16579-7-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
References: <1761388367-16579-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDA5NSBTYWx0ZWRfX+ow8Y7CCYDFC
 vzYSsrolclVrX9UPL7ToxggbJhSEjYIftPkXZgyt0e4SLbfVOOq7c2JAJvmggmVfyTBbaCCFpZw
 MsFc3MF0eec59n64HZweysesk2ktfMvUuMURWzlwvGZZLF2a8ZOYWqj/6ujfziaq2SE3VWdQJ0S
 np19v3jzIaMpMGhwg5K2kSCfx6SA4tllLT3x5PYkp1a1QEk1qZRUxGleq+yx4Imx1ZKwXLuyLRv
 L+gliW0XcNddExnmFDVPVeb00XFpxoTuBwvMFlAMJK5wOoBXmT5lj38Y5b+2KFi53jkbfcVJ1fG
 xiH8v3uTgg+09PX/MYkjuewB3umkJ3v055Z/uiJZQSai8gRdyM2hgbCv19G2/xsJZmmd243qwHe
 rI/CRhtRtG951wb19kijLrbyQbw6VQ==
X-Proofpoint-ORIG-GUID: rakG9A9efcBKWM5VypCEm7ze4OJS--Ze
X-Authority-Analysis: v=2.4 cv=Bt6QAIX5 c=1 sm=1 tr=0 ts=68fca784 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=GFmy-jf8mh29BVtaGncA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: rakG9A9efcBKWM5VypCEm7ze4OJS--Ze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_03,2025-10-22_01,2025-03-28_01

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
index c55a0f15380d..8ab82700e826 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2808,6 +2808,9 @@ static void rvu_dbg_npa_init(struct rvu *rvu)
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
2.48.1


