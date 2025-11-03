Return-Path: <netdev+bounces-235258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32451C2E562
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBEC189547C
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D83311972;
	Mon,  3 Nov 2025 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JI+/IwSe"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644803126B6
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210584; cv=fail; b=A8hxGADXuJny7cO/djuzD5eK53IdeGcWgH5wMzy+0/gDhe5e2ontoRQqqKWanO9WzLThO5qGvZpgMT8X2XPh0OiwPymMlGTkvHkawsakGa8b2u7ytr5vk111cY2M8vf3edoJ5b1KPaf3Zg5fdpxTtH9Mf67LYW6inkgNIlEAE+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210584; c=relaxed/simple;
	bh=esjcnk82MMBzY5V2EVsuGd0+N8KgBcbB0eo84eOhrnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXqHSOHmzNUR8IjTx7vLSxtE+csibNaViUZer9xDhUzBFDgqnOBRS/GowlBXvmkiKjQ6vPuSoCklAodDapKrcQpqaQ4qE1LtcP+VWVd1VytQhsSZehzYLHqQZ6rdfzFzCyFmCUmSAojBhbx+H4z033JZ1uiFd7Yj19L/CYrtoeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JI+/IwSe; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nokl4D3Yuae2hGVHbulKC9WrfuhDqDXrz9v30h4FFVsQzY9zbDxe5ulzSJ9XhnrC4oD4GdJZ2ifpyOBRAc3Ih8etdSZ9ariKZol9dKBSi4mfFtFCXgk0T1aLBAO/hjXrMsV7Fc8iPx3STc0N8HPuOKsA+G3HHJRUTI0S5odGkAM6eYVltFP0K1ZqYJsQL/s+wlkd7WYwWfcpN5HeL3uGkqzvjJXnzjEhwhgKhsv/oetxt3TeHgvM9NNA4DTiHIIG0mYkK/VjmAj9PWOHl9dxnw3gMZZrVsJHrdyLUrXDVR8lavL2QeDfDTJrjsshHuIw+T2tuurP0UjpecpWwRPFZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw6mTFlP0T7mtvUKFHz9qR2fO1MmQbm0MwnVIJQPf68=;
 b=Ab9tp3KiQjnBx8xCpBn0UGJqVKlnunaWAFRg2RAOCh4jQ9/p1rKEgb09Xdmzl9Rloo5BpSAt3G/Wl/huK6RDFC0jiwpD/7JCraTgy7bHPuVdUgUemJG2w3xmQFONhLpw93P90IF1N/huTbBzDIn6d3autEScERRURevRDH+BA1VSZrDseSYRFt97RmfunuN8u6xjJpU8ylLat8/zAMtMa3j1cNLBqep9JE+D//5BlefT9Jn/MUhKs6ejcwJhcvuHZYySLjDKMoKvjpqeZ/FxKqmVJPzlgitOmaxBWD/Mmt9V61gINvI0Ndpww8Xs7yBaZXSVcx0qBKZNCMKSAHSZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw6mTFlP0T7mtvUKFHz9qR2fO1MmQbm0MwnVIJQPf68=;
 b=JI+/IwSeJX24dy8dVgZ8Bxj11QqAVHV0f/PNVKQnHLb7SrIyUmIT9GP6hZQx2/RWAxDcGMTtJvkJw+DwuhsnqU0Ydt/iEX2X78SyHMrJ7+1WS3v5AsdPgjpG/htAz5hP02njGy8ycFWRpdwjN4NdJI3doemMug/vu17m9KPPxcxdk01DfHqxf1Zaa+5sFlh7urvYmBLUKxDTtTrTWwTY/0zrZipuqF2XnszlyQI7mZMQOSS7HD7f25dhKbxfSqxGpg7Y++Ocyv+ADy2fNKJZO62HfsITU6BhMeUhUSc2me2u5OP6IiUn/jK84Y1fXQfDk9/+XROwleY5lkdkZ28Qkw==
