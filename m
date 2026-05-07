Return-Path: <netdev+bounces-285174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJVbIOtF/Gn9NgAAu9opvQ
	(envelope-from <netdev+bounces-285174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:57:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F39714E44D2
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63547301705E
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 07:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF58F37C111;
	Thu,  7 May 2026 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PG7D8WnF"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691D37B3FE
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140616; cv=fail; b=AKbcvS8S1dhsJ6hHA8pH8Cx9ugtFL0GVvFcxcBT2aIdbHaei5Wy8iMwiicEmZqBLCGHT9Zt5fLoUHWmxwfkGY11ztQGk4Z8QMItbYq9Qvhiw23CrpxDxjQGZ0Xp8M4eWLcsdmXBpyFPlru6xQofDprZFSVGh2DXo1++jo1qAXRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140616; c=relaxed/simple;
	bh=EIN6ekZXKwt2/YB9XbKidgPIhE/oRnpfgRYShkDmGII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLnDJbzLZ6Z1f6yfCQAG0T/tsRqkjN/0iao6h6lzXFex5tXrrPNqW6rBrZmAc/FhhDagU92rXbp9+bgz07zKj+sV2hx0Nf/d65T0mAlr4RqM8NiY4Vm8QenH/iQYZ9guRSF7ZJLK2hxx/MXm/Kyq1Ds9lQJIXYSraeRtW1wLT/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PG7D8WnF; arc=fail smtp.client-ip=52.101.57.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOu/egZuPkKV1zliRfiM1Coj9BLMuYOlOmKzszhNPHRT3NGDsMyNBSXloqPMMVKDWiiTLCd9+ed94bYHzzw9xzMNp+tymIv4Nmnb9Qf2xTuRSpAXluCCS/82iIs/VbXq4z7azaonUFylNUBR+Eq8kG0Br8fpcDAZgN7pzM14WcuRbOUIXoQezaRG8fLewzZFNLgqk26G8PDiDZUSv+idZ5vgaPdG4+wgIKYQvtwX81E6+00Isu0hrGXbHHVfLrhLhM4KOODRxlqNf5R/Qo+iLxtFTxT70CkeOK+lpWUy5PBXmJjuX8i1Bhul5vK5xWjStF+9T3rQZMUi/v9ojrVg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLZYDwOMFz58iOCUwt3a+lx4qV+e/dKSc8o8WFkwHKY=;
 b=UUcbQNr+My3Y4kBoP1WnVyW6vi06QSczb8O+h2xjSuY5r6xK/YmOma+auasu3wRoruGpYw0QHnhYBLFlbj3J8ND+VxXbohH1vEuMQQMpBX1pIINpJ7XgMRIAkBYRH1oxYqukzHNUItyC++lpvO/5sRAKlCPyoFy2YbYsxCLtTRk3EXbKis3SVFXpuItAku81OpAfIoFNUVVZWT6IAxY/Nt6TEBdAKdNwIuoR5JB2JedsR5hPUxbzTcFR7zTQV4tHvURsSOAzOznvBohnxUwEZlC8Oqy045pvaPjEkBmMESje7AGzlQIkxKm+zm6tpNqV9I+8R7QB+Jl5KTZboA2LMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLZYDwOMFz58iOCUwt3a+lx4qV+e/dKSc8o8WFkwHKY=;
 b=PG7D8WnFUD1f3+ZUDxUw3J/tE16BjEQpDKr6d4blrzPlsAftmK04kACvE83hDiMuhaji2x5aZSWBj7MaPI1VBhisc/YYsKYty+G38pKE0glLDiDRbuhA+JSc+FYE/T/gxYvgvjz1KELkLpPKrF82w84rgKTTLpNCaWL6Whso9gSTnLL9jxcWMGUfXVJTiJhh+WjskHhOUVMaqQ6nREDHzuziQ/2QflafCvuyvTeD3A96Mm8LBHiB74WmeYmCHdx2hNSFgQnUSstXIPrURFBDOpXJEiorVL4oRMUvt4z6VZVmn79XFGeZTjh+mkNYJb17eRaX2fBmSBda6ABHMoKFLg==
Received: from BL0PR02CA0008.namprd02.prod.outlook.com (2603:10b6:207:3c::21)
 by LVXPR12MB999196.namprd12.prod.outlook.com (2603:10b6:408:3dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 07:56:50 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:207:3c:cafe::cf) by BL0PR02CA0008.outlook.office365.com
 (2603:10b6:207:3c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 07:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 07:56:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 00:56:34 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 00:56:31 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Simon Horman <horms@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH v3 net-next 1/3] ipv4: Provide a FIB flushing signal from nexthop removal functions
Date: Thu, 7 May 2026 10:56:04 +0300
Message-ID: <20260507075606.322405-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507075606.322405-1-cratiu@nvidia.com>
References: <20260507075606.322405-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|LVXPR12MB999196:EE_
X-MS-Office365-Filtering-Correlation-Id: 201b9d17-28e0-497b-b59a-08deac0e320c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	k9knFX4dRZsKbYv2Km8nS37JYbw4ahaKgaEhjFaUrhAPMwuyd7vp5u85uiPxN6o/j//MVVBI7h8mjGVJYzeByIvGkNMLwFJaE9uyEG9Mpb+5yfC0Ekc+TEVDYNGYqAk3Mh2PAW7te8zJDlexnfarP2xPUJe3BJjFXgySygJGVYzo+Uv9sMA3hnL02DngqB4i1iXblliHqzug7HWK4phZzrklFu0tThcunhQ7r7sk/XryXMNhHPkBFzozowd3YX2qHM9MakLROG3seXtqELFSSg1zF6VNPwQgOLeQsiTjWi6hqbFcnhKM1ROk9jtiihee8TwvMkLPZ4OoqR4BgCBJXVR++JRqVEnmLqUqm0D+pjuGvHwrPJQxu3T14JtYyVKiA8+cnAV8O3yYptWL25TKv6mkEHJbAooEZqFruDGdRESRx0ZpKAxmXO0eS/wxfXr7CX9l0WJGE3ceBhTIR3C2v3QVpk3l+HEZKKKsd1t0ACqTj42e5BJ6686l/q+v5x1cHYGCqdJ7SFdRC4AW2sjCRdPgnk6tbGdqM+NHNr+Bwst2sJ1bhWwTlTypRUu+77li7Le5oDjOLOGnGRNDpPIwLPXu7LPvx5PVZ2ihQlsoZnp3xnfAyXBGK264kBqBtNmUjUL7DhO8G62+DWmksk0qCj3rqd7po0P190JRaiQS8K+MjDSMauHFGejaxS0atPCAQSHCWIYLaZH+40kiD8EcctvDBzmkBKmi4KmMYlZJTcs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0m1j+iV/H5TgeQURubMYIlgqJ1V+C9yYp8/vLzLtesWnxQ+vf5xF/hhoyI3X9MSMbDDz00QFw0akEeW3OBhwDl6d5ViA7hvN7PFa24V1cve3o/Ix6erzUNRkzw5ng7uMa6wK1VCkAX5f6hrXHiVv+R+AmEzfvPTloKABSw1wIUYpOwCAUc2WaGtWgBR7P+K32v6ZomX3c2RiQDWXZg8Y+I30lwv8Ma732oKeNUPf8KwfFRhBwtejSZsG1GCqcL7pB3ert2tLHo1KcmHmweBOIKQj7V4ftMK5hruDKRtafdWJ4S9qoIKC8a+v+FATyaTppIc0mCZ+t2jILNlfWIwauIh9hCBmOJw3Duf9Bj65K0OrOSg24SE2ryuT+Dp2b6rddYD+Mb/zDGofjQOBdz5hxHm1FS4Duoaufxq7bwRZg9ya9ScQaDyf0JkR6FpJpjCh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 07:56:50.0541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 201b9d17-28e0-497b-b59a-08deac0e320c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999196
X-Rspamd-Queue-Id: F39714E44D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285174-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Plumb a bool value throughout the various nexthop removal functions,
determined in the innermost __remove_nexthop_fib() (which still does the
FIB flushing) and propagated up all callers.

The next patch will make use of this signal to optimize the removal of
multiple nexthops by moving the FIB flushing up the call hierarchy.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/ipv4/nexthop.c | 50 +++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index f92fcc39fc4c..7177092d2605 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -20,7 +20,7 @@
 #define NH_RES_DEFAULT_IDLE_TIMER	(120 * HZ)
 #define NH_RES_DEFAULT_UNBALANCED_TIMER	0	/* No forced rebalancing. */
 
-static void remove_nexthop(struct net *net, struct nexthop *nh,
+static bool remove_nexthop(struct net *net, struct nexthop *nh,
 			   struct nl_info *nlinfo);
 
 #define NH_DEV_HASHBITS  8
@@ -2016,7 +2016,7 @@ static void nh_hthr_group_rebalance(struct nh_group *nhg)
 	}
 }
 
