Return-Path: <netdev+bounces-116708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1A494B673
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A47C282473
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891A918629C;
	Thu,  8 Aug 2024 06:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E6gQYZ6C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7F185E68
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096901; cv=fail; b=K1i7DMpUmjofoBu9FpoPApsKSs8IVr3nzPlyfdVE1sSe15peoMq6DluNw9v9j2U0WZocV16klQ2+5DWJS76ltLWkbePjEsyow3zuk6p1axqJDHTiZUyfFZjcCrserwfIfig75tQ5x4/S0kK4lLcII1ozVtvcCLV+XTlQI0TaZ9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096901; c=relaxed/simple;
	bh=gDfoxUw5PjBiRtlCYpDvxusUEhWTh71zlLMgwIv/mqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Flh7CYLZCmu/C1Tx5efEc/2vihfdCd/190wtcZVTyO06SOeD69KySuyLjezpEIW2/tP7rPcLPSmUCu39MBb6zD59T54j6gtxy1sxVWoEKCPGe1JSwDpRU147q6U9ALeOwUKivkqPHdWAVlKQFvWopZMeWeuE+a82TS8RHXpN6WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E6gQYZ6C; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byDtcsOLeQUMEf6aXumXA+XFYkGW2F/9ijTjFBhDuTJOcju4oP0j4meIIo83mOHK8X0v/sNDKBJ7dWTFoeMheJOzSd+DlNaUBPDKPhZYO1ctPPsEevuATB1PeV9vyN8Q/2qMOf1z3fywf1V76eK6NFvKWO3u8Bi1W0lDrqWRtfbeJKf+dCoNbborFAVaNHyJv45iPRiK5SnRIUsela0za/+IkzJIL1nzDY5UBuoy3yu7aF8VqLP2v4NE/j9TBgbpZRdA9Rk16NT5X8UTJoQ49iKKTvFQqXeA9XPEKmbkeGG0tRDodUVmiX33Ebwfv+kVwg0lOBAWYaBP6AiPFclEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EPiTuKb0wBZYofRvAVxM+x77V5UgumTeg8Mi2wG5hM=;
 b=wxgKji6C0q8ANvdpHg4YqSWuC49nXjMg8LbHKzeHW68XvFygByjr5MR2lJfTcrys836ZnRjtYv4VxFE537/R2Jl7/KYFHgdfiMvzve1HI+3ZcaVH1x5utCHsgo2vcbe5GR/QhNqmdNKZ5MeTCyA7I0yKCBkvSxCkTVL7VtOi6gxsDu+FRFV5DORxkju4mKmbLF420aXN9WcZ8zpu3vV9ZXnJctXmSI5vWBEK9wgF+8CmsLQsIgX67RZNWAcdmRSeTniy6E0Oe9a1MdnDSOO6oO54ZIYzURbHqXiShrx3oFGxbm2leUctFeZ6lplguslJh5tcoSZu91di4KMBTOiiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EPiTuKb0wBZYofRvAVxM+x77V5UgumTeg8Mi2wG5hM=;
 b=E6gQYZ6C+cLQt8OIOoH51sTOu/C/h9pQb6tAsPMXoGN2t8l445N8OeXLtayf2gp6bjkFv8BDgkYV0o7Gbu3L9XcJc3HI4ZKRoU9c9Y9VC+6ye9NYpws+a0hwYy4Ue5YxgvVeO2eFosG5gxhfu4NdcXEbaveJmSsaINFeSCkWP4G2Bxkgax8nb9kiYa5lRAkLkErM/pZ/Vw0Jx/6C3seR0ZZtrlBE78hZNios2g+X1zh4nAzBxGIWWHOQQIpaUrlf8TnP597bGTjzrKHQV4Hn+21nlpb8xT+P1Ht1ratAHHqEWqsJ1ewmAs/IjwKn1vQG2GTW1BAtTKWhAl5DXoyeMw==
Received: from SJ0PR03CA0252.namprd03.prod.outlook.com (2603:10b6:a03:3a0::17)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 8 Aug
 2024 06:01:36 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::7f) by SJ0PR03CA0252.outlook.office365.com
 (2603:10b6:a03:3a0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Thu, 8 Aug 2024 06:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 06:01:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 23:01:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 23:01:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 23:01:20 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 06/11] net/mlx5e: Use extack in set ringparams callback
