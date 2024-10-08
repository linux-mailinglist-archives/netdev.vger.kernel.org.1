Return-Path: <netdev+bounces-133266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 063579956A5
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5744287241
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30C92141D0;
	Tue,  8 Oct 2024 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J00C0rkz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF5212D1B
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412417; cv=fail; b=OPJVUR1h0MLsvgk+XR+Rx+NKcHVY8QTchHjiEh2yMUIYCZFazpAz25vaoIOpcSnGKuMxPJafcU6U9RKXTEayg1dGouKoYF8DIZX34ow//UZm8aLn1nbHkG3pkOemh6Yun4gnKDYd5YNFdwlMujqkIJp6Ll2ReS0OT2D4uYsc8RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412417; c=relaxed/simple;
	bh=QjDsaivZDmPvlxlTt02Tt0RS1hvf31WOrV1gppQGvOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HhqoMYcC2IgVh309NHpDfolawO1G7dMajzrShTXips3G8EW/3zzNorBpHGhW8QFGvhrttidf9BjNUyF7JrXdETzUpylLgu6Hd1yGxIlGbJhDgf/zJRimw7Cd9B34eGC1ojJeR5op+P53r7u95XTZ4//DdWZ+yavExKkzGLdMuv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J00C0rkz; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smudbTrwxQgb/ENZ0BX3I/F8fZw8zkenxZdTviRYmXvTyffy27uF9two/b8SFkWz2ubgJSd87KZNWKUm5GlBo+QIRyECdmIWEfBZ9ycFDXlraFbEmJlyklOtN/P23GmVY1mwK54cz9p0jSo41C6ajYcFh1oYSiqsrWiv94sIVhhoCMdGaAbxHnR5lp2QvNt8r+Xco8eYPG1aewnxmDMCQg+4/XARvo1kcY9H2/4YxuxcFLEXatBMbiXFvY2yEA3Qb9WP4qyLQv5C5VPRk+XSzERx0PHAKG8WMenXWUs2debBjkpoRv2KCMCd/jIUutOdEA+0NvkyJNkzgm3/Pj5K0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSjiSoJe5GHz9m5lrOmH06Hovmwpsren/9ihjWn004c=;
 b=STlaU6RcNedXCg7DvP0afZjV5xav/VnPYxg6tOlak05LT4rU9zZ6TpLL0eu6IUwS93UcnnjV9DtDA9j/afqxK8Pge3/6M6x0S44/YNqDmQ8ifOl2y6Fr8xgiG7PbkpDynf/G/Q9fN4SosWjCNXeIOmoVRBO26wvlVDF7XqCM2SyyU/fe2H0QiN85c3MMzzXneCwjHYMhpOaC8Xkllo3AM+ZAzMyPuEHmGg6G5dhoBnluBleGKaeXItIdJVMeU+Fp2s6QWCk5zoQjHQBR+1vMoDL+O9eLA8J7drmX7DhR7yLlcZfpONEhWOV6X+M5YjZiGebpLW6JRmIFDRbTSq8PzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSjiSoJe5GHz9m5lrOmH06Hovmwpsren/9ihjWn004c=;
 b=J00C0rkzSOCN5/OXeSxG50pmnYzYr/O/58Flj+AY/U4CkRjhoEziIBjg4dWpTpA4MuKSdi87dWmhJwL1z96obmU3qKczL6H1s1ZIjuYfoMFm8kXyG9gOkq9necCQESXsAv0nyLEoiCGXeQMFJKhO04WUR+7UueeSW3nACGWJe85hK2fezFFPM1KtVZYYRIEYC0RgQWXAHa+WcEWvUaw+UIMAnSF6RVJ4lvNHdZve9LWu5aymiMgONgI80f22qYm8AwkIkWTGShLw0XTM6Y4unJ9Ej8B/6IFIMoBpXAciISLAnSta1LBfhYAMVJioSidvWCuiooaUiphCttJtwsmcgg==
