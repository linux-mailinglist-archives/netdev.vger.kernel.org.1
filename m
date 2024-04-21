Return-Path: <netdev+bounces-89865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669C18ABFA4
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 16:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA21B281600
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB7817583;
	Sun, 21 Apr 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T46wk7F6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5CD527
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713710395; cv=fail; b=fG5tcFtVFgABCxhqyMeU0I3boYjRarh0G3fuXXUdpVTMRZY0LjhUaraKPIUfll9bWLu91DFC8kvhK7Gou0owL+m1APBVkMBl1KmojDax/7HXAxFxWu+zEBw8c/iqoGZ4Log31qiD3PbmWhRxBsmEsImsTImVMutqz0hcPgoHaqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713710395; c=relaxed/simple;
	bh=wCeXoCY+CemkjWqDQAj8HWDNGcxgRZRqkkksj6fdEyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V7QTOKRT7BjEMr//OG/8VoTHqV8uLNtpYHYKQ4/WRsWUIw6tNAyfHTlGpyDhgxHt6MpbOrKMsKQ3DgYXQ6A6fkekHILeK5ea9A+F1fYXNsD02mGVbHOhrZYA+3pVE3WwHH3l51fslhXDaZ28HxagT0ZonpaCRXRRs/7q0LsZ6fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T46wk7F6; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtQFThn4/FwNy0bNdARyCqRNQXbfiIVn6DVZEwQjyZ3ba/dftjSHhoy4gMo2IkSlgzq9gd/t2s0lH1j+AkxzbOxIxTvjlGdz3jZMuRtLs+c86RaOGvsLNnS9MjUT4ejR4sfL1pZTr0cVDLwpj4awdm8D5dSDv9a/4NDzg/jXApu07A2exPgYVcJZEGIlJggMzK2QRR2gpnO0NWnvdYAZi8Qi7ZnXefDh0KmZyqLrEXIu6ACYGtrfpJBX++N3atuBNs+ZT49DMM9C9MearA165o7rItRqEDCDg3c3OSIIGevfqHE8SOHP1zXHLGm28+65OzlntiCSEFrUXm4aZ2qoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2XWnCcV+Cb55E2TF0aqiSYYqGyl6Cji/y/OiIcvol8=;
 b=J/PQKGEohEWZS+tDM1Tu89LkigvBnX2i5SCnHiwU8tRvMwgIB7brAGVfYvcFSSLJ50RyRendyt/wo+TpOl4J4E/jC29Wd0nJAFxK2FpfnyCkL1odQJmCrIbEPFoTTXcRhO+YxqLj6xwO9hu0+wa7FfPf/x85geWP+6CuLQvOe7sftAg01uYNZYZrDoNAXAcK1AdjwgUbcRbi79sbubKienmNKnKVbRxi/QkWBdOyQ71sS/STPhtrKYmPWaiQBhd5BGxQgvz3jS02/2r+XCVPiwOL3LLhE7+YbufJN+sYVt80s8v5MfOBi3fh0Nx+2tAKT5PGcO/JstZd2KOIe+bXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2XWnCcV+Cb55E2TF0aqiSYYqGyl6Cji/y/OiIcvol8=;
 b=T46wk7F6ugVtLK6Wp3m6A2c4vA8uKnyHVGZb30byUnegfU7ZG39c56jSvEydhH52NiCyGHRCmLfjQrkqonpR6bvK6gEcSCpAW4oZERkPl2eaFh18le23jf3a475Vttl9G+n+vsfArQQHvO3+j0f5jHFy5YuagLQvwlCnqrZeuVOid/iaYy1rRjzKJUBWa7sFuv+uW37rOfO70fuvNHtpwxuCw7TU1lwp74IpPBaC+lyPsu32VEjwC5NhXfRd7+xOHEY9kQ0uYQsEmyv8LPw4PpNIrkM8g2I961RBPpHgUYACBg/IaE4MP5QjkdZJNM5W9A6OQNzFhmZoCNFfueDWkQ==
Received: from SN7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::21)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sun, 21 Apr
 2024 14:39:51 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:124:cafe::8d) by SN7P222CA0003.outlook.office365.com
 (2603:10b6:806:124::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Sun, 21 Apr 2024 14:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Sun, 21 Apr 2024 14:39:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 21 Apr
 2024 07:39:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 21 Apr 2024 07:39:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 21 Apr 2024 07:39:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next] MAINTAINERS: Update Mellanox website links
