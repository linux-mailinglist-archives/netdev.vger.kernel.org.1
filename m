Return-Path: <netdev+bounces-195850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1176DAD2813
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A0A1893458
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2B221283;
	Mon,  9 Jun 2025 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lXjVayma"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB498F40
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502312; cv=fail; b=JSwC2dNn9WvbiuzSMXA7jMnQEtp9kFjPMlK3mcgBaL4y0fzQ6Ik6O2fithttMttD/Zv0m+WX0pMBNXG1INOXks8vkeRa0hjDIx7pU0qL5PKQsgmnJ7aRLl2hFfuMbp7LiW/0vqrTpLyAuF8O/LZc3/isRTa8XFI4XVjEphVJF9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502312; c=relaxed/simple;
	bh=fwFUdGCcvGDWKGsufCnYoPG5M42A8DiHIDNcAbq92ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3dvTScZaJy5mdJ1tYxS2cRJQPxsc7Ou6fQ0vE5UaR6a76cU0XsH0Q+N/XZY8HJytKbEQSkMkmAZjEIVD+7aZBQOuT1lO3M3V5Oa9nHgQhDfHAOU9qbtyfDo0FmqOvYWcOt/GRqDjV7LuRWkJluSFMGHT3HDf9qn/xo7FrDH8yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lXjVayma; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIQo6k+NvPEVsPBQYjSHtaQ7xIcC2QdDa5kgt1J5lD/tL1d9Mqq1rPKZ6+Vau9Pn0vvXUv919/Xww2N3PQRqQe3YasMyIIuQ3Cw0c5kQqBU9aw98Og+OiraGCF6csmz0bdTdnuuq0wI4NokFYXiTBG/AiJA6OS8Y30AeKd89msSbDi8V5cxtFSU4rlWIfJ268XOO2pwm0Vrt8KoyD4ihi9KInYcREF6I6OR9yg7e7KWJj8h2q2r3avBvKXlxUQtyq9entOn+LQncWgpRnzMV15blYnedOaFt+AFyqBxDV53btuE/drZXF/ZRtrCPgS20F/pU4Flq8DKYbP2DTLNp5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18FKwX1tU3gU05P+GHoYPMcabS2EV6flc/xCG46ByIM=;
 b=wdmV+hn6V6vyWX4N1PmiEiMVfbZ1uaIO4cADK1aR81P8bvMT57VM2hry5i+e/dpJ/It4/ImvE/04HrSqFvAW6sb7XoMDU3jO3sg1BvNJktS502L/kN18x/UcfoTaGhdS8Ae/Vwfjhl2EkJZYiwT0Zg1nS01Wgzg6V19l4/y6KSn+Q5real+4yQaIVacsSmbgQUuMuKXIINJZPiyy5z5qcBWVfDgfFZA3HFLXzw7ouMCe2AtcjXTYu1TlpvgsyAR/YG8cpgv7CZWSWTt1Xkdxzbuuh1qWFKafIcj7HRZFPStTJ9kQHUgv8e4jTap/l25oawQ8RvFm13zin4UF4XWFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18FKwX1tU3gU05P+GHoYPMcabS2EV6flc/xCG46ByIM=;
 b=lXjVaymaSwyRTWyHweZqP3a/twLz7T0YaWM5iX6MP30cLCQfx3lxEBiPkLobxVWzVO8luzaHwxob75Alhn2InxWOiqPcbQ6lqjLGu3q3LpMGEPhgEtsotL4NfF+rcHqGM6n3kRXz+ULBdACdp9e37tuoqlP1M9AlSMugL66ddA3jRl0ULu5p18aFMmJcN2O1ZJv5P6um2XNSpAlWga5Pw6amObPUCRHJNzq5WaQqdve3mpnq8kmC9R1i7AnfOp0rbHgUXsJBJtsvAkxZcs+5tn/8iTu/lAI/tCIiTYwWNo/pHYvFPbcIT8okL0T2ox7R2kqc6uXrOinHzgfEe96k1A==
Received: from SA9PR10CA0004.namprd10.prod.outlook.com (2603:10b6:806:a7::9)
 by IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 20:51:46 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::6) by SA9PR10CA0004.outlook.office365.com
 (2603:10b6:806:a7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.32 via Frontend Transport; Mon,
 9 Jun 2025 20:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:51:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:51:29 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:51:23 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 03/14] net: ipv4: ipmr: Split ipmr_queue_xmit() in two
