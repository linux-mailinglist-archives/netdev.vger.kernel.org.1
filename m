Return-Path: <netdev+bounces-239599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12DC6A0B1
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C75F22BFA3
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A8635E52D;
	Tue, 18 Nov 2025 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZvQjtW7N"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A7035C199
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476789; cv=fail; b=khotMfwMdU463YtX97E7Gr2gqZdxQ2PjiIYoD6pPCEdoVPKE+grJyoA0li1zuulBoRs6SMbkvbNdtE2/Qq3Xpft5R5lZSnP/Gu6+ldWlQHTez5GPmzUkFgh4ausZxHp2ES3RgFki/IGhP2Mg+jzsfK6wy0juhvXA7kqKv+8Y5BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476789; c=relaxed/simple;
	bh=xakC2Fn5Dmj7dWLfKaLLBUiPU0hIiOPjK/r8Fe8JgGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Md/BXywn7crWRzbMP3hPv9C1E+XlQE2wOi53GwZpHxidC28MZlaJx8mU7cDhY/bFDnmfYeE6MkEJcwEI+wYPtNh2Hqh66FPj9RAz6SI0Q9QAvHixhRBgYGmZJgyDiIV2IjF8S4+YnHwdL80FkZO4qOhUzfINtak3S1G0ZqYkWQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZvQjtW7N; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idVDYyGpe+QAaB3s4yl4jDZqj2OJrmmC6uU6T7j3yPqpbrI0wmI3EMY12VqbjQG0tUsipqRB/IoAgmgAbIyt30MN7wLVbvMPsmkJDjpbf6XQhokOruUnsNRyovMofTN7lgOTqdYHs9vWsJzIoN26L6lBkW9LyxahyQBEwKm/XKRTQ1AaM7AE4P231IgRPbiiSzD5Nf15eMzLRPwX7mqFD0xpbKLeByOe83uT6m2Q0F3GJE7lokrE2twnTpOVdY6qQ2tsMR8hepweOphhBjyofQG+AJcWquBmm5oZQcW8TXObux5m7fZoCHq6uOBMeD4s/8nZtvepsdOYcIZt9fVH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqWs02KODqvVHufZ4JuQp8LD8CNQtx9ugdZ3SnID3bk=;
 b=snuofm1oQ9I8FFvVqTNRjVQJxzenbfAQd9On6Pecd3Z7srn7HhUSNvS1e6BY/xEhjc8ZoevXXVU4E9fDgc4ZmmmwInKWtgb3fTzvBc4P+Gy8mJQhKkDgp+6SCYMF/31/s2tsImiYsNQMllJdUneTm93oizZYbz1JX6QcuhkQ7QFK7FP18exXMCeJaydw2krvYveC/mctrKJONIKQjZXc+TvINGw4w18uVYXh8jf8m7bOSByYQJ+QL0tmgJP2lhubkc00YqYOICIZbiwFXPhvbM8U+p7Q5FYad+dFCT/AkUeRUPpHyVn6LxuQHZRySR5CAoIIPUnA0gy602uYPPt3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqWs02KODqvVHufZ4JuQp8LD8CNQtx9ugdZ3SnID3bk=;
 b=ZvQjtW7NmrrIAoMpKwv1AoeitH1m5S/BrltUe/5CtW0WLVfVoQTC9Woc0eCx3LYEdo1zWGVb7mp+oF9JFpGGm2x3ZV6aXwEFU7gjOehSkZ1uMTnyjmSWx+iSrsA/9hS+o3FqtSZI+Q5AVKr2sgmzvAXdT3Y+fCEmlu83W0ohi/ht4jXPOABebj2iM9PgwPoSUXhxbRnukx7Ss7C9193RmVUom1TyKsJ9++Qm/LfgaaawA9Ag9rOiGkkPQRExxPFJh3xTFSlhuiv+fNmwHW0bpK7feyAEcSiORcUD6r9bCtIY77hjgzOULa/JGle+/YInSJJm8VRLIZO77TFZmkFAiA==
