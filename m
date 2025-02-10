Return-Path: <netdev+bounces-164616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA44BA2E7DA
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B807A3117
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252741C760A;
	Mon, 10 Feb 2025 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I/wcaxk/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509C1C700E
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180045; cv=fail; b=PjLToyYM9m3+F5QelpnVteOe8tkzF4bTlSruL0AO3KZsYCiPIMcfZDA7+gl+olJ7bF5elqhZD9pZ3e8Wax3uOsqPkPAPiIZLZfxIEc9GzGiJpuCyJJdbHG6TnN7DCoPVR5BFlXXHiMIySKEMAVNVM/sjgCkpnJhrhwNLzw0JKZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180045; c=relaxed/simple;
	bh=ZVI3N3gvRvo8xmC2RXBW4JR5dHH8Ne/xad4WWBfiK5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcyDJu3sxLJEwq9C2DX6MvwdvsTGhCG7WBlNX2800HxAxSe1G4gz/JcJKHmIC7igmtZ3ntio2KdFHVu7VmYtFYSQ87dBUm2iimSFHf2zLPKhE9f+xgIYXVIV9kLY8zTcWgberOqfsTzol+Je+tHwW1eEEXlKMRuczZO1rH8HKho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I/wcaxk/; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+m9tLLg2NzBsX54BBBdVuGlTBGBjOFSHMt3bMmR2c2yS7RWWripP1DwyDZPEWb9zVHURKAytXeLJ6J/PA9nv6Fk6UBObq+gi4u8YpNZ9hOtL9NX2B9cUv4UWTPLCByoZ/zN6EYTeukk5H6WaS/DjsU14XUZ6EZr6YduuanL1MWpTef3OQFvoxX9ushNJFwWni58CBzwq1OBASKSbYGl+JuR+ocjqkODAXLCiad3N0ouX+lvpkZ3YSPweygyu17W4s5PD+koNOWLqXmMliKXmAVIoU7go4t7CKxYHMXbitvkc6KBqh8rZ+IWYyBkhojjnmanC5G5oYFmTp7dHBCVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTxG5+TVfti1+0VeTw9UFXSIAi3ypb/ZjR6G84mM/qg=;
 b=vjYU4iv+9B/0zow6pAT+0TdfJGoEw7GqEK3X+AZ6s857gDcpV9sCHIVSQWBgmIHj79CZJz6V84dbMYKjXmV7ihSsf0cfbj+EndIoEAgraUVYZ6DzwLIzTA+CLfRjWY00YAhVTdveN4n2kLo4sgu08ZLnT0+EjuKHqfIZhOSkNGLLwQ/6amL/teibssL9XJoljTdudRSizZ6HyCYivxL++EEYNDH0Ax/WMWQpBKiuIUjYXlnYzvWS+AYFVhp6dXXVwWTCRIWK7t2oqHr45tIRV8gx+tu3ECzeivw4aSVW4Qj3RyQ1wdDK7uQN2ARb+hq3lE/411Libf0zmJn0LO0Tbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTxG5+TVfti1+0VeTw9UFXSIAi3ypb/ZjR6G84mM/qg=;
 b=I/wcaxk/bYnYp6v4tY9L2MI4juaT4suA4WsbqVoImrY+kmmmO1EkAvd89bn4lGvhHGgAuRyFeb5/83aFnBzjDbpy4AhE6gut3SXowFzvSPkOzT7qDKCva3BkHL/DaoDCINf/NHBLexvMQ1Eeopd+KHUFacuWSz4t4ZdCepRdkTNwe+Lh3LNWmRcHF5lAYVDB3QYB0cK698eNbZhgDIn6NZm0Bbu/R6FcGmlbCybw/FlCvDYcEOSXIBn0bIHH8i0BIcFitw20/0hacX4I8Pw3c0nBGp4CR3kXt53xcx4qDfWbHfFTsvenXPyg3Ck+kaNoauOKleKdH029nPy8jPWfcA==
