Return-Path: <netdev+bounces-155731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD1A037BA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019471886882
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F731A0BCA;
	Tue,  7 Jan 2025 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G8wUiV4u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ABF1DEFF3
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230168; cv=fail; b=iqzNLcmL4aDAkG7ON964I/Jec46KylEgiHV93KruLIXXDix+PTB73jc/SbhZeppUtXzZeEDzjk3+HImgiurHuhoqiZ+oYGhBlR9sWERt+EoW4HyhRhoX96PbnUFY8RFwv6NJYS1c/r1bs16NQ0aGNRotBN20ne3u3ysKZjmxiM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230168; c=relaxed/simple;
	bh=NgTByRPZnHtLHuUat97Mbc+K4CnwE73ctCPezXV+6Pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anVhDNUMylSigl/5n+f3auDlo97924v9wXNKLn4F5LzaaQFkLxSuTAwnEGy3MmKs+2bZa3RV3LdJcp4Mt2O9QNCVZrJIAbFfjs/hrMbUHXw9rr7H9ZUsY9CM1ep4AA6kPtwY/eG1WM2eSgxUNiPrVGt2R3M7YBvhhu8ltbGSmvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G8wUiV4u; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5Uu4aUm20NyvZ1e7mNqodHgd66MpsSRdSOQuW9g1MoGg2GjwJFTt626E2599Q9Qp8umnxVbMf25+t+txuX59doIY5/uT5VWlPW8mWrG2LeG8nfx5XKfn/fhoTz2Z8vxk4JIhXiH1eZT4YuAtWCJdcbVqyw9tC8yiKEKAQ1ZJney5ONSviB02w1cr+Nn114VSDiNmzpxgU0iBGsaqtmHUOnS5XsyigyLqylj/TKUt8GsyZepDkpm5NwEnFCT7PBMDRDUvJ6z+A+gaNXN7udkBBg/HA2So9xbQmKGFxGZkOysgsxdmYW2SPLHJtRyVD+qC4Sc3fSdmeBCeEx3DKlUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vD1Xxcw/eQnpy14ry491lFWO7iVw295RAQ/GODWVRY0=;
 b=Tfh3wFjm+XUY8IWk5wCtXKQHAWttU5yNSLC41prmD+lfOVkai6kAF4rnyvwWqGk+9jz5KCZOAY8ZNA5aniz6waUNVmCGSaO/cQ13Y8CRfy6FK3wqSkWz1ez1CQi1Keh70UmppnUZkFbG+y+GwaA7RsZsejPqP7WGPwGsPd9CwV/xEtlLvR7s0S0PdOtFbhauL9iYww+piHRYhtrDge4f8ocVDOOtETqMFUFnMI/2qoF+pvukgVlL+6iFYIhoW7v1QVn9psmAJ0APdKOyG6gEbPy2vEUvs8B1CYL075byxngjZN4nMd/9w5zdDR6DYUyefqxrth1B+6arQ7+q+WHTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vD1Xxcw/eQnpy14ry491lFWO7iVw295RAQ/GODWVRY0=;
 b=G8wUiV4uE3zIleHKzS/KKgtP55NUxdlLAbm1ekw4G/PBIvSWoZIWISWOJPvQbOx7vjwWOu3j4qgwDU6qRhScQ3HUKKbgicWo2mr6YKXE6duXitXgqUp8kMdCiW0ktz2G1B+1HejAlv5svc0GC4fq0sdGoYcpgSktbxG6VjOlLbpHHnBCLsAGhGoo0eyvMY/eJGI/qBzYXKAYXC1oKNSpM0LOe5HSV9Nqn5UbxzGCiCjqpABo+4LMCWA2tzjonpvxIli7buK2pBC1w2bTZpoE/QJ2KQkSzeGf32K8Y4Ru+fmK7cIB6GBOqLN0RJBQtWAUxF2KtyXSMLaPvYujcYKCNg==
Received: from CH5PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:1ed::16)
 by BL3PR12MB6426.namprd12.prod.outlook.com (2603:10b6:208:3b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:09:17 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::cd) by CH5PR02CA0006.outlook.office365.com
 (2603:10b6:610:1ed::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 06:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:09:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:09:04 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:09:04 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:09:00 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 12/13] net/mlx5: fs, add HWS get capabilities