Received: from DS2PEPF0000455F.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50d) by BL1PR12MB5852.namprd12.prod.outlook.com
 (2603:10b6:208:397::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 18:33:28 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:92f::1001:0:12) by DS2PEPF0000455F.outlook.office365.com
 (2603:10b6:f:fc00::50d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.3 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 06/14] net/mlx5: qos: Always create group0
Date: Tue, 8 Oct 2024 21:32:14 +0300
Message-ID: <20241008183222.137702-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241008183222.137702-1-tariqt@nvidia.com>
References: <20241008183222.137702-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c851c8-8831-4e03-031f-08dce7c7b41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pREHytyvTpU4wOP0swibySUduwMsapIM0jMPzJRE9XBaWnmKGG8dVn2EWGcH?=
 =?us-ascii?Q?nUGQ4lrNpGlg68625motMFOk3lb3lPYGndONV7QgAWMFU8eh0RrtAl/5oUv0?=
 =?us-ascii?Q?Be8y4Z1hXy2eb32DZjW93nWWij53tXfA8N/MWa+6LETjgs/Ap4f2MHUe7wKK?=
 =?us-ascii?Q?Z9JTa+jd5qq4QsWdv7yIQIs20szqI8vV3WUv1wrz/RtVYEouMgd+7VLrUMHk?=
 =?us-ascii?Q?sf5qtAtOXsm/nRTF4dJCiT8fvk6RfdOs1G9tqksVgM3d8epRW/BZqpsOkHWh?=
 =?us-ascii?Q?TdeM6QAz3ZQZPpAo+XE3bXGQ2OwE8IK9+KRTgxXSNwjr+HeFnjcV0qYc6NcK?=
 =?us-ascii?Q?QkCuci9XcCxiySUVrt/EGuFL6n6kwvRYSP/p8lTUhjaEJZWk8Lj671uWRgxm?=
 =?us-ascii?Q?CzlYtZZEId28q2tY8i9qQKU+5KBCRAycnNqPmUq1hxDhZbGHoUQqVMW7h3Fk?=
 =?us-ascii?Q?Clqh8CHj6ZYjm7HbBNXctuSjrrXXElJ7Dnl48wsTu2rJ4xGjBOXAz5AxyxfC?=
 =?us-ascii?Q?Y3lKNsvGxH1v8y5UtLZfhGSF+DY0VtCp2nMswm6ax9Gy9Spu0WJKVMpgaWE+?=
 =?us-ascii?Q?+esA+QMXVzArI3epR7Ec87R9MZkcEdtA3RlO1HLMP/ZPiUgWmBEUSQ9TaZrV?=
 =?us-ascii?Q?mh2fTXfLAROlWPs9wl32H5IbNEVu8sl9zUdiswrPAJ1mhRVCZ92hkVC9QFwW?=
 =?us-ascii?Q?AMrJneJSXVWYATHfaEL2pNQexeus3Z4V6/afgCmBxEMMuyRVO039XCajt4CX?=
 =?us-ascii?Q?VdF/paTZMDngac7NR3nGgiqXTF/Lov9xb9J6GCBzTsi2JN6W8bpStDfCOVjU?=
 =?us-ascii?Q?sbbWHcDTQSjBZAwflN9hB3jVgE8B/Mi1hf34BOywRO4BXqrr93h/TpVwDLe3?=
 =?us-ascii?Q?tyr3JPvaVJm34rgeSIEf9Qeu8G1ICRrt7tv3upmNCOMKjWm2sWVyJRoFg7cI?=
 =?us-ascii?Q?ZPMegTd0Im7+bL5E4hdww3Q7aXVPnrqCy9jHLANh0lfciC2hS/MX6x/A+iES?=
 =?us-ascii?Q?uIe9ql5pUV39ILuEmUO3FadYsKs+D4/+XExk1YWPjknUrF6O2LYa2sk4xTsK?=
 =?us-ascii?Q?FhXu33e6PsOZMG0/maEFOImzoWXSATH1qvgAC6dy0yGZz4ruSZRFk69Zmo2q?=
 =?us-ascii?Q?tt3HqMAaDVSUF66+Uzl4Hv4n7dc6XbRYWbYsjOyRS0GVm1iZ8swjKxgGzlPI?=
 =?us-ascii?Q?x5L2gaPOvr9EVxEeLlgFskfyB11RZE+pLQk3H9tacVhzpE727f9s33CQxbbQ?=
 =?us-ascii?Q?REZA/G/wggm5e7IhTb30SOePeCUkFbymiL7CAi+8r+xT26UQjw1099YdAatY?=
 =?us-ascii?Q?YjKv+VcImK1+MFXSF3F2m7UgSRif9Pu9wawTYOlew6O5xjhpUQix3QvyUpCw?=
 =?us-ascii?Q?kzU4X3g49XkH4JvToymzY7mEKedA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:28.4604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c851c8-8831-4e03-031f-08dce7c7b41c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852

