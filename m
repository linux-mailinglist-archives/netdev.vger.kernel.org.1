Return-Path: <netdev+bounces-153033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB709F69BD
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6058E1890960
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F51EF0A5;
	Wed, 18 Dec 2024 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MpibVUGs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EA5189F37
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534695; cv=fail; b=fg5ioHvAYyAw0BgXTtzrLOwLsvFhMo1tCyDv5OBnz3jWDv7Q0JaKjegIYUlae5WYgDInT90wUuXSmYdpt+fgo3pQNKj6s4CxGXTe9MCDSiqyllFw5lPQLPVUQa1wzZWPsevDJf7fi++zZ2e9dqJCduoAmbrC58Mp228iA9rVJ/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534695; c=relaxed/simple;
	bh=D++pqIKqidNsD3DcO5Lz8wswBedt7aL62M4STsJ+Bns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMdrTwiplc/QTm4wrGITLTywCAtRaQHaXZ5okZdl+LzUxHRp3JrAUbyBzmG+9a1hFdk8coH8jlvbHNaSh7BZ6BDXfHyIJg5agIcgbVBl1Slg8bfnTOg2k5le1UB9c4BOU9t7wGZL+H/kj4BiO3sVNxvibUg51W1YhQAREyHsMjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MpibVUGs; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJoWAQ4q8nEp/4U4Dk34Fl0WHtY3kEWhphjc4kI3PrmCyJECP8z9BOnN/idlds+xfQ7wc1yWcqzvl+vq/rxN9zaBKZ9gI2dBMVCNG2eWGE59ZcLDUM+b0+n9TA43WjRXwGwa3RR1Kta1uCTMyLmQBbbkJxz0GivmZSEWLCfclt4FLr0bJUu/KtD2A4WCoRLqxAeqM59cxgEMjlcQWjQPesgNIz8CVn9wHyGZ3VNpgAzdwk+WByRFDQnSYKGeNpI+uxM4qFHAmUrlL0lb/R5pRonBaIIpnjlqgvERJGUMYXWplXvBsQjmAVLa9pI93zdjVIoopHI03B9g87J8L5bEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtsahyL/KZvkitthfk3NMjLH7aEapcFTS+VQ+BFZaVo=;
 b=EXdj0UL+3u15q3Nr5BtMgIi+RmpyQrIbYdmpJlpltDg/jP2+lWqc1uNx9J7wlqbtxi4r2ozMW7hzc5uNPAZDz7uDanG8o2cGxoK7bAWZ+8kNg1HAwXj+Xc57ULj4mPNm4oiPFZ0/usUm76pMACuFqOgNt+J6AHaqOszOEtM4PcrqlOsu7nnul9J8MLiyasVP2igEQuhHLr5BOgqq+GDVLClyyWhDu7812QRZqw0z9VqipwyS4Jin3SYETQmZNSoR0fb6P71jbNihNm1L+LuEMV0zBycL1g3TI5fLfeXGBSE7lfHsy7MrGwpFO7uwgTDLleIUYI/RGmcF6XCa8tMjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtsahyL/KZvkitthfk3NMjLH7aEapcFTS+VQ+BFZaVo=;
 b=MpibVUGsIgA73MTuHZMO9+f+stx++aXU9n2C6mkKLwrQV3eSQ3ZWpBLbbmdGSlHyNj23LirjYG2YWu76HwgcNwprQOxX3QzS9d5rb72rbMWBRtEKIhD2fNvtbeQ2RE3AFjSBtSFHJxPATanqPI5Eb21KgU4ekmFQm8g0jM2Avs3aNWGbuu75VwWKzz4z90UAiWXJfwQSpt41nttQ2OGCBthYUku+1zMU8q6TxBFQUa3lEr28fZDrNYvUX/ZHwoAGsctuq//E5r62aC1P05CyUTI9SLw/2U9hwvVhjDYzjAjaSP0Gek50e7cIj3BdKzI4jhna1XbzgB7Q7UvspujT8Q==
Received: from SN7PR04CA0076.namprd04.prod.outlook.com (2603:10b6:806:121::21)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 15:11:29 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::4b) by SN7PR04CA0076.outlook.office365.com
 (2603:10b6:806:121::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Wed,
 18 Dec 2024 15:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:11:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:11:18 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:11:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 18 Dec
 2024 07:11:15 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V3 11/11] net/mlx5: fs, Add support for RDMA RX steering over IB link layer
