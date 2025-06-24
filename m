Return-Path: <netdev+bounces-200778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6564AAE6D29
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 19:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93EC1BC05DE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187121E5219;
	Tue, 24 Jun 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WK7RphHl"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011025.outbound.protection.outlook.com [52.101.70.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC37DA73;
	Tue, 24 Jun 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784448; cv=fail; b=nngUcXoEB7U70G3PrqP3f5xN++XgMJZbQZ1U/RqIGq5jZ0F1Wld54xQZGq2qh5Ci0qXQ5oj8k7BQz7f6HWeCf6h35tTRXo9eQM3eju3DWzPRHHN61JLB9+l7r+4GWkFcy8ZlUdQxo6j9ZKiaDdIiarebVrLJN4LUXsKYPUGYzEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784448; c=relaxed/simple;
	bh=NlilB4T3NBwzIHKF/Y4DQpoZMA7fy8HHFJHxwtKTrKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q8mR0bMearASS71QSbZnyv0FK9os6uzoXMTyOZOUQ3212LHUl7eZgg8TVrvLagmCFUmDAEfT9rXxg92kpoHjonRUCIVaI4xNpCNHiQTluNi9IfYNiQQjmPS/j3ufziVKfQGR5IfmnZVW+ja0w/VeedcB/AprkIyZ00krEbagsDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WK7RphHl; arc=fail smtp.client-ip=52.101.70.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9OuhAI7cDanL/TtWEm0PUwjOzBBdd6jg4DFwEFjkFAZQnSLSxfQFL0XlsJ0OHK1jTdV6viw7T0y4/pYiepAZVep5Vq2ceOcYNWl7SPkoyZLoamMJPP3bATtBgOMNXWQQxThxTGh5fgpWcDCkz5gNoG180TzIAP/MDfeb7DF5DKIO8AjkydxSMcMfz8z6Y1kUhhkrslqIA4NoZ2lraY+/q/TkvB3HV9RazZ3ogUocS6s9EEsfMkqJXHG8yldG/Bx0aUiT1hrwALeShvqy3SdRp9pKQuMMDqjc+oUUyZ3ZvDI2MBJ9RBnYt4Ysw+1FQjfnwTK4lhE9mjMPCtmVrRklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPMK6/WdonJq0AnMWu1bPLIs1nJFfgHDMi3PbJdNG1U=;
 b=c++gVspUwiNvS1GBPmMU5MKaIQIy75zWifvNe0bT2PsabYvJQmMqCAFac1CFRf0cyX4s6Xvexxl5EJeFxvlWZvybllErrhcs7nnkfUPZNxfLDx/HwnjUFHLtjFn+yE/KASv6DQHTbNMQSkfPwueVCWJPb3ibQ7NF4JvhPnM1Vt6maQtsNJk50sSR39qB6EMENcdJMrMY1l5aeN0FMolL8MB2BXyY2iZGNJcZU115Ne3vDp3mHdSY7oOG5WTOdLr2IpqPFJSyg9xi7drWjKvahrYU7OCcE8RPHW5AtU1ivafc+DoR505MGb9VAOJCYppAXSJmnfehlW46pYuvMQhDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPMK6/WdonJq0AnMWu1bPLIs1nJFfgHDMi3PbJdNG1U=;
 b=WK7RphHlO6MSc07+G1Yvq/Gt3wgAcIws+S9FBIQKzKsXHHdgu/sSh3vqrUPSyfG9TI2zyD2ubr0u8eo2LP0BRdzSa2tEPoPvH5ky5lFW1YOCaTzmMsD7Uvjl+GB816CaO4/YaEl2WxXmbYYgpCrHxSi/XtXs/dbhrycYxCOtyNf7V6qSE9xmuhbH45738xvxBWniGf8nmg7NEG/Regf3rHcgmJgGAU3X7d/SfLJxmKEgRL/ElFg3XpEZbJ7xOpH9gmAAd2zxueKj8lzrH0G2yfvfnOZmL1T8FXK/T7qIdeHCejsiKMReTdVV2qsz5hcTZ9BzajFCvnXAxxHcVqmDqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10710.eurprd04.prod.outlook.com (2603:10a6:800:260::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 17:00:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 17:00:40 +0000
Date: Tue, 24 Jun 2025 13:00:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 3/3] net: enetc: read 64-bit statistics from
 port MAC counters
