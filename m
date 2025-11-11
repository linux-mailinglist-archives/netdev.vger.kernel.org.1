Return-Path: <netdev+bounces-237758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73832C4FF8A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 23:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEBA234B535
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6142826461F;
	Tue, 11 Nov 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QKD+ovrO"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C1257831;
	Tue, 11 Nov 2025 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900233; cv=fail; b=XiBNrght9msjetfbedJ753m26Z+zBXXeNxzN3NIO5P7AQl0fIcSbcu0R+feI6ScnaOmXLyAtkZkHvKCG41Uol7LXtNAzYP491SBA84L+aoFMOQC4s1GH7f+7N1wUHC+F2gVpyKU0h9qwB5590jMnfvBh5Yf282NaOHk3HMOkiR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900233; c=relaxed/simple;
	bh=mm9lwlmsDevwwEiIBgNwCzJYAbYYF0zAoW001k1RYuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gCq6106Xyh5N09u4a4sA+lvI1E6nLvM0s1usDVWfifx09xzgaUgStYdXa3mWnoEJL6bw8mpe3m0i6MuaoDnvO0aenAj7sViOPCFQQotsC1fZa3s+bI1a8qRrPlBOpA6zjzNijrXcyn0hQnSvSDIUwBHLoYrmCa7ZflNuv2Lcxbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QKD+ovrO; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yadiceL/MiR5SNjG/NOj3grgWculBrCf05DEgp8T3m19SLQym8GKJgFI49JU7MbGKot4KsUp1bER++CyoQ0u9CodS9/cUgvxZfQuMx1kSFb1cCRnVg2drwcv+VvgVhnqIcBkWfksapVQ2psPl/VYNNdY4k9s4wFQ6qE5f+HHuC+MSoxIiHeUD2MRhlDeYC3XWFpu4OiwNEjG329gnRehfUcCGauxK16GUr698/yObfqRU1Br9tjDsEx91Ur5EiBJLQFCXvl+lCmFjSvXHYrWRw9L8wJv2+Sx0OCuN0jqGFoDth+6GGFY+SjW94NZlAj1NjDg9Tcrhcdudxm/8Wi8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NVzhiXpY9RtbW7HOAL++FF/27ToXFjzs0J4w9B59R4=;
 b=T5uCtlOm2BwHNTcJXO2LhDPG+MP0gNWqLm2lOPGuOopUrp7wyNyyvm1HbleINO9OcvESxKL3V6ZQ4nX1C2gnfvclzuwIZopc1KMdyw0DDAUm5BhF4PLrohO7K3zyG8GuVtQVL6tRYbVJDvmcwSlhxikajpPgoPuluI2ZJmnFwTU2hZgSyY9SUnyT7Y3h+5nwi3t3dD+qvM9joNBVrswYVfF2ZUnt/RAV8lQ/QrEwlTOcYl+qfULAx8B7dAphOInVic4/Z0D29UJid8oSuTS3zBFCeYTvfcW6KuDjk7KD2NgGy2rxVoCrtjYXCVlmE6H0va2JrGUGvB+XC2KbJ6j9ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NVzhiXpY9RtbW7HOAL++FF/27ToXFjzs0J4w9B59R4=;
 b=QKD+ovrOHNZdp6LBXd4B0lwYuRvIZtC3Tsu8/RifInZ2BydJe2fFYRNcWPJ7IgPW+6XdoHx/IGVeoX1bXme0gMzgDm+wWCJV4hwAj2aHASwB6GteR8SKtUVICfGnR9XldNVlY6mdgWFMWBpaKmWMjAIBL1LdApx+MX9Am9jAoAgv6P752XYpZz/Iag1yZ5dZH9BZA5pre6pF0DQTe4cyMSwwQxqwnq99vcotjQh5ub9W/SCnL7k5UFLw9CezV++8Ik/29P+CDN2RnlYJq16oAFbsGLAu7ax8YiOfTN2tm03f4KLojGocZE4PujIB3aUP8hUxk4IFZQH2/QsQzVz7xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 22:30:28 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 22:30:28 +0000
