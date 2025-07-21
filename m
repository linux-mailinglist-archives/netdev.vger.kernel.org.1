Return-Path: <netdev+bounces-208516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A67B0BEE8
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CE33A1BE7
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118651DDA2D;
	Mon, 21 Jul 2025 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B6FrB7o1"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011058.outbound.protection.outlook.com [40.107.130.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE3A20D4FC;
	Mon, 21 Jul 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086621; cv=fail; b=ovOYvF3bb8fYCr3gzDE1aBqHGlhH+2wR//9kwWOap4oDy3dejwpuU9c92Kos0QhhPHIiwFLrrIHuqLF2f0MBlbae+PMarJdn/cWaspvUjzjBRY1dkW5sr+NjWfxmCJIAileyFpRUUp4h+qiS5V3uWdhl7Hm4kce3JNpa4r62SD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086621; c=relaxed/simple;
	bh=11rf9ridnohQZQzF/8USxbibpG7oUN4NvpugNkeObPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JteDzwACw7NbLH37KztU/krOeLCHdoauj1xLePhf58EfJNPKwlZsydgETYICCOiqdvNzr9bSn80iRL9nB8dCGw2EkEKKnoz2OpzCJW5uW+PHRRJtga/bAhgRWV77uTT4LxX7uWtalEXUYPKMP/z4xRfL/Vf3rgWxur7JOR7Qknw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B6FrB7o1; arc=fail smtp.client-ip=40.107.130.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oB3zhpcnLZXndNSEdTla7n0zAd1Af8M+ORJjzNzbSTzQJiaZAjEJ/7Y6i0+iyF9IPBHoM8Y4VwIrjfbDyz+J9plq/ll99/YcelAnhPSGpKG/uEijGW3y+K1gwfQKcQg31lAn8gSFvj6PSwyrLXIiolQDx5IUZnNIpI5Cx6dwkwRGgQJrHFE9idRBiCNzdyL2GCA+bQrTEXOtaNfZfPrAZ9xnbcKkYmqxUA+sozdX/CSYJ4pNNjHrWWxKSBsmKCRH+Yu8Qzijx+HJN1A2adwsL232pbTMLTfRm15ivqTCI3TyUvmfXfUq+6RN6IziR4Aht0dlQXSoszPN1IPjGn3G6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Npjq8KEjahHmg++S7KOWTpjcUxA6FJCltXc5/xHS/fY=;
 b=UqfeVvC5AOl+tDgVYGOLX9uqbFxYLm9IwYwzykoMdlaaGpJifLuCjBmhLwfMMk8KGREUSg8ZacXkbo5DQukyRKzBi56JzU9bxO6bOnHGq8+JlYJeWhuTrslLZhgDQhRTFthfJuZseN3OUhXUTJhqB4ecbtGh3R+VyUzgg+mBH8F/DTRmbXEHR9a7/LOyxUnSMoaESyCFoNE4wsA0I564dFkPDzxNsK5/ZMddfDRmrItg8gRyPZu2KUzIsAmJMZ6YQYynW2qakCxipL3z49a94g2XQGgdWzFg7RDd1iandx00fR6A36T8mQ3Mi7O52bg7gLWRT1EMzkNS4DVZxSXDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Npjq8KEjahHmg++S7KOWTpjcUxA6FJCltXc5/xHS/fY=;
 b=B6FrB7o1rzW2uPvtWOTxFcWKNKLKv1X+6sDsCaIeW4fU7V4HM98++ZLZXr7aH7OhV8itK/DcrEy0WLSC285HHD9IRxq5SEe2gkxHfHDmUas837nuK8DMy+2nSHALJeQ4+l4QWFL/N/DMrWLlw2tLlNVv941CcC9P7in8+zLAdPl333y6/MQZVubP40XFI4/keI34HtY+3rA3KLcIz+pekbJrilUVul51/rqnBFtvZ8CFD8Z0sfILhOg+N0hCAf0Hbih3sZ0MgsS2Uke8TDv5M3E4HbPR68fJUVHKxltBMS5jNr5/aY+a6gbOMiQ4oFs0QpQr+A542GOjm7YMZbOp2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8589.eurprd04.prod.outlook.com (2603:10a6:102:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 08:30:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 08:30:14 +0000
Date: Mon, 21 Jul 2025 11:30:11 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	yangbo.lu@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7cfb66a237c4a5fb22ad@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] ptp: prevent possible ABBA deadlock in
 ptp_clock_freerun()
