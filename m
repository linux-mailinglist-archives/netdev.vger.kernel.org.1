Return-Path: <netdev+bounces-116105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C3E9491C1
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5E51F21F4B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8D11D47AA;
	Tue,  6 Aug 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bqsONWQ+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42461C4622
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951599; cv=fail; b=BSqYPa0SuhfpQzsAfo7akAz6ez8ad4H+gLtDDwC/E8TIznWQD7cL6Nm4qv4igpKB3qoA4dml2D15ZQSh9GHta2urcm1OC1d6B2wIPGuL0eMGvSGfA1f3yfDfKftWjvdsXzkQecZ4UKG1jRayeTKRZ0d5swDSRiWrnmIIEndr7Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951599; c=relaxed/simple;
	bh=0U8xYOqNwFaft+c6ZXZVcDB172Dnw2o0Sh5JpJ3gZrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rV4nKn/+aeZ7qkYi1mBSuraHtBtQ3NNFUwN3QZQzYvFa0fsWVV9ET+ohlxWB0YMpvlhrjOZxLwoE5vHMN8F/8Eg30A1EZztNOdIicftZTBP/uJ6jv5mc2B8LlQ9XhbMx9XaSyQzskjZfU5dQn+zWiS4YlZJlpqUuasNV5iFp3mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bqsONWQ+; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxHjlPA+Im8/MMrK2+8r/IYrcDjPIV79uYCEHJUDU2gOv+vt78qS7tEitnL0hbi81TaMZzdvxi4XNNDhr+hMVs+AK6uyP1uudodovXWJp/fXs5ZGlKfKx8PjixRQOo9fjOQr9Igu2LhsecXfDid9CiM98/R7CSqoL3Pk4iTkKs5w7zoXN6hipts5KAXrMWhqEziM4QleYUjQZlA9VW4NmvbkktfS8DNa+fifJ3sivpCEOYPGj0NheVKHiP2Xer8E6kCqjw1yoJ53xiY6h+Z7+RiT6TtS6bETCZm02AEs860682hp574ChO/gXG60QHIoEnOURmcCq6zlC+rwIRzSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftQZCRzAw/XMcpxvhNLEX70wxbUeedk3pIzb1lwNJK4=;
 b=zGps2CO8YhWzGdKcBDevhu3IMtCuGXNBoJNiTGqcjTvJFGGgmCOl/lWvXoXoM8luuqsNGugUyaBzTfSvQMOt6AzQPGLOH36zdKsG5JbB/q3MGjDa2zHshgYziHT6csnB+sOGLKCfYy/7vqN22wY3m0ua/93rNpv49NVakQMdVV1jT5TNAIjuIbaUd1E+vuO/56Y2Y9tulIBaENBKnIS3hw1pCmhrhyBdPQVk1sBiR2uQJ5Wn3AWkMg8D+aI/6GoG7C264ZoxQshpPEuhLEm3LTeCQI5UIQHoFLZAutoVadt5BKN4yC0bLMHeqSOduoKgMZY02lZEmzY5lrcQzwgSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftQZCRzAw/XMcpxvhNLEX70wxbUeedk3pIzb1lwNJK4=;
 b=bqsONWQ+HYuoxGBMCY+Sjgj/EVQzDv18a/lOu99ZUq2L+tfYGmWDR7tmEawtwvr5vYLeEkFjncmrTcvPY9O7GzuBXa16QLJENCMmCJUVn02mohJ4v6exgPXsje/jbCakr1940e5tbZMaXUuFA5UMufAqloRh2exN506HxaI/GEYaKdgrC6uSFDixBc1RZ8qRPhO4R2SgWhdInGPOlK+0twnKQCIimKp6vWvLdDNLBUKKzqqWgh4pr0tKNAbH+5qvhFKAYj6yaX4ziGbN7wBmALbKpwkEAxBd0OKDKTtAai7qWMAft1/mcA+eNm/eqJ8mUZkleDKT2KAo0lU+h6knhg==
