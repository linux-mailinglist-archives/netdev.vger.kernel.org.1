Return-Path: <netdev+bounces-180419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60931A81471
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E75885871
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9F323ED69;
	Tue,  8 Apr 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XcXs6Bz/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182C23E350;
	Tue,  8 Apr 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136441; cv=fail; b=oF5l45pX9pvNvd26mM7/rRWMdYLh9HDZEj+EP/jeaWmAXpF7BVIHgk6LLAF00orkehpObKPn2mNCaY+pFB9dDQ/uzaqPpKA+S80H4hN8dnPLyykDp1mvZ4jwOGgbi7rvly1XEQTkjSqALlDESY3O47mDHAvMZPVLTS8hGlLs55Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136441; c=relaxed/simple;
	bh=EkQlMYJ13DIwwIDZIhkrly73F/C5Skw6wmTvgSGS6yo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daj9r7tgZyxHQ+0jJMitgS6ADxBCw3fjWyiuYoirbt1C6b6VWd26cWoaaKwO13pePtHX7XqHvDjP321Ry6Zg5M3pMinhYbl2n50DPvG/dYCBoFE1RA4inVr8a6KoN8eLfleD37fhD/Vx+uKLAD2I4vomGQJd5lsqoDoxr9Ff/gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XcXs6Bz/; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/LhsmWU5reZgSksON9Y04HahvSIGdJDUfzkU5Ij6s0eOwECRfHBUtRz/HgWrNZNAW+A3IX5APQ1FaZJruInaWDLIpjB8q53GBUuvZ7WTt1kx6M2LFCY4Huy59JzW9QFhdtHW17AZsaf5EdHaL3UJcGR5NAIAKOcMaeellH8XxygBB4YYlg3/8hQs1mlQ4OhuzzxVmh2jmmuRFMz5SE0pC8VbPEa8pCdwMBIgDd0e2m+MQks3WdaQABeTHy4ZJgscAhlxdTY/UAC+FLN/o3i34LnfQJtSmZEeEKYGGK2frP6+LnR1QH3p1IXLwjU0jfX5UgWMMKwn5ro3d22Xv/zUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BAJOa9IgvYgxPeYaBTMLyjHiJsZNvKt/fAS3XHirU8=;
 b=FuJXjART3HWHvgSdLabsaTrcQoZx5P25lmQybAKyxKMckbjjdiCZApwJngKd8nNKVsZyZ2FpSCO8wfYhf7d8277d55rUelD6ArQQ+swLvePVwlLyRd3CvzWpkN/ABYTDDcMR4BxZuFNp6/1kqHHqyzTX1nJAWJ2qpBbRR5kH+795pvzrzbltJ//osr5O7PmgZogbGf4MF1fkv+OK/LiPmCxZk60WtxnoM65qKvW4ZLxpkXdx7kTUxFCX+k+dWkZBV6SnFhVMp8fziKNg/Lzvkx9NXZ50Nbe/Ckysv7Perbyr3ZA85KFie40v3b1YqQiDnbRohA+Jm7r4oAzg+xhTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BAJOa9IgvYgxPeYaBTMLyjHiJsZNvKt/fAS3XHirU8=;
 b=XcXs6Bz/ACG6KOph2A4YsLXA3hzDuoB6R1N7U9SSlGWFXOc0goZVSRC2p39jKKlxqREb7VZhDPnddTb1NDiTDD8YeU8CBgX2RKztujAK4UMHTilA+QYwueFATcQakVuf0y9z+I6JLiLBy6fd82/5KyZcZbPNQRCCRVY0eQPMCk4=
Received: from BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.45; Tue, 8 Apr
 2025 18:20:34 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::84) by BY5PR03CA0020.outlook.office365.com
 (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.32 via Frontend Transport; Tue,
 8 Apr 2025 18:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 18:20:33 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 13:20:30 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 1/5] amd-xgbe: reorganize the code of XPCS access
