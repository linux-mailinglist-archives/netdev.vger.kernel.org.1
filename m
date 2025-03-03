Return-Path: <netdev+bounces-171219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30968A4C01D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE59E16EFC5
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7BC20F09A;
	Mon,  3 Mar 2025 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UXuwso/U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE62036EC
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004410; cv=fail; b=bBLOPezppo655Kr3f/MmASEwRH6v4LX/zZ5IscDNaBnZQnyDp4RpWeClDtL0hJvpczdwFJkSveJLtCLsWjc377sVvIkW9E4bN0Cdn7UHYrS8cTaOXzCp077/y+oYbbNpzGXbCgp82SqhP1h3MfjppfKZ4dKVSvNoCIwRLxtrW9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004410; c=relaxed/simple;
	bh=UGOvrCNjh3T2DrqKekOGKzSXnUyxV25K6jM183b4INk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XaxXYLE99/4J5FIcEp3+/vagLkOq+Amdu8dFyqAwkMqioonKdJS59EN50sQVw2/lKzrhK/HE0FGTY7nLPvCGhBHBA0m7/G3Ko0+J5vgM7FFbXfzHqTIh79QbljfKonMvO2UOMrE7X//LeO2EKs+1vJzU/zEJctyrYShPOhSYJks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UXuwso/U; arc=fail smtp.client-ip=40.107.95.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ug/nEDkn1oTQz0F7j7Imyo5sAx92vCGZhAr5U2gwAS/HKWDcWNFYCDZLtrTZMznNzmdxDA5oRSvNEDJan+g/CP6buEjGHNmyrnzFNMVgK+Zio0hit9lUlcjVVvCzyAk8KhGeUOZw3c/7JMczeL9mY35N0497Msa21xNKWmPbgucNP6KgdjF9ED9HeiFdqxOZ1K2GZqnyAJ2hmIsZVaa3vGr+APnhMCQWRSH7HLrnfl9onRurplhpISWAvOlhcaKsCAOk8w3Eswf5hw9QmCcwHd/rwhQqcsfRDATqjQVFAvo7o5cJpATrwplEcaoSzcXHxz0xoVRieexi/RJBDwaHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq+s6k1eONhnvWKjutBX544qkcmkcDKXKVx4lUlX9UI=;
 b=w9FSi+rtW+34WOhm+ouZQwWbGlOOyKHNZ+lV+ZuZWTUPwL92zxS4V0m3+nv2PbQMBF20bYmwr5U3y5s9RXDqm/mlOZGdGgn0ztsck6feiMgQo8q0T9XOktS7A9zKq2Oeu/3MUIa4TbJJGuY7x39JVtb6B4g3RL47b2DvLtzYKJqUBRDV1I0+p0dMR2twMSSnrO4q/jQt2M660Z8Eb+1ITUdCmq4hJRbnCARfy3g8AORvefIITFI1JIa2eW0aeqkMwZNoSTe0qVwZ9sMBDopnKNCv8WljGhpwbFw1CtI4uN34hHhxnU1J9IQHZLpq22I/vEDQDQUGPxJxpXLESr/EYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq+s6k1eONhnvWKjutBX544qkcmkcDKXKVx4lUlX9UI=;
 b=UXuwso/UXcZos5EyQoFO9o+Muz3Irt40eTnQtQt3jLuiuV38eHqqicDlihce6m1LHbtQF2AdBzY30z6BhB7xv4XYrNdtv8SSy1fnqE+8Id8HrJ/YfctdUS7DCafAuRQmnhAWzaFDz4aJX1eJSSJ0EvY9ZjpPQpHESK6EuEU/hkGpuQ7hzzVFYoLmKK0DwgqqWRzxRVIZ8O1LZ8e0dxA1B/vQ2EPFjSahwOh1lyXVJ9S2BVezknWR3Lk8GfnXLsgEMTDlhoQgDGGkaQqxgB6id3sd7QVg0kov6VMk3bGca4L4yLPEA9FwWqMWWErHvxUwHDqbhTFEjF/4haUi48axxA==
