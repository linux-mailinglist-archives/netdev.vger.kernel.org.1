Return-Path: <netdev+bounces-134911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B1E99B8A9
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E83028272C
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1AA13957B;
	Sun, 13 Oct 2024 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uq8h+qyc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98012FF9C
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802031; cv=fail; b=XK+pICy4DwBNQDAAJYMH3ArC7+ikxMDjpl7Mtu4jW6tTixCXYDnPWeUooH4kIcE+3l2y5cba08mlzJD9UQbQOkxgfIjoUWXA8SWyuBBjnpda0e7HPaL0UsYF2rqRJkKaNTlOi5ymCiwCMVQ7ii/q1tNfeSF0vzNmqING+qCUIOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802031; c=relaxed/simple;
	bh=VUOn6GXCvm7h50UJKNENBsm+dB0humSVJ2tCYNzLd9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=newliyjbhcADdQFm9Wa1xVHDoG7r/bEOVdhlwf5o/o6ToAJxQZQ2YTko5Xdh7tSpqQ2v3YVlvbilObB6YnoEgrQwKFOGJ2S6xrL5ENb6z5YbgOhGReyBLJ64PPvBYgi2wxNeD34Z4E0Tp8pEUNNOP8I2cd4dhN+mvVjvp6hB724=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uq8h+qyc; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gA/5kh5yXGvCveRW4xeyNUiHnIemXDqRkiM2oZGxUBLOiL4k0Ijqaw/MmNjmGSzYnn3Zs95DjFLIx5nhZEn+zyl8IZOnmI46RBs3aUt3qRuohjVc9JT6gAYMTqysQ2SS7zEBGjAA3lGOGpPu7FvGEEU+nGeVscPTcekv7q4cK86WHz/k8wVCM5zOHB8Ec0VREWnjdEEkiVC7SZxhs53nPyuilIgal0fVmf0Xoq33WMHk9/hE24kzqLwnn5kB01nmcSMp3+J/V6fzlEIoSE8j8RG78xTEzK3sGCd3R8po7tA1pxeCqjYX7jgUteDmpZSF2S+zMEQJ/9fB2fdW/mxXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbH93SHmMh18raBkI/tOE1it7xyJd1pXIMJ3n3AsNYY=;
 b=jykcuOhkRR8hSl9gNgOIYDA03gWmppn144uQf1KOO44XA4tgEg6T9msufk+byNqnAj3WDnP2UbClJIkfDsite2Eh8fsycWuJ2+JR2I05sttzMhQ8m46wiKgNGIe2ZBhcWyPajpv+VbtUC3TL9uOSBcJaqO+pDPdkM0sE4cdfAE8gycNwxVHIgQQs32u2RFJ6YR5bBtdmrxkB3Eg9QyW292hUU2NS9pIFlgWlzVEFaB+JCpL52mpaMBwc55itOrR07gTd/pR/Ka1BDA43FuAo7gEWJz8vFVri12FU7E3cVbI8odoD1GwyVb3oXg2bhustz7QMWz3lmNBrzLq8HuF39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbH93SHmMh18raBkI/tOE1it7xyJd1pXIMJ3n3AsNYY=;
 b=uq8h+qyc1CO6uCDircEaCtldAYgLmya0te08Gpi3FI/wSFtqrNUOOqxgwVGsRmRwJmgfH7L7ePwnZNDjM6uBoYSkoeurr1lAj9dLPYcNuNlDkAVAxgUcEPluFWb1es9lDdeoJlKShJ2QAYuEpg5acurfm9kp7FlD/Wb1Ede1BucLWXjWVU8cuFXreUwlYWGfYjOosJUorvQZJecouihff+kX6rQL4bJKF+hXO4Vo8UBbSqTvPA7ZIJnOrnYO/dte940tHsaQsyVfZCKRqJzy4xBLv3K8qjKCQJ1tyrns8yHhbXLKh53u5TzetPcGusEEqze20EpV7802fb0zy+DH+w==
Received: from CH0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:b0::19)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Sun, 13 Oct
 2024 06:47:05 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::e7) by CH0PR03CA0014.outlook.office365.com
 (2603:10b6:610:b0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Sun, 13 Oct 2024 06:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:47:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:47:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:47:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 14/15] net/mlx5: fs, rename packet reformat struct member action
