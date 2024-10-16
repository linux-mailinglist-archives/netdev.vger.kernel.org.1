Return-Path: <netdev+bounces-136214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7579A10CB
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9412B1F22E70
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F33212F07;
	Wed, 16 Oct 2024 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jqqw2uF9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7214A4E2
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100275; cv=fail; b=FysI8VFWtkrpqLmTbiH2V6+XYTMcy1OahP/qd01QjYvv0aD0KMtzLUY6ODSgjQfdA4PgUeKmwxpJcJTNnjEn1wxLlRrZf1QY6qHgIj/NQE0fhhvg/CwO51SIqYYlPDlBcKJzoE/Ae7KebF49pu71UzMBYEq5hSIpACc6TMTBuiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100275; c=relaxed/simple;
	bh=MSWCVyeH9TgNYs5KvbJDVf1fdngaZ3o7bmwFc1BAmwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sm4r9vu7X9dPut4mUCr4/9/ASodd++6IKaWzatiQpmFD7yQDlyElbgOvlGtRdNvMll5A15CGG4AslYTkIIoIgbSnTmUEdLcoHokaI9ptgjBAMuTqTk0QtNDqZnrFEO9HxzReHqNqK4dBgai5pMmcZPQPGqhnYKcDl8pjkBSifSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jqqw2uF9; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joQ8EoCY3ZyySvZv5WIne/+xcQt+PYQh6pZqrJ0C/C3WLLqMjZec4GoZEB1VN3A8i2+J2JNRjL74GdITqNJhsHeMJLuZRHVmaChQzgaV5cY7r4yeDXtF6S/OWXJ0CwGZnG6K5lSh0wVpwYZ7l/XnwCnUyI17rbjCwmHInGc45ML8P/gPk1C+UeV0/m88HyOSjEk1EFNDOyBGPSAynu0R9fmGhufcg6l1MZaqs8PX+B4Gwq7lcbpqu6w5b5NVwWYfT0uw0UMWFruUZeORb0XPBqAhUJ/5X/iYXeedmjhyxTJfkDHS80yax2Gp6eVz0WaNC08KSsAL3SyYGPfuOlYHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raD33nTQ1NeIuENpL4ip3zm3qx/Byd/TA2TsWr/K8eo=;
 b=DL1M6Z7rKuD5MU1kyeVY2g8c60XM662tVZNdg74VsR7af0vGn8D7sqB0/xLFOEK3gdz72AqRwSG3A90xFD+/oLvVqIRBwjfOOrZDxNCOjWmgBPG4NDPKIVR+XqyVcuj1WIPMWU+PPItMfvNLZIkWmE8SlRi9alHby8lASYCUoRg7f8ixRDctMMWTU6x2ESgfeEPobqchnWTzLKgOwt7Z5WkYdSHinVKpm9xM/YaPMMPeK75/8PQPtQ97ztuT7xRCzX5Bndr87fInodb44kffrkvGlGYG2QUF72dhRElqIRBjLoQIQSZOspe66r5GvcOgNRhUw0UiAKJidE+L9JgmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raD33nTQ1NeIuENpL4ip3zm3qx/Byd/TA2TsWr/K8eo=;
 b=Jqqw2uF982TcYlsyoQjoJSsrH0rmv6chqc6rrN/kFuK/6MBZe9PaqUCGZYMKQsL5e3NdGX48/1YX10LKnmJ6At5MRpxo41mx+OFvfyFQU2MSonyipvHXr4up9oXmhy7igXjeFouJlGarcWPXZbRPdkpT1V7IOnstLFQWxCBgOcp0CTF58FteIrqgOvDTKTIn6Wh+18wwjkS2TARUZXsJeiSb5E02OmigaYaQ6MjJh265RqsFZb7iPhlx9mQTh5NujO9HRO4TFXWgzT4Mm2pw+/ZnUjTooXosz59srW3HrbUMNnlsR6YPY2buZyRbujyqb1PUxGuslUg7XTPPvUtShQ==