Date: Thu, 8 Aug 2024 08:59:22 +0300
Message-ID: <20240808055927.2059700-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: adf58ee2-b038-460a-0955-08dcb76f8f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ZW7IZNJ2hxugFJ+B83MbzgECdiQYj2X7xKWLbAwdW+tmZZ2vT0Yjkycg0BC?=
 =?us-ascii?Q?AbFv/sO0XPbCFflUaiQeN4JfA0AXg5TfFYE15mJPxEaJIKajfRmaLEHBjCXQ?=
 =?us-ascii?Q?GPqN8bgphzKjGGcgeWM/nYbGq9ujcqwmO54lzbKmU5Gas42yXEqhxGIstEid?=
 =?us-ascii?Q?klfGgCCfRSBay2Us3ltU4nVwHCAAv8xkYGYcOcDsDB9PUYylJPLjIbJj+Jdy?=
 =?us-ascii?Q?QQexzIQzvmDBt60knJIEIqmfCp9fe4HsCgUVLnmoTAQU9UJQC+EGl1xITDTP?=
 =?us-ascii?Q?FzYL9vwvEOikfghvh1ig11TlWtvkjDpqRcGX4X+RnSwgRX2/YylyHnIidZLX?=
 =?us-ascii?Q?OX33DfILlYRc4C8fFYLCW5ETO/7EsdmJK+6QOn1Y2+HM5a6E8hF6VzmFxA2j?=
 =?us-ascii?Q?hARupWEW7v925aTCkFn+nJ55871wuWuxsuvkVnd1Wj2fI2X3qHxgoFOToDYF?=
 =?us-ascii?Q?UYWyXluVjvUjTCw06GXPl40RtmnwH7QU+sD3QX/FycgLnvg6Fy2LmdsW/o66?=
 =?us-ascii?Q?iKccH3ccWJaGUJI2oTtJKw6UCHliROpdAmHKDQ9SJbXdB99BJQsruuh4T2Rl?=
 =?us-ascii?Q?kTGK4BjeDBf9Imh7YIzv0D2ihKw905xJL8OfEe9EH3WV1//8s4FUoF485MR1?=
 =?us-ascii?Q?bJJj1KnZXNmwmmfvDZjOcBkUpiXG/CbK28Ww4r3JMgsY2rD9W2NSnkSRXE4D?=
 =?us-ascii?Q?JC1/I9e9f0apTXQ+8i8czMJNBG7ZuLWST1I3viIFohtSuScFb6i6a2xOoSu9?=
 =?us-ascii?Q?iE/tIx/UeDLqMbG7ccRVgFWST2hM+tJUSwkAYpUEcAhtHqtMgJJooxGM73xl?=
 =?us-ascii?Q?6CqjiS4juOteOb1IqA/HdqEragxV5pRbtwPaBvajVK8rAwz2arHLZHufI9dX?=
 =?us-ascii?Q?l0fsS0YBnEUzAavOvEYcE8FRRy2T/zf06OiAMjm6zkKjL3DS9ox5P0I9qyy+?=
 =?us-ascii?Q?XQin7PSprBDPN+v+bAS8nu9h5u1K+jTxHhcdHVhXbyT5tnVGz3Q13cwmahZG?=
 =?us-ascii?Q?NrFZQxxab4SsJIMOZsOJ893t6yZQqm11Nbo8sI+zWJlIz9i0xF7/CXYVF44B?=
 =?us-ascii?Q?5L3oBUXNo2vGRpNe/hk9JVFgE6HG9iKqMT+PQQx980cReHWyeqVjkYYQ822V?=
 =?us-ascii?Q?Yq/MsGtpwmsQ27ZxJFLK1NpCFLlELoEtQchD4AKCnYDJphwiGXbsXqGgBeHi?=
 =?us-ascii?Q?Afc8g+IpaAq/R8oX8+2JqhSccL/wifP5Y08cBaDitfWLjgbkWjk3kDDUKVOH?=
 =?us-ascii?Q?UTfg7kBZ+kqQ6Lkzol6MLmPNpO9qlbv7UGoewggVuls0Zct+cHbTIqdREZd5?=
 =?us-ascii?Q?+aiylc3fRBhdPXQ2da1UVpV+xPz885rT3U3hItACt2paLC6GDJ6RZbmyUcuK?=
 =?us-ascii?Q?t5SLV+xhFSocZ3FWEhCOg9rttlaLqF0wX3YDf1m1QyPvbYOobhQLazL97ZrJ?=
 =?us-ascii?Q?6y94IGb7C0Tn2k0MCo4/tL9bmr4sK36N?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:01:35.6861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adf58ee2-b038-460a-0955-08dcb76f8f93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150

