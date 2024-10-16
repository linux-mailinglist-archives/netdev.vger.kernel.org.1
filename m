Return-Path: <netdev+bounces-136209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86349A10C5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9E91F236EB
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED55210C25;
	Wed, 16 Oct 2024 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cT163/T9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00A18660A
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100253; cv=fail; b=QYHG9V/dE+A2mWS1ZJSL110xHBuqEuP/l/UmfPSlYAbTxugyZpCuqEljDE7ZtAVUbDr5z0hQnSnlfRIzf5LnHEXTUP2qSkUgKc+RbeFsha158fnLRjjS85mnaWdac1dp78SgHVjk56nkMEp1c7q+Y/puoUfZjdLrZxR7dn5X9co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100253; c=relaxed/simple;
	bh=weMCZS39IOKCF+hKMXNbsD+dX5AKEe6J1hDxl+XqDLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUOMr7U1J4YKLjETimkNfcRUbi8s/843txl/MfbyxCdsxWmb/DpHgVHHryNJWy/RoRYRirc3j7WWFl44E/NEroCb+yBGP4OH7W9n2q8D8sT6F+GyHklq31VZzmO/wcTsc/8tIeL+C4h90U6pSrej7Ytrv620lXmwNXyct+FyCL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cT163/T9; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1ISkfruHk4rlChBlrxNyupG4299URBEzY0rJCVe9sJqiHgtwzbTWIX/HGBFfW2yfWh9BHMvYR4F5VstOvQHTgGIDbueeDNrvahG2ORCX3B5EhmWUnbybD4W/Bqt5LIls2OnzBgsevSWyZ13FOBWz5dEBpIQ1oue2sS7l3A4dcMgUOycHWLvwxT/ouyY0PBeUW3oLSI7kEh8no+humD2EeSKtMmZnj30ppsoPfkStUHtJn1YwIEX8ICqK6u7FOvFyyFWbeeB1CjqDdxb5Cp7Sj4Wk3SrS4lrkHDYW4/gjeqvl6K8VwxzVfzNiLIeE5hC5TG/YLRZdW+9u14JBwbS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5bCgS1PIpHXIzENYErpe9PopDJLKHrzX0iMvdqJ5+E=;
 b=u4nf0tXXdx2Olia+X7zHLpj+n4FqOsV0ltXXnRgqHLlAFW6r4gdakLrqC+31MQj3B8ORM3CfbgrC/KktCr8GKtyLSSFt9umoPD8AY/UtkE/ZCEtDXIVBrJTLcdrSHcDLuk9bDsABACKT9oD0fdSOGXlNKt5UYryC8+HKtazrUMAmu2slMKYBAq5iGxFU1Kwv3OYjoFqmm4BSRS5uF/lQYaIfv1EnT4mrbr39+i0zDSM4uCAeLbDj21mkIvDD3xmaA589ScaDErMU0wlmjEJVdD/KwrTL7ilMZs8JbgMsgH5i8br7xprcBHm0fmcbKPy6V02sayoII/sYmGIpeELtPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5bCgS1PIpHXIzENYErpe9PopDJLKHrzX0iMvdqJ5+E=;
 b=cT163/T97Omrdstd8fD8d1YKBzFli46qEw3E+RHjNkOhHJUL3PhuuVx4XpjbHPWptX6KkC/EuZErWZufnW77qzAbADNpwac7jheYcVvwaUz9Yu58Re6okK3FPlowLPQc2VGgw4rxj4xZ2CSsaCVrkGsdk/82FD7oSiXHV8h1bBsaZrEncVmo5gVpu78O9CfL1Yh6Om9HEiq2BMipAnJK1Wk/tCqOU1uXHyyTPo2GWmNLjI+/W+1kH8DaGq0WpR4qHpt+/Y+CAxK3pnixkye7MoeaWJuBJIg+BsbeEUfgUuehYMlMY6WcsRr1tjibvQE23QW/bdmwRoPm1dLgxApy5Q==
