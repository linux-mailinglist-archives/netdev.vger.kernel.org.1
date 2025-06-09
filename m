Return-Path: <netdev+bounces-195856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5DAD281A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEE3189416F
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E655221F04;
	Mon,  9 Jun 2025 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QihKyeq4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972B221552
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502346; cv=fail; b=ZDiB6jQtf9vvf8YVrRO+dRK4wQpDqPE0AUNDoMKHf0u9cbvKQzXYK1TYIIa4MgaIZchetQRUABv0swFud6zvOo+D/l2UX/Mvyx8bfYsulWa9k5MHC9L6D2DqUSG+7V26ugQi4eNdL/FlguZej6YGXL1xtd6rbgSKQTg1XZbKIeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502346; c=relaxed/simple;
	bh=5hDgFtwkXvQ7TT4EhhczG85mPJTwTkn+dzfAufXuyVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uS6dynhb4IEpyc43Gzg7yk3pXSel0WrH0uS+UIokh+20E/aOu4NowkxFOFfcu7iOV0FUtoaZUrsr632aQ2QGtga9Fy9qJB/k4X19/kJK+dv9bUDR3uIfJDsO1V2O2HJOfbrCCxJ2XffYQDqlf/UUJjf233O72lZehbjM4VbdZ50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QihKyeq4; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr2ZejTPxZ26nDyh3aM9xcE4/bnYZFrnckq7cu4zZg2QEGYBzE3K3OPXrHvzjAH1OXjQs4IKKU3bzTtDU4KKsCcpZYN3QPsDU046JEASxoPTc7JgqPfs5pTDwVP4tXqC/wJGJPN22aPfjodTRAL3SrxbPYMhAOpPmgPRHceyNtZomj67sDK3f2y0BzjYLEhDFvjWNq/9LrRU+jyInA5Xdzaz4cm8ud9+hQHVM3M2gmMGp8DTXTYkpGHUT8y34d9hFaVV3FQEnfbG2GgPvCoFv/zJXwUQECJqO7UX5SWV6snYhwPr6PXbkdGPzvKsbYVOYoR3uHMw7mtol/v9S+zUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT/iVRmn5HJ6o/BVHy9w8NA8NubBanLb6LsuB767Qig=;
 b=jmGLCYNz1NvxFo0P+fZQVZCdYhvo9XXDefOkb/wnyVm4riaAaBfDk6OQRi96Z1LgWempjDU3R6aW7F1EJgt6CtpRAgL6HbL1RDXh/epAL8zo6wOZxz3qcKs1oVJ/cfIiCnRUWXHAoX1ySDNmw1L/NZfbvQVuSvRxuRpaTI5wBc38YOmDPqQRgK/p0ZwpHOe9LWH+nIKx8A6XFaIoriXCzaPYwruNa2cLvNj2PGPDHb0zofQO1b3hmLy8QY7T98nHTIvLeOTno8Evg/y3LrghwtGzuLTUsZigrfUeRBSwj/yW2hbwndOTsGzORZw7q6B72RTNYFNvRuLfRUNDgqrUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT/iVRmn5HJ6o/BVHy9w8NA8NubBanLb6LsuB767Qig=;
 b=QihKyeq4DVskuHAViav4snA8Bz5l/8nsiPkk5bubvABf8Pco1PjVWuTzzdBNGTykEP3N+AxUp6A/SyD1g1EjVa/cYB4TGZhm2UwaQKVTY82DTaxFn1TKMi9+2XAPK5hMMwsMrYs1H1RvGAqw2c+Bt3sRUH3iXGHD4XHqUyTi1eSXEJewOT9JSAzJ0wZ4zbhmHQJzT3qICrM4V61qC1rHIyd3J3AIaQSMlE/Oix3Gdz1DH07h+coUaMmHYESmrMo1lypaY4VEqRNFYz+ikw2M7NOFg0ZbfY+G3tt/ZGVBJmIkwnzSnkIJAZ83U1FZ/QozILJzNkk7S4g9QV3Gk8SwNg==
Received: from SA9PR10CA0025.namprd10.prod.outlook.com (2603:10b6:806:a7::30)
 by CY3PR12MB9606.namprd12.prod.outlook.com (2603:10b6:930:102::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Mon, 9 Jun
 2025 20:52:19 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::a) by SA9PR10CA0025.outlook.office365.com
 (2603:10b6:806:a7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.32 via Frontend Transport; Mon,
 9 Jun 2025 20:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:52:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:52:01 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:51:56 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 09/14] net: ipv6: Add ip6_mr_output()
