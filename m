Return-Path: <netdev+bounces-143038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92E99C0F3B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A858B284D63
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5FE1822E5;
	Thu,  7 Nov 2024 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LBI3PxsS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4942178EA
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008745; cv=fail; b=T0uZWS19Cua9eoQVC7Dky4QQOVX6SaMeDxo2POKIbq4sOj/uCcMywdze0gRv9rfic+GwHXtoFSuhCaCNi443F+pljNYhE7WQyWQMiajGU/vQvfkt0yw89UUAT1QFE2mQNuzn5uZNL1Yr0K7Hc5KZvDwcLqRsIeiXsaNJZNc2G7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008745; c=relaxed/simple;
	bh=TvnoeQ72HxJUBzsscZBchBk6DiXMjKmBYP0lBjelASw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/ZAaxOsOK+HsTUNe9fIFwiW8m8FI8cPDy8NQKawKAoUaUYVXNk7g7hJA2RD8EcMfEFFw6wU1zh7LMKgQgLowTlVYlkd8w4N3y/xHWWers8/kAR72GUeBfFiPYUc4/R5l+WYZJm0GUPzaALHFiAxGq6rD0r96jGZsoyGPnQKDxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LBI3PxsS; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9FL2HZKvHrkfi0YNR9tJXVkxWqVz4YfxOg6p4HYoFH4MdQiQivB8G6aojAlBiNt9pggc9ScYuq6oxawxbt4/GG72YK2+dWMFf/cl0MrKKcTnwPB+OyydunFaJDltQRW55wbdf/i2lbyC0eA1ZpeJD4zmqM2z0TWmmKAt1CYdiCZqEGyjTVRrLGiR7aGfO9Jr2ZxMr+daWDydLRe6Kq9xI1nSewhxi7/iWnePgnpaJnucNWb36xX6tg7h2jsdDHrhXWeTbb3JAMXzQQX90FeNa/wug1lKtXqVEYM9+Zau15GQ0inLqm7osI4jES+s74qb1LV2HochXiurjPiUgGzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQgfSAdITIZHWR3tyvJrgHFAvAhlbcdkzy0S9Ew+0JA=;
 b=vAcx1okrP94rGNvtiz0fEKUf56HcVuyZk7pTZt1FISJkvXsH8cgZJLct4jcT4AOsL18+QFWR4z5DjHDpg7JOse9Y6tgdD9DPP+vtsuxG88tnbxERKFBw12L2+mgnO+/T+XqweS99JhBLFQ/OMA/lVRjTPvwWQbtHsQGeCtkcJRckYaweXDuaF055o+mNsCiRySnm+JRQlQM/UYCe59oRWoMOhiGOLpn0pCTeOKfEO1Le3GVBr5u7UtIonUUYqoMG+6+/vG8gOmZy5306ZWXe3w+XC0pFFMZREtzpH+3bMMHCE4H3/FD78zEs8MU8X7Kn3UFPdGztXnhl3LBG6btOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQgfSAdITIZHWR3tyvJrgHFAvAhlbcdkzy0S9Ew+0JA=;
 b=LBI3PxsSYAfx5ncPm3cyK6Ffw7YS5Lb9lpHeV8SEYsuo08YWnhN8j1nioNQDJQrhHB7bTLrGUuY8wLFzg7eI+/+fd3e/3Zil0bMNev3z/tar7tsNOqkAMWPTzMzwH1AKvB/G2txrsSypoO83TpbYJc907A6/F8UKuPXwSBdrnpv81quMF7GHHWNz6I5Y1T0b3H0mJxnp4qcrxNKDwwJ4sdV5H93LGd6Lw8hwJrXhwtdjZZd1Qly+/6zKrRZJfegN9y9vji+S0Cf8OsWdO6uSR0e6K2oByXtSKoRhCFu1BvZ6y7yWS2UgNISX2YMzyDQ8bmEKgXAGE2yDTkcIw/iBnw==
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:45:39 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:fc:cafe::2e) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Thu, 7 Nov 2024 19:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.0 via Frontend Transport; Thu, 7 Nov 2024 19:45:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:18 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:45:15 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 07/12] net/mlx5: Make vport QoS enablement more flexible for future extensions
Date: Thu, 7 Nov 2024 21:43:52 +0200
Message-ID: <20241107194357.683732-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107194357.683732-1-tariqt@nvidia.com>
References: <20241107194357.683732-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 1157a00f-aed3-4c96-0b79-08dcff64c1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pj+HNRcwakxGW3fQrlLZ266rDdNDyBXPLWcoh1J/CyNa8gRY+DsVD2RI7bO7?=
 =?us-ascii?Q?6M9hQJrfUgU3lMm9vn5CrxhB48ofKkiwzb6ArX7oVFXchGggA5bTqWZ16MX5?=
 =?us-ascii?Q?IrtTbePZuzj6qtCmpR5+u04kk5Vj061sdXBDIxWRuSfy9lMsld9lvJ9o5R+D?=
 =?us-ascii?Q?KL4CnmSfDl+kdxbMkMQWAAGFkfNif9h6aHnitmSBbymh2OjqcjxDRrXUY7JL?=
 =?us-ascii?Q?kGLb6OXHWunhtgMOCKpD+wGmNji88Xy/FxVyEIbJNZ7P9ICmz1noihomxOrc?=
 =?us-ascii?Q?V8DPGFg9qNvYsCYIlx2thp/WqvPUnRPJmAmS5p4nPyd57VXjyR6BenTvkIEm?=
 =?us-ascii?Q?lrilvCDy6V8N0eUCf4bzE/i+2Zoshx4aKrk/mGYn7qRWcijpZdDs5q00qH06?=
 =?us-ascii?Q?60G5lIOHvMzjN3RFzoxRgAdK8a5C2AEXCsy3HCmJmNICR2zb/jdzQwMNHMhU?=
 =?us-ascii?Q?dhJkEhuPoU0iifykNqhrlDAB/FZ2DDoniRqa+8uHQM+FVBY1J4r7QOovwu4X?=
 =?us-ascii?Q?NBBqRTQFMO565SEoC9Ow/NstrotOTtjcauLimYXoHLOnS9risR4LbZsUnigO?=
 =?us-ascii?Q?is7dfT0FqVCzjK8ufvzYZukagXTKLGGlc8r5bLEoRO6DNFX/+Dr/pnaVVgSh?=
 =?us-ascii?Q?BOD+P4O2RD7lFaEeXbkv5ECSSn/YgtC1HDTleKPLF23XO2CcNoROWhby9loI?=
 =?us-ascii?Q?EwJxPM82X6NS2HBCxQMH2/S4X+SnU1tlEN3qL9+p2jXFSwaIHr9eZWBnVCSx?=
 =?us-ascii?Q?nzHTG8jp4BCIjrbs38jRHjH/c/mmUjzcxR5hG8061CI6pmyDFrLx05MV4Vmc?=
 =?us-ascii?Q?7M+cDEssqb5fY/QP2k2e9jltMToorUgyIJZdnlEKzRH/OTT747bpfYFwrEb/?=
 =?us-ascii?Q?4ey1q5KIou8z0Hiavme9UtmfpqJkfzJWhbTNmCcQZsEkfSPKSIoOLb84t/Hm?=
 =?us-ascii?Q?glP74JGz2RFC1whX8c+c163jcpFsLMfjhUbCJRowIIRfqTxxLwkdcLyimAdw?=
 =?us-ascii?Q?DiGobDfCgX8sz2GBZglBX8y5wioUExilKiW5V8VAMyiSeAuJ1g4JYkdGMD8i?=
 =?us-ascii?Q?Ih6BsrmZDyaS3ExeTF834dLaz/S4kYY/Jp/v7qd11UtUC0qEAMie9zubnr2p?=
 =?us-ascii?Q?v2W2x6J80kQTOiarhD6tQhKUYHGHygkMaTv0OUcCN2C90MyR+NVyVYxhyaFn?=
 =?us-ascii?Q?Uxc2uWXyN95ruBeqNZFYTk7fZGan4/9O0kHc0AQuqswhkaIBy6e0HHPJarow?=
 =?us-ascii?Q?sO8SAXZjmRidBdf/777GQW05pfsOLSLrnyCT3Jp4YAbtNcMgXEgHiHrFXuzL?=
 =?us-ascii?Q?4AMTUIojoiR5m9cDKy8q5rIK7amAFYcU201snPAws9tkA07a1MOWiiumTYQP?=
 =?us-ascii?Q?yYI8nk7LuUYKbuylDQSDBXtD1O2jlRTp+nNHmG7z7QG6aFA/SA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:45:38.8746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1157a00f-aed3-4c96-0b79-08dcff64c1a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119

