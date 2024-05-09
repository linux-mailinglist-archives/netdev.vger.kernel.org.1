Return-Path: <netdev+bounces-94883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA038C0EDB
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A1D1C21035
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C148A131733;
	Thu,  9 May 2024 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SpJZQeT+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139791311A0
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715254300; cv=fail; b=O8qQw3zgl8h1lhNWtHdYXhHrqYU+m/gJ6ZhQQARo5s8uMcsyFgDc1JUBrxBZVuEBEnUZ6CIivOvTgiRdeLgrsGELvEDF6vC9D2ifVmKAGfQsaSWz9n96DHpkxjg7XK28x+wAamIiIG9+WOVF/aAeqZBpLvraBz5w9T6JY9HnXXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715254300; c=relaxed/simple;
	bh=X0zdo3XDxnSuJVgaCU2FDMJpDa5kUDd6NJ0lvle3S2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oURtlPWGJ6slW/shlxapzD8iDbuZ2E1s7NqRvYJgBRZEpJ53rLn7yJX29mNtJHM6igv+SzUIBHS+UXLoimmo1lPtXfOVhyhjpKJTOR21Hd4BQv5lRRQv+bD7YL6GMPlddEwdAaSrzFawEtTnelrmr0ouoQ8GpMCXPFjK5l22F1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SpJZQeT+; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDApJflAtWza3JwOexIuae4bBCMuaH4VptuDohA5ZubsAZjVpm82GWLqcxYOJ8RBYaoJ6zeXpZkdryLTQtxBB2XlOnmAwwvy/frqe6SRBcgZhQp/ME0hguIw2fgcoTs4WSgV9bV/GrxBXnErpvAAZ6qSQfSvB4f8iTyUMeLxbsC1tK75bNGEA8N+4scxtSa9Nsbzfc5E9HDyC1JwcSSTU5bOQcFfnnj8lCzj2Cby/y8uE2Zzwg7KEEhDS7EeKs511X5+XP3HLvtvr6A4OPVhoNQbRvfQ+8+lUsFoyvded0lejwV0smVKQ5m6Oxp0Y7gzhMUnjrUIoSfCOa0tLweDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm2KQURsJkdSK8BHayPEipc+Nz2Z6JQRekBiQLlqUzU=;
 b=gXlBKfaaGCS9RiOtcOYgPUwesnpu0Xl+SNjpdm3UjGvrjOtqfPPZqvC7G8Hz4jak0n5fQ97m9TREDLM/drhQf3PiB4cbPaYOrA0v7f12UEAjd7kzZgY3GwO+OVvvCrFjAee+AJcxdLr9+txEhVkJMags7AO6jbWwqCyaiAsOmW+JpLKhytTncn+YemDq53d5SS9SzWtzFVetaZs+xMx6JatgagIo8udogDXhKtlJPkMeeJOV2wPN7YdFIK+A1offf7Eebb1oPgnc1UE37zZBKRuqr3TPKGqG/efVGgmhBjUk4BXVf+u544JSOeTA9IHjAKwD6LpOlpK9SMquLylNKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm2KQURsJkdSK8BHayPEipc+Nz2Z6JQRekBiQLlqUzU=;
 b=SpJZQeT+wz7O0rR6h1KHxPp9hPTFrwcSZTx8mAZX3wZOrEUYX9iFf8pfCS/n0ByYYWZXK2Z+1r7NoIo+qU+XG0Pk7+fx9ZqToIeiGil5qS3WLEkQnCMddlJXUffVvShmgTVcg/GV5ZzW+frLFlnytf919T+9pHJlUTdH6v0vTXRz37JlfHEzG1LsB6mPpmDeeDj7zssCh/+BiSW7MAUeR+uges3lFzg2V2ZY78aU/XD2G2EuHrx8UQJK/zQXqAM3kw1h1mdnb0XtqocwKQqZ1CFrZSFblysENlVBJQDAJITuDnWK5/I2yw7dcapXgi44QLu6dfd0Sni5ybwIXjpRhQ==
Received: from SJ0PR13CA0185.namprd13.prod.outlook.com (2603:10b6:a03:2c3::10)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 11:31:31 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::ab) by SJ0PR13CA0185.outlook.office365.com
 (2603:10b6:a03:2c3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Thu, 9 May 2024 11:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 11:31:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 04:31:08 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 04:31:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 May
 2024 04:31:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 1/5] net/mlx5e: Fix netif state handling
