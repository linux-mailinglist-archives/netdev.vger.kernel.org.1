Return-Path: <netdev+bounces-113988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E45940834
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072F61C2253A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E4618FDC0;
	Tue, 30 Jul 2024 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tRuCbFyd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ABD18FDBD
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320326; cv=fail; b=uKlBaXpQwg7+KcDN57ukp63ngQgDA/ArWaxxKewV6URF+K8x30k5FJhi7RmtFdL+SK3cC3WYWS2P95oXUMiFx6z+S1sKwgFC/wYXtfGZUlGrfJvpEURQO2+Sm/26i4T90/EXn+4QqBq5RqtH0bbvkpbAKPKRJ2Zx174DsnRcLfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320326; c=relaxed/simple;
	bh=rGHL2AePfhEbbleB0Lep/KUfziis+WLwvlkLNluZynQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eR804PteKGTmrdtotonFoSWs2j+Opts/RWLXZlrLtShddDutFtWh12ZPf4jWqDdO/5EtKIogtJwIhthF3sS7DrVxTAqibJ27tj9xajuOHmFSybtXGFuWivjAjX5v/LUqG7CWpsZOLG/TGSgwW6qz29uerfk4Z/sUZ6Oe3tNbCLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tRuCbFyd; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0XxJYDhVnpOmfRKgfID31FRK6LyPach7EVha9AAudEmx/zLZi+qUv8uGgDi5tN6d1oWZPIUgZ+rrRzyzNZ5htxYEfBmG9PJZwC4KbvEDJhEV+MtQaQAFN/wQPgnCZfedstMXr+BUBcGvf9Xcp00VevbDwTPYOycqGjz1Y/xgRrT/JM6wIF5diQKVsbdODVwgHfOyablND3MKzxq0omJmkK68yk3onfTamdrhMxPv34h5SYwbC30ifqrgqLRHr/NQdAJTmoKDTrSOkar+ejwTI1T3kDc2AEx7VuOCVuUsnRziCAnFhlCGmRr+UpbA1zi2sz8+1HcFiY7fSrxFv3haQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H6Wp8nB9sfU7QscxaNuf7Q/M5DrGNM0mw7Ao1iDIas=;
 b=XR8TAIuR2AvVj93EcEPHLnw/gS3hZ7LwKS5JdVHdX2ALGSbexCPQ9hC2xUnRyPluFq2T9C3OqYZIkR8ST3m2anZXjPQWJM1yF1j0DHYWeMofKvuJGNK+603vmY/9CK9wwXcZRLDUMRu26+tZB7RbWbFHEmbljJbs9pzLHqKguufETC8AxJL4M7MZ7OrDYfX+pt2PQ6mj3syKTf+63Jasiw3AhHEWNewecE5CLKHzCVATbQkGsJ6iWFUCNAUysKXZ0lJgH6aJxM8SlOnEOWijZkRUxKt33g/Fz3z25BqZvy3cfZ1QEDfv1jDjX/ju1AWvtxm/xcAPhD6efioIA0LGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H6Wp8nB9sfU7QscxaNuf7Q/M5DrGNM0mw7Ao1iDIas=;
 b=tRuCbFydw+s/f8hU4kwBuaY0u2OFrNr2C/dqUHuvvbENJYljn9xz9VncVuPD+o9GzY3B7dBzHh33DzkBQUlA8G1IyRP0xoraO8SZ3AV3/Sxd3NY2rFEl4weznnbWQIQQqaulJk8gDgR+KLkJO6I/XS0Idf/nJVfifZNK6ts7u2hrOCd+DtQlWnZ94xHsf4prs1lY+BnGv9kUxuJvRZugksQWuSAD2ZKYAEqpnzilYb7nNA0rHrVlVNXHCSEfJoPhgqHJgwlCP984oSjT7txtYTkelIFUXseESktlnegViXm6efNp7FCnEwzWDVUxkTqwv+74RAUtpXd9L4lYYeusBw==
Received: from CH2PR19CA0024.namprd19.prod.outlook.com (2603:10b6:610:4d::34)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 06:18:41 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::aa) by CH2PR19CA0024.outlook.office365.com
 (2603:10b6:610:4d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 06:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 06:18:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:26 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 23:18:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 5/8] net/mlx5: Fix missing lock on sync reset reload
