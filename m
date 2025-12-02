Return-Path: <netdev+bounces-243281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 749E1C9C72D
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 707CD4E43DE
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA32C3266;
	Tue,  2 Dec 2025 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lCf3XRNA"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F112C234B
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697518; cv=fail; b=N+BNFTzMWH4lIPr/Fcw19EXj9VYW0HUw+XPWFyE7Hflyve9EM+s1usrGbhyu5IYW9jbNAiqu7LTzAFcRPyCDR3Qly7oCOhyIYsGzqHTLVtfHR8iGH5U4LCtyiWZAwxliS/xaJUuQdDWrIzIvtkGF8J1Zz8qmpnICWx8R3UvVm0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697518; c=relaxed/simple;
	bh=UpS+12232EB1WvYmhKWV/CiykrE2tGIcWVNgQsTCWq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQejyOnFsHub+bRgb2+h2ourWBdoAO/d6t84HneadMWEZ4ShTR1fUf3rm508W10nk/g7nwVG1qANL/3DTA/59XTpK7W5UaEjfkOaoR7enVTpQiQA0qnK8qBEyQTNHpNf0usX4Sl1/FdkkEf/x7a2ZTfAzPNDHKbIPCQrODYdC2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lCf3XRNA; arc=fail smtp.client-ip=40.93.196.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqHkI3jQRh81Bk/5hkA0vDs4fSfm6lu6ZE7CB384Whrjwu0HXdp6+IQJSqKL7+KsCuXEgBV20Ldvi4uEtnoey2QZYAr5nH+JpOWTPzHcu9wCM0h7azGAVa8WVcmb/5TWWhHZ5pGNULW6vTOlnPcTyj4FEQe/fOb7QhTuOdYHDbTvwqGygLr1JVftvhSjptIYLRq9Ah/dfzO11atZjB5pr3ZOH1cgaSH5ic0SZcEhvnVjh1tO2Sn1vexmLI905Wx28tbTltIr6GfMsdQioNNWfVAmgSACqEUGDPOMrxTPMyS+En9dovexnldH4UFDyBGn8Ly41gFQsKvxhUqSKJEUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5Kj+otty/6U1ymYbkDosoAtiyr+4k8fdA5nOMvzzs8=;
 b=IbuIWuVVkhMgzbjM4ISAqGEmKGiEcsLb1L1AkQtXqeeM2gRM6A9P8T13QIPC9B2s4RGjREiyKea+HxACLP8Lm6q4hFjU8531sJMFCpXkPAy0M7WRkrQyXBlbG2wnT0IG0wk4Ho3avMJ98IVd0+Mop5DkCkZcNZWPV1fa21JcVLl7AuunRmi9pU4VyQsiYSYySZ/4CEzPzevmuUPA6W7XR86rYyiuWk9hHKRJagQ5LOWR+v/nf/wP8JZmEHw5zRJuP7Up1Bjc+YoxoSveKO5Ft3jiAFUmwQQddvpzViRl/HSoxnwsRgV43L8HAjKGC2AKKrZZbNaPrESb2D6KHiWGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5Kj+otty/6U1ymYbkDosoAtiyr+4k8fdA5nOMvzzs8=;
 b=lCf3XRNA9AaK1NEBcLb3uKYoOwH8py6eaxjeIldM2crPVOC+AILX4sxVMRtPZmIIQ6ATmGqDdXVlNW0uyMqXs4ueHAEDhUrz0F09JQsSknhwWeajjlnQ4dQf0OQaD5jsJnE2uWyhBraDjlgy+/DI33kcoSGEgi1Z9UiMzWmMiCABAcH/UhQvHGBYcOkxs2XNTECYxBUlA3kLw+85c1uOD1t/dxF8hDRG+oMpH//qNgNItBC53IYWG0Qb8aYEiBZKf7r/CQDFiHQCdJ4pcXEmEA8EppDhoAuU1P2GVUT3g21BrkyKio37wxPEnMybWyX2HMOAZrZGePzeOSQhIRO7kw==
Received: from CYZPR12CA0002.namprd12.prod.outlook.com (2603:10b6:930:8b::13)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 17:45:12 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com (2603:10b6:930:8b::4)
 by CYZPR12CA0002.outlook.office365.com (2603:10b6:930:8b::13) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9
 via Frontend Transport; Tue, 2 Dec 2025 17:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 17:45:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 09:44:50 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 09:44:44 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net 3/3] mlxsw: spectrum_mr: Fix use-after-free when updating multicast route stats
