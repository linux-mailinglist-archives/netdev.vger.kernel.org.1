Return-Path: <netdev+bounces-120135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9739586E4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5730A1F21CE9
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDC818F2F9;
	Tue, 20 Aug 2024 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YBlycvda"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AAE2745C;
	Tue, 20 Aug 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156948; cv=fail; b=fnY/jsrLp+0qDK21upiiCuXKiz7tCFjPT698MQ9SnHT65Ey7a0KEjsJQkcusAsoISR8fK2cy4yC1UF6rUN80DeEttBZDGlFvUjydQyDwfGskl4p5Qgq8ZQzavUVqXqZsIXLHP2f4GCNi45q5TpklTrSxwZAIaLlfQOD+36BWBaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156948; c=relaxed/simple;
	bh=L8og/WcuC00jMvXIWoviNEcy2nil8wqNZ+o/I7wlCFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eci7KcTGPtkHnjFoeUU2fHagMRD2xu15T+2s/rS1MmMMTwwDkZOIAf1X0OA6kGrhej6HgyCe6aUaZaskgpwFJua1Wdj/AeDZM9B2XMkOMXcno1ju8aDQsYyAXLPX4A/Eew/9JfbzAT9iZrvJJjGqRr0nTYEC+kr3Q9QwKtO6qx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YBlycvda; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wg1GQHJ8LApy/J91YNLpeooUZ9Wr+RDdPZm+CFcRUICFfWrW4wmYvqtNRFrptFwR/F+hIcU2KnUkBD1l3OkkbebQmY3jJvTy+WmmxDo7GrRGAR0o3GEIdr9xDizKmkuC/QG5+ksIIPpJgXsJ/seJAllgKMQ/PAZqQMV8TN+Pu6yM9GcJj4UX00fm1tHcn+X/rqHV6N5wphR0CE2e8/aDLgkI1jFVtiIFL7Dljm3W7XM3a7+RLAOvaZVosmkpqBddmsAhNUjSfFWsLytp2IMv625jOTuWA/g8vZhpiQ9t8O3LNfxg8RmfRL7Bbai4d3bI5OTh1qT8+4ntj9WH8OWsrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HT/4rpTMY/vCDy3i3LuxpTtLeVr+DYbeDQz6+ZnlJKI=;
 b=wUOSO9cvo1KVec7QcuLrA+hoQjUzt5+5xKRu6V8DQ3asKfPfwLWOGPjMlU43sQmkolcBvsSPtuHA4DSUQyz4mlq34LaLr0loo0hRq0UK/zukddtR6XxGsoZLFPQtHY73kCh6uNN9+Ls3xH82upBgYv1a1mVI4MbDKY4ICQrJNwL45C2PzU9RG2jLinJozDk8Swwn6UnhqWn74Dzw3TMMMC/JONTeiGz56SsiFB11MP6gagtPN9rQ8bqhj/dx+1D1aC8mUBRo1pAfVHD4b966eiMDdd8+kCFSYScONkg6ZnlxkE2FssqKD2akpWeTI89xD55BB+MNfWPM5t82dpJfRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT/4rpTMY/vCDy3i3LuxpTtLeVr+DYbeDQz6+ZnlJKI=;
 b=YBlycvda28peZ8kaOU12rWikufcBcWZtLbmp2YqmEmWd3KEOp7r5Xzj4wUwEQBjci5zPy2XsRwfQcY0VYSOcRCvTHSXkwGAMqTbR887kuiLvxuGk7yvFfP6R963FizR8tpyR+p1xfBr2gaPD4LE8XYXSrrVeDCLwTstDvvzfGvaaiCT39XiUatRao5ARmTITLttTgLSHVIHfhZtuoNjd/2YQK7GQyjjcTUsDZFFCbqQHewKy12dV06qxtBc6KDrzecJT/3EWD+MD1TS/Fg2P+f3cU1BDiCN2bR4L9JqaFw9woGhyuC5kdpeI41qb8HByme2suyLWptJP8UMnM45s/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 12:29:01 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 12:29:01 +0000
Date: Tue, 20 Aug 2024 15:28:45 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn,
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com,
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 07/10] net: vxlan: use vxlan_kfree_skb() in
 vxlan_xmit()