Date: Sun, 13 Oct 2024 09:45:39 +0300
Message-ID: <20241013064540.170722-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241013064540.170722-1-tariqt@nvidia.com>
References: <20241013064540.170722-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 315fbbb6-b855-4434-a4b7-08dceb52d999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LV6vlSaZF7dl9wsSM4wBjTJc/ikepMT97khi/td3c28Y9xPVs/+6z0+EktoZ?=
 =?us-ascii?Q?elClvv5sLdTfUPZgOLs/k5R4ZBJPeAN0Nu9J0PYZVfQdKi9WEQdvjJeGQzB4?=
 =?us-ascii?Q?Hr4CXWWWrr5U9YH+B3v5PWaxPY/8OmdMKsZWHNmqyKVi6psRoJWwPNw7aR0D?=
 =?us-ascii?Q?m7rvFU0lgMeChWUoxtTMVgvmoVwt8QCmBYi6qRDTq72IK8aUmuNnR+lbkUSL?=
 =?us-ascii?Q?7hZFBR5NmeXnbjBr3FjV3q2Rd++RT4XQHwKQ+pU4T+L3mflcSd4fR7NKbozs?=
 =?us-ascii?Q?avxBcBOV0yY4/v1k1OWClAUSVznjX2fy5S4YFIhlI/9Pogo4PfGZEwblXD+T?=
 =?us-ascii?Q?HGqdv5CpqcYOa+1ecE3N3TYib/4YaKLN50QFWbgYHxgpm+HkUHXbM68hYkja?=
 =?us-ascii?Q?us7jfRrXib/S/ib9m3uWpCV3wI14T+5btjdVOUEmW6C6GvfxEibXLFfbiZR1?=
 =?us-ascii?Q?mCcT4lko/MOqAvYa+ntRtL9MnJPCJRQVxDjVgKB95yj5LpluUCTLhAsBafj0?=
 =?us-ascii?Q?eOMsAr3Vt3z6WQ8HG0+VT5yO4EPxEVg+/w5D9KHmcUpjqK3VsRNNNB2bc42y?=
 =?us-ascii?Q?0zrEKjFnehWPccoAPm7f4o0Bc7WrXmzoFH8y5nzf7kZY5iGG+12QzcXr5dbZ?=
 =?us-ascii?Q?YUf4xBmCFc4VIBtBdry1KdPD0TJdYLOkSCn4KE4IgemERooLOlOAuE9TFGs5?=
 =?us-ascii?Q?QWinI5Bhegs+c0rcqsfBUuEUW5aXnpxwaY+wmfukZnxF19RbY7o74MiKH0fq?=
 =?us-ascii?Q?xXKxzpiT2tN0k+xPBbRZVcp6fyIZsz05SJ3lWeVN37eWe4TJRtAD9wyznVfW?=
 =?us-ascii?Q?wECdi54b2AB6ZQAlQ/nsRRV7Iq+p4HS+y485VjA0MCXN5bAk7P8LXYgcNeZp?=
 =?us-ascii?Q?yqk38AQJXjOsr25AWBHqDrjfXmRWh+HobMoI2Mr8vy2JxjESfIVxt8glYiny?=
 =?us-ascii?Q?PEACBay6XXXteg4AVV6O1egZSendG6ZLUOi7IBe4xDcl7qXe+Thdn685tDpe?=
 =?us-ascii?Q?WCJxneGq5/SmPXLZBdHrkCEjeNKUOAwFi+1Qd1IBjSFbRi0cdC6tka+eyITD?=
 =?us-ascii?Q?Uke5o4FiFrtL+7DGfbgaEb1cPoQo+0PAaiIMwS8oJKsisCX4pSp6kCvIdJ/+?=
 =?us-ascii?Q?94/HoE92LIhO6o4Av0Gxg8iTBXB1bvUwkaoH2x2qaimSMe1WaDIe79FdvAZL?=
 =?us-ascii?Q?/F9+nanhC/pBZjVEGGPV3ttOuvHuC06Vary0mapodQ5Bh/5wcoY7yHkBSrgi?=
 =?us-ascii?Q?UqAQpuc6Uygn1xiIDas4Mu5qA7rjTR5G1wJzaCb0GCOrGM1/vETm9bk22h3Q?=
 =?us-ascii?Q?SgOEOMfWq2DFqgfLq7t82Xc7DaCdIXV+80t0d0Q+Wl2C/j1zl/Cp3SkZf1SK?=
 =?us-ascii?Q?6/qBRVj1apzocc5xaUJnbcLUaLEy?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:47:04.9088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 315fbbb6-b855-4434-a4b7-08dceb52d999
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768

From: Moshe Shemesh <moshe@nvidia.com>

