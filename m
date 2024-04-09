Return-Path: <netdev+bounces-86249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1122B89E316
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E411C21DDB
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EE3158A34;
	Tue,  9 Apr 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QkXS39fm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C3158A18
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689772; cv=fail; b=E9rh57mHcnWCsV/4V0Nwi3gbXJM/ize1bb5E/H3oHxQG5m/3MY3O6H01xZP6y8q4Uq160ZUQU3UjSOjq63C/ArfRRL3Yz6/DZNfyxoi1vg2Jm6Ngq1ZgDesbkM7L3EVtJUjTtyS2p3LBv0FYT9CG5jdTyfZMsjxSUsoVy3m/La4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689772; c=relaxed/simple;
	bh=yD/60l2sxO2zRiGX9Eb5hemtIhWVk7hHxZULiNonz+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VW1ndrSlqo5unwnQZrsDwqFUveJ1AgjFl0diDhcYiuYqd1nhPjK9VKJWVVwdQjtMlbm1ed2Ufp96WEpPD1lmuNnIfQEZtxtJUc52yy+N0fg8orVN/55lzy8iwxpisRYs74xzyWNeiukw/p1DSNiyl9yhvgsh5DSSWQnpPQ4k6rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QkXS39fm; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkXlaz/YqjQcd7x5yVZZsnOZbcxycb6tUQqiybds+68mLYPFbJzT1jmFFsRfWhUpq4tIlnXyFeg8T3BMMYQkLfP9X67fKLTNuybsnX0DGhq0hcxp9G85ghNJ1gfJ+TEzb3zvUCrIziUnyinmh0nDjiRYc6W6C0eAGSZ8Bx46NhXWFjZauNiRZklKwA1/C/8YHVGrbFmqWrYKtQDBz/mQrZAESw/obBEEq124aagHg+G8nUBcV0IJkyolfjfEZNz1uZKqSX/and4NvJBJDxkwpA+UMQnIj5RP0BGacm7v8AMcJB/P4dNgkONWS/P7yLtVJ621grrKHwD40YDbQaaMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hi3gN/7ukdZFVklxHvVBKeQkDrRkrnm4RuDkohDYxX0=;
 b=gS6JvBkjceh63jowveb8rQyPLGr9r4FlnZFOB5WfP5tOYVlQZ9z0Ox/tFoJEQOQvknBxfs76QzalTJBzufKBwwTc2oEA9Gi/oAaqg8XFnQp4Lo/GXIqpwp7TXxIBagWOQujkMPIqVDulBi5DnWNPXYeq/1mYKP7+l5Y/0Eo+TfrvD6seXWx3vH45cwyBVm6V9e7gRFIFXkGoWLvQpQJ47Nck1Nr2zf50y4EWZwXjKMorUWRi7x+wwNU19ZECmhIPOkUiOBVORXhamHRQZ0fd2CVTIm3HpMcbLJwUiGRe2iWUiGyPrt6nHKK5xYIBYEbonKyX9Z9ZXKYK2d2aVElHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hi3gN/7ukdZFVklxHvVBKeQkDrRkrnm4RuDkohDYxX0=;
 b=QkXS39fmGSrQAm5WhA3B4VmonS7E17qiXKahXmKYA0+emX/MM6qAkWNr/yGuT6+pzL4eHM9uy3sZTKpe38E1350uOQuI3/1skGlebDYH6R75kweKpnrZIXIL2o3aVSSxsQJJ/GFsJdQ+27UZnSDmRe3rDsH/sy/V20aa/hFhcgmpI4UNtjo2G2MOdscMMwxNgIpscIpT5XIAGp56mTzlcACVB6PNtx79LPghXZx2DP4JTPwAlce65XZ1h0FmgsHo1/h0kcLpJGDVicRcjLcQ8UDMTEj4IXswwQv8zMLPjwU9dqH5O6gMcgEhDbBh4DEtakU4hvkW6JziFh8oW5DrBA==
Received: from BYAPR02CA0036.namprd02.prod.outlook.com (2603:10b6:a02:ee::49)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 19:09:25 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a02:ee:cafe::7f) by BYAPR02CA0036.outlook.office365.com
 (2603:10b6:a02:ee::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 19:09:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:08:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:08:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:08:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 02/12] net/mlx5: Register devlink first under devlink lock
