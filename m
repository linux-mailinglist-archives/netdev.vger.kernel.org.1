Return-Path: <netdev+bounces-145084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FD9C9513
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160E7282AD1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D21B1B218C;
	Thu, 14 Nov 2024 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sf6+3iL1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250391B1D61
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622271; cv=fail; b=ej9W9VTAazmakKZWBmYp57zypRwwoj6U9Aagh4dDYbRUQPwVoO1JAcHymw4dQa+MmpcFlGUN38YNeGFs11I0i3cv1NhIE7uNXOf7lMXf2zVixZXt9lsCeaU1F3NWGvx5HQP/gppnDrgij6ovX2n7kkFMJeHHaVGQxcPdt50aMOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622271; c=relaxed/simple;
	bh=WCmh7jsOM+mQt6qP6dj7FxYrz4iZLoBZvOjWJVrHwv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jA0Vfkd+mGMlyeln2NdcoywCWrMlX3pQNWk8aoJA9wc5nympHtxEMutbJ4pGjU7pL1usADEotFbTRZCIX0bIs91+gPeBWgky0epk79hF+cdrTZh2OTvWe7oVNnbma7F+YMhNrGDGtYP8SX0jrslvmP/muCgcWMndwUxx/aKx6QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sf6+3iL1; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPmCHTffeWtV0FZ4McOm0waJmDn8Tu8J/eKzlDbvAUS3yH+QzMXSpQOaxeuO5JTBlot0E56KoAJiWJraWC5LYDJJQRkZlScBtqX1jDNxeEnhnsItLNF4lucHrdY0xrjzWPUmB/9i+X586MB8LFJrQpYBJElzMvyEXpj5aVWBblA02Vqjo6pHdUdZkrYXNyU/UOzC5tfBmkmqLTdItPcYAb/s2e5o+/WX10nvy1am84Sb3URYwXj6I9QDFzrsHMUtZ6VN/mQFxuEAsSoCQTeCRKaNI9DhKXTMbYOwJOb/shCZHP01FHlFq07TtlwdEeIars59XD+btbTLJ2kvK/VOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2gKxXNRLXSAgrGnb3wcY2SicGGLh7jrY2WwcYMFBzA=;
 b=rmT3O+naMmGU/IyUoiqV0RwMNSy9Pj0PZC4wHfJRZaLPnzxU2CABxHuxmW429O1nR1mk3nAgGfE3GpH0TCo7UHx/XJg6a+po84kxNdf9Lg9+Q8NYu/6L7zAH23v5bLz8v1wqqRRSALycNtCTHbe2LGNeJUBcq4XAFmMD9DswULTaHbTGhdqS2zOZwaNyfa2AUpMblXuNgKoCrhLr2xmb+EUQA2qpm1nLVqd4pm5jgoXCo9UOGox1jrgaB2bd5Be4TTbr2kW0kPLtXrNfIJReBIxKuRvwDtumB+2l7nD0ow4peevvfo54U2FDsutLOcgfRTP4yAWR9SIFRt+0Ow7qig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2gKxXNRLXSAgrGnb3wcY2SicGGLh7jrY2WwcYMFBzA=;
 b=Sf6+3iL1Uu+sqQzkU6OzUUO6iafmt6prT4xF7vdId4zyntYaZlbQXuTRzOIlR/wYVsPl6HUkufXeDj3euTTTvUG1kmMTiGL8wOHoLqmKU/3iUgYajOw0Drs6Bdy7NzlZA0sbPOVoOz+B/bTBoqWFYsAlmaUyzdNqgwGGd5hSrhu21Jwe+cPdqGsf0YFMjqs+9IC+bv3EapigXlSdvtZ122PuUeZesHnErQ2s4Ov2xK8/zIPayRV6hIH/OUXFKWIQPJ1qQykIbQAqw6afUlk55hn0ni02Sr9qmiaPdOPZCdR5E45A26250PHH8KhEmRb2j/uhAg4fRpWBOzOCIaBdEw==
