Return-Path: <netdev+bounces-240125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B26C70C59
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63DC5355AC4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8DE36CE1F;
	Wed, 19 Nov 2025 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R+u4BWGA"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602F36C0D5
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579781; cv=fail; b=pppG0fncJXXk2ZsEUTZUR/XsDGtdRYGgUON3Gjoo8lRCZM8FOynyvgB+lwcjFQ1gn12YoWJhsuu/WRKv3g5CviQ/33E5oMzIfRPewSNUg3yjXG+qS3lhqWB5+za843ZANtEcWsC1jtVDoURYrUU3xDfYUme9qbHKlrhL60UBCEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579781; c=relaxed/simple;
	bh=+tPfYpylCyGpDfzRZ2aVdeQ3wQlnE8YXMidsZ6wmMbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpZ322LRjOPjaLn7NS6BNwH2bYmaerQP3F8jvgwhl+v0nTNEUwksbFBwHm3o+7L9qAOH+hV1mGP22SDaqNKn2jm9RMxjQ/NkFXt9guJ8+x/k54YwtHpxp48KRUiBJBWMANv6IOQz8OLRe7HbjCdum+nN2mTyrFclhJhkJTsij08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R+u4BWGA; arc=fail smtp.client-ip=52.101.85.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yycV4FWhuZneTfubPOZOeqM8xG6/DVouTF8GQbw5lKXydTFERVdQCYUYa/ZeS5f3Jjd4uODhoZk6hcT31EUCrTYieRwcj3vdfI51XbX80N+QNBP/0WOBgkVuVMfjH0TAZkGSug3UZzZN3cT3nzLAtrzFr5IPiQymurrEaagTp8rrPniIC+67pxMIjJW7owUcQkJIJ11ldxgC6bK8D6e1pcw9cgTyruQy0feIgouw+zcmVImBmThaZqdDn3lQhIImntitugktxR2mf6oyhX0nRcOARxlbq9ArL9Cu5iFSLJxmrjZ1s/hsKT8InIBSREk7e2DK75RSO+gnL958dwsyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzS4Xi5gc4XehvpXjW6Vu8WdSlpbb6hBdCZkhjV3+ng=;
 b=NtEwRJpiLe8kgtwxx4cvQLKk0v+86goVle/+P1LcDFDM3pRCLMDHvhknkkxe1AbbgZy66RdG2QRBPtGohjeU3wilNMVcJ9b0q4cWyWoYkEbO6B6jY9+X8n0Qu7A1KIievLixeAxME/hwjS39bh32QCCyByfsJ+Ijp6TWz7No4WNgkn7lsIUZuZXhRjkghQs1kfzdFOnrKLQsddqJIeCGc5jdBgU+cPugTUTpfTwIx0JiAoYKCpQ5iIMwwP9mXu8iez4mqSe5pnQodsEU/HKycIKKsnXkCD9oeWTA1py7L4dLhNUzUdBHwXmoXgH7lPDTBIiRmdmD6IXjZg2Rmk80pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzS4Xi5gc4XehvpXjW6Vu8WdSlpbb6hBdCZkhjV3+ng=;
 b=R+u4BWGAx0D7XZ0hkYJalVctei+tak03onYqch2AIM8AZkPSMs64b6uiadbwN0IwhRlYMjgM5oK1XJFZop0ZdaED3jqHLSJ9+AX3ISvqKT+tz1IHv2IDMOxHoZ1PcozSD/T934+Ve/EXn9+IciqEkOfRfdWpost/0TEzeAgVlXHXI65jXuQeH7shzwOep+rZduPItBkBkkcswGuROpdT8EH82TiiEO2FgZgwHD8vChvNOSz0smVcVPY2mFA8+pHfAUChCJaA+YQqRk8v7oJ2O8GsM2/huBPMPc2vy1kJiEDWH7XLLV9jJcsG7Ze7/SjpReY4z0bw/5ApnJ5lpiD8vQ==
