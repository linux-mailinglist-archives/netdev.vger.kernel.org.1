Return-Path: <netdev+bounces-162266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C42DFA265BE
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE741886155
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80C420F09D;
	Mon,  3 Feb 2025 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lzfhtLUf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0720B7EE
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618600; cv=fail; b=rIhJ0YVykS/lY5ch31e1r2Pfm4p3UZZe5Vp0FB3OlLvpiDa9y7TzfusgN9YMQwBUC/rhfA5WHVcTgi5SAMa5eCL3e6wQTBaRWCHGT8ss5biyntu3FEET+UKyeEqIwesrXHVxEwpsSqrZnI+RDp6kx/xnUhN1EjevFFBUSSefQSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618600; c=relaxed/simple;
	bh=csZ5vQLsxJzJDIRAv7v6R0WPaFus13YvMpCFXNoMII8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXT1xm9ydQf1sMzhbELfXY10HbTdhmL51FLynSCAjEkvGx4Azbj6NfcswWSuwOPckKqf55IRCi3zUBeHyj7RlOaNj+07eabfOrEGmH8BSiYoFOFybjpFD+HjLxzzKD4vIOiQditwjHedOhsANmYKGB9fxBfVJO9vmHzLod9szyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lzfhtLUf; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTqn+BoaPGMWt/QL+pG4JQ9kkayrsii5ozK0ID4BifTTSy2VspJ7UnvG5UVrV076pX7WAn5R07etfQhYZnRvTBiDnE4yVei6Ccfof1zAB4AVtpt2GxCy8JyrfMOafc1xG7qU/qOTq0Fzu/CMopck+A6xkHQToZkq3CYXd97JoOmYH1NDEYJ01pokyPtN3W5KI2hIRTSkBgnoezbCyuZiZdo6/LcQnIj9LYd5LzGx8C2Q06Pjt3ygNTtls3lwfHVPlfTJqTEHLjOx4FUQAjg69wgeHYQllIOV1Avc4eBWOAuUAy1q53lbxmM9ide3iI0y8XRFTXtAOyE08eMMa7bpEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYkex5FJ5kKN8egXMJh7OJoR2jabuM38I4CrGkPlWQo=;
 b=VYQZTwdQEYcs4Zn8QgBq1ZTOHzRjN86n+iiHpGzQuVwRTFYiA9mdUyushK5E8skVJPVQGE8cIhD2pPlErdCLJXjnJTmBgkZBtuImRx3Dp9dk/JgYO1LoadyGPuhQWV9rt2wWqYoVILTUQPQZ9fz6VmjacMpO+X9528LRapCXKcI9DUas2Rh6QvhwkCT5lpRXHHmh4e8jQJR/S6sKF0T4UdNbPalbVQfjUuldu2n6RssdzATeXqCF07vYKNIpmOBOt80DAn6bGLDKz8HhnP77BChPWisGoFTi+r66CjKwUrQrE018+5u5WjkiBtqH0qn86NKccD2bgs1q95l1k/adBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYkex5FJ5kKN8egXMJh7OJoR2jabuM38I4CrGkPlWQo=;
 b=lzfhtLUfZfXplF0u1tQNSpq7LMAbnuqNsEOhCY3EL+l9O+efsAMM35McREajPJl0E6gmst5TXFXLgaBtZR3+hZfrJ90ircxNi0rrrhMHJSso4ONg1n+WmYZkOWtRxFobVoICQJLWjSJRYxZNYcEOAnGE6paAdPtDdgpaTFKQZ90XLzrAm1dQGgEgKZOLfLhjn5i7H9A4vwPsin3ateHAw6VSgLjS2/Ggs/PhtIcxUvUpNYICL5wABI/b5+qmxr/MqxLWPs1YgH2olM6BT1mAQ9wGr+llV1AOI6cJLQ9BZU4QBhvisC00BVRV5Cmih5YOlBdi8fYAzLFlEPIXnAEDhA==
Received: from SJ0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:a03:333::29)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Mon, 3 Feb
 2025 21:36:32 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::51) by SJ0PR03CA0114.outlook.office365.com
 (2603:10b6:a03:333::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 21:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:36:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:10 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:06 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 01/15] net/mlx5: Add helper functions for PTP callbacks
