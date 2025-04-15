Return-Path: <netdev+bounces-182749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA042A89D3F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D7E17ABA1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FA22951B7;
	Tue, 15 Apr 2025 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N6DZKDyy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C0A294A1D
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719147; cv=fail; b=F/Z6Qic7qxYaQtYNuujl8wT/TSD8lY2uWVRHPBHaolYAsuSpCBBXn5XFDdnOZ7ZOXC9ESCuDL+zNmmkMOAJ0A9urKDfs25jtlxFB79G5u2AwkVq1HLPJH84ZCBiQlf65HtDcb6234B2XOzD1U4xE4fbsIsbt+3yiuI0CKPqNCCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719147; c=relaxed/simple;
	bh=EoPgK5pSICfV2nq2oco7pG0yyhSJgacZvdexAud/xHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWJLFUCsRjh7/q1N6+HI2xqcR68t0/iWKs9s+sphXN8WZkYUG4Fangwh67Isv7P/AdDCoBBzMnzUiGsqnegjz1d57Owz0czbYBGZDq/28/K31ozBGHcw7B1DcvYExjUwzOjVKTk/BGnQL+lK6I4aagoHDX2QAIv5z0QH6W6Iv7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N6DZKDyy; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0uXzaZ3+f06ghiIa6DoNoWzeysr2kPy/csgLBL/i3g3rppYCh2QEIESK8C4NgZ3Rwh/tCVZz9MuTuZkWaeiZ7wWq1ihS9/R2eRJLGIqWuNk2QxlpDmA9IdIeiXueRAnINISSNOut0aTGNMJQkc8RqI+Cu7X2xSIrUAC6NjgaT8JlTr49z054/w556fV/dGkwX35fSvne9zc9i95HyRmxM0vZMIk/dqd7vu+URFlSb5g+B2InsVDCDOKlodSIBXU1jPoXlvKgL4h4GM8yhCr7T/qvEq+ztuhI5xznqhFKMY9srISkbEGdu8IzXpZ4SC1z+WMWOuFgvTc5gVGXQygog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNeHKA6EA6W1BxSDcLzaJiFamdaGDBXDYgOhAp8NE+w=;
 b=ejq0f98tbnMr0cMQNFqwR8WjDRwEI+pMcOQeTIYU8vy+j5boem84WNQ9zhUAuyo3LIMygFLB/BmPB3elYK43Y1nv3cn74OqtzBtXuxnbNBjUdbJZzH8pJpRTHLbGhr4fbaojyCJCBsHheALBDlCFZ6Ld881UyBqVEKT4b0lcGCti+jsmMN5Ip6zig6c/VqesHI9Moe6cS1cNg68IfFOSKOd/tf2q74/tC7Ulb+x4rI6M8Flmn3UI1+2YCZbXsLvs/nks3rK1XE522ev3Cx+g6t3LF91RWRq7wn/kmr6J+dH/Og6ZaVAgumrus1YbYo0PrlWHgF4KSva1PjbtR0meCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNeHKA6EA6W1BxSDcLzaJiFamdaGDBXDYgOhAp8NE+w=;
 b=N6DZKDyypoZhMaOffC6amxFjfZF458QUn7Xx9Wxf4ALoCZOBcqrwr/oLev8xtVpxoNZhhej7l9GMIX6rgAB7RPgm3YmG67weubBHN1/q1TG4tJfKDovVzGctr9P8U3ujbvL6FgqkblFmSrVSilmCsFx8Tp2mC6/+ImzaJLmp4MvHjdTdLGcCANNkEJeDKIcHJRRPwYDW3UdxjGfUlsOjzuCQcqhQpMZVwRg4zv78OsOHtueys14mpBbIOZq+PV/JKW3eDWHqnHvb6K3nFX+6llxiwEZ5WUnOLyep5DOvL2RjBjZFkKmrho3OcdmZ03SEEguawIQ63+7MRMdAKolwjg==