Date: Tue, 11 Nov 2025 17:30:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eric@nelint.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: fec: remove struct
 fec_enet_priv_txrx_info
Message-ID: <aRO4/l1bMgugPYhN@lizhi-Precision-Tower-5810>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111100057.2660101-4-wei.fang@nxp.com>
X-ClientProxiedBy: SN7PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:806:121::33) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DBBPR04MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eebf5b9-2329-4389-b0ae-08de2171ea81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+u0W+UWVVWv8MvKP16GxGqwxnuClcC1DYlDgpKtqty5xFkOPXEGDFCv5iNjZ?=
 =?us-ascii?Q?iwHJik+GuZVgI+TL2iwCL78L28YWkxaqjzCt6PCM6yHPULuR7205LTArlGgq?=
 =?us-ascii?Q?NR4BcvUKGHA9LCeRMpk4P5O8czD4yfs067fSg9oAtI/ZL94EsblN4K4kFUAt?=
 =?us-ascii?Q?NkW3GZAHr8QcFg+tu3tHOA9FT2T9n5hdJ7W9h4nO9/B4wqQNWT/h0S3ru7Xr?=
 =?us-ascii?Q?g6sLp5yPgDMDeEinLKIC+sM+5Fpr5rbIaoCaEm2ZARiSkN833zDab3hAnY5Z?=
 =?us-ascii?Q?PaLfule9SaOEjZ0kEfSDc1k92y8U1fIvlqQdGWbxsIbReCuhimt5my6Cwc35?=
 =?us-ascii?Q?m7jkDfu/TyYaGZS1r3+yys67UCVGnZ5jeUf7zFFyMouT+/adDrSMSdW3AJQV?=
 =?us-ascii?Q?bFqPtaRwaH8GylUxnFiB+FfSRIvjpJKgc6zB6rgR7e/gcsBgMcnyCrNRBFCS?=
 =?us-ascii?Q?ZfUbXABxvrVyT+UpbjPtV94Lrcx5aR6XQxTZmuse+uWXk3ZQoGblB4+WjIv6?=
 =?us-ascii?Q?5Ib16mOfrz8WJp/LjzJ35GI/jeIGDst0ia/NlcppU0sF1g6nFrgApiD/nCzR?=
 =?us-ascii?Q?lnF967HO6TQsLtdUmmgCFOpsqs6fx0KnTbMp6czBjnpOytxT+9nw3Nl1n6C1?=
 =?us-ascii?Q?Cel+k9rPbdDAgRqy7CHza5sA2LyIlBGahX+oamRHWqpzYFo7Hzbi3y/zevLS?=
 =?us-ascii?Q?fVn8ZmTz8nAhbfgkqXV4UKCqVlAR1vjrAgJ4aOrFnmgASBrkUR3NBkUmVygE?=
 =?us-ascii?Q?8vJJkKtn7U5PYsZBayJtuq6oG7fGKCjfwoMbDXvFCI4Ls3fyXyAAtVGmSvvq?=
 =?us-ascii?Q?+sf/mm64KmA0MvAIsyAm9A9J3ptxcHeAW7L9qmwu2TcJ1qTXsnJi6TBX7AKy?=
 =?us-ascii?Q?uiruTGctlzr3IdKNmpOdarUcECez4HRmnATXEfVZaDy0vY/LGFC51QXtT8Ec?=
 =?us-ascii?Q?ok134HBEyK9GLD4y70A7IAFY3nKJjI9SbPlKhczpPoNXjAs0mgTf/KFsAPdi?=
 =?us-ascii?Q?GnllkjqWO4QrUVVvVGu1ZDyV7uc2Ex6fTyliodTn5dR4p3Jb+kgEZfu6FBos?=
 =?us-ascii?Q?L+mpWpDhTiDv5TbC3NxgzAVg9xxKBvH1vzhKIAMcKx8NuB/k9xNEjJeOjKqa?=
 =?us-ascii?Q?ZozXji1hAcz/p2D0KxI3iPr6vku2DIsnqvbb3s/dG3ypEje75Njp9I7gwSb2?=
 =?us-ascii?Q?ZXfykkq8mntvc6jdWR3Sh445Zk881a6oDnlYeAnSAeiwPJL6tJ4eAGvAx7hY?=
 =?us-ascii?Q?ld1LyLBvMHeCRwdaLyxQ3MmnJSA62MPL36xcdga4s5mrZQdYhHIKuoYqPOsl?=
 =?us-ascii?Q?/PQWIghQ8LDq0jC0KCieTzt+nF8gEI5Wq4u3kslwpPkffGn3cXrTO4eAu7ov?=
 =?us-ascii?Q?/VpEJmZGNdsiMRS29HBhF0HhNkQCbZJUDy5nVQF0ZG5teqXWPOOxyrmAxiGy?=
 =?us-ascii?Q?oD7gA75W0XllamfwJld2UnWM+6TNH/NIZOLrx5/CWFsBO2emj9kfsXlEXbfr?=
 =?us-ascii?Q?/2/V2c0SS7NUqEOGXtB17CcnM7HmqPuPu+Fw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n6evYNs32S/RUBF/ENOH9zo4jHGGfbZpmGXJYBFPtEs3WtoCgQusKSeCyWPI?=
 =?us-ascii?Q?Lntfe7YSmKi4gIsHxwfn/3FUkyLojOQfAMtfq65kv6zOpdS01VFuIOLO8qnp?=
 =?us-ascii?Q?mni8E/dJjsVn5E6UcGDmuQBeOdcYRlr3RIcwcrKBJOg9GsMqsdiMg0dG6Gla?=
 =?us-ascii?Q?OhPqAa91IYvemSdIJtf4EKq78whDUxT6orMOsQvb0acBeaLa3y56BWTx91Ws?=
 =?us-ascii?Q?Vu5oGIiJiafhdtlQ+q2DqAA6N2SBf5LLMAstL9lnM6az1l3nS9Urpa+2aP2z?=
 =?us-ascii?Q?B9aWUgxXlWOd+aBF1Nr5SV+A8G/HlS4N4VYm+Pj9yRfVpf+tDrf6bfRIWZeO?=
 =?us-ascii?Q?vcQt7CKCT4070G/mozRkjIYGpX/9rOMOQrWptjquLmWKv0wJBnlHxnA0Fzao?=
 =?us-ascii?Q?7WK8Mh98y0asUVQU30hh5DstQMmUjXKWrvs59raHMSaVQIjhnFP3aC0fRXDT?=
 =?us-ascii?Q?vGSBx0U0aGr7mRBEYImO6FnKKKubHhGOYMuS3oSZrqqJOlAih3L6rRvHpCDp?=
 =?us-ascii?Q?l9C8YZUG06uEgadK0nyf1OZdnD8t1gI/+pDpxtPIWJYCRq3OVxpoZQprBbZ0?=
 =?us-ascii?Q?GMefPSgA1NI6Xj9E25UYWTrhwYKDQ7B25Nxgz8kwkO4KTIcvf72ve2bHZ9HE?=
 =?us-ascii?Q?5D8IOZ6IRbiWiXwsag0KynxtdYGFaQXBtMsEcp18RVmG0gi3FN8MXRLDMoaA?=
 =?us-ascii?Q?xegNxdihWEO7YF841IS2W3JgPK3/8WMz0QUC3CvYnLLUKU3AkgA6F6Ahb49z?=
 =?us-ascii?Q?WDEZ/iQ5yh7xoR60GniiOtuEu9nVFxeRE9LuF9lusmH1qvPgS1NQi0uQhLQ8?=
 =?us-ascii?Q?KJ0o3yLcTj9xA/5vfGjZa3syhEcZqSDYqhYtAYC2jLtqmMfCpakpjJv3Q/YQ?=
 =?us-ascii?Q?RwPCP+Cw7CI8KDXSUdcVU/qHdVMQ1g+nHMFNNFDCXM4GFyFP/OtaCKzPkBSL?=
 =?us-ascii?Q?x+453lhph/TY7sIRDvmYP9vhez1CGPUwTmDu76jBEzcC0xzU/MGlKQE77QAb?=
 =?us-ascii?Q?FjoUZ3b7bdTXrI1x0gKmd+biotz2gpb6L90BMMhMVJZhOWEgj11mOrX4+fZA?=
 =?us-ascii?Q?hWPNqWJ6CtdbjNVr9SrEKvRvfb7SokIbHwoGb58DcYiUeX3S/APqJPVJX+nY?=
 =?us-ascii?Q?dxLjtRwJ1xqSWsbpss1R23ow+1EPmPs0NNk6IxKfvUs80XVTkxVJTYbykG0r?=
 =?us-ascii?Q?8zih3ddnEoz9G+TN91tpRcuEjmVb3UpsCEtu2n1j6rF7Zhyf9od9tC257HIg?=
 =?us-ascii?Q?nWi14ps2dg8z/lJufP97/Bxk2oyNyQEppergJ04/hR0KyHd0WPlolKZv3i44?=
 =?us-ascii?Q?liDpubbwp30qMSVrOys0tS6T3TkEPJeMqw5j1TuL3K7rtzdst3L3zAAMYJwn?=
 =?us-ascii?Q?vwkKpRy2xg178gkA912/Q+zBIdKKWSZ1eiIO0O/W+8vBrbBG18qPInvJpmAP?=
 =?us-ascii?Q?E5wx70ykcxOSWMId76DEuAwgHv1e2CV1RBxiRuQAJ5pEzXL0hKfDjQfLZ2ZQ?=
 =?us-ascii?Q?kmbipuShdTnWeDnBCHnDohWhf8rzje2pK/vcLJOThbRjo4mQbkFJO5Eqjxxx?=
 =?us-ascii?Q?XrK+jzeC50/xPlFzPV4STpGEa3NUbx02MzYiubps?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eebf5b9-2329-4389-b0ae-08de2171ea81
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 22:30:28.5755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VpcDpbFHxQl1avXk6t03EGGta6WyU7Tci5F1dGmwxJn9mdpUsxOyTNQdbwL4TZ71GuQ9ElH4VHtPKZT/pnPYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7500