Date: Mon, 3 Feb 2025 23:35:02 +0200
Message-ID: <20250203213516.227902-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250203213516.227902-1-tariqt@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b490361-5a5d-4976-b69e-08dd449ad35b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/H/n99tBjOMebn0yJRw/iIghbE97Y4MXMiQ3O1JkDRTBEj9dEGGivtrG7eu4?=
 =?us-ascii?Q?aqoprLqVDIqHLLixA+tjTV1nXWame2qWWyfvGdgHzb7XiThGkNeASsudAGyf?=
 =?us-ascii?Q?kS3OgOJYUfPTic+0PVuGpifgOwDPv8NUdRlRF4ZJ/go15T4Z5l8fkrYVWP1O?=
 =?us-ascii?Q?yBwgldqzO7q1ZCp4BCOHw2k2RH2NJKcuaJOuugbP/eVjbwNqHCPI1UKlCbWI?=
 =?us-ascii?Q?bpFFZgmvbPgoREZ8/mmsUrHDsf3/sJg6yaWKGafRhPPWq/CMC0oNux0mQ49P?=
 =?us-ascii?Q?4giTyvB2aAGq1OxvYRm60IGYhDi4h+RECSw5rEoCdftJ/jrtUwLPoDRzvMFz?=
 =?us-ascii?Q?FdiVVD5IJUWQ2GKoaRIkbfcYG+3pgL5SD6BwLgZmyeBnTC8do01c57hchJHt?=
 =?us-ascii?Q?vRXYmLU86DFY4ZxNNmrBZpQ6pXSqzj9cXafIQ4dZHrZvFvH4TkoryHbsX9Cj?=
 =?us-ascii?Q?NhM8MGR3cl5Fb5vH81ej5Fsa3AMk1OjbIFtG0WAseF38/S+W8cfXKfJjxtzu?=
 =?us-ascii?Q?w4kKlyH97pYz8K8Z6e2C4fM3XGv8pRHZY7/5ehTFpjFSYZ6+MmBY+geyCBJs?=
 =?us-ascii?Q?mNwPWKtZuJa1dfNPQxIOWii9vCIBzD43wEdW8qt7HFfVQAkOvAQBqvfyZoQR?=
 =?us-ascii?Q?EHMeTes/XpBLDhTsBTCyB7wqDsRx9wRPQss30cccIQTbIIgCjkICD/oaDXi6?=
 =?us-ascii?Q?Gt7yRcXT6wi/uSzh+GlDahiZdzvhXa3AiWCyn1y1THp9eE5Ywpql/N0JrM/U?=
 =?us-ascii?Q?rFfn6pU2Qt6BROGqk/fdeLjEmzwQBs60QuKVVk5Ly0Z6xsspVQ2Lmp0ctpKE?=
 =?us-ascii?Q?xuytTflISnBSrgLESpK7oIK85FiquttaAdmABUDdELFdY50aOgnulIxyayDp?=
 =?us-ascii?Q?MnK+WUNCKkn8H+YQPA9KqLubwkvUTIm1ATJ0l+tjTAHrCJF0kFSS1W0jql6N?=
 =?us-ascii?Q?kC5bloxVPvwSkkXxmyh1o/E82GtiojY2xfRQQlSP0Pu5hDmTXin7Z6O9qAJn?=
 =?us-ascii?Q?kovl3eGB5OON2j3Nc6T+BBLkTYmb5JPnOgBdL4MmodLGLWKtAQnCBxI9aGPa?=
 =?us-ascii?Q?xJu3RobX22YcFNoMUSGuRGdYV+vGZx5uw0kCDbh4coTOT6kLAcNgQqdvdXKx?=
 =?us-ascii?Q?zxPemlNCY6T0J/r5FKLh3Eupz0hWNbxvkIu6sic8XcD/WvBrRzskTcVQLk59?=
 =?us-ascii?Q?9sFU+S61fvupng29Q5af4/CfYcrkbUG25Ve7C2dKmfuPvr9nGqPHLsfkGvL1?=
 =?us-ascii?Q?SUjaF86Pto/v1qbD0ccVnsnzLNvzyIMJmWOtWzAEpRkczcsckEOJGuM6PFjW?=
 =?us-ascii?Q?j02TjIeVuQdVPsLvyNm7M76jxc3mU7CgN6rfbkBjdllTWysxys+pLI4VQi/T?=
 =?us-ascii?Q?If0eVSiW67q7NZ5OkTtcuu5zZVoMn7Hk/jj27fKY3miTUQ1dhCoaKU18Brk6?=
 =?us-ascii?Q?H06CMdTL+Uo448gfu12yamhKhtr+0F/NOFql4IJYVpfLnhADMeoX/2Fk3crL?=
 =?us-ascii?Q?zV9KzAmUEaujmBc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:36:31.7665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b490361-5a5d-4976-b69e-08dd449ad35b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987

