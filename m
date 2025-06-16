Return-Path: <netdev+bounces-198309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5304ADBD27
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D9A17430F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831E71E8332;
	Mon, 16 Jun 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YMbIiwsX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2272225415
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113974; cv=fail; b=cNGqCB2Gm904opavdghGh2Zh8okUhNTVASazha7nySV4cKHETCu8fXiHc8b6g2M0kO4fnz9ejJMceOP2aDkrFFoj3g2UlEyRWD7tgCK3p+N7ugdvgtlJCB5CCaApfSiCkuPJ0pwjcMGAFSulmiknRDI91s6CLT3FbzxJ3DJNg4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113974; c=relaxed/simple;
	bh=TfVGp/h10MB/U8+zFaOW6e0KAfSgIILdyVBWF+pRyzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miOAjP2PMMGcwMJGWYr1NJKuOmr0yiKy2VjGpo5NCoObKd2VTXDv9RzYIMlhmGGDHwVCQJyfGZY4+SY+HNr0BnDP7ZrTVbto8IPlu+1zRgpnlpkfNEJQBX0f31AZBkgLr9eHwo9U3xVzdNl8MHxc4/UQFbFA6M8dus7CqD0MQ0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YMbIiwsX; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyvmDboqgjVajCrXEcuDxXOyp4hVyVzu7Tpk9TD2IZ5AvbEPY13GTL6JxpWpRwbKxzEEp3gP9J4YoffouDgjtepv6OyLoPd6cE/QhgulzJwJak8XPAfvkt1icqnSy5S3hjy9FC+JNnBSYAF0g/aMlb08ampwfgUUyEKIA5+OQljyPVGDfcRV0nzJcByKbbpGuEPyxz8nDkmyzdSbuhdq2dhNa/nKYnqEc9SfPQgvaynzV21YKu6LKgwbna8gUglUTpw9cvNEGXHxWQkyytHnjV6wuiZXAXq1M/weQ2j4NqUXQT0CR3NyQOSxYEGGQLlDUxKxzpT5teog6PmO9UP7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Senj96sPA6iDPigAucis7OFcDNXvI/6WHPovoglEF4=;
 b=npWCfzjtfYW63yR8FqcNTQe2I/gIFsRoFZNMdvRYwAcwuFmxPdS5o4etGi447EvkH7m7JnEJ6OfJ0+mr4koZnvlwzhq8vok/tjY+GbucVoEEXOtbuuYVHEhqVoaUYtCC4gHLqIW6PTmiArYd0cZY28Vw7fuMwLJruQFtU17sv8eDvFIsZ1nyaAPCFPTTn8QlutRRZouiulJh1GtqFpe05/ESVMECO7sRvfDL46n+zpjpx+rxddk2/wicMeZRGZ8kLSdj+jd7BrIDBCS4P+vOxYU7Qr5OohfVE99K0iMwk6uEXZ4dlRx8c4m0O+QDMpDau5dBz/YQfzI7wsaGJfGtdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Senj96sPA6iDPigAucis7OFcDNXvI/6WHPovoglEF4=;
 b=YMbIiwsXqxwpulO/hni6TbCgXcM8hIuO+leyBS52Oe6zyQWTzvkBb19lrtWMLDYMsOD2t+77qUI7vaG4WTkF0HPBIok6sktgy6KOjfq4GGcBWP+ncCLd0TZjCKeaQuYEgCECKq4vC9VIEFbozMXqPc+CiPmuZdBvQMQ1n83SdkG9HX3mVA/W56gETsbOO6sUvFKxqLAijE1AVBODBE1xqnI6idOWV84gJYzLbEGdfBLvlhv8K41hnmJHI303c6wZ8Zzqb9KwnuPSTDS3Q5n8Zy7WQaxSe7yRSK2vTGyjB5YJBAr0RAnzybvBLsdf0y2Vjt1OrGUEK77Fd07mBY5HQQ==
Received: from SA0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:130::16)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 22:46:07 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::15) by SA0PR13CA0011.outlook.office365.com
 (2603:10b6:806:130::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 22:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:46:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:45:54 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:45:49 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v3 09/15] net: ipv6: ip6mr: Split ip6mr_forward2() in two
