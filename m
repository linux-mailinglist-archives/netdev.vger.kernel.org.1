Return-Path: <netdev+bounces-142945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AB49C0BB8
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E89D1F22F3A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2367215F7E;
	Thu,  7 Nov 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bzG+zb/x"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF0212D22;
	Thu,  7 Nov 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997127; cv=fail; b=a88NQO7XcGE9eWF8USqq4NDtfhNbKLjDbTAc8xBIiqoVH9jK+wEHONZeZIgXqEslsT8gDd8NEXkw+Q0o8YU9wD9CdEUh+MEw6buHSuBeyjtkAbZHjWCA5AyelFAHh7qilxTJImIku2nLwftiZobnRtiLlYfQX2EMavzJ7J2IKk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997127; c=relaxed/simple;
	bh=v7lNGBfPqSxNbl3kreRZHM15AI2Ms6ojiyBY2ydb5EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t/RVsLKfz+qj20MeOQz/nv8SC9ds01QEMBw5CBqyz2QobnmAjsz1tRGA6fALoSYxNw55cdaPi0z8pZvXmnQvPJiKXZSjpP9V65DcDoyReum++ocUnolYEkNa+i5ajF6kRU6V1wkvc01tEVtzR7oMMwhpbfrmmiSQdUFiNlewobA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bzG+zb/x; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZLOGDsJrq4guNQkIdpIO7Gsiyj87ijG6X/sXBYlWULWQn1G4GjNVAFHb1LKpheJgCK8fBa/hB/eHvtYmXKk9I3vRRmUSy2fGgcMFAcxJvFBoEI1Kp1yU0djriTNCPrZZqATORd08BVxUgLI1J1KRIPrCWS2Qjq19OgDDDT2epV5uCOWY7lZHSQvEAxcl4Zz4taJv5H4U9kjAFARIo62ik4WQs9gzgOC9owmVunOR04OdMMNKirRt/+wfkBfluBphgbjLj9bgU1V3nLArBHHtanoV7HIBnyLxGqUvfB/xh8IS1zRZEegZIyFkgplUBC4IB2s7jVmDXTGn+vxXD6oDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IqUIIqPeXQNGNNmO1H6s1Tu7zOFgVm1BB+LLXpf3yg=;
 b=nj3ekDgG5pp9fxWV5rILr9GoVXATItrq/YzB2kOJi7Nhq3zPye/asSihswq2RRp35xS48sG3BCrso9j+5v245wnhaZSQ7TOibKG+SzwYJxR5yn6TYf+TqUlC4AVzSy3CpPmlOHxC7C+8vuTi2RjW7NLENPVlrwwxba+UYkIxnQjWab0C8mGlXEXvFKi2zuIQOSnS8IQyg0gFiNjvHFTNuOZPcNw69/E7aERyMIM4pqNjjEJpkjt1bX5VHtae9+WfjBMcv0keWj1oFIYHDOyKu228/EXNNVYB+QcDMzq8aiUr5Oqmc702fZaoFRlonc+MwFpx5m/Ja6Hc9wjS1MQX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IqUIIqPeXQNGNNmO1H6s1Tu7zOFgVm1BB+LLXpf3yg=;
 b=bzG+zb/xiSXgDMP8mmGdDe4F8Ewo1Nf43NvcqMUKdJrX/d+lcmP5a27d/XuwF2/DTl0Ib3Jgw2QJN06BuMo6lb9vyJ5EYJuHxk2J/9GWThLFTplbwiHAv6P4urhI0LbbfnbT9B+9qLC/zwXWjp3L39F7XTLOprc0TAXsNQjd3zPOoGDXCEBRN9gL5Qcpk5+HzJg7GEM3TOO506LDe/jz/TAx2aMQAxamlhnTkfFfr3+MfNECcArtFb52boVWfLhhVSoJcGCwykR0W93SENarjBYcaDbbA1wWwa9y6ddCuVQsymTcbx5K4wk3IZfz8xAUI/qm+YSdLfiSu44JibY1cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8807.eurprd04.prod.outlook.com (2603:10a6:10:2e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 16:32:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:32:01 +0000
Date: Thu, 7 Nov 2024 11:31:53 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 3/5] net: enetc: update max chained Tx BD number
 for i.MX95 ENETC
