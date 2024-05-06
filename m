Return-Path: <netdev+bounces-93855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FB98BD645
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 22:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE166282011
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 20:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F09158A14;
	Mon,  6 May 2024 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ovc5ZrVd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6C13D521
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027558; cv=fail; b=U1q206u3kV/JeEW5LjOPEWFMmhe+Zvaufxdcfu0xlTL+mqE1TPeaScJGFcyp1OUgZcVQPCdQ4UscNYyz+CeGBm3XMFMdy4i2rTc1bJI2dNjO7/uNX7uKHgXAqYL8Cv2dWWtOsCJkP8/9ql97s26/E8+2K/v/mcuyeTjNc+JzOsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027558; c=relaxed/simple;
	bh=4XwZBUq6sgeQxIeaCpzAYPMN45R7fpO0tWJ5DY532zw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gm/nOOO3fq2KzU+qAngcYJN7lAxnZe7FwkRuNsidZuphQ95s8mmwD+FUde/n32XQPZIYhb3HeT9jGxUaEmjvIeLbiEclVpO/Wy1OHKrAkLr1RE5rksfnMXM3+GTKLi5qmeNWRMCfCaVSPYDyg7gcRQKa/4wl4dfO43KFC6Tlwso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ovc5ZrVd; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Grhs/NiMAhmMOimQ0Y7IN4YzMzOLKLrJueFSxB/Rhjt3q0aiBHX5QceKTkMNm3Cw2/wRAN1EJ8Igf2tGak+696Phu9u3MlHX6T5ZgwdGOV3K9/CMcMKNnbjD9JbvMEmvPvoodwZKaygZ9F3/b7hPoToNw+XZlwVFQXua/ws2EifH1fCWPiebGlHoFF5kNnJgWSh14JrhOnHWci4xcBCHS43Ds4YoVecuSgJ2FnS8jNiOjVjIdxYX+y4x0ArwDNEg5as1VfWwTxNe16w5JR9fpxeYnqXsDl9zNqEeqGABdnmGXiUDv3tkczKie8zz9PSLIojTd+TsSPOwACn6gQ/Jhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTkBaoG/oH3GjB1EoFxIsWn49qqUXGN3Rt2bvResbjQ=;
 b=AFvQuTFk3ku49TT9b1MhBIHY8RIv/+NbLHh4ulRislhQXPmWC0VGhGc65UzjndWEK1GZYyL+BcLp7K9U5IFP6VMoQ7tMAUh6sLXS0M8/6Qd0CSRRCfN1QB/m8pLt0hA1NH0G1HPMopFLm4KsLoZ9RvG//ILr2mJLoAy4K+5UH/zcEWPqlrOOO7kU06n+yL3TCLxxxwTfmZ5Bylot/R+bZ3NEXtG+6T86hMXabUijFEYW+50jpUWP+AcNt8YpZZbOTBlDnNqhE7WbjxdYq89IYDcHoW53WCQeZZGvwu/lC/HfofZg746eLztXy7JsYj+0xapJSZIEM1tyG4L+J3zQnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTkBaoG/oH3GjB1EoFxIsWn49qqUXGN3Rt2bvResbjQ=;
 b=Ovc5ZrVdObjO4j5y0XBHTwniX/cJMr78ZmB9js5H5kI1JJJXEMPpSuXp4T8WD433Px1ApgxudpJnOl3Rf/C2aB9/cg66UzYrLHwN7U0Y+Mfj2L14RFxCCmT1Zn8pO1Q3Oje+cJczS+ml+mcI0zNwvGbrwvTIGdg/6UUEaG6PI3R2wT2BrEYYXM4gldjkX3Uz0rzjOuxV9xySiiN5gPqeCu3mP9EeRYTW1DdwReP3Il/p3jJESwKIncHf8tkEkmcFXkvNKGihC5uUFO3lR7jT7ZPUQzUwr9Zwyaz2h1qK2gz5+Ad0Ix7KKW2LjtVRnzoGnx39f8nF6J4aQvHtDXM5aw==
