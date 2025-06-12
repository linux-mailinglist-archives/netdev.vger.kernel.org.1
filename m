Return-Path: <netdev+bounces-197191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3779AD7C21
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDB23A3F2F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38E42D8796;
	Thu, 12 Jun 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WFmwAhTU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F922D878D
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759183; cv=fail; b=ef+62aUpDZ0UfADA4gwZKtIPinF0/4XVwj9W6/pQfh5zNjd6eSz5/NapJ7a+P0rpczcKe9KfhI2FU9DsUATvKQJfq8tj1Z0qfYOGrHry2WMuXIU0y89KAkkdGS7Kb9XGU9/FXRwSG0hi4Zc6QB6sgLKBiNB7v4DTyYdWFQkNf/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759183; c=relaxed/simple;
	bh=wBtpcAZJ2DdEs2xjHTojwDbBtZFQO72+shhw3nw1spo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTJyuV2B9k014FTmNqIQ1VQQVWn8hOwODfuQS26ftFQGpKbaodQFrY0YusnhCuHaDx+3MzZJx3zPaa4brjBEXW7mxepzSNqXO68n1/uISQCmUYj7/kpOCJSlZDEDuix++JGMHPhUh0SYIDridDWYkzW8phhFbPTYpCKjnTaf81A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WFmwAhTU; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSBS/3UAOmLIvQFh5vOl1aBPLhik9bb+gl3SLpxIxStpfu9xOENlKxwLL7fBLcuW3+n++gHbHaFD49PVvoum2xjZQVhCYe7R2pjKS6pmV1G6PPN3O1Lt06cQeQBdpXHVmW3iHJi+Sd78I09QJgV8pYYMXl8APM65UqD3Pxs4xq6Rs4+amj1OICaAcNIYrV7pM2fPrxbaRyVzPNiDAyTaXj2EVXO6SFh9dnSTwDCRPpWslLZDV8m6xKRKv+gGDQkrEzqEdMm4fFAS6U7Ln+XyqGt4KfZ3TxH1ozB1Tc2ZMEDKolryOD5wC0xrip4bw7FTbMHgQD027AT8IiOVZlaCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+RoI8VeJCzBbOmvgwCZkx1yt3UKnkdOdqGaZ1i3aT8=;
 b=jzXdf3LqDsH7u7JI+sfuakqnWxKXxYjqzFiWQxcWafP1PZVHpYCrsSwVkV6ORBmlDpQzaE80+lySfmMhut66m5cz108Px+IXUYrya/EG+5pwfAxmItxtmdYw7E9/vA8lDGLWRZfIIB0QImCGvbfYAoupx6SvEXNDfAeuP9pIswa04VL0SWq4j+pLaVNBzXiX+6WcObR7AQMTPrnvG4WzUOVCGLqftxYPzngqgc0NkFicjQqPZdziEykg2Ke2uNpGHRN6eYddAviNKsbdZg1ILgRse4hWRQiQOQf1PHJ2ueEZS9Igreb0U9gxWC1HyQfulsi0kgjQZMrcI0gasuwh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+RoI8VeJCzBbOmvgwCZkx1yt3UKnkdOdqGaZ1i3aT8=;
 b=WFmwAhTUySG+jMF51e8gkkAtbBzt4B66/FPEmgbvcB27FvfFovG0FUm3lhcuHHKfANeXxDZqlqX4AzExvnznJylboV7n+RrkfARvsvben/iW89Gn2vhoI7fdWpuy2zlFiJhuvFrdRORqMOdrGSAUJQBOIMZxe+dVrmck9rZn++BNyJS/+986mOY30yyAe5JBDQQhYWfGDsRQnEzorzoYZzZRHPWTUKvmFMJ4yxEQ7HxoDcJ9V09vEuPcX/TSlxByNaBNNMzO7p9RQPJBnn0lT/rtFfW9aOZDDI9swlW1JxnRtXvCwZ4ExEmo6cpbyMqlR6wNyrUImtUXixxOJTC39g==
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Thu, 12 Jun
 2025 20:12:58 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::6a) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 12 Jun 2025 20:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:12:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:12:47 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:12:41 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 03/14] net: ipv4: ipmr: Split ipmr_queue_xmit() in two
