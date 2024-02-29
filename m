Return-Path: <netdev+bounces-76279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19C486D1EB
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67492283741
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E1610EF;
	Thu, 29 Feb 2024 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VfnbuOOh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C7E7A13D
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230823; cv=fail; b=cQ+Qaabgv/bRUrLur1hv1asWhI/SKJTe0In+qo82O4pjPAmNSrN6Q9gb8KYUhHNCOdjMR7hHyl6rcVFLo8hE/DaBFGrp4d/SMbArrx2qnDII+lVmt1yR09safGopTfp5+JoENSGIP1/Lg0cfHgUDQEauerAB0BBFWNmz6EGOq4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230823; c=relaxed/simple;
	bh=FWh5LmZomI4Pt2FKSNazSD8I18Ye2XQ+nI12KavlIgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWC1UgTUYqwxShtSd+Q0KV/aX635522RhWxccf28uv9W1j6/2rfXqUiau9oWUoiQPkQV+PdzH4N3G5inbdQQoeIqMSCZ13UdJE4PM0WIjxBBjdA5GNQhshHCvMxoNFSpXJBco2Z6Eyuv5BS4jJmDOtW8JVZ1+w4x+fnNkguMX58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VfnbuOOh; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8P9HmEU4Z3l+97EwYcBrg5wlu6Z2H6qvhJzTKIBw/I8BwBggF2J6u3f0QFMNn6NTOgs6NWmX9RSexOBjCp99wDS0I91ZeHh48zOlcwqWL4Xuo0ttcmyrzY4HMx0SDrzMaIm4nFfsNUOFMmpYdoAMsiHVYfnkWPoGxXISVt7X45s8g0hHx2+7CKOxdiFlHGJpUmk2KLUZtBp4X1X0vLPKK4dYhDAkaxB0o2db50Z17KoW8/iVbhKJsrIBKc9E4BgpI3bVMRdHEhgmxLMVNSS4yLyhNHGAEGSD0wV7KSzV+l3qj5RmrcJOkF4XYlERYKbNOYTEFY/F25f/RXhBa+wVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH8gGQvzZ7a+lPhVkpsMU4+V3heBZ9HVGQPV85oVceg=;
 b=eu2H3mZImMfJ8S7xx09JT0h1dxTRgP9g3pWGQal1oehW0h9k4jAFbg2ca7QUACAs/Y3HgDsolFKOe3dd/AAknzUggwnrLHph+ElO0mz3pLNpheF7iRdwXL64n9MMo3sri8VWaE89hxe9y8ytFGJGr+C6ORQPTxwlt7argm3aXfjqLO4dAeDdWQX+zP3qrfuAfQv+agAEVNtaswR7dOsYnf3MqPR16PNBPeMcmQa6qUAp4N/thFf4D8XW2mn2HXs09X3Bo06kgeFzglMcA9IPPMSFnUfG1Z7tyjHcyIHm4MHejZIjqSWf9qXNwgOMtIWCq28fZggEz0ISsFZBYfsbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH8gGQvzZ7a+lPhVkpsMU4+V3heBZ9HVGQPV85oVceg=;
 b=VfnbuOOh7iAqWe3ZKpqWWfncnTOXdADg32UEpnOe6V0+CBr1mtPCrS8rso603NKAmxh76LWw5rcpW8GoKyS2jhAycNRQ56LVIg4J479hwghufZ97nFKp8/xwTha4wjqNk5afBTAJR3XMbB9IO327s2byuThMP8dy+Yk5PtLSWzptxE4Q/vjOdvMcecfUrxCB3q4mQUY50pRC3zOpOyJVXMOFPoggCc2ycrSNyGMEo+qtkJYFIfR1s2Z7asuRp2j5sI5mX1XQSc3eQrtdSrreGxqYQ+M/zUSz7yfCMU3dMLKIewnGrJjrNBRsVsDvZXVISg4oZtttsRTLEPSlWfdn6A==
Received: from BY3PR10CA0029.namprd10.prod.outlook.com (2603:10b6:a03:255::34)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 18:20:15 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::80) by BY3PR10CA0029.outlook.office365.com
 (2603:10b6:a03:255::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Thu, 29 Feb 2024 18:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 18:20:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 10:20:00 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 29 Feb
 2024 10:19:55 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 3/7] net: nexthop: Add nexthop group entry stats
