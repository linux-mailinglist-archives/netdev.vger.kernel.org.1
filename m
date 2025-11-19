Return-Path: <netdev+bounces-240126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBA8C70C3E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 392C22A094
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9864E371DD1;
	Wed, 19 Nov 2025 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VayjURka"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B584369233
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579784; cv=fail; b=KAEV0fgJMp3GfPP9bfJt09V+agtTv1Qs1J4mF/4fr9zDh5FZ04TjL5CQhqjhgGQrjyOHTXZb+DT0+cginJnLxw085o0RSXEMacDuoTdv8Kv9H+H584yQb0/DCfTjYBZnNfwCRbmvRR3cLvKPe9bdtVIMLylsOaDEnp7XiPHjqiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579784; c=relaxed/simple;
	bh=XVSF4IYPo9P8P7olVzH8y+IuEtXc1EaSjopYEZ78p1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqMhQwAetMbxMAlLqQvSqjJfDetJUDsNOYyQMpjPogecp+cZvdSeMwjsxm5tObA2auozrAiAYWYq/jxMwFkr/0huuswh6poMyKW0pRBiXHCYN/al7Oyr3ByULgUKh5ZCn7ExsbYSv2VbsSXFm8TjOJxE7NiUXLp7iN5TMy/tdPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VayjURka; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw/HXHIhItitTynAn1sdVHiodo5EyZQqE8a48MBe1/LTV/Ffdno6LlEv/NoE/fTOrTqaQsiQsp7N2EpFeRLcGRAFtlpg+jCoFS2LmYHcJ94YnkgPXSl4UTRe0RZomJRUqpQKtX5nxltsXZ0GW7t0qqW9h8Pr7BmQSLmOCQ25krqZ+XjBtESKpb66Ex1VhRjQGHVsHad505yVWv5mVnsAERtogCAGsOMUThSyBLuJUJzUV7klCsy6UoygBWYIewQeEju41XEhVykQe/MsZFPtWRgawboPTsTz+pgh6ccR7WOQNlVwr5r5hGyGYyin19JVsH9/wOleN53NpJWjwYXb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJYxgIzf2OcADImRZNncO+wZMHaDWUM6xcxhNpeDI0w=;
 b=KvPD0XoYnnhoUR1uVZ9Ocb168K9MieXfK0jCnAL7TBNK20QBvpGjqAUVxtckidvOqhdNoK645fDiZEdHss54e6pFuScG4XHBuXC4AfqRkf3hn2xpO4H4vbr9x60XVybSae1VfF4Sw2NvRqUhY/sKQlVlwQh6g2AiHfF4TKHq/7m9/jnsnubMeOuDuvXHBZ5JeWLT1aj6jZAPpjp5vrT5u9K5SOqbWH0NCuyw4Zxrok9o6aXYLFBwOTA20wyqKFXPU3J4ofp/x/ZX21OtNA1PEMPnn7wmy8womJ3nfeQACJY+Zk7iwDELwhZFKIKF1M/ezCAUfvCuyh3ZA6V1dfA+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJYxgIzf2OcADImRZNncO+wZMHaDWUM6xcxhNpeDI0w=;
 b=VayjURka+zv1E8XZUiQyBzSOznHeDfgD6khq8BlUTKDykuCMPX9GdPKAVZWu9ZThJqln8wY/lSXUJITjnF9pw+hfYXH7FS9nQt7H96NpFKyOdJES6DKqa5ZmlRCPaLCMVkTOiCJL5qMY5R0grhgeO2qwDQtLYoXN1PZjrrtbH1iJCRiob4cJoQaGHB59YdVQ6ykGuvnlVa6Zz871pTzsWcLctChra8S8shqGqHMeJCPR5d+mgF0ayIJ7nIOIJumFWuv9QA2cyCNHkQxhNGQaD3XjXPhpIxhGnL2xs3gHk3MTd7K4200voNIQW0KR93l2hTcDCC19taSgYmhgBc3nvw==
