Return-Path: <netdev+bounces-133264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2086A9956A3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449391C2453A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C51213EDD;
	Tue,  8 Oct 2024 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y4V2IgEC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B50213EC7
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412413; cv=fail; b=KYrOyaEQ5Y8omW1SdWenukzDBxMG3Qh4Avtp/iY+S4V6sYghwRguhkFb42j8EQsqQIBJbKe+NHOP0WhdpiqZo098tZWcR/DBV9lBjfygDaLChx+gWSp8+VngVOVQMvidOXsexdZY6jUziViMtimPaqC6T7sjwZ4u+pebiH8b9GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412413; c=relaxed/simple;
	bh=rP8E7S48pT1K2+1IRumV2Yven0+L4P59N33dDF/xcvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzQLZW9M9iuiatDyiyvWmaKHuA4KddD7VV11acqi0cJWsEQusWIsV3+M7dn3/9VtRntYaryfNOLTwRSoiHa3FIBu0kBxzp0YqRKhqW1k/k2Paievnw9sM6pHO1RaW5IeZj+k9e398hZof7bfYEksK7m+SZGpBBMvmEm9BzJ7XoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y4V2IgEC; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3+euzyWER8qHMVQGF9y0As6I+PxmLx+9Lcg/Z9ZRQlqf4yNvLJG3FCSEZf+HI5ZA3wfZNtG8f+xbPOnkifIgQweKmdUvFE3xPiXhcu8hhQ42JHvljD615Ok9+DeIstkLg1QhR2yDHIGyYjXMjYyYHQtbzYu5uvMvZLclqNcJnHkODMhAP/M2NIbx/H1Nry1NBF5LWY4y+7cFcHwSSWiHaXeroTApRiwv4G+XcR9lMrmVTxhh92W9WIQBnh4YwC2gC9oZXDEFiJLApFLS3IOiTbBS0pwtrhJN/Lfk886JxaBfdGGG9hlzc1Z7mOasc1DWlnvdjDrQqQaez3DODUXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHm7vGy76Chz5x4fA8zmunWKwrTt27pwupjcMRXfayw=;
 b=XDudidoCTo7GJKljK5WEAtLIADqiNv+IQjI6H08L9Dzs4tg51RynOvjOZ+tNq0i5HMyZAWu+H13pHdzuQtG2D6dHPf6GPC+3lbf194CqpPomnSKFKdOzm4rhBNSTM6bCv2WzB6N+7s6natp4U1dj1xK1V8PaNZ+/ZZo9oA0vg06VBHqumuqcbiSj+GIOs7bJD+TEVOlMmVhZAiBDHqwaQmymqTdCvDR+UgpoWygmKh8k8VpW6zngG0MW7bl/MwiM1pw+S7M7Xmc++42U5dznYMH58oEIFveBwWdJaxDLvKmlQIeSrCYg91JXsfmzWX6njFYFjEh/s9JB1lDr2MahOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHm7vGy76Chz5x4fA8zmunWKwrTt27pwupjcMRXfayw=;
 b=Y4V2IgEC+qyzVI5krBbTPWKs53kf/jvEZt74jkBK10tpffDzyhiogmhrkOWMKFmVaD87U5c5q/WF8FxfSBconk6VHRrhTJhudu2sSpv9yXcTHJ4t4YYP1+g25PGBK46HS6v9TrJ2T4ZNAJHfOKrGC1tCIW0NtOs1g5rdZu38ZtCMbiTFD4H0K5yUvdAnt3pbCUeFFJxUc4E085w1LWvSkwlFYN7FA3zx8TAwJ/6sDkK/noVyH+p0CUW7n/umvFA9mhQ8Yt3NCzeqpbOJpTZKU2Xsy3IscI/+8YOmQ8iMfsopY1ESf/u7Qkihc7tB0T7WCzgNteDqhTTPJ/FO9Uo58g==
