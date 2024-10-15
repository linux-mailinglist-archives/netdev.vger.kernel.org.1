Return-Path: <netdev+bounces-135522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6823999E2E4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE2028226B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373161E1A35;
	Tue, 15 Oct 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sLVRBWKA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33F1E202D
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984818; cv=fail; b=OkcPrE3Qk8IFU/bkWUFMhYqnq6TswZNu0gKwsoy9QiQSraTnq8TaVJ3W8S72Zbfnxvh1oFs/XF8yQd3OHso1RaNez1rezzQSYt8MJP/gJm30FTzKQMMpCgf5+Tj60/vbn/miLN6mmK296AimhIWxYLfxC/FR0MozgHPgLpIlkN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984818; c=relaxed/simple;
	bh=ChgkT48E5QCDr4Y7q5GapL5GPNVl7FWAIf+tL1Hfktg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4iRmput2Ax8DMuPiYPzlIgIfuQYQEu4Bnj2OZkeUrVfN7zX+eSRiqd3099B78J15o7eNiRc5CqmbNq1jatOeotN+dBFlq6Ne1wmH9q6RpegLOWygd8bpPrVNsOBjL3qOjDWJdQCwpCatpft6fx4Cca9c0QGjpnio+auZA3wCC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sLVRBWKA; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE5Bg/LNe+I2Wm2RVaydErPI6ikK2LRnnr/VtkiQK74Fi1HX3oEbF98jugLuueZsq16uLtWvnGuYZnpB4/ULUeal9DC5DI+NaM+ulivGsi93fkj37d5U62CsQFpDB9e7Cut7v8DOIc2az4Q02iQtln9jzwGzIBmeGkPkGpdhW8XNn4C9if1KX37Ipf/XUar/Owc10VaVl8awbwT65eLpE3uxFNDH3jh9Fg/QJ9P7Ru/xDeZMq6nO8S2V4emmyWARnMIuePJqf3PLF+LEquOU2ovKduj+hJpFssFAqZoUAb7uY27eY61JO7niEoAAcZwHLp4Yr4hKf+Y4/wu3JKtPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RnNPqLEllT1jEcqTOIvZ35unUd9vI/Fv6uWjWnez7Q=;
 b=EUveuq4aoijMi3WYrlaZbAwP2y+W+oixBO7WquiNbppSGTTzEUi8EQsJm0RPy+QkHhSMnsXyNgeBnX/mTdVA2K/A1oqPmmAMf0MsWtNVnr+pzOgwiNagsbwW/DMEoZFA6GrXaZQ2og7Ujvp9MJgElxzGlCap5UPBG02Ty/wxPF+vHn1UhKFjjD2N1IaVSduVlhHkSDFzZQRGg+vn19X8M8DhI0K3hB/TNnFeejqGblB5zyceKPRibRbn+dR0g0Ha41+Qe5DeNU7ZMbFErn7q3vEt5jU3pRij052jeX0guG3hjlmQSdjN3Joa7ItiHKm20n51OjjcTeCtz7xZEqhEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RnNPqLEllT1jEcqTOIvZ35unUd9vI/Fv6uWjWnez7Q=;
 b=sLVRBWKAMkHDSpwk7DyDRElFHxlPNtbc0hvZKtVsdbF2Us8feWnjwLdC0u7emmXcw1eydJyLh5o0CK+Lv7mmWLQYnAwumk/I5dUoFD1kXm+JRrjN1xhadvZLYEdu3N2LkBhJcAqDS/GstJxKchkleFve+yBqbjeU1gVYufiHVceRhuzwN38+7K+iLhqYDXabsOwqNVYtghQ5Adp4o22G/jh1pMjVh8MDMurWlGi4sDFbcW5CvyQB+tWDZ718zCk6+hLf/X5cUaqsUSfy1FfkvMzA2iVsh7p15986lh7DMmePQa2iKWetWZBn3xuyb+xEX0smPY9cN6CjmLsHk9FkWA==
Received: from SJ0PR03CA0087.namprd03.prod.outlook.com (2603:10b6:a03:331::32)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 09:33:33 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::94) by SJ0PR03CA0087.outlook.office365.com
 (2603:10b6:a03:331::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 09:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 09:33:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:33:15 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:33:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 15 Oct
 2024 02:33:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 8/8] net/mlx5e: Don't call cleanup on profile rollback failure
