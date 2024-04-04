Return-Path: <netdev+bounces-84971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC95898D49
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 19:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8C2B25CFE
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 17:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119C212FB2C;
	Thu,  4 Apr 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DKuQDDoQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F42112D765
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252097; cv=fail; b=aPmPFpXh0oJvzDgzpC9ZX3HIcOeWMmQVvO4LUryiRFIR2QpzP78c40EFPXtywVs0VuE5siz3QGMG7tRTeZ/Yc3X9pNkDBDuBWS2kb925n/6JYGWXm3kUizlaB2JvPencMO825RwkEidVRjJsbnNd9rqZcy8JsE0niooCY8ULP5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252097; c=relaxed/simple;
	bh=samQoVWGgQBhDOMpVyk7UJdqW27OF25V0YQYaA7/xhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKYICY0tr1WZwJ3H9qSndq3djpc9rG1BMBmnbLUmktf0+Jysg+MTt4YbJyJ4pMskuWNEedPCMiEL/UAjUvaaE8yDCqatUrkxmgmzoiRtRdCwY5MBnbBafQoUjF5j9Q6LwhDO7n21R5uomMjXN/jWk1KD/4aRTiQEyBtv5b46FVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DKuQDDoQ; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd5EZFgv6Nax5lp69NdiPhKtls068biyY/6lJTXMk+TrfKgrXK1Ew80daBVsm1GZTy83Yj73Jq2dWrOcr8J+y/+hZzAuqNZoUk9vP5/8IHkcvzPaFH3EdjzA9SNC3nRU72k5R+lUPAi2y/1n8y1tqfuYkC3E0lGIfYNKvvIEQB1qsF1UifbP3zDdDEvwnNRfgzVPNXBaF5WzPckRSs4qTItDQbShjG7Lr/WoyGAQU3cJl14a3mbTodnjSQGEmX76AAyFoGQakG7Nzu6fjDDXa+bSC9wxbFPoHcJGwG56WCf3SA+XWv1H0FijEto+731ozMjncQbQgGo58YMrxnoTRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROVsO9SlIBSedRs87nXUr456pDeeDtUG3v2Falnm7eI=;
 b=YNCIuRS/uJGFNyxTb611nhIcB9brZowwqXzc1GJ5TQqPbKy6WYCCkchdvf3z6VSFvy0c9LLHLhZdbM0g3Rp8r+kibk5e4TIMgKrzb98CNDVoKEayqnvoCe0Pn13I46VMNdSdn1oOuKg3WmYXnpruxheXTVRngn6J/KkKmPTZRfjmPLBKs/oVmLxPaL/uBvCjmj/vNaL+s2JbQxFPe0gKxKlEEWMEsM1Uy3AVwnXqI7YzUJt1vAGICCAdrDt/y3+7NFWYHYWaPR+aiPCwr1BWiZf7JuvEnLLwruBdjx67wObqCoYwNOiVZl0RrOt4vakJra1MR/eiBrDG7ov3MiqQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROVsO9SlIBSedRs87nXUr456pDeeDtUG3v2Falnm7eI=;
 b=DKuQDDoQeWMvhgT16h2uUdMdKykyfRCopT5IUmqFLnOiMhTs42g1PSEnDjCiJeaGc6tbAl2KMft2hc/mPDp1fwotldxSNx29CcXTN3IOBeEkl2LJBXHSXNhNuRiWUnYWY6Q1n7AmM4aJS5gm1YJtJvz9ERnrkb32jvvDKNXuL4L3XjkwtzLWxIdgknW67d45l6Zn7qJgpSsM9mVEfVGJTKIk2vgWAOamI33wH1T4CgVZNfgWe1EzAEws3OEr72gqKj9+1Ro3dTN6TO1dD/RrfnAjkAlcaNkRK3Vs2HHQXU8eeXmb1lqc1YjbvSQU4cjtlWCBuumZu4DAbjkWlxcCCg==