Received: from CH0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:610:cc::18)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 09:33:56 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::bd) by CH0PR03CA0073.outlook.office365.com
 (2603:10b6:610:cc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:33:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:33:43 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:33:41 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 05/16] qsfp: Reorder the channel-level flags list for SFF8636 module type
Date: Mon, 10 Feb 2025 11:33:05 +0200
Message-ID: <20250210093316.1580715-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210093316.1580715-1-danieller@nvidia.com>
References: <20250210093316.1580715-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: ee547cad-aef2-4bee-b184-08dd49b60a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FqE8+L4PPfl0Iy3mMeuXueLwzD/igggpJVkKqyWZoO/sHrw4mkCnEGSLaBsn?=
 =?us-ascii?Q?XbztETSQqTFVDrvZxa1GChAizzYhBUNmEDe4RVEM9ogC8nDYUuWWYTvFmstK?=
 =?us-ascii?Q?A74Gom7tHGBz5r4DIzXxQU/YIMH86YfX5hWbsRmNeD43QlTESzDA0bjNXWni?=
 =?us-ascii?Q?KfGOhOQxuYy2lo0hJydhFaC5XJf3SrnLdpbJmTmzSJeX/E8T3yfMsUEk98Mg?=
 =?us-ascii?Q?mW7tsu8MOF7EvuTqImvKGF29D+nRh7TeB/xSge8R56wUZCmdOTFeFxY75MAJ?=
 =?us-ascii?Q?XHzfx4hUSR3OB+Df7k4y6fYD9naDLD2A2ov1R3Ah26REUDSSQrty4IIVwLp7?=
 =?us-ascii?Q?JIOlcceTQLL+i4U5n+enCQwmTqkGxNDIvSZYEM2D7FqPLNvSgftyfyxdqvwE?=
 =?us-ascii?Q?yp/RRwbbVDeM4LonBhXf++jvYYDf6ulsBuSN+UPC5GV0TvBU4MT2sn8eDkw+?=
 =?us-ascii?Q?kNipNpH0ke46GZYRHTP+bZVu5CE+FYCKqI1ptpgD9weLTT+srdM9P83XpEKg?=
 =?us-ascii?Q?ydRburln/r145dZgjl4VtJroLjnZtpu9z3z8XVF860Niopl90B+8zQZWO8Ua?=
 =?us-ascii?Q?JSZTW80bf91nlmQim2M8qCbRuxWdGyQY6Q+7UnsPRiZJUUZJ/k/G9AVu5aXa?=
 =?us-ascii?Q?Iea+/gvDV+bkT4jmhwMwCFtBWzSQpDW5eR3uMmqvwurcFvP7P3AicuVTtr0r?=
 =?us-ascii?Q?1QFvMb0uhPi3NBDCUfBCirIgj9HUWWSjgadxoNrNE903N8MR9yFrdh6h4s+Z?=
 =?us-ascii?Q?d1aRmLNh61G5pConcyDNeQXgfLC5PG+HnAzmGcWxEq1tFzgWMe4tGRzxRIQL?=
 =?us-ascii?Q?mEgUzBsP5CSiysAAp9DLhdq5OeeLplU9RRH6c9l5gB2HybDYr3jxvKAvWBgG?=
 =?us-ascii?Q?oOFMvh1lRrXiVGaF51iycXcqYl/+s2xRgObLUGZwxAC+Ks5/qUiz3VCTJrhV?=
 =?us-ascii?Q?A5gthcuUMmnH0jo3+RUAJMRatohZOGOjd+l3PjIVm4duU0bhv6eRkGsF/hDO?=
 =?us-ascii?Q?Ub/zN9NsG0iVr5MHeimzuj/5lUXjc8xBC1RQ+UBRy3azpbJhFxFdlEO6UGh7?=
 =?us-ascii?Q?xiNue66Xz+GA0b9AJD099VVXNVPezi9VB+k8Cp3mwTrQ7TYu0+tgg68Mm1vW?=
 =?us-ascii?Q?KOm4XP1NrOggWFxSNTDC/keXV7iyz4rRdqWVPdKtdUzn5095xUq7R2eg2MmU?=
 =?us-ascii?Q?0qHnYOXC0As7e8XqQGmb7nVktkcrtDcBCmyUOlYSDG88aEVDa7MKfWryGrrH?=
 =?us-ascii?Q?Ufa40lpQBRNdPpJWnFgShGT7w1S2TIkoGH08RH0K/PTH/bdKrfBYqlxmh/tt?=
 =?us-ascii?Q?atI9OGFM/Uav5I9unFxdBMoaQsfGfCWK0diRAYwNu5gwZp1KzC24vf/j+8RP?=
 =?us-ascii?Q?ddHaErdQqF3EQ7cug8o0IcJ70mHvuYo0TaXxDu2TyxT7g5GFn3pcsutLBin5?=
 =?us-ascii?Q?pR0dn2X7PCtFHiHazN+l70gjPPHOqhQLbvFU6acm2ntt2d2FNA/2VA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:33:56.2162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee547cad-aef2-4bee-b184-08dd49b60a64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170

