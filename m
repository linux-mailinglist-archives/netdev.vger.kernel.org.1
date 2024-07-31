Return-Path: <netdev+bounces-114530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7174D942D4C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F001F226C1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985861AAE23;
	Wed, 31 Jul 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WHgD+NLL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AAA1A71ED
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425628; cv=fail; b=qRsVtDJvxJu7wmHzz0u26MFMXtCBikSyi1NKq6aevVBbOwZe4T1TfoU5F4LmjjLTAFt9/18xjKtj8zn2RHNRdg5zkcY/hQ3kV93CNQxNFpG8wmgzLLOSizxQ/L/XY+Y2eogCkP2eEkR3+owTKTDRUQ+bkwtQYpxjapZ4jyFu0B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425628; c=relaxed/simple;
	bh=6dRTrx2tfvYkm5w2ZYbPqmLeipjvdLN5U/uNohRlg5c=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GH7TUJ7HENIKU2A1qv3i5uOBN7oojUYT3rSNiJ44/Y3qVp1x1NTb7uTS7mgOezKQZ19F6qxcCfYo63FI2Cf0dpqH5tDgBUVTMlTM9UfRdIuhR7eBWhcOWGdKGWg3kHxuYCfyOrQx1e6P5zDXINEAtT4jDXu6g7py7HVLnXPHRL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WHgD+NLL; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dth4+yitk55AmR7Jhg8eHPjquIe0MoaLOyWby1BrU2MYiP3Nu593gqj29L2dkRkTXqqQ7Q5yLk0w4qfNP9lkp/1P2W1Yz8YKvoCfAflAv7cOX/P0mnF+sXOggfLK20fHrdWmK8rXobeYXPoDHx3FaWjL82MM7Xor+C0WkFgGSDqWSQcT6gniMWUJhgkZRlPUyLN+K56hXnibYqerrGb7oLH67F/Ky5jof2RZfK0/Zt+21Sz7hN8GMcoCAmeix26TKPPtEUgkt/35kCfkvzVVapooBasxPN5me1Qi4+dsJ1MbW4/BSamP0ugug4eTAFOj+s49sAsvQ0TX0I7JtHSnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47+rdd+kKEaNPTN7N5qHeHC5qyemTrvcNp5DRpzlkvQ=;
 b=XU97CZwN4fCLMPO16Khh+sUsX1uEsFjy0TRy2KbG9o/ocgKKbEt0tvmFPcclkijy2+prFS1wYNijnCk1Am/fi9qphvrjaFvuVI2E3J3W3uEVqZEosXB8gltGFr5hFF0xTRr9zIgCTMqTUAjtEqcR1mDgAeoV5FuzFvF+whOd5Jwkn1gZQmvwwAHccN+L7mzqN78YTEkkiO/9+0bNLZnyAgi5vcAD4NEj+PPTFbNZPaIMd4Kj/lEreV6YBEXdSG+cbQbHbOnNVGc6YnGwQI/bOLu3MTAQOtopb387BdUPh8wIvOaFmKYero2MXtpXL/UgoiYQzQBeJaKy5cqrlwbD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47+rdd+kKEaNPTN7N5qHeHC5qyemTrvcNp5DRpzlkvQ=;
 b=WHgD+NLLlvnAfySGQmuSwM5xOGdMIo0OZ1nAvFGlsIdG6zw35PZPWXpaJh7eg0k5HWeT10CoRx/QXWNXoPyZUZFLaAiBNA/Xvp9UXobwaZK2bTtVCNsS/GJLOhBuWPw0WPykKErGSY1l7PqzBRURee5EJwOlc4oDP+n/MLDu1+gW3v+0b02ZeUXc81c2vExClhrZy0spZG6vTQCB0iOtH0ARDoVxIlbgapv+2uDMke8I+jK6cWFFJUbbEO/8mHfT/590Eu17GL2AsmYpjZpEyI2CaL6WU76fgAzlMXu/o62VoBrLlY+oOsJ3oOzhO6eUFbUn5zQLO1KSSJoFFNyQNw==
