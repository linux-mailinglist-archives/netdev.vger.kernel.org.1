Return-Path: <netdev+bounces-186463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235BFA9F408
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D8C5A08E3
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2972798F6;
	Mon, 28 Apr 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QpVv05sa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C732797A3;
	Mon, 28 Apr 2025 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852602; cv=fail; b=Be6naD1VLgujQUFMuBxAWpOQZTBguHGL10d8GamxgeZmLzBquwB+mO3/Ru1XDHuY3QmNfcEs97xYrD8ApoUpGoKT6T/A2NkTdRW9Q99YOiB0R3J09jRgsvwJxxeFk0w+6sqpbgeRO5HrPDqpYoFLPzSHk2Kz9S37NhsjGoxU2lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852602; c=relaxed/simple;
	bh=PckhD1YeyxdD98DKNXKOBeoPevqSAoq+y/8K+P9/cpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhvaIr007YI5LyScpXlkD3kPvYVIohEZGqyz2WfgcEoTvboEAmvWMsqHSiVm7u/M6iv3e7yd5rGix3ActFWgA8YttNhaUGQSQPmbqysKdZgTT9ZNCJ9XBoV57tSqfvCH+9Ff2q8ClXglftqwCFhlTQ5gA4FtzQocX5CWHrXXWrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QpVv05sa; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcKMvA4a0QPQkBgIkgLPJIZ5moOeueqDm4tg1+46prvHCTn0mmlGEJ1OyRyPE1k0BU01eGJm2IpfiseYTKOePb+O/yU/nN1ss7WI+DTdsntHgL5PgMjJrRo6u6Boz9Jk5Ug3uJG7IlFmOwGMG4a6Ux115tk/LidrlDCGm8ORL+SI1r4sx6CM6EyP4RB0kE7Tc4czbFm/xFfDqFUR50G5cGkc4xPi9hGYWafEe1+kBpe2Kco5icsqT12PNpiymO4lxWXTfMLTtnfyYzuy5VcX6f9kg0zXVL7OcgTOEQIzGoclZNt0OBVSnGoNvUmbBMrf8XtaBmYPrDJsjrdkBrKf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuFIdXaFTJwNCzGW18qo58ySdJDjN456xS80ytzOHN8=;
 b=nmO1CwM4seOUHqeCsQhEhtwoGA5evT8RjyO39VPJ/cnAZ6tx46rKfFVpGUmldP7azxlS8krqPZbPk7nMRs1IwLfTbGAZDIldAHg41q/GEw54yYaUfcRvhv4sDisbbSAnGlHx5UwEZ0vMwa1VTgmAW0Hhy11q1+P1PNqscHfDLaOf2aLRqw6b5iFeP3gqH+XVgjHphYA86NcAtsGGwzYVEqljQe1DFkagHlwZVHkGYr/V3bnLF9m7W07qFdBXll3lpqrttia0h6BVwbg7CyqmEhRMd1KLBVjvez7nJdxzSEMMWgG7+RFFiIUbUgiYm9e3KwuTbsIF7MmlbVA8TUUCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuFIdXaFTJwNCzGW18qo58ySdJDjN456xS80ytzOHN8=;
 b=QpVv05sa47lfn3LzePOiYzgV2bNw9NT2jix/OiHbacdTe0eGndmTdKOzIAbu11/oDb0nm/vOIa3qQxMq1IhrrTtnENW6fZl/7kA+J16AMwO8HGTjzpu3eluL1YuWfzxahvTreqenotFsTWtWtwaXV94iFFiMh8GBxqP4Pp7PoE4=
Received: from SA0PR11CA0181.namprd11.prod.outlook.com (2603:10b6:806:1bc::6)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 28 Apr
 2025 15:03:15 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::3f) by SA0PR11CA0181.outlook.office365.com
 (2603:10b6:806:1bc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 15:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 15:03:14 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 10:03:11 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 2/5] amd-xgbe: reorganize the xgbe_pci_probe() code path
