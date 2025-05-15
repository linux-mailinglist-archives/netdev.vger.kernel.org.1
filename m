Return-Path: <netdev+bounces-190650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE1CAB8167
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2914E1886D34
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3068629372A;
	Thu, 15 May 2025 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IXPstFGX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727A828DEEF
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298996; cv=fail; b=XqTZs2IPwTTzRt9e+zucepp26gxLGvx1sjPO9QLfDYEW/CduTOoLJ9Y8ZH7khaxd7DGd3MPw71bHmMtBsw6ivHZqgCx/8XQ6sDMHeLOYChPmcd9xwlJYnz/ByIGMk7oemIWcOm5T1ut2c1dYGfNs4fANfB1k3TWsgob7eED6r94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298996; c=relaxed/simple;
	bh=+K4vtlC7daQi+XfXiTfr6iWX7Tk9pmPLtZBLHCDgihA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZZRNv1forPERW7ojJs6uusY7BWCH6DDSOI3/B423MWVCODDTjPCfXL4gWdQXRHsQjWflsc93kk1Jp78Hw5R5pk8ZnZlp+sg/iJCyAe9rKXbPDjGSn76yFdHL+BvQTrj07kiUFsn3j9z1dsMXrRqM3FCb5PpVpaMw5lufJ++s2q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IXPstFGX; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPJP+3LG6c24bEWyBSXvRhxhPH2bWv2vZLo4FiuqrBAMCrkYzwof+nOTABA4vt04egcjMUBjybvZtA6oTsSEoJYyLPx3p7snwDoKqGGWI39Cafc2BDfv3iFxzIZ2ef7BXSrqzFF/NGZhSQKutTRnSTbjoNZigKIBqvg7T5/F9ZXs2ymnWkzU4IASTHLdt6zQmPIRFL5unvZSqZ5ZPvTCJFlSB1HotxesRU5J92KggzWqUo5nPibJ4ShHBe4Kdv94AviY2GFcEWjQADs9+zNqcpCTkl0DmhC2VItFQoLGxXQ/QRyTOSd2kDrbriaCcgxfIG3cg751NZOje+ZDrYYEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqEMQLGxKwqbuc+TMyMzS32Fe0EvxpTDbXlt0cA1gNE=;
 b=KXs2phMPq0mLbqygu/8b3/W2WimcO+554wJWX+N0Mal9nVCwcwP9v85cycmVSr3Wuf1iEeA9coz6Bc2neyJmEmh3coAPX1r4smFqVQWEmm0FyEuGPFdBEpLW5FcVK1SMCvBXAO6HlREjQLPpmllGeDktHviQPucMdOV35m428/Qf+lOUo/VtYYe7m26mcT3yxuGyeX2oFM2CCrh/AlgKtX5/vzX1J2fubwB5jzpUy45h/pe+ibzM12oogj7v+Fssa52fbGfeL5v8ozJoJlk/x3xnu6M1zssaIH28/zIvlkWwLinkr6kXLSlzxImE8P3o6l2G7TTEzGr3SH8E5BW/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqEMQLGxKwqbuc+TMyMzS32Fe0EvxpTDbXlt0cA1gNE=;
 b=IXPstFGXL9vWXiN3i8cprTvPY15WodWW6sNpqaXyEpeL99+0pQX6k0k0E+pISPZQ+9EO1gvMRlZ23UvLY51p+K7FlRY3G2fFfiMciwFv3O5mMaHeKAlZfQR6usMP4WGyaf1Gm68MBB66QUhuJrBj+/dhmuEYr4IDkEYGq/wcO3Bphr70pYoJGDC5YEl7tHCmsLelCwXHzxjzTXfUY7S3ub5mttwvrR5R7TXQ8WDrwSJlPvzg0IIoNps7993trkp9682yfctr74+PKduof/18dpuEcfvcZG75i1ZNspOQj1xFlPoTvosSGRi8t7zmirlYmHk5opYfIIBSfrh0iolWuw==
Received: from PH8PR20CA0001.namprd20.prod.outlook.com (2603:10b6:510:23c::15)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 08:49:49 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::6a) by PH8PR20CA0001.outlook.office365.com
 (2603:10b6:510:23c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Thu,
 15 May 2025 08:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 08:49:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 May
 2025 01:49:31 -0700
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 15 May
 2025 01:49:26 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux.dev>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>,
	<venkat.x.venkatsubra@oracle.com>, <horms@kernel.org>, <pablo@netfilter.org>,
	<fw@strlen.de>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] bridge: netfilter: Fix forwarding of fragmented packets
