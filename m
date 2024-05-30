Return-Path: <netdev+bounces-99479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA188D5015
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E848B2141D
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A432E62D;
	Thu, 30 May 2024 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="gSXi58VN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2102.outbound.protection.outlook.com [40.107.220.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4BF2E62F
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087660; cv=fail; b=PsYDJMPP6qwqg1buenCGNKJufkmkJm/8b32+Lqn1Qk1HMRgZiuBl18LiPwU7BD1lCfKAqqqwrz2HiFJB0DKdYGKyyjOValTe6SD0LT2tVcqCUWyaxZbCLQkBEcdm+krLcQRK/Xg1eWYyFp+2RuSdH3uxBmORtQIlPNaCgzyW5yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087660; c=relaxed/simple;
	bh=vXKG2ZuFDzAXU8YDD5qqDPr5n3JTrECx++XUoi+sIfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uzc9gNbFxetKJJyHf/F8LF9hxjz0p2WMoxKR7ffYF9SesV2YFUSFAV6fI9/y5dEtcJ+qRUE1PPowM5ckQg1I4j8/ydv+E87eEm+8dOQu3BPhJKzx2JpT+hlgKQE9bbgXl9V72H5EBEUcbw+U6n5rSYx3//0QsX7e0+py3IzuNnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=gSXi58VN; arc=fail smtp.client-ip=40.107.220.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gl9XaKUrEZpNyKrfP58R+wFifcpazj8oYxeUfV5ig7QuQHuwl2xeyMqnnhE1ZiIlUgoes40vIe4tQvRe7qdVAyvDEgVtkNjN6IFwpMrDNv663JJq4jeRbRA+k/cfpaK+QHfjFg8dA8h8paaoFng+quh0gvB6b5H73aBhgt4H5hY7Uqbq0YOlPj/ZJ29jA6yvNx0MhAp2bRyB8YkxiGZIlXzRJP4WGeVK21ELCuec7SFbzW0h7l+3wmyraPaQ2lqqO50WEB0YcvLMBHDBDAluDEaNi9bEeXv+C5w14VOQM8fpFRvpG9Y7CdpXrtaKi4/6N4Zr4uplC2Qg5ClE//vp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdeC1JsUtMy0p4Ce4KIvbgG6cV8YpN/wHrgpYjK8yzY=;
 b=b2RU24mSHId6fL65wFaR7qjFxji8zbL8qgGoUtjYdLK/DvN0wEk+LEN+UbvG+uAGerYiuf+ey+L3MDW8VOpZeuz5WBz8LZmhMSyp0myBsrEGkuWXHFi53REn/T38pv5LOhf6iQwUueoNozZZp2QHiIUELPQKpcWU+pWF2ZFq/NO3alV/RXHh+9IjAovLw8nekIRkIy+PG3a2ElMmxRsH2hwQqwH/bLiwBnBA9oJlZFGHbXreRMOCqrb0FQKbhOGlRDYRWT+JlbWJrRHz/DmY2fZcEtSZ2NgVaBv3bE0ttOoOdHPVg0/Nqe75uDZEQNq3zVlzwbxJ5OIV0EawZVYtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdeC1JsUtMy0p4Ce4KIvbgG6cV8YpN/wHrgpYjK8yzY=;
 b=gSXi58VNzp3w4KeaSJy7eJADZyP/+4FBeYqcYPJwj9OaR6y2IV7rbe/4pST8a3Zya9qvB9LMbHF5ya53uf4CgOohr5KzP54f8Prd4JtfqacB4pgnJF5vMntxXg+4jWFmXLHG0kZu/Bgg42zBMXOuIBIDBUZIW/9mFIIQLP2YKWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by PH7PR10MB7693.namprd10.prod.outlook.com (2603:10b6:510:2e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 16:47:35 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%7]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 16:47:35 +0000
Date: Thu, 30 May 2024 11:47:32 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next 6/8] net: dsa: ocelot: use ds->num_tx_queues =
 OCELOT_NUM_TC for all models
