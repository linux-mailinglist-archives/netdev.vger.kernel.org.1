Return-Path: <netdev+bounces-134871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E99199B6A9
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 20:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5321C20FB5
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 18:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0841584E04;
	Sat, 12 Oct 2024 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="iqSL1/hO"
X-Original-To: netdev@vger.kernel.org
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2131.outbound.protection.outlook.com [40.107.122.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5428370;
	Sat, 12 Oct 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728759419; cv=fail; b=lHrpVttYam94/KAgrxwXQ8cDwJxwI6fpEufVw0KyfGP11YH9j8QKO6t0uPJJ1qFD4G8CAS6u7MsQLPSNY62E4viWm8PgfNdFhen55OaL2dxR1NnMKIyrPikVCTdese/Kxzpbzo/XpWyKvWU9kzMQVo9LsF/VkoQ0j9c76d00c0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728759419; c=relaxed/simple;
	bh=LxmcIRxSgakeBiYwcMLnbfyFEv7WxeHG2eXufsLtnZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jMVFTWhgE2O61XKvZXcIm8tzNrxvr+BDfBuo2gBb+jgxUClQ3v17mHrThhAK7WIwG3UgKVJkNaWYOWSroOK/MepwUlxBcXon4qV0ep3g+ImVOFiSPPHY17DO7xDLBFfHkqaqHSN4X6d2BHn3WAEbf6sPsL0BbD1fo3tnVeWNkdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=iqSL1/hO; arc=fail smtp.client-ip=40.107.122.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8cReFypH/E0KJQGXnyasdzfzcJYaE7vLe/ksVIAGzfw4VVniPvI1we/VYoYxKon8EYSfpfJigmdINtZvCIKQ4AAVsIeXS+Z86vRXrl8a6loeeHosJXm8OiUVzT8IqvbuDHH4jMEQOmy2LMCvAeekyPYNCnCeZp7fQj/KfMv/JJ02QM8h61fdefnDYFjt8ILR4Bfn5TP7EgCcxgT3T+Zjr/NZmtbhCjG9cR6YMIh1V0+S7CBxMDUXQX9G8zRMQLs1Q30pGmP7GDX3n08sXYh7fOG9jp8MAWQsF/mHP0SocI8nvfpV/wf9I9QR0HLlmdXxEtpxYjQR3Ra+h6uD1XFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa+4CETwYMZdjPluxdsP7KBsxtdTquwZu3OsmhHap4o=;
 b=qgvA+mYy2eqC5aXfelwzOFggYnMT6KW/Jy2CKwOaLc/MO+MM7bsTt90VFkEf91oRnsNflFBx6GI+rrRqbeNBKDFChI9jcIhScXyoaxsI569UOER3I6LYlvuo2325KOCsC+A1bAgXbV6AFeVt4Lnw/vnqBGBskWEnZxcormmQog6626mO/r2PHcaOzUGzCQmszaLJFXSEdbQ8mdd12SiZ2sn42qV8oYia5mskPnn4qv9A35f/7kNqfV1VI+WTKfJPocEll4I5MQo7NZvAJ/RMU0LMKtyjxEkkFRgTsendINgp4rS9cN7waAhp+94ugb4/FcTfaiY2csyTeinkSRpPJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa+4CETwYMZdjPluxdsP7KBsxtdTquwZu3OsmhHap4o=;
 b=iqSL1/hODI7gv4DPBVIU3TXcqmkSM0gLmClI409IJCLx5Pvq06YneeltIt4R4UoKFtNyB/Foy5mBWAHprt+McgPtVo8k7CMFMM3lyPEIZ7qDZl+E5JwwERzNWdOTU/rzaYW0gZHTs25o+sOlrgpl1ld8Kh1D4nR2AF+ERnKFgcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB2430.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sat, 12 Oct
 2024 18:56:55 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8048.020; Sat, 12 Oct 2024
 18:56:55 +0000
Date: Sat, 12 Oct 2024 19:56:52 +0100
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] rust: time: Introduce Delta type
Message-ID: <20241012195652.4d426c90@eugeo>
In-Reply-To: <20241009.230015.357430957218599542.fujita.tomonori@gmail.com>
References: <3848736d-7cc8-44f4-9386-c30f0658ed9b@lunn.ch>
	<20241007.150148.1812176549368696434.fujita.tomonori@gmail.com>
	<54924687-4634-4a41-9f0f-f052ac34e1bf@lunn.ch>
	<20241009.230015.357430957218599542.fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0300.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB2430:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7e0f6e-2a2c-4991-0dee-08dceaefa42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KdzN87+tF5wGHavW6CG7e/4ZEmIHBKMmT5aySpqDH80etDRyZNoY0hPp80L8?=
 =?us-ascii?Q?Lmx591rCQzMMy1Ep8N86gRntedQrRihSyCG/5yLQLQMfKprTBhsUwX1v3qPR?=
 =?us-ascii?Q?DaxUq7oL8GG0GnlfxDCOwhHqRh0TNA/I2UBG77XbOoRbeF5hIE/MILv3xano?=
 =?us-ascii?Q?EoYiqR8Ziw6pfMs9HCCjpcXD9Lr12ZzYPWKhKpol03gfTVgompBSTuocd0YQ?=
 =?us-ascii?Q?xJO1bOJqql6+sbFA2cn/oEQxZfFu8HTZeWeqZGvHjliyNuncm5dBZRz8y+NM?=
 =?us-ascii?Q?eGJYqkIXryNJ10shHOW7TkSXbd39ARYD93rVPB9pfuaWyvsTXU31SGUw503r?=
 =?us-ascii?Q?RoyfLPEEchfMlbcd/mnWYiPbUZuUOzzlQEslMvO5i/Pw6I6c5erJwAXiEg3B?=
 =?us-ascii?Q?vhzw0GNM5IhO5jfVtT7MdEeqdgfdy4fDlWxpjPEOsla7knf5z/hmAyhDoc1f?=
 =?us-ascii?Q?3Ct3C/DHamel/HtGHrPxZGSZt1kYHh+tBWwwKMnFlWkjtq9g6tNufxQQ1RwA?=
 =?us-ascii?Q?PZeWX6eBUs693sofsyGQ/YzAhAE86uTO+LIDMyKSK137HPwdFeZ7pstlOZNl?=
 =?us-ascii?Q?qn8TGalb+En7u6D3opaLT3uU9FFeMuLmwgqIvFXtZTBmcB1dd7kVkx7TMWMo?=
 =?us-ascii?Q?Q++ywHO01dpF+SnjiDqmVCRwDVXxX9/QUzjVCbK1aFY67VB68zWCX/A35Ncq?=
 =?us-ascii?Q?sK7Kw9frjPhwQcHqP1X42iT42iw++wpv4pqpsPDulCji5t0kiFYe39684KJ2?=
 =?us-ascii?Q?AFm+TC3XPYnyzoddBRTNIK9OPkk4dkjbSebzNVpjubpoAkAdRsTaoIc0DnSC?=
 =?us-ascii?Q?JiJMgXBfuwZo1Gg5xTDzaN1DXR8GiuPEKWcpzFeekEDwkM9GNwxCRt4fgSWT?=
 =?us-ascii?Q?rJ6Efh/DyUTL+jZqisySsOe71aTwrjd/IGRzVWo107HDOqQVJz9anBxGwW6G?=
 =?us-ascii?Q?+tsz7ikOakcfXXZnDDwrHtzZzSBMy0lef7N2flBHGf6dJ1BCFeII78IcVLjp?=
 =?us-ascii?Q?qlxxZlyCT5L3Exbx6qcF0Nqr9od7k8wmjIPYLFjWAklTbquXcLebrU16GvhU?=
 =?us-ascii?Q?APfEqJbtcxtvBfz2nPGKwbjte9xWrm3Fqr0EIq6iaaORI0giFndTnZ6wy+ej?=
 =?us-ascii?Q?STCxu/ocaL2v3c2PBOfXJuwbNMwdqb+3yoAGBn+5EhacosGZk//YKF3GAetm?=
 =?us-ascii?Q?vwnpPTjhkVdj2wodik1qaGhzHemd+pBpAhEQQSM4Lp8JjGEtH9zGRyrUk9EU?=
 =?us-ascii?Q?UHBCUWWeLdgWOzRM3mDsUf2HuDOuSS1vyZmQjgvV7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aJxS19BfkaFLwF1RcYYEwajIcK83kppjexXF+Q65i94lrfhBH251xI00/9Dg?=
 =?us-ascii?Q?e8gTwhJg/ThXgESkkwaXVYtooRNqUgac/xgtEbs+HxLeplQi4IIYiIuNKDmL?=
 =?us-ascii?Q?GTswLTmo45e/oH2SFd7+eZ/WncSZ0tK7vV552nuK4VZuempBR0Yvhxtob+Pc?=
 =?us-ascii?Q?591Fp3M+QLwFleC+leZYT7G7EqYGItdADUcjCwGWJuK/uH14PUq7HiXLiqmE?=
 =?us-ascii?Q?XSidEWeh+zkn36IwzW/ni4/B7CIki5J2Z4fTXxU9zQL7yP7nPGFS4Wzpe0jc?=
 =?us-ascii?Q?CZ1nxo0wBbTEt3ggo/Mm4ZUKZqFdh2udVDN2Mmctytg5nF2r8GIPp2NQlKU5?=
 =?us-ascii?Q?79wEYAeU7Eoz1Ic/eRkp75XRnugPncR5HWaK1MR04XzG+M7SDEC1xr5MHWSA?=
 =?us-ascii?Q?yuBz8Z8r/1i2XfRftffsk9h6oMYwv0v7GtLPqlZZ13TmjLH7wn5fyunlXxzQ?=
 =?us-ascii?Q?tSo6B7mGVER0A/dIin72UzmOhsiqVHcoNZXfqE8uaI2pb7d36kEOevjIx3nd?=
 =?us-ascii?Q?zjrDEpTUrTk+KfUWsEc+AjDeLGlIgQwK5SbpJdaLQ8zUgnCle1/XtqklQ3TZ?=
 =?us-ascii?Q?abjD7d6v6rW24OOYIN1ZBhEG+kkA1bcdgjTvmQfd37+g/cyqcUxSSIWxHReM?=
 =?us-ascii?Q?wlWbX5zgKWGvxGp5CE1QNRmGI+t6UFtcSZU4vU65D0x6RsILGCUcFpXAYcpc?=
 =?us-ascii?Q?StWEnEP9bHqo6DBEyIfMSRURDx9eIDKrr8BJsBPXdIIQ9dRZHpnFL2yFKgo6?=
 =?us-ascii?Q?91svTp3GBCfqaapMbiaxOJcZuhOPKnRueR2LzvWc7gtlEr4MzocfFJPeU73v?=
 =?us-ascii?Q?KRqW5LH6qpaSM5szFdu+roni/6Dv2GjKjQixUO+IEYFn/wHSAG66KtFV2ySO?=
 =?us-ascii?Q?zA0M6nV7S+3jMGo+8Dr2al9v84SewE+UAsiSsUPHmIIWkoFtuJwM+nC4ugnL?=
 =?us-ascii?Q?41Y5lUTiY9S6BUA5vJEucX4PzKRF68Dy7UsqJGsGk0xDl0OWaGYAjhFw++Bg?=
 =?us-ascii?Q?FLSKwkk5X3k+C2jMNiiPxiCG6BvAqhHJQ9XdrbgV2l7nJgNHtOF/lS28pIxM?=
 =?us-ascii?Q?0Fd7mMlKihxTUjadC9lRbJ/yEpRQEo1R82gobER5glnbA2smXhh0YBoJSDL/?=
 =?us-ascii?Q?MQ0Xylqf3zyCIlv1+tzXj9/mV95gdGLDZQ4j/Skh+5Ms857aJxqvQSpNSxxw?=
 =?us-ascii?Q?wjns88MGXkylI2j3cZ4UeVLZhFy7oTeMAClwcTG5flbWCfXCrJ+Zv4xPUHnv?=
 =?us-ascii?Q?FHtAa5GZ5W1sxOEY5/r97l5uJvjvbI+UzDs9M3vexyU6CZRmPzl9eGIZ4ZMM?=
 =?us-ascii?Q?FoDR3OTmFpiBQ1sB191P/KwTbw2NLvLml+Vw+V+cHM85LtxPdyrxsAiem4OY?=
 =?us-ascii?Q?MMBDc/Tuqt8rXvoyoqxQP/eUg/4iLcX3k0FuNgspzKe/CEx7L5rK5hQ5GCqB?=
 =?us-ascii?Q?yS7HBff81Eo/GxtBur5HCHBseYI5nDqq+9gOZMzyvdnFYkQqpmH49FeTVHBt?=
 =?us-ascii?Q?rwhu0kmp/M9DiP8x4emjyn0NjYbIF2NPEIYkJTT1cGSgb5d75iKS8eGaVlDD?=
 =?us-ascii?Q?2DETceho2qYaGwKfXAsa+TaD+kRp/uyovhj+7p9YordwlolWVGKOvHR0yR0H?=
 =?us-ascii?Q?s9W8kj7PYgubqwDZ5B3Aw1A+bK/xES0TDYll1cqQM2Sh?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7e0f6e-2a2c-4991-0dee-08dceaefa42b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 18:56:55.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EySO5XWl6X18DeG+Jj+kpOBBXBjBv/HaxC5Bff96x51C/pYykPYmqmWauCAx3mgU7ZGSIqrwa7jXQ56Y4igtaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2430