Message-ID: <ZsSL_QJfZqp6zqtc@shredder.mtl.com>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
 <20240815124302.982711-8-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815124302.982711-8-dongml2@chinatelecom.cn>
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a53c32-bb83-4eb2-0ca8-08dcc113abae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VPVGrGRY7Ho3eleYAJ4NTz1IBK7GHeGotB5vgwh1KlAHw1/oMkMppUre3GeK?=
 =?us-ascii?Q?jtcTUuu75mPxikAS7Ax8BA79Khjg71QQLdHwWQWTLq/5oFICF5pq8W8VkcRe?=
 =?us-ascii?Q?z8Hy/fCCSyRU1Busxinh/BlJ79kSZrOTceYuqMGw5N+H/78f3yTgjhGNi3FX?=
 =?us-ascii?Q?A+PFcwnywtDjwJywlwcMjafnJRxPQJ7cSe6to/W1ZrY203VbyCZKIE/mSQF7?=
 =?us-ascii?Q?W0F3d1ZEmWlPUjEa0NuLRVOEXrG9rmHyUONaYftr7D3MmhIuIMtnbC/ftfZj?=
 =?us-ascii?Q?fZSJZc2Hm6sz3Wj8xAL22AU1NQAwCA/cW1GRQqp9nnVS6Eo6ujtvse3hRJXG?=
 =?us-ascii?Q?xHHP1H2olR901XSVp+8h8oAe3G5jaiLvIxqf6w2wnKBsMnbUOp0gYwBaeOMa?=
 =?us-ascii?Q?vGmlAA4MyiIRbK3H08D4FfaweQevCej3u2lwYiCb3oYBuyTvRsHiLOuHUPrr?=
 =?us-ascii?Q?QmwYjDxVxkNJllTqR2V86jH5TiCJiHm/qbgAyPs7IGH0h6aClluWzWWSXMYG?=
 =?us-ascii?Q?tQPeJ9ZxkKwcp4Rj6va2eq/zohjJoJKs9PzCst/yethyKUwh7nDqWUMq1Jp0?=
 =?us-ascii?Q?79FX+miX/bkgnQD3GSOPkZWCZKQc/6F1N07oHrNAwksvkxwQRyaQ3H1s1aGI?=
 =?us-ascii?Q?e0fA8hswM/Xbt7AF3F+wWpAICmBBg1Et/5jTMaaJqVpfDCPJuVLA0oWwXFW/?=
 =?us-ascii?Q?iMloTm8uuI6LB3E5sgLc+EAETXg+4gu37dNKYhbhzVYxhtSBONPYbAggd0o/?=
 =?us-ascii?Q?HCFvyQIvtRI8AzAKAmVYLUjmJAWhPJJh4MvK9O0pTRk/qVzk26UcwZj+Vcfc?=
 =?us-ascii?Q?w3WrAHLetbVLKWhT/uwdeljU4JvudpBasiF/OAXECG53KqyWAnWCxbFzxGtc?=
 =?us-ascii?Q?nUhKQ3K6i6uMhnreaSRyVu4+J6o38X7JSCY9mcVQdx4ZOZnvC8XuQntJR8bh?=
 =?us-ascii?Q?tcj5zJmJ2s3LASD5mdY51KPg92EWEPfOmbsTVmjMYq8ACzS6ZLk09RsrbkXC?=
 =?us-ascii?Q?QvWW3lwQlyLRieoL8ImdHqIaIymFX4ZyYnLwax/y4bE281rkw8OLMnbqUQD3?=
 =?us-ascii?Q?0z+ubIV1wC/j0MWd+jC2wCvcVAZKN/ySMDTTlgTHyTSjQIn7KeQE6IHxZ4vm?=
 =?us-ascii?Q?8q+fsy+ml1GChB4IK6qHf66FIVVA6yV4gJEvL99yPjZAUCAo+CFaDcgafCAk?=
 =?us-ascii?Q?DP81VWTpmfzqpptmDqSKwzsg1dibmsLejaoeZW39qtDy1XwxGSc5GEmSp5kO?=
 =?us-ascii?Q?lSLGFEb/fmduIwvtN7swuOZPdmo3x8m8rl5OnTRsdJ0Gu+HiYlV2WEHqCaIF?=
 =?us-ascii?Q?y0Z94BloHRsucpqPHIvNiwkgQ5LNmbwTBDWuXjanUDZQQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sP31Sgyoz1grLXo5//3aiHkx5zzZ9zAzN2EfTpH9FFof6o74VPSFVNzsPqdp?=
 =?us-ascii?Q?b3bD8ejTtZVWtdO48uW1fN66orG7jLaLjP52MyYgtS8S6NUufqE/6RGdma2R?=
 =?us-ascii?Q?CAbkzyqdgp4YyUb8rl5owwVxo5ucJIhqLTNz3FK6AhhMM1ZWu3wkfoO2APWs?=
 =?us-ascii?Q?lv3VEGBDOD89+t8BH4QSMjRiydqZdACp01PEJz0rJp1QcARlJ+3XyjCdoMxe?=
 =?us-ascii?Q?NSki9yXA57rVnjL8f2yvxIQaRBekHtKc3cE91G1zmNCnKnUbimYBE3y4MCxz?=
 =?us-ascii?Q?kKWMtFIN0oBTmeJ0f0O2KPL1ydZAE0naKpe9GG2oGa0fwbmZ+UtAC4/l6aLH?=
 =?us-ascii?Q?K64UPfbfjSrjCmOqHsnTRXqGC/dabsKc/hpRIIjAHXN9/sXZ6/GOu1j0W2sT?=
 =?us-ascii?Q?lE7TMgF4CjDJzUinkkbtWkn7ocXdAWQNCJ4BMKmkCCD8BHmWly95NpySRcFE?=
 =?us-ascii?Q?+Ki8YipaTGiuR8tmapnlVCeGm/2tF96k5fp7tRMKUGXJHFisStrgYo71PdjL?=
 =?us-ascii?Q?W/PQIRqogn5M7VQIBvzXlwohLb4s5lG9SRv2CRC2rOYR74w3g3VJfS30jTJm?=
 =?us-ascii?Q?UnPGLom+mszUD4v9onFYnwGbdRbua1oVhIkOc6bOt1PQqVxaIL00wayqtlGL?=
 =?us-ascii?Q?v+Cqj8gLVbEtQnAojT6PDR4lYySRrbJxAOIHUugYHE2gKSSXzJA3OEkIwhdQ?=
 =?us-ascii?Q?ninHRzqRdnjzrGpKErv/QmV3ay91gJ+sJ3WmFX2aOKrM+ie+Vg+eZM3yyL/6?=
 =?us-ascii?Q?DejZi0sTouXBqD9LRZ4iUmxFDHS1gZ1SXEBp9cuUo8p67woguyHad4eojgSf?=
 =?us-ascii?Q?KYEbeqjjXA+YONDidkxpPkj7Zwryz4OxMcVVsd7hYVtJYqiWs7vZI9V73Llz?=
 =?us-ascii?Q?zZnlJ5DnyNjeveb/quEUIYqJwR+n8gLr6hDj2MppAhTDtLoEOSwDSU6V8Z8g?=
 =?us-ascii?Q?t0hNVRRmUcRHskoP7pEN1rrnUB3EOHYwUiCa5NJ/dq9qB1rULMfFmtqosHlj?=
 =?us-ascii?Q?5r7FdNUw/anjXZat55w/ZiJM1eSfOlHkGFIDsW9Aj10GCmLraLeUQ45ODSBh?=
 =?us-ascii?Q?4c5tvnny95edzMp6dEQ5iD4/AOsEnhmXI8lEV9P51JcTCFpUGgR884lkBf2+?=
 =?us-ascii?Q?JNC8Z6XTK1lAMjemoy4FDEnppB7De5cZjYdvYoED2gFhfvqH3oXNLV89Zo8B?=
 =?us-ascii?Q?9tY5ymTJ3fquMqv6t3FAtF3JmV4YU0M/3ZukkjKVOUrPiMvcQfkVbsh8ra2E?=
 =?us-ascii?Q?soJXyVlB1PhnAjZQvH0d1A+nphQ1IGu2MEWbsze41M5uhZiv6Kv527clqQnu?=
 =?us-ascii?Q?bS8s/wjT5/t7CMLNFoqiLKYWItWbzyTBcjFPtDBzQIN13dxZ+PKdMvLFkCUE?=
 =?us-ascii?Q?6KfS4MJ5Q7s/v0sRvgbWo3iIHssUQqyOPV/Kfi8VCB3jkyynSGQNjfQa3zKZ?=
 =?us-ascii?Q?qPbPyF/eFXkU9/+BfHaDRuLQcbi76ejVf0SAaBljimUQmCWmWc0chz1mco5O?=
 =?us-ascii?Q?PevqCkAI4/+wRcyD6Mdd5erbkrnJNqPBE8qI6vXj9UjHKlA+PQH5f/Em24gf?=
 =?us-ascii?Q?8VXCoExbQ6xIL8xh882QA+Efr3SOI+skDfuwRBAi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a53c32-bb83-4eb2-0ca8-08dcc113abae
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 12:29:00.9556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuHUrWQfPO/GTZChPmJpL8aQ5J17ufZRzkI4mrNOuhBkRhtAyeqkFU+mdS+/xyFEO4IL1nPzNfPxFkljhrxt+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

