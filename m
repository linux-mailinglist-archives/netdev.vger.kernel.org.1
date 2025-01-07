Return-Path: <netdev+bounces-155720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA077A037AC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1B23A47E6
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E68A1DE3C3;
	Tue,  7 Jan 2025 06:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iyqv8lwN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC01DE4D6
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230124; cv=fail; b=N4Y2oPSrzPU/KPrBwAcl5WRbBmAgyN8FWBBkyT7YcW0w8AHZHL0pMvW2Hp3jauKkg1SZ1+u4M4qKCQuZ2n1ZghVfwZ4S/TN89uo48yzRJ2okIwuftgw1hZpQSDPRpJaxMY2P1U3jX7/AmbVXjs9FKvO8qV3dprYjxB2c8PG/O1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230124; c=relaxed/simple;
	bh=eySTaEFbRljtfyH2mGrP37a7xPiT6DiC9Cy//ZCOlZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xrv16RNdos+/30aQmtYa9wkHggiB1LWIzpvWEvRhFUxb1IDgLSNKJ0Bt4/29tiMfAXcapff6ykIB2noOVFRi+GAr3WvuZj6HZS3gz0BJpEEa8/p9f1DM1vc/JOcC+ZPQYau8L4UDvT3tR829AU/hW1LeP10ezUmhdc95bwx5t98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iyqv8lwN; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXdYE78Bnk3dwdvOV6latAYwkTTtDFci1AuwZzwfS0KLa5f7r78kiDKLaVZt9ZtMiGJKM8hlE0gc9UIosUuKSn86GNSQqdCrlLQqdpLAOdGfZa9mJ1FgX86a1jQFWrC2ocF78fBaPxgdN6hM1v+uGSO5qTrfcaMmqe4SFOow8cyYddiqynNfrOIXaBz1QrdCSo3sJyNEuVqCSdlnR1D3NL1rGSQN+MedWwur1gNtcheZCfZawCu4C6dgSl//tBcY7UgOzu7YBR4cgK57Gt0xe1lOhSrMPIbS20/Qx7lpKxk1ZChmelMZy8CSFZzu0bkugrd6eaz61CQug3ffAzlIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVIrj1HAoSKLGQpUvdMH+V1jSSTDV7Z7WCw5cDx+lKY=;
 b=YFLdALP0Z2O/WTrdq0JxnRY3753THUw4zF0M0nTer17auMT4f1Rm3sRTBvyp9BJbE/hnDGXE5ZCIZ7VdF39OadKhpjWRiW0PryLl7oOeaMv3+YC1PZkWCW+tUJZxzjU7ZRh0XgR49SGIYjMkiXXEC1puSvc7YYHyV/QRsGP6l10QGbloO0aIL5fOoONfjkkeuPOXkATI8NlD0uyEhCKp+rOxtf5W3Ra2jW1SHVkZplVJ0scpzTgG7twRtRTeWKN5UR5gHjesbQ19M5+0hsSJm5fSF1th4fME2Q3K4OXvxyVAvh/nIMxqkNNMLPdLIVr+pvqHT8REIB1EoiIlbEUCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVIrj1HAoSKLGQpUvdMH+V1jSSTDV7Z7WCw5cDx+lKY=;
 b=iyqv8lwNFrBqId+akcx1e9F+ph8IxQ6S/vCg43163jhfgwvQuFA+TCzG1eVHyM6s7U3Wmdyspe9BGlHZ6dxCzHdrhq6RcpUMwtfL8GTAV8Y3enI++hNDSVhxhDMZhJ9duFg9tbGEk0QD30g7ah8RxfXoBON/9ph+uyDOUyWdcwAaXtlmbNboC5t+PPFsU5Q55YjwrCuCef2Ul3NOVlDIIqQqJZy4EfuAfYyjHlJA/FNfwnKr4LTtVXvx50kb3Wql51ibzM5g5J5Qf7FG9q3Sku8OdKu3+zHFKa2O3DCTithNXXrQ3ORRsbFZK5+qA9TlBr3h65E08FBOKRhqiW1hGQ==
Received: from CH2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:610:38::36)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:08:38 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::f2) by CH2PR05CA0059.outlook.office365.com
 (2603:10b6:610:38::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 06:08:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:08:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:26 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:08:22 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 02/13] net/mlx5: fs, add HWS flow table API functions
