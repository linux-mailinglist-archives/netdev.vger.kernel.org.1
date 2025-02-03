Return-Path: <netdev+bounces-162265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093F6A265BD
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9FC7A05DC
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4511F4275;
	Mon,  3 Feb 2025 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YyfhrmUj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA0717C9F1
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618598; cv=fail; b=FNRjh260tlJ/jeVeZp2kn8A/2LPXdYx1e/ZbndJd/3vGs1pG3ciJtEwhgZzcVpPpZe4nvXZlRvm67mN/6Xu3Fr2q8v/pTUHXDMR0/dhgAPTqsggugZlHd3mbdS9waEI2hyRQYvJUn/4l6U6gFXMXGaWQhCGkpzGWZku6fIP4mfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618598; c=relaxed/simple;
	bh=g6Dwek2cFrbukJPuwAPjkhciDxFmefOqT7gJ9SAro/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=himr9Vw3IOg2Fh2Lb2mPuujjVdT+hqZW31mp8pjWKO+7YXH+jhiOL/+bxRVF5dcRpebTPdEz/ACmhvfCaltknYtBPhGjiF8TrrAPyy+t+uYOAdsTNvMHBc52AC0bc1CMnS0xlQyxSYdbxVz6g16+1H3jhsOnNNaR79hqMBVDCUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YyfhrmUj; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+9mT+m/F6mBJfj+4YRYB7E8eDhmUfit+sV7oLgtlb/E1tT6ePi1qlAg5bQK65xW92dbY6FdyETVl/fvpU7HPSjf5g05wYnRYV92cwD3RZJAFq5F6jSlZ0qVaInulU7+qr3UmhwPOPw5gupgNAlMFOfNmSju55EKh5pVK8HY3uD6KATol2+6FqgcxX2QhOABhAF8qFUnSgq4yhY4LG6VnGfRliNTcZzKZGc5RrtGHGtD+OSlaCypSNdHHhTCpd8usCja7T8AFeABf7z2d39WTTR/3KH+osbwQ0gxL+96ijLujbmMKH3AlJOhPurZ03CVCoLLbf7/6NHJCF9YfyVFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMpDjNUeHxA5f1Vee4eU1Ll3rUpAZz22nFhlmZJtLxk=;
 b=XIZJxaMThS/ILrjyN5aPwHMZTt4LsZTp1h5/uNmX4RDU0CbBa0FcpQMLbXv1vG77SIaL70a/RSXJcrj5yu+VoPFvNTsRm0fLyUQ/OU65usay0EZOKmDbkxTI/nwYA25sWVNq4xcVvq9igrYFKyeCQV1pwMfpS2MpJwuFm+3fvtafd4S6ee2u1NV7EBdxvOuf4QrM6fo1RIIGkUKNKyY7dmVW4OdUauh/rTdxa/R3BCKgl2xswm05WbnJfcVo+OLBA46mBa5U/SvdisugG1PijNEBbyMkxLaFmp/EHbOm1CpKCmelwUSnZ/RKfeH6TLKNzLGYLxQUloSfP1ViuA2REQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMpDjNUeHxA5f1Vee4eU1Ll3rUpAZz22nFhlmZJtLxk=;
 b=YyfhrmUjil7Rm+g3uaG7VtiFaETLprhCfEgrbVNCCp6D6/xUGbQohBl8NH14utK84m3AuKov3znW+MczxPGsbIkLei2r/A8GJI/qWTVDBe2gXZyBUYdi/Dz6NZp+1CuAZQOZe255rpHo8vVG+e107CA8uInH7BH+XTjsWZDyOwl/CaMvY39dN0Wg7NWiJuvD0UBtPZ8I7co+nMow7X8us0muClr06jbU3H03quFx8ExAvt13fqnTSi4i1dK87T0IFCk/CM60ie93wkPvpL7c3wgf1syYcr8PkGCL/KiOXvoTva/wnuqz2KHy47qjc/DyTq2uvS09HVEOwoBfteL5cg==
Received: from SA9PR10CA0007.namprd10.prod.outlook.com (2603:10b6:806:a7::12)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:36:31 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::d9) by SA9PR10CA0007.outlook.office365.com
 (2603:10b6:806:a7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 21:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:36:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:16 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:16 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 02/15] net/mlx5: Change parameters for PTP internal functions
