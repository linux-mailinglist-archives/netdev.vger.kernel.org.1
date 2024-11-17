Return-Path: <netdev+bounces-145678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 617C89D05EF
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7204B21921
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 20:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC341DDA0F;
	Sun, 17 Nov 2024 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P/j54hpj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE21DD9A8
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731876727; cv=fail; b=pzK3rQ/WsLonoN42gha7Nmw2RV7AfTT8UctJi2T9SN/pWsLkPyvQTztY/I2vnUxgArgmNDJRerKiOvO6bKZpvIn88k6cbHV5DBIizHjamdYpw2+NV3XQLAqsmj4AM8BcZz10/SnVxXNY6pUfqyF9LTPP2FDh29GQm5c3WfmLhHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731876727; c=relaxed/simple;
	bh=p+f0Rc2cXt21kTHLqooaSn39K7o1wGJSQMQlC7VmNFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkN5abMcvxnqMIDPhlbIqf8uYsBh3rZ4EKowMU5YTbDXWzL94h7ITdmw+FTIp1HZEMZ6KyT0bhwfhzo0T/UhsBJ2nv+ipDyZUOI5DYhtCWHSlHL+fGa1JPdTUOCHHhP/P0GV2Snbr42UxjAQs/oaQBwedXQXamn3ES4uBMKcMQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P/j54hpj; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yf9YC8k2OctATcL+fE8PK4Lfx4o70RUzIgHjq5Ot9+skj8bBpGufQdXe/daUjgSgy4eEOdJZRPPGzWruuF3bq+4eyk/6uaH9BZ2/1NjFzH6c/EiOS8Rvt9lrTy+EHQkS/o+OJZLn3zSMVVoBuXmyHVdRnkn3fCHogUNQWAi+nxszpF/nP1hnqwhtQkDetmAa7B1MvRL+CVlJd4GoqXJfpRRnZ6yxJBRhgwXiVTkr7Uz45gsFgh+a7WdGmPhBKY7QDhjnImMeflI00XLDujgOLq03+9oek/+Q/mbNMIufA7YqbuzfItjwbY2fyrM6S/E9IfZzkT7CFeQj+FcBN4gfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7HaYmOaPnhb5t6S6+OAIrA4j5fQBco6gkGceNj+Ws4=;
 b=CvzLqBDMvoQrvbcQ+Ya0cbVj/2Xt6mnsWDqlNEm8L8OqNEx3gGg4IivqegNYIe62VnY4PeZVyWtoRKvVKy4m46eOGJxBuqQQAdnLW7J2rO8kG0dBjhS4bqzfsWM9Iq++FVZm41k8Hb7Ql3PiXigzURvJ6M367SmfKg4FQ+nKrPZDS1q7fEFG7RnY9S+K3J46INCxxJvHeRwCPLVlrvsmEW7xOtRe7hq7vBM6k3/qNTFLjbf9FPw0kBGw3W7JFTohZlQWzgDGvMBnovz/LW+oV6U6iCqdibilf6CQK24Cy4ztPNCFVQg990Pr3I3mlADc9IpQEMG4lCmKv/rzs1cKTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7HaYmOaPnhb5t6S6+OAIrA4j5fQBco6gkGceNj+Ws4=;
 b=P/j54hpjxOVxfjtLLvADWxKSEjQJvBql8JTmgirSAcwDZ87yftezenVtT1RnCUFdpbQ5Is8dzrFcVlCSq5awIAfoPNJ64CkD0nTETVCuTB3pVxjzjokcrhjHN+HvpeP7N+AqHuip9pf2j3IeJpFrwzdlEPY/LIDal1nFsSwhU2JyKlYDyOgVZr96Ak1oXJAEHHbuiK7ArBuRpzz2R8zRUHfAwknJ+vE+GVoEPKTXnHpHJSlIm6Q6OlaSU0V0mZo4f6PsRC18tEJ6WSvVgn2iBMvkIoVd/OWyNioxMjGUxBEhToaMGiPCcFJIpj5OlZjQd2TlHurByNKS9X8BmdPosA==
Received: from CH0PR04CA0077.namprd04.prod.outlook.com (2603:10b6:610:74::22)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Sun, 17 Nov
 2024 20:52:01 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::58) by CH0PR04CA0077.outlook.office365.com
 (2603:10b6:610:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Sun, 17 Nov 2024 20:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Sun, 17 Nov 2024 20:52:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 17 Nov
 2024 12:51:59 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 17 Nov 2024 12:51:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 17 Nov 2024 12:51:56 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 4/8] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
