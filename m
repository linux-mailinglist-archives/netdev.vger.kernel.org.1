Return-Path: <netdev+bounces-163026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEDFA28CE7
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8602C1884C83
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FFB14B088;
	Wed,  5 Feb 2025 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ULGF5RSh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C8FC0B;
	Wed,  5 Feb 2025 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763715; cv=fail; b=HUx7DGvTORCNw+NHAz3juTY0MnU0NpXmCX3kemUh87RkM5F6sMQrhuE77gq1BEmX0866amZMlm3tgGOCKF3pxe4F3Ki8L1n7a71jEF44fmuDbaO0wLhpWSxxQiXjZdUhKzc0SnVei3XQu62MRVibjF7QzW1iF5LM2x9U8ABdd0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763715; c=relaxed/simple;
	bh=fM/Ynk+nja5vyIfipDE5uP6dPQuISD1Oh14diRA2qbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uD2pMD/AT6ud5KRexOo7fvC8m7sOO/CltjZkdv0SQFRVsEZ/juk8kmeRiZREKkjJ9x/91jjtvEpZ/8Svi4MKy8o0aUcvikgGGHBIYz71RddNc8cPin6y3TSI6149IyLe77lRPsZwLh/tNKz+bzD3m20JVDMCU7+WOH3en0cg8Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ULGF5RSh; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7ZsZ5I5YcGDUIgSl76eJDfblbTu7Y1o+9S+ZBL3O5f4HeGxscR7IzxHnYskc1KJ1y/t4DspcTZHreLfoHoLAl2MwnkbQ/0TRQCGEu3AmgB4VYQj8UzweNGG/XZ4UJku9e3Irat5a91i5IGk4kldlwV/EtA46jlDDQS+eLvyYrjCL1X5O4qszrmrmUsMolv+UKil1xyx3WDZiFqHKNT5DCeKfSqpHHhn5KsBYVkcNyx54JwNSAr7+toiNrNQRvmWExh4a8HIy2CFpFJEfd08pKqeN3jsuT6C9FnSSrfUAAM2E5FESDAAlWeKAweqNI6D0EA/RsIwnNwg3i9pdl7FoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca58S5zLvWbM81+SBYQ3l91t4WubQWIJWGfAy4cAPv0=;
 b=TUPbPjGvwI6TXvPyjMpu2zLNnivoskqjiXus6NX8RYLGKQm53FiGeKvTaDDkWg0b+qpUhWLI5YkE+B0eunh+HUfpYCfGkGOgOvmI/E0RB8sGoS+DTQ5K/IyKOOrzZ6/BfMgIgC45gZz+u3MlMfxs4ibK9EkQNHmQxV/7ncGQE1IFRnJC3wCozM71Cs9IC5ONnaQ+FrNFp3RPL4YXx1XG5bnwERHNFRfRBy2EBdM94HFRXJb6GEjt7Eg0GzIrBeEjtn1OHnzxACDV7JNwR+GrRgZujnp7xdK66+SXIO/3LLYCdFosnpUI7nZx4BlOhb3Okq2cCNANkwNGkzXzANUUpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca58S5zLvWbM81+SBYQ3l91t4WubQWIJWGfAy4cAPv0=;
 b=ULGF5RShYX1wXNEiIXu3Zd4mYL5Ej5RBiE+bT7gFsYlR2IdDSVebTIlKjfbxK7Jvy1VcYTIkySmP+D/iOPigNUQ4WlX8CIRcA09VL8SFBCBcywCtqzz+R+ZHrKwfss6xnvEVxTi41HSWBt3IsoZ65rVGHvKAevBegKDr+IiY96vjt3T0O1ywNPv5wDBN+oO+19Y6C7/AOzoi1dgFV6UvKUD1iQUg+nUybf1vfTlMfpKcDeb9WgSu64/EaN4iYqEHzEaoQrCKonXBMpe6FP/kBsLKbmJflZ8R8M3/FAHdRbklTw0aViHuBwQXSjQ8hUJdWSh2QKpq10ISt3XNHoiZmA==
