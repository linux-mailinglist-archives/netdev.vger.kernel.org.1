Return-Path: <netdev+bounces-135325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBEC99D898
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1371F2224E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DDD1CB330;
	Mon, 14 Oct 2024 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bcDbG0+r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE01D1318
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939276; cv=fail; b=oYDWff8zxYEdO0UNoVP706JRrWjxqrYNrpJTu/hwWBOb/TfWTfzYMkawHJT3UTVp2UIKNaJjE8f85R5NH9Ujc1p1y7H+UHG+4P6nqwDfWMfGEWxeyXuhRfDSQ25ytAfZgemhq471KKo6BHhcLYLtmUuWQOBGmX3EKIibHgLS5+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939276; c=relaxed/simple;
	bh=+HKWVqN7eu5uSpMzfyLASNS1ga42Mz+S0ePlS+NgX0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbRHt7GqTPoClDjGVnOq6rugF/eQ+iuqrtQqeU/5yOMbiblg2Iu4usG/vCbMIQqOn7GklNYDP3m+qpNJF2FvbZ6JDkGoW/xg680e6a6Ty+QQO8WgTa5ILbFbVZU9eomaUjmNvdFG7tyvBF23/80WGXDEZpBqYXTcQnhYQjDCc2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bcDbG0+r; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6MQ2AgM6qn3SxoGHqR5pjVsKhdCWWkWOJ+vP4x4991goYpGScbCE3Tp1+JhZRxqp24cBeIncxcKu3YZ3F5r69TtCjkOyfV4vCu2JrnpW7gENf2oAJTgo2Woyi6LNzmdgjvjqZ6W/AbQCdOv5EWkC4wMVN/0mz3fL6dpautPdcygSuHQGvQ8THrGC20NPQd3WWalAoBWC0U3BjmKJbHq7BeX+4tYgA4WdWyGzkmK2iC8v3RG6K4NMVJPytSo6xK+4eJUASNvV/yf6LvvBTpJfrNXCEpDW3Hh3e6l2WYgXQqbWNTtKjzBsdlP9PMuHYG7UI8T4y4nf5yjQeiiDsd6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me44sRfqa0xvul1JJbXSzmkdk1hr18wl44TfkkQ6LW8=;
 b=oHbDGu0Tjch3GQeEobZktloPtQqRRxLLpkfGRE8v0ousSJoYTygS20IN7ukL4Vn1PTRM1nmGL6ToZXC9NtFsHi5OiEgquB4C6TkdOWG2u7JixRUWbb4ECBPNOHWFXgdF6a2naZ4FADgkeQek+s7dVeaC+0HErad9Pv4dadyd6VPmmJDWJtZHQ0jy1ED8udX9EHFIUTa0s3bTT9DVArOV6chnrw9cKsrSKDJgWmw9yc8DPaSumHiZoXx3KtOnkNCLUqcNweFe32kyDJo0FK7JBslBl0angygkzzR0r/R1EAQpTqe/7g8Z96vEkYFnerkUgpHQcaT2Y3NBNnsfXho8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me44sRfqa0xvul1JJbXSzmkdk1hr18wl44TfkkQ6LW8=;
 b=bcDbG0+rfJSPO8R2ecVEExViKFMBCqHrchR4y5FYbIvX53Gc4rz+IMfSsz9DOvY3ibtzVB6xjOdmJg+2wUYvqA0YBcliBYTCSHYEPdz96fcVX7AYXM0QlOMDpF3uBEqp1DcebTwhmx05EJNW6Yvv/L9pssZQNO0gd7y+THqdWO6re28P72zeLdYfp7jNMFVtvc1ixSbVIyGS+V7ZWHazlhjfq8eREJjKijnaeZ69DOmvvfRaxleVa0dITyOvJya2apb/vl1qUAmIvm5J2YP8rGwW6TglABDkQecZ7z2vPX/n58E3VtiQAG27qkRUo1VmZ3Tr766/haAtT4yLMoqYKA==
Received: from DM6PR21CA0013.namprd21.prod.outlook.com (2603:10b6:5:174::23)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 20:54:29 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:174:cafe::93) by DM6PR21CA0013.outlook.office365.com
 (2603:10b6:5:174::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.4 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Mon, 14 Oct 2024 20:54:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:14 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 05/15] net/mlx5: Rename vport QoS group reference to parent
