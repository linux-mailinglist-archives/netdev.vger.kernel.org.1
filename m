Return-Path: <netdev+bounces-166496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83310A362DD
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3DF57A4E57
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914032676DA;
	Fri, 14 Feb 2025 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gAjnjb9e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74922753FD
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549972; cv=fail; b=lTqgXGKwVr0GER1fdYmY2cpz22bhygZf/XYjubY2DqH7AtoZx55pQhkS3IWDwppTu71Ka8ayjXGlxTFoY5Fl4pzplpbPJjXBTXHYvz91Yz6mywiYq5n/LR/y0TyY5yTvBxCCUWkIRqAASBdxe9hyuH+EXyXipAUBYroMQQRtV5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549972; c=relaxed/simple;
	bh=7JZunx0YZ6PMcmEnBJSirKzbxLCDajsM6gsBfC2svr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUJt3m9k0lnrQ12ggby8uGz3arEmgst87RQdR2RbzIN2jNK+6ZSPh7SYXAepXpUah4fxullf0r//UPfMFkgSHw7Npr1DQSK3k9pzDRVilIq8Gt0apZo1dZ6h5JXpCV3IZ5agXBTodw/+HEFTaBJZYth/XgbwM4d1HMK+dlp4IB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gAjnjb9e; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fITXkYfAKFz0J5XXUSrFnUh48ieEWTI/0cTu2/sI7jHlRoDHlws5lok8zbQsroP9iLHbRXXFcdDf7xuMj2kgUk3W9AQRRXQS8LRv2bnpJx+ZGzzoApz7TkAawRoOB/dKNrcb6brfZf+tAHOG0L3uNhpgJIbkZGtHyaapvhhOoRbIF08OC0hSYDR/3QwMtiog3KWN07/+twNwNgY7QrPZNFCIMXNDjEMykjjKJI59ElvSdvSw1xmclJgG0DjqQem1hU1CNrQITQsNm/kGqpnbZYZzhBoK4vrFgYVKSXAX707pdam2jr59rU79IyyTgxoVKF26UUEuYHo5pJkuPxisaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy9AzTMbLO0uz0V4Wq59iTR8Arn+DiswL+6tRw3H42g=;
 b=d9/SebWSAp2CXTxrzCwEPzNXuSd1ubjawToJcvSxTfzU+H5f9QLtddsr4ehCCCcLZ8417K2rdJpKRih4QrRKK3XXKnbrayOJWxcaaGgN1D4ZImu0ZVUB7qZ0nL9uk3lYOAMDqNAnU6++S5dfJ78Sb6jz0JiyZJCmOiU+nqijIPKmbyHV1AOUvXOQlw63d5FZLSUBQv74lsZSoxw/DrLqTtnfiwVJYodXtMGYfp8qNUXQJfWbX4ovFao5tbdLDS4o/jOPIgIFtcfpg91Tce/4ws23S5bMt6hHs9mfQGvrCSjngDqguWeBe2jdwma5rd/V8nJkx8ySIUZgLuhikWnDDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy9AzTMbLO0uz0V4Wq59iTR8Arn+DiswL+6tRw3H42g=;
 b=gAjnjb9eKcrRIwfkZcNb8NtafwpbeR2x9aMTOJxNPbi7rbRLlguoPOi62B8HSyBNVMgoJAn9vJbnGMYK9hWSKJclktkUvODyfHPlOkpULaKJjrkMXGVa59ibBeSWtioKRbi3sf2N1OvxoXab68MbBhcALP5kOJsRfYAkHeUaHSr4ehhQdFZ0JMqCByA9LO4dFRwYXKaMQO0ZRw/YM0soubWJfCvM45DeiwUDYu5jozpYHnnA1eKN/c28yUB1YP9cmn5NNjN9DXilBSpIeduFjFzXMp8ULYK0dW4oSW5nJuqoVbzXIzumI3l48VIP+pnqCrsa550nEECLuxqKZ6K4XA==
