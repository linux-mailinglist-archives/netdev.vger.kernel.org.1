Return-Path: <netdev+bounces-238119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1E7C543E7
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E5D74F14BC
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7DD35389A;
	Wed, 12 Nov 2025 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lJsvGiCh"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF1202C48
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976138; cv=fail; b=aocOEWf6w4e+N+xzkiF3RLm+zyWSxRpymJm7OMeC/sx4jxXyJjyw/DscK07gTzdmuAES+jnXmFNJywKd22NzgKOUNhcdU+IFZsEUkwlO8zqgzq0tkkOSL5TYVrEAMrNLJ8zy/3M6ab0EzPCasR4c02h6PrAB28jRdtywU1LOJtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976138; c=relaxed/simple;
	bh=Q0lhQ896wDt9NO4Ci7D7blcQcN+AHZSHPANcVOsvZOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ip2lPK0os3nznzOcnALRQpF6/vw3k0nD5hRbii/UCykBRSxoAQQxGA61kPmVu2bebqOr6nV2yKrG7ELNHSoAA3FyROPYZkqcGjB5lBCWfTOHLUqUJP/tVpxqxykl4lBj4rYV+E8/1LeOj2bD/H/tWMhxQB/8f0cgqP6BK+Fm4AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lJsvGiCh; arc=fail smtp.client-ip=52.101.62.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtgo+LNvC0fu+Cc7yBMOFJZ5UowUgFdLCAlBu1sO8hNSeExs4pJcJ/cVzfyHm4Wu4VDzs1gNE2CzNrOQy5lncIdFmtyyDs78mW+wiv9oMCHx+9jcf/vZ+DECWDcnUveMSTdWRrxYUcvLbjx/W5f6ypqfTXjvERClFY7CO8HfRDcpcOHdd3ghSbE6EywRSYUJcAXRoi3pZ4TYfPHdbWIGNUhtNA7rigVXkVHHozVitmILYtTaAAAbCdMyyVp/Muth+irlIYBym/2n43EH6laZ6c8tlDYl8PIW0YHsICBf1uqIDz9hBafdlQWh20MwTqnOEPlY5I9bPScoPyE6b0twIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dGbfRCZu8SsSNG/ZoBsoAJ8hCQmUuC0Ygb87Antazo=;
 b=wQyx3sxw6Dd5Ue+LBvqW0k/wZ4nQX/ZGuADnaV4FKcoE5W5Po04viG4ZJ1/Qrb7AuUvpdvWFO/OjOKEAlK7f6jCHNoP3+6MDg0SKNtPyimnktSfMA3wEr2Mij6Tl5jv9PQg0G0uEKTbC9+ET/Dec1Y/v9ozGKh7KundIIaLSOkITgdaa9NQBVIVB6p+//KW9215h3KS5fxzX2hJpnxY5NQ/UbhM8eclqLiO3QAdbljJAbgVhzxAWdbXis9fjqv9bbsNCxpwUG4keHRZujEvnlSX9EiZHMDcD2bsSD55IRLQs7FESl4JSzkRb9PrgcGvoqgcB9wbtlPI5kO6DLjGFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dGbfRCZu8SsSNG/ZoBsoAJ8hCQmUuC0Ygb87Antazo=;
 b=lJsvGiCheJ7YHqHbpJZmcUqVlh1iNqLVvcdaqnNyRdnRnNyB7kYM759HNzRAW9onFexXgG2+RcicttEokwQI+kfXdbLduhOPTmBL6p0ADPlQYKeCEpicssSqTm5+N9aO+ZGXGuR1QMKVkPKor8nw1D8YxAwBNhsYbm4SsSRfNI22qjn4VQmt5AklHal4nWKEZV2vq84GetHTtQqAcYl5nmcq06E5Fy8cQX9QoRc6DrjsnHupGP9dK0J8XCElKuo6gAjk3S8ZZfpxxy1HGLBKrmdWqe3iWcRbaNsB2ChdvEiAiY4mOtZaVvv5TsantBGryQHwuW7KXraxbTWWKhu0qw==