Received: from SN4PR0501CA0040.namprd05.prod.outlook.com
 (2603:10b6:803:41::17) by SN7PR12MB6911.namprd12.prod.outlook.com
 (2603:10b6:806:261::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 13:54:29 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:803:41:cafe::5) by SN4PR0501CA0040.outlook.office365.com
 (2603:10b6:803:41::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 13:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 13:54:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 05:54:06 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Feb
 2025 05:54:06 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 5 Feb
 2025 05:54:02 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v2 2/2] net/mlx5e: Symmetric OR-XOR RSS hash control
Date: Wed, 5 Feb 2025 15:53:41 +0200
Message-ID: <20250205135341.542720-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250205135341.542720-1-gal@nvidia.com>
References: <20250205135341.542720-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 184d8a33-03b9-4691-5462-08dd45ec9c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V04hzqVrdzcsMS+nm5IPUtrAEc07U5b3v9M+nMmlMVOdwjt9AjQKvcUD/gOi?=
 =?us-ascii?Q?L99zetQIQbf/OIKm7OBVClCthe46iApQKpqLeo+B8nfsrLM+ZKMTYrQEgJ5O?=
 =?us-ascii?Q?weFdr3lQiJ0kNNFT1lptxqSRdLVs/WSgqGxqRMRroS6nTdAJR4pJeBOg3QtL?=
 =?us-ascii?Q?Xnq29E3haMdqDTdfC+ewqs4VY0vJPO2XFRofFrm+UYDEY9/uFhTX1YQh6GSW?=
 =?us-ascii?Q?UaeE/XXv70JkigltVaFl1CD4UcKb9UAs29YO/ckGWfH5PPb3MUIiLr31AJeK?=
 =?us-ascii?Q?Rhc4Nu1QVMpGigxNpemBUGPa9pzk9GcLeSr2+TpSgzQHbjl7SGYUWRv9bX5E?=
 =?us-ascii?Q?qaXB05UccgzJbOh+Ga6nQ96Oe/2TOCzimKRtD757dLZnOoz7yrH3SF9OCV0B?=
 =?us-ascii?Q?WL0cnFRoDNvn5wwKNHRj4H9wlgYRils4hFZTVBYvHkmelSVfnWiCP4/cHlJj?=
 =?us-ascii?Q?wzuVpIYHT7tFmCtZnvqbhCtdL9ooD127d/dt7Ii2ngJLA6qR6YoqGB4okIR4?=
 =?us-ascii?Q?0HF5hSviqnkEMwrwMXl/m5eUIOvAf+Ni2aNKG5B2PGMFn5jpobtFR+mZdiJx?=
 =?us-ascii?Q?UvuXAFkC7k7/uuBGGDF+D4BZF0YEtFEbHlojAwSBPPdp0+wtP/Iu4phNHltK?=
 =?us-ascii?Q?WiouoW8jqFzyUGLMO8bn39zqpkZUINrz7hy6mtvfkneMxPLJQJ3M83SrrFbm?=
 =?us-ascii?Q?FDUetnfVCOhvZR6WGiI/hZ5eDGwgtuVaerBkrFZt5m0IeiXCu9cf9UEVAL9Q?=
 =?us-ascii?Q?hs2ecLsbI4GiJusHUWmqb91KPIILCb7j8nk+rT5fZYDUwbfX5DNRz/cBMjBr?=
 =?us-ascii?Q?0QY7FZX0CTg6clZBHolgEgsBZ5/yPENVjIqQV3bwChD54HDhQtARMmNpzKs0?=
 =?us-ascii?Q?YMPoqubQ5DUYFz+JTOp26yxoCdc8Lwx0tMTnyoSt1M77oztnh/vzqtb9YMLR?=
 =?us-ascii?Q?8B9GKxzGevdYWiceKkNhNv+/F9NkFLPVC5u59h0en1aSQo2Lj56WZTEfIaa7?=
 =?us-ascii?Q?34JaPlAnRYYU8DH1BqDvQGQMq/p/T6QSIQC/QvXp1E2tPp6BshwlFbmDDNO4?=
 =?us-ascii?Q?I7cRpzM0LJ6aCOkatM+34tTAAAr/vp/S9ooiVaP06W1PgxXdyyx1fAGUmf/U?=
 =?us-ascii?Q?WN/RIyPLnGUB4/9ze42FySB7OVgkpcVg9aggF3YMO2G3c1wxoFC7o3ojcQTS?=
 =?us-ascii?Q?S+e21zR1VKzhAEq+guqOTq2sXxxx/z7+ouLHSx9dHZtDc7fM4gLihCvi4VDv?=
 =?us-ascii?Q?BQWJlul8hq1BMzz5AfMbTa4NqPd3jekZqOZzjEj6VVJVBH9GD5G4PfxtZbC9?=
 =?us-ascii?Q?TztbVX//2cgIFqyelWpOFDr+l54J772vkjL5XK4QuFaF7C6QKJwI0LHnfHSS?=
 =?us-ascii?Q?nM+ZbHDDhFuX0F3bN33QPtIZGSIf67dfxwH5sNveV45lFLwXU2ZjuTQYmB9i?=
 =?us-ascii?Q?yFVvO5UQBxyxm9TLsCEMfg0GJ8CDsrm7L3pbEzx4miM6SLIGPTscoPxLMMrp?=
 =?us-ascii?Q?+b6kfWkElRWBnys=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 13:54:29.4237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 184d8a33-03b9-4691-5462-08dd45ec9c6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911

