Return-Path: <netdev+bounces-197193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FAAAD7C25
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636CF3A4609
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7106E2D8DC4;
	Thu, 12 Jun 2025 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jxFIRTyX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF52D878D
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759195; cv=fail; b=C+BxdeBEH6YGtDUrgrylyNpuasZrBxE3fv4v7ROsQUUTRMFhgqe/1vlmKeYb8tzMR3S8mltw8EzV76MuMn8U0ANtZFDf7PyZwUCQq9Chu+OGDnPj3dTTWCFif1rVAqJamfYRuvfoBKDbGV4t6843vNpLlvUy93Pbi4ekjggUEoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759195; c=relaxed/simple;
	bh=1+DyRfYs04wl6RHXn4jo34aPJY5lMU29IL2zk/mzQLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQ+iQfmLIDkrADxd68s9TPscHzwWcqij1zfwQz9HG1d+NKv9jBzr/wMvUlasD6jFKMmmwmhWGCJU1W2jjsrzKLm0ilxoaIwcUS6PB7MFZRE/BkyHN9oPY85PFIzPJc5ZjjK0I67BRmxraFiCVuWDhLfeTBcQZOBBjKcCHdQYdio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jxFIRTyX; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0RrbfioBThrVDZNN2VDAhL1NBmUPqxzBpTijEFxmU9AaUomUUu8wKoL2+Fng0BB6UTpEgjFCh3nbwdJNEI1XiKE2yU84UNB94BtlCukV3EKYhh+QaVS6ea5NmRsij8bA+WhkK6RdmjQIyu+bqGib2CjhmYCKZPOtL50TY2OH8b6JNmzkD9mf/F21iyZaT0Mm6WmL26NlWUy3UGoOxTldX4oPd28w3LpfxxObdCX4JjCfpVD/fwxP3d7oKR4/kcLK7emddfl6O0tLdIKivfCFOwfJAG7RDKHaHCPv6VSomkF/zJGtfz7mIrQL2isvYucscfyawUjx36wAvd//+9UJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHXHmJKiKramtwP0SFeP13R2r8WPdR4Hv7s3ZhwQSsE=;
 b=NHzuLi3k1NIzVURVYr/DbKjkVhPcCP2r1wi8rTvVxkOIACmnuj5xEC7Tr27eREA+pXEqbvGbm6Lkm/unTYF4RzB55ziVOjZtvcnO+fFC/v9k4OwFXzRkoxQ6uwK68brH3jPAXD1mY/37csI6UMPiMYIcmpreMhMR99kbKKjoo7D5n9lppJPispyjxiGEWblN7PJa6RgHw5jxck94tFgoaJmcPBR3+bFvhzOxT3sEcK6udL449uggW/GlJ44eGRjdgn6Xqe4e9n4X3kdyj7ddPINF6qJJwUW1K0ICiOt5vXPTI+KdAPkjclcSs+5s0qM/XUBTMYwmqwYj7D7ReKGpyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHXHmJKiKramtwP0SFeP13R2r8WPdR4Hv7s3ZhwQSsE=;
 b=jxFIRTyX4A+HuyMGPEGSdJEx0Jn0WFfiYOF3IZu+UaDtvQhdNtaCKszW47yRNzRc9FusPTrpfPjU8VsI9sSW6CnNj6yQV+n09AvnG/x44ynCVwXQYOmtLi4XfsC2HO/IIrR5tvidMOdWkGBJ88ec1uxFiLGMpCuKiu1muNrgGcQtoRU7mFdo7/keXs2jj+3siJrV/Ft0BgtvA6MpxVSQYSLreDocankVUFsxhtJJd/I6o8iuVCw7g3a3Z+v0AV2GP8tKSa/LJzDXSIjOG4r8dEdyW/hEYuSoaXUESZs1WHcpbrDTHYH+JMNoIioJdfmFj0TWMtnSYGjOL/NOvmOZkw==
