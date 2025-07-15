Return-Path: <netdev+bounces-207219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9913FB064CE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015A44E4845
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8725DAFC;
	Tue, 15 Jul 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GzQEaCHA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57E277C9D
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598961; cv=none; b=A2xZu6Q1SVqKUdPPtQlXoD9WIDYrewaqoQKdqZ/eTNfPgfokVO7LRgvTtFgooMmA2+ZQ5hIU61v26hONhnz9dZnjR5sbXtIDnqkSRAgUtY7fxOafkQ3U7qcVk2RK+5aOZQTSNInSPBsn6WrBFxN5IpsWp4NutEBMKnUrllq5I9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598961; c=relaxed/simple;
	bh=EXFFTvsPIWLQEsVLnUOMTTePo4ASEhqVtmV/v3UoZxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6KoiM2zFH++arMmXoYRUu3gm3xY1B9dbYKjmI54o6+GHk6AsNZCrNNzhJZgBINQhmqR4LAWxDdReb4n8djwmfyVN9ATB3w3RfKzPqJeZ8/klJK2I3UkAWvDJvS7LkppAEvCR3CojmzODu1RzRa/x6cmnsotii6xrPik7ufn+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GzQEaCHA reason="signature verification failed"; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGUoLh019299;
	Tue, 15 Jul 2025 10:02:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=x1Nb9LH4+wYDd0KMwLiiuQ6qh
	C9f/KIEsAuci4jH2Pc=; b=GzQEaCHAU9Kqo8CDLMZsNRdr57baWipv4bCmjRVeS
	mnpgxfNFO5HN11HrG1gWxQpG7sx4oYrHkpPW2/3jBsLVgxTR20bjlOQ6aDOkH9+l
	5tJJsBtH++ZntHyIKUmnEb7ByYdgYVTvtG0enL7kbptDboA8UxRer1Tbq+BCFEW6
	yMnLnxyaJUG4WiFuHu5KGy4iqaRuJ3pti2vuogBKVO+cVj9zxJpsLkbmcu/dDVN7
	e+hNzYb1qKUcYpzGWia4V0MQgJh/iOVwJeKlBsiYqTlP4gUOnLNkAVJXiCEyRcNV
	+ILyojh5TXNMfJTtWCoRFBm6u0DkbbdN0s9wiK1UNq5jg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47wajmtc89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:02:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Jul 2025 10:02:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Jul 2025 10:02:24 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 29C185B692E;
	Tue, 15 Jul 2025 10:02:19 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, pabeni4redhat.com@mx0a-0016f401.pphosted.com,
        <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v2 01/11] octeontx2-af: Simplify context writing and reading to hardware
Date: Tue, 15 Jul 2025 22:31:54 +0530
Message-ID: <1752598924-32705-2-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NiBTYWx0ZWRfX2hWa0m0sF4LZ shIYEC3hUVKHlUgx+/iaTgDvl+Z+e14TXrv/SvMFY8lcZjLeliaVyjmHg/dd3X+oCRFaW1iCpY+ 4mCfPmRHSJJhwsINUGTnrSuOEUJziW3VlpHS5VZj9kAsfNrCtb0Y420brmz6LgaKpvrC01YZn/C
 /QpJ1BMW2QZBpyRUUe/jkTu+8NSuhv+6DZe0liwefQ6dmqGFs1ZIcIcyAHG6SZ19nQP9Ois+TvY cENrtR+cI/PZCxxLKnm4X8ZmsmJsBh1PF768RZLDS7CYv8wXTrlk2hUIMrYLnGyMez/VLll8eK9 rPUsVcJxthSa3lsuTK1Mdcz3i2zHlygzkzVfK4IMe/OaTNe9LnpNHS6MUii5+rPMYNgEHxTocAJ
 2zMp/Q4leGx1DTM3B0hkcCUyPq4M55UzvORGIt7XkH+skAuG7JrWfoJs5S2TRnTMmmcRMBsV