From: Gal Pressman <gal@nvidia.com>

In case of errors in set ringparams, reflect it through extack instead
of a dmesg print.
While at it, make the messages more human friendly and remove two
redundant checks that are already validated by the core.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 28 ++++++-------------
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  2 +-
 .../mellanox/mlx5/core/ipoib/ethtool.c        |  2 +-
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 5fd82c67b6ab..01781b70434c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1172,7 +1172,8 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
 				 struct ethtool_ringparam *param,
 				 struct kernel_ethtool_ringparam *kernel_param);
 int mlx5e_ethtool_set_ringparam(struct mlx5e_priv *priv,
-				struct ethtool_ringparam *param);
+				struct ethtool_ringparam *param,
+				struct netlink_ext_ack *extack);
 void mlx5e_ethtool_get_channels(struct mlx5e_priv *priv,
 				struct ethtool_channels *ch);
 int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 5fd81253d6b9..51624053722a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -352,35 +352,25 @@ static void mlx5e_get_ringparam(struct net_device *dev,
 }
 
 int mlx5e_ethtool_set_ringparam(struct mlx5e_priv *priv,
-				struct ethtool_ringparam *param)
+				struct ethtool_ringparam *param,
+				struct netlink_ext_ack *extack)
 {
 	struct mlx5e_params new_params;
 	u8 log_rq_size;
 	u8 log_sq_size;
 	int err = 0;
 
-	if (param->rx_jumbo_pending) {
-		netdev_info(priv->netdev, "%s: rx_jumbo_pending not supported\n",
-			    __func__);
-		return -EINVAL;
-	}
-	if (param->rx_mini_pending) {
-		netdev_info(priv->netdev, "%s: rx_mini_pending not supported\n",
-			    __func__);
-		return -EINVAL;
-	}
-
 	if (param->rx_pending < (1 << MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE)) {
-		netdev_info(priv->netdev, "%s: rx_pending (%d) < min (%d)\n",
-			    __func__, param->rx_pending,
-			    1 << MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE);
+		NL_SET_ERR_MSG_FMT_MOD(extack, "rx (%d) < min (%d)",
+				       param->rx_pending,
+				       1 << MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE);
 		return -EINVAL;
 	}
 
 	if (param->tx_pending < (1 << MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)) {
-		netdev_info(priv->netdev, "%s: tx_pending (%d) < min (%d)\n",
-			    __func__, param->tx_pending,
-			    1 << MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE);
+		NL_SET_ERR_MSG_FMT_MOD(extack, "tx (%d) < min (%d)",
+				       param->tx_pending,
+				       1 << MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE);
 		return -EINVAL;
 	}
 
@@ -416,7 +406,7 @@ static int mlx5e_set_ringparam(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
-	return mlx5e_ethtool_set_ringparam(priv, param);
+	return mlx5e_ethtool_set_ringparam(priv, param, extack);
 }
 
 void mlx5e_ethtool_get_channels(struct mlx5e_priv *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 8790d57dc6db..916ba0db29f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -360,7 +360,7 @@ mlx5e_rep_set_ringparam(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
-	return mlx5e_ethtool_set_ringparam(priv, param);
+	return mlx5e_ethtool_set_ringparam(priv, param, extack);
 }
 
 static void mlx5e_rep_get_channels(struct net_device *dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 26f8a11b8906..424ff39db28d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -74,7 +74,7 @@ static int mlx5i_set_ringparam(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = mlx5i_epriv(dev);
 
-	return mlx5e_ethtool_set_ringparam(priv, param);
+	return mlx5e_ethtool_set_ringparam(priv, param, extack);
 }
 
 static void mlx5i_get_ringparam(struct net_device *dev,
-- 
2.44.0


