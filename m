Return-Path: <netdev+bounces-162274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9509DA265C6
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCC13A6049
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0344B20FABF;
	Mon,  3 Feb 2025 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GftCTL8n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF520FA9A
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618626; cv=fail; b=FoxyclMtyV/xaqsJe9U+W9nj5PiQeoMF4ujImHHlCo4nQLdiurj7fj3GMGj1OEeZt5HTAdiGaFVy5MDdMBH5qbScC74A6+jBMJhTbjV+igt8X8E1ei0/sulZ3XKHQT5uCSBKl5uQwxVqIEFfQfC6duG8tTZeYSGqTp08gWNFWew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618626; c=relaxed/simple;
	bh=mGItBketN/DmJqOQTxQ0OBfUkDArX25ESkHwYKZkWBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ux22RXVCVYSF0rYSTh6dsDayXHlHcAQ4TNnX5rAxUf8+bFxkx1S0vxzwRf+nhpGsd6t1qYYzY37QoLPdZquLVXvTJtfg/7onMftCxy0QLw4WKevYI43AY1jEBmKeD7yal/bfqrnczXzBArF21qVRQXLpbMwsEJo+2Q/hk+RuVtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GftCTL8n; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UF9kC5oMWi198KwOSxUH8AJvu3/Ps5tb9StUE2i9ECo0jc38zmb+9o2Khr+bKKc3B8U/7BYJsZR+ZpIXe0zvYQfCm81Zmta2awXQOfyM1fcfAJ44rUsD75Ge0I63aN/McqLF8+uRWPQp8KK/eecs5wlpJk+/luAT3l7Tf/5HGe23JuWjFrYHDvuzAPyMlKz762AWdNgE/FNuhO2s/0OWBV6zrynokJHxwqsmfyZRE6KSRBhCNFzn/MG/d1DoRnSkh85ekU37KYlBDre9B6ktx8SUt265xLkBrYjwxxbpxc1QHfHSYNhNhAp2yPkePk6ds/YBzxQg16sdYUWtNCLNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwJ17D6oElbqTInlsSWEpF7k8YIeD2bYA0TDx1oeOFo=;
 b=ekhXG/QKknFTNVxcaBINZNBOLom+xCMtERd9edmSIKew4WbqmyA2QS067rqb/3r+lgbv6RWRdefuOjSOeBt2CSS6mKRqI29BnNEBp6VlFxTEhI25Jcn1p8+NFxSQHu8jkYdt5rCokLe/rA3bOvv3Sl3lGY3FmFQUekiyHD6/MHQJSYnZiVpWkqgpasmT3zgeg0l+9eFr6fBIpxguEr/yWVlxONf3Kn+k7uZwf13+YIh/n842aFdhFzLQ2te+k+j4Wp2oZ0Vo0++naZgyHpH3Gn9ILd4zNVhfUDO2NI2pZcZeYLGshkBfJG/g1dj1CTdnHWwXzDq5Dq6Xb5uUo24zhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwJ17D6oElbqTInlsSWEpF7k8YIeD2bYA0TDx1oeOFo=;
 b=GftCTL8nRhvfLBs8vZy8f9wPGOlXb7nrbk7iIho+zDmrEeVBPBmROSBv8FCa9Iqv0K1PVFiMf/arDjyw4F0HeE6tAC7DjCX8RHKqg17rxvrstqBYoY1IadT4q4eSn1DLbbPTk3adbAwjg/8h6qoqBhIRCLFfq3URA7t42oVoJhFnfj+eBkGDBIdVuQZ3PJtzovTrHyVg7EQW7mn6nQmOAWgRyjWcwujqups33gSwHVtXm7NtetcWWLAkJUN6Drx8oBRcqFlKianuIJsLIYkdwcL9wJsJsmMjCe7DdrbKnIjjVOLOO5Nk3j34PMEwa/XcwbLinBat/QJYL7TECJ7c4Q==
Received: from BYAPR02CA0036.namprd02.prod.outlook.com (2603:10b6:a02:ee::49)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:36:59 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::5a) by BYAPR02CA0036.outlook.office365.com
 (2603:10b6:a02:ee::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Mon,
 3 Feb 2025 21:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:36:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:45 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:41 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 09/15] net/mlx5: Generate PPS IN event on new function for shared clock
