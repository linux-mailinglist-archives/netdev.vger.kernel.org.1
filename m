Return-Path: <netdev+bounces-195851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC42AD2814
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2263A7584
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47C410E3;
	Mon,  9 Jun 2025 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EA3J3Swl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E4C221708
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502315; cv=fail; b=lFybTbIye13JcGzzai1Q1cTOvZEdoHJNEDAzJRjFs9Ds4bWAad8Z9kzfsqcOsQI37CAP0Bu0qpmlZRnYnmpxBCRTxWX/s2TgQgRokxGUNg9T35FpE9cvWqE2jqyfJIRt9OLvTXIlLcJHXRTI8PoPddbCDS1ekPxvtNn+T49mJss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502315; c=relaxed/simple;
	bh=1+DyRfYs04wl6RHXn4jo34aPJY5lMU29IL2zk/mzQLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJ2ALFochsIZ2408MWHLIJHWyc6stxWG1Lf7WegG1mUAf1lFO1o6TqPEm6w6+GfDi0SnKh1UhrE55Ygtn1GXEdXlVdAy/iceTW3L8o2Q8W9A1moNn38ZWDIrTmoIRHuqN1PlOuKe254rJBTx2GAWFOpi9CR0laeju+TvlSE7gAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EA3J3Swl; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/bFvee37z8nfi4U9prWYgMfTSpuHvCeM2oneDkO9r3CS4KNV/ABSQgQrkn7qxBpHrlZK3p7XywHYaiWTq1XMIpbAqPLGfuhTrmcaJcXrd4+oB1d8OrDNWzYdi/9wYydF1JZ1tcQnMrkSFg49n9r/YzGlzzGr1PU8AEy/bOgVHok0iFdu/r0cA3JbXdVNlrkTRiMR5/nOqFEtccIM75LjFfdUIXhYZXGgnBxfMaUluV5E202Mng/DEdkFzg5Y++xIrJYHRPqOeBedktK4CUSH9m6bh2Xld9xTrCdULqxEV683ZD9DbqMYN0KC43x0R/wY4OC9di3i0iEDg0yy9rP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHXHmJKiKramtwP0SFeP13R2r8WPdR4Hv7s3ZhwQSsE=;
 b=CYZbVpAXsQ5UdJgkERz2KLwMpGfhmKKq4CTkRMTxP6o0x/J2NTOs7Rab76oN2aCra4UuzzCoHxfSnEUi5WqLKtq0oZt9XBu3l9UoOCiXpwUvuE4ADtlcNFUuPAm9/3jd1t53cuMH5EEesafxpMvnwQWRgS6ePTF1bpBy3lS450ZSIhXO+C5sWsekNy4x9t774674D6WDFSA+dSLJR7mhve+sm+Vj9sncYc1WshDMSF9k6n7XLZdR25kkMyQ5kWNAH+Vf+ACqDEiQE/w1JYLge9j0au7hQzBEsrJLPMPAcSMDT0rgsDcz/3sdYIA6S8OkFvvIgydStY+Afnc2da47iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHXHmJKiKramtwP0SFeP13R2r8WPdR4Hv7s3ZhwQSsE=;
 b=EA3J3SwlsjRXD6roLFPs8Xiq800chKhf0eAKJI4J7nwJUP2fouqgvPtMAgPY8lcDu6kHDUg48Cmc8Ln3H2XfasIvsjno2artOjAaCwdR4WO0RujVQyGiKiTmAUaZsI0MDcm8afnpGlzyyjI245qdGz9viVdUwZLYyUN/1TySR/FSHbszmYuRiwUK9ECeL0pgmn4pgHcsbjOqWdgJzGvc3Am+wpqUoHhkFkkrHybTJ9UrPOVvdM5cAVyuFoGwNwYFZv1MCXC/NS5jhPvKouhDxd0dCTxPp5iM46K0LUasF2LX/iTatGR9Iy7YMFxp9DVcn80DiCZBqzYIlU5vzBdzsQ==