Received: from BN0PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:143::18)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:39:40 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::17) by BN0PR10CA0004.outlook.office365.com
 (2603:10b6:408:143::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:39:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:39:24 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:39:23 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:39:22 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v11 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Tue, 18 Nov 2025 08:39:00 -0600
Message-ID: <20251118143903.958844-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251118143903.958844-1-danielj@nvidia.com>
References: <20251118143903.958844-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 84026db4-d49f-4d70-a22d-08de26b04e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EN8zHIXqKDM7tJBGsejMG6gU0M7COc7Bp5kJaa3Q/FcTPpx3roUpMbnvzWAu?=
 =?us-ascii?Q?0cUrDFXEmx3yaIDN9ePXrS2/WXbYfkwKIZxcCGRrQ0EMCKa6YAizQmbgBh4Z?=
 =?us-ascii?Q?pjiSUItIMFwA+dvBmOjO7Mk9qcwSx8tbKkEp8Iys7dsNoTonht3hsMSCo1gc?=
 =?us-ascii?Q?kJkMQPeskm3MRcQhkYJ8HQ3155wzoY3shWd0hXy/iyN1RJky15shumk05uh9?=
 =?us-ascii?Q?FhNCgChVAD2OYjAyO7pcIIjM/IUo/iJuU1v4dlSZhn9myDsA2DVBGwIpENAp?=
 =?us-ascii?Q?XMejWlipJCIs3TuxklGefG9fHJUU7pkaflKUKnrxIF7Bt6PxhQEQ4gd+9ZLQ?=
 =?us-ascii?Q?MPjoSI3HYtE6CF39xzgHBwKHIaWgGKobmC88K24+KHdh4YkmbCpTr11bl8M1?=
 =?us-ascii?Q?ZWykjElZQr1K7KcuKknSmshGJOu911nrbN9vUVO5V0SNKI/ktY5+tThoCMkB?=
 =?us-ascii?Q?vhT4xA7ty8POjCJxbdGYz8Zqp9R0YtGjBuI8g9XuwpoO6NDiEQN4Hv5Gtu5i?=
 =?us-ascii?Q?LWDtFP53FOna7EPhEBIsa2MK5+rWMIJT854Z7dEzctYjTtYNhjvBX+/KGR7i?=
 =?us-ascii?Q?MZTAy4lgpIP52Ta9MmwXLgOBjAtCLi9xs7ukMc2k7fdxWBENVGj7GTDe1lXV?=
 =?us-ascii?Q?6YHNMzC5Vv3RVjrGTQVcKhWsF3Q9JZSxcJapgtBorlLh5ByVyhHJIVgU7Ify?=
 =?us-ascii?Q?sAhjXe301mq0wkDMknROvHD9lX8/uRGuP/kJwRvXoJF1tpfYHx9bI2E1xjuI?=
 =?us-ascii?Q?iw13drFM+eKtdR62smDXbRLE12qhrLgPoYHe9g6khu788T1a96N5PW6wUMMC?=
 =?us-ascii?Q?/G265P37JimWLYv/hibBefbO3ipeAUTqZeTviRaYceAYtDRz9pHGjZGZMi6e?=
 =?us-ascii?Q?ihn81ioeiHuFcIc+c8p+Kb4fRx4lDuQtuVKrtmI1MA4ew3tABMpGZ8SkarTw?=
 =?us-ascii?Q?RnE3i+DSazYCpfuhaWjXewwUrH/Ht7iS/7BbMgsxwEbPqeHXfa2kp+e2znAR?=
 =?us-ascii?Q?i1p75yb5xZzggLJW3zav+ZBaH5fi5N5D8ajev/7KurxJYU+1ATqEARyPR8Dm?=
 =?us-ascii?Q?N0gmLSILcNxnkzd8nG62imNhr6hk2PKBa8Yl7kZae0hgZ21gjQyLbLg+zQcM?=
 =?us-ascii?Q?FtVLVm2mTsAl+9EVuzXcoGYuO+7NDQjPS81j22r2NznZFxuXBp7CVTKBfOec?=
 =?us-ascii?Q?cDIAIGz20HvycZf2SnjxiI+sQ723A5AZcXpz1WV7TaWNlbxXNVDgDYEIkJCK?=
 =?us-ascii?Q?qjjiNGdSIO3IZMwBMN1nw7/u38nwI7a4ig9lm50554pTS/odCDSA5YbNbSiI?=
 =?us-ascii?Q?HvJf1E6YGOsr5I9YDwJWG27n204knCnVozw0/oYyyx1FrXoKl+ENyWH0N28X?=
 =?us-ascii?Q?oA4Otb1rtjRjNSRSZsKhw6PrpuS52+PWh0Z/8W6nin7ScK+A7Z+eNM4Zuua7?=
 =?us-ascii?Q?rEW+1HkmcxSrGrzLwGPL5LWOsVGJOwLKnO+SutBGP9thZAkcB4isxTi1idhU?=
 =?us-ascii?Q?wA0rfoHFmNRSbF/1M4pRS5M8m7ZlGTU3R12CX18S8NbXzeb/7TyxYKdWSsYx?=
 =?us-ascii?Q?zkph+5hjbAsGc8seYAw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:39:39.7973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84026db4-d49f-4d70-a22d-08de26b04e1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474

Implement support for IPV6_USER_FLOW type rules.

Example:
$ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
Added rule with ID 0

The example rule will forward packets with the specified source and
destination IP addresses to RX ring 3.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: commit message typo
---
 drivers/net/virtio_net.c | 89 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c1adba60b6a8..78fc8f01b6c4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6932,6 +6932,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip6_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct ipv6hdr *cap, *mask;
+
+	cap = (struct ipv6hdr *)&sel_cap->mask;
+	mask = (struct ipv6hdr *)&sel->mask;
+
+	if (!ipv6_addr_any(&mask->saddr) &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(cap->saddr), partial_mask))
+		return false;
+
+	if (!ipv6_addr_any(&mask->daddr) &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(cap->daddr), partial_mask))
+		return false;
+
+	if (mask->nexthdr &&
+	    !check_mask_vs_cap(&mask->nexthdr, &cap->nexthdr,
+	    sizeof(cap->nexthdr), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -6946,6 +6974,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -6968,11 +6999,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 	}
 }
 