Date: Mon, 14 Oct 2024 23:52:50 +0300
Message-ID: <20241014205300.193519-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: c6cb26b3-6511-4b7f-c6a3-08dcec926559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CXruT/d0yntf1Wf0x61tTv49vhiyAfT/SzwaR8k7g2+fiPKopP5eHRBhB+2g?=
 =?us-ascii?Q?3Hyk5BT3Mx52BvK2lZRUKhU7Woe/ioYE64/EeZAWq+vG4OJBIp3n2ERSE1Xz?=
 =?us-ascii?Q?bsc+hH4MlxRJeXtlDtHw0Aci0kHN+WqVToWTtoG4ZdIBCFOTdpAjyXVvsF6k?=
 =?us-ascii?Q?WB2RoHgHqACdTM7ISSbbAZeqhWyC7vNjE4/q1/zti/ffO2EV4y2paWgvbvMm?=
 =?us-ascii?Q?TATaTTuUGZx0kHSfPQWFjQ2mToT6j+rCslscHPAMoa0ihLSETVStQHlnIXT6?=
 =?us-ascii?Q?yyCIlqyNFoA6Ep97YuSkwojXf85vrN3HwIPZMtG7Tmk6Ds7pLFjxwWfAMf5a?=
 =?us-ascii?Q?i9/ihqTsJTKUjvokVuwWqeriCZeKA44TNVonoVcUNM7wDJfYVqKH5F94m9oF?=
 =?us-ascii?Q?fTebDe3G1knIYv9lk6Jl2z7PAp9YyBZD16+B3zi1q38F0Nf5g+mkLNT0PbSq?=
 =?us-ascii?Q?3XNsLo1cFlIrKI3ahL5fhAYwZ+CTiH7/r/gqym+UFGYVEKfmmEfBFgktqzbA?=
 =?us-ascii?Q?NkL4uOLo6566RuKy1KM/U/Bfrt1VhHiksn75uq/g4cn8XziiZj6hW7OkUNJZ?=
 =?us-ascii?Q?Fc5jlws+/IHlE7WfDsGJ1cAF4X/fgLJAT2y35kCjDXk19Vj6nX6mRKeeiPnR?=
 =?us-ascii?Q?fSbrEmCL338OY5ix3dEVBW9rkJS/QaKZWMLA8NxKGdCDL5yl4XsuJm1wEetz?=
 =?us-ascii?Q?Xl7mrBFBz7f/OSkS0F59SosB2vA3KuZ70kQkLxvV+51dXPoId7zPwYZgy921?=
 =?us-ascii?Q?pI5UzHhQlaOHZVWRu6EaRHEsswMq36YIm3ye1WXmBiScDdNBL4jE1K/sHF8k?=
 =?us-ascii?Q?7zaEhe5J1aBs/glnJqzNKIEwRO6/H3j6FvzZHVSZsfK7tKf1/RtnvWNbj3r4?=
 =?us-ascii?Q?1KVOlnCGEXgF+aErKsWl9gAKwJLL+n0I5Zm2m3yatHRnbcRb3/TNk3WVaI7H?=
 =?us-ascii?Q?YNA2LinI4FK+s5Yve7/rlpPKNhjblzRjZVn7kKE95sEfW1xBgAdzvV+Owz8L?=
 =?us-ascii?Q?WEiGFoC5Dx6OuYceiPtuA89BNXxqfygBVJxIRMpBXZov6s8y9CzDYT0oadqF?=
 =?us-ascii?Q?u+P+CvUoSPOCot5pWegV211akIq6A00dC6EvSu9d0kZWJarQKgNj5ZFRUw6k?=
 =?us-ascii?Q?WSBiErkvMts27J4HGGrfAhyQAx/o8KJjkVqrW/CT4bzISc2fiMm94ZtBdDwS?=
 =?us-ascii?Q?ey/JsllwdIHKGlWJmld92wgkJnAI51UC0LsO+CohfsQPejDhobgwGz5s5bVd?=
 =?us-ascii?Q?lQwd4v6bRAsGnKd0O8t23FRaTDHOki5zynlx85kTgGPkZF0YlqgRQZAufQ8X?=
 =?us-ascii?Q?+wMUHTMJY47c/3CXZYGWoF2mLNeI6i9fDhg7aZnFqCIVYNQTuT5AIUxu6Csd?=
 =?us-ascii?Q?Z+l821AYuoPJ4RfwM3AHkgZhfUJw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:28.7967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cb26b3-6511-4b7f-c6a3-08dcec926559
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474

From: Carolina Jubran <cjubran@nvidia.com>

Rename the `group` field in the `mlx5_vport` structure to `parent` to
clarify the vport's role as a member of a parent group and distinguish
it from the concept of a general group.

Additionally, rename `group_entry` to `parent_entry` to reflect this
update.

This distinction will be important for handling more complex group
structures and scheduling elements.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/esw/diag/qos_tracepoint.h       |  8 ++--
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 42 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  6 ++-
 3 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
