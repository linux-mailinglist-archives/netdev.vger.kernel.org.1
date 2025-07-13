Return-Path: <netdev+bounces-206440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D313B031CC
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 17:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7541D3B8AFF
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1474327FD52;
	Sun, 13 Jul 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ak7C/tQV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691FB27F736
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420730; cv=none; b=DEIPPFrSkys4iJoHJZBF/rxNe+XgoElb3+7G1RvTPtkFbCfD/Ms2h0WGfVRfGc3I+LJwGBMiTaP6D+qHtTBPNArTPLo8qIqOHgzU2bvwYIrezFkXsEBo2P/BlB01hR+/EDc38nN2zotwirCvScDDsgGHVOF6L1VRKA2jjAp/8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420730; c=relaxed/simple;
	bh=NM+3GA3x6lVLN2uEoD5A1esZdvh2ib+qSF+SSu0iwyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDu2Cj+ciD/ji5jylXpIwZ1GwQyofYuJ0HXpSy6etjzhcv9c7DqdcL4AIorhk42HSHaGM3opZ8uZV/6h/oHVOFVKJMdHQjuZrrxANCP0h/0VYIOQ/eiLFRlIinfljId7Bm/oR+XgYmXG6C8p1FVZnHlkSLImXx+p8q1TqOPPFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ak7C/tQV; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DFEWJ1003595;
	Sun, 13 Jul 2025 08:32:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=zIIdm7hkyyJKEhEugrYYVIcCP
	71+dNe4r9ADNgGBXZY=; b=Ak7C/tQVSVuRHQSQJNsVO4Kf+X6q2KNJzsuOV+3Cn
	Tgr1pse+4qz7aoJLk5aGRigCBeIKu0dQUrFgq9Ux/syLKkkIPqRJoQGpea3xx8+5
	63QBHyv6l7L2wOMFDtMsg/sxpF07arevvcZ/lVsaUIkqkZTiEwkKkU3ideFNRSjj
	1KRG+DdJTDnNqBuKNziF99703rMA+A8AY41jczRQaGQSoINakckoIIfY7El8L3HD
	1Ll+EZndDBPYbLfJSqQnncf1+UD3/S3hg4KSN7nEd3ilEH5aA3ztIic/fPV3m62m
	Dw3Js4bxbMfH66hIBEvu6mR5hdm3sgAeEqnztutujxovw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47v1farvja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 08:32:02 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 13 Jul 2025 08:32:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 13 Jul 2025 08:32:01 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id E00BD5B6941;
	Sun, 13 Jul 2025 08:31:56 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH 09/11] octeontx2-af: Accommodate more bandwidth profiles for cn20k
Date: Sun, 13 Jul 2025 21:01:07 +0530
Message-ID: <1752420669-2908-10-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=N48pF39B c=1 sm=1 tr=0 ts=6873d172 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=5DSQ5fXoH_NhW3BsuyUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: xIhAEtB3P10Pz8ExxIDllCpqhOD7yx7y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDEwOCBTYWx0ZWRfXw1vf4ooQzdzA pr1zMdtsNaw54Ql6nqi7GlsQOrXtE7VSzxiDtWxJ2vACt0AVbl8Eu388domxW+Z23OasHWaXo+G nIkI+uf6B9Y7Hh9Yo75SKlx+4WQ36O0mdrXQAtuokjKJlkcGs/nsC8wdm1C3A34GUyHDIEjscG0
 VV6P2mZ/j/monqpbZUsWsmFee+O3rEohYLNdcnSuDMAa7TlRHTHULCb3xiRpoAOnj7d5sDxKAbp yjcNoiGTNPWIOO/NVj9cEzT/HQMhe6Y63Uc4KM+TkysWeuzjYmNmbUlek5NwIN2lLFPzemGPl8D SwZJL+M6Tfmva0T3gF1sMcMr2sahomcfX/NvflIXebIsB/WWonEUGMmsLPV7IyIZw/4wAZu8QeH
 YTd64+OfSsjvA6NTNmyvlPw3SlnecfsKw1CKrUDPQnL2KNB/+Da0miIWDfCIxKyBcetU3vyh
X-Proofpoint-GUID: xIhAEtB3P10Pz8ExxIDllCpqhOD7yx7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01

