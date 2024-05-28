Return-Path: <netdev+bounces-98634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554708D1ED7
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF61283BCF
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB83171080;
	Tue, 28 May 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CahjG2Ol"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF9171062
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906598; cv=fail; b=JaEjtEs4/OOm1upInxGKx/XgbPR0LJND8SaCEU7QZ3mPsNQuZr5kwx3mbm2aTIznjFxOd7GLQCrzx+RzwBwLF2rD9+QVKZpngfsPbQCEY9pIM1Re/CcNm7nTp93ihXjIvvEedu0CTw8f9FXZsEY/xr62Cduh2+aknHg5d1z6aW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906598; c=relaxed/simple;
	bh=fmhjvCyhDNLJa/q5RGE2vaUk+UhKz4odZLC0ZVJa24o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kta4zZNzpllO7iW0GICOVNT0d/Gm087zrnsp2B0v1JKPEZVb4N3kRbB1iMXMO5+RLw+iTSzAxnEWcX5go1pdDRRomY5hvGXiB76habXdr3E5BF5uUIpN1RcbpYEyng5Z9HGjPPkdKr/kQ8aaJv54XM3oGTR9kmpQu2alcbQFQy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CahjG2Ol; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwfbviD+Gg/ItTXsuQNwYQ9TCkghr3lk6ns2CtP4JMPrroLrq3qG8Tjp0CpK/qF+6knZ0H6uaZ64NgUoU4bmTilbSlZLWW//3E3gjBZkFYbOUmUFALk9P5ztoYcBp8/u7yd5viFJTXXAV8c+zfBbUkj8i6EZEzJ4cMXgKeVL4eUYS7R9w+HZU79n8RI4FIXlCD78rOwY8s0QbHgIezlsxmDakNSZMhnBzdTVCT57UxZpqdqLbzOQXPj7Bk4PGQhlr1PnE8/PGJllkUVhGbzvTcIPsc0evsHKzjOS4tqch67vNLS5Ow0T2+RRRUI1rnxJtU3w7OnFevA5wDgn3JdZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKOF4BLvLbodgCApJSrMtHPnJdNs81EBFkTKGdv9w3w=;
 b=DkaqXfvsP0ydxHpmwCLmuTuAse6l73cQJxesR/2z0RRpM58dZ7RuhdNtnm8tI5g2U1w4ig/PidQzvDN+RyDUNsJ9/4r0jM4fURb2yrapdyVuE5Q8MEncrVIDOtd+c8CpzFXiorYNt1sKguChC/2tI5nxV8K5cng5bOWXg7H5USfH8t4RZGdkd3hyRi8l2Ea8tlCvIv7+RczA049xT3BemZEiaZ+qulsydqgo/CfPb/e3F+CXzgv/7w2yVA0qhOi/FuzsTJGGDs6i6RG/1xp4FuqREUV7FQ+Lof2lY9iMs4u5jWr7Ld+XBXcli9khok1v7wpugVXe+SjSwwj8GtulsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKOF4BLvLbodgCApJSrMtHPnJdNs81EBFkTKGdv9w3w=;
 b=CahjG2Ol05zU8oigL1mG2VMnWueIWWHWZLJachSWAyv01P8enC9WvcI/77ZM3OYKFm8qjnJG/V5qKcuMdqgj1PqbP9lVnjxFXcDZnIWZ7MQnB699bWwRVZ8VjzD8+EdpNQOP49dRqlQnEw0xavz/TjQr7ahXJyvo4CCnlZQoESiE6EvyEabofcSEr2sY9PGhiGG/Y2Mmc/z8CDHzrrMlUVIvndJLLt/G7fsQsns9Q1Zkp9w2D5LfXUqSmpnpCfNXR7aVOS2tYKMvkVfWgmR5XsDZ1XFZK3VmFtBRRV+hT7oRJPtxYg8298SBJJWH8NogIUdNfGRyGYvkyAkHq5pJNw==
Received: from BN9PR03CA0171.namprd03.prod.outlook.com (2603:10b6:408:f4::26)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 14:29:50 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::eb) by BN9PR03CA0171.outlook.office365.com
 (2603:10b6:408:f4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31 via Frontend
 Transport; Tue, 28 May 2024 14:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 10/15] net/mlx5e: SHAMPO, Drop rx_gro_match_packets counter
