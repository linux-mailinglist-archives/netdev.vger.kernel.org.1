Return-Path: <netdev+bounces-229873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C25BBBE17A1
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA8E403A2D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72907223DE8;
	Thu, 16 Oct 2025 05:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bYIq1acP"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9668A22B8B0
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590908; cv=fail; b=KDSBjNgek6RZLA+ZGzKkNYvJeIDHTjHa0JIpxWvWkY+HwMaktmf7cPdheP4EQfkTm2Nno/0PN2lDBK25zxgKegamrcQZR0gbRHXJg0407C1M8Nt0Ktc+pFrMnZN5q36M6AKGl3rpLhO+ax9wa1L133jtd2s0i4Kd5zLMJhcSvJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590908; c=relaxed/simple;
	bh=w8QrP5zNs1U63Wcyxgh27zwVK+MWOcu7Zck8qZlgrwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msn4i92qZN2cORhhfap//ktx6H9mx7KQGhEMJy5JitSzfoboJ2O9yR+OcjxBLdHewHB5QNfhsFWCEfRKkGfZBsjd/6MJ9LGbEGly+qJvgtkG+Hh1eLKe5GsNZa49CLHQm7F/BRoWUEWq0BFfEEGxuWXE2+ZpfU40o6ejoo9tCnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bYIq1acP; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lp5uXKhC0gdbpi2Gu8bLCnNd1pUtMH6MnXcgd1VxcnyAKRGa0Cz37nReH6E92gb5kRRwTRoCCfhzx0IjYjtQaY/qMRWGMTyGmLiHgEFUGZyHq+I/BL6MjIgmNWSFm/J866bNFEhMe/v09wen+HsVgGraMDSxWxIsOwiYSPCR1ARsT+ahTMQ6+NB2d+TNwJDGtX/YMDl8mKFDNG3d4QkF1KiKrkmKPunLGjOFZsKKk3GaN8JSEpY1uQNFuV+fv0AedI2dpigDi4YNMS3deh0oRkZgpvYKqPQDwY2OBZsUazkINrmt5rhQ35e8x29ijsKX2mv2w8nnk/FtkE+ABY+KvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suOnQkTYQ1XwFngw2TD4p3E39P4gsa2r3a/30sqGsQk=;
 b=oMxRy9rKITLcfcJwRV0MIG58zIc/u6oVfCrGj6PgqO5+D9SbcaCe6eVvu0pQ4FkrPIRRI6RgPy5YTJcw5x492RGLwPnEulendw7jASH69c98GR/f456i4556s6MsX6+cCcGFMSgJh+nizMPRgOBNf3Mzqfg0REKcCvLupSCUuhyBfwatSjH+DOihK+ln2haYK8YOu00oY3Op68mYyEqTVxOQTBFvOp1+zXyztZfz9HXBSyqcpElUbC/J2+NeejpwrIq8qXCdJNTLDOsU6YX/b9H628qSqdbdRjGuZympljuq9leKPalL41HzlA5mM92UXWNCJgCDstXrgLMH8c48JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suOnQkTYQ1XwFngw2TD4p3E39P4gsa2r3a/30sqGsQk=;
 b=bYIq1acPmM3rUTDG8kMhuFCTzxGcLKE9SWuX4tDCoE1H60MbwXF5+JCBLy0dy5m0Zw4q0PBoya0t8HSH1rpm8Tmezkf/G2PZ9YoVwYShRqtd8sTNL06QR/z7mFcLfOSMGjJSc5F1+GAPmwzsU/z9Z8CqqxcQzYQh/vdabRTD6mFNf5rSxSD7xOPXqCr61ZHlM1xCy2yRm4Q4OH+2Jp2JLFWBdEqXZJXMusnN2yLftbPB+srwpuE9rVTdRhtCW/pdQDMZO+VvbwYPNRRpAl4wLN7QQ2fFyV6e/r16FK3RwmnKUyEtcMtW6qg0SmILsPWehHkAMOQp54o3lP0VWNcSpw==
