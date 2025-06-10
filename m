Return-Path: <netdev+bounces-195949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DC8AD2DEB
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2421663DE
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF0A278772;
	Tue, 10 Jun 2025 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aBad4O7f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB55613790B
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749536817; cv=fail; b=ICHP4woaHkc3cDLMp3GwWTo8ay6B3AUEPAuObcrxbCAw9yHWYPJ9nQRUztBJewJ7ZThtzY3EXCrluLBz3vTebo0KvFvtwlnruv8o2Hmi8drZXkTVBaH3WWAfSX8FOunvs6rIJXTkcjD0lqoBXFJ6SBXmV3r2UYxWyiIJWbHNqDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749536817; c=relaxed/simple;
	bh=YVl1UfXMzHE/+oFP0J6ZYkB3RkGd4YOTo3Lc7igbrNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIb7BJpKCgZ30OIqCGCibry2O5MZ83BIxm29bZSmqKpg0/XAR4eT+NlFRrPQTVd7nkFOR4oLzoEkmK7i/3V5qSLvj0DnbnIxpYtrrOlxgKaYc2/v16Udm66fhton0EPwF8MwSS4BWzmyYZ/2k+jmbN9She4MKVE+ZnYtDv9mano=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aBad4O7f; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4xGGcMoWDG3D64rJ3KjG9E7OWAKV2uecjohYz//LGda8ggOSQoyGz/wtXrosXEXlqSU+twiVxgoComEtvDikLfKh6mKiHbHueNqE9H3ao9NFUZDcUd5dG3J+mLV1iSGYVODb2M/viZLNjETqJTqee6AKEOieb5KL4PIaoPnWA3bfqDUBjOVFzg5j+hVSNC1F+3kEtkONUbEhSV+kCvAssij0uRpwSb8Blwnp+8ayEVJdrtelUanItH/R157eR9DSJyU8+bfIYNa+3gxM60cl455KPrJmmUVCF4cTsOFvjhHNc+c6cgldBpCUJJbg6ww5eK9P4FYyP1C56aWbzWgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0XX+Yl75f7iqmRQ4wwaT32PiIP8NzlglNg87kFCexA=;
 b=IMr6GfehLn0lqFHVUzELOLAx3auXjyreBBDeRJ7aj5lu7HjxIzu9CWl7zI7hDbodmKGHDPb6WDsvRgXcdnwNZ/Q3XfzbNUiIv+jGweRcsE1DlfErpO9Yal9dtiIt25SM/qKF2Ui/SGNIAm2JM6sxITNFKOFr3dtcSaph5P+DI75sLTVXVh2oQIh+sBGxmi6+BYR5x4CJK8Ok2svWxyN62Ovv8h1z6ah4iMT4Yit2+RHpIJ6RqfmkglRNvQsFkwfUn6ghRamSW1KheDdX97uBSKfyPKFxmH6rIJSxSwriYXp6GlokznOJWrgaXyMEcrcOJOgxrkp8O0T/zvH9SbZH3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0XX+Yl75f7iqmRQ4wwaT32PiIP8NzlglNg87kFCexA=;
 b=aBad4O7fjDNLYixlfJOy1WykDh6CqWCj4ATlBR47dF0DNIcCHOtDE0Vsglab+V0F4inX4tQDSf7oiAGyBO4jWr9ogcJ3RRRkRjY6mpd2kOmfJEQuUfbA9ABQj37jLFXtY06E0EdufW5R9egkZu8+wUVMikTVSDY50uMMm5r1Rq+BvaA5ISjuzl+Nn0MzIkaYJyCEErilZWOhJ9KV0ee2RRW86gK6+Ttg/NuuzpMnj/eXeooaeVORiM0he5XJzO7owxrhdwgS9cIfHmFQt9OuUFHVgqrQGbWr55kxcf1clixnGeTIm/v6TvpEJAcbxe2SDXCGqx6HB2h/aKzh0PoThw==
Received: from SA9PR13CA0154.namprd13.prod.outlook.com (2603:10b6:806:28::9)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Tue, 10 Jun
 2025 06:26:51 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::82) by SA9PR13CA0154.outlook.office365.com
 (2603:10b6:806:28::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Tue,
 10 Jun 2025 06:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 06:26:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 23:26:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 9 Jun 2025 23:26:37 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 9 Jun 2025 23:26:33 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>, Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	<dev@openvswitch.org>, <linux-rt-devel@lists.linux.dev>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net 1/3] Revert "openvswitch: Move ovs_frag_data_storage into the struct ovs_pcpu_storage"
