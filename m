Return-Path: <netdev+bounces-96854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B58C80B1
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3E51C20F9A
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 05:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEBE1171A;
	Fri, 17 May 2024 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Et1jeXC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E441119F;
	Fri, 17 May 2024 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715924888; cv=fail; b=Fg95IPN0kXo2CP2WXTs68tupfu2ssIBZMmouZtAP91R9dPNpotPwNMogyaXHMTN0QY37mP7TtTPdVxTdtoH4RUYmD/vozktccIoBWF/owRcpRo7tX0tWlixEHLV3pd5z9B+GD4Z6Yu1GpoUwY8GCU1PDUrV4TfcLpVB7HrSvRkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715924888; c=relaxed/simple;
	bh=5VlVJv5yV6i3Nky/kH+43QM0jpBYuSuOELKYXv6VHTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrfMtDa5sbg6MJk5iYVTopH6adH9/QkJiQTCdmp4CjAc8eAyayt/+SL3QDqvoJHRKFDpV2SYPzFVmWSUpxvfWrPfs/GMsmORJFq68b2IUS4BDzEF72D7rjzyXPKuFVpsI6t5E7YLpZgdySmy4R4o09kNPQD7E/mWCAswsbH3WeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Et1jeXC; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYCCYQm+tA/IEdJA83YKVOnRvoXcWBHHx4yRkmMMy1+AOkdJrn992cWZw2tMLGBS9dRfttCQjbyxA/lkP7ymi+pCow6l8VSNkgDy+9Anx95RYFoPuTAFwTsAZ85PUzR6tMfnllqm31Bmzupm9r9Q/R5wNb8C2wYGfVzM6SajpPfFo2LhNbneAslwyTUrcMbNKc3ZCkHwGb25lJg+zx5vdCu3qb4gWWdakkNd/B5A2bR5DpdewSa9i2UwMGfZvxwvSO7quo3aZNbXnRPX6xrWH8pfMHoPF1dLfkJ/5Uc+1i+YsRl7l1YSufAZ8AgjxqKVf5k/IgUIMJ3aQ+c8prn2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKz2fyvnyIieCzaxrW453Xa2ySv/BXkmtHsBH8UfvLc=;
 b=WFKtcBOdfEWK8FHnb4RlsG2yZsnNGtCGIXbV5eXDN4Mpb3dO9lvSJal8TJWfs0CM7ogQwIiTDIEe4/wpqef/d4uXBWfyBA3To/uj6oZnNKMCRguZdZR5xRM2XTDkDbtaF8CM9Wt+9ups2N/wRQ5CBrw0qyHP48AL7h3MbPlggRcgZA7HZEw1X1qPRQQvJZLpHulVBp5Xe8HrRNjV2huPpGzXQsamNAhbng55ApSET8rhVbx5hyF/BzoU4+OY8737QPXBkZ9zEJ+rAxtr+EJTtKBsCXFdahF4J4IwaJeX5WbWMWUQrNVc93FzxjoOJpWzI3EjwlG/yKOQaNchmH5v/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKz2fyvnyIieCzaxrW453Xa2ySv/BXkmtHsBH8UfvLc=;
 b=3Et1jeXCKYSQO4VItQbLR9KWnseTT48O6KOIPH+OpRsW75FGJntvkigkFSGe56jE9cv3z/okSw0Yd+tZe2984PRysDno0A41SFvqcBHYBivS/beN9qmfqLTSH8weYbDyHjEo062seIemUFU/xRybFw4kC133YdrtJicsuw7kZaY=
Received: from PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::28)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 05:48:01 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::81) by PH0P220CA0014.outlook.office365.com
 (2603:10b6:510:d3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30 via Frontend
 Transport; Fri, 17 May 2024 05:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Fri, 17 May 2024 05:48:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 17 May
 2024 00:47:59 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 17 May 2024 00:47:55 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <harini.katakam@amd.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<michal.simek@amd.com>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v2 2/2] net: phy: xilinx-gmii2rgmii: Adopt clock support
