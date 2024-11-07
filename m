Return-Path: <netdev+bounces-143003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EA89C0DE6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37D1B22F96
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75370216A15;
	Thu,  7 Nov 2024 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OcuzwhYa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76D188A3B
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004603; cv=fail; b=pn2Rg/l/sDbPhrYNUPPc+SSnnj5mPjizxDdfyICyZd20L87v3TJTqI8MXfQMtyGSFPGHx98dEvZerrTwwRi8P/UIVJQI25cWp8ix0BPRYjzVwj6sOvpQWfhW8+JQ4CdouBT2R+l0cA3+3rYIkenyrQCFqL7lX5MAv47+gvfwzak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004603; c=relaxed/simple;
	bh=puIXtdphxxbsDTqHgfVT8BF932fNMPD6fj4HUx2mzAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBTa6Vmdt7azwKWpC2tFhsf7jJRX5OmDBRcsd6FyRmV61SQEPYrw47UyI4uEHzNq06m8XMBRXtCUA7GeslhzWM1faPzv4nycFaqdY20F7eHLRBtykOWfyHUb/4wdiBWFC+ZuEegyRgb76vuM8Jx2zQOrNaukuMmrXOnbC3JIyvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OcuzwhYa; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzNGzPO8sQyyDQgkkL17VvBFXoRO7lgk4tDLJplwYpB4kWIGH/UHiuzytHpe0+YG0Evpd982iRiy1UTmmu52/r0KvgZ2oKok3ty/0E3lNee3Yn6PVD+1PcA2YLQEeczH6DYeMqi8yDSYA9SYl5Z0D94eN/W1LIYREIzM/v1NOiijyWCNN+BKr6+7e8S44jU3+cH3laq19d36rGPttqWdYGxv4IKKR/L3ZBQTClgSDqpBxWlo4WwuCmQIScICdiQO3Fj0ul9P6zxYMboKTNKS/ANJMT6SLEORr87vkZgkOc76UR11okxuIDWMnEGxF0mu404Q5jhAfMqWWTjnmWOjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKLzJ2tGpIkngK7UcKMABof9SofZxVGQBCea5MpGUO0=;
 b=o4tx719x1gHDUTCN+p9UD4oCC2Z1a7mnFVpf37CsYf6Q/GzDzcwUkfbU03u9x6CzYOoXjkfz7yzdERHjobFauaMEPojlXD+q+wyHHwilE0WbWpSYQ95S0GvmV7H5k4KpxLWuzClszbhHa4USyRwqqhB1iGgQ52KBq9iP1vpoxWOoMW8mdB2w+ZSVZYMhLEzubNNBve7yXRp6bQTR/wsef8cASI5ZUoD2YN0lyw/gGLr7/+GtPHMDdgzN8t5at8QRu/o3U3nrqgxO7ds20diNlOwHieE/1gx6lBTZJnYYGMqusoAwcdakADD6cvzYBPpSp0GTqwsp3Ywujj8x4KQFYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKLzJ2tGpIkngK7UcKMABof9SofZxVGQBCea5MpGUO0=;
 b=OcuzwhYaXRUu+lr+vIyAetMAHNFEeVZOFG7o8QlLe/aO7g+6KcW6SYBAVzxC0eaUsQvw2GTLKvpM81AzQNa/oMW8ofXBTxutYHzOt8ByTj0xcYHHZoiVvjuqR2R7pDgp8kDEt2+YH+vERPRGq2UZzsW5hn3Zd9kMF6RdGyjtnf6arm6GoBkYBPF5W104927ZUOPeZz9nwec9GWeKkCvQRKSwT0Harhyyci3KWhQKWWhAf4Qu/kTla6XjqXuWOqxWM99CRZ/+yrQrI324CvHL6HD0qAbqOl2ZbNJW48OPcFNfNP9nq+lQex0IVsZGm2z3y1VvdxOTlxt423rld7cXSQ==