Received: from BL1PR13CA0140.namprd13.prod.outlook.com (2603:10b6:208:2bb::25)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 17:37:46 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:208:2bb:cafe::70) by BL1PR13CA0140.outlook.office365.com
 (2603:10b6:208:2bb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.7 via Frontend
 Transport; Wed, 16 Oct 2024 17:37:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:37:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:26 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 07/15] net/mlx5: Refactor vport scheduling element creation function
Date: Wed, 16 Oct 2024 20:36:09 +0300
Message-ID: <20241016173617.217736-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: e2cfbfb3-c107-4200-8887-08dcee093edd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sz62T5BNCAWPnBJB1XAcU7JPra2ANJVQosAPEuV1TonMjQyeBBtS94lg+eFV?=
 =?us-ascii?Q?nLfpBfdSIZ1GQAtG59atLtBBRhlHSepN8N23dx+Hi42W36jVsed9chTQyOKo?=
 =?us-ascii?Q?no76e0yaR21nTyNQVG+9CooJGKSgShsKeOMeOgrD++msHRQpHV29b/ZxVOfd?=
 =?us-ascii?Q?eTDS9l/zrhm+Co1i8l9X6ydqstBGG0sFh+AAPPpLO8c+9XWRwsNCGFjof7DA?=
 =?us-ascii?Q?zmG50oCfrIG5zfNaB/IS+vkthKr4rvm4dTgSYUSOwBubrBZUMBTY2CuawBPw?=
 =?us-ascii?Q?CijTLOlK2kwn79XtTS0TbAIfPrJMIskZ29FuZ13ccaKttKIE8zwZ35zMSxGS?=
 =?us-ascii?Q?mGxTtAzuKGVPR4vkfm+ETJXR2BFRTl1BASwGQwPIjnkc7uigekD+SjXYfghP?=
 =?us-ascii?Q?tt1+haTAETH+3pXiiDbQEVxzNBy9KwjSzCHRtbBGPBgY9Njf5Cc1bBFl0pvz?=
 =?us-ascii?Q?JEuMBF7pnV8GLSu9Z+P/C/TOfD7rNlWu+77Rg7hlud53DlQLcHev9h5CsFjO?=
 =?us-ascii?Q?jYeJTHIDO2suzc6Np/J0h84ONZ/vSqEEey9rocRZjEkSqPx8fBuNzYseJm2l?=
 =?us-ascii?Q?clzHDSQ/oKvS6mYZLFxoLDOKv9CgaJqWKJIMIMNIvJUUuDor3ueDsb7vV21t?=
 =?us-ascii?Q?W4yAzCR5Hj+lPE9rwJ8lI9Fq+CCLoJWetJgW4WU6esCsRbcmPdfggmDX4XBo?=
 =?us-ascii?Q?YBduuICSWw55QNf/2RQZ4awRUsTRKxed93+UpUVwlzm6am6o/CWsd+XZ33CR?=
 =?us-ascii?Q?Cw972xa6djb/4/ZMt/64OVvgEiciCC4Lh5r7v75MKljMaNiG4apqU4CBPo1M?=
 =?us-ascii?Q?O+RI0mGXrEMZkbk2oiySMwFQKw5DUW8puKLBPJvPhP36T1DzXsWEef7S7kAp?=
 =?us-ascii?Q?562gKm1jKzxOp2x4tPMgo5RU8b3XSP0RZSoVsYbkIN+w41sObI2vn+d1ydF+?=
 =?us-ascii?Q?tbyui/PX0uAA7Ho2wdykXgvUyAp5kU/6ObDEIHqgto1x1/w/8b3zCeZakXau?=
 =?us-ascii?Q?NPO1R6gSez8azqKLYW09znFtETITks94nKyN+YxwfrN3yeJTZKBz/MAAOVhK?=
 =?us-ascii?Q?fpVZ/GwF5nEaTqmg124blC9x3OvTHlqrc0ID44pQtCH5s3cBgw9uazbd5geB?=
 =?us-ascii?Q?cwa/I6CQeYt9JZhSudn2AgQLZ0rJ+EaYSod5bdejpH8fOpahVeKHHsGmzXc0?=
 =?us-ascii?Q?ZDseKcchl6vm8mk6IESSxVnM0u3ljJY+gNXysky4SsL3qxc0reTBGyWB0Zd8?=
 =?us-ascii?Q?q3Ro1suC8MPSKn+lvD/VN/5M/LCV477UKoGEKQ9S3WCEFoMZT0tgQvkmR+uY?=
 =?us-ascii?Q?9BtyHcV0hkwKCdROycV9YsJOpL+zRfc82IaaPMPd928fOG6Tnv5sd/IgT1iC?=
 =?us-ascii?Q?6yRr8cQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:37:45.4558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cfbfb3-c107-4200-8887-08dcee093edd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

