Return-Path: <netdev+bounces-94884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C5A8C0EDC
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6C41C21035
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59269131752;
	Thu,  9 May 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RH5Eo/mL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B9013172F
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715254302; cv=fail; b=gEr20B6Z9VUn9QWhnAWkC3dr0pCJ01tvfDrDagHeU8m2i6//lb+pG0j8LUTxsj5k+yZSJYvqmXHsXillUfvsPhoHeIdekNRtA6bAG5LnJENK7C05hjWuLWfl51cYYKWkAQEe1d8a12aw6HiWW1M8ejbM7/xT6rIR7/kUjWsfmY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715254302; c=relaxed/simple;
	bh=A/2nIPTBXEIB5HVrtYPUp6p4CMTkuANxp1H+hreAp2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Axb6JPwUK1aRQSuVRYOdFegN52jDtzqUnlSTJyH3ozYxRfHtxSmbT+cNPn0mUFWaEqn6fUG9QxmsESgZOmh5rJ7DJfke/sprtkw2w/ITqpHoFL+Hi1gBt6gPE/QpOujBpRoxWVmV0JVSsSs3c0TdAKAjErNP00MRmQ/8HZGkswE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RH5Eo/mL; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fesqwokc4E9fFi+hTZGNpRiStRIcglXeNAR0QPXkOPc6bnAZqBjhzyKgvRh6P2x+Gk3pu+VxINinkoLQHcVrLhFUDDG1GMXQNDo5hHptlKWTpLKb9wzp+iBNjx9SJ4oHaK9ntcXwXCHaB1OrIhdB5iZIuYrudd5B3Hw0Tfx50GBnvm42axl2a4tdWOeHvoRjsX8jvlp2ksQBxzIwCULZyNIroDkE5SlUXRQcxVcpzWtgzsZInubyxh9v219OtYVsqqZOTC49NgtZvhgTAJZVWwOjBySMnYHKrzJtaSXcnQMBD4R7B1XaGV+3ArOG01JPJGkyIaOzI5mYmi+jUyQXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoV5TJ+sUED9nWbLBvuH1qNRMZatb0F/SZvvzkdoorI=;
 b=R73rMw24FdUPS0Bc1dLfAWzfI6Uddv0BPdPwvkrG8Ipe4VVM12HQgsMUOpRIr5OAiux6LZlVpl2aAXz+uGLBO2d8GS+2OKQZpZvGEQEq+NNFKg5S0nceXZqhfyGeGdrZLDViJzDIEZM22O11dn1eRk0Xos3EGPxXa6gK9Utsc0e+fJFIdJAtwlL+RUdZN3N/q+00uHkos6J+Fs+cAfq8+Bji3ZlXCaTFu1UlUVz1/ugCUYBZxc4pcIOJ3cn0MAfw3cje7Hptp17rlKHylsTyHTlnSp4QEyiQhCyqPdSoRM7WgwQIOrQ+SWBQuIKozAmAaBJbwZ6pexlPYa8UKLFRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoV5TJ+sUED9nWbLBvuH1qNRMZatb0F/SZvvzkdoorI=;
 b=RH5Eo/mL5nwTRFOlhu8aVtah8VnmRJ56saD6Yy+fmgdDOmZU4ajEkO74HBZEscd4sqy8NtTExSpZoOvzb7V8veXpZoB803V+niXjntdrBTL/Be06t6uK1bdti6DRMlKHUnfaqeZEhU8eFxEW5VUi/xFrmMJKOcD0kXrZD6VNkoYWK7TMMZtGpfY4F/olddUUo9Doui3otljnfY39tUv1yl62rl0wpMYOjJdk/bSEgWBviKQz1cP5SI8fLc8jkrBy1wzbmPcmu3htvKFF8SaICZG6xcTLn+PBrFNDmf36WrknU444keNhlV7ffrQQy/E+YNjYPlOdZ5BpW2YQVqag4A==
