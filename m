Return-Path: <netdev+bounces-75521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0D686A641
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331F528A0AE
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 02:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06A112E61;
	Wed, 28 Feb 2024 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oW4zL/5q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B0524B
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085627; cv=fail; b=FtBFCSanegW0xx8cqcB/btzgi7ts/VQcLXPO1ETt++Hqe8Jk6/rRcoShadVbGNlHT6OiIbaHurC244eSBTFSwXwkPSCrVbb7pV7ID2pyFmDuE7zX1K0j2Yga4f9A/ZtH8mOF1kp2k34Ry/YHUQgnK1G+zIT8HvhbZkpG8IE9HoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085627; c=relaxed/simple;
	bh=E3YeL7UTvyFumCcttZZnjeIc7aIRH1eDfTiRw3IBwiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6J8tjkkALD2+28ANiXmZKeHX4Uek8Ytq76VCXsgoydFSvwJl7ukdG5KeO0XqO65Bif5pDBrMiw9gjvqS+8U/Ei8J6kE9lp4y1Zb0nQl/fuafzn7q5ZczsOYGryXY8XdXP5q8elyQ7ZaVmMZd9W8FiPDOgK9pLNeTOqWkI33suM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oW4zL/5q; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ica2FdUV+if84F2E6N/la13I+/t2mBEOc9w4Jz3AP6qPePDecbbYe+Ulj1WfH5sVm2WKQH4nzxRUv/2rbXZF5xZf2G8Y5z4pNY12u3CRsfQ/jtA5aNo8aAf9ixR06XTZY8XTJ0OBPx0X4lJe7mOa70fyPm4YWNLgJCpCvyTQhHdsS6mjLcwXaPv2P3HiQdlBE24D43nimw4NgqriJ0VUWNH7TOAiKCDAZSrvnGBAz4NKZ5Hc9K51ri3HtKUkuitJ8lZDjT+4y+HOjQaGA3W1KeiiQIdye8AUxq9IK7ls/pRvqUy4lI/8DyRo6PObj4d7MFjEcicGMJ06HQxoYzMcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAO184hsbMGQtqrdBQSsYGez0xreM8fyzdapbxEpgwc=;
 b=fkkCkbPTQ0RhZOAB6k6A9x5vJdPpRZZVvvnI7ybh+APvWzMBqmuJcKj6L7dmcLkswP4BNtvCfrJT0Qv676rDfUeyUxohzAhvlU4NKLBHph/Qk/ht7f4WEfeRUzIUoft0T5pULt6g842HabAL1RSWw6dIw4DB6zl3OZ7EH56Mmz816XQY42KywHU5wPkNz1kf38Rl/DMFarb8LPYySFS2iSwWkVh/D5j+s97bQ4d7T+EZ+JiXox2YYePpE8hVDqaMfA/aw6CldcSEJicVI/Gkkoa4ethENrP1yyJPU3x1SGPtWURvRWpVjDlUfhjnTO58X6yNHD8+DwJhPhJldq92UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAO184hsbMGQtqrdBQSsYGez0xreM8fyzdapbxEpgwc=;
 b=oW4zL/5qlK/3GxXYUSAYZt4zAxyS1z5ViJ0H09vc4hBbru/+q+JesY6bnWObl+rGfunD8Vp+oi05uhkGfPLXFfgzCGighO+QiObIv2bV8koxcEUzjbRmWrlUWWBAWdN6JDnCFJxG1zSZ6sNjuVW2Ai1eTWZzk66K51tI93j6Ty8qxrfwS6DeO194uBirfS01Q1Tr1VpXm0b/2/OV7xnmGK3Iwk0E3320jc+xZo3ZA98OexZv18Xv1lAvBQYePMb3K2lb0gRG1upuUhSsLJpwPLNFoQFzMlz5WRqdZumi8Dx4708w+ukpafitmLYc5iZAYpRnYQpIJbbI5dkA9pByyw==
