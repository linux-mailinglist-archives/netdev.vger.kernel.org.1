Return-Path: <netdev+bounces-237759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50055C4FFA5
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 23:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7C4934B464
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108E32C237E;
	Tue, 11 Nov 2025 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B6Qb5Fad"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3C2BDC3F;
	Tue, 11 Nov 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900503; cv=fail; b=dVYqe63DVN9gFO7Dz69i58a/W2PfXKlqLQfJ5ut7Acknzg1ubcxbg1uMPoYer54eQnjM65gzJYmnG+SYjHutH+zW6DH2XwmxieB8M/PnMra7LB18ZsUWxLlme46WBpPh27LzOGzM3MYCJHlzNSdCkoSwBYL53RHFbMvGmM/Mni4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900503; c=relaxed/simple;
	bh=AD99pYH/X38sT/8rP0FOnDp4kKeyriUnwI/J0ts//X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RCs5Fm6fJl/OuG6VVge5u0I1Ob50I6K3MsQMikhdjzP9NfJBMZT83j65JFvKdy6pBIC0F9bU42AvFZLibbRbrayKO0JIru8xEoDMpAhr+oWWu1FzQH2aSwm2g+nqRUFpGTsxeaYfqkRabm11oHyYVzOzOl2DqIL1N0Zx99NdN6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B6Qb5Fad; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWgTW9Ta39nmIXLA+rTHkH0lfGnuFL+qkal6oquBFYsHZNylUuoJTn/LkGrym+W1bXjwkUJs6v7ICvCAIDB+rlr3JyRFMS1ECCmuIcLyB4qujz8HG55WX4u4eav5A2qCpiw6Nd71kI3PQz5voa4Qc7h0ZwxwaGRps17XFEo/iQAn/oWagY5AardBqVZQJMpwLmNdF/fIhLeoE2lUuEwEqnciXG6mtncjlIOqR7aaAiGZtZTNhm720sMqk+/H8QORth7RLVwZB3ZnTuEo+aKx3nj56fonn+ErhlIgPZ5d6vIKJLJG4P0mkQZ5IsgLVji3G0UJ3EstDrmekskH4T+M7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xDWTSIjvDBUhRUGVZOrKkMqAN0bhxdNG0WbHuM+7+4=;
 b=Oi1nflZTMsjGT35Usc5ZnQYGFskGy22XhLssii8A8ZYD/R77GTTnCyDAL6/2bYKgU6kNg+ZXCd1NkaN8GCNvAntnG9fl1O+fJS3sMX8DjUrqKVmyZgsgW4xEO6w9jtsXCZAaeG0/ys5Mv9Ylev8g8UBVPUszxaaW6/MkxmykrBldc5h+iMAvheNNCYQVFvZ+QXeaueYD8Og2bH57QQWdeTcRLrnzVmIPWivkgE8kIo74noR3P81CxCuj9gDA2iHCMTuZJGizJ1nJ1OD1Vr2m7NjnYlENkwE855+kA5E+8PJ7gle3/59Cb92r2sRoExGyneEOOhj8/uRv6e1niZt9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xDWTSIjvDBUhRUGVZOrKkMqAN0bhxdNG0WbHuM+7+4=;
 b=B6Qb5Fady2Vh68nW55uU7RyPgx4tIZbHGHQpOQvkZhSq4IKws0ifuhNqOfCwfmTJsDa91x4fDkgvAWkaZCsDLOuk0N9vkTZyVDRSGauU5HkfTO5gcIw0J2QJqz9q3OcQEqmTPaneSz1aknphyrnMjv7XRxMTEL8F/ui21XCmv/0uPf/JsLR0JiHdqCsNsNA8LQYcrugae7l6PXfhQrZtI6Q50Z5QsfvYQEgBR4B2OMzNiZvtb9wliE2PrE08snW6cmO13C2BQYQ5WfqDavG00j1v/UnXIfSMaFSRnrgh68vUrOONPyENixLYcoM70d7+b8uZKjy9Vf9p8URFBuWWWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 22:34:57 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 22:34:57 +0000