Received: from PH8PR22CA0005.namprd22.prod.outlook.com (2603:10b6:510:2d1::18)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:10:59 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::1c) by PH8PR22CA0005.outlook.office365.com
 (2603:10b6:510:2d1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 22:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 22:10:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 14:10:40 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 14:10:40 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 14 Nov
 2024 14:10:37 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Itamar Gozlan <igozlan@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 2/8] net/mlx5: DR, add support for ConnectX-8 steering
Date: Fri, 15 Nov 2024 00:09:31 +0200
Message-ID: <20241114220937.719507-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114220937.719507-1-tariqt@nvidia.com>
References: <20241114220937.719507-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ba76eb-cd6f-481b-35ab-08dd04f937ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?emR8pECsJGwH1zO05Mx+bIANkp9kMWb3EEB8+Hbr7M5Sk1VETNSDzEU3XvQv?=
 =?us-ascii?Q?tIeHSvbg5V9HflcR+5wDPn66f7apExcLsaOCpW7PsDE+ivsb8wJB97irfuNQ?=
 =?us-ascii?Q?AF++2CzzLhBWarUzgkJsDTyOxn0fbYZF0BDq/K1EexhHoz0NOornR/HXxcRu?=
 =?us-ascii?Q?aLCoMoPqntNxKQiZsawYPiv94oART1ZoAyVJsHSVk285DoycI1k5CiPElpfp?=
 =?us-ascii?Q?9BXM99RLj2Xh7LxUbYDjc5DzJ2caqx+v+e/Qh2m3p+atkXVYloqRqzettDeL?=
 =?us-ascii?Q?MBXPW3r/VGjl/QFLBrjV76WVMfr+Q3cLRYa9lycNIBJmAjkB/RQrkzjx/rc0?=
 =?us-ascii?Q?AM5a6HN7hi9eFNMymeQSot0UUwAX0Zwfim7Np7gnUjRoy7803jnM/FkpxKHh?=
 =?us-ascii?Q?Vbfq+lQIJEWU2MQca8r/Wbg0bghDGn4GoSDsR7NCgd8Bx700hI3OVZh0r74n?=
 =?us-ascii?Q?cCzW4PsQdmAgGl+5q8so4JNqF0oBP8Uf0Owutd7/45Q+GHax2lAuUAD70Zt3?=
 =?us-ascii?Q?ARS6WqXnNYT6CJpsFHXGMaegIDqKfnoCBVOoEDpt+76JB7dPWT32UaLxJ9pw?=
 =?us-ascii?Q?x2xWnXm02Xv1eWr6yb9wbEp57xjpLgQM9K64YJj6kwVQuapktME49H1F7dLN?=
 =?us-ascii?Q?IDpOZpwcUenArwRxMSufXxrQiQfD17FvyRi2Q4tVM0zSymVrPVk+O+pyi/L3?=
 =?us-ascii?Q?gHeNiDVW+zCtIVIWJXiAKQHa+oZTGLfR/1N/nsxtB9rCXvpc8YU3y+pt51oo?=
 =?us-ascii?Q?IstXgrHhtqJzu7bXc59MVjjn4ST5IHzopcDa1k/o+21DKQJf7XSZv/aaXAtg?=
 =?us-ascii?Q?IzDDD/Np3qviJu1N2llIN8VYlMQXllNyh050vDXZ+IVfQBEISzoI03HsijDj?=
 =?us-ascii?Q?JnEl6lVeBFN+qicL9Csc5gk9wYxGgF8cScanx0mHAKbMrwWyNN8haWxBsZf5?=
 =?us-ascii?Q?I6XO0i9hwMuv0FtanXHULFIh3yiQbwVoLutoItTk7aw7fIC4S2KwuWCU7kxZ?=
 =?us-ascii?Q?98xaMke/vRGDxoFEonMQA4atcBAKpubevX7B2GEaoIzi01OLa032lSpYbGtH?=
 =?us-ascii?Q?yoWsomY6HPp27TNSIR1gutnpM4E07DO7Tr/s71F/De+ucjkrW8xxZ+7yM7sl?=
 =?us-ascii?Q?Op8iEo25PttJS3WPqqjWTKF6AwVAHgCxdS4VkuRTWQaaAmqf4TiZUoAZrMzg?=
 =?us-ascii?Q?Z0MfzEKEtmodxWWWJtSO+6eznOUP2SsSAIXrK2qAV18fJUo8tNd3++n0/NbT?=
 =?us-ascii?Q?YFOWDzrkn1J3KlgItuz0ee/hg/DOMRQbeEeaXO0izLqCSZ4A1OOfpsD8I4Ds?=
 =?us-ascii?Q?Ok7K/3dOlkea3qSVerYld0IjSg12nRBoF0u6bj0BntqnPqz/otw6/hVFUeM4?=
 =?us-ascii?Q?jszCoBpHd+L/V9C30aMPbqOEjC4WETKafoltWl+4PIi6ZLhZQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:10:58.3007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ba76eb-cd6f-481b-35ab-08dd04f937ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157

