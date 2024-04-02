Return-Path: <netdev+bounces-84033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1400A895574
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925BA1F21C01
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7309E8595B;
	Tue,  2 Apr 2024 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mz2LmSuJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F284FC3
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064757; cv=fail; b=RQi5zka+Nxu9DCfi9Fe93v4hgVaKx0WL4naCXfvvpc67ZhrmnpgzFJPPyJ5T8Smh5V9HN5AeXRQdbbbkp6/mQAtUO6PEH7bOHjRBQaIB585aMLdAMq6O47zDwEjYdtH2nchMtLyropdtU2zNGXBV3RF5s0dHXyCikGx9/CiVsp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064757; c=relaxed/simple;
	bh=v5czoYCUWdnytbDMhEQo5sGYS/OimYtJXIBgn1hUbzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATkwx5rg11rvTEh3wa2SAq1qjRWWdUM4ksG6WCPdx33IRN9LTECg/srlYbvRtG5TakUVo4voEm+EEdcUxq8kgIyH1SuLt/Zd0wguOnx63io75nFD0eSd3X6+3khE3Y9pmfsY7aaV5/n0UgU/FIYajsgcaNj8QqIePov/T2g1MHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mz2LmSuJ; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+6OVUK6EFw+MqjvIFsyHLZtef5Q96BSZDujIh3lVuhRrjJJKQcXToDGBntri9DUKRZxXcQ1wVyhdmwJgsWLFhVCiq1pguXjjhS5VGIQto1R3XlJtluSlIKf7zrQYKd4p2F7SZbDlJ1Vvlu1nys31fu4MMC3pPkv8QKojXcyzxPnCtfxfqQLZROsuxmXRzu1lEODWwV262jppebamuLZnafmalMkwM8SD4Zau/RLlK+rRQMiImrv2LJ4df3+383lY/B8F9hjWU7qM/E0tbzSEdz8XtO7yiPnfMOWx2RX3lIQPwbxKW5elxTnE2axvVfnne93ubBirhFgreJeKq4TkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtQ353Hwr7cpDWwEMgo899yQYw56HVk8dOfzsjBmoSk=;
 b=T/qE2mVMkl9u+oTcLIQzNk0WSyc00z0bSi9/HR6PhdMg1xr+VHgj3zG3SBEXnQbA1EobxcfK2kI1T/A9Ohfmsag+aiIDEceb3DKsF3QjSP7ouWFCzQE6vl/DqxUvrLddF/UFuv1+K98m6xYLW2fFw+mKCtrAJCqBDYJyNp1eBbaR9IlqAVfnpGXw7HYIC9Q1JYL8VSKiO8rQXkqOtRL9PpICWUZ+LimVbIadKRLIgXTyMLKddVPiNtsMXP0Tl9u0HB1faeoIHi5Ikh+QQJjpbXMmaRocy87DVTxV9FfEVCXOH/YlbqVpHTYjfiuuRNICmSdRIeUOqVP8q68ONWD9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtQ353Hwr7cpDWwEMgo899yQYw56HVk8dOfzsjBmoSk=;
 b=mz2LmSuJzas0+9neZdfIiUKOMZGXubzlxh0cqGYFwCgAx4Jieg5kEZ36CwMHgmGO450e9J0VtU2bEbk2dgtSVtrkf2lB6rx0nBjc/ZtuOjRYEWQTwReozY6faAeMp0Ft8e2MrjryhWXtpHr84fNrQOuiQgya9vSm813MNlUyKMf+7lRr+W4d47JLplegDkF9QO4NV6hTP6Yagjf3Vt8IWq8rjxI9mUT8FYGAqO+MxhLJzECZ5pHu7dqilVdA4yXLfzik80Xx3AqF99zqreC9741zeebRRfWkKX3e/nOJFBViXBfJTdr+g3yZYIzbwErln/XGvDrp5X4Ce7wcH6mK9g==
Received: from BL0PR02CA0095.namprd02.prod.outlook.com (2603:10b6:208:51::36)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:32:30 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::4d) by BL0PR02CA0095.outlook.office365.com
 (2603:10b6:208:51::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:32:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:32:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:32:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 2 Apr
 2024 06:32:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 09/11] net/mlx5: Support matching on l4_type for ttc_table