Date: Tue, 11 Nov 2025 17:34:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eric@nelint.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: fec: remove rx_align from
 fec_enet_private
Message-ID: <aRO6CS2LcrgZLbXv@lizhi-Precision-Tower-5810>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111100057.2660101-5-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBBPR04MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 142f1fdd-acce-4193-ecaa-08de21728ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yV5y0F5XRpfNz2b70yEqvLReBlBX8hEnHQd18F7hRrNUzQdyhb+r/nJF3YvR?=
 =?us-ascii?Q?BSTX4Sc9ecoSa8UMw6wJEopNDExs++sg1y5Bs/gnboa5GuYm1tLw9vL0zxHt?=
 =?us-ascii?Q?vtoZCBDpkQIGDijgJIKde1k2eB2ps7sfsRZyOAZSM+XJ/b4IUNBiAiMnnLxt?=
 =?us-ascii?Q?AU6V0Fj9w4vuEOJkKgi0/753FmunYrY43D/EB2dgIE02XSTTUlMXkmBjbbLg?=
 =?us-ascii?Q?HrDKVcM402I+AZLKw61JaOt4W9ZFAP5T0fRuDpWP439niSnv0muLKDEXIBhU?=
 =?us-ascii?Q?LgkFnQLl8A7vkqglHrtQO7FqFuUWbXbAG+6QlzqyfMEB8JcZjmcoYrUWCM4j?=
 =?us-ascii?Q?wKhOJC3y4Fx+glXru5vDOYr1Wue5dIn6pGokXiCwUajgRKQ/QqLDHCpiEaS+?=
 =?us-ascii?Q?7GCUjGHHGcP3jeooEZpUZib/LDI6KAVPNkhqkVgtOC7b1Rvu+47MtzauUz0o?=
 =?us-ascii?Q?NetowETrByy7K0Ca6XNJLjdzijfU6naaKWHTzHGEuFr6fVGdGu3gBoIcjjdy?=
 =?us-ascii?Q?ELP0G7Sj1IT9f8bSORFn/sj5iTcICXkjI8Ze+46QF3AQZfkRyZwA7LgRmkqC?=
 =?us-ascii?Q?rkieWdzfq17DwOQ+hm1VVXTeq1kCVdaNBBAszcPNGKGr8H5J9CnTPnW9DepO?=
 =?us-ascii?Q?yVPj99rTAtJqAPEYU8zQaZDff8CcHB7M1FDoyy2bvNfdW2M+OJFne1OMtLYz?=
 =?us-ascii?Q?i0ze4/XICHIgdHsKE/aJRTDBNQz4w4Mp9uysX3mM2otTtGL/l8F8122QO684?=
 =?us-ascii?Q?SP936DsdycAU2Z/+Y75IbcyEwsP5lGLNPBWs8q/99X+RE5f7bagm2LzIcg7r?=
 =?us-ascii?Q?DS2EMrwwVNVrAi2qYNj0jIyHEQECfzRHKPVD/RkXxPD3TM0aqHp3yN1viUm+?=
 =?us-ascii?Q?aslWg5R3gmFJ5cbtziUc8M5+d2VKVmI8uvzJzJEtEQQdxckU628wnWxUroy7?=
 =?us-ascii?Q?yaQe2E9WrnNCMhaY7Fi6cHoL0WjB/ldGz81E3+1nvEwH8P4rMmAwPyvulKTU?=
 =?us-ascii?Q?8CKeSBx7nip8dr20lCnWeKCFLcNHAOCwtDMszHjAo6TXaOGQ37K1RzZfB2yY?=
 =?us-ascii?Q?4/xKJ9DcdHWzU8JAGD3c/ZWqv/DUUn5BWfoTIRFgpewMB0OmTU+UxnWLRAeA?=
 =?us-ascii?Q?Ad667TQYJEC8L6Mdi9L3nty6PzDMLkseAlFziWYSV0fx3J/2YUZro5n3m+pH?=
 =?us-ascii?Q?2hbYMH1sdorkg5QoO7L2l8AS3X954TjmsWoCV+URJkW2N0sI+MekpElZe2YH?=
 =?us-ascii?Q?fe3BxUq34eObh7yJxB6Jww+B2mEDKRyCpY5p1A8e1TE177grYvXC6HsYykPU?=
 =?us-ascii?Q?OgfwJZvW/HEJRMdQZ4zeNGIaikSzjOLlvLirRN99t/7+yN9bcvkXJwWuVGvi?=
 =?us-ascii?Q?J6vB7FCfQ3odANWgE16n0yflVxmwmLvqp5Zu7XGGm3mMo7b1YutDkKRO1qqR?=
 =?us-ascii?Q?EQGoarO7SDcoVR/T8kktzwKqmRnBru9TEV8SpTINa4VzvxNmsRaEa1ehDCcT?=
 =?us-ascii?Q?lbYGm67cDbb7wL7+ZOTVm3IXM0pOZ0cIuuDe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2VLcWzYGL0lbZwuN1dRXpwrGjtngeJg3otbp6qI8dLknTV4PUNLwerJIyrff?=
 =?us-ascii?Q?ufnzSyplTuNPFQYEhpqusRAc29345UrNI+xvq4hfCT3X4c93eew4aYfLzDqI?=
 =?us-ascii?Q?XICCGT03rAJ0mL8ZA/TsVl6y6D04yAesy5otaRUzizsBClkAIQc27X/wRUVd?=
 =?us-ascii?Q?rWF5qg+sUcTC2UXtYWf4c3bkNzi7i6/P2qJaSthl/X+Z3GIWJ4WfKFfgOJLD?=
 =?us-ascii?Q?68i2Gzm/A3nC1GKcTBvUQrJpkADWV5GDZ2mI+pE9EYen1h58BVSIwOc7vKn5?=
 =?us-ascii?Q?z3dLJ7Dz41cVabsS0D9kPRp5f1M8AAk2RuMF6BGFaF3GW22qkRvecJqCSFLf?=
 =?us-ascii?Q?co4Vgi1f0lUd+tFjS9Au6I0As0MDnnoYhmEQOfGLl8SL0/lvWEchX2VJeqxb?=
 =?us-ascii?Q?5U6AkESotpN65lC+1+cb+rviGKJhm6RPGKJDD8miQ9vIN1CouaLruJRSXx9k?=
 =?us-ascii?Q?G756r1VOD1rt1awm8OLmMfvENTNMWsI9fcvJIcg6HCbG57j+2XlcDf7VEes9?=
 =?us-ascii?Q?yC6d2FNoEr5XW39g9lN5Svx8r9MqEaPMzX8TlzXda2cX1qX2G8TkGcOiMBjj?=
 =?us-ascii?Q?V8oqkz84acWBPHbfy8xxfAsygROgCwgfqUl65zsIo1XJc8Tib2uVmP7ZJYYG?=
 =?us-ascii?Q?PwyJwkCV5rcc+ehvF19Shb4LGur5T7cm7ieelrLKJd1hR9plaAsettsp4ib1?=
 =?us-ascii?Q?2vJUjDtQFAGqEVQmxqprPIpecWjJu6GMiqQFMH3Tij6733PoaOXbasZjnLdb?=
 =?us-ascii?Q?utotWqrul12d97juurY1imWrtaoVlNufjOJJ1fFjjPgxN9o4wJkrByDQR9tA?=
 =?us-ascii?Q?wNmaM1f2lrX89e/+RD59T01LIhM0Q8oZqR54OnwvlWJ214+m1tTZjahIBtOx?=
 =?us-ascii?Q?Ha6HYkjZzGz7mg6BmPU15oYxrkgIGBOH0V0E2kJjqErek2Jloyh4UkWUQLRd?=
 =?us-ascii?Q?d+ICoxsdA0/98DOtSGgJRrLk9b1jvQIlheR27WqLgJub6bh7hEFMj8aKNACf?=
 =?us-ascii?Q?wEYjEuwRWxaEk+BvCsBwdO2nEljoSm4SZ8s/+ft9K0/ASJHlMcqow2ki3vQr?=
 =?us-ascii?Q?Z6xGsqxf8o6qDPI2JStT4PF9icy9vyGqp7iVO71WH4dtKIFZIwdYDDC3Xt8j?=
 =?us-ascii?Q?2/tH8jlyyun00q3irdWl5EZDs8r8xXjFSyrwNEW4Wv3/Td/sJGG9SfjA+7iI?=
 =?us-ascii?Q?Ph4FuAJKPSEc90vfdrFtzTGmf6LF4SzCPJWqyp6w5mGT9NdnSqNerpYvTHbz?=
 =?us-ascii?Q?dgNuMsxgh+6KAQq3pdLIXNzqi65+MNHSG5pEyJ/F2WD4mAAhMyK3g672qsn/?=
 =?us-ascii?Q?fuuMG5XK8qytq3TlGwvUrtNlMb+0Q8Rze7P+o+U3FydPhkBYwUOwRn+vJ2UM?=
 =?us-ascii?Q?5TtPSrthi4uHWuapOrQ00wadWKrhkfPrzdncCuemtuV018wC640HB4Omvcik?=
 =?us-ascii?Q?ai4qoLnqbioFBKNJgN+F88LaB4ojnoXW3RRWTynDa7BOPe4QOpxn7jHpv5kh?=
 =?us-ascii?Q?9q8cySf8kTVoykc8R9AhAHP+r9/E/Q6AbD9aGw7iN2UsWsjtE2BOoFsxFYwp?=
 =?us-ascii?Q?xMmI9bTVxc+7Wyf3uq+mcinzYwDYYrIpyhEJWhRp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142f1fdd-acce-4193-ecaa-08de21728ac9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 22:34:57.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okihqj25+zt+Q5SapuRu6vTGKjrmNwZOgvSaqU0v1yDsXfmExJAUpRNDLcmjG6wRpDyrvgU5s5eoVQUrMOXzVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7500

