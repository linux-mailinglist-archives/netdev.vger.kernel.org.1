Return-Path: <netdev+bounces-203022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3E2AF026A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 20:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9EE4A0487
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE1122D7B5;
	Tue,  1 Jul 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E4t9QCy7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9B51B95B;
	Tue,  1 Jul 2025 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393040; cv=fail; b=KdV597IQHBVKIfEPJCYll0bz7D+mVRNzyAkauedtk/lb+28IfBpwlJzX+kjXeIzKQIeIvuUoq20Prne+l//jIQFJYVcrYB8sJYMURyxpyMnRGFkPrt3SX+oEZDdB6Ww6qmXbsbrk5Hg0yDsTIYTyudsnnNRPYQ/J0g3Rcnstvvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393040; c=relaxed/simple;
	bh=qeJd6zCKkRuSwYXNZ3SbsY5uGK/+uYOw+MSyFtazziY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=czVVT7wqNA7R9IU2x3f7nI7lQxnQpvpzGrg1OOXrQNF45c+V4V+uKntlnMVHmMfNKmi4CF4gQnXWRjt/3qlmGh6RfO4bld9fNFqhq4mNZYM2HMKXpkwrMWrnor0uZWD2WXSyAyQwmUrR/S8398fsiMrGqDVh7yCZ37OuA2CnGHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E4t9QCy7; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrNL4xkAr5q+UcJtAdpzHGJvrr09bXGGPBQg3vV7rNmpa8AlrNxBkfgX7M5jES1NJvAlbKMx0eSd8AQxZdOhbyKWIzNms+Wl0amvrKH6UP3iJGOqrUCWhhmPXp9e0XxozfucaCZHTKSikK+NWkhazl++zqeYb3vsJJSak3w3ga4YxvdAKTSIJ8tTjCVzK82oOt2axEGpdgqS6AvhI5pbCm7MvxUIdX3Pzxhjlz8DqWm8x6T5aQMdfGZJAN6uZELxONZRpF5Tt9K8L5GUKjNcz9MyoP53p4Fxp5NMrUi4QMcl3mCbaZKrJFW1q8O+7uwll6F9wX3ICjL4GpACXRIowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uhhf/sbKPfhGgAEZ95mduy9BRy9KubpaT+mtdCqn8AQ=;
 b=HfmdcCD7rH1t2CVZdXy0KeLP2nFvj18HSqy3IF0p+UCuf1RdNyNcc+DwZubVYPvFGP1+y341mBPEChQCJwuHjLFve29bzozC/dTmAcvE70VTDRwI4k5AARLEdmVx+nuGRzCBJnAqdQG4UIatBo0haRc/0JS8+tLHiWCXYqg/pGrq5JtpLm3hOkJPFLyP5pvF6MTeRiiYR9x600RUt4lbo4QIW2hvPQ4cdasRMyefoNHHUosnFkDy6NWwUxlUra82zyG42xv5MWj7xbgvI/DTwYHKgDxfYZrvIq3LPpp34JfMea9gpjvRGOkarEcbL7P/ZD5YZzgaqv8KGhxDcBK5jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uhhf/sbKPfhGgAEZ95mduy9BRy9KubpaT+mtdCqn8AQ=;
 b=E4t9QCy7oGfS6hNnG1fYHBRR2Q94ogcl2gIHrKj8jIAxOQ/181haNEsmGWou7ImTSiotZHMhrYiUANLCQDIa9deH3Nbgqj1Dg8m4m/06MwCEDWky4Q6Ui9QA9c9969ab9TXU/91u9/jHqQHneJiziDvvC8Wvc8G8CH16vP5ac+VjurM8XV8p4zN4xj1PLqU+2GBqxO0zEaoBLDjUgVMmJXtL8zS+kY1/8Puqz1UnMT6q6F1BacB5EvtEL6B16/Ued0gthYdNQ0fQcmUO/coUZ+G7XIEKxjlbwMekvRBJpXhWxbLzMEhVlsRlCPVTl83fPxBt9tYS+CaByDg0Jt39+A==
