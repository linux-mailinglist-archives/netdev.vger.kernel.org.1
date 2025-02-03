Return-Path: <netdev+bounces-162271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9018AA265C3
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB641886124
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB8420FA81;
	Mon,  3 Feb 2025 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jUK/MN6J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392D0210F5A
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618618; cv=fail; b=RHIi8QbWx7hvRQ6CZ/Sgy1mRlP0XB4GFwHmoYmihpYLkrGGkr/zk9whWB8aZFo71DnqkaMTJOoC/Nd1UqTDEmy8RxWm9XDqcRCAWHPPSsOricUCYpK/NUYY/11+TEKBAzX2kEZZeICnk1KLiI9z8gyo5XTp1+DRyZot+MsLnolM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618618; c=relaxed/simple;
	bh=Atvs11Hh6iVh4306naa3JWLw4bCbOZ2rXJhGA1NoCSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrdejkOJP06oTN0scpVEmKc+vRfb2fwjUE3GyAntQcn2s1ttS6MJWgWFfQHbubWBtUfv497ecfK2z9/qmgOZjz+4DTWAEUFevCyh8SVJ0JoEVwnfeQymyIy6VAwW6TewZudkjbSybPPFeUGKJaNX3RVmXqBiIW/3zx+qscaBS+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jUK/MN6J; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7BnDwLmwUjsjGhxjb+VOYHFV8Cy4FqGFAmWVa0N5ZEArklUO807OBY6r29IXqrENjXSMBG/xdugf0b04pZE6x0/fh83WhUpoDnb8iD7z9DrRTjPK8gMtz8r7PEuNg6suRpEAQyM/XgI2QbkG1rsOF2pZXcRNmhucVzG8PyuaFLEwF3bXw5ghjL8vXF2jJ0ptivVFLwy6VBuzO7uNFbCrVvlBwxDXUAh/eM3WnTxnXVyrCBvYh+/vxVkS5w1yBtprDtkU78hYP3cO1CxpdNxlvDpV0Agvda9Rnc4zUiHkzYV2yuU+gwa0GuxRU+dZGZDtlXcFt+sfiE0Fb7FYg1aXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZWU5Lp+Eysnh2HMej/B54IKRLDXShPBfpsOAhtYpsc=;
 b=AEyFjt8RHGeXhLhpfnmYymwnsrc4+rhDVcDZ656o71a1GPGAQTNeJF4SlOeRQsSJeAgiVj+g0JwxLFBgoJc4+xBaTBAS2wmZ8jx4nYGsRJ91rO0k+kMfrlfarMfaS80OGfN3ZGpb6ImGKIRbu6w2zCSKWWY4W5EWXpcxRbWXSqHwiPIO5+J6A7nTHR6ggioFUzNSEMccZ/cqO2iXvzR5t6HByXJqVuVR8mG0j9EhGJwSi7u0x3zd+PlZyx0p0kVPic8t+Fo/DLG0YzHRDhQRYm+qDJYtvf8xfxCb660kRi6sjqSmkjwr0ybRe6oRkPkLERqp9QEiLUvWDaGAjRYszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZWU5Lp+Eysnh2HMej/B54IKRLDXShPBfpsOAhtYpsc=;
 b=jUK/MN6JLjmB8tZ7ClG5EmeTOoz4PReZsMdauBwkNlDz/3saY/HS6keE29tl3FsW//bk0YVnFAv1cjAuZri/TZl2wYnNfKRFduvxkBuQcxQn6+sGFQNO5PJafOTefvZgrIx5uN0OVFj/mz4vk0GG2lc3QwfKwlETPUwwY9H6R9xdsdvgmQ8f4/RDkDT0wa0uh2m1UcPHEERHbkssPvQg3tVzzjPrp3u2vAaBuBjeQ6On1noni4zNPIKIgF7sb4PC+yiqOxKM9NHmxg4wwCWdnkM52vxfoPhjAHqVJ2vKk3Cwqc/7sU3FPnnytscmFLwsv3cNDdE3pMBxmtds0eImuw==
Received: from MW4PR03CA0319.namprd03.prod.outlook.com (2603:10b6:303:dd::24)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 21:36:49 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::ab) by MW4PR03CA0319.outlook.office365.com
 (2603:10b6:303:dd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Mon,
 3 Feb 2025 21:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:36:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:36 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:33 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:29 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 06/15] net/mlx5: Add devcom component for the clock shared by functions
