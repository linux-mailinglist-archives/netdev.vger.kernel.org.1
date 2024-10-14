Return-Path: <netdev+bounces-135281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B8499D5B5
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 19:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2661F23F0A
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BEB1C3052;
	Mon, 14 Oct 2024 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KxxgZoJE"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6F1B85C2;
	Mon, 14 Oct 2024 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728927665; cv=fail; b=LLPXgizL/b/pP34kyMyTeC5e/77lFOmpwq83pQPXweYuVVoeA1kVlW0AkYv/DsTEApU74LJhLlrnqzMxc89DTfRpBV8qpYwI9JfjxxC6OQ97BMdC76heGObu+uDoD6hXS9/O9H0c7LJBQd38KOlE6eiPoBucMi6aOlVwi0D2wDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728927665; c=relaxed/simple;
	bh=Ho9lssrAqKObnQiw+6aVmSoQQOgx+NnwZpLmA5AalbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uVGb7lPKKT1pIGLlbomknjsqpyMql83QChUQWX/Nkrxv/nBGZscRIC+fipu6JQ0QcpWmBMQeN3/c2mJ1beccADSsF3ietsyB+n+UFp2CzfWHAYrBBsz5nddMzndI1ypuFsOGeBbHQwfs6QDPEEazfJ0IDxJD9yJuY572k7ZLuts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KxxgZoJE; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bz/13hwwoHHdRtWCpsgGxyw8Eb7NBmEec5lI/W+xwA2u0j/OZQku1p4SBnqIajRgKaWQHRlHvjz76b9b6nXJ40Wi0OycZQTxoR62Do/7bvk/nrN3ZwAAU76U+oc6g/GAuXwvvEhG93yZMv/8R1SOF6VwiW8hQUWfnESlEP7BjMHgJ0ObQJPgpNmE8IbQpKz7k/AwRzOnfNjOJHvrkv00uVJOS0Pf4PRtOrVbYx0foE11DIyQTJEsJ6I+uvO8f3hAe2aO88N6mLtWvGDotcvEd6S6kH5lgLRKCopoWdw72ASwVTiIPr7etybM/1ZO1FD4zq1IkrrXsdoP0w+J0qiIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GniC2ibNaugTWczCKFRKq0QsgrHyjfIEAWfEcoge7Gw=;
 b=IjSpQSwPZkHl/kZEtakDpzO3bAuoxpymSdQ3/ZYqkms0bSyqIY+ZOXMmoPRGf2hhcZiWvXQacLI0YskrFrp7vtPxuImZyR3XsjYgcbiEdbM2ajOwfHUlgX+Exc+xfA8UpInlwsTcDOULEfhzaSJRa6CwIfqQSou4irXp4yG97KO83QcgMuYh2YJCdNHG9iMjZXKC4r3QBqI72DlcEabbC6IPq5yJVN9EW7B0H/0Ef4FIFDutvdNsFuiR+uFOkH92AwcxTH63Ha5vqF/eCDCyoRiLHiqaLDDdYaRlXjY3/446ygSflFsBUuWE9S+wchUTS80kJXMhIsMGyCZekMiXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GniC2ibNaugTWczCKFRKq0QsgrHyjfIEAWfEcoge7Gw=;
 b=KxxgZoJEVwA8iorTLCwteQsV58jyLkUgO7ibCYgB1VeLRdCTvUqzTaNOCngfsSOscCTfFbHjUlKtxTJ1G+hOceyGMjL6Ysb3Ky8Mxfcsjd0msXhRgIiE3IiwlYkL34PbFrvAFCAq97p0WVHhv4X4UB3iOpzW7UYVkBT588sti5FZbAY18KL2QqUsOZzCZwstiL5Eg6fOWvKLNTNRIaA3cfyY08rfXk3dKLUEeAWAceT1ooxYPYytSj9EcTAonL5/wdRIA6nFqF28SgMZE0NuFKJ7vnP0bmWwEhwGIsnSUGR0dx+MPbOtLDMa2nFsDp04E1cIZTioMDIlvBxHcVTuyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DUZPR04MB9781.eurprd04.prod.outlook.com (2603:10a6:10:4e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 17:40:59 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8048.013; Mon, 14 Oct 2024
 17:40:59 +0000
Date: Mon, 14 Oct 2024 20:40:56 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: systemport: avoid build warnings due to
 unused I/O helpers
Message-ID: <20241014174056.sxcgikf4hhw2olp7@skbuf>
References: <20241014150139.927423-1-vladimir.oltean@nxp.com>
 <c5ffe617-e182-4561-95d4-5f635fda53db@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ffe617-e182-4561-95d4-5f635fda53db@broadcom.com>
X-ClientProxiedBy: VI1P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::12) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DUZPR04MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: 326fc1f7-c536-4099-7b25-08dcec775d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A2KXwMNM3msnmtKbhNm6w0a6WMEBUqnkdWV7dzfQ1JW+p8bA0zHvDY9dUQSu?=
 =?us-ascii?Q?N670Y1JMHzOfSibk05j190N9+YFgII7fU/9xthMYVW2ZJ12/UOtQtjFX2IJT?=
 =?us-ascii?Q?8R4Q8dOu8UDroHwRSc1mP6EkL1LcS5J3iBU/b9P4reGBGii33Sg8qDRtnL31?=
 =?us-ascii?Q?WsXoCJrbCXUTwurUxS681gxgzBFuaABH35MfMjsC9c06vUoIUI6Cux2mwrfA?=
 =?us-ascii?Q?0FKt6T2QrGHS4BeQdtheRTZlv4MZAS1ONRZePCI8r6nA+CFNh2Hsj4a6YUjc?=
 =?us-ascii?Q?16hjXvM47EMrNeoCs7tg0K5vJxrvkQKgNAld7pht69kg7svtssv+nyIdKxWV?=
 =?us-ascii?Q?vTGGe7sfCvTazBjMWjecq9uqrwVztCe0sXaUuGhayQAjpCMn9aHmNStxpmoN?=
 =?us-ascii?Q?TPHmYhCFgIEKk0OwfVjs4MUWr8RJaqskFYwjkuaXVCkYqI2Hn1gPiYABJO1o?=
 =?us-ascii?Q?Nn84byC6agRdubeiEKItLTHzbvogTgSy2so5lW8FPBNu7xMrQ3IqEW2F9Grh?=
 =?us-ascii?Q?Zjjgk9zkb+1RTnt0W8KQaN8I4pV/ax/WvwMBoks9CwMR5DNNSKaPWI9sbmWS?=
 =?us-ascii?Q?c7dW3T7LjOPvwQiuGxUbsiga0VQURfv3eA5ILxiHnBqo/mFNuWU9sfDfLjE9?=
 =?us-ascii?Q?0M/TLW9eTAMfCAV0LGYvTngMXqFlFL90NapMsSe/0ZruXto2tT2XhVqBTcjV?=
 =?us-ascii?Q?/rBllVYAiOXB/yGtkpdUXj62iVd3tAmoj2TMgKR65OXTwKjPUB4NxRzElN51?=
 =?us-ascii?Q?vJPmEibDSRyiaOkVlELKg22NN9tTKU4e0SawYOpm3gcxnd9gJE0TovW3X390?=
 =?us-ascii?Q?GmWvIKB9tyaCX7Rey+Ef3LJvvcCEIfl2PJxRHHQLcSSHYoUqA4Gl4Oom7Ds+?=
 =?us-ascii?Q?VerImShf0MhitxZNECHHFouXE1YeG+CLm+j42Xidony9bRRStmWLHNmVFb/m?=
 =?us-ascii?Q?ioJvqzY03kopDis2rOcMHlX3OMmWASbJxpM100BgdlYskSfzAUk9dALOimmx?=
 =?us-ascii?Q?awRKVquoP5Y01r4NxXSTHJ+AO1XjrABZmCLM97Xzie2iBsuod3CGfGpKNhMT?=
 =?us-ascii?Q?8vHvHGUgm/tB8segSxL3osUoYXemP4tb4lUfqmjculPRL19Uir3siLp5nEDU?=
 =?us-ascii?Q?WpJRMh0JG8wV8Ns+AlDtbLcsvCDMgwYiqI2u0dcGdXfNWqrX9AmI1Wm0jl8A?=
 =?us-ascii?Q?eI64W9FILocZauRC2RYMal+CPHYfp+sQxjgjA0yAB3oNNc5DHaCSYxJsnL1W?=
 =?us-ascii?Q?WqKWH7rLQDZzcNqRgvdt9yqTzM7QaHhUkZqjSCCFrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6cw0Gln6cpM/xT8RrpYjYPSn7Kn0RLPuUbWw/tmtjiYz14Pk5uy4ebBc6Ewr?=
 =?us-ascii?Q?feCCqDaSCUniYoP36Yns3N/FG699/rPTzM5CWq4UsAWYG6ohPSksXrhxGYs0?=
 =?us-ascii?Q?RibbjjDuHcVxdFUpB4QnvEatI/Faf70ObEMDfLBocilf2buLJ2UlN5ilI1SM?=
 =?us-ascii?Q?Xubfbk608HGeZutNagrmraHkI3FBYuwW8Ck0D21ZIl/Hv2rfEM2ZMX9/xiL0?=
 =?us-ascii?Q?gHqZOXmhNWaW8VO2kftVO00e5eYiDDyLG0uhBJWCzN8F0My3zvprOh6mUPvx?=
 =?us-ascii?Q?Xuo6JvjHOR10mWnDizc1nlylXhmshNmmGX+Fkybr0LARqdXZkx8nLpUl6/Bc?=
 =?us-ascii?Q?ZZAEYsYMfgj9Jnr8KX+fPgNw4VOOriVoodd0cCRBOctOxNnyjSf32EkPbNK1?=
 =?us-ascii?Q?5Gpxs1HFPJYY+KEnOEd6FXk+GMxp9F5tgbbCJKRIo45kWXHhvZnanA6k9vcg?=
 =?us-ascii?Q?iGHXPC1rdGSz33QztOz1R0XwDGGch9+md9hKQqu0Pfh1/PgyJyuvDZXVnxkO?=
 =?us-ascii?Q?7iL+vLhEPle0iWyW2Q6HCquM6LsCOmH+X0JR9P4Wflt7aJGZNcXWGu0jFhbT?=
 =?us-ascii?Q?KmeR98IhSIkB4DSc2FTRvbTlVjIOIQGiQjZlBN5p5bLTshIc8e+Fw6LLh3tQ?=
 =?us-ascii?Q?ULBCy6WUczFrVHol+r/jx8dTNx39p8PdZvagvA1RY337cGvKnAU4BnWlj149?=
 =?us-ascii?Q?p0k75vmQgICXKnpp0f7d+lWXQP1g8g7Tnx5itXXDvKW89b5wcY1FaCbIhzZ1?=
 =?us-ascii?Q?L1ay9Wd4VgPTyCE1beZQixAaQJDK+8pcp7Mf7n03UQQnunqv3qbanEo0v3++?=
 =?us-ascii?Q?bl/VSZ94IfKKjeuKHVAZnUafMOiG9N2P6YbrhsjloSb/DjnH5xgGz+vF5juC?=
 =?us-ascii?Q?QwR9vY1ymD1caEtbJKEUdKRtm5xeOZEHh5f++s02avDA9cT0E57grGd7Xmeh?=
 =?us-ascii?Q?bDxdTkMz+WZXxEk31SY+vfuA8iAFCXJw4Gpk4PnfY0dc1PHJ4kgoz/hKvQ/j?=
 =?us-ascii?Q?+J64qgJvnvZ/RTSdCPmqigbTlagT5yS+eEeDiRR1aFdVlPU58+lqB3l6ZqpW?=
 =?us-ascii?Q?9O9YoHBk1hpW0orJqZQXaowNaUb1rvL5J57blusnhOwpio9jhe9A6B8b8od8?=
 =?us-ascii?Q?p+QM2fBmg0NzsuONVRzzv5DCqOLDZ9xT9Y50Uk+jME68Sd3YrPOjcgnXFJ3f?=
 =?us-ascii?Q?vZvTc+Eb1lRFrTlXfOg2wimxZnM/5qa/ymLKgqlez2u64lo0ESCNtSqH/A7W?=
 =?us-ascii?Q?wnJfiJe6Q2RQjeHA4txnZQljzFevPxHNdvsJkF1vYN0ecxx/HH44gTDrW6VG?=
 =?us-ascii?Q?ptMTTNcoDGyEHxAUw8XAzp0Mx/yn5I964HPi/vdhcyT3++CJHC9EcnoUPMmY?=
 =?us-ascii?Q?MDnKqZZwwRkZfh73Q4y1wXl2UGpSzZptaN1J+34RHtapq7zbMNBZu4v4iic3?=
 =?us-ascii?Q?f5zgvJ3Y8rtf+BEeEcL9hZr6B4ICDUR+IQE2KZdIJ5hJB6WICH2Rm/KlquVX?=
 =?us-ascii?Q?HZa/TksavbyIOXnxQ+P6xS2yb+ME7ctJmDz/H/3XVzfVxe4DROzmCi9oocr3?=
 =?us-ascii?Q?3KsXVgwU+m2YLjlhUpcsbkWVPsXO12YGIcQ+oNwLBKYAkiVewBufULVopE9O?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326fc1f7-c536-4099-7b25-08dcec775d70
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 17:40:59.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGO97896tF+skq0vUfSd0EHCnbT6NxA2OdeEI7OTsjJOeSsFPwtFQrtfqURCAMxVAR4Q0MnYxigYE6Gru+UnVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9781

