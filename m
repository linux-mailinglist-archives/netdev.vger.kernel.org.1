Return-Path: <netdev+bounces-195857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4BEAD281B
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C66189435C
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F685221FB6;
	Mon,  9 Jun 2025 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CvVaecN/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566C221552
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502350; cv=fail; b=URxYvl8RfLVLIxZVxk2ka6JfbMGFWpdG2IH01ujTmllEoOEF172diW/fQ2p0rNncBFJTZbaUwtxVMkRdq13K8GA9z5D0abS7oL0P5A81lOcd3a+ps5GrCi1bxFoa0sPU2qxeBMshChvOlxZVWKbW1qJFjCp3VDB+X7EutCxWn68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502350; c=relaxed/simple;
	bh=+QGVWbE05WJoXw1zPd8KwpIgRnemz7R3L43ludb2GGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTb81UEC8pnlCw2pPMEzYWNBps8D5zIV94VaGQJNBsLPAt+ws28eFpMZbVfOk+9477yVUV3J4vpwhqp3OqH/GyG2xdt2zi1iqnTvfaAwRisgfGsNNV+pL+VyOpJkrYFnmtuqYy+A8TL7o0zAcLEvlMfN9qR6a59Wid6YBACruVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CvVaecN/; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpIaxuW9HcG5ViL6K9MgEIADQaiKK+Po0969h0jiHSNru1QN8dn8bCSm7728dCoNddtNygpDbPuMd25CduOp2WrXmcRX0zWOTKFYV03vc8WkDc0piNSURXT5gAbdtUYiRsA6xGxb+DhZEyo9UDWInrPuZyk3t8qzbusITBWwbXypLvt+5Pu5SRvX/5WIRp+CJ3i1qCwO21iskseZvCjuWEa7eFsaOO6Hxi8SH1fGOKPF+kgMRfGL0hNKJIBeeMNnJtQuzdT38rMNVbxOx9tjnZDoFOFbtGyBAE8cad7Bs4fBUorwHtHcOBRHTQNVbPdNwLpVdcYsFVbUuQuLXsOsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j33Fq1I2zGbIzdqEWjBosGTYEAtatf3h6w3tH6YK5vM=;
 b=IbyLoCKCRg9TfUmAgEJjW67jAd4zWY9fiXqFQovYRhJfttlRYSt4BjWC613L0lFDYnQMExVAc3JRGBH7FF1Sqq8V7r2nkMff53S2odHjONIzf/nt81leWHw9v7ax5iKaryJHnQihGGbAsFyq1grJKkRzDLe2e/ZCC/Ui0vscnNeMQ8ynUKx6qYNJ0KRvflcK8+zMJ+p1W061j+kDcPhf0iUFv8UMfGCCmIIYH5SuXCcy8F5zsOwQOET/DIsdMaV3/jxhBLH+1zYtX2qoc62rzdNRVr7v13WFjBDrctVjdqaL52vQk9NMO9awn3w600Xm4FgKHXUUZBQ23ONuPqh9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j33Fq1I2zGbIzdqEWjBosGTYEAtatf3h6w3tH6YK5vM=;
 b=CvVaecN/mPifuNJWLoe+hiAigp8ufT0tD54I896S31EKpErrAn69/33oq4c+3GzvyCCPRl97job6rB96KmQghNpCWBT9VXvE1bXpOPsZX9CnZIs1fYjUQZuCy6C97LjLmy3UIZSK0n8/2Lndvew78JBaAsCYKFIg+8410hyCWO7eFF9FVaGUwhIQxH8LX2Vdvi9BOWtDx2pYFBua4lMy57ogZmrowxACAb/LPJm/tmyZYDDPwdFZQkwDHW4uT5ePLGf3v4PHrdE7muNnJysH0LApUsLN4KOmcODr7eIYDyku+fGYiuDEd5EMjDdwp8o9FLVpVZb7yapbX3Z7GrywaQ==
Received: from SA0PR11CA0070.namprd11.prod.outlook.com (2603:10b6:806:d2::15)
 by BN7PPF62A0C9A68.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 9 Jun
 2025 20:52:24 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::ff) by SA0PR11CA0070.outlook.office365.com
 (2603:10b6:806:d2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 20:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:52:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:52:07 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:52:02 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 10/14] vxlan: Support MC routing in the underlay