Date: Mon, 3 Feb 2025 23:35:07 +0200
Message-ID: <20250203213516.227902-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: e08673da-7073-443e-b75e-08dd449add96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dOyquUwM2S/HXtYc2C2R8CI+Z8dCnIXk+/fMRk93vOdJItFHuvTi5jfbqVVh?=
 =?us-ascii?Q?RbF3sll8lZkewgE8qmkomAGUbrO1oTA+c8AvTo2CvKBAFP8r6hbAcejYi9wh?=
 =?us-ascii?Q?YfQ8Gos2olNKK32FDndAQKSfdHgiWIMyKOsUG/FgBZoJCBmXgaKBF5tmCmrn?=
 =?us-ascii?Q?OYrsx9P5PwJqOKLxaGBo4JB3lZS7mMixtbkL5IthV2xDubODL/fm0yR753ye?=
 =?us-ascii?Q?+YhtHEYKeBJiQvPoCVuM2Bgfpwc9QQTQVOUqYOITyv3T5dg+2wpMXOvC/ldT?=
 =?us-ascii?Q?r2P3VR6K3qYi42YK1FkU2VczwBJse36dNkgnY6GQCS+D0SpOR2irqT4dz7tg?=
 =?us-ascii?Q?cuYN5eG5rTPH2ieu5MCTECLCJwFffnjN5PUa1CIJzuTmPhP6DMj1sPnMUXr6?=
 =?us-ascii?Q?GPsFsVwr9+U72MMQ0rK1MoywJuMDd5lfgAETrN+vnF1vXq4JkcK5fpaJhhTv?=
 =?us-ascii?Q?uQ5+8evgAkkYnKCUT5TZv5qLGpylvF46v6ABSPWQYKDnRO6usIrB4JA+H5Ij?=
 =?us-ascii?Q?mtnjsNm9ZwozYkG6blI6rxxaddia/N+/g0QZucuTXRooh10sMaBqJJkGz5Ia?=
 =?us-ascii?Q?gQeyNapbqHETBiMY8w5XC8Tj8vy+m1XzN+SNGULD9HWLpPvrzqb+VQTX3qHg?=
 =?us-ascii?Q?UVRMlBXms4YOKYKK7ZZLufbTVLkHF13I7ibtolSVltjmFZPRSUtvKwMuGXlM?=
 =?us-ascii?Q?imkInn0Qi6bTC1c3yVrYElOeI8w596BXRps0Tw0cIDDYGgwQw3//CZolb/27?=
 =?us-ascii?Q?auKHlIgipQ5MgDYgz3NXjAuLAnUQxB3XuCUiiZetGOKgL/lwmynwj7jW5mbV?=
 =?us-ascii?Q?mtCDMTkqxTU9hSO72dZcFTRNPn0stLakJG+OMQG6l1N46plLfampK7AJpD29?=
 =?us-ascii?Q?kyvHiOVPCXWdTVQno8J755i+xztmp+qYvWNb90StAfw7ktX8BbGukSGi285M?=
 =?us-ascii?Q?72lKCvuiF/ZpjsKhAti+CGpqpKBaiHOxXpngQ1pOif0siWXATqav3PA/hmSj?=
 =?us-ascii?Q?MCLET8wc3tIQyosIDk3fuwvimI1wjGcXBXfwo5Pn4JGhhisTzoDL0iGaBRMs?=
 =?us-ascii?Q?zybFCY10AjEH17296fQ55Rr6mdXhAk9pUOXRptnbOtQzvDf2oe47d/pdJrjh?=
 =?us-ascii?Q?k1h3C44hxFBbYQxabm9Wj/xhQqj1jujRinWUtFQgsNAGQMXJwHk7VV4+jskf?=
 =?us-ascii?Q?YZWzUrV6dopizbsvP9qeEcin3uQk2ehKQ/rpg2cWkcKlQz7D0/gYcb5PONvz?=
 =?us-ascii?Q?G0pMbGxhSRXSotCiSXrC2Yf4IymLZmFrw/y3dWf7HMSzeTJM15MgwA2AP/hb?=
 =?us-ascii?Q?t6Pgjehv0y2DOIFiUprQQ9PkiGw+9F4a+dZ0R73WOsgoE4HhH3Idvkwdk1oO?=
 =?us-ascii?Q?bC/V4eHBmL1s/+Dd3v/DprAAvUtsDqCrtndr0qIlfbPYoxg6W/3GGiDKFeqd?=
 =?us-ascii?Q?IEVHSmLc7MSTXT38gMmQfZsVJKC7qJk+uF53yLHuLaFqqcgI1uXi8x7Kd2av?=
 =?us-ascii?Q?V7xSWWvSvyerpU8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:36:48.9460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e08673da-7073-443e-b75e-08dd449add96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379

From: Jianbo Liu <jianbol@nvidia.com>

Add new devcom component for hardware clock. When it is running in
real time mode, the functions are grouped by the identify they query.

According to firmware document, the clock identify size is 64 bits, so
it's safe to memcpy to component key, as the key size is also 64 bits.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 59 ++++++++++++++++++-
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |  1 +
 include/linux/mlx5/driver.h                   |  2 +
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index da2a21ce8060..7e5882ea19e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -43,6 +43,8 @@
 #include <linux/cpufeature.h>
 #endif /* CONFIG_X86 */
 
