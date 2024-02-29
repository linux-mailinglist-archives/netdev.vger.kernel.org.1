Return-Path: <netdev+bounces-76283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6F886D1F0
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727F9284FBD
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD617A143;
	Thu, 29 Feb 2024 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QI0kwNJb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC197D3E0
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230841; cv=fail; b=l63g/a9WCdWuODMXSaDqwQCKmw6zWgvnRqe6haU6gXixptDli7uT44yrn4r2iI6lKJixLnvJ0zyqo5qNDFNCJ54fOog9DBCOogS5+Eh5mulNekn7V3XaXZjb39ZsTL6ztavcencO8hVVcfyrIOW3IMGrc9dojAz6GtkiJofwg1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230841; c=relaxed/simple;
	bh=yQD2PevC7A8paCooMwERTtTJV2QPdJjWjCcLOEV4DJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvkNqkviRUDUoBDp45zHcLRBeipQao/lhsHRz1TU+ITqFNsLrpieltmfICD8adHJ/v6/zZx3gKCIh+sMTkk8/hg6A/nqAOhF0GsRen+0GGt5dXdUQZB6pppJ5GtAsCeNJ4U99JJV+OiFRqX0fkGbSJk1xZ9JM3gepCCm2tqNX8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QI0kwNJb; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8MS1M47FrMPG6uKZUQHscIbsJLt2qp2yK9bIcacTqkZwMshp7pLKJ330V8s3slD5RG7pmL3XqnmcvuHiGX9urfdqAIMb82L+cb1IrFfE/TA1ziEel8E4qXVWPPDV5E4EwefkuHSHVCkIZUgshUF5Vp/7yJgJHD4zYO0zJ0y/gDNXLpqVRz4hq+rkOaL0dH+vS2QGm+ki1msh/BUz42f7lcMNv/H09vXg5eJZR0it2y7G+kA9EvLg/T0YP+R5HRIfubs7+FA4b85CEN6JjHQ9a9STRDtgBVNogAdvCNCiDSkhaMqrSXpSBiZaOkeFx0QhmufuUjVa0ysorRVz4iMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ny4BpFqM1tMjHk7PGgamoDwn+QhuyGxG2y0NMqm98U=;
 b=Z+KO3WE5q+5U1YcGOblbEF7epsrZN3mScPlOaXV4oQpz0az8Nc6yE5jNEKqkwf+NBKt+2rv7k0HsgFezLjB9gpL/pu7W1bnBify3c0YNKyIFGEaUOrI9u+hM0W67b4yqr0cjZhrcyBQGeaKKFfHK9Wak7phtjfhNf3Ii2O2lNiLHjgA6en+VBrfMTX9fkWlNIgwIb4OKjkFQgC0kbssm39rY8dK+W8p6Zi7k2oaUqw730801aOciYJVpgYb9w4WInukFmoKUsT1Fb0tneMf9hHTUIaRpWMr1zOuoJS83yKeUu0rKtc7Zn0bsHY2N5Y7x7Rik8khSbBB0P0ttkvQ8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ny4BpFqM1tMjHk7PGgamoDwn+QhuyGxG2y0NMqm98U=;
 b=QI0kwNJbVaVpziD9fBKyoaON9cZRfj+yj8nOwJXcjcFxav7FsX3xtpe9Txvd5b2ak0f70wqLUiCOr9o8lmfHfMpR7SAOeKVbmWgyde3upbkgjbmYcbXjq4M34AbSRXHcByZ/P0Bdf5yhHyBhpQGba7CdHrqMJMFs8+hMt3HBochipN3rSOzYSrofgdJWqvvmTCknpbWSdjWAaitugSrfE0JI0anYDQSEdDT4dqxsh8J9GDe8UAsDuWGVhCtD9MyVvmnU/pFI4Njwu29sT+vNdNv9/eQ/j20tgMeRbeUEiSy0bzWDiBOify5dLSLbzptdQZf9hNZ7TSOF2TBRRirnIA==
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 18:20:37 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::bf) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.31 via Frontend
 Transport; Thu, 29 Feb 2024 18:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 18:20:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 10:20:19 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 29 Feb
 2024 10:20:13 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>, Kees Cook <keescook@chromium.org>