On Mon, Oct 14, 2024 at 09:56:25AM -0700, Florian Fainelli wrote:
> On 10/14/24 08:01, Vladimir Oltean wrote:
> > A clang-16 W=1 build emits the following (abridged):
> > 
> > warning: unused function 'txchk_readl' [-Wunused-function]
> > BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
> > note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> > 
> > warning: unused function 'txchk_writel' [-Wunused-function]
> > note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> > 
> > warning: unused function 'tbuf_readl' [-Wunused-function]
> > BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
> > note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> > 
> > warning: unused function 'tbuf_writel' [-Wunused-function]
> > note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> > 
> > Annotate the functions with the __maybe_unused attribute to tell the
> > compiler it's fine to do dead code elimination, and suppress the
> > warnings.
> > 
> > Also, remove the "inline" keyword from C files, since the compiler is
> > free anyway to inline or not.
> > 
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> clang is adequately warning that the txchk_{read,write}l functions are not
> used at all, so while your patch is correct, I think we could also go with
> this one liner in addition, or as a replacement to your patch:
> 
> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c
> b/drivers/net/ethernet/broadcom/bcmsysport.c
> index c9faa8540859..7cea30eac83a 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -46,7 +46,6 @@ BCM_SYSPORT_IO_MACRO(umac, SYS_PORT_UMAC_OFFSET);
>  BCM_SYSPORT_IO_MACRO(gib, SYS_PORT_GIB_OFFSET);
>  BCM_SYSPORT_IO_MACRO(tdma, SYS_PORT_TDMA_OFFSET);
>  BCM_SYSPORT_IO_MACRO(rxchk, SYS_PORT_RXCHK_OFFSET);
> -BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
>  BCM_SYSPORT_IO_MACRO(rbuf, SYS_PORT_RBUF_OFFSET);
>  BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
>  BCM_SYSPORT_IO_MACRO(topctrl, SYS_PORT_TOPCTRL_OFFSET);
> -- 
> Florian

