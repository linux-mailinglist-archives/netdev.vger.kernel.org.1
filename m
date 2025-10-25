Return-Path: <netdev+bounces-232804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA64C08F39
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 12:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FAA4078D8
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 10:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300F42F39B5;
	Sat, 25 Oct 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JTPWXmgJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857931E1C1A
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388444; cv=none; b=ErZdPVtb755Nnx1NQy+qw68UW2lGHkVbEdjp54ddBKEpzUCr8euqqJwlGicylCqjfSkC20mt0zUPEEFP/DnGiGy3GojhJYPzEBwnP0CO3EPP0XhJuT2MmHyS4pxVd4cZfwLqorp/0ISHxxFpJW8EMU6K2BUy6V+1hIdmuHuWCaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388444; c=relaxed/simple;
	bh=Dfan9hoAwoBYo41fmTUPpIyfh4pfz4DTmDmyPaJcYRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmnIPVqO619NNS8TpNWCuIXU/kIompkPfwdzHrQuthiNLuAzFaDzBpLy0q3+9imw6Xo+7IeT80OvCixqfOlWvUPwAUvt5wEVKJS/d9cn3s0O+SjpQgDKuAhU6pzKe4zWsilvOZp37L0W54AlXJyLEgGwwXfUShpj1jpU5YB6VXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JTPWXmgJ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59P8022C613482;
	Sat, 25 Oct 2025 03:33:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=VQYCEbACawmLP25nbc3lTPNMa
	xkPnYLLK4mw84jLdpU=; b=JTPWXmgJphFRUBVZJAjnXXK65D1L7cSspB9JP1ueP
	rNdhXty5qQg6LNVWpljkcyiZ+vq9mi+yNop9iancfoRDBeHXdZrx/njruoR3M0FB
	aVRlt5hgsZ+MIBAABDs7BAmn+BPIq+eICUskxNAy+/63YljaYIHGqRisjvIGIwLc
	AVhHxPBWesNh4s6gQdCNUWa/bGpm588XSI7YYx+ToXTbuNzpuqRkpxj6b/tf0wdW
	c5o2nHBPRpnN8QAzWJDJLqpebbhxuMGV+a+31moPyshtiXMz4nbZO2CE+rqJ2Mwu
	qu7XOxqcOMp4Ljbd+Wnemoyy2Gjppcwzxm89l9CXDsUNQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a0p2g8gyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Oct 2025 03:33:55 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 25 Oct 2025 03:34:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sat, 25 Oct 2025 03:34:07 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 234E25B6921;
	Sat, 25 Oct 2025 03:33:49 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <saikrishnag@marvell.com>, <netdev@vger.kernel.org>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>
Subject: [net-next v4 09/11] octeontx2-af: Accommodate more bandwidth profiles for cn20k
Date: Sat, 25 Oct 2025 16:02:45 +0530
Message-ID: <1761388367-16579-10-git-send-email-sbhatta@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDA5NSBTYWx0ZWRfXzLaQ8VzQ/is6
 7eImuYUaymVn5W5TbZYPBRoDWTRndy1eyn1QIi/AGAf5HLrC2652EUg3FalEzmNqf2DuCepsiPX
 jAftqlkaIXjRBvu0V5v3BKnDJoe2RDp+ycy5yBqUFwDGOneUknvcuz5ZcQGd1QPp8QtPR0t0iqx
 siFxgrvZy7CwGF2x8gPnYzn74+gPTMjPyPOL9cQ3m/lQ7oOsAsw2xdRtrajJgL5vKSSwHCz9Xxs
 ovUq2TOyyW/u7tICtfVvpUBqfe5jH1sU0JcKSxRlcD/7V2DatFyO8b6EhGpNrKd9qWI4hFPWqTy
 itrFdQyUcHtkRk6tcW3UafKI8MDZMoKPMXvELOd64AhDRRxmYWnHVFQenyea2YBp34Xlm3c30YI
 LZF1iYeZxKZ/B8WpnPdWoCX9LcU/tA==
X-Proofpoint-ORIG-GUID: 5bpuTRud4KzKZ_AWehdPdyvnqta1MBe2
X-Authority-Analysis: v=2.4 cv=Bt6QAIX5 c=1 sm=1 tr=0 ts=68fca793 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=nMhyOuyHttxo1UZp52UA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 5bpuTRud4KzKZ_AWehdPdyvnqta1MBe2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_03,2025-10-22_01,2025-03-28_01

