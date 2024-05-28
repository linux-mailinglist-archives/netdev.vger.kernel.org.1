Return-Path: <netdev+bounces-98637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E328D1EDB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF112828C4
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C83116FF37;
	Tue, 28 May 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O7GDlhOZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8D171658
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906609; cv=fail; b=CMfpEjybVNS2NxtG2dRrxrgZi+9dRDY0xoMPW76Xd6k+Ni9UX91cdj9F5iCi6DQTsvI5x1aAIKbK0lNq0w+ZzUdY5upMxMwKWiYS/KsBh4zS5rKKIg130Gk3D4uV/vhmbo2fiP60+b1p5ewntfPKke9x3nGm4q/84qNJAClGjsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906609; c=relaxed/simple;
	bh=wFOWL5KavNLGN/WhqXExqOOyn1hlPLEpRtsMO7wdAnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmS6c+noba/C84gQ+moLe8cS5jcn57pt/B6DRWn+8KJhzd6krgXkXtWKX/pZKSJWKDrXqhGwqwe+7ALP8KD0JMEPV00mOAPQkY4Obk6cYEC8FmLH/8ei+qPh1KOy5BxlhhgBXTHJfQkHAqYZ+zC3kTfkPTO+8DzeqihXv4S54L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O7GDlhOZ; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muWsqBsRd4h9kr93+SvPczvLwT3wF7WgL/j7yIl5JQECRGFlfFJZj4aAo9xJWQJSNOBRtG0tv32pHuuUdmdEPoz3uPrqT8s1eJYVQWjdNOgr931ToVKH8CgICKDw91dcAhI5oHRrRLEunm89IA/G5DNRH5xfAlGIXQlV2DWqqFjxJ52SDMMTKhsdfzc8A5BeNZDcuN9bMQC1SIGF3Rn26huvnvKoB9gscQrpjh3pfJrEn7ySpc5q7JKms+RE7TOunzX3DtS+xssGD3mKFRVzym64EU9nMC0C+MkrbDva3Cmi4LYwBA0dLifkmzgV0VFtfZl9a9VxHmE9tauzPSbt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+OrDT6jwTz+oIL0AqtQJkC6O4fn5C929vIBbephTMo=;
 b=Vn7ufjlbJcHHnZb0BIasBNdRUxnOXYzGLJbnFFw4E6fGLQQ6upVfCtripN6gF3RkMeZ+jf2WQWuNw0CvL3+ph4vAdXibSN1vTtDJs+O3NxTCmB4oXAwIEA/pstrBpgUX15bUvGtyPsDrtV+52HTObqTTxZbNuNYsSSh/EyoEg9U/B8po8GsTSRccAqdyTTnMzR3jkE1DD/TvtrT4JQT0lYQ3YYHdjZag3xA91kwTMGUXDgbpyZD4RnfeiuUewuiIkmfUeE619kmZVlry3wMxDwLWleSezAotrPjnGJxh4AI+g9YMAvzDm90ELMZj8+L/EMZUq2uDbYdXNO7wCR6N6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+OrDT6jwTz+oIL0AqtQJkC6O4fn5C929vIBbephTMo=;
 b=O7GDlhOZ72iN1u4rWnTbb6zBiS7ebAIndSV5VB+VLGdBl66OLCZViiSAGvUkkH6hpVDENzVqo4CPBwH4nzjEF5oQz930uQlxDw5GKc04oqpwqQMQWi2cu4w0gq/KI8wXtWkHzlxjW2mUFOuUGDK5JogkkRU+GJCEK5/x4vRJSWLf1p3CmhbK03O7a6njxAdBGG/neH6RNlRZ+cZUuQ0WNG6RJBS4iAmE4VarmYcOj56cxcxBut5fMt6Tx5lnN/wBkXtm8LwqDPmCvmhVrLl2TpMBcPRwDUjjx2otBMopnu3dr/7rmB0VmALAf99Y0ED0JoSk93QPZDxDsncldLJw+Q==
Received: from BY3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:254::18)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 28 May
 2024 14:30:04 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::86) by BY3PR05CA0013.outlook.office365.com
 (2603:10b6:a03:254::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Tue, 28 May 2024 14:30:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:30:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:35 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 12/15] net/mlx5e: SHAMPO, Add header-only ethtool counters for header data split
