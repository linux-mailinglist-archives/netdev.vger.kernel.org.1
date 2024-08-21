Return-Path: <netdev+bounces-120485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380C9959867
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAA8B209C7
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D901C2DCD;
	Wed, 21 Aug 2024 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OtpplCBx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D21C2DCE
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231152; cv=fail; b=GkKZDPocRUxVu7oj77YA7ajRlX0APlKfuNuJu6HcTaPiGAWCn44A/CKIQiT0EMFDMbQfjpMQDm1ynTLuGhHG8l2qEaOIVMuUyKTqACwYJDbr0bLgSiPQKv9dEUt+MkMuuMyf0W1bzRJoA7RikdeDvgK2l2xcKe4jHigCQ9+lIYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231152; c=relaxed/simple;
	bh=bH/o5+m0N8MSEFIIylJPH1XFsxwRfvprnPmZdeWKd3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7OBCA+bvKvZ0yhyN230XHMLFSz248SvBj97sT2andsnWhZze8ZaI40P5RDSArqvjfrl9z+vBpMFruNaHdaTZIPwLbAChY11T9hwjmKDAPa6+Qr5rruKyuDcTX8o3Or+UmKuKt8vUMa/HNBpA6Gol8rFsPpS5hbLp/XT4pKicPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OtpplCBx; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kh9UgHj6Fgut4W9FYlq7k/9kOPGDOIURe3rGK5/CQgci0ydsFPw2P6y4qlbSjC7tPhD5jSn7DaerigdGre85hJ2DtfWSsP7jEwEC3QdPswzhAImqvLOktuoga3ft62B7jD6dbz348PH7ZbvowSFjHBsqFu9GlvXOee6YmkC+645GsNpdGpbG4VTVG02hIXI3fj0fDo0QPCXRm5OIfTCBBg2cIqwGVzX4AZTwPnh8nXSJYwGlol51HM/cvvrl+oKuVCQaI0EQYDaeS7VR6O9WfVYbJKMaz7mjENjKE8Tefrp5wsSNPO61ZTCOeGuZvxME2xQccwkVzJupfFGMQx4QaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6wOxYl0skvu5v1M2r5Tjw9IQqL5/9DjUD7DhrhNC4E=;
 b=wQleqPpzIMaqvbVHgc+0BFekgk6RXe4KZCSkUzGIK5TmbDMPJljO69yaxWt4NpyTBoqLkyW6IUBr4FYesHcamzGjjY4dwlt6WC4IpBEExF7HMwJWLAXHKgJWEBbCpWZhl/34jjVmBsPcSZ8LlBpTb2GufaCdJFTQj9FdLRa5DUIdIu+XXr0JL+De/Vl+aiPJO06vJs0ghvIqsXmi1gLwvcuAgyCRdnmnb20YfjYMfkIESHKinUAOvawORCEmVb/avj0u7DyR1EJeGvoaJGNOLxccsHNE8rG9jc5pZ9vxspn9qkTWIaJIaqVDCoN1PFlly7776SzaRAy9sjJkMuqi0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6wOxYl0skvu5v1M2r5Tjw9IQqL5/9DjUD7DhrhNC4E=;
 b=OtpplCBxTSZdMCqjdxoLC7rkmUad8ggxc/kbHn3q6u64DhYVZkjqr8irLFQzxQtd4QfzXXOX91Ix6vrzY3AZxPIorqg3qk7cGIN06EYWnt3lc4dsoVege6CzTP2iSkcRYNPG8uq/SfI4/Wn5aoIaNxiCD9lPutoJfAuMTiM7lZn3XTfVh1uQ+vCJN5dvGdFgt4faCbE868zJN5qPfZl2xh0B/qmc0RCNnWOSQLMcfj7YhdsKYmYo/a/nFNZc2wDDdYAcHD7T/+tpsScjsyKJwyEIXD7ysras7cXp2qmBrV8aM4idJ40EedrXPdLDf1BtYHHAUpChKL8+Mr0QX7v+rA==
