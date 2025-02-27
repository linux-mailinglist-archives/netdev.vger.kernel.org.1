Return-Path: <netdev+bounces-170189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E5CA47AAD
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A439F18905CB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACD3227E80;
	Thu, 27 Feb 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b8VgYZg1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC4226D1B
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653192; cv=fail; b=AMbT5zBzUJhzA0iNAHwMbG+ODzCMR4VmvXqKWZxTP+Yw6Oim2KPnla/gNceCWQ2QH0P0JvV/6vNnwmjsuD3EMrZJwQXL5+l6H0gn2jvGSQqBteXa2fIEiHJB1NRbjNsEFhUZPFh1fOt1iq9QFMNxp4QeYQeH75mHHvj/zgY7c5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653192; c=relaxed/simple;
	bh=uaEstFw1DLkTbvdNJxGuHiunAP4pBJpE+e+WqGczeyI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ELrZD65GI6LR4ARCigAGDaiCSyK+ZM/q5RFH7RRtuUXgTZOwsdcbc2gJ5ckIWaU49PoWdU/sx9/8PWFnFA4kcOHBs/Xs4Ak5ZouptjMSQbIkQBI3ELH/MN65QMWaeQXRm3ZQn1G1Vhp24AZE4QCWrudYhf6T5p51B188wCZQhOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b8VgYZg1; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLJIIurxg+JTxcTywhv5jzb7oESK9EF36jvXX+90w+93iXjH3AdvMbZEe/CKYYC6ySzZdf0XSpxe0qiCp5TCu/vzixTRYsvofB/PiSJ97JgZLnd77tSY/gf3mnPGJFWiClsFXJDFwHDeH8nqOW/EaDE9Exem1ZfrbgTiyaUn0xjwZ9iuOn6ftZLLGd4aVaPQ0Dcmb6C+vf6RxANe+Jo/BOp1HbAsomhnb8MjbzVcHK3iEFwfyE6LjGFlR1yuFEjQNh/MTftsvSczIT4TjulQY/6ZD0KPqb63Crdnte4+fYGcixUOYgDToLQNoJzYsDG3zZnU+S7VO/B+JsH1MsughQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAoluz8dhxJtwkqG5RsXG02ZMDshRZFMm+Ux32q9x+I=;
 b=u1CVshUW5mOhMprhy6EuT+9pYLoCHRnX3SA0QixTist2+7RJnW1IJpGwG1h+Sh6MwQDU/mqNgU1PL8o1UbUqjsHFePctN+rLqTH0QRrPTL52OsY9A/CEwiDgkbnHVxTfrp6kdPO6sBPCz3T0e02SdV6vZro8CsmyIpZ8o3+8Zgbz6mF1CYIlR3B5swDKCcG2+Ol4vZjlAi6qj8hqZFvN8d2SKbz9Udu6kGMK2BSegpg6EOUEIIgt/tfDcHx85KeQ9Pj+lVf2/obCYiOhcoIknHjXqLrMVUyDII1MnTngwW2Y2WSHuYvfNiNgUG3gGhgtX5gROBRTIy1juQc2/gLdGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAoluz8dhxJtwkqG5RsXG02ZMDshRZFMm+Ux32q9x+I=;
 b=b8VgYZg1nkN5r4KQWArs30XCC3CpHqmyZxyZav7sOXfXiWsBF0MuLOTQP6h4Gs/LpzoFIaqo/EDnU3pBKh3n6Zo2pVfWFUCksWR7gLGnJKUzON6jvQni0/CyWRF4MpJekuLXjEX+Z23uPoPiSRB+kthliAbEe6EXtLZKm1/U3XVe1I5QHrgC700+eIadeovxZ1O87yS315OXZOdo7+a3lFc+En81HdqPtOLvctHmvpDG77Lqt9vumx/F20HdKLuAY9WTlkCozDbM3IH1OzatFxw1NP0D+1SWEPsdByszlYgkdyy09vcvBMo4EowCnRF1vj8btdc5srDijx3bJ1BnDw==
Received: from DM6PR10CA0036.namprd10.prod.outlook.com (2603:10b6:5:60::49) by
 DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.24; Thu, 27 Feb 2025 10:46:23 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::cc) by DM6PR10CA0036.outlook.office365.com
 (2603:10b6:5:60::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Thu,
 27 Feb 2025 10:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 10:46:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 02:46:10 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 02:46:05 -0800
References: <23340252eb7bbc1547f5e873be7804adbd7ad092.1739983848.git.pablmart@redhat.com>
 <87zfiagojj.fsf@nvidia.com>
 <3e35d85e-c136-f87e-a215-f2e9ccd43490@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Pablo Martin Medrano <pablmart@redhat.com>
CC: <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v2] selftests/net: big_tcp: return xfail on slow
 machines
