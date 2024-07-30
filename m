Return-Path: <netdev+bounces-113989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846C6940835
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89EB1C22B70
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4971A18E77C;
	Tue, 30 Jul 2024 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S61CJc4m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310618E772
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320329; cv=fail; b=R+ZJp+OCrDqzTHotGm55UjNrYCKqFqmr+QC/GoOsob5+do2yb8nXoAxWZfrH9iyRmrnEjSFUOf0vbDxIyxV23wOhIc17t4ZmiKGY/Jkj/wuI/DMGn3SfmKY1MY5z0whT6Uac0CiJEncX6lsfEFB+KfukF61o0zKiSAsrHdTyCOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320329; c=relaxed/simple;
	bh=n62anDQw9g6sS23WeD1tVOTfJKIt8QeWhgaDtaqX2Aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDSpExBN4+FbQFsALNhuhBuWnRwnOJ48lRJI2Peie+JKa/S8dDclyY9qV6TzBhCYapj2X0YXTOG9asvpiW83iPk6M8GHsMU/lVa2sCH7xPU5T7raxHr7w/LyKAhM+ZPSbhIOZg53vorwli+ZwTr8IU7DTn1xovL/7R7iVXyZ+ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S61CJc4m; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+Z6Rq3lmrSCHafUT58bm431Jtx04F2RXEtDiqledm3JFv3JtR0q6vT4UCqSUcfMEVjtXdjEA/rBwLM2wB7Fk//mlP13CZ+zv4wQRLquP7gMB1YorC00yfBvSJhKF1kJJAYAWdcyHvT0P4iYmGvAyl32/JxgdFCFeIcighlifEp3XBMwlHAHs+wQ2u6b4x2N/ZFtEY7RuOrpZKA6PpyhkfhsE0ROFPWShzBpaXPJikYuyRDx5Ftk706+MEDYzp99RnU3e7baHFyDtll8J1qz16y5kCTfsKpchywOALbhAaZAjfgoKHhVKhuAwAD1ccmE5j/CPUrEjeSlAXiy8gm8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GOtobfGVXLvErxYZJ/0CR68tPlTtcAaBD/5usemGmE=;
 b=jym3cwCFaPeVuesRoreNp0IeFK266vakwwrqxYQnpRXr4BekfccntxfCeVZgfkTs0SWCCHfrAY/N3SHZw7XQJ8sz5u4dj+h7ONLxQjcX7lIln6hS7rULClWD+ikd5wxs+ANtrt1ckVdSm375089yasrDNkTKRLrPBNGQOvRmPqf6MCl+9c0EgLOyhguDToTOPg6iA7g6WjYc+62f1r5iRQkxwJtfzFF5SCVVMtX/SVc25mk5TGzsvNT9wO3X/DIZhduNtXoAnCa+iNVLrRMrBwlAnihQahJlpy6keKr02ykdVZwa8EqL9j+BI/WQOrhoeqNdWnfvz0lNotNE79Hg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GOtobfGVXLvErxYZJ/0CR68tPlTtcAaBD/5usemGmE=;
 b=S61CJc4mReNCXk3d2F70FCiDqS9jsm6YR0pRCTj72D+NzD+b7zVVY1isfOhFrqS92r0QH2VoNMUZ7+l27w6oA58pIbKgMrJpMvUSO2dEZ6R57qSpogGB43nicVCadNjY25UeTwsK+iNWmd14+0Momr4vnWEpb2pX5/iphsowT4Gimah8luc+7UeVapNtvgHUO4tzd4qjiQTvHtm3yyYQNWLOpAnsWGDUAQ3JmtOnk7tuZ4UeMh3BRlZ/36kKa+1HTorlKNygHhmCe2yxckI67+M8Iz4mxx9SuY7DvoUPt0pDIK6KbQsXfTjAXMQsCp3UjRet3p2qbV7zdriXD29dQQ==
Received: from DS7PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:3bb::33)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 06:18:44 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::30) by DS7PR03CA0088.outlook.office365.com
 (2603:10b6:5:3bb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 06:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 06:18:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:30 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 23:18:26 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 6/8] net/mlx5e: Require mlx5 tc classifier action support for IPsec prio capability