Date: Tue, 2 Apr 2024 16:30:41 +0300
Message-ID: <20240402133043.56322-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402133043.56322-1-tariqt@nvidia.com>
References: <20240402133043.56322-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb1d685-ded8-47c1-5054-08dc53195841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YaNSJonb+btoy9zzAFEnk5RSSuFMyviYfIVZZxgFj8+h1RNCTxOldYfrrA3IQgCzbzplmjioLiU7X+zpeNbl1c0sE+gFkC7cGq8fFGdFk2RolPAi7hhtraO6eFRIsY/MvqzwBpjIBWLJVLrH0jb1co0YvQduMGq9PfZD8wryd3m54XzyN5t+gDYZerbyBF7Q/uxdKqNyXTUYdzXKw6oyQPK6PgIavKDBbwM8QN1iVEhmaOuBnSp6/qtojRvYWjp9K4cATRef7daS/hXpRvFCrci4h8KCUY6345LqbWiFwqPWBjDdigiPfa7l/UqtdR1orTikXcvlSx7EOlmHVPY8vZKE1hdRTHZ0+AwlcWyqWjqOUnrUk0aVJAbPwXO/NP52zCiAPzY/XYSWEnOJcr3iNASoRnRUdXCr0OQ9FREuujFWL1nTZo+V2q/aiby5tT/PEK/8sClX5XRymZ9TzWpQlK4CF+zqfIgz6+6L6xMGVgDeregWOgQl7yoxNw7qLdcHv/xX8yQtdpgGtSU2KRo2NrsutOEeVyw2nBvmA5V4XBCkIz9vmDY2CxfKSTyElGZpDExotStifo71FzDrn+yWSeLkP5jN831rqulAM5ZKOigUkMPcatq6NlFhJ9ev/3FDum0zYuJ4Yeu7qVy4Exu6f1wY4yims8VkOZMAl1KwmFub6CtcpHH6sDg38pQb3QZXEqFYgY9lXrVLhsgNM/w64Dpe3UjZGCffhkNMGXpA35vuWxZBFfMlny5H7rgQx8nu
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:32:29.7543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb1d685-ded8-47c1-5054-08dc53195841
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755

From: Jianbo Liu <jianbol@nvidia.com>

