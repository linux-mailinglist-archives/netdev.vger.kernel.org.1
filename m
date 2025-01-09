Return-Path: <netdev+bounces-156774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAB0A07CF1
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764373A91BA
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8E222257A;
	Thu,  9 Jan 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K8Ef8EpV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360DF222563
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438889; cv=fail; b=Iu1XWIffImBiD3T43sJ4RNq0YD8PQzFN37ASsWWWoz5UyK1IMqdp0F+doDdiBd+T1HBE0MtXtPD38XFfd2R0PKghElij7i401VMNaurgwFV+QpdXLAG/ywKLJOmgkAsv4U+251ziKOPKoGxYlg0WzYLylfeaUz04TEyY1fhfY7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438889; c=relaxed/simple;
	bh=vJ9YMUBmeJXkyQ3rt/CMsZRkqdX4QezPohho/OmKXhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDe+NY2XWyTIoiqB5fhYVXtgaO/C66c4RM4mtVNAZ8eUzoCB54O8ydUZ6ORVECBuu4NRPdM0UuyABWsUltv0oz6kQBYw3lfS1ZmcgIHR8DUCC/vkYhVvsGf0d9i7QpyTz4R+dxjfLp9m5LZz4qsJskXYVNd6QLxU4oU4zwinLTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K8Ef8EpV; arc=fail smtp.client-ip=40.107.95.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gknp3gqY5uG9qT3oRA1dzjeZ2cqtnEjdPmiv2W/fKwjByLp6CRSvLkupaYUSVdZm++vHe8TXiYthjbC90HAXagBm+fbRY0xjjWnFuxmY9pIN0UWqFVuVFl708Nye+p/S7dAK/9t/tFm2JuczUL09/22vqXus73Ls1gglNVm/Kf7YHIm+9X0UAS28/uAac9VSvzM+NBQdjOojFg/mJ3zsKy5M+2unJFNgJELg+ECqIX16hxlouHp0ZSlcSCKXKtc89XjSmglp2Qzd81+ejfY6giYFGpAP1yaXORNVlugTIHDGRMWmtujPWz5qAnz7qbTBbzPut+PQ+cOfAR5vMsbLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxlhVVwzUzU6H3AU1wo9Nu+ctHyeEcobJRCG4DR18Xw=;
 b=VhW9K0KS6EkRacNgsz3bHf8C6e3GnrWkqzPcgFYhLIlzm0eeX0vQjjFHItPQggaFGNpM3sAyYcc5Vp4FSPBmMRJPJu8BhC7wU7iV2M+FyV6vDDOtl/AJIUR5Z81NCHVz9Fbm7X1TAR30FSJQvlTDb4ub7E0ANseAjD2M2qm0NMfasLm2jcyS5Qy85J793e5ow013QSgkA0z9EV9E41vXeemKHq2+M3Fo/0MYSfmg+3ggRfFIUM/lul1zmLXtmWJ0QKHW2MFvs7RzuiY3rvyii4xypo7OmkC4DPREN9kGC1A96d5YO+2p/Dy9+eXEDfG0aOj14ypFbFIPp7qd74zz+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxlhVVwzUzU6H3AU1wo9Nu+ctHyeEcobJRCG4DR18Xw=;
 b=K8Ef8EpVccEifIsGZPZMjs8QGc1Y+qGud0a9pjTI8ZUEt0XEtqyu9KO6/Luhl1HJx7szn+zfgklmO/76JwNZGKNMTBPnimBwJs1gKIjP4kpjlsELUXrKoFehJ25A8mEFqYxknFp2/lkWVp7w4wK3pWernQduzafYtDMSWYFGnvLrk8U4ySAMFeVb0Gk37S+c136MPD29vAKfk070Ty699QwDxZPJB4b5CS2cZiMdkRu/r0BFLoskZlf6Vt34yWXeSIRIZ6NG5MWuHMs4y58zU72J9mX/YowW30j9/RNnFfq8uJKtoc1zOO8MPJ04SPjTkswmAqY3Z0q7YYBG3UpLog==
Received: from DM6PR12CA0009.namprd12.prod.outlook.com (2603:10b6:5:1c0::22)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Thu, 9 Jan
 2025 16:07:56 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::84) by DM6PR12CA0009.outlook.office365.com
 (2603:10b6:5:1c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Thu,
 9 Jan 2025 16:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 16:07:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:44 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:43 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:07:40 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 14/15] net/mlx5: HWS, update flow - remove the use of dual RTCs
