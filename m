Return-Path: <netdev+bounces-109768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49477929DE8
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C2B284AFC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B2525634;
	Mon,  8 Jul 2024 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gSbXRU3q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A84AEE6
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425745; cv=fail; b=hZaJO4yYTU4VNkL+Fvii6FMYu7lerHu1bS6ymw9t+S3dfFZoSSycPz5KPQZ1ksvBNmHoa7+RXflgyAbj1wYHgQJTM3Jm3j2R4vjxh2aP2ZSM3jgsVa1ngfz64kSSlGq8QWTDOucEc9DOVG+vrmG0dNyEYTUI3EJ1dy/QVUpig+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425745; c=relaxed/simple;
	bh=NXqyCbm3M/3uO/LJkiD7zifcUf2AiOp4RcMoh8yHr44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuVCybZk92M7cXAOVdI0Lpaej0oVeYdtOBWfZXeJWbPp/S5yQng6s+x8kNxyAtCTm7S7pKrxYAmmn2UdHH4akhbOpU4VAbJMG0REH5id4x/h4m7sUnpdenGjJ9ccNBb3JVninl/GS/c3Pwc4BSnu2IEAgaPaKwLZM/FhIRxoIJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gSbXRU3q; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLSnug62+PQi1+e/LFfRGjLFEeIDNQtR34sXKUXOnCIvbPaD5rbUQasArwFe0Qb1IX4nxe+P5+2kHrT4I6WpHOgUspYb6hNKOd6ZZTRd8xrtQ1IqZ7yv4lI9FQ2iIpnqQQsmz7pRUY6gVPlhU3bKgwLlDUXzSn7zn7DEEhTAdpeCX+67aYF4AdSaUpIZFsoJZ9KzjafAXMCO9AMIzvQHNis6aN38qShn2MA/nRmUbOX/AbW2vafnrSczvzkpQCwYtGCNgEHUZKbbWzfoawZVg66JrrTfZrJsncYlILefkM9KukKlVxXfK111rNASX2vpuMmWvdYbtZsbeq1cq2A37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJarBeswd38mN62Mm6QnYaddXOnpgbyw7M7umv68Qr0=;
 b=dN+ItFqJA5dc5vZoSodOahP4dc8BqmIU7W5YOba3DjXFNdjcGjdiHDmZOL5ZGLKUCF/U/D369IqnuRuqsgw0gjKfs+vQaA7SaAegCV18BxKDvEWhUCQC1YEbkgAm3sVK23JB9MVEbLJa5wl4+UYa6rb0wWEIVAqmYihWxV5WAFeYnq6wIWP1VZ/WaGFcgvvGn2pxhCO6VR22IVuoPv51r5wddNH4PoVrdyYa7mv/sOaqFcyM352tFyls7oRIDE/lP/fdtJasvJSTcptKI3paaLwvfEvtDazJjfdqdb0/b1V/vdKj+B+y5G+NzviQ9oOFHgPRQY9CpyZeucQYWHRCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJarBeswd38mN62Mm6QnYaddXOnpgbyw7M7umv68Qr0=;
 b=gSbXRU3qUmpDsGHo7BQBzAkiPthn8AWoMlwpjKfKT25LeVhWckdWJ48irZGUoti7S0ousAVA4fkFNNVjUHjP/VwDKO1f91MgsEAxsLuYldvWy2ahAFNb6apiHcqBKzyqU8KL83gMm3+F73MGymrg3JVm+pOQUeqttOe2PcA524y3oToTKIcpcZuZfYzIBZhzyIQXGwDrfYeHqfo+Y+4gvZRYXM8AxPJsKRZikYfiDxlwnmM00Z8S32zXSvorK7TxCIfFzQNL4G8dS9nEC8CG4sU9t0dJ0bX0Hs2Q1RjlRGhHAHPcwQuiFXoppwmgd6w27/92Fk7Qfe63fSKOEqtNeg==
Received: from MN0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::27)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:02:18 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::d8) by MN0P220CA0023.outlook.office365.com
 (2603:10b6:208:52e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 08:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:02:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:02:02 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:02:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 8 Jul
 2024 01:01:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 09/10] net/mlx5e: SHAMPO, Add missing aggregate counter
