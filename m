Return-Path: <netdev+bounces-118858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E8953431
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA3E1F2922D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABDF1A7074;
	Thu, 15 Aug 2024 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bIxY4JSp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A71AC422
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731794; cv=fail; b=GxkAke3q4/sunMfQvdpQih2Ie9TULYgPpBuZkcizoc3ODEupN4FPuHDn5Q+CA1+YTiI/L2/Vik4GF4TJbbas78jWw9CI9eZXbvGXqOFJkDpxAjmbRrgHbVrwDMi8Dn98Lm9ulJ24TPLgCtWkcL8B9TLDCYFSeHKvksuiVobu9EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731794; c=relaxed/simple;
	bh=UjwwP4uVGf7GgxPXUlGzmvndlLFD3t4YMet3Sf3BlII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvcGYbqlHesMePN6NfoWFnOEf4ieoTwFER7C6IVBEDNXOKwaxFwXu/MUZDhv0R1ecYGUA5qcakyRJi9T+nsLI6tEkmxj4nIJ2RMUbZ9t36pXBN/C+hBnqNFMzQ/5/TSfKGeArwF68RFBzK/QejOtaDEREf/SbObs5hYgbygG0f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bIxY4JSp; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QV4jdq4BIc1bWUEiIUySMbCGTjHWWByjkxyu3uGQQ5DbNIa7tIrlTnW5b4Tums8QxNQARDzsLDSWS0JAiIKYm4tZS7jZ89bj/SuANeFntvyu3pYmhs3QuLuHGhCn/M/2G5G4fLACMYm5frr+ICHZ5N2ZPZdxoxnCfldIq3Kp8xCQLAX5SvG5T3l/Fn7y0B+fkjhFizTQOA9Pf1npxWubMOOKkR6a6VFzoWmbJ1BhjG9ZMKrrtNOH7HunPf3RvaXuY1vgjx87bjQV3CLXvyQcnSTnIFRS5gAqa/sBb24pjgTOCGxvKqrASOlw0z5YIftpuCtjdq0vWyUGVuxMorI9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHvQbCAk+QWZE2bjEMdqkz/3uExHydua1QOUVd8urnw=;
 b=LMX+clig5ZCYyWwR0JlXOMtRAYvWLoSuCo0HaWz8VE7MtEDpqx1z0LUxegWatppZhtu8KEiOOqfeKYE4bsT8kCJMkyqyStQP/dcFkNijtI6v8ttDBeUcgrOS2K2iwG94+2zX+w7WQnAQuJygpROR0MhKOHSkpwA5XMGX6k8HTKWTn4+bYiAzC+2fFDTS3n+3ke0Q4qsvfUUAPb344BeeKF3XXOYwMAuQWmtBOZ5XfDvCFnRyTrcJ2bGkd1zuZDiER6AnLOoAkjbYVGOsmPsDa+OZ0Ca2VdOJrRF9zXdgqSfocvZG72B42+5Bk+nM1h21QRQUTCBVVlgMq2MPA4krTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHvQbCAk+QWZE2bjEMdqkz/3uExHydua1QOUVd8urnw=;
 b=bIxY4JSpS43hFogh6EvMZOiloCFbkMwKzoMUkUmQqqlOcRThhjqXJ0wdljhIozENa6/5bhT5Y6d0iufl4eYJzAIpuoOddQVE+s8NUkM4WRaaUeJ0sA8LESqmuMqNlBj7KZCFQVdy7H4FYgLqxVhwf3/6abSnbtRXq8Ez2ttddFC9ORbWED8euc1O+Xn3JVjj7HyX73jYVKoflRmNndFU6CE0K7LmHcRgPo/bxB22FaLU/gjR7jD7W9Gc6XuGOySgHuUM/dYfBdeCdgpXR7CPhK2BwvN21PwdHMPpz4kVhaL2zzSNtF4AIhzY+75JeUB5Utsw0LD7qB6iYm+7ZCVTQw==
Received: from BL1PR13CA0436.namprd13.prod.outlook.com (2603:10b6:208:2c3::21)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 14:23:07 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::4e) by BL1PR13CA0436.outlook.office365.com
 (2603:10b6:208:2c3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17 via Frontend
 Transport; Thu, 15 Aug 2024 14:23:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 14:23:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 07:22:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 07:22:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 15 Aug
 2024 07:22:46 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V4 3/3] bonding: change ipsec_lock from spin lock to mutex
