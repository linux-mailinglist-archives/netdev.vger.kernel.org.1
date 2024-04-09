Return-Path: <netdev+bounces-86251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ABB89E318
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC021F227E4
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C8F157E6B;
	Tue,  9 Apr 2024 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DZwUyobC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2874158A18
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689777; cv=fail; b=UMPz5vP7Y8DVT6Tm+giA4kP8sYgsmpT2vtlsZhsJi02u34z+OLhSkMXpLacEyjGM5KAxwlPXDO12PcJecixi42GluRcfBgt2D0GhoxIfVoJikn0G0P3yfgQ3UjCpWmbROWocgu4fciAQHFqzm8pmEIKssGy9D0xpzYYZi18hGZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689777; c=relaxed/simple;
	bh=FNTXBJHyKqGhgSS4tT/jIIL419Kx1SevzDJVIzTcMoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGc8n1VsQ5W2BteKcHrMIQxis1kL5lWvH5qtqTmxyQADWKepLjGmmqjcIuv/5QTOuilmafOShlne9xbeoeyXbbBbZuIsLUZ0DP99BR+cAd5DfRrIeUkFA8m2w5C8kvnAmqkMoVBsnH4yFSyw+PMPATkt/KkdKQWU1hql4OzfqDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DZwUyobC; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iS2H97fTkzmrQtIiRL+DqX7mbzRaEGzB/+btbx+LwHmQeyhRoIN5Z5kF6mc7NhBtXbTx+LvY3kOMVKPCvVy44kyI0nzLkYQjZHzsPBkqANWhC/2JUVd/tqwQ0xxViXpQPTcSXLcc5sKk0LaR5IvBh102E3Xj7QkZnubL5wcldJxaiiHkJeEyX5r5JMM1MXJ51BD9Vp+ZqBTg9RrjWKT3s6ddNVkRj9B1QqNGeGhzWjr8+4zANZD8B7vcLqd3yfOsYp6jo4FPVbNB/LigiJ3MURMxJpkFjmlu398IYbXdbCoBwJEHBjqiWI5ibmAjBuCi90eUFz6rW4MyAbDl0olD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrYU7qhD5C7Sfj+JoJkZMIImW5B1nGTsAhEKRpSMpTA=;
 b=UXgks5P0BKWCP5qzP8VGqGotTDoYUMGJ9eTCqFibv1mKx5f/VdibvH/KEzC9Vx5BXuV2gn6QxVpzyfQSTMdp17myDWwISEWeQ4wQrAMsyEST7hekXoSt+6TD8XY/TTdFKL3OU2sKvt2z4g2u64h7Pu10zXJactGm/EsGQWnD8Qp9NELZIv1c6fAJWwheoe5tYd3zV3mCbkmB8j2o2Fb43MCf0RbuNCG7IgZ5xPVAdMSOVsIgUnkn33b8mEjgwZG0sJm9TLfhDJ+Y0YbW7eUcNkXsFu2kqAxQ6D6m0j1gs8ROSYlnzRMGvUTxN42EJrz7JWQ1wI4GrebPYOUwWwzxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrYU7qhD5C7Sfj+JoJkZMIImW5B1nGTsAhEKRpSMpTA=;
 b=DZwUyobCvgz3PGW9lapQKMH8a+amdZgHkstpbO97cKjpnvLYbU6yaSRmJtcubbAhKYLWCHpxZ39h+MSU8CX+A6plvDZi+t5EqTguDWJM15Eq8eJ/O9zpEf3kx/blYD1MJavGyIL1S7WR41bxuHx+/RDSEzr8LnYM5BqEGbMxSHFBVKHxHbe44l79fXwedOFmL/miQYE0SE9GNvzA3/yZmWwHaIfQY0Rmn8+QlMdu89JTK7ZoC6cZ6Nbn9fsezlie7P4LCkmlZBSmasCpXUv+kaWot0AnmqYe6YfoLvoN1F0nVYrHCnZ7sbp/vlcG59slCFU0dZ7N6+xWQBDBFFHDGw==
Received: from DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15) by
 SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 19:09:31 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:8:2e:cafe::14) by DS7P222CA0012.outlook.office365.com
 (2603:10b6:8:2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7495.0 via Frontend Transport; Tue, 9 Apr 2024 19:09:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:09:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:09:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:09:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V2 07/12] net/mlx5e: Fix mlx5e_priv_init() cleanup flow
