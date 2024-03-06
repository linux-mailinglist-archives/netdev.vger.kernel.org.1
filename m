Return-Path: <netdev+bounces-77905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804808736E6
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9701F22468
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8B12D743;
	Wed,  6 Mar 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rbWD/JwS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431B8665F
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729456; cv=fail; b=ScEwnNya+iUZTyQ9hwzp0FInFWnEO4B9+Mc9URufM3CJWhU/2TY6HvBwpXlYhPEpfkxfzLY7BPplPFzAuEgo3nT0kCTpELvl+Q0SKoprQCYJHPwEobwDtuqMPTxA4OrntjFdGCP22lvQ/gSMfJGxbgQItMqj45AOWQHmemo6+OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729456; c=relaxed/simple;
	bh=Pl9tCdmkaosM7DI6O6UlSVaZgcAAL6Ss0n3KRGiuSlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNlHyz/dmu8u02oPR/Nj4lJRqS5dBxtXmGS5TgJ7jqNBeboOncsiUhkiQu0naL8osN03/Jja8Zb2EvpOmnmvS7sDPyboAIo97x30+G9SzvMyrixDYGhau+tQUN1JhatMvT95AhaUryzYVpuXths4yTDANbFbr0+5JDl6l4Zbuwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rbWD/JwS; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl1ea1STFYK4qpwhXFm6QkJqlUWpUSbRpRlrJJHt61JDUPBQApUSfyAuwUqiWRnL8M2xwJ67DwVXKR4FT+ed50gSbzLFNyH9fNCOlVej8jyKtfaTXAfnwSSaw7GdMJ7SemTGQMq8fsjkfZEaLB0LJ9FU8qwcX9W4c1Y3Cd5gDRN1kzL+O1xrohq37rRGAQzz+odlE0JM+ODt8yYuE0NBP+jaedw1poNYZgJbXRIEYZ5I/+qZYCDVdNwIEibf6kopfjFHqrQhZu92r81J/bPAVGhLWTVGLKUQM3QPtb81L1l4Sz8wuVOc3Zog7/xvjsGhEnaGkFfoxRlIqiCRVoDO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6LnKlRwNe2MUGfiiGO3H4Y9s4ycf4tmRF16GbiTPwA=;
 b=KyH/jxxHvhugntSqT7/ddXREPaacr8cnkiV0cJhbJIULGtFZViefzhMgHySxmVQx9bxuZ8kUbB5LaSthds/cjwzZMRaSdmS5n0kwcAsafzjtWOG+PAiVs0W3WihElAr2CQoJQO12Bak99l5pk2HkHqSwqKpOL0anyWQKfAtiYiNQ/NS1oGaOv5Cnf8vXKzCB1r2hgmzw4Gm5iYKnzlXpVdzNfbaC7npTla+xQLFBW5fSc6rHs77GIDgI2D4NBhKzMPPZxvylI6QRCQHrZolcBA46j2rXXNxZ5cH0m3vXdiwlXxidFVsDU5hKV/iZMFa7mV8saxF6t1Fj4Sr4V8fofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6LnKlRwNe2MUGfiiGO3H4Y9s4ycf4tmRF16GbiTPwA=;
 b=rbWD/JwSVMvZbemZQQTXucZz5MaexWyRFVR5v55PexfPB0aFiWlknVFCEOzy/kI+yZb2KFz036/MQIYE1i637sWuSLN0U2NujkGogEcvB+4rqDvU1GdgKjQ3AFMCRf1Fl76+bKX4exY2c8s2Mqt4qzz1AeYmmjI7bvJCUrEQSzSWONNuSAa2bHqeqNM055c37XhyQJJmUgfbBPt85j83IFpE0Huvj2KwtEwTnCgmYoSvWLI2aMRu1feTk/g27srNx19Jk4RaN6w0tl7C0VGM6VrEHYN5h2EGyCtW/YfmJwDBduKfKiHACRfMYGnQ1QNgI5cqAqd9pZvw9v0riXu53w==
