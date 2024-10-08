Return-Path: <netdev+bounces-133270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EC19956A9
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA431F21CB7
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC1F213EDF;
	Tue,  8 Oct 2024 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UIvk22Xk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466A2139A7
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412432; cv=fail; b=fFsX/eGy0XIjdtreEgxNMp0FT7Bv1rPDGicFUqmSA0MFnpolEBPk5kmY2PJSuXHY77nk6dkt6Is81/bWSyFfm9VDmfBwMfQFOu2T5xf6U4umvB3hifkPMwZ6lJ8p8DnKy045iLtLYoKToIs/4QhE1hQqnaCCD7/1EeUiQ4ixXAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412432; c=relaxed/simple;
	bh=LSf8yUk9y0qqcCFww7/H1cE8F/gwBhmCQiTO23IC6i4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G98I+kodpCt1b42uxizh5EjahEj6QmywGKf4L5AxK4dMczAGvi1Zf7FwtQdgH1yYggm93RTYXIPOysGNN9N91Bnt3ucc932NHbX1aIFaEELrPnOGlo0XryQLEU4qqIchi94bqWTk36O1RldAt1OYPf/s1KmLuTK8eJX7zD7O52U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UIvk22Xk; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWXq/DrMcGeDV5TRaR2dJTvhufftRPUaiCRVXMqwVbtLK/IpEGFnc/Uj8fLnMMD++Nf7gFyhX3niylwBRYW7XptVm2pxZc38k1X8BTRBmQO5mb+pGO4l0XbKgRn38Vn4cZtVlFs85QpG9G5VKTVh3Imic1p36aB7+fmlZdGdXy/zk8KyD98SxY703/pmFIhXWrRmfHZBdKaByYjaFIBFBQyq496SFcSF3H8/ZkAu3hq7sMat9Of0rRqWK3Q86m6ItwhjPK2JlZkgi55N611EAoRDiTR5tSstjLVp1/OHNZG2mWktHJ+F073LKqqL83C+W6g5rHZRiMznnuK2+E5dOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1QKJErxvKQhdz/KTxBucioEURk1g5YCJqEeM2MhqBE=;
 b=OOdP2E5aVR3ziXcmU7HOui6RwJ8hLJsy6cRtvQJCRwZv7c+mjUcrIULiKHMGwSIuXSld3plf8cz/AYfR2b6erB0NUbpLd27R0f6MgyZhLV6POUSJWsQ3PlTv+gyuBPy5haGLEfW5fXH87Gejbm3WYNtW+Yn3WR1tf3U5Vw28dWn3mt3y9T1+Hmnhn9tZ7hcbttc1BF2Qhy1xwsKZ3orOmBZBQdgWQ2Abso1VNqS77PEAfzIe0lHzdUm5+gsfCdl9+kcw5JYWunmXzsmkdd9y5yiUoSjLzJtQ7Tl+km+QwXfiDrq5Tyut7oyXcobamLCXR1kjuLHlzjulCRxD0PQFcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1QKJErxvKQhdz/KTxBucioEURk1g5YCJqEeM2MhqBE=;
 b=UIvk22XkYBqVPVTU+hKXdjxN1aTicKdDE/X9hNkUiV+4PYnLTqf8CnYwUgGpg24/a65eiQESCftx5QHdHIxvCtjEQKEtCK2xjfLTP5zlfm3V4zETzb8g1vekjecuU416cFmdfSSxi6IQ4xn54pD/OsJv+fpPfIlh37LLQZQxlOp5+YxMgLtFs//TWTLLbbfGU+csKJ8LZWhNgdkzlodHeL5CvoN6a0HIq1j7XJO8f5rEkys+5iJ3vSwfyWvexSI6yr3vL2RvcqNl2pcVMxT05J34cCDnMSxIBiPo8OEzAGqDcqHKrN2egwmB3n7wc29ZjSya/j1BSQjkYdqQDYNqgw==
Received: from CY8PR10CA0002.namprd10.prod.outlook.com (2603:10b6:930:4f::7)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 18:33:45 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::f3) by CY8PR10CA0002.outlook.office365.com
 (2603:10b6:930:4f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:30 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:26 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 10/14] net/mlx5: qos: Rename rate group 'list' as 'parent_entry'
