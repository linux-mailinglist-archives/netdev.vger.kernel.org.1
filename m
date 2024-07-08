Return-Path: <netdev+bounces-109764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90AC929DE1
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C9FEB229F1
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32EF34CD8;
	Mon,  8 Jul 2024 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bazlgm56"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F439AFD
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425733; cv=fail; b=l8yLNJM6DB525jEblsFInq9rJ3Dzz/aD2PJGpKi3cEKWHQQjXwXi6FVkjLv3+JlvApvpbfqip5I/fVtxIuCJ1n2yCbbMe6JgX1K6te6emYgdSU43apW5Jr1LGc4o87tA5bxrfkpvTZZhGenDsYAmpvNgEWjoL/yXE9GVqnPjtgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425733; c=relaxed/simple;
	bh=hnKiD60GwOT8EA4a3YY3nLoFelp5jDMB+cKNL87IyLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCRJzu5WTFN8/XtrVTj531nnBZHqQ7YA+PBrkQKFvL7Hz6ZPpeW8WK0jlTGQ7xfb4UkHYMdhBLZ0xG27yFqwJ8rQ9fNiwOk1JPSWTcqC9BFYC8JEVnnqj9AIypHFbshY2yGARrCKgPEZ+GW/nrNeh9lF/bkyJY270JooKIDlyG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bazlgm56; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6XTR5xOHJGZXZSx+yIQP6PqfwwJJ5uSVCVQbjqwiwR7+nLB4LHZlJ8TwTKw3OLiA8Vl3MqpPefzDVehgDhfaZ3TwtgUgFfiCSz/cSPPCNOUlr0pVJRaKemEiCf9GYNrLYLMRQ/Hrzf9YYyWJcNhhlcL4AuLNnRI3dRulC4GflB2gKQjfen1PXb3997wYHL5O1tPcdm9ZNxLknapGdcICa6FDTxt6wtzWFhzkNQwf53ZA2CKVH5+6N6bpyuWmQOyMwCH4fYlXbcI6f82BKQLRWvJRrnUU8fBQsVaXlM8EnxfEvFiQ46U+D0jw5AJOL/XY/OrJqKipvfVRD0loFHj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUdvmT2JWsdOqCl57mibw+huo3A1EYojMJyr4V96Wsc=;
 b=noRqmDrUK0RzwfKBk9SlKqbwRkL66Qo2l/LpAOKX1QZTQzc3HaK0xIVmod9WYli2nTceTSpCKO6B3s53ojpMQMZPgsIxent0llFmbEJGw9qbcRM5nlJqky3XrAJrmavDzxGXVS8F740DcmPJoOtfGIj1+Liw9aMZSFrZbYFn9Xhm5rRzmDw/78KK2Dpkgt3dW+1Zzl/IxtYoNjXRhVi1d3R9g3WbHkI0ZsVBwrLyO8KO7NQxwpxwZdoksZLhsRlFIj5CJJ/cm3ndv3aOL1jJfGwJFsKBuUh1qOZHPVXjijl+ZJo5NDuZJGktXPFPYrp3APoB66Hn1GfihCbu2QAw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUdvmT2JWsdOqCl57mibw+huo3A1EYojMJyr4V96Wsc=;
 b=bazlgm56xTaJRhGuEPUYHiqoIBOTCc/ByPBmxqnUq5pYsTzy0XGe3JZ4BNam+OV/nCwbZefVcxY6oHHvSYHQLaBbAYbCeA+ceI25osqyphOzS2dJDA8bDhFjie8x89/gq/QQrvwzw9mmDfno14NGKMbNtIrwIzEoJNQK+AAyi1+YbrsyZPOTZUcutk+Q9DeByZLE2b8Ry3GmNM8pJzG+7l0axS24Tqlc9hDBwAriMH106eYzOGAVdtjAMqRAYgUPGPbxzwp3dn8DomZQF6yJzBHLGg6F/qF/Asr/1jZ4E/8IdDxPxWXhLHPofnhUwo0F0KV8h7NNDJRdJPbgnhnusw==
Received: from PH7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::7)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:02:07 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::e4) by PH7P222CA0016.outlook.office365.com
 (2603:10b6:510:33a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 08:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:02:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 8 Jul
 2024 01:01:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 07/10] net/mlx5: Implement PTM cross timestamping support
