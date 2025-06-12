Return-Path: <netdev+bounces-196940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7FAAD7042
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E63517ED94
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9572823D2A3;
	Thu, 12 Jun 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k8yVjkoS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7EF1EBA09
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731079; cv=fail; b=An0l+kpPy6+w8t3dDzM6TPG/ELHE6kdZQwovw4e97ycduEhcgKHTN+Wf7gbt0pCjQds7VuewOWECz/0fu9qldaOIRjbD68gh51FePguVXb0rO6Lh6YBW5XW5QHcS9YfVH8ma43VLZGFtNi6ClGUz9RixNesS9cBZFB5IUDfcrr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731079; c=relaxed/simple;
	bh=b4s7Zbh6GIJcKXWOyaSDGy7IUa00UJ8r7VYuLq9UhK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUh3XJ/g7p9aRYZql4xyMC+0vxP8vjLWSV84YmVNobjxePcsh2/4qRoCz/yv/2btuPptS5BKn155s2R3/4htbHWMFgdhHAU3joArkSHzpJDj87yTvJohPloTVHA9E5bJUaWEG52wz+2kcaZhszhuWv8KCZUNNmJCpVBvReHZKcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k8yVjkoS; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shwrXqfcaQes+lPOSlID9rqIx22TLrx6E+eVDvohb26wMxkNFs6TDpG1lTj5xon29fI4+tuyNWAKT/K9jeDtoCP4v4LdGRhnjr37PNnEFv8+0k+mfk4NT51mkxUNi9UC0sU89SSkO9SFFFk2hPo0KKaFg5OaUG0Fggahmj2Xgr7ijwaE9YRA2hilxv8psvhNu2YRPZhRJFcGrbrEOCWGlLq+Rh+TbXjpzNY5GLNZwwuHuMUaxEHfzmjv6zW/96yKnB9IRn7+bZH6ZOl3CD7dyHZT17G0qvi9jkQwLL77rPZ0xvlAMm1SGgmMYOVxC1CsgA/dX1ey5DaCZDGFhgjdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhpxlzUY6FrpmH35X+Z9y/mLmzkFzJeHsZ/LwrnR2NM=;
 b=DelzDd2NQ3b7O/t0YOIkrebmDE6HKoeFfNVNE7ogvMlpAANM7ioJVuurWBm6lTH0SZD3muTdtQa/s7mhJlrzAFULd/3Y4DIntIMyRqaQaHdP633LwRdF6sWMhLvCFEr6xEXLEdISyE1Y4z1vkX5sBbNdl5WtPX3id1WurlI+hrl3e/58RpujnJdR1/WCrz1tVDZh5ditzvAeR3oDEq2X2lbh2rxRMr9S6ggQ+wWWIGn0U5h11Cs9DAURtxbHh4XRIfz3nlQ2BMNA/UaYrQmQJH79LNlCAaHVm1JZm1oc8jxhbq3R5/mfO7OhMxfpBpf8HWH0XIMP6CKPnNI2O2E6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhpxlzUY6FrpmH35X+Z9y/mLmzkFzJeHsZ/LwrnR2NM=;
 b=k8yVjkoSB3YvH2hqs2pe1C+KxciCK/doqaELc74yCukkSqosc/3omcGLRxTzxAxFO062UIGv86ioY8vUrjqSxt/tCXAyBfZ5RYbEdtm/a4+ANtP/DJ/X8WvJVcWRyT/S2ZwWkvN/lTq4Kk7RyANa+RzriwShNqnjCrGbXC6gOrQ1QncH7HAyRB50w9b/ZuWRw1q45HMZZ55qTNpH7/zohdonXJTsO3CFd8Kkmhk9sbJIrrTVMF1hNq/6LToWUhwJiGm9EvoMJrjH3qB8UfJ+eh0zxKeuSNVI0vQmwsZPhnMLxD35eDXVW6i1zp90GRuI2sT2BY1fKzzikRm4jrRmfg==
Received: from BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::12)
 by LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 12 Jun
 2025 12:24:33 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::8a) by BL1P223CA0007.outlook.office365.com
 (2603:10b6:208:2c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 12 Jun 2025 12:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 12:24:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 05:24:19 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 05:24:15 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrea.mayer@uniroma2.it>, <dsahern@kernel.org>,
	<horms@kernel.org>, <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/4] seg6: Extend seg6_lookup_any_nexthop() with an oif argument
