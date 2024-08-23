Return-Path: <netdev+bounces-121224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BCD95C39D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 05:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689031C22232
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF9938DEE;
	Fri, 23 Aug 2024 03:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZa0Wpa0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC3364AE
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724382696; cv=fail; b=RO484nt01t9KzGKL3oplbjqRz51eYwHacUxDwhppZokzpQqsvE29Ti/WT6UJsNK75crqk0Qr/+hxT6fyI6AGKJSd0N+1eRz0XsK7U+om0E1XLqt8+H6OUAg4oi4SYDpuM7mdIQKHbUcfr+NugcnuQ5/l7w9ROAship//AfXyj0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724382696; c=relaxed/simple;
	bh=LjW6m0xff0Q6t0jvxr8tdbegiRqS7+Qvdsk9vmIXZJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prKrXOwcdUAdpeEQHVt2fD5n376awnEjQvheh2LN6+b/udAupvJfXWZ9JuCvwXjYxE2XaNDDSjo2P2lOM1TFMec1utstRtuECgEB36+mtpPHoNQXQU4Wwz5RxhIR3O82Q6KB26b1wd9vhDEOFNyoPcNrkpmfV2iTkTncUbKJkeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZa0Wpa0; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8xwDGuj7dAbfhWhQqe2L3oOZu85r967LUw9wLOefp0IzwagCF04X2I33svPVLI6s/b60rEwe6LU4yelQFvwboe7nwNDu94/9mmagDrmbRyejPjwEFZwpxNtJRx0GpuYupAuvoGRA5fSr4vOuSWOUeLVkN6PY8mLdPtk/FAckmSdkIOIVvPTfuFB3VbDylVp98O3G48BL7LFWH5ZMUtyyfg9WBNbWm2giHUXlYBlk/fP6LTY/SqMgDUnAOfbVk5T3XzG0/kOzkfZBLW3IMhTisCX+oGB/tlTpnUwjNsM7ckn4ASzFIoRNwqnBkGSQe51F1g0yziuPZylfoyS6ecZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/yjKAqdE4Xtu4G9+fEwFj7rEaZi/+iSe5mpRv7GZjs=;
 b=OsJoogXvjyjhF/XH9arwLCJw+iLnGeUD2lywtAexkgiZKPWjTewv3ME73Uvh7exCcLe0a93ihResCf7xbTnZHDZWR39z4TEMAqjvsbNuctbiyhH3hJaatRmttwwJH1S90YzMuusRvbiiv9P1Omng3wtcDTB1iutvHawVx6bVeJVYlBgpNfgawPA9tbRUxl4a+LhslQyXApkA+Djf/UKCfSaORDN1UyBdsDYUIaM5R+VMn3T9XeAsGhilYbwn6v5lzq1d0W2FY5tGvrAHkq6ZJPPWA5t9NFLe3BueB4IoMYh2naWz6kv8lTSPw9AsVFuP84PFkUW2XEo9657NJN5s/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/yjKAqdE4Xtu4G9+fEwFj7rEaZi/+iSe5mpRv7GZjs=;
 b=JZa0Wpa0KxuQwl/CJrpj+6tT6vxTx/R2FAdCUKTs82lYH+X589A+B92bN2kzBKEdEefbpvnrb/0R0VYqqLP+MvWIeHA1VGADGY3yV+WuNlTBZ2l71fsb65uXkzOhnAWS+IRmKcJSOwQP9wgy0OE+xIC8lh1LNStnzHIKkoD8ycrFj6LOUAfW0sR6jaWbojaMKzhOuFHnheL/FKSIM41/coTVGfYxJdfLPXpf/jWd7c0zHaFigYT6Ff1pMMdrWdRuuL3za0Zxq9S5zwvF6RUbZieZZAjrzJg+ySIBcoH4/yN9DmnTcrwb7j2F41TZRX5xA9mHzzEvohQLuTWISv7xAw==
Received: from SJ0PR13CA0094.namprd13.prod.outlook.com (2603:10b6:a03:2c5::9)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Fri, 23 Aug
 2024 03:11:30 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::d2) by SJ0PR13CA0094.outlook.office365.com
 (2603:10b6:a03:2c5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 03:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 03:11:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 20:11:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 Aug 2024 20:11:21 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 22 Aug 2024 20:11:18 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <jv@jvosburgh.net>,
	<andy@greyhouse.net>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<liuhangbin@gmail.com>, <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net V6 3/3] bonding: change ipsec_lock from spin lock to mutex
