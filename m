Return-Path: <netdev+bounces-237760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E3C4FFD2
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 23:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4265A1898966
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC78B296BB6;
	Tue, 11 Nov 2025 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SgX5CNSZ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480A257831;
	Tue, 11 Nov 2025 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900783; cv=fail; b=OTqaO1vQH8T6gHpXFH7Abpvn0CodOd+DHqXuB0zjEaoAtmA+7MKFExd+4i1XspRn7lUxJ8UpNiPWHjZoQXi++M/UJFCbZAJe/DZ3qS2EvofDsSzEFQRecbqS39pBF9aiEOIcN3zseuXXAVmwlzgi9xuKAxDUizqzKiD4mNEFGx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900783; c=relaxed/simple;
	bh=bApKjtqwlMmo6SimsFOHElwaurVcGs9T3AziyYMl6Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G5fIyWLQYnhXZFV7lFMVins1MTNMnVwvL0nsRyLKZHUdCUvc3DYNB2Cti4rGOOxvcAFD4DDf07B2wgo7gVjVhJPyDB85Z1TtC2N47ri2In4czll+u7yLyHu4AAmmkUQuj9SvTYC3tL/K1F9fIn2wq9DzeG6pNBgfPT4bswm4ebk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SgX5CNSZ; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K10OFg4s1LRd31zi3YNw+u5LV1cYMENXf/9sevXoUYn6+SJYjodZrs17WkT6rLSD1YmCDgTat7fjd229If3Djk/i3KhAoFn920LfMDVCgyn2vtOfKUax/mOsFUms3rSkLRzsnE8JgzPYNiOnMJoGmEP+tz6SuPubhB3ysXc28A0rb/BheIAJPRfEVgEGerQpMBe+e2kJI+XBjP5PYQvw5peZ90yyNIkjFX9Dkj9snQiR3Hs0LDV+rR/MIocVOdIIwWL319fSlQg9xy+Rc/Q2K33oBS7lUdl2eU5Ml/xN6vUHPLDErz0i+tT4gf53pQxXJrGCyijAJ0RPKaKDZbeo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhrjvwSrBtFYrdx0dPMdLPQ77q5/0t1gFJf8RLSrWaI=;
 b=rVYLGlMcEOuJGtezXOcm9H4edyjkI7HH5PZoqAei4eumbUr6qwrzJQ/wleAPDXjTHLpa0L7iKuj9XLCa0LCZ5JjmNifusPlRCgXe17TK6b/7mwlzU77wYPj9VBpjcUzL1XAs+KkL2cniVKJmIIH/QT/Bdf3i25lK4+pUv9rBJ6XW4rcefEYGugDgBdvB+zXogzrvExNeF2JM08nGMNF5UUQq+aL8jTK0eWEf7/g3QqwSbnciq8L86i6XQB7EAaYgkRNMIKExyIp2vdrgdXOMIywfu0UMOW53PTmzLqmivbRcUy7QoohB/I4MzPhMj4M72S4Zlx5I9yjQmoDlMCilow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhrjvwSrBtFYrdx0dPMdLPQ77q5/0t1gFJf8RLSrWaI=;
 b=SgX5CNSZDMVcPtt/rAvT9hc9Q5IghFGj7il1y1O4kp6hFF5g0MPCCqxqDt97smVt6kw0Am+SkF3+42eIa1e1W73y5AwMcSu0q3LI1bwmeeMimpdfDHaqQP0nNeVnLk68iEOUydEIC25GsbLm8lhkZ2Ji6fhV2yGA6xv4JD0CZBJj3nEoQGYhKWkRapIq2UcBxOlg4LtVDpvPtJVgOxy7ifkTTaI+Diqk56bWB19lDmjzxfxBsOPRQbn96GN3hDyIoO5zJcr1zHo6mJtIa6WeImhz6IvGhTRogya999IfzmBvf7caAoZx7WFyutd4uZNLJz+36SuHawoJOfSt9OoaBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by MRWPR04MB11997.eurprd04.prod.outlook.com (2603:10a6:501:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 22:39:38 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 22:39:38 +0000
Date: Tue, 11 Nov 2025 17:39:31 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eric@nelint.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: fec: remove duplicate macros of the BD
 status
Message-ID: <aRO7I8XEUnQahVAu@lizhi-Precision-Tower-5810>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111100057.2660101-6-wei.fang@nxp.com>
X-ClientProxiedBy: PH8PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::27) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|MRWPR04MB11997:EE_
X-MS-Office365-Filtering-Correlation-Id: 36037837-bbbf-4d4f-cdba-08de2173321b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XVgf/UuGaF3p0JqdqNG0/PDaa7KVAPJmqCKBqdvFXxTMwpyibmWCmvN3q7hw?=
 =?us-ascii?Q?K7Oh1uqSZvWfyI1bBqKzXWlAdE1LXMpKXCPbZkbh0BAjGdO5RRaFM/MpbUkm?=
 =?us-ascii?Q?AOmPcnAOIMk6TgEhoyQswVVCybtJSECd0fZtChdAr0cLefUVLEZQABTl/hvy?=
 =?us-ascii?Q?SK5SnD7EIzaEjXwaZo3uQi8Bwu6sY62IgrnUBgJ/RYoUuaNEjJcvnaJDUp26?=
 =?us-ascii?Q?C0kKTjaXtw7719HvRO9gj8+7ji813oa7sWjRExwbyQbCwDTy0Kl8Oev/xLsY?=
 =?us-ascii?Q?9wc2etRPc8LMJH6FPkRjNlFOlaXXkPbKuwI5Zo5RyG9OMslXzFk6bl946vWC?=
 =?us-ascii?Q?xHVQ6//MlU+Y7dw82xpN8Z6nJLFaWRM+4Gk6aYs9sAkcauGBTdD6hMQIiuDU?=
 =?us-ascii?Q?KYupQgyU5cdGoTqJ/H37yi/MjQSeEjl3ZAD8/7hplLQJeiV11xbnOr5d0d2t?=
 =?us-ascii?Q?ewMP/dYChA+1fhDE1AvNLcWuhvASzHJ5fS4TX9fkvkI8M7QDy6WhR3Vpi4a1?=
 =?us-ascii?Q?gHGYFKQwTAUwEOKDIjZu0RA7WVs6vMVLBb0b1UDHkbPNwtnJZ9xCshnUXiWy?=
 =?us-ascii?Q?cHFV4cmMSMbo3IkXzQ3mu3w0KeRGHGrr63Or+V0JHEZgYzOVylS2krWYjSaI?=
 =?us-ascii?Q?0hLiJT1kGqTTYgDPbYZihUPEWD09IXxljxiFHLCsMoUMFduXUxalc615Go0q?=
 =?us-ascii?Q?BkCr6EkyrWmxXoqu9kAvSmsKfbRu1bQcslhWuKxQpetoV/A/pv1x32lDAJWf?=
 =?us-ascii?Q?0rIAUFmM2fgUj5NtkZQnbB31oZ1rUToajhX3xJvMmaPqMVKQfxvYjsLUMuMP?=
 =?us-ascii?Q?a4CtCX7d2Wimjmb2z/segaYovDqUyTBX97i6wsuQ93bXx8b66bP0P8CNpr4v?=
 =?us-ascii?Q?QBYcZYL+xsRrgFC1L/qt2gru1bPUhc3jTbWRSWRPGCn2LhiVwqYRdas0Tunx?=
 =?us-ascii?Q?sCO+zWWCrN/zKZx/CfEFzRgsTeeXME7yVYPpnXkm4/QDh6IMxmpZs2QLeWS3?=
 =?us-ascii?Q?xQN80HKIqBGegRH+RKmauXUxwBsBm6W+aDjFT850XzVV4cBqPvOKfSmwpOUl?=
 =?us-ascii?Q?2OXZz+e7YIcJct+WmvCjb70YnaHQT9g2rR2HFQ1lxaL9NgDQykNTdB96OATm?=
 =?us-ascii?Q?yej1asg22r36ZOSrOCX91D6b25ClWU5Sx+dghkhWJRN52l/dkzCBIrx1hElK?=
 =?us-ascii?Q?S3ewbIcKLyR5oLNh7+/x4d1qUfmC/4Tj15KDHezkaPrdyhSR2bF5wAjVTGIZ?=
 =?us-ascii?Q?Pb9sdb4bd/aCFryMBlRPGgwZr47usTs0sScl9sgFYyVpoRNk/JvJXp/5zrGo?=
 =?us-ascii?Q?ZTpySSnFsFwQ7ybRNieJar2kHnrL0SLX+YO7MS4JInAMhfX8Hj5q+huMnFJx?=
 =?us-ascii?Q?df600uamcs8p4Hn6uxniC0Q6jFD962Yq4Z2qxmavkhkRSAdTru/2kwoN7ObB?=
 =?us-ascii?Q?7WQu+jGrFEkNqybvls4nYU5U8ahsfQvh0Dgh+t9pXFvEtPtokmMEGWFKQTgF?=
 =?us-ascii?Q?yE//nLjZHKvWsP6LKfhl18x4M285XLx9mz6T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GKTsEDDNNYaujiei4XZeyFSaySdW4aHlQBykUMoE0Gxfqz21u3VrUPTye66V?=
 =?us-ascii?Q?kXLVBNiARDPB93dplXVJqxlnsQriekEfuGmiJz9MYaTg/yMOwb+e6X71Vcow?=
 =?us-ascii?Q?b/laLTWcHlfFTpaER48XpEBm8auwlZdsdV65FQ8eMgk1c1htbFjnctHElX+f?=
 =?us-ascii?Q?GqKeNU/3Z6+4PgKoSDBW1gd1P3DRYhjt18u+bvFMoXuDUeS3zdpzVrfG4a+U?=
 =?us-ascii?Q?wfnRPZqC2o7tCdRim9iAupO+4X4bXvEOzVbW3TWOrezGN6HpOgtze7qpI8h8?=
 =?us-ascii?Q?fSj8LAqelOxGAIg7i4bqNtjMiKqF9yL2uiX15ZQ5PPCWBzhGq8zKqzQGERXe?=
 =?us-ascii?Q?uK8BEB1nQD20JKCjSEN5vLr4blz0kEeRC9ZpeO8vH6WPI40WZiOn5r6397g0?=
 =?us-ascii?Q?OU2D71jKyHIiAl+PC5/Rw3zmiG6Xh+hURUj9db9oVHgYpdr0pYN3E0dEu7YD?=
 =?us-ascii?Q?uYhMK7dPnL1ltbdKYOnSQlaUMQqmxXCwZaG874+nm+V2WELm0xe0/d8S3UGG?=
 =?us-ascii?Q?s7DDJvTBkbSQnA2QmAJyoY4kRJlTOlgk9AiijjmF6HYFjMoVA1WFfPGTiI2i?=
 =?us-ascii?Q?kh3u4hfiAKgXdOtHhidaw8j1zjCL0aHAiDPGpFBMFNvZR1+SAEo5mqVTTSQb?=
 =?us-ascii?Q?FhurZk9DArAoc2cAaKV0ySpjQDnAASbLhhWKVFKg6N37pSNltytvBYzWAHPT?=
 =?us-ascii?Q?ZEOCprW4QurngfJaetpAeJO2lFGHmoZyBFsx9jqlvLqg30UPL2HupWk68Thm?=
 =?us-ascii?Q?WLcL3sRKdxg5xalgIk33OdWYPCcHk49mXJ/+wcp6o6kdnMVaa5j+mxc1vi6L?=
 =?us-ascii?Q?Bj0XO6W8k/STDLU/ag88epepOUvbcByLzjt66fZPLIsQOLM3q0rpUSdZrpK3?=
 =?us-ascii?Q?zP7QbvoZ1JLc4V+hfuijLgXC2uhMwNAzCTolpmkoUAQ96iJOwLg6i1qNq+CT?=
 =?us-ascii?Q?f4i/3lDjyc00oaOrjsBM/oGrfyGZvy63lfamXoeXxK4V+Hdubw6dsho9Sh8i?=
 =?us-ascii?Q?sTwLE6Nw6t0K7wwY1r9i6pm2cOidWsPZVHmzF5PdjcHDDO7rO7Dv3RgKUP4D?=
 =?us-ascii?Q?oUGf6tjtbUAHH5LXlyDzETkadAXz/63ksyINyVwMz9dwzIJ7RuNrfOm54y+F?=
 =?us-ascii?Q?wD6fP12XNEjdUptzgV6uPd5ckwtaYkoJm+lXM1PBTGcxZK7u8kHELNNLZFht?=
 =?us-ascii?Q?mqJGgpYPB+AKxZxFMf50XpEFuXBcktnNIITvH0aXCUE7mDLRWzfYgTy5XEla?=
 =?us-ascii?Q?5dPDp+o6M/sVI7c5pmZ2DT+BvkHQF3UT5x58rOyVsVrt/OZZr3dBLyhQb5MN?=
 =?us-ascii?Q?huv9llgBlIHd8XWFQr/qTrbUEr1yus8KLlkjBevotTfI7zz+ax8eRKTv1z8V?=
 =?us-ascii?Q?hM+ftkok44oFbGFLgPuFt6Qj0hVJ6vfu52WPoy7VzWevLza7vI6i/tvivsQr?=
 =?us-ascii?Q?qi0nay1Ippa+QIcMu7fKISuByAI0NbQtGLUGhBfdEjWyJR+YLXmfcgVjWo+4?=
 =?us-ascii?Q?mByVcWpGAK34rByFHlhFdGWx2M1qQYoUZ7LFkv6iMU9zs8DOrefu9DaYipiM?=
 =?us-ascii?Q?wCw6N+b51swglBrBACAqAYIyahvBmViuC+r6SqGQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36037837-bbbf-4d4f-cdba-08de2173321b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 22:39:38.2016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vhlnjiVkZ/VNbTDfwLocPkBCCUj4FPO+qzRoabJ8w2h+mVOn1qHnUnKgAvlxs+zJZAyXn9qAdJBu+h6MZBM4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11997

