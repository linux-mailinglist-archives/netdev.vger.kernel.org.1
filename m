Return-Path: <netdev+bounces-133267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAAC9956A6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D045628664C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1BA213EE8;
	Tue,  8 Oct 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FQrM+aOR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE4213ED4
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412424; cv=fail; b=JKWefSYZLq5np9oVn6uHMzv/hfaYqzN+QTqLcEQlcjK5YDdRegnfXJQ8WZV4xCI1KOt0JNlB4QQ92XAIpAQXAYkq4WuVzcj+6kBSEwaXmPZMi7zzuKSi0uYITXMIo8ZfToCVpuBEbj47vQAAUdUoBS4h9SDNez/b7/+SuylLrCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412424; c=relaxed/simple;
	bh=5cnuxLP1utqLiqnqOj4ylLuIR6PY3PWbKtL89VULPoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtMXeoXXAfzyX5DXDstAsPxojgM8VYW2uAKf7VZv0OlEksPXyqx45Td23pW8lV6AegOXIBZlagPa4ASXoC/zmJFAM+FFJtXe2SgK6PDpOeE4TneyOfd1dCoxex1mQlwA791ntTdSwEgx6ubEJF8+kSGACrFBkeSPzfJmfGFsWKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FQrM+aOR; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZefnwQeLi5ysb4aBu0BMrQjIBxz8Oe1zoeKSKkzXw73Ufb3N6HnXkrj4AQPHJ6wUyaxB6ahv41o+PEak0L8yyPekFMSG1aXEQjLshUvSbSdUbtHBGKMFRr7KdNcO9Jy9TOO6YR3imwvtSrfQDMDFBhL8Ps9Q1g5LYiqdsiisco1ZXQJhxw33wmUyXflv/Yq3LZRDdqi9FJeJGk5pu2BjSVYFRkogXcPqwmzI1zYMqF2+8dMtjz37uQjDiiI8w9ppitkQPeKT+QkECZ01z5VqSLv9VdyeafLks9GgERtMJtyYEQDvwJ7P9PbjvnAogS2LBo8s6wwGjy+EYY/3RF+1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw0YgaMKDBwinA8tzYZU5YUarwq2I9oXstZ65UyLufM=;
 b=wopxWE8RC0J00XCGdT+2Yv+sS/YNJBVzpvlN5KTzOZXI6aUcorHNrqTp7EcEBG4UQkvlCrxjWH5FSHvk4YS5wfa03tgZw6F9gx07+Mo68aCs88LHCuZUKJ43mHCmg+tNCcAMZZNTycrIY1eMUWvmHrZVFrJMAVMRuBPE4tnWY0tLCvoBpzvXlV/niohVW5+byoQMx0KU/WvPqPiZqy4i88NZaxO+ufpjHhsTQqnui23duKXbikoLQtBgRDuRNJ4KWoCsrvH0t4v3elBZcMphhBjMKLXTFqUZSKwx9+a30pv1mA2T1aIlZYy53aXdVk8azbAcIGI5uQOQMMl5Xilcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw0YgaMKDBwinA8tzYZU5YUarwq2I9oXstZ65UyLufM=;
 b=FQrM+aORQY9fuIW0hbC7H9pzs7xYXwnK6LOj2RzvmONSazQ9yV9kJpPppocxaXCVHFzknQsPREvEoivcdu9BT/48CR+/W9PhONMXEI2krIlW+Ck3JsmB3t2qFBVhvlVwAzfXCeltZH8++8TZce8fUGYRdd062gyqHPSj7+8qJbqD3kkvjMjB1yWrroyZzfGSX8Mx6SsLBfD/cvVOTz/MffiY04OMxAIPhdRv/n1mMGqx/g69z9xORqmURfZ6SqUonmqNTUYGSv9K5qq0VQNg2Kt4QC8s3mTWUURFDVQZjUOmcGYxKLk+zmehB4uXeRVs7WW2npLt5y3/OqFafSgnfA==
