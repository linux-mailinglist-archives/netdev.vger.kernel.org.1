Return-Path: <netdev+bounces-197198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAADDAD7C34
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729213ADCEB
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E11A2DECBA;
	Thu, 12 Jun 2025 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D+z43dnx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A52DCC09
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759227; cv=fail; b=MRvMyTGtA7nKOvFRFEhZ+oGCuHqKb+Cw5BgRrKdjIeAT1lWvmExmJ6/kg7lVUjokSypNBNx0P7vjJFhUPaT6EofCSzsNyktbYMMtq9smGighTcgGCAaiqcXwCtZ+hR8/be6g7dXG+RZnlZo4lzYC1VoOL5dC8AjSicf14lBuwSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759227; c=relaxed/simple;
	bh=B8T6a4TfgsKSxUwDr2QK1cS0uV76I7jpaG3e6YtkvZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJwscyCOZEfiPE1KfPStxXkq9PImf7H7YH1RZzLiV3I9+EdqU6+dMdDkhlGHlHaK7u1fW0E/fYLixVbLBvYo6p8F7+USaAJKHSN95ptTo+EdjLrhzlZ6MRYR7NMyc3zv8viZ9lD7y6OeUj1XKFTZAoSqHhQrs/C3HKobtV7PzyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D+z43dnx; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xArDFIaUkJBVb6BslgN4rfLJIqyLlnibeEljIg5DTPKyHzVIg+7AFVvNg3e4y4WBBEfn3iuVRijMLcHaAp4IlGv7iGld6GM5/x8MF1jbZZgsWwIVt6miRN23scCgOsHpHf08B3/XXrH3crZFCLWF1XPg0hlP6qia54xqc1jdLgAByEGmGGPKr3aPFRnYzgIs2QJpEMkffJ0JKVc27CTuFNL73xVimpBaLl3vxDiWnHgky1YyXGgEPck/sMVtz84IA6QIFNDST14z+0kN3we0u7qnizPk4gMpioKnPXO4Y3QtNqVIr++Z5kpUNeyABU4gx7WlPc88OL+1O8X1aQ9c2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orTz+c0yX/sakDgfgxEVACZg1k5Hq1pw/x2hswCjbX4=;
 b=NITVpFX7l6nEsJUMfO8VRIBi/WPZSFCHsWRcuFJVRyy+5ZacgyhaqKeRZ0pNxD83v2mVVNI3dVVuhrCg0vp4Zb1R+tzX9JBtThGwq6e3K3TNeMDsE8O5u78oRZ3BWBzDGSpnztlTgnV9ga1XI4g74NCBwFrS9SLrtni/7eZRW23q5905qY3EaP32WoKW0K958dU4vCy0OSLkH6SqoEswlGiWTXuGuFh+aU8e5n0tdoBPiAcYcHdqJZQe4Spu9CVFzFDfaoVowRKyvW47IN/Tdhm2yzGNvQB7TfN/mUIrwo+wenkYuwAEjbmHdmeuRDOwIN/9DQHpPkXcrw7z0BIjHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orTz+c0yX/sakDgfgxEVACZg1k5Hq1pw/x2hswCjbX4=;
 b=D+z43dnxkuLSWVmPOsyQLwYr5oSqgbFNuPyuYUAuyvDjClx2GWDPbmDTnwFwv4ciUjpSnmyjfZ1lK6DUotM9muRog570KRVogNHAMuvbZG7etoK2ydG1IilAMAxKQLPWTY8etrzKt1TMqEInCy8MOkpzCXldRESt0Qmi+Xq36aMn9Fu4oeaW/skcLISqtp0vIdCvDEpfTKfAilCGIRjHMRVGP9EtjTSCgdzFwirgnAqtkB4ThF8XX8Ll2O9I/J+L44aIRW1r4sbtmtWy9fOs1u1F7GDfnz2Ggf39TBQ04UdDwjm0dYrsOD5H5kXWLeY7Rgq05wky9tHaKoTcd0WRcA==
Received: from CH0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:76::15)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Thu, 12 Jun
 2025 20:13:41 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::84) by CH0PR04CA0010.outlook.office365.com
 (2603:10b6:610:76::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Thu,
 12 Jun 2025 20:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:13:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:13:25 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:13:19 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 09/14] net: ipv6: Add ip6_mr_output()