Date: Thu, 12 Jun 2025 22:10:37 +0200
Message-ID: <a2d56fd243fb8c992515a3525af1af1aa16b09ee.1749757582.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd590af-61aa-4f9e-d7d6-08dda9ed8647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Smcprnxn+ESXjRfwy8wtk1AQr0XrAybB86O9Un3+TUyT5GHp1mYBoFWwm0Uy?=
 =?us-ascii?Q?WFEJbeXBW8jeySc632YblAy83axWT+KK/MKbZvns8uPaqd82q2fGlMH45OQW?=
 =?us-ascii?Q?s4C0ia9B4nUtM5zVWf7IWwKpRrD50MO41X1RzXFjIP7L1NtXXqo9IqI3vdT1?=
 =?us-ascii?Q?c7JX3Fixz7zYPmwH3tNcS5wmlslqRJ8Gg1Xgs6pds2Vrzn/QguFpjyMc89qm?=
 =?us-ascii?Q?VZcYi0zJxUAnlpB9mWK0Pzw0J/7jERq25Q75cCRQOdbKQUTK7ouz8/owEC2O?=
 =?us-ascii?Q?opVALoakh/Xs1Y1M88DYZjYlAVxOZOFvkOTh8bNNNKBGzUWvKQ610bfglKrD?=
 =?us-ascii?Q?bQ0XzO4dqAKPsfyMho+GnffByayAH3c20UPEXDnT/zKiyLcwxGj2QTxbWcOC?=
 =?us-ascii?Q?L7agyxJ4JZrVh9kuULLy2ENvvSZKV1blghoYPNf90PYIozAfvpBiEFsDHT81?=
 =?us-ascii?Q?qghRzunZGws1M9eCBDCkOwwJpkuFW1kKYFoQYJsL9+OzoY1uQdrCyAMgsc+t?=
 =?us-ascii?Q?DR3R3boc7QY4zsHsR0kiz9c0g8HHhMnmFDgX/bq3B8/S+LK67EjcM/D3MsYa?=
 =?us-ascii?Q?diD7WVtiJNrbKReIOw3nB34uFy0UhUgjXnd697dvR5y+NG1aOyY9R5p9ZPsW?=
 =?us-ascii?Q?xN+JMntJEN2NgLkqrfq4GdBQf+DYGCMjh0FBhoMuFdCGHo5zPEmMx269AVHb?=
 =?us-ascii?Q?v1j7SJe3RacTFCh4ynawtLzqSiqq2kAMWByDBsmQeHsZV2v6GjUa3SaHQ8I9?=
 =?us-ascii?Q?aUQpIeiL6+00BP1vydeg4wzkPbD45+I33BDLuESJi3T1cz4bbybLaCWDU0MD?=
 =?us-ascii?Q?a61IZJE8TpdcBcRiX17ei1Myk5W0cPVYtDbpf+2SetgSGtJmXqex/R/7YnQN?=
 =?us-ascii?Q?JYOIFpopgFMMCnSsPW2nzdUm1hwEZbYU95p+71BDvrPe4wN1bnxPSewSsjXW?=
 =?us-ascii?Q?H/jVA2IdBgSJjb9RMCJWBA9k3k/HtjJ1iy0T/sK6FFVnxoUv/mHwgvXUp+3z?=
 =?us-ascii?Q?qvASpUZrLsLJBsJNO/3+L9+J3znjdPlJTzHWy+hEdyFrOio41oewmjp967P6?=
 =?us-ascii?Q?W/di4uLSUeDIadlh/I+Yks0LunqZBgCKv+YH87oQmN1UlRJvzIcQEEMZsuQO?=
 =?us-ascii?Q?ls6f+YkI3vx61B7Ktm5WzAGVBsYpaYLNyCPRG0dUL7eYXEoPFE8ZK52LDanE?=
 =?us-ascii?Q?wa7JTBkRCej2Xxp/BB65Xf3/Trw3iv4orgBVxNZbqPsAK6KTgo9/A6kLKFTZ?=
 =?us-ascii?Q?fU2j0qF4Oq6yVR5U9AlrFo8geKXiaZ26Rj19L1O1FAY/vpulidLMSixDwYZu?=
 =?us-ascii?Q?cszQ61tdojGWRFitZ4vgOeSaga9h/JHVc59mFvG7Q0nfa9mHpxAu8f0nLJua?=
 =?us-ascii?Q?MHfITBQnpMiDaSpAfGvp4VPnAm0ZynDpAiahsH1T2y5MpFoFwe4F/vCfXbiH?=
 =?us-ascii?Q?2L9Gpw4cqS5ANJausnRW0TNWxAaC0H76n2FSuIioIMMjOSbX8/TPi8Y96p7U?=
 =?us-ascii?Q?wNvdF2gMpMcgYjB5wFIQUvqOLEErF835unCB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:12:58.0096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd590af-61aa-4f9e-d7d6-08dda9ed8647
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921

