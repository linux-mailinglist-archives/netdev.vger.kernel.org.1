Return-Path: <netdev+bounces-247840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03069CFF1A4
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7127630019EB
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9968036213D;
	Wed,  7 Jan 2026 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K0ccQIHh"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879735FF5D
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805517; cv=fail; b=hIi7onqTtxWze6DQRhP0OWV7bEpq47UO2CuF0XQPGhMLW2wjAuWV5g6Da+/tFEg8OWIGdFFoh4nEMzBoZCt+Kg/QxG3/zlZHZB1M9Ed3LJ3REmDnCjFn8GyFTP/YW9l2dxwG53R04l/QRHFByC3GgNxXoHOAzqDY+/HZvKFtwL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805517; c=relaxed/simple;
	bh=PLCa7VpY9dQDzr0gH7LWrBhhaSycmJtrL61poww2lLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZKLRLPpNk0Bcjo2TlS8aF4vbQFWNfz/icxDjt6ifv8Y8fIzR4ZxKPuKlssrZUN7Zmcz77KJxbYlolV0/OGWz6qQjqnFK8dHq+XZbEE/ul6I6Nne/I/qkDUtQ/ITNoTe6DVChu7liabqn5+l3kUtH4sC96EBRWEI93pdQoHq6k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K0ccQIHh; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehwtMKQT0ctsz9utDD16mSs4Abx83g4ii1sns/Sgli6DZw5drVAfSodLRz8TqqP44O6PPDuzd4YSIzB+brE7L8mXM8RUYh1p/m0EQQ5X8dhZa1afqCTOmYpqWKwCh8JSb61ku1Uw3v2mw1wIOUEMe9alj+CIgbF7wGdpKMrrFi3ZFYawlXtxi57VYiHw8VfJxi4FUANcNki5z4Z2D6IZudPugMS34Q0dgD9u/S04c4futwcsqe3fOCVE0pk4M679EYRFi3wTwNtAQzFunrAXMCCj8c63ket7dHDOLKsyNwHLM0A3HEnOvu9EpBhpSIhmXlY6SZm7x92PwDApZOxVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXlV7puzQbBdC3qP1YugRjCV3C/lQLjWlAzpcwcd9F4=;
 b=O2DP9Fwk2Ew8wpEQ5W5D2JFGLQO/t2ReYBcU9sZ48EJGNibDJ/CAfaXVJRPDynz1VWCARmMIkA5VjSu7O9zIMeCUARSSRw+ih+yGJyY7aVGa0qUgV5nO3LlNWIM6DBpfYXKLhgfjn31W9L/n6U8/EFXfssR4h7ox4FLIuPcuAK3fcHHITit+f/7h95LZzApR+OSCTYy2PaC/ixGm8J5y6GKILJtL2mCrZGRhzc2dFsvn0/dN3xF+BIqiDpv8aHQT/kxQN4xsceG+fdrXl5NXwq61mtRk4aJc0gvluaLoD82fkphJCRbSBlO+dLSw+ITCHIGYWh1Xb7OsmK6m39so9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXlV7puzQbBdC3qP1YugRjCV3C/lQLjWlAzpcwcd9F4=;
 b=K0ccQIHhyDQTT2iLeucm83aauT1OjDcvngb2XwVN2Kkx9I4cosxz6rf/+KnKa12WMdTMcj6JtI261XxLjKPRae6CLggo1EVviz3L43/i0N0JkLLFOJFU9avREqWn2fZZlib7RAW18XDIhv4Xwsm48cPKhhZcYE0lVVycsSOVLx0B7XfJSrAeVwAub2VZmuXXWE6QHSHnoUlDzg3yhukpR3iHdLWAzxzn5pUQl7wACh7dDSwyhWz+oU7phUwgegmwfc0AY0Vu6rT06FpAvCG48Ovu7O9HlSCmgNHNLXP26GiXtwkhpNJebbN+iW7Nw9Ng7fITsEjhRFaoSCGdcAkrGg==
