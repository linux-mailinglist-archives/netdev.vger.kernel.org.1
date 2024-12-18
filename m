Return-Path: <netdev+bounces-153025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8F89F69A0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5327A4318
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3A11E9B1E;
	Wed, 18 Dec 2024 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HmLcyHIg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1D1E0DED
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534674; cv=fail; b=KPrb9n8j7/uip1pQKTzbb5KaK6ETKvQ8uRKCWME5O9xhb5bZ+e6cwa4ktkBmeclW5Kggx4vwg+vZZl6HDMcmKjRI/iGTzvcflhkHlpiwtitfoluKAVjtAp2UZBrepb1Ni8VCXzBYqodTGBWyRtM27kIcqxE92eb8evpkDCvn3xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534674; c=relaxed/simple;
	bh=+DMn1iOyOPjJTG6onyOUK/zF6tGw1OOI7cWEnY/YYv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+FTnlmdhlsoyBD5r8iTYu5YegasVwC/6qMDBckn9kdeVca2mS7cLO1U8CYRkakXejpjYYfRn2BYfyLVuXsJs5Wr1w9AI2ouPzRvHCFn0kJyaIZKQtF2tPX/fv4a+sF06oFz7QJcCqRLe4DXK6gNFaxQhs45F6Ax04RNEsb/TLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HmLcyHIg; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWPO4DuYHeAuD24iNbK0wm2Owv6Iu/gm4uEDB+v5GBuvNWPpPOUP20WTSJlTTcNWcZBtc8tukJyt+Nn6/WmDSzdF3sxPHLJCB3r+rGFfXVu6aVswSl+w5Lsy+zap0Tff8iux8IbYy0pAz6177vVcMtbSd2Ni5fu7//0olAXJsW6Uu/Sr2ARQHTcE5MhNPH+xUCaLUwrEtKQwVSpxsvIxduwnp3esc8Xco852WZytAuOmrJWFYwurqZSXIa5DAlCEtblUJhIBNhTbSA/r7Vzgi1d9NrePGWVldavUzZ5qaDBNveGCVk7eA9ITwD3H72PW2bLpxQDcZtBjfIBFoRzSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNvekCRoPI6kPRo/wHiJl325TRAqasjmD/TS9Uu/KqY=;
 b=qGO87Jbgyqzf24p4XEgSjtn6mnpBkzeN9EziQhZtMpj9TSDRp49P0ZZtHAh0HYU1XckRFBNq8StcO7sG7wTaUc44OuZuIUWkDsTXGmrX/UAstpvRHcs6pJc05dOqiURcLveW0ZEVijn8a35vMTo3JkYdErYSDQyvmcU2y4ZLUFW5X5hj+ZQi1d/4x9y/rPXC1V/UTkMRSCFHDzeVXzKMAuz7fpEsSIxr0PWzeudj6q7XhJfJyC0T7F6JpG23fnY70jxl9PvuFAfRvssQrkbqGQM0G7IfqmNsvoFVICSHRHAuwXzg6lVc4MCx1Cr53tgZV9ac5mFV6P8vMd24md4hyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNvekCRoPI6kPRo/wHiJl325TRAqasjmD/TS9Uu/KqY=;
 b=HmLcyHIg24a2s0iCcTGQER1UY176p54WpSQQlf0nm/hcdGWCdteJnUIx+HFIacXfXgwgoXqLFx46dJJQBHtRLuoj9z2TRDz4M3X1VzGkWSoMoBbLZfD3Yw0nA47dgRZrgYvsISA0sDGr3J6fIXY02klAhSUw9LJY/hGP5FYCoZwDaWJYBGbY9MRJgrmREt61hwz51vMEJyVyN5zRicaapN0CvT9ui+/YSPafExtsgNjaV0i7UbpWatJ6T5XcE67r63/6f3fWc/nP43iXTX1AsAfpzoxWO66yq9YcgClgyTpGmpBhMOCNBfTU4bOA7QwhxaIF0dKmlnsl3iNzIH74kg==
Received: from BN9PR03CA0295.namprd03.prod.outlook.com (2603:10b6:408:f5::30)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 15:11:05 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::62) by BN9PR03CA0295.outlook.office365.com
 (2603:10b6:408:f5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend Transport; Wed,
 18 Dec 2024 15:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:11:04 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:10:46 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:10:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 18 Dec
 2024 07:10:42 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Rongwei Liu <rongweil@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V3 02/11] net/mlx5: LAG, Support LAG over Multi-Host NICs