Date: Thu, 9 May 2024 14:29:47 +0300
Message-ID: <20240509112951.590184-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509112951.590184-1-tariqt@nvidia.com>
References: <20240509112951.590184-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: b454f8a4-8dc4-4380-299a-08dc701b92f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f9kdzSSujFcK7Gp9XqijCuN1MrGTiIjiCqvWCmUz0RBuPGBqX4hbKb+35P1I?=
 =?us-ascii?Q?0LYfrJ9PSucv2ZzLmCxnP0UtIGGYD0CE2v+SDy9n0k1kmVtmDvHF1ODlYhGi?=
 =?us-ascii?Q?V3xAmzUTMCib0yiKwJiBXrnGGYx6oWqWKS4iuB1zs9S3Dv0NMr6ZqlZ4Kk+i?=
 =?us-ascii?Q?27h+AffUGPfsfzWPxjLIBJhEDazyiP2IAE+1hlyGRQledxlpuPgHw7HHsWd0?=
 =?us-ascii?Q?dAwcZWf82Dod+SFbMVqPvrIlQD+XkXoxo2L8smpFc5u6kHSTf8tRFGcP9hm+?=
 =?us-ascii?Q?DD26m5W97vTGRrb8LCCaeY7gAq2+i922NzB1NRUflF2MhtD0ARd/ir1ZTndC?=
 =?us-ascii?Q?rnrAhQYvH0BzOxHf5xKs1p16eFI1bQTXbRUNuHJ+hBoTdaNghnTpJkdVDpcM?=
 =?us-ascii?Q?XSJ1F3jSqQcfg/hfrIbkfznfXmGLJsaRknwTtzMw76oYZ1w1GRZjUzzi06xz?=
 =?us-ascii?Q?hK1I55EmH/54mimAECQbN5HEFgbZYifODCbcQsOUF0HEksVpyqWmZMcxlPGH?=
 =?us-ascii?Q?B8djZRaJpwzzlV+NkV8C2RSaUz9m1MIfOBC2thd8leldnamnJCOWeWhzqiY3?=
 =?us-ascii?Q?mlrnA/BqI9p3BPOmx4V8/MOIuZ12IWN2EpDKvaqRl7WvQFQsQoYV3u2qoZef?=
 =?us-ascii?Q?7PG01/6Ic6EbCu1LGl9bjWALmsHxib9Wck4ypN15RiNHz23whzq9jKWOnl5q?=
 =?us-ascii?Q?BLIPJdkdqAaplP5hY1qsIxMUulU14MeFhlDzXxC87OT6G46Qz9bcDH2uleHG?=
 =?us-ascii?Q?D/+/SIeqDBD3lv9jLAzCwkOU0uD8PvoaYK+c1TWgVo1Pzg7SEX9s3HTA2lLJ?=
 =?us-ascii?Q?4q/Yzc6Q1P9EUzOoTauBlqWLnL6E/PRQLVixQUZoqfD2VBJ+OJKtqGA3vBdD?=
 =?us-ascii?Q?ZDiKcnL7Ow1H4P7/oh8M/uJ+BBPCG+ym7+oAeC6yRcFf7cbwG6C2dmAenGLs?=
 =?us-ascii?Q?KuNPeUt7IP/r1o/6FX8FpDheI7XZ/gxr6HqyRejDSkCDDVl4/3Rx+b+GD1d8?=
 =?us-ascii?Q?7jOhDjJ7RHd1zPeLUPzq26b8v1Lavj4JcO8wLcNj+zvyZatZQf3sTAKUnbnT?=
 =?us-ascii?Q?+D0B5l359Z0w3bnhQqw7Sk3PO2oBHoM9G0iTPOJkJXzHy7CRDemPFt/iWOGj?=
 =?us-ascii?Q?NDd+DSA0N0DsQhF1t27/fED9ZmLTjLheUcUnLQbDPlxoEK1kABaen7bPNhZ5?=
 =?us-ascii?Q?L+LWHVY0VFyclWOtSPEnid59K/HSfWD91+3kIz8teKlZxxHZsA/dHj74Hx/k?=
 =?us-ascii?Q?klD01ekcn/Rb8dQTrxtZBhWHgkLzkELpBG8dmc7i80/t1/l5zmljYzFXFPZy?=
 =?us-ascii?Q?ggjA3x1yqdrmaUv33s3l44954utjDSzHmam4PmcPAt9ByAqp9uf9xU7QfLLA?=
 =?us-ascii?Q?tvj2nTSsFMK40o2AVUbpMNXNhGQg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 11:31:31.0667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b454f8a4-8dc4-4380-299a-08dc701b92f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408

From: Shay Drory <shayd@nvidia.com>

mlx5e_suspend cleans resources only if netif_device_present() returns
true. However, mlx5e_resume changes the state of netif, via
mlx5e_nic_enable, only if reg_state == NETREG_REGISTERED.
In the below case, the above leads to NULL-ptr Oops[1] and memory
leaks:

mlx5e_probe
 _mlx5e_resume
  mlx5e_attach_netdev
   mlx5e_nic_enable  <-- netdev not reg, not calling netif_device_attach()
  register_netdev <-- failed for some reason.
ERROR_FLOW:
 _mlx5e_suspend <-- netif_device_present return false, resources aren't freed :(

Hence, clean resources in this case as well.

