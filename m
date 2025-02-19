Return-Path: <netdev+bounces-167762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C37A3C236
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 15:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7F87A6B60
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542F1EFFAF;
	Wed, 19 Feb 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SPZk+ZvV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398F1EFFA4;
	Wed, 19 Feb 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975632; cv=fail; b=a6+VQJaM6yg6fJ+382HYw2m1eQFjBvbBQJAgM4bdZOFjvS68H7eAIOvAhQRVg4PyWUR5iYYHdnu5zL/aD7UMbkrclXNL1NXg+0cvZ/jHCqd8YhhYq0vfy1PhrErUV9rlY1FgjSmwTatOcCCAIVhtQ6opi+AwbAzGiVMK4Rv1RQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975632; c=relaxed/simple;
	bh=JmgyYESn3CUmt4JE9EQ3CIAC/4TZP1D1XlcFaSsAffw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJMMx64vJJohKW7LrDSRbIPGMO3G/dwrWNiFWlTCfOelV5Ss9oVeYaTY3cs5qkMKsfq05bc0zrnbi911DwrcltPOi/NrUvuOkl6b4ogBnVwY4VdSq7OskGFL8AySgYy1uutgWLZjBYEW/XuXYe4/wAScg5SYyvBOL07tMyNPOQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SPZk+ZvV; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfvOIhi1SobOY2qzruxNifssNgVt093yz8T4RqwG+yp/vpnbFv6L1/3fcfawkPiVWTyf0I0GQ5UJiiVJTJ9dgDZvgp5xm6VBefow5Nqdm7w/d83Czm3vOZNZt9O6dOFBOydiT8YWKvAPUlPtvORktf1PIiU3YsUNL3ScFyBEjZ1zLCnxJnASKwqBHXGf4Qbj43duf4UsWNyKUaYvxm8M4EQd6s17sk0wcWTRNhpOCtHtONg0sGvGUXg6/KYPm6axxsUjZ9CR+qcVTJx/8BX11nqyIM+TgoR8OKX7kE1HlxlIrQGVWG0qf7BlYGi6U9wxHIIrFJdZhXb6WHFfUglgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppamyy/TXwLa4SxAueWd0CLpRg+uf7kr2RX27YPWzIo=;
 b=eYWpU+jnLV8oxANARMgzs/bJsZZDxdJzI915eZFg9Jyboi5FmJV5Lnb+p7pXCAmBiV7iqCKAs05vgIP8xa3rlLy2PGLg6G1bI+LREl9fNtAVXRsZhsWXZ2SD5k2w+pkvesbAhuFrvuvybWAhWOK529v4kPcehatkgAqVFvxfqJxolnIHzqnosMsNvnJwkU3JWFBYanN5iqrV6H8qdq4VLukLB5yudOsGHo68WhMHveZ0oe3m3T1ebkShHtjbdRugQi4pgCacEk9+xhmbUg/b+/1vSUGjiuS8ap6iAvcLKnr03oRvcsiJyR5r/HXAXSqGadd6zJUXGJNHH7hu3rzmLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppamyy/TXwLa4SxAueWd0CLpRg+uf7kr2RX27YPWzIo=;
 b=SPZk+ZvVZ/pubRgs26sOyVPndddK3qcr0HIBqRKy51+9krVumEwEwMVD2+BM0OrN/fQGqsQnCBRg+HhQbdUlus5JRLSSwqKFeMzewmA/9CYmSprUMoREFTZ87dxLhuky4AG3H+h3y3MNWK/L69GPvE7ePyH85lLsuaY7Xh68o/r8QRlpjIgvCxUbO2EgU+7WM+asFH3qympu0ErM34NGdqMD1PlbhVEjv1VUEg+LRwfIM9IOsmn36kISa5+tkzL46q49k3mhGle4CpFamb5O7ZN/qO+Of2jopqqOgOx9nLI2nc1/1haA/Y0NLsNyw5zXWk2FbREsK7Sb4TS1d9AEfg==