Received: from BYAPR06CA0018.namprd06.prod.outlook.com (2603:10b6:a03:d4::31)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 13:39:49 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::cc) by BYAPR06CA0018.outlook.office365.com
 (2603:10b6:a03:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Tue, 6 Aug 2024 13:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 13:39:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 06:00:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 06:00:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 06:00:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 11/11] net/mlx5e: CT: Update connection tracking steering entries
Date: Tue, 6 Aug 2024 15:58:04 +0300
Message-ID: <20240806125804.2048753-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240806125804.2048753-1-tariqt@nvidia.com>
References: <20240806125804.2048753-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: e205d781-8913-4211-defb-08dcb61d3d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xYlyfCOVOsFjkJMiXxUsm+AtZ3DPjMcTRQ2DlsyNiHQwJP2OQU6rG1Sx+YE?=
 =?us-ascii?Q?aV2FqWGeo9rfmdmyr2v+zsDopxoEkwHjGCzmURzv8iqMIJO3ME1/g/ECBkDC?=
 =?us-ascii?Q?40bJPKcYyMPfFzPkQHzBDyb8nFrn+Gkl38r22GHj56Ecms79k5540Y+a5Ucw?=
 =?us-ascii?Q?ZBTFQw9GU/gUBtTA/dnNwtxoa9cXDZTgjfe6qwm0UCb+BiOu1wNPPlY7/2C9?=
 =?us-ascii?Q?nc6OmFMoPw1+St73K9JHorQCaOUtDsTl/aQm2bU7USg+h2v50OEX/RN/ROv0?=
 =?us-ascii?Q?gqwrFXkI7uJ9pK0gyzFQywAeAh0ZAKCb5wIxZwva9lSefebNfeljyWMcKECJ?=
 =?us-ascii?Q?NSd/YK76SbTy+4nMrWhmooXDUU/ldTmV8+d/1UXWXvwzt8ueHFxJjjjebePC?=
 =?us-ascii?Q?5RG6bXpxWPbVdYBfv6cWtFpJ1Ql7cB1mH8IHr531n0vZnBgY2wxCrh18LPWS?=
 =?us-ascii?Q?1YvJ2lJuKlGAEZyTZYTUw5IkjNsBHTz20lGOMPBZN16fLa6yTZzxnRiczj+Z?=
 =?us-ascii?Q?aIWGXBmivBy7WzuXGnRMiCYnigBE57RZ1DQu+DxWlSX71q1zh1OsDqycZpWf?=
 =?us-ascii?Q?9qphwxCDWmAlFJAQfGZ4vxVfk+U0j8Ar9ypGRALOdvJTPG7N8noRljrGm1oQ?=
 =?us-ascii?Q?ekkqNdrFxpO4EBB90spc5rl+4hZTdIGRA6SpIMp//fNypHC1OoQagkIncrrx?=
 =?us-ascii?Q?FJUxN6njgpW2dbqBJsX8kYmnhNfcCVAp+wmiXIXP5ZjAhWkRQ51MgPjxY49V?=
 =?us-ascii?Q?9XqUzkCWk5ZMtto2p8VZUmwo67f8SVasbg/k9G7xfYh4stxtuDGul+6rfk+v?=
 =?us-ascii?Q?GMryUMgSHkjBQZJ6k50WIB1HQd3bCy/eYpqloiX7exY1YNd7DjQCncW2tZIb?=
 =?us-ascii?Q?fRioejLS5LqczkKgRLJk9m/2AGGGC/JadY0k+uVsVwihznzwIPjJunfc2+Wt?=
 =?us-ascii?Q?Qu85zGqviWAnadcMrAaITrjF4Tffy7ixAim+13epPOTeU7FhXIs+kwg5jMId?=
 =?us-ascii?Q?1VkfdIZxJ/0sMx1aAbBUbvPm5TYA+chthgornAl96o73bfgUhc2f/JzykGM5?=
 =?us-ascii?Q?DxA/ybLFPOO6GF9HSgIrCQiGWZQFBf6KmEsmLu2mNPjk9ge5dOVLoHibs7+O?=
 =?us-ascii?Q?1m/g1zzCUWa1LmAbmiyytbIWoU5H55X0ofytLpx2KivRC59B+ZJN3zsSM8AH?=
 =?us-ascii?Q?849Osq8rFZTlEXpMUWisTAv5pfGB+1ekyFbhZC4fQBNpRVwC285nD6ZFRXJI?=
 =?us-ascii?Q?mFnTq5y/dmaGADY26jFa+WpfSVyIbozWTnDMLstSPxToAVHwm7HVKIqi3rXg?=
 =?us-ascii?Q?3wZUDIVel1/O3DNRBJaxaXVbMNK3w6zhQDPYwG6m83cHtr98eCiGUwpaHxMF?=
 =?us-ascii?Q?KZQLNmAiMB/CQzkFtAmog6WXFvwl8+fIzNE0DKQ07ml+rLxeDY0mlN3DntPs?=
 =?us-ascii?Q?qA1r7/I3Dv3B4f6lFIw494fa0hC7n3cf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:39:47.7625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e205d781-8913-4211-defb-08dcb61d3d4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690