Received: from CH0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::23)
 by IA0PPF170E97DF1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 12 Jun
 2025 20:13:07 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::90) by CH0P220CA0009.outlook.office365.com
 (2603:10b6:610:ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Thu,
 12 Jun 2025 20:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:13:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:12:54 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:12:48 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>
Subject: [PATCH net-next v2 04/14] net: ipv4: Add ip_mr_output()
Date: Thu, 12 Jun 2025 22:10:38 +0200
Message-ID: <ad02c7a76fca399736192bcf7a00e8969fa15e3b.1749757582.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|IA0PPF170E97DF1:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf7ddf1-546f-4430-5f13-08dda9ed8b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kBgWAbPjumyXljyBKmWXZQ61Z2Qt6QSc14fOsw21PaB/Rb2dakTcpHKQ9sUS?=
 =?us-ascii?Q?ATchk2FQoE0jgJzK+Ei8o55br2hvBBzfofbjOx/X4pRShRbcCm1e7leFzrfV?=
 =?us-ascii?Q?zqrvaSUF2GUhPOaNvWBYQROfEAoqKj4d0XxdfYO9QlX7T+JFEvJ8W2xRejJB?=
 =?us-ascii?Q?X8CXVXRKVcxqpyUot40J6fLqxc423FElW0DxXM63fTC3eTR9aHnfWMkaaOZF?=
 =?us-ascii?Q?eqc+yOpGhhUJTZ4xIfEpp+8qngu78PV5cBhM6uRfeul9kNjrCoPLNd5vYCfY?=
 =?us-ascii?Q?ZJcHTyn2p7QXSxGZw4+R7mP242WBFGblKJu2OXCqyNjE2+rdTZl8CTcw5dwp?=
 =?us-ascii?Q?tVoxeDrhcUzTFh/Mk2tfvFF24D/+G8AteXB+iHzVEYnKSZoMSlpA/SyyIxRd?=
 =?us-ascii?Q?SE/3kqvi9kWt2q2qyF6IwRdDcIOJrFLXBqAsKxogy0AHXWa6HQXvazZlo79u?=
 =?us-ascii?Q?qTi1BnVBxbkNbw4DNEk0X0ULiqcStIiXQtWJjt7Azfp7Z+nZ6Vp/nM9/gZMD?=
 =?us-ascii?Q?VtqSKTHvfsgf0cLeTKYMpjqjFLn2M81xLy2D2Q8ciCtX0e3QnpTpHikgNFiT?=
 =?us-ascii?Q?xfis5+Fus5cxNyhjxOS1ytViN5An9DjilGsDfOeqBdSFjAhepi2bk9ptdesi?=
 =?us-ascii?Q?neNgyuIPG1Ziph0ETKOGzh2cs5Y3UxetDmGmlCIMQJ+G/2ALXZ/sw0TPKdzm?=
 =?us-ascii?Q?Es5icAeWPS4F1joDe4Id065D3YS7CD1h2XK3pFJBet5+HlJ4qU1TrnpoH86n?=
 =?us-ascii?Q?Y//GJjI2GvyJI6m08g71vCBnJYOgFKymDfRlUxeUrNNVCuHjRm1MdS47T4b8?=
 =?us-ascii?Q?uDgM3WdP0WnUQ8BrdGB8qnZrLLZ9fNUthdhq/snw45ZNoC9iJKD7XpJEeR0T?=
 =?us-ascii?Q?mzIrwlIEK0w9U4pmAQsn6Vc6Mpncf0/rvmUGu98sDmIiF/4GcOQ+8zh/qpBN?=
 =?us-ascii?Q?W0asM2VwMi3sWKRXvlGtXCN4qfzQL16L03L1wx9pvAo0Z9LZilbd8oWW1g7l?=
 =?us-ascii?Q?NofxxuPihe34qR9gYamAkwHVX119SRN5iH/o+e/S1tPL8iIzHgaoGSZtF+8s?=
 =?us-ascii?Q?/NP5xxXDjl+z6ZH7yWF26fC+9NxRgR2sFknj9REoTzVxvYjT8DAfpdgIzCrE?=
 =?us-ascii?Q?uGc45JUwhIZQq3/Supfqfcg7Sa8xUqop6m7RBBP4P9SmAOT0uFCM7FRc9y+c?=
 =?us-ascii?Q?5hyqb4mkItbecWS9dDhGIGQs9vXqjHdDesxGEOUJ57PaKA5Du46izSTkRus/?=
 =?us-ascii?Q?9RPwcYMq9KQnM3W2QATRSqanVdBXUVTjoUr8yle/1mEmTJRAQSvHiw0FsMx4?=
 =?us-ascii?Q?V690fqEaTAWUKe7SdwjepIFEfC74NL4opPQs/n89Kl2cJPfQaBh1r66jCKJw?=
 =?us-ascii?Q?GAb9G8J2DiBK/TVxaDpM38O/Qoo3Tm1KapBNKhs1LjI12Ify7/UbrUjjaI5F?=
 =?us-ascii?Q?2ns7dRAY6/Y1lyNmHsTuXDNfVkocxrUvtq5FWPNFtFFB4TKevOYdBjgeWx68?=
 =?us-ascii?Q?UFVZGeGXCzkSE2E1eot6bNdvEzxc5Kkrbbs8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:13:06.7743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf7ddf1-546f-4430-5f13-08dda9ed8b80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF170E97DF1

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


