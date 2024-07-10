Return-Path: <netdev+bounces-110509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED2D92CC40
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767BC285889
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6797F49B;
	Wed, 10 Jul 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FmA8eo6H"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40B5CB8;
	Wed, 10 Jul 2024 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597973; cv=none; b=emHctS/HsZlARKZD443cudi1q1DyF0TNULE77S56FEgC8R9jH+PYQ+KLb80DyruL4COU6Tl8GPXuTM6GFupOHYLgfM5xTfNM6ybLd/7TGEroIHLoc3qwKswpnOIdc6FGG5eZ5dFW9lDN9ORpS8nMbLGZRUoQG1FRyQbI7umeVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597973; c=relaxed/simple;
	bh=2PFKWkKhSPHmpls7uAOXhTnAwAM9+qDsosLmiGqxaYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afiP1otu/QcJOegWBYeUBHMNnETeYG+5GuT8lC/hfVy8lOSAKpK3ICNDvbH2+FQEDNbksBB33ES8vVlSm0qOGnX2w62VsZmAjm8/0fOtQBiKDbJ5DN9rDyGo+g6TxhYWtrBoolQR66Pnlb/G3LdvY1Zhb5HTwFgySP2pGJE6DzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FmA8eo6H; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469MQ88D022710;
	Wed, 10 Jul 2024 00:52:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=7
	IxJjYfcrPnDxCKWi5guGHlYcsizf4wTIbtgyKp8Oas=; b=FmA8eo6H1wTFDfzQr
	MXrI8VueJh+798a4PFfeUbGJfb5/K9WUyr1VdAe4TuuKPIrPGWNArNImpcQy+Txc
	t5R5roBUOm/2m+AjTrab5dFipFzL1twjMyod4EOg0hXnxTru55Qwtzmpjfjx/1JA
	43EOpO6Z8NucyIyAlVl9GHWPatvluTZt8/v2CnA08w40ucd9zvRUquJFJiwFZ6cj
	D9FWgvsTVrHzz8kvCmrq2yUS7ho+41IRJySZ+v3RaDhh/Va3uGjBEyiAbSPu9HQ/
	LZPLuJp7e5VbSB4f/EMp743hoR6Gjkk4433xWq+8lZjgWylbDg6/npUVmqf287Ok
	QfL8w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 409e061p0j-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 00:52:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Jul 2024 00:51:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 10 Jul 2024 00:51:36 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 860063F705E;
	Wed, 10 Jul 2024 00:51:32 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <ndabilpuram@marvell.com>,
        <schalla@marvell.com>
Subject: [PATCH net,v2,1/5] octeontx2-af: replace cpt slot with lf id on reg write
Date: Wed, 10 Jul 2024 13:21:23 +0530
Message-ID: <20240710075127.2274582-2-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240710075127.2274582-1-schalla@marvell.com>
References: <20240710075127.2274582-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Sb8QWzcP8fJ9QMSb_6GRqxDSiogf_-ZU
X-Proofpoint-GUID: Sb8QWzcP8fJ9QMSb_6GRqxDSiogf_-ZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_04,2024-07-09_01,2024-05-17_01

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Replace slot id with global CPT lf id on reg read/write as
CPTPF/VF driver would send slot number instead of global
lf id in the reg offset. And also update the mailbox response
with the global lf's register offset.

Fixes: ae454086e3c2 ("octeontx2-af: add mailbox interface for CPT")
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_cpt.c   | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index f047185f38e0..3e09d2285814 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -696,7 +696,8 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 					struct cpt_rd_wr_reg_msg *req,
 					struct cpt_rd_wr_reg_msg *rsp)
 {
-	int blkaddr;
+	u64 offset = req->reg_offset;
+	int blkaddr, lf;
 
 	blkaddr = validate_and_get_cpt_blkaddr(req->blkaddr);
 	if (blkaddr < 0)
@@ -707,17 +708,25 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 	    !is_cpt_vf(rvu, req->hdr.pcifunc))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
-	rsp->reg_offset = req->reg_offset;
-	rsp->ret_val = req->ret_val;
-	rsp->is_write = req->is_write;
-
 	if (!is_valid_offset(rvu, req))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
+	/* Translate local LF used by VFs to global CPT LF */
+	lf = rvu_get_lf(rvu, &rvu->hw->block[blkaddr], req->hdr.pcifunc,
+			(offset & 0xFFF) >> 3);
+
+	/* Translate local LF's offset to global CPT LF's offset */
+	offset &= 0xFF000;
+	offset += lf << 3;
+
+	rsp->reg_offset = offset;
+	rsp->ret_val = req->ret_val;
+	rsp->is_write = req->is_write;
+
 	if (req->is_write)
-		rvu_write64(rvu, blkaddr, req->reg_offset, req->val);
+		rvu_write64(rvu, blkaddr, offset, req->val);
 	else
-		rsp->val = rvu_read64(rvu, blkaddr, req->reg_offset);
+		rsp->val = rvu_read64(rvu, blkaddr, offset);
 
 	return 0;
 }
-- 
2.25.1


