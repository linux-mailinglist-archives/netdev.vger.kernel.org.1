Return-Path: <netdev+bounces-198304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A072AADBD20
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676877A96F2
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEA7218827;
	Mon, 16 Jun 2025 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QcwEENY0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9AF7E0E8
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113946; cv=fail; b=dVUdqbYbeKPC0U1PlX31yhL9fciZEhWSEIQURjr2Hvka1Q4ZMHtdGj3IBv9KkrPb80sHF+jGI1kfCljLWeoUMsvLhzr3SCE/7AA/rJedqL2Vux8NE9VgJnqKvmD2tQ10bcAW1VfIYlJYDjd4PX52UR+7YLwCwc1EIg4b3uC1Beg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113946; c=relaxed/simple;
	bh=k6PbVt3V+wOsTpccoB2E/WAv9dYiGpB6MHFaXXcY/y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9G0Eh7aKVMr7CY7cjF0ZWObMxqpKL4HG+bjC1NPpi+YYVkggUZMlFX3Om1gfqLYrhBMhT0pKF49arj8SlvcUIaMa36xWiijL+0UtqIwzK4uIa6ww7w0u5ZnSsKa9RrVFZMfQwgSpi66rXHirI9V+C/oRLL0uAgqM34pBxl4cZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QcwEENY0; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODRWUjxxvb3kZuD+ekrQqByVdVmLibm2J7QOrCQHztfXHeQHbBNVx+Xx7JzQkt/O7lVk1ke2jGTaUb0IIV4ce3S4RnLVrvj17cYfIzwwRY5qjK3OI84CYcn7+NTHOI1uvlH0V415jhzCqhB6fg6q5qVOXZc1U/Fb3j0t+C4VWw2sEgfnL7iEp8Obb5Pqz/KTneqVCvSbWl0qG8uvc85om3p1pmf92Xum7mgSOfGrFIZXAi1sZg6+uL5fxsL4XvYmo142JYw6UGEEq/jS1x/KC343BBzkTyoEZWlViziGqybZlPg8DeHvzp+FtkvOUZyUaAD7tEmyytqur2xwNViOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heilYdZe0pm5JcdNAB5VUMZVEbxraoiqARvMz1G1rYI=;
 b=hDkmPcbWEr74XFw72A8hWRPU7Lr+AA7BSJBEIFhG24gCpn7OpJxGQfZDHE1iQLlcFiJE9W0sjdHVn1mHZk58l4pnYNjtfoxD06mPPMgQQ7CDLCvP8A9N8Sc4yDybP2bw6UDd2NR4ldw1xbJHgbG4s77OKGL+xrHoi4GTpX4xATTDRleczohBUCweNeXl+h81tp09/7/zyIJ+DMV2dS3hClD+MSof7gGWPaSNOHoWu7B5HiTdJW5ia3seLrUcBIv/p7RHUQ5cOfAxJw+Gw2789pxxTtK1FKm7TNvBlM5TTmfhKFk8Q5RV7X7BrV2zeXlyF88KNbPOtLuyUoUSVTtSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heilYdZe0pm5JcdNAB5VUMZVEbxraoiqARvMz1G1rYI=;
 b=QcwEENY0TP6uHz5lLjsJXcEyVhuP2BoTJYl5XYvHi8iluq9lxyiHcOElbV/wDtVwgVjK1qxsE4WvhcRWJSAbeDmtwdxlZAvQn4ZyHuVDyNAyHWKSCKJpBoBPbt53MzjbGrzwnwinRNi2wFibrDKSCbhdqqBSCTHJ5hj4PI0jNT2Rhvk5kwTyt4CTDn5mswbagmMJ2vkYa1BZvrt4PnvOxgsSkA+T9gP1n1MXtzNBLQjcmqS9Wesf6qVtEsA+btrhR8cWpF97nB55FRqnTb4kg96cnbjtfuNHifBGUvweluDI+zUdZaJJmTQpAdyAbrdQQH2jyVNd4wlQ9Q6v4e66sg==