Date: Mon, 28 Apr 2025 20:32:32 +0530
Message-ID: <20250428150235.2938110-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
References: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|MW5PR12MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 0621db00-2c6c-4da5-f13c-08dd8665cd37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Co0OHJig6dpjFCS663M2mr7+mwHhjrjXy/Uu2Vuv7BLWhn7q4BUr8wWbyl5C?=
 =?us-ascii?Q?T4bYQgpn/Au75y2dzoG9A2G4Yz4949DOVJcK2yv9dqsJ5Qo8mKlm5KYjKciz?=
 =?us-ascii?Q?sIMCN/tr1k154QOel44cqABl2yYqD5FSBAvSgF0PuE1TQwfMd8gNl07j8CLw?=
 =?us-ascii?Q?t8pPnXkZbY6J83ymNGCDR+fQhbvZmMyROi24oEsOe0kTQ0edkvkyxtIgm8WE?=
 =?us-ascii?Q?ofQ2u51Mhwjw88sDhEtC3mRsxIPz61gvKmeuvCadheYWOzG/8Tvh2X5TS+t+?=
 =?us-ascii?Q?A04YKNgKgcBO7pEG8wOjcwKgffRTzAiRzjfUseVmfbyehv8Htf/OmREK/y5Z?=
 =?us-ascii?Q?kUN/xMYidYOFhUQzckAQq+GVe1vH4HJknmMpLtnpPkw4cwGr5/yupdyF/sgz?=
 =?us-ascii?Q?0cR3X+WpPS8GepCzTC56qEDWMSyroQng48FVljAnSTO423HgHUrdFWeRHqIP?=
 =?us-ascii?Q?VowYmrwPCMCqQSkzBtVmjsdXUAGvXzX5v0C3FAjO6yyBZOm7mZngOBf7a824?=
 =?us-ascii?Q?YL29UrNhWk3FEjS0LtatqhmjwFpFl/j+gAHLiBBoRN0mKd8tYaN7pa0DaywR?=
 =?us-ascii?Q?faFLZPl/EjCR5JNECIW42nz8c9Bk1QXGfygLZOfrE5uWqPpqUsScNA0p5as4?=
 =?us-ascii?Q?b7oMdz8hWiQ1e8yr+lzySou2BJPYbIMwDXjfwB3QqRaOUyREnLIJW2MnrE53?=
 =?us-ascii?Q?+0E28B3yspAgIEHtWU+7PD7VmPMy+19326CNQJDjDXdQHD79r2lg5VfqfbQi?=
 =?us-ascii?Q?yq6KgaFQuuVeHgdStRbh6TbeE6pwA03b8YOjvUTGmNBBRIpCFdo9jc2qTJ2I?=
 =?us-ascii?Q?20nW5Qc8X9MLEzrPIoWbgvdGtM7QwX0idFVBtftNq/qCqFNFR/kBeGdmlp47?=
 =?us-ascii?Q?hEmsKhPu9F/L+nepeY56oz/6A6Jr8NtisL5HO9vrbnFLvFTgSR9HjCa1onZN?=
 =?us-ascii?Q?2OwkMkZsy2cqvQ+J0+Bq9AFAgwHBovZQGz6rDMCWlu+4JNVfkzodvX1fzlNz?=
 =?us-ascii?Q?35N1/GswDKXODPlLi1h1U8DF14q2H8yZW5ZARItOtgN/zBAGtIR25OOoYzpt?=
 =?us-ascii?Q?5Qh2CTcImDZvohdrAzZBEFKn9MEHhSeE5yuTMaboEe9jv8YSzJgWj2i2Ndvm?=
 =?us-ascii?Q?DaBmFkIf1lTFN3pjOCka4F1EtZ5LGjzS9zRWtv+QOn8eDFabdb/bCrhuw10V?=
 =?us-ascii?Q?SsJkG7vSNgKDIuz1R+J2xpjNJ+5eOaEZXqVaoVYrHlR85x1gAUe0nQakO4gJ?=
 =?us-ascii?Q?ePvab0tDsE+YD60U9FAJbBUEjhcYGTklkJnfoAU/ei+aDi5bBvz7NMNdlAlJ?=
 =?us-ascii?Q?t4IWcwj2OnPUHmzNaVzxujlTwEIhkW3qcVK/QBJIgjTEnwNaenokPPTE3wfW?=
 =?us-ascii?Q?aejT7gDU8kHH5AHuLrdLniBg3HimsrGrXf5Wx/tMv2MV0mruMVtFuMtBxGu6?=
 =?us-ascii?Q?neC033va51LqIP5Kb8Gnea/rNB2YP3DkABuCt2AFa/NVmID30AvD4AOSSs9Z?=
 =?us-ascii?Q?RgdK6eIsyDVnit/7v83O71LUdswAEXosKR7V?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:03:14.8667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0621db00-2c6c-4da5-f13c-08dd8665cd37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649

Reorganize the xgbe_pci_probe() code path to convert if/else statements
to switch case to help add future code. This helps code look cleaner.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 35 ++++++++++++++----------
 drivers/net/ethernet/amd/xgbe/xgbe.h     |  4 +++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index 3e9f31256dce..d36446e76d0a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -165,20 +165,27 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Set the PCS indirect addressing definition registers */
 	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
-	if (rdev &&
-	    (rdev->vendor == PCI_VENDOR_ID_AMD) && (rdev->device == 0x15d0)) {
-		pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
-		pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
-	} else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
-		   (rdev->device == 0x14b5)) {
-		pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
-		pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
-
-		/* Yellow Carp devices do not need cdr workaround */
-		pdata->vdata->an_cdr_workaround = 0;
-
-		/* Yellow Carp devices do not need rrc */
-		pdata->vdata->enable_rrc = 0;
+	if (rdev && rdev->vendor == PCI_VENDOR_ID_AMD) {
+		switch (rdev->device) {
+		case XGBE_RV_PCI_DEVICE_ID:
+			pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
+			break;
+		case XGBE_YC_PCI_DEVICE_ID:
+			pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
+
+			/* Yellow Carp devices do not need cdr workaround */
+			pdata->vdata->an_cdr_workaround = 0;
+
+			/* Yellow Carp devices do not need rrc */
+			pdata->vdata->enable_rrc = 0;
+			break;
+		default:
+			pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
+			break;
+		}
 	} else {
 		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
 		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index e5f5104342aa..2e9b3be44ff8 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -238,6 +238,10 @@
 		    (_src)->link_modes._sname,		\
 		    __ETHTOOL_LINK_MODE_MASK_NBITS)
 
+/* XGBE PCI device id */
+#define XGBE_RV_PCI_DEVICE_ID	0x15d0
+#define XGBE_YC_PCI_DEVICE_ID	0x14b5
+
 struct xgbe_prv_data;
 
 struct xgbe_packet_data {
-- 
2.34.1


