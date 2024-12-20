Return-Path: <netdev+bounces-153620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E19F8DCD
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AEE1894F0E
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFE513635B;
	Fri, 20 Dec 2024 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AZRCGoMD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185DC154BE5
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734682582; cv=fail; b=WTQa7LF+Rp7aMPs39FmhTSaHyyeDo6vu/y6637rBMisrnZoPbdSI1tKcFPnc1mURLeCCcuHpO+sS0X8Z7lb+1ynVlLnLJDznBw2T9otIG7+DBdBHXIc81/M++wY2R/aPMhKG+MYEFr0gpb7JgdELxcn0/n9EwAtmJIKv74rcf+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734682582; c=relaxed/simple;
	bh=Ak6zrSsUf94yvHfXiQSQeB68gcBnkm3iO3aTMVUfXJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpgVmQ4nXnMiZGJE3fwQ7LTN4nn1BpRRMw/tHKkf29J309PSeYJKmlitmkGapHNmoTo+PwjFO4/03qOuD4jX3KagEH2UF9Y8bGsgtLHZsY1r5kz0UJ/QEMZlQxltEkDT7reU0T+jQe/JN0+vcFFhmRXe00qDTiHUgdes+3GhfAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AZRCGoMD; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fnr+FuNR/nDHrjovCBXkkbkHuLMO6P5RE5dO8CwSaLD4bDiMSdJoss14PMpwNykvUGeNFzZ1/zUpu/p8yRll/OpIzx5LzjgUwv1iXR/NGxeIbFUwkUPIrZ/XkrmDBe+oiwatYjboGb+jkplKh4yH+iiRKZQKk8rztBsBGk5mxH4699DxG1SUBYgQFPaLdt77/eVXwh7UhSMCcIMxaHFAHDIvbwwT2NdrQXVkJu/VQvNiHoEwjKx0HeM2RqpazXuKe1v4Jn0clpzL1nbg8/sQoeF9Wahu6GpAD5G2E7OeqiQ6eEio5PuAAXnD+yrOzfMhdNzFRJWswGfLDFrZ2+dHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsCdMxpU3AKYUQoumBmM1rrQF0gwWWYzejWGc5gGmaA=;
 b=CyuE8D+6oprsxirX0VCeno3khWOsXsZ4M5YU3m83W8yDi+4rPLr4A5ewlphZJavNCDaQsJRuYqdlV9EQ2lmbn0YsZgLkY7LA1IptQjL5lT9kHh4e+/6HkFRm9iql1lgUTQq7AU9DW9NFef/durSUsJjfLtPk2AXV9Qz3tN8iG7OWGX/scN6TL0qhErRJi+yhJWMusxwnYfgPVFxwSlqeRj3riXLRIIs2F+b3QQeT1ldCK2Zu5gqMN3ZWvv0qiRJWwecI5H7GqunDktwNuznoxWdcp5kEfJmp5ZQpBnkneFOD9yulpgzw8fIt0KPYTrgLz2ERQoU+NrvOPPm+RZsYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsCdMxpU3AKYUQoumBmM1rrQF0gwWWYzejWGc5gGmaA=;
 b=AZRCGoMDSwEZWmz2R4murlaO8nLWLqCLwjK2D3krck4ZMBUzYc49A8TVZ1e7i3MDx3fAd2ZP0UPX4s0GqBfEIz4EmhZLeKkZan4w0Lt0M4zLRsEkEBWMFZWiFAiQKJk+L70ywntvGTj0Sfiruxcf3wBMnHikZU6hO3SAXRY2sJu0MZdeM3QVCRhcy8RgLxtpl4BJbnawzeXjZqfiAFmRdNehs4fBPIz2Eq7z3975D7pGBN1mIw7ZraFR0PmywDikGzSyeH9gYxMnwxxVRTOO3uTO7rMgXT51Fs8KlSh//c1Pd8/omhjyptXSHp0KryEi/F0jfcCyqz7KIgbWZTZUYQ==