Date: Wed, 18 Dec 2024 17:09:40 +0200
Message-ID: <20241218150949.1037752-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d10a70-cc50-441d-dfdb-08dd1f76315a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7CS5ei/cT/SYg7dibmORGN4GBh1WNg9zNaz7Uh51QUryF6i2WxBC8DcV13jR?=
 =?us-ascii?Q?bQxYq2zhuW+/uA9LsQJDnPtJfxW9IBjt9e5szHITKDroER0cFGPFcPEBMZRc?=
 =?us-ascii?Q?posxyucvGnq6gUrYnlGtP0jkBZdB14krqT1IeKyrJLsiCdTUak4fNjnpJQZp?=
 =?us-ascii?Q?PYh0ykbxpxGBahM7iOdPkqtNDZW0RQL5h5WdIg+I/c1O/w8V0q1sUm1FMlWd?=
 =?us-ascii?Q?mHo1PYp0v3pFi0e4LXsyvxrDdm69X4fZ4kTSgO0ZWfnDshim+w1Ul9fNPHd6?=
 =?us-ascii?Q?qeP3Vjzts2T0xkjjtMZFuy9LKMFjfSLhl6Ha8BzReqrca8+lt0GBbsUbgvn+?=
 =?us-ascii?Q?Tw/SYJxu0Lm8N1QNiNBKDXiyBNmXVmq9QDcIr4CSuCe25gKMvTCBE83MWJ82?=
 =?us-ascii?Q?2PFw5uNlqrI6MBQ/SOlgxVDBXxKFcokCZa1kQkxh1aLPMMgP5kHIAWlt+faz?=
 =?us-ascii?Q?UXBrf+zUOts+vTFl59KYUE+qYf76Oyt+BvmU5i6kEorpEuD42eCuYxAdz+OA?=
 =?us-ascii?Q?SJA7g2KxThNPCrheycZQynnRQG8QgxIQXIS/SVLDxdzrLjTBVvNUd1R/9coi?=
 =?us-ascii?Q?diG6vkqQvEsQkP59Xcz1M/Ywd2kp3RSAoaFl72bozOLl2KfFQTukoGybDh3W?=
 =?us-ascii?Q?sOkPplXPCYbFGvDbeOdSL5tyspVnJtEiq8xDPUYiR3+wSX2MGxlk8nSeBh7g?=
 =?us-ascii?Q?LfDHzLVsvbx9vM+CrC/jgxPGHCCFJsR45MVbpECjGTTyviTQ5ICmVrThVLJf?=
 =?us-ascii?Q?2twjbvJZ1ATBjul/XqFKW6gYjv1qh9yXxDky4O5KDOMi2DvEt+/kYrS6BmdG?=
 =?us-ascii?Q?n9HA3KqR088uQTN71hRj+TmgkTjPd3treOZcQwLopcSme4yVZ+/LyDb1grkv?=
 =?us-ascii?Q?bK24S7JVO00oRZIEn8EaqLjwNWJHBVFworn6Y+w3v4doBJF8aDXlv/nknyqo?=
 =?us-ascii?Q?V2hw1379sh8JZUX/lbNcPZZWc4Z2jfPNFnILFCNF5UedOlC1PYrbDZfr586W?=
 =?us-ascii?Q?FXjVW5V5rhfaBw2PksSrJWBTWkNkKu6310kYI5A/CMW5IW3SmNXuNb0ty/cj?=
 =?us-ascii?Q?pliXewFK3ujZC2aU9s5z+I3nKsfRVe43gGvhnOGOZN+GdjiOXNmRyCK42bDZ?=
 =?us-ascii?Q?+Zv7paIQux/ufylaNjx4WqqSaDgL+B9JyAwpabbIY9+DAcWXcCBuqkmA1BQz?=
 =?us-ascii?Q?pFvGIdVWDYb4v6ARrvkvFXoq0eg7Tpo42Wk+pXV4O0s1b5xcYakK04mC428l?=
 =?us-ascii?Q?B+1zUiMah8Dp2x9jY9iWlf3k2BCtz9Jk/pRDo1lwlfXGCxxokRuzxZ950Mz9?=
 =?us-ascii?Q?/Nq0TvuB+vLyqKKU0/w0+zSIROpb7vp9EgqOgwVvNIIKk5ag5rT/pi95nJD2?=
 =?us-ascii?Q?RlMc53D/qBaFePLgm+8lelg5f1PH1w5YwUf6EU2985c8jOXmNTq/nvE4CtHT?=
 =?us-ascii?Q?AnQI6JrzKPencIEgalUIBrnzRz45nZC+xkcgB1Rl1Bv6HKmjT+QGk4QFFEUB?=
 =?us-ascii?Q?AJMdeoFY/ka1yPs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:11:04.9088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d10a70-cc50-441d-dfdb-08dd1f76315a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

From: Rongwei Liu <rongweil@nvidia.com>

New multi-host NICs provide each host with partial ports,
allowing each host to maintain its unique LAG configuration.

On these multi-host NICs, the 'native_port_num' capability
is no longer continuous on each host and can exceed the
'num_lag_ports' capability. Therefore, it is necessary to
skip the PFs with ldev->pf[i].dev == NULL when querying/modifying
the lag devices' information.
There is no need to check dev.native_port_num against ldev->ports.

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 200 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |   3 +
 .../net/ethernet/mellanox/mlx5/core/lag/mp.c  |  53 +++--
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |   6 +-
 .../mellanox/mlx5/core/lag/port_sel.c         |  41 +++-
 .../net/ethernet/mellanox/mlx5/core/main.c    |   4 +
 6 files changed, 229 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index ed539ac4fef1..7fde81fd29be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -76,23 +76,30 @@ static u8 lag_active_port_bits(struct mlx5_lag *ldev)
 	return active_port;
 }
 
