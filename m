Return-Path: <netdev+bounces-182754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC060A89D44
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A23189FDEE
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D749D2951D4;
	Tue, 15 Apr 2025 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FknleMQd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771C2951B7
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719165; cv=fail; b=spXhkZDmXLF5znsVSsN+50BZFf8Oa8IbNxvYhftL7qhlMIo0R/bscafqJO6eMp7g0jFkILdMohAXWwkX08vS0It4Z82Uv+v/3Gjmfv96yAkjz0+jZDzBJp1Is333jVm1V7QPnJRxfw4KCnmvDR2CO6j85ySSXMElyUYPw1aSYmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719165; c=relaxed/simple;
	bh=eYjdM4Kp4cAhXM7Xc/uOz4BiPcw+KlmolpXRSxpTxqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEmLCX47bebIWp4+Q4CuTO9iINr9RwrOUW25d5F31O7QIIti0lZbtWD/TQ8fC3NK+99buAzK567elv0tdU/crBFkItCwx5UFHUUaY3IsJDUZ/LNNQBCVUql9LLl7ldG4XfdN5Re827TrErWhx3nDQQp8kAGNWGTfGwn1XuaTEqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FknleMQd; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJxR911DpmiN/plgEPQiuDrS+3YFfezVXWuKavTPfCiNeC+BaeBoJEMhJPpfkBo6IGOioarvtdyg1jRYD/EmBRtSIfNDxiPbcb9EVVyxgEIJn3YESda5PerLRSvvrFqzIvZWq8llYTmbUSrXY9VCKzkbmKrJTyTvUz3kn0J+S7wc3lPB2x9TOj7g+fnoHI8jDJsPhfNL5x611hW8WKtn+WV2jVveLTV8PUbbuxI/321mFWUHVgu8mB+wp1B8Gptd/ygXXk0U/GfE/Nk1Eofw+KzM3T9ol5aQApUdWlgrXkUEX8qV3KQCF8+UEpsXhUys4rlyX6NJBjOmmN59CwPpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfYjXlWg7uqJUj1T0oskiPG4biAhZm9KaIWX57Vt+S8=;
 b=tOTIvl2AJtM4dldFcbvw7kCYLsdnmbUPuSElrLKsFODeQh+w0sd8GYdLy3plptzLqcIkWQHrrW8XFUZZrh/5MTj9KwGl2isrWmoAP4GiNFAQ7oyl8To5/QN28pWFOCXj8oVhGSVGjwhHuzr/z3DqOvaoPL5mcVxrud/vcJ8VfaGC9ODNenBv3WsXMtzqh9zDeOAy9u2rsCeZeNvYo3XE4hfCGuaMAJ4ho7LEt9PQWOKiliib5Z71OLThg0Hcze6kOmjED4k9mt/fDoDZR9mV6jxrPyTVRAo3vzeEUllh6/hOsoZ0DOrNlTMK7HB/xsiKraPD0HhfyXB93FRqzHJhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfYjXlWg7uqJUj1T0oskiPG4biAhZm9KaIWX57Vt+S8=;
 b=FknleMQdmgYtoJwGmQRtFwjraQvfuuT8XRlOFXgCcFp3CNdOas0p0w+/PaEahPbJor5Q9dkTkB4ObLp7/2/G8qIKcUztP2B3hpL96ok7KuqjjCnXxIROt1Mkexyqo3iljy82cCnFDQ8+jDYz1VMl+4IbhS0FDA9Hpq/t/gIhopRwiv2jaWeymUISgSo1LsK7HvqS6evi8PlbHLy7HbEz0Hz+iGVbVkmbyIwlYReHLrgqIZGbW+zuvowh4rJzd78jQUYO3XQHBwSX6Mkp5r4LpMv/f6MCQY9b0dKvXvvVnyJoW+ENrg6KC0HKbxTZ28GHyAeHDTg5h/fWNyXV2NRJqQ==