Date: Fri, 23 Aug 2024 06:10:56 +0300
Message-ID: <20240823031056.110999-4-jianbol@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240823031056.110999-1-jianbol@nvidia.com>
References: <20240823031056.110999-1-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: b93282e4-d2b3-4d91-4843-08dcc321486e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Gjcg+y87KcB2xnoh1purBEP9ydndh93Zn4rjdg3njyD4+w63/CDPzOL5nSF?=
 =?us-ascii?Q?N62E6NzIhe7HfOu2z8ZNeMzYqsOodgBRpwH89cQ5Rl4XQ8Hc0xR5gkpyzZC7?=
 =?us-ascii?Q?3G5vsnJg9BQXZdujhvClMHI2ISs69DhpvssnWLiFpGzU+M4vh6/BK8CMQSyI?=
 =?us-ascii?Q?0yZ5jiY4w1l78RIc1BaTXnEu3SpMZydFImTaKbQ7RHcCE1xm6fqQ31trULIu?=
 =?us-ascii?Q?ZxDaRIBJtpfMg19/oQVQsYXAvF4F5kqpmmGkuA88aF9XgLgovHvjIC4fU+ju?=
 =?us-ascii?Q?/uEswZl3tH43PRy5XEJEzEvI80kHeuvqIkjpuuw116+fgcbiejSOkBEPAEYS?=
 =?us-ascii?Q?mqL+TZg4MdOtRElVi7hrpw2BfbK3MP6PL4qEy1PYSPFDUFZsegUQmImZeTfc?=
 =?us-ascii?Q?6i3PynIKu6J6I8t0qyFbDDEZYF664jFsbGyC67SdQJLo8URMnI1fBaQL72L5?=
 =?us-ascii?Q?mPQOzoSEvuFa4KTplKmxkGgXCMS+/Qn7TOhTKEx8J4ZT07A02wZ6c6BP/Woc?=
 =?us-ascii?Q?iRTVRI2Ux4CRXzGL2oW1FMowzRcTsdlgnJEGkRmnBBGEn8q/l1P8wPlLgyJ/?=
 =?us-ascii?Q?MesrDsyrSxCVWTqTZMBLcvTP21hgQOnfuaLztZmOdLhoDHXoUvIn2UXIyb5S?=
 =?us-ascii?Q?6EZuXrq4tIPdkGrS32foP3bkm9Ewm7jJHd20gIPn69a3Ils5CTXb1Nvk6dUl?=
 =?us-ascii?Q?zSPVwM4t26NdxKcjfKjKMgEIayg2wI1EmFxKxhNdWpnPyvSNKWaTJpRc1XEo?=
 =?us-ascii?Q?GgNcHmG8Pq6HTTpxZuxhUGWtaGETscLyUdZa8g2q4VT7bnEsrtAIUBmupmsS?=
 =?us-ascii?Q?NbO++gsUkloep1QQ9l8TRUCsoF1s04F4B6EBL1HjuMQY3JoIVv1h51M/LEBP?=
 =?us-ascii?Q?r1THATzHmCq11i3W8wwMLEPZQroEc/f1OBGXp9RX5f3/IL6J9DPA/QRjnHxh?=
 =?us-ascii?Q?7CmImyEvpBZNNTEbOSpDR903a76XYJOsSdodevDe8gyHy4QeJOksdyfp9oKp?=
 =?us-ascii?Q?YERWZtkLhpG8t0WbWDNxgT14MMgaoSJ8gB6sDNi2RC/0aJMkmrJDAQtfMA8/?=
 =?us-ascii?Q?1GDt22GdnP7lqIXaNiLsgLu7A5Xdkip2bRWJwkPDM1/9xiUSDLtE0IQWLvdt?=
 =?us-ascii?Q?Nk4em2TRNxWZy6lTHRMQuxWTL1s7SmbZq2QahLtbSqKOHUvkH4td3wgzBFgT?=
 =?us-ascii?Q?PUYVE21uA7ldcnoxMdyqpQ6yM/O/7PWH65+hhaxQBAJE7yKYnqRjQrGeE2iX?=
 =?us-ascii?Q?dF3yt6HB1gKZKzJFEmzeBpjMmJLnp6J4HoER+PUA1YD8reYHcgP3W+EMS9YF?=
 =?us-ascii?Q?GpyxZzLC5/lOPQjRB7qsmZj3Gfy3Ebyr0fwBi0I5Ip7FDUWEPafJsGa/MQOd?=
 =?us-ascii?Q?Gtret48lCKvklRuItgy9+0iAEAP0yTCkOhQXa0xneli+QwqucsBn/6oOLdBp?=
 =?us-ascii?Q?kylztFmjx3bKgnviubSCSlT9fcpbJ9Yq?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 03:11:29.6135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93282e4-d2b3-4d91-4843-08dcc321486e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

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
 drivers/net/bonding/bond_main.c | 79 ++++++++++++++++++---------------
 include/net/bonding.h           |  2 +-
 2 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f98491748420..bb9c3d6ef435 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -428,6 +428,7 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
 {
 	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
+	netdevice_tracker tracker;
 	struct bond_ipsec *ipsec;
 	struct bonding *bond;
 	struct slave *slave;
@@ -439,24 +440,26 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
 	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
 	slave = rcu_dereference(bond->curr_active_slave);
-	if (!slave) {
-		rcu_read_unlock();
-		return -ENODEV;
+	real_dev = slave ? slave->dev : NULL;
+	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
+	rcu_read_unlock();
+	if (!real_dev) {
+		err = -ENODEV;
+		goto out;
 	}
 
-	real_dev = slave->dev;
 	if (!real_dev->xfrmdev_ops ||
 	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
 	    netif_is_bond_master(real_dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
-		rcu_read_unlock();
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
 
-	ipsec = kmalloc(sizeof(*ipsec), GFP_ATOMIC);
+	ipsec = kmalloc(sizeof(*ipsec), GFP_KERNEL);
 	if (!ipsec) {
-		rcu_read_unlock();
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out;
 	}
 
 	xs->xso.real_dev = real_dev;
@@ -464,13 +467,14 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
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
+out:
+	netdev_put(real_dev, &tracker);
 	return err;
 }
 
@@ -481,35 +485,35 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
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
@@ -520,6 +524,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 {
 	struct net_device *bond_dev = xs->xso.dev;
 	struct net_device *real_dev;
+	netdevice_tracker tracker;
 	struct bond_ipsec *ipsec;
 	struct bonding *bond;
 	struct slave *slave;
@@ -530,6 +535,9 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
 	slave = rcu_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
+	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
+	rcu_read_unlock();
 
 	if (!slave)
 		goto out;
@@ -537,7 +545,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	if (!xs->xso.real_dev)
 		goto out;
 
-	real_dev = slave->dev;
 	WARN_ON(xs->xso.real_dev != real_dev);
 
 	if (!real_dev->xfrmdev_ops ||
@@ -549,7 +556,8 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
 out:
-	spin_lock_bh(&bond->ipsec_lock);
+	netdev_put(real_dev, &tracker);
+	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
 		if (ipsec->xs == xs) {
 			list_del(&ipsec->list);
@@ -557,8 +565,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 			break;
 		}
 	}
-	spin_unlock_bh(&bond->ipsec_lock);
-	rcu_read_unlock();
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_del_sa_all(struct bonding *bond)
@@ -568,15 +575,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
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
@@ -593,8 +597,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 				real_dev->xfrmdev_ops->xdo_dev_state_free(ipsec->xs);
 		}
 	}
-	spin_unlock_bh(&bond->ipsec_lock);
-	rcu_read_unlock();
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_free_sa(struct xfrm_state *xs)
@@ -5921,7 +5924,7 @@ void bond_setup(struct net_device *bond_dev)
 	/* set up xfrm device ops (only supported in active-backup right now) */
 	bond_dev->xfrmdev_ops = &bond_xfrmdev_ops;
 	INIT_LIST_HEAD(&bond->ipsec_list);
-	spin_lock_init(&bond->ipsec_lock);
+	mutex_init(&bond->ipsec_lock);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	/* don't acquire bond device's netif_tx_lock when transmitting */
@@ -5970,6 +5973,10 @@ static void bond_uninit(struct net_device *bond_dev)
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