Date: Thu, 9 Jan 2025 18:05:45 +0200
Message-ID: <20250109160546.1733647-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250109160546.1733647-1-tariqt@nvidia.com>
References: <20250109160546.1733647-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a170f38-1f8b-4819-9c77-08dd30c7c77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HA0ZTwsvrqWfiB80Elwby5S4GVEei0szrotp3HeiRqWli1oOBwv34vziQlZ7?=
 =?us-ascii?Q?pAkNkNaWywkjSxcc1Bz2d8e9FB/xbVp+kr11frh+Em9q9oDD3xr3aDPQaeXf?=
 =?us-ascii?Q?3ltbzBecabeG1oYFuXVG8WY5/lDHgBDCrt5cMt3vX2yxE+WMQmecU5mqJ1rI?=
 =?us-ascii?Q?GrZSR7pGZ0HbnD6HX1XBYKmZkh/yutxxP1U8TuG2HVLTm0uYQ6YFwWZAwqAU?=
 =?us-ascii?Q?N3iMp6/8sX5BWlc4YogdjtFoN2JjqMe2eMllZVnq29v729rbiYuA7IyzEK7K?=
 =?us-ascii?Q?uG+eN5VcYZWIoWS3NDvmMo5nh8r2PaMcTlEH4YlpE+4NFmevBQgwyueOUiDm?=
 =?us-ascii?Q?Y9/RwKdCpNNe3q4L5BMK4hYFfy96tBwkaVENXvTFeFL8wHhVcHsVrni6FBuC?=
 =?us-ascii?Q?TwKQnBkkpufHTUdPlDX6d12dNZpaPEXGUqBszK+rxPmjJi84wX1J/yBUS+eM?=
 =?us-ascii?Q?tbD3vM1dmXcLMiiRoR15FSTADxsbsqrDcV3pTQeyTr1jYjq3E0Aw6JxrHoxu?=
 =?us-ascii?Q?+7DBPqH/q2L5ocHrBAA2mdO9RVHwr9XeIO0cucw/HKRCs28i74mPgnMzTQBF?=
 =?us-ascii?Q?Ufu8VHalDhDrpz306qB6H59Ueh5s1fFi4LWO7MXxHOVi7ugG3zb5mXaWlhnW?=
 =?us-ascii?Q?QPl3biODsmEsy8hNdOGHtmoVgd30vPWFMJTNgAeOUdn/ZHhdKTvlBLFAPIV+?=
 =?us-ascii?Q?HovXSIH0G8y/cq1mXMXYaxdl01qfoIWu19UOqb7K6jhCvcnuR/pCxlebuyS2?=
 =?us-ascii?Q?uvNxyDBOzCj6+jBcuwK4UkCuwqc0gH9HZc1gPX50+qAASKbPgp2EtEs6iokD?=
 =?us-ascii?Q?q12MtQA/xs9KVJwVWXGgCBs6MVzyIKdmHuup+Xdj9IHxxfwDWe7pF+Gi1F2/?=
 =?us-ascii?Q?YoUmD2GeW9pyk+/Q6y/HYulI4vj8h5SKgul3C3U0jo50VKwqumpoq7ZJ0hGD?=
 =?us-ascii?Q?N9YP0Ws307J/KwVyR7itFCFlWQi4l5SRzKp09VKW310mr2bp01lK0adySu0M?=
 =?us-ascii?Q?bH7yCwcj9hwFy+5TUP5YF9FdGTTLTFpHhcI4DCA1EAnJs+qXZSx0eaB+AdRw?=
 =?us-ascii?Q?/k27Vek0PndH2ulXKeZs3lk2t4oOXdBNxbmE7S2XpnNf7mH6RCIJV6HNYnpv?=
 =?us-ascii?Q?LwZ5jk6/TPOkcH072cnDDPAWGsMlbxpILFZzLznsrvtRsWwxvDtoyOvXyTqS?=
 =?us-ascii?Q?mslPfS3UlmnEmY1IzoHHi5qlMBE95ytLRZfTNmJXY6upFyV0wChngPPXw7Uh?=
 =?us-ascii?Q?OaU9J366NVrDZ+WaMmBlAhNs6x5gpMWlBLHpJ3QDqGioyFpoz+yS1lu9rrcF?=
 =?us-ascii?Q?i/diOFMVak7EJV6/Rq3NFs1Selbr4UDlf6aIpePUkFKvhBk5sk5UcrgS1lqg?=
 =?us-ascii?Q?1Vs18wcLlewnUvt13VVlsRMS0BZzBoltOOQfDri+E62bSSi3OtlrMmR8UrsK?=
 =?us-ascii?Q?afmBAqurH+tJMnMztOIvcLFd98ZMUwHfPYlDDVSNLYL2ylPPBsAzEbsj5iKt?=
 =?us-ascii?Q?xlA2tpvs4xStyLg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:55.7930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a170f38-1f8b-4819-9c77-08dd30c7c77a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