Date: Thu, 15 Aug 2024 17:21:03 +0300
Message-ID: <20240815142103.2253886-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815142103.2253886-1-tariqt@nvidia.com>
References: <20240815142103.2253886-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: e2adf321-9ee1-4805-2824-08dcbd35c891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FLXhRvNaETsZQYCUt9OSiqWnHm0rmcZfMh7j4cgKV6w2ezBR6FyVOK6np0Ak?=
 =?us-ascii?Q?jvtOmaLEYsFTXfznzDEZvceW9zqxbwAMOVbJn3OjssqAlWFLhnorUv2dv03A?=
 =?us-ascii?Q?ozP0Ppxiz7MGKgj3OY5dh7wBPdNV6SGf3WPrTP97bZN1t8xAR2KuLxpqHf18?=
 =?us-ascii?Q?z2bCC+PsW+kuguzbzKaWj1ICCkDrSN5rmvzT0DdRxurEif0V27+TADwxU6Qz?=
 =?us-ascii?Q?mn5b4gtCFN/NhihWXYz5+QlMLEwhKWC5Y/4Ia7U7tUqkY9uGVT7+wwbX/lnZ?=
 =?us-ascii?Q?7IUQtAu/IgYy4gzVUucS6DV893F5qsO1OrTkYkD+tvSBK6blIQE+s9gHRDe6?=
 =?us-ascii?Q?cQXmuYEEWU3qi+rVFeuRdtkZp/GbLm/+Owbpcyzt3eqRSmB8QkEGCOQuo6l+?=
 =?us-ascii?Q?gX7askB04VUixVq5OIGYM/ne6NAI350iE0mQW7T6Eta/Twu/SuGodwuvK7ZG?=
 =?us-ascii?Q?waCkR7gvORQktIHAotAqec75yZ9dQWG+IS1aYbwWrYPrvux6ffGBoa5VUNOy?=
 =?us-ascii?Q?UZo9vKTA+0FHagM43MjZ3CZP8ycjaLDCI+pVnO9fEGyHlg2bhhpxwi/WUGrU?=
 =?us-ascii?Q?nlsARyQqUlZIx5rNa2IgaDKrAIuLpTW4mMTCaSQjoxFoyR+ANYq6FIBgIoJb?=
 =?us-ascii?Q?T6LxXxFPCe1M58gRtkxHV/KaCYaF/GEj/LWuWN4QWMG0EjoQ/ganbrfQNBnz?=
 =?us-ascii?Q?JOf9UCi08RDqtCDXcLiPhOClfaoDdZ4Nx3jUWTjuaenETXwqkCKZf9aYQB/z?=
 =?us-ascii?Q?HdSzJkY1lDSCsztdq/TjXb8KVtvFNohl2AyVbRirktLAPOva/IOn1yd5iG4U?=
 =?us-ascii?Q?CVglULnqCuasuCTtp/7t8Ow+v1cWX+GcUrLHL4mEoRWDDTW4uzOGumZh+Tot?=
 =?us-ascii?Q?prhSWd6QTEag7kh4t2QZmaPygaCze9OjetXWI6HvnMcXey3nnceRrafha8Zw?=
 =?us-ascii?Q?59CbKcj4LeeYEGyk/w0Nv9BFR4mm9uY88tOXZU9nI60CuTR4Nln/CAWDjC+L?=
 =?us-ascii?Q?etM7jqkz4K3LnMtc60gwopboGoRSbhm2pfe0ODknVr856mCYO2eRMUPoYm/I?=
 =?us-ascii?Q?9ubq0rQuVOYlNze/sctiGE64N7/NnttJsSgIMWBXVsS4EfDNqNHerWBHj+Gv?=
 =?us-ascii?Q?eOxNSWROlgQEm4Fw1MxzGT+0qRNLuYZYLbBFd5tjkDmcylRoSQ4L3a0o4WXs?=
 =?us-ascii?Q?oVNFDLg3hMRoDZIGxBOUHORrxb/X1wTZpXrbzz+1Muj0FOudxZPbSdnaak5w?=
 =?us-ascii?Q?fkpwmHlDd05rp7WceXEjz7ByLtf14JyjHCrJ6kMXqD9mTMMwMDKh/fRzQsae?=
 =?us-ascii?Q?otre6YArfTjQxYg9vJ/oZ/ODfRqrR4XRWeR89/xJ3Dtaq0Y+Ao1UY2uD+0nX?=
 =?us-ascii?Q?XEXcAcWpjLMt/2Jkf+QhKzOwMbojkc+RHjZBfiUf5UOw1fl0LzYPWxq7cMOY?=
 =?us-ascii?Q?KQsdQfsnlPnqHcdjzrG+a6APxiM/QcIW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 14:23:07.3609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2adf321-9ee1-4805-2824-08dcbd35c891
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636

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
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
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


