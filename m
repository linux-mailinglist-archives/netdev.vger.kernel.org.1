Return-Path: <netdev+bounces-77907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BC68736E8
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A41B216ED
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B401272A4;
	Wed,  6 Mar 2024 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cKZGtI8U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197698665F
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729483; cv=fail; b=BCuOivJPiFuH9Bphtj+QbIL8kpX33ppM0L9anI7XOvzHCfWVr6AyJ8cNZ68MI+GUMEt2Qh0gOLEzbT5EEYdy816XI0wG7tkLHsAwIJq2+CGI50jmZW/ytLJ0uQTXMHxVv3G7LSS6rj72CGU7PymriCC+nqPg5NuHKBA2YXJl0aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729483; c=relaxed/simple;
	bh=gx3mjC4x7WskcRj7nLTeTYt0xx3R/zmfqX/4inP4pxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hu6Et32KMyMSm6Udl6polQvrESmh2DfGoSM26IiimpdE+YN/s6rMcVxQvdMenaSwdQbFJUmuBL4OSg3JoX2UWI37s5BeogcCXVasFQq5XS0AyMwy7nykvPorAZavPio7RXlGgIgKa2v5uVj62OUJ4M7y0HAHeNenlFQ4+T+Yqnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cKZGtI8U; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZtrooDlgzZD9Dn3+HgD1yMapH6u8MPOHi+FeDy93npYIG4fbWS69D11k6sxKLW2/SsyhXKncUmQ9zXTFheHWrOgEgygrZjJZqlAw48awDAHDNxPErQ1mBS3EwB+hig3OrdeNo4HCaisSYLcLdFQUyKw2iN4EOFQ0zM7iSX2YzabPBR3X5XXaUZrjjqUv0v0GZgLr9drlP5Zgt1Y8r8f2KOtC9Mu4QzL/+jTUFeK9GZXzkyka5LNXwXCskYmR7plirnu6kt8WzNmolAejUqh1F+A/FxhFsZe0Px7UvADB2G5vBvIAOIheQQXGaOz7MxmdnhRYRFa1trOPsh+2A6+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tv0xZTFTn0ndA1P0o2P6qrOU8MF9n9BHSToWb2O9OdE=;
 b=ALiOtqYLzCacrZGeIrSKNgHA0VLGfNud6r6/OV0u2ZkhndjaiTCSJgrqs8G1H96b7G+Qy7s99OWyFei2z3rSJjKAqyntONugznmc366hvFzbsA3Df4diHTEF3g3X3b3Pep4kTaecrrxQLUM0X1VnUAM5y5Z7cKiyRIJognUKiZzGOtTRBi/IPEqj+1spPabHJaCqei+DU97U7y1/bbfNthQJIbyeSuO75ItbT9VWIB5SGw3LMg9iUEGkkk5KQpTu1j5raKl5mqXliE2sP7CieDtdgGwOBCflcIJfshyk/sw0PIzT/q8hDAsY8w1weDGtyNp9l0axfWQQR3K/4huQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv0xZTFTn0ndA1P0o2P6qrOU8MF9n9BHSToWb2O9OdE=;
 b=cKZGtI8UJ4gQyoojIE+rD84fjzCygzTBezDnkAS6AWK6zlQxOpK1A7fYM/E0wvUFa5lQKsw6xvH/J9yfZYbCdfg5xdOzzLeK8kXZsTqwk0tyD7bzQ/hsVBdPcCBNpXc3o3Us+JIOPj2VuhZ7mMTViXU75/yxPiENoM5uLeJ51kItbcZp8D46eg3ngAwCSrcNAmKbr0FXfYfvq1nrqYO38s1CmE6mxGNjXk224tPk74OjPfKh+3aQVZ/YgApOyN1DjyGJALYoldJqvHeJOyr/PWgwDh4zEGbzSy6VfAq3EE+kvzoUe1W5ee4sC+ZUPWLMh2u8WOzaMdknL/RKWDzN5g==
Received: from MWH0EPF00056D12.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:15) by SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.41; Wed, 6 Mar
 2024 12:51:19 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2a01:111:f403:c91d::) by MWH0EPF00056D12.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.3 via Frontend
 Transport; Wed, 6 Mar 2024 12:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 12:51:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 04:50:40 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 04:50:34 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>, Kees Cook <keescook@chromium.org>
Subject: [PATCH net-next v4 7/7] net: nexthop: Expose nexthop group HW stats to user space
Date: Wed, 6 Mar 2024 13:49:21 +0100
Message-ID: <32eba1b760d3a09258ff9189d4d6cabdef0f3607.1709727981.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 4237a9aa-2532-4b71-f69a-08dc3ddc1e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IE0i8YZE7OgvvnmlxoGkoqfco6QKsGBgKSVDmH9JAug2oaULePhUfCi26jf6BAOY8D+iid1hruccbq6vRshOqV96QPl2Rkbln/UYAsFvAY+Q6IBtffebVhXNtH07iu7NjzuKL2ALuPZEJWOgSYxhOWOp2z+3Ip+sRJDXrig4wfhwiH7/AV3Upd2a8w6CiUrs3PfqpBxY8//+aL/qwzqxIlc9aXwm+DqnQ3gkXJugs8eHgtw0LWvE3RCdpj+56lYX2MySGu+0ulE+uTBIE9fbAXwlK3BNB/XvDONa96c5lcrAEyjwy7thoE33aBuOZNe8hrYqTy6ccMmzq9sVdUC54s7QcyD4whnRkmIn0EyBENy5ygbz+4K5gdYRmn8EVE+JwHflk6YtuXAiJUU/jCib50FinDGXt7jhncV+JFALTRI7IGESkH18qPcy53NJgoQTKDCyvKQDihBGmmC8jdBrFZ0Gd1XA0l+lqW56P1B2XnOq4qppGsvyV5iT0eg7f9iy05O06gGdJ0852tMFoc1CLDNN8in6FSo2HFK74QpR/ABg0HwQtw3Ie724luhgmRrCC4p4FR3H6/UZFrA/QxHVwdJfBsT5XMlon6RQ5lzGWl4uyXYFMzKPjaNdxE0Ob+UwqyrhQZoUvVIoVODaiwHyhHt7U2BXeZ4f6eim56Oq8rJJdb8YpKXf1t31acu/xTf5hZA8iSMM0QczcfbDvmBeHL1k/6cBv+75JrJ5y1wb6g4dZUJVsItwLwHyV3UB2qiF
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:51:18.6144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4237a9aa-2532-4b71-f69a-08dc3ddc1e1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059

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
index e75b1aae5a81..e34466751d7b 100644
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