-static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
+static bool remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 				struct nl_info *nlinfo,
 				struct list_head *deferred_free)
 {
@@ -2033,10 +2033,8 @@ static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 	newg = nhg->spare;
 
 	/* last entry, keep it visible and remove the parent */
-	if (nhg->num_nh == 1) {
-		remove_nexthop(net, nhp, nlinfo);
-		return;
-	}
+	if (nhg->num_nh == 1)
+		return remove_nexthop(net, nhp, nlinfo);
 
 	newg->has_v4 = false;
 	newg->is_multipath = nhg->is_multipath;
@@ -2093,22 +2091,26 @@ static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 
 	if (nlinfo)
 		nexthop_notify(RTM_NEWNEXTHOP, nhp, nlinfo);
+
+	return false;
 }
 
-static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
+static bool remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
 				       struct nl_info *nlinfo)
 {
 	struct nh_grp_entry *nhge, *tmp;
 	LIST_HEAD(deferred_free);
+	bool need_flush = false;
 
 	/* If there is nothing to do, let's avoid the costly call to
 	 * synchronize_net()
 	 */
 	if (list_empty(&nh->grp_list))
-		return;
+		return false;
 
 	list_for_each_entry_safe(nhge, tmp, &nh->grp_list, nh_list)
-		remove_nh_grp_entry(net, nhge, nlinfo, &deferred_free);
+		need_flush |= remove_nh_grp_entry(net, nhge, nlinfo,
+						  &deferred_free);
 
 	/* make sure all see the newly published array before releasing rtnl */
 	synchronize_net();
@@ -2118,6 +2120,8 @@ static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
 		list_del(&nhge->nh_list);
 		free_percpu(nhge->stats);
 	}