Date: Mon, 8 Jul 2024 11:00:22 +0300
Message-ID: <20240708080025.1593555-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240708080025.1593555-1-tariqt@nvidia.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 702db8ae-62b7-437f-8467-08dc9f24432c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aQRsG6KUskpanA4v+Fs0s5LjSmdBbhI4Rl4ZWyzpRsbtsUNTWERSATA0IO+p?=
 =?us-ascii?Q?gmdaVP2KdpR115F9vYm5yeGlx3xAHA/45Wd/vWUh356HHyBq47mKOOD0cekO?=
 =?us-ascii?Q?6sVwxjZrDm6wNZMFYWg9Euv7hzDvH8xp7h1W15omn48wHHZGq8ywKHDLJEAb?=
 =?us-ascii?Q?aYcpaFZTeyrCVX9C4ZotidDP/NDh9KshL9ysnEsJoeGKk8l/sg4Z/Bioj9U/?=
 =?us-ascii?Q?95TOan0OJqzmnRwtFQMjv+/gdDUYsDk0IQjhyDoXMG5orA/0gge+IHXLRB+C?=
 =?us-ascii?Q?HKvRzZW4IOLkpGjXujDxyolBNp+ORia0KhCir+nlUhnr7KGN5b0NU/b4JhpG?=
 =?us-ascii?Q?d+zDmeulZ46Wpkof/bSsWH/UhrlPZ7cF68JvLNFde7auAjP7j3+nOhqc7UTG?=
 =?us-ascii?Q?bWsdDbB+eSRyIMsvZApKqiQdAORKeK4PCszMU4NRjT1c/ZPVQFRsKwiXC1aL?=
 =?us-ascii?Q?wrHBvHf9E8NSvexXnzVDLUsL0WW7sBPEYbPYZhv0M1wnBWX/JaITr3sUAzAu?=
 =?us-ascii?Q?dqZAc0hbj4KQjkihTZWm8oC8CYaZNJ+qVoGB+bDO7c45V53+eCybD+cX9B2M?=
 =?us-ascii?Q?mexiEWwChho7GlfFpKXXXOGqTsnU9F5lNfaORpp5z1DQpz6sDsZA3mIrX3l4?=
 =?us-ascii?Q?07HE640RAcX7CD+iRdVgVcfN363++DIJSNfc9JxN8sfCvvgvvnOLL6MNa8Nt?=
 =?us-ascii?Q?NrL0Oa5SMhApjUIeqCSJZdAtqm9DbiaULvXgGcCQMLRdP0m21UkkvZv/x1ga?=
 =?us-ascii?Q?8ThMuD09PuBTWbMUz1D6Yuzta4Jn4yX7/0h7Gjmch+LrSQO9WHkPv6K6X6zK?=
 =?us-ascii?Q?I3qgzRfP80ou1bJzjDCYjHRvEJHNfUb6y4WqRdjJtcvGdGENzvyBx5kIHB6V?=
 =?us-ascii?Q?2SxQ5pHMQT0d47qS463dNl56Mv70wodmkvAuCU/UJIVyj+bQAoM3lp0SHaNk?=
 =?us-ascii?Q?bEL1f9EsEjlGg8LlN2Ovs4kiL2B0TzvliPCulnlj/7cH+SKi2PZV1I7Wqwoh?=
 =?us-ascii?Q?kHLZeuKGrDtvuuVD23/fzfBHwMyM7oEsDFjVaDFM1U3Eb3MdfSgieJde2inO?=
 =?us-ascii?Q?1cbtWGZLGlMnQWlEND/2qvlQxAQICN8d90LlOgZNnhL9gBqLWyc92Kzr+qc9?=
 =?us-ascii?Q?+dAZ3LBtNs927vHvS02YqisuYRqfMu/cXkYc1WU4KfH6z9AcfvM8EvvNuaYY?=
 =?us-ascii?Q?AXRyRi6nt5nXR7zQR5GH2Ognvrz9sBwHGYe4pQzVHa/8YXQsuQ97pgz/6P+O?=
 =?us-ascii?Q?GVsWe+enjBr2WGlSdmYSbJSsn7CVUUpBU2ZnBl7RRBfysk9pGkBY4TZ5K2T6?=
 =?us-ascii?Q?9ZyyP1jIDv+QjCcLJ977RkVVbJIk6buVeThCSKFwwmi3JgOgijx/8dSmeP8s?=
 =?us-ascii?Q?hKY/ZgMUQiMnopyVkuft/2RtPzk8iH1g0LNhuHFxOjZVYFCbXzYWoGuVUIAr?=
 =?us-ascii?Q?cFd/maJ9dfAP//49frQ6WojM9/O9BaN0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:02:07.3929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 702db8ae-62b7-437f-8467-08dc9f24432c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Expose Precision Time Measurement support through related PTP ioctl.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Co-developed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 0361741632a6..5e7bd1ce54c5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -38,6 +38,11 @@
 #include "lib/eq.h"
 #include "en.h"
 #include "clock.h"