Date: Thu, 12 Jun 2025 15:23:20 +0300
Message-ID: <20250612122323.584113-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612122323.584113-1-idosch@nvidia.com>
References: <20250612122323.584113-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: e352f42b-4ccf-4a5e-2f39-08dda9ac1684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8qD2UO8+hdmTzyQ92wreFA0+fWlfyuQcfRBoLnEI7WpKBmFFVIMU72hWTyqL?=
 =?us-ascii?Q?z15m4osVSTxDP/WofJ7QKQwL99h453fW1JSTGdBQHgCsmVmWaQgiMy5rc/NP?=
 =?us-ascii?Q?ppvl+/iCdDhnztRdoeq0AuPooXEhk/YbokP0HSC35vs+Ee0Zy9kRS5Q7BqGx?=
 =?us-ascii?Q?8Rizo/4Ru6QvS8dJK09Ows65Y4T3hb8u8C0ddQ0Jkk7x7rOLPhsacGIpZkCM?=
 =?us-ascii?Q?rATRPPITuCG4YRCRLuajJQ94Re4XVr/lwqV4sf/LKW0sl7jDRGnGQt0vQ6vQ?=
 =?us-ascii?Q?LnQkmEhUjSBI3QYEj85VmsPwjKpllJjg6fXR73p3rTzCMuqYGcd8Jp86BBvj?=
 =?us-ascii?Q?hGCIXczLAO3lhpikBvF9//3nuUlscgXHAcBKROaILk0t1XJ3cbgGONySXdib?=
 =?us-ascii?Q?IG9s5yhFCuFjpooMnVDQY52inWs+pIisLDHPLTsCcve+W3Yh620idGYCiu8l?=
 =?us-ascii?Q?DvhP+5J0kaG7p94cK+evDG/wrY8cWkneVC+AS4POxOLNSBLr7Zg50SdGvxsm?=
 =?us-ascii?Q?6DI/nql+ZSRSDDJxZnxvzkAw8rkQQDDz7AugrsDfhV0mUY4pHJh0o0bqh+6V?=
 =?us-ascii?Q?9SXpV8bZm/aEmsVkCCXYrBgw98Mhdwvugf6Qv/hvD7ZzOlMhD8beJW5LNyi2?=
 =?us-ascii?Q?n/Fa4a4QmWy6ed/B4axRG21+XNL3ygVqHTXhI964ii9vcjV6z1695AoDptNv?=
 =?us-ascii?Q?0hSbLkkgqfeeoNk5XPNkqjtO3ljTRHqdajnMlkfM3izLCijy9M1DvBGp5GcM?=
 =?us-ascii?Q?HjlsuCmKUjViP/NkzLMYsrwE9Gs26PI8XHKE6C0q2RulXdL8nvw+pG5SK0QY?=
 =?us-ascii?Q?yJQwkK7DrFtzrbTsCkLpAZXdE60lW25rvFt0d4sIUNQXXQLIl0K8gvQP8cEx?=
 =?us-ascii?Q?P2bkBvRzcrHKidNaXKBE0xpxVeFIksDcqLqJ8W8LnFpEc1/ZF4626xFP5kD2?=
 =?us-ascii?Q?4v85R41L3zbHBxXxUXtZd5qYvdngofjAY+ZTrDcxSxMuWzYs3fqnGjDgnPzn?=
 =?us-ascii?Q?5UtgcMN+7In3BS93kB7eKz8BjrFm5FYzCY0mRvHNtkMj8QVsFBGQzT68EREE?=
 =?us-ascii?Q?Ee9LIqYcEfZZ9Stqa5DXxznqOw1Nk6lwdiTEd9cfc1m+rSdhonmfBM9T6HHJ?=
 =?us-ascii?Q?stjpEJIt9YVXNCcFwBkcR3E1UtYlkWbkKm7T/PSrF78jgoPo34FhtGZa9nAK?=
 =?us-ascii?Q?pM8DA+90ZIb7jmwwwegCMeCBcsUScFXxHOva3SoXdZqk2px28SHkFvjnUkcE?=
 =?us-ascii?Q?EfxrsWPqDy+oTzPhSFMs+VlOUFFZJM27uOgmfIimY4024XwAdGTmi08Qii6a?=
 =?us-ascii?Q?m82cFvGeYA+Bppzb0A5Jpu7FZhTRSnHWyNDscvg58Z69dhUtY4PlkOTJd08n?=
 =?us-ascii?Q?n6bb12uFmnZCp6S7AQJFOTOWxcnXWDBXiVt6n7KsFOFZ8NblbIYTghCIerIx?=
 =?us-ascii?Q?NPm+ZOqf+sQ1L/424mWCNa3hH+kKqGC77vF/tYG0x3isrQ/Ir5vVzjI/w47w?=
 =?us-ascii?Q?85vjFJBfJR6iZgSgzwNZHEp69TThnx7vl8b1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 12:24:33.2171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e352f42b-4ccf-4a5e-2f39-08dda9ac1684
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156

