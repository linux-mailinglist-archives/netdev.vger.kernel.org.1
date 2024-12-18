Return-Path: <netdev+bounces-153027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF21A9F69A4
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33C4163FE0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31B81E008E;
	Wed, 18 Dec 2024 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JJd5gCoF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ED31F1900
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534679; cv=fail; b=JZHZA1f1y2hLo+b91zQIzTioD9Z2FT41r6Xa3ava32zQoFQZHkG33y8o7Ln+xPTp9zNMm8O5qjRGBRjorybhhzH6gd2oEBbxrgc5aunPwWVZvIv4DjHeqRYWgFCvCk8QMyyHUTYiJJoCmWTkRL3bWlaIKsquvYhQ7BqLlRLLUPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534679; c=relaxed/simple;
	bh=7DIBeovakt0xrazzaQFOyuSplpMhV98uwdlDnbO9M8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWGAe5zhexxNU5XFXkQxG6bVFl/ahQDq70vob4YqP5ysd95Bv3P4WMYalLnsqBHVi17ngw6FmJ2kC95QPqEPlADEMFJyrwsHwKOgMimAqvIgcds0gpHSPUOofXu0L1i4XBor4whUzml/hZwSCUYUuqzgPqIjYFNrY97nwZD827o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JJd5gCoF; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfUVuliwbRYy0Sy0xqlhKDholbwrkRBNLNOhJXUjHbUsGBZbXT2tLWxeI2JB8zBA3dJoOeDuiFv5JPZn4qf84tB0UYT+kNaRxGAT3m77mK6QakKU0mwSnzCGpS1FkxYkxft1LcskpliX2WfWaQJa3jbSuS2ScfnMuHmjfj4WRa4LQdFLw74fu+nYfVb5JQioUErXToyfFz3Q9qh6y2oednIhXpJt+b+VDKEg/VvOnMiEplaFqCV8sRLnl0XeeWkgiKXeCMNj4+NTZGe3NN86M4zE77e25fycCWYZtdVa3wiUvKs6XDJoYhxfFlLkxSQ5B9dtxXHklkfCja3pTt/gJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ugmp5KIbjSX37fxGRX5ch2JpuVuS8ec+HBuP4rMx4Cg=;
 b=umggVKbWXo0CippQomtc0xacSoc5BIkDwXvl4T/ZG9B4gwQ2iTM2M7O9mP0Gvi1nCntbacVxj0CrYPX48etbRUNqRmhEwD+LSA+sJ78BFl4OJAES/sKhy9MyIw4V3WscjjaJUOjKulvni5b1+bTkudqnLly29LYvFbX+NIw36U/B0ClrQwc0tuTe4kcqWPkyb77/N7AD2FONjqrrGVw+PC9m8Nj5dGTpxq/ysNED2gY/AcaLgNu8kEcjHBY6NPsC+fSwpbVusDYvpG95st0NQGaDitddNkFTfPdII21I5BchcYAbdnzA/OgbRLoULa55dXMgu2wyV5MI2COYDt7qRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugmp5KIbjSX37fxGRX5ch2JpuVuS8ec+HBuP4rMx4Cg=;
 b=JJd5gCoFnzLD0q+yC7+opoPbNNqvrOkfAf4gTiDlIntzXjcBao1p4z+BNNsmyuZCOnaj40ErEelrSFXoZlqhDp01mQTL2Lnns4cN/Zo3aV2YTJXG3zL//FKnhIiajZb4BBMq8iiDYY9X+8gFx506VY8eebn+3Fz13CLu2dLx5rWmPYT6Aniar4X6MAm8b07nMaDKueT9Jl1hkfv2RnYyAsVa1zrxGyarnLXx/wkXZhWOCOO8JIGI41JyO7EsP4AfKIITXsgU+beCrDJCIcQo5+uBoYZztMcaUkx+BRg7tdRJ0ix0uMjo36E2iKVki8f17WbLFaeY4BgY4yYATpLzCA==
Received: from BN9PR03CA0116.namprd03.prod.outlook.com (2603:10b6:408:fd::31)
 by IA1PR12MB8586.namprd12.prod.outlook.com (2603:10b6:208:44e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:11:08 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:fd:cafe::c5) by BN9PR03CA0116.outlook.office365.com
 (2603:10b6:408:fd::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Wed,
 18 Dec 2024 15:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:11:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:10:50 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:10:49 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 18 Dec
 2024 07:10:46 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 03/11] net/mlx5: fs, add counter object to flow destination
