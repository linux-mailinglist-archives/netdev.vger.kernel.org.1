Return-Path: <netdev+bounces-116712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DD394B676
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935D41C21773
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BC6186295;
	Thu,  8 Aug 2024 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iN+9KjuB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182AE186E42
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096917; cv=fail; b=KA6nKifogpSwMQaQsMTmv+giYc0vcLSwAx4mDSKNLJy52h9pTwcb3qH0natVySQMgw0mlNH+cMQOp5zUijwpgEHJzGHjbYXQ3NMENy4Dn2LOq+qrXtW9s3Dix8RVFtE2jLuE3v7FO3xCdxPPr8vkIOxAISTOtHE3OMhk/JWMzO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096917; c=relaxed/simple;
	bh=0U8xYOqNwFaft+c6ZXZVcDB172Dnw2o0Sh5JpJ3gZrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2WewwT+eM630YDf7UlMR28IuMgFu8GjMOLJs8zGBJBghp6lUp+QkCfcCn9vK/Q69hOZkCok/r8rJlsUlLeUKytGTofLeVb5427UqvYSEf62KUb97hDLoOrEmovSGNBAqeUVfFLCbBup57Id3yp1CLTfBBFKTD53hWfsuAq6/bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iN+9KjuB; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/6pGdIy+6knT9v6mQ7xtA9u1AGQmiRyvU5q5Fy3JoBgPzZ2EE7G4DYk1467f/XkY0wlumRlFU9uxtThHq0QAii0za+7GfuIboTmCR+kXxIlNKAA/3xshrGU9c07rUDzkjirtqumGcAxsQBF4oVOnZPdlFmq0i5yinOlcm7Un/D6KfFbWACAcDZ17gyZxyl8XdwD8cR4U2qx9GrMOWniWxh84RLr1AHnODSEVEQc1YQrvHsFDTcCaijmaJA1bKWO5WHdztlM6BUzG951WjiOxY/5Y6+0FtVy/14RqXu0kCmPTpKBav2XaFxepuQANjwp7JDuEb+IbDP1F7AmBBrSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftQZCRzAw/XMcpxvhNLEX70wxbUeedk3pIzb1lwNJK4=;
 b=BQoy3Cp1y/Y4c4I/MU5pxFHQIZgjFdMiKXI6hYH3IlczdZP/984GoA95du51gPGvcA9JTjNH5DRlN4w6TUB9y7Wt5k1QQlplND03aBrf+OpcKrWSVhBf7NPXkjWEboOil/rIBFteHT4PyPtqYBt3ukc/6BWHTWFOUMm+IwWm9ocVD2PaSDve0+u/UzFNC3hTx5MQI3eM5RWYOEu/Um90z17N0Brh1msBzkJ3Kcbu+IIWEL+DP7awCeeA0yR72P9+cfnYUGclLKae2H6U1jXVB5M2HTQeYprhztk/dcUWm+Jq0pznnlI/bINXFMCS7/36gZ5pkGiKVXwcZbP+7st0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftQZCRzAw/XMcpxvhNLEX70wxbUeedk3pIzb1lwNJK4=;
 b=iN+9KjuBj5p4nWIsCYMVNUFWWUWA27FxGpti7xYD403J1ANw0CY3w4JnjMGl/Cmhc5xPVEMsrB68fW4tcwDgDCt41w+hkDwORJ2E/YtcrS8yvzROwts6nMoyEiVMrg13jk9Nh7Kk0fGszQDJ7496TEIeGS2mgEfl6XxupnCrr5tEg7pgXy0E4f9RI94sqxO0DRMeuOj5OfzlykphCyjnEfvtse0BkxaEoDxngDMVNdqdGlPB5KN4nS61GDOYOodkJ4G1C4fdNfwdvxUIHrQzghtBK2A30dCpdB2s+rLJ+DnppcPvgEzOVhdSMhWf51FNzr/wO+Ug2gsR8slwJqdRrg==