Received: from MW4PR04CA0099.namprd04.prod.outlook.com (2603:10b6:303:83::14)
 by CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 02:00:18 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::83) by MW4PR04CA0099.outlook.office365.com
 (2603:10b6:303:83::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Wed, 28 Feb 2024 02:00:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 02:00:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 18:00:03 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 18:00:02 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 27
 Feb 2024 18:00:01 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <tariqt@nvidia.com>,
	<yossiku@nvidia.com>, <kuba@kernel.org>, <witu@nvidia.com>
Subject: [PATCH net-next RFC 2/2] net/mlx5e: Add eswitch shared descriptor devlink
Date: Wed, 28 Feb 2024 03:59:54 +0200
Message-ID: <20240228015954.11981-2-witu@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240228015954.11981-1-witu@nvidia.com>
References: <20240228015954.11981-1-witu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: 880a118c-6b01-4401-bdbd-08dc38010311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J4x4zDTLU74qdufEsQF0gvHpCEgJ3nCMW2LMdLJru+ZfeQEa2SxRYZO7jcwWBjhPk+wwDd8eDX1I/946GMf2WebZtaw2DBijG2KiCkdlr01hqzJirVcJIDIAzKQkaQi+15yO6Rzn2NeArzT5lBaMFd7Ykw0q/utj6vF3pv9nUAXQ4EydSKacVcgZ1rsRa6u89KI9HapMXnEUouKCm7sAonan9sSX4BNpG5Ozt2d6kS7CwBFCmhyDKx33TrxE05uZLrVsUI8Sb9McjOSoewKTnbkkKnd/RSzvUzpIv89ltEL7JXqjBfeNLiqGKU3HyA1jmNT1lsn9vk93m+FE7cO8jPxc3+t9lHl1ibOs6Cd/UcAiDkeh2pE0fRmTzrlc6gi47HkA9x1UnzgbVy/ePHBQtqTXZvDqB3NtJQIgeOO0gvt9okVCvA+A6CTRF8o/vTEqbTso/+wbqN+xHedRBd9yNt8TiCAITDI5x0zBt+Saes7PmaDh2OvU4SOfjGHi1t/h6uB4WEkdwGtS4i4NyJXMIhdujhfFrN5pjAc8BzD5kF4ieP7tMK9+H9DR8EyoRdKTWroPVHEIl567c4+m5DaKHqzOL5F6wtofaH+JRsM5zEBhmmMMp87IAYu4ZYbfYwT6mBh/YICfN7fftY3eXhQT3ceooZffbHpOKHRwfRbr0ThME6czdNEPb03s1QQJdm4ptPYNFwvNYv4Z181MvR/s0jJXF1F5RMZk08v/Ntpn5DMkYqniRNIkTg3/Nou3yaCn
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 02:00:17.5822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 880a118c-6b01-4401-bdbd-08dc38010311
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386

Add devlink support for ewsitch shared descriptor
implementation for mlx5 driver.

Signed-off-by: William Tu <witu@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  4 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 10 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 80 +++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 3e064234f6fe..24eb03763b60 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -312,6 +312,10 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.eswitch_inline_mode_get = mlx5_devlink_eswitch_inline_mode_get,
 	.eswitch_encap_mode_set = mlx5_devlink_eswitch_encap_mode_set,
 	.eswitch_encap_mode_get = mlx5_devlink_eswitch_encap_mode_get,
+	.eswitch_shrdesc_mode_set = mlx5_devlink_eswitch_shrdesc_mode_set,
+	.eswitch_shrdesc_mode_get = mlx5_devlink_eswitch_shrdesc_mode_get,
+	.eswitch_shrdesc_count_set = mlx5_devlink_eswitch_shrdesc_count_set,
+	.eswitch_shrdesc_count_get = mlx5_devlink_eswitch_shrdesc_count_get,
 	.rate_leaf_tx_share_set = mlx5_esw_devlink_rate_leaf_tx_share_set,
 	.rate_leaf_tx_max_set = mlx5_esw_devlink_rate_leaf_tx_max_set,
 	.rate_node_tx_share_set = mlx5_esw_devlink_rate_node_tx_share_set,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 349e28a6dd8d..f678bcb98e1f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -378,6 +378,8 @@ struct mlx5_eswitch {
 	struct mlx5_esw_functions esw_funcs;
 	struct {
 		u32             large_group_num;
+		u32             shared_rx_ring_counts;
+		bool            enable_shared_rx_ring;
 	}  params;
 	struct blocking_notifier_head n_head;
 	struct xarray paired;
@@ -549,6 +551,14 @@ int mlx5_devlink_eswitch_encap_mode_set(struct devlink *devlink,
 					struct netlink_ext_ack *extack);
 int mlx5_devlink_eswitch_encap_mode_get(struct devlink *devlink,
 					enum devlink_eswitch_encap_mode *encap);
+int mlx5_devlink_eswitch_shrdesc_mode_set(struct devlink *devlink,
+					  enum devlink_eswitch_shrdesc_mode mode,
+					  struct netlink_ext_ack *extack);
+int mlx5_devlink_eswitch_shrdesc_mode_get(struct devlink *devlink,
+					  enum devlink_eswitch_shrdesc_mode *mode);
+int mlx5_devlink_eswitch_shrdesc_count_set(struct devlink *devlink, int count,
+					   struct netlink_ext_ack *extack);
+int mlx5_devlink_eswitch_shrdesc_count_get(struct devlink *devlink, int *count);
 int mlx5_devlink_port_fn_hw_addr_get(struct devlink_port *port,
 				     u8 *hw_addr, int *hw_addr_len,
 				     struct netlink_ext_ack *extack);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b0455134c98e..5586f52e4239 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4019,6 +4019,86 @@ int mlx5_devlink_eswitch_encap_mode_get(struct devlink *devlink,
 	return 0;
 }
 
+int mlx5_devlink_eswitch_shrdesc_mode_set(struct devlink *devlink,
+					  enum devlink_eswitch_shrdesc_mode shrdesc,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw;
+	int err = 0;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	down_write(&esw->mode_lock);
+	if (esw->mode != MLX5_ESWITCH_OFFLOADS) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can't enable shared descriptors in legacy mode");
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+	esw->params.enable_shared_rx_ring = shrdesc ==
+					     DEVLINK_ESWITCH_SHRDESC_MODE_BASIC;
+
+out:
+	up_write(&esw->mode_lock);
+	return err;
+}
+
+int mlx5_devlink_eswitch_shrdesc_mode_get(struct devlink *devlink,
+					  enum devlink_eswitch_shrdesc_mode *shrdesc)
+{
+	struct mlx5_eswitch *esw;
+	bool enable;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	enable = esw->params.enable_shared_rx_ring;
+	if (enable)
+		*shrdesc = DEVLINK_ESWITCH_SHRDESC_MODE_BASIC;
+	else
+		*shrdesc = DEVLINK_ESWITCH_SHRDESC_MODE_NONE;
+
+	return 0;
+}
+
+int mlx5_devlink_eswitch_shrdesc_count_set(struct devlink *devlink, int count,
+					   struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw;
+	int err = 0;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	down_write(&esw->mode_lock);
+	if (esw->mode != MLX5_ESWITCH_OFFLOADS) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can't enable shared descriptors in legacy mode");
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+	esw->params.shared_rx_ring_counts = count;
+out:
+	up_write(&esw->mode_lock);
+	return err;
+}
+
+int mlx5_devlink_eswitch_shrdesc_count_get(struct devlink *devlink, int *count)
+{
+	struct mlx5_eswitch *esw;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	*count = esw->params.shared_rx_ring_counts;
+	return 0;
+}
+
 static bool
 mlx5_eswitch_vport_has_rep(const struct mlx5_eswitch *esw, u16 vport_num)
 {
-- 
2.38.1


