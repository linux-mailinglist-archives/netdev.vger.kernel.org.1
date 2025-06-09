Return-Path: <netdev+bounces-195853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3E0AD2817
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B4016DEB7
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0604D2222AB;
	Mon,  9 Jun 2025 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VoGIPvFA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B651221562
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502334; cv=fail; b=tFGRjy+XO0fTBe8II5G62D/oXWiPFL0AlHkYd/H22EmeCujT3lDzTgPBIcta8QhalGUSsVI38RYzbQlMFFQFzhMFpDxiY0gWdk7iVmEv1Hgix1pvG0jH2KAzcr5l3x03rsACm/o80v9te7m2pp38HAQGnwwRLHuKAuq2pOE+SOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502334; c=relaxed/simple;
	bh=R5PTee9FkFNsVPF3zgC/oOheXnMvbYBZBlefWd0S92g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCjCJ2vHzHV7e/Lj9GerTjstmVZrf9FxXF6Z4dHTnX8nJtoyQQ0/mnv91rqpn2F9XixBXvpRMVWsZkRTZvM/ScWKsfJK7giqOVkDXOu/AUsfEBV6Zg8R4HSXizAZn6HFgIlqUz9z6/VgJIwV4P/SzHt+3LidsGF11qGfI3Q3L0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VoGIPvFA; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUExrCqynwztP9g5rOV+O191mqaJ1WQ6gpI4Re7fE1DYdcTi1fX+LHJN6Jz9kn9WshfJ/C0u/osihPy3fvIwbZqwQ063mc8hHlZvL1Ly0ZVdQO2PfFPl7tftODGTGshCDAMsNElLIkJqs7IJe6x6q/Dx/Mwf/EHqq+WDsW+Viwls5Pec0GDWvxJlmK/W/ykZBd5ETTNdw69E9xVbN8Gmzp9UYpqkjQy+CWFPt/bUm8K8AHSSJWO0Y8Ne3ZSI7xAleG7Nbk/UpD/XxyFEfZG4GeDubMArO2Z5JhzDIWRYDV4W8e6bM5KGiY9kLVnVEer6N2JKU7fCgvLFUcauDtltWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UulHonpfOHukUJ/UImLwFJT4cvxdcEkUwNZbpiTOtPk=;
 b=nYrHKRxQ2mZLCPlK+L/FLju73gPxuDOsu10EIhI33OjAcGKxgtaBOLqCAgfx/QqHuGnBBExMhquWWxfyMcbCn3jG53oRK5NsN/MmvyLB8bC4dOSQ17U9D5qGw6K0VBmbNJt1QNpO5kCdtWNmSAjRTmJlTpDD/+ZQgMXOJJWkEKuYbnmZv4UC6hwiEKIQieKj1DbJyF+vY01adsrvYfIOG+TZg3M2EDuWtuoMlvbu4UB+exQVRYs0Tb34el/LnAK81O9YoJXksuB99Syp/5A8bfCVvYQwzbnK3n2znwZbKbCQ2fMnykasZZFP/jdTg2QLhH3gSO2f2hOAbTtmFYBUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UulHonpfOHukUJ/UImLwFJT4cvxdcEkUwNZbpiTOtPk=;
 b=VoGIPvFApW+k0NtuQS3aooSvn7c6fkCUf3HNcd0N7yaSDGhpQviRHyIWkQqtQXQ7ik3gqjVcOGoI5bk2R+kslVV+lmi/OdVpZO/0dIpKO9h9uw43rGyDS+wKlBDv415CoSbKGxFQgtndWdYK0L0FDz+NUYPgPMDOFSdu+MrEtPsUI40P4ugiii79IXsXWPsTUCKZGp4UxEa5MhsugWFar92HxP9Tip11xuLTcMo88sC2+sH2CAEH0IG8AvpuVlxK2MhlLudbRPtE4yr92eQ7VbKHJWHD4ocz1vnLdO0IrM2VeX+wvgCZqS6b7XlQxmH63LxIeNd0DDQvm6cwACXnYA==