Date: Mon, 9 Jun 2025 22:50:26 +0200
Message-ID: <534f532c0f587a7ca1e04036b7d106ad9274429e.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|BN7PPF62A0C9A68:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d27f53-74f6-4783-ccf1-08dda7978906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?udDidIfz+c1/NgZmgiJ6/VdAPbhwmpzX8Bax1Y8uf4xKRSB8L6Hz65reNK+5?=
 =?us-ascii?Q?roCE8At6OHoYMEsSfZ3d2hUWTZCcWGo3IfR4x1tyARO5DmRmrGDtLcXBOe0Y?=
 =?us-ascii?Q?tbUCcx5cFHYdMPGih6Zy92/g1ueFabxh8vgZ00pW1uPsAPzaHZAc4iLgg7lH?=
 =?us-ascii?Q?vFfFSwSnu7KMG3TRqxuHvoYQiPByBzAPU7VfKJjfjP6NpMItRejcM9SQ07E9?=
 =?us-ascii?Q?34RUqkMywV8VlbV5Mb/4FmBr0EnrflL1LyMM2qLVNgfdfU44f6zG+UX7Kf0A?=
 =?us-ascii?Q?GN7fYi/+MnXVcTztnSnijcDTKvTwBDQnIRwJ1JY1b9DuAUmsZGUOD4l8xeA3?=
 =?us-ascii?Q?eQGf7Sn6qj4tFq7UkCSZtzziE0CvcceeF9UPNWc9pqYxnSxAux9MAgNi+Q7o?=
 =?us-ascii?Q?Hj/KZKhqfUFvBaPwCgZl1u/MeGZYfek246u2pPe5lE4M8pokkEbht+dR+NPd?=
 =?us-ascii?Q?ucej+8hx8Hn2Zxg6mEW5+8SzkD8GcplwlZGdn7KaUesBZjBsZOex9IGL50eu?=
 =?us-ascii?Q?dXO8y4XNMZ97rxAAL8oGjaxNH5FiQSssMrFxM5axIg8HgK9FXGMFJVLQAmbE?=
 =?us-ascii?Q?P7AwPq62TyYCLOh8Gi5wkH+c13Zyu3DI7cYezI+BxukBNDc2yXllRnb5lH+y?=
 =?us-ascii?Q?GMbCC4gyKZBgbyjoolE7MnrWIP7IpV8q/C2qtOWTsZRqm1CvinBkqwE3XO7w?=
 =?us-ascii?Q?iigMQ5xbkhgqtkbyZgstWoEPpnhTRhL+2Y8xa7B4ssEp0BKdeaMdhyaKcc59?=
 =?us-ascii?Q?5tlQbemiYqqpy/DHQz1pH6elyZXoD8VFWZQVBGO80j5q42Q9rIFudrHQwyOM?=
 =?us-ascii?Q?8Kv0GQXni8XZwmBBPEWpgQkCHfAEsrv190GVTGwtZbYFZjXfuU+1BRHqTjER?=
 =?us-ascii?Q?gu0/B0JsjWY1tJnvIu+IVpScCECcYDly/r586jDT6apP4cV5X0mjMgToVLly?=
 =?us-ascii?Q?CUSGQvpOBc0slnWt84wNdTNrQTti3ti85yQLp+BJnU60U/wnFzEG9pnfwIBV?=
 =?us-ascii?Q?zSPnrmywHwLiBVHAvZjap+6t+ZR5QT0rzI3+CjZsk1a1KKfNtJeaD3Km0sXH?=
 =?us-ascii?Q?ri8fyRjCW9O4OcY2uVij4+ogdbJ8sYivh95GQZNGgOD3KsSQW0zpvcKT7wXH?=
 =?us-ascii?Q?6Pnkrh0fECdl1rL/HKCnnkHA4yTidk/Hvn1X4/IUrBgIFzccdPZNA+rv+860?=
 =?us-ascii?Q?lnqHjZJsBPIFTbN1hVvytDBtFWRpprKcXkUDAfyjMSdAW07HMbEXWUi06lsD?=
 =?us-ascii?Q?DM1jMgXhvylY31r8by9jmuh+woo2QuZWQzN76DHSotPOqHcS40zr4iLaM7zC?=
 =?us-ascii?Q?JuC+yb/szKajItjhf/4AiQ+JOEQjj7bkVV+RJlX6n1VfB0t6P41E/R3DAtXM?=
 =?us-ascii?Q?AI/VqZn6UVCF/dL99FHq4NuT6OFnKPN9XuOolgJxDux7BstjVtb6S5aIWJ1u?=
 =?us-ascii?Q?ue9+FhwOxFo3dgM49n31QCzb0DRKrdfO6Cv3Cr3LSMNGC3RDMw14amZU2dwl?=
 =?us-ascii?Q?86LOBbL2AjL9HTEqcMz+o971SxVMTnz7Kt3p?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:52:23.6360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d27f53-74f6-4783-ccf1-08dda7978906
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF62A0C9A68

