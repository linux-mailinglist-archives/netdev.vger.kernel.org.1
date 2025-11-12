Return-Path: <netdev+bounces-237930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A81EC51A66
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265423A903A
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DE82E03E4;
	Wed, 12 Nov 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V5pZCm25"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149812594BD
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943019; cv=fail; b=gLYv5vj6zgm0WS3qGSKIbTaUGEhR7I58K5Krd5lEf+fD0ZDlW2Ln6kVfNBJAMjV2pDObRUhBeC5kLlvQFrclxquFA0spn5l9qkFIKAkSyIie05Uco+3AWMM7pgaV+f4Fr6y8nVLup8b4ie6J+tXTF8K9/fv4yNq/WnRkK9W+kEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943019; c=relaxed/simple;
	bh=s7fyfQ0fca/8WPJbZ2T7t4pHwJSp2ybUIFYjro5THKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bf1lZLb1cQpjg9tNyf2x/uK4p4Jp84NFDlGjTSvUXAsn1k4B1mbbbNtbjGXGHUaWkG9lE8vOYwTWwsumIJZ3jP0njh39BCyuwU8Q2Oq7E7XUQNoleA87isjTlRZiEjE7tP6zsVTy3Q+TB6ARZo1N/3vNANsiwNVbhIHuMnOgpeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V5pZCm25; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heLK92w3f6+8nl31oPNxGykHjaFnlUQwpW2h3WDzCwBgbFx56KR9tcDGwlyfu1QMk/ThCJ+VNv4vZM55WzrdX0Gbl58ELtPlh2AD9x84Gdgchxn0oMLCTQmfGHz59NPQxsF0PLFNRChZ+wFVa3eHs0+i4EFElkO8qXT+HNOKd5zrftVjPnqj7IFDNbD1GFjUBM2FwHzUpsb7VbLjk1i+YpzDOek4vkc9ftvpNW4VTuwLG4JWp489e0Qf/K6kthu0tLQ6qOOdZqE9jP1qTNj97/7KAkqennKM42OQJ8Q7hd25n9yt3tSNQ7qFKrv4nmpK7Vd17fRcISTKuzl/kitRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLtoGXXlZewtpCF3XG4k1KMilkYhGkzli22mMJQHGW4=;
 b=InSrg8D7IoqudoN6INKRdiKi5XXb3NcmOpFSGie672O00Hgkozt39a3/jhv33VhFDsxLXhrzScNfiwWIoHEMKvQnePTTQ+zVXCKJmMEjMUA+nFyFp9p/U3/+c9VPlvRJVPW0Uo8Di/hUiMoj+2sH0dZy25CHRzR2GSdbHMYNB/nDFlRj00znu5gW2Fv1Vy9ZboxfaLnZ8vtiuyJaGW+6xnbT5sXGNTeZfltpkh9bwHL5cvZ0wuxqwUGGg8W6VQUgXX1FfNCNRWB0UBAQ1Ll6iuSE4dLG7QU4pHJhiSJvwotIpV273FteCxsNRFMHDZbCRNXyVKL1hxAsktyr7r8jYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLtoGXXlZewtpCF3XG4k1KMilkYhGkzli22mMJQHGW4=;
 b=V5pZCm255VObY4hx6XwhVcsujx44nFIgPmEAth61WjotSFRKxzdWhtYv9IddiL8b9EpdISVFd7f++i2BDPbr9FNmvqJ5rHfofQEOvNUZMTuvZ1/hZN1Kn2khOoQRcJAuah4ALekbgFF6GntZdAEmG1IxxwGFiXmbMSpivVMZeKlMTqKs4eZ2pXCLxofxa/Ah0L5FM5vqWLu5a+XNHokD/VrtZIVBxpOW30K+Je7NKn6AkPHBmCmp7rKZUX5m/2JPbz3ilypnWJVXxJRuvURghpEFMCa/rq3jh/jvZLlI8wFsmz8DMzIrsShOP5HeBlo4zu5Rs7JM2kaaS7WKWENr1Q==
Received: from CH2PR05CA0033.namprd05.prod.outlook.com (2603:10b6:610::46) by
 MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 10:23:33 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::db) by CH2PR05CA0033.outlook.office365.com
 (2603:10b6:610::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 10:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 10:23:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 02:23:17 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 02:23:13 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>, Jianbo Liu
	<jianbol@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Leon Romanovsky
	<leonro@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH ipsec 2/2] bond: Use a separate xfrm_active_slave pointer
