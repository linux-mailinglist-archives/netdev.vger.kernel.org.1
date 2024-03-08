Return-Path: <netdev+bounces-78874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25249876D2B
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 23:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90624B20E13
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F292C1BA;
	Fri,  8 Mar 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WtHrVFJO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D781DA4D
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937139; cv=fail; b=Bvqj5r/N/ABqqpjNbuW1Q/SmLEQDtzT/j9eXTi1xeRA2yPUVBkAk27R96g9+VU6p8q65vovpMzPjLYcRrpnAZWLYbTqi5f1JVpvSaR1xbz6UNJNuCHZFb1jX5/lrLH2POYbOm4ps91rn99HJmL47Pvoh4R+ThvAGuiA9F7kGexo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937139; c=relaxed/simple;
	bh=qzy9RkhJmcusQ9oy0awwTMNHcpFBVxDP6gwLWVW/D7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxeNOa3UX0GqUoKmgPrXYFPvSmGfcPHbMd81UpEkaeoSAJPCPvS49AztxCjYxeAkObUWFbB0AkgrHsxwKHE7VxJk+e0cfZp15tYZEe+gRksfTsjQW+Y+6ACyGVg25aIMXRyoHrn4QjAiHNpRdE+NNNDxzrgShalpAQpv44LTdVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WtHrVFJO; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZzMl6OYksvP35Dw9mMvYbU4UYLpJNv3xuoaTL1u67GWpb3w5SJogc0WzdmtxUp/QBzOMFWT2i+/cTQ4VNKQyRkn5dldf9ZpgHxaDbk+6ZQtZQzn5DBygZqGWTu2NNTt710/vktFLodz801XxKjiAk+WSMjshEZ23iy1YthCOT/fkZ3gsN+FYt3bG5yjay880zFAmiTlz0qZmEweOzr36c1qeIkXAY/lCYdutAZYTXuOCmR6cA/aeU5ssE5XRgQ44dKnoNy9Ch11w7PRK0j7yCYtycUnpWNd5CKgYNHpCUnEe77Y5ZGyABYX8V8bS74xOxR25SYN5GEoCfeV0A0SpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1HnXhFpBBNJDR2mofKqQ2bj8BvsXHCu21+1ZoWq574=;
 b=R+MiSR3kkFGXGQX3/pXCq3/I0TXYeiRhKUmcodf4pbGq5ZDifsVYbpjotmIknrBW/k07voJjk0puilw+1CqWnT+CR5c0bYBfbeVvf9fF8toB5mfSQ8I0JQUC99fQNBA/wODuSgVvtTa2kMaWViEQ4R9OFk0hDqhAC+mFbSEA9mnwSZnbigHlp0I50ylv7cxCY49rqZLpmaxNHVHr5r9esZg/GqbDTZwGNAeQWwT/dz2IGjHvyxkrjMi9n3vhLJOuknen802NCchlXoDqsqJe6ABFoQEjoF1/fT1vcbMDiLRDSv3y67Wrtl+udDy/AJTxj/KY/ZBOhqHGXAqX9wwcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1HnXhFpBBNJDR2mofKqQ2bj8BvsXHCu21+1ZoWq574=;
 b=WtHrVFJOBT++fLna1jcriLd3ZeUrUJSu8sdlF5juLkaFocDa+ihhe/kF4j+VqiSbOw6RVRfjylnVDxHIiG6IX7PTZlC8/uITusXe/HLqE48t+HEcm7EtvAwg0IqHIQAB/oWLizTWbhKzw/5D+21nhTJsX4IEm67Hbi8zdoxI6u9FOPCUWGzPPuxtCnJ2EHSEFe95ZcxEivncGPStl7o6xEGIhis4PGygPVkmJilWVNFYcquoQVycZJSTdIwqQxj9w5Ei0QjpoAb7DWruX/fR0MoS3etBxKMTLr7SVZwwZ+h6HwYt75PwnVUD6+UQdRh1aZ4dF7rdPhYL143b8JLDyA==
Received: from DM6PR02CA0156.namprd02.prod.outlook.com (2603:10b6:5:332::23)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 22:32:12 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:5:332:cafe::df) by DM6PR02CA0156.outlook.office365.com
 (2603:10b6:5:332::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 22:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Fri, 8 Mar 2024 22:32:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 14:31:51 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 14:31:48 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH iproute2-next 3/4] ip: ipnexthop: Support dumping next hop group HW stats
Date: Fri, 8 Mar 2024 23:29:08 +0100
Message-ID: <1dd1ece01c84251b201593c8990970e2884e4386.1709934897.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: cffba576-5f52-410c-5713-08dc3fbf992a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KwfEPLR2nDZYJQ9SrnYKelOEk3v+9XH5EqCjcYgAr/VHqm4219i7c5bMFV4xfd7zV96EDQonJigbDtUfQpHI4BBKovQ+9Go9jcZPqGC0APsJhN4Bd31I11v2GTLh/1FwoL2OiuuPs00zVSijpZz8U0v4gvIx6zO3T3+QJuFc669Oqi2hUUs1VdAkjDaZ5OeDJxdUGEYd6LqPm8+rDEePpLrwSCScxvaZik4+xcuA8S9tNSWpP08fX+ymXhijhJSDzmqT2eG7CqMPBCMNyWoMuUEQPyV7XQRXivjswKk/yYRi7gC/9ZbKnCSr0w0w3oXn5udY18/H/cPWg0nUziSn/2SOBmT1ygXkLc7R9iEywJL3/Hb060Xdp3SappVr86Ug1pwn7z8Ot+6J1+6XjBPBsDS139DIHo/aAylExN1B5KkZIjOOLxzK+iPVYSwy8Zp3UhxmnfDbDpuXiyFsVUGOZYQqb8qhyIZSEPweEFNMCVamqh2XcyJj4k2zYQChg8MKIia+DnDwjxRFaGJl/Kfvmsfx2PnjJcdrERws6mg6doqRAi7xxkQ97RBh+y2SNiJzV4lqAMTawqrmdrOSajq3Ty1Yx2mgjRc1tNa3+Qb7FGNKHRleLsjK1cWrTqWPDuBVBpsglm/uAgXL7cdhLDUlFGajVBnHVSW7LVTetO6y6DIrIwUDaXGiD03q4KxLkQHz+OCapg+TC4kr8TPc4dZBFvdUAHt2VJ9b3iMMvhPIHtrG2giOrk1NU91+GXncxgFf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 22:32:11.9041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cffba576-5f52-410c-5713-08dc3fbf992a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995

