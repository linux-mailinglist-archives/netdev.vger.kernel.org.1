Return-Path: <netdev+bounces-116534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8932094ACD7
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 17:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E18BB2C2D2
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E7584D02;
	Wed,  7 Aug 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M3oedXTz"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1271B79949;
	Wed,  7 Aug 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044277; cv=fail; b=OkFpEhoi9VdexlidmwUTJVQOaXmoOCh7wCRhUzk+PG6NyN2ImJScGNA7/FhFKFh6djthZLKD2QmNyzANZc8C1KA8q19earqjL2o0aW7RHhSOeH+2AkxaDmzT417eyrEV49ccY88vn2Zsr4j94JYCBlSfZw2OWBrDzVKBkxJf98c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044277; c=relaxed/simple;
	bh=SWfM2TnM2T9iYuycrBMsX+l7siNgUpdx/x9ZxX259HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYUwqx1ZGCJ3R97+m83/zPAMzWLmj5eOpwSRhGOAL5mSCNNR2sflg8dTbRB1N8rPiCygliRaHm4PMwTaJdsg/bI6sfRRlv+TaMWOTSkZySR9/oY8Wrw9Y549ZVCCudnHSWDLyt2fmxyg/w5rS98cmBp6YqVIrWCMKlCJT5WFdZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M3oedXTz; arc=fail smtp.client-ip=40.107.105.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpMNJmAarxY1ka1sndsMGIzXJUtLcYyaaDmlGVHF24f3yPTFjUL5jyphx4R2vLvlPaL0JObobdVntIDhyVMgwQZUq3FuIz0TodFUiv7Twr5yCbJuic86LCqg42L2qwWqFgYu7EdvwO2U1Zr3pM+mm8bSAtyqwUIjif3SL9Td4BhTO+27hZcEFH0EBcdlB831N+8byedWhI6aZUO/8zUXhHWZBXgsD1DmuZjQ6S5ghX4splBS+mtnvkIEjhdpwsCgKKta39ndL1CNE4b8jArxW2wU/sNW431klKEahveLZn5U2jL10LvtIurKppSVLxRmqJ4LNR3NbEpRMWeYvRQzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iqPg0csbPubyW7t7U6GA76CzeHD4MyI6iEbm3Qw7xg=;
 b=xCBX9V9GZH0TceDZCNRKdyCBjAQ5x6KlkDCA+1306AmCi6Q1sPu9TYqOU4YZ9K0RSTe2AIVlTI0BYM2/9ACll+XV9Tknb0+2ee90lhc8YntRd1UwnGrbCeC2n+rnjjnF/g6BNBEbRVVHSA8S9dTDz6tL3IbkTOBsG4t9nRh1zdEHqo/4O4QGKjrzZwz9FiQ7t9+jiIISaBawgjdp0v6Wqg/MaLvBWNK1gA/kgpG4KPgrHHzuQscqNJo3BHDaPdybn0rgchQCRlhoiWrB1Uo8l/AUvOGzZjv7V8BzTUFIIQ5eDix/1MhK3hUmAc7qa55cV+p4NBaR/32g7T/L4c+9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iqPg0csbPubyW7t7U6GA76CzeHD4MyI6iEbm3Qw7xg=;
 b=M3oedXTzUbry0zTKn1rb2AIlSR77UemBYyybGXJCb1UB7czd/eemLct5A/Ewd7KM4q3bVXtI8UFlcsJaK5LUXw71hekoPple5hGQutqd+v6ZO9UkQ+yapL6LWYWycfZ6wkJCTIlRKqzTCNnDtGnxOjk97jSSW74xeba2fmTF9glwiHNwrCM6u/Y4FndA1g6iJh0tp/zHjpim4CJxiqNGnQGf5R5xHaBX4AGVMGBYRJOVyEnMgl3ZHoTTnMkoKBNKaA2ThT/DJGi3p6UrM36P1KlW4duKW3nyeLLd9qycUM/iWkGAWAfoTTYuLOHiv/szhUnIXmminTnl+qEO0SsE2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8281.eurprd04.prod.outlook.com (2603:10a6:10:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 15:24:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 15:24:31 +0000
Date: Wed, 7 Aug 2024 11:24:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] net: fec: refactor PPS channel configuration
Message-ID: <ZrORp3VU7GFd+4R8@lizhi-Precision-Tower-5810>
References: <20240807144349.297342-1-francesco@dolcini.it>
 <20240807144349.297342-3-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807144349.297342-3-francesco@dolcini.it>
