Return-Path: <netdev+bounces-134912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BA599B8AA
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3862826D6
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BFF13774A;
	Sun, 13 Oct 2024 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c3fN/8OY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C985C5E
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802042; cv=fail; b=lBiG9xD8x049Cci8LfgrvYFzoIZ9VjTcibuAIhxLOPDmDZbSv8kUUWaFy44RQTQiziDPxkA62l2erAseLz9knWkWJt4YgRV9+a75eFU1zv+MmLp+a78VJr7TL74c0pbz1TIOyjHln/TmLFIyAXVCZO8geI8+zyJ7fDfUU3FI1UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802042; c=relaxed/simple;
	bh=XWoF5XaVejxIkEO45xtz3w48T0S5rypCOKStgFdtwlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHoLeL9tJui1OoTLAxjxj0d8nShVmjQ9+nf93ONRJPiphISc4zD2BtNXIXzMmX3+E8fwFAcGf5Ck3DVYpM4Ag4TRVmU4SxgjDUe2A6WX6mGdMhLIeZRABhqU17nSfj8XpDSnsPOb/LHdjdFnDKS/j2jaoWvC40Pst98BYCBVQCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c3fN/8OY; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BK64RypdyxNdhiayoOrMv7KfR9Prs1+XsBu12SkWIlf/LuW7OAA48wq0hRj7x+XSlDMIJpm9h/TGBSgJnThPYCos2DqQMEWix6DQeAPphffklM9LHEWRlUdqw2QEMJr39/uUr3WR7/QA/2FkIIJQl1FWFrKj+GwI//nClklSrUOM9838kKqrEuhtuqqVHS1N7wDFCSS1GUgMLhlrE5z4YynQTIQekEDYIhKzC4oydTN4ET+paVEEocnOIIxG9isr3XSwMln+1V+QjP5RkzkRXAqtiP0olX0exOktLpJqTikUzG9pwjv+g7BlgtbqQx63kbRgsdsKzfSdk0WqbMOOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXmAcoLyOzxRrnd1ljArjHduOwLqEnTp9kIggX8ZN4w=;
 b=PODNINV3CGj/jFRQcSaAamxC9kewoAYQSSvG7XjUcyQATd8nDWgRblHZ3dWXQwJ8EHEqrskxHmKqNiKwHsG1ofn9Cak2OrB4Z8tMhzsHOhqjlpUEBdtFyHU8uXNv17cEwXzCqqIm5X/K93tVSzEbrunCAoCF3jpuvSdkQnn+hXxmyl36RxAZGDPu/O2Owpf2gzZ3+XvvrpxcKZUB6FvfLilJABc4bbxC2+NFlP6doXgW06OkKX6YS96G8VRwHcl3XMEirQmL/UNPMhne5wOdK8JBlb9o07Eyx62tFiihh7O9H23KfuRqFUd5Ky/zYshYU0VKSDTqVEECgwDcZkYv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXmAcoLyOzxRrnd1ljArjHduOwLqEnTp9kIggX8ZN4w=;
 b=c3fN/8OY2OmI2puqmFfl1I7GsYeEwanQ/f6nE4L87d9IqreTDran23dkdyLGUcrawKXySPWgctmOtuonxNPyFERJTm4ZaEeyLA/2b/IfuaGDfNZmNOPt/Nk0MtemnZPwjb59z977u2f/scDBBICqV4c+wRV2XM2I3KN9FicN409c4oKo5k9AO4BOgDrDCDFZPvSFnVtepJum7AxU4REPDyMZooUKAH3uXFr7H6klVD2fPPpJdcuwXQ1AxMYpyePJabIKjC2zMys1jWb4rPywI+2WNWMrDA8cRH/8bdmP6Il6jzMhI9Of8kLzFUxPxbeQctKTa3L2JOnAygCOtOww0g==
Received: from CH0P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::14)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sun, 13 Oct
 2024 06:47:18 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::7d) by CH0P221CA0004.outlook.office365.com
 (2603:10b6:610:11c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Sun, 13 Oct 2024 06:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:47:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:47:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:47:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:47:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 15/15] net/mlx5: fs, rename modify header struct member action
