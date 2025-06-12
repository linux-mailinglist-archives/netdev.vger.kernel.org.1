Return-Path: <netdev+bounces-197199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B2DAD7C3B
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F503A406A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F712DECC9;
	Thu, 12 Jun 2025 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LQHAsy6d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363F2036EC
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759231; cv=fail; b=YO2eWdXb6NlN7scsGm1vc/5ls9bAU+mhb6Hxc5Kjtyf8PulLqgci+2f+LZ7nLDzMvbqb1qZdi31Tlczu3d3uH0WxQjI0CzmDZBU0dqj6RixUdaLm0MkE4lEcvoLZ41ZQ650r4Yioer+xQ0b58hnqV09IzF+pac+/aYqPjaoONIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759231; c=relaxed/simple;
	bh=DKIXmeoc4VBV5LIN5U0pO5QgozJzuyngI05R09mlHJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FR6ungi60/eyFL3dSIt1cGxPtVOAyoDCTR+QTcRVujftC5nqQ2w6aFloyCwa2XjvSPJl5Pa5+PBqCYkVg+4oYrdbf6+lxRNJ+XKzKpBWvKLk1y5lThlk7SfE8IyWtkxt15goAGWITZsr1sahWcZcGhwS5qaN1yX8CAH3QYokmGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LQHAsy6d; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuA0shfpvbdg+xDn7Vos1Di6X0KpA/QM0hSnHncAIgo9UrlDLcugbPo2jqOWHmnECXnfZWGE0IV0GBQiJN++z+i7PdJCunJBpcTmW0ViQ4JMThwUlLOZvVNNgeGoKEpUyaH6gJIMjcbk5zerW83bxNfW5J7w8gFdoWPSNC5pOqbUb5yMb4RAd+FezQMcJl4GlAE9ucmZH9Dx6TLd3wAQmlbjp7Q/DeVkqXq8UBcjK0DMtj8iIlmu2qrTgBIp22e45Kxcwal4s5nNxDePtCz4rR/3IFrE/Obc220I/AdRGwAPPRyDwlHbu+1hKIgeAU5fXREYyiCYHpksOI+ZscmEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usKWZfBRidRmU+gSrs586gqqy8mfO4iE9iO9JLK9rGE=;
 b=tAjLPO9e9ZL4HTDufNVjKoEgetNAx2A26UBYYk0BASkzI9j6K5oqwzDdJzbiwEreM45s1hnviwwPAFS19Drlc5Q4d/MjyOEIIz3HwfTpEjfLYgxrksxHN1o3GsnGNYnShqL3gWmOjDLfPTI9PGbp2o1eA3gOBc+RJ88GV/AJpdvuq9L5k7vjyMrhyv59DSr+HpYjHiIj4g3KH6lYNM3lVH6WmxO7m0Uvaaf6z7PqkhXtnzEQ9bZke4WXvo9jJ4nP25rM0bLcRite9qejyxLMLBPOowoUQHIVyzKSC32k4niWxoUe/hxxf+9vgp/N/Nx67uqchKAsUgDOq78aXbz0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usKWZfBRidRmU+gSrs586gqqy8mfO4iE9iO9JLK9rGE=;
 b=LQHAsy6dOvR4X51RshHQGC99DeoCj+2D+5kGoeY15rpiHcAwEL0D8Q6ETe1befsDwtAPSQRW/MvNzPKoX7+vX8UAfsqoz+YSitiULbtmy8VWOIQIerznR0BZqmw/D6tnZMhw7/NUJD3V3mDB8vZwWLqNqlG2+eCjKtwpnkDEndTnM4nSAWajAcZAFmd/UK0htbh26Bg8NZMy4tfQl3oe1l9zSDhppiFJyDjZpqIb4wCq/gf6dwgjuzmop3OEktTTxqRR1AjcoxpLufmDHmt3BPWzXRK+6hEuyTZd762id557+XGCblIKODZSNiCWfG7Iu3UGOkreh5C1ORAJdgqAoA==
Received: from SJ0PR13CA0053.namprd13.prod.outlook.com (2603:10b6:a03:2c2::28)
 by CH1PPF6B6BCC42C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::612) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 12 Jun
 2025 20:13:44 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::cc) by SJ0PR13CA0053.outlook.office365.com
 (2603:10b6:a03:2c2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Thu,
 12 Jun 2025 20:13:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:13:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:13:31 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:13:25 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 10/14] vxlan: Support MC routing in the underlay
