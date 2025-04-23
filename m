Return-Path: <netdev+bounces-185155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57F3A98BEA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7700F5A123E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B01A9B23;
	Wed, 23 Apr 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A2U+HOYS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8574040
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416398; cv=fail; b=bGLiB4c4RvXIQKz8RyoAq2wn0Wlm7pxSv7qT9Tmv/seiFbfLEqSLk1GsC4zKBQELHSm90xxcqJGxx2GJWSxhIV5Fbg3oPMhIH7uCb2trONAQuS6fliICKXJJQXn0DZyIb16l3MAomU+rlpWi+s91odGGOBzL1lJHAsMwRMnus1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416398; c=relaxed/simple;
	bh=qIKbbtz0V7eWJ305JLWvvTElNEcbdcsDqdHFpXziyX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdICN2R7BrATKVMXC7p3ng2PZdLbAsrRoe+8pwzz24FM4CpPw7jj6FfJcFMLB7BAdzKg3KQu8SM9FIg7sQey92P5zHwAfEHBUDkDqnRwODbCxzXE+3OXnkXAYGT0DafnEuGkPdDLKqezpCHL/3QJFzUKIvpwhJsnQLjaTEYR7TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A2U+HOYS; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJ6gAoWSLmFMMw8NqG9Oh+TUlCOoff9djg/a/mG+oBRrIVsQ2SPk/0Wqo0x28ASrV5WMeIx5HSD9LUAuCOT14hQXYAe5DwNM3eV9FH6dPq6hx8aBJ/OsWq7khU3wUr6lVoncJAboM/NLmlmmpROqNDz89pQiMYgakFe66bzBq4ghf5SM8GTGTOS3U8Xtk1W2KrntSw8uT1cfqoiXrxq1i+Myh2X6Gk0J9uiI8ItupE8I0VR7jkJ3DZrE9nFT7U77oZ7mDzeOlF40krPOGujeczYbeokCUFgGp8LpqgNEsooj3XIrqt86pCR/MbRy9+09IifHayEC52XKVvb7fopDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmlszRfFS1o/rN7nKl9RuwWuhiKtBZICW2p3PO2TJ44=;
 b=PaVwRjyAjFQxDvlY/W/i8AOYiahlgAv8d+dZVTcPsxxCBIoNJr43khJM6HzVzn8CJJUyVziTqfIokIXu4KqvIbD44UlFF4b4Gt+ctDzKg57mjmJFNnsXN43ktOB3EejLrMjook3yoT/VV6zKgGTz/XVbWTNrZbxZzaMoLve0K24AaM4Qf040wvpW7JT04db5+ubPnv11FZEnMOPN2SrtIqXEkCUKnqll0P9FyI97iRvufOh2S6CryR0d186UZwgrytbr1YDNh8zutIY/et49uIGLTkbXWJlFE4eG0pjFhrPHsapqttcaxNvt+j5j/V0FfZQ7MJhGWa58YTU03Nw7rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmlszRfFS1o/rN7nKl9RuwWuhiKtBZICW2p3PO2TJ44=;
 b=A2U+HOYS0WX5mPw41VB61OGQh65YzcLMUVq4mPONd6WYauXDG1YNKR9ZtlUonwbIxLhQ86vuAR3Z2j3asrf6RDTHG9Ta0olwJoYOryE4LkjynokJWEIKZ9RyusNngUB0WZ7XvEcTGopCMos5Ctyd10JwMuWelvZViJJAyMXfzYZkCF03zB4OPJ4TXzti9kYQTIxJ1wOU/t7EaIyO1RPjiaLUj7xyWbGoZXW1doLNsd1iAbhL7dq5VR4XxH9mVRkBSOS9iXJkcjOgNfFVsOpg2YhRGC+ndXZUFzvhkPrBlZGDmYHXaKruTPvshAHugjbIxgdvRe7GoSZZoxKUWgnZcw==