Message-ID: <aFrZs17NpJM5SJBU@lizhi-Precision-Tower-5810>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
 <20250624101548.2669522-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624101548.2669522-4-wei.fang@nxp.com>
X-ClientProxiedBy: AM0PR10CA0122.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10710:EE_
X-MS-Office365-Filtering-Correlation-Id: 71240fc6-c839-4911-638d-08ddb340a620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lme3PqTqhNQrKllxNLn0EWeETnFBz2UvUKnnUFBWEwMBN1R/+E5RB3+5rUAy?=
 =?us-ascii?Q?3ce4fWz7f6sfj/A94U7/QzDO3sdBf/vPx4QxFw+6w1wRzjMrzpmaaZDEHaFj?=
 =?us-ascii?Q?yeFQZgvhhFh7RLxL5dAd+sXnB91bl4Dzr3c5IWTdxR28JJkOjBzHt+K5+ylw?=
 =?us-ascii?Q?8SB1uaUk2GoK917yslqsYxIHJmTn/U+kyKldD0fpVnatGBg68pp/KAyn/Zda?=
 =?us-ascii?Q?fMXR1XNwBnS0tczGpwCeCfxakpuG/seA6InT+Hp6JEK5L1r5qMOD3EOh8/o6?=
 =?us-ascii?Q?gqHsVOIM+5bp9D47cKMub5unrwMwe8iM/7U3S3LE7/2Kq7ElxAPGKpD8O2Qn?=
 =?us-ascii?Q?AFtzTunB5HLqe/XFJyIlhvojs30WEakmKHCo4U4kA6/erFDpWTAI/BVaY86Z?=
 =?us-ascii?Q?iTkny5qJlXu2ylW9spIyxfxjUbiy2EXFes255yRe3NPtFIMAgIsvazV8kFam?=
 =?us-ascii?Q?1tnD96JUYZDilEYDa9ju8nurmDNpL9NdDSVyts2zSFlCuX9wNcCtXYJ0hJBK?=
 =?us-ascii?Q?fMXZ8wl/re2j9FyTwfX6JlTCWaPU7U3ND9/qv0ZGQIDIwS5IIcZ0x6T8nx3q?=
 =?us-ascii?Q?appFt7yszEuzO9DUPLY+FYbXZrWxcIs2j33n+5m3VxGSlTAkSZMocD5N756N?=
 =?us-ascii?Q?TBUJtnuDyI/ZWvxelh1UPb/adaFVoDR2E2VpR24VNeBFFjeFNmKDv4b9NvFX?=
 =?us-ascii?Q?vsYx20jWVj9AFjU14f67fMXjhP8mhj1mE8iY+YxHh85Thw2b6fRzd66hBErN?=
 =?us-ascii?Q?aYDcKV4R2WlgSG2ON6NOqN+JnPsaGPJ7U8Y6xPcmiON8EUcKeRYUxf4Ugikv?=
 =?us-ascii?Q?N9RWfXb4bqc6l1mJVtvM7OvpYS6p8TqgmXHOw6ck+UH3H4diNgikIoHKN/O5?=
 =?us-ascii?Q?FGt+GQtZmTBVzaWeT/MoXKdHLS7ByfuG1OdWF2d+gibIesYcBoUTA1rXnSTz?=
 =?us-ascii?Q?pNchWZPaEOARUqkFcJKDluuXAs6t3pJQNyxoPprXriTuhV/BMRuoC402VHSo?=
 =?us-ascii?Q?GZs3hHNpKzrsyRXJwThI+U1B1XfrQbFq88BAB+l5IJqP1XakWBeFi6wVTQAN?=
 =?us-ascii?Q?tGtSnxxdBOz1LzQiH52KTFiG5M3yVCslmv+2gB45toCf7F5p5MdelrGdr9Fb?=
 =?us-ascii?Q?22zW8WggSSzY9/Ahqdf7YiGf5L0lu8WvmJdnMhDRo1RszLTtK4Aa4Vo7dVaq?=
 =?us-ascii?Q?nLhIEW4n7zpxL9TLp3reo0uFqYi3JeSY+1FPonYcFq7viEvY39nHAo8+ROsb?=
 =?us-ascii?Q?H7MPC7W/zdcCFj1l8MQW7Oa/ejP4paAWfA4VlXxD2oyjA3CGwnrheGLG6kIW?=
 =?us-ascii?Q?VLGvi0NKy+bm4G3w87KXCnJHTzOzZPTFEn70M/lrIz7iHTlAoK5opLFjWbuP?=
 =?us-ascii?Q?aIEHEPo0aE2XwRh7LhiVZNJr5sKFMo/kxyfmT81NZgOveACloMHFDsOcrG9T?=
 =?us-ascii?Q?JcCZdbi1y+nm0ReAA2835lZ/Sjvmotz+EL0EqlwL0RA8I91S3804Xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QPF+py8xLYqc20BxPvGOdbcKNLMXFRJf5zR6sb8H4dEmZFIv1SVqpgWR1q43?=
 =?us-ascii?Q?3BwmHNDjzrP+/2rbKPiFkN9c1uNSPN1se36YGdVv2Snr5+p2Hi/PIF7/FrTM?=
 =?us-ascii?Q?IGIZK+4e4ku/AeUqTOfuehOG6OBvxy7F0ZxNHAM6vkYQNGBZxkLXjMfAHRPD?=
 =?us-ascii?Q?XBoCrnFetpdamlXV0hn/G5RWpEbZgoZpTWPfmO0YhV10srV3+x6AeR2Am2SN?=
 =?us-ascii?Q?NoMoxRIKE2qd3nzjcNocahzPOP93elbJvGlVrsGx7FY1i0D88hFm2UJBcXHk?=
 =?us-ascii?Q?whRnqnB7UAOIAslCHVxPWPxItLAjQYwumgmPjvVhviXUoblJ0VJa5a8H3Oqf?=
 =?us-ascii?Q?n2PMx4Vm+ng4AAlW4NHY9evg6qu8qXRpHtlkkQQzEEviNZ5hu8xwBS1tuCP5?=
 =?us-ascii?Q?Ip0F4YH22VswYCMR2u0uTvlXkP3llNz2g/cMQL1s6ft4eDYGrNHXNay2s9we?=
 =?us-ascii?Q?dflKHNIOCo51Yl8MEhMt2wnIfDi1pjSrfUaHRSqw3XTah5ua0O6ahgFD4XRo?=
 =?us-ascii?Q?DM9qfszvzszEeNzsQYlbz+SN46nRVHONeEK+jCSmF1GbZ5MPFHlbmuRt3ChV?=
 =?us-ascii?Q?S4Sye3Jk3CxRFEYrbs1c28X8FOQvf6ITLb+Tiigt/NicPqhWA/b3id7n2NNW?=
 =?us-ascii?Q?4lyG8xfUp52lveFC9Jovvi5iI3m8rLDXCQtJiz+q+VJ8TZdU8jSyAWNCeDbZ?=
 =?us-ascii?Q?/uCxbz8lKKPJDl7MUBNx666mzoLoR2tSNesmWAutpp/H11CEnOZbidwxqf/U?=
 =?us-ascii?Q?tNnufwoyDu4BWjXpkI3VHBCSHP8kibKuICBJLj3DtHAPmCjZDr1oLGeoETIE?=
 =?us-ascii?Q?iEdN4xQZjxecS1lM7zK+lrTO8kd2KDw9Idc2otgrBtTrfrXNCPZgY+0UIoMJ?=
 =?us-ascii?Q?4RByAzR+TET5ACe7egywe8JbYMMqRpEUauzVtRPSeyXp6rxPGkKhLABgirXf?=
 =?us-ascii?Q?rv72ovo7whtl4QdhhexWDu6RfYfBaq/B0c95Y/KWlB9OBLrBaXZhOmp9wbWO?=
 =?us-ascii?Q?ZNQxqzC45QIh8hcvJHlYYB6lwyfITH562SczOanTRkXYO2jYjFIRk3PIxzEO?=
 =?us-ascii?Q?VtfAT27IBODYGRX9kr3Qfdo77CYj80bJLVBBDrf4indEG7DluOx9uXOis/g+?=
 =?us-ascii?Q?xZ25jXPHPGQxg6jYmgfrKDJNGfbHjA8mV0Vuqm90M2rVvV+l0ywVR0/cIaH8?=
 =?us-ascii?Q?DpkEzxtP+a1RKNVomgbGtok/XIAZB4OMcQgNUBEpEKLSCY7NS8N6vZfEX7fW?=
 =?us-ascii?Q?asRGOmSNMv+DkLeySTCZqgJU3qxvAQEggKGNqzoL/8CIflDvycEs/DCStd7P?=
 =?us-ascii?Q?wOS3rhXGS7DmThQl+7Z8UWKEJHz1tdhb7FBvrueZGLW5T6LElqroBXWzR+2a?=
 =?us-ascii?Q?NE8icH1jK5xHrLZ3L4BQkaS99bfAT0XtfJPcCmqI/3cZv6zFRyc+MnVIA2SI?=
 =?us-ascii?Q?lGspe+bIS4qxu2Th83J6u1nYMVrvZJ7XgiI30aYjmCyeWdMgXC/N3CvUCKPd?=
 =?us-ascii?Q?X3Ne9dokvvz0nXrQHSLZzxgKls3R+Bm4HPMaOzaq8IBLQ58G2fNRxlRCWUJE?=
 =?us-ascii?Q?Z3jpzd2Am1YgvBSm33PfWzLL2Ak8jXEK4BwDG4CG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71240fc6-c839-4911-638d-08ddb340a620
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 17:00:40.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05SScl2YhHKSE841XOl4nBy/TnoMrf5SIDXAUxJN46INAU90tv44pq4i6PdybtCHekbHS9vUzOPO4V/RIwlWBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10710