Received: from SN7PR04CA0183.namprd04.prod.outlook.com (2603:10b6:806:126::8)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 09:05:45 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::b) by SN7PR04CA0183.outlook.office365.com
 (2603:10b6:806:126::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 09:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 09:05:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 02:05:32 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 02:05:31 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 21 Aug 2024 02:05:27 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <jv@jvosburgh.net>,
	<andy@greyhouse.net>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<liuhangbin@gmail.com>, <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net V5 3/3] bonding: change ipsec_lock from spin lock to mutex
Date: Wed, 21 Aug 2024 12:04:58 +0300
Message-ID: <20240821090458.10813-4-jianbol@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240821090458.10813-1-jianbol@nvidia.com>
References: <20240821090458.10813-1-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb6232b-0616-48df-7cf2-08dcc1c07109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ikzWjhmUijAvfYKHw7FEaALqXhwYS20U/NwA52oJIbfnJmlTSxN34DdT0QVk?=
 =?us-ascii?Q?XVYTodWE29PwQSHlJtZ7qA7wKv97AkbLOk0+F92oMUUWLEe7awdLBkiP1IgD?=
 =?us-ascii?Q?gCtmrVt9oDalH0VbAFoTartMOC2fxmYqhUTM9UHztZatw3IBU1tjWB9hlS1y?=
 =?us-ascii?Q?8WiF4/gx5Y8MA1mps5mIiHuO7UJLtq7reGCyD9Sa31zYMV02OLuKski2SnKx?=
 =?us-ascii?Q?1A7Wtod0cS61WCAXk38PxY2/yJM8IFqgaUA9ph8sucQrdtKohVZ3/eV1Q+QN?=
 =?us-ascii?Q?BziIlDL2dh3bKGw1VI4pGZxGDcitq//IiJqJhtNaiIlvi0a/aBmwmBb/socv?=
 =?us-ascii?Q?kcr8mqSHF0acNyfMCMxHZ3cPbQBzak8lJaV4CDW5LC0jGKnkavYmhHIj7/FI?=
 =?us-ascii?Q?JKFx+9y5KmSydAlDzQmJ0gZTqW4mguWYpwiV5pnU8nQ71H2Lbv7avRngYqqD?=
 =?us-ascii?Q?8LPwcyJgsNGCRnMQQ9IGn2/LklRB/TpDp8fbxmfrsrFSTzfi5KKdnfxjcXCC?=
 =?us-ascii?Q?WWCN8wSEiwHl0tL2DERCcNyKIBBWuqq+EvWM75K4eHqGRtFHwNpzMGv/7EZB?=
 =?us-ascii?Q?TWXlxy4rP59AGczN0XrgNFmoUNIMpzJu2QGFngEZznpJTvs5gsTMSkmfwocX?=
 =?us-ascii?Q?Nit8eh9Hd7jl5n/t+j01FPwRgSfyOMw+8Kd6zwzeJr9R7KqRDCEEPm274+9B?=
 =?us-ascii?Q?nzXSKe0EPWijj/o6Bd7bTUA7JzI2BHvSF7746ilpxjUPvVobgkyMkjwiBSij?=
 =?us-ascii?Q?6K/XqWHxab6s0i6zd0cQJVn0yWUf76dqAjD3bt/ECAXSQL2CuC21hd/y0t3t?=
 =?us-ascii?Q?KqL/g38GXewT1T6Ldzs8kBxrju1RW7UJ6gXzQCQCo9cMINS1qAdYwFflqluL?=
 =?us-ascii?Q?QTHfpkIpr+0hRMKi8ASIhSXRu1Uu3Or/0CpMSOkkWEK7A3sUZ3tUUPVyORPf?=
 =?us-ascii?Q?lkfcY7zsjMbnG75a48zEIkan4aD5mLKYCUsRhfATaioa8QszEipZihzYa1xy?=
 =?us-ascii?Q?dxtDHlzeeyEAoFTFkn9v5/qqKJ7bFpHrKkodAz6XJvunm2MxOBD+tqNmtg7Z?=
 =?us-ascii?Q?+noeW4GRjfiD7WatWtouKhgvCZzuIzJdN5Ryg4iZ+9YAzRSIbZexjSWFWexD?=
 =?us-ascii?Q?6Crs2O68QmEomS9T7GPo4Xkzs7Z2hZraIarr/yH5xrvp4uG9MhJj54WFsS9S?=
 =?us-ascii?Q?49SHRzrjcuEnpxatDQ4qUvscA9cQMg2T/sbsZD0oSS1KUuKltYoR6yc44pty?=
 =?us-ascii?Q?H+6SDPHUBFRXRJilU7RSXHz94LvfDe1FDfB69Jt4Eh0CG97WjG0vJOwHJiJT?=
 =?us-ascii?Q?wLN4bHBMCcQXxsDP43cMzUfZGHLbiAcN190DZkK9OhVKsFsBNRx29qUFRnHc?=
 =?us-ascii?Q?xaHewXEvFO+tT1ftz47MB56azgYZxhMDV75RZftriyRW4AWmgGaAfwdNUuNI?=
 =?us-ascii?Q?09MwLNP27Ysp+999/WWjX/B0IIhhGpil?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:05:45.2690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb6232b-0616-48df-7cf2-08dcc1c07109
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719

