Return-Path: <netdev+bounces-189314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 018BDAB1956
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F7E0B222F0
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2198723237B;
	Fri,  9 May 2025 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DEdcppJu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7B6232368;
	Fri,  9 May 2025 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806049; cv=fail; b=EmFfT4TqMLN1c1KX/2ThS2urOcwggB7q0p85Zvlu845yKiseo3q5MT56fYJaFcb4ZuzJb6DOs3Mk4oidAlVa1ozVCodjr45Nx/yiuY3+KNpes242VR852hwQXy9unGDsLt9VhI+unDyV/WQyGijr3X3/kwyYC03KdNc7ItEMF98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806049; c=relaxed/simple;
	bh=N56JMvcqjB7KIcdVOQH2uOJ+HLzo6H1q/26iqKzjR6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2wNIBiG11b9oaKTFf4PBHO9Jfu/mU+Uf1EHSW071G3VpcyUSekTmqaNGaMOeoObBobNYMbru01ovwdGWcRDUC0Ku5nrMjrMidvWhrBxPIeIug4pPOLYIIY1WVrIkXruPVuxiU1ou04FxSxO3AXHil70OZUqTyM0fhBDaq132tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DEdcppJu; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owlb7uXCvTdKIw83jqwpFgvSEAAYmJ5bxG3M9nQ57B3JV5WU9VhHxWMMnlSl1bEyI4g88qjr3GDS833ekloNDu8kfEMNkMbUvMJnetLYeDJX/KJtDy+JfCBEc9D4RLo5E6K9H/DpmK16uw1cOzWth2zJZJjlD6MqsumXCuwRG6sTIV2iCBLegKyHi6irp6MR1E+fUPWS+iF9iUwZGWdmfGrdbmlDcTEK4ivjwTMFted8fLQweDuSymHFS6oNguQTAsoNJKRiRc+Mc5eFG2QBaCXoMGSoLfn6ckRsB2dFFJS4xcWEy5Wb7rcRnXSm0/XYgmxaraBjdE09/Fnvfhkq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvIcfp8idZp7VuLuD+VK+dMpE9Ed8TMSTsEaPy5opJU=;
 b=Hudw6n9vGJUNH6t7rmNa2w5hSHQgIBV2lkwNGF+hlRRuGsBC5nzdZX3gJT6fZSVdFGl3Ux87gdKucm4Rl1036GRHQg3qjAXNvrMINfPz8BPKy8oR1QA94OxblwggiFGrx7A0exOifGNRlfEKeen9u9hyETq60aBy3FnDkqcyAXeWM6pPwk/ZAk/fzhnbHm9CBsSZwa+dUTsNcFYpRjEGj9iicNKnyEhcV26VGjAx7EVnJ9EIjaFUEmJmyNhF6hQxoM6nwmlQcOckEKxIiDeWcECq11mlir7y4lKJEfxt9K1YVZUXXvuZDvFTAl0fWEt6loERTTI2T7pTdj9nfY3euA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvIcfp8idZp7VuLuD+VK+dMpE9Ed8TMSTsEaPy5opJU=;
 b=DEdcppJuQAJvHkjxE3HMd5PbqYjbAlVwKVEoCDoijQOXgSq7qDlT9UmKDtqgr5Xns35BOelPvrZoAYgKIHuWaW2b89+D+e10RIUhK8GYp4DJ71nOqmW1mcfHomhWMFoBeFZvdvkKN2F9jTULxmuVbFn6q2kobq3DLFdGO6cFcsg=
Received: from MW4PR03CA0007.namprd03.prod.outlook.com (2603:10b6:303:8f::12)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 15:54:01 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::fc) by MW4PR03CA0007.outlook.office365.com
 (2603:10b6:303:8f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.32 via Frontend Transport; Fri,
 9 May 2025 15:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:54:00 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:53:57 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <horms@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 1/5] amd-xgbe: reorganize the code of XPCS access
