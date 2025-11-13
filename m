Return-Path: <netdev+bounces-238282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F8AC57024
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18703BFD8B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893A333733;
	Thu, 13 Nov 2025 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O5pLJ/QP"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D8333438
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030644; cv=fail; b=GK4KaAJpMYI7gPUIpTZIy/GZ0ZI68mwopmm8xA8GBOoOZzsE7kazt3dteCnTNggWCJhG3iStCjbyfq+ss81BgTGaQ/S47VSElo5cb3R4vib0InRHnb5DTtYfQMKM/ITIjMdvoayTdtKyxHuoTxFf9Fb4FsQ5hfVLw5MU6OtR06I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030644; c=relaxed/simple;
	bh=+OI4h1sBSoXSN4lSNpn1ckkfeEpOpOPY5kM0tXFFI8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqVEd7T76qT4m0Qlv01wO3uOwNDKIkQmPuwPzHpAhPca72jKPZlIUcBbz20W3lH41urCI53ebDrE5y3WaylutQIIVPVVyd+LBB16qSU0Me0XLwKsxp/a+t/uczpIemukKFmvhTAx18/t0UtNIxlNExKU0qmrtr3Eo74G9iSOxjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O5pLJ/QP; arc=fail smtp.client-ip=52.101.46.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOLKz50EXGDTQcPMZj3uy3qGYUfyRICPEeDEDK7R8AoEXGV1rBRpjF3jtT+AlpcMScIZ9Y+URmOq9BpjisU6lw+C/BJG3D5lcJdHc0kibuT7ABLcGMGZlv7Yj3xAZQEGiYPPY/ltcT/tD0N6X4B+BO+6wVI6c1LJsfqSPeQfj4BWJDrhN/U/2+Qhtw7f1/iExM6DufZ01bzb9oLOIw7HB2qwkU0NgfEICOGzhisDuSqelXoY18EqyRKETNGSLI5+s/HHaaVSiWL3QaUvMHlPZ+PBYXYjKeggCcvV/30dCDspNGDWAQhtPIfwP7F41UaiD2AePkliwOAruORumlLDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfMvLRrtlqJwEhMKFrYwy+VHaVFFoX6OizWjTI63Fhk=;
 b=agoIjueK1SBgLs5GqD93c9bVB0CEC6gQ6gw2J3s6Wo4GIfmBcDqHa/bUMCSjWbTmtvdgnup20SLe9k6MNXiyDkZdHWOZcnEZBQBmIqE74Zh5vpaLGLJS+PeTQ446dRB7Q4zYtaO0VbneU40pRID4WFUAT3cc4VW1PHTAcm/TSvdFBGiajM/DoxPcVgVt+4clVFIeA/eAsVaRVC3gLT1b8OG8sm5rdUwpYSUnpIFP+Sy2GnJdmMkaCjt4iAKskhCGRITx3A7GR0Ayd+f4i+uWMVu4NdFhDucAmy+9elGN5QIKikhWWHUAEuzVisHwSOE0zUtI/dFzHPWrCD9M4uUvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfMvLRrtlqJwEhMKFrYwy+VHaVFFoX6OizWjTI63Fhk=;
 b=O5pLJ/QPhnwUtT/f5CP2p2oO1aBbjZKHeHBHmgzc2fol6+1dDjVfomaJ9mYu4/RNuROQY3knYBBmgPpmfCPX42rnRiDBZVfhKP6zJNb8LIA6qY5eU7S5ibA/XsOEmO6uTSdahmDHQMoEDEVMEwzIx6+hgTdKGDMYxmir2HfbUz7FXpN1h8IscfHkTs7/FNic3ZsrfWx/F6sDnMd7GCGIW5qjYzyyaR6Cp3YYZBpo5DykraUFZn0Nrx+PMQd6JNs4r0wZzIJ/6JcCtrKmXWy4OXT1P6Vcn395Z+0aL7NegLusvbNymEBKRZlO4lbnKiyhUaO5rMGCeBhTJ6WKTkYMtg==
Received: from MN0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:52c::23)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:43:59 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::62) by MN0PR05CA0029.outlook.office365.com
 (2603:10b6:208:52c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 10:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 10:43:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 02:43:43 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Nov 2025 02:43:39 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>, Jianbo Liu
	<jianbol@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Leon Romanovsky
	<leonro@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH ipsec v2 2/2] bond: Use a separate xfrm_active_slave pointer