Received: from PH8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:510:2cd::20)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 11:31:37 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::56) by PH8PR07CA0015.outlook.office365.com
 (2603:10b6:510:2cd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Thu, 9 May 2024 11:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 11:31:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 04:31:15 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 04:31:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 May
 2024 04:31:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 3/5] net/mlx5: Reload only IB representors upon lag disable/enable
Date: Thu, 9 May 2024 14:29:49 +0300
Message-ID: <20240509112951.590184-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509112951.590184-1-tariqt@nvidia.com>
References: <20240509112951.590184-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e0fa75-76d9-42a4-69fc-08dc701b95d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?owDp07IaGydAFL/sQ1TvcsIV8F3M50UtIltpmyh0d8rCQaCuiZBWpxiDPNPV?=
 =?us-ascii?Q?EsK5rYys2u2cz088IRVrTZCiI62dnx4q4YoYfkYJ0MdYkv5YypifBzgRRsb6?=
 =?us-ascii?Q?6GQl1GJng7bJwGcnFhu3DOMqaoSu8oabN5DlUG/9iommDd4oZETOhybMkWQE?=
 =?us-ascii?Q?7MoKgiUDup2l2DLTDj00oHhg1oiWc5MbiPcqF+hcDybFeEKyS4Yvy+YwDX7k?=
 =?us-ascii?Q?BpTdmPAAR6toHyNI260uAJO+TEgdPheIbFVeNeqI7Qcqq7cAshbPHZr+Sbat?=
 =?us-ascii?Q?/mC8dDd6qljWyx1iXM8ePrsvsrEvIbrPg+EMBMRcHUIYmn3K4zvELlflOhim?=
 =?us-ascii?Q?AKO0t5D1VyxUrISuMjp2g1mcpWWBtZRqy+CWBss5tjjkRWBR+OYkSqjMfxMY?=
 =?us-ascii?Q?kRjVESXQnvby2b+FvZzC6wF5PCnTPFWhNmjUeCTeWuzXgfMyPSU7Km33PLyy?=
 =?us-ascii?Q?gl/FDbM4gSX5kUoRziw9xbLPJYgjo95kYl+3nZWyr59ShXL9ZkFtXXL/EVFw?=
 =?us-ascii?Q?QzdhChGtzvQIoqR//paU7dNna9RssVQN0LsjnXaM3K2t6XmJUu61FbWkqTZu?=
 =?us-ascii?Q?0Mbp0x7e1zXQw6gl2+n6M7yvGznNwHzTYrmXlrk6h2D5KflNutfYbg59wwoA?=
 =?us-ascii?Q?tM3Ac65kDb1YtUP0oJTFdoVqmP4mPY/21vz2bPrRTdQvJ5vARrQjKz1stwPW?=
 =?us-ascii?Q?CMGEn9iV/g+gkvZTFNsyioSdozrUThzO8rA9LLRujRVbSKdzaCmFhiGHRVjj?=
 =?us-ascii?Q?9D/KnLnI7CWC995VkBFgFQhzxEVxSYGeIqSjueipZY/xCoa3ITPLWFEul//c?=
 =?us-ascii?Q?qVIgxuccQfpo49FFwWaqXLrB4a/M5earN53qmvlRfCGthl3PzSg8oTm8wApk?=
 =?us-ascii?Q?KHyls9rMN+By7C+0wb8smdH3Gk6tw5aOgM7+JAiJpuE+QLPOB2gQwN26Gh+H?=
 =?us-ascii?Q?9Ova9mPFQP9gDJ84CDErWJcrQecOMxGvJBMb7D9qSehL7QOy6lXcCYdQHw7X?=
 =?us-ascii?Q?P9V0x2gXET+PiRxWyFzvatv+V9pXEPS5ZmoGJsrMk79oPdTSIu4yZVvjloim?=
 =?us-ascii?Q?fBMC0ISAeAAyL1tHtpiHgjPVUNL/mZSgnwEbScmve32sHdemTAvHiEOQSEJT?=
 =?us-ascii?Q?U8G8hogBvTrOy93nB6GC1tq7lroYlP6CZCVQF80vnzt38MyK6MURjyTNulTY?=
 =?us-ascii?Q?eFJXdpXcJYv7upFGGE3bU710UODVJr9XyH5MgNrSWPYAd2Fs+bsPO+ncpeDi?=
 =?us-ascii?Q?5vjyuO+39vN08f6n2cBw7fpFvQ0vdZwg2o9trwl382Dy6eFGf5rjKCcqf7NK?=
 =?us-ascii?Q?tPtnQ0nGhChjKhNQWWaRFov8iCGRoZEwwkIGuepzsVvmqUVElTbF/+e+Dh5V?=
 =?us-ascii?Q?nRY8Lgo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 11:31:35.9246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e0fa75-76d9-42a4-69fc-08dc701b95d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461

