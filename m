Return-Path: <netdev+bounces-78872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F93876D27
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 23:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4D8282F18
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8DA22F0F;
	Fri,  8 Mar 2024 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FdeZZ3Ht"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36A17C8B
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937126; cv=fail; b=DXSh7KN9JyL7ql/1xiFarN/1VKMRm1z9z5tQD9fZHbFobfShw3XoMG8XNQ+fgs73GCVYZ1fiX5UFV2s/umEcvodPFpoiTZMqFRvP/6qfpnE+olDuUbt1MMwMW/LK8OtPNfrFVRuv4VPjggWi6KcuRNlgw8Lmdyx+s0HsmMs4+wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937126; c=relaxed/simple;
	bh=WcaYpHIw+ry4CIad+KziRU6GugajNsL9W6zwWKShGAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CK2Y4b6B3jfLPGMEbyN8GM+P4hnZ9a1QjGcYeDROY5uR6TfPjBsco4aqad78WneoisthzNeGv5ImHH1vlmsQSeH3O9RoaCr05kk/LNMLATmHYe2PlcTWEFUCFBC558AxvVCVNngmpiQpBDgV7AZUpGN6d27M2ywzINE6hiSsjAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FdeZZ3Ht; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aea+9RGX3akiSHkfO0dAw6YtQE93F2al2Lr5J+gBAMCS29zmqIweGa78ZCMlFwpWqTAc1oLDrHrAipGYR+Bx0OYY7KxY4uT/iMJXa7bAV1XVBAIQ+Anf+VqSPelCdFWFyiSYQfxZK5xhcnDRwCcBCE4QgOqRwwrhW6auYF7m7MVuKOrqQNlSbSFW4IrCC/P47p2G75nyxaRys+Iv9GTl6uKsLP0zahurOpTpPVdX+UbjCaekU37VXREiwJ1CB3vW4AFtRQFFbfde/XSoC4dTZh6p+qCgTMjZX5URvSjGWTcKLgeqvBOMdbvem0/AK4nsrssO489Q9a8BVVdUnmjlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0S0cmg2HgDK5qvBdiLfwlpkKH2CrhkQrfRxdy9x85c=;
 b=XjRGGdHgbyzkP/VHKGst4D4BJoHoXK4wQDO3faesOCJhWi7zCzHPQYwK9hSKAWNygGYe4pePBXPJDsujxuTXRTyXcGF5HoE25MP+/cEcFnaRRT4bNAhWiESzpbauH2ldD84zDQUyx0D/0SgdyL8hlxITJx/H55PZ+QdRKam/NZnPJafhaci/cyW+riE0iPuYofFVeSBaROwA3BJqri/ZBUA58uOMkwwgJ6GCuTTmprol9bI7hNT8i+PZmCy/f90hYxNemwLt80Pw4eLSMI4tVGO7eNbmBUcbf/5vVd/bUs38OzFNmGbPXRcskuuUDbOna0jPy1UGa9BrGc9/Otqn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0S0cmg2HgDK5qvBdiLfwlpkKH2CrhkQrfRxdy9x85c=;
 b=FdeZZ3Htd9rcDPvncbKJB93KhCL69T6QzEW3Nm7Z1sAjsJLIVhHpd9MR7Xt9EFYvNdeHMk7v9BqkHfBvpzbGWhQfy/R7f/28XzcUg6GALFxsr+OaiLjP56C+ucvrbBm4ECQ860I0t9uNfFiehWO9IrkHZWAJVGHfq1J3q+aySx62fVE3EU9z8HtBzUba8zG1EDOoeKp+NHK4rSs/9A/+0+9wesNn5oCosVun3my28jass0dEPDBlu+MFoe9dhVmbw2rtX7z1+F83L0R1uGOluzLHh3D8JvQfmW4vmdO79lTk8e1+VjCR86xDvsUvcVH9Hp7piQix/7dEZIebZv+06w==
Received: from SJ0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:a03:39e::34)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 22:32:01 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::e2) by SJ0PR03CA0299.outlook.office365.com
 (2603:10b6:a03:39e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28 via Frontend
 Transport; Fri, 8 Mar 2024 22:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 22:32:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 14:31:48 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 14:31:45 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH iproute2-next 2/4] ip: ipnexthop: Support dumping next hop group stats
