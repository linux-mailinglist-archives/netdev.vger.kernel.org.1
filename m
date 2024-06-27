Return-Path: <netdev+bounces-107419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D92C91AEC1
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E64B251A8
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6677A39AE3;
	Thu, 27 Jun 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PdMjuwgD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E419AA7B
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511493; cv=fail; b=a+N/QHkTGNuwN1pvSjoAMc3P7D+2YPZ5oaTBktBgPfF7aATsNYRdAfsR0LxHekPeIGYJjhQ9ZADj/wov6KPjdGxKym4vITcgylt0W8f5n+JHjPzo8QFj2+KQAze1vgOyagrh40TzzptqnRFU0B5v5Xn/wXm6VN5cZ0PCbazp5ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511493; c=relaxed/simple;
	bh=LStAbE9vpO/sIAT/4See3RWQmxNTtiVg9lDExW0cLOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAcxVUeiOFWukSmWQcTOyl+7MTlfUcqf64rCVbH7OZULsZ575mMZIj9Jt468FIiOUE7fhF7oPRDAYeYeqRsvQS0vm02l0RqDHoQROeNzJcFTlmMYvsccjDCLEes67jSnNL08WOYPipTV0tv2qjfbY5NldYxEelcGRzbZryuQ0p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PdMjuwgD; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Txg39X2UgVjfGE/Gle0V6vz8t2ETBySIUPoOiR1kzna/aJv0usoRyh7CWtBQww5usF67xiOVsHZaSa/MplqfHu5s27cJ6I88LDxioXhzhpUGalHinJ49g7q+rFhpw6Sh6PalZwL0TTKq5lldDnmJMlEBvCsjlB26U+43YCdWSRvUXm4s4SUuPnBFeSBzoXx4Qp2wLOWHvNStkPymhcQ2kcLXGHRGmz4ny0d+ZpA5CWkNDXbHH4j/lM5q88FXZn1nPtlMVVO4GMMAd2qbD1+S1pX6Lqtn8F4ij0dQvnP1LHOaTdSvzur8/2iseMD2CwtihOli8agl/ZrX4lYXo9VAww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3PKK+BN3vPx9Db4iy/hS26Whh5E64+zPiV3w2Wl4vA=;
 b=ScPqPQKmdrb6S2jTAr68ot80J7JrW+XkLwZ2kSSM88NSipf8mBY3DGLcELJYlSEPA73uijbm0TAajdkjpQukr9+WDy5NMTSBkk8AhloIq+g2q3v91aNrscZA3G3ncDSKS8lMqTlBvjgKFG1YECO9boW7DG0H0bg+sAWXxtLdAEGdSsp9kbj0rXqs8NahoQtKxMD+c3EWv/Smof/lL/zNVBkJeIEygsH1+nfykPi7PsOwDKD8hFwPBpUWQXMmq+TBh1/Jhtmgjxw6129P8uHo9ise9k6fRnPOfBWUJU1kAamq2Z6f4Jm1+KWUkslkTftobhfYPbYXMv0ndUw6fIVlgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3PKK+BN3vPx9Db4iy/hS26Whh5E64+zPiV3w2Wl4vA=;
 b=PdMjuwgDLmm3GOA6i23EVgWYIy4RKn2F+msD9xYly5hRlsz53iHpTgfzvwkoSxafNvfL5ozXjRzvwqrR+HQg09Za7Q2aIVWY5Dd7HJEiDZ5ZTrpDgE1TDuw38enDD7jKTOfCjs07RvCwAMb/um0pJbp/LuAwBYYJ5RbBygKidgYWE50z7InvuOVdRXbW1oIwSW5s6uz3vZ6x16OrbuUH2y9zMDhU66XL4Z36yz1kz3f3WUMdoR6ajjQIOxaCEPAjV+FWCA5+nG388oPbIMVBp+gvCb53/1cPXuikvQUnJVBsExIprukDZmiH/KUh5/owML+XBNaHhhYSIOQ5omZPAg==
Received: from PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::19)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 18:04:31 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:510:32b:cafe::44) by PH7P220CA0048.outlook.office365.com
 (2603:10b6:510:32b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 18:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 18:04:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 11:04:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 11:04:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Jun 2024 11:03:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, Parav Pandit <parav@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 3/7] net/mlx5: Use max_num_eqs_24b when setting max_io_eqs
