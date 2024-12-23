Return-Path: <netdev+bounces-154005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DB69FAB88
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 09:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D4D165BAE
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 08:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2908218FC89;
	Mon, 23 Dec 2024 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EfzeiZFu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973618D620
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942600; cv=fail; b=jFgN+AtxCpgnFBKoIkO6pR6miKHBH1ZYl02RyFu9WQ9sZC1t9J+rHIC7tNwpU9LQSR3aXModEVHCeJ0a4eEs1k0uFN5+4HgQqg0ZhQ7bWpzoAa67xuvfwBCsWJw8dNkqy7OufVL8tmi4hAmt07lHXZEjNDNl21ywK0pQmcLk/qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942600; c=relaxed/simple;
	bh=3X2V+32zx10YRDsS90NGrBRc1DFNFl1PgV6P+v2Ho5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSPCeKgcpRcls7lXT/aLPx9zfD5dzatThq3mUGEKxagScRdpkcIldnmQvGNpgTaxWBRcuFWxxNDw8Hk3xtMrwAiKt8ui0mlt8wP0Ia3CdDpGqT3Am6tmypNaMlu8OhcsGOYFwNPSs+ET70E1EK/SFLcgL/XAjoe9Sl7VKGxPI5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EfzeiZFu; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzjdxELOV+uA6KWBVXq9fe99KT5o+vgRNHmaO83MQlYXdVaxKx+ZbqYeuQXjdEitoZ2SR8k6SPtpVT1IkY6BtdV/zaWdRUqQaabqLp3JoyjTaWhrJKTcYveZNs3SxY9fAqA+ntzSCKuXVCq3+ZqyLTYZgBsm7z+VbORC6bFeDhzV9z1MHtWPm4fZ3RKwPRKEoTUZ8vNULAX9vRjwHTuMdGpJ4CydoGUuEY9qFPyUlFHnNUvTRmNHuZUUDiiTwF/e2Jsbjx4I9BpPwVWOwrSaMgh1d9HYcpg51prVpTlUZN93cA4EVyWN0gKKgui+nzeAJWMVTa6cZvhABXITQlF/ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzPGfWnRgGhDQ9qDSuZpmk1bsrxb15VMDbqVCgFluJo=;
 b=uWJrMppUTjuC52YJice/B7akooCQtdaGz8d6xzMxJ078d9E4x5aVOeFQM5HIvgom2D+YUZtB0CiH0CXNuVVZMrBn1TNsl5xC65lLIetVNeKuyZLutyXDSE/tsqbyH2Kshzj9PhIwZATSKKlZqVJ8rpjBZIAcrQOd4Zeggdto7jo75S8+X/Hi0AapAUdN+V1iqXRepkhSGDsyA3tme+cdCNWK5Fr0BX6vAe7ZhAJa+Pa197ng6lcfcSMghbp8/5JPoeJEOUBrJqC3KDmemFNEtE2AEtsZ/MV5n7Q2vNc0UP0UCTpJq+AJHIOvuI+VDZsVMZ+BlbZpSbCODO1lx9ICZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzPGfWnRgGhDQ9qDSuZpmk1bsrxb15VMDbqVCgFluJo=;
 b=EfzeiZFungzZceDEIya+j8ipm0OsPfvT2P/9w+0V5VYMXoAqgmHXHAspznzf7FJFp62VVXgByt5Q09/WygXUDoPPO6GUou99iIKZeqiBx6zzGitoxNGQEQvKHkfGmu+ohHk03sf5BmTaVWh/9WNo+/ttNxytYI4Q3yP+iIiF4gBfhN2CiE/ry7juGddxQuXZ9UjKKs/jLLm7FCvjGEd/kkp2/Dc6Sf9T1R8mgTPIrb+XdNcPE7Yxm/VtwbyqglmGnPTR0+mc5YcuZDw14YbMBHqKtabNLL773ds4BdsXHT2GOobhwlhIsHhGML11aZnB15EpbhgIBwOxfQqobtTj5g==
Received: from SN4PR0501CA0037.namprd05.prod.outlook.com
 (2603:10b6:803:41::14) by IA0PR12MB8351.namprd12.prod.outlook.com
 (2603:10b6:208:40e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Mon, 23 Dec
 2024 08:29:51 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:803:41:cafe::f9) by SN4PR0501CA0037.outlook.office365.com
 (2603:10b6:803:41::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 23 Dec 2024 08:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.12 via Frontend Transport; Mon, 23 Dec 2024 08:29:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Dec
 2024 00:29:39 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 23 Dec
 2024 00:29:37 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <petrm@nvidia.com>,
	<gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 1/3] Sync uAPI headers