Date: Tue, 17 Jun 2025 00:44:17 +0200
Message-ID: <8932bd5c0fbe3f662b158803b8509604fa7bc113.1750113335.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750113335.git.petrm@nvidia.com>
References: <cover.1750113335.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c353ff6-4dac-4dc1-ebdb-08ddad27954c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eDozl8It4GIlW3I7YdiskAoGVx+NYXR1cuVktRGzcSQg5kXTSPEsRs21vGud?=
 =?us-ascii?Q?TebNwqxrGEKJzW8F0fffuRjqCcj3IEwohx8AoaG8tpJ9AM8cQgaIOgsOlPtf?=
 =?us-ascii?Q?cjlqJl3YG9nPR6R4jKpL+LzoqxeEje0YZSc67MIbpe5DTR1xEFowpxpu4346?=
 =?us-ascii?Q?GHTNZVO0aihsI97b15j+xIUzfvrbyLinkBLc3bb60IonQAU0FO4NKCKAbSte?=
 =?us-ascii?Q?Ol22lgFq/uCrGEMpiPynY3eh2TcLEwuABnoBaUSNWhzJRv8NM/V9CQ3lZZWE?=
 =?us-ascii?Q?YNOZ9jDVCp7DhfaIKOgm+iQljQDtI9vFzT2fi52A1EXVOYzYyi3zZ74ox9It?=
 =?us-ascii?Q?MCJ1HP2Y8Uwt3KS3h8NjjJE8UkVhtIK1rLqoJBpWvta6k8VMin5BwYwH5Z1o?=
 =?us-ascii?Q?Z0QtVeSc4AL6zKCQEnghz5/8lPR94QxKaDs1jpyMplZbD+myDkurt9BnqC8n?=
 =?us-ascii?Q?mVp7XT1wwJiNbJnhi479TvQuX3KGX6WMuNv2xFy8zOeqgF8onlz+hsaPrp6H?=
 =?us-ascii?Q?Z2N40LuUYO0n5ZVKfACEBGs/Z1QcN+CBmAgRoyS0Pf1W26ABxi/eRX8RRgvN?=
 =?us-ascii?Q?/KocQQ4tdEqloh6ooQLPIydNToXwY5WwxOaiTojmyRk0cBRzDsRpbBjCB+TV?=
 =?us-ascii?Q?9dab2hi78B5zRw1O+de/7h8d8XcaAG71NVIkm2FgCxNSIb8cB8WsTUiu6V+K?=
 =?us-ascii?Q?g6qNOYckRfHSRpWB+DK2DoG8pQl/65RQ71G04JQJaF00RMEcxpaHr4lBQkzv?=
 =?us-ascii?Q?HOVpr8GqtSVdf6W3eJm0FwWIgJeiuiVQ60GRa+Q8r4vgC1LHV7uApMIMQrmg?=
 =?us-ascii?Q?bBC4NulA0HECz7HMUTK8FG9B3XLUPQa/44buBw2q50oaDDldMgsaN/EZSCq4?=
 =?us-ascii?Q?ngxPWgcYCz2YdVzBjnvZ6L4olbyLeltXdantQB1WvToIW2RKJjOSxJixXDJd?=
 =?us-ascii?Q?7xXzBIm2+zRGH0APZe4wv8h2bM0V7enH3UNKuMPYdNplJqWJpADfyPGylTkm?=
 =?us-ascii?Q?KJdJe3zFt2CDJgsVff01Mm79UrlLKZLy/mRhHhLJJZxRijEH1rKqzeLW5pG5?=
 =?us-ascii?Q?DqJh2qkpLa52GRFaeBtotzdPcmNiwYQLPA0xd+aR0a4uuXyDIWP8agqtyxS8?=
 =?us-ascii?Q?XzHAqsmxCwW/Rp80jR4+6mk5lkBKYHFaGmuOyQDIjVF/Vt6kuQxIT5u8DRoZ?=
 =?us-ascii?Q?W+KfS+31TVQOEcVuMv7O5egW6TiuCpbPhhleiijxVybR23KwyF4nU0j2o0zu?=
 =?us-ascii?Q?9ivVxeTdZt5uKzGxDNkv7f2FryHvNDBHfpgKVR9+3kvX5igO526JbGXjAF0e?=
 =?us-ascii?Q?25E1NWZQ3Ujyc/baM3/GEJNnD6V4KGZReyR0ZTQRpJtfxmXikOlTPXbLDtHi?=
 =?us-ascii?Q?COJ2Bu2RuG8V65RHSB8+tMW6oOVPTLPVwYZs0JWdayyS/rN77JJEFObyF/1N?=
 =?us-ascii?Q?ix7JQ89hWlezL31OxbZ1N3fEyofA3So6au37vWyMEVNSoNApeMVLHjywm2As?=
 =?us-ascii?Q?PCK/ijEC8wZHO4YfbygjE5jXfB2UT/cl6lve?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:46:07.5208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c353ff6-4dac-4dc1-ebdb-08ddad27954c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858