Received: from CH0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:610:77::33)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 20:32:33 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::83) by CH0PR04CA0058.outlook.office365.com
 (2603:10b6:610:77::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 20:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 20:32:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 May 2024
 13:32:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 May 2024
 13:32:13 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 May
 2024 13:32:13 -0700
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <kuba@kernel.org>,
	<witu@nvidia.com>
Subject: [PATCH RFC net-next] net: cache the __dev_alloc_name()
Date: Mon, 6 May 2024 20:32:07 +0000
Message-ID: <20240506203207.1307971-1-witu@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: e0300060-c58c-4bbb-158c-08dc6e0ba884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SFbg2jTyjvLUrppu7XJndlACBTN9MWrskwR/I5gNS0iaDBACMVLLHk6z5VDu?=
 =?us-ascii?Q?og8CeBQuYb3QVVRNYkesBIVe82u5g9aw++c4WIDvjUrDxwfMRwncKnfY+PN0?=
 =?us-ascii?Q?+iDlR65vpjdshHjeTRfqUbW7fixbsh1jODRyo0UDg+2Aiead/IWSclq1kNgR?=
 =?us-ascii?Q?jGFNHckXSXKMGmiT4j79/ptlBRPdJ8TRgnE4CBWIYOTMNfsRPh14d1Yz6Mlg?=
 =?us-ascii?Q?JrPBfOW+rMtOHEswoQbIVKymnvgzq49P5Ko7qV4UrtQVwUmNkaUQuej4jFah?=
 =?us-ascii?Q?oK6xXPUgTvsFEuqL0gsBePVbBCGCgJuCuye3r+EGbMqZH7F90bP2qPpgAJGG?=
 =?us-ascii?Q?XGJ+rtXcape/d9HcY221qU+YivhuG3FTdO1jWBFqENRUhg3C+4Nxg2vwoxWh?=
 =?us-ascii?Q?3KcNwZuzk6lU2tlVA8ibLJkYXTMGVHz7rTVl4TZDL7bHN/YVo1fqBbp4FoSE?=
 =?us-ascii?Q?nj+Om9DNR6CEaL3E7P7U9lR4uEC0rq6vd/Ef6aPSLQYCq31Xke7WOjk9h18J?=
 =?us-ascii?Q?yiicbQwdS4NKKmjs9B9wnQLHWn8e9fOWJbfnfaQ9B8IWehWIhtMB6clWAr1N?=
 =?us-ascii?Q?594CahDXlrJzT5EgpXBrdYacPZdXOwDB8t8DYSIu2mDEpR6RxnjP/Vqxg0C3?=
 =?us-ascii?Q?tfCFFYNAld7eDdW77tf/tgjEsWo7KT6ypqdthlJJh8WvTrG7BM4MFzs8uR+l?=
 =?us-ascii?Q?eQaI6RsgIEBq8fa+QDLa1wqsaHTGBT59jj8JIF+ZwjO6p90r6nEqlAIIB3zi?=
 =?us-ascii?Q?IBSP0lU7rT5KsGYdmxtM+Cc4+2JgHiQKl6hfJ9bxnoz0RXXSklN/iVTtS40O?=
 =?us-ascii?Q?gHm8DAGITIwUv/YmrWIE1zBKjsXurHAjbS1Yb/Uk1vNnasD3o/4YBet8BiU8?=
 =?us-ascii?Q?oGEIPhYxZ6vQly8ywyBcGf1TPtftg4QaHdAo4BUZbtwy1q1Dds5zcq4GvXe0?=
 =?us-ascii?Q?kuZ1dyOYwimSkKUndAitu1yj1bRwS/Hga6ecP3y13sMlSfTRdXYRh8jp676P?=
 =?us-ascii?Q?ZQb3BKToxsLine95PLFTzBa6/t5nA63iZ40CVBPmh4CiXWI5fAopVe80eSR4?=
 =?us-ascii?Q?UtmifyQalPUfZ5EqpG3A31GQ2n/BQK0RHO43ulLESdnch1WeKcTjSPQ6O6jn?=
 =?us-ascii?Q?3wiGSqora/fZVrqQ4+zg2tVKpiBKEab9834q9BZdAoLES5eZ69rt0AWLatRA?=
 =?us-ascii?Q?R+hwd38GvqkkFSRqQxStCWYfrnxzKgGXpOPPMVhvIrcC8o3W9rEDuNBVBeq8?=
 =?us-ascii?Q?w/yjEXW2xlBOGgw5ZV6Og1eyfksF+zA5xUBd8JjTqLnJxXBBJY3LaBjJ/ibA?=
 =?us-ascii?Q?daZ/9OZ77BIsWdN12lKBeqCONWtE1SN2B3DAViJCNk4tghiJjsnVYIOXyfTf?=
 =?us-ascii?Q?qR3Ahfw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 20:32:32.9129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0300060-c58c-4bbb-158c-08dc6e0ba884
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108

When a system has around 1000 netdevs, adding the 1001st device becomes
very slow. The devlink command to create an SF
  $ devlink port add pci/0000:03:00.0 flavour pcisf \
    pfnum 0 sfnum 1001
takes around 5 seconds, and Linux perf and flamegraph show 19% of time
spent on __dev_alloc_name() [1].

The reason is that devlink first requests for next available "eth%d".
And __dev_alloc_name will scan all existing netdev to match on "ethN",
set N to a 'inuse' bitmap, and find/return next available number,
in our case eth0.

And later on based on udev rule, we renamed it from eth0 to
"en3f0pf0sf1001" and with altname below
  14: en3f0pf0sf1001: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
      altname enp3s0f0npf0sf1001

So eth0 is actually never being used, but as we have 1k "en3f0pf0sfN"
devices + 1k altnames, the __dev_alloc_name spends lots of time goint
through all existing netdev and try to build the 'inuse' bitmap of
pattern 'eth%d'. And the bitmap barely has any bit set, and it rescanes
every time.

I want to see if it makes sense to save/cache the result, or is there
any way to not go through the 'eth%d' pattern search. The RFC patch
adds name_pat (name pattern) hlist and saves the 'inuse' bitmap. It saves
pattens, ex: "eth%d", "veth%d", with the bitmap, and lookup before
scanning all existing netdevs.

Note: code is working just for quick performance benchmark, and still
missing lots of stuff. Using hlist seems to overkill, as I think
we only have few patterns
$ git grep alloc_netdev drivers/ net/ | grep %d

1. https://github.com/williamtu/net-next/issues/1

Signed-off-by: William Tu <witu@nvidia.com>
---
 include/net/net_namespace.h |   1 +
 net/core/dev.c              | 103 ++++++++++++++++++++++++++++++++++--
 net/core/dev.h              |   6 +++
 3 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 20c34bd7a077..82c15020916b 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -109,6 +109,7 @@ struct net {
 
 	struct hlist_head 	*dev_name_head;
 	struct hlist_head	*dev_index_head;
+	struct hlist_head 	*dev_name_pat_head;
 	struct xarray		dev_by_index;
 	struct raw_notifier_head	netdev_chain;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 331848eca7d3..08c988cac7a2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -197,6 +197,14 @@ static inline struct hlist_head *dev_index_hash(struct net *net, int ifindex)
 	return &net->dev_index_head[ifindex & (NETDEV_HASHENTRIES - 1)];
 }
 
+static inline struct hlist_head *
+dev_name_pat_hash(struct net *net, const char *pat)
+{
+	unsigned int hash = full_name_hash(net, pat, strnlen(pat, IFNAMSIZ));
+
+	return &net->dev_name_pat_head[hash_32(hash, NETDEV_HASHBITS)];
+}
+
 static inline void rps_lock_irqsave(struct softnet_data *sd,
 				    unsigned long *flags)
 {
@@ -231,6 +239,64 @@ static inline void rps_unlock_irq_enable(struct softnet_data *sd)
 		local_irq_enable();
 }
 
+static struct netdev_name_pat_node *
+netdev_name_pat_node_alloc(const char *pattern)
+{
+	struct netdev_name_pat_node *pat_node;
+	const int max_netdevices = 8*PAGE_SIZE;
+
+	pat_node = kmalloc(sizeof(*pat_node), GFP_KERNEL);
+	if (!pat_node)
+		return NULL;
+
+	pat_node->inuse = bitmap_zalloc(max_netdevices, GFP_ATOMIC);
+	if (!pat_node->inuse) {
+		kfree(pat_node);
+		return NULL;
+	}
+
+	INIT_HLIST_NODE(&pat_node->hlist);
+	strscpy(pat_node->name_pat, pattern, IFNAMSIZ);
+
+	return pat_node;
+}
+
+static void netdev_name_pat_node_free(struct netdev_name_pat_node *pat_node)
+{
+	bitmap_free(pat_node->inuse);
+	kfree(pat_node);
+}
+
+static void netdev_name_pat_node_add(struct net *net,
+				     struct netdev_name_pat_node *pat_node)
+{
+	hlist_add_head(&pat_node->hlist,
+		       dev_name_pat_hash(net, pat_node->name_pat));
+}
+
+static void netdev_name_pat_node_del(struct netdev_name_pat_node *pat_node)
+{
+	hlist_del_rcu(&pat_node->hlist);
+}
+
+static struct netdev_name_pat_node *
+netdev_name_pat_node_lookup(struct net *net, const char *pat)
+{
+	struct hlist_head *head = dev_name_pat_hash(net, pat);
+	struct netdev_name_pat_node *pat_node;
+
+	hlist_for_each_entry(pat_node, head, hlist) {
+		if (!strcmp(pat_node->name_pat, pat))
+			return pat_node;
+	}
+	return NULL;
+}
+
+static bool netdev_name_pat_in_use(struct net *net, const char *pat) // eth%d
+{
+	return netdev_name_pat_node_lookup(net, pat);
+}
+
 static struct netdev_name_node *netdev_name_node_alloc(struct net_device *dev,
 						       const char *name)
 {
@@ -1057,6 +1123,7 @@ EXPORT_SYMBOL(dev_valid_name);
 
 static int __dev_alloc_name(struct net *net, const char *name, char *res)
 {
+	struct netdev_name_pat_node *pat_node;
 	int i = 0;
 	const char *p;
 	const int max_netdevices = 8*PAGE_SIZE;
@@ -1071,10 +1138,21 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
 	if (!p || p[1] != 'd' || strchr(p + 2, '%'))
 		return -EINVAL;
 
-	/* Use one page as a bit array of possible slots */
-	inuse = bitmap_zalloc(max_netdevices, GFP_ATOMIC);
-	if (!inuse)
+	pat_node = netdev_name_pat_node_lookup(net, name);
+	if (pat_node) {
+		i = find_first_zero_bit(pat_node->inuse, max_netdevices);
+		__set_bit(i, pat_node->inuse);
+		strscpy(buf, name, IFNAMSIZ);
+		snprintf(res, IFNAMSIZ, buf, i);
+
+		return i;
+	}
+
+	pat_node = netdev_name_pat_node_alloc(name);
+	if (!pat_node)
 		return -ENOMEM;
+	netdev_name_pat_node_add(net, pat_node);
+	inuse = pat_node->inuse;
 
 	for_each_netdev(net, d) {
 		struct netdev_name_node *name_node;
@@ -1082,6 +1160,7 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
 		netdev_for_each_altname(d, name_node) {
 			if (!sscanf(name_node->name, name, &i))
 				continue;
+
 			if (i < 0 || i >= max_netdevices)
 				continue;
 
@@ -1102,13 +1181,14 @@ static int __dev_alloc_name(struct net *net, const char *name, char *res)
 	}
 
 	i = find_first_zero_bit(inuse, max_netdevices);
-	bitmap_free(inuse);
+	__set_bit(i, inuse);
 	if (i == max_netdevices)
 		return -ENFILE;
 
 	/* 'res' and 'name' could overlap, use 'buf' as an intermediate buffer */
 	strscpy(buf, name, IFNAMSIZ);
 	snprintf(res, IFNAMSIZ, buf, i);
+
 	return i;
 }
 
@@ -11464,12 +11544,20 @@ static int __net_init netdev_init(struct net *net)
 	if (net->dev_index_head == NULL)
 		goto err_idx;
 
+	net->dev_name_pat_head = netdev_create_hash();
+	if (net->dev_name_pat_head == NULL)
+		goto err_name_pat;
+
+	printk("%s head %px\n", __func__, net->dev_name_pat_head);
+
 	xa_init_flags(&net->dev_by_index, XA_FLAGS_ALLOC1);
 
 	RAW_INIT_NOTIFIER_HEAD(&net->netdev_chain);
 
 	return 0;
 
+err_name_pat:
+	kfree(net->dev_index_head);
 err_idx:
 	kfree(net->dev_name_head);
 err_name:
@@ -11563,6 +11651,7 @@ static void __net_exit netdev_exit(struct net *net)
 {
 	kfree(net->dev_name_head);
 	kfree(net->dev_index_head);
+	kfree(net->dev_name_pat_head);
 	xa_destroy(&net->dev_by_index);
 	if (net != &init_net)
 		WARN_ON_ONCE(!list_empty(&net->dev_base_head));
@@ -11610,6 +11699,12 @@ static void __net_exit default_device_exit_net(struct net *net)
 			BUG();
 		}
 	}
+/*
+	hlist_for_each(pat_node, head, hlist) {
+		netdev_name_pat_node_del(pat_node);
+		netdev_name_pat_node_free(pat_node);
+	}
+*/
 }
 
 static void __net_exit default_device_exit_batch(struct list_head *net_list)
diff --git a/net/core/dev.h b/net/core/dev.h
index 2bcaf8eee50c..62133584dc14 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -59,6 +59,12 @@ struct netdev_name_node {
 	struct rcu_head rcu;
 };
 
+struct netdev_name_pat_node {
+	struct hlist_node hlist;
+	char name_pat[IFNAMSIZ];
+	unsigned long *inuse;
+};
+
 int netdev_get_name(struct net *net, char *name, int ifindex);
 int dev_change_name(struct net_device *dev, const char *newname);
 
-- 
2.34.1


