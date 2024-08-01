Return-Path: <netdev+bounces-114886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6939448CB
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEC31C2283A
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D1C137748;
	Thu,  1 Aug 2024 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UotjrDS2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5316FF48
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505874; cv=fail; b=d/D5qqSmnWpZJy43ZwkpLJPdY3bL1sjIDqP/QT62ykidOsOvSE6C60ae5gPa4wnH3y1tOkPdkUWmFri9h1RDyIulgtjTYgettRC1XVlZceIEVpD8EmbRi/ud4NhHUU39WlwA6WTxdDXx1azrYER05+s1+QVX/q8MS0QTEo7hS0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505874; c=relaxed/simple;
	bh=0FxIku6JRZjQrfP3dwU+F22X/jsDhvsk8D6+93suyRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuWcjq8829TeIB9WMqCSz6pJu58I4rDFonj6H8oXL36U38W0TymiboEjbdEADA8hnE3N+lndhZbmjkLffEeZxdxwlyGUDrnZvZN9vWByHlNTEh+T91Ns8OJ9j92DCYkdmY2is3QJbeM9EbZgRzu6IiwKVIP5VZfEU0KT9bNGhM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UotjrDS2; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj+bjzaXDVkDyg2TARW0yPL6ORPXeIjeVTEzA8myXeOxH6KV8GPYv/iljz21/cWRETni3XT5c8WkftyyImk/XdSze/4ff4qshfwg+Rs2c5Bi5xrtGpzvXXUfk4uRXmx41hbcPlIOaUznL0TsJtjD/ewy3ew2dJ+xBIFhxXOMvCDmbEIgbwU6hKt20c/opWFyABIczG9Gf1Ux5RdTRs6HoVBkenE4CcfGVzSeeY4t6Vi70vq234DeIvrCRjfgNSP/hDJDCvP6/brx4Av5aW9CCiKS/+AGR+Vy27iqT5reBOC7kL5CydsUbOFk0c+SfDsqFkZljd4u9dl5usA1CjFL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqC8iJupWHrzceM8Ypurys4yCxOobvPDGLjfbXA5CE8=;
 b=gEwNjTIX73C5DuuamwChszkSpJJuP4SFXDd5eh8J1ytewsUXP9l6MObTRI80SeraYudKv1FlNk2sJGyPAMRKPdUtK3qvngpsBnULRLksbkUa6p09CHTKL+th60xVPs3iS4NzEkTf87bihpqc6+WyOvLt67K00AapLPEyymPQLdh6kAXQBvDrNIPUikpHmFikBSahIlLMFis0ecg0W7SLtF4TJypKE4Od9SvF+4VZY53UyXzcAsnDRsK2VmPqKu97Sh0rmCXCKwfo6lxoVpsq0iUi0e9F0pZCCUyZyfiUEQG2GA2XVOPdE3aALrNjJm+eJu0L4ZeZdFQ1UD/hBimyXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqC8iJupWHrzceM8Ypurys4yCxOobvPDGLjfbXA5CE8=;
 b=UotjrDS23dP2wTOLIa3x06/XPcZZaoVVUG+26R7Cu2WaxZevDT3+8JnySfuX9hWbGzwDY2O3HVa5qam9llqUln9bEe8VG0uND8t4T6qU6iuZTZdHNnvrftB2rD2KRQIONC4d7Gja8mY8RS/vHfGKUupb+iwplmQUhBunh4ErT03+1tBtHD0S/mYFuda5t7QYBchSV8xAMAfFaINbaOUtPsF2idbC9pKEBBNAs9DbO02GY/6uHFLZ60n1dSTKQrH+8pYtTHiT6R03mN1CT0Hu0+d6DyEGisNKKiiPA0ZkiGy6q05XJ0ksn1o1/bTwq3VCgsg7LBURR1uJq7vBlp02MQ==