Date: Sun, 21 Apr 2024 17:39:14 +0300
Message-ID: <20240421143914.437810-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: a74a3d28-cc3f-40e3-6ee8-08dc6210e68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/pGMtJSLiC7N8GaxW5yqx9f+L8L5hmtay8lFKQpvSlt/wvIJN1JyiWKldd5?=
 =?us-ascii?Q?GMC7TYhM5lnz8Fq+3Hd3q4kRiIwh/syFt4jMxrlb4YwLhuWXUGDBrfHmBmOn?=
 =?us-ascii?Q?izZb1wyuFNkeI/My7mGKxoNaqTWxFKUEWrcBPppvqejQ3uTwpjL2/qcD4OQG?=
 =?us-ascii?Q?FGnQ5ptlHlyD328N+wCFundf7+umLj2NWmmEAH1sjJUR4Yu/DwW+REu1Vo68?=
 =?us-ascii?Q?PQiP69ioAzsDvEDgE4rCOZU5YsbbFm0tCdS6w6h+2b11OZomf4rvknYTqcK3?=
 =?us-ascii?Q?RJUDaXmjqYMLH1BAq5VxcYDpf39YoRuC+4Tmi144fSNM3uhQMo84BNRgybU6?=
 =?us-ascii?Q?vimXzO8ZlvHdFYJyL+5rH8FUg/GMBIIWdZVjrsb0FkhDFmEsxN4altSazrgm?=
 =?us-ascii?Q?j8YvGG3Bt23UzxTiwSZmbIF2S1n3RFHOoX7vEAVNNDYY7lVprbuXqdHACLgv?=
 =?us-ascii?Q?zlTdCSB9pk2vK2OaKu2nUpxq658W0JO7MbLv5Rgkmz9+HOh9Nkbjq1A8wnGu?=
 =?us-ascii?Q?QzGtO+QcTZGum0HiWeFOWPfRjic83SLkcSf1ZC/wSPAV//v0UiiDAEk2JYM/?=
 =?us-ascii?Q?qHsbyMA12g4Vm+2ppKbGEpEasP8Inlwdn875JSUKciEbJtHdIWnMbG/axzUd?=
 =?us-ascii?Q?TTREFgC1cQLQbTFKCUgSX2b6nIpKkBTpYigqFYh9Fz4XLt6kvB3DTv3fmv8A?=
 =?us-ascii?Q?EL5qKlaJnvJTaaPkKxA2qq3p7T6l+BBXkd3PHvL5aay+sReGEAKQ3j8HQfuh?=
 =?us-ascii?Q?NPRfDaLC0cdAwE/dLyaIYaBq9VqGQ9Ag9XQ+qCpGXS9XN9XxMtcqLaTHn4w+?=
 =?us-ascii?Q?p0IqAI+6lmDAm54x7mc1aTGXCDvWvJ3AWRe4Uirum/s3wjRfaZXrWXi1EfIm?=
 =?us-ascii?Q?MWsyC9WHuGLhnT80Ju5hHiPdCZ3itPyFV6dE4YiiopL1J9C+3OD2QwgpEfrP?=
 =?us-ascii?Q?ndgijzCNNFpdw5WiDggMJHvjotxl9ESSbAmdL6iaGuDRc84WlcDKs1ZX1mQj?=
 =?us-ascii?Q?S0PeOtzBE2sTQCgZehQxOV5QugVAAXIBL1MKSZ8FdzWD4XlMpiw/pNSCOfh9?=
 =?us-ascii?Q?QiXc3wZ2O4FVFbG1Jojdjh9lW7RRnmLMkm5zY1Uo/v5rNhLbe8LOu2y8yd/H?=
 =?us-ascii?Q?MzuBlD5PYTJ7aEU4ZghbYS7S3+81PzfDjwINcHJgQPfvoht1sqAujyQA6d6H?=
 =?us-ascii?Q?m9dStTPQxxPsR0ihCLkYCvRJwbz3RYa2RdyuCsBVocU3JRhvWRbgMdgI5/Ug?=
 =?us-ascii?Q?2OmfQn7pXXJf38MFeTOrUYn72Uvjtpb9A83ZOakAa44wX55QP9PPsbWgWErs?=
 =?us-ascii?Q?i9Xlo53XhzITTT42u2g6aTSHIvT29DUwziw/Y25bVuGeD97I4TUXlnu2tRWB?=
 =?us-ascii?Q?GeLQOYq5br1rgo28MnMbz6nrlz5r?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2024 14:39:50.5323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a74a3d28-cc3f-40e3-6ee8-08dc6210e68c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Old mellanox.com domain is no longer functional. Point to the current
relevant pages on the nvidia.com domain.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 MAINTAINERS | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0bfad334623..7f4f62968a67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14009,7 +14009,7 @@ MELLANOX ETHERNET DRIVER (mlx4_en)
 M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/en-us/networking/ethernet-adapters/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlx4/en_*
 
@@ -14018,7 +14018,7 @@ M:	Saeed Mahameed <saeedm@nvidia.com>
 M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/en-us/networking/ethernet-adapters/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlx5/core/en_*
 
@@ -14026,7 +14026,7 @@ MELLANOX ETHERNET INNOVA DRIVERS
 R:	Boris Pismenny <borisp@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/en-us/networking/ethernet-adapters/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlx5/core/en_accel/*
 F:	drivers/net/ethernet/mellanox/mlx5/core/fpga/*
@@ -14037,7 +14037,7 @@ M:	Ido Schimmel <idosch@nvidia.com>
 M:	Petr Machata <petrm@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/en-us/networking/ethernet-switching/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlxsw/
 F:	tools/testing/selftests/drivers/net/mlxsw/
@@ -14046,7 +14046,7 @@ MELLANOX FIRMWARE FLASH LIBRARY (mlxfw)
 M:	mlxsw@nvidia.com
 L:	netdev@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/en-us/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlxfw/
 
@@ -14065,7 +14065,7 @@ M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/en-us/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	drivers/net/ethernet/mellanox/mlx4/
 F:	include/linux/mlx4/
@@ -14074,7 +14074,7 @@ MELLANOX MLX4 IB driver
 M:	Yishai Hadas <yishaih@nvidia.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/en-us/networking/infiniband-adapters/
 Q:	http://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/mlx4/
 F:	include/linux/mlx4/
@@ -14087,7 +14087,7 @@ M:	Tariq Toukan <tariqt@nvidia.com>
 L:	netdev@vger.kernel.org
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/en-us/networking/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	Documentation/networking/device_drivers/ethernet/mellanox/
 F:	drivers/net/ethernet/mellanox/mlx5/core/
@@ -14097,7 +14097,7 @@ MELLANOX MLX5 IB driver
 M:	Leon Romanovsky <leonro@nvidia.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-W:	http://www.mellanox.com
+W:	https://www.nvidia.com/en-us/networking/infiniband-adapters/
 Q:	http://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/mlx5/
 F:	include/linux/mlx5/
-- 
2.31.1