This patch is the first part of update flow implementation.

Update flow should support rules with single STE (match STE only),
as well as rules with multiple STEs (match STE plus action STEs).

Supporting the rules with single STE is straightforward: we just
overwrite the STE, which is an atomic operation.
Supporting the rules with action STEs is a more complicated case.
The existing implementation uses two action RTCs per matcher and
alternates between the two for each update request.
This implementation was unnecessarily complex and lead to some
unhandled edge cases, so the support for rule update with multiple
STEs wasn't really functional.

This patch removes this code, and the next patch adds implementation
of a different approach.

Note that after applying this patch and before applying the next
patch we still have support for update rule with single STE (only
match STE w/o action STEs), but update will fail for rules with
action STEs.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/debug.c   |  10 +-
 .../mlx5/core/steering/hws/internal.h         |   1 -
 .../mellanox/mlx5/core/steering/hws/matcher.c | 170 +++++++-----------
 .../mellanox/mlx5/core/steering/hws/matcher.h |   8 +-
 .../mellanox/mlx5/core/steering/hws/rule.c    |  73 ++------
 .../mellanox/mlx5/core/steering/hws/rule.h    |   3 +-
 6 files changed, 81 insertions(+), 184 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
index 60ada3143d60..696275fd0ce2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
@@ -148,8 +148,8 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 		   matcher->match_ste.rtc_1_id,
 		   (int)ste_1_id);
 
