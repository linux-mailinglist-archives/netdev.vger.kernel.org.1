Return-Path: <netdev+bounces-195852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2310BAD2816
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11FB189416F
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB6F221F35;
	Mon,  9 Jun 2025 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VSLqgvlK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58D221DAD
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502332; cv=fail; b=TZPaBlpxpvZhF8qkJmC7VzbBG3mT3cPRidqQLpTYPKh6LpDKOxrQ6Q/7ParfaEyBWwxQPt8gK6FCIJ8mnsvaeXld9zSjvnh+4uYNkL02Ch4F6m5T40ewUZp3wP1uLMwvAshFJG//R2Pnrb4GpTd/zwmWfqV6/sdTgUqt1egu80s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502332; c=relaxed/simple;
	bh=5/l0cF868gtGgSdGH4JB+MXfdZ4geagslDZrMzbiRTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzwLhU6ZJ2RJjR5UM9s9yV4+kvpWSbOKeYtVte9jTzy/Tt4I7Zv2PMxYZJjxj9d6cqyoJ9i7J9+eYetQTzwKKs074Nf78YMPwNmSen/V+C9iiZj9WVa+FWb65x4ondEQCNA1scySEm0735hMuhiYqaH1Ig7A0pdkxuDNyPtCyDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VSLqgvlK; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oq5Mg6x6GeRJcuv7babLMYSI/iCcC7BWUGc/GBjQ5oAhI0sO9ZPP10Fb7Khbp7FlnXPuvJIPlke6tCAWUfDWGjLlHc4++DBwpJ+S4A1pkZUKelwNGMpZ86GMw9Ho/NLhFpmQ/l5umDKTDnsq8ByHi+aIcSHZUC0B4UWh0qrazlZpl2+kxdggJzQ3YdWH8ojj2UIRdc+1RP84Gq9OxM9bxImu9k5dhc61vCSj7VttXsxqKRMo5ZAkYQpiN83u+mZ84vh8ftcIyOY8zjZHmKqrrx1KePjQk4UvYhEEFdmX3FVMDdtoEzegDNooAdCmUMyXxSuPVV6ZNxJExn4z0pItuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ6pIP2lUwkNO0TgHzsoOpXhCbUue3+DjUUQk2wcbSc=;
 b=yixoRAsrwzEt6G3ZXmOei9R6gyDVZPORGJkrrsVYEcB62gzfXkN/r8n2uuHoBrbDQMN5zmDzI2fQVqkXWjyVZNIm32rtFlexbPxABrUO3h9QRQbmvxL1wcSn4l+mN5k7JwV1gZv6T+dabPrPXltqvnoKUTuHrjtbVcSW8DM3JbdlFhxLzgw2uNxc40UKq9ucYlIN+/hffnMZmcGLabWyME9OJWT5xHo/0kafXnJ9pHO4RRrw1d+gk8TYjsR7UkoOhVqt40OqCG1e3TXKb4EWXZubN7WAgIxCCu3JmrDA0EAOXcReyzuKf4Ml6YVm4FaezB4bWtOEbSAfL+3rc5p+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ6pIP2lUwkNO0TgHzsoOpXhCbUue3+DjUUQk2wcbSc=;
 b=VSLqgvlKy0IxbbHSwgAoF9F21T5yA0JNi6Sw1Wn89Vl4lHpfxEAnowz+m9Fn7b+VQsMHbvtBneBGEP8/nUY+HRj0AEhgzqyoNLZQxfHWP/T245Wbei3/MHJe398mLOW8qRnq4u6xYTiZVrvVayUoX+Exy7fTas0qU6AbePxn4LBcNMHa5NHWnSkhtO4VwvIWvxNBYl12EjTydHuK70cg7SVayehLCR3crTBPfc8Td6GxXvmKbIn6ODEg3tJ10p0LFo/DBYCxYFO3kXAwZSHyxs49DA48d3fvxeEhEDSWmp2ggHgVFxoDMUlZ0v9JQllW/Y9KagdixNRf2KvwhqIiiA==
