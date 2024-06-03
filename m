Return-Path: <netdev+bounces-100363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C698DAF52
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C521C23FCD
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129FC13C681;
	Mon,  3 Jun 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4qQvZku"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88013B58D
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449845; cv=fail; b=o0tA0a6BR5GyN3C2HNobBCDQcCCJilSi3GtulHb0qMwmEfJSxCjY3ZuhvG74ObVdrljPrQFK7Q40ZqY9psTS8H7MFvId1CSOzqSUUfjniJ+1vUVu2k7tjMlAl/MnOPulNqJ6ssU7NElVdFk/6whnMBFE1V5mHLcj+6GpX7SPGYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449845; c=relaxed/simple;
	bh=ZwrMtd77uF+j0OeCO8kfP5YsRqlW0uXUeP2EHKvf+N8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1eeD+CSyY0SgZXPiaM2Jt71t0YQHwgCCLoJiVwhUKFKP7VHJFwRBn5tfmp4icT5l+dEzHkMu7vHQ/pqaqkt/zuK3Us6OD5pH8eLh0+SuVU64DjVX2iq0QELnWugy4R8C87dFbV07onwKclZfglIuUv6YEn/XHESIaq4kQ179/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O4qQvZku; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abMQswvguZfC/LvomIGgmskgJW+ZW1rZwjmHyKkJeTQLfrDRqMWZiNRUt09QyEl/izxnC6GaotQOvMk/STFP42a1ZqiqOjg17Vo4k7u6btO1bl7sf/95QQhI9XflQoHkWpeSgqDjEn/Q1JA5tCrotVRqStm3J3HCYrwLMVvPeEwThiWqrhgANM4gWxLeQ7E1X6xfgansthBnJQbFJbnkQBs25lbmD6/+v68LBfuaJsFJwiUhp65hDn3HATIfl1cNGBMuGL6UP/tmxuR+xOiKnj041MZrSG9jeVou4aYovF4i7kKt2XQg+M025B/AIxW/UY18Pr77uUWDxd55ZqLX+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a35fdEY9KDg7HcNtzme6BqdJfb88AgLqHwQBhwRr/BI=;
 b=Do1bIBETajLkX2GvP2r3w4MIAY3f9B0Vo9km/dhpbIbHf2P9W1Kgy7IFizBokgsYTyc0Nts7fLQgt3Q0lmjphgcRwdq712AbQmbwjXI5CskKa0BiLk+fIPhTFjBbxHrfJYDBPpcTa81sCH+lnzgo2gkD36YZoDG3kyadAeoIMlJDUiIjkQ2MHv5PAsVwO3QR9fwiUk5haXuX+/w5pd5qS2quQzBH9EFkNTBSrEO+ZJ2gx+if+CpyEERbGL8+BUQT8WliJcwq9pdvzv0oh8UBhgmX5U4weD48wJjMkaH0LIVsdz63uT4Q3WppDKMPwp5pllasy/Thx6QtM6Gax9C9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a35fdEY9KDg7HcNtzme6BqdJfb88AgLqHwQBhwRr/BI=;
 b=O4qQvZkuvH6GoM5AtV7HEtd5E4UhYk7j2im/+Ilwmw5+fJ06+dO5gN380XNsPq6RMJzWlsyK7lkp3JAwuv6R2yWocsHjKxP12rwI5IC2he//f8GY73Vgd7uorjltXWKDebLn4zSPqEiSYndATprW3AN4AWPQw0wTdKeFtyv2/YbmqjBy9MSJxweo33veGiz5+RRTEk63AX23q/pP9pi1MIrKjq8eGCYxXz091JlE1hsoTiELfEjoD97wqgj6DUfuGp3oytBmb8D9yZQ55rtedXklsxOlPjA4H1b6Vh+0Zqu/qat1S8HS13+uOyToVTifecLtE/hH7lBY0OVMl5LT6Q==
Received: from MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17) by
 PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 21:23:56 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::74) by MW2PR16CA0004.outlook.office365.com
 (2603:10b6:907::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:23:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 10/14] net/mlx5e: SHAMPO, Drop rx_gro_match_packets counter
