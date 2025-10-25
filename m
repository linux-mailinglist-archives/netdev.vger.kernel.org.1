Return-Path: <netdev+bounces-232796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD45C08F18
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D58634E1763
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750882F39AB;
	Sat, 25 Oct 2025 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="X60fg4G9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2642F39A7
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388412; cv=none; b=fLIWhhjJbExMXYJzrlYmUI2+9arRBbEvVDY2csaCUgnuNEgTXwpvMMp4EP/iS1kqP5+1YbkJUxKlf84jUa1wQJ6BeaEJTPIi6wQIWTJSg0mzg5b1QbOsxTz3nrk8s8eaowGvhu7tjyIC3nsPAFUWkKyWBwfIVhC11+d/wlrhRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388412; c=relaxed/simple;
	bh=wbRalzmPBufYWqFCJrxG4+kiTWutEFMPY/UYcgotPBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxPINIagRP/50FyhqYdp5+H+8ZkFLYnT0eGdNqDsA4WTQXBC4eVvjLrEicygpf6lUsl0DdpLasYM8qI46iHab8pqzqAtW0XKqN5gje4L4k72SyfkTQNBqOANcQI/9yJswXRFUMltVWWMfnTSUc7cFlVYqwu8Y6LrwNslbmLB7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=X60fg4G9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59P9QI4Z670930;
	Sat, 25 Oct 2025 03:33:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=RyBfdmapDDZHPi9KvvVQVQrjx
	899uLZCyJz1ATd8iBQ=; b=X60fg4G9LV++8UEIGuH5pZiAyMosl4SEdkKlYFrRi
	Ja4tZhxwDc5QUc3W490rePgoP9OE0tlAJmLkZ6vb2x944iY11wm3iM/Jm7A+0hBX
	3wTP5r9DYmw2jjzxCaPCd35s7htDR4RsYzq0vEj/9JUgESUn9ml+UF3mBmKOit6E
	iLMhPQif+L6qIr1tX5UMXk265c0ihJ3loUUaX3G2KIvXD/ZuxGK4jSqkoYEAo8Ms
	P+uZrVVFmqocumrNqISZKjAdPYPPIIw6Yo67F/mnT0vBIGkU08l7yXHOasEIO6h4
	irZaAFoJyhqK5WQngB9l6DXuqFmnZOCPc1Yh1L6owR7HQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a0uwh02tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Oct 2025 03:33:16 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 25 Oct 2025 03:33:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 25 Oct 2025 03:33:28 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id DBDF95B6921;
	Sat, 25 Oct 2025 03:33:09 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <saikrishnag@marvell.com>, <netdev@vger.kernel.org>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v4 01/11] octeontx2-af: Simplify context writing and reading to hardware
Date: Sat, 25 Oct 2025 16:02:37 +0530
Message-ID: <1761388367-16579-2-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=H6vWAuYi c=1 sm=1 tr=0 ts=68fca76c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=QqTgl1hd3bcHdtdf-WUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: fsmV-rb2JUd6Ak435_6NeLsgLBc_xjBj
X-Proofpoint-GUID: fsmV-rb2JUd6Ak435_6NeLsgLBc_xjBj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDA5NSBTYWx0ZWRfXyG/gSiPTOig4
 dgo9Rg0cwLjRVmkArS2DxM4ZO13sWtppVqzKz/94Et9vyl7W0wQPple+EZEcVyOX7t7ytftFeN/
 U+5H/svE7JSn+TQ1mg9Vb2w7F987GLEYGZHE9E4J77ePn0Zixsqvm/FNTLOxu9dq2Cy6Jkh+Vbg
 ZDfdGZjTitjFheURMB7jyK/caEh80ZUpAJ//m06QFC3EWsvke78wRvTtMXj/8Z6DQ/5KvREJFDq
 V6JJQIt+0rle0IhgJ4NUDIgG7+y6s4C6mHIqrACs7f7zFLD9Rf0ghO6SLWgxfi2ilBHybHHBoqB
 YDY+RdOXaMkH5SM6JYiSThMuTNJwzaLQPEngLVUMevrzw1OXWKB04qjyLpq0URcGyWY1TTH1yxi
 ryONZxXw4uoGa1nF4T8w9qk8BcTRnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_03,2025-10-22_01,2025-03-28_01

