Return-Path: <netdev+bounces-195950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FE2AD2DEC
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B2A189207D
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 06:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6976C278772;
	Tue, 10 Jun 2025 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rMdwfnua"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B19221D88
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749536823; cv=fail; b=KLlMccOaPdqsRZd+AtcbuqgN4Mo953H5ngNp2o5V/XIIxPzXYi7PbrF9t1+ijS3hcJqhal+V4TDK/pFRfUHfyGMXOUnlJmc9kP/fZHqFx3ypo2NC8YHaRSEOJDTyQykHs7J0mA2AcrE+hFfVG6wabI8JNES/d4JvjQgouNHXc5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749536823; c=relaxed/simple;
	bh=3xAXrFygCE52CezTCXwcdTcl/lz0s9FIp+VBuWxpyKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlgn1RI3uBVuAUdgNrgMxRstbYmcC8mt+p7z96A5uyY2UFt3nIcTYOGWuMsJErhdM63UzrRuXjoxUZoUf6GjX9XQ9AWXrGGJlxAqarS4cqdh5hiRfvMI9+63ntmnmfLry+/Jko0k+GorZ8G2zsTNShLgkD5YV9cfGEQhAgG4eCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rMdwfnua; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZC/YXh55ixAjiL5jwloFng2Cf+3x6FElcM/M1Id/p6Upn2YXq7UeBz2XisCtQZ39Q5k0+Y3YepQvrNzu1KrdCmSZHle7OQB4eEXqk1hQIWUDQOSJJ5jTDC+x7tXzRmItXtuEh5nqbYEa63HqvxJo3OZhAUqR+f7fOzxicRcRlQ7l+JO0CwQr24WQ+ipECikASkOohJACM6ifipgDu+0M7UhqHACyt+IfQQmiOpuPeREMjEutVwghTlFe/B3CvnlMUKfRaPHCP86MYf8Fb7WiVYEgb/gIqSyY2qg2/Foq57akvGQGgCp11mYp4jqtqaru1+Yx/L6WzHSvEiPJbQutWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBXmlsZGhpJtc24kEoISW6dFuhwuXDoCVer6Un6oh6k=;
 b=Zo6oBDhJNjsW0wFDjq4J+JpQ6M4SPkMgOuuV/eXZLQK2RcO8ZjJiq4DTZkd+wZHA67yb+1TyjSE9mkzeJLKBui/APTEXZovQkqv7kKYHNzZlk7ntUEJNeKHmeUV2JyC1bq3tzAtQb9dmeFtAtTMVGgmkPf6UAn+f0g9iYTkBIhE//CmrJoO/KRVUIHo6WSeFejvf6qqWosbavWsNyWobT5ZEu4WJ52QT0cYHDxhjmpX6vvAe7WwiGT3bqHMD405KFAYeQj4h3HcLyCw0aKc8K5VKQGsazH2+2Pp4Vz2c0BV2vyuOfy+lU+i6i4mHzDkr4odE2Cqg8iNWN8e66Vnc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBXmlsZGhpJtc24kEoISW6dFuhwuXDoCVer6Un6oh6k=;
 b=rMdwfnuaYdnG5IPm2Sdj7zOpVued4kBIWISbCT6NhRc1LYaP8nUhHE+Ho0XNRFZuWQ+HCbg9l+jY1OJMT0vTfHHFwZ2s2uzLQdt+7vDHlcczRSG6s3suBiB7+HRfzC03QpNMA0wJoX7qvE50bcSNcOtXH1WacE8o9CHB/9ol9yq6KIJkVx5IGIoXyuWqyboDxWPwzPYzHeBWYqe+wPvVAIItWuoIdF40qqb6uGnG0MeMQTALQSmstuZP/ZWKrppTKj4XdpbabDcuv2vSdSs21LXPRgmy4DG2FTOVgbNVvJgwyA/cSVQLRYH5nkQafwRH75KLau6hpdgUDScJV50KDg==
