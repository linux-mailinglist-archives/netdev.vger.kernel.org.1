Return-Path: <netdev+bounces-161051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD00A1CFC7
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 04:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B0C166858
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 03:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A24347CC;
	Mon, 27 Jan 2025 03:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Ou8El6pG"
X-Original-To: netdev@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021107.outbound.protection.outlook.com [52.101.95.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774C2A1BB;
	Mon, 27 Jan 2025 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737948674; cv=fail; b=WrxTAZIzeDUn8uPABg78lwRIdAG8wsiUPaYajTUwPPN/kISSmIujyuTLj6JLuWn2WkpRXFp2kN3WlG1nTqPMvh4rjou3ECaz6KH3p1p+ppcfmcOxX/Z82pj5LW9jwyEOLNplFCoyv3gDudoD94sZwzCqKnlJvE2AkVoyzcs0aeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737948674; c=relaxed/simple;
	bh=REJvXmMiMP5IP5EN3bdzXl8rXVhZ6quFisk1P5lIxl0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AV0k7MwL12EchSM2oz+B37P8iAdY+SSAnJq01oyh79gdC/H+IZT+2lmcQOZ+NvrPkMNT7Co8/R1+67swFBvHgvp7SzxZPbkL8FVfVs6NQAAz5RYH5D9fo0cCwj3Fnb4y/uH2N1lpEcpa7bLeVsaSoXE5kEyIsRNXp+3QFddyWLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Ou8El6pG; arc=fail smtp.client-ip=52.101.95.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUrb941SIPCebrG8arMUe6HMYXvEaUP0JOFdKgeY3glT/9FWEnDPloKzCe/0lsdSm8nW2BwlokFi8/Gya++qNs9C4y9rOziBb0AuWa+mw34TXz6b9NfBSQXVcl2DIDRHk5DvPi8GFdHZBRupScceVfFkzoaqvvSKXWUrbfy7yE2lFL6JQM3hFkhdt8eFuoVqQ/Axoj+KdGcu9ZXiMtyDch/2ti9OUEfpJxfo6RsI5YQU+svFtrTZlNAXsKlkhmabOp0JFM/U3u2gdgeUJX1GrLhCYxnK3e0131lSVdZK9CaT4HOg2f550S49/3xZvRSQT6TAAB7yak+QY0VzJUw8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcRGVOQYuRCOT1uMehiXvFFnuxGTz7PBZfEQuAaPCzk=;
 b=I/uIQn9O0ANMYCj2bh/BaLK0jDXT2JT6tvumqwRFCE/tkZZQ6Iry9EGvPZSN2AmmtZSNRpxwRW7UH4RVBY7OvXZB5uIBSYFAYH3dTmcxpoVJVjYfltEzTWjCypNCKzspvzXoHwOAK83seegomMOcgNtNaKPTxY+x3wUbiFCraN5LTbXC9xKJ+NUgwYunkXUuzap00ZKkAPktuDY7meJXcE86w3VTOJYd1QxRMl50LANr1b6a0z10zd8dVgWpV17eN6YGbb+hbvIIJ/uQ+lon2EFlyK7b2CQk44Xi0RJ4LmAlaDiSY43uh5GDRPmHbGt6OI1GC1msCp/JJsQdRJ6Aaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcRGVOQYuRCOT1uMehiXvFFnuxGTz7PBZfEQuAaPCzk=;
 b=Ou8El6pG0XgUvv40PORo8hgDGFzXlBC5VBf+dwaljzT1LIFnZXODOvxhiIbeI4pBNaC0D/Erni+BNYGzc5BwKTiSLamLnHYCJWDdydZK2Y+7TkQ4Oc6SqCfCU73jrlCWI8h32AqCqVN8n/sQYXV2BeZTm2/VA16dwJQmY1j8f78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO8P265MB7546.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 03:31:10 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 03:31:04 +0000
Date: Mon, 27 Jan 2025 11:30:46 +0800
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
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 4/8] rust: time: Introduce Instant type
Message-ID: <20250127113046.69333431@eugeo>
In-Reply-To: <20250125101854.112261-5-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
	<20250125101854.112261-5-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0143.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO8P265MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c36e25-4ace-4930-899d-08dd3e83072a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0hT5mW5VoLgtcA4hbtGqiChfA9gOWa9IL0rwtmemt/vb5TX3TUncBQzKp0tz?=
 =?us-ascii?Q?u2sFylPjkSDx6+EXEwWQSF8X45jKXKWR+c9K5yADuNMFr3l6hCBDJw5kmdCD?=
 =?us-ascii?Q?dOFsw+3dE0Yc871O9ojDuCoudTQbHdCNm4f99ioSVD3C0Nv5w3YVB1gAIVhy?=
 =?us-ascii?Q?O7o7gOSEThVVf4GM7NX0rOFnl4h6JQOlC6JOTWTaSENz5dmjpsivPqMJA7wW?=
 =?us-ascii?Q?pP4LzEiNjOeyuwfS07E2eQzFqBoX0+MNrED4YH9caeseqZ2qxVLWTyB6gjAS?=
 =?us-ascii?Q?UaC4KcellxhAaoNLobyBn+Dj8nWyJ7GkZDA+AASL/9EWd/UeOI8c0+FM7Ug7?=
 =?us-ascii?Q?OguvB7XbJy/sdDIL/q85+cIOT4KMx3GFzBQ7nPqvmxG5I6tyByJyMJ0uZXik?=
 =?us-ascii?Q?rRqn4yHBqhDwN2oJheIOwuqL0vWxmNdiSoNsxrfloEjexZwQkj9aAQ4hwT/x?=
 =?us-ascii?Q?nWbzwefknem7jm1hU1oJvR7qf6lhVurOIgoOfsK/44jAzOZbkjtONhWbepYg?=
 =?us-ascii?Q?2+s/jYG2NHtGNaTPZ4a0RLAjUUmTnjEZZuMC0rcTyaXrSPWIouo0Y/GslCI2?=
 =?us-ascii?Q?KUyOCRFQvSte1yXyBHN0uVQKB33YEnrQnij325tNjsdMF4M1N6eem81wvIdO?=
 =?us-ascii?Q?tWO1V0Y3yETwePlpgHnz5lT7x5sViYxZ/XAoZSBWRfpiXe5FeipmEpTTySkU?=
 =?us-ascii?Q?/hxYsUJACi6Ki9UzOk5agLtE7MUsxFl7H60Ck9lA6yf66KTBEnhvAPHo9oiP?=
 =?us-ascii?Q?10cvqEH47iAKcw1Z8Cw7bs1QZv+RBRAuSwJRYyrSHiI971dd6k+ih7VzNp9l?=
 =?us-ascii?Q?ZzI2vW6sdlzR2u0ayLFdhsHPHyYKbfP768Rw+2ATvkOC+bzmkZLu0YytzgTk?=
 =?us-ascii?Q?W0WHJ1PGE3QXeqkXtmzWzLYf1Ynv+aj8oHlugNipRmXEfEjc61kt2PGM6hmC?=
 =?us-ascii?Q?RYR2iAjup4kOOarTAW+wHJp0j9RH5mo0tjBp1zPmseZ9iZQYakte6Cwasyxl?=
 =?us-ascii?Q?hsL1Fm9sLh39VV5jDJc/Rk8eiYchOoYpvuqR37phfg1WLJr7kX1lCFiYfiJr?=
 =?us-ascii?Q?SwykgBqslkp7DetzAmejnQYbTxqbdqFjcZ9UOJ+JHoWCrBCIPgaIdMxGAaaF?=
 =?us-ascii?Q?uQwzcBk25BpVyRo+/RC8Ub9CTsWAIUOnBh1W/3TqKpe1s7u/ovMxEPzdQtSO?=
 =?us-ascii?Q?00vuJ2pc6WNFemykG1T1ot+9ozsXLHmn3rsx+gzAfKg/z7rmKZN/x7A16aSI?=
 =?us-ascii?Q?dVuOZzK3tFbQ2bLP05DutPuTR2t3Hov7sOYAanKY5aLEbkqZeFQmmJpO97f5?=
 =?us-ascii?Q?OLeuJQT49Zp+k6R5RbNVNdxqnawj7gxPbQZ227EP4ebP27uY4h2jx+QE2rEJ?=
 =?us-ascii?Q?jQ8bAVwywPPXuP5Ddtg5/vPnGvY+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KZW4L7lcDscModvWo5gj2dwZaSE5EBtChfvIPYyGClSUj51EJs3O31nVgWDx?=
 =?us-ascii?Q?O5eJ6QvvxBjDCmY+KidaiFk/kcOMaLz29t8zrYa12ia1Lehy1y3d8HAHSwpm?=
 =?us-ascii?Q?Bz8C8V0kVWyHDec91+XUM0S/i9BVzS0SBJkL2WfibkX8HKTeG//ppGc1DBMq?=
 =?us-ascii?Q?ONA7ItHulfO1AfFbiSr+5vqrFiZjoHlR9RHTHIU+boD8U08OcJolcPRDXWlv?=
 =?us-ascii?Q?fZrYEGsSq4G20HoLcziiKqxQDrq/d7jBSUzHqxxxppdgZXRGSRfslwP8Zu9W?=
 =?us-ascii?Q?n6X9W14zAWtn69TBWN62h4M98Rf8lDypPnnbuI2eD9rpNtV9R9XuDI/ows/L?=
 =?us-ascii?Q?uvpFaCwzb6H7uXzjF/1gU9trD1DMM3UFFGTUriV+Bz5+vI/L4XFa3pShGm6g?=
 =?us-ascii?Q?Ww3jIjr151lCxQ7cY6RaRpa2730z0CC14KpfKIDFiWEPqcwKT5/UiSg83Uek?=
 =?us-ascii?Q?w1uqROaVLoT5r1WYfjboRQ/Gp7QRY7TIATE7oLuX0TnpakDy6qTKOxuheQRN?=
 =?us-ascii?Q?1fBqc+wq32skSNXt7xqx2Km48mLhhqtjMF/R55gFl2YxuJ61rVsxR/rTh7WM?=
 =?us-ascii?Q?WtTNmevd0HPMBJbmk4h9cHSqV3WkptD6h9Ef3djHVp4E4dvr82QrWdTyqiMI?=
 =?us-ascii?Q?dNYflKx4H5s+L22VeDdtWOtz565PUKl7xe1w/i6dLfQIB1w/Gs9XYrcfIsH9?=
 =?us-ascii?Q?2NrG1WQMd6rLZItv2NSS+f1yLfMLyC4IvVcuwcMT2molR12UiHOkqiHcApRt?=
 =?us-ascii?Q?jXhsH/TJ1BJWDPoEO2/cbgTTy1Y3+0a6IhopZyetFaXl5JqvIiYMAaLeQpJB?=
 =?us-ascii?Q?LzYRDeroAlm5wmWHQFi7QYHXaifLcbKeRh5WBsdZ+bgL8AhySE8NA6gry80L?=
 =?us-ascii?Q?5kwtHeNpPpjGmTGf0J1YrGEDJCHeSTW3Oa3VnxUY0F3NWLHwqYgTG0lSp0VC?=
 =?us-ascii?Q?kgEXDi9zvT6sRwxKV/gLuv5ARmcmi8JNSg75Y/KMfRQIu6k4hoDNL0lzdUAQ?=
 =?us-ascii?Q?dXJ5dHyuLR0BP4gEi7QHtZXFjOZCpvtoOoBs3QrUKGMLT7br+Pm1azILVmGd?=
 =?us-ascii?Q?GgxGb4Aero7KcWtvzfApZCgbZPU+ej7TLLujpXZse8MQNAtnfVzOIAY6ZFI8?=
 =?us-ascii?Q?v8TGJZQ7bKPiDEL0wI67MMLiVM2e071J0D/QOU0yw0RkJOlTf/5h9gzEGqNH?=
 =?us-ascii?Q?Ujb/7pa5F5NQo/LPfLKgerLNXURhdxG52+FNfjUUNvBZNvFeaB24PqFltGrC?=
 =?us-ascii?Q?ReAkWP4bVKzyNktqmu2ZGOnufPGrmMC79XK7Xd+s4dleoC3uPpfhpoBr5aew?=
 =?us-ascii?Q?VjDxbp9YrSGjEv0AvaJYzPVJ5lebPxqsPJZAALNINF3d1JsOE05gGp/reISc?=
 =?us-ascii?Q?7nHu2nWSmYbfO5qkuVHB9ageWfYIr9ZKKqtuo+p0oq3KrkMGqy97Oc4Rihu0?=
 =?us-ascii?Q?h8i4mszW6vluXMVtRdJHrIWs2LD9Zn35sK8Jd4mBa7IG5OxQ0rWFMVNFuxGX?=
 =?us-ascii?Q?nXpCREVyf+bGDjl9QzFLFFGuWA0wF57CKXjG0PIEr6RyrusjjBl1eZUgPnZd?=
 =?us-ascii?Q?H1UJKHILD6MTbIGP1mZwQeGoMadXqOtfZuHxDu95VTZt3DR9R7D6GHGyCF9m?=
 =?us-ascii?Q?D28l8/2uT7qkrW7FNr8dMlN2FVSCAhssh0Ll6o5fkDf8?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c36e25-4ace-4930-899d-08dd3e83072a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 03:31:04.1863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWjFxHoOuOH+GJmUIULdZtTSf+PUtz1eeOOus4UvNdWzZSw0ZAsqob5F6xzc/OCmOW/cXTNyKjlxY7Edlu8IuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7546

On Sat, 25 Jan 2025 19:18:49 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Introduce a type representing a specific point in time. We could use
> the Ktime type but C's ktime_t is used for both timestamp and
> timedelta. To avoid confusion, introduce a new Instant type for
> timestamp.
> 
> Rename Ktime to Instant and modify their methods for timestamp.
> 
> Implement the subtraction operator for Instant:
> 
> Delta = Instant A - Instant B
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/time.rs | 77 +++++++++++++++++++++++----------------------
>  1 file changed, 39 insertions(+), 38 deletions(-)

