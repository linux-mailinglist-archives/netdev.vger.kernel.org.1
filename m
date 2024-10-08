Return-Path: <netdev+bounces-133265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545D59956A4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B662B28754F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3BC2141DF;
	Tue,  8 Oct 2024 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UPbGhi2v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7D4213ED5
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412414; cv=fail; b=I/sGrPGbTkXwoNUoibYE4BH9aIk8tcUQ0nShNFgEKXXEo8a7tng87oLB6i5BLT7N7rM0vmzsNAEd8GZu0LC8EaAamHotOQ+92TKVSHp8AB8xbS0IVMSQn3VPtECcAK/kxWL8aR7eCy7krdDhtPYOjexMF1QijaY68PlpXZrCreo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412414; c=relaxed/simple;
	bh=poiFJ+c+6B7D3lfVOcSTo5dLbsicAtEnCEoEpD8STBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ug+PZQybl1bWIC44cXOqwqaudsHbZN5Itu6Xfb0AcSMvrf9TgPPBOlBWBuOojmuW/SwJK6bDBhyvIzBQ8yYbsBQYpUH8Im0ZZNLKOwl4Nw87wp4WuLkc+66bbJR6SHAWbokiGGscOlHwiU4f0dLM/Xv3O18znfdvJ5rtQjoOiss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UPbGhi2v; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFJtG1/BvAmI54d3oAnb4CX91vgZRyAt410OXuqWcMgg4qp0ZPmBpgH9CeRFlclEEPYFQBvg5nEgDaEDQWn/oNbWqSL08QJUpL3p5TQ17C1pw60lkKs39V1PX1V2VsfaSKENCk7n0Q+qBqFQJPppnPzbDAdm8s0rj06aw7uMJV/6/x74bc6QweMnFJFkcVdD4sJBO6Sz8pO5riU8oYVAmxzOW5A3N10WHK4D5D9Amll0B5QDqesuWVMVbFPmmPWzLFCPKK8o94H8q9qK7X60lcZk8SEqRIBswPKGvKz9uym3NKhzGTiOUHMTqU9rncmAeO/3VaieY8Yd104Up8lRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ih3vFMt63gjYj1c6NvSqiYdpsu0aBqHxfEDAnPq9fkg=;
 b=b9pw/WusoqFVfo3eQu45XrZai4NCGWIxr7OEBMzqAfx3JNWJdm+fzaPhR9ckfTKawzvp/ujVYxEUQZrJBleFMROPhO5mpwNc1+WzptooU0BEViJgMDinUrUfclTOmaGgLQqdteR1L2SY4QrTGJGcsGFT8qTs7f7lasOM5ubLbkyUMZrFJsxY1BCI36mdHH0TXwfPKEPuzVpgEzscSBzaFU82RnnFaInRexFQVmQro+uTDvVjuJzpa/VkaQduZL+kNA8DH5/Kzn0whiOczD6Ao6+x14Vri1Lsm3UQZprog2upmW7AlUrf0otcomFwbHfThQC01X9Z1cyzXVRxcjsObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ih3vFMt63gjYj1c6NvSqiYdpsu0aBqHxfEDAnPq9fkg=;
 b=UPbGhi2v+WK6pqvKy/b04hT5YgcaiA9MFUtqfKTGxF9Fgg6vMAXXOUfDIV4EDGU4AIiwNhj1QLvukK2ou1VSdFWfLQwqf8FFHVMmgzI+pn2MG4jaIMI1Na9qIPsFwSDzQsz3za7R6eNwU0ekuBvDqOOp+XxZn7tQpPuK92FaJlGY+wLLHv9LPMADWcnCfeaofFVgL8qbvnylsRoK2TIGIVsOff1BqvJqWCGU7q9Or9/JCGyLB3sSFJJfn/alS9EKIWpQNRJZ0v9430jx8jrbORJtAt9uYq892ng8ptAJuen/mFvAbTkAmwzsjur9HK5V5BOBWNfx5wPfvA3u5i9Zjg==
Received: from CH0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:610:cd::32)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 18:33:26 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::e2) by CH0PR03CA0117.outlook.office365.com
 (2603:10b6:610:cd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 18:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 18:33:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Oct 2024
 11:33:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 8 Oct
 2024 11:33:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 04/14] net/mlx5: qos: Refactor and document bw_share calculation
