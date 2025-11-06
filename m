Return-Path: <netdev+bounces-236450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2032C3C6B8
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6750318C0A6C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E39350D66;
	Thu,  6 Nov 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="beBJpPcd"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0F33EAFE;
	Thu,  6 Nov 2025 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445994; cv=fail; b=feryThkZyImjl9Va/M5UyTkmgitMrYMnLgr1NLF18WxBbJqMxpeQbVb5IURDUYOZIcv+Uj5z2gCM/+vhGKuTGH+NHP5PcVy0kUxWbg66AYafNy8lpwO2vkGwgtHt4Qk9Sew3fbA6uwfBHfKBQiIGrEx+6KKXiYFuonCoXmiypnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445994; c=relaxed/simple;
	bh=BWWjXLIw8IjXnC0jR1ESlYuWDHMXoEeVx/r+bbd2MBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VI2IqCge0ZAvO8boH4IM9+pGRMY9doahu3iWxFYUM44pzbTPia7xu38ihwVlYsDHYEJUeGgrldOdjNzxvNhVVcxtMVbMDz+AhTJDcnhsdzS3o/v+V8y6bJEYmcAQG5ZAFmb0H0OgGm9sTdty5uyPgUyzMoheI7x1t3NRfJBXch0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=beBJpPcd; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amlFEwqpORbqh5WtAXgl6WNApLBUyexy9NYgeuNExYFvT1yUBsX9q0GjZPE1TuTtr4hz6BLMZLFUxAkvR5AHQWcw6GQisPQA8RYxrKtp2uzEaWktPi+oB5A/rjt2vLxeSsaRAYdXoRNdcuvvDHoSixk6bXkSbkJKrHiQ6CWCgJjB2PvhTDeoGR7Vm/CW5ryFDApKEqys2iekcf31utyyxUI3LuK1jn59GBCZcNbmh69m3KUWYJmEBBM30FTZo4MqNRzTRXt5XqS46axlWdK/tFJry9gi7LT1SIOdJa6aw1Yx1nhYcgAlBTZCFI5/5RoHz4gHQiZbBbOzKJKcvenuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tj4+9JEk2yNL/uzRyhyBcqlPfojbRHbHg4IfzEvnp6A=;
 b=R4mKXXCLa+WB5B2/PrNCJrUL4kfyOxzi23Hgnkd2B7abiijn7DoeH3J85ABuVN1n4J8Eny/VTCo7b1N6x7jH+F7tDrmpYFRjweSsR9IwBwzIOz7Ops6UrVmAFQPAUOSM/BTY5ctn+/ldX5RxYY3eyhb9gtZ+NYViuH0oDOBtn0f/ZTgnAoLZ1Im66qb9AeVjzjmBVdyJRkV8GbxzqC1CFU1+CjQfX4qozeHJqpp0btC8Z5Z43dsBgM1qsgMbtjHBsEAM0Rdo0iDQQKQXS0Jv6+4nULVmuyqjBWQxsOLyLK5cN7MPUDhvAz+ySXk2sNtYcolt5ZixM/urfKE6IGCQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj4+9JEk2yNL/uzRyhyBcqlPfojbRHbHg4IfzEvnp6A=;
 b=beBJpPcdlx9x3e72R3FBTwpR5+YCO8BD23Cv5GcX5F3tz/nOng/GuGD2Qr/t2ouZCG/1yfDVW+6XX7BJKJmgJPEwG6xyRE3KMTCJi9SgaELzepjjt7L0Mg035p3QbNQxs178ePipXvgGjLw2dn2aHz+1WdAHjHgxDiiZ3a2v1E1wxv6qgwWEvwYElPWtQeMDh8sNX1I/5CnzPcyoPXbgKi5bq6KZUAlyKTsv5ZAe7tU/lWGmbCz3WTpav2xet6BIbEx+Cx9hXrYMM/5ojibibJJSZ3SATgSnLwQj51rq2a235nUIoFPWHymNZ9FkgBKuQMXTIw71ulqu97OUG2qMSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB9145.eurprd04.prod.outlook.com (2603:10a6:10:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 16:19:26 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 16:19:26 +0000
Date: Thu, 6 Nov 2025 11:19:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eric@nelint.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: fec: correct rx_bytes statistic for the case
 SHIFT16 is set
Message-ID: <aQzKhRDA7gvYZ/FZ@lizhi-Precision-Tower-5810>
References: <20251106021421.2096585-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106021421.2096585-1-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:40::38) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f08056-80d5-452d-2b54-08de1d5040fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BtsbX9vHrXO+QU0BUMrZzGKITe0Jad51WcXi7N1+cjo5lGIv7pT8Typ/Mux2?=
 =?us-ascii?Q?xK6YB6kS4Mo4qM1W4kbJ9XX5byKtNI9oaU3HfkJ8bgH/HSGa7kkTTJUzfism?=
 =?us-ascii?Q?qswyX3AEf7iHWQJbsgOtjK9xFyAPteXQgu6/29Gg3JrG/VCwcNo27srrG1Y5?=
 =?us-ascii?Q?ZvG4B/r8ovQGbwV6QoS7Xp/lQQkGndCE28f4LEep0g9eywjEAeZIdXNiGwDi?=
 =?us-ascii?Q?g2RWEaWIba7+Yus0iuGE74aX5UsOwHs9gjL9jJIG7Jer4bXK3FYQEVDY6Doa?=
 =?us-ascii?Q?pyS3c9fJ2mydaMwDG87cctrU/FPXe9t17XQDMuRYyNxVCqdC6E9P3DC4eqli?=
 =?us-ascii?Q?jT/dMYyyhnLs5Zl0vu+SxOHOMfmKp7SAkpuyscpPiqdY4+ldnXtyCezVNDrz?=
 =?us-ascii?Q?qoCLLi16mbJxbRhuFUKK+w/tmqep4HkRAqyzcZ9QPZyB/2EktHp6X3jtdPOl?=
 =?us-ascii?Q?OxapLH8WRDNXg3BJjmEg2tQnaOibCGNU682kJNBzcbJNKwTsjhwdSkZn0YxN?=
 =?us-ascii?Q?lGHmzcAH10G/JBFLLeI1F+aKBoxh7JiHDT6hWcD2gFx8POY9gUdLo6W8sMB5?=
 =?us-ascii?Q?jpFj4Dk5ERR5GQ9o0GR+Ue/BWVlzf0lLjgA2s10ntSEswqEMGfUcRARQ0sF8?=
 =?us-ascii?Q?H5ebscTgutoF1LUlgVGQzg2y0OpO1KyUQVBx9G5lhwVYkK+jOQgQmBC+1Dh2?=
 =?us-ascii?Q?nk2Emm8P0MCP16sS8D3gxe+41FcZCdvUdbcGSUO+w+WmvFklS7fk2LLT+KQb?=
 =?us-ascii?Q?13GJ2heu6uRdyx4cDbj+Tf6FriD400i95PYgYBDgJQfGtq/cB75s1gTsnUhx?=
 =?us-ascii?Q?ixmBoiKtkhjsZ3VfxdWiGRzwzG/lOcgP8jyfgeJtzPOe2cz/OnfD9FtSPQvI?=
 =?us-ascii?Q?UIVEOoScbdlroO01WzaAXWNDcosdgZ32ONvmthBPZaLu3KGmKQGX/hs5MVV1?=
 =?us-ascii?Q?ZYQftE6ZGaNMbb+T+sp9NQzO1RBsRBFfYeHPxyDofQewK6poCwAM5AqKYDd4?=
 =?us-ascii?Q?7GMZxoYWiX1A2th0dOiyDhHfyM1xB+ZbdFTMR9yn616e2S9/2+aXyIH8sIeR?=
 =?us-ascii?Q?fBAqbyVvEzK7JbicqDD8NCXTmRZnsmrt7lnU/mxhVKJT0rKCJwTpm8woO+Sh?=
 =?us-ascii?Q?BD3ICpyzNLXE+DLUUWI5ROsg77ErNOjbW/SMNuBCtHXHTyBVaZ6o6PJ/A2eo?=
 =?us-ascii?Q?mJNGvAqcxMhOPjoKdtE5YuSceqZnicvb8hwqYDSp3Puj5W05/t6FGqBRX9co?=
 =?us-ascii?Q?USzWDMICgIJ0BE8E7KRfYxOwlqrBXuv800IMBZvTpwxUFUL4kKeu6+ka5K6b?=
 =?us-ascii?Q?ireVSK5EWjU1zfrmllbrCAE1w6w1gySpwod3NropjIobV8qvvSlSTUNPPUl+?=
 =?us-ascii?Q?yhinVERJyGQXJdCpUpcTOsuanzQxe9AoZo8Yf+NwmcF5e3Sd4P9lyV9qE3NG?=
 =?us-ascii?Q?k43zqfc4GN+YSkjcBIggABL1LvCJfjEOI1/DUapu/ydR0wuQDWC+j6b+XBo3?=
 =?us-ascii?Q?gkGAzioIjpYuEHELCneBc6dxshZTrZq+pIIL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P/CKs4jbcasxADZCN9g4QsCIMjjxpytlWJ5V/9H2F15tx0mowj7wT95yOFPQ?=
 =?us-ascii?Q?HCTouWQntbiRP6/NJxcDgoL12Rwj4fyIbWgxGEZZLxe6C7+960HrSMMDqKbG?=
 =?us-ascii?Q?zAQFkO9zjeIIqwdhsrYcqkAvwVjGzLqvwjue9/W6mOULGTd+a7zeU08V94K0?=
 =?us-ascii?Q?FVm9Yxa7NqTiZWScldWxN/yzsBl2nFmuVyS4wm+vOHe3A4V+HSC41rXnv+iH?=
 =?us-ascii?Q?ZtKLJOZUYD6V7zosKM6lBMtmyLj9Fy9gYdAscAVQH6jcPgKC1Hl+KRiw8izp?=
 =?us-ascii?Q?hNSbF4NbFkXFa3Z2AYpiXtDuQ9UjBGd9m0sfJrlQiJ3syFafmbafYU1QY/j4?=
 =?us-ascii?Q?ns1ZtjNB3glAjf2VzO45Z4V3F+trefjfFwqhKTnfVebdbxfh9Daeb9bHRuKj?=
 =?us-ascii?Q?P8WzJyPjNXrcXzj0EduJZa6ShFVQ3accdYtvuFCOld+fcqJeVCeHzVX4gF5v?=
 =?us-ascii?Q?y+KsaXFoSjvuw2+rI+jqzsWRO9IGoFC9sYMdA33oowyiJ1DBNJolX6ope9+A?=
 =?us-ascii?Q?yTdruivrkbVBbS+KJHzqvy/tpy5JcCzcZ9twQ11hQ3M+7s5Xom0lwxVDpQez?=
 =?us-ascii?Q?ZE+zL3NZcEb2bm1/fJba8iMIivm7G7ki0CfKlSKLtHJKyMFs0Gr+Fi1zjYXS?=
 =?us-ascii?Q?1SLVdCObtH7jZcmcmvM4ZBOKg/EjpFhJbhgS+AwP4Q9CfTvm4ladySZc6yIa?=
 =?us-ascii?Q?b27imauLbfdWegyHfu4d876O7c9e0DkKClnKGIH6TuGLQsCTyw6pKSQpeGIr?=
 =?us-ascii?Q?Q/eRxEry0Ce3UpWB0WKcK9ZsmVfu9FFcMIUFHz1oLu0X00XQee0nbYSzNrKa?=
 =?us-ascii?Q?BMSjtpRz509ZT4PKifmo8TyW4xfPuykYR7mZiIkRsn7a/sUO1LqEqbDQPP6S?=
 =?us-ascii?Q?rrBMBSgapeshciM8HPO9L5KHybyRGh8DhIpwrJXyFmDMEOIc+JEHf0ZC+Wls?=
 =?us-ascii?Q?XNm3fIYrx4TCGyHTEZQ6fzGGIWfevFjVzE4Vj96VWgVseNsqqeM4sdzBfFDz?=
 =?us-ascii?Q?JSyIv6iAmXmgc3SnLJi0fUMka7ZEGdIkRUM75gNRcc+jaMzMCmlI29LWfWl/?=
 =?us-ascii?Q?x3lBmdZTvtw8MmRINzWgWM40IZiPF4hDBvOHlDKM++pLNMlmFzd8Oyg3wxvP?=
 =?us-ascii?Q?++Corqd71WqMJ1Zp3EXuTBfYqxllHDSElS/DI1CMqukwOlUjzC4Id9CzyGRZ?=
 =?us-ascii?Q?65GLzG5LcoXLfcbfwQFvmW45J6SAd3L01k2my8GnL2dvFz70E4aj8l+qOI/a?=
 =?us-ascii?Q?7K2mhIgg9GDWTxEqo6+imTCyJR0FpiINV4yHC0fTAP+cjIocnfW5KU2s2d5x?=
 =?us-ascii?Q?Jtxf9c0yNo0Vdu2/Yj2IH6oXFCqj0Haxff1MDMZyZpYPJESZNBwPtXF7qkxu?=
 =?us-ascii?Q?bMSIXN8aJyq2DN0RVF+jm8aiEm0iMW7uEv5gPXG+Sv4JTWCJ2JKcyr9mjhrU?=
 =?us-ascii?Q?3AAPhrQARkx34mMYVGT0hxpp5aYzng/+5zFGYvPyKAWtSV32oogjQEpb9EZt?=
 =?us-ascii?Q?2RTHo5rzIcWapFTlQRB8fTeZLUqGKwpghum3YexLrDypVfPiWkNKpK2II3g7?=
 =?us-ascii?Q?UZqpow+PmtYqY2zdr+/Bjvbe77w46fZTya5Baqj7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f08056-80d5-452d-2b54-08de1d5040fb
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:19:25.9415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXeq7CalY5LK3HdIU5HbJMZIUVxf3loLqYU49EP8RnaKJ91pgUmjkxK/oycp8b+Vd3rd+DuuDFpHPXZ0O6z2sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9145

On Thu, Nov 06, 2025 at 10:14:21AM +0800, Wei Fang wrote:
> Two additional bytes in front of each frame received into the RX FIFO if
> SHIFT16 is set, so we need to subtract the extra two bytes from pkt_len
> to correct the statistic of rx_bytes.
>
> Fixes: 3ac72b7b63d5 ("net: fec: align IP header in hardware")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/net/ethernet/freescale/fec_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 1edcfaee6819..3222359ac15b 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1835,6 +1835,8 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
>  		ndev->stats.rx_packets++;
>  		pkt_len = fec16_to_cpu(bdp->cbd_datlen);
>  		ndev->stats.rx_bytes += pkt_len;
> +		if (fep->quirks & FEC_QUIRK_HAS_RACC)
> +			ndev->stats.rx_bytes -= 2;
>
>  		index = fec_enet_get_bd_index(bdp, &rxq->bd);
>  		page = rxq->rx_skb_info[index].page;
> --
> 2.34.1
>

