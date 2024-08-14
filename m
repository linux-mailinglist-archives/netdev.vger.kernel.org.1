Return-Path: <netdev+bounces-118440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B07679519A3
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DB9B21815
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F711AED3E;
	Wed, 14 Aug 2024 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rw7tZsIj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B941AED45
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633871; cv=fail; b=OCiFM4GuqijVz+zolAhjAIrAUAQJfwrlQ5tC3X8XXkLQjI1GmiZuT2PV/yXt+j8bzznDRonvgS8WLb5jILDXVxYjKmfLQTRwhuerbmjIc12eIjGGt0bnasNz/A4U32NMlL86+D9Yj29BYaCsetG4bmdJ6IMaSr2WfO3YYiw3cIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633871; c=relaxed/simple;
	bh=hxxwyWefDRx5W4IwEaQzi+e+HKE6u3XKz6OiVrUGcSE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l2+G0SqFoVZ8yJwYh6nDetNf5LtOUEZsHuiA42PRvIdmVqaVNS/fHB1bZQXclbpM+9ft5Xl37bX/V05dkHsyH/9xOMQ/NwFc9O5mXVT3rkySrYKnmIQ4IflvAXBQDooljf7VEMXm0e1T3FGRJKuRMoLcRW7OGLwhpf9Awcqugwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rw7tZsIj; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0k1bD7paN8enaX58RgrrhPnQl9/OfFMDbuiHhdL8zNA6b6ZqS+Y5CrP+KcWaCLjs4Xtjwoj+KbqlRw94TIOs0iyZdOtPEMpDT70cGOhdvIZkH1KHb1tY7e/v0DgVhSkzny75KC4ilWvwZhR4qLVuofFlksDgi2g9KsHpN6SRjcpo2hqVcI7BHUzHHs/QIaTKXA9PtM0Qd4iJJPsOCPQ0D9pX+O10gtup4qgXu5zN+tmvxfnuGo05nGadPapiIgaXzRLMO19SDnXAlej5Kr/ZjUjNg3+ChohVpzyD9NNzSM9DhYGAF2NFNPasmOz9O4fLLh9Uhz6HSsOvlJ2bCdTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNxLyPyBa621QBQJVFUtQnnp79Q7H681aMSdFZ/AdtE=;
 b=oTr4bktEHKxK6cub+cSEAHR3vrdrBosXtnFgE1robMRmtb30lM3UShcUothdvkmU1bXaK2u85BeyNVQIXNnMDpTtXNOKK5rJOk7SLdmBP9rJ6CHAvDL8WVudO/4M8F1yu3Qr8UKmUsK2RssATx9SS072arEJh21QR4ATAYZxPk9JTyHOx7SizFtDLgAXZk8OM+rtkE6x2HRl0eeWpL6Q8bf3Pr0x8Z/hCXmfeRQk8MFSgy8cToYvsMJYUVc3Pkxp6821a9xPPnfv7gcAV2KtYLwM/shm84mWblJvrwdX8eB51h6inHZiDnxujLuUv1Sq6ehsc1vVK5H/je5CYu1XHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNxLyPyBa621QBQJVFUtQnnp79Q7H681aMSdFZ/AdtE=;
 b=Rw7tZsIj7jYoTG5YwTGRFcY+RZVBj7ttx3QlRTVGPKWH0l0yDDv1OndhYUnQfYJ4H4qRwDKCJH/cC9Hf2AHyAGzwSLjWpVQT7P7724Z+vP/d4h6RSTJh1dVhBtZrqJOkkiLN4HXMERez7LR1FnUe3vEAwp4rFrrbssF9ZWUhVARLRwOrtjp52a/s0P/hbqufaWutrnHzuX1PNyXDhjCq0Is79klktTTEE1wvn/EhtDImm5uA8Lpab0NSvJ87Zbg9gTumNb/TkLUbS7c7PmB/1mCuMNusj6IlMI9LZ/pHlRtFt+A6cTpHAaRy6Y6xRz1RjahtS1JV3wNEVKnQifN9uQ==
Received: from PH7PR10CA0009.namprd10.prod.outlook.com (2603:10b6:510:23d::29)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 11:11:07 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:23d:cafe::e3) by PH7PR10CA0009.outlook.office365.com
 (2603:10b6:510:23d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Wed, 14 Aug 2024 11:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 11:11:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:42 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:38 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 0/5] selftests: fib_rule_tests: Cleanups and new tests
