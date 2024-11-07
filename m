Return-Path: <netdev+bounces-142941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870AF9C0B8F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D3A28542F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5EE2161E1;
	Thu,  7 Nov 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mnCdlQ76"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3631B21733B;
	Thu,  7 Nov 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996531; cv=fail; b=TLOhBNAwFOMdjdIG15meIT5aBa3vUef1A1lYLG3xHTNTyqTrdhbaZ988T4CfPFy5eJ0CyTAr8PLNhpyqjqkf1p70MIwr+xJe5UPvYlw2+Shnn73K4CkTcAUpLW+5wjIrI435nLHGrH2i2bO4IJuQAvlC3tTrbPXMVMWVi27MmAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996531; c=relaxed/simple;
	bh=peLGKUQ6+sQpjEugX9vZYbEqQJa7K+LbPc+ooVpK3TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iRBkZTs9DBZAcq0B2VzMSzBVCVadxsNDnJ4Tz273SZnODCEKzAGGe3BvdcR8qTLDNUPgaI2FWm2Cqux56qHVeCrLdDmpgejiVgjoP57Xl/YtxBTZ0JoP9qwiGPnw6xPMjNsuPJt5Wqk0WuRiJTWw7o37WLA8Pouyik/F65VxWZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mnCdlQ76; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVFnsNn5MBVAt4NHtr715tCCorfqNPklOjsGfm7iAdB0y6EmuGCp5TJNBjIMb6Cgl15+QMNXCFqd9h6JiQaxZyO+oMM/PHwHuBevEYaGaxHYcsHIQxzeu3i1LOrl8Rbx1PmP2dJ/e1p7AFTdrhGubBgXN7PbjuZiGcw3O069xaM4EjtdFQ6lWvBJhyTCPqPOKfc/+g4lyOoldU1nvuKioGhz9I+4CSdfLaR4HI43jSyqkSodRx0DiXKG2xkLOb4YsKy/gyg0PTMAQkEhG6YHW0a5PX/j6ldJ5cAK2pDNAzLPXHmq9CZxI65IMMDBODyS2p5i8AwX/upqosV9sICa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPQkFhY6eB5iFWpg1OFpRicwRHoRGElhriksxEvK88Q=;
 b=Z/NPQDM5LCblIRJ67NS3Jsn+WTE9uHcrTPeLkG2IS2tDo3af7VyUx4skrSY47wPKMNbdYlb9/mUtimJDC1qS/YxJEFFUtLlNAh/VQFtQaCaWJN+qDTMPCnNzBLR7+bPFGmBIaqQAKAjjCeNOznjn7MoirpbHIKxVLrNC/UxCP96zqKSyfQKBKdRWF0lo1pm9eppUQ8wMqrZnhGflL+JFWlEog68iCl1uPf4EKmzdfwSy/+RYEX9mn4TnMJHtKka1g1zuC2xEB5hQnsS5e/9yQBqK8QfdKBa9IY+wvAocs1yKZblBLg9XAvevFv1o+cZzRgyA/YrcfIorXUMZV5n/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPQkFhY6eB5iFWpg1OFpRicwRHoRGElhriksxEvK88Q=;
 b=mnCdlQ760FgWW0gL/LkXW2lmdvXYhnKncHUJv31ktnAJ/PEaB5KGYl0CPxqdxr5hvnBqnEWAydptkEoDD2t1//L00aUzQJxID9Dl4Q9fAQzq4GJ8qlZoN1Z7+k89UBIBnhBNy6Pgcm2YOwJNkAG/GUQ0cCoQSh9t4XnAJ/LH38n7B1Wv8PoJqf7NQH2SyeOLn4UJaUFARyk3VbgF9JuBz581eV84jg7AfsaoBssStJ61bodV0aEF383pn59MCx6wdAloeOHXdSqHqxsXiU62Ml/qx+ueR39/SjFh2LFP9CZenIF9Fqs9XRvsE1/i1TGB/FNMchSqMyUFZSnfpiDniA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8463.eurprd04.prod.outlook.com (2603:10a6:10:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 16:22:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:22:05 +0000
Date: Thu, 7 Nov 2024 11:21:57 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 1/5] net: enetc: add Rx checksum offload for
 i.MX95 ENETC