Received: from BN9PR03CA0599.namprd03.prod.outlook.com (2603:10b6:408:10d::34)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 15 Apr
 2025 12:12:37 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::43) by BN9PR03CA0599.outlook.office365.com
 (2603:10b6:408:10d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Tue,
 15 Apr 2025 12:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:23 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:19 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 06/15] vxlan: Use a single lock to protect the FDB table
Date: Tue, 15 Apr 2025 15:11:34 +0300
Message-ID: <20250415121143.345227-7-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb2e5df-2973-472a-cdb7-08dd7c16cf86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+UYoiyJBZV43RMoF00BaxmrW4OKP5VqoWhWIPjhjyjDleJT0mpl95I3pNLXV?=
 =?us-ascii?Q?5onuIjzPxFFtL9n2AKW6IlzI87c9V3YOQuulhyJJ6tBj2lZFy6uK4jraRoHY?=
 =?us-ascii?Q?GLhLZOLnNtyabX4fxXb4+RMg4qcm7FQJjllDinNsFpU7mm2wv5QbKCrpGIr5?=
 =?us-ascii?Q?5tu9yNlKjHf2Nz5ansVglCE2krA9tUZGH/L8w4MAd/LdPQ6i9Od0ADfSTsdm?=
 =?us-ascii?Q?//x1HnvMK/41W6mzzv4+pMLTbYYi6J30ENyPn16VpYNwfGQleCFTZcZzRNOy?=
 =?us-ascii?Q?BN/SavFzdSY/uEYyuoqFJmf/jJh609X1wU8ZqEglIm5GnZ0FpmVgQpJGySmT?=
 =?us-ascii?Q?k+s/drAi837OtdmG8ghFMKA9tYeu/uzQZQ9B/c3eUnZ7lAls1vP3S/1MdUuc?=
 =?us-ascii?Q?JbADoPxy5zX4xpfKjptwO++x7FPzNjahKBbqSHiw3F25v/foNYUxEf2E735t?=
 =?us-ascii?Q?apVOeiwcNzIyOYg+m5h0MnHNxiDpM6CS2rj++fo7yl51YQmyTOla2zldxLST?=
 =?us-ascii?Q?ZSLOEbdwlP6XT2ww8blHhZSVROlZXMXRElgr1FOLG8mI2q43I1nLAxCf8mHH?=
 =?us-ascii?Q?ZuZP5eGNvr8uWlea9CmPYVkvOielKzpG0wtBo6EHm68TQ928rs0txLkJUHik?=
 =?us-ascii?Q?zjySYsi9QWNOHRHKf4xlGgXXlImvpUzziDMoOqBQxNiVW7GN3hO1c1KZ+uzY?=
 =?us-ascii?Q?pz51EFZiE2LAHqBHEcRZOKYAzX47UAJ/J1xYNmFp00CH3iYUOyTtL0FzM/Ht?=
 =?us-ascii?Q?l10HHGiOadD0xb+VIL14EPBP2+dizT2Dsdb7d84iyLvVgrXb97vFFoadJrQv?=
 =?us-ascii?Q?4NKN9Afxh79x0yBpaZjSKfvx+95LbompbMIUGq9CeAKb7W/cPO/2h34iRzH2?=
 =?us-ascii?Q?7ji5884MnzfV6+zjODzTQfgObtRpyvb2PfA6x3Z2Z1qNejCF789dBmr/zGdz?=
 =?us-ascii?Q?OfSNpGXasTkAQZWgzwBPMk1+5vC921uGl8by2X1jXCpfIZRZBAkHBMPODNpu?=
 =?us-ascii?Q?EmQ7/KQaBmb4yelP4okdbJTNdBitcrw+d2D6NDHjIfO6M1azf03eO1KkWRjE?=
 =?us-ascii?Q?+q5J8M853TdGXbUDaO4NlZLcE0pNSXlVcwFR/8RQGOfQTl1svjDP4CJv1DLo?=
 =?us-ascii?Q?x+o2jmcPQPotr/ur47+dKiF8wBIJhFtSZOBJRxdtl8gBm4L6+Dp6ginOkQCe?=
 =?us-ascii?Q?KfJZYXWAsyFbhv698wAcGwag5nJVLlca2We+eYcsBQ9QBVw1Iap2mnrjwZ2Q?=
 =?us-ascii?Q?Npp67ve96Yt2MobFRIEek06flVjYNa2vRPpRYYiQGZlTUNmSrwnLMRA2tKNu?=
 =?us-ascii?Q?ZzxaRZ1tXCsg4/JDySL1wXI3tBOTAOeE4gQVS47+ROEK6Pp465g85deqiyP1?=
 =?us-ascii?Q?2gK2JF+K7Wt395JUhHpN5eN+yvNCs+dm51vo5BjbNxh0r+ZENYPiiWU1IcQ/?=
 =?us-ascii?Q?sWcKMMPAfCiQTUXv/5cqKMGVBwdjx1H0n6Yn4OuQs2sUaaMVI/XYOcSIQxzw?=
 =?us-ascii?Q?a9gJmtaSFUyqNBQsG4nJ2Lf1AQyGlAg7wCwv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:36.7446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb2e5df-2973-472a-cdb7-08dd7c16cf86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116

