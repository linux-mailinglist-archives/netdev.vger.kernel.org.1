Return-Path: <netdev+bounces-113640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8156693F5CD
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0DC1B20B36
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B173914D29B;
	Mon, 29 Jul 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EKn5edG+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C1149E0E
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257161; cv=fail; b=I2GECXIdOpoJVw875dsNvX3ZX73ONNL+o7juJV7FlJuK7laDaoixfnmqK12xeoz2c/lKnKRe8zFRLs8ZBMeKWflNzeSx3MaHSq8P2sgfLF/YB3ODPFkHP2NJ/2tMkuPSBJRDKIZGA7QBzsXSeEPy9LBp9Vrp1AgaKLB4V0GKICY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257161; c=relaxed/simple;
	bh=g6dgiVZHpAlYLyqKoIYMl0CTllUOx9ECFFgBN1yzyCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMUrF/w9Qi3zEwZ3MCwOE8I1I5Bz3uV30XiS0w9TRAcQJnsbdUSoonNpjpUxWMLtEEbqdKSKGlgeUaCJBYrQ0tKWoX0vcLt1dN2heHyRwHA6vGXB9SJ1DINc1zg3AhJC8lqs18H26TWeRnfsvN9+vTwFNnpuJ/BR0/J+zJkpz5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EKn5edG+; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmDUD8fY50dCrYtynZ16OeY+Svf+/XbJ7zrZdGUpL/Clc+9O3EVdfeN15fmjz+ryOwfcQYp09ywbteSLZyXqQEDGJqNASsA+W/axNay+Jf1HYWrMZ07q0UVor61WDjPnKtsHboQnfPS5f4jwro9F7YJCsm+4Z+vmq+WzeyOtAJ4wvCddtZhUl5Bud0+KhkSqxfzxgOFYVBHMfiSlrPYc2urTzyO43Ws2o0Xar53S4XboUMklBhHUqY6zfCNGkH9es3KwbLhYDOdl7D1SlwQhRKyVGX84VJS4sTxl5+ppCyBDRhz63Oy75EcmxCOCHPyBleNWIvZ9KhHYTW08k7Rqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaRC7om/2eEk+zaX1FZeFJKNBlMaohkCXqX9J3JEGWM=;
 b=IBNgGaX9Nzr4pmjwbzcuVkAewxHsDHl4q5/IIzzeG0VCSbLvFzCLPMymBRIWHNeur/1hpYvKb55qW2vKGu043bbJQUdmm9MlMrTTDRGgH2iugDPkn7DowsK6+9EAPOHF+wtAky2kg6heAOXzl/K/RBITagUfxQR1JeqO/giQQRRCiiaAN35jb1G8kMQTI50hutew/iEfP/Qo3oilzZCvKn3rH1yjBIok9grMsiDiRbEUTN2GkEfpOVB564NIr63j4YIU1ZIk5fEy2lmwwA+WT0QDzWvoJMY5VcbCsYhrRkGkJydf6sM9iWCLqKd9cb18njZML8bgAJnD95VohSY2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaRC7om/2eEk+zaX1FZeFJKNBlMaohkCXqX9J3JEGWM=;
 b=EKn5edG+Ha2p5uC/NAsNQBS23rXKWBBp6MvEeA2DtqtVKicTWPuRqaPlyQDI9gYz54E4eBbTzN2f21kqub24foq8Ciot0wPJEViv3tNsHrbSndM/7QBN7nX4G57BelHeUZgSa+K7cCyUtTiBSQ0JbJ01rUPqMn+S+4Uo384nfnzK0h3NnhnKlCcO28sDbty+RgR/9ZsN5rEkDLd007FXLWubg+a41/kJ7jGdAy17iO3IM1IsBDV66tqlCKYoHj06fcCOl5838oC+Cuij3UOGXOozcHVhPSG1N4MgjBU5eCU02FkcliJLi7Ku3Iiwj2GOHC38Rsafjg3YyADamEuWSw==
Received: from SN4PR0501CA0103.namprd05.prod.outlook.com
 (2603:10b6:803:42::20) by SJ2PR12MB7944.namprd12.prod.outlook.com
 (2603:10b6:a03:4c5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 12:45:55 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::70) by SN4PR0501CA0103.outlook.office365.com
 (2603:10b6:803:42::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Mon, 29 Jul 2024 12:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Mon, 29 Jul 2024 12:45:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 05:45:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 05:45:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 05:45:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 4/4] bonding: change ipsec_lock from spin lock to mutex