Message-ID: <ZyzreUeh9PddNBY/@lizhi-Precision-Tower-5810>
References: <20241107033817.1654163-1-wei.fang@nxp.com>
 <20241107033817.1654163-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107033817.1654163-4-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f659d6e-cb3b-4511-bc46-08dcff49b4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Kt86tz8qTNtrrbCNNeuTJMg971ZDzykBtDeQx/0XDIXKex0O2QE972alRth?=
 =?us-ascii?Q?+pDR1gMP2J3qj9NZEr0SKCShYV+tasdv5oI0ezzjzCOxTEW/lmseapMjWpzc?=
 =?us-ascii?Q?L8J31cejA/XEAVvoiv3+MF/BGvB3NgRdi1vX9W5AdAnuctY6+6ipZXFkf+nS?=
 =?us-ascii?Q?TxYWNqjK530VGoDRBuzqsZ4/QQa9hRDv0gkXX6t6gP+oCToV1iCk7GvnoSX7?=
 =?us-ascii?Q?IN376lmbyStxWiuQT7If6H3qsmnah63bJU8XB4TYmzhM+W0VY9YPgGvQQM0J?=
 =?us-ascii?Q?2xFIzuAxtlvASHK1bdlPyDlBvfyIVaJR3I2EP1O0ivxbQ0NLdweX5bM+Qqie?=
 =?us-ascii?Q?mvLCZaqMymmoZ6Y+O6Opj4rdJXRVNK735LkmIdYE/2qE2s8kK5fYceVUD7+k?=
 =?us-ascii?Q?Pf5ThdnH8uHgXDcTuRcpr5gO+Oxm/G8MDjQEVqubjZhQ83q7N8wdQQQCSiEa?=
 =?us-ascii?Q?5OlL4QaRUKNX8NiFNJ0fGzeXUM/Kl4wiFtCF6AictKX5VJ6k8ajQQXzT3FEH?=
 =?us-ascii?Q?1M7dtub6zj2Dd62W3Sqck5uyge/4BdK/vqHNzMXN5zZZruRfOlPw9xI+L+PQ?=
 =?us-ascii?Q?mS/dkQ2AKc+NoCRgylHs4KuVO0Sdsxhct8bIREQ+kv3IkPXfm0vFaZA1qqj8?=
 =?us-ascii?Q?rhpC5JYGOJDM8VrnqiM1tnjLA27f4wpNRdj13QlDJ0xcYn4dMavQFBsGJfPg?=
 =?us-ascii?Q?SFStqIHBBdA9brKawAFz9pfFArpvYToc+fwFmYmgjl0VuJJTXXFouQw55wPZ?=
 =?us-ascii?Q?sySreE7hzKX2YiwcnHV1ieBr2+yHF7L5mwxKBviUDgMfUth95x/zoCAjsv4h?=
 =?us-ascii?Q?2cwSvyjfLaYWt2ouAN5nK3h7Llz5fYh/vvFu+rhxhBXdm6PjERcMfEiBmsh0?=
 =?us-ascii?Q?R11cbV5UtKZwHL1S7N2auO/29XBzJtPybOMFIOKtLvsREbjt8ascX0P5Nh2g?=
 =?us-ascii?Q?LgP25Nii6Z6LiowhE1+PaBYCHbSOlJ8Ytz8ZU3yrEd4f1/SwWC4MGIHCOEDu?=
 =?us-ascii?Q?g5xDTTQwHrQ5iD5Br1gKTnGLTdTFkGOfWLO3CkqewmmQ5WFQ/+9d3S9163JB?=
 =?us-ascii?Q?AW/aheH16aIIYdGZRCt+w6019uZ30d+xZcJcu/l7475zQwgMEuOQsh9rlelr?=
 =?us-ascii?Q?BPSXgGzklfAsn7pKX9iLpt4b9tfUm+DBK+/PJOy5+Ei6U+4tnVJ2suvaAt+z?=
 =?us-ascii?Q?FgCGnN7HYX1WoEj0a+wRI1qQiieOtmWFxXI7vp8IAQSqP3K2+0TiYctQJEWU?=
 =?us-ascii?Q?A1twXQlXH+zBPaLM+wxZYnA9vT9wg+f/AfuvUXCqhSE9hx2XXiiCu/YtJwrk?=
 =?us-ascii?Q?D77A34fyrOmc2+7C4SQEZViy0UQ0erUtbHe+Fnn6UQ2rX0Ou/uR0XLimBuJS?=
 =?us-ascii?Q?IjqupeI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQWpchqufDKFpBxMpjUOntaJ2jzr8XNhybAraMw/MSvUPoTPFxj2MyO1auJm?=
 =?us-ascii?Q?1+iHpf6wz5SlYrzz+OcSSoylbLRfLNbtShac/gEWGzWpTE8KN7qmvF9n0nXU?=
 =?us-ascii?Q?2nvy+hJNfU5QTRUPcXGOkc0b8Kml0M3EvMtR6+7eH43KHJ/UZnIWVkQ1c3hm?=
 =?us-ascii?Q?Cs/EJJ/TU2W5mrP2DrOpS4tmK31YUMQBReBSB5cnAWzsiwV8JHzQoF2py9T1?=
 =?us-ascii?Q?AwnRnBMgdm6H2/WHg3UwZzuESNbFVM9O61qfZ67Fi4cUgudD/naTFyiOXa2C?=
 =?us-ascii?Q?fxeyHs/fztAo12RVutsWw9EFO68WzKfm9HaB5JkjTvqEcz39ZoWB4NmW1lR4?=
 =?us-ascii?Q?p26iXumblL8MzrosZV0ZieifYzyhdknDwZPAdEvhDl8REo47r7ts28Bfy7Ey?=
 =?us-ascii?Q?7ALRce7dtjQ9h1ioUQYYMvRef71WVPU68FxkWrCxn5fMZUw9YRBuuuHakKdM?=
 =?us-ascii?Q?hmrvjcOpEDu2z5zdni8ObTJTSFlDPkhrTD0Vo9LUE5xQe+zMCIMa/pf86Xof?=
 =?us-ascii?Q?IWZTg9c7auGCs9OY3Fk5jL3X50vWQi3dMTO+9zjeOIfNDsTVfqNREGjV60V3?=
 =?us-ascii?Q?sSYx5Sxb/CSmble0paNTGNLRN2RBZDM4exSIkb52Se4ZLpL7wrovUtHs6gGg?=
 =?us-ascii?Q?CaB5uLqrxaSz3gkc+9mnrkkYycbPR13TNucXhg/wG7ztbz7320RLKSKvU5GW?=
 =?us-ascii?Q?P8XH+gbjhDqiwp8IiSkXWgpnaQXTSGGmaXymy2p/XW0Z8rngBpznooZ/qMSb?=
 =?us-ascii?Q?V1UBZAnUJAX31TBSyZsSiH/AhQQdI2cYobIvbZUJOH7KoxeH/Y0CaCq+MU8F?=
 =?us-ascii?Q?ipWr7kakKPAHrlNFMJYVgFWzY2OfMkaLUEzv2W+clbGHIiOlpfKEcj19HvkR?=
 =?us-ascii?Q?hEenMNx0fAbARVlprNba+5hUXMd1vdM1JohriM7X2BmrZENGm1yRXwosiyg4?=
 =?us-ascii?Q?JC+5Rk/mwdSsgFbChtMB9UXaDZXsUeovS4aijQg+XCFeP0qmZ8BLKfuXtEkj?=
 =?us-ascii?Q?KTnVSAVDjX56PyM3xHOngND2Qze1nroEFqt0TUIgZRb6TkpABvp5/ZWj+ter?=
 =?us-ascii?Q?Wgv8DGSK6LIpg+3X1nrGDdTtoVt3fJx58rCbSB7pQKocv7jApjdq26F6PrLL?=
 =?us-ascii?Q?drjjJfvEXS9aFnA5tmBhJ/0epblUaVNxw8vlb5LYHBgT75fxyqDPnOcybLtg?=
 =?us-ascii?Q?wUEu7Ygg80lEIeMRomsfrw5DJeUsB2wGgCQ3spsq66fyOQKLSa9sc1SkNxnt?=
 =?us-ascii?Q?PsaRpsxhM2IknGyhG97oMR3mabdrenxTsGQBWIuvjoi7mmS9mqZsZ8A3aNXv?=
 =?us-ascii?Q?Q3HZhUAh5gU6akoxPcYacrLfJtA8PhF64uKVrCoW5grDoRN3evb1zfEUcfvi?=
 =?us-ascii?Q?n+4wsLxdZdKagm7RpR7B0QHRxnDVmOuf+1eXHmfvwR8zQh0UF0Fc5o8FYfhs?=
 =?us-ascii?Q?YEbTYGVYVPOanFw9A8RPlWKbYkS1PsilWiT8bqyqBVYQuQUPdEB+ZHbd6gV5?=
 =?us-ascii?Q?l2coYm0o3O6mc6oXLIaTL0DDvVH0RbDWNX8Ad2qWIr0D7ZqxIMFeb2xGJfO1?=
 =?us-ascii?Q?GL79RzwvT74Xv6o8edXpsOS3KrG72fxUsc2zjhsu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f659d6e-cb3b-4511-bc46-08dcff49b4e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:32:01.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gmQyDsDMjXVJRaoH6/EcIYiWvUYzT3PN1K7U01WjqxiU4j8UnzoiT6SJfytxCtU4LMes9xMEVt/snXh1F65rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8807

