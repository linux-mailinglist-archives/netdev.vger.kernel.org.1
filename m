Return-Path: <netdev+bounces-197190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D108AD7C29
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E861D1886746
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0004B2D8776;
	Thu, 12 Jun 2025 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E0ebKv0u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0E2D6634
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759178; cv=fail; b=n6K2SnaHQSc4eto+zG/mQ7Uku/S/VdGk57W+TUKrVxgbwDlDt++U2fjAFESMIyZrA6wQd9fq2Jb1VrlpG5ubpW53E9p0y7F4jCjjOQLRevySNj8bWueqAl6a3AxyUzs+U65N4o/8URI4JnOdUpRx4oSiTwKsG9A0jqPd+vQ2klU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759178; c=relaxed/simple;
	bh=+5HoSsD8Woe4oXmdSPlmRnj4PS1m/DFdh/7fgcCIMBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PremJO1uEDSpHy4wbANV+n/8kil6UvHwa0Ac1jZ+Jdagezbm7tZtylG4NBjFvjOH1TdqM0F6SVMLrgdOfZx+28urdj0o8UOPw01eKSxSq3d9z9AUAKQgEWYF8wl/HsPjMpJRfvRJuGOd8Jqq3GfRloLhlyBJqjXNEzVbnvDGoMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E0ebKv0u; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCaiKQA5id0IlGJ+I+V86a8B5DzZvqYBo1SHxxAHrdHapFRFPJwdQhVi59E+13yV4Ij9w5B5ceHyj4PKCjpN8dUfnUiIx6y1WQRwDCt4HVXmniM5NeY4EuOOUJ0WZj+OJqrtLgbi8cFzCWx2jtassaovt6V0/xH5AySfzHsmqec/McbpYSnCd8OnSFPJiGKxIyNID64cT3cg8wwA8XnwaOZiETJPRepvIC8zvC2i9siLVbA7fZPJxtyCEVQPjDJxxLtuoIDGqePsAFCLF3r1LlfIFuiBALGTr66fzEzIc/ruBONw9ximW67rUsH3npBLaGJ5jmfFKJXLoC3MZMRCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfEZDoJr5CSckLwc8m5eyv/tuphKHxnXg3EHVEr69wI=;
 b=n+Y1YetQV2tDRnXXBEzUoKw5spmIj5JglbrIUfkXEPblhrowgozXpeUwSXcQlm/LMFCWfRutLyQFEtH5i+1xXURqKmrcrozabn7QcJNxwN2kU3vh48sk237y5KlWBN4Np+nNgqPi9STy8TVEhjvdxJdJlbRtol3w2AwSYgPjw43pao5+jCAoF6dFhNa+GN+N4+1D3avxX5ql+wHP09MDDZzyvQw1RXx89fWvsdlpxdjcfQYL0yaArGahhjKvd5E0PvmFA5vvHN7kWObWxDVEqoBUE46RRrCb4KQFuXrqu0shSAtJPNQXK6j5NWT84RwgU5+3IH1/UKoZhaycqHi4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfEZDoJr5CSckLwc8m5eyv/tuphKHxnXg3EHVEr69wI=;
 b=E0ebKv0uG/HfoZXR0pUrwQxmXb2datMxCYOaNqfadhsLxkS7n2WTNWkF/hM0QKq5MSmS9C/AMTwBSvCMKZnCFQedVJqfMhSWZXey9VNVETeKevr1jUs/f9Q3MAumS+CViiyrfLabgbbCx28FR6gKDH3oJs9CvCJrCMgxpDFi90ccpkPsjXId24vDC7/xzsYjaqIXf1bGnuWHstzSuS7g7hq9cbbiB9Xi6QEbhBN8G6mcL0p1sVJL24Cm6qRgp/UYQcqhAFkpmZ9kRjOTyUH1Z4+wzin1TpjuDkbCYMz8XxsFnzamGcz3sm2JPZMmT/FYdVNU5vGu5ZMxcxxP3PoQlw==