On Tue, Nov 11, 2025 at 06:00:57PM +0800, Wei Fang wrote:
> There are two sets of macros used to define the status bits of TX and RX
> BDs, one is the BD_SC_xx macros, the other one is the BD_ENET_xx macros.
> For the BD_SC_xx macros, only BD_SC_WRAP is used in the driver. But the
> BD_ENET_xx macros are more widely used in the driver, and they define
> more bits of the BD status. Therefore, let us remove the BD_SC_xx macros
> from now on.

nit: remove "let us",

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec.h      | 17 -----------------
>  drivers/net/ethernet/freescale/fec_main.c |  8 ++++----
>  2 files changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index a25dca9c7d71..7b4d1fc8e7eb 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -240,23 +240,6 @@ struct bufdesc_ex {
>  	__fec16 res0[4];
>  };
>
> -/*
> - *	The following definitions courtesy of commproc.h, which where
> - *	Copyright (c) 1997 Dan Malek (dmalek@jlc.net).
> - */
> -#define BD_SC_EMPTY	((ushort)0x8000)	/* Receive is empty */
> -#define BD_SC_READY	((ushort)0x8000)	/* Transmit is ready */
> -#define BD_SC_WRAP	((ushort)0x2000)	/* Last buffer descriptor */
> -#define BD_SC_INTRPT	((ushort)0x1000)	/* Interrupt on change */
> -#define BD_SC_CM	((ushort)0x0200)	/* Continuous mode */
> -#define BD_SC_ID	((ushort)0x0100)	/* Rec'd too many idles */
> -#define BD_SC_P		((ushort)0x0100)	/* xmt preamble */
> -#define BD_SC_BR	((ushort)0x0020)	/* Break received */
> -#define BD_SC_FR	((ushort)0x0010)	/* Framing error */
> -#define BD_SC_PR	((ushort)0x0008)	/* Parity error */
> -#define BD_SC_OV	((ushort)0x0002)	/* Overrun */
> -#define BD_SC_CD	((ushort)0x0001)	/* ?? */
> -
>  /* Buffer descriptor control/status used by Ethernet receive.
>   */
>  #define BD_ENET_RX_EMPTY	((ushort)0x8000)
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index cf598d5260fb..3d227c9c5ba5 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1010,7 +1010,7 @@ static void fec_enet_bd_init(struct net_device *dev)
>
>  		/* Set the last buffer to wrap */
>  		bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
> -		bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
> +		bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
>
>  		rxq->bd.cur = rxq->bd.base;
>  	}
> @@ -1060,7 +1060,7 @@ static void fec_enet_bd_init(struct net_device *dev)
>
>  		/* Set the last buffer to wrap */
>  		bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
> -		bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
> +		bdp->cbd_sc |= cpu_to_fec16(BD_ENET_TX_WRAP);
>  		txq->dirty_tx = bdp;
>  	}
>  }
> @@ -3456,7 +3456,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
>
>  	/* Set the last buffer to wrap. */
>  	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
> -	bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
> +	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
>  	return 0;
>
>   err_alloc:
> @@ -3492,7 +3492,7 @@ fec_enet_alloc_txq_buffers(struct net_device *ndev, unsigned int queue)
>
>  	/* Set the last buffer to wrap. */
>  	bdp = fec_enet_get_prevdesc(bdp, &txq->bd);
> -	bdp->cbd_sc |= cpu_to_fec16(BD_SC_WRAP);
> +	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_TX_WRAP);
>
>  	return 0;
>
> --
> 2.34.1
>

