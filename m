Return-Path: <netdev+bounces-207965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4796B092DA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840095A4787
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166302FCFFB;
	Thu, 17 Jul 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DP7uxCmE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C62FD584
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772204; cv=none; b=ZqIPjDgd5lwaBxV8LEVgX0jkcnusiV8qmm5o9Ivlhck16DwtZ4HJAPt6QHJBckjptHSQrI7wVrfbrIR1QWxKKyXgkN8s89rLwizzxsnEWnBu5BMj+VlvFWvxUIdYYrxsDPADoKp2RDtF5rOthDO0NG0dTYnezJ/rYUfiyZoRmUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772204; c=relaxed/simple;
	bh=csrvZ3oB7tUHoElaBK2/jffWlqeYTDzzdbWXZ2zRIvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIg0sTmaydMhI172QHxSJNGuy0N+oWhJxGrNhFs//ikDbXeeIQBmi7GgDf9QzJnd/ru6AIaE2sYBIhbZVqccxjZHepV+Ga6dWJEGLsaKnIOrHjpnahU19/PgqpIBqZEovkRpyaZAGKirG7d/VRpWCCNePXgYFsyEcdYeCvacEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DP7uxCmE; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9e597019407;
	Thu, 17 Jul 2025 10:09:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=I/4V8qGonxkqJpqy6sSMS/UlZ
	POZekuSmUtNKtkCbSw=; b=DP7uxCmEOcNlGFfpGR/y0DyrH6bN2xP8UzxWzt8oZ
	lSTI0aGZW6oHsoYMYJza615PABtUleUJMLsp6T21/BVr41e0M0s++yu8rPZt49ND
	eGmR/rSHs9xbGnUOlgY9KAGauTXI3xRz/wiyn3t8ti7qpDCIu2svP9T5vEo1L89F
	2iSoEuuhFlzMlTGZg4SP1wwWhzuQfNY/sKtXhz6E5LAM8rwGUhbGQWILj7wuWfOk
	ILtjPKOFwZXLqhVfmSIaEOqVo+AIocM+UpkW2OaeNobG5CH78Ud8GGCbnWQMaZc2
	GttEpeWRssmfoXcVxNemKezgc6Yl7m9N5QDpOmsM+iSoA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47xvpc96ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:09:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Jul 2025 10:09:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Jul 2025 10:09:35 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id CCAEA3F7044;
	Thu, 17 Jul 2025 10:09:31 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 01/11] octeontx2-af: Simplify context writing and reading to hardware
Date: Thu, 17 Jul 2025 22:37:33 +0530
Message-ID: <1752772063-6160-2-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=U8ySDfru c=1 sm=1 tr=0 ts=68792e61 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=MRDsCLJ-5-IbZPZsV44A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 96m7-qeG1h8OAO8E10Rr6AzgcrdzHpy3
X-Proofpoint-ORIG-GUID: 96m7-qeG1h8OAO8E10Rr6AzgcrdzHpy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MiBTYWx0ZWRfX1d32+aQtUiby 7LZrjhVNQ6aVdEi4zjVT8a2pWfU6RI1cjt5xRbjmF2bxHGiEHnnGNncSKPZ3VM992XfVC50lNn1 IixwMy8ufQh/Bd5avcbisdga+als6abCEHRUN0D9udztiKAf0NI+CakK429T/aOqY7DhCXGs/pj
 b+UX0W9bEBCp/b+H8HF5MU6Q5XxcZfkeHArEnBFpnJ+L2HV68PsKCrvlywM5DJ83wiWWgNSXme3 aiVPBjqSc+nY2Cf2Am+rqeEhaSl2NVLeqkMdeKgZMvH9Qff0yBkd0Vh39DlFEaZhyorvjKqenRl GDvAkdf1KFnhbwQaOWcyGbnNXwaPsmp8ZWh563Oc1DcvBlGAkAiag6OfY1GaeNhul3kDV7Sh/rU
 op/oc3ea4ht57Ijlx5OnCl5RkEihpEnj4WO/zqdzRA+enHjMWO9MlAP5e/KtjFxPqi+tTKY9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01

Simplify NIX context reading and writing by using hardware
maximum context size instead of using individual sizes of
each context type.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 44 +++++++++----------
 .../marvell/octeontx2/af/rvu_struct.h         | 15 ++++++-
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index bdf4d852c15d..b8ffbd7c8f00 100644
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
index 0596a3ac4c12..1097c86fdc46 100644
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
+	/* Ensure all context sizes are minimum 128 bytes */
+	u64 padding[12];
 };
 
+static_assert(sizeof(struct nix_cq_ctx_s) == NIX_MAX_CTX_SIZE);
+
 /* CN10K NIX Receive queue context structure */
 struct nix_cn10k_rq_ctx_s {
 	u64 ena			: 1;
@@ -672,9 +678,12 @@ struct nix_sq_ctx_s {
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
@@ -684,8 +693,12 @@ struct nix_rx_mce_s {
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
-- 
2.34.1