Date: Sun, 13 Oct 2024 09:45:40 +0300
Message-ID: <20241013064540.170722-16-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241013064540.170722-1-tariqt@nvidia.com>
References: <20241013064540.170722-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2dcca6-c4b7-45f3-c0b3-08dceb52e121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1i0qREAay+PLZchsJ5gSl9zd+XQ/iPEEblB6csYybw3RpAwVPQEu8r519Lsv?=
 =?us-ascii?Q?tfhVBhkllLaKszfRPknumLG1zGG/a0IqK8smLN1TohlaPuZhtJiP1C+PHBVC?=
 =?us-ascii?Q?dNRCRxdUuEUOIUG06BrI6EOCzDj5LJ0XWZuzFeKpDULpV9wFtyQQljSLGYJW?=
 =?us-ascii?Q?USdwTnEnypJQz3lwXfGGbfFSJc4s1g97ZqFu9tn7UPvssojlRQmZ9Mjs1Oix?=
 =?us-ascii?Q?ZMI06Fa9Jfu2kfqhtZFZ7WaKeK1SqwGs6cwwVe795RTOggpw4owLHyEv8GmK?=
 =?us-ascii?Q?gtYFs9nfQdrgQc+uGFOB/QHcqiZzn7QBCmzudkdpReG5/EW+ZWvMQtmLexo5?=
 =?us-ascii?Q?ZQ5YhJaev4MDJXozWViIAgfRDCJd98/1mDOgCd9n78cRJS9H9tfXIb0kSr2e?=
 =?us-ascii?Q?G+LEpdvLBJGHSHTA4rBmm1mnmNAYw5yh3QS1UYQbQWidzUYvJiJohfXZ/fjq?=
 =?us-ascii?Q?4m7lrRwJn0hwAQqflnmZqOgj1STu50iU3pX9DNySqtcfU2xjwKsfhkY2uwHl?=
 =?us-ascii?Q?wk8IR1d+JtEfvkhgIPUzffIYCyuklENMhO0Tk1Fi1FFJDjv4faptAJDRCqCE?=
 =?us-ascii?Q?AJB4pgbW/8aWqhNjmGp3b3d45mC4qrX+MZzs7ph/QNdfOZHdfN1DJ4EYKexl?=
 =?us-ascii?Q?NwzHKnlE9KvXqMqHwnTpfrbU8zx/gASEZwCYJCaqV5993Z4I6Vh6q2YG8mHH?=
 =?us-ascii?Q?gqkDypmlC0EfIES9n//G5Xd9oTdL/DRyOKwPiD5nYwCmGXzORsZercVoHIt8?=
 =?us-ascii?Q?MidzjhMOJgwuPK7/CD3ftWE9ORMIbiXlmDO02N1znRWYE2EqDLx4sC8fa2vE?=
 =?us-ascii?Q?cgr1EXW3yjZvnLCesLT9NftxVmxWkP11imu5weSbMq8xtzQx5PJEYhNZ+vFv?=
 =?us-ascii?Q?r2EyHIOes/iqYaRGudzSD7+rMwBrGzd0GG6y7l1nZfDJHTXQwC7pNRf52to0?=
 =?us-ascii?Q?7FJX1xFw9ICR0ASIZjlLygRBr8gQMe3kL07kSGqqMNO8VgA5lZzm1nFxJ7G+?=
 =?us-ascii?Q?+jkxNexqouss9v3vPRCocnkvYUdp86/V3iCdt7jPUuBxBDcENeXL7ChRN0rR?=
 =?us-ascii?Q?zIdY4jZgsBqMugqwrPY6dgoGBBKcCZepC09mBksz9p9KYhIgqHeugpsDtIKD?=
 =?us-ascii?Q?fQn51hxFFy50h03zfexGpYhEnEFcnOXrjMyLQmtQb3JekulhYHkjeV63AEWS?=
 =?us-ascii?Q?i6yk1cwZugf+3grKStcDgpt1b2tXAenkAblT5rCzX9q+lnEkRkJ6TQN0z/2H?=
 =?us-ascii?Q?SLyyNA7CDINjLsaDBtPuTCLh94UlmtF0VKqUk1V23gRFSV48lzPu1sNjEG8f?=
 =?us-ascii?Q?b7+6QDFuAo9auXUCVe7cm4Xop9qQwPYY+c55qCAvxby+/v60XBe8Z+aICEFt?=
 =?us-ascii?Q?fzgxWXa7wEaoI6jvIq3aT5Qnyxjs?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:47:17.5136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2dcca6-c4b7-45f3-c0b3-08dceb52e121
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273