Received: from CY5PR15CA0235.namprd15.prod.outlook.com (2603:10b6:930:66::7)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Mon, 16 Jun
 2025 22:45:40 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::fa) by CY5PR15CA0235.outlook.office365.com
 (2603:10b6:930:66::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 22:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:45:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:45:20 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:45:14 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>
Subject: [PATCH net-next v3 04/15] net: ipv4: Add ip_mr_output()
Date: Tue, 17 Jun 2025 00:44:12 +0200
Message-ID: <0aadbd49330471c0f758d54afb05eb3b6e3a6b65.1750113335.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 3002b870-01ac-4035-78e7-08ddad278465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dshvquV6VKar5z/S6sY2lz1ThS9Ts3UGFrt+OKpgKkQmNQ713B7hn87RyMXE?=
 =?us-ascii?Q?PfWLzPIrDcWAEBeYFwO8i3oFNT0AZvaJx4rHvlNtNWj8OTvf+pyUpb94RqW4?=
 =?us-ascii?Q?JkEDb8OQ3Er4sume14vO7jZDwHCLa1Z6GNzGdtVX74W8lx9OwY5qTTD/4p8o?=
 =?us-ascii?Q?OOIFFFug4sKp3L8GP5Bo4SxWFMuvvZDXFxtGcbt3Odw4yL6sOWqQ+gJ02lMP?=
 =?us-ascii?Q?FaKFvsWNbNtrms6PAi47qZ50iBS0mnD823ewSY/aPLJMP27osS00ZmBcC6pm?=
 =?us-ascii?Q?ZHnQ/KoBI3Vpl624XoIANq8alvY3M41lblv6fcmMCOAJYuAfU2KSVepbwCoS?=
 =?us-ascii?Q?2FVwudsJQBilzo3PL9+C7H8ebOtm3qLg5V13yDKIfgN6fpURS+CmfWrQBlLn?=
 =?us-ascii?Q?L0c9JgWhv+FDG2Aen0dmMmvuKBIXJ2E/IaWmOWYdRV5mt6JIVSLsRRfJUJ1L?=
 =?us-ascii?Q?Csc4JzvMgAcMezK3lVv383k8xuz8aedArMwPs5QpTdUibtArExXxqEr7QIav?=
 =?us-ascii?Q?j6WbxZ9DWG4JPAGbBXGengHAPJgeyLC0sO2ABkvVkFFESWbtO3WQDXbmh2Ge?=
 =?us-ascii?Q?P3LosTWDqll3TFQbh7I7TW5sjv4Mh4E9cAwzwpVjPGvX78CrL9YEvn8TpPTS?=
 =?us-ascii?Q?VZTCJQgymc+2erlF4reKwUr82f80FPQDZISRtbNiu9p/a73nKaXEbHjKLMcD?=
 =?us-ascii?Q?0BYrQp1ab2s25a4IZi0zPQuWTxPvjLzBLpnetvAjAGOGuV3ODv0AyLwnxU7g?=
 =?us-ascii?Q?//yWu7+uZ6doCJk1Y+AFrNORO0a2UpiIQgZyxb0MJeGf0ZrETqgliVv+Tibq?=
 =?us-ascii?Q?jBfxTxAOIsfiStMON2uTCKA2wjNnO4UHv8XsyZ63pBtgWfdj0w17YHYhd1pc?=
 =?us-ascii?Q?XlFtj7t6oF28+Xvo+G2re2ARRbhK7J4rhlj5a80YVlAQmUqXs977a7bes3Jc?=
 =?us-ascii?Q?GWi7Zdj1OLQ4c04U80fUsuzOSR1bTZsQVRUDUdkJ0nKC7/JaLftbOZwSvBu2?=
 =?us-ascii?Q?Apcam5ryZEO1fYpv9ABe9M9g9c9hWUyTHYmPKvqIGaUI8kxj/Br9er4ePjqw?=
 =?us-ascii?Q?NA2jj3I12nxzPTtltQLcKc7BoeM7uiOpdnJnhPTtjyhMx7Uqw4m0HWF7K1Qu?=
 =?us-ascii?Q?KHiOYusGsHD1bUSMhO0uRTvMKh5pcT5jOIbORljdrXpXvAWRNO87C3laeIaJ?=
 =?us-ascii?Q?AAr4FevEk+3wraFUb5SFCjgX4b1PGuN9tJj6waTaWlQR6uaFpRMUTUR1Mp85?=
 =?us-ascii?Q?NzcDCrd+u1YjrH6C2jTvePrk2Hn1xYC8wYBoF0gAtIPOaRY9BH7zn6V2XeMK?=
 =?us-ascii?Q?iWeC8lEvE/e3zNnqRdiVfZGBY9yZdEuu9QpRfku61lDL3jm0YtUybPmYCJKn?=
 =?us-ascii?Q?Q7S5tWwOBdeRPr6+fi+HSa5heJLqMaPptDVYCFk/iRbT0QGx+NJgreGLWtuP?=
 =?us-ascii?Q?ipP1/YkKJrlL9Ir7xWCyl5pDg0l4izMi9PzeO0syr7jt/s+lZx9ABj5HkHfo?=
 =?us-ascii?Q?/B5OqdTIUDyUERaf7Z/tQtQBncJMSEUjvWU+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:45:39.2124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3002b870-01ac-4035-78e7-08ddad278465
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213

Multicast routing is today handled in the input path. Locally generated MC
packets don't hit the IPMR code today. Thus if a VXLAN remote address is
multicast, the driver needs to set an OIF during route lookup. Thus MC
routing configuration needs to be kept in sync with the VXLAN FDB and MDB.
Ideally, the VXLAN packets would be routed by the MC routing code instead.

To that end, this patch adds support to route locally generated multicast
packets. The newly-added routines do largely what ip_mr_input() and
ip_mr_forward() do: make an MR cache lookup to find where to send the
packets, and use ip_mc_output() to send each of them. When no cache entry
is found, the packet is punted to the daemon for resolution.

However, an installation that uses a VXLAN underlay netdevice for which it
also has matching MC routes, would get a different routing with this patch.
Previously, the MC packets would be delivered directly to the underlay
port, whereas now they would be MC-routed. In order to avoid this change in
behavior, introduce an IPCB flag. Only if the flag is set will
ip_mr_output() actually engage, otherwise it reverts to ip_mc_output().

This code is based on work by Roopa Prabhu and Nikolay Aleksandrov.

Signed-off-by: Roopa Prabhu <roopa@nvidia.com>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v3:
    - Reindent the TTL condition
    - Refold the skb2 = skb_clone() code

 include/net/ip.h |   2 +
 net/ipv4/ipmr.c  | 117 +++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/route.c |   2 +-
 3 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 47ed6d23853d..375304bb99f6 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -59,6 +59,7 @@ struct inet_skb_parm {
 #define IPSKB_L3SLAVE		BIT(7)
 #define IPSKB_NOPOLICY		BIT(8)
 #define IPSKB_MULTIPATH		BIT(9)
+#define IPSKB_MCROUTE		BIT(10)
 
 	u16			frag_max_size;
 };
@@ -167,6 +168,7 @@ void ip_list_rcv(struct list_head *head, struct packet_type *pt,
 int ip_local_deliver(struct sk_buff *skb);
 void ip_protocol_deliver_rcu(struct net *net, struct sk_buff *skb, int proto);
 int ip_mr_input(struct sk_buff *skb);
+int ip_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb);
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb);
 int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb);
 int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 74d45fd5d11e..f78c4e53dc8c 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1965,6 +1965,19 @@ static void ipmr_queue_fwd_xmit(struct net *net, struct mr_table *mrt,
 	kfree_skb(skb);
 }
 
