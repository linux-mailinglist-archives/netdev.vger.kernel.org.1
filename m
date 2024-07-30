Return-Path: <netdev+bounces-114176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B57F9413D4
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D50F1C23508
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89A1A2C25;
	Tue, 30 Jul 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KBycIGBz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF251A2C1D
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348001; cv=fail; b=ndDym9tvuy9hx112Gt1HSEOPazWAkHDbbsEaJIuHW4WoljUDmLfhzv+QWQUkFQBlkM4RpXD8pmnXe+oFcqT7Ufarv2GoX9Bm1MVaYxynSSqPRJhV4FWIt03XKITM4VbuMMoAyXMdYS+cK0l0j/pMnjDm3BdK5GO7J8AivfGpGd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348001; c=relaxed/simple;
	bh=kVd42uvWQoorMmiHsksHFhlZzQ10f2Fdh5LcnY74I1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aw2tNtFgaWZKvdOk3QqK8+uDx8+G9B8lqDg6nH//qvDMXECr0T8V+z/tfGHAlP4q60491fz4kQAaV0yliczCm3gxCKHRpaksE3jjQp/vSirlAUjxdLfcKJWDkChfXjwAWYmsRwRQYIdy7f1Kq9SPEVdJT8cR3z9v9k4xp/3WiSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KBycIGBz; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3jhL8uwS4shdhGqT01xSx1HMOlBnB2sip17tO8Bk3A8jwV8ZxlpsUXNtZNCMZCr6I7QneVDnzq6ggopyx0nsWUO8bxbh40resGGZLtvoCl/wnleZLCzrBWdFlBeVEgzsIYCYVVyuk1GO2DkWZg34DZy8w0eaV4VMB5NBMYDsxWJHKruFFkUsdKfazS+Blp8DhVJU++nCYEwHV21I56YMd9OfS9QHYtRHi2w6OtkRktHSozCxjhOO8mIcinoHIzAs1PLqxUAQ2OXmTRC29tMYSN3caWjcSUa/1Y/RhLWlpaRebUBIu8/e8OqRbS7DaSSEKQsNVcTTPOGfoRspruwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AI3sMFSYP6r5jB3ysD51JzLgSJzOty6EkiWMw/wwsk=;
 b=K6rlR0u2VKvSoMbiCqkRx20qhQ+/EXGAaQIazd/740sFkwb3F19ZaIe30G/gqnDibAZB94d8gtui+fpongnSFOkUA51iHuNHqk8/j4Ev+uB6l+8fPaqzTkisTT+KCn/YzM6+n0h/Fc37C7Ci/MYuaJnkpQywHjQvIrfhq4S6cPoLe31Ey9Zp2KalOkuhxkULfV1ZquTnIDyO2DH5adfTK44CkT3hXGfNua/aI3GAi0ffmOnUXM4L8xE/OrgJr1Ei3F8FUh5RE8Dcq1s+clk+J4+g+MBlu1f5vbclKxOIkO7AIQ02pOrwZjRJw5D0k4cl+iC/EhGQyjeaKbYsfON9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AI3sMFSYP6r5jB3ysD51JzLgSJzOty6EkiWMw/wwsk=;
 b=KBycIGBzxlUtyZ8i5yq1Lyp9QbJ9Slqy3nq/6AxioRLxAonWAakneVHoAgWAfPBqGxEIv6bu/AxjQRYmyXcSy/kv9nht+MqW1U7EGsg5ODcqHCUzioX/H6CT6/EOtfHf8DLl6mdjmwFx48At1O0u+LooVTOEkiCncG63J1E6j+z73L9+AkneKrGk5VZ4nwarraWWTO9dEbaNVECZI9nHR0rjJHPiEiywhGjaqDWgvQ158IWz4Y8sHkIWhyrDkbC0nPN/MfSCylEQt4kIycIvbdZo0WKTmEjhA2f8kitj3rtH1OnNIPUNnUyo3FPhKeg7Hn7ugoTktocXLmYiE2wTjw==