+#ifdef CONFIG_X86
+#include <asm/tsc.h>
+#include <linux/timekeeping.h>
+#include <linux/cpufeature.h>
+#endif /* CONFIG_X86 */
 
 enum {
 	MLX5_PIN_MODE_IN		= 0x0,
@@ -148,6 +153,83 @@ static int mlx5_set_mtutc(struct mlx5_core_dev *dev, u32 *mtutc, u32 size)
 				    MLX5_REG_MTUTC, 0, 1);
 }
 
+#ifdef CONFIG_X86
+static bool mlx5_is_ptm_source_time_available(struct mlx5_core_dev *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(mtptm_reg)] = {0};
+	u32 in[MLX5_ST_SZ_DW(mtptm_reg)] = {0};
+	int err;
+
+	if (!MLX5_CAP_MCAM_REG3(dev, mtptm))
+		return false;
+
+	err = mlx5_core_access_reg(dev, in, sizeof(in), out, sizeof(out), MLX5_REG_MTPTM,
+				   0, 0);
+	if (err)
+		return false;
+
+	return !!MLX5_GET(mtptm_reg, out, psta);
+}
+
+static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
+				     struct system_counterval_t *sys_counterval,
+				     void *ctx)
+{
+	u32 out[MLX5_ST_SZ_DW(mtctr_reg)] = {0};
+	u32 in[MLX5_ST_SZ_DW(mtctr_reg)] = {0};
+	struct mlx5_core_dev *mdev = ctx;
+	bool real_time_mode;
+	u64 host, device;
+	int err;
+
+	real_time_mode = mlx5_real_time_mode(mdev);
+
+	MLX5_SET(mtctr_reg, in, first_clock_timestamp_request,
+		 MLX5_MTCTR_REQUEST_PTM_ROOT_CLOCK);
+	MLX5_SET(mtctr_reg, in, second_clock_timestamp_request,
+		 real_time_mode ? MLX5_MTCTR_REQUEST_REAL_TIME_CLOCK :
+		 MLX5_MTCTR_REQUEST_FREE_RUNNING_COUNTER);
+
+	err = mlx5_core_access_reg(mdev, in, sizeof(in), out, sizeof(out), MLX5_REG_MTCTR,
+				   0, 0);
+	if (err)
+		return err;
+
+	if (!MLX5_GET(mtctr_reg, out, first_clock_valid) ||
+	    !MLX5_GET(mtctr_reg, out, second_clock_valid))
+		return -EINVAL;
+
+	host = MLX5_GET64(mtctr_reg, out, first_clock_timestamp);
+	*sys_counterval = convert_art_ns_to_tsc(host);
+
+	device = MLX5_GET64(mtctr_reg, out, second_clock_timestamp);
+	if (real_time_mode)
+		*device_time = ns_to_ktime(REAL_TIME_TO_NS(device >> 32, device & U32_MAX));
+	else
+		*device_time = mlx5_timecounter_cyc2time(&mdev->clock, device);
+
+	return 0;
+}
+
+static int mlx5_ptp_getcrosststamp(struct ptp_clock_info *ptp,
+				   struct system_device_crosststamp *cts)
+{
+	struct mlx5_clock *clock = container_of(ptp, struct mlx5_clock, ptp_info);
+	struct system_time_snapshot history_begin = {0};
+	struct mlx5_core_dev *mdev;
+
+	mdev = container_of(clock, struct mlx5_core_dev, clock);
+
+	if (!mlx5_is_ptm_source_time_available(mdev))
+		return -EBUSY;
+
+	ktime_get_snapshot(&history_begin);
+
+	return get_device_system_crosststamp(mlx5_mtctr_syncdevicetime, mdev,
+					     &history_begin, cts);
+}
+#endif /* CONFIG_X86 */
+
 static u64 mlx5_read_time(struct mlx5_core_dev *dev,
 			  struct ptp_system_timestamp *sts,
 			  bool real_time)
@@ -1034,6 +1116,12 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 	if (MLX5_CAP_MCAM_REG(mdev, mtutc))
 		mlx5_init_timer_max_freq_adjustment(mdev);
 
+#ifdef CONFIG_X86
+	if (MLX5_CAP_MCAM_REG3(mdev, mtptm) &&
+	    MLX5_CAP_MCAM_REG3(mdev, mtctr) && boot_cpu_has(X86_FEATURE_ART))
+		clock->ptp_info.getcrosststamp = mlx5_ptp_getcrosststamp;
+#endif /* CONFIG_X86 */
+
 	mlx5_timecounter_init(mdev);
 	mlx5_init_clock_info(mdev);
 	mlx5_init_overflow_period(clock);
-- 
2.44.0


