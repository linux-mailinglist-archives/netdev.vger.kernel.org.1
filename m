Return-Path: <netdev+bounces-195849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A49FAD2812
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1451892FC0
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4E221278;
	Mon,  9 Jun 2025 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3zDYq5q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AE98F40
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502301; cv=fail; b=DuFsTcrqDVZeGsL1kJFEVJwiAfjA/kYaRquCKW1TackBZTabHT2Az8AGeS+NOu6eL5IM3GidvR0rMbXi44ILLgqsIal9lzcan1PC521W9f89mUMdezmEqNFObsAxV/Cw+kuBnU2lyv9NaDbbPRRNbwpTjuhresraAYGKIFqzfqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502301; c=relaxed/simple;
	bh=HAi9nOUpRbG7kpMp+dgtZ0KYNhr7IDPhXci/iWB5KLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FK1Fe/QEVaG7Rnlm1AUxb7qlSGM+tZ4g+qyTfmbruXFcgmfmeWCd4wR0mkkqsvIHjFoi4TCwMq1IdKCKGgP9/SGIdbAc37AwldgCXAW/WmFWEEFQ7AcRt1UETLWflGwFi8FYcfL83rA+Qt1cr25FtPK9lVXFSaWh00bj1BNLvaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3zDYq5q; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGbcCZ/sJ5I5zDorXAtV6BZgCdaST/jwgc3/nnVYyo+xp62MVQiFcsmWPSAyyq9EUYLXdvTzQdICpELEAX+2O9IVLZAYb4oe6rdrLzjqDgjAvkHYoCjWY+wWO8T7V97AyTjn8ZRYWyAFkQWMtcKUvn8bCR/9fJJcCp8IUol86A/N8CO0Ah5wbY4IuHL71AdXn6oqEEaIt7cmyh+s7LpYlvaC0YddjK0O5bTYepLS3wDQCOCbTHF2NPvPw0GW/zZLlzrQJplOfZ7lOd6hv3AROFa9HtzXfxjZW/4BeKKV6gyX6F/dZR9GRnVcLmiJc0A3EbrialnO80gr95IaNP+ZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIA754OUQ2M7+ESSFW8CY5VqnlD0SAnS4R2v1g1K5p4=;
 b=eaijDK5kbfS06uckRFGlSrju6cpW4O499ZK7BURIclo8rQpObnJNve/XfqP5MLxf0oY2sj1W8WTPqxIoEKIR12txTmwGV53Wa2kw7qQemPtB3wZFdvaANpubYlTtPFGCMcs/D9trRFqzyrVRhMvYa3XsTbve+8rv6t0zvw/1GfWM1EpxnEQTnFjM2I6ZkYzUh+SYWkVXnJKbNjIMLymoS6rl6znsIDx/ihnLPmkH3R984yFRZoKSZ1zJNMsSW3vD1f3XhAoWub1W7vDE0qFwjr3w1JuvjBpgIFDmzGfh0OGh9O71DN90tmpC/Ojh9rgstX8gHgyrKPN02JhzzkB16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIA754OUQ2M7+ESSFW8CY5VqnlD0SAnS4R2v1g1K5p4=;
 b=B3zDYq5qcO4wIP2pbTT+YNb5pMfWN+eT+52/2MaR93SAs/QZmD//lzpIL4B5WiDeIi2IZV8ubo4Qwew7M3EDllf+17SyY7ekFE84PMGjKQOW6S1YI6/EjEDh4YknlOZEW+9LCCOj2GOzWs6jPpIazW//JrGBvD9U+BZcsA7avzFuKZz0TpvIY6K9WyZ9fwNWsRepjwHCjAw0fnzbgYdQXASIUPbynNBZ/0if5jzjf989xIDGgGKiiXN5Fw8TMXX3+sG8+drwYIwDoQx68OJRVVhnQFqKFYg9jmvfZO364lzzxeGf9iEzTWSiCHNCJxJJjg1InHvA76csoTv3ubq0KA==
