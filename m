Return-Path: <netdev+bounces-144438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 279E79C748F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B76281A16
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B6917B401;
	Wed, 13 Nov 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lH3y1jSH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444AF273F9;
	Wed, 13 Nov 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508762; cv=fail; b=DLWAHTbSjq2RaWrlbZfzrQ22bbWpB9UCrXaLw7Zhl3U8PTainV0S3BwZjSvwLmgZN2W7Afg8UMQCfji+pazxeK4/4pVaV9sGMXY+KekX+MgD+Hxuv8mbsdp/nhOEyrnlIWvI1Ez0DGfdssgZPT8pkN/KHrdophCBLF0WXlutiDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508762; c=relaxed/simple;
	bh=49E8jKzYd0ysBW/E9bFyPJClCRviELQ7RH5TaMxemno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qMqiowzzYBAk80kr0vmovsc0a3Ravvqx5rxXGZUQIV2Znx3RfT1mS7bAcXoIyLJZusGuqWo8U52/zwIOIvqs1WIwCFKHwprK4JVA4bGYrFH1Aqa9fhmr/VN5AJhMvxbM9x7X9uX0SNp8L6PZSCu9uZPN+VmBioLwgyedUZ56/4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lH3y1jSH; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrA7E3vbgLf5C9x4IbcJSxwaaYcMr34+Izc+xBchrDoFKaKy2PCl+vc1nSnF2cVF9T/UId1qKa6MOQmkxXwsb8n2y0uyyCEmhSiRQSyZeZHYjaeTJoRzj4/x6nyYmILTlhMYxx8n2xpYsUAkjCHxtLYUwCMdJ45OfwwzGLz+WR7i9JRpHU5kbsp0Kyopyz887esohDPvwToPcJ9a+iVn3zwcmmEoYSRMS0qQef3G0KP9WiDdFT86ZBqnm+y0oLoFzHUWLFrB+/ui2d9ouPk+hU1JReTBKyW29h2DxJDpz64WAbABwY9VDXqpBEQ9Gh3C0cp+iT0zdsZ4NnSSBj7MoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgeMKbNHX7OMRsNVa/OyARxRBiHeAgeBWdJwbEGzI0A=;
 b=hJpV7dJVriiKtdh2OGSYr8CikLZekiQx5yCUxPIeDUdHF24v7QHAZhX/svkPLuUabQ3E52Z7MHh1Gf8Zmlq/xNG3K7CrnE4M8VRPkE2Hklr1yBYA82KRgtPzkMN4gptWz4pnkwzqPdNMlY1SKIj7TpIaeucrltT+eSAPWPa8ayNGEb0EkU3SfssRVEG12kBQaR+kpB5yJQrpDqR09FX6K9mHM5TxRJ7NJHFNfzktaZtL7B/c6L6zkZJrTv5LLCR1f0lVRgq6Tdl3S/zpnq5crL0JGMXsTS1dVNoEQxIXfjks3gg2OhtZwOjTvPa+/FfoYv2UWMQIAZdz5N2b/216yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgeMKbNHX7OMRsNVa/OyARxRBiHeAgeBWdJwbEGzI0A=;
 b=lH3y1jSHyWV1zKPh7mrboljgVkAFDGDPV1oOFyeJdLAsiWLcsXruHQmLrVRyR7Kn3ZiCgkCRhavADjI/QU8Gr/jTGzV3Xwo97TiZWcS6CbBCkUAbY9NX0XTvPGtD8uqdSrqOgLGHl+zHrtIBZ4ZMMkLCVI2kU44nYCivJbS+qRKjs9dPuqm5avZmwK29qXQ/f4DlkMjdMup7B/UsgnbbDhaA1E9473f9Es9WTTkweWtlCuJgVahN5V6gsW9/xBNax6MaoXMczDK7OOMpBgmTVxIfK7GV9iTUuk4vFvJ/mFVWdvKja6pCzYNIjxPLPOAf5VMtWSuZSc7PfMiDKY/x/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by AM8PR04MB7203.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:39:16 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 14:39:14 +0000