Message-ID: <20250721083011.zesywxhisw435g73@skbuf>
References: <20250719124022.1536524-1-aha310510@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719124022.1536524-1-aha310510@gmail.com>
X-ClientProxiedBy: VI1PR03CA0055.eurprd03.prod.outlook.com
 (2603:10a6:803:50::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 785884c7-1ac9-4356-4d5f-08ddc830d09a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zavfSxH0U7REwksUdjG2TPCgkxjEfklZM0EEi7UjW5BtzAo8N5pPCjPjTDhH?=
 =?us-ascii?Q?nAuypLtcH7voRgil3crlONDZMxzCgy2vsptmh/I8tsHJjkCNOIUSdiSmmSAs?=
 =?us-ascii?Q?6P06zUjtHuSAqALQVOFY4SaGHQdj+U+Qj1uweZevr53Z8eoIRulS+Rlx7CB8?=
 =?us-ascii?Q?rbVxwB+HkCUIfu8TWGahxCYjc6ZjYRrZWaKqGAPYdNrRtgz3lB9llqLnX29R?=
 =?us-ascii?Q?kEYysmsLO4SfNL4GgCsjfvsjFVhDpfwqNP1cFarlkFRbHbu5/xF9yB+S0r/6?=
 =?us-ascii?Q?NcBiRExqm7J8RMpCyw67D4nlF7kpKLJ6zEP7kfaMSr4OXnkUFYimmUadqXvW?=
 =?us-ascii?Q?0eOLal8Ad7ZhZ2hyBn2CkgL02n0E8mj9qu7cr7jyRjwGlgttxf8JJyFp//H0?=
 =?us-ascii?Q?lps1pxVoXC6Rr3pfm0x7JrzxEOIxQDZ83zr+xI/BDzHcwEMT/A5LDgKV4dLC?=
 =?us-ascii?Q?mOPg0c3/Or5foKqgpKdFILiN1p0oz1lfbsqDdgkYOOpYR5vUCTmtVaYSSyfa?=
 =?us-ascii?Q?TZtVBQWKP4fYx7JMxtBYt3nsLY7/Dr49wLLJ1d5rQv+7ppfPEcvgag86zYkS?=
 =?us-ascii?Q?EfWpms9u6TFoajNe7KphRpBPYjYbivFOx/shHMqkPAeP7V20Zo+O3GBHx0er?=
 =?us-ascii?Q?rGoME0pmSKTZcBVHR830UulvsliGIQu7/7z7R66ccfOynrwqlTATV/ephZbl?=
 =?us-ascii?Q?bWLpdfT6AjEP5X2IWK7mjOHGBWfFPmSGCTvDYgd1ODgh87fcHsR/cgnXaA7u?=
 =?us-ascii?Q?3fgw7OvfmIrL8y8j/Q23IB+uvtX0XSjh4z5Lbs4T0ubhWfFt9FzL1szKt4gO?=
 =?us-ascii?Q?IiR7ZOE9aroVAzpf3+dYWWpEizvsUI1WRy17ZYwjmoXe3IRdnbqSBfgdi/gm?=
 =?us-ascii?Q?Hvq48AcUxwDhJ8qY5toTR4Tyfqz/25GT7Zax5QPvyVwlS8sNffpb1NiYPRZA?=
 =?us-ascii?Q?f3PJ8bdGaFXd0lohzkmtOZQlzELER/6G2p+GOLVrzaVnUO4odyyLbiNl1+0n?=
 =?us-ascii?Q?JPELC7uUz5x6k9Bq/5+l3O97hhAvUs4ouwfjkbnMEfltz0xW8bGMIfmJpWai?=
 =?us-ascii?Q?X9VSNpSlO8ohNpz0nnxOC5r6zZ+iHzI0PxfvN4lghLnWNj0R07vGQ8bPO90o?=
 =?us-ascii?Q?vOgAviUb1LURUCijcyKt1b/SIDc+YX0jBXOv/QjKyKqgb4aCXBITmWr3vYt8?=
 =?us-ascii?Q?GXubfxulF0dpN677U16DRFKzV8BKWTKfegbFh7aSlpIOUjHvkGaqWpLv213A?=
 =?us-ascii?Q?7ncybiSdL8pjX9mXNRQx3/ZQFAw9Se4q3Ny8zNrYxYahYurojqJGfGXzqu6U?=
 =?us-ascii?Q?cyjtZZ5aX/r3DCX5nGjL7tfLGNvDdxn2QyJFIfDKUdeNZFvz5ZjOx89ngHaS?=
 =?us-ascii?Q?JGk5mBBxrtciESOQfBatT76xQUoRxJ9lBpmvKsERAg3rdYSysQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N5slFtzpWWHcFhWY0lu0egksV0rT93u4UPynIpVbFT+Er+t+IAn9WZ9FanVu?=
 =?us-ascii?Q?MZbKoNYoOIc99ckge/rhwHKDMoJZbv5OIdDv2hgHEB9I2/rba8nmSOZj/gZb?=
 =?us-ascii?Q?y4Fr9gKyuvvUZn1fs5QxdtmE6UTufVjQ9PQNSWkY+hIEFFc+41AadL6nMl1g?=
 =?us-ascii?Q?fz4IVU614mmCWV9ac1xYkZU995M7miWfHLOIMvUTTlCTMtlIATJqv3ECrq3i?=
 =?us-ascii?Q?lQke8FA3DmM9Zs5dDRkCSWmhw2tzUff6CeGf4ivOvSl73cm/E6yd5xxfCXoT?=
 =?us-ascii?Q?GqVPCC1lB6Hc61ytTRtjYBkJ/WqzWXL74d20fAJoGwyt60fORjmKtkFc1NP0?=
 =?us-ascii?Q?pWEau9T/Nzqhs9vw9YdAENBKweVCRb06qDqIQPNFMVZqEUN90hDUQEU/E0vF?=
 =?us-ascii?Q?sr2W7CYLrMzpltkGGxZ32nq+d40NjUGRxUEyboMdXAaLOVNndClFf2vtIr0o?=
 =?us-ascii?Q?RtOq4SgkRqNo7Dew0O+KlH8d4x2I2HcOqAowt6gibZdEjw5+mDNK6pcgitKx?=
 =?us-ascii?Q?HvHAJsgy/wVRSZmc0xIm6CzclbE2xN5pEjgXKNKo4QCsLwQ4MvIJmXuWWYcy?=
 =?us-ascii?Q?iLDnlsyx3W7NvOd3qPxl4Ave40k6E8SUBOzAws3hBVdPeBvoh/J96Ch/5MJx?=
 =?us-ascii?Q?aG3yCbKsVD2n3BqgSC6JweTIVaKb7aeiAMGdj/TruSfmCx/g8DnvfTFcxz1j?=
 =?us-ascii?Q?vbzW733Qcj6Kfx8V2s6qxu94izJjoLAROreRgXnhIcCCzXC9ActEzIAuksL/?=
 =?us-ascii?Q?oWeCwsOFxUepANdKLgjpZem5Sv5UHIgV+BSE0GZSuFyXz1wMffoEAK6uKZrU?=
 =?us-ascii?Q?n3ACVqOkMQP99yrFH6ye4NDfdibShAt01tqnEEypYsHE/1vPQGnMi/U5svex?=
 =?us-ascii?Q?ORj6vgIqrZrTL09n4bdsSJ9e0wQzLMiSR04HzWNdheX/col4tD/jLVTpKIfG?=
 =?us-ascii?Q?p0I9gHDv7+hpjuT3WifyEBuvoEahHl2XdVGJwmmngAQBVa8GOJ8Gl6xjGwt1?=
 =?us-ascii?Q?QGWW53drk1NznzWcpMQoRqukN3N0wyu66wo0RcC0iHslQBIp2DXhp9TMrADR?=
 =?us-ascii?Q?87BM+17qjoScOjfiSzMa5TF2fgOeCFo3kqbahfO8xH3yLBaH3mQ71wH8t+eP?=
 =?us-ascii?Q?iabKz9/pEPO1NoB7RsOfqEMMrIlXbFL93oxgeY9L0vQ5tKitruu4RhlJ5w3j?=
 =?us-ascii?Q?bUpe/nIxKJ31cWR1WEQzowpF6OS/32by8jT0kKz4Zg5mbNWPKEZL+uFoOqhl?=
 =?us-ascii?Q?hzz0bNkeo4U02N/1F1hkezFCYTdESLA8RUaI78m2sFxp8Nti7md2se3TipAi?=
 =?us-ascii?Q?7eGb7eUGW+ux7qPUtp1l5pamrv6y0wcIwFQFeIKFx7bgm82ptjphYq6aiyNJ?=
 =?us-ascii?Q?BeiY0z4Xuyx5o4LAPYqFvkH7VeMl788mtOaeZRVYDWdFaVRHqEou/XxrbdLA?=
 =?us-ascii?Q?gYMIZtiZmZTAjXx3cmilwDJIE30iA4/CvpwMab5g4IE467k4bjvyv9mMoYeL?=
 =?us-ascii?Q?x6ql2WVRhIcqbyDO0O3VFJBoqX9C7o47Qi83/KsnHmm72w6kLHsJ+tUU8IJ8?=
 =?us-ascii?Q?OrI7aG1GZoje9qzussh8U2E/L7lNaWp0RKKWdXyB1DlH0PP+6WiUo9IJVTha?=
 =?us-ascii?Q?a6btg3DKzeo7H2hVAEr1mtKl2a9RS2AcYNQ8zFiOcUB7CLo6KaWF9oD/iW1K?=
 =?us-ascii?Q?dkPWMQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785884c7-1ac9-4356-4d5f-08ddc830d09a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 08:30:14.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqfx9+sjgLTYkUHTBRLQr/X4+uSe1J1yL1D8BHuZN0MLtPzw/VFO+LCkBe9ElfNd8KvryAuRsatOPRg3+NKlHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8589

On Sat, Jul 19, 2025 at 09:40:22PM +0900, Jeongjun Park wrote:
> diff --git a/drivers/ptp/ptp_vclock.c b/drivers/ptp/ptp_vclock.c
> index 7febfdcbde8b..b16c66c254ae 100644
> --- a/drivers/ptp/ptp_vclock.c
> +++ b/drivers/ptp/ptp_vclock.c
> @@ -154,6 +154,20 @@ static long ptp_vclock_refresh(struct ptp_clock_info *ptp)
>  	return PTP_VCLOCK_REFRESH_INTERVAL;
>  }
>  
> +#ifdef CONFIG_LOCKDEP
> +static void ptp_vclock_set_subclass(struct ptp_clock *ptp)
> +{
> +	lockdep_set_subclass(&ptp->n_vclocks_mux, PTP_LOCK_VIRTUAL);
> +	lockdep_set_subclass(&ptp->clock.rwsem, PTP_LOCK_VIRTUAL);
> +	lockdep_set_subclass(&ptp->tsevqs_lock, PTP_LOCK_VIRTUAL);
> +	lockdep_set_subclass(&ptp->pincfg_mux, PTP_LOCK_VIRTUAL);

Every other lock except &ptp->clock.rwsem is unrelated, and I wouldn't
touch what is unrelated as part of a bug fix. That, plus I believe this
breaks the data encapsulation of struct posix_clock. At least CC the
"POSIX CLOCKS and TIMERS" maintainers in v4, so that they're aware of
your intentions.

> +}
> +#else
> +static void ptp_vclock_set_subclass(struct ptp_clock *ptp)
> +{
> +}
> +#endif
> +

lockdep_set_subclass() has shim definitions for CONFIG_LOCKDEP=n, you
don't need the #ifdef.

