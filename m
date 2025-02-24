Return-Path: <netdev+bounces-168895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DACA415B1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6203F3B0E4B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8289D15886C;
	Mon, 24 Feb 2025 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xl8b0+LP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC91C8C7
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380013; cv=fail; b=gmQpwQshsf50jAkwvivNFH1oHIMyS/sVj5mLLq34Ydn5yTgMOmmL6nV4Uw/2WbPMaEAJuFTP2cBjzJQmVjHF9NNRFkEeAUxD4T/siVYHLIsTYwo0JvXJiQ4y9KgKHnJ6A6i+mocLE2/9AuedNZM4hqo+qAsuCKyzP5ZhChChcWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380013; c=relaxed/simple;
	bh=Etu7CA7PGslmJxs41c6/bsDKb3TSkXbnC99lx7C7QqE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gz4EOwwgLvds1uUMh0qpCRnMFZ1zZAl+KotIn7NADvhW+qBydEARacGpGE8t+Arr8bUju94Hl8ohROMJA1AfQHwNwNj6I2RoQOHbLzF3BZaHncn/06vidd+cGDsoMnrRBVEiNKUSDJ/jVqxxwnNGIzlVj24yxu0zHZIe23++4tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xl8b0+LP; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/T32/7BmQsxxQfvgPO/4LtkuuxgbsmV79xyDxwqd0jWN746Tr/ZEfMf6L6ZkHBM4A4i8NflZiOKSDIJ4saIq4uG0i6qBOotR0gPiaC6SOghhxjkzNlF1+g9auhGiWFjSDTogfWkJ0PzTfe1lradzsevZUHiBle+5m7VNgKUQxoKkf3CMcK52q499fhw3ocuimYhs2LmuxbB+rHxmzVTXxxnPkdcUse9EsIMkSLqWGdmDPU6Vi4TRJl7Q63ygwKiX4atIpIVIZ+PE09dT+L9jvhq3/GGUZfw4J+3go22lP1XIYMwlgKXJp9VcnLw3BdoMoxtsTGgOKrkHmeBrIv4HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZhiWCvpRXyHuYMm4b1iCbhwkkABQeNgGaUzc2qa01I=;
 b=hp67bMhvFt4k3qx7s7uQ7amVl1N7CP95XwHWRDIQ/h4Bus3seBKQhzqMHNV1elUQ81KV3YrCWj7hCm6fGYUXYCkNQ32kmuL0EdjcQiMS3VkeDWiuWmkZoFlKQxR4Sd+vu9tCNMYuSRu9Xpzm2USRDnKYBO8jjVZE2VOX4GnGbiAisTEoQvHaUU8ewIoxul8N9FQy6wIwYDOVbjV9Snj7CkqDaViBhAsv7iAuB7T77Rx8PgSC/byo9xAKD5gtOHeow/ojz/f4yCZU4nPSvcf+bGIOW7pweT9BauNzdtFPMRwUG3TPOHSoniMbelQgxTYBerd0hpb4O3hEZeiE2A5UJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZhiWCvpRXyHuYMm4b1iCbhwkkABQeNgGaUzc2qa01I=;
 b=Xl8b0+LPcBN3bxGGYkfNbdl6rBWYygnbCOLyHVEYKYAYUNafE2TEiuhLAMhzXTVE087dwKvXll8VRXNoVnXUINEkJlPA3q54PdvGGlWgLSo1GFNculPM3SOz21e24nYJv9l9t/tPjrF7x2FgHybocaI1ApJR/GydkNKnTjmKIt1U2GM6+gAMeYjlZRtiOueeCW4ujxLtEzEf46HEJgsn6fwjq0z9Mo1UvcY5z3I8XrtF9yRXugTbCK0VS3ScAAK4BaC/0gS/uvY3GwR2Z+v6f59rXxVrAkIb2oqrTlompkNFQHpGyapUppe+wkIzrRTSb92HT5vhcpXd1WzTtFoYUw==
Received: from BY5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:1d0::12)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 06:53:25 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::10) by BY5PR04CA0002.outlook.office365.com
 (2603:10b6:a03:1d0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 06:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 24 Feb 2025 06:53:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 23 Feb
 2025 22:53:14 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 23 Feb
 2025 22:53:12 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <stephen@networkplumber.org>, <dsahern@gmail.com>, <gnault@redhat.com>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 0/5] iprule: Add mask support for L4 ports and DSCP
