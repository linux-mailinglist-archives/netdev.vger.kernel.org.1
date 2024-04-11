Return-Path: <netdev+bounces-86989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829968A13AA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67E41C2094B
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE3314AD3F;
	Thu, 11 Apr 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvzgJzRx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14D114A09C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836561; cv=fail; b=LQEtSfCQbOIweOYCwPdWAD5dbS+uf93wJ1irUaXFuUArzdumMUoS5p5oYzmoPY0FP+I310rl75AL1/ppPTZhKM2yEKQwX4SAYpkLjZa/JT+ANqTrX7e2Br8SA6WJmP3Kq7Q5rYJTyHpp9jC9Yr9r/f6RBHlghrw6P3eDMcdLdVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836561; c=relaxed/simple;
	bh=R4bj3d04hlZF2JwDBQ9+2/6smhdpPB6Wnby4Cef4+7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqEAfey7cgmeeo6Ds3J1NBsX5U1WFaoj3Cl8ff9NzdoxaBLfup6eKpVRAuRJHkcqNud2O5oq48d7+qowe6pT2QWTNubjuGcnKm0+FE5UeoIqY4RR9ag9iHrb8G8MG0l1DCLkuD3AqRt9YAANa6q8xmPLEW/jKesjg5UC3r6ut3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tvzgJzRx; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBx//aU/7wIwMGy/1P+YmdoyXAYRZCyf+w2u7ds/7Dd950KhJvzQ8T8ucDrrHAubUMREGnpATMtCWIXKgbdyWI/GTK+dfcwCD6/w6g/9VKJaJlWJTx5TYg/3API65FloW5+EWtgZj7ctc3Wv/IzUdw7k+QGdYD2T3SI52x5nG2eVUR//6KNM/Hso37xLOPD3U+WrNuf65Khztac+a1VbRH/oi/N6hVZrooPyET4elpkgegKc5l01ThbUxQdCj0NYJwfqV/D8z6AZTkPLFNOiAZxByAEFAFSMESscRlnY9ein5zwdWyTTKutjKjUo4rGZk+pbef3iKYYLHJXIS6AY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OixfipY+jUUQ+ZH61odyfq/ytKp/vZEacLws6H3yPEo=;
 b=XXOm7UcQ6Z1pma70+Vq/MLdmGomRYhOM+A6J2hO8EAtqojnRVbpeKTIpwxp16lGPJRc/p+yzjlxx5kI804URAAYADF+nyPLctPkhCcJwG+v9CO8j6/vdPaorc9ViPcdDptlXqjwYZVjnXg5bscfc3Spi8zJ5cSt26kfOAl35TL1+Qvk0kzyCZPYup+oExCSU1ze6oIBwKv8HS+zxxLK8gku++cqZhum0JDCLpQVJbeA4hLqWTyYX+embne381P0o4+cZC3A376mikJMmsTMzJ0zBSmlSyY7bh0HIppUKN5s1WTDwUuPTECKzx+0Z9/y22iHVjuojr4fOExqkc56+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OixfipY+jUUQ+ZH61odyfq/ytKp/vZEacLws6H3yPEo=;
 b=tvzgJzRx8XHVShTo5NYN1PkxKUJ54gL1Hipu81Y8zEB9pjgWrwLP3Bcy1P4ky9iEH67Sp9IFXXE6F4m+fAu8Gqh+tkp+bqAbi9D74X7xLkjWDuwQfBhsZzjsCoPRjJKT0+NUcR9ZbvaplQipjuMCazOd4t7gWaBBsc++DH2iAqt9wPVuL+28gDE85Wc/V6GBVPVf29SZQmvTWUAoOw+mcCZycNWv7aMXSfKkh5pXZrMMoqIddfBr1vXPueTRtw/sQdUFULJuDD/PuhtvUYjPKVwtg8d6/9VfMmHmzTiruwfpIFYH6kUqAnXIrUtvDM+eITktw0ZOGea3J58TvLaBWA==
Received: from CH2PR20CA0027.namprd20.prod.outlook.com (2603:10b6:610:58::37)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 11:55:56 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::65) by CH2PR20CA0027.outlook.office365.com
 (2603:10b6:610:58::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 11 Apr 2024 11:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 11:55:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Apr
 2024 04:55:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 04:55:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 11 Apr 2024 04:55:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 6/6] net/mlx5e: Prevent deadlock while disabling aRFS