Received: from PH8PR02CA0028.namprd02.prod.outlook.com (2603:10b6:510:2da::29)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Mon, 9 Jun
 2025 20:52:07 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::ff) by PH8PR02CA0028.outlook.office365.com
 (2603:10b6:510:2da::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 20:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:52:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:51:45 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:51:40 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 06/14] net: ipv6: Add a flags argument to ip6tunnel_xmit(), udp_tunnel6_xmit_skb()
Date: Mon, 9 Jun 2025 22:50:22 +0200
Message-ID: <ae11785a7fecd87c0bea9ee91704727692e0b3e5.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dff37a9-89a8-4e1b-8205-08dda7977ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3bAp00mEufKq+h7uc36KlqaIgF77AclURmKlMQ3py8ukQ80nCAbeaGTebyJy?=
 =?us-ascii?Q?phayQjQg4wiQzjb4DppL7zDNwYwzstjfVSx1g+7JZFjIbR1d/52spvnEcjrk?=
 =?us-ascii?Q?O2gmpi+/xqBrxvX0OFSMRQTxbq68gcFPlKXfBlNH9d9utkltoZlyfZ7MbIAZ?=
 =?us-ascii?Q?RkopfYVN2Yle6vpIJlAmQPwWi106/hZGUMVJQA9okXJ26u89qVDK/OzjvDlQ?=
 =?us-ascii?Q?3Qqh1iayF8s7bvdTdHU3b2F7dWajfCM0NZ1vMqlH6/0PJlTVZsPmfz0W+qhM?=
 =?us-ascii?Q?a+ykYV65et5SdHY3CaXo6kGalo8YrfhKKB4KE5ud4nU7Dgv8o7C5LpGPBTaV?=
 =?us-ascii?Q?scgu6XrxB0J04zqJHjSuJBXcvI+X0Te4X7/uNseLNvY6PiWDmedELeJFarY3?=
 =?us-ascii?Q?tGVO8nbBFy/1OyAnECIS7i7nlQ09zdHTmic6Sb3QpjXEXVmTPMPpe3UniNu3?=
 =?us-ascii?Q?AtnUURsDePTinGlJ9x3ogi0TDbgtuld1RHi0UEs3XBpzBazdLm1SA/VKBmw1?=
 =?us-ascii?Q?84R7UPjpmWAOsHTCk0Q1necpJQ8yYv7lbq3lDKYg93bGTKmkQOEexT8M/LN8?=
 =?us-ascii?Q?xouI2galDJMMk9G823AdKiNFgYn36S8H5QFF17ZFHBtDZhYhLOirYNCoL2mB?=
 =?us-ascii?Q?McqGFIMCpqcMn3Xm/bfhlbWZgAb1qwSFSr98XNGcm1WOTSmr+eKQcrEyJbQz?=
 =?us-ascii?Q?IJrc6XixsY4h6ydeEycn/chxzHdCTsH8/ionBULP0kxxty39AtWqoL1Q+jWk?=
 =?us-ascii?Q?JaC+CQAnwwTw7AsCfXkWMoq6Bv8tKxKqUlzG1SlT412gLmwz24mAi+PcRX/X?=
 =?us-ascii?Q?d+Cs/INKD9I1o/KqtxbtKrT8+9D0csVr5xwGZURG7XnhzcKJq9PGwIpVWmX9?=
 =?us-ascii?Q?pdfOMrRMYSRLCE8D4BQJj0WcdPP2hyc0lxlRX0aq+3HfqNvEEs/a0+sgysqQ?=
 =?us-ascii?Q?fOFJ2qymrp8DqdOay3cnzo0UKezrOMhRbMKoPBJP1ymzpdPnLBqt/tCb2lT9?=
 =?us-ascii?Q?wmCBJ8zSwBdrc7Dk/1b+MXhAvjXRJcinIAeeFGEJ0UyShGjIfwngvfdIka0e?=
 =?us-ascii?Q?yWb8zlUfQ+VYNPNZVi+HPhyWqvIE3OaQ17gMEwdBDaK0GWJHw4sMYxg/qqZn?=
 =?us-ascii?Q?hkBeQHbNP0nh3AN3MFTfjzj1IX5jy041LUzpzvKucDmiWG3zmmuyZFhih+EI?=
 =?us-ascii?Q?NY30NJe1OY03aW3e7aTYmU1sO5aJ8i2qSzfoxR8hCfRuPt2XrehqImRd1mVn?=
 =?us-ascii?Q?HGDPTbTdkWy+3uPeaHT7AFI0Qx8c9UHe9gaAfwSgWVSCpxBJeDv1FXGqrWLe?=
 =?us-ascii?Q?g/Hki2kE5EFs40I6jQPGBWZlr4C4LP9aKFCh8pt79B4DNOaVmiuwlI5kH8CN?=
 =?us-ascii?Q?MsOg6/Gu4dWQfBnAuBCPGaZ9wndiJHyQKFiZ4A/WkFX72nDCeFc7r0wtjQ19?=
 =?us-ascii?Q?pA1GoMaTNlifzUNwWjeRYh2bCzc05VipKnY2zf58Hr7AHHJVa5piSG3Ou6f2?=
 =?us-ascii?Q?ZEyLluP4Icij84vHdMihp8W7Ma1DgEy+5e/b?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:52:06.3762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dff37a9-89a8-4e1b-8205-08dda7977ec4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

