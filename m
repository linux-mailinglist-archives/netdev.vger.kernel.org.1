Return-Path: <netdev+bounces-162508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD8BA271E6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF039188403E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9792101B3;
	Tue,  4 Feb 2025 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rHxNUiv5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402E20D4F7
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672380; cv=fail; b=MzkgWF/qlJ2UP6rnA8GSdswIyboIKyQLY1BAMv1c+tM1J/YREOWbO1EBVa4uxPs/WUs8moJf7kDaE9UZSY9fWrpXiIkqLsd/MSbuvYPW3Ik4wyQJbMnPrLVpVb1aOL0y/NQd0WexP2M9cclYJGxMnntc2LJeIpMaSaXNWaQ1LdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672380; c=relaxed/simple;
	bh=SP4tT+dA3PM5xku0H2QmMBn8h3UaW6wEIcBFCICH5bE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MCVBAiXWqgCmYhVg/Y5C4FOySJUBM8oD2CbFk2FMCnPTaJ2Sa5b9RTSNT+lnPkB/wvMLpseZpngfsPzLdOvc6OFOH15L4hqgN8NlPqxKyNwBKRuW4B0lHl2XvVVP9xRzHIcOiBj2g3U4Xb4krR4PrU4I6pWSqCN/AJEz7m4fKu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rHxNUiv5; arc=fail smtp.client-ip=40.107.212.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw6Ixr81cmvvCpBlk+EpjABS2UmIQNyHE8rbhEDp/75qdZyPBDRAZznuyEtpR6bjZ+sdrbfaI3BYEaxC5x0YKZiRFjEoSdKjNMoW59XmoDUg7ygwjlvi9dcftniX1D/Clv6bQJOI3IV7ej9sUr9zm0WxWL6Sqtzvy2hVWgZNF/biYoJB83aynVOHKo4WYR5wY4Stcy2wqfrZrut0x9pTDv4si1EBijEgA4SQJjktn9oLfqsBkhFu/C9m1Sicmnr4Qi/c4C1S1cCzoDCC6d3SY/A69rvaRNkGNeS4ZtiulvwmETMAaUPT6E8fHAagrRj6vRPwOl5GKPJPXImGH/cRRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnrKnaqc1kSkbMG28qxbNDl9QHnwV4ELMeEVH/wltqM=;
 b=iVGKN163zIgjzcFtF3oXtt5IjKDYgyqQBxLzxLugEI7byZayJy9nhNbso8Qv6ZktuOQbhr0nDFTyqZYq2vIn8AMB3ofEM6LiJflxF/maWuDdZj1xnF24KI5oyc2iSMVbrVzr2Ej/VoGtELM64QiClk/hJOaURDD3kOgumdCScCSqpW/MzadJbiNYwmBWKOQ9tYPVe0F+nMxoSvPaQUmOClu2C23LRAj+iUtO342xdD1dJhNG3yJXiZg27eYdjgaH8eN54vd0W3C51wrf23QJCttFPu7SzS8jPO1/W8bGMMZJXAu97g0Nf//vwT99B8CX2dz7cptDKRMCwE05RCKiiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnrKnaqc1kSkbMG28qxbNDl9QHnwV4ELMeEVH/wltqM=;
 b=rHxNUiv5+P4b8zq9J3V+iVBZa4iv3A5s9t5bDXQQSFZrtkxYUmD8Y/HGkwstcYr7EId/M6zSo/40uaGgPce35q6pb0AESVMYT3ObnUzcZfyYk5qSd2YFzyXKiAbLjDVht6npm7egrecwCZ947cF/m9aNR31VIidfDN3GIdOocUDI92viUqDGEM14X3iV3KgySkK3jFxCiUhx07O4aOrXOMKyiHn+wMvfBSWCkasXsv0s8Cl+1dnIkS0ffpKCQF64SZnGsmBB3mA6qQpdT5Ys+Wh96TiogIKacgimuNryz9B3fQ/L8dj/m878UC/KuWGtveGAyEUDJmKqhdOM6lzN8g==
Received: from BY5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:a03:1d0::13)
 by SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Tue, 4 Feb
 2025 12:32:37 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3d) by BY5PR04CA0003.outlook.office365.com
 (2603:10b6:a03:1d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 12:32:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 12:32:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 04:32:25 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 04:32:23 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	<joe@atomic.ac>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next] tc_util: Add support for 64-bit hardware packets counter
