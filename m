Return-Path: <netdev+bounces-130803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF28E98B9CF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF6D2832EF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776C51A0AF2;
	Tue,  1 Oct 2024 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BvAMYSF/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA719CC08
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779084; cv=fail; b=rj6bjQnSAuxWZFmdw88qQ+Fkxg+VTOmFzN17nuiErXUsWcIGVAsgXqK0iCl5PgzkqSf979SGUR8pMB8rhpn1td3Kprrs8GjpojdKH5gwYGqK3COLNdAmHNFvDoMrN5pmcWsSOX965zbabLO9rmnIqLilNfCktUsnjUtDTHrAvKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779084; c=relaxed/simple;
	bh=TKY/buyhaJrAkZOWl86+E3prr3fKHqCHcaSMpsRrSvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2XpDjLEMzKT7JOWdsn8Hl4EHyfa5fTyirJUPIucmLo27USdftyaxkaXKIRCF7mWMoxz2nSL7t6z4KId/zYukWQTGgp4RqAXN8+TrbT4bincQuVEI68qcuxHodbE8uuR8gr/EOpoV0CvBqrxEGT050aDg6cqw6o/W8DXLk85E60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BvAMYSF/; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErGbZW6zgRdVkVtHarWm4c38rQfv9XB90g7+Gl18lt7kTmHCV36DkiOahsHUkvuXZAyK5p0+zcfJrrPqKou6wYOVC5N/KbaMK8iFhtY2TCHuJEECA/8Mx0fVbrjTiH0ol0e9FL+5tHaLqlmyN5i9ya3bg4H5k6t/Ovk7Uynd322Qoo7sunUGc7Ip2P/grBM5wVm5k2JEr/RMCafAjPKUtSHMiS2ftzWOGBJDWRNt7ceGmNwoKvaG/hV0N6g2602hOilTWMBRweANApvWKXEn5arVElptmhw9O79uZKCWH1DZ0CmID1awOW6lEThgOE8oQaimaWik+iRxZ+PBOitGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jH3QfNSYs8bgAa+N9PUNOrQQ8fgi8985NoRHonJlGA=;
 b=jrhZQqWIJwUFvYST64bGjcIXxXMZRUNtPBtG+HTIwMgtpP6vHjNcWYJKf/Gbs1BWhNNeunoItSAzg4MiCglhI2NQN+OO1YmluV/eG8+b5H11kx8DIGZysDyr36dGmQi64Fht5CxRMDdctSRwH8+Kz+91fN99KW7axSHP/IiAHDiHHfI3mmOxKTyKOxMceJPMNMSSXMym47nhyM2mV65e9b7SLJxBD0VFhJ1gS3h5mptLC17QaaRxTibXCnQvOs7rYKfBr5zzfRP/PcRdVu7CvN+03fPDy6F+/rCGVotqVdbO3sBYmCu3qk+fAFQ6SWUZHL2+B+LMppQzp3zDeJwknA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jH3QfNSYs8bgAa+N9PUNOrQQ8fgi8985NoRHonJlGA=;
 b=BvAMYSF/E4CR2GdxA7CfpROS5OPnzmdZjLNC5MoMDMKjrBjlSlpPq2Rb5DQsCiXNQjC1gj0HUkQfWxvASv4g1913/FcfAFSkI55KCOKujnBMRh26zqMSiX6s+vkXyYSx2Xj2L+rNcRGevLf8TzRXAibrFwZxsMDORYlNcB4Kh/Gqmv6EhTO+wAFviPIJlVGffWkTgAowKduGl5FxOpeTugpE9CmFJEQLzJ+/+pqN9olecZCI5aAZrsCdDGRQQarp3aWXAm1AeOjJY3buIOXe4HVs8oGrnoZXfKBFIeXdGi5wNDUqIMTODmr5hl+Xnv5wToHvrnhAXkZJOFUtL6OHhw==
Received: from CH0PR03CA0395.namprd03.prod.outlook.com (2603:10b6:610:11b::12)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Tue, 1 Oct
 2024 10:37:58 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::a9) by CH0PR03CA0395.outlook.office365.com
 (2603:10b6:610:11b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 10:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 10:37:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 03:37:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 03:37:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 03:37:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Simon Horman
	<horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 6/6] net/mlx5: hw counters: Remove mlx5_fc_create_ex