Received: from DS7P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::28) by
 IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Fri, 14 Feb 2025 16:19:18 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::b2) by DS7P222CA0029.outlook.office365.com
 (2603:10b6:8:2e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 16:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 16:19:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Feb
 2025 08:19:04 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 14 Feb
 2025 08:18:59 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>
Subject: [PATCH net-next v2 2/5] vxlan: Join / leave MC group after remote changes
Date: Fri, 14 Feb 2025 17:18:21 +0100
Message-ID: <056c8f4765a52179630b904e95fc4e3f26c02f2a.1739548836.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739548836.git.petrm@nvidia.com>
References: <cover.1739548836.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA0PR12MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf9e8de-dad7-4694-b43b-08dd4d1354a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iw9uele4Hi5+Bxyd7IHXI5KjAtUi0B++oWdW1ulBEauGKKCtP3XBDhM5w7xW?=
 =?us-ascii?Q?fyWtOgqHb1RbXgFsPsaP3BsLDGj3IDmDYTza1qZMUhUDTBlpuAK4XvA+DLyF?=
 =?us-ascii?Q?2Cv1647xFj/yHbR3dpd4u55LQemmU4NB3HrUKW4B5TfxY70bXOBOCN90uf6b?=
 =?us-ascii?Q?8yGRu/K3cMgHLcr1OruThre4OmWcsJpcrl4h3SlExpR67HFtMnJbG7DgYROb?=
 =?us-ascii?Q?O/4ujrGMjx+tSGFI16hMvHI2+M0TTCzBFqBF1lwTpsiCUPRLi48b6Uo1GUVB?=
 =?us-ascii?Q?77cj13KCoahCBUvRNMPmP7e5LURlqdJkbdGaQ2o0sL8hsaPMbmgos2mlJQcC?=
 =?us-ascii?Q?ZMHMbTjuwRcA63SKIE4H4YHbHy9uLKP8b98wAr4xzB7QUqe7UkJl0EEP/k31?=
 =?us-ascii?Q?b1zLlAu8hoRgU2m8F4hbP3VSnhBMpZAxguueAv/++ws2OwzZZvT05xsVnzza?=
 =?us-ascii?Q?ppXYYg8xekODcquOTxlfvb/mpUSsQOG5xsCgBs37lDwvxo0sMYCGrEs4KFbq?=
 =?us-ascii?Q?KrzVelS6Gtt7BaqW/nyvdgTljqX6m1mmDipZCZSgq7Q5huoeyfR66f3+JOWY?=
 =?us-ascii?Q?bOoyf4+CCCKbUdfK1XBaK2cf0IdMlA0CAFvpLippWHCRnNf4JBKH3s3HYfZo?=
 =?us-ascii?Q?jxzcLwlIYYaAe83DQdGFIjkciWH801RDpAhTp2N2rJb1haZvFm4GmJPPo911?=
 =?us-ascii?Q?l8Ijuy2b1M0a3SDQ0394LFY+4E3gijFTrDRM6IgfT5bmmPcdRLK84Zu68OZ/?=
 =?us-ascii?Q?RLnOvVZj2VIKrPa4lmkgs/B7WOtOZ2jBBmSx+J9+m+LSDAtIWtO397hVNcP4?=
 =?us-ascii?Q?0RAEywCuohFmFQwrOvpF9mtEf22nlR4/4TX4mN4sHljTZ45mEx6IN6OtoFsr?=
 =?us-ascii?Q?0EV7fIFs+SNRxOr+j3QwDEu/CUfdc5OB7bGdxmjTS3qF4WCYuU2WlkxFBMcV?=
 =?us-ascii?Q?OsZWqzH/IqTpdqQ6t+7dCgBNqTSuRpLwT7ht8FokQco66j9+hQ3oyL/chI3d?=
 =?us-ascii?Q?unGbm5B7QHjIuanzqErdc/h8DrcRI7UGMHYpc0UwjYZmhxwSLjLSKty42lCz?=
 =?us-ascii?Q?yYmQkKy4e/o+FxaV0TMpuXR3sV9Euf2Dza9I86OTra6s+7h03j8yhiZXuvX6?=
 =?us-ascii?Q?1oMLWdbQVPcQ0Jh5KJ896MuLlsbuJDZHY1H+ngjvV4um/gPBPQgOKHyIc9WP?=
 =?us-ascii?Q?YpFlsqt7LdNFHMRAxRNB1oNbopULdywQKC6DSBppLRVQxf1RQvdpDE9UOKU+?=
 =?us-ascii?Q?do2mm+bnvkUnXan0nJKedPe6pg/MxEcV1oi19863fQyR1uP3tq4faf17n3t2?=
 =?us-ascii?Q?GDHbznmB1XpEjKucIi8eduQFmyZaPake9DBCZwTeQYULSN1kFRUrTwpBqKug?=
 =?us-ascii?Q?2d2l3DyrYPTiDk7wpvp1McBmTpizn2JT7wyfQmPFcikafJ3lt/hpV8H6VTNS?=
 =?us-ascii?Q?I60ewfHem6WKSvJMdHdxOt+I++OAza2n/tdJoslEHkb5IJg4D/rNXE9VcRDC?=
 =?us-ascii?Q?Dlq+hUI5arOT5/c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 16:19:17.5041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf9e8de-dad7-4694-b43b-08dd4d1354a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225

When a vxlan netdevice is brought up, if its default remote is a multicast
address, the device joins the indicated group.

Therefore when the multicast remote address changes, the device should
leave the current group and subscribe to the new one. Similarly when the
interface used for endpoint communication is changed in a situation when
multicast remote is configured. This is currently not done.

Both vxlan_igmp_join() and vxlan_igmp_leave() can however fail. So it is
possible that with such fix, the netdevice will end up in an inconsistent
situation where the old group is not joined anymore, but joining the new
group fails. Should we join the new group first, and leave the old one
second, we might end up in the opposite situation, where both groups are
joined. Undoing any of this during rollback is going to be similarly
problematic.

One solution would be to just forbid the change when the netdevice is up.
However in vnifilter mode, changing the group address is allowed, and these
problems are simply ignored (see vxlan_vni_update_group()):

 # ip link add name br up type bridge vlan_filtering 1
 # ip link add vx1 up master br type vxlan external vnifilter local 192.0.2.1 dev lo dstport 4789
 # bridge vni add dev vx1 vni 200 group 224.0.0.1
 # tcpdump -i lo &
 # bridge vni add dev vx1 vni 200 group 224.0.0.2
 18:55:46.523438 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
 18:55:46.943447 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
 # bridge vni
 dev               vni                group/remote
 vx1               200                224.0.0.2

Having two different modes of operation for conceptually the same interface
is silly, so in this patch, just do what the vnifilter code does and deal
with the errors by crossing fingers real hard.

The vnifilter code leaves old before joining new, and in case of join /
leave failures does not roll back the configuration changes that have
already been applied, but bails out of joining if it could not leave. Do
the same here: leave before join, apply changes unconditionally and do not
attempt to join if we couldn't leave.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v2:
    - Adjust the code so that it is closer to vnifilter.
      Expand the commit message the explain in detail
      which aspects of vnifilter code were emulated.
    
---
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Nikolay Aleksandrov <razor@blackwall.org>
CC: Roopa Prabhu <roopa@nvidia.com>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>

 drivers/net/vxlan/vxlan_core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ec0aee1d5b91..588ab2c16c67 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4419,6 +4419,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	bool rem_ip_changed, change_igmp;
 	struct net_device *lowerdev;
 	struct vxlan_config conf;
 	struct vxlan_rdst *dst;
@@ -4442,8 +4443,13 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
+	change_igmp = vxlan->dev->flags & IFF_UP &&
+		      (rem_ip_changed ||
+		       dst->remote_ifindex != conf.remote_ifindex);
+
 	/* handle default dst entry */
-	if (!vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip)) {
+	if (rem_ip_changed) {
 		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, conf.vni);
 
 		spin_lock_bh(&vxlan->hash_lock[hash_index]);
@@ -4487,6 +4493,9 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 		}
 	}
 
+	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
+		err = vxlan_multicast_leave(vxlan);
+
 	if (conf.age_interval != vxlan->cfg.age_interval)
 		mod_timer(&vxlan->age_timer, jiffies);
 
@@ -4494,7 +4503,12 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (lowerdev && lowerdev != dst->remote_dev)
 		dst->remote_dev = lowerdev;
 	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
-	return 0;
+
+	if (!err && change_igmp &&
+	    vxlan_addr_multicast(&dst->remote_ip))
+		err = vxlan_multicast_join(vxlan);
+
+	return err;
 }
 
 static void vxlan_dellink(struct net_device *dev, struct list_head *head)
-- 
2.47.0


