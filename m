Return-Path: <netdev+bounces-135520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A750599E2E2
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380EC1F23610
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC051E0DB0;
	Tue, 15 Oct 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tEvUf7bT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2339E1E3796
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984810; cv=fail; b=pRqV1Zakxv7n5bovDYyQy0wVldEQ+/pFH02DTagXs6Ksr6YRAeCLd26P2n2YA/6L0p/ttMrAkrrYfs3F1l0hbJUg84AQEJ+kdRQle0inEA7Oppw87vluRseLT8S8Ijz1Hx56ouJYnpJMXltel4jm5OK5GgATSoJtGyDifopW3ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984810; c=relaxed/simple;
	bh=5SpAKHEu1C8CJ3OByvrDyaeojkyDTkE1RxfgU4dhBzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8lO3tuUdZaVFPIpB/ZYqV2EUwgjUzMkldy+UGJijoejZOxFwrEUeAELBKD34+vBHJGzXqaFRhbd9pT3cYkAvuGX0FYEdFivzXS5BuXiY2YoqPxMAMTA2jUGFsJmoQXLx+oN3eGBMyIYMGzUQrWhGWIhX5wdeC3EupfkYFoauyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tEvUf7bT; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7qFwPyBYtTcfR2JDaqqE5ITYRTXO8r2pe2OaSs65DQktvrAzt02fku5NK1+2R1FMaTGSf2F5UsRGT7O2cGmyT/tcNYplYlY5ULYAw2g10iNNPIRG5u+7W1vYvTV+sRzSbrUEmkgUhbrx8e10f1AyQRVqvgLlM3cSuaS/jpwTKYj086VvCohWx7YTfP0aiYl2S3V57FQ+doX/R1l2KkQLMJihpKnhPO4jPvNMkQWvLPMIw4NbNbAGnrFcCIzFQF6sfXnnpiZliYVbZMat61k0G7irn3bMyQNzuewvb392YFnB4R7k3sUV90D6u69xZoUOmFPW5eJ+/99Shque/Kmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vy4nE7HIIcXC7o6mulFfTE90fexUD+/ES/V0qjTOnqw=;
 b=xi1UNdqXZEDWZYwkNtnS0WaLfQzBr8ik1c2/NlBENJCtqeENsmpFZN+xik3W5A9CL7fLvvGS63ScMRFiCseUHrwWVUhSFbHcgvui9EV5euy61tp1Z1rudJW/of/T71gSyMsyxKBrABYL1q+KaZOSa0ytXhf5l+NOQQsHyocQZEq2RhsQdOOZcrHynGKxqsP1mPyhftXe/8cCiFcFHQxVg0TQ2OXb/5cep6sB3oJWL4ClKsxR3MVzOLxe3h8x3LS34BxkhhZWtK5a4WYc/dJwDGuW36edjtzG5DTCa5ukJuu8jWuPCnVG7Rvc15THDoXrVLfXwiHp3FKZWaqZpZZmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy4nE7HIIcXC7o6mulFfTE90fexUD+/ES/V0qjTOnqw=;
 b=tEvUf7bTZ89m6ZTgifEGkJdpoHi/iYD2QrlGN0tEXUpNi5AF79kWtKeBZQI1NOVHU9GzSuHqaKMntlFIMkSFIIoU7bEy0RtQduasn1kQn4C6cwNhfiaZ2dWFui82eqdIxl/eeJHxUoBPp9Lrj1av0R8VAGYGZ2HN0wZ73RrWPdC2fgKhKS4FAKHW3QUyXTAhFsSWlPOIEgj5jopJTrAY4n1JUeku2MmPnA/IsUEptwLgeOBXW2uJT3Pkl3ybxD7nl197Zjum3wGVS99zUsLVWgDVgadGA9NuJQnj7WF4Uacrdm44PHiZmVvkRr0gfSuC+G9Dc6XRSh/E3rK+vejQwQ==
Received: from SJ0PR03CA0343.namprd03.prod.outlook.com (2603:10b6:a03:39c::18)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 09:33:23 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4e) by SJ0PR03CA0343.outlook.office365.com
 (2603:10b6:a03:39c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 09:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 09:33:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:33:08 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:33:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 15 Oct
 2024 02:33:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 6/8] net/mlx5: Fix command bitmask initialization
