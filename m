Return-Path: <netdev+bounces-171220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B7FA4C01E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4393A6F1D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C41A20F083;
	Mon,  3 Mar 2025 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tN0FB7LV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6B20F09E
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004412; cv=fail; b=SjwfzlwdS1BUqdhYa6K0V0dCaA6KZeALhf22JL3iLbreKKHUSalrsxkaaJi6DJUENjplpOGpM4CoZ4JayIs27u243qZWCfhFZwTULT9HRIgv0xtGb5Ckh4FoybPO5xxwy+2wW+YF5Fh2rCbXVhW8uz1m0PVIutcfYn8MeUsfK0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004412; c=relaxed/simple;
	bh=jLsygoKZJjeCk+V6zmk/cT6HlC4L+flzSf+lP1b1JVk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcuueK2z+5JFcHDl2mfV1qEGgt3bOpKw3D5BJ57CBiVYCWNJKTibAjdfmZx/j9419cQ86da62miO7vTKGcnbcWDEsT0KPvW/yvBgFAdphlvSkAxrMeyQV5UoxLcSjQJOyAi9yqmXf3cHKSxHKIFLUDaz7TzF5NMxjaA4iA0VhZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tN0FB7LV; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwgAJ71q/BtvkzuH1YXwGeX1A9Bluc0k0uGaK9T2EwuR7dbOGmgCEDu59xmhul4ZASkHe7ihapxV6fLETa2WhQGSaw2wzqDP2bRCVKnEzd6dZWvL9QEBtFmwun8HXvVEEd97npJmdYgj/P7VVUYfHXUMNAYS50MQoAz0CGkwESamNRTzz8hbkpLgs8kD7nr2R1Kbo9cJWYEhvxwdvHyoZ0NfkHILG9c6B9ECnYX8rU9xnF7XSV/0Fb4chOGTMhnzdpu63xw8IVcwqdElskHWi4C8GcCPxd+XWjM8kKO1LSmMrUn5PuRbhm2qcTwd2twD6yrCpZgDCzUscQPcAQPTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pkz3h0Z9fLpv/JotPCiUrWdFI8S+7TQeoM9W/RKgFBY=;
 b=JPSTsWCbvVzMzJwMoO6xxF3GLkyG4jfn0A25rdcSnv7ttuLxPLgDYVQY9W73aV6yC6LPYLa69k9lCjLP+8W0h9r+fH0lKTkXgq28Ivoz1uHIqJfz8h2YmBpizdXBlwd0fbBIBN6/I73eamv1nHGbLx3MQwsZXLEiYTHR6hRIntmRaohSG8Wq0UxV+s6yRTecEXZ9qrz0GRZTcYyvgu7o5cnaLVSHs35QNqf/xV4Z6z/zkKDvk5XUt9Gk8lwv+HMVs9wPJYbMduXbALXEm1VrkCHT+NQ20K4GTNWmwIVZTOWDMviMBs4E325ByHYlN7SsbuDthfNrF7D0fbXuSx7xww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pkz3h0Z9fLpv/JotPCiUrWdFI8S+7TQeoM9W/RKgFBY=;
 b=tN0FB7LVkhBIuGpxyKmCo5FhDGSckP27hP3NVYCNiQ2ts2y7vJkM1aOFORkEpAVdVYLB3wj+NG+7ECZ3jy2w1p/4FbRE3reL5qjFp0PEt1BkT/7IhtBD4MRe2RWFbf/P0qHJK+RE18vnt63sPOzuoLLwhC1XAv9eoiEua78HjOatwSBUQB9h+swoOJevVtRKnVZGS4/P2WnQPXgVgzfMry7/u98++kVgXM3yUpssonnc37p0sqIiQeZzY+sG5MjYa7T8GRNCm594C/ba0fH3qxhqUvSPBp/YeMgSakv1VgoJUKBDMqF+WMgP5+4rLc79+A2/tDmjqp/4KEERfWaKDg==
