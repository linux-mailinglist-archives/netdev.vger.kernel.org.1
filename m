Return-Path: <netdev+bounces-116891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D46994C00E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23A61F25316
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB721922D5;
	Thu,  8 Aug 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IZVH33dP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA69190692
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128184; cv=fail; b=EpYPdbFQw0gvm1q8PZ+ZT6BvWQzcqZGJNiIziYCUpkLYsF+QZcRD1Q8hpAm4yK7RU793xKRNqyLX8X4kJk+BgKj4EqlwSTOW8r5qYG8LsFsM6UxZqwauL9SVsRqSF/JBWHoLnXNmEO4fXXSq/lkH1eXFfpCPklE3PvwjAlLpomk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128184; c=relaxed/simple;
	bh=ipU19euc30X2BFE5TF5xmNf7ZjTrNkHvLo0ICVjdRlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxBVNIrNZVe/PSqKGb+5AcxpiDuvSRg1fbGznk9BvpdOhnKe5E4FsXNIzOBBOvJSf3uyDb6Iq5pMVle/vYOsQZu/HvMXs767zqZK4CLfd51Mpb2wh24SH+60ihMxrChr0RBvsTAGrycYdh1yFY1XAUUioS0rw9XSKuxjDFBwFdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IZVH33dP; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ts2PPbeItlyLvSEJ9sGPflVMLAWZSYX3GHd/MLmtfvwYEhWTAt8ElDeZ/guKI/T5OzCs959H3aa9jrzDCTawZ2ySH/p7S4ZW+HFHOt0Kr9uTxdMgRM2If+aT2fH5x7Owb3scUCPUn/WpMjKIZl+tKsYcY7IsWerJcqb9NRfr8JHqhQPUdrotrZVqeGMDyIaG2KagVPjA5k7ssJwX3eaYDJqigFeSuFWqJoUeXrtEkVFpD7eir/UaPowq5ll9ImKXLQc3EO8tzlvEZA6AZRcUkkZ1bqs9U+2o+BtVx2z2tZcJtw70oA8hUQqOugv9u8l4HmLT/APpJnG5qd+6IZbrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h1YHDhGDAm+bWUU7hedoWMsS1q9tyS4gmlFhvASSzY=;
 b=wy64DyYjdnS7W8jhrvTdrgQ6ltW65N+7MJqx2RfwbA4gLW57teA0QZkg4AOvuf5DrSn/cm6Og2TcU0Of0SjSc4J4Y9fKWt8ge4YESrdVCCQmnrv+5mAcp4I5RmZaUUX3P5Tm2Q6LuXWhGHCqE0z2THj4JHuRdkb3rqmppeg0vcDM+kZp5tNkr0Im1/3OuoL0MUdxNq5AUmZZkg7r7IySsE1YNj/PVKw9rAfai+hekWWVk5uCwib6sMA5LHRr+KIhV1nJHS27DqNymF2E4tfC2fyxnaRTuiN6iBBY/LpTn1pbGCwxDIQp31OvHUdqClIFsSGva0FWWL3finU/Q9Az/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5h1YHDhGDAm+bWUU7hedoWMsS1q9tyS4gmlFhvASSzY=;
 b=IZVH33dPvGXS/i08CQeUBgepCGrzHBxaDqI5LGlwCKEImHpXtAf1gjj/hFeaMd1ZBWSR7yeO3lJgWSuAkZGQ9TksoSZ1/LG+MjD/pf8itHru0xZDIsCexcbng5VArwn6SKwzJLp9lEpvTN/ssyrzhK8k/nLHGQD6ThkBasn9BHG7l3p6ejs5CXm3AayP40s0ty9Qr3CvqnOqmdiS5a+Wpvfu8EkeBFHzrnetUDDMXjWQ/oyWyJ51PU0tS5AUbDSjTZc9AOHhDa8URQTjlZWwByl73dLNKY0avHP0xUty6cfWUFN+viphc1I/wVmhmUb+7UU466OXz415nAm1AA3sxg==