Date: Tue, 7 Jan 2025 08:06:57 +0200
Message-ID: <20250107060708.1610882-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250107060708.1610882-1-tariqt@nvidia.com>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd25470-1d54-4d99-f0d9-08dd2ee1ba38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BGO9ZaKCdK4XdH5R6KvCxcplEmWL4EJBjWy0SkQuFcHss+2u7q1/IYQHXoGA?=
 =?us-ascii?Q?fMMv4iXzYQRaLMkjI6/+9bwwJ2dulgw8YzdY6qNnUmoNROLlIP1K8KPg00K0?=
 =?us-ascii?Q?ZLrj9NjlO3Fj7fJ8I2Wx2RN3u75PHnPYx1+K1zIIxtSi4EluIzae3ixUWRrw?=
 =?us-ascii?Q?Cp4MwrYJu93vxHrLqWfp+a/EyL2cnVhJ8vSFqsb4h70ZWbx4a5M8KxItLnhl?=
 =?us-ascii?Q?TMAHkuBM3zwVNgZGlR7RocksBvQVtP2gpRh2jLFrqVLtTlHtd8SywN5GE0by?=
 =?us-ascii?Q?tzaktKNbiyPPR+wcHdBm6FFs4t/VYApYUreIDY2ShaPpzi3aViYg3bvTK+EL?=
 =?us-ascii?Q?OFkg9EtrinHEq9ZvAHL97YtJQ7wZPnTh1g79rJzPuCtv0/dRB6zXZwoc5Lub?=
 =?us-ascii?Q?4+MCyuG34qaJ9vSa7eP5eisdFozfVFzamrDCK16Ikic1yaf2hmrJ6dvTRLVB?=
 =?us-ascii?Q?YvQZt+mxjSF7iNeeRpbp7qHfcU2LZVCAeM+FFlp4wffvB62HZ8QDThrH2Ht5?=
 =?us-ascii?Q?QyY2pQ1SY+sNUt+roeM20s65jb/+LE5qjZspT/VPasx8WzSB/9fIbob4nhJY?=
 =?us-ascii?Q?w6Qrf8kjkJychVgW7BX0EZh43VhsFLxKs9DzAWxDUlEU5VoSBiD6Gv8KcU27?=
 =?us-ascii?Q?VBb7w6gsUdBq8wLg5QX/5NBohL6Tq6wkvcJUdbknU8KDznW1fXHnTByj3lLU?=
 =?us-ascii?Q?UUTsJEiBAsbbKxmMQZOloUt6UaCXQZzpQiK3tmknQuqYRtfg9qLeT1DW6UZ/?=
 =?us-ascii?Q?w/2KIfFVexdOL5BMG/JW1PI/d6Ny942N7WSJLXayRU16yRhfQ4sVIINsYMCd?=
 =?us-ascii?Q?Z+IvDFnRu92GzyVk17m2Pn23QQbJBCHA7aRRFC2ycAPb+f+J63pu6gNKSoI0?=
 =?us-ascii?Q?v8j8V6VvqZy879qtElFxGQF57ZORMtL61V+DI+Nj6FeXzW/VtqusWaeNtl8P?=
 =?us-ascii?Q?PL8iW+JZhtVdQWH/BQukZqndKmo1UU2DR89KxELcqNebjV84DC4PskTDwaIT?=
 =?us-ascii?Q?Lt8s2C1lrPrMb0g35hJvOBhy1MawBqLnj2nuYxubDJ9DzBPQkkh+H0r4+49o?=
 =?us-ascii?Q?UVgwfjKbq6l8JnWWr39mGVe+sNSIkNuF8HNllmIorRKKGMwPcXL2B3BfDGby?=
 =?us-ascii?Q?XrVkjETgI++7V62CfpQDIa5zRaXur7Sdeuvn3jpbmBm2t/o9ilGyC4UKwQBP?=
 =?us-ascii?Q?Qg0Lh3fFHW6Pb0hzbXw/sZSEonUUJuaQfAuoI+dnfMVi2ypD9vIS1ZNEBzfU?=
 =?us-ascii?Q?8QX+TsBGipjhExBIpn++rOy4ktlOsBXbx5qKGxhyoDL3Gm/3QlOKcRyrVa2B?=
 =?us-ascii?Q?PsfaJIhSZhyiCIypfPmoojGiQ4PFzVvGEbx+AN1Bf0jQDSVmpcEMqt94l7Ay?=
 =?us-ascii?Q?RVhz3FZvIAumk0jKMaVOhdqo8P+qDqgM070NjhmsJTjtjQHjweNrgoBJPrw0?=
 =?us-ascii?Q?/oAjB3u2MJ1VLzWUrPhAM1NjnrX0ra9P2XhwyeLlXtnXVd88RxkYXz3Ol7nJ?=
 =?us-ascii?Q?gil0ZuBojyPo8j0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:08:38.1729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd25470-1d54-4d99-f0d9-08dd2ee1ba38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714

From: Moshe Shemesh <moshe@nvidia.com>

