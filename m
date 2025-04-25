Return-Path: <netdev+bounces-186106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDF0A9D331
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411DC4C6099
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 20:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E1224242;
	Fri, 25 Apr 2025 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TmtRL5F8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919FF2236FB;
	Fri, 25 Apr 2025 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745614008; cv=fail; b=RJDpr6WA1zkyAmJGCPTybHFaJ3HC21E52OfkuQ7I17yeID+UjYncmY6P95KY07X2ifk0Q/cwkYo82uBhuJfpQuFg/mKdIzU2VuzdE4VSogXKOfqEIHnaVxLucGlntwR6Y/gSou7CGeIvNA2xRBTbptAwkS0KGABMgih8glJcKMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745614008; c=relaxed/simple;
	bh=2EbcsiJOSnkUDqBX3I9YKDbLneeBnK2EEO70HQKSlkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGjxVT4qSaViBUcq004ED2TtmKv5EPm+0/WKu9/YtpxLNzFnngOUGbCN98ENihdGWsgmBYB6SrVlYSb7L6aDNrPnzo5Z6LI+TWB+XmvndcBuEJKmbedgCDFDlTTLAcEKkfpYOsIIRjFr7DfYb+UsDwv0YOzwNEA+FicFRw02QCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TmtRL5F8; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zhk2JAm+teN4HYu+B2/0Y5S2L+m1yroEpwUA7ljSMhlbn9fmUH47M31nHMgRw1wC0b/tkXiPf2BGb3zCeBPTE2+2YFB92zZoS8FzqqwMVkpC1uP32o8XHZVH0eJbuqYTJC9rKu0DBLgB6VLT05up+x/Bx6R50Kn1Ns5eEcndKSrugoGCKAvkpQjTLeQGai4y5byfz2HlQlfZPTMbD9NHXbIW1o2IuVTZ5UP+CKQfusa/iZEsNoWt+0UM8LrCBN/Jtrhrm13JW9km6w2de8TzqzJs4sbisv+0U+fNgbsqDlrciozP0YD88pPc/IQErtSfX4EqTp3MVz9oSyMA5PtSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WARgstx+K5MpDTF/h2KqUkEdJ1/TRshpVl4r1+xMIO8=;
 b=AJmWm+WlpDh7n4uNDhZLj3gQ/PolxJ+18FHpcETlZu6TAjaqKjRFG7P7MfUVK+cF9bhN2Y0J7NAEUAR9Ryky7Bo46IUeT4+YsqVdMyYSdL1qJq6mqwW3zYV8mxjq4fGOGy/2q9zqG+jKNEOlnIqjlYBR1X6iPbhViwyBbawE0xrxobAM43G+ar2OeaXzU7Yz4USmedPaZS9jorx01EG9PsrYU2Ejdzg3SKaDU+900kFQP+4zm3RIqsxwC0uxYdCIjDt+nFSQEUbK1uuUboCdyhGKhJTHDqCsjYjA5zD4v6uMAb2NV3kRSodv5zig0pzL78+POOralcthcuRunGN9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WARgstx+K5MpDTF/h2KqUkEdJ1/TRshpVl4r1+xMIO8=;
 b=TmtRL5F8Coet4ftsq6DiAum0wA6sJY33i+xWguNuXVqEAgScCJuIlY6BTovBv9Q/b1Hynohjb7pMjTDusHOX+uiqnrg/ljin0SYeEiP/n5IfkjzybkZQau707lwt2Uu9rlC7aoWxsJJ2BLMqIUNjrGSCO1EW2DobSRhtJX+FvEQ=
Received: from DM5PR08CA0055.namprd08.prod.outlook.com (2603:10b6:4:60::44) by
 DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.27; Fri, 25 Apr 2025 20:46:42 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::bd) by DM5PR08CA0055.outlook.office365.com
 (2603:10b6:4:60::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.34 via Frontend Transport; Fri,
 25 Apr 2025 20:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 20:46:42 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 15:46:41 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 3/3] pds_core: init viftype default in declaration