Received: from SA9PR10CA0022.namprd10.prod.outlook.com (2603:10b6:806:a7::27)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Mon, 9 Jun
 2025 20:51:50 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::f4) by SA9PR10CA0022.outlook.office365.com
 (2603:10b6:806:a7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 20:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:51:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:51:34 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:51:29 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>
Subject: [PATCH net-next 04/14] net: ipv4: Add ip_mr_output()
Date: Mon, 9 Jun 2025 22:50:20 +0200
Message-ID: <4f1d54cc71c9201184063ec1e38f3e85784e59a1.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfabdd3-1b7b-453c-5d6c-08dda797752d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XkaCUdAtTOUFr8TKfunr2/7WpUuxek9NQZRlj2Mh9U7YqZzqKBAoMatI+QgL?=
 =?us-ascii?Q?8wT8++Ctl9964WZ3D1SSiLQdK10HWzS79tIkMcw/5sJ+vOD+W29i6dudWAoX?=
 =?us-ascii?Q?kJwSQs5B83rAArebvSL+k2+jDsoTzpEdae27ygC/YRrfqytQldupgdbCjzrh?=
 =?us-ascii?Q?7xSdIvNKRNNGQ/vo9zum/uMKljoE2Q9Bx7+asHv07hd6D3EarhwPecsy/Q6B?=
 =?us-ascii?Q?H7m1h+U1Rej8xuaH/P2m7wdheaMf+hESpb5SpUYjskz3qmDM4RBDWzizp8eX?=
 =?us-ascii?Q?APzV51sSylu2va/rdKzdLSESoswHrSIOwN1cQ35GTNevLZQVhDot8cb/76/9?=
 =?us-ascii?Q?Xt3Nv99YhsplYgsfBUdPluQDws19kUy8gFEVzT9JkW451+bFMjWkl+Pw0190?=
 =?us-ascii?Q?VLbPpa20x3qMZX7sUIFDwAsLpZt/rjdcvUlsMs9MfR5LWsoy/klLNaZy31ks?=
 =?us-ascii?Q?ep2H/RXps1vMYfiB5tkSMAOrjW999C8FPj7BZFUp3zmt3phWyRT8FrssXqw5?=
 =?us-ascii?Q?1JpT53c60ZjC6ox0sU6poGBrlujXJRrpbxzzH0xYTZi31VnZpoH38g5hJcrh?=
 =?us-ascii?Q?gyjkPMQh3dggYqRLrGX9j2OSCXFSfF/bcvKhGjSpytAIz8Wm10yk3a9tF++t?=
 =?us-ascii?Q?VkcsgqWTHRsqZH1EzFfqYay6pGgSC6tR3z+7OLMy/6EK/Ee3WjutvCj1JojK?=
 =?us-ascii?Q?ZHZodOnqP9HHUiFqNJcw/UixQ1E6SM714XjzIN0EDTYjrs0oEJrBphQSv074?=
 =?us-ascii?Q?Zi+GmhbOqa8Hn76bB60OBjRTlZKyYMaPT4CzChqjmyaJZYTCF2kWP+58kidw?=
 =?us-ascii?Q?FJlWmlWM1emrPPxh6xI+kL9ti+PMrCU6SNDuYk3bRku10B3cZD5HRxCYOPDA?=
 =?us-ascii?Q?Q0DpmgEwz80t1lseTnHFgWPpQFAR2Txcli0zsSR1/FFtPDuOmuzWYCRsDxP1?=
 =?us-ascii?Q?1om3jP5F9NE/scgVNHqZjXCECMbEQ7Wh9nuerJPK9+bSNiLuOoE2fcIFnAL/?=
 =?us-ascii?Q?cSJuu4RtDABLZ71DKUG6nEjQkvBaTAcHfWuzuADrZ8/8AW511lpJZUflsxGV?=
 =?us-ascii?Q?V+e7aLKTv741O5m2IGVZEWydqvyayb5ECI+15sqViWAYYkfqj+LhJ8GT+j0S?=
 =?us-ascii?Q?yy2PkQCIFYiBbkmE2dONgvwfQY6Wl7Ctyckv1ntRKww5lbOyKklMwLePONS+?=
 =?us-ascii?Q?j4NADDhrcl2DSp3/nxtVdgjWPVRUEGjqTg4yVPpgUfdx2VkUOx2XV5CR4DE/?=
 =?us-ascii?Q?thRHNb5SeAu2j/kJMNxBOC7p4s7LVL2s8JXcW/ZLpg1tbuGC5r5FEwuPC0KO?=
 =?us-ascii?Q?fXJELHQp23R7EdmMnVkaBi0Afd+aHKgwo0rTeOoC7B9aywbrxdcJ9xL8illI?=
 =?us-ascii?Q?uc8vGFS2QDU/Px+RSUK5chWxN6LcFHfVFAFzcoIQHxR0OkW6leDPgaG9bGER?=
 =?us-ascii?Q?BxmiHmU30bX3bgaPhlFUm4MqVz4Qn0bYIKLU8jQmlptaYS8WI9ZTVS1z/Tyz?=
 =?us-ascii?Q?jZtpFUWLOnUmyUBqVq8ve2WeVjLqDKwHYjzA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:51:50.2812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfabdd3-1b7b-453c-5d6c-08dda797752d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284

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
index 7c1045d67ea8..f5268a9211e1 100644
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
+				c->_c.mfc_un.res.ttls[c->_c.mfc_parent]) {
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
+				struct sk_buff *skb2 = skb_clone(skb,
+								 GFP_ATOMIC);
+
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


