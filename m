Return-Path: <netdev+bounces-115632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC3E947484
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 07:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB5E1C20B90
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 05:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0666A13D502;
	Mon,  5 Aug 2024 05:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jwphncXr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6835381BD
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 05:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722834376; cv=fail; b=hjfwXg3+j+lLgi1WE37RQTeGw3p/hhBHIl2IcHxJZAB2M9z5NKEJNwnZB7vF7C3VdQbhugA3MGWuhv5i+WMNOI0KC7o0xJLAnaEkNBfFE6TLqI0UJjy2HvOf7UAA/8g3SMM+W2z9o+7ZrjAnoygt+xnS6VpNKwY/BzW9qSUcg6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722834376; c=relaxed/simple;
	bh=RIC/x4WguaKBTtWlqV7BH2hovdQr8Jk728Q3WRRRtUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i00iaiCkFj3a5Iwi1g/DmgFZBgeJiBIiPhDieLw5XrA8oODBRMKZuzxLjC7ISj4WUCVZVDpZYMClHzaGSI/bjew3EgQIfkFbSAvfExQ+Qzb/+D51RNGL5NEkZCjdNOrPYWK25ySsd2xVBKix2ceQ9IRj2RKJG2GV+r9q2OsEFrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jwphncXr; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXIdf+9JfkYl95HVW/Oh8p9nJnKctAzhnsHPXF6ttPmjwSMO3fnx8JvixLYEwApjG5clq4k6IALVJA38LMLAZuL3GlL5Y+Fr1cRf+HN46Qrgvps4SeAkPDtKuduScUCEUPCFGB8iA8nRok4gBQZqi7GmqDeCOjC6b37syz3zSPC5JP5sTVa5LjBuY2QCPuODlVpajGbecNgmpK6itHyiw4proRNGL2tGQt0BkGPQRNOClon0PxPOwKd1P9Alsp/M1tvUEYqDfiSDQzXp/Kdx7i8pEbMEmkS+C2caWyRnWSkHOxqdqdH2bY1iN74oJHPK/LkbyrZ3Y3X2JTWZKtXOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uooANgY7pVMLUkZbDZlnaUlzSqKqENpZ5FTyjGJaHGw=;
 b=FWmQReAiH7B7ckGDN2Jp7qbW3h/t1lTP2i/pMdeDvEikNBY0uAMV0ZBkCGV1iPbCLuyoC6hfwUbuOTzUC1izPzDE9UlPpzWa7o0dwZ0qV2IqzRIEc1LiMTZWL9hItz1kua6o+KiujQn6idc4D+QiaMfv4t2HrMID8CgQ1a+5Q+TCIpkdbH58IUiYyBvuw+7K3RJfl7S+v31QfxXooOZ9jB7mzUSFe62lxrkhCM9QJT4PJtmi0RiF7d2I8kSVQdwDWDsy6SNCf05txC7EL65CDK8kCMHG8kRMNWPDeKwh2cfkCR2133yVTjYAdiOZs7RR1C9HV4SwZFB+HMj49tG/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uooANgY7pVMLUkZbDZlnaUlzSqKqENpZ5FTyjGJaHGw=;
 b=jwphncXrYGuI5iJYh4DiVT3DX4U3hELvIxgazZWj5tD+coOVIw7qPKl+WD9Bwu0Me+e+iLP/DyLDvSdlQJvl0f+XFlIdmwSk3GzJ6MWnYaE07qfzvvw2ygNppSU3tSDdIKnedY+7O8XtMV75lYLMroold4XPNMKO841iPfBhwdOtSRJrwzt5DnIQYhD68z2TNv5Ns+wklCB46kG423CXIQAWGYgoI70hh5eNT6rqsYw0opPcYk9JNAayzHMBqFXUPvaafBbuLCQbrvov8BSixqlr02au89S0tYKQAW6FPTX3O588CXP9tFfSvSxF0SWT2bV/4625HznlfPHPUDQIdg==
Received: from PH3PEPF0000409F.namprd05.prod.outlook.com (2603:10b6:518:1::4f)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.20; Mon, 5 Aug
 2024 05:06:10 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2a01:111:f403:f90d::1) by PH3PEPF0000409F.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Mon, 5 Aug 2024 05:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 5 Aug 2024 05:06:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 Aug 2024
 22:05:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 Aug 2024
 22:05:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 4 Aug
 2024 22:05:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V3 3/3] bonding: change ipsec_lock from spin lock to mutex