Date: Thu, 11 Apr 2024 14:54:44 +0300
Message-ID: <20240411115444.374475-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411115444.374475-1-tariqt@nvidia.com>
References: <20240411115444.374475-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: c94c7632-bba5-4af6-4baa-08dc5a1e58e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sKffVDWUvZKSiaKy54VrowMNuu0i3Cj9M1c50xeQonA01JnQsLKEkOZlzBt6cu8LSCcIZZ+rqmH6r0QgNl2A0jjw81cxssp9JiDvOh4psTMSvR5MjTxripm02aX0xJPov4b1BUO7765SrGR2OT6y7D5bxP2i3D7vzAtB42V1wQGYD5muAzZjXPC574kNX8NMEAXs2VGmFdfwBgrDBgfG7iSHpoadGXrpy7Soyc5Ef1C7WS6dldy6Q0QRDpZmUt3UB7Svdeoh8yN4K3P3nI8BtJhvZu57hTZoi93r0KMrsmxfdVtrw20M+08afLDRLD9Gh669l/6GK5XIe3epRw0TK4CwERpQUEVhRN0ND2SRgmqS/A9xvaSJ19OPHQwpWXko6gtRCstiP/7O9BPyrCQ0xmUd7/1VA3sr5vKaqI7+K/d3d/6Xq6gNsJEFAtpk5c1hwo8K9YL/70hf8zRiKcRJMZ6vMRApycZTnI0oKL6HXEhWFyObIXVlTYw5szjhEefMFHlUBGNMgbLhZZ9fJ07qree8N0/rkbC8n5Od5xbY+vYoG/XmbM2z5Z9vgwk2ltJMEVDJD8yFTpdIxkjM0tul1A01Sl0r2vK6tBcZcbxJPJhWzQdDOJSP7ug90cVu+MMEldXAFoEcJCenQYKPLWT4ilpiuoMXwuZKv/9MoDCByVQzKhetp0i2wg4WbXEOw/RxbZB4RPFvphFDmp2TgVX6VvFv/0HJJb8T7FH/NGEDYsCnUyiBgluZS8qujIwnmGVq
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:55:56.5211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c94c7632-bba5-4af6-4baa-08dc5a1e58e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877

From: Carolina Jubran <cjubran@nvidia.com>

When disabling aRFS under the `priv->state_lock`, any scheduled
aRFS works are canceled using the `cancel_work_sync` function,
which waits for the work to end if it has already started.
However, while waiting for the work handler, the handler will
try to acquire the `state_lock` which is already acquired.

The worker acquires the lock to delete the rules if the state
is down, which is not the worker's responsibility since
disabling aRFS deletes the rules.

Add an aRFS state variable, which indicates whether the aRFS is
enabled and prevent adding rules when the aRFS is disabled.

Kernel log:

======================================================
WARNING: possible circular locking dependency detected
6.7.0-rc4_net_next_mlx5_5483eb2 #1 Tainted: G          I
------------------------------------------------------
ethtool/386089 is trying to acquire lock:
ffff88810f21ce68 ((work_completion)(&rule->arfs_work)){+.+.}-{0:0}, at: __flush_work+0x74/0x4e0

but task is already holding lock:
ffff8884a1808cc0 (&priv->state_lock){+.+.}-{3:3}, at: mlx5e_ethtool_set_channels+0x53/0x200 [mlx5_core]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&priv->state_lock){+.+.}-{3:3}:
       __mutex_lock+0x80/0xc90
       arfs_handle_work+0x4b/0x3b0 [mlx5_core]
       process_one_work+0x1dc/0x4a0
       worker_thread+0x1bf/0x3c0
       kthread+0xd7/0x100
       ret_from_fork+0x2d/0x50
       ret_from_fork_asm+0x11/0x20

-> #0 ((work_completion)(&rule->arfs_work)){+.+.}-{0:0}:
       __lock_acquire+0x17b4/0x2c80
       lock_acquire+0xd0/0x2b0
       __flush_work+0x7a/0x4e0
       __cancel_work_timer+0x131/0x1c0
       arfs_del_rules+0x143/0x1e0 [mlx5_core]
       mlx5e_arfs_disable+0x1b/0x30 [mlx5_core]
       mlx5e_ethtool_set_channels+0xcb/0x200 [mlx5_core]
       ethnl_set_channels+0x28f/0x3b0
       ethnl_default_set_doit+0xec/0x240
       genl_family_rcv_msg_doit+0xd0/0x120
       genl_rcv_msg+0x188/0x2c0
       netlink_rcv_skb+0x54/0x100
       genl_rcv+0x24/0x40
       netlink_unicast+0x1a1/0x270
       netlink_sendmsg+0x214/0x460
       __sock_sendmsg+0x38/0x60
       __sys_sendto+0x113/0x170
       __x64_sys_sendto+0x20/0x30
       do_syscall_64+0x40/0xe0
       entry_SYSCALL_64_after_hwframe+0x46/0x4e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&priv->state_lock);
                               lock((work_completion)(&rule->arfs_work));
                               lock(&priv->state_lock);
  lock((work_completion)(&rule->arfs_work));

 *** DEADLOCK ***

3 locks held by ethtool/386089:
 #0: ffffffff82ea7210 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40
 #1: ffffffff82e94c88 (rtnl_mutex){+.+.}-{3:3}, at: ethnl_default_set_doit+0xd3/0x240
 #2: ffff8884a1808cc0 (&priv->state_lock){+.+.}-{3:3}, at: mlx5e_ethtool_set_channels+0x53/0x200 [mlx5_core]

