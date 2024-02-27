Return-Path: <netdev+bounces-75436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E46A869EEF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BA12908C4
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B85149E13;
	Tue, 27 Feb 2024 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VJT7ue5E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584211487C6
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057901; cv=fail; b=E6mvx4kesH7wk4nWkkyfMYEvMRegr/eHEq8sa+M+Zw19YTDUITi9svBZcYTW1xfH1bArvEZpEvH83cUGdvv0UwsWVMPikarvv1rMFHnMA92kRlf0nh2TiZntwLb39pExYIUTfDZn7i3QwSDqkCFFKNrwEqgM8wgbBbwnagnMcZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057901; c=relaxed/simple;
	bh=KAKwG9HcsasfOvB7jfPzIT8FAkcCMOX28E3bmfCirsw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaR1TNBkPiFe2+jHyvN9li3FRFd5rRYJ6fXivSfhLtwQkvr0pQkrMBsg/Em9Ln6wA3RReGWA+or9f4FEl0WF7w3FwZFHZ5CLfBu8J8VWnRqr4hVVSmno/JZNKktMA9bF4HvhOm8DEjoP9QKkyVJLAffCIR1dvfZwGvsm9E+wX3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VJT7ue5E; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIUtdu491rJHuBW0EyM+IWV8Eh4tpKv/cH9abJo2YZ7gO+w5YNry+7jhKPHF752/MiFBffPpmE7TeUJN+jvWvy+RagOIjdU0JiZUIUanEs7ACSzJWSyoueIrVCnMwn3hafK/ampPUrAk+/+5NseBUQwEMwfQ0JRO5NfoYH7vImwtepR5MXfSs8OZo+IEuCBMPo49oa9y02NEZUMpN1t5uTXmckrRhQUH9IgtULG27n2zasva8eHeLFhCnfv17i94tgV88KGLxSrbuXYB38enroNqWDHFU6Wq152jM5IW9M7JLa6BR+EAKD3C16vDDo5sDH8sa/52Z8/rPRMwlvGVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdD2FJ7mlMhUxLGOoBjzIIzqXcOrnGnuVf9w+2eA9pY=;
 b=Z7DgDDjmSY6JruCdaMdtvMJUDowibW6bn1UCSKR+94yP0RLKdCspisXYIicdeKLAAOKH4cWjDNzCtInYjo10ZPxAyein7nR4oog1Vn40yL3BFvBDp+0eOXPdGtb/3lkMSIodYRondQUZyTa+IWqXjiMKDNG+5z9yLHsKkf2p08KXlhgTCGGKg4/fX3IZSv6Z1HH7kwW3n04N2teGoYFYtXQj30lbnee/w750f8gEKLrvnaRZMpJTY6Ep48dYfV2JvwiUphplJ/Sw9p3ltJ5nYsn8KFxjzoBivBbdSnZBY99AsUaaSFBmqe1zeZmtoD05p/m+3pX237XOwdujc0WsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdD2FJ7mlMhUxLGOoBjzIIzqXcOrnGnuVf9w+2eA9pY=;
 b=VJT7ue5EFsKHkhjq6Fqc2jA+/Xm33JW2ijzHu+47QLh/wh2xU4wOtmojEQLaxfsQDQRtiSIX76FRN9Q6a+3rXc6Rvo2gW7m3hZQujrL6x3V3c004RR1NYvAvPL6Tu7SruPboezuTEeC0co2/E9VWFSKTeOnUmDblUVgzmJrSGTZfxY/QCQB0lMm0ekb3SaVz/xfUgsjkwXnJ3rDcQY17Xf3kv8BwF35fEMhHddJyN46ygWMeAOggXBpXNyD7WgVkobaQpLMrupfn7dt1VkYZQvuZq2z+jWQFUZXHR60axgE2EtCxY0dsu/uG6DOszCUTKE04EVIU3ZEyURhozKenhg==