Allow control over the symmetric RSS hash, which was previously set to
enabled by default by the driver.

Symmetric OR-XOR RSS can now be queried and controlled using the
'ethtool -x/X' command.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rss.c    | 13 +++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en/rss.h    |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c | 11 ++++++-----
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h |  5 +++--
 .../net/ethernet/mellanox/mlx5/core/en/tir.c    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/tir.h    |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c    | 17 ++++++++++++++---
 7 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index 5f742f896600..71a2d0835974 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -156,6 +156,7 @@ static void mlx5e_rss_params_init(struct mlx5e_rss *rss)
 {
 	enum mlx5_traffic_types tt;
 
+	rss->hash.symmetric = true;
 	rss->hash.hfunc = ETH_RSS_HASH_TOP;
 	netdev_rss_key_fill(rss->hash.toeplitz_hash_key,
 			    sizeof(rss->hash.toeplitz_hash_key));
@@ -551,7 +552,7 @@ int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
 	return final_err;
 }
 
-int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc)
+int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
 {
 	if (indir)
 		memcpy(indir, rss->indir.table,
@@ -564,11 +565,14 @@ int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc)
 	if (hfunc)
 		*hfunc = rss->hash.hfunc;
 
+	if (symmetric)
+		*symmetric = rss->hash.symmetric;
+
 	return 0;
 }
 
 int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
-		       const u8 *key, const u8 *hfunc,
+		       const u8 *key, const u8 *hfunc, const bool *symmetric,
 		       u32 *rqns, u32 *vhca_ids, unsigned int num_rqns)
 {
 	bool changed_indir = false;
@@ -608,6 +612,11 @@ int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
 		       rss->indir.actual_table_size * sizeof(*rss->indir.table));
 	}
 
+	if (symmetric) {
+		rss->hash.symmetric = *symmetric;
+		changed_hash = true;
+	}
+
 	if (changed_indir && rss->enabled) {
 		err = mlx5e_rss_apply(rss, rqns, vhca_ids, num_rqns);
 		if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index d0df98963c8d..9e4f50f194db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -44,9 +44,9 @@ void mlx5e_rss_disable(struct mlx5e_rss *rss);
 
 int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
 				     struct mlx5e_packet_merge_param *pkt_merge_param);
-int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc);
+int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc, bool *symmetric);
 int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
-		       const u8 *key, const u8 *hfunc,
+		       const u8 *key, const u8 *hfunc, const bool *symmetric,
 		       u32 *rqns, u32 *vhca_ids, unsigned int num_rqns);
 struct mlx5e_rss_params_hash mlx5e_rss_get_hash(struct mlx5e_rss *rss);
 u8 mlx5e_rss_get_hash_fields(struct mlx5e_rss *rss, enum mlx5_traffic_types tt);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index a86eade9a9e0..b64b814ee25c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -196,7 +196,7 @@ void mlx5e_rx_res_rss_set_indir_uniform(struct mlx5e_rx_res *res, unsigned int n
 }
 
 int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      u32 *indir, u8 *key, u8 *hfunc)
+			      u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
 {
 	struct mlx5e_rss *rss;
 
@@ -207,11 +207,12 @@ int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 	if (!rss)
 		return -ENOENT;
 
-	return mlx5e_rss_get_rxfh(rss, indir, key, hfunc);
+	return mlx5e_rss_get_rxfh(rss, indir, key, hfunc, symmetric);
 }
 
 int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      const u32 *indir, const u8 *key, const u8 *hfunc)
