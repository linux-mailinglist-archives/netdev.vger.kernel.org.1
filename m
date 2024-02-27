Return-Path: <netdev+bounces-75442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C8A869EF7
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8366E1C27F2F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BFC14D423;
	Tue, 27 Feb 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rz3tehiW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561614C5B6
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057918; cv=fail; b=e4Kys8jxPDEL39UjuXmyCo9w0A1KCj+TJ8V+kzIg5taWUv8V36uWNwK6qWiNxOHUf0+txA5nPzxHisJ1+p7CtJl4droASZbPTGp4tO3l/C+DpGbBSUfkZqhP1W6ocfq0xuvJWerl5sGJispE8U4jbIqpXU1znLoHasIalxsMX34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057918; c=relaxed/simple;
	bh=2LnPXtvbK2RYDmPKCqVkZjB6HOVy4LsvPUgD6Vrp4WM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPADZHbJ67Zxsqa7VsZ/2WGa9LCO2OwSzKpm/YfcIzmLjYo5r/KG6TWlE5od7sZekNYU8V8m5zHIKE1a+KrnCproJ5+NDYCO/kuYAJfMBGJVQHnz+vcxNcgSgdLvErgooylFOTDAwSzdMDQ+cRSOYfrUpxZx8hPuZKLF7W820fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rz3tehiW; arc=fail smtp.client-ip=40.107.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5EQPGtWKqwqgeOvhTz4GpDFTGnKVtPOLQQnHgDuN5oai+e7Hvw+CqTbatxOBCcvY7IjJNvljQJ7VF1xXQznMVbL6O8akWX31fv74tUUUJWYVCLHTByXLnaPkgJ0L2RaRMWSEKCh42d/4wOeQy5y6/jtXuIS7wb7x71nhtGd+fEccQt14wmiLTYu9Cjwvo1egryaw0DlpW9WfYfmlEq418LNrk2ddmlVejjV1xtsoVaqIWT/cQkh3AalgxTkbmCsper/RfUyuC2J4uY8033cnV9CfwkChpxUX/6lHmaNa1FOMHG3DF/fT8BXQNuNkYz4abiKi+l1JlJjLriKL/jmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y84uQTSorBjwAI6ET1mMquQ2ABTEDRxx0EyMTjmV2hc=;
 b=jPcsFrD4t1Xe8YOZIAavKxaEGOtxC6OhGwzyHMwROX8Yw3TGfy03lErzPOA5fY0IfzeOprFdygBeRneqEH6BKno9TyjTMu7og+DP1uApTYMWEtDD9555oVmYIfbXH2OrAQdCQc5E1s1VzTb+jaBjpJ27ayPUmmwRHp1Sis2ryeUh6u8+vBSZ87SaqxtOkV3eU2evLiwafxgkyOBl9pBjfF/ikwTSLwI6Sm46ktJ2LoUTB2C3sor4d+pNClzzDEjsOZs8zbGE/SBWXIgUiEVQMOl6/Fhmkl/JIyWgKLkA1uZkT9YbFMxcgS/9m9XiQQCtB8AqjtLW4Aw23Y1WtfH2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y84uQTSorBjwAI6ET1mMquQ2ABTEDRxx0EyMTjmV2hc=;
 b=Rz3tehiWEAEZ+xfvMvDsB/srRpgIoPLw0zUIwij8W+dQiPf15NleVH3RhmLDK/BWc1JUxA5MkW99RjpTnwn+rPW4M50cmdyTto70q4ktetZ65aEfb997CnojRXbZR0x8044HpzGnnemKqIBC6J9Nk74bJAgu0pTfZ6FhJW+dkxGEhsj8OPamQoUA3WhwZrzkLLJAitn2YUTepKeahPVDNzuJE7PbfmNu32sNvWUGLRHJUOaiBw0CvevkHDIChsuMqZJvWEAIud6Un2N5zZV/bhxYjBhj8t1VAdsoI2vD7QhJ/rkiY1phXLU9Uh+44UfPCwqox6Il+YWYSOJ5wuxYXQ==