On Wed, 09 Oct 2024 23:00:15 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Mon, 7 Oct 2024 15:33:13 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> >> I thought that from_secs(u16) gives long enough duration but
> >> how about the following APIs?
> >> 
> >> pub fn from_nanos(nanos: u64)
> >> pub fn from_micros(micros: u32)
> >> pub fn from_millis(millis: u16) 
> >> 
> >> You can create the maximum via from_nanos. from_micros and from_millis
> >> don't cause wrapping.  
> > 
> > When i talked about transitive types, i was meaning that to_nanos(),
> > to_micros(), to_millis() should have the same type as from_nanos(),
> > to_micros(), and to_millis().
> > 
> > It is clear these APIs cause discard. millis is a lot less accurate
> > than nanos. Which is fine, the names make that obvious. But what about
> > the range? Are there values i can create using from_nanos() which i
> > cannot then use to_millis() on because it overflows the u16? And i
> > guess the overflow point is different to to_micros()? This API feels
> > inconsistent to me. This is why i suggested u64 is used
> > everywhere. And we avoid the range issues, by artificially clamping to
> > something which can be represented in all forms, so we have a uniform
> > behaviour.  
> 
> I'll use u64 for all in v3; The range is to u64::MAX in nanoseconds
> for all the from_* functions.

If you do, I'd recommend to call it `Duration` rather than `Delta`.
`Delta` sounds to me that it can represent a negative delta, where
`Duration` makes sense to be non-negative.

And it also makes sense that `kernel::time::Duration` is the replacement
of `core::time::Duration`.

Thanks,
Gary