seg6_lookup_any_nexthop() is called by the different endpoint behaviors
(e.g., End, End.X) to resolve an IPv6 route. Extend the function with an
output interface argument so that it could be used to resolve a route
with a certain output interface. This will be used by subsequent patches
that will extend the End.X behavior with an output interface as an
optional argument.

ip6_route_input_lookup() cannot be used when an output interface is
specified as it ignores this parameter. Similarly, calling
ip6_pol_route() when a table ID was not specified (e.g., End.X behavior)
is wrong.

Therefore, when an output interface is specified without a table ID,
resolve the route using ip6_route_output() which will take the output
interface into account.

Note that no endpoint behavior currently passes both a table ID and an
output interface, so the oif argument passed to ip6_pol_route() is
always zero and there are no functional changes in this regard.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/seg6_local.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index a11a02b4ba95..8bce7512df97 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -270,7 +270,7 @@ static void advance_nextseg(struct ipv6_sr_hdr *srh, struct in6_addr *daddr)
 
 static int
 seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
-			u32 tbl_id, bool local_delivery)
+			u32 tbl_id, bool local_delivery, int oif)
 {
 	struct net *net = dev_net(skb->dev);
 	struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -282,6 +282,7 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 
 	memset(&fl6, 0, sizeof(fl6));
 	fl6.flowi6_iif = skb->dev->ifindex;
+	fl6.flowi6_oif = oif;
 	fl6.daddr = nhaddr ? *nhaddr : hdr->daddr;
 	fl6.saddr = hdr->saddr;
 	fl6.flowlabel = ip6_flowinfo(hdr);
@@ -291,17 +292,19 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 	if (nhaddr)
 		fl6.flowi6_flags = FLOWI_FLAG_KNOWN_NH;
 
-	if (!tbl_id) {
+	if (!tbl_id && !oif) {
 		dst = ip6_route_input_lookup(net, skb->dev, &fl6, skb, flags);
-	} else {
+	} else if (tbl_id) {
 		struct fib6_table *table;
 
 		table = fib6_get_table(net, tbl_id);
 		if (!table)
 			goto out;
 
-		rt = ip6_pol_route(net, table, 0, &fl6, skb, flags);
+		rt = ip6_pol_route(net, table, oif, &fl6, skb, flags);
 		dst = &rt->dst;
+	} else {
+		dst = ip6_route_output(net, NULL, &fl6);
 	}
 
 	/* we want to discard traffic destined for local packet processing,
@@ -330,7 +333,7 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 int seg6_lookup_nexthop(struct sk_buff *skb,
 			struct in6_addr *nhaddr, u32 tbl_id)
 {
-	return seg6_lookup_any_nexthop(skb, nhaddr, tbl_id, false);
+	return seg6_lookup_any_nexthop(skb, nhaddr, tbl_id, false, 0);
 }
 
 static __u8 seg6_flv_lcblock_octects(const struct seg6_flavors_info *finfo)
@@ -1277,7 +1280,7 @@ static int input_action_end_dt6(struct sk_buff *skb,
 	/* note: this time we do not need to specify the table because the VRF
 	 * takes care of selecting the correct table.
 	 */
-	seg6_lookup_any_nexthop(skb, NULL, 0, true);
+	seg6_lookup_any_nexthop(skb, NULL, 0, true, 0);
 
 	return dst_input(skb);
 
@@ -1285,7 +1288,7 @@ static int input_action_end_dt6(struct sk_buff *skb,
 #endif
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
-	seg6_lookup_any_nexthop(skb, NULL, slwt->table, true);
+	seg6_lookup_any_nexthop(skb, NULL, slwt->table, true, 0);
 
 	return dst_input(skb);
 
-- 
2.49.0