Date: Tue, 8 Oct 2024 21:32:12 +0300
Message-ID: <20241008183222.137702-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb83690-5b97-4d32-5789-08dce7c7b262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KCbOfQNH3CiEQnQzVfEZZPSu3WdcVcsLNSD2g0rzLgx7HpeGK6ZOSI705KS2?=
 =?us-ascii?Q?NeqZpXvhIq8rQeHYuL0L7aOjsvKlhXKK1farwZtgFYKuARd9JmjuWoLL8iOy?=
 =?us-ascii?Q?5JNBg/uK/ujep4cP/ZKHiISmzEJd/0M6WO4aovxuaDYt61j+KqK7KNFCSumi?=
 =?us-ascii?Q?YC0OTuwZndusygoSlx1//sJul6eaCcOh4knnO5vczVdGDOym8v1VcsSu7C29?=
 =?us-ascii?Q?WznX0lpJ3LvtMYlTXSugCGI8wvDPs21Xx78QCBSLys5PjQ9pUNMDUkoy4cEs?=
 =?us-ascii?Q?eUB4V1U+ERK/BFf3s/A9E+84F2vdt5bVi4ZFhWh6uQxi4jnvn9vxCh9nI1Im?=
 =?us-ascii?Q?JIVNNVWnl2e3NI3t33K2bVbpZ/XoRaYF6vY7akkCfHNERRMB9hYiWuQ40xKu?=
 =?us-ascii?Q?heFb8CHbtKxjtBaqxuM0OYxoixixupaMehfXHFyI/8JFUcd14e3qqjdaKr+3?=
 =?us-ascii?Q?ZxYYzknjduCj0CotsCq9a1wq8Wmoathb3PHY6H7+mCSSc4HKbKMSEfv3ASju?=
 =?us-ascii?Q?fEidJEWof8MAH+YYNPntGOpnTFzGe/iVas+hUEIPZWSP92FTn50BxALSbUZ9?=
 =?us-ascii?Q?bGit9bz9w50uBiRtM5iEIsfXFBO6M6AeDe6DHnbnqj59Y/JmhxZHaaT0wC8G?=
 =?us-ascii?Q?+btC909xJQg145krEYkVJl7k9kFqCkD3Q2JEc4ukB55eGIoy22U+1DZUZ7i1?=
 =?us-ascii?Q?mowLVw4HawZLYeZVOTGhjtQ7a4LzCKatPoeQSu9p4en5iAgY1lzU+JtqFzPo?=
 =?us-ascii?Q?Wg1Mr76l7y8UyTt6DwZLAvJ2+FxeBpFEPR31h5TIWGFsiaPdzXtLmdtOiADu?=
 =?us-ascii?Q?R7heTNeB530zsjYtatRndqq36YXuDKNTR9sPKYofs8iUK899Eun9Lv7u/Tcn?=
 =?us-ascii?Q?ryMvw87ac2RcMSr/JwB/DbR1afg0C+QEUeuBUX+vXg9aScQACocECIw5ZVjJ?=
 =?us-ascii?Q?YB0WE/eEtOYQcRvJ++lhgfKZuhR13bpGh3sHtnogQXe1w3JChurexNpvLG/9?=
 =?us-ascii?Q?wBWztCZsnCHbQTg1T9haPRJqHNosRXpUfpR3W/Pp94j4WuUc42SAOgjKtCSj?=
 =?us-ascii?Q?t56grbJ5hktJ1HpY89LteP13+kWWa3WMJsfIBi5K9YYfZNLgwaRGL8+l0Lvd?=
 =?us-ascii?Q?a2oaxNyRZ0wrgOC/o8IbVsozc07eEal/wAFenpY+7B8tAirWQ+FJtYY9k60v?=
 =?us-ascii?Q?NUWf+SoB8jWq3a6Zom3RHIPi6HQb2KMQiu1WT8hf+lca3h5S1FO0z48jXjmj?=
 =?us-ascii?Q?0Z1GBX8PWVjDm0UvlCNLEvmc85JaIB8Wk2Uk4swr7/gnP/8MRFwdWsMdZ7Ru?=
 =?us-ascii?Q?z8B5TTjW5w5exkjFPl5UtUM+VL/IbonrUTN7UDVVT3OjPSqo46mD2gdi19Ga?=
 =?us-ascii?Q?mYZ3F2OOHCfhoAPChVXvHgMXYfE/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 18:33:25.5659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb83690-5b97-4d32-5789-08dce7c7b262
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756

