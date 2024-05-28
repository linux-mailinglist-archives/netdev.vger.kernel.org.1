Return-Path: <netdev+bounces-98636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 498E68D1ED9
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D92B22DB8
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26630171093;
	Tue, 28 May 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Crx1sW0J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66511171648
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906606; cv=fail; b=cDlPvjuAaPNMEpDlMWf1SV8+BPwcSU/f6cZXU3a9oObg47lp49ZGjUCIWe3339AUjI29l95F8R/A1G83n59as/bNrjmd5lVhr/OfaDGrQEWuLIAaFFiDO/bDo7rXfg+fKRiI8p7JuKHqhB/vmCi2OykfosPJAaTvfKlR6RiRaPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906606; c=relaxed/simple;
	bh=jTrB6wR26s/wm3DSw4yZ+slRQQCz4msLtpHVKU59Cd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoeAxWkNFJWH37K2GBomCQv5pm+FPMvciRN57HB4YDjTipphaoNpPcavW4sHUXBeY9Zyy+Q8ZXTQunlPrV3qgdYWGzn1aKlOjIxHB/JhBThW5DZ0RoYvSmNFCwJRL+s4USXdgy627hxEz1rx4Aqz2PtwyoxUmKhf5Fr4Vx9w1RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Crx1sW0J; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILX8E7oyjPIqoBEVV1Xf6ldyimdnATm3jldMgUauA4qovqsMdJmDJubJPhRWjV3J5vGZ6cKAj5sbYDZMG/yQ5SaG5RKDBvx2WKYbpkAD54+GinQA7SQraXaMsZmesR2mgcEFdA5Eu/z8CyAoFHvg6NAnSxzJunna+j1yuO0suy59IvRifT6GFtBJBknBF+ofU/qOfk+65pXkpp7dVD14Ou6CMWiximKhhUSvpLDkPcluHyIqTzkAFxIoQy+ZQwmhADyyfZZLJKEm1jsWCzOzva4j8wFiqEEvVFKAs5Tz2CPk9ADN6OMTtr0N/kwgvYRpagynsSFXknyvsmWxvGT/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3vusMPLkT5kV0VjiP4G/jXC/TbXDwV7AZXfoM7/tc8=;
 b=a0dI9C7y35sJf3O0fwcgRaMTpuqYb1M9wcIJ/FvnsaF/WO9/XGg/KkBLjd+775wyX8g620RXGgqsRlsJTxogG9DkqAaYjkBt2GIILZU3D2CwwEnsW8/GdIa7791L1wyKT+RrJunosp8bXriY+2oetmYr1f5ASXV8fsM4lpXf188NiNhlPYkFGRBBLy1GqYAy5FJBq+rMz7EZe+rsmthOvQ6HZVN6GZqDP0Q2M3pPnDwLt2FXQ8bJj+PFxIfwUU+ul9QyRtFzjNto68N7vsiHhgbZqg4naz+kikXy8j7VcDUnbJOcpVOwzW6xj6JdRnktEpgcwcHKv9eUP2ZBDqFUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3vusMPLkT5kV0VjiP4G/jXC/TbXDwV7AZXfoM7/tc8=;
 b=Crx1sW0JRGm50Felg5NunsZLryK4tWSqAt162nzeH4Q+s+QLsUF3m3NaglJZ3l14eHr2b20iOMVFDSw8UlV9VRLv1S0ocpjRCkEZe78NV/dkt9aVn99riAQKukBpAUjxL2xcdb1aOYjdbaYUx2vXn22cLzPYT9xTjCV78n6CVQI43Yrx95smidTwBRY06sgH/+UlesDXmofim4eBeOqlt4+kysLe4gChF+M05IsKLlOdUywKEam4ZNTcN53Bo4jmej9kw9/VlgCpY+/Qn8HUDZLXLEdMYJpA3jta1QQVsiVb83D9gJ9Z2Hq/158x3vdmR+bi2p50f4nQ0PRWcPhEjg==
