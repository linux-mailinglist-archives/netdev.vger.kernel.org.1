Return-Path: <netdev+bounces-198311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B84CADBD2B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9C4173EC7
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4365B2222B6;
	Mon, 16 Jun 2025 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NvsKdDhL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A7218AD2
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113989; cv=fail; b=J+HIc0k0cl06/GWWC5lsTHvQfmlM6Mjy4OMwf2ZckHSa5cY8i7NlZKcDohaNcbAd8fa3/F2Z9KvjWkkbcRlfzZuwa0TEZFA5y9Waj6fBV/vE44I9gH/Eus4cdA18E1ZImx25ZPlioxe9afi6Mk+0nN+5IxIaT5IERC7DzZgRe7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113989; c=relaxed/simple;
	bh=ETMvE4fIufy/k2z2dKXF2Rbc4BSKBtjNb/Ptn4WkZHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ikagx37+d4bGgXpJV2xDe0kYNiLJbTWy09S9qNEkFWuLkeELGy2IZoXwofW/9t3Xb8Y3lLn/kyN/aVyOKzdiDQAmiOWs4SOx7BFHX4J22nG7ljXP2Ca8ljYBpnMQpbT17Eg0HeZox/zZY6FeRwUxD6zPkFUgGq40vBpaiue1GH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NvsKdDhL; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQvLkz0vtQo3Vh/uOI0w9wTWFa9fFG3SnYU4WollrpSwv3jAKCQ8IxCP76Mxr6YwTjZPxnb81PkdohomBW7PR+c3epNL2A2hjGhj6/bONGExLyqSKnjGXN3it9xoGuFPPeFvJGlPRTpgJdKzX6L3y+3b1ked6r2fXPvOM9jelfddLC7iaouG+4W8WnzFBpeJ9DCSBfo9/XR0k+35icNBv3FuU0ghqR+cc/69uHQALZWE4G44HBkFzpO+i1EYvDkLIkjI9m5LC33egP6rv0Rpeostt6R7TflhVkqL2q38kdH+rx8oEcBziLdP+vzCWgfHhNmbS3vqXeZI5hHLnUnY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj/vs8gp11S62YhuFX+M/erdcmPHXgrmIkln7jBiXFs=;
 b=gOEBb2tnHmP2jk3UxVXs2CHpXFJdCcNQod96g90JXSmxDlPMZXsoSlJ/uEdZx6d6zRRkNA+pz0E+ghgtH8p3M7RtMFfMQYguWEhBnLf+0Wl2khGgtP7zTMpuelS6FJ4+T/nPTsOc+hNWtsJd4Pn8R4ZcjPTxEas1IUFt45Glkq0/NM2imu8aaJjuWOjS6Yx1cxeEuykoeBsMGWmLHIXi3BEwXCbGWdbDL45vXZMVem7c+7Y5srMkCh51Z3yofUBAAqvRpTAaEJ9KSpmQyv2Ef/SLFwFbUPkLkh5TwEd9oDmkVA17xkYx/ovs8xpJhqkCBiSVwowdVn0Iekh3d6jgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj/vs8gp11S62YhuFX+M/erdcmPHXgrmIkln7jBiXFs=;
 b=NvsKdDhLb9D5B3VpRu7YnXsXeHxiXKVStkPn5s5MVQurlYpEYs75PlMV9DhklWxxGUgUJPiGpxdZbiwiOQad1JCHLMihahHrF6MtmCx+BvH21TEnHyJe3xMsD30BATk1aJydMGVVb1PWMq7FryBe00fHBjMgst+6byVFR7ZgcVtke2sUBhlK7orLzmL0OUJG0zdS3IZEtBvGwPwmAfx3/czE7kTwo3hx1IbxA+Cm+SBYHFLETa3HF8leQzQcpeXZtYUN/ru8YM2q5xhVrCas3IXKiLqWN+tI9Mwsyy0hG0fxE6A6ZJYyDVocaAwV5doc0hh3J4/LegRZ9TkCJV6vWA==
Received: from BY5PR17CA0052.namprd17.prod.outlook.com (2603:10b6:a03:167::29)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 22:46:22 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::d5) by BY5PR17CA0052.outlook.office365.com
 (2603:10b6:a03:167::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Mon,
 16 Jun 2025 22:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:46:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:46:08 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:46:01 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH net-next v3 11/15] vxlan: Support MC routing in the underlay