From: Carolina Jubran <cjubran@nvidia.com>

Refactor esw_qos_vport_enable to support more generic configurations,
allowing it to be reused for new vport node types in future patches.

This refactor includes a new way to change the vport parent node by
disabling the current setup and re-enabling it with the new parent.
This change sets the foundation for adapting configuration based on the
parent type in future patches.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 193 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   1 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   6 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   5 +-
 5 files changed, 96 insertions(+), 111 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index d0f38818363f..982fe3714683 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -195,7 +195,7 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 		return;
 	dl_port = vport->dl_port;
 
-	mlx5_esw_qos_vport_update_node(vport, NULL, NULL);
+	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
 
 	devl_port_unregister(&dl_port->dl_port);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 35e493924c09..8b7c843446e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -101,6 +101,12 @@ esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_
 	node->esw = parent->esw;
 }
 
+void mlx5_esw_qos_vport_qos_free(struct mlx5_vport *vport)
+{
+	kfree(vport->qos.sched_node);
+	memset(&vport->qos, 0, sizeof(vport->qos));
+}
+
 u32 mlx5_esw_qos_vport_get_sched_elem_ix(const struct mlx5_vport *vport)
 {
 	if (!vport->qos.sched_node)
@@ -326,7 +332,7 @@ static int esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_
 						  tsar_ix);
 }
 