Received: from CH0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:610:e5::15)
 by BN7PPF7F4CD71A4.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:16:04 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::d9) by CH0PR03CA0250.outlook.office365.com
 (2603:10b6:610:e5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:16:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:16:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 11:15:46 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 11:15:46 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 11:15:45 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v12 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Wed, 19 Nov 2025 13:15:21 -0600
Message-ID: <20251119191524.4572-11-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|BN7PPF7F4CD71A4:EE_
X-MS-Office365-Filtering-Correlation-Id: dc449a02-e7c0-4b36-0f88-08de27a0157e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S70toYoh55ESnWbRngCQ5CfiI71hxC5f0NN0OlnVP+XIwqPLA203yFMGin1D?=
 =?us-ascii?Q?W4cdqp+D5AxvqN2l83uyFrsWrrkR8BWQc9riOo+c0Vi5FlrnDCexSyPsoFwx?=
 =?us-ascii?Q?nCpuP/dGpuGuWKEP0s8x86fPXN6arCUQJ/H8TgwHxsl/UHSRQXuX2M0/609g?=
 =?us-ascii?Q?+9N3hxBxQ6S0G2kssk+Jbx99PlKfpCJKYM6tU7v9APSJdF9eWj9c4z/1/Ray?=
 =?us-ascii?Q?Vc1OzCJo9HTXBo9aG7ErRuSTuyQVxIngKPJgVDNZqO5PVd4fzy6vqecdo+0M?=
 =?us-ascii?Q?jG3G/VcHwVDeQqygSrCop+uzqW0p9CiTRb88hD5eSaIwh4+QKg/IzVV6nUJZ?=
 =?us-ascii?Q?VMg1B50W1Pv3mn2j3Ri6wgcbFy7fxOef1VdVsCx09YotinO6PE/GJYBt61YU?=
 =?us-ascii?Q?TFuGs8cveDmJGHVr/jSiIXxxXal+bFFJRNTpb7Hv2OLMPf6zfQB0vsVusltk?=
 =?us-ascii?Q?K+YHCIIso7G7CsXNZ1ZRvmRGTqpCtQzUBhx7hnlDMlUZW7LIr4DOhXtPJZU2?=
 =?us-ascii?Q?0THGyxrBDUNs3r89m3rCy3WKN0iQU2PElRyJLre5LN5d6p9JjienvKS0EJKq?=
 =?us-ascii?Q?Vjauh+pjj2N+dVYp7b1LEQlBGp22qwJFV0q5RpblaVi7na9ksD/tM5PSTZrI?=
 =?us-ascii?Q?+7HTYcWdUWu3CGknttr58h8l5PFLR+xWML2gWmYz6uT4NSwNXdC6G9HY7ecj?=
 =?us-ascii?Q?MLq26g89va8LqpvKBBemxN4HedI/CVQEdYWDugW4MLOzVx83FYlAinkm1VN0?=
 =?us-ascii?Q?Xu9+Etm5xRiZIO4HPrXehH+ogm1e8i852H3vaTyXtqPZdqdKr2HOPPUrTW/O?=
 =?us-ascii?Q?mOx5faR6AzO5CllBo4v15oSlc37HfWj5kTXmlFY+JXtNbQhsYE9yTfFDXk+L?=
 =?us-ascii?Q?GXtBGa9IPPH573LarEJqLhu838+E7aJkcw6poTvSgus2VmJN7MY8zKJk4BUz?=
 =?us-ascii?Q?7cxUqp8QAXNVz6cI94wH1lYgnrqyNIJprxROg2aWtIMr9lQR5Nzmq3WzCvtA?=
 =?us-ascii?Q?/tS/alsjFHkUxe4cZFH+joCJgeAjS1xgMhVggqjbsaaZkCIGDY+U/HfCxnba?=
 =?us-ascii?Q?hNZ3sos0g+ujOleb4j9dFk5P+4bo8xMuMdbcbP6ITngn6SExPBXQ0Q3iHIyN?=
 =?us-ascii?Q?x1OPa0vMVe6pKJmG/aEIxe0AhdG2TvppReK6pEHQNvTabZPsAO8gVc95T0FC?=
 =?us-ascii?Q?xN55ZCPqZwFUKr2ARfU3t46Vt7il72iyffHEDrDLMrPIOAV1kkD5kgmdDhgK?=
 =?us-ascii?Q?MqfFDe/uawqEv+OmWMCipuwK+ZeziepjJCm86VQ5X6kwUCduIk6gCZwScftp?=
 =?us-ascii?Q?jcXrnxLQitGqf314uaE4ZvdeIuJqYxgGWl9E88eNzHGp4zeNYG0ZBv3DL9zy?=
 =?us-ascii?Q?Bu2OZEMhn+juW/t+rqYnZhPq24T+20dzjnq3EFSkZ9MSiLe08SugrS3INI66?=
 =?us-ascii?Q?0Fqaom1CW5qBIcpuIIHS/WK9V2TfkdqWOpKrOhaAlAJCPj/0rgluEZbfSuyr?=
 =?us-ascii?Q?gw98j7XtAnX6vm/5RRv2IHYiJLZ9wTDJKivnbvR2is8N37UD5sUHdrM++6I3?=
 =?us-ascii?Q?uIMkFBvYscy4kNvhOvA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:16:04.0615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc449a02-e7c0-4b36-0f88-08de27a0157e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7F4CD71A4

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
---
---
 drivers/net/virtio_net.c | 92 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b0b9972fe624..bb8ec4265da5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5922,6 +5922,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -5936,6 +5964,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -5958,11 +5989,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -6099,6 +6152,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -6138,6 +6192,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		++(*num_hdrs);
 		if (has_ipv4(fs->flow_type))
 			size += sizeof(struct iphdr);
+		else if (has_ipv6(fs->flow_type))
+			size += sizeof(struct ipv6hdr);
 	}
 
 	BUG_ON(size > 0xff);
@@ -6165,7 +6221,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
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
@@ -6176,20 +6235,33 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
-	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
-	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->m_u.usr_ip4_spec.ip_ver ||
-	    fs->m_u.usr_ip4_spec.proto)
-		return -EINVAL;
+		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->m_u.usr_ip6_spec.l4_4_bytes)
+			return -EINVAL;
 
-	parse_ip4(v4_m, v4_k, fs);
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
+
+		parse_ip4(v4_m, v4_k, fs);
+	}
 
 	return 0;
 }
-- 
2.50.1


