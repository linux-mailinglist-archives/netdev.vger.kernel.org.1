Return-Path: <netdev+bounces-136210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC89A10C6
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA151C22013
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84589212624;
	Wed, 16 Oct 2024 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eb1/w040"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B00A18660A
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100257; cv=fail; b=cQfgHrJJIZBs1qtzkoAtC2UYzcBo+tKaDhGkgVMpKNMX1hZ6LLBh+Nyg7QuquCCgsr9EepXxVuNrptgdKL6YWmhkaDL7qYDGKW7YTdM/lFMjwHh8c1cfKbHjbCAikar5oKOvftZ21s9Bq2w5mYgpgjwouEtS0zFzofR9wrRf2Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100257; c=relaxed/simple;
	bh=+HKWVqN7eu5uSpMzfyLASNS1ga42Mz+S0ePlS+NgX0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OW6NDyTXRiOG8OkFmgOjFC34chxictKyoPt2cr9oYUE2Y+q5Q79L+wNZ72B0wDpjkfCnEJDnkjnZZGDSTd/sEKHiy5QzCjWyUapgSCh31jdWgfKg8KP9KBDFR5I1fFNZxAsLS4Qblj457judSP3HiUouc/P+hIe+hu50DjfnDxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eb1/w040; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0s+CweljpA73nKZCmP6zF75enB2jb7cpTEPniGI7jRgV47u3QKk/FkxkoIbaw28KB7IMNC/zI7q1ri9QlL0aog+qxQWospuHg1Y43pN0eD0fQP8qiixiK4s9LMRHt8A2iHCrzzlemR5CEIbGW3BiOX6dsgLhRa28au9AF26c0rA6ql0I1Oz32n2XtPUl15JEb7B8zqoI0D1aaC3ruXvj7vyUrPdFSvrwBSJ+XOjDY3jj/lCRDO+TFc+CQYPQudIPAXqNvunnr2jhofl2KAIO7dZkn6RT4/BIilrgcADCUlbHRbLQsJ74IAzfpjHCVlYfWSoHjCBgccqP5Aq5glxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me44sRfqa0xvul1JJbXSzmkdk1hr18wl44TfkkQ6LW8=;
 b=p6FPAfcWrValw2oGSmhmzAFfBB59pX4Qr0ozobnWL8cALXNacQDrYkX+/JzcwJERR9NzFiZdlfdOPeBb1Xt9s9RtZfTRCPCtmara/1fqGHFSAFVFTrptO+xkvekVvs6XI5I3a36eN3QEyWnEZ7YAn0Rpjb8IZatWjdYPoAvk3rhTDUzbqek+jNo9IvP3LreDfVn3lX1089TQwvM0WsGZbOwddbFgNBvUprlqwFf8hZcZuS7L1zpT4JdpasVw4aC6LfPZ+UskkVLImkHmRNUKvnjD3+HBRNEPHYPnMGOP864ooHxqnTY6lKgCurd+KW2FK+AZdd/w7KY3RHVO37sFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me44sRfqa0xvul1JJbXSzmkdk1hr18wl44TfkkQ6LW8=;
 b=Eb1/w040lEsNzovon7fSUIufRhFWVsAgNozdZXW+wNttupC2VoHe3Bgh9hr1jkmJx62VDNXfwBU+VaWvrLlWGxKQiA2MJ/fhmVtY+zzZa6e+YaLu/L5JAfqio7ngD9iPQ33+RgkzoMwgiuehxo0ubkoOUkqFURSfKgHjYJMOgb2crs7DgEX+CvIIgH1rr4fSicTwegneMwaBzXg/Ln7f+PiG9P8i7V4nw2fiKgOkXKu8BJ2Z1JmNHm9fpB4h/ms7dcpDm58l7klQfojVwJn1J14WPMEM19X7/9hWr5M//MbMK8aU5CVXFPaUQLyjDKKainwm1TSMCtKuBQau/PyZww==
Received: from SJ0PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:33b::15)
 by SJ0PR12MB6757.namprd12.prod.outlook.com (2603:10b6:a03:449::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Wed, 16 Oct
 2024 17:37:31 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::34) by SJ0PR05CA0010.outlook.office365.com
 (2603:10b6:a03:33b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8 via Frontend
 Transport; Wed, 16 Oct 2024 17:37:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:37:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 05/15] net/mlx5: Rename vport QoS group reference to parent
