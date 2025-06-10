Return-Path: <netdev+bounces-195951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BA3AD2DED
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FB23ACA5A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 06:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AF327877F;
	Tue, 10 Jun 2025 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I1Ynx8ne"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947411A0BCD
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749536830; cv=fail; b=tBjKIedKFJV55xeFzpLdS6GVc25MSmF3fH1TyO3uEv+9/iIkaBDxxnTm0orfjxULn/whdqo4PfIb/Ia3VutuwDB4udbav3ukSlo/S1ndrfsf49krbVLNWcqbESCHwtCCKmLknHhZUwL38wA6qfxpIzp3l+89Sf8xh0oLZLz9kSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749536830; c=relaxed/simple;
	bh=rTwJbRJMBvkgKAaycRIusdaNxI0IpMyIlZejdvgG5rs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OFW08ju6yyKt6CRyBiPo5DnFZm6jdW0L/1nuwFAeD0eaHIDKEQ/mWe4bPT9HkVGdsICe3n9bDYuO8/cs/sHy1tC29xmJef8ZAqRjSV/fITRHsIhhb0SSnmz37KTxgHxZ0NKPVSNlEipCh6AwyKORZmaKsDHrot/9iOrvwzHycCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I1Ynx8ne; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLaAJTuOqMYVV7Wk9bqNMha6nT3lgTYSYT6JLIpG1nO3XTCQn26TL85PHwTkDsQwDv0iAabMniY4SGJ2XduiQ+2LMmNAkc4rnjNdzxZbbDqaxQ7Oc5QSjInouyxPQOZami1y5pm6KnA7/NHQJxxrah9/y31vQT54znht5vIFi5Wot5ZgC8cHkc1HqsjfBwX3ECtKAjVHJjJl6gExkSw7AlQRC4XrolvKi8ykdhPJnCZR4DEg7NqBLSQGSyXDS9vIPgntHT4CW8JE2+A4kJLpW3SzNThu0uFSKAjrJQLI7jb/eVNtcl7rdghg5brStjFlIQ5gj/tu+PYIc8S1tE8JVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+a3C6q+kyWqUqc8yrUWO7Ti7+sMXkut2awVBLki5o94=;
 b=jXKxMJYkg+ViaTftnseRZO0htlEBY+rdKBjfqbSzniZhTqWxkXxibv8lt3AhsuuYqOmpqsPRWP2HW3fWXvtZmkVT5noSb0Vp8+Mm3OXUg0N6gUR3iItVMDPUnBxdzdgW0YhvRTxqTC4lu6ROT2G+8CvCscRgSOR09ztfMFe9J6p5zu0FR8EkpqzDaf73pJh7/RlmWTl9UbvdOaOVfYxp5reMnv9G/Lb4tD2LK1E0FJ9sZprNAX4NNtydWRFmmK6Ux7Ll724Brb8eVECgTwV/qTy6pkV5CqoQl0ci7HtURNMZQ7VeOaAA7UKoc7nhPmdgOSS2mQwQkx5vPSQhsE3BGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a3C6q+kyWqUqc8yrUWO7Ti7+sMXkut2awVBLki5o94=;
 b=I1Ynx8nezxd36IGYYue47jbCTvjMASDJka9ypfKBpO2Kf8/GrhIE/VRulEZF7CrYveMigoNAVh4ffzYKDTNxvVddIppp6bMxxVexRVjmZHYPKx8ndql9aR4IDayip4+DmFkxbXeDTyZW+dd0HYGg7b42RIU1OLUA0mzKOyYnJ1FU5J7B6VsWqZhX99CoZgHU98UysglLmVBsfljwVi81PkpzdUha9arPgT6DTWqCX6FcNLidoElmYlKVHyVVnQgfgLuXXOVMt8mNinjRor3S9FYag53xxQhgzw33ox2Ejv5JIKoPz/riO65NBpYxZ4sLUNlewIfKFWdYpBAYqWwNPg==
