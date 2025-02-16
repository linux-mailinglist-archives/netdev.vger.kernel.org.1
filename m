Return-Path: <netdev+bounces-166820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59945A3768B
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 19:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE23E188EF63
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 18:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9124D19F135;
	Sun, 16 Feb 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p1XdH1Pj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7D19D886;
	Sun, 16 Feb 2025 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739730338; cv=fail; b=j5gZdY0Jr9owmyWRGbaITqwV83iSYBjWxue2AANTo9Dua62jpxECoq36PBFhmOGIUHOrMW9B/fFGUUA7I2yxVSYIjkQwwVp8P5xa2dLrcnl67RTvSN21xdA9h+e7mt04aF+oyZpxJglyZkfXNeeAKWJU9ql6P2zLkQU5/0ptJF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739730338; c=relaxed/simple;
	bh=fM/Ynk+nja5vyIfipDE5uP6dPQuISD1Oh14diRA2qbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d4tPceEVGlqOhLfeqREriRAd7a1XFmpuj7ZaAouNntDsii43Bd3wdN7WtXzwusD2VvPtL/Y9K8WiYSEE5erM+o/3gd039BHFBynAoHb6AHJavmdt+vKfC9jfD+fQvibA5eirPc+u+QKNRwc+yJ3anHRgPi08JFF4KPvJkd4e428=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p1XdH1Pj; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwxYp0DnnTqHqdyMb7htfxYoNo0UxX6RwylcOhKNLTxxWw6Sd5ie8tQCcVaGh/zN/V+hLbl3/oEbsMIlOVXa3SoSoBXipJlRYV58wHa6Rr8ueZ3OBaJIOeVG75NvPA3dEMKEviOXGQnHIlnVAyIoxc1lnBFPIzWS2848UaiZJmr9N/mZ+K8lE79G++VmiYO9OvTewHoT2ChRFThgZ45tNyjTedf/ojlRzQRXNskdrYdduQ4Ss4o1Kqbocxo2R2Xb8vXs/WEiZnRw5sj8EBB1seZYvKNFuKZq9QLN75CBLk4jD5j3x1K1VYv+CFC+H5gTa+9qrQYiPZNchy+KANR19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca58S5zLvWbM81+SBYQ3l91t4WubQWIJWGfAy4cAPv0=;
 b=IloAn9VQ4snxP5jfuV4zcEqZlSCB/Z80wxkc1fwOe9COS+tHbJ0VCZHSYSqMjXUAFHeXOWHqrPtVbYmfph5C6jXoC9B5W/pTTmMI51q6NYzxmsLyOBXatupPEbcK6WsQLU6eTDukPdDUe790U9dsNFFRVKXUJHL8WimcEwZYlRqm5WHNKHKiTlE2o2pSpCdBJBlrnk1KQG6Z5UO/Zb5cP4DsTHFmYy0dhYvlTKFyVXnt60ZpJBvrEi2Linhbr+0Un0fPVOO8GD1KAPWr79vguGKsa0xyfu3i48RRq2+qyMJhaCH9Jw1DIfrDnbr2rn5jaajSxEJHTgTPpllKCrdXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca58S5zLvWbM81+SBYQ3l91t4WubQWIJWGfAy4cAPv0=;
 b=p1XdH1Pjmyz2yaWB7TysdXygkb0rVQag+ZaORQMDtRbdji1x0rFZVfWQVI+6nw7xJrsSxKlHcJBWKedaGECZpZYtWTJ5wAYuiYLFWjl5Vohv+DFqk1POHuVXLj8zVe0jKdICRNVO7nwLjMa/gEAZe1a551dX7SOBy+WWbZqJepVtWAVEKvIo5hjy1qc7VXxXHZr43LdhsSSrJ4QlSmZaKzMXMstetQemvxM97srjea2ydk1UJf5m6G63EYP9x/X7kwAkbI535Fe5kitWoNZdpNOCiOzTmWMxm+flDfirVajPeJIFeUb8mqrqMkMaIkgHXxhUh5GN96C5qYDMy7JrLA==
Received: from BN9PR03CA0977.namprd03.prod.outlook.com (2603:10b6:408:109::22)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Sun, 16 Feb
 2025 18:25:28 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::a7) by BN9PR03CA0977.outlook.office365.com
 (2603:10b6:408:109::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Sun,
 16 Feb 2025 18:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 18:25:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Feb
 2025 10:25:11 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 16 Feb
 2025 10:25:11 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 16
 Feb 2025 10:25:07 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v3 2/5] net/mlx5e: Symmetric OR-XOR RSS hash control