Date: Mon, 9 Jun 2025 22:50:25 +0200
Message-ID: <682328fffd7c73427f4011ab9488a5e90f63b4e1.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|CY3PR12MB9606:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5f8880-9e4f-4cf2-eb08-08dda7978648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HkXh3/Tmr3wuBfOfl31efMSsW7XNJo5BxamZlooouZE7IU/4HN2+gyp7QZU1?=
 =?us-ascii?Q?j9zOuAXPV38ABpZ0qo9kXAVnQYkzk5qGkcA+t679CNTgbExzlP0gzPgUyATJ?=
 =?us-ascii?Q?vvEfNABfaou/LdBfcNn25RAyx16DiTFTQ5RFPnoEzK+Po9/QqcMnAe2zNImz?=
 =?us-ascii?Q?HL4F4egLUghoZywNVvR12rDkw7uNQwLkb5xmdG7iGjsQa4jcd4+S5XTSMHp4?=
 =?us-ascii?Q?KmHG+sX23+8+MOmrs3sqbAZiJiEwYEJe4Mnk5NvhEiouoFnON9BJyuFA3QBB?=
 =?us-ascii?Q?TgKSk7LwbZn6rTve7GFPzeFfTXoITeNlQrb4pWxGUJ7qUlyLbdqWAdtDi4Ky?=
 =?us-ascii?Q?ckHrtJQCFB7IXDKBQHlUZTcnrc9Ra5mzRH2NRl936zg7ewySKpZiYWLD6fCW?=
 =?us-ascii?Q?PUEWjc2fTyWK8Jx3lMbnlB0SGs/g2cikZN3VYH5qMjGDKcOtfpHBcdOgaS2V?=
 =?us-ascii?Q?UNeUQOdAd2bR8ihjkL6112EWpbovsrd8GcRSksqlLOedKfZ0YDKpuRnQV40/?=
 =?us-ascii?Q?jp/PU3BvObnGvxdZltePahoEqIqKE4lpMywS0AnUAaqsvCiluvljFfHIPhDQ?=
 =?us-ascii?Q?PQQjPo+3xjsvUzL2qrdcn1x2ESg9Z0aJivleNeMPeFQ2/Dhz4d5AVU5RiDaH?=
 =?us-ascii?Q?7QRBSUqmfeKKpGA80GMjYgzBlxuUSBqPGMDjDago859Vd6qQnkxlzvNMIpJA?=
 =?us-ascii?Q?30VUS6f4J5C6bOISyunfohISrxzEEKxyrkNJk2WVo5WzlWEIsEX2OejPnq5/?=
 =?us-ascii?Q?rBLzFOZRH4LNdMBslq7MazBv7mNIGUAKJjkbXz3g4hypcvOkuFvDO02sKUqI?=
 =?us-ascii?Q?xUfv7Nuv6JIROQffO/ERYuDkY0dGB04gm3jnCRYDsdR8vlphg0BwLgw+IedV?=
 =?us-ascii?Q?TARvvOZhq7Uru46F6YjX0evZKkG8bZpgRaEvHYJrGx9e7b+QJUGpSl0rp2Dd?=
 =?us-ascii?Q?BqqyZDzeMuY2WcVj9PjKf/bzN6Leqmp88xPBEGmoIzoxzwPQKYSr3U9z+cY0?=
 =?us-ascii?Q?NrRmYTqgrkOA3ttBZvbsxN5N1Uft0ZBdbgpGdmBgOxPwzf4Rjwi1CJObHqBK?=
 =?us-ascii?Q?mNUJAE4rvQvATy37u8WP+QXHO0BXlBozgiqsphbQjgVWD9KLJlblGng06l0S?=
 =?us-ascii?Q?0eyGAVUU89bzAwaUly4BHaXeYk0RQ6SLneX9Z1NXsNOFlMH+WkG8xutVqNLt?=
 =?us-ascii?Q?62kGMgGTgZjg5yQMPaiMPPL5NXjnyQ6ciCAAt3Lvog2nfGAV/QvIipt7jEg7?=
 =?us-ascii?Q?f1T74bIbPvA6gFl+EU5x2V/LmX2qGukFOJb3p2dkYydi2mc9zCbE8OAB3TWf?=
 =?us-ascii?Q?dvUCvNrY2N82qib6yix8l1BVlo7ENpGWlaSUu/cUG/iBt1Fl/H5m4SKJPCeF?=
 =?us-ascii?Q?u1n7U/LUjH3Ts5rnSymFZhgz6AuxlL58e3cxGurLm8iWyS5HDLNCc0eNtDJ7?=
 =?us-ascii?Q?pSl0xhdxHHPyNxeE+K8SZW/z3LZHlmxmxXFD0fGJPsuND2p4XEkyLefuOBQj?=
 =?us-ascii?Q?8c5SM7lbrTuYR86SgZubyVHk1t+df5byruHr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:52:19.0171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5f8880-9e4f-4cf2-eb08-08dda7978648
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9606

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