Received: from DS7PR03CA0179.namprd03.prod.outlook.com (2603:10b6:5:3b2::34)
 by IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 18:33:37 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::22) by DS7PR03CA0179.outlook.office365.com
 (2603:10b6:5:3b2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:20 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 08/14] net/mlx5: qos: Store the eswitch in a mlx5_esw_rate_group
Date: Tue, 8 Oct 2024 21:32:16 +0300
Message-ID: <20241008183222.137702-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|IA1PR12MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: fd89e80b-5333-4ea5-9497-08dce7c7b904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0wK4mqzDaf+rCVeUkPmiTx/X87WetQHm/IFDeQKrvRSTd2eosX5ZEnBq7/RB?=
 =?us-ascii?Q?wj9tUNQGKcEOa0VJOLoij3wmKV7gM5zBW98Z/G818+h40CvuyJejYzhrLkUT?=
 =?us-ascii?Q?Sxom0+MTHeiKgBP6mbyQf5RBzh5gZZI/2C2CbgNurGFwVGsrY51yztwZFlz0?=
 =?us-ascii?Q?dmsbbLhkF40Vw6ufBY8oP4cE5IQ7+TLfp4jhkHvjF/T4lvdoS0bZbnOp+uCX?=
 =?us-ascii?Q?w6mrJ2PgNeW/juLb+K1I4HPkaA/T11m0KubtCNrREUT9p5pzZIhEIkdcnGDt?=
 =?us-ascii?Q?VnCYJHRXLRXhfn+ePHx1/WRqWdY8y13t34KbLzfIwC8sgKwAXkkxP5pYr1D4?=
 =?us-ascii?Q?U+BHkLyVrRjOTmC2hzXULFK/HSZukifchzk4km2UiBJ0OCvcKAQppF3wKKJw?=
 =?us-ascii?Q?HrORiSsTztMp+/SEWR7B2QAiP0Y7i1oObEV26AO225I8eFawSszL1GWeCWZO?=
 =?us-ascii?Q?jBef9SNY3LL9aQu2ucetrX6mX7zRvYr1PhDz/yH7vnBN01Zs9kzacLiWM/LI?=
 =?us-ascii?Q?ATKBA0e58aBVFttQiqokoLH9XwLX8g8pFsGZaY6SOgVcRe7pDtkzjkji18sB?=
 =?us-ascii?Q?YBE+Q1qOnnOkHHLZbodbGmkY7MAocjcCJugrUaSSiTMTJnKJjIiq27JA2X6j?=
 =?us-ascii?Q?RZVMJAtCtgXyW/8Y05smjRbTXDWf1nrytffeA3cFczieecrTUrAgym6e+F/z?=
 =?us-ascii?Q?kH8VsWac/xbT2f1I7lEGgnv4VyEKC9zVOeeUtaA7xQ9KlSsMPToOBC7AHyW2?=
 =?us-ascii?Q?of6/PkmwTaLW/94A0+KDJcnVHrlYDJtipA6ErAYX+m6Ztv05waG54KaCPjXs?=
 =?us-ascii?Q?3FK/53NQBMd/FJfylG+/V3CG1h1L9bYmuHeA+OkfqXy1UUgyZBLBVPVJLcOB?=
 =?us-ascii?Q?db9M9oSDx8SVVsoblxiIWOD95lCEtMwf1uakMpaJalwlbMbEsb3plFjiemcr?=
 =?us-ascii?Q?S0kUNjSy6EjzrGRydf/piLedRii14M0fkYRbFtkvV9spOy19Jhxm2xCetyo3?=
 =?us-ascii?Q?y9Eae9kaIEi2YvPMFW5/JyN6LS5PYK8RYz8xTxSc79r+fFZypmMaL32EAsH6?=
 =?us-ascii?Q?0QQUX5O/M9YnZDPD/g+bAvGRE1NXFf8tX7mjDCQwf8Y1qlSZn9eS79AaXk53?=
 =?us-ascii?Q?MJzHA798MuuegXqyAZRh0Bca+n89hK6M3mSg3hARrvDb0Ymj7xLee/nSQc4b?=
 =?us-ascii?Q?wmR8N8DnegrWcx0NTUpDJZ6nEkE5ChynPy+lvgNcs+CUovj7TAKxRz/CRcUe?=
 =?us-ascii?Q?5tz9TDsKxrQ/+FkKmxM/5OcEGqmLl3eKIJNwi2Akn/xHpD6G1F59ARmTnjxw?=
 =?us-ascii?Q?UP5FsdTJQnS/V32Avgig77JISdNRJSZcCMYk2xaRPyJrmt0QY5Tf8tV5RvHz?=
 =?us-ascii?Q?r1a7TLkTKAaHnPFhXYnu8CMKENjQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:36.6954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd89e80b-5333-4ea5-9497-08dce7c7b904
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457