Date: Mon, 23 Dec 2024 10:26:40 +0200
Message-ID: <20241223082642.48634-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223082642.48634-1-idosch@nvidia.com>
References: <20241223082642.48634-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3c8a69-9d6a-4452-7b97-08dd232bf821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YugkIynSzdJhzz23UZqBj2KUhc9MBEuXjd+5mDM9MlbRMjgcqu6/p9WKu5ea?=
 =?us-ascii?Q?JNY+0gyrnEEQYkkEJ+1F/AM1nbS1oNRWPGsMj6OzMCHrBtNHEC+YfkwrbFUm?=
 =?us-ascii?Q?qKLXLgMHoavk/qJbecNFswaFeHBSvtsIjleaZM2jflMI++GXf0jBi777VrTk?=
 =?us-ascii?Q?BdWSLBJ9Sx8PbRXoPWajpJPqUMshFvN0+3PLKhkOXOn566ZXYl+FMGcuZ4KS?=
 =?us-ascii?Q?J1I+8a9yk89rBXcB52g3xiof/KJknqTOb6hIS81VSgi4zqHTZXvFpWv11Ck4?=
 =?us-ascii?Q?jy/AS8TabIMNbNZ576Yo1gk6bfUS+xPcwepVgw9oslvuSPVKao/WvBJxk04g?=
 =?us-ascii?Q?wRqvOTk11CFFpQdlIsPNEwubQgZ9SniFuOJCP18+4FDuHNvai6+3yV3G6kYJ?=
 =?us-ascii?Q?u0wF4vKU3CsXp8HTFmGWBQfVAzVeLr1sxjvJtDxsyCW4c7H0mw25NKjJu+UL?=
 =?us-ascii?Q?wa3wi6tZYU9wZ+B4ur1SBsRZYdSDM3pCYibl+Ct4xscRQr3jv5kwpB6rrkPh?=
 =?us-ascii?Q?/kVt5YA3bMtrR2I/+89/pbnrKlhSNw5j2YFrparglfzG+l2kuGCpbYalKutm?=
 =?us-ascii?Q?AAyE2LhmQuGfc/MxkELaNPcFqsR27G4coT1++jmQn0H7W7pV2lypyYq1JToP?=
 =?us-ascii?Q?iNU+viKDO5f+FSZ7kSNHrKvIc/qUvZYABQJUetXoxkG02nd0ZHJRw6tBPMMx?=
 =?us-ascii?Q?NhYy/Kg4CIz1BNMcpoiJPsjgp4A5EhkAJONENXikTbIWfkK74hvn4EBUVCkU?=
 =?us-ascii?Q?mPrfEFbdOmBT+EuUvFQs6mZblwxj7yiNoEHSSr0yH6umBg8oFAjzEVyN2iY7?=
 =?us-ascii?Q?nW9K78l0yBXw9m7IPh8/T90o3MYQ/0rbTQNzYnhpRWXB4668k9/37eDojba2?=
 =?us-ascii?Q?TW3jVLdLMGJPwoju0K54WVrIUhSYekiCyO10clNQR/iJOF8nOX1Uf7fC+oH3?=
 =?us-ascii?Q?BGTZMwhopx0XrfYF735rYNOLPU7jicWyDKiy89FNjDtvnpmvK2brzCCdpDCY?=
 =?us-ascii?Q?mN6FXjIx1pli8jLV6kiyHeBZmkeoelE+YawaQoycCAR2UruOFXONlNL/oILS?=
 =?us-ascii?Q?w/RJu1Q+VxPtyP6XLbLqhEFr0wY2LLhaAiAIa8sXNrm1Ndre8wveDMKpXRS8?=
 =?us-ascii?Q?Cs0k9dPSF4MseSwATf0KZVp6We0Udl27QtqP5TmhPbnTLrKig2sFE53cDrKM?=
 =?us-ascii?Q?C8qQ3kYvE4k8ic4b6IiR4LKlMXG4O+tWDDbDDKQTI5nXlwRK2UVN5gK+HU1R?=
 =?us-ascii?Q?jzrI+Xe0ZQJ7ZCaeZptE6VLjJU1LZjjYfsTEP1DGeHvi9O2UGReNGXx23cWl?=
 =?us-ascii?Q?FIfiofGhuHBXV3FC7Gwv2+SOzQ+yXdN2jpZSCsrIdoNClhh3DCtNLb9lz+r1?=
 =?us-ascii?Q?tElPmOaT4API/eTJCNRcKlGPu1qHW9PqQks4Uial7DNE+BRJvBQ4wtrTwxkU?=
 =?us-ascii?Q?d49TfegvdKIF6JzsAcpW3hVGXsZuvwgNw9jbARoZunlKXqWlyvfJ55XpQ1yY?=
 =?us-ascii?Q?PE5w7uDktS7hppI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 08:29:50.8425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3c8a69-9d6a-4452-7b97-08dd232bf821
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351

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


