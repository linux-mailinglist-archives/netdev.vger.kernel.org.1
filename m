Return-Path: <netdev+bounces-242003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B219C8B9CE
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4509359905
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C973469FC;
	Wed, 26 Nov 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MamSLLIr"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E8340A4D
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185789; cv=fail; b=m3ME+Fr7/U4UTOilcy8RDG8BIruuBY+FHt9IrhUX+nx9fPsXhhZyvo9MalNIkl/jlDTzErvMDwaJUmGerQWjg5gAFE+J+d/E84AfHoaPuRbaxkevHK062DTRL0yoirJFxjppkzzyNyZlDJPC4lkd3kO8s4DgGyWniOyQ9FmmSnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185789; c=relaxed/simple;
	bh=ogOhJ3x3FhSTHEmEryWi+dw7LTfCqpx0Nmt0BPX44+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZZ4GdzKQYBh0ptAWeuCKVwOhAjzghvBv/bRp9i4ozsPXL4Nb3hQi8+3rrdQUqLjIZ9t3Y+zFeAH886ONFsBltq88a442aBwJyHFqT2GtxlCIYbJgRiGT9KPmGUd1wm/PXr4NNO8BwrcjVLDz9N0Xh6QtpQVujG1ovR+ISM6j/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MamSLLIr; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKCitNLKdQI8zJzle6UmXnNkzf4sLOXDyi9CZxymov9B/TAcStDZOCD5n7k/IzTWVcpCUhGR7ezpANOk/9dhueKDC9osMmwYfM5nLO+w5UzOrM9dZDAwpQucocfsQHLfl69/6YBmCdd8BHyQZ61XJ0sEIN5bLJdaUbKpR/wcF0f9yYgdKliJ5bEmgQGK0F0sQcpFsFF5emD31Pt1a69M8D/o7ua/pA3JgOCOalnJB+vnxh7rS9ByH8wXLg8NRN5ed4MO66jqt8x0pSlUEdjNIfV4n7R/UOkl3fhXGp1LJdIpqt9G4OFrlXXez9Ki2lkInFLM6+IOX8Jqhqbmy4Xbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PFRT9oB3YYyPXbt+HdyT/fs3Zi8KusLgOY5sk9Bbq8=;
 b=DMn1AFl6IkoYQv3NEHaGeDnowHPC4c4lr9hlRhXNAc6ZdaaeS3c0UorYgHfRBf8o8QkCk6cHcshQw9U7/hlYerYSzdHOVpEDLlwD4gpa4jBcL3KCAtCTtOWASs/nwNX72aKvkvhmrAwa9q2ZMKOEk/HCQCTezhNgpHV12PRNe2WSFmaMx1opyUVjxw69Uf30aZKj31mbEfUSMrg02jUviOQK1ZnXKf4JEB3exvXCAm0m+JHhyo8uTB+AfA2kW3Oj2HeazD01WFHv3phopYV0VBQyL6PdLKN4M5z9FNYNN1bxCYpJEeqTuDtXvReVmVVkIvlbxrKp5SZL5ZFCZa3TRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PFRT9oB3YYyPXbt+HdyT/fs3Zi8KusLgOY5sk9Bbq8=;
 b=MamSLLIrGOyYb9VLOX1IGwHdGCsC3WDZqjt8T2qa8m7CxSM0uL0ZFWpchm4/u1/fK1bBgThZtNFtldeq3oJ1BhzJtiSJgNcPBddmwv2/7Ida2Cr8lAlgH4ojF7ZlGR0q9IxPNekT+ynK4knbxSwEChl7JcGBDQepjBPeBRF3/pzxZUaMAfmhIPN1OYhTLcyXFBMiTMXAKpsjtUDufqXK9ytTAYwug7HyU+caH0OTFPhxuu2egGNTIBr4P/O7lk3zbVe09IGblHDAjbgDfuQHcT33+6ZHi3R7mC+NIiQF6qAFkvrcMeG4D2FyiFiEAzYMHPcF/k1gYy1S9dUJWgooOg==
