Return-Path: <netdev+bounces-100366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E62A8DAF55
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04289285DED
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8E213C90B;
	Mon,  3 Jun 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AaqZcUKX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D9313C914
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449849; cv=fail; b=DYhh+WW2OZ0C/hOHazjsgiREWvEPYXofS8K5eh/SmsBq+TdvKo9kZRIBy6AGbLDOJ04BCq2sYoWQVbpSYQ2wfFPtjYfWgipsPfFZ5BinBDVM8z7DZf3s8C7VniBZcaSHPM20zv6UTbuDmC6IKqEtMUIOFA1kr9clEB0C+mttPj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449849; c=relaxed/simple;
	bh=TJZKGFydQLuM7QG2rBoqc0j0X7ZAgbHwAF9W4HjMHGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fs7Xd9jCvz2WWH7jPyCskI4yLYiqnF9/Q/l9JNLGwAGaKc4jk8qdeO7f7ONK/mhQEodOt7Wxn5J4wKrfmPtmtnQCUKJGxhittFQwIJ0WxIHvVjWgD7WNc5tRj5yiHneuGUEMiFwF5aAxcl9LDlufcBXiFdy0HuzlDZiUCwrxK64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AaqZcUKX; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AU3tafeJtBy5KhGcbja8glK7jwefqr9vHnabw51NgR1Cn8FCUEIq0plQoOCnVRncAVoLieLPMTL1wru0z1tjwNOuqTjDYJNWWOjGRkBtummsnP1EMrpSw568owfq0DHAUBxB1VjchM0kK29Qk9353r3VACo/enA9pOgMVl3mCmQS7gJ5CAMyN+5STFMb6R7UAEQvYd+0zxZ5H83Iqa8sODvEZkrutNCQvaJRes9Qv+KZ2IAsvEcrgx5wTY9amaob3ozY/T/7SIQovVj8Gl33rokNLU2eHYB8j9goDGKj/r6PFe5cCbrhUMDx/mGDSlGD6AnB5EQpcHsAlb2mkLJXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z70qeK1+wFJT3LlMDI/z2wYEXh2K+ndTJLRNTw2OloI=;
 b=f0+M9VcQAhWtirq20+TeOewk73feoRLbdiK/jZ84i0ddmlCjZtHtljxVasPgTyiVwOaWzFwgaTJ8/R3kH1pCIoVvFms6Zc2akVwI+NkV1PXecw30QsZYWwyfOv9W1C6J4YbUlHeq0qqyID5CjKxn90173syrHWQjF6tslJUbndiQIs1iWHet25UFHg+JrmlcO8JWSiVj8rweoEyBlWyuAhB1v2jEtfhEaaIh9UCjqPzONaq4Xh2JMjDljaYpMa3Mh4weIVsyKWNGHtnXaLGLSEUwBDjtNLwiqXBQRIvXHox7UDTjOTpyqgYuZbw7aYSuLmFI+AG461UzDOZIWVX0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z70qeK1+wFJT3LlMDI/z2wYEXh2K+ndTJLRNTw2OloI=;
 b=AaqZcUKX2nhD7KIQNNocx3ZEs+1tAtqqnULQuftKmO2CHUH0iQ+PcBlxv4u1CFcRINXlWrZ7wiD79IFBB+vf47KtcfDJcycuMfxHAG6AP/zWEC6vvsY8LvlsVT4/86Ag70cdKuLjKyui9n4EuipdAH8lZOfIjsWAdki5NhQCzAmMx7bQelFwPTxYnaI+IFSsDUdqZHFjLxMpF4FmSm1wKIUtGzWF8G3QDP7ATpQH2/zv9+pyhMgGncH/rQXrn0Rxae3LU7jUIduN1b412cSofSv3emwkdlgKqbOT4aowgAyh/N8m4cDAGfulta/tq+JuiV5ODwHaUS65lHQN28Na3Q==
