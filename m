Return-Path: <netdev+bounces-169537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95707A447E7
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714AE17B8CE
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368391FAC52;
	Tue, 25 Feb 2025 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XYeN1Pop"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096E1A073F
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503769; cv=fail; b=LTB5gqx1GLZSo4agEKgg73SwVOgWNqSl476KNh+mRdSnVCRr3cVO+r+wWCjxJVU6Mbo5Knj6U4I/repJQdVwbPW8cI0sdMM1n1CDrP+vNYLvS6hVVpFdIHUVPfZlwfdaCH4eqRRM+BCEC2nZA0UPNIPNewoe6x2/WGNSSqCA+b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503769; c=relaxed/simple;
	bh=nuemk7EeOeML260u8A29vpkzXGcgIVp4dEN11cymZzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=KmA+ThTeN21CeTsiDlygzje/sBCf+GQMtHsApbFcpNTsgVta5onHatyCjW6oLj3DYG/EUG1yyMSOpnemsgpks3b0Gn/azOr+rCB/qPj04fsUYFccK/R5MN7iO19lz7rYhuUCYPijcnRDQ9pFGZYuU5e8j8q5IgeuCNDA8OxpvsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XYeN1Pop; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XE4jGgUSKNzsNhM1DFgT/LMVLWTkbjYLDOEMb7J9gxV+5JlGBukdCWF7/j9P7bZQasSdH9QcmDCLImqwBIBJ5n2PRShIKqBncZgecfGJ83gxf3qgPdleg5RGyBArmRvoh+8UA6tGl6JufIzhI1bUR/HfcTYJsR9yasy1PWozMV23bixGjtWA6PLQhTTt/HTXtN7KQnOipjAvmFNzKQNGVAhgS/2zU8vBfysgZTtwcpT/BRJP/HP8Cz0DPqHoqAkqFRNsSA6HezGsRLuwxPgYgkkSpAYjAlm1vgmehIMwzT67Gq1iJ9/1OphJ2flLrOq2lbY+zpYSiF8xkcTCZeB8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uAgRQHXELFfAcoEGsGtPAesMuChlY6SYbJDZjKoq8g=;
 b=H+npxeJZwm1GCyVEXEmnmiBX0l8AzT7mz4AvF/Caa2lduVjXjVh9t61aFvPRbmnsT8FHY0RWPB2F37nlNBMOAwtkCxxMPcgJZ7u0twa4FhXF1jVwUoKJBDfzNp9iMiW43n67bU5Oi225ggeGEjWh/KrK/24TY+4E+CI6RUwQtxf+Mbq5idzio3iMh7XLg8Hf60+D26y9U8HQOU/02/dOa+wiyzuum9wAPdzV2A27ipOpmdGFEdtvGDSZIKSv8t1USr89F1NHQQH5AHaxv7TXWG0pXMGpMqGS661+aJ0Pik9qVPJzmzGWusdtMCCCT06xJ1aGohZsZ43FJZOZ8heqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uAgRQHXELFfAcoEGsGtPAesMuChlY6SYbJDZjKoq8g=;
 b=XYeN1PopTZZgDSmeWD97PRNeJKE6xOYCge9HA/0B/5VYhFjASdooA/Ie/r9L+JPn+XaJsttHxAjOiDi6nVuam8795+UDSSmKFt4eoDpxzzqKxS0P//u9IyoWVRt2H7QjrpK8tFOxYGnL6Wi8tTNeNKTalEmn7xnOiV5Wr0lnzRWdaXpQAu1xa8QtQJJlEL8CSZ3Jev9fkUOuIlrc4lWdOysr0ePr8wwVZNCcIyxGql0t0jcyHs7oTFveyUionVjS1K4C44ER2D8GWu71MHYbry/74qttQaTPeUan7QMHKYQUOSQIuoyEFRO80WdjtmtLYAmYiVYmW2lGdqHeJcU7MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 17:16:01 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 17:16:01 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
 apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
 lukas.bulwahn@gmail.com
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
Subject: Re: [PATCH v26 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <253seo2ywq6.fsf@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
 <20250221095225.2159-2-aaptel@nvidia.com>
 <9d381da6-cef7-431e-be82-fd2888fc480a@redhat.com>
 <253seo2ywq6.fsf@nvidia.com>
Date: Tue, 25 Feb 2025 19:15:57 +0200
Message-ID: <253mseaymgi.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0434.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::7) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 369d7930-6292-4e31-2a99-08dd55c013fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jo9MQ9CYye97hDf/XKN35m/UfwYUP67pRGoVnJHI4CzPLLEglNbICNWp9uKB?=
 =?us-ascii?Q?vLMK4oD375L8fhjs+DeW365+uvp1err1nRYznt4Es9e1LdZ3v1UUESmeXTHY?=
 =?us-ascii?Q?Hmbu4Q7cDvbUW9zAReQk6uOhryS3/JKeRZYt1MMm37kSZR9vTPLgQiq81CVI?=
 =?us-ascii?Q?B8Avxh9VPXiCf4BBuWVH9CnO6Nw1XOeYI0ZjuCPPiRcjNzCz4NFc6LpR8w2D?=
 =?us-ascii?Q?c0SZqc8UcYruQnUvdDfQvsErp3Ezsgtz9ooStQnWbjYwUuSILb+BRKf2707g?=
 =?us-ascii?Q?oE1CctJM6BNpIlqQDae5xt7Eib1BqYLtSEGNHr5Fja+DyYKGZnMWHpv9Ayza?=
 =?us-ascii?Q?hUXiTL0zZMjIs0L5dXg8hI4K62T6NiC7DSW/pvRbwi5SKgWbLYptkEGYzzOm?=
 =?us-ascii?Q?NKtvYyPYplpu83wMbLVPg2GS2kD/uFG7Zy9mZhU5hTtXKKBpaPsLh49IO2rb?=
 =?us-ascii?Q?l3cIZhd9Fc0jRz3CQHPTUeTPDaR/MYuB+Y5K0Ik5G68whr1a4oly6/jFKakM?=
 =?us-ascii?Q?42YHHXvBCHwXBH04eETE83ndnMnhCQlE18OYVMprTr+r58IGGx1jk5hFXjLW?=
 =?us-ascii?Q?38whr23Oa11D8XiouJsOoOpBupxBMcRpjgZpJDy90pU6kftxUfQ5LOhSfBb8?=
 =?us-ascii?Q?SujHIlkqnE7mx8Cj0eIzDNhyldxG6+O/pzuhKPcKhXQQofY9Ec0s84PeqY86?=
 =?us-ascii?Q?N/EearQONyrcfY+cnF3ObsiZjVMTErCuctdFI41uP2YgEiYMIQBjfUZlA59O?=
 =?us-ascii?Q?KK57he0vXFo5LX5yFQElCYMZrk+j1xTQKLe+3rkVJS5Mkh+kZ/vuc2ci/D1c?=
 =?us-ascii?Q?yPCIP6I599ImnNkpdO0zZ+Jd96D3csmA1FAPS1pucQHPSjZs0N3TbHmR2g9Y?=
 =?us-ascii?Q?7qUoKJRn0I3/3oJ/USxHsC5mNPc2h3hAGyN79MhHrAQZxQ567T5+udSC//gt?=
 =?us-ascii?Q?Y6jTVy3F5HyAlCO45FL092fdjZUsn/Cdj/1gU4xR/Wdwmg95klQc9pSK2Ibk?=
 =?us-ascii?Q?tXmXqNfQNWYM7MW4eHq3BN1pX432uyX9nD2zLR4BeLJZ4DyDwTO2TPJp1wmo?=
 =?us-ascii?Q?30l41ZFEPBiUZNqAyqIfQZwGjHgWYwNJAJ1+k2i0AMBw+Bj+vOCxy7xGKPO3?=
 =?us-ascii?Q?KCAwjS546/g7QNz9B01t9/sjSFTkWxYyThoOwTjVUPrrl/SQiqGn03D9H0XL?=
 =?us-ascii?Q?Zx3QWJGwmsG7lmxj53U8k4rhePVl94ZZf332Ymnmdb9j6mSiGNrLait8INGm?=
 =?us-ascii?Q?cHSXp5HvBF9XBgsMyY0SWmeZ30fF3y1IsVHgy2J3FEJqw5xk9K6wrQxgwiVd?=
 =?us-ascii?Q?LnruaYKmDU5qHKSrXq44b4pJjusTamOYn8exCEXHB3XG3LqjzY/FDNvsKO3g?=
 =?us-ascii?Q?JP1LwlJU1inh5quWR3bVxSaX37EYHt/9qgkp5Pnnok8KZOHbKEIQz3ZChlpI?=
 =?us-ascii?Q?GzAyPhuZyZ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CzSsSRPHPhJjoBZz5htbuiDj8xiDuv1ro44wuZgUT/oZ7m80WVuowpzwcj3N?=
 =?us-ascii?Q?33UjtUKNlLTAkHuUjBj8AN814zjPYrW+X6BHl/jLsmn+LPACi3dz1l/tpM49?=
 =?us-ascii?Q?xXYiAhBbwgH6GlPL07fXFRoqhUAJm4o9C9SFFSHqGNxYltEJ/n4ZLDelc/h8?=
 =?us-ascii?Q?s1tgdaehcMDKjJ0UV0eT2yIMifwy5A9cgqpEYy/sY+7b+WPP4sG45opSZJrP?=
 =?us-ascii?Q?Wu3p87L5mJmrVI/icrD6RoVxoOHbhYJPLmIZuSD26WwVR65oGH+CKqUsFnEE?=
 =?us-ascii?Q?zOwIUKOpeHXM8jYO7tTlB3KhhVSeWRaZgvvKBak5ImTHIaC+xWPysByF+rXw?=
 =?us-ascii?Q?mv+I8bxVxxMG9NgXCdAssYpM9C5MmD0JlnunmpuGHsuTlVtTy9nVoA97Vq24?=
 =?us-ascii?Q?MLk35Si5dMyox/QPl4AJwuyPZjZ2HIwWeQkP0Y0IMsOV1ar8k87JUSkHlGfQ?=
 =?us-ascii?Q?QjFYZqy8SblgdwZvsJZdkoheuVM/kHQexvFD7LAl1nRRWd6CblX1rbb8iVxu?=
 =?us-ascii?Q?mXkLWgdpyQN3Dt88iiUPeA6Ebq+ecayW9FlQanHGL5l17qYSLzIdhXLURoln?=
 =?us-ascii?Q?GwQ74Kj1KiEPNG8cgEUaBgO1Otc8DmJaCRjE3gLoboxaRn9orrZq1WRa9pjw?=
 =?us-ascii?Q?hGv0C4HR3bVdWIsGvRJ9yETV1lsydobT9Sru0hh7FvUpr6nmRJp9rEfokUoT?=
 =?us-ascii?Q?Pac6EPNpvA7jMANIYBmTgBxktRrB7RA8WBFu0obZvE9EJon/0XXAPt+aKzak?=
 =?us-ascii?Q?HeRiIdH14HW51rym8elfQ91/orG+IAh3bDAY0YnEhgqcduNj8Ab5qww6cTwF?=
 =?us-ascii?Q?XO3XxSdX5rv/p02czdZmKO5peIkL8OM2Peyk5j+NVH3lvfkWaAJ7HZ/ZTgJw?=
 =?us-ascii?Q?ilBChyYrdcHbEx8E3I9QK3SdxGdqxqXN9SlOTcRumqUcnxDAcsSYXQhUyeh5?=
 =?us-ascii?Q?I8mK4dtzAwLeafadNG8pvJre7JtXaVZGU5ag9NYBarR+cSQxaPImZjtCiYC1?=
 =?us-ascii?Q?wnNgD4/q1/43fK6DM/QrVDOKqmwV6NlDpxVaK5UzWvLwPOlh6Hezv0T/vWr5?=
 =?us-ascii?Q?NAjM0qzx7oQpi0qaif3t8AkqTh0JcDwjrXxC7yt8YvEYl7rmbJe0rYcaA1rU?=
 =?us-ascii?Q?4O6lsMk826EPtoFdHQFE/R/NevAaypGKZJ09NocfnzgWwO++Mz1mwnevgdJL?=
 =?us-ascii?Q?MUi/ntVZk7VL3UvQSK+bcTHREsMceoSmy45TIZfmVSYBntN3oAyh8i1apGHb?=
 =?us-ascii?Q?xt8oeMv06LEYGcl8KnnuZF9PuORAwtQ4suusKLNn8LxmpaoTQ41zO1BcNtvR?=
 =?us-ascii?Q?jRN72LuaA6U8TmLbzbBIj/gba2cDJo3Aun58dACHMS3tFaJi5vQTovieRDTU?=
 =?us-ascii?Q?b58BbH3QN3X+FnUgw+lOHtVYPFTr0iyDh61vucXuWaFzvuOiyuMGwKVgiQOH?=
 =?us-ascii?Q?vtL149dwleDdbZS7uDoWCVoxPQKbpr0zxxiLoD55KvEj2a/rbjaEQP5FkQX5?=
 =?us-ascii?Q?3qanSNiOR1ciOvt+k3s11nE2shQ8k512HHCu9TxCFTXS1trTx3xLFemsceye?=
 =?us-ascii?Q?ZQK9zYB1AjloGjYzKThayoUX0pKlpQ4Lma4CdJPS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369d7930-6292-4e31-2a99-08dd55c013fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:16:01.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnPwtVlkhR4c8qznLNCT+NGUEj59mP8KC+BKs7cCn3b6Mt1ioHYnpHGjtDR4HtuV9lLVEwOiLlaw07Ed8RBrGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674