Received: from CH5P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::11)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 8 Aug
 2024 14:42:54 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::7f) by CH5P222CA0023.outlook.office365.com
 (2603:10b6:610:1ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15 via Frontend
 Transport; Thu, 8 Aug 2024 14:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 14:42:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 Aug 2024
 07:42:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 Aug 2024 07:42:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 Aug 2024 07:42:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 1/5] net/mlx5: SD, Do not query MPIR register if no sd_group
Date: Thu, 8 Aug 2024 17:41:02 +0300
Message-ID: <20240808144107.2095424-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808144107.2095424-1-tariqt@nvidia.com>
References: <20240808144107.2095424-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e61beb-b0d2-4c2b-41a8-08dcb7b8628c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P4x4BDrl4TY+FLvU59OrgH4VC/KjmWv9ZjxzBTohdOcpDpDYuTutHnN0rCk2?=
 =?us-ascii?Q?Qg6d+mUNSogVxABlIUqoxTK4ABQ/gZeoYO4GGC8PrdvQ5wsWX+440reB/ib+?=
 =?us-ascii?Q?ypIDcPqbsqz/DZxaK154mGih/f7ZW3MXlJtNwsYLIhUbBhRw4+XU+3seiIaI?=
 =?us-ascii?Q?CX/oAKQk4mz6cEyd6lhVAUMY3lgTBnH3FkQN2zJbwlrKO6AgF718fVwoPC9E?=
 =?us-ascii?Q?eyXQXsK4hGyyhs0B86F0DheqBentywTR7S1Ny/sEHm2qErLT1u611VxasDAc?=
 =?us-ascii?Q?Ua5xPFlcp8ltsKKGnWf8In6aYrnHa20o2LCsp8rV2Vv0DgbckCl2GpphO741?=
 =?us-ascii?Q?sVZLXSb33LF7fzzj8lq3o1ZlZ5a20dssoG6SPnVN687so7e5GIabTn1S0nQ/?=
 =?us-ascii?Q?JUTrtoJ0fIxRfkzx/pippzU7/jRfg1wXZxCBMLAJ0U0h9bMxzQh0x0kBnkzJ?=
 =?us-ascii?Q?nZda91JfiTT2mIP2zEKLj1Dv+u9tgjDQZXsMwLI2Ey/R86oY6JoC8jbVgQ+V?=
 =?us-ascii?Q?au5pmrm2vUJ16xGcpRlr+b5UrjTHYxK0wx8Y6q85p8jx6jBXBn02TXHP98qw?=
 =?us-ascii?Q?YrhLcC2yEKg3ppTeetefiqnNXIhTM2+iTzQW6FLlp28xQgIl5CjKvtacstEy?=
 =?us-ascii?Q?Ttb9MZJqBh22gzP3vM8fRLKflQuON+UWV4zSm/MFhxKPptvaLQvrz9LXUwsH?=
 =?us-ascii?Q?UfsM6MNwCBLEh0LAx7GHi1KSKuXUb0iBEm8XlryqbUJcvwC9eMqhmVLo6ona?=
 =?us-ascii?Q?RL62HZTAgOAJm1rexmgq6oNb3JTGC9Pdtrx5MzY6SVJgVG6GiqGhq9FJyUqY?=
 =?us-ascii?Q?aWd7g96f2lQ6sLYGFceMWTf+icCLiUgIkgufvwZJUv/6VE1P+xyEyFQQlAid?=
 =?us-ascii?Q?hkdY/vQXQyT3hYYn5ghTGaiUZ0LKztdA0dpjiLZBFFGOLN7EXqxw4sR/vFWv?=
 =?us-ascii?Q?kxhxmPMNc4t+qNjMRbR1jTYf6OTWLQM0zWGaovgeLnTZIDIOrNny3eAES24V?=
 =?us-ascii?Q?QJwofWAXCHE5HI2X+DG6wXJGufm+Ntb7MMFbtJycknofRHDx54ZME0T4eEJI?=
 =?us-ascii?Q?Yq9+yjWppN/P4ZgNM76MROI2QOc3nsG13XXNo+lmhgLpnCjl1DMXIOYj16Gi?=
 =?us-ascii?Q?GldYKZEHfX2BPsZ8A/KF/kYjjqJ4xwT5Cbp0N6iq9ZbvhQnpAUNs+/uF0yUi?=
 =?us-ascii?Q?T89GAL+v5owz3Qhp2VQno921asFtxUz71WM/NN9j8t3KNN5WzON4CtRTFfmc?=
 =?us-ascii?Q?Shmw+2RLZ4N1oSKaOGtiRgithXvnmNtN6AxSNaQPF21nswP4/8lIUjDHlxuu?=
 =?us-ascii?Q?darmsOP7GxwrrTuivKRwnT3iZETOKxtSseoa6eyyJZFJ/+ltKhY1ZntSI3vj?=
 =?us-ascii?Q?mYOUIdDQo6uE/h+TXQIomFc97UQ4A3e3vH/iU3VTvbjdmc3/QJH3gZW6/2zt?=
 =?us-ascii?Q?vTRnGLcD3ZTqXsVlHmziCd9ZCbXopat6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:42:53.3586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e61beb-b0d2-4c2b-41a8-08dcb7b8628c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133