Date: Thu, 29 Feb 2024 19:16:36 +0100
Message-ID: <e0bba52945a53398c0b0af6ea5bc4a11f130960c.1709217658.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DS7PR12MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd6f906-7bf8-4f55-4935-08dc3953139e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fWt5ORo361kmXZTirKUc9VQRA8E1Rb10Q3+CJSEgzvp7LmMyBq1C5fhB8fFRTWFbByMS3Xt9nNKYj7qIp2b+PFRt1PXSoxvjHkewxH3Y78SF6Gk3C2rS+KF4rKW/Qos6/mMQuaVUeNbA6brlTOXIHCGthBqh5roexo7amJic4Zt7KQIqOZLrUhAc5LcqPeP2IVT7v4l1xchTINdvgdrXWg/0kDnQ7yKGKac6/j3gPupBNjEmxRBUO+gr8aDC5EnKKgd07K0VQ/GW90RLFnBuJL0klL4V0FjZllPeADAeUg+LKgEZmvBR2nSrH5UbG18AlLk9+G55V26OTIrL5GDl+IhjRIfdjSIK4c6TkLg4vVz0QnyUU4NjBhQ1ATOXVxt/ou46/7LVT/RhcI8EmEhpjtK0d85Hoct5kwREb1wzzq1HId/BaFC8qbMDqPpHLSUnImKkYXvWHlkbnLupkw3JTGtwStnEm3mPtUksjkKeD9lwIv16mxQX/ZNN7MtaLWHL8hzsiuTOUmY7dj4fjkjc3IS88l1gozZ/031kLFkzWKTeYn+FDdi3UQHJG66JdJ1dkYF3jM9tMBPlvmRsP6oV5LHyT7tQIiPw/DFfazjp3jHVDYnhk/cSmHP8q1gQP/M9bDg5/87KPZeeyU1G5T2iMowitBK17vL+GGKWNmAP7dDC+ZpEkO+mEiBkB0x615yj75l3JHby3TCdDLUV3xf40pP6QXGIFDoNchTRLeh4OxF22ouDhwiDyMhymZHOfs6P
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:20:15.2883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd6f906-7bf8-4f55-4935-08dc3953139e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359

From: Ido Schimmel <idosch@nvidia.com>

Add nexthop group entry stats to count the number of packets forwarded
via each nexthop in the group. The stats will be exposed to user space
for better data path observability in the next patch.

The per-CPU stats pointer is placed at the beginning of 'struct
nh_grp_entry', so that all the fields accessed for the data path reside
on the same cache line:

struct nh_grp_entry {
        struct nexthop *           nh;                   /*     0     8 */
        struct nh_grp_entry_stats * stats;               /*     8     8 */
        u8                         weight;               /*    16     1 */

        /* XXX 7 bytes hole, try to pack */

        union {
                struct {
                        atomic_t   upper_bound;          /*    24     4 */
                } hthr;                                  /*    24     4 */
                struct {
                        struct list_head uw_nh_entry;    /*    24    16 */
                        u16        count_buckets;        /*    40     2 */
                        u16        wants_buckets;        /*    42     2 */
                } res;                                   /*    24    24 */
        };                                               /*    24    24 */
        struct list_head           nh_list;              /*    48    16 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct nexthop *           nh_parent;            /*    64     8 */

        /* size: 72, cachelines: 2, members: 6 */
        /* sum members: 65, holes: 1, sum holes: 7 */
        /* last cacheline: 8 bytes */
};

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Set err on nexthop_create_group() error path

 include/net/nexthop.h |  6 ++++++
 net/ipv4/nexthop.c    | 25 +++++++++++++++++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 77e99cba60ad..4bf1875445d8 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -95,8 +95,14 @@ struct nh_res_table {
 	struct nh_res_bucket	nh_buckets[] __counted_by(num_nh_buckets);
 };
 
