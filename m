Return-Path: <netdev+bounces-228831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB402BD4C2A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A660401BB0
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC4731A54B;
	Mon, 13 Oct 2025 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CpbBOCSH"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A4E31A552
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369315; cv=fail; b=AmkaUntAf/DlSYCQ1JYaYoHIvt+rGu1iQBdNLlTM8x/+QhfwYG1PPjk5d4HD6eRmrD2Jio1VQPY13ms3zn53vzw/7wLYvMoy4puf/X1Y8iVkEsxlElkmnXYDBpHuunlfr5ZRhvbTmV3aj9f2nPgIzxTgf6toRNcknXWdX7G4RpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369315; c=relaxed/simple;
	bh=Co0aswu/bCitlmEvFnhXMM6hwxXRe/HikPhJkKORlMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gK8SOF1xQZE8TKFvOnJtB9JcSE+865vTf8OQT/tkgEEzgAVf/17M/tGQZStri9bN4d0eIJnh96+/E8DhD/WxWYzEbm7FNsgpKxlaB29Myw4tkFWAtDzjv/sRxCnbMYDYgGe1/r4Tw4HGW66VtR0oX4pUnpnoMkHXb+oR+eUaO5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CpbBOCSH; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6/KgSE7EbLzb6TILISWX1c66wCrZfsbNadZZt2mf/vmEOj6YSjDtIZJGgKdkc78KjOZLwJFDBBYgETw/kmdiXH+o9bvA4I0/k/1Ut/cLhEm4mLLd/9N4yJQPCVoxK7zwGmyRQRAdnl7JgOClxmHkLMbHTbepWfHueK0d72wQxOu2qY7p9V6i1EUtZ7LNPaKhHzsfDryVDlyGfpP5jexFjy7FXX5Sqan5xoA6D2UQ5eqtCUdJo8JFbThuN3H8NZawtEgbS+RVtJikGdqnDZgdb7DcW48SLAnz5lJOn/hwCjXgjLbFvzaUf6QTGlSMK81XianZVbj9DHJHKPKjJe2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjRjcBiOoZ/1rAWnMZemJpBppGVzlYipvw2gFu0mwrQ=;
 b=ma3iF5lqKQJ1fNvp6bHuv5VzTn4ayHx5EMiz0nfTRqz00l7F674vvBFAiuCN0Yrw7SizJMqK5GBBE/3H+/PulHiMptXGZsKOWVkrZHKlWLk0yArAAMe+2bPPctjX2MKUURaKvLbYtvApbY8yoEEl7FdybSjvZ0d2aCYdwiG5XPq91nQYFG2lhp9NB9Os4A/ANAr9TSDN6SOJVulmdAlcTQqxrCFBB6/2FlHKWDFD6BpnoekilKeROQmC3G7XIFRAnCLRq3TdwMO/6lQwTe6+Xio6orUNTFc7Cugu2vVqlURygewWsUdOlxtkO/lijhC3HUOA+b78F2DtMEozfgVFAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjRjcBiOoZ/1rAWnMZemJpBppGVzlYipvw2gFu0mwrQ=;
 b=CpbBOCSHNvktoovAvdabXPRcZ5OTQBVpyET7++PAKUTVFAeEkfZD6ivSiOSKAeqqiQcshxbJnGZUYhh7cEpxAY8I7RkhHGfqyqufmTR/zhm6JAy6FC0bgVWNsfagYVbTi7twY76rtUedk8hkfa4NoN3dqS7rmYsGasx29RCCqmoOLK7CVcYglVIGuMj1PY317bNZ3l0+e9e4HWP2Wl+ZsMPqaqW3ilnsc6Z224nsITaCV/EV7LZVt+z2w8ooJLXL9kln/PC/fFEyMBA8egyoJxnhzdQesUFNNiUvi7SBrxIi8mEdkphLMWsq/HQzKRc7Fb3ojpdOQnAp0Ij4y2IyaA==
