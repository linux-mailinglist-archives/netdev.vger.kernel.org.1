Return-Path: <netdev+bounces-207227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD9FB064D6
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00CB5677B8
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2244727BF89;
	Tue, 15 Jul 2025 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GfljBBTL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23B2417F8
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598991; cv=none; b=bwkd4paK37pKgWz1Nev9xI3NGmpi8ijCKFkvU5ZEmLmWIVqq7qzzoE1PSCYXjDwSbZ4S8pMG8TTNRmE6kxdaxSMBNFD2Pd03T3lh2PvQ8XDYkNo1qa7FwZohew7Ub3ORDzPZ758dUrjXBtALd9EtcAPzowEDViQfpX2sHqdSgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598991; c=relaxed/simple;
	bh=aKIOh7bYIQ8ypAKRCh2DAj4oISDxa5UFqCxg/sDFzXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cH21AsiPrGjC/wA6tRpWV9fHVTI7loLfrYI9Y4knL7ThZ6MQN+nGQ74AWfF/PkQCvS9qvlF0kMqfSG357fPROOY7GYaJYe47sNbJ7DjP03qLFJH8BCpknqXxWv1vDhILJWRDg+QG5GYVG2DCUmS7qDmJip5/sTZpkRigFcISh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GfljBBTL reason="signature verification failed"; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FEk764000654;
	Tue, 15 Jul 2025 10:03:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=88mU1ooSyFtOFVjV/xXaif3uD
	MKCOQ2FZ8c6ZmvPdfY=; b=GfljBBTLFa88qyXNNXzk3MJdU2ZISjjiyc8xoqjLZ
	7xLGuW/XS39/4Avf32eaaeCceBTmu4eReEBuFPALg6Wv6aHj7dCB1RycO7MtyaB5
	EcoYr3bLaP2VPzw0aI2TEokaJvu9X4JceIR7xuVgnI8tNR9mYCa+yqDQAuv1c2Fh
	FYYc+L6pQSJrXOwFeVtWiURvZiDEv3u00OIapwUIC5+sDbKK2nFl/dteeRGG/aOG
	07duYyc8LZdxmoYQLXM1lDXvvYrL8aZoYvDVC8FUUqaFIELsaXbaNR34/Jj+jAYO
	SiavyACsn5ul/uqSBTas8GlSPSC5d71o/m4+1ifNGAs0A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47wbm52bcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:03:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Jul 2025 10:03:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Jul 2025 10:03:02 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id 0BA805B692E;
	Tue, 15 Jul 2025 10:02:57 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, pabeni4redhat.com@mx0b-0016f401.pphosted.com,
        <horms@kernel.org>
CC: <gakula@marvell.com>, <hkelam@marvell.com>, <bbhushan2@marvell.com>,
        <jerinj@marvell.com>, <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <netdev@vger.kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [net-next PATCH v2 09/11] octeontx2-af: Accommodate more bandwidth profiles for cn20k
Date: Tue, 15 Jul 2025 22:32:02 +0530
Message-ID: <1752598924-32705-10-git-send-email-sbhatta@marvell.com>
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
X-Authority-Analysis: v=2.4 cv=M7tNKzws c=1 sm=1 tr=0 ts=687689c7 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=5DSQ5fXoH_NhW3BsuyUA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 8-mw8I1TWVrYIbis97fmqbd4m12huSVK
X-Proofpoint-ORIG-GUID: 8-mw8I1TWVrYIbis97fmqbd4m12huSVK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NiBTYWx0ZWRfX3OcbuOLiTK7+ A5I8pV9hoTtTSW0I9JJpsWPptNoL8Afs3R1/TFCkq2Jyj4AxYs+P3OKzoFE1VHhI7vqD0hFlBE3 rDytPKsBezm5PHPjS1odlWan/qSSBRY3Bc0xWPptUdt2gfZNpKuDS4L3Tno2BN3CQkZ3RaoBnZa
 N0iumAc2E+1WbJBq14dbRuF7QJVaslYpxxuqZhsDJUFE64XqnWfknoSpZr2cg79ua4oFdoAloY/ i/FTCNkUL+mCL2jPb490+xPJvbrOr1tmSbCRzwW8jgRX6zpiQm5NsioyKtR7QRhs8Ksrr2/FzGP wmiK5So0fQ6acrCuCcxmZpNFxVj0TK8nOiEqO76SzhZhjydI3ZqT8zy4f+bxblHoWMXznTVyztk
 GaeYmcJSi0p0ZvwJuq+5ziwSU8b9hHUziOAKxXGpwYok88Benc0WrBcaOG7Dpm03MWqYKpma
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01

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
index 8a66f53a7658..1060ef0caf9c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -415,7 +415,8 @@ struct nix_cn10k_rq_ctx_s {
 	u64 rsvd_171		: 1;
 	u64 later_skip		: 6;
 	u64 xqe_imm_size	: 6;
-	u64 rsvd_189_184	: 6;
+	u64 band_prof_id_h	: 4;
+	u64 rsvd_189_188	: 2;
 	u64 xqe_imm_copy	: 1;
 	u64 xqe_hdr_split	: 1;
 	u64 xqe_drop		: 8; /* W3 */
@@ -741,7 +742,8 @@ struct nix_bandprof_s {
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