Received: from BYAPR01CA0028.prod.exchangelabs.com (2603:10b6:a02:80::41) by
 CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19; Tue, 30 Jul 2024 13:59:56 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::84) by BYAPR01CA0028.outlook.office365.com
 (2603:10b6:a02:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 13:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 13:59:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:40 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:36 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 06/10] mlxsw: core_thermal: Make mlxsw_thermal_module_{init, fini} symmetric
Date: Tue, 30 Jul 2024 15:58:17 +0200
Message-ID: <a661ad468f8ad0d7d533d8334e4abf61dfe34342.1722345311.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722345311.git.petrm@nvidia.com>
References: <cover.1722345311.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: d6522801-b6fe-40e7-81f0-08dcb09fe4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vinI6H+FLeYDIlpQzHwIfNEyu9CXBCdhSBoENozT0tAE8uDhlUWaK93mD24G?=
 =?us-ascii?Q?yv17C7MtNdu1oOh7R/70q7G1Z1PM3z76DvXX9BChHUGsiiH9gND8DXXwPcPk?=
 =?us-ascii?Q?8848LakDO1cgYjLMfz19281a+EPr6YfuDeVbuPNi7DL+z/0JXjFgCksjEbV3?=
 =?us-ascii?Q?zZ4bL8lyLCMwgj57Z6iu80GCxCIWF8IHbh+duVEuj4grDKJnHhquMLhGl1ZV?=
 =?us-ascii?Q?u8w8HeUNBVfoXIMA+9KOzn1z8GCIFt+bVHDuQbabXBbMPG+9VGrgAND/e4X+?=
 =?us-ascii?Q?C4vsylm5LFSpwUesIpbsapAMGX6M/TdpzjINiReED+M0Mnz0q63bsr7X0Fe7?=
 =?us-ascii?Q?FxUWOfCIrqDLtokk3Qs/Kp44vD0pVmyxm1NNssBYMGGZLyjqdd47SITtvYDK?=
 =?us-ascii?Q?v2DJJBrjJgLF6/wohGyI2VV6crEbGtyqNceJfgZE/9ypgiCOumhXZ6+SfvYG?=
 =?us-ascii?Q?Jw/SszbDbDBZwrVVqTDaqdn/eY47VPsZJBVqTSTKfFX2qILcxgBoDa0Ov5Iy?=
 =?us-ascii?Q?LVSXSQR4Y3WaG4GAdex+VottzM/YgWJ3bwVGf0JwmhUXzmYXjKbvKWPCWdv5?=
 =?us-ascii?Q?pMmlQJHo3AkBw7Yf5YRdC/RdgYYWkpcaiIYoAzzJev8ziXfdM5XiWF+INkfG?=
 =?us-ascii?Q?Hjfn3LGlg8IW2DlsnhoMY3x7IudzJy2hAIwr/AobfIICLlooEYeUGT+FX6o3?=
 =?us-ascii?Q?D4/mRRRsoEoifFsa7HZc2jtcT52EYclZ4GBajh4C+aE9G/2DFY4plFblwCw8?=
 =?us-ascii?Q?uY4WqPWBKel0CxAsLPRI5k+XkIcYOFzawNO4gb/5rYALmqqhzWXlL0By2HeJ?=
 =?us-ascii?Q?xBXNsrgbf8vfCU+JfKbApwSxxfOrywqSnuTi1g/To+nfj4QS8+LlvImygCk4?=
 =?us-ascii?Q?++HQaTJmAR50ck+yfllG3gCPcUYFOP8Fwz0KAv7//rHOffLm24XHhAsk+1An?=
 =?us-ascii?Q?tJ+JGu0YfnhalgF5baenowhHtsojZcdUK6jzqTfskqf/4FrnxLfn0U+7P1PQ?=
 =?us-ascii?Q?U9WpFcqAv7bLqVgv6nxQiEpFy2M/paFGI/yhT1Ig2jc/yZkAx1ivLe3SamGo?=
 =?us-ascii?Q?3Xy54gB74KzAgGOpe/l05wXuQ0bUiYeMkFb6ksld0jY9E4bslZchN4fubTWp?=
 =?us-ascii?Q?sVuWwRx5ceHPANf1zCtxpsuYTfogpXesxPv+LXDGTQa91KdXtTy/6TgpPzD/?=
 =?us-ascii?Q?OPJ9ncpy63GuGGpkM+bgz+icKJ2x0WD8wx0cFoSoSKHqwbUKfBXhZJ9XzLdM?=
 =?us-ascii?Q?hVJAyJolJSlqrosszm8emnnJMtsC3uD1QAokubTZYaI8l1G8YwUjSm8epCPF?=
 =?us-ascii?Q?Gq7FFdjg4ueglKSaErCSU9g/5/xSPOS5vIG/BFEK1USYu42WmrdyZXyx7R+W?=
 =?us-ascii?Q?0UjygxyI/xqRzKAXV9mapL7GSFm8mO1rDKziEp0+yiDOjwuwQx5wyJ8y/eyZ?=
 =?us-ascii?Q?OA/JSa8gtf5kPpn8W5qvVkbOLannvxdU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 13:59:56.3258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6522801-b6fe-40e7-81f0-08dcb09fe4cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