Date: Tue, 4 Feb 2025 14:31:43 +0200
Message-ID: <20250204123143.1146078-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SN7PR12MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: d75b7049-a60a-4d27-b8e4-08dd45180208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C7uzkWdUqHCQ2ULKyjVoATj6yhB36HKfjBDzhvVFzQRHSmbsy4SF5k8fMNei?=
 =?us-ascii?Q?TuFHFBkptAF5AKutlxex9bRp2l33uefoim8LRe/7HVjimE/6n9TA/RyHSp0j?=
 =?us-ascii?Q?e48eUVbGqfz+GwsNyUkD3bwtbeiGp5vQ45RR4HEXwCvJimQ8A8IhxYRmfDzi?=
 =?us-ascii?Q?eHG+TVgQIepYnmrBvENeT+S2UjQussPFUyMgQPW/N0eiDJxMD6hXjZCxHbwR?=
 =?us-ascii?Q?eLjwda+wCC2steG+g1VudK7Wxokly2jNlmO48Lq1XeCvqGEo88OCrK//2beP?=
 =?us-ascii?Q?k9tlW5d8GjivGP65yNlHUSq9/OQH7xfJAkNbHQ6J0C7CCJiC5Sn1vjkBzehe?=
 =?us-ascii?Q?L3T7ztBxdDi49yw/vMVHx66J5XJmmNj4FUI3RQP//3lpApVFc5ZaYURVbJNt?=
 =?us-ascii?Q?wxfeht+IQI6E24+CjZoFdPl8tX7j43wl+SfVIrtjK34MG4hJUZD4T+Rgsjyq?=
 =?us-ascii?Q?vRBjxDwJrofM2tbspDZdSm/HoKYoVrOmNDkvHitJ0rptCLbJj67t+FjXeNNQ?=
 =?us-ascii?Q?GUz4GrJE8p3qO8mWQz8EpV3fnahNBmiiwaCCjJ43kNcUBGMI+3NoZPij05+h?=
 =?us-ascii?Q?cFNQXo7UKmZ/VyZM8JA+3q3n1T+Tt1vRPEZfzR2x0Ikr9rLZV8bjes+9rWXs?=
 =?us-ascii?Q?8M+eox6l3w/mSao8t7fD5i3pRI27ozFz1M1cZep0f+9APRIPZmA4G1sitDvd?=
 =?us-ascii?Q?V85mHqz1+F5V6uVoQ+GqQ4LfDf8Bg74/zZhgXUH4DycogWma+y8nxAfVSZFk?=
 =?us-ascii?Q?6yuU0tgKyhB83rev3X4lTCgODecwv3R+TmaghiEXvAtKw63NtY3m86V34H5I?=
 =?us-ascii?Q?/ZHmW3Ru/57Dv9KsBZqru2hrnomBAlZ1xcpYHPRGNSS+n78QanJPJ0LzsZ7j?=
 =?us-ascii?Q?EnPmU1DZwin7BOnB03lJOZGLm7sQWxfi0KX1FwrQ0WhULqM+FplMRfmf6Hyo?=
 =?us-ascii?Q?18MTjzkiPsnTYLiOG5o7n8ydVigEuMSZtxgFhXtDnXkysJEkkp+eedDs15KC?=
 =?us-ascii?Q?VAqydd2BHeiwLockODCeTv3Mos7ANx+edrIyTxPmGLcR6DGReOzo8k9qCRAP?=
 =?us-ascii?Q?swRMZD8dIvDl5zxdTbo0yJLfSv5mpInurs4gxtp8ZDuT8bkpKhjGXfJPurnS?=
 =?us-ascii?Q?KZnOraL/ZDSBe0AaV8me0tson7f2y95l55cWlx+BQ/BMQsIesBvN5jqJxC1T?=
 =?us-ascii?Q?r8vyb9a4o3f1ObPfPW+uug31XxdkqKiODdwPsBWf1h6vqoO+LIeUTs/b6ViF?=
 =?us-ascii?Q?IYFYSDcdZChnSVIY/4qrm4QGRai0+EwKEfEFW7hWsfoB/oFNdYM29aNkAvCq?=
 =?us-ascii?Q?V/+2BZKTlHKvPkS0cQpMlVIhJHbDQA1cGCrEZjwrVmvevz6IFpLBJwLSwrpz?=
 =?us-ascii?Q?Dlr+ZFnr/PIxq8k90liOUXhVpVj3RULszbPjs2OmORon/N/4ZNGOBMrBQX9m?=
 =?us-ascii?Q?NpAuzq+nkdJ+U0aczuAOHcGrOBz7+qgfvaTz7KDqEfgJ5uwrLSXGeZOOla7F?=
 =?us-ascii?Q?vrQEMp3urZzm0IU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:32:37.1198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d75b7049-a60a-4d27-b8e4-08dd45180208
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786