X-ClientProxiedBy: BYAPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc22f23-d365-4e75-a31a-08dcb6f508fc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?2MkIb9Dahv75qqVxRPnulH6sKbbUxH8KiWId90OgVyVTLCH9EZvdsTg02y/v?=
 =?us-ascii?Q?yZdFezWa/l8Hz8BUr8gyOGgIFtoGF+1pywbIqZBbfXUzkvSG90ZXimzgBkRX?=
 =?us-ascii?Q?PnUfph0ceIIqf3BzDnvIWR+mGQf0fmxAJXNi3YenKYXdJl+cmekawKG7blkH?=
 =?us-ascii?Q?nZw02sxzOICUpsaMC6jABu3lR2iTirGd/oK1ekZOgMewaoIJmdfXz+FFuE9C?=
 =?us-ascii?Q?Vp9mfx6uxe3gQpCEuWpTdOLpyhnzszNsRqphy6kQJlbfRmzPtiTSn3MAYbQB?=
 =?us-ascii?Q?k/OAFNHVWK/KllQzjMWGKufEwnTWFOYnwVu8eU++toKTfr85G0eraZhCrXGi?=
 =?us-ascii?Q?2yWMlTTvCUsa4gWfI50H/fWIh0JpeiCNNiVdVc5A+craN6uC7PNJaVcJP1Yj?=
 =?us-ascii?Q?BmkgPBRJntM51r8ryogztstimJdvo/3iUHgvCASeNbtKBjxNA5qN90Yw1tJO?=
 =?us-ascii?Q?Uss1K2WZda/3ZsqwgA/VUV7FsyRdEHjxKoLZQhlUtGlWydbzkw6azBpgffyz?=
 =?us-ascii?Q?jTyRCqBmvz0DY4xEeS3syAbeAudafmMlSEo/0Zpi3oU5+WnKeqaIXtFu2m0n?=
 =?us-ascii?Q?r0yMqpdKIb5CdTBrnF5KyjG/dtrIvWEgm1JyRKuhWfFP0BtGqJsLNcfgtuP9?=
 =?us-ascii?Q?FHzgrdLEtxA6eSBDMbKduIrB58Yap93EwG6t0R9fwgURjCY+c4gJgI5VB4VU?=
 =?us-ascii?Q?X5bX5cX67HzPyNew8Idc3his4fAFNANwcbQLImLWbg3B0AUCMl4NHXaE+nAy?=
 =?us-ascii?Q?ElbETIDiU/uTULLoKgHg8VNLOxbeVa7Kw/2ubDXTlLnReV8ofdQrUOTxhf7c?=
 =?us-ascii?Q?VdrPqrVceDwRwoqhbxfDAhg4N8A3+un3gGJSGfs0FA41WshZJG5vl4nRDcqH?=
 =?us-ascii?Q?USG3DOZtu/Tz32pvLClw1um+IlI7TME2MvNpsHKR8KFSOJHltA+nIBv8VoPr?=
 =?us-ascii?Q?aQbWjMuiXLk0casKUg08W8h5P2XCIU/+kkl4FNJetglWW/0lmULhvJUPNLZm?=
 =?us-ascii?Q?qe3U7VWyka3HeFkC6Spk3SdWJzJ8nGuU7O28qFGgRoJdWjfoFCr5eT2DiLY9?=
 =?us-ascii?Q?nSSzMkAPlkNRIs3mR/lOLRRgzcp2uBjhOTTZB3tMtFwVEOtCpQzeoMzSZAUu?=
 =?us-ascii?Q?zL06mEou+ySiB+Gp1GDAo/Yy/ZooFH4MloLedf7NoozKdMYrSiWXrXRg2V2s?=
 =?us-ascii?Q?Tf3wOV+KLPe26psl/LPKqQgQGb89noirL8wetqUQAZ4r1ib8hN6W5gdMq+fv?=
 =?us-ascii?Q?yHSV2t0/6Sx+XXsX+yZwh2cEgcIMWAbKeUn0HJexOiy54U+JkerFYJN+/li2?=
 =?us-ascii?Q?j9OdEE7p0Zu0n5ihjhKAUzPf6FfvTJ84yKNU/G0pyEmsR2kfyTqdPC2LVFTa?=
 =?us-ascii?Q?aQee2BPchn999CDlDf96FUVX37fkURHAc1Sak4Iajd+Ar7U13g=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?EdLTclGg/x8a6J/DIVi/sxu/Gf8b730j2sHTuhSv2wzjAnaviRqmII/OyJJ0?=
 =?us-ascii?Q?/SHfXAqBv1C7FToZfrsIFgZjAyCoNUIAa+CHok9EpEgEecWvDS7IgcE1RQ+f?=
 =?us-ascii?Q?Ysp+AkLULdVVuU5rKCE/gJJoScsI7p7uEYRioaKRbVSvYxuQwTqrbqUpNQwH?=
 =?us-ascii?Q?H+VjDFpLPBebLiBEIh6cW2b5/Ylnwume/M8N5AlXOfPV5Vnbjpa3Gl4N4OdP?=
 =?us-ascii?Q?+bbq0Ope/SKuXu1bUqo7+9x1VaxSEQzEw/QSAC494daqWdrtdILw379tlOex?=
 =?us-ascii?Q?Ino8v/dXBqybgPvSn3LKiEGZlxaEQG2xU9wYk/64yBviYfRfNtB7ihFdAF3x?=
 =?us-ascii?Q?sw4Afahh98caLtj1O24S/y8PeEDUZZcoBfUDhXtXu7bUVcvb6GAMXKYJoi8R?=
 =?us-ascii?Q?n0Ua3uSLdOmwyw+L3Q+BQ/a/QBrqyJ+tsxWHN7rq2lMtXOHsaEEl7STE8L3V?=
 =?us-ascii?Q?6belPIz8l1+5JlcAsloy2Semp40HcLzOmMYex+ygmmKXEQurzLbilr70MayG?=
 =?us-ascii?Q?/w89+9ZKJma+QNRZJMizFPeCqAmEwEoCFDTrnA2zu7TpDE9qq1UyhlZ06aBE?=
 =?us-ascii?Q?fm5FyT8gkp18uZZnlQdaX+Bb0Wo7vEDmwUrxKU16ky6rjhSuIbKvNJABfZgY?=
 =?us-ascii?Q?+oEHcHMVw0+HOZy1E/guBLTul3Gsvk1zR+7vSMniHtDVhzmdrK/ThhorQd/B?=
 =?us-ascii?Q?gdv0RNj1ycpW8eKt5apr5pBNnCTVgR6owMjfIhIzSVTnaXJr+4ryaXphKIU/?=
 =?us-ascii?Q?4RAyvLOppCl5HkcvmFFNTsKBhOcsTBGqA2B6F1hZBItcT8mRi8g/I9rLYdOA?=
 =?us-ascii?Q?ValR2EjHG7rtsmsRZv4N0WZPhsmqntZDWkVjKz/x/+RBa86tjxDngsPsqs4k?=
 =?us-ascii?Q?3u98goL+Fc2J5Q0pv8GFrNq+MqKqjUwH7WyTmdQfQHzXE0zAG5C2k4+0mRxf?=
 =?us-ascii?Q?RYLTkSn8tdjRF77hYrxqvxGJOUyDhLQetIiv5lrkeL97pnt5bEgrki4bmmaq?=
 =?us-ascii?Q?MvRfNvVoh7LmrwSUqK23eO6yO0ZlPXGQP82WluMlFgKMmPD1mp4fkTGVa01e?=
 =?us-ascii?Q?Z7BCcfaTKwDA1ZgBVQkD3v7yHVfOV1ojMCDPypTJAR5MmfIwWZyhXM7GR/C9?=
 =?us-ascii?Q?GyTFobr1VzG/Ap/tcZEzs+d/Vo6x7MasnTDQP4ssfaCfa6tffzm5aJl5v992?=
 =?us-ascii?Q?HfLRNZs0GcJpOgxYibiUhTNgnNEHQzjIl66pX7ozyNGfEk2Y8DyY+4N2SGwd?=
 =?us-ascii?Q?RUnliZ8/MZY4bLv71Dw5xuL0g2Zr/maLg2iWc156XVNPIqvIvxKoI1Z9jGGN?=
 =?us-ascii?Q?AUcUgZ11Sy7DJjdviP0VOE1q0PLBR51kxg/sJigvhchihrMFb9IffxO6fQYO?=
 =?us-ascii?Q?tbhLC1xznNg2OPq64TtUtxaNoJDkMRcqQrKltLcRuAvR+zz5lQPjgYXwBGhb?=
 =?us-ascii?Q?Kjq5El0z0+hEd5HOUjbVohmkDwq5zUR4E73a48UHg3Xk88TfMRsGfFhjmPom?=
 =?us-ascii?Q?Jsx4nm3dffouuplypYDcwpLHaQK1OUFFCU7gGxmuWMT3eqYYSfm5wY/Qb+U7?=
 =?us-ascii?Q?FSnsma0BDW8+A1F24l0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc22f23-d365-4e75-a31a-08dcb6f508fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 15:24:31.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DslkKCPYUcyC+QveiquVpaAh+rAxM6eXo738AlwEfxGzXwRn0ck3eveAcQNCJXOTBmsN+iWnbXwpKBlURLeFhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

