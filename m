Return-Path: <netdev+bounces-198303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4F4ADBD1F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79663B70C9
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07A31FC0ED;
	Mon, 16 Jun 2025 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ae20RqZJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCB11CBA
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113936; cv=fail; b=Xd0up6PtfhdxjZofEEhjTNaAkLto/hOqvofwyjuhx2MABAO0gDHczfAf/vKr8Qsz002bRh9pmed5umwtPuZn+KRmBg1ZDjvh18JduoPqNO12ymXSp0qMTVFDAiHIZ65n6I7nQJGN0C03Q2ZIGiE8zYs9BkNRer1Qg6KIGnR7zKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113936; c=relaxed/simple;
	bh=mAL+e3AfhFl7QWDsHWGl6tAL0dZ289aHJkdEVeRMgNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQlwxTMUI6F7t34PjT2WI+cwpCpOXN9swPGcJhrJ9fX5zwlZ+q4ga7FTKMmNXBEqKaIaoRBb2FEFMjH/Re4kqX+KpTDwViWIT+raKmAYSOL1BZS+x+Zx54bpknGyLn1PsmN1fu9TPCT7lEEmLp7MvuX+yAfKEFcToOW8FNTKph4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ae20RqZJ; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MX+am5uC61r4wjnmifC55de0JdbT9DdFJwdHPDbR9S4dnlj7+ZtNPP9cf1GQu4cU83a2fVbmxpbQX6s81B9jka2Pg5aDHnC4oMLu0IcRgqcXVd5fUfuzPbFUccSc6n7zbtajDV5GORYMhKBy0vdNhxLgIzLWwIURcca1ooiyrjxX+snTfjv4SsxZITdl4NYZv6QRJQJnubWert/5nD073nfBe6yBVBgYVt49l/JHa/g7tY2wkU3DG+8VqqBCN5Q4OMcmS8eZ/KLQDxEzJ4VYvj+KWdqi3x8ztsqDkz8DrG3ag+75Xaxk61YUrZICQhuBqHevXAxXiER5hpOW6rb85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2IADWnxCL8m8sQT4lwwQ/lWAqN8wFS3d2N5xSAVeic=;
 b=rgt7BE1/2RBLJQnOXlvuI3TAHEjMF5GjfKH2bLc3F7PNmbXJS/yn2bvKK1uS2lEaDXzSCftKSUXfBoA+aoDG9kgg45f7YaTTxSs4/qOpLZqYcD4Ysgxls5YWBL3MY3pgSy5wknRNpg2XazhFbnkE0pS/PtzHQAI7Yun0JfBPOCheoSBHyvQ6DgWpdgT4BVo+5FgA3iBzyGPJ+O+Tz458v0as5xUwcq+UNw7D4JSRX2KJIL8m/F50Ocu4wb6GL880oI78DbO+JisP1CO/K3kBC1hIA1MSaogDT4cSXRI45XvP+HfIM7Vzw0ZhMGF6wD1RAT1LoxcRTkptdfEFjFqk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2IADWnxCL8m8sQT4lwwQ/lWAqN8wFS3d2N5xSAVeic=;
 b=Ae20RqZJwgRHgv6iubOO9wk5RE/Di/Wrf2ogp3AyRB2PWuvz7P8nSMH9Cp6foZVv4o3F8S3f7BjCi1uso9+1irWx5IxHj6K1kgJF28l7+6YlwdN/RVGKRCEtxkxihnjVyRO3XfdXrrS4dmvUAeQR1Yakr0FybA1wFftKYYRqLnpEwzO0zO5z5GXRGg0LEbGKoMYxnMu3uYd4W1pFjeU7DV5ABTiQf1s2M1EFTEu7SOT3TVDTULhBFW91ST5FvmbUDscnkhNzeH9R5aaVZZWbGkC0YaxvExFe9kIB7E7V2DyJtsGo6mMEjwPbC3iDE8zbYmPijPF+IrDif2OvwjFM6w==
Received: from BY5PR17CA0041.namprd17.prod.outlook.com (2603:10b6:a03:167::18)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 22:45:31 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::c4) by BY5PR17CA0041.outlook.office365.com
 (2603:10b6:a03:167::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.33 via Frontend Transport; Mon,
 16 Jun 2025 22:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:45:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:45:13 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:45:07 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v3 03/15] net: ipv4: ipmr: Split ipmr_queue_xmit() in two
