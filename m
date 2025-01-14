Return-Path: <netdev+bounces-158104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904D5A1076F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB10168D57
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2822361C3;
	Tue, 14 Jan 2025 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmNCOsKU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675042361C5
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860254; cv=fail; b=BHnZCjFsh1kNf3b0WV8CIGT9NVh6Mb83wGMRDvamuf96PuhBLFwflpL199dPU16pVJpyoPsm+fzhit1gAu8e8cacKW5fB3qNx6wdThhnqdls29aK3x3o9suOKL4Oo1cLJlRkRn6fLf5sXPdxDicjYyEB/SAHCxYLX77kxtymEZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860254; c=relaxed/simple;
	bh=T7mfNfhzkwWpGy/37BuXWdjBsETUZB1QFHYVeD0MANc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWOoLQ3l9nQod2IaL0jrxcX7zqmdTVYU75lEoOzO5lrD+XTROmb515sg9OxiOaCB0xSs4tTa8/yvErH7B+kfbo0r8ayhi8khYsKKHhAPHXeegXUmMUsy+v9p+DxaaatKW9yxuJ0KRvB13151+sL/K4mQynzzLrI24YgJBsVla0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmNCOsKU; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSaPYHVGs6R7tgV+dtOhI3mMn8Qsei/cFXMUgs2M8HcZPt7CHqT8Jc5LibOxKOvTnw6/sFbQLEkPJGGhuJyy7gNyjrZhHNGlwVo0bEMgdKHaFvf4erxqO5Wz5c0o3d7dOqFbBCUf7sdV29mpoXcYqukZQU41nxcqN9XSq7iN+RQV2KQx2i8HkIv1CsLULKUuL5e5EUS9XCc9ZgnxL6mT067KnpaPpSvwPM+itb1R9gUukMZfMy30opX1Ky5IDb77vP5rHnA1J5GmdioOZ+CsVUQhsmqKgUZpWy1K4kVxE2ACbBtSiOmYCq08Uu7ygLOyOG+GiQTfRGpm3YTpuptG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3lE9BQY1JtSq2Z9hW0aAJblhBkRi5To4hGKEFUAa84=;
 b=JyUpedNyy+ezKH7iYPSqjhxefM9j2MYOdlUcX70RbIzH6sUp4UIAe3K5O0mRUJVtjvjCf1qBdUfXjWYkKkZKb/8zrJT0zm75VrEVAAVZdf3F7d233ICMvl/FPrsfStkVrJqGtxJ33wvrkReZyiS6H1RXgqoOyqts1tMQ4N5md6504jgXJboAdryqJJ1WkqWXb8qVBfL67S6f9VaTZ0XxrjgVJbm/THJKG9AeJiB1JPr6vVAyZgWoUhwKao6ZCT/OHhSoN0BD5egSUM77Cmw2MDgZIa/GKeNiiCRxtxJeI4jA8sR5ovAuX3Dq6L7wtBcH8+mFAMQj2Idu6P2AlqPxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3lE9BQY1JtSq2Z9hW0aAJblhBkRi5To4hGKEFUAa84=;
 b=DmNCOsKUxVkEZkkxq4i2aGIWqZ5+xYrK94/Yx3gHK1W3tXNMXOCL/bs6B5pGntpybmF8KHoggPL0Oythb/u/k38CdlYM3QzTzmuCORdTcsjpX8KUd4DmdmSgl5vLQDIFfqt0xO233IOYxWhMQPiFLH7eEQCS3a6plN4xvx4JwFY87+AeEEGT5gKYk77JOPfPD0GvN1pLbhjAtORx8GCVRlRjorprjv+BOcrudOwYqp/8ctDe+ms84pXk73gbu50z04V5fxfk8JtrDQvxdy7N4HvnQnfM5k5g/tf0YHXGjkOnsBRrJLOF4mGAg+QlcVVGYcHvDQiAtGbQMCIylklJAQ==
Received: from PH7P221CA0059.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::29)
 by DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 13:10:49 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:33c:cafe::8) by PH7P221CA0059.outlook.office365.com
 (2603:10b6:510:33c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 13:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 13:10:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 05:10:28 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 05:10:27 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 14 Jan
 2025 05:10:24 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 1/4] net/mlx5: HWS, rework the check if matcher size can be increased