Received: from CH0PR03CA0068.namprd03.prod.outlook.com (2603:10b6:610:cc::13)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 14:33:41 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::fd) by CH0PR03CA0068.outlook.office365.com
 (2603:10b6:610:cc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 14:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 14:33:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 06:33:11 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 06:33:11 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Feb 2025 06:33:06 -0800
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Tariq Toukan <tariqt@nvidia.com>, Louis Peens <louis.peens@corigine.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, "Pravin B
 Shelar" <pshelar@ovn.org>, Yotam Gigi <yotam.gi@gmail.com>, Jamal Hadi Salim
	<jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <dev@openvswitch.org>,
	<linux-hardening@vger.kernel.org>, Ilya Maximets <i.maximets@ovn.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next v4 1/2] ip_tunnel: Use ip_tunnel_info() helper instead of 'info + 1'
Date: Wed, 19 Feb 2025 16:32:55 +0200
Message-ID: <20250219143256.370277-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250219143256.370277-1-gal@nvidia.com>
References: <20250219143256.370277-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e912f5-5572-4322-cc0b-08dd50f26832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nWS9tOmHUXV6kd259G1Euq1EDKHCyDZ1Kity6Xot6lcmDtlKf/sUTLTDj+uc?=
 =?us-ascii?Q?8DrHa0C9Y04gtXBb5c+1SVXVN3luB1qU932PzbV+y9zPqXxOmCGH2JX6D+zK?=
 =?us-ascii?Q?5oEOsClvaViwsuAlFcVSkEVvf4kRiMvr54a4tggLSA5H5xDs0zS6cBcuG1Xg?=
 =?us-ascii?Q?w7fcpz9I/F38I1tq0ARZp+Wty0Gv0DRZX1Dvo2Jc2fYQ/QYv3lArjvy0MFDz?=
 =?us-ascii?Q?1ll+5WOQXJ3Ze8iFdGk8tyxnATzqRzEDu7JQvKQUrsrxO+SIt1Sb1P1ZtjQJ?=
 =?us-ascii?Q?bQxttlGL2WeRqTMSmy7SvljjSsqn0XQgDbrvN7/0WXJyaKdVxmA0BQw6XVER?=
 =?us-ascii?Q?XT3+6Yzdum+adpsSi9VkaCF1EP/FP3rFUcJzykgqXenZXcn4UmAToo/u0y7M?=
 =?us-ascii?Q?F+E+xCCTez24M+2hPvLvFt0pqOl1QDFddTJQknNzfEbefXNP0JHfKt2KN9G2?=
 =?us-ascii?Q?PiMr9HqFQLdrwSeRQS74MHbdFR6QYeoddL8HA+OG2becj5l3hRU5KLJLlo9g?=
 =?us-ascii?Q?SLdXreR9rV91zRwDEvP7EcGid9SAVrRPfXeQFjW/IQQ5wHZpi9uUVqrzS3No?=
 =?us-ascii?Q?xhTbf0Nw8PxCSU8M1X0HC6JNyS3ueBB2SRYm5kej7uj+bPXV94vn1e5Iin+k?=
 =?us-ascii?Q?v35/YWCkYiWcggK6W2Md9+BQAdKeo6xY2wyQ3w+i14hFHXMqx0ukZyiAisin?=
 =?us-ascii?Q?So2uYNUBpGIJNFcHpLDcgJXaILH+XTUo/FHKvH64Sxmh0/ufD+uGXBwnjZK3?=
 =?us-ascii?Q?6J+uyCLcx/hrdIRx5HQVDDdv2GDoVFu01tes8XrqcoTGWGpShhr1roigewTs?=
 =?us-ascii?Q?W+oUN/kHiJowMMbgAo+clCBATcGVKBMWdziVYo3jeamhYnmVem9RUucOpQ3v?=
 =?us-ascii?Q?3NYkVhK0O1aBHEuH0DgKDk0moTmYzSMapTU3DIohuJA6N6wVOghSdPDhJrKd?=
 =?us-ascii?Q?5BOhv+unq5vUC3ONUy4QsRWxTGg4KAZIrn2kXfv+LwLy3b0pGkbZL7YtLhHR?=
 =?us-ascii?Q?rRoIn0A27v6WJ/f4Tmf01gFsZadfueEGgJULw1ZgmJABYIT5f4k/LxzEjKQ2?=
 =?us-ascii?Q?BNSOGJhKNVGqbd8QVcTTCRX7Xj4c076/9Xenso4UJ7H07BH8njciDpMsQghP?=
 =?us-ascii?Q?u5ieocZTxfZ/7bD3RwVAg0e6k7pklt3dl/i3sDNnTdQF1rrqe44o5vLQZ00n?=
 =?us-ascii?Q?iUaA2Ajx6LzOWpVaQ47utMBWxQ0tovapakc4NSrMjvYIYdNsmWfT7qOYaWXU?=
 =?us-ascii?Q?4OJ3kQTfTIMjEF9hgSO9fTFwEQwyaGI4HPECphvefYQoJ79diJbE6gkfj/n5?=
 =?us-ascii?Q?JGP671F6JtMy0s2AzNBb/haJ1QOO8TaMZHQdbcpKhcfW/i9LWWKwQTOXTOva?=
 =?us-ascii?Q?nFaefQJsFQr3tur+aVz3m7vtfRAiox4+ncsM2jJwzYafG6Jx9B9LNq4jbLES?=
 =?us-ascii?Q?EjXw791cNJ4QWvojAK3bARfi4BA47noOu7bbStpFZjVHlq3LbNUO5heojdvq?=
 =?us-ascii?Q?SS1yrxlQYt9kmbI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:33:41.5226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e912f5-5572-4322-cc0b-08dd50f26832
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970