From: Cosmin Ratiu <cratiu@nvidia.com>

All vports not explicitly members of a group with QoS enabled are part
of the internal esw group0, except when the hw reports that groups
aren't supported (log_esw_max_sched_depth == 0). This creates corner
cases in the code, which has to make sure that this case is supported.
Additionally, the groups are about to be moved out of eswitches, and
group0 being NULL creates additional complications there.

This patch makes sure to always create group0, even if max sched depth
is 0. In that case, a software-only group0 is created referencing the
root TSAR. Vports can point to this group when their QoS is enabled and
they'll be attached to the root TSAR directly. This eliminates corner
cases in the code by offering the guarantee that if qos is enabled,
vport->qos.group is non-NULL.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 36 +++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 12 ++++---
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index cfff1413dcfc..958b8894f5c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -113,7 +113,7 @@ static u32 esw_qos_calculate_group_min_rate_divider(struct mlx5_eswitch *esw,
 	/* If vports max min_rate divider is 0 but their group has bw_share
 	 * configured, then set bw_share for vports to minimal value.
 	 */
-	if (group && group->bw_share)
+	if (group->bw_share)
 		return 1;
 
 	/* A divider of 0 sets bw_share for all group vports to 0,
@@ -132,7 +132,7 @@ static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw)
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
 	list_for_each_entry(group, &esw->qos.groups, list) {
-		if (group->min_rate < max_guarantee)
+		if (group->min_rate < max_guarantee || group->tsar_ix == esw->qos.root_tsar_ix)
 			continue;
 		max_guarantee = group->min_rate;
 	}
@@ -188,6 +188,8 @@ static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw, struct netlink_e
 	int err;
 
 	list_for_each_entry(group, &esw->qos.groups, list) {
+		if (group->tsar_ix == esw->qos.root_tsar_ix)
+			continue;
 		bw_share = esw_qos_calc_bw_share(group->min_rate, divider, fw_max_bw_share);
 
 		if (bw_share == group->bw_share)
@@ -252,7 +254,7 @@ static int esw_qos_set_vport_max_rate(struct mlx5_eswitch *esw, struct mlx5_vpor
 		return 0;
 
 	/* Use parent group limit if new max rate is 0. */
-	if (vport->qos.group && !max_rate)
+	if (!max_rate)
 		act_max_rate = vport->qos.group->max_rate;
 
 	err = esw_qos_vport_config(esw, vport, act_max_rate, vport->qos.bw_share, extack);
@@ -348,19 +350,17 @@ static int esw_qos_vport_create_sched_element(struct mlx5_eswitch *esw,
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_esw_rate_group *group = vport->qos.group;
 	struct mlx5_core_dev *dev = esw->dev;
-	u32 parent_tsar_ix;
 	void *attr;
 	int err;
 
 	if (!esw_qos_element_type_supported(dev, SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT))
 		return -EOPNOTSUPP;
 
-	parent_tsar_ix = group ? group->tsar_ix : esw->qos.root_tsar_ix;
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
 	MLX5_SET(vport_element, attr, vport_number, vport->vport);
-	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent_tsar_ix);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, group->tsar_ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, max_rate);
 	MLX5_SET(scheduling_context, sched_ctx, bw_share, bw_share);
 