On Tue, Nov 11, 2025 at 06:00:56PM +0800, Wei Fang wrote:
> The rx_align was introduced by the commit 41ef84ce4c72 ("net: fec: change
> FEC alignment according to i.mx6 sx requirement"). Because the i.MX6 SX
> requires RX buffer must be 64 bytes alignment.
>
> Since the commit 95698ff6177b ("net: fec: using page pool to manage RX
> buffers"), the address of the RX buffer is always the page address plus
> 128 bytes, so RX buffer is always 64-byte aligned. Therefore, rx_align
> has no effect since that commit, and we can safely remove it.

I suggest keep it as it because we need know this kind limitation in case
future code change broke prediction
'net: fec: using page pool to manage RX ..."

Frank
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec.h      | 1 -
>  drivers/net/ethernet/freescale/fec_main.c | 6 +-----
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index c5bbc2c16a4f..a25dca9c7d71 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -660,7 +660,6 @@ struct fec_enet_private {
>  	struct pm_qos_request pm_qos_req;
>
>  	unsigned int tx_align;
> -	unsigned int rx_align;
>
>  	/* hw interrupt coalesce */
>  	unsigned int rx_pkts_itr;
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 5de86c8bc78e..cf598d5260fb 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -4069,10 +4069,8 @@ static int fec_enet_init(struct net_device *ndev)
>
>  	WARN_ON(dsize != (1 << dsize_log2));
>  #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> -	fep->rx_align = 0xf;
>  	fep->tx_align = 0xf;
>  #else
> -	fep->rx_align = 0x3;
>  	fep->tx_align = 0x3;
>  #endif
>  	fep->rx_pkts_itr = FEC_ITR_ICFT_DEFAULT;
> @@ -4161,10 +4159,8 @@ static int fec_enet_init(struct net_device *ndev)
>  		fep->csum_flags |= FLAG_RX_CSUM_ENABLED;
>  	}
>
> -	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
> +	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES)
>  		fep->tx_align = 0;
> -		fep->rx_align = 0x3f;
> -	}
>
>  	ndev->hw_features = ndev->features;
>
> --
> 2.34.1
>