[1]
BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: 0010 [#1] SMP
CPU: 2 PID: 9345 Comm: test-ovs-ct-gen Not tainted 6.5.0_for_upstream_min_debug_2023_09_05_16_01 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at0xffffffffffffffd6.
RSP: 0018:ffff888178aaf758 EFLAGS: 00010246
Call Trace:
 <TASK>
 ? __die+0x20/0x60
 ? page_fault_oops+0x14c/0x3c0
 ? exc_page_fault+0x75/0x140
 ? asm_exc_page_fault+0x22/0x30
 notifier_call_chain+0x35/0xb0
 blocking_notifier_call_chain+0x3d/0x60
 mlx5_blocking_notifier_call_chain+0x22/0x30 [mlx5_core]
 mlx5_core_uplink_netdev_event_replay+0x3e/0x60 [mlx5_core]
 mlx5_mdev_netdev_track+0x53/0x60 [mlx5_ib]
 mlx5_ib_roce_init+0xc3/0x340 [mlx5_ib]
 __mlx5_ib_add+0x34/0xd0 [mlx5_ib]
 mlx5r_probe+0xe1/0x210 [mlx5_ib]
 ? auxiliary_match_id+0x6a/0x90
 auxiliary_bus_probe+0x38/0x80
 ? driver_sysfs_add+0x51/0x80
 really_probe+0xc9/0x3e0
 ? driver_probe_device+0x90/0x90
 __driver_probe_device+0x80/0x160
 driver_probe_device+0x1e/0x90
 __device_attach_driver+0x7d/0x100
 bus_for_each_drv+0x80/0xd0
 __device_attach+0xbc/0x1f0
 bus_probe_device+0x86/0xa0
 device_add+0x637/0x840
 __auxiliary_device_add+0x3b/0xa0
 add_adev+0xc9/0x140 [mlx5_core]
 mlx5_rescan_drivers_locked+0x22a/0x310 [mlx5_core]
 mlx5_register_device+0x53/0xa0 [mlx5_core]
 mlx5_init_one_devl_locked+0x5c4/0x9c0 [mlx5_core]
 mlx5_init_one+0x3b/0x60 [mlx5_core]
 probe_one+0x44c/0x730 [mlx5_core]
 local_pci_probe+0x3e/0x90
 pci_device_probe+0xbf/0x210
 ? kernfs_create_link+0x5d/0xa0
 ? sysfs_do_create_link_sd+0x60/0xc0
 really_probe+0xc9/0x3e0
 ? driver_probe_device+0x90/0x90
 __driver_probe_device+0x80/0x160
 driver_probe_device+0x1e/0x90
 __device_attach_driver+0x7d/0x100
 bus_for_each_drv+0x80/0xd0
 __device_attach+0xbc/0x1f0
 pci_bus_add_device+0x54/0x80
 pci_iov_add_virtfn+0x2e6/0x320
 sriov_enable+0x208/0x420
 mlx5_core_sriov_configure+0x9e/0x200 [mlx5_core]
 sriov_numvfs_store+0xae/0x1a0
 kernfs_fop_write_iter+0x10c/0x1a0
 vfs_write+0x291/0x3c0
 ksys_write+0x5f/0xe0
 do_syscall_64+0x3d/0x90
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
 CR2: 0000000000000000
 ---[ end trace 0000000000000000  ]---

Fixes: 2c3b5beec46a ("net/mlx5e: More generic netdev management API")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 319930c04093..64497b6eebd3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6058,7 +6058,7 @@ static int mlx5e_resume(struct auxiliary_device *adev)
 	return 0;
 }
 
-static int _mlx5e_suspend(struct auxiliary_device *adev)
+static int _mlx5e_suspend(struct auxiliary_device *adev, bool pre_netdev_reg)
 {
 	struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
 	struct mlx5e_priv *priv = mlx5e_dev->priv;
@@ -6067,7 +6067,7 @@ static int _mlx5e_suspend(struct auxiliary_device *adev)
 	struct mlx5_core_dev *pos;
 	int i;
 
-	if (!netif_device_present(netdev)) {
+	if (!pre_netdev_reg && !netif_device_present(netdev)) {
 		if (test_bit(MLX5E_STATE_DESTROYING, &priv->state))
 			mlx5_sd_for_each_dev(i, mdev, pos)
 				mlx5e_destroy_mdev_resources(pos);
@@ -6090,7 +6090,7 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
 
 	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
 	if (actual_adev)
-		err = _mlx5e_suspend(actual_adev);
+		err = _mlx5e_suspend(actual_adev, false);
 
 	mlx5_sd_cleanup(mdev);
 	return err;
@@ -6157,7 +6157,7 @@ static int _mlx5e_probe(struct auxiliary_device *adev)
 	return 0;
 
 err_resume:
-	_mlx5e_suspend(adev);
+	_mlx5e_suspend(adev, true);
 err_profile_cleanup:
 	profile->cleanup(priv);
 err_destroy_netdev:
@@ -6197,7 +6197,7 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
 	mlx5_core_uplink_netdev_set(mdev, NULL);
 	mlx5e_dcbnl_delete_app(priv);
 	unregister_netdev(priv->netdev);
-	_mlx5e_suspend(adev);
+	_mlx5e_suspend(adev, false);
 	priv->profile->cleanup(priv);
 	mlx5e_destroy_netdev(priv);
 	mlx5e_devlink_port_unregister(mlx5e_dev);
-- 
2.31.1