Received: from DM6PR02CA0161.namprd02.prod.outlook.com (2603:10b6:5:332::28)
 by IA1PR12MB8588.namprd12.prod.outlook.com (2603:10b6:208:44f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 23 Apr
 2025 13:53:12 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::3a) by DM6PR02CA0161.outlook.office365.com
 (2603:10b6:5:332::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 13:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 13:53:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 06:52:57 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Apr
 2025 06:52:56 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 23
 Apr 2025 06:52:52 -0700
From: Moshe Shemesh <moshe@nvidia.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Avihai
 Horon <avihaih@nvidia.com>
Subject: [RFC net-next 2/5] net/mlx5: Move mlx5_cmd_query_vuid() from IB to core
Date: Wed, 23 Apr 2025 16:50:39 +0300
Message-ID: <1745416242-1162653-3-git-send-email-moshe@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|IA1PR12MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4de088-805e-4693-62f4-08dd826e2fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D6NWCPQnAVYjsEHR7WW5pg7Cipkejz0WC/hvDUub+xxpQIv01s0M6W2l0u77?=
 =?us-ascii?Q?XvgPWVK5Tv6wNVu3B9cGTA/p1d7n08PWjvmoi0yiaIdwvURpVoCoGvOQqRP6?=
 =?us-ascii?Q?Ukd4Arh6jTEIRxB+Em3NLahZUI4zJ4/FVBzdT380NXKeUd/E+dk0CruGWPNp?=
 =?us-ascii?Q?33fN9ujGlVcsL8dXgLIomG8pMx7NxskDVcEfKwN6lFaedP1CtiMPjSVJhFwA?=
 =?us-ascii?Q?bmaqE1dhc6i3A79wCPi/YsaKDd0dSSINSbdsJQAktbh/a6FTGowTucWsCQ+D?=
 =?us-ascii?Q?q8Liu6enNGfEQ4ka/4d4goKOWslfQuI+jly8YmvO7XNrRCmqCOujteVt10vx?=
 =?us-ascii?Q?zA3kZZHTlInHTBUKfyNAF4O/tdgIbQDy/TbDa/Y9obfUSxtL2kqd6Y4Sbh3G?=
 =?us-ascii?Q?cZU/SUrYpnRqEtBVDABnKJJpq9s/Issdsp6B9Xjhuq4I26Gl6YEqkVp1DXp6?=
 =?us-ascii?Q?CqD7mBuFkMZm4rHVgm0DWMvLgK2B7z8jsuZJVathEcpXQiFr2DcYyw6UyGK9?=
 =?us-ascii?Q?DOgq0LTLF2uyjfUsnFfqOk/rQ8u+hY4Hz1gClfh8JXAC/+wQIUtYBjYSNGoT?=
 =?us-ascii?Q?u6/3Hftsm6ndze9wz1hMW7WJJpdR9ZDkzw7ePCiCP7Cmt0kr8Jx9sNSQk5hr?=
 =?us-ascii?Q?Gcf2VnfU/8XPYvKh6i2a3taqQjOSCocdQCFkhRMORJqFnZ7fzX37nnn0XnRL?=
 =?us-ascii?Q?tKoCmmMhXlFjgE7cCqbTLZi7G6q7BXVKV27mYDzK8Yb+uQdosbI0QGsx8YGC?=
 =?us-ascii?Q?OQeuCqa60Lk/h2RM5DbkNvl3+0vNPDS2zGsgXK94utLXkeIwQl6DjeCq+Aev?=
 =?us-ascii?Q?JQV4SEiHTZjdg6jillUhW6aWig/bMhLBgfofJFoNFf2haVQdHQcP7yGjZqSC?=
 =?us-ascii?Q?83rU58YpYMeguGqrbh2aQYKtEJoeRxWMKCM+fqlChahGNS4pxn0JtL+X2Gpx?=
 =?us-ascii?Q?ki7e2Q2Th0TFyblw5T6f8Jr7vk7zuI6y8zz66SIH1L2rLfQTK48KArl3Tn1G?=
 =?us-ascii?Q?U60+2nyCtAvX/NaZ/rzDIAgPkVCNUg/E79qvN5eP+PCWuxqbvKT/wJCWvIKp?=
 =?us-ascii?Q?UgfoKy+jTeF2yGcojqFn7kwC2As0yr2aD88QeYHyl1tpaXwXDRA3nUBTwS/k?=
 =?us-ascii?Q?WEohf0sRRsGtaFhAq7eIhasVKyZp1pae0WhGB1uduFMZwZy+fD9wR8mkjluT?=
 =?us-ascii?Q?o/aLWpLkAnLhtFkdDpCG90SmquqowyN4xXjzgxgazFYjHzKHv1/R1vO13HUT?=
 =?us-ascii?Q?jJFEOnePH2C5fqWsaH9sXxuY54mxSbZZnl3GGX8/J7m7+vgWdN8JTNyA8HxB?=
 =?us-ascii?Q?8ivFqY1ba75rZzqsFxyA/vZcm/J7KzeYtHZ7WYMoGo5UPFtWSj1zpGeSXG9k?=
 =?us-ascii?Q?sJlf/y4U+TliN/LbrFvJpJ/iTmxqd28LVEoLbycXQDJVeoBho0RgV5gaSOGz?=
 =?us-ascii?Q?tipSQh0KCYYh/lEtqT+5I4bFndTm0ayjSvLv637883yZEvKPc2GyHP0JJYZd?=
 =?us-ascii?Q?/tVtCigr4H0rICR8JCl8tkfeZhtswC1LDCdBL+Lvij5L7kvaULloEy1CsQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:53:11.5311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4de088-805e-4693-62f4-08dd826e2fd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8588

From: Avihai Horon <avihaih@nvidia.com>

Querying of VUID will be needed in the following patches to get the
function unique identifier of a devlink port function.

Move the existing function mlx5_cmd_query_vuid() to fw.c so it can be
used in both core and IB. Rename it to mlx5_core_query_vuid().

No functional changes intended.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cmd.c             | 21 -------------------
 drivers/infiniband/hw/mlx5/cmd.h             |  2 --
 drivers/infiniband/hw/mlx5/main.c            |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c | 22 ++++++++++++++++++++
 include/linux/mlx5/driver.h                  |  2 ++
 5 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
index 7c08e3008927..895b62cc528d 100644
--- a/drivers/infiniband/hw/mlx5/cmd.c
+++ b/drivers/infiniband/hw/mlx5/cmd.c
@@ -245,24 +245,3 @@ int mlx5_cmd_uar_dealloc(struct mlx5_core_dev *dev, u32 uarn, u16 uid)
 	MLX5_SET(dealloc_uar_in, in, uid, uid);
 	return mlx5_cmd_exec_in(dev, dealloc_uar, in);
 }