Received: from BN9P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::21)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 17:37:23 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::e5) by BN9P221CA0027.outlook.office365.com
 (2603:10b6:408:10a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 17:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:37:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 01/15] net/mlx5: Refactor QoS group scheduling element creation
Date: Wed, 16 Oct 2024 20:36:03 +0300
Message-ID: <20241016173617.217736-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 01af8ba3-4d9a-495c-ddba-08dcee09314b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0QrlJBHxv62I1IqXKNLewVYgBoQz3vDSYnlhCnPwnN00f1YQNA7mZIFs61qi?=
 =?us-ascii?Q?SSAw4jwFtTdiJ2wbrLl4NNQKWz1RGAHv8z4/6LXEHOV1QCh/z6sDLIOzqrvl?=
 =?us-ascii?Q?aopGV4jVdhJcZBEILttmJz2ZdWuhJ+u43nelPy5gvV0O1zc7YrBWP91/y0RE?=
 =?us-ascii?Q?2aRKrep3bPnFrKH4BOpDTix3qgqBiQ3L7+RgQiz59MmmgHMtEfxRBmSizCJA?=
 =?us-ascii?Q?P0aRVKHzbHoU+X6to1qiC7YG8iOJhwMMP9UfdaCgTiX+B6ey2ksPezWwJ6U+?=
 =?us-ascii?Q?mk8VM30+DBx1C7mCKpBy3DEO8mTOK9jAySu4cn38e/1F8WT4uwkNRiTcnGOQ?=
 =?us-ascii?Q?59JfmozMX100vf+9I230WN3RsJ9kycQf1ifUL3tgvpqmmEw4WCmAqwBihByW?=
 =?us-ascii?Q?1SgbZ/VjKhmcSy6Iwes8xQEivY2Iky4YBQUDT6NkY5ErdY90JWytnnWNqYjO?=
 =?us-ascii?Q?r/c2uf+LeAhT8d6wmcIhmXJa7nIpqUimVDnwdH21nClhe+ZM2NTF6rFPWDE4?=
 =?us-ascii?Q?YpmgK0MnSAZ57qwlbssIQ12fUskoZsxY0zbPJ7A6Qct6KShJn6hSYyE0ppmX?=
 =?us-ascii?Q?yF5m9+9IRriREjKSHNIMGhEtYp8BY15Bu2E4Uz5CNapfMNzIl8Y1vcDZjkWK?=
 =?us-ascii?Q?GdA88SUZhiAsIYZ+KWBqQWzuwSZ+2/w3rKOt5PqhBH0hwTO5cL8FPR/Sy534?=
 =?us-ascii?Q?0RTokotND17+5v/skYmoHe9yBwlloQm5kUqvKdDQtZsYRb0CN7kmasNeqQZS?=
 =?us-ascii?Q?l73Z9P/zkHagsfhkNP68QED9w76el0ccGME6pvPiIC+6QTgmifj/SNUqo5fp?=
 =?us-ascii?Q?GCo9vMrZZ8zKtPHqYSmE1UWHq0CTwQUSLSaZzQZecW9Bn7Lj8ip/SlPk2KMZ?=
 =?us-ascii?Q?UvMfH5+I4vxCuU7SJebDKdjeVhlWMN/bIVhkxAMKqZFA2kH6PzTFsYEtTdmZ?=
 =?us-ascii?Q?bK6t/ydHGijIW+T1u6TGTrSikYey31DtHpveC+PZPfGwYxA0at9DrQryMNlM?=
 =?us-ascii?Q?YyaWi5Xip2GYKhe4LwCIiozxXJ5p1PV7xMCYhxOn83BJ9BzoYzkR5VU/aQZa?=
 =?us-ascii?Q?q8EeGUSy64HGjWNbYWDh3Afa5XM+sXWpjNKJItg/hOcn8yDTMCDi74D3IBsk?=
 =?us-ascii?Q?kv05I3KH9EZ6Tn0xOqsxXj9VU4BvBIedAuAUJji/aXROImzaM4l74lNB4ffQ?=
 =?us-ascii?Q?lEsJJr5l/aDPCjGaQOYlCuy1qAe0i0toK/uo6cxsV4R+5OPcAZVLLN82hYRK?=
 =?us-ascii?Q?M0+p3HsBNNhSeFMRhMvD1Cn0aqEHtgMu40h/2EwVD+IdKPpd/I+tDR1bagJN?=
 =?us-ascii?Q?9AGXjx1sn2rd1XjDEJSXtRgX6+hNbgRX95SBEOpBvbNjKJ4OhAZRNylDNZVs?=
 =?us-ascii?Q?O3lOQscnWYPU6NdoCN/1Ap5JJpkC?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:37:22.6908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01af8ba3-4d9a-495c-ddba-08dcee09314b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `esw_qos_create_group_sched_elem` to handle the creation of
