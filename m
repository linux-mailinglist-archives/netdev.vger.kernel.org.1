Return-Path: <netdev+bounces-197197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA14AD7C37
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D09B3A514E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77182D6600;
	Thu, 12 Jun 2025 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rKv7k//n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B42DECBA
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759220; cv=fail; b=WUpY9XskwHFNWh2gYXqFt65SvEuZakrvDb9qnCi2Z8Lt0S2r7MuoMSXWLUpz03e1eXTWpcM7UQ8o49Jqs1oyF4z3JiuNfXL/oeaIXQ7NQxhUnA6YA65yQpwwn1m/uIsxbUMV3gedrIYr9bPWsulUVGe2W3nwr6MMvfo8X+wMl+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759220; c=relaxed/simple;
	bh=35y3cHTcBiRfJ9DaPP5dTJJoZXPQBD5GL4+Q7uZ2vB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtQU43JNJ0GQ+QfBiypuUZOJzsrpFMiJyzUWGvGwAekxKVfC9enrEG8aRgwFLjYfhXm3RCHRtyEbyTv/J9I+O0QI25yVostXFzqpsSO4yZR/sd2F+jvUu6+lt/8E63Zet2S8Pg5bFDowpZFg7QjnaDw6J6y1rrwKz+Z2wLucBYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rKv7k//n; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bq/l0JwJ240MfTePxlIy1mnTfSPwckiHdMnXv+jN3ttaQjGL1PSgrnwJ7tvfEM4M7vPA7qOikap5JIF0FTjmE41r3fxagqjhnMWO9jSQ8zP06M8ZLa8F2BTUTxAsum2EdZoiQavi4CxR437R8q3eAmeJ/mVwNloT7SB8Oh5dAXd8+nB5FUKohnodzJ3NohvAZD+6ow6CRFMlz6EBgABeyKUS9dMO5nkPEeqh0M7DJFnn0G/2A0W6d4NL6n2zQ5hWYrRLV/jb1efVhqGWOR+oYGGMYCIvfeduFYRDXS6PgeBHsBAuQ+JFpwavS2x5b6XbMVlkaRvHiw8qiL3vp6k/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vupvo7AxrupGrdnJRHwgi316g5Uqp24j5MbRJiTb7o=;
 b=WsThZsruQVPaNaapJCLY3ZGkmb6dXLrgmVaVCN3KBcVwBkdsBNWBUW086nXc5H8Xl+IBqyKZZNJ8cRI5lnGP+9jRus99yT7bCVHxT6CRW+mxAgtJBYYVof2mc6N7su6DEJ+eZjAQ7wlA+oOQoFcdIL7f/Mgg2ON4eSoj29TfZ0V1SZXjVoakYAQBOLk6HJQMf9sjOubLxfw39/0oE7Mf8qToEBZCH4+l+D4nQTHvyNjjcqlH2aBetukSBrCW/bnXhqXBB27sN1yS5FoEIRA8WdQnYnekHEbdhoelrTdIsUHKRnl3Pj7aW48sV0E8h39ZNXflgOzqvCSJPdPHD+qC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vupvo7AxrupGrdnJRHwgi316g5Uqp24j5MbRJiTb7o=;
 b=rKv7k//nOlQmJze0oeYTFAFqYNsK30VcbYUCHJzkTdBSRVCchdF1OR3wgfWTL9FQr0uFyQPP3Xf+2o64RI4qIrk0qVogOdAmSbEg+r5X8xMWvVnMcpldS7WQl0Sv8AkRynfl9VeRfxPKx8wu7XoFSJno9ZwUAspWYAxIUEu2T3xosocf9//tlrO+U9mMORa8lCwzHZg6lGXy2iQlOaUNQ7Y8m2itWy42oj3RHy11m1Xm+XQmQCKzdC6mU4YlmnyI47sAMoMMvz6Xnh+LEE5DWhgGyT/rD3K6sestN0e0rZ5RajrFq3Onq9jCkQpbpUnUsd60aK4VQXeSnFzANGdNwA==
Received: from CH0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:76::15)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Thu, 12 Jun
 2025 20:13:36 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::fe) by CH0PR04CA0010.outlook.office365.com
 (2603:10b6:610:76::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Thu,
 12 Jun 2025 20:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:13:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:13:19 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:13:12 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 08/14] net: ipv6: ip6mr: Extract a helper out of ip6mr_forward2()