+struct nh_grp_entry_stats {
+	u64 packets;
+	struct u64_stats_sync syncp;
+};
+
 struct nh_grp_entry {
 	struct nexthop	*nh;
+	struct nh_grp_entry_stats __percpu	*stats;
 	u8		weight;
 
 	union {
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 816ae8ee3e06..4be66622e24f 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -480,6 +480,7 @@ static void nexthop_free_group(struct nexthop *nh)
 		struct nh_grp_entry *nhge = &nhg->nh_entries[i];
 
 		WARN_ON(!list_empty(&nhge->nh_list));
+		free_percpu(nhge->stats);
 		nexthop_put(nhge->nh);
 	}
 
@@ -1182,6 +1183,7 @@ static struct nexthop *nexthop_select_path_fdb(struct nh_group *nhg, int hash)
 		if (hash > atomic_read(&nhge->hthr.upper_bound))
 			continue;
 
+		this_cpu_inc(nhge->stats->packets);
 		return nhge->nh;
 	}
 
@@ -1191,7 +1193,7 @@ static struct nexthop *nexthop_select_path_fdb(struct nh_group *nhg, int hash)
 
 static struct nexthop *nexthop_select_path_hthr(struct nh_group *nhg, int hash)
 {
-	struct nexthop *rc = NULL;
+	struct nh_grp_entry *nhge0 = NULL;
 	int i;
 
 	if (nhg->fdb_nh)
@@ -1206,16 +1208,20 @@ static struct nexthop *nexthop_select_path_hthr(struct nh_group *nhg, int hash)
 		if (!nexthop_is_good_nh(nhge->nh))
 			continue;
 
-		if (!rc)
-			rc = nhge->nh;
+		if (!nhge0)
+			nhge0 = nhge;
 
 		if (hash > atomic_read(&nhge->hthr.upper_bound))
 			continue;
 
+		this_cpu_inc(nhge->stats->packets);
 		return nhge->nh;
 	}
 
-	return rc ? : nhg->nh_entries[0].nh;
+	if (!nhge0)
+		nhge0 = &nhg->nh_entries[0];
+	this_cpu_inc(nhge0->stats->packets);
+	return nhge0->nh;
 }
 
 static struct nexthop *nexthop_select_path_res(struct nh_group *nhg, int hash)
@@ -1231,6 +1237,7 @@ static struct nexthop *nexthop_select_path_res(struct nh_group *nhg, int hash)
 	bucket = &res_table->nh_buckets[bucket_index];
 	nh_res_bucket_set_busy(bucket);
 	nhge = rcu_dereference(bucket->nh_entry);
+	this_cpu_inc(nhge->stats->packets);
 	return nhge->nh;
 }
 
@@ -1804,6 +1811,7 @@ static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 			newg->has_v4 = true;
 
 		list_del(&nhges[i].nh_list);
+		new_nhges[j].stats = nhges[i].stats;
 		new_nhges[j].nh_parent = nhges[i].nh_parent;
 		new_nhges[j].nh = nhges[i].nh;
 		new_nhges[j].weight = nhges[i].weight;
@@ -1819,6 +1827,7 @@ static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 	rcu_assign_pointer(nhp->nh_grp, newg);
 
 	list_del(&nhge->nh_list);
+	free_percpu(nhge->stats);
 	nexthop_put(nhge->nh);
 
 	/* Removal of a NH from a resilient group is notified through
@@ -2483,6 +2492,13 @@ static struct nexthop *nexthop_create_group(struct net *net,
 		if (nhi->family == AF_INET)
 			nhg->has_v4 = true;
 
+		nhg->nh_entries[i].stats =
+			netdev_alloc_pcpu_stats(struct nh_grp_entry_stats);
+		if (!nhg->nh_entries[i].stats) {
+			err = -ENOMEM;
+			nexthop_put(nhe);
+			goto out_no_nh;
+		}
 		nhg->nh_entries[i].nh = nhe;
 		nhg->nh_entries[i].weight = entry[i].weight + 1;
 		list_add(&nhg->nh_entries[i].nh_list, &nhe->grp_list);
@@ -2522,6 +2538,7 @@ static struct nexthop *nexthop_create_group(struct net *net,
 out_no_nh:
 	for (i--; i >= 0; --i) {
 		list_del(&nhg->nh_entries[i].nh_list);
+		free_percpu(nhg->nh_entries[i].stats);
 		nexthop_put(nhg->nh_entries[i].nh);
 	}
 
-- 
2.43.0


