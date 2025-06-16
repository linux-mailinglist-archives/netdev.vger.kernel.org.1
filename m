Return-Path: <netdev+bounces-198308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E53ADBD26
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3B0189240A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EC9218827;
	Mon, 16 Jun 2025 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nEYVQo2r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0821A454
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113970; cv=fail; b=RY6JSOa3ixppldVrsTQ1OB8f1wztA/SToDr5cJQ5sh45nk60XOF1IfaL9EU0f3PRppTWHl34Y0Um2SHx/vwX89xEVg4qkhQyPFCywHSQstcrSQWFvr9C2Vz3Kt8Jr5sWU111TNFuP0kFts4ju58LpEJy4YdGvimux9unB8WTUMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113970; c=relaxed/simple;
	bh=c7i6ny2wLjvBHUqZkSLjhcW1uixv/8/O1rkMKKRw/6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyzkiyuTQ2di/yMDxsC+kSzq3rZGDB9TcAZidnoeHdYfr8ByJXEfTid4Fd5hlWKNZ6wl+jXLaX/WbkugY8SQ4QIAaAmyMl0wub5SJdjbprb1iyOdqY5CPRj3vHGLbP/XWelZqvwnFWTInCzyGj0QTvn8B8YE7HVOfhELPCFBSKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nEYVQo2r; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmu7v+ztvKzRFRfwRZRK3CABD53arTz0I7orNs0z0rZSAoTizB8JPH1Db+iFCCMFqHqs6W76U3jVT6jqaz59aL2fadRoYbc9K/m6/aaU4g3XabAJsVMLnWWEjXMJ7BMSQzwl+Ix6LD1xF5bdIlZwGPSqYlEExtZ83bETdcuHcidXJUsjlt4CTfjt4DUTJIBHKCEcAOHqPD4hZB7Mv4a1lQYJqKCZVbKCGuWN8gZFByxRzLV8aQTNoRxCDDIJd/F7RfxT3JZew6wnN1TeXyE/8pJEySrkSHuTvP34496ZCfVaN2EX62bh9oPe2uCfPrEZC6JFU7E0waiQtJnP6UDqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYW2ZPdv4XX7XpxBCSk7bg4KdgAkVr3nBIdb79I78dA=;
 b=EmvCtfeF1MRI55BDaQJCdPEkIW/pJihkgRyIYIXFSvE8U2lgEXJhXolZVjAWrVgK12gNf5Upl0tzFqQ76oOH7ASNAwL2DAmMXtWyLBz6zIvoJHSuEzLiPzsF9iawMoghVMlTlF0rpOIoVDzrBy5Kukq/Ig7ka2yf4HJEP5G+lDT5j1/xEWU2LpoIMti2/Hgj8QH+p1diVAqwK2u4VXYwvGPAnAkli9NC8Z1HiaiYmFO/S6QQ2mkrtSLG0nU0ecek8b6fWU4b37zXHx0zpp6UeXA6eWtvuLthnp/hlEgwVm70JQf7ERiFbfT42XkWU+Tfafh1OlbX6nwYAr0rQmwdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYW2ZPdv4XX7XpxBCSk7bg4KdgAkVr3nBIdb79I78dA=;
 b=nEYVQo2rVZdH4HRinEpr4LgPakANXq9tPVFsOqB7rTylEkRCaA1Ma77UDGNXlsz31sOFvLfXh03RB1fSf2qjP8FD0kwNeL/noPeyCcwEo8zSStlJYNVAT+Mswx7zijo8k6SKVZi+aBsRi087YIh5/rYINfYyFPB2uLhB7tXI39GYBUvx/oxASDffkQtWQ38eWlj1J9jIrLITC1qJHoEQu3YTscwN3ybqgNmEzSP7NaCIdzT7WZbxKjFXFS+J+LOw2/mk1i5nfIrOI72oSXPDQlT6OPwfQ/lQAdc7lfq9RU92XjCOMXqbYnku63dU2/Bte1XOl9cJBJk2pRrSH30jXQ==
Received: from SA0PR12CA0025.namprd12.prod.outlook.com (2603:10b6:806:6f::30)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 22:46:03 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::e8) by SA0PR12CA0025.outlook.office365.com
 (2603:10b6:806:6f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Mon,
 16 Jun 2025 22:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:46:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:45:48 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:45:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v3 08/15] net: ipv6: ip6mr: Make ip6mr_forward2() void
