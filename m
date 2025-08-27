Return-Path: <netdev+bounces-217416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30031B389C6
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D50D7C3CC8
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DE82E7BDA;
	Wed, 27 Aug 2025 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XqL3xhyM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229182E7648
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319980; cv=fail; b=CrJ80XtlLi9xPSHG/DrOq087so64/llL8XQZY7hrsVpYHScKnZbwQCL/PXuBBpUt2bwrZWcvCn+7u4hnBVNINBv0UjjMBLlNoUmr7l4Kq/caaSEfuzQYfosUhGib7xJi+AXWa5dinkpzC/LVfPpA51HEvwiLrcOdnio8Kjjwgnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319980; c=relaxed/simple;
	bh=CJPH7ZuRepEAzAZkiLB/AtFc7WI1uT7k+BqgDsrUql4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCnmwHaTRmJD8yRQi/o4Pwgi0hRaG5LmSvn/LnhOqpxryUmje2fPo1rzyiBzv0R4lLEWUnpUf2pE2/pHnYRojbQ3Uk8pB8YguRGTRYZPHH87XAWtu1OFbv8/gsYdU2VzyOTPrFoJRKZ9AyNj+68hfJshI4coUXd1NmmhymA0uM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XqL3xhyM; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdKI5IT77iaFCBAGNLyBnJQTKRnJcsqG8OIxvyZJD8Uz1P1L4z6uPzciBBqgfR87yO1P0eMWr5IM114JM4c7R7LSVpDaLyXZtv4zO8m24Aasn1NQ3Jg1aW5iQ/L+gCFSFOsQNJpKgZ6cwMS8DyxhsUJFMGDABXQAwqcA6bRd7MH4CgfLrthkgPlld0tiEj8vnlBDwkqi/BEZuzIAiv0kwNVwAU9z1tRbP/JhLchDuri6L0F//fcwtPZQ9IW9pkKJvunvtuhRTec3R/D9C0M0lPneZZoOC1PeSGAVlb9q2hfqb0WQ7XRJkM7VjNnQU2OaeOSq7k0RRj09Nb2JlIao9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBuNw54//jac3D0C2WGk6LHamjqqPX9ExxHX2mOyek4=;
 b=Ma8oLKZm2he4JBLjez13veR3HJdgquzzL5CtSCVM7V/8R07F8TlwpVCAaazjCWStMX8Xx1GcJ9fzZsUpR/Tce0qkvbT3mwdyPLVHvGwf5W5ueZZ0F1Mm6FFq5j/R7Y47iTZs49xhMG10NmaBG6gI+hPqWkZwW3e8rKlFCNM/N5xDwg8incfG2N1H+yv5Jc2eQfU5RUllnAHT0R/gbrQUEex7T8t/w3iiiK2BPmrHDkEthmx4dOXW+bmPkWUPime7q1mo+E+Ifa4jIzMjcWdtohcIMG+u1PBrb0R/c88irq9hQjYnV35yJfxlp2kuV8b/y+bWgbzyYN7tgjXm6IN6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBuNw54//jac3D0C2WGk6LHamjqqPX9ExxHX2mOyek4=;
 b=XqL3xhyMiZUrDcMkpDhi7WKUjvu18yvweDqQ1Vxgii9nXzkV+aIp7ZQIZVij/iuTdALGn1Ea45kk+MAVOBAZzIGP7eBqsGarHpzIh463VkKpDwXrScgePHBCje7pL9qgPh62y3zPdeHeqj/qYqkxS+j6qNrJuJFqIm4xuT6BDqY1rgrqm6zi5m+u6ft4Wk0bTBe7PHr61QYI///R/B8dgCGaat78CjLFQATXu94wLmu5JHeOfQU5Mo2S5gFPUwjXwzY1Gjmsmc42QtQ+Auu2jzwBbcxvwz0FSZS7gRBTew4JauuIIzoPePvg+Sg94Esuugwx/vGGs7pzGWkf7V1fmg==
Received: from MN2PR04CA0011.namprd04.prod.outlook.com (2603:10b6:208:d4::24)
 by CH3PR12MB7715.namprd12.prod.outlook.com (2603:10b6:610:151::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Wed, 27 Aug
 2025 18:39:33 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:d4:cafe::58) by MN2PR04CA0011.outlook.office365.com
 (2603:10b6:208:d4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Wed,
 27 Aug 2025 18:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 18:39:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 11:39:13 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 11:39:13 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 11:39:12 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next 10/11] virtio_net: Add support for TCP and UDP ethtool rules