Message-ID: <ZyzpJaRu9KWiEW8N@lizhi-Precision-Tower-5810>
References: <20241107033817.1654163-1-wei.fang@nxp.com>
 <20241107033817.1654163-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107033817.1654163-2-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: ffee811c-62ee-4a58-3e94-08dcff485180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ex2hIoza4a8eLp+mTm66TpkYs8rsgV20/TzHDeDlQ12vohgJObiWBAOW0wJi?=
 =?us-ascii?Q?AzUnEjILVEhGlH9WInCiUSTYYh8boWJcxvXcUM9jXkzdIuCdb3PqTzvJo6oS?=
 =?us-ascii?Q?gEgaVBJvupHJCQqcYKCEFBBzUN3oa2VJ3laqEisMXG5MVTjGEcWXS4HxxmfK?=
 =?us-ascii?Q?sd78mVtkNufcGVISemv5dQgjv79VG1SVh8ZZ8y/C2J5F1S0RlA7LJNCEsztU?=
 =?us-ascii?Q?lF3jq9TD4+UETFjLyNR5zsTw7ti++FZD/GYo3iqiFa4g20woUXuspmUNP0i5?=
 =?us-ascii?Q?VJ6gc4+dt56V5J34WzVbrmbx1gsFl5/0FA//PnFQJhWKPyrvOpA9H7JL15p2?=
 =?us-ascii?Q?Yu2eQHUQ7qFHBaEoy9fbWPY9Y2hEGJNxUQHiP2FjK6eoBomzEsY35QvGG7Py?=
 =?us-ascii?Q?GRyMhsFuhX6kWZ4Fc6HvGjPEB10avcIq/sX+CMsjcYwzXTTsK/gUZSEV8C2t?=
 =?us-ascii?Q?+A25j6nt+mSV53GaI3GV8AraEjbNZEtL0Be1oxdL+GDd8aZuSP1hvuk5RVCS?=
 =?us-ascii?Q?jx1UmNrB5giKPQhFelX0bF2d5eW+0/RUTrOM+ncQEGngS/1MoMzZAPwKq/E+?=
 =?us-ascii?Q?scYlR36LLe22RSphDOpGxyRVtz4MBjZK1HnlZwH8DL2+WSozUsIYsqVfjoVy?=
 =?us-ascii?Q?z3I6nQCwUY86u5jzR3RPZHHnAx0Xf6WVEk48/3pFJhitut99uOaREsZ1koYf?=
 =?us-ascii?Q?19UJRiHPwD3odbus0oh8sVpm0e6pF1wGg3ibC3Jt8PV4hRtPSZDewnPUWL4B?=
 =?us-ascii?Q?Wqk+FTSdjsHvXqKFzJ9aUd4uXJX/t4UXa9b19sUvZ2u2czIMG+DrowePo87B?=
 =?us-ascii?Q?xcfh65OX0VvCpmxnQdQQ45X6qObGX7pgHqgU/ADjaz++oOJzZOoF7lwZboXW?=
 =?us-ascii?Q?Rw3GJCdNdTybWGL4OWR2a1M22Tvsuk63s2rblpUbrLhFJli+dDalSYhT0gC1?=
 =?us-ascii?Q?nZb8r8yzVfOv5wOzGDrvWDo6aW3VvrVGEAplrpbvlyt/VvONgVLv8sTi5Jbd?=
 =?us-ascii?Q?g71EXJDuJ9dhtortU/aQGruiTuw3zpfkZteM0Os/RRYwZd8F3bbf/yF80J2R?=
 =?us-ascii?Q?8shOW2+fUd+hIoM313Y8qMy0pH/caZoC37fpy+wcR62A5nVANygBM57XDIq7?=
 =?us-ascii?Q?PT18f6zzLzabrLWyJ3IcoAtGJGxsOR/cN4uicLy3OsoO2eyfneQoW4WEMxGi?=
 =?us-ascii?Q?CjS4+tUnpKFXvLLhKbR9YTbzG+5JsPmudQ0YYR3VjR0S1/2hKH/L8MfPmlC1?=
 =?us-ascii?Q?Alwl6GBjfIO5axw8yFFOzeygmeTqlm0UP9vmxwxuTVTVZln8h1Ud2psnsAl3?=
 =?us-ascii?Q?epCsmin1XbKOpfGvz8oplGIWWpah1Cn0DJEa3FYjzaC/KVFZrZ89usJod4w/?=
 =?us-ascii?Q?okHqnps=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JrUjuB7Ka8z5S9xWAOlKpM2DwXAR4ANtFCN1IAU/0REHLeYV3oV33i6p/Qg2?=
 =?us-ascii?Q?KwuUHrz3sikNBggQ/O4kk0YoT1KCKx6DmQWlo4UGas5CW8kf7jOflzY+pebO?=
 =?us-ascii?Q?qP5Oo9ZSqaSo+T12T1XzmVsdxqhhujisojyZgNzXf/oz+hV3DuzkTcLlW9OX?=
 =?us-ascii?Q?0kOz2TPFRBo4OezRT5YQfd8TSk/ddF5UxaA++g1F3cRkP4AenSD29KFwn/UY?=
 =?us-ascii?Q?5T2H241rZVcojXqS4CvJwmrJRAAXwOGu67i0wgdx1r9p9myh0bSsKha6hthi?=
 =?us-ascii?Q?Xd6rwixuoUmFfDjHvqehFIHof9dhXBueRsV4eUXg0Rv6pQGV5aTVAOmNQiTU?=
 =?us-ascii?Q?HGtscHJ/pfj2O4gFcmHNk9Nkn5nKdx8oZNV6hIIaqR53xELejuOsW6Moz6ZB?=
 =?us-ascii?Q?ZRXqOitMrsFzTaPnjTTnO5QeWeEECOtv1GdhkgNk+38ddgFTEPLn+3L1xd5X?=
 =?us-ascii?Q?66dkjh8ZXQ4xFxG1uxAtcnzDXMTMFjHKbh1kougbHAoSrWYMExN/f2Uvrnxh?=
 =?us-ascii?Q?cRtFxnzl0CDw9ly/LbbdZXTJmWGzwATXjKj7zC3gbBkiiC4D0jXbpGBdFbs0?=
 =?us-ascii?Q?qlKBsh6pRV7KMDVcwojzTq9i6wp6J/eaSgy3JwULQpU0IXwBvA3vxeJXElOK?=
 =?us-ascii?Q?7ulo2f00xjX47xq67WOWyB8EHaNVIEaIuNkW+q1fAXD56rTu+uLIR/GzcOHI?=
 =?us-ascii?Q?tLhxDS3Lau2vG74QqjBe10Y5gJZqxwL6npoKxU9MwuD+kBVpTwvStmA2znNu?=
 =?us-ascii?Q?QtI9c5oaa+iiWd7Ronod2T0XzhHEkznRPdW4mPDNmN/t92PrZuCZdV+zJWFx?=
 =?us-ascii?Q?ALoKMYtzvOZQujT0XtTJeGcpYu4FX24HzlfqQRGvGYxKx4oFR780utSVcDgf?=
 =?us-ascii?Q?0uMYgiHHyhzHpDM1qUH/r6cIs7/hy0ulcSIEfElKBfFfAWZEGJIV1NvTRLvI?=
 =?us-ascii?Q?W1GJismPXnlsaIqvE06zFOjnnd19lRdBnj+ee84t55dHXpZVsAhUYN8owoMi?=
 =?us-ascii?Q?XRqmXLTlkisIQiKWaDpwL4PxGJXcn8cVrrVc2lHl6GWh9N8QyPoP9JiqIIo8?=
 =?us-ascii?Q?f/MsXD8d9BnQWtcbIIFjbjXE7RzqLpmbxEUuowXJ3yhKMz97mrtLXYun6yat?=
 =?us-ascii?Q?N9CSZdHST1m3jmfk+yM0AO3dRl2v/M16pYRNkLWgIsfNIc5oOP0YISW9G22t?=
 =?us-ascii?Q?+RkA8TjX1pdoVHvgl7KP0Dy8jwov+CRM/ZU7nSnUSpJ7r5OtC1IUyTU9bEtl?=
 =?us-ascii?Q?sq4/Fy0deyb+1E4DUFp1tjNrNX3ds167V8DkMKyXWohajgZMvXUsIlFlgA+g?=
 =?us-ascii?Q?GvqnNHxXeNAINQ9FcvVZT7I36QsN2Y3u+mVhV5Gj8URUDbi1+9fkLv2Pazxb?=
 =?us-ascii?Q?2NDy/occB5t8YekZaBTLW0oktHXaI8BibC6BH7J7lDdG8BNX+q/QnWJMlLCT?=
 =?us-ascii?Q?0ENc2QKogc6bHqRRbufWiKzf77i96+G4xe0PXY6lft666eol3h3Drdw+Mc3n?=
 =?us-ascii?Q?WHVdJC9sik0wVV9+AZVswuc0sT8ncqOQ0Kd9b5helFWNriCZG/O+tb3OoFBT?=
 =?us-ascii?Q?TqgMwoASPHLxnOvIhZiScvnlvJdY8MXZRCa2xKUC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffee811c-62ee-4a58-3e94-08dcff485180
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:22:05.2572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAyn71FIqXDnGFhATj73rdSmCH+xKWpVIXpj+bXcxE3JoKShzEtFtCA4WuaVXfwmz0qyGzQl++BoK4ajGWlTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8463

