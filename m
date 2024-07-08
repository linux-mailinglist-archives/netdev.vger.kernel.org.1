Return-Path: <netdev+bounces-109763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1272B929DE0
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6F128477F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53DD40BE3;
	Mon,  8 Jul 2024 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sx7nUnI3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF725634
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425724; cv=fail; b=Gu/ZbqnQ3nhPM3IBhKzbs5W/A3U7Eak5KwpqqVqhEuJgypFUVr2qogIqY+zVW51jo0zjtW1UT9+4v8v2jY8H2n42WBiCHJgVP3J3dI/buWA6GbC3rfab16bvUSQDEMwkvv9kpRYVCZfahd+avK3FaVhUUPJtsC8PblfXP3w8kkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425724; c=relaxed/simple;
	bh=Abl/mgl+7k2eozKu2ALzHu4Z5hyOl9gTDa3xN8Bvaxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4bX4vZpDK4kxKu0jqefEpMugnKWq4ouEGUNd3KN/4kb3ZtLbSDpKHFWMFJumUhIqv9Jaw9TnVK6GBoGfncXMh0Q6h9opFfrzCS2WpCaS5Q69IcDvVBVQ7w+mKBPW56Cm4frVAxENiodA2VWcDhpwE2i1/LcOrTL7UG3qAe0SLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sx7nUnI3; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTbZsKAFuoNXHNaYpbOXEZAfCknBbA+QFNL9E2U3/B3x7klbgqyr4kvdA2zu/E2lJh8RunR1NUZP39Y7HXDTLfFNJ3HVRMFWnke7Olv+Hf5oHfMW6yD83D0c7jDXmzSY2MXp3KdVg726IIkZmJEBnNaNQNEzujKh1FEev2m9lNL92VnMxxcBstUSYRJC4z1Jj8pyZS5tz192UH5MZaK20xRxaaF/vxqqnPZqhUrLIaHBLxcTknv4C4tvtAkvqCeNfrDoFpKeJqNzOM5rz9QBG+xPhy5eI9G/WkLFS7QPTbemottDBw/E14KyWsiXnxCDX8ypddQPgaWzfGwNN0MeTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LED6M5sdB7PSysZvBJ0cSaTk00BstLkXE3b9A1IB6FU=;
 b=M8gz7RG0vrLn1WqJygYWaSwJZ/iRTjktSC4BiS/68ajGuzXcsv3MYRVoxrn4YC0x/XnWKXHGFQP7X3zrCb64H04z7EDINtYmTCL2m5AjjFI29DB9D+ndLJ89PYTPRdyteUyZPH6/qe1QlO2A17Mrro88mt6ILDtN7it6Z6dbLpbuC+pVnl9Q+ndVP5vaTSm1QhlojWi/f1UDXCn2jaIwC4ju7GX/37eiCBSKmUXdONV9vQs4iKIcB2KMb4OEAKk0CZ3bbylperaurNA9/ufPRsYCyrk5LMjOYGGQsa3YwdRtL5PDBF3l2c4QJqS4ZM0HJccdfEOnasS5MCvVPel0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LED6M5sdB7PSysZvBJ0cSaTk00BstLkXE3b9A1IB6FU=;
 b=Sx7nUnI3REKlTBjPHSBHGqZVxrEGPuSDeCfaDyPZcxRDlAA493cWhY/aE7Zl0VOX/oApPlQIYlemfQZGEScDzUm517bk5TGBIqHewEP94xSJQZMb6XDAfbyAZDdoQPdCNkLpRBlUIf3y7lOGXdzz6euq3/YHDPHLjd/3DDW9dxiXl8q7x9Et0UiQr8jhKB7jTYjHaLQyzr/vIvG/4/xCAMfiY8Xy34weUCx7kQF7T+5YYp/+sS2hmqCFqpSL4oDk452/83upVXIZQQp4pzDvD0qG1SUAET0Eg1V8uQYpybwdJzmC2QzpYHgj5nUrAZ76QXSrhK2oz1Yho9uLPS3Znw==
Received: from BL1PR13CA0109.namprd13.prod.outlook.com (2603:10b6:208:2b9::24)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:02:00 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::e8) by BL1PR13CA0109.outlook.office365.com
 (2603:10b6:208:2b9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Mon, 8 Jul 2024 08:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:01:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 8 Jul
 2024 01:01:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, William Tu <witu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 03/10] net/mlx5: Set default max eqs for SFs