Received: from SN7PR04CA0043.namprd04.prod.outlook.com (2603:10b6:806:120::18)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 18:36:36 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::d3) by SN7PR04CA0043.outlook.office365.com
 (2603:10b6:806:120::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 18:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 18:36:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 10:36:16 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 10:36:16 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 10:36:13 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Amir Tzin <amirtz@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 2/7] net/mlx5: Fix msix vectors to respect platform limit
Date: Thu, 7 Nov 2024 20:35:22 +0200
Message-ID: <20241107183527.676877-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107183527.676877-1-tariqt@nvidia.com>
References: <20241107183527.676877-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: f800106a-3933-4d9d-2623-08dcff5b1c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XVcpyPiDSS85TZRxTnPcmeNXkcK94rgBtjtk3394aJ8WP6P+FCOz35lKN8Hm?=
 =?us-ascii?Q?VVQZkznjETVbJSL06qBYeDv2vtECQ0CBN0kHtMSxJdVVmvsP5kQi+cMimSN2?=
 =?us-ascii?Q?3hQRBTS/1rOkW+icA6d3aZzAJ2U/9oV0dIIdNXa3P8CQ470RNxKY3bbTsRXv?=
 =?us-ascii?Q?MYJV3E8k79Hp67TbCc6Pxgdxaqk+E6iHdbZtAereaWwz+NOM67CczOPA6YQh?=
 =?us-ascii?Q?IuUxp5oPSQ9RjXKm1jsMlm2zCB03Af0XH33yXxGNVIXFr7XER1Z8GlMafyvz?=
 =?us-ascii?Q?Q5g6FOvlaWgdCqs6DyVFCJKaUicuAzrCNjP6pRxCLsI0Eq1+RDkoFiHuz1GW?=
 =?us-ascii?Q?qL7uPYsqXk9vwJgjCX9Qf2rZai1gmC6I7VOqTTBoy0SBo7RzVnzDTSpQYBzf?=
 =?us-ascii?Q?vbd2j9Mp3ufPzVBcqK7fOxsPTPCs/bJ+EqxGXoFAaLscGupy0m+4Q84zEvNC?=
 =?us-ascii?Q?qkSeMhqfMT1zaeekynSuwhQuh2Ikg8saH+ujyOtaGI7Xu0H71Z1ZUP8v31V4?=
 =?us-ascii?Q?7eRfQqTQo7Txi05re6Fu/vUvBES5lXZ0I9vcYIBx73/6x5rFpTnx3jkVOzD9?=
 =?us-ascii?Q?BQjTTKXSZFH+HYEg+JL+2NkxrQ2gOZ03GjNy/mTxtRF+2Q2YLM/zdIoJbWYC?=
 =?us-ascii?Q?Vd5iZDRcT+NlZ24wfcm9KgsB+V9aaXwU3wW0F/0ZRXw0KFUJTKExIvFovPAb?=
 =?us-ascii?Q?z+wzM9NgW1sHOJyzduVbjUH/GND5AIQMFnnm+HwNUa3XbTWJB8L5nREEjwz6?=
 =?us-ascii?Q?0mhWDnd9/un3LIDPhKO6pRnsgcABgsHWcidhkSh3ja/xYgeqqWNJJ7vvD5ip?=
 =?us-ascii?Q?I51mFuPJZaBGd/2ksKy72MI+zpPGf39MJIa3sXyItZ/ZWqGJYq29nFV03e/k?=
 =?us-ascii?Q?heLcI4UPR6Ri9OaPUzKWLWGoYesKtNsLyuMDX4xb5a/gNdoer0UUowWIi92l?=
 =?us-ascii?Q?HlW+voCTzHzZeTI2HnzTfYqMTKSGpAPMj3IFOPuSoU0SsSYC42sYAaoUGgeW?=
 =?us-ascii?Q?XJYnm1Feru+JViIwv3zhwkcBew6Ih14b+RvW95PINLXX5vdkq9DCVGJ5FSSL?=
 =?us-ascii?Q?VJU4MozVFlJ/d7x6Y7R7jQhLkIIY70yQjB7QCp3WHNXv96dH4PJ5+IDzRF27?=
 =?us-ascii?Q?O0oLzGpnTl3y4NUdRhcis8zZJeGTPpqa1WLsDEfwyXAQ+xVZHIb+6BE///tF?=
 =?us-ascii?Q?fBGTl/+6EIJsISlh5Bu/qI20S93BY/ydGM0CFNSYDr1lnYDhgt6wzm8ciSa7?=
 =?us-ascii?Q?J5AnvYI9RLTqam5O/95kzp/tL/PVN8L5Hh4b/ZwARP2SZFpQtNheHV3KTgou?=
 =?us-ascii?Q?Tt/EYiApag8ATDafTNDXrQKiq/+Qq3Z+YWFa+a0cvDbWCUZUNwWij0qO2p33?=
 =?us-ascii?Q?My8shwgnYsA4BFpkNPsq2GAfMc4UDlN0V/zJOkSeOvP+AHjwSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 18:36:36.2721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f800106a-3933-4d9d-2623-08dcff5b1c6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936

