Return-Path: <netdev+bounces-135334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA9599D8A3
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30ADBB21F1B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7C71D5AC8;
	Mon, 14 Oct 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LcrEyenp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085D1D0F79
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939304; cv=fail; b=YqzRXjlCTSfBnnbu7BVgFbTfBQniy4r0KaOoGWnSrq2N0/sBE8TIp73IRQW+Wc0Nr6Wd1zmVfdg3WomhRgRH+Jm1xUNVozIG8llDPTKiCacONnYUte9VUJ4PYCyHrmhHUR/KBc4u6tslPUKPsLaS6PzygMkw+xjHswfVrrfdmBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939304; c=relaxed/simple;
	bh=VUOn6GXCvm7h50UJKNENBsm+dB0humSVJ2tCYNzLd9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1DmYUhXw5E/YkP1BH/hj15izn8C5Gequbfo8iELFnWRhi3fhboH5kHhrfBgrhfn3Ej1i+sS3X/fPxkJRqLZHmrk+mTTWli1Ag5rAMBVSBydlSRQmoSQ/5wnqKmMHAMQLXYXS4DbWWmqB6okVB7cxe3Kor0E+pb44aUE4qKEYMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LcrEyenp; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLctbFBxFS+pA03TVThkMZ6Z1d+qqSxgbX/MEixPtgjw+6by6Yo73blvqk0ajYw1cocBKQ1npqulVXzhQBVXBrIRqyGoS2u1XQnAS9qXw7KeBjW+kZ4L1bffIuSt8/56Q9n0hGcFmPHkyN8eBsjEY6n2lxrsdReKEjuM9H3u5eqOcaRg1wAEoz1+e6yP6SZcy/08y6y6XOWSO69ftb8j7JopoeL/UHlTxITG0qOALeLqYljLXYeXNuIGhrtZdoCwDX+sq5aKpHYTA4uZUiYy0qASq5/wYlPFXoI5BQVRhV8mxXJHhQazdIbSSa0vz9OgGZsO7pbD35P18YU40CzHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbH93SHmMh18raBkI/tOE1it7xyJd1pXIMJ3n3AsNYY=;
 b=kAUuXzkv6SDjB+fesCu5mGowOuOxtG43JF707TN90fG5Eehf0vfIhM8lzLozh8ZLw9YZTttfRSG9k3CP3apUABCK5fXuq2VTkxzyJqQqF9F2y4W+BokeEmMN4rFnqszDyfzwawf8k1KiW29/Hsci31lgUahwkH9s1k7tAUbrg6rB9zxEvGgwZsyLO07Wa5F9JKl/gIT0BxHtI9QNq5r1eteNe9XRr9G7IH81XVue+DAESf/Y4/hA+Wra+C8PohHuIaxjvqNB02Vk/q1XRcIpPBYn7QfsWpNazW2ExfDeHvc6JRR548DcUaT0JKgYG6KgR5iMRrJx7BWyHHlWSEYWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbH93SHmMh18raBkI/tOE1it7xyJd1pXIMJ3n3AsNYY=;
 b=LcrEyenp37kxA3s64G9soDMGuwF0QFQ433GW8mLGwhJrkGMP0/GKa4LTSyIAKQoVDQ8S+Glc1OtFW6CnK4AZ9zuwx7oDaKOExnlYQwNTtS5P39rG+0zXVrT84d2VM3PE9MUQxnLsNzIUwzB3Uj+jwFYCF4WtlRAntmWhaSlkUY85etS6mXrLRLcdk5uyEkbJ72v1abLWiWOUBwarqc+8OZMzCX46Wsy+7uDzbHMN63DQ/kN5ESeDBzTt/2+x/IIHzhvh97bhRqNgMPcXN7+v013e0k8DzkEk+OPSqRvUY5JiWWhK8nb+d4lF/FWlCS2db9Gju/zXYir1mzcsBtoSkg==
Received: from CH2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:59::28)
 by IA0PR12MB7751.namprd12.prod.outlook.com (2603:10b6:208:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 20:54:58 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:59:cafe::3c) by CH2PR03CA0018.outlook.office365.com
 (2603:10b6:610:59::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Mon, 14 Oct 2024 20:54:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:46 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 14/15] net/mlx5: fs, rename packet reformat struct member action
