Return-Path: <netdev+bounces-120430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91353959550
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 09:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E41A285274
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 07:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3D199FAA;
	Wed, 21 Aug 2024 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EvVLqAYx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97380199FAE;
	Wed, 21 Aug 2024 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223979; cv=none; b=Vz5ECidadAyAiehh5VhFJSKnN2ybOUJmJ6xXljv93yl6nHRrffz/D6Fzb+49YzSVFmsQb0Vvfz5V0H3V9vOWky+g5wiZtyHY18b78G9wqnfKlp2XdZufZGUlC6TTuH9tp6iG09INr11qDi+p4xSDI9IlzsV2F8Ylapxf+CORvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223979; c=relaxed/simple;
	bh=H6e8sR9NwEUa7+97t5vyzl80Dup3G/Jrnu3y2VQX3Ts=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lihT+TmG5XJBGRgdHNnC0b8AGFNtPSbFQxUF34WbJwePPFXLgos4DmkP/PsnI4fPL8PBvOKhF2abPvIDhjJP9ke83tXpCjc9oEbk5oLtEV1jR5zkK4bJ5rv2NFsLb2pnvJDmRPrGVh4AhZBxHRQ7ipc+QRA2ClFxJ4YEGM2qvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EvVLqAYx; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L4ffQY022001;
	Wed, 21 Aug 2024 00:06:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ndSFFiA+eUPyexFnJa7zlp/
	aunsjNSVl8vEQu2tj5tQ=; b=EvVLqAYxbwbLDKUfY3juVdY++fTxzhi/SPYmSbX
	AKRngOarnDLQU5utfSIqCmaEm9YJqRyOSWDgkcSRkktR8NtPFcqw4Hh6I5O/mMNr
	UDvoTca1pepKdLR1v2XxwpArzz2x8QV9V8P37wfJqMYnP5hAvIfMIxoRPFfJHgRd
	+I2W4egD08vf6lmAixYijTlMGw7ZX97bVDTqXNUr4Fgezv93vY4M1n3UxU/I4PAX
	kHSSTJMbirMJE0hIc9EZMBxjfpr+qY2AEUjgIc15g5Zoyi1fpaoZOwECKBy9+a7+
	QYKx1ATxM2nkWUcCDtUxnctji1/g2lBudtcUPv8Zki6liTQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4159e28dpm-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 00:06:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 21 Aug 2024 00:06:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 21 Aug 2024 00:06:06 -0700
Received: from bharat-OptiPlex-Tower-Plus-7020.. (unknown [10.28.34.254])
	by maili.marvell.com (Postfix) with ESMTP id 845273F704F;
	Wed, 21 Aug 2024 00:06:01 -0700 (PDT)
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <jerinj@marvell.com>,
        <lcherian@marvell.com>, <ndabilpuram@marvell.com>,
        <bbhushan2@marvell.com>
Subject: [net PATCH v3] octeontx2-af: Fix CPT AF register offset calculation
Date: Wed, 21 Aug 2024 12:35:58 +0530
Message-ID: <20240821070558.1020101-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: I9TpbL7ofwsL7ncn4ZuN1NKYne6dYMGH
X-Proofpoint-ORIG-GUID: I9TpbL7ofwsL7ncn4ZuN1NKYne6dYMGH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01

Some CPT AF registers are per LF and others are global. Translation
of PF/VF local LF slot number to actual LF slot number is required
only for accessing perf LF registers. CPT AF global registers access
do not require any LF slot number. Also, there is no reason CPT
PF/VF to know actual lf's register offset.

Without this fix microcode loading will fail, VFs cannot be created
and hardware is not usable.

Fixes: bc35e28af789 ("octeontx2-af: replace cpt slot with lf id on reg write")
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v3:
  - Updated patch description about what's broken without this fix
  - Added patch history

v2: https://lore.kernel.org/netdev/20240819152744.GA543198@kernel.org/T/
  - Spelling fixes in patch description

v1: https://lore.kernel.org/lkml/CAAeCc_nJtR2ryzoaXop8-bbw_0RGciZsniiUqS+NVMg7dHahiQ@mail.gmail.com/T/
  - Added "net" in patch subject prefix, missed in previous patch:
    https://lore.kernel.org/lkml/20240806070239.1541623-1-bbhushan2@marvell.com/

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