Date: Thu, 15 May 2025 11:48:48 +0300
Message-ID: <20250515084848.727706-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: db2cd62d-f8f7-4a23-df30-08dd938d72fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t+RczYOlvVkvW5w404u8ceZv+0Be9rp+/QOkyh6u98G9xYPTXHM+y+CEHAk7?=
 =?us-ascii?Q?Yg0OG63sQleYHBgxdNp1XngLgLCNR+ULGOVespV7c+vxRxQCosCr2FixVGfe?=
 =?us-ascii?Q?pz/FV1h3GHRKtJareTDLs5FH6y8MfXRJ6CpRVEVnSnDYmvsbPL68KWXjN/Dg?=
 =?us-ascii?Q?9N9s1kMDimUAid/t+ww6+6JcEyBlsaX3M097kFsAYq77aIK+rve+jBO2DWCf?=
 =?us-ascii?Q?9OUqSb5GY8nekG0tAM3egtD0tXtyAROfUxqTPwumHArhXKytVz3B4Bh2VIRu?=
 =?us-ascii?Q?sKFHmIku8T/pGLtglf9hn1cE5su+VDNWjKRfkGBUrj6GYK13XUw4MLCGpUBl?=
 =?us-ascii?Q?FjJAzN+e1+nUMq22QizFdBsOKa79wcd8sl7sDnSbJucYW6m/nszWPy3I4lCd?=
 =?us-ascii?Q?eTC5EfR/NYIo7KFsgujITa57LosZGRefo6N6QEKQNWzVQMeriJf7au8NmeJS?=
 =?us-ascii?Q?jtt1klDIsI8MuoQL1ueb72yjgLL/zVWVsD/4veYWTPi0i3lBQi5oL3MReTQO?=
 =?us-ascii?Q?LFkA4oH7DQK5jVFJccuICIFkGHlh2sUtW12YNvQD02GHXfn/VWoy8pAlNxXw?=
 =?us-ascii?Q?88YwT8Jy+j0moTW/UyCjC6f3nrLCn1jbrC+OCL93msBsSxcEmWA/l2G1rqRK?=
 =?us-ascii?Q?h9QseyXC8gBRUPqfjigMWPiP0yonmWTIuykn4jg1nTBheW9l52h7EE0DwKhu?=
 =?us-ascii?Q?WBy/QtYMLt79vKr2QOpucwXuT/q92ZtwDbaR+thqnak8AQOfvdeLO0gXRBUw?=
 =?us-ascii?Q?vYOQTjU0D47gzFVwRWwfx4BMlA48q0JlCDzfaLAQIZqyDNgtLDjFyPtr6eKU?=
 =?us-ascii?Q?erxl1zxVJyvItfnEgaXz9k+Tb2q5+79P55B4M4aOVql5yPnxbrpLELNIEkgw?=
 =?us-ascii?Q?9JvrqNwr3Nk9zQs0FHwqh8xpgEUBxNH8xmta4DBIyY1LnVhy/j5qdMuQMP0v?=
 =?us-ascii?Q?GS/pxQ6xXrCbHq3KMudGUYr9J0ePydvMamfqpfBvClY4Jk4KzH+Xulwzrz/m?=
 =?us-ascii?Q?jHHTshJ39OGln3T75yWYSfe7CN8pf9+EsXSR4U+V5u5gK4GFj3tSY6ZGPajR?=
 =?us-ascii?Q?4V7bKT2+3uamQZexdnLtQDbOMMZs5q3DgEhGisL4B4apIkb8gUw4F9C5S8Cs?=
 =?us-ascii?Q?x1IHnrFCLPY4rMWDM/2b5w12Mqu5DPGd431HRWC9vg8I9b8U2hORZHa1cWcy?=
 =?us-ascii?Q?3fRxmJrC7UTxyALaij58yMm+vU40hCBCHqXRAAWyQ2kuVH9ssEZpt0cGKxe0?=
 =?us-ascii?Q?TNj303Qq0gXGXrz+n2QIVKMmtTnSSEdEOocfZeK5SBEssAYn08AE7phcL8mb?=
 =?us-ascii?Q?/z/JAoOZeyE41ObqqAllaS32GripuLmMfx3RXjAd/cGJ0ga9QdjJLJr52Afs?=
 =?us-ascii?Q?qKvZdGwVyrPJ55H7LP0kvtI8t46n4S6XQus1csh1hFu8w0LRVyYOh5AlNO66?=
 =?us-ascii?Q?bb3w6fxcpX8g3quaHAmUjlau42e9D1DsUJVvO2EC85vXcZPNjM7xvtM2LPxh?=
 =?us-ascii?Q?aPOvBHJ2Af9NhiZ8fGVx91/LmtzQ8SIEo3dz8cVW4OgcHu9HwMZwmSTuvg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 08:49:48.3962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db2cd62d-f8f7-4a23-df30-08dd938d72fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486