From: Itamar Gozlan <igozlan@nvidia.com>

Add support for a new steering format version that is implemented by
ConnectX-8.
Except for several differences, the STEv3 is identical to STEv2, so
for most callbacks STEv3 context struct will call STEv2 functions.

Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   1 +
 .../mlx5/core/steering/sws/dr_domain.c        |   2 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.c  |   2 +
 .../mellanox/mlx5/core/steering/sws/dr_ste.h  |   1 +
 .../mlx5/core/steering/sws/dr_ste_v3.c        | 221 ++++++++++++++++++
 .../mlx5/core/steering/sws/mlx5_ifc_dr.h      |  40 ++++
 .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |   2 +-
 include/linux/mlx5/mlx5_ifc.h                 |   1 +
 8 files changed, 268 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index be3d0876c521..f9db8b8374fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -123,6 +123,7 @@ mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/sws/dr_domain.o \
 					steering/sws/dr_ste_v0.o \
 					steering/sws/dr_ste_v1.o \
 					steering/sws/dr_ste_v2.o \
+					steering/sws/dr_ste_v3.o \
 					steering/sws/dr_cmd.o \
 					steering/sws/dr_fw.o \
 					steering/sws/dr_action.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
index 3d74109f8230..bd361ba6658c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
@@ -8,7 +8,7 @@
 #define DR_DOMAIN_SW_STEERING_SUPPORTED(dmn, dmn_type)	\
 	((dmn)->info.caps.dmn_type##_sw_owner ||	\
 	 ((dmn)->info.caps.dmn_type##_sw_owner_v2 &&	\
-	  (dmn)->info.caps.sw_format_ver <= MLX5_STEERING_FORMAT_CONNECTX_7))
+	  (dmn)->info.caps.sw_format_ver <= MLX5_STEERING_FORMAT_CONNECTX_8))
 
 bool mlx5dr_domain_is_support_ptrn_arg(struct mlx5dr_domain *dmn)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
index 01ba8eae2983..c8b8ff80c7c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
@@ -1458,6 +1458,8 @@ struct mlx5dr_ste_ctx *mlx5dr_ste_get_ctx(u8 version)
 		return mlx5dr_ste_get_ctx_v1();
 	else if (version == MLX5_STEERING_FORMAT_CONNECTX_7)
 		return mlx5dr_ste_get_ctx_v2();
+	else if (version == MLX5_STEERING_FORMAT_CONNECTX_8)
+		return mlx5dr_ste_get_ctx_v3();
 
 	return NULL;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
