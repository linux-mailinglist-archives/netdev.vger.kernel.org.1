Return-Path: <netdev+bounces-220889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B7AB495E8
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850704C4226
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6920F3128DA;
	Mon,  8 Sep 2025 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nk4NqAV2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB13128C0
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349801; cv=fail; b=bQ15RgljE+ibAApMdWPOFiyUAwF2mi4LEu3z7xqKG0AVaOaiQm3f9KFQsq80jWnmSPIq/UhqxVEhf50P3sQgbLRaOIgYbg41a2Nu/mEoVY3eyrnI/M2YjP2GmqGHRfjU5PrBEAXdw1YNM4V2pkV4LggZYFQo2u6LBxYbrviUO9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349801; c=relaxed/simple;
	bh=HUj5Acese5YMH3+fAE2BzcsCp7d5axzjv8LYzbs+ioM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aO8g3RT6rPC+p7WlfkHlwZFkCCGSP0iQsNiDZAaCnlhYviI67NLHJKojVz1VLY+4PYikQg1OPOIThhtGygn13oYRzL7mC16X2sTw7G1NF+Neirw1LzwKVIsHbmCJSWlnrIMYeN3YKX3O4MQ6YXNAFFgJhL2BNuHhEPFtDHCJ25s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nk4NqAV2; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g49PDz2XIq/CCp+FC7iYtVV3d4fOPVcR+CAHiUnXB0UyfFq6ieuE8oh9KBP62H2LGpcNQnjESqU+lD9g+PcL9UJcbyi0s6GzgvgItwltfj3U847gL8MhWMOy7Jh57bj/Ji3lbLxq8vh0SMgaxqsnJ5dvG85YxzZnSRS4azQqmjxia8hE4Uno8M+iZjKfe/nyQnJ1kGmEBM90kIfwPWD/aAZZbfwqj5kVoFsDaasig4Zr8QRR4dI9iGipnACnLdWEKMvhh99E2tgL/15lOdNgMjkM/JtBfe1qPnAuJtArE/5rUavylr2bUuQ+Y5yj+0dmU7dn5tDYcflt+WQPoZ2bAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ffg8iL0rMCKREfjsG/wRwKm/xpn8ZQPy7giR5dkjMOs=;
 b=OGx+E0dPC3TD7YVR/eiTVBi5CIw9sGhUc6h9q3Za2g3sMBKLgq/iOSFZsBmFyUs1ddi7v+ToCO8VXmyTEbUicmPOEirXuADq9X0vRqxEgoVW3pkBgZR7CUYVr4ZtOMPd+XJ/CYKWWIJh6/HmEVk5/fDScLtaqU0AzP3qJ5OsFAEDVIu842Zv+swBTF/K0W6hkhb6UH8i6E1Zx7birm1QTbzgCX/NdE3h1oSEAVOgWK8PskBFMNLA8a5t4yALdMEhcNyFdZTug7ToFteRsnoKFrZ13aCtmzHjucGJl2+jGtJAdfaLZyviwOj2vRkRw3PRFulz4tXrqq5uVbkXneBM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ffg8iL0rMCKREfjsG/wRwKm/xpn8ZQPy7giR5dkjMOs=;
 b=nk4NqAV23P+YRagXzy20u0exa3CP3v/wVidXNrRR2tfADBj/tJPad+WneEaMs0urg7Ao9hRLIeJVW7vhC/7rgPnsh7a4W24wFKx5iV8MFuqDOZhxXYh+AICFlmxdysG3IG7Ncsk+8RblX72a68MRO82SN5dpmjyMjDz114zh0+HfNFM0apJEJlzcB/6aqDbgj6/YORhf03hF0iju0tPIycTseQIMZRJf1jpJehcxmRUG38U4Jqw7MSrh2JsGC1T+S5zQG/XUKvYGU2atT2SfwleTqo1BOR5nH02QkdePhErNjSUv0+iQqD8j2jNBZDrjmViDrPp7lYiLuk3PvHxg5A==
Received: from BYAPR02CA0044.namprd02.prod.outlook.com (2603:10b6:a03:54::21)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:43:14 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::73) by BYAPR02CA0044.outlook.office365.com
 (2603:10b6:a03:54::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:43:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:42:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 8 Sep 2025 09:42:44 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 09:42:43 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v2 09/11] virtio_net: Add support for IPv6 ethtool steering
