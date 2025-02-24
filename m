Return-Path: <netdev+bounces-169071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA69A427A8
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5D7188AB3C
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0102B262D1A;
	Mon, 24 Feb 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SDPCvJf1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5223025A658
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413878; cv=fail; b=P9VKS87GCBrBfqwiBQLqCuhsVm2XBmV4zvWNeehJmJ9Z6cGZ75nGyIiuR6niAiwQ8D52tIInsn1q3GYkH9fG7CFomhigF+RG5rPFvgr0h7jHWdijntKN1pzV/3nxJ/WGKVhnhoy+3HQBSXDqCPNdqnsfZGHT/qx0XaslJfIKWcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413878; c=relaxed/simple;
	bh=1nSPaHgOIb+QuGEDR58P89llwf3QFn8hMqogZLe6LvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o+objT0QEeJcN+guIVK0M6EhS17Gf7hRMn5jL5Gk0ILPVFBBNn1Ed4THbFn2ZzuECsTd2gN2u1HCucRhTf+wOBF5r4LP2Fzx81FmTxapOmOz6KCA7W++YdemkTBSS5hP7Ih2oxr8+SF8qKDAjYUpDBmM5i6t1FydaCoyY64vW4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SDPCvJf1; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGPrITIZPZqQBm7L6yhEx7U4DseFj5Xl6sRUlRhFAmb4Je03BQ2zjtp5rv5idzbGvOJ9dDW9/B1DZn+9VJEz9Pja9M4bMvg/84WDs9OufbkiNh8GRxTQAEywGuB7gmBLM+fy22DmQo0KMgw0Tc5xQWo/Q6Yf5By2lUPNLXyyVPfPdijv+Wc0izsgckw7kyzeYiE1NQvnExfLyQdobrdMYrF6I6ED+7kKb1hPzIa8oslFJUZ1wVApYX5g+qpU2yxvRFu1VVFDHfDa6Wjsjp08sYu9vBTGdhcFQR3AtBVQ0bBc7VF3thnI2SmH1TNyr+orjHzxN7N6szb78r0acyU2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nSPaHgOIb+QuGEDR58P89llwf3QFn8hMqogZLe6LvE=;
 b=PXQper5Ub0UWEUAt0VQVjE+JjqCKTYGXtlWB35h1b8+Jil6ih18PKTGGUngB90Zw/uWk2Tktil2Rk1OUKY2v1pM7VA1hTAADb7U3ld0MiHJP12D9pZPNYV5Tcyp/ipz/G/5yqC8F0xt4UN6MyzhkIye4x/jXpg3raKtuhE99cmGcyWNI+vMsx1trrQYPB6uqAJkSpO9p/Mmj9vGfyZl+X6rYymsIf3kR10x/3XXkQOqsk/tDCkaBFJO5akHslQltGZRaVSPScs7PL7raThZc/V7WFMpufYrW5Qx+cv7VQ4znrKZAYr4XZbFwHq7poOvkiyQ+ty2gUR+KSnkJKOUueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nSPaHgOIb+QuGEDR58P89llwf3QFn8hMqogZLe6LvE=;
 b=SDPCvJf14DQ8RpUxmYfVhaQGtkuG17yue14aKkI/N8+4UdbgK9Bizfdik0yEqfnFsS7zfKKCpGBzuy5WF1nY2v1qVR0nFw+LV/HWQeGNHnsYV1ZIbDstLVJG9p2nbNtMcnDAD1RIQnLBTb4i9sYGF/D5YTMF+atSyYfhONYWRMmy47pW2jKiw7Ukqe63o5Ar1kUWcPb4t77uj6yZL89DNbQR44HthtKMXw+AeL95f+B1Bl3y2U0kdFfsmBz2g+OGEm1TGv9QxqC7ASR7UPp9Le1JwnBb+mPX1gTi1T7klU5xj/MWIlEF+rsl9lTQ/qkDcH85dfcOD2YStv16tBFj9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 16:17:54 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 16:17:54 +0000
Date: Mon, 24 Feb 2025 18:17:44 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
	gnault@redhat.com
Subject: Re: [PATCH iproute2-next 4/5] iprule: Add port mask support
Message-ID: <Z7ybqI5CDFfe8ft2@shredder>
References: <20250224065241.236141-1-idosch@nvidia.com>
 <20250224065241.236141-5-idosch@nvidia.com>
 <87o6yrju35.fsf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6yrju35.fsf@nvidia.com>