Date: Tue, 15 Oct 2024 12:32:06 +0300
Message-ID: <20241015093208.197603-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: d395e572-58e1-4237-98c8-08dcecfc69df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0yCXKTckXaBoN7CY8L5lbxDPz7BtDEp/+UO4nQhj9kN7Gaz9ash+ifN3AdF6?=
 =?us-ascii?Q?OMS/Rg9Zh3OPfZI34BeUOjHJD5npzngGSsT9o+QTxQJPJTVBQyLcqDBj5nJz?=
 =?us-ascii?Q?R8Xj1hzWrEz5vmgPmUhPSF/eq3hHEXveCKI3wFJ67m8eNm67gGMRknCfh0sB?=
 =?us-ascii?Q?zrPZh1Viaq4845xJC3Ff45U8pCe2oWnZJQ5uqfki/EZQQfOB3OZX3iryDcQK?=
 =?us-ascii?Q?H8yA6+WxzNmrvuoFkfBQsMna1apMpk3RtNf3dUGARjrvJ4CbeW/kGmrtkmO/?=
 =?us-ascii?Q?AHvYrh7/3QOdJxJfaGCBs8mpJsprAYWL8Zh+frT82l3GzZcZf2pbIsoJMDrb?=
 =?us-ascii?Q?FN4cOcmDoDlJGg8V6sr5ckBktui1FYSFNrYVfZw1Bre6kao1bpcXHQTROl7m?=
 =?us-ascii?Q?R7+VFv7v1hpSyXxbQan07fqx8zvZ9uqYxxiEa5bqZWAwRzobSxV08vPdDJ42?=
 =?us-ascii?Q?+uxfRboytVfeM3Y+UU45wAy6QLYMzpjKpdBhEmyBRRxQhG8z2PeVFj1783i4?=
 =?us-ascii?Q?Gj1kROVM/WEDmiB7iWqcI7apcgxO2U5t2RcgtLO4D2k7Qx/oXL6Nm1NoDjO+?=
 =?us-ascii?Q?v0MxjuEvbXH6uf+C2y4qDSaHhQskqaQUYdQZPRu8hzjHqIrtSVyjPPl/6uDI?=
 =?us-ascii?Q?zoZef6UT+sI9nJDVZoIMxwE3Pmaeq19QnBkM/IhaNUxwmiIXF45Upul8E5f+?=
 =?us-ascii?Q?vhp1D/wlkYdm0qTj+wuxvMFzjKWPnYZ+TXUQTtECd1d/xn4VILzdN2i7xgDe?=
 =?us-ascii?Q?/tSJDPowp2BIKy0MvkQG5RF48clzbd1q95ubptgUD4W9HJkClZKeI8PYm2aA?=
 =?us-ascii?Q?ZPkwh6XM0sgQn2ZwU96hahD07o/dPb/vRmxfMGbN3y9XEzyJ/X/c7DBzu/kx?=
 =?us-ascii?Q?55XONbptpAO1kdQGsFBKSY6mO98+qvToeR6ia7X8eiBGE0Jxlk9ZrsiNcv5i?=
 =?us-ascii?Q?dNzrM4enhN6s3pOoW9rXXjj6QJnSk8a+QjNIpNkDeaMBa+SHnbsJcFDyO7fo?=
 =?us-ascii?Q?VQvMvd6/kwXgy1nbRyo1DuNHigpKS4gx6d+vasL4JgUFqFRjaWeYx4xtZkqW?=
 =?us-ascii?Q?7EyybMVNA+EE8AZrc8wcfUxp2cq9WpG+86sOTUgWOLfjS8RPcMm1Zf5/meiA?=
 =?us-ascii?Q?k+SK2qDc6VpZRFcwYdh/sN+xpVSoKi4b+JmrTM1yLx0Fu6ZBOxLRDVB5/tvP?=
 =?us-ascii?Q?KkumX/x1/JkQ3JknO4ZY0WCHeibioUuu7SUNKSgNa/1p07+0ZZghTLddonPo?=
 =?us-ascii?Q?jNC0km4eRIER3FmS6Rbhv1DsK/eQMwHVryZY3dBSsGED2cr9xTGX6pEtrgWs?=
 =?us-ascii?Q?XOjW+XAiQecRaMzJWgIxMeZ4QN+0aNq/zIH9oi2QSzgZoCDeMkRHDAQznUeP?=
 =?us-ascii?Q?o/nEJecCKQkO32QdlOWx34D+txwm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:33:23.0536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d395e572-58e1-4237-98c8-08dcecfc69df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165

