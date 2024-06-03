Return-Path: <netdev+bounces-100349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1E38D8B45
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B9F1F22F7C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F3513B284;
	Mon,  3 Jun 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tluUCR8l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D513B59C
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448768; cv=fail; b=gQhX7LUarVCp68lFtEhaUWX93Bm4iOTNHc3W1UmIBwrmekNilE/m1gwZPiiJGhdJVr1wizRfLuUkjWKcv09WXDXkqxByKt9RhGtiWy9290hOzXChrag3rSajKnxt6KVWOnYoXSXosxpbYhNqOP5A4xi9xxpPoPWl/0RExvwaiwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448768; c=relaxed/simple;
	bh=tihl7qiS3tmFyFsItgYYvbl9cAshPwkXAGO+ivGa5Dk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIlvsplJ/CK0lmq3hqB26ohm+be5F0pMplwPNSwU+xqFXOB3d5WYGG8F9h2ipuyYmuf+UgjVMogQhQZRweifa/LCBK7JMwoRs3RhwCrbY5mGPZHbggzGSmRkxUHvHS2Bib7MmYjgDV0Hgi8lvntLbQpxcHNg5JyL8XhtwoZ5Vvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tluUCR8l; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOZYdfsxqNB7DHTm8NyLA7AXY0x/Xalms1f/wnaTat3T1djwyxO5T8kwp3pyetzwUHhTpj3LCF+HBpfsN7b29wbFtt296qBC6LWknlKqNi3ml0fCMCJYVHvHpeuESFqZBdngbEp8ZonEiJkZxlxeggWfMq40uIcNe26eTtNeBNVBB2OtdkHcDtMO9T5E3DaNOUFdziYd9pNu+hQ0DnclbGjeD03NkOqMvbO4Z56+bgXsrUxCOysW0rxiHtM7kc+bIbi5I5lGywQDgMLszzJfIML2Ip6OqTuwiGryK/ppna7k4tWmO3fI6qrEOT2w69UgUDjm7+50TQGbxm6zlZUiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtDNz0GhE0AfkeXVTrSKca+j3qL8Ii/kvWSCiDt5aMI=;
 b=Fglow3rmAskVuHSLqPu6PBAQGCtiTpWYZX3WjGN9VSbb/a1squmjZ/bEaSPM4yTkNhyu5zDS1Q0Bbxxr2Sj7LFQryy+BfwTQqMBNnHR8tcvPdShnmwMeE/V9jOMWGE0792Zlz1L87dbUkVgzjWQ4IQBoiC+IrfLewmsEDqGVUAWSmR/6kvbN6SWBuQXce2ByzuUTDvmZKwhu1R7DKFiBRuCPvJArLJPfMJUyWToXKdTNMhbJgbdtU+xmc7IZmrh4HNjT8LKUt5s40eOGcM3Dq7zwL8XF4KKQ3BqYfT0Z1N0v69oB/1zZynm9ERAofdO8Iy7Xeai04DfTDCGPnDV+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtDNz0GhE0AfkeXVTrSKca+j3qL8Ii/kvWSCiDt5aMI=;
 b=tluUCR8lYQmw7ExLMCi61Z63AZqC4OGjFhBF1COQb78HGg6d6SgHaGBcwbtahD84dbeHQm5/o4PyHsaaFfZTV6TKIt52VDFV4dPnKpCMFbHUz9wwWMIaEKvO6V6x4dIJHaX0YJBeZkA1p1JIurPxYRSzByLyMizhkVorPiXH5olw2PGttTxvBk0SLdGK+1lsFTvDAjd7v3fdmNQYq2jseWc8eoujeq/HGjztibLSb/EH5/sMR/qt5SHRJcs3rAswoyh2CxrTX8AFRXjKc5rUkGtbOUZQZmtdYMG6mu0BzC+5dqMJRtb7NTdTLhwuaTj6sFkyYkHa26i+RZyZKRrj2g==
Received: from DS7PR03CA0359.namprd03.prod.outlook.com (2603:10b6:8:55::35) by
 MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.25; Mon, 3 Jun 2024 21:06:02 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::a9) by DS7PR03CA0359.outlook.office365.com
 (2603:10b6:8:55::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:06:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:06:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:05:54 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:05:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:05:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 2/2] net/mlx5: Always stop health timer during driver removal
