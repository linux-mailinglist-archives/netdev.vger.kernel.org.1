Return-Path: <netdev+bounces-171221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81960A4C028
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B58A7A7C14
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2EB20FAA4;
	Mon,  3 Mar 2025 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AXZRZYhR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1920FA96
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004413; cv=fail; b=es+LS8WTiUVEomurBVeroL1jonPud0+4B1IQNuaNueXZJVn+AHK62fUrErUYvzE/CcRsPob4T4FGKerCsaMXDLyHC4wHtp95RdWya2NldVsSmq+HPw9daIxLotYuVzKzCcWDZ9ONS26vInf0ANGMDf8rq4V8KF7Gr/b2k46ajaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004413; c=relaxed/simple;
	bh=A7l2IuyOWhsfgd4J0rRB7F0pTuG1GVZFymO6E0WTuw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1BRDP3cAoGidwbJuKpNeLLVbDVULCsZ23GsGyDfVIHegR2WLQV4LrnipD7PJTEsFG6r6TWQKx1RY6Xe6UIyLqS5ZW2gbgVJAv3Rl7bFMbXqlHDrDrkuwMzmAkQJYXNf5yie+af7E4vs4NfHwnYVKGVFuwjC71cAiJO3eJdKluo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AXZRZYhR; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ie5y2yE4pHrCdF/1PHV8QYJfdwkuM2vExeWtdWVu5fzYSANiviyrxMS3e6dVtzjGrCHjpdRY6CWr7lNuGocpXZfnkAQ0w5d7+HGoXWoDSpJ4ROEvFiKE2hOgVKEmuAzCiabsELa1vmROtLtwA+t2+b2sxv/QkPzlvyB1GtYuluAN4FNnr+bW++nnS8MJRD7N58bsnoGTNpdB+gME5OgIyi2h8wHVfr2bg0ji6uE/3HLjuktecYG4lTwpU0fDudBb3bWe0Xe1gYt96W3HDsEuII+cXFTNCrGYry2nTe2EgxbaVBXrZceu9r6F2wplypCnc6BrTjPI3/6Uv5+g5blI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbkPZSUPUx361RfSmYq16w4CpmPw9tXNITWjK+M7S98=;
 b=ji5OT+QUdSQ8Vu+a167WKraLS5Su93pzvEmCNQH9w6HfKeGi/Cql+I7wjyJkgVSHB26ONOrsh3DQdC810bk3LJKqqd6OnKTmq68GxomFPRDHadO2YJNOGU5m6N1pbplzvIBnNO5DjaqhfgNCoQGI4ePkk+8DwI9ePKJJm3YNZnz1f0nfCCrPtNkhCYSIIzPT/JlN/7RfXwAEE3xbUiyNd8Ve12Uz0GvNsOIW7wpBNv2VxBdFV8kVZr6/+a3OOYUlzyC5DYtFMEJPZ5oxgTCEXxAtMVGDqTRhgKjozUNTeOjen4bJgwCmv1aKnuj3SB02+XMB9k44m5v6GPTbZmVylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbkPZSUPUx361RfSmYq16w4CpmPw9tXNITWjK+M7S98=;
 b=AXZRZYhRVn/J/sX+iK3KSsre7p7n+PgMrZZC1Pt2L2YjDIpiDiW3IRYhNYBvcYEk0iaRQsTEiMx4tZT1aq3jr3RHvqiUofn7K6JDqfAq+eTvN949YV7q/UFBglEDHFCwQaBGNQXcGBHRQq3+H8MnRROHosMfYvoTjZz6T5W1reVSc8wTJiD9061WCgxBWAw2jzRnc32Kd6f9aaaYwM77WfLub1X5NG0/lFoUaX/eLRH8Mfalpr9cphAt7pujJlNc14PKMM74oPxt+Fz2s3Zyc9QZj6+Pm3/jrB9s4Xc5X222CjXjUp/WMBZKL61xPFy41xCylDpL33R6Yepsk3/4lQ==