-static int esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node, u32 bw_share,
+static int esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 					      struct netlink_ext_ack *extack)
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
@@ -344,69 +350,10 @@ static int esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_
 	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, vport_node->parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, vport_node->max_rate);
-	MLX5_SET(scheduling_context, sched_ctx, bw_share, bw_share);
 
 	return esw_qos_node_create_sched_element(vport_node, sched_ctx, extack);
 }
 
-static int esw_qos_update_node_scheduling_element(struct mlx5_vport *vport,
-						  struct mlx5_esw_sched_node *curr_node,
-						  struct mlx5_esw_sched_node *new_node,
-						  struct netlink_ext_ack *extack)
-{
-	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
-	int err;
-
-	err = esw_qos_node_destroy_sched_element(vport_node, extack);
-	if (err)
-		return err;
-
-	esw_qos_node_set_parent(vport_node, new_node);
-	err = esw_qos_vport_create_sched_element(vport_node, vport_node->bw_share, extack);
-	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch vport node set failed.");
-		goto err_sched;
-	}
-
-	return 0;
-
-err_sched:
-	esw_qos_node_set_parent(vport_node, curr_node);
-	if (esw_qos_vport_create_sched_element(vport_node, vport_node->bw_share, NULL))
-		esw_warn(curr_node->esw->dev, "E-Switch vport node restore failed (vport=%d)\n",
-			 vport->vport);
-
-	return err;
-}
-
-static int esw_qos_vport_update_node(struct mlx5_vport *vport,
-				     struct mlx5_esw_sched_node *node,
-				     struct netlink_ext_ack *extack)
-{
-	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-	struct mlx5_esw_sched_node *new_node, *curr_node;
-	int err;
-
-	esw_assert_qos_lock_held(esw);
-	curr_node = vport_node->parent;
-	new_node = node ?: esw->qos.node0;
-	if (curr_node == new_node)
-		return 0;
-
-	err = esw_qos_update_node_scheduling_element(vport, curr_node, new_node, extack);
-	if (err)
-		return err;
-
-	/* Recalculate bw share weights of old and new nodes */
-	if (vport_node->bw_share || new_node->bw_share) {
-		esw_qos_normalize_min_rate(curr_node->esw, curr_node, extack);
-		esw_qos_normalize_min_rate(new_node->esw, new_node, extack);
-	}
-
-	return 0;
-}
-
 static struct mlx5_esw_sched_node *
 __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
 		     struct mlx5_esw_sched_node *parent)
@@ -590,43 +537,62 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 		esw_qos_destroy(esw);
 }
 
