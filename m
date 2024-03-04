Return-Path: <netdev+bounces-77223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD44870BDF
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC581F23B02
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E483FFBFC;
	Mon,  4 Mar 2024 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HV+EA5P1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED0A1097D
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585539; cv=fail; b=teeXj4sOW2CovO+jauzDBoOF7/P817IFmK3P/PNz4u+uqQsVaH1Bfby4na+Z7fk17xt6PxjyTBa6bMRmmpMB3zv/IAkFFI3v4aZMLUm++lC1bNYZHwt/+oj5QBk1u8yf7w+biGyIH3RnDdx/QWOPO+QE/bPmACpzvBqND1pASbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585539; c=relaxed/simple;
	bh=KROqfB89h2pIYpNKNgKyiLThUd3H2e27WvKVcd0eqoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOuVULiw+S6beKFxi/8he70rGwXFUHdlD1buv/V8KGClzMSNiGJIGDbEEF9hBrPDTIKjb1c1ILgzsCJVpAstUCPj3m5QalzoBOK7MY6U/3ewzGPMlIImb0vKgF4kmnmYBbjt4nWUfiQIQT4zne/jL77i+I/hPmza0jGJTiQ/gLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HV+EA5P1; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aChjD8Yg79ERKuEcXUF20Q+oP3HeczAn+TGFANtDoEIvlTs0EAALQ0B6zEGyauD4eOwg6yCkpZ1o/xLvC3mTJ6UWS7sGNrx0eFwcdzEOLwQkcxRM0l+nv5KAjq8qIYZRRZU7ScWGVKo1er/UPMbZlDzhug4wLiM5NZfbLxX+ghP933CRcreVnudbmP3QB2PkHyl6kflQ6BoheP8A3jMFKqg3aB4EmnpjCvOFi/4YhkmuUgjJqeCG82mdpnyXd+1BVq/2VsaO1Pu59DZIBrSF/cKWCc4pwQMfMu1hYFdDPADJuci37NCv+Wn+lhib9PnKELyrT7sHuxVlpE3xo8MRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwOp5EskDtM1LmUWxDStXvtDn9mFl27luCJpdhRrG4Y=;
 b=OXM7TZDx7nvDHa8VIok91a8+9P7YR1BjjPHXCU1YTxXcyn48Tn9wCAiLZM6Y9XzDnkRec63q0YDaJv22Ua2XkvbLsPtQuk2WheQV7RrKrdIUkJF7v9qibElMlY2kEITEcdAF65haXUlRcGG8CQaigtXtdJ01pAtRFPXA2KRQOeEE+2SBsIK4TVerFLLyOH1I0Nwhmw3yoFhV+C/vqa/c2Hy5YaMNtqwzTIPjSezTbg3hRzGJzZfpkbjjYOw3LPp/Wj+Jw/acydVIsib7dlS+gr0xBlX2D/xiIW0N/ojLmhM9w3pflthzBc/8QsajCR9JbPYhdZuCjyfYEZtq/jtrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwOp5EskDtM1LmUWxDStXvtDn9mFl27luCJpdhRrG4Y=;
 b=HV+EA5P18T4jIhYxaR/oYPMamPLggFN9OzNLNl++eehZFGjkjSF258jm+mkN3oUGM1sZfEQEOkDy4Cd029d/bEyer1VXuf7prIo/w2ypNQj9aLzgXdZ03sIjHyV3Jzentjbs6vf9TAaqvk4n5Xuk25eeFdMiQuiPV/bWyCVOcZeWGIluDw7kGMb8Xz5TuSfAPcZ7moisPKDaIlbBpPlI3HBV5O/tDWtGudZkOVL+NYk5uA1zuHsdW3eYKnX9mbnL00UMyQk7PI9zOABWepzgtslnOzu/6TbqS76iZy42b9sDdpKYO/3k6/E7502CWUyFUzNo1izi0F9aG2p9vZWjOA==
Received: from SJ0PR13CA0205.namprd13.prod.outlook.com (2603:10b6:a03:2c3::30)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 20:52:14 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::2d) by SJ0PR13CA0205.outlook.office365.com
 (2603:10b6:a03:2c3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22 via Frontend
 Transport; Mon, 4 Mar 2024 20:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 20:52:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 12:52:01 -0800
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 12:51:57 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v3 3/7] net: nexthop: Add nexthop group entry stats
Date: Mon, 4 Mar 2024 21:51:16 +0100
Message-ID: <869e1f80d2c3443b168028c07eef8dd2175bb7e2.1709560395.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: bab22431-f531-425a-8ff8-08dc3c8cf88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fzXmEXtA1cifWJ+oFA0Z1XMyzj5mg5D4ajJBFzZEP/oFN3cehBfQ+IB5vomaHiN90ff8b/JV0YQPHyQFsAJaqORQPoiCgYP10EtRF3QOvcnl4uwAcMrld+RHnbA5lx6bC2plO7acFm1wTjSlfaYhK9mjH5qztNKdDPlSu8fUGwHhhaRMopH9TEigaQWLrtZqlxpTGuqV41f2Anyp3uhuXwoDjVhAzLnr3qOmvGyNBvWnmX8MfPhdF/5d4MBH0po21tVUNVn5MUdQlPizvv+tgzsroQqrlTUd4AhrfuNv/Qe7srPi/CnQC/TicL0XixSSNIBzw8VU2WSqSBWJ2KWZQCgECMnp/pK+7Moa/Zz/CjJwDP+ivOpLD+3X9AfIRBxVQytVmfNi7yGBnvUJng6jcdLaIJwh6ka/6WDOeKQKbRJ+4q4MI3XVXMqd2Hq2QoUIuhhNuJBEyoLvR9Bu1/sbfqzgL/KbTHxMHg6SExrlFnbfIzOwtcok26ssWtV/fEitMm3qB48Bt3mwi2oyZXfT9N4mZD+yvNYz5Y03pXKuVwAdJlms4fWble13Vb8wIZxp94wCojLhoZNbeP+RsvLrwZVnxQV0M/4YCPUVYCMvrrQg0h/onj/hYdFXDBgRMYHKEgT2lm+MS3SFl9Nxx6PYhGvbwjDd3Q8pdu8tiE2NbUidujCrKKmsoRsd/HUyX2CL44gZ4HPS6sxrtwfDqhs/RXT63VEHLow0B7Gvdb++0X2RSgyqvRV03hf5VXpxIS5O
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:52:14.1607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab22431-f531-425a-8ff8-08dc3c8cf88f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002

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