group scheduling elements for E-Switch QoS, Transmit Scheduling
Arbiter (TSAR).

This reduces duplication and simplifies code for TSAR setup.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 64 +++++++++----------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index ee6f76a6f0b5..7732f948e9c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -371,6 +371,33 @@ static int esw_qos_set_group_max_rate(struct mlx5_esw_rate_group *group,
 	return err;
 }
 
+static int esw_qos_create_group_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
+					   u32 *tsar_ix)
+{
+	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	void *attr;
+
+	if (!mlx5_qos_element_type_supported(dev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
+					     SCHEDULING_HIERARCHY_E_SWITCH) ||
+	    !mlx5_qos_tsar_type_supported(dev,
+					  TSAR_ELEMENT_TSAR_TYPE_DWRR,
+					  SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(scheduling_context, tsar_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
+		 parent_element_id);
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
+
+	return mlx5_create_scheduling_element_cmd(dev,
+						  SCHEDULING_HIERARCHY_E_SWITCH,
+						  tsar_ctx,
+						  tsar_ix);
+}
+
 static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 					      u32 max_rate, u32 bw_share)
 {
@@ -496,21 +523,11 @@ static void __esw_qos_free_rate_group(struct mlx5_esw_rate_group *group)
 static struct mlx5_esw_rate_group *
 __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
-	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_esw_rate_group *group;
-	int tsar_ix, err;
-	void *attr;
+	u32 tsar_ix;
+	int err;
 
-	MLX5_SET(scheduling_context, tsar_ctx, element_type,
-		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
-	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
-		 esw->qos.root_tsar_ix);
-	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
-	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
-	err = mlx5_create_scheduling_element_cmd(esw->dev,
-						 SCHEDULING_HIERARCHY_E_SWITCH,
-						 tsar_ctx,
-						 &tsar_ix);
+	err = esw_qos_create_group_sched_elem(esw->dev, esw->qos.root_tsar_ix, &tsar_ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for group failed");
 		return ERR_PTR(err);
@@ -591,32 +608,13 @@ static int __esw_qos_destroy_rate_group(struct mlx5_esw_rate_group *group,
 
 static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
-	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = esw->dev;
-	void *attr;
 	int err;
 
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	if (!mlx5_qos_element_type_supported(dev,
-					     SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
-					     SCHEDULING_HIERARCHY_E_SWITCH) ||
-	    !mlx5_qos_tsar_type_supported(dev,
-					  TSAR_ELEMENT_TSAR_TYPE_DWRR,
-					  SCHEDULING_HIERARCHY_E_SWITCH))
-		return -EOPNOTSUPP;
-
-	MLX5_SET(scheduling_context, tsar_ctx, element_type,
-		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
-
-	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
-	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
-
-	err = mlx5_create_scheduling_element_cmd(dev,
-						 SCHEDULING_HIERARCHY_E_SWITCH,
-						 tsar_ctx,
-						 &esw->qos.root_tsar_ix);
+	err = esw_qos_create_group_sched_elem(esw->dev, 0, &esw->qos.root_tsar_ix);
 	if (err) {
 		esw_warn(dev, "E-Switch create root TSAR failed (%d)\n", err);
 		return err;
-- 
2.44.0