On Thu, Nov 07, 2024 at 11:38:13AM +0800, Wei Fang wrote:
> ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the bit
> 108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since
> this capability is not defined in register, the rx_csum bit is added to
> struct enetc_drvdata to indicate whether the device supports Rx checksum
> offload.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/net/ethernet/freescale/enetc/enetc.c       | 14 ++++++++++----
>  drivers/net/ethernet/freescale/enetc/enetc.h       |  2 ++
>  drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  2 ++
>  .../net/ethernet/freescale/enetc/enetc_pf_common.c |  3 +++
>  4 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 35634c516e26..3137b6ee62d3 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1011,10 +1011,15 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
>
>  	/* TODO: hashing */
>  	if (rx_ring->ndev->features & NETIF_F_RXCSUM) {
> -		u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
> -
> -		skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
> -		skb->ip_summed = CHECKSUM_COMPLETE;
> +		if (priv->active_offloads & ENETC_F_RXCSUM &&
> +		    le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_L4_CSUM_OK) {
> +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		} else {
> +			u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
> +
> +			skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
> +			skb->ip_summed = CHECKSUM_COMPLETE;
> +		}
>  	}
>
>  	if (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_VLAN) {
> @@ -3281,6 +3286,7 @@ static const struct enetc_drvdata enetc_pf_data = {
>  static const struct enetc_drvdata enetc4_pf_data = {
>  	.sysclk_freq = ENETC_CLK_333M,
>  	.pmac_offset = ENETC4_PMAC_OFFSET,
> +	.rx_csum = 1,
>  	.eth_ops = &enetc4_pf_ethtool_ops,
>  };
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index 72fa03dbc2dd..5b65f79e05be 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -234,6 +234,7 @@ enum enetc_errata {
>
>  struct enetc_drvdata {
>  	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
> +	u8 rx_csum:1;
>  	u64 sysclk_freq;
>  	const struct ethtool_ops *eth_ops;
>  };
> @@ -341,6 +342,7 @@ enum enetc_active_offloads {
>  	ENETC_F_QBV			= BIT(9),
>  	ENETC_F_QCI			= BIT(10),
>  	ENETC_F_QBU			= BIT(11),
> +	ENETC_F_RXCSUM			= BIT(12),
>  };
>
>  enum enetc_flags_bit {
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 7c3285584f8a..4b8fd1879005 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -645,6 +645,8 @@ union enetc_rx_bd {
>  #define ENETC_RXBD_LSTATUS(flags)	((flags) << 16)
>  #define ENETC_RXBD_FLAG_VLAN	BIT(9)
>  #define ENETC_RXBD_FLAG_TSTMP	BIT(10)
> +/* UDP and TCP checksum offload, for ENETC 4.1 and later */
> +#define ENETC_RXBD_FLAG_L4_CSUM_OK	BIT(12)
>  #define ENETC_RXBD_FLAG_TPID	GENMASK(1, 0)
>
>  #define ENETC_MAC_ADDR_FILT_CNT	8 /* # of supported entries per port */
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index 0eecfc833164..91e79582a541 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -119,6 +119,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>
>  	ndev->priv_flags |= IFF_UNICAST_FLT;
>
> +	if (si->drvdata->rx_csum)
> +		priv->active_offloads |= ENETC_F_RXCSUM;
> +
>  	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
>  	if (!is_enetc_rev1(si)) {
>  		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
> --
> 2.34.1
>