Received: from BN0PR08CA0002.namprd08.prod.outlook.com (2603:10b6:408:142::18)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 1 Aug
 2024 09:51:10 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::d4) by BN0PR08CA0002.outlook.office365.com
 (2603:10b6:408:142::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 09:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 09:51:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 02:50:56 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 1 Aug 2024 02:50:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 1 Aug 2024 02:50:52 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 3/3] bonding: change ipsec_lock from spin lock to mutex
Date: Thu, 1 Aug 2024 12:49:14 +0300
Message-ID: <20240801094914.1928768-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240801094914.1928768-1-tariqt@nvidia.com>
References: <20240801094914.1928768-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0ea959-2f6f-49d6-a691-08dcb20f7829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zZNP0BakOeseCEvsc9GOQnUBOtS5b9lp7yHNzaLAbRS08x78+tD3zBjgm4yP?=
 =?us-ascii?Q?uaS3ebPOAkumSzHRjXm14KtoypDYXcXIDqz4WowcxKW5IvtgFEofRtSssr4Y?=
 =?us-ascii?Q?UHe0wfCUId0Ld+118nRt0P5JaTmg+TPuiTo+6pyB7ES0HrI4W9/yTkjNIEGx?=
 =?us-ascii?Q?T6tALz6TFgaVigMJOD3uHGZm+UOaf0ZWZl9F02B0iRbsaKYeNz6AtkALuV2J?=
 =?us-ascii?Q?s9OJE1rs4R0hV3+/HsjB444FAQnjHIlYyu7t1MXTTwOvYKLedoXMdrRvjyNk?=
 =?us-ascii?Q?5vu2ufOXnZkC4X9Z+H/LAYMgazW7Bo97L1dB6SGPXo0FVZEh2/XfAPl8OjXe?=
 =?us-ascii?Q?JfkUEUT2XnzyRkX/FkZY8NUqDdNzAkE/+QyuFVIMJpdNVe8QVqo9gcs9B/H3?=
 =?us-ascii?Q?0133PnVaKKp7lntPyiFLbatTdBp01Ioa+5oCehGROEcNIFIbddeFuio2d8c9?=
 =?us-ascii?Q?dlEzZeOyVSwV//zjaMUfp6xZuQ05khOLL+YS0cq35Oif+ghRiDaFIE6+K5T5?=
 =?us-ascii?Q?rgeFRawZktetRwcvU7gFRBs35gQUXo/7zZLJl7f9BjH5EOrZAbucIWl5eiTW?=
 =?us-ascii?Q?Beq6TQBssC22j4X7hJAN/56GDNPAgjvPRsNrsxS4kqulS+74FD81WEASLjNg?=
 =?us-ascii?Q?MAAlbmcqlowbqGcg4uWLbuXnEHl+fi4tCYYbPWREc22z+3g/QgdfY1BjagQc?=
 =?us-ascii?Q?lHH7JEpWGnINa61UOrlTdFaymVuHSrhsI2vJ5qg0O6Ymv+Wa796yniIf1EmU?=
 =?us-ascii?Q?agXD55+FyiXo2r5qG0OfktaHpzj7GADu2o2xFTTlJXhjuO1TnWDgT7DqeaAx?=
 =?us-ascii?Q?iAYWAE+4Xen2iqCxeRG2GGWYx3jSQjbm0q5cyxq3KRGfi6AgPUuPTZv0E5Ud?=
 =?us-ascii?Q?pUVC12nC94En3N4KtnUWbnqOvj1qKBHLGI3sgToxgAZfMhdczp+atwx0inBQ?=
 =?us-ascii?Q?jtq3I4YYKkW8MRF9ImvOUZXBoXxSW99Wq1fHs/JX2XF9Y5ChbrnLr8D9lMFJ?=
 =?us-ascii?Q?XCzEKQ+6rdee0GKoc4AaeZUg6C4Z2PPlBfWcfdulrjrOIw767/+kAeiVwMx2?=
 =?us-ascii?Q?AKGzzfD9jT+O+ZOF3CyonKGC7jyWN9tmmOeZGDu+xqP0VNOMkd6UWcIWa8p8?=
 =?us-ascii?Q?UNvwkoNlT1PDSruGfe8yo2t+ON3HzwJ8x2pR0c8BI3wlslc7VzCUdrIV4wq2?=
 =?us-ascii?Q?VG7cT2+FM1NxjBR7RRwwofpiDWfZDEMItFp82XilwKV3864Ee3lBjnehb/Kd?=
 =?us-ascii?Q?FMRIpF54XfFsQ3k1m/DoITUiyopKgxkWjHcNxxm2u1tmZJOtqsW6987+M8RL?=
 =?us-ascii?Q?oiZrXSHVe6IcO1zsZnzFiZrK2iCOE5Wq04iFyhrXmruF829LnTjEUtUx9i4H?=
 =?us-ascii?Q?ZSWz4+k1gxkTJtDOzI1Gyu1Uc2N0zwVp3VxmH20pnzVIO0XvYLVaQc43MxJl?=
 =?us-ascii?Q?CprebDwjyqygot02FF/Q4+G5EP8/LujG?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 09:51:08.7985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0ea959-2f6f-49d6-a691-08dcb20f7829
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144

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
 drivers/net/bonding/bond_main.c | 75 ++++++++++++++++-----------------
 include/net/bonding.h           |  2 +-
 2 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e6514ef7ad89..0f8d1b29dc7f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -436,41 +436,34 @@ static int bond_ipsec_add_sa(struct xfrm_state *xs,
 	if (!bond_dev)
 		return -EINVAL;
 
-	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
 	slave = rcu_dereference(bond->curr_active_slave);
-	if (!slave) {
-		rcu_read_unlock();
+	real_dev = slave ? slave->dev : NULL;
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
 
@@ -481,35 +474,43 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
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
@@ -527,9 +528,9 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	if (!bond_dev)
 		return;
 
-	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
 	slave = rcu_dereference(bond->curr_active_slave);
+	real_dev = slave ? slave->dev : NULL;
 
 	if (!slave)
 		goto out;
@@ -537,7 +538,6 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	if (!xs->xso.real_dev)
 		goto out;
 
-	real_dev = slave->dev;
 	WARN_ON(xs->xso.real_dev != real_dev);
 
 	if (!real_dev->xfrmdev_ops ||
@@ -549,7 +549,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
 out:
-	spin_lock_bh(&bond->ipsec_lock);
+	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
 		if (ipsec->xs == xs) {
 			list_del(&ipsec->list);
@@ -557,8 +557,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 			break;
 		}
 	}
-	spin_unlock_bh(&bond->ipsec_lock);
-	rcu_read_unlock();
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_del_sa_all(struct bonding *bond)
@@ -568,15 +567,12 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
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
@@ -594,8 +590,7 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 		}
 		ipsec->xs->xso.real_dev = NULL;
 	}
-	spin_unlock_bh(&bond->ipsec_lock);
-	rcu_read_unlock();
+	mutex_unlock(&bond->ipsec_lock);
 }
 
 static void bond_ipsec_free_sa(struct xfrm_state *xs)
@@ -5920,7 +5915,7 @@ void bond_setup(struct net_device *bond_dev)
 	/* set up xfrm device ops (only supported in active-backup right now) */
 	bond_dev->xfrmdev_ops = &bond_xfrmdev_ops;
 	INIT_LIST_HEAD(&bond->ipsec_list);
-	spin_lock_init(&bond->ipsec_lock);
+	mutex_init(&bond->ipsec_lock);
 #endif /* CONFIG_XFRM_OFFLOAD */
 
 	/* don't acquire bond device's netif_tx_lock when transmitting */
@@ -5969,6 +5964,10 @@ static void bond_uninit(struct net_device *bond_dev)
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