Received: from BY5PR16CA0021.namprd16.prod.outlook.com (2603:10b6:a03:1a0::34)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 12:12:22 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::76) by BY5PR16CA0021.outlook.office365.com
 (2603:10b6:a03:1a0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 12:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:08 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:05 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 02/15] vxlan: Simplify creation of default FDB entry
Date: Tue, 15 Apr 2025 15:11:30 +0300
Message-ID: <20250415121143.345227-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415121143.345227-1-idosch@nvidia.com>
References: <20250415121143.345227-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d826b7d-eb21-4f3d-e38d-08dd7c16c6b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PqmP4nkLFNgcSaOAAJZAdlpcoAKI/7JnzBHXQHy0MsTopYWlV/jixLGXGZHd?=
 =?us-ascii?Q?TnmomDMKqz28opY3FvhnA5qmxhuvjDbWpjN6b6zJeqSpCxqkfyUR5UK+niHA?=
 =?us-ascii?Q?XG62nwbRqCrhEhG47tlDoK/G2JM0k+XIX2nER5RGXXmSL4oi5PIK9cNIlnJm?=
 =?us-ascii?Q?D5yJgeuATTYJ9jwmoOaUElI5ULDRTBqE6XcujWHTD1HhDgw2FrI+xI/0WcGT?=
 =?us-ascii?Q?BFlUPF+rI7lXXpTLcGzPn1Ql1Zxx1VkM+26t+UY8BC9gpGwPTOYyL06gBju9?=
 =?us-ascii?Q?w04Sqvtf00zMOD399GyaoddIUyQrmvFKWg2EB4U/q84sD3ekVRhZKJlGM2LX?=
 =?us-ascii?Q?W6SROFjXOm5kKdgjyVw0D/V9tzq4SsQ5xKojraKOFAoZGPPhcORxkEAq6EKd?=
 =?us-ascii?Q?zBp6TLE7GHw1kG9mmvULD0PnyYoVVp0zrNxoQ70sZVrNjuJu7O0Vdrk0hEDC?=
 =?us-ascii?Q?iOEa4I67BBUCRx2rDv+sfuS5qGtxes1MoWj1Z91G7qCy+EA0ZiiE8PIeuyTG?=
 =?us-ascii?Q?qot+DynwZlfzDsbhMdT0XGsX5KY0Hj4h7W/YbTit/Bq/Sz7TRTm9JL6AYR1w?=
 =?us-ascii?Q?jr9vG5hDf1b6vcfdExY908CUElzmtUUITaEr8C+6/ODWjSNvxKJtrQ5qUOa7?=
 =?us-ascii?Q?KRrfh6d4trhY6s8oocAemRFvByCkS2T8FVcegkD4NecHhBe7XPZmJ8adxolk?=
 =?us-ascii?Q?CdGC0DxygBHrTEfcOX41AW9Dur6ClsRFIVcNP9ajgflWEDZT5W7i2BlNZMrm?=
 =?us-ascii?Q?Qgqt+h3/Q91ar/NxPfm9n87qN+RozEdPyRQatd6/FWyLp/F3tcO3Hg/6n+Ob?=
 =?us-ascii?Q?g+9zjRcWm1z5joCP71Cfag1jBLzjGDsDIEm+68/zWqMLaxb9PKMwy/J1Zt+6?=
 =?us-ascii?Q?iujIoPK2DRKmo4f07TsEGLlWVgdrYGrzWwfm5hZw45Pw0RiSq7kAmb1Ug3zu?=
 =?us-ascii?Q?vhpq4J5A+FpP9k1juDoyFaSIkSIJrvp06Rlh0+2H2FkbNdC9TS4w88kowETK?=
 =?us-ascii?Q?6zhha+sL0KHeA+3yJhuye8n+hPvEbEtBs8WInkbpNpiEECDHZzsGzfkSKfLe?=
 =?us-ascii?Q?tq+6pUdL46m9UOg22SYk9sQrGERhUhkxbyeYvZhcBLclDNk5tgg1rhaRGqrR?=
 =?us-ascii?Q?vME1Zuw7uuR0ELMNv3cTFeCDWV7kDrAs5o/hL4Og1UGVPARQnnLOvEHJofT5?=
 =?us-ascii?Q?+Gz77Yol3GdAiB2SQKydsVVFiVlj1XvgveoJTOgME4XZruQs9/b7yiBs6H0D?=
 =?us-ascii?Q?fOCSZFNfGiGTXiYHX940TjRcvCY7XNBzr62QiGTuHbD2LVpDt4opVliIt+EE?=
 =?us-ascii?Q?4deKfe1/vroFtgZWo6HaK5cjLJS3aKfjeKLsXwvrz+ao3iuJSAGpCPRhYwpb?=
 =?us-ascii?Q?1IhHtEbpOYzfzIYjEwEznn0EGBv6EorOnQA6+pf96zDl/e85IHMr5CMoX9pz?=
 =?us-ascii?Q?VYZm20ay6LP+DnX+GyQW8UQIurqi244kARXy6E9vMDccXlcERVMW6OO2dkC7?=
 =?us-ascii?Q?bHJdo5MSnMLtiaSPDTQu4xG8w6eRKjWiZGKV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:21.9900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d826b7d-eb21-4f3d-e38d-08dd7c16c6b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513

