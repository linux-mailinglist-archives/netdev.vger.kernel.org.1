Return-Path: <netdev+bounces-160395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A52DA19888
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6270416948A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277E621576C;
	Wed, 22 Jan 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="BXPshm5H"
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021114.outbound.protection.outlook.com [52.101.100.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1F2153D5;
	Wed, 22 Jan 2025 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737570983; cv=fail; b=afloFohnOeHwpXokzjVB/42+tTeeMwRCrTk1D63UFqjeFOV4Xn7VkhQw8d2yK5YUVR8iUwheaK/14DEyj7CfDuq/TZFH1NoC2IALPeJtX2N/PZLW4gITXvvJu48XYnHkvCcS/v2ivbt5BVtLDCPNZBFJIe4SquyTcXuj22ZnDqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737570983; c=relaxed/simple;
	bh=BhsKrt0DWkVcRa9c+Nb8WOs4Wp6s0jZPjzVJbcNJvKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lHY/DHk5KwD9z+7ckFqYtu4UYgcYjNpXAcW0O6FOZ7fEoVbfVopH1Iz+f/IH2L39ytfkjNl1vdUBBtwbgcfUlLMIpQIU0zJjWOJKFOhqtb3yrSvxclF2U6u2Q6EgpGbEIlChxKFdJn0DA3LYh37qeaAP/1FHt70fgAQpC+PKGnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BXPshm5H; arc=fail smtp.client-ip=52.101.100.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqLXTiG0C0vsKulbFWSmvgiqlpMsinGAp003juPIkZN8T3UsuTiOk/OlS1KF2tygykSAxohZ2+1oSQTQLl4u58jqI2VBm1uWf7kAwqMk49Xsqb+/tdtb9Idr5M8h95CFA1jRP2x/f33QW9DMV4fjKyJoJogzQYIo6B892iGOb3MSv+zJDEGX+lcWbTJBOhpKigd3gV8W8qAQKZkhvvMKyAmzUpcdt1sN1Xr9hGybj1MgJVFFkw4Q6gijv/HXerc0J3iO7mVj3kRRsKv/qwBZSnDkHGpTjmqrWwYImuIlfoFOZcrginKTov8Ca5SPaN/GsYb7e+zj7krANvxHHI3cew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06BoNMhWo/CtYhAU5Xl7dkRRkh2ACUcoHuaaYPMvc0E=;
 b=MzLw5Jc6+GjSHXlAlEeGGFpqr7HivkkhmsTMcoTG89co8d7ubWqChv+GvJL1+EeeRdwfHcMEExd21FqgW8sQ18IVomrekKEc3YMwqR/LPBrZhXq9VgtZoTMgrY/e1o2Xgg7ddMb/0hXJyZ3TOV9YOwPX1titBNUvPmXD/CvvsWy+tBIsRL8hpmu1cP98xpNe3h30n8sFSiUwqSxN1hpHb7yGe88okM1z79rosThwKppNJVKjikTPNYOMfiGMAXXUKw9NGVSuly4n0aT2hlkAuHhWw/8yv/H1ojDFXmWejGSJNmsJTG2I7dGiExRXEGsRvDSUIY+ReDF9bScw+c8TRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06BoNMhWo/CtYhAU5Xl7dkRRkh2ACUcoHuaaYPMvc0E=;
 b=BXPshm5HD+Y9dFTcnzVFNLrRiOG7rUlbSGeZuSo0hBUgXyGQVkjsQs8Cpxa4sXTDOk/NErtGgW9uJ8wNlTdo3NzLvYqTfuCkZWAXxuGHd4ocMXq9CuSmlkj+Vng2y2dKQhlBx+YuwXH5DnfggVbRafxMzDuYrWl0Z879P9MYgTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6723.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 18:36:16 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 18:36:16 +0000
Date: Wed, 22 Jan 2025 18:36:12 +0000
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
 sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 6/7] rust: Add read_poll_timeout functions