Currently, the VXLAN driver stores FDB entries in a hash table with a
fixed number of buckets (256). Subsequent patches are going to convert
this table to rhashtable with a linked list for entry traversal, as
rhashtable is more scalable.

In preparation for this conversion, move from a per-bucket spin lock to
a single spin lock that protects the entire FDB table.

The per-bucket spin locks were introduced by commit fe1e0713bbe8
("vxlan: Use FDB_HASH_SIZE hash_locks to reduce contention") citing
"huge contention when inserting/deleting vxlan_fdbs into the fdb_head".

It is not clear from the commit message which code path was holding the
spin lock for long periods of time, but the obvious suspect is the FDB
cleanup routine (vxlan_cleanup()) that periodically traverses the entire
table in order to delete aged-out entries.

This will be solved by subsequent patches that will convert the FDB
cleanup routine to traverse the linked list of FDB entries using RCU,
only acquiring the spin lock when deleting an aged-out entry.

The change reduces the size of the VXLAN device structure from 3600
bytes to 2576 bytes.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c      | 82 +++++++++++------------------
 drivers/net/vxlan/vxlan_vnifilter.c |  8 ++-
 include/net/vxlan.h                 |  2 +-
 3 files changed, 34 insertions(+), 58 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d45b63180714..b8edd8afda28 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -524,8 +524,8 @@ int vxlan_fdb_replay(const struct net_device *dev, __be32 vni,
 		return -EINVAL;
 	vxlan = netdev_priv(dev);
 
+	spin_lock_bh(&vxlan->hash_lock);
 	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		spin_lock_bh(&vxlan->hash_lock[h]);
 		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist) {
 			if (f->vni == vni) {
 				list_for_each_entry(rdst, &f->remotes, list) {
@@ -537,12 +537,12 @@ int vxlan_fdb_replay(const struct net_device *dev, __be32 vni,
 				}
 			}
 		}
-		spin_unlock_bh(&vxlan->hash_lock[h]);
 	}
+	spin_unlock_bh(&vxlan->hash_lock);
 	return 0;
 
 unlock:
-	spin_unlock_bh(&vxlan->hash_lock[h]);
+	spin_unlock_bh(&vxlan->hash_lock);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(vxlan_fdb_replay);
@@ -558,14 +558,14 @@ void vxlan_fdb_clear_offload(const struct net_device *dev, __be32 vni)
 		return;
 	vxlan = netdev_priv(dev);
 