-static int mlx5_cmd_create_lag(struct mlx5_core_dev *dev, u8 *ports, int mode,
-			       unsigned long flags)
+static int mlx5_cmd_create_lag(struct mlx5_core_dev *dev, struct mlx5_lag *ldev,
+			       int mode, unsigned long flags)
 {
 	bool fdb_sel_mode = test_bit(MLX5_LAG_MODE_FLAG_FDB_SEL_MODE_NATIVE,
 				     &flags);
 	int port_sel_mode = get_port_sel_mode(mode, flags);
 	u32 in[MLX5_ST_SZ_DW(create_lag_in)] = {};
+	u8 *ports = ldev->v2p_map;
+	int idx0, idx1;
 	void *lag_ctx;
 
 	lag_ctx = MLX5_ADDR_OF(create_lag_in, in, ctx);
 	MLX5_SET(create_lag_in, in, opcode, MLX5_CMD_OP_CREATE_LAG);
 	MLX5_SET(lagc, lag_ctx, fdb_selection_mode, fdb_sel_mode);
+	idx0 = mlx5_lag_get_dev_index_by_seq(ldev, 0);
+	idx1 = mlx5_lag_get_dev_index_by_seq(ldev, 1);
+
+	if (idx0 < 0 || idx1 < 0)
+		return -EINVAL;
 
 	switch (port_sel_mode) {
 	case MLX5_LAG_PORT_SELECT_MODE_QUEUE_AFFINITY:
-		MLX5_SET(lagc, lag_ctx, tx_remap_affinity_1, ports[0]);
-		MLX5_SET(lagc, lag_ctx, tx_remap_affinity_2, ports[1]);
+		MLX5_SET(lagc, lag_ctx, tx_remap_affinity_1, ports[idx0]);
+		MLX5_SET(lagc, lag_ctx, tx_remap_affinity_2, ports[idx1]);
 		break;
 	case MLX5_LAG_PORT_SELECT_MODE_PORT_SELECT_FT:
 		if (!MLX5_CAP_PORT_SELECTION(dev, port_select_flow_table_bypass))
@@ -114,12 +121,18 @@ static int mlx5_cmd_modify_lag(struct mlx5_core_dev *dev, struct mlx5_lag *ldev,
 {
 	u32 in[MLX5_ST_SZ_DW(modify_lag_in)] = {};
 	void *lag_ctx = MLX5_ADDR_OF(modify_lag_in, in, ctx);
+	int idx0, idx1;
+
+	idx0 = mlx5_lag_get_dev_index_by_seq(ldev, 0);
+	idx1 = mlx5_lag_get_dev_index_by_seq(ldev, 1);
+	if (idx0 < 0 || idx1 < 0)
+		return -EINVAL;
 
 	MLX5_SET(modify_lag_in, in, opcode, MLX5_CMD_OP_MODIFY_LAG);
 	MLX5_SET(modify_lag_in, in, field_select, 0x1);
 
-	MLX5_SET(lagc, lag_ctx, tx_remap_affinity_1, ports[0]);
-	MLX5_SET(lagc, lag_ctx, tx_remap_affinity_2, ports[1]);
+	MLX5_SET(lagc, lag_ctx, tx_remap_affinity_1, ports[idx0]);
+	MLX5_SET(lagc, lag_ctx, tx_remap_affinity_2, ports[idx1]);
 
 	return mlx5_cmd_exec_in(dev, modify_lag, in);
 }
@@ -287,6 +300,48 @@ int mlx5_lag_dev_get_netdev_idx(struct mlx5_lag *ldev,
 	return -ENOENT;
 }
 
+int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq)
+{
+	int i, num = 0;
+
+	if (!ldev)
+		return -ENOENT;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		if (num == seq)
+			return i;
+		num++;
+	}
+	return -ENOENT;
+}
+
+int mlx5_lag_num_devs(struct mlx5_lag *ldev)
+{
+	int i, num = 0;
+
+	if (!ldev)
+		return 0;
+
+	mlx5_ldev_for_each(i, 0, ldev) {
+		(void)i;
+		num++;
+	}
+	return num;
+}
+
+int mlx5_lag_num_netdevs(struct mlx5_lag *ldev)
+{
+	int i, num = 0;
+
+	if (!ldev)
+		return 0;
+
+	mlx5_ldev_for_each(i, 0, ldev)
+		if (ldev->pf[i].netdev)
+			num++;
+	return num;
+}
+
 static bool __mlx5_lag_is_roce(struct mlx5_lag *ldev)
 {
 	return ldev->mode == MLX5_LAG_MODE_ROCE;
@@ -423,10 +478,15 @@ static int mlx5_cmd_modify_active_port(struct mlx5_core_dev *dev, u8 ports)
 
 static int _mlx5_modify_lag(struct mlx5_lag *ldev, u8 *ports)
 {
-	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
+	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	struct mlx5_core_dev *dev0;
 	u8 active_ports;
 	int ret;
 
+	if (idx < 0)
+		return -EINVAL;
+
+	dev0 = ldev->pf[idx].dev;
 	if (test_bit(MLX5_LAG_MODE_FLAG_HASH_BASED, &ldev->mode_flags)) {
 		ret = mlx5_lag_port_sel_modify(ldev, ports);
 		if (ret ||
@@ -445,7 +505,7 @@ static struct net_device *mlx5_lag_active_backup_get_netdev(struct mlx5_core_dev
 	struct net_device *ndev = NULL;
 	struct mlx5_lag *ldev;
 	unsigned long flags;
-	int i;
+	int i, last_idx;
 
 	spin_lock_irqsave(&lag_lock, flags);
 	ldev = mlx5_lag_dev(dev);
@@ -456,8 +516,12 @@ static struct net_device *mlx5_lag_active_backup_get_netdev(struct mlx5_core_dev
 	mlx5_ldev_for_each(i, 0, ldev)
 		if (ldev->tracker.netdev_state[i].tx_enabled)
 			ndev = ldev->pf[i].netdev;
-	if (!ndev)
-		ndev = ldev->pf[ldev->ports - 1].netdev;
+	if (!ndev) {
+		last_idx = mlx5_lag_get_dev_index_by_seq(ldev, ldev->ports - 1);
+		if (last_idx < 0)
+			goto unlock;
+		ndev = ldev->pf[last_idx].netdev;
+	}
 
 	if (ndev)
 		dev_hold(ndev);
@@ -471,13 +535,18 @@ static struct net_device *mlx5_lag_active_backup_get_netdev(struct mlx5_core_dev
 void mlx5_modify_lag(struct mlx5_lag *ldev,
 		     struct lag_tracker *tracker)
 {
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	u8 ports[MLX5_MAX_PORTS * MLX5_LAG_MAX_HASH_BUCKETS] = {};
-	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
+	struct mlx5_core_dev *dev0;
 	int idx;
 	int err;
 	int i;
 	int j;
 
+	if (first_idx < 0)
+		return;
+
+	dev0 = ldev->pf[first_idx].dev;
 	mlx5_infer_tx_affinity_mapping(tracker, ldev, ldev->buckets, ports);
 
 	mlx5_ldev_for_each(i, 0, ldev) {
@@ -518,8 +587,13 @@ void mlx5_modify_lag(struct mlx5_lag *ldev,
 static int mlx5_lag_set_port_sel_mode_roce(struct mlx5_lag *ldev,
 					   unsigned long *flags)
 {
-	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	struct mlx5_core_dev *dev0;
 
+	if (first_idx < 0)
+		return -EINVAL;
+
+	dev0 = ldev->pf[first_idx].dev;
 	if (!MLX5_CAP_PORT_SELECTION(dev0, port_select_flow_table)) {
 		if (ldev->ports > 2)
 			return -EINVAL;
@@ -539,11 +613,13 @@ static void mlx5_lag_set_port_sel_mode_offloads(struct mlx5_lag *ldev,
 						enum mlx5_lag_mode mode,
 						unsigned long *flags)
 {
-	struct lag_func *dev0 = &ldev->pf[MLX5_LAG_P1];
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	struct lag_func *dev0;
 
-	if (mode == MLX5_LAG_MODE_MPESW)
+	if (first_idx < 0 || mode == MLX5_LAG_MODE_MPESW)
 		return;
 
+	dev0 = &ldev->pf[first_idx];
 	if (MLX5_CAP_PORT_SELECTION(dev0->dev, port_select_flow_table) &&
 	    tracker->tx_type == NETDEV_LAG_TX_TYPE_HASH) {
 		if (ldev->ports > 2)
@@ -588,12 +664,18 @@ char *mlx5_get_str_port_sel_mode(enum mlx5_lag_mode mode, unsigned long flags)
 
 static int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 {
-	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
-	struct mlx5_eswitch *master_esw = dev0->priv.eswitch;
-	int err;
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	struct mlx5_eswitch *master_esw;
+	struct mlx5_core_dev *dev0;
 	int i, j;
+	int err;
 
-	mlx5_ldev_for_each(i, 1, ldev) {
+	if (first_idx < 0)
+		return -EINVAL;
+
+	dev0 = ldev->pf[first_idx].dev;
+	master_esw = dev0->priv.eswitch;
+	mlx5_ldev_for_each(i, first_idx + 1, ldev) {
 		struct mlx5_eswitch *slave_esw = ldev->pf[i].dev->priv.eswitch;
 
 		err = mlx5_eswitch_offloads_single_fdb_add_one(master_esw,
@@ -603,7 +685,7 @@ static int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 	}
 	return 0;
 err:
-	mlx5_ldev_for_each_reverse(j, i, 1, ldev)
+	mlx5_ldev_for_each_reverse(j, i, first_idx + 1, ldev)
 		mlx5_eswitch_offloads_single_fdb_del_one(master_esw,
 							 ldev->pf[j].dev->priv.eswitch);
 	return err;
@@ -615,16 +697,21 @@ static int mlx5_create_lag(struct mlx5_lag *ldev,
 			   unsigned long flags)
 {
 	bool shared_fdb = test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags);
-	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	u32 in[MLX5_ST_SZ_DW(destroy_lag_in)] = {};
+	struct mlx5_core_dev *dev0;
 	int err;
 
+	if (first_idx < 0)
+		return -EINVAL;
+
+	dev0 = ldev->pf[first_idx].dev;
 	if (tracker)
 		mlx5_lag_print_mapping(dev0, ldev, tracker, flags);
 	mlx5_core_info(dev0, "shared_fdb:%d mode:%s\n",
 		       shared_fdb, mlx5_get_str_port_sel_mode(mode, flags));
 
-	err = mlx5_cmd_create_lag(dev0, ldev->v2p_map, mode, flags);
+	err = mlx5_cmd_create_lag(dev0, ldev, mode, flags);
 	if (err) {
 		mlx5_core_err(dev0,
 			      "Failed to create LAG (%d)\n",
@@ -656,11 +743,16 @@ int mlx5_activate_lag(struct mlx5_lag *ldev,
 		      enum mlx5_lag_mode mode,
 		      bool shared_fdb)
 {
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	bool roce_lag = mode == MLX5_LAG_MODE_ROCE;
-	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
+	struct mlx5_core_dev *dev0;
 	unsigned long flags = 0;
 	int err;
 
+	if (first_idx < 0)
+		return -EINVAL;
+
+	dev0 = ldev->pf[first_idx].dev;
 	err = mlx5_lag_set_flags(ldev, mode, tracker, shared_fdb, &flags);
 	if (err)
 		return err;
@@ -704,20 +796,26 @@ int mlx5_activate_lag(struct mlx5_lag *ldev,
 
 int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 {
-	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
-	struct mlx5_eswitch *master_esw = dev0->priv.eswitch;
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	u32 in[MLX5_ST_SZ_DW(destroy_lag_in)] = {};
 	bool roce_lag = __mlx5_lag_is_roce(ldev);
 	unsigned long flags = ldev->mode_flags;
+	struct mlx5_eswitch *master_esw;
+	struct mlx5_core_dev *dev0;
 	int err;
 	int i;
 
+	if (first_idx < 0)
+		return -EINVAL;
+
+	dev0 = ldev->pf[first_idx].dev;
+	master_esw = dev0->priv.eswitch;
 	ldev->mode = MLX5_LAG_MODE_NONE;
 	ldev->mode_flags = 0;
 	mlx5_lag_mp_reset(ldev);
 
 	if (test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags)) {
-		mlx5_ldev_for_each(i, 1, ldev)
+		mlx5_ldev_for_each(i, first_idx + 1, ldev)
 			mlx5_eswitch_offloads_single_fdb_del_one(master_esw,
 								 ldev->pf[i].dev->priv.eswitch);
 		clear_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &flags);
@@ -749,6 +847,7 @@ int mlx5_deactivate_lag(struct mlx5_lag *ldev)
 
 bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 {
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 #ifdef CONFIG_MLX5_ESWITCH
 	struct mlx5_core_dev *dev;
 	u8 mode;
@@ -756,9 +855,8 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 	bool roce_support;
 	int i;
 
-	for (i = 0; i < ldev->ports; i++)
-		if (!ldev->pf[i].dev)
-			return false;
+	if (first_idx < 0 || mlx5_lag_num_devs(ldev) != ldev->ports)
+		return false;
 
 #ifdef CONFIG_MLX5_ESWITCH
 	mlx5_ldev_for_each(i, 0, ldev) {
@@ -767,7 +865,7 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 			return false;
 	}
 
-	dev = ldev->pf[MLX5_LAG_P1].dev;
+	dev = ldev->pf[first_idx].dev;
 	mode = mlx5_eswitch_mode(dev);
 	mlx5_ldev_for_each(i, 0, ldev)
 		if (mlx5_eswitch_mode(ldev->pf[i].dev) != mode)
@@ -778,8 +876,8 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 		if (mlx5_sriov_is_enabled(ldev->pf[i].dev))
 			return false;
 #endif
-	roce_support = mlx5_get_roce_state(ldev->pf[MLX5_LAG_P1].dev);
-	mlx5_ldev_for_each(i, MLX5_LAG_P2, ldev)
+	roce_support = mlx5_get_roce_state(ldev->pf[first_idx].dev);
+	mlx5_ldev_for_each(i, first_idx + 1, ldev)
 		if (mlx5_get_roce_state(ldev->pf[i].dev) != roce_support)
 			return false;
 
@@ -817,11 +915,16 @@ void mlx5_lag_remove_devices(struct mlx5_lag *ldev)
 void mlx5_disable_lag(struct mlx5_lag *ldev)
 {
 	bool shared_fdb = test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &ldev->mode_flags);
-	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
+	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	struct mlx5_core_dev *dev0;
 	bool roce_lag;
 	int err;
 	int i;
 
+	if (idx < 0)
+		return;
+
+	dev0 = ldev->pf[idx].dev;
 	roce_lag = __mlx5_lag_is_roce(ldev);
 
 	if (shared_fdb) {
@@ -831,7 +934,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 			dev0->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
 		}
-		mlx5_ldev_for_each(i, MLX5_LAG_P2, ldev)
+		mlx5_ldev_for_each(i, idx + 1, ldev)
 			mlx5_nic_vport_disable_roce(ldev->pf[i].dev);
 	}
 
@@ -850,10 +953,14 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 
 static bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev)
 {
+	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_core_dev *dev;
 	int i;
 
-	mlx5_ldev_for_each(i, MLX5_LAG_P1 + 1, ldev) {
+	if (idx < 0)
+		return false;
+
+	mlx5_ldev_for_each(i, idx + 1, ldev) {
 		dev = ldev->pf[i].dev;
 		if (is_mdev_switchdev_mode(dev) &&
 		    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
@@ -865,7 +972,7 @@ static bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev)
 		return false;
 	}
 
-	dev = ldev->pf[MLX5_LAG_P1].dev;
+	dev = ldev->pf[idx].dev;
 	if (is_mdev_switchdev_mode(dev) &&
 	    mlx5_eswitch_vport_match_metadata_enabled(dev->priv.eswitch) &&
 	    mlx5_esw_offloads_devcom_is_ready(dev->priv.eswitch) &&
@@ -906,13 +1013,18 @@ static bool mlx5_lag_should_disable_lag(struct mlx5_lag *ldev, bool do_bond)
 
 static void mlx5_do_bond(struct mlx5_lag *ldev)
 {
-	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
+	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct lag_tracker tracker = { };
+	struct mlx5_core_dev *dev0;
 	struct net_device *ndev;
 	bool do_bond, roce_lag;
 	int err;
 	int i;
 
+	if (idx < 0)
+		return;
+
+	dev0 = ldev->pf[idx].dev;
 	if (!mlx5_lag_is_ready(ldev)) {
 		do_bond = false;
 	} else {
@@ -945,7 +1057,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 		} else if (roce_lag) {
 			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
-			mlx5_ldev_for_each(i, MLX5_LAG_P2, ldev) {
+			mlx5_ldev_for_each(i, idx + 1, ldev) {
 				if (mlx5_get_roce_state(ldev->pf[i].dev))
 					mlx5_nic_vport_enable_roce(ldev->pf[i].dev);
 			}
@@ -1380,7 +1492,7 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
 			 struct net_device *netdev)
 {
 	struct mlx5_lag *ldev;
-	int i;
+	int num = 0;
 
 	ldev = mlx5_lag_dev(dev);
 	if (!ldev)
@@ -1388,11 +1500,8 @@ void mlx5_lag_add_netdev(struct mlx5_core_dev *dev,
 
 	mutex_lock(&ldev->lock);
 	mlx5_ldev_add_netdev(ldev, dev, netdev);
-	for (i = 0; i < ldev->ports; i++)
-		if (!ldev->pf[i].netdev)
-			break;
-
-	if (i >= ldev->ports)
+	num = mlx5_lag_num_netdevs(ldev);
+	if (num >= ldev->ports)
 		set_bit(MLX5_LAG_FLAG_NDEVS_READY, &ldev->state_flags);
 	mutex_unlock(&ldev->lock);
 	mlx5_queue_bond_work(ldev, 0);
@@ -1469,11 +1578,12 @@ bool mlx5_lag_is_master(struct mlx5_core_dev *dev)
 	struct mlx5_lag *ldev;
 	unsigned long flags;
 	bool res = false;
+	int idx;
 
 	spin_lock_irqsave(&lag_lock, flags);
 	ldev = mlx5_lag_dev(dev);
-	res = ldev && __mlx5_lag_is_active(ldev) &&
-		dev == ldev->pf[MLX5_LAG_P1].dev;
+	idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	res = ldev && __mlx5_lag_is_active(ldev) && idx >= 0 && dev == ldev->pf[idx].dev;
 	spin_unlock_irqrestore(&lag_lock, flags);
 
 	return res;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 1dada791815e..01cf72366947 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -136,4 +136,7 @@ static inline bool mlx5_lag_is_supported(struct mlx5_core_dev *dev)
 
 int mlx5_get_pre_ldev_func(struct mlx5_lag *ldev, int start_idx, int end_idx);
 int mlx5_get_next_ldev_func(struct mlx5_lag *ldev, int start_idx);
+int mlx5_lag_get_dev_index_by_seq(struct mlx5_lag *ldev, int seq);
+int mlx5_lag_num_devs(struct mlx5_lag *ldev);
+int mlx5_lag_num_netdevs(struct mlx5_lag *ldev);
 #endif /* __MLX5_LAG_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
index 40406d04adc9..aee17fcf3b36 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
@@ -17,7 +17,10 @@ static bool __mlx5_lag_is_multipath(struct mlx5_lag *ldev)
 #define MLX5_LAG_MULTIPATH_OFFLOADS_SUPPORTED_PORTS 2
 static bool mlx5_lag_multipath_check_prereq(struct mlx5_lag *ldev)
 {
-	if (!mlx5_lag_is_ready(ldev))
+	int idx0 = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	int idx1 = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P2);
+
+	if (idx0 < 0 || idx1 < 0 || !mlx5_lag_is_ready(ldev))
 		return false;
 
 	if (__mlx5_lag_is_active(ldev) && !__mlx5_lag_is_multipath(ldev))
@@ -26,8 +29,8 @@ static bool mlx5_lag_multipath_check_prereq(struct mlx5_lag *ldev)
 	if (ldev->ports > MLX5_LAG_MULTIPATH_OFFLOADS_SUPPORTED_PORTS)
 		return false;
 
-	return mlx5_esw_multipath_prereq(ldev->pf[MLX5_LAG_P1].dev,
-					 ldev->pf[MLX5_LAG_P2].dev);
+	return mlx5_esw_multipath_prereq(ldev->pf[idx0].dev,
+					 ldev->pf[idx1].dev);
 }
 
 bool mlx5_lag_is_multipath(struct mlx5_core_dev *dev)
@@ -50,43 +53,45 @@ bool mlx5_lag_is_multipath(struct mlx5_core_dev *dev)
 static void mlx5_lag_set_port_affinity(struct mlx5_lag *ldev,
 				       enum mlx5_lag_port_affinity port)
 {
+	int idx0 = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	int idx1 = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P2);
 	struct lag_tracker tracker = {};
 
-	if (!__mlx5_lag_is_multipath(ldev))
+	if (idx0 < 0 || idx1 < 0 || !__mlx5_lag_is_multipath(ldev))
 		return;
 
 	switch (port) {
 	case MLX5_LAG_NORMAL_AFFINITY:
-		tracker.netdev_state[MLX5_LAG_P1].tx_enabled = true;
-		tracker.netdev_state[MLX5_LAG_P2].tx_enabled = true;
-		tracker.netdev_state[MLX5_LAG_P1].link_up = true;
-		tracker.netdev_state[MLX5_LAG_P2].link_up = true;
+		tracker.netdev_state[idx0].tx_enabled = true;
+		tracker.netdev_state[idx1].tx_enabled = true;
+		tracker.netdev_state[idx0].link_up = true;
+		tracker.netdev_state[idx1].link_up = true;
 		break;
 	case MLX5_LAG_P1_AFFINITY:
-		tracker.netdev_state[MLX5_LAG_P1].tx_enabled = true;
-		tracker.netdev_state[MLX5_LAG_P1].link_up = true;
-		tracker.netdev_state[MLX5_LAG_P2].tx_enabled = false;
-		tracker.netdev_state[MLX5_LAG_P2].link_up = false;
+		tracker.netdev_state[idx0].tx_enabled = true;
+		tracker.netdev_state[idx0].link_up = true;
+		tracker.netdev_state[idx1].tx_enabled = false;
+		tracker.netdev_state[idx1].link_up = false;
 		break;
 	case MLX5_LAG_P2_AFFINITY:
-		tracker.netdev_state[MLX5_LAG_P1].tx_enabled = false;
-		tracker.netdev_state[MLX5_LAG_P1].link_up = false;
-		tracker.netdev_state[MLX5_LAG_P2].tx_enabled = true;
-		tracker.netdev_state[MLX5_LAG_P2].link_up = true;
+		tracker.netdev_state[idx0].tx_enabled = false;
+		tracker.netdev_state[idx0].link_up = false;
+		tracker.netdev_state[idx1].tx_enabled = true;
+		tracker.netdev_state[idx1].link_up = true;
 		break;
 	default:
-		mlx5_core_warn(ldev->pf[MLX5_LAG_P1].dev,
+		mlx5_core_warn(ldev->pf[idx0].dev,
 			       "Invalid affinity port %d", port);
 		return;
 	}
 
-	if (tracker.netdev_state[MLX5_LAG_P1].tx_enabled)
-		mlx5_notifier_call_chain(ldev->pf[MLX5_LAG_P1].dev->priv.events,
+	if (tracker.netdev_state[idx0].tx_enabled)
+		mlx5_notifier_call_chain(ldev->pf[idx0].dev->priv.events,
 					 MLX5_DEV_EVENT_PORT_AFFINITY,
 					 (void *)0);
 
-	if (tracker.netdev_state[MLX5_LAG_P2].tx_enabled)
-		mlx5_notifier_call_chain(ldev->pf[MLX5_LAG_P2].dev->priv.events,
+	if (tracker.netdev_state[idx1].tx_enabled)
+		mlx5_notifier_call_chain(ldev->pf[idx1].dev->priv.events,
 					 MLX5_DEV_EVENT_PORT_AFFINITY,
 					 (void *)0);
 
@@ -150,11 +155,15 @@ mlx5_lag_get_next_fib_dev(struct mlx5_lag *ldev,
 static void mlx5_lag_fib_route_event(struct mlx5_lag *ldev, unsigned long event,
 				     struct fib_entry_notifier_info *fen_info)
 {
+	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct net_device *nh_dev0, *nh_dev1;
 	struct fib_info *fi = fen_info->fi;
 	struct lag_mp *mp = &ldev->lag_mp;
 	int i, dev_idx = 0;
 
+	if (idx < 0)
+		return;
+
 	/* Handle delete event */
 	if (event == FIB_EVENT_ENTRY_DEL) {
 		/* stop track */
@@ -180,7 +189,7 @@ static void mlx5_lag_fib_route_event(struct mlx5_lag *ldev, unsigned long event,
 	}
 
 	if (nh_dev0 == nh_dev1) {
-		mlx5_core_warn(ldev->pf[MLX5_LAG_P1].dev,
+		mlx5_core_warn(ldev->pf[idx].dev,
 			       "Multipath offload doesn't support routes with multiple nexthops of the same device");
 		return;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 1123c8afcf9e..ffac0bd6c895 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -68,13 +68,15 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 #define MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS 4
 static int enable_mpesw(struct mlx5_lag *ldev)
 {
-	struct mlx5_core_dev *dev0 = ldev->pf[MLX5_LAG_P1].dev;
+	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	struct mlx5_core_dev *dev0;
 	int err;
 	int i;
 
-	if (ldev->mode != MLX5_LAG_MODE_NONE)
+	if (idx < 0 || ldev->mode != MLX5_LAG_MODE_NONE)
 		return -EINVAL;
 
+	dev0 = ldev->pf[idx].dev;
 	if (ldev->ports > MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS)
 		return -EOPNOTSUPP;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index f98f0735fce0..22241f52716c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -39,13 +39,18 @@ static int mlx5_lag_create_port_sel_table(struct mlx5_lag *ldev,
 					  struct mlx5_lag_definer *lag_definer,
 					  u8 *ports)
 {
-	struct mlx5_core_dev *dev = ldev->pf[MLX5_LAG_P1].dev;
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_destination dest = {};
 	MLX5_DECLARE_FLOW_ACT(flow_act);
 	struct mlx5_flow_namespace *ns;
+	struct mlx5_core_dev *dev;
 	int err, i, j, k, idx;
 
+	if (first_idx < 0)
+		return -EINVAL;
+
+	dev = ldev->pf[first_idx].dev;
 	ft_attr.max_fte = ldev->ports * ldev->buckets;
 	ft_attr.level = MLX5_LAG_FT_LEVEL_DEFINER;
 
@@ -293,11 +298,16 @@ static struct mlx5_lag_definer *
 mlx5_lag_create_definer(struct mlx5_lag *ldev, enum netdev_lag_hash hash,
 			enum mlx5_traffic_types tt, bool tunnel, u8 *ports)
 {
-	struct mlx5_core_dev *dev = ldev->pf[MLX5_LAG_P1].dev;
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_lag_definer *lag_definer;
+	struct mlx5_core_dev *dev;
 	u32 *match_definer_mask;
 	int format_id, err;
 
+	if (first_idx < 0)
+		return ERR_PTR(-EINVAL);
+
+	dev = ldev->pf[first_idx].dev;
 	lag_definer = kzalloc(sizeof(*lag_definer), GFP_KERNEL);
 	if (!lag_definer)
 		return ERR_PTR(-ENOMEM);
@@ -339,12 +349,15 @@ mlx5_lag_create_definer(struct mlx5_lag *ldev, enum netdev_lag_hash hash,
 static void mlx5_lag_destroy_definer(struct mlx5_lag *ldev,
 				     struct mlx5_lag_definer *lag_definer)
 {
-	struct mlx5_core_dev *dev = ldev->pf[MLX5_LAG_P1].dev;
-	int idx;
-	int i;
-	int j;
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
+	struct mlx5_core_dev *dev;
+	int idx, i, j;
 
-	mlx5_ldev_for_each(i, 0, ldev) {
+	if (first_idx < 0)
+		return;
+
+	dev = ldev->pf[first_idx].dev;
+	mlx5_ldev_for_each(i, first_idx, ldev) {
 		for (j = 0; j < ldev->buckets; j++) {
 			idx = i * ldev->buckets + j;
 			mlx5_del_flow_rules(lag_definer->rules[idx]);
@@ -499,10 +512,15 @@ static void mlx5_lag_set_outer_ttc_params(struct mlx5_lag *ldev,
 
 static int mlx5_lag_create_ttc_table(struct mlx5_lag *ldev)
 {
-	struct mlx5_core_dev *dev = ldev->pf[MLX5_LAG_P1].dev;
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_lag_port_sel *port_sel = &ldev->port_sel;
 	struct ttc_params ttc_params = {};
+	struct mlx5_core_dev *dev;
 
+	if (first_idx < 0)
+		return -EINVAL;
+
+	dev = ldev->pf[first_idx].dev;
 	mlx5_lag_set_outer_ttc_params(ldev, &ttc_params);
 	port_sel->outer.ttc = mlx5_create_ttc_table(dev, &ttc_params);
 	return PTR_ERR_OR_ZERO(port_sel->outer.ttc);
@@ -510,10 +528,15 @@ static int mlx5_lag_create_ttc_table(struct mlx5_lag *ldev)
 
 static int mlx5_lag_create_inner_ttc_table(struct mlx5_lag *ldev)
 {
-	struct mlx5_core_dev *dev = ldev->pf[MLX5_LAG_P1].dev;
+	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_lag_port_sel *port_sel = &ldev->port_sel;
 	struct ttc_params ttc_params = {};
+	struct mlx5_core_dev *dev;
+
+	if (first_idx < 0)
+		return -EINVAL;
 
+	dev = ldev->pf[first_idx].dev;
 	mlx5_lag_set_inner_ttc_params(ldev, &ttc_params);
 	port_sel->inner.ttc = mlx5_create_inner_ttc_table(dev, &ttc_params);
 	return PTR_ERR_OR_ZERO(port_sel->inner.ttc);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 220a9ac75c8b..869bfecdd8ff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -664,6 +664,10 @@ static int handle_hca_cap(struct mlx5_core_dev *dev, void *set_ctx)
 		MLX5_SET(cmd_hca_cap, set_hca_cap, log_max_current_uc_list,
 			 ilog2(max_uc_list));
 
+	/* enable absolute native port num */
+	if (MLX5_CAP_GEN_MAX(dev, abs_native_port_num))
+		MLX5_SET(cmd_hca_cap, set_hca_cap, abs_native_port_num, 1);
+
 	return set_caps(dev, set_ctx, MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
 }
 
-- 
2.45.0