Add API functions to create, modify and destroy HW Steering flow tables.
Modify table enables change, connect or disconnect default miss table.
Add update root flow table API function.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |   5 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 113 ++++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |   5 +
 3 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 545fdfce7b52..e98266fb50ba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -192,7 +192,10 @@ struct mlx5_flow_handle {
 /* Type of children is mlx5_flow_group */
 struct mlx5_flow_table {
 	struct fs_node			node;
-	struct mlx5_fs_dr_table		fs_dr_table;
+	union {
+		struct mlx5_fs_dr_table		fs_dr_table;
+		struct mlx5_fs_hws_table	fs_hws_table;
+	};
 	u32				id;
 	u16				vport;
 	unsigned int			max_fte;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 7a3c84b18d1e..e24e86f1a895 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -44,7 +44,120 @@ static int mlx5_cmd_hws_set_peer(struct mlx5_flow_root_namespace *ns,
 	return 0;
 }
 
+static int set_ft_default_miss(struct mlx5_flow_root_namespace *ns,
+			       struct mlx5_flow_table *ft,
+			       struct mlx5_flow_table *next_ft)
+{
+	struct mlx5hws_table *next_tbl;
+	int err;
+
+	if (!ns->fs_hws_context.hws_ctx)
+		return -EINVAL;
+
+	/* if no change required, return */
+	if (!next_ft && !ft->fs_hws_table.miss_ft_set)
+		return 0;
+
+	next_tbl = next_ft ? next_ft->fs_hws_table.hws_table : NULL;
+	err = mlx5hws_table_set_default_miss(ft->fs_hws_table.hws_table, next_tbl);
+	if (err) {
+		mlx5_core_err(ns->dev, "Failed setting FT default miss (%d)\n", err);
+		return err;
+	}
+	ft->fs_hws_table.miss_ft_set = !!next_tbl;
+	return 0;
+}
+
+static int mlx5_cmd_hws_create_flow_table(struct mlx5_flow_root_namespace *ns,
+					  struct mlx5_flow_table *ft,
+					  struct mlx5_flow_table_attr *ft_attr,
+					  struct mlx5_flow_table *next_ft)
+{
+	struct mlx5hws_context *ctx = ns->fs_hws_context.hws_ctx;
+	struct mlx5hws_table_attr tbl_attr = {};
+	struct mlx5hws_table *tbl;
+	int err;
+
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
+		return mlx5_fs_cmd_get_fw_cmds()->create_flow_table(ns, ft, ft_attr,
+								    next_ft);
+
+	if (ns->table_type != FS_FT_FDB) {
+		mlx5_core_err(ns->dev, "Table type %d not supported for HWS\n",
+			      ns->table_type);
+		return -EOPNOTSUPP;
+	}
+
+	tbl_attr.type = MLX5HWS_TABLE_TYPE_FDB;
+	tbl_attr.level = ft_attr->level;
+	tbl = mlx5hws_table_create(ctx, &tbl_attr);
+	if (!tbl) {
+		mlx5_core_err(ns->dev, "Failed creating hws flow_table\n");
+		return -EINVAL;
+	}
+
+	ft->fs_hws_table.hws_table = tbl;
+	ft->id = mlx5hws_table_get_id(tbl);
+
+	if (next_ft) {
+		err = set_ft_default_miss(ns, ft, next_ft);
+		if (err)
+			goto destroy_table;
+	}
+
+	ft->max_fte = INT_MAX;
+
+	return 0;
+
+destroy_table:
+	mlx5hws_table_destroy(tbl);
+	ft->fs_hws_table.hws_table = NULL;
+	return err;
+}
+
+static int mlx5_cmd_hws_destroy_flow_table(struct mlx5_flow_root_namespace *ns,
+					   struct mlx5_flow_table *ft)
+{
+	int err;
+
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
+		return mlx5_fs_cmd_get_fw_cmds()->destroy_flow_table(ns, ft);
+
+	err = set_ft_default_miss(ns, ft, NULL);
+	if (err)
+		mlx5_core_err(ns->dev, "Failed to disconnect next table (%d)\n", err);
+
+	err = mlx5hws_table_destroy(ft->fs_hws_table.hws_table);
+	if (err)
+		mlx5_core_err(ns->dev, "Failed to destroy flow_table (%d)\n", err);
+
+	return err;
+}
+
+static int mlx5_cmd_hws_modify_flow_table(struct mlx5_flow_root_namespace *ns,
+					  struct mlx5_flow_table *ft,
+					  struct mlx5_flow_table *next_ft)
+{
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
+		return mlx5_fs_cmd_get_fw_cmds()->modify_flow_table(ns, ft, next_ft);
+
+	return set_ft_default_miss(ns, ft, next_ft);
+}
+
+static int mlx5_cmd_hws_update_root_ft(struct mlx5_flow_root_namespace *ns,
+				       struct mlx5_flow_table *ft,
+				       u32 underlay_qpn,
+				       bool disconnect)
+{
+	return mlx5_fs_cmd_get_fw_cmds()->update_root_ft(ns, ft, underlay_qpn,
+							 disconnect);
+}
+
 static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
+	.create_flow_table = mlx5_cmd_hws_create_flow_table,
+	.destroy_flow_table = mlx5_cmd_hws_destroy_flow_table,
+	.modify_flow_table = mlx5_cmd_hws_modify_flow_table,
+	.update_root_ft = mlx5_cmd_hws_update_root_ft,
 	.create_ns = mlx5_cmd_hws_create_ns,
 	.destroy_ns = mlx5_cmd_hws_destroy_ns,
 	.set_peer = mlx5_cmd_hws_set_peer,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index a2e2935d7367..092a03f90084 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -10,6 +10,11 @@ struct mlx5_fs_hws_context {
 	struct mlx5hws_context	*hws_ctx;
 };
 
+struct mlx5_fs_hws_table {
+	struct mlx5hws_table *hws_table;
+	bool miss_ft_set;
+};
+
 #ifdef CONFIG_MLX5_HW_STEERING
 
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void);
-- 
2.45.0


