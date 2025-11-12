Return-Path: <netdev+bounces-237929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A8AC51A63
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9083A8F80
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E7C2D876B;
	Wed, 12 Nov 2025 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C3m3f/0L"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD02957B6
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943013; cv=fail; b=gi4bnm0vfbk8QOW0sxX9bVaknWhyvGPvstXzdYlTqIPnlSpZ19F0gqbVafCyANxZAohXBvk9aslyiAwTQwPCV2NgUxfAoWT8xIMqFkD7dL6ItLGBqCNd7h9tykgYOy6iQtDQPrCBfEm0Tf7quirvePT9mtK2Tb7zf1Kgwu/4k60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943013; c=relaxed/simple;
	bh=0wAbazaavh1EwjvLmfkTMKnaMZ4yFYf1KEtpV5zFJUQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SjxWqk2G5qgGQuTpnPKxxYhEjdTD7ReAWlJwZESm40WeouW9ot1Wd0M1BRg2qZ+w/zdL0WqlfTIPpEsGWEiKekiSM0FCDcbhn+PiDFH3mCvcQ4l/UldXE6oOJBjsbSN9IkYdjLgMwT+6cdsCmU8iohUWT+aeXjEteVrZ+vsAp84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C3m3f/0L; arc=fail smtp.client-ip=52.101.53.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu60IWH8ICza5kDd+R9bDZ7tE8mgsVrVnu0h8coTMb4rrE4bXLte6bCFnXTC9FAlJLoHc7V6ZN2o/oVgIWwAyvfBtFeWKYR6JzYA7+LmoGOMAopFeYBLjiTWHMN2HOjUVB3OXIkQMh5mHx0rpJwFpvEFEHK1hEk46ZjQnDDzs+L8yjUHOQgDEbwlsOkBo7918OUrxmR1RTMMhy9ssASnt4/erZHlIwrNi5BfaFUCNY5KEWEPjEmVuRPjGqzgRRK0+wlTMnmkWxTOeEMSZqipRMwWrXCpa2GJITjvNLOD42sDXXVk4xFFHg2omrMFNyLUSbyaw/ZkXwdmbn6CTkrsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TriTrPwhsLsrfFAJwg3j6V2Pks9/hZhiBRfk53LDxq8=;
 b=d0QAsTmcq2k3sUY2dywHTjQzbXEiLvUTQ1Rp+mI3B8uuwtM7opCKoi8r4z7tATcjECnQ+bP5Y/tUMQHsi1zGrap0kQR0lTW/u3m7kWcJVeqBcuiTj666v7Tznv61KwwOpFOW8VG0w18IUv2tTPLE5lHopbDOR9FE0ckNZ3lIRGpTbmxgbxGDKXtdVvjGax2o7/fQ5NqogXLCXt9wiUhlVimkeIUyxVPQ+PAwFpeNu5ru78Z/enpmKUBe2NotGqh/85I150ZRM9ca7wwHsVLoxBcvjZjjjOVXoVSzDjKyyj0u/YAUKvTb7yP9a2qTFPT/I9UMTf4wGx63mnTm8+h5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TriTrPwhsLsrfFAJwg3j6V2Pks9/hZhiBRfk53LDxq8=;
 b=C3m3f/0LivkROD47VBWjT7PhSqdcJ9OFp7m7yTIEQ6hbERCQeUVx5pT5IH3ryknIkd9Zs896gB+GmwTeziUoG01tvLYqvLQ4UULmnrOXP1rNKeAP5d1Phzta8KT01qLXEMDh+cma0UVZhcW+M/YAq2NF8fW51l/1m0p4wYccuPaLg08snrBBWMdcVhTJLaWIxxtKPBQw+QN3XBy+tSo4j01tOIQY3GcHgGRBj6xL3+DKxbgQA05ZF31EjGfwf1BcJsgqqltEooVm5VmkYtyYfZiZY9y2gQepGOUfwWBz3/bANtaJdqI9UyPBnxbgt8n9LjxuVYPTewuVoUGdcDudXQ==
Received: from CH0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:b0::19)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 10:23:25 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::ee) by CH0PR03CA0014.outlook.office365.com
 (2603:10b6:610:b0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 10:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 10:23:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 02:23:11 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 02:23:06 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>, Jianbo Liu
	<jianbol@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Leon Romanovsky
	<leonro@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH ipsec 1/2] bond: Use xfrm_state_migrate to migrate SAs
