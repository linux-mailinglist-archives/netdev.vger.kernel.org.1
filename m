Return-Path: <netdev+bounces-158107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56130A10775
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521E37A036B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB9724022C;
	Tue, 14 Jan 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P8J8WAl+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984D72361E7
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860259; cv=fail; b=gY9/sEZDo0Bpi8mHGVBn2RyBgH2h2zFFnShPkkw0PdPIodBmULUYEpXMotRfTVdgeBsTxQLeTaxNFmhrd810ryLIAJgZINJHjr6PcaNr3O6hV+qNdt45PQZYp6SqJwS8gDPJKUQ/FgNqlCOrXYRbDKgYZyKbF2K0doXtJZmw3sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860259; c=relaxed/simple;
	bh=nyU14iyWCpg3Ety3A0rdYgYrrRbEbhsihwbWr7OmYKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMmooCOytmyeQtDZA5Xcq9t+XkhAGkcYlYrsOzyfJxO6QV1dZowXlR1TWwp5PByy2gVrZTOnp0WmXRWfkUn27zK2WsufPqoZCOhtNT8e808IM2BEPWpAzM0vEnN9eqVcET4EwJptDFBnjVPbpoUHGLTzllUsfNNH8j8kN+5XOA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P8J8WAl+; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ad7xGPnWnqBrJ+TdVKDkMUXmOg0uhdEllhhwxyas0cZnnUROPFLb8c5mgJwm7h/+7m0+e0C0RYVhsER07eYCI3T+cLF9e4Ulb6bg9OOUeZCEpzXlmkmCgRWI/5mVvCyeLpzrkhFjcedIbKyBnDLtMEgE1cwfeZd6d0sqv6yQ8iIm+sFh/tSYEoB+nRl6Khy86BnBZjKDPfaX2hD1W/6W76vONXkX/hvnxd/n6fFRwrHMewD/FogiQkFecJrJKyS8lVIoeUwrGw9nXurVP69c4whfv1J9+0HBmwuwAL1e59ikHUNrgsvc1aFkRpIodjRb3uYKoe6ME/OZd94SnaefYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZSWS2/pni8YC7fVBfv9LT3Cg6OO/vSvVC1OmaHX6Vk=;
 b=A+cDasOXA4Gb0OS937qNZsD2AVG6smMIVF5Nomp/Fs97iW3PiTGU/9iedSH5m14LnwZFu7jDkC1aOt/88ph/NUlg962LzNfu6m+/KEbvwiEByTyyrU4JvA/dEs73fZXWWxQ4RSq+mVmUavnmBGCCjlOo84Vu7n1jbabuVStBTEtfIzHDzjAdugqk8NWp4RTIbq02iDndRQ93UpdrVupbJzxF/HMqgehfmDLi7Lgoe19gqEzJLTZoMGnBGTvoPdMqbDVk3y4t1fmqj/wDLcogMRWkDAiKOR3Dm/kahr5W+FHnQ+FSPfNf5aMbpYZnYRHmHUeCwFfLx5+b4YC19wBUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZSWS2/pni8YC7fVBfv9LT3Cg6OO/vSvVC1OmaHX6Vk=;
 b=P8J8WAl+DmWFKLh0iWMJ9K5nwdK3PTIO6X9YnIdvk14e5+n3jlcCqivEpfHhhxOq79fuPB+t6iMp3mq/2yGUSm6JDODNsNWg7ezjCWILnKlB/4X2B0eFPDlbIK4An4Jgw6Le9Y6Y04xl0uOwP/RGozIt1WwtvEmE8wol1NfHnwzA7k8TSaij8HXt91xRl2q9vdwtWnQkT44QREZ/1ul0cFgwN3EFgIV7zD4m/uFDUxBfrq0lswIC0qljUmqS8Sb3jedMEgso+P9dTay+7AHisNLXc/6uxXSKgwaoorhCug7Muy93zcC8Bh7vmTgWoc4CJ4DfisAoMMy5wNnisCwDGw==
Received: from PH7P220CA0086.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::15)
 by IA1PR12MB9499.namprd12.prod.outlook.com (2603:10b6:208:595::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 13:10:54 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:32c:cafe::88) by PH7P220CA0086.outlook.office365.com
 (2603:10b6:510:32c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 13:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 13:10:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 05:10:32 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 05:10:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 14 Jan
 2025 05:10:28 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 2/4] net/mlx5e: CT: Add initial support for Hardware Steering