Tunnel options should not be accessed directly, use the ip_tunnel_info()
accessor instead.

Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 include/net/ip_tunnels.h   | 2 +-
 net/sched/act_tunnel_key.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1aa31bdb2b31..7b54cea5de27 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -650,7 +650,7 @@ static inline void iptunnel_xmit_stats(struct net_device *dev, int pkt_len)
 static inline void ip_tunnel_info_opts_get(void *to,
 					   const struct ip_tunnel_info *info)
 {
-	memcpy(to, info + 1, info->options_len);
+	memcpy(to, ip_tunnel_info_opts(info), info->options_len);
 }
 
 static inline void ip_tunnel_info_opts_set(struct ip_tunnel_info *info,
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index af7c99845948..ae5dea7c48a8 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -571,8 +571,8 @@ static void tunnel_key_release(struct tc_action *a)
 static int tunnel_key_geneve_opts_dump(struct sk_buff *skb,
 				       const struct ip_tunnel_info *info)
 {
+	const u8 *src = ip_tunnel_info_opts(info);
 	int len = info->options_len;
-	u8 *src = (u8 *)(info + 1);
 	struct nlattr *start;
 
 	start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_GENEVE);
@@ -580,7 +580,7 @@ static int tunnel_key_geneve_opts_dump(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	while (len > 0) {
-		struct geneve_opt *opt = (struct geneve_opt *)src;
+		const struct geneve_opt *opt = (const struct geneve_opt *)src;
 
 		if (nla_put_be16(skb, TCA_TUNNEL_KEY_ENC_OPT_GENEVE_CLASS,
 				 opt->opt_class) ||
@@ -603,7 +603,7 @@ static int tunnel_key_geneve_opts_dump(struct sk_buff *skb,
 static int tunnel_key_vxlan_opts_dump(struct sk_buff *skb,
 				      const struct ip_tunnel_info *info)
 {
-	struct vxlan_metadata *md = (struct vxlan_metadata *)(info + 1);
+	const struct vxlan_metadata *md = ip_tunnel_info_opts(info);
 	struct nlattr *start;
 
 	start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_VXLAN);
@@ -622,7 +622,7 @@ static int tunnel_key_vxlan_opts_dump(struct sk_buff *skb,
 static int tunnel_key_erspan_opts_dump(struct sk_buff *skb,
 				       const struct ip_tunnel_info *info)
 {
-	struct erspan_metadata *md = (struct erspan_metadata *)(info + 1);
+	const struct erspan_metadata *md = ip_tunnel_info_opts(info);
 	struct nlattr *start;
 
 	start = nla_nest_start_noflag(skb, TCA_TUNNEL_KEY_ENC_OPTS_ERSPAN);
-- 
2.40.1


