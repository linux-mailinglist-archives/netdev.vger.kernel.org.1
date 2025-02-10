Return-Path: <netdev+bounces-164615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BDEA2E7D9
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D333B7A2537
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7521C6889;
	Mon, 10 Feb 2025 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V9s43DRH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7C91C5D5B
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180039; cv=fail; b=eXXxkJWNZpi9qa5dXNpzVLDjJm58zThYcFzgr9gkzAKVm6Ij3GVdjduMIIsyMg91qtNtCDYp/hFuwJLpJWbXvO45i6/QupE84CZ1zGrjeBJHnM2yNAGRWdKVDhynYQ0ezZ7L1+P6lpz2HqtC3BLsbytDlJTw6oitjyTlJflyt60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180039; c=relaxed/simple;
	bh=FP9P655vlNUd0UjHx2UXrV1HEw67CgU9B1K3tDEYFg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGOIqOwqXrpXQQC+xMSlqL94ltsL+8nKybWXDiig4/zarwjdXXZ124V6Qpp4Mf1eQWb80Q8bdBva9FfaeOv2l+cp5Lo/ri2wy3+Wpw3H1e1GJFG8E5yy6nRe7nWikSYA/7EK0N/1i2rqGm/1Vn9AmzbCJSOzWNHhTwRJslmGy/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V9s43DRH; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSqZe2ypfN27D1Ufhm6lXhP605fryelGhWZotOqTWBw2qGDWhgb6dalrQtT2DKkl3izA5k8rSIeFYiIjW/HkU74n6YHNkKc5/WOgH67tylhwwqtB7IB89VllqA4HB9236QF6jtyQlbTFg/Xp1/YCxNAchId2X0y/BWAE9xOiMJ529Pznwn83hIgc/liy3RvgNdYwzvQN7E3wbtyD+N+WLOYrCa3IwyrMLk+rm1X757Vi5C5TFFZmhm+dSqQFV1U/QXzCUrN6G4qepskJctLO1ih74J4/cZjjbHxMDSfqiESPw/jBW5d2g1Lv8m8asEseVqZboKuh8SyUDjQq7AEAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+TAlxv7uzsM6lTShL3DeuwMQGbqRwhuMg1bMBjEDNI=;
 b=RWOm9K4abTJT6D/lRlIGGF0NKAV0oiKZAV8Ea2F0amBKcysU8R55eDLM6wJYGCKsZR6dASZFJ+wsgY76PvRPu17HIuA7alg1VVMNNGEElwBhQ+2PUm4q5Ew5D56KZn/QrcLuSgPmdyCYg7TKk8MrQvBnQe+aGLi1ypwHGjflKM8jNaLyMxAD7UewO/w/QrDh3KDwtaXXDDpOirxC0FBwDBMvC/eL9+neDpD/Bjzdyf112qCaAu3uUnAee18+9ytCajFcszL1S9obXpd3CD5sBjOirZmYB6Ncqbd2BED9j1kGOyzZgt7TgxaFE7p94zC4kSSQhFUBSsy1Q4NdaBlzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+TAlxv7uzsM6lTShL3DeuwMQGbqRwhuMg1bMBjEDNI=;
 b=V9s43DRHuSk14tWIO2Rpr2paPGnKFx/R/8c5tl4DKx1pTqjMTpeK4wN4CPTqvJzPBsmcpjfcAGZFlcsYiwHO1x5dkcyXe6Ljk8QOM+702bpeEMRhK4xh6RF1Fw2WqoQRheykyVLA8pcVtgkWZEBvrVpUtFn6OkK6PLAFBy0ExC2Jfk3nidwPIKAkWaZPA1/TpFifjHHtj7B++YYCqLTUERdh2U2sxxBUbUvwv7gFQd7NaDmokJUb85jQvx9FqBM4ubjpFccP6IBI4y6+53YrfI0aXc+0S9kFG5Jvd8fMn3D6xCNh2QwKzJ2V8bx0nOyy24zyA5LOYgVFNYUdnC4DBA==