Some of the work of ip6mr_forward2() is specific to IPMR forwarding, and
should not take place on the output path. In order to allow reuse of the
common parts, extract out of the function a helper,
ip6mr_prepare_forward().

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v3:
    - Move kfree_skb() to the ip6mr_prepare_xmit() caller, like IPv4.
    - The patch is now structurally so similar to the IPv4
      one that the subject should reflect that. Update.

 net/ipv6/ip6mr.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 41c348209e1b..bd964564160d 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2035,11 +2035,10 @@ static inline int ip6mr_forward2_finish(struct net *net, struct sock *sk, struct
  *	Processing handlers for ip6mr_forward
  */
 
-static void ip6mr_forward2(struct net *net, struct mr_table *mrt,
-			   struct sk_buff *skb, int vifi)
+static int ip6mr_prepare_xmit(struct net *net, struct mr_table *mrt,
+			      struct sk_buff *skb, int vifi)
 {
 	struct vif_device *vif = &mrt->vif_table[vifi];
-	struct net_device *indev = skb->dev;
 	struct net_device *vif_dev;
 	struct ipv6hdr *ipv6h;
 	struct dst_entry *dst;
@@ -2047,7 +2046,7 @@ static void ip6mr_forward2(struct net *net, struct mr_table *mrt,
 
 	vif_dev = vif_dev_read(vif);
 	if (!vif_dev)
-		goto out_free;
+		return -1;
 
 #ifdef CONFIG_IPV6_PIMSM_V2
 	if (vif->flags & MIFF_REGISTER) {
@@ -2056,7 +2055,7 @@ static void ip6mr_forward2(struct net *net, struct mr_table *mrt,
 		DEV_STATS_ADD(vif_dev, tx_bytes, skb->len);
 		DEV_STATS_INC(vif_dev, tx_packets);
 		ip6mr_cache_report(mrt, skb, vifi, MRT6MSG_WHOLEPKT);
-		goto out_free;
+		return -1;
 	}
 #endif
 
@@ -2070,7 +2069,7 @@ static void ip6mr_forward2(struct net *net, struct mr_table *mrt,
 	dst = ip6_route_output(net, NULL, &fl6);
 	if (dst->error) {
 		dst_release(dst);
-		goto out_free;
+		return -1;
 	}
 
 	skb_dst_drop(skb);
@@ -2094,10 +2093,20 @@ static void ip6mr_forward2(struct net *net, struct mr_table *mrt,
 	/* We are about to write */
 	/* XXX: extension headers? */
 	if (skb_cow(skb, sizeof(*ipv6h) + LL_RESERVED_SPACE(vif_dev)))
-		goto out_free;
+		return -1;
 
 	ipv6h = ipv6_hdr(skb);
 	ipv6h->hop_limit--;
+	return 0;
+}
+
+static void ip6mr_forward2(struct net *net, struct mr_table *mrt,
+			   struct sk_buff *skb, int vifi)
+{
+	struct net_device *indev = skb->dev;
+
+	if (ip6mr_prepare_xmit(net, mrt, skb, vifi))
+		goto out_free;
 
 	IP6CB(skb)->flags |= IP6SKB_FORWARDED;
 
-- 
2.49.0


