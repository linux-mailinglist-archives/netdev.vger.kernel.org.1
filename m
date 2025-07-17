Return-Path: <netdev+bounces-207973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C7B092D2
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337601C465E1
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D992FE383;
	Thu, 17 Jul 2025 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iXjSbZUd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EDF2FE370
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772224; cv=none; b=nqmVh3NzdkvgDMzviM+O1Lf0tOTLreAUuJESGMytq2BLSlNOQEf5BDpCUrMjUaP7xrM0249yJCZp6l2ILFXpVdB8vD3lLdyG7knOfTHGtG3CQMB76IGpTcGPGN2Mxje3+Zyq/6U7cmyxjuCRXTkqarRDd5xlo6OQu7NNAkrt2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772224; c=relaxed/simple;
	bh=2EFWBDTlg/oTgc8nPsMY3pOnxh7eEfOBmNidydIeAjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rynkVsL7qhx5idN7pcAAL3Pw4R0kTZ7P5/CJLaAaIuNF28DZOd/IN2fsHrSNAd7K9e5zkBMnrevD3d9UBqid5OmBRIzwowDqamTpC2haq4iXY4RK2Ej1czAohT3bOfbN+URrfm6oPh+o0h+4ZgYQDcoLVj+VJKwlDapnZ/IkxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iXjSbZUd; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H9e6wt019619;
	Thu, 17 Jul 2025 10:10:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=bk0BzEq7FQj0RYhfNrquFLLDb
	1ypj9rFrf/SxpblwNo=; b=iXjSbZUdB3ghTYgkYVSA7r9636lWR9W3yGpS2tCiW
	bpkRBg2WdwCLGrs0ECOLWzlIFcW5G/UAEH6R4EJDK/gPfEJMKSRaRzc5MGDhMbYA
	OUYRb04cQGtGxwcRo9fa6r4R/MlfIuU9HvLszAOs/PksN5ovUFzNNaOtpMoRgkZs
	f9Yj0M700sYolmEX3wwXco4BU+OaVYovTku0MmCx3BHq66cL15554uOgofX+s+IG
	9/UV6Y9PLoOsWXce4dD8n7FqXsO3ahMOpwYzl8PSlU0nOJ+6IUFaI14+ZjtEUIFi
	oSTlltTkQGrOGIhFjH4JVfdGFPQLG1/5rms/K/yZjyyEQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47xvpc96tu-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:10:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 17 Jul 2025 10:10:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 17 Jul 2025 10:10:12 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 7994E3F7053;
	Thu, 17 Jul 2025 10:10:08 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v3 09/11] octeontx2-af: Accommodate more bandwidth profiles for cn20k
