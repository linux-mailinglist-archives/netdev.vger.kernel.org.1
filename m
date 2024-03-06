Return-Path: <netdev+bounces-77903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F67E8736E4
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538E81C20971
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC480028;
	Wed,  6 Mar 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mIHAFs5c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76C12C53E
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729446; cv=fail; b=Akxicl5TgbdfAQ26McjYs9fA1CzU8P/cPigJa2yCw1mzw1yLcXLeZoshXYyWZT1kreOkXIX7Q1WT88K+AIvSOg67woH2kd6Pqgb1GAi418X0Nb1ynQ/3EueQY37mQi/fkqNDo2J7hvN0cXS8nyqX/cLYLW4pj5zEJxru64oB48k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729446; c=relaxed/simple;
	bh=rF2k8iez4zNo5D1ysII2kXAYyb+hrVdW4Gj3QYLEGCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nkChPHehuIcSPi1Bj4hgEwRAO2OzqBLO/xontuD29oLarBEe8e8sZatFHSkIWW80ajSonGUQasCXSGqNFhX6u4qU2eu7kbFWxvJQWaPWj3pPPIq7lItL9naUGKyjiiSGrxea+DRKATf2e25Apx0PSSiALD5xA6mCMekdDgsnevw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mIHAFs5c; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOm6CkwAYLf1vIzrrVhM6E9myrwqJd72gFJpJ2htEtGqypfTq2OwokOnqc0mlt8mweF62+5V+ZloLCXXTDCWIGS3Ag209HiR9pP9HiPMbTvG1jqpofmKnNt9G18NRaprrMYOGVrwP63x5PVfVOV8l7x5ykqVFFtPsvL43B7Xg6ArKAu/gJodVq4Fppi4JGYU9xk+Lnrgr3TGAHYkcAALcQ9gX8lfg4fzQCBzD0rHYz+Zmhg1Zqp/ELFzoqV+9sy8Co2u/jq/CcUShl3EpuFecn/gm2WhvO9wprE53m2h+SQjkJDVbZSYmy+7LvFjicqDqRhUyj+d51MPOwRFApTN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXWiw2nFCTo7i0ddDdkQ/Q3QrDEBlUmug1FytdtHF/M=;
 b=d05UbIVHA/Cz6TYcQ7jiCel0S6fdOAHA0Le2gmAKygf/v8nCs7IOVyw2Swij+eI3krHaIfjRkaXXhudqQOWpeIG5jd2fYLJiN4my+io174nL6eD6QsMZuDjalVqmy5tk2tZl4f2/fjI4h3VWcYFavE9pmV5kuCEf0oTOqvA78mIfnP05dJuDw+/xBx7Qi2xm3kG9/aLR8ytUA0R3U2UXQwsrO5gqQA31CvxfFeQFlDtWG/srDpqGNBsUEIgi8DrLT7Jy6/1rT2EnylZsrMmGPQcFvLkVfJ7oWcR10yR1rFw7mcQnCT2FGd8EW8FTZaRlOc2SsG+skIM+6u3TpjbKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXWiw2nFCTo7i0ddDdkQ/Q3QrDEBlUmug1FytdtHF/M=;
 b=mIHAFs5cY0bELmBwVau1iX3LY3e49+ViFhagw63OOn4pIqH4tpSj3J8C2Qh/sMg8/STiKkEhAbj4CHi8FXQxXKWIf7sf0AgcGaLhTBNF+d5uhx4WwmaRTcJ3jcAklMk5IWTzmWv118Z7AqHd+7l5C1vdDY4++fOhGsT5ZFwZOSYkpvQObjLXcDEIny+h8kEgSkoDjkxCFMw6UZPLy2t8Tk03YrrlT9AjCcux00GpHnFwOLsAEbISvOlZs6PH9Z3MIRbA/ejGhMa+XxfjFv353OwHQg+3b865jbHLDHD03Y40OiDVUSklU267wnQENO07248TJtwcTnxHulrIaoQgsA==
Received: from SA9PR13CA0153.namprd13.prod.outlook.com (2603:10b6:806:28::8)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 12:50:40 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::2f) by SA9PR13CA0153.outlook.office365.com
 (2603:10b6:806:28::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6 via Frontend
 Transport; Wed, 6 Mar 2024 12:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 12:50:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 04:50:18 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 04:50:13 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v4 3/7] net: nexthop: Add nexthop group entry stats
Date: Wed, 6 Mar 2024 13:49:17 +0100
Message-ID: <0bb4e222c10fb1d2a84666a8b2b0725ef25d1fff.1709727981.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 271c99ad-7b61-41e4-15c2-08dc3ddc06f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sgSKXFyAPibjkdA5XeIadW4XhtP15MSzDr5MKTHUgFYLniV29BjVP0S3pZaj9lGQ/YbLaD6+9CVM32njqxFJHQ3czW74qwG8i3cXQ/mY3/SLF2uiTWx9JjqrY81glQAsLrto5n0ivsVQLN10GgOM0rfxaQfMw22Ep3AEqyRMphh4a8K6EFlkaK9nmiGAXEVma+d04nECZsplKS0KYf4qYFgRvAfWtkzElZqn0FhnMqhnB4NL7zG5pCHeDBtSlCkefM8YtJumbE8+5xllmEHxd9ZEzjUhX3Mo7qFoDnUtVnMQVYFZlHXyyq0cAeNPVdzwMLcSUeUinWDZsQQ6y6yweqJn3uDiY3ReqUndavx34VLZcfowYGePDVTUrHadblgDC8cMzLeN/qpPwdQMj/Utl5zKbW08AQhLkf1OXZ8QV58w7LBoXf2sQBtncOnpplDdCAv8as4S/bVT0+Y00Nkv2yz6/B5vUsAGMwTvDL92oEzF7Oagz/p9GEUPhDnOzBKur1C3F4WZLgbxezX6hRAUx1jk0YDO8sz5ehblCqnwNxBI7kh8bzpHyMxXgWO8kEoxh7RMkx27/LdXhLtq24dEubRfue1UVuaaaERNpMwd+HlGGOlrmFg9k1A1gZX45KOi5OT0yD+K//Y0xEScTJdYDKMXXZ7tBsRw8W2gF9Sr0G+PcC/ctoEIay/2wbvIWfeyHn7JUxAKAws9S32DmMNcYssfyUkAU8oG3s22zTubTuOaacI2LJrN2vNEDtUOBVsm
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:50:39.7342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 271c99ad-7b61-41e4-15c2-08dc3ddc06f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749

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
index 576981f4ca49..92dc21a231f8 100644
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


