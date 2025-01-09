Return-Path: <netdev+bounces-156773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200DDA07CF2
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642301654AA
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1290E2206B6;
	Thu,  9 Jan 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pcm6Ezwm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94522069A
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438889; cv=fail; b=IxoaN69kWL2gn9wKDsQB5s/V28pE3RWY3zix9EbLNxypHVxoB7B/0hrfR0YvdOewMkzdelLXYID5a3Ba6I7hNJM4w862H6WPMffcOX37Kb8+LCj5SNJT+zjmYcO8esR7J8wjwd8Vdue50ffydRaY7FxysXe5wRf9MSP4uKg2jkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438889; c=relaxed/simple;
	bh=3gcI7Czko5s8iiwReKiRxMckqrkbMgyARn7mB+GQFeE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNrsFaHyX2DCtczC2vz9iJBIVy/eLSdmqYwGU7yocRoRgrY27MO6tWRC/sRQOYbTs7uYA221mxCZx70loulUFeT89dWMbM1yAMa0SD3BxCkyZqyC5uV6O1pZ8sx85O9qQ0xOjroU2cjzbLsVq00cg/3x800U/Owb1bb8Vid1GV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pcm6Ezwm; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnrmVLGdCMghCb3vDI+o+eKsgxKRNx52WcD1E+xSphWfhcdoIZ8oXSG7rLmpLJ5/WJVT4y4eVX5dakqHOvjeW7DeDqYL837PYmJfl1r2HXLCgkeM0Z0PSaVy6fYCwTiOynb2nQZVUJh+gTfBZQYuPbSOr7QNtObNnu4nZfLvouV6aLxrbQshJ81Rc6+tQeF/8mwdCy8JZ9Y8e5tf9sADet/grp33yEPu+e75JgWSwwuwI0FBVpmLn2p1lXIhkEwSi0M2p++UgZcViS6iwxbkRbk/y5af/vtBX78mDhn07gBJrAtqa/wsIz9AUG3vIZ6E7jFzg+x+ZjUKQpDWE4lwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zva29k1nSlCWjfTgCiddSqQ3GxFJDCpYa0KDPsavR+o=;
 b=o4198ZdE+l2hCizyG+0COAwinNsh6p3nfQEy47wnmvE0BgVVq34Rkn4xah0VdBhhaTNJj/JpB5K5SdFTD1FQovMOf7AdAQhqJb6s4W9hm+VDTp6JeP8VNEK7TZpQHkhrHARZ5B0YuoLl1jtaxcLye0gbs5jD/FhkyVaySLTlwZzkWs7eIn9XM/u6uIZcGOV819ZSboD2IrNhU6exAKJ3UaFXNx1No0tGVUeJ+RVeUkolSwrCvWZN2pqhggH778kXlhWxcjgZC3n9dE6br897uditz5VT+G9vXSs795nhhYnESF7Q9Un52KMGRufbiz/D0T/hIWR7u1QGVtEQ0cf+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zva29k1nSlCWjfTgCiddSqQ3GxFJDCpYa0KDPsavR+o=;
 b=pcm6EzwmiHQ8Yn+Ay3wwBBK1nRb7Qdhj/LwoJ1UI6Aipjq1jMWL+ZNePxfwqifKSB0gfqRwJh3Oj7XkOsSSHX47IgHiJJ1R6f/I/KRIWpIxvGl1TgZUEADR+X1esi3GYDCaxejocQ4Fo0zxUPIjYan0QmVFhPu/gOhYx3X2TmNbWW+8BtBZm4pPuADfxPWAmy8J8ZbUM/A/ALkNfF14Og2TyVfT9jQ58DUVZaVePGnIGotZd3sebYgrT1oTPlAZb/zfujBf2PQZsKOhIcbvhwRcg7LibOw2Ip98BSVlGXpACUA9oeXRwPDiORnNym0C9olRHLM0y8hSN2FFJaBn7cw==
Received: from MW4PR03CA0245.namprd03.prod.outlook.com (2603:10b6:303:b4::10)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 16:08:03 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:b4:cafe::58) by MW4PR03CA0245.outlook.office365.com
 (2603:10b6:303:b4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Thu,
 9 Jan 2025 16:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Thu, 9 Jan 2025 16:08:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:40 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:39 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:07:36 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 13/15] net/mlx5: fs, add HWS to steering mode options