+static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	struct mlx5_esw_sched_node *parent = vport_node->parent;
+
+	esw_qos_node_destroy_sched_element(vport_node, extack);
+
+	vport_node->bw_share = 0;
+	list_del_init(&vport_node->entry);
+	esw_qos_normalize_min_rate(parent->esw, parent, extack);
+
+	trace_mlx5_esw_vport_qos_destroy(vport_node->esw->dev, vport);
+}
+
 static int esw_qos_vport_enable(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
-				u32 max_rate, u32 bw_share, struct netlink_ext_ack *extack)
+				struct netlink_ext_ack *extack)
+{
+	int err;
+
+	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+
+	esw_qos_node_set_parent(vport->qos.sched_node, parent);
+	err = esw_qos_vport_create_sched_element(vport->qos.sched_node, extack);
+	if (err)
+		return err;
+
+	esw_qos_normalize_min_rate(parent->esw, parent, extack);
+
+	return 0;
+}
+
+static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_type type,
+				     struct mlx5_esw_sched_node *parent, u32 max_rate,
+				     u32 min_rate, struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_sched_node *sched_node;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
-
 	err = esw_qos_get(esw, extack);
 	if (err)
 		return err;
 
 	parent = parent ?: esw->qos.node0;
-	sched_node = __esw_qos_alloc_node(parent->esw, 0, SCHED_NODE_TYPE_VPORT, parent);
-	if (!sched_node) {
-		err = -ENOMEM;
-		goto err_alloc;
-	}
+	sched_node = __esw_qos_alloc_node(parent->esw, 0, type, parent);
+	if (!sched_node)
+		return -ENOMEM;
 
 	sched_node->max_rate = max_rate;
-	sched_node->min_rate = 0;
-	sched_node->bw_share = bw_share;
+	sched_node->min_rate = min_rate;
 	sched_node->vport = vport;
-	err = esw_qos_vport_create_sched_element(sched_node, 0, extack);
-	if (err)
-		goto err_vport_create;
-
-	trace_mlx5_esw_vport_qos_create(vport->dev, vport, bw_share, max_rate);
 	vport->qos.sched_node = sched_node;
-
-	return 0;
-
-err_vport_create:
-	__esw_qos_free_node(sched_node);
-err_alloc:
-	esw_qos_put(esw);
+	err = esw_qos_vport_enable(vport, parent, extack);
+	if (err)
+		esw_qos_put(esw);
 
 	return err;
 }
@@ -634,23 +600,18 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport, struct mlx5_esw_sched_
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-	struct mlx5_esw_sched_node *vport_node;
-	struct mlx5_core_dev *dev;
+	struct mlx5_esw_sched_node *parent;
 
 	lockdep_assert_held(&esw->state_lock);
 	esw_qos_lock(esw);
-	vport_node = vport->qos.sched_node;
-	if (!vport_node)
+	if (!vport->qos.sched_node)
 		goto unlock;
-	WARN(vport_node->parent != esw->qos.node0,
-	     "Disabling QoS on port before detaching it from node");
-
-	dev = vport_node->esw->dev;
-	trace_mlx5_esw_vport_qos_destroy(dev, vport);
 
-	esw_qos_destroy_node(vport_node, NULL);
-	memset(&vport->qos, 0, sizeof(vport->qos));
+	parent = vport->qos.sched_node->parent;
+	WARN(parent != esw->qos.node0, "Disabling QoS on port before detaching it from node");
 
+	esw_qos_vport_disable(vport, NULL);
+	mlx5_esw_qos_vport_qos_free(vport);
 	esw_qos_put(esw);
 unlock:
 	esw_qos_unlock(esw);
@@ -664,7 +625,8 @@ static int mlx5_esw_qos_set_vport_max_rate(struct mlx5_vport *vport, u32 max_rat
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
 
 	if (!vport_node)
-		return esw_qos_vport_enable(vport, NULL, max_rate, 0, extack);
+		return mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, NULL, max_rate, 0,
+						 extack);
 	else
 		return esw_qos_sched_elem_config(vport_node, max_rate, vport_node->bw_share,
 						 extack);
@@ -678,7 +640,8 @@ static int mlx5_esw_qos_set_vport_min_rate(struct mlx5_vport *vport, u32 min_rat
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
 
 	if (!vport_node)
-		return esw_qos_vport_enable(vport, NULL, 0, min_rate, extack);
+		return mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, NULL, 0, min_rate,
+						 extack);
 	else
 		return esw_qos_set_node_min_rate(vport_node, min_rate, extack);
 }
@@ -711,6 +674,31 @@ bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *m
 	return enabled;
 }
 
