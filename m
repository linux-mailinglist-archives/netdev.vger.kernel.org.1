Return-Path: <netdev+bounces-236626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE45C3E6E4
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 05:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14131188B906
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 04:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E34F2E54D3;
	Fri,  7 Nov 2025 04:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aZ2b7CQr"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841D2E0410
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 04:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762489013; cv=fail; b=eyTTfMT/EPYE0UqffbheukFlX2+sPirLUy2soD1wPSPA1hZKrgPQXDwch7I9lvkDZVaoRV3Xq+noVj4w9n4Bs3J6v8Phqt/xK2+i6NwnKh5EEcrlZkivVnPm5/p28RdavAhu1+tmzl7Ehl0K1zs8rTIZZozded6RGu4vGBtjZw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762489013; c=relaxed/simple;
	bh=M5WLL+L15YIqI0xbfUSMw1GRhDHHAvEUa24o1fkY/bM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6h+3xNpIGTWfnRtbdHM503a6vIVuyQt6uzPAiMDvQgR5wTllJpVTRXGsatUTL/ftN/IiPirCFOGZabtM3Veh4jxOsMDiT/DFMJA7yPLbEw+1TKmuyFQpkfczpfilkmnHCzdgwHMIe43KZRVVIeacZEagdLLcsbiowc8qyKJ4X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aZ2b7CQr; arc=fail smtp.client-ip=40.107.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6HA5ybDloNgLjk4aormQvApQaDqfy5LFUZABOYkCjuYhSP87j2atqbcPIYVQK3q9h3ZHIM+n+Ik6qhirU0+xO98taYc8jHX/YZDDV+5sfXXkV9WbXeDA4HEK5PN4hUxtyA//nf1NLHKrpZ3OTFidSEpGqLTltWAxCdASgvjAQ910crZ1BVcAIaBzb7naEamI34nYe1N3oLN11DWjK1zjR2eiGH2kVylc2mo/vL6FkpEGSKtDOYVIhGJPAYX+GMTjeZJeEFhH/916YUFFavyALWpdCXySR06vxV41Ruqc6rCe64AD2DeAAzlHR+R/USsZZt86nxRLDGAoVCq0SOojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuAM4be5PjgSKKDdEHOniQyNDUjimunEQtTCa9Amtuo=;
 b=bSGZqXdRYqPMG94MnAIWuDqwDrkQ/nIzLwqrTDFhwjpNJ8Gc6HGsCxTRfjC7emPhoLYXmLS8jf91NHbsn0e4pDi3flvyYLS+KuEywtq4XWJeN6Amb94/D1LaWAf7rz6SgSJ3Q34qA2R1LBTRfalxxTR8ig52QdCyfKnizfSjoHlHroU22+RLbdzqBYA2y6kTgSOs/6kNYk/vbElTUUWJOVUYj0z2sKcaE6nq8w1Rjyk5ITSfZrbX0K4mmo1VLxlj8PXmlJrjOaDoUBg2cgqs5X+6xZXYo2EBdU5+uUWB8SJHDs/1SLu1KiJIwzbjcHLOefH2UrOGUwDMK6dno5Rp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuAM4be5PjgSKKDdEHOniQyNDUjimunEQtTCa9Amtuo=;
 b=aZ2b7CQrMU7LVkAawxsp0LxtKzujHTW7E1us2zNh3C+XKR9RslzzyGps0Tj/1brqHhfifdEBMe3EpS24jy/A76FqsXvmOLoBLoVw4zQ8iX6YN9OXFHkfg4V9agMqplHaRMYQOeAQzwo1T+hfMS26OmfynRjwfNtIuEi6sxheMMhf6XmpsIAaMv4mt+pTUz+3POE1U8p45EyQqQwFarRiYtbQd4omM8PgeEuXoAAAwbKUzlq3HSvoT9bVT8FkZiDC5QXkuCieOgDcHFyVQryvhV1FcCrOq2nW2w0fHV2sTbsUYtnzJ3jMGWfbNw1cFZQBSsXrp89izCgRLxcSDJKfSg==