Date: Thu, 12 Jun 2025 22:10:43 +0200
Message-ID: <175561dc917afb9a9773c229d671488f3e155225.1749757582.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 981690f4-4013-4dc5-b43c-08dda9ed9fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FpABBNFc1m6UfvE8Kjy92aezJEUG/5Jw0rIB+NDmBQbSJCBMgWUYDJ4Y3HkJ?=
 =?us-ascii?Q?EKoSjSgVwbugzpyPkkUFoAoJmRRVpqZcY3fU0vcHgYyHKVxFxsNSJ5nibqZY?=
 =?us-ascii?Q?X2c/0ww+3oQTnxPpIPxvPQVQJghCc4WKBmTy9gStNIfsYjZ/N+Kgw4SXmLFo?=
 =?us-ascii?Q?S5E5mtMN1GOYj8RIqTfLYa6EyBPrRYQZQcssG8SM+ANEXFzWTdg3snFvqoOz?=
 =?us-ascii?Q?AX2YKbJoj+kiVi82tg3UcPWmzMZqb2BLIxryoJft3YH7LhMfudOmjPCzgkA3?=
 =?us-ascii?Q?OP4DJYwzviGtqY38AqY8m7yJIjjMREJQgOL3AuHcqj5xGYdvIVnUwKAS+J5R?=
 =?us-ascii?Q?J0ZNdgOXC30E1qtL4JwEjTcnzPDDJm+WPK41jK9+5EBAdhsLHT0fW1qmu24J?=
 =?us-ascii?Q?NIVTZHYT8AtvtuvQxo6iiWRuNiannQP/3ftydGZnPkADdiC0meY5oXUgBYx8?=
 =?us-ascii?Q?BjB4YWULYDbi6ImbDC3OFX9RMF2ZzlKP1kl4aR7XlgRnkkLqjmNEOMsmKmpI?=
 =?us-ascii?Q?KwgKAsoJ1Uerdr9JUnviSDvjM7M32NMvUNkJ4YtIoFS1YD3hqNKaw+iGcwl5?=
 =?us-ascii?Q?aZMlYsz5nWzAJC/GJEb8jKmwX6JmKhqbmj5H0VA13R/nR8AYxVgWYU0ROKh6?=
 =?us-ascii?Q?Hz7Io7O5zAXihDUAtoStj2qUhFqilGVD2OaOzeze5+bHA7gXfoEUeTSDwk40?=
 =?us-ascii?Q?m+ItCYEW82omRG9VNlG1qYkv5TL8HviAI9R5G0x946rokimv9wdlhwZ6WsB+?=
 =?us-ascii?Q?w9L0NmLd7dLOOOONUBwlhLuu53W0SK8xXHSfYAYmv7u9vjr42cAiaTgfwGmS?=
 =?us-ascii?Q?mJH3JWpL00I01cKDCNuenN7hmkPhnKCYhEF8stQ43QF28C1tOPoTH+HtLLUe?=
 =?us-ascii?Q?k6f1mwKWZtbDTgKDBgmWeDLDD1syOSPhz+hYp1FtMzrCqn2tO+daCVZ/D+0E?=
 =?us-ascii?Q?FosFcnDohCB6AqLjQ9n1afFmnlEIIYGqvKSgJuvVSNQsCo9yRfDDYpQyknRO?=
 =?us-ascii?Q?H/pypyAsIRhl/lnCCZBM9xiE7l67r9dH00UkoK1i8gl3Y19kgRW4jtWrAE02?=
 =?us-ascii?Q?xucsYL5mp5alSzaYcYMyLj54LZS5Ne9Aa6w7FV27SaM1lf5QtFy8lYBWXajl?=
 =?us-ascii?Q?RsgrhjN2uNl/58clDOv1bZ6WFcSDeLvz5JRAwfHufwSK/AtNguTfBCufnuKB?=
 =?us-ascii?Q?9xMjBedQM6xo5zz6d2LyA9rMbGgzWiq4JK+LLtBz5DFwdM4ZktZ/+sP7DeiY?=
 =?us-ascii?Q?VdhGlAGp6ioyMFgjX4N47wp3fFnAAYAJjen3D35LNeQBfu+Mn5zQwM3lGC6I?=
 =?us-ascii?Q?kJK0MCoWlCUXyMZpFBXzMeUEonk0314D3MDoile6Frv3bzQ61oMd1iKqGOdW?=
 =?us-ascii?Q?3p8LDBLStEL6CaqzHHCm9OHKC0PpFoNxHwpsSjLfnKJzEd0CjWi3Ax+EY8Gk?=
 =?us-ascii?Q?pb2nAY5GecFrYdHzLD+jIm/X7dl7O8DShzrV46LUiFlKZFEmHNCkvt04ScAw?=
 =?us-ascii?Q?GgGZty7W3+TxmMZjIpnUx+po/FJyiugAL7pc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:13:40.8862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981690f4-4013-4dc5-b43c-08dda9ed9fd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243