Date: Tue, 9 Apr 2024 22:08:10 +0300
Message-ID: <20240409190820.227554-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409190820.227554-1-tariqt@nvidia.com>
References: <20240409190820.227554-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1ae08c-2c51-4f85-7ffd-08dc58c88f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s9Jtoh03JODQcrMkR70WFaeHe0Xie1EucDWBal39/RNqlvJApFdJXBW/3ICkf63HzZY2DTmPMatW1sh0WUWcTUVF92ZFYd0fIRklKnWkIUd9VfVNKsjeMXZURxGgandv5KCl7LVfQsC74rDXxFTAQmsqyBGd4coqeb7k8QnqZrSTZcfeZmXh8ul+jPYhcJ30iUtK2EZsya408PmRbEei9iHGD07VsbJ4B7AgC3HAPS90aWtM7uAoEFIhX8VUZN31IR6DU4lhyvWcAvpqAn7jSPG69SzboMy56QtORcC80kCZaL8c77ywYJSpxjTnFx3c8mZRg3LKKmeM7R8v4/j7HdOxBMdZmS4G8Hy+NiRUYnB8S/44xhoGVbMgCpifYalijUNz5UMOqWKjMz0Y2tS1oEiNILSyX4oR/okGlhqUFS1arVjK7ANNZVexgMWX8XOyzkhrk9el2inGWQ+vHTZsaDDt2U/WvieY7/KxFjFVeM42xFk8dCiASoNduAm3uDEJLCQIfpf7FfW8roLv551TZhor7V7OJrUdgrCAn/v6SglCPqcRo5HoXJbmeQukP/6/YkFmhEUaJauGbhTm6fb3IE/Ryq/hjkP7niLRM3axvLX4A26rwH50vcTfZM2aY+poFHMW+JQZx4MGvHG+WG3ScbzD8N/bmB0IAA/kXy8Ir9t8y75E6qfBxJ9EH957UtTSpZIQcahhpOQjsp5Tmv5dPQB5j7x100sV8S/0EN6FuTIiUtGY8s2LABWEgjiuEwR9
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:20.0727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1ae08c-2c51-4f85-7ffd-08dc58c88f63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550

From: Shay Drory <shayd@nvidia.com>

In case device is having a non fatal FW error during probe, the
driver will report the error to user via devlink. This will trigger
a WARN_ON, since mlx5 is calling devlink_register() last.
In order to avoid the WARN_ON[1], change mlx5 to invoke devl_register()
first under devlink lock.

[1]
WARNING: CPU: 5 PID: 227 at net/devlink/health.c:483 devlink_recover_notify.constprop.0+0xb8/0xc0
CPU: 5 PID: 227 Comm: kworker/u16:3 Not tainted 6.4.0-rc5_for_upstream_min_debug_2023_06_12_12_38 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Workqueue: mlx5_health0000:08:00.0 mlx5_fw_reporter_err_work [mlx5_core]
RIP: 0010:devlink_recover_notify.constprop.0+0xb8/0xc0
Call Trace:
 <TASK>
 ? __warn+0x79/0x120
 ? devlink_recover_notify.constprop.0+0xb8/0xc0
 ? report_bug+0x17c/0x190
 ? handle_bug+0x3c/0x60
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x16/0x20
 ? devlink_recover_notify.constprop.0+0xb8/0xc0
 devlink_health_report+0x4a/0x1c0
 mlx5_fw_reporter_err_work+0xa4/0xd0 [mlx5_core]
 process_one_work+0x1bb/0x3c0
 ? process_one_work+0x3c0/0x3c0
 worker_thread+0x4d/0x3c0
 ? process_one_work+0x3c0/0x3c0
 kthread+0xc6/0xf0
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30
 </TASK>

Fixes: cf530217408e ("devlink: Notify users when objects are accessible")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    | 37 ++++++++++---------
 .../mellanox/mlx5/core/sf/dev/driver.c        |  1 -
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index c2593625c09a..59806553889e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1480,6 +1480,14 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
 	if (err)
 		goto err_register;
 
