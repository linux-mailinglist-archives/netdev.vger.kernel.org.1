Return-Path: <netdev+bounces-168034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 635FCA3D2C6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DBB18945D8
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B851E4110;
	Thu, 20 Feb 2025 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z2TxPFcI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C21A8F8E
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038806; cv=fail; b=jvggf4rShSoz8nwQL9wxfYl7sk7dbfdibI++AiRgsc/3mNm7fhe2qdO8pnp1xDJk1oJoY6GMcmPCao8VdRqZCUxFo2hVp39H4fFhTWc8nIEtNWIO30n+vODtSCklxv4fN10kG04uuZsLS82jibpn+xgrQfligXHAJdV8sEIAoXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038806; c=relaxed/simple;
	bh=Hykb87wk3fcuOAiU2EYO6rKD3eNX5fKHOcJffvjb/Bg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qDqGd3Cz7mUcJejw/55mhO7hrekhM6XlRdl2h02mfUA89wBzr4Kw4mP2nVJgxg3mwG/m+/aw5oDrIEuESN8lCcNkXGmjx+xfNN1tPuDpr6xC/WiXXsANyPwVeXr4qpPYPmmkRIX2WqkGm/lq3T1I+fY6DmuIVTzEyYECHWxr8hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z2TxPFcI; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFFD8XkeYblQGWVxvgzKgC7HelYA2hMRHZf9ec5YBBDk4m2xKOENdUbX6yr6P4pZb4RTkJbHKpqlHwwroiFWKlVe7Rp+SgQLxC8S+Qc1H9jAWfI6tB1RrSv1Y461A6LTZ0rp2KsHSYTP0VCrjcrzOE/lN1ZXV/Ow3eByxiFi609rVI8YoFA2YikW8Waui1Pb4SbQ0BHbVzxPWjU4s0TFTtJsMEZkj8yLGJkJQiyVoS/TbhTCkVO+RfHycSteBcRtU3T+EeKl62u/MZC4K8NJSXaK3jHpXsPg7hJAeb67iRAAK77G68JGma2Wyu23AU6w7FslyhPqxTeUBJBxwNchPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTc5tSIYWvtUtG5J5baNGvd9ZbesrsdVDD8faWqK16c=;
 b=ZFyeht6/Faz89GzeRf3Ck9/sBw1hfpnyKN3VpZhaq2+Tv4lq+2YkXSOW8HfFvoLGwHh+RkQ20UWhU+7QCACtPc/9VnG2QY1NtPapAFuQ9TDS+CkNvAmG2MnfMgPG7v3rh5pHXhpy5qRAAvC7L8PhpscKf4erVmk9tvqoDPJ/+2ILLGjIoVmRZWvJqgyR8G2/LzYVOsku48bC66OGaDiikzv1Jg8WVJ5IjJw4GYKBQOtPgwfACnpk+rar6yIu1WlHvKVtolLDM1KtXnOvzIzFIgCxL2ZIg0XsmGsbDMoRMfJb89LadRm4bm01r2gj74beHfTQY6Gn9ZbV4EjkfjX3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTc5tSIYWvtUtG5J5baNGvd9ZbesrsdVDD8faWqK16c=;
 b=Z2TxPFcIGS6pVaWT+EMVRpQfqszUSfM2gPUn6CwodnXQpgr8QgzCoSBS+kt06WuCiuENtp4D2maftaL9Z0Jh3/jVb6d4Jna3EovVgCTwJcjNGDeAc+S/mOHb3LRDjplzq9wFbPSCz8VcU21PggHgfmPy4VWkVWyxgfO+DRA+YQGU48mPPPLKZDxRdZRiKX9LquPfyj7HuY7MtajYeK1sK85cBHV+3pM9zvUO4YayQcbj4RgwQYMv/nuMi7mAMkSkO6quI3ZcekBTeL8wABCymviKlg91pDDssvJ14970i3lxqJ0N9L+G5e0zBHVRg0VTVdQlAKJg+xsIvjK6R5uypQ==
Received: from SN1PR12CA0102.namprd12.prod.outlook.com (2603:10b6:802:21::37)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 20 Feb
 2025 08:06:40 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::8d) by SN1PR12CA0102.outlook.office365.com
 (2603:10b6:802:21::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 08:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:06:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 00:06:27 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 00:06:23 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 0/6] net: fib_rules: Add DSCP mask support