Message-ID: <20250122183612.60f3c62d.gary@garyguo.net>
In-Reply-To: <20250116044100.80679-7-fujita.tomonori@gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-7-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0264.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::29) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: f9755463-bfc5-48c4-ee7e-08dd3b13a790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/mUsLJKy+uJT8paClSc9IamrkyIZ/cy1RGtGUVO0qIJvJ9zEE9W7Hbnlmq9m?=
 =?us-ascii?Q?BQN71zQ/5aiT1Jedg+9YX1HrllLu5sY91NKEUquQWZhSgxVWdQhxhUGwTs2L?=
 =?us-ascii?Q?T6Rk1U5LnXXxxqZqzNIrGLa+0mXaslwwQ4MRjQ80PGLw0A0IWkG/Ex6Z0Yvl?=
 =?us-ascii?Q?H+s2OH5v5h1xBp8bXwLzrqaP3Y+4DQrWtLrvATwT3dvqMdlZeJzDnH/26Ko3?=
 =?us-ascii?Q?o35zXL8QXjd8O8WSbM0+EcOkCS7Bu7cj/SAww985pV1WEBWFg7rkWvErEKlw?=
 =?us-ascii?Q?vwZa1DXyUbdCsIXbh8SOEWRH+O+JBeBhWLfPn01ByuSZTSZzrH5eOzLBGILy?=
 =?us-ascii?Q?rjIN6GROjCA8GQWGQlyqarVovbQ0UL1GaeFfuGCkcZDXnUlre7EH9Sqff5GZ?=
 =?us-ascii?Q?PR63wmaiobHSAPhUVB6mZtsBeYlzpe0/9nfPE8EYZ3WiAEvpl9IYot9ZNvmx?=
 =?us-ascii?Q?BOEv1qQxu+kgXxQyzCL7rai0knZ622zJRRSCHVYvdUJQAqbV8hiXRgZj60Zh?=
 =?us-ascii?Q?OMkciHjJ/eYBfJ9+mrT9Gdn/B0vHTMkm+pblx0KHrP6pXzHu2fQjeinJEFrJ?=
 =?us-ascii?Q?M9glX9+RTZhag+3ooFW8qeZH2UBBylTkAZeYDKeWIqhGFRvByFondnSeh90x?=
 =?us-ascii?Q?Tg6O6+TxxlSgRknMwNtzPDS9rE62aOx1e27hlAu9BcJ5BBxYEJXPmW6TAEYQ?=
 =?us-ascii?Q?STuih9qAItcsxlgzhMBKMHbOEofXD7GhVVDs0xBhs/EKQWtnXcEXuOxwKhBf?=
 =?us-ascii?Q?sZDzuMej1wvFF2yFhvt6lWC2TvnK3/cKwECEH5AO6As6ImJgQrYvhpzUj4QL?=
 =?us-ascii?Q?ntQgpdrAZMhsE1Bthq6gITermbVi3oMCtWmjiDGe7lhHbbkJbV5OqtdX6P19?=
 =?us-ascii?Q?xc8vckDAwX6q+4oHo0uATJew7gf8SoYWfJFAasaSGwup3fVe9yksqo9T5Qwt?=
 =?us-ascii?Q?w1bKmQWgHejcVUBvt0gGWHlcnhhj2sQrOuPcLHxGfaMYyxtZS6cjWLcPZCho?=
 =?us-ascii?Q?wHOlFjB4aYjNQ3JWv/DBX21dQvPAh3ZWJwi+1QZl78zSK+ecp4dCx7AMoaYf?=
 =?us-ascii?Q?zDVH2ll5uacadioJVQERtx2vsVkmp0bnGQOIqgbWOnNAnNR/TW+HZKp7kvob?=
 =?us-ascii?Q?b6ctFE3Ry9qyUufwVsi3XkI3qivd1tVOFTg/qvr3tuyVoAqirx44htgrvKB4?=
 =?us-ascii?Q?6o4F7akCny0d0j0NOHXZFA2EdSmdCpgy2r4LjKrbZf5Dv/DVXFIIXsA1Mw31?=
 =?us-ascii?Q?HceM78bczNVkGjeqePjYLK64WyGSYVB/O2r8TZHsA14iHPDHAhMrHPeqkFPQ?=
 =?us-ascii?Q?k/lquRoufIWcZfQDG44QaAKjrr+rcels1ldavDRRUwoVSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IgTmrnehiXqb61u5jahorLsYK1skvIogQFK8WUiwWI6Z8wtYBCaXQDJVlMOJ?=
 =?us-ascii?Q?uK6CRYtl04dLU8h8MSj9+PU736PfqI3gnEnqX0B/8sSNHy3SzWxlXSxC91QW?=
 =?us-ascii?Q?ASO023He+l/odbGoYJUJtRj1WwpnUhtePpfN3zI9UDjPh8iYkjhuKjP2KrXo?=
 =?us-ascii?Q?UrKwxM/k3RP9AQXdFEHqw3lEWwl30UeTGjR9mCT5EEb/o+NpgA186yKBhfTo?=
 =?us-ascii?Q?Sya1CPwhgu/oYDHSXQJBMyM4LWykdN8zYEg1eDClG0H807PpOq5CO9i231Lu?=
 =?us-ascii?Q?75w2UoLk4/iEOHdcS9gopoyyZtx83xltkmw5Yl/n5a0WV1GohNqhTu27XrR/?=
 =?us-ascii?Q?hPDczV0YBEUSTXwEZgEEX4Whgu5FaRd3pcU+iA093wIKQHRQzBxYfXifaQAt?=
 =?us-ascii?Q?74d+o1gXjLY0cegu0kMVOjzJ8QeICMm8Mzenenrn9XFfJVKy1aF8sypyIlPO?=
 =?us-ascii?Q?mki7AxpPdzwA8/WWIs+z8aSdLhQgrWdG7ROgFcFi6pk8CBrMUXqIqBKrsRaF?=
 =?us-ascii?Q?jrOJxGkt+aQfmWtM+9tJOVve8TZzVTZABL22+ueh+hnJSQLJtrIqILGUWK8F?=
 =?us-ascii?Q?+dOn+laRz9bF/eHnF5B9kNG7aODJYFY39B/d9hTT4eEL79RxC4Am6YIVsrLx?=
 =?us-ascii?Q?+70wIKCExadWTyXWgU0KmVqb8NECKMe0ZuGtfXzMeRBNOJNcotnvafT44s1H?=
 =?us-ascii?Q?w4Kkm9MxjdbjOAzeW6HVrsIY7YBfs971KPmz8J721Ixk0LO/rrWmBMKREWZQ?=
 =?us-ascii?Q?rH050eOU9tBo4q6XLTzN7TnPa4dY4QpORN+tf/dObIn57UoYa2MM78R1+4Es?=
 =?us-ascii?Q?gBNcZbFQK3URsRTXYNRkGh8Zhqy3pvxsOT1cZTPxHMw/KtxBOTkBE7/+zlrh?=
 =?us-ascii?Q?wAM8Eb7taQtUydBY33/8NiyY6Uj/V2Y4TEt9vhE2lXhZxhZBBxlmOmXDPqva?=
 =?us-ascii?Q?PGqeybvYze4dKWCBRsUBOwT1hfFAkkOEwcsDHbDhDsfJs/bvglS5PzEXrjov?=
 =?us-ascii?Q?qVpTY/7l6M18+KJqwVaKH8ppf72AhIbVqyv+Erz+8ET8LZm/R4T6sQYyjGcf?=
 =?us-ascii?Q?kLH71V2sIOwNUjhU88aXXnjDwad8mFtTWPsvFWxyiIrAVH57qSLWp4czDTLt?=
 =?us-ascii?Q?93cwMiFO4vtYCrv+cHIcRRQGP1MfBTH76RSoZzAW2XMF1XxWwgyRBCl01xWY?=
 =?us-ascii?Q?/U0A32+uMV/7yZNQA2i513JbDE/gKq4puqZtmg1FeMGu3Vm4cR24cgI0EnuN?=
 =?us-ascii?Q?qSjQ4AJxeZmhBVdnsgNzkyLLnKeYksXYhgyGTWvHAZsUcDPFxr7d+jtQAqdQ?=
 =?us-ascii?Q?Sk6Id1ls4yE5e08uLTEYWeTUyH5G7NINq6lqSRvzzVdePrqXPtEe+lHd2kEl?=
 =?us-ascii?Q?aDC5DAUVFq2lB5SfgtmB5LtlkS5GWGgfdyk6/xgPnkQlMFEfExMTM9Hvm9AS?=
 =?us-ascii?Q?YAwgRAWJSnpvTcwyG/L5vnLvq3XzKydwV8/2Z1Qsztgtp3bdglVEpeE0uc/z?=
 =?us-ascii?Q?FUJCh3383nGZp/X+BlcPXjZYevAyTDKZuFYPK2sPYqKVU8X/YMARiFoNDNwW?=
 =?us-ascii?Q?ZnpXZv3DkZyfTM3JNsSLmWfRKVpnfRk4bokkiqy3+eKLkGGMFnNt3v/QRWw1?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f9755463-bfc5-48c4-ee7e-08dd3b13a790
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 18:36:15.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mJIjIOv8AA6CNGxmTZptx3qkxE1mNTM6Mbl3CR6cD5qLIHleTNw/2tPSdyHQqvcWm1nHxjhslyzXar81eeY2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6723

