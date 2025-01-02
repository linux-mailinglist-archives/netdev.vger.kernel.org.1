Return-Path: <netdev+bounces-154815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2F09FFD9B
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9DB18832A0
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8111B21A2;
	Thu,  2 Jan 2025 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R9BM2U0d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA413FEE
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841751; cv=fail; b=F1sFB0z348rwGDZ0VUHq3grzIeUck6wNK8RX65qEow7Kog/Svi97k+UGRDgvCtyJ4EPtIdCSjfITI0qW5uMgpgIPPoV0gTuTg0PgnmXsTZXeRXew4dEnXxXE4rdDB6/j38QN6XWH3fD13mb5klnsxeTJyBXk4MaCKWC3epZYpVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841751; c=relaxed/simple;
	bh=fbPADwtkT/EF3vkYf9/2mHorATlkbTArS6qSQNN77L4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfZmoGi1hmDKbZU3SkhhI1Htyq37V5OC+SpRX4fBB1mRu+gMDJ2rEMCYzX7rjhKPaAjzeDNfHsrUZiTcXY6OsDsbNH4DT3iuHiqqJVkLgcbR2vSvSPCfeR5+lJNCzFdDWBaN5oLZxhxTtzmOailti1y1yA4x0stXHkQH97hhxag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R9BM2U0d; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrOaqrngupmCAaaJ+u8Qt3U3R5NaGJBM12Z/WeTBoYFbqX5d3JRG358EqjnKFJyhqGdMyBZTQkNQ0OiNF5qBqHtCo08cfaSIJsSxF+RALLdgsOhMShjXZUtG8jeufc0AnAC9PC1hPYCEEQV5sp7kDrTLBs9Q5nqsvdpc08Xi6886KpUp1iGSwUCX2OuyWkChNXFSJbc1Xc3wSSiLtvwbB0PHYlC/1t6/AcLmVdf/R4SUdZAcQw8iGLqjqIF4yJbi6oA/hjqP+svK60cMa8631aG5DoxywJVNJVzJqxorlgq+bzuN/k4/Xl1CwSqou1WhbmsrwXyigXy6/rW9j7ViXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+L/jrVa+SVc+FbIR2xYershGyuP0b88bJhJwPIb3A3Y=;
 b=kc0Ek62THaqFgH7IFMcmk091x8be5sTEbsyWe+TMH/e+Ovh57wnAS3lhXtrHj716aXWEaZh7w0kUnkvbA5iwa8A37XbrnuePjpbJfhu9QHwYDK8jMHDMUXR9k2XOX0I6DDc/I56drdotbjogHU6hD4aXfundtqz3FeR+zEaG62l+IgA72SbcDB39T0mN2V31wngydO5W/45Jx+NCFPxDjRWv2UAAiml89doTZalGmStBNi4cDl+/lJfCM9GOdOqhiTsCVP4uNiIK7APPEStLEEV3z+wfCVTutf7M8OZhO9dUf7FRmiqjxRturO/s1Gftu9ss+jyHPZsYC7eeZd3zkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+L/jrVa+SVc+FbIR2xYershGyuP0b88bJhJwPIb3A3Y=;
 b=R9BM2U0dz2cQ3FaaXpBQI3O5N8y8yj9LtTSHO48iDssH1EqBdCYaRQLaznTMOdnRjpZt+fmeOTA4NbN26c5AkpWT6vZ16LBmwYbJKWfL1R1XNOxw4sPLaCn/PxYI9hW1AVfcudsfDCxu6TCM/UD4SDqxcK52alqDorS6Im4ZEIC0eYKc/7bHKcAxPLgutJxw7fMSq6/WOfFCF6ew8oN+75LaIQsFiVhP8oM1PEB0Oqdde4Hys1nIKg7N4wwtgjiL4bLt0ge0fRSMiQkNfm+NIBKnBEgtxmR48MMe0iJaeT4C5uPhkzEzm0geygHHe0SddIkDJ/noilCvsgsVJxZ2HA==
Received: from BN0PR04CA0140.namprd04.prod.outlook.com (2603:10b6:408:ed::25)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 18:15:40 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::98) by BN0PR04CA0140.outlook.office365.com
 (2603:10b6:408:ed::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:15:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:26 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:22 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 07/15] net/mlx5: HWS, remove wrong deletion of the miss table list