Date: Fri, 9 May 2025 21:23:21 +0530
Message-ID: <20250509155325.720499-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509155325.720499-1-Raju.Rangoju@amd.com>
References: <20250509155325.720499-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 140a24e7-eabf-45e7-d9e9-08dd8f11b756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3WbgRK+TT02Wn/84lOOWUjzExHWUy9VIJuFyUXEDwXCQ3G6ox5/B6dVIe7o4?=
 =?us-ascii?Q?rPCdu6TOfd0vX49vsVBPMqGJx6ym4hD2KkkibO88jCDQURPJQpUzIsRZcml6?=
 =?us-ascii?Q?Y9OPvseELsT/VOrUAkhcdM/2PX0v+Zye2Kw/vqlKoTnlDIsHOZgJD7k9Spet?=
 =?us-ascii?Q?FXzfA0zIeht8EVxBbxrLwLo80bZryPh4gyu11Rs+aYyaUTOENIcYtxzYWNwE?=
 =?us-ascii?Q?r1v9Ok2vm+oHoAbSKUp5kK/audpLc9nwUlG8gH0Q5GCBe39yvJw112QiKkwG?=
 =?us-ascii?Q?NoydjDlBwICxss+Mg/YZEN8MaJeihoCPK05Y6bM/X2ahaetqgPKctz0NbMuR?=
 =?us-ascii?Q?OY9qRoxLB+aCZwhNq5RI7qnnjZeAPjDxOBEaBMxIkYH5wr6Q9gIRdcSzHgtE?=
 =?us-ascii?Q?7a/QVR9Rhrk7pWlE4UUvvcshV+gK+V7DjY9Hej5kwcJTQveeqdWG2iNluYPy?=
 =?us-ascii?Q?IMWmFZCO5Fk6Mbq5WP82fjfGCkaMIgg2HRX5k1c/B43ZO+0PR7gbX6o3Pix1?=
 =?us-ascii?Q?nBMcHKKYI73VVHW8XRpm0qVA11YgTgPztSeD13KNi9mqoe33RXKebIx1veYq?=
 =?us-ascii?Q?Fuw6Xx4J/r2W1xx7qT3lxYjoJyS8ajRHhbHXNnzKKtrfct4lr/YpU6hGEJoT?=
 =?us-ascii?Q?2d0jISDBGLLifNsKSjpy2szXt2bqyhF5DaaqYi+uPgLQqo4Y42tW9jtsXeD2?=
 =?us-ascii?Q?Q9yfZW4iWozVDABovV7nbGusB68HMqcC/c7TymCMJ3oOR/53aL5XrC9ZCwiy?=
 =?us-ascii?Q?MmYGVmqD/8rf2WizBN9mlISxGqKTAHbSvzKEuEAON0AhCS22zFFmaBBTZO08?=
 =?us-ascii?Q?1Ko04Nt9DdNt9htPfwfW7lUgUzxT0eNGEKhcg1d+MNgYqlktZNs28cP3rBIJ?=
 =?us-ascii?Q?NWdz4UAvGE4e6xFIBW/CGFK60myygalapTNaOuMp/oLWj6n96VTUK42y0t62?=
 =?us-ascii?Q?fC7sKRsO9r+vyKHu40hLRdsYZenQR2UghQVEFg5pNv60rNy1Ftvz9irgv2wn?=
 =?us-ascii?Q?6dA4IaacENL1kXjjSBV91X0n5+oHyO/eZvFJHIoLo0xyH0LKLU53ZeJcxqJW?=
 =?us-ascii?Q?c3cLChws0GoNNPV8zsjSxOdr1UsQMRzvDs7d16p/1GCmYZbwY0TMswp6/n6+?=
 =?us-ascii?Q?42ll6xCKtJ0Iog519da52GlqtuzFL4OulvzUSZmtSfELiH9ALlyN1FGuHPKU?=
 =?us-ascii?Q?PJokjhHd+VKpPjqrSAZqZtIy5jWGV9UIPXN/eCKK0rvxTqp+ZkDDf+y7Gta8?=
 =?us-ascii?Q?ZJitPtf7o49NjcNZk0bfbehszkzxpGY/WXqtS1LfRcJNXBH20r/cfzxPoqzV?=
 =?us-ascii?Q?w6wEcrboSN0x5PlPiHjAqNu8qnu08lmgvbktA7+sQ4S1xM6VBPHQpaSsM5xC?=
 =?us-ascii?Q?xpNKSBRYVm6K/IC/imjzmxDTc2kN2LG8v9PDtM5LmJwyW1FzVnkhuywuTiX2?=
 =?us-ascii?Q?bzh3fs7dlmLmjYggTVRfLyvn8kMi065xEe8fFRFsdmm9A/cx2GxUkOUH2Qd7?=
 =?us-ascii?Q?o0U777snys7QPz6clJk/cWahgDTDmp48L354?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:54:00.8314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140a24e7-eabf-45e7-d9e9-08dd8f11b756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

