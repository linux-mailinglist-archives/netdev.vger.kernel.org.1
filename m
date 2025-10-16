Return-Path: <netdev+bounces-229871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC2FBE17AD
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27B3D4EF8AC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0E3227B8E;
	Thu, 16 Oct 2025 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F0z4ASET"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD352264C9
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590901; cv=fail; b=RaKUgAISEMPCNWCNNH2KmCDouIlm6cbabnDHFHzR+H+/tsHW3oGesIjN86NsFccklguob+aS/0dFZODCGbGJaEcPOT5/XgZOz0hdsvS3fmdjcsDjZuUGGfT2Qn1aIDhYMitS8NGc2KQIX7Cr2YTiw5x2AB6ZOYt+4+TfPuy3YXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590901; c=relaxed/simple;
	bh=rDNB0sYXhqxr/qT1wRZtzWg3md+EXNCpZncwY/IQ8nA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dt9vmnaDEOoGgLVs2Mgj5VCoP2WOe8oxMjTsT02CtDkmuVx1GdQp7Nhf1lB8ZMUFfIVSkqBBXIxjqcceMgmzVrYm/rCoapceVU64JH3cwr3kEGG3cUIacYe3RSIBSEh9H8pdTj4bMsGnlhbT78nOfiBe0wZIYwyhfVrUy5WH8H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F0z4ASET; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xidxA5aqE6g8BbRLLcbFhg0EfYgHaVcytcoSkcRCbr6pgnWe8MHTNQgv1HngNPJi50UFJFEEiWRGoe5nM3ebc11vj4Q3Na+4/8y2zqCQcS5ELJdOjXdpHFUWocTKh+k2nXBhXIlmwlkBPZBC2ZCF4NkSRk3CultHCYpMDNhA9JjHx+UDtzlatvnR4IRK4SLNcS85LCruwFPY9/KIUYrfFxE6YTGnFD5EotLsRCcuaQUpJf8cN169s46NMvu6GpaZJcXATpRsEM/pcrf2gqyH6J/Gw+6ccJx96mjECP4nYDImJYjMVbz6/gJTy/TOBz0AAtZI8KuWus2ni+jGNo3lkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eSUS2DlCIseCIcNpXLB3ipVC+e09Dy2rRMvRkrgpgI=;
 b=uC+sWZIuiLgQdv9EqWb4JLVFXGKSUpAG1rvGAXSsl6I+oHexemie1NSYI1YfD5ob1L7uavEbpWSeCYG63wYbDUX+07JYi8IXPN9rMLFqK8x6j7YjSmeOxjqYoXbzg48GaRQI04kCay1mhQmtPssCF2ZDMC0xFE1TKV2BVceit8FtbWn/f5Y122dnEpig/oaelwdPSxgqDFsiOhVzQC+/F0cI+swhglNBKovDAK8svMGyPdShHaTUYVX8/+hbaznxa3shOyWePHZOCs3f/4ccqcbJEX4tq1K478n1gggaQL0QU9P7g+Vj2XLg5vpD5RykwWw6pDI9HzoosIzlA8aBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eSUS2DlCIseCIcNpXLB3ipVC+e09Dy2rRMvRkrgpgI=;
 b=F0z4ASETMgeg1S/n1v2IpnfqwjBL/ACvPpF2IgwhG8vqSpreJrrNT1zXSGP/2CAQ2rDpUpdRYr85T7MFOXSXTwO1MTNWDiqYRbBmQS0Ulxa9CySnMV766FnIymexHwX5zZERs6g8LVr1l4/st0AfZDOwLq/hrCaTMBrsArV4xet1abI3C8P5vqADK6SL803fzpX6r/97Jssje7Uk5XoETuccj6Sq8ZmrRlu87JnOrqDj139QEQ4lfhAiaN0CMqKHdyZwEiW3hw3sEcyAa916H4ssdK4l6PnsxxaYCxzOEYWg9KC16Wv6VxMVktjsExa4lFr7mupKsVzhmrIFI2GZzw==
