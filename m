Return-Path: <netdev+bounces-109371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C21928293
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF8D1F21B2B
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66E1144D22;
	Fri,  5 Jul 2024 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H96/gWUz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099231448D3
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163758; cv=fail; b=rLeUYJ93wUhwNS7XHVl46h0QwmeIdB44i3k0AKxgoFUyGMn1LUoeXvoc7nKahcr2Jo7I29wWhl7YbZfA/v9ccvCPTlAnUu8GTwbtSRdc2JToONUPaG3PV0I0FsiE+nJjDqWWikPe7rPqr0awj74LfoN1rvgVqq7CN35tMCShEic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163758; c=relaxed/simple;
	bh=OB+BVukxK+YLc0FcI0LLLEpO9ASly19wQuSwV0fIq7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEUNckBQCbxh9VEK3nPM7FwUB3YHUrcvunou02HjTX4DA2TYT2JstETt5x1bujdncdzbv4AFQDWp6/KVS9FFtIVC8l2iHD227wGHuH/zGAvvhaqbEWAxAyaHtYm0K8nIAN6V9Hd55bQ6Lpx/1WYbGjYhBAv5Ye4vnmO5p0Zr//w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H96/gWUz; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0083V8yr5slArh67UgyIZveQkqy+XBpQGEZsWGOrzvygUmS6FS0bo5QAqlKcEmvC2/IPcA8NiLA95d44smbwpOmMO4wHygTjjtPFZAgLyraqwivyL2kndUyRR2PaUAJ/y9+evH+Fpo3Q+pN1bUovTjIVg77m91AajsdmtfaedeS90rGmc2Xig0bF6VNsBMgR1aatRQhl3uZzGdljSv2adHx75UytqD1YdUxlgqq7UuxpWwSKDvZFIasIGKtjSxFatKrDdpijFufSPFGD6GxkZ3kFKUIas/KrtWMT+Jr5wKDRki+01SW1/Xn3Wor9Wwzbm5s7DVI8gtNY/aaX7EwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rn/Q0rTdMzek4mM/QNGSMmL7TM1jTDQ7tHLAi8ycdhY=;
 b=O9WbTdEoiEY0DkAzs1gSdtXIIJptjduNdLOiFtJHvW0z0hMN7UIy1raRrmWzem1mUhJRrdfY6r98moKIxaPX642FzDgb2QGgX0KAagCBmyrQ+aZXeZKMIcO7/CGc/prANqnmDgXmq/G8e0haOgb7A0alNsVYzTFfBrFju1sr/PAl08tdQ7yPY+vQwCsJwhsfz1TVAA7CQLEdJpP29FidWosKRtEfaRA+jfBrElri6S+AJWV7Ok81LFK4ic5XNuczxts7nMW3kzBw4FPBkybfoAn01IJzvFt2/eELFmJt7Q9zq+JnjUHOfvvO8L1aj/M8wkIfUTH8xUYjqvByoGyT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn/Q0rTdMzek4mM/QNGSMmL7TM1jTDQ7tHLAi8ycdhY=;
 b=H96/gWUzn+HKjYQ2yWJNOXkOdQLDk7BtQzvgUomKQ81LRLr9x7WVGymFwBLppHkcNmed0aD0UkI1cbEpU1f7XCVg40BQshn+PqCpxsSh8ATZ9DR76bB4ta+80vsflmTcIuit8GMA2P++tyvgLYSDd6pox446ny+/u/EYXRxwvH41JDn7rH/58eNEaV5zqZ18zOui4LAd7vPVBQQQ1pXnnQlq1wRG6xN6gMMSOru41EiWGP+NZ64HIY5se99adzX8vE5i2g0XSITkiSm45ZKrjpJ8a0pWssJdTezaSlsFoPzx5CCWMOrwG1ZbamvOOzS+jRifOyEfrEbBl6aD95y2Vg==
Received: from PH7PR17CA0048.namprd17.prod.outlook.com (2603:10b6:510:323::11)
 by PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Fri, 5 Jul
 2024 07:15:53 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::5a) by PH7PR17CA0048.outlook.office365.com
 (2603:10b6:510:323::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Fri, 5 Jul 2024 07:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Fri, 5 Jul 2024 07:15:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 5 Jul
 2024 00:15:30 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 07/10] net/mlx5: Implement PTM cross timestamping support