Date: Mon, 29 Jul 2024 15:44:05 +0300
Message-ID: <20240729124406.1824592-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729124406.1824592-1-tariqt@nvidia.com>
References: <20240729124406.1824592-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 7911fb8d-3fda-44bc-b9d7-08dcafcc6345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WRHTTlNwjE7e6dVu1sNjCK97tqQSMwJSuCH7N0nKuKJiPszlyLuJOSzzViJ9?=
 =?us-ascii?Q?+bSnrb3U58fKslkkOAFPZ6YsRzG4r/mdNyTGax9DQin4NyB/QcsyGBzdG3dM?=
 =?us-ascii?Q?xb878Am1R8/7S8Mgeaqb4dKW4yyddG4lTGc9Q+0uH18mUu8/C5p5lDN57rBK?=
 =?us-ascii?Q?U7q3Rf0pslX0jZFoc13ygqj4Hgqq/Gn3ELTAgaDquPet+y41ouWKuH7wjt4g?=
 =?us-ascii?Q?gjLo1zAHdqUCQqpegwk3S5sUCjnESk5NuaMbXlmNF+5d5MPY/4ra47XtyH+P?=
 =?us-ascii?Q?p562L7Ptg9i7kTR5G/V9DmYYhuBWSmz71HkzjxnYTFPxXYkDHaSJhXcTjoIa?=
 =?us-ascii?Q?TdnKIORaXH+BBgt23TuWa9tHlmdq7araP+mHD3TxeR7lWTpnSproxTkTd+xl?=
 =?us-ascii?Q?22Scg944U89fhYOJrnV3TuYoeXMhoNBij0iuFlZY8XFJ+CnUQ947hsE5ffqi?=
 =?us-ascii?Q?RJvZK5NfIDRujJv2Ug/72A0lPDO9KoQuX7As2b/w7w4C303U5ugBBDrhuUbg?=
 =?us-ascii?Q?HYn6aQk4k2NZoNPfJ+PZKHin6uEW/2A0Q7ovc8CSSvhZl7dtWX3l21jkCXFn?=
 =?us-ascii?Q?7iurT+9IDSCXRslu9RNU6+YbUK3BIUSJLw0tMCGujxpR5RCX18E/Ax6jIW2k?=
 =?us-ascii?Q?OU8HVO+UN7CNVMc2lTN5zEn6qagkfUV9xkGSsrHfjZulGo7rMLunHv2nJWyH?=
 =?us-ascii?Q?WmowciL5Vz4vIXzCBxiRwlgqQ9r/ljb3M+IDrdP94agsoZy3OISyyXPlAO7E?=
 =?us-ascii?Q?MRsIIGLg2+qjkzJFxqMdQ2YMzlA+dUqEI8W8GHSv/2ZbH38vSd9nHCYNp7zZ?=
 =?us-ascii?Q?j2T+kHT7DN9PzpEvqY+8t86M0Za+mS1n+p+twQAi8mlUpfZ0k5/NS4836Eo5?=
 =?us-ascii?Q?/17A62KwUFCmHQ3UnOg/Jv7jj5eQ73CfMEqqugTdM3RmFu93zBiT469Sari9?=
 =?us-ascii?Q?L87iKTICp7Pii17X6Yrwp+rrWgqOJqxQ8uVehM1aPqagags0dTR2w3vxU0Ll?=
 =?us-ascii?Q?VUztaKprfJ9BoBEdvH1gbDhonpTQLkTKd++cx30yuyhMBHoTpEdV3EvM+/By?=
 =?us-ascii?Q?gooPJKmR6oq4lCpNU6r/Q3c4wLoAArCf12N7o/PrKlvjMH7Ljhh0iNNNEKFs?=
 =?us-ascii?Q?HDT9rOfvSKQlrM4pNuHs4Mbe7gm2cR2wbFOA/D2FVkpmh5YzheiUJqdWaNY4?=
 =?us-ascii?Q?C0ByiO2mWAz5HBM9aD3twGJ086s02zP5C9alMMgJKmVqXc4o31Q0hQ2Ry9My?=
 =?us-ascii?Q?fOnI0RSGlDbkgshE/E1iRA0xgkqPOF/E2aMHYayeL4+4V0PfPzwv5Sa9SW50?=
 =?us-ascii?Q?jKqJwN6j2WpsGKg2z+pGdRao+NwYbUPT9bbzZ4oPLGWj412owVK53b1RxAX3?=
 =?us-ascii?Q?uVw3HWf23qUYwEt5cYNwI2sXqSLdQFBj740PT4ZM9VHwiGIohYadJC+9i9OW?=
 =?us-ascii?Q?9+Ozhz8sOX0IBGwSH2nV6pWZS7PmXlex?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 12:45:55.2220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7911fb8d-3fda-44bc-b9d7-08dcafcc6345
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

From: Jianbo Liu <jianbol@nvidia.com>

