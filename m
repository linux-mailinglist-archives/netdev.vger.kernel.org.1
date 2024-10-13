Return-Path: <netdev+bounces-134898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054B599B89C
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40922826BE
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC1D81AB1;
	Sun, 13 Oct 2024 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HKrQtcQ9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA7977104
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728801999; cv=fail; b=KYuzYfCOgBr6j+du40/BziMO7+ewA52sBylTvN8DNv1yqpXuZJ0dg2AVGB6jnGjCC1d4UZQiMm7bO6e4E0P1HAr+8wYxPS/NXF5B7yGtW3Fc23qSBblkcsG8IShqZHhdCrfmwoeqF6yXsa3F79mUja03FnpQ1uK7ElinYKhDOyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728801999; c=relaxed/simple;
	bh=Rnq4iyNTofZy9Jiy6ETVHtyLUkx10eu7u2PaFmM6zZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MamzGprjnAhCearD15vRwV79HBjfZO39896g9dSUa/QCahSMDP3V5MD3a2eQX6iZkMrg1eSN40WYRp1zVgWuvhzXjvAZtgBQr2QaVltTwhfRRRjFgQz1ZE7+sZZuG5lLQFxJOlAAT7otDez+QZ9jn/EH1/nineMtXMNKf660buc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HKrQtcQ9; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/v/0r9Zhym+lAVWl4sokuyDmIE1l0nUGmhtztqK6/YQSh0UhfGOz9H/+MmAO1UhG49UHi4v7te6YIHt9cNbrr53DbnkhQvC2pLPxwZ9a1MJdSpjkKKPrKVEi1hZXkE1Vixkd+AgKKFYzlSpAf1XsEYE84cCObnQ8qArPW2NIXC3LN/5rCB40CI5fwu7W7VsDMWCV853vF7FHitaxKwghfCMUUuT7nHE0u4VnfmDxD4BsR0uRTy6RtYGhhKHBo8/grJaIh9MZ8Yza2dg03MS4PT6mMNIOJDO7MGEDIaKN7g39VZUgjt8xbYfXBxt5ThmxxLCGJNVFqFFiu8NLDrI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt6KQGveKpv3h5Vcnvsjp6svIE0gMNHAEatb0cmOFgE=;
 b=upqir07R8cZdFthiaueCmkfK/nC2/H0AND9ssTcSjkCm2bp4qnTuHQtYYuJDR0lr+sO3YZj19GcMOoG4Ls6S5eEicck+wTGb+AhN8Om8Fws2VO6yFudrcI9/2fIrZufIC0zuv6qTw2oz8RygDt+YvnvT84jDyOKHvJvNjS2/xPAJbMCHOTu6yfPUt00vZJ0Y0flNURRlVLva1oTXleP2Zd1av7fEE3b7WGGDYWYzhGRK+/gig5pjSxg1T/HqivzY4ag1mPBweed8HxXjkjrdTVGmz1gisyGyik75b1wya87cI3POfjklJ46KOJtm58kj7b+QMeiTXM2OkJzc5amyDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt6KQGveKpv3h5Vcnvsjp6svIE0gMNHAEatb0cmOFgE=;
 b=HKrQtcQ93eOFIH7AobFz4mEsF0hjdSImhybHjJfc+gGTKDzElKQKQg8tlYGVRlMvTnJ9wx4hzBYF+JP2PESPxESnpIhxGGYWoNe+J64S5Ri3iywWqTcIi9fgUGiSBA7kepjQH2+dCW2sod0fxxbqEypf8lzae7IVdE3rg3YeiRg9hoxjL9i0we7Cp2cZXc0ikg4ItwOKxJqX5EXCtuwHDRW1CNqhpPgx1amoehlTyuB+/aWWFv70SyG89jI93R/wEz6ai7rGE/ySEMhAG7/Qewv6MRTQUaMjyynKpiaySoBOjvwzV2sxAwEgp0UcaKWugGPaRFWv7g8/ivnsh+Pi/w==
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Sun, 13 Oct
 2024 06:46:32 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::52) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Sun, 13 Oct 2024 06:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 01/15] net/mlx5: Refactor QoS group scheduling element creation