Received: from MW4PR04CA0193.namprd04.prod.outlook.com (2603:10b6:303:86::18)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 12:20:07 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::9a) by MW4PR04CA0193.outlook.office365.com
 (2603:10b6:303:86::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Mon,
 3 Mar 2025 12:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 12:20:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 04:19:56 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 04:19:55 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Mar
 2025 04:19:54 -0800
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH ethtool-next 6/6] Symmetric OR-XOR RSS hash
Date: Mon, 3 Mar 2025 14:19:41 +0200
Message-ID: <20250303121941.105747-7-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250303121941.105747-1-gal@nvidia.com>
References: <20250303121941.105747-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c2da36-298a-4f6c-459a-08dd5a4dbc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YV91Y+6ZwEXsVxvw1db8/pra2jh3t3+kPhvYAk1AsAwIpY3s1wMvWweh3Sb+?=
 =?us-ascii?Q?Adaua6o0R223e8qfECGFaTr/ddOPpu4UvrjjqyNehKTbBuvmNmpHepmDph8d?=
 =?us-ascii?Q?ES4tJpfPUpEHyDIVflaW1kXSL7jSay7/jxO9XdOFbeg3KFu5ReyVYPdKJqD3?=
 =?us-ascii?Q?XS1BT0MdzA+pv3dQf+qUQX1sDteeQlCE1tT/l1Geu3Naqjp2VvU+bdquhMsc?=
 =?us-ascii?Q?NvIGbiSq87+yvNMRHXYLVRS1S1195aXm9N1hSZdnC3GLa7S+Rzuk4FJFUsrF?=
 =?us-ascii?Q?bZRFSfc6bP0bTnka/+6wf2zU8z1jq//DWcFMWjKR9LhH64OY6LtLZaU/BoCk?=
 =?us-ascii?Q?oGcxOrMwvJTYoa8XoRx3aFyBp3v16Lsn8WQEj1MeEWYhE33tfw53eU8iEymd?=
 =?us-ascii?Q?9bPdT6SiMNxj/DeYkMdddycL2VbYRXqJz2PsSEo1Ee+119KsXGXEze9DRyLV?=
 =?us-ascii?Q?ydIq6+XJ0S/Hh0Sl/zE6GnYyT3HmXAGRWl9k/WlKPBMAtd6AvuPCQLhapAn+?=
 =?us-ascii?Q?9/JK7AdUhpJeF/M3Q/m10gn0hYVUnR7YHspppp5t+rg9suY+GRAighcYXICE?=
 =?us-ascii?Q?MWjOUdDPaBPoPmKhvxHNbxDHB5tRXLlTFVA/N91tyEjAEoZrtU73DzJ4Faa8?=
 =?us-ascii?Q?902EZ2068qAqlSrWbJjPviXoqtV1hib/8DN7jML1H8zrDYADDAVVg0cfI/TB?=
 =?us-ascii?Q?IT7IWrrVQm7iTGp/2AxkQjSrHP5k/m5EZ2PwArASWcn8MkStLJ84dDhopyC9?=
 =?us-ascii?Q?wPqyFFwazTaF/jOJG3Uycc0BeVr27GL/HBDBPMpu/hnvLR1jYqOFU50H55tg?=
 =?us-ascii?Q?t6u5bTTfU3psdqTzCOVjDgy+jwSsg/UF++hRP76tT1UxopNEs7OmO/7dnkbN?=
 =?us-ascii?Q?SKCCSiW8gC8nvH2WdSqLqreg8/jRk36KPE3/pZAzUCKR+nR8Onfh37qGFqGM?=
 =?us-ascii?Q?skX4HgCc5hvj4emTDB3+jJNcA4G+XkdlpuBg/OJSNwPB0FXU8EDlla4u4X85?=
 =?us-ascii?Q?TxnrsVuOIZTaOPz9cSCCqGdrrMEIoWTgopXrO8jZGo6jwJLhr14+ukbbb1m4?=
 =?us-ascii?Q?9Ap+TrAegzuVaAF7YL4+OnNtGfuQK4MEmpnbETzm7NMCZrJryh9mnWETr7Pp?=
 =?us-ascii?Q?s24tTyhH203zYRdCCvMqK5YSIQBMTWM1qiu6Dvc73RsgllehW+gExqmll7h2?=
 =?us-ascii?Q?N3t51Hj7Jv0sPOqReGsrSDpcBVBnRTsA/Hz+XZ6Mgu7N96sKrBetycWN5ZbN?=
 =?us-ascii?Q?v/xsfIto/0N/fgX+3dyVkv3b6fvUFDhuitE+inuRs1qOIOsSsoDDfm67r5/G?=
 =?us-ascii?Q?cdZ/PhZbvN0lMb2Pr8GyJhmVETEEJY4pm1v9u8jphaYxzWBNhMgbUb7eKx5x?=
 =?us-ascii?Q?wKpfjmTndfgllN989/Nj1B+dg3BJtmnrqL5bFwzIvp13MQuT2floN0wiqE/o?=
 =?us-ascii?Q?rPAT+7j6CSzMkPMCN4s2o+cwcOFqCNoO8bFWp4kOjiH+baD46U2oQgsBnwK1?=
 =?us-ascii?Q?eKzJSgWbnM7faYg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 12:20:07.4030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c2da36-298a-4f6c-459a-08dd5a4dbc52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076

Add an additional type of symmetric RSS hash type: OR-XOR.
The "Symmetric-OR-XOR" algorithm transforms the input as follows:

(SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)

Symmetric OR-XOR can be used through:
ethtool -X eth2 xfrm symmetric-or-xor

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 ethtool.8.in  | 14 +++++++-------
 ethtool.c     |  7 ++++++-
 netlink/rss.c |  7 ++++++-
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 9e272f7056a8..ffee0fe5a3b5 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -358,7 +358,7 @@ ethtool \- query or control network driver and hardware settings
 .RB ...\ | \ default \ ]
 .RB [ hfunc
 .IR FUNC ]
