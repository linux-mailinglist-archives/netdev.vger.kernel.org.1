Return-Path: <netdev+bounces-192165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0198FABEBB1
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9CE7A35AD
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7386D231C9F;
	Wed, 21 May 2025 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D+qMITgO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF52192B75;
	Wed, 21 May 2025 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747807734; cv=none; b=ZoHKp0nIG2uqaepC7QdIp3xHd9QCqHLpwS+OEAt/jBRw04kZyvM/VOZJqaZDRnIMkp3/qqO9bByb8iuQYyAb3giZnL0iIiaZZ7Upp+pbP0MobI/9PfU55ZBSiz5DWGLD7Yks11OuwgNBaiCtWBrinuRGpm86gSGkuySRXi0ioSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747807734; c=relaxed/simple;
	bh=doMmCBK3UsQwoS8k0t6yG7wP2J4cYU6IcC+hRBF3mhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlE4g6TCMtoEuLiYhAerJgOyyJxwWPGRUUiSVRfitieerI3LjWA2BiGmVAHlgAvv3bcos6/V01WZtMUE2EXasdlcgDymzQDrubW1YkdpSmv5qO7D383b8xESviqy0gpDDEWkuFFe2AtvIDuhUVV/3PsvBf4EE6jk5RUCEon7v18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=D+qMITgO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KNcTKC031279;
	Tue, 20 May 2025 23:08:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=DP4tl85qanEw2Jj7xTDmV247R
	jk/OCX+rkSQNGq4uss=; b=D+qMITgO6SgpUB3G7MUlE+iMU60Tixr/3A2O7+lAI
	Hi4htphkc6GRv8UjrV4Q/ASgungUbesymZA1JnQ9x6pd2d7B0lwA4Swn1XnqFIPI
	wiSAPt2kNxEbiEHWfmsqY0EOeTQNUotVexqF0I1kiFjSirGH6QIISjtsAvlcxjbT
	5D72IVtosqfODrkd/ZFZOtPkhY6XV9Hc5b7UJdX6RLcqB/e4mVHVTq6+4UmavbgX
	jJH6g4ppcgRW+d6sp6UL7TBZQt0S8KpjIuwsrceHlxgLVhQH691xEpR71T5DlNVk
	rH6DDqhykzQgJ6uqd+JuXZ4DwRhF8XPP78ggjj0kUzMSw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46s3kc8kg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 23:08:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 20 May 2025 23:08:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 20 May 2025 23:08:44 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 513B23F7077;
	Tue, 20 May 2025 23:08:40 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH 1/2] octeontx2-af: Set LMT_ENA bit for APR table entries
Date: Wed, 21 May 2025 11:38:33 +0530
Message-ID: <20250521060834.19780-2-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250521060834.19780-1-gakula@marvell.com>
References: <20250521060834.19780-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CG6dLKocc-atiIzC22CoTKe8DpYDQjE7
X-Proofpoint-GUID: CG6dLKocc-atiIzC22CoTKe8DpYDQjE7
X-Authority-Analysis: v=2.4 cv=TcyWtQQh c=1 sm=1 tr=0 ts=682d6dec cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=mpddl2msnD5X7IA2-cwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA1OCBTYWx0ZWRfX62YLF9eQqu3U /kk0+ZAyecsgu+2qKX2iNTF0+LLgJ3wf77PDl7KNePzvOc61tZTuEyt4VV4Mabewq3Ux6211dnK DF0OO1h1jk6gnTB3QTxT8hIWSR2a9g2poec19cNM2002AdSFN9IZzCPBnUgyuSYXf8WcjoMccwC
 wUk21Ru1obFK9BSNqzBd9uRu4MStFMf3UvLMV4jAKCjSUcQJ9hR+8f5aaBG7rSYGkE8ZBvT5A6P 6xoVajL8rvW+r8zd7RE6lH7yr1btL39nqEUjtqzjZa8FTfGfXyDFDWPIYoROYnsh47SNFHVJlaV 1N072M7meQd84FGegrYlFrXWH5xO5fnEGU3XnMO9YOQYRWFraLADYKT2N44EX3XlOUKXExRJCZS
 m/ZCIxzhMup+KpOqI2Ju4U/cjGFqmpxlhprVZKVM9tkc2Zf8x4CniF4a8m5yWUXhdRuMPIe2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01

From: Subbaraya Sundeep <sbhatta@marvell.com>

This patch enables the LMT line for a PF/VF by setting the
LMT_ENA bit in the APR_LMT_MAP_ENTRY_S structure.

Additionally, it simplifies the logic for calculating the
LMTST table index by consistently using the maximum
number of hw supported VFs (i.e., 256).

Fixes: 873a1e3d207a ("octeontx2-af: cn10k: Setting up lmtst map table").
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu_cn10k.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index 7fa98aeb3663..3838c04b78c2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -15,13 +15,17 @@
 #define LMT_TBL_OP_WRITE	1
 #define LMT_MAP_TABLE_SIZE	(128 * 1024)
 #define LMT_MAPTBL_ENTRY_SIZE	16
+#define LMT_MAX_VFS		256
+
+#define LMT_MAP_ENTRY_ENA      BIT_ULL(20)
+#define LMT_MAP_ENTRY_LINES    GENMASK_ULL(18, 16)
 
 /* Function to perform operations (read/write) on lmtst map table */
 static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
 			       int lmt_tbl_op)
 {
 	void __iomem *lmt_map_base;
-	u64 tbl_base;
+	u64 tbl_base, cfg;
 
 	tbl_base = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_MAP_BASE);
 
@@ -35,6 +39,13 @@ static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
 		*val = readq(lmt_map_base + index);
 	} else {
 		writeq((*val), (lmt_map_base + index));
+
+		cfg = FIELD_PREP(LMT_MAP_ENTRY_ENA, 0x1);
+		/* 2048 LMTLINES */
+		cfg |= FIELD_PREP(LMT_MAP_ENTRY_LINES, 0x6);
+
+		writeq(cfg, (lmt_map_base + (index + 8)));
+
 		/* Flushing the AP interceptor cache to make APR_LMT_MAP_ENTRY_S
 		 * changes effective. Write 1 for flush and read is being used as a
 		 * barrier and sets up a data dependency. Write to 0 after a write
@@ -52,7 +63,7 @@ static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
 #define LMT_MAP_TBL_W1_OFF  8
 static u32 rvu_get_lmtst_tbl_index(struct rvu *rvu, u16 pcifunc)
 {
-	return ((rvu_get_pf(pcifunc) * rvu->hw->total_vfs) +
+	return ((rvu_get_pf(pcifunc) * LMT_MAX_VFS) +
 		(pcifunc & RVU_PFVF_FUNC_MASK)) * LMT_MAPTBL_ENTRY_SIZE;
 }
 
-- 
2.25.1


