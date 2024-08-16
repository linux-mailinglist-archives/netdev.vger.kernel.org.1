Return-Path: <netdev+bounces-119165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3229546D0
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D2D1F22BA8
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E26158DC8;
	Fri, 16 Aug 2024 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RRr32zKJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FD12A1CF;
	Fri, 16 Aug 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804734; cv=none; b=Es8cu+Vl8DwBdzjhlrR9To7gIFZUJf3TXBnOO5GamuUsjs2biyqTBCBW81m4GsIV5FygCX1xP/XVanvtzx5Awfx+NzELuKujOSWncpA/1V6IePq2j34Prs/K2fbdqPmkpFkMOWJoKD4NCfaEXqHvm/00zTDr9CgOYYCxSXUEfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804734; c=relaxed/simple;
	bh=J4M4kvsLInnExY/QCbU9J9DriPGrhWN5e+IA/qfKpcY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kk8s3MBqxNoOSdiYwEH0x9bJKPzusc8QZBJ0tqbQqJLCZ9vj46KWs+nkmoCQWkh4MJxn5atdPW1FdyGCvFLycgGreSyanImS7U+bNaQB0KdTxEhJt4iU6a1TzDPmqQPD5TP/YlS/L8W17WT/Ui0bqkc9EXF1zqgIafCRR96qtk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RRr32zKJ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GACYRe009392;
	Fri, 16 Aug 2024 03:38:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=qyS6gmL9fUjso1gx6fyW6lU
	7ArR8Ee+ubGGTs2Kfv8g=; b=RRr32zKJ8nFCATzSPK4dkWjTdS1S+k6IW727N7g
	qCHKe86gESfkyQ9+gs93nPJvpnE/UXhZU7nWc9YQ0hOa3xqdteUjlGiz/kcFOpJj
	T5t37RwKYo03I9HZJwIrZuUddjqJ64KVbJuzmsfgMxFw6wIcwML4YMpI3En18Guc
	ilscjF8vb5Urk0Rz+4ROT2UIMIMvMbNa6f0Us+DsEKRxp/xi6ZCyq3OVlr3nPEua
	IJIbelXJTNZXmddCNaLGbyhu2j270ekPU0z8q04623Rj7IjLgcNOXkLwUmgS8bPi
	gPWThlwn1lsd0UmfkR/1HkkLvJOwNMN7Y1KWXjq11hRx9OA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4124h5043u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 03:38:31 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 16 Aug 2024 03:38:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 16 Aug 2024 03:38:29 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 0A9173F707D;
	Fri, 16 Aug 2024 03:38:24 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <bbhushan2@marvell.com>, <bharatb.linux@gmail.com>
Subject: [net PATCH] octeontx2-af: Fix CPT AF register offset calculation
Date: Fri, 16 Aug 2024 16:08:22 +0530
Message-ID: <20240816103822.2091922-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1KMMMTTxdoC4jnZ9SpzwfoYUgd_MxwOB
X-Proofpoint-ORIG-GUID: 1KMMMTTxdoC4jnZ9SpzwfoYUgd_MxwOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_02,2024-08-15_01,2024-05-17_01

Some CPT AF registers are per LF and others are global.
Translation of PF/VF local LF slot number to actual LF slot
number is required only for accessing perf LF registers.
CPT AF global registers access does not requires any LF
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


