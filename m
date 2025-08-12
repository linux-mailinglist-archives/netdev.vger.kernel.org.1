Return-Path: <netdev+bounces-213004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0481FB22C55
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF3E16EF77
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503062F6569;
	Tue, 12 Aug 2025 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aZjeOzs6"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0D72F28E2;
	Tue, 12 Aug 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013978; cv=fail; b=N53cfi40med6T1JvedxipfxTJraOPOsBZqYB1HWYAOJ9eyBubmKYNOmtxc024VQVxPSEiI2PKAP7gJJTsrzCRSdoWtiDmw9h/JQuNJ7hRuGSawfR3X/FksJX2ioVNFHSZPSIw+q/yoUCLZ7EVSHUYuV9bjBD4k86Pvguuw0Ood4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013978; c=relaxed/simple;
	bh=FMgtPeNBMoOc3spp4SlfJ2tDFKKt3XIeBGbP4il9f7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lcz+jNmzXyTr+uP5TwCn/vp/LNbnxk/cgnb+Qr4uF5pW4GdmJ+WmaB8b026Uif+/J1bYgNVhK/sQSp5eXS68OyfC0v7p+3WRf+zDlQzteGr6/lQvl1Fs58cEqwebeY4dA0g06YpmD6spRiXtHUu3mOaP6lmNl1lk0kjirTbdI60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aZjeOzs6; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvYqXaMA3JwOj5PUEQcmjTdK57yBx77lgV3IcmOthR84wrqQuuSe5lKZqzhq2lfiHAjG6rXmYQXnI3TxfxeIMz0+7jTC70WUW6qQ3uVroCpUNRUNNXReVfGX1jhd1VIBf8tH2DhMMQgGoBtjTkbqPin6n0FBGayHHEfYlWUH7+KbNelZR12XhuDuj4kFjRqEyyj93l25szJ1S6iiTIz6z0ZHrp6xcnDvpqTVJmaFgkUkCi+5pjwed6sIhl4jMj6esCuLGH9+B2LSZAM8gRJXMjp9U8nBrKn1LTdrTBbDYibdgX+6qJW6JFQBmLezubL8Am8wJ51kXi2L1Ch3izFhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgJFe1jlye15LPOTokLajAoFAB9gvaOKNeQg5cQm0BA=;
 b=kkAoCr3apn27zZX1+vtZDdK4cudt0uDhbPSKGFMz5nnEndPOeY0xuw6NazKPEtpvFlkUh7Iznuudj9dGZKFfm+ksXd5xRCAQkCZY99S/WMw6WkSaG5K/6TLjnHyV67Nr86FcEV80ZesbV9H4FUflQsUYhfcio4PTjveyv7USWq4a39Ekuyain3nierrg8SzJ662bOssZXvJgcxS4o/auqb6mu3FPKhVuWHSlLFfeZsY1R94N/DUy+KFaA3KGeOlF0cNONeHzFTRJy5L9bLXW4iDRbzQuAxPnfLsAZs1Kinbw8IALEJ3Ga9l+Pw3MbwuoKJ1F0IgdkYzm3RzxHypOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgJFe1jlye15LPOTokLajAoFAB9gvaOKNeQg5cQm0BA=;
 b=aZjeOzs69G/1HJJs3NjNfUQWN1c+znoceYgwlavS4ynPYF3wNFeyZISGZZ3Sf2uCZ/EvCBN0nD8F1167VoLXca725f/ccbWzfU/gPJPMOCmV6gIGyfb5J5NJoy1yxyjoKfFmJSzIxNqlkFpgVvZ+QyJiY/UyTzsYm5wcI9uoibfiwHNszid6CmgbHSsA2cshptbwrx5ijNAOED4aQi3o4Oyikvl43XS4/EK+TnqLcKA3/i2JZi1GoJYt/1tZJV1vCpoAHDAO5pUjaUuy8AhYpA6i05JsqyXpRcpqbKN/fxXnx1rJT+fTOPh7P97ppuE8PE99AkphrSs0sp73bs9YuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7174.eurprd04.prod.outlook.com (2603:10a6:20b:11a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 15:52:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 15:52:51 +0000
Date: Tue, 12 Aug 2025 11:52:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 11/15] net: enetc: extract
 enetc_update_ptp_sync_msg() to handle PTP Sync packets