Received: from SA0PR11CA0024.namprd11.prod.outlook.com (2603:10b6:806:d3::29)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 08:16:11 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::86) by SA0PR11CA0024.outlook.office365.com
 (2603:10b6:806:d3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Fri,
 20 Dec 2024 08:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 08:16:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 20 Dec
 2024 00:16:01 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Dec 2024 00:16:00 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Dec 2024 00:15:57 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 3/4] net/mlx5e: Skip restore TC rules for vport rep without loaded flag
Date: Fri, 20 Dec 2024 10:15:04 +0200
Message-ID: <20241220081505.1286093-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241220081505.1286093-1-tariqt@nvidia.com>
References: <20241220081505.1286093-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f26c80c-7131-4026-59a6-08dd20ce900c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N9CPl0WllPtkSSOLxrlEMv0ARWKd5bokGGyV6GsFaprbVneeLb43YH9jVe7G?=
 =?us-ascii?Q?RHdnXRZhNQSFlr//LY8LTKU8GC32NlwxBqcA5fjKA/EFV+z/GJCc2YARY2TQ?=
 =?us-ascii?Q?5MOq+SluS+w84AWV/ST1w6PuemRmIu/kCyHTWbZIqy8+Dp19YeCVVEcex/nw?=
 =?us-ascii?Q?5HuHjZlAZUkw4LQDHoctzUPJzm7gc0ZqorD3vHYpDtkJS3ep9EeKPyBXshKi?=
 =?us-ascii?Q?VbRo7HULgCUtQBAtwozh/AVUoAZCQUbDxz+oAJWdA5A9IRmdqpu2c2V5W56y?=
 =?us-ascii?Q?6WcKsvgdoea7JSiEot7c6FNw80iutfN6d/7VjWDpJzzu4K25bwTTlrKdQSbQ?=
 =?us-ascii?Q?hHfVkP6etG4Dh+7Hhud8xklFJi+GtF/20wpX34fWeMdCZOEsTBooBW9fIm1m?=
 =?us-ascii?Q?ExQA14gOwgrZ7IGxQ6q7+3WEczDoBrlyhtQxw+VECdYLmexdQ7GC1ZMnnpkm?=
 =?us-ascii?Q?v610QhdZN7VD6dcyLmZCdi3eBbX4X9lxHmTOBbVYmA/931UXUiVDj9XlylHH?=
 =?us-ascii?Q?FODi3Bvm17WcYVtnmRQkT8ScdRM3u71ZJ8TGcMf49rUm/0MOjG0MFWL1/gji?=
 =?us-ascii?Q?/kS+1N86xRuwzWsz3L3UgqlcMXlkecwhwUNUiLrBiQgqh/ySyUiSHQVRdJ5p?=
 =?us-ascii?Q?pYL1Kq9vQGNaaalY3OIheeX8v/8X2wOFU/L+o+9vAaBUthBBID5tXayjLa4d?=
 =?us-ascii?Q?cTppGKKeCR0UkDMjmRn7mztCWvySTTM93vQo/UNIqcwSUkZr5a4fi5fIbbLh?=
 =?us-ascii?Q?9YBo9qd8tdPYtDljmqdFgZH7LXBHHd7XJ9Beiexb/xkttXqSC0iLksgeuCbJ?=
 =?us-ascii?Q?Den1cDEh3ZgFpb3Z9dG/crgY/nyylFfV3Q2qdiwXQVoOucpKWgkq7JH0WyEg?=
 =?us-ascii?Q?I3GvljmWi1PVI2BU+XjMAWEdJOeG9m+5F9+HW7haVDsO+Mgo/2kY8mO37Urn?=
 =?us-ascii?Q?R13detQzlBsu4e7Lq3YB6g43fnZvtgOvyyRL0EzBTwvt/3uZYgbE8/o1G/mC?=
 =?us-ascii?Q?5lf52s1S0j9sTeuCWj+yZLjRd9pyT7HFLX4IrVapE5lOGLZkxJYjZ5LWALaN?=
 =?us-ascii?Q?zNklcTMDO9bjM8AL7M5VerGRauKEGmzQH89nY0TJ8+37lTsDYwtmHI44ipBO?=
 =?us-ascii?Q?JzrfLsjnwnKBeuBhnKqx2vDXPpxhTLf1emQhn3AO7rtq11qnHFFMp2/p52qK?=
 =?us-ascii?Q?i2iDiwpdXGV4LxIU+kz/FXcqoVCCJRBkroBi+ANzKJ2ZNaWs2HjZD35bpi8q?=
 =?us-ascii?Q?0o5Ff4hPmj4WyapjIeMwi08OduMi2kvunYvLmPObHtsfO2tFr30+EvBwr3wV?=
 =?us-ascii?Q?Whhc30Yj9e7oW3hi2QVK/eeMzjXUwN+L8C/pPAZbhbY2HqeTm4GnmObJrHsl?=
 =?us-ascii?Q?48KT8oYa3NBrrc8SfyX81Cmm0eOYuaZ2UByppVndouUMo2Sef0o0Ry7hiz+Q?=
 =?us-ascii?Q?W0rcJ/PK0lBnz2U5Xqy77F6PZbHq3sCE0fHJwiDDC2ZK3xo5wEzesOnSHzZj?=
 =?us-ascii?Q?IBwACvZ9Xjg9HAU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 08:16:10.7308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f26c80c-7131-4026-59a6-08dd20ce900c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494

