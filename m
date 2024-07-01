Return-Path: <netdev+bounces-108065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 439EA91DBEB
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFF91F2537E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80C2127E3A;
	Mon,  1 Jul 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XOUQQgmK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD323207;
	Mon,  1 Jul 2024 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828025; cv=none; b=mPQXpidxcuofZipBTe5rYRSrFGdOALv2u628mur0CKldzl3yV2hmD/eG+811cGnRdl6LDfrbhUxrT81s0dr+6dzziDJdRQobo51kg2o+TmbCj8eZMTYaZXUlW7bG/4fQfCU4/EjToUhCrBDtgX2kgynFNlCnBHk8qpnbb/vz2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828025; c=relaxed/simple;
	bh=RUf7OjjTglvTPXGaPVeizucUUQcyVBcR3ba4jC8am9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQO6bydQNSxclCTxlsL/mz4KHpNj09snEiKK+XPeBczrxUProdIPnjsxL4A1GJ117PBKlsgkdnut6eCZ1O2SZr5MXNZTnuwRa7ue7+McoU3XcPDK2oq828bFu2ElT0qDT6qBLF3kkX+TRe7Iv8uSh/mVbJ05iN5pLAxzf4JJw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XOUQQgmK; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4618vWEW022313;
	Mon, 1 Jul 2024 02:07:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
	V/vwo6keil1TY6K9z6dN0ncA5BO0qdU5lVeOPVYXzU=; b=XOUQQgmKbmOuIPBzq
	/Xwi47VHHLMzo/0h16BE/dYX3cyKTcxlAtNNuaJfYv+LjZ7jDO4L9SEoPgq0JSwx
	BUm6TvmloehuUwZ0WgxVrRw2EA/E5n7iKp3T368STe5evXmtMIxGG4e7tmrfXo7h
	7pv172C/DPNvTeJfZuOO3tkRRWsxbe/2vcDBdkiJgEGLoguEXcuq0BMhuTjs/1ui
	dE+l9IBKdfGBIZlhIc9zpRzozR1iVF/GZqPT9wvA3nUORx9A/Y2dHtVr92aEXU++
	2Ee02SOx6iZd3qszJ1EwzPFCkI2j6tnnCxkwlXobF6hSLuep3fAyMZlLcfk/nRLv
	qyAxQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 403sdcg1my-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 02:07:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 1 Jul 2024 02:07:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 1 Jul 2024 02:07:57 -0700
Received: from localhost.localdomain (unknown [10.28.36.175])
	by maili.marvell.com (Postfix) with ESMTP id 7615B3F7055;
	Mon,  1 Jul 2024 02:07:52 -0700 (PDT)
From: Srujana Challa <schalla@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
        <schalla@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>
Subject: [PATCH net,1/6] octeontx2-af: replace cpt slot with lf id on reg write
Date: Mon, 1 Jul 2024 14:37:41 +0530
Message-ID: <20240701090746.2171565-2-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701090746.2171565-1-schalla@marvell.com>
References: <20240701090746.2171565-1-schalla@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xhxDl6Nlsy0u5m-up4tXOxKgGyOdswgC
X-Proofpoint-ORIG-GUID: xhxDl6Nlsy0u5m-up4tXOxKgGyOdswgC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_07,2024-06-28_01,2024-05-17_01

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Replace cpt slot id with lf id on reg read/write as
CPTPF/VF driver would send slot number instead of lf id
in the reg offset.

Fixes: ae454086e3c2 ("octeontx2-af: add mailbox interface for CPT")
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index f047185f38e0..98440a0241a2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -663,6 +663,8 @@ static bool is_valid_offset(struct rvu *rvu, struct cpt_rd_wr_reg_msg *req)
 		if (lf < 0)
 			return false;
 
+		req->reg_offset &= 0xFF000;
+		req->reg_offset += lf << 3;
 		return true;
 	} else if (!(req->hdr.pcifunc & RVU_PFVF_FUNC_MASK)) {
 		/* Registers that can be accessed from PF */
@@ -707,12 +709,13 @@ int rvu_mbox_handler_cpt_rd_wr_register(struct rvu *rvu,
 	    !is_cpt_vf(rvu, req->hdr.pcifunc))
 		return CPT_AF_ERR_ACCESS_DENIED;
 
+	if (!is_valid_offset(rvu, req))
+		return CPT_AF_ERR_ACCESS_DENIED;
+
 	rsp->reg_offset = req->reg_offset;
 	rsp->ret_val = req->ret_val;
 	rsp->is_write = req->is_write;
 
-	if (!is_valid_offset(rvu, req))
-		return CPT_AF_ERR_ACCESS_DENIED;
 
 	if (req->is_write)
 		rvu_write64(rvu, blkaddr, req->reg_offset, req->val);
-- 
2.25.1