In the cited commit, bond->ipsec_lock is added to protect ipsec_list,
hence xdo_dev_state_add and xdo_dev_state_delete are called inside
this lock. As ipsec_lock is a spin lock and such xfrmdev ops may sleep,
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
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 67 +++++++++++++++------------------
 include/net/bonding.h           |  2 +-
 2 files changed, 32 insertions(+), 37 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 0d1129eaf47b..f20f6d83ad54 100644
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
 
-	ipsec = kmalloc(sizeof(*ipsec), GFP_ATOMIC);
-	if (!ipsec) {
-		rcu_read_unlock();
+	ipsec = kmalloc(sizeof(*ipsec), GFP_KERNEL);
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
 
@@ -481,35 +476,35 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 	struct bond_ipsec *ipsec;
 	struct slave *slave;
 
-	rcu_read_lock();
-	slave = rcu_dereference(bond->curr_active_slave);
-	if (!slave)
-		goto out;
+	slave = rtnl_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
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
+		/* If new state is added before ipsec_lock acquired */
+		if (ipsec->xs->xso.real_dev == real_dev)
+			continue;
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
@@ -530,6 +525,8 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
 	slave = rcu_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+	rcu_read_unlock();
 
 	if (!slave)
 		goto out;
@@ -537,7 +534,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	if (!xs->xso.real_dev)
 		goto out;
 
-	real_dev = slave->dev;
 	WARN_ON(xs->xso.real_dev != real_dev);
 
 	if (!real_dev->xfrmdev_ops ||
@@ -549,7 +545,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
 out:
-	spin_lock_bh(&bond->ipsec_lock);
+	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
 		if (ipsec->xs == xs) {
 			list_del(&ipsec->list);
@@ -557,8 +553,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 			break;
 		}
 	}
-	spin_unlock_bh(&bond->ipsec_lock);
-	rcu_read_unlock();
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_del_sa_all(struct bonding *bond)
@@ -568,15 +563,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 	struct bond_ipsec *ipsec;
 	struct slave *slave;
 
-	rcu_read_lock();
-	slave = rcu_dereference(bond->curr_active_slave);
-	if (!slave) {
-		rcu_read_unlock();
+	slave = rtnl_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+	if (!real_dev)
 		return;
-	}
 
-	real_dev = slave->dev;
-	spin_lock_bh(&bond->ipsec_lock);
+	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
 		if (!ipsec->xs->xso.real_dev)
 			continue;
@@ -593,8 +585,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
 		}
 	}
-	spin_unlock_bh(&bond->ipsec_lock);
-	rcu_read_unlock();
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_free_sa(struct xfrm_state *xs)
@@ -5917,7 +5908,7 @@ void bond_setup(struct net_device *bond_dev)
 	/* set up xfrm device ops (only supported in active-backup right now) */
 	bond_dev->xfrmdev_ops = &bond_xfrmdev_ops;
 	INIT_LIST_HEAD(&bond->ipsec_list);
-	spin_lock_init(&bond->ipsec_lock);
+	mutex_init(&bond->ipsec_lock);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	/* don't acquire bond device's netif_tx_lock when transmitting */
@@ -5966,6 +5957,10 @@ static void bond_uninit(struct net_device *bond_dev)
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
2.21.0


