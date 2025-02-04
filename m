Return-Path: <netdev+bounces-162510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584D2A271FC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B517B3A3A60
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50420DD49;
	Tue,  4 Feb 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SspTjdSx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD425A620
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672816; cv=fail; b=ZNhbx6xiQFe9wRi07+m+wHLd4+Enl/elXWaS7bXfP+7NLKX8uPu+pwrIwDr8L0vQwJRp5EER81YeqgX7ZoerfxExTPo1K0utjwh21k8hHJryRVNf+66JuRV5xWiqOhmfD0p2QV+JX8o0159mDvS4R7oYUjGs3aYX9J0hnRASFXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672816; c=relaxed/simple;
	bh=IuTTxGjmfl/ooa6kIfUFrqzfs6cYmdRUdEMtHIkNPWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gq4ZiF0mGA7QnK1eovFmcLpTU/kEKO7U3DMFKMEfktcL7MqJ0XxtseCwneEhxnTcS/pWUN3SoQ7VXg+waz8kHBXmhrLSe7Tq/fHbEWF5IvkSh5wUzzMep8Jy5pMZPGjnDNttyJv39x2mr0uVCPML9vdGVWNZdevThJXPxyH2SgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SspTjdSx; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pmmt1NZmXsKRbBAQyYza9EBUDH7U+a2YIhBUmG4rz0oxq0dybLdyPfXq+bXUbceVAAyBkBTPwEW16Qp3Bmb85je4RUQBcDVTKkyEsEj0k+bZHfV2akcu0tFntx16/VKZ/4v/n5FzV17tch47Lzc/LCUapxEJOuqsWbVgh9hKDDqjN1HtfXBdCT5crPSftoG2ykv2DhF0mZSVO6NvHpd4eRrRr5p0jODdW0e0pWPAawfnHGuxL3f+M+ocKQvj0/tmb24/fdpndqwl1vw1CfYf2BzpXvDrbI80LAtSSQ43xo/eJk/8mnaZX8EHw9FRjkKSH3Q+MkadjdssH+We0RuTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0G6CvyJEpjOTYioHJFFjh+EtAA1uSfWOUinalJ7Ess=;
 b=ccx7rFeSYg6U5sgLCLiNxHpv2lNVMHM2lddAdR8B4qfaCk8JTRE1YgaZb5FJDVfanfjBCDL6TDgPrzdtwDfZufkyqEID7qRc/UOgrm851a22gFnaUM+kVkxpQ2mxvphvg1LuPwZ0MtDZBva2FV8cOD24KMKWGNR6uJ2Inztx+HtmMR8GNyLIgCqZT6cxL97WXnuFXNpdPIGB7BksQ3Uzh5/jGOg21AqNW8FpqTDt9xnCEMMNgAgZuW4ip8JY6r0I0bsCdJ7P/UpNKovKbvck5ir/WxdEmeyy4WFoyqL0Kl4bzvoxFaD77DbyEMH6ZFKRkjcRIfTD8F1wd4IJK4MBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0G6CvyJEpjOTYioHJFFjh+EtAA1uSfWOUinalJ7Ess=;
 b=SspTjdSx1RKl2pPAd9jZ6mfklaGvAKN09vCWWT7tJRPeNpmz4jH2QDZ8Xt9cTTkhE/JQV7bNgLzsxyVNyvgvCZRWlVJdwmn0789Xw3jtcGFk/TaTJLCfvEWPF2QaxIlxA27v0CJMOLQuEwh0jLwYz6C9r3AUQ13rffWDNdBg48+vtLITpT7pIE5sdPMtPZtuk6A/NGe2uUZt34YNmpD5BBuYNqiYs0e6kRXDkYp/aL/JuwNB9jrVoUu5EJnjXHEcykzdf4aCwVAyP+tUtj9yyRgcZxfhlr677IB10tMoHy2ZVB9OuZ/OmcADBem9qdnUIh2j2wyivlAvFBu7nsL2RA==