Date: Thu, 12 Jun 2025 22:10:44 +0200
Message-ID: <d28769e72f6c66ee4e5c008593d513f671b99999.1749757582.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749757582.git.petrm@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|CH1PPF6B6BCC42C:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a43b9c4-b9f0-4ced-15af-08dda9eda135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HgYCb79FSj3lyGrwQEZfQU1mi4WH4fkm2inlkn8+frKUM/DI0/byzkQCvQ4k?=
 =?us-ascii?Q?6Qqlp8VfGg6Wrn/yaRyYfmRZApLEGchqafkI8JYDMoOjLCy2eZLUu6hTtQ90?=
 =?us-ascii?Q?my7COLFX7Ccx9gb1mHmsm5ViIdZQYlCONZjbZ2A8tvl7BNyDfXIXuBX9ozej?=
 =?us-ascii?Q?pfUABxIfeA7lBoESpMmz96u/ZLxyQaAw4hz2Ul8M6myWDhYm6/XeoGaQL07/?=
 =?us-ascii?Q?lhBUrcwlp6ONF2AY54fwhRbh98IjrDPg5xi4RAcm3VIeHD9fEFXDVIsOx+Gw?=
 =?us-ascii?Q?+/neUsgeM95emCD2XT6vXVxD2QgfPaQ9emW4k8xJsvltvlBryb7CIVO7lqwg?=
 =?us-ascii?Q?DYaW3GJnMcsBG0b8myYGnLCU6di2dpZ473/S0B2vzyLAV/R7ZCNgM3+l4iHy?=
 =?us-ascii?Q?mridChARGaEjhkQ6Na2EGbJtxX60Eu7zJBXyixS/6pEcQuR6uOqKNBEO7A9R?=
 =?us-ascii?Q?QaRdaNmAJQSvrPLOnisSic8Ekvl7poP78T2f5f/YD7HSuy5ulv6mQ0v7pb+y?=
 =?us-ascii?Q?I3C2wVXKM+EC8x+oSf6T/X/JmyzcVqszdmUns3mSHZ0FR7waJ/tgwaouwblk?=
 =?us-ascii?Q?1aLZ0mdROlUqV5NSy7T8mJurJpx5T6ZbG0h7/KfExdmRTJeKhLcsnthtBEA3?=
 =?us-ascii?Q?KkL8S/CNaVCVG8+lSu2N5XIro3j1LolCuqSBgnQAk7Q4DFwJg1/mPA1R3Hgy?=
 =?us-ascii?Q?+v2yZzGIA7xWd6BS28ZtLr4btI+lPjw9Kmh5IyekcE8/6DE+4iohY89WKHux?=
 =?us-ascii?Q?qi9pmpSE23OIHniIUkOGZRlvqnYR0wJ8rVGwWkYPJXhqWdOsMu886R35PJCm?=
 =?us-ascii?Q?DMqVR3mL/C6v21/wDKSDLDsJ3SxyEW62utzv0sVsU8eYAxtas4Fd9+Pvi4kO?=
 =?us-ascii?Q?yXAE7H0GCABA+R1dLVG1+UNr1su2Vrbwj1G7+jMV+ZNag/V27CtpARkjNiny?=
 =?us-ascii?Q?lsG8NYeIs76vxLQLLC+kDh7Iswb4HtH9+XiVoCRTwdO6WpodDrabdhW1zhbA?=
 =?us-ascii?Q?upHuOmqt5+TzzCGKfSADg8C6Fn/HswpfuKUZSTSMH0A6gkI/nYHIumaVnhi2?=
 =?us-ascii?Q?uiGbrAVmyDAkjuAo3w0CjOJYMhbsbCQUONo8NSSt09lBXZgKnQCK9i8wVPXr?=
 =?us-ascii?Q?ojkwQDTcca2pMLmfg+/3FP8o4VDtTA1mPI0rcWNZSUeI7LFcVP7DN/0KgSYd?=
 =?us-ascii?Q?YuxLVEm6mN1lrmJ7bSnbXgYPAEJl6uIy3zZ9vhu6ZBiDxJTZgB3qlqqUtkHF?=
 =?us-ascii?Q?c7TR56saqflcthe3d08FJAc+pbuiisiQY+e9eMDdo6OcW3VS7JAOOWs/m6ZI?=
 =?us-ascii?Q?MDk8skJFoLI/ar1V4vaAAQcB81/NRT4HjRQ1VpS4V3yxGjftYkiRiUJQZazI?=
 =?us-ascii?Q?fjhPTQHyBwRJJkHnyfkkXwmRYBu20xq7AkWqP7IBYppmLIYSPchi157mp8SC?=
 =?us-ascii?Q?5M8XrHgmtnaRiKJIdfqLRHr2gNjAY5ESsmp2tikzxjScKHkE7qjdwTJ1KDKL?=
 =?us-ascii?Q?uyppHFvlYtthebDTpgb3ht1qDZpPccgR6K/q?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:13:43.2898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a43b9c4-b9f0-4ced-15af-08dda9eda135
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6B6BCC42C