Date: Wed, 18 Dec 2024 17:09:41 +0200
Message-ID: <20241218150949.1037752-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241218150949.1037752-1-tariqt@nvidia.com>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|IA1PR12MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b87b3d-aba1-40d6-ff06-08dd1f763331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dw7c1c0EVzTJLkgh1kfN158+q9SEl9RjjZ4ZVrg2mB2RVOme85oD/gfilfkd?=
 =?us-ascii?Q?7eoIR/eF2rr931c69ng3E6Sb1DPoD1JNXYG5RefsjmytlWqZoAbbfu39KKPa?=
 =?us-ascii?Q?UbqGpAg5/nXd/+6W1PzTUeuyEgTLRqxCsM0EwxqR7a5ub/csp823z1EumL+R?=
 =?us-ascii?Q?MSEp+qm8msXRPwcy8w3vQ9sRCVuNkUnZESaUsPuJgn2QmyFOTJX3fjVLUnS/?=
 =?us-ascii?Q?YDP71oKFW1nrlEsnPGJG+n63Dt/ehjzMZL8WPFgNrjj1DoU7REmObeTtwXBT?=
 =?us-ascii?Q?iAHew6b+sIJIet4ygwL1rJDoBOsq9gRUWfD8EZ537zeZ9fGv0U9csKN4I25W?=
 =?us-ascii?Q?c3rUrovo+nLvEvFjYYzV+I4KIBtwxfhSDkAxXZuvcbsl4f2VRlQFZ/Xb0pqc?=
 =?us-ascii?Q?aQkBEoKpuBhsRjBiZjRebSk6x0jUkC2+JQeWFK3tB9A1MiO5cEVZ14wlIUwW?=
 =?us-ascii?Q?fiih7x/A2eTM3uZR6vbf77P04WGhxjf+EJwEx6NHgPen5r3ltOUSLwLeX4C+?=
 =?us-ascii?Q?T1e3ziB9QdL3YZO3v6okBn4hvqXrxqu+CHzNwzup1ukY0yOiZNSnasxlRD0B?=
 =?us-ascii?Q?PZMVup5pCtzZyMNhQWVeyiPtdrSlhWt2bb50Yt1+9TSLaTIBG626D1xpsCdI?=
 =?us-ascii?Q?OEpvfurt0/mGeHA+R/vbZhY9bOOy8d0Jm5I3IWDix0IqIscJHnFBew1teRgc?=
 =?us-ascii?Q?KEkP1kDODTyHrJuXQh6uBzX+zuInoz6iXyrRLB74DL8VlEJIZiIaeJ+kCR9R?=
 =?us-ascii?Q?qIeJsmGcpR8N22Ta55ikU4wmmMufMx3HisDcFZaTLl+a7U4UTMu0BTV/l24F?=
 =?us-ascii?Q?0dqd4DoEzXX+SyfxZRxwXvWcgIiZjd/9P1wESHWW0NrKGHLqlDbjFh4m2wgY?=
 =?us-ascii?Q?pTQnhE5mfvBgGLZ31t+pWrre7Cm0DPWjkb21XU881/pK1Yta8PKW7btqyYOi?=
 =?us-ascii?Q?6vHKFwnVxqYJxfgi5aqT5yv1QY0iDLXZKIzPZUXYwK+7YDWhOpIBM+TXBlIO?=
 =?us-ascii?Q?oufPOtIoQxDbQiR0C98fZIuhIIOFUbI2AHWLkHowiEGNNTesx6qUwsrmZ1EU?=
 =?us-ascii?Q?TJYj6Qbc3e7SVcpMqPoVTWI63a29ChQVy0G/r+l4Y1ou3GB3C2HWTbemvdSr?=
 =?us-ascii?Q?jE4UX9uli6StzRSqPuurCf6IiJY5qRp/1919wR712ipdbdr3bU5/g6HHorVz?=
 =?us-ascii?Q?/+P5DmdcHWeizz5Xit9LJCe2Z7VI1ky39KaOU/BQMqW2PTfnakHSS8mZGnKV?=
 =?us-ascii?Q?l3bOauwJ++bzDNR/LkygrA7xdHjrgESt718GV1q8lFXpXkxpuw4pNjHSTjED?=
 =?us-ascii?Q?+5xbKFkx+LwlS3oo4LE2Cj7M8SpLTosjt5k5ORAf3YVKWNcjkVfHLu4fJid1?=
 =?us-ascii?Q?69wDQcucSL//rbtrui9/EHZ5b263oBov5tGDE6INZVImLUnohw5cLYCf7WDx?=
 =?us-ascii?Q?wciIE7GRvDtmjPtlo0Tr52uhO9b9Rqnmqpjo8PQud/U7dBUGfChoQUDKNBrs?=
 =?us-ascii?Q?BL0fcOZpM8EF71E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:11:07.9807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b87b3d-aba1-40d6-ff06-08dd1f763331
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8586