Received: from BLAPR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:36e::20)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 19:35:26 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::4f) by BLAPR05CA0024.outlook.office365.com
 (2603:10b6:208:36e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.5 via Frontend Transport; Wed,
 12 Nov 2025 19:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 19:35:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 11:35:07 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 11:35:06 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 11:35:05 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v10 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Wed, 12 Nov 2025 13:34:33 -0600
Message-ID: <20251112193435.2096-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251112193435.2096-2-danielj@nvidia.com>
References: <20251112193435.2096-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 0504212d-6efe-4395-dcb4-08de2222a17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ry9iS7z+T5PFp2gy/9OotvoPS6EwGJc6LGR44owztsE5o9YUFY4OuGKmC7RU?=
 =?us-ascii?Q?Z+swHlWMMoNbEJs1EwrSSvEPclaTkxjHKUs7FJaF2i98y3tqAC5mKoH5UtTU?=
 =?us-ascii?Q?Hmtko/aYhrxV08kpWrgKJdyb1d5ZE6YNBi9kUGNakdRjMf+bekG8GYcWV3wl?=
 =?us-ascii?Q?1HtoHtBOOk4qoWJDNkAO1Kt3BFelRSTDkX87laHqwatvHYoQKzpyrSCkyMON?=
 =?us-ascii?Q?RI6/6PaOxU/TQkszLZF/qtQzu2QD2XKqNqHutZUr1jhOdb5Q8KYqLC8Lc55/?=
 =?us-ascii?Q?zgMTkmJvDYr50rVr/y+CnKnxGnwBya2lFmJ1FQLgWrV1HIU/q1kmIhOO6PeC?=
 =?us-ascii?Q?gvX3Cy2Jku6vbZEryNQUbIGKbOWMStsonGlU8DvMIbxclAxx5FtLwMmDfGWp?=
 =?us-ascii?Q?1qqgSQOsj/PIY0zkIEv0myfp6uUwERvgyCHjqWe+tIT55z6zyU7azPK4HQPm?=
 =?us-ascii?Q?SbphGLeRbvp3p2pVfpFXCNRYQmUoIYrGxb2nuT5+kknwxfVqcZ+O7a/WhA+5?=
 =?us-ascii?Q?guFWaH1A+F5J5OqVGhC+TgnmdWhtLnSWOUr5/XWLTAokyzNlCYVughI7vB8C?=
 =?us-ascii?Q?g7SBHX0YGc9gGgdkjV7IZkG5257hPy9/swOjXbE0JeKukBWiskLvtaEhqzGc?=
 =?us-ascii?Q?lyt+zf2CeDyvgBkUZFMRxQtqBaiGvT767nLwaj8T6UoRzCes7TkGRk6W64ry?=
 =?us-ascii?Q?L4sEZt5bZnb0MdfufegJPtPY3LfCyyCXrJ4gtJG5BNrZBuhFDfGW+5THIm6Z?=
 =?us-ascii?Q?plv5upvbBP6QFOuzRvcol2kBpPP0rul8sNKTlBQZEWHgpSnifloH7UpJotMu?=
 =?us-ascii?Q?XcI46M4c77b5vU5X1wHXcM3M6UwIX8RPckvLKNkYxW6ABBE/zdPqig7lC5z/?=
 =?us-ascii?Q?3Ljrm09fGnmRw8VQeRk2bkKIsBMhTX0jhzRK7sSUqLYUBSKRLcgSy64QdAcI?=
 =?us-ascii?Q?cNcsZejBHaRkdBrrNbhJem9A/naZIvtbHOQHAevhsggoFoVspG9pon3O3LH0?=
 =?us-ascii?Q?I24KLsHwklAJ+okTDM/HwUU/358sOzIRWD5nKfhWNJJKZPmZvwbL7WJP9i55?=
 =?us-ascii?Q?oAtuiTPKfeuE0cK3pDn0Bb3BpTXwqx52EGdxf9UDXj5U5xiJUbbVVF75k86u?=
 =?us-ascii?Q?VfrLezzMCsIht7Ux0SfQAtCNaaAZZtRz07w/k8YvWmbn3hdT4iHa7NF5XWZX?=
 =?us-ascii?Q?1mW4AshjjHr+1cb0dqHXpgutVrt5yMVwlhzdahCmjzH6YE5r/QV0S56HAtiO?=
 =?us-ascii?Q?vJ6MWxrXBoln70gF4JAjg9w09+xJgLYPKMlXV4848Mbh/xa4DbkOi07mUnMk?=
 =?us-ascii?Q?lPI5ZxixOjyhprVI3UyDAStsYV0Ul6csXoJ5J7ioCjMtpbuazOLOsmpCqoW/?=
 =?us-ascii?Q?YOI4oYlfauJqvl+pAUUcOaxpCy6RoTWJAZnOKLfSu7ywZkONe2v8X7QmOT8D?=
 =?us-ascii?Q?gkMUE60ufnewZ0md+ZVCMgpwWxFe+rklFsKxGR3W02CxQOpWfJ7ySsiTlt/R?=
 =?us-ascii?Q?uyMNlMMEhTT4cgvMeldcEGimy2tTHo7DQ9pCewa8rTwI7Rfz58q6Llam6jIb?=
 =?us-ascii?Q?HPe8rxs50ra5QmDj8L8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 19:35:26.5136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0504212d-6efe-4395-dcb4-08de2222a17d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719

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
index 5e51a9371582..73756334a040 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6926,6 +6926,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -6940,6 +6968,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -6962,11 +6993,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -7102,6 +7160,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -7144,7 +7203,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 	++(*num_hdrs);
 	if (has_ipv4(fs->flow_type))
 		size += sizeof(struct iphdr);
-
+	else if (has_ipv6(fs->flow_type))
+		size += sizeof(struct ipv6hdr);
 done:
 	*key_size = size;
 	/*
@@ -7181,18 +7241,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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