+			      const u32 *indir, const u8 *key, const u8 *hfunc,
+			      const bool *symmetric)
 {
 	u32 *vhca_ids = get_vhca_ids(res, 0);
 	struct mlx5e_rss *rss;
@@ -223,8 +224,8 @@ int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 	if (!rss)
 		return -ENOENT;
 
-	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, res->rss_rqns, vhca_ids,
-				  res->rss_nch);
+	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, symmetric,
+				  res->rss_rqns, vhca_ids, res->rss_nch);
 }
 
 int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 7b1a9f0f1874..c2f510a2282b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -44,9 +44,10 @@ void mlx5e_rx_res_xsk_update(struct mlx5e_rx_res *res, struct mlx5e_channels *ch
 /* Configuration API */
 void mlx5e_rx_res_rss_set_indir_uniform(struct mlx5e_rx_res *res, unsigned int nch);
 int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      u32 *indir, u8 *key, u8 *hfunc);
+			      u32 *indir, u8 *key, u8 *hfunc, bool *symmetric);
 int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      const u32 *indir, const u8 *key, const u8 *hfunc);
+			      const u32 *indir, const u8 *key, const u8 *hfunc,
+			      const bool *symmetric);
 
 int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
 				     enum mlx5_traffic_types tt);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
index 11f724ad90db..19499072f67f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
@@ -124,7 +124,7 @@ void mlx5e_tir_builder_build_rss(struct mlx5e_tir_builder *builder,
 		const size_t len = MLX5_FLD_SZ_BYTES(tirc, rx_hash_toeplitz_key);
 		void *rss_key = MLX5_ADDR_OF(tirc, tirc, rx_hash_toeplitz_key);
 
-		MLX5_SET(tirc, tirc, rx_hash_symmetric, 1);
+		MLX5_SET(tirc, tirc, rx_hash_symmetric, rss_hash->symmetric);
 		memcpy(rss_key, rss_hash->toeplitz_hash_key, len);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
index 857a84bcd53a..e8df3aaf6562 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
@@ -9,6 +9,7 @@
 struct mlx5e_rss_params_hash {
 	u8 hfunc;
 	u8 toeplitz_hash_key[40];
+	bool symmetric;
 };
 
 struct mlx5e_rss_params_traffic_type {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index cae39198b4db..2c88b65853f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1458,18 +1458,27 @@ static int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	u32 rss_context = rxfh->rss_context;
+	bool symmetric;
 	int err;
 
 	mutex_lock(&priv->state_lock);
 	err = mlx5e_rx_res_rss_get_rxfh(priv->rx_res, rss_context,
-					rxfh->indir, rxfh->key, &rxfh->hfunc);
+					rxfh->indir, rxfh->key, &rxfh->hfunc, &symmetric);
 	mutex_unlock(&priv->state_lock);
-	return err;
+
+	if (err)
+		return err;
+
+	if (symmetric)
+		rxfh->input_xfrm = RXH_XFRM_SYM_OR_XOR;
+
+	return 0;
 }
 
 static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh,
 			  struct netlink_ext_ack *extack)
 {
+	bool symmetric = rxfh->input_xfrm == RXH_XFRM_SYM_OR_XOR;
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	u32 *rss_context = &rxfh->rss_context;
 	u8 hfunc = rxfh->hfunc;
@@ -1504,7 +1513,8 @@ static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxf
 
 	err = mlx5e_rx_res_rss_set_rxfh(priv->rx_res, *rss_context,
 					rxfh->indir, rxfh->key,
-					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc);
+					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc,
+					rxfh->input_xfrm == RXH_XFRM_NO_CHANGE ? NULL : &symmetric);
 
 unlock:
 	mutex_unlock(&priv->state_lock);
@@ -2613,6 +2623,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_USE_CQE,
+	.supported_input_xfrm = RXH_XFRM_SYM_OR_XOR,
 	.get_drvinfo       = mlx5e_get_drvinfo,
 	.get_link          = ethtool_op_get_link,
 	.get_link_ext_state  = mlx5e_get_link_ext_state,
-- 
2.40.1


