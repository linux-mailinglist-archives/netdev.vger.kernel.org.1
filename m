Return-Path: <netdev+bounces-248380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F46D07854
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A654306305F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92982EBB99;
	Fri,  9 Jan 2026 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZHU180xD"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6121C3C08;
	Fri,  9 Jan 2026 07:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767942677; cv=fail; b=kwToZkHbrDhwDnreSb3gytoNnw9uMWXjhmJAq/ZWpyauTBlyiHBCQO/sfmRf9W4mXAZAvB6+hHAovj6QDEM2kuU8oLsbTq7tO7X512aiHcyfm1FRECUOhDRYPfj3L3UD5sOhOxrsjWxR7e8FfTJ9KSPwel2P9VkeAKnfnNmA5A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767942677; c=relaxed/simple;
	bh=A4qEw3HtGtaRzA9iuC5i2Epoxh4Ikmz8PvLOoNmt1lI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjDrQBonoxL+bhblTz7okxKtCQLLyIQ1H5rAcDludp5ycVyM6ja9apDmjZW2CJifHQudMbJ4H8Py3BATqZ9Z4udoDCpyS1Xr86dcr1OKFyB4oE9Ksq+cgnASZhh5QuXu0/o0MXP53qBCYSKu6CGBsI5W+198//A1ce+0kQhaw74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZHU180xD; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ba98peHIWyyk7U+70qGE8Dy8vcVHopwZrbl2+SFDLJoR/R80Z9niLkTSKcPe3IIgyYXkGYB0W8uLlQN0hxmF1YRzUQGD8jSlBy4joq5QHmaDpDxeplaD8FojBbEL5t/hVcwKCtmvahwgY95Zjc14xaazOzNXVCaTQKJwiY9kFT7qlo5TeDE/SvGaBCtMlOYyF7NZvdaySbt2nRP6h4uWTKG/3O2P+n5ROOl1Pjz6Gsx7jda68wcrGllbyVovq7y6YCnCdokOBotAxsfQAXCDt54aZGBi5AKBwCTaMtQThohwqjnjjTsPBpL6QqTGyMlPbfOK+VaTZ2GyZbFLYpC83g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aW7uz6v3VjmITltTaGu1xzNekXqWqTMQzHelPTWvVY=;
 b=vK3GGe4uufAKJ3Ua7+ZGeSSIKbVssl+VqdqgWdlz+IyPvLDQu1GcDcMiK3E7VTsJWhoaO3kOSLHZbxqdumV6P64ACI4lpYkra4M94kW+Jv+x8/GOKSr4F794SuCCqjXhQR3BIju6JOstnZ5o0mMDjrSwmAL/UHOtCk2k/BNBCDRM8ehLRo0VuVMEPsWtIAZwmXuPlthh1dzp7xic/t+mFr7WaIQ5aU/eQk6D6iFOhXcw+qMqO3d4joUWDFhsCmv+1RAswlzs3ngTYHh+XUPGbWc49kHOhqTESmwv5zAFci75V3nk/0pXb6PaYaOGjilAZy3aY9gX7+IsZk1klHei0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aW7uz6v3VjmITltTaGu1xzNekXqWqTMQzHelPTWvVY=;
 b=ZHU180xDYlkr8GxLw6UQHjQYUDEVx7P33ttcosjB6yvwnpuZwL71ZhUSy8urkh1w6wLY//yt6Rm5oTBPwcMID0KynjYpTjqo/Ht3wDhJ2AU4kIYiLV0ZQhql0suHs5reschfV+fflft5sdHGK0/fnAcACG9966X0uTKLxRJ8aww=
