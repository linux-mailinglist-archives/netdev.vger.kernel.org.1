Return-Path: <netdev+bounces-212748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E1FB21BD7
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 05:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBD81906950
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F062DD5E0;
	Tue, 12 Aug 2025 03:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LbttVtaI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66802D29C2
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 03:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754970767; cv=fail; b=E3AYr2Oe/qnipLBac0cAAnGUX/FJGIiRyE04Geik6LYgzsyDQ3OxjUZDTGY4vQjkil1u5JZqZ8qKSqc8ZAcfswcNF1hKn40k/XgC1bFWDfOBuke1m/k2uyeaqtamOtkbW88sX89gQk1Wm+7C3G+ImE1F9+UBVLHk+Dy6/FPwj8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754970767; c=relaxed/simple;
	bh=Wb8E6KgwCo+lh+r2Q3vkf6hLlh1QHGhfDE0QA/KkSW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dj0RCt5DpQNCSVzDspWQkbT+1g+FAZaSRsncDyEyIDXXFUwfV2rgGD4GuAPcIz9nh6CGXGSjYGB+VO1e4x6B3YuoaheLx/U9456tWVy58mZuVpUO6wrTwDvu05TGGK5HEUWZLmDZT8nawSVA7T4Fsefff01jWMSGwfDHNMzQbdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LbttVtaI; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+O43M4tdQM4lue54mvRq8UXPQhKtzj1NMMDgFhvrAzQrebN/AOGCORbWB15U21xg7ZaEWWHcCLaRFIIaA+bM7NViZysOd0Fi4/DSXARO1q5XEJPZphrgW6k7h507oAfu1pUZadvCP8fkPZTVJz748e8Z9oC7tyaXPmFqcPg1UaYTNu7Njl63JioyIFNbLNX+6Ra3rMewmKIUsfigLYyP/XbJrmoafVE0PYgJaJO5LilygOwh7skyEdnNft5F6LhOH638Rk4Ky3PxHdF9UZFByOfoWZgGHa3xhrps6LQwVLEAlnlRDPOtXtNuaF30mvVt8iLjNXSFzRjDX/xOc8u3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d29Ace1RfIdVEr65pHEJWMmtE+vV0wPexmWVw3t7fC8=;
 b=hubo6wbo7EZMJ0JBhOEGwE70LAtWVlmXrAsQQW9jOHq7DuufN3cikotOYuvaQXsw654plDuW9U98zIwsmrC+T7iHwaa0xFuDD9CbvMJgSgln/KPQ9rW2yceE/Ol44LwJReViOFZe0eyTGuisiGGeS/AQR9vcfm3tkbS5fGgoo+HF3EjNniFmTYs/x2o0Hla2qx5R5fjvpLfk1J9eIIpXaCkOg0DwNe0DObA6ZQOfXYZJ7i+P17bScXvu5zXDCpdcUV69qdGOxfzCekxO+sGy4IHIQFL/cGWMRcN8jZokAd0cnGy7Kgh4ZvsNBFLa+DORpzajm4a6bFa+bLUCMZSf7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d29Ace1RfIdVEr65pHEJWMmtE+vV0wPexmWVw3t7fC8=;
 b=LbttVtaI1P8sOJubaDM4fWBDrdI9fthcr9CkGv1CxaWtXeHOiJdX5uUoCCO/mXdW8Jp4JMTwUyStIlNH39WlAWidBzzsOG3S82d/WFGJBOvdvrxyVd2rW7ct32sHlAQ8oaXgsAPLrFm2n350q/Tqu3JJkSybPydSwwN5mKJzljNfHJSwPgToa2nW4xHnxhBB4X+Q0CO7O3emFzY5H7EO3QIxVshrWZc1TcEyPGOvAGcoismM6XUHH0VB6pBlrXvxe/Tjpq3GSqWw9QIlThzkrn5/j3RGK0UsBHtGxBT0Fhgsy1Z56mrhJblBW9wsWUIs2gD8m1GSUNWfRkDI/ZdNnQ==