Date: Fri, 8 Mar 2024 23:29:07 +0100
Message-ID: <d28e3c81f9a6f57efc21c1275d9bbe659ea6abe5.1709934897.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709934897.git.petrm@nvidia.com>
References: <cover.1709934897.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 10aa978d-9f27-413c-edeb-08dc3fbf9271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U2jNgMbI/ghX7dwrm/32UgOz6fi13J+ZzHgoJrnzUgP3ktDgquXjVJXuG5OPIcZwuKaIV04c/4wCN/0s2ZY8j3rY0rfO8aS6vheyHhfUOM2Y7aboh1KTmvsecoBNa0kzopcSWBobQmN1XUiXpD4T9WZapbnm3CpiDI9gB9MZtns9/abs04DhUga7f/82jqRN+0ZZwFhEHm5Gxx2mdUCqc/btqYSO099sbtlzzf/s/mJ2Tu2OUWn1vgDu+aoGxpIetNAsuxdHh8Gd4GvZuLuZ1Tj+q2fBRbSBtNZSPcLwHSLgsVWFcwu6j03shLT612fquMMnYdf3CQQAxSILuYWXB+cH+GA8qBAa2MX6qWcT5cM1REs/SOS+J0ZTfEQ2mhnyxr7zMtdp/TqDCAp7Dk+ah6wjz3sMC3AgyjfcZy5UlfFL1thDZohBZpn8pc6dy6dFqLgA8lY9efBqVEr9t7VZJsZhs5s9tHyQ0OUeohePhwVSHtjO5y/F21SetQyMO4yZfaKUChJKrGG4G9fgdvvyFCZfxLq3vD8fcJU1MB1o2CPbYCWVoe2uTgJ0rwFtuJb6qcw9OGaMxqDT6acoaxNPuuH2V6xA23RT6FHOoMlCZG123dlkacRz5DdQiqWAzzHvhT83wdMuJrz8t7fg1bZaSBowEVZ9PMeNQwfCRk5l8Y0eo6WtWso5Zd8x8dv+Sdw8vAZstTRgiiaaJLXBD98Mg1wfTHQnBgWzzmZpsPd7VDArSNj2VGf3V+9KJOI9B6OS
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 22:32:00.7698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10aa978d-9f27-413c-edeb-08dc3fbf9271
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099

Next hop group stats allow verification of balancedness of a next hop
group. The feature was merged in kernel commit 7cf497e5a122 ("Merge branch
'nexthop-group-stats'"). Add to ip the corresponding support. The
statistics are requested if "ip nexthop" is started with -s.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 ip/ipnexthop.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++
 ip/nh_common.h |  6 ++++
 2 files changed, 93 insertions(+)

diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index e946d6f9..8aa89546 100644
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
@@ -343,8 +377,33 @@ static void print_nh_res_bucket(FILE *fp, const struct rtattr *res_bucket_attr)
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
+	print_string(PRINT_FP, NULL, "\n  stats:\n", NULL);
+	for (i = 0; i < nhe->nh_groups_cnt; i++) {
+		open_json_object(NULL);
+
+		print_uint(PRINT_ANY, "id", "    id %u",
+			   nhe->nh_grp_stats[i].nh_id);
+		print_u64(PRINT_ANY, "packets", " packets %llu",
+			  nhe->nh_grp_stats[i].packets);
+
+		if (i != nhe->nh_groups_cnt - 1)
+			print_string(PRINT_FP, NULL, "\n", NULL);
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
@@ -418,6 +477,16 @@ static int ipnh_parse_nhmsg(FILE *fp, const struct nhmsg *nhm, int len,
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
 
@@ -484,9 +553,23 @@ static void __print_nexthop_entry(FILE *fp, const char *jsobj,
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
@@ -500,8 +583,10 @@ static int  __ipnh_get_id(struct rtnl_handle *rthp, __u32 nh_id,
 		.n.nlmsg_type	= RTM_GETNEXTHOP,
 		.nhm.nh_family	= preferred_family,
 	};
+	__u32 op_flags = ipnh_get_op_flags();
 
 	addattr32(&req.n, sizeof(req), NHA_ID, nh_id);
+	addattr32(&req.n, sizeof(req), NHA_OP_FLAGS, op_flags);
 
 	return rtnl_talk(rthp, &req.n, answer);
 }
@@ -1093,6 +1178,8 @@ static int ipnh_list_flush(int argc, char **argv, int action)
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