Received: from DS7PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:3b8::20)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Fri, 7 Nov 2025 04:16:44 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::31) by DS7PR03CA0015.outlook.office365.com
 (2603:10b6:5:3b8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Fri,
 7 Nov 2025 04:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 04:16:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:33 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:33 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 20:16:31 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v9 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Thu, 6 Nov 2025 22:15:21 -0600
Message-ID: <20251107041523.1928-12-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: bf793585-48c4-4d97-d640-08de1db4761a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?46HW/V1wQjSLaM0OFEl2u35jM9eO6ashexpeckG0UUeYd43txdm824t46Wxy?=
 =?us-ascii?Q?vOtVmpUNnFyqF9b308jTmRMy/gYe0cSVXgieTU/6HPjVhX2HSUhd35jvQ+he?=
 =?us-ascii?Q?6+44oLnupqNK4gb7h1JkCbU4OvdztLSBU9ZzVuULDK2Q7AVOy6ik6jbhZgHP?=
 =?us-ascii?Q?fO0kMbSpzCHk0L115LQbOiqu5ubEephj1n1mfaX4zuGsrbrDTU0zSm/RbP5I?=
 =?us-ascii?Q?eApf5Fg+Wvg6IKMno50lB6Z9r7dJnlXgLdoaBWj/UPlGr0mgtvl+LVxbad5p?=
 =?us-ascii?Q?YYreytENzNTZK9yFwFGGq5ouGnbhjpVuVtJRiUumPH9/Ng2NW6BXDt5+XK+x?=
 =?us-ascii?Q?F50Twj5KNVhWgduNcw0a8ssAUO7haArOZqOkf6WP73jWGpc32asAocndfdxm?=
 =?us-ascii?Q?Ka5En13L+12sAvQ1JtkWimyoIZdwiQtw09GEWZUoHay1/x9UkVkMRC7lvPSN?=
 =?us-ascii?Q?+i4HhQthV1ylOjJaeT5JhINCtVErB1FIXkeXtDyXbh/OtajS7zQQ7mBMJ/bs?=
 =?us-ascii?Q?yljl2JPPdWUfPY1zoKFy5BRM8RaGQ9k1d43g7kVPrRlF0bDJDLlicZKqFkg/?=
 =?us-ascii?Q?PmD5UIidrSWUFzJznw5htCGy7TFv1M+HejkZlk8oYl2rcNxiWBrma2BnO/1n?=
 =?us-ascii?Q?uNIKgdtc1Je8jXWXULACWjm6Lr93BA12BnGYio4/D2HW0iTSgfLiT6tjziJi?=
 =?us-ascii?Q?BEsubLp9myDFvFz1l3LMWO5gHW0sY3b/z3zJ48XSpV/bwbyXoqI+h9uG9iLq?=
 =?us-ascii?Q?pCq47fWRgkAxO30b1fwd9HekauCg7bFJAo8SUH5TuS4O6Ec+T/X9By1jTHUz?=
 =?us-ascii?Q?LgScXqDzTGiA1wBa+6kN8TvaKGYdNzX3+wvpFTkjNhhAx7e10jgqUitdxlc+?=
 =?us-ascii?Q?oav70EuXpcQsMfLLbLYsqa6XhNdJiFky4XwXZBYCvyOC68CBZ3I7JQCIaBdT?=
 =?us-ascii?Q?8mWcU1VNV/lFeSwzPz1lZiEKe+CHZc3+NeFNwNcbn6G2vWVa0R0lQroyyvNg?=
 =?us-ascii?Q?xua6YpLm8P4kTw2v/RzPi6H7QbRJ5lkiOqMvQABsqOnHQNlmeCsdDEFcXzRJ?=
 =?us-ascii?Q?3t/DQWIIc0yg9xSFohmOe/S0kyCG2JQWaphIdc01uKnvkmxkUAdP2TUJnaiM?=
 =?us-ascii?Q?LX9a3+p82zPp4G5UiTS4XQ22L/lanl4XjLeuQIIAESjgTf9l71GpxAv7x2jc?=
 =?us-ascii?Q?1H4xOeTnCt3vvfHXM49LESbXuiznWeu7x1b9stehkmB1OcQGz4oM0QdK2lDL?=
 =?us-ascii?Q?iZtdsyFD6VRf4DzqsH9bAJSScWcsTHf7mKuMh+XU6SE7dD55SBGXgDVL9+cg?=
 =?us-ascii?Q?eQBp6DUVcNIlUNEaEdcn6Q4LsTrTxiRQCwV5y7WZ2feLOjXaEZZFCu3OvUsH?=
 =?us-ascii?Q?5srvlHW/mxOLPuYH+0oR7lTuonmCJyNklRcQYb1QKTuGfugiEMIpKBK+PyF/?=
 =?us-ascii?Q?PCgpQljml6QsIO373TgdQZXPw3myXnR+cbpLPL2+/rfK2FuzJ2x6BXLYB1ti?=
 =?us-ascii?Q?X21wQ1v861S0BQSSmT5l+oALehIElkKfn47eiJN44lhxi2c4HzNc4HuGaFLW?=
 =?us-ascii?Q?F8p/WqvPei4F6xonCe8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:16:44.4896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf793585-48c4-4d97-d640-08de1db4761a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472

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
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: (*num_hdrs)++ to ++(*num_hdrs)
---
 drivers/net/virtio_net.c | 207 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 198 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f0dba1ccb6b4..576ce44d7166 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6944,6 +6944,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
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
@@ -6961,11 +7007,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
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
@@ -7007,12 +7087,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
 
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
@@ -7151,6 +7245,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -7195,6 +7293,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -7229,7 +7333,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -7240,21 +7345,93 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -7294,6 +7471,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	size_t key_size;
 	int num_hdrs;
 	u8 *key;
@@ -7327,9 +7505,20 @@ static int build_and_insert(struct virtnet_ff *ff,
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


