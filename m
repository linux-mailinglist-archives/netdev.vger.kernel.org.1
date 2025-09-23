Return-Path: <netdev+bounces-225640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915FFB96330
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776AA2E7969
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB93258CDA;
	Tue, 23 Sep 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cIV8tlSl"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010050.outbound.protection.outlook.com [40.93.198.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05183255E26
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637209; cv=fail; b=XQdRVoFcgk9sVIL53r3dYrlSG+xWXECyHk7nFckW0Df6utvEOBy18LQMDGQTXlbB2eZrgNWnoRM4sk5JD2cBTDOxDZK7YG3OOITvMsiQ959brQHTyGv4sxrFvcyhZ8xzJggk6T72OpSX7q/xDEFxfGXv2nx3YiHRMP1sQwgrF5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637209; c=relaxed/simple;
	bh=/jKl1/Isv6EtgQG4eZbvcvszDggMxEw6Y0CM4UX/4qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f560Nl6mDS+35WDuupHPxs3NXFama38vKsZEVxfTwlpcU/8UuCyFOV/cplSZ7jdaQVi/A/NnHyZZy24uQuuprEAFBuR6Q2hbBeUi999DSdwVaUw90EIQPce8apx8d47UToHAhmuX5OZqWsbOv5DhEuI0C2cIlrBq/yXYXOFde6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cIV8tlSl; arc=fail smtp.client-ip=40.93.198.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeJ8YWY0YemeZwaSJxY41+UNypFkm9RzUGTEpVI1Hxe6u1DEJewUSKoE8GfIa6ceqewH1aQmDusuxcGEmhLn48vFqAM4ROyWclWgsk/Vd6aUAGGy6gcIa4+O1lxW/e80iDKsT3WTtyfcyuVkLLxOtJLm32WcTdUcyFLj8bECEHGyOIxlVcEZAFXIWEDIwT0AfjvB+lLhiMzJEWDyOArwqbVL3FyqBYICe2eTr8nWPywnG8+W7HPXt/zg1xCCd5Qi6+kLcppFHpQ4uLXrkoNdEsqPhQWge4EqeNDMykwOW/nkNiLuT1rBOnIISVb5mHO1OHsfg4BkoBflmgBb1O8aoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc+K1L0vzKdLePD/wGMSO9i+oWmBvuFtpo+bVrYo50o=;
 b=na/YFaCHRm2Mkbn319vtLIgV+8O0QHHAM0O0RLCSNGiH41h71Asmqn1WCovLy8xWXaqGtFIHJDPi2mOEG6pqZc7hY/K3pEAxF4UFEJkEM/7rVp5fY20rfA5pyDOb7Z/myUlkr0XPrppgzPMr+rf7n7wtX03IfYy6DYRh6qhieaHUz8QtrgqQB/X70ebHkZwwsAEJVG1GMyb9nWCGh56tsWC6CvJ2ix1a9XRcfspUkZ6q1XYeELzA11U90JvBpMzS4blCadW+L20DLo44H1Pr/2bgrqjq4BdrFzc+ZeUBPkZxETWaRn1hB4hxbZI316raWEfFYtjwXTmASGW5PxYj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc+K1L0vzKdLePD/wGMSO9i+oWmBvuFtpo+bVrYo50o=;
 b=cIV8tlSloR4AbpspQH1OvDhYEh4l+k6mpYuooVOhFip/QPCgtCk1nN/HjhE0ztM2TdFQCf0oQozpVgN10D51JF4wlhT1ZYM+X9NHFrYeifwMB6sSs3zDEYyFd84I/fmgstD3wmfTLq+x7EDtHo1uJZrloL1NHRgvQnlE9O68ebAXChpPMDO1BYeXOJE8i7Xw+O2fE8L+QYbD7d5mt6ssvIO/PguxzH6onBvnozraw9PVupQ3oTcEqmmNRNFo3iRPrvB1QGu7lIeu+9Hr7RaPUTW767DRTlyen9cqCzNtfJ2QwQAjTc7lp66fweciYezPPGBCyFtQWSz6jDgcyUqkrg==
Received: from BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::8)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 14:20:03 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::63) by BY1P220CA0012.outlook.office365.com
 (2603:10b6:a03:59d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Tue,
 23 Sep 2025 14:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 14:20:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 07:19:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 07:19:47 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:19:45 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v3 09/11] virtio_net: Add support for IPv6 ethtool steering
