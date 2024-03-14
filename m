Return-Path: <netdev+bounces-79900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A767A87BF5D
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8D81F22704
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2218071726;
	Thu, 14 Mar 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="svY8Og18"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE43B182
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428185; cv=fail; b=Sew9No+4gnEmMMBkMPBn3z/mQ4t56sIJ3T4H6xcCVBVAXeu2KNP1b4OcFti/Aju/jZSgmeiM9GJqZ2I0jYoPHUeJWyaxilKOjuVuYJy52l6aAaEBu70alvws+gM568i1HcsTxvsXMSn0GCpRA03hI9jmy4gTfEfv1vFRWrMLlCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428185; c=relaxed/simple;
	bh=/bDWdh7/JKRsWfYMSgBbr3zbKedpGvjRfhPb+sa+LeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtcsPnc9l90VeXhnJxIDjllPzQ4zAp1Hpzi4UVZV+ELZBkv/sXYRQ684OOeHwqmdKIJfh6EoEp9nrSb5+c9PShH8MJzPDBO+L8FYjZ4l2ybHQwFkMGWXLoxCXiYZMIK/FQule8t0DBF6vWYE+PPT3BGEeI/l4T0TRXXrLmfUBao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=svY8Og18; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuoRS7bkn6K8r45qp2SbvhvRrXPC++8+ocinwRRYGNKolwfxaxcgdkXdP2KZd9/sUlSG4o7rENHq7clNHC03dRz+2XWAfk4f4vcaMIYKa1xZPZGpoNIQbkKwfKtz2l0RvozDKXBbVhOHMrHPYdzkHGmZhs70Ba3gb2yGV9HzaxKXFWMV7R3ZmIcYJS0Gy5NHVHSbiebiSw36kVhwZO2J8TiaXTQO8ZfFvZEo2BkaTe9qv6JwicxRh7SiMYJNTfQUQ0BBFc6DnkugsT2bDBzh0vDB/0jVwTzd9Ry5V4DHsuLe3cBykmHnq6lmIFPmA2VtzgGvUjuenLVomerejCQbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr8BR33hGdyABqPe4lj+2KTyLdZCjRtKmSxqGgcwIFM=;
 b=BvQvmNgiuTLDkQajm4/hAomJDBmxzVKIcbDCO/gDhbG3Mfw56b6q5ksgTIeKBykz3L8dRjjTfZ/tLF4g7V4UJn55wBZuxccGeCgF9cSOnW9Z8/l5qTCXjzghTARsEvxs7+pnn42zkKbw+yQ9wozFnggLq9PFQKOGVZBXl3AcCronWMaWT53anEt6QfV2qrEEktypyF3jXibFFpchrr5b+Nnyk3An3TrTC229IRVkW+hUMgJwo8bNA9EMiVd1kuKzIpyM/B18yNbnc/VwbDhYl4giFbSMpFGQoesp7fa3FiT8uID0cVr/y/8ZbACAAeAvmQyP7isczJFLJmVjuwqKqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kr8BR33hGdyABqPe4lj+2KTyLdZCjRtKmSxqGgcwIFM=;
 b=svY8Og18PUJZJ54AF2KngfhyyI8ZBgoB0iNUCSK0HnQuENv3M2sqD3h5tK0SNDW0P6596H+XHc+RMOHJRZSszmlnjtnqDZbq5dBaFZDMttDkwd8qW7GT3q4mujO6bNon9sPwzllBwwnZb/y1CsD2xovkf3yG9fV4OMo4qM+AGPVyTd7Lwa20HqI7MKFNwM00oEXVuOPR+QNgbPi5gIHkEmAlVVmvLEA7MyHp/vL+cJOnULnkbi6FAz5GZVGbGJiJ4m9YKCHXZjD8Hax8H21em+oFy3nFVBP8jYkfmpBfjWdxMVL2BdbIKQJMlJX925HeJAJxpUI3iqUuth3C93ppSA==
Received: from SJ0PR03CA0377.namprd03.prod.outlook.com (2603:10b6:a03:3a1::22)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 14:56:19 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::11) by SJ0PR03CA0377.outlook.office365.com
 (2603:10b6:a03:3a1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21 via Frontend
 Transport; Thu, 14 Mar 2024 14:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 14:56:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Mar
 2024 07:56:03 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 14 Mar
 2024 07:56:00 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Jakub
 Kicinski" <kuba@kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH iproute2-next v2 3/4] ip: ipnexthop: Support dumping next hop group HW stats
Date: Thu, 14 Mar 2024 15:52:14 +0100
Message-ID: <51d1686b5a2124b67a796945e117ce824c012811.1710427655.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a5526e-50e5-4d07-a207-08dc4436e82d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QLg8oXohrNhUqExMkikZX9jW00N+PFpG2asEOYfIjGnSlh9YY7TxDO0HiAzqe0+D2AIFMpGM92j4C84uPYk6Hy2CeuE1ztTyWZpgFRuyUbWC/qydyaP/gzmwiy64pSjnB488nsNXf0V1XjCUnY3C728XLEFN59POCjEkG2ppUTGPNXaXSRcDU/J2us7y8fW6kPQin6sxLF9kLukRrPBnfkVqgcbYFP6Oroxw7OOS+5Bvmd7clYp70UxRe16uVI29WX86FLIX1NYjEMOnBUS5e7einfwUX2c/W5pyjNtMMWrHI3czeKm9JXBGyw91C4IeGWM4tw5T4ksMIA02wNSlUdFRVTA7Fu9i/gZIvNHhZscHggcMTulMQIsc+QE+Lp95eusrJU3mCRG7NU0WJpB1opNbZPbQ7fu2fcKzSFLxiEukNPVByAY068JrrDNfw7kfO2+GNfOnKR0q1iO0JfAnDikDMZluVYmgqGGJULKucf9iglZbtusm0GldlBJgXtpPMU0caCZT7hr1l2zTw9BX1js8sx7RLErV7cnjndNB4NB7gnyM3vXPR2bSnEQZAUzIXcYi291uvYPCLych0LmfNuudHVIkkLTyBEjlXHBJPj6FysakO76S+Lx8a/3KrhQ+tuXyFmtayF00EDkSzt+srkRuvIbZXEKKZ6ujTMr7Iv2f7ETaFs2kWaklgD4JIb+gAswvDsVyQkjy7dKVI3BvflQ6dj3oplZEUWhh8mRMgIMAiiWV0uSZshJdk7gSqXyV
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 14:56:19.3682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a5526e-50e5-4d07-a207-08dc4436e82d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576

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
index cba3d934..6c5d524b 100644
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
 
@@ -395,6 +400,9 @@ static void print_nh_grp_stats(const struct nh_entry *nhe)
 			   nhe->nh_grp_stats[i].nh_id);
 		print_u64(PRINT_ANY, "packets", " packets %llu",
 			  nhe->nh_grp_stats[i].packets);
+		if (show_stats > 1)
+			print_u64(PRINT_ANY, "packets_hw", " packets_hw %llu",
+				  nhe->nh_grp_stats[i].packets_hw);
 
 		if (i != nhe->nh_groups_cnt - 1)
 			print_nl();
@@ -479,6 +487,15 @@ static int ipnh_parse_nhmsg(FILE *fp, const struct nhmsg *nhm, int len,
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
@@ -555,6 +572,15 @@ static void __print_nexthop_entry(FILE *fp, const char *jsobj,
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
 
@@ -567,6 +593,8 @@ static __u32 ipnh_get_op_flags(void)
 
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