Received: from PR3P251CA0021.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:b5::20)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 12:50:51 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10a6:102:b5:cafe::1f) by PR3P251CA0021.outlook.office365.com
 (2603:10a6:102:b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Wed, 6 Mar 2024 12:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 12:50:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 04:50:23 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 04:50:18 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v4 4/7] net: nexthop: Expose nexthop group stats to user space
Date: Wed, 6 Mar 2024 13:49:18 +0100
Message-ID: <2a2acab9177e68b53c45dde1a28a7436cbc41f5a.1709727981.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709727981.git.petrm@nvidia.com>
References: <cover.1709727981.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 446d682a-d659-4b82-5621-08dc3ddc0be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WbUbeOjWVS/Kid4+8JgYOU1Ntz9gob00GBQtXQTjREHOXxU5EC44MCO+2DQuQfaZaehTQsoweBsEmXS82dl9Jhty89maEUYrAFJ8HCcdU35UmqTS7yxktSEAvZ03s1V0NY/eUReN4nv43m7BsxtrTQNuY0r3hp+A4bwNNl2i98cER24Gj10LejKALFj9S0AdAltnYxezQKw1vnbSTCHmoK2+JY9UtRQ4x4rU521ZfyVCU2ujr1tws1N/YKn2+0HmjzbZwqVDfdDtOyPbeQG+SjieWJvvGO7WcGYxlPj7L0TaGxfeHSF18kqDylmJdT96jx3UFyBzkLCdJzZ80vz9w+A+J5etTkWuyjr9V0jIFckYeWlzyynYa3r8EigJ+ycRdCv9RlEfknjMk/Xpe3sDQ3lYkQnCa8pLiXLGFEhkHHfcw941/0LnXDOBmvU12gLZDWVs8bzcbbxaOyShYZoD9dn7cv2ncEE6lLMi+MEmX5t432uscre6GeuCMdAOnWPr3Xis9KJhPnLdwcW3amhGP7mmM2q3NRTx53k8ewGAu6eX0EBJgGypbJccKgVI4D5TmYr972vB8P/F6nDgpI9yGsckdBhjIIhiemkMqWEJ8wQ2CUb0EX1E+HB9wleXG3JdjTYwn2AfjRmInvr34/rwmxLAhFiHD2z3C7MUn6V51WuA0W36bJdzySSMy9Mj19Smgqv8x5Vt9qLLT2d+jU1tAqAYOPtGtPZkVnRX2fC5uNMIqww+XLyg5RfOFQV35Njx
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:50:47.9778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 446d682a-d659-4b82-5621-08dc3ddc0be1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366

From: Ido Schimmel <idosch@nvidia.com>

Add netlink support for reading NH group stats.

This data is only for statistics of the traffic in the SW datapath. HW
nexthop group statistics will be added in the following patches.

Emission of the stats is keyed to a new op_stats flag to avoid cluttering
the netlink message with stats if the user doesn't need them:
NHA_OP_FLAG_DUMP_STATS.

Co-developed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v3:
    - Give a symbolic name to the set of all valid dump flags
      for the NHA_OP_FLAGS attribute.
    - Convert to u64_stats_t
    
    v2:
    - Use uint to encode NHA_GROUP_STATS_ENTRY_PACKETS
    - Rename jump target in nla_put_nh_group_stats() to avoid
      having to rename further in the patchset.

 include/uapi/linux/nexthop.h | 30 ++++++++++++
 net/ipv4/nexthop.c           | 95 +++++++++++++++++++++++++++++++++---
 2 files changed, 117 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index 086444e2946c..f4db63c17085 100644
