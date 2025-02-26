Return-Path: <netdev+bounces-169903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F236CA4659B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7943B6988
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C619921D594;
	Wed, 26 Feb 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NAmVQXNE"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD921C9EE
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584881; cv=fail; b=F1ModogMyqdysfI1IYahVee8PcXXFjQLaFXY2ZO93J7UZDfACGj9KKcz0XmtV8ZIwhz0KPNSACLTjvWiwk9V0mgDvO5tokWwauOE7+3szE3S1NFaT9sn4otUrqejX847ty4qnjaFgCPbu3rnZ/vtJhYOdu/PSuBgGS0JpCBNENY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584881; c=relaxed/simple;
	bh=5B+H3qAwXDZpvF0CU5OrMySGnEALaRHm6vZ0G/pn7JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qlfvJXfamhwBJitTCXo9PLS8VYvx27+PrSiKcr6zzdWYkyhlcvXFt0/QSSpc9QIlsyNHrL9BjZxLkyH3ELP87jzOvSd+AwcF9VEbNwIaG/N8mytGg/C0nY2eIVgCqWSbOC16EjaMeJJQbOZm61Qzjj20u5EyMd9ZN9SywhA0s0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NAmVQXNE; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfMaQjhsiM3/60nJZin5eIr17zVYpGpkSOGpG92imuJg5ioWJgLzgayNJCx+HokJqJjPKw+oS047QtKfXj3RRzdxaevQGNGQo5d4cidVRDTSLh4MhQjqEoN2AqcfySm8lh+3Rbi0v7OgAoE9fNntKUFlxVJO3NyahprNSgHSe42dWruceJmDy6lz+VhxHBrkNd9FDNIGAsf7UNNkIyWFf6lGcp4leIWV18mVKgJchPdW93w0667zqcHnN2g5B4ycICAmK/Pac6/m9j/aK0C8k4bH1WpviuHafezEArIIYaIsOQvjS5s9vLXdK2bJbWDw7j/i3XkBCXKo0Nq6cAQEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y97ZEIoKLWxYhJw/SHPTa3tZJCNrB2Mpj34Zce7BQYI=;
 b=LGmGtT/4BEb/iEg6QS/62D3AxYZhGbApKJdPUHiIiu/X6OmNN0jMf80af2fDDsBbsZNdABGJ6MKbRzveUV4TXOJSNnrbY6asjEI4gqxWytzxEFCAjFctfaIVuyYakg6AVdNvJD87SmxKvXijMQn4+2+l3RnBOEu85yKOj2yvoZWnHaZL1VIgD54+tnCXpvEoORoAkX1LBB61bXGPGZVdEffQoiX6w6Ss6hvU+c51xSSOaWuRrmkefqq+M63WhN96SQMk/jS8edj28WUOdhBltsJ6gDUEGRoKKUhoR9xaItTSuW5uT8hkZb091SRqlpojdKcOcLSjSEHIIbWRZnP7QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y97ZEIoKLWxYhJw/SHPTa3tZJCNrB2Mpj34Zce7BQYI=;
 b=NAmVQXNEqngjP4jgHsriyE8HyImTqiYI1BbUYdQi0Glgg2wpmvQNCcs5e5A7dvGA581C3U0U74S9GqKbkBfBQmPKn2UHCN2wyRRO2QwbTKpFJ2O8a3aFQH/wNQrJPTjk+51mV8omE8UTykwRnuWsiwtVrQMZ0bQGI0AjeSw9yBsj8EqdAOTHIT9NiVIvlDCLZwBTA881/IRu7H919mzAE9lRUk7yuOI9RsSY1KiBAkO1wH/ftFMAcEoxbai+D1ZSeNspp+WwAgkeEFHQ9yM0lucPQYatDc13dLwE+0zG3jU8/zcxHh9EJrE5P86dfgtCXOiz2lcRDNTdfPjYgy7yZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PAXPR04MB8973.eurprd04.prod.outlook.com (2603:10a6:102:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 15:47:57 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 15:47:56 +0000
Date: Wed, 26 Feb 2025 17:47:53 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
Message-ID: <20250226154753.soq575mvzquovufd@skbuf>
References: <20250225214458.658993-1-shenwei.wang@nxp.com>
 <20250225214458.658993-1-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225214458.658993-1-shenwei.wang@nxp.com>
 <20250225214458.658993-1-shenwei.wang@nxp.com>
X-ClientProxiedBy: VI1P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::38) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PAXPR04MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 859b9873-345d-4bac-8546-08dd567cf05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E8wQl9hfSdlTMgXfBdwVyHSeAZCNVWe5p37ocoyofs8HidR4/jeXMLzf+oJ8?=
 =?us-ascii?Q?A6MRqqQSh5kOjqWHbZfj4wuoENcFSqyvsJl5h5Twdt6bkBmtecYqInniYE0I?=
 =?us-ascii?Q?fEmEbUaqZYr6I9sIcIC8zceZX2swEnh25o+clPSHfpl30qTmzhfpTlZvSeTy?=
 =?us-ascii?Q?c1DODv9KQokcQy4tOgovAWrzatvTvLNnEvgbNUS71SnOtRi9frxc6DeABC/g?=
 =?us-ascii?Q?MOaXMc4AsrAh4w8O9DJ2QRUpoPtcU6j6PfvZmv0jTFp5BMk1oBy2s724VNFd?=
 =?us-ascii?Q?P+n4Phq1cOwWnzBNbuoPh4SLD8O0lnDZVPvVUM2CnXtETbvmcEJ5FkDC1iy8?=
 =?us-ascii?Q?jfXUCviC5T+yxn+Fz1+bOauuA0dJ5mtRtB5MblJZjvPf2x/vtSv0PYr5YGga?=
 =?us-ascii?Q?8Ge5Ut1U6JiHQddMBWlGSagq1cpOslutNG8/Ta2oPexDE+cSQB8AlkZHjSeI?=
 =?us-ascii?Q?HHTlXy2oM3KTBQZAVoc72Nnk1QC8k3rJYjKwDXx/wJ/VBcXbwt9zrnZXK10x?=
 =?us-ascii?Q?hIx836XrARIr8eKEXvbYYmnmK0WX5oHkgHc/MOnw9YrfcEU4K5TgsM/UWdWY?=
 =?us-ascii?Q?Xx9FiWlk/ylHn7YxzRhe6a+n4iCR3LUM/hlj/fdpfQCvAmV+zcr8ffeDKgOt?=
 =?us-ascii?Q?BGZ4sIbP9gL6XOUJc2dIPbOXP6fA2VGQ64G+Fe6bn1IqNBVAAyzIeGnoZfpN?=
 =?us-ascii?Q?CG7cRrFp2OwDGCBrcOENW4n5W+SLKdwKIv0O2WObJVB0YsS4OPpz20MAM301?=
 =?us-ascii?Q?lONHgiv1L559M6tpUcJZrP3GKOWAfINSS8JKIJ2V5g2gnOqGew5UKtnXWKzj?=
 =?us-ascii?Q?Z+AZkyAwiXAqcBp+rR5tPJrQ2sYWo4S0sqVcgKFVLJsOD9fAaR77bSrl8H13?=
 =?us-ascii?Q?nbxZS1CqvO3UzyyMrJWwU8i7rCV7k8BfcHrak5FWJ7jXByhAvsKfbqJJNjBU?=
 =?us-ascii?Q?/iSrA7wM2BhjF1Xu4OqVQXi0UTtjFLL65yuxLkvCr0yx4QXbPCHMkRxeSSEp?=
 =?us-ascii?Q?DdggnLul8VsfamEpZaceV6BET7jhX/9aX2k4A5Bc4xSPmv1MAoVdYGLMuda8?=
 =?us-ascii?Q?IAdhBJEhe/K1jEf0AtrKyP6XSPDs1EmdVpWyHLh5tPILSgDjyNBC8MT6M5Oz?=
 =?us-ascii?Q?3SYwdyFR8+dMI1W+diF9uiz193wp+z3vSA4w+qm+ZAusIpofDYTzmmqE8Jp2?=
 =?us-ascii?Q?n9vf2e2HoWzTQecZOpONqXFO2BFbd6zst+qFn8P1hby4sZ/SHPi1uFKsz5wy?=
 =?us-ascii?Q?anK+/NvqwrSDGY4jFKWoNrdF8CEJzciVJS8qZR+pqnoJwGMKjKcqBcArePQb?=
 =?us-ascii?Q?lLCsuNu89H1OpxSmaB5MO88xjpLyYIueCAhzdV4FsH5dzuFIeNtqstW6dgq/?=
 =?us-ascii?Q?TSr/a2Gw32CLTBHl6p20pKosS3rl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?syg6oOvJ0NqUWvLw7kk+3ouwPfyQpBTFumO7GcccnnsLd41gwrTK5ZLcAu15?=
 =?us-ascii?Q?kAtZ8I5OOzdnf7NaNhxVYXTnDyyD8D9PGw6Gp4EqWNu2AGNqdChutJBIzMyp?=
 =?us-ascii?Q?dH8L6V/aLtxY5jGbAgoJel7iuxkelVxYyAKRc36wllQWgA9sAQeiyAmFDs6R?=
 =?us-ascii?Q?zMi4ACVaSoWrAlAIjwH7kjAPYw2EpafqfKN3kR/wCve2qJNU6gzMkLuRnSR+?=
 =?us-ascii?Q?4YLAnJPhYfvVieimtk5/qtD52ptcDVtBvgDNPzAF6S317pDWXhRddi2bMdJ3?=
 =?us-ascii?Q?LWyg+0tIQgej8jr0W5dbVU+GABbD+/+cHzMkEml7L7O8dg5BY/HK8u2Fbq9a?=
 =?us-ascii?Q?kABQ80/IOnn6L11ZvdfkpPO/VZAEEAxSZmvQjLfR82SKAEHTO01feP9imb4X?=
 =?us-ascii?Q?mQbz5KItm07hlfAxJis48Lh2/eYrteXpaiwcfP9yLVC9uRTrH2VnLPwbWGD9?=
 =?us-ascii?Q?FdnjdIyqvYRprziZeekrIjp6c8/ZxLCKHBoox5EuuJQg9BUw0alcqoE+c8gv?=
 =?us-ascii?Q?8skkYc6dJl+ttJEW0FRvIWPVioEpb17bNai5QMA+2TeXuwePyHbpiXFJTPwT?=
 =?us-ascii?Q?mxJY7qbkXFlhH3MJ+QknyVasQacd9/EulqQUZYxtDgB3LzIGx4iQ7pr1ggnB?=
 =?us-ascii?Q?C73b0ZXZCr8cku0bEcaTXuOzM54bgYdCRT9L4jY5N851S1XzlvbJWvmVhZVB?=
 =?us-ascii?Q?eddc1KQmSFjNQr6DEw/MoRIMcPYanHVnUGAXhtVMOX8EvyTwf2/8dufFPuVO?=
 =?us-ascii?Q?MNvx7v1Wkl8nUTqF8vSXcrTvi+FphGqOD76l1j3BkS8Pn/aa6pdACmYjvL31?=
 =?us-ascii?Q?gFLfjwobcCSooz+H2eF/kNu5+noe/xnvuyot0/nZGDSj0W99C91/SSZoinU3?=
 =?us-ascii?Q?fk5rwPwBiiA8PDZbZ2WWpYdYPILi4oLbTjYAEJ/BevnEn9Ox8OUEv0qdpOV9?=
 =?us-ascii?Q?Uur82LpNDc1F+r91pfuPJ4umWqNlXE1mlHD/nmsOELB5VQqyrAK4xXOTR39B?=
 =?us-ascii?Q?l8pOm3GNP5syRO6asoJqDhsxpOyGzeNjQ2xKlV8sHU808qTCZoISOzGZ4jyw?=
 =?us-ascii?Q?bAqAdn3U9wd2Fpxv0VFxk8mPDXuP5Q1w+sr02MOtqCraSS2/Q35lwocQxdbi?=
 =?us-ascii?Q?ikQ4Uj9/q+3KIeqty+LTcgLKLVd4jCROiwqA1YCTxnBHkiLN1Ce3mcGyD8y8?=
 =?us-ascii?Q?XuST+ZnW+a+i442CeGnefIyO/c4TJuNfgPr+9JzcgJF6dLsextGMSJ3Nh2Z3?=
 =?us-ascii?Q?zQPNe11AKmC7SFOOrV3Q67KUviGsqPFjgI548GZw5uJlL0VaUvQlgIsW02Ql?=
 =?us-ascii?Q?nL8mWIhebEUWmvER8n+jfb/VZZ91esAp4uPYnmWWf6CaW66Wwcl9yCBUvTyI?=
 =?us-ascii?Q?2PJZvThFAWkm+zoIU4Cm7vDiTjjPDmF6sj4t6+aBGAjPJVQY4rM2xNYpLNUh?=
 =?us-ascii?Q?an+nG6Pc+Y4i04zE/3Gkg35RxGMSVseNTFFwk8JqVUwzJ6a6ljZAWcO8r5BZ?=
 =?us-ascii?Q?X54zvswanlPoOIrEw8rC2iIVj4Sk+JkRuR0GvKdIbJmrpJ6vks9FSK9yMPZW?=
 =?us-ascii?Q?AH4AiOdctnriG7sCd5kiQqtfr2j3XgqLCptjSuYag8WWpVZ7WuT4rRju+plV?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859b9873-345d-4bac-8546-08dd567cf05a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 15:47:56.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/cdUVkEHwTVpAxUS1Kseb1AbiGIAvxX6tKQBiqNJ0X8A123hv42bJtXm0hwQyydl5Zuw8TbLxc98r1CNJ4uvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8973

