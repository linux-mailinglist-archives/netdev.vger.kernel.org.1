Return-Path: <netdev+bounces-119264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3121395501C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FB61F22FC6
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD551BE241;
	Fri, 16 Aug 2024 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HEgN7NiC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3861BCA1C
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829931; cv=fail; b=JfWjVb7TV0539CahiylNXFBthyJdyu6oimTzx7lwdXOyUVKYemhz0eEZAX5Js4QyeeScgw81KDA0EUXTfB8BTE1RptmVqQ4ZlSuFS2K7UGHCxEDZ4TKhEQ4dKYY1DcbRGmBp1fF7z0GdyKXsPMz6BCToL7vN28rJ0iRuF2ytzFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829931; c=relaxed/simple;
	bh=3KW+RXZWgJP7hjCuSnYmFFR3EFH+rd8XBw7bRabl0uc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jq00kYXD639hdrFEbHeIQrJWhp6jjXibS4DHvfgj6oaSNVgyTpJKuiBo4kNQ9pcOIKLLHcETucW2iCZVt1DJSqfEespepk39l7XiWvxPgDLw0xON8+Ul0S5lZn+0RlUolu8uVdZb7eGFSkWDRZLGjWb56vg/AmbljiYHnOMUaX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HEgN7NiC; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWZpHYTIW8gowrpLlcq7MLMSb9P5lKdC/9ckqMAAC2oZJs0EGRgH/8aUEElRWLogTQJxt4w0RFVyr3VkwqesIcIz1Sz6sUzPZbfXvg9Bsnd0S3WV9EERNAAEfMn7sbp5HO7MTXBt+EFg50DBknqsxQEC/Mcb3PUi+c5IWkQwV6d0yFrKKqLBfullEuBbqtzDJ/uWnbUE7oR6fHKj5Fuq8B3PVfA0HlqxD1IK9i9bE3iJEuuEkQ1Ql9ORJEgIYlzDzR/o7Lb8H5OX4c15kIyNVrOxl2BCVpmwAPEiwfbMNPrfbpAy43i9SJbWcsHgwlYclQyj+Rk+LMo5A3uhoEwtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTtJm6FvvcKoS7EnqkDPOkfjkkxSdN4SjdzJ+XZVLQw=;
 b=LS3MDz6HR/B1W/506mY/ut3qUbreldEXH05oZ1hAU3gnWTPKBsJRoB9eazYxwuPHH6SpLzV5RvFcU7DtwOJA4QCmfnr4mt0YS1EVuISitg9k8A/Olu8LKIptchhGy+Tfpku5rAgR1BVo8OPkBjAynHjI1zq/4Mmy9nItiEjnNra/ZUgXG0KKtmHaAitaXptSgCOveDf2N1AiZnYM/xPCOEagk73qOVZtuimqTo3Cv6wytbAfWGQ79mHxEKnHKtVktUYsgxGgwqfQjN8GbBOxxTQNNIPVHivB7/nkOKr2WrPkXPKPphnEeYR8VLEPnaxhWJqRz4XO5lqe48rsKaPteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTtJm6FvvcKoS7EnqkDPOkfjkkxSdN4SjdzJ+XZVLQw=;
 b=HEgN7NiC/HqAR2GRZlqVTB6Xz3ZW2DpNA/x8Ywt4QOXRvMpuMDauB/PqZ51UKJG4unJ+NBwVIi0H8a+58PzM+uUAwhaqfm1qr4iaQCWwHTMP1ime2NJ7acIyIDaP8IV/ioZetCbUmksov02hGiL9TDTgY7P97JjRW19Vq5K498Hk9JtbvQJl4o0jJ2to0GEVDsOoQrDKRqHj1k5APLfPYTo6VjFu/FS0fzZ9hbQ2IRs1gCR3SFEMaEKY/KjHoyclO7NcNuWtXqJlnxHicYEotAit6T3AvB52SDS18eMJrPfXabZUuZeHxDkuel9GkAoiGEtE1FReD1EGAJ+vdCK/jw==
Received: from SA0PR12CA0014.namprd12.prod.outlook.com (2603:10b6:806:6f::19)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 17:38:44 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::40) by SA0PR12CA0014.outlook.office365.com
 (2603:10b6:806:6f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 17:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 17:38:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 10:38:27 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 10:38:25 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@kernel.org>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: <mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next] ip: nexthop: Support 16-bit nexthop weights
