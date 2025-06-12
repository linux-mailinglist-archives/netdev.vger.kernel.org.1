Return-Path: <netdev+bounces-197194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21333AD7C30
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FB61887101
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD82DCBEB;
	Thu, 12 Jun 2025 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J4gna8EA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BC2DCBEF
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759200; cv=fail; b=cpwJlMhZ8dLvDWbp38V3Mlc3wsbWwoWtFKG1pFF5hpK6ZrbN/6uKeavNYo7KlRSU7Iu1KdNCNGFq4V3Ra9MSvTs+2wZX6FYY0eYr6OKT2pALxZvdlyDJrgsE0UFGTBmxfgb2wt7zuTHH1BAZvSbvqtetuh07x8qDl2eWCjdVrpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759200; c=relaxed/simple;
	bh=wL0NI3y9ThIcHENNxj183QT4CrzGYCk1Z64/46E0yUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKJfrx6Lj3ILsiInSv99t7shfMws64o8DbuETMA1fkqsZC2QwHnFH6CbB8DvNYzAFiDE7Px1jOqLpA8vgQYMyGgGs+rob7ciXlKzNw5SB+FhOtqk6hhYW9f1E1AzXDYOqNJhUhwbvN4vrypnEfz/7VEjyzMF2SZpvYusrBmfJ4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J4gna8EA; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzIc57uxVm8EqikyAyF5P9qmVB036Hk24Rj+18Wiscjs7cVgP/JUmP5KIhymQ/r1Bf9pJRWkx2Sf/gkOKMItBM+zcXz1vAxvZHo2At96n0oeQwTZ9EpYPwKKczZ40woyPlLxO+CTALKOWIO6McppebKeEPAW2hSAXqlTK2SHd7Iwmr2AJxOFDBgKE2gKvN0ewGv4wlpSjWxrrsSZusy20Bh5JMy/OShcxp3wZNMHGbVvftdr5Cei8WFPEmkjXk2SypQcHiTLLyDej+5Avi5bjScgBEekIrsdv6R7eXvYmpzj2yQRVxsLHF4+ykFJzg80G7p9rM3zbCdaGFHNqq4CHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8ODkueXdRoVBXCDWr+xxzpfF/qkStC3kPUe3et6JI8=;
 b=IbEm5DTEFdgoeXFjq7ueZDRjfAJKzXnpW1OT7JLqLD0QaBNAFxxb2AIit8+AE5mukRXq1HOpmu72ttQTX8/3+aR2UvbV7qkdTBjx3q7tKuESo/8Wg3l2Hu0nQ83pRx4bXVFQFNTelKTNH+VRByvvxNih3pMaw4el7GUfpNwebjU+Bv/7LXdxrj5UQ3IJNbE1rwK9XBVR3yJTrESK7+Rn/TKco9OFE+tCwhrYrIwSoe0ew8hCNUZ6vqPhE1ylQsRuWFmt7Q2R9miitNm3YrGL1U+Bk6hajNRvwwJlpiQ5wEHaBzxJk+vUEwx5bYuSxngWesxPUP3Hi2xkPyTryHSDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8ODkueXdRoVBXCDWr+xxzpfF/qkStC3kPUe3et6JI8=;
 b=J4gna8EAm7T5b8BoG9dEHGWAmQtLVLrD+yHZn4yd8luCPpDkHuQpOqV1jBSR8MA9S9C6aSfDxeFtwXgrQUD88gm6BBENHnXDffPG5w+cGYpaGUkme07J0KyvSM97mpfASeytvjXyprI8KOGPj3KUhhvY7mqrdli4UZC/Ia75kvsDuPgaunWQ5uZ+SyzAHgjxkcj+8vBgQ/nE5OZSEopHmEQwtQpiIrxWEYY13ZoY9eHdPAVXuI3MLvp3LJ9mO3KviNkAKZBK9qUJWQdK3NVKpwmqRtcrW6Bwq/qmWZHFeha0bVWfJEbk532ArLvkWQDgKEy59LmUGubBhrVdnebBNw==
Received: from SJ0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:33a::30)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Thu, 12 Jun
 2025 20:13:15 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::91) by SJ0PR03CA0025.outlook.office365.com
 (2603:10b6:a03:33a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 20:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:13:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:13:01 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:12:54 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 05/14] net: ipv6: Make udp_tunnel6_xmit_skb() void