In the cited commit, bond->ipsec_lock is added to protect ipsec_list,
hence xdo_dev_state_add and xdo_dev_state_delete are called inside
this lock. As ipsec_lock is spin lock and such xfrmdev ops may sleep,
"scheduling while atomic" will be triggered when changing bond's
active slave.

[  101.055189] BUG: scheduling while atomic: bash/902/0x00000200
[  101.055726] Modules linked in:
[  101.058211] CPU: 3 PID: 902 Comm: bash Not tainted 6.9.0-rc4+ #1
[  101.058760] Hardware name:
[  101.059434] Call Trace:
[  101.059436]  <TASK>
[  101.060873]  dump_stack_lvl+0x51/0x60
[  101.061275]  __schedule_bug+0x4e/0x60
[  101.061682]  __schedule+0x612/0x7c0
[  101.062078]  ? __mod_timer+0x25c/0x370
[  101.062486]  schedule+0x25/0xd0
[  101.062845]  schedule_timeout+0x77/0xf0
[  101.063265]  ? asm_common_interrupt+0x22/0x40
[  101.063724]  ? __bpf_trace_itimer_state+0x10/0x10
[  101.064215]  __wait_for_common+0x87/0x190
[  101.064648]  ? usleep_range_state+0x90/0x90
[  101.065091]  cmd_exec+0x437/0xb20 [mlx5_core]
[  101.065569]  mlx5_cmd_do+0x1e/0x40 [mlx5_core]
[  101.066051]  mlx5_cmd_exec+0x18/0x30 [mlx5_core]
[  101.066552]  mlx5_crypto_create_dek_key+0xea/0x120 [mlx5_core]
[  101.067163]  ? bonding_sysfs_store_option+0x4d/0x80 [bonding]
[  101.067738]  ? kmalloc_trace+0x4d/0x350
[  101.068156]  mlx5_ipsec_create_sa_ctx+0x33/0x100 [mlx5_core]
[  101.068747]  mlx5e_xfrm_add_state+0x47b/0xaa0 [mlx5_core]
[  101.069312]  bond_change_active_slave+0x392/0x900 [bonding]
[  101.069868]  bond_option_active_slave_set+0x1c2/0x240 [bonding]
[  101.070454]  __bond_opt_set+0xa6/0x430 [bonding]
[  101.070935]  __bond_opt_set_notify+0x2f/0x90 [bonding]
[  101.071453]  bond_opt_tryset_rtnl+0x72/0xb0 [bonding]
[  101.071965]  bonding_sysfs_store_option+0x4d/0x80 [bonding]
[  101.072567]  kernfs_fop_write_iter+0x10c/0x1a0
[  101.073033]  vfs_write+0x2d8/0x400
[  101.073416]  ? alloc_fd+0x48/0x180
[  101.073798]  ksys_write+0x5f/0xe0
[  101.074175]  do_syscall_64+0x52/0x110
[  101.074576]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

As bond_ipsec_add_sa_all and bond_ipsec_del_sa_all are only called
from bond_change_active_slave, which requires holding the RTNL lock.
And bond_ipsec_add_sa and bond_ipsec_del_sa are xfrm state
xdo_dev_state_add and xdo_dev_state_delete APIs, which are in user
context. So ipsec_lock doesn't have to be spin lock, change it to
mutex, and thus the above issue can be resolved.

Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/bonding/bond_main.c | 73 ++++++++++++++++++---------------
 include/net/bonding.h           |  2 +-
 2 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 763d807be311..bced29813478 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -439,38 +439,33 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
 	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
 	slave = rcu_dereference(bond->curr_active_slave);
-	if (!slave) {
-		rcu_read_unlock();
+	real_dev = slave ? slave->dev : NULL;
+	rcu_read_unlock();
+	if (!real_dev)
 		return -ENODEV;
-	}
 
-	real_dev = slave->dev;
 	if (!real_dev->xfrmdev_ops ||
 	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
 	    netif_is_bond_master(real_dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
-		rcu_read_unlock();
 		return -EINVAL;
 	}
 
 	ipsec = kmalloc(sizeof(*ipsec), GFP_ATOMIC);
-	if (!ipsec) {
-		rcu_read_unlock();
+	if (!ipsec)
 		return -ENOMEM;
-	}
 
 	xs->xso.real_dev = real_dev;
 	err = real_dev->xfrmdev_ops->xdo_dev_state_add(xs, extack);
 	if (!err) {
 		ipsec->xs = xs;
 		INIT_LIST_HEAD(&ipsec->list);
-		spin_lock_bh(&bond->ipsec_lock);
+		mutex_lock(&bond->ipsec_lock);
 		list_add(&ipsec->list, &bond->ipsec_list);
-		spin_unlock_bh(&bond->ipsec_lock);
+		mutex_unlock(&bond->ipsec_lock);
 	} else {
 		kfree(ipsec);
 	}
-	rcu_read_unlock();
 	return err;
 }
 