Date: Tue, 9 Apr 2024 22:08:15 +0300
Message-ID: <20240409190820.227554-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: f71e3b6c-569d-45e7-18de-08dc58c895c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KUCWJW29jgbhHmUtDtM6Z/HWhg04HOs09aIjz8edMVZu63nYceWG2m0cy+hOZiVfEg7Lob4Uw1JMfsjpKhoSO+PMz9nSL3b7k31RE3l/afloZBNSZs1oDmjLCMibXSXM80w3VGxJid2r7w0m9joSN2YvElhjQSxZLHbPp7br3m8y3kaHaRKXQMtK7qamroZtTnZv1bLRJAVCDwG7eXekPpKmuMfx+ppZnU9TwAskZOX88rhsazGeKHpVTOqSIxYzF8vPllsrCe0sl9nS3pmcbFgIZneRdrIW1xKb8/R3qPvQIxOgQZy1iZAtrUJ9z0/gCNFWOYTV9jwrWWAcn3h21dIZDCYqDM2MQ4mdU+CDH+uKUrwuCcu6d+8zfCLba0QLVo5VvZlVi8+k80K/4rKqTOoGwNOHqfC7WN7+8GFBLdKKamYVDVIR8ILLDQJbEtpiTagzrnsmdbekUZ/jeszbIbyN3uQ+lXw2y8SHVNCzTjCEuNFe1//fDyLzh2TxSjEJkYR2KG4no2mxD5vgVUEHsl7bWXJS5PuNlLB0VjLs2Q6rpMNQZDMqcuK628I3lVSofBwzDUqdjlURCKgGg+xfpojTC+4PAEDdYLrbp/xp99I8aIO4UtSVMmK48fe/qOa8bcr0lfQXcyiAt75zFqPp3sIOd1QMyzdfmDLITzT0L6Etw6GGEWV4etCbseTBF3EW7rFarWY0IuHmCpqKqYFvPzhpxJSP234KNGYRpbiW05g=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:30.7565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f71e3b6c-569d-45e7-18de-08dc58c895c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

From: Carolina Jubran <cjubran@nvidia.com>

When mlx5e_priv_init() fails, the cleanup flow calls mlx5e_selq_cleanup which
calls mlx5e_selq_apply() that assures that the `priv->state_lock` is held using
lockdep_is_held().

Acquire the state_lock in mlx5e_selq_cleanup().

Kernel log:
=============================
WARNING: suspicious RCU usage
6.8.0-rc3_net_next_841a9b5 #1 Not tainted
-----------------------------
drivers/net/ethernet/mellanox/mlx5/core/en/selq.c:124 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
2 locks held by systemd-modules/293:
 #0: ffffffffa05067b0 (devices_rwsem){++++}-{3:3}, at: ib_register_client+0x109/0x1b0 [ib_core]
 #1: ffff8881096c65c0 (&device->client_data_rwsem){++++}-{3:3}, at: add_client_context+0x104/0x1c0 [ib_core]

stack backtrace:
CPU: 4 PID: 293 Comm: systemd-modules Not tainted 6.8.0-rc3_net_next_841a9b5 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x8a/0xa0
 lockdep_rcu_suspicious+0x154/0x1a0
 mlx5e_selq_apply+0x94/0xa0 [mlx5_core]
 mlx5e_selq_cleanup+0x3a/0x60 [mlx5_core]
 mlx5e_priv_init+0x2be/0x2f0 [mlx5_core]
 mlx5_rdma_setup_rn+0x7c/0x1a0 [mlx5_core]
 rdma_init_netdev+0x4e/0x80 [ib_core]
 ? mlx5_rdma_netdev_free+0x70/0x70 [mlx5_core]
 ipoib_intf_init+0x64/0x550 [ib_ipoib]
 ipoib_intf_alloc+0x4e/0xc0 [ib_ipoib]
 ipoib_add_one+0xb0/0x360 [ib_ipoib]
 add_client_context+0x112/0x1c0 [ib_core]
 ib_register_client+0x166/0x1b0 [ib_core]
 ? 0xffffffffa0573000
 ipoib_init_module+0xeb/0x1a0 [ib_ipoib]
 do_one_initcall+0x61/0x250
 do_init_module+0x8a/0x270
 init_module_from_file+0x8b/0xd0
 idempotent_init_module+0x17d/0x230
 __x64_sys_finit_module+0x61/0xb0
 do_syscall_64+0x71/0x140
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
 </TASK>

Fixes: 8bf30be75069 ("net/mlx5e: Introduce select queue parameters")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/selq.c | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/selq.c b/drivers/net/ethernet/mellanox/mlx5/core/en/selq.c
index f675b1926340..f66bbc846464 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/selq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/selq.c
@@ -57,6 +57,7 @@ int mlx5e_selq_init(struct mlx5e_selq *selq, struct mutex *state_lock)
 
 void mlx5e_selq_cleanup(struct mlx5e_selq *selq)
 {
+	mutex_lock(selq->state_lock);
 	WARN_ON_ONCE(selq->is_prepared);
 
 	kvfree(selq->standby);
@@ -67,6 +68,7 @@ void mlx5e_selq_cleanup(struct mlx5e_selq *selq)
 
 	kvfree(selq->standby);
 	selq->standby = NULL;
+	mutex_unlock(selq->state_lock);
 }
 
 void mlx5e_selq_prepare_params(struct mlx5e_selq *selq, struct mlx5e_params *params)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 91848eae4565..b375ef268671 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5726,9 +5726,7 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 	kfree(priv->tx_rates);
 	kfree(priv->txq2sq);
 	destroy_workqueue(priv->wq);
-	mutex_lock(&priv->state_lock);
 	mlx5e_selq_cleanup(&priv->selq);
-	mutex_unlock(&priv->state_lock);
 	free_cpumask_var(priv->scratchpad.cpumask);
 
 	for (i = 0; i < priv->htb_max_qos_sqs; i++)
-- 
2.44.0


