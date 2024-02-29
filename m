Return-Path: <netdev+bounces-76280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A3886D1EC
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E96283FDB
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD977827A;
	Thu, 29 Feb 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aG1O2e+j"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3578270
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230829; cv=fail; b=DCFLDzbZ4uzwih6igkP1rKEiT4Xz03zEJH7pXSTZ3AszLI58fePZ7N408EDQS9AzZwg9uKSCbccKJtbio2FavUOM8fwRRr4EIYiglZe0g5thh86wAJ5N/uHwK0HbG2JrsSf4ev6HOfHTdhI5vw59scJbsnAfUFAvbukzy4Rn5pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230829; c=relaxed/simple;
	bh=4DAxoF8ABk9xzPv7cODQo3rqilaw/7vkjaRAlRpRTGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPoRW6TBMZfvw1gK/K7Jae4bseqafS2Rj+YUsaeyyCtZZ5jqdmTjWq6Fmc4eQjA5LAylqUK0R2nSgaZBB/fq1INV+hFgRPum+F+D6wQdVmCyLMSyioiRu7iKE85eX+G8M3kJAkqZEIbtyPrxzAf3Opio2/+mxxGyDb3MeoaVh/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aG1O2e+j; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgdgYEkCrSLe64/EtNYWNvSr6y6YRE6lrg+/HDdtRP8F2W1m/sNZ6ZgH+ziQNjUXRbKPG4GTWZnakvh+Ia34kBiatJz6ZmWOG4FC/fkLOkbGAiJ14yemxfzccggAeUaRkRnOmn8gAVXE5jY9hAWUgm2CP1LtNFX7NYeNbdjF9scuB7aBnHf0y+IFfMaz1cyfCRwwF0qyWsrwawvt6kj/7AcrS+PK6tyS/gQSDClvjNKbZ1J5JbRqH5UiSk/BmjmPpj9+dOc3O/hkkZRsNIEq4RmiiSHFX6gpO3aTt8CwQXMsCdZQ1Q/2pBgwHuiG3qjalCuYsek74W4dFWNUMphCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+TrQKGJqcEn3M9zo24X7IfHkt6aMgOZZeWjS79qX7U=;
 b=KSTarh6dtqUip/mqChO2ZicjwT9KRlXHO0VO+e1vklsOFjCe8oERGF7ZEMiUuIA2eNGUBViYbQaMILtmHw1yaPsDCaxihC49ebE5bfFFcsqE+fBPxUhZrNGXutLko9vMx+gIl6GZr2Gr2cdaJACIL20gLkTPz5qP6T3FAFrWudUGGkn+UAQCWr9ijDX42F43inj5It5lpkkm1HiNv02djKh9ulwzWF5P+Fa0/C5HSgnvYfrzj5C6F+qCozKdAGsiheowqc+kG1QcPXFzrBjQyTCPtZTaLEjstFTEuVhFARfLI+c9oo0pe30FDzrqLdCtg3kwaipZAS7tIUKRPlM1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+TrQKGJqcEn3M9zo24X7IfHkt6aMgOZZeWjS79qX7U=;
 b=aG1O2e+jSvJB4IkY8JH8ox1qEuZZdYYNEvwZQnLOMXFdkg0oM4a6odsKJsDxvbVHhEK3/JpfgZCAc9Q3tOJtsdIXVqF0JyclhHRQ3z097oULyJp9+Cvx5FEzQRJX+ZgrcLGZen2OU0wucatnePeoMqMfjbZFTsGes+oyGFQ/pCre/nZnFq19Clg58QA0r7Km+LtHx+rNaexomNff7waHiG9XCdhv9k8FBXSvyGAUYv85QyTlIaG5IUG5bkW6KyMXFotoLEhpHK7RTwsstx8uIEdgkIZAriUlyInuR6d6GMt7Pm7ub7YOr5LGLRXecs+MKcBybUh5qF3hnzyimkXEcQ==