Date: Fri, 16 Aug 2024 19:38:12 +0200
Message-ID: <b5686bb1c47ef3af1d65937cb8f5e378a3abf790.1723829806.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 752a12ed-3c03-48c8-b205-08dcbe1a4671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B1Z9sKLmnbYtznWl3TAeTQAqLdM/BQ6F5ZazT8Zx2Hz9NKNV6/KvWnjDSS8s?=
 =?us-ascii?Q?B8aXPApmqgHRltndz4oSscTCUz7CDmT7SHXoc2UKg7wEGu327B6CVP7rviWo?=
 =?us-ascii?Q?IVY1ix13141c+4Q4XtrMVcbB0lbvHb6drCtMmOCMUwI/KRo2NrgiU6xTbjF2?=
 =?us-ascii?Q?KCK/uHnG9WQGR910DvztDhA6YLAAClruo1+EL0GP3ReBfq9g0agw28jMjTbC?=
 =?us-ascii?Q?zRiIvcSA9YQylgZvFGZMxNA6l9R/RxHlta0LgyGjTArhTjxIEXMhT5EJb5s+?=
 =?us-ascii?Q?qdKp2P2VsyycRHCzzRJHzJb139cjORX4Rb6pSqJ0CTyGWW/GDGUkwPjSQHpH?=
 =?us-ascii?Q?cjygwmUIwyN627NAWZqAfF/WjnkXqlBtIfCcvrVhNdqzxdgLUcGGHHRdIFHi?=
 =?us-ascii?Q?FswV2XCoTj12Z1u/U2+9xEYke8P2zMnjYf4LBjTX/MSR0uRswLWGqNbrMTFG?=
 =?us-ascii?Q?FmalX+LKpWmk/kH2i6+SJ5wgW6tDHDPmMOFqvydFfOhVD0WsYOVOD0S5bnp3?=
 =?us-ascii?Q?Jh9mBhPlw+2ZjwNQH32lK//As+c1UlI97WSkQ5SqY+ua7MUJx4FiSleaVPEZ?=
 =?us-ascii?Q?J22avkdVZ1M5RulNllpwp/iKn4JGCCMu/76dG744FbmJ+iiYmpSCYNOsJnR5?=
 =?us-ascii?Q?CycUqe3HT6vka+0SFCmowJyVbHFbWejDMcurwF28ClvjJgVQPpu+928eBCSR?=
 =?us-ascii?Q?h38OiLZ7usgA871c7DszHMiC/RmDmA0iEJHdIUjJdCqY14R+W3vDP8qifFDI?=
 =?us-ascii?Q?fMw4n6rHCvLuhi4Lw0fhLAzT8q4CWfbIb9uXdznLQ4eh0Em/ku4C4A3skLHQ?=
 =?us-ascii?Q?/rv07he00nUYi+6G9VDMD+fY3/D9MPWI7yWxuweI0DaIqXg+qitM342RbzZ/?=
 =?us-ascii?Q?jU0kRv/15mgtjI3MLbYqKRtpn3Lztaj9k2N92YxCGG0YBl384G7UIgxJ3FBv?=
 =?us-ascii?Q?pno3nlH1+DJeWm6WCACN3ay4aAEoJhL5CUlIDCAEt5SYNkjYSh3J9/eaF9Jx?=
 =?us-ascii?Q?ELGmZfba2sMV6JYbWI+sl0VgOawRKfz49swEkis87m2ila5P8oimTez9HUAg?=
 =?us-ascii?Q?zN/UC+km30OXuV6q3r2tPTCL3K/Q9B8K4wp6ORx/PSHJ7vMi4RnA5HZox95k?=
 =?us-ascii?Q?bAz6W/xZlTKEVEXFk8tYM7azpncG5WV0rKflS7qCMeNsxAbGnarpAsorwAM5?=
 =?us-ascii?Q?2SZe7v/ldsgNlCbf4O02cSqTKmLRx6Cg3kblbjPqugVaLt76bfh1P322T2rh?=
 =?us-ascii?Q?5NUQ61leZkUlRF3frgYWUpEOJMOLFntDGWjndhTzpjD6nNmA2WATF9zu2Q9V?=
 =?us-ascii?Q?4b6HKpXVylWkk2zBgLlD8AxhMq8hUXOEPX6X5/dTGaGUYx4/WgQcoHqGhVGh?=
 =?us-ascii?Q?cEiqNeSQ4Tf7GsMXxfJA7XOaucwp3uFEMoUgrvuteAqLHX4TNBtrY/re/+Uc?=
 =?us-ascii?Q?XY+mH+5hwWDa1NNAG0Ja3KMkpd2pxWnN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 17:38:43.8644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 752a12ed-3c03-48c8-b205-08dcbe1a4671
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337