From: Cosmin Ratiu <cratiu@nvidia.com>

Previously, replacing a connection tracking steering entry was done by
adding a new rule (with the same tag but possibly different mod hdr
actions/labels) then removing the old rule.

This approach doesn't work in hardware steering because two steering
entries with the same tag cannot coexist in a hardware steering table.

This commit prepares for that by adding a new ct_rule_update operation on
the ct_fs_ops struct which is used instead of add+delete.
Implementations for both dmfs (firmware steering) and smfs (software
steering) are provided, which simply add the new rule and delete the old
one.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs.h |  2 ++
 .../mellanox/mlx5/core/en/tc/ct_fs_dmfs.c     | 21 +++++++++++++++
 .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     | 26 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 12 +++------
 4 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h
index bb6b1a979ba1..62b3f7ff5562 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h
@@ -25,6 +25,8 @@ struct mlx5_ct_fs_ops {
 						struct mlx5_flow_attr *attr,
 						struct flow_rule *flow_rule);
 	void (*ct_rule_del)(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_rule);
+	int (*ct_rule_update)(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_rule,
+			      struct mlx5_flow_spec *spec, struct mlx5_flow_attr *attr);
 
 	size_t priv_size;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_dmfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_dmfs.c
index ae4f55be48ce..64a82aafaaca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_dmfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_dmfs.c
@@ -65,9 +65,30 @@ mlx5_ct_fs_dmfs_ct_rule_del(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_ru
 	kfree(dmfs_rule);
 }
 
