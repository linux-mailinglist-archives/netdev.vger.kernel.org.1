Return-Path: <netdev+bounces-216296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD34B32E6B
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9D33AE8E2
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DA026A09B;
	Sun, 24 Aug 2025 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="agZCl5LN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9628325A337;
	Sun, 24 Aug 2025 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756025096; cv=fail; b=gcFsUeyFR7T2L8V5HHhjA3jkNqC0yKKdNlJXbzklXl9IirPsKWFv05qxfmB/5p73wxJiYsAA6Y0rrrvT2kiEdDAtOgbN7TTP6tbNpDcLK4vNEVNMyI/xjV264HjO1kIb91mrxK3Zem/FZQ8sSZQefJWwnLu1URfQG457Jy/3WXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756025096; c=relaxed/simple;
	bh=fsZuoY3JiOgc70G68aOUfCs9XZC1kzdyDUu5vUb8Oto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnTKm9gm9db1O1rgWJ7jCALyMqTZ8B1Kuu+52fRSX62Dwx1Q55U/m2iuse4zg32+HYPNXHeNbX1rZkR7O01SwJ4RkVJX/sNkZEQF/qjhogvlocLxE9DGjAgAft4cdAaa33N+aP+nm3ughRTVsvKl/mpuS4yqwP6OIxhtJwbWEa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=agZCl5LN; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMmAkQGCXbNelny7P7t641al9lyDQoebPlkXHwqXGwUiQShU710uN0a3jkYpzx6ti/Y6FVh1zIvG+W8MQkNYokfQxHB7pL3CdwTM4ipjKUUV6T2+qNkZnzoty+9PrtNYn9uHGMA52kq3w8XHE/sDhDOfaGosNzGlXWqLSfiWgoNb+nDCa6mPMHkPfXPD2lBq9xHbiAnvqkPTfCxBYNNTeuoBV0b4GgRgC2U/1ldeMLoktvGCPdLV2XhAfIpLc6BDn8JmCkhy2PRzCBQH7ix6tvW5ipKk7CzAqWk+W/V9nYO7bQ7HYYTgkCB44y1/nVqBkZFyd8H9m9kWEjckYnhuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mycVIQ5DSrEz1588wsnAMB8LCFlQWu8ItT9fUmZTZro=;
 b=IixhrFSNXm0MOy0JcTkbrzELhfwc1JgYxME0EC9X7m09/XrpIBc2NDbw49/+IF6Xh8b8v0cOVnFl/OIvCE9CkPmjO8GrZctvXkxjB7LBGu0WFwb/RbGnh+OzfX8PYOQZ2Sc8xoI4tGcLJR2Mw5M1H1XPzNz6ca8PaQG7s01F9pfahmWrnE3B4Z0/7VOxwW5T30eogfjmdhEacRodCvuHMWVS79lMTxyFITsvajw32iWNPeJIUrqJ8tG7LG/6Q8Texj1tJ1XVGKeXXZEqJe6w6oi8R+ykCh9T/QWA3goBei7ivezW6Ch6sOHMjGh+kf1/2AC0/VzH35Ga/IU0UXOyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mycVIQ5DSrEz1588wsnAMB8LCFlQWu8ItT9fUmZTZro=;
 b=agZCl5LNI5dXb+IYcenc0divfc9tCMamtXJygLIIWkWnipDw3gLtrAJjF7Wa7PqUy7MbHw6kRqqzggcMjyPo5gIaMS9JNCW+at7YRBpTj6SLOTlK3x4NJJe0dTHKYcwY3XxQZEr11+TVvfqeDK7vdxQjcbL8U9e7VA8XB9LCWCQEhi9vvWLlo91e2Pc5gcG17SPZ2XhU28h70kY9/rlExfes3g/IeLFv5OIRv7uz7Wb4qqyvwU9/fGvpGtuEDP+dnPtxBxj5gLRprSXUAejFFvLUGTUsZhZlGSCL/UTYOE1xOuIc4LfBZJu1Rww9Eb1Ygqp6mAZWFy5K4KfcVsPz4g==
