Return-Path: <netdev+bounces-202944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C467AEFCDB
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 079807AADA2
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D3277CB3;
	Tue,  1 Jul 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gqccEScu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA712777FD
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380985; cv=fail; b=Ch1nK12XuoollqizuyLfiVT+h+LsIDvKJN9IqW8hU2CPJ0zzQ285WMPEi1kupAQom3FDifLJYs9JG2LU9T0wh0kvJcLNBtXn7m9Cmj0AtyayyAAeO03XMffjq3kF1yWhVKKvBory6Z25p8KGaPCTd+R0oXyImnYeYyXyE3lN80A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380985; c=relaxed/simple;
	bh=SKXOP0y/KsgBOBo2nJZFJz9yOIufXYg+3GU/8g/DaUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fv38hTCrC9AaMd9iygSSAUf+7DlpK3vSXqcXfzQ8lN71NRV6nnHriW8eIDREKEf5ChGSk/a9F24ZZcNhF7XlMhQlgKn/WV4ifYAblU8EwLdNNY/lVq2JpRBYgUHtYJMXwCUlzhEYKXtspGwoKmDdcDfkDptFWYxWcXKVn3CT8jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gqccEScu; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnGd/j9WB5BWxYvZP1/YDtOGxsrvwqxc+yhUt9NTfjfygDqSDsleThNpT8eTPnIOQ79QUTAQpXMOZGdBF+Sh+Pl5xubvyM2I0Q5zHcCYjd7t+3bwg0Yn4/5C6Z/qRYde5xsdQNoy6X1qoB2DmC4PmRHzHnFv3kYjg3mgBtFjrgVqyLQH4jLozD64s4wLKl/8Ga8dqralAyiHgV2CQjdpoulTMDy/STOmzYhuZCdzrfD+dJoOkPLBcV5zMfjKjgGTfwA8fmDkyCZzgfX9qJWu8XGgCLX/030hXVW0u3qY8m7EJCX3OujlR1ng0bMWYG5USPAf5GmmHQLAnefjLSsQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yntXXu5YEVW28v1uFFVRhknpJEmULW9kTmoovwK3A4w=;
 b=igION6SFqVqXUjQDNlqbspLVqveSvAzQMbIGy9H/C83YhsNgZD0RCmMR4C6030xDELQQlHpajCcn3VvfxOMQ0glxx5UR5+Mx5b+QGEBMIRwy8zTLdY/3qZt9uLN6zs5rOJZ98WV8jtXxOiv0pAxKCFg+VF3unWRFciO/XffaWsYu54GUSoJ6akQQtnMf8+w8Qe6ru+awWMOP5agSbB0pWoHLPKJzOsNf/rKZq1EXWmiux6FBT4oWf+Sl9cl6JgdX4yyBsvL3I4iPI5DEDuW0aIxANLkaRYOL6iW2tj8j4KAhHg83imIUBG+fCJ0cnQ24Xr+zANClkPFrqIje2ICWWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yntXXu5YEVW28v1uFFVRhknpJEmULW9kTmoovwK3A4w=;
 b=gqccEScu/wX95FztJO15tmVDF82tOeNaPV7hykAejRvhB2O0xXZV0qL0rnmjRCP2MkDksaL798iYvR0iq/zfeMGgkAWkBlG1N5GMm/HDp2wbmMc56n9NWYJRK93P86lkKKMzTdKGIL9AOhLJQu4QfIzeZtpRZWzQId9st+JRXX2MpSXpSj7UrnKRWu7EwNoT/OcpSjuJiUXuyzbGCscaNEsSblIKXICs1Tm3Q77S/ZXr9MzuCZcf/RH5FzeBEbE+xgmQ3qmQMFipNswg7UiK1fbVxmCQ4UfoCBBtrw1kEx0gW/ADhsliQSXUMP/ZgWfGD2OnA1LzsiqcEyT9VBY4uQ==
