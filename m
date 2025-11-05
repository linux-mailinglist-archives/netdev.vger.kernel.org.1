Return-Path: <netdev+bounces-236081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACFBC383F8
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F361A251C9
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7062C2F5A2D;
	Wed,  5 Nov 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ke7Q58+3"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463C8221703
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382719; cv=fail; b=Jm4il4Sim/0ObqDituujmoQ+qTi6rnbDw4TeQ/Xny0rZejTrs0RJ61zuEdPeGK7p1CkILPDtao/SNofntZsBLCaFIus0Ex7uV3UFAu3DiBNfK3a0L0awN6ZC4pAe4UFo7o7dcWY1Bm7o1bCfqNP6RsmYuSA/DfQ0Gn3V14p2P04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382719; c=relaxed/simple;
	bh=dEoMVoSAATQ4gyXau8sGRomo2vjEED+ZPPhSxW0ttXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M12ye/Z1iJ5141GFj08v2M0f2wEBIcZGpGQ8lTuutZUWsN4EMdFG5BjAv9o3Tmwrd+Lcnk63YZ/mRmSLM8tt5rBeBcpvhhZkEJ38tRizAQT0hl0wR1xevjdgBdJZ2ZMLx9GdnrajYv6i6lf4LFfRHRLDcx71AC7WDNmHYCxOCQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ke7Q58+3; arc=fail smtp.client-ip=40.107.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDDf8eNIZ0v+2z1J93roY8fO4AmQPTsqI/ZqYZw4bEq+cgZK3NAwffjSx65fzzQeaNk/4b8jUix/vWKoSdDWpcqmggmYh4YfWkr1MDGsQ496b2lDvLQSo4+5DdbHiDEuSD9CLr7PZoOO2b3NZApQjZB+nB8s8aSoAL5KiBXGDAdOgMX+UQiC/TdMKZZbqRumbEv2ASNQRs6dNgEBmoFNZvNhsgJ2yaGJDvjwBT621vv4veqjLqEYNil8xYymrwJIHGlAXMSVq1cwzeLz59IQe6NP/ySKcMEEQa71Lgpb9Y3M/H3Zf+EjMcu93KQuD/R9Q8Oh8Eb1ZyviWqyjQDmxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miAgUZfnb3hae7aFp89PQSzXzwnKKMyaLAoO2PA0W1Q=;
 b=LzIEAiU5WKGw5EoOztE0d/o863EWJBgnbA/L5vzFz8NEYYdHWxH1aZ+69wzHG8YexrAtpd3CQh4lrh48yNBgHiv6IFyAIL5Zb01bYHkWEILtjUJKjYUn4OfVaz+Ye8BwEHGSB5d0I3La+NYzUd7k6r5h8oOGYZ565DuytT1tQ+LuuxxroNE9UltFa+LGZiy7LXC1WMMivqZt49jMlQU88e5FN5EWlfZ86rUDPlb/9jUGO88V7BbPQDHerxf9dkY9LWRiKxUJDH9DfrBD48VR84zttCn5C3e4vnLlyEyJLkT93jOHrSAv1CWYUghOVZv6Wlge+bbp5k56ruUvbkI4pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miAgUZfnb3hae7aFp89PQSzXzwnKKMyaLAoO2PA0W1Q=;
 b=ke7Q58+3IkW9y2lXtYkjfNvHZ4MYUtjmi4raqDaWaPBJ1fnfSJLugv5WQeMMJf7s/HQOU0DEt3V4GaGkoDn+prl72stRYUP3+iQ93fbLpBoztuSxBq2UMLbV7/VZ07/BveoZOayvtF/Iipb38UIKnVBSU5spqtlqjTFrQxGDwc4Y8NG0xFIL/CBonG3y237dydnGHIczU92LR7LpSX3JCvY6a+tEcyZJ03svu6q4Ves+EOBpKqgFpA3GAVJw/S0yAQ4VedOmgWf0KX9HxJOiz3BnzSJEO6e1+tGyZUOPATkMJzsb5ptJN95WWU9lel2EiWAebxkk3fkzAZ4JMmawzw==
