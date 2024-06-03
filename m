Return-Path: <netdev+bounces-100361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6DD8DAF31
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DC4285CA4
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5201113C3CD;
	Mon,  3 Jun 2024 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jzqqOtyd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8EB1311A1
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449838; cv=fail; b=alsVzlhi/TFZ1knzZ/PPxH8ksNKo1s++wFZprcg6uGUbImPt/Qf7kmiIp99tuRp79LOBbXE3QJljKwEXSYALbDuFbxwQ4wtfcNcdYmk+xjxpSfELjmLeSn2Uhf+hDCZv7Q3vO4FOeDeRrXh9sRfKADkQfhH6fQhZaLRBJ2gIHFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449838; c=relaxed/simple;
	bh=fa6icr9ENtHix7PpR153w0Uk6QKJJ4/EJwsl1cLXRxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+q60Lecpaq5Q9aeXd0oKRf2f51/++LzB9q293tsSMGzdcXN5IKIS1St4P8+ZgKiI9ZCxGs8i1rpig2IEAvkP9BShwmIeCyGa+M/yWKdTHK4WGRrMM8mEdyGdis/mg0ZMMHz8P0qB2ocseZucR0gK3VeyGRNSR9E17Y4GP7IGLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jzqqOtyd; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIX6/UrE0/R9T2VNjBOgUW+3TJobGUWFiXsfKKFi1HKw1yEpjx4NII9VFtV2Z0Cbewc+HYEwd82HJB15dxMxXqFd0W8Sneqwhs69YJ3eQ/oehrlmUx4gCi+gAbAvLV+EiTV4TdiWw/zsWzl+pyd1LdfQsl+yc8m7zYKy5BgOXPAzZyn5tA8+iVjISHF8qNNQwC5J0qSpXapKgO+eboR0VeGimINvdg2DgJdjNMIM2z4hzJxv0aGvyzMWhdVAzCgd+7H213ilTcc7O6CCwDDD3aKplWa5qwvcUPBGGlFzWaAGVn09CExQjlCMhflc9CC6g5FLX5GS7LJ8JJtHn5iXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTCoPd2xeYd2qbbr2nYmx897XxAZHkbtTashSgLzjnk=;
 b=Ifq2943ipzShCXF/Xw8zSKJsfGRjMBgsGDB5WksXZRKZ3HOQckjBtOOywWmq4UTjV1TrOOTjiEiAgJiG/sBtcf7PtQcvJ85kXxBZt+xZ/0XkWRG0B5A1Nc7gyuzUSimIRaxggeiC4lWWoXV3OgVgP+ge07Om5T6Yzg1SiSXhfKTSTx6wZrlVbyBYWlnN/B+51h6t4BbubwqYpULcOBdm8ND1l1QQCLKQmb3VODRrlO7Gf/3nthmEiDfQtPwXkTO4iYnU6Qow45Lcf5Pv7X3AYuwUJRQ5ABTyrAyQ/TO95B8aYwMvxToJMRVpNYa/iDlSCtOhpLhbtMI6hqAgrtwbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTCoPd2xeYd2qbbr2nYmx897XxAZHkbtTashSgLzjnk=;
 b=jzqqOtyd47DkG8uM4R+NIE+k/wkMrhea/D3iBX6gjqxekKk+zctMjeshhLykMfzi0z+X1Jl0H1Fh8Qs2RMi9fpeiZ7l1bBbiPubr8YdWpGqnoGNqhu4LgkeiEtSTS3ZrWjtgRXF316s2j7JR2Lrk8Qog8F63Lui041Q0SDON+4LWnTtghkMYzEnoIsMLeqHzt3xHv85S6lbZl763lh+W5QQjJERYiU7Eq9D9mopyi6wBX/pkhbyWBGp5hIBAR6zfreWSag1vtCiGQpzHHxN1KhxCDOQ5MIWGPt+8t4yg/GTEnkfgwAZhnt2jKNK2CrvLD1WspS+1rqjAfietqyfqfg==
