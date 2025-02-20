Return-Path: <netdev+bounces-168116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D840A3D8E0
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA10177E67
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C44A1F4178;
	Thu, 20 Feb 2025 11:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eaGdU/qg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D231F150A;
	Thu, 20 Feb 2025 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051323; cv=fail; b=ggIrTA0hZX+WKcspCBblAKVZZ4k1W3pc7mwysHCgkOZpCyN1oFW+2rcnVw6Uk1h3cVK7ucp7sPw1Rdqx0B0z+sN3kImt5TG/tZdzAWKqzUkI4q4k6YpRmJbpk6fqlKH+QxUD3Egzyxv60ap4jxMs1enPsGxDPWALC5tEVKmrmPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051323; c=relaxed/simple;
	bh=QCFQ7q4G2O177g5dr2V1Xhgwv0hsd7LxmfIKmfPOAds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAGOCM1gDPGfuga9YAchAJB5Kf5NV07wTuEGbpkoFfZhezyE9yTizdAoUzfkjA3kSwe+LZWtsPUrJAa3C47UAiROSP+wpvvXwBu70E9S/hEmo3JMrkn4fCD1KbhZ9jIi6rxrUHerwivlocGCaGA3C0dp9ZOwXmRbiwsrFC+0Q4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eaGdU/qg; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXQrR2Or3yuQrJP7q4NqRpRws1Jf560MmL/knRiN9TpKumkYj5QW/QLR9lHjQWcytozxfTvSRQ+EfFCqRDfmBtdy4umnbwznPRfFSQUnlGc6DkXHbeNFu4hWFP/bX7S05HDXcu/BPuGenmJKJUY2YIByMj2ebUlHagFduQ8jBLEE651QYUCqvs7UiG/ytOddhyTRcgWu0ALePauQIlYGUtC+devYfmpMgsy1lBwPqcGUG2FkEyNZiaxIN5zGuazIwBDxcJFrlse0rZVhh6f0iuKHkSK7hu7BNJIejgueRSqiy75jmm1xU1Votv4kGEnAagz0p1EpE+IMnVsGfuwq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qx5dco9QkZibDDsE3q+7FXfwBxonytieuoQqubrMwS4=;
 b=DqtndKzUogdbS7gM+Td4+87hUcY/v8f6JTdc+7NeuLYWLSjUuRdb9OK73s9UGc/4w5c6U6/zoCSmvsrX7zsCMwexvkA8h3y0ZNUNtV34gKXIWp18SzvAFZrPCGrBbA1j0fTorGBwt1udznO9IByPzEbfOZiNtv9aTdF5sgrmf/1acAtRd/rBKbOByr3gbxLOP6EheE5sVivHMBakewLd+l2iftCQ26gYi88VCQS645JxpYWFmaygd8M0fiRkEv2yU9LIfF5qd8j/3hHToKurwRJzGDBYRl//ZIGdc//+HaQT5gI9zAeZf+HIkmkGPUYnBrLx6QXaLVdoXK6Dl82mxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qx5dco9QkZibDDsE3q+7FXfwBxonytieuoQqubrMwS4=;
 b=eaGdU/qgwxKz1n4EqychbOjD7AGXirbbqzoLXqgscM/ym+xGUnIt0J7o+2jjaLM3aDYECVEgdYjHIprPr1dA5fJc6xVKJV6kWqox6uYkxwMg3ZcO+lDZTeOsK8elP9vAtWntky5HZ1g1CXNYYH71C2zVQltEZsW0WeajquNC7u7zOXZTKZ0n7tnYT2vLDVBhupmLT9fA3oOufkKuOJjG5QOz06POrZjihmEn8dOI1sw179qqtK6sb3Ouvl3Jz2Wma9VsQNX39Hpnphqz7yuUvho5H8GRnzxLDo6chrTGJ1l01k/lop2I2BpsXM8k8dY6NcOfeLriIj4p2uU7D/MVKQ==