Date: Mon, 14 Oct 2024 23:52:59 +0300
Message-ID: <20241014205300.193519-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241014205300.193519-1-tariqt@nvidia.com>
References: <20241014205300.193519-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f27dbe7-4bf1-4168-3d97-08dcec9276e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nxwQisBnRmBTPUKYLMp0USf1Vdqn+zzJtcv468vFVLVo5ZOUPG9sfPpWVw6A?=
 =?us-ascii?Q?O7jLic28MAP/GQht7NRhEHhJ+u90aIx3nuZaSEGQKV9HdPe6SKTlD0a+UacP?=
 =?us-ascii?Q?n3f6Q3Kk8ZcsUsR8SAl6zRO+biT5OK00AqECB/vgC5u4P3DNgcTWRgnJ45s3?=
 =?us-ascii?Q?BFrxS1CjO0zAAL6rlxhHJkM4gEnuaWFWb+4VLn7t7P8MHrJ6JvzIAw1E4v2C?=
 =?us-ascii?Q?UmwXwd60/nh3NfQN7wdPBm3lLuv9jKRhmRFmf8mOfRQa9/u4CsDq9p3l6yau?=
 =?us-ascii?Q?gQGk38SZ1Laz0ZXc1AMDYssoAxFaqxkKZqNiFLbtic+8Qb0hpynlexxjnW95?=
 =?us-ascii?Q?SgUBkjzUpdhSG+qXre074dIhKgLRqikc83o/hFxMBu9G9uSQIvpdd7xBJLAi?=
 =?us-ascii?Q?5+s7Gi/6tGVH463gK0hnFaseEr6DTf/16XlbTVbiE3c7cJtaL+B9wM7gQCHp?=
 =?us-ascii?Q?lMh0V2op+ABiclm/NpssL7bmkApEQUje6IEAl5vmBv/IMYBoRXnD/pS02X50?=
 =?us-ascii?Q?V8tL2kbopzDbKsAbZPUvlLYFYdcbhcYpOghnK9+XoND1C1X+5e9pr74FCi96?=
 =?us-ascii?Q?/c8Q+GPzNuNCdAaSwerU9rHmNMlPEq383y0jRpLHUwjbc+yP4ywYq+oeqqQg?=
 =?us-ascii?Q?RSq3J52xgIDCg/6vhFldtg0vWHSCgwZwzCWz6pOzdycmBNwfoucQavWI+r+M?=
 =?us-ascii?Q?Eq7h3hIgW4/R+lwgsg0MCpawUbMYARiHn65r9X4defs/Jc7/PmPGPTmOSDQ8?=
 =?us-ascii?Q?1KSLBgaMXrRjjjCxQLPGAiLvWbfdY5WzeBPlrFScQU/JFhnc2apstYOEdk/I?=
 =?us-ascii?Q?I+pmJVpL34lsIdZd3epB0V9SqjNpinRAf53rjhbIejYi/nMUA4C441A/s3Hq?=
 =?us-ascii?Q?ieJodGu4iKz/SXvOFaEtnRmsjeoRddVZiUPZNXtO3FzW6YAN62LN+7xKGhOm?=
 =?us-ascii?Q?ADUe+6DEMEYuIxOpAkj+5j7yP0wJHKTB4aMQQH06U9JpTYapggMuoMJKr5n3?=
 =?us-ascii?Q?g+YjJupGfNuf/S+x1T6HPDHThx6NxLo+ECPBoMhM6be96r7MHSX1kIH/I2ke?=
 =?us-ascii?Q?waQ/5DPndQJ7LeLzcli0y4fXiAictHEK1Jj+i7I3InDdrGOw+dEXKENn6lXo?=
 =?us-ascii?Q?6b0m1/YM5uQ5/rlBeXuDRThntnwk8lBM7Na18Fj2PTRf0pC7j/zriXRKQDTs?=
 =?us-ascii?Q?otTkEW43k/Yfbdj9FSfaPKsHnR7L8374jKFkQ3yLEdwQsSo5PUiw5IT5UAeW?=
 =?us-ascii?Q?hZ9acWKnICUedRtKDnbTZWB93qtUf+Cr5rxH6ZH78tG6UKdFV8IIcLiqnSR4?=
 =?us-ascii?Q?ro9DAcvT+LmAwv7+iBw2HXAMFHJ/zzISFZCoduPvsDeDxryJq3AMygVrGLJb?=
 =?us-ascii?Q?JD7h1TRiluymNVQyTLX+l8Xmbb7j?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:58.2229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f27dbe7-4bf1-4168-3d97-08dcec9276e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

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


