Return-Path: <netdev+bounces-161050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB60FA1CFB8
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 04:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147C016444F
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 03:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFFA8C11;
	Mon, 27 Jan 2025 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xHDaAPuH"
X-Original-To: netdev@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021112.outbound.protection.outlook.com [52.101.95.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D5218EA2;
	Mon, 27 Jan 2025 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737948323; cv=fail; b=VPMwMLrHmBatqvBzXWJfjCaNqeMUVVouFec2lFOscPOgcqvWAWwfxO4GTF60ax5EeebRdIf1utc/pVZsbgtcx0d8nkPXZE1jkcsXtlSS8nZSKjKC6HpKll7SX8BAoNROa2Nt0bLhnr/w4D0ctD1uotwisU2nptRv6WepVLI9PTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737948323; c=relaxed/simple;
	bh=VHXQqoJMNks8KwrtYZ1hiTcD9kJDD8EKVJSxUqBCBpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D42Z3chEWtxpeMc3MfOsLP8igvO4mXDNoy3pWmzggp9b45QNWxNkAQOJXKpdR//SNBO0yQyHSMW6RU+n3OOmUiaSnqXMIM9FKl29N1S40cSJ8+c28rdUSc4L/sTUsKQ1fOIXAXrcOpJcRwMAfflscg9bgvjdekLpkWcLFVmQ6TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xHDaAPuH; arc=fail smtp.client-ip=52.101.95.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvCqNIYjHkBA8devI3Zu+4EIE/hM+cLdeVXvVN7hV0M01YoFZmod/IyDD7VMnUnTCHRnsi/QV4QoeShGZLhNIw+NxcbnwnUKCmke53mGW/7MGaVly/oSOjD9/G7kI/gLq7akgq5QBcH9KlJCxf5RSifn/5/quw7jmqfYTs5Pz0sGXuBUUbRDILVpiOPo54OwNlOrCwftfwt9tongXNoTlxk5XbPEBZXMwhr3sEjqBF1HBfuTGbmuwz2gp6S4ecyEnSo5kBhsifsmA4o/QQHWu7VQBX7oGmBmX4nXGTG+dlv3FwPIDnzChOT4NU9jye6Vcs0KxvtfbS66/oRwBr1adA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyEtibwfefVfMUf40ffHwfQJmJtwj1RKBTFUco/JkHI=;
 b=lyE8WmVU7PdeXSTgBO4VNq1aXWax2XcjFwQ62rVhIaBV5GvXLKZOtIl8xZB14gqO8vu34p5ubonM42NxRvF0Ying/b3ZQj8sMpburRxg1PjVVpBsSvdsp69+EKxqApbdyZzwB7dMnk1rIBbs9N4oux0vN2g4lXgACga9aUegD/u0awHLQNnTzk1nf+7e0jsP3Fb3Prv337rTjALtavkp1pq+ZTclLylbrH2+kveeNk9jvNBdIQJZdCVnjaNiNPioJJ1gDv1B7eQ+YKymhrdZ9SZcDvyQhGplV+vhG5Q9kb0lmMzUyr3tRc5xCc8ExhBvua6HntNJ0hEktO9hFVj53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyEtibwfefVfMUf40ffHwfQJmJtwj1RKBTFUco/JkHI=;
 b=xHDaAPuHHwDAWqdnOeqBIquJYGruTPjyyheO4qdws4XHLVwwrvJMlxTtlssCfniOt+jQ1H4ERi73KThwFd7X4a0XQAiwYjt5N/MeNkU9aE2/q/eX7LW6Tryzhmyb+4rbLMpuT4Gxphn4OXd1I0Iu8SZotGcZaYTqoJP/GsKmYvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO8P265MB7546.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 03:25:18 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 03:25:18 +0000
Date: Mon, 27 Jan 2025 11:24:52 +0800
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu,
 ojeda@kernel.org, alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
 sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com
Subject: Re: [PATCH v9 3/8] rust: time: Introduce Delta type
Message-ID: <20250127112452.1e2249b7@eugeo>
In-Reply-To: <20250125101854.112261-4-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
	<20250125101854.112261-4-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:404:a6::25) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO8P265MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: c3980476-592b-4462-14d5-08dd3e8238e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g6ZybTxJu42LsLY3wgYik6Av2zJPIi00WJy/IazyA2lwlBZCn8O7V+BDSeMD?=
 =?us-ascii?Q?+ACEtRDhhb+z/GA9mz/kt6ULciFYq+qpPp7sOkV80eNbjfWc/02YBscQ63oe?=
 =?us-ascii?Q?vK70S4Ayjp2I/sl4R85lyqTwiXKGfmhxJg+kfnSonv4QFPl/3IoPoRCItr1h?=
 =?us-ascii?Q?p1MSQAQCMkM219mRjIWFtuat1HcVm2E40mQtkH+BNGIioC696XTfSQHt2FMi?=
 =?us-ascii?Q?6jtf4eKX7YKvuk2lnCSbFQ635YxjSzKFfG9k/PoDCq6X2sECu4MSzy7PB8hJ?=
 =?us-ascii?Q?e2iyzB6GuP2Yl+wJXsBy+m2D6nyIs1JXCUwjbLnURZLkMrzz60HTrJZPVzAp?=
 =?us-ascii?Q?cy5/9KlatjQzhUoLRdG3kaK8BRj8JRi+6pw3CEkeWv/fx+3vNX7+9ULKUurX?=
 =?us-ascii?Q?OrZ373xU524MrrYM5inSniGGVXOTTNYQ6nB471XGj0vFnQDa5RtscATaQUaY?=
 =?us-ascii?Q?BJ/PKYP+t737aSe+JpRzQGln5IE8pcsyvagIwWCsOzcMRgzPFf5YJN0Zxv1F?=
 =?us-ascii?Q?5qFXuyKtOwuk1EUJh3Di3TZdodV4Yz0jCoLB8glinp/bRAlDchRo41bs7hqJ?=
 =?us-ascii?Q?15m9NuT4kPhugK0GsgfF9H3dIl9ErEUERAZXu/DPZsj0RQe9ZzRbZpUM8Mpz?=
 =?us-ascii?Q?WKffY2kxlU4+Si7KmUfK+Aco4cAVlVNuU+qNk5VyX3rWUwX6EI5Rnx7GW22E?=
 =?us-ascii?Q?apUPrko8xTisiODSL2m3237eFboYFGkdl8XTnRJsrEIEWQC4hbGB9pQcn/tv?=
 =?us-ascii?Q?GOXcUcNmPb2N6IWVYd3gTPEooQMr0thPimWTk2/DTsP+aicT7Qz1eOp23p7U?=
 =?us-ascii?Q?wWdelcAx2EKfMMXs1uw20+kQr+nCAIXsUBjVkKYjPuIQXvz9QWP9yQlKtxtO?=
 =?us-ascii?Q?ix+yiHWlwm1E7ll38gz87Sqd5DYO+5p3y0+L4aVw2ftSSKfeEIGXaN9WquNw?=
 =?us-ascii?Q?R5vQnrtO+t+jcv4fvkvgHpZMYioMdtUQF4TEPSZqRtDcXTu664rTX3jKN9as?=
 =?us-ascii?Q?K7e799CervbgRKISqnVA8fiU4/OuYX8z1weuqiXqhTj3CNC6SRxwa88LDpfO?=
 =?us-ascii?Q?iddKmtYd6l1XEzhZUR3mbcCkC6aN2o9VMg34wFMD4M4se7KMwCu30ns0CWjG?=
 =?us-ascii?Q?JhgldDagxtoaPd+/pAlpzwRAF/kIBWDVHUQ7AmgffZUJbJz6YMY66DSh2c/s?=
 =?us-ascii?Q?IzicCfmJ+a8Wr0H5LH11CpPv92ROkjUd8O5jliVTTAhwHEkIHcbcNN6f2Ugu?=
 =?us-ascii?Q?RugluKahoWGQ5jgKGu4F/JSc6nFC7HZJFwd/3w7byZFgcPu5v+PIe7HYKrrh?=
 =?us-ascii?Q?aPtqBX9gTQ26Bn5+B8zVXTYoa/QnObifCc7+qWfDXhZlLl9teOWop5ddj+e4?=
 =?us-ascii?Q?hbnay6V0pyBC8g3c3SWwQ1HFwnh5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dhaevi1yzoNkHe+oHIuDpA9ssvwqPBWy3mmLTNsoVft9rLjQP5n4o6q9W7c?=
 =?us-ascii?Q?2E4+fvzNb3V2DYfKN30Z3g7H7E0Da0hKMuu50XpFH3tgZORKUrdB9aCY/fYE?=
 =?us-ascii?Q?OFxrkXHaLxNLZiiNUEvWhhMBuoiF2xeNi5jFtdb4Pk8EX7rG62pbS+ncRsh9?=
 =?us-ascii?Q?34X15P7UkQoKL382CCNGHWIJCTHz1cHfpHpS3g1TPEotingBf7/M1ezaX8Ag?=
 =?us-ascii?Q?y5xh5OVV1KCBU0gOIdtfN6AoYN71h3mhzV7R5gYTrgHJ9CqK+XEROSV6wE9c?=
 =?us-ascii?Q?JpUxFwwWLwBwjUO0uCsWK9RruGkeKppMrxdidplYM2q3TAUQYsfBsK766idA?=
 =?us-ascii?Q?eCWlEtgJLRQ1+i9m0L2D8nF3ls0yVNr47FlpE9g/scUIFSK/uhGXgz0EeyBQ?=
 =?us-ascii?Q?RyMuvHnwZigupNKK5sEhqgTR1JTTyPHj+7Q1FN7iy1T0165Zc0a8lA94ALLX?=
 =?us-ascii?Q?hO6/RI2FzDYS2kZe0KRzNNGLr6Bc64KbXozHn1LNZfwUmIDP2ze781YbHGXR?=
 =?us-ascii?Q?0m4rQ+e9a5QckxyrUeZ0v/XSK04BPGF7cHY3YnFPFHJegghpCBFtRNWOiOOA?=
 =?us-ascii?Q?m5/h8lv2sSuVAtuzEfs9nY/8F9tOhZijpD4Ns03I7o/pBzfckL48ktZz+92h?=
 =?us-ascii?Q?zGWHx79wz/wt7ZMcOP0BRm0zQlwNBqXiMF5HZbJ3hv/cZj61FCj20F68BA12?=
 =?us-ascii?Q?mfW+S3F30Gd/bgsW+iLpv6bot4jxNEBy+hWwnGfbhUkJopqOUW6p+MgvLJdB?=
 =?us-ascii?Q?wq+olStpBQWgVXM6hSVlcNj/yHzBu68RQ80uMnChaZrhiTp5XMg9NcKbt+sF?=
 =?us-ascii?Q?nnEJbfYGegXAw5BYm9onyw2VY7RgAPtjpY9pQ4azRsgAj1L34hcRzD4RXN2f?=
 =?us-ascii?Q?ocECMAFGvMHavOVXi+xCGRMKZDKvheV7GnavLzNRAU36TV5wwn0rJgXp2j+/?=
 =?us-ascii?Q?zO7aMje2ZqX6vgni57RjchcC63Wstpl2IZrKQsvXxRQt8JUNv13fBvoBkyBB?=
 =?us-ascii?Q?9p1mmOkQ2UC9pIGYGcFkxhEQgvBHt6oP7VoK9ShIpHR6Hprjrv6fOyhVoTSK?=
 =?us-ascii?Q?Pa/2DZ2NK8CUowu6xeTDPL8chA/B73a9+KHUCdTW7zuz77WEt7Y9a2ASxbo0?=
 =?us-ascii?Q?qUE10k3MsWHTTnw/EbUaasviFziNmDrtWPGrnkFy49IGLZy07ahg6hfPURen?=
 =?us-ascii?Q?d0e6DsgxnBvpsEGqrKGfGMEC+QONQU0REIqATUqWRpqSzy2GTDduLhskY26J?=
 =?us-ascii?Q?oJ2lHRzd86pfZlV1GBdFQJ+d+MZWgYNlZMESjYujAQprjYC6Z0o2PVNlhg0a?=
 =?us-ascii?Q?tN8tUfW6oVPdNjKU2C/7WapRPk/XZu0kZ4NKSlz6jpdQlrpEjuQxMSnS/CQP?=
 =?us-ascii?Q?sFeBfpI3xkUcCTWFly5nJ00RyM+nLqXtDmgkX/80NyzX4dq9ObCJi23T5hq6?=
 =?us-ascii?Q?hfxuRMp28P3bKAQEh1DW7pxq7xNNiBZFcpSp+3CZYZaZOXg1ebcbhk5Gfnxj?=
 =?us-ascii?Q?kg+yuCNK2up82B5mpeV1UEOftPEGXQSA51Qy12257cdp+JF6Mjcs5gvTM86F?=
 =?us-ascii?Q?fatTmzSKKJawB2sW70HcS126afLJ+MUgqce9cQ/EX/6Ipi+BrgZcuvc6+d2u?=
 =?us-ascii?Q?qbNLVyET5WWsmmr6nmweQDWWTVtmU9jrnODFoWp+OpmE?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c3980476-592b-4462-14d5-08dd3e8238e8
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 03:25:17.9321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtccK1IIeOGalzUHyhBUyE8pOCOYTJy3rWVJl+EsAGfQJ/nid8lbWrIgKaidRMHMQW+vVMUMczzYtfLfoXq93w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7546

On Sat, 25 Jan 2025 19:18:48 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Introduce a type representing a span of time. Define our own type
> because `core::time::Duration` is large and could panic during
> creation.
> 
> time::Ktime could be also used for time duration but timestamp and
> timedelta are different so better to use a new type.
> 
> i64 is used instead of u64 to represent a span of time; some C drivers
> uses negative Deltas and i64 is more compatible with Ktime using i64
> too (e.g., ktime_[us|ms]_delta() APIs return i64 so we create Delta
> object without type conversion.
> 
> i64 is used instead of bindings::ktime_t because when the ktime_t
> type is used as timestamp, it represents values from 0 to
> KTIME_MAX, which is different from Delta.
> 
> as_millis() method isn't used in this patchset. It's planned to be
> used in Binder driver.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/time.rs | 88 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)