Locally-generated MC packets have so far not been subject to MC routing.
Instead an MC-enabled installation would maintain the MC routing tables,
and separately from that the list of interfaces to send packets to as part
of the VXLAN FDB and MDB.

In a previous patch, a ip_mr_output() and ip6_mr_output() routines were
added for IPv4 and IPv6. All locally generated MC traffic is now passed
through these functions. For reasons of backward compatibility, an SKB
(IPCB / IP6CB) flag guards the actual MC routing.

This patch adds logic to set the flag, and the UAPI to enable the behavior.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
CC:Andrew Lunn <andrew+netdev@lunn.ch>
CC:Menglong Dong <menglong8.dong@gmail.com>

 drivers/net/vxlan/vxlan_core.c | 22 ++++++++++++++++++++--
 include/net/vxlan.h            |  5 ++++-
 include/uapi/linux/if_link.h   |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index c4af6c652560..02eba9235406 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2451,6 +2451,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	rcu_read_lock();
 	if (addr_family == AF_INET) {
 		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
+		u16 ipcb_flags = 0;
 		struct rtable *rt;
 		__be16 df = 0;
 		__be32 saddr;
@@ -2467,6 +2468,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 
+		if (flags & VXLAN_F_MC_ROUTE)
+			ipcb_flags |= IPSKB_MCROUTE;
+
 		if (!info) {
 			/* Bypass encapsulation if the destination is local */
 			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET,
@@ -2522,11 +2526,13 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, saddr,
 				    pkey->u.ipv4.dst, tos, ttl, df,
-				    src_port, dst_port, xnet, !udp_sum, 0);
+				    src_port, dst_port, xnet, !udp_sum,
+				    ipcb_flags);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
 		struct in6_addr saddr;
+		u16 ip6cb_flags = 0;
 
 		if (!ifindex)
 			ifindex = sock6->sock->sk->sk_bound_dev_if;
@@ -2542,6 +2548,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 
+		if (flags & VXLAN_F_MC_ROUTE)
+			ip6cb_flags |= IP6SKB_MCROUTE;
+
 		if (!info) {
 			u32 rt6i_flags = dst_rt6_info(ndst)->rt6i_flags;
 
@@ -2587,7 +2596,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
 				     pkey->label, src_port, dst_port, !udp_sum,
-				     0);
+				     ip6cb_flags);
 #endif
 	}
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
@@ -3402,6 +3411,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
 	[IFLA_VXLAN_LOCALBYPASS]	= NLA_POLICY_MAX(NLA_U8, 1),
 	[IFLA_VXLAN_LABEL_POLICY]       = NLA_POLICY_MAX(NLA_U32, VXLAN_LABEL_MAX),
 	[IFLA_VXLAN_RESERVED_BITS] = NLA_POLICY_EXACT_LEN(sizeof(struct vxlanhdr)),
+	[IFLA_VXLAN_MC_ROUTE]		= NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -4315,6 +4325,14 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 			return err;
 	}
 
+	if (data[IFLA_VXLAN_MC_ROUTE]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_MC_ROUTE,
+				    VXLAN_F_MC_ROUTE, changelink,
+				    true, extack);
+		if (err)
+			return err;
+	}
+
 	if (tb[IFLA_MTU]) {
 		if (changelink) {
 			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_MTU],
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index e2f7ca045d3e..0ee50785f4f1 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -332,6 +332,7 @@ struct vxlan_dev {
 #define VXLAN_F_VNIFILTER               0x20000
 #define VXLAN_F_MDB			0x40000
 #define VXLAN_F_LOCALBYPASS		0x80000
+#define VXLAN_F_MC_ROUTE		0x100000
 
 /* Flags that are used in the receive path. These flags must match in
  * order for a socket to be shareable
@@ -353,7 +354,9 @@ struct vxlan_dev {
 					 VXLAN_F_UDP_ZERO_CSUM6_RX |	\
 					 VXLAN_F_COLLECT_METADATA  |	\
 					 VXLAN_F_VNIFILTER         |    \
-					 VXLAN_F_LOCALBYPASS)
+					 VXLAN_F_LOCALBYPASS       |	\
+					 VXLAN_F_MC_ROUTE          |	\
+					 0)
 
 struct net_device *vxlan_dev_create(struct net *net, const char *name,
 				    u8 name_assign_type, struct vxlan_config *conf);
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 3ad2d5d98034..873c285996fe 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1398,6 +1398,7 @@ enum {
 	IFLA_VXLAN_LOCALBYPASS,
 	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
 	IFLA_VXLAN_RESERVED_BITS,
+	IFLA_VXLAN_MC_ROUTE,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
-- 
2.49.0