Received: from BYAPR03CA0036.namprd03.prod.outlook.com (2603:10b6:a02:a8::49)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 06:01:50 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::cb) by BYAPR03CA0036.outlook.office365.com
 (2603:10b6:a02:a8::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Thu, 8 Aug 2024 06:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 06:01:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 23:01:38 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 23:01:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 23:01:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 11/11] net/mlx5e: CT: Update connection tracking steering entries
Date: Thu, 8 Aug 2024 08:59:27 +0300
Message-ID: <20240808055927.2059700-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808055927.2059700-1-tariqt@nvidia.com>
References: <20240808055927.2059700-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 105339a3-8aa9-4048-b989-08dcb76f9877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jT1s454paW/A9/aBH4Go+72YPomoECSL244bjJcVidEc6B8Q9PO2PsJXjaP3?=
 =?us-ascii?Q?Grd/2bMEzT0w0oVEPxjF1cD7pPtbax1V0mb09Sial+W6rxfn2b34bfZtOuzc?=
 =?us-ascii?Q?5zdjuC/80lPWc/BwIeYgrAL+scUI0eHsbNQKNFdmOfGqrlwqyyTY/kYEDtup?=
 =?us-ascii?Q?f2JFysTjVuvb8CuESS+/6eHgLv2RTv3uYjtjxYW4tM2HCbQwj/AXxqj73T13?=
 =?us-ascii?Q?DEFNK6Q2UsKYlG581Cv3FYf/6yLz8pVJl+GVNOKHrjKI6R9AUFC6r5U6c9hj?=
 =?us-ascii?Q?e21U34xEE/5MAqUf/8+u52DJ4d64miYPRPZEn4NuBRMonK1Fl1p+MGUym26M?=
 =?us-ascii?Q?61BW/50i+QoEbFNWlLtjXdVCVS3DB2uRcf7n6j+N0KJNIFR1hSv81nh4QBYG?=
 =?us-ascii?Q?hYabEmJVKmrM2+36OynZYrZihOWKmFAbKGOnsHxX2dhsR7UNvNKLti/v/YR/?=
 =?us-ascii?Q?/DvoopDle3b69YtcrCcr9hPVrrRagF5+dDdgScGJ8FgEbs+Pw8oiGDQSeySe?=
 =?us-ascii?Q?EGXX3WwWxLaHU4nnQQOroEdiGtW3F19nlFI0n8XarGuZHzQkKMjZ7098FbyL?=
 =?us-ascii?Q?DrrF0c7XqwDuv/tu9HS/MBaYJcC2BbALYn687rT1BOVApFXNV0F++H3tR09D?=
 =?us-ascii?Q?HI2aOHsCrUmnmAM7qMs7VlCrbnUIu1Z7uGle1vJWZdSyrOY2+CSGbeWuGmpR?=
 =?us-ascii?Q?nNbbblrU79rz0Z1j7Ywdodj3bng5SpD1h75HFs40/JQ+m98h2xyOvmWHjPjd?=
 =?us-ascii?Q?BiABOSrfM5Gx3HurxmB8W4PKPwjdnzPc4Bkz5I6XCgfwP7uEwAglrnLrgJxc?=
 =?us-ascii?Q?uBnDGFU+AE7YtEELCL+B+TnfTo6Ly5eCUUsFEaz6nJs5MFFqOOookvDSWQst?=
 =?us-ascii?Q?ZI9Pcf7mSui5zkEf5kPab+IWacbFwNAhUIEcVtJtazYsQc1BsdkcgszUt4n5?=
 =?us-ascii?Q?6p6gHCjsOAP7mcrp0qID//UVia04UyVHxubxivugA2taBma5T5k1avnwP2+I?=
 =?us-ascii?Q?lK3nEolXSiOvnDYXmRvbe+W9+Qy6wCFBy7540mNkHKG6fcqMr5msRtvZqhmD?=
 =?us-ascii?Q?iBZUmwCD/UhY/pGA3YDkyCi8DzpNBpDD+4Lc5FE3m8oDFhpwDmZu30XHwHWG?=
 =?us-ascii?Q?nDIuubjdT4o7gHsEbbtQ5zsp1qRT3pFvksMXs/AuW4Wi8uB2c5mBpKHTTezp?=
 =?us-ascii?Q?KHF640KwIs0mmaqS0go5WVgkFQIj9BJBQPysDpUKwXKb2Pt1Q1xzKMLm7k7J?=
 =?us-ascii?Q?NcLf8DP/ipmO0KOhgHF0+26NOqTKNIydmOOXp3mS0aetZYu08cTTkHCixSam?=
 =?us-ascii?Q?Sdz08M7madsj+fFrGlOlbk6pGox7Wajt4lv8KJ/FSaQyFbq5Va6t/jphtvpz?=
 =?us-ascii?Q?2ceOoV1DkXP4FqBfU2XyiqenGxWpK16OFCUuvmxmU3trcJawsHPfj5jxNvY9?=
 =?us-ascii?Q?kvztS0AJKOpVmbs7yGoY0n5txTMC6ZAC?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:01:50.6066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 105339a3-8aa9-4048-b989-08dcb76f9877
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052

