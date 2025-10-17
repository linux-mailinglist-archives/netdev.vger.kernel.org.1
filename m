Return-Path: <netdev+bounces-230342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51427BE6C44
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 184E13401D3
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3B130FF39;
	Fri, 17 Oct 2025 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g5ssGqP8"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21730FC35
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683664; cv=fail; b=V4JBXzCYj2uihpG8ccJcgI+RNBOVyiPNWgdzyu78b+NOWlc2CK8nQ4Cqz8ufViyEGvcvH0FuQqk3DPSz4XLA2YSCGf8qU/yKMupsPNw8UAVClyGTTi45IylwIQKtPEsLSaksIcgsoc1VO/uF2JIWM0Cy8t6bDdNQC71XsdfXwSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683664; c=relaxed/simple;
	bh=xvBIT0wTUIe9bMbFt46/NUZ5LFoIZUxM4uzabfZihTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbdIUH5gr1xHUgaMwZ+UGIpNgJUFC25BgCWjKCj4p5GPEIQO/LvMY9yZTkWPV79fM1lfNzddUUIZBtAhWS3HKc5+Cef5cLzwRg6+AoViljBd31Ww7QOi+bRmbwwcUHSTQZGxDDbwoTNJJ66O2z8LNS6aq+TkfC0oSl5hu+twRX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g5ssGqP8; arc=fail smtp.client-ip=40.107.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUzZgqJCBe8oxlyCNYRLteF1vrQftdnp3kaBH73Q86gg62da9/JQeutabKPfzKNLhyfTNo0fuiEPZyyYLK13lEhfAWdYr8g1dH3rnPptxvNX79vRxI6MUa1l9lH299AZUDoMop1qdVhJBEBz4dTkzdPAw0V5h7VG0vSOnPd6y7tn7WZ44CYhJ87gaEe8fgiP5/LIx0T8CmXY5sOnBOjJoBRLZm3RWczvlQQtY3hLUt7ZZ6KVhpNU2ZwSo7/LxqiyrQsAWWIoHx9KPlwoPK64pqUrK0exVBbk2tFWEqGhMufUvVV94TF4DxEBxW06izNsjPHOuCNwuaYT1nfmSqZBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q127R12LnuRcn3frWcWgNaKdFAGizuDw2XAWON/62/Y=;
 b=Nc4yrpsycUU7n3KvcbIlW41Yp7gR0UTwb6I3xMs0KMuWqgrrbqYi/DgQNBgg9+usKdfP3eAo7YRSuazUk7nW8M/y1GxkB/Fc5tlZXcH7LVwlvIPwGToGjjvuivLwU4Dw0LcG4pb1V4QAp48pM4WxCp9jKRgJ5cupDhucFT69/6Imrhnt3NKCkM5+KNBugJeEMWaJc3LYmywma+g6Psv7P8eU6VWkVhIRgMS/xc3QAiCinJkUOVUIGGCHFrZWQJ9Rr/V2NRA7xsJmQwe2VQWgUtlpq/CGxDFX+t4nFZmntmSj5Hm6z/zCfYPaNj04wKyeteEZtBgB0rNdtTfta5dfYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q127R12LnuRcn3frWcWgNaKdFAGizuDw2XAWON/62/Y=;
 b=g5ssGqP8l1Y1dbZnXqAUTaOlbt1B/tdpBuT3cZysA48lGQ1el9BtqIxmcxVbcPKMpg6vlBYeL/wrMkk6oy3BiCktrmEFwsIcyQjzPkAHvLEAG00PiE+pR+vHJeiEF0q/3aegpxXPpOAERrD9QkSka5AyalTXIKa63daChXEpeIM=
Received: from DM6PR17CA0010.namprd17.prod.outlook.com (2603:10b6:5:1b3::23)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:47:38 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::78) by DM6PR17CA0010.outlook.office365.com
 (2603:10b6:5:1b3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 06:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 06:47:38 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 23:47:32 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 2/4] amd-xgbe: add ethtool phy selftest
