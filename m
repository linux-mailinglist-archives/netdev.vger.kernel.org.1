Return-Path: <netdev+bounces-153480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249439F82E2
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BFBB1885D65
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372E51A9B38;
	Thu, 19 Dec 2024 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IiKJfTSq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7DA1A76DE
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631217; cv=fail; b=paVJIsZ0rRqYxS9+12fp/KY6nZWbDNuqUXytxiEKzQkAmU1F5Q/Nko1XzvbBfvh/zmIwqZl42bvCtCyffYGzhTA4tIN4zoP3t41CBDP3YFK5/dMOYT4WNkHvYW5VyBD8UgIvtnWoqQ2lxtwBGTH0ptQFTcyHChjnkUXsNS796iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631217; c=relaxed/simple;
	bh=HZp36Z/BNM/7qHp4pzrjhalxF8VqhT1hOGKFeKCDV8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A704zgsJc1u/gChonEe8A42gVXmXfkXDjbmEveaBgyLEPwTHhiwILzUgew3xtkvGpftZoaoAEyELRnpsTmTkCH2vLywaTy7YjRUbzpQ6Rs2aLzFvzZmUf62vxw3QiHX+NaI9QJbuyxiLYUg8PdHVvWHSuq5JYj16ZAGICd/CTTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IiKJfTSq; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJdikiSbe0mv13A++zoxvrTrQYVrca1Fvyw6YV89RNn5M3VrQdpYcyFIRHVKmEpgkkxP79+3rQQlguXECdGkGZLJVjSHs591ThGFqFYWqS6eOAHP5LcUtgI04bdlgiDYpprJql1TzX+rPYDBpAX+J05Mue3q2jIcIvjIdeombowqL2SdezsLe9KogBld9YZs+sUwhjI0E+WfJIlndcI7rLiIErRXT8VoSIin7Hw9iSPUI9PKav68Ltn4T/+7qqjh068uqh7DVemK9g1iVRYrlOkoRabzOW3gkCukLHWSWySeTB++/B+Io3xic+b02H34NLM4+kLX4dtNjEqu67eXeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHJfrVIfs8CkSCBMOa7ULp8zKCL087Q62zNg5LiALGQ=;
 b=y8vi0TEggJLBK3AChf3vBu0oBAv97JMBGEU/fU9R0fqWOEWaRxIdzHo50jHrMALGZkmom27NfIheS7nuLvSVC8FdVGHRAwYaZ05uquXkCktb4oZH/NljAdK/EPcf+hBQ77yXh5bMmCRaWvStGCmFOPyCLg73VVR5wyWHUynmg79nqq4hTO6wSdoQ19FAL9ftNhXFMmEAq3LCPjsnAKkd1Jr3+0MFBrPN1+an9VrchFPGaQLJNNKjjP7t7gKpIpQqvBHr+a6qfi22l6kIWdt8Z50OEa4avFVyjjJmwuUaN/xpzQqCBMi4fDfrXdOBrpeKNSA9oaQnjpTHKChzGa8uhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHJfrVIfs8CkSCBMOa7ULp8zKCL087Q62zNg5LiALGQ=;
 b=IiKJfTSqF9rTDrXc1IXukcKmPBV15mDN4iyTu11SmOxOsAQerr074mq1hKdWTKLzeK21uRG55rLdoUAHxCHn5+/TQ/lby7pQR/sXO9NkHwXEbc17dIC6RzX0NbEpZvL5Ij0qAGcVOTC6xVRfMb/lW97ZET5HC+BSgkXR5coABmqYTTOpfu6C/6ACZPY8iwusTHxYx1pDOCo+VUp7OxoWBJrm4s7gQbApgNg8ARQjQu5M1HQFXxmtUXY3aB4w25p1A5IT1RVnxTp2ki0Ti99J6I91LCriMD/FN45YuHMSoKBu1CG+eerrWzCy2RRKI92ISWEaE8IUzs6+WI0erftcNA==
