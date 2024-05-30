Return-Path: <netdev+bounces-99476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 564BB8D4FFA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723721C210D3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8C222EE4;
	Thu, 30 May 2024 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="JBMcJeqn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2103.outbound.protection.outlook.com [40.107.92.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39B18755F
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087254; cv=fail; b=gAU6dYPcAovos2S9XU9fk7j3PPU7tAEopUrcyjELgKcKBTyuWSX9z5bgCMTmGuW1aVXmdMymMPmC+IoE0qz0IDC8WJAXbg1gXRZ3bredDUgSqUrvHCzbY4Pufy+d+UUq/OyFAxKzs0J+N7kjnqjSqv5s8dJ78tJxzLMUbhqDeII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087254; c=relaxed/simple;
	bh=pvaVrsODuHXNLQZbOb/PceQ7OcT29kwvTkyNNgcvV8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r/dC5q4sLlsNsjKh5Lb6x3hlzlQ4SoQp0n6gb2alD5J0NssaZxORCdr+YgDCs6wuOdhSmG2hkTfdykL2Msh86YFMEVnDYCia1x6kFzXLGgu9GdkosyEG8klvD66rOVmhcyxcOLRabiPEKOt3MoGpqsyBmurTtfGE6zCI9vboEp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=JBMcJeqn; arc=fail smtp.client-ip=40.107.92.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoF/baKDPnpRYEBGJZO1fqjH6piOzRDCL1tcmbWUIs3toLMu5qZcHHFtrUsKuErjw+XlhuuQO1398cAzQB5XaRJmzNF4x99DYY6eGQUWDUYssRMrWLAUuftSN1thbW6zF7dP3V+OjDDDceYIJX+eem/R+fsshrAzTIKe87tionrBhSfGDSQaNyYaLS0eaagF8xFs+v/sR656G7U1MPmKIOymcpkV0tsAF/bHMdFvViRg3wjKX0qJzY8MCIeVl8/DOXv9Syc+n/Tf8rJrI1tu1YnblWwSAzAvU03SXmCqvFTvJPEdrHmmXz1CCBvwbi33UZwsSaW78B1z4BeE7tKYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR6VQfg93aAp17JfOb/1FwuFAOf+yyp+Uz9lvPLJ494=;
 b=Fep8Cz2DFE5BpleKQsKVB7X9lITQNiL4yUVDAHwGW+clCBv8Lg8iPaOTMSo99IRHRSu+gxVAMdTiE8JaJkAXFQCWSVaAe/mPd8PpyIvmjqryhlBloC0eOjunTwaU2ZdOrnkS9u1K5SMBLwOLvtEulOIDKLtuu3IRPsMsYBjFWBy2cxw/1DZ0dxCgRObqBfdis5JghHdeLLQ2vmh2E6f11Ah0lzBQUskEz5ffByAKJsrLTdhakt6IdfEQYB3XRa4JgtgG1giRSpm0jO88xxy2oyO7bNJTjDf1eGRN32pE1yEayu3GkHHDW1AE1EiP9tPI2KjKgdoZ+ewy36c/d2QDIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR6VQfg93aAp17JfOb/1FwuFAOf+yyp+Uz9lvPLJ494=;
 b=JBMcJeqn1ErBnvPT41/uWkq+wYUcVq4DWcxJj3aSmwhtQEPobPJnGbK3+KNqXqBSbWiuUL264MOcBafZ/hiMvsi9Dx+LjomvBtQ9AxKSqlmJnx84t+qneuzaBn9+wN97/Px2DK8wVtEqUJLIHaRk4HHmpQ+oQFlUdA/Rve5rMrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by DM4PR10MB6159.namprd10.prod.outlook.com (2603:10b6:8:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 16:40:47 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%7]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 16:40:47 +0000
Date: Thu, 30 May 2024 11:40:43 -0500
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
Subject: Re: [PATCH net-next 1/8] net: dsa: ocelot: use devres in
 ocelot_ext_probe()
Message-ID: <ZlisCyAh9LtfcYgv@colin-ia-desktop>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
 <20240530163333.2458884-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530163333.2458884-2-vladimir.oltean@nxp.com>