From: Cosmin Ratiu <cratiu@nvidia.com>

Previously, replacing a connection tracking steering entry was done by
adding a new rule (with the same tag but possibly different mod hdr
actions/labels) then removing the old rule.

This approach doesn't work in hardware steering because two steering
entries with the same tag cannot coexist in a hardware steering table.

This commit prepares for that by adding a new ct_rule_update operation on
the ct_fs_ops struct which is used instead of add+delete.
Implementations for both dmfs (firmware steering) and smfs (software
steering) are provided, which simply add the new rule and delete the old
one.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs.h |  2 ++
 .../mellanox/mlx5/core/en/tc/ct_fs_dmfs.c     | 21 +++++++++++++++
 .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     | 26 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 12 +++------
 4 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h
index bb6b1a979ba1..62b3f7ff5562 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h
@@ -25,6 +25,8 @@ struct mlx5_ct_fs_ops {
 						struct mlx5_flow_attr *attr,
 						struct flow_rule *flow_rule);
 	void (*ct_rule_del)(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_rule);
+	int (*ct_rule_update)(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_rule,
+			      struct mlx5_flow_spec *spec, struct mlx5_flow_attr *attr);
 
 	size_t priv_size;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_dmfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_dmfs.c
index ae4f55be48ce..64a82aafaaca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_dmfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_dmfs.c
@@ -65,9 +65,30 @@ mlx5_ct_fs_dmfs_ct_rule_del(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_ru
 	kfree(dmfs_rule);
 }
 