@@ -605,12 +605,17 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	INIT_LIST_HEAD(&esw->qos.groups);
 	if (MLX5_CAP_QOS(dev, log_esw_max_sched_depth)) {
 		esw->qos.group0 = __esw_qos_create_rate_group(esw, extack);
-		if (IS_ERR(esw->qos.group0)) {
-			esw_warn(dev, "E-Switch create rate group 0 failed (%ld)\n",
-				 PTR_ERR(esw->qos.group0));
-			err = PTR_ERR(esw->qos.group0);
-			goto err_group0;
-		}
+	} else {
+		/* The eswitch doesn't support scheduling groups.
+		 * Create a software-only group0 using the root TSAR to attach vport QoS to.
+		 */
+		if (!__esw_qos_alloc_rate_group(esw, esw->qos.root_tsar_ix))
+			esw->qos.group0 = ERR_PTR(-ENOMEM);
+	}
+	if (IS_ERR(esw->qos.group0)) {
+		err = PTR_ERR(esw->qos.group0);
+		esw_warn(dev, "E-Switch create rate group 0 failed (%d)\n", err);
+		goto err_group0;
 	}
 	refcount_set(&esw->qos.refcnt, 1);
 
@@ -628,8 +633,11 @@ static void esw_qos_destroy(struct mlx5_eswitch *esw)
 {
 	int err;
 
-	if (esw->qos.group0)
+	if (esw->qos.group0->tsar_ix != esw->qos.root_tsar_ix)
 		__esw_qos_destroy_rate_group(esw, esw->qos.group0, NULL);
+	else
+		__esw_qos_free_rate_group(esw->qos.group0);
+	esw->qos.group0 = NULL;
 
 	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
@@ -699,7 +707,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_eswitch *esw, struct mlx5_vport *vpo
 	lockdep_assert_held(&esw->state_lock);
 	if (!vport->qos.enabled)
 		return;
-	WARN(vport->qos.group && vport->qos.group != esw->qos.group0,
+	WARN(vport->qos.group != esw->qos.group0,
 	     "Disabling QoS on port before detaching it from group");
 
 	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index f208ae16bfd2..fec9e843f673 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -213,6 +213,7 @@ struct mlx5_vport {
 	struct mlx5_vport_info  info;
 
 	struct {
+		/* Initially false, set to true whenever any QoS features are used. */
 		bool enabled;
 		u32 esw_sched_elem_ix;
 		u32 min_rate;
@@ -362,14 +363,17 @@ struct mlx5_eswitch {
 	atomic64_t user_count;
 
 	struct {
-		u32             root_tsar_ix;
-		struct mlx5_esw_rate_group *group0;
-		struct list_head groups; /* Protected by esw->state_lock */
-
 		/* Protected by esw->state_lock.
 		 * Initially 0, meaning no QoS users and QoS is disabled.
 		 */
 		refcount_t refcnt;
+		u32 root_tsar_ix;
+		/* Contains all vports with QoS enabled but no explicit group.
+		 * Cannot be NULL if QoS is enabled, but may be a fake group
+		 * referencing the root TSAR if the esw doesn't support groups.
+		 */
+		struct mlx5_esw_rate_group *group0;
+		struct list_head groups; /* Protected by esw->state_lock */
 	} qos;
 
 	struct mlx5_esw_bridge_offloads *br_offloads;
-- 
2.44.0