Received: from CH5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:1f4::20)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 09:33:55 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::bd) by CH5PR04CA0002.outlook.office365.com
 (2603:10b6:610:1f4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 09:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:33:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:33:41 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:33:38 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 04/16] cmis: Change loop order in cmis_show_dom_chan_lvl_flags()
Date: Mon, 10 Feb 2025 11:33:04 +0200
Message-ID: <20250210093316.1580715-5-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210093316.1580715-1-danieller@nvidia.com>
References: <20250210093316.1580715-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 85153d8c-d749-43c3-8b02-08dd49b6096f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oshcn3udfQyfcEkmmWXIYuxMgrVbHN1g93CFZTXWnORRItNQjMoBlqHDWsAT?=
 =?us-ascii?Q?6sAUszYlSlYGYNQF1cLzCKXmCY5yK9RcbpH8QbJ3ANmPb9kPQiTukEZdzPlf?=
 =?us-ascii?Q?K0cv9kkEAL2tzRgT1LO3Ws2NR2YeVS3+ATyMpGCO03iUbrX+ciAm8X25UfrI?=
 =?us-ascii?Q?FOUEG4tpmEzr2XhYjJ2BJ+4fSgImcIQahAGYuW6AxJ6pQrr5UuasGkQgjRLm?=
 =?us-ascii?Q?JVowzftXrLRJzKzGRYN03BPJvfbH3eTCUaAq/BSUMCvBuMCy77kaWg4UEauK?=
 =?us-ascii?Q?J11wUalE/x7rGK+cZ/xPpWfEjXycAFSQinq2eiTug50tqx+CrdF9cvzBZ/65?=
 =?us-ascii?Q?jUnBQC58Z4UwG073mlVURBuUbu6SAL2NOY9rcIhYNxT6PzxeEB61ZS+brDz5?=
 =?us-ascii?Q?IZvchzpzMPx5u1xqrJcabqL3uz7PEWuoH3oKmj3+5um1G/2LPYeQ+vROtkYb?=
 =?us-ascii?Q?W5Jv/3n+heJR5BLUoidL+XksbppxrfnhR5B930oHSXsf2PQIdJsTHYyNWR/5?=
 =?us-ascii?Q?TDOp6swtKlsC/3h6s13ycHTU5FnPXhsb6ZvPW/aZe3lVDZZXT0rSqyzqmxB2?=
 =?us-ascii?Q?BOCnrtFbeaJJWc+qJSaMSAQRxsvqCRQVY8wZlzJRO6//WRTd5FTbbZ0ta7WV?=
 =?us-ascii?Q?fkP5wkZCuMQ23CTDr3joaY6iLpVKuE6ilJYMS++3mInAnqXX1wvZdMvrPAhr?=
 =?us-ascii?Q?2He0RbxbB1eHf+XRvIHZmzgoLp6a+OYRZaF2OuNKF76L1W5fncA/jU493VlS?=
 =?us-ascii?Q?2TxOqeLJyqxMMOlW5ZtjMCSs+TOBh+14+fhdhKn5Ldxm57qKALIKN09Tmt08?=
 =?us-ascii?Q?kIU2L6UEjXwK3qwN4kxts25xZ0MKG1Ai8Uy1Li5K03/7/q+Jvr64ja6DvTk9?=
 =?us-ascii?Q?eO+Xx1sEmEgELPztfumoQwiWXtEoe9nXU5ylZb75QkAJBAATU5WczDFC6LYu?=
 =?us-ascii?Q?0jFnBL90SzF9FOldKZ6VFC28rbwb1xW+241IfsW9/8zuAXulP3Hn00DSBqO2?=
 =?us-ascii?Q?BhveqkcCJ5GsaPrIk/xFAqFOx/gHmrPpsFCGuIlsIeg4oBYFHrsEZg/Isazk?=
 =?us-ascii?Q?bIiXXl4rG58ZZcb0UGPV3WGgCwpx1rUebMFEdOygpElTeHr1l4magTa1wqAh?=
 =?us-ascii?Q?VCGAypYuemwPYeg2qd7osyjl3FFRolHSh+EuDGHFDOnMDcejo47EimbsJzNn?=
 =?us-ascii?Q?BH8iKhU9YRByXIsSvhuu61FGtfYdPXsigWIiqlR9sRcvTPUUwKjRun3zCwK9?=
 =?us-ascii?Q?bK5/n3m0PeU2sWI+cMacwpNod/MvtrlZjhJKgfvsWqzJsp02FRKkbsQAjrIt?=
 =?us-ascii?Q?R5T4SxLqV3e13s6cpO8eIsMV/4VrV+3HT5fevoHI+PO81mIh+x02s6h/jBB9?=
 =?us-ascii?Q?/qWGMlV6hcbr/wJHVx4JVE8WDEzx9PKuDB8Rzssuhd3jKZQdLGWJShiKoFf3?=
 =?us-ascii?Q?78q8LhLGVMomXyGUpEAVe7TFaxdhEna+ys1Z/X7KV0IQ9AiCaRLlj/32rh/v?=
 =?us-ascii?Q?hZL2kC4F/49ezck=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:33:54.5940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85153d8c-d749-43c3-8b02-08dd49b6096f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853

