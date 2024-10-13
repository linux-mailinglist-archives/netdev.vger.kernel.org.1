Return-Path: <netdev+bounces-134902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB3C99B8A0
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACD82826E8
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5E113211F;
	Sun, 13 Oct 2024 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NicPT2Qk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AF130499
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802010; cv=fail; b=nGu1ZQF0kgB4EbkvtpuHrGVyX/QnG9r5RWhIgTKJB4vrik/81tFRo9QlXnTD9qr0+aHtra7/rtDL7P/RSx1NpAIFYzmjcf/nEpHBvmQLXp0jBEKPM9DD/uk5/T2Iuce3GGuMswuTZy6tszRl7pHSta6uWWXhDmGmY7jRdo2CW58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802010; c=relaxed/simple;
	bh=/8CJOu2e5aX6Ix/AuyjZfeI32Y1tTfEkg9g8gMt4j5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVTPiNnsGz5sqIuwJyc21ghT0as3z3D363zR2Dio29HfZ3x6FuAL4lax1wfPWrZKd+Gli+s20qMAlNj3bAJO8WqmlHUdNyvwVlbRLZZxkegwKyewCbiFlyRpre5CIsAy1dt9Ibe7JrCH3P+6SQmMvE8KMwaiKbV5Q6lU61UqNaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NicPT2Qk; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzYd1hddC3PR+zNVjjVDW4AmNrGiSKZmWXLpX2QbbWKDdf+0c2TSZViWysZ1WwkEfsP9Viq+r77eYghnBkKr6YxbLc8yvyb3yRjKk02ZgZUWHSlxdfTawzuK+Vo36bFlBHgvrDSUOWaApaEqqTXbf7HI3IYl7UhxMhbJ1GxjpILOPHKWfXMSoOF2CQKlGjWF8F9vJrFHjNOPcr9PJzugoWBQNfU4obZ+S/JLUTRAKymgshIk6voWb6xWJ4he9sXYnWWgqlTOPniO3ozW1fwDTlpyPhiqiDLD0vGz1wGLEBhOt2EvjVKe8HLzWV7aiiGcZmdbXmRlMHbT4h8n/n3ZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BW5T9Bd9p9Rib1LgHHq8T114lk2QU25Q6qS/0Bfv+o=;
 b=tD2/lXEW35eEh9R35SIZgO+pwfRV32JC75vbjIAyDgKZELjIHi+uLmySDJrLzvUcDfNasBWjm87p75KDm/CITYGf5e/LIjjpVDbbYJ/cq54FhqOT9q3eQHCX3f+hEIfvwWM39B/NiEYpPmzoyQS3UYA+bcggKR0XsOaH18YnlH2ke3zMIF19+eiDH45eqhQLEccxGZS7AcqMBqjXJTuOhIJ6xFzX/81AMZL99h9ecUdmcpM4UsDImxdMA8YtSzJDtcIHri3t7A9TYKRBkOUumk9wXNOcCbud5naogajv9++JIMQRNDwf8ihpc6BpG4GU2+ZULb2eiE/HP2xqqnDC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BW5T9Bd9p9Rib1LgHHq8T114lk2QU25Q6qS/0Bfv+o=;
 b=NicPT2QkRgj033piKcIM2VijVOxiEl+vyxElakyWiqcbCsR/ciK7pah8cLx2KJNASPxp4yAEBDa31rZsqv0zYoo2sKZl4NiJAswQBeEkQTDQRvDMieW/UE3cx4pu6+3at6uxGU5dQwIza+HHIXJOeXjX3BS0Fmf0+42+srkJ9jYmKNLEKHeXsCpLtq1Ou5o4AMfMRXSL+BNBiWeIYYk+YfL/iH8AQHPs0vDNJ+Fr5dc9BsCblqq+1JmrMomxXD7LvuWalQuOLmRPAWEBVIqaVyQZV2f333Rbv4QU4uHn/VHuLhZ0Kx6GZJll/7kppyehF3onTOEpabqjRrJbHq8ZXA==
Received: from CH2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:610:59::34)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Sun, 13 Oct
 2024 06:46:44 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::fa) by CH2PR03CA0024.outlook.office365.com
 (2603:10b6:610:59::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21 via Frontend
 Transport; Sun, 13 Oct 2024 06:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:31 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 05/15] net/mlx5: Rename vport QoS group reference to parent