Date: Tue, 23 Sep 2025 09:19:18 -0500
Message-ID: <20250923141920.283862-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250923141920.283862-1-danielj@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e7a141-b192-4183-9c3b-08ddfaac496b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OML5cXAWUCd0l2i8RD+hgwqS4k9fxdS+2PBCcXwOuya3/fgmZiY977ds5YN8?=
 =?us-ascii?Q?aDoTBZbw2zURMvqj0omtMfixDwJXYjhueevd7mjyf4NLZxRkamn4HBTy0cAC?=
 =?us-ascii?Q?O2GJu1F+6Qg03j0EFMGGUEM58SXGsussMt0fvxWC3lJK7DcJ1gb3FfumXMnQ?=
 =?us-ascii?Q?zJPzPGtl80f9Ty+i9mWqhHw4E+dxNFGdD/aCeLetxYlGqc0kRzTnpWN3psV2?=
 =?us-ascii?Q?ViyAkqtJWOi5/ISMPJFQ/O7ZFh0/HzJgqDfnQvcb6GqmseKAyWJvWWn3KngK?=
 =?us-ascii?Q?9pyNm6dkS4uRx8JhV3Yyx62KKjXTdx9BYy+upwXAh7QlaTQ3jI43l5BQvWlr?=
 =?us-ascii?Q?anrZBj07HR+DAQUh39uSEGfWZfZ7dvqZ1lXvX+NwY/7PITOYUg3DBukkKDk5?=
 =?us-ascii?Q?HQ/Xdr6q5mzBlI9wjUVSuAZD499d50HJPb3f0S5tux7ud0NI5lZIFP+Iba6c?=
 =?us-ascii?Q?3sQ0YlLsDKqMwdmtpRw3mehpckhKsskYljt5v9jeTGUdRBB1jdne4h/zklcr?=
 =?us-ascii?Q?JE0BAxFSgLcpvfcZgn0hIytvi/N4+c/FarGN8h2phNC0ej8aLPa8lN/5Tvyh?=
 =?us-ascii?Q?Jd389zQghGMlcDuJcAkn1Lrem3C3ImtcPGRV4mQ2BXXLGHz2fdiLtAZrFJFG?=
 =?us-ascii?Q?F4WDX+Ng7RHlweWnHof3M6KK+y5XX7dXYx0JqCw8OmG3MtMXtWlodSSpqDs/?=
 =?us-ascii?Q?2ZlMwxMgPBMA0ihdOGtKRX/+EXmChnc1SV1d+vzRMpq3uuNQI2aVM+F9fb4v?=
 =?us-ascii?Q?Q3XGqeg2BymvwNhBGj23S0WdwW0DonncIVm6BnX2CNAM2i3PHf3sAT2WEbrr?=
 =?us-ascii?Q?Qw4RA8vFrVG/nLN7Nc/bxG9P7HHL/NcveAVa99Z5la1IiHn7YcKRaKEnItBc?=
 =?us-ascii?Q?CKiqPn49LtUB/bwwtgQqG/fUZjxhzvo7twIa7iFHJLZFunUbWFlgUZwjedUP?=
 =?us-ascii?Q?7EGsNFecJcz4dn286HjQaxR1BPLxPyWpgGCKPBfkx6yh6G+Um94tw5FuMZC+?=
 =?us-ascii?Q?qpJcgHCZsH8c+xdfWkW1reknUgheLaETmOw8s3Hf0Bv4OlUKy6HPvCLmxI+6?=
 =?us-ascii?Q?OSx1HIWUKG09M/O1FRlZXrU29baAXRA7h//N8dMIk/HCgACAgfSURWDwsolS?=
 =?us-ascii?Q?QDqTZueq//J0aMJfPvy5OQOTRSqPw2PV/r4P7IkSh1NvVUQVuiq3U0TFy5gl?=
 =?us-ascii?Q?QPV7dQLOYOOd6q4piXKPXDpZIQgCv6DdnqLoFxzJcyhPKYpxXJYkCBBUhNs4?=
 =?us-ascii?Q?/YHJB0IEmbHLh5DRKHZbfqETggRIegagKP68n6NLep+N0pNrZrpCnG/gRi/v?=
 =?us-ascii?Q?w6u/ZT07FGLMo/S7QJdhhvYfPRp3CseOZp/r4Gpjn2YhLGewBKNnBm+bCIBL?=
 =?us-ascii?Q?ItXFSqFwGqbvZceDuSiGOkBLyIm0WhVGtrKV9P86tSq8NYp33LOPlGgSYtV1?=
 =?us-ascii?Q?nqzx8oR9eLmI4z+hHKEyBfFFH26BOH5HZBuRig409rS9vI/uohYw502gAxtB?=
 =?us-ascii?Q?ZM6nA6mWKHdNliORT+B5Z67uwyXvSej6cS4X?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:20:02.9314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e7a141-b192-4183-9c3b-08ddfaac496b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725

Implement support for IPV6_USER_FLOW type rules.

Example:
$ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
Added rule with ID 0

The example rule will forward packets with the specified soure and
destination IP addresses to RX ring 3.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net/virtio_net_ff.c | 89 +++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index 0374676d1342..ce59fb36dae9 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -118,6 +118,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -132,6 +160,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -154,11 +185,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -291,6 +349,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -332,7 +391,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 	(*num_hdrs)++;
 	if (has_ipv4(fs->flow_type))
 		size += sizeof(struct iphdr);
-
+	else if (has_ipv6(fs->flow_type))
+		size += sizeof(struct ipv6hdr);
 done:
 	*key_size = size;
 	/*
@@ -369,18 +429,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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
2.45.0


