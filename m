Return-Path: <netdev+bounces-198310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4FBADBD29
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4373B7C06
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAFA2264A8;
	Mon, 16 Jun 2025 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DlfWBIUC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C722222B6
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113982; cv=fail; b=RQcbOIXo1IsCrdwfokV/czaw+JJA7rV1MVJImkLnDK7BtDbnDJKuM4iY6rH+ZtvHjaR15fRgQ/1dGriZlvT9TqO7A6UARk6IlSeBx95ytCIOkadSkHi1qXb1REZepbQeAo4I2kkUsAoZW8ggvU/IG/qbfkxacMaqWPp7YPkoZqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113982; c=relaxed/simple;
	bh=4X4xbPKGwpj0eRlwo4yZEhSI24f6DeHbwIw2YrLWy3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvAC1SzTapnO82ZAuZ6eHgvWzTSaH4LvVQj6u0fT59plFjWjSB5umLpSKeKKpkO3U6IuV911b2d45R7o+tUsrxlq9Fh2XEwSLBqTbARPxubl2MZTP/h+DcF+x50ayfTSWncLW+bLft8vrAHT1koIdg+3qLA6t6Re16f8Ibwi0Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DlfWBIUC; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3IUgpdHjWclzdyjEIj0QRwqK3XYOSULG4lP0MUgA8lViDzIYsisssR5+djCGH1pnj3PJxt03rlWON6pBNXccKao8Ycsw8CuJR4DxU2hL28kKcrpaOI2jefogo2PZtw0vd+SQ8Y3fTUZeHqUx8rkzyhFqVFxelc0OX8ba3NSt1gVjKY+ZJjsMED7Ht2y39hC4kxn8DHJXnXqbm7v81DbaTxjMv6HkCVZ+n3ZYPiaS8fbDZRfsPHHSLXvSMI8CAka2uvRD5GFCozdOjJvKV9zIZq62o39VoE2veP3JNy5QgUoU95nGRJ+4Vyak5pZGXmRnn7/a/Zm82YQZRtHXc1oOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oz1qygwl8WZG1I5bJO3IZ33/pidQcvxD8A15jcV0v0=;
 b=uMvg1JqsBlTp+U5pW7TiyxRPpwWOL1Buk40g2ax9nmyGmzHDkUSmOVIlItNKPtfCIqWBgM+Nht4khzTAxi4wdeaL85eg+f4iu3yIam/fjMn33E4gXPLTQwvWpBYk52TsGrqPVX1KvT5lEognKQJGqrP2lUeQkkww2PbyPGYufBpyPS91jb8G8JPmLE1RK7wKiTQfXO1O89pv9ngRfaV+TONe0zUcasayochMIeRYzJflp1P4MWoFiq8tQbrfBTYYQcraW3brY+K7+q85bCsAM7toTy/IafdC9nDTJj5dhQkZVcjzLeS3gEb6kUo2Slvqkajudra7TQGLPwXIdai7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oz1qygwl8WZG1I5bJO3IZ33/pidQcvxD8A15jcV0v0=;
 b=DlfWBIUC6ugIPmLX41ytUsVNZrL4r61Yp1XeRDcVS/4qElMRgINTYqluQL7Zg8pgnrqrhfwj8kIP+Xeg4CCk8uHHajIESTBIW6TUbmcxfDbD7JVPYYQS/UHCXjJW6lorc6hsMTYK/1wkRJX8GPKtA0zTcjQkW7c1txRwOk1ZFqsdsok18pjOhRDAJfUQOx0/srQU8KEMa9A/q6wYFsY8I+NSevv+fAGJDCHC25US35NAMOIKabY5qliM/flWw3U5ebvhD5d0097jMOo7+TNBXWJ0N3qit68IGmuxgrrHshVI3YlbDT0mMMqTau0atboC6FjuCgG7aeJFP+llD6u85w==
Received: from MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::24)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 22:46:13 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::b0) by MW4P220CA0019.outlook.office365.com
 (2603:10b6:303:115::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 16 Jun 2025 22:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:46:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:46:00 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:45:55 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v3 10/15] net: ipv6: Add ip6_mr_output()