Date: Wed, 18 Dec 2024 17:09:49 +0200
Message-ID: <20241218150949.1037752-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241218150949.1037752-1-tariqt@nvidia.com>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b6d524-f7b1-46db-2807-08dd1f763f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?94UcSKayHJ5bR+p/pwEbLa7pkQIWBlGleC00ec+2P4A/GFQYiF3ShZT774zR?=
 =?us-ascii?Q?JjVAOOo7LODoUO9dJN6jkL9UO6zG70tcdSvU3LGGMNHPrjjlkR2Ii3blkdfp?=
 =?us-ascii?Q?c855HGNccuvZAKvi6Jwhst9qsVJMseirq73+/oZBfW8d1m/9uvMTu4LR70jz?=
 =?us-ascii?Q?vfCaq5SivNvuxinq8GAuZmqmcxFXWSpEYhRqt/biuN4DRJagdGR6UdJ9XIHo?=
 =?us-ascii?Q?IuYH1TEcs7AKzVL7iGBS3MbR2LOoUIjldHib58UkKtPf6cnz8n5rODRlEkZX?=
 =?us-ascii?Q?75EaTZvxAm3NxiIrD71KqWi33WxlfArbpvyJ/nKfS5UaZag2MJqbK7CFIee5?=
 =?us-ascii?Q?O1OxJ5YoTBOX6DkGmLIj6NEB8hg7wcOa1O10cSR9jw9c0ISgZf8agHxox0G7?=
 =?us-ascii?Q?V1/pApCMt5So5EazUphxOwW567xLpOyYRR1DwmlQChwDpEaj34Mim24o8Dgm?=
 =?us-ascii?Q?SuDY+7KUpdw//+m8WHwRqd3D2ir443oCahKjf8H+J9kTv2b9JEdMdf5SVevp?=
 =?us-ascii?Q?HV25nuRPZI/jCz/Sq9YhGSSaJ9rBE7Vvgl8WPjG8LjYYXXZo2GV18DTcFxgR?=
 =?us-ascii?Q?Od7OqYtSFrjQT6/qvXBqUAOa8E9dq0AjuE9d3i+Io6UsbxZi5IBnINXqK8Sg?=
 =?us-ascii?Q?Sl4jlUqSNMl+nQvVIpQO6r2Ty0FhiqRe4sN33jcJkusy3DlVOVSoRm9K8upX?=
 =?us-ascii?Q?SFnJbFVliqvIU235k4B9MJAbGGnlOVOdERW+qSVTrAjRdcV/jV3w2/E2moQH?=
 =?us-ascii?Q?qmnOFyE+Zy0uB7TtjnqvXgwGfSLmrAmWXOGDin79B84i6WW5FnJ1ccGyBfxF?=
 =?us-ascii?Q?zoDdH8eYZqvkVrJz2krzWycK9E2KaFmVIcCVlpdSsZef+cQXp/rPAqbszL4F?=
 =?us-ascii?Q?BJmW9hKEfdssx9cQ9a+vrcanja8LTvk/G7vcrGIzvmvInIt86a4R7BjalkA/?=
 =?us-ascii?Q?8dpNqRCJZrK7cyIcjk0e0n1hKsDa9c3cPkBkZPhLtIlNoEDok+gVdNmMuJAv?=
 =?us-ascii?Q?owzJLv5PKLp+upK8HW3aZoQnJj0h+/LlBUAkZjqeqwj/E+fNL08oTCM/7UcH?=
 =?us-ascii?Q?J70d9PYXdfmbIq48/8EhuZsgJRQ91dc0/YXgHv+rKHVgT+I+KGUUQRGRAwEV?=
 =?us-ascii?Q?FyjsU+ZfGu3yJqm0tTmqzu5qX7w9YLn1V1PChdTjghows1QqHkr49VLfyNMU?=
 =?us-ascii?Q?fil5VCXhZRNIdlqphmatpozwjO80ol0o6RNpfccaecS3ZsTkZcMYEyasW+Y6?=
 =?us-ascii?Q?n12NpXOeNXQkkEiSq5x0zM0iMoLSHCBk2fZfVUBS/YS9+DDTbb0MQ6heJkKc?=
 =?us-ascii?Q?BdFi377chHKJ+fZClUDIVDs3a89M5Jq/qUPvChXM8ItgLPGK8J5r2/2H8kbr?=
 =?us-ascii?Q?GodmEa/eB0zkySU8WoWAq0GJfhpWNvn+ZSwFeVR/reu5ISfTNVMqwaKIDtTk?=
 =?us-ascii?Q?wMsdRTXaAM0AKhySuenuKfiNZfFlEFfSWBT5BneX30ZE8PlUS8elpLIZoVzs?=
 =?us-ascii?Q?9YYyuH/oAo84JrU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:11:28.8807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b6d524-f7b1-46db-2807-08dd1f763f9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024

From: Patrisious Haddad <phaddad@nvidia.com>

Relax the capability check for creating the RDMA RX steering domain
by considering only the capabilities reported by the firmware
as necessary for its creation, which in turn allows RDMA RX creation
over devices with IB link layer as well.

The table_miss_action_domain capability is required only for a specific
priority, which is handled in mlx5_rdma_enable_roce_steering().
The additional capability check for this case is already in place.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c  | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 6bf0aade69d7..ae20c061e0fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -217,7 +217,8 @@ static int mlx5_cmd_update_root_ft(struct mlx5_flow_root_namespace *ns,
 	int err;
 
 	if ((MLX5_CAP_GEN(dev, port_type) == MLX5_CAP_PORT_TYPE_IB) &&
-	    underlay_qpn == 0)
+	    underlay_qpn == 0 &&
+	    (ft->type != FS_FT_RDMA_RX && ft->type != FS_FT_RDMA_TX))
 		return 0;
 
 	if (ft->type == FS_FT_FDB &&
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index ae1a5705b26d..41b5e98a0495 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3665,8 +3665,7 @@ int mlx5_fs_core_init(struct mlx5_core_dev *dev)
 			goto err;
 	}
 
-	if (MLX5_CAP_FLOWTABLE_RDMA_RX(dev, ft_support) &&
-	    MLX5_CAP_FLOWTABLE_RDMA_RX(dev, table_miss_action_domain)) {
+	if (MLX5_CAP_FLOWTABLE_RDMA_RX(dev, ft_support)) {
 		err = init_rdma_rx_root_ns(steering);
 		if (err)
 			goto err;
-- 
2.45.0