Received: from PH8PR07CA0029.namprd07.prod.outlook.com (2603:10b6:510:2cf::27)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 21:23:53 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::24) by PH8PR07CA0029.outlook.office365.com
 (2603:10b6:510:2cf::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:23:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 09/14] net/mlx5e: SHAMPO, Make GRO counters more precise
Date: Tue, 4 Jun 2024 00:22:14 +0300
Message-ID: <20240603212219.1037656-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 6960058c-2bd5-44fe-cd47-08dc84137828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bZAZ4DMUoL9X2DYn/dyOzZ4dYmmJoicYcvOio+my4+e66zyBee8eHTa+Dtdg?=
 =?us-ascii?Q?UKxD6aibhofrQ6p1c9NnN+Kea2B+AO0DqdyOEFnMWERECfO4cQi3TnKVruyM?=
 =?us-ascii?Q?yZDXNhn24SA4aaAEyW74NmkMt3UbjgOMBhK0no/iVhYpl/0B/+l56zc1yPTi?=
 =?us-ascii?Q?HGGBx0zR+ph65/tQnjDAg92Wb8i6XSDOD/xBeekDPHPcLpqCNjQlpo8oW2a9?=
 =?us-ascii?Q?4hroTC2bkvUrA2j6NA4QnB9FjVHmxqlb9+GIUHzz4N0hz0ByNAf6cRvbyrnL?=
 =?us-ascii?Q?871G5rocYkswV5/a0VPuE9BR9N+hX4/WyfTKUZVN+R23ffU30+TTVWkWK7gR?=
 =?us-ascii?Q?AzN8RHyGfMo7/+BLdADWZkLflRCk4s8bKfUZ+5dg3nKjWvPiARdEzTrTyG2s?=
 =?us-ascii?Q?4cUaNUVoOb1C2UNHUwztrI18pF0Ds2dweDX/BQMgs4oUrX2fILwwLPpdf/Bg?=
 =?us-ascii?Q?ZpOTsrcNr1Sda0LTz42mPBG8X1pXPNrqFICKzJqz2GueBC0JXGaqhHA1ly7j?=
 =?us-ascii?Q?Zt2LBtyZzPLEvxxDuFb/nUVIO1jcFTajIxddHbPVjSreB+Fmg5p0o7gRBRp2?=
 =?us-ascii?Q?9yG12bKj0JQuWmCTDw+YTIwPL5/RWiqK3G1o2Tn7xheKb7V/u0DDIMATGbnI?=
 =?us-ascii?Q?qc6itGVVDUJtKABVYYMH+PWY+2gJeVvW3utoQe9xEzymk5dcz2cZ4OVOpJkU?=
 =?us-ascii?Q?NdE8CWMqc5fgO198vW9rFeFd8U/GP0xF06aPCzYCSEt5OKT2TktCpoKhFzcO?=
 =?us-ascii?Q?SwXDKJc9mhF3JxzmcicO2cmZ1i8+9y4POgqi/AHpXIzX5Z+rzfuUN3FwbK/s?=
 =?us-ascii?Q?DsZQ2jXRDraXkyoiu4KW0N48ibnACcN6RGE1Fi8dXEEvUQ+SjPPZ6Fn8t3Kh?=
 =?us-ascii?Q?i0cU+QY7dR/ri49GvKcZVAckumD06UBwJ15v61ZTO4yb/8rUl6nPNN0KGEk7?=
 =?us-ascii?Q?ZZlMRRv2eoBQnbwC70NKV5d9XQtRnK9IkmjIn7Zy2FDz7SsxZIiU+Mndrm08?=
 =?us-ascii?Q?A4xwhqTRBXY5CVEzke3xlmyNDGlMDmkyjzar6973liMMqRMgk7jSPNiAcYI8?=
 =?us-ascii?Q?+9NfpkxHz6VZ4mT+5OVV+VA4NwoEFSIlL30d9Pxj907ORmQPHLJaUbyfDjWr?=
 =?us-ascii?Q?isHEqQgXrx4aeknvHChp1byezCi28uXqHWEko+Y8vAuv+cINsNi4lAtl8rUC?=
 =?us-ascii?Q?Oj8Sm9B47dFkrmN77Gg1no9OHRfeqvYZaPU5XEBmEf/jPwBAUHZzbhpyR3Os?=
 =?us-ascii?Q?SJ/0U2K0X/cI43TID8Bu229PO5T9gGP8UThv1URT3rfxrQbrqDRopkrhN/cJ?=
 =?us-ascii?Q?0TrsFAHrWQySw+IErWAmel8j1S7ISZpePpQ4T2PjP5pJq7rUBwK+xFrySPR2?=
 =?us-ascii?Q?uJT5R/0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:23:53.3702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6960058c-2bd5-44fe-cd47-08dc84137828
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