Received: from PH1PEPF000132FA.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2b)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 18:33:26 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF000132FA.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 05/14] net/mlx5: qos: Maintain rate group vport members in a list
Date: Tue, 8 Oct 2024 21:32:13 +0300
Message-ID: <20241008183222.137702-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 41688264-263f-4ffd-7c9a-08dce7c7b241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YF/WG0T06uffcdbQfDJoPqx3e6j4wPWArnLKJPOk9AeicQyPWrW0qvrVl+ah?=
 =?us-ascii?Q?cJW4z4LHAtjN23q0iNWfCmgYEub0XVk1pTTv4zJoJDBIXXE6JBBPcbEFpqsh?=
 =?us-ascii?Q?rAx32SwOoQO58ZU5dnS7qFprvu91A0FDz7uIsY+xMuNRy3vfTn7XSFLbpQQs?=
 =?us-ascii?Q?UXEzHOGFjTtc3s3VX+rGflEr2Nv9uiNnEB5IxxbeUAN/qoIvsJ2fR+6WGhOV?=
 =?us-ascii?Q?nuaqwRj4fzDm9UAiqwPvWdHh1KZNPCmzZQX7RVlzR8YYIJbNXTn1tv1c1dmf?=
 =?us-ascii?Q?V/zxRPBJfOytvhkb/lWMTSWkrLzRZ3p+yrw2+Ow4+LrDNHmBeIlhLJcNARM7?=
 =?us-ascii?Q?aoN4iwvJ5UauA7SikKp6RTEQf1KiMkLT0HYWoVoohmqnHfn2Vp8SCzhKJkwi?=
 =?us-ascii?Q?LtScUcMa/x1Hr5UyaeqNhNtuSXJr2dbusehfiUFjeN6u91xoABO7o47PuAYE?=
 =?us-ascii?Q?GkEnUluXPNM+7ME0muMvW5Y+UnPKqwA42Ut3kToZUSaWXxFDz0KmuBzdy/sn?=
 =?us-ascii?Q?WIB5uEw9YyEZzDji5dGLIna/4O2pThVEJtww3DeEVi75ytLoeEdvgj5msGHY?=
 =?us-ascii?Q?WUKhUStLoICm3zo5www2JxE6ko19SIbq/VoYiKm7O0Np/FnWVvCFtLsyUWoe?=
 =?us-ascii?Q?DRy4J/PnUFPXGL/ST50uJzef0aKuJ8Epg2EWNMT3naUtC2KRBqyRTFSURR0q?=
 =?us-ascii?Q?BJMaMT/Xc3LXNqUpJosrkLKtgCJHzyaMtj/dySiUjXG098fJajGyCkAnv/9u?=
 =?us-ascii?Q?XVAmdkVGo/4nKG4w3dSxc71W5zHYHVEsqisQ54kdRPhYiFWH9SPIbZhKSdTr?=
 =?us-ascii?Q?byMQm07ZXIpOGmQNf1j9Adk/6OPz1xSsZG6peCsYG+jNWrByUgpbF8lvcHau?=
 =?us-ascii?Q?ooIxVNDaOkugKUhC3qR0XjlVN+AaWBNNv7tEhkNhxd81uM2lBhPzIeG4koxZ?=
 =?us-ascii?Q?2UsAL0ZUvZAXx/WyjL1/2UL4O61PTc4uJBI1PPjZdZ9TDeNo1y+SflvDgx3R?=
 =?us-ascii?Q?YDBmi2ouUmyqa3Zyz1TfmhOgXcgNUF27hgbnuD4OCcI9zNg6IcaWF6pnHU96?=
 =?us-ascii?Q?0ouWeRieK3PxJVoOAjMdcfHS/afGHvgH9fpKLjNEx6/aVmfdKyJ183IpJzz4?=
 =?us-ascii?Q?jYkfCN3mNzUvM2v2dJrqzFQagC6u6cHaHcPys5UzUfjOvcXqubYzJF5X2nIz?=
 =?us-ascii?Q?JV93TDyl0006ZDXaq4n+Ad8VXu10yki+HDjQXiJ8ZyGFXoT8jeK7Pbya6ImH?=
 =?us-ascii?Q?5bquUcx59q+Rwljk/mQ9Iwtp29V3RG/GnoguN6CY3wV/zvB5UFYxZy172Yv7?=
 =?us-ascii?Q?hBzMAlFcTeDSKGm70wOuP3ieH7cUt7GYADTIrGIcT/X/vbDQ4blG2G+AbXwv?=
 =?us-ascii?Q?4d99xBKCwVGZs/xreA3zmfBbpc9c?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:25.3974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41688264-263f-4ffd-7c9a-08dce7c7b241
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

