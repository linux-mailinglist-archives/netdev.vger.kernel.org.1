Return-Path: <netdev+bounces-238281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F030C56F6D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC535344F22
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742FF3321A4;
	Thu, 13 Nov 2025 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dx2IrQE+"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10D334394
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030639; cv=fail; b=PCIHnfj8jforjFvxi4/jJObdtjKWmbGkUnHdFxKcjNzG3KjqWc1MjMhItFb6aMKrr7ulpC7+Ve+ugCDqomYI0Q+9Ofv2MQ/KyxLkVvWGKB+yOwWXeeP4GkXr36XcnFTujyXBVLmSIwKmio/40dEHrMulgCqtIMMtB3jDml+Igd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030639; c=relaxed/simple;
	bh=bQ1MNX7fi9QV/EhDXUYayfCGpczJ/IrkesUEIO7r7N8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B/BQsCZg0zfLJDIvIa4IS/wMHzZk3+ogVAl4BhwxCMaxeczj0ll1JaJsBh1hfr2gEzro8Z/XRgi4D4gOSixKPxFuk73Y3fmCRXCEW8FA7OByX2vGIKSdJbB88PI34VHCOfvKWF5+AvBeP/EedhkdIsmfNYRTnn02ouRrWpp1V7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dx2IrQE+; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3unA9lXFuNw9xx06Wvk+DwRtvy/ffymABflXMQ/q7cQzEvgdcFf7MEbuBAr6TndB0+sB3Lwp2CfGKaDGOX+1E5yLTMUB6PxeArm2KUgKi2YpYWi5WMcVZYsvHXZqPi2XPqM8qKHqzqlPAXV+6ruOA57s8KqqmbfleM8YevVkAqjAeDt8S7SlxQdP+chewFlzmffMRN4sNvpjxEjOAIRpSNYE9oEc+uh7pZe4Z2DyKXvpPLt+TNdoHznofA0kkhQAsySS8YLUL+BhIa64atfedElGJanFsmOXw+HR3zjL6Y+XTRRBUUvp59xO6cup7GQHv8ZL2YdcZvgHt78OZvBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwHsZKrUhf1Acrt/93kmBj+AQoyV3il12XfEX3jq3uw=;
 b=yEKeSxICZ/eWVeGIdqfAEJHHuiNvN3gkDB/IAH7RhxmgZZxWgoBvKsPTVUKKSUNRlIlHwxNR/voNfBsh+WvSZkczmVzwAoDhEfY9CXE4rYbEK6NFKGhDY0h4ya8HucEAbYuaUCwddy0p+zzC9U6WIdZU13C0k9EON9Ei2mocqXnhLkGn68cZXgMg/Hu/tMFsumg8zhZ7S7HG47Nh0WbuLZSjs6X2Si/qh+ImpuwyF937JiCrmtO//jygPwsEFkRhN3yYkWuf6KdgWvemv03D6GE2oOem3v+ytAWo+p5VCR79QWDPqxTK9yLmkKjzqn0q+GEbNsTZpfYKVpMZrvvBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwHsZKrUhf1Acrt/93kmBj+AQoyV3il12XfEX3jq3uw=;
 b=dx2IrQE+xzY63G+3O+QjdG7QqevRWWyN2b1EzFO7YfKF+a1eWdjBupm0y1qcKyAoB9XFFv3VlNfOCrJE7ZlyywJP2c/qcgcfmwPVRPQUSRhQJwWt3R4PFU62sQ0M8lgGnZ1rx73os/n72VpByUdtlvw4yjMYua0tFH4tmD8Ax9UG0sMJ4XsPajYhgxenSO416M2m84xI7Mbm2zRNAGyWv4s46IBRWK7MfIzETY1EH6j2hbYmmBX6sl5iAdesU+y8Cpgd7zqueR9FieRxb59J5sCJXw+CL4hbSXMBviPEB3pFAiacrM+6SO9W2Yc5FNoEKcXhiK7oLJsw+f1D13RFOA==
Received: from BLAPR03CA0161.namprd03.prod.outlook.com (2603:10b6:208:32f::8)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 13 Nov
 2025 10:43:51 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::f8) by BLAPR03CA0161.outlook.office365.com
 (2603:10b6:208:32f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 10:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 10:43:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 02:43:36 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Nov 2025 02:43:31 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>, Jianbo Liu
	<jianbol@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, Leon Romanovsky
	<leonro@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH ipsec v2 1/2] bond: Use xfrm_state_migrate to migrate SAs