+static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
+				       struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+	struct mlx5_esw_sched_node *curr_parent;
+	int err;
+
+	esw_assert_qos_lock_held(esw);
+	curr_parent = vport->qos.sched_node->parent;
+	parent = parent ?: esw->qos.node0;
+	if (curr_parent == parent)
+		return 0;
+
+	esw_qos_vport_disable(vport, extack);
+
+	err = esw_qos_vport_enable(vport, parent, extack);
+	if (err) {
+		if (esw_qos_vport_enable(vport, curr_parent, NULL))
+			esw_warn(parent->esw->dev, "vport restore QoS failed (vport=%d)\n",
+				 vport->vport);
+	}
+
+	return err;
+}
+
 static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
 {
 	struct ethtool_link_ksettings lksettings;
@@ -972,23 +960,22 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
-int mlx5_esw_qos_vport_update_node(struct mlx5_vport *vport,
-				   struct mlx5_esw_sched_node *node,
-				   struct netlink_ext_ack *extack)
+int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
+				     struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err = 0;
 
-	if (node && node->esw != esw) {
+	if (parent && parent->esw != esw) {
 		NL_SET_ERR_MSG_MOD(extack, "Cross E-Switch scheduling is not supported");
 		return -EOPNOTSUPP;
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.sched_node && node)
-		err = esw_qos_vport_enable(vport, node, 0, 0, extack);
+	if (!vport->qos.sched_node && parent)
+		err = mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, parent, 0, 0, extack);
 	else if (vport->qos.sched_node)
-		err = esw_qos_vport_update_node(vport, node, extack);
+		err = esw_qos_vport_update_parent(vport, parent, extack);
 	esw_qos_unlock(esw);
 	return err;
 }
@@ -1002,8 +989,8 @@ int mlx5_esw_devlink_rate_parent_set(struct devlink_rate *devlink_rate,
 	struct mlx5_vport *vport = priv;
 
 	if (!parent)
-		return mlx5_esw_qos_vport_update_node(vport, NULL, extack);
+		return mlx5_esw_qos_vport_update_parent(vport, NULL, extack);
 
 	node = parent_priv;
-	return mlx5_esw_qos_vport_update_node(vport, node, extack);
+	return mlx5_esw_qos_vport_update_parent(vport, node, extack);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 61a6fdd5c267..6eb8f6a648c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -13,6 +13,7 @@ int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *evport, u32 max_rate, u32 min
 bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *min_rate);
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport);
 
+void mlx5_esw_qos_vport_qos_free(struct mlx5_vport *vport);
 u32 mlx5_esw_qos_vport_get_sched_elem_ix(const struct mlx5_vport *vport);
 struct mlx5_esw_sched_node *mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index d0dab8f4e1a3..7fb8a3381f84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1061,8 +1061,7 @@ static void mlx5_eswitch_clear_vf_vports_info(struct mlx5_eswitch *esw)
 	unsigned long i;
 
 	mlx5_esw_for_each_vf_vport(esw, i, vport, esw->esw_funcs.num_vfs) {
-		kfree(vport->qos.sched_node);
-		memset(&vport->qos, 0, sizeof(vport->qos));
+		mlx5_esw_qos_vport_qos_free(vport);
 		memset(&vport->info, 0, sizeof(vport->info));
 		vport->info.link_state = MLX5_VPORT_ADMIN_STATE_AUTO;
 	}
@@ -1074,8 +1073,7 @@ static void mlx5_eswitch_clear_ec_vf_vports_info(struct mlx5_eswitch *esw)
 	unsigned long i;
 
 	mlx5_esw_for_each_ec_vf_vport(esw, i, vport, esw->esw_funcs.num_ec_vfs) {
-		kfree(vport->qos.sched_node);
-		memset(&vport->qos, 0, sizeof(vport->qos));
+		mlx5_esw_qos_vport_qos_free(vport);
 		memset(&vport->info, 0, sizeof(vport->info));
 		vport->info.link_state = MLX5_VPORT_ADMIN_STATE_AUTO;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 14dd42d44e6f..a83d41121db6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -427,9 +427,8 @@ int mlx5_eswitch_set_vport_trust(struct mlx5_eswitch *esw,
 				 u16 vport_num, bool setting);
 int mlx5_eswitch_set_vport_rate(struct mlx5_eswitch *esw, u16 vport,
 				u32 max_rate, u32 min_rate);
-int mlx5_esw_qos_vport_update_node(struct mlx5_vport *vport,
-				   struct mlx5_esw_sched_node *node,
-				   struct netlink_ext_ack *extack);
+int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *node,
+				     struct netlink_ext_ack *extack);
 int mlx5_eswitch_set_vepa(struct mlx5_eswitch *esw, u8 setting);
 int mlx5_eswitch_get_vepa(struct mlx5_eswitch *esw, u8 *setting);
 int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
-- 
2.44.0