Received: from BY3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:254::18)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:30:00 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::87) by BY3PR05CA0013.outlook.office365.com
 (2603:10b6:a03:254::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Tue, 28 May 2024 14:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:32 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 11/15] net/mlx5e: SHAMPO, Add no-split ethtool counters for header/data split
Date: Tue, 28 May 2024 17:28:03 +0300
Message-ID: <20240528142807.903965-12-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5c0e3d-63a1-42bd-6e60-08dc7f22a750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VN7oSAV1dnOPAVA/Sj7s0IDmbcR98qHieueXHgIRCjiYFHTB5aopKEwUcLI1?=
 =?us-ascii?Q?61MkS0rdnqWWzY+d7E4JngC1fophMutoTcvC0CJcr3Z6hSuYpF4gGL06uDld?=
 =?us-ascii?Q?Y3HHkq63QV7GQ4UHSLC/lIczVx9VfsVYOHLqPckimB5L5TS0vHcMRKZX91M2?=
 =?us-ascii?Q?H+mdHkWtHZ4swEr23ve6lddNKzOGIQOLsmKPqfmFFtEZxbKdrWbiNliZmFDu?=
 =?us-ascii?Q?tCD9joVDllFKEOqcFj8J6qDfhCBUgG4NjyNXYkXB0ZMYDG95DgYIbNBmVARN?=
 =?us-ascii?Q?7EhVQ/XKt68XGyaJsAj/quCMXOfbmBpDi+rjJQdAQLkIYo5VUpDdQkQxhshB?=
 =?us-ascii?Q?z1MXRYvglPEHfgV+uXxl9XEeYKoxNlHVLDDkUzash246lso1PFCdzBMCAFeq?=
 =?us-ascii?Q?0U5mjRmPXhLRbifAqcRGwH4P6tUZkPs7JKwELJMHFn9XvXtMo/CrzyQvhPwn?=
 =?us-ascii?Q?yAAEtW8h1GpotrZNvf3AQw/Se+HFN5R757hblHSKxv0b0CmO4Rbz4dlXpn0k?=
 =?us-ascii?Q?2juCGKxniuNVlXt5day7QVm0XzfMXm4BtP7I+LLq6bmBcj+0Ge9sShTOABD7?=
 =?us-ascii?Q?OqSqHE9u2qZpgWom6u5Beydyj1xyaIZ8hb5mPy+Wk6v/bQBr0wcbp+P3jpE2?=
 =?us-ascii?Q?VfQ3mcOUzydcyH3UdXWXhsPeRWjFh9Ecz/KgrsIHpBQ+H297v6FT/TUwD5Lg?=
 =?us-ascii?Q?e7Fk1VoHH99UVO5R1jsEV05QOGCZqfVV1N0p1rqAZhqmXGRNNVmNOsfdreXs?=
 =?us-ascii?Q?oL05L32UdQTd2ayrcezUjV0br6gnJZEP+Jaamdyta3ioZ8K32OnJf/X8DfVj?=
 =?us-ascii?Q?huKobVnceS+55B3HnwGosXoY0hzhhmA4ldByNseqYWHQipLXE6B4CF5rJFbj?=
 =?us-ascii?Q?ygckL90Tn7e0WrM+keqK3Vc1MWnK1ZO4dRXf5DPc5fOq0xy7K4OCeBe3l7R+?=
 =?us-ascii?Q?foXWF2TNgZmQqI9optVSt7QyhFfHVpHggkuh45luIWsvNQFlPez+BeNorX9D?=
 =?us-ascii?Q?P8XTTPZ/g9uUdhHcqhlodw4JhGshzqkhzUE2eVyPM6BAiFHtBIaxU2j+xRUY?=
 =?us-ascii?Q?IpLDBZs+IaNvGXpLGnNmmZWtGuto27ObWnCIhmLGFdb4i3G/TOVATahLPsOq?=
 =?us-ascii?Q?BM2n6uyvwH+dCkf8MTSNynjdhdts16fXAJn4Dbcw+z0+KJvU60yXEXWmDoNT?=
 =?us-ascii?Q?dZexDATdDityb/MMHApwqMUDjRmrRLR71XqOY1HEtoBlqtTnGkegYmefqA1X?=
 =?us-ascii?Q?P+C/D6QpMBjFVzSp/67hcDGOnYOxDK+U38ytLBb5drPLkZ3AJ0h1OvnFWSjJ?=
 =?us-ascii?Q?qD5waH0bdgmoUQgKhn3ohCrdDowJY3PjhnV//UZoaloV01k+6YQxFdBrtsWv?=
 =?us-ascii?Q?Mb+O9JE1XXmCe2F58lcbsO7UnSew?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:59.1199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5c0e3d-63a1-42bd-6e60-08dc7f22a750
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802