Message-ID: <aJtjSbZGZC/w1YAs@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-12-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-12-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d9ffe7-a27b-45ae-bb78-08ddd9b84aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ccoufyF1AYM7P2jWW9+npNJr1/nwFsANFopgh3S4xF5SbYqdg6NQJgwd9pJh?=
 =?us-ascii?Q?oyc0det4IuKlWNX8optJynuyWoyt39Ittco59SNJpyW71TPOiPej6L26f9E9?=
 =?us-ascii?Q?HKzpzCFGOgMhFOwsyqiPomIIH5b7GyDGULJIuBPkD6toGi0MxiPSxlfVIHGV?=
 =?us-ascii?Q?A3TJdhnDQQxCiDhBKoEIG2ntjQeEWCau6Yt/5+cQ9Zh06bFMcWOYsY42flhR?=
 =?us-ascii?Q?5FoccdYlX1BiG1DWMVPtUNeDIUDn+7cwH9oIw/fcp3d5TpRcW97aac2wPS01?=
 =?us-ascii?Q?I2giW9ztkmFeuW15S65VkRWz1Wb+caPzrGdatxsr5kFEC6/0zdFlIKcNbXlG?=
 =?us-ascii?Q?gre0kdGV0nPjIS6qwzV/UeI7ONx0oNUT++Yjaljhy7VJWZHngzfbk0AHodOZ?=
 =?us-ascii?Q?LAY9SpmqRkW9m5vyP5U66YUqdlYNp4Y4GUNOmXn2LhbvioPgp80do5DeMLvc?=
 =?us-ascii?Q?PhdslsyFOt98rFfEKYKu+SRuFHU7cnWaVpozd5tTS1FDQmTsMEh25yPvR0/G?=
 =?us-ascii?Q?I5xA3ZID/0h0f6fA9cPf9Wt7q0KDkbK3XVQkaUD+2rR+OPfKs9ijK+uUTb3Q?=
 =?us-ascii?Q?sR2OaK+P5gNK6SXQ2TQNFrpBgfC8HWjRFEHc0QSOe5miLkcRIg9nMZwnQSkr?=
 =?us-ascii?Q?R2DeneQzNWD+XTwlTUSp5YsN82d6D1KwloqyjtNETkGMVhuRETju4+sJBQ3d?=
 =?us-ascii?Q?B7LQLbCeS2ECAt85B5LPf3c2xbRI30N2DzIFWgbEqoy6rwryixfAlMO+wDu4?=
 =?us-ascii?Q?BP2rdQUbaHjpfDg42jcU977EG4GFE3tE/yfU1YYMLFcIEe4uC5tgtZXf6cgX?=
 =?us-ascii?Q?6uqQhXN0znhN5yLalCg5sVnIcARxw+yANc/A/EgKfw+ZEDReeEaAO+GFiwmR?=
 =?us-ascii?Q?h6rXYOXjSi4Tzr9CnVjwG3x2V3wfvXmrgai0e8UnF0i78TTXt4BBguba8q0m?=
 =?us-ascii?Q?bXEFVSef+kfQ3+1ewl+7H2acyYEHCAaBl0QFVbmIhZ5OaeQZz06fcPAZr28c?=
 =?us-ascii?Q?jE4Asc0xSCMwMUgImd5YhgHm6YzQ3NiYG9LNlcGkS+B0JFtVEOkcvAV7u27a?=
 =?us-ascii?Q?S73VLAcJyv499HR0VwxhXEZZfNCIpT3YPSrRrulIvtYcaCtCkWZ1shoJgmc/?=
 =?us-ascii?Q?VGbeg8YCG/7SF5gMXVQT/QyneHvBWBaX8z7h4LdRzn28DxJEwSLpzqRXzzln?=
 =?us-ascii?Q?N76lDgOm17IcKcPLAoZGBSw1PaqvfEJDPQ6wqBDHueEzjHSIYZeEymii1sIj?=
 =?us-ascii?Q?IZReu50OMw3uQUYiNFJnBrsUIgdyp7uGdFBRRT4tnFFhWbTH44V2ujzL+mLa?=
 =?us-ascii?Q?4RV2yXN+hWuXzgSx4Ft3M3r4DbZ+89Lw3YXWvNwxVBRWM5ViEdZszYRB3ia5?=
 =?us-ascii?Q?QVuQAFxTdBMmk0sBLuFTTDxnimNTICNUswqdnrQXNwpwkJjV+o/SIqTCVXwr?=
 =?us-ascii?Q?BEKRoLOsa2xYb51tKygrqr5jKn2WpTsMcvgI2fInM6gD+mLe6MK7gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e28g2Kq3Z9CHBa05rnCNKByW9/cFEoXWGcDee7e4ckcvNZuDlURoHKZTMvfc?=
 =?us-ascii?Q?Rw7vlwNi5nvqGzX/U3XSyVoKs9H/gHW36jyyISz9Df1+sEJisWBbhGDE8f2N?=
 =?us-ascii?Q?CmWj0ZhBpPtS4tj0Fc8GHAE1U1DRYZFUAVCjNHPWUkp8o7SeTmBPCbgeGuSU?=
 =?us-ascii?Q?xfcgzdPqr2Pa/x2NBK3S+C+mPWfjJJ+U3NIfG6V+NUK1p9ti6dj2yf8s7V/p?=
 =?us-ascii?Q?an3MSNW729Q82oZ8MEStB7NLeh+LgL5ty+xRk8fwDG01nsmL3u9zFijL3cv6?=
 =?us-ascii?Q?yrAhUdS0kSo4Kj/5L5Cy2JB7hIw7HRNtrFLWWPvnpAhGBIg7f7/4XlPkaS+v?=
 =?us-ascii?Q?96992ccNGs8CiBM9OCFYCgxhGSyvxOF8TWKmi4PLADxnivpKELtTda2lGw2K?=
 =?us-ascii?Q?ytJMHaJy3h8ldwW1F58yZU3fGtHbPpkq5hNgl2KDv+svuoGu1Cocu4mnrMCA?=
 =?us-ascii?Q?X6eFQMDY+GdLLEv41GTyHiOonFs4lkD4uRMKBW7UEXeaUSOu/c4YZay3iHzE?=
 =?us-ascii?Q?k5ByCCiVYwuecpBOrnnUSpfBHR+9/leB7WwK0EThHoDzIKIJWlzlrNEnjx1I?=
 =?us-ascii?Q?aO/U73LX9vCmB1vn/0JthnsT9G9EoF9OPPOMQQNHHKLwcLhT05e+3AihR/BI?=
 =?us-ascii?Q?xkBpsqibZODvmAz1zRAfRBM+ulgttJcOr5AA+IzvGvm/R7JJK1wKFZYV9asH?=
 =?us-ascii?Q?Z0BUCDhqWymdcDCXusaVbMPg/ps0WVSRRsbEN2heUAfyMWidDqn311zxYo5z?=
 =?us-ascii?Q?cg/KKfG8pmXkENfIBvzI/FxHbj4h53ZzlRi9qmCcfBjT/jm9aoKPyhUuoLYo?=
 =?us-ascii?Q?UB1Zfi/uwjSQTDHzn0QbkHe9ySoqj5RC0550A7U79fnsdThdKkIzEEII1jtl?=
 =?us-ascii?Q?RJ5Jclcwfh+b1WAiXSKbKoxayLC8BgH27zmTo7iDs4O/NS7owBZN+JOeBVAi?=
 =?us-ascii?Q?KHT+ckhKr6ryNDQIKlpzgQbeR8U69/QBAwu7nc2Xc7hI5eP9KLuliFrBUSvZ?=
 =?us-ascii?Q?k0ZYHnDT0JlWyjKtSIKdsTLNlR+Rpkky46ZFOQLsB8QSm/W/SZVvVxXbttnH?=
 =?us-ascii?Q?etfqxgLuMxXuVkl14SfkrLPsg6qN5VX/pybHzSZGddVUHYdBgRfofK8RJEg9?=
 =?us-ascii?Q?cfFu8zA9GrNEQJplzBuitEH9kWzJzbEqXUQfR8eo2bn7ut14gl3fFN2TpRhE?=
 =?us-ascii?Q?fpeSM4GSs3jSGPI68iEWo4vrIlNZUxA6+974IonelIN/Qdb2UoHRxda8hIww?=
 =?us-ascii?Q?sZDxpoF751jyeCCQapQF3m9qLay9Rcn9cdNpgZ8gLnxfp3NO/wwyoyyXt8Ko?=
 =?us-ascii?Q?eDVMwoj5rYxypRfabwmaJEJdMxKMsnURw5hrEYN1fMfSBVriB43DirOCCWQe?=
 =?us-ascii?Q?DCdhKew3G6238nT3i5FuvXKTIeChGTQAQuZkE1Tc2KAcY4wfIKRLEiSNwkfD?=
 =?us-ascii?Q?weY6Zz8eA7z78C/ZGb5g4YzEg4Gy4UDeH+mHcBX/aemnw3JIxysEW/8TUtsa?=
 =?us-ascii?Q?j0NpxGrLg3L1CFX9O6Ls4wEytjyDqWqSKVar1cX/To3AWA4L0zVrFv/zIlq2?=
 =?us-ascii?Q?zyTx1XdvhlmgSByJqxbqh1XSwY9R2z7hFpaFYhI2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d9ffe7-a27b-45ae-bb78-08ddd9b84aae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:52:50.9102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfbw3yz0YFQHoueoSk7KltePfQ470khHnfkggZEGMC4vF4/ZBsiZdj08JeTcGJL2GvekQ7hd+SFDTFE5Fx9YUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7174