Date: Tue, 4 Jun 2024 00:22:15 +0300
Message-ID: <20240603212219.1037656-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240603212219.1037656-1-tariqt@nvidia.com>
References: <20240603212219.1037656-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b08d92e-503f-40b5-1274-08dc84137916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ryPKMJagReyMbZQYJ3uqyFX0pBj14d+5zsvWg0yT50MH9bitPK18whfutagY?=
 =?us-ascii?Q?PfkXs0adI/DDSmkS3v0Cf09DWUZkzehl8wW6bKKNLsaDJZhcfhfBpX5itgtx?=
 =?us-ascii?Q?7YTKAhfyRV+YHqW5JyXUHfw043X14n9FFQ5chfheS9jIXgsAdO3Ajfg3xAxP?=
 =?us-ascii?Q?RhBdb67mdPCI1xIGUoSo0UKpkWPUcQCiAIbGSzLBfpJ8m7zJL6g2s6r2Eoqn?=
 =?us-ascii?Q?xcIekFubOzmYOwkEP+GUITn3XP5DSnMDW0fZp4QDQ0dCbCyaU6f+7dEz512V?=
 =?us-ascii?Q?7NBUIyfWRl1BmazBWXa00zO3opdVRGnBla576GxH5vjbJ5+OIDbTNQ9FiZW1?=
 =?us-ascii?Q?UEoNKh3ktfMvBGt/ZkfYBCCHJCIPBBvOhKpzUkLgWshMSfshjkVZCtHDPK9v?=
 =?us-ascii?Q?vu2n+PgASFAPbgqNd+WYtL0xUTPJvMA4kt0gyzxQ+Rr/J6NGiPLCTxG61LXy?=
 =?us-ascii?Q?OvhCWd7gB0OtUp3lL80568MWRzT10NjvtXfuw69wWoTBXq27q4nB3/NcHGae?=
 =?us-ascii?Q?AMavS2wtxe+oxXqg2DtHFV2O3SRQxACZ3iLrjTOVyR3drpw+kPzTHtkn5t//?=
 =?us-ascii?Q?HuBAfqjLqLFLCcmxduVH5KvdWeOmLyHxFfiP3M89lTvTaHLCdiuyjUA6Y+9x?=
 =?us-ascii?Q?px7x8jpt5fjKMBICHiS9jrrvuAP2DtZIMAR7nDOn6qi22I5XmwbAH5by6tjA?=
 =?us-ascii?Q?nSEA1WyED4DBJHh0pDaWiiy90+a8FiZRS/8H5yVMNva7S/arA4hc0GTtu9eh?=
 =?us-ascii?Q?mpeeLkJz+nbFmaxIituOyOXogEWaVvnmSmjUlPhQqdqBEh8FcCHYdysNDUtr?=
 =?us-ascii?Q?Pm6Rk5Yci8REUU8tFLnATdAsjXdgQwoVbKfo3eUe0F6BvGFV6BtM9lTrbVB6?=
 =?us-ascii?Q?eEBxYprFgI1ew2mHRJ8dWPMOhtwEHlHAdbFWQVsYOyX9NoITfY9z6PzQg4az?=
 =?us-ascii?Q?eXBCaZykibxBpMY3mHuedWCUs+oPeKwj6r/iQYalOkhXY2T8E5uxIh1Hoy0X?=
 =?us-ascii?Q?gfR3icu+p8mMVBNn0HD3cBfkbpSKFTGZMFRw5ae5R8uf3BkLjm7FNcyEonge?=
 =?us-ascii?Q?Jigs2+r1RsrcDteYvcSXEI1azKyVqKXgv05cE2yKXKFLW9nV+Iy5mc8BsJ8P?=
 =?us-ascii?Q?VmPC6ZpTtLtaT0nQup/llvhFwCf3+Ca2oQOoZeTSLu95ZrbEQMUTLR0Sg59H?=
 =?us-ascii?Q?YdRtyUw2tFJvOaiLvX3f0wZuaS/52I/SPX7bqQUyMcfeOYWygRXRScUF5yoI?=
 =?us-ascii?Q?v1g0ugOeGx3oZtDJAbu4GcLID/+6HkYzurFIheIO2YgcMn6YZEF15tDcYwb2?=
 =?us-ascii?Q?bMO21rnDyWzfZJJYOS+B68ciZG4Exnb0mWJH7zsP+L6el3/eFrF2yeNvuj5O?=
 =?us-ascii?Q?mfB+JuWgenSMfRENHY35Jj0K40Or?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:23:55.0346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b08d92e-503f-40b5-1274-08dc84137916
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448

From: Dragos Tatulea <dtatulea@nvidia.com>

After modifying rx_gro_packets to be more accurate, the
rx_gro_match_packets counter is redundant.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/counters.rst       | 5 -----
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c              | 2 --
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c           | 3 ---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h           | 2 --
 4 files changed, 12 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index 7ed010dbe469..18638a8e7c73 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -204,11 +204,6 @@ the software port.
        with a GRO count > 1 are counted.
      - Informative
 
-   * - `rx[i]_gro_match_packets`
-     - Number of received packets processed using hardware-accelerated GRO that
-       met the flow table match criteria.
-     - Informative
-
    * - `rx[i]_gro_large_hds`
      - Number of receive packets using hardware-accelerated GRO that have large
        headers that require additional memory to be allocated.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 79b486d5475d..7ab7215843b6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2296,8 +2296,6 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 		goto mpwrq_cqe_out;
 	}
 
-	stats->gro_match_packets += match;
-
 	if (*skb && (!match || !(mlx5e_hw_gro_skb_has_enough_space(*skb, data_bcnt)))) {
 		match = false;
 		mlx5e_shampo_flush_skb(rq, cqe, match);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index e1ed214e8651..a3c79da1525b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -141,7 +141,6 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_bytes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_skbs) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_match_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_large_hds) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_ecn_mark) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_removed_vlan_packets) },
@@ -343,7 +342,6 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_gro_packets             += rq_stats->gro_packets;
 	s->rx_gro_bytes               += rq_stats->gro_bytes;
 	s->rx_gro_skbs                += rq_stats->gro_skbs;
-	s->rx_gro_match_packets       += rq_stats->gro_match_packets;
 	s->rx_gro_large_hds           += rq_stats->gro_large_hds;
 	s->rx_ecn_mark                += rq_stats->ecn_mark;
 	s->rx_removed_vlan_packets    += rq_stats->removed_vlan_packets;
@@ -2057,7 +2055,6 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_bytes) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_skbs) },
-	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_match_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_large_hds) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, ecn_mark) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, removed_vlan_packets) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 650732288616..25daae526caa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -153,7 +153,6 @@ struct mlx5e_sw_stats {
 	u64 rx_gro_packets;
 	u64 rx_gro_bytes;
 	u64 rx_gro_skbs;
-	u64 rx_gro_match_packets;
 	u64 rx_gro_large_hds;
 	u64 rx_mcast_packets;
 	u64 rx_ecn_mark;
@@ -352,7 +351,6 @@ struct mlx5e_rq_stats {
 	u64 gro_packets;
 	u64 gro_bytes;
 	u64 gro_skbs;
-	u64 gro_match_packets;
 	u64 gro_large_hds;
 	u64 mcast_packets;
 	u64 ecn_mark;
-- 
2.44.0


