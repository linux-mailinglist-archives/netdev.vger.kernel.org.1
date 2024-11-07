Return-Path: <netdev+bounces-142796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9209C062A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE94D2846D4
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E2720F5C8;
	Thu,  7 Nov 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="EajvfmCR"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DE71F4267;
	Thu,  7 Nov 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983826; cv=fail; b=CmikNxgxTOxDzQnofupQj/s+f9DUDpcRa0XNxG2F2K/Kp78hV6sZkqKBgv2nGj6snRRZWoGC263+rkTq7vKHwNm1rQPqWftG1b8aKSiecymdCQ0Y4DmU3V5PZWrFiq5rdbiQvJ9p99spNe0HIsWbewALceRt0AKjY4NX12Pexww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983826; c=relaxed/simple;
	bh=xIllkFyL92umJQ/VkFkf0DckECSGAn6bWH/563LsidI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=LCv0LICLUS4uhgt6pJCIQKZO53DXpQvtT1tG9FxJQgAyjswkT9OTIdIm/prmUiYI6H/fI9+BW/hl3DrjzeIa662Dh6FyCayo3sG2fj0f+EhzXmU8aC1Nl/YnSniE8TSc5/ZBqOE2YyLH61hVQAPsyJC2mdp35r/gyTDG/9gycuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=EajvfmCR; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbN+5nN/XcejYmLDMDkmLCbI4rI8SfJ06Iy19PusItyYsXaGODkoN09PiixaS/6TdRi612FD7TcfIY4mbzAOyQB5j60P6c9fujKksS0PfHWyyC/iUrKKVm3xweHeo00ah7/v6k63hK2A+BJzX4VHSsqWh2XAI4BSvuTT65xC29GE3g+pipjF2O8jK6aSU4OTG0hw4CDmkolbgELIAHZwgsUem5iEMommk5Hm7Jj/JAH46H1LQlmIiTh4jX88T/rxLvNW+XkLVajjXmxv9hsOnBZ8Caer2EFAS9DPVntSw6MlkQPzCL8OVCHVPPlEnZilcOL9MJ0W3D9uEpAyBg07Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIllkFyL92umJQ/VkFkf0DckECSGAn6bWH/563LsidI=;
 b=MeAs76fFvHgrIRzHhyLOvGKvAjGTNfSJB5PfIX4XWkT/quduLAcc7LJrEKOq+pENgJZoHgW8/KDQRO409yW6Wc4umMXOuFIfqbHqM3rUxEcjPjLEQXjF2nz4PuKB0yZTkPSLK8Dgk8ks8AEcRvOGkNeup2a3PBy1QCSjnrn0uyshsa8D18TKMnhrFJYt1n6uf+ffFdsVgEDmt78gJkFJ3Mup4w30YSsnVQB63/7/0zLO4bRPl57hL5BpqfdcPHTH6ewDvsXDMWwmI6UAO/PL2ayfA2qbEi87wu09QqQQ4A5E2DtN+9wf5bR11rajRaFRt5mtGnTOViKNa3Crw6cG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIllkFyL92umJQ/VkFkf0DckECSGAn6bWH/563LsidI=;
 b=EajvfmCREJJyHzf+sqZG+KUQo+vjBMXykq+QxlNgUY8KY6l8pp7xOXhix+DN5w9UZf1w0UWDKsX3WnsZY6+UDjdE+XdBhsPBtXSIYSCyi+LxQUBPCb+P74/T4Gsz0biEU0aPakgxFS8Xpr9cyzryk7pOOfWnxcLM3GsfK0Kmxz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by DU0PR10MB6977.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:415::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 12:50:17 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 12:50:17 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de,  frederic@kernel.org,  tglx@linutronix.de,
  jstultz@google.com,  sboyd@kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  rust-for-linux@vger.kernel.org,  andrew@lunn.ch,
  hkallweit1@gmail.com,  tmgross@umich.edu,  ojeda@kernel.org,
  alex.gaynor@gmail.com,  gary@garyguo.net,  bjorn3_gh@protonmail.com,
  benno.lossin@proton.me,  a.hindborg@samsung.com,  aliceryhl@google.com,
  arnd@arndb.de