Date: Wed, 27 Aug 2025 13:38:51 -0500
Message-ID: <20250827183852.2471-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827183852.2471-1-danielj@nvidia.com>
References: <20250827183852.2471-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|CH3PR12MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: b0848063-e450-4231-5f23-08dde5990fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wUCGzOAhPn+6lL5J4JQ2t8I+3z2tecPXZzLSeKdbvQJk+55HUFulJxMyvL5N?=
 =?us-ascii?Q?I1/MpMW/yW+C0u678Uq4n+GofQ0xo2lS71K/bRNDdlboSNPtWURDMl5rbj+Q?=
 =?us-ascii?Q?M/4LAFMhiGyL8WG9kqqso9OAQxvxi5KdYn3/BENtpPNHyz32+lwFoSYO4Jek?=
 =?us-ascii?Q?5iizwcBfXLQGLrEA4tYtsIQWya75pz3DkG3YwvZ3TtPF/PbM8Bd/1i0dZ7OO?=
 =?us-ascii?Q?NAQ0ma8JrsI1S3/M4swIJJeu6GxPP+s02xXlM+Onn0c6IGnpc2dFlQ7ePjFS?=
 =?us-ascii?Q?epvjdhMzm8UC4lqKkcWUPHtkwSuFWhxN7RuO2BWk/eFpk6Bb8F+Ze9zZu+G1?=
 =?us-ascii?Q?8P8MIGfTfxaE+dctpW9yamHYvjICRB+BgOx3dDpbIP+OvJVDJ6IrGGvrgMRU?=
 =?us-ascii?Q?EtRZj1pBXw724c2A1exX7whyn7z2lGyewLomTMcnlhw63IXtGyG9deyj+RfP?=
 =?us-ascii?Q?H7blJ7Nw9Fj+xSpPq3hilIKL6DwLKW3akbP30Kb2Jf/ZLp0NjoQxBNzixiNj?=
 =?us-ascii?Q?zpizh/iejF4ZHfh0ShtjuX21Yd98RLYnc2XcC6mgY7O/aZIvS+svR17BkK04?=
 =?us-ascii?Q?isGIUgpIR0Izx9z0K+u9ZNdlYwfHhOS8QA+twdAY5cDEqTnNgKcTMMilFZzj?=
 =?us-ascii?Q?BnOS2ekvj4ApyoACcr+ZEurLg3VBn2RJagX6DXn5g1iOV6YXHeTAIsBMEvU8?=
 =?us-ascii?Q?SaGinBqh6orl6blZcEyXjVD6lhKI1CJ+xKHRzHdlZ2ckNkOq+1fVymtsnTHe?=
 =?us-ascii?Q?Lo/Abl9r67uQxrTmLiPbGskbCc1xOG3k62uP+SS9RgHLfnfvp77tBh0xzSW/?=
 =?us-ascii?Q?3o4+3w4DcMbl9b4jGEeO7OLWkOu2I/oBftaCilrYvByqScSfXFwiFvL/xKe5?=
 =?us-ascii?Q?XDqzMNQQ/VFg5qEqkMEPvlkVzxG1BJ60oLV9+qIMzUQ6WiZBUqri1p81pv6b?=
 =?us-ascii?Q?VWSBzPCSJCCGIRrIjrw7Er8M6c1W/Ubs/MJo2T063qvPnDXCnz9qbiOuKjri?=
 =?us-ascii?Q?+Z40mgW3tf04oPVzXlc/GO7YjlsaWCVMu04mWFycX4TzQVDwBjt0O20B/GpN?=
 =?us-ascii?Q?/uuPDSOSJZT8fJOm7UG9x96e69/FIO4x386L7eR2+eeD9MT3zAZ1h4KWA6UG?=
 =?us-ascii?Q?ibgV5PDxrJ3sGr5XQik8niV9fQ1SVH2403kYEkhWz7L5LkD45smf5DOTo/cH?=
 =?us-ascii?Q?hAohj7vrhUTFRdFVKr/BdsGXsgoB2lGDxjRSqSdbfEndQI1q3QVa77Tn+t+9?=
 =?us-ascii?Q?6xCskzWGcaBT45N+e9/8XtUIkmvdkBUGrqN5mIywsAYcAnY7DodYXNFwpe5z?=
 =?us-ascii?Q?SL3wlD2l7TllBEwSwnWLOnwJolHnpUT2Lg0kZs81RIzRuQZowPyHbI1C03Fx?=
 =?us-ascii?Q?xCYEvAalWMHcYUzRsK1eSpcj2oiAhIqTGXOrqjjaoO5146JxC05F7dm3YKLe?=
 =?us-ascii?Q?d4TNTXQAO8VaLBFxmvg4GTLKjaINVNAb/CVWbiyXw6zxkhy5FFExqRlGMD8w?=
 =?us-ascii?Q?4fJNYGaTwLsddtFOqXUDp9LaiPsOnB7BXlxf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 18:39:30.9752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0848063-e450-4231-5f23-08dde5990fa3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7715

Implement TCP and UDP V4/V6 ethtools flow types.

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
 drivers/net/virtio_net/virtio_net_ff.c | 207 +++++++++++++++++++++++--
 1 file changed, 198 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index 9b237a80df39..a1f5c913bf08 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -146,6 +146,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
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
@@ -163,11 +209,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
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
@@ -209,12 +289,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
 
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
@@ -350,6 +444,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -393,6 +491,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		size += sizeof(struct iphdr);
 	else if (has_ipv6(fs->flow_type))
 		size += sizeof(struct ipv6hdr);
+
+	if (has_tcp(fs->flow_type) || has_udp(fs->flow_type)) {
+		(*num_hdrs)++;
+		size += has_tcp(fs->flow_type) ? sizeof(struct tcphdr) :
+						 sizeof(struct udphdr);
+	}
 done:
 	*key_size = size;
 	/*
@@ -427,7 +531,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -438,21 +543,93 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -495,6 +672,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	size_t key_size;
 	int num_hdrs;
 	u8 *key;
@@ -526,9 +704,20 @@ static int build_and_insert(struct virtnet_ff *ff,
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