Currently, when printing channel-level flags in the ethtool dump, we
iterate over a list where each element represents a flag and a channel.

The list is structured such that, for each channel, all elements with
the same flag are grouped together.

To accommodate future JSON support, where per-channel fields will be
represented as an array (with each element corresponding to a specific
channel), the presentation order needs to change.
Additionally, the hard-coded channel numbers in the flag names should
be removed.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---

Notes:
    v2:
    	* Simplify sff8636_show_dom().

 module-common.c | 168 ++++++++++++++++++++++++------------------------
 qsfp.c          |  17 +++--
 2 files changed, 95 insertions(+), 90 deletions(-)

diff --git a/module-common.c b/module-common.c
index ec61b1e..4146a84 100644
--- a/module-common.c
+++ b/module-common.c
@@ -87,112 +87,112 @@ const struct module_aw_chan module_aw_chan_flags[] = {
 	  CMIS_RX_PWR_AW_LWARN_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
 	  CMIS_RX_PWR_MON_MASK },
 
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 1)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 1)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0,(SFF8636_TX_BIAS_1_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 1)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 1)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 2)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 2)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 2)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 2)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 3)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 3)",
-	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 3)",
-	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 3)",
-	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 4)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0,(SFF8636_TX_BIAS_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_LWARN) },
 
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 1)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 1)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 1)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 1)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 2)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 2)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 2)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 2)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 3)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 3)",
-	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 3)",
-	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 3)",
-	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 4)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_LWARN) },
 
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 1)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 1)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 1)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 1)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 2)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 2)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 2)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 2)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 3)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 3)",
-	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 3)",
-	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 3)",
-	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 4)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_LWARN) },
 
 	{ 0, NULL, 0, 0, 0 },
diff --git a/qsfp.c b/qsfp.c
index 5baf3fa..c44f045 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -711,13 +711,18 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
 	}
 
 	if (sd.supports_alarms) {
+		bool value;
+
 		for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
-			if (module_aw_chan_flags[i].type == MODULE_TYPE_SFF8636)
-				printf("\t%-41s : %s\n",
-				       module_aw_chan_flags[i].fmt_str,
-				       (map->lower_memory[module_aw_chan_flags[i].offset]
-				        & module_aw_chan_flags[i].adver_value) ?
-				       "On" : "Off");
+			if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
+				continue;
+
+			value = map->lower_memory[module_aw_chan_flags[i].offset] &
+				module_aw_chan_flags[i].adver_value;
+			printf("\t%-41s (Chan %d) : %s\n",
+			       module_aw_chan_flags[i].fmt_str,
+			       (i % SFF8636_MAX_CHANNEL_NUM) + 1,
+			       value ? "On" : "Off");
 		}
 		for (i = 0; module_aw_mod_flags[i].str; ++i) {
 			if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
-- 
2.47.0