Date: Thu, 9 Jan 2025 18:05:44 +0200
Message-ID: <20250109160546.1733647-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250109160546.1733647-1-tariqt@nvidia.com>
References: <20250109160546.1733647-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: de6929a1-c08a-49eb-d295-08dd30c7cbda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mOww++Eau5ZR9gGxi/Q++VGk9c41UIc3k3GyTLEyZjW/4JRcEu2Y5QQ1ZNjE?=
 =?us-ascii?Q?AzizWg7uGGUwUGNus8K7DqMdOvHu4E1cHKWJTKiKwK6FpwKFgGAqUyhs8kGF?=
 =?us-ascii?Q?L3cy2hEniNAf4wwpMrKbRqRnGDzu0YxMl44ZyiiQNQ0kBuaAoUCeE3fu8B+K?=
 =?us-ascii?Q?ygeYZa6SRhaL9wizx3IwEGvvmRHoDu7hCaruAV3ig6hjOZrr9i+HhNX5gOOr?=
 =?us-ascii?Q?Hjx1IS+7+qVvP/tt0gqYtt6Pd3H/qneY+OKeRvy29sajs86rLU0JhMILCPZv?=
 =?us-ascii?Q?rSIvXir+wubdqi1DQYrghokcBnTns+cHzMa3CYW4Rpmj8UBrgmL86Z/7m6Hy?=
 =?us-ascii?Q?tfIK1C5ztpXTHhi5oWTbKybmkVYTnDcmmBvxDBf2T4g1NLr6pJKcKNP0+0eE?=
 =?us-ascii?Q?1WsWQFxQJn4WJ7wJ3UR1JtDZ7BNvn8YR6ze+P3KuajOn6kP+MIEcdZK9hKQX?=
 =?us-ascii?Q?i3ZsFYoSUffGTBpKL/Ddc+4bobXVMDO/oMza71w8Ee6lHNCJL8w2cybwQgWk?=
 =?us-ascii?Q?7OOJ5sdSpOPN4yjSyx0/LmtVaWvCetyS9GU7zGpZvrwPIuS1xYBm1Js3AtEb?=
 =?us-ascii?Q?gi1VjNjZzzZItv0X6i5dPIPW+X0YtztBcUjmohzi06oqrRNLUsS1uaZLqfmO?=
 =?us-ascii?Q?kakeSk9XXmSzmqV+uxOxW10UB9WY+a5xiwboVPJwkglvXNxO2RYAObMwuGI1?=
 =?us-ascii?Q?XKDCAGzPhFGpqQ1MJcqBMCo2U860ioBJR7TcHcmXZpnWMEP7YyygvhhM4WiF?=
 =?us-ascii?Q?z6G6s+tnI2sdtWNGGFsQTTpVFBxeqFNDF9SaWtgDMJWlkOt4iKZIn1VR7V4+?=
 =?us-ascii?Q?InXFBfCH4u0r2cDnBwZS/PT/Ku+3jT6TOENAU+8ctyWl2OFux5v0cdXSWegh?=
 =?us-ascii?Q?AhyEW3S7XvbB8ZN3zrOej4qMUDiqB1REnu9tEZdnt1eqMMsDjGur6Fv3jaP4?=
 =?us-ascii?Q?UCOh/ctFmx5dGOlKDRcYa4LIQbpvQJVJIqFsGm3k3Dglh+y8GWYVUVURNMiQ?=
 =?us-ascii?Q?CJeXZD0cPaIVu9i/rgUFG92MvUqd4hDXYONv2dV2XHzBddeSSziTxPhXgCkx?=
 =?us-ascii?Q?L2ND9eokLDlOBWLA6pB4cuXRADOJyQscTV3jRRVIloD1ai/nvILzHQ0Cc9cM?=
 =?us-ascii?Q?9i9M/ck146xPujC6UwH0JPc9hbqxgc7qv/4Y2GPz62n70qw3ZBhg+XN5OUZX?=
 =?us-ascii?Q?7Kit4ziMJKFOGOmTX+vmRMVIzaxFjYl0b3Up2/g1bQ/8up2VfJnP+A/rAK66?=
 =?us-ascii?Q?U/PSdjS8ohrQMUFsxVapenOMJ/gUBMc89rr4nrS6bpaeNaHICw0O75OmzOGN?=
 =?us-ascii?Q?jws0YDeBOG+wUjSwSZQ652csnf38Smn3Tl2AlJ1chAoMsjdzDVVlMzODgCBx?=
 =?us-ascii?Q?6ouf2okkJQS7XLrzDjAA1zmllA+lu/qM3JZdhU1BZrQKVCsh97NNFxd/1ws/?=
 =?us-ascii?Q?9ACfFpSmrT2NqNAT35uC92ZglcfNjZY9wAY4srIj3uid663OYIXpiQY7DN6m?=
 =?us-ascii?Q?K3JjOPD1ADpwlso=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:08:03.1656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de6929a1-c08a-49eb-d295-08dd30c7cbda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795

From: Moshe Shemesh <moshe@nvidia.com>

Add HW Steering mode to mlx5 devlink param of steering mode options.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst     |  3 ++
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 50 +++++++++++++------
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  |  5 ++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  7 +++
 4 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 456985407475..41618538fc70 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -53,6 +53,9 @@ parameters.
        * ``smfs`` Software managed flow steering. In SMFS mode, the HW
          steering entities are created and manage through the driver without
          firmware intervention.