Replace matching on TCP and UDP protocols with new l4_type field which
is parsed by steering for ttc_table. It is enabled by the
outer_l4_type or inner_l4_type bits in nic_rx or port_sel flow table
capabilities and used only if pcc_ifa2 bit in HCA capabilities is set.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   3 +-
 .../mellanox/mlx5/core/lag/port_sel.c         |   8 +-
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.c  | 254 ++++++++++++++----
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.h  |   2 +-
 include/linux/mlx5/device.h                   |   6 +
 include/linux/mlx5/mlx5_ifc.h                 |  32 ++-
 7 files changed, 244 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 777d311d44ef..8c5b291a171f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -896,8 +896,7 @@ static void mlx5e_set_inner_ttc_params(struct mlx5e_flow_steering *fs,
 	int tt;
 
 	memset(ttc_params, 0, sizeof(*ttc_params));
-	ttc_params->ns = mlx5_get_flow_namespace(fs->mdev,
-						 MLX5_FLOW_NAMESPACE_KERNEL);
+	ttc_params->ns_type = MLX5_FLOW_NAMESPACE_KERNEL;
 	ft_attr->level = MLX5E_INNER_TTC_FT_LEVEL;
 	ft_attr->prio = MLX5E_NIC_PRIO;
 
@@ -920,8 +919,7 @@ void mlx5e_set_ttc_params(struct mlx5e_flow_steering *fs,
 	int tt;
 
 	memset(ttc_params, 0, sizeof(*ttc_params));
-	ttc_params->ns = mlx5_get_flow_namespace(fs->mdev,
-						 MLX5_FLOW_NAMESPACE_KERNEL);
+	ttc_params->ns_type = MLX5_FLOW_NAMESPACE_KERNEL;
 	ft_attr->level = MLX5E_TTC_FT_LEVEL;
 	ft_attr->prio = MLX5E_NIC_PRIO;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index f2f19fa37d91..aeb32cb27182 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -835,8 +835,7 @@ static void mlx5e_hairpin_set_ttc_params(struct mlx5e_hairpin *hp,
 
 	memset(ttc_params, 0, sizeof(*ttc_params));
 
-	ttc_params->ns = mlx5_get_flow_namespace(hp->func_mdev,
-						 MLX5_FLOW_NAMESPACE_KERNEL);
+	ttc_params->ns_type = MLX5_FLOW_NAMESPACE_KERNEL;
 	for (tt = 0; tt < MLX5_NUM_TT; tt++) {
 		ttc_params->dests[tt].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
 		ttc_params->dests[tt].tir_num =
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index 101b3bb90863..c16b462ddedf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -449,13 +449,11 @@ static void set_tt_map(struct mlx5_lag_port_sel *port_sel,
 static void mlx5_lag_set_inner_ttc_params(struct mlx5_lag *ldev,
 					  struct ttc_params *ttc_params)
 {
-	struct mlx5_core_dev *dev = ldev->pf[MLX5_LAG_P1].dev;
 	struct mlx5_lag_port_sel *port_sel = &ldev->port_sel;
 	struct mlx5_flow_table_attr *ft_attr;
 	int tt;
 
-	ttc_params->ns = mlx5_get_flow_namespace(dev,
-						 MLX5_FLOW_NAMESPACE_PORT_SEL);
+	ttc_params->ns_type = MLX5_FLOW_NAMESPACE_PORT_SEL;
 	ft_attr = &ttc_params->ft_attr;
 	ft_attr->level = MLX5_LAG_FT_LEVEL_INNER_TTC;
 
@@ -470,13 +468,11 @@ static void mlx5_lag_set_inner_ttc_params(struct mlx5_lag *ldev,
 static void mlx5_lag_set_outer_ttc_params(struct mlx5_lag *ldev,
 					  struct ttc_params *ttc_params)
 {
-	struct mlx5_core_dev *dev = ldev->pf[MLX5_LAG_P1].dev;
 	struct mlx5_lag_port_sel *port_sel = &ldev->port_sel;
 	struct mlx5_flow_table_attr *ft_attr;
 	int tt;
 
-	ttc_params->ns = mlx5_get_flow_namespace(dev,
-						 MLX5_FLOW_NAMESPACE_PORT_SEL);
+	ttc_params->ns_type = MLX5_FLOW_NAMESPACE_PORT_SEL;
 	ft_attr = &ttc_params->ft_attr;
 	ft_attr->level = MLX5_LAG_FT_LEVEL_TTC;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index b78f2ba25c19..9f13cea16446 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -9,21 +9,24 @@
 #include "mlx5_core.h"
 #include "lib/fs_ttc.h"
 
-#define MLX5_TTC_NUM_GROUPS	3
-#define MLX5_TTC_GROUP1_SIZE	(BIT(3) + MLX5_NUM_TUNNEL_TT)
-#define MLX5_TTC_GROUP2_SIZE	 BIT(1)
-#define MLX5_TTC_GROUP3_SIZE	 BIT(0)
-#define MLX5_TTC_TABLE_SIZE	(MLX5_TTC_GROUP1_SIZE +\
-				 MLX5_TTC_GROUP2_SIZE +\
-				 MLX5_TTC_GROUP3_SIZE)
-
-#define MLX5_INNER_TTC_NUM_GROUPS	3
-#define MLX5_INNER_TTC_GROUP1_SIZE	BIT(3)
-#define MLX5_INNER_TTC_GROUP2_SIZE	BIT(1)
-#define MLX5_INNER_TTC_GROUP3_SIZE	BIT(0)
-#define MLX5_INNER_TTC_TABLE_SIZE	(MLX5_INNER_TTC_GROUP1_SIZE +\
-					 MLX5_INNER_TTC_GROUP2_SIZE +\
-					 MLX5_INNER_TTC_GROUP3_SIZE)
+#define MLX5_TTC_MAX_NUM_GROUPS		4
+#define MLX5_TTC_GROUP_TCPUDP_SIZE	(MLX5_TT_IPV6_UDP + 1)
+
+struct mlx5_fs_ttc_groups {
+	bool use_l4_type;
+	int num_groups;
+	int group_size[MLX5_TTC_MAX_NUM_GROUPS];
+};
+
+static int mlx5_fs_ttc_table_size(const struct mlx5_fs_ttc_groups *groups)
+{
+	int i, sz = 0;
+
+	for (i = 0; i < groups->num_groups; i++)
+		sz += groups->group_size[i];
+
+	return sz;
+}
 
 /* L3/L4 traffic type classifier */
 struct mlx5_ttc_table {
@@ -138,6 +141,53 @@ static struct mlx5_etype_proto ttc_tunnel_rules[] = {
 
 };
 
+enum TTC_GROUP_TYPE {
+	TTC_GROUPS_DEFAULT = 0,
+	TTC_GROUPS_USE_L4_TYPE = 1,
+};
+
+static const struct mlx5_fs_ttc_groups ttc_groups[] = {
+	[TTC_GROUPS_DEFAULT] = {
+		.num_groups = 3,
+		.group_size = {
+			BIT(3) + MLX5_NUM_TUNNEL_TT,
+			BIT(1),
+			BIT(0),
+		},
+	},
+	[TTC_GROUPS_USE_L4_TYPE] = {
+		.use_l4_type = true,
+		.num_groups = 4,
+		.group_size = {
+			MLX5_TTC_GROUP_TCPUDP_SIZE,
+			BIT(3) + MLX5_NUM_TUNNEL_TT - MLX5_TTC_GROUP_TCPUDP_SIZE,
+			BIT(1),
+			BIT(0),
+		},
+	},
+};
+
+static const struct mlx5_fs_ttc_groups inner_ttc_groups[] = {
+	[TTC_GROUPS_DEFAULT] = {
+		.num_groups = 3,
+		.group_size = {
+			BIT(3),
+			BIT(1),
+			BIT(0),
+		},
+	},
+	[TTC_GROUPS_USE_L4_TYPE] = {
+		.use_l4_type = true,
+		.num_groups = 4,
+		.group_size = {
+			MLX5_TTC_GROUP_TCPUDP_SIZE,
+			BIT(3) - MLX5_TTC_GROUP_TCPUDP_SIZE,
+			BIT(1),
+			BIT(0),
+		},
+	},
+};
+
 u8 mlx5_get_proto_by_tunnel_type(enum mlx5_tunnel_types tt)
 {
 	return ttc_tunnel_rules[tt].proto;
@@ -188,9 +238,29 @@ static u8 mlx5_etype_to_ipv(u16 ethertype)
 	return 0;
 }
 
+static void mlx5_fs_ttc_set_match_proto(void *headers_c, void *headers_v,
+					u8 proto, bool use_l4_type)
+{
+	int l4_type;
+
+	if (use_l4_type && (proto == IPPROTO_TCP || proto == IPPROTO_UDP)) {
+		if (proto == IPPROTO_TCP)
+			l4_type = MLX5_PACKET_L4_TYPE_TCP;
+		else
+			l4_type = MLX5_PACKET_L4_TYPE_UDP;
+
+		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, l4_type);
+		MLX5_SET(fte_match_set_lyr_2_4, headers_v, l4_type, l4_type);
+	} else {
+		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, ip_protocol);
+		MLX5_SET(fte_match_set_lyr_2_4, headers_v, ip_protocol, proto);
+	}
+}
+
 static struct mlx5_flow_handle *
 mlx5_generate_ttc_rule(struct mlx5_core_dev *dev, struct mlx5_flow_table *ft,
-		       struct mlx5_flow_destination *dest, u16 etype, u8 proto)
+		       struct mlx5_flow_destination *dest, u16 etype, u8 proto,
+		       bool use_l4_type)
 {
 	int match_ipv_outer =
 		MLX5_CAP_FLOWTABLE_NIC_RX(dev,
@@ -207,8 +277,13 @@ mlx5_generate_ttc_rule(struct mlx5_core_dev *dev, struct mlx5_flow_table *ft,
 
 	if (proto) {
 		spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
-		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, outer_headers.ip_protocol);
-		MLX5_SET(fte_match_param, spec->match_value, outer_headers.ip_protocol, proto);
+		mlx5_fs_ttc_set_match_proto(MLX5_ADDR_OF(fte_match_param,
+							 spec->match_criteria,
+							 outer_headers),
+					    MLX5_ADDR_OF(fte_match_param,
+							 spec->match_value,
+							 outer_headers),
+					    proto, use_l4_type);
 	}
 
 	ipv = mlx5_etype_to_ipv(etype);
@@ -234,7 +309,8 @@ mlx5_generate_ttc_rule(struct mlx5_core_dev *dev, struct mlx5_flow_table *ft,
 
 static int mlx5_generate_ttc_table_rules(struct mlx5_core_dev *dev,
 					 struct ttc_params *params,
-					 struct mlx5_ttc_table *ttc)
+					 struct mlx5_ttc_table *ttc,
+					 bool use_l4_type)
 {
 	struct mlx5_flow_handle **trules;
 	struct mlx5_ttc_rule *rules;
@@ -251,7 +327,8 @@ static int mlx5_generate_ttc_table_rules(struct mlx5_core_dev *dev,
 			continue;
 		rule->rule = mlx5_generate_ttc_rule(dev, ft, &params->dests[tt],
 						    ttc_rules[tt].etype,
-						    ttc_rules[tt].proto);
+						    ttc_rules[tt].proto,
+						    use_l4_type);
 		if (IS_ERR(rule->rule)) {
 			err = PTR_ERR(rule->rule);
 			rule->rule = NULL;
@@ -273,7 +350,8 @@ static int mlx5_generate_ttc_table_rules(struct mlx5_core_dev *dev,
 		trules[tt] = mlx5_generate_ttc_rule(dev, ft,
 						    &params->tunnel_dests[tt],
 						    ttc_tunnel_rules[tt].etype,
-						    ttc_tunnel_rules[tt].proto);
+						    ttc_tunnel_rules[tt].proto,
+						    use_l4_type);
 		if (IS_ERR(trules[tt])) {
 			err = PTR_ERR(trules[tt]);
 			trules[tt] = NULL;
@@ -289,7 +367,8 @@ static int mlx5_generate_ttc_table_rules(struct mlx5_core_dev *dev,
 }
 
 static int mlx5_create_ttc_table_groups(struct mlx5_ttc_table *ttc,
-					bool use_ipv)
+					bool use_ipv,
+					const struct mlx5_fs_ttc_groups *groups)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	int ix = 0;
@@ -297,7 +376,7 @@ static int mlx5_create_ttc_table_groups(struct mlx5_ttc_table *ttc,
 	int err;
 	u8 *mc;
 
-	ttc->g = kcalloc(MLX5_TTC_NUM_GROUPS, sizeof(*ttc->g), GFP_KERNEL);
+	ttc->g = kcalloc(groups->num_groups, sizeof(*ttc->g), GFP_KERNEL);
 	if (!ttc->g)
 		return -ENOMEM;
 	in = kvzalloc(inlen, GFP_KERNEL);
@@ -307,16 +386,31 @@ static int mlx5_create_ttc_table_groups(struct mlx5_ttc_table *ttc,
 		return -ENOMEM;
 	}
 
-	/* L4 Group */
 	mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
-	MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ip_protocol);
 	if (use_ipv)
 		MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ip_version);
 	else
 		MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ethertype);
 	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
+
+	/* TCP UDP group */
+	if (groups->use_l4_type) {
+		MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.l4_type);
+		MLX5_SET_CFG(in, start_flow_index, ix);
+		ix += groups->group_size[ttc->num_groups];
+		MLX5_SET_CFG(in, end_flow_index, ix - 1);
+		ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
+		if (IS_ERR(ttc->g[ttc->num_groups]))
+			goto err;
+		ttc->num_groups++;
+
+		MLX5_SET(fte_match_param, mc, outer_headers.l4_type, 0);
+	}
+
+	/* L4 Group */
+	MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ip_protocol);
 	MLX5_SET_CFG(in, start_flow_index, ix);
-	ix += MLX5_TTC_GROUP1_SIZE;
+	ix += groups->group_size[ttc->num_groups];
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
 	if (IS_ERR(ttc->g[ttc->num_groups]))
@@ -326,7 +420,7 @@ static int mlx5_create_ttc_table_groups(struct mlx5_ttc_table *ttc,
 	/* L3 Group */
 	MLX5_SET(fte_match_param, mc, outer_headers.ip_protocol, 0);
 	MLX5_SET_CFG(in, start_flow_index, ix);
-	ix += MLX5_TTC_GROUP2_SIZE;
+	ix += groups->group_size[ttc->num_groups];
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
 	if (IS_ERR(ttc->g[ttc->num_groups]))
@@ -336,7 +430,7 @@ static int mlx5_create_ttc_table_groups(struct mlx5_ttc_table *ttc,
 	/* Any Group */
 	memset(in, 0, inlen);
 	MLX5_SET_CFG(in, start_flow_index, ix);
-	ix += MLX5_TTC_GROUP3_SIZE;
+	ix += groups->group_size[ttc->num_groups];
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
 	if (IS_ERR(ttc->g[ttc->num_groups]))
@@ -358,7 +452,7 @@ static struct mlx5_flow_handle *
 mlx5_generate_inner_ttc_rule(struct mlx5_core_dev *dev,
 			     struct mlx5_flow_table *ft,
 			     struct mlx5_flow_destination *dest,
-			     u16 etype, u8 proto)
+			     u16 etype, u8 proto, bool use_l4_type)
 {
 	MLX5_DECLARE_FLOW_ACT(flow_act);
 	struct mlx5_flow_handle *rule;
@@ -379,8 +473,13 @@ mlx5_generate_inner_ttc_rule(struct mlx5_core_dev *dev,
 
 	if (proto) {
 		spec->match_criteria_enable = MLX5_MATCH_INNER_HEADERS;
-		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, inner_headers.ip_protocol);
-		MLX5_SET(fte_match_param, spec->match_value, inner_headers.ip_protocol, proto);
+		mlx5_fs_ttc_set_match_proto(MLX5_ADDR_OF(fte_match_param,
+							 spec->match_criteria,
+							 inner_headers),
+					    MLX5_ADDR_OF(fte_match_param,
+							 spec->match_value,
+							 inner_headers),
+					    proto, use_l4_type);
 	}
 
 	rule = mlx5_add_flow_rules(ft, spec, &flow_act, dest, 1);
@@ -395,7 +494,8 @@ mlx5_generate_inner_ttc_rule(struct mlx5_core_dev *dev,
 
 static int mlx5_generate_inner_ttc_table_rules(struct mlx5_core_dev *dev,
 					       struct ttc_params *params,
-					       struct mlx5_ttc_table *ttc)
+					       struct mlx5_ttc_table *ttc,
+					       bool use_l4_type)
 {
 	struct mlx5_ttc_rule *rules;
 	struct mlx5_flow_table *ft;
@@ -413,7 +513,8 @@ static int mlx5_generate_inner_ttc_table_rules(struct mlx5_core_dev *dev,
 		rule->rule = mlx5_generate_inner_ttc_rule(dev, ft,
 							  &params->dests[tt],
 							  ttc_rules[tt].etype,
-							  ttc_rules[tt].proto);
+							  ttc_rules[tt].proto,
+							  use_l4_type);
 		if (IS_ERR(rule->rule)) {
 			err = PTR_ERR(rule->rule);
 			rule->rule = NULL;
@@ -430,7 +531,8 @@ static int mlx5_generate_inner_ttc_table_rules(struct mlx5_core_dev *dev,
 	return err;
 }
 
-static int mlx5_create_inner_ttc_table_groups(struct mlx5_ttc_table *ttc)
+static int mlx5_create_inner_ttc_table_groups(struct mlx5_ttc_table *ttc,
+					      const struct mlx5_fs_ttc_groups *groups)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	int ix = 0;
@@ -438,8 +540,7 @@ static int mlx5_create_inner_ttc_table_groups(struct mlx5_ttc_table *ttc)
 	int err;
 	u8 *mc;
 
-	ttc->g = kcalloc(MLX5_INNER_TTC_NUM_GROUPS, sizeof(*ttc->g),
-			 GFP_KERNEL);
+	ttc->g = kcalloc(groups->num_groups, sizeof(*ttc->g), GFP_KERNEL);
 	if (!ttc->g)
 		return -ENOMEM;
 	in = kvzalloc(inlen, GFP_KERNEL);
@@ -449,13 +550,28 @@ static int mlx5_create_inner_ttc_table_groups(struct mlx5_ttc_table *ttc)
 		return -ENOMEM;
 	}
 
-	/* L4 Group */
 	mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
-	MLX5_SET_TO_ONES(fte_match_param, mc, inner_headers.ip_protocol);
 	MLX5_SET_TO_ONES(fte_match_param, mc, inner_headers.ip_version);
 	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_INNER_HEADERS);
+
+	/* TCP UDP group */
+	if (groups->use_l4_type) {
+		MLX5_SET_TO_ONES(fte_match_param, mc, inner_headers.l4_type);
+		MLX5_SET_CFG(in, start_flow_index, ix);
+		ix += groups->group_size[ttc->num_groups];
+		MLX5_SET_CFG(in, end_flow_index, ix - 1);
+		ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
+		if (IS_ERR(ttc->g[ttc->num_groups]))
+			goto err;
+		ttc->num_groups++;
+
+		MLX5_SET(fte_match_param, mc, inner_headers.l4_type, 0);
+	}
+
+	/* L4 Group */
+	MLX5_SET_TO_ONES(fte_match_param, mc, inner_headers.ip_protocol);
 	MLX5_SET_CFG(in, start_flow_index, ix);
-	ix += MLX5_INNER_TTC_GROUP1_SIZE;
+	ix += groups->group_size[ttc->num_groups];
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
 	if (IS_ERR(ttc->g[ttc->num_groups]))
@@ -465,7 +581,7 @@ static int mlx5_create_inner_ttc_table_groups(struct mlx5_ttc_table *ttc)
 	/* L3 Group */
 	MLX5_SET(fte_match_param, mc, inner_headers.ip_protocol, 0);
 	MLX5_SET_CFG(in, start_flow_index, ix);
-	ix += MLX5_INNER_TTC_GROUP2_SIZE;
+	ix += groups->group_size[ttc->num_groups];
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
 	if (IS_ERR(ttc->g[ttc->num_groups]))
@@ -475,7 +591,7 @@ static int mlx5_create_inner_ttc_table_groups(struct mlx5_ttc_table *ttc)
 	/* Any Group */
 	memset(in, 0, inlen);
 	MLX5_SET_CFG(in, start_flow_index, ix);
-	ix += MLX5_INNER_TTC_GROUP3_SIZE;
+	ix += groups->group_size[ttc->num_groups];
 	MLX5_SET_CFG(in, end_flow_index, ix - 1);
 	ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
 	if (IS_ERR(ttc->g[ttc->num_groups]))
@@ -496,27 +612,47 @@ static int mlx5_create_inner_ttc_table_groups(struct mlx5_ttc_table *ttc)
 struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
 						   struct ttc_params *params)
 {
+	const struct mlx5_fs_ttc_groups *groups;
+	struct mlx5_flow_namespace *ns;
 	struct mlx5_ttc_table *ttc;
+	bool use_l4_type;
 	int err;
 
 	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
 	if (!ttc)
 		return ERR_PTR(-ENOMEM);
 
+	switch (params->ns_type) {
+	case MLX5_FLOW_NAMESPACE_PORT_SEL:
+		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
+			MLX5_CAP_PORT_SELECTION_FT_FIELD_SUPPORT_2(dev, inner_l4_type);
+		break;
+	case MLX5_FLOW_NAMESPACE_KERNEL:
+		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
+			MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(dev, inner_l4_type);
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	groups = use_l4_type ? &inner_ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
+			       &inner_ttc_groups[TTC_GROUPS_DEFAULT];
+
 	WARN_ON_ONCE(params->ft_attr.max_fte);
-	params->ft_attr.max_fte = MLX5_INNER_TTC_TABLE_SIZE;
-	ttc->t = mlx5_create_flow_table(params->ns, &params->ft_attr);
+	params->ft_attr.max_fte = mlx5_fs_ttc_table_size(groups);
+	ttc->t = mlx5_create_flow_table(ns, &params->ft_attr);
 	if (IS_ERR(ttc->t)) {
 		err = PTR_ERR(ttc->t);
 		kvfree(ttc);
 		return ERR_PTR(err);
 	}
 
-	err = mlx5_create_inner_ttc_table_groups(ttc);
+	err = mlx5_create_inner_ttc_table_groups(ttc, groups);
 	if (err)
 		goto destroy_ft;
 
-	err = mlx5_generate_inner_ttc_table_rules(dev, params, ttc);
+	err = mlx5_generate_inner_ttc_table_rules(dev, params, ttc, use_l4_type);
 	if (err)
 		goto destroy_ft;
 
@@ -549,27 +685,47 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 	bool match_ipv_outer =
 		MLX5_CAP_FLOWTABLE_NIC_RX(dev,
 					  ft_field_support.outer_ip_version);
+	const struct mlx5_fs_ttc_groups *groups;
+	struct mlx5_flow_namespace *ns;
 	struct mlx5_ttc_table *ttc;
+	bool use_l4_type;
 	int err;
 
 	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
 	if (!ttc)
 		return ERR_PTR(-ENOMEM);
 
+	switch (params->ns_type) {
+	case MLX5_FLOW_NAMESPACE_PORT_SEL:
+		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
+			MLX5_CAP_PORT_SELECTION_FT_FIELD_SUPPORT_2(dev, outer_l4_type);
+		break;
+	case MLX5_FLOW_NAMESPACE_KERNEL:
+		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
+			MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(dev, outer_l4_type);
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	ns = mlx5_get_flow_namespace(dev, params->ns_type);
+	groups = use_l4_type ? &ttc_groups[TTC_GROUPS_USE_L4_TYPE] :
+			       &ttc_groups[TTC_GROUPS_DEFAULT];
+
 	WARN_ON_ONCE(params->ft_attr.max_fte);
-	params->ft_attr.max_fte = MLX5_TTC_TABLE_SIZE;
-	ttc->t = mlx5_create_flow_table(params->ns, &params->ft_attr);
+	params->ft_attr.max_fte = mlx5_fs_ttc_table_size(groups);
+	ttc->t = mlx5_create_flow_table(ns, &params->ft_attr);
 	if (IS_ERR(ttc->t)) {
 		err = PTR_ERR(ttc->t);
 		kvfree(ttc);
 		return ERR_PTR(err);
 	}
 
-	err = mlx5_create_ttc_table_groups(ttc, match_ipv_outer);
+	err = mlx5_create_ttc_table_groups(ttc, match_ipv_outer, groups);
 	if (err)
 		goto destroy_ft;
 
-	err = mlx5_generate_ttc_table_rules(dev, params, ttc);
+	err = mlx5_generate_ttc_table_rules(dev, params, ttc, use_l4_type);
 	if (err)
 		goto destroy_ft;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
index 85fef0cd1c07..92eea6bea310 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
@@ -40,7 +40,7 @@ struct mlx5_ttc_rule {
 struct mlx5_ttc_table;
 
 struct ttc_params {
-	struct mlx5_flow_namespace *ns;
+	enum mlx5_flow_namespace_type ns_type;
 	struct mlx5_flow_table_attr ft_attr;
 	struct mlx5_flow_destination dests[MLX5_NUM_TT];
 	DECLARE_BITMAP(ignore_dests, MLX5_NUM_TT);
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index da61be87a12e..d7bb31d9a446 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1336,6 +1336,9 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_ESW_FT_FIELD_SUPPORT_2(mdev, cap) \
 	MLX5_CAP_ESW_FLOWTABLE(mdev, ft_field_support_2_esw_fdb.cap)
 
+#define MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(mdev, cap) \
+		MLX5_CAP_FLOWTABLE(mdev, ft_field_support_2_nic_receive.cap)
+
 #define MLX5_CAP_ESW(mdev, cap) \
 	MLX5_GET(e_switch_cap, \
 		 mdev->caps.hca[MLX5_CAP_ESWITCH]->cur, cap)
@@ -1359,6 +1362,9 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_FLOWTABLE_PORT_SELECTION(mdev, cap) \
 	MLX5_CAP_PORT_SELECTION(mdev, flow_table_properties_port_selection.cap)
 
+#define MLX5_CAP_PORT_SELECTION_FT_FIELD_SUPPORT_2(mdev, cap) \
+	MLX5_CAP_PORT_SELECTION(mdev, ft_field_support_2_port_selection.cap)
+
 #define MLX5_CAP_ODP(mdev, cap)\
 	MLX5_GET(odp_cap, mdev->caps.hca[MLX5_CAP_ODP]->cur, cap)
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index c940b329a475..40f6fa138e27 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -416,7 +416,10 @@ struct mlx5_ifc_flow_table_fields_supported_bits {
 
 /* Table 2170 - Flow Table Fields Supported 2 Format */
 struct mlx5_ifc_flow_table_fields_supported_2_bits {
-	u8         reserved_at_0[0xe];
+	u8         reserved_at_0[0x2];
+	u8         inner_l4_type[0x1];
+	u8         outer_l4_type[0x1];
+	u8         reserved_at_4[0xa];
 	u8         bth_opcode[0x1];
 	u8         reserved_at_f[0x1];
 	u8         tunnel_header_0_1[0x1];
@@ -525,6 +528,12 @@ union mlx5_ifc_ipv6_layout_ipv4_layout_auto_bits {
 	u8         reserved_at_0[0x80];
 };
 
+enum {
+	MLX5_PACKET_L4_TYPE_NONE,
+	MLX5_PACKET_L4_TYPE_TCP,
+	MLX5_PACKET_L4_TYPE_UDP,
+};
+
 struct mlx5_ifc_fte_match_set_lyr_2_4_bits {
 	u8         smac_47_16[0x20];
 
@@ -550,7 +559,8 @@ struct mlx5_ifc_fte_match_set_lyr_2_4_bits {
 	u8         tcp_sport[0x10];
 	u8         tcp_dport[0x10];
 
-	u8         reserved_at_c0[0x10];
+	u8         l4_type[0x2];
+	u8         reserved_at_c2[0xe];
 	u8         ipv4_ihl[0x4];
 	u8         reserved_at_c4[0x4];
 
@@ -846,7 +856,11 @@ struct mlx5_ifc_flow_table_nic_cap_bits {
 
 	struct mlx5_ifc_flow_table_prop_layout_bits flow_table_properties_nic_transmit_sniffer;
 
-	u8         reserved_at_e00[0x700];
+	u8         reserved_at_e00[0x600];
+
+	struct mlx5_ifc_flow_table_fields_supported_2_bits ft_field_support_2_nic_receive;
+
+	u8         reserved_at_1480[0x80];
 
 	struct mlx5_ifc_flow_table_fields_supported_2_bits ft_field_support_2_nic_receive_rdma;
 
@@ -876,7 +890,9 @@ struct mlx5_ifc_port_selection_cap_bits {
 
 	struct mlx5_ifc_flow_table_prop_layout_bits flow_table_properties_port_selection;
 
-	u8         reserved_at_400[0x7c00];
+	struct mlx5_ifc_flow_table_fields_supported_2_bits ft_field_support_2_port_selection;
+
+	u8         reserved_at_480[0x7b80];
 };
 
 enum {
@@ -2004,7 +2020,13 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   reserved_at_3a0[0x10];
 	u8	   max_rqt_vhca_id[0x10];
 
-	u8	   reserved_at_3c0[0x440];
+	u8	   reserved_at_3c0[0x20];
+
+	u8	   reserved_at_3e0[0x10];
+	u8	   pcc_ifa2[0x1];
+	u8	   reserved_at_3f1[0xf];
+
+	u8	   reserved_at_400[0x400];
 };
 
 enum mlx5_ifc_flow_destination_type {
-- 
2.31.1