Received: from MW4PR04CA0192.namprd04.prod.outlook.com (2603:10b6:303:86::17)
 by PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 3 Mar
 2025 12:20:05 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::2b) by MW4PR04CA0192.outlook.office365.com
 (2603:10b6:303:86::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.26 via Frontend Transport; Mon,
 3 Mar 2025 12:20:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 12:20:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 04:19:54 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 04:19:53 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Mar
 2025 04:19:52 -0800
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH ethtool-next 5/6] Print unknown input_xfrm values when encountered
Date: Mon, 3 Mar 2025 14:19:40 +0200
Message-ID: <20250303121941.105747-6-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: c5151cf8-98de-4838-f4d2-08dd5a4dbabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TQ2YoOUF3TthpymSmFQsIjGnvp+3sxCX23fMNaqEOU3k45r7HHTXouhXSMuC?=
 =?us-ascii?Q?mQOv/RhDWHM3HXEtepJkXL+E4oc/UQheAyDb7D27Ue1ILQ1RF5vmXN1TfHQu?=
 =?us-ascii?Q?rbTVlA5PuPKMPfYycenEwSojcExHn6ghKKWIwfo+BlQfSB/D/c5f9YBxNiZV?=
 =?us-ascii?Q?WfEfWa/YvA1NnHVuCiLV9EgsHMcX3BR80PRKTJGVqLZTUVvI+JU+rUqWmZY5?=
 =?us-ascii?Q?QHu3tyGR/JG9j22RVkT0gJDKf0dJs3cL3aBfxyT2PREjLTIYkW6gLUuao6IG?=
 =?us-ascii?Q?HnfvTsnhNRCjTiFyavQpOGY4w8pJMJt1sPK/D0Ak1F8NlZj/PmK3GfWt1zNO?=
 =?us-ascii?Q?1bpFafFZWhK1iPLCFAGxkk2Zam5J5IwLzNMJ0bIdzzMwg3MlXLfMa8FaprYA?=
 =?us-ascii?Q?c6Xwfw159qsHRWsQLbKJ1HDbcIoqria7AQinQuBUEiV0DlVxp4pqv5zewJsH?=
 =?us-ascii?Q?seykMmwEknjTzklcS302Sj0aK+bkXxMingOdLdgK9aAB7N5SrTzuRU/lfbJX?=
 =?us-ascii?Q?TAhIKPl3CfDNcvD22j330I7+uG/W1JD+f4PjYBG95D7qeoZfco3bLC6pI3VM?=
 =?us-ascii?Q?ktdtBrcatfGhqpCQnrZ+Edic7lni8K8sgvAo8t7JkzmyYMPOcKUYDcjIHUx+?=
 =?us-ascii?Q?dPN6AoLmiojxPUeiP4GdhOt11aB/7H7OZrM9Nvhtus/zR1nrucYWlbtRoPxR?=
 =?us-ascii?Q?czxSPRm+ApgjCmGrl0bIcYGFlQc+sbqhIapEWVt1EPMlmnCMNU8DkRH1BFVu?=
 =?us-ascii?Q?SomotiLVzw2B6DtIDEFMaryLwiUQ/pt1THmF+jugGv0s/YzY0FahWS7e7qSb?=
 =?us-ascii?Q?BcnEn0YpkB9bXCBp/SDBmHa2xyi0e0DEoc5wVpUT+bd8g8r61CTOs2UVaBjN?=
 =?us-ascii?Q?K/WvNFQjjwhNnjdmFUt876QxqYRebTjCKJi4zesqVqv4UVp2GQ/apQw8oYOl?=
 =?us-ascii?Q?YAQnosbuFzaQI6xtPSfP9ehvkieQSeqnKM1a8FEXzRjUVb6b2v9To+5/oXfK?=
 =?us-ascii?Q?ro7UYsvUpXfEHF0DaAU77rYHZsGymc81wsiILqRGbWD6x/Etf6bRnEmOLNAi?=
 =?us-ascii?Q?9PMewg175YMM0mNbVsmcPAXOqsiDk40mwTEGsOP64hnx5ryyj96vTwJMka80?=
 =?us-ascii?Q?uhTgQo0Gbv7mzeTLc+RSb4VZvaacGEI2VbcpxP5GQAOL2xf8G4SZMOFpgMNK?=
 =?us-ascii?Q?JSo1LjbtdyeR5kZx23dNtZX1Q9crY5FRkg4RH+homptLbgCJU2sgHC+G//+1?=
 =?us-ascii?Q?czS/DVK2bmqPTWXMD20QXNiW74SEprjUbOENUazqiZL3T4cv/QCSmjnp4DbT?=
 =?us-ascii?Q?yerQelv2UwobIROvBkIfaUaEf9ME2TJV+2aDzXxPx+ZqRyzkQzq//4txoNDU?=
 =?us-ascii?Q?/HiyWtgEBsljc03rlHLkcsYdqRcuXJEq61GITvRKCkYyMXeZWfzx46ZVfavH?=
 =?us-ascii?Q?hAyez/URnXT2VPbAQJ/i0w7XU14AkOeNeUrZhhCyBxoqqfwsspVHMqu+6oc2?=
 =?us-ascii?Q?IJhgS8rRBnwJxIc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 12:20:04.7311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5151cf8-98de-4838-f4d2-08dd5a4dbabc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203

It is possible for the kernel to report unknown input_xfrm values, e.g.
when a new driver which enables a new transformation by default is used
with an old userspace ethtool.

When such values are encountered, print the raw values so the user is at
least aware that some unparsable transformations are enabled.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 ethtool.c     | 5 +++++
 netlink/rss.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/ethtool.c b/ethtool.c
index 1c58dbf1c379..f679f253d490 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4118,6 +4118,11 @@ static int do_grxfh(struct cmd_context *ctx)
 	printf("RSS input transformation:\n");
 	printf("    symmetric-xor: %s\n",
 	       (rss->input_xfrm & RXH_XFRM_SYM_XOR) ? "on" : "off");
+	rss->input_xfrm &= ~RXH_XFRM_SYM_XOR;
+
+	if (rss->input_xfrm)
+		printf("    Unknown bits in RSS input transformation: 0x%x\n",
+		       rss->input_xfrm);
 
 out:
 	free(hfuncs);
diff --git a/netlink/rss.c b/netlink/rss.c
index 0207931a5771..9ce56c2c687d 100644
--- a/netlink/rss.c
+++ b/netlink/rss.c
@@ -58,6 +58,8 @@ void dump_json_rss_info(struct cmd_context *ctx, u32 *indir_table,
 	open_json_object("rss-input-transformation");
 	print_bool(PRINT_JSON, "symmetric-xor", NULL,
 		   (input_xfrm & RXH_XFRM_SYM_XOR) ? true : false);
+	if (input_xfrm & ~RXH_XFRM_SYM_XOR)
+		print_uint(PRINT_JSON, "raw", NULL, input_xfrm);
 
 	close_json_object();
 
@@ -174,6 +176,10 @@ int rss_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		printf("RSS input transformation:\n");
 		printf("    symmetric-xor: %s\n",
 		       (input_xfrm & RXH_XFRM_SYM_XOR) ? "on" : "off");
+		input_xfrm &= ~RXH_XFRM_SYM_XOR;
+
+		if (input_xfrm)
+			printf("    Unknown bits in RSS input transformation: 0x%x\n", input_xfrm);
 	}
 
 	return MNL_CB_OK;
-- 
2.40.1