Date: Sun, 16 Feb 2025 20:24:50 +0200
Message-ID: <20250216182453.226325-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250216182453.226325-1-gal@nvidia.com>
References: <20250216182453.226325-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|CY8PR12MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 153b2b6e-92a4-42ac-075c-08dd4eb749a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ShW7EhtCiMYBv2PGaNqmeIAdFMlMXLEp6XqSIPdHC37R1ouS2zPlMxEwpJW3?=
 =?us-ascii?Q?HLTE+EZl0if1iCAeoi59PnN+KEwypzQfrTJ0eToMFEiJxrt9zJY7yZNkejpK?=
 =?us-ascii?Q?23/d2f6yPORDB0aWuKYcDbri/AEjMwzDwlULzpIK+f4SNE3YFb/QhGFwfkv2?=
 =?us-ascii?Q?H+kY4LwMCdAbsiqUjTX7tcJqk3toZqgkfUU1B0RutMrKKl8Gv7wTNtQiBqTn?=
 =?us-ascii?Q?1i9uCnf4uOgFkZHfKeJ/CrgHdxfjm3702HqLGr5gaOJI+Zqqrl1XcthNPlH2?=
 =?us-ascii?Q?IAZiHT8kzmSJne3Ull8WNaJnM0ZcEDBBvYlxEqPsf6g/4N295RStuFFZY2rM?=
 =?us-ascii?Q?HuyrOEGIl5DAV1pSM7iSzU9F1jiu0xg+/5gmb5bxXqyxy+D4PBqljkmOKLoa?=
 =?us-ascii?Q?xGyJtzrAG0nDR7oTeq7RAVdDxCpQVAajQSWzdm5/SVigkzCXDbY1tlIMRmjC?=
 =?us-ascii?Q?V6Io5DvkpM/BciV4QoQB2QmlHqro5KlJ5T3xQCI3qfaohLXew3PN6dJBJsDp?=
 =?us-ascii?Q?fk6RHV0blaRC/7AvR+Li+fKMPXVifTlbr15x8kolLIKame3M3ogE28rOzE1B?=
 =?us-ascii?Q?ZHv06gY4/cSDPj+eZ08jfcW47MUChOIpZ18kyfAi4PxvBLoV010w0YgX0z0K?=
 =?us-ascii?Q?VQbRmQVS2L/TigWqp/Ns3uFkW0kLeWpb//Hc28Xo3r/Mj2Y8BSpHoyBEVTZP?=
 =?us-ascii?Q?bts0V6RliAmZS70SfIFUp4c09LhjoekXIOyYI1QGG60GyYwPqpS7lw1rBcpg?=
 =?us-ascii?Q?sdbwPTL6kBKjVM5X2PMYWnQx+B6jCQ34gZu8jz98mUKVzqIvbyMc6c5romyU?=
 =?us-ascii?Q?ylKgWSJbEeubxyklXJveSZZcT9bWNk2gWTXDw+tmlDBj7eEoQDCmDy+0LM0U?=
 =?us-ascii?Q?EzeEjZjmThIsiIiuFNldKYnZWc4xoTQxq0bxtw/AgMKNinEqKs9k9PI1P0se?=
 =?us-ascii?Q?E40c3vkl/Z2DMrmbPqBcsx3BfCf6QxDXNVYaM070WbUtjO5U9nnjdj1c5X1X?=
 =?us-ascii?Q?TPSHRhWDV6f1VdlF6/1m6wyWjSxGU1GMNY6+cj9shToy8BERaDcCmdDMMH2+?=
 =?us-ascii?Q?ICy4kC6Av1+bfADcJy+IRZ6gbJZPKDK/Mxfyo+7J2EbyPpZO5V3nAS7yxzB4?=
 =?us-ascii?Q?gwH+fjoLtli2+GFvDC8qASrIw16+zwinGR9A4ydLqxipiNR8RQQBQdAIHP6z?=
 =?us-ascii?Q?gIBh9bSA6Rj1cb/cq/uawi5+ViBj/wMMug+3qdmx6l0vmikRTUujltLDnEDL?=
 =?us-ascii?Q?6K8bWLdnw7wBUUrSwvp2BqwERMtJHlUWy4AIB/YZFQPIw/v8uE7Ff4l4FSwD?=
 =?us-ascii?Q?HwX/spOTn9XnYkzzkhD+G9J1/uNctnDTZM11KixboyAu5OH0a5ysPtpPMy3A?=
 =?us-ascii?Q?1O6LfIXXfMcqKkeBhPqcMW+F4LHpJ+f1PPVu8yUTWD/AGvtnRN5YI4WdlZM8?=
 =?us-ascii?Q?ohP9XqXBJ5y6WcmrRv04hvZb6jUO7JYzHU68MNMP9Z4cRbjaS0HK2dK13dob?=
 =?us-ascii?Q?cji8RVxO/uksIOE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 18:25:27.6137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 153b2b6e-92a4-42ac-075c-08dd4eb749a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266

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