Date: Tue, 14 Jan 2025 15:06:43 +0200
Message-ID: <20250114130646.1937192-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250114130646.1937192-1-tariqt@nvidia.com>
References: <20250114130646.1937192-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbc9dd5-eb1d-4a05-70da-08dd349cdd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kKETkINQHyieXbn81+Fd4IjCyS4425bYclpAmW8CyE6EX3KE5mtKbHUjiWwI?=
 =?us-ascii?Q?s5U3LM0XTaxu4S2kRBJ2YuPd0fdczwiHFBaagLt1/sxLz2c278fnmIalPD5J?=
 =?us-ascii?Q?7VydcbsexnfgbiodMs+0ezexH77X3bIXNjZZJTYxqq15yI6HVrnIZDi0z5SX?=
 =?us-ascii?Q?kWei1HfsIpSYQo03N9U3IhdLZu7xC++kkHrtypj3AoggD5iZaeneGTS5tKCT?=
 =?us-ascii?Q?MpgNDTqesoLo3F8/Xpsi7vXyn/g78L0VSQNQ1BEUooaX0UUpRXP0u8U7A2y6?=
 =?us-ascii?Q?HyyAjeVc+NsLucK3lIxs8rUqmHe5RMA1skisexr0WhXHleDSAtBEv1Imh2XW?=
 =?us-ascii?Q?UpgFZQy5g2u+8X0DI8BksvXB9R+Mckqm+nL6YrLCwqovS5OntlXGkS+k+ldy?=
 =?us-ascii?Q?CSvN8MYxCN7J47zEwW7csFCRDwcc4pHlBEKiUDtJK13sohAbOelxo8FTq8XR?=
 =?us-ascii?Q?ibY9uU6vUPSxssoBaA4oh5mhrAEYINekfyB8CpiERedPTmhoZ2dY4R+Zg8uZ?=
 =?us-ascii?Q?zlvpTvISPE0ZkaD0B+/SliO9zBF9X9ELdeWljz3AVWEEYw+4O8nhGwQqIqiC?=
 =?us-ascii?Q?HSb94vkWMc3qtfZbxmBLTT/Dff8uoT6a7Uh7K8yppEiSZ03GK9wHdS2KLoMj?=
 =?us-ascii?Q?g8+KsIJmHWON954nmRB7MeHtzvpX4a6dah/xvmCKKhC6TPmfVmXqQ1/KYvfT?=
 =?us-ascii?Q?GFA25AHi4MHTDJ+6FSEVNdw5alkWBuCqFmZEiUAGvwq0cougknnPpE4x4dUM?=
 =?us-ascii?Q?hQj5hzJW0SIuvj92bLlXmlFpN2fB+iIYoLSaKEBgoeTumsrgOoAy4bGHiRsZ?=
 =?us-ascii?Q?TC8GFmu4mwDuQbFUI7o48GsjuINIlZiD5SK28AY9i6PuepyMK5lg6jonEDjX?=
 =?us-ascii?Q?60LYXFWAKVWOjT8hNgK2Q1XygFtADDgKE6pk+PUpzZqcRRRn5UjpLy8AyFLy?=
 =?us-ascii?Q?8hH3Fx3QL6M7FyCNCn4dtHf9mjerO7m/aCAPftFJoDEyGQPVKc195itAzJj8?=
 =?us-ascii?Q?B4S+5/EG55m1gTWE42qpRO3s3OVtTuUNlJ0vQuJyDeelPWEKVWXKLsQbE2j3?=
 =?us-ascii?Q?boKtzSWAzTecJU69WUlJ78v3WuINTJoyWm96c8gRct2TPRlOrw5Fri6QXgFm?=
 =?us-ascii?Q?4/Tj1UpybGbugs1WN21MsW3aQjW1t9FLHm3G7lnBtxwZ7SpnHDBF3OfmhBlI?=
 =?us-ascii?Q?RIymzWRYoon2sqyukJJkf5sBFoJFpy+u+bmZ9uxPCOAxiAoq4SMRDasxGnU4?=
 =?us-ascii?Q?kwnyC/ZhHjJr7uSslOyy3LrdoIC0MEW40siIVVsQZRZNvbAODI7+2Eug/6aa?=
 =?us-ascii?Q?9Wb6mIcJC9E/f9KukpQkzaZ4Fjs7H4Nhwh3OFeNdOGwY+3hQMxlXvtEY5kkd?=
 =?us-ascii?Q?EXnPDSu00m7TdpfglLBN9bIfDizY8L3P0Ix4G1zVhFtiLQJl+qh1YudpCEF0?=
 =?us-ascii?Q?LcCLK2NcCRFYgrHCT5muIJ87ZN3r3iqK7BUdC9UYCgumKxpfVH6J3lgJuxi1?=
 =?us-ascii?Q?2G2URUhKj6i29r4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:10:48.2383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbc9dd5-eb1d-4a05-70da-08dd349cdd02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