index b6ec8d30d990..5f409dc30aca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
@@ -217,5 +217,6 @@ struct mlx5dr_ste_ctx {
 struct mlx5dr_ste_ctx *mlx5dr_ste_get_ctx_v0(void);
 struct mlx5dr_ste_ctx *mlx5dr_ste_get_ctx_v1(void);
 struct mlx5dr_ste_ctx *mlx5dr_ste_get_ctx_v2(void);
+struct mlx5dr_ste_ctx *mlx5dr_ste_get_ctx_v3(void);
 
 #endif  /* _DR_STE_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c
new file mode 100644
index 000000000000..cc60ce1d274e
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include "dr_ste_v1.h"
+#include "dr_ste_v2.h"
+
+static void dr_ste_v3_set_encap(u8 *hw_ste_p, u8 *d_action,
+				u32 reformat_id, int size)
+{
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action, action_id,
+		 DR_STE_V1_ACTION_ID_INSERT_POINTER);
+	/* The hardware expects here size in words (2 byte) */
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action, size, size / 2);
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action, pointer, reformat_id);
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action, attributes,
+		 DR_STE_V1_ACTION_INSERT_PTR_ATTR_ENCAP);
+	dr_ste_v1_set_reparse(hw_ste_p);
+}
+
+static void dr_ste_v3_set_push_vlan(u8 *ste, u8 *d_action,
+				    u32 vlan_hdr)
+{
+	MLX5_SET(ste_double_action_insert_with_inline_v3, d_action, action_id,
+		 DR_STE_V1_ACTION_ID_INSERT_INLINE);
+	/* The hardware expects here offset to vlan header in words (2 byte) */
+	MLX5_SET(ste_double_action_insert_with_inline_v3, d_action, start_offset,
+		 HDR_LEN_L2_MACS >> 1);
+	MLX5_SET(ste_double_action_insert_with_inline_v3, d_action, inline_data, vlan_hdr);
+	dr_ste_v1_set_reparse(ste);
+}
+
+static void dr_ste_v3_set_pop_vlan(u8 *hw_ste_p, u8 *s_action,
+				   u8 vlans_num)
+{
+	MLX5_SET(ste_single_action_remove_header_size_v3, s_action,
+		 action_id, DR_STE_V1_ACTION_ID_REMOVE_BY_SIZE);
+	MLX5_SET(ste_single_action_remove_header_size_v3, s_action,
+		 start_anchor, DR_STE_HEADER_ANCHOR_1ST_VLAN);
+	/* The hardware expects here size in words (2 byte) */
+	MLX5_SET(ste_single_action_remove_header_size_v3, s_action,
+		 remove_size, (HDR_LEN_L2_VLAN >> 1) * vlans_num);
+
+	dr_ste_v1_set_reparse(hw_ste_p);
+}
+
+static void dr_ste_v3_set_encap_l3(u8 *hw_ste_p,
+				   u8 *frst_s_action,
+				   u8 *scnd_d_action,
+				   u32 reformat_id,
+				   int size)
+{
+	/* Remove L2 headers */
+	MLX5_SET(ste_single_action_remove_header_v3, frst_s_action, action_id,
+		 DR_STE_V1_ACTION_ID_REMOVE_HEADER_TO_HEADER);
+	MLX5_SET(ste_single_action_remove_header_v3, frst_s_action, end_anchor,
+		 DR_STE_HEADER_ANCHOR_IPV6_IPV4);
+
+	/* Encapsulate with given reformat ID */
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, scnd_d_action, action_id,
+		 DR_STE_V1_ACTION_ID_INSERT_POINTER);
+	/* The hardware expects here size in words (2 byte) */
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, scnd_d_action, size, size / 2);
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, scnd_d_action, pointer, reformat_id);
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, scnd_d_action, attributes,
+		 DR_STE_V1_ACTION_INSERT_PTR_ATTR_ENCAP);
+
+	dr_ste_v1_set_reparse(hw_ste_p);
+}
+
+static void dr_ste_v3_set_rx_decap(u8 *hw_ste_p, u8 *s_action)
+{
+	MLX5_SET(ste_single_action_remove_header_v3, s_action, action_id,
+		 DR_STE_V1_ACTION_ID_REMOVE_HEADER_TO_HEADER);
+	MLX5_SET(ste_single_action_remove_header_v3, s_action, decap, 1);
+	MLX5_SET(ste_single_action_remove_header_v3, s_action, vni_to_cqe, 1);
+	MLX5_SET(ste_single_action_remove_header_v3, s_action, end_anchor,
+		 DR_STE_HEADER_ANCHOR_INNER_MAC);
+
+	dr_ste_v1_set_reparse(hw_ste_p);
+}
+
+static int
+dr_ste_v3_set_action_decap_l3_list(void *data, u32 data_sz,
+				   u8 *hw_action, u32 hw_action_sz,
+				   uint16_t *used_hw_action_num)
+{
+	u8 padded_data[DR_STE_L2_HDR_MAX_SZ] = {};
+	void *data_ptr = padded_data;
+	u16 used_actions = 0;
+	u32 inline_data_sz;
+	u32 i;
+
+	if (hw_action_sz / DR_STE_ACTION_DOUBLE_SZ < DR_STE_DECAP_L3_ACTION_NUM)
+		return -EINVAL;
+
+	inline_data_sz =
+		MLX5_FLD_SZ_BYTES(ste_double_action_insert_with_inline_v3, inline_data);
+
+	/* Add an alignment padding  */
+	memcpy(padded_data + data_sz % inline_data_sz, data, data_sz);
+
+	/* Remove L2L3 outer headers */
+	MLX5_SET(ste_single_action_remove_header_v3, hw_action, action_id,
+		 DR_STE_V1_ACTION_ID_REMOVE_HEADER_TO_HEADER);
+	MLX5_SET(ste_single_action_remove_header_v3, hw_action, decap, 1);
+	MLX5_SET(ste_single_action_remove_header_v3, hw_action, vni_to_cqe, 1);
+	MLX5_SET(ste_single_action_remove_header_v3, hw_action, end_anchor,
+		 DR_STE_HEADER_ANCHOR_INNER_IPV6_IPV4);
+	hw_action += DR_STE_ACTION_DOUBLE_SZ;
+	used_actions++; /* Remove and NOP are a single double action */
+
+	/* Point to the last dword of the header */
+	data_ptr += (data_sz / inline_data_sz) * inline_data_sz;
+
+	/* Add the new header using inline action 4Byte at a time, the header
+	 * is added in reversed order to the beginning of the packet to avoid
+	 * incorrect parsing by the HW. Since header is 14B or 18B an extra
+	 * two bytes are padded and later removed.
+	 */
+	for (i = 0; i < data_sz / inline_data_sz + 1; i++) {
+		void *addr_inline;
+
+		MLX5_SET(ste_double_action_insert_with_inline_v3, hw_action, action_id,
+			 DR_STE_V1_ACTION_ID_INSERT_INLINE);
+		/* The hardware expects here offset to words (2 bytes) */
+		MLX5_SET(ste_double_action_insert_with_inline_v3, hw_action, start_offset, 0);
+
+		/* Copy bytes one by one to avoid endianness problem */
+		addr_inline = MLX5_ADDR_OF(ste_double_action_insert_with_inline_v3,
+					   hw_action, inline_data);
+		memcpy(addr_inline, data_ptr - i * inline_data_sz, inline_data_sz);
+		hw_action += DR_STE_ACTION_DOUBLE_SZ;
+		used_actions++;
+	}
+
+	/* Remove first 2 extra bytes */
+	MLX5_SET(ste_single_action_remove_header_size_v3, hw_action, action_id,
+		 DR_STE_V1_ACTION_ID_REMOVE_BY_SIZE);
+	MLX5_SET(ste_single_action_remove_header_size_v3, hw_action, start_offset, 0);
+	/* The hardware expects here size in words (2 bytes) */
+	MLX5_SET(ste_single_action_remove_header_size_v3, hw_action, remove_size, 1);
+	used_actions++;
+
+	*used_hw_action_num = used_actions;
+
+	return 0;
+}
+
+static struct mlx5dr_ste_ctx ste_ctx_v3 = {
+	/* Builders */
+	.build_eth_l2_src_dst_init	= &dr_ste_v1_build_eth_l2_src_dst_init,
+	.build_eth_l3_ipv6_src_init	= &dr_ste_v1_build_eth_l3_ipv6_src_init,
+	.build_eth_l3_ipv6_dst_init	= &dr_ste_v1_build_eth_l3_ipv6_dst_init,
+	.build_eth_l3_ipv4_5_tuple_init	= &dr_ste_v1_build_eth_l3_ipv4_5_tuple_init,
+	.build_eth_l2_src_init		= &dr_ste_v1_build_eth_l2_src_init,
+	.build_eth_l2_dst_init		= &dr_ste_v1_build_eth_l2_dst_init,
+	.build_eth_l2_tnl_init		= &dr_ste_v1_build_eth_l2_tnl_init,
+	.build_eth_l3_ipv4_misc_init	= &dr_ste_v1_build_eth_l3_ipv4_misc_init,
+	.build_eth_ipv6_l3_l4_init	= &dr_ste_v1_build_eth_ipv6_l3_l4_init,
+	.build_mpls_init		= &dr_ste_v1_build_mpls_init,
+	.build_tnl_gre_init		= &dr_ste_v1_build_tnl_gre_init,
+	.build_tnl_mpls_init		= &dr_ste_v1_build_tnl_mpls_init,
+	.build_tnl_mpls_over_udp_init	= &dr_ste_v1_build_tnl_mpls_over_udp_init,
+	.build_tnl_mpls_over_gre_init	= &dr_ste_v1_build_tnl_mpls_over_gre_init,
+	.build_icmp_init		= &dr_ste_v1_build_icmp_init,
+	.build_general_purpose_init	= &dr_ste_v1_build_general_purpose_init,
+	.build_eth_l4_misc_init		= &dr_ste_v1_build_eth_l4_misc_init,
+	.build_tnl_vxlan_gpe_init	= &dr_ste_v1_build_flex_parser_tnl_vxlan_gpe_init,
+	.build_tnl_geneve_init		= &dr_ste_v1_build_flex_parser_tnl_geneve_init,
+	.build_tnl_geneve_tlv_opt_init	= &dr_ste_v1_build_flex_parser_tnl_geneve_tlv_opt_init,
+	.build_tnl_geneve_tlv_opt_exist_init =
+				  &dr_ste_v1_build_flex_parser_tnl_geneve_tlv_opt_exist_init,
+	.build_register_0_init		= &dr_ste_v1_build_register_0_init,
+	.build_register_1_init		= &dr_ste_v1_build_register_1_init,
+	.build_src_gvmi_qpn_init	= &dr_ste_v1_build_src_gvmi_qpn_init,
+	.build_flex_parser_0_init	= &dr_ste_v1_build_flex_parser_0_init,
+	.build_flex_parser_1_init	= &dr_ste_v1_build_flex_parser_1_init,
+	.build_tnl_gtpu_init		= &dr_ste_v1_build_flex_parser_tnl_gtpu_init,
+	.build_tnl_header_0_1_init	= &dr_ste_v1_build_tnl_header_0_1_init,
+	.build_tnl_gtpu_flex_parser_0_init = &dr_ste_v1_build_tnl_gtpu_flex_parser_0_init,
+	.build_tnl_gtpu_flex_parser_1_init = &dr_ste_v1_build_tnl_gtpu_flex_parser_1_init,
+
+	/* Getters and Setters */
+	.ste_init			= &dr_ste_v1_init,
+	.set_next_lu_type		= &dr_ste_v1_set_next_lu_type,
+	.get_next_lu_type		= &dr_ste_v1_get_next_lu_type,
+	.is_miss_addr_set		= &dr_ste_v1_is_miss_addr_set,
+	.set_miss_addr			= &dr_ste_v1_set_miss_addr,
+	.get_miss_addr			= &dr_ste_v1_get_miss_addr,
+	.set_hit_addr			= &dr_ste_v1_set_hit_addr,
+	.set_byte_mask			= &dr_ste_v1_set_byte_mask,
+	.get_byte_mask			= &dr_ste_v1_get_byte_mask,
+
+	/* Actions */
+	.actions_caps			= DR_STE_CTX_ACTION_CAP_TX_POP |
+					  DR_STE_CTX_ACTION_CAP_RX_PUSH |
+					  DR_STE_CTX_ACTION_CAP_RX_ENCAP,
+	.set_actions_rx			= &dr_ste_v1_set_actions_rx,
+	.set_actions_tx			= &dr_ste_v1_set_actions_tx,
+	.modify_field_arr_sz		= ARRAY_SIZE(dr_ste_v2_action_modify_field_arr),
+	.modify_field_arr		= dr_ste_v2_action_modify_field_arr,
+	.set_action_set			= &dr_ste_v1_set_action_set,
+	.set_action_add			= &dr_ste_v1_set_action_add,
+	.set_action_copy		= &dr_ste_v1_set_action_copy,
+	.set_action_decap_l3_list	= &dr_ste_v3_set_action_decap_l3_list,
+	.alloc_modify_hdr_chunk		= &dr_ste_v1_alloc_modify_hdr_ptrn_arg,
+	.dealloc_modify_hdr_chunk	= &dr_ste_v1_free_modify_hdr_ptrn_arg,
+	/* Actions bit set */
+	.set_encap			= &dr_ste_v3_set_encap,
+	.set_push_vlan			= &dr_ste_v3_set_push_vlan,
+	.set_pop_vlan			= &dr_ste_v3_set_pop_vlan,
+	.set_rx_decap			= &dr_ste_v3_set_rx_decap,
+	.set_encap_l3			= &dr_ste_v3_set_encap_l3,
+	/* Send */
+	.prepare_for_postsend		= &dr_ste_v1_prepare_for_postsend,
+};
+
+struct mlx5dr_ste_ctx *mlx5dr_ste_get_ctx_v3(void)
+{
+	return &ste_ctx_v3;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5_ifc_dr.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5_ifc_dr.h
index fb078fa0f0cc..898c3618ff26 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5_ifc_dr.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5_ifc_dr.h
@@ -600,4 +600,44 @@ struct mlx5_ifc_ste_double_action_aso_v1_bits {
 	};
 };
 