-	ste = &matcher->action_ste[0].ste;
-	ste_pool = matcher->action_ste[0].pool;
+	ste = &matcher->action_ste.ste;
+	ste_pool = matcher->action_ste.pool;
 	if (ste_pool) {
 		ste_0_id = mlx5hws_pool_chunk_get_base_id(ste_pool, ste);
 		if (tbl_type == MLX5HWS_TABLE_TYPE_FDB)
@@ -171,10 +171,8 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 		return ret;
 
 	seq_printf(f, ",%d,%d,%d,%d,%d,0x%llx,0x%llx\n",
-		   matcher->action_ste[0].rtc_0_id,
-		   (int)ste_0_id,
-		   matcher->action_ste[0].rtc_1_id,
-		   (int)ste_1_id,
+		   matcher->action_ste.rtc_0_id, (int)ste_0_id,
+		   matcher->action_ste.rtc_1_id, (int)ste_1_id,
 		   0,
 		   mlx5hws_debug_icm_to_idx(icm_addr_0),
 		   mlx5hws_debug_icm_to_idx(icm_addr_1));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/internal.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/internal.h
index 3c8635f286ce..30ccd635b505 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/internal.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/internal.h
@@ -39,7 +39,6 @@
 #define mlx5hws_dbg(ctx, arg...) mlx5_core_dbg((ctx)->mdev, ##arg)
 
 #define MLX5HWS_TABLE_TYPE_BASE 2
-#define MLX5HWS_ACTION_STE_IDX_ANY 0
 
 static inline bool is_mem_zero(const u8 *mem, size_t size)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 4419c72ad314..74a03fbabcf7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -200,7 +200,7 @@ static void hws_matcher_set_rtc_attr_sz(struct mlx5hws_matcher *matcher,
 					enum mlx5hws_matcher_rtc_type rtc_type,
 					bool is_mirror)
 {
-	struct mlx5hws_pool_chunk *ste = &matcher->action_ste[MLX5HWS_ACTION_STE_IDX_ANY].ste;
+	struct mlx5hws_pool_chunk *ste = &matcher->action_ste.ste;
 	enum mlx5hws_matcher_flow_src flow_src = matcher->attr.optimize_flow_src;
 	bool is_match_rtc = rtc_type == HWS_MATCHER_RTC_TYPE_MATCH;
 
@@ -217,8 +217,7 @@ static void hws_matcher_set_rtc_attr_sz(struct mlx5hws_matcher *matcher,
 }
 
 static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
-				  enum mlx5hws_matcher_rtc_type rtc_type,
-				  u8 action_ste_selector)
+				  enum mlx5hws_matcher_rtc_type rtc_type)
 {
 	struct mlx5hws_matcher_attr *attr = &matcher->attr;
 	struct mlx5hws_cmd_rtc_create_attr rtc_attr = {0};
@@ -278,7 +277,7 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 		break;
 
 	case HWS_MATCHER_RTC_TYPE_STE_ARRAY:
-		action_ste = &matcher->action_ste[action_ste_selector];
+		action_ste = &matcher->action_ste;
 
 		rtc_0_id = &action_ste->rtc_0_id;
 		rtc_1_id = &action_ste->rtc_1_id;
@@ -350,8 +349,7 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 }
 
 static void hws_matcher_destroy_rtc(struct mlx5hws_matcher *matcher,
-				    enum mlx5hws_matcher_rtc_type rtc_type,
-				    u8 action_ste_selector)
+				    enum mlx5hws_matcher_rtc_type rtc_type)
 {
 	struct mlx5hws_matcher_action_ste *action_ste;
 	struct mlx5hws_table *tbl = matcher->tbl;
@@ -367,7 +365,7 @@ static void hws_matcher_destroy_rtc(struct mlx5hws_matcher *matcher,
 		ste = &matcher->match_ste.ste;
 		break;
 	case HWS_MATCHER_RTC_TYPE_STE_ARRAY:
-		action_ste = &matcher->action_ste[action_ste_selector];
+		action_ste = &matcher->action_ste;
 		rtc_0_id = action_ste->rtc_0_id;
 		rtc_1_id = action_ste->rtc_1_id;
 		ste_pool = action_ste->pool;
@@ -458,20 +456,13 @@ static int hws_matcher_resize_init(struct mlx5hws_matcher *src_matcher)
 	if (!resize_data)
 		return -ENOMEM;
 
-	resize_data->max_stes = src_matcher->action_ste[MLX5HWS_ACTION_STE_IDX_ANY].max_stes;
-
-	resize_data->action_ste[0].stc = src_matcher->action_ste[0].stc;
-	resize_data->action_ste[0].rtc_0_id = src_matcher->action_ste[0].rtc_0_id;
-	resize_data->action_ste[0].rtc_1_id = src_matcher->action_ste[0].rtc_1_id;
-	resize_data->action_ste[0].pool = src_matcher->action_ste[0].max_stes ?
-					  src_matcher->action_ste[0].pool :
-					  NULL;
-	resize_data->action_ste[1].stc = src_matcher->action_ste[1].stc;
-	resize_data->action_ste[1].rtc_0_id = src_matcher->action_ste[1].rtc_0_id;
-	resize_data->action_ste[1].rtc_1_id = src_matcher->action_ste[1].rtc_1_id;
-	resize_data->action_ste[1].pool = src_matcher->action_ste[1].max_stes ?
-					  src_matcher->action_ste[1].pool :
-					   NULL;
+	resize_data->max_stes = src_matcher->action_ste.max_stes;
+
+	resize_data->stc = src_matcher->action_ste.stc;
+	resize_data->rtc_0_id = src_matcher->action_ste.rtc_0_id;
+	resize_data->rtc_1_id = src_matcher->action_ste.rtc_1_id;
+	resize_data->pool = src_matcher->action_ste.max_stes ?
+			    src_matcher->action_ste.pool : NULL;
 
 	/* Place the new resized matcher on the dst matcher's list */
 	list_add(&resize_data->list_node, &src_matcher->resize_dst->resize_data);
@@ -504,42 +495,60 @@ static void hws_matcher_resize_uninit(struct mlx5hws_matcher *matcher)
 		if (resize_data->max_stes) {
 			mlx5hws_action_free_single_stc(matcher->tbl->ctx,
 						       matcher->tbl->type,
-						       &resize_data->action_ste[1].stc);
-			mlx5hws_action_free_single_stc(matcher->tbl->ctx,
-						       matcher->tbl->type,
-						       &resize_data->action_ste[0].stc);
+						       &resize_data->stc);
 
-			if (matcher->tbl->type == MLX5HWS_TABLE_TYPE_FDB) {
+			if (matcher->tbl->type == MLX5HWS_TABLE_TYPE_FDB)
 				mlx5hws_cmd_rtc_destroy(matcher->tbl->ctx->mdev,
-							resize_data->action_ste[1].rtc_1_id);
-				mlx5hws_cmd_rtc_destroy(matcher->tbl->ctx->mdev,
-							resize_data->action_ste[0].rtc_1_id);
-			}
-			mlx5hws_cmd_rtc_destroy(matcher->tbl->ctx->mdev,
-						resize_data->action_ste[1].rtc_0_id);
+							resize_data->rtc_1_id);
+
 			mlx5hws_cmd_rtc_destroy(matcher->tbl->ctx->mdev,
-						resize_data->action_ste[0].rtc_0_id);
-			if (resize_data->action_ste[MLX5HWS_ACTION_STE_IDX_ANY].pool) {
-				mlx5hws_pool_destroy(resize_data->action_ste[1].pool);
-				mlx5hws_pool_destroy(resize_data->action_ste[0].pool);
-			}
+						resize_data->rtc_0_id);
+
+			if (resize_data->pool)
+				mlx5hws_pool_destroy(resize_data->pool);
 		}
 
 		kfree(resize_data);
 	}
 }
 