From: Dragos Tatulea <dtatulea@nvidia.com>

When SHAMPO can't identify the protocol/header of a packet, it will
yield a packet that is not split - all the packet is in the data part.
Count this value in packets and bytes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/counters.rst | 10 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c        |  3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c     |  4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h     |  4 ++++
 4 files changed, 21 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index 18638a8e7c73..deb0e07432c4 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -209,6 +209,16 @@ the software port.
        headers that require additional memory to be allocated.
      - Informative
 
+   * - `rx[i]_hds_nosplit_packets`
+     - Number of packets that were not split in modes that do header/data split
+       [#accel]_.
+     - Informative
+
+   * - `rx[i]_hds_nosplit_bytes`
+     - Number of bytes that were not split in modes that do header/data split
+       [#accel]_.
+     - Informative
+
    * - `rx[i]_lro_packets`
      - The number of LRO packets received on ring i [#accel]_.
      - Acceleration
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 7ab7215843b6..f40f34877904 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2332,6 +2332,9 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 			frag_page = &wi->alloc_units.frag_pages[page_idx];
 			mlx5e_shampo_fill_skb_data(*skb, rq, frag_page, data_bcnt, data_offset);
 		}
+	} else {
+		stats->hds_nosplit_packets++;
+		stats->hds_nosplit_bytes += data_bcnt;
 	}
 
 	mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index a1657fad9a0d..96ecf675f90d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -343,6 +343,8 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_gro_bytes               += rq_stats->gro_bytes;
 	s->rx_gro_skbs                += rq_stats->gro_skbs;
 	s->rx_gro_large_hds           += rq_stats->gro_large_hds;
+	s->rx_hds_nosplit_packets     += rq_stats->hds_nosplit_packets;
+	s->rx_hds_nosplit_bytes       += rq_stats->hds_nosplit_bytes;
 	s->rx_ecn_mark                += rq_stats->ecn_mark;
 	s->rx_removed_vlan_packets    += rq_stats->removed_vlan_packets;
 	s->rx_csum_none               += rq_stats->csum_none;
@@ -2052,6 +2054,8 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_bytes) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_skbs) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_large_hds) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nosplit_packets) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nosplit_bytes) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, ecn_mark) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, removed_vlan_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, wqe_err) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 25daae526caa..6967c8c91f9a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -154,6 +154,8 @@ struct mlx5e_sw_stats {
 	u64 rx_gro_bytes;
 	u64 rx_gro_skbs;
 	u64 rx_gro_large_hds;
+	u64 rx_hds_nosplit_packets;
+	u64 rx_hds_nosplit_bytes;
 	u64 rx_mcast_packets;
 	u64 rx_ecn_mark;
 	u64 rx_removed_vlan_packets;
@@ -352,6 +354,8 @@ struct mlx5e_rq_stats {
 	u64 gro_bytes;
 	u64 gro_skbs;
 	u64 gro_large_hds;
+	u64 hds_nosplit_packets;
+	u64 hds_nosplit_bytes;
 	u64 mcast_packets;
 	u64 ecn_mark;
 	u64 removed_vlan_packets;
-- 
2.31.1