Received: from CH0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:610:e4::12)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 03:52:41 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::e9) by CH0PR03CA0187.outlook.office365.com
 (2603:10b6:610:e4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 03:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 03:52:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 20:52:26 -0700
Received: from sw-mtx-036.mtx.nbulabs.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 11 Aug 2025 20:52:25 -0700
From: Parav Pandit <parav@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, Parav Pandit <parav@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next 2/2] devlink/port: Simplify return checks
Date: Tue, 12 Aug 2025 06:51:06 +0300
Message-ID: <20250812035106.134529-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250812035106.134529-1-parav@nvidia.com>
References: <20250812035106.134529-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: c3dddff2-db38-474c-8b62-08ddd953af9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5wNkWZzt8jFIrb7v4uwh3kXeORsj6Ntp1Df5C4NsJsSiEmz9HHXxIEPX7dy/?=
 =?us-ascii?Q?iK/VQZ3X0ucVNmUWVkJ3GSxRLX57IV3BnkvMOt7suiMzXomvPT1z+QpOlZal?=
 =?us-ascii?Q?H242lqabhg68Q6VHMJnL/caKa3FVknCmExDoRP+4xlrBs5+2/ZgCoa0IxsdR?=
 =?us-ascii?Q?mNNPBkDNi82pBvktW/A9tvS8fO+3RG4mgflVDawNZ5x2xQULrWMzLagwZ5+U?=
 =?us-ascii?Q?UYibeuY4ldswQtMvJpRTLbg2Z+6EJa6ObqYS0iPiVZqbPCChgPHoAyxFW2Kg?=
 =?us-ascii?Q?WiBnq4uMAAEBWnaMyyI36PyGhcV+iQXW054tpyV7Mf5MvVS8L8f20DhheSmv?=
 =?us-ascii?Q?SSXAUHS7SSEUqqMLSum15zLte+24Efuu0zRXBsIgmMuBcUGLj9eeId5cZaoz?=
 =?us-ascii?Q?fGw23niRXJZXddTyLf2QtB/gYVde2dsKhPynsLsKvfBzqZqJlSbbCGtsTmME?=
 =?us-ascii?Q?0a1UlfUFELStcEPq33Gq91DM2cR91tCdwiOeqHTYQllct7IGcbuXu6fRpbq2?=
 =?us-ascii?Q?/TUvfFZDB8YmHBLtsvr3svNVldq6RkhHhk7BeiWX/16T4whUi/gFTsbz/yx3?=
 =?us-ascii?Q?20n/UvRJa0r3pKxIVFk4pnZOLVwhrzOO72KuVvEh2wl+it2COWfBF4TGxlq0?=
 =?us-ascii?Q?EX4WHAe89tbeyb5SqxCe+F+sv7s9Qy0SZ2vLVXSUk9v7T9TCr+F6dZENM2fP?=
 =?us-ascii?Q?oGlKg6XYhQp7++29yn9VCeE5VKDJSagmltlpfMeU8lg4ElBO1EAbpwgxFhbn?=
 =?us-ascii?Q?B4w4VMzWvzMJeOaBt+ERuR2BY0CeGFUV5Q296CMgL0JdbpGzlR96P5dtNfnL?=
 =?us-ascii?Q?xp0UQU/wGI4cZPOtmaDV2HFcmiJyWixxQyR0z/orWlGgJxVhvXa+tYeb2YTx?=
 =?us-ascii?Q?z349vxiO2ATCseNiKEzGReYhO6fD3BiTIYBAmy/512z5j2lH6dTQHcDWBvy8?=
 =?us-ascii?Q?h6nrXLVeY/U7aAABkA2abRiLtNaupod2D59EnYx7JLw+YlX8wYadgRXEq9tS?=
 =?us-ascii?Q?DgQqpvNBnD1HolhfvIzFG6DemvLLga7mBJ3W4WTNUz2bM8CVk+THlat7+J+c?=
 =?us-ascii?Q?KErvnjs2XtyYNvWJ/LMKDjB1szJPHmfre6vlsAKsTyvB7LJ42mMc4/gAyj3L?=
 =?us-ascii?Q?+B+zpgmE1l5/hmAndLHXUg5ANd6AI6Tr6x04Snhw3fuAp6PE6xpUqlOpowNB?=
 =?us-ascii?Q?GnBysdNRW+BzSMOodZEqCI+rYZQT/OZkUKxPzRqVvidPiy34zN5yBePY/W0m?=
 =?us-ascii?Q?nHfGueK4QqMsXwKcxJdJL13Jxq+S/GC5ha+Lw8aJ4PeNkS/6wUMyrVg/Ktbu?=
 =?us-ascii?Q?geOoU0SG9tbPryzo9/UWx/gws3ECqBl6v/LajKZCHBSLnZIHGeI4hM0/vYoF?=
 =?us-ascii?Q?UiXjFznPV+k2L+nX3oe3Su9Egg1pvw90XpNv0Vx1BJT56CRYT6tDS0xB1DdM?=
 =?us-ascii?Q?JY6gg3hgbGDO7i0BqeAdVMeMVkof0AX2Ht8L/uxVkSPGXpZo7g0cYkGvsM3i?=
 =?us-ascii?Q?cX2kLAdY6MRpNJT7M2T6l1Oy6vBjbktHHnJg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 03:52:40.5378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dddff2-db38-474c-8b62-08ddd953af9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274