Date: Wed, 13 Nov 2024 16:39:11 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, frank.li@nxp.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 net-next 4/5] net: enetc: add LSO support for i.MX95
 ENETC PF
Message-ID: <4vfvfzegrk774qlo5fobie5qcleqxqaogphucpzlwlcnq3llqd@aspdtwwqbobn>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
 <20241112091447.1850899-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112091447.1850899-5-wei.fang@nxp.com>
X-ClientProxiedBy: AM0PR04CA0143.eurprd04.prod.outlook.com
 (2603:10a6:208:55::48) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|AM8PR04MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4a62f4-e30c-4a37-9a26-08dd03f0f213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dnb1phrywz/FAWq0xbM/5za1BiD46BXIfCLdjbkEkHrYdJhrktfhGZewv5Ky?=
 =?us-ascii?Q?DyNIiOMPgaj3ptDeOkE3AuRi+jS+K6hG633MZYUTE7x3rfElbzGUnW/+sOLK?=
 =?us-ascii?Q?2ubplG7fVVzOkA0k/Hzr2iQ8q6LtrXEzE+yEcRunDW4kldnulduyBJXvYPpU?=
 =?us-ascii?Q?8U7VMHTXTaMBim3iuNUvwmWUPs8rYPt2bOh3hG/Po7jR91qh6ATHYPvI6yGo?=
 =?us-ascii?Q?AyEhP0mKJ4PND4MoNULpeOzVG+qwDbtell8t0Qat9D5kxigO9ane7+gpHM8C?=
 =?us-ascii?Q?90ObD7hlcFHCF0kPkSt4K9lXdzcc0f3Zb5msXrfOQrNSJB42t/nLlnX1nsUJ?=
 =?us-ascii?Q?vDo3Zx+ONd2vNdxlzgONaua+cC6aYcdr5YiRTZxIN1/bPzTaggtGADDgl5E3?=
 =?us-ascii?Q?CsjfZt8ZpbzwO6sJ461zDStufYaTfGr2hgjc5esU0KwIV5q/GevrkwkyWfZQ?=
 =?us-ascii?Q?1FxkEfEvxOCONmeCekn+dFfFEQkN4UIWzYVU+0MlK7cQEbtNM5ehCZRlhvio?=
 =?us-ascii?Q?syiuYl0kaDI+XC0Dp4WbySQ6iWZHLVZmuZJYc9KuYxSKmLKvtixEJdQwKILL?=
 =?us-ascii?Q?PLTdq59CWvorJ+CImQJ0FD76Qu5HhhRJZy3lRraaFhnsFSAdg/Ms1lomIiX3?=
 =?us-ascii?Q?2nmelswY6MKXB8eohZ7BGEIwa3IOyZ9RgE2y6Z66R9sIUEtrerKVYFq88Pw5?=
 =?us-ascii?Q?Vdf5nBf34k9Fgowe+zWsdopIz9Ebe6cCG5T3YWnQimNMhpscEI8BuagVwQ5P?=
 =?us-ascii?Q?nuXWcPzBDMFqyj8YYL+bgsDhM7PpJv+56NshnPwN4jCD4+PgkhxxuQPfsKJV?=
 =?us-ascii?Q?qtTsCD9h+X10nJD3pQsw5mwvK/7fwdNm9CJbvLzXhyCWyXN9r7O2j0joWn0h?=
 =?us-ascii?Q?rpDtq7/MNbkAdzFphFL1rLiKPVvYJ/m+l2L2e3kY5HG85OVWCwYebIg8LvXI?=
 =?us-ascii?Q?UCX6bXpLvadTiMJ7y3yXpwzr+a2NR/eFh98pQTPjFtFjJi7nV/ywAgd9y0ym?=
 =?us-ascii?Q?jfdViVhtludIDfWUJaXSQ0m0m0VeKDP5FjXF3309qIyy0/qwsr8efxdIw2FI?=
 =?us-ascii?Q?1frFICiJ+tlDkc4iB3hAujVlsE+CgEWntckaxym+YFcUvf7vYdVLd/1aWO91?=
 =?us-ascii?Q?WrosqTxjUBHL37zi5Nk4tUp4zAQQi8jRzDdvC2wbwb8b3XiYFiGDMytozrAm?=
 =?us-ascii?Q?md8mG1/BZuGgqcNj7UeeXLsRjLhvmcG/1DBYfAm3ShMBFIWKtoO3tC0iMMKK?=
 =?us-ascii?Q?x63wd0G3UGDsNGKVmv9/T3KMlKsBs/q/5UhoZ0fnvHFBhmBlx83jm/SIEGJO?=
 =?us-ascii?Q?hdbztoGKUEGK1TAvhPTVWRP7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q2/SKE1WG+sK2K0gWOszPaus7/L42qAh60TLjZtw6MXnEbHh59v6qWu+Owh0?=
 =?us-ascii?Q?yyDIx7PsuaVpZYq2jjoT0ff4CHVBkJoIuGPzwOHhbGXVhxYbixaeh8dGsGvW?=
 =?us-ascii?Q?Dw8aliDFzOeREUP8weQ2k/xZvC/wL9Ma3nyXKu7y+71ptN7/nbXBOhqTq18R?=
 =?us-ascii?Q?+Gyu789sziYCrVtyqYHZhY25TqZGjpxeyLd75YaSMIQVNL27DpA+QYVXYfV7?=
 =?us-ascii?Q?xzqKVJZeRyHm9yZSQxcUufLvjhusKDB8+OGsUnVpLH05Evi38xUFlboO61zA?=
 =?us-ascii?Q?Wi4D89U70UZwGGcxDmRI3J0g9UOdMuQDdw7eEY7lXI76yvFYLoG6kj0s2DhF?=
 =?us-ascii?Q?dVnCqpfQbtMTN7Uzhko3TcJpnGMWbwt2yyZfTtSAhpaL3HYzG2nHCsQ3Q2sq?=
 =?us-ascii?Q?Nu0FBy0iLVovPi8hO0ki2BKkus0xVwEKDrzx4V6aZmv2qq/6ZueFBzUHGcx+?=
 =?us-ascii?Q?uulMTtkXQDwqH0t4aFXByDvuvaSk1eOcl+nKgD5deQ/Y5BAMYbJ+O3HujsZu?=
 =?us-ascii?Q?+yoxF6wdlRco9zmg9a75u0XHh1kLtoK5CucX1+A3eUv46Ogs0pnjjtnFNb8G?=
 =?us-ascii?Q?50m2GLc5uY8B9T3ZAuw8GkG9/2deH1V2QTCGiJCsg6MqILgngkRs9CwD3c+e?=
 =?us-ascii?Q?ky3+bz9u35HB0wbui3Vli8UiY5tn5cCL62R58Q8B0lRrNqtL4JwtSFbmrpvx?=
 =?us-ascii?Q?8yB98iYjrehlga3yOeSanRSSxV+/eUNtGGyeCKt0FaKdr+/EDtdAm8LfoKl0?=
 =?us-ascii?Q?Y0CqeKHA4hCs9fIDDjRo3WLkVJHWYN0MLV2dR6VuTRnn1t8kqGeZ3WrUa87H?=
 =?us-ascii?Q?Hb+f41wVkKKano9NqbQ6ACT7OiLD5zTl5VN+WZGylaMsmrFR1kFGE75OtRpw?=
 =?us-ascii?Q?qQD0Ven2ScBxf7um6cDkRyL9+7Mjk0J84Ea+lwhGpabtxBU5Y2viTj2pI7pR?=
 =?us-ascii?Q?FiiXI+sdhier8/46gqdRQm5j8J2GJ5kNxz+9MgrFhUrF3K4G4rbzo115YbHa?=
 =?us-ascii?Q?XxT8IwA5MD9JwgPVZFv3An/FhEMJn+Q/4PoIBKEDrJKSErGdLG6tWwas79Wg?=
 =?us-ascii?Q?BptR+scVF/UO8ocleRkwt/O5djU+BjQwBQMa1G1/kG6bGNjsTZqCE5JjOwQm?=
 =?us-ascii?Q?wHTFWqKLvJNRMbNfeMxgh4X0r7jThxqU14lHWaXLs2LG2Y5EGnQ3Kyfv8+tV?=
 =?us-ascii?Q?WXhcFWJyX1XDPOMe8CQQBiBVrMG1r5wp5oGUii5YTvxp0xj2F83u0KQtZp7S?=
 =?us-ascii?Q?Z1w8VoVAr17oepuw3YjF4hKTajUPxgdmplRA/GbqrZtrSQVXnDQ8gfX6QKVu?=
 =?us-ascii?Q?9/Qfa+aXr2IZPcZKoLhcWXa3ACK5C+IDwZEPjFG1aSug/IXIwCta3MQBPbKc?=
 =?us-ascii?Q?ksjJnU7ssAqnpfkiSCB6qKny+6LfxTvwJBJ88MF2k2gFsvQ23rwngxFkQVHx?=
 =?us-ascii?Q?fhYFGe4Pi8IZiZsodMm/BxtQNypeftb3yhxznpOrB8RMdASErz3ll8uqwxbW?=
 =?us-ascii?Q?gxyA9BiSXEX4iXtXC4fEFaCukqT3CVOgC6ZdMg/WiscXXIG7eyKFivVVqDdO?=
 =?us-ascii?Q?sbXK/wz00m+mJGYDSIZ4Zr6urdA+8Aevci5bWFLJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4a62f4-e30c-4a37-9a26-08dd03f0f213
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:39:14.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ocqu9BQrLiNzRQRLEPmNNtq5C5Uy3aG4tqgXK2eR8zi8XlWhbW58BgB+bBQfJ/o3ko9DHAfOPDebVCbie91mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7203