From: Moshe Shemesh <moshe@nvidia.com>

Currently mlx5_flow_destination includes counter_id which is assigned in
case we use flow counter on the flow steering rule. However, counter_id
is not enough data in case of using HW Steering. Thus, have mlx5_fc
object as part of mlx5_flow_destination instead of counter_id and assign
it where needed.

In case counter_id is received from user space, create a local counter
object to represent it.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c               | 37 +++++++++----
 .../mellanox/mlx5/core/diag/fs_tracepoint.h   |  2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 20 +++----
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  2 +-
 .../mellanox/mlx5/core/esw/acl/egress_lgcy.c  |  2 +-
 .../mellanox/mlx5/core/esw/acl/ingress_lgcy.c |  2 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  | 20 +++----
 .../mellanox/mlx5/core/eswitch_offloads.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  1 +
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 52 +++++++++++++++++++
 .../mellanox/mlx5/core/lib/macsec_fs.c        |  8 +--
 .../mellanox/mlx5/core/steering/sws/fs_dr.c   |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c             |  4 +-
 include/linux/mlx5/fs.h                       |  4 +-
 15 files changed, 116 insertions(+), 44 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 520034acf73a..162814ae8cb4 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -943,7 +943,7 @@ int mlx5_ib_fs_add_op_fc(struct mlx5_ib_dev *dev, u32 port_num,
 	}
 
 	dst.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dst.counter_id = mlx5_fc_id(opfc->fc);
+	dst.counter = opfc->fc;
 
 	flow_act.action =
 		MLX5_FLOW_CONTEXT_ACTION_COUNT | MLX5_FLOW_CONTEXT_ACTION_ALLOW;
@@ -1113,8 +1113,8 @@ static struct mlx5_ib_flow_handler *_create_flow_rule(struct mlx5_ib_dev *dev,
 		handler->ibcounters = flow_act.counters;
 		dest_arr[dest_num].type =
 			MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-		dest_arr[dest_num].counter_id =
-			mlx5_fc_id(mcounters->hw_cntrs_hndl);
+		dest_arr[dest_num].counter =
+			mcounters->hw_cntrs_hndl;
 		dest_num++;
 	}
 