Received: from SN7PR04CA0105.namprd04.prod.outlook.com (2603:10b6:806:122::20)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Mon, 3 Jun
 2024 21:23:59 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:122:cafe::4b) by SN7PR04CA0105.outlook.office365.com
 (2603:10b6:806:122::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:23:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:50 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 11/14] net/mlx5e: SHAMPO, Add header-only ethtool counters for header data split
Date: Tue, 4 Jun 2024 00:22:16 +0300
Message-ID: <20240603212219.1037656-12-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: c407ef7a-d089-439d-b8d0-08dc84137ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+kJ/fvX3X3KVzi+fcfDSFwn0wiJjtuYJY916Js/UxGBcx0a1m4Ynru91w9yQ?=
 =?us-ascii?Q?ZmL6xQF2EeN6LRG9ix9SQATaVIh2CrCoZxYDhueewBIjWRBBVpeWxJJvbVo+?=
 =?us-ascii?Q?AtX/0lmr03BJbg8+uslzXuevZn8xSs7JkK//1YQh4Fuox554wFV8URaLUi8m?=
 =?us-ascii?Q?1sDpwgw365KP3IWcvz4PEXDQUkyueAyFpCktSZZkL88EOXlV7+gEwkmbriaI?=
 =?us-ascii?Q?Hk9VPsGMix6R65Sdx2UR1LfWny+gRHaDOgzjgNT+qJCKjIzP+99Tse1cWT33?=
 =?us-ascii?Q?qB1ma01mepqTIJnIATMrjD9TWG2HHuHUC98gRkPXxC4Ck5g7NEjlDC0Ifvub?=
 =?us-ascii?Q?yWZZfun6MRAgplE+xsWVSxXRVY95W/hiAGsvQJg4EvA6ls3GZKTtEBTJHss9?=
 =?us-ascii?Q?6sk5e2rqAzMoyrefzuY6PmalmmvEG3nZonU0GyZJnsY2xzkwvKEvT5+qrSTV?=
 =?us-ascii?Q?9YOCsgMMUKsleCyDloXFc22hb6VN2+nH7KwXARwlCwKFKNwYUIFzvY1GLaf1?=
 =?us-ascii?Q?95qzTOohgYwE7MGLK/3F7ZC/bYmy78z3qZU/IfrlMrfbmlZiw616sOa493mx?=
 =?us-ascii?Q?2UQZXRIqnP8eLQ8lu9KUo+4jQoPI4XBBVYjb+OVcA83gvNp5al4LQ4lYTXTv?=
 =?us-ascii?Q?cL4wSsdmz7jB0y9xG1j1lvWAeeAK4a8G7LQi9fZw7Zlc34Jsh/E+yEdxsONu?=
 =?us-ascii?Q?oIep770OxS6L0L8w/nmXAv1wYOn/oC9A5ABDgyj53bgfxETup81s8sBYj5ZX?=
 =?us-ascii?Q?oaao5JzL478lU4kL7c55+52vrbQ+p9ZphN9+2VYOjYd7VBgtavGXHSexkeUM?=
 =?us-ascii?Q?Fuzem9EcfjZxFcBDm5dPnWKaieiT/vIlXM6OcqiL6O8vshqocZ+uFmH3IPsC?=
 =?us-ascii?Q?06uuskVsmoF68djJ1KMVpca1Vvwokp/vKwoN51Q3tgu20oIor9BLMVknhF/i?=
 =?us-ascii?Q?xHP7P3hR9xyDR7UgpX2J5HxdK6a1i5Uv2rcSDsa71jtevtaItRNX6j1uWxbJ?=
 =?us-ascii?Q?99qLw36iSyv0R64CJnF/xXCHWRrXWku0Y8jonNN7tOwhm3o63LutXFu74xgN?=
 =?us-ascii?Q?b/cKCwvu6KoUpBNikRd7dlLlQsX+OJpjSyz1tOhLdLpd9bKkJlBg/ho+5i2p?=
 =?us-ascii?Q?mM/XUie0jfMJOf568v9/SVY8b5dndIxTuxKS5p/EX7T2E12anXYmpzpbX/Cg?=
 =?us-ascii?Q?Qt2U0fT9rcPGVBLqFlWZBFTpUFWO3mTT2Xy4ro6D7eCl0U3OSDcQaTXSx43i?=
 =?us-ascii?Q?gYZndfmeNM4yOd9ZBAh07ZbmFXHVcGssPMj4K/rI4zGGn4Ld8wpMiSw/mE9S?=
 =?us-ascii?Q?WOPT0dxSglYnoqDDC1RdoizMgwG1fmIkfoPttoDTKEctn7R8WB79eRAe1i8t?=
 =?us-ascii?Q?fszS1uKTO14I8Oq+s7GXouOH1m0R?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:23:57.6558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c407ef7a-d089-439d-b8d0-08dc84137ab6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288