Date: Tue, 2 Dec 2025 18:44:13 +0100
Message-ID: <f996feecfd59fde297964bfc85040b6d83ec6089.1764695650.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1764695650.git.petrm@nvidia.com>
References: <cover.1764695650.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 563aa1fb-1c8f-4caa-dda0-08de31ca8b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Wc8BwjGQhXY5vEWfseA1bhNiTm2Nl6gJ7EnVUAu0AtcSIwoGQkpAxHeUR6K?=
 =?us-ascii?Q?IJxx50N3sRMKhuIkbLEb/2t7e8tTKYP/6MMCudMyM49NhEI1QG1x27UNyZko?=
 =?us-ascii?Q?R9DvSJmtHgmWakHE7nC545QKqbAtdPn2Ye+y+ze139drj1KHrq1JNXgReZOh?=
 =?us-ascii?Q?lCFR/bwlYRtOu1uCL/DGG1D+yAGgRhMfko/b284NYYrOILdZqGTgzwNz0oKI?=
 =?us-ascii?Q?bWetZyX6Sr660wrKAwvKxu3jm3xbaeSiMb7liPD6YsP3EeqcnoRp2uoIUHrJ?=
 =?us-ascii?Q?tIoEijVkb1uUQK3ehRiLk0awz5XM7YR6wSAH3YQxQJ/wkzHBm3qq9mzG8Y5U?=
 =?us-ascii?Q?ssWP3NZ4QKhMUQILPCw3XG/9MxNZrVBS6fmtzNd8WlSMaRXzza9cLSZZR/6U?=
 =?us-ascii?Q?R/QB4lbMzRf4WtXEiImwmWkz1oXRzJvjGSE1lXzm+SXTWS0dU4hfhzg3W8pY?=
 =?us-ascii?Q?YlRr1D/2Sj57E3wSU/S+d0vziTcH1QNSfv1wgyDzoytE8FQ/HmB2Yw/jPRuT?=
 =?us-ascii?Q?RvFDAFNSFwsHacY18MxhN6kaJSMwxU5448nHWkUzwjLEVFA+YLbWwHPV+WrT?=
 =?us-ascii?Q?JymwtK+CPtP3JUGuYR1hIS8pBUcrw9DFV+mwY88pl8Qd5CK2jsjbN6rRbYhI?=
 =?us-ascii?Q?dhfQeJH6g1nbi1X8znNzFnkkxzmsIbYiPkebENeR6tv4diZgvTfkBs832Y4+?=
 =?us-ascii?Q?vQ0Y1ZXEKwG+q/cAGi7OFDDlWlCT4HUhLuDD37LPdt1uUWYocEvXp6q9W52r?=
 =?us-ascii?Q?lrEU6fuA6Hb59u6+sNqnoPqFvnmqGj1LqMkpV38suPJb7Xrauch9gJuwOTa2?=
 =?us-ascii?Q?o553mvvOmzgdmEMR7xQNSNknvX/8Wz8ufA82tX2sYZRSfzuZ9y4fdQzT3QDM?=
 =?us-ascii?Q?Tukz0JkjOS1qlJo8TKUqHNitWFe6WOutVRzxgKmYFg66cUUydUklzbvsDbE3?=
 =?us-ascii?Q?12slnURjFTRkl/W/FspKXqxWq8PhEkolhiNC9U+2nx91tBFDA2l6pGxn+1BL?=
 =?us-ascii?Q?9RVAZ4JXn2B39AaA/Txu0+6oKaoSedJGAGxCqSUKcepT7h47FqEnkNz9K0hQ?=
 =?us-ascii?Q?LdVhXJV3ABYf/knU6edY77FEPC5g0Nkrw0b0FDoKa02gsEQgW1hzEWpnf9TQ?=
 =?us-ascii?Q?Y0MDFIwerD3bzFwQcx0isfE1VOOt2DgxbDnfXOoXxcRXEPy9mzEQS221dSl9?=
 =?us-ascii?Q?2NRgC0yJ/GGEgHMA/OBEV9P9RtSj5VtCb4aqiuYWfSWOGoM95qmGpfaUTg4I?=
 =?us-ascii?Q?8xb4nBmxtdbgZipDBXoWb3PYXKQyYrqQg4SxjMAFJDUIphJPRf7Yb406nmsv?=
 =?us-ascii?Q?y93ej9b3HuTYuxo/xD+6rgv/8Colr1KIJvVaNs1xTJYJI0c5AEsllU7jgLdq?=
 =?us-ascii?Q?kYbTi/tDEfT9g5UTsgU0NvSLSDl7O28YJYYwjaeQU4kD2gjNrZBi4o3PPt9R?=
 =?us-ascii?Q?UEKYgO48aTQbaPe4Gq7qrS1JehD6I8oFSCu1cvjOBIC3KqJkHe62g4LpMINH?=
 =?us-ascii?Q?J7SEPEZOJuK7wn5VRnv/r0zaicpqrFdbK42CnCrhepQLiucjVRnzPte4I2Kf?=
 =?us-ascii?Q?AbeIAS0GUbGQcnqSITc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 17:45:11.7824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 563aa1fb-1c8f-4caa-dda0-08de31ca8b0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939

