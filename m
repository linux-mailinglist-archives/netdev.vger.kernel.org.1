Return-Path: <netdev+bounces-118735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA05952957
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ECBAB25336
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098B417838C;
	Thu, 15 Aug 2024 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ryQFGrMM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05F176FA2
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703112; cv=fail; b=qRgYZjyeYgkVFV+L+sIRx2m6xv3fywFo0VJKqnppObDb8ZIk2OxCojdvvU91p2ujiKx7vETrrH4hMEuuKXe6e0LI4ynnhyHwazsbX+XX7zLF5JpsD4eIjpObj4YXs7QRqZv+DqjqluezRv0o2YOLQo42KRrdvMoV0GbwYYUO0Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703112; c=relaxed/simple;
	bh=uskiWukM+M3TVU+rZ6kxlMLLssI+Wfm1Q5GeRyFkpp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6ZeFR4R3EuTKySQ/EY9jHv8ZeJlD325ilfkNUxGZ+LRshpkDNLradfJDes1DVKg9Gg9T1dc0LKJCmeucaGln0NEY2euu3cieKnPM+fzkDH6xnuQa9mBnQ4PFgWPvyLUnipBAzUEUqrf1wVFAxseC5ClmERraApUXAGxHtNfMn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ryQFGrMM; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qI5WVRH3c0oJIzvhwpcif7pwhP+VLhsR+uLgSrZ4a7h7dgp5b6Ft3OLrJV+2uGMuhFXZaabTMWsbaqwXiAjzhTBW1gUksboxpN2fbpfBMHVt60aqUAb2n9UraOR5Jy6BTqfK/dRkX9vTX5vgI1rnujzRXz1ux+rgVr7auhO7goV1+zLLv8IXRfP7vdiZnjuU05L5yglah1TAmmAkqPabG49GzNyAJxPDrPLmw7EZnO/ADbHj7+jlK1JGBArxkQm/r3KrGmu1ubr3mX2PWEkZq1x4RWLCLEFm0vyYpXje98rg8AnMVDBWTmSdX3dWDUUfpToWsggbiYQQW3vpN9bo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yRNU2yc1MeixEpUrqMoY0hLv9tT1Q0wGITbp62jifs=;
 b=IH1qt20bdiLzBikx4KeKFAD3b6qi1ScqQcEVVZq5VmPJNy3x2jUnKcS1N1M8GF2xMP19j+Vp4jCHa0ZlYJjsceHiMj8RNQQT4Iml5CZhUI30+Bfz2LsS+Ty0yXwiElM7NnZrTtr6LUpISbbnHFy+QLC90aAJq9WCMLK4lgjFRxUhILoAHoM0Q6F3riySJ2Sd54vSA35JI5UBfbptiGuJOzPC0oiViCfUv1qwpdjWafatUJBtqiKx1oC4aifPJHFwv45QDsJ09nNpXB8+8zb3SwNBwq0UqafZF6IFw0OTmchGMdXSWG2p70/oP0cTBptyJPGqMU3O/QqO4RYj+/A9gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yRNU2yc1MeixEpUrqMoY0hLv9tT1Q0wGITbp62jifs=;
 b=ryQFGrMMjkuviJxG99f07S7zVqwJX2s8SgJkdlsdQ+wx47SakibdOu9jgDBFXqmjujRySyNDbT2IGM7AApxisUwQSpFptemJbplJF/tUv7a/teWrKH/mLYpsS/1vOAXlrXtH7XFYn0ykZttX+ICGxtWKuMgMMkQ51GLHpoYRVxf+HhTCmPq9g34pY63sRSjzgpe33FOFhlyR0N2bhlpx18JXi3OnLz3z0Ar/Cxv2W1lxEJ1KuOHSloM1pdq5Ag1W8Gp7EzTH3XNzVuao96QPN1sAGt2BrByFXBFqJBz+E+QuuhG2vtpDZ5GMyWCFwDfqz18srUgNlB9uy8vXxdJTCA==
Received: from BN0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:408:e5::32)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.23; Thu, 15 Aug 2024 06:25:03 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::b1) by BN0PR02CA0057.outlook.office365.com
 (2603:10b6:408:e5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 06:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.4 via Frontend Transport; Thu, 15 Aug 2024 06:25:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:44 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 14 Aug
 2024 23:24:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 09/10] net/mlx5e: SHAMPO, Add no-split ethtool counters for header/data split