Received: from BN9PR03CA0509.namprd03.prod.outlook.com (2603:10b6:408:130::34)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 22:56:16 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:130:cafe::bd) by BN9PR03CA0509.outlook.office365.com
 (2603:10b6:408:130::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 22:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:56:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:56 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:55 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 3 Nov
 2025 14:55:53 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v7 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Mon, 3 Nov 2025 16:55:12 -0600
Message-ID: <20251103225514.2185-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103225514.2185-1-danielj@nvidia.com>
References: <20251103225514.2185-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: e7165926-87c3-4220-7d5a-08de1b2c3210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fQQjYxAIWRqRO7Q6r3ZlK4vV0aTFMfSRcglWczrkmODBhr8H7/hi+BHLAjNy?=
 =?us-ascii?Q?DWvocgXSKVPG+VVoPf5toLeeeyWOYJhpQ/c4UT7LDqvQrk7RmrQTcm01QjjD?=
 =?us-ascii?Q?UcgBPuF5m+c5wvrHW4l0zD+iKnqs2a9WE+jH6qlaI9S5TdGwZ73JN5i8vIjA?=
 =?us-ascii?Q?HHLMb75z8FBHjJ3WMyzXoHTQaY2935NcwYdlfIwY55PkjynG6Tu045TVFp6a?=
 =?us-ascii?Q?GS3IDhqsuNpWnkL0Ruawfgad1Wz09ocnGTcXH8YmSs1f7RR90jxhw1wYhh+T?=
 =?us-ascii?Q?WnrqbvOeHgCceFtbSaLMuckQnOewPqjSEX2TUS5Keoi0TVeBL0yOQZ9zryx2?=
 =?us-ascii?Q?ek3ob2KYThPB7eONYfYq9LzjuFyvD6u5ycEycaQuq8CwCsQSVMZYrSJCKeFI?=
 =?us-ascii?Q?mwJNiS9LfbWk+TlHF8KdGNFV75uqLwa0TDumX//vgZu63UAiWQczGK/ic9EY?=
 =?us-ascii?Q?aXTod3bwls0tNa7GvnjqChdYzhMz2VjS6USfROzQiueXNUccLnXTj0te+Xyi?=
 =?us-ascii?Q?jvNThWhYEXy7/UFPk6gI0CT7nYgch/nNotiNzM3+odFfVqY++U2zIedsbQJI?=
 =?us-ascii?Q?aeQEzFFvj46I0IDUeBBzK+O3n606gSCRKZzvxu2dhZ4td1ZYWCobBDG8IkdE?=
 =?us-ascii?Q?ihtAgUtrQE5FOG2aPFgtva2ajnBx3skvQ4y4cRo2MSaiZI80277L/eyf0Pn8?=
 =?us-ascii?Q?tpBSFJvpBAIFE7xEEPlH/R50kWHw/5pYPye+/zvG8FTm1tBf1gwYgLWf31uZ?=
 =?us-ascii?Q?CpfVW4KcJ8WlBZPxcpSaCv+laQRTek8HhTFIkw6zJuxnGLQ3a47Ssdt5wjxh?=
 =?us-ascii?Q?AVX7TNudO8plWcC9Cwc67noqRWKM6Njbv17NIhlXQ6ewS12G21vdEMiY/7t6?=
 =?us-ascii?Q?JwiFTzuP3sLQwAvCoekplJ2MGwKs/PyB5kTgV9R+QVR1+I29vneOvwEihtiD?=
 =?us-ascii?Q?CKLjoJR88AKGk6Pas9K/bcfIFwePaWAqN0zSVzsGTICUKFQIxy3OabcQj841?=
 =?us-ascii?Q?Hxox6ElxR3QTi3KEoDPb55zpqzitP/W7b4DNXVZhOBRvv7zKbWnfj3V50Au/?=
 =?us-ascii?Q?4u2ItM8QkPWawW139NSd88wY67Iu2UXINgrqgT4ZxyfirIApYeuxcyZ74GeD?=
 =?us-ascii?Q?o2TMbIIiJJ4xmz2fmSN7I3BtKH2Q8OuCmIwZTDE+BIN8oNCa49+y2HKBmoS9?=
 =?us-ascii?Q?vfDi2cluDI+m93ZeqNvDTTLWTTNW18pjXkak9NXy7tsC82Kfd3uCgtllOpSI?=
 =?us-ascii?Q?sNX6/wUrSWNJKNbaqWkDNIdr5+Tco7BTeJpUrYHqUzwBIU5oUHn8MJoYZW9f?=
 =?us-ascii?Q?BT/DTvQ4flY/Wa1PQvR/oJOar5w5kHpeNL0nC/xwgKI1hi4S37NB81UzYXfX?=
 =?us-ascii?Q?cCv35cO8EeuRe0RRGsh62tDyBedbJnlybXAvn1AdPn/m5TfVy5YnbQThuDpq?=
 =?us-ascii?Q?Kv//3bWmdHUrYiEu6l52d+aoGVfWe4xPdXuUq3jLs+Xf5fjL2kTIJLJiC/+Q?=
 =?us-ascii?Q?7ovzxFU6aXWcNQRV5sCNxBEwjEiKqxje1pErpszwS/aiRdexU8N6I756bZNU?=
 =?us-ascii?Q?aHiQBMEAo6NATtOQCkg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:56:16.3722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7165926-87c3-4220-7d5a-08de1b2c3210
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677

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
index 865a27165365..b1f4a5808b5b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6917,6 +6917,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -6931,6 +6959,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -6953,11 +6984,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -7093,6 +7151,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -7135,7 +7194,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 	++(*num_hdrs);
 	if (has_ipv4(fs->flow_type))
 		size += sizeof(struct iphdr);
-
+	else if (has_ipv6(fs->flow_type))
+		size += sizeof(struct ipv6hdr);
 done:
 	*key_size = size;
 	/*
@@ -7172,18 +7232,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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


