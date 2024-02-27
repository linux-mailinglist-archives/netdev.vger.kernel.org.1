Return-Path: <netdev+bounces-75437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21944869EF1
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C6EB20C66
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5573A14A4C9;
	Tue, 27 Feb 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eXcf0fny"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6A1487E3
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057903; cv=fail; b=nor8XXvDcJh4j5LLlqG2zIgcwOIf6IjJnNYzRfLWTnbqsQylcAMZ72nVuPHjprokVXT4Uzr5du+zXMgUCvY6Be3L20RDXc/sWVjGbR/crp/uVp5Vgb+ozeuE2r3l4TQdZjR3TvZ0ey5R/d6zvMCgC2uR0n+/tCQSyi5dk/SRg+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057903; c=relaxed/simple;
	bh=NK4G/DoFR69r+yTYTzyCA6bnaKk50ahtKfUj7AVuchU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXyiCq63TsMGHZeChFWB1aRN9qQHdbhdX2ToEq35ju7+Iyg7LzSDiI87J6T83+SiPidKsS22e14By06s/0jmx4aednjtDLj92A03qPCrz3HlsfB4jEdMIhBPQzvDigFUUx4ICaQ6tXcpHXU8bhLl0bXYeWZpBkNQ9bTecqZg9is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eXcf0fny; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+SZ2NoO/a+ZQ1bkX0SZ6m6rCvyFDeCKVIw8lVfRSjIkfXpfAJWYgwD8Y0OnBl9NQhCRRD/LJNh4Mgbw2mxnvaDIDcyFEL8Aysa6C5/FQUtOHA2OMBfTmu1rqAviSTvC3ILeOQT8S1BklVf71Mil5jdY6vYOKlwZ6e1Ed0N3b3tlobU2w7FW55t1uFH+RHdHgCODfFs11VH5GNIbqLimCgFJyQexXmIEAqIAFiHKIiW665tv4qK/31SFps0kHkv+D4ZqELUwmJLqgAq9sns1jLzzstefJxVpckott/UBB1ki9qS19PKWTRYuSOu9gzk0L8e30eLxkca3N8I/fSmkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X87g2KP+W50fI5wEti8OmUKBR8DxCkNCQAAy5JyKT60=;
 b=R34ZnibeSljUVe26yF+olAIJu18XX+NkRt4wE/yGGMyY9SMwL6LUJRqdeHvHwBVVU503QEXQDmPMkHIsAXHftahGhUG8onYmVGx1Km5Fi6+2K6APx8zht9MnO7OSXs++E4ysIaLOZM75QnFSf4TvFKGrLRkDKMmLPnFF9bZ3F+VFe2X2YZrloRdw3YMnYvWgJj7Zoyggji0ZIFvu1hLvx4JQB9EAhERriC+fR/YEgH9huM/avemTT8Rb2UEjCV9TACvYCMYXydVdTbe+Bavs2ldZ8lLiB2v0BRvsetzD0ITdvLVZsrxxJnDsT25IgaTK48pZgTpEcIkLDULCfG4sSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X87g2KP+W50fI5wEti8OmUKBR8DxCkNCQAAy5JyKT60=;
 b=eXcf0fnyJGBaHfyezIeVmrouIzI9o6b9ITZ/T+vOHceuXMlFxFYNRMXcau5iN6BFvY7tDIcTfjhi+MsksdYuEWyRGQLTZYNKlrahC1OcP0XIhD8vu8WTnTnrudnOaQSboVnDGkHwwoGbuv2fVMagS4sg+E3jD37kFFUirtzqf2WVv419t9FIqHmEYkxHYUESWJJhdKPzRszssM1d9Jd1nDaEd8uJU7VgDrJJGfaF0UdrVwvYpKWL6ZYA+dEwKcveuPAgozOkz8oKrIg3Zv4rKg5Vx24bu+xbr6dKGpXLyFxtePc3Il244rn0k4CXUjyEiOboTs1fjBIINP58LNmtsw==
Received: from CH2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:610:5a::30)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 18:18:13 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::30) by CH2PR08CA0020.outlook.office365.com
 (2603:10b6:610:5a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 18:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 18:18:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 10:18:02 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 10:17:57 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/7] net: nexthop: Add nexthop group entry stats
Date: Tue, 27 Feb 2024 19:17:28 +0100
Message-ID: <7b6e4e106f711bf25ffeae1da887f2ef53127ce8.1709057158.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 24177752-4c15-4fb4-abff-08dc37c075c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2PN1ipBCCf7sJEZOig8y+Wujx/5y5syQLIz7HC9K+Lukuvm96XX3KckwNGnUt+Jycwb6p7OACByYUFQdy/Q+zrE+CErURYCoML9vWrNLFsyebUI7nnyb9AskON9H298aDRCRyPS1jekXO4QNl5mD53vUyDMtHJMBqLDwJt9O7st90sbqdHQ8aPBOuDdxZs1k6E9F+qKpNeQBjRzmStZJm48fnU8LVyXQSUCQR3WcPEMNZ7MIxxRIDOUwMl4cCwPIgUCBMqj6REnCMpENf47Q8ytkxCaa3t1KrlhWRswuqIUfgxd4xQEkXYpTU/+DrpDRwfJ3xxREGkjjFKaKAPgmbd2jWiyjZ1t5sddfEzpa3bsVZRARqCCfH1FoxhuHwt+jP1Z+uMG/xCZUGSwNXH/HwqKrPlSxFbvdczJ+Yoq8lDdbCCfW0iks4WDBdlw7wnPLFmhPtZhak5n/RpNCltA4Hx2rgBmbjcwrDVaKjfSAkayDVE6G9ViqaC9DNp5S3iaM8Wj6CqNjCEKikhkmTGId9fdAADFrVBlb0qzbHiJVtvGj5OYvAPpENm2tiNWWpCpdbcF1xnQ765zEZIOsZd4EhsnI/SZi9WzCjhKyYl0SJHgdcKdE6lcLMydbAYIgV5a21Ba1j5E6ls9C2D0NtRDxlj1OBn6gyU+dJvDuJVnXEsbXV3Ydrgvb6dkTt0kpzqzVQVzvcpVSi8GYgTdNCDLgxChCHzg4Pk6FkXpieN/mrL8TVdZm6lOxrwn3bESW/TJ2
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 18:18:12.7317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24177752-4c15-4fb4-abff-08dc37c075c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176

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
 include/net/nexthop.h |  6 ++++++
 net/ipv4/nexthop.c    | 24 ++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

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
index e41e4ac69aee..29d0ed049b91 100644
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
@@ -2483,6 +2492,12 @@ static struct nexthop *nexthop_create_group(struct net *net,
 		if (nhi->family == AF_INET)
 			nhg->has_v4 = true;
 
+		nhg->nh_entries[i].stats =
+			netdev_alloc_pcpu_stats(struct nh_grp_entry_stats);
+		if (!nhg->nh_entries[i].stats) {
+			nexthop_put(nhe);
+			goto out_no_nh;
+		}
 		nhg->nh_entries[i].nh = nhe;
 		nhg->nh_entries[i].weight = entry[i].weight + 1;
 		list_add(&nhg->nh_entries[i].nh_list, &nhe->grp_list);
@@ -2522,6 +2537,7 @@ static struct nexthop *nexthop_create_group(struct net *net,
 out_no_nh:
 	for (i--; i >= 0; --i) {
 		list_del(&nhg->nh_entries[i].nh_list);
+		free_percpu(nhg->nh_entries[i].stats);
 		nexthop_put(nhg->nh_entries[i].nh);
 	}
 
-- 
2.43.0


