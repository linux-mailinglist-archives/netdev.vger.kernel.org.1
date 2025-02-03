Return-Path: <netdev+bounces-162268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3BA265C0
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7228188560F
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E2620F094;
	Mon,  3 Feb 2025 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fb5Zomk1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484A20FAAC
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618610; cv=fail; b=F2HErI900Jo0FGcvrJGTLxo3jPQ3JPMBltLAN8KBdruBG0LPmoHXZzCDRjn5vOGCpn37Oa94+ldpQQSozf9PYRd46yWOw/ojp5gcVBN1h8AkfeAnz6DA3aHIs1OjxTgfFAaGiC0m/7ZQhGVU7NFDuNWP9pRauJYLbismU1gltyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618610; c=relaxed/simple;
	bh=sEivobWtCuuu/wSAB2q64RJCvIuR2RZEvWqchfqo+Ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvp+pkWDDkg5kPIm1AVVzZ8sAVHkLPK9TDGi2S4zCOTOG+lWk8n029LuJGOBLzdAn69YBbYpTqe/qSgvd37Kl8AlMhzxBVPgB/hoAm/GA4NluZ7sirhtRl5cQmS+iWveEC6/ywIN2s2dE8bljJJQPaWezLBC0TR+FkHqAd+I3Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fb5Zomk1; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FA9nUoVf4jqGHQRn5PHHF5RTuM6Md7uYTv0C0EQa+OqjOsaC7At4THqR2EETlXwDzXQGD2zu9qZpYEgW0e57I77VcT1GQ1FM8kPf2LJ36MEhGrZUfq7i2O8F9WeRx+WKjRJ/BZeGRYhHdafrsJcSWe+zIZr3IsbEb4lGVxRPP1BxyzGflhfDD4+eWECfaZR7YxIugsoJKjgkHJ8xjGs2cTNP4xzkV+9bQooT+dBtyE3TwewVv6CqGcie7ufuPQf85nITgcoolECU0MVDb35ZF90s9+4y660PKtF9hNUdpMm5FvaJl7RXTva0yN1ZTzsY3vXHUDpyr3sbUZ6pusFKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ucn/9AC15QM1YKsi8hvb80zuc71i+OcTLtblO3qJHc=;
 b=J5aAq76W8JBZuzPMPdYIQrlZIVoGOb9X+U79R0vcv+svZ/1snUDEO0cXw13UMDhaqccZzs5R1W0AfBuXusW40kYJK6Tn3aGpSM80IZMsBaEkqD9KkBiXxf2VgraGxrUd9M2fNIl+eS57HcJ66BmJedEDbdtonMs0ooPXw/UKQ7eeMqtx0leCHhjotsq/5j9KZBC5A0B8xcWjrfM+/Vxr8N3WB82qyQ4OXFtRGqtzC6OXsQb2gcxiDaBFkeXkdb2sRAMxjZjIEO9t67JEpU3hBHMznm1by5xM6HaheSCiqcrI1UjHZUZJhlB8tgonwDnB1J7IWTDZsP3R8hUAC3zh5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ucn/9AC15QM1YKsi8hvb80zuc71i+OcTLtblO3qJHc=;
 b=Fb5Zomk1PwPGDzVOHkmeefvQL9gWdyVCx78MuHKHBK2wMv7KVxJUtXiU6UdLWCyskeaKw4S2zzfXmicOs2FP+Sltdnp59iseBUersF7Eel7qXh/kXZtOmlH/6LSW98SQUgfKBlt436WBymKSv0CN0GeuxuZs9Dh4hDjQaWuQqsvWQaGNDfNQaB3gPe3s/61WtUpsp8+LLS9M6MnxS7jH++Oa3foAJPxK2etcwlKa90Gisoe66VdAIeN+B/1HCvNZaGhWRlUVgWXyUWhNsGQfJ64YTs9ik2jlqtG0JUQwjYyGoRToarQDFiFAKo5sam38UHuUiGfdEoCkNlg14V7CoA==