X-Proofpoint-GUID: nFSr5tNGNs_Po5MoDccFYcqPQ_J3rFKX
X-Authority-Analysis: v=2.4 cv=W+c4VQWk c=1 sm=1 tr=0 ts=687689a4 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=MRDsCLJ-5-IbZPZsV44A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: nFSr5tNGNs_Po5MoDccFYcqPQ_J3rFKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01

Simplify NIX context reading and writing by using hardware
maximum context size instead of using individual sizes of
each context type.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 46 ++++++++++---------
 .../marvell/octeontx2/af/rvu_struct.h         |  7 ++-
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index bdf4d852c15d..48d44911b663 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -17,6 +17,8 @@
 #include "lmac_common.h"
 #include "rvu_npc_hash.h"
 
+#define NIX_MAX_CTX_SIZE	128
+
 static void nix_free_tx_vtag_entries(struct rvu *rvu, u16 pcifunc);
 static int rvu_nix_get_bpid(struct rvu *rvu, struct nix_bp_cfg_req *req,
 			    int type, int chan_id);
@@ -1149,36 +1151,36 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
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
@@ -1243,22 +1245,22 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
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
 
@@ -1289,8 +1291,8 @@ static int rvu_nix_verify_aq_ctx(struct rvu *rvu, struct nix_hw *nix_hw,
 	/* Make copy of original context & mask which are required
 	 * for resubmission
 	 */
-	memcpy(&aq_req.cq_mask, &req->cq_mask, sizeof(struct nix_cq_ctx_s));
-	memcpy(&aq_req.cq, &req->cq, sizeof(struct nix_cq_ctx_s));
+	memcpy(&aq_req.cq_mask, &req->cq_mask, NIX_MAX_CTX_SIZE);
+	memcpy(&aq_req.cq, &req->cq, NIX_MAX_CTX_SIZE);
 
 	/* exclude fields which HW can update */
 	aq_req.cq_mask.cq_err       = 0;
@@ -1309,7 +1311,7 @@ static int rvu_nix_verify_aq_ctx(struct rvu *rvu, struct nix_hw *nix_hw,
 	 * updated fields are masked out for request and response
 	 * comparison
 	 */
-	for (word = 0; word < sizeof(struct nix_cq_ctx_s) / sizeof(u64);
+	for (word = 0; word < NIX_MAX_CTX_SIZE / sizeof(u64);
 	     word++) {
 		*(u64 *)((u8 *)&aq_rsp.cq + word * 8) &=
 			(*(u64 *)((u8 *)&aq_req.cq_mask + word * 8));
@@ -1317,7 +1319,7 @@ static int rvu_nix_verify_aq_ctx(struct rvu *rvu, struct nix_hw *nix_hw,
 			(*(u64 *)((u8 *)&aq_req.cq_mask + word * 8));
 	}
 
-	if (memcmp(&aq_req.cq, &aq_rsp.cq, sizeof(struct nix_cq_ctx_s)))
+	if (memcmp(&aq_req.cq, &aq_rsp.cq, NIX_MAX_CTX_SIZE))
 		return NIX_AF_ERR_AQ_CTX_RETRY_WRITE;
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index 0596a3ac4c12..8a66f53a7658 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -370,6 +370,8 @@ struct nix_cq_ctx_s {
 	u64 qsize		: 4;
 	u64 cq_err_int		: 8;
 	u64 cq_err_int_ena	: 8;
+	/* Ensure all context sizes are minimum 128 bytes */
+	u64 padding[12];
 };
 
 /* CN10K NIX Receive queue context structure */
@@ -672,7 +674,8 @@ struct nix_sq_ctx_s {
 struct nix_rsse_s {
 	uint32_t rq			: 20;
 	uint32_t reserved_20_31		: 12;
-
+	/* Ensure all context sizes are minimum 128 bytes */
+	u64 padding[15];
 };
 
 /* NIX receive multicast/mirror entry structure */
@@ -684,6 +687,8 @@ struct nix_rx_mce_s {
 	uint64_t rsvd_31_24 : 8;
 	uint64_t pf_func    : 16;
 	uint64_t next       : 16;
+	/* Ensure all context sizes are minimum 128 bytes */
+	u64 padding[15];
 };
 
 enum nix_band_prof_layers {
-- 
2.34.1