Received: from BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::17)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 22:45:12 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::cb) by BL1P221CA0021.outlook.office365.com
 (2603:10b6:208:2c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 22:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 22:45:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:55 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:55 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 5 Nov
 2025 14:44:53 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v8 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Wed, 5 Nov 2025 16:43:54 -0600
Message-ID: <20251105224356.4234-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251105224356.4234-1-danielj@nvidia.com>
References: <20251105224356.4234-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ff7462-b3fd-4544-a0b8-08de1cbcfad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IV4fTRcMA79+cBZ7M0jEJIHrHHs3Ltm/dGM0sapgwAuh1mTi1KVouS0sj9ft?=
 =?us-ascii?Q?5OUlFmIDLcVbyBjzFhMEHyu7Le5tmnGq8jYd8XZu5gT8FYxqOmp5aJ25tGqm?=
 =?us-ascii?Q?qAD0DHMdVOoY76qAgFLNxlO4hceyp4fWGzattv6AaJAzOWx3QJWuF2y+vp6H?=
 =?us-ascii?Q?hqzxMDwqLpQwFdBYH/ozzf4KqKSMRR1R9V6yGzd5mXXtNSzAec1kNyqr9XK3?=
 =?us-ascii?Q?EK8Fd7kGbngRwAvSFkqOKcheXK3WBk5W+Ex6lKH+oo3kZmPTObTkNNE3cvdE?=
 =?us-ascii?Q?z75FGH1IxcaGJf/Vw4M799geJjmchRIUxnQlOcuvFmru5f88PepjGJmg5rK/?=
 =?us-ascii?Q?PyqG2ZyH7eIPYEIojZQ5MHcjOzEzeGlPSYcaY2BkvA/EweYviQ2DGmRYwffa?=
 =?us-ascii?Q?adBaJZaL7Mf7OKe1SvxJXDlJ5VAqav/gWABaErUAISR1V840XtMVkBsANlEk?=
 =?us-ascii?Q?CwXU6AX3H86VKdbQa6sjxQpQPvurLT8R2wjBJyVB9e05u5g7bYyT/zW75ac9?=
 =?us-ascii?Q?oJ6UlOfyIdHnaVy5Zd+r7dS7iHT7k5dX0ggLFueVC12b+ji2v/z7w/IvWeHK?=
 =?us-ascii?Q?S0CuyQMPLvbiFLRnOl+jJVHnuTcP++2gPXaXiKbz9LOrpaYII4TFqwE/JP5n?=
 =?us-ascii?Q?tySnp5Dc5nx/wafIolcTb/eOFgO18i7Jg33cQw3Lo2pui7KAmSLzzaCCzHhR?=
 =?us-ascii?Q?ZGV5+3wp6YRoz6AxKFA2n9yg+zZxJvKcdH9RHvrT9zWfT/WvuemRmgi1S4Jr?=
 =?us-ascii?Q?B3B1d30X6+PJ8qah3Plrw4+D6WADthkt6c10raEiRqXQNccmOuRaXccuTbaI?=
 =?us-ascii?Q?ndHIteYnCLHZntHmPRi/IcLuDIusM3fOWBZqIwlnu7g0Xo95yKsRccsyLlMk?=
 =?us-ascii?Q?S5y0JJrmN06ditsbi7TqkYtHrMX/YhDamz6+30BmTypnaJBi9UpolLRyeEzC?=
 =?us-ascii?Q?o/a8VXkAJWk3a2tJtLyZlKtIpVnfSr0T3BFi0NdDYfj+EPViadmDdv4L4kD+?=
 =?us-ascii?Q?NJZSCx0GlKb/3DoguJ07hw4wVRkk88o8zOqpXM4y95fDuXaor2GyuA91pr2b?=
 =?us-ascii?Q?2AYmmD0YMnHOp8VY4QLDjSErfr8gf/0tXVgXTYezLo+smr763u2u5hU3C/+s?=
 =?us-ascii?Q?LkeOzIbOGqvyf/2Abzx7KCh68gaKBTe55ReLwZLjzwMfIi2LMGvE2cI+kXi6?=
 =?us-ascii?Q?TiLeuJXapZQ1fG+K+kCoqtCMNzYsVpM2vscioIsBXNI15HcwNSrO4ILNLftF?=
 =?us-ascii?Q?Tx/UAaeJ/ER6QoPo07EPnE+KitFyBZYl1vgqrt/cAZyzDDoBMn7iu19552kE?=
 =?us-ascii?Q?b8QKBjBUDgxxPurcR5krHCzQ5mrWgswC1chTORiB2lka8fGnnURiPWpiGlfy?=
 =?us-ascii?Q?gaOyEiGI3xWOqNyKPqcPAW6Lx0Svw0t9RRb+Z8T3nbwyc14xnW+haDf8JdmS?=
 =?us-ascii?Q?ZeM4FD5jvPqHFaH+4VcOEDXAKJAPC20gstY4+9TY9vpBG33O2nhfz9XfWgr9?=
 =?us-ascii?Q?GZWtblTlz4CFn/nBveaTtz2DenzF4UwOFvfAPR6mBb64Gmko7gwgzPg2cNhj?=
 =?us-ascii?Q?pv4kMHW5G3+fqJJd9qg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:45:11.9209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ff7462-b3fd-4544-a0b8-08de1cbcfad8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898

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
index a023d8936273..6bf8bc5c1915 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6916,6 +6916,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -6930,6 +6958,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -6952,11 +6983,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -7092,6 +7150,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -7134,7 +7193,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 	++(*num_hdrs);
 	if (has_ipv4(fs->flow_type))
 		size += sizeof(struct iphdr);
-
+	else if (has_ipv6(fs->flow_type))
+		size += sizeof(struct ipv6hdr);
 done:
 	*key_size = size;
 	/*
@@ -7171,18 +7231,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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


