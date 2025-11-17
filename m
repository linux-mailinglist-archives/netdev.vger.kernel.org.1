Return-Path: <netdev+bounces-239108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2AFC63FC7
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DDAB3570F6
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5D232AAAA;
	Mon, 17 Nov 2025 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qynB10xD"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E7257854;
	Mon, 17 Nov 2025 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763381194; cv=fail; b=cvACiH+FGzq54pZL0RJLQ98R/ZOyB3J7EPuF6McyFh0uYdr1vY7H0Il960RzoxEWJbxHjIGy7MsSaeTUyzZd9juzsxKdQMms3pc1eY7obJBb0+Nc9R21izZoi3y61eUAvFvMZx03zDE3oGzIUHte0kXCuAlivpU9WNMu9sGRry0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763381194; c=relaxed/simple;
	bh=c8VGx/z3Fj76opqXA7sbeVXBMk/LL2s6nJDhAIayVRo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ONc6wDvBmOWRpkm1GN7zaz0snf3D0XXpX3YavGoKmxCqAvrvZ49DoRaXJImu+2rgcIA5iRLUZP58vney0JaG3b+U6ptmy7JPCfybu5d3OQWRrzhi6m8ku3Su0AZhA3WPMno8WysLXmMO45TlZGV6pMwfi3aDc16M5B5Voi70OL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qynB10xD; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiCtIv0t2U1QraZqXNzFDnhxBV++QgsUVhE95+/WcJCXz3IH1g/Rq+CFshvId5ZZANxPRaQ8BAazXlFc3NyRz7sJo7skLuupKil3c0gMNo1cQ5Iaxs6iO1pctZyP/4xkkw8bvSpCi30JYBLwVenkG9H9SFJlM0J0REbatCjs6HbOiEgTt83cHgvS9OxmTIEvdt1OungncLzM9I0JRkPOHOTGgSsMgzv7jPWaE2We9ucrFU+dLcGYd8BUlp2zOxa5kwowJBlBS8heVt+olCcmC+Y6KpEITN5S0mt0SnQEZi2f1AaPZ5ZC4f7hNIWyX/SxDi9+AR33slaUoBUK/0myQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPhLmZbAskiDoBx3ZXR/UlrHQfnrrVgJae+1X6q4+a4=;
 b=dePPpfnCHwjKj48DD8AjmSbnUBORRaoyIs10WFLwga2cfnBpYoiE7S6Dj1g4dfIl0Pk5PJ5FNutTx97T3QhKy6Ca9p+6tfaXtbLrc+7Uq/tkRIwdYbfh2bKjs03795y1V3g+qAvhexlY2RAANddx9ZjF5CyIMEuzPUXEUHoMVlVK5ntBb0Wrp1SIyj8MIQiDNHu0GP0UskVQ0tbDuZq8sJk7qoU5iVMpGdSF8PPaQGDEgwfm0Fs1Q39F06J7y3JWqgDF7YXgB9cmz3ORz7FdbWqD4mK7TKywsLGrWIDTaCm3gjVFljrL8IX7+CXT2H14U1rPMebUUVBhBOB0HvHuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPhLmZbAskiDoBx3ZXR/UlrHQfnrrVgJae+1X6q4+a4=;
 b=qynB10xD8LvY3F1bR31snRHZN+r9jBR1+g+e2KmQzZuxI9inC/QPj6HcFeVAGcc1LkPnT6r+x56+iC0K8yehBdrKnh4vVrCdp1s1cr3bjHu/w3R5LXCc5JvS/BcZ9kIotZLunDP/0MJ/L/e7qUrexPlRJ5IVSZ91ZLcBBSYmVxKGu5aHvCs+c3scItQLObQ1+GWhI3kTzR26Pegsk1B99yNazsQXhl4NzXRtwioLN5Ct2poRT/IUailR0eN4P8o2DtERzV7QSopV8nRxo+xSJS069yxscXrXiPx82jLE9gP71Z0CM5EidImZZjrGWAG5tnXHwDUwuUf4ZsPkpgEYtw==
Received: from PH7P221CA0059.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::29)
 by DS4PR12MB9793.namprd12.prod.outlook.com (2603:10b6:8:2a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 12:06:28 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::48) by PH7P221CA0059.outlook.office365.com
 (2603:10b6:510:33c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 12:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 12:06:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 04:06:08 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 04:06:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 17
 Nov 2025 04:06:03 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2] devlink: rate: Unset parent pointer in devl_rate_nodes_destroy