Date: Tue, 15 Oct 2024 12:32:08 +0300
Message-ID: <20241015093208.197603-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241015093208.197603-1-tariqt@nvidia.com>
References: <20241015093208.197603-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b3311c-4da5-4b89-3577-08dcecfc6f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tRW5ZOMYceJSR614btPI0eBw7Gjc1J3BptTpFg3CIWfxAqc10q2V7xD5yAoF?=
 =?us-ascii?Q?0sS3izsJ82CDjQjBtujyQkWpP912FgCSzeYYyYDswmYsqIjNVr7ULKFn3/Jw?=
 =?us-ascii?Q?tWM8o2VLQlQcIqDTcxAgmfL7IaSHNJglMKa6JuXSMcM1/MjwyaGLc1/+YpK7?=
 =?us-ascii?Q?rQLTLNT3FRe4h8WK+Ub22GcVLQoZa1I1nrQ7+EM1g/cmkJTd9BC9V581KRPj?=
 =?us-ascii?Q?ge0mhpLcwvICvhbiUf1qA5CNBy/QjN6uA3CWkIYeSTZYPQWgjI8PA6Ur2reW?=
 =?us-ascii?Q?loG78A0k2+STb0zD5aBi9WoxtwZLr1c1Y2yfiv3xDKVj0UXIxaD4Sie5d6EQ?=
 =?us-ascii?Q?pzvF+57I0CvQiPqbPPQ8+M8cdTTGR9bTWqnjy1DiWTnf6tTOH1hbZdH9xRQT?=
 =?us-ascii?Q?yJDfZE02S56s9FL3sGbFnnLn5rq/8K6Cjq6O9is3JgCAXJblNtxkgy1P/uh8?=
 =?us-ascii?Q?iSH9L8pWh5NLTokgHo+O1tH6b4YwqMC7ZLoqKXkqK1MkIFz/cuKmBlIMaJhb?=
 =?us-ascii?Q?RgsSHHyHNBeUZUKpTT1cz1uL2R67tZQ7UiyBtD+CrLXcnwgwn+e4oaOZD2dP?=
 =?us-ascii?Q?+jCr0mW9MWE3r1DPmgOl4Raj+Jy92ifJgiaRu7tMaeFIcDYeMiB1ok7uCZle?=
 =?us-ascii?Q?e7SiOTHKnrUf0oR/OkoxFDBoQ6Zm3mfC+NIxjPI+8FrSydOAPjOwADevNuHC?=
 =?us-ascii?Q?b2TTP6p67Z4xTeWVpW4OlmD48SZEZ7PROh8m41T70E5sHsOhKjFizFain3jN?=
 =?us-ascii?Q?T9glA6HooD8mM9LMDTFMe3X1Fc4lFgZCqaB+8jBfebIAvgMtiz18bFPsG14h?=
 =?us-ascii?Q?+XDPagdxUZquCAPcto/xHdlHcehSeGs/NfSrQF2rgGJKQ6uo45tbGLKZBR2f?=
 =?us-ascii?Q?kIbbCIj5ap3o6v4G5uF3QyUxN4qnDFR9FJndUYvGQl10po5rVqtRxpKCGJqo?=
 =?us-ascii?Q?LXks45XQtwJ7uc9tEs4zK2aeHmBYNAWTxgrnRyQgmYdsd2qEtJnw4p4DXiKh?=
 =?us-ascii?Q?bZsagpj77xHuYQh5iD4XQX87orhw+4il8f6vooGza2UpPtRz7SrdEEc8rgOr?=
 =?us-ascii?Q?YTKsU7LTA/4IRvlRN1VXvijBaACi7AZj7Tp2ZXX+13L9fIoC/G0P0Acs8S2F?=
 =?us-ascii?Q?q8I5xJ2YRPmE15RAwhg2JS5NgM5IbhAz2n890lrYIu6A12afHzCHN3jcsYm3?=
 =?us-ascii?Q?21cBaPBB0fFgsxAvtiNmley79s/wIWMDUwNx1n37Eb3Z1h6WfqPoC4IFrvwD?=
 =?us-ascii?Q?5Xk33icmguo7QUEK6G4deR6KxtUYtqvp5kKFHzpzCLTyXFhZAurm8vQPMe2f?=
 =?us-ascii?Q?t38XBkM/9+4yduLjj79wmd/CPjgOxL7c2aJ7jHzlO2AymJvYnAKlEXGoSqQC?=
 =?us-ascii?Q?yOJya6wyRDPs3pp/ICz7EgnsoZLv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:33:32.1581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b3311c-4da5-4b89-3577-08dcecfc6f4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867