Received: from BL1PR13CA0163.namprd13.prod.outlook.com (2603:10b6:208:2bd::18)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 11:35:15 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:2bd:cafe::9e) by BL1PR13CA0163.outlook.office365.com
 (2603:10b6:208:2bd::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 11:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.2 via Frontend Transport; Thu, 20 Feb 2025 11:35:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 03:34:57 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 03:34:57 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 20
 Feb 2025 03:34:53 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v4 2/5] net/mlx5e: Symmetric OR-XOR RSS hash control
Date: Thu, 20 Feb 2025 13:34:32 +0200
Message-ID: <20250220113435.417487-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250220113435.417487-1-gal@nvidia.com>
References: <20250220113435.417487-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f98acb1-96f7-421c-bdd1-08dd51a2a4e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R/prbDjh6hat4EuHbhfVfptDYhBgN1mnnG17AxDAQbBjT/Tw1ZiK/bDpWzeo?=
 =?us-ascii?Q?RSe/saj6HDM5Ts83O+1K7bYtHOFxVkinCBqCz23luUrUqJOLIAwY9YsofiS3?=
 =?us-ascii?Q?sq+ZsuTaHoO+7trdv6WDF6jC9lUBLVi7mOGcufwEqBCNMk0E3+lxb4KnOYti?=
 =?us-ascii?Q?Se+Zq58cLqXB0gU3JyIDJi0U047OCRdWKAT0Fxdcvj57C7BD21m85vnkn38H?=
 =?us-ascii?Q?lE7kdxpNWukm9LN0oFulNtyIBYWegWIsniDbXuV923kfmDbFxJ/mHFkMxSy0?=
 =?us-ascii?Q?ZQqtn9yY9zKn9J4sXFDUjRGBEVmX+nZULt0L93bo6TG+wyNnE1X4VGkqYf9G?=
 =?us-ascii?Q?aJDDhGvm4niEmE41Sqm6nDDXG4U80qP+bWziQA8vrIJIoedx9kHlwqtTthut?=
 =?us-ascii?Q?cbYwszsIQbrY4j9LaJmB9R6/RRTJvKwGbtGp/Gqk3hK+9u/4PnrwkTVOAYLN?=
 =?us-ascii?Q?J473+20UI2ISx1iX+ORy5i9bHYm0ve/y0zlibsjpPfnUfocbtFNILs3CYKCq?=
 =?us-ascii?Q?lgQhZwvp+/iJxPCd0ugvprQHYKDPWOp+ZxjwQ3AhVQeZY49ymJiKtMEdkEj2?=
 =?us-ascii?Q?pYd8TIvgFYGE9+A3Gva4D1TZxZEYszBMxD5dFzcRXeW6joa8gPdewCXe2M5D?=
 =?us-ascii?Q?pBnt4yk+OGbaSX8tqXwIiIR7+JU+u6Qn3O1wggnu8wwWIzKeq2A9aDw0mCjB?=
 =?us-ascii?Q?fgrpr5smkZcOAt5bZyoIj+ljiEn7u0nfLpE5gL4FbI//fkdiAtoHlTSpcpnQ?=
 =?us-ascii?Q?P2ac0KEvWMLKxKFHAxD0GxDlrNpMFaPZM4mJeFuqa3xb6n8WmGdSsvXlVtI9?=
 =?us-ascii?Q?gDezFY3YLpU/o4qdTGCyy8wWsE6oTnTMln/InuxG4m2r2lkvfzz16b7JgguS?=
 =?us-ascii?Q?JyFONyNoS+q2T2PkrX2hZkDbQs4RZb39iwzb5R1gxXd+r1D6oh1Fj84Xd59F?=
 =?us-ascii?Q?iA8pEe8psTPatX0xPHO9PX856BX+gROzqLVkERS05B8NussEgDmCbXtvHXoU?=
 =?us-ascii?Q?iqAYbTqKNqT3kPvn5i5TlwZAHQ2Kh2HsKkeY9ozOUgtwZKoi8HN44lRHV12o?=
 =?us-ascii?Q?tL/zWOZFkdU+XSfnA1IMewmMQIUEjnead7xv+8XqgZerlQhtwKR4IX+Oots/?=
 =?us-ascii?Q?25nw+8dOLRiUp53uvkjyro1GVsNDTsVvnGY+dEjLhIyDZmSlIg1aAoV0Owfi?=
 =?us-ascii?Q?j4E5qMss6BWJEmp+6243Hdz+60/47KVVZPG+8RVd+LYROKH7L8WnUTZceP53?=
 =?us-ascii?Q?pE3acsJirFJ5WGy2L5UNYo5V+KOG6VVfdyyPxOVtlepFjSWlaG78IG3YB/PM?=
 =?us-ascii?Q?gg0eZET2YZxVVIEPHEcm3PFh8RrTvzdt1qPE0P/PYmKlGwLwdaAkHcueCFcC?=
 =?us-ascii?Q?qFOJsF/yudtEFS414xNnofVX6uiiCB+sNeECTqy/4kjLjea92vIdJg8NZehx?=
 =?us-ascii?Q?v+fojM7SKYrEZrtpIEbx28KwzwiYpN/cY5LIUrUOf65xNnGkhJnIse/KLjap?=
 =?us-ascii?Q?juf4yIxzjoCmqKE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:35:14.7518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f98acb1-96f7-421c-bdd1-08dd51a2a4e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046

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
index 0d8ccc7b6c11..74cd111ee320 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -161,6 +161,7 @@ static void mlx5e_rss_params_init(struct mlx5e_rss *rss)
 {
 	enum mlx5_traffic_types tt;
 
+	rss->hash.symmetric = true;
 	rss->hash.hfunc = ETH_RSS_HASH_TOP;
 	netdev_rss_key_fill(rss->hash.toeplitz_hash_key,
 			    sizeof(rss->hash.toeplitz_hash_key));
@@ -566,7 +567,7 @@ int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
 	return final_err;
 }
 
