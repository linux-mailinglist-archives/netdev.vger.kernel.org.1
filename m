Return-Path: <netdev+bounces-207543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF36B07B61
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3712586C3E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FB22F5499;
	Wed, 16 Jul 2025 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I9gq84Oa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853012F5491;
	Wed, 16 Jul 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684155; cv=none; b=CNPrrnHdVzKckDKYHKy/1RybJXIs03Mu/vr3NNE9dHoYFJcYaqJbsYKF5K5i8288ym5LhG8ZnQdfpLAQA6JNvX2Sj25fKSsvqoA8Q4SyAJpLdtMjt4ZPspZYWW154Q2TdNDw8f+/edKQVGpk44eC4w38GpDIojula1HoxQ1DbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684155; c=relaxed/simple;
	bh=UYkP73h9y2LxNsBZNm45up0Qr1MYNUs51hYbx0RZDds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4tHJyaiDCbLq0K+34ipd3DYUtOtArNxJKHeMxd4tqNKBakFkCIn++jWBraij7lmKNgyupR+cC1yLaHdS/KTqZ7zz4eHIiOnyLswiaHHQOk+pxehY8v+XbBo4yZ/ciZ7gzBITzpw7mR1IzRIaotzZkGieVsE9B72TfTlNdRwT4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=I9gq84Oa; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GG1nea010782;
	Wed, 16 Jul 2025 09:42:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=1
	qu4/E9dpMpF3pwu+KUnUJ0qjtHjKBZk5eN14S2ETos=; b=I9gq84Oakpye0l9M1
	bit/IVCbivnYqLu5PQbthQQ+i0Msh8uH+2NIsu/t8v98NWjgzQF5WfY799d8FG6o
	6WDDv8A2eXMtImyAHhyGbZ1FR5ARnGGay5/hUYxImjoYVyAFnWdTNKigrcIW6Fod
	ZAVLbewUKqvepl/5lOwE8M+5M7v6DljHxd0cx3OYA4hEcANMtVDOw7MGqVM6j4EI
	M47GemvUKSi7kw3Q8e7QhceN601ZFUK7TkAT8/Ea4Nq7Hl4o/+MJkej06AUmOFT+
	ay+tGUhh2mmGRZ03EILIpGD1CY9lAMidHV2iTPJxVLfY4IJmH5ShYglQl0bKPgiN
	bZPhA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47x8dthma5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 09:42:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Jul 2025 09:42:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Jul 2025 09:42:09 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id E8F863F7062;
	Wed, 16 Jul 2025 09:42:04 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next 1/4] Octeontx2-af: Add programmed macaddr to RVU pfvf
Date: Wed, 16 Jul 2025 22:11:55 +0530
Message-ID: <20250716164158.1537269-2-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716164158.1537269-1-hkelam@marvell.com>
References: <20250716164158.1537269-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1MCBTYWx0ZWRfX3WTbIlLF0Tlq wDhd+9mjXixAjvXwmYID+39/4/lrBQ9Ncvo/9pOJF66a77wzZYWmyaWmt0c3ISdaOu2ehVHdt70 MpxKHpgtqtcvwWG0587xMvD2ZHw9tnPgaF+lOJEiywzbJDJW04EfNfMyzjJ6VccY9aOqjsf0fuK
 5r8qeto+nK0fJ9YX47t3d8W0oIOTba0kjs/nKe8ZmQrFDkFuMqHdfmlBmYMr73N12wbTZglP3ln Qq+nt0BIYqhKI7/ns/aFpsCbcSRO/arKypuHY+SCuaI1Qp/ZgB2YyxyugtwMcRU5dxRCJCbrBGf rT+qomviH0dm0OLLianCrBCh/bK1hXp42V0mTnlHckMx89JDVrgXzW+1JVJeR9ipjzGk6ayy3g8
 j9m5pJES5l/htsNf3YW3dAt9jklIdEbVUX55Inlq3+sEbzv7wigwO+DElHqXBrF3cRea4tb5
X-Proofpoint-GUID: ttiw2CEh22oLj92Pfq2bF6-Exqd7hlkc
X-Authority-Analysis: v=2.4 cv=N90pF39B c=1 sm=1 tr=0 ts=6877d662 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=L-R8ID7CKs2bE2q17uEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ttiw2CEh22oLj92Pfq2bF6-Exqd7hlkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01

Octeontx2/CN10k MAC block supports DMAC filters. DMAC filters
can be installed on the interface through ethtool.

When a user installs a DMAC filter, the interface's MAC address
is implicitly added to the filter list. To ensure consistency,
this MAC address must be kept in sync with the pfvf->mac_addr field,
which is used to install MAC-based NPC rules.

This patch updates the pfvf->mac_addr field with the programmed MAC
address and also enables VF interfaces to install DMAC filters.

Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 890a1a5df2de..dd589f9b10da 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
@@ -682,16 +682,19 @@ int rvu_mbox_handler_cgx_mac_addr_set(struct rvu *rvu,
 				      struct cgx_mac_addr_set_or_get *rsp)
 {
 	int pf = rvu_get_pf(rvu->pdev, req->hdr.pcifunc);
+	struct rvu_pfvf *pfvf;
 	u8 cgx_id, lmac_id;
 
-	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
+	if (!is_pf_cgxmapped(rvu, pf))
+		return LMAC_AF_ERR_PF_NOT_MAPPED;
 
 	if (rvu_npc_exact_has_match_table(rvu))
 		return rvu_npc_exact_mac_addr_set(rvu, req, rsp);
 
 	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 
+	pfvf = &rvu->pf[pf];
+	memcpy(pfvf->mac_addr, req->mac_addr, ETH_ALEN);
 	cgx_lmac_addr_set(cgx_id, lmac_id, req->mac_addr);
 
 	return 0;
@@ -769,20 +772,12 @@ int rvu_mbox_handler_cgx_mac_addr_get(struct rvu *rvu,
 				      struct cgx_mac_addr_set_or_get *req,
 				      struct cgx_mac_addr_set_or_get *rsp)
 {
-	int pf = rvu_get_pf(rvu->pdev, req->hdr.pcifunc);
-	u8 cgx_id, lmac_id;
-	int rc = 0;
-	u64 cfg;
+	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
 
-	if (!is_cgx_config_permitted(rvu, req->hdr.pcifunc))
-		return -EPERM;
-
-	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
+	if (!is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, req->hdr.pcifunc)))
+		return LMAC_AF_ERR_PF_NOT_MAPPED;
 
-	rsp->hdr.rc = rc;
-	cfg = cgx_lmac_addr_get(cgx_id, lmac_id);
-	/* copy 48 bit mac address to req->mac_addr */
-	u64_to_ether_addr(cfg, rsp->mac_addr);
+	memcpy(rsp->mac_addr, pfvf->mac_addr, ETH_ALEN);
 	return 0;
 }
 
-- 
2.34.1


