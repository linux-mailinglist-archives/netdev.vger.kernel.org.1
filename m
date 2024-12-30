Return-Path: <netdev+bounces-154504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349C9FE3FC
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 09:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3D418811AB
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382A01A2389;
	Mon, 30 Dec 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dzSGplCZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742C19F461
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549179; cv=fail; b=GxgY/J4LaoHqvpNcYfLldh3j/ZrnMjKDGPw6w17EmpdAwjyqDodoZAZTfp2cRlwh9zwNmMPsadxK5EmnUzvYZEmK9soNHnALkmDmMkVgZ/fQLwNbzeJvMKvUSBjqEUf7mT2x9L6LPd3tV+8bfWC1sbRIAgbhQKCA8S2jfVJF3P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549179; c=relaxed/simple;
	bh=3X2V+32zx10YRDsS90NGrBRc1DFNFl1PgV6P+v2Ho5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txWUfdA3bcv61x9p7ffEBTj7ZH0JYg0lQl4KfkM9PshnXiEwtSkrrfg+5CoaMAX92LNRtNqZDeyhGGX4R5vwCiRkIGIQbt6vtC7z3xcXz6cw/rxI+y1E1dIZnpZS7xrUIzhQ3wQZEKhktUVX918TJK3OMb49Uvn+1aScOIMrjMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dzSGplCZ; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuBbloIYBhj42y0oPp5cULoGN5qwu1anHTOYc21MBU/Dtwphfllm2h6v7MqJf0M5Ib2FxRYlYgan1YPZJHnEbTJdGvSC5U6Qi028IzKLVYqVM4TXA8rWPz8T/5P8zbeP7EDJERgAGZdbIqqVLMXzivGOx8Kno5q4AaIzggGTbAw9GtuWMRFA0dUsxYAYRKFI2iYPM3QebivqbDxQqvN8+yoA/ANz3BmfAkEBQzcuJWhCZYSL+GRCKpf5tdCANm83FpQU8kb4m3tgdoRXYHM6GH9K71TBKxmVxBAaV9Xkb8S9oXrIt/siHEHMqe1rEhF3Ctq9CSiraMNZF1t/BwD7pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzPGfWnRgGhDQ9qDSuZpmk1bsrxb15VMDbqVCgFluJo=;
 b=HrcWfVxXtCG/YJLRdi/KbPqYcEudm4XTVlE1zrCRSY58ws3FeUhmtMjfiSWWrU0efXtMk5KmRcsevyK/Am/XOII/Yn1/+T5GOEndHA0jzzbgfuepKo6gIHWshk0qaefKx9rbM0J845gJRjhNUGiwDLWkvFdLB3FmhKILM1poUjyPt65YpYvLAEvSormSJ6BhoZHf5fXfsWxo7pgc6D3Nj1b/KkJWLtS3z0AVq560WP/AudS89J9q8cj8i8iIDm24F+EASiM+Km4cyUKA8o72PL8B0cSpglzxP6QP7Dozd0PmKLWZB6QNMXotFHGdSxHLSMsxgJyZVzEl/l9FuarWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzPGfWnRgGhDQ9qDSuZpmk1bsrxb15VMDbqVCgFluJo=;
 b=dzSGplCZMCsDdVQt9yt0aE+ZFFakkS22qqd1JCjrenru3YpMD/HHZ8iUKw2HgAk/Ctwkm8QZBelRZyCs7IGLOZD1aULmLUYG4CSoTal9CpmRZ4nHeSWspxk02GBCV4BGx58B79OwSho+J4Jws0lD8oSjDGhtDxhLV7D/47oaCgL2xgc8Oiqavy6JEJsPuWtA3UnUXOkIj0PfbnKxWH2trOOc9qsKty7XcqAx7/RXn95EezD4HsQI5saQuOO4hTeaHGbMgtCBjAdEemCBdLiRVqSpKzXepnypwvP/AlEYarRTyG/Ca0WlFjUEddxpFaBra7nvTgKESqzV9cwWtFzavw==
Received: from BLAPR03CA0083.namprd03.prod.outlook.com (2603:10b6:208:329::28)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Mon, 30 Dec
 2024 08:59:30 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::25) by BLAPR03CA0083.outlook.office365.com
 (2603:10b6:208:329::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 08:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.12 via Frontend Transport; Mon, 30 Dec 2024 08:59:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Dec
 2024 00:59:12 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Dec
 2024 00:59:10 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	<gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next v2 1/3] Sync uAPI headers