Date: Tue, 4 Jun 2024 00:04:43 +0300
Message-ID: <20240603210443.980518-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240603210443.980518-1-tariqt@nvidia.com>
References: <20240603210443.980518-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bcf5f3-741e-4697-21ce-08dc8410f9a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+5IgdGhCewP3/xa6ZzBm6vreVyzKHF94OWjj3Br1iOp+19jFRuN45Bbihd1?=
 =?us-ascii?Q?S4sqlPBZatjsg6L3ewcy8XjcQtKUUDeymXnuckzcogwcIN/bVfaxKl+HWRDF?=
 =?us-ascii?Q?RF/xwxU6taGFtugYk9qqx70lBIGvlM0nq9BOLUxWDYdP6kKDAzkfe+nG1UeR?=
 =?us-ascii?Q?YZDH9S+RIR6RoJTU7nZbYN6FAFZ3xGWEEtx9KYsxsHnegauLoX7dWlct08v3?=
 =?us-ascii?Q?huMDNHLNUEkhfRCPvcfrWoM7v4vSoMZOabnPV/PEC0YhXH4BYHJ+uZKAFgTk?=
 =?us-ascii?Q?ot6gzjytySlNUP0HJpficNXRoUv3EscTW+MUu7in6P+w+OqJ2mqyMOxZMClG?=
 =?us-ascii?Q?tK1kc8Wb4dICPNFzKO7DWRqIlXl6LnfOpxVpA8l79hlUdAs/8PgmbpSWNaS1?=
 =?us-ascii?Q?0uPBDU/8/9YR5G3+GTVF5mQ8jNW3mGFSRB30pm4vl0YLKKHLfcDO1HrkGX7p?=
 =?us-ascii?Q?zOPkZqiWMZ31baoLYUa3xj94TNJn9XcQ49POzPyJKtfLkxzX8tq/xFmBgxTX?=
 =?us-ascii?Q?jGCyDC+zgv6aEA4j1tzPTOgnOkJrerT3tQeJN7wHYu6F8M41k7l5YbgZ1FHt?=
 =?us-ascii?Q?7/iXIqDU53PQNLY+j/ogeTEcTsBOz7PL7rKxZFD4vbU2B33YQzML3Lp6OOW6?=
 =?us-ascii?Q?rYAAhLreGnPgHxh1TfpjCsuMQq3TsTmRidq6VGxGC1D8fjit0iKAOkrXow3g?=
 =?us-ascii?Q?pn/caCTiLrAWWJ5Kg8oGeQJ2QElN1bIQbbyHN014b9dmQcDfdqQGBr+NEDTY?=
 =?us-ascii?Q?nJMGk6krODKTFrE7ueD+agIH0OTGfmAt0qvIMXZ/hGKHMv3x+cDS26bC1a/5?=
 =?us-ascii?Q?AJGIn2XXap3naWgHskUuuptDP4s9WdGsFRkLxLECb9FM9v4VvrF86d7gP3rS?=
 =?us-ascii?Q?UV8jdyf5vOBSgjB6xd5bkzbvczKBh+uPI7TM5GXrLtZVA/SCibI7QqZC6GdG?=
 =?us-ascii?Q?nZ/gDDxrpaYyjiYqoIeUNfwylQJkuVOh/Plqx81lmvQQ1nCcfjlS6nTmeOjL?=
 =?us-ascii?Q?0xI/4O/u+L7PpV9qG+Ff8mtYPujXKdV5PhvTiBr8WFpBBGzqPoOaMrl5T1Ua?=
 =?us-ascii?Q?a2bwc7Vxej4LTT08A2ofJLvuuiyW2xV+I9Mvp++wRvBZ0agh/St87jwEE0lx?=
 =?us-ascii?Q?0URw20c64rWEtVT4uzTIx8DZMPqFEzHHpg5hVdly9xGbEIlmJrP0ijzc+E7S?=
 =?us-ascii?Q?W76kfnLs74FZgM22bQwEz99cl8s7iQ4rv3f/eqGshA0k1QVk9/PyISFMmLQW?=
 =?us-ascii?Q?ns9vS2NPtrPezsl3mjNuobCRBOEYgEUDWH8i8aVh6cicw9nq6sjXb8/BheDl?=
 =?us-ascii?Q?RtqaW4TBOr7pRmeoOgi6cY4sgMNsmnQ4RK9O21r1nw7+6zfZUA0vvgNIpg93?=
 =?us-ascii?Q?5ODa5tlCqRe9w0VcLIuy9wNYw8kQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:06:02.0922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bcf5f3-741e-4697-21ce-08dc8410f9a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380