Date: Fri, 17 May 2024 11:17:45 +0530
Message-ID: <20240517054745.4111922-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517054745.4111922-1-vineeth.karumanchi@amd.com>
References: <20240517054745.4111922-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 4454c9ba-e816-4cab-6c95-08dc7634e993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|36860700004|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f82vIei56SXGN+XmAQXnUXRtYrpKFcQRc0I19QPecDCiyWgGDF7J5Ke8eHCI?=
 =?us-ascii?Q?nXRy0WCgpVOzHI136uivAfRqra03VTqeaqyZpXdjvvcFQy9J4Jo2/ufcDHxh?=
 =?us-ascii?Q?fAZ2MwjGUYfikdVt/RtpwPx1iJMt1NYblowKcA+CozdT6mDVws9Mz+nge1/4?=
 =?us-ascii?Q?/pJkgU+BsEtK3khzETHRrAGY5HbEzO20QJrrj5wTSWt4nxVn9EaEJF9zTDmH?=
 =?us-ascii?Q?2V5xo6+tzWsV6XJSQh1YuJLnfc1a8cb27GCwLCUlmaagAQ3LKNWgiOTPTk+D?=
 =?us-ascii?Q?i1t/pS6DYk/uQGtr4ICamki7fv6ndymR9T60KNPqXUvZ9HdAH3LraWBU/Kb7?=
 =?us-ascii?Q?2bLOXMPbb8Jz6WqWxVWwitxV883xw+p3lgWvsdVCggBcizgE9ziW/2HEy2QZ?=
 =?us-ascii?Q?RM6sOm+VL3y0fDClq574LjRjsn413zYzdQQH5DBJTaBTjeNAajsiLg80trlz?=
 =?us-ascii?Q?ly01731B2wi+4UjXBiOgyJv2KSwuNaZu0BNdKtFbo6JqtP6+ddXBxLohSJqU?=
 =?us-ascii?Q?95PLxN8R1wKA1PKSXtrsW7cZWatbzQmtuKc9Z5XLDeF45MzbVxzDPrYny/Va?=
 =?us-ascii?Q?atWBtpj3zuhPHI2rG8S2UDK7vfmJfQ+HerecvpX0tE1vz71nwPnj2Rrh8DJv?=
 =?us-ascii?Q?1CVO6JzXkdue3W/lqCFf7AB3UaA11vrM/qGz3l8sgrd5wFphj53wZksXCOrr?=
 =?us-ascii?Q?JiIzAe1aKyg5eYcwefG3vq8Lq3Eso7weK1HToShTuMecU2/Yyh4vTpbb/n33?=
 =?us-ascii?Q?66El3UoeJhNlqXYgjFC9INqn6YRRG9uvbR5Ifc+goj++8wLVOq1JqYtCL6Ar?=
 =?us-ascii?Q?AxcBylhKo3LnXQp09Vr5CsMXeZxLiPhTpRUIH/oWnPqZwciyxB9hLNWkJILX?=
 =?us-ascii?Q?6seW/a3gBLqI3i5cZPtriNztNpDeFeSnMrkhmM8ODPctiSyGgXoEzDhHxB2k?=
 =?us-ascii?Q?Tn13MRt+XvkB4+7/zJQ/wlO/IJs1UGFGmnlF6T8oFSZCCn+p9WOgjln0ZoMO?=
 =?us-ascii?Q?LDKAyquNFNHPYIirAiA4ruoPrRi509uI2bZbHRc/589mgeSPreUoTRcvWYpI?=
 =?us-ascii?Q?LnhpCOIkpgDo69VBuPYeFgBNgfiZ5ltX2AtE8C/ujlxFWq20eAe4PF6xu9w0?=
 =?us-ascii?Q?1obLgr/g9K33bLpAJWOuBAsOa2aICMVN5p5NK5pAuO8ZoC0qx1i+JoV7TQUV?=
 =?us-ascii?Q?vIgCp7g149mx85UI+Of0B5OOP3bkNBKRtYuLykXFkh1NoZZRoJrnR76g/skE?=
 =?us-ascii?Q?cHK0lDLfqGVSBGZyu5TW2iTXz6QgOkdOpfXIogFw/RbDbmIK4CV7S3GSUKQK?=
 =?us-ascii?Q?Et+/hAlX/rOehTeOb1EUAKA5Kdxbl/m48fJIQtMuKj4MBZcd1RfZ0JhoNLNr?=
 =?us-ascii?Q?KyqMQzauBD30Sm0LionIZ6YJMtuQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(36860700004)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 05:48:00.8116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4454c9ba-e816-4cab-6c95-08dc7634e993
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643

Add clock support to the gmii_to_rgmii IP.
Make clk optional to keep DTB backward compatibility.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 7b1bc5fcef9b..7c51daecf18e 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -15,6 +15,7 @@
 #include <linux/mii.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
+#include <linux/clk.h>
 #include <linux/of_mdio.h>
 
 #define XILINX_GMII2RGMII_REG		0x10
@@ -85,11 +86,17 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
 	struct device *dev = &mdiodev->dev;
 	struct device_node *np = dev->of_node, *phy_node;
 	struct gmii2rgmii *priv;
+	struct clk *clkin;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	clkin = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clkin))
+		return dev_err_probe(dev, PTR_ERR(clkin),
+					"Failed to get and enable clock from Device Tree\n");
+
 	phy_node = of_parse_phandle(np, "phy-handle", 0);
 	if (!phy_node) {
 		dev_err(dev, "Couldn't parse phy-handle\n");
-- 
2.34.1


