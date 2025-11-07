Return-Path: <netdev+bounces-236624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BB1C3E6E7
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 05:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED0D3ADF70
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 04:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68652236FA;
	Fri,  7 Nov 2025 04:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kxNXdfTv"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF58F2C325F
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 04:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762489008; cv=fail; b=Cdy6pg4lnk0VWZJCWScFvjtZmsuK7ZuC/M2ZYgYJqfOgYbY1UHwfG24UNrEnyGW0FjmiKF3V3ntl06xN4R90SheQO08RHMhA+sFPYtyU0MDS4kzlj0iq+RIWux71pReP4RFa/sHXZHE90TYIC+rIOiXbf2Ze0z6mIQtW1kqZ/K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762489008; c=relaxed/simple;
	bh=pL60R2QqXCRDMAriwq/7t/BvUdrhaMOx5WWyzW9UqOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZ+PzheclUF+qSDu7GrmJMA0j7BKQKdgUMjRZD/1M5g3w70OV4AnLvVuyGVDw0J+KpvrHEBgMLsomk9zVnAaZfMblBjPASGQziu6bSTzas3OEMbP+bzQe/Mhs97dczb6HDh88zud+bwln0KGL3TqM3ik1mFJsSmKN1sZd95eE7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kxNXdfTv; arc=fail smtp.client-ip=52.101.85.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S87AK6DzCuF2hCd6C8XRQAJ8WRBwaX9axWZ0QxBNVr5zE77yJ6APHXnogydnKnrLOY7WOPf2X1WoRPsxgqdBw2dVfkVWNZ7tsZD9L5me4Da/PFjrPhiMKZe7yhxVs9qBFzonvffmW0KawfS1HhgwIihmCq/CTP7hS6qQ3Nlpt+UjtNBiE1NVKGMqhgeQIZhOKWGvSkEwjKhXZs9b8pmOnPCr2r8dZk9AVCpJbbf1PGE6V5gW80bQnw8F4P9+eiANc/pZNyYtsvCK76Xs4ithISf/GH+W53z7bSdJMJSJ0+ADqQgZdRV6jtEpPVbQwh4LZdkkAJee8bDTxto9tBpgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqQPMqFMcU1hRBEQRKmhCtAUb8CqNnRL5ecoaE/WEIs=;
 b=E9hdp842DXE3QZv2HOi8gZhWZctbLbK9qWrPRgdAPbbZiUM6tZZOtaaxCSMWlLgEglqV3fuDpPToM8MuByerG0av/4n6/I1TuFwCY6iqh+Dkfir1SFeArItWMYK30RuNuUTm+2+IFa4uh5s3OBZHqVkNLFV/PniI05mBFSfUIGkOqAGPePJsH/mfWcYuM2HtwgbXAj3EQrjh0kbf+/pcaHOTYHhthBR/qzhT1y9EfpJ0gFrWW5wDTQX3FkyjY7SRgjSOgOm8/19PD/P8E1/v63OziMWKaOCP8ykQ3xyRh1h0YFcgDbkoWVTMvOMkr3Op4J4N+3Gc8jGSF3n3BNZNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqQPMqFMcU1hRBEQRKmhCtAUb8CqNnRL5ecoaE/WEIs=;
 b=kxNXdfTvnBsGNE2fjoac3vVJzLI6qsLyaUis3rW+6oKk/IRXKOt45U9xDDqGbOxpnxDHSTs8gysyCIjBP2fUtqnqrfm0FrFlXm8MRSZWPFLXP2xM2wLSm6S9fhrrq3FKg4nEezuAjHbOZDh0HPwxM6KlPD4jpAvvt+TlgNa9kkZOQ94oxSVwohpEFuZcpk+7PoUzo/7GKbw8L+zh4RwO19XZrjQ2E3z59VZGU7GpZAVmQ5IfiXQZDi+hKky/HL3+BymAHxUEEInRTXq6fwE15CRmXDXxx93UJumMMH5EtSZ0pTnL2NoEs0rXorUsw4cqr75i8nvonfCjlpP/V23+mg==