The xgbe_{read/write}_mmd_regs_v* functions have common code which can
be moved to helper functions. Add new helper functions to calculate the
mmd_address for v1/v2 of xpcs access.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
- follow reverse Xmass tree ordering
- line wrap to 80 columns wide

 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 65 +++++++++++-------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index d9c8f2af20ae..cdab1c24dd69 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1053,18 +1053,19 @@ static int xgbe_set_gpio(struct xgbe_prv_data *pdata, unsigned int gpio)
 	return 0;
 }
 
-static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
-				 int mmd_reg)
+static unsigned int xgbe_get_mmd_address(struct xgbe_prv_data *pdata,
+					 int mmd_reg)
 {
-	unsigned long flags;
-	unsigned int mmd_address, index, offset;
-	int mmd_data;
-
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	return (mmd_reg & XGBE_ADDR_C45) ?
+		mmd_reg & ~XGBE_ADDR_C45 :
+		(pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+}
 
+static void xgbe_get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
+					  unsigned int mmd_address,
+					  unsigned int *index,
+					  unsigned int *offset)
+{
 	/* The PCS registers are accessed using mmio. The underlying
 	 * management interface uses indirect addressing to access the MMD
 	 * register sets. This requires accessing of the PCS register in two
@@ -1075,8 +1076,20 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	 * offset 1 bit and reading 16 bits of data.
 	 */
 	mmd_address <<= 1;
-	index = mmd_address & ~pdata->xpcs_window_mask;
-	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+	*index = mmd_address & ~pdata->xpcs_window_mask;
+	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+}
+
+static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
+				 int mmd_reg)
+{
+	unsigned int mmd_address, index, offset;
+	unsigned long flags;
+	int mmd_data;
+
+	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
+
+	xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
 	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
@@ -1092,23 +1105,9 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	unsigned long flags;
 	unsigned int mmd_address, index, offset;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
 
-	/* The PCS registers are accessed using mmio. The underlying
-	 * management interface uses indirect addressing to access the MMD
-	 * register sets. This requires accessing of the PCS register in two
-	 * phases, an address phase and a data phase.
-	 *
-	 * The mmio interface is based on 16-bit offsets and values. All
-	 * register offsets must therefore be adjusted by left shifting the
-	 * offset 1 bit and writing 16 bits of data.
-	 */
-	mmd_address <<= 1;
-	index = mmd_address & ~pdata->xpcs_window_mask;
-	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+	xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
 	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
@@ -1123,10 +1122,7 @@ static int xgbe_read_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
 	unsigned int mmd_address;
 	int mmd_data;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying APB3
 	 * management interface uses indirect addressing to access the MMD
@@ -1151,10 +1147,7 @@ static void xgbe_write_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
 	unsigned int mmd_address;
 	unsigned long flags;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying APB3
 	 * management interface uses indirect addressing to access the MMD
-- 
2.34.1