+static int mlx5_ct_fs_dmfs_ct_rule_update(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_rule,
+					  struct mlx5_flow_spec *spec, struct mlx5_flow_attr *attr)
+{
+	struct mlx5_ct_fs_dmfs_rule *dmfs_rule = container_of(fs_rule,
+							      struct mlx5_ct_fs_dmfs_rule,
+							      fs_rule);
+	struct mlx5e_priv *priv = netdev_priv(fs->netdev);
+	struct mlx5_flow_handle *rule;
+
+	rule = mlx5_tc_rule_insert(priv, spec, attr);
+	if (IS_ERR(rule))
+		return PTR_ERR(rule);
+	mlx5_tc_rule_delete(priv, dmfs_rule->rule, dmfs_rule->attr);
+
+	dmfs_rule->rule = rule;
+	dmfs_rule->attr = attr;
+
+	return 0;
+}
+
 static struct mlx5_ct_fs_ops dmfs_ops = {
 	.ct_rule_add = mlx5_ct_fs_dmfs_ct_rule_add,
 	.ct_rule_del = mlx5_ct_fs_dmfs_ct_rule_del,
+	.ct_rule_update = mlx5_ct_fs_dmfs_ct_rule_update,
 
 	.init = mlx5_ct_fs_dmfs_init,
 	.destroy = mlx5_ct_fs_dmfs_destroy,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
index 8c531f4ec912..1c062a2e8996 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
@@ -368,9 +368,35 @@ mlx5_ct_fs_smfs_ct_rule_del(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_ru
 	kfree(smfs_rule);
 }
 
+static int mlx5_ct_fs_smfs_ct_rule_update(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_rule,
+					  struct mlx5_flow_spec *spec, struct mlx5_flow_attr *attr)
+{
+	struct mlx5_ct_fs_smfs_rule *smfs_rule = container_of(fs_rule,
+							      struct mlx5_ct_fs_smfs_rule,
+							      fs_rule);
+	struct mlx5_ct_fs_smfs *fs_smfs = mlx5_ct_fs_priv(fs);
+	struct mlx5dr_action *actions[3];  /* We only need to create 3 actions, see below. */
+	struct mlx5dr_rule *rule;
+
+	actions[0] = smfs_rule->count_action;
+	actions[1] = attr->modify_hdr->action.dr_action;
+	actions[2] = fs_smfs->fwd_action;
+
+	rule = mlx5_smfs_rule_create(smfs_rule->smfs_matcher->dr_matcher, spec,
+				     ARRAY_SIZE(actions), actions, spec->flow_context.flow_source);
+	if (!rule)
+		return -EINVAL;
+
+	mlx5_smfs_rule_destroy(smfs_rule->rule);
+	smfs_rule->rule = rule;
+
+	return 0;
+}
+
 static struct mlx5_ct_fs_ops fs_smfs_ops = {
 	.ct_rule_add = mlx5_ct_fs_smfs_ct_rule_add,
 	.ct_rule_del = mlx5_ct_fs_smfs_ct_rule_del,
+	.ct_rule_update = mlx5_ct_fs_smfs_ct_rule_update,
 
 	.init = mlx5_ct_fs_smfs_init,
 	.destroy = mlx5_ct_fs_smfs_destroy,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index ccee07d6ba1d..dcfccaaa8d91 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -884,7 +884,6 @@ mlx5_tc_ct_entry_update_rule(struct mlx5_tc_ct_priv *ct_priv,
 	struct mlx5_ct_zone_rule *zone_rule = &entry->zone_rules[nat];
 	struct mlx5_flow_attr *attr = zone_rule->attr, *old_attr;
 	struct mlx5e_mod_hdr_handle *mh;
-	struct mlx5_ct_fs_rule *rule;
 	struct mlx5_flow_spec *spec;
 	int err;
 
@@ -902,22 +901,19 @@ mlx5_tc_ct_entry_update_rule(struct mlx5_tc_ct_priv *ct_priv,
 	err = mlx5_tc_ct_entry_create_mod_hdr(ct_priv, attr, flow_rule, &mh, zone_restore_id,
 					      nat, mlx5_tc_ct_entry_in_ct_nat_table(entry));
 	if (err) {
-		ct_dbg("Failed to create ct entry mod hdr");
+		ct_dbg("Failed to create ct entry mod hdr, err: %d", err);
 		goto err_mod_hdr;
 	}
 
 	mlx5_tc_ct_set_tuple_match(ct_priv, spec, flow_rule);
 	mlx5e_tc_match_to_reg_match(spec, ZONE_TO_REG, entry->tuple.zone, MLX5_CT_ZONE_MASK);
 
-	rule = ct_priv->fs_ops->ct_rule_add(ct_priv->fs, spec, attr, flow_rule);
-	if (IS_ERR(rule)) {
-		err = PTR_ERR(rule);
-		ct_dbg("Failed to add replacement ct entry rule, nat: %d", nat);
+	err = ct_priv->fs_ops->ct_rule_update(ct_priv->fs, zone_rule->rule, spec, attr);
+	if (err) {
+		ct_dbg("Failed to update ct entry rule, nat: %d, err: %d", nat, err);
 		goto err_rule;
 	}
 
-	ct_priv->fs_ops->ct_rule_del(ct_priv->fs, zone_rule->rule);
-	zone_rule->rule = rule;
 	mlx5_tc_ct_entry_destroy_mod_hdr(ct_priv, old_attr, zone_rule->mh);
 	zone_rule->mh = mh;
 	mlx5_put_label_mapping(ct_priv, old_attr->ct_attr.ct_labels_id);
-- 
2.44.0