Received: from PH7P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::14)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:05:07 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:510:33a:cafe::b1) by PH7P222CA0001.outlook.office365.com
 (2603:10b6:510:33a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 17:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Wed, 7 Jan 2026 17:05:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 09:04:44 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 09:04:43 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 09:04:42 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v15 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Wed, 7 Jan 2026 11:04:20 -0600
Message-ID: <20260107170422.407591-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107170422.407591-1-danielj@nvidia.com>
References: <20260107170422.407591-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: e319c19a-f3c1-4bb0-8463-08de4e0ee82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WI46CAn7ns9eH3srqIQ0OJrmxlG6745SjhGx+aFEIUCqY48/X+T1Odwho8b4?=
 =?us-ascii?Q?f4Wg8yHU3VaevASxUDEZEF3t1nEtUeidEvA0aa4LKXqZTLs17bBRN5yUY/EP?=
 =?us-ascii?Q?a+z2scqEx2dAWH+j93MBUDEAXGQ0ownOv2vr4p9hFqUR5PAQ+Tspvpj4t4uA?=
 =?us-ascii?Q?uJBKjSEdpFFArmtq1W0k1Rg4zV0Ku6vTLleYLBuGw0TJEpGiTPotsC4ZVdRE?=
 =?us-ascii?Q?u8AaICr2P/oYKCNPBlRW63aHqWNNKbb7V85R+sUT8EmxDHW6LJ4BHt0pmgZH?=
 =?us-ascii?Q?btcpgxJVEzLYj+/lKUUrl9pzQdtLBDFBJHRNVjKxetYNsAGLxfVdN+o09TFk?=
 =?us-ascii?Q?O9YCg5oUdimwRrR7hA6flt+Hs88BdX3AaM5CgE62Yny9A0o3TSN84neWECJc?=
 =?us-ascii?Q?AeLa3GQBzqThAwilLQyLRAq0UCH0BMUABlFvy+9Y2QU72FPVb+GNgHHtTP0f?=
 =?us-ascii?Q?JDcGdjI4ONHE40hhVzO/oJZPnXBg6KES/RjTAGcRkRAHhYpVIsXT5qNS1WwL?=
 =?us-ascii?Q?fA0sLT9IdsH8nrJNUBlaQ968BN3ona5M/mSSQv1wqX4ehecNpNjdSA0Zu7gt?=
 =?us-ascii?Q?SOcoB5kRsUjWjL1K3cWsg8RWt7MRyImTkYPrd28v808pL4F7h5ZDI8s4bhnX?=
 =?us-ascii?Q?UkGP8215C2l9DFNME0OoP775y80TDUS3oVKcRhgd/RTF6LLjd3vH5N7LHZZL?=
 =?us-ascii?Q?RDxYVmUj61bpeAeJkfxM741saXWn/PhtyUQ3OXezXT3jWtf7LD6O+UtU8kQq?=
 =?us-ascii?Q?cXrJj+mAb9Ya59KdUFmULLIXp+TvCpWZYOl2oQ/4spLifzhdJTt2mEFOaRsf?=
 =?us-ascii?Q?2ABKzDbe6CJFBvuE5McBmTESdjiywxMYxvjyMeJCEQbAeN8KwHujlwMRCoBf?=
 =?us-ascii?Q?vmzZ+8ixAXQllJnqHUTH0j47iZBWsLwxY3ovWypf9q+bwABeQngGQas859+C?=
 =?us-ascii?Q?lJXT7CJ0UpzqXtnNgi6VwE6xmlySiQiw8dAbd0VrWhhML5UWy03a2RB8oUUL?=
 =?us-ascii?Q?OhZu0tnx77MrjliUhEs990rZNR1TYpjR+u0b6deeMGOXRdSEHr3IuNvkHUzp?=
 =?us-ascii?Q?PF+XBAj74n+Q5iQ9Ri4V+4n8eJu3GX6j+mDuRXIIyRciDVaUo48NvjEyTLRd?=
 =?us-ascii?Q?rcLBbJZiXujzdq9/2ecRTrKf1j7I6wdH/8BvGa9X6hETVAqgn8so1tcOX8VJ?=
 =?us-ascii?Q?8tOW/eKc1P5ro6fr42C2wSsBuqfDzWN8g8aphzfsb80sjBkSL6S9WqlO5MKe?=
 =?us-ascii?Q?vE84Zoj27OhzNE87E/FVo3H9fg60jVd7cdGsqNSlJxkF11jxi06ZxEAoOHam?=
 =?us-ascii?Q?xmfwFt+EWmIr8nmA9UNQSP1ZrfUxlmF9rT+wlzfAPn3TJ/HeoZ/6kZko+0EA?=
 =?us-ascii?Q?P+2jMd4iZAdtHHohSpi+63itR7065ys4fMMwwcgbZgXzfWc+kjiuNqVGobXm?=
 =?us-ascii?Q?SVuZOmzj+PrMWhKL6o+/6zHjPxPjmn8xq3ZjXdN4og4f5zvfbwc5pNkhA70o?=
 =?us-ascii?Q?8MogX1w6hnOKz3sxYw/R6ZweyoRrBviB/xlnkrXZn1wMtXW9MnJys1qZQXFz?=
 =?us-ascii?Q?ytT0iCSuW2eDvE1Fm8U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:05:06.3876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e319c19a-f3c1-4bb0-8463-08de4e0ee82b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585

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

v12:
  - refactor calculate_flow_sizes. MST
  - Move parse_ip6 l3_mask check to TCP/UDP patch. MST
  - Set eth proto to ipv6 as needed. MST
  - Also check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
  - Remove tclass check in setup_ip_key_mask. If it's not suppored it
    will be caught in validate_classifier_selectors.  MST
  - Changed error return in setup_ip_key_mask to -EINVAL

v13:
  - Verify nexthdr unset for ip6. MST
  - Return -EINVAL if tclass is set. It's available in the struct.
---
---
 drivers/net/virtio_net.c | 99 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 93be689e0ecb..6dbbdc1422c5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5937,6 +5937,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
+			       sizeof(cap->nexthdr), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5951,6 +5979,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -5978,11 +6009,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -6119,6 +6172,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -6158,6 +6212,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		++(*num_hdrs);
 		if (has_ipv4(fs->flow_type))
 			size += sizeof(struct iphdr);
+		else if (has_ipv6(fs->flow_type))
+			size += sizeof(struct ipv6hdr);
 	}
 
 	BUG_ON(size > 0xff);