On Tue, Nov 12, 2024 at 05:14:46PM +0800, Wei Fang wrote:
> ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
> and UDP transmit units into multiple Ethernet frames. To support LSO,
> software needs to fill some auxiliary information in Tx BD, such as LSO
> header length, frame length, LSO maximum segment size, etc.
> 
> At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
> CPU performance before and after applying the patch was compared through
> the top command. It can be seen that LSO saves a significant amount of
> CPU cycles compared to software TSO.
> 
> Before applying the patch:
> %Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si
> 
> After applying the patch:
> %Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> v2: no changes
> v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 266 +++++++++++++++++-
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 +-
>  .../freescale/enetc/enetc_pf_common.c         |   3 +
>  5 files changed, 311 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 7c6b844c2e96..91428bb99f6d 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -527,6 +527,233 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
>  	}
>  }
>  
> +static inline int enetc_lso_count_descs(const struct sk_buff *skb)
> +{
> +	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
> +	 * for linear area data but not include LSO header, namely
> +	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
> +	 */
> +	return skb_shinfo(skb)->nr_frags + 4;
> +}

Why not move this static inline herper into the header?

> +
> +static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
> +{
> +	int hdr_len, tlen;
> +
> +	tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
> +	hdr_len = skb_transport_offset(skb) + tlen;
> +
> +	return hdr_len;
> +}
> +
> +static void enetc_lso_start(struct sk_buff *skb, struct enetc_lso_t *lso)
> +{
> +	lso->lso_seg_size = skb_shinfo(skb)->gso_size;
> +	lso->ipv6 = enetc_skb_is_ipv6(skb);
> +	lso->tcp = skb_is_gso_tcp(skb);
> +	lso->l3_hdr_len = skb_network_header_len(skb);
> +	lso->l3_start = skb_network_offset(skb);
> +	lso->hdr_len = enetc_lso_get_hdr_len(skb);
> +	lso->total_len = skb->len - lso->hdr_len;
> +}
> +
> +static void enetc_lso_map_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
> +			      int *i, struct enetc_lso_t *lso)
> +{
> +	union enetc_tx_bd txbd_tmp, *txbd;
> +	struct enetc_tx_swbd *tx_swbd;
> +	u16 frm_len, frm_len_ext;
> +	u8 flags, e_flags = 0;
> +	dma_addr_t addr;
> +	char *hdr;
> +
> +	/* Get the fisrt BD of the LSO BDs chain */

s/fisrt/first/


