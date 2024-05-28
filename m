Return-Path: <netdev+bounces-98626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 252658D1ECC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BABBB2326E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCC216FF37;
	Tue, 28 May 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVQva0Sf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E81DFDE
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906575; cv=fail; b=YYnmUpAxSmSiRYfbfA+jCikKHWiKoxjGaMcGlEiG0Faw1AXML83mWX6Ll4aZqg0do3CUdVQFq5WVaAjhfIa8ggE2f4qDZffsfCw+UMtV+WxQL5loPN6l2CUANzV0iPhuJ1Y7/vo9DBZkt6ZTwkL0Jx9r9B7kK1t3Ohhd6Ne1IHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906575; c=relaxed/simple;
	bh=tBzWpNP02/j8YnGjTDuNDQ1QXFYPwPbB4MvGbMdkBzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIb/oebbQ7ZFS2X2y3CJxtayUBwpwMnm4rav5zUFW64ZZjpOi7mXjnto0q5QBB40T3vgmQvBio2u49O29zn9tTjbxxwUj7UO9h2vNDBMxlsWL6OUNKR0r9ZxihLdkevTDLzaTv96yRh9LolWa5ZFvU4r2qTmgS/gP1ehjbb6Osw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UVQva0Sf; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSrcq2OI97eLPWj/vnnEH+zJ5AR6NMbqnG1tRpUO6Woaar9LQ3Pg+8cbvkHzTt5/yuUJyhWz4fw1B87z4snM7wOeYvjvOMncqvbnlSm39YlR0ik8sS6ivjlk9vuCpm1fPpgWRCSftsl2taJ2e89CiJgPAvojWe1esYe9cv9zjmCeMbtk8UtKqoyw7njdx1+v6oF/V4Xwqk8BFSEm5Nu0Cks5N395fW8Hsoobf8qScXN/GpoaXnrTN4E4M8mVb7zlSFCK2nhXNk/BWTGjtA+/hXtlbZfZP3C9Bf1tjtnlMbCd65MW/VP2JkGjEX9tIBjSx5OqrjG0bZbIaunL2lq7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwyEYObhx2Mu6J/+E3FJBJIhgacIDX6cnxNZiYjXrEo=;
 b=FYBaIg77qCVzW/ncT2X2vlvD3voaXELrbNv2hKtMy67sasMVdDFXNTmLQjN/7BH8WtGOcpD3S4GexW8Koq2lSxzA32quTfAfFHcthCzJGfVX5Rw1TYnFsgCmT5KnzrtMOAtnzBGYWyN6REIZ4o/IN54IQmUVSv4viz1neVzPiYAsoXfQODpjs1X1nAVT8FX7Nopm0afVgEHM34wQvqu0aT2klggsOauLO5o/i4TDNQSq3MNqsuV9k/VrLV55rKg801NseQ6/CoGV3Jp1YarChRAm1cqmsUrtPWhgUMaoef0MkTopxCmf9FuDypssaQ1go2B4nT+a8pan9tKRFsyw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwyEYObhx2Mu6J/+E3FJBJIhgacIDX6cnxNZiYjXrEo=;
 b=UVQva0SfEUj/mINgzuQXN/kZCrozrmkbTx11I10nwQj1k9XR9pg0dqOg7Hsmffmg/O9S8nORyQ0IH2Epbmcm4eBtLwrsniQ0v+fmUxigDoEt0s+63f4JW1AVFeq08gww7pxsoKjLVEyAYoKxkpyiMV3XFD3751pElp7xFxdg+5Sc6ViGhlz711aZQmuDlh45eR+PT7DJFa8vYqU5gzKRRk3/jK3JEjaBqgkHJuwZmIwGY5XCx7azZWD7p871t1EGRzeNxxu1IBXiZkDwgy/W1UrmgDg6vhQyJ3x24+VjypV2gPM6Wtk6XmwPDX49GUQMzq3SesbD1ysX5N4nXPh5jg==
Received: from BN0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:408:ea::8)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 28 May
 2024 14:29:30 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::27) by BN0PR04CA0063.outlook.office365.com
 (2603:10b6:408:ea::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 14:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:10 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 04/15] net/mlx5e: SHAMPO, Fix FCS config when HW GRO on