On Tue, Jun 24, 2025 at 06:15:48PM +0800, Wei Fang wrote:
> The counters of port MAC are all 64-bit registers, and the statistics of
> ethtool are u64 type, so replace enetc_port_rd() with enetc_port_rd64()
> to read 64-bit statistics.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../ethernet/freescale/enetc/enetc_ethtool.c  | 84 +++++++++----------
>  1 file changed, 42 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> index 2c9aa94c8e3d..961e76cd8489 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> @@ -320,8 +320,8 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
>  static void enetc_pause_stats(struct enetc_hw *hw, int mac,
>  			      struct ethtool_pause_stats *pause_stats)
>  {
> -	pause_stats->tx_pause_frames = enetc_port_rd(hw, ENETC_PM_TXPF(mac));
> -	pause_stats->rx_pause_frames = enetc_port_rd(hw, ENETC_PM_RXPF(mac));
> +	pause_stats->tx_pause_frames = enetc_port_rd64(hw, ENETC_PM_TXPF(mac));
> +	pause_stats->rx_pause_frames = enetc_port_rd64(hw, ENETC_PM_RXPF(mac));
>  }
>
>  static void enetc_get_pause_stats(struct net_device *ndev,
> @@ -348,31 +348,31 @@ static void enetc_get_pause_stats(struct net_device *ndev,
>  static void enetc_mac_stats(struct enetc_hw *hw, int mac,
>  			    struct ethtool_eth_mac_stats *s)
>  {
> -	s->FramesTransmittedOK = enetc_port_rd(hw, ENETC_PM_TFRM(mac));
> -	s->SingleCollisionFrames = enetc_port_rd(hw, ENETC_PM_TSCOL(mac));
> -	s->MultipleCollisionFrames = enetc_port_rd(hw, ENETC_PM_TMCOL(mac));
> -	s->FramesReceivedOK = enetc_port_rd(hw, ENETC_PM_RFRM(mac));
> -	s->FrameCheckSequenceErrors = enetc_port_rd(hw, ENETC_PM_RFCS(mac));
> -	s->AlignmentErrors = enetc_port_rd(hw, ENETC_PM_RALN(mac));
> -	s->OctetsTransmittedOK = enetc_port_rd(hw, ENETC_PM_TEOCT(mac));
> -	s->FramesWithDeferredXmissions = enetc_port_rd(hw, ENETC_PM_TDFR(mac));
> -	s->LateCollisions = enetc_port_rd(hw, ENETC_PM_TLCOL(mac));
> -	s->FramesAbortedDueToXSColls = enetc_port_rd(hw, ENETC_PM_TECOL(mac));
> -	s->FramesLostDueToIntMACXmitError = enetc_port_rd(hw, ENETC_PM_TERR(mac));
> -	s->CarrierSenseErrors = enetc_port_rd(hw, ENETC_PM_TCRSE(mac));
> -	s->OctetsReceivedOK = enetc_port_rd(hw, ENETC_PM_REOCT(mac));
> -	s->FramesLostDueToIntMACRcvError = enetc_port_rd(hw, ENETC_PM_RDRNTP(mac));
> -	s->MulticastFramesXmittedOK = enetc_port_rd(hw, ENETC_PM_TMCA(mac));
> -	s->BroadcastFramesXmittedOK = enetc_port_rd(hw, ENETC_PM_TBCA(mac));
> -	s->MulticastFramesReceivedOK = enetc_port_rd(hw, ENETC_PM_RMCA(mac));
> -	s->BroadcastFramesReceivedOK = enetc_port_rd(hw, ENETC_PM_RBCA(mac));
> +	s->FramesTransmittedOK = enetc_port_rd64(hw, ENETC_PM_TFRM(mac));
> +	s->SingleCollisionFrames = enetc_port_rd64(hw, ENETC_PM_TSCOL(mac));
> +	s->MultipleCollisionFrames = enetc_port_rd64(hw, ENETC_PM_TMCOL(mac));
> +	s->FramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RFRM(mac));
> +	s->FrameCheckSequenceErrors = enetc_port_rd64(hw, ENETC_PM_RFCS(mac));
> +	s->AlignmentErrors = enetc_port_rd64(hw, ENETC_PM_RALN(mac));
> +	s->OctetsTransmittedOK = enetc_port_rd64(hw, ENETC_PM_TEOCT(mac));
> +	s->FramesWithDeferredXmissions = enetc_port_rd64(hw, ENETC_PM_TDFR(mac));
> +	s->LateCollisions = enetc_port_rd64(hw, ENETC_PM_TLCOL(mac));
> +	s->FramesAbortedDueToXSColls = enetc_port_rd64(hw, ENETC_PM_TECOL(mac));
> +	s->FramesLostDueToIntMACXmitError = enetc_port_rd64(hw, ENETC_PM_TERR(mac));
> +	s->CarrierSenseErrors = enetc_port_rd64(hw, ENETC_PM_TCRSE(mac));
> +	s->OctetsReceivedOK = enetc_port_rd64(hw, ENETC_PM_REOCT(mac));
> +	s->FramesLostDueToIntMACRcvError = enetc_port_rd64(hw, ENETC_PM_RDRNTP(mac));
> +	s->MulticastFramesXmittedOK = enetc_port_rd64(hw, ENETC_PM_TMCA(mac));
> +	s->BroadcastFramesXmittedOK = enetc_port_rd64(hw, ENETC_PM_TBCA(mac));
> +	s->MulticastFramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RMCA(mac));
> +	s->BroadcastFramesReceivedOK = enetc_port_rd64(hw, ENETC_PM_RBCA(mac));
>  }
>
>  static void enetc_ctrl_stats(struct enetc_hw *hw, int mac,
>  			     struct ethtool_eth_ctrl_stats *s)
>  {
> -	s->MACControlFramesTransmitted = enetc_port_rd(hw, ENETC_PM_TCNP(mac));
> -	s->MACControlFramesReceived = enetc_port_rd(hw, ENETC_PM_RCNP(mac));
> +	s->MACControlFramesTransmitted = enetc_port_rd64(hw, ENETC_PM_TCNP(mac));
> +	s->MACControlFramesReceived = enetc_port_rd64(hw, ENETC_PM_RCNP(mac));
>  }
>
>  static const struct ethtool_rmon_hist_range enetc_rmon_ranges[] = {
> @@ -389,26 +389,26 @@ static const struct ethtool_rmon_hist_range enetc_rmon_ranges[] = {
>  static void enetc_rmon_stats(struct enetc_hw *hw, int mac,
>  			     struct ethtool_rmon_stats *s)
>  {
> -	s->undersize_pkts = enetc_port_rd(hw, ENETC_PM_RUND(mac));
> -	s->oversize_pkts = enetc_port_rd(hw, ENETC_PM_ROVR(mac));
> -	s->fragments = enetc_port_rd(hw, ENETC_PM_RFRG(mac));
> -	s->jabbers = enetc_port_rd(hw, ENETC_PM_RJBR(mac));
> -
> -	s->hist[0] = enetc_port_rd(hw, ENETC_PM_R64(mac));
> -	s->hist[1] = enetc_port_rd(hw, ENETC_PM_R127(mac));
> -	s->hist[2] = enetc_port_rd(hw, ENETC_PM_R255(mac));
> -	s->hist[3] = enetc_port_rd(hw, ENETC_PM_R511(mac));
> -	s->hist[4] = enetc_port_rd(hw, ENETC_PM_R1023(mac));
> -	s->hist[5] = enetc_port_rd(hw, ENETC_PM_R1522(mac));
> -	s->hist[6] = enetc_port_rd(hw, ENETC_PM_R1523X(mac));
> -
> -	s->hist_tx[0] = enetc_port_rd(hw, ENETC_PM_T64(mac));
> -	s->hist_tx[1] = enetc_port_rd(hw, ENETC_PM_T127(mac));
> -	s->hist_tx[2] = enetc_port_rd(hw, ENETC_PM_T255(mac));
> -	s->hist_tx[3] = enetc_port_rd(hw, ENETC_PM_T511(mac));
> -	s->hist_tx[4] = enetc_port_rd(hw, ENETC_PM_T1023(mac));
> -	s->hist_tx[5] = enetc_port_rd(hw, ENETC_PM_T1522(mac));
> -	s->hist_tx[6] = enetc_port_rd(hw, ENETC_PM_T1523X(mac));
> +	s->undersize_pkts = enetc_port_rd64(hw, ENETC_PM_RUND(mac));
> +	s->oversize_pkts = enetc_port_rd64(hw, ENETC_PM_ROVR(mac));
> +	s->fragments = enetc_port_rd64(hw, ENETC_PM_RFRG(mac));
> +	s->jabbers = enetc_port_rd64(hw, ENETC_PM_RJBR(mac));
> +
> +	s->hist[0] = enetc_port_rd64(hw, ENETC_PM_R64(mac));
> +	s->hist[1] = enetc_port_rd64(hw, ENETC_PM_R127(mac));
> +	s->hist[2] = enetc_port_rd64(hw, ENETC_PM_R255(mac));
> +	s->hist[3] = enetc_port_rd64(hw, ENETC_PM_R511(mac));
> +	s->hist[4] = enetc_port_rd64(hw, ENETC_PM_R1023(mac));
> +	s->hist[5] = enetc_port_rd64(hw, ENETC_PM_R1522(mac));
> +	s->hist[6] = enetc_port_rd64(hw, ENETC_PM_R1523X(mac));
> +
> +	s->hist_tx[0] = enetc_port_rd64(hw, ENETC_PM_T64(mac));
> +	s->hist_tx[1] = enetc_port_rd64(hw, ENETC_PM_T127(mac));
> +	s->hist_tx[2] = enetc_port_rd64(hw, ENETC_PM_T255(mac));
> +	s->hist_tx[3] = enetc_port_rd64(hw, ENETC_PM_T511(mac));
> +	s->hist_tx[4] = enetc_port_rd64(hw, ENETC_PM_T1023(mac));
> +	s->hist_tx[5] = enetc_port_rd64(hw, ENETC_PM_T1522(mac));
> +	s->hist_tx[6] = enetc_port_rd64(hw, ENETC_PM_T1523X(mac));
>  }
>
>  static void enetc_get_eth_mac_stats(struct net_device *ndev,
> --
> 2.34.1
>