Date: Wed, 12 Nov 2025 12:22:44 +0200
Message-ID: <20251112102245.1237408-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf9e2ad-0b4a-4080-0bd0-08de21d583b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2zCz3f2paoTKXHUHvSGKvPCclbG48pxzywFVG0ZWlOIbPSrjRP41uTKMPpoW?=
 =?us-ascii?Q?3vxWfjXwBWMnYQC1uBGWs+NY17P9uRHEXWymrWn3olsJmAov3Hk720PDhSwx?=
 =?us-ascii?Q?A3ysePgkXVQoGnTKgk1gQ8FrRnhtWTVk5jIWst2lDbz5NlnMlGbVv/K83H+Y?=
 =?us-ascii?Q?FqgH8/HjQbQRI+ILQMpuonXLWCiz5tbOUac08BVn6eyzs/zGB127KUQk4iDS?=
 =?us-ascii?Q?YVBAQq4vYiYaKaEt2zaV0H5t8qVuzjXA9BD5sjys9yezPosxDaVHUHftEXvD?=
 =?us-ascii?Q?B9ZxadfIKQHncOYA+pUQ2GnIsg/NofO7P3RMlEo/DFHgiPES7oloLp/iXpV2?=
 =?us-ascii?Q?bgqhVRPevUtrPPsbalCdmEGNFVgALwvRLSYJq/Rn/Oqaun4Iv9XjMrG/ZcFw?=
 =?us-ascii?Q?pqFt9qw45QtSXTQVBbw3MddVNNbLJduRUQgIX3yMo7fESJU8/HqlgPrPuKWY?=
 =?us-ascii?Q?XyMv5CBnetZZk/k23ZdRJnNViw8rOVdMXcHeburPtf6fiFx+XZFHjHj4aUOP?=
 =?us-ascii?Q?d0YgRc0wsRV5ULAKq7Lxlz3/oyZ+MN1d2Ye5IUvzxWIMgcI2KJ3q7PMHoA8Z?=
 =?us-ascii?Q?hVUHfQvP1p8ryZjizd14tq63p0DZfc75ge4F2QOaOrUMVDDqoya5z/FUfPcw?=
 =?us-ascii?Q?UHwouEBVksljnAENFg1ymJi05aWmwMSMnDN6WaVcHnQwVlev7L6E7qZS5jmK?=
 =?us-ascii?Q?NaaZbL6mkf+Ygtjv2+8lSdNmJ27DPtJa2w+AATUguXzVxhen+uSiaUCprkC0?=
 =?us-ascii?Q?SXEsU91qUUbWN/RJ9Rmn5vZmWqZVg+v0CUKXh2Eybap8CjnHNbY7g76MFsNX?=
 =?us-ascii?Q?aAuhuiuLawTyW+J71h3jdeOa56HQrpIGyNuRe6sVrCiHjCoUeybjsXUwOtr4?=
 =?us-ascii?Q?GYC39HRjFFXFljwz0NxI9YZ6KOKD0cK70spKr7u9KmUiWOue70DTPjNqZ5/2?=
 =?us-ascii?Q?z3m8uamnztch+hZTFERr8ugRVM0B5Pv79lIZ0N6Sihtv87vHiuYe4h9TxWJW?=
 =?us-ascii?Q?sxFGTcOrnZr2WPlzbuUtPPmHx7gdm9Z/gmuONkyWJc2IYlbJj5brRZeu3Wpz?=
 =?us-ascii?Q?IiTSxgStdtDaztBAyUR4Txo+5+DkvVmmrjix/bG62/4KC8o4R1uFQSOruf8+?=
 =?us-ascii?Q?KKIVlHDzKhcaUdqYUTe1S+hGnpJrrIFduRNqvlkwkQau3GjvdMNQt6N706RW?=
 =?us-ascii?Q?KGci1BoQ1aiArpleH9teBAgRcFXHUdd/TODgDoVO9kmEXpeQz3FQWF1MtrEz?=
 =?us-ascii?Q?Du8HHO4OjLETzAE3EBhnnut4cwryOiH1zvjCyg1/+yObJ8YfezA0jzKPOJrg?=
 =?us-ascii?Q?X4jXZIROlOkBMHnQgA+0+TIqOwLSHRCiKfPSZPGzgNUWCYWrryqCoV6yKNz4?=
 =?us-ascii?Q?ORzrKaC2PpSgjuTLDIJs5iZUWvZTGaIHVj7aup0p+OrN1x/z9T46pnRBeNrg?=
 =?us-ascii?Q?gaxI5hM88zWGaxeZwCLoYMioOe7mbDsSliXqdbOdBRgdGn7tWvVQsGbfLB5f?=
 =?us-ascii?Q?rMYIj3CoaCVal8DpB97uZUX1XOGKOALkPPol/dQ/UQ29lRfuwCSfislqJsEC?=
 =?us-ascii?Q?amzr172+mFD0YdjdoZo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:23:25.2160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf9e2ad-0b4a-4080-0bd0-08de21d583b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