Received: from DS7PR03CA0075.namprd03.prod.outlook.com (2603:10b6:5:3bb::20)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 15:28:28 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::b2) by DS7PR03CA0075.outlook.office365.com
 (2603:10b6:5:3bb::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 15:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 15:28:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:28:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:28:23 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 08:28:22 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v4 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Mon, 13 Oct 2025 10:27:41 -0500
Message-ID: <20251013152742.619423-12-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013152742.619423-1-danielj@nvidia.com>
References: <20251013152742.619423-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fd5e46-2a4e-4a11-37b7-08de0a6d28ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lu/ulsO7WmuCcSC145aIiNGMqfVkaVPvXWTj0W7l7ampDloK8FzQMRPoZs/P?=
 =?us-ascii?Q?JzJXzwICt7LaGPwkL7uNnsMoC3tNXUZmJek0If2bbc+547NIuSKjLFAPH5bn?=
 =?us-ascii?Q?gVc7Rmq7dO8cboyy7+ZdyLL7fGbKasDLVJkXoFEMo7cu/dQpP6iAWFwQH7T4?=
 =?us-ascii?Q?hG9RGWanqw/tms8W/C8zsnzM9w9hz2EjCymcL1RqDNOf7j7+OEaamyXu0zr3?=
 =?us-ascii?Q?rEhp2AT4Cqk6F0+qVRR6ZhHBRkWA76iGMfgEwXZzl3RPKC4c9WTm/RfEb1yJ?=
 =?us-ascii?Q?T6RBJrkc61BrepVH3S4GfIFiSp/f+VhegyLXVo/dtdsZv1fEhr20/LzNGnrd?=
 =?us-ascii?Q?mxNGwDZB240hGAzMnNeVBjyqoT97twXQ/OwIZE0P2LxDElXOJq+rVjl0Oa6H?=
 =?us-ascii?Q?oGrAsAM/etfz+V8rXKLHYL5T30DCFblo9i9DlqJI0ajkSn1QxVexxom+TZTr?=
 =?us-ascii?Q?GqH+VjgT8kJckvzqsviIdmnlN2MA50QtAVeCHriQe5MnT0dsmwanW9boCMdA?=
 =?us-ascii?Q?bedjlE3RjhZ+1H33GKePc0Gk+nXOY8BHFxOsktv4dT1wRBlTmO7KaxNKzxbc?=
 =?us-ascii?Q?yqSEkMuUPGPx3kXdYpCYRcu7u0UKdvVDZ425Rp7pCODGcPQ3+8UfVU7pCkKK?=
 =?us-ascii?Q?ifjybfAMGbEFlSHNYLEbzQY6KH8mnkPUeJ09IbJZ6OFmI/rqxqzWz0dQ17/b?=
 =?us-ascii?Q?Mp2nw/qHMsMC3tft/484+hJ24bVliHMhW4XTctuQbaBwgU82aI9EqBLZWzvP?=
 =?us-ascii?Q?+seHswlW2O5Xs9x0YLlpkupBbmO3ChOfzj06jiPBTgmEjUs8g8jkaZyjwuNu?=
 =?us-ascii?Q?ddH0gbKTHcM9UYInvf9uG2TfbQvwg6maa2vZ98qg9PKoeuL2u/u+/XRKWsSW?=
 =?us-ascii?Q?VuXYXUXfPT9fmY17W29vbyyaKyByssntHaRk2Jg+Kbl78bPbaXKU+uNY+SBz?=
 =?us-ascii?Q?qD+Sqv8uwHiqIEd878SvDoA8pSC6WAMtx6FM+zwy40qGlB2NhgxwkKqprWte?=
 =?us-ascii?Q?ph0u+De8aFg7iEafMrmDUruFFF1/s5MUbjZavELcYGFTd4aKRvceft+gABcx?=
 =?us-ascii?Q?8wRrSVl09XvjOsf5LkNc/XE1XP8IU53pjgii0B7WhPaLEhXhks4o+3gj16UM?=
 =?us-ascii?Q?wMTwtmoi4bEQeGu6rWGFeJqlUnsaKnL2Q2qUyjpebgvVHbkh2ryHxVycTaYM?=
 =?us-ascii?Q?fqKKJGgssTlaXQbbEyictX0L+nOY+lHM31Xf4Av9X2Sihr4eRjIOH4b8UUUA?=
 =?us-ascii?Q?g1MQ0P6wcahiwGl8dOquRe9wUyxFwuVx0NympmeRv2Ow6dXWi8Kw3eH7mWc6?=
 =?us-ascii?Q?3QiJTJXzsWpeAtlxpWQbTBwz075uFSzNRqRdWlq+LzbOzb7P3v1j83LRP6Gx?=
 =?us-ascii?Q?e6ZUvouim38zPx/1Ec/w7+InYvOm0FZaKyyjsJP5cOQmTH1KIrP5RFZJv9EI?=
 =?us-ascii?Q?bzu1HZIYVOJ3YQpJDVOVawBuw0WPsnGZUo4sIRtK1FnVWKRgay/LOZUpjHO6?=
 =?us-ascii?Q?aGoeA2YJmdvTT1rHSm2Byquj8W3m0K3EVnZR4D/FSzorkTm77cNu4zns4JcQ?=
 =?us-ascii?Q?RKkYHjR4KtiYukJ3Ymo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:28:28.1880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fd5e46-2a4e-4a11-37b7-08de0a6d28ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926

Implement TCP and UDP V4/V6 ethtool flow types.

Examples:
$ ethtool -U ens9 flow-type udp4 dst-ip 192.168.5.2 dst-port\
4321 action 20
Added rule with ID 4

This example directs IPv4 UDP traffic with the specified address and
port to queue 20.

$ ethtool -U ens9 flow-type tcp6 src-ip 2001:db8::1 src-port 1234 dst-ip\
2001:db8::2 dst-port 4321 action 12
Added rule with ID 5

This example directs IPv6 TCP traffic with the specified address and
port to queue 12.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
v4: (*num_hdrs)++ to ++(*num_hdrs)
---
 drivers/net/virtio_net.c | 207 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 198 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 591bdbe77b99..2878a1b9bc62 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6940,6 +6940,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_tcp_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct tcphdr *cap, *mask;
+
+	cap = (struct tcphdr *)&sel_cap->mask;
+	mask = (struct tcphdr *)&sel->mask;
+
+	if (mask->source &&
+	    !check_mask_vs_cap(&mask->source, &cap->source,
+	    sizeof(cap->source), partial_mask))
+		return false;
+
+	if (mask->dest &&
+	    !check_mask_vs_cap(&mask->dest, &cap->dest,
+	    sizeof(cap->dest), partial_mask))
+		return false;
+
+	return true;
+}
+
+static bool validate_udp_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct udphdr *cap, *mask;
+
+	cap = (struct udphdr *)&sel_cap->mask;
+	mask = (struct udphdr *)&sel->mask;
+
+	if (mask->source &&
+	    !check_mask_vs_cap(&mask->source, &cap->source,
+	    sizeof(cap->source), partial_mask))
+		return false;
+
+	if (mask->dest &&
+	    !check_mask_vs_cap(&mask->dest, &cap->dest,
+	    sizeof(cap->dest), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -6957,11 +7003,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
 		return validate_ip6_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_TCP:
+		return validate_tcp_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_UDP:
+		return validate_udp_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void set_tcp(struct tcphdr *mask, struct tcphdr *key,
+		    __be16 psrc_m, __be16 psrc_k,
+		    __be16 pdst_m, __be16 pdst_k)
+{
+	if (psrc_m) {
+		mask->source = psrc_m;
+		key->source = psrc_k;
+	}
+	if (pdst_m) {
+		mask->dest = pdst_m;
+		key->dest = pdst_k;
+	}
+}
+
+static void set_udp(struct udphdr *mask, struct udphdr *key,
+		    __be16 psrc_m, __be16 psrc_k,
+		    __be16 pdst_m, __be16 pdst_k)
+{
+	if (psrc_m) {
+		mask->source = psrc_m;
+		key->source = psrc_k;
+	}
+	if (pdst_m) {
+		mask->dest = pdst_m;
+		key->dest = pdst_k;
+	}
+}
+
 static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 		      const struct ethtool_rx_flow_spec *fs)
 {
@@ -7003,12 +7083,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
 
 static bool has_ipv4(u32 flow_type)
 {
-	return flow_type == IP_USER_FLOW;
+	return flow_type == TCP_V4_FLOW ||
+	       flow_type == UDP_V4_FLOW ||
+	       flow_type == IP_USER_FLOW;
 }
 
 static bool has_ipv6(u32 flow_type)
 {
-	return flow_type == IPV6_USER_FLOW;
+	return flow_type == TCP_V6_FLOW ||
+	       flow_type == UDP_V6_FLOW ||
+	       flow_type == IPV6_USER_FLOW;
+}
+
+static bool has_tcp(u32 flow_type)
+{
+	return flow_type == TCP_V4_FLOW || flow_type == TCP_V6_FLOW;
+}
+
+static bool has_udp(u32 flow_type)
+{
+	return flow_type == UDP_V4_FLOW || flow_type == UDP_V6_FLOW;
 }
 
 static int setup_classifier(struct virtnet_ff *ff,
@@ -7147,6 +7241,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -7191,6 +7289,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		size += sizeof(struct iphdr);
 	else if (has_ipv6(fs->flow_type))
 		size += sizeof(struct ipv6hdr);
+
+	if (has_tcp(fs->flow_type) || has_udp(fs->flow_type)) {
+		++(*num_hdrs);
+		size += has_tcp(fs->flow_type) ? sizeof(struct tcphdr) :
+						 sizeof(struct udphdr);
+	}
 done:
 	*key_size = size;
 	/*
@@ -7225,7 +7329,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -7236,21 +7341,93 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
 		selector->length = sizeof(struct ipv6hdr);
 
-		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip6_spec.tclass)
+		if (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+				      fs->h_u.usr_ip6_spec.tclass))
 			return -EOPNOTSUPP;
 
 		parse_ip6(v6_m, v6_k, fs);
+
+		if (num_hdrs > 2) {
+			v6_m->nexthdr = 0xff;
+			if (has_tcp(fs->flow_type))
+				v6_k->nexthdr = IPPROTO_TCP;
+			else
+				v6_k->nexthdr = IPPROTO_UDP;
+		}
 	} else {
 		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
 		selector->length = sizeof(struct iphdr);
 
-		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip4_spec.tos ||
-		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
+		if (num_hdrs == 2 &&
+		    (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		     fs->h_u.usr_ip4_spec.tos ||
+		     fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4))
 			return -EOPNOTSUPP;
 
 		parse_ip4(v4_m, v4_k, fs);
+
+		if (num_hdrs > 2) {
+			v4_m->protocol = 0xff;
+			if (has_tcp(fs->flow_type))
+				v4_k->protocol = IPPROTO_TCP;
+			else
+				v4_k->protocol = IPPROTO_UDP;
+		}
+	}
+
+	return 0;
+}
+
+static int setup_transport_key_mask(struct virtio_net_ff_selector *selector,
+				    u8 *key,
+				    struct ethtool_rx_flow_spec *fs)
+{
+	struct tcphdr *tcp_m = (struct tcphdr *)&selector->mask;
+	struct udphdr *udp_m = (struct udphdr *)&selector->mask;
+	const struct ethtool_tcpip6_spec *v6_l4_mask;
+	const struct ethtool_tcpip4_spec *v4_l4_mask;
+	const struct ethtool_tcpip6_spec *v6_l4_key;
+	const struct ethtool_tcpip4_spec *v4_l4_key;
+	struct tcphdr *tcp_k = (struct tcphdr *)key;
+	struct udphdr *udp_k = (struct udphdr *)key;
+
+	if (has_tcp(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_TCP;
+		selector->length = sizeof(struct tcphdr);
+
+		if (has_ipv6(fs->flow_type)) {
+			v6_l4_mask = &fs->m_u.tcp_ip6_spec;
+			v6_l4_key = &fs->h_u.tcp_ip6_spec;
+
+			set_tcp(tcp_m, tcp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
+				v6_l4_mask->pdst, v6_l4_key->pdst);
+		} else {
+			v4_l4_mask = &fs->m_u.tcp_ip4_spec;
+			v4_l4_key = &fs->h_u.tcp_ip4_spec;
+
+			set_tcp(tcp_m, tcp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
+				v4_l4_mask->pdst, v4_l4_key->pdst);
+		}
+
+	} else if (has_udp(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_UDP;
+		selector->length = sizeof(struct udphdr);
+
+		if (has_ipv6(fs->flow_type)) {
+			v6_l4_mask = &fs->m_u.udp_ip6_spec;
+			v6_l4_key = &fs->h_u.udp_ip6_spec;
+
+			set_udp(udp_m, udp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
+				v6_l4_mask->pdst, v6_l4_key->pdst);
+		} else {
+			v4_l4_mask = &fs->m_u.udp_ip4_spec;
+			v4_l4_key = &fs->h_u.udp_ip4_spec;
+
+			set_udp(udp_m, udp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
+				v4_l4_mask->pdst, v4_l4_key->pdst);
+		}
+	} else {
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -7290,6 +7467,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	size_t key_size;
 	int num_hdrs;
 	u8 *key;
@@ -7323,9 +7501,20 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (num_hdrs == 1)
 		goto validate;
 
+	key_offset = selector->length;
+	selector = next_selector(selector);
+
+	err = setup_ip_key_mask(selector, key + key_offset, fs, num_hdrs);
+	if (err)
+		goto err_classifier;
+
+	if (num_hdrs == 2)
+		goto validate;
+
+	key_offset += selector->length;
 	selector = next_selector(selector);
 
-	err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+	err = setup_transport_key_mask(selector, key + key_offset, fs);
 	if (err)
 		goto err_classifier;
 
-- 
2.50.1