Date: Tue, 17 Jun 2025 00:44:19 +0200
Message-ID: <d899655bb7e9b2521ee8c793e67056b9fd02ba12.1750113335.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a321a1-9e5f-41a2-8de7-08ddad279de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqq1XHQ6D3q9NKQSxOR2aKpsjFfj8wgn1I41lO/PBN/D4hfzQbbgEKdkEgHa?=
 =?us-ascii?Q?OzgvthKKzpEzyNa+nkzg0dzgv14edYRkmWLZ5lwjYsV5ehXNg1aSCGzBlRWu?=
 =?us-ascii?Q?9ZCAbiVehGPM1RC5JUzrePJIx+zeCgN66dStOQoe5ckE6NwA8tq963sS37f7?=
 =?us-ascii?Q?G6QVTj3OroUONu2AdTm2a6DH2BhUFu9mO814sWGUb46HVwbjYB6uPUaZxD82?=
 =?us-ascii?Q?O7dV3CVHZjXAjfSOE/jvceX23p/7lmRUgPUTR3LESc3v9Tr0TCemvkFicqtA?=
 =?us-ascii?Q?Um7U4vgxdJmvqC9zZ2Yz0o8KCLKanDk68xtD4k9B/zt1nwf7zIgJVB0ZQH7G?=
 =?us-ascii?Q?/zw+1rSkhQhhGJk2cm3AjXZi3vtgUqx1U+pL+Z3NCrUcBYXNJoJg6FKHs/+P?=
 =?us-ascii?Q?5eRxd3FvDBUjJx4KEQ9dwMj7UWYcpMW9LOHFRmLUW3YQ8lYyPODl7wX6/0bd?=
 =?us-ascii?Q?cwXoWu4pzxVyIhMnpDHFJX027S2O8YZ9ntjcYO1D6Hipuhqm+T4YFAmKXGw7?=
 =?us-ascii?Q?EeqyfkgfaWa8b8XSyQHK6uvsexzc/vrJHRrkqlhTsa42r2PEmBIrczKn5ZYa?=
 =?us-ascii?Q?ore48VhZp/fMclk6aNjCAg4c66B0E6/UrB/kbxrhaipWL8Zz1JkpWVWCSad9?=
 =?us-ascii?Q?1oh7B1Id8HBruifrf2K3+RC5aDLeP8XMeNmyLSnULNy3pFmWxiaVw95q7sjq?=
 =?us-ascii?Q?7PW1U1aKvRDKWqfEEAdtUVfPvdxUS8c5XV/LDm+juYDjR1DKdduUSQGtqNE8?=
 =?us-ascii?Q?RyLSAAVTouA5w5z4rZfW+7mw4URt0GoJpwdjCc9IMMIC+IPC7PDKxJrMS83S?=
 =?us-ascii?Q?saua1lWSgDYrGsziQGSUX1pLC+2GWlu2+MAOc+rhWL/usR3qIWmvWXq0TRXU?=
 =?us-ascii?Q?Cf02fSiAnBHG570JIPNqBLc49XGAro5RsRBMF1oUKe1/eP/VqMQaAhIIowyX?=
 =?us-ascii?Q?jvZxh3zlHYPdQ8pFWCWDeiH1Y7D5dYTHKYe5aUYuiyf5Obg6SGq2HRUBd2jB?=
 =?us-ascii?Q?zVp+WnA6IvJ6uiDDUdvrSY0nqdP40w8P5VDN37hPchoAkRhssF4y0ZHlpQ02?=
 =?us-ascii?Q?WrBdoJ4rT7fQHWQBYGEFyxtFEF0ua4tBaZecwqfTlAi/g9HtaGJ0J8GOikpu?=
 =?us-ascii?Q?Eej641ooQfIrXhSLvuqZJAi7jcPFGzZ6D7rKvos9lAMYxfcSYC+IgcPG6bjX?=
 =?us-ascii?Q?chVQOKoAJrCpgkiBbwGPRc2EnkIsOb5YjyZMcYEbqi4MJk2wnRiiS/nlr42Z?=
 =?us-ascii?Q?uVrofcjB0sAYrMHBwFzG0mdkg9w5SYwIufbENtneA2R/6Zh8j3RMO02fPNGD?=
 =?us-ascii?Q?TTaiCMj/K2VttpH2RNIFNViMWDzHfMXOe7sgT/lJq+ReHyfAPph29aRpdGdG?=
 =?us-ascii?Q?0dd1ERjD6iHmxdV/T1pHUAKWgyOW8GeBzU6tJ25v5w2Vi88/To9KWAMTF/f6?=
 =?us-ascii?Q?DQ6ZDYXYZC+NUhmx34YhzlRiUBE4XlyHuLZAA6BUsL0QkEbxGFDpX9N6JUof?=
 =?us-ascii?Q?x62zbpPrwzeSiwlmtn6ck1GZYegrb7itIrki?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:46:22.0376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a321a1-9e5f-41a2-8de7-08ddad279de4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704

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
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Menglong Dong <menglong8.dong@gmail.com>

 drivers/net/vxlan/vxlan_core.c | 22 ++++++++++++++++++++--
 include/net/vxlan.h            |  5 ++++-
 include/uapi/linux/if_link.h   |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b22f9866be8e..a6cc1de4d8b8 100644
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