The bonding driver manages offloaded SAs using the following strategy:

An xfrm_state offloaded on the bond device with bond_ipsec_add_sa() uses
'real_dev' on the xfrm_state xs to redirect the offload to the current
active slave. The corresponding bond_ipsec_del_sa() (called with the xs
spinlock held) redirects the unoffload call to real_dev. Finally,
cleanup happens in bond_ipsec_free_sa(), which removes the offload from
the device. Since the last call happens without the xs spinlock held,
that is where the real work to unoffload actually happens.

When the active slave changes to a new device a 3-step process is used
to migrate all xfrm states to the new device:
1. bond_ipsec_del_sa_all() unoffloads all states in bond->ipsec_list
   from the previously active device.
2. The active slave is flipped to the new device.
3. bond_ipsec_add_sa_all() offloads all states in bond->ipsec_list to
   the new device.

This patch closes a race that could happen between xfrm_state migration
and TX, which could result in unencrypted packets going out the wire:
CPU1 (xfrm_output)                   CPU2 (bond_change_active_slave)
bond_ipsec_offload_ok -> true
                                     bond_ipsec_del_sa_all
bond_xmit_activebackup
bond_dev_queue_xmit
dev_queue_xmit on old_dev
				     bond->curr_active_slave = new_dev
				     bond_ipsec_add_sa_all

So the packet makes it out to old_dev after the offloaded xfrm_state is
deleted from it. The result: an unencrypted IPSec packet on the wire.

With the new approach, in-use states on old_dev will not be deleted
until in-flight packets are transmitted. It also makes for cleaner
bonding code, which no longer needs to care about xfrm_state management
so much.

Issue: 4378999
Fixes: ("ec13009472f4 bonding: implement xdo_dev_state_free and call it after deletion")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Change-Id: I3953ca0e600220180721174f3eeb7d2df466f8c3
---
 drivers/net/bonding/bond_main.c | 126 ++++++++++++--------------------
 1 file changed, 45 insertions(+), 81 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 67fdcbdd2764..e45e89179236 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -513,19 +513,21 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 	return err;
 }
 
-static void bond_ipsec_add_sa_all(struct bonding *bond)
+static void bond_ipsec_migrate_sa_all(struct bonding *bond)
 {
+	struct slave *new_active = rtnl_dereference(bond->curr_active_slave);
 	struct net_device *bond_dev = bond->dev;
+	struct net *net = dev_net(bond_dev);
+	struct bond_ipsec *ipsec, *tmp;
+	struct xfrm_user_offload xuo;
 	struct net_device *real_dev;
-	struct bond_ipsec *ipsec;
-	struct slave *slave;
+	struct xfrm_migrate m = {};
+	LIST_HEAD(ipsec_list);
 
-	slave = rtnl_dereference(bond->curr_active_slave);
-	real_dev = slave ? slave->dev : NULL;
-	if (!real_dev)
+	if (!new_active)
 		return;
 
-	mutex_lock(&bond->ipsec_lock);
+	real_dev = new_active->dev;
 	if (!real_dev->xfrmdev_ops ||
 	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
 	    netif_is_bond_master(real_dev)) {
@@ -533,36 +535,42 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
 			slave_warn(bond_dev, real_dev,
 				   "%s: no slave xdo_dev_state_add\n",
 				   __func__);
-		goto out;
+		return;
 	}
 
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		/* If new state is added before ipsec_lock acquired */
-		if (ipsec->xs->xso.real_dev == real_dev)
-			continue;
+	/* Prepare the list of xfrm_states to be migrated. */
+	mutex_lock(&bond->ipsec_lock);
+	list_splice_init(&bond->ipsec_list, &ipsec_list);
+	/* Add back states already offloaded on the new device before the
+	 * lock was acquired and hold all remaining states to avoid them
+	 * getting deleted during the migration.
+	 */
+	list_for_each_entry_safe(ipsec, tmp, &ipsec_list, list) {
+		if (unlikely(ipsec->xs->xso.real_dev == real_dev))
+			list_move_tail(&ipsec->list, &bond->ipsec_list);
+		else
+			xfrm_state_hold(ipsec->xs);
+	}
+	mutex_unlock(&bond->ipsec_lock);
 
-		if (real_dev->xfrmdev_ops->xdo_dev_state_add(real_dev,
-							     ipsec->xs, NULL)) {
-			slave_warn(bond_dev, real_dev, "%s: failed to add SA\n", __func__);
-			continue;
-		}
+	xuo.ifindex = bond_dev->ifindex;
+	list_for_each_entry_safe(ipsec, tmp, &ipsec_list, list) {
+		struct xfrm_state *x = ipsec->xs;
 
-		spin_lock_bh(&ipsec->xs->lock);
-		/* xs might have been killed by the user during the migration
-		 * to the new dev, but bond_ipsec_del_sa() should have done
-		 * nothing, as xso.real_dev is NULL.
-		 * Delete it from the device we just added it to. The pending
-		 * bond_ipsec_free_sa() call will do the rest of the cleanup.
-		 */
-		if (ipsec->xs->km.state == XFRM_STATE_DEAD &&
-		    real_dev->xfrmdev_ops->xdo_dev_state_delete)
-			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
-								    ipsec->xs);
-		ipsec->xs->xso.real_dev = real_dev;
-		spin_unlock_bh(&ipsec->xs->lock);
+		m.new_family = x->props.family;
+		memcpy(&m.new_daddr, &x->id.daddr, sizeof(x->id.daddr));
+		memcpy(&m.new_saddr, &x->props.saddr, sizeof(x->props.saddr));
+
+		xuo.flags = x->xso.dir == XFRM_DEV_OFFLOAD_IN ?
+			XFRM_OFFLOAD_INBOUND : 0;
+
+		if (!xfrm_state_migrate(x, &m, NULL, net, &xuo, NULL))
+			slave_warn(bond_dev, real_dev,
+				   "%s: xfrm_state_migrate failed\n", __func__);
+		xfrm_state_delete(x);
+		xfrm_state_put(x);
+		kfree(ipsec);
 	}
