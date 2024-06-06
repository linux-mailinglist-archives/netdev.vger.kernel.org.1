Return-Path: <netdev+bounces-101558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB508FF5FD
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 22:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2B51F2232A
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 20:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4E81993AF;
	Thu,  6 Jun 2024 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h5ntt40E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7319938A
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706064; cv=fail; b=kGG921mr7vImab01YNlgVxPxPrwFUW9hFJhRiLXZ4yvsQN3hYXW0FIKlEgKjddVocyiOc79mX5cpMk90bgsl980simW4FVZ95ToD+Y8qrtp73JGPcLz64fq+18vz/XZsR/9cnY6PiAfeRHu7/noyqeb/OGzSWK7ZQ87dHuyzpoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706064; c=relaxed/simple;
	bh=RQxE8oWngfwPRvUvT8e9g3XOqQ0pFY/6e1BAVOWhQMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHfLSpRboYT2O4gZHKx4EcekxSHsUouKb6BuJmYg83xpSre7oHTapu76KOAomkkxoF7rx6v9v6pRmuX3gGqzAuSl9eKkFS3uyQJh26v8P3fCJu2v/lv0EF1RMXwOxz9RdnqbLG4rWNAwLqyD7wGvDEs84cbcLtcap2jLHkePxq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h5ntt40E; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA+WcJCAqEEd7DxQvA4gFz7GmNUXVSZRFDBBq2tWFJRf9N107D0DxkqiwOX9mAzF4N80DB0m3ZID+LUgvBUY1fydKNNghxShN0nGGbYo8HR9dTMvCFzVCHz4ENI75gCr4aSBrme31UbmjwJoU5kNPHXySL33olI+xios22pvFbv0N/bLlWJfOgbdLHqM8PcrLpNZu29ir/G27E2vzNa5bGkbR6+UAPJ6sUVinpI2xfs+4UY/KQz29vo3iUMWdaRuK7OjjFH2JW5V1ERY0e1q0mM59FoPEVVMYMl96cRQqZADkgtxWtDnZf60w9vP60erecMX5E69pkaffpU9ZNoQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUZU00+JCG+pVGqgR4dptVN6qEjkKxuJGfI8xvb61TY=;
 b=VC/PVqTCDk8HEAX+J3BxX1Hl11d86QG+uEAV8h5liTVD5CkgmoYVqHrFPXXw4MXuNy2Groy2GRE3tSmfofVRv0SiZ/IqCjflNU9o6mn+PEblnagHkDSSD2Hr2SoVtX23cHCTfT0yrEfXvNJZgQ0oWRCQcWeyGI305h3Pk8meAYORU9w/3kQtXzvANLDBcLuROz+TNrrmhoqquDPJj9dVNVjO/qZjqxqrJw7UhjiMM61q4yYs0sw7y9XJ0pXT9A/3tqLdmBjEo46Rk3/mc6RXh3/kzo8j5r6DZPPG/pShPQ70JZu0ZBBz9nOh7oNqvUZaV8LaM/B9xG1UMn8W3utY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUZU00+JCG+pVGqgR4dptVN6qEjkKxuJGfI8xvb61TY=;
 b=h5ntt40E9sIS+ktyVhuOri0Ft4xKCWNTOqxBoPvWant3pRTw4DXuA5DB2mcrQQb9OU3eXnn1CoI0uIHHMYi+HM1b5z19gd6is/5bL9ikhd4U8YmzwpedWCrH9YdC2zLuUqBoioCxYmoX4hwDOywUPavfa03j+vQrGeBNAq+VnMhmDbMuRwEpPmcxSUV/ET0LLWmFlq6e4H7OfJ5PoB+oS/Iz9DrTfEVl/KMtKpWSSudYPhGNhq3xqpjyIhDJ22mGDimosFkRaetU0y/24ZdYs9nH7Zx7wgYYY1u6l17COEJf47+aTxDtlvX0hF4gLoZE9us9rAqBbN9JZwfzjYVKQQ==
Received: from MN2PR19CA0044.namprd19.prod.outlook.com (2603:10b6:208:19b::21)
 by CH3PR12MB8849.namprd12.prod.outlook.com (2603:10b6:610:178::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 20:34:20 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::cb) by MN2PR19CA0044.outlook.office365.com
 (2603:10b6:208:19b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 20:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 20:34:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 13:33:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 13:33:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 6 Jun
 2024 13:33:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 2/2] net/mlx5e: Fix features validation check for tunneled UDP (non-VXLAN) packets