Date: Tue, 8 Oct 2024 21:32:18 +0300
Message-ID: <20241008183222.137702-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5e1e04-c056-4419-af84-08dce7c7bde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fVbk9wFYeIXVgIF1ApP1vKOHmY6LVMJzwG6M5sSXzQWQhYbgTMJ05gqVUis6?=
 =?us-ascii?Q?QU3AwagcavfZ8aPpjCZVJS4dPzSXGKRoy1UW/cCPuRQK/0IPdJhIiq+akrdi?=
 =?us-ascii?Q?F5msKK54wYX1S03Ew6OWtv6LGFMBiqwaP76skUrE2/96hKUylJ8LOcvKk+wN?=
 =?us-ascii?Q?o9y1TR1R1NTrgHFbRGzwB//AWqDTISM2WhFceuQlL8LSiY0w0CxXuu6x3WeM?=
 =?us-ascii?Q?dN05DTepZlKIOnreI9duvnVXvIN2vH3HyU0RCNpePcRTt7gMgylkk0g5uX7t?=
 =?us-ascii?Q?8PBtAGBnLySP0JO3lmAPKOnfwk7IKTJ59+RzcDrhkHFC+OJzvlOL3PzX3LRd?=
 =?us-ascii?Q?rHsk+2IMXsyCHq/nK0nlv0841THcj4IKl9IZrWh2JtGM9buNGGsN01pLD8/K?=
 =?us-ascii?Q?WBHxk3Pr4mc9wiYHvoXQOC+hoUgFntnbM/4VVIkG2IMpcFZykqzm7DB1kE0T?=
 =?us-ascii?Q?QuKeJUdQH8H4liEFfcyPoH/ZU/ZluJkh4BsuBOLoyaeMpU9M3fHxzApIkIB4?=
 =?us-ascii?Q?YYDD5dyrghDFdWAykz7cfPZgszZFg29YH7sobOmsjlMhpAYzRSalPry/EzUa?=
 =?us-ascii?Q?aexrbYtRRUmTjJBoEh5uFW6/Dt3TAxwc0Z9FiXLJQI7qgk8FmGNcxbwtolsI?=
 =?us-ascii?Q?l7BYZ/z8I+jH4TW48XMUACm99zT77fry3enE0cTAbDqIIhHCc8p3w+GoQNle?=
 =?us-ascii?Q?QAU6I0BTOxh4TjqQVg2WfB3IbnZvmpnnunrWD+kkaoIW6pASK2+y1fTCF470?=
 =?us-ascii?Q?QF606gez7RELoTm8TSmB3vzBXdKnRqK8ZP8vNtKXMKH+YQXzoSlkQNhdIHaL?=
 =?us-ascii?Q?358Po3R5TeReDN/U7Mu/oSNKqGy/eg9GF+aza2tZj+yyXSCvCGKFbJHswswE?=
 =?us-ascii?Q?TIKIqewcDNukZiHo3AR2VLB1h7BFBqXST//hR5OvLvIhCKcaJ6lLMjL7R7pn?=
 =?us-ascii?Q?zlboxmNucTHCakC/D9Xsgelc0eA5TfPFW7XptJXrwLkPNhCDm3UURsylqzR+?=
 =?us-ascii?Q?rIEP5kONc0vIRcD7CyrFsTQvkjq3kmIYn1Omhmj16A898lXtrE1aG5cCx9Az?=
 =?us-ascii?Q?8idqNoiC2TgbJb53DOwnvALwJUGUNVugwqUI8lXhVXnFBU0BfJb5BKCMyMrw?=
 =?us-ascii?Q?SpYRVGld9tm0/S/xvBn4EhP9kPqxjZ2JnWHQodTULp0bN9td3kQ33fbASNTe?=
 =?us-ascii?Q?Vptb6QYgNw+8CBZup96KhnuQSHqv2GX4Zo7p2j3T0RGXMYn4t3GsNNPI5QAv?=
 =?us-ascii?Q?DMk+IIr4pdkTTZsqtsriHtQ8fUN1lXr72rjWWV5GlqBn6NaSRl6A1EdYUwa9?=
 =?us-ascii?Q?b3ToigAl9XLa5dq8rlTbpEyT0RVx8iz8zNhq2a18XTl3PtnRjGJUaTAwm6Gu?=
 =?us-ascii?Q?aFEHDPKjLLGZTVuPzWzI0ksGMbWP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:44.8815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5e1e04-c056-4419-af84-08dce7c7bde5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358

From: Cosmin Ratiu <cratiu@nvidia.com>

'list' is not very descriptive, I prefer list membership to clearly
specify which list the entry belongs to. This commit renames the list
entry into the esw groups list as 'parent_entry' to make the code more
readable. This is a no-op change.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8b24076cbdb5..5891a68633af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -19,7 +19,7 @@ struct mlx5_esw_rate_group {
 	u32 min_rate;
 	/* A computed value indicating relative min_rate between group members. */
 	u32 bw_share;
-	struct list_head list;
+	struct list_head parent_entry;
 	/* The eswitch this group belongs to. */
 	struct mlx5_eswitch *esw;
 	/* Vport members of this group.*/
@@ -128,7 +128,7 @@ static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw)
 	/* Find max min_rate across all esw groups.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
-	list_for_each_entry(group, &esw->qos.groups, list) {
+	list_for_each_entry(group, &esw->qos.groups, parent_entry) {
 		if (group->min_rate < max_guarantee || group->tsar_ix == esw->qos.root_tsar_ix)
 			continue;
 		max_guarantee = group->min_rate;
@@ -183,7 +183,7 @@ static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw, struct netlink_e
 	u32 bw_share;
 	int err;
 
-	list_for_each_entry(group, &esw->qos.groups, list) {
+	list_for_each_entry(group, &esw->qos.groups, parent_entry) {
 		if (group->tsar_ix == esw->qos.root_tsar_ix)
 			continue;
 		bw_share = esw_qos_calc_bw_share(group->min_rate, divider, fw_max_bw_share);
@@ -452,13 +452,13 @@ __esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix)
 	group->esw = esw;
 	group->tsar_ix = tsar_ix;
 	INIT_LIST_HEAD(&group->members);
-	list_add_tail(&group->list, &esw->qos.groups);
+	list_add_tail(&group->parent_entry, &esw->qos.groups);
 	return group;
 }
 
 static void __esw_qos_free_rate_group(struct mlx5_esw_rate_group *group)
 {
-	list_del(&group->list);
+	list_del(&group->parent_entry);
 	kfree(group);
 }
 
-- 
2.44.0