Date: Sun, 17 Nov 2024 22:50:41 +0200
Message-ID: <20241117205046.736499-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241117205046.736499-1-tariqt@nvidia.com>
References: <20241117205046.736499-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: 41967d7b-b650-4220-36e7-08dd0749af06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z4grtq95wbVOmlpV5Mj+xTkwCARwmuutiaoLyPgRHbRlGwkkPqvVVTN6faRI?=
 =?us-ascii?Q?1x5bjW7uiyKG3WCRRGV/51++39rhbhI/huwUTgJiiWNlz7r1jxDcpgf4XFzr?=
 =?us-ascii?Q?VYl+oacJ5z+YCJq1CVggCpHrSevp5KNtHCIPdWq9G3Yicg/o1r6rTXDJIcwi?=
 =?us-ascii?Q?D19WpD9J6Srh9dkSkBnrqo3Ysb6nFsMpfGC/WNGpOrV589VBFeItfCuGMCMk?=
 =?us-ascii?Q?cms2MuAD5Vt1DO0tikJ4u+fm04E3kC+lwp471rrzqSgZKYI3vlYvoUtZbS4K?=
 =?us-ascii?Q?9U8qMJXoAEKZrFyhioeUS5bmIT1Bn1+Jel5qF617vjO/cdHDqS1geLTkj+hl?=
 =?us-ascii?Q?MvSuB6M3I2sC+ZzcB+qxosWP7hIAqUBvF9u59mqun8oJTRXPEvpxB+0B5f9t?=
 =?us-ascii?Q?wh58z31Kpa2RwsJ+gAd4f/KVjKBVVAXOQafnxd5EV8xuinkQrwXxdIiX2jRD?=
 =?us-ascii?Q?3XGPwKKPUqdRjk1xznUUs5l4Iy5o9XyF94IcweEnmjkspk/Ito04q2ORZxJ8?=
 =?us-ascii?Q?bNYY6my530KdkI+SHyf+mgWlnYHLAzqMfqZ8ZaUJz018aTIOrEpGP9Fur0hg?=
 =?us-ascii?Q?7qy7wZ1EitzF9ZHQGF8Ado1nOpYvoVHhftZFyLKnwXM3lkl+u20h2aQqLMON?=
 =?us-ascii?Q?e3P1CNRs5HFqDiDLY7pRIs7oB84DI1cJiZTYZieP6FtC4Kr31ts5LL0Wl8z1?=
 =?us-ascii?Q?YMROMDaI9sRanU4+vsCTmw0ZlAZMXXIinQk1DtFCvmSZxmm07u0ctatt/eiE?=
 =?us-ascii?Q?pjkLVNvCZ9d7O5aXK1fW4Cv7TncpySfB1HURPsgJsfAUnqFSgB2pNoZFUmx/?=
 =?us-ascii?Q?TMIoU8CFnoz7m05A9waM9ZfxKWCngEMvYWQGtW4gT5g36xjoJWR/pTFnOyjh?=
 =?us-ascii?Q?EFmztDHJOqyHu4p534JenRqSYRi35Lpd6yh7EFgazqpI7t1OnOxRRmmEcKyi?=
 =?us-ascii?Q?0wtk11cvBS/hmyTDqHuf2zhgnqN0r9+vVpapCcucAkbdSmkruxtDgYdW554w?=
 =?us-ascii?Q?h1r+tu4XknqhPnp0c8LVZInQE8S1BwtZq7ljbVUYxin0n070b0ICg+v6LpYx?=
 =?us-ascii?Q?GRbfgCnablznqdUI2gjaQdhjHVsbv/Z8icbVcveKVq/Xub3dtE1fdW17zBxs?=
 =?us-ascii?Q?wwBKxVWUwcdiRM2c79ySG1wZOSm1Rf/UiN2wmlL1j0s2Z1IsFQwyBF4/OYIO?=
 =?us-ascii?Q?ZT7DWO+uLiq7gjzXcICdpD63XNBhzGuCR5xV/KW2mjCdhQS0abJJbzZNIYZU?=
 =?us-ascii?Q?Scz58GKJugeC33MI4PNGH1HDVBh0ZgQVmkGYi0iUHbpGH6CzblNOYBIcnaqc?=
 =?us-ascii?Q?iCMGHuhzyIbDR0oF4/llgvzGcure55IOLusReKG3/J3CzXnCSI90SqKy9JTG?=
 =?us-ascii?Q?x9+FTJ/9oind/dNA2AEqhr6ERabaG7LgDLI728LdJLXBUAgicg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 20:52:00.5186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41967d7b-b650-4220-36e7-08dd0749af06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463

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


