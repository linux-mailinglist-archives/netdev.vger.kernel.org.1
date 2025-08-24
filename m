Return-Path: <netdev+bounces-216281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C4B32E40
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A6F440435
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913C8267AF6;
	Sun, 24 Aug 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FFP8ckCT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339F25C833;
	Sun, 24 Aug 2025 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024845; cv=fail; b=c2atBekHEW5TTru4vVX1KlKpwNaUUwXy7qrTtVeg2zvhM6Zm0iZ6XTimrpAGvOobxiXHhunvQ4S3P14P+NrVxYMr2GX1JapgC8yweoRRh7fOs9aSW7UflzbKPNTHz+54Drb9I6eABT/YYbK1UDjSgJqyw7wB4su72Rk7WayzhdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024845; c=relaxed/simple;
	bh=4wynCkAEk3DkaBtg4jY24gosyi+QBhPcPKNUQkgFW9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ew80LrTc9rkeHSvxsI4A6TJkcT7v5aOnxVPKQojm3E6dDAn1pdz2au2D1DGCkABVC1eupuQi0Eq35ime+l8CJFEFTQ3Lfln4ft12gGoLCbPaSPyz+QRmkvUgFdBV+u88qXcM9QaEQItVIOxvw6g8F7exXU0iMzza0M8TeR8jrng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FFP8ckCT; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJgTR1+0CDz62XDqCmm8ZvlvXzwl1ZMhv/8cdpqy6ZnMCpParMAlak45uUldZniU0mOuRF+n520sjBffgG834Uqcso1h15ujEQlvdViHj/DaRvd8wJJIihRjgxRWgnu5EpnTAaM2bZB1dmdDDL3/1vTzGSwxkh1xi06BsapGszDWsoXuU+Qq64oFIkR8a8D+Tgei01K2uTNjQrLyA4iAK0h1aW3Ud476meIX5UpO9RkutpcjUWITrDOiNYb8JM3JHGiuP+859U/KlU9r1cr6tA0fJ32iMfhUTCWs1lvOQtXhhZgri2VfzslmCOo/+/VE6Sif0k7eik2Wr5XrHe/bQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovmJcB4B6dVfpnjW61Ui9xNMEPCtH0/RPY4WjVrQUhw=;
 b=L6HxWTm22bDLQqTCK3lcXLJjL8ny9d8CBkLELuTRIuSQZiA3NCi/4+ZFuAZmvgCBgOOXnNMyl0P/csHUy5gCjTtGXNiCq9F+7t9aCmLit8i/jmWcHP8t5ekCiD2S001Er/E2NMnaYZL7LHYbq1SjW5LGyFNM24KfzbYovpHy/XPKXHbBX8DGJ2MEmcNQQCA7G0r3tmrpFnDEEULvSKOnw+pC0sd5XkaiWNo5Jv+ybV/EEQpSE7HPKp3czXvF+75GBTv9lBTNZrD57k1R3bilrbh2q9f8q7sTPTF0l+Q5EeHb8kRSumImhEAa6GK5W4urXnNT6dU0WTyeIt3Gow3R0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovmJcB4B6dVfpnjW61Ui9xNMEPCtH0/RPY4WjVrQUhw=;
 b=FFP8ckCTDlIQD4TRCJH9l2uI0F6oKcuoeEIRijE3B6GdRH0B6djdfwcsXu+MTBN0IdAobgzacn5rON7+EaRVBqX20ZD8EdGFqkciyx9OYud7CcUUwFWw2JaV7VoZ+qH5J+b6bDMA+9Q9J1tGLUjxF4RiEOaTw91uPBhkjpLjmHmRUDkdQ7YNzNHvHZ10zaHAE3W06HxwFJi5gaAWtRvUUusvhIS0hb6W6DCokzPZNMOx8wjwGj+C7mGtNFHQ19dUto8n8MYev5gmLgbgUtS+qDWN5gl4/n+7CIckzHO34nmDEmgf+x9zE9T51yw6qhcfAygCHbBmPQpjJuCd+e0NuA==