Besides SW datapath stats, the kernel also support collecting statistics
from HW datapath, for nexthop groups offloaded to HW. Request that these be
collected when ip is given "-s -s", similarly to how "ip link" shows more
statistics in that case.

Besides the statistics themselves, also show whether the collection of HW
statistics was in fact requested, and whether any driver actually
implemented the request.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 ip/ipnexthop.c | 28 ++++++++++++++++++++++++++++
 ip/nh_common.h |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index 8aa89546..573f1abb 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -327,6 +327,11 @@ static void parse_nh_group_stats_rta(const struct rtattr *grp_stats_attr,
 			rta = tb[NHA_GROUP_STATS_ENTRY_PACKETS];
 			nh_grp_stats->packets = rta_getattr_uint(rta);
 		}
+
+		if (tb[NHA_GROUP_STATS_ENTRY_PACKETS_HW]) {
+			rta = tb[NHA_GROUP_STATS_ENTRY_PACKETS_HW];
+			nh_grp_stats->packets_hw = rta_getattr_uint(rta);
+		}
 	}
 }
 
@@ -393,6 +398,9 @@ static void print_nh_grp_stats(const struct nh_entry *nhe)
 			   nhe->nh_grp_stats[i].nh_id);
 		print_u64(PRINT_ANY, "packets", " packets %llu",
 			  nhe->nh_grp_stats[i].packets);
+		if (show_stats > 1)
+			print_u64(PRINT_ANY, "packets_hw", " packets_hw %llu",
+				  nhe->nh_grp_stats[i].packets_hw);
 
 		if (i != nhe->nh_groups_cnt - 1)
 			print_string(PRINT_FP, NULL, "\n", NULL);
@@ -477,6 +485,15 @@ static int ipnh_parse_nhmsg(FILE *fp, const struct nhmsg *nhm, int len,
 		nhe->nh_has_res_grp = true;
 	}
 
+	if (tb[NHA_HW_STATS_ENABLE]) {
+		nhe->nh_hw_stats_supported = true;
+		nhe->nh_hw_stats_enabled =
+			!!rta_getattr_u32(tb[NHA_HW_STATS_ENABLE]);
+	}
+
+	if (tb[NHA_HW_STATS_USED])
+		nhe->nh_hw_stats_used = !!rta_getattr_u32(tb[NHA_HW_STATS_USED]);
+
 	if (tb[NHA_GROUP_STATS]) {
 		nhe->nh_grp_stats = calloc(nhe->nh_groups_cnt,
 					   sizeof(*nhe->nh_grp_stats));
@@ -553,6 +570,15 @@ static void __print_nexthop_entry(FILE *fp, const char *jsobj,
 	if (nhe->nh_fdb)
 		print_null(PRINT_ANY, "fdb", "fdb", NULL);
 
+	if ((show_details > 0 || show_stats) && nhe->nh_hw_stats_supported) {
+		open_json_object("hw_stats");
+		print_on_off(PRINT_ANY, "enabled", "hw_stats %s ",
+			     nhe->nh_hw_stats_enabled);
+		print_on_off(PRINT_ANY, "used", "used %s ",
+			     nhe->nh_hw_stats_used);
+		close_json_object();
+	}
+
 	if (nhe->nh_grp_stats)
 		print_nh_grp_stats(nhe);
 
@@ -565,6 +591,8 @@ static __u32 ipnh_get_op_flags(void)
 
 	if (show_stats) {
 		op_flags |= NHA_OP_FLAG_DUMP_STATS;
+		if (show_stats > 1)
+			op_flags |= NHA_OP_FLAG_DUMP_HW_STATS;
 	}
 
 	return op_flags;
diff --git a/ip/nh_common.h b/ip/nh_common.h
index e2f74ec5..33b1d847 100644
--- a/ip/nh_common.h
+++ b/ip/nh_common.h
@@ -16,6 +16,7 @@ struct nha_res_grp {
 struct nh_grp_stats {
 	__u32			nh_id;
 	__u64			packets;
+	__u64			packets_hw;
 };
 
 struct nh_entry {
@@ -32,6 +33,10 @@ struct nh_entry {
 	bool			nh_blackhole;
 	bool			nh_fdb;
 
+	bool			nh_hw_stats_supported;
+	bool			nh_hw_stats_enabled;
+	bool			nh_hw_stats_used;
+
 	int			nh_gateway_len;
 	union {
 		__be32		ipv4;
-- 
2.43.0