+#define MLX5_RT_CLOCK_IDENTITY_SIZE MLX5_FLD_SZ_BYTES(mrtcq_reg, rt_clock_identity)
+
 enum {
 	MLX5_PIN_MODE_IN		= 0x0,
 	MLX5_PIN_MODE_OUT		= 0x1,
@@ -77,6 +79,10 @@ enum {
 	MLX5_MTUTC_OPERATION_ADJUST_TIME_EXTENDED_MAX = 200000,
 };
 
+struct mlx5_clock_dev_state {
+	struct mlx5_devcom_comp_dev *compdev;
+};
+
 struct mlx5_clock_priv {
 	struct mlx5_clock clock;
 	struct mlx5_core_dev *mdev;
@@ -109,6 +115,22 @@ static bool mlx5_modify_mtutc_allowed(struct mlx5_core_dev *mdev)
 	return MLX5_CAP_MCAM_FEATURE(mdev, ptpcyc2realtime_modify);
 }
 
+static int mlx5_clock_identity_get(struct mlx5_core_dev *mdev,
+				   u8 identify[MLX5_RT_CLOCK_IDENTITY_SIZE])
+{
+	u32 out[MLX5_ST_SZ_DW(mrtcq_reg)] = {};
+	u32 in[MLX5_ST_SZ_DW(mrtcq_reg)] = {};
+	int err;
+
+	err = mlx5_core_access_reg(mdev, in, sizeof(in),
+				   out, sizeof(out), MLX5_REG_MRTCQ, 0, 0);
+	if (!err)
+		memcpy(identify, MLX5_ADDR_OF(mrtcq_reg, out, rt_clock_identity),
+		       MLX5_RT_CLOCK_IDENTITY_SIZE);
+
+	return err;
+}
+
 static u32 mlx5_ptp_shift_constant(u32 dev_freq_khz)
 {
 	/* Optimal shift constant leads to corrections above just 1 scaled ppm.
@@ -1231,11 +1253,26 @@ static int mlx5_clock_alloc(struct mlx5_core_dev *mdev)
 	return 0;
 }
 
+static void mlx5_shared_clock_register(struct mlx5_core_dev *mdev, u64 key)
+{
+	mdev->clock_state->compdev = mlx5_devcom_register_component(mdev->priv.devc,
+								    MLX5_DEVCOM_SHARED_CLOCK,
+								    key, NULL, mdev);
+}
+
+static void mlx5_shared_clock_unregister(struct mlx5_core_dev *mdev)
+{
+	mlx5_devcom_unregister_component(mdev->clock_state->compdev);
+}
+
 static struct mlx5_clock null_clock;
 
 int mlx5_init_clock(struct mlx5_core_dev *mdev)
 {
+	u8 identity[MLX5_RT_CLOCK_IDENTITY_SIZE];
+	struct mlx5_clock_dev_state *clock_state;
 	struct mlx5_clock *clock;
+	u64 key;
 	int err;
 
 	if (!MLX5_CAP_GEN(mdev, device_frequency_khz)) {
@@ -1244,9 +1281,26 @@ int mlx5_init_clock(struct mlx5_core_dev *mdev)
 		return 0;
 	}
 
+	clock_state = kzalloc(sizeof(*clock_state), GFP_KERNEL);
+	if (!clock_state)
+		return -ENOMEM;
+	mdev->clock_state = clock_state;
+
+	if (MLX5_CAP_MCAM_REG3(mdev, mrtcq) && mlx5_real_time_mode(mdev)) {
+		if (mlx5_clock_identity_get(mdev, identity)) {
+			mlx5_core_warn(mdev, "failed to get rt clock identity, create ptp dev per function\n");
+		} else {
+			memcpy(&key, &identity, sizeof(key));
+			mlx5_shared_clock_register(mdev, key);
+		}
+	}
+
 	err = mlx5_clock_alloc(mdev);
-	if (err)
+	if (err) {
+		kfree(clock_state);
+		mdev->clock_state = NULL;
 		return err;
+	}
 	clock = mdev->clock;
 
 	INIT_WORK(&clock->pps_info.out_work, mlx5_pps_out);
@@ -1267,4 +1321,7 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
 	cancel_work_sync(&clock->pps_info.out_work);
 
 	mlx5_clock_free(mdev);
+	mlx5_shared_clock_unregister(mdev);
+	kfree(mdev->clock_state);
+	mdev->clock_state = NULL;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index d58032dd0df7..c79699b94a02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -11,6 +11,7 @@ enum mlx5_devcom_component {
 	MLX5_DEVCOM_MPV,
 	MLX5_DEVCOM_HCA_PORTS,
 	MLX5_DEVCOM_SD_GROUP,
+	MLX5_DEVCOM_SHARED_CLOCK,
 	MLX5_DEVCOM_NUM_COMPONENTS,
 };
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 5dab3d8d05e4..46bd7550adf8 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -679,6 +679,7 @@ struct mlx5_rsvd_gids {
 };
 
 struct mlx5_clock;
+struct mlx5_clock_dev_state;
 struct mlx5_dm;
 struct mlx5_fw_tracer;
 struct mlx5_vxlan;
@@ -763,6 +764,7 @@ struct mlx5_core_dev {
 	struct mlx5_fpga_device *fpga;
 #endif
 	struct mlx5_clock       *clock;
+	struct mlx5_clock_dev_state *clock_state;
 	struct mlx5_ib_clock_info  *clock_info;
 	struct mlx5_fw_tracer   *tracer;
 	struct mlx5_rsc_dump    *rsc_dump;
-- 
2.45.0