Date: Mon, 8 Jul 2024 11:00:18 +0300
Message-ID: <20240708080025.1593555-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240708080025.1593555-1-tariqt@nvidia.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa4b015-d1c7-400e-a2ac-08dc9f243ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QenT207SjhxTospazoszP07jiZt0cCA1ARHFi0amZEtAkjTeJkX+q8Zqcc6f?=
 =?us-ascii?Q?MSwBfdP8cC5+ZDFYL/CR4qt9xZ126UOqOAsfDsgymUKLZ2HV2WR6EOkN1Kpv?=
 =?us-ascii?Q?tmuzr48Y9Bw8SejZkajlqR11BU1v8RkE+aggJpEiiuA0GA5HCgr917pmMHeA?=
 =?us-ascii?Q?JEl9G3geeBaUbqzpMW5DLi2rmqL/ApSSW4w/ZXY3vkzUbKKiWXGLFhgS6PlI?=
 =?us-ascii?Q?e1BTVyualCrwuuyfrvTh/VkgNYDsnYrbzK3lU+vYTf+8csasFjsDI+/AzlL3?=
 =?us-ascii?Q?3zHsYPPL17alWpk5X1iF/roqQwSfzi9upWTvhuZt6g8ZY1O0X/oufgR8V6TY?=
 =?us-ascii?Q?yd2GwHreqb/SC5ifHb1D2KJTJ6lVNZA8N+M+5CPVE2Fg7aG66Husw/nJNy48?=
 =?us-ascii?Q?Aary7U8nsyYRKCHtjSpFp7J5ruvu86IkGGi1KsqZMTkDLdD1HCojMXV64Z4o?=
 =?us-ascii?Q?XU9Jok63qnyxflgSXJ/MVPr+bJa5ayfdc9MGIyEw+ziHSzj4cgGko6Gxu9KS?=
 =?us-ascii?Q?4EqMb/kf7t5perZchby5EMxqJoPLJxC8FKdm+LNHiu5fWy0dTYSJYnKeC24R?=
 =?us-ascii?Q?dVQ9pZAS1afXLyJti8MPbP6NAqDptSYO+urZilD0pNGECtF+Pq3VBaLNN2Ty?=
 =?us-ascii?Q?3OY3k/dxDt7qtplSLcpeXMlazdN68uUpcV7FXOuMAAmQcMuCoBU5ePqPAw5i?=
 =?us-ascii?Q?miSLeH+/l7Opog9wjLNhxHHvxlI/eG/DOUbj/XkRzWZ85DerbVGdYmasBm+c?=
 =?us-ascii?Q?K+mxAtlpJ1nPo5DynqURNEljgOkEvJ6JQ/Y5vRi0K9Y6Hqsmr22epEc/DDO4?=
 =?us-ascii?Q?j6WjihgKTtvgDH0BNkAdg4UCI3S+6BMx6JNJkop3C0XVg8y20dXmnW3a3Qk7?=
 =?us-ascii?Q?8gyMicF7rTJcQ8x6YwmCJkXwgkLJcAaoOL70afcLZINCPery+FcinIBP5WzE?=
 =?us-ascii?Q?eFgwcZX/UNCTmDY1CajrMbRt9dCF0o7d1XKYgnGiEOenvSABd3y16UHsODIT?=
 =?us-ascii?Q?rD9oMobskcQ/VvfQfmbxfk1Y2WhRRVz8Jvw3voadJmvKz8z3ZRgAlkXQazN+?=
 =?us-ascii?Q?ntLf0Ng0MisS/RJmObf6C3Tv5oH/Op0vi5hvmz4q5+wSSSYYmBVmARgp8iAQ?=
 =?us-ascii?Q?VRGw5MxYvAkONwV7Ud7bsF1e0izxpsVbHewOFR2ChAFR+WoVr1Rssush92YA?=
 =?us-ascii?Q?Pr15xFYkSFrXYB1KM1Nix/x9+i7tnLTNPDyIJj7RGb6cQwikySlKv69TU19V?=
 =?us-ascii?Q?yZOTB/sus0RkxEebTMRHYwxbf1A76T0giV+SkEiZc/+pQn8yQEv1qjpO2UHJ?=
 =?us-ascii?Q?TEyeljjxw07HQvjtz1qtFTSfn/zpb+3dD3ISunVlbHbKWBlm9RDlbXTRc8l+?=
 =?us-ascii?Q?v8iee5lUcxea5vmq4MbLC/1AP8aBqZgo8tD/uACCbu+hRsxXsI1B2JW55t2E?=
 =?us-ascii?Q?29opHtHziPQwWOD4u35Ve0gNcQ280bWk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:01:59.6483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa4b015-d1c7-400e-a2ac-08dc9f243ea6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783

