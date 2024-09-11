Return-Path: <netdev+bounces-127309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B1974EC9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A2E28366B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2A0176FD2;
	Wed, 11 Sep 2024 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iPBjJvUe"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DA155346
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047513; cv=fail; b=ge8X99pd3Z/5TsW93D9j88tABUXNYGTC70yj/hMMnDnV7GHUyNQonHgU0ARgt8xaM5i/3W8LUc+xGXfw39HnmcErFUHP5xVeniftoZJj6eCbv1gVuQJd7SMNrJ7mub9700JQVB2BFBqhdczW0tsDhp0klAXjYtYCxrvAU6cF9pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047513; c=relaxed/simple;
	bh=80//76hnKUAqGd582ArQIY7oE42X5zfucJxRURqzANg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NDKXkZqqw+BRGaWOtxlvw8d6hGEu5GAzWKY4Bs1PS4lEaBHCVuexbrdp2IJXOWoOkQVWFONVk1m5iatZoiGpy445vzkPZ5sseV4jQwkMkKDHPoL7bFotceCTSXAyt6l5tzmrFc0Iglpt8w4vhwPv4MMpiHkagU7JhJUpnyYwZps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iPBjJvUe; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNjCEA/oHnZsG4RaOrjURHpOXA29e/0bO2p+gXvYKtBoqaiwbHYXidwPjg/KB8C9upio6ndyavo903qvdSuomLQlBUOzLiUsQ+cX6B6kc8m0AP+GRNvV24A+NoRS0jEJDzKw02ysYpJwmYqNPATMoeMtS1vnWTKCBpx0ZTEi6s9v04ftRiwnFIBR7vX1prmvB2DIRM/06IiO9XCH5TTOius+jqc4+ulBPB7y89bJG4/fTt/H6Wp3XWldGxnS76PObbCcmoHzlLpdEcLtBFMgiNouN2MqtbD0paNO81//IblcpNZzDpmopcf/iZg4VgkiLNJ1mm96xS1wl1YD0WFQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ra06nxt0S2qQZiK3qwpF3S5P29c7e3dRsxrNJyRYSt4=;
 b=xSf20M/AhhXf1aMTAd4CFCNFN7aDxBa1xLRT097Cwhw8SCLs6Oahu8n82OtcMB1/HpGlVR2ZjWsfSspBgBLhlKg4CzBJp69dLtgUJQ51JXjdXJqSLeCdG2o107hAPwfnHL8JHXyinm76mduMZz3LOOku2clTjCdjDAPmR95IhnsX0kp1x4ClUu9lQHGisDjmRTi509gerozFwX3/dt2habvq2KGNv/FLI6igb6mnU4pTQXyxsXsSsZSq/E9UbggJBgekrWqXlajtoUAztrmNmIcOzmFNmD8a/L8TxqHNrmqq/XNZkAJTxtw7Yz8OzAxKSwk8nwe8Zz4oHQRtNk5yug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra06nxt0S2qQZiK3qwpF3S5P29c7e3dRsxrNJyRYSt4=;
 b=iPBjJvUepyp6cstgKtCO1T9gJUYxABS8cNuUe797sG4lFzglgPbkFPWmtztu23p1K1+zi6vduydGZCh/xZmXsZGPfTBd22Yf1zkoYuh1MDartkZ7jBRz6EbIqyt4aAHYQ3JcBAq/kAiJUBWGF1XBT2udWBLUzaZnltsOASuDeNfpieN73/oNs3RfFh/TMhbnulewy6P6AAVwLLywwfEcYU6Vew50aQJgeYDPyi1554KAvzANiZdHCxzjMGAF2a/PL+1UAOlJPMz8208XyR2x70VWt4cASRq+RANJxn+fd9PPSBZYS2OGZrJMyEooYuLGg0GbyFXVqjBOgBMCufFILA==