Two interlinked changes related to the nexthop group management have been
recently merged in kernel commit e96f6fd30eec ("Merge branch
'net-nexthop-increase-weight-to-u16'").

- One of the reserved bytes in struct nexthop_grp was redefined to carry
  high-order bits of the nexthop weight, thus allowing 16-bit nexthop
  weights.

- NHA_OP_FLAGS started getting dumped on nexthop group dump to carry a
  flag, NHA_OP_FLAG_RESP_GRP_RESVD_0, that indicates that reserved fields
  in struct nexthop_grp are zeroed before dumping.

If NHA_OP_FLAG_RESP_GRP_RESVD_0 is given, it is safe to interpret the newly
named nexthop_grp.weight_high as high-order bits of nexthop weight.

Extend ipnexthop to support configuring nexthop weights of up to 65536, and
when dumping, to interpret nexthop_grp.weight_high if safe.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 ip/ipnexthop.c | 32 +++++++++++++++++++++++++++-----
 ip/nh_common.h |  1 +
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index 91b731b0..d5c42936 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -234,6 +234,24 @@ static bool __valid_nh_group_attr(const struct rtattr *g_attr)
 	return num && num * sizeof(struct nexthop_grp) == RTA_PAYLOAD(g_attr);
 }
 
+static __u16 nhgrp_weight(__u32 resp_op_flags,
+			  const struct nexthop_grp *nhgrp)
+{
+	__u16 weight = nhgrp->weight_high;
+
+	if (!(resp_op_flags & NHA_OP_FLAG_RESP_GRP_RESVD_0))
+		weight = 0;
+
+	return ((weight << 8) | nhgrp->weight) + 1;
+}
+
+static void nhgrp_set_weight(struct nexthop_grp *nhgrp, __u16 weight)
+{
+	weight--;
+	nhgrp->weight_high = weight >> 8;
+	nhgrp->weight = weight & 0xff;
+}
+
 static void print_nh_group(const struct nh_entry *nhe)
 {
 	int i;
@@ -247,9 +265,10 @@ static void print_nh_group(const struct nh_entry *nhe)
 			print_string(PRINT_FP, NULL, "%s", "/");
 
 		print_uint(PRINT_ANY, "id", "%u", nhe->nh_groups[i].id);
-		if (nhe->nh_groups[i].weight)
-			print_uint(PRINT_ANY, "weight", ",%u",
-				   nhe->nh_groups[i].weight + 1);
+		__u16 weight = nhgrp_weight(nhe->nh_resp_op_flags,
+					    &nhe->nh_groups[i]);
+		if (weight > 1)
+			print_uint(PRINT_ANY, "weight", ",%u", weight);
 
 		close_json_object();
 	}
@@ -507,6 +526,9 @@ static int ipnh_parse_nhmsg(FILE *fp, const struct nhmsg *nhm, int len,
 		parse_nh_group_stats_rta(tb[NHA_GROUP_STATS], nhe);
 	}
 
+	nhe->nh_resp_op_flags =
+		tb[NHA_OP_FLAGS] ? rta_getattr_u32(tb[NHA_OP_FLAGS]) : 0;
+
 	nhe->nh_blackhole = !!tb[NHA_BLACKHOLE];
 	nhe->nh_fdb = !!tb[NHA_FDB];
 
@@ -904,9 +926,9 @@ static int add_nh_group_attr(struct nlmsghdr *n, int maxlen, char *argv)
 			unsigned int w;
 
 			wsep++;
-			if (get_unsigned(&w, wsep, 0) || w == 0 || w > 256)
+			if (get_unsigned(&w, wsep, 0) || w == 0 || w > 65536)
 				invarg("\"weight\" is invalid\n", wsep);
-			grps[i].weight = w - 1;
+			nhgrp_set_weight(&grps[i], w);
 		}
 
 		if (!sep)
diff --git a/ip/nh_common.h b/ip/nh_common.h
index 33b1d847..afbd16b6 100644
--- a/ip/nh_common.h
+++ b/ip/nh_common.h
@@ -25,6 +25,7 @@ struct nh_entry {
 	__u32			nh_id;
 	__u32			nh_oif;
 	__u32			nh_flags;
+	__u32			nh_resp_op_flags;
 	__u16			nh_grp_type;
 	__u8			nh_family;
 	__u8			nh_scope;
-- 
2.45.0