@@ -1603,7 +1603,7 @@ static bool raw_fs_is_multicast(struct mlx5_ib_flow_matcher *fs_matcher,
 static struct mlx5_ib_flow_handler *raw_fs_rule_add(
 	struct mlx5_ib_dev *dev, struct mlx5_ib_flow_matcher *fs_matcher,
 	struct mlx5_flow_context *flow_context, struct mlx5_flow_act *flow_act,
-	u32 counter_id, void *cmd_in, int inlen, int dest_id, int dest_type)
+	struct mlx5_fc *counter, void *cmd_in, int inlen, int dest_id, int dest_type)
 {
 	struct mlx5_flow_destination *dst;
 	struct mlx5_ib_flow_prio *ft_prio;
@@ -1652,8 +1652,12 @@ static struct mlx5_ib_flow_handler *raw_fs_rule_add(
 	}
 
 	if (flow_act->action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
+		if (WARN_ON(!counter)) {
+			err = -EINVAL;
+			goto unlock;
+		}
 		dst[dst_num].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-		dst[dst_num].counter_id = counter_id;
+		dst[dst_num].counter = counter;
 		dst_num++;
 	}
 
@@ -1878,7 +1882,8 @@ static int get_dests(struct uverbs_attr_bundle *attrs,
 	return 0;
 }
 
-static bool is_flow_counter(void *obj, u32 offset, u32 *counter_id)
+static bool
+is_flow_counter(void *obj, u32 offset, u32 *counter_id, u32 *fc_bulk_size)
 {
 	struct devx_obj *devx_obj = obj;
 	u16 opcode = MLX5_GET(general_obj_in_cmd_hdr, devx_obj->dinbox, opcode);
@@ -1888,6 +1893,7 @@ static bool is_flow_counter(void *obj, u32 offset, u32 *counter_id)
 		if (offset && offset >= devx_obj->flow_counter_bulk_size)
 			return false;
 
+		*fc_bulk_size = devx_obj->flow_counter_bulk_size;
 		*counter_id = MLX5_GET(dealloc_flow_counter_in,
 				       devx_obj->dinbox,
 				       flow_counter_id);
@@ -1904,13 +1910,13 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 {
 	struct mlx5_flow_context flow_context = {.flow_tag =
 		MLX5_FS_DEFAULT_FLOW_TAG};
-	u32 *offset_attr, offset = 0, counter_id = 0;
 	int dest_id, dest_type = -1, inlen, len, ret, i;
 	struct mlx5_ib_flow_handler *flow_handler;
 	struct mlx5_ib_flow_matcher *fs_matcher;
 	struct ib_uobject **arr_flow_actions;
 	struct ib_uflow_resources *uflow_res;
 	struct mlx5_flow_act flow_act = {};
+	struct mlx5_fc *counter = NULL;
 	struct ib_qp *qp = NULL;
 	void *devx_obj, *cmd_in;
 	struct ib_uobject *uobj;
@@ -1937,6 +1943,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	len = uverbs_attr_get_uobjs_arr(attrs,
 		MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX, &arr_flow_actions);
 	if (len) {
+		u32 *offset_attr, fc_bulk_size, offset = 0, counter_id = 0;
 		devx_obj = arr_flow_actions[0]->object;
 
 		if (uverbs_attr_is_valid(attrs,
@@ -1956,8 +1963,11 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 			offset = *offset_attr;
 		}
 
-		if (!is_flow_counter(devx_obj, offset, &counter_id))
+		if (!is_flow_counter(devx_obj, offset, &counter_id, &fc_bulk_size))
 			return -EINVAL;
+		counter = mlx5_fc_local_create(counter_id, offset, fc_bulk_size);
+		if (IS_ERR(counter))
+			return PTR_ERR(counter);
 
 		flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	}
@@ -1968,8 +1978,10 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 				    MLX5_IB_ATTR_CREATE_FLOW_MATCH_VALUE);
 
 	uflow_res = flow_resources_alloc(MLX5_IB_CREATE_FLOW_MAX_FLOW_ACTIONS);
-	if (!uflow_res)
-		return -ENOMEM;
+	if (!uflow_res) {
+		ret = -ENOMEM;
+		goto destroy_counter;
+	}
 
 	len = uverbs_attr_get_uobjs_arr(attrs,
 		MLX5_IB_ATTR_CREATE_FLOW_ARR_FLOW_ACTIONS, &arr_flow_actions);
@@ -1996,7 +2008,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 
 	flow_handler =
 		raw_fs_rule_add(dev, fs_matcher, &flow_context, &flow_act,
-				counter_id, cmd_in, inlen, dest_id, dest_type);
+				counter, cmd_in, inlen, dest_id, dest_type);
 	if (IS_ERR(flow_handler)) {
 		ret = PTR_ERR(flow_handler);
 		goto err_out;
@@ -2007,6 +2019,9 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	return 0;
 err_out:
 	ib_uverbs_flow_resources_free(uflow_res);
+destroy_counter:
+	if (counter)
+		mlx5_fc_local_destroy(counter);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h b/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h
index 9aed29fa4900..d6e736c1fb24 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h
@@ -292,7 +292,7 @@ TRACE_EVENT(mlx5_fs_add_rule,
 			   if (rule->dest_attr.type &
 			       MLX5_FLOW_DESTINATION_TYPE_COUNTER)
 				__entry->counter_id =
-					rule->dest_attr.counter_id;
+					mlx5_fc_id(rule->dest_attr.counter);
 	    ),
 	    TP_printk("rule=%p fte=%p index=%u sw_action=<%s> [dst] %s\n",
 		      __entry->rule, __entry->fte, __entry->index,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index e51b03d4c717..687bd95d2c3e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -194,7 +194,7 @@ static int rx_add_rule_drop_auth_trailer(struct mlx5e_ipsec_sa_entry *sa_entry,
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	flow_act.flags = FLOW_ACT_NO_APPEND;
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest.counter_id = mlx5_fc_id(flow_counter);
+	dest.counter = flow_counter;
 	if (rx == ipsec->rx_esw)
 		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
 
@@ -223,7 +223,7 @@ static int rx_add_rule_drop_auth_trailer(struct mlx5e_ipsec_sa_entry *sa_entry,
 	}
 	sa_entry->ipsec_rule.trailer.fc = flow_counter;
 
-	dest.counter_id = mlx5_fc_id(flow_counter);
+	dest.counter = flow_counter;
 	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.ipsec_syndrome, 2);
 	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
@@ -275,7 +275,7 @@ static int rx_add_rule_drop_replay(struct mlx5e_ipsec_sa_entry *sa_entry, struct
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	flow_act.flags = FLOW_ACT_NO_APPEND;
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest.counter_id = mlx5_fc_id(flow_counter);
+	dest.counter = flow_counter;
 	if (rx == ipsec->rx_esw)
 		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
 
@@ -348,7 +348,7 @@ static int ipsec_rx_status_drop_all_create(struct mlx5e_ipsec *ipsec,
 
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest.counter_id = mlx5_fc_id(flow_counter);
+	dest.counter = flow_counter;
 	if (rx == ipsec->rx_esw)
 		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
 	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
@@ -686,7 +686,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	rx->ft.status = ft;
 
 	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest[1].counter_id = mlx5_fc_id(rx->fc->cnt);
+	dest[1].counter = rx->fc->cnt;
 	err = mlx5_ipsec_rx_status_create(ipsec, rx, dest);
 	if (err)
 		goto err_add;
@@ -873,7 +873,7 @@ static int ipsec_counter_rule_tx(struct mlx5_core_dev *mdev, struct mlx5e_ipsec_
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_ALLOW |
 			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest.counter_id = mlx5_fc_id(tx->fc->cnt);
+	dest.counter = tx->fc->cnt;
 	fte = mlx5_add_flow_rules(tx->ft.status, spec, &flow_act, &dest, 1);
 	if (IS_ERR(fte)) {
 		err = PTR_ERR(fte);
@@ -1649,7 +1649,7 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 	dest[0].ft = rx->ft.status;
 	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest[1].counter_id = mlx5_fc_id(counter);
+	dest[1].counter = counter;
 	rule = mlx5_add_flow_rules(rx->ft.sa, spec, &flow_act, dest, 2);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
@@ -1762,7 +1762,7 @@ static int tx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	dest[0].ft = tx->ft.status;
 	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest[1].counter_id = mlx5_fc_id(counter);
+	dest[1].counter = counter;
 	rule = mlx5_add_flow_rules(tx->ft.sa, spec, &flow_act, dest, 2);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
@@ -1835,7 +1835,7 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 		flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_DROP |
 				   MLX5_FLOW_CONTEXT_ACTION_COUNT;
 		dest[dstn].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-		dest[dstn].counter_id = mlx5_fc_id(tx->fc->drop);
+		dest[dstn].counter = tx->fc->drop;
 		dstn++;
 		break;
 	default:
@@ -1913,7 +1913,7 @@ static int rx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 	case XFRM_POLICY_BLOCK:
 		flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
 		dest[dstn].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-		dest[dstn].counter_id = mlx5_fc_id(rx->fc->drop);
+		dest[dstn].counter = rx->fc->drop;
 		dstn++;
 		break;
 	default:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 6b3b1afe8312..9ba99609999f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1282,7 +1282,7 @@ mlx5e_add_offloaded_nic_rule(struct mlx5e_priv *priv,
 
 	if (flow_act.action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
 		dest[dest_ix].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-		dest[dest_ix].counter_id = mlx5_fc_id(attr->counter);
+		dest[dest_ix].counter = attr->counter;
 		dest_ix++;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/egress_lgcy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/egress_lgcy.c
index 6b4c9ffad95b..7dd1dc3f77c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/egress_lgcy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/egress_lgcy.c
@@ -135,7 +135,7 @@ int esw_acl_egress_lgcy_setup(struct mlx5_eswitch *esw,
 	if (drop_counter) {
 		flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
 		drop_ctr_dst.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-		drop_ctr_dst.counter_id = mlx5_fc_id(drop_counter);
+		drop_ctr_dst.counter = drop_counter;
 		dst = &drop_ctr_dst;
 		dest_num++;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
index 093ed86a0acd..1c37098e09ea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_lgcy.c
@@ -260,7 +260,7 @@ int esw_acl_ingress_lgcy_setup(struct mlx5_eswitch *esw,
 	if (counter) {
 		flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
 		drop_ctr_dst.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-		drop_ctr_dst.counter_id = mlx5_fc_id(counter);
+		drop_ctr_dst.counter = counter;
 		dst = &drop_ctr_dst;
 		dest_num++;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index c5ea1d1d2b03..5f647358a05c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -570,7 +570,8 @@ mlx5_esw_bridge_egress_table_cleanup(struct mlx5_esw_bridge *bridge)
 
 static struct mlx5_flow_handle *
 mlx5_esw_bridge_ingress_flow_with_esw_create(u16 vport_num, const unsigned char *addr,
-					     struct mlx5_esw_bridge_vlan *vlan, u32 counter_id,
+					     struct mlx5_esw_bridge_vlan *vlan,
+					     struct mlx5_fc *counter,
 					     struct mlx5_esw_bridge *bridge,
 					     struct mlx5_eswitch *esw)
 {
@@ -628,7 +629,7 @@ mlx5_esw_bridge_ingress_flow_with_esw_create(u16 vport_num, const unsigned char
 	dests[0].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 	dests[0].ft = bridge->egress_ft;
 	dests[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dests[1].counter_id = counter_id;
+	dests[1].counter = counter;
 
 	handle = mlx5_add_flow_rules(br_offloads->ingress_ft, rule_spec, &flow_act, dests,
 				     ARRAY_SIZE(dests));
@@ -639,17 +640,19 @@ mlx5_esw_bridge_ingress_flow_with_esw_create(u16 vport_num, const unsigned char
 
 static struct mlx5_flow_handle *
 mlx5_esw_bridge_ingress_flow_create(u16 vport_num, const unsigned char *addr,
-				    struct mlx5_esw_bridge_vlan *vlan, u32 counter_id,
+				    struct mlx5_esw_bridge_vlan *vlan,
+				    struct mlx5_fc *counter,
 				    struct mlx5_esw_bridge *bridge)
 {
-	return mlx5_esw_bridge_ingress_flow_with_esw_create(vport_num, addr, vlan, counter_id,
+	return mlx5_esw_bridge_ingress_flow_with_esw_create(vport_num, addr, vlan, counter,
 							    bridge, bridge->br_offloads->esw);
 }
 
 static struct mlx5_flow_handle *
 mlx5_esw_bridge_ingress_flow_peer_create(u16 vport_num, u16 esw_owner_vhca_id,
 					 const unsigned char *addr,
-					 struct mlx5_esw_bridge_vlan *vlan, u32 counter_id,
+					 struct mlx5_esw_bridge_vlan *vlan,
+					 struct mlx5_fc *counter,
 					 struct mlx5_esw_bridge *bridge)
 {
 	struct mlx5_devcom_comp_dev *devcom = bridge->br_offloads->esw->devcom, *pos;
@@ -671,7 +674,7 @@ mlx5_esw_bridge_ingress_flow_peer_create(u16 vport_num, u16 esw_owner_vhca_id,
 		goto out;
 	}
 
-	handle = mlx5_esw_bridge_ingress_flow_with_esw_create(vport_num, addr, vlan, counter_id,
+	handle = mlx5_esw_bridge_ingress_flow_with_esw_create(vport_num, addr, vlan, counter,
 							      bridge, peer_esw);
 
 out:
@@ -1385,10 +1388,9 @@ mlx5_esw_bridge_fdb_entry_init(struct net_device *dev, u16 vport_num, u16 esw_ow
 
 	handle = peer ?
 		mlx5_esw_bridge_ingress_flow_peer_create(vport_num, esw_owner_vhca_id,
-							 addr, vlan, mlx5_fc_id(counter),
-							 bridge) :
+							 addr, vlan, counter, bridge) :
 		mlx5_esw_bridge_ingress_flow_create(vport_num, addr, vlan,
-						    mlx5_fc_id(counter), bridge);
+						    counter, bridge);
 	if (IS_ERR(handle)) {
 		err = PTR_ERR(handle);
 		esw_warn(esw->dev, "Failed to create ingress flow(vport=%u,err=%d,peer=%d)\n",
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d5b42b3a19fd..8636f0485800 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -724,7 +724,7 @@ mlx5_eswitch_add_offloaded_rule(struct mlx5_eswitch *esw,
 
 	if (flow_act.action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
 		dest[i].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-		dest[i].counter_id = mlx5_fc_id(attr->counter);
+		dest[i].counter = attr->counter;
 		i++;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 676005854dad..6bf0aade69d7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -718,7 +718,7 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 				continue;
 
 			MLX5_SET(flow_counter_list, in_dests, flow_counter_id,
-				 dst->dest_attr.counter_id);
+				 mlx5_fc_id(dst->dest_attr.counter));
 			in_dests += dst_cnt_size;
 			list_size++;
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2eabfcc247c6..f781f8f169b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -658,6 +658,7 @@ static void del_sw_hw_rule(struct fs_node *node)
 			BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_ACTION) |
 			BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_FLOW_COUNTERS);
 		fte->act_dests.action.action &= ~MLX5_FLOW_CONTEXT_ACTION_COUNT;
+		mlx5_fc_local_destroy(rule->dest_attr.counter);
 		goto out;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 62d0c689796b..e95488ed1547 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -43,6 +43,11 @@
 #define MLX5_FC_POOL_MAX_THRESHOLD BIT(18)
 #define MLX5_FC_POOL_USED_BUFF_RATIO 10
 
+enum mlx5_fc_type {
+	MLX5_FC_TYPE_ACQUIRED = 0,
+	MLX5_FC_TYPE_LOCAL,
+};
+
 struct mlx5_fc_cache {
 	u64 packets;
 	u64 bytes;
@@ -52,6 +57,7 @@ struct mlx5_fc_cache {
 struct mlx5_fc {
 	u32 id;
 	bool aging;
+	enum mlx5_fc_type type;
 	struct mlx5_fc_bulk *bulk;
 	struct mlx5_fc_cache cache;
 	/* last{packets,bytes} are used for calculating deltas since last reading. */
@@ -186,6 +192,9 @@ static void mlx5_fc_release(struct mlx5_core_dev *dev, struct mlx5_fc *counter)
 {
 	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 
+	if (WARN_ON(counter->type == MLX5_FC_TYPE_LOCAL))
+		return;
+
 	if (counter->bulk)
 		mlx5_fc_pool_release_counter(&fc_stats->fc_pool, counter);
 	else
@@ -536,6 +545,49 @@ static int mlx5_fc_bulk_release_fc(struct mlx5_fc_bulk *bulk, struct mlx5_fc *fc
 	return 0;
 }
 
+/**
+ * mlx5_fc_local_create - Allocate mlx5_fc struct for a counter which
+ * was already acquired using its counter id and bulk data.
+ *
+ * @counter_id: counter acquired counter id
+ * @offset: counter offset from bulk base
+ * @bulk_size: counter's bulk size as was allocated
+ *
+ * Return: Pointer to mlx5_fc on success, ERR_PTR otherwise.
+ */
+struct mlx5_fc *
+mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size)
+{
+	struct mlx5_fc_bulk *bulk;
+	struct mlx5_fc *counter;
+
+	counter = kzalloc(sizeof(*counter), GFP_KERNEL);
+	if (!counter)
+		return ERR_PTR(-ENOMEM);
+	bulk = kzalloc(sizeof(*bulk), GFP_KERNEL);
+	if (!bulk) {
+		kfree(counter);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	counter->type = MLX5_FC_TYPE_LOCAL;
+	counter->id = counter_id;
+	bulk->base_id = counter_id - offset;
+	bulk->bulk_len = bulk_size;
+	return counter;
+}
+EXPORT_SYMBOL(mlx5_fc_local_create);
+
+void mlx5_fc_local_destroy(struct mlx5_fc *counter)
+{
+	if (!counter || counter->type != MLX5_FC_TYPE_LOCAL)
+		return;
+
+	kfree(counter->bulk);
+	kfree(counter);
+}
+EXPORT_SYMBOL(mlx5_fc_local_destroy);
+
 /* Flow counters pool API */
 
 static void mlx5_fc_pool_init(struct mlx5_fc_pool *fc_pool, struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index 4a078113e292..762d55ba9e51 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -497,7 +497,7 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 	memset(&dest, 0, sizeof(struct mlx5_flow_destination));
 	memset(&flow_act, 0, sizeof(flow_act));
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest.counter_id = mlx5_fc_id(tx_tables->check_miss_rule_counter);
+	dest.counter = tx_tables->check_miss_rule_counter;
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	rule = mlx5_add_flow_rules(tx_tables->ft_check,  NULL, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
@@ -519,7 +519,7 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 	flow_act.flags = FLOW_ACT_NO_APPEND;
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_ALLOW | MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest.counter_id = mlx5_fc_id(tx_tables->check_rule_counter);
+	dest.counter = tx_tables->check_rule_counter;
 	rule = mlx5_add_flow_rules(tx_tables->ft_check, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
@@ -1200,7 +1200,7 @@ static int macsec_fs_rx_create_check_decap_rule(struct mlx5_macsec_fs *macsec_fs
 	flow_act->action |= MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT |
 			    MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	roce_dest[dstn].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	roce_dest[dstn].counter_id = mlx5_fc_id(rx_tables->check_rule_counter);
+	roce_dest[dstn].counter = rx_tables->check_rule_counter;
 	rule = mlx5_add_flow_rules(rx_tables->ft_check, spec, flow_act, roce_dest, dstn + 1);
 
 	if (IS_ERR(rule)) {
@@ -1592,7 +1592,7 @@ static int macsec_fs_rx_create(struct mlx5_macsec_fs *macsec_fs)
 	memset(&flow_act, 0, sizeof(flow_act));
 
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest.counter_id = mlx5_fc_id(rx_tables->check_miss_rule_counter);
+	dest.counter = rx_tables->check_miss_rule_counter;
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	rule = mlx5_add_flow_rules(rx_tables->ft_check,  NULL, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.c
index 4b349d4005e4..8007d3f523c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/fs_dr.c
@@ -521,7 +521,7 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 				goto free_actions;
 			}
 
-			id = dst->dest_attr.counter_id;
+			id = mlx5_fc_id(dst->dest_attr.counter);
 			tmp_action =
 				mlx5dr_action_create_flow_counter(id);
 			if (!tmp_action) {
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 5f581e71e201..36099047560d 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1952,7 +1952,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 		goto out_free;
 
 #if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
-	dests[1].counter_id = mlx5_fc_id(node->ucast_counter.counter);
+	dests[1].counter = node->ucast_counter.counter;
 #endif
 	node->ucast_rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dests, NUM_DESTS);
 	if (IS_ERR(node->ucast_rule)) {
@@ -1961,7 +1961,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
 	}
 
 #if defined(CONFIG_MLX5_VDPA_STEERING_DEBUG)
-	dests[1].counter_id = mlx5_fc_id(node->mcast_counter.counter);
+	dests[1].counter = node->mcast_counter.counter;
 #endif
 
 	memset(dmac_c, 0, ETH_ALEN);
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 438db888bde0..2a69d9d71276 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -163,7 +163,7 @@ struct mlx5_flow_destination {
 		u32			tir_num;
 		u32			ft_num;
 		struct mlx5_flow_table	*ft;
-		u32			counter_id;
+		struct mlx5_fc          *counter;
 		struct {
 			u16		num;
 			u16		vhca_id;
@@ -299,6 +299,8 @@ int mlx5_modify_rule_destination(struct mlx5_flow_handle *handler,
 struct mlx5_fc *mlx5_fc_create(struct mlx5_core_dev *dev, bool aging);
 
 void mlx5_fc_destroy(struct mlx5_core_dev *dev, struct mlx5_fc *counter);
+struct mlx5_fc *mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size);
+void mlx5_fc_local_destroy(struct mlx5_fc *counter);
 u64 mlx5_fc_query_lastuse(struct mlx5_fc *counter);
 void mlx5_fc_query_cached(struct mlx5_fc *counter,
 			  u64 *bytes, u64 *packets, u64 *lastuse);
-- 
2.45.0


