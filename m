Return-Path: <netdev+bounces-242006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB500C8BA85
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E70C3BC560
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F51D349AF2;
	Wed, 26 Nov 2025 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bmqypvls"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E9346FD7
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185794; cv=fail; b=dO42rEXmgPRpdEm6TOxX+SGpfqdz1N+RnzIecoDhDwo6KV4krNk1ux+xs24CdwcNk90J6KSozkg0P57fef4TdGsDrPVVeigwmKqMq4N8dem9b2fB5J3d8sFPTj1pGPQqjshbAnUujMvPSPdKfHDwfRxb1hhh9lb+5x/6D2q6ntI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185794; c=relaxed/simple;
	bh=obQM9cVjgL2jBNkFHLlKth9antytr02yzNDgGyfSpuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1h33j60cIXuPxmJrEsB45c534DZvCCn6VZgn7GUVI2GEBFD3ZSCNyhOtJ+eSoF0MaoBgVC88ldcwNhsuqdXzQ+RNgaNzMcIcGCmHQrtlRa3DxqzI9tx01VHu2NtAN35yZADmSp/tQwMyl0Rc/xOOvIOpJGalWnnaNnfuU3OclE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bmqypvls; arc=fail smtp.client-ip=52.101.61.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp3KMT6xIdQ3UESybKlVn6w7ScSXb52OhrPAgntZsS7xiHJxIIt47dO9JhIsiQcG36UioXZ6qB0nXwWAnXhwRNwlvRtH2DnlXO1evhzemJsUANpJltCzsy+l8/rkfvFO8Vx15YEzsKf7hCpS7fGiva/5QBA1gqYjwv2kN47qXfVCfDTDsx45X/vxAY6D2Opn7E6aCBEc8QthSD6xSRjCbQ3QAtduiMsJrcHWbl0EBESTldcQsWpmpvrpt+9T0gpdzBZlqLXYDNA+LcO9oy+ycUE5HePgLHDsIIDpHebrgACVzzfyMdxEHGMR4zyVgWHXxg9AdIp+TcfQbrAHB/EY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXMkdV5iWz+zRS81vKGU+G9XsKZ2senvk6lI31HG0aM=;
 b=rfxf5cxK9NiZGNjPvqnbwosH7FKizuKgGR8jHgWHOPHZAa1pud/c9+RavBLsoldgFXepZHITZOYjRRSVDRuxFzMXok79vJYKqD9VadbjhSagCntyANAiGClB30MrC6ftXf9QTvHhl4sif0hH/1iAAFNU7zbUh1yaJF9TzTOnInt7a1KJZtmMfZoRxPy54uUsXTKtQ3vtQjg4oskYSYM/Z+F1JJ68ySFsdcdt97UWK8fYtmhgZ1KYJcDXb4vRW9CYvSj/b/buTVXmwcvDHLlWPu0s0j2HhGXgLlzfHE/Bo8HDrNQOoDnt3y9wg0VJ3QOcTEzRAnRAoQS4TdXd5Bn7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXMkdV5iWz+zRS81vKGU+G9XsKZ2senvk6lI31HG0aM=;
 b=bmqypvlsA2xDHMKrqCz8VgpJ0L43UNugDBfC63Qj6VKNwWxdAV7cG+DjiMBHv8LkRKbZrWsTj4dU3UrukpIpd5LYmfNu68ivGnYV12W64fwCLJOz0kx26hz7VL6CNXfTAgAKFEY1WryX4EmVmTc4w38XyZVpYRlVKRVf1nrXLiryGeYS6xJnfwWWO5xOb2Ul9DY+YFeKV8xgYcZ0w3OM59GQRj75pZPYjHX1lqRCxO6JcVQHzTRJRK59cRQE75sugL38YPoFlsoud/PY960LHZnAgjbMyQUZtJf3TpK3oar9lm3eBm2LkaozQE1pjtLHZNWFkn5+RlZ0vToVMgMOWQ==