From: Cosmin Ratiu <cratiu@nvidia.com>

Previously, finding group members was done by iterating over all vports
of an eswitch and comparing their group with the required one, but that
approach will break down when a group can contain vports from multiple
eswitches.

Solve that by maintaining a list of vport members.
Instead of iterating over esw vports, loop over the members list.
Use this opportunity to provide two new functions to allocate and free a
group, so that the number of state transitions is smaller. This will
also be used in a future patch.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 94 +++++++++++--------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  1 +
 2 files changed, 58 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index a8231a498ed6..cfff1413dcfc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -20,8 +20,17 @@ struct mlx5_esw_rate_group {
 	/* A computed value indicating relative min_rate between group members. */
 	u32 bw_share;
 	struct list_head list;
+	/* Vport members of this group.*/
+	struct list_head members;
 };
 
+static void esw_qos_vport_set_group(struct mlx5_vport *vport, struct mlx5_esw_rate_group *group)
+{
+	list_del_init(&vport->qos.group_entry);
+	vport->qos.group = group;
+	list_add_tail(&vport->qos.group_entry, &group->members);
+}
+
 static int esw_qos_sched_elem_config(struct mlx5_core_dev *dev, u32 sched_elem_ix,
 				     u32 max_rate, u32 bw_share)
 {
@@ -89,17 +98,13 @@ static u32 esw_qos_calculate_group_min_rate_divider(struct mlx5_eswitch *esw,
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
 	struct mlx5_vport *vport;
 	u32 max_guarantee = 0;
-	unsigned long i;
-
 
 	/* Find max min_rate across all vports in this group.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
-	mlx5_esw_for_each_vport(esw, i, vport) {
-		if (!vport->enabled || !vport->qos.enabled ||
-		    vport->qos.group != group || vport->qos.min_rate < max_guarantee)
-			continue;
-		max_guarantee = vport->qos.min_rate;
+	list_for_each_entry(vport, &group->members, qos.group_entry) {
+		if (vport->qos.min_rate > max_guarantee)
+			max_guarantee = vport->qos.min_rate;
 	}
 
 	if (max_guarantee)
@@ -155,13 +160,10 @@ static int esw_qos_normalize_group_min_rate(struct mlx5_eswitch *esw,
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
 	u32 divider = esw_qos_calculate_group_min_rate_divider(esw, group);
 	struct mlx5_vport *vport;
-	unsigned long i;
 	u32 bw_share;
 	int err;
 
-	mlx5_esw_for_each_vport(esw, i, vport) {
-		if (!vport->enabled || !vport->qos.enabled || vport->qos.group != group)
-			continue;
+	list_for_each_entry(vport, &group->members, qos.group_entry) {
 		bw_share = esw_qos_calc_bw_share(vport->qos.min_rate, divider, fw_max_bw_share);
 
 		if (bw_share == vport->qos.bw_share)
@@ -295,7 +297,6 @@ static int esw_qos_set_group_max_rate(struct mlx5_eswitch *esw,
 				      u32 max_rate, struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport;
-	unsigned long i;
 	int err;
 
 	if (group->max_rate == max_rate)
@@ -308,9 +309,8 @@ static int esw_qos_set_group_max_rate(struct mlx5_eswitch *esw,
 	group->max_rate = max_rate;
 
 	/* Any unlimited vports in the group should be set with the value of the group. */
-	mlx5_esw_for_each_vport(esw, i, vport) {
-		if (!vport->enabled || !vport->qos.enabled ||
-		    vport->qos.group != group || vport->qos.max_rate)
+	list_for_each_entry(vport, &group->members, qos.group_entry) {
+		if (vport->qos.max_rate)
 			continue;
 
 		err = esw_qos_vport_config(esw, vport, max_rate, vport->qos.bw_share, extack);
@@ -395,7 +395,7 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_eswitch *esw,
 		return err;
 	}
 
-	vport->qos.group = new_group;
+	esw_qos_vport_set_group(vport, new_group);
 	/* Use new group max rate if vport max rate is unlimited. */
 	max_rate = vport->qos.max_rate ? vport->qos.max_rate : new_group->max_rate;
 	err = esw_qos_vport_create_sched_element(esw, vport, max_rate, vport->qos.bw_share);
@@ -407,7 +407,7 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_eswitch *esw,
 	return 0;
 
 err_sched:
-	vport->qos.group = curr_group;
+	esw_qos_vport_set_group(vport, curr_group);
 	max_rate = vport->qos.max_rate ? vport->qos.max_rate : curr_group->max_rate;
 	if (esw_qos_vport_create_sched_element(esw, vport, max_rate, vport->qos.bw_share))
 		esw_warn(esw->dev, "E-Switch vport group restore failed (vport=%d)\n",
@@ -446,16 +446,33 @@ static int esw_qos_vport_update_group(struct mlx5_eswitch *esw,
 }
 
 static struct mlx5_esw_rate_group *
-__esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
+__esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix)
 {
-	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_esw_rate_group *group;
-	void *attr;
-	int err;
 
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	if (!group)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
+
+	group->tsar_ix = tsar_ix;
+	INIT_LIST_HEAD(&group->members);
+	list_add_tail(&group->list, &esw->qos.groups);
+	return group;
+}
+
+static void __esw_qos_free_rate_group(struct mlx5_esw_rate_group *group)
+{
+	list_del(&group->list);
+	kfree(group);
+}
+
+static struct mlx5_esw_rate_group *
+__esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
+{
+	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	struct mlx5_esw_rate_group *group;
+	int tsar_ix, err;
+	void *attr;
 
 	MLX5_SET(scheduling_context, tsar_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
@@ -466,13 +483,18 @@ __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *ex
 	err = mlx5_create_scheduling_element_cmd(esw->dev,
 						 SCHEDULING_HIERARCHY_E_SWITCH,
 						 tsar_ctx,
-						 &group->tsar_ix);
+						 &tsar_ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for group failed");
-		goto err_sched_elem;
+		return ERR_PTR(err);
 	}
 
-	list_add_tail(&group->list, &esw->qos.groups);
+	group = __esw_qos_alloc_rate_group(esw, tsar_ix);
+	if (!group) {
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc group failed");
+		err = -ENOMEM;
+		goto err_alloc_group;
+	}
 
 	err = esw_qos_normalize_min_rate(esw, extack);
 	if (err) {
@@ -484,13 +506,12 @@ __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *ex
 	return group;
 
 err_min_rate:
-	list_del(&group->list);
+	__esw_qos_free_rate_group(group);
+err_alloc_group:
 	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
 						SCHEDULING_HIERARCHY_E_SWITCH,
-						group->tsar_ix))
+						tsar_ix))
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for group failed");
-err_sched_elem:
-	kfree(group);
 	return ERR_PTR(err);
 }
 