ip6tunnel_xmit() erases the contents of the SKB control block. In order to
be able to set particular IP6CB flags on the SKB, add a corresponding
parameter, and propagate it to udp_tunnel6_xmit_skb() as well.

In one of the following patches, VXLAN driver will use this facility to
mark packets as subject to IPv6 multicast routing.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC:Pablo Neira Ayuso <pablo@netfilter.org>
CC:osmocom-net-gprs@lists.osmocom.org
CC:Andrew Lunn <andrew+netdev@lunn.ch>
CC:Antonio Quartulli <antonio@openvpn.net>
CC:"Jason A. Donenfeld" <Jason@zx2c4.com>
CC:wireguard@lists.zx2c4.com
CC:Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
CC:linux-sctp@vger.kernel.org
CC:Jon Maloy <jmaloy@redhat.com>
CC:tipc-discussion@lists.sourceforge.net

 drivers/net/bareudp.c          | 3 ++-
 drivers/net/geneve.c           | 3 ++-
 drivers/net/gtp.c              | 2 +-
 drivers/net/ovpn/udp.c         | 2 +-
 drivers/net/vxlan/vxlan_core.c | 3 ++-
 drivers/net/wireguard/socket.c | 2 +-
 include/net/ip6_tunnel.h       | 3 ++-
 include/net/udp_tunnel.h       | 3 ++-
 net/ipv6/ip6_tunnel.c          | 2 +-
 net/ipv6/ip6_udp_tunnel.c      | 5 +++--
 net/sctp/ipv6.c                | 2 +-
 net/tipc/udp_media.c           | 2 +-
 12 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 5e613080d3f8..0df3208783ad 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -431,7 +431,8 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     &saddr, &daddr, prio, ttl,
 			     info->key.label, sport, bareudp->port,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
-				       info->key.tun_flags));
+				       info->key.tun_flags),
+			     0);
 	return 0;
 
 free_dst:
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index c668e8b00ed2..f6bd155aae7f 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1014,7 +1014,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     &saddr, &key->u.ipv6.dst, prio, ttl,
 			     info->key.label, sport, geneve->cfg.info.key.tp_dst,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