Received: from BYAPR02CA0013.namprd02.prod.outlook.com (2603:10b6:a02:ee::26)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:36:44 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::9) by BYAPR02CA0013.outlook.office365.com
 (2603:10b6:a02:ee::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 21:36:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:36:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:25 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:24 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:21 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 04/15] net/mlx5: Add API to get mlx5_core_dev from mlx5_clock
Date: Mon, 3 Feb 2025 23:35:05 +0200
Message-ID: <20250203213516.227902-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 177102d8-5815-476f-9277-08dd449ada2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kKa75SBSaYsNdPQ44cT9OWw4Iyf/Hf/t7n2IsbPXgDdYmKfO2q9823bOnQ++?=
 =?us-ascii?Q?FI43hHyN8pj5tUOC++mD80A3ns1yKtj1q5eNF5rYc+DjbNSxR8PM/woOytV2?=
 =?us-ascii?Q?RxWIeFHCcNyW3h1vlyhovhGoS6ffYsxTDMbH3wSTu2VxazFRRS5EIXLMUfvR?=
 =?us-ascii?Q?DdKTiIOLHO7wzoSma8U3Um/qjA/pbkbTGs4XtcLvN4ofdfQ+NRpbTDUAQ7bi?=
 =?us-ascii?Q?vCVEnBlMefhBrqKVEj0S14EX3oVUJn/4qKJZ28waktDBvWh8hIf6LC4yC32a?=
 =?us-ascii?Q?hBYv9FNfdVLfDaWmjHklM14dTwa7e2Idcb4nx75tll3PhPBJWQ6iTK+b9cQ+?=
 =?us-ascii?Q?4QpGcp4mVtYWiyary+VExXuasuS0NgG/uUMwNYMSnc8/nPozdBC/YA8pvMUw?=
 =?us-ascii?Q?3K7/IopBCqB6pvkcLVMgR3t0aKyrQMi6zslPnMXMisGzAZfcIrb5uYx9ENYw?=
 =?us-ascii?Q?CPRy1lO2kJ7gxcljzaw55F64+KmN+ukuGmBU7UXkZasqleH37IMMJjTwqgBO?=
 =?us-ascii?Q?uT9pOsU1l8rz+ekGEVwx+RuiDj5BEOSinNVnaE8sKO3cn20CsOlqJVTtajNe?=
 =?us-ascii?Q?PJsUC8R31JHKSW6IvHvoziu5DZfHGczUwHNu2JY/+Zib5aPnmOe40/CVwymU?=
 =?us-ascii?Q?6EMFRVcQG26V9EGpbpgy84cH8APJZ+ozbpXc0q1KKMSBcE5s/c4H0B+ZTyrG?=
 =?us-ascii?Q?7RdwSW2uKIuT11oVU8u/DqCBzSbnnW8zKp9fH/0YBzI58vVut6LicZq3vqSt?=
 =?us-ascii?Q?/ZrtQvsUvfIFACL1ow5eQYFIEmrNH3oJdHlhLDmbv+I8rMkUo7zxVH9AGf8j?=
 =?us-ascii?Q?E7+tOwmrgQBtCtex7XVg+nO0n0nUizwGOgYxftM4mVB+w+WR68ZeH81dmJ4P?=
 =?us-ascii?Q?CRaYto+vSP2JIuxwjafqoX8cA19Th6BoWvzl2OD8v73LG1aZ8iTcCheHzVs1?=
 =?us-ascii?Q?4MlYAzyYOci7g+0ln+we4QCPkZ6Si9vBUa8xg/OyZ6MHrsWfE0Kow6A8iJK9?=
 =?us-ascii?Q?kk85PQWbyc2RnW/VX0zIh2eCqzHMvyE5/lCb01zJ+k1LwgSLrkpyd/wTITYF?=
 =?us-ascii?Q?dFTqRF10OeW3twBFHBJEeDB9dUqNMbLjBdmJ3/Ji6vA7Q1bQs6qej0OPNfKT?=
 =?us-ascii?Q?YvU0R7SkJZNeMFTOUPzdpH/ZRjcyF+xI+wp23lyfH6uNnZ77avYEaYQ7OdrJ?=
 =?us-ascii?Q?ta/sXLMLAJA/3IWi1Wyd16Zp44553qEVazzkY/6uNKC6gucVpcSm/KNyHYS1?=
 =?us-ascii?Q?c9BagIO5wZp9tVDEEc2E7TbUeE50Ab0ZMdqrqwzNPC9/qGMwX/bech3b1/Q4?=
 =?us-ascii?Q?dAs7OcGLItv/d0OO2Z4kFvs4p2eqjGvdDWygHFPOvATmfYnppCaa8/ypG0B6?=
 =?us-ascii?Q?npF3pO/SVSE9FUQVG7yUjkhLrJ5xN7x6ByzoGafk4LE20svmaTs9SM5X+pX2?=
 =?us-ascii?Q?JMdOGbdGNWOTAAlVY1xIBKAqMjV0mCbNzs7IdzSCptKKqI8QmVovRRaIOztl?=
 =?us-ascii?Q?/9meas2tSNS29us=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:36:43.1950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177102d8-5815-476f-9277-08dd449ada2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224