Date: Thu, 12 Jun 2025 22:10:39 +0200
Message-ID: <379491f2c1f9e92bde94a1ed10821d859c23adb0.1749757582.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 60aef70b-58f8-4db2-4f88-08dda9ed8f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6oNCxXNJ7Is+0fCja5FKQfrL0TURAFQIczIjdyEPDiHMCy4B9qOTB7d4WYW?=
 =?us-ascii?Q?rvRrqeFFFWmlmAXmtU6aar7HOYC1cQtReQCsAkzeEANoZIxy4ztWL1/tSabD?=
 =?us-ascii?Q?WHp8f2tBHRXZqJHh0WMPN6Yd6/Uc9BTmooEuZ0rw+3Mj6b3FHGgxZGVpr6Fi?=
 =?us-ascii?Q?YB5iSbz12sJF10OXfbrY6i6XaBNm5V5a/gqatXxb2fm9t4lxDQIGrhclayNA?=
 =?us-ascii?Q?/f+a8Mss1BVwORRCBHRReY8w4rQbrcl0BSWxkGYObAhA3BAoU+QWwiFQ8b9A?=
 =?us-ascii?Q?OBzlnuwbfRDgGCglFQMBVa4d6gU6Cw6cN0KK5EQ4sP29kKWxpDQHsZDpNbU+?=
 =?us-ascii?Q?gOz00I1gsfcznx/UXOQZ7aRF9ml8yy0+kO7tvxlmBC3FvzPMytp4pM1grVTb?=
 =?us-ascii?Q?GWy3Q9tsvLSRmbklRTfbkF9snbwyZDaF52EL9SBc1fey0N7/Nt6oZOVdpLbx?=
 =?us-ascii?Q?pcmMzQ49MKb+qINE/YfoQBwP9KuKf8jBHA0UO25+ZbBHn5dklnasky8pRtUc?=
 =?us-ascii?Q?9VsmvLHW563mHcwedxj6pvx6p2t/kHcl+7lIfjTENd8OvRNuzpiwd/2sn8dR?=
 =?us-ascii?Q?6or3pkYZ1iGGblYj+BTM5rJacIuBECQTX4ia3YjgZzjs4c449ienvrQP/Rpt?=
 =?us-ascii?Q?RKbmgiznzMG+Q2ZOjLREJtYCxb3HwEGL240e8WvCNve98tQYtjBi0Lwolb4Y?=
 =?us-ascii?Q?Z2lId/Mv6YCmMsweTPI82kTMPAF+gEWwMpViSVAzKIkOkXY9V8YjASnu6Wx3?=
 =?us-ascii?Q?5efWH4dw3hh8lIzP9x1iysaUrpUe2J98PwXkmq1N15QPSWcYyS4JYYCMrogD?=
 =?us-ascii?Q?gouqzEUP/LAkdslW3cilmqaUTPDrZekzhg7djCn5pjNcCaBcJuQw1s3LItzI?=
 =?us-ascii?Q?FGzoV/WFxSzZzwOLG5E0bqyz5oD5o622DgiHe5rXIZGK8gNF02agKqfpbqnn?=
 =?us-ascii?Q?M41rchRRbM4jwwO75nk5/VqcCm6F4MI+qP3wfnGyialYnSw8BCN54tBxj5JE?=
 =?us-ascii?Q?cmctmQBqPnnvPzT+78LFGLQh/Xzt4CEaTyIwVY9Bd7GT2k01Rcwy2qlAwlM7?=
 =?us-ascii?Q?O/jfnd7zRoe7fj51XlC0glmaJ6LMalnyHEu8E8nGa14C1uxtj6UB9rszAAKk?=
 =?us-ascii?Q?0Vxy/2aUzOhXB8x6wj3NPCkIZU2vLPKde1YvApyj0g40+ZulXFb+w1ml+8R7?=
 =?us-ascii?Q?RLBMpG529hkhPaIJxSZ4PiOg+lo+kFawzuCJPM5wiYgaCaugblvsAnI1hUze?=
 =?us-ascii?Q?qQSpWhS12JOdp4Rh0yp8RczfXtRWW+Y0vKlqrr4S0CsF5HW3e3ruvYidt6HE?=
 =?us-ascii?Q?O4vW2qtDEMC5jP72AA5jjU/Q4FozoxlHRzGvKl4SsVxzzJaaMNDxkYYLQnBw?=
 =?us-ascii?Q?QQJU7hPv2c0iebeW36wKf0fORYZIKKCsCM2p2eZd4vQKWomCkYvQjIE3jFnm?=
 =?us-ascii?Q?vIql/MJ5L78roUAyV3Ol/fDItBwk/UD0hiZOp1PMZQi4Dgof+JEwgHjOOQ9+?=
 =?us-ascii?Q?KPBuR2Fq1eqfyuQicK+u4nI4vBcABldwG8ky?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:13:13.6524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60aef70b-58f8-4db2-4f88-08dda9ed8f92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988