Aurelien Aptel <aaptel@nvidia.com> writes:
> Paolo Abeni <pabeni@redhat.com> writes:
>>> +     /* put in ulp_ddp_sk_del() */
>>> +     dev_hold(netdev);
>>
>> You should use netdev_hold()/netdev_put() instead, with a paired reftracker.
>
> Ok, we will pass the tracker as argument.

There is currently a bug in checkpatch, it seems it cannot deal with kernel
typedefs when they are inside a ifdef:

    $ cat > test.h
    /* SPDX-License-Identifier: MIT */
    #if x
    int a(netdevice_tracker *p);
    #endif
    ^D

    $ ./scripts/checkpatch.pl -f test.h
    ERROR: need consistent spacing around '*' (ctx:WxV)
    #3: FILE: test.h:3:
    +int a(netdevice_tracker *p);
                             ^
    
    total: 1 errors, 0 warnings, 4 lines checked
    
    NOTE: For some of the reported defects, checkpatch may be able to
          mechanically convert to the typical style using --fix or --fix-inplace.
    
    test.h has style problems, please review.
    
    NOTE: If any of the errors are false positives, please report
          them to the maintainer, see CHECKPATCH in MAINTAINERS.


If you remove the #if/#endif it is quiet.

I'm reporting this since NIPA is so strict on checkpatch errors.
I've added checkpatch.pl maintainers in the loop.
In the meantime maybe let's ignore this warning in NIPA?

Thanks

