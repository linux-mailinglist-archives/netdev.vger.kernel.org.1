Return-Path: <netdev+bounces-206432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F85B031C2
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 17:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF03F7AA136
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C127F003;
	Sun, 13 Jul 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MOiOz+w6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA217279917
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420707; cv=none; b=W+c00DLR6srh7mRAjc3WyXe2SOnHRFspO9d50NhZNg9/lWXP5pLv3m1KXtjKpYUIrCMJxDfd6MUprSd79HixmZ1b7wkIrWnQMcKOnc+jb5GZHpfH/btg6s0+/HJoGEiJztZ9jIyaW4fxHUi4ObvelyBwyWR7Zts0TMzju86nTWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420707; c=relaxed/simple;
	bh=zGOS/+cgKXW43OPnF9/v7kDSxT4mQ+VqkOY+nqIbahU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nn3IoBZ/gFSFnjBpqyiRjDuUwVwSEi+FJiai5axtByaLeRXqwOb4Bm9JnHtVrqDJBK/EdKcdvkl/9NoiZJMBpB4F7zDUCYHreCs5vR+K1Ez0nmHfgt9clZdRwqSnB8SXG4oLCuuJDAAJOEgxxvfNA0eDUkao9h1g69ZrEP7Rd9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MOiOz+w6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DFQta8029376;
	Sun, 13 Jul 2025 08:31:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Qm5pZXMduLKbqHhSUZxu6rchw
	QyPgTu7QcFJSogRW08=; b=MOiOz+w6c8zL51dt7i4/ogRy/zH6Fg1HJizG4fsF7
	PQgfCt4ekGvcpoUmjaA3E2bEhTPxY1oXtdtZsVzA3XRhozD8QRAu7QDrQ8lyl8/W
	ITKsrxFY6KCK8TxQMJSnZTwXcX8GRwB8wIJMRZk9eE2GRrA4Ct84/3n7k7X4KKc6
	KtMrqiPw553FCmfHDAhPmMCSbBWAnk3D9Tl0u0KYvzrrRndGChH+W0hTKwzE/TYO
	oVgKoOhgWqazHNL3elVbjIEWeA1y8cc554Z7yTcL9Hcd7PuZJbRiLfjHeGEitHlT
	hRxJK90fK+F1wbU/H2QoYHZcZRNCq2KLr8wRWk7s9fd9g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47vbyd86h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 08:31:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 13 Jul 2025 08:31:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 13 Jul 2025 08:31:24 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 034855B6941;
	Sun, 13 Jul 2025 08:31:19 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 01/11] octeontx2-af: Simplify context writing and reading to hardware
Date: Sun, 13 Jul 2025 21:00:59 +0530
Message-ID: <1752420669-2908-2-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDEwOCBTYWx0ZWRfX9tfOJbmraJiM zlknF+QDFuK+9EMW9SbhzU0Ma8UwOUAlEKBCORan6M6xp5M9U7VazX5QWGB6gaIPCakW5jxMpCO A8WOVyw4xNoyO+MwelVeK45EpijpEqLaaHB50JMRNzvgFzKZvPqo18uVFgaRqf53R/5bB25kJFG
 N6cWxluqwXceU/oXVAk83Fa6j7OR3u/0dxywfBbzd9aPFbl9vwqyWSJx0IOofZs56oamfj/veEB 28Ls/9BWeJcxlQOD9o/GL+9LB+GMtyG6FiIjhuf4JXnPgA2ywgVZ81BhJc7ehEOT6dia3NW/srb cq0lVTaqSAjNwTkvr1m4FwAqUiBOdxw2EIF+04O5v5mn6715nOmCPY3Ph2HMh7RKABGqcBKQi61
 ACy/ebCRCh9XafDREdUINCCBcr6cG+GUzXTotZx7V431c/zIin7RTV73gJgHDtcwGkuxTjvV
X-Proofpoint-GUID: dFZBo_LLmQ3hh3zQTdvcC0fErTVAQq28
X-Proofpoint-ORIG-GUID: dFZBo_LLmQ3hh3zQTdvcC0fErTVAQq28
X-Authority-Analysis: v=2.4 cv=C+TpyRP+ c=1 sm=1 tr=0 ts=6873d14d cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=FJ1_8QKiwqmaIeHmKokA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01

Simplify NIX context reading and writing by using hardware
maximum context size instead of using individual sizes of
each context type.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 46 ++++++++++---------
 1 file changed, 24 insertions(+), 22 deletions(-)

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
-- 
2.34.1