From: Cosmin Ratiu <cratiu@nvidia.com>

When profile rollback fails in mlx5e_netdev_change_profile, the netdev
profile var is left set to NULL. Avoid a crash when unloading the driver
by not calling profile->cleanup in such a case.

This was encountered while testing, with the original trigger that
the wq rescuer thread creation got interrupted (presumably due to
Ctrl+C-ing modprobe), which gets converted to ENOMEM (-12) by
mlx5e_priv_init, the profile rollback also fails for the same reason
(signal still active) so the profile is left as NULL, leading to a crash
later in _mlx5e_remove.

 [  732.473932] mlx5_core 0000:08:00.1: E-Switch: Unload vfs: mode(OFFLOADS), nvfs(2), necvfs(0), active vports(2)
 [  734.525513] workqueue: Failed to create a rescuer kthread for wq "mlx5e": -EINTR
 [  734.557372] mlx5_core 0000:08:00.1: mlx5e_netdev_init_profile:6235:(pid 6086): mlx5e_priv_init failed, err=-12
 [  734.559187] mlx5_core 0000:08:00.1 eth3: mlx5e_netdev_change_profile: new profile init failed, -12
 [  734.560153] workqueue: Failed to create a rescuer kthread for wq "mlx5e": -EINTR
 [  734.589378] mlx5_core 0000:08:00.1: mlx5e_netdev_init_profile:6235:(pid 6086): mlx5e_priv_init failed, err=-12
 [  734.591136] mlx5_core 0000:08:00.1 eth3: mlx5e_netdev_change_profile: failed to rollback to orig profile, -12
 [  745.537492] BUG: kernel NULL pointer dereference, address: 0000000000000008
 [  745.538222] #PF: supervisor read access in kernel mode
<snipped>
 [  745.551290] Call Trace:
 [  745.551590]  <TASK>
 [  745.551866]  ? __die+0x20/0x60
 [  745.552218]  ? page_fault_oops+0x150/0x400
 [  745.555307]  ? exc_page_fault+0x79/0x240
 [  745.555729]  ? asm_exc_page_fault+0x22/0x30
 [  745.556166]  ? mlx5e_remove+0x6b/0xb0 [mlx5_core]
 [  745.556698]  auxiliary_bus_remove+0x18/0x30
 [  745.557134]  device_release_driver_internal+0x1df/0x240
 [  745.557654]  bus_remove_device+0xd7/0x140
 [  745.558075]  device_del+0x15b/0x3c0
 [  745.558456]  mlx5_rescan_drivers_locked.part.0+0xb1/0x2f0 [mlx5_core]
 [  745.559112]  mlx5_unregister_device+0x34/0x50 [mlx5_core]
 [  745.559686]  mlx5_uninit_one+0x46/0xf0 [mlx5_core]
 [  745.560203]  remove_one+0x4e/0xd0 [mlx5_core]
 [  745.560694]  pci_device_remove+0x39/0xa0
 [  745.561112]  device_release_driver_internal+0x1df/0x240
 [  745.561631]  driver_detach+0x47/0x90
 [  745.562022]  bus_remove_driver+0x84/0x100
 [  745.562444]  pci_unregister_driver+0x3b/0x90
 [  745.562890]  mlx5_cleanup+0xc/0x1b [mlx5_core]
 [  745.563415]  __x64_sys_delete_module+0x14d/0x2f0
 [  745.563886]  ? kmem_cache_free+0x1b0/0x460
 [  745.564313]  ? lockdep_hardirqs_on_prepare+0xe2/0x190
 [  745.564825]  do_syscall_64+0x6d/0x140
 [  745.565223]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 [  745.565725] RIP: 0033:0x7f1579b1288b

Fixes: 3ef14e463f6e ("net/mlx5e: Separate between netdev objects and mlx5e profiles initialization")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a5659c0c4236..e601324a690a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6509,7 +6509,9 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
 	mlx5e_dcbnl_delete_app(priv);
 	unregister_netdev(priv->netdev);
 	_mlx5e_suspend(adev, false);
-	priv->profile->cleanup(priv);
+	/* Avoid cleanup if profile rollback failed. */
+	if (priv->profile)
+		priv->profile->cleanup(priv);
 	mlx5e_destroy_netdev(priv);
 	mlx5e_devlink_port_unregister(mlx5e_dev);
 	mlx5e_destroy_devlink(mlx5e_dev);
-- 
2.44.0