Date: Tue, 17 Jun 2025 00:44:18 +0200
Message-ID: <3bcc034a3ab4d3c291072fff38f78d7fbbeef4e6.1750113335.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SA1PR12MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f66dace-2c97-4d5a-1c28-08ddad2798a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o0IlltkPDCbWl5grl6DLrln2pGG8azBiXRyrkAXBW6qVofJNj47yv4EPDV+X?=
 =?us-ascii?Q?5elD6wiYhgURfC9QshbbNqMTNwRZS58FBAJlTOQm0svBAF68vivhKiRCGoMl?=
 =?us-ascii?Q?ZazgslUvq5TWEPCbbZ7R2m4H1fWmY+ynSVnaU+t0s0MPxqRqh/APufsXKIny?=
 =?us-ascii?Q?o+M5YUmo7jZOOokS4iAFPq2SoLMzpwtykdEKZFxDuFO4bpPx0MPVPpJNDvWT?=
 =?us-ascii?Q?zrdUJsWJsX+98d449LP4zUDSS/CesK5hQYN55xzFCRCINTpP2SBj1W1BARc+?=
 =?us-ascii?Q?J1BF56dWdogW45+CxoRs0jZVd31Um5ST3+jLl8hngm+Ynucwim4Y6Y0KSDzI?=
 =?us-ascii?Q?k13PyCNfv102ERHdKEtDgrowjYjhJyGFywjjDEJ5Qz2iIYfyrYDlGEKonaIc?=
 =?us-ascii?Q?httqc+jkBK1ZfUYRi8VCZlCv0IzDtL2jEYK59Y8WhEs4dxWYUqzCYKqo/NUb?=
 =?us-ascii?Q?vCMK/TZ8D1XrfkAEnKm13+rBBOneLS76T/U7kYSGJL7nHaYyCqbybTGh0Ja1?=
 =?us-ascii?Q?Pl/MLBmIjKuQhLKLi6mo0HLQxKMqRm8zYS/7ASrdJFw9ZPg8NgfgEaYOHlRV?=
 =?us-ascii?Q?yTiHsUahwibYzTNIbFQYmWJY0VZyOVdz9CYIM2rjB8eCHz2a9KTtEZrXUtpD?=
 =?us-ascii?Q?Gv2XnhxuaANm4N48lxq44fyDpeyF3aXqgQwsnTFxBWOgUwukNdkn7IKVrC7q?=
 =?us-ascii?Q?gjNf9vllEMcmqGEFi9Irxs4T9dhqLkuHDNV074WnL7i8e3/5rdawi4ECJtlX?=
 =?us-ascii?Q?Hah5vAVVbw12HYEKBcj2e9Hx5Fhl5n1eNrJcAA+wjl/QockRWBaIgpvwXk43?=
 =?us-ascii?Q?5kcfscSO6CZ7DhR4nKJc8tmR4FpOvjYvncrG/Qr4JldCuU8Tb4w2oaYEVJwq?=
 =?us-ascii?Q?CmYOvQ/0aQK11HL/B5JbUvbdwV835VA2AlbuDF3j4qEv12xnglahy1s3WcQY?=
 =?us-ascii?Q?rD9hqOfysTglN14St1eNC+nSuVjh84McIqNLqf18/APEX7Mv6aeCRRdo7ZTX?=
 =?us-ascii?Q?iH+7RcO+ndlwupUoMGdBAtQ5j6gn3V9OrCNarc+b+TsMWSadzJJRrf3G4cvN?=
 =?us-ascii?Q?QHV+A1wcC6KBf4w6uWTf6B+6esMYeaUYr13bGp7qujFwV3q/dWkvVFKFDzvT?=
 =?us-ascii?Q?vXUSa+YKwO1KvjlzmUwc6OKcuPg4G0+3K4+C/UcDJ1PYnkcnz2/HnXA8Evus?=
 =?us-ascii?Q?m66k+0wmlI8z78RHFEsgCo2hPYjL62gHOIdN94wx55q5x0WKfRYn4aphh+Wj?=
 =?us-ascii?Q?Dw5S/ewe/+YZwHHeu5W7aWCb1xO178W1nJdlByv/Lkmyd8Z5H/Rs2tNYBx7l?=
 =?us-ascii?Q?CrtfW0wq3mHUutHsdMXQgkdaNoTNIoe4YCAqkc3liOyLEIJQlxlhqTfkcNdU?=
 =?us-ascii?Q?/0hmhuMgV3HQB09d9g8uGNTVWVhXekBFSKdCmqWbx/5XkRbXB1w+jxnm1nZ+?=
 =?us-ascii?Q?z6suDNRicagFSrhKK5R7byFwFDwKvmiqsN2lWDw9W9YnI05jUo1ugzRahgEU?=
 =?us-ascii?Q?WQ3MB6pjTniTcPB/0tuN9FwUcbBKUtzPpCoZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:46:13.1746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f66dace-2c97-4d5a-1c28-08ddad2798a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860

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
---

Notes:
    v3:
    - kfree_skb() now needs to be in ip6mr_output2()
    - The fallback version of ip6_mr_output(), compiled when
      IPV6_MROUTE is not defined, needs to call ip6_output()
      instead of silently leaking the SKB.
    - Reindent the TTL condition
    - Refold the skb2 = skb_clone() code

 include/linux/ipv6.h    |   1 +
 include/linux/mroute6.h |   7 +++
 net/ipv6/ip6mr.c        | 118 ++++++++++++++++++++++++++++++++++++++++
 net/ipv6/route.c        |   1 +
 4 files changed, 127 insertions(+)

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
index 63ef5191cc57..fddafdc168f7 100644
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
+	return ip6_output(net, sk, skb);
+}
+
 static inline void ip6_mr_cleanup(void)
 {
 	return;
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index bd964564160d..a35f4f1c6589 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2119,6 +2119,19 @@ static void ip6mr_forward2(struct net *net, struct mr_table *mrt,
 	kfree_skb(skb);
 }
 
+static void ip6mr_output2(struct net *net, struct mr_table *mrt,
+			  struct sk_buff *skb, int vifi)
+{
+	if (ip6mr_prepare_xmit(net, mrt, skb, vifi))
+		goto out_free;
+
+	ip6_output(net, NULL, skb);
+	return;
+
+out_free:
+	kfree_skb(skb);
+}
+
 /* Called with rcu_read_lock() */
 static int ip6mr_find_vif(struct mr_table *mrt, struct net_device *dev)
 {
@@ -2231,6 +2244,56 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
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
+		    c->_c.mfc_un.res.ttls[c->_c.mfc_parent]) {
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
+				struct sk_buff *skb2;
+
+				skb2 = skb_clone(skb, GFP_ATOMIC);
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
@@ -2298,6 +2361,61 @@ int ip6_mr_input(struct sk_buff *skb)
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
index 79c8f1acf8a3..df0caffefb38 100644
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


