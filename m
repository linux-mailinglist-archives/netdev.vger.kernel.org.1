Return-Path: <netdev+bounces-116706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94BF94B670
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02326280FE2
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDCA13DBA2;
	Thu,  8 Aug 2024 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WtBU0fNH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8318455C
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096898; cv=fail; b=m20XMPQAArRpO41+I6yk51Wl0y0c1CPDnaeLRjgCgb8SfVCvMjRTjS1wJFJLSXVYMBZ1SCZzDTZCodjQG9R+kKsSUH5CTFutcPXFF8WtPaBYUBnGjvCO0bARi2nk9fX9KtMNT6UY1lgb0VIQ+WliQCUH5yAxXorLH8i7cNeOipw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096898; c=relaxed/simple;
	bh=2MH7qsSqxTeezX6iQ34hCjKTNBtZuowhlxKAtwjAHfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrGBOaph4XO2+2up1QWP2oBASJ/fP2cI2UFdneaWUApPHvfKfWpYPRioQT6rgg9qnS0HCE4bE35kn7CG6R3WfdveMZobvstIFY2yNkIu5+GKsI3+at7k/cbNxDVY2Z0PFw1mFMRuqRPCnye7x3GzApwdyNLxzqIeSQQrQ07u+HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WtBU0fNH; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZlBdrD4dhR/dPoLPCE5/tACoOZTL4HMF8Iv3Vn2bSHO8OzrUaqYNK9GjVZ8OPLJnZvnYsFRChbbCi5b/tu+bfbIAZMs5U3jVaP+/1671TsCp10TdjD/pL3QY96Cq0gRgdrpZGTsr9loUjn6CREtbXnzD+FOw1oasQe0TI/g5opUmnRr+nx6Wpfnx8qG+8+ZwnQ3c1y3vR7aDB884vO8Y+WhY5jYn3V/Ly1/fPS8cfxciNlSrWr9BUmQTMixarOMfF1bFRrb8UCdioyBZeee/b0dWq7JDmYjJxJXpPLMkueuMtOfsc/b5HjFvG6lph7saeI6sGr4Q0CtoG3dHQ5xKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brbbDhWugk22VQ8Khi9Ywv9xEKjzVTEylE8mb4aw1WE=;
 b=pjMs6Tc3+t+0NBxJogAZknyEQkbwSnscPa8+6XHIioCjxv0+SdWvmLG57mIPg0C+s18JIoSmKS3984FckIVxDE1Q8tQ/9Ki32vAkzk4TEFPhQHtxdCAevrd/+0BTdYq1cPAvUNK8T3UdwKxCNYH/IierZH3JmBKoRQqBcPv1zz4TB1muSktpnsyalpGktsF6P4cQcRG2BS/pbooUylqM3pubhWJL9tNBQB2g1eh8/7jXMPypwPiZza05RJPAGwnuDK/MQnxZpsMn1j30hwMOVJRz0zG0U1NnAgyV4XIqUIyCPuHlXgVKVdMaiXpwf/HWMO0XCw5c49DY7wfNV6APaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brbbDhWugk22VQ8Khi9Ywv9xEKjzVTEylE8mb4aw1WE=;
 b=WtBU0fNH6ofT0fNrnleQDnWuI+NP0jEo0uC05+zWvRNtyffPs7ofMG7iM8DczrPrPUcNnrAOVNMgnDfHMOh3huUmwjX0b5GlALyrwNq6C+3TE8pe/N5P02uDt2tki+Lw6IZDZz8C/EIzBWXUoAI6TcYzfOO4uTJTqesBBye+OtT2gmprDoArf/VOSkIRZomo2IFqLOkpcVSOEP+JzsXV3+WkMvG996iHgTfFjCysFuPNqglTJkSOiuGsqMFDxiAjZWx2nBq7ZZE5nOhydOjJdb4EfUA0hjVsH5kl8a5g0cf0I8xUjwWuGo7CozUWsEuwSi0oQzsn3JdVRT216U69Yw==
Received: from CH0PR03CA0438.namprd03.prod.outlook.com (2603:10b6:610:10e::14)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Thu, 8 Aug
 2024 06:01:33 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:10e:cafe::ef) by CH0PR03CA0438.outlook.office365.com
 (2603:10b6:610:10e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Thu, 8 Aug 2024 06:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Thu, 8 Aug 2024 06:01:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 23:01:26 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 23:01:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 23:01:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 07/11] net/mlx5e: Use extack in get coalesce callback
