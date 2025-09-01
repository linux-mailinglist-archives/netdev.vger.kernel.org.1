Return-Path: <netdev+bounces-218652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4587DB3DC6C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 10:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CCD189D18A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 08:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371FE2F5485;
	Mon,  1 Sep 2025 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IM3tWFGQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26DA2F83CB;
	Mon,  1 Sep 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715568; cv=fail; b=te3WSts3hf1gpsbp33SyK6YlE0gfJMsEQwcTaWAm3PKmrccI20ghwNgKlhnA8DOzg5QsJc4sCmWAo1jQouBa1lG5A4FF4W7gHYavqsIPkWSj8mso5o+JzfrAox9hUFMUF6cxqL/GX0+gdOsQ4y0KUnvVXyA+BrjWjsXiZp4ZjyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715568; c=relaxed/simple;
	bh=ton7y4gntSi0aipfWMlWK+wvbI8AgaYvfiC8E7bivPw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R8egjbBx43II4bNGxeOkL5nKOc0eg7S93AhiQUMZPSTOj7Cty8IJ56ZhV4jd2zWuMF8JGkWLgdWpESS0Y22p/pSiR2/aRl55qjXrdJnQGBCFckt6dE1uHFaTreCDF8y8575JWcj3MZlG6ppzZ8wVtjQao6+T1dolqhTI6w/Ke4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IM3tWFGQ; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAExVu31DenjYm3O1UY3ayglgl4APQ+mJaa70pkcC89jGqvoyatKyZSmu3PNhlmh2vlqzHfZh9LclwILs0zmPeKJsAPKubZ0B6KG2ZbAg1yPkR2qmImeZSPtbZvZGfutzDLs8DBd9sEPsRMMfky53PW9PLLmAeE4Tj0AS1wSLR+GNjWkwfFygf7jecHPzTRE0eBo6JS7XLDn1qYTJthFrem30aKgKcAjHM97Mun9z3zBhR0IFw3JIsyb6jiH7xfB88SpQYa1TmQVCHT4lzk7/yw0nMYL4PMIeFn5JFs8MbxD3zNpdS5xs84dx9dUfvS1UI4xA3ZQ6LarDsXg7At6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc6T0wOoNtpvBqTIkqsWD/uLuNaDdJ4h/kJhPq0Q+7Y=;
 b=zQG0WUN8YZgVd7OYxYcqOQmPXjRLQMpEPp498k8d+VSU1r2q9HSYrhULA2PN0pzWxlBYn41L+NPcO3jlTrnucu52TSUjBEyYtthWvWK2J8Uh2N7++S8F4cMymL/feQhJbSXinxNig4rUoybH1wP0gpsPV4tzMmNf98DkyRhvNEtCSPbHzD3J69cSR6U0dh7PGal2rAlqsrq3U9m5zT7+qZIotknUOXMluKN7tFV9zQ33ypUGpb2ZwyXk/6NsV1F1olvzwqou5i2S/4OVQOvXBMzt20kj6Ud2CdEfud6ACyWas6v9Ah/T3n811D11Rys058yZQYf40goZYlgElk4s6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc6T0wOoNtpvBqTIkqsWD/uLuNaDdJ4h/kJhPq0Q+7Y=;
 b=IM3tWFGQG6mt0ZBpM7+Lrm2+3kjN5TLyUOcdfU0Q2vD28rj2+jvLya428ihQlYfdYJFmyWRjBkiBGThLfHv4BGQdsTHDG5DsKPtyLVY3Vuqs6C63Y4wDdKlQitqMtHa3vSz/xhsBuqRn1dOGdir4LA/8fFu2kXmGyA2XUdlLVZ7Wgtom7dBiLIp/iq/uO23kDxJbRoaKELPZNjMUzF8I00Kr7IJbEmPAAFiuSS0v3jpU/0nVFOwJ1gtWJlK8re/TwEet6//gWbaL0vueg90jFPzUEv+9+XcJd9Hj2MmtltZm41Z66CrctFniWzd/XlAuoatYDCfWiCMEnThKQqdCqw==
Received: from CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::23)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 08:32:44 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::8f) by CH0P221CA0007.outlook.office365.com
 (2603:10b6:610:11c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 08:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 08:32:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:25 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 1 Sep
 2025 01:32:22 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/8] ipv4: icmp: Fix source IP derivation in presence of VRFs