Received: from BN1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:408:e2::7)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 08:44:50 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::37) by BN1PR13CA0002.outlook.office365.com
 (2603:10b6:408:e2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Sun,
 24 Aug 2025 08:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:44:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:44:31 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:44:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:44:27 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V4 5/5] net/mlx5e: Set default burst period for TX and RX reporters
Date: Sun, 24 Aug 2025 11:43:54 +0300
Message-ID: <20250824084354.533182-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824084354.533182-1-mbloch@nvidia.com>
References: <20250824084354.533182-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: e666c922-b1d2-4d21-ed1b-08dde2ea7cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HJvddYkd9QVN5LwhRWqlGVPc2X84ylrLcwyXEbOTwE2tpe+hRNFNs9VCztVl?=
 =?us-ascii?Q?I6qMCZkuNEQCgcY/oT5vbQ2bPtTMYSuO3cRioWnUcUBseIdoa0l867Al/tYN?=
 =?us-ascii?Q?9oHVeevv1j5TKd3kbnddeCcFYp7xUgWXyxMHzR93H/Z3fmOXaM7vsAfH3Jxi?=
 =?us-ascii?Q?rxkg6fGZ6xHm+SpAGNqgQoefOzenzw4i9PqTFGBOQ3wxIY7Y+Rv+LhAYwR7y?=
 =?us-ascii?Q?lLE0q7/t68uu/DXEL6Afv8nLaZwrY5NLZa/Qi72sdLXjqe9Ev3d1yny4ItKa?=
 =?us-ascii?Q?zCZ69++lGuYepohcexI0r0JfQze5pYLTn5O/keOLlk07TdNEUj5i/z7ZNk4+?=
 =?us-ascii?Q?60yBPZDqD+NPAGwLYO74L3hWzOqflkcRzLMW4p/7Fc0EN3CBz4iayqLiAJ85?=
 =?us-ascii?Q?5nL7cvdBxTMkLT+Gyup1i+NjvSu2xQd8q+66a78YuvIbO7XtonfgvfV+zNMo?=
 =?us-ascii?Q?3rTQ6iDDBIYCecv4XUk/WfErUrMjG+1IUcV1om+bOdhvv7XODEKuc6IbvQjr?=
 =?us-ascii?Q?Fns7VfRjX5YXpSGYfBicdT8Y5t8w8FwsBxTp7J9eAOemayDEvggkX5wZ8x1d?=
 =?us-ascii?Q?mvi8MbZLT7M3ykQIZA8TXXKvVD2B9znM0K5ufvtpuFE5a5r95KBTc0ElLYKD?=
 =?us-ascii?Q?5/OFQUlx2IshU5nFLnqKYrcIK7AMeMnOdP4hN2BXwBgXPoAv5tVzmQaicuMe?=
 =?us-ascii?Q?dRMwZKTXUPildRKcbbY+1YNPKn8fw4W1B8DqwCZuLWJEIkXqKnKvNPnliqAQ?=
 =?us-ascii?Q?0vLeVsV1d6ddZ0nawl3Qz88AvcRGU2MmQfH2QgdTzE6NN2iXT3VHzjn3uXEw?=
 =?us-ascii?Q?PqBc/WNvA42YgXoGtx6ptH8k9c1ScrtF+T9uEvtpLvMkF3jGz3ogt98MX9gv?=
 =?us-ascii?Q?6yyfrh4YQx+eQOG1hHR9NVTQXjJyaf6USymCR5fYsgw6V+gm1DiU81LjVl3/?=
 =?us-ascii?Q?L2uWiP8GAq3LKRlvN4MgPxA7FnmsDN2wnFVdjPLTr5OByoCIhoJtKQ4QCtnP?=
 =?us-ascii?Q?Gjkn/Tvw1u/QFBs7hirw1Z8anDjVoF7pYnbjCmGiBfmU8h0RHwvLuTiemStc?=
 =?us-ascii?Q?yJ5yZjIvv2OD6Fugk9IeglHWiu6KGGD8pK01n7ZTkuYARabquHwu5CJZYCX6?=
 =?us-ascii?Q?yNsk84XyD3io6tcsXBVBjpRkWekHaPOzw7kkHb1EFHBWdUYs4yJ3JjgnvrRV?=
 =?us-ascii?Q?TEfRL7nUwP9dhjSfkfI/mzUugyVJW/QOJAcf66Ez6zj69CMI1IYo+4k5IA6u?=
 =?us-ascii?Q?hb5xOesiPcj8vy7tPsKe3DlF/JJO4pzTnvHMXqae1s+uWh63Y9Kp2Ssy3UAC?=
 =?us-ascii?Q?xKhNyF8LKkptVckNPrRdOj4ZMXLwHkdPxv1xi0y0/mYwUjTt8zX6X3GOWmWB?=
 =?us-ascii?Q?xxAKJSFaRNQShQ8HphKO0jFVGDnDTzkeX++kG8xeevqVsZxqTM+vhBhTk/hq?=
 =?us-ascii?Q?colJSZxOnoza7h/rgjIqD1cM6GqBdvJluc9PGE9aHrT0sftfzoVCORrXvxWa?=
 =?us-ascii?Q?E4RvwosB4qaSEbtabMFjErEOxvheIH6gsycc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:44:49.7574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e666c922-b1d2-4d21-ed1b-08dde2ea7cc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304