Received: from CH0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:b0::8)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 18:18:16 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::8f) by CH0PR03CA0003.outlook.office365.com
 (2603:10b6:610:b0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 18:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 18:18:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 10:18:05 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 10:18:00 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 4/7] net: nexthop: Expose nexthop group stats to user space
Date: Tue, 27 Feb 2024 19:17:29 +0100
Message-ID: <b194971db40744eb8aa6e1e562564cac7118c42f.1709057158.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709057158.git.petrm@nvidia.com>
References: <cover.1709057158.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: e6781402-afe0-437a-9b43-08dc37c077df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KwYMkWIV0FECpV6kmX3UTL5OoSYErNZMhP6AfvapDgOuFIx6HghJCnIDA1E2zTOCXdkuWlDWdIPh0aSUwbEHk7JOR2hM2OhpJJnnF464knEXEORLQfySnVMibJIJEtfGW2FHuQcncyEZIUEivw8diDgjGEDeGrQPN3LpbyHUV0eJT+Eprvde1uWz7paSp/TNtP5Z93WKJbcjQBAJDPvivkWBg8+20K5tynmv+rEXXUz4356LQH9ZDOkd0RCWv0CnAukax+4c2zZiy6u6wVaScxh7qp7N7RnGLy2KLiHq2CDvkKGEIVEBi20C11MzWs4IPEeLAZeK0aJNiOAvFV53DZmvMVvZf6Ucoq7BznrlASZGnxj8a8FrKlfjvxEtQBYV154uyWLLiwzrRaS3iNhUspe4imp9L9kpaecfLhOl3sct+J3nmWgEELwaXus/6lpdtC/7ivb/chzSif9E5Jb1Ep6uBs+yHkro2gY9X/uYs9VHR7HnsMLCDFdIMk5xWD71qiE64X4vvsz0zAxY5Fymz6T8uOGv2ObULs6VROkO/v8ONVJ//xgsbjjmTm1ned/OtsMfjwHnPuxHyq8vKCnNKqAV67Pwm79m0VmpJA5unFJrQgmuwgxGFXA1KhQv1ag+u19CKrtu8Ul6tjEe3S3z9cpqVLrHi1UJIshWJrl2Q5EH+7igNJZ8S1Q75NKi2NARwObIpKMdeIw3NQmFbiG9RS3LKiMX9oq3+FT2h7Z2VpA2yEEKpMyH2GjvNN6YyPGP
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 18:18:16.1815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6781402-afe0-437a-9b43-08dc37c077df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745

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
 include/uapi/linux/nexthop.h | 32 +++++++++++++
 net/ipv4/nexthop.c           | 91 ++++++++++++++++++++++++++++++++----
 2 files changed, 115 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index 0d7969911fd2..b19871b7e7f5 100644
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
 	/* bitfield32; operation-specific flags */
 	NHA_OP_FLAGS,
 
+	/* nested; nexthop group stats */
+	NHA_GROUP_STATS,
+
 	__NHA_MAX,
 };
 