-int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc)
+int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
 {
 	if (indir)
 		memcpy(indir, rss->indir.table,
@@ -579,11 +580,14 @@ int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc)
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
@@ -623,6 +627,11 @@ int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
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
index 72089f5f473c..8ac902190010 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -47,9 +47,9 @@ void mlx5e_rss_disable(struct mlx5e_rss *rss);
 
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
index 9d8b2f5f6c96..5fcbe47337b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -194,7 +194,7 @@ void mlx5e_rx_res_rss_set_indir_uniform(struct mlx5e_rx_res *res, unsigned int n
 }
 
 int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      u32 *indir, u8 *key, u8 *hfunc)
+			      u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
 {
 	struct mlx5e_rss *rss;
 
@@ -205,11 +205,12 @@ int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
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
@@ -221,8 +222,8 @@ int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 	if (!rss)
 		return -ENOENT;
 
-	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, res->rss_rqns, vhca_ids,
-				  res->rss_nch);
+	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, symmetric,
+				  res->rss_rqns, vhca_ids, res->rss_nch);
 }
 
 int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 05b438043bcb..3e09d91281af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -49,9 +49,10 @@ void mlx5e_rx_res_xsk_update(struct mlx5e_rx_res *res, struct mlx5e_channels *ch
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
index f9113cb13a0c..75faf15fdd64 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1480,18 +1480,27 @@ static int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *
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
@@ -1526,7 +1535,8 @@ static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxf
 
 	err = mlx5e_rx_res_rss_set_rxfh(priv->rx_res, *rss_context,
 					rxfh->indir, rxfh->key,
-					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc);
+					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc,
+					rxfh->input_xfrm == RXH_XFRM_NO_CHANGE ? NULL : &symmetric);
 
 unlock:
 	mutex_unlock(&priv->state_lock);
@@ -2635,6 +2645,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_USE_CQE,
+	.supported_input_xfrm = RXH_XFRM_SYM_OR_XOR,
 	.get_drvinfo       = mlx5e_get_drvinfo,
 	.get_link          = ethtool_op_get_link,
 	.get_link_ext_state  = mlx5e_get_link_ext_state,
-- 
2.40.1