-static int
-hws_matcher_bind_at_idx(struct mlx5hws_matcher *matcher, u8 action_ste_selector)
+static int hws_matcher_bind_at(struct mlx5hws_matcher *matcher)
 {
+	bool is_jumbo = mlx5hws_matcher_mt_is_jumbo(matcher->mt);
 	struct mlx5hws_cmd_stc_modify_attr stc_attr = {0};
 	struct mlx5hws_matcher_action_ste *action_ste;
 	struct mlx5hws_table *tbl = matcher->tbl;
 	struct mlx5hws_pool_attr pool_attr = {0};
 	struct mlx5hws_context *ctx = tbl->ctx;
-	int ret;
+	u32 required_stes;
+	u8 max_stes = 0;
+	int i, ret;
 
-	action_ste = &matcher->action_ste[action_ste_selector];
+	if (matcher->flags & MLX5HWS_MATCHER_FLAGS_COLLISION)
+		return 0;
+
+	for (i = 0; i < matcher->num_of_at; i++) {
+		struct mlx5hws_action_template *at = &matcher->at[i];
+
+		ret = hws_matcher_check_and_process_at(matcher, at);
+		if (ret) {
+			mlx5hws_err(ctx, "Invalid at %d", i);
+			return ret;
+		}
+
+		required_stes = at->num_of_action_stes - (!is_jumbo || at->only_term);
+		max_stes = max(max_stes, required_stes);
+
+		/* Future: Optimize reparse */
+	}
+
+	/* There are no additional STEs required for matcher */
+	if (!max_stes)
+		return 0;
+
+	matcher->action_ste.max_stes = max_stes;
+
+	action_ste = &matcher->action_ste;
 
 	/* Allocate action STE mempool */
 	pool_attr.table_type = tbl->type;
@@ -555,7 +564,7 @@ hws_matcher_bind_at_idx(struct mlx5hws_matcher *matcher, u8 action_ste_selector)
 	}
 
 	/* Allocate action RTC */
-	ret = hws_matcher_create_rtc(matcher, HWS_MATCHER_RTC_TYPE_STE_ARRAY, action_ste_selector);
+	ret = hws_matcher_create_rtc(matcher, HWS_MATCHER_RTC_TYPE_STE_ARRAY);
 	if (ret) {
 		mlx5hws_err(ctx, "Failed to create action RTC\n");
 		goto free_ste_pool;
@@ -579,18 +588,18 @@ hws_matcher_bind_at_idx(struct mlx5hws_matcher *matcher, u8 action_ste_selector)
 	return 0;
 
 free_rtc:
-	hws_matcher_destroy_rtc(matcher, HWS_MATCHER_RTC_TYPE_STE_ARRAY, action_ste_selector);
+	hws_matcher_destroy_rtc(matcher, HWS_MATCHER_RTC_TYPE_STE_ARRAY);
 free_ste_pool:
 	mlx5hws_pool_destroy(action_ste->pool);
 	return ret;
 }
 