Date: Mon, 8 Jul 2024 11:00:24 +0300
Message-ID: <20240708080025.1593555-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240708080025.1593555-1-tariqt@nvidia.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 71916363-21cd-4465-99db-08dc9f244953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AEMtBUuJ6CzpSEz3vA6G+P3vdN52Z4NiNMw4jIYE3um7D4NfHJeVx1xldXyY?=
 =?us-ascii?Q?YJm+ORSnFXANXH4XF58JPUPwAdo952atE+4/PWdt0bwkBzQw8Q4PGRbI5PaT?=
 =?us-ascii?Q?DTGw8otZMVT2aGE9fBQQnC6WmUX2eS/ileUlr3F/N3EDimgIUhKY3lRC6qBR?=
 =?us-ascii?Q?Ba4qHL30MtBbALYGv3uPOC4OqKn2iLgm5JrxVg533c10DPzGZYL6RXSbJ88E?=
 =?us-ascii?Q?QP34BG+yJtE9H11Fdy0Ra3BjecIoJleUz4g1jMLS36kh4Xkrse+3gq8WrWoB?=
 =?us-ascii?Q?n53zSCCiJ5spJzms/zUKHvV64akK3ko+/weiI+ZBQCGD30BqWdzJJZp1lShn?=
 =?us-ascii?Q?+ZyQOmeHALjPzYCmo+1CSiDF+lOO9hU59fRLCehubJPfX9NnzrUJjBIGcFbL?=
 =?us-ascii?Q?KZ3R1zRtl/IEBUJUvPmUhuaD1ATBhYFEAJEwwbot+rMHLyqm/i1ay6SQqvbf?=
 =?us-ascii?Q?fce3IkYTVubupl8sRYe1oslY7/BFaCpAjupBX8iYUpjp+l/YgGr1DAXxl5VE?=
 =?us-ascii?Q?qpNawXI6tmnaf8ew3q+g+EiKOZ0cDW4UbElenYO7inpj7qkrIYR/M/tdsMr8?=
 =?us-ascii?Q?EXLFtFdpZPqYRFrNxErzD3yuNc3H8F14v+loZVEFi2m7ygTjli81hPYRt1cQ?=
 =?us-ascii?Q?oH7JnM3ZPvQJ1vXueSypGEZDLGChTfbktNt0rE4IOH+YMzmf1GAxFZ7U9ozQ?=
 =?us-ascii?Q?7LUqLUVUn4yvsxNjGGLls/TqWMkBmm3G/+CsEJPoLi13jIkJnmNmAmVyxDNW?=
 =?us-ascii?Q?deQQouEqztqKjyf1aPgSSAKuzXDDKjcqEoeNSRuaAFLun2X+VdFv1/Ly9zue?=
 =?us-ascii?Q?W5HyMcQ95JGN3Iaz8QRIrqdqmqS7c1Ulu+/vy5/vFEEFoTbgjO0AH5RHb/5D?=
 =?us-ascii?Q?0/vyH8KOUGys3X4crPtZYWMlYagHQZxTZq5ttdiqv8gXmcG43yv5FxkoZ9xO?=
 =?us-ascii?Q?K6vCxT5V4msLpXfA2Nft9kc7ct+DEgO7ANYei7UiRgF97NOwqH+k6fDePAOE?=
 =?us-ascii?Q?0X0U0pzgT6JR0eGfROMjkvABmprrMk3ytSdWAMqVX30IefwwMPeLSXi9kbfF?=
 =?us-ascii?Q?cXHn1ksVyuaciFU9FhApas3TqeeO9mtt53FVC5BCsw5dArnnRfR6IhkpzkvP?=
 =?us-ascii?Q?cwuXk5y/KFG/5OappDN86lIaFJPd/3T/yUv0vZQ4n048zq+OgaURncYHCiN9?=
 =?us-ascii?Q?Z0ZZWqpGehGuA7aOCMVioQVxmnfepDaCZWIAYnhP6FVCAGHCUSjwwBERt4rF?=
 =?us-ascii?Q?Apyt9R+0S/tUM1so01vy6Q5v76hLD2VlFtGnlC2FzwnZ+Wd6gRRoDZz8SNi2?=
 =?us-ascii?Q?p5x4YkxZDfFK4VU0TDve5Crq2vghJNu0w2pAiYlO4pDHHp39ridM2vqch85b?=
 =?us-ascii?Q?zW37ZdqQgONqqBvzBHdZcMrDUeWnThfyvvunwOGQAVHWFLwYF7hMSG/JRG8X?=
 =?us-ascii?Q?TeeK6j8tmVPn2Y+gha2hWwRQeByA21Nw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:02:17.5747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71916363-21cd-4465-99db-08dc9f244953
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829

From: Dragos Tatulea <dtatulea@nvidia.com>

When the rx_hds_nodata_packets/bytes counters were added, the aggregate
counters were omitted. This patch adds them.

Fixes: e95c5b9e8912 ("net/mlx5e: SHAMPO, Add header-only ethtool counters for header data split")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index db1cac68292f..e7a3290a708a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -142,6 +142,8 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_bytes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_skbs) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_large_hds) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_hds_nodata_packets) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_hds_nodata_bytes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_ecn_mark) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_removed_vlan_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_csum_unnecessary) },
-- 
2.44.0


