Return-Path: <netdev+bounces-247405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB9CF9768
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A106301F7EA
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A4133A6F6;
	Tue,  6 Jan 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EoRyhD8h"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C563385A9
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718333; cv=fail; b=R9mUji386zzCoWBo5WyUqLLf7NHR7PNSduGrdq+XStcqJhxTcblviWyBzu6Uk1OprM2zIdP1PfQR91HUQhYSsU6kJydoThi21+YsqLhmzNpVdhsylEYkUzhJZI5wJoizv4SVYk9m0LCilhrfq1i+gnhc47C389yARjSSx2H9dKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718333; c=relaxed/simple;
	bh=jxPg1hr+SnM/ZPcvDQGqCZKK2X4azdrEWszWK5COMi4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJtyG7aRW+O9984VnpchLGiO9VEsk+nxVC/X7ysmYWuNXCyXJaur/n8Ur8ZZiXsEhLZxaEeNH9UidqRWYO/oUeVi5q9Q8AwRtRq6hnK+oNpePZeS1iekddxhEwYFOYbRIu3BlVj12/jAi/eQ0fuixAix7/PfbTOpH4yp/at+ZJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EoRyhD8h; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTQh0WopnJnr5ugZ3DEFq4al8LsJ/0FLO0u3ZAj3SuheSvnjOG8XrB58h19lZrZ5NZmoz9x3eykywBm7ADmNF06K+n65sYMHhSrrT3tghfRmshO7TM+eayFPhWTibRlPb5ERBDRlmVcEq0KMxYBgK5lSOCAJ5IjOgzwBEDo0R2MxelEI5l7iC9KJja6xjW7/c6awncYbQtXUZiQtVa2bzIGlS47+bMvLCDDiCwmUVHn0AvLqNJUJ1KkBrwr6LjdlXfHtKboRUszWJxZU+3+3rF1kA7oiuUdNvXGYidy17iL4TR1oboaf0wbdcSo7YvXEpAN3CqosyPVpgkWvUOEgYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRf1WMESBwtFNgcV4CscYcJTg3VkPe5JHriPhFE8L+0=;
 b=dRubpMqq7+PLt08RNjhlqIvqv0jFa28/JLpViNBZhEtFISmoPvmRF2yrsMb2NHWolM21zFq+MHthgC8QjyGfd6Vao077SmcOr5UENu7hXJ9mJAn8IKG2/ESx+IomvAbvTJGECvRzdIB+GuiDpXKfeYb7+r9sgukq7ktUkkrwsuk1PQ4QtaKaObge3eFjVcUNO9bF0mG+cPCMpR3TfA7M9G8OMCEPb18VyFevX8dcM5aPsUFfEu+TByHmlNIK2aqREjre/uaDKpF54+0r8CvM2jLEY3grRavpw8Shx7Bn6mnvahbeIBSyQoZ9FlAsMhHclIQUL7fXrPCTB+sfxm4NbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRf1WMESBwtFNgcV4CscYcJTg3VkPe5JHriPhFE8L+0=;
 b=EoRyhD8hMAfOZM2rvszeyFw6uMrAIsGgvRADwE1sSOO+9lD+EIlRlnZsjBx2gRqTE7pMKOZrb981RkYxRW4FSmPw4bbsfBCqbGhiw3l2eic32SxbqxqM3x3rY+eZoRsr0Og873HIqm/Nm0cGaxpSEcQ37EPXnjm76+ekp74JpJQgXqjoo4LNj2s2qaoX3NeU4D/0a0Ty2mQ0qC01FV4vPhBu6MRL2jFDgxauCE9jAXQxdSwZB5lUPN4WJqplFfTD5GTcpj4QzwiZfDqizlR/nYlFdGOw3IRAwUnyTQqbuACjaYJM5G3lhSLDq9kUxiXgDBHFDXhrF+sPHVPhGuIarQ==