index 645bad0d625f..2aea01959073 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/diag/qos_tracepoint.h
@@ -35,18 +35,18 @@ DECLARE_EVENT_CLASS(mlx5_esw_vport_qos_template,
 				     __field(unsigned int, sched_elem_ix)
 				     __field(unsigned int, bw_share)
 				     __field(unsigned int, max_rate)
-				     __field(void *, group)
+				     __field(void *, parent)
 				     ),
 		    TP_fast_assign(__assign_str(devname);
 			    __entry->vport_id = vport->vport;
 			    __entry->sched_elem_ix = vport->qos.esw_sched_elem_ix;
 			    __entry->bw_share = bw_share;
 			    __entry->max_rate = max_rate;
-			    __entry->group = vport->qos.group;
+			    __entry->parent = vport->qos.parent;
 		    ),
-		    TP_printk("(%s) vport=%hu sched_elem_ix=%u bw_share=%u, max_rate=%u group=%p\n",
+		    TP_printk("(%s) vport=%hu sched_elem_ix=%u bw_share=%u, max_rate=%u parent=%p\n",
 			      __get_str(devname), __entry->vport_id, __entry->sched_elem_ix,
-			      __entry->bw_share, __entry->max_rate, __entry->group
+			      __entry->bw_share, __entry->max_rate, __entry->parent
 			      )
 );
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index dd6fe729f456..837c4dda814d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -84,11 +84,11 @@ struct mlx5_esw_rate_group {
 	struct list_head members;
 };
 