Date: Mon, 17 Nov 2025 14:05:49 +0200
Message-ID: <1763381149-1234377-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DS4PR12MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: b99df5e6-66fc-4693-75e6-08de25d1bcaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TAaLHVqUc4GcR7vvFGYTd+3rX7oUCAlIyi5n7U72nSGp4CHSjV0NesxGJf/V?=
 =?us-ascii?Q?MD9vaXtxgdL++PgYsjmLZqygKR+ycaFzZh5TLLfntUarGr/tSH1rWdI1j3By?=
 =?us-ascii?Q?BGOuw+Vg164hnTyQ7KjBS9sOI7IPucu0Se+QZATNTfHlmPx4J+NtB2ruUp2h?=
 =?us-ascii?Q?WNGT1mjk/vXARgM13ZafbBbfngMKLqciJ7bhiTIiiIr2jS2j4IBReE1cWy1c?=
 =?us-ascii?Q?Mz7LFmSXqx8jqxyEvcbfM6MW2dh6yppFDj0PhTbFWnHyUvflXi7f/pd7sJwk?=
 =?us-ascii?Q?WaZITfZpn1Shl0VA6t4PwIR10C/liHnc8Gg3RlLQ2wpgjBAZuxC/bapH/C4m?=
 =?us-ascii?Q?ZJlVipadhheTiJPPV2fhsXGn3UDyybGesEhDrWeSaJD2UYi52AVVXrZJaPkL?=
 =?us-ascii?Q?gdpEj22h2QR/nhNDyiv0tVvY5ygXrKGKJUjmwFtDV+mS6MPxoms5VYdAq6Oy?=
 =?us-ascii?Q?TPKIo8PK5etxd7KR1i2AE6xY3iodrOnV3n1oADYDBZYWPiCUumDw8Ml2gqoP?=
 =?us-ascii?Q?Eajs5BO5kRL3/jVcKbONHNGJnUPBVERTSE6of60Cz+wZzs66UnQn33OuN4wb?=
 =?us-ascii?Q?jeM/cXQHz48ylOZOwrVAmrJ/uOj8/VLFUb2Y/cUM6kMNn7xhfDDrLwnNNQnB?=
 =?us-ascii?Q?SQtJvzP76CMzxLoJvJIENiKpLwHNZTGVgYAPuURNlxpL7MRB2Jav1TcfONJ7?=
 =?us-ascii?Q?NXXiBsR5KShFFs5AFhb/SesOONuVSfoM3o/G3yv0Ax42ypnT6Jugq9KiCvb9?=
 =?us-ascii?Q?aVcomMHN6XBvCFEJN0v8GrMQHXj8Fl3iZBU3NTnpau9lt7tSwfVNp/fXIf33?=
 =?us-ascii?Q?QdeOzjmnZb571hcE2J84bqL0zwXBgR5p7EHWyxA7bAhy0qHUAned3dOlp+XB?=
 =?us-ascii?Q?QMI+Wrog9ezqQlUjFIK93tJqiP77p8Ae+gMwdYbQsC+YFgT4yH4han8mnACM?=
 =?us-ascii?Q?nZAgLMdkq8djuerM1ss6G39i3HeMihE22h0pcZR79oA1uvRzCBU2HhIk1sdE?=
 =?us-ascii?Q?+JZBJQg9F24rc6okyIMJPw4sMOm8IRLtjf2/7XyjUitd1Hz5Sh4t74i4RA+y?=
 =?us-ascii?Q?uZQFkvBoOp+HCM/aheXGVvNCCb3KRpwgn5lpZVOzgYTrpV0fXXfqblGEfbE4?=
 =?us-ascii?Q?NEyrWITC7ptqsTlMo9fV52T981G/kj8rQQlRO1l7mC5CVXnnwBHzDMPkOpg4?=
 =?us-ascii?Q?MldQTxAvIo4KS6uL7qy/RNv9Y9DOyTVBeINPIDiUJWXMY1BZ4ZyUoYR1V0e3?=
 =?us-ascii?Q?cWFfeHy97L8Ja4OVXmCdp+w/291W6qucKE0ylhiSI6WkAcOVOwXNpQRLdCGp?=
 =?us-ascii?Q?ay+DQohWPlWHnunNSt5Gu95Ajid9P1797CJIyDgM8yxOTcW+OHa54+q6X20P?=
 =?us-ascii?Q?to/6anvSFp63NTnHviUfMsAwVoi3Z8ehAGYpWA+TrPBvYG8UGiVGB8b+B5sN?=
 =?us-ascii?Q?eUdEp6fASLc64gEFh9cpXt3JidofTnfORAIM1CxU5/h6jWIQtnOCRW9RN0NN?=
 =?us-ascii?Q?yBPQbP2/ENb3pzUsyZEz9PzhFA1o8BGQy/HE77DIMRhB5bJJESTQmU7cGDil?=
 =?us-ascii?Q?JeSn2HAjB92ZrJDIv+8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 12:06:27.5494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b99df5e6-66fc-4693-75e6-08de25d1bcaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9793

From: Shay Drory <shayd@nvidia.com>

The function devl_rate_nodes_destroy is documented to "Unset parent for
all rate objects". However, it was only calling the driver-specific
`rate_leaf_parent_set` or `rate_node_parent_set` ops and decrementing
the parent's refcount, without actually setting the
`devlink_rate->parent` pointer to NULL.