The function always returns zero, thus the return value does not carry any
signal. Just make it void.

Most callers already ignore the return value. However:

- Refold arguments of the call from sctp_v6_xmit() so that they fit into
  the 80-column limit.

- tipc_udp_xmit() initializes err from the return value, but that should
  already be always zero at that point. So there's no practical change, but
  elision of the assignment prompts a couple more tweaks to clean up the
  function.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
CC:Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
CC:linux-sctp@vger.kernel.org
CC:Jon Maloy <jmaloy@redhat.com>
CC:tipc-discussion@lists.sourceforge.net

 include/net/udp_tunnel.h  | 14 +++++++-------
 net/ipv6/ip6_udp_tunnel.c | 15 +++++++--------
 net/sctp/ipv6.c           |  7 ++++---
 net/tipc/udp_media.c      | 10 +++++-----
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 28102c8fd8a8..0b01f6ade20d 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -152,13 +152,13 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 			 __be16 df, __be16 src_port, __be16 dst_port,
 			 bool xnet, bool nocheck, u16 ipcb_flags);
 
-int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
-			 struct sk_buff *skb,
-			 struct net_device *dev,
-			 const struct in6_addr *saddr,
-			 const struct in6_addr *daddr,
-			 __u8 prio, __u8 ttl, __be32 label,
-			 __be16 src_port, __be16 dst_port, bool nocheck);
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+			  struct sk_buff *skb,
+			  struct net_device *dev,
+			  const struct in6_addr *saddr,
+			  const struct in6_addr *daddr,
+			  __u8 prio, __u8 ttl, __be32 label,
+			  __be16 src_port, __be16 dst_port, bool nocheck);
 
 void udp_tunnel_sock_release(struct socket *sock);
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index c99053189ea8..21681718b7bb 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -74,13 +74,13 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 }
 EXPORT_SYMBOL_GPL(udp_sock_create6);
 
-int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
-			 struct sk_buff *skb,
-			 struct net_device *dev,
-			 const struct in6_addr *saddr,
-			 const struct in6_addr *daddr,
-			 __u8 prio, __u8 ttl, __be32 label,
-			 __be16 src_port, __be16 dst_port, bool nocheck)
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+			  struct sk_buff *skb,
+			  struct net_device *dev,
+			  const struct in6_addr *saddr,
+			  const struct in6_addr *daddr,
+			  __u8 prio, __u8 ttl, __be32 label,
+			  __be16 src_port, __be16 dst_port, bool nocheck)
 {
 	struct udphdr *uh;
 	struct ipv6hdr *ip6h;
@@ -109,7 +109,6 @@ int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	ip6h->saddr	  = *saddr;
 
 	ip6tunnel_xmit(sk, skb, dev);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index a9ed2ccab1bd..d1ecf7454827 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -261,9 +261,10 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
-	return udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr,
-				    &fl6->daddr, tclass, ip6_dst_hoplimit(dst),
-				    label, sctp_sk(sk)->udp_port, t->encap_port, false);
+	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
+			     tclass, ip6_dst_hoplimit(dst), label,
+			     sctp_sk(sk)->udp_port, t->encap_port, false);
+	return 0;
 }
 
 /* Returns the dst cache entry for the given source and destination ip
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 87e8c1e6d550..414713fcd8c5 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -172,7 +172,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			 struct udp_media_addr *dst, struct dst_cache *cache)
 {
 	struct dst_entry *ndst;
-	int ttl, err = 0;
+	int ttl, err;
 
 	local_bh_disable();
 	ndst = dst_cache_get(cache);
@@ -217,13 +217,13 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			dst_cache_set_ip6(cache, ndst, &fl6.saddr);
 		}
 		ttl = ip6_dst_hoplimit(ndst);
-		err = udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
-					   &src->ipv6, &dst->ipv6, 0, ttl, 0,
-					   src->port, dst->port, false);
+		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
+				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
+				     src->port, dst->port, false);
 #endif
 	}
 	local_bh_enable();
-	return err;
+	return 0;
 
 tx_error:
 	local_bh_enable();
-- 
2.49.0