Co-developed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    v3:
    - Convert to u64_stats_t
    
    v2:
    - Set err on nexthop_create_group() error path

 include/net/nexthop.h |  6 ++++++
 net/ipv4/nexthop.c    | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 77e99cba60ad..6e6a36fee51e 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -95,8 +95,14 @@ struct nh_res_table {
 	struct nh_res_bucket	nh_buckets[] __counted_by(num_nh_buckets);
 };
 
+struct nh_grp_entry_stats {
+	u64_stats_t packets;
+	struct u64_stats_sync syncp;
+};
+
 struct nh_grp_entry {
 	struct nexthop	*nh;
+	struct nh_grp_entry_stats __percpu	*stats;
 	u8		weight;
 
 	union {
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 816ae8ee3e06..06d65e27553d 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -480,6 +480,7 @@ static void nexthop_free_group(struct nexthop *nh)
 		struct nh_grp_entry *nhge = &nhg->nh_entries[i];
 
 		WARN_ON(!list_empty(&nhge->nh_list));
+		free_percpu(nhge->stats);
 		nexthop_put(nhge->nh);
 	}
 
@@ -660,6 +661,16 @@ static int nla_put_nh_group_res(struct sk_buff *skb, struct nh_group *nhg)
 	return -EMSGSIZE;
 }
 
+static void nh_grp_entry_stats_inc(struct nh_grp_entry *nhge)
+{
+	struct nh_grp_entry_stats *cpu_stats;
+
+	cpu_stats = this_cpu_ptr(nhge->stats);
+	u64_stats_update_begin(&cpu_stats->syncp);
+	u64_stats_inc(&cpu_stats->packets);
+	u64_stats_update_end(&cpu_stats->syncp);
+}
+
 static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
 {
 	struct nexthop_grp *p;
@@ -1182,6 +1193,7 @@ static struct nexthop *nexthop_select_path_fdb(struct nh_group *nhg, int hash)
 		if (hash > atomic_read(&nhge->hthr.upper_bound))
 			continue;
 
+		nh_grp_entry_stats_inc(nhge);
 		return nhge->nh;
 	}
 
@@ -1191,7 +1203,7 @@ static struct nexthop *nexthop_select_path_fdb(struct nh_group *nhg, int hash)
 
 static struct nexthop *nexthop_select_path_hthr(struct nh_group *nhg, int hash)
 {
-	struct nexthop *rc = NULL;
+	struct nh_grp_entry *nhge0 = NULL;
 	int i;
 
 	if (nhg->fdb_nh)
@@ -1206,16 +1218,20 @@ static struct nexthop *nexthop_select_path_hthr(struct nh_group *nhg, int hash)
 		if (!nexthop_is_good_nh(nhge->nh))
 			continue;
 
-		if (!rc)
-			rc = nhge->nh;
+		if (!nhge0)
+			nhge0 = nhge;
 
 		if (hash > atomic_read(&nhge->hthr.upper_bound))
 			continue;
 
+		nh_grp_entry_stats_inc(nhge);
 		return nhge->nh;
 	}
 
-	return rc ? : nhg->nh_entries[0].nh;
+	if (!nhge0)
+		nhge0 = &nhg->nh_entries[0];
+	nh_grp_entry_stats_inc(nhge0);
+	return nhge0->nh;
 }
 
 static struct nexthop *nexthop_select_path_res(struct nh_group *nhg, int hash)
@@ -1231,6 +1247,7 @@ static struct nexthop *nexthop_select_path_res(struct nh_group *nhg, int hash)
 	bucket = &res_table->nh_buckets[bucket_index];
 	nh_res_bucket_set_busy(bucket);
 	nhge = rcu_dereference(bucket->nh_entry);
+	nh_grp_entry_stats_inc(nhge);
 	return nhge->nh;
 }
 
@@ -1804,6 +1821,7 @@ static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 			newg->has_v4 = true;
 
 		list_del(&nhges[i].nh_list);
+		new_nhges[j].stats = nhges[i].stats;
 		new_nhges[j].nh_parent = nhges[i].nh_parent;
 		new_nhges[j].nh = nhges[i].nh;
 		new_nhges[j].weight = nhges[i].weight;
@@ -1819,6 +1837,7 @@ static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 	rcu_assign_pointer(nhp->nh_grp, newg);
 
 	list_del(&nhge->nh_list);
+	free_percpu(nhge->stats);
 	nexthop_put(nhge->nh);
 
 	/* Removal of a NH from a resilient group is notified through
@@ -2483,6 +2502,13 @@ static struct nexthop *nexthop_create_group(struct net *net,
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
@@ -2522,6 +2548,7 @@ static struct nexthop *nexthop_create_group(struct net *net,
 out_no_nh:
 	for (i--; i >= 0; --i) {
 		list_del(&nhg->nh_entries[i].nh_list);
+		free_percpu(nhg->nh_entries[i].stats);
 		nexthop_put(nhg->nh_entries[i].nh);
 	}
 
-- 
2.43.0