Date: Mon, 3 Feb 2025 23:35:03 +0200
Message-ID: <20250203213516.227902-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|CYYPR12MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5781b1-3d05-4849-3b69-08dd449ad2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5DpSzFAJAed31Ak9xKFqYSrjJ87/AQhLtUnWmPeVXm172PvR6PO4p9bLX561?=
 =?us-ascii?Q?4d/IvNMiC5b4mN2BzLBZYBBe13V5939+mgNNtP9sIOPnLWYie+tuKX+khh09?=
 =?us-ascii?Q?LeJdtINX79izKzG6RLercd34Q8RvYQdE65BnXrNvVvlGdjiwoOj/PS0TRVg7?=
 =?us-ascii?Q?b5uf5usjNt23DGTO+f3px+8QzZEadxMwsYlWO34Q7NUJBaY5Pb3dCdm0B+Vz?=
 =?us-ascii?Q?1Qir9w/nycYCSXNiKNSHiYnTWPxKv9HpJIbxVuj8gACCnfIUOgCwbhdGumml?=
 =?us-ascii?Q?Os7nXP1uIMX/Mv3TcC+AUF1muH4MVO4Gj6CrV6Lx9uTk/A0NeSp8lzZrXW8O?=
 =?us-ascii?Q?1wFjkGeK7yI74jIEdgLhI/syWdst25Gacc5ZOrbDd7VpzeOSsJSMR9P00eGV?=
 =?us-ascii?Q?1Lw4cJzGdOEy1co6cVu5Oh4zgpf95fcEJkLt1p7HKnfbFKbp7OG8ukSGptEa?=
 =?us-ascii?Q?uJbvI+hnXS/Img1JloEW7qnHWoSXdtPYbbJaBvgproZp24lvA0M/FqSpKO/G?=
 =?us-ascii?Q?eiQlxgb/fgKPNY87cDAQM+mxuAmFkz13yr50kiTfX4lGpOU0QyBUXoK+Qd1M?=
 =?us-ascii?Q?QZntXe94ZqZUePSHCq2FjKyVo14V+AYnziFkB9HgPN/UaJ+jq37ojpKxHSiZ?=
 =?us-ascii?Q?KfLl39NZ84FmWQq5+h517E6QmZKoemQz6mzwd/Bf9lDDvrsHfGTdNB5m4n8m?=
 =?us-ascii?Q?l0ydQeRCYkOig+58x93UuOCexfZU65kYAPLrUqR1LJhgHcJU0IOqGCf5aUoe?=
 =?us-ascii?Q?7IisK+hhR9HKFxpD2s5p5OzkESXRcKdoIbJU/LHv1ABJH9wMQrLE/OxgBCg7?=
 =?us-ascii?Q?WDyUWQjkMT4GJqwNtbqbugEtZmpiUZimM37+CqkSM82w2k5ObnqRue+2elh0?=
 =?us-ascii?Q?kZqABTYU7FHSIy9gQAPjmRWnLselcWwbbPQqWSOv6+Oh+kGtzphZ7MWmP1FO?=
 =?us-ascii?Q?Hnc69sl/bzn79E7BP1pLVNvPSF9saq7Lcsu/gXQrZhzqPvacwTGzdTlLxFc5?=
 =?us-ascii?Q?ub/eRGlxkHDsQWVUIu1NHx3uE8Q3Db5vGeXW32lzW7EQ8ko6h2jRMhHrBa0+?=
 =?us-ascii?Q?HUJbF20oemW4LAAmyhTsVifbHrwEAEJJCiAkQp/rzNoGk4J6miNEdzyUfm6a?=
 =?us-ascii?Q?+pMckbpO+g9ck7VyA+D3fTd+vwT+G5hjTgJPUedmeY0v3raLnqkdlFBKKS9e?=
 =?us-ascii?Q?cfxM1TgttIwA+ukHR3DDm+jL0mnaQC4II4rxdT6qZdfQ8siER22zrcKWfd7g?=
 =?us-ascii?Q?Lp3aqpSCs8p7uYuogl6RHWaw5lx+xaNhAJUvMFiAi1qjtqB0nr29hiaxMPoW?=
 =?us-ascii?Q?QPvqhPIDSe/bsMgk7abdDETRugKyoD8f6nr8kxGqoe2MDXEA+DqrPDqOkzi2?=
 =?us-ascii?Q?waBNhi7Ai/kGqSRFTebb3hZYBp+cNG+FGSJ0RGA0tz5vwa7zPFEFQpmkiUMA?=
 =?us-ascii?Q?KJ5bdBsqMHG1k3yoV3iIRD2+9n7IT3UP/4tR7jH5E1ZgR9+gsadHGwqG25e9?=
 =?us-ascii?Q?IU8y8uldRc0DpR8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:36:31.0011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5781b1-3d05-4849-3b69-08dd449ad2f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653