Date: Tue, 30 Jul 2024 09:16:35 +0300
Message-ID: <20240730061638.1831002-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240730061638.1831002-1-tariqt@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: c47fc560-901c-4ed0-d40a-08dcb05f76ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LZ6xpspupe+XXnpDT6LfICWnY3yj10krN5dhamReiOCskFssJdKdiOxSkuKc?=
 =?us-ascii?Q?4xj8wi5FV4Y4Vwjl+B1Jyori0UD5eJTUax5GLeD/0gDoXgDXRgpza9er6EVj?=
 =?us-ascii?Q?qeakg3D9DmGoEI3eY6v87Ib+g7zeyXjNIhnKWezXbZDHfaCXFK/97G4Fh3Mo?=
 =?us-ascii?Q?1MN1ToNLhCaokRZeeQxBoIhnsNP3MCbqBkiKmjBhlw9L1cGUaavZsRemBNaV?=
 =?us-ascii?Q?7N0z+Xeukh+/ckdJsUm2kgxIm9ojhToQp3qfPGLmo7m8kWfF8C2saYLjr6lp?=
 =?us-ascii?Q?qdAcvxTtXOpg7PA7cC6U21vBYVFZYB1Ku+dhf/dbaTeTZEZGIqp7dBzVsNz7?=
 =?us-ascii?Q?tUWLdhbI3ccm5fFmTuebQoV4MIyo/Vgn3Y6e9UTtorVGbnUV2QVWNHrNyUKc?=
 =?us-ascii?Q?DkBu0qMGQgVLWRiHEorf5/8NOhjQ9IdcuS+VY3tqHilRSA27VUsmDfTPJG0o?=
 =?us-ascii?Q?s1vq7Z4T3o5r8o244dHFe+lrIShk28pPUxYeDTPPYcP1NAXAiEOC7Ho99HLx?=
 =?us-ascii?Q?gPkwIO6b2G3Xct5B5g/u0NKI+i04dKuRTutMFT7oHVCAnm/3vkFmShAWV0NN?=
 =?us-ascii?Q?+k1CWmhG/GFgxga0iKxEa+RbZ3cjL8WNQ6zVLKUpTT8jWbguJWhCZNeKa4hs?=
 =?us-ascii?Q?VhFZVHTzXKAzvpdwjGaQxRT2ZS8sUKxyQaSbrPK9DSzdcVm5sPAQsGcaIumZ?=
 =?us-ascii?Q?JhkxqfSRryNdhag15XZhAfKzdU2KeS1dxU/SGw7DhpZ0dLOvEgFTmR8PSTDn?=
 =?us-ascii?Q?7L1dBw1E3bAO/eYVQlOcjkzzWCtLgyA8KBtKSWRYPSGRMMZP1MaKHEBD3fuP?=
 =?us-ascii?Q?5Wnj4yKLLK/iEEwB/c5TxqolPtocq7LNbZI5k0Ekm74gwxB+VhsvOT62AXW2?=
 =?us-ascii?Q?8ZzBPsWjGVs/xpNsXTRwop1+ry1ij1YXg8gYxnJwKidReHbHyGGHUOrKglzj?=
 =?us-ascii?Q?aPptrf8R9R/g4jk4b1pMdaLrp58d9tSDwshU/zm78GGu+BP+M3AYE6P6oZLD?=
 =?us-ascii?Q?Ep8nYa2xDUp+y+PycS8W+m/RmArjq5usUPuA/0zQC6IRqZS/Lu9Cp6c1hFjg?=
 =?us-ascii?Q?kjNxgrnqnNUJQMTBTsaWKVlnVjOWInYQCY5LxvljeZJNkYxt7J4j8B1fC56v?=
 =?us-ascii?Q?AJACFqpI2KjUBre/j2xnx/2nsWReeLT3jG02lb4rPz+A+Vh04Ij0LZniU32y?=
 =?us-ascii?Q?Q2q4QNa9AUUZcZ2MR6TAy6l8dUJOKBMiVTN/yrHdaY6fSdtewfF3FBOxtuf9?=
 =?us-ascii?Q?LktarVNFvvfzJsg9AWKiCXN83X+oIjnZstRpo2KqmFY66T+tJDjgOXU6RotV?=
 =?us-ascii?Q?m9RgCEXVK1FoECdwjrg1J3gaRa/t8fUQAVQ43OwmVi+cVBTMPSrLtPXA5Dap?=
 =?us-ascii?Q?fBswVcuLjS6W+auKQCVdcM96I6ZHodKBv6uFFVtLe36bg+vdF4OZB2uAURvV?=
 =?us-ascii?Q?QxjPNPJmx78qYXwueeHkc3y+Zw2Kdl9p?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 06:18:43.7624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47fc560-901c-4ed0-d40a-08dcb05f76ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Require mlx5 classifier action support when creating IPSec chains in
offload path. MLX5_IPSEC_CAP_PRIO should only be set if CONFIG_MLX5_CLS_ACT
is enabled. If CONFIG_MLX5_CLS_ACT=n and MLX5_IPSEC_CAP_PRIO is set,
configuring IPsec offload will fail due to the mlxx5 ipsec chain rules
failing to be created due to lack of classifier action support.

Fixes: fa5aa2f89073 ("net/mlx5e: Use chains for IPsec policy priority offload")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c   | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 6e00afe4671b..797db853de36 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -51,9 +51,10 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
 		    MLX5_CAP_FLOWTABLE_NIC_RX(mdev, decap))
 			caps |= MLX5_IPSEC_CAP_PACKET_OFFLOAD;
 
-		if ((MLX5_CAP_FLOWTABLE_NIC_TX(mdev, ignore_flow_level) &&
-		     MLX5_CAP_FLOWTABLE_NIC_RX(mdev, ignore_flow_level)) ||
-		    MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, ignore_flow_level))
+		if (IS_ENABLED(CONFIG_MLX5_CLS_ACT) &&
+		    ((MLX5_CAP_FLOWTABLE_NIC_TX(mdev, ignore_flow_level) &&
+		      MLX5_CAP_FLOWTABLE_NIC_RX(mdev, ignore_flow_level)) ||
+		     MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, ignore_flow_level)))
 			caps |= MLX5_IPSEC_CAP_PRIO;
 
 		if (MLX5_CAP_FLOWTABLE_NIC_TX(mdev,
-- 
2.44.0