Received: from BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) by MW3PR12MB4380.namprd12.prod.outlook.com
 (2603:10b6:303:5a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 06:27:04 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::1) by BL0PR1501CA0025.outlook.office365.com
 (2603:10b6:207:17::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 10 Jun 2025 06:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 06:27:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 23:26:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 9 Jun 2025 23:26:45 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 9 Jun 2025 23:26:42 -0700
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
Subject: [PATCH net 3/3] Revert "openvswitch: Merge three per-CPU structures into one"
Date: Tue, 10 Jun 2025 09:26:31 +0300
Message-ID: <20250610062631.1645885-4-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 7488b5a3-affd-4fb0-0b7e-08dda7e7d041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cJAblz2m6OXgKRn+mX9bzwA1fTe6joEVj5xFcZNGq8QlzuPagjMR4sdAaAbW?=
 =?us-ascii?Q?tT6bIs6Xw1OprLUVhcgR9m4lxXaHHr8rqmB3vgUnEO7JEHOy9grkLHoPFCg6?=
 =?us-ascii?Q?p+yn4WY8jy83MArPDOBTCIdkXVLLUVMlgsmwmNwdeMlF4J7xTdL5HD283dC0?=
 =?us-ascii?Q?K1h3+cToWE9EcIYMdU+myEVMdkAAWS8vRGcawysw6DpVl7k46C0ewkHvtrao?=
 =?us-ascii?Q?OtPKMOskFZLIH9T0vkUDtT5DC1n39yQw9iPSDW3HgrLxdzpatMkPXpU1R/I+?=
 =?us-ascii?Q?wIZZRQltz7F05baT7EXF4KVWEfKA7W6mgeFxf2ewpzJ8Voaqsmo8b2LHgP0k?=
 =?us-ascii?Q?UPDGRLIdXdMctwFMx8suLdP/nQHgNFs4dUHX4ITzB2K4KiM3nk1RmBZK3de4?=
 =?us-ascii?Q?MYJzcBNku4y8Trx1P5oEaKhNc8vajm+/NXuR9XknF+JMextDhJSrt6LHLd70?=
 =?us-ascii?Q?uY4x9wZZ55faNyX/PI+01gRE/aUz469xT8srLWvX4s6+ePt545gwh8Jjk+4I?=
 =?us-ascii?Q?/xgAKc4nWGjqqAi9k8yg7CrQcY9ZdA3bUFgZLkW5JBlYfsq0DmZShXAZqOIQ?=
 =?us-ascii?Q?qVfhMoZ1Wfz5S4fJVvkB6AX61MIbmjsrknr2qokWVPyKv/wxnZHkGgnpIQ2N?=
 =?us-ascii?Q?IfRyMGTTxBbYWdvke6uUIX/DB0rfNHfTwg0Tid55mpwSsBr/peeeVerppV5s?=
 =?us-ascii?Q?N3OSeT+10yhU3BMRByk9IIn7L20Zv7ffksVi0u5kVapXQyJ+bqS0UgH/nnvG?=
 =?us-ascii?Q?h4mfjt8VVyljq6BWsWznnX+VIHELAF5SqTPTARl+tnlCr4yp8/g0eKcKjK1v?=
 =?us-ascii?Q?9cxzwqCBm10+pO7EkREGvv3hSc8GNjzhOg3yxeDS4uz7H0N0ShOBoWpCLdH8?=
 =?us-ascii?Q?vze7gkiyTGy553UI7zdKy7xQ2IJ09dYmGdZrEcUQGOVfbwn4mhveJ/dcZuwz?=
 =?us-ascii?Q?gfts7wUcpQCFu7Ey9jxEFGH/uFZRJqQ2qb6c3qqVC7iO+n/UDHjI9ptahW+9?=
 =?us-ascii?Q?jCYcreESI3Re3SWCGHKbKO0KGveHoZBrEqpKERar8xxpBFFBtoMt+Safmbq+?=
 =?us-ascii?Q?ZXwKyYIkMYhHqi61AY/1pBCrubRchBU5PXnnGzyuG9SlQ5z9v0aENWfdJDSH?=
 =?us-ascii?Q?eDkLixYgmJvdxpiH3/jTvypS7pCAatV0bt/FnOhbFJdK0sVhao2MUXE3OXAW?=
 =?us-ascii?Q?YpbisnnXRtchbzf4knO6LMmiR3BAOkY89hyrxuPFsq1n+2G62U5KxC7Ot4xs?=
 =?us-ascii?Q?+JDegfodwig4SKK+R07pkJXfaw7Nu+aY859N0slJ9ZLE6Jzf6EUyWZTXAgus?=
 =?us-ascii?Q?JFh6js/kdn40knCg8N5325DZjwYDfD52Hhwsdgn2AqawGv7+oji4Hw8+j7D/?=
 =?us-ascii?Q?nlDlHyEoVe0IOH0FstnVdrrNREjsiexrwa7nAp0Q97WFYA4xhlX6NP6yXjmF?=
 =?us-ascii?Q?hQF2HL0troEATofh4RdNhHLtqEhJ3LyP1s85z7wknKYeWj7ZHMastm2FYeNQ?=
 =?us-ascii?Q?b+bg/fBobyuM1zuUCuG3w27JhKbIGHtb3SL2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 06:27:02.7609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7488b5a3-affd-4fb0-0b7e-08dda7e7d041
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380

This reverts commit 035fcdc4d240c873c89b76b752dd9921bc88c1ba.

The cited commit changed openvswitch to use static percpu allocations,
and exhausted the reserved chunk on module init.
Allocation of struct ovs_pcpu_storage (6488 bytes) fails on ARM:

percpu: allocation failed, size=6488 align=8 atomic=0, alloc from reserved chunk failed
CPU: 2 UID: 0 PID: 4571 Comm: modprobe Not tainted 6.15.0-for-upstream-bluefield-2025-05-28-15-45 #1 NONE
Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS 4.9.0.13378 Oct 30 2024
Call trace:
 show_stack+0x20/0x38 (C)
 dump_stack_lvl+0x80/0xf8
 dump_stack+0x18/0x28
 pcpu_alloc_noprof+0x860/0xa48
 load_module+0xc68/0x23f0
 init_module_from_file+0x90/0xe0
 __arm64_sys_finit_module+0x21c/0x3d8
 invoke_syscall+0x50/0x120
 el0_svc_common.constprop.0+0x48/0xf0
 do_el0_svc+0x24/0x38
 el0_svc+0x34/0xf0
 el0t_64_sync_handler+0x10c/0x138
 el0t_64_sync+0x1ac/0x1b0
openvswitch: Could not allocate 6488 bytes percpu data

For large buffers, dynamic allocations are preferred, revert the patch.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 net/openvswitch/actions.c  | 49 +++++++++++++++++++++++++-------------
 net/openvswitch/datapath.c |  9 ++++++-
 net/openvswitch/datapath.h |  3 +++
 3 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 7e4a8d41b9ed..2f22ca59586f 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -78,22 +78,17 @@ struct action_flow_keys {
 	struct sw_flow_key key[OVS_DEFERRED_ACTION_THRESHOLD];
 };
 
-struct ovs_pcpu_storage {
-	struct action_fifo action_fifos;
-	struct action_flow_keys flow_keys;
-	int exec_level;
-};
-
-static DEFINE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage);
+static struct action_fifo __percpu *action_fifos;
+static struct action_flow_keys __percpu *flow_keys;
+static DEFINE_PER_CPU(int, exec_actions_level);
 
 /* Make a clone of the 'key', using the pre-allocated percpu 'flow_keys'
  * space. Return NULL if out of key spaces.
  */
 static struct sw_flow_key *clone_key(const struct sw_flow_key *key_)
 {
-	struct ovs_pcpu_storage *ovs_pcpu = this_cpu_ptr(&ovs_pcpu_storage);
-	struct action_flow_keys *keys = &ovs_pcpu->flow_keys;
-	int level = ovs_pcpu->exec_level;
+	struct action_flow_keys *keys = this_cpu_ptr(flow_keys);
+	int level = this_cpu_read(exec_actions_level);
 	struct sw_flow_key *key = NULL;
 
 	if (level <= OVS_DEFERRED_ACTION_THRESHOLD) {
@@ -137,9 +132,10 @@ static struct deferred_action *add_deferred_actions(struct sk_buff *skb,
 				    const struct nlattr *actions,
 				    const int actions_len)
 {
-	struct action_fifo *fifo = this_cpu_ptr(&ovs_pcpu_storage.action_fifos);
+	struct action_fifo *fifo;
 	struct deferred_action *da;
 
+	fifo = this_cpu_ptr(action_fifos);
 	da = action_fifo_put(fifo);
 	if (da) {
 		da->skb = skb;
@@ -1612,13 +1608,13 @@ static int clone_execute(struct datapath *dp, struct sk_buff *skb,
 
 		if (actions) { /* Sample action */
 			if (clone_flow_key)
-				__this_cpu_inc(ovs_pcpu_storage.exec_level);
+				__this_cpu_inc(exec_actions_level);
 
 			err = do_execute_actions(dp, skb, clone,
 						 actions, len);
 
 			if (clone_flow_key)
-				__this_cpu_dec(ovs_pcpu_storage.exec_level);
+				__this_cpu_dec(exec_actions_level);
 		} else { /* Recirc action */
 			clone->recirc_id = recirc_id;
 			ovs_dp_process_packet(skb, clone);
@@ -1654,7 +1650,7 @@ static int clone_execute(struct datapath *dp, struct sk_buff *skb,
 
 static void process_deferred_actions(struct datapath *dp)
 {
-	struct action_fifo *fifo = this_cpu_ptr(&ovs_pcpu_storage.action_fifos);
+	struct action_fifo *fifo = this_cpu_ptr(action_fifos);
 
 	/* Do not touch the FIFO in case there is no deferred actions. */
 	if (action_fifo_is_empty(fifo))
@@ -1685,7 +1681,7 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
 {
 	int err, level;
 
-	level = __this_cpu_inc_return(ovs_pcpu_storage.exec_level);
+	level = __this_cpu_inc_return(exec_actions_level);
 	if (unlikely(level > OVS_RECURSION_LIMIT)) {
 		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
 				     ovs_dp_name(dp));
@@ -1702,6 +1698,27 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		process_deferred_actions(dp);
 
 out:
-	__this_cpu_dec(ovs_pcpu_storage.exec_level);
+	__this_cpu_dec(exec_actions_level);
 	return err;
 }
+
+int action_fifos_init(void)
+{
+	action_fifos = alloc_percpu(struct action_fifo);
+	if (!action_fifos)
+		return -ENOMEM;
+
+	flow_keys = alloc_percpu(struct action_flow_keys);
+	if (!flow_keys) {
+		free_percpu(action_fifos);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void action_fifos_exit(void)
+{
+	free_percpu(action_fifos);
+	free_percpu(flow_keys);
+}
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index aaa6277bb49c..5d548eda742d 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -2729,10 +2729,14 @@ static int __init dp_init(void)
 
 	pr_info("Open vSwitch switching datapath\n");
 
-	err = ovs_internal_dev_rtnl_link_register();
+	err = action_fifos_init();
 	if (err)
 		goto error;
 
+	err = ovs_internal_dev_rtnl_link_register();
+	if (err)
+		goto error_action_fifos_exit;
+
 	err = ovs_flow_init();
 	if (err)
 		goto error_unreg_rtnl_link;
@@ -2774,6 +2778,8 @@ static int __init dp_init(void)
 	ovs_flow_exit();
 error_unreg_rtnl_link:
 	ovs_internal_dev_rtnl_link_unregister();
+error_action_fifos_exit:
+	action_fifos_exit();
 error:
 	return err;
 }
@@ -2789,6 +2795,7 @@ static void dp_cleanup(void)
 	ovs_vport_exit();
 	ovs_flow_exit();
 	ovs_internal_dev_rtnl_link_unregister();
+	action_fifos_exit();
 }
 
 module_init(dp_init);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index a12640792605..384ca77f4e79 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -281,6 +281,9 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
 
 void ovs_dp_notify_wq(struct work_struct *work);
 
+int action_fifos_init(void);
+void action_fifos_exit(void);
+
 /* 'KEY' must not have any bits set outside of the 'MASK' */
 #define OVS_MASKED(OLD, KEY, MASK) ((KEY) | ((OLD) & ~(MASK)))
 #define OVS_SET_MASKED(OLD, KEY, MASK) ((OLD) = OVS_MASKED(OLD, KEY, MASK))
-- 
2.40.1