Received: from DS7PR03CA0017.namprd03.prod.outlook.com (2603:10b6:5:3b8::22)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 04:16:43 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::91) by DS7PR03CA0017.outlook.office365.com
 (2603:10b6:5:3b8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 04:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 04:16:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:31 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:31 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 20:16:29 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v9 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Thu, 6 Nov 2025 22:15:20 -0600
Message-ID: <20251107041523.1928-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107041523.1928-1-danielj@nvidia.com>
References: <20251107041523.1928-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 7effdd33-a123-4a38-d7b9-08de1db47542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3S/qg3nqBRnQjZ8yRWIB4zTzhZnn25RN6cN3k+4SjGzdr3WGghEZOtflrKO7?=
 =?us-ascii?Q?YcVz5DGg3F5anhk4mzZOw6qR7NwsVpktlaw6rnKBhYi8zMC4llsl+cZqF1qK?=
 =?us-ascii?Q?LmraCpJ13tpEW7+KkuU0FqZA3JclyLkiU5nQtdal/ikyg+kBf+WuqMMNm1HH?=
 =?us-ascii?Q?P66GMnM7I3w+n02kmqT4VU6KbkNAtGxnYUmySN4hDdbOE78Pq4uhpo9DX9qe?=
 =?us-ascii?Q?6PBuUdTjtZZeR5EdisBW7kwehARNRC1W4TkgN8XYVUAGbxhijVPF627qEX2d?=
 =?us-ascii?Q?Sq9RA5O6THuxh+o3KnRSgO9rtZVKKAaaS8SdW9jCw9CNZGIF0feRQfkcMyrB?=
 =?us-ascii?Q?dvXBBGz2hp/hNdKr/nSFjfvmL6gTh/cpQbOktiF+iIi6ReE4v4uKN6Z0VY03?=
 =?us-ascii?Q?amm/CAGALRVf0EirdPdfMn46aWXY09EIE1zZgS6uEf6B4Pq3/tkjldfSA3ed?=
 =?us-ascii?Q?dhWNv2Wbj1S/JHJVSH1QWmcFmjQSOfe/1bM7yR7BHZGcs0gl6uF0hwBw+M8n?=
 =?us-ascii?Q?UXXAyz7G70HZfyZcMl4QoJBq9QPXsrsdJVciz+fxE6jDKYp18b9VRG/hphhR?=
 =?us-ascii?Q?sWlX31vkckWwJ6suRkuq9Yznp4vYH2ocEBRtsH0QgBJLkM9t2KvBWpJfLxeB?=
 =?us-ascii?Q?GPXAzIFG171hdqzrzQiNA4td8a3VSRqS4QWn0UnPCVJ9xZ2V2xz18S6ajOxr?=
 =?us-ascii?Q?bBGOVy/uIY7wfY/Wp2L4x2wb8ImSRyhrEr4tX6d4SKfvBeP4XRV2+m2xfN58?=
 =?us-ascii?Q?DdUq5vmiRM3/Lm45cTZ1Zl1P8+IDo4Z2hCXRiFE8RB3JN0xSi0m9jXawOx6L?=
 =?us-ascii?Q?L9LWeK3hKrWx+P5bSwNaSVIywUb8bgvfByubRBLbJced0AKHBdVocIjiz+kB?=
 =?us-ascii?Q?r510oWoYVFjEodf8Cww7Q+L0rvghqSufKP8n7ar9Wxqu8iyY4YXSuSJi/se3?=
 =?us-ascii?Q?Jq4+ivabldi3Ps7HQk/MF2KPMZM1EFHxKQq938uGzPGPHxfgxp6mvAYLKqho?=
 =?us-ascii?Q?exNPxR3Y3VFEs5p5LOGDPZ09KM+NL3acxWo2hdhrcEbGCsPVLUb0EPrQ6vmv?=
 =?us-ascii?Q?N3A47GZZgUT9xJcV31LrnLDVOKNeekGO+shcmQSJ/RbDkn3fnMdV/u6GR5Mn?=
 =?us-ascii?Q?4FS01JynIJeGLfY6JVMCbm5qhSqbJCJdnyd+XALzX+1kuS9yNWYcs45wCbvg?=
 =?us-ascii?Q?KiaZlfc0Z4pGmxWRn7grEmK/ZhRDAuoBUuHeDDPZr8Lbyg2w+XsK6ls/3krz?=
 =?us-ascii?Q?5TvLdEBfEnguWPcZ+AVIXA6dl6Tm7J2ihwpXeNJWkalQCIpPpMqko/qEYx5B?=
 =?us-ascii?Q?c6q3ChsY94D8e0+jt5NiLNE9wg9rmUdfMe7MbL5rrK9ok4vQrFOuJk/WnB1v?=
 =?us-ascii?Q?lZt0wNFvplzrJfHq1eSJVKcXuyufYD9jTQMNbzlbt+d4gwlNzeWiVxQ+eXC0?=
 =?us-ascii?Q?eLV3Q0nPMPsG5LgrILH/EWcgATV5QDeL2Dp5GlRmuoW3KMeWXDClqJbbaPT5?=
 =?us-ascii?Q?9zi7ky1ztiqbS9FyIh8mQapvife8cR3ajjJxoI8qsALWfL1gdyRyfCfQO9yT?=
 =?us-ascii?Q?LiSKC5gfC9m0MMQw2uE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:16:43.0374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7effdd33-a123-4a38-d7b9-08de1db47542
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585

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
index 14bacefba899..f0dba1ccb6b4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6916,6 +6916,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -6930,6 +6958,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -6952,11 +6983,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -7092,6 +7150,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -7134,7 +7193,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 	++(*num_hdrs);
 	if (has_ipv4(fs->flow_type))
 		size += sizeof(struct iphdr);
-
+	else if (has_ipv6(fs->flow_type))
+		size += sizeof(struct ipv6hdr);
 done:
 	*key_size = size;
 	/*
@@ -7171,18 +7231,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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


