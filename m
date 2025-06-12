Return-Path: <netdev+bounces-197196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE2AD7C27
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9BD3ADE99
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881F12E0B78;
	Thu, 12 Jun 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lOhKp0Fw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10432DCC15
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759211; cv=fail; b=r1EkWX649G8zapybngQLBJ7IWEofByH/pA0P6PyhhwNMKpTFvcXsI03j23EwiUZL/KuYiapeLJLkR+zeeP1mH8AW4DYDJ8cbcWUhABuJ0IWlsprahQH0G4gnAoKSeHpCQ9w8ccGcdWL0LbfQpJ96p+2x7uAKGp58nMTzHl+8nSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759211; c=relaxed/simple;
	bh=PApmkCiaxXB5G/gR1sItIUi+JbxYfCPJ9D8L2x9MjPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/KN8C7jIRENeOyw5kn85BVkfc8OZgt8k4ugZXwlsiv6IeB3aj4Ap1v1Hm4nZfb+5mi7PrzCUjUT5DmDt5rIoo0YwJqI83d8wfXmvlZGYMchJQXrDPkROv6Vp2I/ktXUNlmlCFhNyhAfNJZN2/ewK/KeroKP4pksmqKFZqeZkHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lOhKp0Fw; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgBCRZMyj+ZTbGNSsr7wviXAyPqSMTlEUiNDtKlB4TbnOLnYbyTwm9MmzNtb74542ZPYonR1bFE7CEQlBfd/Jj47iYafC79E28M1QIyrzAA9wJelfsZ2PzJ7ef/B6z/eA9SlRC0JugysTN6gk+7fMn5LOUd96W0GOwMsCjR1EHhTshwO21G1hP8bVWEpWPkKQE4LmZ4qt6+wt82+KJPJx4rCOIlEvcN9ESjr5tPUq1/pi96rZf3hXHIEpQZ0icaOXbnsNbWBCuWxNJXT2NbP1KPe/VGd1dzb083tmX4bsPi45xkfFGYhlirAj5Rag9DQWyDaxAhaSXXXSySLErrlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X3XpG/fWV97Wr0wbbk1VLCFIiADWziA2+JRefzwc2g=;
 b=hsbE8wydOb43AqsdlZe2/rVhbO3mn+lkjSN75tZRQ04/wLU/FAEoYmOgOpUtyy+qD+TS04Ci1SgTWWv3nUGjwBD8x0OkIFcavhtKrjdME/lcudcWd4xLePs8hs/jriEvDh2bjTQ4Si6UGFoc8LL581KH0PwyxDPCUCZlA2VaAidNaT2Wp9XRMYcnHDDX2w3Tpio3PaI0M8cS+gEYb+mUgwAyANUtfbQtb164TbTdXd5i7tE5Qnf9hmVwgWnBaYv71rld6H4TXbeUm5gOUB98F579QZJlE6kwcswYYRHKRsvgKJvxW6st1YtaSOMYqWoRdmouvX47os7+Nlje6UbBtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X3XpG/fWV97Wr0wbbk1VLCFIiADWziA2+JRefzwc2g=;
 b=lOhKp0FwNmV2F6kxO9BH47pf1S9rPHWYJVpUODwfk+gk6okw8b7UTiIbUU2VJ0Y/CPFweGT6fVZBo5fclfVOBBkLwT+EiXLOKUnf3Sq4jO5uzB/vsvvN+7tyJhR5FXuoIXz8wUkODV5SNqyHQfzncDUVgKvVEBfkozSiumcyAlZBTwuMY8O/xYqgAt/XOuYyZH+xTcE75JJ9jY18t0FIcu5oAYN2KQ1FDXuek5rOHpHZ/VP3Sp4rpmwKf1JcPPyickl/bAv4IXieCaqK5dXiWm6StQs+34Pfs5s89kD+lTlvf1H+0jap/msja68SMr3jsPaQ7CkhrASPSPCGFJDW3A==
Received: from CH0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:76::22)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 20:13:22 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::21) by CH0PR04CA0017.outlook.office365.com
 (2603:10b6:610:76::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 12 Jun 2025 20:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:13:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:13:06 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:13:01 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 06/14] net: ipv6: Add a flags argument to ip6tunnel_xmit(), udp_tunnel6_xmit_skb()