-static void hws_matcher_unbind_at_idx(struct mlx5hws_matcher *matcher, u8 action_ste_selector)
+static void hws_matcher_unbind_at(struct mlx5hws_matcher *matcher)
 {
 	struct mlx5hws_matcher_action_ste *action_ste;
 	struct mlx5hws_table *tbl = matcher->tbl;
 
-	action_ste = &matcher->action_ste[action_ste_selector];
+	action_ste = &matcher->action_ste;
 
 	if (!action_ste->max_stes ||
 	    matcher->flags & MLX5HWS_MATCHER_FLAGS_COLLISION ||
@@ -598,65 +607,10 @@ static void hws_matcher_unbind_at_idx(struct mlx5hws_matcher *matcher, u8 action
 		return;
 
 	mlx5hws_action_free_single_stc(tbl->ctx, tbl->type, &action_ste->stc);
-	hws_matcher_destroy_rtc(matcher, HWS_MATCHER_RTC_TYPE_STE_ARRAY, action_ste_selector);
+	hws_matcher_destroy_rtc(matcher, HWS_MATCHER_RTC_TYPE_STE_ARRAY);
 	mlx5hws_pool_destroy(action_ste->pool);
 }
 
-static int hws_matcher_bind_at(struct mlx5hws_matcher *matcher)
-{
-	bool is_jumbo = mlx5hws_matcher_mt_is_jumbo(matcher->mt);
-	struct mlx5hws_table *tbl = matcher->tbl;
-	struct mlx5hws_context *ctx = tbl->ctx;
-	u32 required_stes;
-	u8 max_stes = 0;
-	int i, ret;
-
-	if (matcher->flags & MLX5HWS_MATCHER_FLAGS_COLLISION)
-		return 0;
-
-	for (i = 0; i < matcher->num_of_at; i++) {
-		struct mlx5hws_action_template *at = &matcher->at[i];
-
-		ret = hws_matcher_check_and_process_at(matcher, at);
-		if (ret) {
-			mlx5hws_err(ctx, "Invalid at %d", i);
-			return ret;
-		}
-
-		required_stes = at->num_of_action_stes - (!is_jumbo || at->only_term);
-		max_stes = max(max_stes, required_stes);
-
-		/* Future: Optimize reparse */
-	}
-
-	/* There are no additional STEs required for matcher */
-	if (!max_stes)
-		return 0;
-
-	matcher->action_ste[0].max_stes = max_stes;
-	matcher->action_ste[1].max_stes = max_stes;
-
-	ret = hws_matcher_bind_at_idx(matcher, 0);
-	if (ret)
-		return ret;
-
-	ret = hws_matcher_bind_at_idx(matcher, 1);
-	if (ret)
-		goto free_at_0;
-
-	return 0;
-
-free_at_0:
-	hws_matcher_unbind_at_idx(matcher, 0);
-	return ret;
-}
-
-static void hws_matcher_unbind_at(struct mlx5hws_matcher *matcher)
-{
-	hws_matcher_unbind_at_idx(matcher, 1);
-	hws_matcher_unbind_at_idx(matcher, 0);
-}
-
 static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 {
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
@@ -802,7 +756,7 @@ static int hws_matcher_create_and_connect(struct mlx5hws_matcher *matcher)
 		goto unbind_at;
 
 	/* Allocate the RTC for the new matcher */
-	ret = hws_matcher_create_rtc(matcher, HWS_MATCHER_RTC_TYPE_MATCH, 0);
+	ret = hws_matcher_create_rtc(matcher, HWS_MATCHER_RTC_TYPE_MATCH);
 	if (ret)
 		goto destroy_end_ft;
 
@@ -814,7 +768,7 @@ static int hws_matcher_create_and_connect(struct mlx5hws_matcher *matcher)
 	return 0;
 
 destroy_rtc:
-	hws_matcher_destroy_rtc(matcher, HWS_MATCHER_RTC_TYPE_MATCH, 0);
+	hws_matcher_destroy_rtc(matcher, HWS_MATCHER_RTC_TYPE_MATCH);
 destroy_end_ft:
 	hws_matcher_destroy_end_ft(matcher);
 unbind_at:
@@ -828,7 +782,7 @@ static void hws_matcher_destroy_and_disconnect(struct mlx5hws_matcher *matcher)
 {
 	hws_matcher_resize_uninit(matcher);
 	hws_matcher_disconnect(matcher);
-	hws_matcher_destroy_rtc(matcher, HWS_MATCHER_RTC_TYPE_MATCH, 0);
+	hws_matcher_destroy_rtc(matcher, HWS_MATCHER_RTC_TYPE_MATCH);
 	hws_matcher_destroy_end_ft(matcher);
 	hws_matcher_unbind_at(matcher);
 	hws_matcher_unbind_mt(matcher);
@@ -962,10 +916,9 @@ int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
 		return ret;
 
 	required_stes = at->num_of_action_stes - (!is_jumbo || at->only_term);
-	if (matcher->action_ste[MLX5HWS_ACTION_STE_IDX_ANY].max_stes < required_stes) {
+	if (matcher->action_ste.max_stes < required_stes) {
 		mlx5hws_dbg(ctx, "Required STEs [%d] exceeds initial action template STE [%d]\n",
-			    required_stes,
-			    matcher->action_ste[MLX5HWS_ACTION_STE_IDX_ANY].max_stes);
+			    required_stes, matcher->action_ste.max_stes);
 		return -ENOMEM;
 	}
 
@@ -1149,8 +1102,7 @@ static int hws_matcher_resize_precheck(struct mlx5hws_matcher *src_matcher,
 		return -EINVAL;
 	}
 
-	if (src_matcher->action_ste[MLX5HWS_ACTION_STE_IDX_ANY].max_stes >
-	    dst_matcher->action_ste[0].max_stes) {
+	if (src_matcher->action_ste.max_stes > dst_matcher->action_ste.max_stes) {
 		mlx5hws_err(ctx, "Src/dst matcher max STEs mismatch\n");
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
index 81ff487f57be..cff4ae854a79 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
@@ -52,15 +52,11 @@ struct mlx5hws_matcher_action_ste {
 	u8 max_stes;
 };
 
-struct mlx5hws_matcher_resize_data_node {
+struct mlx5hws_matcher_resize_data {
 	struct mlx5hws_pool_chunk stc;
 	u32 rtc_0_id;
 	u32 rtc_1_id;
 	struct mlx5hws_pool *pool;
-};
-
-struct mlx5hws_matcher_resize_data {
-	struct mlx5hws_matcher_resize_data_node action_ste[2];
 	u8 max_stes;
 	struct list_head list_node;
 };
@@ -78,7 +74,7 @@ struct mlx5hws_matcher {
 	struct mlx5hws_matcher *col_matcher;
 	struct mlx5hws_matcher *resize_dst;
 	struct mlx5hws_matcher_match_ste match_ste;
-	struct mlx5hws_matcher_action_ste action_ste[2];
+	struct mlx5hws_matcher_action_ste action_ste;
 	struct list_head list_node;
 	struct list_head resize_data;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
index 14f6307a1772..699a73ed2fd7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
@@ -142,14 +142,9 @@ hws_rule_save_resize_info(struct mlx5hws_rule *rule,
 			return;
 		}
 
-		rule->resize_info->max_stes =
-			rule->matcher->action_ste[MLX5HWS_ACTION_STE_IDX_ANY].max_stes;
-		rule->resize_info->action_ste_pool[0] = rule->matcher->action_ste[0].max_stes ?
-							rule->matcher->action_ste[0].pool :
-							NULL;
-		rule->resize_info->action_ste_pool[1] = rule->matcher->action_ste[1].max_stes ?
-							rule->matcher->action_ste[1].pool :
-							NULL;
+		rule->resize_info->max_stes = rule->matcher->action_ste.max_stes;
+		rule->resize_info->action_ste_pool = rule->matcher->action_ste.max_stes ?
+						     rule->matcher->action_ste.pool : NULL;
 	}
 
 	memcpy(rule->resize_info->ctrl_seg, ste_attr->wqe_ctrl,
@@ -204,15 +199,15 @@ hws_rule_load_delete_info(struct mlx5hws_rule *rule,
 	}
 }
 
-static int hws_rule_alloc_action_ste_idx(struct mlx5hws_rule *rule,
-					 u8 action_ste_selector)
+static int hws_rule_alloc_action_ste(struct mlx5hws_rule *rule,
+				     struct mlx5hws_rule_attr *attr)
 {
 	struct mlx5hws_matcher *matcher = rule->matcher;
 	struct mlx5hws_matcher_action_ste *action_ste;
 	struct mlx5hws_pool_chunk ste = {0};
 	int ret;
 
-	action_ste = &matcher->action_ste[action_ste_selector];
+	action_ste = &matcher->action_ste;
 	ste.order = ilog2(roundup_pow_of_two(action_ste->max_stes));
 	ret = mlx5hws_pool_chunk_alloc(action_ste->pool, &ste);
 	if (unlikely(ret)) {
@@ -225,8 +220,7 @@ static int hws_rule_alloc_action_ste_idx(struct mlx5hws_rule *rule,
 	return 0;
 }
 
-static void hws_rule_free_action_ste_idx(struct mlx5hws_rule *rule,
-					 u8 action_ste_selector)
+void mlx5hws_rule_free_action_ste(struct mlx5hws_rule *rule)
 {
 	struct mlx5hws_matcher *matcher = rule->matcher;
 	struct mlx5hws_pool_chunk ste = {0};
@@ -236,10 +230,10 @@ static void hws_rule_free_action_ste_idx(struct mlx5hws_rule *rule,
 	if (mlx5hws_matcher_is_resizable(matcher)) {
 		/* Free the original action pool if rule was resized */
 		max_stes = rule->resize_info->max_stes;
-		pool = rule->resize_info->action_ste_pool[action_ste_selector];
+		pool = rule->resize_info->action_ste_pool;
 	} else {
-		max_stes = matcher->action_ste[action_ste_selector].max_stes;
-		pool = matcher->action_ste[action_ste_selector].pool;
+		max_stes = matcher->action_ste.max_stes;
+		pool = matcher->action_ste.pool;
 	}
 
 	/* This release is safe only when the rule match part was deleted */
@@ -249,41 +243,6 @@ static void hws_rule_free_action_ste_idx(struct mlx5hws_rule *rule,
 	mlx5hws_pool_chunk_free(pool, &ste);
 }
 
-static int hws_rule_alloc_action_ste(struct mlx5hws_rule *rule,
-				     struct mlx5hws_rule_attr *attr)
-{
-	int action_ste_idx;
-	int ret;
-
-	ret = hws_rule_alloc_action_ste_idx(rule, 0);
-	if (unlikely(ret))
-		return ret;
-
-	action_ste_idx = rule->action_ste_idx;
-
-	ret = hws_rule_alloc_action_ste_idx(rule, 1);
-	if (unlikely(ret)) {
-		hws_rule_free_action_ste_idx(rule, 0);
-		return ret;
-	}
-
-	/* Both pools have to return the same index */
-	if (unlikely(rule->action_ste_idx != action_ste_idx)) {
-		pr_warn("HWS: allocation of action STE failed - pool indexes mismatch\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-void mlx5hws_rule_free_action_ste(struct mlx5hws_rule *rule)
-{
-	if (rule->action_ste_idx > -1) {
-		hws_rule_free_action_ste_idx(rule, 1);
-		hws_rule_free_action_ste_idx(rule, 0);
-	}
-}
-
 static void hws_rule_create_init(struct mlx5hws_rule *rule,
 				 struct mlx5hws_send_ste_attr *ste_attr,
 				 struct mlx5hws_actions_apply_data *apply,
@@ -298,9 +257,6 @@ static void hws_rule_create_init(struct mlx5hws_rule *rule,
 		/* In update we use these rtc's */
 		rule->rtc_0 = 0;
 		rule->rtc_1 = 0;
-		rule->action_ste_selector = 0;
-	} else {
-		rule->action_ste_selector = !rule->action_ste_selector;
 	}
 
 	rule->pending_wqes = 0;
@@ -316,7 +272,7 @@ static void hws_rule_create_init(struct mlx5hws_rule *rule,
 	/* Init default action apply */
 	apply->tbl_type = tbl->type;
 	apply->common_res = &ctx->common_res;
-	apply->jump_to_action_stc = matcher->action_ste[0].stc.offset;
+	apply->jump_to_action_stc = matcher->action_ste.stc.offset;
 	apply->require_dep = 0;
 }
 
@@ -333,7 +289,6 @@ static void hws_rule_move_init(struct mlx5hws_rule *rule,
 
 	rule->pending_wqes = 0;
 	rule->action_ste_idx = -1;
-	rule->action_ste_selector = 0;
 	rule->status = MLX5HWS_RULE_STATUS_CREATING;
 	rule->resize_info->state = MLX5HWS_RULE_RESIZE_STATE_WRITING;
 }
@@ -403,10 +358,8 @@ static int hws_rule_create_hws(struct mlx5hws_rule *rule,
 			}
 		}
 		/* Skip RX/TX based on the dep_wqe init */
-		ste_attr.rtc_0 = dep_wqe->rtc_0 ?
-				 matcher->action_ste[rule->action_ste_selector].rtc_0_id : 0;
-		ste_attr.rtc_1 = dep_wqe->rtc_1 ?
-				 matcher->action_ste[rule->action_ste_selector].rtc_1_id : 0;
+		ste_attr.rtc_0 = dep_wqe->rtc_0 ? matcher->action_ste.rtc_0_id : 0;
+		ste_attr.rtc_1 = dep_wqe->rtc_1 ? matcher->action_ste.rtc_1_id : 0;
 		/* Action STEs are written to a specific index last to first */
 		ste_attr.direct_index = rule->action_ste_idx + action_stes;
 		apply.next_direct_idx = ste_attr.direct_index;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
index 495cdd17e9f3..fd2bef87116b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
@@ -42,7 +42,7 @@ struct mlx5hws_rule_match_tag {
 };
 
 struct mlx5hws_rule_resize_info {
-	struct mlx5hws_pool *action_ste_pool[2];
+	struct mlx5hws_pool *action_ste_pool;
 	u32 rtc_0;
 	u32 rtc_1;
 	u32 rule_idx;
@@ -62,7 +62,6 @@ struct mlx5hws_rule {
 	u32 rtc_1; /* The RTC into which the STE was inserted */
 	int action_ste_idx; /* STE array index */
 	u8 status; /* enum mlx5hws_rule_status */
-	u8 action_ste_selector; /* For rule update - which action STE is in use */
 	u8 pending_wqes;
 	bool skip_delete; /* For complex rules - another rule with same tag
 			   * still exists, so don't actually delete this rule.
-- 
2.45.0