Received: from CH2PR18CA0035.namprd18.prod.outlook.com (2603:10b6:610:55::15)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 16:52:02 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:55:cafe::ac) by CH2PR18CA0035.outlook.office365.com
 (2603:10b6:610:55::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 16:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Tue, 6 Jan 2026 16:52:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:42 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:42 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:51:41 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Tue, 6 Jan 2026 10:50:28 -0600
Message-ID: <20260106165030.45726-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260106165030.45726-1-danielj@nvidia.com>
References: <20260106165030.45726-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: c58592f7-a3b5-4b6c-7231-08de4d43e99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AKsW+98juK76LirvJZThEgZRMks6Qfm669UtiuDm2qSl6Nn7VTC+lQ1eW8r3?=
 =?us-ascii?Q?Mrb2+VDqF46KWFZE2puq2ynBqBER9FbncpqOMLSF8QoZ018f2BdvDSHPg7Mf?=
 =?us-ascii?Q?orRQ9yQ0VPsb2DbA8KzJ0fBwk3YuJQQBK/xmj2Q+rwJgZLSRIEpRq5QsY/VW?=
 =?us-ascii?Q?IzQyebKXgUS7Gx9y1HBYJfQKP2c3pAPT27/ZFBdIGsYIP4dxJ3PyYSr4hMkj?=
 =?us-ascii?Q?Ys/IB4IRHDhTOAS/6DtOTzrr0CETNQAJnOo0XFzUjP5Yap77+derDD67vi7G?=
 =?us-ascii?Q?dcftx1PXLujPKUVCD+zI+qVADYkH7Va2wGxmskB9wf/POjU0ScLPFLHCgwyy?=
 =?us-ascii?Q?mIk1XW1qaL/5vaVLVr8hfJbC7tw9+3fRKtPnLz/9SsvWgtP7M9nKbJL7rG9L?=
 =?us-ascii?Q?AlAn2uYY6J1tM7wniIHucK8ot7xCqf/U+msXMyL/gOjb1nHHpmvoKWT7VvR+?=
 =?us-ascii?Q?YBmb8Wa03jne2QiY3l/CIXRYP74b5nFk9H0pdpyGeaFG7lCy/boUuVqQ9dek?=
 =?us-ascii?Q?fIar9MalSfD4pLkyjmLaEExTxMsJ2R9sSpIZ5BDKwUVlaKITSw18d8Me5SdH?=
 =?us-ascii?Q?5p4bgEDEOAa3LDo9Q0eEY3ogOvhPYIF8GWaNPmtdTv9mSFhQ/1U8ZedkKvIC?=
 =?us-ascii?Q?jspWPScDO646Ju2SCHimCd1Ru1ioJhE/yTAN9dOT9S+T1aAzpjlOlo4AOO+0?=
 =?us-ascii?Q?4F0eHn/d3K0SjvhW/FtTzsw4vlUgtMmhAtcdXIpN1hix64rPdrxJCUB7OzDS?=
 =?us-ascii?Q?C01qfoJ61qCgiLiXKnHJ/gSPnILAKkK8uj7USdywB4knq/eT2GFJhYl69Qa+?=
 =?us-ascii?Q?SZXYvMcs+z8t5WATtGeZ6qaa/nFVyERQ/NTztXs3/Qg8vlMA87bJ6I8kVaVF?=
 =?us-ascii?Q?mB2fE+i+BG2pEgJmihaLs3S41+XJOCSNs3p/Nd4mPbdQUkp7kQpnq2MqHQqR?=
 =?us-ascii?Q?H0LrZhSOIJyWpBc3ScZTXFRdm/c2DkifmQ/I8H+6ex47Cp1PYQItDBdBRyAh?=
 =?us-ascii?Q?ycg/ygZA2uIRpVLop+Dy9sKZ4eUorqtPgoR5qDON/kIWtUgqf4iCg56VrLro?=
 =?us-ascii?Q?VvlpHhA7tzq68f5Tak4LKxlKHNmOOr2h76nwb2BjJhkGKEn9HCG56yD59pL/?=
 =?us-ascii?Q?wk4avkNI/ab0C85ndk2c2rt3v7ZEEbxQqPRM/kgoHkLe+S2MchOFAKczVe9D?=
 =?us-ascii?Q?FtMLZa/s0ecHE6RrRDxCXzyjkhPJnL4wOkx923hMbH+XC3eCBBwsigOaxXKw?=
 =?us-ascii?Q?PIe1cYOsHeVOOsk74TCdvo5JSV+kUx8NPIAmYRNxi82hKwHg1894OwkPxHfQ?=
 =?us-ascii?Q?+ZJ8QRf6K3py53iPFwZlRQ01QOJ1cAoOMWl8YLaS13tEefphkdKVBE/EJlK3?=
 =?us-ascii?Q?DWytwF1KLP8TQGMIHad8h1QIYKSfCoAghApJeJEvQcGimE4rsxcGwD42a1+h?=
 =?us-ascii?Q?1M6VBnCZrhly1Nmd6g10m1XGXWJ+NVo7VbAXrMAEufIPXY5CMh5ZwY3FnCp8?=
 =?us-ascii?Q?JwJbzdK2EcPPq1joFbo3r8UlQ/kZiF7/TgoUxBK2wOpmAOKhr01jXBiaFSnq?=
 =?us-ascii?Q?u2hCiDWssv4GVEaMpVc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:52:00.9287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c58592f7-a3b5-4b6c-7231-08de4d43e99f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747

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

v13:
  - Verify nexthdr unset for ip6. MST
  - Return -EINVAL if tclass is set. It's available in the struct.
---
---
 drivers/net/virtio_net.c | 99 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f9525b59150b..15678a408554 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5936,6 +5936,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -5950,6 +5978,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -5977,11 +6008,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -6118,6 +6171,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -6157,6 +6211,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		++(*num_hdrs);
 		if (has_ipv4(fs->flow_type))
 			size += sizeof(struct iphdr);
+		else if (has_ipv6(fs->flow_type))
+			size += sizeof(struct ipv6hdr);
 	}
 
 	BUG_ON(size > 0xff);
@@ -6184,7 +6240,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
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
@@ -6195,20 +6254,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
+
+		/* exclude tclass, it's not exposed properly struct ip6hdr */
+		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip6_spec.tclass ||
+		    fs->m_u.usr_ip6_spec.tclass ||
+		    fs->h_u.usr_ip6_spec.l4_proto ||
+		    fs->m_u.usr_ip6_spec.l4_proto)
+			return -EINVAL;
 
-	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
-	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->m_u.usr_ip4_spec.ip_ver ||
-	    fs->m_u.usr_ip4_spec.proto)
-		return -EINVAL;
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
 
-	parse_ip4(v4_m, v4_k, fs);
+		parse_ip4(v4_m, v4_k, fs);
+	}
 
 	return 0;
 }
@@ -6278,7 +6355,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
-	if (has_ipv4(fs->flow_type)) {
+	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
 		selector = next_selector(selector);
 
 		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
-- 
2.50.1