From: Parav Pandit <parav@nvidia.com>

The number of PCI vectors allocated by the platform (which may be fewer
than requested) is currently not honored when creating the SF pool;
only the PCI MSI-X capability is considered.

As a result, when a platform allocates fewer vectors
(in non-dynamic mode) than requested, the PF and SF pools end up
with an invalid vector range.

This causes incorrect SF vector accounting, which leads to the
following call trace when an invalid IRQ vector is allocated.

This issue is resolved by ensuring that the platform's vector
limit is respected for both the SF and PF pools.

Workqueue: mlx5_vhca_event0 mlx5_sf_dev_add_active_work [mlx5_core]
RIP: 0010:pci_irq_vector+0x23/0x80
RSP: 0018:ffffabd5cebd7248 EFLAGS: 00010246
RAX: ffff980880e7f308 RBX: ffff9808932fb880 RCX: 0000000000000001
RDX: 00000000000001ff RSI: 0000000000000200 RDI: ffff980880e7f308
RBP: 0000000000000200 R08: 0000000000000010 R09: ffff97a9116f0860
R10: 0000000000000002 R11: 0000000000000228 R12: ffff980897cd0160
R13: 0000000000000000 R14: ffff97a920fec0c0 R15: ffffabd5cebd72d0
FS:  0000000000000000(0000) GS:ffff97c7ff9c0000(0000) knlGS:0000000000000000
 ? rescuer_thread+0x350/0x350
 kthread+0x11b/0x140
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x22/0x30
mlx5_core 0000:a1:00.0: mlx5_irq_alloc:321:(pid 6781): Failed to request irq. err = -22
mlx5_core 0000:a1:00.0: mlx5_irq_alloc:321:(pid 6781): Failed to request irq. err = -22
mlx5_core.sf mlx5_core.sf.6: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0 enhanced)
mlx5_core.sf mlx5_core.sf.7: firmware version: 32.43.356
mlx5_core.sf mlx5_core.sf.6 enpa1s0f0s4: renamed from eth0
mlx5_core.sf mlx5_core.sf.7: Rate limit: 127 rates are supported, range: 0Mbps to 195312Mbps
mlx5_core 0000:a1:00.0: mlx5_irq_alloc:321:(pid 6781): Failed to request irq. err = -22
mlx5_core 0000:a1:00.0: mlx5_irq_alloc:321:(pid 6781): Failed to request irq. err = -22
mlx5_core 0000:a1:00.0: mlx5_irq_alloc:321:(pid 6781): Failed to request irq. err = -22

Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 81a9232a03e1..7db9cab9bedf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -593,9 +593,11 @@ static void irq_pool_free(struct mlx5_irq_pool *pool)
 	kvfree(pool);
 }
 