+       * ``hmfs`` Hardware managed flow steering. In HMFS mode, the driver
+         is configuring steering rules directly to the HW using Work Queues with
+         a special new type of WQE (Work Queue Element).
 
        SMFS mode is faster and provides better rule insertion rate compared to
        default DMFS mode.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 41b5e98a0495..f43fd96a680d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3535,35 +3535,42 @@ static int mlx5_fs_mode_validate(struct devlink *devlink, u32 id,
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	char *value = val.vstr;
-	int err = 0;
+	u8 eswitch_mode;
 
-	if (!strcmp(value, "dmfs")) {
+	if (!strcmp(value, "dmfs"))
 		return 0;
-	} else if (!strcmp(value, "smfs")) {
-		u8 eswitch_mode;
-		bool smfs_cap;
 
-		eswitch_mode = mlx5_eswitch_mode(dev);
-		smfs_cap = mlx5_fs_dr_is_supported(dev);
+	if (!strcmp(value, "smfs")) {
+		bool smfs_cap = mlx5_fs_dr_is_supported(dev);
 
 		if (!smfs_cap) {
-			err = -EOPNOTSUPP;
 			NL_SET_ERR_MSG_MOD(extack,
 					   "Software managed steering is not supported by current device");
+			return -EOPNOTSUPP;
 		}
+	} else if (!strcmp(value, "hmfs")) {
+		bool hmfs_cap = mlx5_fs_hws_is_supported(dev);
 
-		else if (eswitch_mode == MLX5_ESWITCH_OFFLOADS) {
+		if (!hmfs_cap) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Software managed steering is not supported when eswitch offloads enabled.");
-			err = -EOPNOTSUPP;
+					   "Hardware steering is not supported by current device");
+			return -EOPNOTSUPP;
 		}
 	} else {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "Bad parameter: supported values are [\"dmfs\", \"smfs\"]");
-		err = -EINVAL;
+				   "Bad parameter: supported values are [\"dmfs\", \"smfs\", \"hmfs\"]");
+		return -EINVAL;
 	}
 
-	return err;
+	eswitch_mode = mlx5_eswitch_mode(dev);
+	if (eswitch_mode == MLX5_ESWITCH_OFFLOADS) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Moving to %s is not supported when eswitch offloads enabled.",
+				       value);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
 }
 
 static int mlx5_fs_mode_set(struct devlink *devlink, u32 id,
@@ -3575,6 +3582,8 @@ static int mlx5_fs_mode_set(struct devlink *devlink, u32 id,
 
 	if (!strcmp(ctx->val.vstr, "smfs"))
 		mode = MLX5_FLOW_STEERING_MODE_SMFS;
+	else if (!strcmp(ctx->val.vstr, "hmfs"))
+		mode = MLX5_FLOW_STEERING_MODE_HMFS;
 	else
 		mode = MLX5_FLOW_STEERING_MODE_DMFS;
 	dev->priv.steering->mode = mode;
@@ -3587,10 +3596,17 @@ static int mlx5_fs_mode_get(struct devlink *devlink, u32 id,
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 
-	if (dev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_SMFS)
+	switch (dev->priv.steering->mode) {
+	case MLX5_FLOW_STEERING_MODE_SMFS:
 		strscpy(ctx->val.vstr, "smfs", sizeof(ctx->val.vstr));
-	else
+		break;
+	case MLX5_FLOW_STEERING_MODE_HMFS:
+		strscpy(ctx->val.vstr, "hmfs", sizeof(ctx->val.vstr));
+		break;
+	default:
 		strscpy(ctx->val.vstr, "dmfs", sizeof(ctx->val.vstr));
+	}
+
 	return 0;
 }
 
@@ -4009,6 +4025,8 @@ int mlx5_flow_namespace_set_mode(struct mlx5_flow_namespace *ns,
 
 	if (mode == MLX5_FLOW_STEERING_MODE_SMFS)
 		cmds = mlx5_fs_cmd_get_dr_cmds();
+	else if (mode == MLX5_FLOW_STEERING_MODE_HMFS)
+		cmds = mlx5_fs_cmd_get_hws_cmds();
 	else
 		cmds = mlx5_fs_cmd_get_fw_cmds();
 	if (!cmds)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index ccee230b3992..05329afeb9ea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1344,6 +1344,11 @@ static u32 mlx5_cmd_hws_get_capabilities(struct mlx5_flow_root_namespace *ns,
 	       MLX5_FLOW_STEERING_CAP_MATCH_RANGES;
 }
 
+bool mlx5_fs_hws_is_supported(struct mlx5_core_dev *dev)
+{
+	return mlx5hws_is_supported(dev);
+}
+
 static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.create_flow_table = mlx5_cmd_hws_create_flow_table,
 	.destroy_flow_table = mlx5_cmd_hws_destroy_flow_table,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index 9e970ac75d2a..cbddb72d4362 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -60,10 +60,17 @@ struct mlx5_fs_hws_rule {
 
 #ifdef CONFIG_MLX5_HW_STEERING
 
+bool mlx5_fs_hws_is_supported(struct mlx5_core_dev *dev);
+
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void);
 
 #else
 
+static inline bool mlx5_fs_hws_is_supported(struct mlx5_core_dev *dev)
+{
+	return false;
+}
+
 static inline const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void)
 {
 	return NULL;
-- 
2.45.0