+static void ipmr_queue_output_xmit(struct net *net, struct mr_table *mrt,
+				   struct sk_buff *skb, int vifi)
+{
+	if (ipmr_prepare_xmit(net, mrt, skb, vifi))
+		goto out_free;
+
+	ip_mc_output(net, NULL, skb);
+	return;
+
+out_free:
+	kfree_skb(skb);
+}
+
 /* Called with mrt_lock or rcu_read_lock() */
 static int ipmr_find_vif(const struct mr_table *mrt, struct net_device *dev)
 {
@@ -2224,6 +2237,110 @@ int ip_mr_input(struct sk_buff *skb)
 	return 0;
 }
 
+static void ip_mr_output_finish(struct net *net, struct mr_table *mrt,
+				struct net_device *dev, struct sk_buff *skb,
+				struct mfc_cache *c)
+{
+	int psend = -1;
+	int ct;
+
+	atomic_long_inc(&c->_c.mfc_un.res.pkt);
+	atomic_long_add(skb->len, &c->_c.mfc_un.res.bytes);
+	WRITE_ONCE(c->_c.mfc_un.res.lastuse, jiffies);
+
+	/* Forward the frame */
+	if (c->mfc_origin == htonl(INADDR_ANY) &&
+	    c->mfc_mcastgrp == htonl(INADDR_ANY)) {
+		if (ip_hdr(skb)->ttl >
+		    c->_c.mfc_un.res.ttls[c->_c.mfc_parent]) {
+			/* It's an (*,*) entry and the packet is not coming from
+			 * the upstream: forward the packet to the upstream
+			 * only.
+			 */
+			psend = c->_c.mfc_parent;
+			goto last_xmit;
+		}
+		goto dont_xmit;
+	}
+
+	for (ct = c->_c.mfc_un.res.maxvif - 1;
+	     ct >= c->_c.mfc_un.res.minvif; ct--) {
+		if (ip_hdr(skb)->ttl > c->_c.mfc_un.res.ttls[ct]) {
+			if (psend != -1) {
+				struct sk_buff *skb2;
+
+				skb2 = skb_clone(skb, GFP_ATOMIC);
+				if (skb2)
+					ipmr_queue_output_xmit(net, mrt,
+							       skb2, psend);
+			}
+			psend = ct;
+		}
+	}
+
+last_xmit:
+	if (psend != -1) {
+		ipmr_queue_output_xmit(net, mrt, skb, psend);
+		return;
+	}
+
+dont_xmit:
+	kfree_skb(skb);
+}
+
+/* Multicast packets for forwarding arrive here
+ * Called with rcu_read_lock();
+ */
+int ip_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
+{
+	struct rtable *rt = skb_rtable(skb);
+	struct mfc_cache *cache;
+	struct net_device *dev;
+	struct mr_table *mrt;
+	int vif;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	dev = rt->dst.dev;
+
+	if (IPCB(skb)->flags & IPSKB_FORWARDED)
+		goto mc_output;
+	if (!(IPCB(skb)->flags & IPSKB_MCROUTE))
+		goto mc_output;
+
+	skb->dev = dev;
+
+	mrt = ipmr_rt_fib_lookup(net, skb);
+	if (IS_ERR(mrt))
+		goto mc_output;
+
+	/* already under rcu_read_lock() */
+	cache = ipmr_cache_find(mrt, ip_hdr(skb)->saddr, ip_hdr(skb)->daddr);
+	if (!cache) {
+		vif = ipmr_find_vif(mrt, dev);
+		if (vif >= 0)
+			cache = ipmr_cache_find_any(mrt, ip_hdr(skb)->daddr,
+						    vif);
+	}
+
+	/* No usable cache entry */
+	if (!cache) {
+		vif = ipmr_find_vif(mrt, dev);
+		if (vif >= 0)
+			return ipmr_cache_unresolved(mrt, vif, skb, dev);
+		goto mc_output;
+	}
+
+	vif = cache->_c.mfc_parent;
+	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev)
+		goto mc_output;
+
+	ip_mr_output_finish(net, mrt, dev, skb, cache);
+	return 0;
+
+mc_output:
+	return ip_mc_output(net, sk, skb);
+}
+
 #ifdef CONFIG_IP_PIMSM_V1
 /* Handle IGMP messages of PIMv1 */
 int pim_rcv_v1(struct sk_buff *skb)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fccb05fb3a79..3ddf6bf40357 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2660,7 +2660,7 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 			if (IN_DEV_MFORWARD(in_dev) &&
 			    !ipv4_is_local_multicast(fl4->daddr)) {
 				rth->dst.input = ip_mr_input;
-				rth->dst.output = ip_mc_output;
+				rth->dst.output = ip_mr_output;
 			}
 		}
 #endif
-- 
2.49.0


