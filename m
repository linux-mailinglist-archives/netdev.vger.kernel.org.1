Return-Path: <netdev+bounces-77226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4196A870BE2
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA6C1C2248E
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ED110A05;
	Mon,  4 Mar 2024 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qK1T79vp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C291101E3
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585561; cv=fail; b=jyKPn9KggcHowD8d5GIoHv3ns9DiEkjMk1+rOQYk+6IjNHzIzXBwAweZVYRWjIUq2knfDIiR4qQRAQxMFenaW1b/ftPLcWapG2KsMQxvrIozjAoarAVgvqbVEOXIlpNJ0CK8iCH43aUUYLqfMxlbYA7BRQBwekAIIeUnw8E/D9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585561; c=relaxed/simple;
	bh=rkkp4+zdWnSg2tJpQ2Z2nQ7g6FH30cs7dDXFwBiKyNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDlc4GwM1IZoIs3cPM3aYUhZ3/qlXUnj0yZdLPi4JfBRQdbdRPKjJBSEPSKXeCX8CKbbeMI2y0xno1XtKFQOYsNMnhhq636NAWrNQzcNcakJyflCHHETXiAbxZ2NIGeomyWWn/DtQPGGVpOh95xAiKFerSaPXzjw0l1qc89xqww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qK1T79vp; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZseLONbxWRCrwHJIvGmSR7+5foVjOd+8wME/CRyj60sm/oEnvsHAezE0YTLbSua1/Ru1GSlgV1waXhyKUio9r6/Wd97LlR7aqaYZTIKsB2syNjoAevZFYGwRnWB7hrJo6CjgKLULZEmv7UVq9mRSyr3+ff79c8I15EBq7NMdq2aBXImXIpokm2g1IpxDl6zFLaLVJPE5d7nSoMQAsa8/NuuFZQDhldsWTGhHJxsMkbkQoV6H5kSbuiOBNqCBgrkUd9geGhqiwQTdxrKpf5j1PxWnnRtqBiEEOkaZjuH/WV5UXv93LTQziKPiNQ/tyXu2Y++OzoKwlZA2fqRCTvOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9SR15RXf6Uz+g2kzimo6ZbabEgjtQ8q09YbmSD9t5o=;
 b=YcG2kmg+Hl2Wmu/+SUpuAkR17H+X6+ehiR+YfywevqT0CmqEu49UKEHiBCuf/2Jy7tM8qI2qTKWgFhB0/Z4+/uf0AWOizWsBqfCKOxqGeGz1A7pgjACAzY4Y4IZfnhohRRCvX8Xo/eQKm7g8PLWYw2QCu/nU+gv9eY256Oz7meOnKLR2Y7AMLeNc7AfyM/Zm+/EMKwucvOU0b9EWPkZ0QN/n6EbNB7iIzQEL0eyv6i+y5c5Z5krFTi3j1tmcyzfTCA5P/+6aqQzCV2p5kW0plo1TztdzR2Mq4RjqJAp/CTKt4osjGrBmt0eUpTEy5wXHtHZbLV1sxPb3yMZYIuwUVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9SR15RXf6Uz+g2kzimo6ZbabEgjtQ8q09YbmSD9t5o=;
 b=qK1T79vpdJw1/pu7vnhShKty2lFHsDGeMEQGaKm26PHKvgGhgue/kTUPOpxLtkmr+1wISW5gfibH8WYV4QZnYs/hq7KuLOFnxApX8aJBuN5Zn/kv4P5Oru8YWluGlm56175eXvmpzLCwvtombzL2eU1C4N+kPHCxFT3zOt/wZrb0jL5f0VfgH2HMB/4078Wtv0hRC5ix1U51It4/HJk8cvnKRoz5qqxUnEL4Kcd2feVq3JAqCfYxo1Ulj2RwZo4Yxh7LUy017+G7dGKjAOQmFTY08CFu1wMLMoh/AERHx9pQI9m7fetZjPSXx/vaUDdReJj8/olQXvDLHR1qar20Wg==
