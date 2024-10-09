Return-Path: <netdev+bounces-133450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 299D6995F13
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6B11C23889
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 05:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D617C220;
	Wed,  9 Oct 2024 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QxaRnD17"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC68D16EB4C;
	Wed,  9 Oct 2024 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452424; cv=fail; b=M4vjGrcxliAgC//5PfawNttLBzP7CpH48A8GDRdMaZN9DGysFAKeGQxuSK7C1xYhqyOk96Ru7Ti3dDWUOk93+Q1k/QYS/ZiM1EyW5pFBWF9yvYXSo5R0lv1syi6c9ZqazmHr5gdfBbWg5mKID8z3zPrc6oTcnZn8X4mio1+KBUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452424; c=relaxed/simple;
	bh=X7qYOKtbaBdCGGB0wIApRvP97w06fM48Pds/1jG3ZQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAkdT78HKnLHnnjGH/UGHMfjKEBWnJ4F7Ap+CDo3LXH1+kb4Ieu/sAIM7thW+X7h5EhWpGWShwirtVPcbgf3ZFdQcLMjoSqymUeK5bkTB2kV/9MUYJxAPa6l19nm/nkJWDWka0g1af08R5xku0iexrsL5OVWP32eEGmylo5X9rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QxaRnD17; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds1b+VLWeY9MdyG21clMoGBbyA8oMnCL1FTao0IJLzVC4oHHMYfoqpPmL+HstdLJgEwUhQ5NzLSD+sikkA1J9z1928BHjeSUp2/P++R0v9eL0niwsn1x4Oic9TfxnW/B6cG6vecRHgJ8K6ZeYlCmgdXakr97GXRtmHuA5xpkvLRCl7YoryQzgF4TCfdXY3+b5qW0fgvPtHXf27XDBwdl2UjLs7S2y7ywj+RRTi5VRQm2k3aY3n0jU4Bf78Kc+o1QDAJ2OvUHVTZRQ8vLouWBA98d/WirUpOvHH5sw+9lqYnwWwrrPnjKD85IX7FuhaiSeR2eBntPY4XZxYg6wQywDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqPi2fKST9EsbhXJ2b8hOjJgg1G3DuvXxcJfsHOdFNg=;
 b=tSYMvwXR8y1/TA80Oq4dc34wUYCbPMIDOZNDvU9oGM/xiuBB2CtrfHdS7UgWOy1sTXt3sVpb41580Ma2jOQJcqMytZv5sjwKZ//8yTC81UO2mXMieDvMFoG3rl6MaDSVNYfy127cuRxDDvOlibdq+0pIsYkuwf+pcAE94TNr4IkGbPtJ4eSJIMfg10dX5vgDl0dKLbWXkbL/9oq1+Ebeyyu0XXEsfxB/x5BqmolK9vnmQmQeSmnTD5MzSPCG4eHYXExPEh4DUFXKL+szJwa/pdtLYQa1AdYS3RB9eqE/GMeQqd70cyqCnzXdlWd0UGFJJsiH57x6PVXLK14vuZH2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqPi2fKST9EsbhXJ2b8hOjJgg1G3DuvXxcJfsHOdFNg=;
 b=QxaRnD17HOdCi4BgSXm4T1EJ1j72kcGJ+PxNR8vUCWnEkz2CDJ9sdPY9sWLeXaenWpkjutC8rGkhgrdPoxDBOtp/hZfRR5GnOaah2yjfUfGk8CtuMeMwJWdPAycu3PNeZ8/8onNLYf58WVWuh66aoyHyvQmydNsycyn+Cc2Sw7A=
