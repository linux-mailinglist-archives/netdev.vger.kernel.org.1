Return-Path: <netdev+bounces-136220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58559A10D2
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AFF1C224BC
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3A62144B2;
	Wed, 16 Oct 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sZcv4uwL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710272139D4
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100291; cv=fail; b=cLtxQwjKqM1gErSw/0em0eyKeROKwsTSqUEh7T9UABBXYNHu+HJui4snHIKtDG9rtsxvgHOD5VMJQHZ4giXbu8tc7N13cZxuuip2AH1svXH0opzcqTIfR9gA5KJ13OY+AwI4kG+eHmDdL19I1IXb1wjl9sWfqRZ7Goc9/Ck1bG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100291; c=relaxed/simple;
	bh=VUOn6GXCvm7h50UJKNENBsm+dB0humSVJ2tCYNzLd9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAejU1QMNEvLDywPuo1c2+tbcT6pbaHCPH6jxQ9LLi57CpFIRCcW0wDXJ+qM19JBgar5YRapaFGWUbR1SE7mR2ArRkVWgba3jXI71K+CPsCBb/6LxmLdXT+6vVgkR1WvdFQ07kuO7STMExwr6bUMqMUPEgwA3XcvyqX6csOQLTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sZcv4uwL; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3jp+Uew+yJ+2AE7A1eZ7o7ktdJIIXAfbj6fy03G/Uk+h0ntYnHG2XL5t+e432dGxEyBgVVbsoTmf/jiq0ibfSCMXv+oonMVC2EGumbTOrVXaaUkVxqQvSbIPmKHMNBfncXWooOwfj50rW05p7/1tAOn7GtfWDWfrq4FR7nNAXjCh5wz4vaNKfM792gc/5y7VhnoY8m3QdTlcFStaYpL1/YDgTVNedLitAI0eVnBg41fMQkc3ZmEUBSaQyGE7O8DQUvS5ObRqRXrscIim48QxJIkz57zprk1N2SdbGoBU+tb/njMGIzFGsYWV/STTMMJWPieNH4F3dLGWt/vShvVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbH93SHmMh18raBkI/tOE1it7xyJd1pXIMJ3n3AsNYY=;
 b=yWhX1bMSb8pk0CCMARFAS5MrZ4ZC1/QreDUh4oXKqtWOZmDtG9Jl7vm/ayUOiS5qe4UKYXpXZKav0OZ85il7ZJ7jStx0BCV/gwbywus2uppsOHVtfrshcBRt+9SvYiAdlfuKKVy91R9aTdHcn83Rj0qjLr18lc4H7SpoXBfDFc5EnetzbjZWJncpO67gY8BSbVwqc6jN1uEdj+qa8nzUEsXws3ol0dnotahLfyGjbVv9/TB/PbGXB3sfFM2VQjGijYoO9ejxYZ53PHM2tmkDI1nOQfW+Nm/azSEtG8MQ3ggpqpLYDfFrah7BgFs0++tjHyMLod3KUvsEhGsc+R+vLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbH93SHmMh18raBkI/tOE1it7xyJd1pXIMJ3n3AsNYY=;
 b=sZcv4uwLqpGuEQROQEMGWJkSuUHYVmP8WPomSg89GJxuTZGB5Sil/8U9FfgZgcD5Vo6XM8NTJG2VjnSen14kolxkI2zaZKxF3e4e98Q0N5yr1vTcWNVVKxVaB8vItK6kpcBjo5Hhv/VHL2PUPXX0jBCIV8ojgDASVjlpiGw7sMSnsSXxuRv65wJ9U/q5qPNV8C8xFjY6M198N7WoqALiZS6YBCTxZL8BY2TivZOMsBPkCtns3l5LM08wXp1b+iMzrXNdZZPMU2Mx9VBB/pdXd38myYXrfpTbnNLZRnxfNS8IVZjL0tkMBpyv9R0g6CZvAaW50bwlkLgfhs6VZVt6zw==
Received: from MW4PR03CA0036.namprd03.prod.outlook.com (2603:10b6:303:8e::11)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 17:38:04 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::69) by MW4PR03CA0036.outlook.office365.com
 (2603:10b6:303:8e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 17:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:38:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Moshe Shemesh <moshe@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 14/15] net/mlx5: fs, rename packet reformat struct member action