Date: Thu, 13 Nov 2025 12:43:09 +0200
Message-ID: <20251113104310.1243150-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: f483cbed-d648-4d7d-73a6-08de22a18916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZhI0Z/8et6qGKnCLccbq2YmQPN3xKxkifuMzMpVkbs7Nsm7Yz2u9KQbwnvvO?=
 =?us-ascii?Q?pKCgvgLRcW/hhXZNnuOd3ppwZpsve7DtH9revONbOJLohDgwnf1m3Yw3q/n9?=
 =?us-ascii?Q?jPT0A1XTt2iiorbdlRYKmYR3uDNSGnV3Zy7Xgk58ZvPSl2fPjYN3C3u6N1Bn?=
 =?us-ascii?Q?HWNN7YjdXrRhGRpU8QzVvUB30ZraU3eoMCw3zArK30wyt6SfdC3G4Q12qPLg?=
 =?us-ascii?Q?NIslWsfCSG/qWeawEZGgNKef12Mgo9menOlW6UGKuLtSkq+6hAmkeMs+y2qY?=
 =?us-ascii?Q?rYFYY01kRo7ly1vJq/6C1OynBYqxOdR77kcozTKRmmXDzbwMR6Kbp9J586u9?=
 =?us-ascii?Q?pzDXg0aa56SijYvtY4b/zJvrKnDymNcUNScgZR3oqYS8UaOUz3U+I0SziPMw?=
 =?us-ascii?Q?5/psb7DYtlZcugNcMfvlMb1rsamtoSRHi36OO8LfYW3wRTcLWx6jdm+REaAg?=
 =?us-ascii?Q?MROgn7O7aVa26D7pU1GCrggJizaf6utRm2qpyqavrkvLo+mQqiiZ5WiQEtT5?=
 =?us-ascii?Q?Iv0+CQILXJxPzV4nha6LjXJI5Y6Z6CNTC3QXgIrVTKx3x9jTSuSWBo1S9CkY?=
 =?us-ascii?Q?i4VWgk0qbEtQvopiX9PTpyxcFRIWbTNakBBF8oQw++lkTlsUQuSrf0y22aKc?=
 =?us-ascii?Q?EcTmAHO6K81QEiy98oXGOxt2/zvcbgVwapPg2xffkZpZq8az2hrFr7D25t6/?=
 =?us-ascii?Q?L6rQcyUR4haVBRbE88Jkrjb81B/1wCcE/E/jSXu7LJVaxrF9fRY4r2l5rqNl?=
 =?us-ascii?Q?DUfIOgp+U7ptimOHWifK6/o5aeoaNDxx4Ylyla2WrePphhjAJX3QYh5Bndus?=
 =?us-ascii?Q?ahyiftnpQCSyLQng/Cn4Wdq6cVtXpmdf4o5L+14ENSrSF449mJP59OzFG2pU?=
 =?us-ascii?Q?N14+3uGDHvxTe+vBQgyR9PQaCAIqpUqXUCtsVIyD+cyHgrSsvtlp6DsM/A1b?=
 =?us-ascii?Q?7ORCacDa5x/TCP9TjDlBj+zZN9NL4cHuXeFa4c+WsH433HWmQ9HkDFtGVF88?=
 =?us-ascii?Q?fCiLE1oOwRfHPBnn0jVjLYUYAQBi+V0Fpj//Bb6JqRjxogjTDivckuEhBeWG?=
 =?us-ascii?Q?ye2/ImByoD6i0OeL1zLclMwlVO0qtr8w47xFIB/K8NUv3z0q52WhkJK7dSEQ?=
 =?us-ascii?Q?M0qDKYjFeZM2yclMtD31gigLIhz8G1pa/K2r7W6ou9wmIjHP5Elafua4Prua?=
 =?us-ascii?Q?q5VvxO3OU+NgxDftdv2yV/2Kv24Kngc1hfpZC1p4mDV4uizrhEUweIJe2MEk?=
 =?us-ascii?Q?56CGbm+Nh6z2IYkoFnTHwEvoIN4Zg/jC1Wq/lcM77rFPzw3hTwUEeCbvR6w8?=
 =?us-ascii?Q?WWECgsIFJu59fiXUnXO916dFPOx/7qjilUJZLeV/jpOcIsJ0ty18MR2zvTfq?=
 =?us-ascii?Q?WXwIw1w/QG2A+3B8sfiPUJ3PWdSwa0xqtNlx5XT9SCRXwh5HTqCzRxfopuy4?=
 =?us-ascii?Q?DyPZJshItqd793UgV+/d70FmAiyLb6LPWnKixMDQgg4ci+akZ5REU9rgcnqf?=
 =?us-ascii?Q?jUO8M3L+lRVsjPR0IFUnKwLNYH9VsmmERYoq/d2s1Zq8VO6dWec5UFgJQd3D?=
 =?us-ascii?Q?wK3xLFaOrBKDv3NqzT4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:43:51.6302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f483cbed-d648-4d7d-73a6-08de22a18916
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181

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

Fixes: ("ec13009472f4 bonding: implement xdo_dev_state_free and call it after deletion")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
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