Date: Fri, 17 Oct 2025 12:17:02 +0530
Message-ID: <20251017064704.3911798-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017064704.3911798-1-Raju.Rangoju@amd.com>
References: <20251017064704.3911798-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: e634b3c4-cb46-46bb-26b8-08de0d490fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TNoRgan/X7/Y0tjqajXVZmnXWOU+wXigFm5wOegOdlcF3/HOlEjrKkYhiyZ3?=
 =?us-ascii?Q?9ZE7GoCK7uQelL+8l1CNDr/IGM7nNn7iCTb9RVZqSQ1RxQxlIXcLKQgYUvcZ?=
 =?us-ascii?Q?1uY2R8ucPLp2dkdzleVTcjb/+Es1rEIa+pkXAL8Eb5ILkY6QFDiOloCBIznG?=
 =?us-ascii?Q?xY3WoqTvi+5V4DE38HxgZGrcLOnMC49WUj55KUThpdYPo+81ZDVw9F0mqyo0?=
 =?us-ascii?Q?wnxKAqSBT9RaCUMPDuueP+InUjW7i85xAX7UO94hTjXHAt24krZE0AXbhl8i?=
 =?us-ascii?Q?6aSmhd2qIkrrhlN2OzMmJ1tXeItyjv1KuuHsTDPDiYMymQHSj1vjqQo+P6Mi?=
 =?us-ascii?Q?OVrcRHg5YgZ1a2LXIvanjsm+9CfXUKbvR+4aSU/jl13SUuR0pkV0Dg2nnSR6?=
 =?us-ascii?Q?RYcImExwHk3T1CaG0Yx2MRApQrkpkNFhzhO5n2uS7FbST8lz8g2cIncAU3zo?=
 =?us-ascii?Q?A0ydulDSx5uQqD6N01gkEKSR4bxVKbr5hmX2ABEdg24fORw74J1L7FdLw7JT?=
 =?us-ascii?Q?kT/vlQp2kqV7L7gIlQoUtnioYmaiPuSawTd4OZ/KokYV/FM5wS6xlkRmuGnr?=
 =?us-ascii?Q?jfiPxxCTUPJJwI8YLTLQ8bMBXC7RYypOv5biOGSX4UXTTCBtls3gHlaD5tOX?=
 =?us-ascii?Q?PfsLOqvp3woeoqDw7RzUXAHtZXGeTHROdpYHEzbNTTy4DKeYb2H4Lg1ym7Yd?=
 =?us-ascii?Q?cqPOaypGIVTP98Ruv85dn/bC7sn/Zt2V8YpARUOCekovBU2vQlxXkz8a50Ti?=
 =?us-ascii?Q?5dTZIvzrOSXUS1U3ikXhjTT/krOwEYCNVZJ0x76MLZZB3Jo1OzKeG2Deex/n?=
 =?us-ascii?Q?2enJpgRLRHr/G9DSNoGz0M2ahIikG8vWKYu+HBGm5ClJojgMCO2ZMX6TWvFF?=
 =?us-ascii?Q?5t4ThTg2RdxyDlzum3qRrh1Qxk5ZFD1OaEochwUr1aO+oj4rsa1yNh2eMsLy?=
 =?us-ascii?Q?/zbt4A1609rG+14jsKG8rDx/ZfvDHHQqfKlTp5Ft9EAkNWim8Rj6lKIzBXNb?=
 =?us-ascii?Q?Kag/CkLgbl2g6iozcxfLBX7dcjsPQlgIxy7emabLil23qBALB7sADqH1lX1M?=
 =?us-ascii?Q?ka3HEz3EHiYbPRz9yGwguKGXy2pYsARN/y+kamqr6woMR/ayo0zKVyKfKI6w?=
 =?us-ascii?Q?nZI8d/MwMTwwbCvfP741yeFaTosW/jS2ah9HZWgw++/cwAsscdnMU+grYVb6?=
 =?us-ascii?Q?zJsomWS5ZHrZ5VZTiiJWPpHZocVDrBXusN/mmfPAHIZSnsHpUtL4oA0F0CLi?=
 =?us-ascii?Q?OFqfOxfFUkWyRzkwma//+7CYk+nonAalLfRXOUEFSs080haL31iN2RbBS0LM?=
 =?us-ascii?Q?9lrRDIwUVbh4921deLk2HChU3RHz6Rct8iQ0tO2n/2F+Q4KMoDJsXaLg4ti+?=
 =?us-ascii?Q?nFqIjUpa45/0vYjJFQ70Rg2pA8zqDee2MfqqjGz7XQDf6K8mSqMODXzFks6Z?=
 =?us-ascii?Q?bNJlF7l6h2cqUeCYvnG2NLc+oPK6BUoKmYLlF5ioEDlKwWnJWaQ8Zvpte1Yv?=
 =?us-ascii?Q?+7/rfLIEzQzdn3veBqiMwIdSkztAeK+NIGfYISN0Qxc2yShJZVNRyek9jlAZ?=
 =?us-ascii?Q?1QTRDHhpVIygg83JLuU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:47:38.0666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e634b3c4-cb46-46bb-26b8-08de0d490fc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