Date: Tue, 14 Jan 2025 15:06:44 +0200
Message-ID: <20250114130646.1937192-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250114130646.1937192-1-tariqt@nvidia.com>
References: <20250114130646.1937192-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|IA1PR12MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: db4655e5-3f6a-40af-0d23-08dd349ce028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5aZdDL6ezfy8P7zQHrhoHgo0zDa7nonf+WHjugC8rYb97eePVfINTc61xbxS?=
 =?us-ascii?Q?evJmgqVwA1VOYtEpUtAVLmgz1wK9D0VxMgENhF0sVbWzG6OoPbbmDdoBRJQ0?=
 =?us-ascii?Q?Jw5jRnBRpZ+trf8HPIg7kh6R4fbdh8ufMwZ3bSHdl3jtE8MIUvL7xm6DDlLl?=
 =?us-ascii?Q?l7s/tUGwrhlP47Hj3Q98mCtGwcEaADUPOCLY7RZS+hhfL1QoPCNvz6kl2cSi?=
 =?us-ascii?Q?y2Ui4Iq2smuiGoph1bvCiuMi6fRIGNgtTurGl/4k08OwARX9VK2dNMPGL9NZ?=
 =?us-ascii?Q?Q34P4JlcMYH/OwtMVOITnVHb5jcuYXmseeFUWW+gZBDuw6aS4COvhAXaLD6E?=
 =?us-ascii?Q?8Yo9kAyMcsOhOLOiEJpKgMgR55vLnbkVQmWjTOgo1QVOuARwKEG03QjKo57j?=
 =?us-ascii?Q?elrZdpc3pzdwM9OsPMzOnpNsOaO6ur5DXyAjMSluOWZW5f8YTcd18F5sTufo?=
 =?us-ascii?Q?DvqYwiSi32+/DCzwYnUMsRpeR7dFeTSV3MoNgOV+ekMASIREJ2fT7y2BqTdt?=
 =?us-ascii?Q?7w6KilQDT6fi3N0pnK9pSqs7lEcWWSsDMH/btzpACFbcyFoSQ+3zzd2MbGoT?=
 =?us-ascii?Q?t3HNR5RdPJc+TJowDxx4K0GmEk/oK09wv+4oJ7ul16KalPGbOdoHMBAZgGCb?=
 =?us-ascii?Q?cBqYpqtQNjTmtRYJm42/AiBvfJt+MibSBFcD3hMr9QPqDxm6OLN/3Jst7e60?=
 =?us-ascii?Q?Uys+w4vcS+1pWppOyGkT8YbwF4oYMBdbcdzlUHYyK9ctYrZygZAKllOeigpA?=
 =?us-ascii?Q?g1pPXvNB8HVmXjkTgpiu1nYjLdCivDcF1ibzq9Aeq0PGn5KRerjxbvEwPsOU?=
 =?us-ascii?Q?yI3wJw6IkMJcYTO9yWA1gjoPz76pQXbG9+OpM3ElQS/yRGKguLnU+gkdEhLz?=
 =?us-ascii?Q?snaiUE/quziwBr+NCa4ROQzHMXvztakrt+7T7X0d7r4b0oqlkCVHQ9TeDZJJ?=
 =?us-ascii?Q?Ch1avDRXaUbcdK5FqqWmXCS5wI2anDhWEmLy6b6/Tx7wn8mziXQqyVqkdsKC?=
 =?us-ascii?Q?TiXPyBtYjR0oBeFw3JDSPYNbmpLDxgbP7B65FFH/sPzyAbp2BAherDmV40KM?=
 =?us-ascii?Q?Sl2ZBwGMjT+ngWrbCtDPN7tuqQjmEFY/eVPCualrmfDN1ABAa8AMsRsPEE70?=
 =?us-ascii?Q?6xe6ZxGJWQCGOz11k+kWmurTS0E2ul2vLurqnn2touZpXc5Y0fy82q8we38C?=
 =?us-ascii?Q?WjKUxXoDoMLZKgtoJJwfP7VQVuaQm66s9nnRdXqTlWWqcbWtDYbxDYXtXUK7?=
 =?us-ascii?Q?YlHbiptcG+nW944WFP8rKc63KbBY9vfjyZtKTd4ifhHcgGyZ1PjSvnslrtb9?=
 =?us-ascii?Q?MVs5VrCe6J3PXG+kvWUWnw6UWFl4e9/UXC131Cdn+/c70XrpNc/VOZaJh6Tg?=
 =?us-ascii?Q?kYc+IqcvlAYxOm769zImN5mpaV3z1A6us6SRnhEdkRIKhuVEtCJ6h/UTESCc?=
 =?us-ascii?Q?UyEPqw2lUpDDXFrR5S3GMJg5/Jo4pcfMIA7B3KLMU/w074hLb9cQSdOUlJk5?=
 =?us-ascii?Q?uc0tTPP1MxwDhVw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:10:53.5179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4655e5-3f6a-40af-0d23-08dd349ce028
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499

From: Cosmin Ratiu <cratiu@nvidia.com>

Connection tracking can offload tuple matches to the NIC either via
firmware commands (when the steering mode is dmfs or offload support is
disabled due to eswitch being set to legacy) or via software-managed
flow steering (smfs).