From: Carolina Jubran <cjubran@nvidia.com>

Modify the vport scheduling element creation function to get the parent
node directly, aligning it with the group creation function.

This ensures a consistent flow for scheduling elements creation, as the
parent nodes already contain the device and parent element index.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 27 ++++++++++---------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 840568c66a1a..bcdb745994d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -407,10 +407,10 @@ static int esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_
 						  tsar_ix);
 }
 
-static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
-					      u32 max_rate, u32 bw_share)
+static int
+esw_qos_vport_create_sched_element(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
+				   u32 max_rate, u32 bw_share, u32 *sched_elem_ix)
 {
-	struct mlx5_esw_sched_node *parent = vport->qos.parent;
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = parent->esw->dev;
 	void *attr;
@@ -432,7 +432,7 @@ static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 	err = mlx5_create_scheduling_element_cmd(dev,
 						 SCHEDULING_HIERARCHY_E_SWITCH,
 						 sched_ctx,
-						 &vport->qos.esw_sched_elem_ix);
+						 sched_elem_ix);
 	if (err) {
 		esw_warn(dev,
 			 "E-Switch create vport scheduling element failed (vport=%d,err=%d)\n",
@@ -459,21 +459,23 @@ static int esw_qos_update_node_scheduling_element(struct mlx5_vport *vport,
 		return err;
 	}
 
-	esw_qos_vport_set_parent(vport, new_node);
 	/* Use new node max rate if vport max rate is unlimited. */
 	max_rate = vport->qos.max_rate ? vport->qos.max_rate : new_node->max_rate;
-	err = esw_qos_vport_create_sched_element(vport, max_rate, vport->qos.bw_share);
+	err = esw_qos_vport_create_sched_element(vport, new_node, max_rate, vport->qos.bw_share,
+						 &vport->qos.esw_sched_elem_ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch vport node set failed.");
 		goto err_sched;
 	}
 
+	esw_qos_vport_set_parent(vport, new_node);
+
 	return 0;
 
 err_sched:
-	esw_qos_vport_set_parent(vport, curr_node);
 	max_rate = vport->qos.max_rate ? vport->qos.max_rate : curr_node->max_rate;
-	if (esw_qos_vport_create_sched_element(vport, max_rate, vport->qos.bw_share))
+	if (esw_qos_vport_create_sched_element(vport, curr_node, max_rate, vport->qos.bw_share,
+					       &vport->qos.esw_sched_elem_ix))
 		esw_warn(curr_node->esw->dev, "E-Switch vport node restore failed (vport=%d)\n",
 			 vport->vport);
 
@@ -717,13 +719,14 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
-	INIT_LIST_HEAD(&vport->qos.parent_entry);
-	esw_qos_vport_set_parent(vport, esw->qos.node0);
-
-	err = esw_qos_vport_create_sched_element(vport, max_rate, bw_share);
+	err = esw_qos_vport_create_sched_element(vport, esw->qos.node0, max_rate, bw_share,
+						 &vport->qos.esw_sched_elem_ix);
 	if (err)
 		goto err_out;
 
+	INIT_LIST_HEAD(&vport->qos.parent_entry);
+	esw_qos_vport_set_parent(vport, esw->qos.node0);
+
 	vport->qos.enabled = true;
 	trace_mlx5_esw_vport_qos_create(vport->dev, vport, bw_share, max_rate);
 
-- 
2.44.0