Date: Thu, 13 Nov 2025 12:43:10 +0200
Message-ID: <20251113104310.1243150-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251113104310.1243150-1-cratiu@nvidia.com>
References: <20251113104310.1243150-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 89abdcb2-9a56-4d0e-4cd2-08de22a18d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i6Cru1WrKA5rNCESs2nJo/jfYCTZdmQ5NvobHrI23NrjGLffc2UsE8MDiFdp?=
 =?us-ascii?Q?IKq8Q6K8euraLxYZiJSJfzwjrtLX5lXti83WAVlf9d8NgOca4/VmEpVRh/wg?=
 =?us-ascii?Q?kWw4qTdJUXxp4OXQ2obL6mKqw/LQ5hibXcTfGqbRmqA9yxsoyIJ2uwMH1ooM?=
 =?us-ascii?Q?T6f8va9BibAGN+Y9iXeKtu6g2Bfiszr9oBWxVppa+xGEXSqFD+xaflhVfDWS?=
 =?us-ascii?Q?Y7EmybXes33F84mtHWtky5a670UqClWqR5hO3fN2dAfOcrpO6RBkEIOHNxPY?=
 =?us-ascii?Q?D2tAFTPs4DidEGuKGDU28olg9dSIzTo4zNbqN1HHgX0MGG6FeMm9ayodsKBx?=
 =?us-ascii?Q?43AO63a6j3MnQvGSqBbWJXui1QZPDP9i2jjLm6ukK/Ez6EAMw/tMZfSgUeXg?=
 =?us-ascii?Q?/cuo4r+arQj/seRCohKVnFd/J8B6fMqxPAyMO+w/dmvlmt7t6eFyovzgUCbh?=
 =?us-ascii?Q?7TV5LN6psfkduyqpnzOixLlzbZ+MDq10bGSdOCpHSlCmIpMmjCdhJkfa3JGd?=
 =?us-ascii?Q?bf+bhuFBgmx0NuCy+fjv8jb5cIteMeNltLaHa7BEwoK/4Yc4WBl3QJPqwgD7?=
 =?us-ascii?Q?kDrsGbBqezqmqKXmnjqqfECq+jUC3OwtSK5juidc7zoEU5uJZVsUPTiq3Gpm?=
 =?us-ascii?Q?TV3NCUGXWwtTmI2eNR6VgPBYJPzSAEo7MokhRsC4/ukxdBI5K4d62FWB7GCD?=
 =?us-ascii?Q?/jhZHMoWiZBsRH8Jp8cavtqlFtvMK2iYPqueuSO0i7QwkJbVrqleAETgEXx7?=
 =?us-ascii?Q?jvV8rWgcdXCEw2WoHyogSfZE0M0aYoNjbXhVLC6I0me9WXH0UFxqTMuXLHml?=
 =?us-ascii?Q?86OmkNVfW2WZ14q7tm3dmbyU75aLd5vROAthiE/vUloCfxXgPy3EYftT/IH/?=
 =?us-ascii?Q?THenZ4DD76UlpKqxVYhBbI9oDOrvjHGkkbendEj9ggmPXoUeYbZZ3Opezv5b?=
 =?us-ascii?Q?p69XXhd16DYD4nV9LzV719Az44KD4m43FJLtX5D7zcnr3fwDoivf1WW1313H?=
 =?us-ascii?Q?WNgMxcPVCj9cxk3R/mKCH0OLF332TYqdtZ05sczu5zn1N9xBesrRPnmMDYZh?=
 =?us-ascii?Q?+ardcTptjqZAEpwc6X7s7ZF9N66ZHnaWKSDqLDDoNXhVYLEeykfwUmsrUpD2?=
 =?us-ascii?Q?l2qirOWxWCOxuuirtbelFwxxIGcR8GgG7TElCAF7vfa7tYw9D3Q2HCCWsED8?=
 =?us-ascii?Q?VyKfwflsEck0+4roXIiVkcFrrgmP2JgxDp4rHWJAP6/kImPf0KvmmlMJmxDj?=
 =?us-ascii?Q?6vQsE1qpbUBwWGft8cwkHWsIsCi3vJrpqeazEwJsM94v8/TFPZGx9YbxaAay?=
 =?us-ascii?Q?yAbxAR1QyM1sCwT2/TjYe+ORF64dM4g0hbEJC3fEiKeW+K8HoZ7oZpYNM/4H?=
 =?us-ascii?Q?AUyI3aH8cUkt7zwtJjDmZqDqlkaknjDNppVgloskXSFhNzgKmV3kyxhfR9ts?=
 =?us-ascii?Q?OkdDhVsbGWsgRzgxq9n7XZ3+gyEHp98yRITYQnz7Lv1RolRlEG/MeJa+6NO4?=
 =?us-ascii?Q?P9R+ueISW248mrTe5jnt4YEc4672gxkqSG49yyi7GBqzVORIx7ljk3UcEEtb?=
 =?us-ascii?Q?EDzgwhBuXDJd6TbIU9U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:43:58.9148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89abdcb2-9a56-4d0e-4cd2-08de22a18d6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102

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

Fixes: 9a5605505d9c ("bonding: Add struct bond_ipesc to manage SA")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
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