Date: Wed, 14 Aug 2024 14:10:00 +0300
Message-ID: <20240814111005.955359-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c94ee5-f885-428e-695a-08dcbc51cb22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QorYScArIUefR/eQSe+DsZkV+dgdvo1EzPY9PjIqqm8nDlWWgs6iRmU6f9Jo?=
 =?us-ascii?Q?zbfUXH5vlpMlCXyKfq2bgCtQJ660zcupsmKLEJNYSU4Y4x2CEcNAeIj7JANU?=
 =?us-ascii?Q?AdiqdbWf0U556bAC12H/eoQg97iVg8tguuCupaa2ln307milP5tT3XM26cGz?=
 =?us-ascii?Q?V6McHOtOTUIdV7Iw2g1X6XUQ4bl3cjTH2q650Whb2tP3HnivF1PMeFbmIzOF?=
 =?us-ascii?Q?9/ybcgH4u76bZ4RBLA2YaBj6TixtEczQ4FkhEc6fP2c1bSNbk5KU9/g6bqO4?=
 =?us-ascii?Q?EsSUgDPZhF7jDDHElZfSnOTLzWxR27paaFBe1iKt/ESZMXKGXljQITi7LrHt?=
 =?us-ascii?Q?yIOamfqB6ov2yfCkcjwiRfIxSfCAglWWYDCFUU1u1d+gNTbh5OXkS9oqaJxv?=
 =?us-ascii?Q?pL9Fglu+3RrqL4Sx12Cegs3403trf3FD5/2bwvcV+Ms+7C+H406LjxdeDKYO?=
 =?us-ascii?Q?yWCIm6BBPq3D3hgrkw1McDu9lJIo71Mj8SSv/lzez26kgbOWPGUehEukubwe?=
 =?us-ascii?Q?TtPuB/75q093W5WYk77bkDxa8O414AgWAlkEet9rH2cpqqn/L5FCWXYF41tx?=
 =?us-ascii?Q?Ta7Lwpbo+srNf3JSizWuL1sx2ZbyOaJXzPoMx7OkaJsy04/kwKMxsK9xDxSj?=
 =?us-ascii?Q?XtjH8F/chPCBJ2Ck0LgRGiAo2wJD0WzHy3uZ9ccIlY7HoMHsmliuBdf2fzb1?=
 =?us-ascii?Q?CWEiH74rN4ZZfjG9nrP7MItzyzxgznmNU5uKGR8rf5Tu3muCZJv5krpZ37n/?=
 =?us-ascii?Q?zTYG+5TDRd4Qn9UP89BEQaeZ3j0fB1xJaQezxa/jocAt9KnELIVPOxs0v9Jq?=
 =?us-ascii?Q?1gr/gTrq8c6nCDL8fy37G8SMTrECo9U5dm2LMH6ZVVstHoGiBcF+ZxgC7iUl?=
 =?us-ascii?Q?aEyUHTXDeyfiQRJ8LEYuFmvcZtyMc0Z/SxI8RTdBN5YL3lpkaPDtUdewNXrA?=
 =?us-ascii?Q?tfBmCu1K7rF39MJUNh1Htgw+P+eU5LlR/Gg7wkfNH6jqK/e9TnX1SQI2crGq?=
 =?us-ascii?Q?ptrbtlgp7U6vmeGKD7iCctSsUFJk8bmlawAPcUYj1vGb9iBHEGwvyX6Jk/1N?=
 =?us-ascii?Q?78H7OTcBH1NKRIxgj1ih+AR05qil1kRMDxQYLUrQUwJSLCn587YWV3zCGD2W?=
 =?us-ascii?Q?GNtSLdW4QbN4bebMbUfHKu4qE5wTXxFZrFrIwp6Em+vlrlhJW+J/gWu0YUTn?=
 =?us-ascii?Q?c7IrDcheRLQBUwBxWIoH4vmKiZyp0hAm7kpvaoj+0x2++HjzPlPaKyNUQgiA?=
 =?us-ascii?Q?tNG3Jg1H96ScHuoZMZNzmCYxnjOMopqr/xjZTsi1cxh+dkNRblc2Ra03GTS9?=
 =?us-ascii?Q?EKQ4ifkgU4/ph590b3oml16Nuc6aumjIwXUTIw3lInE4IBGWU+dg9VvQ2rj4?=
 =?us-ascii?Q?Wcj7iLDC36E2s5Kd9jpMvs4eYLpKL5wMngeLP7vOnjgyDQVsMd8rNKINQjUk?=
 =?us-ascii?Q?odKO4AEJAFN1a6nlk1TxKqo4JquIEqmz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 11:11:06.4295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c94ee5-f885-428e-695a-08dcbc51cb22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384

This patchset performs some cleanups and adds new tests in preparation
for upcoming FIB rule DSCP selector.

Ido Schimmel (5):
  selftests: fib_rule_tests: Remove unused functions
  selftests: fib_rule_tests: Clarify test results
  selftests: fib_rule_tests: Add negative match tests
  selftests: fib_rule_tests: Add negative connect tests
  selftests: fib_rule_tests: Test TOS matching with input routes

 tools/testing/selftests/net/fib_rule_tests.sh | 181 +++++++++++++-----
 1 file changed, 135 insertions(+), 46 deletions(-)

-- 
2.46.0