From: Jianbo Liu <jianbol@nvidia.com>

In later patch, the mlx5_clock will be allocated dynamically, its
address can be obtained from mlx5_core_dev struct, but mdev can't be
obtained from mlx5_clock because it can be shared by multiple
interfaces. So change the parameter for such internal functions, only
mdev is passed down from the callers.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index eaf343756026..e7e4bdba02a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -878,10 +878,8 @@ static int mlx5_query_mtpps_pin_mode(struct mlx5_core_dev *mdev, u8 pin,
 				    mtpps_size, MLX5_REG_MTPPS, 0, 0);
 }
 
-static int mlx5_get_pps_pin_mode(struct mlx5_clock *clock, u8 pin)
+static int mlx5_get_pps_pin_mode(struct mlx5_core_dev *mdev, u8 pin)
 {
-	struct mlx5_core_dev *mdev = container_of(clock, struct mlx5_core_dev, clock);
-
 	u32 out[MLX5_ST_SZ_DW(mtpps_reg)] = {};
 	u8 mode;
 	int err;
@@ -900,8 +898,9 @@ static int mlx5_get_pps_pin_mode(struct mlx5_clock *clock, u8 pin)
 	return PTP_PF_NONE;
 }
 
-static void mlx5_init_pin_config(struct mlx5_clock *clock)
+static void mlx5_init_pin_config(struct mlx5_core_dev *mdev)
 {
+	struct mlx5_clock *clock = &mdev->clock;
 	int i;
 
 	if (!clock->ptp_info.n_pins)
@@ -922,7 +921,7 @@ static void mlx5_init_pin_config(struct mlx5_clock *clock)
 			 sizeof(clock->ptp_info.pin_config[i].name),
 			 "mlx5_pps%d", i);
 		clock->ptp_info.pin_config[i].index = i;
-		clock->ptp_info.pin_config[i].func = mlx5_get_pps_pin_mode(clock, i);
+		clock->ptp_info.pin_config[i].func = mlx5_get_pps_pin_mode(mdev, i);
 		clock->ptp_info.pin_config[i].chan = 0;
 	}
 }
@@ -1041,10 +1040,10 @@ static void mlx5_timecounter_init(struct mlx5_core_dev *mdev)
 			 ktime_to_ns(ktime_get_real()));
 }
 
-static void mlx5_init_overflow_period(struct mlx5_clock *clock)
+static void mlx5_init_overflow_period(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_core_dev *mdev = container_of(clock, struct mlx5_core_dev, clock);
 	struct mlx5_ib_clock_info *clock_info = mdev->clock_info;
+	struct mlx5_clock *clock = &mdev->clock;
 	struct mlx5_timer *timer = &clock->timer;
 	u64 overflow_cycles;
 	u64 frac = 0;
@@ -1135,7 +1134,7 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 
 	mlx5_timecounter_init(mdev);
 	mlx5_init_clock_info(mdev);
-	mlx5_init_overflow_period(clock);
+	mlx5_init_overflow_period(mdev);
 
 	if (mlx5_real_time_mode(mdev)) {
 		struct timespec64 ts;
@@ -1147,13 +1146,11 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 
 static void mlx5_init_pps(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_clock *clock = &mdev->clock;
-
 	if (!MLX5_PPS_CAP(mdev))
 		return;
 
 	mlx5_get_pps_caps(mdev);
-	mlx5_init_pin_config(clock);
+	mlx5_init_pin_config(mdev);
 }
 
 void mlx5_init_clock(struct mlx5_core_dev *mdev)
-- 
2.45.0