X-ClientProxiedBy: BL0PR02CA0118.namprd02.prod.outlook.com
 (2603:10b6:208:35::23) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|DM4PR10MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 162f8bb7-2842-43e1-bce7-08dc80c741fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n9qNgxyPTdDmM1fHWHJYB70bApgNOHbNH/5MBHASr6Pw40+aDqhWrnz6kS+e?=
 =?us-ascii?Q?nXowuYM1WjyksmwvSOPEOVJs9AHTCsm/cjSWy5ECAiI/oOXQy0ybQrfxNVXG?=
 =?us-ascii?Q?Xd1WCFq28toxioYR5jmXM5XEKmp3eK2BZ0QxARXwBFKqYi1SW02108Wsb/hy?=
 =?us-ascii?Q?dmhqs+ur3w7nFL+GN8XiyRm0kWdwV8f0cXkz8+LMvYuFFLCRZChrYvV8VYiZ?=
 =?us-ascii?Q?dmaS623aCVLOuGw8XtEhxPPFSRiHsosSj4zjN+Q779cWZusZsTRbwz+oIf6W?=
 =?us-ascii?Q?vIHEnrEjNKxqOJExkqnraKa/T1s20XFnLuD/q0DslmEEjN/FsaKWyRgYWrSO?=
 =?us-ascii?Q?FtJDB7oxKxSrS0Iyjr7EGz/cz5dHHG3q2yl6UasmFZ199P67KQvN27dZTAeg?=
 =?us-ascii?Q?8rBWTeI+V8+/IdIy42r0avmg12TsSZOF8UeHnSBkHV8+E2PZtLx+JjSiCbpP?=
 =?us-ascii?Q?rqcTskpRb1WTdjzBc9Yq6xV+YDe26sUhTfQccy8r9mr1aeOqdm3hqztRf58T?=
 =?us-ascii?Q?S1IbN6oWbOaDOugT0GyICebBlREGeASuEvgW0zY1PlGhN8uaqryn4NSpnW5p?=
 =?us-ascii?Q?WSn+y39FBPo/15quPMR4r+0vgxeXMkoVOSSkPEG7YnZS3/zLjR2Jp+UYB09Q?=
 =?us-ascii?Q?vIvj0Urkt5muWtqDXdfmIoQzo+HgUwFtTV1wXaEoYm7wU804wRMftod0xaez?=
 =?us-ascii?Q?ISPAp4e3GS19/5u4hK8ICvKG+N9DwM6ZBleE7iuPS++dEP8+Y5h9Z6hbnX6/?=
 =?us-ascii?Q?iSLtDvDoTRI2Lm4qul2MSvDjYzuA4XoEKHnsxRJ8IeuPxwu4BbEBb6oHHCsm?=
 =?us-ascii?Q?prwqUNCH5Qorzgemvxoa15jF3TXkF0/EilDdKNKf4sQm+3Kt54BQRliVXMR/?=
 =?us-ascii?Q?/DsRExFmquggryCGh9khN/f8j0UOj8FoLzE2bRbefxpQY4WS7l/JTCaqHTui?=
 =?us-ascii?Q?1Hs22iLVgYDX0D0PahSIXrl115Mt/HFOQA+CVspthaU4yW40O5FFU6RXYk3I?=
 =?us-ascii?Q?OODSQNdu65Vl54feCjGl/mddGcXafsvrpY7QoGRqD14VVbGmBEOnZFyTUpl1?=
 =?us-ascii?Q?2uXR4FRehs2uyLGd/iOCXvrW4Fbd9TSpH/z36z29vu1HgSY+6xoJx+hVDDov?=
 =?us-ascii?Q?Fbrfq3LdkNNm1jPk8HR/YGSDlMWee8O4piuzpPcph+YMOH/J+itmJA8VHT+n?=
 =?us-ascii?Q?uiEo6Tt91h/WaW81Xt6tO4WT30XnSKWKDETMFPkO2r0BitO3f1E/V9x5Q54?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WsWp6UFpySHuHNy5ZgnjihBHZtopX7bUtKEIpI8155tiKFeuPuI7y83jOy/9?=
 =?us-ascii?Q?X1evMuqZF8d1EUwV94jxQDxqk/a/rOe0VM7dp4gnuwaH/9HpkIMKbM2rEeJO?=
 =?us-ascii?Q?2CwRRP/L87O+BL7zDNP6mRV+B0FkM0wdQ5Mma1qRVwMVQ0dRq2pRSMH9vJCC?=
 =?us-ascii?Q?weuo4PBz9dgcx5qgijwHhuU7ClJc3O3P1OGuTLludHk/yrnB/nzyD1cSo+wn?=
 =?us-ascii?Q?hZQQfB5l1n0th2yrujjJWvHCVkrnP2xUWWz9FKgHkpmUGTZ2VP2Pnkmyq61j?=
 =?us-ascii?Q?DzkKQZJ7GY+Juw/jlTQQqGHuzVS6b83hPdfeaFogjXvTwecviL9qSD792N+t?=
 =?us-ascii?Q?Cf4ZmTxFeUV41tgXXhiMfOvS+OgnxpWKNWZvuHpF6IvsN+lJ1FoxWKRhJ154?=
 =?us-ascii?Q?3Qp6sAwSYkw4QK04DkC/pp61o+Xc5+pMdehlvA1mrjwufWrOel98QBuoX2LG?=
 =?us-ascii?Q?zJgX25yTO63zLA6Py12T0HCuwgpcpfG/BoiK4ASyo9QxtvNk9y8nbvZl6c3o?=
 =?us-ascii?Q?J8uKuxFASjgxx5NgcoYNey7JKlxOWRwRLPtgoK/2PR3EdpcR1aBPt44fqBwy?=
 =?us-ascii?Q?m5lt8musuWCjfXAJZ11QCZIh2AafIrrbVGCS40f9YKRgTHFTdNOnC3k6LPGz?=
 =?us-ascii?Q?NwMgU/MON+K4zTthOGv+VXPJfcQ9Ay4rcRfBAcBXmG0BnRU54LEr9zrZf/B1?=
 =?us-ascii?Q?SLOLBbY2PaEat5aQmLrgJ6o47Y7+xPCW1M2X84WwWrpsEFaQoteD0RN8b4tm?=
 =?us-ascii?Q?NDZaznttFcis5y6if+Pg1+IcqB/snTtl03bmZ5H+hU0jqz6NsDZWL8SQ5eT/?=
 =?us-ascii?Q?5eKcnd8rj/ltoimhz2vAoUKlrHY4DGPmi2KXSQHI+buu+9xiHviEYXz/CqUn?=
 =?us-ascii?Q?mAw4shVA+AyD/y45vOYlMKf1uJm7GHoEonrpsO9EN69rC6dzNHbpxAoD8rGF?=
 =?us-ascii?Q?ho0IdgwfdJ9jqcnm2cKQtFijU5zcAN2TtWlIFD1abseTYoQGhxejF0qeBrFq?=
 =?us-ascii?Q?h0FiueJlgO5MrDzccxvgAIVxW7mOSumiZjUSUhZYTW5LTqukkkde2CbNZZFL?=
 =?us-ascii?Q?A7o2vMi3AMXACjY2w0n0qZfpFxGnoW2OVPQ48lhQb2a4y5uqrJSmpgbIgm9o?=
 =?us-ascii?Q?nJnOq9j5YStzNQLf8kHUueZRVkOcG5nWUy0Xi8631Ue+IUDkfC7s3YWW894n?=
 =?us-ascii?Q?2Aar25NAV9PZs18kD79WVvEQmb83Lx9dzzJlHpAUznSBBZkf+hYbNDngzh/w?=
 =?us-ascii?Q?eW+t83cMbAc+nIevXslsM0nbFHLH0Rode2IfZUittYmx+YFdxfLHiBnO1+Yl?=
 =?us-ascii?Q?L1I+0bHsxNhdhkWxhHsO+Wk12UrQZu7wZr3UFq7R6MjlIO9xPnPw3hCPGiD0?=
 =?us-ascii?Q?O0qsgOVTNjR22hhdrxSzsu5ZBY2KEnWWZY8mu1pIpZkhzyMKxxdw2fGH/Sr6?=
 =?us-ascii?Q?DomC3KrooUSFbdnlnXegIOHNAFZhp8AJq6k2vyrAm9r451uEEoGI+oLeRJGr?=
 =?us-ascii?Q?OGKGWsojnpsi39n9EE4p5O+uRp3WDEXSbQykM7iVOs/oIOFGl3iB6+/X18+n?=
 =?us-ascii?Q?v/bsB5iAMNkIUQBMWJpwxaoq8KwriIiFIzk+Hqrt/1XB6nHTsKbUNOvYK+61?=
 =?us-ascii?Q?W+QFaYm1rtwi/d+Zhq2W/gY=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162f8bb7-2842-43e1-bce7-08dc80c741fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:40:47.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0jPjDlyGcDeOeRTnYM/5I80jmrYRW8QkE1sZku93kJBikI7YgdZ1ma5PM7qT5n/KSzcjHPkxJ6Vy2+Ue3dYIO/JCPgeGJm4DjWiXjY8MSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6159

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>