Date: Mon, 5 Aug 2024 08:03:57 +0300
Message-ID: <20240805050357.2004888-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240805050357.2004888-1-tariqt@nvidia.com>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1a5373-726b-411f-2642-08dcb50c5248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l9Y8VN644kKUw4VgKM9x0o+4K4yiNm8z1Jx6bQ/6n661PwtLW9qW1vG6y/y8?=
 =?us-ascii?Q?EeMORFTXbIwhshyCbvVEh3BOA+Fz8SvVdtSxWikhWrIIoLQxUXRih3iuDSxC?=
 =?us-ascii?Q?eyfFFQKyEbA2gEr8n9aX0usepFEZo8heDq55jOTRrcnnnMHSK8xb0oQvwvqd?=
 =?us-ascii?Q?3aWH12JzqcW2l89cDAa9XyqgOzRJXBnQyQhOjXks8kA5AETeLRqIpKmA+rya?=
 =?us-ascii?Q?3/0BJ9QslvtK+XJp1NUa8QQc6WQvmjMMfTp6owt+sXw8MQ8L81Xkxhq8nWAC?=
 =?us-ascii?Q?cOlytjBA3IPKIHz6wspSiYH5m5bAcU1M0w/3ozHh/1DnHLfQUrXbzmNXcNjz?=
 =?us-ascii?Q?f+ek6xNALRY1S3j4fmSX42bBqIJcHhnpm0/Xh7GSmtbZpcVGbJuBO1xTKZEg?=
 =?us-ascii?Q?cI8Zb7YtXhI+2I9WoFM4RG2Q3bw9qsiD5m51P06/WKgX27oojKpj/ObKH4+M?=
 =?us-ascii?Q?BH25DTd75r+i81dJFujcPpalWvlSkhwCVEN4UbbFGLJK7rPbUalq7WHxSxd2?=
 =?us-ascii?Q?rUueKXwXie3F57+FsXjiu8ZuGewB192QLtx24NSSGBlaU3baVyBRwzKk0w/4?=
 =?us-ascii?Q?2IWa2w1ENjUk97kC+qQkGXSP6slxvxrZ/g+jtZeA0LsssM0bqCNJIDU5AUHm?=
 =?us-ascii?Q?NFY8z2WMi41dX1l/yaFRS4DOvvb24dE9xxgxMnIMCKR9UK6RBor80LobWv3z?=
 =?us-ascii?Q?BiUV1RxN14w5RbGpIirbNSRRZv0jR7U8J7srgDz2Iw+2SjI9zoxLMIEFPkmm?=
 =?us-ascii?Q?0B63oTon2DnE9I9em69VA0MCMI2HO8iM9nh5hEcq4D3bCeyg5QgxtkPPiscW?=
 =?us-ascii?Q?+Jds5q7+N0rfx2JCtP0Q8T0OXcAYs32EWn7fIYiIarEZ9IROlusl8YoWz8jA?=
 =?us-ascii?Q?lxlfXDITYDt0Eymb4Y2p1ypMiVmnJghR149+5UW+UHm+zaVp813m4LFStsQg?=
 =?us-ascii?Q?YQ8Z6OTcS5hWcG8ou2MMRROzDXS49qDnGNbWikOo8OHlgKGEz6L1xmgghMrU?=
 =?us-ascii?Q?BjcDMhnuT9prC1t12q6ROXqVIzW5g6Vy0lGX758fjvRK98TtxZkXSjrPjaP0?=
 =?us-ascii?Q?fcQke5PL9ZN/9CD5qZifFxlE/JMeq6KHr1BZ0DHSv0WMlAYnA3+HvqWp+WIc?=
 =?us-ascii?Q?/tETrL/7q82bDdrRy1QQd/PHZjXeAvHgr4SqrLJgAGzFxss+3b+B+dTecQt/?=
 =?us-ascii?Q?Odw3Ep1a+XkG9lEBcuXbF6RvERcssGC6iehkbGvpZafWlbN83V81TZDm4kUk?=
 =?us-ascii?Q?U+yqi9XgUgKBba2CI3PzAwgOIlR6K0Pz6SyP3k5bpv0P2ik2CmUZopEc1vZd?=
 =?us-ascii?Q?1yJvrUQRgkkMjrtiv7HWDyCJpQGv1c5SNeyzk9fKfQ018KHZ63GlTPbRqION?=
 =?us-ascii?Q?oPnRu6U2PE60ffzFCpdbNbT4G1CKn3UX+64oz3P7alub2gCpDcdN+2FVVJkb?=
 =?us-ascii?Q?xicVPn4MgNOTLzRBhTwvOnQ5xHoAi5Qt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 05:06:10.3056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1a5373-726b-411f-2642-08dcb50c5248
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359

From: Jianbo Liu <jianbol@nvidia.com>

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
---
 drivers/net/bonding/bond_main.c | 75 +++++++++++++++++----------------
 include/net/bonding.h           |  2 +-
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e550b1c08fdb..56764f1c39b8 100644
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
 
@@ -481,35 +476,43 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
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
@@ -530,6 +533,8 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
 	slave = rcu_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+	rcu_read_unlock();
 
 	if (!slave)
 		goto out;
@@ -537,7 +542,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	if (!xs->xso.real_dev)
 		goto out;
 
-	real_dev = slave->dev;
 	WARN_ON(xs->xso.real_dev != real_dev);
 
 	if (!real_dev->xfrmdev_ops ||
@@ -549,7 +553,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
 out:
-	spin_lock_bh(&bond->ipsec_lock);
+	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
 		if (ipsec->xs == xs) {
 			list_del(&ipsec->list);
@@ -557,8 +561,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 			break;
 		}
 	}
-	spin_unlock_bh(&bond->ipsec_lock);
-	rcu_read_unlock();
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_del_sa_all(struct bonding *bond)
@@ -568,15 +571,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
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
@@ -594,8 +594,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 		}
 		ipsec->xs->xso.real_dev = NULL;
 	}
-	spin_unlock_bh(&bond->ipsec_lock);
-	rcu_read_unlock();
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_free_sa(struct xfrm_state *xs)
@@ -5922,7 +5921,7 @@ void bond_setup(struct net_device *bond_dev)
 	/* set up xfrm device ops (only supported in active-backup right now) */
 	bond_dev->xfrmdev_ops = &bond_xfrmdev_ops;
 	INIT_LIST_HEAD(&bond->ipsec_list);
-	spin_lock_init(&bond->ipsec_lock);
+	mutex_init(&bond->ipsec_lock);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	/* don't acquire bond device's netif_tx_lock when transmitting */
@@ -5971,6 +5970,10 @@ static void bond_uninit(struct net_device *bond_dev)
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