Date: Thu, 6 Jun 2024 23:32:49 +0300
Message-ID: <20240606203249.1054066-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240606203249.1054066-1-tariqt@nvidia.com>
References: <20240606203249.1054066-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|CH3PR12MB8849:EE_
X-MS-Office365-Filtering-Correlation-Id: a618db4c-52d4-4ac9-7a0d-08dc86680aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Z3rxLhp1/j8JmJYWo91d/6vtKzEVcjSRMPfBN2e1Y2kjAh9VttRNCtDBlDq?=
 =?us-ascii?Q?20OS9NAILvlIhZwzhPYRTMT6cozYThNEwTMM5uV6jfyV+a7WhN910fcHL5bh?=
 =?us-ascii?Q?8Mxlbwq6bvZmTtuWdTgVHWA7RyIFMMJLGOhsfInJOqrKY1nduYIyhrpjaHlz?=
 =?us-ascii?Q?IzenJFl9QCVaqKPvJoVR0JmlwIWnNtfTj5Z/KmCTu+6F3OEceRqGSMN4Dygs?=
 =?us-ascii?Q?I7ll2CUq4km/kREXZitK055KVdGLCEGCxOzooCpSvsajt8kfcUg5fvTVD8ZH?=
 =?us-ascii?Q?ib5Tko3xki2dh5VWfwvVX7oMST59MO2SkwLLDA6q5gNZoZGFToZEcGcz74P+?=
 =?us-ascii?Q?UefWaoiPmtmrn4ewfp8oCJnAeFW9hkR5wcJ3QFDEqQ9rqdvhA6NZAXu+OXHZ?=
 =?us-ascii?Q?r4CUhN5xnl01VSgsrEBye7k8aSnluObCcqBNYt730qUAxsteEkvNeQ9DowWE?=
 =?us-ascii?Q?xhkCOcbNvqT4P88DOkpV9GZQh+7BEtteOhNkbkMfDPysnnfstvoCOWEApqsS?=
 =?us-ascii?Q?WO87U/+loFOADsYEtf/gBM5tWBiaMx1LN/6NhKrebAr+hwpFJl5eHUbRFwgx?=
 =?us-ascii?Q?lFEz+zLA4MxT9ycItQ0BgmB9NkijHMvikvee/EXnZQf1/K1OZBW9kX125mBj?=
 =?us-ascii?Q?UZl07DYr8Pbh3A7shOw8DOdzUC7zxnnmr97dj+1LfMaWG9ZKK0IMDPaQxWo7?=
 =?us-ascii?Q?gyMqrCeenfjDm3cnvdxmNk80MCLIqEaV5lv4Kf12e16O0YhUbxmV+loUDIY7?=
 =?us-ascii?Q?ZFZZH4Rj2Cuof+dymWcLlqe9jZr88+FiMvL71Ul8amSsRARaTnqxuySqacrT?=
 =?us-ascii?Q?rviiJ+3A2tMNpLGcNoSXCW8fFmeMUcIY8lPvvMFqgaWYh3GjTOusp4/xEz8B?=
 =?us-ascii?Q?Hx++9htnAbHVMz8tnIAtgndy+ULXAm5n+PET1ECGp/gA1OkLgA2GQgRCld11?=
 =?us-ascii?Q?w5uAMck1WXfIZn2Hn3+++hs2p8HW6Y74pgF65GyzBKyBZgCI4thyiByA6Yxh?=
 =?us-ascii?Q?zN2Obf+YQ3w0K4PsEIEUNxFPzDPw7tFi0Wp8WLZAZLVTOHjMMacKkZk0llK5?=
 =?us-ascii?Q?U2seKXAFx53zUy+xzi431EyIa5LoRJMpHOwRDVgWDr5Lb7BV6ZxjmQyMmoer?=
 =?us-ascii?Q?apFpHXtWqKKgpc7xidDTLsv2FRI+Cm08by290zE2YK0iu/dtIAqOHHbNbTWy?=
 =?us-ascii?Q?x4c0s5LVNeGsqHVlBr9lDkzdMkTpSBECBt9hFQvTg3/c7If3wN87OS09YbUd?=
 =?us-ascii?Q?dCQjj+485kjikNjFxsdDNVRAma7cuvp9wjiFipDoeq38rwaGU0CqlcEUhGlL?=
 =?us-ascii?Q?hOSc84zytXNDuswUKBuY2kSjKH88cQvBaAOkS5QWKJRhJiHOlHevID8wMHeb?=
 =?us-ascii?Q?NlKB6sWDFYRy+/6bD6OYaoffj3ea38yB95SJuk6Hn7adplkjlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:34:19.1664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a618db4c-52d4-4ac9-7a0d-08dc86680aae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8849

From: Gal Pressman <gal@nvidia.com>

Move the vxlan_features_check() call to after we verified the packet is
a tunneled VXLAN packet.

Without this, tunneled UDP non-VXLAN packets (for ex. GENENVE) might
wrongly not get offloaded.
In some cases, it worked by chance as GENEVE header is the same size as
VXLAN, but it is obviously incorrect.

Fixes: e3cfc7e6b7bd ("net/mlx5e: TX, Add geneve tunnel stateless offload support")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c53c99dde558..a605eae56685 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4875,7 +4875,7 @@ static netdev_features_t mlx5e_tunnel_features_check(struct mlx5e_priv *priv,
 
 		/* Verify if UDP port is being offloaded by HW */
 		if (mlx5_vxlan_lookup_port(priv->mdev->vxlan, port))
-			return features;
+			return vxlan_features_check(skb, features);
 
 #if IS_ENABLED(CONFIG_GENEVE)
 		/* Support Geneve offload for default UDP port */
@@ -4901,7 +4901,6 @@ netdev_features_t mlx5e_features_check(struct sk_buff *skb,
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
 	features = vlan_features_check(skb, features);
-	features = vxlan_features_check(skb, features);
 
 	/* Validate if the tunneled packet is being offloaded by HW */
 	if (skb->encapsulation &&
-- 
2.31.1


