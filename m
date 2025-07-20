Return-Path: <netdev+bounces-208445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4314BB0B6FF
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 18:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41E41899ED2
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179CD22424C;
	Sun, 20 Jul 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PfcIHmjK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED71222566;
	Sun, 20 Jul 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029433; cv=none; b=me6TmuWpF1ddHcrtgXlEvM2wLBKKAsMwEes6frcaQtxuCENuaoF2CfTxQ4vVfC8kiIbJzbWw9Vy9b2jUMymbtMQ6J//796utnweuHGgPC5Llo1EE/DYFTYdiK0X91gmOvPC+gpMMz3CMkeX1n8I74sV1Fpum01Dzc+b9pA3xm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029433; c=relaxed/simple;
	bh=GvdjHBwkgvGUTu7XqJ9QM9rQq+On1dFLb6PWF0UI71I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fP140A0huX+8ufd7EFzMXauX5V13EOdcd/ie1+0KmvGXEPW08jvHvHCMwjy4dDXXtGlb0mn6f1PV2I3xzYuzXIejpg0jsFgdYBmrbVCtqZGJtgAB80aDw2o/NZePG15rm/Wbe0lDJu1fI79+hcCj+lhuYAa7ZIcFlxEIMwOTdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PfcIHmjK; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KGBYsb016791;
	Sun, 20 Jul 2025 09:36:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
	TTZmDhypgw3Ea7UFL2v6lVf3KSwStxTu1erLyFa3+o=; b=PfcIHmjKOb07/Gs6a
	zAOmc9prQOCxCyXvRW+QnLK02w0vST+IXIwzqOioAK0Ct3/+89ArTzcjYEqq1+eN
	QT0qhGbmge6u8VkxwumdT24HQ/N2MexAsG5uRZDiudcEXE0zVUbfSkEqnKZwJ3Ti
	l6mTKi1MlIturaVXey26YbqU/MrHPKShyizhcrUIr+dl2KAWxZMjDexlK+wxfzka
	YqoOCElzJcIWvH4AAztwuKYMg58QQXCgfZpI6bJlAxu8hz2IBKHGZXIHivuzY1RM
	of7M35sBvcHeuxxDpSd+arQK3IoxGrYJMcuUyByp1yh7JN46wIJdq6PMO0Cg5pA8
	g9Ssg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4808qq1tk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 09:36:50 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 20 Jul 2025 09:36:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 20 Jul 2025 09:36:49 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id CD7DD3F7057;
	Sun, 20 Jul 2025 09:36:44 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <naveenm@marvell.com>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        <bbhushan2@marvell.com>
Subject: [net-next PatchV2 1/4] Octeontx2-af: Add programmed macaddr to RVU pfvf
Date: Sun, 20 Jul 2025 22:06:35 +0530
Message-ID: <20250720163638.1560323-2-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250720163638.1560323-1-hkelam@marvell.com>
References: <20250720163638.1560323-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDE2MCBTYWx0ZWRfX7mslaKeZfFjU LiERPHB4DMbJ9CofZg91PSmNcoHSFPrul5Rzm5cQEBFyQKaAC6Ys/kZ6dfwYwYc10vWiPPcXKlY H+/jhvU62aT5nypthd53aOhdrCnSSFYyxAYF2rLlE3MOUYxw7IY127ZmHUyQSQRhBJ6FXUuoO9G
 w3TV8rJ9IE3EiGkke93zpUWpzDuHiBfi4jwZeHWn1ptTEvkNeegbuGXBTLlJ3HGXnmPWFOehULL /MrfOi/vs2NxGGTUNUJjU4gy2Zin+ynXS0rkwouEhYWBMd4kWgn2DGAfXzDC0HZJfJfzMwR8vTc 1MbEGGdwT+R7zPWZiCHs4q0JlkMgosuCJWGIft7mILQVJdjxANsiDp9ac/YrUrCohFIqP8+c1+Z
 RavUmC1tj+kyn0ZH896hiaPR8WkQAYhkp4D2SlE6Rh2P51FfiXBGpTSjcmUl2k6ERW4xBQky
X-Proofpoint-GUID: nejEfzWZg0vKYeRquqKy1btIdtCGBjT_
X-Proofpoint-ORIG-GUID: nejEfzWZg0vKYeRquqKy1btIdtCGBjT_
X-Authority-Analysis: v=2.4 cv=TuLmhCXh c=1 sm=1 tr=0 ts=687d1b22 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=L-R8ID7CKs2bE2q17uEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01

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
v2 * Use  ether_addr_copy instead of memcpy

 .../ethernet/marvell/octeontx2/af/rvu_cgx.c   | 23 ++++++++-----------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
index 890a1a5df2de..3303c475414a 100644
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
+	ether_addr_copy(pfvf->mac_addr, req->mac_addr);
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
+	ether_addr_copy(rsp->mac_addr, pfvf->mac_addr);
 	return 0;
 }
 
-- 
2.34.1


