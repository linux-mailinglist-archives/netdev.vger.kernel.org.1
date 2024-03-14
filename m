Return-Path: <netdev+bounces-79899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B8187BF5C
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F00B1F2340D
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3B271727;
	Thu, 14 Mar 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FVH0Tw4R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25971735
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428178; cv=fail; b=r0OFGZt4N0jq/rj9m1aKWqg6iZnS/n1ZL4Wys4wkA782PkldWFt5UQUC68ojh1O0bVOwW+2t2IG/l8TUokNjm6lpaWrWhA0uJfI66crSHcWZMTHB7kq044tt1uArCsZdmBv2zXENJcFXufIG/9NqpJP+F2sf2DqugPciaUZI6mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428178; c=relaxed/simple;
	bh=uUwSYAGpidRzK9RpHnrZHkCVrqN6xxxuESoVcyVOo8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fi/AEIcb01YsBGavM/qi4Q7xtIkOQ9WytaeVxw8B8+JUeuQKFp2u2ZQ0uzm8iHI0azoQNzE8+j8SFHq2QoAQ0s/ZNkFwt29avLF28/S+Uhbpz7+NWYkqJlsa1PzMlSJRVN1W3cbmAV0LbH60ac8d0x/5mBJWZHrfa3wvsY5WQG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FVH0Tw4R; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXxGHESxrZMiJh+2R6nWW3UFlGtdCPHAMgNZOC0r6hxvPUDl8N7BLHwLej/FziBkWn6TGGig/nidSxfzO9V6IVb9XVk0oQjM/xRGIMqMvnPrr4pbniQBkWZdIxTBQ7Teosu5Tf0E37wL/W7P0HGBTVdp09LK1hq+c+67u3+5B0lby/6XpIqXQ3opYiFDMVrujmgOtKmOZdoej21bXtMs5SUJYGmiLHmuUuJK2RrK+zv2miEIQVzRGNmijkCK8+XcIJU9et9FaRIkT1xHYAkTlA5fN9uH6TwJn+uIZ3gEtkZDrdMUXnkoyW+id0GmgMa/3M7ae6UhxSdNACqwA2uofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wXGl072B94HOE1sfE+IEYopNKbrtvmEqzK1KSlmZnY=;
 b=RiJ8g14k89x5eR8QzWYovedfgjKjnkKeJ7uNFfjf6IMtd2JnnZ6DG6DNJFJ3Pfwnr/kPJREr9Mz2douoaQEWMsrec/+lTrcXVrRPjXbL7oiW2NVVpsMZjOrD8zbNs6NJkRhMD/Zb74mO9FFvMw4ItfcDS6OnAlj2sskiQb+e6DErzQXda8bHhUnSJyUcuGKTmWB7Lt2zsR3cBZIw9gWug4oOeHtP0SI9rDjgNaYM3zDZC+6fK4v5gkAeBHjKQ4FBLgoujlQapzkdCZ9P2ufm2S4CG/hdUAMCrMdv2416x3N0ist8C1gueDgcJg2jXXEmRxsTRHicq+c++hu3xagNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wXGl072B94HOE1sfE+IEYopNKbrtvmEqzK1KSlmZnY=;
 b=FVH0Tw4RpqOx1Sw35EQo5uTj+8PVUVu1Y4wekwHXfgrc67hZ0jakD9X5xfoCFdvKpKV4BQsSsHxhADeHUklgLlzKIDEtlBa6ggnkccDLiRxi7zGzDwWu9wCfekef9hTKrKK+X9ZrEomh8UONXKRGUPHWpjFSKJ6+T9zAgm3NMDI+VfkkZxaUSiZ80FMMVqvHcyBwg+2MIQFOnlU3K3r20+Bvwo52tznnaLcP5KCmYXOUtgfRWsV6D+j2kii1/dkjybwziQ1lLmCX9HBc2WFiXPXOtCUtTXgYDd9lVwLRVvyOuogMDoaLZnaMmacbj7Fu0t7YV0dxv/CRdx8o1kEXjg==