Date: Thu, 15 Aug 2024 08:46:55 +0300
Message-ID: <20240815054656.2210494-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815054656.2210494-1-tariqt@nvidia.com>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 4435c1bd-0ca2-47d4-fd4e-08dcbcf2fed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pTiidSJiHj5KTM1D1aravYpxXmSt8a2/t1RdDRoXplNc46JRyP4HZVTSi9r6?=
 =?us-ascii?Q?Od/iaJwhgKsnsEGvf2TfwwekCM+UmB0DQA0bMeKzB/rZTCYztjGvOUDy/n1p?=
 =?us-ascii?Q?aHlAQ2zIehL89DNs1koeoTz5SLh7mI0vAgVF2jy6DTrBzM3IciPTY30fDNgA?=
 =?us-ascii?Q?b6d2/zUNZQUabD/IkIaMFKJN5/4aizD4IhJvshm1XfWqWtWJG4MZGdapJkxG?=
 =?us-ascii?Q?4u4uchqyCc3kVO9beeJcX0v5iflV1/A/A7fdlTArVj0bNzH+Iw8Suenypnz4?=
 =?us-ascii?Q?SRvHjV04+GQUrgx5zPaTC+I5YcUV4YRfNPzh+XZD5xWUxhbM8Uh4VL4OMOB2?=
 =?us-ascii?Q?kS+fdwvCwK9dVaRHi/2ajUOugKV+i3SDF9T2I0Op8rGwkW/+CQR/0sxHkdr2?=
 =?us-ascii?Q?sOwsyGdRXmruNYDXig1oKAIoi8DN17b67usdx9r1VLmNvJ56GMHtW+XgcOs4?=
 =?us-ascii?Q?MZf85iPAUPNY/lMoOcjHlmZQOm6oO6cOQIgnI/F4FUGFyB+zKLamDE7ksRfG?=
 =?us-ascii?Q?3por5OtpweUwUUnDHGLXYFeSvPMP2bdgoERVLOypDvqdRDQBC+nfsu9GjU5g?=
 =?us-ascii?Q?CUAO+XjPwRYFNxTJY7jW8tOOqKJPbmzmJCuf59+G6m4rBKkroO456vmn2IG8?=
 =?us-ascii?Q?sPFJ4NsKvj8yqNkmbDjkVwkHTwLiHBfehCmn1HEnRx+QXENCz3RuRoMeUM9/?=
 =?us-ascii?Q?5Ee+Lgb/g9dqEyLFRvvW0AB9ADqH3hp8Q50tLoR3soFE4yyEA644EgM6tiS6?=
 =?us-ascii?Q?4GHwI+PCTn/vPxGne8P1vv8fA33pwD9Fwh3qrnSClg6XEPoCZxgTvVSaxCVH?=
 =?us-ascii?Q?PiqO/MIds+x+T08wm3Bhm5aHkSrVktc+QGdWA+feD3OoWXb+lM2swf9/nm88?=
 =?us-ascii?Q?5lu2LXJLtwBXTgMVVcqN7AWmMzIk6cQ2UQ8XsHEuNZPs0tG/HfJH+TjjEZar?=
 =?us-ascii?Q?s86nukmPl3jgSuiOt/GkWLG3SJvDYy/uIe8Us6k5cyDWSqxukC6ZivB6duoG?=
 =?us-ascii?Q?urNQ3SLiiIvilR+VYvbiaHLKq3uxdzJIOXHbc12eM6uSlTHUZpJa8YVYFvga?=
 =?us-ascii?Q?U9Msv7qYqsfB+2V8yGHyvgrReCBTzg/1kmOzx0ODirsrCPTPsu5nFtoezdpR?=
 =?us-ascii?Q?/7MrR9U2PB81TjkDdaD4jAf+D3/NmoUQUTzM/lTQl8Zqjay4Q/HId/pi8Rm3?=
 =?us-ascii?Q?6TpK8xzIuG81BhivXqYbxRsgS/0TYg4LERTWtrAwdkkRhrquh52R7H65CmK2?=
 =?us-ascii?Q?p8V+rGJ9REbeseH22kztkjH+Cnbz3zSjkPHYbfmSG88nEzt5/XYI6i/RJDpN?=
 =?us-ascii?Q?LeqNTz0HniMBj9tkYfD7QJktRetmJLLc+FPl+1Rs7vTMsFGIKgLxSQF4Vbmy?=
 =?us-ascii?Q?bRO8nCYrR1ct+DzFG8KSQxT4v6bDD+/C7P/cetha//m1yW3knocvbgkjb4ev?=
 =?us-ascii?Q?QA4f/OIXQNbABnXRt9D3MTXEg78uHwDW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:25:02.0640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4435c1bd-0ca2-47d4-fd4e-08dcbcf2fed0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469