As a maintainer, you know best about how much to preserve from currently
unused code, in the idea that it might get used later.

Should I also delete this?

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 9332a9390f0d..113d4251a243 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -46,9 +46,7 @@ BCM_SYSPORT_IO_MACRO(umac, SYS_PORT_UMAC_OFFSET);
 BCM_SYSPORT_IO_MACRO(gib, SYS_PORT_GIB_OFFSET);
 BCM_SYSPORT_IO_MACRO(tdma, SYS_PORT_TDMA_OFFSET);
 BCM_SYSPORT_IO_MACRO(rxchk, SYS_PORT_RXCHK_OFFSET);
-BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
 BCM_SYSPORT_IO_MACRO(rbuf, SYS_PORT_RBUF_OFFSET);
-BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
 BCM_SYSPORT_IO_MACRO(topctrl, SYS_PORT_TOPCTRL_OFFSET);
 
 /* On SYSTEMPORT Lite, any register after RDMA_STATUS has the exact
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.h b/drivers/net/ethernet/broadcom/bcmsysport.h
index 335cf6631db5..55d72a16efcc 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -168,10 +168,6 @@ struct bcm_rsb {
 #define RXCHK_BRCM_TAG_CID_SHIFT	16
 #define RXCHK_BRCM_TAG_CID_MASK		0xff
 
-/* TXCHCK offsets and defines */
-#define SYS_PORT_TXCHK_OFFSET		0x380
-#define TXCHK_PKT_RDY_THRESH		0x00
-
 /* Receive buffer offset and defines */
 #define SYS_PORT_RBUF_OFFSET		0x400
 
@@ -202,16 +198,6 @@ struct bcm_rsb {
 #define RBUF_OVFL_DISC_CNTR		0x0c
 #define RBUF_ERR_PKT_CNTR		0x10
 
-/* Transmit buffer offset and defines */
-#define SYS_PORT_TBUF_OFFSET		0x600
-
-#define TBUF_CONTROL			0x00
-#define  TBUF_BP_EN			(1 << 0)
-#define  TBUF_MAX_PKT_THRESH_SHIFT	1
-#define  TBUF_MAX_PKT_THRESH_MASK	0x1f
-#define  TBUF_FULL_THRESH_SHIFT		8
-#define  TBUF_FULL_THRESH_MASK		0x1f
-
 /* UniMAC offset and defines */
 #define SYS_PORT_UMAC_OFFSET		0x800
 

They shouldn't contribute to the generated code size anyway.
Plus, __maybe_unused would allow only the readl() or the writel()
function to be used, which doesn't seem to have been needed so far,
though.

Something I haven't thought of, until now, is that if the I/O macros
were defined as static inline in a header rather than C file, the
compiler wouldn't have warned. So I guess that option is also on the
table if we're keeping after all.

