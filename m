Return-Path: <netdev+bounces-135335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDAE99D8A4
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA9F28257B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C8B1D14E4;
	Mon, 14 Oct 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q47yzcYs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9FD1D0F79
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939312; cv=fail; b=ORehzH5gojBJgb9iv1dawVlUPQbocYJ+FC9Z5U0bkXjXi/bQMCMaAufkBR96GPcl0eX/HR0LiiwMAdHcz2yWI/8rf5uQHgmy5WCkEp+oi6q+TGHk/B0yDFM2JHGl35Vrve1tzEgwfMdSqPKs3WABewmmIFzqms3SZLGQrMRykKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939312; c=relaxed/simple;
	bh=XWoF5XaVejxIkEO45xtz3w48T0S5rypCOKStgFdtwlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFfXTaWLtRM5EBbSW+UWKEFUX2ffq4aDAO6S18jbvPevj52iaTDY6CaxYkbR14lRjKMh1GHgZFcHXkMmIsh8WoiyQGw4nc9sDi4QzHY738HL5axWtVd1qu27NQ3/ULBv81ym1B+0XtGF9T2P9QqA9PZZpVCsrbuZi2vWBALKlQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q47yzcYs; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDHE0hHLpMyu2d9/eRL54IVQroRVHq8MY3wTSE735XHBGDIARWzULK/dmdnqQoSt64pDu5AvDYobdnG9z54WJUBKbL5tHK4vRs849x4S5QK4P3H937fGi4EkTsU1Z6nGyMAZsaet6uQhdNEgI89RUb+k/vxSLhc3sj+1jQQzXPA9SI8LVq3jky07gWwPcjOlZkVdP2iD+V4MMUwOwQmkkkjYQT6UANwvwCJy2UPHDFPyBOuqOYFLjzKbJ/7Hg7DsNExiqL+vD+/fYejqAhCdvG1goonC8d2JRl9wz77CrwJkBMWuo0QLk/YqSzhziKsp6Je9aCWLXKaZwO88dn8t5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXmAcoLyOzxRrnd1ljArjHduOwLqEnTp9kIggX8ZN4w=;
 b=uCv5RfkYVrJyWSTEyQD7kAuV+7EwgGEr+o2tHDI+wI0RtonzdY0AHdxooGTd3W+TnqCAFK0Fwi+Cp+T/+vfV89OONPIV6Pmkz36BVPEWZ+9UKR3dsJ7XI8r7AJL7Ho9mAPjfowqZ9P9YKu7IpwP85Dt+mjnW9CUmk+B/wWEtJ7EGphGYOiJQFKVQadwd56BvBwzqJIYPQOKKZaWEbNX0KutbANxv8jNd3PDYqJLldvxJzqASUY+n6YObgH2S5SWetI59ZTGFyH9optv4aFBvCnpKPzKLcDdrTRbIC3JiUSklDMEC2Jncv3y2fNVuLIBu/xAVrMKGT6xOGLVc+/vBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXmAcoLyOzxRrnd1ljArjHduOwLqEnTp9kIggX8ZN4w=;
 b=q47yzcYsIXYBDC3s2bJ1zVAJcgNw8KJ5s16DC6Sk7c/TgbBAtD7ZKImcBKbTRZ9OOApXUe5QguyEs+dnPdorjVAg5MPMqfez9kCSKwsMCpnaNBIg10n4q8RPTVhH9s6qtVEcgz6bJSSKAMoyvZBw1ZxAgKDLKvfyBvIShEGhPJBLqHkl7ziSFFkNd4UdDtTVaLbtfGNBzoZPWnAOBE4CRK/ZOKXJM/MsZmYgo934dAGU1QPzixkY8pm8xGtUGszqRv0yoFNGJucOTMzsvuPKim6jQp/VVq6hEvGWFcNHUpS7xD5jNPMi+6Obi7YQzdV3u/GSztvnWKeEy8rL/V1R6Q==
Received: from SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 14 Oct
 2024 20:55:06 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::55) by SJ0PR03CA0187.outlook.office365.com
 (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Mon, 14 Oct 2024 20:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Mon, 14 Oct 2024 20:55:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:46 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 15/15] net/mlx5: fs, rename modify header struct member action