Date: Sun, 13 Oct 2024 09:45:30 +0300
Message-ID: <20241013064540.170722-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 215f3b98-3934-4b4d-2fa9-08dceb52cd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ivjunYxwebkHDVALvpXsAJJoUNmn4tcBS+M+TIHHhFbR++7VxD4EwMJdMhzv?=
 =?us-ascii?Q?lxK5WWobrx92Ufhj0GwkZqJT00FJmR8yUN1DRomysG2cx79NlIZYZ4TJy/OI?=
 =?us-ascii?Q?4LdpKRPZqFXldKqGflgDAnoAq4bwE2A8jLftFwxYXxwZ6NC2hgHbAN74eZpJ?=
 =?us-ascii?Q?aLMOODr+qNkwq+Hua5oX5UdspUemBLpx2QAB8rzZRycJ9oWcTGBso9mYkSY4?=
 =?us-ascii?Q?ZwnUYNhLDa57sE/C96fzY2YgP66Ib00QEV0WD7H/kTvFISuBu6cbSkwQDrlb?=
 =?us-ascii?Q?0ZY7sc8bS5DNKBALArZ121SxO0tuE18PghGNpR9CqUy+O+isoRLsNSByPFnC?=
 =?us-ascii?Q?4uLOEs8zQQ1F8eaNkE8ahV7d74/QUepw+XZSbn+GrqVdrVEBqScMmQo+PeB7?=
 =?us-ascii?Q?3MGSdw5/fckvA0knnogO3uRtApLIo4ko8Gce8HqJMCIHvj7hEYlnHy1Xe6Cp?=
 =?us-ascii?Q?4td3zoxi0mo2ykbjTdDKwF60klWHLvPWMguB0dY225KNVjiL2mvSx41k7/sr?=
 =?us-ascii?Q?CnEzQFbrXYCaP9s3iqE1iUIrfmWE/+hrb6IgwP/SJIOZ2sMHPclVQMlTa+Pt?=
 =?us-ascii?Q?Y7rt8oREGdipqQS6GWoWGborl/8kYIaAxUYLeZVFyc3Db22yx5/iZQanQ7eZ?=
 =?us-ascii?Q?NUJZVhb+B8o3X+PguTAHTXJ+ip/k86Ju8SDAQHzPNfeEBmnLJs4n5FKYbE+4?=
 =?us-ascii?Q?oE1Uq+oKfv55wn3pIXGnncPnQY9A4ZpaFdmKt+09kT5aY1Y0lp6hmWBLVPYl?=
 =?us-ascii?Q?HyU48nUoxgM8x4trVT7kyf4hX8xiE6NQs7zPh+luCiC/dKNLIJ1irLa7u0vo?=
 =?us-ascii?Q?CuKx1kjPmQHVzwriVD/a9Q4tlX1qcZhSmxw+dh/ge1MNOHa9i+rWfBahGN0W?=
 =?us-ascii?Q?JwgTuZQKLl3naeN37aXKxFIfeUEAazb2qvV3uIZKcNhfi5q29SExE1EOZXnE?=
 =?us-ascii?Q?EVcakiRn7FvUDVZiYNB+fDQVm0lZMie5V+7Je0bnSrqXnmZtOXbsw5TAFRfL?=
 =?us-ascii?Q?RY+Mti0yx5oxJlCqt5NyCuneCYDDjVXD/lHn2Uvw57Dy/ritGJT0poOjG0tS?=
 =?us-ascii?Q?FiYQ0JmnwKXCojPsFbLrojFYXhBwtdo5PIABXqHoy5zBFV5shzdstZZCsFoW?=
 =?us-ascii?Q?eDFPgE++9t8soTHWPTV9jCPX2OkJTAnJGprldUv54og7DatDctQwk4fHP82t?=
 =?us-ascii?Q?iUZHVm2PeuCyWYJ9WAJIxxnAwjHa8sw94wVYXFheMRrlv/aSaEUJeotSBm0D?=
 =?us-ascii?Q?5EHBuL2wJT365pD1Mf4sOCOHgWMD3Dqcu/dxSzy3z7oHt168Ap8IYBP2Yw7C?=
 =?us-ascii?Q?is+YtGkBf13ovA+WmNnFP6xYPgElT8vetrSnUzvuTjhk81Fj0INeFZy9JFjY?=
 =?us-ascii?Q?Rr2tTg20XYdIiCArHrHmvj33Lnq+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:44.1742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 215f3b98-3934-4b4d-2fa9-08dceb52cd40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094

From: Carolina Jubran <cjubran@nvidia.com>

Rename the `group` field in the `mlx5_vport` structure to `parent` to
clarify the vport's role as a member of a parent group and distinguish
it from the concept of a general group.

Additionally, rename `group_entry` to `parent_entry` to reflect this
update.

This distinction will be important for handling more complex group
structures and scheduling elements.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
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
index 65fd346d0e91..67b87f1598a5 100644
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
@@ -714,8 +714,8 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
-	INIT_LIST_HEAD(&vport->qos.group_entry);
-	esw_qos_vport_set_group(vport, esw->qos.group0);
+	INIT_LIST_HEAD(&vport->qos.parent_entry);
+	esw_qos_vport_set_parent(vport, esw->qos.group0);
 
 	err = esw_qos_vport_create_sched_element(vport, max_rate, bw_share);
 	if (err)
@@ -742,10 +742,10 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
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
@@ -887,7 +887,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
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