@@ -104,4 +109,31 @@ enum {
 
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
+	/* Pad attribute for 64-bit alignment */
+	NHA_GROUP_STATS_ENTRY_PAD = NHA_GROUP_STATS_ENTRY_UNSPEC,
+
+	/* u32; nexthop id of the nexthop group entry */
+	NHA_GROUP_STATS_ENTRY_ID,
+
+	/* u64; number of packets forwarded via the nexthop group entry */
+	NHA_GROUP_STATS_ENTRY_PACKETS,
+
+	__NHA_GROUP_STATS_ENTRY_MAX,
+};
+
+#define NHA_GROUP_STATS_ENTRY_MAX	(__NHA_GROUP_STATS_ENTRY_MAX - 1)
+
 #endif
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 29d0ed049b91..9c7ec9f15f55 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -41,7 +41,7 @@ static const struct nla_policy rtm_nh_policy_new[] = {
 
 static const struct nla_policy rtm_nh_policy_get[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
-	[NHA_OP_FLAGS]		= NLA_POLICY_BITFIELD32(0),
+	[NHA_OP_FLAGS]		= NLA_POLICY_BITFIELD32(NHA_OP_FLAG_DUMP_STATS),
 };
 
 static const struct nla_policy rtm_nh_policy_del[] = {
@@ -53,7 +53,7 @@ static const struct nla_policy rtm_nh_policy_dump[] = {
 	[NHA_GROUPS]		= { .type = NLA_FLAG },
 	[NHA_MASTER]		= { .type = NLA_U32 },
 	[NHA_FDB]		= { .type = NLA_FLAG },
-	[NHA_OP_FLAGS]		= NLA_POLICY_BITFIELD32(0),
+	[NHA_OP_FLAGS]		= NLA_POLICY_BITFIELD32(NHA_OP_FLAG_DUMP_STATS),
 };
 
 static const struct nla_policy rtm_nh_res_policy_new[] = {
@@ -661,8 +661,78 @@ static int nla_put_nh_group_res(struct sk_buff *skb, struct nh_group *nhg)
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
+	    nla_put_u64_64bit(skb, NHA_GROUP_STATS_ENTRY_PACKETS, stats.packets,
+			      NHA_GROUP_STATS_ENTRY_PAD))
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
+			goto nla_put_failure;
+
+	nla_nest_end(skb, nest);
+	return 0;
+
+nla_put_failure:
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
@@ -691,6 +761,10 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
 	if (nhg->resilient && nla_put_nh_group_res(skb, nhg))
 		goto nla_put_failure;
 
+	if (op_flags & NHA_OP_FLAG_DUMP_STATS &&
+	    nla_put_nh_group_stats(skb, nh))
+		goto nla_put_failure;
+
 	return 0;
 
 nla_put_failure:
@@ -698,7 +772,8 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
 }
 
 static int nh_fill_node(struct sk_buff *skb, struct nexthop *nh,
-			int event, u32 portid, u32 seq, unsigned int nlflags)
+			int event, u32 portid, u32 seq, unsigned int nlflags,
+			u32 op_flags)
 {
 	struct fib6_nh *fib6_nh;
 	struct fib_nh *fib_nh;
@@ -725,7 +800,7 @@ static int nh_fill_node(struct sk_buff *skb, struct nexthop *nh,
 
 		if (nhg->fdb_nh && nla_put_flag(skb, NHA_FDB))
 			goto nla_put_failure;
-		if (nla_put_nh_group(skb, nhg))
+		if (nla_put_nh_group(skb, nh, op_flags))
 			goto nla_put_failure;
 		goto out;
 	}
@@ -856,7 +931,7 @@ static void nexthop_notify(int event, struct nexthop *nh, struct nl_info *info)
 	if (!skb)
 		goto errout;
 
-	err = nh_fill_node(skb, nh, event, info->portid, seq, nlflags);
+	err = nh_fill_node(skb, nh, event, info->portid, seq, nlflags, 0);
 	if (err < 0) {
 		/* -EMSGSIZE implies BUG in nh_nlmsg_size() */
 		WARN_ON(err == -EMSGSIZE);
@@ -3084,7 +3159,7 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		goto errout_free;
 
 	err = nh_fill_node(skb, nh, RTM_NEWNEXTHOP, NETLINK_CB(in_skb).portid,
-			   nlh->nlmsg_seq, 0);
+			   nlh->nlmsg_seq, 0, op_flags);
 	if (err < 0) {
 		WARN_ON(err == -EMSGSIZE);
 		goto errout_free;
@@ -3254,7 +3329,7 @@ static int rtm_dump_nexthop_cb(struct sk_buff *skb, struct netlink_callback *cb,
 
 	return nh_fill_node(skb, nh, RTM_NEWNEXTHOP,
 			    NETLINK_CB(cb->skb).portid,
-			    cb->nlh->nlmsg_seq, NLM_F_MULTI);
+			    cb->nlh->nlmsg_seq, NLM_F_MULTI, filter->op_flags);
 }
 
 /* rtnl */
-- 
2.43.0