X-ClientProxiedBy: LO4P123CA0377.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::22) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb5efe8-4f8d-4629-20d0-08dd54eecb01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OKtviXSWXj/x2eUvKgFICj0TsAFYYiOkB6oRhON80n0VGgcN/7ttuy9Y80si?=
 =?us-ascii?Q?vU6pBHfnKNZfYYYu4kZzfkzqI7e9mnlCgOg2Stp40ISj2vr7Z34Tb0XlgoGG?=
 =?us-ascii?Q?PJHrpNCo2jNS9DyiN2rVVeX3bbIEulU02PECzpaWxFuQImHKLgh5zoMgRvGx?=
 =?us-ascii?Q?506TrVQKqdwTkY5BCeb0TYpea2EUk3SRr/PPORIHBlg/mb5xAM/SU1g5Esqg?=
 =?us-ascii?Q?NR1jBPjlqO4H39vwp6HpEXnfWAYgEwNllx4z3WmPRD/xMMbr1fLOdA66cqO2?=
 =?us-ascii?Q?fnXtBEtw35PIgcopT7O7LOFjZcUr0KZlDGEWVaygZ45InfwEzvQJzc4UibAU?=
 =?us-ascii?Q?NaA2C7Fvv7QPeQQ+MVYexAJOmyYeNhtvrh8HQdvn3AAA0xO8R2DQGmtOcxkv?=
 =?us-ascii?Q?XN4IYLHC9+JrKYgdlytnQlBVSoRx6Ootdrxp/NntUKZs1YFd3x18CRz2hNfO?=
 =?us-ascii?Q?rI+5yOi1x2k8vvp0OP8CsdcvgPDe1/0W9RQ8SH2yFft4iulAwAxuteT6USg5?=
 =?us-ascii?Q?hOpNlx1If4kCWjoWYv7Q1bQRXiYPU+wSqSBl5Jth6XI+59sihsXxdJfBlx/N?=
 =?us-ascii?Q?BFrgzi7oum3cyZ7zyKuJKj81UrfQFyy5xra3yNcTfS3BPkTllgsb1QoD2hOr?=
 =?us-ascii?Q?qrUpRWL5ajVnKqdRDGJeANeb3sLOBH8K/tal7kJRob1XF2b63p2+ftqaW1DD?=
 =?us-ascii?Q?nOrGbamV0qcbd8JOiDNeZ+0HrwXdsd3G6LVGweUN0VKSPQR1SChzReasQ89F?=
 =?us-ascii?Q?ufNaVH9PtWXXYMMQ7Bh0MlKzMyySTgowpJraXAC8Xvtf6EraTI+X7G6dOnpr?=
 =?us-ascii?Q?z/55Hc5trijandZnWcPV0SWNu2d5S8AMHNryffYonercb4ka0ASVsbfRGq3t?=
 =?us-ascii?Q?phvLw6tW0C8KU9E2jz2VJ9sOGmi0mJjONCv7BWAC3Ff/lMprUzW3qW27gxzl?=
 =?us-ascii?Q?NzvKJHQndklca+tMWnJ5j4r1djSav0rv7Nyq2SyTP4kpL9VjrXYY+SF8uc9D?=
 =?us-ascii?Q?3O40BaGRk/dkcFn2lxYlkn1BvQBbfDVaqwcQjQbaTafAfTK0/1k3vbQf4jNc?=
 =?us-ascii?Q?XYEr+beIl1Rp4aGXF6E8eqkNhFFV3hEU2Ga6ljZlgvFkM92QFRC5ywqJGV3y?=
 =?us-ascii?Q?qA5Pr0iMVXd/GMadEDUtaMeKvvK+7xS0EkTtYY4vjyqFTpTzoLmmZZAgW1QY?=
 =?us-ascii?Q?EEt3O7U6RuiFctB3IP4iTggjG3WRvRfwC59PnSvEv7q6RpCOdLK6lfQ/qT8b?=
 =?us-ascii?Q?8LDo7HOlyRfRkDUf0/8A29Kj2VIWFW9+NSFjqJqxV49govWqa7ZfQ5tSOL5+?=
 =?us-ascii?Q?gVW4WDvpIC7JAFjO2u3VjS8306VluLPSAMxH/VfAYil7kYezBmAJ1Mp17ahf?=
 =?us-ascii?Q?0PNQTlaR+DOaaS1Betasri25hi9O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ThXijImG2L61AzL0wZcoyn7RHkEmFMZMnAJtDQmHQoM6QeWklbbR47ThxR7m?=
 =?us-ascii?Q?lAdU4+rFg8qdzzIc5mO5zlLYV9aoDNYSCRk/Oa1aqGTTzsMEenYS2Q/Twuec?=
 =?us-ascii?Q?nxGKLiqVwdEosD5ld4iKuHQJ0+hM7ZCAXbEGq0dd4k2Zj2tokDoWPVx3z+YA?=
 =?us-ascii?Q?egUZ2bo11N3JXTPh1NZ0XiOOVNh0EjYaZTjjwBAkOgsxuhX4i27xnZ1ACjJC?=
 =?us-ascii?Q?ilOY5mMEspNoEIjOzxJztF11SB7NyAH3KoWaNB0RXpc+LEM+ZMVYQ7inSjdI?=
 =?us-ascii?Q?EMhF8mvi+zL1b8PNiI4d8esuN/qix5BVIju7Ns/HLxLjERDyi+qWsOsdYVs/?=
 =?us-ascii?Q?fz+SUiQX8hQYUgKbzh1Lg+eDVTLFidod1qfq3XBuwk80PtSBdgyAn4kvLf72?=
 =?us-ascii?Q?okcd2QsJ6IikrPfEBlhYilLEKlYl7A29ChloTkOaHiICualJ4sPOryxGQUQH?=
 =?us-ascii?Q?YpCEdi9wM4R8pH7Y9vHFmdmoFSr59fr080wWiJVgtGSkxgsN74hvx/aXBTBW?=
 =?us-ascii?Q?WAya8rOEYCNqT/QRDXhNCG8V4y35Bs9DwsiHRZsyXS3KPcxHNqAmwErbjoOW?=
 =?us-ascii?Q?z45WB9TNuQahwAzYfEwet/sK8IzFnlwrhQUvPpQzrDEeNTuk5IGR7dvd7vqB?=
 =?us-ascii?Q?e8+hPVSHWIipNB8ReXKxJjD50bYSy1nFqaGmqa+2LaO97L3ep3uOrwgOqlMF?=
 =?us-ascii?Q?4Go2Ezk+r19pFM91VFqMByPRcfkVl6BsUGxrrNv+aaJlh8jGjlZnI7Y5v9Co?=
 =?us-ascii?Q?YIXunnxtxozvuSAotZ8i53SUH5wTZ+mB7/Du8Ip/81dqbef1JDP5OEIjv35B?=
 =?us-ascii?Q?V9cfq0fiBIMSw2Xdh3jXip2noUdwlFnHBtaCnE5lscMa3DCuV7eu+48VzqHc?=
 =?us-ascii?Q?WdDGjkoGaqvtLSQ8xGC30D8Q0zwjYNZ6tyyrqKyDfVR1sVFV6h3eTCqHm7ZZ?=
 =?us-ascii?Q?r/rw8cK1V0gudQgzymsdmidGYbPVZYL6z2DH3N3ItDvHr0yYDcX2ZztS09Sj?=
 =?us-ascii?Q?W+fDrbhLuCe8bIJB0oYN4LkAn/LveOqs4AAnj+/G7Z8Cg3//RXGITKrzXQqe?=
 =?us-ascii?Q?7ChH3KC4g5ccPxHelg30WslCAX/AQFv7FGtjMaHsuLP9Zo6qwjv2OdErNCnf?=
 =?us-ascii?Q?OpI1G6V6iYVa4HFyhLZdVooYbhsnhNNC7yrA3VOXfu9J+sRb8lmm60DHnK+p?=
 =?us-ascii?Q?5FCvXz3+d0EQgTpYqzkhB3J2HMj9yuxHvjiq/Qd4MuuOhfvKa8dnSLCDJwmh?=
 =?us-ascii?Q?mVXvKFfVi3xxlMGg/KyJpEZh/Mtxt2HmAnHADSFh7ntBBvhApdyVATif1Bx2?=
 =?us-ascii?Q?SpXZ35cofQrZw5+FmPioxoftTsEa15tufaP74UKiPwfaP2vyHoFBsAJqS8Q5?=
 =?us-ascii?Q?xBegeJtzPaZHxbprMkHa/meUxM8cfa/0AwWl5DWcZIomYxhAqTmAExILZWIT?=
 =?us-ascii?Q?kabQijrkcF8HDUpIYMxyni06RT+o2IF4p1ZWml/dphJ5xaaYrp+5qhITOQ8Q?=
 =?us-ascii?Q?35AWuT6gShXrXyFRVxqLp02yJQPaa/0rsXQ18QwNCDhJtgej6US0txXcvOAB?=
 =?us-ascii?Q?5zbQvbf+ilI7J6bmgljL2NplV7GCmcxICJ5GJeBm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb5efe8-4f8d-4629-20d0-08dd54eecb01
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:17:54.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgbdy0jp0P63ks5NQ+OPjrhguNruCFFzmC2ePhUU1TaEHutvcLn52lkswuuR+/fWqn5rVGEdM7hn5vQfnm8oJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471

On Mon, Feb 24, 2025 at 03:03:25PM +0100, Petr Machata wrote:
> Two minor suggestions and a couple notes to self below. Looks OK overall.

Fixed both. Will post v2 tomorrow. Thanks!