On Thu, May 30, 2024 at 07:33:26PM +0300, Vladimir Oltean wrote:
> Russell King suggested that felix_vsc9959, seville_vsc9953 and
> ocelot_ext have a large portion of duplicated init and teardown code,
> which could be made common [1]. The teardown code could even be
> simplified away if we made use of devres, something which is used here
> and there in the felix driver, just not very consistently.
> 
> [1] https://lore.kernel.org/all/Zh1GvcOTXqb7CpQt@shell.armlinux.org.uk/
> 
> Prepare the ground in the ocelot_ext driver, by allocating the data
> structures using devres and deleting the kfree() calls. This also
> deletes the "Failed to allocate ..." message, since memory allocation
> errors are extremely loud anyway, and it's hard to miss them.
> 
> Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/ocelot/ocelot_ext.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
> index a8927dc7aca4..c893f3ee238b 100644
> --- a/drivers/net/dsa/ocelot/ocelot_ext.c
> +++ b/drivers/net/dsa/ocelot/ocelot_ext.c
> @@ -71,7 +71,7 @@ static int ocelot_ext_probe(struct platform_device *pdev)
>  	struct felix *felix;
>  	int err;
>  
> -	felix = kzalloc(sizeof(*felix), GFP_KERNEL);
> +	felix = devm_kzalloc(dev, sizeof(*felix), GFP_KERNEL);
>  	if (!felix)
>  		return -ENOMEM;
>  
> @@ -84,12 +84,9 @@ static int ocelot_ext_probe(struct platform_device *pdev)
>  
>  	felix->info = &vsc7512_info;
>  
> -	ds = kzalloc(sizeof(*ds), GFP_KERNEL);
> -	if (!ds) {
> -		err = -ENOMEM;
> -		dev_err_probe(dev, err, "Failed to allocate DSA switch\n");
> -		goto err_free_felix;
> -	}
> +	ds = devm_kzalloc(dev, sizeof(*ds), GFP_KERNEL);
> +	if (!ds)
> +		return -ENOMEM;
>  
>  	ds->dev = dev;
>  	ds->num_ports = felix->info->num_ports;
> @@ -102,17 +99,9 @@ static int ocelot_ext_probe(struct platform_device *pdev)
>  	felix->tag_proto = DSA_TAG_PROTO_OCELOT;
>  
>  	err = dsa_register_switch(ds);
> -	if (err) {
> +	if (err)
>  		dev_err_probe(dev, err, "Failed to register DSA switch\n");
> -		goto err_free_ds;
> -	}
> -
> -	return 0;
>  
> -err_free_ds:
> -	kfree(ds);
> -err_free_felix:
> -	kfree(felix);
>  	return err;
>  }
>  
> @@ -124,9 +113,6 @@ static void ocelot_ext_remove(struct platform_device *pdev)
>  		return;
>  
>  	dsa_unregister_switch(felix->ds);
> -
> -	kfree(felix->ds);
> -	kfree(felix);
>  }
>  
>  static void ocelot_ext_shutdown(struct platform_device *pdev)
> -- 
> 2.34.1
> 