The netlink nest that carriers tc action statistics looks as follows:

[TCA_ACT_STATS]
	[TCA_STATS_BASIC]
	[TCA_STATS_BASIC_HW]

Where 'TCA_STATS_BASIC' carries the combined software and hardware
packets (32-bits) and bytes (64-bit) counters and 'TCA_STATS_BASIC_HW'
carries the hardware statistics.

When the number of packets exceeds 0xffffffff, the kernel emits the
'TCA_STATS_PKT64' attribute:

[TCA_ACT_STATS]
	[TCA_STATS_BASIC]
	[TCA_STATS_PKT64]
	[TCA_STATS_BASIC_HW]
	[TCA_STATS_PKT64]

This layout is not ideal as the only way for user space to know what
each 'TCA_STATS_PKT64' attribute carries is to check which attribute
precedes it, which is exactly what some applications are doing [1].

Do the same in iproute2 so that users with existing kernels could read
the 64-bit hardware packets counter of tc actions instead of reading the
truncated 32-bit counter.

Before:

$ tc -s filter show dev swp2 ingress
filter protocol all pref 1 flower chain 0
filter protocol all pref 1 flower chain 0 handle 0x1
  skip_sw
  in_hw in_hw_count 1
        action order 1: mirred (Egress Redirect to device swp1) stolen
        index 1 ref 1 bind 1 installed 47 sec used 23 sec
        Action statistics:
        Sent 368689092544 bytes 5760767071 pkt (dropped 0, overlimits 0 requeues 0)
        Sent software 0 bytes 0 pkt
        Sent hardware 368689092544 bytes 1465799775 pkt
        backlog 0b 0p requeues 0
        used_hw_stats immediate

Where 5760767071 - 1465799775 = 0x100000000

After:

$ tc -s filter show dev swp2 ingress
filter protocol all pref 1 flower chain 0
filter protocol all pref 1 flower chain 0 handle 0x1
  skip_sw
  in_hw in_hw_count 1
        action order 1: mirred (Egress Redirect to device swp1) stolen
        index 1 ref 1 bind 1 installed 71 sec used 47 sec
        Action statistics:
        Sent 368689092544 bytes 5760767071 pkt (dropped 0, overlimits 0 requeues 0)
        Sent software 0 bytes 0 pkt
        Sent hardware 368689092544 bytes 5760767071 pkt
        backlog 0b 0p requeues 0
        used_hw_stats immediate

[1] https://github.com/openvswitch/ovs/commit/006e1c6dbfbadf474c17c8fa1ea358918d371588

Reported-by: Joe Botha <joe@atomic.ac>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tc/tc_util.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/tc/tc_util.c b/tc/tc_util.c
index cf89fb7cbabc..ff0ac170730b 100644
--- a/tc/tc_util.c
+++ b/tc/tc_util.c
@@ -665,7 +665,8 @@ void print_tm(const struct tcf_t *tm)
 			   tm->expires / hz);
 }
 