Received: from SJ0PR13CA0071.namprd13.prod.outlook.com (2603:10b6:a03:2c4::16)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 14:56:12 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::8d) by SJ0PR13CA0071.outlook.office365.com
 (2603:10b6:a03:2c4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.8 via Frontend
 Transport; Thu, 14 Mar 2024 14:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 14:56:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Mar
 2024 07:55:59 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 14 Mar
 2024 07:55:56 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Jakub
 Kicinski" <kuba@kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH iproute2-next v2 2/4] ip: ipnexthop: Support dumping next hop group stats
Date: Thu, 14 Mar 2024 15:52:13 +0100
Message-ID: <66b2df7b7226a5a25bfcf32c9ef7f41394729ef4.1710427655.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1710427655.git.petrm@nvidia.com>
References: <cover.1710427655.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c851de-c451-4efa-a260-08dc4436e3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ksb3Z41F8Y4P86L186JHLEQfD4UY6ww6xB6KoRwr14ocVLVGp2emrBZzJ0mwBd3SPodZLM5/WZ2GNU9CvlxQ3KMEZhX0OfOQeEi85F9TJwqaTHfGUasB4SjhCeBXcvGZB+EB4o9dgeJEp9lZ754Z5gJJe4dG1F1eNrMuRrh6Oaq6hM8ETqlZJ6VYxiP0+400BotpYXIGpBVcOFMTXidCks5D0U7Fv95BA4TiByROMctVqlyRqMW0xvM+ewDJuxYDpIR3ILkOFz2IvRAJDJk2Fw3uRCXdBPIZzOsS2AFLMuG0Jl2hP2V6JIQ6c4gPuPFNJ0QqR4WUxo2Gu1kaLg/6gVx2dFg1NIWf/Hicv0ETpNUDj3uD4eBgqc6dvwpdzqWrUHNgCD6+eULghPzhmTz/N1vXEKJzFIsODPeXojQF8wlyYy0+i2Zm1aSvw7YgpmKz4L07/isS3koC2bqqR/UU1Es3ft8nL1KcX5ZVLhY8MsZrhgfG09icIUSMXLs2ZZaw+XAuhh7oVw5uiaX3SzkFKJuZHzS24y+O886Pt5/X03vdSFHfftO1b77YEEDkF9WOVPUlxmn87BB64J3GtheJ55qBu7kdThmOB6Q8DfuQDPT0d6XcVE4F6JlxHsISe4q0NXjSPYBd8256+Id0UI8aoAkKvhTQvp21IqWez1Tln+EoI9FQyO0E5q9BFLNay296VlhRvNAp1txvQrbiGuyRS835VB7Hm14lahyQ+VfsKJzt+FvLSnWbDD2zS/0S52E2
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 14:56:11.9692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c851de-c451-4efa-a260-08dc4436e3c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

Next hop group stats allow verification of balancedness of a next hop
group. The feature was merged in kernel commit 7cf497e5a122 ("Merge branch
'nexthop-group-stats'"). Add to ip the corresponding support. The
statistics are requested if "ip nexthop" is started with -s.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Use print_nl() for the newlines

 ip/ipnexthop.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++
 ip/nh_common.h |  6 ++++
 2 files changed, 95 insertions(+)

diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index e946d6f9..cba3d934 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -25,6 +25,7 @@ static struct {
 	unsigned int fdb;
 	unsigned int id;
 	unsigned int nhid;
+	unsigned int op_flags;
 } filter;
 
 enum {
@@ -92,6 +93,14 @@ static int nh_dump_filter(struct nlmsghdr *nlh, int reqlen)
 			return err;
 	}
 
+	if (filter.op_flags) {
+		__u32 op_flags = filter.op_flags;
+
+		err = addattr32(nlh, reqlen, NHA_OP_FLAGS, op_flags);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -296,6 +305,31 @@ static void parse_nh_res_group_rta(const struct rtattr *res_grp_attr,
 	}
 }
 
+static void parse_nh_group_stats_rta(const struct rtattr *grp_stats_attr,
+				     struct nh_entry *nhe)
+{
+	const struct rtattr *pos;
+	int i = 0;
+
+	rtattr_for_each_nested(pos, grp_stats_attr) {
+		struct nh_grp_stats *nh_grp_stats = &nhe->nh_grp_stats[i++];
+		struct rtattr *tb[NHA_GROUP_STATS_ENTRY_MAX + 1];
+		struct rtattr *rta;
+
+		parse_rtattr_nested(tb, NHA_GROUP_STATS_ENTRY_MAX, pos);
+
+		if (tb[NHA_GROUP_STATS_ENTRY_ID]) {
+			rta = tb[NHA_GROUP_STATS_ENTRY_ID];
+			nh_grp_stats->nh_id = rta_getattr_u32(rta);
+		}
+
+		if (tb[NHA_GROUP_STATS_ENTRY_PACKETS]) {
+			rta = tb[NHA_GROUP_STATS_ENTRY_PACKETS];
+			nh_grp_stats->packets = rta_getattr_uint(rta);
+		}
+	}
+}
+
 static void print_nh_res_group(const struct nha_res_grp *res_grp)
 {
 	struct timeval tv;
@@ -343,8 +377,35 @@ static void print_nh_res_bucket(FILE *fp, const struct rtattr *res_bucket_attr)
 	close_json_object();
 }
 
+static void print_nh_grp_stats(const struct nh_entry *nhe)
+{
+	int i;
+
+	if (!show_stats)
+		return;
+
+	open_json_array(PRINT_JSON, "group_stats");
+	print_nl();
+	print_string(PRINT_FP, NULL, "  stats:", NULL);
+	print_nl();
+	for (i = 0; i < nhe->nh_groups_cnt; i++) {
+		open_json_object(NULL);
+
+		print_uint(PRINT_ANY, "id", "    id %u",
+			   nhe->nh_grp_stats[i].nh_id);
+		print_u64(PRINT_ANY, "packets", " packets %llu",
+			  nhe->nh_grp_stats[i].packets);
+
+		if (i != nhe->nh_groups_cnt - 1)
+			print_nl();
+		close_json_object();
+	}
+	close_json_array(PRINT_JSON, NULL);
+}
+
 static void ipnh_destroy_entry(struct nh_entry *nhe)
 {
+	free(nhe->nh_grp_stats);
 	free(nhe->nh_encap);
 	free(nhe->nh_groups);
 }
@@ -418,6 +479,16 @@ static int ipnh_parse_nhmsg(FILE *fp, const struct nhmsg *nhm, int len,
 		nhe->nh_has_res_grp = true;
 	}
 
+	if (tb[NHA_GROUP_STATS]) {
+		nhe->nh_grp_stats = calloc(nhe->nh_groups_cnt,
+					   sizeof(*nhe->nh_grp_stats));
+		if (!nhe->nh_grp_stats) {
+			err = -ENOMEM;
+			goto out_err;
+		}
+		parse_nh_group_stats_rta(tb[NHA_GROUP_STATS], nhe);
+	}
+
 	nhe->nh_blackhole = !!tb[NHA_BLACKHOLE];
 	nhe->nh_fdb = !!tb[NHA_FDB];
 
@@ -484,9 +555,23 @@ static void __print_nexthop_entry(FILE *fp, const char *jsobj,
 	if (nhe->nh_fdb)
 		print_null(PRINT_ANY, "fdb", "fdb", NULL);
 
+	if (nhe->nh_grp_stats)
+		print_nh_grp_stats(nhe);
+
 	close_json_object();
 }
 
+static __u32 ipnh_get_op_flags(void)
+{
+	__u32 op_flags = 0;
+
+	if (show_stats) {
+		op_flags |= NHA_OP_FLAG_DUMP_STATS;
+	}
+
+	return op_flags;
+}
+
 static int  __ipnh_get_id(struct rtnl_handle *rthp, __u32 nh_id,
 			  struct nlmsghdr **answer)
 {
@@ -500,8 +585,10 @@ static int  __ipnh_get_id(struct rtnl_handle *rthp, __u32 nh_id,
 		.n.nlmsg_type	= RTM_GETNEXTHOP,
 		.nhm.nh_family	= preferred_family,
 	};
+	__u32 op_flags = ipnh_get_op_flags();
 
 	addattr32(&req.n, sizeof(req), NHA_ID, nh_id);
+	addattr32(&req.n, sizeof(req), NHA_OP_FLAGS, op_flags);
 
 	return rtnl_talk(rthp, &req.n, answer);
 }
@@ -1093,6 +1180,8 @@ static int ipnh_list_flush(int argc, char **argv, int action)
 		argc--; argv++;
 	}
 
+	filter.op_flags = ipnh_get_op_flags();
+
 	if (action == IPNH_FLUSH)
 		return ipnh_flush(all);
 
diff --git a/ip/nh_common.h b/ip/nh_common.h
index 4d6677e6..e2f74ec5 100644
--- a/ip/nh_common.h
+++ b/ip/nh_common.h
@@ -13,6 +13,11 @@ struct nha_res_grp {
 	__u64			unbalanced_time;
 };
 
+struct nh_grp_stats {
+	__u32			nh_id;
+	__u64			packets;
+};
+
 struct nh_entry {
 	struct hlist_node	nh_hash;
 
@@ -44,6 +49,7 @@ struct nh_entry {
 
 	int			nh_groups_cnt;
 	struct nexthop_grp	*nh_groups;
+	struct nh_grp_stats	*nh_grp_stats;
 };
 
 void print_cache_nexthop_id(FILE *fp, const char *fp_prefix, const char *jsobj,
-- 
2.43.0