From: Moshe Shemesh <moshe@nvidia.com>

As preparation for HW Steering support, rename modify header struct
member action to fs_dr_action, to distinguish from fs_hws_action which
will be added. Add a pointer where needed to keep code line shorter and
more readable.

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c   |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/steering/fs_dr.c | 12 +++++++-----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
index 1c062a2e8996..45737d039252 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
@@ -318,7 +318,7 @@ mlx5_ct_fs_smfs_ct_rule_add(struct mlx5_ct_fs *fs, struct mlx5_flow_spec *spec,
 	}
 
 	actions[num_actions++] = smfs_rule->count_action;
-	actions[num_actions++] = attr->modify_hdr->action.dr_action;
+	actions[num_actions++] = attr->modify_hdr->fs_dr_action.dr_action;
 	actions[num_actions++] = fs_smfs->fwd_action;
 
 	nat = (attr->ft == fs_smfs->ct_nat);
@@ -379,7 +379,7 @@ static int mlx5_ct_fs_smfs_ct_rule_update(struct mlx5_ct_fs *fs, struct mlx5_ct_
 	struct mlx5dr_rule *rule;
 
 	actions[0] = smfs_rule->count_action;
-	actions[1] = attr->modify_hdr->action.dr_action;
+	actions[1] = attr->modify_hdr->fs_dr_action.dr_action;
 	actions[2] = fs_smfs->fwd_action;
 
 	rule = mlx5_smfs_rule_create(smfs_rule->smfs_matcher->dr_matcher, spec,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 195f1cbd0a34..b30976627c6b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -63,7 +63,7 @@ struct mlx5_modify_hdr {
 	enum mlx5_flow_namespace_type ns_type;
 	enum mlx5_flow_resource_owner owner;
 	union {
-		struct mlx5_fs_dr_action action;
+		struct mlx5_fs_dr_action fs_dr_action;
 		u32 id;
 	};
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
index 8dd412454c97..4b349d4005e4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
@@ -372,9 +372,11 @@ static int mlx5_cmd_dr_create_fte(struct mlx5_flow_root_namespace *ns,
 		actions[num_actions++] = tmp_action;
 	}
 
-	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR)
-		actions[num_actions++] =
-			fte->act_dests.action.modify_hdr->action.dr_action;
+	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) {
+		struct mlx5_modify_hdr *modify_hdr = fte->act_dests.action.modify_hdr;
+
+		actions[num_actions++] = modify_hdr->fs_dr_action.dr_action;
+	}
 
 	if (fte->act_dests.action.action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH) {
 		tmp_action = create_action_push_vlan(domain, &fte->act_dests.action.vlan[0]);
@@ -705,7 +707,7 @@ static int mlx5_cmd_dr_modify_header_alloc(struct mlx5_flow_root_namespace *ns,
 	}
 
 	modify_hdr->owner = MLX5_FLOW_RESOURCE_OWNER_SW;
-	modify_hdr->action.dr_action = action;
+	modify_hdr->fs_dr_action.dr_action = action;
 
 	return 0;
 }
@@ -713,7 +715,7 @@ static int mlx5_cmd_dr_modify_header_alloc(struct mlx5_flow_root_namespace *ns,
 static void mlx5_cmd_dr_modify_header_dealloc(struct mlx5_flow_root_namespace *ns,
 					      struct mlx5_modify_hdr *modify_hdr)
 {
-	mlx5dr_action_destroy(modify_hdr->action.dr_action);
+	mlx5dr_action_destroy(modify_hdr->fs_dr_action.dr_action);
 }
 
 static int
-- 
2.44.0