-				       info->key.tun_flags));
+				       info->key.tun_flags),
+			     0);
 	return 0;
 }
 #endif
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 14584793fe4e..4b668ebaa0f7 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1316,7 +1316,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 				     ip6_dst_hoplimit(&pktinfo.rt->dst),
 				     0,
 				     pktinfo.gtph_port, pktinfo.gtph_port,
-				     false);
+				     false, 0);
 #else
 		goto tx_err;
 #endif
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d866e6bfda70..254cc94c4617 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -274,7 +274,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	skb->ignore_df = 1;
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
-			     fl.fl6_dport, udp_get_no_check6_tx(sk));
+			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
 	ret = 0;
 err:
 	local_bh_enable();
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d7a5d8873a1b..c4af6c652560 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2586,7 +2586,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
-				     pkey->label, src_port, dst_port, !udp_sum);
+				     pkey->label, src_port, dst_port, !udp_sum,
+				     0);
 #endif
 	}
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 88e685667bc0..253488f8c00f 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -151,7 +151,7 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 	skb->ignore_df = 1;
 	udp_tunnel6_xmit_skb(dst, sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
-			     fl.fl6_dport, false);
+			     fl.fl6_dport, false, 0);
 	goto out;
 
 err:
diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index 399592405c72..dd163495f353 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -152,11 +152,12 @@ int ip6_tnl_get_iflink(const struct net_device *dev);
 int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu);
 
 static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
-				  struct net_device *dev)
+				  struct net_device *dev, u16 ip6cb_flags)
 {
 	int pkt_len, err;
 
 	memset(skb->cb, 0, sizeof(struct inet6_skb_parm));
+	IP6CB(skb)->flags = ip6cb_flags;
 	pkt_len = skb->len - skb_inner_network_offset(skb);
 	err = ip6_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
 
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 0b01f6ade20d..e3c70b579095 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -158,7 +158,8 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			  const struct in6_addr *saddr,
 			  const struct in6_addr *daddr,
 			  __u8 prio, __u8 ttl, __be32 label,
-			  __be16 src_port, __be16 dst_port, bool nocheck);
+			  __be16 src_port, __be16 dst_port, bool nocheck,
+			  u16 ip6cb_flags);
 
 void udp_tunnel_sock_release(struct socket *sock);
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 894d3158a6f0..a885bb5c98ea 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1278,7 +1278,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	ipv6h->nexthdr = proto;
 	ipv6h->saddr = fl6->saddr;
 	ipv6h->daddr = fl6->daddr;
-	ip6tunnel_xmit(NULL, skb, dev);
+	ip6tunnel_xmit(NULL, skb, dev, 0);
 	return 0;
 tx_err_link_failure:
 	DEV_STATS_INC(dev, tx_carrier_errors);
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 21681718b7bb..8ebe17a6058a 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -80,7 +80,8 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			  const struct in6_addr *saddr,
 			  const struct in6_addr *daddr,
 			  __u8 prio, __u8 ttl, __be32 label,
-			  __be16 src_port, __be16 dst_port, bool nocheck)
+			  __be16 src_port, __be16 dst_port, bool nocheck,
+			  u16 ip6cb_flags)
 {
 	struct udphdr *uh;
 	struct ipv6hdr *ip6h;
@@ -108,7 +109,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	ip6h->daddr	  = *daddr;
 	ip6h->saddr	  = *saddr;
 
-	ip6tunnel_xmit(sk, skb, dev);
+	ip6tunnel_xmit(sk, skb, dev, ip6cb_flags);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index d1ecf7454827..3336dcfb4515 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -263,7 +263,7 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
-			     sctp_sk(sk)->udp_port, t->encap_port, false);
+			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
 	return 0;
 }
 
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 414713fcd8c5..a024fcc8c0cb 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -219,7 +219,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 		ttl = ip6_dst_hoplimit(ndst);
 		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
 				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
-				     src->port, dst->port, false);
+				     src->port, dst->port, false, 0);
 #endif
 	}
 	local_bh_enable();
-- 
2.49.0