There is asymmetry in how the default FDB entry (all-zeroes) is created
and destroyed in the VXLAN driver. It is created as part of the driver's
newlink() routine, but destroyed as part of its ndo_uninit() routine.

This caused multiple problems in the past. First, commit 0241b836732f
("vxlan: fix default fdb entry netlink notify ordering during netdev
create") split the notification about the entry from its creation so
that it will not be notified to user space before the VXLAN device is
registered.

Then, commit 6db924687139 ("vxlan: Fix error path in
__vxlan_dev_create()") made the error path in __vxlan_dev_create()
asymmetric by destroying the FDB entry before unregistering the net
device. Otherwise, the FDB entry would have been freed twice: By
ndo_uninit() as part of unregister_netdevice() and by
vxlan_fdb_destroy() in the error path.

Finally, commit 7c31e54aeee5 ("vxlan: do not destroy fdb if
register_netdevice() is failed") split the insertion of the FDB entry
into the hash table from its creation, moving the insertion after the
registration of the net device. Otherwise, like before, the FDB entry
would have been freed twice: By ndo_uninit() as part of
register_netdevice()'s error path and by vxlan_fdb_destroy() in the
error path of __vxlan_dev_create().

The end result is that the code is unnecessarily complex. In addition,
the fixed size hash table cannot be converted to rhashtable as
vxlan_fdb_insert() cannot fail, which will no longer be true with
rhashtable.

Solve this by making the addition and deletion of the default FDB entry
completely symmetric. Namely, as part of newlink() routine, create the
entry, insert it into to the hash table and send a notification to user
space after the net device was registered. Note that at this stage the
net device is still administratively down and cannot transmit / receive
packets.

Move the deletion from ndo_uninit() to the dellink routine(): Flush the
default entry together with all the other entries, before unregistering
the net device.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 78 +++++++++++-----------------------
 1 file changed, 25 insertions(+), 53 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 7872b85e890e..3df86927b1ec 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2930,18 +2930,6 @@ static int vxlan_init(struct net_device *dev)
 	return err;
 }
 
-static void vxlan_fdb_delete_default(struct vxlan_dev *vxlan, __be32 vni)
-{
-	struct vxlan_fdb *f;
-	u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, vni);
-
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
-	f = __vxlan_find_mac(vxlan, all_zeros_mac, vni);
-	if (f)
-		vxlan_fdb_destroy(vxlan, f, true, true);
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
-}
-
 static void vxlan_uninit(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
@@ -2952,8 +2940,6 @@ static void vxlan_uninit(struct net_device *dev)
 		vxlan_vnigroup_uninit(vxlan);
 
 	gro_cells_destroy(&vxlan->gro_cells);
-
-	vxlan_fdb_delete_default(vxlan, vxlan->cfg.vni);
 }
 
 /* Start ageing timer and join group when device is brought up */
@@ -3187,7 +3173,7 @@ static int vxlan_stop(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_fdb_flush_desc desc = {
-		/* Default entry is deleted at vxlan_uninit. */
+		/* Default entry is deleted at vxlan_dellink. */
 		.ignore_default_entry = true,
 		.state = 0,
 		.state_mask = NUD_PERMANENT | NUD_NOARP,
@@ -3963,7 +3949,6 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct net_device *remote_dev = NULL;
 	struct vxlan_fdb *f = NULL;
-	bool unregister = false;
 	struct vxlan_rdst *dst;
 	int err;
 
@@ -3974,72 +3959,62 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 
 	dev->ethtool_ops = &vxlan_ethtool_ops;
 
-	/* create an fdb entry for a valid default destination */
-	if (!vxlan_addr_any(&dst->remote_ip)) {
-		err = vxlan_fdb_create(vxlan, all_zeros_mac,
-				       &dst->remote_ip,
-				       NUD_REACHABLE | NUD_PERMANENT,
-				       vxlan->cfg.dst_port,
-				       dst->remote_vni,
-				       dst->remote_vni,
-				       dst->remote_ifindex,
-				       NTF_SELF, 0, &f, extack);
-		if (err)
-			return err;
-	}
-
 	err = register_netdevice(dev);
 	if (err)
-		goto errout;
-	unregister = true;
+		return err;
 
 	if (dst->remote_ifindex) {
 		remote_dev = __dev_get_by_index(net, dst->remote_ifindex);
 		if (!remote_dev) {
 			err = -ENODEV;
-			goto errout;
+			goto unregister;
 		}
 
 		err = netdev_upper_dev_link(remote_dev, dev, extack);
 		if (err)
-			goto errout;
+			goto unregister;
 	}
 
 	err = rtnl_configure_link(dev, NULL, 0, NULL);
 	if (err < 0)
 		goto unlink;
 
+	/* create an fdb entry for a valid default destination */
+	if (!vxlan_addr_any(&dst->remote_ip)) {
+		err = vxlan_fdb_create(vxlan, all_zeros_mac,
+				       &dst->remote_ip,
+				       NUD_REACHABLE | NUD_PERMANENT,
+				       vxlan->cfg.dst_port,
+				       dst->remote_vni,
+				       dst->remote_vni,
+				       dst->remote_ifindex,
+				       NTF_SELF, 0, &f, extack);
+		if (err)
+			goto unlink;
+	}
+
 	if (f) {
 		vxlan_fdb_insert(vxlan, all_zeros_mac, dst->remote_vni, f);
 
 		/* notify default fdb entry */
 		err = vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f),
 				       RTM_NEWNEIGH, true, extack);
-		if (err) {
-			vxlan_fdb_destroy(vxlan, f, false, false);
-			if (remote_dev)
-				netdev_upper_dev_unlink(remote_dev, dev);
-			goto unregister;
-		}
+		if (err)
+			goto fdb_destroy;
 	}
 
 	list_add(&vxlan->next, &vn->vxlan_list);
 	if (remote_dev)
 		dst->remote_dev = remote_dev;
 	return 0;
+
+fdb_destroy:
+	vxlan_fdb_destroy(vxlan, f, false, false);
 unlink:
 	if (remote_dev)
 		netdev_upper_dev_unlink(remote_dev, dev);
-errout:
-	/* unregister_netdevice() destroys the default FDB entry with deletion
-	 * notification. But the addition notification was not sent yet, so
-	 * destroy the entry by hand here.
-	 */
-	if (f)
-		__vxlan_fdb_free(f);
 unregister:
-	if (unregister)
-		unregister_netdevice(dev);
+	unregister_netdevice(dev);
 	return err;
 }
 
@@ -4520,10 +4495,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 static void vxlan_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	struct vxlan_fdb_flush_desc desc = {
-		/* Default entry is deleted at vxlan_uninit. */
-		.ignore_default_entry = true,
-	};
+	struct vxlan_fdb_flush_desc desc = {};
 
 	vxlan_flush(vxlan, &desc);
 
-- 
2.49.0