Received: from PH2PEPF00003857.namprd17.prod.outlook.com (2603:10b6:518:1::79)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 09:38:27 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2a01:111:f403:c91d::1) by PH2PEPF00003857.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Wed, 11 Sep 2024 09:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 09:38:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:10 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:06 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next 0/6] net: fib_rules: Add DSCP selector support
Date: Wed, 11 Sep 2024 12:37:42 +0300
Message-ID: <20240911093748.3662015-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: bf05946c-303d-471f-bef4-08dcd2457ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f+JvsYe5FDE/K07XQcfb5YEoyiAqXX4KMptTc9taTBS4w9zDSNTRvqjS7Xmy?=
 =?us-ascii?Q?HMsYen/ovXFQRDIe1o9Mdm1SOIEe+cGL/AzLK5/OjEd05JIN67NYVJ2FBcDG?=
 =?us-ascii?Q?IHJ4joFMLC+cwmhf3ZPPy9T9CYbWV/Zl1v75gVIAfXT8aP5oRXTqoC01jIAk?=
 =?us-ascii?Q?80/OBMPX/HA+ByOSzibFBKOVua2LimBnzwRhMWZ74fkThSh8fWS4PRbEC0zH?=
 =?us-ascii?Q?xHEwwfr319C+gfPkZKICx2WeKzYQLg1qYviDmO7vg4yms+Fot7C0mPDpjXTe?=
 =?us-ascii?Q?JmwUttFwLiAlVyadUrSxlSMQOayV4w1EHy/NXlFEryYJ9lzW2jCKuEgG0ZRh?=
 =?us-ascii?Q?FEPfXBM8YYEBU/M/tY3jCB8DfGipB5zy2X0fQkFgGTzECPE7Z95WTRCUEpVN?=
 =?us-ascii?Q?Y6W1kIlwQEcc3r/1V9Mffon7Asy/yJXPFkdYb008/yE482Lpy8Me1CohnanQ?=
 =?us-ascii?Q?fJ0n1qWRi9C9xi093QCOANScMZ5gK0UcWElLeQXfs7t3+IpHMF/SziIEuxti?=
 =?us-ascii?Q?dbhMCIhxTJW1tOreI8mX7VR+sUz538V8TS6NKEC5K0lGlFyi+6mR8AR70WjS?=
 =?us-ascii?Q?/X0zsvyWLisQleSPZ9Z6rdfx+QT4CopF9Vb3IACXhzQzl8qqihtC0Rjhqgdn?=
 =?us-ascii?Q?rohk2xC60y77hTvRDM7968va0iqJDg7DP2Q3zvA9MFzzFwg6YyT6mnzp2gol?=
 =?us-ascii?Q?dnmMOv9j8+UTVxWhPc14VUeBHuyZnFmHt/jYuf4XkKdrU+TsA+Af3hz75s7M?=
 =?us-ascii?Q?ZnWfhuJRUrWXQFDkcdV0RkwGFhlyYKxnkdLwS4MEcK6TMObcgG4kyOUVRQZ0?=
 =?us-ascii?Q?s7EG4BuYG56RDsqrxq2+ILrr/8l0mON5j5JUpYe8uS9IGrPcNYZyMm/OloMc?=
 =?us-ascii?Q?piI3T9P/nv+D8+29hpaotvj2f3176+9RonC/CGL2H5LN2sGCKIKAeh62xKbx?=
 =?us-ascii?Q?nRdvcJbpmS+zVN99bqKj8bVLoxGRbyNkS3z99W4hR4Fx8zGeoTBDB0omTIiU?=
 =?us-ascii?Q?3Vmu6U8/6wpnglFLQe5zzZYeUDNvYq/003k4E3zMnTOqPWAGVtjssq5ZOBqn?=
 =?us-ascii?Q?lmTtnA5yfChw4raWk+QMo4o9qb4gGSmfKpKyM4wvhudeYIwGsIDifVIUegVB?=
 =?us-ascii?Q?4SgBqMPifoQneiuoTZh+G1nWwpztSfIzsSGO7CIJ9Qm1s9fc2/+dOgDDfJG7?=
 =?us-ascii?Q?eGPY65Xf10JhJllTYfJ8kZz444YdLMFP4W7eAppPbNUwSV/8u5nHKOecqHQ5?=
 =?us-ascii?Q?QVxi3eUGjfMFDKvmyDfltdzCdr0ohWc+mDGVQwHAkFbUJbLceqm43Esz4F5f?=
 =?us-ascii?Q?qzsEpKiDB1oT34CyS9A94O8GX4UvSAToMljDXD4dzU3Y4e7oEn6ox+wX46Ks?=
 =?us-ascii?Q?bHT57WCmAxI2AH3rju/Vy1dWUfDw+46+U96uqnGk87WAV/r0aBKB5DidgL34?=
 =?us-ascii?Q?EeuLdSzQYOFMGk6rKkB+0D5B+dFePcwm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 09:38:26.7890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf05946c-303d-471f-bef4-08dcd2457ccd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078

Currently, the kernel rejects IPv4 FIB rules that try to match on the
upper three DSCP bits:

 # ip -4 rule add tos 0x1c table 100
 # ip -4 rule add tos 0x3c table 100
 Error: Invalid tos.

The reason for that is that historically users of the FIB lookup API
only populated the lower three DSCP bits in the TOS field of the IPv4
flow key ('flowi4_tos'), which fits the TOS definition from the initial
IPv4 specification (RFC 791).

This is not very useful nowadays and instead some users want to be able
to match on the six bits DSCP field, which replaced the TOS and IP
precedence fields over 25 years ago (RFC 2474). In addition, the current
behavior differs between IPv4 and IPv6 which does allow users to match
on the entire DSCP field using the TOS selector.

Recent patchsets made sure that callers of the FIB lookup API now
populate the entire DSCP field in the IPv4 flow key. Therefore, it is
now possible to extend FIB rules to match on DSCP.

This is done by adding a new DSCP attribute which is implemented for
both IPv4 and IPv6 to provide user space programs a consistent behavior
between both address families.

The behavior of the old TOS selector is unchanged and IPv4 FIB rules
using it will only match on the lower three DSCP bits. The kernel will
reject rules that try to use both selectors.

Patch #1 adds the new DSCP attribute but rejects its usage.

Patches #2-#3 implement IPv4 and IPv6 support.

Patch #4 allows user space to use the new attribute.

Patches #5-#6 add selftests.

iproute2 changes can be found here [1].

[1] https://github.com/idosch/iproute2/tree/submit/dscp_rfc_v1

Ido Schimmel (6):
  net: fib_rules: Add DSCP selector attribute
  ipv4: fib_rules: Add DSCP selector support
  ipv6: fib_rules: Add DSCP selector support
  net: fib_rules: Enable DSCP selector usage
  selftests: fib_rule_tests: Add DSCP selector match tests
  selftests: fib_rule_tests: Add DSCP selector connect tests

 include/uapi/linux/fib_rules.h                |  1 +
 net/core/fib_rules.c                          |  4 +-
 net/ipv4/fib_rules.c                          | 54 ++++++++++-
 net/ipv6/fib6_rules.c                         | 43 ++++++++-
 tools/testing/selftests/net/fib_rule_tests.sh | 90 +++++++++++++++++++
 5 files changed, 184 insertions(+), 8 deletions(-)

-- 
2.46.0