Received: from CH2PR14CA0049.namprd14.prod.outlook.com (2603:10b6:610:56::29)
 by PH7PR12MB6739.namprd12.prod.outlook.com (2603:10b6:510:1aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 19:36:24 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::bf) by CH2PR14CA0049.outlook.office365.com
 (2603:10b6:610:56::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 19:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 19:36:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 11:36:12 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 26 Nov 2025 11:36:12 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 11:36:10 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v13 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Wed, 26 Nov 2025 13:35:37 -0600
Message-ID: <20251126193539.7791-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126193539.7791-1-danielj@nvidia.com>
References: <20251126193539.7791-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|PH7PR12MB6739:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c62f71f-8826-4281-cf4f-08de2d231557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LIlThvVO3eTX5r2UJSOC1k5nlrmh3+7w6tomiL/jgGqHPwNCM1Me5FS9ApM1?=
 =?us-ascii?Q?F21C6A0vqI1AjT7UxpJCnah+d1LTVYPmDTOyT0kpJpjkrMmvOVfz/hEJ9CXl?=
 =?us-ascii?Q?8yJdYE/ifPsrutoTQGQAPPql3kXfRpLYWMNmbynZlKKojgow8j/MhryqJKqN?=
 =?us-ascii?Q?tV5vmagArXWNkFhlzKIjTAb2Jx23p2j4Di/XjMluUsntq1XVEhrwTXeaVCPf?=
 =?us-ascii?Q?YVft55x5bLuKhfkY6Ixb61xf+Ns0iErqZDX88oCOhsXPK6ChTxmM6ehSA+QY?=
 =?us-ascii?Q?ggK2DzI6WeoukYdyMY/xFpHYfUsSS11cW9EYu2egTGViajtxr3cKpswL6Z6F?=
 =?us-ascii?Q?ZKXPzgCK2e4Se1JMOcwwKOcMt+0fJ47PebK2tqQ9yjySbk+h3xwHAr+5FgdX?=
 =?us-ascii?Q?dt1PK4JNwdeDM4IWjLn+w2SsyPSGcs5owiv0bxFAThKXKCczPVWB3n+8WHFs?=
 =?us-ascii?Q?Xyn6g6oPV1C4ODuO6Y8xzGY4BusDqhJ/RVpVXLAWCVlKP4fuCdFdOMc7Xrct?=
 =?us-ascii?Q?1z+z/7mx6HpEFLEEdCRFj6mBGOtFk5qzAzn68T0TDxADjtGa8UjX+lKIwVRQ?=
 =?us-ascii?Q?lWzoSCOMiZY7W/kwAfd1xrImK+e6QpRM02FsmnIXZgxaJk8wJp/iH7P60j/b?=
 =?us-ascii?Q?94GuWvh5bp8bncJB4U+EUvGSCc1Et9K94x0FFAY1kb5Kbk6kAobQ4JcSiend?=
 =?us-ascii?Q?xU3nSOVH4t3eeCxhkxIOqxmpUMQlYAGSdnMxpAm6V/KbvAbmWcxLKOWVwH9f?=
 =?us-ascii?Q?2v6MJWUqJFwll1cHTpgbR8c7srm8dzGd4gMHA9B2oDOZ7jBzM0KgLnhrNdlo?=
 =?us-ascii?Q?rCmUt0Nn2P1/NB01qVZOUW2WaP0YmMCYr2zuid4KRVhdoIrRqOpe5XHCWOBQ?=
 =?us-ascii?Q?OZoTF2JH11MpreqOuExWaTSeopHYrqMdVcesGa/UHzNvb2hqZdsF6wLXzqDB?=
 =?us-ascii?Q?qfJ+GgaLjN2fj1hu1GAD+aGtjpAxy6a0tT0oDukjCgbHv2Ehj+hsxslxIZ6Z?=
 =?us-ascii?Q?LUC9/iZAZvh3WZ/NofTQJlLz5jZupw/ld91e+ksE03bmy3R8/rNylT8ncPvr?=
 =?us-ascii?Q?/Qc5OnaHTIaNx0qSgwfpZpa2JKsfLNhy39ECr9Thg+WKjQCEL3urg0QZ2/ye?=
 =?us-ascii?Q?xe9kPeuooTZsDknelWVg5L7+RVacQG7vhqub1IU/fHrlIb2sEMvCyCIw2vl4?=
 =?us-ascii?Q?9/j61oaDuXX3IHJDnO1Elsn4sdNI5UOSPfVTsA325S4hpNq5lkD42g6Hluim?=
 =?us-ascii?Q?jW9xkCJKpx0z1kAjWt4pt21h4xQZeA7Uz0095vtDLSWG4FTYgb0kaa6dWdHw?=
 =?us-ascii?Q?FxtvzPBKeaAaMc1WIJneVCDPrgjAzlRq8fzSLOHRc3DIiRSgEYsPoJkTSEPB?=
 =?us-ascii?Q?OMtWrAf8kO3WrJw1NGA7ngBlYocPbUn4fDm2deTmUM2g/f3jycEaIaj8/Rnl?=
 =?us-ascii?Q?5aJH43TpbwxB+kJ8nWLHsBZunr5GAGN8+ODxvQhySw2BfB7bBOtqgtNzTV8O?=
 =?us-ascii?Q?eLfIxNt/qEEcaz6gbFKaIYDfOk2NFHtFz1rPcSLjr4LzZwmRM4mnYXoPRdWB?=
 =?us-ascii?Q?9ofADGjLJoeW5i8mBvw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 19:36:23.6838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c62f71f-8826-4281-cf4f-08de2d231557
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6739

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
index ecd795fd0bc4..28d53c8bdec6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5935,6 +5935,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -5949,6 +5977,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -5976,11 +6007,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -6117,6 +6170,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -6156,6 +6210,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		++(*num_hdrs);
 		if (has_ipv4(fs->flow_type))
 			size += sizeof(struct iphdr);
+		else if (has_ipv6(fs->flow_type))
+			size += sizeof(struct ipv6hdr);
 	}
 
 	BUG_ON(size > 0xff);
@@ -6183,7 +6239,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
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
@@ -6194,20 +6253,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6277,7 +6354,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
-	if (has_ipv4(fs->flow_type)) {
+	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
 		selector = next_selector(selector);
 
 		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
-- 
2.50.1