Received: from MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 12:20:03 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::80) by MW4PR04CA0303.outlook.office365.com
 (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.27 via Frontend Transport; Mon,
 3 Mar 2025 12:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 12:20:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 04:19:52 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 04:19:51 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Mar
 2025 04:19:50 -0800
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH ethtool-next 4/6] Move input_xfrm outside of hfunc loop
Date: Mon, 3 Mar 2025 14:19:39 +0200
Message-ID: <20250303121941.105747-5-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 835d9280-a1a2-4b11-75a6-08dd5a4db9cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0zj7SiQ1JVR3jqGG9I88YSE6+z41EMBVhxtcroxjtE9xv0DzyK4td+Hslaih?=
 =?us-ascii?Q?Mhk/SADrNnnO8cX5T2Lmi6Bw7Yb3NzcGPpWDHDZaVbE3R1NxDmzNVAUFOgDi?=
 =?us-ascii?Q?BxgxAo9Umdk2ebPXIw0QjhwoxrCdRbM7zQqmVM7WEcHYtIbNFEM8EP9ont/E?=
 =?us-ascii?Q?86dmX6Rq9hE4rpLx4+f9pExsK1x+AmmDPxekVtP8lIsSRePWeaZOS9qOz5E3?=
 =?us-ascii?Q?kbRJix2XUXfOW9u7e0lHl/Mq96KQqWWP9R617+zsoJXs2zRvlSZpzjjynLP7?=
 =?us-ascii?Q?MckkluSeQOYZA4qV6R40FoZgBdM5+p7lAUC+T9jK9m1XJBkvHKP0n405z0ol?=
 =?us-ascii?Q?fwRm6eQVIOKjGrmm5AjXd8FnT1b5imZUozJmIwjLMKAWBSHzQudpYcVZTVGt?=
 =?us-ascii?Q?75HWHqTsAwgEovbKvAeC3xa1KAtU9U0IeZYlfKHYPP4Bl5sJdhykRfa7twQK?=
 =?us-ascii?Q?4gIorFl/vcXyUxXBd7vQUFWhNZPwz85QrjwLzXrwex9ZrFoag0vO/R5asRaF?=
 =?us-ascii?Q?rm6glZvTKkprLHHDk9pNCgKCa/R6bK0sXlaZ8rMFQ7fuGfSnyGQBGd2SJNVo?=
 =?us-ascii?Q?GMKDAKb0uJmf1o4jTJLiipfvJ36SInZ6PBmgiIWdeRFstspE3ZtynlKkDkvK?=
 =?us-ascii?Q?3mCvqQN2TYv8IajeEjlEBw52QpacsbVGp0rqSIuGVlBVTBAC+O1K2Ui0IBYW?=
 =?us-ascii?Q?PYpfwpgHntJVa6IUVGXs4+21KuyFwxEj3vn6zOM2bwv5Xl5xYvL8Eh4AU37r?=
 =?us-ascii?Q?Dbns1numJ36RZgiBxf0XTWIVPI7wB2PKbZi3jCh5suvq83y/D8fIUvw78OS0?=
 =?us-ascii?Q?2r6xdQYgPTv4iaJtk9A8oHRVnybwDH1y64H1AWmXcs+NoH0/UXrrHm0wvc6R?=
 =?us-ascii?Q?p67OtTAnwv4FhI1aoF0XJdXzN0W4zECmiUHLM6PU4JEPQyffTLTEeJIzCG7Z?=
 =?us-ascii?Q?Fa6T0j7bMn4W+adRLlKO8Rl/bch7k0CQ9dZG1c4Mmrd7hXBRI/h55zT494Hj?=
 =?us-ascii?Q?NFrPHto7vhv13MyLNlGpu+ObU9QxHZBtcwLKxEuTBMvzLQlBbnsQUallE8Xo?=
 =?us-ascii?Q?FodidL+9glghvyfuTSNZK3kxbFCXj0p3+btRXJeKWq/L90cYWzlbTtU8Bkm8?=
 =?us-ascii?Q?csSLxYDxQjhQVp2crM8hJB6AgFq4WLc/mAilFwz6IkUBn4xHBN7C8bDvs2oN?=
 =?us-ascii?Q?EJwcVyeBqvRTYU89tVjS6jo55QZ96y/m0vy/ApktnZen/N+zWZbrjafdCQKd?=
 =?us-ascii?Q?1u8lCh0GPADqjGTo1E7n0VRsAB4kWfIm1PIaCEyXxG0te2dUu7SkHTfJNZOo?=
 =?us-ascii?Q?TazhB2K8bjSipuCeBlObiNvdQkNw5ie7B+lN8hw6aHYCn+b0p074GazOBzTR?=
 =?us-ascii?Q?6nP0FsxOPXXfYnSfQG4twzbUQ0QZ0AAXJhw/CPywCPugWGvphXSINgcBrP2V?=
 =?us-ascii?Q?IQeY8yfdB4gtt6PBEs2TvWA2JRfe7jDaXJL/Ab5xZiP4iH+SXRrrhBFaZzLw?=
 =?us-ascii?Q?xasQ5MG0EpeVwiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 12:20:03.1642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 835d9280-a1a2-4b11-75a6-08dd5a4db9cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565

When dumping RSS info JSON, the input_xfrm has nothing to do with the
hash function, move it outside the for loop.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 netlink/rss.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/netlink/rss.c b/netlink/rss.c
index 7a8c4e5e7379..0207931a5771 100644
--- a/netlink/rss.c
+++ b/netlink/rss.c
@@ -47,12 +47,6 @@ void dump_json_rss_info(struct cmd_context *ctx, u32 *indir_table,
 			if (hfunc & (1 << i)) {
 				print_string(PRINT_JSON, "rss-hash-function",
 					     NULL, get_string(hash_funcs, i));
-				open_json_object("rss-input-transformation");
-				print_bool(PRINT_JSON, "symmetric-xor", NULL,
-					   (input_xfrm & RXH_XFRM_SYM_XOR) ?
-					   true : false);
-
-				close_json_object();
 				break;
 			}
 		}
@@ -61,6 +55,12 @@ void dump_json_rss_info(struct cmd_context *ctx, u32 *indir_table,
 			print_uint(PRINT_JSON, "rss-hash-function-raw", NULL, hfunc);
 	}
 
+	open_json_object("rss-input-transformation");
+	print_bool(PRINT_JSON, "symmetric-xor", NULL,
+		   (input_xfrm & RXH_XFRM_SYM_XOR) ? true : false);
+
+	close_json_object();
+
 	close_json_object();
 }
 
-- 
2.40.1