Received: from CH2PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:4e::16)
 by LV5PR12MB9803.namprd12.prod.outlook.com (2603:10b6:408:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 19:36:21 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::c8) by CH2PR02CA0006.outlook.office365.com
 (2603:10b6:610:4e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 19:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 19:36:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 11:36:10 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 26 Nov 2025 11:36:10 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 11:36:08 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v13 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Wed, 26 Nov 2025 13:35:36 -0600
Message-ID: <20251126193539.7791-10-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|LV5PR12MB9803:EE_
X-MS-Office365-Filtering-Correlation-Id: a120e674-815d-41d8-b569-08de2d2313a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?09vz1N20z+fI7SGm5SqTqgdc01LVXeNM0OAtHP8zlJqGqHPtEVhe5dXtINsU?=
 =?us-ascii?Q?AomWz5XQI1bR6D5QR15Cr0pm5rSh0ffjab9KA7e7I0hdirkuDyt0Xm1Jco3s?=
 =?us-ascii?Q?cEKNj5RR+FlAiEoo5IVSM2vGDx+IVvevRWrjWgiKcHPn1jRQjzZnno0lyZ7B?=
 =?us-ascii?Q?3mBISdGrf+1JcgQ3XLOKAPxlpu6fai3OACsTz0TMvxzfDqMTSog4tQ+onteT?=
 =?us-ascii?Q?oyIuV7hkhES472On2cls8fdZM1jEKKlGO9I9iomJcI3Hgg3buNFlZ/7uAaiY?=
 =?us-ascii?Q?8Dr/ig1H+7kybYYL5RL9WoEXqSZPSW1Qm0bdxIIieGxAFY5G32kcPxceYhlr?=
 =?us-ascii?Q?2MhnIopfERXMqfo73rXNj33HnP+NPrr/P0EPDkqQjk9s1wDrvKR7jlcNAhE+?=
 =?us-ascii?Q?MjDgFvUkRYgYw4zHl1m1WZXqJFaZhgWGOmOV/NpS5W5oOWl+RRN8K+R00Dwl?=
 =?us-ascii?Q?knHiM7qWyQxDpLfdbimGHPu1f7GAgrTqwD2Dj6h1fRI1UnyRmdcnwnGOveUU?=
 =?us-ascii?Q?GlRG1+oeoRTqc7JuENufZUx3yRO4CohPTlu5k2LmQ5k7En+Qn3RiIfzL/kTu?=
 =?us-ascii?Q?JP/BZlzI+LXQHhVHB53LBSewgGb4xawPJEmvMbYdETKiVbWFRr1hS4Uw9ziP?=
 =?us-ascii?Q?F+m5c+GIwcF56TQ4Al8W1TAWtdqAHFXeDiZPDb3QJ4FqWWxZzTUI8hNs9xOE?=
 =?us-ascii?Q?C4eYUSlhdUrhRbECINTbwB5EtxhYk05JM+CMzTwZhShoV43J247csA8ukGb6?=
 =?us-ascii?Q?YeKF9oqu25ruyNDwQEB4VUi9mDpOb1h/ipKO+zKLHHI5hNvgDIgUX1Rr+sRK?=
 =?us-ascii?Q?m041PveCIfe5dDu7eLAH70mXb2FmvMQv8BTN/gKe8JPFLys2PFqly5AZA5FL?=
 =?us-ascii?Q?6abpRWcCq4aR79Pj/lMYucZNbIKfyB4M10RBUOWNbXyJ2YytxNxFAUViQ3M4?=
 =?us-ascii?Q?N/6jYuXiFwNF7DJnhd2ujjq9q0vDRBOc5oRynXHRv25GqElvQ3TJ9964e5Fo?=
 =?us-ascii?Q?1Oin3z7CL7c0OKu+oxFYqtnvd8xpzCtbVPFFxKkkWTr7816oXyhBmYXntc5c?=
 =?us-ascii?Q?LHyTyMMMidUSVUJNVfbSohnrgxXUbtUaMQCaLUiY/BSehEAfymPwZQOOFJhq?=
 =?us-ascii?Q?wq44dMFI9zJujwhTM3Jl/37FhpcKn5gTQh1sc7i46KjrLBOIT+QhvNNvquxS?=
 =?us-ascii?Q?cxQHmkeugPA3Xrpp56YQ7AKBQBRHkgbUsM861xt3uHaxxCd92mRlboF1l15R?=
 =?us-ascii?Q?qZGlD4kC7ygEs9+FptRE35ZphOuKZ/CoXpuKlf4kNgfXgTvRYFkeFMYGAImb?=
 =?us-ascii?Q?5RQA3HfZaxOYSb/DIOARpOQSrMi2tAwpUwJlb5QfIm9hXQYRxbh3urQ/cnys?=
 =?us-ascii?Q?EDD81T3EsMSbz1x6gAyjrbVf9is8nR24QIbjEfeuemsg8Wi5OA1y9+bJqGf7?=
 =?us-ascii?Q?iR4gICuJJBnj06TBCTrP6/RmlZkcMcgJUNF5PCPY9EFWlboAYEMC+rbQPL0Z?=
 =?us-ascii?Q?Wda9FnhysLVj3MqBLLwvK/jKEWu8xVNbgEUU+f5BwrNV+oJrPbg9j75Ag+bo?=
 =?us-ascii?Q?Ffm6d9Y3rHdecZ4v23c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 19:36:20.8801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a120e674-815d-41d8-b569-08de2d2313a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9803

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

v13:
    - Set tos field if applicable in parse_ip4. MST
    - Check tos in validate_ip4_mask. MST
    - check l3_mask before setting addr and mask in parse_ip4. MST
    - use has_ipv4 vs numhdrs for branching in build_and_insert. MST
---
---
 drivers/net/virtio_net.c | 129 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 026de1fe486f..ecd795fd0bc4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5902,6 +5902,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
+	if (mask->tos &&
+	    !check_mask_vs_cap(&mask->tos, &cap->tos,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5913,11 +5946,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
+	if (l3_mask->ip4src) {
+		mask->saddr = l3_mask->ip4src;
+		key->saddr = l3_val->ip4src;
+	}
+
+	if (l3_mask->ip4dst) {
+		mask->daddr = l3_mask->ip4dst;
+		key->daddr = l3_val->ip4dst;
+	}
+
+	if (l3_mask->tos) {
+		mask->tos = l3_mask->tos;
+		key->tos = l3_val->tos;
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
@@ -6053,6 +6116,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -6084,8 +6148,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6097,8 +6171,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6106,8 +6181,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6129,6 +6231,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
@@ -6166,7 +6275,15 @@ static int build_and_insert(struct virtnet_ff *ff,
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
-	setup_eth_hdr_key_mask(selector, key, fs);
+	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
+
+	if (has_ipv4(fs->flow_type)) {
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