+struct mlx5_ifc_ste_single_action_remove_header_v3_bits {
+	u8         action_id[0x8];
+	u8         start_anchor[0x7];
+	u8         end_anchor[0x7];
+	u8         reserved_at_16[0x1];
+	u8         outer_l4_remove[0x1];
+	u8         reserved_at_18[0x4];
+	u8         decap[0x1];
+	u8         vni_to_cqe[0x1];
+	u8         qos_profile[0x2];
+};
+
+struct mlx5_ifc_ste_single_action_remove_header_size_v3_bits {
+	u8         action_id[0x8];
+	u8         start_anchor[0x7];
+	u8         start_offset[0x8];
+	u8         outer_l4_remove[0x1];
+	u8         reserved_at_18[0x2];
+	u8         remove_size[0x6];
+};
+
+struct mlx5_ifc_ste_double_action_insert_with_inline_v3_bits {
+	u8         action_id[0x8];
+	u8         start_anchor[0x7];
+	u8         start_offset[0x8];
+	u8         reserved_at_17[0x9];
+
+	u8         inline_data[0x20];
+};
+
+struct mlx5_ifc_ste_double_action_insert_with_ptr_v3_bits {
+	u8         action_id[0x8];
+	u8         start_anchor[0x7];
+	u8         start_offset[0x8];
+	u8         size[0x6];
+	u8         attributes[0x3];
+
+	u8         pointer[0x20];
+};
+
 #endif /* MLX5_IFC_DR_H */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h
index 3ac7dc67509f..0bb3724c10c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h
@@ -160,7 +160,7 @@ mlx5dr_is_supported(struct mlx5_core_dev *dev)
 	       (MLX5_CAP_ESW_FLOWTABLE_FDB(dev, sw_owner) ||
 		(MLX5_CAP_ESW_FLOWTABLE_FDB(dev, sw_owner_v2) &&
 		 (MLX5_CAP_GEN(dev, steering_format_version) <=
-		  MLX5_STEERING_FORMAT_CONNECTX_7)));
+		  MLX5_STEERING_FORMAT_CONNECTX_8)));
 }
 
 /* buddy functions & structure */
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index c79ba6197673..cf354d34b30a 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1590,6 +1590,7 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_5   = 0,
 	MLX5_STEERING_FORMAT_CONNECTX_6DX = 1,
 	MLX5_STEERING_FORMAT_CONNECTX_7   = 2,
+	MLX5_STEERING_FORMAT_CONNECTX_8   = 3,
 };
 
 struct mlx5_ifc_cmd_hca_cap_bits {
-- 
2.44.0