Date: Thu, 27 Feb 2025 11:42:32 +0100
In-Reply-To: <3e35d85e-c136-f87e-a215-f2e9ccd43490@redhat.com>
Message-ID: <87ikovhdhy.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: e6644fa7-336f-4f95-3c70-08dd571bfa24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X17A4O40RUu67jlbHeTVJIT/j9kl5weGCUxSuhKpQ1F5b0S26eRhNFKmUppt?=
 =?us-ascii?Q?JX1AOMKv9kD7KB0YaCseZ8Xsji59ul9JJLaiy11kxtY4bgn4UvhD2ro9bjWA?=
 =?us-ascii?Q?f6asGRoksoiJkPuQyJ5b+6tQC+bqlwT0HZjLSMZ3UuZIUFQ5DneLbJcdvHTX?=
 =?us-ascii?Q?qjpysXGFn70sillxppeWzZyNhw/v6Ufk3ifd6+CD2r/cOU1HlAhd/1pKTB4F?=
 =?us-ascii?Q?I5UB7ETliO8Yn0zZkNbAvMcNcuN0tf2rIQ+dd8rGtkAxwwhMccWaKdSXkOeI?=
 =?us-ascii?Q?4UGZU1BSIRtry6OLaoDiCMDUtvWS+QyS3nKa+UzLIiouyZANnALk1iOLxd1s?=
 =?us-ascii?Q?HgVAVxIuofNkhR43V/+gfePiHm1zExwhHoXDFn06Wo8Pz9ssQ87I8z8qneia?=
 =?us-ascii?Q?Q6oItagl6ealWdoa537JpwC81z1QRTxQxZjxyEvLb5OJNBjjKvCCYySNAWoJ?=
 =?us-ascii?Q?SQS3Q+z1BrNfajBxPKzckixHWbjBU6Epx5qnjK7qoVVtA1Pz/Hy7lbXpUuTz?=
 =?us-ascii?Q?IetXE9jvnxXK7+AO97m27Q/jbz7/ap6e1PRnW1VH2wuRVDgenqmn2muX5HKT?=
 =?us-ascii?Q?pwcPm7XTu3QPS6+IQjoHVjPRkfVHFihcWWuwijiQMxmyUBID2h1MEkvEI4pX?=
 =?us-ascii?Q?tY0WYwYJbdaCKZY2BEnzFxTaVoBA8xkWizRkLzs8PQZ/ds8AT5pTOoYQbPjS?=
 =?us-ascii?Q?cR10LlFB6eeASa2+MU7d8Vl7GAC65jDWLYZhGvWeqGfjbdSFYpwCvyeTZJwz?=
 =?us-ascii?Q?oMkMISdmEkDy65gUfUzhXqV20X+sJwrBIopoA25LBhGNfacDxZtVhuwSLEGn?=
 =?us-ascii?Q?x2gxHsaLh3nqQyGo9bHxN+sQdDO8wb69CGDAch4lMFSsRS9C2BYZ66KO8mFG?=
 =?us-ascii?Q?4/9eLo6QIseIS3b8KsrQivy8Ck1nytS0COmiQMfZ4ZR1lS9/+jhEo9PO/LBr?=
 =?us-ascii?Q?alTdzX1Di9Tg1u970x5yDVxn1AdtIuxDyLRrr5enTDb0zxYZv/tFI89hyGKq?=
 =?us-ascii?Q?78yiD0xRn/BMZRsmrxrm2wTZE6uQbjoBJCG6ksKmPmVmDkuw0qnPzxy25X6h?=
 =?us-ascii?Q?a0qrRq2B0rZ09SpyEHGwA6OEawgsUYJmGp3ShzmYhQ0zMs6TXdbRkwnbTY0m?=
 =?us-ascii?Q?lyBpHJjSDQdjMvquzmqjM6HPCIwEg+KDIX/I+y3fSY9qjsEZOmGm0HRWf0dn?=
 =?us-ascii?Q?XqR6tamljiPQv0+OD5aT93TVkAbQ8Y1cYKo8YwPJVFEwKNAXp8pab1O4Dv6k?=
 =?us-ascii?Q?iSoNNSrXUApkRBGx3rF88k4O02/GyMQtHr9HQL4RkF/YwSNZ0502OHogoyuA?=
 =?us-ascii?Q?CoLmHo7BExA1b1BzD1ESoNJnTFJ59YQzpIqbecNBp58d+SLR8iWBLJ2mUAZw?=
 =?us-ascii?Q?hAyp0OheqxUfj9KoBACczKskAbeONlEMCHvPZFIIN91nyG6jnvWewLJV1TO3?=
 =?us-ascii?Q?zNraYijte5a4YAS12NGohzJdJphOZIDs2ZHSy0281/88zLcSjf1ACh7FegIF?=
 =?us-ascii?Q?7PS16BJNXykn+v0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 10:46:22.7328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6644fa7-336f-4f95-3c70-08dd571bfa24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637


Pablo Martin Medrano <pablmart@redhat.com> writes:

> On Tue, 25 Feb 2025, Petr Machata wrote:
>
>> Due to all the &&'s peppered down there, do_test() only gets called at
>> most once, so it's OK in this case.
>
> Actually do_test() do always returns 0, so it gets called all times in the

You are right, I missed that you kept the ret == PASS test at the end of
the function. So just drop that? It's not adding anything, it could be
replaced with a : or true if you truly want to return 0. Then local
ret="PASS" can go away as well.

> code. check_err is setting RET and keeping it at the failing return
> value, so check_err is always returning error after the first error
>
> If I force the error by injecting in do_test():
>
>   if [ $gw_tso = off -a $cli_tso = on ]; then
>     check_err 1 "forced to fail when GW_GSO is off and CLI GSO is on"
>   else
>     check_err $ret_check_counter "fail on link1"
>   fi
>
> The output is:
>
>   Testing for BIG TCP:
>         CLI GSO | GW GRO | GW GSO | SER GRO
>   TEST: on        on       on       on                         [ OK ]
>   TEST: on        off      on       off                        [ OK ]
>   TEST: off       on       on       on                         [ OK ]
>   TEST: on        on       off      on                         [FAIL]
>           forced to fail when GW_GSO is off and CLI GSO is on
>   TEST: off       on       off      on                         [FAIL]
>           forced to fail when GW_GSO is off and CLI GSO is on
>   ***v4 Tests Done***
>
> So setting RET at the end of do_test is needed indeed.

The convention is to do it at the start of the test, before the first
check_err etc.

