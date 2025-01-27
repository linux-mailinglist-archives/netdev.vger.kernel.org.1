Return-Path: <netdev+bounces-161053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531DFA1CFD2
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 04:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10263A4369
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 03:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02082AD21;
	Mon, 27 Jan 2025 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="NjH53pZU"
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021131.outbound.protection.outlook.com [52.101.100.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2EA2907;
	Mon, 27 Jan 2025 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737949634; cv=fail; b=ZCDkTtTLF2erSDLojPPAOWUuaF9aEggS7vGiXe6FaYcLptA+eP1e/Si4gAlUuyg6AxEevOdceX7rc7geo2FR9gXcShsLBEWSSPwF1S7GKlFRyHPfWXVEhIfRiU4Y5brvWjklHLP3q7kTTWSmt1dcpRiqEpPxTviPZkRsQPlWshA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737949634; c=relaxed/simple;
	bh=TjVwDUCICN1LXyYfprJ9w9nPOCzSBNHrJJ3SRA6uCME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECLiazmWCgSpEffe9vCHvs90pkN1FICO7ERjCzmZUPp7SdvKghtgW6OgtsxzpLSaCL+OCxARbazH0qvU28lzUv4yalX7X299fF2fXykmZ49plfGkxI8H6BHtFZSARvN6MNmyZ48Xi3QcdlibIS/yvJMk8LHfYCfEW+A57UqzOmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=NjH53pZU; arc=fail smtp.client-ip=52.101.100.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJsB0NHA8y9m9SZ55WXJ/MwsAF/i2irPg9US/FkXVx7nUWGOHyMRvMm/jh/i2y5NSA/XYrv9B/FYgxNltiRZYemUYtgSaVt3RSuu5V8kIwQ0ZetVgenpPBNZ+v24pL5SW5VvlgoZpIverDGVS8UvRCslls4WuBSX0g5JqwPuCvj1eOkNkGijHUkWXYZPa55FD/E2ugXK9WiSWog6ZrlThkQzNsB3X8xayuJ1H1gIFRe6eQNwHopMruvvWnRBWBNQWmhbRufa3PaKGRnG6greZGJoMy5hkdhm0c9uODH4nQ8y554t7UuV7I8g4/5dLmxS1QDn+pE96FK0nywAVoSJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7UKdfuMo4bzl2HdHf083Fe1FDyonoSomh8JH13Ow7I=;
 b=M0idH+ftMeA3N3f9Pncm2b1j17TvUCgkY7AosClShs5UWgGnaWFJw2sX6/y+g0oKxLPSk0MDr5yrtOtYXRPG0JUPINloqVoU8FAUDIYLeED1IjE08R9h8H8DtZMOFxVHiW6pEZrFX6DbNxtnpuiihQAgkmUvyc/hfnclO4TMVC/fOOYr83UMTBUkhDBG0XtV0oihmEV5ghMBIdxOSe57/0GRHYw9nAHfvCXL6HdY9gQH65Y2Qu1MTLV3Fdngmz7IEMutKGbVhcUu4ekGuY2vjJH9UQLNWeK7ot2XHGFDYWhuH1IMLB0szpf1V6446DTk9b+kIl3F3F1MRkjNcsgneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7UKdfuMo4bzl2HdHf083Fe1FDyonoSomh8JH13Ow7I=;
 b=NjH53pZU+jSJSTfC1Vx2HQM2rUOBxlm1OsRlEwUzjkAmYJi6TH6egNRYnab/pMYTcj6WACBMCsKFhsX3cfhSalo5GD7P01glUYnTrrqaS1WAk/hch1DjrCrOedNJFANLuf4WRSn9dqNtpoZdGQGUlvJbKLChnBHcSOxMGbtXAxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB3019.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:180::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Mon, 27 Jan
 2025 03:47:10 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 03:47:04 +0000
Date: Mon, 27 Jan 2025 11:46:46 +0800
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
 tgunders@redhat.com
Subject: Re: [PATCH v9 7/8] rust: Add read_poll_timeout functions
Message-ID: <20250127114646.6ad6d65f@eugeo>
In-Reply-To: <20250125101854.112261-8-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
	<20250125101854.112261-8-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0179.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB3019:EE_
X-MS-Office365-Filtering-Correlation-Id: fce8f86f-5648-4fbf-e334-08dd3e8543ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QlZk2H8JRzEGG6I4pykG9mWtU3D/zbaBzBIv7XFBZHbsk/pfyVbd3S6Iyo5k?=
 =?us-ascii?Q?WsVbgZPshd3ntzERdqu9PJ4XgSme59f5p5JIQzy5ankPzTCZyHV9LTOpLkIv?=
 =?us-ascii?Q?bDWpoF7h+IspUjMMeAUt2cDC7vPgEBmeB9OFBsbATdXjoxgh09vB6fcFCqHE?=
 =?us-ascii?Q?Vz5qdLQWsfsRAj1pCkPejo6UaxE20k74YDds83pkt+z29y3O7+Nz+5rIcfBR?=
 =?us-ascii?Q?0RnCKvi5G1761T3LZDqqzR6Y1E/lnnL25EMvvxvMXBl3Z8AeSxNDLqJqKYiH?=
 =?us-ascii?Q?xxNoxjefsVE4eqWAkEjyObPUYnHBFDuUl6ZiBVSjUTnEU8p0pH9Z52vljtmR?=
 =?us-ascii?Q?Lj56WDUVZ943pSu+/pfO1ipzzh2E3Vai5DRAvVUeNbECHQUUTX+FSEJd8TWL?=
 =?us-ascii?Q?0DUU4Ap9prZMD2AnH1RUHI5pZ4ZEK+Pr18x148D1MDlaza4PX+YXn2Vw81G3?=
 =?us-ascii?Q?5n5f9Y8b4ULdpU/ox/Ktq0jN5PsSqyBLarHQiryGNHsi7Zh6XcfkfZNjpsot?=
 =?us-ascii?Q?I2+gs2KNbC4sdw/ezqzpoIOPkN2Dydbt85xHvjW/zpsyzK1Kgu5/i8XHc8LY?=
 =?us-ascii?Q?yKLAncXrMyDcTsK578vP12FdUwAfKZZrye1wsj14izRUFXIyYkQNnkZtmWwd?=
 =?us-ascii?Q?w0bqxhNUWdMRflik71eQOpGfnVxl4ptJbzOAhHFVh2bfvi+6N2UEk0VzZ1P/?=
 =?us-ascii?Q?NYtAj14f9470U0ACHYstXajjdvzTpy5jJNJ7/M6gRIcUQ2NYhGSpQ3zo5MGr?=
 =?us-ascii?Q?0ynbqMjtRTIiR18bhHS4y26nwGaZvQDpUZIVWhuWJ2To13p2Ye5g2KexbaOe?=
 =?us-ascii?Q?tN9h+hmzFNybTX+2xToFVhGm/tRjJq12HDvzB/D6GFgNeisI3nlGRKeR2vTJ?=
 =?us-ascii?Q?Xs5f0jQ1TwxmJVW7n7nB2oQA6swCltLGYRWXJMbRLgJa+F5miFWjL7RJi8Mu?=
 =?us-ascii?Q?+sioUPd0Xw6FqUsU17iWEhSpI8FkE09FYJ/UWWx2VbI80WPJ/Czb57QCn3IT?=
 =?us-ascii?Q?HbQpqH0DuK+M2HWXnXd2iVHXd4rj4p9hWwmteVnWG7O3ji7HJNxdVO3Jc1q7?=
 =?us-ascii?Q?C7OSE20NYYGCOwUKvSM7VW5g32cI9QI467qD4HYYlxYNOMMwc8J9ORMEjA9E?=
 =?us-ascii?Q?NwNB8/vSDtXrImax/oRFukj6DBR+ZFHokP3DvqyTxL+uuyBU+JT5CdSIfxT5?=
 =?us-ascii?Q?5vON1165OKuMWUYRvvfjLcYnnD1yl195eUNxgLxQ8Eb1Kdvcr+lcgq5cUeK1?=
 =?us-ascii?Q?5H0N6+HTgpHXAuXhTXK0jmh8dyhl9C1rl5L3MAbhjnFDO/lP8aHw3EncxQI4?=
 =?us-ascii?Q?iSuksQ0B9fWLzhfe7RY6/anN1y7zc/7NxReM6sOfsau3PQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UfIFSQN3odI1J1KvDgRQBUFVSQh81UCOhTYe0ygjl41tBF0MCoGIulVGR8AF?=
 =?us-ascii?Q?Kra1QsfG59EC7ynHMByvoWRqFn7WOhKjvL0zW1vRkAyiC9hYLO8oDnAbNeqH?=
 =?us-ascii?Q?IDFg3nhrOXxfoJ0kROCC2MvH67X0eKpjgOCDm50kX0G2ivKO+TlLOcgy+vDr?=
 =?us-ascii?Q?W7saqdaI9rbYu16PjgQcDqtnEiECWVBxwkKId2ZbBdX5GzahDPmYfV5Ebj0b?=
 =?us-ascii?Q?uKCrNE+/PbOnZ7OiJqYa1ksm4a9+Yj+Mza9Tv4K9NTZlrVESni5aor7vysoK?=
 =?us-ascii?Q?i7nl4Ra+OKGslrh/BamjFBbaoV00qDErvT27G0lGsmxcepqsN3k3nN+UxNHG?=
 =?us-ascii?Q?FeR2nF5HH6shdtsrV625Qu9dcxZ031F3u/118tManvSecPtVcP5RXFguJ7ZJ?=
 =?us-ascii?Q?ILEkaZjAWzwU8Hn5lwzKRhw+tXbRz4vyHTbLSrrxqjRdi1VbwGBnDKena3hF?=
 =?us-ascii?Q?oqUllo6oRx2j1JUhjsLb/isiRVRktRH91V/sb3untnHeyLF2Tm2dJBvM35dv?=
 =?us-ascii?Q?n+DI3KfCpTk7f81iKbiXDdjPsn47C12wWc58zF3gJ7Qd2a2L/Bu0Zr4vy9p4?=
 =?us-ascii?Q?bZc8yum1MFcYG281chvdQzcP43Ii8r3zZb14pVgdrs9nMuliIv3SkRcQ0gmp?=
 =?us-ascii?Q?Rz1NWmtQQ80CJKYgzUgyYBUImRfQsLdnpiLbegWNGwY1LdBuMXRqArnsu6os?=
 =?us-ascii?Q?/Vgew0Un/P3ld/doqTdmifiwVKQzUvjZSv1FMSyUsE7Owko9xBtBr/qlSjse?=
 =?us-ascii?Q?olFEjWxusSTWCh3zzZkktmeMzvDo+cLcvkKcQ4j2sdEDWeCvx7W7FnqMc6Ab?=
 =?us-ascii?Q?7QA9+B0chSwkIdhLAyhJgwBXiLiTcU0pgrz8Iw1lc/EO7bSXDMbY1WQI7L8v?=
 =?us-ascii?Q?PdsxVu6NuyBJSObIRp4j23zVk7tRXaIlJ8LfHnthMg0hhYK+SFElCfow3z1Z?=
 =?us-ascii?Q?MpVohiBpVgcfsQbONzE1pZZeJNNn9ECiHO6Pz0Z0J5vyXbhX1D4aARyc2q5c?=
 =?us-ascii?Q?N77jHhGE3E5WR3iHjvVTDI14iuc3be/91irnv1y8joM0bFtna+78MGUGGNQy?=
 =?us-ascii?Q?HCyo30S1GQ5gnOcwz0rGwldJAtOq7z/RZWMbmNS0vBhsq7/LxQLL5+GccBCL?=
 =?us-ascii?Q?JdW2rUvMVfQnp5fMR4wg8iDXj4XqJLKjIe4F6DGUYNVT7GPausJfSTIQ2uBd?=
 =?us-ascii?Q?ZvBP19XkeHVKp+BmKXBBnrh8kuRVBiW//8apEOvsNDC7sZzQzGXgd/NJevz5?=
 =?us-ascii?Q?ns/wvJYYYVLDqTpT0h8Hq4+KnywnNsobdZ8GPLokwcHOmjqXwvKmwt/sWyab?=
 =?us-ascii?Q?PkG6RJMJf3xYouQCM6TP+JmoBKv/g6Q0xbefPQI2OgMRVvdsdEZiNaNp4RpA?=
 =?us-ascii?Q?vgqn2pe6GrmQlfj+PT9S1qgTLj+ShcWDFBjySDicwzv0lJ1ykuBiObJOV7BU?=
 =?us-ascii?Q?PSS4/CCosg3NU0bKhk3CtGMaHqfneggO58FyudPui26sm+tQwGtfeaxkdO3C?=
 =?us-ascii?Q?UxLjavQ8DxvdCmo4ekTeidbT/j7SVf0xHbbvGH5bhH6HpVe1yOpkiAhSbp9W?=
 =?us-ascii?Q?tdnvecGn6muEudXHA69C45GuEjdOfXHmXtAPtK5xCDEoof4gdrnALc6Onxy1?=
 =?us-ascii?Q?Q9D43OdiZt0fWuNaRQaD2ohOF7FOvImMmckfeccm0JZO?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fce8f86f-5648-4fbf-e334-08dd3e8543ac
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 03:47:04.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a6WDR3lSAb67OFDyeY4/MiE6WCVB626NTk//VYxSx/8jCCUYvmbb286tVQXWI8Is/5DCrq7dcxPaBpzhJK91uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3019

On Sat, 25 Jan 2025 19:18:52 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Add read_poll_timeout functions which poll periodically until a
> condition is met or a timeout is reached.
> 
> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
> macro and a simple wrapper for Rust doesn't work. So this implements
> the same functionality in Rust.
> 
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
> 
> Unlike the C version, __might_sleep() is used instead of might_sleep()
> to show proper debug info; the file name and line
> number. might_resched() could be added to match what the C version
> does but this function works without it.
> 
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
> 
> read_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [1] or a similar tool will be used to check it in the
> future.
> 
> Link: https://rust-for-linux.com/klint [1]
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/kernel.c  | 13 +++++++
>  rust/kernel/cpu.rs     | 13 +++++++
>  rust/kernel/error.rs   |  1 +
>  rust/kernel/io.rs      |  5 +++
>  rust/kernel/io/poll.rs | 79 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |  2 ++
>  7 files changed, 114 insertions(+)
>  create mode 100644 rust/helpers/kernel.c
>  create mode 100644 rust/kernel/cpu.rs
>  create mode 100644 rust/kernel/io.rs
>  create mode 100644 rust/kernel/io/poll.rs
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index d16aeda7a558..7ab71a6d4603 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -13,6 +13,7 @@
>  #include "build_bug.c"
>  #include "cred.c"
>  #include "err.c"
> +#include "kernel.c"
>  #include "fs.c"
>  #include "jump_label.c"
>  #include "kunit.c"
> diff --git a/rust/helpers/kernel.c b/rust/helpers/kernel.c
> new file mode 100644
> index 000000000000..9dff28f4618e
> --- /dev/null
> +++ b/rust/helpers/kernel.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +
> +void rust_helper_cpu_relax(void)
> +{
> +	cpu_relax();
> +}
> +
> +void rust_helper___might_sleep_precision(const char *file, int len, int line)
> +{
> +	__might_sleep_precision(file, len, line);
> +}
> diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
> new file mode 100644
> index 000000000000..eeeff4be84fa
> --- /dev/null
> +++ b/rust/kernel/cpu.rs
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Processor related primitives.
> +//!
> +//! C header: [`include/linux/processor.h`](srctree/include/linux/processor.h).
> +
> +/// Lower CPU power consumption or yield to a hyperthreaded twin processor.
> +///
> +/// It also happens to serve as a compiler barrier.
> +pub fn cpu_relax() {
> +    // SAFETY: FFI call.
> +    unsafe { bindings::cpu_relax() }
> +}
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index f6ecf09cb65f..8858eb13b3df 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -64,6 +64,7 @@ macro_rules! declare_err {
>      declare_err!(EPIPE, "Broken pipe.");
>      declare_err!(EDOM, "Math argument out of domain of func.");
>      declare_err!(ERANGE, "Math result not representable.");
> +    declare_err!(ETIMEDOUT, "Connection timed out.");
>      declare_err!(ERESTARTSYS, "Restart the system call.");
>      declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
>      declare_err!(ERESTARTNOHAND, "Restart if no handler.");
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> new file mode 100644
> index 000000000000..033f3c4e4adf
> --- /dev/null
> +++ b/rust/kernel/io.rs
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Input and Output.
> +
> +pub mod poll;
> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> new file mode 100644
> index 000000000000..7a503cf643a1
> --- /dev/null
> +++ b/rust/kernel/io/poll.rs
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! IO polling.
> +//!
> +//! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
> +
> +use crate::{
> +    cpu::cpu_relax,
> +    error::{code::*, Result},
> +    time::{delay::fsleep, Delta, Instant},
> +};
> +
> +use core::panic::Location;
> +
> +/// Polls periodically until a condition is met or a timeout is reached.
> +///
> +/// Public but hidden since it should only be used from public macros.
> +///
> +/// ```rust
> +/// use kernel::io::poll::read_poll_timeout;
> +/// use kernel::time::Delta;
> +/// use kernel::sync::{SpinLock, new_spinlock};
> +///
> +/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
> +/// let g = lock.lock();
> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Delta::from_micros(42));
> +/// drop(g);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[track_caller]
> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
> +    mut op: Op,
> +    mut cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Delta,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    let start = Instant::now();
> +    let sleep = !sleep_delta.is_zero();
> +    let timeout = !timeout_delta.is_zero();
> +
> +    if sleep {
> +        might_sleep(Location::caller());
> +    }
> +
> +    loop {
> +        let val = op()?;
> +        if cond(&val) {
> +            // Unlike the C version, we immediately return.
> +            // We know the condition is met so we don't need to check again.
> +            return Ok(val);
> +        }
> +        if timeout && start.elapsed() > timeout_delta {

Re-reading this again I wonder if this is the desired behaviour? Maybe
a timeout of 0 should mean check-once instead of no timeout. The
special-casing of 0 makes sense in C but in Rust we should use `None`
to mean it instead?

For `sleep_delta` it's fine to not use `Option`.

> +            // Unlike the C version, we immediately return.
> +            // We have just called `op()` so we don't need to call it again.
> +            return Err(ETIMEDOUT);
> +        }
> +        if sleep {
> +            fsleep(sleep_delta);
> +        }
> +        // fsleep() could be busy-wait loop so we always call cpu_relax().
> +        cpu_relax();
> +    }
> +}
> +
> +fn might_sleep(loc: &Location<'_>) {
> +    // SAFETY: FFI call.
> +    unsafe {
> +        crate::bindings::__might_sleep_precision(
> +            loc.file().as_ptr().cast(),
> +            loc.file().len() as i32,
> +            loc.line() as i32,
> +        )
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 545d1170ee63..c477701b2efa 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -35,6 +35,7 @@
>  pub mod block;
>  #[doc(hidden)]
>  pub mod build_assert;
> +pub mod cpu;
>  pub mod cred;
>  pub mod device;
>  pub mod error;
> @@ -42,6 +43,7 @@
>  pub mod firmware;
>  pub mod fs;
>  pub mod init;
> +pub mod io;
>  pub mod ioctl;
>  pub mod jump_label;
>  #[cfg(CONFIG_KUNIT)]