Date: Tue, 30 Jul 2024 09:16:34 +0300
Message-ID: <20240730061638.1831002-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240730061638.1831002-1-tariqt@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|IA1PR12MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d4c2f0-37af-4883-2e00-08dcb05f74e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1k5dWFCVTFVdHZ1QTVHcXFQeU9SZFlNUGs1MkRkREliTkpwUmdTWmdSb3RL?=
 =?utf-8?B?M1gwV0JTV2pEVzFsbFdLQUU1djJaeFNwc0VVcGg2ZDZnc0x5enIxSlNUTXlQ?=
 =?utf-8?B?V29YUXpVdG80empQV3V1Z251T3ptRjBVNktSZUlPeFNLbXNMMFl1NTJ6ZnNl?=
 =?utf-8?B?VnJ5WlV3OWt5ejlQNkNaWUdrdDhUdkRremJtNkZ1RU1wTlZyeVc4S285WHBL?=
 =?utf-8?B?b2ZrVUg0NDkyYjVhSTlnNURMdldvVWdsc2FUL3IyeW5XR3BDQ3JCVG15cmhK?=
 =?utf-8?B?K090NXF4UFRvQytQWWhrTzdraTUwendHZjM5cW9SZm1TTVh0c252ZG1tdVlw?=
 =?utf-8?B?Mkl1a3VXeFRZN0NlUFZtYU16NnZxSmFVeVJUT0xLVm9WaUhYT29uc1J1TGFp?=
 =?utf-8?B?dlQyUFFPYjR5Znl4REE1eDB4SkFBL3BtQTJzQ3ZyV2tDRFVPaGIzQlJVYUlP?=
 =?utf-8?B?bHE5NVZtOXRZY1JKbGZnQ3hBTXZUT2YyNUR4bElRMElQYkFiQ0M3UjlRK2xq?=
 =?utf-8?B?Y1BpTmhGYzE1V1hiOGtkZi9ubldab2pMa2s5M0hTbFNWZkRsa1hQRVhNUnVx?=
 =?utf-8?B?R3hKcHJEMUNEeEh0Tng4dU9wVE5RZkRQcGQ2NjQvOEZLS0NDOCtCRkhuVTRV?=
 =?utf-8?B?M3ZVd2NKT001bWF4TVVhS2dNUkY4d0lXVUJSQzllZHBaYkdOSzNKMDI2LzFx?=
 =?utf-8?B?RHZGNzlqMncxeFNReC83WDB1Y2ZTdjJQU3YzYVZTeHlFSXdEdHRCczd3cHBl?=
 =?utf-8?B?R3F4R2REV3dBUE1PQXpOMjd2Y3pZQ2MrNktaWmhiNHphYkFBWnVESzlmbFdz?=
 =?utf-8?B?VDdjNk42YzhoZHFjTTJ1T3lVM0trbkV4d1QwZThEMU45K3Zld2pWUHZwNG5k?=
 =?utf-8?B?MGZxVlp1UVZOcW1VaUFhYnUxUnJVNXEwMTU4dE5wVjB1cURWVEk3eFppWkdB?=
 =?utf-8?B?MjNnUTRNdnBxS3Bsb1BPYnlYWW8zTC9zQ09vM2dGeWZwQ21YdFNwTldDTXdo?=
 =?utf-8?B?YXdpSVEraVNkS3JRemJVV0NjKzZFdENCQVAzM2NYSEFqdkNqMXZ3eEpaVzU1?=
 =?utf-8?B?bVp1OTM2a1FiNTY1bDJpNTVHbGUwTUUzSVk1Q1R3UWtoR1cxaGVVenU4elcx?=
 =?utf-8?B?MC9aajVtV0JBZ3V1N2hYNVJVem92b2Vud0F6djI4N0pFZzRZMkJpdituN1Jn?=
 =?utf-8?B?dHhvdy91MWUzRU94TTNGOWhaeERLTndvMEhpU1grNnVlU2JvcXhJdVcxc1JX?=
 =?utf-8?B?Njd2bDBvemJnc1oyQ2F5V0podWttTTBJeGRWNzVmWGNpK2Jwbjhwc3NCWlBz?=
 =?utf-8?B?cjJFaVhoa3U0d1lXNDliU08zcEl2QjNOL29UTjlIWFZmZzVsWExwZ2hqWG5q?=
 =?utf-8?B?YWpwWWN4enhYcFd1UW1LV1ZMNTZEcTNYcWFEcGRsQXlhNG00cDBUbEpXdVdP?=
 =?utf-8?B?NXphck9YQStpdDZyV3VHZEU3RWNtTDV0Z1VSd1BNMDl5NGZUcmJSQ285VGh2?=
 =?utf-8?B?dkVuOXg0MFV3WmE1N2NzMDdzbGVLT1Vrb1VzYWhIT3FZbUR2UkpQazJaSVJ4?=
 =?utf-8?B?QjNFSkNvNGx1b1VyZmdHZUJ2NU1hSW0xMFpRNWhmRzBla29LaUtGZUNvNFBl?=
 =?utf-8?B?Vkloalc4dUM2bzZNK3NNSHI4TXNvQ3Y1Q2pRY3p1NUFFK3RyakEwOVNlR2VT?=
 =?utf-8?B?SVNEOXhBbkhvSUZrQmV4ajEyaDN3UjVYMzNDWkRLVnRFdVI3TUI2T1BJcW9w?=
 =?utf-8?B?S1p0cGVYMUk3c1E1ZkVjSFFFb0tPT1cwNHVST0gvcHZEVjFXSXY4V0JrVEhY?=
 =?utf-8?B?SjNMWlN4UlViL2lYMERiQWxkWFNRVW44VGxleGVxSkttYzVyc2NyZlg1OVAr?=
 =?utf-8?B?K2s4YUFTZzRXMklHNjJYRTcwZCs1bWF1b3hhOW5oZ0dpUWs2QjJNN3dWbnNZ?=
 =?utf-8?Q?uD7SpfOB2Lgh4OF2Zron/TLssLpNBqiJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 06:18:40.8116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d4c2f0-37af-4883-2e00-08dcb05f74e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161

