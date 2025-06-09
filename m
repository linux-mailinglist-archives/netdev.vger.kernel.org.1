Return-Path: <netdev+bounces-195854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DBBAD2818
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F2F3B14E7
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3B221708;
	Mon,  9 Jun 2025 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bqVMDy9i"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99753221562
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502338; cv=fail; b=JqsKtV1Fl3Hv97UKq8y5YjwnijlBKNSsaajkNjUahDSiXDdxd8uPr404GNh7hxXQlYFuixLOu2/ZVgEP1dQQSNtGqVvol/lini7JoxPG2ZeE/CfMLPCR2oVErLr4DC38741FPJM6VfZ3HTVSR8KxNC21MWFY6QMlteYgCjKlIOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502338; c=relaxed/simple;
	bh=33f5v8OGvLl80YUl50CkJ4aazsC48ge8XVpvJZzaiZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKWwJLXNbZ4+DxTXzZIwzsHQVk92WCUoPvgxTLweiOEHYhbf/EgjKxa6X5M+iafwZAGJhlx0GOrcJBhagNwWxPbZXbR559HNMyK5bTFSQon2n0gC1ypiGfKjBXmS+xU9wRoAckX5zSKZEovd1LpdgMSk42Wpv+o8CmykvAhXk1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bqVMDy9i; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIV7kH7Xnrubic/F3zTi9/K3QWrcRIJT4Ao7YNbqKOKaz2PuXenjM3E/XLRymADhALpD71UG4o57ylxv4ihpYs6KOg04+afoYYWekp1WXLoeuODNv84OMEYenvNY/acgSaBTiEPrjZbYRB8UZsXhS8rrujHDYo4uPqS9YCFa5PeBV3uGnTIDTuSAPmCWJhDn+fHA+Zw50uhxl3HEiagzTg0TxSDDXFUnPmBylbVDvwNuLS4MqfnRzST3nGFMY9KKrs91CP5nzoFzJwQKBV92JMNd62PwbVLDCdBz2mM5bpbNvcH4halSIacSCBK3K94YtDWv8sDenaLSNF+jfsiNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQQ1VAFNNTjo3y1WSlTlLSxTyjukaoV9MrYVzLqM9bE=;
 b=VqVXnFzt2zVbvOtYRQtTU2lulz0r2Zxxa6P/QxCUVUq5Uc+vlNNaDp7tI7PZE9e5ufjDkpv4V79Wznt/Wqg25WQkTYGKCDao/un0kfgCWUQ4gFccs9u5HKd05fSgVekm5jKW4fz7KIfCvEAw1Zm8VH0DVWbWM1vRVuP0ycYb1jfjHFa7SHXRkOxhJrnftqp7seHMc2YxsqZHHUe6Q44uSBbMXK+NIn1u3FOwRMiRmvM+UJWmEqyZPVbP7QdzMilrDcuPy7eT14fs1IiwqZh72p6ax0jwZQczwzz9orGk5GVx7YD3eFmDIOFn/MWBRywaXzgsPE6x/Z28tdggLiCdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQQ1VAFNNTjo3y1WSlTlLSxTyjukaoV9MrYVzLqM9bE=;
 b=bqVMDy9iaFhvB3vMbA1bH9rsDKKPkQzoPC7zycEobvS93rRIYbdDJVSWEzWkpo2QISWT7kiSiEPf2ZyQK1gCPb2ZR29pGZOZ1LL3IHQWS3HwrrswHtnrIBG8qipbFsTbNcBsjiGHv60I3gj5GQ6D6lt0kyW3sWvhr/dBWSLduEL2sw0vUUqOBEWHV026epCWKKBs03vJJ4jaG9a/ggmwnNv3gu10Xjzckv+FpLHyd7hhNUB6K6IJOxjB3fbnwGv8ZrWFdUhCwLR1RoryrXpWqZYTWDTOdSfUkf2y2NU1P/9bE5z2PnqYHYbrNK59+VooE+Qjk4rWWYO/3vE7/W8wBg==
Received: from DM6PR07CA0082.namprd07.prod.outlook.com (2603:10b6:5:337::15)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 20:51:58 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::fb) by DM6PR07CA0082.outlook.office365.com
 (2603:10b6:5:337::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Mon,
 9 Jun 2025 20:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:51:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:51:40 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:51:35 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 05/14] net: ipv6: Make udp_tunnel6_xmit_skb() void