Date: Wed, 12 Nov 2025 12:22:45 +0200
Message-ID: <20251112102245.1237408-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251112102245.1237408-1-cratiu@nvidia.com>
References: <20251112102245.1237408-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af0fd72-8127-4193-acd4-08de21d58827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IuSNvxK2hPUd6YK4BX+6fuPBWlz65zbRKeS0pGwuwIJ1lq+Li62TemWBF67L?=
 =?us-ascii?Q?/QA7oGE4xrgplDtd3l8rdTFcJOt1Q3Y6JPIB8SdH+bG+C6BcZyBGCCU02U2Z?=
 =?us-ascii?Q?rGxG+q1Kefiu3k7n7MTqcGcdk7nftZNoR69tTxAluJFAidn29oVYB6/IKdKL?=
 =?us-ascii?Q?nkoUrSq1ZJtFcj6+QL0MY6t8aAXnvj8mJsspt/1Zbs+FDxovToUnDyni46go?=
 =?us-ascii?Q?X0FHTXByuwOnP5Lw0kr/YKcOhYHCdRHf3UxqcSz4ThyH680dnITRVDhka2k7?=
 =?us-ascii?Q?FanpBOs7eGKw6fcC7YlD0ooGGZVlOoWsFmikAUh4LK+R8+piP8R7UV5Go+3I?=
 =?us-ascii?Q?8v3BwbdGGHFxhPD3dAJqCshfQXES4IEw6j7EzzBkK9QIZT745CTp/QZFDc/q?=
 =?us-ascii?Q?lO1+/6fUQouztPX7z8DosfwIg+maJFOz4Qoibld4068CVYwRaiaE/2Qa1b20?=
 =?us-ascii?Q?v6bpOHTkxoBE+xMCWnca3tHXYWUKP+S1y6TyAPUeFfPz564QvrKgn8jEtOZm?=
 =?us-ascii?Q?H26A2ClfBMcC0Gb3IoaejZOxq+0zFQB46CcxS+vgS2Wt03z5nDeGs7Rlwkcn?=
 =?us-ascii?Q?5T0IMoASxGYAX19cge+BxGtgnbXHQp/r8gV6XuaCo9l/y/UQ0UuGedb7UaXG?=
 =?us-ascii?Q?knzooJbkb4fYFWKNctG+b71nu0TineKUdAX9P0KhrCndq4M/g0JaZx60TT4p?=
 =?us-ascii?Q?4g87gniwo3+TsREBmzpRbTFHs5PWWbk+x7LeuXRdrEkFwy7rWDEpfQqHvPlQ?=
 =?us-ascii?Q?Kem6eTWYX3yKfOX6yuCNLhk/uXLd0Yx4DGuG5XCW26xCjDGOnD/4PtEbQZa8?=
 =?us-ascii?Q?y4rJmG7PYKX+XyVUZyeX0kibO7WVemzZw7wiQTJdkho3t9n8y9lJjImwWaX/?=
 =?us-ascii?Q?rsnE2kMrkBnD+x8bFaykoQAaJE7I5aaGnmo7PkEE5HgqC4cFUX4gO2F6r+zp?=
 =?us-ascii?Q?E5rqk2MfBzSWFiHP5I7ny8lGgJ5NyfcO25GY8VTSHoVrg8Fe8010Uv8TiY59?=
 =?us-ascii?Q?RdCerXal6lq5aBPrYpDoY2T+iTpsOYsRWiQLfCQgSRUcJNFhIxk2/yPtzB/K?=
 =?us-ascii?Q?Fe2AaxkwFCCM7E+7TvrhVOaxNa886+RC8qUNZ5EOIjSq43WDiHW+ginJOdIm?=
 =?us-ascii?Q?9bAN2qrFKMtRPY3099LJsE1oFzHeBo9oeoKlRlJjLpX6UDJHxbuZjDIc0Jls?=
 =?us-ascii?Q?cxHsyUEtngSZkLoHSNsdtNVPK45/ZT0mnzo321TmQe/oH+A+IVDuztcfzh6C?=
 =?us-ascii?Q?cHOYr9XLcxWBB3ajjB5rsCvOiLrQKuKlcXphmdSw+Ei3XNqAN3B4Uflr+Kcn?=
 =?us-ascii?Q?mQKxrWs56LTSi3Jy9zMzwYXfZYxAEVlCCihu1uj5yDEzkSpOchViwlAE4m90?=
 =?us-ascii?Q?QTeb0MtbllOqXpKok2o5pz/sDrHJu1p24Od2IfG8LjYJlHNhCQmIKLzc7byO?=
 =?us-ascii?Q?HU4IZlLcurENGkOdFYDb+USSizY1vAm5QDeDeqWMjY/muIvXQVXoJeBG5o12?=
 =?us-ascii?Q?PEjV37z2VdgWE3sWf5qCnzpuNcYc/j1F8YBwftVc64ZVzvFmORDLQjJIWlmo?=
 =?us-ascii?Q?FPprFUKd37Pk0EoC0ho=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:23:32.7574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af0fd72-8127-4193-acd4-08de21d58827
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953