Date: Mon, 9 Jun 2025 22:50:19 +0200
Message-ID: <9667e583c46288b5dd1367ad5e1d75d1e438db81.1749499963.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749499963.git.petrm@nvidia.com>
References: <cover.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a2842c-1d62-4ddd-009f-08dda7977246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WUDfT6+6weSPkVZQpwBbZQ8IvYLL9VoMQ0CWrfT/EWAMhKzunFte95oe1iMA?=
 =?us-ascii?Q?oJv5RK+yztrLElU1nbeVgChMgaAKeGCwixwyWAsKYIHpJ5u09mdZI9Ptr7W6?=
 =?us-ascii?Q?KdGowwTcQxTtHMbc/9Mo2GNyVArEK0YExCX9nfGwUiBFuzfEmSFj7UbsCc8X?=
 =?us-ascii?Q?+E57SF35OTWE5eUFaGvxEmw9OZhPpALjnBIgjeLsxgSS4ubQjP18FPeufBSH?=
 =?us-ascii?Q?wBEr1RXhguNiHi9B7T2KNN98ewz3IFYTaz7F6o3uqe/raLXeVt2Yun0Xby1Y?=
 =?us-ascii?Q?Muq4NhdU+c/V6MqhlH7rdJexMu3LJq0UDgtWwaKhuQC+NUsFMi4SEre/r7Sa?=
 =?us-ascii?Q?b8stpNHzfxWuvvZrXOyLkdEvnUg67WixPPhsKzU0mTKn3p9SegrgJJEDHsmx?=
 =?us-ascii?Q?Rjw40DMLVobckF+W9OlMhbooXBk1lwgCeFKI4FkztFHGxMUTxqgqre09fgAC?=
 =?us-ascii?Q?lVvRtnL0RobKqyfSV/dRrcnk2/+2ZBGP/qblOF5TepoRQ4B7+i8Ow1/2M1au?=
 =?us-ascii?Q?9zR09GJ9wDjEkcjksCynRIw65ApzYr8a09wZDHdfplPgiorn8qD29PUVHc6K?=
 =?us-ascii?Q?T9e4MttZssAo+DLivNMD+iDcMwgkMc0H8u3omsXL86lvXHWwLen/Fo1qxFVh?=
 =?us-ascii?Q?XD7MMMq2NFfH8v7xW/xQjVI28QQtuHoF/bbTlN1PCmAv1ZF5Vbq6e9Kn/dK1?=
 =?us-ascii?Q?M7j1eRPE7/lFrXPUmyiMWuX5wUXQpz4IdBk4LP9TAzftFSCiWUjOA3SlAtKc?=
 =?us-ascii?Q?JfLKsQnYpb95/Z96OiwtWXUbCfOvoAZ7xnvodBu3osrvc20e+lm55oLzL3DY?=
 =?us-ascii?Q?AFqhmHCf1zbV3njgt+Z9iNe/WGfYnQDCG7K/9+828WNJTAGg92lI4DqXWz0w?=
 =?us-ascii?Q?PvkI7L8fqXjFfUonAk4z9/s2RCtK30OuJD8E+NA8YFMkRkftIQgzww7mLfLX?=
 =?us-ascii?Q?Zlc+3h6bdxleU0/ohvVd6J94+juBYViFcMf2y4LZpGfQAG68QGk/KoDmEG/s?=
 =?us-ascii?Q?ksFqsUp4jZMZV4n00d8fmPytAn45ooB9Q1HGFxwsUixP+QvMV+pPdDRBWMx8?=
 =?us-ascii?Q?ou/2GOk4m3uI+HP5Muywp7jxecVxb9bY1T7qkTjr6DH4JWwS68tunm78/bB0?=
 =?us-ascii?Q?IQ1s1x5zHoqJzHmNnxLVQud4iIW0o7NfnZs9vmVzMOO/ZqR/twc8ywfgp3oJ?=
 =?us-ascii?Q?r7t/3pI8PZ9fiYHEPdL0K/1McDy7sT+cMnY373EV2wMmfvW4GmjyadChBP7p?=
 =?us-ascii?Q?dvRNoQ5seE1D4wVQcI/QFRMzKCNaKyYD/mIZ/a7ByGWw/ZtgO1X7wM9oYDlR?=
 =?us-ascii?Q?5ARVUdlwcH4rnW8y2rP8tgTUZnypuV6rfoi7G79cgNcZmOqaed48+pe01fTT?=
 =?us-ascii?Q?TDpwosNPTS7Ylxgdnp2tYYWSYuHBl9ZZQlPAIOToDUl3g1NWbRsjmoVRsPQG?=
 =?us-ascii?Q?wt4nWgT8KRcRJVRtWFQAIdSbS7lPuOHGXnk4hN9FtXnVUStDCUws3/jzxOGy?=
 =?us-ascii?Q?UyTs1ap2lzQ6TdWZHBXUdIvZz2ub1+0tSu5q?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:51:45.4202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a2842c-1d62-4ddd-009f-08dda7977246
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908