Received: from CH0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:610:b2::12)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 18:00:07 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::c6) by CH0PR13CA0037.outlook.office365.com
 (2603:10b6:610:b2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Thu,
 19 Dec 2024 18:00:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 18:00:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:52 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 19 Dec
 2024 09:59:48 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Itamar
 Gozlan" <igozlan@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>
Subject: [PATCH net-next V4 09/11] net/mlx5: DR, add support for ConnectX-8 steering
Date: Thu, 19 Dec 2024 19:58:39 +0200
Message-ID: <20241219175841.1094544-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241219175841.1094544-1-tariqt@nvidia.com>
References: <20241219175841.1094544-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 647161e0-ef1e-4372-7466-08dd2056f8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rXr+SfwLQfAvjKmirlpOxKattcOeDsKld8MTz+7oo9LfPR+4+9fPw5bS6/HB?=
 =?us-ascii?Q?u7hgefXpJmOoAqoQ1QN19cEWB4CszPO5858IVQTFtjGm/Sf7jaDXTVGgINZb?=
 =?us-ascii?Q?l79lrSWVEWWvczfAknU6U/SFiIe3H4zp96xTxPExVtzKlQyd7q5V9tJDyqTK?=
 =?us-ascii?Q?y67pYAEwu6kbkfhfOK/PJ5aN4u/vhRP808/N6ui82c8uqzrsqydnbW1QfemA?=
 =?us-ascii?Q?R84fRdUBNzyRxgmG+CuxW4JyXvUGRcPZK9+SELxOK9dJz5MvhGvlUPQXpyWI?=
 =?us-ascii?Q?LsaMosuoG+b55NXHperksp3KuMUPfsi47xOu7KRhEmiQryGiHP87whW4vDYt?=
 =?us-ascii?Q?y5+Nu5eIsZP+QiM68VUimQX4tI8njW1Ez1rhhhP1wLXI3/ZyOgj4QdpnaDAW?=
 =?us-ascii?Q?vxhpZCwL88i16OjWS/a5O5QWSXZoad6lsY11xSc6cgf7qmac1+cnPCb7gwer?=
 =?us-ascii?Q?ydCJT74QJE2FKDNlCL7poFd+tXi0UGV4qH08OU6apH7RVI/cNtrvYDhZHpLJ?=
 =?us-ascii?Q?2Yc8NvDFeaXoVNaxcXUD1ZSzrtjvtwm6bda3/a/iAQKAlTXpsE8fFpxI+ONQ?=
 =?us-ascii?Q?uuI6Rz3BVwefbnxA8Pru8mbaeNiWlL0QbxYpAI4qbS9uSTiQwaCFff3V79NA?=
 =?us-ascii?Q?0U1OHBLVvd6UN9lKIe/LKLizJXWzMBQtGdC3Ak2cvjmn3GS2LaL/cH5wK6CW?=
 =?us-ascii?Q?cajPjyBmjySScd3oTmykJz2uayD2l7bF6D2J8cgstteqcFKSJb68NDhFdeh9?=
 =?us-ascii?Q?oxJpSKy4xDzsoHzeOtvjMss7LVm1SuNDxVfpp3iiwQIwPHvF9gCNoCtKKudL?=
 =?us-ascii?Q?Xi/Qw6JJTRH1r5z00BEIabnw+WX2twiZfouuf0dyHVAMHW//RbdhPN4oDJvX?=
 =?us-ascii?Q?0SE3JTDblKO+UEK3dstGeOWwEf7C6aqfErx10wbF1IRTvAWaC+5fXEK7Q3d6?=
 =?us-ascii?Q?UmtU4qL1UE4DOoif73rZu1HWgJwFVPEOuOFZE55/EYGax8ip+XZ4KBr2qMAn?=
 =?us-ascii?Q?VRyfQ/dr3Iz+JV71vps0PKV+QqYPXPiBw+P8bprP1igOHYLg3NfNJx12aT6q?=
 =?us-ascii?Q?D2UWb9UgfDTDPLui7dAZdEY26VEwD4skX962RN2E8zTp4Z6xbMdcB7GVnCLX?=
 =?us-ascii?Q?aExedEtNjgWthKmDRcn9v8PrgVgGb9K/iJsmrICKiTsRLezjmCt1l3Us6cdk?=
 =?us-ascii?Q?AL+jKwO6tCuUMa+E3L1Fl4ZBYh6A/IOFxy19jm685R8Cimw0MmTP21KvDWpA?=
 =?us-ascii?Q?G6CIS+8dHYhyMd+4I4Q3DAqviQEaBeGS0vOmowa0pjL8V1HAyJNI0Qfy1acj?=
 =?us-ascii?Q?66XJWiSBvhpcrslUY08W7/ZemRxqs0GPXiDrPMBJeGjrwP0nyE0tz5+rJe+g?=
 =?us-ascii?Q?XXFPD3NE2fbspXzR4olBMM0wT9D9TZMbbg4zB9KAQa65Oix9zVraKgvPk/Je?=
 =?us-ascii?Q?J74EQgx2/EVeiEsGV/ZJ/hhKhldtFK/WcT4TuwGyWW85kg4mBBeEEfOe2Uz6?=
 =?us-ascii?Q?u4JdHGWMFZv/ITQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 18:00:06.8840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647161e0-ef1e-4372-7466-08dd2056f8d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

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
 7 files changed, 267 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 79fe09de0a9f..10a763e668ed 100644
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
index 49f22cad92bf..60cb4527588a 100644
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
-- 
2.45.0