Received: from BLAPR03CA0002.namprd03.prod.outlook.com (2603:10b6:208:32b::7)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 07:11:11 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::1b) by BLAPR03CA0002.outlook.office365.com
 (2603:10b6:208:32b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Fri, 9
 Jan 2026 07:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 07:11:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 9 Jan
 2026 01:11:05 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Jan
 2026 01:11:05 -0600
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 9 Jan 2026 01:11:01 -0600
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <sean.anderson@linux.dev>, <linux@armlinux.org.uk>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<bmasney@redhat.com>
Subject: [PATCH 2/2] net: axienet: Fix resource release ordering
Date: Fri, 9 Jan 2026 12:40:51 +0530
Message-ID: <20260109071051.4101460-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260109071051.4101460-1-suraj.gupta2@amd.com>
References: <20260109071051.4101460-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: f15cfcb3-7182-409c-be28-08de4f4e4509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yCLmeUGviQN4H+aDfjYfQpi1gojRbek2lCQCHjLO0KjvUuX+5FXx/nh0RdTv?=
 =?us-ascii?Q?jn3bgHNQlFKID3fmsUYvWiM4C6CIXR+MuTPd1/xfLA3SKq0jsyVepyPN70VO?=
 =?us-ascii?Q?xSRKpGvFzZ4V6vdbi1tsVKy6I1ab5MGZXFX35kmdEEk/2gEykoqfpmY7Irh8?=
 =?us-ascii?Q?goLIxolr51HF4FpPQFyXKP+96XZQKQr+Y24Rf9RpfOTh84Akh3J1tDKZamda?=
 =?us-ascii?Q?PoyXrL9Ah6kEelSh3Q3EeOKTET484czsOAUM9Ay41ZHF0xVIqrLWcEgWUIAh?=
 =?us-ascii?Q?/l57UmF5Bfdg3J1AljLaCpMKKKsBiIrAn0X0cOTdTPzaGISmCy7nigyYe1yx?=
 =?us-ascii?Q?v1G5AEuhMnCIjuLbda58ywNrXc8rO+5x7awANQtd0RycKLom7XsEGd4nhyZ8?=
 =?us-ascii?Q?TndEm3jCYaCaMYApUWSJk5zeVqU+qx/PqQeAf103NjPpBOEeV4Nb0gG/SLlE?=
 =?us-ascii?Q?EiETnqthNupItFSOVe1PCHYjeBDj9TQ20VAKb5rl110EJMhsfDa1NXFb/bTH?=
 =?us-ascii?Q?AlZtgFMeeGHnUfACH1Qe1zPAqvfEExtojtGPT1Y3qmPJ1XhuBr4GRzgkwcEc?=
 =?us-ascii?Q?TE9vo+ce6C/AJ0OA0qnJ+Dq72amSKf7khPrKF/TId/Gtog8QwpcrMyHyZ9JW?=
 =?us-ascii?Q?DwsAfQ+46+w+mvlpTBpq8gnIWX/8nfiG9Vy1gjaR46KhbVnIWDB9he47eWw6?=
 =?us-ascii?Q?ivHarFZDkRTBnyGmWySKv9692sKfUDI9d8aeGhJgtSH3fu7jHxI03ARWgVZk?=
 =?us-ascii?Q?rgeTpmxmDp9NpWKw2vfGYZL1TEEiX8ZHUNXmI3ZS5QMefRPhEDrc+WwmVLS2?=
 =?us-ascii?Q?3D/YAi4HsyonfQZkQcuLp6foX5rkaokXdD1LUcqoKN3Kmd1H2XdhRwYQj9+E?=
 =?us-ascii?Q?LRJk0tl4yHhKT2LmscAeY7V/l0ZKk5EVXfqZuYNfCQe4aukOOpCAgHKalji0?=
 =?us-ascii?Q?ZfBZ6Tc5FWbcRWrhcuCZZnySJ8PJZMW2opDrBGB+WtjCmRXWzpLFCHvcuAyA?=
 =?us-ascii?Q?heIlhOj8ccovda/6BjHkThnxxI+fNPJsAV7oaqXxx1tLZsnbFaGHArQpnBcA?=
 =?us-ascii?Q?IaB06RHHcHD9pUs/4zfz0o2QmyNkfdm87stiD8IsEPP49OjvhDjeMJFMboOl?=
 =?us-ascii?Q?cPW52l+uLQOKwJWT1gUWbEXu4RhmGUDh02nY8aDjbZLScEC70c47+Hnz3jvG?=
 =?us-ascii?Q?ABCSodwNfhnmUzsIi5oF/vHe49jMRW2W/kCvBAvm2nVJYgYXb23Fasu9sfY5?=
 =?us-ascii?Q?NlkPkUfajwoIsdbFuFEJWB82df3AGHrVPNY7jXP9Sf3bJxKx/DJRVUlypysK?=
 =?us-ascii?Q?/rCpMXLkfgCiU1SEkODnMgB5SFrOxRMeIPc/hYICqDKqBX3lALcoAhm3Bnfn?=
 =?us-ascii?Q?KzledvrJ0XRXwzU4JBYocDzCjc5FBYTPXa3mziSOtE3DHcOLt904l/fRB1pC?=
 =?us-ascii?Q?ds0z4MAQ3lSkb/LbUoSSVMmmVvIOvIZ3yI5e65f1Zhl4XtgRKs8Afhp2u3Pp?=
 =?us-ascii?Q?THooE5bC8RAZF72QovabILRTiKYYD3Orp9Cmfyt0pRHnwnKT+swVDT0y/WkZ?=
 =?us-ascii?Q?CdGiAPjBmQLvN8Ajo+0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 07:11:11.7062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f15cfcb3-7182-409c-be28-08de4f4e4509
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053

From: Sean Anderson <sean.anderson@linux.dev>

Device-managed resources are released after manually-managed resources.
Therefore, once any manually-managed resource is acquired, all further
resources must be manually-managed too.

Convert all resources before the MDIO bus is created into device-managed
resources. In all cases but one there are already devm variants available.

Fixes: 46aa27df8853 ("net: axienet: Use devm_* calls")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Co-developed-by: Suraj Gupta <suraj.gupta2@amd.com>
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 83 ++++++-------------
 1 file changed, 27 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 284031fb2e2c..998bacd508b8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2787,7 +2787,7 @@ static int axienet_probe(struct platform_device *pdev)
 	int addr_width = 32;
 	u32 value;
 
-	ndev = alloc_etherdev(sizeof(*lp));
+	ndev = devm_alloc_etherdev(&pdev->dev, sizeof(*lp));
 	if (!ndev)
 		return -ENOMEM;
 
@@ -2815,41 +2815,32 @@ static int axienet_probe(struct platform_device *pdev)
 	seqcount_mutex_init(&lp->hw_stats_seqcount, &lp->stats_lock);
 	INIT_DEFERRABLE_WORK(&lp->stats_work, axienet_refresh_stats);
 
-	lp->axi_clk = devm_clk_get_optional(&pdev->dev, "s_axi_lite_clk");
+	lp->axi_clk = devm_clk_get_optional_enabled(&pdev->dev,
+						    "s_axi_lite_clk");
 	if (!lp->axi_clk) {
 		/* For backward compatibility, if named AXI clock is not present,
 		 * treat the first clock specified as the AXI clock.
 		 */
-		lp->axi_clk = devm_clk_get_optional(&pdev->dev, NULL);
-	}
-	if (IS_ERR(lp->axi_clk)) {
-		ret = PTR_ERR(lp->axi_clk);
-		goto free_netdev;
-	}
-	ret = clk_prepare_enable(lp->axi_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable AXI clock: %d\n", ret);
-		goto free_netdev;
+		lp->axi_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
 	}
+	if (IS_ERR(lp->axi_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(lp->axi_clk),
+				     "could not get AXI clock\n");
 
 	lp->misc_clks[0].id = "axis_clk";
 	lp->misc_clks[1].id = "ref_clk";
 	lp->misc_clks[2].id = "mgt_clk";
 
-	ret = devm_clk_bulk_get_optional(&pdev->dev, XAE_NUM_MISC_CLOCKS, lp->misc_clks);
-	if (ret)
-		goto cleanup_clk;
-
-	ret = clk_bulk_prepare_enable(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
+	ret = devm_clk_bulk_get_optional_enable(&pdev->dev, XAE_NUM_MISC_CLOCKS,
+						lp->misc_clks);
 	if (ret)
-		goto cleanup_clk;
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not get/enable misc. clocks\n");
 
 	/* Map device registers */
 	lp->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &ethres);
-	if (IS_ERR(lp->regs)) {
-		ret = PTR_ERR(lp->regs);
-		goto cleanup_clk;
-	}
+	if (IS_ERR(lp->regs))
+		return PTR_ERR(lp->regs);
 	lp->regs_start = ethres->start;
 
 	/* Setup checksum offload, but default to off if not specified */
@@ -2918,19 +2909,17 @@ static int axienet_probe(struct platform_device *pdev)
 			lp->phy_mode = PHY_INTERFACE_MODE_1000BASEX;
 			break;
 		default:
-			ret = -EINVAL;
-			goto cleanup_clk;
+			return -EINVAL;
 		}
 	} else {
 		ret = of_get_phy_mode(pdev->dev.of_node, &lp->phy_mode);
 		if (ret)
-			goto cleanup_clk;
+			return ret;
 	}
 	if (lp->switch_x_sgmii && lp->phy_mode != PHY_INTERFACE_MODE_SGMII &&
 	    lp->phy_mode != PHY_INTERFACE_MODE_1000BASEX) {
 		dev_err(&pdev->dev, "xlnx,switch-x-sgmii only supported with SGMII or 1000BaseX\n");
-		ret = -EINVAL;
-		goto cleanup_clk;
+		return -EINVAL;
 	}
 
 	if (!of_property_present(pdev->dev.of_node, "dmas")) {
@@ -2945,7 +2934,7 @@ static int axienet_probe(struct platform_device *pdev)
 				dev_err(&pdev->dev,
 					"unable to get DMA resource\n");
 				of_node_put(np);
-				goto cleanup_clk;
+				return ret;
 			}
 			lp->dma_regs = devm_ioremap_resource(&pdev->dev,
 							     &dmares);