Received: from MW4PR03CA0295.namprd03.prod.outlook.com (2603:10b6:303:b5::30)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 11:33:43 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::4e) by MW4PR03CA0295.outlook.office365.com
 (2603:10b6:303:b5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Wed, 31 Jul 2024 11:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.0 via Frontend Transport; Wed, 31 Jul 2024 11:33:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 04:33:34 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 04:33:29 -0700
References: <20240731013344.4102038-1-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <sdf@fomichev.me>, <shuah@kernel.org>,
	<petrm@nvidia.com>
Subject: Re: [PATCH net-next v2] selftests: net: ksft: print more of the
 stack for checks
Date: Wed, 31 Jul 2024 13:07:26 +0200
In-Reply-To: <20240731013344.4102038-1-kuba@kernel.org>
Message-ID: <87h6c57q4b.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 5908fabb-6d7f-4e95-c600-08dcb154a1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h/cHERFtHWVZrFOISZyEVgIBAQeJPLgdOmeTgbLH84ldVfWhdFXjY/fwdUgw?=
 =?us-ascii?Q?RjA3tWd4sqpWMmmb0WXb6u/DUvKoGKrbuvOsnwO5hIcedbRC0IsKqagnm2bE?=
 =?us-ascii?Q?cJWpjrXumDoQzOPRXlKou6Mb1iq59dPNsG4CmrjzJUyPbuNqGnY/IOQ6coRc?=
 =?us-ascii?Q?H/H+Mm3sPXJfQ77+Rsn2qtD1zG8fE6GGUTbDGSK6HvW/8YDrIif1LgIkVhsU?=
 =?us-ascii?Q?2tbwhpBfs3mM9WPRfsIp0GVEDu+PHzfRcPqpdwzUqHrX3KlDQRzFkTD/kX8w?=
 =?us-ascii?Q?OwUbmAJxLUS9aO9VMjzQoOOqCF43zbsXYAL4oCckc0lcIJN+1/xvPS76tEtx?=
 =?us-ascii?Q?MfsL6UKvATRJ2IrS8hIu/9lse3IthSasUGe+9orZVaxpaPszyGoO87E9Fgh1?=
 =?us-ascii?Q?RoJoYtlCgYYRgywSPF/QKv2CrONulFLxUMl2LZvaOHBkyu6KMww0qloXnV0k?=
 =?us-ascii?Q?AnUbRr8FRM04Gz3yZyJYTBdMeRaTwYFF3xYzw3cIOSdZcKpF4akq0mFo7al1?=
 =?us-ascii?Q?BpUPeBX+2y+8gqDfDS4bvkqz+HTux+AqS4OT2oIHZKaEuWa9i43Sm3Lq09dC?=
 =?us-ascii?Q?gq3SWI+P2H6AUydAcNmsqf3MFtN5v7a+Pps9IU/rWorIa2rFHdxAdQnCCklh?=
 =?us-ascii?Q?Gi69j9p0DzquGfNZrUhwJj/kSwKZR/ja2fFmLsi3xmyD5zM/x+HKyZtWzZ4N?=
 =?us-ascii?Q?qR4gS+43AUYhiIHnX2RQlV/7/wPPS4CLzxhzyL9qbP1qMLk19Q992oJwSbZN?=
 =?us-ascii?Q?3OA/2REF2lACXzssmBAvgcyMf8WjdOe4oJ6pgzcqI+DaXhHH/0bkNFkVhfGT?=
 =?us-ascii?Q?PDgyDjNlTnmUZsD2hJf8evL46XQ8t+1NsGwSeVsR6sTz9Jweqr7bWhZdUKkL?=
 =?us-ascii?Q?N9vBDH5QAu8rXx2OykQAl7LHureSYh59xhXuL0W6XMg3pQwqcgU/iPkYXoIk?=
 =?us-ascii?Q?0xHqCDi2J0T0rW6dm6qtke9zdBifjYI9hanRwZgP2+8SvEi5lKP+cu0Huld0?=
 =?us-ascii?Q?3KWt3L2Y7QxB79i6ZbCUkeZLMW4Kg8+BDruAC+33X5ti4Lnn0r/yljXX2Bxg?=
 =?us-ascii?Q?P4oUp1L84IoPCZXetl+8+9XV4KRQvC9zl+DZqMB5HEMJHbAVJwHwOHBJXK74?=
 =?us-ascii?Q?Jg54ishw9V0WeuGrQv/pwMfzcgyzI7l8yNFICXElxyM8kFOBnbiBxnJSf+W8?=
 =?us-ascii?Q?l/mCxkRCmByXs1ADInGblvxADZ4rQ3gft8mFNQKOMXKNvKyqAgykvZT5oJae?=
 =?us-ascii?Q?pdxY/e8EXWs8FxisxDos7upwLcFmvPOGfykJ0jNaRK/pk2gwmvMofkaYnrQh?=
 =?us-ascii?Q?+fTjdqMymU0vuXe+g8P2je981/MhmXgQlFfKAs7UodeZ02m3z+X0kFaR575w?=
 =?us-ascii?Q?K4/IxIMFCaxwFFuriBq+FTHBiWuLlfpOs6Dd3AdwhIr8bx6bwmtziKmi5e+K?=
 =?us-ascii?Q?stjDdmMp/CnyDWaJd5ckFxDTadIsRGTg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 11:33:43.1897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5908fabb-6d7f-4e95-c600-08dcb154a1fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238


Jakub Kicinski <kuba@kernel.org> writes:

> Print more stack frames and the failing line when check fails.
> This helps when tests use helpers to do the checks.
>
> Before:
>
>   # At ./ksft/drivers/net/hw/rss_ctx.py line 92:
>   # Check failed 1037698 >= 396893.0 traffic on other queues:[344612, 462380, 233020, 449174, 342298]
>   not ok 8 rss_ctx.test_rss_context_queue_reconfigure
>
> After:
>
>   # Check| At ./ksft/drivers/net/hw/rss_ctx.py, line 387, in test_rss_context_queue_reconfigure:
>   # Check|     test_rss_queue_reconfigure(cfg, main_ctx=False)
>   # Check| At ./ksft/drivers/net/hw/rss_ctx.py, line 230, in test_rss_queue_reconfigure:
>   # Check|     _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
>   # Check| At ./ksft/drivers/net/hw/rss_ctx.py, line 92, in _send_traffic_check:
>   # Check|     ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
>   # Check failed 1045235 >= 405823.5 traffic on other queues (context 1)':[460068, 351995, 565970, 351579, 127270]
>   not ok 8 rss_ctx.test_rss_context_queue_reconfigure
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index f26c20df9db4..707e0dfc7b9d 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -32,8 +32,15 @@ KSFT_RESULT_ALL = True
>      global KSFT_RESULT
>      KSFT_RESULT = False
>  
> -    frame = inspect.stack()[2]
> -    ksft_pr("At " + frame.filename + " line " + str(frame.lineno) + ":")
> +    stack = inspect.stack()
> +    started = False
> +    for frame in reversed(stack[2:]):
> +        if not started:
> +            started |= frame.function == 'ksft_run'

Hmm, using bitwise operations on booleans is somewhat unusual in Python
I think, especially if here the short-circuiting of "or" wouldn't be a
problem. But it doesn't degrade to integers so I guess it's well-defined.

> +            continue
> +        ksft_pr("Check| At " + frame.filename + ", line " + str(frame.lineno) +
> +                ", in " + frame.function + ":")
> +        ksft_pr("Check|     " + frame.code_context[0].strip())
>      ksft_pr(*args)