Date: Wed, 16 Oct 2024 20:36:16 +0300
Message-ID: <20241016173617.217736-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241016173617.217736-1-tariqt@nvidia.com>
References: <20241016173617.217736-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 893420fe-349b-4191-fbf3-08dcee0949e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mwecWcoaHK9R3zDHBwqck8QpdSXCCJT6b/IllAyozhqenky5r1TFBdLlpoJ/?=
 =?us-ascii?Q?HaZt5gclso97uWlHBmq9dHvYx2nn83EzX2v+PrqW7H93ARiaCnVLhZrOu5fM?=
 =?us-ascii?Q?RnmpDoX4vg3+BvnvDfOrpkWrizIos39H9uqyHhCB3D5I2rywWN7txY4DfalC?=
 =?us-ascii?Q?kP/k9HYpXgX702+iC0eKpmOkeSoQgM9rTit6aYbf/TVwJDtXdkwShwLbSWPk?=
 =?us-ascii?Q?agHNbQHl2UP65nGCQ5dRjPHBDLa5/VQiDUIwXuFSA91virRDd72ZB3uCEHRz?=
 =?us-ascii?Q?ZjAc1hz+aUdsjYirAO6ougJxb3uT+cf/1yEeQtBQTVdWOa852yBGA/aF5Qea?=
 =?us-ascii?Q?aP3XAuDHFTZhj9WsEOlM6QobrJHoWWMybI2/8JSuPOIW4DVLICiSdI3D4q8u?=
 =?us-ascii?Q?BvCSwxprfpiFAVym6CwoHIuHcnDhh+zgkjLzWd1b44F3JCO0CeJZcVEqodbI?=
 =?us-ascii?Q?VqnIW0H++vxKcdV0tGMkYxIFb1MZtlZ/8c4NaNpgt+n310w+r3bSYU9lT+NG?=
 =?us-ascii?Q?r6cWy6uNBA/k7mYJZDgHsTGmcn0FAX7XUmOdZ+edxnvvCNWaRRi18Uu4+87P?=
 =?us-ascii?Q?w/0AZae3RMO4g3LUxTd/x2WR314ZEZ0Ak8IynRb2yxNbxT6be5633NOoJZVp?=
 =?us-ascii?Q?LgouRYxkyU8t61vmvVXCpnxPJF3Va8RRNjsKAggvaS4OEEJv2XgTNV/FrbJo?=
 =?us-ascii?Q?N5sDflerFk+wUj+fZacl8Qm5JNhwxY/Og+HBgbaDJPHHOSb9hC8zK5jrJqe5?=
 =?us-ascii?Q?CWky7iNkjhZnWXCbdzs1tNCq7Pbc6FqMQ42S2rnlguKBLgCUlKhcUV+Vvx/9?=
 =?us-ascii?Q?6ud0eh7+6crLBaLsRkZRSU9Ojonyu+2RvjL1gJGH3dx89eamTJZnLCIJSing?=
 =?us-ascii?Q?Ye0XXt1iOV4ZA9SQ89jl5inAzw24T68+SVkAjzkZjq68s0kgZ17UZHp0bhpI?=
 =?us-ascii?Q?vWqMh3TttJSxqy5hv4uHn7qjgaT+KXpMs/3VBC6WV5xhqpgC7f+rBK6JWVJJ?=
 =?us-ascii?Q?R/zj4LPqOuWoDEFJItdavxjS8L3R83bujsI9ZkT0LVc4nJFoKO8Ukk9r/Y/F?=
 =?us-ascii?Q?PckAwOL8qNARUOQZuWzMaKva9zUvBsRrdPGOfaKRA5j/RdMv4jtYUXbH13+j?=
 =?us-ascii?Q?itJBgqQORL0xt9yrwIYTudkNpYzI5FucFUcbmLIfUAcJWeOw59pAcpQ2V6bF?=
 =?us-ascii?Q?1LIl31XixO7U9CL9TKnb+9TaVSAZ5JtdV0H21nCOT79cdoCTLbRFoEtq2/Qz?=
 =?us-ascii?Q?lXw3yymW7rvWwxZqu4jp2kx5bPOjEKo4R8fWPwCWdSZA32c8C+gBUp9azFFM?=
 =?us-ascii?Q?7im4fiBM0DNU9SYL6PuhXceRd43lZmK4oQPbzw++C8tPatvCbPGR1gszDBrk?=
 =?us-ascii?Q?edxpidWFOmPruevsrMr9jDgeE0wJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:38:04.1209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 893420fe-349b-4191-fbf3-08dcee0949e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210

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