@@ -523,21 +544,19 @@ static int __esw_qos_destroy_rate_group(struct mlx5_eswitch *esw,
 {
 	int err;
 
-	list_del(&group->list);
-
-	err = esw_qos_normalize_min_rate(esw, extack);
-	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch groups normalization failed");
+	trace_mlx5_esw_group_qos_destroy(esw->dev, group, group->tsar_ix);
 
 	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
 						  group->tsar_ix);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR_ID failed");
+	__esw_qos_free_rate_group(group);
 
-	trace_mlx5_esw_group_qos_destroy(esw->dev, group, group->tsar_ix);
+	err = esw_qos_normalize_min_rate(esw, extack);
+	if (err)
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch groups normalization failed");
 
-	kfree(group);
 
 	return err;
 }
@@ -655,7 +674,8 @@ static int esw_qos_vport_enable(struct mlx5_eswitch *esw, struct mlx5_vport *vpo
 	if (err)
 		return err;
 
-	vport->qos.group = esw->qos.group0;
+	INIT_LIST_HEAD(&vport->qos.group_entry);
+	esw_qos_vport_set_group(vport, esw->qos.group0);
 
 	err = esw_qos_vport_create_sched_element(esw, vport, max_rate, bw_share);
 	if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index ce857eae6898..f208ae16bfd2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -220,6 +220,7 @@ struct mlx5_vport {
 		/* A computed value indicating relative min_rate between vports in a group. */
 		u32 bw_share;
 		struct mlx5_esw_rate_group *group;
+		struct list_head group_entry;
 	} qos;
 
 	u16 vport;
-- 
2.44.0