+static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
+	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
+
+	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
+		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
+		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
+	}
+
+	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
+		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
+		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
+	}
+
+	if (l3_mask->l4_proto) {
+		mask->nexthdr = l3_mask->l4_proto;
+		key->nexthdr = l3_val->l4_proto;
+	}
+}
+
 static bool has_ipv4(u32 flow_type)
 {
 	return flow_type == IP_USER_FLOW;
 }
 
+static bool has_ipv6(u32 flow_type)
+{
+	return flow_type == IPV6_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -7108,6 +7166,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -7150,7 +7209,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 	++(*num_hdrs);
 	if (has_ipv4(fs->flow_type))
 		size += sizeof(struct iphdr);
-
+	else if (has_ipv6(fs->flow_type))
+		size += sizeof(struct ipv6hdr);
 done:
 	*key_size = size;
 	/*
@@ -7187,18 +7247,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
 			     const struct ethtool_rx_flow_spec *fs)
 {
+	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct ipv6hdr *v6_k = (struct ipv6hdr *)key;
 	struct iphdr *v4_k = (struct iphdr *)key;
 
-	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
-	selector->length = sizeof(struct iphdr);
+	if (has_ipv6(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
+		selector->length = sizeof(struct ipv6hdr);
 
-	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->h_u.usr_ip4_spec.tos ||
-	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
-		return -EOPNOTSUPP;
+		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip6_spec.tclass)
+			return -EOPNOTSUPP;
 
-	parse_ip4(v4_m, v4_k, fs);
+		parse_ip6(v6_m, v6_k, fs);
+	} else {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+		selector->length = sizeof(struct iphdr);
+
+		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip4_spec.tos ||
+		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
+			return -EOPNOTSUPP;
+
+		parse_ip4(v4_m, v4_k, fs);
+	}
 
 	return 0;
 }
-- 
2.50.1