From: Maher Sanalla <msanalla@nvidia.com>

On lag disable, the bond IB device along with all of its
representors are destroyed, and then the slaves' representors get reloaded.

In case the slave IB representor load fails, the eswitch error flow
unloads all representors, including ethernet representors, where the
netdevs get detached and removed from lag bond. Such flow is inaccurate
as the lag driver is not responsible for loading/unloading ethernet
representors. Furthermore, the flow described above begins by holding
lag lock to prevent bond changes during disable flow. However, when
reaching the ethernet representors detachment from lag, the lag lock is
required again, triggering the following deadlock:

Call trace:
__switch_to+0xf4/0x148
__schedule+0x2c8/0x7d0
schedule+0x50/0xe0
schedule_preempt_disabled+0x18/0x28
__mutex_lock.isra.13+0x2b8/0x570
__mutex_lock_slowpath+0x1c/0x28
mutex_lock+0x4c/0x68
mlx5_lag_remove_netdev+0x3c/0x1a0 [mlx5_core]
mlx5e_uplink_rep_disable+0x70/0xa0 [mlx5_core]
mlx5e_detach_netdev+0x6c/0xb0 [mlx5_core]
mlx5e_netdev_change_profile+0x44/0x138 [mlx5_core]
mlx5e_netdev_attach_nic_profile+0x28/0x38 [mlx5_core]
mlx5e_vport_rep_unload+0x184/0x1b8 [mlx5_core]
mlx5_esw_offloads_rep_load+0xd8/0xe0 [mlx5_core]
mlx5_eswitch_reload_reps+0x74/0xd0 [mlx5_core]
mlx5_disable_lag+0x130/0x138 [mlx5_core]
mlx5_lag_disable_change+0x6c/0x70 [mlx5_core] // hold ldev->lock
mlx5_devlink_eswitch_mode_set+0xc0/0x410 [mlx5_core]
devlink_nl_cmd_eswitch_set_doit+0xdc/0x180
genl_family_rcv_msg_doit.isra.17+0xe8/0x138
genl_rcv_msg+0xe4/0x220
netlink_rcv_skb+0x44/0x108
genl_rcv+0x40/0x58
netlink_unicast+0x198/0x268
netlink_sendmsg+0x1d4/0x418
sock_sendmsg+0x54/0x60
__sys_sendto+0xf4/0x120
__arm64_sys_sendto+0x30/0x40
el0_svc_common+0x8c/0x120
do_el0_svc+0x30/0xa0
el0_svc+0x20/0x30
el0_sync_handler+0x90/0xb8
el0_sync+0x160/0x180

Thus, upon lag enable/disable, load and unload only the IB representors
of the slaves preventing the deadlock mentioned above.

While at it, refactor the mlx5_esw_offloads_rep_load() function to have
a static helper method for its internal logic, in symmetry with the
representor unload design.

Fixes: 598fe77df855 ("net/mlx5: Lag, Create shared FDB when in switchdev mode")
Co-developed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  4 +--
 .../mellanox/mlx5/core/eswitch_offloads.c     | 28 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  6 ++--
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  4 +--
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 349e28a6dd8d..ef55674876cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -833,7 +833,7 @@ int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
 					     struct mlx5_eswitch *slave_esw, int max_slaves);
 void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 					      struct mlx5_eswitch *slave_esw);