From: Dragos Tatulea <dtatulea@nvidia.com>

Don't count non GRO packets. A non GRO packet is a packet with
a GRO cb count of 1.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/counters.rst             | 10 ++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c     | 13 ++++++++-----
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index fed821ef9b09..7ed010dbe469 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -189,17 +189,19 @@ the software port.
 
    * - `rx[i]_gro_packets`
      - Number of received packets processed using hardware-accelerated GRO. The
-       number of hardware GRO offloaded packets received on ring i.
+       number of hardware GRO offloaded packets received on ring i. Only true GRO
+       packets are counted: only packets that are in an SKB with a GRO count > 1.
      - Acceleration
 
    * - `rx[i]_gro_bytes`
      - Number of received bytes processed using hardware-accelerated GRO. The
-       number of hardware GRO offloaded bytes received on ring i.
+       number of hardware GRO offloaded bytes received on ring i. Only true GRO
+       packets are counted: only packets that are in an SKB with a GRO count > 1.
      - Acceleration
 
    * - `rx[i]_gro_skbs`
-     - The number of receive SKBs constructed while performing
-       hardware-accelerated GRO.
+     - The number of GRO SKBs constructed from hardware-accelerated GRO. Only SKBs
+       with a GRO count > 1 are counted.
      - Informative
 
    * - `rx[i]_gro_match_packets`
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 3f76c33aada0..79b486d5475d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1596,9 +1596,7 @@ static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
 	struct mlx5e_rq_stats *stats = rq->stats;
 
 	stats->packets++;
-	stats->gro_packets++;
 	stats->bytes += cqe_bcnt;
-	stats->gro_bytes += cqe_bcnt;
 	if (NAPI_GRO_CB(skb)->count != 1)
 		return;
 	mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
@@ -2240,14 +2238,19 @@ mlx5e_shampo_flush_skb(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
 {
 	struct sk_buff *skb = rq->hw_gro_data->skb;
 	struct mlx5e_rq_stats *stats = rq->stats;
+	u16 gro_count = NAPI_GRO_CB(skb)->count;
 
-	stats->gro_skbs++;
 	if (likely(skb_shinfo(skb)->nr_frags))
 		mlx5e_shampo_align_fragment(skb, rq->mpwqe.log_stride_sz);
-	if (NAPI_GRO_CB(skb)->count > 1)
+	if (gro_count > 1) {
+		stats->gro_skbs++;
+		stats->gro_packets += gro_count;
+		stats->gro_bytes += skb->data_len + skb_headlen(skb) * gro_count;
+
 		mlx5e_shampo_update_hdr(rq, cqe, match);
-	else
+	} else {
 		skb_shinfo(skb)->gso_size = 0;
+	}
 	napi_gro_receive(rq->cq.napi, skb);
 	rq->hw_gro_data->skb = NULL;
 }
-- 
2.44.0