On Thu, 16 Jan 2025 13:40:58 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Add read_poll_timeout functions which poll periodically until a
> condition is met or a timeout is reached.
> 
> C's read_poll_timeout (include/linux/iopoll.h) is a complicated macro
> and a simple wrapper for Rust doesn't work. So this implements the
> same functionality in Rust.
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
> core::panic::Location::file() doesn't provide a null-terminated string
> so add __might_sleep_precision() helper function, which takes a
> pointer to a string with its length.
> 
> read_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [1] or a similar tool will be used to check it in the
> future.
> 
> Link: https://rust-for-linux.com/klint [1]
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  include/linux/kernel.h |  2 +
>  kernel/sched/core.c    | 28 +++++++++++---
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/kernel.c  | 13 +++++++
>  rust/kernel/cpu.rs     | 13 +++++++
>  rust/kernel/error.rs   |  1 +
>  rust/kernel/io.rs      |  5 +++
>  rust/kernel/io/poll.rs | 84 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |  2 +
>  9 files changed, 144 insertions(+), 5 deletions(-)
>  create mode 100644 rust/helpers/kernel.c
>  create mode 100644 rust/kernel/cpu.rs
>  create mode 100644 rust/kernel/io.rs
>  create mode 100644 rust/kernel/io/poll.rs
> 
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
> index 000000000000..da8e975d8e50
> --- /dev/null
> +++ b/rust/kernel/io/poll.rs
> @@ -0,0 +1,84 @@
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