Currently, when printing channel-level flags in ethtool dump, we are
going over the banks, and for each bank, we are printing all the flags.

When JSON support will be added, in per-channel fields we would like to
have an array that each of its elements represents a channel.

Therefore, change the loop order so first we loop over the flags, and
for each one, we print all its channels.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 cmis.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/cmis.c b/cmis.c
index 5efafca..9cd2bb1 100644
--- a/cmis.c
+++ b/cmis.c
@@ -683,22 +683,19 @@ static void cmis_show_dom_mod_lvl_flags(const struct cmis_memory_map *map)
  * [1] CMIS Rev. 5, page 162, section 8.9.3, Table 8-77
  * [1] CMIS Rev. 5, page 164, section 8.9.3, Table 8-78
  */
-static void cmis_show_dom_chan_lvl_flags_chan(const struct cmis_memory_map *map,
-					      int bank, int chan)
+static void cmis_show_dom_chan_lvl_flag(const struct cmis_memory_map *map,
+					int bank, int flag)
 {
 	const __u8 *page_11h = map->upper_memory[bank][0x11];
 	int i;
 
-	for (i = 0; module_aw_chan_flags[i].fmt_str; i++) {
+	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
+		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
 		char str[80];
 
-		if (!(map->page_01h[module_aw_chan_flags[i].adver_offset] &
-		      module_aw_chan_flags[i].adver_value))
-			continue;
-
-		snprintf(str, 80, module_aw_chan_flags[i].fmt_str, chan + 1);
+		snprintf(str, 80, module_aw_chan_flags[flag].fmt_str, chan + 1);
 		printf("\t%-41s : %s\n", str,
-		       page_11h[module_aw_chan_flags[i].offset] & chan ?
+		       page_11h[module_aw_chan_flags[flag].offset] & chan ?
 		       "On" : "Off");
 	}
 }
@@ -708,15 +705,17 @@ cmis_show_dom_chan_lvl_flags_bank(const struct cmis_memory_map *map,
 				  int bank)
 {
 	const __u8 *page_11h = map->upper_memory[bank][0x11];
-	int i;
+	int flag;
 
 	if (!page_11h)
 		return;
 
-	for (i = 0; i < CMIS_CHANNELS_PER_BANK; i++) {
-		int chan = bank * CMIS_CHANNELS_PER_BANK + i;
+	for (flag = 0; module_aw_chan_flags[flag].fmt_str; flag++) {
+		if (!(map->page_01h[module_aw_chan_flags[flag].adver_offset] &
+		      module_aw_chan_flags[flag].adver_value))
+			continue;
 
-		cmis_show_dom_chan_lvl_flags_chan(map, bank, chan);
+		cmis_show_dom_chan_lvl_flag(map, bank, flag);
 	}
 }
 
-- 
2.47.0