Date: Fri, 25 Apr 2025 13:46:18 -0700
Message-ID: <20250425204618.72783-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250425204618.72783-1-shannon.nelson@amd.com>
References: <20250425204618.72783-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: fef0eec1-b60c-49a7-ff20-08dd843a491c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tjUpF2hx7RBEPlK4y1wdQ/q8mOckd5bRvZ4VD8VeKofkiq/CKpU4q+BrBkAt?=
 =?us-ascii?Q?KQ1hr9GYFM/3WGM0gdcMUHshGY68hGqsH6MQqRaKkezzgyHFdpawOpdXlrN1?=
 =?us-ascii?Q?B2WydO+YJTG8lH1wMilcXZlpnPKDrYR9Wljjb9mBsPnxGD1bqzR1djafJgnG?=
 =?us-ascii?Q?VE8/C3pLmNBLZmsx53x6BXfaqPcluOO+2sXfe3IwEjjBK32zQq99QEkGr/mw?=
 =?us-ascii?Q?EIAJ3KQc6V37f3SIv8aRZ4FUxZdB4OKLirnt7Gm1iXn3KCf9Z+5/K11+MD10?=
 =?us-ascii?Q?rqvkmVgJ+g+rKNZMGdj5mdQcnXNQf6sty81tAzw1N1g7ab3Jxc0FwP3ezf8x?=
 =?us-ascii?Q?2c9saBgFm7JRVHuvEXeAoLfPH7xnIsT2qNJIeB8ez3DlRm+BUV9+DW6C2KVO?=
 =?us-ascii?Q?PyyfWy1eouhT58cOb50/KSoV5bwMd868Eb/OovMV1jVjpsEuJ9iB3MlaBsKw?=
 =?us-ascii?Q?oQ9zeODsoQZdEzcItF78pgYCxL+O3F7kgEmvOCeAwe9PbalJWFJJXlYeK7Vg?=
 =?us-ascii?Q?KJOCjSYBHeNlpe2a2YQmOyjzp18PQMHouPstEuhL/M1tp2Ph3nKHRWy9TreR?=
 =?us-ascii?Q?QuViEbdvBwoLvF2wS+05qWh5GAbeBw2BtePO9p2f1UtpdyuPfO+Lkxw28rxs?=
 =?us-ascii?Q?UxkTfQn1GKlitsZGYNKM9EwMIaieT1hYQYR6664yJIkeX1oER4B3spwqlrv6?=
 =?us-ascii?Q?8mVl5uy8MiGRK2NxJCZRflDbVsFixIu9HRVJWhOW6ZkSYfrWblAuz7Sjpm2m?=
 =?us-ascii?Q?gsK4qVIvRVECc0hQtvwIKvpqBcwkZ8O/9JgaBlycxXoIexq4mFSXnc/MD2jH?=
 =?us-ascii?Q?o7QHoCBu5wyj+y40s8/5N9sVUf1cXl034BpUMPEjFQnpT6h444FrsKVyJSly?=
 =?us-ascii?Q?qum4IK4A7VyMNxOwdwpJhAqKEodE36aX2rVZh/HCFPgdUckDy8I+NDqZxedq?=
 =?us-ascii?Q?rdAu1uyAIwmvu4to6GXpk3g4ZDQS5oVbQGvoeR7DE8rWW/BZDHRXEb2IYYa4?=
 =?us-ascii?Q?T3lb0L/ZyI3pwp4uxsRiY3X2tbPLMVGTtO2z1Js+mUz+mIU6bf407pUz5VoC?=
 =?us-ascii?Q?XqFPQqeohYULYq4lJtbMS64HFAZ5+7lrscxq0I2dx8mhEAbSpnJKUDuoNkO8?=
 =?us-ascii?Q?FOSxoxfIfDw4fx4loFhooCmvcTKVlox5eLCv1Cuffgc1ghXLk6VZ4PD297Iy?=
 =?us-ascii?Q?zkRW0fb65P9l07ZKNhi4bIX1Im/+LSf+KMsV94MMP9F8mkeVfFohUHtjvxC9?=
 =?us-ascii?Q?eFG1hmw4CjPDjvIRUvNC+1zzdJqR/TgpIkW3Gbh3WzCrWeJJft6wRT7eyvtV?=
 =?us-ascii?Q?1K8yTeej4HCPLp81cHqz8Bnq72TyVbtc8PH+wSue+Ks6xNm83E8Jw6Zpe/RT?=
 =?us-ascii?Q?wcoA4e0SpX1Cn/CgPSDFiF4iodIEnOw4REEHNaUMxC0jJbkmsZMJtXgcN3UH?=
 =?us-ascii?Q?Y+VXXhPtew6UETceSDYI0zInssdExbiZSU7NeQie5AW4RdMvz+ccYzOb9yzL?=
 =?us-ascii?Q?Cmclr+qnQDOUaydruqEyUB5WifkqZOnN/YiX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 20:46:42.5460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef0eec1-b60c-49a7-ff20-08dd843a491c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478

Initialize the .enabled field of the FWCTL viftype default in
the declaration rather than as a bit of code as it is always
to be enabled and needs no logic around it.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 9512aa4083f0..223547e4077f 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -402,6 +402,7 @@ static int pdsc_core_init(struct pdsc *pdsc)
 
 static struct pdsc_viftype pdsc_viftype_defaults[] = {
 	[PDS_DEV_TYPE_FWCTL] = { .name = PDS_DEV_TYPE_FWCTL_STR,
+				 .enabled = true,
 				 .vif_id = PDS_DEV_TYPE_FWCTL,
 				 .dl_id = -1 },
 	[PDS_DEV_TYPE_VDPA] = { .name = PDS_DEV_TYPE_VDPA_STR,
@@ -431,9 +432,6 @@ static int pdsc_viftypes_init(struct pdsc *pdsc)
 		/* See what the Core device has for support */
 		vt_support = !!le16_to_cpu(pdsc->dev_ident.vif_types[vt]);
 
-		if (vt == PDS_DEV_TYPE_FWCTL)
-			pdsc->viftype_status[vt].enabled = true;
-
 		dev_dbg(pdsc->dev, "VIF %s is %ssupported\n",
 			pdsc->viftype_status[vt].name,
 			vt_support ? "" : "not ");
-- 
2.17.1