Date: Tue, 17 Jun 2025 00:44:11 +0200
Message-ID: <4e8db165572a4f8bd29a723a801e854e9d20df4d.1750113335.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: bd47ab59-4e2e-4a63-4f3d-08ddad277e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nlcj3J/MliycazytRNI4IWgObrjetocJzQ2DG7jX0niIkz5eoIGLFEL89WbV?=
 =?us-ascii?Q?gEgEAUGkaFQT2i0pHUHlLlhzV+hUQ9gMgYJB80j42/uDrOwzWeHqDcEbIErO?=
 =?us-ascii?Q?BmHGrwqtQboNQlRKgenkioOQhI0AN7xHvllz3rM6GeTKCprbzYrZ8Kp4io6g?=
 =?us-ascii?Q?zo49Z/W2VJjuwAvo6PjIYxlx8mmjawHKzps8jsRv6Kj/ugxs/Fa4M36hztru?=
 =?us-ascii?Q?tqREBBoxBta771Gp7oTgHj9kwn2M7REjDC5ogPWcjQyDsHLDu4sevdRc63Jx?=
 =?us-ascii?Q?OW4ZTcvRTwoSU6qjS3ewv8806B6DgYk7V1I0ERbPqgFy2vDA3frICJacJr9L?=
 =?us-ascii?Q?GeclveeT7CruBcbnqz40WnTKYNDzTOkMj2zRRikemcQ9py+EaLmrWvvYlsK6?=
 =?us-ascii?Q?wnLf2Q+8q/S+039Pol4gDrnjhQAc3QNzNX5+/MBsAWtl1hNKhNKIe+9KhJlX?=
 =?us-ascii?Q?CiVKR22LSzY8e8eK+zQyFOYuN8mHwB/veRud+EBCJK+dZmzTdFd6sRLOOWaX?=
 =?us-ascii?Q?wI9/oc1DG3bNIPvooCj9KKWyq3QtWBLbzP9EV5CPSlRqKPgEm78UHXVkvC7v?=
 =?us-ascii?Q?1seDgHdYK50CudZCPMBDZVL2ubmB2Z1m5XFwzWe+XlYcwl33ESCb5EXUPoMZ?=
 =?us-ascii?Q?3j4+p9Mv3CigPh8D0SOexGGU1ZOBaUE4kSBqc+N1kdm0/4uU3sd4idJGY+Dy?=
 =?us-ascii?Q?/9nZ2KUFFn1Gra/a5jQbtrz7E7rDZowW9qAbjL0s+5mK+I6evGqqQopmiae2?=
 =?us-ascii?Q?Lb8S5e1ywJHA/w+IHwqbEZy4V3WFKTUoxeUiBWb6uTlvGJCjGwl+dH/ZAGfl?=
 =?us-ascii?Q?YiWQuObR+5izAEy/m73/9/u7Tcb+TEBiYYibzaTXvECL//f7zf/VSv26pAt8?=
 =?us-ascii?Q?hE1xYZGE+01NXrtShBrg163eDfZeWB6gFDfIM4yRTaTcjWrsy1cR3tWjWAqp?=
 =?us-ascii?Q?fN84VbNXRMLYhZbpMv4l+H++JbE9mvF+42Ee6CkrPdXX7ABeVgsnswARmaZb?=
 =?us-ascii?Q?Nz1cYXHscsbvPVsAci4pLfFhrYaRyW75eYLaQQ9IzUPQr8HbP/bY77OWSq3P?=
 =?us-ascii?Q?ih7l/pVMSZnDDKjT4z0JqyxLIx9HtU+V24RPxFEa7xrXdFVHQ0O3rl/XWBb2?=
 =?us-ascii?Q?hxxesV1T+6iOZGTZ6Z7nB5iUKQpHN9AqKMHcT+BVbXOdUTuMtlqn5skaobjk?=
 =?us-ascii?Q?euueX0TvWzvXInimu346fnGDcaHZCY+Pl6tXWmpb+yUUG7aIG2BhKWPR+aew?=
 =?us-ascii?Q?yq114kzc4Wu6SuFkORMQNxqosJeVCckX9JM265VApYCCl+Cn0xplFFXNqUSO?=
 =?us-ascii?Q?Mr6ZvM4wq0AGUo4G+SGS0nQ3IhsD5U2ve4viNpns03tJuvkXCKEuZ4MJcind?=
 =?us-ascii?Q?tQWooJUBURTGfXYY+XHO6wuef4DprlUFUZcx5+uDnsQe2FoPiwp1H4WOg1+g?=
 =?us-ascii?Q?fxnXc4/nkKjq/vyUoyP9AFjNnjSBVRp4AF7qHNBpH7Vg+vqu2050R8tH3bry?=
 =?us-ascii?Q?mQz4LQCqhVUuHFYwcOsgWToYetrUVOHSWqnl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:45:28.9905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd47ab59-4e2e-4a63-4f3d-08ddad277e4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

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
index d2ac630bea3a..74d45fd5d11e 100644
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