Date: Wed, 16 Oct 2024 20:36:07 +0300
Message-ID: <20241016173617.217736-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241016173617.217736-1-tariqt@nvidia.com>
References: <20241016173617.217736-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SJ0PR12MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 60edd1b0-d90c-42d0-398b-08dcee09362a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sy6rE+e9ufoDh4W1jXA2H3+pw/XIa5nrrCi0SOUzJ7PQk+r814V1Yn/q6SFx?=
 =?us-ascii?Q?LUHx0BbItmK+jddvsQtzY9UfDHlrcbLgQ+7u0Ap/1oVyFCLavCsCTlqem1/z?=
 =?us-ascii?Q?tQaODi4uuCWGv+5WrvKiXfKc2DndlbCU+p2XqAekIzMV3sClyYw3r6CwBPGc?=
 =?us-ascii?Q?f5jjdanTKEzeYv9AKLsRvWjgq27WJSky+zMVeZVvgCBRhoS2AXGIE2EVndEw?=
 =?us-ascii?Q?cTe2SOnWvpVNRrRTLv338thXkOyrGvTH64qM7X24cKTMDsIjNVYw7yJ9QC1A?=
 =?us-ascii?Q?FsmkUSPoQl7t+uO/HBmvfJ49egUNfmLOZXypPk+LvcSbMCnmv9dTqifbKxzl?=
 =?us-ascii?Q?v+m1dCYMMAEB6iTqS3rYCUa/q2vMMAMybNkfmLB4U6jVx8/VQqACk0ikucQJ?=
 =?us-ascii?Q?JB/pdnbQCgD7koNV6aC/9xUubXEep2BlLupPMPVSRGp1ZgUTPxdVoZBVpU5v?=
 =?us-ascii?Q?pQL9Nk1rBOoaL2W9SY000JFPoEFDnzdx+WkxbeKB3EHcSZABxvDVpaVUtaEY?=
 =?us-ascii?Q?sQKnucylKIfB/aTgJYcLg2szeb+yZO1iWJwJVScGv7t66DJnURGqw3f5H3+h?=
 =?us-ascii?Q?TKPc3xBbIoGJC3vYsQ/veT3U4DoRPSQdQdjgzC68aq2BbBAfdBlw1p1ENR/C?=
 =?us-ascii?Q?UGRt0h7cPOHrWwsnwOphKG+9sRSHZwvbk+OLgW4KShkvR2wHmlPwHCIdbePg?=
 =?us-ascii?Q?KY5wkWel9zKsie9QShzPSYIzlHfai7kEpkopI5xst/zFPnp/BTAJEw7J3Yfx?=
 =?us-ascii?Q?oSouz8vGPJDnN6L5cMISCcH/vZg7UtIBkiuywWCDRmGe7VM5AD8umrfWyil0?=
 =?us-ascii?Q?eGD4VOkYcJRkid7Ocbepq2zupN7kx24eGgTaWeaZHJ4KTidi2DCXkGISiEG7?=
 =?us-ascii?Q?MC3iCasKMsHDdCPBVQYr5X+KbvYukWKrdHKOnepf9it5S0QVpy37p6clzIZA?=
 =?us-ascii?Q?PNgq7EC+u9+QCU3M8C+hv5bages70pzshol2dhXTjNe1dNBAsVaBlneiKO7T?=
 =?us-ascii?Q?CuC46OvzCzR8O3e3gpA1WFgeCx47K7WB05mUlps7xuUows2Jr8y0LJga1F1q?=
 =?us-ascii?Q?g4U/s3mbvAND4nlVqh00P4DYKHqqY3XvDP0X8qhz8Yb+6Qf017KSomW0KEyW?=
 =?us-ascii?Q?eIHZjAkaKgBAj9QJBODrhDC66J9ybHv5YxLb63MrRkYrs9pWsWi225ouOBHz?=
 =?us-ascii?Q?w71KiI2FGSuyP/+acMC/db7akcrdqCxq1F5LDUzN+tamgAWn8hfBaWvJQAxk?=
 =?us-ascii?Q?yBm2ytzFG5/vGtuoqBa10jxK5G3wMpLFFpOLcxZf4WVrJl3QCpoAPFFxFTXc?=
 =?us-ascii?Q?f4D2WoQc+bbbPRTb2hL2x+XiNx4A4sRHhuOkea3vMyXw2aEetcHR9dY5MYkf?=
 =?us-ascii?Q?Yg0S+U8WNBsYXIYi03xVdJR2qLph?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:37:31.0464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60edd1b0-d90c-42d0-398b-08dcee09362a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6757

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