Received: from CH2PR14CA0030.namprd14.prod.outlook.com (2603:10b6:610:60::40)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 12:40:11 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:60:cafe::61) by CH2PR14CA0030.outlook.office365.com
 (2603:10b6:610:60::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 12:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.2 via Frontend Transport; Tue, 4 Feb 2025 12:40:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 04:39:58 -0800
Received: from shredder.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 04:39:54 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <amirva@mellanox.com>,
	<petrm@nvidia.com>, <joe@atomic.ac>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] net: sched: Fix truncation of offloaded action statistics
Date: Tue, 4 Feb 2025 14:38:39 +0200
Message-ID: <20250204123839.1151804-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|PH7PR12MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c93ac4-8832-4fef-c6ef-08dd4519108f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YgJfocfFglu9RDCw4GExiGlU/rgBv+9f5+m7XdnTu/tQExK8DeKr+an6pPCj?=
 =?us-ascii?Q?X0vrmrntLVhVKRhmnxrfLaGNViMx/vHhJGzyCe6wxnTMul1eqCSgBdCwB6XW?=
 =?us-ascii?Q?0Dgqj5yBpWR/ApAn33Iq5WgnDsUp33EGpeOEvJPxHu7ipjAczGmzpru6XdXE?=
 =?us-ascii?Q?QQyMr4MLjnOTX/Xco3MSC2fs2QGZIanIzoqD7NCYh4Ids1cDD6z3qs1amG3s?=
 =?us-ascii?Q?9VywnEQ7tzvSMSaWkkUwVwA28l3RBRYXcX5vYy0FJCvGFFMNCJULGG90jPZT?=
 =?us-ascii?Q?/hzR5vNm/u0tz6DWdcXAZxBWon6gSGrQfML6aZ0pwzFUsXx93CfGp6hNkUxk?=
 =?us-ascii?Q?zrJhPXCbq+9ju1hBXz6d7HtgwB59fvUxjpCt/vikKimrHPRz7JjxA8imY3HI?=
 =?us-ascii?Q?3iMN/WH/I4yQztrmSjcSVGgDKo/CyyK0irgL7Za2karafXDSyeL8Ph4vNUnr?=
 =?us-ascii?Q?XL08KOxvx+lLx5K4zI5vaHdbTgAumrjMxoGMUh5L1m0BHxAvV0/+W5yaZagU?=
 =?us-ascii?Q?yF+COXdtQfU1woqyHtPU+/XZNefpEGi4LZE4lQqpGjUclvvdMKwDbmFNWNaV?=
 =?us-ascii?Q?MyD0kaotYkglfIfptp3X1LPRTcEx+o6ctL3fB+IsZajto5VRM2FlCbJyok9k?=
 =?us-ascii?Q?SXDddvI9N27Xu3lTehwLljFVpBMnyFTFLU7nHABHxhbX4cjEG5Pa1lAdIRY0?=
 =?us-ascii?Q?+8nOTCe8rtxjzzXYUfmgjOVpq7XRCZz6ghV/2AchQOkKwSpU2+yaZrmE4/gD?=
 =?us-ascii?Q?cZNBvIOZ5QuVi1dV1HDV1RqLHMkuHdwABxPxkV600Z7WElz2RFGZPXJZ04MG?=
 =?us-ascii?Q?RWvywAfzXTaViRkAMYshSUvyTPxXnOmvhNrEtqJp200k5u6S3mjBbdCvT2Ai?=
 =?us-ascii?Q?lsi6it/xDX5AeR71HXOEJs/c7L6qVDaDZIFIYmZbnIk+dj3FL8ame3eHFsVt?=
 =?us-ascii?Q?aXS87/sjfpQ3LF7xyoE3xfYX0mYCF5gfkKg7Wt5uUMOndzlTyYDAxu8jmtER?=
 =?us-ascii?Q?D5yUyCjOACDhJfBXE5cgc+fIddHL/Psr2HNRxIPiFTEIqjnkrJtTeniLWLuJ?=
 =?us-ascii?Q?ZH4RtWlaP9a5CDM8CYygzWUmFm9Z2USupWnpyfaVZhUwuICQgzQbZ1x7U458?=
 =?us-ascii?Q?/fs52TO2dhuhJ1Mr7FyzZOUkvHTKETxNoAwuqvIgOiNHCm7BtEgVlRzPQ2iL?=
 =?us-ascii?Q?ki8/vECCpL5K+Ftu44sX6QUv7qea2GSjHOV3IBi2Lab6WkpPvdZfmQjXK7f1?=
 =?us-ascii?Q?rAZiJNHh9Pol7TcucMwBR78HSl5h2bRR7L1/b5oyPwdWWn8DfxPizWivsPpX?=
 =?us-ascii?Q?HSCgnFUerwMwZ1kA/HMtrRAGt9tpDE4WQsiB/oyDVQnCZKkbkngfw+ueU870?=
 =?us-ascii?Q?MuTBfN/iwDWPuwyhFJqyl/HnQUIZFQxV9+wIGGa2hNMDiZEinWus09P4lku9?=
 =?us-ascii?Q?XWWy1icf6X+O/YWtRkWfrcHs/MlPCI7sb90ADr9pbhktBEFj6d77gAaflKK9?=
 =?us-ascii?Q?FhtJypi0ILFJnyI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:40:10.9429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c93ac4-8832-4fef-c6ef-08dd4519108f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879

