Return-Path: <netdev+bounces-164484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80BEA2DF14
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 17:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66FC188682E
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CEF1DE3BA;
	Sun,  9 Feb 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LkG8Fqpb"
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020138.outbound.protection.outlook.com [52.101.195.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BC3250F8;
	Sun,  9 Feb 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739118058; cv=fail; b=WClXxaYo8+6dB6Evm1mCCgRRiZrhIHnZEP17NKWIWjOfB37al9gJVLPqid6uAJz7uj6I54FAGTLTcRBulvCF2+PfbZR15dZpPOnOowpSflFijH/btsBNhZR+eXCcW9K3o/uz8HiEW98cYEO3Z4q4TazzTixJfwAgO/NMWpkT12Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739118058; c=relaxed/simple;
	bh=i6fgLCBC2f+0Dr2IoMGcrXOWm7gffwi3SXd4cyZbDRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fL0RQMHQ0e7gJ2and97J2dF5HTcb9/F9q3BLq4MHCszDrRiZ4FZierVXyI+3zN2/mQYjxF4hq2AhwsdzYCnDVz89hWyD0AcVqb48a/AoZzfDCIUxsV2S5FAK7uiczjeHMt8VdA/evoVnCcT2dMuUASIiRxWgUid4HGaM308GHOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LkG8Fqpb; arc=fail smtp.client-ip=52.101.195.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytyktF7rTTcVd1hJCYmbwExBsVJr5Mo0V/gPld3rcmJQwTfjfljcJ4REJ6co9GYUsPvpSzRxjPGBhKExhC6QSdUE9yIi1ZYvPY+mH/aIMpX0Hfmf8CHIXLJLNMo9+dP3+liePeEBrmlc/f6iSKaZkp4t50yT6MpaEm1sVTW8GaLSsbqfISZe4Sx5XAxfeoOcn7CNDBzawWlqiajnP0CYhElybGO9/lACyPPCKqgfCJwN7mKbdBsfhxvHktGliLrzRJ7vzxnU9dbPr3sOlBZzb29r88Ew0DdnJBZrVfyDKpoT109Hxsc7+txRSgCw6kiH0d0rywcl8xBoNkw10cdvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VffbfcDm79DKlMBkcS5HapqG3f12ysPK1meD2t0HheY=;
 b=iwDWXVkgImuK59k6QMBAbuHJi9r6SXFdAffNPMqctpL24CaqX9FpW4BAj5eebPcr97UhSFiupheJC0Y7PGzRiAP85N9BnW/Bu7XXzPjCc1Bv5ocBh8mL/zq7Vms3PDgJv1PNM8zHFTHZiAj5g7z+bMSFPYzAT6zPpQJh7N0zLbmo3mCvRrl2txcASrnEnVWFX1+bh2sE2WwkDWcu53/dZBwenSLYcIUtx3YBbc1MqTiQFMzOhvZmf8Hn0JIox6mbwV8SsfyYVIzqi9YqN1K3UH6eB01Omzecykc2fvMAZ+i6/5I+56t5BdSKy8X88AyTvhtK4R2LGnK+B5D5lUsxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VffbfcDm79DKlMBkcS5HapqG3f12ysPK1meD2t0HheY=;
 b=LkG8Fqpb4B+3II4idPMalAsR2eb4aFMgVxqtfKpHJB3KGeOoFv+bmX1n7mcsthEMU3P0xOe2KXe2/LD0zog9JYvYTlp6g3nDprtk6XKVd1HLDPCtYoBDqyNaL5YofeaTjQsQ1Jjcpt+z02Mz2p09+OgZ2F4mLmKGtFFp37JgYIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB7078.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 16:20:51 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 16:20:51 +0000
Date: Sun, 9 Feb 2025 16:20:48 +0000
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
Message-ID: <20250209162048.3f18eebd.gary@garyguo.net>
In-Reply-To: <20250207132623.168854-8-fujita.tomonori@gmail.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
	<20250207132623.168854-8-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0273.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: eb43039b-13eb-4ee0-a939-08dd4925b8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0m/s/M71yVA3klMpLDP0eVD/EUqIkwGW6jvUrl4HZ2kY+IR97FJZncHfPxVe?=
 =?us-ascii?Q?4LFmIALkHi+usjRXMjRLqW3wSaSoV2sBA2BKimw4kf+66G9aGvJTJXTpb0Gc?=
 =?us-ascii?Q?WJ8sw5r9yYgDeI/bGT9Ux0rJmAkPbyKxx6caM//yWFwgp/ADXYISlDOsMDzH?=
 =?us-ascii?Q?ICuz9lAAK4XxkE4JgyoiO298fMi/erV5/H+ToeHvRZiOrgX1ROFFYMcp3eza?=
 =?us-ascii?Q?17zb1s04E3BARjvFROKViajgehd+qSHr+qJ44pDaBBvbBS+GFSzdlAtYOYEi?=
 =?us-ascii?Q?mI1pgWr9lfW0Mh86adFlWf/OieNQ/eGQ4XbGks79fpCWL7jcNd7PwADBc/rI?=
 =?us-ascii?Q?ZtUw6H/3ol39/u2HV4JV9Qo4pfYmNEDgH/dFE5ePmsfwtiUoO2S9Uz+6TQCJ?=
 =?us-ascii?Q?OgEmdwV9ZAOs/xBfptzQWI5iyGW7DMYSoQ+OWUQf+CTC3Q79i/wFob7tpHDC?=
 =?us-ascii?Q?uLZEKBpagkc9qU9gLGBCBZBBT+DA24Z0Q5m96bcZSLYIvve8wlcdcAt4gNuD?=
 =?us-ascii?Q?p/2kiz9fZxJZZy4DNnkzckTRhZqG1exPuWddflp+okeScOmHZC9XDGQMqZJP?=
 =?us-ascii?Q?ERi4EZuZ9oCFesHOBXxEb5BpLgbuUHPIa5YaW+CsBdyJSe3I9rDD5s7MP5eY?=
 =?us-ascii?Q?C29eMeQ7Ss0NzJOXPBiO7xZ6GZZGK2qZt7p1Jt+JQfVVsoQpSzH44TZtaAFD?=
 =?us-ascii?Q?A43aJ/6XXbPiMrO4dvYlS27N3FpUF2hffOWAURnDffvbcLVr1exROjzMsepx?=
 =?us-ascii?Q?yjJVpU+UUvyBwO6/xW6vLA39S4tfdYVKalaMdPjFPd3Sc1BSPM+uivpQe4a8?=
 =?us-ascii?Q?TKVb0WtKcVzFs9oDHfrv7VJZGNjOzFTh8juFNilgdU/WuqgzRyRtHyFvOEWx?=
 =?us-ascii?Q?a3wyqW34amkZwRQjMU+WpgXdNgZI6ookqjoDoLAx+cwBAEFV/4NZKlWLHMuE?=
 =?us-ascii?Q?XWjwGHo4kWhfUV8OG+6EsI2J6ZvN4kt/bwTraMSBbRKjgwrsx7lvNWjE4kIx?=
 =?us-ascii?Q?uzD5Oobs6kdoajxnbPveCR9beTCU+3GOVUR5oy/Ugdl2ZZgRcyeNr2k3gOc3?=
 =?us-ascii?Q?o1+jVVeC1AInQ2WgwkXhHlGlJpNTbKbALOyKXMuDlRMgPr9t1HnipWJDVNrI?=
 =?us-ascii?Q?fQ9LHbkDJ2Z6KJe2w+0QqGVNR8o4WYu5CaYkjuLn79znrUBCG/RfhqH5Kukf?=
 =?us-ascii?Q?unT8m/Paj3magRfsazsmMDK8HPPFkM06qrKW/AgIv6wEBv8k2VTNhZ08coyJ?=
 =?us-ascii?Q?UBMKm2su4pIO4J8fIHUaN3g6Yy6hXowaNWOFTdnOwQ5C0XgjZKhUDAof2wZb?=
 =?us-ascii?Q?NskQnLza6To4+0j1Y6cK9EN+0yMKfld1Jf64qc5V3SbwYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jedUDO3o54vX/n6Wcbhz88FaaLxRrbUH6JDyGqqaUnS9Hr+WCLbPOVE78DjI?=
 =?us-ascii?Q?Lktvcmiaqg2wXcU7evt06AImYuruDQZ2e5aHzlJrMfQYk3C+UH6WonFEErMw?=
 =?us-ascii?Q?6o5/B5hYyrFQjJAim1s1F6VL37MsGWtOpMdxSd72c4b172A1vNOH9uKofVUB?=
 =?us-ascii?Q?dwqbxWlwFnWtriF1ITU0WOQal7dMVU806sNhxxy3ZVfuz4yrkiGIcZQccnRa?=
 =?us-ascii?Q?n7l4V4FT/nT16j/6Avy6l4ARpiMlCa0AEofJgpTLXJ4EEXay8k49ddPYuJoj?=
 =?us-ascii?Q?hlFra+dJlBYqRGS8CHUER+4tCbim8l7XpPeiauM99e0yuHcIcGMzsmyc/nT5?=
 =?us-ascii?Q?6da1YCHEoVsl/NfjEaJa8/Hx3PWpb9IEj0kjn3imMOLTD10l3ZQlr5FONRi4?=
 =?us-ascii?Q?g01LKzuMrV5dG3eOQikbfumf3f+biARAhOKYUdVFWlm4eTY2A7ZdA/3hzCuX?=
 =?us-ascii?Q?X604SqMH+wchh9C31R4GPQkcH2uspql0mKHm1sgeG2OtZ00sn5B9JtlqM//r?=
 =?us-ascii?Q?UtVPAm0gZj003gJzeImhVedvZ1lLzekty/x7ZYHx8zpHlsOZTXH8p+nqNsZZ?=
 =?us-ascii?Q?cANsVXV4JGNsEMhJ4ZR2bc0xdL1opkEQw5il/c1z5q6ijGTsleZFVqvgcIik?=
 =?us-ascii?Q?xGrWKnn1abJVFX49YFZQ5U0ULun8oXwpwX+aTgk/1CxwHWy6HMOzEyLmDum4?=
 =?us-ascii?Q?BogMganwXXdgjDWjJLMJaxob55yj5DOk6xWRmWxyx02Cg1H1eN3FVjC5zkT7?=
 =?us-ascii?Q?IOwUkwdLVJk6KM/2L6V8Upq2jbzR4qT11Rqo4IWeFahnnXFDWQkXOJu1Niiq?=
 =?us-ascii?Q?LSEGIL8buxZmRqhf7tAyx2Ss2NzWRKPp8fzdN2eQ3bBjIgBEVwgKZMqrkjzo?=
 =?us-ascii?Q?Hq8DXqU58jv7fEoxfiPqBMI3SXRWRkSJpbiFCLdJ9jftel4RjmMEa3N/OwbU?=
 =?us-ascii?Q?pau8F1WMZfXPPj40JPJUoMZ74fdl6TzUULDaeNK8YbVw3DqkoWdZxr1WFXG9?=
 =?us-ascii?Q?BeQ8nT73heSsbF2r17P3ZUUls3J0HLu/NdMaGZE3mNWgEn0QLT79HvxwSTec?=
 =?us-ascii?Q?2R6/QNdLSm22vwU+3QxBcdRaHS/tdfao/ACN0uZjP7/eqCbEc2R4tDbvCjvK?=
 =?us-ascii?Q?74aVuzEmthSYabOngEWf5F3ULGmrKS49WAGDcvc/7HOmzZjjI5RdEuGmW6X/?=
 =?us-ascii?Q?AM2u0lghRqg+SVfiCgqZV5LYfptSnmzX2AARcR7suoNPXV8nwv3eDeTI+1Qx?=
 =?us-ascii?Q?/UrQbssnH9mOwQYX15KZIcyF6e/6Vk54mJSEY5UkoHtg2I6gnFlZIXUoXREm?=
 =?us-ascii?Q?tRGxrusa2qXB4OGtv/2WJ4morrnMwwP91r/JjY+jE+/Ltza2asQYHyien0LC?=
 =?us-ascii?Q?ldZDF788Io7M3sIMjLfpdh9JTRLaiyhlyscWkwccQfijKRQM5A3JPp77dNVb?=
 =?us-ascii?Q?pIhKYYrdFSDf1gATLW+YrRdU6+6+CT8uH5uqcqtSa2gvsYQoT46JF64/7QAt?=
 =?us-ascii?Q?aQbNhKROiTDk62WYLrKrc9FhHV85SL1qE55qiAi0A5NnZ6Nho017gX70Lu7U?=
 =?us-ascii?Q?KHky8oZtWqV8ABmBLjEO1q8nCn/ekkU7UBxNQ5wPHh4pKgVUod7bwKs5yMBq?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: eb43039b-13eb-4ee0-a939-08dd4925b8a1
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 16:20:51.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tWVCYL/3bCadsvVAIrA78Wjd39WYCFNOoq5sI0G+e0VnCl2tVMmKsfStk6vwxNHsIS3CKN3XzDk73kuHu+gFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7078

On Fri,  7 Feb 2025 22:26:22 +0900
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
>  rust/kernel/io.rs      |  2 ++
>  rust/kernel/io/poll.rs | 78 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |  1 +
>  7 files changed, 109 insertions(+)
>  create mode 100644 rust/helpers/kernel.c
>  create mode 100644 rust/kernel/cpu.rs
>  create mode 100644 rust/kernel/io/poll.rs
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 9565485a1a54..16d256897ccb 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -14,6 +14,7 @@
>  #include "cred.c"
>  #include "device.c"
>  #include "err.c"
> +#include "kernel.c"
>  #include "fs.c"
>  #include "io.c"
>  #include "jump_label.c"
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
> index d4a73e52e3ee..be63742f517b 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -7,6 +7,8 @@
>  use crate::error::{code::EINVAL, Result};
>  use crate::{bindings, build_assert};
>  
> +pub mod poll;
> +
>  /// Raw representation of an MMIO region.
>  ///
>  /// By itself, the existence of an instance of this structure does not provide any guarantees that
> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> new file mode 100644
> index 000000000000..bed5b693402e
> --- /dev/null
> +++ b/rust/kernel/io/poll.rs
> @@ -0,0 +1,78 @@
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
> +/// ```rust
> +/// use kernel::io::poll::read_poll_timeout;
> +/// use kernel::time::Delta;
> +/// use kernel::sync::{SpinLock, new_spinlock};
> +///
> +/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
> +/// let g = lock.lock();
> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
> +/// drop(g);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[track_caller]
> +pub fn read_poll_timeout<Op, Cond, T>(
> +    mut op: Op,
> +    mut cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Option<Delta>,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    let start = Instant::now();
> +    let sleep = !sleep_delta.is_zero();
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
> +        if let Some(timeout_delta) = timeout_delta {
> +            if start.elapsed() > timeout_delta {
> +                // Unlike the C version, we immediately return.
> +                // We have just called `op()` so we don't need to call it again.
> +                return Err(ETIMEDOUT);
> +            }
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

One last Q: why isn't `might_sleep` marked as `track_caller` and then
have `Location::caller` be called internally?

It would make the API same as the C macro.

Also -- perhaps this function can be public (though I guess you'd need
to put it in a new module).

Best,
Gary

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 496ed32b0911..415c500212dd 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -40,6 +40,7 @@
>  pub mod block;
>  #[doc(hidden)]
>  pub mod build_assert;
> +pub mod cpu;
>  pub mod cred;
>  pub mod device;
>  pub mod device_id;