From: Daniel Jurgens <danielj@nvidia.com>

If the user hasn't configured max_io_eqs set a low default. The SF
driver shouldn't try to create more than this, but FW will enforce this
limit.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h    |  3 +++
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 12 +++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c | 12 ++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 88745dc6aed5..578466d69f21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -223,6 +223,7 @@ struct mlx5_vport {
 
 	u16 vport;
 	bool                    enabled;
+	bool max_eqs_set;
 	enum mlx5_eswitch_vport_event enabled_events;
 	int index;
 	struct mlx5_devlink_port *dl_port;
@@ -579,6 +580,8 @@ int mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port,
 int mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port,
 					u32 max_io_eqs,
 					struct netlink_ext_ack *extack);
+int mlx5_devlink_port_fn_max_io_eqs_set_sf_default(struct devlink_port *port,
+						   struct netlink_ext_ack *extack);
 
 void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 099a716f1784..768199d2255a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -68,6 +68,7 @@
 #define MLX5_ESW_FT_OFFLOADS_DROP_RULE (1)
 
 #define MLX5_ESW_MAX_CTRL_EQS 4
+#define MLX5_ESW_DEFAULT_SF_COMP_EQS 8
 
 static struct esw_vport_tbl_namespace mlx5_esw_vport_tbl_mirror_ns = {
 	.max_fte = MLX5_ESW_VPORT_TBL_SIZE,
@@ -4683,9 +4684,18 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA caps");
-
+	vport->max_eqs_set = true;
 out:
 	mutex_unlock(&esw->state_lock);
 	kfree(query_ctx);
 	return err;
 }
+
+int
+mlx5_devlink_port_fn_max_io_eqs_set_sf_default(struct devlink_port *port,
+					       struct netlink_ext_ack *extack)
+{
+	return mlx5_devlink_port_fn_max_io_eqs_set(port,
+						   MLX5_ESW_DEFAULT_SF_COMP_EQS,
+						   extack);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 6c11e075cab0..a96be98be032 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -161,6 +161,7 @@ int mlx5_devlink_sf_port_fn_state_get(struct devlink_port *dl_port,
 static int mlx5_sf_activate(struct mlx5_core_dev *dev, struct mlx5_sf *sf,
 			    struct netlink_ext_ack *extack)
 {
+	struct mlx5_vport *vport;
 	int err;
 
 	if (mlx5_sf_is_active(sf))
@@ -170,6 +171,13 @@ static int mlx5_sf_activate(struct mlx5_core_dev *dev, struct mlx5_sf *sf,
 		return -EBUSY;
 	}
 
+	vport = mlx5_devlink_port_vport_get(&sf->dl_port.dl_port);
+	if (!vport->max_eqs_set && MLX5_CAP_GEN_2(dev, max_num_eqs_24b)) {
+		err = mlx5_devlink_port_fn_max_io_eqs_set_sf_default(&sf->dl_port.dl_port,
+								     extack);
+		if (err)
+			return err;
+	}
 	err = mlx5_cmd_sf_enable_hca(dev, sf->hw_fn_id);
 	if (err)
 		return err;
@@ -318,7 +326,11 @@ int mlx5_devlink_sf_port_new(struct devlink *devlink,
 
 static void mlx5_sf_dealloc(struct mlx5_sf_table *table, struct mlx5_sf *sf)
 {
+	struct mlx5_vport *vport;
+
 	mutex_lock(&table->sf_state_lock);
+	vport = mlx5_devlink_port_vport_get(&sf->dl_port.dl_port);
+	vport->max_eqs_set = false;
 
 	mlx5_sf_function_id_erase(table, sf);
 
-- 
2.44.0