On Tue, Aug 12, 2025 at 05:46:30PM +0800, Wei Fang wrote:
> Move PTP Sync packet processing from enetc_map_tx_buffs() to a new helper
> function enetc_update_ptp_sync_msg() to simplify the original function.
> Prepare for upcoming ENETC v4 one-step support.

Add "no functional change".

>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2: no changes
> v3: Change the subject and improve the commit message
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 129 ++++++++++--------
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
>  2 files changed, 71 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 54ccd7c57961..ef002ed2fdb9 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -221,12 +221,79 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
>  	}
>  }
>
> +static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> +				     struct sk_buff *skb)
> +{
> +	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
> +	u16 tstamp_off = enetc_cb->origin_tstamp_off;
> +	u16 corr_off = enetc_cb->correction_off;
> +	struct enetc_si *si = priv->si;
> +	struct enetc_hw *hw = &si->hw;
> +	__be32 new_sec_l, new_nsec;
> +	__be16 new_sec_h;
> +	u32 lo, hi, nsec;
> +	u8 *data;
> +	u64 sec;
> +	u32 val;
> +
> +	lo = enetc_rd_hot(hw, ENETC_SICTR0);
> +	hi = enetc_rd_hot(hw, ENETC_SICTR1);
> +	sec = (u64)hi << 32 | lo;
> +	nsec = do_div(sec, 1000000000);
> +
> +	/* Update originTimestamp field of Sync packet
> +	 * - 48 bits seconds field
> +	 * - 32 bits nanseconds field
> +	 *
> +	 * In addition, the UDP checksum needs to be updated
> +	 * by software after updating originTimestamp field,
> +	 * otherwise the hardware will calculate the wrong
> +	 * checksum when updating the correction field and
> +	 * update it to the packet.
> +	 */
> +
> +	data = skb_mac_header(skb);
> +	new_sec_h = htons((sec >> 32) & 0xffff);
> +	new_sec_l = htonl(sec & 0xffffffff);
> +	new_nsec = htonl(nsec);
> +	if (enetc_cb->udp) {
> +		struct udphdr *uh = udp_hdr(skb);
> +		__be32 old_sec_l, old_nsec;
> +		__be16 old_sec_h;
> +
> +		old_sec_h = *(__be16 *)(data + tstamp_off);
> +		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
> +					 new_sec_h, false);
> +
> +		old_sec_l = *(__be32 *)(data + tstamp_off + 2);
> +		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
> +					 new_sec_l, false);
> +
> +		old_nsec = *(__be32 *)(data + tstamp_off + 6);
> +		inet_proto_csum_replace4(&uh->check, skb, old_nsec,
> +					 new_nsec, false);
> +	}
> +
> +	*(__be16 *)(data + tstamp_off) = new_sec_h;
> +	*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
> +	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
> +
> +	/* Configure single-step register */
> +	val = ENETC_PM0_SINGLE_STEP_EN;
> +	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> +	if (enetc_cb->udp)
> +		val |= ENETC_PM0_SINGLE_STEP_CH;
> +
> +	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> +
> +	return lo & ENETC_TXBD_TSTAMP;
> +}
> +
>  static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  {
>  	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
>  	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
>  	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
> -	struct enetc_hw *hw = &priv->si->hw;
>  	struct enetc_tx_swbd *tx_swbd;
>  	int len = skb_headlen(skb);
>  	union enetc_tx_bd temp_bd;
> @@ -326,67 +393,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  		}
>
>  		if (do_onestep_tstamp) {
> -			u16 tstamp_off = enetc_cb->origin_tstamp_off;
> -			u16 corr_off = enetc_cb->correction_off;
> -			__be32 new_sec_l, new_nsec;
> -			u32 lo, hi, nsec, val;
> -			__be16 new_sec_h;
> -			u8 *data;
> -			u64 sec;
> -
> -			lo = enetc_rd_hot(hw, ENETC_SICTR0);
> -			hi = enetc_rd_hot(hw, ENETC_SICTR1);
> -			sec = (u64)hi << 32 | lo;
> -			nsec = do_div(sec, 1000000000);
> +			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
>
>  			/* Configure extension BD */
> -			temp_bd.ext.tstamp = cpu_to_le32(lo & 0x3fffffff);
> +			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
>  			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
> -
> -			/* Update originTimestamp field of Sync packet
> -			 * - 48 bits seconds field
> -			 * - 32 bits nanseconds field
> -			 *
> -			 * In addition, the UDP checksum needs to be updated
> -			 * by software after updating originTimestamp field,
> -			 * otherwise the hardware will calculate the wrong
> -			 * checksum when updating the correction field and
> -			 * update it to the packet.
> -			 */
> -			data = skb_mac_header(skb);
> -			new_sec_h = htons((sec >> 32) & 0xffff);
> -			new_sec_l = htonl(sec & 0xffffffff);
> -			new_nsec = htonl(nsec);
> -			if (enetc_cb->udp) {
> -				struct udphdr *uh = udp_hdr(skb);
> -				__be32 old_sec_l, old_nsec;
> -				__be16 old_sec_h;
> -
> -				old_sec_h = *(__be16 *)(data + tstamp_off);
> -				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
> -							 new_sec_h, false);
> -
> -				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
> -				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
> -							 new_sec_l, false);
> -
> -				old_nsec = *(__be32 *)(data + tstamp_off + 6);
> -				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
> -							 new_nsec, false);
> -			}
> -
> -			*(__be16 *)(data + tstamp_off) = new_sec_h;
> -			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
> -			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
> -
> -			/* Configure single-step register */
> -			val = ENETC_PM0_SINGLE_STEP_EN;
> -			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> -			if (enetc_cb->udp)
> -				val |= ENETC_PM0_SINGLE_STEP_CH;
> -
> -			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
> -					  val);
>  		} else if (do_twostep_tstamp) {
>  			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
>  			e_flags |= ENETC_TXBD_E_FLAGS_TWO_STEP_PTP;
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 73763e8f4879..377c96325814 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -614,6 +614,7 @@ enum enetc_txbd_flags {
>  #define ENETC_TXBD_STATS_WIN	BIT(7)
>  #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
>  #define ENETC_TXBD_FLAGS_OFFSET 24
> +#define ENETC_TXBD_TSTAMP	GENMASK(29, 0)

Suppose this type patch no any addtional change to reduce review efforts.

Or you need say replace 0x3fffffff with ENETC_TXBD_TSTAMP.

Frank

>
>  static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
>  {
> --
> 2.34.1
>