Date: Mon, 3 Feb 2025 23:35:10 +0200
Message-ID: <20250203213516.227902-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b87224-d436-4841-8cd4-08dd449ae39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QA5p991JMzc6Le+u6OZZVEo2x/gQWCIQkKlNmsJUa4+mbuIvZLG0kJA+sfnz?=
 =?us-ascii?Q?brMGtP9Wtve5hRCg3bj6x4CM1gWuZ0kqTBFz4YcBSZKDtC/27Rqlu9D49pxV?=
 =?us-ascii?Q?S7mzzZoIJtheOzNfteGhFsWmx3s9ySQcEbUbdeNxdy+lk2nAbIg1gnwC1Afl?=
 =?us-ascii?Q?MZ3IVbTiRT/BOm2/5tKD8G4uYDFwq/xXr5lB7CaUmZKRXKnNtuEkfDGMtTpP?=
 =?us-ascii?Q?RPgbToWnIG/Y0i94PBVohI49eUv/f5Jd4V4tdhwASCgioSbXxr/M3VpaGGsv?=
 =?us-ascii?Q?3yyCySXQYDY/pjifxXHNWgoACGa7HH5gLvc29AUVhY4X24hrJ8qFGBP9gJNx?=
 =?us-ascii?Q?P0I5TIeGttkNFCaBv5wzaKxOb/GCho38hOnwfj1FANQvDizXeUva7W1ie57P?=
 =?us-ascii?Q?3QCDPIl+IaqwWMka2s78SKL6ICq4S/K4KxctVdAmtQyuTe02HhgT/uUriUvQ?=
 =?us-ascii?Q?/dlCFvs2CS4KUcUt27+yo7DjOpnlH/nL3ilYaCamCU0C8TckSEwBI5cHrrhB?=
 =?us-ascii?Q?eehAyyIw3el6wIJAItA5GN3G8cU6brNWtuVNOzCW0u6vg16/UJx/zVh3EcJY?=
 =?us-ascii?Q?HJz+oXV4WVKf1OW2IubDD+mDZE+Os6T75o/o+PcIjdKtwVq28jDiogoT35Qr?=
 =?us-ascii?Q?sGvbp1rP+kCJfF1gHqnDSZh9xw2MPJVY3L6EEOidfVBJRmOoNt6GTyLVttHJ?=
 =?us-ascii?Q?6l68Ms/uFYyV8vIq5PBIzoV0qeeeUh8QySDfMEEbqAagmK8nJzMnfpXxu+Kz?=
 =?us-ascii?Q?ntlTD4J7nkmU2LjbJsOgoHPzAJp096r9GIer646w7DFxaCTnCXBWAkqbJ45g?=
 =?us-ascii?Q?SHQa4NGiI6Mi++AgH+ozI3GSvm/NofMnNYiI861NKdfnBFIkLaQAdxgAG5GW?=
 =?us-ascii?Q?EcLN97cBVnUx9e4U7F4VHUUWlohMD6+W/103Fv4dKxTPCwkY+DHiLvNIuDbe?=
 =?us-ascii?Q?poW01p52YqACpWrrRs2WkoaY1TrQH+L2e9g9ZBlmmvuXoJjroqifzB6BONtA?=
 =?us-ascii?Q?Md0U+pMPym/2TjY4Cq+3Iek8SHikdX4FHv4yvVjwBdDCwwLdztAtHVLit8Rj?=
 =?us-ascii?Q?eee82//pELsfL1/ZHfygNQ3Fyw5b0g4M+qKhz3c2ZD+vvfm4I1RN4zpB6fYo?=
 =?us-ascii?Q?jUVpRioVTIV5m5pZo+RRXP37OMndBk168umkHTv4xwrlVF8zMoE+vZROCRsV?=
 =?us-ascii?Q?HliAJo1w7vd+FxgAKORM0YoJW7NsPz22M9oOhY46K17EYBI2LMvMPl2oN13b?=
 =?us-ascii?Q?yXQTk4nC1XuPXAZdStLDJNNRfUMKcAoE4HQMYX8w2ZYf4HVrgGbyr9iVXWMR?=
 =?us-ascii?Q?Gha//swu0YqD+lH1Jr04KnM7eKu71N58treTeg5lnz7tCfOKvYXnJTpguKYQ?=
 =?us-ascii?Q?gv0liM5JxXk5shyQTUz1SVg9ag8VbLe0FIBrSaPStkYGaX9F5qhv7SjoEmKP?=
 =?us-ascii?Q?wrA6N/XSzAENScvkWfKrMOZIv2ErRWFYSTOhgFGGoohiZ2gs7DW7bHEybuI3?=
 =?us-ascii?Q?+L2nFSa7HxsE02g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:36:59.0702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b87224-d436-4841-8cd4-08dd449ae39f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916

From: Jianbo Liu <jianbol@nvidia.com>

As a specific function (mdev) is chosen to send MTPPSE command to
firmware, the event is generated only on that function. When that
function is unloaded, the PPS event can't be forward to PTP device,
even when there are other functions in the group, and PTP device is
not destroyed. To resolve this problem, need to send MTPPSE again from
new function, and dis-arm the event on old function after that.