Received: from SA9PR13CA0086.namprd13.prod.outlook.com (2603:10b6:806:23::31)
 by SN7PR12MB8060.namprd12.prod.outlook.com (2603:10b6:806:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 1 Jul
 2025 14:42:59 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::83) by SA9PR13CA0086.outlook.office365.com
 (2603:10b6:806:23::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Tue,
 1 Jul 2025 14:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 14:42:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Jul 2025
 07:42:46 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 1 Jul
 2025 07:42:43 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	"Ido Schimmel" <idosch@nvidia.com>
Subject: [PATCH iproute2-next 2/2] ip neigh: Add support for "extern_valid" flag
Date: Tue, 1 Jul 2025 17:42:16 +0300
Message-ID: <20250701144216.823867-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701144216.823867-1-idosch@nvidia.com>
References: <20250701144216.823867-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SN7PR12MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: bd84e212-4906-45f2-9fc0-08ddb8ad9350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+zV819mdX2uPXoXilymVt8h99Ci5DYiQO2VQ/wrgYd3x0StFrsnni3+Hovn5?=
 =?us-ascii?Q?Gu0Nvnoxzy+3CgUmW6nB3qHUfilZrSd+lfsvhX0goNR5ho5wVTo2rMdnxEaf?=
 =?us-ascii?Q?QVE8nso8taGTnrG1vnTTNbJOz0MaWTUpG1+3yIrSDJeiiv0cpfjlPlZiIdCt?=
 =?us-ascii?Q?s1L3UINdbKbOmHFU1ZGLsyF+Zqb64KUCJF0O0eu6NusO9IcDjFg9MbK3UbPB?=
 =?us-ascii?Q?WX1n8ffkKTAL616hGaZI8J2DSVAfV3fn/vC4QJ+Z5vbMmN+UjPNV+dIDrNR0?=
 =?us-ascii?Q?PmftQYFae32eCXF+6viRzqcKIYPwadu5HNznXUuiS9ShIP7QOJkSCmLLat7a?=
 =?us-ascii?Q?eArVOghmM8/mYG3QjKi/0J+mWCsiVb1P1/Rs8X8xLpqlhkMIklYrRKFgzDTF?=
 =?us-ascii?Q?P8ZbUsYJW6EUZFtTFYfn+bQTYvPo5DFLijn0SK4z3odkKFrEcpPECoyOdgzl?=
 =?us-ascii?Q?H3RoPsvQu5DVJ5LFlvRfPC1nDZmMRzWORqBizzw6EOh3IBT8R4hRNKHIscNY?=
 =?us-ascii?Q?DsRix0tQZMpcItYRhKG+05uuYIUckBdelYg5NZUixhyoi2K7DkZgtFY/DRZR?=
 =?us-ascii?Q?N/GMpwRtrE+dgdZB8/IMO9DPtfChfSDm1m5fqUwVHKfgW4pwj7Z94sZcOl6r?=
 =?us-ascii?Q?7VxvrhPBG3rnBgFW3b4UMoB8eB4mbRTis2HzBsWUYKuzGmYec/EEnBwIQ/H9?=
 =?us-ascii?Q?LIIfwcfLUZd1qzeL1hLSiGi3YZGAtwqDDYA2+LltGkA0Ufy4sMFS3Q6IpQbl?=
 =?us-ascii?Q?bH8LCRJqKs6o0I4q4V+3rMUc8qm7KXG+05Gvy53SWLCVt2dai0PW5wAM9L5I?=
 =?us-ascii?Q?RSlLKNQhm6WSBVHx9ABtbzUaPCYk2e1lslgGAitV1Er5y3ax316Y2T6QLwOz?=
 =?us-ascii?Q?xKnIcptwvui1/GSdRUGJ6vU9Lwa9awiSyFnQJbnjTzud3thxUhpZdxfAAvVB?=
 =?us-ascii?Q?rMSOqGRspnuZm1Wf5xrRfV1l6aCQmAsP/mU1JIRUjah1KIR7T9F1jIS+2HA+?=
 =?us-ascii?Q?w4wnEbx0f5b+YceFzLyR9NOnM19Ltbdi3Ixei9orvjq6m1x3Ag2wJPiaXxOT?=
 =?us-ascii?Q?wY7RZPXksSOM6o02e/arlhpNdYH7JQNdROFm8yckRQXTmRN5Uy9oijjimZe5?=
 =?us-ascii?Q?iB1hFfiYzNL9W3UEfxHcovwd24fybmECVdAbWOWFX7Wt9krlgw3EWmjVger8?=
 =?us-ascii?Q?TtBw49rl6ePjy0/LbiHEJ4LCd2K6RD1M8W84Zn7JGzjLFo76yQriWmT9UHKb?=
 =?us-ascii?Q?sIemSxb08nbA3u31wOXqrfya9TwOC97df3rh3WfnNYDScqAHusretimHdTZr?=
 =?us-ascii?Q?GDpjn44r+Fv1P16gPVkraP+il10HFPZWvYvAFHhyIIr+dWXOjFNoQ+tjiYby?=
 =?us-ascii?Q?RS3HiPjBKcCV0gJ9NBvDvlSjLYnci60JrmD3e7zAe73639y18qb2RFQzZ5/z?=
 =?us-ascii?Q?TBtfsVMiiz9w95ZNuiOYQjFxkkUpu+1H/ccssUEHIBbXJPXwCW6WsoK5uT8Y?=
 =?us-ascii?Q?ymkgTPvdLk/gqIgXThEhQKs0xZr/sLWwcJpO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:42:59.5318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd84e212-4906-45f2-9fc0-08ddb8ad9350
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8060

Add support for the recently added "extern_valid" flag that can be used
to indicate to the kernel that a neighbor entry was learned and
determined to be valid externally. The kernel will not remove or
invalidate the entry, but it can probe the entry and notify user space
when the entry becomes reachable. The kernel will return the entry to
stale state if it did not receive a confirmation after probing the
entry.

Example usage and output:

 # ip neigh add 192.0.2.1 nud none dev br0.10 extern_valid
 Error: Cannot create externally validated neighbor with an invalid state.
 # ip neigh add 192.0.2.1 lladdr 00:11:22:33:44:55 nud stale dev br0.10 extern_valid
 $ ip neigh show dev br0.10
 192.0.2.1 lladdr 00:11:22:33:44:55 extern_valid STALE
 $ ip -j -p neigh show dev br0.10
 [ {
         "dst": "192.0.2.1",
         "lladdr": "00:11:22:33:44:55",
         "extern_valid": null,
         "state": [ "STALE" ]
     } ]

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 ip/ipneigh.c            |  6 +++++-
 man/man8/ip-neighbour.8 | 10 +++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/ip/ipneigh.c b/ip/ipneigh.c
index bd7f44e10426..e678545ad535 100644
--- a/ip/ipneigh.c
+++ b/ip/ipneigh.c
@@ -47,7 +47,7 @@ static void usage(void)
 		"Usage: ip neigh { add | del | change | replace }\n"
 		"                { ADDR [ lladdr LLADDR ] [ nud STATE ] proxy ADDR }\n"
 		"                [ dev DEV ] [ router ] [ use ] [ managed ] [ extern_learn ]\n"
-		"                [ protocol PROTO ]\n"
+		"                [ extern_valid ] [ protocol PROTO ]\n"
 		"\n"
 		"	ip neigh { show | flush } [ proxy ] [ to PREFIX ] [ dev DEV ] [ nud STATE ]\n"
 		"				  [ vrf NAME ] [ nomaster ]\n"
@@ -152,6 +152,8 @@ static int ipneigh_modify(int cmd, int flags, int argc, char **argv)
 			req.ndm.ndm_state = NUD_NONE;
 		} else if (matches(*argv, "extern_learn") == 0) {
 			req.ndm.ndm_flags |= NTF_EXT_LEARNED;
+		} else if (strcmp(*argv, "extern_valid") == 0) {
+			ext_flags |= NTF_EXT_EXT_VALIDATED;
 		} else if (strcmp(*argv, "dev") == 0) {
 			NEXT_ARG();
 			dev = *argv;
@@ -446,6 +448,8 @@ int print_neigh(struct nlmsghdr *n, void *arg)
 		print_null(PRINT_ANY, "extern_learn", "%s ", "extern_learn");
 	if (r->ndm_flags & NTF_OFFLOADED)
 		print_null(PRINT_ANY, "offload", "%s ", "offload");
+	if (ext_flags & NTF_EXT_EXT_VALIDATED)
+		print_null(PRINT_ANY, "extern_valid", "%s ", "extern_valid");
 
 	if (show_stats) {
 		if (tb[NDA_CACHEINFO])
diff --git a/man/man8/ip-neighbour.8 b/man/man8/ip-neighbour.8
index 6fed47ced857..1f890c0d0c7c 100644
--- a/man/man8/ip-neighbour.8
+++ b/man/man8/ip-neighbour.8
@@ -27,7 +27,8 @@ ip-neighbour \- neighbour/arp tables management.
 .BR router " ] [ "
 .BR use " ] [ "
 .BR managed " ] [ "
-.BR extern_learn " ]"
+.BR extern_learn " ] [ "
+.BR extern_valid " ]"
 
 .ti -8
 .BR "ip neigh" " { " show " | " flush " } [ " proxy " ] [ " to
@@ -115,6 +116,13 @@ this neigh entry was learned externally. This option can be used to
 indicate to the kernel that this is a controller learnt dynamic entry.
 Kernel will not gc such an entry.
 
+.TP
+.BI extern_valid
+this neigh entry was learned and determined to be valid externally. The kernel
+will not remove or invalidate the entry, but it can probe the entry and notify
+user space when the entry becomes reachable. The kernel will return the entry
+to stale state if it did not receive a confirmation after probing the entry.
+
 .TP
 .BI lladdr " LLADDRESS"
 the link layer address of the neighbour.
-- 
2.50.0