On Tue, Feb 25, 2025 at 03:44:58PM -0600, Shenwei Wang wrote:
> Retrieve the "ethernet" alias ID from the DTS and assign it as the
> interface name (e.g., "eth0", "eth1"). This ensures predictable naming
> aligned with the DTS's configuration.
> 
> If no alias is defined, fall back to the kernel's default enumeration
> to maintain backward compatibility.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index fc41078c4f5d..5ec8dc59e809 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -622,10 +622,20 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
>  	struct device *dev = &si->pdev->dev;
>  	struct enetc_ndev_priv *priv;
>  	struct net_device *ndev;
> +	char ifname[IFNAMSIZ];
>  	int err;
>  
> -	ndev = alloc_etherdev_mqs(sizeof(struct enetc_ndev_priv),
> -				  si->num_tx_rings, si->num_rx_rings);
> +	err = of_alias_get_id(dev->of_node, "ethernet");
> +	if (err >= 0) {
> +		snprintf(ifname, IFNAMSIZ, "eth%d", err);
> +		ndev = alloc_netdev_mqs(sizeof(struct enetc_ndev_priv),
> +					ifname, NET_NAME_PREDICTABLE, ether_setup,
> +					si->num_tx_rings, si->num_rx_rings);
> +	} else {
> +		ndev = alloc_etherdev_mqs(sizeof(struct enetc_ndev_priv),
> +					  si->num_tx_rings, si->num_rx_rings);
> +	}
> +
>  	if (!ndev)
>  		return  -ENOMEM;
>  

Shenwei, you don't want the kernel to attempt to be very smart about the
initial netdev naming. You will inevitably run into the situation where
"eth%d" is already the name chosen for the kernel for a different
net_device without a predictable name (e.g. e1000e PCIe card) which has
been allocated already. Then you'll want to fix that somehow, and the
stream of patches will never stop, because the kernel will never be able
to fulfill all requirements. Look at the udev naming rules for dpaa2 and
enetc on Layerscape and build something like that. DSA switch included -
the "label" device tree property is considered legacy.

Nacked-by: Vladimir Oltean <vladimir.oltean@nxp.com>

