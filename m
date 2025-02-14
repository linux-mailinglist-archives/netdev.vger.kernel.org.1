Return-Path: <netdev+bounces-166384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00DAA35CAE
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 12:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F0F16946A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC86263C62;
	Fri, 14 Feb 2025 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="sVOcLB7/"
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021080.outbound.protection.outlook.com [52.101.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2D025A657;
	Fri, 14 Feb 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533068; cv=fail; b=PUJWIrdiK121EyJ4qw8pq1A++KURotkapmC0GWofQJzEpQNqQzUGDt+6RbkzehW2S2I4S842fD7UqmtfXgDfokPM3yx+bBbMyAmMkGpsyRzI1R91Bs4Te/UJHlCgkjU4p7jTfdTAdVWjUJSl8SERnEhKf+Loii/fAP8fCZJX0wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533068; c=relaxed/simple;
	bh=IjFWn+gPCC6NL2fTwyTAuqDvzywntRNoFOUeA/PUjyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mriXi5xEeMcLa+yZxoZO5aWv22oqDcmOnewuRtkfHjiOQbUoxgXhy5zM3koo469YNabIWuH5Uj+4NtAh5iiQL9T9gHKDgW8z215VyUV5V3l/90Ia5asOVpeYu2RYdOGxaP0MEPrEBGawYki0kqwfekl+LLxEOAm7wXglTgxzHvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=sVOcLB7/; arc=fail smtp.client-ip=52.101.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4KitlUQmuxIGyq74sFDe27Q4j1Li/V3rqQe07csi2BWtHnwgjbAUdOxYL3AIZA0MuoCmQzv6Th6qkpKUnZ5YDqy0dhZlGX/7KMChwnRwDuEFw5sLsa1EmCK5dkQFt+KOBk6XW4qNj9cu02+0TXJ5GLycW81GS8PobI5hWD8Hd6pvSUv70Cg9nLtXuQrnbJbEqD4UQKjjsmLk03uGnfsWlhbXcvHqNil2DZmwouWcIlYVlaxA1B5erNBaeFHUrtXhcwFOv/+1472z5//XABtR7e4gZJP4cA85lCFmc6h06M6hJUP6qqrHWzT82NJuU9pnM1ZuMtoFMarEn1paAQR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/aFwF0AgNhX46hjssnsbwLM2eVJ5LhAnzJUDQRWhBY=;
 b=IjuWDNe8tDZTTo6iwwpMyo3R0HOwkKRKqaJLU52BYY8Tvod+m4fi8Kv9Vb2xvWxkLcvCgg1bz2jzOiFxTiI8PZbtKI7qizZ1ZhNscAKO6wN4ID887vKJm2/siFzlzIwLyjwMRlBxTXjd6dsIq992KsUhErKnZM0S0Wj7lBq6SJOiNaLKt045ND/C4mtRYE8Z9ddKXLzsxOPKhY7qQJwLJIeCXHN6t9ndO1JPUq0NkWq/5Ow6dxulbW7qErY8/j+dFZ4l7MRPdp0CfCPaf1QtGsKx5fGtgL2XDW4p3kTtYoK5/UhTYev6xrK/28r+quT8FrbFeA4trew8aDWPx7IHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/aFwF0AgNhX46hjssnsbwLM2eVJ5LhAnzJUDQRWhBY=;
 b=sVOcLB7/HHv1p/dMa3XpbG/hBOT52qY+Yn4gBF2UySmhBdFUusmzvPG2u3O1xcD/+EKs1GPsZIkkOUIm3iRU/kIys3K2CRangF0FK5H7kCU2bSm6hmLv1ynPMOLBXQ3DWDpAyPjf4otDDm1tmDWRGpnczGMe9CTg5UkQjfQEEpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB3061.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 11:37:44 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 11:37:44 +0000
Date: Fri, 14 Feb 2025 11:37:40 +0000
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 7/8] rust: Add read_poll_timeout functions
Message-ID: <20250214113740.156faaf4@eugeo>
In-Reply-To: <20250214.130530.335441284525755047.fujita.tomonori@gmail.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
	<20250207132623.168854-8-fujita.tomonori@gmail.com>
	<20250209162048.3f18eebd.gary@garyguo.net>
	<20250214.130530.335441284525755047.fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0504.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::23) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB3061:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7d1c60-cf2f-413a-98f6-08dd4cebff5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EIBhZaNmUsHSwGlQIh321FoyDGTohfQsljBA4H/83KJa4KphOvHZCN9a8nE9?=
 =?us-ascii?Q?KXCjtWAPvTfNFDT0aZB9qcwLJTCdhSvwKWYuMnHY392zgX5XcSrBRdwhUKxM?=
 =?us-ascii?Q?s9IG2gWhPydUBr6eefU/ZhzyzKA0N0/ZHHy0wj3caVOltG5mbdAfN4Pt6zlc?=
 =?us-ascii?Q?DPiNc8wUGCn9cByvbMLQvejVXSj/GtZLi+qge1AWAZePRMI6xcpRpEj7uFF2?=
 =?us-ascii?Q?VaRRoaatPUNfNR2sbY5OhscXHdrVJQr5NZGy/HvH9NSakqPHJKKGVlYBTgbL?=
 =?us-ascii?Q?TxHihejnV/v4MqxXLsV+pqLTXfzbMGbrludF6aL6JrvaNpf24fqVrhoB3PGd?=
 =?us-ascii?Q?iWPrwHyVUn6aaX571o96QLSdXrmixpq76gIftRa6LVNgZ3SeKOcGnGMulMz9?=
 =?us-ascii?Q?vzwkl/1BSwGOpKjX0+ZRdryJLpjiSD/aVtPL7GdyN1ZMVS4Fub2zoj9sT4eN?=
 =?us-ascii?Q?1GxlJGrMPp1nwnS5W+9ggIX6RrxA6JuQ4NxDleEdiRxjBKfxPstKP+kcwu2t?=
 =?us-ascii?Q?s7on/KwHfjb//u+NVy0l7S4fYCWgvTFLGLlKCSol0H3wqLUbA3sVpQBvE9Z1?=
 =?us-ascii?Q?Q1y/JOODxhi8uyENXefkkCiOyKKgJ28e9zuzPyOZMdlqMY6UbwxWvwPKbcgi?=
 =?us-ascii?Q?6P/0DIFbQJUNxJkyUQXkllnuyvufmc3Ag1HiYdjNyIvgm0tTL7B9qe4Jvcmm?=
 =?us-ascii?Q?4RmsGeHjjDZSD5vRtDBuBSweJ7MLCnyEYkKv9bE6Q8odJXomdIXY4WGaZXiW?=
 =?us-ascii?Q?lf8xPoEIPLFWnONAhmAewT+oDRb3APnWDeAg0Q5bMAaQVUmAS6Jw1HiGPYlJ?=
 =?us-ascii?Q?aiSTEx4jzrz2jY954BYTdh+wVvJjT1TKLFg0XWl73rXFwcqB5X9O81/c6c7U?=
 =?us-ascii?Q?0TesplbJEvDUaFjoQtjuxhcQrsxYDW+NvGzHKUgqdpANtRauYwQ0SqT1m7oC?=
 =?us-ascii?Q?JEVdtDGxqA3VfywzYRv9VTlbPYDfrrE5UIKCjpXEtqJQiGhkgLxQliNIqOWd?=
 =?us-ascii?Q?sPhd9nWTR2a8rK2yWlf9VpyzK10BimQXhKyF733VVuxAyjD3AnSoqTIttSTN?=
 =?us-ascii?Q?VA5txElF7YYEa3SaP8FWuFV/0c7K9RRnu1cl38V7xMjxSC/yN6iU40lIh7/T?=
 =?us-ascii?Q?DGVeHqUqULt2bOBsz08JaUhuO+mVzjO1JObx5FLwabIdvn7AgMkSsF3AO9W0?=
 =?us-ascii?Q?gL05b9uAjkQDZgjt2VREQfKdZJa19MjkXmWIydZhvptGMW3GWLG+okD2Gfik?=
 =?us-ascii?Q?Bjp8V21lRohZy8S7DmYXKrMRYkQirrK5PzEt8DVYTsF0A4QLuZnhy2C1h9yF?=
 =?us-ascii?Q?lRsj15OZAUwOsQ0dUlf/5nL8qkeIH5aGqufa9dZcUvCzJ+Z6xUyjDi8lH9Ov?=
 =?us-ascii?Q?pZInZWnAm8U5e0aRBFtSqSzI/25t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z39n8HFClXb3rzinFe3Vgsb9u1aJXhlmYtldtJipY3IhtGefTohgE3H/lhrh?=
 =?us-ascii?Q?xEK4i/0t3VqyulZwM8PdKvBQJUhyeoaW7q4nAtTg1Y9TqoTLuF4iD5f9+qwK?=
 =?us-ascii?Q?S1mulEOEgiNIY1ocMRH9cGa7K9LnbigcxUgXWri9/dZi1hQ/t3ZIz8OyJAh2?=
 =?us-ascii?Q?718wBm1KKHCRdmx3k4MrNbvUv8B3z8PbI8zeQbymW8DDwws3Yk8EShJwqw2b?=
 =?us-ascii?Q?DHsfZ5deWjn1JXvzHHRf6M+Q2W6YnQ/VPqdv93BRF1tfukDNTcts1In+nFNB?=
 =?us-ascii?Q?3Q0bSM9Dr39u2IyeZU2oEEO7zYucS52LtGi0VlTIJzoHj3CT5q7U4vK2JqsQ?=
 =?us-ascii?Q?MEpZ76j9J1/R6F7emgLgNPW2tWvDfjy+9cqbbS1EKm/dsBe6bakGgS9Bf/7n?=
 =?us-ascii?Q?bopCUbqUIxV5AHCfv3CYR+533jEta7eNV8irZ4MKrs4C+oItHdfC/HzTuLtR?=
 =?us-ascii?Q?BkfFaqYrzt5lHeICjLryocwepwReVkd2hhYoDqGuqoPFUeXDFEPb60glPMei?=
 =?us-ascii?Q?iIcirppf5xEkJ19hgDfXMreODkwgLsprcx/WBExb93V7ODD13WII2uSxPqwB?=
 =?us-ascii?Q?spP5bjmzRs7iwlyFLl9ZYt/9SPlWZqdl84ahiB7joP2NC8oCiHKoQcSb4vH2?=
 =?us-ascii?Q?+l1Ac9ytuSZwqw4pYOlgfCBymY1eLHz78GR0j2tNnY0WPfYJQsBpjkM5kq1P?=
 =?us-ascii?Q?DrBy2qC4tULFxJ6vmxx2PPeKWegXfAjG1cWDC1oLdMwsEnk8sK25YNm45I8B?=
 =?us-ascii?Q?GDyr9ODgFfFzWi+MIxOazcLxpEkAlq80W0zBie6ZVnjtCV4y6rdnURGRGs5T?=
 =?us-ascii?Q?/MRnIQT5opYZgCTrp87OjiOMNztI8BtVXPBu62yjW3nEUmVkiYZhwelKoZhD?=
 =?us-ascii?Q?4QhhP+QXibDdCjIZKmr5CUz0Z0ASxfN6xhT+0y3J6SUJLkqOlKm6JrvqY3ZZ?=
 =?us-ascii?Q?NLcQzo+kguDVisFVtqptWYZjSBsHvjl/6RMyMAtvvfowu6dV3F9kZiHZ8QlR?=
 =?us-ascii?Q?sBuRbT7u1pYBwbgfg0kfzUsW1IQKNk/Ul3zE6GXIQChBsg2XUCRXZBFMihxh?=
 =?us-ascii?Q?ubJ4YfSv6jvZBkMo2ilkaEfNFrwAN1pEz96VN5UeuX8ZGKE+TPLIssxPNtxo?=
 =?us-ascii?Q?Ha2s6J0TluyqyEyMdULs3zXCPWm6br1tgyrTvvMjig7WExXdVBZydfuyp4Sd?=
 =?us-ascii?Q?30g5F/TO7LzH0vkPm5EOT5R17wDy2mVxmIFhy3EyP26qr3s/thXqx0kr1jQr?=
 =?us-ascii?Q?WIwsiS1TFjZeloJW3pKfM4M2ZmlIL5jokW03f2870tM7wqfHo+ycK0qxSRro?=
 =?us-ascii?Q?z/frctEMcnspLNnXl93SB8JQ4lMi0O7TFwOHCTjuvaz27d22P6GbPO5rkrqe?=
 =?us-ascii?Q?uUqgXyV2t8jfKlWSDlYX9F78/kx8axatEl+3DvOr5ln9A4vI0DY8XLdFsJmg?=
 =?us-ascii?Q?SZ1wdrwKl9SKEYTJjSNVbTh14THO/c49DstbCKGL1uQ6wW4p0PsdXMMcTvOU?=
 =?us-ascii?Q?ITC2QN18bB+r5JOk8XZ3V3pfBTKisN1CyJGKOhHEUrSZ3+L8EedyBa1KD+3u?=
 =?us-ascii?Q?Wq99FzQPcyNR+AkpDzK4yUDYceSb1LK1T9b9t+Ss?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7d1c60-cf2f-413a-98f6-08dd4cebff5d
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 11:37:44.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYAoePQ8DezYgDkcAhH43MWB2EAmiNTOWDtyMMxGva5vbLBVrV/pMdq+xtKE+8F+qlxj5xVcGsSzT1gwKZA5vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3061