Received: from SA0PR11CA0074.namprd11.prod.outlook.com (2603:10b6:806:d2::19)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 20:52:08 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::c8) by SA0PR11CA0074.outlook.office365.com
 (2603:10b6:806:d2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Mon,
 9 Jun 2025 20:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:52:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:51:51 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:51:45 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, YOSHIFUJI Hideaki
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH net-next 07/14] net: ipv6: ip6mr: Fix in/out netdev to pass to the FORWARD chain
Date: Mon, 9 Jun 2025 22:50:23 +0200
Message-ID: <4d836908c8667a64f66652f5690fc60e0aa2d93e.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7d69a5-3ff7-4c07-c1e5-08dda7977f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?814bswXxZ09CmqxscFeJBa5U/Vp84fCZgyWO0h0EdJcABMhx3I4tmyGoalfd?=
 =?us-ascii?Q?A7AGbYo4JypZHoaahJvkCgpV98OqE0kSC3RGUu43PjdHdUjp4oyQdIFN11Q8?=
 =?us-ascii?Q?lA34++M9EIxkqgtbomAKPR/t3PnkOvlPvb+IRuQcgs1zY/Bn4EvGqzyBvSwV?=
 =?us-ascii?Q?KVOiv2fYdrG7QW0ROrEjgkNdePARblcTIoZtrijFxF4uIA0Akb0FdzBxQuUC?=
 =?us-ascii?Q?QMxBdv0vuRI3loMSTSkRKmVhhXeAgx00sLAKohBPtu8hfMO73Ywdm1sVNQFs?=
 =?us-ascii?Q?bblwRd03DjbvvhEeS3jo+BVCGp9r/BN5JTO1xGjJaQtvY6ih49HjqmANESj6?=
 =?us-ascii?Q?JzkclQr4e8Mw+lAPk/MppJlBB48IM/R5II3PkonRPXP2jknNAW6OCRMT8lIS?=
 =?us-ascii?Q?HnuHmvuAA7uFLNH8SLxegsq3ptihZQLXjRZlhAxaAjA7Hnba0wByXYHKexHZ?=
 =?us-ascii?Q?ZXzqfO8ei0UETVXI/kT1nDiFJSEgsbTTr5wFyjImAmKsr1yYkuRn+jlerAwP?=
 =?us-ascii?Q?I6AuGy+JXm8BKgTJxtoo/sKFXAi/PCMkSZzb3IF4DfwpgOPkdBN1ssG5U8ey?=
 =?us-ascii?Q?g5j0q2S0SZHQh7SUUbeMQfVPWT3MIdYl0TX4gkIwZ8OiDpnq/7XscO5uxceP?=
 =?us-ascii?Q?qFxys99VxTpaJY93YBS+e3pKHPfvVckwW7dvy38w9GX25xNAk03YnMpcWrki?=
 =?us-ascii?Q?1xQGdJUTB+RT5nGac0Rr255DvrApp8rMpA3e3VqQHlq3lO/cOBc4lepQb9p9?=
 =?us-ascii?Q?7HIwdqAB9luXwz/25/2e8TbJdce6OtqWI2Ndh3Hu4Djs4vWJiTaXSU+EWL/K?=
 =?us-ascii?Q?h/sAGFTRW2a3Vp6ZomMXbShrdzAp0vff12lqV5XaHzE53YXqoea58FiHZipd?=
 =?us-ascii?Q?yAlvMD/04Tc3euq1YHJnXa3MXHwilXO1/5yq83VlWbl/evoCGLi9YM7fww0v?=
 =?us-ascii?Q?8SJyWypa5tU0IXls4AqAnjBwRnK2S0v/Sw/++V/nkJ345xLTzd+iVdUdrd4S?=
 =?us-ascii?Q?dhtxLFxeUF6PAULMHki43Z0zNCBQGrYvucVihnNC/GGtoaMfKyHSBpdqdZNz?=
 =?us-ascii?Q?TWmHjfNvYVzP8XFmdH0w2b3+uxtelW1XmYMPvB8JF/+r1v342VwVXpyQVz8s?=
 =?us-ascii?Q?CdKSr+vxGqxzwI/hRiJiPknZRFwICeCp+gINkwPraAU9HFWuYV74VayDl/nW?=
 =?us-ascii?Q?kz7IAd70fkhJVYV8wKW6RSff21uYlvv/TcpBsVVI1xNfVeUGPbMxyW1C27Jf?=
 =?us-ascii?Q?Pk9AJzNWmrq0BBh+cUseSGMiu98paO2V/hVq+WnGXcjZGVdsTZoIgu0qGU+t?=
 =?us-ascii?Q?hNW/wQ3Fm6i47ipzGYHtwrHJdgWN6/698Ji1h+kEBHHG5aAWujbcpsZhr/Fg?=
 =?us-ascii?Q?SDldQqC3Fu9Gn5fZ7ksCp/7nEV6NyAgedH6M8fxtsCYN1cYqMRqZWeZ81KZB?=
 =?us-ascii?Q?n1HpiPSS7X8BSj8QHz24tBXyPAzCQT2BcJolyILGXLbVn0kdoU6IWzV3ptNW?=
 =?us-ascii?Q?ME0KvLsZ1g4YCpAMvLWPg5bA6P75RwOuZjKs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:52:07.5677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7d69a5-3ff7-4c07-c1e5-08dda7977f79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002

The netfilter hook is invoked with skb->dev for input netdevice, and
vif_dev for output netdevice. However at the point of invocation, skb->dev
is already set to vif_dev, and MR-forwarded packets are reported with
in=out:

 # ip6tables -A FORWARD -j LOG --log-prefix '[forw]'
 # cd tools/testing/selftests/net/forwarding
 # ./router_multicast.sh
 # dmesg | fgrep '[forw]'
 [ 1670.248245] [forw]IN=v5 OUT=v5 [...]

For reference, IPv4 MR code shows in and out as appropriate.
Fix by caching skb->dev and using the updated value for output netdev.

Fixes: 7bc570c8b4f7 ("[IPV6] MROUTE: Support multicast forwarding.")
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    This never worked correctly, hence going through net-next.
---
CC: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

 net/ipv6/ip6mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 3276cde5ebd7..63c90dae6cbf 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2039,6 +2039,7 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
 			  struct sk_buff *skb, int vifi)
 {
 	struct vif_device *vif = &mrt->vif_table[vifi];
+	struct net_device *indev = skb->dev;
 	struct net_device *vif_dev;
 	struct ipv6hdr *ipv6h;
 	struct dst_entry *dst;
@@ -2101,7 +2102,7 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
 	IP6CB(skb)->flags |= IP6SKB_FORWARDED;
 
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_FORWARD,
-		       net, NULL, skb, skb->dev, vif_dev,
+		       net, NULL, skb, indev, skb->dev,
 		       ip6mr_forward2_finish);
 
 out_free:
-- 
2.49.0