--- a/include/uapi/linux/nexthop.h
+++ b/include/uapi/linux/nexthop.h
@@ -30,6 +30,8 @@ enum {
 
 #define NEXTHOP_GRP_TYPE_MAX (__NEXTHOP_GRP_TYPE_MAX - 1)
 
+#define NHA_OP_FLAG_DUMP_STATS		BIT(0)
+
 enum {
 	NHA_UNSPEC,
 	NHA_ID,		/* u32; id for nexthop. id == 0 means auto-assign */
@@ -63,6 +65,9 @@ enum {
 	/* u32; operation-specific flags */
 	NHA_OP_FLAGS,
 
+	/* nested; nexthop group stats */
+	NHA_GROUP_STATS,
+
 	__NHA_MAX,
 };
 
@@ -104,4 +109,29 @@ enum {
 
 #define NHA_RES_BUCKET_MAX	(__NHA_RES_BUCKET_MAX - 1)
 
+enum {
+	NHA_GROUP_STATS_UNSPEC,
+
+	/* nested; nexthop group entry stats */
+	NHA_GROUP_STATS_ENTRY,
+
+	__NHA_GROUP_STATS_MAX,
+};
+
+#define NHA_GROUP_STATS_MAX	(__NHA_GROUP_STATS_MAX - 1)
+
+enum {
+	NHA_GROUP_STATS_ENTRY_UNSPEC,
+
+	/* u32; nexthop id of the nexthop group entry */
+	NHA_GROUP_STATS_ENTRY_ID,
+
+	/* uint; number of packets forwarded via the nexthop group entry */
+	NHA_GROUP_STATS_ENTRY_PACKETS,
+
+	__NHA_GROUP_STATS_ENTRY_MAX,
+};
+
+#define NHA_GROUP_STATS_ENTRY_MAX	(__NHA_GROUP_STATS_ENTRY_MAX - 1)
+
 #endif
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 92dc21a231f8..3365c41eee9a 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -26,6 +26,8 @@ static void remove_nexthop(struct net *net, struct nexthop *nh,
 #define NH_DEV_HASHBITS  8
 #define NH_DEV_HASHSIZE (1U << NH_DEV_HASHBITS)
 
+#define NHA_OP_FLAGS_DUMP_ALL (NHA_OP_FLAG_DUMP_STATS)
+
 static const struct nla_policy rtm_nh_policy_new[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
 	[NHA_GROUP]		= { .type = NLA_BINARY },
@@ -41,7 +43,8 @@ static const struct nla_policy rtm_nh_policy_new[] = {
 
 static const struct nla_policy rtm_nh_policy_get[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
-	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32, 0),
+	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
+						  NHA_OP_FLAGS_DUMP_ALL),
 };
 
 static const struct nla_policy rtm_nh_policy_del[] = {
@@ -53,7 +56,8 @@ static const struct nla_policy rtm_nh_policy_dump[] = {
 	[NHA_GROUPS]		= { .type = NLA_FLAG },
 	[NHA_MASTER]		= { .type = NLA_U32 },
 	[NHA_FDB]		= { .type = NLA_FLAG },
-	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32, 0),
+	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
+						  NHA_OP_FLAGS_DUMP_ALL),
 };
 
 static const struct nla_policy rtm_nh_res_policy_new[] = {
@@ -671,8 +675,78 @@ static void nh_grp_entry_stats_inc(struct nh_grp_entry *nhge)
 	u64_stats_update_end(&cpu_stats->syncp);
 }
 
-static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
+static void nh_grp_entry_stats_read(struct nh_grp_entry *nhge,
+				    u64 *ret_packets)
 {
+	int i;
+
+	*ret_packets = 0;
+
+	for_each_possible_cpu(i) {
+		struct nh_grp_entry_stats *cpu_stats;
+		unsigned int start;
+		u64 packets;
+
+		cpu_stats = per_cpu_ptr(nhge->stats, i);
+		do {
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
+			packets = u64_stats_read(&cpu_stats->packets);
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
+
+		*ret_packets += packets;
+	}
+}
+
+static int nla_put_nh_group_stats_entry(struct sk_buff *skb,
+					struct nh_grp_entry *nhge)
+{
+	struct nlattr *nest;
+	u64 packets;
+
+	nh_grp_entry_stats_read(nhge, &packets);
+
+	nest = nla_nest_start(skb, NHA_GROUP_STATS_ENTRY);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(skb, NHA_GROUP_STATS_ENTRY_ID, nhge->nh->id) ||
+	    nla_put_uint(skb, NHA_GROUP_STATS_ENTRY_PACKETS, packets))
+		goto nla_put_failure;
+
+	nla_nest_end(skb, nest);
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(skb, nest);
+	return -EMSGSIZE;
+}
+
+static int nla_put_nh_group_stats(struct sk_buff *skb, struct nexthop *nh)
+{
+	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
+	struct nlattr *nest;
+	int i;
+
+	nest = nla_nest_start(skb, NHA_GROUP_STATS);
+	if (!nest)
+		return -EMSGSIZE;
+
+	for (i = 0; i < nhg->num_nh; i++)
+		if (nla_put_nh_group_stats_entry(skb, &nhg->nh_entries[i]))
+			goto cancel_out;
+
+	nla_nest_end(skb, nest);
+	return 0;
+
+cancel_out:
+	nla_nest_cancel(skb, nest);
+	return -EMSGSIZE;
+}
+
+static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
+			    u32 op_flags)
+{
+	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
 	struct nexthop_grp *p;
 	size_t len = nhg->num_nh * sizeof(*p);
 	struct nlattr *nla;
@@ -701,6 +775,10 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
 	if (nhg->resilient && nla_put_nh_group_res(skb, nhg))
 		goto nla_put_failure;
 
+	if (op_flags & NHA_OP_FLAG_DUMP_STATS &&
+	    nla_put_nh_group_stats(skb, nh))
+		goto nla_put_failure;
+
 	return 0;
 
 nla_put_failure:
@@ -708,7 +786,8 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
 }
 
 static int nh_fill_node(struct sk_buff *skb, struct nexthop *nh,
-			int event, u32 portid, u32 seq, unsigned int nlflags)
+			int event, u32 portid, u32 seq, unsigned int nlflags,
+			u32 op_flags)
 {
 	struct fib6_nh *fib6_nh;
 	struct fib_nh *fib_nh;
@@ -735,7 +814,7 @@ static int nh_fill_node(struct sk_buff *skb, struct nexthop *nh,
 
 		if (nhg->fdb_nh && nla_put_flag(skb, NHA_FDB))
 			goto nla_put_failure;
-		if (nla_put_nh_group(skb, nhg))
+		if (nla_put_nh_group(skb, nh, op_flags))
 			goto nla_put_failure;
 		goto out;
 	}
@@ -866,7 +945,7 @@ static void nexthop_notify(int event, struct nexthop *nh, struct nl_info *info)
 	if (!skb)
 		goto errout;
 
-	err = nh_fill_node(skb, nh, event, info->portid, seq, nlflags);
+	err = nh_fill_node(skb, nh, event, info->portid, seq, nlflags, 0);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in nh_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -3095,7 +3174,7 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		goto errout_free;
 
 	err = nh_fill_node(skb, nh, RTM_NEWNEXTHOP, NETLINK_CB(in_skb).portid,
-			   nlh->nlmsg_seq, 0);
+			   nlh->nlmsg_seq, 0, op_flags);
 	if (err < 0) {
 		WARN_ON(err == -EMSGSIZE);
 		goto errout_free;
@@ -3265,7 +3344,7 @@ static int rtm_dump_nexthop_cb(struct sk_buff *skb, struct netlink_callback *cb,
 
 	return nh_fill_node(skb, nh, RTM_NEWNEXTHOP,
 			    NETLINK_CB(cb->skb).portid,
-			    cb->nlh->nlmsg_seq, NLM_F_MULTI);
+			    cb->nlh->nlmsg_seq, NLM_F_MULTI, filter->op_flags);
 }
 
 /* rtnl */
-- 
2.43.0