CN20K has 16k of leaf profiles, 2k of middle profiles and
256 of top profiles. This patch modifies existing receive
queue and bandwidth profile context structures to accommodate
additional profiles of cn20k.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 22 ++++++++++++++-----
 .../marvell/octeontx2/af/rvu_struct.h         |  6 +++--
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index d156d124f079..2f485a930edd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -5818,6 +5818,8 @@ static void nix_ipolicer_freemem(struct rvu *rvu, struct nix_hw *nix_hw)
 	}
 }
 
+#define NIX_BW_PROF_HI_MASK	GENMASK(10, 7)
+
 static int nix_verify_bandprof(struct nix_cn10k_aq_enq_req *req,
 			       struct nix_hw *nix_hw, u16 pcifunc)
 {
@@ -5856,7 +5858,8 @@ static int nix_verify_bandprof(struct nix_cn10k_aq_enq_req *req,
 		return -EINVAL;
 
 	ipolicer = &nix_hw->ipolicer[hi_layer];
-	prof_idx = req->prof.band_prof_id;
+	prof_idx = FIELD_PREP(NIX_BW_PROF_HI_MASK, req->prof.band_prof_id_h);
+	prof_idx |= req->prof.band_prof_id;
 	if (prof_idx >= ipolicer->band_prof.max ||
 	    ipolicer->pfvf_map[prof_idx] != pcifunc)
 		return -EINVAL;
@@ -6021,8 +6024,10 @@ static int nix_ipolicer_map_leaf_midprofs(struct rvu *rvu,
 	aq_req->op = NIX_AQ_INSTOP_WRITE;
 	aq_req->qidx = leaf_prof;
 
-	aq_req->prof.band_prof_id = mid_prof;
+	aq_req->prof.band_prof_id = mid_prof & 0x7F;
 	aq_req->prof_mask.band_prof_id = GENMASK(6, 0);
+	aq_req->prof.band_prof_id_h = FIELD_GET(NIX_BW_PROF_HI_MASK, mid_prof);
+	aq_req->prof_mask.band_prof_id_h = GENMASK(3, 0);
 	aq_req->prof.hl_en = 1;
 	aq_req->prof_mask.hl_en = 1;
 
@@ -6031,6 +6036,8 @@ static int nix_ipolicer_map_leaf_midprofs(struct rvu *rvu,
 				       (struct nix_aq_enq_rsp *)aq_rsp);
 }
 
+#define NIX_RQ_PROF_HI_MASK	GENMASK(13, 10)
+
 int rvu_nix_setup_ratelimit_aggr(struct rvu *rvu, u16 pcifunc,
 				 u16 rq_idx, u16 match_id)
 {
@@ -6062,7 +6069,8 @@ int rvu_nix_setup_ratelimit_aggr(struct rvu *rvu, u16 pcifunc,
 		return 0;
 
 	/* Get the bandwidth profile ID mapped to this RQ */
-	leaf_prof = aq_rsp.rq.band_prof_id;
+	leaf_prof = FIELD_PREP(NIX_RQ_PROF_HI_MASK, aq_rsp.rq.band_prof_id_h);
+	leaf_prof |= aq_rsp.rq.band_prof_id;
 
 	ipolicer = &nix_hw->ipolicer[BAND_PROF_LEAF_LAYER];
 	ipolicer->match_id[leaf_prof] = match_id;
@@ -6100,7 +6108,10 @@ int rvu_nix_setup_ratelimit_aggr(struct rvu *rvu, u16 pcifunc,
 		 * to different RQs and marked with same match_id
 		 * are rate limited in a aggregate fashion
 		 */
-		mid_prof = aq_rsp.prof.band_prof_id;
+		mid_prof = FIELD_PREP(NIX_BW_PROF_HI_MASK,
+				      aq_rsp.prof.band_prof_id_h);
+		mid_prof |= aq_rsp.prof.band_prof_id;
+
 		rc = nix_ipolicer_map_leaf_midprofs(rvu, nix_hw,
 						    &aq_req, &aq_rsp,
 						    leaf_prof, mid_prof);
@@ -6222,7 +6233,8 @@ static void nix_clear_ratelimit_aggr(struct rvu *rvu, struct nix_hw *nix_hw,
 	if (!aq_rsp.prof.hl_en)
 		return;
 
-	mid_prof = aq_rsp.prof.band_prof_id;
+	mid_prof = FIELD_PREP(NIX_BW_PROF_HI_MASK, aq_rsp.prof.band_prof_id_h);
+	mid_prof |= aq_rsp.prof.band_prof_id;
 	ipolicer = &nix_hw->ipolicer[BAND_PROF_MID_LAYER];
 	ipolicer->ref_count[mid_prof]--;
 	/* If ref_count is zero, free mid layer profile */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index 8d41cb8f85ef..8e868f815de1 100644
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
@@ -757,7 +758,8 @@ struct nix_bandprof_s {
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
2.48.1