From: Moshe Shemesh <moshe@nvidia.com>

On sync reset reload work, when remote host updates devlink on reload
actions performed on that host, it misses taking devlink lock before
calling devlink_remote_reload_actions_performed() which results in
triggering lock assert like the following:

WARNING: CPU: 4 PID: 1164 at net/devlink/core.c:261 devl_assert_locked+0x3e/0x50
…
 CPU: 4 PID: 1164 Comm: kworker/u96:6 Tainted: G S      W          6.10.0-rc2+ #116
 Hardware name: Supermicro SYS-2028TP-DECTR/X10DRT-PT, BIOS 2.0 12/18/2015
 Workqueue: mlx5_fw_reset_events mlx5_sync_reset_reload_work [mlx5_core]
 RIP: 0010:devl_assert_locked+0x3e/0x50
…
 Call Trace:
  <TASK>
  ? __warn+0xa4/0x210
  ? devl_assert_locked+0x3e/0x50
  ? report_bug+0x160/0x280
  ? handle_bug+0x3f/0x80
  ? exc_invalid_op+0x17/0x40
  ? asm_exc_invalid_op+0x1a/0x20
  ? devl_assert_locked+0x3e/0x50
  devlink_notify+0x88/0x2b0
  ? mlx5_attach_device+0x20c/0x230 [mlx5_core]
  ? __pfx_devlink_notify+0x10/0x10
  ? process_one_work+0x4b6/0xbb0
  process_one_work+0x4b6/0xbb0
[…]

Fixes: 84a433a40d0e ("net/mlx5: Lock mlx5 devlink reload callbacks")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 979c49ae6b5c..b43ca0b762c3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -207,6 +207,7 @@ int mlx5_fw_reset_set_live_patch(struct mlx5_core_dev *dev)
 static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev, bool unloaded)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
+	struct devlink *devlink = priv_to_devlink(dev);
 
 	/* if this is the driver that initiated the fw reset, devlink completed the reload */
 	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags)) {
@@ -218,9 +219,11 @@ static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev, bool unload
 			mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
 		else
 			mlx5_load_one(dev, true);
-		devlink_remote_reload_actions_performed(priv_to_devlink(dev), 0,
+		devl_lock(devlink);
+		devlink_remote_reload_actions_performed(devlink, 0,
 							BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
 							BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE));
+		devl_unlock(devlink);
 	}
 }
 
-- 
2.44.0


