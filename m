Return-Path: <netdev+bounces-160399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA23A19896
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 19:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879A416B2E8
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4969421576C;
	Wed, 22 Jan 2025 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ZgvH8ZvQ"
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021113.outbound.protection.outlook.com [52.101.100.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850BB215057;
	Wed, 22 Jan 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571124; cv=fail; b=gTI4mayas7LVPfSXohqYNIEoH6nbLsP1gNPmemFj31QfTQ7FlnahIHz97H7VUmJp9RMDW/o81lu2i5N20wrT6QTsREW7D4WR6hPaZPZo8AA4NrofAx87W0PQMYtZF/r+e05ZEZ2WjNUp5KFNWpQixV8DV1g31HsG28ORkdewqSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571124; c=relaxed/simple;
	bh=REAU07lGX8juS5DZKDeLAn6r3jn5qsXZST7m2WWJgLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s10NJBH+GpgbLJcflBxoIW8/4jMInHELbXcYKBnrIM120yB5uEZzgqA3YCF/vQdPuvTt/XPIct4hWcZVyaiWA3zNwnTkaiYwG+TuPZAP09jQJy2Ei6sZMKF8yzNyHgEVzh+ZfgS/bjIXroiVJzyts1oCfkm5sMgnUkBVfgAShOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZgvH8ZvQ; arc=fail smtp.client-ip=52.101.100.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYeZHNv0FEZAQtH9ASsq7gDiYhmmYubZqZSG+XPq4hrMxioetF7wHB3LEm98umx38IMRf7o+pqQ39CxZAgUMgbHWxUpbs1LcTGb4oHEObmD7inRgoknkgAVQLP90gGQEHbeJCbDEmiqyrwhCZKo8ky07rDzg//dkozNGrDm3yIvBmHwMGs6QzPHnPEUFS/dUdkKPcCFxtDX2r1gPuIUotHa4UwjOotPNMvV5fCXhccRKVjjtwHXy0Z2geqBvvr1n6IdNI/JIKHXdZ5OwzmLam4Na4Zna71y4c7h6ZfmfGLAngAnBfNAkTLCrWrlqeQy/S1IsLr48KZ1+uswc0nJYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxBjZhcQJRs8X/9wYPFHigUK1WQUHDV+/l4CSF4gpGA=;
 b=P9+gGc7GE3PyScT3jobiyRYmKfRGYUzJm+JsdMT9E5b9zh4mhB5wCilDiOAX1A1RVye4KBFbz0qr3pG8pz8VcQ7ujCjzneF3aTd6ACfcDYHzXGTFGqMls8bXRuXx3kn1gUG0vH+vFRSnO2y6QutbvXcHdC1Z2TD5Qo0C8zlzV790k2mCdcNjGsEnC8f2XCFWbqk4n4yquzIvSHKVyY7jf/IR6d+MWmSnrLeDeuBXQDiLbWWUJduy5cW/LjWClwMQr7NsAN8TSPCB6ROBRQHz+iH6vQgbqJosJIe5nhbhC9KhxXKBhmqXUvGUsonQzTw8N7abJsbZs1E5rXxE4Pl+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxBjZhcQJRs8X/9wYPFHigUK1WQUHDV+/l4CSF4gpGA=;
 b=ZgvH8ZvQ4i7OxT/+KMhd4/Uah2Fkcm5U2c3WhHUPT2j4dhXbvqvoJ0h7qcIYHt6HxrLyWJRXRGQF4yboymr8AfKKbS3ZHEcp8EgH1dZ+OxYJxx3HeEdkUwJhrYwRhBKQ0lO0d70AyR/NoRoxNFNXgO07Gl9i6fNsYlYcOFLNmEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB3183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Wed, 22 Jan
 2025 18:38:40 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 18:38:40 +0000
Date: Wed, 22 Jan 2025 18:38:37 +0000
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, Alice
 Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
 sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 1/7] rust: time: Add PartialEq/Eq/PartialOrd/Ord
 trait to Ktime