Simplify NIX context reading and writing by using hardware
maximum context size instead of using individual sizes of
each context type.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 44 +++++++++----------
 .../marvell/octeontx2/af/rvu_struct.h         | 25 ++++++++++-
 2 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 828316211b24..26dc0fbeafa6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1149,36 +1149,36 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 	case NIX_AQ_INSTOP_WRITE:
 		if (req->ctype == NIX_AQ_CTYPE_RQ)
 			memcpy(mask, &req->rq_mask,
-			       sizeof(struct nix_rq_ctx_s));
+			       NIX_MAX_CTX_SIZE);
 		else if (req->ctype == NIX_AQ_CTYPE_SQ)
 			memcpy(mask, &req->sq_mask,
-			       sizeof(struct nix_sq_ctx_s));
+			       NIX_MAX_CTX_SIZE);
 		else if (req->ctype == NIX_AQ_CTYPE_CQ)
 			memcpy(mask, &req->cq_mask,
-			       sizeof(struct nix_cq_ctx_s));
+			       NIX_MAX_CTX_SIZE);
 		else if (req->ctype == NIX_AQ_CTYPE_RSS)
 			memcpy(mask, &req->rss_mask,
-			       sizeof(struct nix_rsse_s));
+			       NIX_MAX_CTX_SIZE);
 		else if (req->ctype == NIX_AQ_CTYPE_MCE)
 			memcpy(mask, &req->mce_mask,
-			       sizeof(struct nix_rx_mce_s));
+			       NIX_MAX_CTX_SIZE);
 		else if (req->ctype == NIX_AQ_CTYPE_BANDPROF)
 			memcpy(mask, &req->prof_mask,
-			       sizeof(struct nix_bandprof_s));
+			       NIX_MAX_CTX_SIZE);
 		fallthrough;
 	case NIX_AQ_INSTOP_INIT:
 		if (req->ctype == NIX_AQ_CTYPE_RQ)
-			memcpy(ctx, &req->rq, sizeof(struct nix_rq_ctx_s));
+			memcpy(ctx, &req->rq, NIX_MAX_CTX_SIZE);
 		else if (req->ctype == NIX_AQ_CTYPE_SQ)
-			memcpy(ctx, &req->sq, sizeof(struct nix_sq_ctx_s));
+			memcpy(ctx, &req->sq, NIX_MAX_CTX_SIZE);
 		else if (req->ctype == NIX_AQ_CTYPE_CQ)
-			memcpy(ctx, &req->cq, sizeof(struct nix_cq_ctx_s));
+			memcpy(ctx, &req->cq, NIX_MAX_CTX_SIZE);
 		else if (req->ctype == NIX_AQ_CTYPE_RSS)
-			memcpy(ctx, &req->rss, sizeof(struct nix_rsse_s));
+			memcpy(ctx, &req->rss, NIX_MAX_CTX_SIZE);
 		else if (req->ctype == NIX_AQ_CTYPE_MCE)
-			memcpy(ctx, &req->mce, sizeof(struct nix_rx_mce_s));
+			memcpy(ctx, &req->mce, NIX_MAX_CTX_SIZE);
 		else if (req->ctype == NIX_AQ_CTYPE_BANDPROF)
-			memcpy(ctx, &req->prof, sizeof(struct nix_bandprof_s));
+			memcpy(ctx, &req->prof, NIX_MAX_CTX_SIZE);
 		break;
 	case NIX_AQ_INSTOP_NOP:
 	case NIX_AQ_INSTOP_READ:
@@ -1243,22 +1243,22 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 		if (req->op == NIX_AQ_INSTOP_READ) {
 			if (req->ctype == NIX_AQ_CTYPE_RQ)
 				memcpy(&rsp->rq, ctx,
-				       sizeof(struct nix_rq_ctx_s));
+				       NIX_MAX_CTX_SIZE);
 			else if (req->ctype == NIX_AQ_CTYPE_SQ)
 				memcpy(&rsp->sq, ctx,
-				       sizeof(struct nix_sq_ctx_s));
+				       NIX_MAX_CTX_SIZE);
 			else if (req->ctype == NIX_AQ_CTYPE_CQ)
 				memcpy(&rsp->cq, ctx,
-				       sizeof(struct nix_cq_ctx_s));
+				       NIX_MAX_CTX_SIZE);
 			else if (req->ctype == NIX_AQ_CTYPE_RSS)
 				memcpy(&rsp->rss, ctx,
-				       sizeof(struct nix_rsse_s));
+				       NIX_MAX_CTX_SIZE);
 			else if (req->ctype == NIX_AQ_CTYPE_MCE)
 				memcpy(&rsp->mce, ctx,
-				       sizeof(struct nix_rx_mce_s));
+				       NIX_MAX_CTX_SIZE);
 			else if (req->ctype == NIX_AQ_CTYPE_BANDPROF)
 				memcpy(&rsp->prof, ctx,
-				       sizeof(struct nix_bandprof_s));
+				       NIX_MAX_CTX_SIZE);
 		}
 	}
 