Message-ID: <ZlitpP1/silRDYLY@colin-ia-desktop>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
 <20240530163333.2458884-7-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530163333.2458884-7-vladimir.oltean@nxp.com>
X-ClientProxiedBy: BL1PR13CA0288.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::23) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|PH7PR10MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d78a4d-28c8-4bd0-d8eb-08dc80c834fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VuvaMBwYHUqlhA7deNZoyk3XArTUTL1C0SvvFVyoihWu4O1RbpF97vAWU0Gy?=
 =?us-ascii?Q?taoRhpdsR4+iAM5sTgzqic8iWGTZSTBepnlJMAjsLkFOVUtG9FlWj9xD4Efr?=
 =?us-ascii?Q?m076sQPp0neR6+SoTt3x+HEohRMtxmcg1kjunYZ/6444f39gcodKlqgQRNWL?=
 =?us-ascii?Q?POXFnS6tPMHgs0VInSBMJEjfGHWBio/I4uAXyvrkYaoCEHW1U+eY4fWBKS1t?=
 =?us-ascii?Q?InHK+nAdwlK3GX0+7U3SpP47HZ6DMm9+BuydYeWq1MffIl7AAoRX3JBgzajS?=
 =?us-ascii?Q?Jt+xrdjMfssFn1pg6TzQOaogEuFDsU0ta/06gy92czRrkEkg+LJPT4MOrlAU?=
 =?us-ascii?Q?YGnCnmMrf8TxPlhbHR5uKk/ImAbDYSVy92Vk6TsCBt/uQWOgbGuUmA7xTNQv?=
 =?us-ascii?Q?C4HpUU4bEw3P0Mc2H1k6kIhwf9XUvlh9HmUrmp4wZNiMT0h74VN7DhFY6JhX?=
 =?us-ascii?Q?/ciB5r21mZ1LGUUv4nVcg8nctDesYlqy1CMEsAWrFsqYP4KpZFtdzsJh/OdZ?=
 =?us-ascii?Q?F1ukihjbtwcQ9Sj3HDWMskIptrkPeXAb7gBZ439xSybM/rGctBg9JmnaMxMS?=
 =?us-ascii?Q?OT2p62jmzWtX1+DQDEblw5cc2K7HYv+tF4LFLCtJx6NGUuOeCtXxZ0fD7NF6?=
 =?us-ascii?Q?n+Yg1eMxa3lJgX5fR46j/9QxOFq1PzXbxG1MWhZJR6sAH3TmgMkzSXlnhRuM?=
 =?us-ascii?Q?Ps6oRjLvFrHqD0lFoAho7bgV9Hy915ujJ7OissLBlUpzjDR4hRaf7S4E1lY2?=
 =?us-ascii?Q?WfZwiGHpPh+n+vTOo6o6uwBcX/l3l72rVB/noB88KGzugAjD11rmqA2PGZSe?=
 =?us-ascii?Q?IAN9XieKwmDwcQ1mz03+xbimZSgh+HqCxEWOCIIxW9uK+Y2hJMc0xzvPNKK6?=
 =?us-ascii?Q?UZxrVZtxz+Yw2/pVgzIsIVN5qXANhit1/5VjLj+ZzXAhLlwy+ZW9B84BZBC+?=
 =?us-ascii?Q?lB5jnuNojVD7mngFJGFvoORMlTMUOno+2XKMlQudzffHlO/uMSTw41xGOe4d?=
 =?us-ascii?Q?H7qDVSKRKzqhEXZtTRdkFhqqfZ6xGLetO3hzDZzl0FLVCqaZfrzgpxuLmnWj?=
 =?us-ascii?Q?Jy8Jgpx+Jm08yebti6MAM62mmssYKE94Hpy7l2JS7mLaOIokfDS9lS5RrtLC?=
 =?us-ascii?Q?DG/ePDfxkh/qT/+/XeWM73a6pDHsmGGwUTOAAjBGwrVvvZhiFRekq1gAZ1c2?=
 =?us-ascii?Q?XVvoEHgp6znb8FpqknkPlsI26vo1GFgY75xMrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JbpPUVRcWaioDdAA8ZkCQtUFYJRFeFBi2LOPV4yZ20tsC8U07ZhwUrdyjN19?=
 =?us-ascii?Q?4KrNJm4phVVG8qLXjWmMZlNKb9MiSulBdYOPn9VgvYTXKz1AYtg9uYqVT7Mm?=
 =?us-ascii?Q?2H7em05187wImeASsJW/+Tg3iMF4LpP/ObqMt2OOSZZM9k9GfDimqspwinTy?=
 =?us-ascii?Q?CspbV2wGYQAhTTdLRfGZJQ30T2DeO8ZyELqXEmSb3vRJWmTl3jFSpvrbZIkd?=
 =?us-ascii?Q?/ofIBe+POK5xZFVFWP7wCDEtuIuIgGPiTl/cOFdzT+RLnYDnM0qzVgR05h7s?=
 =?us-ascii?Q?NlIFG26QZ9duOlE0tJU6C3yupR8EKp50qkKSIh/zoGM3Y9l032BEZMFTTh+g?=
 =?us-ascii?Q?DaJvpUqmaDC9mlYtx24J8jw9uK4XcOwgnQ2QejH0L2NWkaRY0wlvEOKRwCWm?=
 =?us-ascii?Q?AbPFqGDYb4FbhK1sUZl9yKHMFVtZAi8W9rJor8rsmXgRmTzfeIHRyunrcLvA?=
 =?us-ascii?Q?zaiOz+mc9vSmInD1MPh0L0J/pFV+bmbX22ZCu8NonDI1Ft9H86p1r6491YX1?=
 =?us-ascii?Q?GfRxo4/Eeoyi2WNgzfqq9xf3jTfipXdTgSrcnFLFtYYY5fNvZjSXSO/stWJJ?=
 =?us-ascii?Q?OcV/g3NS01TPt6+VMHAxQ5/Pr2WTz2t1oFB+HqQ9vEoO74Fm/Z8qR/9lbVLE?=
 =?us-ascii?Q?iXGnJo3K4XpOKmhDFguVXJMZ8rdi7QYFHzHSeGFGuCZQ/yqHh3vpv5aRBqFO?=
 =?us-ascii?Q?sclNbSYhRk09qlZ2EbM1BEqi52q+tMMsI3yh4TvMEWjUmYJX06+9oWzid0qT?=
 =?us-ascii?Q?UsYODuHdI0KoJ6BaB6hTIgPERq2YVLyGMgTmVfajhYUL95izyvL9wh5gyO1K?=
 =?us-ascii?Q?x+b3wT7b+cxzFLK0YZW/5HsQ3YU0dXzIyi0HhVZLT/4MmlsU3DAbIK3aOFZZ?=
 =?us-ascii?Q?G/yXgEYA7c3zWSN7pNcJAYC4AvoXWHETAngDcIpBg5Fa+3TVru/Orrj/wPTu?=
 =?us-ascii?Q?J4E4s8wjCSHDiCWcaYeAVwGMn2dSxuLAWBrlfzVI3MfEj71jyiM6ROhH2Ja7?=
 =?us-ascii?Q?ICsB5bPeCLNmJSBSiJwHYw6o/wwjs63c4UxebKizeGTP665TrV/BZl5WDDiu?=
 =?us-ascii?Q?0Ww2XkJDuLZRqstrMHPtvRYUu6/J6mtlcjeE0POR8knfcPinfVq/lGgxEFId?=
 =?us-ascii?Q?+XdFxLL3Pz6fg/g8U9EvxUK3b5QyT+IooOlmpCJhkXVOB+3j1n2hwAFkHg8h?=
 =?us-ascii?Q?O9wvmmr/Cf72cXAUVQW9JBfRJA3vtOme+iOYhSgJBM0Doxl19cjmgnEZMASi?=
 =?us-ascii?Q?vlhE+aJ2RwV//bu1Ca6jfT3FJ4H0FUcrP8Asc3qeOcynAP62WqwdYfduta8Y?=
 =?us-ascii?Q?hCyQGkBC6jju088kklF+xOwlHFbkoQjEZRZgKE8wdpQ37bvEaMEqLFU3/lBz?=
 =?us-ascii?Q?m6yUiQqN+rwflftmOCT4OoGgoX2fUT4bX+KGY7wzs6w8nZcokJAAdGqswmho?=
 =?us-ascii?Q?Qeeh/gJSKqqQ0l2Tle8rD8Rhy75pX12dCsQEOPDOAldGwBsI1XK5LnY1A21H?=
 =?us-ascii?Q?uxuZ/l+PdwnvoXaljbxY84pHaj6LNw5Mk6d5oovitOW1yK6iTa4T9LLKPE9c?=
 =?us-ascii?Q?351mP4In2GFbCsMpLRQdioaBky9FYSBv9JfNEaTK4PmWH9S71s1DsoWavyCF?=
 =?us-ascii?Q?ZXqFNxBJA6PTBuNAWAoWYe0=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d78a4d-28c8-4bd0-d8eb-08dc80c834fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:47:35.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zZ4tDl+01/5Ujb/oVDYlLIXiRWU8VPvMl4RycrY2UymkSTujnd5O4a5KXSYdd0YXfAGh91hKY9vx/ChyKJLiWI7ZT/akhQFQxDqTCn0njw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7693