Count the number of header-only packets and bytes from SHAMPO.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/counters.rst   | 9 +++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c       | 4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h       | 4 ++++
 4 files changed, 20 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index 18638a8e7c73..3bd72577af9a 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -209,6 +209,15 @@ the software port.
        headers that require additional memory to be allocated.
      - Informative
 
+   * - `rx[i]_hds_nodata_packets`
+     - Number of header only packets in header/data split mode [#accel]_.
+     - Informative
+
+   * - `rx[i]_hds_nodata_bytes`
+     - Number of bytes for header only packets in header/data split mode
+       [#accel]_.
+     - Informative
+
    * - `rx[i]_lro_packets`
      - The number of LRO packets received on ring i [#accel]_.
      - Acceleration
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 7ab7215843b6..3af4f70de334 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2331,6 +2331,9 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 
 			frag_page = &wi->alloc_units.frag_pages[page_idx];
 			mlx5e_shampo_fill_skb_data(*skb, rq, frag_page, data_bcnt, data_offset);
+		} else {
+			stats->hds_nodata_packets++;
+			stats->hds_nodata_bytes += head_size;
 		}
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index a3c79da1525b..db1cac68292f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -343,6 +343,8 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_gro_bytes               += rq_stats->gro_bytes;
 	s->rx_gro_skbs                += rq_stats->gro_skbs;
 	s->rx_gro_large_hds           += rq_stats->gro_large_hds;
+	s->rx_hds_nodata_packets      += rq_stats->hds_nodata_packets;
+	s->rx_hds_nodata_bytes        += rq_stats->hds_nodata_bytes;
 	s->rx_ecn_mark                += rq_stats->ecn_mark;
 	s->rx_removed_vlan_packets    += rq_stats->removed_vlan_packets;
 	s->rx_csum_none               += rq_stats->csum_none;
@@ -2056,6 +2058,8 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_bytes) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_skbs) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_large_hds) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nodata_packets) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nodata_bytes) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, ecn_mark) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, removed_vlan_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, wqe_err) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 25daae526caa..4c5858c1dd82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -154,6 +154,8 @@ struct mlx5e_sw_stats {
 	u64 rx_gro_bytes;
 	u64 rx_gro_skbs;
 	u64 rx_gro_large_hds;
+	u64 rx_hds_nodata_packets;
+	u64 rx_hds_nodata_bytes;
 	u64 rx_mcast_packets;
 	u64 rx_ecn_mark;
 	u64 rx_removed_vlan_packets;
@@ -352,6 +354,8 @@ struct mlx5e_rq_stats {
 	u64 gro_bytes;
 	u64 gro_skbs;
 	u64 gro_large_hds;
+	u64 hds_nodata_packets;
+	u64 hds_nodata_bytes;
 	u64 mcast_packets;
 	u64 ecn_mark;
 	u64 removed_vlan_packets;
-- 
2.44.0