PPS events are handled by EQ notifier. The async EQs and notifiers are
destroyed in mlx5_eq_table_destroy() which is called before
mlx5_cleanup_clock(). During the period between
mlx5_eq_table_destroy() and mlx5_cleanup_clock(), the events can't be
handled. To avoid event loss, add mlx5_clock_unload() in mlx5_unload()
to arm the event on other available function, and mlx5_clock_load in
mlx5_load() for symmetry.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 97 +++++++++++++++++--
 .../ethernet/mellanox/mlx5/core/lib/clock.h   |  5 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |  4 +
 3 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 42df3a6fda93..65a94e46edcf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -90,6 +90,7 @@ struct mlx5_clock_priv {
 	struct mlx5_clock clock;
 	struct mlx5_core_dev *mdev;
 	struct mutex lock; /* protect mdev and used in PTP callbacks */
+	struct mlx5_core_dev *event_mdev;
 };
 
 static struct mlx5_clock_priv *clock_priv(struct mlx5_clock *clock)
@@ -691,6 +692,11 @@ static int mlx5_extts_configure(struct ptp_clock_info *ptp,
 		goto unlock;
 
 	err = mlx5_set_mtppse(mdev, pin, 0, MLX5_EVENT_MODE_REPETETIVE & on);
+	if (err)
+		goto unlock;
+
+	clock->pps_info.pin_armed[pin] = on;
+	clock_priv(clock)->event_mdev = mdev;
 
 unlock:
 	mlx5_clock_unlock(clock);
@@ -1417,6 +1423,90 @@ static void mlx5_shared_clock_unregister(struct mlx5_core_dev *mdev)
 	mlx5_devcom_unregister_component(mdev->clock_state->compdev);
 }
 
+static void mlx5_clock_arm_pps_in_event(struct mlx5_clock *clock,
+					struct mlx5_core_dev *new_mdev,
+					struct mlx5_core_dev *old_mdev)
+{
+	struct ptp_clock_info *ptp_info = &clock->ptp_info;
+	struct mlx5_clock_priv *cpriv = clock_priv(clock);
+	int i;
+
+	for (i = 0; i < ptp_info->n_pins; i++) {
+		if (ptp_info->pin_config[i].func != PTP_PF_EXTTS ||
+		    !clock->pps_info.pin_armed[i])
+			continue;
+
+		if (new_mdev) {
+			mlx5_set_mtppse(new_mdev, i, 0, MLX5_EVENT_MODE_REPETETIVE);
+			cpriv->event_mdev = new_mdev;
+		} else {
+			cpriv->event_mdev = NULL;
+		}
+
+		if (old_mdev)
+			mlx5_set_mtppse(old_mdev, i, 0, MLX5_EVENT_MODE_DISABLE);
+	}
+}
+
+void mlx5_clock_load(struct mlx5_core_dev *mdev)
+{
+	struct mlx5_clock *clock = mdev->clock;
+	struct mlx5_clock_priv *cpriv;
+
+	if (!MLX5_CAP_GEN(mdev, device_frequency_khz))
+		return;
+
+	INIT_WORK(&mdev->clock_state->out_work, mlx5_pps_out);
+	MLX5_NB_INIT(&mdev->clock_state->pps_nb, mlx5_pps_event, PPS_EVENT);
+	mlx5_eq_notifier_register(mdev, &mdev->clock_state->pps_nb);
+
+	if (!clock->shared) {
+		mlx5_clock_arm_pps_in_event(clock, mdev, NULL);
+		return;
+	}
+
+	cpriv = clock_priv(clock);
+	mlx5_devcom_comp_lock(mdev->clock_state->compdev);
+	mlx5_clock_lock(clock);
+	if (mdev == cpriv->mdev && mdev != cpriv->event_mdev)
+		mlx5_clock_arm_pps_in_event(clock, mdev, cpriv->event_mdev);
+	mlx5_clock_unlock(clock);
+	mlx5_devcom_comp_unlock(mdev->clock_state->compdev);
+}
+
+void mlx5_clock_unload(struct mlx5_core_dev *mdev)
+{
+	struct mlx5_core_dev *peer_dev, *next = NULL;
+	struct mlx5_clock *clock = mdev->clock;
+	struct mlx5_devcom_comp_dev *pos;
+
+	if (!MLX5_CAP_GEN(mdev, device_frequency_khz))
+		return;
+
+	if (!clock->shared) {
+		mlx5_clock_arm_pps_in_event(clock, NULL, mdev);
+		goto out;
+	}
+
+	mlx5_devcom_comp_lock(mdev->clock_state->compdev);
+	mlx5_devcom_for_each_peer_entry(mdev->clock_state->compdev, peer_dev, pos) {
+		if (peer_dev->clock && peer_dev != mdev) {
+			next = peer_dev;
+			break;
+		}
+	}
+
+	mlx5_clock_lock(clock);
+	if (mdev == clock_priv(clock)->event_mdev)
+		mlx5_clock_arm_pps_in_event(clock, next, mdev);
+	mlx5_clock_unlock(clock);
+	mlx5_devcom_comp_unlock(mdev->clock_state->compdev);
+
+out:
+	mlx5_eq_notifier_unregister(mdev, &mdev->clock_state->pps_nb);
+	cancel_work_sync(&mdev->clock_state->out_work);
+}
+
 static struct mlx5_clock null_clock;
 
 int mlx5_init_clock(struct mlx5_core_dev *mdev)