@@ -6185,7 +6241,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 	if (num_hdrs > 1) {
 		eth_m->h_proto = cpu_to_be16(0xffff);
-		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+		if (has_ipv4(fs->flow_type))
+			eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+		else
+			eth_k->h_proto = cpu_to_be16(ETH_P_IPV6);
 	} else {
 		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
 		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
@@ -6196,20 +6255,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
+
+		/* exclude tclass, it's not exposed properly struct ip6hdr */
+		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip6_spec.tclass ||
+		    fs->m_u.usr_ip6_spec.tclass ||
+		    fs->h_u.usr_ip6_spec.l4_proto ||
+		    fs->m_u.usr_ip6_spec.l4_proto)
+			return -EINVAL;
 
-	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
-	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->m_u.usr_ip4_spec.ip_ver ||
-	    fs->m_u.usr_ip4_spec.proto)
-		return -EINVAL;
+		parse_ip6(v6_m, v6_k, fs);
+	} else {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+		selector->length = sizeof(struct iphdr);
+
+		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
+		    fs->m_u.usr_ip4_spec.ip_ver ||
+		    fs->m_u.usr_ip4_spec.proto)
+			return -EINVAL;
 
-	parse_ip4(v4_m, v4_k, fs);
+		parse_ip4(v4_m, v4_k, fs);
+	}
 
 	return 0;
 }
@@ -6279,7 +6356,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
-	if (has_ipv4(fs->flow_type)) {
+	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
 		selector = next_selector(selector);
 
 		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
-- 
2.50.1