Received: from MW4PR03CA0351.namprd03.prod.outlook.com (2603:10b6:303:dc::26)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 18:20:22 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::28) by MW4PR03CA0351.outlook.office365.com
 (2603:10b6:303:dc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Thu, 29 Feb 2024 18:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 18:20:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 10:20:05 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 29 Feb
 2024 10:20:00 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 4/7] net: nexthop: Expose nexthop group stats to user space
Date: Thu, 29 Feb 2024 19:16:37 +0100
Message-ID: <223614cb8fbe91c6050794762becdd9a3c3b689a.1709217658.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709217658.git.petrm@nvidia.com>
References: <cover.1709217658.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1b3c89-5b5e-4b08-7f3b-08dc395317c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BFDkAt0XarG7bu/3ukxZC7irZ1h2GCYFsQTAZrMe0wjyxhr1fuBZRnMRbvn8pJN2BlfIazP8qtk3sFPVlKWmjlolfGUea/cfkNIflkuyU6XFvn4Ah0LLusydBjSdBtEN3f0DX+XcCtgQgNZ2sIFqXkLRDjMsQ0T24sA4wU8KMGSeB+z2gt4fMaWWnAps5DKCOBVJt3OARiaeruPXpQsN7m50j/wqUD8iZJlobiXN1tg4zNUSWqQo9dWMchJK9poMF9jU1xqjBXFGKB6ziqmjqGEn/ZyL5FwsLa42vV7GdeSDvcxBretMAYFw3pv44hodEEw4nwiDGyfgR7+7sfOXc7mQAxS6iDLPz5oEDO+0ukgZXAkFWnbUowLG25o/Cnv+q7GLWPUEGw25GCzbs3YqU86LQcrcd736qL/Jf9YcRA6vn8GRcKLBVs8otK64QBEHNrXO5eF5A4PZMbSer4sW7+iPdcEMddramb/zZzXe7npn+Uw/G+Mu6guIIk8xbG7lhT7MTY9e9lwUqyLywRBf6UGeH7AztolLz3ZOanAhVFnL/V5DJCcju9FN3ZosP5Pnw7701bMap/EepPUTmCK+Btl2pZH49MlfKvldh4IE7x8AGf/QiTsOfm8Bsaqwn+f352+46Q5mw97TSMD9sLsaC8gBD6sZz35YaL3QY+Kc+diNk9dyalRNKdNVroENO0jJtgmtHRka5zqFC+WeVpt1dgZQOQn2sNKyIYCMAyoditHTbywslDdrDKJeYi0oIgr0
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:20:22.1599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1b3c89-5b5e-4b08-7f3b-08dc395317c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452

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
    v2:
    - Use uint to encode NHA_GROUP_STATS_ENTRY_PACKETS
    - Rename jump target in nla_put_nh_group_stats() to avoid
      having to rename further in the patchset.

 include/uapi/linux/nexthop.h | 30 ++++++++++++
 net/ipv4/nexthop.c           | 92 ++++++++++++++++++++++++++++++++----
 2 files changed, 114 insertions(+), 8 deletions(-)

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
index 4be66622e24f..0ede8777bd66 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -41,7 +41,8 @@ static const struct nla_policy rtm_nh_policy_new[] = {
 
 static const struct nla_policy rtm_nh_policy_get[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
-	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32, 0),
+	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
+						  NHA_OP_FLAG_DUMP_STATS),
 };
 
 static const struct nla_policy rtm_nh_policy_del[] = {
@@ -53,7 +54,8 @@ static const struct nla_policy rtm_nh_policy_dump[] = {
 	[NHA_GROUPS]		= { .type = NLA_FLAG },
 	[NHA_MASTER]		= { .type = NLA_U32 },
 	[NHA_FDB]		= { .type = NLA_FLAG },
-	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32, 0),
+	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
+						  NHA_OP_FLAG_DUMP_STATS),
 };
 
 static const struct nla_policy rtm_nh_res_policy_new[] = {
@@ -661,8 +663,77 @@ static int nla_put_nh_group_res(struct sk_buff *skb, struct nh_group *nhg)
 	return -EMSGSIZE;
 }
 