Adds support for ethtool PHY loopback selftest. It uses
genphy_loopback function, which use BMCR loopback bit to
enable or disable loopback.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 5209222fb4de..0c7770aab979 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -23,6 +23,7 @@
 
 #define XGBE_LOOPBACK_NONE	0
 #define XGBE_LOOPBACK_MAC	1
+#define XGBE_LOOPBACK_PHY	2
 
 struct xgbe_hdr {
 	__be32 version;
@@ -307,11 +308,36 @@ static int xgbe_test_mac_loopback(struct xgbe_prv_data *pdata)
 	return __xgbe_test_loopback(pdata, &attr);
 }
 
+static int xgbe_test_phy_loopback(struct xgbe_prv_data *pdata)
+{
+	struct xgbe_pkt_attrs attr = {};
+	int ret;
+
+	if (!pdata->netdev->phydev) {
+		netdev_err(pdata->netdev, "phydev not found: cannot start PHY loopback test\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = phy_loopback(pdata->netdev->phydev, true, 0);
+	if (ret)
+		return ret;
+
+	attr.dst = pdata->netdev->dev_addr;
+	ret = __xgbe_test_loopback(pdata, &attr);
+
+	phy_loopback(pdata->netdev->phydev, false, 0);
+	return ret;
+}
+
 static const struct xgbe_test xgbe_selftests[] = {
 	{
 		.name = "MAC Loopback               ",
 		.lb = XGBE_LOOPBACK_MAC,
 		.fn = xgbe_test_mac_loopback,
+	}, {
+		.name = "PHY Loopback               ",
+		.lb = XGBE_LOOPBACK_NONE,
+		.fn = xgbe_test_phy_loopback,
 	},
 };
 
@@ -343,6 +369,13 @@ void xgbe_selftest_run(struct net_device *dev,
 		ret = 0;
 
 		switch (xgbe_selftests[i].lb) {
+		case XGBE_LOOPBACK_PHY:
+			ret = -EOPNOTSUPP;
+			if (dev->phydev)
+				ret = phy_loopback(dev->phydev, true, 0);
+			if (!ret)
+				break;
+			fallthrough;
 		case XGBE_LOOPBACK_MAC:
 			ret = xgbe_config_mac_loopback(pdata, true);
 			break;
@@ -369,6 +402,13 @@ void xgbe_selftest_run(struct net_device *dev,
 		buf[i] = ret;
 
 		switch (xgbe_selftests[i].lb) {
+		case XGBE_LOOPBACK_PHY:
+			ret = -EOPNOTSUPP;
+			if (dev->phydev)
+				ret = phy_loopback(dev->phydev, false, 0);
+			if (!ret)
+				break;
+			fallthrough;
 		case XGBE_LOOPBACK_MAC:
 			xgbe_config_mac_loopback(pdata, false);
 			break;
-- 
2.34.1


