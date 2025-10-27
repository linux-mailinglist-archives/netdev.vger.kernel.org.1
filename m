Return-Path: <netdev+bounces-233277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5B4C0FBA4
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C49A4E8DCD
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0831961C;
	Mon, 27 Oct 2025 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V7qYAnO2"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659843195EA
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586859; cv=fail; b=FWyOAX5D0p9Kiu1VwO3wN7BKS4qD1MOIBheZn7bJezPxDDva0mJz5+VIAM/xJ9oQcrbBGNQ/mLwFkEuK7TJ1T9yCK4ZkwBPhE0T/4LmDedhUTvXccioAUSnTQAyXk2UiD/NVpXCI2ks/ziN4RVwo0tbV2TempolquD7GdkER2gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586859; c=relaxed/simple;
	bh=fwj+ZROvbFq+Mf+lnKziJmKlBARgVoOpRhefuj70GzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uurc+yNPaCo7DBmPl1HNMw/ZNmZkYZf24hXtq0++IPUvZiW+WzcSKvrwjvAwuoYamTpTVviBsEdieioQbw/t+Edec2hDvqmPv7cKX4KrQopDu6dMk3Xyp8LAX16+YpO6zYuHm65++Etg5Su4M4ZZ+EX8EZH24glbCT3GcN5ppaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V7qYAnO2; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nf9lqB1qI9jqw34Iu8Ft+qcRtZxMt2sSadTKFV5mvtmm6DfmsQt/u9At4ocdAI6eEwvCunyfoH/c7soGFR1/BrJr9Li+xfr1XycsVm5nNZCauxYyZd7d4hw2DCno+VruzsplB77DBQEhp2Io1daCoPiupqp4dU2asCUnoR7EEUdCEb5I0uaV3FL0OppMGtEJTp11iCqaH35vn8Go0ikdyYmn+HznFnDQS00tI37nmUAXXqiJ7T9X/XXWeSXl9oz4PmSfvC6OJMu+aoWLEzj0E/ClV0jo/pMjvbCHnXidV7y+mTNNWV3+IZF4lpzAgR7XAcjX87lZcHdMr3DewId38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx3shm0CkZFGqcUCpzLGHs6mp4oPVFgaqa6v0emwCKM=;
 b=LjGle7Lfpt32SpQH/S9pUtWfwJDo7W1o2dZwB2/pnjycQfuAYlB+O5xaaAVryuV5U8temA6wsMCsXOFloDaqiJK/9uP5AIm3Xt6eFZ5RAsvgjxCiUa19u1JDamaFkoEFbpPfIM6XjYlmkA9pwu+ktmqVEKI+WK/z4c3cELNjgwiJTI/nEna0ch5jjIjCRbsjG0XbTjOEeY5ufT6eOsrjsT3z7Tmx5hS1XaZmnTuyCAzbdtcmA/stJlnn9uHfkQufumnAnRgVhr9yVMTcu3Kmv/hFz4hEqMzotoYD1iLdDiuJFiJdEKAuNT+peUcZ43ldldkL8EefVCZjhdudoqrNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx3shm0CkZFGqcUCpzLGHs6mp4oPVFgaqa6v0emwCKM=;
 b=V7qYAnO2QUoIld5DH3PJUM/ZxkNwP9I6U8oAa0tl921fOtaaxaZ9mQV5jCJaLrg2CzQ0eV74feBOypSTB6ZKkGW0eUFFY+xV104iNsM/y6gBvCQM5AGeGGHAVYVqxCj2oMv0vv2uAgVnvc8RI3c414nfJYbxPRwJBrMZlV0jBUjEdG5Iqqa44m+ePOsAUP35YQaIHEYL/YcKXdfWLQ7EfDD7113WHa+AQPYIn34LqCj9uu0VFHbP5Q5p5X3MbIN+VxukythlJjfqcIpAkvOJdmdkSi63K57KrXTK9a87GqlQkYSY682eBWov2mOiEUB5JYKjhIVi1dKqBmgfhxIHtw==
