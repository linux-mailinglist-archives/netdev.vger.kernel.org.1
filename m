Return-Path: <netdev+bounces-77224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB63C870BE0
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD323282E47
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A719101FA;
	Mon,  4 Mar 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwsFy1RD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE46E57F
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585544; cv=fail; b=VIUj8G+S4L8poQS4ZJsYNfemkQVoXog9Z3SMTjXaUKT8teYlszr3IrAslHIVmrDVb/Ez8IMRs+yACksx1nuZPcY6tx2lCGiBzA2/EjID4A53cuKoe+qNlLOt12ISvTTJd+/hjEjkpa4bMvM35y1a+GxsiH4YmUGmD3nvTlezYhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585544; c=relaxed/simple;
	bh=jbT7Zif7mgiHo/j7BVMGU707ngMXBajP2DuXRsztjpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jz7KUjOqEuWWiqsswARpPdqaEtS0CMn1VlQ6Bxwjr6bgYdZwouhaaz5oYtv9is+sVLcdy6I1Jmzk5R2051bcank6lQmrb2SNQWsQflN6Hqw3WpYC8MM10jBng++rNy2SmJJWFlEwgXEiHXvvnJp6o8p8GA+fhl8F0aQqikyKVuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwsFy1RD; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9uQCfytzkBrzNMB973rQUjAGgelcCpfxoafXM7z4W/B3AE4b47UWVmmRfIQh1c4fQvo80qcRmbPZfwIhSN4R5DC9NmuZl3i2VDXE7lYydP1qe9zFAG4lSY8/eHAhYoB9Uc4URApiqwpQZCDrvGTxFTvjRjPd9dzpQ6aO9XpjlNfOcwyJcIRKaHonzJaXQnNX/S6byuhFer8QpAq4BjT2rKm5efrqx+bT/PccRB8YYkhAc1F1zhHlNJ2GQ23S32CmwQwSujfUxhvpdx75doX6Yaa9rDxRS3Pl/mtXbChcVB21hn7hzLSPL6zZS/hdUqPqaLYMoklFo+/sAJBnQ8Isw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTkWYz9FY0GMnixPP7jtY38ZlKRAvKGWB8ZyIbMT5MY=;
 b=B6uGIDXtW4JzfXmIkmQvcf9vTaMD8kSxXCyY/btvzAymnD3gw+EecDg5thfKeA2pwa/CrFFlbxuCBXhcFDvkRAujMtrJUrs1AUCVSTL4PGgDVMwNT/2Uk8gmS2WdVdozcCMMh5+HY5nwU2bU5WNc4BsAAGG9u9j/5KPFgkpvlJUdy3+GhdWGDeelCtMsM2sUxzmP4CyiPgs5UxPnO3bPSm9gsftDqE6pID2kjA5R+qMmfpOlKnzG44tJGMJJVd+dMqV0IL9dkQvqsCDf2bvfgi9vms3FpdWQQPVTWo2JuOx81VTXZfmX1ChoK+gZSkTG0Z8Du8CHIrB3bxWVzBdQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTkWYz9FY0GMnixPP7jtY38ZlKRAvKGWB8ZyIbMT5MY=;
 b=VwsFy1RDH6fpKJ5NkoIkV5kO4nwWIXyycQQMtXRIjnm9f2pava+quk8HGJlm1j+aPAgQzUJhFlGSuMpYJAH+srj1BdSnoyxodGTdj22mzMxn5ipDZHzhJBvynQoxYTundZrIndQDNMT7UMBSnmFqu71EIWgxPki9dOw4GlMk7VjXiPCitTXII1xyZT0N/o/hDooHgyEdBEj5rBz0UuJv5hlX5l3LKouGsdNlXg6YFVTPLvNT58Uhv4zFeDtKN+fkMvsjndnF7uSxLCA9srdQDRG+RTJts3F0JaeeHAhe7Ibyr1YDatfXN4ZBSSqW09k/pNHwOT9wxkwsEjYx62gRsA==
Received: from DS7PR03CA0253.namprd03.prod.outlook.com (2603:10b6:5:3b3::18)
 by IA1PR12MB8405.namprd12.prod.outlook.com (2603:10b6:208:3d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 20:52:20 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::83) by DS7PR03CA0253.outlook.office365.com
 (2603:10b6:5:3b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 20:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 20:52:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 12:52:06 -0800
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 12:52:02 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v3 4/7] net: nexthop: Expose nexthop group stats to user space
Date: Mon, 4 Mar 2024 21:51:17 +0100
Message-ID: <aa4033e9a1b7512fe31913744c01410e5d5b0342.1709560395.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709560395.git.petrm@nvidia.com>
References: <cover.1709560395.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|IA1PR12MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: c9af07d9-cb27-4581-5086-08dc3c8cfbc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tPJUGgj7MKdqoqjr5fO4Vzlax6wEh/swGxVqqwlaFZBNpa15e0NqcjPkG2RRr+JJ4g1O8/lpQpzmdQZCnkn3BvaL0A3kBz8D5QDCL44tFTFysh1zWi7ZcIxmbQqXP4o09s5EwTGtC9CSAGkk3Mra1C2hmXS13zlO+6JFjWsNpPJmWKoAHWn2oJBYIJ2WmTHF68dzV8Xql5a5p/4LwnOqgJ6PQ8fOmec/hHUEXI/jJvljOjoB2l2Y3cv0n7WVtKa9uzwFQmLoiY4WX1EHqhpOMMQf+jaPtELF9a+q2z9oF7GVL99YZQpvP224/H2ho+JDsgyAKFCpvhQw0GfoOXB1IWHDHmShS6STRxWkcyI9SVNmMHJJewLlk75TobHxz6QBeXt1qgD8cmMdentcmp09D3IWWg1Qsshmb9e0nfBUpHBXDg0lzz/7c9OS3T52bhSgkQoR3qEesKE99GeUDGl9BSXs2CvidwEH0dqFivLrYyATxWPsaxQ94YSOMimyAJoZsWFtVtCz6nzcSu0CJnbJCCV75gor9G7+lbE0IczlosnY4rnCHEuwWQEpNXbIcqOXDOiZsu2dakZq3uoLgXe7HLdfuyrvOjWBVmZ0UyKwnaLaUxhQE9dwa8pgHrRJSDhuah9WeCRMxvf/9EGvlp9Zl211B34VQpBnEKraJcXK8RNqQNrzsVqZgcqNipjK7BszRcueRR9JI5tXPATacYZuFldiV80q5i0w4wzbyXst5lNoH/n23FqfeUV+B2UhQlxu
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:52:19.5724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9af07d9-cb27-4581-5086-08dc3c8cfbc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8405

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
index 06d65e27553d..68ba60a1bad9 100644
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