I wonder if we can lift the `T: Copy` restriction and have `Cond` take
`&T` instead. I can see this being useful in many cases.

I know that quite often `T` is just an integer so you'd want to pass by
value, but I think almost always `Cond` is a very simple closure so
inlining would take place and they won't make a performance difference.

> +    mut op: Op,
> +    cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Delta,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: Fn(T) -> bool,
> +{
> +    let start = Instant::now();
> +    let sleep = !sleep_delta.is_zero();
> +    let timeout = !timeout_delta.is_zero();
> +
> +    might_sleep(Location::caller());

This should only be called if `timeout` is true?

> +
> +    let val = loop {
> +        let val = op()?;
> +        if cond(val) {
> +            // Unlike the C version, we immediately return.
> +            // We know a condition is met so we don't need to check again.
> +            return Ok(val);
> +        }
> +        if timeout && start.elapsed() > timeout_delta {
> +            // Should we return Err(ETIMEDOUT) here instead of call op() again
> +            // without a sleep between? But we follow the C version. op() could
> +            // take some time so might be worth checking again.
> +            break op()?;

Maybe the reason is `ktime_get` can take some time (due to its use of
seqlock and thus may require retrying?) Although this logic breaks down
when `read_poll_timeout_atomic` also has this extra `op(args)` despite
the condition being trivial.

So I really can't convince myself that this additional `op()` call is
needed. I can't think of any case where this behaviour would be
depended on by a driver, so I'd be tempted just to return ETIMEOUT
straight.

Regardless, even if you decide to keep it, you can hoist the `if
cond(val)` block below up or move the `op()` down, given that this is
the only place to break from the loop without returning.

> +        }
> +        if sleep {
> +            fsleep(sleep_delta);
> +        }
> +        // fsleep() could be busy-wait loop so we always call cpu_relax().
> +        cpu_relax();
> +    };
> +
> +    if cond(val) {
> +        Ok(val)
> +    } else {
> +        Err(ETIMEDOUT)
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