+	spin_lock_bh(&vxlan->hash_lock);
 	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		spin_lock_bh(&vxlan->hash_lock[h]);
 		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist)
 			if (f->vni == vni)
 				list_for_each_entry(rdst, &f->remotes, list)
 					rdst->offloaded = false;
-		spin_unlock_bh(&vxlan->hash_lock[h]);
 	}
+	spin_unlock_bh(&vxlan->hash_lock);
 
 }
 EXPORT_SYMBOL_GPL(vxlan_fdb_clear_offload);
@@ -1248,7 +1248,6 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	__be16 port;
 	__be32 src_vni, vni;
 	u32 ifindex, nhid;
-	u32 hash_index;
 	int err;
 
 	if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_REACHABLE))) {
@@ -1268,13 +1267,12 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
-	hash_index = fdb_head_index(vxlan, addr, src_vni);
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	spin_lock_bh(&vxlan->hash_lock);
 	err = vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
 			       port, src_vni, vni, ifindex,
 			       ndm->ndm_flags | NTF_VXLAN_ADDED_BY_USER,
 			       nhid, true, extack);
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	spin_unlock_bh(&vxlan->hash_lock);
 
 	if (!err)
 		*notified = true;
@@ -1325,7 +1323,6 @@ static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 	union vxlan_addr ip;
 	__be32 src_vni, vni;
 	u32 ifindex, nhid;
-	u32 hash_index;
 	__be16 port;
 	int err;
 
@@ -1334,11 +1331,10 @@ static int vxlan_fdb_delete(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
-	hash_index = fdb_head_index(vxlan, addr, src_vni);
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	spin_lock_bh(&vxlan->hash_lock);
 	err = __vxlan_fdb_delete(vxlan, addr, ip, port, src_vni, vni, ifindex,
 				 true);
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	spin_unlock_bh(&vxlan->hash_lock);
 
 	if (!err)
 		*notified = true;
@@ -1486,10 +1482,8 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 		rdst->remote_ip = *src_ip;
 		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
 	} else {
-		u32 hash_index = fdb_head_index(vxlan, src_mac, vni);
-
 		/* learned new entry */
-		spin_lock(&vxlan->hash_lock[hash_index]);
+		spin_lock(&vxlan->hash_lock);
 
 		/* close off race between vxlan_flush and incoming packets */
 		if (netif_running(dev))
@@ -1500,7 +1494,7 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 					 vni,
 					 vxlan->default_dst.remote_vni,
 					 ifindex, NTF_SELF, 0, true, NULL);
-		spin_unlock(&vxlan->hash_lock[hash_index]);
+		spin_unlock(&vxlan->hash_lock);
 	}
 
 	return SKB_NOT_DROPPED_YET;
@@ -2839,10 +2833,10 @@ static void vxlan_cleanup(struct timer_list *t)
 	if (!netif_running(vxlan->dev))
 		return;
 
+	spin_lock(&vxlan->hash_lock);
 	for (h = 0; h < FDB_HASH_SIZE; ++h) {
 		struct hlist_node *p, *n;
 
-		spin_lock(&vxlan->hash_lock[h]);
 		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
 			struct vxlan_fdb *f
 				= container_of(p, struct vxlan_fdb, hlist);
@@ -2864,8 +2858,8 @@ static void vxlan_cleanup(struct timer_list *t)
 			} else if (time_before(timeout, next_timer))
 				next_timer = timeout;
 		}
-		spin_unlock(&vxlan->hash_lock[h]);
 	}
+	spin_unlock(&vxlan->hash_lock);
 
 	mod_timer(&vxlan->age_timer, next_timer);
 }
@@ -3056,10 +3050,10 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 	bool match_remotes = vxlan_fdb_flush_should_match_remotes(desc);
 	unsigned int h;
 