On Tue, Nov 11, 2025 at 06:00:55PM +0800, Wei Fang wrote:
> The struct fec_enet_priv_txrx_info has three members: offset, page and
> skb. The offset is only initialized in the driver and is not used, and

the skb is never initialized and used in the driver. The both will not
be used in the future, Therefore, replace struct fec_enet_priv_txrx_info
directly with struct page.

> we can see that it likely will not be used in the future. The skb is
> never initialized and used in the driver. Therefore, struct
> fec_enet_priv_txrx_info can be directly replaced by struct page.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec.h      |  8 +-------
>  drivers/net/ethernet/freescale/fec_main.c | 11 +++++------
>  2 files changed, 6 insertions(+), 13 deletions(-)
>
...
>
> @@ -1834,7 +1833,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		ndev->stats.rx_bytes += pkt_len;
>
>  		index = fec_enet_get_bd_index(bdp, &rxq->bd);
> -		page = rxq->rx_skb_info[index].page;
> +		page = rxq->rx_buf[index];
>  		cbd_bufaddr = bdp->cbd_bufaddr;
>  		if (fec_enet_update_cbd(rxq, bdp, index)) {
>  			ndev->stats.rx_dropped++;
> @@ -3309,7 +3308,8 @@ static void fec_enet_free_buffers(struct net_device *ndev)
>  	for (q = 0; q < fep->num_rx_queues; q++) {
>  		rxq = fep->rx_queue[q];
>  		for (i = 0; i < rxq->bd.ring_size; i++)
> -			page_pool_put_full_page(rxq->page_pool, rxq->rx_skb_info[i].page, false);
> +			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
> +						false);

move to previous line.

Frank
>
>  		for (i = 0; i < XDP_STATS_TOTAL; i++)
>  			rxq->stats[i] = 0;
> @@ -3443,8 +3443,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
>  		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
>  		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
>
> -		rxq->rx_skb_info[i].page = page;
> -		rxq->rx_skb_info[i].offset = FEC_ENET_XDP_HEADROOM;
> +		rxq->rx_buf[i] = page;
>  		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
>
>  		if (fep->bufdesc_ex) {
> --
> 2.34.1
>