Date: Mon, 8 Sep 2025 11:40:44 -0500
Message-ID: <20250908164046.25051-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908164046.25051-1-danielj@nvidia.com>
References: <20250908164046.25051-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f093d92-d9d3-49c1-c48f-08ddeef6cdc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lyRhHQNAG2TTvnd6hm75/cGI5M6hZBnEZHvBEqP0VjwshgQWYzqZnqACnpZC?=
 =?us-ascii?Q?IZV68KYpJJeKZb+wSl3WNbzzfJx71dAcsU7XbGT1wa2nbTsER/VnjO/fT2Mc?=
 =?us-ascii?Q?+bsbUP6zkvwe0sKZgOPOIR6pxkCpo9cjDiAYsJbGmiICCQM7/JIUayb4aReC?=
 =?us-ascii?Q?MHx6Ba0t8lhtADN2+ckU0s2r0VWL8c6egdrcdTSsi9wwMAvJnafy0g3Dy5fR?=
 =?us-ascii?Q?D3zg70UMektMzeP0eHHAae9516Qs0wK6OZqb6G6W+MoUqQMjIiyAh6qPxqR0?=
 =?us-ascii?Q?7V7i5W+22SsJTPFtN4MzxLhU5K3BF/605WSCvFDmxezIsiZ0eFTUsp+St5xy?=
 =?us-ascii?Q?ftl9EJr/1B5HWyR81Hj2KYzIkx45+rxQkggYQw9+94SebI8i9v8LJW40/mB0?=
 =?us-ascii?Q?tLhqffuqSksnqgGq5wtjb1TkMePiCnGwF9W5bVJHs5sYQFTAIeFEh+jGsNM4?=
 =?us-ascii?Q?OaYZt9UTFjVbkVjFNVdifcRjrYH5O0OJg+Pz6ivJYMp/Rp0wihtcsyzuqXKR?=
 =?us-ascii?Q?hcxDABss//rxbMy1aak2vt6vXV88wLPwtVOPqrAAi31Pr6Xe443hNfkM9xM1?=
 =?us-ascii?Q?IqRPSflKUZeFV9GduuMQ7n8PPoD+uwpZ0dhJlk8kYggEXgu9N4m4Wf1iwVr5?=
 =?us-ascii?Q?bzd9xKy+GCuEfKIFJ7pLRA5MY4WFTE+uI6wl4hLrs45NjAtOUNoLS0B8PZIC?=
 =?us-ascii?Q?pABrSqsLArremUTypeebMAbZOsbemW7lkD021EUP6hDJU9s9tZGjvN5tE2c+?=
 =?us-ascii?Q?mF292FYJrjY38zMuF8FCorxPc0VABun9QC61mLPLo3g0tZT3PmIvbe4B6i9M?=
 =?us-ascii?Q?STJAMuuW8czn9Ra5itisgtq1/vZHJ81aoCXzS5GjnKHydGnIgBNZGGW5aZ6f?=
 =?us-ascii?Q?9EKKLghjCOXJBtxs4A76vwKeQS3cUWzbnpsR2Xp8ZvBQczs5i8tvCwAUN2+t?=
 =?us-ascii?Q?f20nurJCdSZ7KtzB7kl9V3e8HhLSvCCuxYU21dv4fRG21KNVhPDDhu6rDRNU?=
 =?us-ascii?Q?Vxsx98XiWs8YvtKJrIUVAOT8uhzXgvQARS3k64gGDnD1/jTEfaWUCteJrG3e?=
 =?us-ascii?Q?mPmHIcxTHxLePeFJnLLmgD30hRmySl684NnvU+Cong/Y+8czVwIXTVj+HSz9?=
 =?us-ascii?Q?xkbIDA118ARzCf1hk/1EUIMRbIRqCODyQcdKG10H1r1ojg8ZAt1Pactfns86?=
 =?us-ascii?Q?42H+Uqs9vjTpepiyuMOlOdcuDpAu+TWuKr7TghCBAB9Aiv7FTPwRYNMed1A2?=
 =?us-ascii?Q?lgieR0FpwqrwC7uvfdoIZBVAqGsnGf3PHSiwZZgv/kL7F9x+MLHtr/Kg/TNt?=
 =?us-ascii?Q?Jtw9cLQzw614kcK8KJqlx1Jt8Uu7H2c/G71bhE9UX37zGSbLlsAvWKKKh1hU?=
 =?us-ascii?Q?YBviabXhkKRAwp0ERRO9GUxg5PwjFQj5QDRJWY3VnFkqDf0eNcFpNbNWIO6R?=
 =?us-ascii?Q?bDTEis2kMFVhsTtHERfj43YV5DDfrKBldpjq+oStvmAedmbz6j2+pPHbBaVX?=
 =?us-ascii?Q?5SugzCNspZwQDxNL3ipSsTJTT8bEK1cGCnEn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:43:13.6938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f093d92-d9d3-49c1-c48f-08ddeef6cdc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080

Implement support for IPV6_USER_FLOW type rules.

Example:
$ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
Added rule with ID 0

The example rule will forward packets with the specified soure and
destination IP addresses to RX ring 3.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net/virtio_net_ff.c | 89 +++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index 0374676d1342..ce59fb36dae9 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -118,6 +118,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -132,6 +160,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -154,11 +185,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -291,6 +349,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -332,7 +391,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 	(*num_hdrs)++;
 	if (has_ipv4(fs->flow_type))
 		size += sizeof(struct iphdr);
-
+	else if (has_ipv6(fs->flow_type))
+		size += sizeof(struct ipv6hdr);
 done:
 	*key_size = size;
 	/*
@@ -369,18 +429,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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