+	spin_lock_bh(&vxlan->hash_lock);
 	for (h = 0; h < FDB_HASH_SIZE; ++h) {
 		struct hlist_node *p, *n;
 
-		spin_lock_bh(&vxlan->hash_lock[h]);
 		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
 			struct vxlan_fdb *f
 				= container_of(p, struct vxlan_fdb, hlist);
@@ -3079,8 +3073,8 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 
 			vxlan_fdb_destroy(vxlan, f, true, true);
 		}
-		spin_unlock_bh(&vxlan->hash_lock[h]);
 	}
+	spin_unlock_bh(&vxlan->hash_lock);
 }
 
 static const struct nla_policy vxlan_del_bulk_policy[NDA_MAX + 1] = {
@@ -3358,15 +3352,14 @@ static void vxlan_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	INIT_LIST_HEAD(&vxlan->next);
+	spin_lock_init(&vxlan->hash_lock);
 
 	timer_setup(&vxlan->age_timer, vxlan_cleanup, TIMER_DEFERRABLE);
 
 	vxlan->dev = dev;
 
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		spin_lock_init(&vxlan->hash_lock[h]);
+	for (h = 0; h < FDB_HASH_SIZE; ++h)
 		INIT_HLIST_HEAD(&vxlan->fdb_head[h]);
-	}
 }
 
 static void vxlan_ether_setup(struct net_device *dev)
@@ -3977,10 +3970,7 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 
 	/* create an fdb entry for a valid default destination */
 	if (!vxlan_addr_any(&dst->remote_ip)) {
-		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac,
-						dst->remote_vni);
-
-		spin_lock_bh(&vxlan->hash_lock[hash_index]);
+		spin_lock_bh(&vxlan->hash_lock);
 		err = vxlan_fdb_update(vxlan, all_zeros_mac,
 				       &dst->remote_ip,
 				       NUD_REACHABLE | NUD_PERMANENT,
@@ -3990,7 +3980,7 @@ static int __vxlan_dev_create(struct net *net, struct net_device *dev,
 				       dst->remote_vni,
 				       dst->remote_ifindex,
 				       NTF_SELF, 0, true, extack);
-		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+		spin_unlock_bh(&vxlan->hash_lock);
 		if (err)
 			goto unlink;
 	}