Date: Tue, 28 May 2024 17:28:02 +0300
Message-ID: <20240528142807.903965-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e75b65e-7f01-46f4-1a58-08dc7f22a1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1FEHImQUQRIQCvkqDktoPUBdBcabqrUWojur1DMNEyA3QhfVFDQmuAZt/okE?=
 =?us-ascii?Q?ADu00r9MFluYRiTxHK7JwqVZeoFhi3HAW337Bcf/qyU/2UZRYHRCRs9z0DR3?=
 =?us-ascii?Q?IetSU99Whhc62tF5GcRSlVARGuCB3Sh6SUVdCzmggMdttkUWVzZYjGIYOTU6?=
 =?us-ascii?Q?uOMdqJU6aJZ/D12Cse+lrGxbVxwwAyWaWppQBDG9V72UvrBPDbaYMQnhJ8sB?=
 =?us-ascii?Q?G/B54PVYvx6mNXEEhbCcg4sCtoUb3AIQlwTPeAsu8qxJP8V/r/ooONtdWGtd?=
 =?us-ascii?Q?SpU3ThuJRZnIqPp1hOjrrW6HBzLrlmFFf23Au0e1d7q/X42Ux9B+fTxI42p7?=
 =?us-ascii?Q?RPlejds4RVcH2oRCQw8+glcqU00nNFZqBr+M/z9YM+6fwGQVN3QvUxcDKP05?=
 =?us-ascii?Q?yvHGjH3VslAh++OqTpPvAB5f+78lMG1pOR1vYJ58F85Zz7a8jOBg4Qiu6xIy?=
 =?us-ascii?Q?Cp0o8SpTyRuv2rKaHIvvk6vbOjOGkqIxXKlCv6IhvhjVch1GNDyb4uuO038d?=
 =?us-ascii?Q?+NgZmdP5RCeYvtwONcPi8AJKk+4+2OyUcRJC0GmNfrIltP5PmiMEoZyq8uH2?=
 =?us-ascii?Q?+SazLvt4Pq6iY1APccCAgQ2bdR6ud20kGoZss9RQWBz6+KrF38eh670mB7Pq?=
 =?us-ascii?Q?vMwfh1oTa+hq/00izdPFB9qGrylg7WP7AbVUKQKugem1Q9VW+dq99L3gbgLJ?=
 =?us-ascii?Q?lOwFQD3+tbllMcKzPppfRoaS/nOV5uh6ECa/NLQ7P6knIlv8ZRc03ElP7vPA?=
 =?us-ascii?Q?iBQ2XRn2dmbogn3sPxX+eb6w10fddzYRSE/N/qJkgIXP7aIra4YayY+AmI07?=
 =?us-ascii?Q?Xnd1StaFqSQWjGbVm/pSWqqCZ3muldGxDd8MQxKznVBl41Pz4ad0bNqrLd8k?=
 =?us-ascii?Q?ZmHQauJ4kNg5rFqicnP+WuVPgqSAm6WhSvML2whqx1lclew42qoHiiCBtCA5?=
 =?us-ascii?Q?7VsI79UYbftQTqdsNjKqDbR5EHIgOWrCjTaQl9KMRkmGps5OAzYfX1ZiMhHP?=
 =?us-ascii?Q?/g6iDTDX+LXLdHE46aqo5XyVmTRDYVW/SZ9NWf4vM3snuphTv8ce4e0taqPe?=
 =?us-ascii?Q?1i3HkiwF8EnFH4JrrT8gUP5+wYjlCl5dK6rFyCn61HirPA3B29i5ahEwWOST?=
 =?us-ascii?Q?GhJZXlsPZgG4fZg2JWXGn3uyeN3LZkvf9dj7Ph0HeMWCUOiXluezxhNrQi2r?=
 =?us-ascii?Q?MudpeTfEqnc7dkIgXN/EmlCLiT2j+VfJR1Cn8LS+tRmlGzOUpmPA9y9ppas+?=
 =?us-ascii?Q?7CwWTF/sUHqaqzO5nvzPw3GVLoSv6iJum+6fPwc9pGnM+PG15zZDCvWJrGcO?=
 =?us-ascii?Q?enISDHgLeDZcKLVbQvQyTcyfiL0D0LAUyG8qXXRO1ADmQywtgUIoYWT/73wD?=
 =?us-ascii?Q?Kwg6vJ8/CfzQEK2WDGMpvTmyTAkx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:50.0718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e75b65e-7f01-46f4-1a58-08dc7f22a1fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807

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
index e211c41cec06..a1657fad9a0d 100644
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
@@ -2053,7 +2051,6 @@ static const struct counter_desc rq_stats_desc[] = {
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
2.31.1