Received: from BL1P223CA0039.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::10)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Tue, 10 Jun
 2025 06:26:55 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:5b6:cafe::a7) by BL1P223CA0039.outlook.office365.com
 (2603:10b6:208:5b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 06:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 06:26:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 23:26:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 9 Jun 2025 23:26:41 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 9 Jun 2025 23:26:38 -0700
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
Subject: [PATCH net 2/3] Revert "openvswitch: Use nested-BH locking for ovs_pcpu_storage"
Date: Tue, 10 Jun 2025 09:26:30 +0300
Message-ID: <20250610062631.1645885-3-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 8697089e-64c1-4f0d-379a-08dda7e7cb8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n9FdupJ6oxz3JeXXxli1GlA4KrXok+XOJkKolMl45h2m0pyFs10Qs72elnHv?=
 =?us-ascii?Q?LDEf2Y7Jqc7jub3KieCPCdsIBmtY7m132mHwPzAWxbWygIziLWNN4qr1qpsy?=
 =?us-ascii?Q?DlwgsgU3kDXDwqvMn0wFVaOv1PUASsqEID9zFGOd0R8ucBfsBDKDT/CriMeB?=
 =?us-ascii?Q?vo2/5SOnHSelzvmaZnwhVyo2WvDBjWjthKyI74yHwnxtPwmjD1WtooLvefN6?=
 =?us-ascii?Q?PMwxQHH4qhu6GCO1rt3v9Kp8s/2MaqFglNKlt5azAPNMAaGw05O927aYy2W8?=
 =?us-ascii?Q?zTFZ+UjOhtuMgPkFH5pmJxU1rXekLXnLGu/DfcHRNFMtHrfteHkUazO7EXbe?=
 =?us-ascii?Q?f5+NwvkxldO/ntMYJuvoEXzlG+iaLO4bevZU/q9zGzHFO/45J71/eusd3BXU?=
 =?us-ascii?Q?jboVSNH3yxDxOL35c01GCvL6KCFxqZm6MCMUlypmGjOCcL9u54IvOI56HpON?=
 =?us-ascii?Q?SxNtviXIIngkSyFkhGI560h9z5wPJvU21/H7K/BGWpd6QD2nf3LgUxY5w/9X?=
 =?us-ascii?Q?4aKfqUq7S5SasPyPMdDfcfvE/9oV3XgGXBbutRoUd61vB+h+nCzlYjXyovkZ?=
 =?us-ascii?Q?E/KOtV1J6qBpWKGVECrfkS55NhEkV+ssIHuTXVwFjSic+ke2fm+JvwDpnGmd?=
 =?us-ascii?Q?YWaIGh2IdOTngmgnXFuniZUmQvfMVl5r0abcT9K5UrmZZENfRQfjNrVR0/cf?=
 =?us-ascii?Q?/0RAbpitjhUxEdtgV0TYkkp6rzYk9Wo19BWNwQ8117YIjJXJw+wj8Ij5pET5?=
 =?us-ascii?Q?GtOo6lBKzT27lcMboFmULKFQ5qXWt0gTtXi/7AR9oCcOtBi1qaFWmqt/7MF0?=
 =?us-ascii?Q?2yeKOvqDO4ZEPOL1OpYpKh7TRTjABLbelqTR0Q1m6OQWB7dzH65MSYbU+2UH?=
 =?us-ascii?Q?J0/iPm7slpq76UX3XvOX4Uyp/GFQu0sqRyJN2E7Ve1+UJtwCdc/qK64ei3X1?=
 =?us-ascii?Q?INbOMp8S0YaabYz80Y3VP9MY/fP6xRR5YtJu/CASTyRB5rKS79OFxvDyR+GZ?=
 =?us-ascii?Q?6BipgTcBtSvqhOvI7z6K6UyAmWiIg714+lqsZPY4/ikUexlSwryAHo738Ajp?=
 =?us-ascii?Q?xIDExMmu17jkzYll1tByylRKgkFY7KgylERe04t3ccEMJtwgqKwEyP+wHP6I?=
 =?us-ascii?Q?DT5VtVWAjHODkVmeGSPR+htjjBbrb372pcT1sPWxzy/03irHNm1ElXzRaJWY?=
 =?us-ascii?Q?vSlc0yMP/tfrgkLvzUrfP9F97tQdKbRMyUthT17oZvhe9mg86C4f1yaLV7uu?=
 =?us-ascii?Q?VP0+G/C7bUmhBAL00bqeXxR1qi/BsK3bnyOBGcTWGNU7wTT7iTmUAXCYa2CT?=
 =?us-ascii?Q?eJf/NcY5Ogc/d+usZE9VvuRBQTgHhk5ZrpqYJAJDAUGBcGZBv4O88eh/5MKA?=
 =?us-ascii?Q?UVWDVOLGbH1RohaLcuBJURvAPnvA3SkF1hYQAGnv42Jsm14rVw5s/HuQs+R7?=
 =?us-ascii?Q?/d98fUSL5i7gthWvm+FnPsrZNw/eDxjJkVw+L6ZE+4Zzn9ChMcreJBrwmfuj?=
 =?us-ascii?Q?o6MLTk7z7aZ+dq8xM/7YTO/b0mtpz7DXO7Q+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 06:26:54.8846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8697089e-64c1-4f0d-379a-08dda7e7cb8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

This reverts commit 672318331b44753ab7bd8545558939c38b4c1132.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/openvswitch/actions.c  | 31 +++++++++++++++++++++++++++++--
 net/openvswitch/datapath.c | 24 ------------------------
 net/openvswitch/datapath.h | 33 ---------------------------------
 3 files changed, 29 insertions(+), 59 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 435725c27a55..7e4a8d41b9ed 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -39,6 +39,15 @@
 #include "flow_netlink.h"
 #include "openvswitch_trace.h"
 
+struct deferred_action {
+	struct sk_buff *skb;
+	const struct nlattr *actions;
+	int actions_len;
+
+	/* Store pkt_key clone when creating deferred action. */
+	struct sw_flow_key pkt_key;
+};
+
 #define MAX_L2_LEN	(VLAN_ETH_HLEN + 3 * MPLS_HLEN)
 struct ovs_frag_data {
 	unsigned long dst;
@@ -55,10 +64,28 @@ struct ovs_frag_data {
 
 static DEFINE_PER_CPU(struct ovs_frag_data, ovs_frag_data_storage);
 
-DEFINE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage) = {
-	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
+#define DEFERRED_ACTION_FIFO_SIZE 10
+#define OVS_RECURSION_LIMIT 5
+#define OVS_DEFERRED_ACTION_THRESHOLD (OVS_RECURSION_LIMIT - 2)
+struct action_fifo {
+	int head;
+	int tail;
+	/* Deferred action fifo queue storage. */
+	struct deferred_action fifo[DEFERRED_ACTION_FIFO_SIZE];
 };
 
+struct action_flow_keys {
+	struct sw_flow_key key[OVS_DEFERRED_ACTION_THRESHOLD];
+};
+
+struct ovs_pcpu_storage {
+	struct action_fifo action_fifos;
+	struct action_flow_keys flow_keys;
+	int exec_level;
+};
+
+static DEFINE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage);
+
 /* Make a clone of the 'key', using the pre-allocated percpu 'flow_keys'
  * space. Return NULL if out of key spaces.
  */
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 6a304ae2d959..aaa6277bb49c 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -244,13 +244,11 @@ void ovs_dp_detach_port(struct vport *p)
 /* Must be called with rcu_read_lock. */
 void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 {
-	struct ovs_pcpu_storage *ovs_pcpu = this_cpu_ptr(&ovs_pcpu_storage);
 	const struct vport *p = OVS_CB(skb)->input_vport;
 	struct datapath *dp = p->dp;
 	struct sw_flow *flow;
 	struct sw_flow_actions *sf_acts;
 	struct dp_stats_percpu *stats;
-	bool ovs_pcpu_locked = false;
 	u64 *stats_counter;
 	u32 n_mask_hit;
 	u32 n_cache_hit;
@@ -292,26 +290,10 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 
 	ovs_flow_stats_update(flow, key->tp.flags, skb);
 	sf_acts = rcu_dereference(flow->sf_acts);
-	/* This path can be invoked recursively: Use the current task to
-	 * identify recursive invocation - the lock must be acquired only once.
-	 * Even with disabled bottom halves this can be preempted on PREEMPT_RT.
-	 * Limit the locking to RT to avoid assigning `owner' if it can be
-	 * avoided.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && ovs_pcpu->owner != current) {
-		local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
-		ovs_pcpu->owner = current;
-		ovs_pcpu_locked = true;
-	}
-
 	error = ovs_execute_actions(dp, skb, sf_acts, key);
 	if (unlikely(error))
 		net_dbg_ratelimited("ovs: action execution error on datapath %s: %d\n",
 				    ovs_dp_name(dp), error);
-	if (ovs_pcpu_locked) {
-		ovs_pcpu->owner = NULL;
-		local_unlock_nested_bh(&ovs_pcpu_storage.bh_lock);
-	}
 
 	stats_counter = &stats->n_hit;
 
@@ -689,13 +671,7 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
 	sf_acts = rcu_dereference(flow->sf_acts);
 
 	local_bh_disable();
-	local_lock_nested_bh(&ovs_pcpu_storage.bh_lock);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		this_cpu_write(ovs_pcpu_storage.owner, current);
 	err = ovs_execute_actions(dp, packet, sf_acts, &flow->key);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		this_cpu_write(ovs_pcpu_storage.owner, NULL);
-	local_unlock_nested_bh(&ovs_pcpu_storage.bh_lock);
 	local_bh_enable();
 	rcu_read_unlock();
 
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 4a665c3cfa90..a12640792605 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -173,39 +173,6 @@ struct ovs_net {
 	bool xt_label;
 };
 
-struct deferred_action {
-	struct sk_buff *skb;
-	const struct nlattr *actions;
-	int actions_len;
-
-	/* Store pkt_key clone when creating deferred action. */
-	struct sw_flow_key pkt_key;
-};
-
-#define DEFERRED_ACTION_FIFO_SIZE 10
-#define OVS_RECURSION_LIMIT 5
-#define OVS_DEFERRED_ACTION_THRESHOLD (OVS_RECURSION_LIMIT - 2)
-
-struct action_fifo {
-	int head;
-	int tail;
-	/* Deferred action fifo queue storage. */
-	struct deferred_action fifo[DEFERRED_ACTION_FIFO_SIZE];
-};
-
-struct action_flow_keys {
-	struct sw_flow_key key[OVS_DEFERRED_ACTION_THRESHOLD];
-};
-
-struct ovs_pcpu_storage {
-	struct action_fifo action_fifos;
-	struct action_flow_keys flow_keys;
-	int exec_level;
-	struct task_struct *owner;
-	local_lock_t bh_lock;
-};
-DECLARE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage);
-
 /**
  * enum ovs_pkt_hash_types - hash info to include with a packet
  * to send to userspace.
-- 
2.40.1