@@ -1456,10 +1546,6 @@ int mlx5_init_clock(struct mlx5_core_dev *mdev)
 		}
 	}
 
-	INIT_WORK(&mdev->clock_state->out_work, mlx5_pps_out);
-	MLX5_NB_INIT(&mdev->clock_state->pps_nb, mlx5_pps_event, PPS_EVENT);
-	mlx5_eq_notifier_register(mdev, &mdev->clock_state->pps_nb);
-
 	return 0;
 }
 
@@ -1468,9 +1554,6 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
 	if (!MLX5_CAP_GEN(mdev, device_frequency_khz))
 		return;
 
-	mlx5_eq_notifier_unregister(mdev, &mdev->clock_state->pps_nb);
-	cancel_work_sync(&mdev->clock_state->out_work);
-
 	if (mdev->clock->shared)
 		mlx5_shared_clock_unregister(mdev);
 	else
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
index 093fa131014a..c18a652c0faa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
@@ -42,6 +42,7 @@ struct mlx5_pps {
 	u8                         enabled;
 	u64                        min_npps_period;
 	u64                        min_out_pulse_duration_ns;
+	bool                       pin_armed[MAX_PIN_NUM];
 };
 
 struct mlx5_timer {
@@ -84,6 +85,8 @@ typedef ktime_t (*cqe_ts_to_ns)(struct mlx5_clock *, u64);
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
 int mlx5_init_clock(struct mlx5_core_dev *mdev);
 void mlx5_cleanup_clock(struct mlx5_core_dev *mdev);
+void mlx5_clock_load(struct mlx5_core_dev *mdev);
+void mlx5_clock_unload(struct mlx5_core_dev *mdev);
 
 static inline int mlx5_clock_get_ptp_index(struct mlx5_core_dev *mdev)
 {
@@ -117,6 +120,8 @@ static inline ktime_t mlx5_real_time_cyc2time(struct mlx5_clock *clock,
 #else
 static inline int mlx5_init_clock(struct mlx5_core_dev *mdev) { return 0; }
 static inline void mlx5_cleanup_clock(struct mlx5_core_dev *mdev) {}
+static inline void mlx5_clock_load(struct mlx5_core_dev *mdev) {}
+static inline void mlx5_clock_unload(struct mlx5_core_dev *mdev) {}
 static inline int mlx5_clock_get_ptp_index(struct mlx5_core_dev *mdev)
 {
 	return -1;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 996773521aee..710633d5fdbe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1364,6 +1364,8 @@ static int mlx5_load(struct mlx5_core_dev *dev)
 		goto err_eq_table;
 	}
 
+	mlx5_clock_load(dev);
+
 	err = mlx5_fw_tracer_init(dev->tracer);
 	if (err) {
 		mlx5_core_err(dev, "Failed to init FW tracer %d\n", err);
@@ -1447,6 +1449,7 @@ static int mlx5_load(struct mlx5_core_dev *dev)
 	mlx5_hv_vhca_cleanup(dev->hv_vhca);
 	mlx5_fw_reset_events_stop(dev);
 	mlx5_fw_tracer_cleanup(dev->tracer);
+	mlx5_clock_unload(dev);
 	mlx5_eq_table_destroy(dev);
 err_eq_table:
 	mlx5_irq_table_destroy(dev);
@@ -1473,6 +1476,7 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
 	mlx5_hv_vhca_cleanup(dev->hv_vhca);
 	mlx5_fw_reset_events_stop(dev);
 	mlx5_fw_tracer_cleanup(dev->tracer);
+	mlx5_clock_unload(dev);
 	mlx5_eq_table_destroy(dev);
 	mlx5_irq_table_destroy(dev);
 	mlx5_pagealloc_stop(dev);
-- 
2.45.0