Date: Tue, 28 May 2024 17:28:04 +0300
Message-ID: <20240528142807.903965-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 97da7ce0-b48f-47a9-376a-08dc7f22aa63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d7UpyNl1dOzdkQAIJ94/UwB2YMoLhwbd3a/sRD7HixgrnLwAX+04gWV2L/Zt?=
 =?us-ascii?Q?DFygbwOKP9oiOYWp2EV/5m0sUwIQYAHMkpqlC8vAf1YNsGZgfJfbuu7qxOsb?=
 =?us-ascii?Q?dmBhz5OE47iSEhhuKecnKxlgJvHrslBEFR0NIvxW7064GDt1On1lonMjGeiY?=
 =?us-ascii?Q?WVtLlAcVufoR0vL3yu9gd7FuRrzNjzMJYVon11nG1QdGUfWNwsXcxM08BEx4?=
 =?us-ascii?Q?8sHSu/bQznY1Hs3a9jOAeTajElYb3P1dI5lcwDsdxZlvNNQne3Nv64uVdeAW?=
 =?us-ascii?Q?nihDwwP+A8QwO/NMMNJNwJQhT6RkMMoJ+jAQb5h+QxpYzBdd/5H0sNh4x6LA?=
 =?us-ascii?Q?epvdrtoXJRAWhYKix6jt/Li88Upr/bK98I+QQH73da6Zdt+TaTXltTrSs/Iq?=
 =?us-ascii?Q?xDa5HOFtzzcY/imuzl+ldyJS3cfmdzenaeuSMpqEkUtYGYSDpdAt6rfhgwd4?=
 =?us-ascii?Q?JHwBJnY1xCirMu/vnub9eBt91CMcE5F+sP40I0jH6bbrGdh9u3+lfz02956v?=
 =?us-ascii?Q?DI3TZ8zO16Q/w90ey28IXKveL3BYRtBxgPVw/pbYWoD6MkllPlX3+ivpH2UG?=
 =?us-ascii?Q?/7x3VzNOxNW7GdFD5zVUF8zg182Ue9dn8C8r0qpSupe9WleLioqetw0wviQ1?=
 =?us-ascii?Q?xNL8zjKkh5vVPE8vEmVtx+kpfd3zncm0DbWgmNfNZHmdIGeiX9i+LAn/aXdd?=
 =?us-ascii?Q?8RERTshtyc5SSgK/ar7vUE29a7jwP6lVMC0j76tP7eJXGh6xDPMYxdXY0gLZ?=
 =?us-ascii?Q?Fe2tLUyXWgs1VtmunFit+gGZ57nD5qicpJ42jhkvPWNiqeb/4xH9pMVSU8Cx?=
 =?us-ascii?Q?JksWkGN/kLtRfmHNFv4UO3YMcMN0B7w3j7D4UwhzNtoWTLjl+zJNgzvOpxUv?=
 =?us-ascii?Q?UWKyJRsVuQ+z1ojaCuUB02xAWS2YguLRgDhtPIbOp8hfag6povznFqQsNTpe?=
 =?us-ascii?Q?el607lA9KgzGYffv4OIWdRGDPMLvZJS9AJgQvU4FS6dN0VKJ8KE0MnpYkbUL?=
 =?us-ascii?Q?dlNELuOilcHd69rBxhKh7Wt3JXnBxL8WfN+NsVErznyLjslDjyNC3fkweaB9?=
 =?us-ascii?Q?IwNbMgpdzs2cmTan94T0JBtwP7sVpzmlYio2hobV1cd41WPXaQ/J7nZg27QG?=
 =?us-ascii?Q?W2zpREkNnySBw5YDHw536T3bQkLW4fSF8mEIvMsCroW/OnJiRfu0a6tYufQF?=
 =?us-ascii?Q?FRanoylcOmtLgfSbj2NL0PaK9hOrwRMfgUaokGpBUBIDpc2Vt07C27K0JwL7?=
 =?us-ascii?Q?n02oEzqV6EjeyAVS/t8qXLu4i0D9TRiUx3NN2u+Pl12w1IbwuQb+QET+PTQO?=
 =?us-ascii?Q?lgS+E7QfuIH8E7+cfCtyFz9T5rzg0SEMZz0w67GVb/xPBYtdz4dru1RwONHW?=
 =?us-ascii?Q?Z62N79Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:30:04.2762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97da7ce0-b48f-47a9-376a-08dc7f22aa63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998

From: Dragos Tatulea <dtatulea@nvidia.com>

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
index deb0e07432c4..9d12dd154d2e 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -219,6 +219,15 @@ the software port.
        [#accel]_.
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
index f40f34877904..834428ed45ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2331,6 +2331,9 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 
 			frag_page = &wi->alloc_units.frag_pages[page_idx];
 			mlx5e_shampo_fill_skb_data(*skb, rq, frag_page, data_bcnt, data_offset);
+		} else {
+			stats->hds_nodata_packets++;
+			stats->hds_nodata_bytes += head_size;
 		}
 	} else {
 		stats->hds_nosplit_packets++;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 96ecf675f90d..a4c2691e3bd9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -345,6 +345,8 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_gro_large_hds           += rq_stats->gro_large_hds;
 	s->rx_hds_nosplit_packets     += rq_stats->hds_nosplit_packets;
 	s->rx_hds_nosplit_bytes       += rq_stats->hds_nosplit_bytes;
+	s->rx_hds_nodata_packets      += rq_stats->hds_nodata_packets;
+	s->rx_hds_nodata_bytes        += rq_stats->hds_nodata_bytes;
 	s->rx_ecn_mark                += rq_stats->ecn_mark;
 	s->rx_removed_vlan_packets    += rq_stats->removed_vlan_packets;
 	s->rx_csum_none               += rq_stats->csum_none;
@@ -2056,6 +2058,8 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_large_hds) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nosplit_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nosplit_bytes) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nodata_packets) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nodata_bytes) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, ecn_mark) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, removed_vlan_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, wqe_err) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 6967c8c91f9a..b811cf6ecf9d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -156,6 +156,8 @@ struct mlx5e_sw_stats {
 	u64 rx_gro_large_hds;
 	u64 rx_hds_nosplit_packets;
 	u64 rx_hds_nosplit_bytes;
+	u64 rx_hds_nodata_packets;
+	u64 rx_hds_nodata_bytes;
 	u64 rx_mcast_packets;
 	u64 rx_ecn_mark;
 	u64 rx_removed_vlan_packets;
@@ -356,6 +358,8 @@ struct mlx5e_rq_stats {
 	u64 gro_large_hds;
 	u64 hds_nosplit_packets;
 	u64 hds_nosplit_bytes;
+	u64 hds_nodata_packets;
+	u64 hds_nodata_bytes;
 	u64 mcast_packets;
 	u64 ecn_mark;
 	u64 removed_vlan_packets;
-- 
2.31.1