+static int mlx5_ct_fs_dmfs_ct_rule_update(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_rule,
+					  struct mlx5_flow_spec *spec, struct mlx5_flow_attr *attr)
+{
+	struct mlx5_ct_fs_dmfs_rule *dmfs_rule = container_of(fs_rule,
+							      struct mlx5_ct_fs_dmfs_rule,
+							      fs_rule);
+	struct mlx5e_priv *priv = netdev_priv(fs->netdev);
+	struct mlx5_flow_handle *rule;
+
+	rule = mlx5_tc_rule_insert(priv, spec, attr);
+	if (IS_ERR(rule))
+		return PTR_ERR(rule);
+	mlx5_tc_rule_delete(priv, dmfs_rule->rule, dmfs_rule->attr);
+
+	dmfs_rule->rule = rule;
+	dmfs_rule->attr = attr;
+
+	return 0;
+}
+
 static struct mlx5_ct_fs_ops dmfs_ops = {
 	.ct_rule_add = mlx5_ct_fs_dmfs_ct_rule_add,
 	.ct_rule_del = mlx5_ct_fs_dmfs_ct_rule_del,
+	.ct_rule_update = mlx5_ct_fs_dmfs_ct_rule_update,
 
 	.init = mlx5_ct_fs_dmfs_init,
 	.destroy = mlx5_ct_fs_dmfs_destroy,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
index 8c531f4ec912..1c062a2e8996 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
@@ -368,9 +368,35 @@ mlx5_ct_fs_smfs_ct_rule_del(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_ru
 	kfree(smfs_rule);
 }
 
+static int mlx5_ct_fs_smfs_ct_rule_update(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_rule,
+					  struct mlx5_flow_spec *spec, struct mlx5_flow_attr *attr)
+{
+	struct mlx5_ct_fs_smfs_rule *smfs_rule = container_of(fs_rule,
+							      struct mlx5_ct_fs_smfs_rule,
+							      fs_rule);
+	struct mlx5_ct_fs_smfs *fs_smfs = mlx5_ct_fs_priv(fs);
+	struct mlx5dr_action *actions[3];  /* We only need to create 3 actions, see below. */
+	struct mlx5dr_rule *rule;
+
+	actions[0] = smfs_rule->count_action;
+	actions[1] = attr->modify_hdr->action.dr_action;
+	actions[2] = fs_smfs->fwd_action;
+
+	rule = mlx5_smfs_rule_create(smfs_rule->smfs_matcher->dr_matcher, spec,
+				     ARRAY_SIZE(actions), actions, spec->flow_context.flow_source);
+	if (!rule)
+		return -EINVAL;
+
+	mlx5_smfs_rule_destroy(smfs_rule->rule);
+	smfs_rule->rule = rule;
+
+	return 0;
+}
+
 static struct mlx5_ct_fs_ops fs_smfs_ops = {
 	.ct_rule_add = mlx5_ct_fs_smfs_ct_rule_add,
 	.ct_rule_del = mlx5_ct_fs_smfs_ct_rule_del,
+	.ct_rule_update = mlx5_ct_fs_smfs_ct_rule_update,
 
 	.init = mlx5_ct_fs_smfs_init,
 	.destroy = mlx5_ct_fs_smfs_destroy,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index ccee07d6ba1d..dcfccaaa8d91 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -884,7 +884,6 @@ mlx5_tc_ct_entry_update_rule(struct mlx5_tc_ct_priv *ct_priv,
 	struct mlx5_ct_zone_rule *zone_rule = &entry->zone_rules[nat];
 	struct mlx5_flow_attr *attr = zone_rule->attr, *old_attr;
 	struct mlx5e_mod_hdr_handle *mh;
-	struct mlx5_ct_fs_rule *rule;
 	struct mlx5_flow_spec *spec;
 	int err;
 
@@ -902,22 +901,19 @@ mlx5_tc_ct_entry_update_rule(struct mlx5_tc_ct_priv *ct_priv,
 	err = mlx5_tc_ct_entry_create_mod_hdr(ct_priv, attr, flow_rule, &mh, zone_restore_id,
 					      nat, mlx5_tc_ct_entry_in_ct_nat_table(entry));
 	if (err) {
-		ct_dbg("Failed to create ct entry mod hdr");
+		ct_dbg("Failed to create ct entry mod hdr, err: %d", err);
 		goto err_mod_hdr;
 	}
 
 	mlx5_tc_ct_set_tuple_match(ct_priv, spec, flow_rule);
 	mlx5e_tc_match_to_reg_match(spec, ZONE_TO_REG, entry->tuple.zone, MLX5_CT_ZONE_MASK);
 
-	rule = ct_priv->fs_ops->ct_rule_add(ct_priv->fs, spec, attr, flow_rule);
-	if (IS_ERR(rule)) {
-		err = PTR_ERR(rule);
-		ct_dbg("Failed to add replacement ct entry rule, nat: %d", nat);
+	err = ct_priv->fs_ops->ct_rule_update(ct_priv->fs, zone_rule->rule, spec, attr);
+	if (err) {
+		ct_dbg("Failed to update ct entry rule, nat: %d, err: %d", nat, err);
 		goto err_rule;
 	}
 
-	ct_priv->fs_ops->ct_rule_del(ct_priv->fs, zone_rule->rule);
-	zone_rule->rule = rule;
 	mlx5_tc_ct_entry_destroy_mod_hdr(ct_priv, old_attr, zone_rule->mh);
 	zone_rule->mh = mh;
 	mlx5_put_label_mapping(ct_priv, old_attr->ct_attr.ct_labels_id);
-- 
2.44.0