Message-ID: <20250122183837.79ad9dcf.gary@garyguo.net>
In-Reply-To: <20250116044100.80679-2-fujita.tomonori@gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
	<20250116044100.80679-2-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0083.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB3183:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef88b70-1461-4d99-5291-08dd3b13fda1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3hnc0aN+4cOjsizAUJbgC5mcsw2NCk0t0NEu6jNhNU4Mp0/jOSCxTBRS4j1x?=
 =?us-ascii?Q?OZwDErtUpLlhRbsKvh1KWoegbcYScsbjztjzjSZaSraxwQWYB9MI4GMjMjh0?=
 =?us-ascii?Q?AlFCXfnHiHpf1UYtUCCK8O0FRk82SY66KizwrFfZ9guxtlJYAxOSp9ZJSaAh?=
 =?us-ascii?Q?xabvU220cAEkg7Z7g0CPyvbD2mgFxWEPeReKYQa6vHjcPTJ+zp6NxvcRdrxA?=
 =?us-ascii?Q?1Vs6wu0ewQEWMqgP9X9UWGTcg/D4loZd5ZO0BAeZXGTF+x7f7rrBDsmo1rN7?=
 =?us-ascii?Q?nTRoJ7Zt7GNVMY80MWDem0dl+0VJLvJBXKveDajBZ46SXGQEkNPKIJ/V2jS8?=
 =?us-ascii?Q?8ICQpC/i1kIHTNscG+E/GvDjjMGrlC9/fGYrkDKpRh0PyL2wGAszkS6IlKve?=
 =?us-ascii?Q?H2OuSQt1V31eaCHpZb3lM9m55eXShYlWnL7CQdMpujfmsbBQTzvSdCJIhg38?=
 =?us-ascii?Q?rJXEs2hteWtQCmRFIT+0SU2iQGF3hDVKDNgzlNpZmczHyDg4ZvsswqVBl4X7?=
 =?us-ascii?Q?0Fk+4q/d6noHXFp8y3z36kZOwCFPxF1z7IRxFNh0idajopmddTwlBeao1aeg?=
 =?us-ascii?Q?ItKkmMbV73z+6T60IbtcybkQzUwH52LgKoHY+CuJpgBM0FKUXC1Bykk3GXlb?=
 =?us-ascii?Q?/kBrZF8a1DHPHRngKofiFZMWUDpBoWHhilBXqjZOVLsJSWOJDTt/SObLn/Nb?=
 =?us-ascii?Q?2MidfYzl+xNqT8wgXfkJ2Chfiac5rEYFvKW/6c5k8PbWIOejdDrMNvqCJhKH?=
 =?us-ascii?Q?Qx7Jn0285Ru7mz6f2BLMOX7A3EOobFSeTqd/DZxB6n2qYYt+iFacX7xYM2+g?=
 =?us-ascii?Q?jp4r44KcG7ZQB46eTzk4RnCCU5+DQRlf1RcW2Ogj9/YZiKZJdj9aPFE1A+q2?=
 =?us-ascii?Q?l5PYnOjAIK+W6aPVrYCl2rlxB9Cx/SiSJYowqKSOsEUbbLyrYbrsyucCnjOM?=
 =?us-ascii?Q?EmxXniTd6FS/O8ZXkR5ecwFAMNSzOhDt5mKO914ykUSFv6dE5Hm/Vn8rZZxR?=
 =?us-ascii?Q?5kn++3lAxgxxobavw++nvxcZch5w9sAeyhxcV3HkzbTvEEfW3jNAmJgyn8/C?=
 =?us-ascii?Q?pO2VyzfsghEdIVWIzL9YaXkJumrFubLlvgg76M5tbeYnL6dPhflvUmz/SBa0?=
 =?us-ascii?Q?E7lTnnVQLwOhE30VFN/T5iZVyCMIKoP+TLw0MO8ZYNlkNfV39hqQ3B9Yllvv?=
 =?us-ascii?Q?4AbxkHckLKz8HuZwj1rTdvQLpD6wsuM3QEf63JQAyWSiLflYtQefyURgdWkN?=
 =?us-ascii?Q?u0MawXBOsucAFQsJDMW86XOZNtjsHIW2Z0NaahC6zNxgVcEmBmevEjIq8kyl?=
 =?us-ascii?Q?iKqJPJRYGArBu7R+Uj3S2RYDaaesig74uCNHIeUJZmoDNxKW8jTa8Ae4N4CJ?=
 =?us-ascii?Q?XegiCYIlOM40F7T+dAyiIbNqiNnt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xI3k8FQ1SVtA4DSpBFbyoYnStuI77THDji+vmzskht2ucsmYdigByyTbq4+Q?=
 =?us-ascii?Q?MkccMs5R5XquC3tB3hyhbGbJSyumcPoQTKlWaant6FGCLs0uUTQK3Dd9305R?=
 =?us-ascii?Q?m0ctwllR9U+5qZuNEuw+yPe8SuW2do9bqgN0azC6dcbE8RexnAhE6Xlz/CaY?=
 =?us-ascii?Q?dViQJwPGAZQYoYzg48P9/1XT8VXhm/n0bVpJl9h9xm60RfyByD7pA1+VmFY6?=
 =?us-ascii?Q?VZVGFdUtgIoCV2yT4pJo+xE8Ju6P5eCRI1Qf156sNF27TU9hCx2OsPBu0l6f?=
 =?us-ascii?Q?rp9uxKKbkRXVKy86tsnjPVqdWwWb8QZGsgeQ9SJrFVLk7aWfMUu/K+DKPnYH?=
 =?us-ascii?Q?58y25J8jEf3Y+LlHcCondrarvtkBD2RIuV9DBEYLksOCaTSEW/PKY/wUYGXU?=
 =?us-ascii?Q?u2AbL9eF4Y7iZ+GRzpmuZNayC7rdpLmBI7R5PKdFK04t+1smn5IJ3TfFHoFX?=
 =?us-ascii?Q?kd45qC230unr41DZvdi04+/T2A5+2XntVOCm4hdwlEgWfXCXZzU6dnGuIx+d?=
 =?us-ascii?Q?Jg8EHPG7H8CzWsbvxh9KG7TCKfRHNhiKRhYiCuGYAoC0rSYRsFsLlRWm03Pa?=
 =?us-ascii?Q?f0mJPpQgVhlgBZzulpbGCtzH1cmXkSshQVggaYAY5/Br/r4t7eKzV2SWUdNg?=
 =?us-ascii?Q?AfK9Zny7ElnB1ygT12BjQHIeLD9732cfCvq28lQetCabHV3wmcX3sfZisiTI?=
 =?us-ascii?Q?u1HZJlNiy6g97Wd4s5S74j3RfMaJk4HWZ8JUhOnxeLeZ3mLNh7pqImK36ZQ3?=
 =?us-ascii?Q?xw9h2I3+UWclXYP7v8aTD0d85NI6x1IMAFDk8eu1kywzIG9citu0zyFQo28W?=
 =?us-ascii?Q?fFzY0ATARS8Lw8j+OzuUfFmoiGCtrpGgX1u4kL9NpCjbcMhkYwTPo+pFGie7?=
 =?us-ascii?Q?I/obpaY46cIQFD9sXXAiPxT4FodKkJhBTMRLnJ5IjL89pzl7PB0a/bO3AqiZ?=
 =?us-ascii?Q?B1hVZx+pQO4GHfqpDCgwKBNB3i3gf1MHS7O3OVzx7v0MREJR/QyQDn/x3pFz?=
 =?us-ascii?Q?z4+q9OCaEnpFG2sBzLa3NO9OLVA6slnh6dKizOCRZnjUj/aAZnkR75X1McUy?=
 =?us-ascii?Q?cBG6M6Vyxcg6CTk94HduzwtWr7+Y6jrhXgMfJavthNdChzhvj+OTZ8w7piiM?=
 =?us-ascii?Q?WUay8rKnHjDxtGJKZL5+LmqkLxMl+Qpabl4BUp/809AMs/4ylBAnn7KPubXf?=
 =?us-ascii?Q?S+e7HBgI8CJ/a3gl0O9kC1BuRj/0XycTlZFFfCNmGA8RgMSqXSnONdkOCktb?=
 =?us-ascii?Q?ULyS7HBbNuhUoVEskWIWBzARrMVEP9XNqsfOkbbh+w94MHVomX5AqbZAvxn8?=
 =?us-ascii?Q?+PnHkrfPKG0letEq+INjPdCHGPArfdarcMouuR5uTmp0CSvp0YUUGDZkd6K2?=
 =?us-ascii?Q?lhES61nl3z9GNluWV8oSiHdjtZ1pEn7OD5+9OZ2BfofcKwiInpo83/XFrvCy?=
 =?us-ascii?Q?Jbccgx7HEsXAjt8Q8oMZBdCSU5fhK35Bk1cAR79XsSTNh11Nqzbw/xgSdRxn?=
 =?us-ascii?Q?JlgEzHCd0Oc8OsEo/B1OyBoZUkLoLCIo0f7Z4ggqMlU+LPYyog0Or0QOWi22?=
 =?us-ascii?Q?GTcj+qwycv3FTfxV47G83I3/OMByyQjNA3ALGlg7e2qyadEsM6WFwpII3n6w?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef88b70-1461-4d99-5291-08dd3b13fda1
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 18:38:40.3390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMTB193sgQEbJMDY64+yfAw0B3nHobnh4oEMosC4uQi1loHmU3Igd3NRlfXtxS6tj9Ugmw9HieOqy+4aoUMpAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3183

On Thu, 16 Jan 2025 13:40:53 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Add PartialEq/Eq/PartialOrd/Ord trait to Ktime so two Ktime instances
> can be compared to determine whether a timeout is met or not.
> 
> Use the derive implements; we directly touch C's ktime_t rather than
> using the C's accessors because it is more efficient and we already do
> in the existing code (Ktime::sub).
> 
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/time.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 379c0f5772e5..48b71e6641ce 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -27,7 +27,7 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
>  
>  /// A Rust wrapper around a `ktime_t`.
>  #[repr(transparent)]
> -#[derive(Copy, Clone)]
> +#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
>  pub struct Ktime {
>      inner: bindings::ktime_t,
>  }