This commit adds stub operations for a third mode, hardware-managed flow
steering. This is enabled when both CONFIG_MLX5_TC_CT and
CONFIG_MLX5_HW_STEERING are enabled.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  1 +
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs.h | 10 ++++
 .../mellanox/mlx5/core/en/tc/ct_fs_hmfs.c     | 47 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 17 +++++--
 4 files changed, 71 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index d9a8817bb33c..568bbe5f83f5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -60,6 +60,7 @@ mlx5_core-$(CONFIG_MLX5_CLS_ACT)     += en/tc/act/act.o en/tc/act/drop.o en/tc/a
 ifneq ($(CONFIG_MLX5_TC_CT),)
 	mlx5_core-y			     += en/tc_ct.o en/tc/ct_fs_dmfs.o
 	mlx5_core-$(CONFIG_MLX5_SW_STEERING) += en/tc/ct_fs_smfs.o
+	mlx5_core-$(CONFIG_MLX5_HW_STEERING) += en/tc/ct_fs_hmfs.o
 endif
 
 mlx5_core-$(CONFIG_MLX5_TC_SAMPLE)   += en/tc/sample.o
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h
index 62b3f7ff5562..e5b30801314b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs.h
@@ -48,4 +48,14 @@ mlx5_ct_fs_smfs_ops_get(void)
 }
 #endif /* IS_ENABLED(CONFIG_MLX5_SW_STEERING) */
 
+#if IS_ENABLED(CONFIG_MLX5_HW_STEERING)
+struct mlx5_ct_fs_ops *mlx5_ct_fs_hmfs_ops_get(void);
+#else
+static inline struct mlx5_ct_fs_ops *
+mlx5_ct_fs_hmfs_ops_get(void)
+{
+	return NULL;
+}
+#endif /* IS_ENABLED(CONFIG_MLX5_SW_STEERING) */
+
 #endif /* __MLX5_EN_TC_CT_FS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
new file mode 100644
index 000000000000..be1a36d1d778
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. */
+
+#include "en_tc.h"
+#include "en/tc_ct.h"
+#include "en/tc/ct_fs.h"
+
+static int mlx5_ct_fs_hmfs_init(struct mlx5_ct_fs *fs, struct mlx5_flow_table *ct,
+				struct mlx5_flow_table *ct_nat, struct mlx5_flow_table *post_ct)
+{
+	return 0;
+}
+
+static void mlx5_ct_fs_hmfs_destroy(struct mlx5_ct_fs *fs)
+{
+}
+
+static struct mlx5_ct_fs_rule *
+mlx5_ct_fs_hmfs_ct_rule_add(struct mlx5_ct_fs *fs, struct mlx5_flow_spec *spec,
+			    struct mlx5_flow_attr *attr, struct flow_rule *flow_rule)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static void mlx5_ct_fs_hmfs_ct_rule_del(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_rule)
+{
+}
+
+static int mlx5_ct_fs_hmfs_ct_rule_update(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_rule,
+					  struct mlx5_flow_spec *spec, struct mlx5_flow_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+
+static struct mlx5_ct_fs_ops hmfs_ops = {
+	.ct_rule_add = mlx5_ct_fs_hmfs_ct_rule_add,
+	.ct_rule_del = mlx5_ct_fs_hmfs_ct_rule_del,
+	.ct_rule_update = mlx5_ct_fs_hmfs_ct_rule_update,
+
+	.init = mlx5_ct_fs_hmfs_init,
+	.destroy = mlx5_ct_fs_hmfs_destroy,
+};
+
+struct mlx5_ct_fs_ops *mlx5_ct_fs_hmfs_ops_get(void)
+{
+	return &hmfs_ops;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index a84ebac2f011..fec008c540f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -2065,10 +2065,19 @@ mlx5_tc_ct_fs_init(struct mlx5_tc_ct_priv *ct_priv)
 	struct mlx5_ct_fs_ops *fs_ops = mlx5_ct_fs_dmfs_ops_get();
 	int err;
 
-	if (ct_priv->ns_type == MLX5_FLOW_NAMESPACE_FDB &&
-	    ct_priv->dev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_SMFS) {
-		ct_dbg("Using SMFS ct flow steering provider");
-		fs_ops = mlx5_ct_fs_smfs_ops_get();
+	if (ct_priv->ns_type == MLX5_FLOW_NAMESPACE_FDB) {
+		if (ct_priv->dev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_HMFS) {
+			ct_dbg("Using HMFS ct flow steering provider");
+			fs_ops = mlx5_ct_fs_hmfs_ops_get();
+		} else if (ct_priv->dev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_SMFS) {
+			ct_dbg("Using SMFS ct flow steering provider");
+			fs_ops = mlx5_ct_fs_smfs_ops_get();
+		}
+
+		if (!fs_ops) {
+			ct_dbg("Requested flow steering mode is not enabled.");
+			return -EOPNOTSUPP;
+		}
 	}
 
 	ct_priv->fs = kzalloc(sizeof(*ct_priv->fs) + fs_ops->priv_size, GFP_KERNEL);
-- 
2.45.0