Received: from MW4PR04CA0056.namprd04.prod.outlook.com (2603:10b6:303:6a::31)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 17:34:51 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::8c) by MW4PR04CA0056.outlook.office365.com
 (2603:10b6:303:6a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 17:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 17:34:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 10:34:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Apr
 2024 10:34:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Thu, 4 Apr
 2024 10:34:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 5/5] net/mlx5e: Un-expose functions in en.h
Date: Thu, 4 Apr 2024 20:33:57 +0300
Message-ID: <20240404173357.123307-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404173357.123307-1-tariqt@nvidia.com>
References: <20240404173357.123307-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c796049-3ac1-4830-103c-08dc54cd87fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MpOhv0iDZiBXHwMpEQgL2BRT3QdSeGme+rQaE2sv7R3pdrOKqMlfsMXD3fu5Mz+jdX7LIogFBuiPh5lv4VUmJ5ikhoHYPwnF1djZ5O3CzHErMKa76CpcIkOYDKj/bxp2dwyzLaDdhmhJFsNDaydbmtlOIHnMOkVmPZ0fMlJEW4+BtNvj/Y2EXni4PjZmYoOI6cjZGh9Wk8ywmp+l7+3pisBOSfQKkZ8UOvuFIwCndSPMQ2bWsqZ+tKRb7iFg/PjLgroxGNdLmPdflDo3Ve/MSTA4Chcx7MUlyEF8ywp8h4nlpI2X4XVWpzfL4g2DTdA6uu3rmdtUq6e9IDmyG/iqz5Yp3/zawqcplRjSH3AQfIB7nCuTc9m9sVH1SDJa13RabbWtzihATqoaWxSYne+kJXC82QPhJG3AZC9Nqopuf2xNHp2oIpKhaApqXLEck0rotl5VBWhaurYhWlJWU2qxP9C2TGM/jAaaSKKBHtFPdL6Jcm9HHdPQvbRqXBLxAI3/cpFSvdGvGdeXlTGzoi9CE9nCm4guBGcJMpCiNBVT78M51//y06FM0GPiCiar12Z2AzHCUUInHMI7r3hMRErNcw3FL2jz+HjxYy6ODcgLQ2RN8CM5cONB5BYs3vwNSc9vwh9gA7PXamvWqEo+t6/ECChH+CVa7sUDTzJ3MzFYPt8vDmmdCE1PypS1/7rU9nrC0CH5lD27u0K/W8VOx/b/dGoZHwcWW/77Uet+8l+AJWNPeEr1P38grhYcMy6nE4Xz
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 17:34:50.4833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c796049-3ac1-4830-103c-08dc54cd87fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709

Un-expose functions that are not used outside of their c file.
Make them static.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 12 ----------
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 22 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index f5a3ac40f6e3..2acd1ebb0888 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1143,7 +1143,6 @@ void mlx5e_close_drop_rq(struct mlx5e_rq *drop_rq);
 int mlx5e_create_tis(struct mlx5_core_dev *mdev, void *in, u32 *tisn);
 void mlx5e_destroy_tis(struct mlx5_core_dev *mdev, u32 tisn);
 
-int mlx5e_update_nic_rx(struct mlx5e_priv *priv);
 void mlx5e_update_carrier(struct mlx5e_priv *priv);
 int mlx5e_close(struct net_device *netdev);
 int mlx5e_open(struct net_device *netdev);
@@ -1180,23 +1179,12 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal,
 			       struct kernel_ethtool_coalesce *kernel_coal,
 			       struct netlink_ext_ack *extack);