Subject: [PATCH net-next v2 7/7] net: nexthop: Expose nexthop group HW stats to user space
Date: Thu, 29 Feb 2024 19:16:40 +0100
Message-ID: <f35433867d7bab05bbe0a1b4a09c3454cdefeb7b.1709217658.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: a853b468-f7bd-4083-ae4c-08dc3953207c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BxRo0W0eCu9wZmvY/Fqx7IMHuEILOH7Khh7ilJzZlF1U3m6af0b9luEPYM9Sju7/S1Z7RZaRx4XDMhpUuTEi03N6fta2khnFMLgJbQ8vAGZiRY1kDnIxzWVcKn/gkYr8xICBrn1pneu3KcQfmoIywxqJy+g1roRHokBgQT5xhnktJ0EeUuz3t6dKJRRSU6Ux8fQY9q33OODPY/X3x7Pql5YcltNGKd/GSNiIpopCaeVF0/7aU9vdtACLuCcQ3wHa3xZPtQdA3aFlTSLEkl0Hlh02eWTW3IaNYjk5MjKrP5I6a2u8xCtZxEy8AdNt290CQZXJU0VQMcw9HJfD1T9kXPrPxnKybdWjwZh2WiiJ4BmMPOHx/BCtZN6nW+QP/3gHzgCe7i84ZVyy0902Ctwe6mSt2ANEPItqqLqVL54svY6EZTtGPOR5bZCezrK9kCs8Ah068MHTMQ85YqnnSUhOipGtE3xWFVnT+X76N7q3op1l71y5TKtpdYRFsLFCvigvsXD++Mn+DRtm78731iDU7dF15i8BXWIsMKMEPwfvtAu5nZKI3kSCNm1J6Ten6DSd15L0MLTqlBC9k2/QGcdYzYtsuSuJqxrDN9e4wq0Xda2Qau5AITfc2PrtgdcsL+t8MUeOnwgmUA30q/VsK/4n4UmJNKqM7maoTfvxYWuFM04iraryXIeOwClCc49mK3az5m6XL6Pt6TQ7Jd31X2DejmQ/wMQYkz9fpG8c0ny52KnvgTmYHr4xjIn1XWntfVf8
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:20:36.7066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a853b468-f7bd-4083-ae4c-08dc3953207c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374

From: Ido Schimmel <idosch@nvidia.com>

Add netlink support for reading NH group hardware stats.

Stats collection is done through a new notifier,
NEXTHOP_EVENT_HW_STATS_REPORT_DELTA. Drivers that implement HW counters for
a given NH group are thereby asked to collect the stats and report back to
core by calling nh_grp_hw_stats_report_delta(). This is similar to what
netdevice L3 stats do.

Besides exposing number of packets that passed in the HW datapath, also
include information on whether any driver actually realizes the counters.
The core can tell based on whether it got any _report_delta() reports from
the drivers. This allows enabling the statistics at the group at any time,
with drivers opting into supporting them. This is also in line with what
netdevice L3 stats are doing.

So as not to waste time and space, tie the collection and reporting of HW
stats with a new op flag, NHA_OP_FLAG_DUMP_HW_STATS.

Co-developed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Kees Cook <keescook@chromium.org> # For the __counted_by bits
---