Received: from CH0PR03CA0229.namprd03.prod.outlook.com (2603:10b6:610:e7::24)
 by IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Thu, 12 Jun
 2025 20:12:54 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::7b) by CH0PR03CA0229.outlook.office365.com
 (2603:10b6:610:e7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 12 Jun 2025 20:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 20:12:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 13:12:41 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 13:12:35 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v2 02/14] net: ipv4: ipmr: ipmr_queue_xmit(): Drop local variable `dev'
Date: Thu, 12 Jun 2025 22:10:36 +0200
Message-ID: <0fdb8e4ecc240a789b23dc73cc8bcab19e1dd155.1749757582.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: c19ea92f-a9f0-4e92-1141-08dda9ed836c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sHdNIGjSEJC9U4M1iz+Nun476qPDZ7smbzpoQoaNEngeRG/IReWtlff0JhR9?=
 =?us-ascii?Q?D+kyJXTeCBiDxFrBEC3MoxfVX4IhylFpS7ziOJRkKdJqkU34ZcWRwfIhkQx/?=
 =?us-ascii?Q?gVXfcBsYInLCdqj3T22kf8dNrnUfQNHvlDpLPOwkhy1Q5yeVipTpYvKUihNq?=
 =?us-ascii?Q?y1gGWYv4pNwVAgZmwRhL+a5gT+XrOiU77NQkp+79RXdv3UyzofK3Ei7z3gUD?=
 =?us-ascii?Q?DPXeYuufygrpHTioycEUuLr6Cwvlmma3g8WP3qXk4wdeq8MsDXNoKDSYDeY2?=
 =?us-ascii?Q?SNLIAH1s5Z80oz31Dvm/vHolSPmAIpcYF9ZzNTk5PpRqYkN/BRJCd1W/P8UU?=
 =?us-ascii?Q?3kQ5p3f184VGNVoFcK3HiN2paYJxEltpwcqOzekqFYWNJVKCqZFYBpBGo3Gm?=
 =?us-ascii?Q?onTxd3GGLIbQgOG15EEmbPgu8tqVtEjBJyXXGnMULNEWfx2idWdB//bjkHmH?=
 =?us-ascii?Q?nm3a4NTUBNESgjzNTHzGM0xhsyRo8JgDREt5hLzQ/RFMrzKRpfp7rud3eJTk?=
 =?us-ascii?Q?MAs3xvs8jtjVKledkigBbpMg1Trv6w6Jg2/R+xng4XGuoNIleFyi+yNQxQJO?=
 =?us-ascii?Q?o+1OzsONNXnGItbyVuXg0XfRIrJVIOZ3voilwcYBQPa3uu1uADsET5Y+Va/Z?=
 =?us-ascii?Q?5h9108eKt0pSqe7vCM6nE+vtRLyJpmnN6MMQigdfk1J265G4ts6EcBdTMpRL?=
 =?us-ascii?Q?5GwU3H/rvmriV6HQysWdoKngGA8c1YkiMsNlVUAjZgFhBXlyp1S3Z5AH6Siy?=
 =?us-ascii?Q?m/q8EiGw5k8DIYHeoZhCUIz8lsSv2o/gH4vMAdsJMdX6xDpnj3gVN0tzf1hZ?=
 =?us-ascii?Q?aMd1oeyJ5hcuiTRvuKq6JTD4UvRiWjaFDIyP2EVgG/atZgScgxEp/vJRqxy/?=
 =?us-ascii?Q?VEcdJZtz0Sek8lue76GOhVFv02sIkZVmuLIiHUucdIaN782vG3+bQZmJWNbl?=
 =?us-ascii?Q?oNlhykRHZrPOFdPfLAHrOKT5+Snfc3b8pf5YOkmrUnbPWWH9smNnmwrjranB?=
 =?us-ascii?Q?dtCBOpzPA6zje3Nq29nn+VwHKpEDc2wgCFj86GHh18wCHZ20PqYdhu5yXmhx?=
 =?us-ascii?Q?jQTeI8z/PZoIVsq0uuG/Jw65+XBBAg+Ma/Lldlp844oruK2EIMN22R/ItXEl?=
 =?us-ascii?Q?ISFiset9V/OscCcYNfF56JXhMQaTXkpZlQNgc3DKAHQJC/Cm3Ux3UMLyzUOv?=
 =?us-ascii?Q?Fr3F7lxyURvDoEd1nAqey4wyuFztz+9yNA+ot9SKh78KqgBWv0ozcAVdmZBn?=
 =?us-ascii?Q?FfKoHtjwodDXCfed7L5ZAKmbza+S9E6d//JuMS8btXI7enIwTakphKjk3NrV?=
 =?us-ascii?Q?w6cW91xSrmOXTc2OhooBY0pT/xaamNDDv8UViof1oS1l+63s0Vy+egAc5MAM?=
 =?us-ascii?Q?gxOer/8EaSQvdfrd0See9KNzjQj5FrQEqDiPMZAgWHBSghDVmRDbL3aGDzGD?=
 =?us-ascii?Q?GcEUd8nlr98ovIkrc2+jF1TdZX79mo+rG8yAq0E+7Tr6Je813qsdamUl726H?=
 =?us-ascii?Q?2TNbfBgHHvQ3dgl5rxP7Cj6TQri4hpYTPmaw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 20:12:53.2221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19ea92f-a9f0-4e92-1141-08dda9ed836c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162

The variable is used for caching of rt->dst.dev. The netdevice referenced
therein does not change during the scope of validity of that local. At the
same time, the local is only used twice, and each of these uses will end up
in a different function in the following patches, further eliminating any
use the local could have had.

Drop the local altogether and inline the uses.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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