Received: from DS7PR03CA0248.namprd03.prod.outlook.com (2603:10b6:5:3b3::13)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 20:52:36 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::cb) by DS7PR03CA0248.outlook.office365.com
 (2603:10b6:5:3b3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 20:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 20:52:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 12:52:20 -0800
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 12:52:15 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>, Kees Cook <keescook@chromium.org>
Subject: [PATCH net-next v3 7/7] net: nexthop: Expose nexthop group HW stats to user space
Date: Mon, 4 Mar 2024 21:51:20 +0100
Message-ID: <40715b7655ddd9aa72e17bca1439c84ffa7dea05.1709560395.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 609de226-4d6a-48d8-0a71-08dc3c8d059f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X7akrbXSpqmeSPS2VoHYvtjkADHD0AM3+VVz8CeGSnKNE9fpnFDFOph49w3iGkZR+AK3QUKJDGJyNYI/3g0a2CZmUSByGX55lVGeoSUMZJNbHWTU6qz6qyYZODYDhYZMVzLVpgwCyvBg6k6sDQIk223E7m9ICgxYI10KP7FxOVr3c80O2MFSGExUtZ+TSV4JNJDbJhRuIo+2/ZVbN4ifRhK9ctsuKqPAdXxwDuDq/TtBbM5zx2GyDfgRplQj0yCOCenoAwSlMCIP4+lPomYVNJP7F9bySQ69imchKoQmS6YJ+ygIupxmVkDXmeQMqThPpx0yNeEPZpqvxPjxJyN+DBtVs39FW6EXAkqK6l9DLyUgQujHWrfPmExJUxukR552UYmmXLEH7um496Brs7L6OrDwWElwSK/anawfEipAc/J+KRmRAnyRm4yOCitgxJ+ecWbAFMK9puH3ZVXFHD9DMpkl6J7YqQgU9FKu2SooOHLWp8FjTfpkInATdePsv12ABvbp2hVL3eu2zHXKOD4EbsNisnHZBiKZEkQ8ENVasuxsRpw7EQjKiRTzDAP/gLB6Mhn443BXLVooVXjIJoD7yVTnvBE18ekgBqpksTB0uiE6CHv8Tmk9wPcFXJDipqhPalux1xc469+7IHklpr68d10UMIFWom6bnHdnBybScG+pyGLl/BEgW9PTl4HDgmx8wiItFXJWzxOv6fi27e8dTQ1DCCjVNgSAYpRxjCzGlQ7gQFKfE9hJr/D5TAAqyluU
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:52:36.0569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 609de226-4d6a-48d8-0a71-08dc3c8d059f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706

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
Reviewed-by: David Ahern <dsahern@kernel.org>
---

Notes:
    v2:
    - Use uint to encode NHA_GROUP_STATS_ENTRY_PACKETS_HW
    - Do not cancel outside of nesting in nla_put_nh_group_stats()

 include/net/nexthop.h        |  18 +++++
 include/uapi/linux/nexthop.h |   9 +++
 net/ipv4/nexthop.c           | 130 ++++++++++++++++++++++++++++++++---
 3 files changed, 149 insertions(+), 8 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 1ba6d3668518..7ec9cc80f11c 100644
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
index acd27bcdecc5..fbf7f268038c 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -26,7 +26,8 @@ static void remove_nexthop(struct net *net, struct nexthop *nh,
 #define NH_DEV_HASHBITS  8
 #define NH_DEV_HASHSIZE (1U << NH_DEV_HASHBITS)
 
-#define NHA_OP_FLAGS_DUMP_ALL (NHA_OP_FLAG_DUMP_STATS)
+#define NHA_OP_FLAGS_DUMP_ALL (NHA_OP_FLAG_DUMP_STATS |		\
+			       NHA_OP_FLAG_DUMP_HW_STATS)
 
 static const struct nla_policy rtm_nh_policy_new[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
@@ -700,8 +701,95 @@ static void nh_grp_entry_stats_read(struct nh_grp_entry *nhge,
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
 	struct nlattr *nest;
 	u64 packets;
@@ -713,7 +801,13 @@ static int nla_put_nh_group_stats_entry(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	if (nla_put_u32(skb, NHA_GROUP_STATS_ENTRY_ID, nhge->nh->id) ||
-	    nla_put_uint(skb, NHA_GROUP_STATS_ENTRY_PACKETS, packets))
+	    nla_put_uint(skb, NHA_GROUP_STATS_ENTRY_PACKETS,
+			 packets + nhge->packets_hw))
+		goto nla_put_failure;
+
+	if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS &&
+	    nla_put_uint(skb, NHA_GROUP_STATS_ENTRY_PACKETS_HW,
+			 nhge->packets_hw))
 		goto nla_put_failure;
 
 	nla_nest_end(skb, nest);
@@ -724,18 +818,35 @@ static int nla_put_nh_group_stats_entry(struct sk_buff *skb,
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
@@ -743,7 +854,10 @@ static int nla_put_nh_group_stats(struct sk_buff *skb, struct nexthop *nh)
 
 cancel_out:
 	nla_nest_cancel(skb, nest);
-	return -EMSGSIZE;
+err_out:
+	err = -EMSGSIZE;
+out:
+	return err;
 }
 
 static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
@@ -780,7 +894,7 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 
 	if (op_flags & NHA_OP_FLAG_DUMP_STATS &&
 	    (nla_put_u32(skb, NHA_HW_STATS_ENABLE, nhg->hw_stats) ||
-	     nla_put_nh_group_stats(skb, nh)))
+	     nla_put_nh_group_stats(skb, nh, op_flags)))
 		goto nla_put_failure;
 
 	return 0;
-- 
2.43.0