Date: Mon, 9 Jun 2025 22:50:21 +0200
Message-ID: <e73fd6fb6ee4f4ee6c85823217d9fc3ccee49db6.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb553a5-c41d-4463-e7da-08dda7977943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uBd7bI6XhI/9X/Kskc7W7FkMbbcejwd01muwG82H09pYGBpxBFlPNiu8X0TP?=
 =?us-ascii?Q?EAAQiG5ZYVZr/LcPtmpen6drCxoUjqIFHiU11HtpO4KFkUIt3oGl444EN96y?=
 =?us-ascii?Q?BgS3W+L/tbq8L6vQHCRgmCgEh66b/yIqJCxTsLogHmCCQlWvsTSTI/mNfQB2?=
 =?us-ascii?Q?cDpJo8nZgq/9qYD9QlcpKJsnNKJPNeGXsuI7HJcUR28HER/zW0ziTICei+xi?=
 =?us-ascii?Q?XKyAiFXeClCxDSIy+rfsBE6brN1C2Q542G26hn71s++dV4rez/YSxktNu1f8?=
 =?us-ascii?Q?JMjn1RpUvohJzFhW0f4R3pY2blMt3stiFBUnOletF8awIRAsipDN/0K1CDG0?=
 =?us-ascii?Q?OMks2xzQrJ2XBOkTbK+/zDR5T1DLvkPf25hr59OgDa/nxkhl+vi9UZYbS25E?=
 =?us-ascii?Q?9rB0cxt4X72nWBMqj5NinXd6+nksfsjE0VPQavGObcpKxlkHvh3/QfWBNmbW?=
 =?us-ascii?Q?agg69R1KThSqG1ECMYlJMOKec3TynTwOUCbThMs5Dyq56tUcc8NAXacxKE+q?=
 =?us-ascii?Q?hNP7gFf94b7FT7PTFq/XAp1RUapH4nHyUFTia0o1zttekjpfAQbMX1pfJhQI?=
 =?us-ascii?Q?YXk0sMmLx0WhQ0GBUSUxs9O0rd9tf8ERgRjPavbwbqnxKh2lT6WcrKzrH+Gt?=
 =?us-ascii?Q?HLmcgw8kdGZU9bbAgRxf2Xk3DM6W5f8eQdSLr0dzWYUK/CK3snrNSJxvaOAU?=
 =?us-ascii?Q?K0/ERPdbY2oQK98yyJDCwkzvxvXwFzjikitJr/mroTiGJdYLgrdLamaZ/q6K?=
 =?us-ascii?Q?osT/jGJXaembLBbZwq25ULfMqdZAf3OODU2Tn2Jh+2sqypphnZKANoMz4jzE?=
 =?us-ascii?Q?jquLhhYFRWv631uMRPKZ/qkVBF92bvGGQRVZIGZwOLVeeSK5o1V0fDbud31R?=
 =?us-ascii?Q?OyQiNVVplLDtYJyg+pyTOB+qnuO62WcARmHPRcQ9DZnXdGp/tfAvdvakcr3R?=
 =?us-ascii?Q?be8aIDUqbSNyyxU+V1N2t51yx5Emvft+CE4QH9FaMYU3RayN7p0lOiw66IMR?=
 =?us-ascii?Q?xbWp9ZW39lLPtHEqOxU4y+R6gTwjwnrg6weKUwQml3OJhSVaDT7AJIj161Dt?=
 =?us-ascii?Q?yhn97QtpamGolcR8Rr+5jEQLbjBd8SL0oPQaYcB6bvCJ4hlQDAD/o6qWbPXg?=
 =?us-ascii?Q?7BgskFtYl7DoXlgmpruIiQgY2buCfUoz6URt1KrmEQcFQy8Q7VW+W5H+Ewhw?=
 =?us-ascii?Q?F3onH7YACO7nWgH+3OElRO+GI8cw4Xlv8cMNLNQx/4iYqqpuR+pAGH8YlNC6?=
 =?us-ascii?Q?db+FELw+45BvRVpudwY/ibUeaaHKaRzA6VQX3HkaH21O3Q0Ph7Zjs8Hi9Blq?=
 =?us-ascii?Q?+XDOoYtkFjdj+Dpgv1/6T8p/UThw/U2ogG5VvswssGgyt8/oq97sM8JtUOyW?=
 =?us-ascii?Q?pnj8qB9bYP+jCvGcPpTQPwkQ7e3m+DoFgEJg8s+krXDg9sOB2KEoh8pZIZap?=
 =?us-ascii?Q?wsQ6uuGI9UAfFcSUsPsFYYG/X/sXhybO33hdET0lFfgxJQ7XnUZCe4fnTDCO?=
 =?us-ascii?Q?ntXpsbY/cl54SAZSk2MVw1/jUBpXqySARjlP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:51:57.1477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb553a5-c41d-4463-e7da-08dda7977943
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554

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