Date: Sun, 13 Oct 2024 09:45:26 +0300
Message-ID: <20241013064540.170722-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: c2772408-7330-4944-6e12-08dceb52c4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6qL1UNI9q9dKXiFBZ1IWfci6aE82VB96lm1hYZhZQHIdLWyFmsRvJ6s1YEmg?=
 =?us-ascii?Q?eUiMNN9nt2XLP/o54wMsK88ieTBs25CZxO224GUCpgVfVd4WmeIP6EUeibth?=
 =?us-ascii?Q?MsEiolLzDIpaIKJH9nLmJ5p3G8ml04MXfsz2WcbCKl8HUkrrSjyxGsYIkV/6?=
 =?us-ascii?Q?HYQ7qoDxr262Nu0scyXUSvhecwRUHwcvcP8Lr79Pb6kgqipFo51XDIWBlcSY?=
 =?us-ascii?Q?OHoZ+09mrkfqv21D3JyOlEAB6aVEynzwp81A6lTYyHj61Jh805ODXkvRWX9M?=
 =?us-ascii?Q?zd3gD/QQcgvKBYd3B6VWq8URX246XF7/ldxmbrB+hyp/CeJw74GNN2IrcFs+?=
 =?us-ascii?Q?jJ5rH85EZVTtC3BOuFZ7BW1erNJ8MzwJp9gD17PY4KDSspEucreqlXAEduA/?=
 =?us-ascii?Q?KI3YokVUFzQCSzGob0RnVa1WS44sax5dLIius/7v4esXCeh4kjyZU8DtbECp?=
 =?us-ascii?Q?eZZUI+X5ILsYD4ZuUwJuVzx+nL1GnS4mlDT9TG7YLK1Q7U3svkHoq5ReAs8K?=
 =?us-ascii?Q?kgbVnrTNgQGGGCfMhq/aqdOS60X7kyVlStgaRXY5N3yB8qYBNnCbGoczZUrp?=
 =?us-ascii?Q?eXmp0cVlzM9ikxN4uUvpvPWmWa2dLBP2Qax0sB0F4lFv3GTf4JUS3D+pAR/1?=
 =?us-ascii?Q?ssCUTZ73k6/gwW86ZLYWZt/LQM8o3vDxgHlCWge2hW0MK9xGkBofMBk5xoKI?=
 =?us-ascii?Q?wD7yycT5mI1FPglrGYjRo5cWmtdlHMTrKztdUD1ZQoVif+9/17NN8VlB7Kv5?=
 =?us-ascii?Q?Ljg77cJCXDWnA0wMYV+m9tWBVLgAFyFoGeSCzvoD+9m0TEUOjyt0GCk/3Pzt?=
 =?us-ascii?Q?xkU4WOpx8s0P8PXnyBvGi4LSjp9r7YVDY7EBqEUCKILem0i1zkqbuns+P/Xg?=
 =?us-ascii?Q?yFiw8aUcuX/iNtpHjT0RmMD3CFKG263uYxuekYOwTN0m3AddqttKMBz/j9/d?=
 =?us-ascii?Q?ROzGv/XYB0cQnfnSUn6nEZoqOlnBR2mIokb//Vwh9T9Ol8KSNd6H9QXWyXoZ?=
 =?us-ascii?Q?ocmsxkXTmkiChkqQ6mgp0RBtbZ2tb1cbvvY/Mspo7+MxPsyMy7zHqpNSKYrR?=
 =?us-ascii?Q?510ZY2yC3flUqEc3NHhQB+55L6oCP/pd+9KjyGoe3H8VNj20uNeealpFCcFZ?=
 =?us-ascii?Q?EeBgHPlcYbxSiySXXNY7hQMvyuU5lBi1NK83tjTcdfBYTsandDUkloYZkhMx?=
 =?us-ascii?Q?DbF1FCfof5h+XiuJWmOrlgNbmYV20U8/qQVKfu8rRcOAKaII9ye3bXiGOByu?=
 =?us-ascii?Q?bnfZHKBW2F3EI8D3G75jaP6mCaaJMZLmteNOQpizDNZF0LuFyuyBE9QfIf9z?=
 =?us-ascii?Q?DcBtU3A0Pdj+BEf4ETWYf9qK3oTXrnQiJmb1hrvht/rm8JJ7YypHBnCYI9gg?=
 =?us-ascii?Q?SYnYJweE1fiCIqjh9DEnl10Rwi4x?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:29.8759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2772408-7330-4944-6e12-08dceb52c4ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `esw_qos_create_group_sched_elem` to handle the creation of
group scheduling elements for E-Switch QoS, Transmit Scheduling
Arbiter (TSAR).

This reduces duplication and simplifies code for TSAR setup.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 63 +++++++++----------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index ee6f76a6f0b5..e357ccd7bfd3 100644
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
@@ -496,21 +523,10 @@ static void __esw_qos_free_rate_group(struct mlx5_esw_rate_group *group)
 static struct mlx5_esw_rate_group *
 __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
-	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_esw_rate_group *group;
-	int tsar_ix, err;
-	void *attr;
+	u32 tsar_ix, err;
 
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
@@ -591,32 +607,13 @@ static int __esw_qos_destroy_rate_group(struct mlx5_esw_rate_group *group,
 
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