On Thu, May 30, 2024 at 07:33:31PM +0300, Vladimir Oltean wrote:
> Russell King points out that seville_vsc9953 populates
> felix->info->num_tx_queues = 8, but this doesn't make it all the way
> into ds->num_tx_queues (which is how the user interface netdev queues
> get allocated) [1].
> 
> [1]: https://lore.kernel.org/all/20240415160150.yejcazpjqvn7vhxu@skbuf/
> 
> When num_tx_queues=0 for seville, this is implicitly converted to 1 by
> dsa_user_create(), and this is good enough for basic operation for a
> switch port. The tc qdisc offload layer works with netdev TX queues,
> so for QoS offload we need to pretend we have multiple TX queues. The
> VSC9953, like ocelot_ext, doesn't export QoS offload, so it doesn't
> really matter. But we can definitely set num_tx_queues=8 for all
> switches.
> 
> The felix->info->num_tx_queues construct itself seems unnecessary.
> It was introduced by commit de143c0e274b ("net: dsa: felix: Configure
> Time-Aware Scheduler via taprio offload") at a time when vsc9959
> (LS1028A) was the only switch supported by the driver.
> 
> 8 traffic classes, and 1 queue per traffic class, is a common
> architectural feature of all switches in the family. So they could
> all just set OCELOT_NUM_TC and be fine.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/ocelot/felix.h           | 1 -
>  drivers/net/dsa/ocelot/felix_vsc9959.c   | 4 ++--
>  drivers/net/dsa/ocelot/ocelot_ext.c      | 3 +--
> --- a/drivers/net/dsa/ocelot/ocelot_ext.c
> +++ b/drivers/net/dsa/ocelot/ocelot_ext.c
> @@ -57,7 +57,6 @@ static const struct felix_info vsc7512_info = {
>  	.vcap				= vsc7514_vcap_props,
>  	.num_mact_rows			= 1024,
>  	.num_ports			= VSC7514_NUM_PORTS,
> -	.num_tx_queues			= OCELOT_NUM_TC,
>  	.port_modes			= vsc7512_port_modes,
>  	.phylink_mac_config		= ocelot_phylink_mac_config,
>  	.configure_serdes		= ocelot_port_configure_serdes,
> @@ -90,7 +89,7 @@ static int ocelot_ext_probe(struct platform_device *pdev)
>  
>  	ds->dev = dev;
>  	ds->num_ports = felix->info->num_ports;
> -	ds->num_tx_queues = felix->info->num_tx_queues;
> +	ds->num_tx_queues = OCELOT_NUM_TC;
>  
>  	ds->ops = &felix_switch_ops;
>  	ds->phylink_mac_ops = &felix_phylink_mac_ops;

For ocelot_ext

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>