Date: Fri, 5 Jul 2024 10:13:54 +0300
Message-ID: <20240705071357.1331313-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240705071357.1331313-1-tariqt@nvidia.com>
References: <20240705071357.1331313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: 5008a377-f9f2-4e87-2674-08dc9cc24dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BJJpMkfDTiiTrPcf9I0qymlK8pmrXU60Wu1qoMG8vVx0w5943CLFSOiLXcQr?=
 =?us-ascii?Q?Po4qYlJoqrqV6lfdNex/xEHSXO/cmV/rPzY04ft7ULLOOMmmxs0cPFM1Ye6A?=
 =?us-ascii?Q?J1vbi3C2rPtxNrACsIG8lYyWomuJYSFanduNs3foVBxQWmOt8JXbqMtCn9We?=
 =?us-ascii?Q?t2MZ0cZCoDjA6OmbY4Ks+gGTf1eJb7ZDIJMZCVAH65qRTXV+v7x2TqqOLHCD?=
 =?us-ascii?Q?m/sNIqudywE0BC1NErD5ddfyYOipaYZqV5q7Uk6qAl+wFasRn2HHH9rGzRpQ?=
 =?us-ascii?Q?VECXEc2hX0KXDXBg5N6ItK9TrgETum0KDF0WH5KJrmo3opBDBlNuxpAP9BLk?=
 =?us-ascii?Q?30Kx9ifjdalo/vthx8zgIoLA0PCW1jc+i03sLHCVkqBGnwVbMvZE5MfsPLfV?=
 =?us-ascii?Q?w4+qpFZxzDPPbY/EMvv7ImOO9jW0Ky4XnGh/zFzH66w7NHJJ4NxiP5+gTpCZ?=
 =?us-ascii?Q?oN54Kelg3hF3RcTWQXvrZfovNH+8eRh6de1TaQ4cXN64TDegQg4WUaVvAO5W?=
 =?us-ascii?Q?ElOLsH6aWKgU4Pe33L3FqajNpbuW3L2fxTJnktKXq/b148h3VJ5RmeG9V8wq?=
 =?us-ascii?Q?t3qG29o4fbT61XHtO2oNLz3IoIn6w1LLeg9qEACT8viI03ynd3VsEJNCvXyb?=
 =?us-ascii?Q?2q0IDNWpA77bBo5ae8HnRXU6Wbn5MCyPMqZzYl0NbHHLIQuVkfMFjS/sJe7Q?=
 =?us-ascii?Q?EBt4OPhYzEtjdfkdfVX4cVkS/rtAHaUn0pSmskOj9refx2LOjt6Vh2XohTLu?=
 =?us-ascii?Q?wcQPvR2nCS+q9hahtymAr3y3VObqZQIEXg9Iz0/hPRiWWlikw+u7GUUZlQJJ?=
 =?us-ascii?Q?AOWCbK1bqMvITRVSbj4+jTzdqKiWld95g6WphmmRx//pRuog6tvGW0G9aXQ7?=
 =?us-ascii?Q?a+lkGAmqPfoYeGLVSvn/PR9ABCKusZIbZ+CbgmVWwu9ImSHZTipUdDlqP2PB?=
 =?us-ascii?Q?tjpML9CVE3GzfAqbQnxEij0N/ycguJIFewriPS6drpUfyKBVxqjADy0FF2op?=
 =?us-ascii?Q?fenz9zFidm75hfXPblQvMiBdGYtK1rrxUyZd2pJrumCthFMH4czhv1Ace5ZS?=
 =?us-ascii?Q?eXtVrIvXmoLyNlFmv10+x3Rkz0EYez7BJWXLb9BOmCx4qqi7nfABD54Yfo+F?=
 =?us-ascii?Q?RDqXS5NkGdG4m3eofxY7NNxTGHJx57Vj2ehx6BGYzVTVy+83SMnOqqTp1Ghn?=
 =?us-ascii?Q?1mHE4qAal340hMZn+TxFWCGOZo2xdv06phRy1R5R//Seyew56LJBi67Fa/pQ?=
 =?us-ascii?Q?aVBc3VwSjNM+kFlSOY6KZxTWBzbU7c6/4KjMwUpI6rpg789dlU+V589bdSjD?=
 =?us-ascii?Q?s8mn3iAaoeWa6aH421BrBZBWIdayY67wLpIqndqrG/bxr6bDLLtcju2iPdl0?=
 =?us-ascii?Q?hLp0+Yri2hH5gn3ZOi9loM3Jc70K+qyxv6PRDG2EIntTdFFdNtVL4nDIN8QP?=
 =?us-ascii?Q?gaaxvwM3ZeFUN3iOcROHHcrdFbzlKEMk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:15:52.2404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5008a377-f9f2-4e87-2674-08dc9cc24dda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Expose Precision Time Measurement support through related PTP ioctl.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Co-developed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 0361741632a6..e023fb323a32 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -30,10 +30,13 @@
  * SOFTWARE.
  */
 
+#include <asm/tsc.h>
 #include <linux/clocksource.h>
+#include <linux/cpufeature.h>
 #include <linux/highmem.h>
 #include <linux/log2.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/timekeeping.h>
 #include <rdma/mlx5-abi.h>
 #include "lib/eq.h"
 #include "en.h"
@@ -148,6 +151,83 @@ static int mlx5_set_mtutc(struct mlx5_core_dev *dev, u32 *mtutc, u32 size)
 				    MLX5_REG_MTUTC, 0, 1);
 }
 
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
+#ifdef CONFIG_X86
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
@@ -1034,6 +1114,12 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
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