-out:
-	mutex_unlock(&bond->ipsec_lock);
 }
 
 /**
@@ -590,47 +598,6 @@ static void bond_ipsec_del_sa(struct net_device *bond_dev,
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev, xs);
 }
 
-static void bond_ipsec_del_sa_all(struct bonding *bond)
-{
-	struct net_device *bond_dev = bond->dev;
-	struct net_device *real_dev;
-	struct bond_ipsec *ipsec;
-	struct slave *slave;
-
-	slave = rtnl_dereference(bond->curr_active_slave);
-	real_dev = slave ? slave->dev : NULL;
-	if (!real_dev)
-		return;
-
-	mutex_lock(&bond->ipsec_lock);
-	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
-		if (!ipsec->xs->xso.real_dev)
-			continue;
-
-		if (!real_dev->xfrmdev_ops ||
-		    !real_dev->xfrmdev_ops->xdo_dev_state_delete ||
-		    netif_is_bond_master(real_dev)) {
-			slave_warn(bond_dev, real_dev,
-				   "%s: no slave xdo_dev_state_delete\n",
-				   __func__);
-			continue;
-		}
-
-		spin_lock_bh(&ipsec->xs->lock);
-		ipsec->xs->xso.real_dev = NULL;
-		/* Don't double delete states killed by the user. */
-		if (ipsec->xs->km.state != XFRM_STATE_DEAD)
-			real_dev->xfrmdev_ops->xdo_dev_state_delete(real_dev,
-								    ipsec->xs);
-		spin_unlock_bh(&ipsec->xs->lock);
-
-		if (real_dev->xfrmdev_ops->xdo_dev_state_free)
-			real_dev->xfrmdev_ops->xdo_dev_state_free(real_dev,
-								  ipsec->xs);
-	}
-	mutex_unlock(&bond->ipsec_lock);
-}
-
 static void bond_ipsec_free_sa(struct net_device *bond_dev,
 			       struct xfrm_state *xs)
 {
@@ -1221,10 +1188,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 	if (old_active == new_active)
 		return;
 
-#ifdef CONFIG_XFRM_OFFLOAD
-	bond_ipsec_del_sa_all(bond);
-#endif /* CONFIG_XFRM_OFFLOAD */
-
 	if (new_active) {
 		new_active->last_link_up = jiffies;
 
@@ -1247,6 +1210,7 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 			if (bond_uses_primary(bond))
 				slave_info(bond->dev, new_active->dev, "making interface the new active one\n");
 		}
+
 	}
 
 	if (bond_uses_primary(bond))
@@ -1264,6 +1228,10 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 		rcu_assign_pointer(bond->curr_active_slave, new_active);
 	}
 
+#ifdef CONFIG_XFRM_OFFLOAD
+	bond_ipsec_migrate_sa_all(bond);
+#endif
+
 	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP) {
 		if (old_active)
 			bond_set_slave_inactive_flags(old_active,
@@ -1296,10 +1264,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 		}
 	}
 
-#ifdef CONFIG_XFRM_OFFLOAD
-	bond_ipsec_add_sa_all(bond);
-#endif /* CONFIG_XFRM_OFFLOAD */
-
 	/* resend IGMP joins since active slave has changed or
 	 * all were sent on curr_active_slave.
 	 * resend only if bond is brought up with the affected
-- 
2.45.0


