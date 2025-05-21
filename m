Return-Path: <netdev+bounces-192166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9191FABEBB5
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342414A57AE
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F0230D35;
	Wed, 21 May 2025 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LbA7Ie9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4B192B75;
	Wed, 21 May 2025 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747807740; cv=none; b=n/45wIoG+ty0eIhbzP6+swEsDHgf7DEhl/5o6MnWP9VdT5fdQ1RrVByu7DeTEMculc5ncHalIzwH9bv6rUojfCllfWMQGKc5qqZkcGVlLtXn1b5lkbYT2f/RHiwWJ3h9tJvQe1eyd5d4xMGATzbeSMtZwqVxkmW6kmITswwUHww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747807740; c=relaxed/simple;
	bh=xvhWXckWVZOlJBDWwV25agxnkq6jMnIrx+DQzulEHBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROFEa0Ly+B9tJtNA6/5EB0aXpTQkxS9rt9YGW7rl33fLedgGt+vel/b66djEocLARMSk1ybtyLSv10wk6LasWG9wXHjQGJW8K8DOF+N5ZV7bd+v76JpLfGthSJwdNABCxaaxaM5zVQFH1CfNYdZMbSlF0zWbGe9Oirr407e9o+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LbA7Ie9Q; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L3ejgp006545;
	Tue, 20 May 2025 23:08:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=dW3drOUwJfCDtQwoNmldvSheD
	C4ybFqHU8gyFWrOdhc=; b=LbA7Ie9Q6Ln0m0rT9b0qgf4xnGg+3eCU3AqZm+75F
	bqJP0eHHbidvSImRZp1guKW8TCHOhauhhY7usqBwlHtornUxsFYGuEjVNOAwwXvi
	z0ttWJs1gq2BqccM6HPvmXT8svAyqXnl8WXXYKXLGUrSdy0jwia8wAmammHdMHox
	fpBwzDfALFF4B4mvQYd4SNrEsJhld2I+oqwsGEKh7+YodZ51KsecvVmvZS4QIQUv
	McqKmexM1Z8veKpoRXEQRNQ/ZzOvqqknp63fAGDoA/06WFhGFD/frzEdZNGq2GzZ
	3O2Zi1Tkqy2qiW9W3p8rqvNLfNPP73616USlI2k5geNag==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46rwfghaa0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 23:08:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 20 May 2025 23:08:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 20 May 2025 23:08:48 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 83A983F7077;
	Tue, 20 May 2025 23:08:44 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <andrew+netdev@lunn.ch>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH 2/2] octeontx2-af: Fix APR entry mapping based on APR_LMT_CFG
Date: Wed, 21 May 2025 11:38:34 +0530
Message-ID: <20250521060834.19780-3-gakula@marvell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA1OCBTYWx0ZWRfX5iDMfeAyeXyf tz0hiEY4sOg32mg6W8Y6skRmQv/l5GOxVBc08gZrMnmoX4+M/Hm2eUYZSOZil7XVzHUKyB5IQmP 2jJo018r1ReRm0zoIjyJqYqYqWBdYyVE7qMujuZ1fKWeSfCXV7WAkIDLfIDuSObWACGMmA5ABwQ
 ImO+o0S+5rTtLuBNJyMnbBK57T8QlfqhZUkDaeM7xZtYuxqEXaoX2D+KFZvzkaoUqUJZ6kpwoI6 JRc+FChSB3jnu48SVHsIF+Hkec2m+BUJz1sjYk4TCub1L25VHiGkBcnuFdqUiFZ/R/w/RY4fIeU IUtELUGaRvIchs2IYkxKkc1ldoCRdIIAb77eGT23hwNTZC/jXONVhHZHVfh9eWexQWP2qKZxICC
 JlJVtybCX5Gyt/tOyts73grNY67gw4BXvXYThaeoFl5XFklPswmULfD5X8j3D4NT8d4F80aa
X-Proofpoint-GUID: NJbyK6bVPgwO4vYG_43HENxYFL2kEN27
X-Authority-Analysis: v=2.4 cv=T6OMT+KQ c=1 sm=1 tr=0 ts=682d6df1 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=pBlSUKV1qd5FT76UzXYA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: NJbyK6bVPgwO4vYG_43HENxYFL2kEN27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01