Received: from CYXPR03CA0069.namprd03.prod.outlook.com (2603:10b6:930:d1::9)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:16:07 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::fd) by CYXPR03CA0069.outlook.office365.com
 (2603:10b6:930:d1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:16:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 11:15:45 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 11:15:44 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 11:15:43 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v12 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Wed, 19 Nov 2025 13:15:20 -0600
Message-ID: <20251119191524.4572-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119191524.4572-1-danielj@nvidia.com>
References: <20251119191524.4572-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: cea124e9-78e6-415e-f855-08de27a01750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/b5xRYj3Bb5D1daVQydtdcaZUFTXlth1LRAMcLlcSbLqd60PuekCd5u3+5er?=
 =?us-ascii?Q?oDbqrllx5ZO+lPA6YuD/A+9JlRHbgvCzCMMVC5zSfiiYW46u+8C2foMLRWut?=
 =?us-ascii?Q?OLLBQsxWx0uiyj3FdZUoDHpFvbZ8ADgvG+cWY+dWgAFU9HlY/rKCKCj59e5G?=
 =?us-ascii?Q?vZX4s13dFQwXA8qWKj6smZmDH8ZCyB5fjqp8sGCb/9eNCZkAvUGu8048Jve8?=
 =?us-ascii?Q?sHBsC5pK5FC3qTfayMz0Z5P/PIGeP/4bO9tgIgf3Qxra3HwKIXUXM8guCnlC?=
 =?us-ascii?Q?/f9rT8ImTmm5jyFrMFy0Eji4N08wOxGFcVKzhlBOg+M/eaBr3S31nwcq85IS?=
 =?us-ascii?Q?QhcRr+Kegnye5oRB5ZJIOd+xXelXcbtKVcAln8dUL758zBXG2Xl+T2xBv2h6?=
 =?us-ascii?Q?MSwMKUqlCx/ndvMmgXy7nxj/YW3kK4QZvwelLfnsdb2FAchMDWPQm3WumSXE?=
 =?us-ascii?Q?y1hAJxHfjuVmaP15UW3Qm65dZ9MKMriu5bvHmf5VRr73+ZoJKOd/eyCblWbR?=
 =?us-ascii?Q?zICBAMNGgV61CAS84wUaTfL2b0XkbXa8MTzwgkuu9eB7esxMmFHqkR57Pdtu?=
 =?us-ascii?Q?96+qRp7WsRYZdmpcxSRVXARV/12Bv9Z3cSXxuYXlUdI8XTcj5f6S4wk5y4or?=
 =?us-ascii?Q?vhZaGuOCVy/dt8R5pPgzOW0pDxvhHjxYd82mfwGoKozMLBcBC4fEL3R977SJ?=
 =?us-ascii?Q?J6PRMALEcSho6ws+6CzNHoKmqo2hLN0Xp3rcxqxdy8+QN990Ze5sRsKNW0Ne?=
 =?us-ascii?Q?kdd8wM/EXtdh87oe208wvii8noO6PU+fL7mWFA0ldxcPLRkGxM6Mt5XhdlVU?=
 =?us-ascii?Q?RKSPbM+qg0eGjpz5w8ziyfkhCIFZ0rJpUS+3GfVSr5byQBnKbwPJWpjA+LBH?=
 =?us-ascii?Q?rFX9eiDbmsNdiL9y8qcE++TYU9/5Li6X6arp05lmeAAeTb5sqjMH4vgoOouV?=
 =?us-ascii?Q?NelBsFpe/LlK37M4oYr5fKNc+UETMHxIeOGRlzombIOzITeM1cpQTVB11/gl?=
 =?us-ascii?Q?9Nyn2RcSkzsv6QKQdXYlW4roob8l3U4e/ZZi4Dr90CGSQdycHHf47HqHhsBJ?=
 =?us-ascii?Q?WQgBiINqUKlbJU9Ad0fjc6ohVTrPYU2NvBm+8Ev/vCV43LOkYGJzuuhzopqN?=
 =?us-ascii?Q?S4lhq027FR1TsSodNvKzKibl+1lVAq5m+u5xTQqpV7qe0d1TKwOMCPHbf5s/?=
 =?us-ascii?Q?ARGYKsRKf8lAGeIlyd3B0uQ9WcokbtjW343rtGEi0tQgo/u4Nf87yI0MHfTY?=
 =?us-ascii?Q?UmL5RPQeRlITRAQJbwN+1lLjsx8g/7+NzeFQkqVQZk26E9alqnrbmBUziVhC?=
 =?us-ascii?Q?31JaSU0OR+PSheL1M2NuPOWsYNksMhYs498c1rasGq/Ud4k+rJUL35yNIZoZ?=
 =?us-ascii?Q?mANB6SML1Br5u7iR6ft/gJvfvf5HYrN5g+4qHYtIGyjW5652DD6PKhvjB3Ks?=
 =?us-ascii?Q?AhKotFTPdtYvEQTqb4BTvlDwqG2s7o80Lg5YRgWsJsEzCN3vtXdVgV9qZ/b4?=
 =?us-ascii?Q?hIiUAJAX1Rd/xBUq6OpZhY2617Ang7ICKOQJPhcUOMLKtXb4d9jU3Im8bHK4?=
 =?us-ascii?Q?C8yNrP09ZejkvhK1gDs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:16:07.0901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cea124e9-78e6-415e-f855-08de27a01750
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed bug in protocol check of parse_ip4
    - (u8 *) to (void *) casting.
    - Alignment issues.

v12
    - refactor calculate_flow_sizes to remove goto. MST
    - refactor build_and_insert to remove goto validate. MST
    - Move parse_ip4 l3_mask check to TCP/UDP patch. MST
    - Check saddr/daddr mask before copying in parse_ip4. MST
    - Remove tos check in setup_ip_key_mask.
    - check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
    - changed return of setup_ip_key_mask to -EINVAL.
    - BUG_ON if key overflows u8 size in calculate_flow_sizes. MST
---
---
 drivers/net/virtio_net.c | 119 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5e49cd78904f..b0b9972fe624 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5894,6 +5894,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
@@ -5905,11 +5933,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
+	if (mask->saddr) {
+		mask->saddr = l3_mask->ip4src;
+		key->saddr = l3_val->ip4src;
+	}
+
+	if (mask->daddr) {
+		mask->daddr = l3_mask->ip4dst;
+		key->daddr = l3_val->ip4dst;
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
@@ -6045,6 +6098,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -6076,8 +6130,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 				 u8 *key_size, size_t *classifier_size,
 				 int *num_hdrs)
 {
+	size_t size = sizeof(struct ethhdr);
+
 	*num_hdrs = 1;
-	*key_size = sizeof(struct ethhdr);
+
+	if (fs->flow_type != ETHER_FLOW) {
+		++(*num_hdrs);
+		if (has_ipv4(fs->flow_type))
+			size += sizeof(struct iphdr);
+	}
+
+	BUG_ON(size > 0xff);
+	*key_size = size;
 	/*
 	 * The classifier size is the size of the classifier header, a selector
 	 * header for each type of header in the match criteria, and each header
@@ -6089,8 +6153,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6098,8 +6163,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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
+	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->m_u.usr_ip4_spec.ip_ver ||
+	    fs->m_u.usr_ip4_spec.proto)
+		return -EINVAL;
+
+	parse_ip4(v4_m, v4_k, fs);
+
+	return 0;
 }
 
 static int
@@ -6121,6 +6213,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
@@ -6158,7 +6257,15 @@ static int build_and_insert(struct virtnet_ff *ff,
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
-	setup_eth_hdr_key_mask(selector, key, fs);
+	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
+
+	if (num_hdrs != 1) {
+		selector = next_selector(selector);
+
+		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+		if (err)
+			goto err_classifier;
+	}
 
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
 	if (err)
-- 
2.50.1