-int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw);
+int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw);
 
 bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev);
 void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev);
@@ -925,7 +925,7 @@ mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 static inline int mlx5_eswitch_get_npeers(struct mlx5_eswitch *esw) { return 0; }
 
 static inline int
-mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
+mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 {
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 844d3e3a65dd..e8caf12f4c4f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2502,6 +2502,16 @@ void esw_offloads_cleanup(struct mlx5_eswitch *esw)
 	esw_offloads_cleanup_reps(esw);
 }
 
+static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
+				   struct mlx5_eswitch_rep *rep, u8 rep_type)
+{
+	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
+			   REP_REGISTERED, REP_LOADED) == REP_REGISTERED)
+		return esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
+
+	return 0;
+}
+
 static void __esw_offloads_unload_rep(struct mlx5_eswitch *esw,
 				      struct mlx5_eswitch_rep *rep, u8 rep_type)
 {
@@ -2526,13 +2536,11 @@ static int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num)
 	int err;
 
 	rep = mlx5_eswitch_get_rep(esw, vport_num);
-	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++)
-		if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
-				   REP_REGISTERED, REP_LOADED) == REP_REGISTERED) {
-			err = esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
-			if (err)
-				goto err_reps;
-		}
+	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++) {
+		err = __esw_offloads_load_rep(esw, rep, rep_type);
+		if (err)
+			goto err_reps;
+	}
 
 	return 0;
 
@@ -3277,7 +3285,7 @@ static void esw_destroy_offloads_acl_tables(struct mlx5_eswitch *esw)
 		esw_vport_destroy_offloads_acl_tables(esw, vport);
 }
 
-int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
+int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 {
 	struct mlx5_eswitch_rep *rep;
 	unsigned long i;
@@ -3290,13 +3298,13 @@ int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
 	if (atomic_read(&rep->rep_data[REP_ETH].state) != REP_LOADED)
 		return 0;
 
-	ret = mlx5_esw_offloads_rep_load(esw, MLX5_VPORT_UPLINK);
+	ret = __esw_offloads_load_rep(esw, rep, REP_IB);
 	if (ret)
 		return ret;
 
 	mlx5_esw_for_each_rep(esw, i, rep) {
 		if (atomic_read(&rep->rep_data[REP_ETH].state) == REP_LOADED)
-			mlx5_esw_offloads_rep_load(esw, rep->vport);
+			__esw_offloads_load_rep(esw, rep, REP_IB);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 69d482f7c5a2..37598d116f3b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -814,7 +814,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 	if (shared_fdb)
 		for (i = 0; i < ldev->ports; i++)
 			if (!(ldev->pf[i].dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV))
-				mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+				mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 }
 
 static bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev)
@@ -922,7 +922,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 			mlx5_rescan_drivers_locked(dev0);
 
 			for (i = 0; i < ldev->ports; i++) {
-				err = mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+				err = mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 				if (err)
 					break;
 			}
@@ -933,7 +933,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 				mlx5_deactivate_lag(ldev);
 				mlx5_lag_add_devices(ldev);
 				for (i = 0; i < ldev->ports; i++)
-					mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+					mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 				mlx5_core_err(dev0, "Failed to enable lag\n");
 				return;
 			}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 82889f30506e..571ea26edd0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -99,7 +99,7 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 	dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 	mlx5_rescan_drivers_locked(dev0);
 	for (i = 0; i < ldev->ports; i++) {
-		err = mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+		err = mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 		if (err)
 			goto err_rescan_drivers;
 	}
@@ -113,7 +113,7 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 err_add_devices:
 	mlx5_lag_add_devices(ldev);
 	for (i = 0; i < ldev->ports; i++)
-		mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+		mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 	mlx5_mpesw_metadata_cleanup(ldev);
 	return err;
 }
-- 
2.31.1