Date: Mon, 30 Dec 2024 10:58:08 +0200
Message-ID: <20241230085810.87766-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230085810.87766-1-idosch@nvidia.com>
References: <20241230085810.87766-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: b214064e-c978-4652-0ec1-08dd28b04597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?798/0rArzi05Dt3j3Si4IelNTf35taJ3CrjHLlzb0CNXg/FyMjsfEYOvFo8I?=
 =?us-ascii?Q?OlZ3uuaALnPiHwpbMNmKPGDAkd5jF7B3W4EGQS55W7YjFBkvhstrmrkwSiGQ?=
 =?us-ascii?Q?HlGAPdVpRUlsGHD8lfR392ewN3SK2pue1Ye5FMSuXNMrVojRlaCM95ZQHeGj?=
 =?us-ascii?Q?BiOI1jDDMNGRdZKg+akoREWiMumriTQsJI8H7cr/hO/65FMa2SDlIKibq9/Q?=
 =?us-ascii?Q?SFUXsmhivbZdZokCVz1H5nTfauLbczmRzkJ/sulJTmt+emCbjMtIV9RXGQYO?=
 =?us-ascii?Q?itIeVcKSGofE72QbYDMZB248faNmPImzjSnaM67hMOaSSlU658RXDeR2RVmS?=
 =?us-ascii?Q?oaSLzSIggNY9r0P83vh1hHMBu5yVlMASkurRNUKhnpKof6JaMpVvW20DwbOg?=
 =?us-ascii?Q?YB8Bj1y7J0l9ExGatwYdnJ6ZHUnavMahJ+NyhanZ6VzLHiDXTjio/z0xRkys?=
 =?us-ascii?Q?UeT8YtE6sqvGhF4RsYlBB+mSBtteG64dhz3vnITjFB4cSdmNVzXthmxb0Xo6?=
 =?us-ascii?Q?/UkAxGBEM5aaKfki6jQ8+bkuDbaeBsDL/1uX1dwywseowGliyTdHc/ZTX8tJ?=
 =?us-ascii?Q?G2bF6luizPgVtsvObMjVMB3fQJcruDnf+4aGd0+DyvFgXE06BBUp45kBkbnZ?=
 =?us-ascii?Q?8aLoou14FkcQqkJHS/uPYH7PBNqe72J4BBpAY3QZh/MikxqXl7V2HhAm982u?=
 =?us-ascii?Q?ZSkzjbWyP6Ukar5IT22kL6ZPcCLx2ix4et3klTYFgP2KFWXaXPBhiXAQhrXP?=
 =?us-ascii?Q?n51XVwQ1RsdT5EHvLgmrge47F9bPKFn2UkOp7jRE8WXESMlPUxBpj4DW+bgW?=
 =?us-ascii?Q?KnIWp468TnJavriG8BC+ZhV8wA8AdNRzwgmD0OAhBqUeEQMoQTQiAwT1MBCY?=
 =?us-ascii?Q?vSm/B+fR22TIX/A+ekLiU21M/WtMM/YN4MgNkzKEPlSr4tly0aWI/2DJYdf3?=
 =?us-ascii?Q?C89ZNEBGSueEOsa44Oo4d1z5YGYHUdlWtYeSc4EEgq+zrgsdKLJKVj14zjho?=
 =?us-ascii?Q?5W7s4OEWCulqeMrKWNmgsa0XARSvPzbnK8xe6ko2d8eheOkcSfBE1ohgYQRy?=
 =?us-ascii?Q?SG6JjY3nur1x20PiaSc6KKoaWvhAAmHp3L0RxoX9sq9Gk56IUCTdzw7IQVIt?=
 =?us-ascii?Q?IQJgkr8jFUbTDsGYUbVga3Iezh0NOzHF7Wz540H7UEGxGEZN9W4FJj7/WDci?=
 =?us-ascii?Q?boQE31DnPjtH3dVou1UA0L+i0WNvT1F6G36id7C1LLRjO2OK7P5G0ODnyc9p?=
 =?us-ascii?Q?B8CkmbjAiom1a5kQx5/4f2qaqpMu8EeR9yGBy5b0P8EaOGRZim85AAwcEipF?=
 =?us-ascii?Q?pcEQjkGN40MAC+ycc4rKllTZNIgMRIKRfiuMZmZzxPwqsthr+gKB3S9qH1JW?=
 =?us-ascii?Q?iXXkGGluehbj/86fyoPuP2xdptIschDX+wYYgMWcKnW9VULg86m98W2MALjj?=
 =?us-ascii?Q?IeQotcIJe8H01BKnrWRuQlBOP4WIZCzUaDOBCrzh/fWOR6N1gd7hHhd4qKAF?=
 =?us-ascii?Q?CibhtzwN3n3oMKs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 08:59:30.1486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b214064e-c978-4652-0ec1-08dd28b04597
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/fib_rules.h | 2 ++
 include/uapi/linux/rtnetlink.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/fib_rules.h b/include/uapi/linux/fib_rules.h
index a6924dd3aff1..00e9890ca3c0 100644
--- a/include/uapi/linux/fib_rules.h
+++ b/include/uapi/linux/fib_rules.h
@@ -68,6 +68,8 @@ enum {
 	FRA_SPORT_RANGE, /* sport */
 	FRA_DPORT_RANGE, /* dport */
 	FRA_DSCP,	/* dscp */
+	FRA_FLOWLABEL,	/* flowlabel */
+	FRA_FLOWLABEL_MASK,	/* flowlabel mask */
 	__FRA_MAX
 };
 
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 458e5670ce67..478c9d836a7b 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -393,6 +393,7 @@ enum rtattr_type_t {
 	RTA_SPORT,
 	RTA_DPORT,
 	RTA_NH_ID,
+	RTA_FLOWLABEL,
 	__RTA_MAX
 };
 
-- 
2.47.1