From: Ido Schimmel <idosch@nvidia.com>

Cited commit added a dedicated mutex (instead of RTNL) to protect the
multicast route list, so that it will not change while the driver
periodically traverses it in order to update the kernel about multicast
route stats that were queried from the device.

One instance of list entry deletion (during route replace) was missed
and it can result in a use-after-free [1].

Fix by acquiring the mutex before deleting the entry from the list and
releasing it afterwards.

[1]
BUG: KASAN: slab-use-after-free in mlxsw_sp_mr_stats_update+0x4a5/0x540 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c:1006 [mlxsw_spectrum]
Read of size 8 at addr ffff8881523c2fa8 by task kworker/2:5/22043

CPU: 2 UID: 0 PID: 22043 Comm: kworker/2:5 Not tainted 6.18.0-rc1-custom-g1a3d6d7cd014 #1 PREEMPT(full)
Hardware name: Mellanox Technologies Ltd. MSN2010/SA002610, BIOS 5.6.5 08/24/2017
Workqueue: mlxsw_core mlxsw_sp_mr_stats_update [mlxsw_spectrum]
Call Trace:
 <TASK>
 dump_stack_lvl+0xba/0x110
 print_report+0x174/0x4f5
 kasan_report+0xdf/0x110
 mlxsw_sp_mr_stats_update+0x4a5/0x540 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c:1006 [mlxsw_spectrum]
 process_one_work+0x9cc/0x18e0
 worker_thread+0x5df/0xe40
 kthread+0x3b8/0x730
 ret_from_fork+0x3e9/0x560
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 29933:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 mlxsw_sp_mr_route_add+0xd8/0x4770 [mlxsw_spectrum]
 mlxsw_sp_router_fibmr_event_work+0x371/0xad0 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:7965 [mlxsw_spectrum]
 process_one_work+0x9cc/0x18e0
 worker_thread+0x5df/0xe40
 kthread+0x3b8/0x730
 ret_from_fork+0x3e9/0x560
 ret_from_fork_asm+0x1a/0x30

Freed by task 29933:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 __kasan_save_free_info+0x3b/0x70
 __kasan_slab_free+0x43/0x70
 kfree+0x14e/0x700
 mlxsw_sp_mr_route_add+0x2dea/0x4770 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c:444 [mlxsw_spectrum]
 mlxsw_sp_router_fibmr_event_work+0x371/0xad0 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:7965 [mlxsw_spectrum]
 process_one_work+0x9cc/0x18e0
 worker_thread+0x5df/0xe40
 kthread+0x3b8/0x730
 ret_from_fork+0x3e9/0x560
 ret_from_fork_asm+0x1a/0x30

Fixes: f38656d06725 ("mlxsw: spectrum_mr: Protect multicast route list with a lock")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

CC: Jiri Pirko <jiri@resnulli.us>

---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
index 5afe6b155ef0..81935f87bfcd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
@@ -440,7 +440,9 @@ int mlxsw_sp_mr_route_add(struct mlxsw_sp_mr_table *mr_table,
 		rhashtable_remove_fast(&mr_table->route_ht,
 				       &mr_orig_route->ht_node,
 				       mlxsw_sp_mr_route_ht_params);
+		mutex_lock(&mr_table->route_list_lock);
 		list_del(&mr_orig_route->node);
+		mutex_unlock(&mr_table->route_list_lock);
 		mlxsw_sp_mr_route_destroy(mr_table, mr_orig_route);
 	}
 
-- 
2.51.1