Received: from BN9P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::12)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 05:01:42 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::5d) by BN9P221CA0004.outlook.office365.com
 (2603:10b6:408:10a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 05:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 05:01:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 22:01:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 22:01:22 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 22:01:21 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v5 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Thu, 16 Oct 2025 00:00:53 -0500
Message-ID: <20251016050055.2301-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016050055.2301-1-danielj@nvidia.com>
References: <20251016050055.2301-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f23a255-4f10-4714-4af0-08de0c71193c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZZd1ZaDgBny91RLL1/mL4KJq8un8HM9689Pg1tgc6vl1I5B9oS9qsETv2IrB?=
 =?us-ascii?Q?5ThcP2tip/rHJ5J12v9zQesB6FoieW7SQlj3NcAOtiQLxVEHmUPPODKhqAg9?=
 =?us-ascii?Q?vPuHbYHDtndbS/Y1fFDfikl2R2KcSJZjyO3J01ORBLDS8OeNLBPoziU6luZQ?=
 =?us-ascii?Q?72I5dMS0r0xbkYfczgCZlTJISU8pihhZoA19ZnNzY2ekXzoBYyger615sEDb?=
 =?us-ascii?Q?kaCYndVkHLPxUC3grAMlnDOaDX6bFQHv2MkYHJnlWMj7Qh0gh5vOY4S1AvHj?=
 =?us-ascii?Q?78k0AVVvmxzYvAUQtL9lablr0g/8tGUhwLDnyd6Pvp0u7WYoHBLMDBhqREHm?=
 =?us-ascii?Q?lO3GPH1k0NlZiljjYBvz56hN2+jgjIo2VkLH/sY4+MKDVBHzp9+MZzcHK7D8?=
 =?us-ascii?Q?vHBMnM9dgak37Uc35kldyedvTfvSmtbNrTLXXIUevJ2NJ4NfEZZ+74raBhUs?=
 =?us-ascii?Q?S9N3kHMVCNWb1NS2tbbSrY41L/lQ3b1aGmcEakbknGZPpsY4eYZQpOOcAV38?=
 =?us-ascii?Q?+RsHkXlTJ9I0Wc6vEqdkj5p69jnGouPE+85s2oK04O6ddx9yUdJN+bgTp6E5?=
 =?us-ascii?Q?plGAlgmp7WGhLFUZojNsubBjttXIwg5HKuaHPeG1/08JWujEldMngpKsGWUP?=
 =?us-ascii?Q?MFtjBqYEerYaU31jnsk3rzqo5+zyIMox5c4lRDjCxcPfbHBDYPTIlF8EZxu/?=
 =?us-ascii?Q?3OTHXZhF0jgpyl6OZ5rxEb+rAiGwYuOwpYLhTEAFGcgyBmhEt5VT8TrFzbPz?=
 =?us-ascii?Q?Zw2BlHpcX8wZ1A77N6qdeQsYVv6/tLSRaQS6H2GWfTvdgcBTmpuuXhJsRz1s?=
 =?us-ascii?Q?emWUv9dvFXxZ0BRPFVzy5XHq/vuJACd1lSKFCIeHMwhjP49EZ1M/4+HTvP1j?=
 =?us-ascii?Q?Kqw9ZHVveEugDQeSgSIshnwi6ph44Rl+cOLJ6tZ3o0BEqZiFKJhssKd3QLdd?=
 =?us-ascii?Q?PX6kpBH0curkjQZn2aZLla+MO/I950Yw6ww2lll+bXFjOtcO9/nsxPb9nMQ+?=
 =?us-ascii?Q?I2Yw01DqGb4yuLw142jyx89vsYnGKjBdRwza6NdixgzhybFuolqVLjkdcDDp?=
 =?us-ascii?Q?r0l4/XGOq/VVJgC+nEGd8/iLmHdDlsVASpHu/k94JeU9faUYA8EuLbKkOkPP?=
 =?us-ascii?Q?TqmkkZPJ8xLg3UDM1L1lt4kXueUVykCsHTjxUgB0H2hi9Ayf4hyRSiOKeITT?=
 =?us-ascii?Q?UniEcY7PjEnj9/nMhDzPKc8f5MWkorCkjH8u9jd4Ggvjeb8XLkn7E2fRuJMI?=
 =?us-ascii?Q?qXZaa2he6toxhXIJxCx7AfC3jY7OAnjJvB/wWUGHYljgJp+IgTXcGJAaK5oG?=
 =?us-ascii?Q?n6lXSy7yixNdmlVD7dIXsUUQCjpSYUl/90zWewUdLJGYXUdKrUwH1bzC4VtK?=
 =?us-ascii?Q?zHuhmRqaF6/f4CjmNa/EbA1R/dgZSirZ1ckW7cbdbmmeuHeEiCJta3S+AUKG?=
 =?us-ascii?Q?jTs4uNKi6xuI0FJ5IZ6HyhRX7oc3bv+ss5o+Kr4/fCvzjHwrypM5anpecoX5?=
 =?us-ascii?Q?5dD1WNZpN6QHFQVog6CVzcdrngDIPfhPtd2zybadU6Y2CEnwbS8iyE/kRZOh?=
 =?us-ascii?Q?ULBG51McEl6A8rJs+i8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:01:42.5575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f23a255-4f10-4714-4af0-08de0c71193c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883

Implement support for IPV6_USER_FLOW type rules.

Example:
$ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
Added rule with ID 0

The example rule will forward packets with the specified source and
destination IP addresses to RX ring 3.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
v4: commit message typo
---
 drivers/net/virtio_net.c | 89 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a67060405421..f13141e9f2de 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6912,6 +6912,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -6926,6 +6954,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -6948,11 +6979,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -7088,6 +7146,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -7130,7 +7189,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 	++(*num_hdrs);
 	if (has_ipv4(fs->flow_type))
 		size += sizeof(struct iphdr);
-
+	else if (has_ipv6(fs->flow_type))
+		size += sizeof(struct ipv6hdr);
 done:
 	*key_size = size;
 	/*
@@ -7167,18 +7227,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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