Some of the work of ipmr_queue_xmit() is specific to IPMR forwarding, and
should not take place on the output path. In order to allow reuse of the
common parts, split the function into two: the ipmr_prepare_xmit() helper
that takes care of the common bits, and the ipmr_queue_fwd_xmit(), which
invokes the former and encapsulates the whole forwarding algorithm.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/ipv4/ipmr.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1c5e6167cd76..7c1045d67ea8 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1853,8 +1853,8 @@ static bool ipmr_forward_offloaded(struct sk_buff *skb, struct mr_table *mrt,
 
 /* Processing handlers for ipmr_forward, under rcu_read_lock() */
 
-static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
-			    int in_vifi, struct sk_buff *skb, int vifi)
+static int ipmr_prepare_xmit(struct net *net, struct mr_table *mrt,
+			     struct sk_buff *skb, int vifi)
 {
 	const struct iphdr *iph = ip_hdr(skb);
 	struct vif_device *vif = &mrt->vif_table[vifi];
@@ -1865,7 +1865,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 
 	vif_dev = vif_dev_read(vif);
 	if (!vif_dev)
-		goto out_free;
+		return -1;
 
 	if (vif->flags & VIFF_REGISTER) {
 		WRITE_ONCE(vif->pkt_out, vif->pkt_out + 1);
@@ -1873,12 +1873,9 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 		DEV_STATS_ADD(vif_dev, tx_bytes, skb->len);
 		DEV_STATS_INC(vif_dev, tx_packets);
 		ipmr_cache_report(mrt, skb, vifi, IGMPMSG_WHOLEPKT);
-		goto out_free;
+		return -1;
 	}
 
-	if (ipmr_forward_offloaded(skb, mrt, in_vifi, vifi))
-		goto out_free;
-
 	if (vif->flags & VIFF_TUNNEL) {
 		rt = ip_route_output_ports(net, &fl4, NULL,
 					   vif->remote, vif->local,
@@ -1886,7 +1883,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 					   IPPROTO_IPIP,
 					   iph->tos & INET_DSCP_MASK, vif->link);
 		if (IS_ERR(rt))
-			goto out_free;
+			return -1;
 		encap = sizeof(struct iphdr);
 	} else {
 		rt = ip_route_output_ports(net, &fl4, NULL, iph->daddr, 0,
@@ -1894,7 +1891,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 					   IPPROTO_IPIP,
 					   iph->tos & INET_DSCP_MASK, vif->link);
 		if (IS_ERR(rt))
-			goto out_free;
+			return -1;
 	}
 
 	if (skb->len+encap > dst_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
@@ -1904,14 +1901,14 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 		 */
 		IP_INC_STATS(net, IPSTATS_MIB_FRAGFAILS);
 		ip_rt_put(rt);
-		goto out_free;
+		return -1;
 	}
 
 	encap += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
 
 	if (skb_cow(skb, encap)) {
 		ip_rt_put(rt);
-		goto out_free;
+		return -1;
 	}
 
 	WRITE_ONCE(vif->pkt_out, vif->pkt_out + 1);
@@ -1931,6 +1928,22 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 		DEV_STATS_ADD(vif_dev, tx_bytes, skb->len);
 	}
 
+	return 0;
+}
+
+static void ipmr_queue_fwd_xmit(struct net *net, struct mr_table *mrt,
+				int in_vifi, struct sk_buff *skb, int vifi)
+{
+	struct rtable *rt;
+
+	if (ipmr_forward_offloaded(skb, mrt, in_vifi, vifi))
+		goto out_free;
+
+	if (ipmr_prepare_xmit(net, mrt, skb, vifi))
+		goto out_free;
+
+	rt = skb_rtable(skb);
+
 	IPCB(skb)->flags |= IPSKB_FORWARDED;
 
 	/* RFC1584 teaches, that DVMRP/PIM router must deliver packets locally
@@ -2062,8 +2075,8 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 				struct sk_buff *skb2 = skb_clone(skb, GFP_ATOMIC);
 
 				if (skb2)
-					ipmr_queue_xmit(net, mrt, true_vifi,
-							skb2, psend);
+					ipmr_queue_fwd_xmit(net, mrt, true_vifi,
+							    skb2, psend);
 			}
 			psend = ct;
 		}
@@ -2074,10 +2087,10 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 			struct sk_buff *skb2 = skb_clone(skb, GFP_ATOMIC);
 
 			if (skb2)
-				ipmr_queue_xmit(net, mrt, true_vifi, skb2,
-						psend);
+				ipmr_queue_fwd_xmit(net, mrt, true_vifi, skb2,
+						    psend);
 		} else {
-			ipmr_queue_xmit(net, mrt, true_vifi, skb, psend);
+			ipmr_queue_fwd_xmit(net, mrt, true_vifi, skb, psend);
 			return;
 		}
 	}
-- 
2.49.0


