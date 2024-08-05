Return-Path: <netdev+bounces-115818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D167947E20
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 723BCB23731
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B1613C690;
	Mon,  5 Aug 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cAnzkzGS"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A50502B1;
	Mon,  5 Aug 2024 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871891; cv=fail; b=dmv8O1VOust+C94maPPbkjeVtFV4wqYc4x2M//UiJqSX36ldENE+w3l7U5uJCFJNXvcDXHxWOyfvZE/adh52mo1FWA4Js+TzK2X/MRiCuGgSH9A6Dw65ZdV5z3EstHgdbVC6ictfZNsqa2HW1s32JlHiGJE/hSO4uTc/ElJcSW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871891; c=relaxed/simple;
	bh=eH6dwJDT1Yh6MO5stJP9gHKefOcRv17JM3a04E/JzDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nKuDoC8JOvbzz4A79Jr2zEDH2dQn/Aq5oBkMgclSN2YcznQTshMGMkxqVFGt7zKQ5853k7RJmc4X9Wad3lYQFw4fLP5/AdHyU8f49RKVcxOebQvqPNZpoXvFLxxJCQI1NQ9kLL8XTvgV9ELS45THz7/xTz2dIgLakhIK+IigBUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cAnzkzGS reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNLYcFHH3o8h+sRTCbSKbBO19ed7+CBZDHDkRQ4kpIwxAtwrR2ctNPIeuN2bzK3vNOWt8Cz3zU/p8kstbLWKRs+xqNIkVnvC8+NuFs2fuK+sHZmlZaeX71dqzc56qexn/SGPjZgsH4jI3Q3J6Ca6INX4uBKcJ4LWLDZbA8OaklDD76i5xLgT2+cbk7LMmIX4gicoN7hIUn0RRnfIKbWW0LnPdWXWLHT0IkK9T3XVNIq6vwCntHVA/2KacCYfOBH1pqG/+Rc7R1YoPuxPk9QCgPnW+2LMIdXchn036PEiQcKUOOqpwCkb5RhTmQQF8aKXa5OBk86s3WChP33g8TTOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nwIZd4zlYKSrz3mRhaD6XhGpsWDWJUE3kmsDMeONEI=;
 b=Tl52McvgSWRZnVeJoOC9TJspEIlzPFsz4wkOjxIO1gSEID+0bz7VchyLy9mMZVf232sWzAC1l0yr269K9Mqi1Oh9N/HWwxxrxg50g6UrhFL0/to/eVZwzafle9z3UGcMV6kddBm7a6Yy3tExucegKNYERllw6Z3cTXpr1Wyj8Ab2TI46vWS0oFRRuu2clY16p0GAUhFvHtPAlkeV/VjpRlv7GKxjCNYHPmeoM+wRAAFgLrfkkj6W4o81wpjFGJ9uakLGYzSL0oi9m0nQOS7a8wKHqTVP/wM/lHE5ck+G0AveteQwYU5TGruRcU0M8rVnq7kvldqaNLazyIxJjLys7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nwIZd4zlYKSrz3mRhaD6XhGpsWDWJUE3kmsDMeONEI=;
 b=cAnzkzGSaCKfPLwqx+G7J97qb1z9WCyfiZq6FfXZ8v2a4yD+7Gc6za2h86p8pjtGNX3znD3jxdv4rOAooSdHQJqDPKSiJC63tPYRF6VCQfav6Yb8E/IvgWfIj8p8kc3+BQVQpNi3xCtZ3jXuLnosAl0RfStIEQWeFs13I+0mLIxciKceKEPssjVmqb0OViyL182Vjk9d7bqTXaZZd3Si6LvZfOvk7A/zI8OPPzUqiQslAsLVZG0AwBvtr1hDuZl7cpjzyAFEivFaTs8GauWeUcM9LkIm+DgvKQgOwdomCd6vM5Dy7TjxEsipnAQMyMJQN5JHKEQOISO65WDoFDIZGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10373.eurprd04.prod.outlook.com (2603:10a6:102:416::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:31:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 15:31:26 +0000
Date: Mon, 5 Aug 2024 11:31:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH] net: fec: Remove duplicated code
Message-ID: <ZrDwRBi8kS6xgReQ@lizhi-Precision-Tower-5810>
References: <20240805144754.2384663-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805144754.2384663-1-csokas.bence@prolan.hu>
X-ClientProxiedBy: SJ0PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10373:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bcf193-55dc-44df-a040-08dcb563ab0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?5Sp2oDCsMdJ51vxVLSKtlVQzXGlYTF6atxUc5mNrtwAnA6YTAJbBJQCqqM?=
 =?iso-8859-1?Q?xWG0vyfARkqDyTcPusldX8ac3KTBRM1enn64ykYcDineZkIlUJTW6zxbTI?=
 =?iso-8859-1?Q?XGPn7kw3ViUOOYliZHNoFYm37NfQ1P/IvdCs68QqcLTI0mAdCWck/l7cnZ?=
 =?iso-8859-1?Q?LrTBcgZKTyt+LjMQ0K3Iiapuggfi24QHemDywkGtWa+ttV0VoCfTPqXXO4?=
 =?iso-8859-1?Q?U2ex7M/c9vRwTinSSTFDsx1mkXAPqfErEZT3yuZvvsSq2iWyTM8EqBl7o6?=
 =?iso-8859-1?Q?Ihq8sg2xJRl8b067wSGM1xBY74weI7vDTVWCs1pxkWMJXkP1OdNxjl5CAB?=
 =?iso-8859-1?Q?WsW2BQ/jyuopoRqgSjGM8cNc3mKGuaohBHZ6qbn2pwSmCx3ANEsjdaFmAc?=
 =?iso-8859-1?Q?2TiVXMjVlEJNDCv16pA5LHxf6XMAlGg2KUxYxdFrrllsF2Pwcf+PjM/Fpk?=
 =?iso-8859-1?Q?la/S9LchR0vNN+Zo7Iliwlu9+qg6zdfit7GLNqiyUMY4lU7lOiTzYH0aHr?=
 =?iso-8859-1?Q?hqowOjS08V/Lp25IbcLq6EHWENBjVTgNkCgtKgb5PehBW178hGVNdqd0Vd?=
 =?iso-8859-1?Q?OkYju1cH5juUrIGrw/2oGv3Rc0oGSrRZefM3FjmbyzedX7FAf3vrLwrCVM?=
 =?iso-8859-1?Q?Kc77+3ryXWFeqmSFpD1yuVawLnf/zfIm9+esdGUpWdGSNHL5baBqbsl6xY?=
 =?iso-8859-1?Q?D4loK6esG8qcts2+iGvD8HUYkRCIkhTKllKj5EvhJrw88xgOWLdNm+3ONm?=
 =?iso-8859-1?Q?iId4I1edmFTrcE9eVCHYrd0QWNQV6U4Tg9rLF3z3HO+yLeoZZeu5tL/oMM?=
 =?iso-8859-1?Q?9gbn0EJ/j5IlV2wEEFgFJEeKeKNGSpFDNL2SoWDwE62j5NAfYBXC0Q39na?=
 =?iso-8859-1?Q?9tBUZd/6GPQGvAtSgGYdxmgdMOTwScQ9ssfMIlqNCvQ1vsbCaOAFBpRhWT?=
 =?iso-8859-1?Q?pNLyeYR29IajSzplvgcXlsyIifJkuLPWi3wcmb/Npci5jAssTr/nPBrJFS?=
 =?iso-8859-1?Q?Qas+CNDdCdht85ey2UFeTibnEPpwp5oMdodV4qkh7NkdWTMTCAmWva94H0?=
 =?iso-8859-1?Q?csLV1tVMoRRyOyrNqhRadOyiEmawn++vT9S9UlT0Djcj9v57Ag/SSVrxiB?=
 =?iso-8859-1?Q?lL8NqvwSod0WRuJblsr+IIR8Dfl85+sX7+I1F9WFtV2ediFo/kk1Bud2ur?=
 =?iso-8859-1?Q?RmvQbQCycsjp1M8xjN9QebYrwZer5bxq9kgQzhkeuR1kN+Fe3SwSvQD+Ie?=
 =?iso-8859-1?Q?1yyEz69cjCBZfZM1qRqVfWnI2iSrIwjUgp9YCONXAw9JAipNtyTW9w572O?=
 =?iso-8859-1?Q?I2IPKYMRMQwW91iKx4Zy3acfBQqQMWOx8XGWPpfE+Pm4t0U93qNs5wsaAI?=
 =?iso-8859-1?Q?Ohkpktusxb8c1e/NfZFEG0ckUbZ7Blohn/Zr2seS+XfFGYDkDMr4R2RJs3?=
 =?iso-8859-1?Q?D2sO3hQhgcAytupPgDzDmCxO507aEXR1rVeupw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?CMqFBKksTbzrLs9Q6T75sYyDYUhoKwiSibFcH6lvbeha1sgK6W2u0w6pda?=
 =?iso-8859-1?Q?q4lj/kC1/PPS5kuHz3yQ62qCNhDLzTuHhIfB3kSHL+2sU84Y6sZ/qsTCVR?=
 =?iso-8859-1?Q?/h7E2IXNvuWqxMJKC4e8tgloDQUmFRAkqyHhZ2f1UgJV696kw5qrwFN+4k?=
 =?iso-8859-1?Q?SHGJ18BFglAQ+eKrelANrY5YZaojADTdNXCL0GOshdpSIRS2NFa7BVEDwL?=
 =?iso-8859-1?Q?QjAz4GqxZWZWok45+lkYU3znqaQ8VCHHVgopO1WVzHP1uFVLqr6dzF2tuB?=
 =?iso-8859-1?Q?u1kxms8TkCvkF+oMyjIRSxsIJmVs+wEy06d5tWZ6F1i0u27KC3ZVy9vThZ?=
 =?iso-8859-1?Q?PO54N1GpIrGD0AqPG17oRExf9YmCZ2ysmYuHXP8ViBCwc0zwtICiG+YdsG?=
 =?iso-8859-1?Q?SGvslA8fEjpAnSKJQxAbMIqKSjYYyNOpA5YX3IhNndrav2DGJpBzM1VODD?=
 =?iso-8859-1?Q?+AXn+xr76VeO0hyxw4JU6Z/2p/Cr9mTcZJeIx/0+0rUdcn0gNqWb/OumnI?=
 =?iso-8859-1?Q?ZjYicNJ4icf2ZIOCvBfGm0VVL78Lv+JQ60im85zOz8gQZCRZwvqrJY7BoA?=
 =?iso-8859-1?Q?8mLRCFwahpHIqZut7oEDZyTbTX9FYY2KrqqB+Jh04KKpHX3HHcOgR1DHkt?=
 =?iso-8859-1?Q?IDYXwwjteyUHro0YMDuaYETVtJ5f5oAaUIGwFJDSja4dbYLhkTE0NxpNON?=
 =?iso-8859-1?Q?lQMoudMI2ZxlIMj8Pgaa4nMnZlpBr+Yek4af9WiE6lbPjhwRbpLJRApFYR?=
 =?iso-8859-1?Q?ZXYkADGg0D/Z8PSo/I+VVntFLHwGnMR9yfw2bxBMlND5G4RPC5URhfgbzu?=
 =?iso-8859-1?Q?jdJ1kPlpWcciju3V5xzDipb1PK4788BsbYYv9vEjfC2GmaO+3P3CseBI54?=
 =?iso-8859-1?Q?G9ZsXZTMcx48rqUKO/yl3cnzrA8UNHc2Sk8oOUXU7IrBwbkT0K8n5iGAG1?=
 =?iso-8859-1?Q?HE8/Vi5NvvWSzGMtDG3HvALNJKxMiy9GoYCXFxoXjG6zHKA+sDvcaVFwSt?=
 =?iso-8859-1?Q?PTTNiBNA5UWYB9X/LBxCjHi84eVRDCKV8LbFPfS6jTz+zIP3po0NoTww8J?=
 =?iso-8859-1?Q?Dw/r4ZKddyQz5sSlMk1SvnD7yqoLZzyuVbxKGIge+7xlLLM+DAMpVOwJIW?=
 =?iso-8859-1?Q?Ne6vecG1m9uft+eUquF/1mTWGZmmG9ltvUYEgYSTLiVbJVJLbZJCaEwJMo?=
 =?iso-8859-1?Q?2YtMg+pi+AkXdQfoth3lSqOj6Y4LAjuPfiyBd8dVm1xUO7uP7KAbhu4GUU?=
 =?iso-8859-1?Q?n+HgT1EjMRvC/3dMATK7lIzcEFL3nDayv0nQa5yy+DR4wgO6l2GmylRUIN?=
 =?iso-8859-1?Q?KXbe+Yk2RsTh9T3cPE0bnoXH/Agn7QZHhqmPkBalTkC2LQPLLxqqQUsbT1?=
 =?iso-8859-1?Q?lhjiW/XuySqo/uDSnX15Yawv8sSBkdAjY8i1OOdRzYSgkgsLaHpBd7+nCE?=
 =?iso-8859-1?Q?AAAUibTIhQYzScL4NlaCvNcWBLu9hWdE+63qwEuhEiakFN9V2e3wzX84nR?=
 =?iso-8859-1?Q?GbbYv1NM86+CMvdvXlkUIhS0WhhQ/UyOVqCsx8jZqkg+08U7YeYFSbFWc2?=
 =?iso-8859-1?Q?oD/+sgXsbpPTBXcgLAS9LGtYJ7PjQ/HuOU3bgfz2FtTqQoRkbWqutuAJrc?=
 =?iso-8859-1?Q?CmCPdhkmGAowYJQMnNjkwL+f8lDwNVqiKd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bcf193-55dc-44df-a040-08dcb563ab0f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:31:26.0042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGQ5TR98DQK4Z5e0UMqOXGvxIJrpE+L75w1grSWpzxRm8LimEET9U16SyXvh0HTxTNWtVgPMLmZaKGfq5EPfYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10373

On Mon, Aug 05, 2024 at 04:47:55PM +0200, Csókás, Bence wrote:
> `fec_ptp_pps_perout()` reimplements logic already
> in `fec_ptp_read()`. Replace with function call.
>
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index 0cc96dac8b53..19e8fcfab3bc 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -211,13 +211,7 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
>  	timecounter_read(&fep->tc);
>
>  	/* Get the current ptp hardware time counter */
> -	temp_val = readl(fep->hwp + FEC_ATIME_CTRL);
> -	temp_val |= FEC_T_CTRL_CAPTURE;
> -	writel(temp_val, fep->hwp + FEC_ATIME_CTRL);
> -	if (fep->quirks & FEC_QUIRK_BUG_CAPTURE)
> -		udelay(1);
> -
> -	ptp_hc = readl(fep->hwp + FEC_ATIME);
> +	ptp_hc = fep->cc.read(&fep->cc);

why not call fec_ptp_read() directly?

Frank

>
>  	/* Convert the ptp local counter to 1588 timestamp */
>  	curr_time = timecounter_cyc2time(&fep->tc, ptp_hc);
> --
> 2.34.1
>
>