Locally-generated MC packets have so far not been subject to MC routing.
Instead an MC-enabled installation would maintain the MC routing tables,
and separately from that the list of interfaces to send packets to as part
of the VXLAN FDB and MDB.

In a previous patch, a ip_mr_output() and ip6_mr_output() routines were
added for IPv4 and IPv6. All locally generated MC traffic is now passed
through these functions. For reasons of backward compatibility, an SKB
(IPCB / IP6CB) flag guards the actual MC routing.

This patch adds logic to set the flag, and the UAPI to enable the behavior.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC:Andrew Lunn <andrew+netdev@lunn.ch>
CC:Menglong Dong <menglong8.dong@gmail.com>

 drivers/net/vxlan/vxlan_core.c | 22 ++++++++++++++++++++--
 include/net/vxlan.h            |  5 ++++-
 include/uapi/linux/if_link.h   |  1 +
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index c4af6c652560..02eba9235406 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2451,6 +2451,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	rcu_read_lock();
 	if (addr_family == AF_INET) {
 		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
+		u16 ipcb_flags = 0;
 		struct rtable *rt;
 		__be16 df = 0;
 		__be32 saddr;
@@ -2467,6 +2468,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 
+		if (flags & VXLAN_F_MC_ROUTE)
+			ipcb_flags |= IPSKB_MCROUTE;
+
 		if (!info) {
 			/* Bypass encapsulation if the destination is local */
 			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET,
@@ -2522,11 +2526,13 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, saddr,
 				    pkey->u.ipv4.dst, tos, ttl, df,
-				    src_port, dst_port, xnet, !udp_sum, 0);
+				    src_port, dst_port, xnet, !udp_sum,
+				    ipcb_flags);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
 		struct in6_addr saddr;
+		u16 ip6cb_flags = 0;
 
 		if (!ifindex)
 			ifindex = sock6->sock->sk->sk_bound_dev_if;
@@ -2542,6 +2548,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 
+		if (flags & VXLAN_F_MC_ROUTE)
+			ip6cb_flags |= IP6SKB_MCROUTE;
+
 		if (!info) {
 			u32 rt6i_flags = dst_rt6_info(ndst)->rt6i_flags;
 
@@ -2587,7 +2596,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
 				     pkey->label, src_port, dst_port, !udp_sum,
-				     0);
+				     ip6cb_flags);
 #endif
 	}
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
@@ -3402,6 +3411,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
 	[IFLA_VXLAN_LOCALBYPASS]	= NLA_POLICY_MAX(NLA_U8, 1),
 	[IFLA_VXLAN_LABEL_POLICY]       = NLA_POLICY_MAX(NLA_U32, VXLAN_LABEL_MAX),
 	[IFLA_VXLAN_RESERVED_BITS] = NLA_POLICY_EXACT_LEN(sizeof(struct vxlanhdr)),
+	[IFLA_VXLAN_MC_ROUTE]		= NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -4315,6 +4325,14 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 			return err;
 	}
 
+	if (data[IFLA_VXLAN_MC_ROUTE]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_MC_ROUTE,
+				    VXLAN_F_MC_ROUTE, changelink,
+				    true, extack);
+		if (err)
+			return err;
+	}
+
 	if (tb[IFLA_MTU]) {
 		if (changelink) {
 			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_MTU],
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index e2f7ca045d3e..0ee50785f4f1 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -332,6 +332,7 @@ struct vxlan_dev {
 #define VXLAN_F_VNIFILTER               0x20000
 #define VXLAN_F_MDB			0x40000
 #define VXLAN_F_LOCALBYPASS		0x80000
+#define VXLAN_F_MC_ROUTE		0x100000
 
 /* Flags that are used in the receive path. These flags must match in
  * order for a socket to be shareable
@@ -353,7 +354,9 @@ struct vxlan_dev {
 					 VXLAN_F_UDP_ZERO_CSUM6_RX |	\
 					 VXLAN_F_COLLECT_METADATA  |	\
 					 VXLAN_F_VNIFILTER         |    \
-					 VXLAN_F_LOCALBYPASS)
+					 VXLAN_F_LOCALBYPASS       |	\
+					 VXLAN_F_MC_ROUTE          |	\
+					 0)
 
 struct net_device *vxlan_dev_create(struct net *net, const char *name,
 				    u8 name_assign_type, struct vxlan_config *conf);
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 3ad2d5d98034..873c285996fe 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1398,6 +1398,7 @@ enum {
 	IFLA_VXLAN_LOCALBYPASS,
 	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
 	IFLA_VXLAN_RESERVED_BITS,
+	IFLA_VXLAN_MC_ROUTE,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
-- 
2.49.0