From: Jianbo Liu <jianbol@nvidia.com>

The mdev is calculated directly from mlx5_clock, as it's one of the
fields in mlx5_core_dev. Move to a function so it can be easily
changed in next patch.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 35 ++++++++++---------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index cc0a491bf617..b2c88050ba36 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -77,6 +77,11 @@ enum {
 	MLX5_MTUTC_OPERATION_ADJUST_TIME_EXTENDED_MAX = 200000,
 };
 
+static struct mlx5_core_dev *mlx5_clock_mdev_get(struct mlx5_clock *clock)
+{
+	return container_of(clock, struct mlx5_core_dev, clock);
+}
+
 static bool mlx5_real_time_mode(struct mlx5_core_dev *mdev)
 {
 	return (mlx5_is_real_time_rq(mdev) || mlx5_is_real_time_sq(mdev));
@@ -131,7 +136,7 @@ static s32 mlx5_ptp_getmaxphase(struct ptp_clock_info *ptp)
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
 	struct mlx5_core_dev *mdev;
 
-	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	mdev = mlx5_clock_mdev_get(clock);
 
 	return mlx5_clock_getmaxphase(mdev);
 }
@@ -226,7 +231,7 @@ static int mlx5_ptp_getcrosststamp(struct ptp_clock_info *ptp,
 	struct system_time_snapshot history_begin = {0};
 	struct mlx5_core_dev *mdev;
 
-	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	mdev = mlx5_clock_mdev_get(clock);
 
 	if (!mlx5_is_ptm_source_time_available(mdev))
 		return -EBUSY;
@@ -268,8 +273,7 @@ static u64 read_internal_timer(const struct cyclecounter *cc)
 {
 	struct mlx5_timer *timer = container_of(cc, struct mlx5_timer, cycles);
 	struct mlx5_clock *clock = container_of(timer, struct mlx5_clock, timer);
-	struct mlx5_core_dev *mdev = container_of(clock, struct mlx5_core_dev,
-						  clock);
+	struct mlx5_core_dev *mdev = mlx5_clock_mdev_get(clock);
 
 	return mlx5_read_time(mdev, NULL, false) & cc->mask;
 }
@@ -304,8 +308,7 @@ static void mlx5_pps_out(struct work_struct *work)
 						 out_work);
 	struct mlx5_clock *clock = container_of(pps_info, struct mlx5_clock,
 						pps_info);
-	struct mlx5_core_dev *mdev = container_of(clock, struct mlx5_core_dev,
-						  clock);
+	struct mlx5_core_dev *mdev = mlx5_clock_mdev_get(clock);
 	u32 in[MLX5_ST_SZ_DW(mtpps_reg)] = {0};
 	unsigned long flags;
 	int i;
