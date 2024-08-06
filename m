Return-Path: <netdev+bounces-115958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01489489B3
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22412B23C73
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 07:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9B6165F1F;
	Tue,  6 Aug 2024 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Twag1pFv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31BA165F16;
	Tue,  6 Aug 2024 07:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927775; cv=none; b=B3RQRJj/l+tzR9+MPSpaQ1Ci8hh6c1o4QdC6zNwnPpkAV+wBX5Ho1RshiLLptNFdp2HyFSzOL+oWt0qP2OnQ06fA/V6OoB/L8U/lJT1X1+AVRuDOw8Bhz0etPC0y1sgGKoIrQAcvLFN2o2+PRNBFqqvzBWxtvfKYQ7p33yVP7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927775; c=relaxed/simple;
	bh=J4M4kvsLInnExY/QCbU9J9DriPGrhWN5e+IA/qfKpcY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EPjjHid52djU/VNoffEVzLxFI58EbPZPL6w+7by9SttXGV/Tkq5yi6hZ7QkCwnSYeJmi+i1SzIfkzFUPYzuC6fIbINXUQAGtUAtB2wQ7nmfmTC3eeEHiaVWqTqVQ/olKOeyL0w6CkZosCEKVCDLLQT045UyIeWdcJyh5d4I5dcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Twag1pFv; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4763fp1f016877;
	Tue, 6 Aug 2024 00:02:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=qyS6gmL9fUjso1gx6fyW6lU
	7ArR8Ee+ubGGTs2Kfv8g=; b=Twag1pFv2M2cuNbqxU79gtEYBYw2BJlSX0Dpdj3
	fU14Vs2GE/OfFi6lXfAMLj1oG9VHkimzNwOa/5mxF/EXtE3YVScgXsAjgcfU0HQh
	ai/3F2nzCHUX+eSPMngnoJ6OVcgJfaWR6O4l8czTCM0tQSxexkXiURtsypWEM7R+
	BknRzhWcVnts/BOHGSVssozC365GtFdQpM2IK88bepyASB36s1Mz1S4Xx0Wl+Qe/
	rWnRjjUphucPjOawAxFX3UJhsVFkPEK1axEgWI6Sbpkg/6nsdrocjRa1j5ETXrlm
	drQxrOLkFLgSJTP8SrzZZ+UWR7BuFf3BUInB271kftRh+hQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40uc5f0gbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 00:02:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 00:02:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 00:02:46 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 41A383F70BD;
	Tue,  6 Aug 2024 00:02:42 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <bbhushan2@marvell.com>
Subject: [PATCH] octeontx2-af: Fix CPT AF register offset calculation
Date: Tue, 6 Aug 2024 12:32:39 +0530
Message-ID: <20240806070239.1541623-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TRMjsiiIXhD3k3HN9EyfhUlpLyyyW-v4
X-Proofpoint-GUID: TRMjsiiIXhD3k3HN9EyfhUlpLyyyW-v4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_05,2024-08-02_01,2024-05-17_01

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