Date: Thu, 2 Jan 2025 20:14:06 +0200
Message-ID: <20250102181415.1477316-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250102181415.1477316-1-tariqt@nvidia.com>
References: <20250102181415.1477316-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: cab4fa04-cc20-41cb-1c66-08dd2b5976fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eSnYOCEY2BPeRhTCMhevr6ajFcJ0xD79p4d8fsXqHKg9I/72bvgYp+9cgp0Y?=
 =?us-ascii?Q?mu0kkOHWTOmydma+Y3IkFJwSRT6cw1V4Rs74PN56nXoTNS0mBE1Pl5+BL79c?=
 =?us-ascii?Q?gyObXKwqcFHhgkc7Gkjbi5ypf5w03ATTtcluLAy8n9cAKnA1pFPb2iUtedS9?=
 =?us-ascii?Q?4DRJyU2xe6+UHsPDGf5EawXXMx6ctP1J+0lMtLRSOH8OA69fjdeEbdmIvJ/m?=
 =?us-ascii?Q?Um2RtMoIZ7hkBNOMjxzk9fdTjPhYkrNyD9jW8LiNwVrstSMD39wyTBQn29ZP?=
 =?us-ascii?Q?kISY2O1Ue6WTS1F4eLoLHN734QNm4VoAlFq+3+SR8ZuYEqPw8liUYqw9YKOK?=
 =?us-ascii?Q?TTC90eDglQc2Xo82NXcR8/y/yVtyvTJAeTcfx04sv/jkpaIDiGDwlJL8eeyI?=
 =?us-ascii?Q?Fxby6o3srzpGqTyjKHovrewty6afugQlok0oIPzsIegfKucmS3l+/OHeG9oj?=
 =?us-ascii?Q?WeERbTAOEWINPanSBupXhSNHZoIPUNEkAJQWKNbBqACRuyNZl6c0hCmw0kV8?=
 =?us-ascii?Q?hktooJOHWBMIEovrAXPiurRMW+AWUHELmAnhliNoqA5shdHxwoaulIcVcIwt?=
 =?us-ascii?Q?ohp8lWOr6ah6TuROHpUR5LJ8mDXDLXd/GG5X9NozCY+45tOjx0EEYDFwTeOQ?=
 =?us-ascii?Q?VtQo8B5rKX3VD8VHVUpnGgBqji6kFyIjm+xzCjzNH53jvoBDsI9oHFUBpIjz?=
 =?us-ascii?Q?5T916Ketvr0iYoiRo5zYNjEdrWw77aiMBvxqZNF6TZe/F+/qKbonk8BHjfVn?=
 =?us-ascii?Q?1+jLDG9cziL/uTyVLl1nGXCKdsrbg/AKD5dlhbL5jtViIq/VnBadDPfFAqMN?=
 =?us-ascii?Q?fEPJaQ84gk04Pz+7hbe33HV8RzjsQPhtw9eJdsA7Y0TOU8tfuUoZ4n8F8kY2?=
 =?us-ascii?Q?A113+RGY5RuDepRZV/cVpt4g/xDqsuSHHoCx2FO/ug8uC792OyiKcY68z/xO?=
 =?us-ascii?Q?rJFKb841zi919Bk8QWDz8vslKu2EdflG+MK3PKCOlBGFtkZNdqFXiJhJCmV6?=
 =?us-ascii?Q?PQEe1l2i6OfJtPX1e4miwZSH/rspCLAF3XMgLHm8K9FWit8ccUcOfzvVqIV9?=
 =?us-ascii?Q?w6FmV7kFSwR+N2bsyT76bQP+Iz5I3CcldGtd6hk0gBUKHEdbY/0Fwi9K445a?=
 =?us-ascii?Q?MhdHcv4aSGCz8tjcdSEtveNv9zxxDxPOAxU3ayOTk8eFJCUPnG0vW57cH4ut?=
 =?us-ascii?Q?sWwu2CTMo34clam7ik/hZDO3awTPTRCRvXxcXNUVnV7OgN8cyScEIZD/B/eF?=
 =?us-ascii?Q?3MI1woaVf06IahzUg/HaY0hbbfoOXZxUwFxAspa0xP73A8t2JNQHDPReXRmr?=
 =?us-ascii?Q?D6BvCc2x3ICZM+F6URgr0TM7WuKopV5tvfCC7QiszbqNDTWxawFqU8JCODAb?=
 =?us-ascii?Q?/09uaO0v01lcDrXwrjOlP/XXSr6VeblidX+1Jk0PAcHfseJ6vTRi3AwfQigI?=
 =?us-ascii?Q?cSCVFeHMwGTuedyHTDiUG6HZZu13VOA7oWFQRAP3bNNd5MJLnGMLuYYhv9RL?=
 =?us-ascii?Q?LEFHpirUpE8J+bM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:15:40.2789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cab4fa04-cc20-41cb-1c66-08dd2b5976fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Remove wrong cleanup of the old miss table list and
simplify the error flow in the function.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/table.c    | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
index 967d67ec10e3..ab1297531232 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
@@ -478,15 +478,9 @@ int mlx5hws_table_set_default_miss(struct mlx5hws_table *tbl,
 	if (old_miss_tbl)
 		list_del_init(&tbl->default_miss.next);
 
-	old_miss_tbl = tbl->default_miss.miss_tbl;
-	if (old_miss_tbl)
-		list_del_init(&old_miss_tbl->default_miss.head);
-
 	if (miss_tbl)
 		list_add(&tbl->default_miss.next, &miss_tbl->default_miss.head);
 
-	mutex_unlock(&ctx->ctrl_lock);
-	return 0;
 out:
 	mutex_unlock(&ctx->ctrl_lock);
 	return ret;
-- 
2.45.0