Subject: Re: [PATCH v5 6/7] rust: Add read_poll_timeout functions
In-Reply-To: <20241101010121.69221-7-fujita.tomonori@gmail.com> (FUJITA
	Tomonori's message of "Fri, 1 Nov 2024 10:01:20 +0900")
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
	<20241101010121.69221-7-fujita.tomonori@gmail.com>
Date: Thu, 07 Nov 2024 13:50:23 +0100
Message-ID: <874j4jgqcw.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|DU0PR10MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4e9f3b-d568-4993-8f60-08dcff2abb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OQKy2AnxsB8ilNGEH8YyazOBNCtUqT8lomHSgijpQ8ANn97hnGOAFedUyLug?=
 =?us-ascii?Q?eqdTMupvm8U42JXzjiGqKOyeY7kQ5GOk9B7f5iPruWZK/r5jeBB2omDT28Mm?=
 =?us-ascii?Q?BH1dFU9hHp0I8Yvm6Fvbnq53R3B2ikMheBdmCglKjCg9qvv3xx2xz2s/ZAhX?=
 =?us-ascii?Q?rVBDBgNdTh34Pp6GOXY+4gMdr/JTl4OcGn1NrBOE2kMKQmX1Rs1DlH0BcMmW?=
 =?us-ascii?Q?/9uSfR/gtYvegwKbI4hEy3OWFkTFKfi3rVHKIcnRABLpjq6qzwwQipKIWHL3?=
 =?us-ascii?Q?hCqjwdHDgikd2Kc7M+cqiwlk0TGtFRDHV57l68Lwiibb1wwt/MgExtKgIXFg?=
 =?us-ascii?Q?XK631VkFqKRhJbf0/4F/yaA9UGi3Rz9RF4TM0Dcy3WI/JaA7yBHuslP/14ck?=
 =?us-ascii?Q?iY2zfBwss/8DYYASTt+bmiaSjsw7+sqghmABT9tDd1muGqgppF++zaEqOpnw?=
 =?us-ascii?Q?HZurt05puqOpnz1NP6reTkk2bXFavklaedGKpmA6K0YasmfpqC6fYC5sNAMP?=
 =?us-ascii?Q?3rhWdylVVaQmstdxOYfHTFbwinICxGEinQMkNBkCoTb9nTdT5XPoS9rqzik1?=
 =?us-ascii?Q?kjvARH386C4GG4NGj+k/JDcyhBYzhvU0T64EwZ00DoVx7TIh7RgxD1gPldnP?=
 =?us-ascii?Q?UMchsW/Jh0AHoRdoZCm3XEqnuBbdbLHpfMXMRnicAmPvt6KDhL78MmmCHkWz?=
 =?us-ascii?Q?qA3TecnczA1QDN4iHH6/tsAspnq2eeHX36GlSp3FTkN9um4bUQe5TAFWGpqc?=
 =?us-ascii?Q?4uz/6i9Gc+EDmJhba7yuqFXOZhRgNaQAu7OlP/1IwsQB4UHdYa9wO4DO5Gmv?=
 =?us-ascii?Q?ckHoocx7r8XNkNnmCr/ctcj9hVEUKM9kMcC0tyxEn6VC1DHycWvF6GnmTE7b?=
 =?us-ascii?Q?zrHyLQ2WVzevTXKpIGe3AmuUQiDy2xKPZVDIZed3NwkQfpeA72WIfGkNQpqe?=
 =?us-ascii?Q?IQ0CpzhXgXqWWDxTB0nfOiPgxJoTZHkfJefkCUjhgtuwhb2izumutEq6E1vP?=
 =?us-ascii?Q?G/niEVKG5bqMRQ8sqibuizOxis2f8gOuavzNhEcQJsp3kyVuISn7xw1sLmzO?=
 =?us-ascii?Q?bYLOcY7pswXgKJOtmloPwwZhCBJQbrBkMnPSthw161mem8vD3oqyAs55PtlR?=
 =?us-ascii?Q?MK2s1fIW+yImXqTfig9zVIkqrIxiA0DzAa+J4e8cc6Jq7TUvQRgs+DG08iTc?=
 =?us-ascii?Q?S24XIkH6u8LXbueYyWR0AcGnU/+/pgIoUUVgtkyvx3DiN5uWoOjsQRR6MsJt?=
 =?us-ascii?Q?LdoBmhI22dpB8F3+Tf+qpYynFPeMEGsioXBId7b2wU8vBHwMz5EvGHO+rSWa?=
 =?us-ascii?Q?Z9khSPCLIMJuaiAnSOYYd7PAsX9vn2nQTOxZs0GMg/AcL5xPyRA8tT8vfhY3?=
 =?us-ascii?Q?Zr+dhuk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EyIR4tqKaWJUeWaFF426K0HnOXlfXwbDJAUOMzKOhOi/NsNIyBcmsjsVapxD?=
 =?us-ascii?Q?3rGB9nbEzlxxkNG26PSyHucLfFw7uC+9n3bKiywoCVRgqbYkOyUbcLbYhjVD?=
 =?us-ascii?Q?taTDQb5WSQHxMi44+V5ciiU0wMSx8l0S16kYM32HtEbdfzr5c5EGwWT/QhOW?=
 =?us-ascii?Q?KZXIqv7BAdYAa2J8vebrQ27hwIkUqMsyrKNnaZKZzgNBCzjNIQKG8zzF4xhz?=
 =?us-ascii?Q?3WXxvFpohIxiu48jlvJGiIc4UEdWdMBNumqdzFVYPErupgTa5y04Ut5G03jV?=
 =?us-ascii?Q?e8fD8IlN1+tm75uZrXzwn5AFlrqMLqK6KOzjrS5zzbAqAYgImsrleOZDjW+7?=
 =?us-ascii?Q?bgbYre4PTCEdWcKnqYbO7R/tH6d+J11Vc6Chg0XCdoh7F9dOlJ9HvlgNWjdx?=
 =?us-ascii?Q?ENNfqbCS75QUMKfljVhtn+YTLL/aGzIlvOBGN+OlBEvcE7D5cEIctiGvULP4?=
 =?us-ascii?Q?0OWiLzPdNmon30px+jUGXZzU1WLwpdrupG6fBsdD3FjDlrPbW45P0dnrQGcO?=
 =?us-ascii?Q?kBKPRgrUTxVjPt6yIdEXfI1DAkr4W6UGuCsf5a9Cyo/xqo+FXgFT/2EtZedV?=
 =?us-ascii?Q?fy7rXTlo71p2vZ5g0lUWavF7hLKDdgP6RSnSE5ZCjsJ0ygFzQ7WL1IYJflYV?=
 =?us-ascii?Q?B+Se1X5tRLC3rpf/FMie3DEWy1pUgO1VbY7ikuoWJ7ADbXSXgQB4bbygMC2s?=
 =?us-ascii?Q?mM8lzBQAyhF6qxkZS8U5QxuePYaKb33PAL3eX4zyuLc8WSj/20qbf/P3/4wQ?=
 =?us-ascii?Q?TcSkhXgbZiKEOlSQCFpPX8PxttJxCMTOLsUAZOPjUTJpVgI796Wo7NOj0zD/?=
 =?us-ascii?Q?k3Z5vmoDXGbrAYkB8LMV65T3pHJnpidhD26AXoKIYqwwYH0frlkmyycOdIE3?=
 =?us-ascii?Q?rPymMG5WCWMmf/8/JhUlLMZLPzeQYgkwfKbABuXUQWkfAazwxI/aKa50CqZu?=
 =?us-ascii?Q?Tyy9dIMPLilZaGriZN1EOFxRgEaZa3C8DTEg5o7I5fBtIM5wPpYrmgHWmskn?=
 =?us-ascii?Q?4Av+5M0laB+cMhU4xmy2eBcD5+kKCi5FfoMAPaSHLj537gVNqL+Q73jnEgcT?=
 =?us-ascii?Q?BRzYD+gZniqot3EcrD63vTzVPtoRPXlxxyYRC34oToLjNaeWoZ3EwD9ccvft?=
 =?us-ascii?Q?fwP/hNVwKxuRiJQljjLmBDcSMdRy7Zy+3CbumWvbWJ3LQNIctE9t/ifwk6y8?=
 =?us-ascii?Q?Vfg7myE7dggstinjO6IqvqKBlZYwOdoceJMgMdFY69jWMY+LPgUmGqI0jIhi?=
 =?us-ascii?Q?gEWEay736i6MIcfceH8mSP8kTWs5b6vg/W97mGZgN+rwZnAdLjeN3C76jV6C?=
 =?us-ascii?Q?s47K2QervvNAFSQp07lw2vfFYl80m/zdNDToKzwrSeFaJs2WMqBarQHwOyIx?=
 =?us-ascii?Q?wRXxShiUF+v5e9FfaQgfHKw+WtirvgNSC8ZDvt18FxtLNSmICXtYloNIptFe?=
 =?us-ascii?Q?MZN1bWdH+PFkEFlwqKZ2ZNE9/CNiUDeyJMM3FvaX5kvW5/R/vjctdyCHU3RF?=
 =?us-ascii?Q?uo1tPpm2VLfRov4Z8Sh0dNDq4xwewPGaPRVN0NF+w3sLlblWSklNfOi7Voqk?=
 =?us-ascii?Q?AZTcfern8gKgXjo2hK7mf76OXlb9HqVw2x5hPU74IP0lVkxTOayVG6ullLdL?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4e9f3b-d568-4993-8f60-08dcff2abb02
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 12:50:17.4183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/dI0RPldT5dgZW9J9j+XNAZ87hDuu7aysAY7cvKTvoWgU1N1BCCw6e/R5JF7mucHBrWpNgIZ21v9AL02jjV39PmbGRz5GZTxeHmmHpoekE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6977

On Fri, Nov 01 2024, FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> For the proper debug info, readx_poll_timeout() and __might_sleep()
> are implemented as a macro. We could implement them as a normal
> function if there is a clean way to get a null-terminated string
> without allocation from core::panic::Location::file().

Would it be too much to hope for either a compiler flag or simply
default behaviour for having the backing, static store of the file!()
&str being guaranteed to be followed by a nul character? (Of course that
nul should not be counted in the slice's length). That would in general
increase interop with C code.

This is hardly the last place where Rust code would pass
Location::file() into C, and having to pass that as a (ptr,len) pair
always and updating the receiving C code to use %.*s seems like an
uphill battle, especially when the C code passes the const char* pointer
through a few layers before it is finally passed to a printf-like
function.

And creating the nul-terminated strings with c_str! needlessly doubles
the storage needed for the file names (unless the rust compiler is smart
enough to then re-use the c_str result for the backing store of the
file!() &str).

Rasmus