@@ -482,34 +477,44 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	struct slave *slave;
 
 	rcu_read_lock();
-	slave = rcu_dereference(bond->curr_active_slave);
-	if (!slave)
-		goto out;
+	slave = rtnl_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+	rcu_read_unlock();
+	if (!real_dev)
+		return;
 
-	real_dev = slave->dev;
+	mutex_lock(&bond->ipsec_lock);
 	if (!real_dev->xfrmdev_ops ||
 	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
 	    netif_is_bond_master(real_dev)) {
-		spin_lock_bh(&bond->ipsec_lock);
 		if (!list_empty(&bond->ipsec_list))
 			slave_warn(bond_dev, real_dev,
 				   "%s: no slave xdo_dev_state_add\n",
 				   __func__);
-		spin_unlock_bh(&bond->ipsec_lock);
 		goto out;
 	}
 
-	spin_lock_bh(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
+		struct net_device *dev = ipsec->xs->xso.real_dev;
+
+		/* If new state is added before ipsec_lock acquired */
+		if (dev) {
+			if (dev == real_dev)
+				continue;
+
+			dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
+			if (dev->xfrmdev_ops->xdo_dev_state_free)
+				dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
+		}
+
 		ipsec->xs->xso.real_dev = real_dev;
 		if (real_dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)) {
 			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
 			ipsec->xs->xso.real_dev = NULL;
 		}
 	}
-	spin_unlock_bh(&bond->ipsec_lock);
 out:
-	rcu_read_unlock();
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 /**
@@ -530,6 +535,8 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
 	slave = rcu_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+	rcu_read_unlock();
 
 	if (!slave)
 		goto out;
@@ -537,7 +544,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	if (!xs->xso.real_dev)
 		goto out;
 
-	real_dev = slave->dev;
 	WARN_ON(xs->xso.real_dev != real_dev);
 
 	if (!real_dev->xfrmdev_ops ||
@@ -549,7 +555,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
 out:
-	spin_lock_bh(&bond->ipsec_lock);
+	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
 		if (ipsec->xs == xs) {
 			list_del(&ipsec->list);
@@ -557,8 +563,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 			break;
 		}
 	}
-	spin_unlock_bh(&bond->ipsec_lock);
-	rcu_read_unlock();
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_del_sa_all(struct bonding *bond)
@@ -569,14 +574,13 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 	struct slave *slave;
 
 	rcu_read_lock();
-	slave = rcu_dereference(bond->curr_active_slave);
-	if (!slave) {
-		rcu_read_unlock();
+	slave = rtnl_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+	rcu_read_unlock();
+	if (!real_dev)
 		return;
-	}
 
-	real_dev = slave->dev;
-	spin_lock_bh(&bond->ipsec_lock);
+	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
 		if (!ipsec->xs->xso.real_dev)
 			continue;
@@ -594,8 +598,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 		}
 		ipsec->xs->xso.real_dev = NULL;
 	}
-	spin_unlock_bh(&bond->ipsec_lock);
-	rcu_read_unlock();
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_free_sa(struct xfrm_state *xs)
@@ -5902,7 +5905,7 @@ void bond_setup(struct net_device *bond_dev)
 	/* set up xfrm device ops (only supported in active-backup right now) */
 	bond_dev->xfrmdev_ops = &bond_xfrmdev_ops;
 	INIT_LIST_HEAD(&bond->ipsec_list);
-	spin_lock_init(&bond->ipsec_lock);
+	mutex_init(&bond->ipsec_lock);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	/* don't acquire bond device's netif_tx_lock when transmitting */
@@ -5951,6 +5954,10 @@ static void bond_uninit(struct net_device *bond_dev)
 		__bond_release_one(bond_dev, slave->dev, true, true);
 	netdev_info(bond_dev, "Released all slaves\n");
 
+#ifdef CONFIG_XFRM_OFFLOAD
+	mutex_destroy(&bond->ipsec_lock);
+#endif /* CONFIG_XFRM_OFFLOAD */
+
 	bond_set_slave_arr(bond, NULL, NULL);
 
 	list_del_rcu(&bond->bond_list);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index b61fb1aa3a56..8bb5f016969f 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -260,7 +260,7 @@ struct bonding {
 #ifdef CONFIG_XFRM_OFFLOAD
 	struct list_head ipsec_list;
 	/* protecting ipsec_list */
-	spinlock_t ipsec_lock;
+	struct mutex ipsec_lock;
 #endif /* CONFIG_XFRM_OFFLOAD */
 	struct bpf_prog *xdp_prog;
 };
-- 
2.44.0