From: Cosmin Ratiu <cratiu@nvidia.com>

The previous function (esw_qos_calculate_group_min_rate_divider) had two
completely different modes of execution, depending on the 'group_level'
parameter. Split it into two separate functions:
- esw_qos_calculate_min_rate_divider - computes min across groups.
- esw_qos_calculate_group_min_rate_divider - computes min in a group.

Fold the divider calculation into the corresponding normalize functions
to avoid having the caller compute the corresponding divider.
Also rename the normalize functions to better indicate what level
they're operating on.
Finally, document everything so that this topic can more easily be
understood by future maintainers.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 134 +++++++++---------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   3 +-
 2 files changed, 71 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8be4980fcc61..a8231a498ed6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -11,13 +11,13 @@
 /* Minimum supported BW share value by the HW is 1 Mbit/sec */
 #define MLX5_MIN_BW_SHARE 1
 
-#define MLX5_RATE_TO_BW_SHARE(rate, divider, limit) \
-	min_t(u32, max_t(u32, DIV_ROUND_UP(rate, divider), MLX5_MIN_BW_SHARE), limit)
 
 struct mlx5_esw_rate_group {
 	u32 tsar_ix;
+	/* Bandwidth parameters. */
 	u32 max_rate;
 	u32 min_rate;
+	/* A computed value indicating relative min_rate between group members. */
 	u32 bw_share;
 	struct list_head list;
 };
@@ -83,57 +83,77 @@ static int esw_qos_vport_config(struct mlx5_eswitch *esw,
 	return 0;
 }
 
-static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
-					      struct mlx5_esw_rate_group *group,
-					      bool group_level)
+static u32 esw_qos_calculate_group_min_rate_divider(struct mlx5_eswitch *esw,
+						    struct mlx5_esw_rate_group *group)
 {
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
 	struct mlx5_vport *vport;
 	u32 max_guarantee = 0;
 	unsigned long i;
 
-	if (group_level) {
-		struct mlx5_esw_rate_group *group;
 
-		list_for_each_entry(group, &esw->qos.groups, list) {
-			if (group->min_rate < max_guarantee)
-				continue;
-			max_guarantee = group->min_rate;
-		}
-	} else {
-		mlx5_esw_for_each_vport(esw, i, vport) {
-			if (!vport->enabled || !vport->qos.enabled ||
-			    vport->qos.group != group || vport->qos.min_rate < max_guarantee)
-				continue;
-			max_guarantee = vport->qos.min_rate;
-		}
+	/* Find max min_rate across all vports in this group.
+	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
+	 */
+	mlx5_esw_for_each_vport(esw, i, vport) {
+		if (!vport->enabled || !vport->qos.enabled ||
+		    vport->qos.group != group || vport->qos.min_rate < max_guarantee)
+			continue;
+		max_guarantee = vport->qos.min_rate;
 	}
 
 	if (max_guarantee)
 		return max_t(u32, max_guarantee / fw_max_bw_share, 1);
 
-	/* If vports min rate divider is 0 but their group has bw_share configured, then
-	 * need to set bw_share for vports to minimal value.
+	/* If vports max min_rate divider is 0 but their group has bw_share
+	 * configured, then set bw_share for vports to minimal value.
 	 */
-	if (!group_level && !max_guarantee && group && group->bw_share)
+	if (group && group->bw_share)
 		return 1;
+
+	/* A divider of 0 sets bw_share for all group vports to 0,
+	 * effectively disabling min guarantees.
+	 */
 	return 0;
 }
 
-static u32 esw_qos_calc_bw_share(u32 min_rate, u32 divider, u32 fw_max)
+static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw)
 {
-	if (divider)
-		return MLX5_RATE_TO_BW_SHARE(min_rate, divider, fw_max);
+	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
+	struct mlx5_esw_rate_group *group;
+	u32 max_guarantee = 0;
+
+	/* Find max min_rate across all esw groups.
+	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
+	 */
+	list_for_each_entry(group, &esw->qos.groups, list) {
+		if (group->min_rate < max_guarantee)
+			continue;
+		max_guarantee = group->min_rate;
+	}
 
+	if (max_guarantee)
+		return max_t(u32, max_guarantee / fw_max_bw_share, 1);
+
+	/* If no group has min_rate configured, a divider of 0 sets all
+	 * groups' bw_share to 0, effectively disabling min guarantees.
+	 */
 	return 0;
 }
 