Date: Tue, 10 Jun 2025 09:26:29 +0300
Message-ID: <20250610062631.1645885-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250610062631.1645885-1-gal@nvidia.com>
References: <20250610062631.1645885-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d19c9ee-0f26-4e5d-c6ea-08dda7e7c93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lAiWhu3kx2YR/MCf3Fl3/Fg+iyJQBVpd3oakZboEwDWF5DAaD9YuwU4jjU6c?=
 =?us-ascii?Q?+RqWS7mls2CYeryNVLTDEQSFRe6UwddzqPZbbKDUTQ0X/XyQ64RFdxk7LNGS?=
 =?us-ascii?Q?tmhdSVCXnZl1O/JZ3wXuFp5xvV3l28lcBEUAoP8gtq/tD7xHRtz275c+vYlg?=
 =?us-ascii?Q?iz9bNmphusl9JloyYIK+FKefQ6el4fy/PqD3KE7vkXah3etXcPpN4lvG5NPA?=
 =?us-ascii?Q?ApVngmgGlPATrYfMDe630qNje8ir5NWgjKdHF+GPMWcgC1ikMUQHePWDQIxz?=
 =?us-ascii?Q?tgJm6lKbK1XFN8jlu0x/BLvt9HUgd5x8uZrGXMB2Ov7Op3N/vKvAGY+T8K6U?=
 =?us-ascii?Q?a7gHLKy108TeHImY8VD90L0DkmafyQxCWK0TDoAtf3J8sEn8H2SsG1OZJTXt?=
 =?us-ascii?Q?kcngMh59Rat1+qTHas3kpN+M5dS29WWIt93Zlt+HGil3HYk8le2WHUmIgxu9?=
 =?us-ascii?Q?086DczEwUBk604c6skns1oVK8e/7PZv1wXxdQDh8kNnjx9Hsl+Sms960VwT6?=
 =?us-ascii?Q?VxJrEmedy+A0E6wqH4jmK5Pplajjty6WEXtyw4Yk9BQl4RqDRCWiXRPZ3Cxr?=
 =?us-ascii?Q?56RHvohNIUo/cv8Px4wsOi5TghQ0Ad0YEdjh4B5nvxD/xFHGgyFau326c3Lm?=
 =?us-ascii?Q?utYjRm84vmRLaXHXE1MF+3VXmIR8MlwL0aRgWoQmhr7UWVgT82D2rWFyD6Ff?=
 =?us-ascii?Q?wEZad0RYXSK7f46KgaFUFzSRjCeamKo3z1O0oAkG2lBN40W0C8HplrYwhSq0?=
 =?us-ascii?Q?cS+fCqK+nHf/0IOWBIsmNvHLP5Kt8+QC+LqL4MsirZo0xtjqjKx6KKWUA9CB?=
 =?us-ascii?Q?gXeMLctAFsJEbDjwDu1XsgHgxjm/9EXEuFSBLmmfEo39MDN41wx8O3IEqNuS?=
 =?us-ascii?Q?0M+dvhB9zauj2d6QYmLWNFO1nDsfp+38aNehxqHmWhNs4Od0DrgOmFeKo71/?=
 =?us-ascii?Q?k8ISAlXY4yzmDxs/7OTopqz87baGhomRLHMIsTi1MlE/zkY2zV7eSjNZZ7Wx?=
 =?us-ascii?Q?HUnWoTPQbXSfn2G/Xo/oIgESYMPQFaewHak6faFV3mNyjuObliKRhmD358ut?=
 =?us-ascii?Q?xglM9O3qSQw/w679lVRpnALzDm4G94lxBIQaTiObJ1gWG64TT8Kp8f4PfpCo?=
 =?us-ascii?Q?Exw+hdbI6ZJKn2Kdu5uU4QZOqNlOvGSaBLMrvaQe4NHDpfLmwt+N6Ha2DNZJ?=
 =?us-ascii?Q?LmCm5rShaVCc3S33m0QfN6BSdM4ckq/kncD4J1cKTPdsZ/saq7fkcFgZ75/+?=
 =?us-ascii?Q?B9Ko6Ht42KVm5v265xlFA3NSgXmWseBM+UGNv9wmqJSsB/86UrhSuv5s07XI?=
 =?us-ascii?Q?A5fgv93rwx2wgeOhvoZAKGtXtgNxcpFFg7EFqQQ0DLtnqhkZNJXwzqG8DOWo?=
 =?us-ascii?Q?3rCD5rx5hnQScPhaZPZR1tllG9ziaP/I098L+7WD/L2kjmmCI8FSTtH3do87?=
 =?us-ascii?Q?Xq+CWmDBW25F8LJeKpv1sorrynCzdE3j1ZbvlW5zgtiHQQEEoefSlKLLSq1x?=
 =?us-ascii?Q?iqz1IUba2VNjUkkFKzDa/cCoBHFkLcJklm8F?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 06:26:51.0545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d19c9ee-0f26-4e5d-c6ea-08dda7e7c93b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344