@@ -335,7 +338,7 @@ static long mlx5_timestamp_overflow(struct ptp_clock_info *ptp_info)
 	unsigned long flags;
 
 	clock = container_of(ptp_info, struct mlx5_clock, ptp_info);
-	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	mdev = mlx5_clock_mdev_get(clock);
 	timer = &clock->timer;
 
 	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
@@ -392,7 +395,7 @@ static int mlx5_ptp_settime(struct ptp_clock_info *ptp, const struct timespec64
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
 	struct mlx5_core_dev *mdev;
 
-	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	mdev = mlx5_clock_mdev_get(clock);
 
 	return  mlx5_clock_settime(mdev, clock, ts);
 }
@@ -416,7 +419,7 @@ static int mlx5_ptp_gettimex(struct ptp_clock_info *ptp, struct timespec64 *ts,
 	struct mlx5_core_dev *mdev;
 	u64 cycles, ns;
 
-	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	mdev = mlx5_clock_mdev_get(clock);
 	if (mlx5_real_time_mode(mdev)) {
 		*ts = mlx5_ptp_gettimex_real_time(mdev, sts);
 		goto out;
@@ -457,7 +460,7 @@ static int mlx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	struct mlx5_core_dev *mdev;
 	unsigned long flags;
 
-	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	mdev = mlx5_clock_mdev_get(clock);
 
 	if (mlx5_modify_mtutc_allowed(mdev)) {
 		int err = mlx5_ptp_adjtime_real_time(mdev, delta);
@@ -479,7 +482,7 @@ static int mlx5_ptp_adjphase(struct ptp_clock_info *ptp, s32 delta)
 	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
 	struct mlx5_core_dev *mdev;
 
-	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	mdev = mlx5_clock_mdev_get(clock);
 
 	return mlx5_ptp_adjtime_real_time(mdev, delta);
 }
@@ -512,7 +515,7 @@ static int mlx5_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	unsigned long flags;
 	u32 mult;
 
-	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	mdev = mlx5_clock_mdev_get(clock);
 
 	if (mlx5_modify_mtutc_allowed(mdev)) {
 		int err = mlx5_ptp_freq_adj_real_time(mdev, scaled_ppm);
@@ -539,8 +542,7 @@ static int mlx5_extts_configure(struct ptp_clock_info *ptp,
 {
 	struct mlx5_clock *clock =
 			container_of(ptp, struct mlx5_clock, ptp_info);
-	struct mlx5_core_dev *mdev =
-			container_of(clock, struct mlx5_core_dev, clock);
+	struct mlx5_core_dev *mdev = mlx5_clock_mdev_get(clock);
 	u32 in[MLX5_ST_SZ_DW(mtpps_reg)] = {0};
 	u32 field_select = 0;
 	u8 pin_mode = 0;
@@ -724,8 +726,7 @@ static int mlx5_perout_configure(struct ptp_clock_info *ptp,
 {
 	struct mlx5_clock *clock =
 			container_of(ptp, struct mlx5_clock, ptp_info);
-	struct mlx5_core_dev *mdev =
-			container_of(clock, struct mlx5_core_dev, clock);
+	struct mlx5_core_dev *mdev = mlx5_clock_mdev_get(clock);
 	bool rt_mode = mlx5_real_time_mode(mdev);
 	u32 in[MLX5_ST_SZ_DW(mtpps_reg)] = {0};
 	u32 out_pulse_duration_ns = 0;
@@ -987,7 +988,7 @@ static int mlx5_pps_event(struct notifier_block *nb,
 	unsigned long flags;
 	u64 ns;
 
-	mdev = container_of(clock, struct mlx5_core_dev, clock);
+	mdev = mlx5_clock_mdev_get(clock);
 
 	switch (clock->ptp_info.pin_config[pin].func) {
 	case PTP_PF_EXTTS:
-- 
2.45.0