Date: Tue, 7 Jan 2025 08:07:07 +0200
Message-ID: <20250107060708.1610882-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250107060708.1610882-1-tariqt@nvidia.com>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|BL3PR12MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fe60fc-c0b7-4bf0-212d-08dd2ee1d195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5DiGN3TVa1FQ56coAr4FeJuGI8t5o3GtovJWWaufFbndtMKZHsPHPyRo96h8?=
 =?us-ascii?Q?UXeWtu2NIbUAB3GczIEypafayJG3ynCeBJmVNtzbejJnp+xldq8Ee7Yb7AII?=
 =?us-ascii?Q?PqZNG2lC32KLufWbAbmo1RCtqP7iUZg3u+bcX1DbLYdKRmxStNHVc9Oagva6?=
 =?us-ascii?Q?JwdCv6nedgiJzWRxnUPkEykDW9lIjphbl09PZQpeE8irNoUAIKitrfgXbSG/?=
 =?us-ascii?Q?ty7K7tDIj1AjjR6z6YYEbfET6kZtu6YIeQ4IcXtDH5GbBfJXnjnf7ApZ2qUm?=
 =?us-ascii?Q?lS09UUsp10blAzA+3+z7h2dAWk36NASzOhOXe+g1K3HQdaxj7aZWOQHNlDrd?=
 =?us-ascii?Q?iRxM7fKrAWrMDEtVIGL2xtpbBWJzcpBtHg8iRNobrPJM6ghxjaZyE938ynlj?=
 =?us-ascii?Q?kKWQi+SrfRDaePmMkgIWBy3rBlBPtOHy+lV+QZ4K0RVBJeCUwUxL/ds+QSMu?=
 =?us-ascii?Q?yI0HXL+Ye06sF0GPYuY+fdOLK5hmsVYX6rKVqfAS1SwGOJsms13qM5w8IIrG?=
 =?us-ascii?Q?458v+ZyXSPTA7byga/PaE+pMfswGKi4RNZttF5xMLBYQO3rkpHyVQOreh0O3?=
 =?us-ascii?Q?ohOrwm9HS09gFYuiZFCD2r+KgKATOv7jyAW3NRJQx+rM44OEG5dae+vbz4qR?=
 =?us-ascii?Q?Kt95qKIoFp4tnGn5hMRsAkISig+V/wSGrPcDr/EVHeEQQkfi9doriklIWvP4?=
 =?us-ascii?Q?vlad/aQP/tb/zcylJTryBF96ZAMoLWkD2JbwD0GlENImHxsQTYowAK51abZE?=
 =?us-ascii?Q?jIp+giX/Y+OFkZ8Cj3MNUn8WlYvQGLiALjl+jXizn+lWFA3PczuG5qTyZ3Jc?=
 =?us-ascii?Q?XGia1EwFE/8PBlPZmMPTv/NneDOGz5Cxv6XbFI0ObcrII2sUJj9Evw2Us5Wy?=
 =?us-ascii?Q?i0zeXqxz7rC373Ol5c2UTXDkgQ+Im3/xWNZPUqSt55cuHFePz9IuxxpFMxWV?=
 =?us-ascii?Q?G6DkXenwTPIRLrcVDpMCtFXwLyxiACw03o5yNaezY0j3W5Tt2IQbdG4Mm9dS?=
 =?us-ascii?Q?YZBBEjlonZTzunMUMfMhIhYP1PYokLJqQzptFEKfVz0y1II+Mt5vG4q4ovZQ?=
 =?us-ascii?Q?7QC3/RmGe4L0X3ZilVZNhhLI5E9kC5M/eaFoK+ffjkjyXnWZoV27A7NpbrP/?=
 =?us-ascii?Q?ne/yKIbyLs9mHeLhBq3kAnHctre9oY+dFD57O266mgOjzigyeOMfDcJ3401x?=
 =?us-ascii?Q?+Mg/+wtvXejP4548dtNcvZwWu9uwa0cZkhT0ZJkyt0sUjupLLo6N685Nf/VD?=
 =?us-ascii?Q?679RsyJ3AXC/8g0fuGCDR+sPz8qM4N18mDirMDbJ6M877iA/pUrOXJblDEDn?=
 =?us-ascii?Q?W1xwBQEx4749ifBjGQyqFSn4iJ9JYuh09NoW91PnBPkjbQ4Ic59e5tCdPPwc?=
 =?us-ascii?Q?5bGy+EZDdsohImVZ5gGBFBCx7029cEYO2acER4a4pwXivzSYNpr0ScWqbWBj?=
 =?us-ascii?Q?Xftlt4kPszSFlscZh+zNeodsVfz0JMnyr+CkdzmYgUNTdHanP7smsFfmMSKF?=
 =?us-ascii?Q?Ize7lot1h30Vy1w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:09:17.3803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fe60fc-c0b7-4bf0-212d-08dd2ee1d195
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6426

From: Moshe Shemesh <moshe@nvidia.com>

Add API function get capabilities to HW Steering flow commands.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/fs_hws.c         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index d5924e22952d..460f549cc2da 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1319,6 +1319,17 @@ static int mlx5_cmd_hws_destroy_match_definer(struct mlx5_flow_root_namespace *n
 	return -EOPNOTSUPP;
 }
 
+static u32 mlx5_cmd_hws_get_capabilities(struct mlx5_flow_root_namespace *ns,
+					 enum fs_flow_table_type ft_type)
+{
+	if (ft_type != FS_FT_FDB)
+		return 0;
+
+	return MLX5_FLOW_STEERING_CAP_VLAN_PUSH_ON_RX |
+	       MLX5_FLOW_STEERING_CAP_VLAN_POP_ON_TX |
+	       MLX5_FLOW_STEERING_CAP_MATCH_RANGES;
+}
+
 static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.create_flow_table = mlx5_cmd_hws_create_flow_table,
 	.destroy_flow_table = mlx5_cmd_hws_destroy_flow_table,
@@ -1338,6 +1349,7 @@ static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.create_ns = mlx5_cmd_hws_create_ns,
 	.destroy_ns = mlx5_cmd_hws_destroy_ns,
 	.set_peer = mlx5_cmd_hws_set_peer,
+	.get_capabilities = mlx5_cmd_hws_get_capabilities,
 };
 
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void)
-- 
2.45.0