Received: from DS7PR03CA0240.namprd03.prod.outlook.com (2603:10b6:5:3ba::35)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 05:01:32 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::b2) by DS7PR03CA0240.outlook.office365.com
 (2603:10b6:5:3ba::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Thu,
 16 Oct 2025 05:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 05:01:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 22:01:24 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 22:01:24 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 22:01:22 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v5 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Thu, 16 Oct 2025 00:00:54 -0500
Message-ID: <20251016050055.2301-12-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc5ca20-e885-44fc-2dee-08de0c711323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ib8LsevGKWNSyoYnn0NSvCgXdtNq8/Wa3WiOx7GOSFFnhjsxaOvYegp8fz+U?=
 =?us-ascii?Q?vIpaHiym0hRd742ylQzEBHOBffl5NE3DPDP5uG9jrx6TUEHRQScxqIACOhFV?=
 =?us-ascii?Q?4rCoYVBslHK8BRoXL5Wx3R2/r3UFDAjWkLwFK5bK5XQOsWq6lScK0JWQn/jr?=
 =?us-ascii?Q?ELb1lGnfDLzZYesmdlfHYtQFypVqngpNOi0QkSFSTWwaoZmWZkdfq9pSJwTl?=
 =?us-ascii?Q?TlC6NLNT77aFOE8ljKObrFHQ9NjRJ/c17wbBuAJd3C8WByOuaLIHSz1xf2gP?=
 =?us-ascii?Q?4uFfLN0p8/BFY6AhgExVhdSEPhlho7CzA1WhPgMtrk1xL8nwQEqUqUfYsqlz?=
 =?us-ascii?Q?0fuHWrDI1S6OhO8eTUXVn7fJyYGPHh87BHL9G4Z83xjIogPnVX25/Omribkl?=
 =?us-ascii?Q?WddgqvywwcDNtSPFvJSOYyv15hlooLS1bYoE975UhI+ZESKS7AUNNdKhMEPv?=
 =?us-ascii?Q?G8hdO8glSsP0gbDvSkou/LYNEigHbnFQtFGidPQKI/5AZsIfqxdsggvTRRRD?=
 =?us-ascii?Q?jtVrF/mOJ+EVymz19gsYg8MTT80zJGNgVswp/owxi0oWoB7sd9QHU0E0uccg?=
 =?us-ascii?Q?SUvJWsU5bwaRKmPJ4+kfdtzJgx4G42k/jkPKFykpxrIRZH4kXYTydm3fssg4?=
 =?us-ascii?Q?BnqILWVw/ie3uD85mUIYwpRWAZaBpPuaajvoeAcqVWNhErVQ81cJDkHxqYrF?=
 =?us-ascii?Q?JPwKLER/rIUXIGFm7ANRobqwvu9eA43jA0o0UUlwQLWagRseRY5nqkcdf3x0?=
 =?us-ascii?Q?bRO5t4L+VyjkU75OjOoDkBKuFBjijP4J41qq8X9BG9mv2ybvpi6Lry+Ae5U8?=
 =?us-ascii?Q?wVpLO0HHKrD8UvEiLESIG4ihFDRM84TVrlRgw8OstqBXH5BDOIwQ9k/BbxSC?=
 =?us-ascii?Q?XDPmjqvuKvIsnYXLWouql7rGPWQ9KrA9/iz0qmINydNzg0miC9flT/BdThwZ?=
 =?us-ascii?Q?423XvrJnJFs0DMijfPP/Pv58OBOONjRgFrdSjRKnz7TsWxD7wuNPhFQdOxao?=
 =?us-ascii?Q?QBafEFE/OMdHETYzP4hmJ1BlWKs5W4JWA3taAMsm3dODoeu6dTev2WKMaoTg?=
 =?us-ascii?Q?GXbxlOFQPdaUNXR2+NFAsea3TJP6zdW2BQRGB1T2j+qUWYDZ3MHa513PBcAs?=
 =?us-ascii?Q?gzMmrnOPJF2V9QXYASjW67AteQVW32Haf8/e79r3uTxmHCmK0el6WXASBr3p?=
 =?us-ascii?Q?FPEapIo6J4MjJeXM+AJ2OgB5JyAAICf+XRiBf5GdLwcRv+xIVyN/IojhQY9q?=
 =?us-ascii?Q?3DA9fj66dIj6uyGMJWCPzshqMVcnpeBGpqDDWorjfUcmAXMvZiCc0qK6c22q?=
 =?us-ascii?Q?t9kdS1qgoyx1Otu/N546oQ3K5Fn1plJtUQc1toJl4BWdFSUP58CKXG5QJDX/?=
 =?us-ascii?Q?GX8fNsFeRsq1XYkTbS2VHpiHDxmr+or888ghH+4MSLwJVAgRyGpA4U/qX5Vq?=
 =?us-ascii?Q?WqpyVXrvaifwTlqoDEaS/m3f7e28GchLMVR+FKJ+JqvKJnDgKPPQitpKwQER?=
 =?us-ascii?Q?sKSPsxKf5bBAOBqK6xusytztpeCel9OcitD30ifB9LNdSIbO24a9pObDkth7?=
 =?us-ascii?Q?UYLX9n4wj9OEZrNWNgU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:01:32.4084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc5ca20-e885-44fc-2dee-08de0c711323
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

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
index f13141e9f2de..623b318e5375 100644
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


