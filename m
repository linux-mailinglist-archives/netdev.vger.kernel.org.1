Return-Path: <netdev+bounces-119712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A74956AED
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E961F2108E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8456516728B;
	Mon, 19 Aug 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WN6TQy38"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB81487FE;
	Mon, 19 Aug 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070773; cv=none; b=aku5Wr7UyK+V0snFL1cxJvQ8vx4zTYWUOfI8efY9NTKnNUrkqXvPXjsoktd8QhpI7W/FIpWWL/ka8C6wHeL8O7oYo7MZN93d3/ej1uM7ZpLhZcOWUbC7CmjH0WPJtiW+gj8QsX3qP7NEvbMDYldTOtHM8Lz4EsHEdYDvYD6SSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070773; c=relaxed/simple;
	bh=LcqKkkKEqAI8dc4MEoeZPEcumAXv9qSB3QRRSzq5HY0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y24g1PRyCQxNT7Mmw4Yr61SveiMubMueYlcOi5Hu52sPbygvhtFYzVa17dmRlhGlTlS7l1kyHIeaPONizCG0TEl1eoVwsueKZw4OcjakU7IviLIKhr8l1RT+u/MSsC1Ln8Xx1wd9WUL8WddGXebzYKisJey1sY6jYiNYeLIt0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WN6TQy38; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47J9QxBU004262;
	Mon, 19 Aug 2024 05:32:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=T3w4aeClcXuf8wxt6T8SJAr
	7x+4HAI2H1+XZT3FcizE=; b=WN6TQy388eRcvak7eYKPi3q4j4zEhZGxhvV6hBE
	K3mZ3ETGib2LRqn1PzRMygQ2Pz7Gm/+paiQXzFcrP8/41g9MLrcR6079UlLnton7
	MXQRabhjAEq7xBQtR0d1JkNSk1QpWI6Fnui4NjIMMAftf39p1A/HNKFOW3QGXNxt
	s54Vlr6DyBrbxu4ux8AHs4i336oek/LMXKxYjhDL8HGPItaD9O+G8joxHOm8UqES
	LZlGfObQjlGfjntqxsw/kD5bY4GYPvNYXBpJLb/+vSSpI873vSbMQVupzlkVaYGH
	LDq2q6X7QPMljUuRcQ7dWAhlPL6apb+qQr+QUt2j9TrWr6w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4143e80gsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 05:32:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 19 Aug 2024 05:32:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 19 Aug 2024 05:32:45 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 922FE3F70A9;
	Mon, 19 Aug 2024 05:32:40 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <bbhushan2@marvell.com>
Subject: [net PATCH v2] octeontx2-af: Fix CPT AF register offset calculation
Date: Mon, 19 Aug 2024 18:02:37 +0530
Message-ID: <20240819123237.490603-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0-aWPIYkJgWZtKHfXkNmu9UfOEhxCttM
X-Proofpoint-GUID: 0-aWPIYkJgWZtKHfXkNmu9UfOEhxCttM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01

Some CPT AF registers are per LF and others are global.
Translation of PF/VF local LF slot number to actual LF slot
number is required only for accessing perf LF registers.
CPT AF global registers access do not require any LF
slot number.

Also there is no reason CPT PF/VF to know actual lf's register
offset.

Fixes: bc35e28af789 ("octeontx2-af: replace cpt slot with lf id on reg write")
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index 3e09d2285814..daf4b951e905 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -632,7 +632,9 @@ int rvu_mbox_handler_cpt_inline_ipsec_cfg(struct rvu *rvu,
 	return ret;
 }
 
-static bool is_valid_offset(struct rvu *rvu, struct cpt_rd_wr_reg_msg *req)
+static bool validate_and_update_reg_offset(struct rvu *rvu,
+					   struct cpt_rd_wr_reg_msg *req,
+					   u64 *reg_offset)
 {
 	u64 offset = req->reg_offset;
 	int blkaddr, num_lfs, lf;
@@ -663,6 +665,11 @@ static bool is_valid_offset(struct rvu *rvu, struct cpt_rd_wr_reg_msg *req)
 		if (lf < 0)
 			return false;
 
+		/* Translate local LF's offset to global CPT LF's offset to
+		 * access LFX register.
+		 */
+		*reg_offset = (req->reg_offset & 0xFF000) + (lf << 3);
+
 		return true;
 	} else if (!(req->hdr.pcifunc & RVU_PFVF_FUNC_MASK)) {
 		/* Registers that can be accessed from PF */
@@ -697,7 +704,7 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 					struct cpt_rd_wr_reg_msg *rsp)
 {
 	u64 offset = req->reg_offset;
-	int blkaddr, lf;
+	int blkaddr;
 
 	blkaddr = validate_and_get_cpt_blkaddr(req->blkaddr);
 	if (blkaddr < 0)
@@ -708,18 +715,10 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 	    !is_cpt_vf(rvu, req->hdr.pcifunc))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
-	if (!is_valid_offset(rvu, req))
+	if (!validate_and_update_reg_offset(rvu, req, &offset))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
-	/* Translate local LF used by VFs to global CPT LF */
-	lf = rvu_get_lf(rvu, &rvu->hw->block[blkaddr], req->hdr.pcifunc,
-			(offset & 0xFFF) >> 3);
-
-	/* Translate local LF's offset to global CPT LF's offset */
-	offset &= 0xFF000;
-	offset += lf << 3;
-
-	rsp->reg_offset = offset;
+	rsp->reg_offset = req->reg_offset;
 	rsp->ret_val = req->ret_val;
 	rsp->is_write = req->is_write;
 
-- 
2.34.1