Date: Mon, 14 Oct 2024 23:53:00 +0300
Message-ID: <20241014205300.193519-16-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241014205300.193519-1-tariqt@nvidia.com>
References: <20241014205300.193519-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d389b5-d344-4f6f-69a0-08dcec927b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QrGduj3PbRRbO9rfnDW2Oao5sT+KaKXyY8wA3mk0E7XHbb+ZGvT/wR+VqIhG?=
 =?us-ascii?Q?FRoLNesW+yDxiDk/dQcddBXEabmeIHVKH+DfKAWEZRVYKYPZMK+aXHYhRQhc?=
 =?us-ascii?Q?ApIQb9Df3l0Mto2tCCXOJX5lMtZbT2IPIiH5ZDETOeQ7bbn2GRt1HCvMuzlC?=
 =?us-ascii?Q?SywWN/3YP1D0q0htOEa/wYqBtwVXOHuPpIB80NBFGmM+ppN04RR4yqI77eT4?=
 =?us-ascii?Q?dvzr4SjeK9SmRnN2SWvIqoiedNOB6Jsa/xKaKfPCrjwhvEd6kb+SSiFsmwWW?=
 =?us-ascii?Q?fErDe0lrqG5HNL15RJREZurP/sSMaoE2ta385x9nYAW3O/C6qn+NzNL9oUan?=
 =?us-ascii?Q?FzDlgdJo9CZL4NR3ZCswjbMc0zHFSatHEMZ41TJFfxxMUheyKSNBtRVzlGkC?=
 =?us-ascii?Q?48NElN7CoiKD7Eo8B3ZHDr/o1ggb4miShmJiswCwWExVD09FWxneFrM97fHO?=
 =?us-ascii?Q?QwV2r+9ZvDk6BXxnqkr8Lu9UFoGzm6TG11/Sg63NLQndhEskwBQeJYKNQ6v0?=
 =?us-ascii?Q?Q1oQ5U53YC3LwIBHjtuXTyvi/6O9lFkf0DHBwXD4Hj35CU3UVP43oYDrEWk0?=
 =?us-ascii?Q?5XmtU7+ZzIuHqhAn6F3L4nAfkrNmlvQkRAv1TY7eJjdl9W3WNgw1hhaq9aeW?=
 =?us-ascii?Q?+eu+E0Fq401diSs1U5nReSpk2BJK+rEmN/3RObY3ydgdedylLqhZkaCGTHd7?=
 =?us-ascii?Q?oWfPVXbP/2GXOAoGnLg5O+y8WZ0CkVitubOBLv6ygW5jEEL8c//aaeU1RGPk?=
 =?us-ascii?Q?vAgM6IRPTpjyKrpCjhTCNP/D4PQAi5dyfq821ZkPWPZdK5bl7HxS8AjOXZZz?=
 =?us-ascii?Q?7Ms0zQu3RDT9UQMr7GyIYpnDGKTixiGmK42UKJ42bKDKK/Z/4Zqji0J3Dlv0?=
 =?us-ascii?Q?WuS/soyBmPe9ycYtst/ZLulHI+f0kE6FAKT3XIGdenfWn4pfx+gOnDjXi7JS?=
 =?us-ascii?Q?6rCLTlBHQ9ONT6syNjWyx1aIz71Yw6i6Qkp1aknjRK5dZgzuA6UraoTd6w+K?=
 =?us-ascii?Q?JLaEOSQdDYUBRtwKrrXY7kQGrDWdOdAaeVziVNHMTe0TlkiOfwa1YagN3zyD?=
 =?us-ascii?Q?K9eTxOkEKFod2YwfqnJdzQakUBcRNRwRcUAq8tFCauGS8zngvw8c0eLX1AbJ?=
 =?us-ascii?Q?xqCUDsKExTx1w6LrIDgCeRWZf2nzRNKAKYyAvEvs49MmhCVxvUeyfRm9U9c4?=
 =?us-ascii?Q?aBNcn7ocn3Ut6MNxQzb66K8bl+pTrd1+uTMB/P3AoSoGB/7EUyCFO7YO6Uvw?=
 =?us-ascii?Q?cPtJwqdwGsjopd9ZR6CLhusaIHJPn11GnXTWuucQD70UWywvU0a9c5s/l+aG?=
 =?us-ascii?Q?/tvE+wdsftToTGSPUdK9lIEFpFK7SbMU+AOh8X1tk6P+IbJbUNYxyXJitkQd?=
 =?us-ascii?Q?NViMIATUXxP/lLiWDzub2xhT1/ZB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:55:06.1811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d389b5-d344-4f6f-69a0-08dcec927b9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867

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