Date: Thu, 12 Jun 2025 22:10:42 +0200
Message-ID: <0bef079626b34bc6531d83d79e0fd5c056ee17da.1749757582.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7d2340-a983-414c-518d-08dda9ed9cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MurzK/K7xG7mm9hNb7DXZ7+ts0wXW9zSr+JZPZzZ8qBy6sDQ6E3R0+t13YFA?=
 =?us-ascii?Q?IK1eYBgL3+KgPA7mXdhvAlWCH2thnm+Q+WRHj0LBd6FmbIXlVe15XrKSLClv?=
 =?us-ascii?Q?6Aluso20Xp+zwjRSUbQz732M/Xr7SVXXI7zcw3SYKzGQOOpgCKOgYnOlqEkg?=
 =?us-ascii?Q?1p8fb5OmHVb5DhBwXi6m7LAFod3REPttTDNV3Z1PmS6lFF9YEbPQIwSccmVc?=
 =?us-ascii?Q?sRtt+NYGe6gComaHe1Mc0tw0hXuVpKOoT+2f/nIf5G34p8fpmwehFdsGiTkv?=
 =?us-ascii?Q?coKqOo4LDDmCcmuaSEczs2JZEiejTWoZjAA5JkGBjaWS+K1ARqT1xDEkEjEg?=
 =?us-ascii?Q?CN6jHfoz5qapTgKUCQhlcZWYNhQKlDvlyEyXcn7RsykaWKliu7AlxLhSpuWo?=
 =?us-ascii?Q?fqUVq834ymErjfzGHRxRLz+Uu994eHtXapoq8j/72SaHz5Ien8HSQ+dEzzPc?=
 =?us-ascii?Q?qeeoxvIInSUmsI3DtKzgO1qiWTX9dBZbNL1Ro5qnjw+hGvfW11zsjabhO6/G?=
 =?us-ascii?Q?48JzlvjabvbdTiLiUA39caya9Ob1yCwNRnw77T2ARPAgbqwN75U9cqqhMdMC?=
 =?us-ascii?Q?XGdeP/IBsivChVQz/q2tYVwx+y4qaAN9k/PJN20NFhItRCFz2d4kW0Qpi85Z?=
 =?us-ascii?Q?7+CTIlqpn2cYuYkNHhw/ZZA7VOKJoKo832Rzo8NjFB7iWHuFWuyxzcK0r8yM?=
 =?us-ascii?Q?4BuLbMqi6bU3/DXLLYzjZROv/Zju4oedYdV7hLshzI/7G5Evdtz9RxbY7V9K?=
 =?us-ascii?Q?uwgpyFCmoTZcQenNyVrzRaXZ5GLLeTUTbaIdWPvoQu0tMN7v0VXtDvKmglOm?=
 =?us-ascii?Q?9kH+0t3pqkhLNRnRKSksLarliz7F0yGSDzu0okEatgCi+T1/aZvSjdlNgLef?=
 =?us-ascii?Q?uuq08+OBlvjE+SJ20J1qBaoJcXVcE+v5PtO+wLJ6l4dR0LxcsyalRCa75xpg?=
 =?us-ascii?Q?8Zut3abUctht4PeeR685XgPBD1FjCymjsOO79M2QYXTBeaKUONcLX19G+UzS?=
 =?us-ascii?Q?DLPkWJtjb+J8JuYZMWlEKCwSYuOrg38QnBA3ZCawPwozNKIPLpJeHEBSOlqB?=
 =?us-ascii?Q?8ZwwcYeqAs/DbJGeusl8YB0kahHc8Ja7hJHMq4PKU1mCxy0mEbJz6WosT4in?=
 =?us-ascii?Q?yZtwjo+qcYuC+B4nTLdeu+fQ6iZ9nwHGCo4fa6e9QAWwPjRFw4tLQdgPAug6?=
 =?us-ascii?Q?j0fkrmlE/XzTPa+ssTbe2WZ3hXegIhqLMORacc54XCSj8tLfnZUEObzUefmu?=
 =?us-ascii?Q?VOq2xqLy3uGfwkmnq9nt88nL7s9CvgOoFU9IpEHN/BMQCsXFFK3HlkFQvlxZ?=
 =?us-ascii?Q?b49hzRUHfC3xnJoGvVISdAdXJCLfUpoxPexKMe7FmjOsEgNdqM0Kyu40wrJH?=
 =?us-ascii?Q?mN9DRe+1GkZdc5yMZMHedFkYgtrBbAET2KJyCpVffg2Bgb+AMUcB9QWKYipd?=
 =?us-ascii?Q?BS/wNwROun6VoVwmBBYveWK78fVUFJ42g3UE71evzgzUwhW3qZTrTO5QWZ41?=
 =?us-ascii?Q?Hq8M47tymkNFa69qz8+aydyfWydqO+nRXduo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:13:35.9065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7d2340-a983-414c-518d-08dda9ed9cdf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436

Some of the work of ip6mr_forward2() is specific to IPMR forwarding, and
should not take place on the output path. In order to allow reuse of the
common parts, extract out of the function a helper,
ip6mr_prepare_forward().

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/ipv6/ip6mr.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 63c90dae6cbf..03bfc0b65175 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2035,11 +2035,10 @@ static inline int ip6mr_forward2_finish(struct net *net, struct sock *sk, struct
  *	Processing handlers for ip6mr_forward
  */
 
-static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
-			  struct sk_buff *skb, int vifi)
+static int ip6mr_prepare_xmit(struct net *net, struct mr_table *mrt,
+			      struct sk_buff *skb, int vifi)
 {
 	struct vif_device *vif = &mrt->vif_table[vifi];
-	struct net_device *indev = skb->dev;
 	struct net_device *vif_dev;
 	struct ipv6hdr *ipv6h;
 	struct dst_entry *dst;
@@ -2098,6 +2097,20 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
 
 	ipv6h = ipv6_hdr(skb);
 	ipv6h->hop_limit--;
+	return 0;
+
+out_free:
+	kfree_skb(skb);
+	return -1;
+}
+
+static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
+			  struct sk_buff *skb, int vifi)
+{
+	struct net_device *indev = skb->dev;
+
+	if (ip6mr_prepare_xmit(net, mrt, skb, vifi))
+		return 0;
 
 	IP6CB(skb)->flags |= IP6SKB_FORWARDED;
 
@@ -2105,9 +2118,6 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
 		       net, NULL, skb, indev, skb->dev,
 		       ip6mr_forward2_finish);
 
-out_free:
-	kfree_skb(skb);
-	return 0;
 }
 
 /* Called with rcu_read_lock() */
-- 
2.49.0