+
+	return need_flush;
 }
 
 static void remove_nexthop_group(struct nexthop *nh, struct nl_info *nlinfo)
@@ -2142,17 +2146,15 @@ static void remove_nexthop_group(struct nexthop *nh, struct nl_info *nlinfo)
 }
 
 /* not called for nexthop replace */
-static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
+static bool __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 {
+	bool need_flush = !list_empty(&nh->fi_list);
 	struct fib6_info *f6i;
-	bool do_flush = false;
 	struct fib_info *fi;
 
-	list_for_each_entry(fi, &nh->fi_list, nh_list) {
+	list_for_each_entry(fi, &nh->fi_list, nh_list)
 		fi->fib_flags |= RTNH_F_DEAD;
-		do_flush = true;
-	}
-	if (do_flush)
+	if (need_flush)
 		fib_flush(net);
 
 	spin_lock_bh(&nh->lock);
@@ -2173,12 +2175,14 @@ static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 	}
 
 	spin_unlock_bh(&nh->lock);
+
+	return need_flush;
 }
 
-static void __remove_nexthop(struct net *net, struct nexthop *nh,
+static bool __remove_nexthop(struct net *net, struct nexthop *nh,
 			     struct nl_info *nlinfo)
 {
-	__remove_nexthop_fib(net, nh);
+	bool need_flush = __remove_nexthop_fib(net, nh);
 
 	if (nh->is_group) {
 		remove_nexthop_group(nh, nlinfo);
@@ -2189,13 +2193,17 @@ static void __remove_nexthop(struct net *net, struct nexthop *nh,
 		if (nhi->fib_nhc.nhc_dev)
 			hlist_del(&nhi->dev_hash);
 
-		remove_nexthop_from_groups(net, nh, nlinfo);
+		need_flush |= remove_nexthop_from_groups(net, nh, nlinfo);
 	}
+
+	return need_flush;
 }
 
-static void remove_nexthop(struct net *net, struct nexthop *nh,
+static bool remove_nexthop(struct net *net, struct nexthop *nh,
 			   struct nl_info *nlinfo)
 {
+	bool need_flush;
+
 	call_nexthop_notifiers(net, NEXTHOP_EVENT_DEL, nh, NULL);
 
 	/* remove from the tree */
@@ -2204,10 +2212,12 @@ static void remove_nexthop(struct net *net, struct nexthop *nh,
 	if (nlinfo)
 		nexthop_notify(RTM_DELNEXTHOP, nh, nlinfo);
 
-	__remove_nexthop(net, nh, nlinfo);
+	need_flush = __remove_nexthop(net, nh, nlinfo);
 	nh_base_seq_inc(net);
 
 	nexthop_put(nh);
+
+	return need_flush;
 }
 
 /* if any FIB entries reference this nexthop, any dst entries
-- 
2.53.0


