Return-Path: <netdev+bounces-161243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C836A202BB
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 01:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B743A6E46
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED0E2745E;
	Tue, 28 Jan 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PfnrcDCM"
X-Original-To: netdev@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021096.outbound.protection.outlook.com [52.101.100.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E474400;
	Tue, 28 Jan 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738025402; cv=fail; b=uWzS6rjQf20h5845u1UC8gi5BEhbNa1maFjA/8hQBEh077NSjSy6RJGWqEtWuItQDv3sgh6u7jnKLH2RiuOSuqmN3L4WaLcYnvjtV6jv5tSARaqmiGQscPE4PtrbJRVpDE8dB6JqsP6tVYRGKAxWlcFeiGN+bMwZmzPwVoQZHco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738025402; c=relaxed/simple;
	bh=jYzqjcI5rJl3J0BOtowc/VwbWRGUAZj7jt7470/lPbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FAMh8KsP2w57PIRdSUEoRJL/1RBjgU+LIiUWViAzZ0CktuPqTP6Y9GgYHmkI9Wgji7ZB3hBe7QTZeHN7P3nDEBL0Yy4IVjxL8Erq+vqirvHWtgH6s4HeqS3eeORkAE3QtLToFS45UKyW0CQClMsTOmrJrS9QyAtn/NlMfZYMsL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PfnrcDCM; arc=fail smtp.client-ip=52.101.100.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzONafxsDrFK0QQbGkfxToD/5ximfmPi7FS8WS1vnvHMF2RyKe3moTtZDP8ApDUB1sSDp90BmYJNyUOFuSl7Rc+taOiFfuygOrl6b85Wuh5i2/coOsF0ThbqG4i8Eg3DUdmAi8ua8p7O+dmvYwswk351PefhP1q097iEXUM+Zp5qOekOmy20HVrdYYEdEUywiip2vK6umlyMBhDihcc80C7cQQ+E9FjdNcsDsyuxpJ88Cao1pdFfhQKSNw93Tyii01FMbzcoo9AlghVLTlsKyt5KMnud04WvBvP2E8TiaaX0yErpYfeaY5hlFiXokYYWFkv+ExhagRE+xA3jDQwCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Sf2+nT8CgwkB0OSHm4j6rY0UUZOgos74VsUyNnK/B0=;
 b=RxgsOwgBPej7alzhhUd6HrymW4XDBTz9r6Ft3eErsbDQrRPhorUquBtkCDbMKytNHn2khPN5QtqJwsNPsk2CdJNP4BNVb0byYKcMqpPYDdVjBq8+NJkCLVqk/lSc7M/RbbMDMCWTJRgO5NSw4qLhYp48CTE2d5hlkw6VIjKrw3GChFr43XMHN5k9Bz4LwyG1OyxW4IeEsm74bG+7dGb1+AJ3ygMvi1D/uyfCZSlRFBJovZVWLK1EBbXcRHkbY5l2DHsw2rifNmdhk53W93cD7DdFQTh4sHXokCQTGbSVB3oNVNTvyIGeP8/h4aXO0xuDA5r0exVNd1BJiO7Jf3p1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Sf2+nT8CgwkB0OSHm4j6rY0UUZOgos74VsUyNnK/B0=;
 b=PfnrcDCM8bqe0B/YfkIZsYi0uXYaCb4LinxsnKejocrlXrmqJ1pv5IQRrc6mOk0YyUWYa26kaqBp/KT0UUdmaiKt86+vZEMCGBMlmofMFgwp+Ky/iMuP/g2Lp9xdNodRsgTJOcLZXjIymGu4Oor8BdiYyTb6oSxiqAZq9b2h9o8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB5325.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:258::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.24; Tue, 28 Jan
 2025 00:49:57 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 00:49:57 +0000
Date: Tue, 28 Jan 2025 08:49:37 +0800
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
Message-ID: <20250128084937.2927bab9@eugeo>
In-Reply-To: <20250127.153147.1789884009486719687.fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
	<20250125101854.112261-8-fujita.tomonori@gmail.com>
	<20250127114646.6ad6d65f@eugeo>
	<20250127.153147.1789884009486719687.fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0082.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::22) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b888d0d-52bc-4312-f9e1-08dd3f35af0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tXg7ScotHWKXFzvM5j3yhbO+Uw9Wt5BC8WML3Rg9DEau/maC4moxCpO4irxf?=
 =?us-ascii?Q?Fhc7fniGJkN10ncV99AIM5bEdr5c0RfAoNPpXptJAz9AlnFmyMMTZ0+jd3fR?=
 =?us-ascii?Q?8uJ/X3K6PVxCAc18qK3jKHbrqPfFedm6elnNQ/UVECJtWA48zsmqDITfGD+c?=
 =?us-ascii?Q?/L+cwx3rH52l6Lqjv3Gwmm2tTgG7LQ3VvyWAfhA7sM8f3GcvXS4+imW1QqYL?=
 =?us-ascii?Q?dheb/E+GDgUJ1F9+LTTeVYrs+soDXILO4eylkcNXfVKOrTSv9SHLu9hd96vC?=
 =?us-ascii?Q?kfEvXsTncELHbrsK7jqQvYhOvRVP+zx8vXxSIr7C0E+e8tbnLuA7VBeN2dxp?=
 =?us-ascii?Q?0Xeq5twqRWy1UJwYFtAVDDaMhiT/cNfTlqDsJygCzGjx8aqSZBRikf2BayQC?=
 =?us-ascii?Q?W1ylxjd5mj62qOoMblKUK3cSFleyeqXTPfhmu86Pc3bruf9vaftESm8eOCkM?=
 =?us-ascii?Q?K9Goy0nrO5pDVgOK2AU/TvYwIQQ04uGm5TN0/IF+Rrtuk4yrVl0RwYr9Uuju?=
 =?us-ascii?Q?DgNGMNeee0mk/qJCPV3TCziFjC88SaC2l9TrATp45DHgTs8BxwRt6qEiV4Ag?=
 =?us-ascii?Q?kTfWJ19ZcwzZMh9Tdj6HIBiDCrWW79Qf34Y65ncZKa8AN0QyTOLtsf5qwC75?=
 =?us-ascii?Q?M1NwvuWmK71ch8JKCDngEbWCirmKhLqRWtEiotvFbqsimzG5StS3F4FFBoww?=
 =?us-ascii?Q?SJ7lyLbEOEYAnjnU11bt5g16UWvcpsh2VtI7FOQHbPL2mumTjZHZsyfjD42y?=
 =?us-ascii?Q?pwhZJeXMOMXiCmMs8lfNFJYfTwkFrohaWBe8/F5skY/oPCFNrHLtiReK1pSJ?=
 =?us-ascii?Q?RV51rm7u/4uyZQ7V4Addn3NjEPJk5V7AN2w2eNT4teF+WyoqFuKBgTXxGMFM?=
 =?us-ascii?Q?npmGOi4IcSAPwHQ4OMayVeWGpLv1y4bdyXtY7A53qZzBUXlT4TTEX6srzu7W?=
 =?us-ascii?Q?/cRWRYIzMnbZePd4f2u9kOAg47gzBojRGkhjiSWOBRReaBWF+hvol0fDQXI7?=
 =?us-ascii?Q?HBF2QufnfXMiNVHlX8u5ddulGuBuLTdXjqHWUNPudOHKQdp2BTWNSPLVkDlN?=
 =?us-ascii?Q?YxA2/2LeDBKQZ4NKIkC2gDYDzx+U6PYn7hRG4xWnWbiBaDOgH5j0o6sPZVU8?=
 =?us-ascii?Q?9A9YbeP/qh6bgVIbBfOYBMuNmY+l5J2A6vOwFJ12l9Op7MexBebDHXZ4EP9g?=
 =?us-ascii?Q?Ya2Wz5pkjik1ptuVHbaaP0e9l+OciZumsdxmOl3UmP/G8Yfzb3BPJCErXtYc?=
 =?us-ascii?Q?cDjFicXGgvrcxlH9gLZyKZiNj7la4OMIoyG0XVdpqEYqur77QNu1dmEnK6mz?=
 =?us-ascii?Q?ppmSIznxNIDTRORfZW1Uy3mwmll64V25uIDN2znOm2m1TixOljO5N1drpkv1?=
 =?us-ascii?Q?KVheQiyit0cNT6pQ+YIA+/p6oqFr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUf0TxWkzwNtyJiif8xqIfFwG1C16827M7rrHui+/H1/tMX9Tr4zIw4Ij5ZK?=
 =?us-ascii?Q?ED1Hnxr9fJyRpqbYEr8h1wrAXsU03r7JbjNK2/PLpHSrH7NqEDULme+aXtI3?=
 =?us-ascii?Q?SbmOWboyfmgmno6WenRJNR2iCHLbidBIlBFaMEB0IRR1U75cC/3ElIMAy4V8?=
 =?us-ascii?Q?DXJC3PkA71lKzUJDrHY4Q3qDgHw2YjF2rDvUxGaC3vJBkMmQhZtY1e9Ql3Qh?=
 =?us-ascii?Q?ZiGfn2ooXy6h/S3/vJTrVCwzCtITGrBNWf9WaIVMPOy/9u9XMeiCMFlgIVF7?=
 =?us-ascii?Q?RVI1t1BBmENEVryIjVlsdEQG+NS9Osiu5oBB6OhHoRG41aCJ70neaXINvjg3?=
 =?us-ascii?Q?pzdAcC/1RqeZIQiUTx4gVxh+Mq3F6MJZTFYWMidSZBHenPHwuXFSOHYpU0IK?=
 =?us-ascii?Q?DxrgSBV2CiRvJKpvp3H7R7I5Hc+xL3oV8ohFVOcIFwLBMBQXkhuQhAuulBXw?=
 =?us-ascii?Q?sSrzid6NSXdI/38CeXorV/l6y6uaL5HhhpmTWms0+x9NtadgkkCxCyuVtmhN?=
 =?us-ascii?Q?C/cO3AnUqOvEw36hLBt4thODyQZ+hpMHXzMfzqR4g+mvSCX3K5Bfv9PV0J5F?=
 =?us-ascii?Q?miolCaVPmI/v+3cTZ5GOo5r3Rz6xgwkmvCJ4HfMqlrobpNY73Bd2BLDjjQ7K?=
 =?us-ascii?Q?oicxq2bThFtG6BJnRpt/eC57mFzAwSQozP/Zytubxko0IjC95dVT+veFzxZn?=
 =?us-ascii?Q?T779saUJm0aG/oncxk9K5W5IuMZuHHR8Jgwh52Qnxp5A1nj/ubtNQa6p6++R?=
 =?us-ascii?Q?mCzrJ6qRKnJxV49SQ5aosQ4QvB9WbnFXSTEJQjyX6fvb4afaU2+HTxPsu7UF?=
 =?us-ascii?Q?uQ0RAP6kNX3PlXN1rlVKoj14NgtqE5E9iAOD68krxJjkByhD+qSbAWQltji3?=
 =?us-ascii?Q?2ZMsRVAV35VtCUURXoYwkA/NPKXPeWZMYf2KJ9xXcRhBbpcTst3XWgKUmqmJ?=
 =?us-ascii?Q?2fL1ildrTxvu7MTrcMbjG/okFP/I7Wfdg5LJmxahaMVzUh+IxnClkxRQWmdh?=
 =?us-ascii?Q?iWZA3RRidz18kyWfefmolZWq6KuFQNSPqHklaa8N9T68IDfD9hM+UGuwPnSd?=
 =?us-ascii?Q?Jd9MusqmF3B4Zv6Vtik4T+T976Qsj060E3kpuMAfZ4lVmQ/FSdaQlOArARKh?=
 =?us-ascii?Q?YSzWYkJCfzFAJsegLpyY9LMJfWesb0GYBYc2i6+50ud5iDTJCNXF8WdeFGmm?=
 =?us-ascii?Q?5eFmq48MVs1FlnqZc77/wdVaLVLDulYEKwv+UmftAJlwJ4+DnpHUmj9wFI2V?=
 =?us-ascii?Q?8s3V61ZuO7Bd30JFIuxHNNTbynWh8py4FOOpqm00k1Zzwx539S8aZ/5zHTR0?=
 =?us-ascii?Q?gbvZzXWLbZEyP40LZ7QXIJebCx+qs3SwYZgL9HFD+aI1V6gbphcLpxkhglKv?=
 =?us-ascii?Q?S4M++QduWRAOZ2D3yFur42IR9rsZzkJprx9BYCZuch9JMRsEphQgtnB2ilIN?=
 =?us-ascii?Q?g9qinMrqxjGmJzOpcKGv6zCLiTOr+dBz2+me5tUKYj5UxLj7HhyaHsQ7tSdu?=
 =?us-ascii?Q?9i9qty9U011QjHBYURhjA7vDJ/dL4b1IhRDOuOSXqw+lIwPQ7baNJ9TfumXx?=
 =?us-ascii?Q?nprzpoW8k/BFyZ0CSnFsGkG47WeyutVDslLiiToFjcF0tRJcGy1JRsZu0LP5?=
 =?us-ascii?Q?232OBtubtdvHWmgV0QqK05Wr59naw0Vl0O0EwWbAL1wn?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b888d0d-52bc-4312-f9e1-08dd3f35af0e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 00:49:56.0342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRoqSYVXtNB4FSdzqEBLeKQMzvgN4/Bv8dBDTn1EoLJCXKWQ2XLtoZDKcQjlTf5QUAjDLiUuDncR40MhTjUWJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5325