From: Cosmin Ratiu <cratiu@nvidia.com>

The rate groups are about to be moved out of eswitches, so store a
reference to the eswitch they belong to so things can still work
later.

This allows dropping the esw parameter from a couple of functions and
simplifying some of the code. Use this opportunity to make sure that
vport scheduling element commands are always sent to the group eswitch,
because that will be relevant for cross-esw scheduling. For now though,
the eswitches are not different.

There is no functionality change here.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 115 ++++++++----------
 1 file changed, 52 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index baf68ffb07cc..3de3460ec8cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -20,6 +20,8 @@ struct mlx5_esw_rate_group {
 	/* A computed value indicating relative min_rate between group members. */
 	u32 bw_share;
 	struct list_head list;
+	/* The eswitch this group belongs to. */
+	struct mlx5_eswitch *esw;
 	/* Vport members of this group.*/
 	struct list_head members;
 };
@@ -52,10 +54,10 @@ static int esw_qos_sched_elem_config(struct mlx5_core_dev *dev, u32 sched_elem_i
 						  bitmask);
 }
 
-static int esw_qos_group_config(struct mlx5_eswitch *esw, struct mlx5_esw_rate_group *group,
+static int esw_qos_group_config(struct mlx5_esw_rate_group *group,
 				u32 max_rate, u32 bw_share, struct netlink_ext_ack *extack)
 {
-	struct mlx5_core_dev *dev = esw->dev;
+	struct mlx5_core_dev *dev = group->esw->dev;
 	int err;
 
 	err = esw_qos_sched_elem_config(dev, group->tsar_ix, max_rate, bw_share);
@@ -71,15 +73,12 @@ static int esw_qos_vport_config(struct mlx5_vport *vport,
 				u32 max_rate, u32 bw_share,
 				struct netlink_ext_ack *extack)
 {
+	struct mlx5_core_dev *dev = vport->qos.group->esw->dev;
 	int err;
 
-	if (!vport->qos.enabled)
-		return -EIO;
-
-	err = esw_qos_sched_elem_config(vport->dev, vport->qos.esw_sched_elem_ix, max_rate,
-					bw_share);
+	err = esw_qos_sched_elem_config(dev, vport->qos.esw_sched_elem_ix, max_rate, bw_share);
 	if (err) {
-		esw_warn(vport->dev,
+		esw_warn(dev,
 			 "E-Switch modify vport scheduling element failed (vport=%d,err=%d)\n",
 			 vport->vport, err);
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch modify vport scheduling element failed");
@@ -91,10 +90,9 @@ static int esw_qos_vport_config(struct mlx5_vport *vport,
 	return 0;
 }
 
-static u32 esw_qos_calculate_group_min_rate_divider(struct mlx5_eswitch *esw,
-						    struct mlx5_esw_rate_group *group)
+static u32 esw_qos_calculate_group_min_rate_divider(struct mlx5_esw_rate_group *group)
 {
-	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
+	u32 fw_max_bw_share = MLX5_CAP_QOS(group->esw->dev, max_tsar_bw_share);
 	struct mlx5_vport *vport;
 	u32 max_guarantee = 0;
 
@@ -152,12 +150,11 @@ static u32 esw_qos_calc_bw_share(u32 min_rate, u32 divider, u32 fw_max)
 	return min_t(u32, max_t(u32, DIV_ROUND_UP(min_rate, divider), MLX5_MIN_BW_SHARE), fw_max);
 }
 
-static int esw_qos_normalize_group_min_rate(struct mlx5_eswitch *esw,
-					    struct mlx5_esw_rate_group *group,
+static int esw_qos_normalize_group_min_rate(struct mlx5_esw_rate_group *group,
 					    struct netlink_ext_ack *extack)
 {
-	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
-	u32 divider = esw_qos_calculate_group_min_rate_divider(esw, group);
+	u32 fw_max_bw_share = MLX5_CAP_QOS(group->esw->dev, max_tsar_bw_share);
+	u32 divider = esw_qos_calculate_group_min_rate_divider(group);
 	struct mlx5_vport *vport;
 	u32 bw_share;
 	int err;
@@ -194,7 +191,7 @@ static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw, struct netlink_e
 		if (bw_share == group->bw_share)
 			continue;
 
-		err = esw_qos_group_config(esw, group, group->max_rate, bw_share, extack);
+		err = esw_qos_group_config(group, group->max_rate, bw_share, extack);
 		if (err)
 			return err;
 
@@ -203,7 +200,7 @@ static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw, struct netlink_e
 		/* All the group's vports need to be set with default bw_share
 		 * to enable them with QOS
 		 */
-		err = esw_qos_normalize_group_min_rate(esw, group, extack);
+		err = esw_qos_normalize_group_min_rate(group, extack);
 
 		if (err)
 			return err;
@@ -231,7 +228,7 @@ static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 
 	previous_min_rate = vport->qos.min_rate;
 	vport->qos.min_rate = min_rate;
-	err = esw_qos_normalize_group_min_rate(esw, vport->qos.group, extack);
+	err = esw_qos_normalize_group_min_rate(vport->qos.group, extack);
 	if (err)
 		vport->qos.min_rate = previous_min_rate;
 
@@ -266,15 +263,15 @@ static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
 	return err;
 }
 
-static int esw_qos_set_group_min_rate(struct mlx5_eswitch *esw, struct mlx5_esw_rate_group *group,
+static int esw_qos_set_group_min_rate(struct mlx5_esw_rate_group *group,
 				      u32 min_rate, struct netlink_ext_ack *extack)
 {
-	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
-	struct mlx5_core_dev *dev = esw->dev;
+	struct mlx5_eswitch *esw = group->esw;
 	u32 previous_min_rate;
 	int err;
 
-	if (!MLX5_CAP_QOS(dev, esw_bw_share) || fw_max_bw_share < MLX5_MIN_BW_SHARE)
+	if (!MLX5_CAP_QOS(esw->dev, esw_bw_share) ||
+	    MLX5_CAP_QOS(esw->dev, max_tsar_bw_share) < MLX5_MIN_BW_SHARE)
 		return -EOPNOTSUPP;
 
 	if (min_rate == group->min_rate)
@@ -295,8 +292,7 @@ static int esw_qos_set_group_min_rate(struct mlx5_eswitch *esw, struct mlx5_esw_
 	return err;
 }
 
-static int esw_qos_set_group_max_rate(struct mlx5_eswitch *esw,
-				      struct mlx5_esw_rate_group *group,
+static int esw_qos_set_group_max_rate(struct mlx5_esw_rate_group *group,
 				      u32 max_rate, struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport;
@@ -305,7 +301,7 @@ static int esw_qos_set_group_max_rate(struct mlx5_eswitch *esw,
 	if (group->max_rate == max_rate)
 		return 0;
 
-	err = esw_qos_group_config(esw, group, max_rate, group->bw_share, extack);
+	err = esw_qos_group_config(group, max_rate, group->bw_share, extack);
 	if (err)
 		return err;
 
@@ -349,7 +345,7 @@ static int esw_qos_vport_create_sched_element(struct mlx5_vport *vport,
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_esw_rate_group *group = vport->qos.group;
-	struct mlx5_core_dev *dev = vport->dev;
+	struct mlx5_core_dev *dev = group->esw->dev;
 	void *attr;
 	int err;
 
@@ -386,7 +382,7 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_vport *vport,
 	u32 max_rate;
 	int err;
 
-	err = mlx5_destroy_scheduling_element_cmd(vport->dev,
+	err = mlx5_destroy_scheduling_element_cmd(curr_group->esw->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
 						  vport->qos.esw_sched_elem_ix);
 	if (err) {
@@ -409,7 +405,7 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_vport *vport,
 	esw_qos_vport_set_group(vport, curr_group);
 	max_rate = vport->qos.max_rate ? vport->qos.max_rate : curr_group->max_rate;
 	if (esw_qos_vport_create_sched_element(vport, max_rate, vport->qos.bw_share))
-		esw_warn(vport->dev, "E-Switch vport group restore failed (vport=%d)\n",
+		esw_warn(curr_group->esw->dev, "E-Switch vport group restore failed (vport=%d)\n",
 			 vport->vport);
 
 	return err;
@@ -437,8 +433,8 @@ static int esw_qos_vport_update_group(struct mlx5_vport *vport,
 
 	/* Recalculate bw share weights of old and new groups */
 	if (vport->qos.bw_share || new_group->bw_share) {
-		esw_qos_normalize_group_min_rate(esw, curr_group, extack);
-		esw_qos_normalize_group_min_rate(esw, new_group, extack);
+		esw_qos_normalize_group_min_rate(curr_group, extack);
+		esw_qos_normalize_group_min_rate(new_group, extack);
 	}
 
 	return 0;
@@ -453,6 +449,7 @@ __esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix)
 	if (!group)
 		return NULL;
 
+	group->esw = esw;
 	group->tsar_ix = tsar_ix;
 	INIT_LIST_HEAD(&group->members);
 	list_add_tail(&group->list, &esw->qos.groups);
@@ -537,10 +534,10 @@ esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	return group;
 }
 
-static int __esw_qos_destroy_rate_group(struct mlx5_eswitch *esw,
-					struct mlx5_esw_rate_group *group,
+static int __esw_qos_destroy_rate_group(struct mlx5_esw_rate_group *group,
 					struct netlink_ext_ack *extack)
 {
+	struct mlx5_eswitch *esw = group->esw;
 	int err;
 
 	trace_mlx5_esw_group_qos_destroy(esw->dev, group, group->tsar_ix);
@@ -560,18 +557,6 @@ static int __esw_qos_destroy_rate_group(struct mlx5_eswitch *esw,
 	return err;
 }
 
-static int esw_qos_destroy_rate_group(struct mlx5_eswitch *esw,
-				      struct mlx5_esw_rate_group *group,
-				      struct netlink_ext_ack *extack)
-{
-	int err;
-
-	err = __esw_qos_destroy_rate_group(esw, group, extack);
-	esw_qos_put(esw);
-
-	return err;
-}
-
 static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
@@ -633,7 +618,7 @@ static void esw_qos_destroy(struct mlx5_eswitch *esw)
 	int err;
 
 	if (esw->qos.group0->tsar_ix != esw->qos.root_tsar_ix)
-		__esw_qos_destroy_rate_group(esw, esw->qos.group0, NULL);
+		__esw_qos_destroy_rate_group(esw->qos.group0, NULL);
 	else
 		__esw_qos_free_rate_group(esw->qos.group0);
 	esw->qos.group0 = NULL;
@@ -703,6 +688,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+	struct mlx5_core_dev *dev;
 	int err;
 
 	lockdep_assert_held(&esw->state_lock);
@@ -711,11 +697,13 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	WARN(vport->qos.group != esw->qos.group0,
 	     "Disabling QoS on port before detaching it from group");
 
-	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
+	dev = vport->qos.group->esw->dev;
+	err = mlx5_destroy_scheduling_element_cmd(dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
 						  vport->qos.esw_sched_elem_ix);
 	if (err)
-		esw_warn(esw->dev, "E-Switch destroy vport scheduling element failed (vport=%d,err=%d)\n",
+		esw_warn(dev,
+			 "E-Switch destroy vport scheduling element failed (vport=%d,err=%d)\n",
 			 vport->vport, err);
 
 	memset(&vport->qos, 0, sizeof(vport->qos));
@@ -832,10 +820,11 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 		/* Eswitch QoS wasn't enabled yet. Enable it and vport QoS. */
 		err = esw_qos_vport_enable(vport, rate_mbps, vport->qos.bw_share, NULL);
 	} else {
-		MLX5_SET(scheduling_context, ctx, max_average_bw, rate_mbps);
+		struct mlx5_core_dev *dev = vport->qos.group->esw->dev;
 
+		MLX5_SET(scheduling_context, ctx, max_average_bw, rate_mbps);
 		bitmask = MODIFY_SCHEDULING_ELEMENT_IN_MODIFY_BITMASK_MAX_AVERAGE_BW;
-		err = mlx5_modify_scheduling_element_cmd(vport->dev,
+		err = mlx5_modify_scheduling_element_cmd(dev,
 							 SCHEDULING_HIERARCHY_E_SWITCH,
 							 ctx,
 							 vport->qos.esw_sched_elem_ix,
@@ -936,17 +925,16 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
-	struct mlx5_core_dev *dev = devlink_priv(rate_node->devlink);
-	struct mlx5_eswitch *esw = dev->priv.eswitch;
 	struct mlx5_esw_rate_group *group = priv;
+	struct mlx5_eswitch *esw = group->esw;
 	int err;
 
-	err = esw_qos_devlink_rate_to_mbps(dev, "tx_share", &tx_share, extack);
+	err = esw_qos_devlink_rate_to_mbps(esw->dev, "tx_share", &tx_share, extack);
 	if (err)
 		return err;
 
 	mutex_lock(&esw->state_lock);
-	err = esw_qos_set_group_min_rate(esw, group, tx_share, extack);
+	err = esw_qos_set_group_min_rate(group, tx_share, extack);
 	mutex_unlock(&esw->state_lock);
 	return err;
 }
@@ -954,17 +942,16 @@ int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
 					  u64 tx_max, struct netlink_ext_ack *extack)
 {
-	struct mlx5_core_dev *dev = devlink_priv(rate_node->devlink);
-	struct mlx5_eswitch *esw = dev->priv.eswitch;
 	struct mlx5_esw_rate_group *group = priv;
+	struct mlx5_eswitch *esw = group->esw;
 	int err;
 
-	err = esw_qos_devlink_rate_to_mbps(dev, "tx_max", &tx_max, extack);
+	err = esw_qos_devlink_rate_to_mbps(esw->dev, "tx_max", &tx_max, extack);
 	if (err)
 		return err;
 
 	mutex_lock(&esw->state_lock);
-	err = esw_qos_set_group_max_rate(esw, group, tx_max, extack);
+	err = esw_qos_set_group_max_rate(group, tx_max, extack);
 	mutex_unlock(&esw->state_lock);
 	return err;
 }
@@ -1004,15 +991,12 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 				   struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_rate_group *group = priv;
-	struct mlx5_eswitch *esw;
+	struct mlx5_eswitch *esw = group->esw;
 	int err;
 
-	esw = mlx5_devlink_eswitch_get(rate_node->devlink);
-	if (IS_ERR(esw))
-		return PTR_ERR(esw);
-
 	mutex_lock(&esw->state_lock);
-	err = esw_qos_destroy_rate_group(esw, group, extack);
+	err = __esw_qos_destroy_rate_group(group, extack);
+	esw_qos_put(esw);
 	mutex_unlock(&esw->state_lock);
 	return err;
 }
@@ -1024,6 +1008,11 @@ int mlx5_esw_qos_vport_update_group(struct mlx5_vport *vport,
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err = 0;
 
+	if (group && group->esw != esw) {
+		NL_SET_ERR_MSG_MOD(extack, "Cross E-Switch scheduling is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	mutex_lock(&esw->state_lock);
 	if (!vport->qos.enabled && !group)
 		goto unlock;
-- 
2.44.0


