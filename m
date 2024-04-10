Return-Path: <netdev+bounces-86745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5508A0251
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317901C2229C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72291836EF;
	Wed, 10 Apr 2024 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qEFIhGD7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFDA15EFAD
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785385; cv=fail; b=mjYmZ2bbzxshpzw1IdfcN95HxPU7JXz+JWQitfcRpLjxoRFtu62+VIEaijO3XOa6TfN6nYI/F7QTmq3tUvovHcJlSPSqaI/4eDraPLzrj2VM86RNamE32Nb/C7P0v3KUgP2A6umdTJmPea8RYAhL0E9qOU6xDM0BtA+upAvqmj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785385; c=relaxed/simple;
	bh=lDgSiFJUwjeClnDskOdb+7ozZB5d2VbiLV69WUlMxBY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jp51JlE4zHRzv4SNuPXvPaUvatrItZCeM3DMHiq2Cy3Fim+NzKp+flolwEE4WKs+hpW3hwtHOrutVNV6ub5XdN3UCT3l2TU7s6o/xrEijgoISfGiafRc8Ud6V+4RxD6WJ9s/VMTUa9cG+DP44fNbFPXlm7qJHdXS8WJki5EkaZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qEFIhGD7; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amG/x1+SL0HXPKEFfkGZv3lK9Wwt9p2tPbkKrm5pUpsZ7BO8TZqJlmAxcoTIf8n2bLdDL8iCU57qqmA01ye7isEaa/NVLqNYnGwjXaw97SYv28T27hFrBurOE5ke4XAKfLOafer7EQzq9dcyimx6ZqsjbwOj1rvsweN3O0DcTTy8QjkfEVTx1Gil1Ru5CzQu0LoSnDCZLGGDC39wo0Sa25O4z+iWrfzBVHlA8lSSHasdh3m4qwLyEQyC45nwtOQa1N+MNoK/RmV4yIpiZAURWzh2HXgaA+/NeWWc1cF9pq9dSgu3l9WBC4UL6tApTg55l/bqqTJ2b3bJuu61Ru28SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpWEyWs0OxWjHCOjI77KAQivSoeSQlRc/IT07PBfooI=;
 b=e9klB5ISH+f6P6E6SiUSQ/1iqAjUF2ym2PRkxwoSXENrWsVu37tXGKc+nnMzqIT/VMTloarVtBg6J/OOWGJSndqqdF2FtILARCExDy8fIHCChcAopSNaR2ycg/ybWz6ad0j1gAfdHNJ035sRIQ0iUyg8/b1ysvn1dcARd5L7Vz6STqdsQgCXiET25CGitowoNhdolJ5XQD4IBag851UA/1QsV5VOib5SAXnDnt9HHkhiHaWCJdiDHeq0EDh+TdJKi0eD+J4O3igsBOdB1w87gMlhP5ePtKFhCISV+k+Q524sLj3LAsqImXGNLR4A16ehTBlgQQzZo4Y/Mk8YhPBJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpWEyWs0OxWjHCOjI77KAQivSoeSQlRc/IT07PBfooI=;
 b=qEFIhGD7pVbG79M2L158SkCTy3HlPaUlYiof0yegycg6rPA/ldM5YoKhc8f8wBkiYtPvWclG0jp6EYYaWQr4ZUTjwR9ZJOjfLr2pXooRoFr6IjeDbsN9OBQFF9adiIjtNJjBjPoQXs9Z56DjuIyeuJq6E+btWwg8Oa74/v5eVlfEbvRfZlhaG+BRsfXk6FG5isN38QZNdzk2L5fRrPbdFHQIkb3g+d7HOMnn2bZOwap9nsJnm5bgPLYQ4JzLRFosnTYi8E9WUhBsKKUri1ypHtJODiIqBqX3ybn9a/QDnNXcchbz3okoS7Jagkv1RmsQHuWWzcdCzyJcZqanE7aPag==
Received: from SN7PR04CA0029.namprd04.prod.outlook.com (2603:10b6:806:f2::34)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 21:43:00 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::c2) by SN7PR04CA0029.outlook.office365.com
 (2603:10b6:806:f2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:43:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:42:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 10 Apr
 2024 14:42:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 10 Apr
 2024 14:42:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Wed, 10
 Apr 2024 14:42:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Aya Levin <ayal@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3] net/mlx5e: Expose the VF/SF RX drop counter on the representor
Date: Thu, 11 Apr 2024 00:41:54 +0300
Message-ID: <20240410214154.250583-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 463c2f11-d463-4c7c-3561-08dc59a73114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9il3ePI1qosofPR+H4wD+cHVEOM4QIOIfztnpqyYtO1qMx2gBiH4Awm12TQGZUHjnBPjvCcnRvs19NFGJysB9GOcn+JriQARoDwoRufF/6tBA6DLnHlySS975zC7VGtLubEOipMiqK4cC8qj29PWYkrJKD7g0p8Hn1BIDrHjslw8qeS01R8f+eKxu+u7YaEntyDqxYmpWYXkQOmU1a8huB3r04KMZZhIhuU2jCBZR3gmv9DWPTFMdj0NxIsJalm4XLMNN8YZ/Hsjrf1TXw1ZZ2a9CbGqBSqB0R8OAmnlp24NhGAKWSRYozEHv+qc7FeKrsxfi9xkUotIaY/SW9G3QbK6bcXkWCcoQDEP/nubFWCdcicb5q+xezHaBjyb8RqRyqK+izmniY5RLoQuSJXYjw5wybfi7HqkmuitgMOmi5T55ihZy92bkZlQfLW7qd+99QrHDhoLr9b+VjWgez6QgUQhhVSFacaKBS2kIpE6QBC27lwUd9e1vg6rHRQvAsSXpdJ+8pVx9791SVcUTYA+gLuLVsYA7vpTEryYhVXWMmrRKmOk4xCfR9grmnw5hLGfRPFd7eQl8bR5XAV3KyQctpRq190eaH3yIfwnMG7jDx+mjS0PNTOrn37kbBsjqm7bacwbIf5W/kDPoQ3QQNZ53zGv2acXWY7edycBzcyTEWZ30hC8zxWZzcZ3KnvfcpzvTgF9PQhuEkpGHf35jKqKpdp885dqUWq+o4NZfe6EKoMzHcsc0Bz1P3eZHjtmYg+x
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:42:59.6180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463c2f11-d463-4c7c-3561-08dc59a73114
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183