Multicast routing is today handled in the input path. Locally generated MC
packets don't hit the IPMR code today. Thus if a VXLAN remote address is
multicast, the driver needs to set an OIF during route lookup. Thus MC
routing configuration needs to be kept in sync with the VXLAN FDB and MDB.
Ideally, the VXLAN packets would be routed by the MC routing code instead.

To that end, this patch adds support to route locally generated multicast
packets. The newly-added routines do largely what ip6_mr_input() and
ip6_mr_forward() do: make an MR cache lookup to find where to send the
packets, and use ip6_output() to send each of them. When no cache entry is
found, the packet is punted to the daemon for resolution.

Similarly to the IPv4 case in a previous patch, the new logic is contingent
on a newly-added IP6CB flag being set.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 include/linux/ipv6.h    |   1 +
 include/linux/mroute6.h |   7 +++
 net/ipv6/ip6mr.c        | 114 ++++++++++++++++++++++++++++++++++++++++
 net/ipv6/route.c        |   1 +
 4 files changed, 123 insertions(+)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 5aeeed22f35b..db0eb0d86b64 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -156,6 +156,7 @@ struct inet6_skb_parm {
 #define IP6SKB_SEG6	      256
 #define IP6SKB_FAKEJUMBO      512
 #define IP6SKB_MULTIPATH      1024
+#define IP6SKB_MCROUTE        2048
 };
 
 #if defined(CONFIG_NET_L3_MASTER_DEV)
diff --git a/include/linux/mroute6.h b/include/linux/mroute6.h
index 63ef5191cc57..6526787de67e 100644
--- a/include/linux/mroute6.h
+++ b/include/linux/mroute6.h
@@ -31,6 +31,7 @@ extern int ip6_mroute_getsockopt(struct sock *, int, sockptr_t, sockptr_t);
 extern int ip6_mr_input(struct sk_buff *skb);
 extern int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
 extern int ip6_mr_init(void);
+extern int ip6_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb);
 extern void ip6_mr_cleanup(void);
 int ip6mr_ioctl(struct sock *sk, int cmd, void *arg);
 #else
@@ -58,6 +59,12 @@ static inline int ip6_mr_init(void)
 	return 0;
 }
 
+static inline int
+ip6_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
+{
+	return 0;
+}
+
 static inline void ip6_mr_cleanup(void)
 {
 	return;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 03bfc0b65175..fa1e3a16851f 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2120,6 +2120,15 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
 
 }
 
+static int ip6mr_output2(struct net *net, struct mr_table *mrt,
+			 struct sk_buff *skb, int vifi)
+{
+	if (ip6mr_prepare_xmit(net, mrt, skb, vifi))
+		return 0;
+
+	return ip6_output(net, NULL, skb);
+}
+
 /* Called with rcu_read_lock() */
 static int ip6mr_find_vif(struct mr_table *mrt, struct net_device *dev)
 {
@@ -2232,6 +2241,56 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	kfree_skb(skb);
 }
 