-static int irq_pools_init(struct mlx5_core_dev *dev, int sf_vec, int pcif_vec)
+static int irq_pools_init(struct mlx5_core_dev *dev, int sf_vec, int pcif_vec,
+			  bool dynamic_vec)
 {
 	struct mlx5_irq_table *table = dev->priv.irq_table;
+	int sf_vec_available = sf_vec;
 	int num_sf_ctrl;
 	int err;
 
@@ -616,6 +618,13 @@ static int irq_pools_init(struct mlx5_core_dev *dev, int sf_vec, int pcif_vec)
 	num_sf_ctrl = DIV_ROUND_UP(mlx5_sf_max_functions(dev),
 				   MLX5_SFS_PER_CTRL_IRQ);
 	num_sf_ctrl = min_t(int, MLX5_IRQ_CTRL_SF_MAX, num_sf_ctrl);
+	if (!dynamic_vec && (num_sf_ctrl + 1) > sf_vec_available) {
+		mlx5_core_dbg(dev,
+			      "Not enough IRQs for SFs control and completion pool, required=%d avail=%d\n",
+			      num_sf_ctrl + 1, sf_vec_available);
+		return 0;
+	}
+
 	table->sf_ctrl_pool = irq_pool_alloc(dev, pcif_vec, num_sf_ctrl,
 					     "mlx5_sf_ctrl",
 					     MLX5_EQ_SHARE_IRQ_MIN_CTRL,
@@ -624,9 +633,11 @@ static int irq_pools_init(struct mlx5_core_dev *dev, int sf_vec, int pcif_vec)
 		err = PTR_ERR(table->sf_ctrl_pool);
 		goto err_pf;
 	}
-	/* init sf_comp_pool */
+	sf_vec_available -= num_sf_ctrl;
+
+	/* init sf_comp_pool, remaining vectors are for the SF completions */
 	table->sf_comp_pool = irq_pool_alloc(dev, pcif_vec + num_sf_ctrl,
-					     sf_vec - num_sf_ctrl, "mlx5_sf_comp",
+					     sf_vec_available, "mlx5_sf_comp",
 					     MLX5_EQ_SHARE_IRQ_MIN_COMP,
 					     MLX5_EQ_SHARE_IRQ_MAX_COMP);
 	if (IS_ERR(table->sf_comp_pool)) {
@@ -715,6 +726,7 @@ int mlx5_irq_table_get_num_comp(struct mlx5_irq_table *table)
 int mlx5_irq_table_create(struct mlx5_core_dev *dev)
 {
 	int num_eqs = mlx5_max_eq_cap_get(dev);
+	bool dynamic_vec;
 	int total_vec;
 	int pcif_vec;
 	int req_vec;
@@ -724,21 +736,31 @@ int mlx5_irq_table_create(struct mlx5_core_dev *dev)
 	if (mlx5_core_is_sf(dev))
 		return 0;
 
+	/* PCI PF vectors usage is limited by online cpus, device EQs and
+	 * PCI MSI-X capability.
+	 */
 	pcif_vec = MLX5_CAP_GEN(dev, num_ports) * num_online_cpus() + 1;
 	pcif_vec = min_t(int, pcif_vec, num_eqs);
+	pcif_vec = min_t(int, pcif_vec, pci_msix_vec_count(dev->pdev));
 
 	total_vec = pcif_vec;
 	if (mlx5_sf_max_functions(dev))
 		total_vec += MLX5_MAX_MSIX_PER_SF * mlx5_sf_max_functions(dev);
 	total_vec = min_t(int, total_vec, pci_msix_vec_count(dev->pdev));
-	pcif_vec = min_t(int, pcif_vec, pci_msix_vec_count(dev->pdev));
 
 	req_vec = pci_msix_can_alloc_dyn(dev->pdev) ? 1 : total_vec;
 	n = pci_alloc_irq_vectors(dev->pdev, 1, req_vec, PCI_IRQ_MSIX);
 	if (n < 0)
 		return n;
 
-	err = irq_pools_init(dev, total_vec - pcif_vec, pcif_vec);
+	/* Further limit vectors of the pools based on platform for non dynamic case */
+	dynamic_vec = pci_msix_can_alloc_dyn(dev->pdev);
+	if (!dynamic_vec) {
+		pcif_vec = min_t(int, n, pcif_vec);
+		total_vec = min_t(int, n, total_vec);
+	}
+
+	err = irq_pools_init(dev, total_vec - pcif_vec, pcif_vec, dynamic_vec);
 	if (err)
 		pci_free_irq_vectors(dev->pdev);
 
-- 
2.44.0