CN20K has 16k of leaf profiles, 2k of middle profiles and
256 of top profiles. This patch modifies existing receive
queue and bandwidth profile context structures to accommodate
additional profiles of cn20k.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 13 ++++++++-----
 .../net/ethernet/marvell/octeontx2/af/rvu_struct.h  |  6 ++++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 47a64c4c5b7e..ab3b8b6a9e43 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5858,7 +5858,7 @@ static int nix_verify_bandprof(struct nix_cn10k_aq_enq_req *req,
 		return -EINVAL;
 
 	ipolicer = &nix_hw->ipolicer[hi_layer];
-	prof_idx = req->prof.band_prof_id;
+	prof_idx =  req->prof.band_prof_id_h << 7 | req->prof.band_prof_id;
 	if (prof_idx >= ipolicer->band_prof.max ||
 	    ipolicer->pfvf_map[prof_idx] != pcifunc)
 		return -EINVAL;
@@ -6023,8 +6023,10 @@ static int nix_ipolicer_map_leaf_midprofs(struct rvu *rvu,
 	aq_req->op = NIX_AQ_INSTOP_WRITE;
 	aq_req->qidx = leaf_prof;
 
-	aq_req->prof.band_prof_id = mid_prof;
+	aq_req->prof.band_prof_id = mid_prof & 0x7F;
 	aq_req->prof_mask.band_prof_id = GENMASK(6, 0);
+	aq_req->prof.band_prof_id_h = mid_prof >> 7;
+	aq_req->prof_mask.band_prof_id_h = GENMASK(3, 0);
 	aq_req->prof.hl_en = 1;
 	aq_req->prof_mask.hl_en = 1;
 
@@ -6064,7 +6066,7 @@ int rvu_nix_setup_ratelimit_aggr(struct rvu *rvu, u16 pcifunc,
 		return 0;
 
 	/* Get the bandwidth profile ID mapped to this RQ */
-	leaf_prof = aq_rsp.rq.band_prof_id;
+	leaf_prof = aq_rsp.rq.band_prof_id_h << 10 | aq_rsp.rq.band_prof_id;
 
 	ipolicer = &nix_hw->ipolicer[BAND_PROF_LEAF_LAYER];
 	ipolicer->match_id[leaf_prof] = match_id;
@@ -6102,7 +6104,8 @@ int rvu_nix_setup_ratelimit_aggr(struct rvu *rvu, u16 pcifunc,
 		 * to different RQs and marked with same match_id
 		 * are rate limited in a aggregate fashion
 		 */
-		mid_prof = aq_rsp.prof.band_prof_id;
+		mid_prof = aq_rsp.prof.band_prof_id_h << 7 |
+			   aq_rsp.prof.band_prof_id;
 		rc = nix_ipolicer_map_leaf_midprofs(rvu, nix_hw,
 						    &aq_req, &aq_rsp,
 						    leaf_prof, mid_prof);
@@ -6224,7 +6227,7 @@ static void nix_clear_ratelimit_aggr(struct rvu *rvu, struct nix_hw *nix_hw,
 	if (!aq_rsp.prof.hl_en)
 		return;
 
-	mid_prof = aq_rsp.prof.band_prof_id;
+	mid_prof = aq_rsp.prof.band_prof_id_h << 7 | aq_rsp.prof.band_prof_id;
 	ipolicer = &nix_hw->ipolicer[BAND_PROF_MID_LAYER];
 	ipolicer->ref_count[mid_prof]--;
 	/* If ref_count is zero, free mid layer profile */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index 0596a3ac4c12..12899191c426 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -413,7 +413,8 @@ struct nix_cn10k_rq_ctx_s {
 	u64 rsvd_171		: 1;
 	u64 later_skip		: 6;
 	u64 xqe_imm_size	: 6;
-	u64 rsvd_189_184	: 6;
+	u64 band_prof_id_h	: 4;
+	u64 rsvd_189_188	: 2;
 	u64 xqe_imm_copy	: 1;
 	u64 xqe_hdr_split	: 1;
 	u64 xqe_drop		: 8; /* W3 */
@@ -736,7 +737,8 @@ struct nix_bandprof_s {
 	uint64_t rc_action                   :  2;
 	uint64_t meter_algo                  :  2;
 	uint64_t band_prof_id                :  7;
-	uint64_t reserved_111_118            :  8;
+	uint64_t band_prof_id_h              :  4;
+	uint64_t reserved_115_118            :  4;
 	uint64_t hl_en                       :  1;
 	uint64_t reserved_120_127            :  8;
 	uint64_t ts                          : 48; /* W2 */
-- 
2.34.1