+	err = mlx5_crdump_enable(dev);
+	if (err)
+		mlx5_core_err(dev, "mlx5_crdump_enable failed with error code %d\n", err);
+
+	err = mlx5_hwmon_dev_register(dev);
+	if (err)
+		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
+
 	mutex_unlock(&dev->intf_state_mutex);
 	return 0;
 
@@ -1505,7 +1513,10 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	int err;
 
 	devl_lock(devlink);
+	devl_register(devlink);
 	err = mlx5_init_one_devl_locked(dev);
+	if (err)
+		devl_unregister(devlink);
 	devl_unlock(devlink);
 	return err;
 }
@@ -1517,6 +1528,8 @@ void mlx5_uninit_one(struct mlx5_core_dev *dev)
 	devl_lock(devlink);
 	mutex_lock(&dev->intf_state_mutex);
 
+	mlx5_hwmon_dev_unregister(dev);
+	mlx5_crdump_disable(dev);
 	mlx5_unregister_device(dev);
 
 	if (!test_bit(MLX5_INTERFACE_STATE_UP, &dev->intf_state)) {
@@ -1534,6 +1547,7 @@ void mlx5_uninit_one(struct mlx5_core_dev *dev)
 	mlx5_function_teardown(dev, true);
 out:
 	mutex_unlock(&dev->intf_state_mutex);
+	devl_unregister(devlink);
 	devl_unlock(devlink);
 }
 
@@ -1680,16 +1694,20 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 	}
 
 	devl_lock(devlink);
+	devl_register(devlink);
+
 	err = mlx5_devlink_params_register(priv_to_devlink(dev));
-	devl_unlock(devlink);
 	if (err) {
 		mlx5_core_warn(dev, "mlx5_devlink_param_reg err = %d\n", err);
 		goto query_hca_caps_err;
 	}
 
+	devl_unlock(devlink);
 	return 0;
 
 query_hca_caps_err:
+	devl_unregister(devlink);
+	devl_unlock(devlink);
 	mlx5_function_disable(dev, true);
 out:
 	dev->state = MLX5_DEVICE_STATE_INTERNAL_ERROR;
@@ -1702,6 +1720,7 @@ void mlx5_uninit_one_light(struct mlx5_core_dev *dev)
 
 	devl_lock(devlink);
 	mlx5_devlink_params_unregister(priv_to_devlink(dev));
+	devl_unregister(devlink);
 	devl_unlock(devlink);
 	if (dev->state != MLX5_DEVICE_STATE_UP)
 		return;
@@ -1943,16 +1962,7 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_init_one;
 	}
 
-	err = mlx5_crdump_enable(dev);
-	if (err)
-		dev_err(&pdev->dev, "mlx5_crdump_enable failed with error code %d\n", err);
-
-	err = mlx5_hwmon_dev_register(dev);
-	if (err)
-		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
-
 	pci_save_state(pdev);
-	devlink_register(devlink);
 	return 0;
 
 err_init_one:
@@ -1973,16 +1983,9 @@ static void remove_one(struct pci_dev *pdev)
 	struct devlink *devlink = priv_to_devlink(dev);
 
 	set_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state);
-	/* mlx5_drain_fw_reset() and mlx5_drain_health_wq() are using
-	 * devlink notify APIs.
-	 * Hence, we must drain them before unregistering the devlink.
-	 */
 	mlx5_drain_fw_reset(dev);
 	mlx5_drain_health_wq(dev);
-	devlink_unregister(devlink);
 	mlx5_sriov_disable(pdev, false);
-	mlx5_hwmon_dev_unregister(dev);
-	mlx5_crdump_disable(dev);
 	mlx5_uninit_one(dev);
 	mlx5_pci_close(dev);
 	mlx5_mdev_uninit(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index bc863e1f062e..e3bf8c7e4baa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -101,7 +101,6 @@ static void mlx5_sf_dev_remove(struct auxiliary_device *adev)
 	devlink = priv_to_devlink(mdev);
 	set_bit(MLX5_BREAK_FW_WAIT, &mdev->intf_state);
 	mlx5_drain_health_wq(mdev);
-	devlink_unregister(devlink);
 	if (mlx5_dev_is_lightweight(mdev))
 		mlx5_uninit_one_light(mdev);
 	else
-- 
2.44.0