Date: Thu, 27 Jun 2024 21:02:36 +0300
Message-ID: <20240627180240.1224975-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240627180240.1224975-1-tariqt@nvidia.com>
References: <20240627180240.1224975-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7355ea-124a-46ea-518c-08dc96d397a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kV+kGYnn3YwHYU8jxquxdHUEyLMU0szGZQNLLf46f76FdRUv+WdEKLNQZ0rB?=
 =?us-ascii?Q?kLxulcTlNR/r2x99tHli4LrmXdLH6vfLecjAu53G00Z1AN+qnPzxQwfgWh1p?=
 =?us-ascii?Q?/k01x9yu8RB7xXui+vrTx8WNh4nsSKGWGfLFra1aHhdUdjfQuAClVcfRyMag?=
 =?us-ascii?Q?tidTpDInpJT2+b3V5zy1R6szTaAx+LhncE0tP7pWr0jcDSQB06IiKICGhdIM?=
 =?us-ascii?Q?cSO2lZ3qhMKRKlucIgZeKR72p16PTlcJxcFLYD/C9bHWdBjs6M1MU4bBpGQI?=
 =?us-ascii?Q?2CyzPr8djPI7gSHLcuDSXA7OvaXl1nsk0E2N2RTBn0XeTXm92E6HgKTuiGnz?=
 =?us-ascii?Q?viBTr7CNwYHUaceQQ4LuLpoGcy8aUXk36oaUb8SGKDKBHPUfbyMuL8lqvPwg?=
 =?us-ascii?Q?r+4/tXmMT+CvXoGATUltMl3kZ+g9J495+1Rat5ei2U9ZL+1cNr5DY7Oqc6d1?=
 =?us-ascii?Q?05im62BqbWS9RgbNaJ8wnRR8SMxj/kYGsKB9bbu/7BucnvnOQU7AwGC+yRco?=
 =?us-ascii?Q?HN8glU408OsBBYUalNke/zS1D8qCIM9fQaCYCEPqhDyiE/av4qGfToQvZdjQ?=
 =?us-ascii?Q?h4Fhk7bEx3OoyR0rsMV3IC8v4MfqGTzl+Doek81nGaPI2SkbQ5DNzf3faqs2?=
 =?us-ascii?Q?hf9veLcssiueQXD2P76IQmKPBofAu9z5CHjVlxUEVxk3rtTkUkZMcjKlZWRS?=
 =?us-ascii?Q?9i9NjeXdFkFUfApskgxsZgQWJdEI+FgjHI/iKhV4MUoWGqe6iORHx4zlh9fH?=
 =?us-ascii?Q?aWz6shHaHTrGNsGVv6DU5Oqp2bWlvnKAR3qfrsWoiP2++tJwGI1nXxUpPipg?=
 =?us-ascii?Q?YNoGu7eShgWwlC6APQ1q247meGEgRk5mqhYdkaFae3zn2WBncUy3xNwFVD66?=
 =?us-ascii?Q?HqUHhUwB06fZnI8ok0TeQooRPAoERVHrkpdFOj5Lww54Hhc361iXtX9F5+N7?=
 =?us-ascii?Q?c7SfiPd+b8yhNI0+QABHGyP5yjW2zlkBYDPet+J8u14fwddmWGBRb55gfzGT?=
 =?us-ascii?Q?QRejERu4k20MOEheh3dlIKI/Iz38EFxdRHhvX8xNQjvQ9RyXVxElI2hZjcX5?=
 =?us-ascii?Q?T0V9PUt7/BN9vbkDuu0/za4nmwpTkiKNpxZqmPTGc5Mb1r5AQalbz+2bZMOq?=
 =?us-ascii?Q?4MSZefBbQ4uCpZPHqejbMjW2gIWjfuCAprKacFSc6s/PsNQj4delUN4lvNTv?=
 =?us-ascii?Q?bzQJWgH8wAp145kh1C6lpo9OUFKqvw7sY2YZin1Fi20TcmPg2UY2TcUYv+8M?=
 =?us-ascii?Q?7KpNg+3PIYdhHtfYhhvnKEhqLxorrh+4HCUaJSpCbC7ttu/1GVrPnvNqRwkK?=
 =?us-ascii?Q?CIYCmM2UO5tyZjAvyXAA5j3gpZh2cECPFUDY48KN69/xJW9QmyOU8DjgSpbc?=
 =?us-ascii?Q?V/q/GkZFV+L5FDZ+K+xzvbVGlGQijdFLdMYjvItw8l5xlSoorVvbhc07554J?=
 =?us-ascii?Q?MzwxVBqcbBoduwyBs+YFMknE2sHSWKBg?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:04:30.5133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7355ea-124a-46ea-518c-08dc96d397a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

From: Daniel Jurgens <danielj@nvidia.com>

Due a bug in the device max_num_eqs doesn't always reflect a written
value. As a result, setting max_io_eqs may not work but appear
successful. Instead write max_num_eqs_24b, which reflects correct
value.

Fixes: 93197c7c509d ("mlx5/core: Support max_io_eqs for a function")
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 592143d5e1da..72949cb85244 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4600,20 +4600,26 @@ mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port, u32 *max_io_eqs,
 		return -EOPNOTSUPP;
 	}
 
+	if (!MLX5_CAP_GEN_2(esw->dev, max_num_eqs_24b)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support getting the max number of EQs");
+		return -EOPNOTSUPP;
+	}
+
 	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
 	if (!query_ctx)
 		return -ENOMEM;
 
 	mutex_lock(&esw->state_lock);
 	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
-					    MLX5_CAP_GENERAL);
+					    MLX5_CAP_GENERAL_2);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
 		goto out;
 	}
 
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
-	max_eqs = MLX5_GET(cmd_hca_cap, hca_caps, max_num_eqs);
+	max_eqs = MLX5_GET(cmd_hca_cap_2, hca_caps, max_num_eqs_24b);
 	if (max_eqs < MLX5_ESW_MAX_CTRL_EQS)
 		*max_io_eqs = 0;
 	else
@@ -4644,6 +4650,12 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 		return -EOPNOTSUPP;
 	}
 
+	if (!MLX5_CAP_GEN_2(esw->dev, max_num_eqs_24b)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support changing the max number of EQs");
+		return -EOPNOTSUPP;
+	}
+
 	if (check_add_overflow(max_io_eqs, MLX5_ESW_MAX_CTRL_EQS, &max_eqs)) {
 		NL_SET_ERR_MSG_MOD(extack, "Supplied value out of range");
 		return -EINVAL;
@@ -4655,17 +4667,17 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 
 	mutex_lock(&esw->state_lock);
 	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
-					    MLX5_CAP_GENERAL);
+					    MLX5_CAP_GENERAL_2);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
 		goto out;
 	}
 
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
-	MLX5_SET(cmd_hca_cap, hca_caps, max_num_eqs, max_eqs);
+	MLX5_SET(cmd_hca_cap_2, hca_caps, max_num_eqs_24b, max_eqs);
 
 	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
-					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
+					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA caps");
 
-- 
2.31.1