From: Carolina Jubran <cjubran@nvidia.com>

Q counters are device-level counters that track specific
events, among which are out_of_buffer events. These events
occur when packets are dropped due to a lack of receive
buffer in the RX queue.

Expose the total number of out_of_buffer events on the
VFs/SFs to their respective representor, using the
"ip stats group link" under the name of "rx_missed".

The "rx_missed" equals the sum of all
Q counters out_of_buffer values allocated on the VFs/SFs.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 42 ++++++++++++++++++-
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  2 +
 2 files changed, 43 insertions(+), 1 deletion(-)

V3:
Do not use vendor specific counter in ethtool, nor a generic counter.
Use a proper counter from the link group.

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index a74ee698671c..6acecf2e7cf6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -273,6 +273,40 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(vport_rep)
 	kvfree(out);
 }
 
+static int mlx5e_rep_query_aggr_q_counter(struct mlx5_core_dev *dev, int vport, void *out)
+{
+	u32 in[MLX5_ST_SZ_DW(query_q_counter_in)] = {};
+
+	MLX5_SET(query_q_counter_in, in, opcode, MLX5_CMD_OP_QUERY_Q_COUNTER);
+	MLX5_SET(query_q_counter_in, in, other_vport, 1);
+	MLX5_SET(query_q_counter_in, in, vport_number, vport);
+	MLX5_SET(query_q_counter_in, in, aggregate, 1);
+
+	return mlx5_cmd_exec_inout(dev, query_q_counter, in, out);
+}
+
+static void mlx5e_rep_update_vport_q_counter(struct mlx5e_priv *priv)
+{
+	struct mlx5e_rep_stats *rep_stats = &priv->stats.rep_stats;
+	u32 out[MLX5_ST_SZ_DW(query_q_counter_out)] = {};
+	struct mlx5e_rep_priv *rpriv = priv->ppriv;
+	struct mlx5_eswitch_rep *rep = rpriv->rep;
+	int err;
+
+	if (!MLX5_CAP_GEN(priv->mdev, q_counter_other_vport) ||
+	    !MLX5_CAP_GEN(priv->mdev, q_counter_aggregation))
+		return;
+
+	err = mlx5e_rep_query_aggr_q_counter(priv->mdev, rep->vport, out);
+	if (err) {
+		netdev_warn(priv->netdev, "failed reading stats on vport %d, error %d\n",
+			    rep->vport, err);
+		return;
+	}
+
+	rep_stats->rx_vport_out_of_buffer = MLX5_GET(query_q_counter_out, out, out_of_buffer);
+}
+
 static void mlx5e_rep_get_strings(struct net_device *dev,
 				  u32 stringset, u8 *data)
 {
@@ -1229,6 +1263,12 @@ static int mlx5e_update_rep_rx(struct mlx5e_priv *priv)
 	return 0;
 }
 
+static void mlx5e_rep_stats_update_ndo_stats(struct mlx5e_priv *priv)
+{
+	mlx5e_stats_update_ndo_stats(priv);
+	mlx5e_rep_update_vport_q_counter(priv);
+}
+
 static int mlx5e_rep_event_mpesw(struct mlx5e_priv *priv)
 {
 	struct mlx5e_rep_priv *rpriv = priv->ppriv;
@@ -1421,7 +1461,7 @@ static const struct mlx5e_profile mlx5e_rep_profile = {
 	.enable		        = mlx5e_rep_enable,
 	.disable	        = mlx5e_rep_disable,
 	.update_rx		= mlx5e_update_rep_rx,
-	.update_stats           = mlx5e_stats_update_ndo_stats,
+	.update_stats           = mlx5e_rep_stats_update_ndo_stats,
 	.rx_handlers            = &mlx5e_rx_handlers_rep,
 	.max_tc			= 1,
 	.stats_grps		= mlx5e_rep_stats_grps,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 9cee4c9472e9..650732288616 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -484,6 +484,7 @@ struct mlx5e_rep_stats {
 	u64 tx_vport_rdma_multicast_bytes;
 	u64 vport_loopback_packets;
 	u64 vport_loopback_bytes;
+	u64 rx_vport_out_of_buffer;
 };
 
 struct mlx5e_stats {
@@ -504,6 +505,7 @@ static inline void mlx5e_stats_copy_rep_stats(struct rtnl_link_stats64 *vf_vport
 	vf_vport->tx_packets = rep_stats->vport_tx_packets;
 	vf_vport->rx_bytes = rep_stats->vport_rx_bytes;
 	vf_vport->tx_bytes = rep_stats->vport_tx_bytes;
+	vf_vport->rx_missed_errors = rep_stats->rx_vport_out_of_buffer;
 }
 
 extern mlx5e_stats_grp_t mlx5e_nic_stats_grps[];
-- 
2.31.1