Received: from CH2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:610:5a::13)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:40:53 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::f1) by CH2PR08CA0003.outlook.office365.com
 (2603:10b6:610:5a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 17:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:40:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 10:40:31 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 10:40:31 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Oct 2025 10:40:29 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v6 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Mon, 27 Oct 2025 12:39:55 -0500
Message-ID: <20251027173957.2334-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027173957.2334-1-danielj@nvidia.com>
References: <20251027173957.2334-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c604b8-933d-4960-6816-08de157ffa2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ev/N0WD7SYw+3N3fpj5W20KS9OJwLYip98fgDZ51o0kDkWI/0QhHuebOdqq6?=
 =?us-ascii?Q?ISB7vjMaKjWHUYN4LDCRUTI236Dr80OcLlCPbVvx0KEQemEfHQCyMWXrFPk3?=
 =?us-ascii?Q?RU2MpGTI2Gtmm74NQjTydxUjixumHPiPgGwWzmSOd5HgGmGNFg0rUUKSivvw?=
 =?us-ascii?Q?PE6NmLVbygptVqfOTSG6MjFv64nnmFBfFmlEUJhskMlsvnlyTkE5IYbuyZfB?=
 =?us-ascii?Q?jgl8EGZ7/nE7Wy0KrVsUr0U8nzdTn/AePvWF8ZcNHdAXt6MvTs2VEEuj9foR?=
 =?us-ascii?Q?8VZzay4qz41uTTvXtvZ7TdGTAjJ88YNhH31AbB4WGkc2kkSkn4MSJWmgKQR/?=
 =?us-ascii?Q?ksX80gMQDTbzBWLxGTMqWi5wXC+P/WMrMhQxY91qtOrUncWiqUU6V/VVO3qj?=
 =?us-ascii?Q?LJbidh5SF98hjDdwUh4idAJ2zZ2vhyuUm2km+jcVM83PmCfKsq4md8LcOeuH?=
 =?us-ascii?Q?CFBUdYpUe6xC/QljiZPnSLdyVojpsOivAuXmXlDiz4TvWnm7LKtm8hvdbu6n?=
 =?us-ascii?Q?1cRLu5kEKG1kRUEa08qKpCniWo/iV1VkHhjNU/fOmT1baA038/dQvc0U4MuG?=
 =?us-ascii?Q?8NozOchJrlNpspr7ttwyMYhp5YIm1l3669qX2aGgZd3YTgCmMkBXXs8XOK74?=
 =?us-ascii?Q?5BLIsqjDxRGHYrI8k/Vw9jvePgONg/jLpukU8YgqAj5AXrDMPc6J/XL3fwQo?=
 =?us-ascii?Q?i4ITgOTZ07acAdsYo7RH64sQTdl4mna7Pnxzam1Sld6JsdhoFRx60LmOeN2+?=
 =?us-ascii?Q?YiZMaI1APx5MMgdbE16xjyUe4WTfD734QLOio/ctm1dJSOoQnuXvpfQuBSiG?=
 =?us-ascii?Q?g5cye+BUAfRg9aMyuUWzFHPjwOhwIaRdkNP0VbflERQeF+ZF2hHVom53kdOe?=
 =?us-ascii?Q?XhYh7hTE7wN+8Zf0KEXgQmtktcRQgfP/qc16Od0HzOIIHSw7/xqbIXGlPMd3?=
 =?us-ascii?Q?nS29MF03VaSgrx0dc8SXvBzKrVRnOoE4Q22tvV8ig6acbPqPW43pVpsk+wv4?=
 =?us-ascii?Q?cZ0uvwILj/mBq5LSZy1+WxXlmwEZb0TY0yYElWPctEJkxjrHNjkya1U9NSnM?=
 =?us-ascii?Q?0cusenD/3mFSVYd74BD753g/vHrhT/TqlLUUZAcpZL8kEk+U6aDNvj7XiTY9?=
 =?us-ascii?Q?7lR4JbpllaZf32htaQRsJ+uIEM9q5vSS0xGY8BQacQ8V6f1CiUbvd6sQfNFq?=
 =?us-ascii?Q?UdPXnzK0PN2419YnlkuYwENFsG16Dz6YVck9xhxyLtnZIsDFIg37THXLEfaD?=
 =?us-ascii?Q?kMq0xrVPG7qBpUcuax2WSnCU+JL07J+CqGqwfrZuhIujtJmp0decuJKpgzfI?=
 =?us-ascii?Q?IomZxzzZuCpu0A0gylIxKd8F2I4WXaRAWXpOdx8x/jCKzYD1jGIvW/7u6+aC?=
 =?us-ascii?Q?GU1kK4pLP8a0DfB03CbSQCyj2Q9Tiynno43biBStyv5wUJYZVYyGlnS0+Gqy?=
 =?us-ascii?Q?RD8P9L9QkHUCjvoMywk5hpngBMi+hJEx5p3T8jhZOSTVLGc+baUHZllUnbKK?=
 =?us-ascii?Q?IMy36T1c/MhR5t1vi1E8NRC6GW7GT6apH8hRJc2pkeS2576XhmKPVJutO9lv?=
 =?us-ascii?Q?axPl/nW/J0nLE5yNxqM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:40:53.4053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c604b8-933d-4960-6816-08de157ffa2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101

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
index 79313627e1a5..587c4e955ebb 100644
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