Date: Tue, 8 Apr 2025 23:49:57 +0530
Message-ID: <20250408182001.4072954-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
References: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5aa3ad-1353-4dbb-fafb-08dd76ca0da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/cjhh1SZBehre6CUVD3Vr6O40JBQpJQ+Dj7YPUwOnIbxZCDl0Q/X5EPkA940?=
 =?us-ascii?Q?lItXcC2uJvWeuxG5k40QOnhlKdDCcH1Ej09DL+NF7vxQ7QeX8cNayshtFNvR?=
 =?us-ascii?Q?SmefqFraNMoGs0PV4EqHSAbZfJlscrdUTEqGlEux1MrAJUHzG2I3deJAUT14?=
 =?us-ascii?Q?d82JIu1QHezza5nbw+DsAzTvvUY8SwDpfyanHOmFHCXkLWcFZ+AGWtFRXfJR?=
 =?us-ascii?Q?zJ4EPPXKYzAQ7b3su7KlBPrkp3JdRFQk6WCY/3AeIr5Z2GAUjwv8JyH6XolN?=
 =?us-ascii?Q?2LafQTEB8jSk11MIKRp/3X4Qq/ziR5jk85gH9pQ4WD/EsYoMwyC4cDxWFdep?=
 =?us-ascii?Q?tkbKKgJhpkJW2CDzOuktY/FN1K//PEtQVLTzTVfn1Vao41IxXarN7kgN9kbO?=
 =?us-ascii?Q?JPrqYTPyMEmPmJkVjgxP49EZJ43G0T0njxTWhceDEEL+DNaDWAtoJJ2753jA?=
 =?us-ascii?Q?qFPXOWbVUdxblEyDyr5a4itdor+iINpbk057tcMBscA24inIQbXNZqACAdKu?=
 =?us-ascii?Q?o6r6FqWfVkyF6+7or06MFbRzH+8iS82aClqBh+1u3V7qdvD34C7A52TGnFN4?=
 =?us-ascii?Q?5o0LoTswAKjPPJiOd592Rs8s5Gjkt5VAD10+dfoXI2BehgzYYvAg5M3MWHvN?=
 =?us-ascii?Q?qJuFqqaKiNxrt0W9Ld+VDBKEX+XTW4ObTWqZISJYF8TYSofmwC4qJV1DIofD?=
 =?us-ascii?Q?xF1VL2yJMWuZFjMrHUNXXJh/AKpt7fnBZPuwrvhLrPiftnuHZk68QWLxICWB?=
 =?us-ascii?Q?BIbgcLOkaPyIK3xv506yqNQaYEidjQ1XU0Z0WpavqsVzUAOIUGxx1blvtN4r?=
 =?us-ascii?Q?XDfohaiyWPPqqrIqjbgQDU3AL/t368uPUQlTeSgWwCdFYjdB2UsibbMyWJxC?=
 =?us-ascii?Q?QfoCg1uxgeFokU7o5aTE8/79MHHnTuIz+6aa/YJubryxyUEJMWkqdlL4So3N?=
 =?us-ascii?Q?xySQJ6ubpjUsIdrz7mF5DISLsbs0Cefq08GEEbQifwh/C0aZzkCv6u3TjIeh?=
 =?us-ascii?Q?6KQUYu2E62yMrHda7gsfYn6zyPlV5MY5G1GJQeXY/w1G0NeT5MYqEZ3d9UPK?=
 =?us-ascii?Q?P6hOBsky4LsuhP8/O5r9OGF/IU0tUJMKRSM4hmN7v5PkyWymhu7dw7R7gMZy?=
 =?us-ascii?Q?tLniKS6uzKVcZz+VwPNx/NABgGNoSN6vIjfipfWFz0ZIS9RLEsmrpKw3Dbkx?=
 =?us-ascii?Q?yjlE0/JAWsALxMjkobhEg+ZamI7IUkF6RNgr4U9n/uhYhT5LtUO2YjRjYT0X?=
 =?us-ascii?Q?/5VHeg4fRuar52T92S5K8RVUleWG3FenzFImcYRb9hcHePw36H9X0MN8z7co?=
 =?us-ascii?Q?JoN0fYycL5f5Z2l/34n5UAo9P2eEYyiHSyOk3sMB8llShpwDXE/Js7NFuDPe?=
 =?us-ascii?Q?m6sCpiTRi2TCnYsz7GX788xybp/+2m4EX+g4HLifYSQyY11otBbvZyky9mUH?=
 =?us-ascii?Q?nwv1SKCFSGUAU2uytg2YsOiy5LId5d0XZsUhe1Y4xbi6ihTTstSq1LE9FQqL?=
 =?us-ascii?Q?+i5jgEe2/d5GxAM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 18:20:33.9721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5aa3ad-1353-4dbb-fafb-08dd76ca0da8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455

The xgbe_{read/write}_mmd_regs_v* functions have common code which can
be moved to helper functions. Add new helper functions to calculate the
mmd_address for v1/v2 of xpcs access.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 63 ++++++++++--------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index b51a3666dddb..ae82dc3ac460 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1041,18 +1041,17 @@ static int xgbe_set_gpio(struct xgbe_prv_data *pdata, unsigned int gpio)
 	return 0;
 }
 
-static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
-				 int mmd_reg)
+static unsigned int get_mmd_address(struct xgbe_prv_data *pdata, int mmd_reg)
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
 
+static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
+				     unsigned int mmd_address,
+				     unsigned int *index, unsigned int *offset)
+{
 	/* The PCS registers are accessed using mmio. The underlying
 	 * management interface uses indirect addressing to access the MMD
 	 * register sets. This requires accessing of the PCS register in two
@@ -1063,8 +1062,20 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
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
+	unsigned long flags;
+	unsigned int mmd_address, index, offset;
+	int mmd_data;
+
+	mmd_address = get_mmd_address(pdata, mmd_reg);
+
+	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
 	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
@@ -1080,23 +1091,9 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	unsigned long flags;
 	unsigned int mmd_address, index, offset;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = get_mmd_address(pdata, mmd_reg);
 
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
+	get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
 	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
@@ -1111,10 +1108,7 @@ static int xgbe_read_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
 	unsigned int mmd_address;
 	int mmd_data;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying APB3
 	 * management interface uses indirect addressing to access the MMD
@@ -1139,10 +1133,7 @@ static void xgbe_write_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
 	unsigned int mmd_address;
 	unsigned long flags;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying APB3
 	 * management interface uses indirect addressing to access the MMD
-- 
2.34.1


