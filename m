Return-Path: <netdev+bounces-145082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8D89C9511
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C000281294
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B6F1B0F05;
	Thu, 14 Nov 2024 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qn1zWI9G"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D41B0F2C
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622268; cv=fail; b=q8BYbpgVJzh0MkAjgspImB6lsktF0uuBz0lip6DdyitectD7C3zr2wx97KSqiCI5+eR5h2zqwVeGSmB7E2BTJQg6VpGQKzAI8UiKzG58v8MMd6XYl0XF3tVtqDVIo2zBqWLRXMOsty3C1A4z5UriAeuv3n9wbvvZRvtY3VT8xso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622268; c=relaxed/simple;
	bh=p+f0Rc2cXt21kTHLqooaSn39K7o1wGJSQMQlC7VmNFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWlb3P0guJiq/9Wvt9by1T3xG2KD2vFykqQNbEtg1WpMMmW4UwJJV3D05BYQcsl3sOLe5G6jM2URniV2mawk+yEXNuRlpR+cemcAPfbWoJEa2Ok4pQtCnpflpUofT0hLnmpN+FN3odNFwECJTe6YOXEYP/ruo4DtoGhDLqnU/zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qn1zWI9G; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCwD5sb6X9iCmHVGLwRd//QoRDrpQI6iDiat40BVriDgqQr6ZKEkEHBQOgb/kSH4IgFn1zFOFllBUicZxGufOOGra9DwpRG3lbYbM5xzm0IoUhVnEzyRH64rO1BBJE01SbiYV4OPuR0/5XjToS2/zBoWo5cYOmRSquWaFPXDSH5bGFQfzaTGRnCstzK4NwB1qpp8+AcdE62aCtvCLoS+woh6aOxIsBWzYOxEBBGVrcRVSgqRFUXCyrL8Zh/2gqD4gJNBWdDPD1XOypmuOJrScZZeMpvi8XiCtumGNMwBO1k1j7TEPxQfPl+7izyNgEGI7yD9acFed4/y7bEeKYqtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7HaYmOaPnhb5t6S6+OAIrA4j5fQBco6gkGceNj+Ws4=;
 b=LEsKkVSIXlRJlKSLNjTeY989GynvLnayQet1OGG9tabIciXS0MHk/j8RzyzcgyhBARKBDvd/Ce7U8i18iGfBcti4hpmI7fv4BvEyJEWIJJEumB26IurPFkuZABbtE4JQFjZ8qe4VFGL++D+Ci/rJsnuym7vxXitTr2jhlSpaZiSQDI2/2OwYSvYnuDlMxCbD9gqeY6lopxx0xUPBlghEtjJbuIV1+GFwYkWRdlX/j0RUl5Q/uGGaIU7hM5rcdjb3oihOPesH6/GE0RFlOLMEdJo9K+cRdLUP1apDfi3wcPwCfIsSt6Ao3NWhZgHVkAixCw5yhdwNW98MESicmY6Qog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7HaYmOaPnhb5t6S6+OAIrA4j5fQBco6gkGceNj+Ws4=;
 b=Qn1zWI9G45dblVLl8dlLjrfCQ1bVj3Zg3YdjE9WYLyx1UGCAvR9r6N/ASLdf7BSKImPqWOlNH5eacStBPibmJTPSdM8Gib+VK2Kc4Xv8Fn9Jgv0YU1Z4S685CwdUn6SfTEcJLwV2nwHuL7AMXs6hixULwB4HckQv0FJKSDUrRgGyDqRvwQmBoW/FvbVNkwTIQKnV1Wf4c3rO3y7kFCFXCrMg9viYOlsF0+9sVnUOXywz+pB46yLNtxTA2rajr8otJueAvPplzUAhBZFQDZF4SuS8Ewl9CEbcNSbhautdk2XknnRnrKfy3kHJOSm9EyPvHx/f7KXwIdlaTsHokfGREw==
Received: from PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::29)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:11:03 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::5a) by PH0P220CA0024.outlook.office365.com
 (2603:10b6:510:d3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 22:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 22:11:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 14:10:48 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 14:10:47 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 14 Nov
 2024 14:10:44 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 4/8] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