Received: from SN1PR12CA0067.namprd12.prod.outlook.com (2603:10b6:802:20::38)
 by DS0PR12MB7654.namprd12.prod.outlook.com (2603:10b6:8:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 20:51:37 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::35) by SN1PR12CA0067.outlook.office365.com
 (2603:10b6:802:20::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 20:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:51:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:51:23 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:51:18 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 02/14] net: ipv4: ipmr: ipmr_queue_xmit(): Drop local variable `dev'
Date: Mon, 9 Jun 2025 22:50:18 +0200
Message-ID: <1de06ab553e52f9303761764f1ede7e03715a773.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 884f9a69-8465-4491-dadb-08dda7976cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i1++4S7Nrcy+A7L0AV4YWSvH4zCRbrnK68m02lBHp/GJu8CRBYs2rhwKzLEl?=
 =?us-ascii?Q?hvYIEog2iu86zWvS6CrTnmMyyBI+6X06I8FyAMMvqNQYfs5q55f76ftIoQnT?=
 =?us-ascii?Q?Uj7HByPYScSM/woJebS3sI7B+ir4AqrO4sQ8/OdNuVgexpbaE9h+7oAjCntU?=
 =?us-ascii?Q?DZi299qHssNJtTDn+8CN9qB4D+7ZNHH1n6hPPLGLhZZsyGS5rg7J8g6i4rsh?=
 =?us-ascii?Q?WI74JRokK0VRlAq4nqWv2QNSaNhQHQEB/L7mixWGCJ+VrtHcLvoOwLg8F6Ti?=
 =?us-ascii?Q?3A75Dy/wQiibWoIMd5cuGLvwCqbr8xE5ZNZXZjdBdzseJZBG+xhiJGNYAIeh?=
 =?us-ascii?Q?LTCb5jZ8BKXHTdMe+jJz3dLDJ5U66rK5Ozb7XOsnipnpqK7rYgXDTRvyhwVy?=
 =?us-ascii?Q?Z1Rprw+tuzzMEJKHadO05Pzs9EVqVaTPVs3eFLVdletwXLqoOQkMxg9FjsnT?=
 =?us-ascii?Q?OoXT9LfP5cTVX7WWmXtbfy6RFAilETS6nP3PgvyT5Ls+ZxmaKMkTDzbpl+D4?=
 =?us-ascii?Q?/UiNDXmUAS6b3zGazyEZWUs1yjCTULn2r1jYUUL+80fbhveZVchnozONVWAD?=
 =?us-ascii?Q?8D1ce48Zlj/aui4hJz+znUv2mJMwgZkffrHNwxdue7/H6oFLxHnPhy2FP56E?=
 =?us-ascii?Q?1HqicVRReIREUaLFjS2YS+Q2RD2NMRtvSRRc39Ve7WyqxFU47gOB0HgLa9SV?=
 =?us-ascii?Q?opYzKELALYOlY81Jn0Ny6QVLRBWaqrXlpEqWadFF8wracq3+9xPajCkCI6rx?=
 =?us-ascii?Q?tvhHTbR7iYTnSNIkjGxNVEHeBx1wEWiEpoUplFYgnkNcZfoNv7dgSAoloQ06?=
 =?us-ascii?Q?Qs9iTGFKJTuw07p3QIhTNBBfzn1fpquxAz93MyTKlr5OXQ6HVVfk7di7ThDz?=
 =?us-ascii?Q?yVLkrfGHOrSQ10x7sHFmWeiPi2eTyappX5su3DLOgSZ/6hkOtVSdNZGtcQUe?=
 =?us-ascii?Q?qguX1Uh0Tg4dAOF2xHop0LdnPyfRsG+sLaZr2SPRfmmnEMgtb54A4JmdDwPc?=
 =?us-ascii?Q?4DWgyMXon82JQ+eOtamAEWo6ubL4AVcPj/wOyXI7POG0/yV6sxJG5DLT5pvr?=
 =?us-ascii?Q?8Zifujx70gIiTFKyiT7w1tiIOcYxqalnNgdDvQfJ68dwdbUjrryB47N+tPkG?=
 =?us-ascii?Q?ilwzMlHfrrAnak/p+4Y/eDIJLtRRDFz6Y2Yt86RKD3k/h+yYzSYJ8mf/hXIm?=
 =?us-ascii?Q?AwilmVsis+Y8FcX4tEl9WPqSSot+nrUNI8SjVYrQyqnYSz67HfH1BZwhpjlU?=
 =?us-ascii?Q?+VOMkp8RH6wSOAOaiphlzumDH8NSe0dVbgebLhsKXixEhZSqCpbsXs/Ls7fv?=
 =?us-ascii?Q?XcMFyRGKsUSYoqYmkBV2rLagLdG5jHosAPTzlXmnqI59s3wrCR1Ly3LUoFFu?=
 =?us-ascii?Q?zOd/Rov26AlLthpjgxnShRMClioEb+F5/p8R3rKShft9eYa2pJ4Sp/z2uuyd?=
 =?us-ascii?Q?Re5DvP5aQriuVDTFkextO7cCL3a0ulqRT3EleT6X5x2fadluXBTZo8NvLhEZ?=
 =?us-ascii?Q?nXz69gaGgf8IBcPPTy4J4px4TcKF+IDxCOoq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:51:36.4991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 884f9a69-8465-4491-dadb-08dda7976cf5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654

The variable is used for caching of rt->dst.dev. The netdevice referenced
therein does not change during the scope of validity of that local. At the
same time, the local is only used twice, and each of these uses will end up
in a different function in the following patches, further eliminating any
use the local could have had.

Drop the local altogether and inline the uses.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/ipmr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 2ff2f79c7351..1c5e6167cd76 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1859,7 +1859,6 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 	const struct iphdr *iph = ip_hdr(skb);
 	struct vif_device *vif = &mrt->vif_table[vifi];
 	struct net_device *vif_dev;
-	struct net_device *dev;
 	struct rtable *rt;
 	struct flowi4 fl4;
 	int    encap = 0;
@@ -1898,8 +1897,6 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 			goto out_free;
 	}
 
-	dev = rt->dst.dev;
-
 	if (skb->len+encap > dst_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		 * allow to send ICMP, so that packets will disappear
@@ -1910,7 +1907,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 		goto out_free;
 	}
 
-	encap += LL_RESERVED_SPACE(dev) + rt->dst.header_len;
+	encap += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
 
 	if (skb_cow(skb, encap)) {
 		ip_rt_put(rt);
@@ -1947,7 +1944,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 	 * result in receiving multiple packets.
 	 */
 	NF_HOOK(NFPROTO_IPV4, NF_INET_FORWARD,
-		net, NULL, skb, skb->dev, dev,
+		net, NULL, skb, skb->dev, rt->dst.dev,
 		ipmr_forward_finish);
 	return;
 
-- 
2.49.0