Date: Thu, 8 Aug 2024 08:59:23 +0300
Message-ID: <20240808055927.2059700-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808055927.2059700-1-tariqt@nvidia.com>
References: <20240808055927.2059700-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: e306d16b-9d2f-4982-94e8-08dcb76f8dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PJRzxUO6iB4LEOrfwTU4ySir6DDpct7bF2VYSyhWOvxlhy6eoNZGn4F8Y7mz?=
 =?us-ascii?Q?jsPoTCJ8xGtUVnDd+J3KszdZIaKwvlYFL3zkYXVnCRb46uk7r/tJCdYBGNmc?=
 =?us-ascii?Q?upRDhbNULGn5O+dXuBrUdAtKyz3EpW838A2/A3hWz0YaV3lkinaKFmnjKYdj?=
 =?us-ascii?Q?yEp8Wj60J6MAXvRwVV1Ky86QFhv/wKLfFf2LhzD2VglH5LaRfFcHDZh/iUEc?=
 =?us-ascii?Q?t4oxY0hm7BVF/N1S9O+SJf9qQzA4/ISbGba/rGKZnfju2WA6kocUyW/tvkuU?=
 =?us-ascii?Q?HM45zoDo31Hozz86GUX54kQoZxIOB0vVeJTza9eIv+vgDsSKl1EBaKNcK+cp?=
 =?us-ascii?Q?DlJSSEXUg1ehbkU+UPn6GkIFQio78GWitvlDu9/4ncoOIL4C8tQwbQkl8zhV?=
 =?us-ascii?Q?zGVBG7qHCwS1HZZuZKl090/ffC3WERDpd8Y3onvggr+pO8UKni+08r7XVNjF?=
 =?us-ascii?Q?JMlGg8INXpauRtY0mWoPpk7Nh/Mw524f4wxNZ7TlXPCfP4vpS7SoNlvRMHOw?=
 =?us-ascii?Q?THu3DYxD459IMfoqSf/OI9nMAGQY70YNKcra38QFSePpL+JBO/FYfx3jj+ZF?=
 =?us-ascii?Q?BU98yEp+W3SaXI4U+tlmHocANZPtHcjl4gO+IN9eMQr3CHX3IIldqrm1uKZb?=
 =?us-ascii?Q?LWiloZbYL0S6xAuSouQ5BYETZWhAum81LgdA+0Ov+w6cxQw8VCL5+nuI7+ZS?=
 =?us-ascii?Q?jdNXebBAfHkoG5aS/j3l2tcHU8n0UeiQk9xy8XUCb/dA3IzIgKj09MSthvMi?=
 =?us-ascii?Q?qE4OR0GTSCdmIVfJQi0oaThG8/b94h2RDJx5d5upFmE0H+zpGAYJ+2SM214W?=
 =?us-ascii?Q?9InM+gJvSMhlYVA4HjzmO+rg7zCemZ9GhG6EnSgCx2Hnhl7LAR+du13jSdip?=
 =?us-ascii?Q?fP0qEXRc51fVgy11luD5KCL3olH+iNo0ysfjd5qWdzAEBDYTpXYi8w4Jwz3e?=
 =?us-ascii?Q?n+sL8ubbv78GEnroBOTd9QPgtEEsj/IaTFRfCDZnKagQguaK4D5TTNaMV9Q+?=
 =?us-ascii?Q?ygxjbyEOz/phye5W0g2laQ3cyBzU7+Fa5f94wN8FSOYGx8hHohy9qy1YVsfe?=
 =?us-ascii?Q?78tDkT7ndb9Hjg/L251HFI0QMdKg7Xnujkknuv+TfNp6G5QyI72+s+E/VsjD?=
 =?us-ascii?Q?anfk+6Nl7U2PfsN4dHkgTxf1+ra/T+2QgnD0YHGFr+wUmPP5Zjjvx0BWDFX0?=
 =?us-ascii?Q?vmt7uaa9m2ngWdFy9LqGa8lWm7GZj+MgrZNYoA+gMY4mLOcnpTqffJ7qDkra?=
 =?us-ascii?Q?pKLboP9VhDSDRx7l0cN1cdINIxH614YaCzXLnpFC6GQXyqbg4ZTWt/ziLeOb?=
 =?us-ascii?Q?gv99nDuQupSErkjep+gJ+qiPAuG83VL50SOdh0d47DL0af3BJSEYCbMaBGYT?=
 =?us-ascii?Q?ctqBVchwjIwIrngo29DFdQS30G2EGTBQBUCpLiTWQsaCWTi+Gu7E9eF6ywc2?=
 =?us-ascii?Q?HxAOL3AizYz0s/HlDAgjPZ3FEnydHrpk?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:01:32.8706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e306d16b-9d2f-4982-94e8-08dcb76f8dec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

From: Gal Pressman <gal@nvidia.com>

In case of errors in get coalesce, reflect it through extack instead of
a dmesg print.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h            | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 9 ++++++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c | 2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 01781b70434c..7832f6b6c8a8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1180,7 +1180,8 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 			       struct ethtool_channels *ch);
 int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal,
-			       struct kernel_ethtool_coalesce *kernel_coal);
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack);
 int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal,
 			       struct kernel_ethtool_coalesce *kernel_coal,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 51624053722a..9760215926db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -545,12 +545,15 @@ static int mlx5e_set_channels(struct net_device *dev,
 
 int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal,
-			       struct kernel_ethtool_coalesce *kernel_coal)
+			       struct kernel_ethtool_coalesce *kernel_coal,
+			       struct netlink_ext_ack *extack)
 {
 	struct dim_cq_moder *rx_moder, *tx_moder;
 
-	if (!MLX5_CAP_GEN(priv->mdev, cq_moderation))
+	if (!MLX5_CAP_GEN(priv->mdev, cq_moderation)) {
+		NL_SET_ERR_MSG_MOD(extack, "CQ moderation not supported");
 		return -EOPNOTSUPP;
+	}
 
 	rx_moder = &priv->channels.params.rx_cq_moderation;
 	coal->rx_coalesce_usecs		= rx_moder->usec;
@@ -574,7 +577,7 @@ static int mlx5e_get_coalesce(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
-	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal);
+	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal, extack);
 }
 
 static int mlx5e_ethtool_get_per_queue_coalesce(struct mlx5e_priv *priv, u32 queue,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 916ba0db29f2..b885042eef14 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -386,7 +386,7 @@ static int mlx5e_rep_get_coalesce(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
-	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal);
+	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal, extack);
 }
 
 static int mlx5e_rep_set_coalesce(struct net_device *netdev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 424ff39db28d..9772327d5124 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -132,7 +132,7 @@ static int mlx5i_get_coalesce(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv = mlx5i_epriv(netdev);
 
-	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal);
+	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal, extack);
 }
 
 static int mlx5i_get_ts_info(struct net_device *netdev,
-- 
2.44.0