From: Shay Drory <shayd@nvidia.com>

Currently, if teardown_hca fails to execute during driver removal, mlx5
does not stop the health timer. Afterwards, mlx5 continue with driver
teardown. This may lead to a UAF bug, which results in page fault
Oops[1], since the health timer invokes after resources were freed.

Hence, stop the health monitor even if teardown_hca fails.

[1]
mlx5_core 0000:18:00.0: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
mlx5_core 0000:18:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
mlx5_core 0000:18:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
mlx5_core 0000:18:00.0: E-Switch: cleanup
mlx5_core 0000:18:00.0: wait_func:1155:(pid 1967079): TEARDOWN_HCA(0x103) timeout. Will cause a leak of a command resource
mlx5_core 0000:18:00.0: mlx5_function_close:1288:(pid 1967079): tear_down_hca failed, skip cleanup
BUG: unable to handle page fault for address: ffffa26487064230
PGD 100c00067 P4D 100c00067 PUD 100e5a067 PMD 105ed7067 PTE 0
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           OE     -------  ---  6.7.0-68.fc38.x86_64 #1
Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0013.121520200651 12/15/2020
RIP: 0010:ioread32be+0x34/0x60
RSP: 0018:ffffa26480003e58 EFLAGS: 00010292
RAX: ffffa26487064200 RBX: ffff9042d08161a0 RCX: ffff904c108222c0
RDX: 000000010bbf1b80 RSI: ffffffffc055ddb0 RDI: ffffa26487064230
RBP: ffff9042d08161a0 R08: 0000000000000022 R09: ffff904c108222e8
R10: 0000000000000004 R11: 0000000000000441 R12: ffffffffc055ddb0
R13: ffffa26487064200 R14: ffffa26480003f00 R15: ffff904c108222c0
FS:  0000000000000000(0000) GS:ffff904c10800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffa26487064230 CR3: 00000002c4420006 CR4: 00000000007706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 ? __die+0x23/0x70
 ? page_fault_oops+0x171/0x4e0
 ? exc_page_fault+0x175/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? __pfx_poll_health+0x10/0x10 [mlx5_core]
 ? __pfx_poll_health+0x10/0x10 [mlx5_core]
 ? ioread32be+0x34/0x60
 mlx5_health_check_fatal_sensors+0x20/0x100 [mlx5_core]
 ? __pfx_poll_health+0x10/0x10 [mlx5_core]
 poll_health+0x42/0x230 [mlx5_core]
 ? __next_timer_interrupt+0xbc/0x110
 ? __pfx_poll_health+0x10/0x10 [mlx5_core]
 call_timer_fn+0x21/0x130
 ? __pfx_poll_health+0x10/0x10 [mlx5_core]
 __run_timers+0x222/0x2c0
 run_timer_softirq+0x1d/0x40
 __do_softirq+0xc9/0x2c8
 __irq_exit_rcu+0xa6/0xc0
 sysvec_apic_timer_interrupt+0x72/0x90
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20
RIP: 0010:cpuidle_enter_state+0xcc/0x440
 ? cpuidle_enter_state+0xbd/0x440
 cpuidle_enter+0x2d/0x40
 do_idle+0x20d/0x270
 cpu_startup_entry+0x2a/0x30
 rest_init+0xd0/0xd0
 arch_call_rest_init+0xe/0x30
 start_kernel+0x709/0xa90
 x86_64_start_reservations+0x18/0x30
 x86_64_start_kernel+0x96/0xa0
 secondary_startup_64_no_verify+0x18f/0x19b
---[ end trace 0000000000000000 ]---

Fixes: 9b98d395b85d ("net/mlx5: Start health poll at earlier stage of driver load")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 6574c145dc1e..459a836a5d9c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1298,6 +1298,9 @@ static int mlx5_function_teardown(struct mlx5_core_dev *dev, bool boot)
 
 	if (!err)
 		mlx5_function_disable(dev, boot);
+	else
+		mlx5_stop_health_poll(dev, boot);
+
 	return err;
 }
 
-- 
2.31.1