The current implementation maps the APR table using a fixed size,
which can lead to incorrect mapping when the number of PFs and VFs
varies.
This patch corrects the mapping by calculating the APR table
size dynamically based on the values configured in the
APR_LMT_CFG register, ensuring accurate representation
of APR entries in debugfs.

Fixes: 0daa55d033b0 ("octeontx2-af: cn10k: debugfs for dumping LMTST map table").
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c |  9 ++++++---
 .../net/ethernet/marvell/octeontx2/af/rvu_debugfs.c   | 11 ++++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index 3838c04b78c2..4a3370a40dd8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -13,7 +13,6 @@
 /* RVU LMTST */
 #define LMT_TBL_OP_READ		0
 #define LMT_TBL_OP_WRITE	1
-#define LMT_MAP_TABLE_SIZE	(128 * 1024)
 #define LMT_MAPTBL_ENTRY_SIZE	16
 #define LMT_MAX_VFS		256
 
@@ -26,10 +25,14 @@ static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
 {
 	void __iomem *lmt_map_base;
 	u64 tbl_base, cfg;
+	int pfs, vfs;
 
 	tbl_base = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_MAP_BASE);
+	cfg  = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_CFG);
+	vfs = 1 << (cfg & 0xF);
+	pfs = 1 << ((cfg >> 4) & 0x7);
 
-	lmt_map_base = ioremap_wc(tbl_base, LMT_MAP_TABLE_SIZE);
+	lmt_map_base = ioremap_wc(tbl_base, pfs * vfs * LMT_MAPTBL_ENTRY_SIZE);
 	if (!lmt_map_base) {
 		dev_err(rvu->dev, "Failed to setup lmt map table mapping!!\n");
 		return -ENOMEM;
@@ -80,7 +83,7 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 
 	mutex_lock(&rvu->rsrc_lock);
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_REQ, iova);
-	pf = rvu_get_pf(pcifunc) & 0x1F;
+	pf = rvu_get_pf(pcifunc) & RVU_PFVF_PF_MASK;
 	val = BIT_ULL(63) | BIT_ULL(14) | BIT_ULL(13) | pf << 8 |
 	      ((pcifunc & RVU_PFVF_FUNC_MASK) & 0xFF);
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_TXN_REQ, val);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index a1f9ec03c2ce..c827da626471 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -553,6 +553,7 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
 	u64 lmt_addr, val, tbl_base;
 	int pf, vf, num_vfs, hw_vfs;
 	void __iomem *lmt_map_base;
+	int apr_pfs, apr_vfs;
 	int buf_size = 10240;
 	size_t off = 0;
 	int index = 0;
@@ -568,8 +569,12 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
 		return -ENOMEM;
 
 	tbl_base = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_MAP_BASE);
+	val  = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_CFG);
+	apr_vfs = 1 << (val & 0xF);
+	apr_pfs = 1 << ((val >> 4) & 0x7);
 
-	lmt_map_base = ioremap_wc(tbl_base, 128 * 1024);
+	lmt_map_base = ioremap_wc(tbl_base, apr_pfs * apr_vfs *
+				  LMT_MAPTBL_ENTRY_SIZE);
 	if (!lmt_map_base) {
 		dev_err(rvu->dev, "Failed to setup lmt map table mapping!!\n");
 		kfree(buf);
@@ -591,7 +596,7 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
 		off += scnprintf(&buf[off], buf_size - 1 - off, "PF%d  \t\t\t",
 				    pf);
 
-		index = pf * rvu->hw->total_vfs * LMT_MAPTBL_ENTRY_SIZE;
+		index = pf * apr_vfs * LMT_MAPTBL_ENTRY_SIZE;
 		off += scnprintf(&buf[off], buf_size - 1 - off, " 0x%llx\t\t",
 				 (tbl_base + index));
 		lmt_addr = readq(lmt_map_base + index);
@@ -604,7 +609,7 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
 		/* Reading num of VFs per PF */
 		rvu_get_pf_numvfs(rvu, pf, &num_vfs, &hw_vfs);
 		for (vf = 0; vf < num_vfs; vf++) {
-			index = (pf * rvu->hw->total_vfs * 16) +
+			index = (pf * apr_vfs * LMT_MAPTBL_ENTRY_SIZE) +
 				((vf + 1)  * LMT_MAPTBL_ENTRY_SIZE);
 			off += scnprintf(&buf[off], buf_size - 1 - off,
 					    "PF%d:VF%d  \t\t", pf, vf);
-- 
2.25.1