This leaves a dangling pointer in the `devlink_rate` struct, which cause
refcount error in netdevsim[1] and mlx5[2]. In addition, this is
inconsistent with the behavior of `devlink_nl_rate_parent_node_set`,
where the parent pointer is correctly cleared.

This patch fixes the issue by explicitly setting `devlink_rate->parent`
to NULL after notifying the driver, thus fulfilling the function's
documented behavior for all rate objects.

[1]
repro steps:
echo 1 > /sys/bus/netdevsim/new_device
devlink dev eswitch set netdevsim/netdevsim1 mode switchdev
echo 1 > /sys/bus/netdevsim/devices/netdevsim1/sriov_numvfs
devlink port function rate add netdevsim/netdevsim1/test_node
devlink port function rate set netdevsim/netdevsim1/128 parent test_node
echo 1 > /sys/bus/netdevsim/del_device

dmesg:
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 8 PID: 1530 at lib/refcount.c:31 refcount_warn_saturate+0x42/0xe0
CPU: 8 UID: 0 PID: 1530 Comm: bash Not tainted 6.18.0-rc4+ #1 NONE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:refcount_warn_saturate+0x42/0xe0
Call Trace:
 <TASK>
 devl_rate_leaf_destroy+0x8d/0x90
 __nsim_dev_port_del+0x6c/0x70 [netdevsim]
 nsim_dev_reload_destroy+0x11c/0x140 [netdevsim]
 nsim_drv_remove+0x2b/0xb0 [netdevsim]
 device_release_driver_internal+0x194/0x1f0
 bus_remove_device+0xc6/0x130
 device_del+0x159/0x3c0
 device_unregister+0x1a/0x60
 del_device_store+0x111/0x170 [netdevsim]
 kernfs_fop_write_iter+0x12e/0x1e0
 vfs_write+0x215/0x3d0
 ksys_write+0x5f/0xd0
 do_syscall_64+0x55/0x10f0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

[2]
devlink dev eswitch set pci/0000:08:00.0 mode switchdev
devlink port add pci/0000:08:00.0 flavour pcisf pfnum 0 sfnum 1000
devlink port function rate add pci/0000:08:00.0/group1
devlink port function rate set pci/0000:08:00.0/32768 parent group1
modprobe -r mlx5_ib mlx5_fwctl mlx5_core

dmesg:
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 7 PID: 16151 at lib/refcount.c:31 refcount_warn_saturate+0x42/0xe0
CPU: 7 UID: 0 PID: 16151 Comm: bash Not tainted 6.17.0-rc7_for_upstream_min_debug_2025_10_02_12_44 #1 NONE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:refcount_warn_saturate+0x42/0xe0
Call Trace:
 <TASK>
 devl_rate_leaf_destroy+0x8d/0x90
 mlx5_esw_offloads_devlink_port_unregister+0x33/0x60 [mlx5_core]
 mlx5_esw_offloads_unload_rep+0x3f/0x50 [mlx5_core]
 mlx5_eswitch_unload_sf_vport+0x40/0x90 [mlx5_core]
 mlx5_sf_esw_event+0xc4/0x120 [mlx5_core]
 notifier_call_chain+0x33/0xa0
 blocking_notifier_call_chain+0x3b/0x50
 mlx5_eswitch_disable_locked+0x50/0x110 [mlx5_core]
 mlx5_eswitch_disable+0x63/0x90 [mlx5_core]
 mlx5_unload+0x1d/0x170 [mlx5_core]
 mlx5_uninit_one+0xa2/0x130 [mlx5_core]
 remove_one+0x78/0xd0 [mlx5_core]
 pci_device_remove+0x39/0xa0
 device_release_driver_internal+0x194/0x1f0
 unbind_store+0x99/0xa0
 kernfs_fop_write_iter+0x12e/0x1e0
 vfs_write+0x215/0x3d0
 ksys_write+0x5f/0xd0
 do_syscall_64+0x53/0x1f0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: d75559845078 ("devlink: Allow setting parent node of rate objects")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/rate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

v1 -> v2:
- Add repro steps and dmesg log (Jakub)

diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 264fb82cba19..d157a8419bca 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -828,13 +828,15 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 		if (!devlink_rate->parent)
 			continue;
 
-		refcount_dec(&devlink_rate->parent->refcnt);
 		if (devlink_rate_is_leaf(devlink_rate))
 			ops->rate_leaf_parent_set(devlink_rate, NULL, devlink_rate->priv,
 						  NULL, NULL);
 		else if (devlink_rate_is_node(devlink_rate))
 			ops->rate_node_parent_set(devlink_rate, NULL, devlink_rate->priv,
 						  NULL, NULL);
+
+		refcount_dec(&devlink_rate->parent->refcnt);
+		devlink_rate->parent = NULL;
 	}
 	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_list, list) {
 		if (devlink_rate_is_node(devlink_rate)) {

base-commit: 5442a9da69789741bfda39f34ee7f69552bf0c56
-- 
2.31.1