Received: from CH5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:1f1::9)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 08:40:36 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::49) by CH5PR03CA0012.outlook.office365.com
 (2603:10b6:610:1f1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Sun,
 24 Aug 2025 08:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:40:36 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:40:15 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>
Subject: [PATCH net 06/11] net/mlx5: Fix lockdep assertion on sync reset unload event
Date: Sun, 24 Aug 2025 11:39:39 +0300
Message-ID: <20250824083944.523858-7-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824083944.523858-1-mbloch@nvidia.com>
References: <20250824083944.523858-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: c4023243-1c40-4f48-8a23-08dde2e9e5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NsbFwTE36mpUe+t3VrvGfhvOrWdf3WOE0x4o26snbWrd9K/FlFNrCI2XrXK+?=
 =?us-ascii?Q?3RLAaAcIOuFyVQntGgbdA5oaylZT5uBOjU1xc2vppy/oT8VYpfY6zhfWfe3R?=
 =?us-ascii?Q?R0zA6HVOhaS7IO0Kt4+QUs+S+JYb6Msr8XMFu2xn4+D7m/a/VuDzVF51UTzD?=
 =?us-ascii?Q?xurI4kuUoxkSzKvaFdM5rHLHwxk1nFDyUdOvQU9NVrpRRDHwm2GwU0J1OIZ2?=
 =?us-ascii?Q?Y6Q2hegiF3VQqKroEnwB4KGOfkXEg304HOpC6SxLvwjq9liX7TOnroaAMOwR?=
 =?us-ascii?Q?xLn6CRX4NrmHuaQAGbmbQGtUty00/2wkPtnkvBO6cVLK56WZSwZqcVW1o8W/?=
 =?us-ascii?Q?I1EMsNZrrZVUOkEM6tZD9w+BpJVg+hHi5IgNSg4EUAHngrg5TWyv8RFluyJB?=
 =?us-ascii?Q?mMh7XTURt080WcfbSADgYzeeN/XZe8ofAmRBjO8CjCfWhk1sYseBbrcAgVf4?=
 =?us-ascii?Q?3B3pCbf5SVijUQLwyolhw3n9ix8OCGBWIMEe2Yrs2D6yDEMtjs/RSsB2fhFH?=
 =?us-ascii?Q?YzX0O4Vpa/NEho/gKhyMPDOGkl0uCFBI04UMZTcrM2kbJQakHIzwSOGPuWGI?=
 =?us-ascii?Q?Mef73SaM/AJ+wFj1tEPrmza3d1qHMAa2YoxRej+gWX9gxP3GoXF4wrqdwpvF?=
 =?us-ascii?Q?q5H44nOxY+9TLDzwTDjhw97KdEz3hMQQfMjcIsDz6zRylqZUKipvdMLMGAg8?=
 =?us-ascii?Q?15oHGt3VpZfxLHVxXYe/FFNCmWFa4t2LcEmog/cLPuUXd53Dsvl6ND1+jHCN?=
 =?us-ascii?Q?spTh1DVaVjROd9BJeIOrptpbPIE3CwNS0T8tIF0MHz7ojIOuzik0uGT9i/Xl?=
 =?us-ascii?Q?E+tvH/AI8jX+ibLv66HOWckSVjO8LB32sL/s2HAAd5RcCin+naDLV57GxL6o?=
 =?us-ascii?Q?W2TdA+RcAwoufRiVYBTBwpgAwr39XxNtl26+JNIQtwgnGAAeDNw/HICsJFX4?=
 =?us-ascii?Q?u41p8/5L7qfrUMhBxF8KyxUdmOTVOWtZeCTn2DFWemP6R9i5V+VvVC4XsECG?=
 =?us-ascii?Q?+jk7miD7pt/Wjuwr+5Vg3hjr6+5js0sDyqwd4ZFOk0YwLMMBoM1l7Nu4LLES?=
 =?us-ascii?Q?e2iSdVH+sn07pzZ/b6Y66qNpWCT2/D668MwJkTd9wE8EeqUeJ0aR9ancNjpS?=
 =?us-ascii?Q?jMYBnlqQg6ICdQL8iXk20B5PdLR1yel+ISNr8WYjp+rPx/4C/BATcox0YOdv?=
 =?us-ascii?Q?w9+AGk2UxsNRTLG4o3VD9+WnlLbOk0bVpNQLYQboE1RD56oD4rOdvvmAd3gb?=
 =?us-ascii?Q?e3sFOFkwesQfLSVxW7yz7yihL9j5I/3vDWHoHtYtIs7K0psXCqWuKNogVJ7h?=
 =?us-ascii?Q?CYrs4xY2K4jAdZBDUPZo5SnX7XFsgNWbgAqprxe9mJm85lXQWOp9yGM8eo04?=
 =?us-ascii?Q?t6rOgLujRSB4HqC8aETUKRqKx+MBUctrqVQO3o2I1Vc4+dQPjzRoEq67+B5/?=
 =?us-ascii?Q?2w4ulRaUJmc3znOGt8gPmm1Y1iy/IvFnW3Yw3Z1Rle0i/ub+gF7bVgrU0/PD?=
 =?us-ascii?Q?N7svvwAmxdgVwXcbsBzDi2AYCmYyPHunLOOY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:40:36.6496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4023243-1c40-4f48-8a23-08dde2e9e5d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465

From: Moshe Shemesh <moshe@nvidia.com>

Fix lockdep assertion triggered during sync reset unload event. When the
sync reset flow is initiated using the devlink reload fw_activate
option, the PF already holds the devlink lock while handling unload
event. In this case, delegate sync reset unload event handling back to
the devlink callback process to avoid double-locking and resolve the
lockdep warning.

Kernel log:
WARNING: CPU: 9 PID: 1578 at devl_assert_locked+0x31/0x40
[...]
Call Trace:
<TASK>
 mlx5_unload_one_devl_locked+0x2c/0xc0 [mlx5_core]
 mlx5_sync_reset_unload_event+0xaf/0x2f0 [mlx5_core]
 process_one_work+0x222/0x640
 worker_thread+0x199/0x350
 kthread+0x10b/0x230
 ? __pfx_worker_thread+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x8e/0x100
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
</TASK>

Fixes: 7a9770f1bfea ("net/mlx5: Handle sync reset unload event")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   2 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 120 ++++++++++--------
 .../ethernet/mellanox/mlx5/core/fw_reset.h    |   1 +
 3 files changed, 69 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 26091e7536d3..2c0e0c16ca90 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -160,7 +160,7 @@ static int mlx5_devlink_reload_fw_activate(struct devlink *devlink, struct netli
 	if (err)
 		return err;
 
-	mlx5_unload_one_devl_locked(dev, false);
+	mlx5_sync_reset_unload_flow(dev, true);
 	err = mlx5_health_wait_pci_up(dev);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "FW activate aborted, PCI reads fail after reset");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 69933addd921..38b9b184ae01 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -12,7 +12,8 @@ enum {
 	MLX5_FW_RESET_FLAGS_NACK_RESET_REQUEST,
 	MLX5_FW_RESET_FLAGS_PENDING_COMP,
 	MLX5_FW_RESET_FLAGS_DROP_NEW_REQUESTS,
-	MLX5_FW_RESET_FLAGS_RELOAD_REQUIRED
+	MLX5_FW_RESET_FLAGS_RELOAD_REQUIRED,
+	MLX5_FW_RESET_FLAGS_UNLOAD_EVENT,
 };
 
 struct mlx5_fw_reset {
@@ -219,7 +220,7 @@ int mlx5_fw_reset_set_live_patch(struct mlx5_core_dev *dev)
 	return mlx5_reg_mfrl_set(dev, MLX5_MFRL_REG_RESET_LEVEL0, 0, 0, false);
 }
 
-static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev, bool unloaded)
+static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 	struct devlink *devlink = priv_to_devlink(dev);
@@ -228,8 +229,7 @@ static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev, bool unload
 	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags)) {
 		complete(&fw_reset->done);
 	} else {
-		if (!unloaded)
-			mlx5_unload_one(dev, false);
+		mlx5_sync_reset_unload_flow(dev, false);
 		if (mlx5_health_wait_pci_up(dev))
 			mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
 		else
@@ -272,7 +272,7 @@ static void mlx5_sync_reset_reload_work(struct work_struct *work)
 
 	mlx5_sync_reset_clear_reset_requested(dev, false);
 	mlx5_enter_error_state(dev, true);
-	mlx5_fw_reset_complete_reload(dev, false);
+	mlx5_fw_reset_complete_reload(dev);
 }
 
 #define MLX5_RESET_POLL_INTERVAL	(HZ / 10)