+/* Called under rcu_read_lock() */
+static void ip6_mr_output_finish(struct net *net, struct mr_table *mrt,
+				 struct net_device *dev, struct sk_buff *skb,
+				 struct mfc6_cache *c)
+{
+	int psend = -1;
+	int ct;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	atomic_long_inc(&c->_c.mfc_un.res.pkt);
+	atomic_long_add(skb->len, &c->_c.mfc_un.res.bytes);
+	WRITE_ONCE(c->_c.mfc_un.res.lastuse, jiffies);
+
+	/* Forward the frame */
+	if (ipv6_addr_any(&c->mf6c_origin) &&
+	    ipv6_addr_any(&c->mf6c_mcastgrp)) {
+		if (ipv6_hdr(skb)->hop_limit >
+				c->_c.mfc_un.res.ttls[c->_c.mfc_parent]) {
+			/* It's an (*,*) entry and the packet is not coming from
+			 * the upstream: forward the packet to the upstream
+			 * only.
+			 */
+			psend = c->_c.mfc_parent;
+			goto last_forward;
+		}
+		goto dont_forward;
+	}
+	for (ct = c->_c.mfc_un.res.maxvif - 1;
+	     ct >= c->_c.mfc_un.res.minvif; ct--) {
+		if (ipv6_hdr(skb)->hop_limit > c->_c.mfc_un.res.ttls[ct]) {
+			if (psend != -1) {
+				struct sk_buff *skb2 =
+					skb_clone(skb, GFP_ATOMIC);
+
+				if (skb2)
+					ip6mr_output2(net, mrt, skb2, psend);
+			}
+			psend = ct;
+		}
+	}
+last_forward:
+	if (psend != -1) {
+		ip6mr_output2(net, mrt, skb, psend);
+		return;
+	}
+
+dont_forward:
+	kfree_skb(skb);
+}
 
 /*
  *	Multicast packets for forwarding arrive here
@@ -2299,6 +2358,61 @@ int ip6_mr_input(struct sk_buff *skb)
 	return 0;
 }
 
+int ip6_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
+{
+	struct net_device *dev = skb_dst(skb)->dev;
+	struct flowi6 fl6 = (struct flowi6) {
+		.flowi6_iif = LOOPBACK_IFINDEX,
+		.flowi6_mark = skb->mark,
+	};
+	struct mfc6_cache *cache;
+	struct mr_table *mrt;
+	int err;
+	int vif;
+
+	WARN_ON_ONCE(!rcu_read_lock_held());
+
+	if (IP6CB(skb)->flags & IP6SKB_FORWARDED)
+		goto ip6_output;
+	if (!(IP6CB(skb)->flags & IP6SKB_MCROUTE))
+		goto ip6_output;
+
+	err = ip6mr_fib_lookup(net, &fl6, &mrt);
+	if (err < 0) {
+		kfree_skb(skb);
+		return err;
+	}
+
+	cache = ip6mr_cache_find(mrt,
+				 &ipv6_hdr(skb)->saddr, &ipv6_hdr(skb)->daddr);
+	if (!cache) {
+		vif = ip6mr_find_vif(mrt, dev);
+		if (vif >= 0)
+			cache = ip6mr_cache_find_any(mrt,
+						     &ipv6_hdr(skb)->daddr,
+						     vif);
+	}
+
+	/* No usable cache entry */
+	if (!cache) {
+		vif = ip6mr_find_vif(mrt, dev);
+		if (vif >= 0)
+			return ip6mr_cache_unresolved(mrt, vif, skb, dev);
+		goto ip6_output;
+	}
+
+	/* Wrong interface */
+	vif = cache->_c.mfc_parent;
+	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev)
+		goto ip6_output;
+
+	ip6_mr_output_finish(net, mrt, dev, skb, cache);
+	return 0;
+
+ip6_output:
+	return ip6_output(net, sk, skb);
+}
+
 int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 		    u32 portid)
 {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 0143262094b0..86f88fd8b385 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1145,6 +1145,7 @@ static void ip6_rt_init_dst(struct rt6_info *rt, const struct fib6_result *res)
 		rt->dst.input = ip6_input;
 	} else if (ipv6_addr_type(&f6i->fib6_dst.addr) & IPV6_ADDR_MULTICAST) {
 		rt->dst.input = ip6_mc_input;
+		rt->dst.output = ip6_mr_output;
 	} else {
 		rt->dst.input = ip6_forward;
 	}
-- 
2.49.0