From: Jianbo Liu <jianbol@nvidia.com>

During driver unload, unregister_netdev is called after unloading
vport rep. So, the mlx5e_rep_priv is already freed while trying to get
rpriv->netdev, or walk rpriv->tc_ht, which results in use-after-free.
So add the checking to make sure access the data of vport rep which is
still loaded.

Fixes: d1569537a837 ("net/mlx5e: Modify and restore TC rules for IPSec TX rules")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c     | 6 +++---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h          | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 3 ---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 5a0047bdcb51..ed977ae75fab 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -150,11 +150,11 @@ void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev)
 	unsigned long i;
 	int err;
 
-	xa_for_each(&esw->offloads.vport_reps, i, rep) {
-		rpriv = rep->rep_data[REP_ETH].priv;
-		if (!rpriv || !rpriv->netdev)
+	mlx5_esw_for_each_rep(esw, i, rep) {
+		if (atomic_read(&rep->rep_data[REP_ETH].state) != REP_LOADED)
 			continue;
 
+		rpriv = rep->rep_data[REP_ETH].priv;
 		rhashtable_walk_enter(&rpriv->tc_ht, &iter);
 		rhashtable_walk_start(&iter);
 		while ((flow = rhashtable_walk_next(&iter)) != NULL) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index a83d41121db6..8573d36785f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -714,6 +714,9 @@ void mlx5e_tc_clean_fdb_peer_flows(struct mlx5_eswitch *esw);
 			  MLX5_CAP_GEN_2((esw->dev), ec_vf_vport_base) +\
 			  (last) - 1)
 
+#define mlx5_esw_for_each_rep(esw, i, rep) \
+	xa_for_each(&((esw)->offloads.vport_reps), i, rep)
+
 struct mlx5_eswitch *__must_check
 mlx5_devlink_eswitch_get(struct devlink *devlink);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d5b42b3a19fd..40359f320724 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -53,9 +53,6 @@
 #include "lag/lag.h"
 #include "en/tc/post_meter.h"
 
-#define mlx5_esw_for_each_rep(esw, i, rep) \
-	xa_for_each(&((esw)->offloads.vport_reps), i, rep)
-
 /* There are two match-all miss flows, one for unicast dst mac and
  * one for multicast.
  */
-- 
2.45.0