From: Jianbo Liu <jianbol@nvidia.com>

The PTP callback functions should not be used directly by internal
callers. Add helpers that can be used internally and externally.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 32 +++++++++++++------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index d61a1a9297c9..eaf343756026 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -119,6 +119,13 @@ static u32 mlx5_ptp_shift_constant(u32 dev_freq_khz)
 		   ilog2((U32_MAX / NSEC_PER_MSEC) * dev_freq_khz));
 }
 
+static s32 mlx5_clock_getmaxphase(struct mlx5_core_dev *mdev)
+{
+	return MLX5_CAP_MCAM_FEATURE(mdev, mtutc_time_adjustment_extended_range) ?
+		       MLX5_MTUTC_OPERATION_ADJUST_TIME_EXTENDED_MAX :
+			     MLX5_MTUTC_OPERATION_ADJUST_TIME_MAX;
+}
+
 static s32 mlx5_ptp_getmaxphase(struct ptp_clock_info *ptp)
 {
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
@@ -126,14 +133,12 @@ static s32 mlx5_ptp_getmaxphase(struct ptp_clock_info *ptp)
 
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
 
-	return MLX5_CAP_MCAM_FEATURE(mdev, mtutc_time_adjustment_extended_range) ?
-		       MLX5_MTUTC_OPERATION_ADJUST_TIME_EXTENDED_MAX :
-			     MLX5_MTUTC_OPERATION_ADJUST_TIME_MAX;
+	return mlx5_clock_getmaxphase(mdev);
 }
 
 static bool mlx5_is_mtutc_time_adj_cap(struct mlx5_core_dev *mdev, s64 delta)
 {
-	s64 max = mlx5_ptp_getmaxphase(&mdev->clock.ptp_info);
+	s64 max = mlx5_clock_getmaxphase(mdev);
 
 	if (delta < -max || delta > max)
 		return false;
@@ -361,15 +366,12 @@ static int mlx5_ptp_settime_real_time(struct mlx5_core_dev *mdev,
 	return mlx5_set_mtutc(mdev, in, sizeof(in));
 }
 
-static int mlx5_ptp_settime(struct ptp_clock_info *ptp, const struct timespec64 *ts)
+static int mlx5_clock_settime(struct mlx5_core_dev *mdev, struct mlx5_clock *clock,
+			      const struct timespec64 *ts)
 {
-	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
 	struct mlx5_timer *timer = &clock->timer;
-	struct mlx5_core_dev *mdev;
 	unsigned long flags;
 
-	mdev = container_of(clock, struct mlx5_core_dev, clock);
-
 	if (mlx5_modify_mtutc_allowed(mdev)) {
 		int err = mlx5_ptp_settime_real_time(mdev, ts);
 
@@ -385,6 +387,16 @@ static int mlx5_ptp_settime(struct ptp_clock_info *ptp, const struct timespec64
 	return 0;
 }
 
+static int mlx5_ptp_settime(struct ptp_clock_info *ptp, const struct timespec64 *ts)
+{
+	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
+	struct mlx5_core_dev *mdev;
+
+	mdev = container_of(clock, struct mlx5_core_dev, clock);
+
+	return  mlx5_clock_settime(mdev, clock, ts);
+}
+
 static
 struct timespec64 mlx5_ptp_gettimex_real_time(struct mlx5_core_dev *mdev,
 					      struct ptp_system_timestamp *sts)
@@ -1129,7 +1141,7 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 		struct timespec64 ts;
 
 		ktime_get_real_ts64(&ts);
-		mlx5_ptp_settime(&clock->ptp_info, &ts);
+		mlx5_clock_settime(mdev, clock, &ts);
 	}
 }
 
-- 
2.45.0