-static void esw_qos_vport_set_group(struct mlx5_vport *vport, struct mlx5_esw_rate_group *group)
+static void esw_qos_vport_set_parent(struct mlx5_vport *vport, struct mlx5_esw_rate_group *parent)
 {
-	list_del_init(&vport->qos.group_entry);
-	vport->qos.group = group;
-	list_add_tail(&vport->qos.group_entry, &group->members);
+	list_del_init(&vport->qos.parent_entry);
+	vport->qos.parent = parent;
+	list_add_tail(&vport->qos.parent_entry, &parent->members);
 }
 
 static int esw_qos_sched_elem_config(struct mlx5_core_dev *dev, u32 sched_elem_ix,
@@ -131,7 +131,7 @@ static int esw_qos_vport_config(struct mlx5_vport *vport,
 				u32 max_rate, u32 bw_share,
 				struct netlink_ext_ack *extack)
 {
-	struct mlx5_core_dev *dev = vport->qos.group->esw->dev;
+	struct mlx5_core_dev *dev = vport->qos.parent->esw->dev;
 	int err;
 
 	err = esw_qos_sched_elem_config(dev, vport->qos.esw_sched_elem_ix, max_rate, bw_share);
@@ -157,7 +157,7 @@ static u32 esw_qos_calculate_group_min_rate_divider(struct mlx5_esw_rate_group *
 	/* Find max min_rate across all vports in this group.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
-	list_for_each_entry(vport, &group->members, qos.group_entry) {
+	list_for_each_entry(vport, &group->members, qos.parent_entry) {
 		if (vport->qos.min_rate > max_guarantee)
 			max_guarantee = vport->qos.min_rate;
 	}
@@ -217,7 +217,7 @@ static int esw_qos_normalize_group_min_rate(struct mlx5_esw_rate_group *group,
 	u32 bw_share;
 	int err;
 
-	list_for_each_entry(vport, &group->members, qos.group_entry) {
+	list_for_each_entry(vport, &group->members, qos.parent_entry) {
 		bw_share = esw_qos_calc_bw_share(vport->qos.min_rate, divider, fw_max_bw_share);
 
 		if (bw_share == vport->qos.bw_share)
@@ -286,7 +286,7 @@ static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 
 	previous_min_rate = vport->qos.min_rate;
 	vport->qos.min_rate = min_rate;
-	err = esw_qos_normalize_group_min_rate(vport->qos.group, extack);
+	err = esw_qos_normalize_group_min_rate(vport->qos.parent, extack);
 	if (err)
 		vport->qos.min_rate = previous_min_rate;
 
@@ -311,7 +311,7 @@ static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
 
 	/* Use parent group limit if new max rate is 0. */
 	if (!max_rate)
-		act_max_rate = vport->qos.group->max_rate;
+		act_max_rate = vport->qos.parent->max_rate;
 
 	err = esw_qos_vport_config(vport, act_max_rate, vport->qos.bw_share, extack);
 
@@ -366,7 +366,7 @@ static int esw_qos_set_group_max_rate(struct mlx5_esw_rate_group *group,
 	group->max_rate = max_rate;
 
 	/* Any unlimited vports in the group should be set with the value of the group. */
-	list_for_each_entry(vport, &group->members, qos.group_entry) {
+	list_for_each_entry(vport, &group->members, qos.parent_entry) {
 		if (vport->qos.max_rate)
 			continue;
 
@@ -409,9 +409,9 @@ static int esw_qos_create_group_sched_elem(struct mlx5_core_dev *dev, u32 parent
 static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 					      u32 max_rate, u32 bw_share)
 {
+	struct mlx5_esw_rate_group *parent = vport->qos.parent;
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
-	struct mlx5_esw_rate_group *group = vport->qos.group;
-	struct mlx5_core_dev *dev = group->esw->dev;
+	struct mlx5_core_dev *dev = parent->esw->dev;
 	void *attr;
 	int err;
 
@@ -424,7 +424,7 @@ static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
 	MLX5_SET(vport_element, attr, vport_number, vport->vport);
-	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, group->tsar_ix);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent->tsar_ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, max_rate);
 	MLX5_SET(scheduling_context, sched_ctx, bw_share, bw_share);
 
@@ -458,7 +458,7 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_vport *vport,
 		return err;
 	}
 
-	esw_qos_vport_set_group(vport, new_group);
+	esw_qos_vport_set_parent(vport, new_group);
 	/* Use new group max rate if vport max rate is unlimited. */
 	max_rate = vport->qos.max_rate ? vport->qos.max_rate : new_group->max_rate;
 	err = esw_qos_vport_create_sched_element(vport, max_rate, vport->qos.bw_share);
@@ -470,7 +470,7 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_vport *vport,
 	return 0;
 
 err_sched:
-	esw_qos_vport_set_group(vport, curr_group);
+	esw_qos_vport_set_parent(vport, curr_group);
 	max_rate = vport->qos.max_rate ? vport->qos.max_rate : curr_group->max_rate;
 	if (esw_qos_vport_create_sched_element(vport, max_rate, vport->qos.bw_share))
 		esw_warn(curr_group->esw->dev, "E-Switch vport group restore failed (vport=%d)\n",
@@ -488,7 +488,7 @@ static int esw_qos_vport_update_group(struct mlx5_vport *vport,
 	int err;
 
 	esw_assert_qos_lock_held(esw);
-	curr_group = vport->qos.group;
+	curr_group = vport->qos.parent;
 	new_group = group ?: esw->qos.group0;
 	if (curr_group == new_group)
 		return 0;
@@ -715,8 +715,8 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
-	INIT_LIST_HEAD(&vport->qos.group_entry);
-	esw_qos_vport_set_group(vport, esw->qos.group0);
+	INIT_LIST_HEAD(&vport->qos.parent_entry);
+	esw_qos_vport_set_parent(vport, esw->qos.group0);
 
 	err = esw_qos_vport_create_sched_element(vport, max_rate, bw_share);
 	if (err)
@@ -743,10 +743,10 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	esw_qos_lock(esw);
 	if (!vport->qos.enabled)
 		goto unlock;
-	WARN(vport->qos.group != esw->qos.group0,
+	WARN(vport->qos.parent != esw->qos.group0,
 	     "Disabling QoS on port before detaching it from group");
 
-	dev = vport->qos.group->esw->dev;
+	dev = vport->qos.parent->esw->dev;
 	err = mlx5_destroy_scheduling_element_cmd(dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
 						  vport->qos.esw_sched_elem_ix);
@@ -888,7 +888,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 		/* Eswitch QoS wasn't enabled yet. Enable it and vport QoS. */
 		err = esw_qos_vport_enable(vport, rate_mbps, vport->qos.bw_share, NULL);
 	} else {
-		struct mlx5_core_dev *dev = vport->qos.group->esw->dev;
+		struct mlx5_core_dev *dev = vport->qos.parent->esw->dev;
 
 		MLX5_SET(scheduling_context, ctx, max_average_bw, rate_mbps);
 		bitmask = MODIFY_SCHEDULING_ELEMENT_IN_MODIFY_BITMASK_MAX_AVERAGE_BW;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 3b901bd36d4b..e789fb14989b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -221,8 +221,10 @@ struct mlx5_vport {
 		u32 max_rate;
 		/* A computed value indicating relative min_rate between vports in a group. */
 		u32 bw_share;
-		struct mlx5_esw_rate_group *group;
-		struct list_head group_entry;
+		/* The parent group of this vport scheduling element. */
+		struct mlx5_esw_rate_group *parent;
+		/* Membership in the parent 'members' list. */
+		struct list_head parent_entry;
 	} qos;
 
 	u16 vport;
-- 
2.44.0