-.B2 xfrm symmetric-xor none
+.B3 xfrm symmetric-xor symmetric-or-xor none
 .RB [ context
 .I CTX
 .RB |\  new ]
@@ -1253,15 +1253,15 @@ List of RSS hash functions which kernel supports is shown as a part of the --sho
 .TP
 .BI xfrm
 Sets the RSS input transformation. Currently, only the
-.B symmetric-xor
-transformation is supported where the NIC XORs the L3 and/or L4 source and
-destination fields (as selected by
+.B symmetric-xor and symmetric-or-xor
+transformations are supported where the NIC XORs/ORs the L3 and/or L4 source
+and destination fields (as selected by
 .B --config-nfc rx-flow-hash
 ) before passing them to the hash algorithm. The RSS hash function will
 then yield the same hash for the other flow direction where the source and
-destination fields are swapped (i.e. Symmetric RSS). Note that XORing the
-input parameters reduces the entropy of the input set and the hash algorithm
-could potentially be exploited. Switch off (default) by
+destination fields are swapped (i.e. Symmetric RSS). Note that this operation
+reduces the entropy of the input set and the hash algorithm could potentially
+be exploited. Switch off (default) by
 .B xfrm none.
 .TP
 .BI start\  N
diff --git a/ethtool.c b/ethtool.c
index f679f253d490..2df99eefecde 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4119,6 +4119,9 @@ static int do_grxfh(struct cmd_context *ctx)
 	printf("    symmetric-xor: %s\n",
 	       (rss->input_xfrm & RXH_XFRM_SYM_XOR) ? "on" : "off");
 	rss->input_xfrm &= ~RXH_XFRM_SYM_XOR;
+	printf("    symmetric-or-xor: %s\n",
+	       (rss->input_xfrm & RXH_XFRM_SYM_OR_XOR) ? "on" : "off");
+	rss->input_xfrm &= ~RXH_XFRM_SYM_OR_XOR;
 
 	if (rss->input_xfrm)
 		printf("    Unknown bits in RSS input transformation: 0x%x\n",
@@ -4291,6 +4294,8 @@ static int do_srxfh(struct cmd_context *ctx)
 				exit_bad_args();
 			if (!strcmp(ctx->argp[arg_num], "symmetric-xor"))
 				req_input_xfrm = RXH_XFRM_SYM_XOR;
+			else if (!strcmp(ctx->argp[arg_num], "symmetric-or-xor"))
+				req_input_xfrm = RXH_XFRM_SYM_OR_XOR;
 			else if (!strcmp(ctx->argp[arg_num], "none"))
 				req_input_xfrm = 0;
 			else
@@ -6001,7 +6006,7 @@ static const struct option args[] = {
 			  "		[ equal N | weight W0 W1 ... | default ]\n"
 			  "		[ hkey %x:%x:%x:%x:%x:.... ]\n"
 			  "		[ hfunc FUNC ]\n"
-			  "		[ xfrm symmetric-xor|none ]\n"
+			  "		[ xfrm symmetric-xor | symmetric-or-xor | none ]\n"
 			  "		[ delete ]\n"
 	},
 	{
diff --git a/netlink/rss.c b/netlink/rss.c
index 9ce56c2c687d..83cc50416dc7 100644
--- a/netlink/rss.c
+++ b/netlink/rss.c
@@ -58,7 +58,9 @@ void dump_json_rss_info(struct cmd_context *ctx, u32 *indir_table,
 	open_json_object("rss-input-transformation");
 	print_bool(PRINT_JSON, "symmetric-xor", NULL,
 		   (input_xfrm & RXH_XFRM_SYM_XOR) ? true : false);
-	if (input_xfrm & ~RXH_XFRM_SYM_XOR)
+	print_bool(PRINT_JSON, "symmetric-or-xor", NULL,
+		   (input_xfrm & RXH_XFRM_SYM_OR_XOR) ? true : false);
+	if (input_xfrm & ~(RXH_XFRM_SYM_XOR | RXH_XFRM_SYM_OR_XOR))
 		print_uint(PRINT_JSON, "raw", NULL, input_xfrm);
 
 	close_json_object();
@@ -177,6 +179,9 @@ int rss_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		printf("    symmetric-xor: %s\n",
 		       (input_xfrm & RXH_XFRM_SYM_XOR) ? "on" : "off");
 		input_xfrm &= ~RXH_XFRM_SYM_XOR;
+		printf("    symmetric-or-xor: %s\n",
+		       (input_xfrm & RXH_XFRM_SYM_OR_XOR) ? "on" : "off");
+		input_xfrm &= ~RXH_XFRM_SYM_OR_XOR;
 
 		if (input_xfrm)
 			printf("    Unknown bits in RSS input transformation: 0x%x\n", input_xfrm);
-- 
2.40.1