On Mon, 27 Jan 2025 15:31:47 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Mon, 27 Jan 2025 11:46:46 +0800
> Gary Guo <gary@garyguo.net> wrote:
> 
> >> +#[track_caller]
> >> +pub fn read_poll_timeout<Op, Cond, T: Copy>(
> >> +    mut op: Op,
> >> +    mut cond: Cond,
> >> +    sleep_delta: Delta,
> >> +    timeout_delta: Delta,
> >> +) -> Result<T>
> >> +where
> >> +    Op: FnMut() -> Result<T>,
> >> +    Cond: FnMut(&T) -> bool,
> >> +{
> >> +    let start = Instant::now();
> >> +    let sleep = !sleep_delta.is_zero();
> >> +    let timeout = !timeout_delta.is_zero();
> >> +
> >> +    if sleep {
> >> +        might_sleep(Location::caller());
> >> +    }
> >> +
> >> +    loop {
> >> +        let val = op()?;
> >> +        if cond(&val) {
> >> +            // Unlike the C version, we immediately return.
> >> +            // We know the condition is met so we don't need to check again.
> >> +            return Ok(val);
> >> +        }
> >> +        if timeout && start.elapsed() > timeout_delta {  
> > 
> > Re-reading this again I wonder if this is the desired behaviour? Maybe
> > a timeout of 0 should mean check-once instead of no timeout. The
> > special-casing of 0 makes sense in C but in Rust we should use `None`
> > to mean it instead?  
> 
> It's the behavior of the C version; the comment of this function says:
> 
> * @timeout_us: Timeout in us, 0 means never timeout
> 
> You meant that waiting for a condition without a timeout is generally
> a bad idea? If so, can we simply return EINVAL for zero Delta?
> 

No, I think we should still keep the ability to represent indefinite
wait (no timeout) but we should use `None` to represent this rather
than `Delta::ZERO`.

I know that we use 0 to mean indefinite wait in C, I am saying that
it's not the most intuitive way to represent in Rust.

Intuitively, a timeout of 0 should be closer to a timeout of 1 and thus
should mean "return with ETIMEDOUT immedidately" rather than "wait
forever".

In C since we don't have a very good sum type support, so we
special case 0 to be the special value to represent indefinite wait,
but I don't think we need to repeat this in Rust.