Notes:
    v2:
    - Use uint to encode NHA_GROUP_STATS_ENTRY_PACKETS_HW
    - Do not cancel outside of nesting in nla_put_nh_group_stats()

 include/net/nexthop.h        |  18 +++++
 include/uapi/linux/nexthop.h |   9 +++
 net/ipv4/nexthop.c           | 133 ++++++++++++++++++++++++++++++++---
 3 files changed, 151 insertions(+), 9 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 20cd337b4a9c..235f94ab16a8 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -122,6 +122,7 @@ struct nh_grp_entry {
 
 	struct list_head nh_list;
 	struct nexthop	*nh_parent;  /* nexthop of group with this entry */
+	u64		packets_hw;
 };
 
 struct nh_group {
@@ -166,6 +167,7 @@ enum nexthop_event_type {
 	NEXTHOP_EVENT_REPLACE,
 	NEXTHOP_EVENT_RES_TABLE_PRE_REPLACE,
 	NEXTHOP_EVENT_BUCKET_REPLACE,
+	NEXTHOP_EVENT_HW_STATS_REPORT_DELTA,
 };
 
 enum nh_notifier_info_type {
@@ -173,6 +175,7 @@ enum nh_notifier_info_type {
 	NH_NOTIFIER_INFO_TYPE_GRP,
 	NH_NOTIFIER_INFO_TYPE_RES_TABLE,
 	NH_NOTIFIER_INFO_TYPE_RES_BUCKET,
+	NH_NOTIFIER_INFO_TYPE_GRP_HW_STATS,
 };
 
 struct nh_notifier_single_info {
@@ -214,6 +217,17 @@ struct nh_notifier_res_table_info {
 	struct nh_notifier_single_info nhs[] __counted_by(num_nh_buckets);
 };
 
+struct nh_notifier_grp_hw_stats_entry_info {
+	u32 id;
+	u64 packets;
+};
+
+struct nh_notifier_grp_hw_stats_info {
+	u16 num_nh;
+	bool hw_stats_used;
+	struct nh_notifier_grp_hw_stats_entry_info stats[] __counted_by(num_nh);
+};
+
 struct nh_notifier_info {
 	struct net *net;
 	struct netlink_ext_ack *extack;
@@ -224,6 +238,7 @@ struct nh_notifier_info {
 		struct nh_notifier_grp_info *nh_grp;
 		struct nh_notifier_res_table_info *nh_res_table;
 		struct nh_notifier_res_bucket_info *nh_res_bucket;
+		struct nh_notifier_grp_hw_stats_info *nh_grp_hw_stats;
 	};
 };
 
@@ -236,6 +251,9 @@ void nexthop_bucket_set_hw_flags(struct net *net, u32 id, u16 bucket_index,
 				 bool offload, bool trap);
 void nexthop_res_grp_activity_update(struct net *net, u32 id, u16 num_buckets,
 				     unsigned long *activity);
+void nh_grp_hw_stats_report_delta(struct nh_notifier_grp_hw_stats_info *info,
+				  unsigned int nh_idx,
+				  u64 delta_packets);
 
 /* caller is holding rcu or rtnl; no reference taken to nexthop */
 struct nexthop *nexthop_find_by_id(struct net *net, u32 id);
diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index b86af80d4e09..dd8787f9cf39 100644
--- a/include/uapi/linux/nexthop.h
+++ b/include/uapi/linux/nexthop.h
@@ -31,6 +31,7 @@ enum {
 #define NEXTHOP_GRP_TYPE_MAX (__NEXTHOP_GRP_TYPE_MAX - 1)
 
 #define NHA_OP_FLAG_DUMP_STATS		BIT(0)
+#define NHA_OP_FLAG_DUMP_HW_STATS	BIT(1)
 
 enum {
 	NHA_UNSPEC,
@@ -71,6 +72,9 @@ enum {
 	/* u32; nexthop hardware stats enable */
 	NHA_HW_STATS_ENABLE,
 
+	/* u32; read-only; whether any driver collects HW stats */
+	NHA_HW_STATS_USED,
+
 	__NHA_MAX,
 };
 
@@ -132,6 +136,11 @@ enum {
 	/* uint; number of packets forwarded via the nexthop group entry */
 	NHA_GROUP_STATS_ENTRY_PACKETS,
 
+	/* uint; number of packets forwarded via the nexthop group entry in
+	 * hardware
+	 */
+	NHA_GROUP_STATS_ENTRY_PACKETS_HW,
+
 	__NHA_GROUP_STATS_ENTRY_MAX,
 };
 
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 15f108c440ae..169a003cc855 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -43,7 +43,8 @@ static const struct nla_policy rtm_nh_policy_new[] = {
 static const struct nla_policy rtm_nh_policy_get[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
 	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
-						  NHA_OP_FLAG_DUMP_STATS),
+						  NHA_OP_FLAG_DUMP_STATS |
+						  NHA_OP_FLAG_DUMP_HW_STATS),
 };
 
 static const struct nla_policy rtm_nh_policy_del[] = {
@@ -56,7 +57,8 @@ static const struct nla_policy rtm_nh_policy_dump[] = {
 	[NHA_MASTER]		= { .type = NLA_U32 },
 	[NHA_FDB]		= { .type = NLA_FLAG },
 	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32,
-						  NHA_OP_FLAG_DUMP_STATS),
+						  NHA_OP_FLAG_DUMP_STATS |
+						  NHA_OP_FLAG_DUMP_HW_STATS),
 };
 
 static const struct nla_policy rtm_nh_res_policy_new[] = {
@@ -687,8 +689,95 @@ static void nh_grp_entry_stats_read(struct nh_grp_entry *nhge,
 	}
 }
 
+static int nh_notifier_grp_hw_stats_init(struct nh_notifier_info *info,
+					 const struct nexthop *nh)
+{
+	struct nh_group *nhg;
+	int i;
+
+	ASSERT_RTNL();
+	nhg = rtnl_dereference(nh->nh_grp);
+
+	info->id = nh->id;
+	info->type = NH_NOTIFIER_INFO_TYPE_GRP_HW_STATS;
+	info->nh_grp_hw_stats = kzalloc(struct_size(info->nh_grp_hw_stats,
+						    stats, nhg->num_nh),
+					GFP_KERNEL);
+	if (!info->nh_grp_hw_stats)
+		return -ENOMEM;
+
+	info->nh_grp_hw_stats->num_nh = nhg->num_nh;
+	for (i = 0; i < nhg->num_nh; i++) {
+		struct nh_grp_entry *nhge = &nhg->nh_entries[i];
+
+		info->nh_grp_hw_stats->stats[i].id = nhge->nh->id;
+	}
+
+	return 0;
+}
+
+static void nh_notifier_grp_hw_stats_fini(struct nh_notifier_info *info)
+{
+	kfree(info->nh_grp_hw_stats);
+}
+
+void nh_grp_hw_stats_report_delta(struct nh_notifier_grp_hw_stats_info *info,
+				  unsigned int nh_idx,
+				  u64 delta_packets)
+{
+	info->hw_stats_used = true;
+	info->stats[nh_idx].packets += delta_packets;
+}
+EXPORT_SYMBOL(nh_grp_hw_stats_report_delta);
+
+static void nh_grp_hw_stats_apply_update(struct nexthop *nh,
+					 struct nh_notifier_info *info)
+{
+	struct nh_group *nhg;
+	int i;
+
+	ASSERT_RTNL();
+	nhg = rtnl_dereference(nh->nh_grp);
+
+	for (i = 0; i < nhg->num_nh; i++) {
+		struct nh_grp_entry *nhge = &nhg->nh_entries[i];
+
+		nhge->packets_hw += info->nh_grp_hw_stats->stats[i].packets;
+	}
+}
+
+static int nh_grp_hw_stats_update(struct nexthop *nh, bool *hw_stats_used)
+{
+	struct nh_notifier_info info = {
+		.net = nh->net,
+	};
+	struct net *net = nh->net;
+	int err;
+
+	if (nexthop_notifiers_is_empty(net))
+		return 0;
+
+	err = nh_notifier_grp_hw_stats_init(&info, nh);
+	if (err)
+		return err;
+
+	err = blocking_notifier_call_chain(&net->nexthop.notifier_chain,
+					   NEXTHOP_EVENT_HW_STATS_REPORT_DELTA,
+					   &info);
+
+	/* Cache whatever we got, even if there was an error, otherwise the
+	 * successful stats retrievals would get lost.
+	 */
+	nh_grp_hw_stats_apply_update(nh, &info);
+	*hw_stats_used = info.nh_grp_hw_stats->hw_stats_used;
+
+	nh_notifier_grp_hw_stats_fini(&info);
+	return notifier_to_errno(err);
+}
+
 static int nla_put_nh_group_stats_entry(struct sk_buff *skb,
-					struct nh_grp_entry *nhge)
+					struct nh_grp_entry *nhge,
+					u32 op_flags)
 {
 	struct nh_grp_entry_stats stats;
 	struct nlattr *nest;
@@ -700,7 +789,13 @@ static int nla_put_nh_group_stats_entry(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	if (nla_put_u32(skb, NHA_GROUP_STATS_ENTRY_ID, nhge->nh->id) ||
-	    nla_put_uint(skb, NHA_GROUP_STATS_ENTRY_PACKETS, stats.packets))
+	    nla_put_uint(skb, NHA_GROUP_STATS_ENTRY_PACKETS,
+			 stats.packets + nhge->packets_hw))
+		goto nla_put_failure;
+
+	if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS &&
+	    nla_put_uint(skb, NHA_GROUP_STATS_ENTRY_PACKETS_HW,
+			 nhge->packets_hw))
 		goto nla_put_failure;
 
 	nla_nest_end(skb, nest);
@@ -711,18 +806,35 @@ static int nla_put_nh_group_stats_entry(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int nla_put_nh_group_stats(struct sk_buff *skb, struct nexthop *nh)
+static int nla_put_nh_group_stats(struct sk_buff *skb, struct nexthop *nh,
+				  u32 op_flags)
 {
 	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
 	struct nlattr *nest;
+	bool hw_stats_used;
+	int err;
 	int i;
 
+	if (nla_put_u32(skb, NHA_HW_STATS_ENABLE, nhg->hw_stats))
+		goto err_out;
+
+	if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS &&
+	    nhg->hw_stats) {
+		err = nh_grp_hw_stats_update(nh, &hw_stats_used);
+		if (err)
+			goto out;
+
+		if (nla_put_u32(skb, NHA_HW_STATS_USED, hw_stats_used))
+			goto err_out;
+	}
+
 	nest = nla_nest_start(skb, NHA_GROUP_STATS);
 	if (!nest)
-		return -EMSGSIZE;
+		goto err_out;
 
 	for (i = 0; i < nhg->num_nh; i++)
-		if (nla_put_nh_group_stats_entry(skb, &nhg->nh_entries[i]))
+		if (nla_put_nh_group_stats_entry(skb, &nhg->nh_entries[i],
+						 op_flags))
 			goto cancel_out;
 
 	nla_nest_end(skb, nest);
@@ -730,7 +842,10 @@ static int nla_put_nh_group_stats(struct sk_buff *skb, struct nexthop *nh)
 
 cancel_out:
 	nla_nest_cancel(skb, nest);
-	return -EMSGSIZE;
+err_out:
+	err = -EMSGSIZE;
+out:
+	return err;
 }
 
 static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
@@ -767,7 +882,7 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 
 	if (op_flags & NHA_OP_FLAG_DUMP_STATS &&
 	    (nla_put_u32(skb, NHA_HW_STATS_ENABLE, nhg->hw_stats) ||
-	     nla_put_nh_group_stats(skb, nh)))
+	     nla_put_nh_group_stats(skb, nh, op_flags)))
 		goto nla_put_failure;
 
 	return 0;
-- 
2.43.0