This reverts commit 3af4cdd67f32529c177b885d4ca491710e961928.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/openvswitch/actions.c  | 20 ++++++++++++++++++--
 net/openvswitch/datapath.h | 16 ----------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index e7269a3eec79..435725c27a55 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -39,6 +39,22 @@
 #include "flow_netlink.h"
 #include "openvswitch_trace.h"
 
+#define MAX_L2_LEN	(VLAN_ETH_HLEN + 3 * MPLS_HLEN)
+struct ovs_frag_data {
+	unsigned long dst;
+	struct vport *vport;
+	struct ovs_skb_cb cb;
+	__be16 inner_protocol;
+	u16 network_offset;	/* valid only for MPLS */
+	u16 vlan_tci;
+	__be16 vlan_proto;
+	unsigned int l2_len;
+	u8 mac_proto;
+	u8 l2_data[MAX_L2_LEN];
+};
+
+static DEFINE_PER_CPU(struct ovs_frag_data, ovs_frag_data_storage);
+
 DEFINE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage) = {
 	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
 };
@@ -755,7 +771,7 @@ static int set_sctp(struct sk_buff *skb, struct sw_flow_key *flow_key,
 static int ovs_vport_output(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
-	struct ovs_frag_data *data = this_cpu_ptr(&ovs_pcpu_storage.frag_data);
+	struct ovs_frag_data *data = this_cpu_ptr(&ovs_frag_data_storage);
 	struct vport *vport = data->vport;
 
 	if (skb_cow_head(skb, data->l2_len) < 0) {
@@ -807,7 +823,7 @@ static void prepare_frag(struct vport *vport, struct sk_buff *skb,
 	unsigned int hlen = skb_network_offset(skb);
 	struct ovs_frag_data *data;
 
-	data = this_cpu_ptr(&ovs_pcpu_storage.frag_data);
+	data = this_cpu_ptr(&ovs_frag_data_storage);
 	data->dst = skb->_skb_refdst;
 	data->vport = vport;
 	data->cb = *OVS_CB(skb);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 1b5348b0f559..4a665c3cfa90 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -13,7 +13,6 @@
 #include <linux/skbuff.h>
 #include <linux/u64_stats_sync.h>
 #include <net/ip_tunnels.h>
-#include <net/mpls.h>
 
 #include "conntrack.h"
 #include "flow.h"
@@ -174,20 +173,6 @@ struct ovs_net {
 	bool xt_label;
 };
 
-#define MAX_L2_LEN	(VLAN_ETH_HLEN + 3 * MPLS_HLEN)
-struct ovs_frag_data {
-	unsigned long dst;
-	struct vport *vport;
-	struct ovs_skb_cb cb;
-	__be16 inner_protocol;
-	u16 network_offset;	/* valid only for MPLS */
-	u16 vlan_tci;
-	__be16 vlan_proto;
-	unsigned int l2_len;
-	u8 mac_proto;
-	u8 l2_data[MAX_L2_LEN];
-};
-
 struct deferred_action {
 	struct sk_buff *skb;
 	const struct nlattr *actions;
@@ -215,7 +200,6 @@ struct action_flow_keys {
 struct ovs_pcpu_storage {
 	struct action_fifo action_fifos;
 	struct action_flow_keys flow_keys;
-	struct ovs_frag_data frag_data;
 	int exec_level;
 	struct task_struct *owner;
 	local_lock_t bh_lock;
-- 
2.40.1