On Thu, Aug 15, 2024 at 08:42:59PM +0800, Menglong Dong wrote:
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 9a61f04bb95d..22e2bf532ac3 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -2729,7 +2729,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
>  			if (info && info->mode & IP_TUNNEL_INFO_TX)
>  				vxlan_xmit_one(skb, dev, vni, NULL, false);
>  			else
> -				kfree_skb(skb);
> +				vxlan_kfree_skb(skb, VXLAN_DROP_TXINFO);

This one probably belongs in include/net/dropreason-core.h as there are
other devices that support tunnel info with similar checks.

>  			return NETDEV_TX_OK;
>  		}
>  	}
> @@ -2792,7 +2792,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
>  			dev_core_stats_tx_dropped_inc(dev);
>  			vxlan_vnifilter_count(vxlan, vni, NULL,
>  					      VXLAN_VNI_STATS_TX_DROPS, 0);
> -			kfree_skb(skb);
> +			vxlan_kfree_skb(skb, VXLAN_DROP_REMOTE);
>  			return NETDEV_TX_OK;
>  		}
>  	}
> @@ -2815,7 +2815,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
>  		if (fdst)
>  			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
>  		else
> -			kfree_skb(skb);
> +			vxlan_kfree_skb(skb, VXLAN_DROP_REMOTE);

Maybe VXLAN_DROP_NO_REMOTE? Please add it to vxlan_mdb_xmit() as well

>  	}
>  
>  	return NETDEV_TX_OK;
> -- 
> 2.39.2
> 