When checking if the matcher size can be increased, check both
match and action RTCs. Also, consider the increasing step - check
that it won't cause the new matcher size to become unsupported.

Additionally, since we're using '+ 1' for action RTC size yet
again, define it as macro and use in all the required places.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c      | 18 ++++++++++++++++--
 .../mellanox/mlx5/core/steering/hws/matcher.c  |  6 ++++--
 .../mellanox/mlx5/core/steering/hws/matcher.h  |  5 +++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index a8d886e92144..3dbd4efa21a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -468,8 +468,22 @@ hws_bwc_matcher_size_maxed_out(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
 	struct mlx5hws_cmd_query_caps *caps = bwc_matcher->matcher->tbl->ctx->caps;
 
-	return bwc_matcher->size_log + MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH >=
-	       caps->ste_alloc_log_max - 1;
+	/* check the match RTC size */
+	if ((bwc_matcher->size_log +
+	     MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH +
+	     MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP) >
+	    (caps->ste_alloc_log_max - 1))
+		return true;
+
+	/* check the action RTC size */
+	if ((bwc_matcher->size_log +
+	     MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP +
+	     ilog2(roundup_pow_of_two(bwc_matcher->matcher->action_ste.max_stes)) +
+	     MLX5HWS_MATCHER_ACTION_RTC_UPDATE_MULT) >
+	    (caps->ste_alloc_log_max - 1))
+		return true;
+
+	return false;
 }
 
 static bool
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 80157a29a076..b61864b32053 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -289,7 +289,8 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 		 *     (2 to support writing new STEs for update rule))
 		 */
 		ste->order = ilog2(roundup_pow_of_two(action_ste->max_stes)) +
-			     attr->table.sz_row_log + 1;
+			     attr->table.sz_row_log +
+			     MLX5HWS_MATCHER_ACTION_RTC_UPDATE_MULT;
 		rtc_attr.log_size = ste->order;
 		rtc_attr.log_depth = 0;
 		rtc_attr.update_index_mode = MLX5_IFC_RTC_STE_UPDATE_MODE_BY_OFFSET;
@@ -561,7 +562,8 @@ static int hws_matcher_bind_at(struct mlx5hws_matcher *matcher)
 	pool_attr.flags = MLX5HWS_POOL_FLAGS_FOR_STE_ACTION_POOL;
 	/* Pool size is similar to action RTC size */
 	pool_attr.alloc_log_sz = ilog2(roundup_pow_of_two(action_ste->max_stes)) +
-				 matcher->attr.table.sz_row_log + 1;
+				 matcher->attr.table.sz_row_log +
+				 MLX5HWS_MATCHER_ACTION_RTC_UPDATE_MULT;
 	hws_matcher_set_pool_attr(&pool_attr, matcher);
 	action_ste->pool = mlx5hws_pool_create(ctx, &pool_attr);
 	if (!action_ste->pool) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
index cff4ae854a79..020de70270c5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
@@ -18,6 +18,11 @@
 /* Required depth of the main large table */
 #define MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH 2
 
+/* Action RTC size multiplier that is required in order
+ * to support rule update for rules with action STEs.
+ */
+#define MLX5HWS_MATCHER_ACTION_RTC_UPDATE_MULT 1
+
 enum mlx5hws_matcher_offset {
 	MLX5HWS_MATCHER_OFFSET_TAG_DW1 = 12,
 	MLX5HWS_MATCHER_OFFSET_TAG_DW0 = 13,
-- 
2.45.0