Date: Thu, 12 Jun 2025 22:10:40 +0200
Message-ID: <d3e0d58b5d4e9a375735a1dc9a24462d4aa16931.1749757582.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efa38ad-5ba9-4cb0-d921-08dda9ed949d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ak28Iy/T9Qf8Cn3r1a7+bk7TM8qQ+xF4q2S231Qwif/AMRoHxeSv6TomXh+T?=
 =?us-ascii?Q?VJ7QcOrJ910dGdRQTU2iptIrWlTu04qpxyoFG1gaut1BV3lTFsRwa435CfFx?=
 =?us-ascii?Q?nTc7mpRC0V9fGuqRooxdT3cqZuI7NBzW0VVaUxZraBvB3ohClxvMylNI+kXW?=
 =?us-ascii?Q?on6vVZO8AKLtn5B9PRWmhSTsCe9MRiOdH2xqtkXCqUkdry3rVqQbkKFlVp+0?=
 =?us-ascii?Q?YC2wztoxxzPQRZ6YOryQv03JhjKlZammdQp9jtEO60CkKJtg8mTGMQbIxB+r?=
 =?us-ascii?Q?Kjdlt80zJOpEhZuNKJWtZCXjSnJQX6nwU3d0pYNp/eQxtcBpzV2EVoLIGljY?=
 =?us-ascii?Q?1USPjATH6wXm2WlnajG1LnTSeZk7hS1NdQf++YuYapBGO3IKjEhbiMPn8iY2?=
 =?us-ascii?Q?xm65f1pthqCLUggJLQxCrxyUJgN4l4d+7ZMf+pTTnr2+QjKHW809G7rPfUGK?=
 =?us-ascii?Q?2hoi3rv9hf7I1niJDC1SY0qEzhZrTG1uNz1twTfGDJn443C6uqvHDvJcpNM+?=
 =?us-ascii?Q?RjUtMUdpVa+U4OTgm9Rwu5M1a41F+4vK8WUMwITuF7vGCgs175lAnZJm+aiv?=
 =?us-ascii?Q?n+7KdsK8DmtduTnSY9yHM/4IAcpy1y7K3VOFv0sxOgL7Vkg80u7UO4WnqkGi?=
 =?us-ascii?Q?ni8GhxBmOqG6ES1LMZx40r2ih1x8uVUOiK8ZGHL/6R88zzEehPVFQe7KrEFS?=
 =?us-ascii?Q?l3A52AVp/w13eDdWA+mZOBhupRidsdyclD3DrsLko+iMmM48JaLuesEXYMQ/?=
 =?us-ascii?Q?W5ichgl7E2ff7JzAO0YuaXd3e5fjgMqYHNasDEIufEosDShNsMWeyVyWM9zL?=
 =?us-ascii?Q?UtTDhjHshKtW7apBmH9d2PORKSZ7UZ3taJUtr8Xb8BC9kaqd/amusqo7hU0U?=
 =?us-ascii?Q?RTkf9sa4dq78Hfne+kk53KKTbr+wgrs1EOUudRpcDzXmbRCPqMvP3Ms3JIIs?=
 =?us-ascii?Q?nXSuwpeAKcDGcALldKTxTkWYYZBQg4OKfY8pEWhnxbeJGJoaZnmLXblKRKLg?=
 =?us-ascii?Q?BxYCmZMpJ9EkOnHa/JdEJSIg1rW1lZyphPROIux1vB7F9FlV76SlbGAC/c2+?=
 =?us-ascii?Q?/xVjHS8oJ13X/gUvuXfDBULsjNf53PaW9TdHEZ3LZ2BPqrz4vvuRZQ8qXxC0?=
 =?us-ascii?Q?3Qk3GzQp2O53esrCjZGXps3Y+v7Ov0BwV4Lf002uQA/y/kKAzLqwGf71ZElW?=
 =?us-ascii?Q?Z4YirO1iXWyXJwNOJKHrq7MULbAqYZ92xoFK3ewxtqZD9c6v43mRIujPe1uH?=
 =?us-ascii?Q?SHltBwIFVl/rCjZRQIrnvEE5hp0swRf9ANJNtohaSMpXx9FWP/XOczmaDXBk?=
 =?us-ascii?Q?7nG+slUCXSH/3cyWEP5IZL0LAKHFq/rzRPfy7cketRQ+m6dKeJP2d5ibkM60?=
 =?us-ascii?Q?xRU+uwxWw+PB9UnXga/L9X6Pj9dtRJQuRpgnhf5QG7sVCjeJcj3/p3BJ0Y3s?=
 =?us-ascii?Q?fiAMBl/ogqXXqH456AnFgEEb44tbREHbdg5rSj2sLlVGW1AaA4PcH1QZjKZi?=
 =?us-ascii?Q?tiDuWtD1e7mFArZfWvlQkhOSw/sPGPNBIBhN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:13:22.0602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efa38ad-5ba9-4cb0-d921-08dda9ed949d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884

ip6tunnel_xmit() erases the contents of the SKB control block. In order to
be able to set particular IP6CB flags on the SKB, add a corresponding
parameter, and propagate it to udp_tunnel6_xmit_skb() as well.

In one of the following patches, VXLAN driver will use this facility to
mark packets as subject to IPv6 multicast routing.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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