As preparation for HW Steering support, rename packet reformat struct
member action to fs_dr_action, to distinguish from fs_hws_action which
will be added. Add a pointer where needed to keep code line shorter and
more readable.

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  2 +-
 .../mellanox/mlx5/core/steering/fs_dr.c       | 23 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 964937f17cf5..195f1cbd0a34 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -73,7 +73,7 @@ struct mlx5_pkt_reformat {
 	int reformat_type; /* from mlx5_ifc */
 	enum mlx5_flow_resource_owner owner;
 	union {
-		struct mlx5_fs_dr_action action;
+		struct mlx5_fs_dr_action fs_dr_action;
 		u32 id;
 	};
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
index 833cb68c744f..8dd412454c97 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
@@ -256,6 +256,7 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 {
 	struct mlx5dr_domain *domain = ns->fs_dr_domain.dr_domain;
 	struct mlx5dr_action_dest *term_actions;
+	struct mlx5_pkt_reformat *pkt_reformat;
 	struct mlx5dr_match_parameters params;
 	struct mlx5_core_dev *dev = ns->dev;
 	struct mlx5dr_action **fs_dr_actions;
@@ -332,18 +333,19 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT) {
 		bool is_decap;
 
-		if (fte->act_dests.action.pkt_reformat->owner == MLX5_FLOW_RESOURCE_OWNER_FW) {
+		pkt_reformat = fte->act_dests.action.pkt_reformat;
+		if (pkt_reformat->owner == MLX5_FLOW_RESOURCE_OWNER_FW) {
 			err = -EINVAL;
 			mlx5dr_err(domain, "FW-owned reformat can't be used in SW rule\n");
 			goto free_actions;
 		}
 
-		is_decap = fte->act_dests.action.pkt_reformat->reformat_type ==
+		is_decap = pkt_reformat->reformat_type ==
 			   MLX5_REFORMAT_TYPE_L3_TUNNEL_TO_L2;
 
 		if (is_decap)
 			actions[num_actions++] =
-				fte->act_dests.action.pkt_reformat->action.dr_action;
+				pkt_reformat->fs_dr_action.dr_action;
 		else
 			delay_encap_set = true;
 	}
@@ -395,8 +397,7 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 	}
 
 	if (delay_encap_set)
-		actions[num_actions++] =
-			fte->act_dests.action.pkt_reformat->action.dr_action;
+		actions[num_actions++] = pkt_reformat->fs_dr_action.dr_action;
 
 	/* The order of the actions below is not important */
 
@@ -458,9 +459,11 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 				term_actions[num_term_actions].dest = tmp_action;
 
 				if (dst->dest_attr.vport.flags &
-				    MLX5_FLOW_DEST_VPORT_REFORMAT_ID)
+				    MLX5_FLOW_DEST_VPORT_REFORMAT_ID) {
+					pkt_reformat = dst->dest_attr.vport.pkt_reformat;
 					term_actions[num_term_actions].reformat =
-						dst->dest_attr.vport.pkt_reformat->action.dr_action;
+						pkt_reformat->fs_dr_action.dr_action;
+				}
 
 				num_term_actions++;
 				break;
@@ -671,7 +674,7 @@ static int mlx5_cmd_dr_packet_reformat_alloc(struct mlx5_flow_root_namespace *ns
 	}
 
 	pkt_reformat->owner = MLX5_FLOW_RESOURCE_OWNER_SW;
-	pkt_reformat->action.dr_action = action;
+	pkt_reformat->fs_dr_action.dr_action = action;
 
 	return 0;
 }
@@ -679,7 +682,7 @@ static int mlx5_cmd_dr_packet_reformat_alloc(struct mlx5_flow_root_namespace *ns
 static void mlx5_cmd_dr_packet_reformat_dealloc(struct mlx5_flow_root_namespace *ns,
 						struct mlx5_pkt_reformat *pkt_reformat)
 {
-	mlx5dr_action_destroy(pkt_reformat->action.dr_action);
+	mlx5dr_action_destroy(pkt_reformat->fs_dr_action.dr_action);
 }
 
 static int mlx5_cmd_dr_modify_header_alloc(struct mlx5_flow_root_namespace *ns,
@@ -836,7 +839,7 @@ int mlx5_fs_dr_action_get_pkt_reformat_id(struct mlx5_pkt_reformat *pkt_reformat
 	case MLX5_REFORMAT_TYPE_L2_TO_L2_TUNNEL:
 	case MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL:
 	case MLX5_REFORMAT_TYPE_INSERT_HDR:
-		return mlx5dr_action_get_pkt_reformat_id(pkt_reformat->action.dr_action);
+		return mlx5dr_action_get_pkt_reformat_id(pkt_reformat->fs_dr_action.dr_action);
 	}
 	return -EOPNOTSUPP;
 }
-- 
2.44.0