On Wed, Aug 07, 2024 at 04:43:47PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Preparation patch to allow for PPS channel configuration, no functional
> change intended.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index e32f6724f568..6f0f8bf61752 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -84,8 +84,7 @@
>  #define FEC_CC_MULT	(1 << 31)
>  #define FEC_COUNTER_PERIOD	(1 << 31)
>  #define PPS_OUPUT_RELOAD_PERIOD	NSEC_PER_SEC
> -#define FEC_CHANNLE_0		0
> -#define DEFAULT_PPS_CHANNEL	FEC_CHANNLE_0
> +#define DEFAULT_PPS_CHANNEL	0
>
>  #define FEC_PTP_MAX_NSEC_PERIOD		4000000000ULL
>  #define FEC_PTP_MAX_NSEC_COUNTER	0x80000000ULL
> @@ -530,8 +529,9 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
>  	unsigned long flags;
>  	int ret = 0;
>
> +	fep->pps_channel = DEFAULT_PPS_CHANNEL;
> +
>  	if (rq->type == PTP_CLK_REQ_PPS) {
> -		fep->pps_channel = DEFAULT_PPS_CHANNEL;
>  		fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
>
>  		ret = fec_ptp_enable_pps(fep, on);
> @@ -542,10 +542,9 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
>  		if (rq->perout.flags)
>  			return -EOPNOTSUPP;
>
> -		if (rq->perout.index != DEFAULT_PPS_CHANNEL)
> +		if (rq->perout.index != fep->pps_channel)
>  			return -EOPNOTSUPP;
>
> -		fep->pps_channel = DEFAULT_PPS_CHANNEL;
>  		period.tv_sec = rq->perout.period.sec;
>  		period.tv_nsec = rq->perout.period.nsec;
>  		period_ns = timespec64_to_ns(&period);
> --
> 2.39.2
>