When netfilter defrag hooks are loaded (due to the presence of conntrack
rules, for example), fragmented packets entering the bridge will be
defragged by the bridge's pre-routing hook (br_nf_pre_routing() ->
ipv4_conntrack_defrag()).

Later on, in the bridge's post-routing hook, the defragged packet will
be fragmented again. If the size of the largest fragment is larger than
what the kernel has determined as the destination MTU (using
ip_skb_dst_mtu()), the defragged packet will be dropped.

Before commit ac6627a28dbf ("net: ipv4: Consolidate ipv4_mtu and
ip_dst_mtu_maybe_forward"), ip_skb_dst_mtu() would return dst_mtu() as
the destination MTU. Assuming the dst entry attached to the packet is
the bridge's fake rtable one, this would simply be the bridge's MTU (see
fake_mtu()).

However, after above mentioned commit, ip_skb_dst_mtu() ends up
returning the route's MTU stored in the dst entry's metrics. Ideally, in
case the dst entry is the bridge's fake rtable one, this should be the
bridge's MTU as the bridge takes care of updating this metric when its
MTU changes (see br_change_mtu()).

Unfortunately, the last operation is a no-op given the metrics attached
to the fake rtable entry are marked as read-only. Therefore,
ip_skb_dst_mtu() ends up returning 1500 (the initial MTU value) and
defragged packets are dropped during fragmentation when dealing with
large fragments and high MTU (e.g., 9k).

Fix by moving the fake rtable entry's metrics to be per-bridge (in a
similar fashion to the fake rtable entry itself) and marking them as
writable, thereby allowing MTU changes to be reflected.

Fixes: 62fa8a846d7d ("net: Implement read-only protection and COW'ing of metrics.")
Fixes: 33eb9873a283 ("bridge: initialize fake_rtable metrics")
Reported-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Closes: https://lore.kernel.org/netdev/PH0PR10MB4504888284FF4CBA648197D0ACB82@PH0PR10MB4504.namprd10.prod.outlook.com/
Tested-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_nf_core.c | 7 ++-----
 net/bridge/br_private.h | 1 +
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_nf_core.c b/net/bridge/br_nf_core.c
index 98aea5485aae..a8c67035e23c 100644
--- a/net/bridge/br_nf_core.c
+++ b/net/bridge/br_nf_core.c
@@ -65,17 +65,14 @@ static struct dst_ops fake_dst_ops = {
  * ipt_REJECT needs it.  Future netfilter modules might
  * require us to fill additional fields.
  */
-static const u32 br_dst_default_metrics[RTAX_MAX] = {
-	[RTAX_MTU - 1] = 1500,
-};
-
 void br_netfilter_rtable_init(struct net_bridge *br)
 {
 	struct rtable *rt = &br->fake_rtable;
 
 	rcuref_init(&rt->dst.__rcuref, 1);
 	rt->dst.dev = br->dev;
-	dst_init_metrics(&rt->dst, br_dst_default_metrics, true);
+	dst_init_metrics(&rt->dst, br->metrics, false);
+	dst_metric_set(&rt->dst, RTAX_MTU, br->dev->mtu);
 	rt->dst.flags	= DST_NOXFRM | DST_FAKE_RTABLE;
 	rt->dst.ops = &fake_dst_ops;
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d5b3c5936a79..4715a8d6dc32 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -505,6 +505,7 @@ struct net_bridge {
 		struct rtable		fake_rtable;
 		struct rt6_info		fake_rt6_info;
 	};
+	u32				metrics[RTAX_MAX];
 #endif
 	u16				group_fwd_mask;
 	u16				group_fwd_mask_required;
-- 
2.49.0