Date: Thu, 20 Feb 2025 10:05:19 +0200
Message-ID: <20250220080525.831924-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: b067b98c-c262-41c9-5f4f-08dd51858163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sWpvj4zJq1+wkvFCz+wfaMAfo8VWDrcThol8i5FocPN93A63R3/FFdnAlT07?=
 =?us-ascii?Q?yd0Bktl6yUyhU76+omFYK1QJdokU9x0vWDhnGTmQqBCG42eNoBc/mcRD9GaO?=
 =?us-ascii?Q?MMHXhj9unRoJXMqyeA8kXLcDmpgBX8GheJ00V3p5chTAW1fXBxukuDhyCtEY?=
 =?us-ascii?Q?oA9qT+wbYIdA4fDdTFjZlFhT6UBtGHyt194arrOEdbCZaTYmgxV7/P2CaF7x?=
 =?us-ascii?Q?j1cy56+koct/3Ckcd4X5NsHoJznfzjvu7mkhDRm3Lqv3VZnVWq0Lu63w0UmN?=
 =?us-ascii?Q?XX5csqKykNO3QdTkZ2ovkL13fJ+dhSXSkI0aQOfHdXEefCiaLUCK4M6lWu8r?=
 =?us-ascii?Q?sK7xnC6iK0sZf2fkWah4eGMjUmNSIlpLHziGFX8gN1cfqttiaPqi0OC2UuPT?=
 =?us-ascii?Q?y0kavVoBiHhprL6X4NkuvB9p0+pwplyOyNCF/aez2Ck+NX43pbx7+sJeFFu2?=
 =?us-ascii?Q?Iq5vWg2I37yEHGjZTIA4yw2b29hDkzVvd+baA8MGlDLrVF+9U2ivPdGuEqUa?=
 =?us-ascii?Q?nSfF8ml+nE38bA+FQyK4Al+7A7nfrwYBbFLd1wPYpaNbl5q6EW3Ap3ahIIjv?=
 =?us-ascii?Q?bCyUMSXHHNM3ADhhUOKH4k1yMRzrN/A1PLwG2jT3n2eupK/iww5a8Deg1Co+?=
 =?us-ascii?Q?1Jc4C5XrOvcF0DChXIvJzGTvXbuSv58hXWZLctjZBIb69euqEAWmJ+jicp8f?=
 =?us-ascii?Q?EY9gM9tfXBLs7mhiOIpcktNf6BF+0yOB8P3q60MKTpKnWaoZ0ceIGqMQAF5m?=
 =?us-ascii?Q?05eDIKH36f8RFhw+mIaw/aJXF3OHpalFOmn9YPtXP/yXGp/XbLzwvBXo3dHq?=
 =?us-ascii?Q?HP5PA6kN0J29h1mz/2Cr9A7J5Wc56mUeBwUO9kwc0x4LlqtnxiseYl7uPfJk?=
 =?us-ascii?Q?4EfV1uy3SDF3r88nslE/X4MabF8fxcp8p/CwuX87XpLbLEcWsSVPCovX12YO?=
 =?us-ascii?Q?iluz0NFHGGXAmnTjBJNBjgGrq36s5joR/Q+xWb+JPnwd5OIDOM2OnRW6YbA6?=
 =?us-ascii?Q?PCSaqlVQgOVx4NhYYtWviPhcCrEHvNElmVK0GwEiODtC9utqr0XdTSc1nXFR?=
 =?us-ascii?Q?cGZ0MIi17nVCnPeQngK1VEOxJW0VQVIfgZdDOCoAX5cRVe+YT7WetUXs+D4Y?=
 =?us-ascii?Q?Exhi98lOSokfbm/aZOcq6f4M2eMTYvk7JpreVvX6RVDaw3RUeL+xwAZ0dgYD?=
 =?us-ascii?Q?wmNvdspPRoWikRciEgEIgvNl342RK9ogjWiylrXt77XIRie/SVwwvAFOFanU?=
 =?us-ascii?Q?RDv4ZRwCD/stZc+DKT1PHewBcEqjXQOtOy4ppkuEfRnxHSlhsbIx7j/uZ5WE?=
 =?us-ascii?Q?YWR0dkgMm63GHFumG1UbqvZsJgNgnFDc9XVOWhrOnpStEdSx7t0uDXcZKMY+?=
 =?us-ascii?Q?HLbHrT81waB50JlxcVY7BQSMt/7mQCjegGne8o2i0cSoc/a1N+EGXK4kdakX?=
 =?us-ascii?Q?9K+FG7wtZl2tWG3urIPZm0fDkk6AFwZ34SO7zkePG6JPu8bjWJhGrwxTlqyO?=
 =?us-ascii?Q?2Xu//KDsqDZL5Cc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:06:39.8658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b067b98c-c262-41c9-5f4f-08dd51858163
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216

In some deployments users would like to encode path information into
certain bits of the IPv6 flow label, the UDP source port and the DSCP
field and use this information to route packets accordingly.

Redirecting traffic to a routing table based on specific bits in the
DSCP field is not currently possible. Only exact match is currently
supported by FIB rules.

This patchset extends FIB rules to match on the DSCP field with an
optional mask.

Patches #1-#5 gradually extend FIB rules to match on the DSCP field with
an optional mask.

Patch #6 adds test cases for the new functionality.

iproute2 support can be found here [1].

[1] https://github.com/idosch/iproute2/tree/submit/fib_rule_mask_v1

Ido Schimmel (6):
  net: fib_rules: Add DSCP mask attribute
  ipv4: fib_rules: Add DSCP mask matching
  ipv6: fib_rules: Add DSCP mask matching
  net: fib_rules: Enable DSCP mask usage
  netlink: specs: Add FIB rule DSCP mask attribute
  selftests: fib_rule_tests: Add DSCP mask match tests

 Documentation/netlink/specs/rt_rule.yaml      |  5 ++
 include/uapi/linux/fib_rules.h                |  1 +
 net/core/fib_rules.c                          |  1 +
 net/ipv4/fib_rules.c                          | 47 +++++++++++++++++--
 net/ipv6/fib6_rules.c                         | 45 +++++++++++++++++-
 tools/testing/selftests/net/fib_rule_tests.sh | 38 +++++++++++++++
 6 files changed, 132 insertions(+), 5 deletions(-)

-- 
2.48.1