Date: Tue, 1 Oct 2024 13:37:09 +0300
Message-ID: <20241001103709.58127-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241001103709.58127-1-tariqt@nvidia.com>
References: <20241001103709.58127-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe36fe5-5854-4cd0-0727-08dce2051d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hvXAJ8mdD3pQshEETlHcYz6vrvZFGqtPWlZN89feiLgQHS8b6bCuj8YGZcMi?=
 =?us-ascii?Q?2HWTWvoP69v6GHcxeOlPJCAUNHm5Lan2vtw34Tg74Tb1htA411tFk56+4cPo?=
 =?us-ascii?Q?9vgEArGNVBTJTEEQJh2L7UcMBTYqgTjjpClCgHRN/CliRNEaZOIgA2wLdj8i?=
 =?us-ascii?Q?O3aNMT76+0Jk1aBsG4Ta4I63zhXqpUfgE1/t8KW4l3PDsvqkdeGvO5A9MuXH?=
 =?us-ascii?Q?69TqMVHhWtR9Do9v5qBckfxXFvjoxANSlxZHhyKkYyLUepJRtq6+PinuxsOh?=
 =?us-ascii?Q?FVtd9tm7rmeAap88IMDf6XE2H8sk+2zUVy3zp+Ka01wW9bPIVFGWBOtbhnt0?=
 =?us-ascii?Q?ZM1Bo6fTyj51dZNYBytv6AfgC5BWeGJY0NXAJ6YtQLyRN3yUOtzIZfAGinxJ?=
 =?us-ascii?Q?P6d/6MEyvCkz9Dr5Rfrk3CCEnwXV/AiBoL4mrxIcxzBxXY4eYcnfsn5AUIVt?=
 =?us-ascii?Q?I5ruH/IYmKZdUlt/YsOhHL1lW96K/D2n2Ix2w38jX6Y5g8Q5XdcmdMLz3/Ig?=
 =?us-ascii?Q?xpscTq+1+pupp/vv37gBWprESvG5rPZ6aYL8xuAl+/hWnOoG4iKD3e3WGTga?=
 =?us-ascii?Q?7g44q9b66ITvAvKRDpjmLTexuEw46ObJ/2ze27uMumuzERlxrRooWD0S53Ez?=
 =?us-ascii?Q?I0C2AtGWJHkdvPZq7xOIgKL2Nq+XxihEyH7TfxqTYa/HqS/ivgnRgai+nfFV?=
 =?us-ascii?Q?bkNHPbOefRHfpCHd/DguWkCPoAbY5A4vupsjtulWMSOx2UJzxMTGHE5ndfYS?=
 =?us-ascii?Q?geR+CcehzPLwC/QarPp9hOTBdM1qv3JpiidP7PicMQacbxhJt4TwttQY4ZDL?=
 =?us-ascii?Q?cnZAc5hKvDx/w2LzNSkIwo76j3GOmUl1OoO+xbO1n7vNY6JK3TpeLLQDfi/e?=
 =?us-ascii?Q?JEAP3akIAeEX5m1OwR2JaK041koGPJNgdKv7SJn5f6+eExCpbSSRACnwOX+e?=
 =?us-ascii?Q?JxVjOm2j7//9blgb7ASHXIybbraMT82n77sKLQ9CNwTbAgM5I/F7FiqzSdmr?=
 =?us-ascii?Q?8n4sBvjuzuCWP/bbjnEl3aV8IdVxPE1/5yPXIiRCi3Ou7JN4/4+uA05tbEp9?=
 =?us-ascii?Q?Y2Y24xCj3743L/CGVunxxlbCrtizM+FHgOhPlcz+MTdqXoWfaZzQ8cpmVpis?=
 =?us-ascii?Q?hQSopRYwhOqpegh5QLK574xRCWlH6u+IXNxRYgjicUvPKaI0cNdH4Sb3+Cv4?=
 =?us-ascii?Q?6smBRZMSrBC4Emr48uRZDqySIiK4XBQyJa86b73L8gkKGkvkGc3yTcXDsBqT?=
 =?us-ascii?Q?Bt7zZsmIVyjpYqEhvq/Amd0yeij2LjLhTLj2TgSCB3pKEQHexMNlsxS2gGm1?=
 =?us-ascii?Q?fj2dfuUtBmSvLoG+qY/ROhUzkwpg8UveFI3GpGr7/GIrEIB1D97GTECa+I53?=
 =?us-ascii?Q?dcst0RU5rxKSlD6ZRBWxTDvnb3f2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 10:37:57.3227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe36fe5-5854-4cd0-0727-08dce2051d58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960

From: Cosmin Ratiu <cratiu@nvidia.com>

It no longer serves any purpose and is identical to mlx5_fc_create upon
which it was originally based of.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c    | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c | 7 +------
 include/linux/mlx5/fs.h                               | 3 ---
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index dcfccaaa8d91..4877a9d86807 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -1026,7 +1026,7 @@ mlx5_tc_ct_counter_create(struct mlx5_tc_ct_priv *ct_priv)
 		return ERR_PTR(-ENOMEM);
 
 	counter->is_shared = false;
-	counter->counter = mlx5_fc_create_ex(ct_priv->dev, true);
+	counter->counter = mlx5_fc_create(ct_priv->dev, true);
 	if (IS_ERR(counter->counter)) {
 		ct_dbg("Failed to create counter for ct entry");
 		ret = PTR_ERR(counter->counter);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 0b80c33cba5f..62d0c689796b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -275,7 +275,7 @@ static struct mlx5_fc *mlx5_fc_acquire(struct mlx5_core_dev *dev, bool aging)
 	return mlx5_fc_single_alloc(dev);
 }
 
-struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging)
+struct mlx5_fc *mlx5_fc_create(struct mlx5_core_dev *dev, bool aging)
 {
 	struct mlx5_fc *counter = mlx5_fc_acquire(dev, aging);
 	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
@@ -304,11 +304,6 @@ struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging)
 	mlx5_fc_release(dev, counter);
 	return ERR_PTR(err);
 }
-
-struct mlx5_fc *mlx5_fc_create(struct mlx5_core_dev *dev, bool aging)
-{
-	return mlx5_fc_create_ex(dev, aging);
-}
 EXPORT_SYMBOL(mlx5_fc_create);
 
 u32 mlx5_fc_id(struct mlx5_fc *counter)
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index b744e554f014..438db888bde0 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -298,9 +298,6 @@ int mlx5_modify_rule_destination(struct mlx5_flow_handle *handler,
 
 struct mlx5_fc *mlx5_fc_create(struct mlx5_core_dev *dev, bool aging);
 
-/* As mlx5_fc_create() but doesn't queue stats refresh thread. */
-struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging);
-
 void mlx5_fc_destroy(struct mlx5_core_dev *dev, struct mlx5_fc *counter);
 u64 mlx5_fc_query_lastuse(struct mlx5_fc *counter);
 void mlx5_fc_query_cached(struct mlx5_fc *counter,
-- 
2.44.0