Offloaded xfrm states are currently added to a new device after
curr_active_slave is updated to direct traffic to it. This could result
in the following race, which could lead to unencrypted IPSec packets on
the wire:

CPU1 (xfrm_output)                   CPU2 (bond_change_active_slave)
bond_ipsec_offload_ok -> true
                                     bond->curr_active_slave = new_dev
                                     bond_ipsec_migrate_sa_all
bond_xmit_activebackup
bond_dev_queue_xmit
dev_queue_xmit on new_dev
				     bond_ipsec_migrate_sa_all finishes

So the packet can make it out to new_dev before its xfrm_state is
offloaded to it. The result: an unencrypted IPSec packet on the wire.

This patch closes this race by introducing a new pointer in the bond
device, named 'xfrm_active_slave'. All xfrm_states offloaded to the bond
device get offloaded to it. Changing the current active slave will now
first update this new pointer, then migrate all xfrm states on the bond
device, then flip curr_active_slave. This closes the above race and
makes sure that any IPSec packets transmitted on the new device will
find an offloaded xfrm_state on the device.

Issue: 4378999
Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Change-Id: I24a2945db8c4450a9abaceb5ec4379e85f10db84
---
 drivers/net/bonding/bond_main.c | 15 ++++++++-------
 include/net/bonding.h           |  2 ++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e45e89179236..98d5f9974086 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -438,7 +438,7 @@ static struct net_device *bond_ipsec_dev(struct xfrm_state *xs)
 	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
 		return NULL;
 
-	slave = rcu_dereference(bond->curr_active_slave);
+	slave = rcu_dereference(bond->xfrm_active_slave);
 	if (!slave)
 		return NULL;
 
@@ -474,7 +474,7 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 
 	rcu_read_lock();
 	bond = netdev_priv(bond_dev);
-	slave = rcu_dereference(bond->curr_active_slave);
+	slave = rcu_dereference(bond->xfrm_active_slave);
 	real_dev = slave ? slave->dev : NULL;
 	netdev_hold(real_dev, &tracker, GFP_ATOMIC);
 	rcu_read_unlock();
@@ -515,7 +515,7 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 
 static void bond_ipsec_migrate_sa_all(struct bonding *bond)
 {
-	struct slave *new_active = rtnl_dereference(bond->curr_active_slave);
+	struct slave *new_active = rtnl_dereference(bond->xfrm_active_slave);
 	struct net_device *bond_dev = bond->dev;
 	struct net *net = dev_net(bond_dev);
 	struct bond_ipsec *ipsec, *tmp;
@@ -1216,6 +1216,11 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 	if (bond_uses_primary(bond))
 		bond_hw_addr_swap(bond, new_active, old_active);
 
+#ifdef CONFIG_XFRM_OFFLOAD
+	rcu_assign_pointer(bond->xfrm_active_slave, new_active);
+	bond_ipsec_migrate_sa_all(bond);
+#endif
+
 	if (bond_is_lb(bond)) {
 		bond_alb_handle_active_change(bond, new_active);
 		if (old_active)
@@ -1228,10 +1233,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 		rcu_assign_pointer(bond->curr_active_slave, new_active);
 	}
 
-#ifdef CONFIG_XFRM_OFFLOAD
-	bond_ipsec_migrate_sa_all(bond);
-#endif
-
 	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP) {
 		if (old_active)
 			bond_set_slave_inactive_flags(old_active,
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 49edc7da0586..256fe96fcfda 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -260,6 +260,8 @@ struct bonding {
 #endif /* CONFIG_DEBUG_FS */
 	struct rtnl_link_stats64 bond_stats;
 #ifdef CONFIG_XFRM_OFFLOAD
+	/* The device where new xfrm states will be offloaded */
+	struct slave __rcu *xfrm_active_slave;
 	struct list_head ipsec_list;
 	/* protecting ipsec_list */
 	struct mutex ipsec_lock;
-- 
2.45.0