@@ -4420,9 +4410,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 
 	/* handle default dst entry */
 	if (rem_ip_changed) {
-		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, conf.vni);
-
-		spin_lock_bh(&vxlan->hash_lock[hash_index]);
+		spin_lock_bh(&vxlan->hash_lock);
 		if (!vxlan_addr_any(&conf.remote_ip)) {
 			err = vxlan_fdb_update(vxlan, all_zeros_mac,
 					       &conf.remote_ip,
@@ -4433,7 +4421,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					       conf.remote_ifindex,
 					       NTF_SELF, 0, true, extack);
 			if (err) {
-				spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+				spin_unlock_bh(&vxlan->hash_lock);
 				netdev_adjacent_change_abort(dst->remote_dev,
 							     lowerdev, dev);
 				return err;
@@ -4447,7 +4435,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 					   dst->remote_vni,
 					   dst->remote_ifindex,
 					   true);
-		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+		spin_unlock_bh(&vxlan->hash_lock);
 
 		/* If vni filtering device, also update fdb entries of
 		 * all vnis that were using default remote ip
@@ -4747,11 +4735,8 @@ vxlan_fdb_offloaded_set(struct net_device *dev,
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *rdst;
 	struct vxlan_fdb *f;
-	u32 hash_index;
-
-	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
 
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	spin_lock_bh(&vxlan->hash_lock);
 
 	f = __vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
 	if (!f)
@@ -4767,7 +4752,7 @@ vxlan_fdb_offloaded_set(struct net_device *dev,
 	rdst->offloaded = fdb_info->offloaded;
 
 out:
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	spin_unlock_bh(&vxlan->hash_lock);
 }
 
 static int
@@ -4776,13 +4761,11 @@ vxlan_fdb_external_learn_add(struct net_device *dev,
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct netlink_ext_ack *extack;
-	u32 hash_index;
 	int err;
 
-	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
 	extack = switchdev_notifier_info_to_extack(&fdb_info->info);
 
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	spin_lock_bh(&vxlan->hash_lock);
 	err = vxlan_fdb_update(vxlan, fdb_info->eth_addr, &fdb_info->remote_ip,
 			       NUD_REACHABLE,
 			       NLM_F_CREATE | NLM_F_REPLACE,
@@ -4792,7 +4775,7 @@ vxlan_fdb_external_learn_add(struct net_device *dev,
 			       fdb_info->remote_ifindex,
 			       NTF_USE | NTF_SELF | NTF_EXT_LEARNED,
 			       0, false, extack);
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	spin_unlock_bh(&vxlan->hash_lock);
 
 	return err;
 }
@@ -4803,11 +4786,9 @@ vxlan_fdb_external_learn_del(struct net_device *dev,
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_fdb *f;
-	u32 hash_index;
 	int err = 0;
 
-	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	spin_lock_bh(&vxlan->hash_lock);
 
 	f = __vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
 	if (!f)
@@ -4821,7 +4802,7 @@ vxlan_fdb_external_learn_del(struct net_device *dev,
 					 fdb_info->remote_ifindex,
 					 false);
 
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	spin_unlock_bh(&vxlan->hash_lock);
 
 	return err;
 }
@@ -4870,18 +4851,15 @@ static void vxlan_fdb_nh_flush(struct nexthop *nh)
 {
 	struct vxlan_fdb *fdb;
 	struct vxlan_dev *vxlan;
-	u32 hash_index;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(fdb, &nh->fdb_list, nh_list) {
 		vxlan = rcu_dereference(fdb->vdev);
 		WARN_ON(!vxlan);
-		hash_index = fdb_head_index(vxlan, fdb->eth_addr,
-					    vxlan->default_dst.remote_vni);
-		spin_lock_bh(&vxlan->hash_lock[hash_index]);
+		spin_lock_bh(&vxlan->hash_lock);
 		if (!hlist_unhashed(&fdb->hlist))
 			vxlan_fdb_destroy(vxlan, fdb, false, false);
-		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+		spin_unlock_bh(&vxlan->hash_lock);
 	}
 	rcu_read_unlock();
 }
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 6e6e9f05509a..e137c5bb4478 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -483,11 +483,9 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 					  struct netlink_ext_ack *extack)
 {
 	struct vxlan_rdst *dst = &vxlan->default_dst;
-	u32 hash_index;
 	int err = 0;
 
-	hash_index = fdb_head_index(vxlan, all_zeros_mac, vni);
-	spin_lock_bh(&vxlan->hash_lock[hash_index]);
+	spin_lock_bh(&vxlan->hash_lock);
 	if (remote_ip && !vxlan_addr_any(remote_ip)) {
 		err = vxlan_fdb_update(vxlan, all_zeros_mac,
 				       remote_ip,
@@ -499,7 +497,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				       dst->remote_ifindex,
 				       NTF_SELF, 0, true, extack);
 		if (err) {
-			spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+			spin_unlock_bh(&vxlan->hash_lock);
 			return err;
 		}
 	}
@@ -512,7 +510,7 @@ static int vxlan_update_default_fdb_entry(struct vxlan_dev *vxlan, __be32 vni,
 				   dst->remote_ifindex,
 				   true);
 	}
-	spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	spin_unlock_bh(&vxlan->hash_lock);
 
 	return err;
 }
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 2dd23ee2bacd..272e11708a33 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -296,7 +296,7 @@ struct vxlan_dev {
 	struct vxlan_rdst default_dst;	/* default destination */
 
 	struct timer_list age_timer;
-	spinlock_t	  hash_lock[FDB_HASH_SIZE];
+	spinlock_t	  hash_lock;
 	unsigned int	  addrcnt;
 	struct gro_cells  gro_cells;
 
-- 
2.49.0