-
-int mlx5_cmd_query_vuid(struct mlx5_core_dev *dev, bool data_direct,
-			char *out_vuid)
-{
-	u8 out[MLX5_ST_SZ_BYTES(query_vuid_out) +
-		MLX5_ST_SZ_BYTES(array1024_auto)] = {};
-	u8 in[MLX5_ST_SZ_BYTES(query_vuid_in)] = {};
-	char *vuid;
-	int err;
-
-	MLX5_SET(query_vuid_in, in, opcode, MLX5_CMD_OPCODE_QUERY_VUID);
-	MLX5_SET(query_vuid_in, in, vhca_id, MLX5_CAP_GEN(dev, vhca_id));
-	MLX5_SET(query_vuid_in, in, data_direct, data_direct);
-	err = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
-	if (err)
-		return err;
-
-	vuid = MLX5_ADDR_OF(query_vuid_out, out, vuid);
-	memcpy(out_vuid, vuid, MLX5_ST_SZ_BYTES(array1024_auto));
-	return 0;
-}
diff --git a/drivers/infiniband/hw/mlx5/cmd.h b/drivers/infiniband/hw/mlx5/cmd.h
index e6c88b6ebd0d..e5cd31270443 100644
--- a/drivers/infiniband/hw/mlx5/cmd.h
+++ b/drivers/infiniband/hw/mlx5/cmd.h
@@ -58,6 +58,4 @@ int mlx5_cmd_mad_ifc(struct mlx5_ib_dev *dev, const void *inb, void *outb,
 		     u16 opmod, u8 port);
 int mlx5_cmd_uar_alloc(struct mlx5_core_dev *dev, u32 *uarn, u16 uid);
 int mlx5_cmd_uar_dealloc(struct mlx5_core_dev *dev, u32 uarn, u16 uid);
-int mlx5_cmd_query_vuid(struct mlx5_core_dev *dev, bool data_direct,
-			char *out_vuid);
 #endif /* MLX5_IB_CMD_H */
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index d07cacaa0abd..d051c9d9a07d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3594,7 +3594,7 @@ static int mlx5_ib_data_direct_init(struct mlx5_ib_dev *dev)
 	    !MLX5_CAP_GEN_2(dev->mdev, query_vuid))
 		return 0;
 
-	ret = mlx5_cmd_query_vuid(dev->mdev, true, vuid);
+	ret = mlx5_core_query_vuid(dev->mdev, true, vuid);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 57476487e31f..beef8a279001 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -118,6 +118,28 @@ int mlx5_core_query_vendor_id(struct mlx5_core_dev *mdev, u32 *vendor_id)
 }
 EXPORT_SYMBOL(mlx5_core_query_vendor_id);
 
+int mlx5_core_query_vuid(struct mlx5_core_dev *dev, bool data_direct,
+			 char *out_vuid)
+{
+	u8 out[MLX5_ST_SZ_BYTES(query_vuid_out) +
+		MLX5_ST_SZ_BYTES(array1024_auto)] = {};
+	u8 in[MLX5_ST_SZ_BYTES(query_vuid_in)] = {};
+	char *vuid;
+	int err;
+
+	MLX5_SET(query_vuid_in, in, opcode, MLX5_CMD_OPCODE_QUERY_VUID);
+	MLX5_SET(query_vuid_in, in, vhca_id, MLX5_CAP_GEN(dev, vhca_id));
+	MLX5_SET(query_vuid_in, in, data_direct, data_direct);
+	err = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	if (err)
+		return err;
+
+	vuid = MLX5_ADDR_OF(query_vuid_out, out, vuid);
+	memcpy(out_vuid, vuid, MLX5_ST_SZ_BYTES(array1024_auto));
+	return 0;
+}
+EXPORT_SYMBOL(mlx5_core_query_vuid);
+
 static int mlx5_get_pcam_reg(struct mlx5_core_dev *dev)
 {
 	return mlx5_query_pcam_reg(dev, dev->caps.pcam,
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index d1dfbad9a447..424090e62917 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1127,6 +1127,8 @@ int mlx5_blocking_notifier_call_chain(struct mlx5_core_dev *dev, unsigned int ev
 				      void *data);
 
 int mlx5_core_query_vendor_id(struct mlx5_core_dev *mdev, u32 *vendor_id);
+int mlx5_core_query_vuid(struct mlx5_core_dev *dev, bool data_direct,
+			 char *out_vuid);
 
 int mlx5_cmd_create_vport_lag(struct mlx5_core_dev *dev);
 int mlx5_cmd_destroy_vport_lag(struct mlx5_core_dev *dev);
-- 
2.27.0