-int mlx5e_ethtool_get_link_ksettings(struct mlx5e_priv *priv,
-				     struct ethtool_link_ksettings *link_ksettings);
-int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
-				     const struct ethtool_link_ksettings *link_ksettings);
-int mlx5e_get_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh);
-int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh,
-		   struct netlink_ext_ack *extack);
 u32 mlx5e_ethtool_get_rxfh_key_size(struct mlx5e_priv *priv);
 u32 mlx5e_ethtool_get_rxfh_indir_size(struct mlx5e_priv *priv);
 int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
 			      struct ethtool_ts_info *info);
 int mlx5e_ethtool_flash_device(struct mlx5e_priv *priv,
 			       struct ethtool_flash *flash);
-void mlx5e_ethtool_get_pauseparam(struct mlx5e_priv *priv,
-				  struct ethtool_pauseparam *pauseparam);
-int mlx5e_ethtool_set_pauseparam(struct mlx5e_priv *priv,
-				 struct ethtool_pauseparam *pauseparam);
 
 /* mlx5e generic netdev management API */
 static inline bool
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 69f6a6aa7c55..93a13a478c11 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -996,8 +996,8 @@ static void get_lp_advertising(struct mlx5_core_dev *mdev, u32 eth_proto_lp,
 	ptys2ethtool_adver_link(lp_advertising, eth_proto_lp, ext);
 }
 
-int mlx5e_ethtool_get_link_ksettings(struct mlx5e_priv *priv,
-				     struct ethtool_link_ksettings *link_ksettings)
+static int mlx5e_ethtool_get_link_ksettings(struct mlx5e_priv *priv,
+					    struct ethtool_link_ksettings *link_ksettings)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u32 out[MLX5_ST_SZ_DW(ptys_reg)] = {};
@@ -1167,8 +1167,8 @@ static bool ext_requested(u8 autoneg, const unsigned long *adver, bool ext_suppo
 	return  autoneg == AUTONEG_ENABLE ? ext_link_mode : ext_supported;
 }
 
-int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
-				     const struct ethtool_link_ksettings *link_ksettings)
+static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
+					    const struct ethtool_link_ksettings *link_ksettings)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5_port_eth_proto eproto;
@@ -1268,7 +1268,7 @@ static u32 mlx5e_get_rxfh_indir_size(struct net_device *netdev)
 	return mlx5e_ethtool_get_rxfh_indir_size(priv);
 }
 
-int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
+static int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	u32 rss_context = rxfh->rss_context;
@@ -1281,8 +1281,8 @@ int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
 	return err;
 }
 
-int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh,
-		   struct netlink_ext_ack *extack)
+static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh,
+			  struct netlink_ext_ack *extack)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	u32 *rss_context = &rxfh->rss_context;
@@ -1411,8 +1411,8 @@ static void mlx5e_get_pause_stats(struct net_device *netdev,
 	mlx5e_stats_pause_get(priv, pause_stats);
 }
 
-void mlx5e_ethtool_get_pauseparam(struct mlx5e_priv *priv,
-				  struct ethtool_pauseparam *pauseparam)
+static void mlx5e_ethtool_get_pauseparam(struct mlx5e_priv *priv,
+					 struct ethtool_pauseparam *pauseparam)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int err;
@@ -1433,8 +1433,8 @@ static void mlx5e_get_pauseparam(struct net_device *netdev,
 	mlx5e_ethtool_get_pauseparam(priv, pauseparam);
 }
 
-int mlx5e_ethtool_set_pauseparam(struct mlx5e_priv *priv,
-				 struct ethtool_pauseparam *pauseparam)
+static int mlx5e_ethtool_set_pauseparam(struct mlx5e_priv *priv,
+					struct ethtool_pauseparam *pauseparam)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 81e1c1e401f9..a0d3af96dcb1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5562,7 +5562,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 	mlx5e_ipsec_cleanup(priv);
 }
 
-int mlx5e_update_nic_rx(struct mlx5e_priv *priv)
+static int mlx5e_update_nic_rx(struct mlx5e_priv *priv)
 {
 	return mlx5e_refresh_tirs(priv, false, false);
 }
-- 
2.44.0