-static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
+static void nh_grp_entry_stats_read(struct nh_grp_entry *nhge,
+				    struct nh_grp_entry_stats *stats)
 {
+	int i;
+
+	memset(stats, 0, sizeof(*stats));
+	for_each_possible_cpu(i) {
+		struct nh_grp_entry_stats *cpu_stats;
+		unsigned int start;
+		u64 packets;
+
+		cpu_stats = per_cpu_ptr(nhge->stats, i);
+		do {
+			start = u64_stats_fetch_begin(&cpu_stats->syncp);
+			packets = cpu_stats->packets;
+		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
+
+		stats->packets += packets;
+	}
+}
+
+static int nla_put_nh_group_stats_entry(struct sk_buff *skb,
+					struct nh_grp_entry *nhge)
+{
+	struct nh_grp_entry_stats stats;
+	struct nlattr *nest;
+
+	nh_grp_entry_stats_read(nhge, &stats);
+
+	nest = nla_nest_start(skb, NHA_GROUP_STATS_ENTRY);
+	if (!nest)
+		return -EMSGSIZE;
+
+	if (nla_put_u32(skb, NHA_GROUP_STATS_ENTRY_ID, nhge->nh->id) ||
+	    nla_put_uint(skb, NHA_GROUP_STATS_ENTRY_PACKETS, stats.packets))
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
@@ -691,6 +762,10 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
 	if (nhg->resilient && nla_put_nh_group_res(skb, nhg))
 		goto nla_put_failure;
 
+	if (op_flags & NHA_OP_FLAG_DUMP_STATS &&
+	    nla_put_nh_group_stats(skb, nh))
+		goto nla_put_failure;
+
 	return 0;
 
 nla_put_failure:
@@ -698,7 +773,8 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
 }
 
 static int nh_fill_node(struct sk_buff *skb, struct nexthop *nh,
-			int event, u32 portid, u32 seq, unsigned int nlflags)
+			int event, u32 portid, u32 seq, unsigned int nlflags,
+			u32 op_flags)
 {
 	struct fib6_nh *fib6_nh;
 	struct fib_nh *fib_nh;
@@ -725,7 +801,7 @@ static int nh_fill_node(struct sk_buff *skb, struct nexthop *nh,
 
 		if (nhg->fdb_nh && nla_put_flag(skb, NHA_FDB))
 			goto nla_put_failure;
-		if (nla_put_nh_group(skb, nhg))
+		if (nla_put_nh_group(skb, nh, op_flags))
 			goto nla_put_failure;
 		goto out;
 	}
@@ -856,7 +932,7 @@ static void nexthop_notify(int event, struct nexthop *nh, struct nl_info *info)
 	if (!skb)
 		goto errout;
 
-	err = nh_fill_node(skb, nh, event, info->portid, seq, nlflags);
+	err = nh_fill_node(skb, nh, event, info->portid, seq, nlflags, 0);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in nh_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -3085,7 +3161,7 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		goto errout_free;
 
 	err = nh_fill_node(skb, nh, RTM_NEWNEXTHOP, NETLINK_CB(in_skb).portid,
-			   nlh->nlmsg_seq, 0);
+			   nlh->nlmsg_seq, 0, op_flags);
 	if (err < 0) {
 		WARN_ON(err == -EMSGSIZE);
 		goto errout_free;
@@ -3255,7 +3331,7 @@ static int rtm_dump_nexthop_cb(struct sk_buff *skb, struct netlink_callback *cb,
 
 	return nh_fill_node(skb, nh, RTM_NEWNEXTHOP,
 			    NETLINK_CB(cb->skb).portid,
-			    cb->nlh->nlmsg_seq, NLM_F_MULTI);
+			    cb->nlh->nlmsg_seq, NLM_F_MULTI, filter->op_flags);
 }
 
 /* rtnl */
-- 
2.43.0