From: Dragos Tatulea <dtatulea@nvidia.com>

When SHAMPO can't identify the protocol/header of a packet, it will
yield a packet that is not split - all the packet is in the data part.
Count this value in packets and bytes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/counters.rst          | 16 ++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c  |  3 +++
 .../net/ethernet/mellanox/mlx5/core/en_stats.c   |  6 ++++++
 .../net/ethernet/mellanox/mlx5/core/en_stats.h   |  4 ++++
 4 files changed, 29 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index 3bd72577af9a..99d95be4d159 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -218,6 +218,22 @@ the software port.
        [#accel]_.
      - Informative
 
+   * - `rx[i]_hds_nosplit_packets`
+     - Number of packets that were not split in header/data split mode. A
+       packet will not get split when the hardware does not support its
+       protocol splitting. An example such a protocol is ICMPv4/v6. Currently
+       TCP and UDP with IPv4/IPv6 are supported for header/data split
+       [#accel]_.
+     - Informative
+
+   * - `rx[i]_hds_nosplit_bytes`
+     - Number of bytes for packets that were not split in header/data split
+       mode. A packet will not get split when the hardware does not support its
+       protocol splitting. An example such a protocol is ICMPv4/v6. Currently
+       TCP and UDP with IPv4/IPv6 are supported for header/data split
+       [#accel]_.
+     - Informative
+
    * - `rx[i]_lro_packets`
      - The number of LRO packets received on ring i [#accel]_.
      - Acceleration
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 225da8d691fc..1db26a2f237b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2340,6 +2340,9 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 			stats->hds_nodata_packets++;
 			stats->hds_nodata_bytes += head_size;
 		}
+	} else {
+		stats->hds_nosplit_packets++;
+		stats->hds_nosplit_bytes += data_bcnt;
 	}
 
 	mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index e7a3290a708a..611ec4b6f370 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -144,6 +144,8 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_large_hds) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_hds_nodata_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_hds_nodata_bytes) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_hds_nosplit_packets) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_hds_nosplit_bytes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_ecn_mark) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_removed_vlan_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_csum_unnecessary) },
@@ -347,6 +349,8 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_gro_large_hds           += rq_stats->gro_large_hds;
 	s->rx_hds_nodata_packets      += rq_stats->hds_nodata_packets;
 	s->rx_hds_nodata_bytes        += rq_stats->hds_nodata_bytes;
+	s->rx_hds_nosplit_packets     += rq_stats->hds_nosplit_packets;
+	s->rx_hds_nosplit_bytes       += rq_stats->hds_nosplit_bytes;
 	s->rx_ecn_mark                += rq_stats->ecn_mark;
 	s->rx_removed_vlan_packets    += rq_stats->removed_vlan_packets;
 	s->rx_csum_none               += rq_stats->csum_none;
@@ -2062,6 +2066,8 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_large_hds) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nodata_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nodata_bytes) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nosplit_packets) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nosplit_bytes) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, ecn_mark) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, removed_vlan_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, wqe_err) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 4c5858c1dd82..5961c569cfe0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -156,6 +156,8 @@ struct mlx5e_sw_stats {
 	u64 rx_gro_large_hds;
 	u64 rx_hds_nodata_packets;
 	u64 rx_hds_nodata_bytes;
+	u64 rx_hds_nosplit_packets;
+	u64 rx_hds_nosplit_bytes;
 	u64 rx_mcast_packets;
 	u64 rx_ecn_mark;
 	u64 rx_removed_vlan_packets;
@@ -356,6 +358,8 @@ struct mlx5e_rq_stats {
 	u64 gro_large_hds;
 	u64 hds_nodata_packets;
 	u64 hds_nodata_bytes;
+	u64 hds_nosplit_packets;
+	u64 hds_nosplit_bytes;
 	u64 mcast_packets;
 	u64 ecn_mark;
 	u64 removed_vlan_packets;
-- 
2.44.0