Drop always returning 0 from the helper routine and simplify
its callers.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 net/devlink/port.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/net/devlink/port.c b/net/devlink/port.c
index 1033b9ad2af4..93f2969b9cf3 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1333,8 +1333,8 @@ int devlink_port_netdevice_event(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static int __devlink_port_attrs_set(struct devlink_port *devlink_port,
-				    enum devlink_port_flavour flavour)
+static void __devlink_port_attrs_set(struct devlink_port *devlink_port,
+				     enum devlink_port_flavour flavour)
 {
 	struct devlink_port_attrs *attrs = &devlink_port->attrs;
 
@@ -1347,7 +1347,6 @@ static int __devlink_port_attrs_set(struct devlink_port *devlink_port,
 	} else {
 		devlink_port->switch_port = false;
 	}
-	return 0;
 }
 
 /**
@@ -1359,15 +1358,11 @@ static int __devlink_port_attrs_set(struct devlink_port *devlink_port,
 void devlink_port_attrs_set(struct devlink_port *devlink_port,
 			    const struct devlink_port_attrs *attrs)
 {
-	int ret;
-
 	ASSERT_DEVLINK_PORT_NOT_REGISTERED(devlink_port);
 	WARN_ON(attrs->splittable && attrs->split);
 
 	devlink_port->attrs = *attrs;
-	ret = __devlink_port_attrs_set(devlink_port, attrs->flavour);
-	if (ret)
-		return;
+	__devlink_port_attrs_set(devlink_port, attrs->flavour);
 }
 EXPORT_SYMBOL_GPL(devlink_port_attrs_set);
 
@@ -1383,14 +1378,10 @@ void devlink_port_attrs_pci_pf_set(struct devlink_port *devlink_port, u32 contro
 				   u16 pf, bool external)
 {
 	struct devlink_port_attrs *attrs = &devlink_port->attrs;
-	int ret;
 
 	ASSERT_DEVLINK_PORT_NOT_REGISTERED(devlink_port);
 
-	ret = __devlink_port_attrs_set(devlink_port,
-				       DEVLINK_PORT_FLAVOUR_PCI_PF);
-	if (ret)
-		return;
+	__devlink_port_attrs_set(devlink_port, DEVLINK_PORT_FLAVOUR_PCI_PF);
 	attrs->pci_pf.controller = controller;
 	attrs->pci_pf.pf = pf;
 	attrs->pci_pf.external = external;
@@ -1411,14 +1402,10 @@ void devlink_port_attrs_pci_vf_set(struct devlink_port *devlink_port, u32 contro
 				   u16 pf, u16 vf, bool external)
 {
 	struct devlink_port_attrs *attrs = &devlink_port->attrs;
-	int ret;
 
 	ASSERT_DEVLINK_PORT_NOT_REGISTERED(devlink_port);
 
-	ret = __devlink_port_attrs_set(devlink_port,
-				       DEVLINK_PORT_FLAVOUR_PCI_VF);
-	if (ret)
-		return;
+	__devlink_port_attrs_set(devlink_port, DEVLINK_PORT_FLAVOUR_PCI_VF);
 	attrs->pci_vf.controller = controller;
 	attrs->pci_vf.pf = pf;
 	attrs->pci_vf.vf = vf;
@@ -1439,14 +1426,10 @@ void devlink_port_attrs_pci_sf_set(struct devlink_port *devlink_port, u32 contro
 				   u16 pf, u32 sf, bool external)
 {
 	struct devlink_port_attrs *attrs = &devlink_port->attrs;
-	int ret;
 
 	ASSERT_DEVLINK_PORT_NOT_REGISTERED(devlink_port);
 
-	ret = __devlink_port_attrs_set(devlink_port,
-				       DEVLINK_PORT_FLAVOUR_PCI_SF);
-	if (ret)
-		return;
+	__devlink_port_attrs_set(devlink_port, DEVLINK_PORT_FLAVOUR_PCI_SF);
 	attrs->pci_sf.controller = controller;
 	attrs->pci_sf.pf = pf;
 	attrs->pci_sf.sf = sf;
-- 
2.26.2