Date: Fri, 15 Nov 2024 00:09:33 +0200
Message-ID: <20241114220937.719507-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114220937.719507-1-tariqt@nvidia.com>
References: <20241114220937.719507-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a1f85a-b0ef-49c4-39f9-08dd04f93a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?csiAcWwf8H5ktlrnefhQXXykYs04S5scFXOOR/jACCkCTudzEDgGnsjIInkB?=
 =?us-ascii?Q?o4R0zeNlQ/NpYniNjq0a//gjH07+6g00tsFnVSdL2jNKj43Jc+1Lo+TxIske?=
 =?us-ascii?Q?6TrzxrXyblsBUnDK4du/ZleC1rJhd9odmVB8M9jRB7CUJ+/EhYzwAWksRs+I?=
 =?us-ascii?Q?s1thcd/teEJOsi9gPaikHFkb91LF+9HgaOvNfmQXuqypRP7lMD+catQH43sH?=
 =?us-ascii?Q?V8HCtI054kiub1Xt4Xvk032UCiiSvvGWlIbGuaoqJazzoGYA+FPPDSrupTIn?=
 =?us-ascii?Q?4ivDJI/WkEdjCzC4KDFsaw4clh6PnIPRbvE3wGgJ2vg6BlRvZo+vNYaXKoyI?=
 =?us-ascii?Q?AKR5mmtHpn/XAlvDvdQsEffc09q1e6Bq9syCkIG5PYv/5908UEX7M5G15wJS?=
 =?us-ascii?Q?ZfeSQIcpzNIU/xrt6SnnedmSilDX8v5UaiA9/lm1AetcL3C/OynljAI/aEf1?=
 =?us-ascii?Q?vl4VPblJ3QtvXEVM22Oxo+WDcQsmZCl0qIvimXl7ZVePlCDU8RP68+zSq50B?=
 =?us-ascii?Q?ginwrL7DMTb0Mkxtpv88Fc9bPQA0b5qnS6wNX/KEGH00arSLUvthTcFpjlq3?=
 =?us-ascii?Q?VbyJUDRXKGDTSsp7HB3amsqioVhuv5xnnm7wWkxE8XleIGC8+6zEBeWmn+7z?=
 =?us-ascii?Q?8duDcz0Z5r6BNZ9ZPzZ1T6LvhddFtonqOxfCaZrhBEVChvy+DQMy9uPxerUX?=
 =?us-ascii?Q?cxHxsRSCZrH2yZAnQvgqArYBKZ7Dp/Z6uxCkwX+2/jnZRg/JHULMVlXx3ov1?=
 =?us-ascii?Q?AwjQhOPAIoRDvJcajg0nUQedMS1N0DIBEXbiyGr6Od5YcYpSjSIQiehoWAnw?=
 =?us-ascii?Q?r05AQMP3IQkK5P6srVI0N+tcdgQNdIZ5/WyqNqxKUAkvC3eN15CRSSQ4Rga6?=
 =?us-ascii?Q?dT/1FXgmPTn4gHyZs7/jTe85QIIqx93IDLXpjBsk03z7ZfXcSp/rrW89dzH0?=
 =?us-ascii?Q?C49WZP+Jg1lg2FAZ3dukIhPezN+cANVaTVOvKqPLsUUDlxwpr5waZVB9nbsu?=
 =?us-ascii?Q?SknvlLRFoU/3M6be9RMg1NmZtF2NUX5l78c7bkoc+KJ8Nhos3G80DFvAfpZr?=
 =?us-ascii?Q?q0T1NPirljQenSBhpPfa1afJ5TWNvF0wLnTwx/1xTkwj419dSxmBf6faNjOR?=
 =?us-ascii?Q?JK15iQNHAansDWKq5Ns7vKNvaIe+b44fEXE/sVZlxL3x+Bc6pIbRpTWq8Ml8?=
 =?us-ascii?Q?xK0hZFzWMiVGRM1pFiBcRCFEv+3BMK9Vu9vi9uGteuShJaHF5YV6798IqLYF?=
 =?us-ascii?Q?I5cgafbp8npKDtU/Uo327coB/ZOXNOCXjFZ9atWaGt0dTXcsL+y1uFAOTGMv?=
 =?us-ascii?Q?lvAL8z9i2tkqk7OcUidTEdyLiJVv44pqbuckOPkHnBXyddzAIC/uC5NFGT8Z?=
 =?us-ascii?Q?0Ki3zLoJRmWDqpYV02E0a2cUGdjeUJd6eO23A+Y8iRpRFiX9rQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:11:02.8701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a1f85a-b0ef-49c4-39f9-08dd04f93a6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `mlx5_esw_devlink_rate_node_tc_bw_set()` and
`mlx5_esw_devlink_rate_leaf_tc_bw_set()` with no-op logic.

Future patches will add support for setting traffic class bandwidth
on rate objects.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 98d4306929f3..728d5c06d612 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -320,6 +320,8 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.eswitch_encap_mode_get = mlx5_devlink_eswitch_encap_mode_get,
 	.rate_leaf_tx_share_set = mlx5_esw_devlink_rate_leaf_tx_share_set,
 	.rate_leaf_tx_max_set = mlx5_esw_devlink_rate_leaf_tx_max_set,
+	.rate_leaf_tc_bw_set = mlx5_esw_devlink_rate_leaf_tc_bw_set,
+	.rate_node_tc_bw_set = mlx5_esw_devlink_rate_node_tc_bw_set,
 	.rate_node_tx_share_set = mlx5_esw_devlink_rate_node_tx_share_set,
 	.rate_node_tx_max_set = mlx5_esw_devlink_rate_node_tx_max_set,
 	.rate_node_new = mlx5_esw_devlink_rate_node_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8b7c843446e1..db112a87b7ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -882,6 +882,20 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 	return err;
 }
 
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on leafs");
+	return -EOPNOTSUPP;
+}
+
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on nodes");
+	return -EOPNOTSUPP;
+}
+
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 6eb8f6a648c8..0239f10f95e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -21,6 +21,10 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *priv,
 					  u64 tx_max, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
-- 
2.44.0