Received: from SJ0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:a03:331::10)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Tue, 1 Jul
 2025 18:03:53 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::37) by SJ0PR03CA0065.outlook.office365.com
 (2603:10b6:a03:331::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Tue,
 1 Jul 2025 18:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:03:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Jul 2025
 11:03:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 1 Jul 2025 11:03:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 1 Jul 2025 11:03:30 -0700
From: David Thompson <davthompson@nvidia.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<asmaa@nvidia.com>, <u.kleine-koenig@baylibre.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: [PATCH net-next v2] mlxbf_gige: emit messages during open and probe failures
Date: Tue, 1 Jul 2025 14:03:24 -0400
Message-ID: <20250701180324.29683-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fe16e5-c775-4f79-12da-08ddb8c9a3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V8FDruQVWWhR6kezGfLSbJAFm1JMquRheqS4BRsvRkIRJ+mBmWf19sxe8xpS?=
 =?us-ascii?Q?fjPGtvPpsmY6XUhVf4S2L0bgkWyP4TM9pzu+MxMY5pwYkRmSJvsJN4enSuog?=
 =?us-ascii?Q?TGpCtMH6U0p0CYO9BVnO/H7StCifQgUaqtQF3frs0jiSzjwJ3i3YFDI/hap9?=
 =?us-ascii?Q?UPHI8sjGAMC/wFvEoqY78ZU1ZcWaeYjGryFZZ7s6fw/7oijGTHUhleQwRBqb?=
 =?us-ascii?Q?+Vxnwa1BYWl/ygD0yklu+sq5ANn3SlfcRpJr/nzsOn+eGo5tJ4uEeWvLdHXo?=
 =?us-ascii?Q?XGsJJnWTJpOhDM9OC7QSkwxAAJDuC/A9wl+E55imUNBKviLMNVGcZAOZ+YQZ?=
 =?us-ascii?Q?ygqtYSoLjXRUnaLLug7zfa58i7P72t3vKGoX6eU6iEAD4NPrugIUg1a3Pr8A?=
 =?us-ascii?Q?9X/2QDXzvd4vct4XrqrbSk3lI/Z1neIALwx0E11QVAiW3HSvQeq/e4jFut2c?=
 =?us-ascii?Q?Hjp9PcyTfo12HUauBa0C1H0C53+9IxPpzRppGKDi9ZsuYUS/IkbZYzx7Z5vu?=
 =?us-ascii?Q?QG3Jq6TG4S6ouBCrgn7LxyWyTVNk9PIR/dnHt+2tMCBoBQ9dwv9yHaHnZjfg?=
 =?us-ascii?Q?e+Vi8uRloYcPRNaxlO19ftdtFDrfD4eWAE2mc1KmhDhkkF6MgmzsbWWVTqb+?=
 =?us-ascii?Q?adXSLFGpxIoA9DIGALXCyAiGxP30JgFJZpd0X4piuPm9Gla04kOeU9W4TGh8?=
 =?us-ascii?Q?5776G4aDYC9kRNoAES83JcCW9yKQtnuxyGv0ylLUaHBbeXS8qWYT3lCgT4eL?=
 =?us-ascii?Q?l2aPDTsNXdswi9M5EaZ/YWHFk2VbxVwM4E6/w/g60HXIcxJBhFrGcxVzEngM?=
 =?us-ascii?Q?71ELIeFHhE/4d3rnCgaaH6fdeafNLKLupb4R/jg/mHs8nDd4hp/XkWaEotF6?=
 =?us-ascii?Q?SAzQFBGa0oGrUnXYXEmUIYnHf/mN8M3OTYpy5T0jPjxKfiv4VJ97BH01ylY+?=
 =?us-ascii?Q?PyzJFdR1Qxp4kn1UZHYlGldZWVi50AIOV7+b/NMtCrS18/zQV4ZX/Ee0eEow?=
 =?us-ascii?Q?Vb7260I9G+24/5ZvpKwjllgky1jCxf9EDz1/dit5nLdTKPtGokiybR1VUS9V?=
 =?us-ascii?Q?qT9ovUdgozkykT5+IedojIGi9ZoVk3/yad3TpBmfINTaeWE1Gxwuk9TZL8oi?=
 =?us-ascii?Q?nt1ad5NuE17bxrDb8YfT9/6AaPcXM9Na2TW8EzQe6tHPzVsF2vq4PQHvvZdw?=
 =?us-ascii?Q?062OkWf6CO7SI2zKP9KhbxsAIcZS2Ozo3JLt+i2ze8kfsuzDlnhoItu/d+r4?=
 =?us-ascii?Q?vN1/mGZy/FcmtedTL35i8UEq0J+j/3ex56k8t4D4HRpS++b9NcYt/gDqJr9u?=
 =?us-ascii?Q?dPMw22IXcj2ngbweTsfkDyfGPWqGi3jfeLcqbEEtXoRYYv98oDM6iUnkGgaN?=
 =?us-ascii?Q?FRFMS7A2RHXwZizwrDP6JLuNYGLSw43i03AHrKlQnhN2c/T9xXNCSHX8PIai?=
 =?us-ascii?Q?cX6jZri4TvKrsdiUHAb1I9MbyAurGtqxRcp5oj6V/oufnU4g3z1g7tldQmyq?=
 =?us-ascii?Q?6Itc2q7wJdAprAh+Sj3Cew6yMZaAu8U7QoOn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:03:53.1001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fe16e5-c775-4f79-12da-08ddb8c9a3c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128

The open() and probe() functions of the mlxbf_gige driver
check for errors during initialization, but do not provide
details regarding the errors. The mlxbf_gige driver should
provide error details in the kernel log, noting what step
of initialization failed.

Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index d76d7a945899..d1f8a72cae53 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -142,8 +142,10 @@ static int mlxbf_gige_open(struct net_device *netdev)
 
 	mlxbf_gige_cache_stats(priv);
 	err = mlxbf_gige_clean_port(priv);
-	if (err)
+	if (err) {
+		dev_err(priv->dev, "open: clean_port failed: %pe\n", ERR_PTR(err));
 		return err;
+	}
 
 	/* Clear driver's valid_polarity to match hardware,
 	 * since the above call to clean_port() resets the
@@ -154,19 +156,25 @@ static int mlxbf_gige_open(struct net_device *netdev)
 	phy_start(phydev);
 
 	err = mlxbf_gige_tx_init(priv);
-	if (err)
+	if (err) {
+		dev_err(priv->dev, "open: tx_init failed: %pe\n", ERR_PTR(err));
 		goto phy_deinit;
+	}
 	err = mlxbf_gige_rx_init(priv);
-	if (err)
+	if (err) {
+		dev_err(priv->dev, "open: rx_init failed: %pe\n", ERR_PTR(err));
 		goto tx_deinit;
+	}
 
 	netif_napi_add(netdev, &priv->napi, mlxbf_gige_poll);
 	napi_enable(&priv->napi);
 	netif_start_queue(netdev);
 
 	err = mlxbf_gige_request_irqs(priv);
-	if (err)
+	if (err) {
+		dev_err(priv->dev, "open: request_irqs failed: %pe\n", ERR_PTR(err));
 		goto napi_deinit;
+	}
 
 	mlxbf_gige_enable_mac_rx_filter(priv, MLXBF_GIGE_BCAST_MAC_FILTER_IDX);
 	mlxbf_gige_enable_mac_rx_filter(priv, MLXBF_GIGE_LOCAL_MAC_FILTER_IDX);
@@ -418,8 +426,10 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 
 	/* Attach MDIO device */
 	err = mlxbf_gige_mdio_probe(pdev, priv);
-	if (err)
+	if (err) {
+		dev_err(priv->dev, "probe: mdio_probe failed: %pe\n", ERR_PTR(err));
 		return err;
+	}
 
 	priv->base = base;
 	priv->llu_base = llu_base;
@@ -438,7 +448,7 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (err) {
-		dev_err(&pdev->dev, "DMA configuration failed: 0x%x\n", err);
+		dev_err(&pdev->dev, "DMA configuration failed: %pe\n", ERR_PTR(err));
 		goto out;
 	}
 
@@ -468,7 +478,7 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 				 mlxbf_gige_link_cfgs[priv->hw_version].adjust_link,
 				 mlxbf_gige_link_cfgs[priv->hw_version].phy_mode);
 	if (err) {
-		dev_err(&pdev->dev, "Could not attach to PHY\n");
+		dev_err(&pdev->dev, "Could not attach to PHY: %pe\n", ERR_PTR(err));
 		goto out;
 	}
 
@@ -479,7 +489,7 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 
 	err = register_netdev(netdev);
 	if (err) {
-		dev_err(&pdev->dev, "Failed to register netdev\n");
+		dev_err(&pdev->dev, "Failed to register netdev: %pe\n", ERR_PTR(err));
 		phy_disconnect(phydev);
 		goto out;
 	}
-- 
2.43.2