In case of tc offload, when user space queries the kernel for tc action
statistics, tc will query the offloaded statistics from device drivers.
Among other statistics, drivers are expected to pass the number of
packets that hit the action since the last query as a 64-bit number.

Unfortunately, tc treats the number of packets as a 32-bit number,
leading to truncation and incorrect statistics when the number of
packets since the last query exceeds 0xffffffff:

$ tc -s filter show dev swp2 ingress
filter protocol all pref 1 flower chain 0
filter protocol all pref 1 flower chain 0 handle 0x1
  skip_sw
  in_hw in_hw_count 1
        action order 1: mirred (Egress Redirect to device swp1) stolen
        index 1 ref 1 bind 1 installed 58 sec used 0 sec
        Action statistics:
        Sent 1133877034176 bytes 536959475 pkt (dropped 0, overlimits 0 requeues 0)
[...]

According to the above, 2111-byte packets were redirected which is
impossible as only 64-byte packets were transmitted and the MTU was
1500.

Fix by treating packets as a 64-bit number:

$ tc -s filter show dev swp2 ingress
filter protocol all pref 1 flower chain 0
filter protocol all pref 1 flower chain 0 handle 0x1
  skip_sw
  in_hw in_hw_count 1
        action order 1: mirred (Egress Redirect to device swp1) stolen
        index 1 ref 1 bind 1 installed 61 sec used 0 sec
        Action statistics:
        Sent 1370624380864 bytes 21416005951 pkt (dropped 0, overlimits 0 requeues 0)
[...]

Which shows that only 64-byte packets were redirected (1370624380864 /
21416005951 = 64).

Fixes: 380407023526 ("net/sched: Enable netdev drivers to update statistics of offloaded actions")
Reported-by: Joe Botha <joe@atomic.ac>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 include/net/sch_generic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d635c5b47eba..d48c657191cd 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -851,7 +851,7 @@ static inline int qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 }
 
 static inline void _bstats_update(struct gnet_stats_basic_sync *bstats,
-				  __u64 bytes, __u32 packets)
+				  __u64 bytes, __u64 packets)
 {
 	u64_stats_update_begin(&bstats->syncp);
 	u64_stats_add(&bstats->bytes, bytes);
-- 
2.48.1