-static void print_tcstats_basic_hw(struct rtattr **tbs, const char *prefix)
+static void print_tcstats_basic_hw(struct rtattr **tbs, const char *prefix,
+				   __u64 packets64, __u64 packets64_hw)
 {
 	struct gnet_stats_basic bs_hw;
 
@@ -674,8 +675,9 @@ static void print_tcstats_basic_hw(struct rtattr **tbs, const char *prefix)
 
 	memcpy(&bs_hw, RTA_DATA(tbs[TCA_STATS_BASIC_HW]),
 	       MIN(RTA_PAYLOAD(tbs[TCA_STATS_BASIC_HW]), sizeof(bs_hw)));
+	packets64_hw = packets64_hw ? : bs_hw.packets;
 
-	if (bs_hw.bytes == 0 && bs_hw.packets == 0)
+	if (bs_hw.bytes == 0 && packets64_hw == 0)
 		return;
 
 	if (tbs[TCA_STATS_BASIC]) {
@@ -684,15 +686,16 @@ static void print_tcstats_basic_hw(struct rtattr **tbs, const char *prefix)
 		memcpy(&bs, RTA_DATA(tbs[TCA_STATS_BASIC]),
 		       MIN(RTA_PAYLOAD(tbs[TCA_STATS_BASIC]),
 			   sizeof(bs)));
+		packets64 = packets64 ? : bs.packets;
 
-		if (bs.bytes >= bs_hw.bytes && bs.packets >= bs_hw.packets) {
+		if (bs.bytes >= bs_hw.bytes && packets64 >= packets64_hw) {
 			print_nl();
 			print_string(PRINT_FP, NULL, "%s", prefix);
 			print_lluint(PRINT_ANY, "sw_bytes",
 				     "Sent software %llu bytes",
 				     bs.bytes - bs_hw.bytes);
-			print_uint(PRINT_ANY, "sw_packets", " %u pkt",
-				   bs.packets - bs_hw.packets);
+			print_lluint(PRINT_ANY, "sw_packets", " %llu pkt",
+				     packets64 - packets64_hw);
 		}
 	}
 
@@ -700,21 +703,40 @@ static void print_tcstats_basic_hw(struct rtattr **tbs, const char *prefix)
 	print_string(PRINT_FP, NULL, "%s", prefix);
 	print_lluint(PRINT_ANY, "hw_bytes", "Sent hardware %llu bytes",
 		     bs_hw.bytes);
-	print_uint(PRINT_ANY, "hw_packets", " %u pkt", bs_hw.packets);
+	print_lluint(PRINT_ANY, "hw_packets", " %llu pkt", packets64_hw);
+}
+
+static void parse_packets64(const struct rtattr *nest, __u64 *p_packets64,
+			    __u64 *p_packets64_hw)
+{
+	unsigned short prev_type = __TCA_STATS_MAX;
+	const struct rtattr *pos;
+
+	/* 'TCA_STATS_PKT64' can appear twice in the 'TCA_ACT_STATS' nest.
+	 * Whether the attribute carries the combined or hardware only
+	 * statistics depends on the attribute that precedes it in the nest.
+	 */
+	rtattr_for_each_nested(pos, nest) {
+		if (pos->rta_type == TCA_STATS_PKT64 &&
+		    prev_type == TCA_STATS_BASIC)
+			*p_packets64 = rta_getattr_u64(pos);
+		else if (pos->rta_type == TCA_STATS_PKT64 &&
+			 prev_type == TCA_STATS_BASIC_HW)
+			*p_packets64_hw = rta_getattr_u64(pos);
+		prev_type = pos->rta_type;
+	}
 }
 
 void print_tcstats2_attr(struct rtattr *rta, const char *prefix, struct rtattr **xstats)
 {
 	struct rtattr *tbs[TCA_STATS_MAX + 1];
+	__u64 packets64 = 0, packets64_hw = 0;
 
 	parse_rtattr_nested(tbs, TCA_STATS_MAX, rta);
+	parse_packets64(rta, &packets64, &packets64_hw);
 
 	if (tbs[TCA_STATS_BASIC]) {
 		struct gnet_stats_basic bs = {0};
-		__u64 packets64 = 0;
-
-		if (tbs[TCA_STATS_PKT64])
-			packets64 = rta_getattr_u64(tbs[TCA_STATS_PKT64]);
 
 		memcpy(&bs, RTA_DATA(tbs[TCA_STATS_BASIC]),
 		       MIN(RTA_PAYLOAD(tbs[TCA_STATS_BASIC]), sizeof(bs)));
@@ -740,7 +762,7 @@ void print_tcstats2_attr(struct rtattr *rta, const char *prefix, struct rtattr *
 	}
 
 	if (tbs[TCA_STATS_BASIC_HW])
-		print_tcstats_basic_hw(tbs, prefix);
+		print_tcstats_basic_hw(tbs, prefix, packets64, packets64_hw);
 
 	if (tbs[TCA_STATS_RATE_EST64]) {
 		struct gnet_stats_rate_est64 re = {0};
-- 
2.48.1