-static int esw_qos_normalize_vports_min_rate(struct mlx5_eswitch *esw,
-					     struct mlx5_esw_rate_group *group,
-					     struct netlink_ext_ack *extack)
+static u32 esw_qos_calc_bw_share(u32 min_rate, u32 divider, u32 fw_max)
+{
+	if (!divider)
+		return 0;
+	return min_t(u32, max_t(u32, DIV_ROUND_UP(min_rate, divider), MLX5_MIN_BW_SHARE), fw_max);
+}
+
+static int esw_qos_normalize_group_min_rate(struct mlx5_eswitch *esw,
+					    struct mlx5_esw_rate_group *group,
+					    struct netlink_ext_ack *extack)
 {
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
-	u32 divider = esw_qos_calculate_min_rate_divider(esw, group, false);
+	u32 divider = esw_qos_calculate_group_min_rate_divider(esw, group);
 	struct mlx5_vport *vport;
 	unsigned long i;
 	u32 bw_share;
@@ -157,10 +177,10 @@ static int esw_qos_normalize_vports_min_rate(struct mlx5_eswitch *esw,
 	return 0;
 }
 
-static int esw_qos_normalize_groups_min_rate(struct mlx5_eswitch *esw, u32 divider,
-					     struct netlink_ext_ack *extack)
+static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
+	u32 divider = esw_qos_calculate_min_rate_divider(esw);
 	struct mlx5_esw_rate_group *group;
 	u32 bw_share;
 	int err;
@@ -180,7 +200,7 @@ static int esw_qos_normalize_groups_min_rate(struct mlx5_eswitch *esw, u32 divid
 		/* All the group's vports need to be set with default bw_share
 		 * to enable them with QOS
 		 */
-		err = esw_qos_normalize_vports_min_rate(esw, group, extack);
+		err = esw_qos_normalize_group_min_rate(esw, group, extack);
 
 		if (err)
 			return err;
@@ -207,7 +227,7 @@ static int esw_qos_set_vport_min_rate(struct mlx5_eswitch *esw, struct mlx5_vpor
 
 	previous_min_rate = vport->qos.min_rate;
 	vport->qos.min_rate = min_rate;
-	err = esw_qos_normalize_vports_min_rate(esw, vport->qos.group, extack);
+	err = esw_qos_normalize_group_min_rate(esw, vport->qos.group, extack);
 	if (err)
 		vport->qos.min_rate = previous_min_rate;
 
@@ -229,9 +249,7 @@ static int esw_qos_set_vport_max_rate(struct mlx5_eswitch *esw, struct mlx5_vpor
 	if (max_rate == vport->qos.max_rate)
 		return 0;
 
-	/* If parent group has rate limit need to set to group
-	 * value when new max rate is 0.
-	 */
+	/* Use parent group limit if new max rate is 0. */
 	if (vport->qos.group && !max_rate)
 		act_max_rate = vport->qos.group->max_rate;
 
@@ -248,10 +266,10 @@ static int esw_qos_set_group_min_rate(struct mlx5_eswitch *esw, struct mlx5_esw_
 {
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
 	struct mlx5_core_dev *dev = esw->dev;
-	u32 previous_min_rate, divider;
+	u32 previous_min_rate;
 	int err;
 
-	if (!(MLX5_CAP_QOS(dev, esw_bw_share) && fw_max_bw_share >= MLX5_MIN_BW_SHARE))
+	if (!MLX5_CAP_QOS(dev, esw_bw_share) || fw_max_bw_share < MLX5_MIN_BW_SHARE)
 		return -EOPNOTSUPP;
 
 	if (min_rate == group->min_rate)
@@ -259,15 +277,13 @@ static int esw_qos_set_group_min_rate(struct mlx5_eswitch *esw, struct mlx5_esw_
 
 	previous_min_rate = group->min_rate;
 	group->min_rate = min_rate;
-	divider = esw_qos_calculate_min_rate_divider(esw, group, true);
-	err = esw_qos_normalize_groups_min_rate(esw, divider, extack);
+	err = esw_qos_normalize_min_rate(esw, extack);
 	if (err) {
-		group->min_rate = previous_min_rate;
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch group min rate setting failed");
 
 		/* Attempt restoring previous configuration */
-		divider = esw_qos_calculate_min_rate_divider(esw, group, true);
-		if (esw_qos_normalize_groups_min_rate(esw, divider, extack))
+		group->min_rate = previous_min_rate;
+		if (esw_qos_normalize_min_rate(esw, extack))
 			NL_SET_ERR_MSG_MOD(extack, "E-Switch BW share restore failed");
 	}
 
@@ -291,9 +307,7 @@ static int esw_qos_set_group_max_rate(struct mlx5_eswitch *esw,
 
 	group->max_rate = max_rate;
 
-	/* Any unlimited vports in the group should be set
-	 * with the value of the group.
-	 */
+	/* Any unlimited vports in the group should be set with the value of the group. */
 	mlx5_esw_for_each_vport(esw, i, vport) {
 		if (!vport->enabled || !vport->qos.enabled ||
 		    vport->qos.group != group || vport->qos.max_rate)
@@ -382,12 +396,8 @@ static int esw_qos_update_group_scheduling_element(struct mlx5_eswitch *esw,
 	}
 
 	vport->qos.group = new_group;
+	/* Use new group max rate if vport max rate is unlimited. */
 	max_rate = vport->qos.max_rate ? vport->qos.max_rate : new_group->max_rate;
-
-	/* If vport is unlimited, we set the group's value.
-	 * Therefore, if the group is limited it will apply to
-	 * the vport as well and if not, vport will remain unlimited.
-	 */
 	err = esw_qos_vport_create_sched_element(esw, vport, max_rate, vport->qos.bw_share);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch vport group set failed.");
@@ -428,8 +438,8 @@ static int esw_qos_vport_update_group(struct mlx5_eswitch *esw,
 
 	/* Recalculate bw share weights of old and new groups */
 	if (vport->qos.bw_share || new_group->bw_share) {
-		esw_qos_normalize_vports_min_rate(esw, curr_group, extack);
-		esw_qos_normalize_vports_min_rate(esw, new_group, extack);
+		esw_qos_normalize_group_min_rate(esw, curr_group, extack);
+		esw_qos_normalize_group_min_rate(esw, new_group, extack);
 	}
 
 	return 0;
@@ -440,7 +450,6 @@ __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *ex
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_esw_rate_group *group;
-	u32 divider;
 	void *attr;
 	int err;
 
@@ -465,13 +474,10 @@ __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *ex
 
 	list_add_tail(&group->list, &esw->qos.groups);
 
-	divider = esw_qos_calculate_min_rate_divider(esw, group, true);
-	if (divider) {
-		err = esw_qos_normalize_groups_min_rate(esw, divider, extack);
-		if (err) {
-			NL_SET_ERR_MSG_MOD(extack, "E-Switch groups normalization failed");
-			goto err_min_rate;
-		}
+	err = esw_qos_normalize_min_rate(esw, extack);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch groups normalization failed");
+		goto err_min_rate;
 	}
 	trace_mlx5_esw_group_qos_create(esw->dev, group, group->tsar_ix);
 
@@ -515,15 +521,13 @@ static int __esw_qos_destroy_rate_group(struct mlx5_eswitch *esw,
 					struct mlx5_esw_rate_group *group,
 					struct netlink_ext_ack *extack)
 {
-	u32 divider;
 	int err;
 
 	list_del(&group->list);
 
-	divider = esw_qos_calculate_min_rate_divider(esw, NULL, true);
-	err = esw_qos_normalize_groups_min_rate(esw, divider, extack);
+	err = esw_qos_normalize_min_rate(esw, extack);
 	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch groups' normalization failed");
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch groups normalization failed");
 
 	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 9bf05ae58af0..ce857eae6898 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -215,9 +215,10 @@ struct mlx5_vport {
 	struct {
 		bool enabled;
 		u32 esw_sched_elem_ix;
-		u32 bw_share;
 		u32 min_rate;
 		u32 max_rate;
+		/* A computed value indicating relative min_rate between vports in a group. */
+		u32 bw_share;
 		struct mlx5_esw_rate_group *group;
 	} qos;
 
-- 
2.44.0