On Thu, Nov 07, 2024 at 11:38:15AM +0800, Wei Fang wrote:
> The max chained Tx BDs of latest ENETC (i.MX95 ENETC, rev 4.1) has been
> increased to 63, but since the range of MAX_SKB_FRAGS is 17~45, so for
> i.MX95 ENETC and later revision, it is better to set ENETC4_MAX_SKB_FRAGS
> to MAX_SKB_FRAGS.

Add empty line here

> Because the maximum number of chained BDs supported by LS1028A and i.MX95
> ENETC is different, so add max_frags to struct enetc_drvdata to indicate
> the maximum chained BDs supported by device.

Add ... because ...

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c        | 13 +++++++++----
>  drivers/net/ethernet/freescale/enetc/enetc.h        | 13 +++++++++++--
>  .../net/ethernet/freescale/enetc/enetc_pf_common.c  |  1 +
>  drivers/net/ethernet/freescale/enetc/enetc_vf.c     |  1 +
>  4 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index f98d14841838..b294ca4c2885 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -530,6 +530,7 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
>
>  static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  {
> +	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
>  	int hdr_len, total_len, data_len;
>  	struct enetc_tx_swbd *tx_swbd;
>  	union enetc_tx_bd *txbd;
> @@ -595,7 +596,7 @@ static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb
>  			bd_data_num++;
>  			tso_build_data(skb, &tso, size);
>
> -			if (unlikely(bd_data_num >= ENETC_MAX_SKB_FRAGS && data_len))
> +			if (unlikely(bd_data_num >= priv->max_frags && data_len))
>  				goto err_chained_bd;
>  		}
>
> @@ -656,7 +657,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  		count = enetc_map_tx_tso_buffs(tx_ring, skb);
>  		enetc_unlock_mdio();
>  	} else {
> -		if (unlikely(skb_shinfo(skb)->nr_frags > ENETC_MAX_SKB_FRAGS))
> +		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
>  			if (unlikely(skb_linearize(skb)))
>  				goto drop_packet_err;
>
> @@ -674,7 +675,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
>  	if (unlikely(!count))
>  		goto drop_packet_err;
>
> -	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED)
> +	if (enetc_bd_unused(tx_ring) < ENETC_TXBDS_MAX_NEEDED(priv->max_frags))
>  		netif_stop_subqueue(ndev, tx_ring->index);
>
>  	return NETDEV_TX_OK;
> @@ -942,7 +943,8 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
>  	if (unlikely(tx_frm_cnt && netif_carrier_ok(ndev) &&
>  		     __netif_subqueue_stopped(ndev, tx_ring->index) &&
>  		     !test_bit(ENETC_TX_DOWN, &priv->flags) &&
> -		     (enetc_bd_unused(tx_ring) >= ENETC_TXBDS_MAX_NEEDED))) {
> +		     (enetc_bd_unused(tx_ring) >=
> +		      ENETC_TXBDS_MAX_NEEDED(priv->max_frags)))) {
>  		netif_wake_subqueue(ndev, tx_ring->index);
>  	}
>
> @@ -3317,6 +3319,7 @@ EXPORT_SYMBOL_GPL(enetc_pci_remove);
>  static const struct enetc_drvdata enetc_pf_data = {
>  	.sysclk_freq = ENETC_CLK_400M,
>  	.pmac_offset = ENETC_PMAC_OFFSET,
> +	.max_frags = ENETC_MAX_SKB_FRAGS,
>  	.eth_ops = &enetc_pf_ethtool_ops,
>  };
>
> @@ -3325,11 +3328,13 @@ static const struct enetc_drvdata enetc4_pf_data = {
>  	.pmac_offset = ENETC4_PMAC_OFFSET,
>  	.rx_csum = 1,
>  	.tx_csum = 1,
> +	.max_frags = ENETC4_MAX_SKB_FRAGS,
>  	.eth_ops = &enetc4_pf_ethtool_ops,
>  };
>
>  static const struct enetc_drvdata enetc_vf_data = {
>  	.sysclk_freq = ENETC_CLK_400M,
> +	.max_frags = ENETC_MAX_SKB_FRAGS,
>  	.eth_ops = &enetc_vf_ethtool_ops,
>  };
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index ee11ff97e9ed..a78af4f624e0 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -59,9 +59,16 @@ struct enetc_rx_swbd {
>
>  /* ENETC overhead: optional extension BD + 1 BD gap */
>  #define ENETC_TXBDS_NEEDED(val)	((val) + 2)
> -/* max # of chained Tx BDs is 15, including head and extension BD */
> +/* For LS1028A, max # of chained Tx BDs is 15, including head and
> + * extension BD.
> + */
>  #define ENETC_MAX_SKB_FRAGS	13
> -#define ENETC_TXBDS_MAX_NEEDED	ENETC_TXBDS_NEEDED(ENETC_MAX_SKB_FRAGS + 1)
> +/* For ENETC v4 and later versions, max # of chained Tx BDs is 63,
> + * including head and extension BD, but the range of MAX_SKB_FRAGS
> + * is 17 ~ 45, so set ENETC4_MAX_SKB_FRAGS to MAX_SKB_FRAGS.
> + */
> +#define ENETC4_MAX_SKB_FRAGS		MAX_SKB_FRAGS
> +#define ENETC_TXBDS_MAX_NEEDED(x)	ENETC_TXBDS_NEEDED((x) + 1)
>
>  struct enetc_ring_stats {
>  	unsigned int packets;
> @@ -236,6 +243,7 @@ struct enetc_drvdata {
>  	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
>  	u8 rx_csum:1;
>  	u8 tx_csum:1;
> +	u8 max_frags;
>  	u64 sysclk_freq;
>  	const struct ethtool_ops *eth_ops;
>  };
> @@ -379,6 +387,7 @@ struct enetc_ndev_priv {
>  	u16 msg_enable;
>
>  	u8 preemptible_tcs;
> +	u8 max_frags; /* The maximum number of BDs for fragments */
>
>  	enum enetc_active_offloads active_offloads;
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index 3a8a5b6d8c26..2c4c6af672e7 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -101,6 +101,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>
>  	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
>  	priv->sysclk_freq = si->drvdata->sysclk_freq;
> +	priv->max_frags = si->drvdata->max_frags;
>  	ndev->netdev_ops = ndev_ops;
>  	enetc_set_ethtool_ops(ndev);
>  	ndev->watchdog_timeo = 5 * HZ;
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> index 31e630638090..052833acd220 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> @@ -129,6 +129,7 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>
>  	priv->msg_enable = (NETIF_MSG_IFUP << 1) - 1;
>  	priv->sysclk_freq = si->drvdata->sysclk_freq;
> +	priv->max_frags = si->drvdata->max_frags;
>  	ndev->netdev_ops = ndev_ops;
>  	enetc_set_ethtool_ops(ndev);
>  	ndev->watchdog_timeo = 5 * HZ;
> --
> 2.34.1
>