Date: Mon, 1 Sep 2025 11:30:19 +0300
Message-ID: <20250901083027.183468-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b1b055-593d-4f41-6745-08dde9321f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ZrthJ0m54Xdh1PAtEnIcvnrGDms3oAh5FORhgsqolaMpq2icg7m8JyVR/r5?=
 =?us-ascii?Q?vehycymeGZHZp2OsJXsGL6bNAc/M93kpio3Z7/Wm4IwkD2fscne4eF4Qnas9?=
 =?us-ascii?Q?Q+hhAp5Y9d1FAzuaLx+wf6c+xN1B3NiOnPKCqySyR86I6nZSyuEPM944hRXG?=
 =?us-ascii?Q?wSRJQLSmm8G5rpeF5msISQneHx6WCIfuSiqxzh+wKaah87KaqtoI1kTodlYF?=
 =?us-ascii?Q?ty0RThg3bBr5i0aC14AEpzV3sZSqppQLiZjZVseB296WVNSD186935vUiWAc?=
 =?us-ascii?Q?z4EUL2JtdRqxiaAOsEE0MLsrDwjVp0YyZqpJcflZCjq2eeTBuwNKZaAg9KMC?=
 =?us-ascii?Q?vdwCxbrRe+8TH9T+Iy8WKcv1tni8I2euhfso4gA97hYmyad2HT90YQ8qPqoJ?=
 =?us-ascii?Q?qAdw+3hudJrLxEeKvhud5zDY2ZZ7EFVuTT+3nmpDUErcInYAs7Ra8DHcR+IS?=
 =?us-ascii?Q?gV5tFG+d9+b2x4dvBactSmCmJ+DcdgWwHlLkdx9kFIR2b/XCRZ960lAIK2SC?=
 =?us-ascii?Q?8jIj+9nnzfl/O3cKUjZZkNXNjK75JQthjHsITzwpyT5BnNhwhXBS0jxNVYY/?=
 =?us-ascii?Q?RO6uqiD3rsI+jKvOrU8Gmg1Ho5L1hQuF/faWmZJwx6ICzH/nfngjkmKtHlZ0?=
 =?us-ascii?Q?8g0Yw7kBClBvdCKdzmMzD99W9hVwMkQaQCvS6JM8FZdJ+AjX1hb/obPMMWyX?=
 =?us-ascii?Q?wX8seCWw3EmA+NqKu0Xza4779wDWG3qI/SF7S5WfL45QL47kbYL0aDfd+BQs?=
 =?us-ascii?Q?khWmMN7BtNJjjPPs0utdDlevGTnKOokjQuSSUDwSBCZqFvMfA3rOPyJWKD/9?=
 =?us-ascii?Q?kV36p6Zsez8SvwwgchQcvm8gByR3DI+XTN03fnAbPivZervy+gKPBgefF9uB?=
 =?us-ascii?Q?MLECRS4srIvc+wBS4qZ8E173SMO0GHLW2tUXtAOWqkWg+8l0xLvN9buIeRmF?=
 =?us-ascii?Q?5g94K0sqso0EM0hGZ8dzhxzpESrQjZui4JjW63DaahVBCGlw9xT3XispJW7R?=
 =?us-ascii?Q?ni1J/Zm4AtfofTYLsbLSc5HQ1POLsE/o17sq5vxp0EldmMtoNJdKABFCrpdy?=
 =?us-ascii?Q?e/S5aNUJacENmskmeNLskhTxJ/cmnkMtOjS1oA/tdSCEFfOSZqtlppiPaW8j?=
 =?us-ascii?Q?Lb4LRlwnWEDwGMwWfQMDEhhhA8ZwfPqKRUjnH9rzSKmjjmeMv1IhzUnfy2xr?=
 =?us-ascii?Q?YxAYrRe0Dzo7CB+13+P5g17wgefChW6LBDHpXrfIkuG8maezNBZHpmeTg37r?=
 =?us-ascii?Q?LSGryb9wELYD5p7uq83M/pmiYk4xI/HTl8UnuxqpFz5bFtAEzQEG6Wce5eW4?=
 =?us-ascii?Q?TpphFBZn9RlEZd3VGJmAfgAgZc51MLtenCkdyN4sWI2vUcChvTyK2Jin+L8V?=
 =?us-ascii?Q?SkLPUJpLTdszHRbf8ZMUppOe8Vss3S/itJCxmOKEebN/XMMoIsRDRRSIIW+N?=
 =?us-ascii?Q?hdbh1OFWfgozgbh77OL4wy9FrqgVSovsyEWIhJEtLQ7jffLPD78LtkWDV5dU?=
 =?us-ascii?Q?uy3w3HI8RUMdc+Sftw7T/YAJP6gsKf2ZXfPq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 08:32:43.4451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b1b055-593d-4f41-6745-08dde9321f1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

Align IPv4 with IPv6 and in the presence of VRFs generate ICMP error
messages with a source IP that is derived from the receiving interface
and not from its VRF master. This is especially important when the error
messages are "Time Exceeded" messages as it means that utilities like
traceroute will show an incorrect packet path.

Patches #1-#2 are preparations.

Patch #3 is the actual change.

Patches #4-#7 make small improvements in the existing traceroute test.

Patch #8 extends the traceroute test with VRF test cases for both IPv4
and IPv6.

Ido Schimmel (8):
  ipv4: cipso: Simplify IP options handling in cipso_v4_error()
  ipv4: icmp: Pass IPv4 control block structure as an argument to
    __icmp_send()
  ipv4: icmp: Fix source IP derivation in presence of VRFs
  selftests: traceroute: Return correct value on failure
  selftests: traceroute: Use require_command()
  selftests: traceroute: Reword comment
  selftests: traceroute: Test traceroute with different source IPs
  selftests: traceroute: Add VRF tests

 include/net/icmp.h                        |  10 +-
 net/ipv4/cipso_ipv4.c                     |  13 +-
 net/ipv4/icmp.c                           |  15 +-
 net/ipv4/route.c                          |  10 +-
 tools/testing/selftests/net/traceroute.sh | 250 ++++++++++++++++++----
 5 files changed, 229 insertions(+), 69 deletions(-)

-- 
2.51.0