Date: Tue, 17 Jun 2025 00:44:16 +0200
Message-ID: <e0bee259da0da58da96647ea9e21e6360c8f7e11.1750113335.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: e751001a-3c3d-401b-e684-08ddad279257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YZhlvDq1nrNlXOIuO3TtHVeNpqZdOPvYby9o+c0RMoVngHU6tijLt95Cb+fs?=
 =?us-ascii?Q?dMI57g2pr4PVEC3J1E0unkDARiUkFNaRWjenKhxDBo5P+waYkBNNGQJ+Ti6P?=
 =?us-ascii?Q?XJhYVgjWdDKIYUqdEL/2oIVfzstHRKx1b0TM66tJzozL62THCW5XSTE5f8C8?=
 =?us-ascii?Q?t5U0pG+JHEX/FcormZUjnC4nhvbFAiiz0oHfB9ptztW2nPF5Vj3qQ8c1XgZ7?=
 =?us-ascii?Q?SFtEiUyiCeAiW7ifmptVFQ8yyeY/pVLll21KeMTf4c+Y/iq8UZctjHUxJgaK?=
 =?us-ascii?Q?rtMT5HfsiMUBkiP48VeEpxIvrZ8WaR1EvpFV4hZcKLPs/5/ygB69wtHKumQY?=
 =?us-ascii?Q?4v3w8V8p2lTzV3fYNB0OtLNJI7yovOc0XunwZ8jEQdXukCThdG+R8ionxSQG?=
 =?us-ascii?Q?/0yrgDVyPLOoj0dLq8x1MEIbfJkqx4zz9RbgxZSVbfWSalDfH8yt3cbVU05C?=
 =?us-ascii?Q?78YLybGk0zcRsHcGO//okev+3zxc0swk1Adpwx+Akj7+lpTI6HKCe3DriBHF?=
 =?us-ascii?Q?G941qdQ2xTusLyqCh5oVrkhoY2l9UM4K6l0ZtXz6UJmA/p2Nn2IG5wtiFGR1?=
 =?us-ascii?Q?WP+oZnVePdcqavJsW0ZGzku3V7SGWvO7NXNnAALc2g1lboOA2TaK6NDWhuM0?=
 =?us-ascii?Q?MX/MgD4b6kUDm/LQerJo4jzVFJ9GJofiNYHTvYgnG87fi7Y6dBrwLr4tsj4n?=
 =?us-ascii?Q?94oHnjGqPhabBCkphvrZgI9wAbMAKGCej+fcbEBmnOsqHoyOdaxdPWVRuV2l?=
 =?us-ascii?Q?cYIVoRJpyZTve3TVNFINoHCqQD8weS4Autam3G3Wft7asLhTIW+s5sAvhwVv?=
 =?us-ascii?Q?iVw9j4s05JSSinYkgm8VZQLGfnugX4lfk1LStYorsCewsQ+3UcoEyF62xaAq?=
 =?us-ascii?Q?jUB9tXDw1QjfkhnduUKRISDEN3cgh2iezZ44l+/d8YDFqbT0lPxapCpcH4xh?=
 =?us-ascii?Q?gdDE18dvh/rXCm1KBZrvUCWhPOsyXYSMfZkJlxjgWlUSHj7yAqgefwWT8C4q?=
 =?us-ascii?Q?UfAIKnKRcvBgylh6n9MFDTWWxltYrV/D53BMKQ3LoIdJLuQLip4dGTpG9Q79?=
 =?us-ascii?Q?zvxVZC/NUHepODdJmTmDlCbKDkgl0z/V2BNihG7Sr1AeNmA+OUJOC1KSq1Te?=
 =?us-ascii?Q?z1BjpjjZa9Z6hxnlX4BbItm5hae24aCI2KLaJj+J/Vl1BFzV/tvAICGAfzYg?=
 =?us-ascii?Q?XXAjDMysT5AlHsTOu+LNH1KNC/gnvuLwDbGbap3B/Hgpmf2YTjO/4LQrtr1e?=
 =?us-ascii?Q?eAtkBJAZprIPsoe8zzRPm9qKUCJjN5H7WHWQO92PW1ZFZN7WNTWTqyamSDIi?=
 =?us-ascii?Q?huUOtDCSVyvKkyjBAcdFjscHvO4kUAcI/EpflZ2d76c0YxtwASNiaAfEixvv?=
 =?us-ascii?Q?ETHSHftCal5q+bpxvdNKGZqVXWC6fgYgA4eC6wwBIrptC5t62ssNZRl/uaa5?=
 =?us-ascii?Q?+ano086rlaeMKUj8eLVd1npx7jkNKJll5oY/ICiaE4ci67anF9YuNYB8+Bb4?=
 =?us-ascii?Q?J1nH4xu6Wogg9H+qrLDOMdogS53sRFr65HE5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:46:02.5639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e751001a-3c3d-401b-e684-08ddad279257
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283

Nobody uses the return value, so convert the function to void.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v3:
    - New patch

 net/ipv6/ip6mr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 426859cd3409..41c348209e1b 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2035,8 +2035,8 @@ static inline int ip6mr_forward2_finish(struct net *net, struct sock *sk, struct
  *	Processing handlers for ip6mr_forward
  */
 
-static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
-			  struct sk_buff *skb, int vifi)
+static void ip6mr_forward2(struct net *net, struct mr_table *mrt,
+			   struct sk_buff *skb, int vifi)
 {
 	struct vif_device *vif = &mrt->vif_table[vifi];
 	struct net_device *indev = skb->dev;
@@ -2101,13 +2101,13 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
 
 	IP6CB(skb)->flags |= IP6SKB_FORWARDED;
 
-	return NF_HOOK(NFPROTO_IPV6, NF_INET_FORWARD,
-		       net, NULL, skb, indev, skb->dev,
-		       ip6mr_forward2_finish);
+	NF_HOOK(NFPROTO_IPV6, NF_INET_FORWARD,
+		net, NULL, skb, indev, skb->dev,
+		ip6mr_forward2_finish);
+	return;
 
 out_free:
 	kfree_skb(skb);
-	return 0;
 }
 
 /* Called with rcu_read_lock() */
-- 
2.49.0