@@ -1289,8 +1289,8 @@ static int rvu_nix_verify_aq_ctx(struct rvu *rvu, struct nix_hw *nix_hw,
 	/* Make copy of original context & mask which are required
 	 * for resubmission
 	 */
-	memcpy(&aq_req.cq_mask, &req->cq_mask, sizeof(struct nix_cq_ctx_s));
-	memcpy(&aq_req.cq, &req->cq, sizeof(struct nix_cq_ctx_s));
+	memcpy(&aq_req.cq_mask, &req->cq_mask, NIX_MAX_CTX_SIZE);
+	memcpy(&aq_req.cq, &req->cq, NIX_MAX_CTX_SIZE);
 
 	/* exclude fields which HW can update */
 	aq_req.cq_mask.cq_err       = 0;
@@ -1309,7 +1309,7 @@ static int rvu_nix_verify_aq_ctx(struct rvu *rvu, struct nix_hw *nix_hw,
 	 * updated fields are masked out for request and response
 	 * comparison
 	 */
-	for (word = 0; word < sizeof(struct nix_cq_ctx_s) / sizeof(u64);
+	for (word = 0; word < NIX_MAX_CTX_SIZE / sizeof(u64);
 	     word++) {
 		*(u64 *)((u8 *)&aq_rsp.cq + word * 8) &=
 			(*(u64 *)((u8 *)&aq_req.cq_mask + word * 8));
@@ -1317,7 +1317,7 @@ static int rvu_nix_verify_aq_ctx(struct rvu *rvu, struct nix_hw *nix_hw,
 			(*(u64 *)((u8 *)&aq_req.cq_mask + word * 8));
 	}
 
-	if (memcmp(&aq_req.cq, &aq_rsp.cq, sizeof(struct nix_cq_ctx_s)))
+	if (memcmp(&aq_req.cq, &aq_rsp.cq, NIX_MAX_CTX_SIZE))
 		return NIX_AF_ERR_AQ_CTX_RETRY_WRITE;
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index 0596a3ac4c12..8d41cb8f85ef 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -13,6 +13,8 @@
 
 #define RVU_MULTI_BLK_VER		0x7ULL
 
+#define NIX_MAX_CTX_SIZE		128
+
 /* RVU Block Address Enumeration */
 enum rvu_block_addr_e {
 	BLKADDR_RVUM		= 0x0ULL,
@@ -370,8 +372,12 @@ struct nix_cq_ctx_s {
 	u64 qsize		: 4;
 	u64 cq_err_int		: 8;
 	u64 cq_err_int_ena	: 8;
+	/* Ensure all context sizes are 128 bytes */
+	u64 padding[12];
 };
 
+static_assert(sizeof(struct nix_cq_ctx_s) == NIX_MAX_CTX_SIZE);
+
 /* CN10K NIX Receive queue context structure */
 struct nix_cn10k_rq_ctx_s {
 	u64 ena			: 1;
@@ -460,6 +466,8 @@ struct nix_cn10k_rq_ctx_s {
 	u64 rsvd_1023_960;		/* W15 */
 };
 
+static_assert(sizeof(struct nix_cn10k_rq_ctx_s) == NIX_MAX_CTX_SIZE);
+
 /* CN10K NIX Send queue context structure */
 struct nix_cn10k_sq_ctx_s {
 	u64 ena                   : 1;
@@ -523,6 +531,8 @@ struct nix_cn10k_sq_ctx_s {
 	u64 rsvd_1023_1008        : 16;
 };
 
+static_assert(sizeof(struct nix_cn10k_sq_ctx_s) == NIX_MAX_CTX_SIZE);
+
 /* NIX Receive queue context structure */
 struct nix_rq_ctx_s {
 	u64 ena           : 1;
@@ -594,6 +604,8 @@ struct nix_rq_ctx_s {
 	u64 rsvd_1023_960;		/* W15 */
 };
 
+static_assert(sizeof(struct nix_rq_ctx_s) == NIX_MAX_CTX_SIZE);
+
 /* NIX sqe sizes */
 enum nix_maxsqesz {
 	NIX_MAXSQESZ_W16 = 0x0,
@@ -668,13 +680,18 @@ struct nix_sq_ctx_s {
 	u64 rsvd_1023_1008        : 16;
 };
 
+static_assert(sizeof(struct nix_sq_ctx_s) == NIX_MAX_CTX_SIZE);
+
 /* NIX Receive side scaling entry structure*/
 struct nix_rsse_s {
 	uint32_t rq			: 20;
 	uint32_t reserved_20_31		: 12;
-
+	/* Ensure all context sizes are minimum 128 bytes */
+	u64 padding[15];
 };
 
+static_assert(sizeof(struct nix_rsse_s) == NIX_MAX_CTX_SIZE);
+
 /* NIX receive multicast/mirror entry structure */
 struct nix_rx_mce_s {
 	uint64_t op         : 2;
@@ -684,8 +701,12 @@ struct nix_rx_mce_s {
 	uint64_t rsvd_31_24 : 8;
 	uint64_t pf_func    : 16;
 	uint64_t next       : 16;
+	/* Ensure all context sizes are minimum 128 bytes */
+	u64 padding[15];
 };
 
+static_assert(sizeof(struct nix_rx_mce_s) == NIX_MAX_CTX_SIZE);
+
 enum nix_band_prof_layers {
 	BAND_PROF_LEAF_LAYER = 0,
 	BAND_PROF_INVAL_LAYER = 1,
@@ -769,6 +790,8 @@ struct nix_bandprof_s {
 	uint64_t reserved_1008_1023          : 16;
 };
 
+static_assert(sizeof(struct nix_bandprof_s) == NIX_MAX_CTX_SIZE);
+
 enum nix_lsoalg {
 	NIX_LSOALG_NOP,
 	NIX_LSOALG_ADD_SEGNUM,
-- 
2.48.1