Received: from SJ0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:a03:33e::9)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 05:40:19 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::26) by SJ0PR03CA0034.outlook.office365.com
 (2603:10b6:a03:33e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Wed, 9 Oct 2024 05:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 05:40:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 00:40:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 00:40:16 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 00:40:12 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [RFC PATCH net-next 5/5] net: macb: Get speed and link status runtime.
Date: Wed, 9 Oct 2024 11:09:46 +0530
Message-ID: <20241009053946.3198805-6-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
References: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 7746d75f-60ee-427e-6840-08dce824dc27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eBwgyghLwwad8onD1cP3nyLoFA9XtTI8GU/BsqZttQNIwDluQ3bIMEHsYd+j?=
 =?us-ascii?Q?qiUV0qOg2+WMxgPvuMfWIuE+2ad0xdQ5liNSR+S+/wYi0M6mz+iq3m2tHCHJ?=
 =?us-ascii?Q?ZnUZ93c5hXRLFMtZUIPrbwKgcPD2AiIoWFqPM9URB//rB1DRxjdV7r3hw3Eg?=
 =?us-ascii?Q?nA4P4SyFKbmxDo6CRowKGVBzgmvn+om8BZe6Y18ngaf+Nb5lT9NUkBH+kh3w?=
 =?us-ascii?Q?X8wtjS0nI92UUeFTmZoUvx1Dz0lVVDZuhT5bpvIbhRv6Udtlmj8PuV6pp+4h?=
 =?us-ascii?Q?o+eM1F604N/jmFga7EnlGPY8vtxFYNDB2yZrfF3HXvE+KPqsxIZ4vHS9H47b?=
 =?us-ascii?Q?sxkDXmtd7ufWpHJlFMoVWIKqGVWp8a4BYIYCpCO3vQlwaZRuiw2fcmykYzxC?=
 =?us-ascii?Q?LDVWrOZS9psc0XBHyJbhxg6YpadebhFwaQ1Yy+kBWIUa50L3L2w3DR2g1PFt?=
 =?us-ascii?Q?ZPh3ge0THyVOgr84stKvFqwZoiQxd3OPPsC81PAA6jzJp1KNUb96541+bNAo?=
 =?us-ascii?Q?VAai40zKveOqRfC5U7mdPKBSaRhoDYR9a5owmy0YhTUl8nG5CLa3CHYOefJc?=
 =?us-ascii?Q?iZpqm5mUnjhehjTh6taIv7P2Mw4BK/20ffPYn2lQYzizNmCvdYv5GQ3xffl+?=
 =?us-ascii?Q?a+EhtC6G9lhumlZTKVhMkaFTcOIV5rn+4j8lCYh9tLtvLSwQLaWZJpHHB6sM?=
 =?us-ascii?Q?sCvpmhYMZeLMrrIoO3sAER5NfLmpHCrGDC9ycnyHv8lo1MQmHLTRNQfMPNq+?=
 =?us-ascii?Q?HCpUp1A9RAVBHo9dbfK5r/ZOU0k6kv04EPr1EMyt8sCVYjxhbpqLJAVb2rkl?=
 =?us-ascii?Q?JCurX+bjnI3xCSP93KIAnaJTNuWrUu+l7x+YM88xno1kDk0FAUTF+XxE9DZo?=
 =?us-ascii?Q?K5envDa7RgqrB/YzMRnT4fVT4dFEmnUBalYG/PVkwPDrVG+hiP6XwnUnDlnX?=
 =?us-ascii?Q?S2r02korB25PoozjSgs7Vs04T6fRoAT3Ik0omI14dbTGx1cjBoEMjlgqxI8a?=
 =?us-ascii?Q?rkQC+83v31r28OmVMZ5gHrfx36gU1UxxndU9aTn8oum7xWH+iHD54IUBgbES?=
 =?us-ascii?Q?dvWLt0uvICJpLcuZsx9R75dWzNKkAcyxMB3e3NnbrOZIW1XLhMddwwAC27oR?=
 =?us-ascii?Q?iNR8rJsD0BOU8O+sJLm2Ywmfkf5z4R2P3liEcGJj2BeNcI2vF3YqjLS84Vzg?=
 =?us-ascii?Q?XKg2jZJPBAH7dEdaBcXwW08VvQYuqGm2GX79oBX2+y1dbJW1tb/vSozj/fBS?=
 =?us-ascii?Q?9Jw+F/SToq92MKWzvZkPNHY1dPLin9kVrmXD2adQiLd6ZsTvKF1vH5pL6rmE?=
 =?us-ascii?Q?b99R1yoQbYnRS53/KrNJardncJVJEUq8ZG0Px6/sL1csRHbyuWw8hYYyhHUw?=
 =?us-ascii?Q?r1M9YrhBJndLzlbZ8ElsQY3my/ai?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 05:40:18.8398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7746d75f-60ee-427e-6840-08dce824dc27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539

- Update speed value by reading HS_SPEED_MAC register.
- Update link status by reading NSR_LINK bit of NSR register
  for slower speeds (1G and 2.5G) and USX_BLOCK_LOCK bit
  of USX_STATUS register for higher speeds.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 7beb775a0bd7..48ba19a76418 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -624,14 +624,21 @@ static void macb_usx_pcs_get_state(struct phylink_pcs *pcs,
 				   struct phylink_link_state *state)
 {
 	struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
+	u32 hs_mac_map[] = {SPEED_UNKNOWN, SPEED_1000, SPEED_2500,
+			    SPEED_5000, SPEED_10000};
 	u32 val;
 
-	state->speed = SPEED_10000;
 	state->duplex = 1;
 	state->an_complete = 1;
 
-	val = gem_readl(bp, USX_STATUS);
-	state->link = !!(val & GEM_BIT(USX_BLOCK_LOCK));
+	val = gem_readl(bp, HS_MAC_CONFIG);
+	val = GEM_BFEXT(HS_MAC_SPEED, val);
+	state->speed = hs_mac_map[val];
+
+	state->link = (state->speed < SPEED_5000) ?
+		!!(macb_readl(bp, NSR) & MACB_BIT(NSR_LINK)) :
+		!!(gem_readl(bp, USX_STATUS) & GEM_BIT(USX_BLOCK_LOCK));
+
 	val = gem_readl(bp, NCFGR);
 	if (val & GEM_BIT(PAE))
 		state->pause = MLO_PAUSE_RX;
-- 
2.34.1