@@ -586,6 +586,65 @@ static int mlx5_sync_pci_reset(struct mlx5_core_dev *dev, u8 reset_method)
 	return err;
 }
 
+void mlx5_sync_reset_unload_flow(struct mlx5_core_dev *dev, bool locked)
+{
+	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
+	unsigned long timeout;
+	int poll_freq = 20;
+	bool reset_action;
+	u8 rst_state;
+	int err;
+
+	if (locked)
+		mlx5_unload_one_devl_locked(dev, false);
+	else
+		mlx5_unload_one(dev, false);
+
+	if (!test_bit(MLX5_FW_RESET_FLAGS_UNLOAD_EVENT, &fw_reset->reset_flags))
+		return;
+
+	mlx5_set_fw_rst_ack(dev);
+	mlx5_core_warn(dev, "Sync Reset Unload done, device reset expected\n");
+
+	reset_action = false;
+	timeout = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, RESET_UNLOAD));
+	do {
+		rst_state = mlx5_get_fw_rst_state(dev);
+		if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ ||
+		    rst_state == MLX5_FW_RST_STATE_IDLE) {
+			reset_action = true;
+			break;
+		}
+		if (rst_state == MLX5_FW_RST_STATE_DROP_MODE) {
+			mlx5_core_info(dev, "Sync Reset Drop mode ack\n");
+			mlx5_set_fw_rst_ack(dev);
+			poll_freq = 1000;
+		}
+		msleep(poll_freq);
+	} while (!time_after(jiffies, timeout));
+
+	if (!reset_action) {
+		mlx5_core_err(dev, "Got timeout waiting for sync reset action, state = %u\n",
+			      rst_state);
+		fw_reset->ret = -ETIMEDOUT;
+		goto done;
+	}
+
+	mlx5_core_warn(dev, "Sync Reset, got reset action. rst_state = %u\n",
+		       rst_state);
+	if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ) {
+		err = mlx5_sync_pci_reset(dev, fw_reset->reset_method);
+		if (err) {
+			mlx5_core_warn(dev, "mlx5_sync_pci_reset failed, err %d\n",
+				       err);
+			fw_reset->ret = err;
+		}
+	}
+
+done:
+	clear_bit(MLX5_FW_RESET_FLAGS_UNLOAD_EVENT, &fw_reset->reset_flags);
+}
+
 static void mlx5_sync_reset_now_event(struct work_struct *work)
 {
 	struct mlx5_fw_reset *fw_reset = container_of(work, struct mlx5_fw_reset,
@@ -613,17 +672,13 @@ static void mlx5_sync_reset_now_event(struct work_struct *work)
 	mlx5_enter_error_state(dev, true);
 done:
 	fw_reset->ret = err;
-	mlx5_fw_reset_complete_reload(dev, false);
+	mlx5_fw_reset_complete_reload(dev);
 }
 
 static void mlx5_sync_reset_unload_event(struct work_struct *work)
 {
 	struct mlx5_fw_reset *fw_reset;
 	struct mlx5_core_dev *dev;
-	unsigned long timeout;
-	int poll_freq = 20;
-	bool reset_action;
-	u8 rst_state;
 	int err;
 
 	fw_reset = container_of(work, struct mlx5_fw_reset, reset_unload_work);
@@ -632,6 +687,7 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 	if (mlx5_sync_reset_clear_reset_requested(dev, false))
 		return;
 
+	set_bit(MLX5_FW_RESET_FLAGS_UNLOAD_EVENT, &fw_reset->reset_flags);
 	mlx5_core_warn(dev, "Sync Reset Unload. Function is forced down.\n");
 
 	err = mlx5_cmd_fast_teardown_hca(dev);
@@ -640,49 +696,7 @@ static void mlx5_sync_reset_unload_event(struct work_struct *work)
 	else
 		mlx5_enter_error_state(dev, true);
 
-	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags))
-		mlx5_unload_one_devl_locked(dev, false);
-	else
-		mlx5_unload_one(dev, false);
-
-	mlx5_set_fw_rst_ack(dev);
-	mlx5_core_warn(dev, "Sync Reset Unload done, device reset expected\n");
-
-	reset_action = false;
-	timeout = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, RESET_UNLOAD));
-	do {
-		rst_state = mlx5_get_fw_rst_state(dev);
-		if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ ||
-		    rst_state == MLX5_FW_RST_STATE_IDLE) {
-			reset_action = true;
-			break;
-		}
-		if (rst_state == MLX5_FW_RST_STATE_DROP_MODE) {
-			mlx5_core_info(dev, "Sync Reset Drop mode ack\n");
-			mlx5_set_fw_rst_ack(dev);
-			poll_freq = 1000;
-		}
-		msleep(poll_freq);
-	} while (!time_after(jiffies, timeout));
-
-	if (!reset_action) {
-		mlx5_core_err(dev, "Got timeout waiting for sync reset action, state = %u\n",
-			      rst_state);
-		fw_reset->ret = -ETIMEDOUT;
-		goto done;
-	}
-
-	mlx5_core_warn(dev, "Sync Reset, got reset action. rst_state = %u\n", rst_state);
-	if (rst_state == MLX5_FW_RST_STATE_TOGGLE_REQ) {
-		err = mlx5_sync_pci_reset(dev, fw_reset->reset_method);
-		if (err) {
-			mlx5_core_warn(dev, "mlx5_sync_pci_reset failed, err %d\n", err);
-			fw_reset->ret = err;
-		}
-	}
-
-done:
-	mlx5_fw_reset_complete_reload(dev, true);
+	mlx5_fw_reset_complete_reload(dev);
 }
 
 static void mlx5_sync_reset_abort_event(struct work_struct *work)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
index ea527d06a85f..d5b28525c960 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h
@@ -12,6 +12,7 @@ int mlx5_fw_reset_set_reset_sync(struct mlx5_core_dev *dev, u8 reset_type_sel,
 int mlx5_fw_reset_set_live_patch(struct mlx5_core_dev *dev);
 
 int mlx5_fw_reset_wait_reset_done(struct mlx5_core_dev *dev);
+void mlx5_sync_reset_unload_flow(struct mlx5_core_dev *dev, bool locked);
 int mlx5_fw_reset_verify_fw_complete(struct mlx5_core_dev *dev,
 				     struct netlink_ext_ack *extack);
 void mlx5_fw_reset_events_start(struct mlx5_core_dev *dev);
-- 
2.34.1