Unconditionally calling the MPIR query on BF separate mode yields the FW
syndrome below [1]. Do not call it unless admin clearly specified the SD
group, i.e. expressing the intention of using the multi-PF netdev
feature.

This fix covers cases not covered in
commit fca3b4791850 ("net/mlx5: Do not query MPIR on embedded CPU function").

[1]
mlx5_cmd_out_err:808:(pid 8267): ACCESS_REG(0x805) op_mod(0x1) failed,
status bad system state(0x4), syndrome (0x685f19), err(-5)

Fixes: 678eb448055a ("net/mlx5: SD, Implement basic query and instantiation")
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index f6deb5a3f820..eeb0b7ea05f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -126,7 +126,7 @@ static bool mlx5_sd_is_supported(struct mlx5_core_dev *dev, u8 host_buses)
 }
 
 static int mlx5_query_sd(struct mlx5_core_dev *dev, bool *sdm,
-			 u8 *host_buses, u8 *sd_group)
+			 u8 *host_buses)
 {
 	u32 out[MLX5_ST_SZ_DW(mpir_reg)];
 	int err;
@@ -135,10 +135,6 @@ static int mlx5_query_sd(struct mlx5_core_dev *dev, bool *sdm,
 	if (err)
 		return err;
 
-	err = mlx5_query_nic_vport_sd_group(dev, sd_group);
-	if (err)
-		return err;
-
 	*sdm = MLX5_GET(mpir_reg, out, sdm);
 	*host_buses = MLX5_GET(mpir_reg, out, host_buses);
 
@@ -166,19 +162,23 @@ static int sd_init(struct mlx5_core_dev *dev)
 	if (mlx5_core_is_ecpf(dev))
 		return 0;
 
+	err = mlx5_query_nic_vport_sd_group(dev, &sd_group);
+	if (err)
+		return err;
+
+	if (!sd_group)
+		return 0;
+
 	if (!MLX5_CAP_MCAM_REG(dev, mpir))
 		return 0;
 
-	err = mlx5_query_sd(dev, &sdm, &host_buses, &sd_group);
+	err = mlx5_query_sd(dev, &sdm, &host_buses);
 	if (err)
 		return err;
 
 	if (!sdm)
 		return 0;
 
-	if (!sd_group)
-		return 0;
-
 	group_id = mlx5_sd_group_id(dev, sd_group);
 
 	if (!mlx5_sd_is_supported(dev, host_buses)) {
-- 
2.44.0


