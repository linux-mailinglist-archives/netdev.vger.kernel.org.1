Return-Path: <netdev+bounces-229874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75782BE17BF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A0A19C4E12
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535C822D4D3;
	Thu, 16 Oct 2025 05:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K0M6MDjd"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F5A22B594
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590909; cv=fail; b=nelDqNpXCxeQvISN6dALbz6f1kM7z7ey1wRqmzqtcP4ba/gg8vWl37HUF1UHxztbfSHJGGUa9xKLNew2aE7nns5Yn/AfAN1yQJSH2h/gBINgx2fiXaTp6jgGrmWj3Zr8Sq/pckNAnithVEkpnyCZY2NBkQxduV8UkQroLc8Iqsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590909; c=relaxed/simple;
	bh=AbQR3kZIvG6Rj8ftUjrfXrcLE/45vs+FubQ8hXB/4h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVMyWqWXBlFMa9RICpY2Mco1AZcUsWbF38sXLn5/ggLbwc4XTOdJ4wRMjKVOwH6g7XFjFzFdF7+9wPMsHu+dGsOw3PDF8zu95adCw/f/uQOgDUxrWWrumPu8Ir81Yg/es2Xc5azIM0Rs1eobsSPP72X/b/SCxxbjtY6CysizMx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K0M6MDjd; arc=fail smtp.client-ip=40.107.200.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsdIb2e2/wabbZTvIdzd7DyMmc0uQMvRODTejzd7nVCrHzOBZK64sYMk5axY+HZ05xpoHTVaq4POf53GXddINQm1QNIU5wEeWiZOZh+BROwIxKgoGnJKhWC5uSNfxsPliD75RpabXj/M/XWAOVyBE7rX8LLONhezYOinAzuiAk93k3i6FwbVdnHMQkqDXfb1HC10qyEAw8k/bGFSJVAMnei14iDtA6ueh7RL4DTHxmcyjvapMW/mJ5uekmK63PWYyLhIUwFIo2M9OdszUVT0kmA7c1bl6W6AkKPGbHPn+G5S6Gcgcr+hhujc6+dymfuSXXCVGGtceh4Bg7AOi/mojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZolKOTjLKzh+/oiXlOXKtA/2PSTp7pujrMSwvP8yBA=;
 b=EQeebJak6sP6mqlLC7EwJzjA2IBQ/HA4wQcmTKXfJZx4htLkMcT7Y1oGVBcZA82TbsadqCPzvf1cZZMrAJZQCctrOs6CBdJlto2haheqyCYq5P7ZMPYeY3X2ILXurXraLsxZ10lM11dg3Yuu0LWChtrkkqbDv3RTpQ1plf/4w6PGXM0WJLcvI+B0nPp9zrSSevnvh3nw9X6NUwDMnpnyleA6W4CL/juScDkMw3pOLfcGZpPAu2XD8IzEYam3sxKxN2U68xD+UYtl0jzGoNk9YP4GgkAj/so5YOZZ8D4s/QeMAVk8Q9uRzzd46QfHyUZlC6+nDq5n96a3aqLx9KhCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZolKOTjLKzh+/oiXlOXKtA/2PSTp7pujrMSwvP8yBA=;
 b=K0M6MDjdTfXU8hQOyHVtRNR2OZRaGOmV7yJq3EFaKXROvHSZvBRs97A4Zh6N4db+QBgYQrL5SNf3MEHFjnyhoBIbVbBiuHCxN9RUQthipjjyhger3o2BCetSQe1tc39LwxGpwhQYi0Q+kjyVv+m7ZtPzEjfwWIjnPZg0v8kHNyMMSEdTthaVY5KPwYdhx4H0JPf1NehY4CUtfeFLsUosNZWQJxxDVeXNw9B6d2HH4UJp7K5HWRyrE0GrufgMGeTtRcm3kAiJR+2t6KT/h417HDwDFfmsrM10M2hB056bVk4CuiW4lB2iqKzrHtuhtITHDB0LVjw7ymtHbXPSi941Tw==