From: Shay Drory <shayd@nvidia.com>

Command bitmask have a dedicated bit for MANAGE_PAGES command, this bit
isn't Initialize during command bitmask Initialization, only during
MANAGE_PAGES.

In addition, mlx5_cmd_trigger_completions() is trying to trigger
completion for MANAGE_PAGES command as well.

Hence, in case health error occurred before any MANAGE_PAGES command
have been invoke (for example, during mlx5_enable_hca()),
mlx5_cmd_trigger_completions() will try to trigger completion for
MANAGE_PAGES command, which will result in null-ptr-deref error.[1]

Fix it by Initialize command bitmask correctly.

While at it, re-write the code for better understanding.

[1]
BUG: KASAN: null-ptr-deref in mlx5_cmd_trigger_completions+0x1db/0x600 [mlx5_core]
Write of size 4 at addr 0000000000000214 by task kworker/u96:2/12078
CPU: 10 PID: 12078 Comm: kworker/u96:2 Not tainted 6.9.0-rc2_for_upstream_debug_2024_04_07_19_01 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Workqueue: mlx5_health0000:08:00.0 mlx5_fw_fatal_reporter_err_work [mlx5_core]
Call Trace:
 <TASK>
 dump_stack_lvl+0x7e/0xc0
 kasan_report+0xb9/0xf0
 kasan_check_range+0xec/0x190
 mlx5_cmd_trigger_completions+0x1db/0x600 [mlx5_core]
 mlx5_cmd_flush+0x94/0x240 [mlx5_core]
 enter_error_state+0x6c/0xd0 [mlx5_core]
 mlx5_fw_fatal_reporter_err_work+0xf3/0x480 [mlx5_core]
 process_one_work+0x787/0x1490
 ? lockdep_hardirqs_on_prepare+0x400/0x400
 ? pwq_dec_nr_in_flight+0xda0/0xda0
 ? assign_work+0x168/0x240
 worker_thread+0x586/0xd30
 ? rescuer_thread+0xae0/0xae0
 kthread+0x2df/0x3b0
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x2d/0x70
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork_asm+0x11/0x20
 </TASK>

Fixes: 9b98d395b85d ("net/mlx5: Start health poll at earlier stage of driver load")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index a64d96effb9e..6bd8a18e3af3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1765,6 +1765,10 @@ static void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool force
 	}
 }
 
+#define MLX5_MAX_MANAGE_PAGES_CMD_ENT 1
+#define MLX5_CMD_MASK ((1UL << (cmd->vars.max_reg_cmds + \
+			   MLX5_MAX_MANAGE_PAGES_CMD_ENT)) - 1)
+
 static void mlx5_cmd_trigger_completions(struct mlx5_core_dev *dev)
 {
 	struct mlx5_cmd *cmd = &dev->cmd;
@@ -1776,7 +1780,7 @@ static void mlx5_cmd_trigger_completions(struct mlx5_core_dev *dev)
 	/* wait for pending handlers to complete */
 	mlx5_eq_synchronize_cmd_irq(dev);
 	spin_lock_irqsave(&dev->cmd.alloc_lock, flags);
-	vector = ~dev->cmd.vars.bitmask & ((1ul << (1 << dev->cmd.vars.log_sz)) - 1);
+	vector = ~dev->cmd.vars.bitmask & MLX5_CMD_MASK;
 	if (!vector)
 		goto no_trig;
 
@@ -2361,7 +2365,7 @@ int mlx5_cmd_enable(struct mlx5_core_dev *dev)
 
 	cmd->state = MLX5_CMDIF_STATE_DOWN;
 	cmd->vars.max_reg_cmds = (1 << cmd->vars.log_sz) - 1;
-	cmd->vars.bitmask = (1UL << cmd->vars.max_reg_cmds) - 1;
+	cmd->vars.bitmask = MLX5_CMD_MASK;
 
 	sema_init(&cmd->vars.sem, cmd->vars.max_reg_cmds);
 	sema_init(&cmd->vars.pages_sem, 1);
-- 
2.44.0