On Fri, 14 Feb 2025 13:05:30 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Sun, 9 Feb 2025 16:20:48 +0000
> Gary Guo <gary@garyguo.net> wrote:
> 
> >> +fn might_sleep(loc: &Location<'_>) {
> >> +    // SAFETY: FFI call.
> >> +    unsafe {
> >> +        crate::bindings::__might_sleep_precision(
> >> +            loc.file().as_ptr().cast(),
> >> +            loc.file().len() as i32,
> >> +            loc.line() as i32,
> >> +        )
> >> +    }
> >> +}  
> > 
> > One last Q: why isn't `might_sleep` marked as `track_caller` and then
> > have `Location::caller` be called internally?
> >
> > It would make the API same as the C macro.  
> 
> Equivalent to the C side __might_sleep(), not might_sleep(). To avoid
> confusion, it might be better to change the name of this function.
> 
> The reason why __might_sleep() is used instead of might_sleep() is
> might_sleep() can't always be called. It was discussed in v2:
> 
> https://lore.kernel.org/all/ZwPT7HZvG1aYONkQ@boqun-archlinux/

I don't follow. `__might_sleep` or `might_sleep` wouldn't make a
difference here, given that this function may actually sleep.

- Gary

> 
> > Also -- perhaps this function can be public (though I guess you'd need
> > to put it in a new module).  

> 
> Wouldn't it be better to keep it private until actual users appear?