Date: Thu, 17 Jul 2025 22:37:41 +0530
Message-ID: <1752772063-6160-10-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=U8ySDfru c=1 sm=1 tr=0 ts=68792e76 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=5DSQ5fXoH_NhW3BsuyUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 3BQrr14qdo8GsCBNsYR8aCV7JXGJideK
X-Proofpoint-ORIG-GUID: 3BQrr14qdo8GsCBNsYR8aCV7JXGJideK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MiBTYWx0ZWRfX8OyyNHDRY5e2 BpVAC5RmIGcY01x1sD2nR3IPTjAN4VOuK9guHagdXDBe6rC/6Ka33wsx0VaNnNWjbOwc+uG+wjJ JgziIWrHflhvHxfpkNsiBvcdIEiFKXHENp2qCrntb8ChwyBcaltT6PcayK4gMNBIY4ke3Sqm5S5
 CgKeI2qQh0mW94B313aC+IIQW6uYct5A4Iqx92qvSd7LrLZQxEng6q6lerEUcaPEQXhO1nQ/k0A wig2wmqNBXiiXngcKoAWToKCrIKxOM9Tl7fYn/44uCyHf3dNYAX3Z6bscKsdc80d7awlh4J+uBc sMy6mE6mHdMBbQ2wSTGc1IKJWSAZZHZlEu9pqogBsEGU4y29JxtPIZMGAe4SCpLKlkFTZMai0Np
 GZmDiyvtOy/1V4pTFNa0VZAZ86oc8cTatu08va6LYuSTNVXJMxXRLaqfodEUZiUvh2Pixfi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01

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
index 162283302e31..f6ecdb4b5ff9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5856,7 +5856,7 @@ static int nix_verify_bandprof(struct nix_cn10k_aq_enq_req *req,
 		return -EINVAL;
 
 	ipolicer = &nix_hw->ipolicer[hi_layer];
-	prof_idx = req->prof.band_prof_id;
+	prof_idx =  req->prof.band_prof_id_h << 7 | req->prof.band_prof_id;
 	if (prof_idx >= ipolicer->band_prof.max ||
 	    ipolicer->pfvf_map[prof_idx] != pcifunc)
 		return -EINVAL;
@@ -6021,8 +6021,10 @@ static int nix_ipolicer_map_leaf_midprofs(struct rvu *rvu,
 	aq_req->op = NIX_AQ_INSTOP_WRITE;
 	aq_req->qidx = leaf_prof;
 
-	aq_req->prof.band_prof_id = mid_prof;
+	aq_req->prof.band_prof_id = mid_prof & 0x7F;
 	aq_req->prof_mask.band_prof_id = GENMASK(6, 0);
+	aq_req->prof.band_prof_id_h = mid_prof >> 7;
+	aq_req->prof_mask.band_prof_id_h = GENMASK(3, 0);
 	aq_req->prof.hl_en = 1;
 	aq_req->prof_mask.hl_en = 1;
 
@@ -6062,7 +6064,7 @@ int rvu_nix_setup_ratelimit_aggr(struct rvu *rvu, u16 pcifunc,
 		return 0;
 
 	/* Get the bandwidth profile ID mapped to this RQ */
-	leaf_prof = aq_rsp.rq.band_prof_id;
+	leaf_prof = aq_rsp.rq.band_prof_id_h << 10 | aq_rsp.rq.band_prof_id;
 
 	ipolicer = &nix_hw->ipolicer[BAND_PROF_LEAF_LAYER];
 	ipolicer->match_id[leaf_prof] = match_id;
@@ -6100,7 +6102,8 @@ int rvu_nix_setup_ratelimit_aggr(struct rvu *rvu, u16 pcifunc,
 		 * to different RQs and marked with same match_id
 		 * are rate limited in a aggregate fashion
 		 */
-		mid_prof = aq_rsp.prof.band_prof_id;
+		mid_prof = aq_rsp.prof.band_prof_id_h << 7 |
+			   aq_rsp.prof.band_prof_id;
 		rc = nix_ipolicer_map_leaf_midprofs(rvu, nix_hw,
 						    &aq_req, &aq_rsp,
 						    leaf_prof, mid_prof);
@@ -6222,7 +6225,7 @@ static void nix_clear_ratelimit_aggr(struct rvu *rvu, struct nix_hw *nix_hw,
 	if (!aq_rsp.prof.hl_en)
 		return;
 
-	mid_prof = aq_rsp.prof.band_prof_id;
+	mid_prof = aq_rsp.prof.band_prof_id_h << 7 | aq_rsp.prof.band_prof_id;
 	ipolicer = &nix_hw->ipolicer[BAND_PROF_MID_LAYER];
 	ipolicer->ref_count[mid_prof]--;
 	/* If ref_count is zero, free mid layer profile */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index 1097c86fdc46..da23a0b5dd6d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -419,7 +419,8 @@ struct nix_cn10k_rq_ctx_s {
 	u64 rsvd_171		: 1;
 	u64 later_skip		: 6;
 	u64 xqe_imm_size	: 6;
-	u64 rsvd_189_184	: 6;
+	u64 band_prof_id_h	: 4;
+	u64 rsvd_189_188	: 2;
 	u64 xqe_imm_copy	: 1;
 	u64 xqe_hdr_split	: 1;
 	u64 xqe_drop		: 8; /* W3 */
@@ -749,7 +750,8 @@ struct nix_bandprof_s {
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