From: Shahar Shitrit <shshitrit@nvidia.com>

System errors can sometimes cause multiple errors to be reported
to the TX reporter at the same time. For instance, lost interrupts
may cause several SQs to time out simultaneously. When dev_watchdog
notifies the driver for that, it iterates over all SQs to trigger
recovery for the timed-out ones, via TX health reporter.
However, grace period allows only one recovery at a time, so only
the first SQ recovers while others remain blocked. Since no further
recoveries are allowed during the grace period, subsequent errors
cause the reporter to enter an ERROR state, requiring manual
intervention.

To address this, set the TX reporter's default burst period
to 0.5 second. This allows the reporter to detect and handle all
timed-out SQs within this window before initiating the grace period.

To account for the possibility of a similar issue in the RX reporter,
its default burst period is also configured.

Additionally, while here, align the TX definition prefix with the RX,
as these are used only in EN driver.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 1b9ea72abc5a..eb1cace5910c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -652,6 +652,7 @@ void mlx5e_reporter_icosq_resume_recovery(struct mlx5e_channel *c)
 }
 
 #define MLX5E_REPORTER_RX_GRACEFUL_PERIOD 500
+#define MLX5E_REPORTER_RX_BURST_PERIOD 500
 
 static const struct devlink_health_reporter_ops mlx5_rx_reporter_ops = {
 	.name = "rx",
@@ -659,6 +660,7 @@ static const struct devlink_health_reporter_ops mlx5_rx_reporter_ops = {
 	.diagnose = mlx5e_rx_reporter_diagnose,
 	.dump = mlx5e_rx_reporter_dump,
 	.default_graceful_period = MLX5E_REPORTER_RX_GRACEFUL_PERIOD,
+	.default_burst_period = MLX5E_REPORTER_RX_BURST_PERIOD,
 };
 
 void mlx5e_reporter_rx_create(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 7a4a77f6fe6a..5a4fe8403a21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -539,14 +539,16 @@ void mlx5e_reporter_tx_ptpsq_unhealthy(struct mlx5e_ptpsq *ptpsq)
 	mlx5e_health_report(priv, priv->tx_reporter, err_str, &err_ctx);
 }
 
-#define MLX5_REPORTER_TX_GRACEFUL_PERIOD 500
+#define MLX5E_REPORTER_TX_GRACEFUL_PERIOD 500
+#define MLX5E_REPORTER_TX_BURST_PERIOD 500
 
 static const struct devlink_health_reporter_ops mlx5_tx_reporter_ops = {
 		.name = "tx",
 		.recover = mlx5e_tx_reporter_recover,
 		.diagnose = mlx5e_tx_reporter_diagnose,
 		.dump = mlx5e_tx_reporter_dump,
-		.default_graceful_period = MLX5_REPORTER_TX_GRACEFUL_PERIOD,
+		.default_graceful_period = MLX5E_REPORTER_TX_GRACEFUL_PERIOD,
+		.default_burst_period = MLX5E_REPORTER_TX_BURST_PERIOD,
 };
 
 void mlx5e_reporter_tx_create(struct mlx5e_priv *priv)
-- 
2.34.1