Some of the work of ipmr_queue_xmit() is specific to IPMR forwarding, and
should not take place on the output path. In order to allow reuse of the
common parts, split the function into two: the ipmr_prepare_xmit() helper
that takes care of the common bits, and the ipmr_queue_fwd_xmit(), which
invokes the former and encapsulates the whole forwarding algorithm.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ipmr.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1c5e6167cd76..7c1045d67ea8 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1853,8 +1853,8 @@ static bool ipmr_forward_offloaded(struct sk_buff *skb, struct mr_table *mrt,
 
 /* Processing handlers for ipmr_forward, under rcu_read_lock() */
 
-static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
-			    int in_vifi, struct sk_buff *skb, int vifi)
+static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
+			     struct sk_buff *skb, int vifi)
 {
 	const struct iphdr *iph = ip_hdr(skb);
 	struct vif_device *vif = &mrt->vif_table[vifi];
@@ -1865,7 +1865,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 
 	vif_dev = vif_dev_read(vif);
 	if (!vif_dev)
-		goto out_free;
+		return -1;
 
 	if (vif->flags & VIFF_REGISTER) {
 		WRITE_ONCE(vif->pkt_out, vif->pkt_out + 1);
@@ -1873,12 +1873,9 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 		DEV_STATS_ADD(vif_dev, tx_bytes, skb->len);
 		DEV_STATS_INC(vif_dev, tx_packets);
 		ipmr_cache_report(mrt, skb, vifi, IGMPMSG_WHOLEPKT);
-		goto out_free;
+		return -1;
 	}
 
-	if (ipmr_forward_offloaded(skb, mrt, in_vifi, vifi))
-		goto out_free;
-
 	if (vif->flags & VIFF_TUNNEL) {
 		rt = ip_route_output_ports(net, &fl4, NULL,
 					   vif->remote, vif->local,
@@ -1886,7 +1883,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 					   IPPROTO_IPIP,
 					   iph->tos & INET_DSCP_MASK, vif->link);
 		if (IS_ERR(rt))
-			goto out_free;
+			return -1;
 		encap = sizeof(struct iphdr);
 	} else {
 		rt = ip_route_output_ports(net, &fl4, NULL, iph->daddr, 0,
@@ -1894,7 +1891,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 					   IPPROTO_IPIP,
 					   iph->tos & INET_DSCP_MASK, vif->link);
 		if (IS_ERR(rt))
-			goto out_free;
+			return -1;
 	}
 
 	if (skb->len+encap > dst_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
@@ -1904,14 +1901,14 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 		 */
 		IP_INC_STATS(net, IPSTATS_MIB_FRAGFAILS);
 		ip_rt_put(rt);
-		goto out_free;
+		return -1;
 	}
 
 	encap += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
 
 	if (skb_cow(skb, encap)) {
 		ip_rt_put(rt);
-		goto out_free;
+		return -1;
 	}
 
 	WRITE_ONCE(vif->pkt_out, vif->pkt_out + 1);
@@ -1931,6 +1928,22 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 		DEV_STATS_ADD(vif_dev, tx_bytes, skb->len);
 	}
 
+	return 0;
+}
+
+static void ipmr_queue_fwd_xmit(struct net *net, struct mr_table *mrt,
+				int in_vifi, struct sk_buff *skb, int vifi)
+{
+	struct rtable *rt;
+
+	if (ipmr_forward_offloaded(skb, mrt, in_vifi, vifi))
+		goto out_free;
+
+	if (ipmr_prepare_xmit(net, mrt, skb, vifi))
+		goto out_free;
+
+	rt = skb_rtable(skb);
+
 	IPCB(skb)->flags |= IPSKB_FORWARDED;
 
 	/* RFC1584 teaches, that DVMRP/PIM router must deliver packets locally
@@ -2062,8 +2075,8 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 				struct sk_buff *skb2 = skb_clone(skb, GFP_ATOMIC);
 
 				if (skb2)
-					ipmr_queue_xmit(net, mrt, true_vifi,
-							skb2, psend);
+					ipmr_queue_fwd_xmit(net, mrt, true_vifi,
+							    skb2, psend);
 			}
 			psend = ct;
 		}
@@ -2074,10 +2087,10 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 			struct sk_buff *skb2 = skb_clone(skb, GFP_ATOMIC);
 
 			if (skb2)
-				ipmr_queue_xmit(net, mrt, true_vifi, skb2,
-						psend);
+				ipmr_queue_fwd_xmit(net, mrt, true_vifi, skb2,
+						    psend);
 		} else {
-			ipmr_queue_xmit(net, mrt, true_vifi, skb, psend);
+			ipmr_queue_fwd_xmit(net, mrt, true_vifi, skb, psend);
 			return;
 		}
 	}
-- 
2.49.0