Received: from SA1P222CA0174.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::23)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 18:18:31 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::55) by SA1P222CA0174.outlook.office365.com
 (2603:10b6:806:3c3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Tue, 27 Feb 2024 18:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 18:18:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 10:18:11 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 10:18:08 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, <mlxsw@nvidia.com>, "Gustavo A . R . Silva"
	<gustavoars@kernel.org>, Kees Cook <keescook@chromium.org>
Subject: [PATCH net-next 7/7] net: nexthop: Expose nexthop group HW stats to user space
Date: Tue, 27 Feb 2024 19:17:32 +0100
Message-ID: <001978ea519441f0295912034d00dd1af9eb5b93.1709057158.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: cd021f1d-c40c-48fb-ba7b-08dc37c080a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cbJ8ZCOnFMe/lLCVRPbAEzJAGk0gYJeAd1gkK0bcQryI+ud9HS2cvgHke9x7AdmMaV6GWjzhC9u4TwiGpSt/23JdoznqUFHommwRPv3nxcpfoX5Pgj/6I/8gEMxafG59nVdPRB6zrPFuWtK2WRaMkWaaKSLj3di8LOwQBa3t+7IJM2KBM7Ay7/HOi3yxhdbWYQ6NRlOmw77qzZ5Ekys4KtnEvX8Sohx+rFNNVbgOJ+Eb1AtHPCKEvqIywo59tvTld7Qcapp415eTWG9omRE9fGEtXlul+FgDNUwBFkleE/vAIjYohM+mRQjZp543CVxupBO1p3fTy8oji11t74DFyUocChX+Nbjfe8na/luViBcYFM/EFIxOw6Sh1SNrIKcVOL/ViMTyEK2hui9O7MKCmVRWi2kWKrxpdXW/PRBETYOT9H6BzwU+Juc7l65oYJUsFPLJXIAoqfFiL4Bka7mwFOdQduHBh5l3CgLQD2Ej1W9VPFo50mcmIZvrqDIWbOgxrsFTmR3dM5mq9ZomkNd7HRV5vfdc/2H02NJTnKJyKktJLnSQiIxaydpN/NAvg4ho1YGD62vNp4uW61HAWtUkt0N9QPAaCPJbs0BDMM8ixYgKV8mCJ9iUbeK9tjvRxYS3GCplThHH9z0Tbs31RadYYHQMqCm6eqNIEh+To2hxz0UJll7FYDNcqeA3UbQzXrVf6ZWSP8qmgoZYPIvFAo+WRFhK31TA82zgrG62NgBbKSdHCrX0x9LlUj0Nx2hQcFNU
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 18:18:30.8926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd021f1d-c40c-48fb-ba7b-08dc37c080a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176

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

Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Co-developed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/nexthop.h        |  18 +++++
 include/uapi/linux/nexthop.h |   9 +++
 net/ipv4/nexthop.c           | 130 ++++++++++++++++++++++++++++++++---
 3 files changed, 149 insertions(+), 8 deletions(-)

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
index 6d5ec1c4bb05..37ed705fcf6d 100644
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
 
@@ -134,6 +138,11 @@ enum {
 	/* u64; number of packets forwarded via the nexthop group entry */
 	NHA_GROUP_STATS_ENTRY_PACKETS,
 
+	/* u64; number of packets forwarded via the nexthop group entry in
+	 * hardware
+	 */
+	NHA_GROUP_STATS_ENTRY_PACKETS_HW,
+
 	__NHA_GROUP_STATS_ENTRY_MAX,
 };
 
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 2e6889245294..ea2fef853337 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -42,7 +42,8 @@ static const struct nla_policy rtm_nh_policy_new[] = {
 
 static const struct nla_policy rtm_nh_policy_get[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
-	[NHA_OP_FLAGS]		= NLA_POLICY_BITFIELD32(NHA_OP_FLAG_DUMP_STATS),
+	[NHA_OP_FLAGS]		= NLA_POLICY_BITFIELD32(NHA_OP_FLAG_DUMP_STATS |
+							NHA_OP_FLAG_DUMP_HW_STATS),
 };
 
 static const struct nla_policy rtm_nh_policy_del[] = {
@@ -54,7 +55,8 @@ static const struct nla_policy rtm_nh_policy_dump[] = {
 	[NHA_GROUPS]		= { .type = NLA_FLAG },
 	[NHA_MASTER]		= { .type = NLA_U32 },
 	[NHA_FDB]		= { .type = NLA_FLAG },
-	[NHA_OP_FLAGS]		= NLA_POLICY_BITFIELD32(NHA_OP_FLAG_DUMP_STATS),
+	[NHA_OP_FLAGS]		= NLA_POLICY_BITFIELD32(NHA_OP_FLAG_DUMP_STATS |
+							NHA_OP_FLAG_DUMP_HW_STATS),
 };
 
 static const struct nla_policy rtm_nh_res_policy_new[] = {
@@ -685,8 +687,95 @@ static void nh_grp_entry_stats_read(struct nh_grp_entry *nhge,
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
@@ -698,10 +787,16 @@ static int nla_put_nh_group_stats_entry(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	if (nla_put_u32(skb, NHA_GROUP_STATS_ENTRY_ID, nhge->nh->id) ||
-	    nla_put_u64_64bit(skb, NHA_GROUP_STATS_ENTRY_PACKETS, stats.packets,
+	    nla_put_u64_64bit(skb, NHA_GROUP_STATS_ENTRY_PACKETS,
+			      stats.packets + nhge->packets_hw,
 			      NHA_GROUP_STATS_ENTRY_PAD))
 		goto nla_put_failure;
 
+	if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS &&
+	    nla_put_u64_64bit(skb, NHA_GROUP_STATS_ENTRY_PACKETS_HW,
+			      nhge->packets_hw, NHA_GROUP_STATS_ENTRY_PAD))
+		goto nla_put_failure;
+
 	nla_nest_end(skb, nest);
 	return 0;
 
@@ -710,26 +805,45 @@ static int nla_put_nh_group_stats_entry(struct sk_buff *skb,
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
+		goto nla_put_failure;
+
+	if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS &&
+	    nhg->hw_stats) {
+		err = nh_grp_hw_stats_update(nh, &hw_stats_used);
+		if (err)
+			goto hw_stats_update_fail;
+
+		if (nla_put_u32(skb, NHA_HW_STATS_USED, hw_stats_used))
+			goto nla_put_failure;
+	}
+
 	nest = nla_nest_start(skb, NHA_GROUP_STATS);
 	if (!nest)
 		return -EMSGSIZE;
 
 	for (i = 0; i < nhg->num_nh; i++)
-		if (nla_put_nh_group_stats_entry(skb, &nhg->nh_entries[i]))
+		if (nla_put_nh_group_stats_entry(skb, &nhg->nh_entries[i],
+						 op_flags))
 			goto nla_put_failure;
 
 	nla_nest_end(skb, nest);
 	return 0;
 
 nla_put_failure:
+	err = -EMSGSIZE;
+hw_stats_update_fail:
 	nla_nest_cancel(skb, nest);
-	return -EMSGSIZE;
+	return err;
 }
 
 static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
@@ -766,7 +880,7 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 
 	if (op_flags & NHA_OP_FLAG_DUMP_STATS &&
 	    (nla_put_u32(skb, NHA_HW_STATS_ENABLE, nhg->hw_stats) ||
-	     nla_put_nh_group_stats(skb, nh)))
+	     nla_put_nh_group_stats(skb, nh, op_flags)))
 		goto nla_put_failure;
 
 	return 0;
-- 
2.43.0