Received: from MN2PR01CA0012.prod.exchangelabs.com (2603:10b6:208:10c::25) by
 SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 05:01:41 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::4f) by MN2PR01CA0012.outlook.office365.com
 (2603:10b6:208:10c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 05:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 05:01:40 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 22:01:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 22:01:20 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 22:01:19 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v5 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Thu, 16 Oct 2025 00:00:52 -0500
Message-ID: <20251016050055.2301-10-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d795a5e-ee37-4aa1-7670-08de0c71180a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F6PfKVuXlkx7iwLby84moWtEs9Pa5tbNBmJpfeNjKfyMyrQMoL/Dr/APG90H?=
 =?us-ascii?Q?+UMJCMjqz2cq2OnWIj/FfN7JkoFiwN3axC1/no18gO00lPeZLwnTYZaf+rLP?=
 =?us-ascii?Q?/OZdVBnidrzQD4jU6VTP3Qe+ejB2v2y4rWOxE+Mksq8FtfqjTBsLtpuM5rgQ?=
 =?us-ascii?Q?bgkzO1oF+OAvEl3YCBBB+5nTDfQoiF75vxiCewkvLsk0Lv0gRdg47AnBRudg?=
 =?us-ascii?Q?9td0yfrgmjR0kNofE+bkoSU/SLCfynaLD8AWlvKPwC4/x1CyJkg6PiJmKmmd?=
 =?us-ascii?Q?yu0IU6OK1i5aLsB9rsfsbT1HouUnRHqs0Tmi7J7flBvn8AmBnyizSwTQoYmP?=
 =?us-ascii?Q?G33lBQiPnt6bYG5nTLBYFeOAIF2gnRKORjxhTO8Gpdw4HmQ4SG2E7JL3DDwu?=
 =?us-ascii?Q?bg0Tuo3yNdPQzMgBszUF0bC0C41nmbTIWPCD0jHBwaADHlnfBD+mx6kZB6JU?=
 =?us-ascii?Q?Sn8/X07UN+vapKQK5W8qaKXzML/x7JU1HTBlagwGf86+KbGqB887h++8K5Wp?=
 =?us-ascii?Q?ETSow83j0j6dKXNH8YVnhLwo/AgGYZr0DdI96GQl7rsAXlj5ud28MA89uY5q?=
 =?us-ascii?Q?uLDjoi+qBSHu+90vRX5m+HLvU9W1p4+0CE8zWqSuHofGJ19Bh3aLfAOlMLRN?=
 =?us-ascii?Q?hJOphJtDH2/JQH3QKciHzO3XF+/YnLQEbsdvFLHYKQU3UdX9jYyGipdoxu6q?=
 =?us-ascii?Q?zA12Dk3lCKEVIJEAjmUpOgSHQA8HwLkglX+z4wg6f2Ldnf2ZpoGa7LEBGRbg?=
 =?us-ascii?Q?VcdS2jQB0eGMNrIzwxFauUxjB1Hegj5FnngGNOA/Ykq4eFsSpYOyaAR0hu1Q?=
 =?us-ascii?Q?ITOQ3h2pur/VrSRFlaX4WdoUSjazNH4Rvfe3bfltNXdZHks3jXnS0VOqx+M8?=
 =?us-ascii?Q?02j2aEftvYlWinIbJhl1eTFor7bjoeDdimThoFSeQuE4v2U4TMx/9nGcfBPq?=
 =?us-ascii?Q?spylPNUA0UdP+fB+4q59szJbWhHtcIvcevUPro+nDjwLPCcwR7HMnxqIB2uM?=
 =?us-ascii?Q?pGJfKB0wsJ1A1hSkYD6eJB0tFefXU3BAM7dgEmuO4uRGarUqmclXc8g7KUd2?=
 =?us-ascii?Q?1q62pws9rmtKNbM6WNfYRy5gZewg2IYtBYs8ctarejDP7MCyJo5Ms+s0X/pN?=
 =?us-ascii?Q?YUZVXUgvfPk1oX3pe7kcDZTgM89F9qRjbX6YrjSpZFh1MkTZS3s81TTTDtqv?=
 =?us-ascii?Q?RnvbaNs6r53XJau05dnwtN8UBj49gahTX9XJV+Q1YswvQtNoAUfcr6WzFTvY?=
 =?us-ascii?Q?D+Vwc4HUUnAyQju4Ksz5v6wj6/CoRaonlm2IfFQpTf8DBAMQ1o315ca9YgKc?=
 =?us-ascii?Q?6GYoZ0DXZaQObqzTI1UCV6a/9QgmGuri5lnMw37CYuIYSplGvxjo+ku2blqz?=
 =?us-ascii?Q?AG4I22FwxFKOTXdnYqhXfSODVsAj6kmR46YzDxuzJfRd6yWBfbpdV71BZ/c0?=
 =?us-ascii?Q?P3JMO9xhTqahvc7q+QJJTUEBPAr894Gjb+jaUiZo8xrI82VyrwUVhqYGEiZT?=
 =?us-ascii?Q?0d2ogZsQQn7pC4skI2KLLT9neqQw9GZyDNKOE4ptZm31fZbZ+YNQvlINyHlO?=
 =?us-ascii?Q?QQcLKBwgzIuSck52aKc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:01:40.5502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d795a5e-ee37-4aa1-7670-08de0c71180a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
v4:
    - Fixed bug in protocol check of parse_ip4
    - (u8 *) to (void *) casting.
    - Alignment issues.
---
 drivers/net/virtio_net.c | 122 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e7816e1cc955..a67060405421 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6884,6 +6884,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip4_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct iphdr *cap, *mask;
+
+	cap = (struct iphdr *)&sel_cap->mask;
+	mask = (struct iphdr *)&sel->mask;
+
+	if (mask->saddr &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->daddr &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->protocol &&
+	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -6895,11 +6923,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	switch (sel->type) {
 	case VIRTIO_NET_FF_MASK_TYPE_ETH:
 		return validate_eth_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return validate_ip4_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void parse_ip4(struct iphdr *mask, struct iphdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
+	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
+
+	mask->saddr = l3_mask->ip4src;
+	mask->daddr = l3_mask->ip4dst;
+	key->saddr = l3_val->ip4src;
+	key->daddr = l3_val->ip4dst;
+
+	if (l3_mask->proto) {
+		mask->protocol = l3_mask->proto;
+		key->protocol = l3_val->proto;
+	}
+}
+
+static bool has_ipv4(u32 flow_type)
+{
+	return flow_type == IP_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -7034,6 +7087,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -7062,11 +7116,23 @@ static int validate_flow_input(struct virtnet_ff *ff,
 }
 
 static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
-				 size_t *key_size, size_t *classifier_size,
-				 int *num_hdrs)
+				size_t *key_size, size_t *classifier_size,
+				int *num_hdrs)
 {
+	size_t size = sizeof(struct ethhdr);
+
 	*num_hdrs = 1;
 	*key_size = sizeof(struct ethhdr);
+
+	if (fs->flow_type == ETHER_FLOW)
+		goto done;
+
+	++(*num_hdrs);
+	if (has_ipv4(fs->flow_type))
+		size += sizeof(struct iphdr);
+
+done:
+	*key_size = size;
 	/*
 	 * The classifier size is the size of the classifier header, a selector
 	 * header for each type of header in the match criteria, and each header
@@ -7078,8 +7144,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 }
 
 static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
-				   u8 *key,
-				   const struct ethtool_rx_flow_spec *fs)
+				  u8 *key,
+				  const struct ethtool_rx_flow_spec *fs,
+				  int num_hdrs)
 {
 	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
 	struct ethhdr *eth_k = (struct ethhdr *)key;
@@ -7087,8 +7154,33 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
 	selector->length = sizeof(struct ethhdr);
 
-	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
-	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	if (num_hdrs > 1) {
+		eth_m->h_proto = cpu_to_be16(0xffff);
+		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+	} else {
+		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	}
+}
+
+static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
+			     u8 *key,
+			     const struct ethtool_rx_flow_spec *fs)
+{
+	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct iphdr *v4_k = (struct iphdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+	selector->length = sizeof(struct iphdr);
+
+	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->h_u.usr_ip4_spec.tos ||
+	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
+		return -EOPNOTSUPP;
+
+	parse_ip4(v4_m, v4_k, fs);
+
+	return 0;
 }
 
 static int
@@ -7110,6 +7202,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
 	return 0;
 }
 
+static
+struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
+{
+	return (void *)sel + sizeof(struct virtio_net_ff_selector) +
+		sel->length;
+}
+
 static int build_and_insert(struct virtnet_ff *ff,
 			    struct virtnet_ethtool_rule *eth_rule)
 {
@@ -7147,8 +7246,17 @@ static int build_and_insert(struct virtnet_ff *ff,
 	classifier->count = num_hdrs;
 	selector = &classifier->selectors[0];
 
-	setup_eth_hdr_key_mask(selector, key, fs);
+	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
+	if (num_hdrs == 1)
+		goto validate;
+
+	selector = next_selector(selector);
+
+	err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+	if (err)
+		goto err_classifier;
 
+validate:
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
 	if (err)
 		goto err_key;
-- 
2.50.1