From: Ido Schimmel <idosch@nvidia.com>

mlxsw_thermal_module_fini() de-initializes the module's thermal zone,
but mlxsw_thermal_module_init() does not initialize it. Make both
functions symmetric by moving the initialization of the module's thermal
zone to mlxsw_thermal_module_init().

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 95821e91da18..36b883a7ee60 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -445,7 +445,7 @@ static void mlxsw_thermal_module_tz_fini(struct thermal_zone_device *tzdev)
 	thermal_zone_device_unregister(tzdev);
 }
 
-static void
+static int
 mlxsw_thermal_module_init(struct mlxsw_thermal *thermal,
 			  struct mlxsw_thermal_area *area, u8 module)
 {
@@ -461,6 +461,8 @@ mlxsw_thermal_module_init(struct mlxsw_thermal *thermal,
 	       sizeof(thermal->trips));
 	memcpy(module_tz->cooling_states, default_cooling_states,
 	       sizeof(thermal->cooling_states));
+
+	return mlxsw_thermal_module_tz_init(module_tz);
 }
 
 static void mlxsw_thermal_module_fini(struct mlxsw_thermal_module *module_tz)
@@ -477,7 +479,6 @@ mlxsw_thermal_modules_init(struct device *dev, struct mlxsw_core *core,
 			   struct mlxsw_thermal *thermal,
 			   struct mlxsw_thermal_area *area)
 {
-	struct mlxsw_thermal_module *module_tz;
 	char mgpir_pl[MLXSW_REG_MGPIR_LEN];
 	int i, err;
 
@@ -500,16 +501,14 @@ mlxsw_thermal_modules_init(struct device *dev, struct mlxsw_core *core,
 		return -ENOMEM;
 
 	for (i = 0; i < area->tz_module_num; i++) {
-		mlxsw_thermal_module_init(thermal, area, i);
-		module_tz = &area->tz_module_arr[i];
-		err = mlxsw_thermal_module_tz_init(module_tz);
+		err = mlxsw_thermal_module_init(thermal, area, i);
 		if (err)
-			goto err_thermal_module_tz_init;
+			goto err_thermal_module_init;
 	}
 
 	return 0;
 
-err_thermal_module_tz_init:
+err_thermal_module_init:
 	for (i = area->tz_module_num - 1; i >= 0; i--)
 		mlxsw_thermal_module_fini(&area->tz_module_arr[i]);
 	kfree(area->tz_module_arr);
-- 
2.45.0