@@ -2962,19 +2951,17 @@ static int axienet_probe(struct platform_device *pdev)
 		}
 		if (IS_ERR(lp->dma_regs)) {
 			dev_err(&pdev->dev, "could not map DMA regs\n");
-			ret = PTR_ERR(lp->dma_regs);
-			goto cleanup_clk;
+			return PTR_ERR(lp->dma_regs);
 		}
 		if (lp->rx_irq <= 0 || lp->tx_irq <= 0) {
 			dev_err(&pdev->dev, "could not determine irqs\n");
-			ret = -ENOMEM;
-			goto cleanup_clk;
+			return -ENOMEM;
 		}
 
 		/* Reset core now that clocks are enabled, prior to accessing MDIO */
 		ret = __axienet_device_reset(lp);
 		if (ret)
-			goto cleanup_clk;
+			return ret;
 
 		/* Autodetect the need for 64-bit DMA pointers.
 		 * When the IP is configured for a bus width bigger than 32 bits,
@@ -3001,14 +2988,13 @@ static int axienet_probe(struct platform_device *pdev)
 		}
 		if (!IS_ENABLED(CONFIG_64BIT) && lp->features & XAE_FEATURE_DMA_64BIT) {
 			dev_err(&pdev->dev, "64-bit addressable DMA is not compatible with 32-bit architecture\n");
-			ret = -EINVAL;
-			goto cleanup_clk;
+			return -EINVAL;
 		}
 
 		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(addr_width));
 		if (ret) {
 			dev_err(&pdev->dev, "No suitable DMA available\n");
-			goto cleanup_clk;
+			return ret;
 		}
 		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
 		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
@@ -3018,15 +3004,12 @@ static int axienet_probe(struct platform_device *pdev)
 
 		lp->eth_irq = platform_get_irq_optional(pdev, 0);
 		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO) {
-			ret = lp->eth_irq;
-			goto cleanup_clk;
+			return lp->eth_irq;
 		}
 		tx_chan = dma_request_chan(lp->dev, "tx_chan0");
-		if (IS_ERR(tx_chan)) {
-			ret = PTR_ERR(tx_chan);
-			dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX) channel found\n");
-			goto cleanup_clk;
-		}
+		if (IS_ERR(tx_chan))
+			return dev_err_probe(lp->dev, PTR_ERR(tx_chan),
+					     "No Ethernet DMA (TX) channel found\n");
 
 		cfg.reset = 1;
 		/* As name says VDMA but it has support for DMA channel reset */
@@ -3034,7 +3017,7 @@ static int axienet_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Reset channel failed\n");
 			dma_release_channel(tx_chan);
-			goto cleanup_clk;
+			return ret;
 		}
 
 		dma_release_channel(tx_chan);
@@ -3139,13 +3122,6 @@ static int axienet_probe(struct platform_device *pdev)
 		put_device(&lp->pcs_phy->dev);
 	if (lp->mii_bus)
 		axienet_mdio_teardown(lp);
-cleanup_clk:
-	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
-	clk_disable_unprepare(lp->axi_clk);
-
-free_netdev:
-	free_netdev(ndev);
-
 	return ret;
 }
 
@@ -3163,11 +3139,6 @@ static void axienet_remove(struct platform_device *pdev)
 		put_device(&lp->pcs_phy->dev);
 
 	axienet_mdio_teardown(lp);
-
-	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
-	clk_disable_unprepare(lp->axi_clk);
-
-	free_netdev(ndev);
 }
 
 static void axienet_shutdown(struct platform_device *pdev)
-- 
2.25.1