Date: Mon, 24 Feb 2025 08:52:35 +0200
Message-ID: <20250224065241.236141-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: db0a3c6a-e07f-4a7f-0455-08dd549fef54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hVb894ppNlk8g3TxpFfGP8dFRZjx7arfQeUKdV5pY3ItI90hlyszgFYDchh/?=
 =?us-ascii?Q?xwF+g1lAPUswClCqBrGeklb9jyav5M0gnreyY08WE19nR8oeI3Uh5lLCWLae?=
 =?us-ascii?Q?CZiVlU2xXiUyTZUofgcAn2ynY6WaMtHIGLAdjoePc9Vbs0yfm177/Saodw2Q?=
 =?us-ascii?Q?Gxrvpl5JwFH8R1737JuST9Ew7Qsihird2lTZrDGPZ0Eg6wX/9x0hQlL+pT+A?=
 =?us-ascii?Q?fyYWUIw0zpg5Hj5xMbcsang2h9/FlFncTO0ymNSZ1ZJNZJw+av+hAFt89bBb?=
 =?us-ascii?Q?U40h0lHeJO3sO6tVtP36I3rcwuU318bO5rcHx6ILORvgsmvCXfMoOur3rEqb?=
 =?us-ascii?Q?MgCk8rSVqKHU5qAm8XhsaEuwdDLmMFo9JLToK3U5ZcwX0WkdwwKW4Wcjscrv?=
 =?us-ascii?Q?hMHkATJ6Z91DV6N923XAnmYXQpNuV04ahlT64isP3uZrOhEJr47ov3tVfieA?=
 =?us-ascii?Q?IJh1hN341bOKRyWJqzmf2b0dVofJPR/N2JKH4La5wzKXbFzscP62R3b7fbZd?=
 =?us-ascii?Q?kCj3Sa3/oooA0b8NfCMVY5IifiZSea/3khJXq1YxWekMTuK9EYGmgqsW1Fv8?=
 =?us-ascii?Q?HWsNI/dyZQZzsL69mVzIZRnvSdGZS+uPoPcEZHEcl6OXb23yzR44jnJ75yA6?=
 =?us-ascii?Q?q9AM8FH4jgbJIMmD3Gb4dVoh46uFQ1IGxqJRkkf6Kdy3u8IH8DmU+mFdozhB?=
 =?us-ascii?Q?ayH9L2PKbODC94V3J/4mKsVmOgWjl3Ib59GokWu6dT4/j5Ot+V3M1OJc+ed5?=
 =?us-ascii?Q?85ovsVK9ZMbFndwrw+zRdhTnUvaA+oB694Kb5ffFrkau4EcuRditHoazEjWy?=
 =?us-ascii?Q?SUDnijjpZc0alEESIWDCJ4fpYDm9rxXtVKAnxa1RFeLgHKVBrkFbWnhi0iKV?=
 =?us-ascii?Q?YPLi5GipTXd1CNXF9P+hiSuc4+N58lAt9EMWS3NbNCOSIZpxnPmHHw4MkOno?=
 =?us-ascii?Q?bkfQ3rqI+hDv618eIPo+3FBV5VAnQrreTzWk2SscBcXORt+w1+IrFJ7AZJnW?=
 =?us-ascii?Q?4uzvMWoC1GT17NxNsW2OkXy33R9QWTavpR194hQp4K4o69c2zK/x6cejv6LF?=
 =?us-ascii?Q?1PKFaUUeK0/cPzb2kY0TZjqdnzDdGylXrE9HzGOwb3l27D155//nzuXFniw8?=
 =?us-ascii?Q?ZinKBUFo/AVtp/zLWCM0VsJplHxHR/k1DGap0BaiibVphJ5eTfyKWegTdXYv?=
 =?us-ascii?Q?24219BMxckXmDx4x9sfyd0wuPAbXSDJHPWDE+4kIE0/nUPpO41XGk46HExkB?=
 =?us-ascii?Q?0gwpYAtPbwfYOkrInnL9pIcvkmk5eX8CH9Kw0v45FonT1ayxK506OcCCCAuK?=
 =?us-ascii?Q?uaW1Z4m/ssiMD8g2gM1Ih9FB0MyP4qOGyRjLgiW5uT27qnrX2bWq89LeVan8?=
 =?us-ascii?Q?NflbqsIKKF3ibrItFnEnK6sJuyvfM5wAyIuNRpNHrHNi+C5fNPpw7yxYpniv?=
 =?us-ascii?Q?fgLJ/M6txafUPXxp09RtZivVdkd4Bq4z/xSy7+STVxbnM4y5eSs9axce8c9y?=
 =?us-ascii?Q?iejvJslVBxl/+eo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:53:24.7803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0a3c6a-e07f-4a7f-0455-08dd549fef54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271

Add mask support for L4 ports and DSCP in ip-rule following kernel
commit a60a27c7849f ("Merge branch 'net-fib_rules-add-port-mask-support'")
and commit 27422c373897 ("Merge branch 'net-fib_rules-add-dscp-mask-support'").

Patches #1-#3 are preparations.

Patches #4 and #5 add mask support for L4 ports and DSCP, respectively.
See the commit messages for example usage and output.

Ido Schimmel (5):
  Sync uAPI headers
  iprule: Move port parsing to a function
  iprule: Allow specifying ports in hexadecimal notation
  iprule: Add port mask support
  iprule: Add DSCP mask support

 include/uapi/linux/fib_rules.h |   3 +
 ip/iprule.c                    | 223 +++++++++++++++++++++++++--------
 man/man8/ip-rule.8.in          |  23 ++--
 3 files changed, 185 insertions(+), 64 deletions(-)

-- 
2.48.1