stack backtrace:
CPU: 15 PID: 386089 Comm: ethtool Tainted: G          I        6.7.0-rc4_net_next_mlx5_5483eb2 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x60/0xa0
 check_noncircular+0x144/0x160
 __lock_acquire+0x17b4/0x2c80
 lock_acquire+0xd0/0x2b0
 ? __flush_work+0x74/0x4e0
 ? save_trace+0x3e/0x360
 ? __flush_work+0x74/0x4e0
 __flush_work+0x7a/0x4e0
 ? __flush_work+0x74/0x4e0
 ? __lock_acquire+0xa78/0x2c80
 ? lock_acquire+0xd0/0x2b0
 ? mark_held_locks+0x49/0x70
 __cancel_work_timer+0x131/0x1c0
 ? mark_held_locks+0x49/0x70
 arfs_del_rules+0x143/0x1e0 [mlx5_core]
 mlx5e_arfs_disable+0x1b/0x30 [mlx5_core]
 mlx5e_ethtool_set_channels+0xcb/0x200 [mlx5_core]
 ethnl_set_channels+0x28f/0x3b0
 ethnl_default_set_doit+0xec/0x240
 genl_family_rcv_msg_doit+0xd0/0x120
 genl_rcv_msg+0x188/0x2c0
 ? ethnl_ops_begin+0xb0/0xb0
 ? genl_family_rcv_msg_dumpit+0xf0/0xf0
 netlink_rcv_skb+0x54/0x100
 genl_rcv+0x24/0x40
 netlink_unicast+0x1a1/0x270
 netlink_sendmsg+0x214/0x460
 __sock_sendmsg+0x38/0x60
 __sys_sendto+0x113/0x170
 ? do_user_addr_fault+0x53f/0x8f0
 __x64_sys_sendto+0x20/0x30
 do_syscall_64+0x40/0xe0
 entry_SYSCALL_64_after_hwframe+0x46/0x4e
 </TASK>

Fixes: 45bf454ae884 ("net/mlx5e: Enabling aRFS mechanism")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_arfs.c | 27 +++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index c7f542d0b8f0..93cf23278d93 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -46,6 +46,10 @@ struct arfs_table {
 	struct hlist_head	 rules_hash[ARFS_HASH_SIZE];
 };
 
+enum {
+	MLX5E_ARFS_STATE_ENABLED,
+};
+
 enum arfs_type {
 	ARFS_IPV4_TCP,
 	ARFS_IPV6_TCP,
@@ -60,6 +64,7 @@ struct mlx5e_arfs_tables {
 	spinlock_t                     arfs_lock;
 	int                            last_filter_id;
 	struct workqueue_struct        *wq;
+	unsigned long                  state;
 };
 
 struct arfs_tuple {
@@ -170,6 +175,8 @@ int mlx5e_arfs_enable(struct mlx5e_flow_steering *fs)
 			return err;
 		}
 	}
+	set_bit(MLX5E_ARFS_STATE_ENABLED, &arfs->state);
+
 	return 0;
 }
 
@@ -455,6 +462,8 @@ static void arfs_del_rules(struct mlx5e_flow_steering *fs)
 	int i;
 	int j;
 
+	clear_bit(MLX5E_ARFS_STATE_ENABLED, &arfs->state);
+
 	spin_lock_bh(&arfs->arfs_lock);
 	mlx5e_for_each_arfs_rule(rule, htmp, arfs->arfs_tables, i, j) {
 		hlist_del_init(&rule->hlist);
@@ -627,17 +636,8 @@ static void arfs_handle_work(struct work_struct *work)
 	struct mlx5_flow_handle *rule;
 
 	arfs = mlx5e_fs_get_arfs(priv->fs);
-	mutex_lock(&priv->state_lock);
-	if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
-		spin_lock_bh(&arfs->arfs_lock);
-		hlist_del(&arfs_rule->hlist);
-		spin_unlock_bh(&arfs->arfs_lock);
-
-		mutex_unlock(&priv->state_lock);
-		kfree(arfs_rule);
-		goto out;
-	}
-	mutex_unlock(&priv->state_lock);
+	if (!test_bit(MLX5E_ARFS_STATE_ENABLED, &arfs->state))
+		return;
 
 	if (!arfs_rule->rule) {
 		rule = arfs_add_rule(priv, arfs_rule);
@@ -753,6 +753,11 @@ int mlx5e_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 		return -EPROTONOSUPPORT;
 
 	spin_lock_bh(&arfs->arfs_lock);
+	if (!test_bit(MLX5E_ARFS_STATE_ENABLED, &arfs->state)) {
+		spin_unlock_bh(&arfs->arfs_lock);
+		return -EPERM;
+	}
+
 	arfs_rule = arfs_find_rule(arfs_t, &fk);
 	if (arfs_rule) {
 		if (arfs_rule->rxq == rxq_index || work_busy(&arfs_rule->arfs_work)) {
-- 
2.44.0