Date: Tue, 28 May 2024 17:27:56 +0300
Message-ID: <20240528142807.903965-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528142807.903965-1-tariqt@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a70c3d-4986-4f2f-1ec9-08dc7f2295f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?16TN+FOKunaaJ32/qalFY4Fk1rYSO+BxCMYxUAhkQA6RgCXTr1Sz0ou9Il+i?=
 =?us-ascii?Q?ofar5Nlo05yFCq14scftjEkNVwSKmJGfvO6uOAGOpgF837prBqy1y+qTUJVo?=
 =?us-ascii?Q?mKNFZ49z+cKRv3QkXQyTIzR58cq11z1gXV6w6iPrR/tbrFE6a6c8ddC1t9NL?=
 =?us-ascii?Q?35Pme1o+XZS/A6ftECCWkBSGtfdrR29Wf8kNMB90xz6u7fq7MxDIfv0ktGHS?=
 =?us-ascii?Q?/WcinODBvVs5qLRaYmkjgKls7geVadu1vTueJiQNzKIxOsBM02SlJXE+amqq?=
 =?us-ascii?Q?wy9voC4Pl+FXhJSPMC6u6LPfx1savbLhDvfBKdP0Up44+IjNM4YFGpheXI2v?=
 =?us-ascii?Q?axXNEnpWIDwVwetmcFV0LNzRb6/eoqVwtFJpl15lJ6eq1A6TQlIN4w4rM5Wg?=
 =?us-ascii?Q?d2UvsGCCDhQmNvj3egWqGJ1XDCaEtRfglUDHpnC9Rv4mSehJ+pol6T/7Rk6J?=
 =?us-ascii?Q?gTiDYBFiVza4JXlcH5Bu9lgJZio5/m6w0QCAy3FS3firQp33pOGHaBRC/In9?=
 =?us-ascii?Q?gf/dyYco8J2UilYnrGHBLfP8GnWHGb8lrX5mngfEcdzdQMnN3W1kzs1GpfPW?=
 =?us-ascii?Q?sKmTvb6YJaYqAxitYRg27ZrbbGTlkhCt4Jh44yOUMgJNBqLN6zZpOuGERVwF?=
 =?us-ascii?Q?lvdZmRtkw1eZI4rOQ7cNBO34DDbzOxIOGvPdRuyit3Lr+h/mNQr/K5FS9rDY?=
 =?us-ascii?Q?28lvoNapcNxfoq23U3ex5z5+PfaEHPRVfwjnZ34+2Q2XzfRHtm9P0nSIEfcg?=
 =?us-ascii?Q?KWXtRSMtiDaz4VNmTBboAo8TuhaFzOwkRXpc6v8079drvP6PDdoiJ517Nxh/?=
 =?us-ascii?Q?EjRNzn4VLr+WKp8Xt6Y/uCGxM56dGCBfevfkonY3BXhFc9QQ2JNVvz2W0DR4?=
 =?us-ascii?Q?6mvJ3aiChaXgwI/NTcNpcUIDI1erMypUeqa5PHkVZ7ShgtRvGxno3N0RlSZS?=
 =?us-ascii?Q?n0+oe8GtGzfqLQRoZLlHs1dORHdk/iVGnYavf1Tt2DxjJhyskRu5gdSdiWp+?=
 =?us-ascii?Q?165gF+fuiLplocwxAMWbINqnfQwQyqK0u3FzoHCV6ROaB+mmJ5uGbxKPoJB/?=
 =?us-ascii?Q?wI2CT3PiFCm/pY3Vngra0a10UQ943hSDlHOBl5A+1zFXgIbR5ZUkrExnqQQH?=
 =?us-ascii?Q?V7TiKTnvQvca1xeACAeKiCGBvr3wH08bQXToZ4Gm/S97Q5MKUsSkQTkOeEk6?=
 =?us-ascii?Q?wGD55qdGPhs7+k+IdyttgVW2Z8eQXaqWPXZ6IW/EW+ZeDORmyOBZbxWHvX4V?=
 =?us-ascii?Q?jeCtMleiJH2TAvcPNU1vdCkpIdmpuAIQvx3b9U0lc4Gkos4jUj1SeXNVap+v?=
 =?us-ascii?Q?sj5DXWfvRBkQffCwyCjnCYN4lTglr9sCZff9HNE2AwJXKuM/NXZPrz0Mifnx?=
 =?us-ascii?Q?p5LsQBRXXHl5E/1MiLu7qDi/Ia8y?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:29.8556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a70c3d-4986-4f2f-1ec9-08dc7f2295f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778

From: Dragos Tatulea <dtatulea@nvidia.com>

For the following scenario:

ethtool --features eth3 rx-gro-hw on
ethtool --features eth3 rx-fcs on
ethtool --features eth3 rx-fcs off

... there is a firmware error because the driver enables HW GRO first
while FCS is still enabled.

This patch fixes this by swapping the order of HW GRO and FCS for this
specific case. Take LRO into consideration as well for consistency.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b758bc72ac36..1b999bf8d3a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4259,13 +4259,19 @@ int mlx5e_set_features(struct net_device *netdev, netdev_features_t features)
 #define MLX5E_HANDLE_FEATURE(feature, handler) \
 	mlx5e_handle_feature(netdev, &oper_features, feature, handler)
 
-	err |= MLX5E_HANDLE_FEATURE(NETIF_F_LRO, set_feature_lro);
-	err |= MLX5E_HANDLE_FEATURE(NETIF_F_GRO_HW, set_feature_hw_gro);
+	if (features & (NETIF_F_GRO_HW | NETIF_F_LRO)) {
+		err |= MLX5E_HANDLE_FEATURE(NETIF_F_RXFCS, set_feature_rx_fcs);
+		err |= MLX5E_HANDLE_FEATURE(NETIF_F_LRO, set_feature_lro);
+		err |= MLX5E_HANDLE_FEATURE(NETIF_F_GRO_HW, set_feature_hw_gro);
+	} else {
+		err |= MLX5E_HANDLE_FEATURE(NETIF_F_LRO, set_feature_lro);
+		err |= MLX5E_HANDLE_FEATURE(NETIF_F_GRO_HW, set_feature_hw_gro);
+		err |= MLX5E_HANDLE_FEATURE(NETIF_F_RXFCS, set_feature_rx_fcs);
+	}
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_HW_VLAN_CTAG_FILTER,
 				    set_feature_cvlan_filter);
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_HW_TC, set_feature_hw_tc);
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_RXALL, set_feature_rx_all);
-	err |= MLX5E_HANDLE_FEATURE(NETIF_F_RXFCS, set_feature_rx_fcs);
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_HW_VLAN_CTAG_RX, set_feature_rx_vlan);
 #ifdef CONFIG_MLX5_EN_ARFS
 	err |= MLX5E_HANDLE_FEATURE(NETIF_F_NTUPLE, set_feature_arfs);
-- 
2.31.1


