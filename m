Return-Path: <netdev+bounces-239181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D4C650CA
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C71C54E97C6
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E487E2C21F6;
	Mon, 17 Nov 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A/7NbQmg"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DAB14AD0D;
	Mon, 17 Nov 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395816; cv=fail; b=qtkhG3d2RmdZHOeI362cmEgRFyZ8mFjwWoO2OV070MY4aqqNsxXfHbZJxOKtBRCmTz/SLINEcHsBL9BI5yoLG+6qn6UnLHgzbF96uloMsPJodak+ZNKshZL8/jgtCe2wnQELMWKuas5p4bDUVYLEnuek4Pu/Doo9i1AeOIinTl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395816; c=relaxed/simple;
	bh=ZNbSR1HWQ8MuHkYyQ6b/l8n+VgReoh0NVENwcTMLL3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JGtjYXz/Dmy1JhhUfL/BeRUJ6YLCHwydgepuH0EYxvcELuUPC9iNlvFd5XD4oz09Ir4nMkDt3A+SFfQ7W1/cr5ZUGOPIPO3OkGqNSrcF8f5jL4cCx2+usLPcWXCFQJ9u2TCKz0le4wP5W8B6XmCKHvKFymw4ZT2n+GpDfuXRTmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A/7NbQmg; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0eqAqoMoAhkSB7obco3/Qk9JckRxIcIDf3iCO1XpEpdI17TtOayS7P5n1tgsVuhWFtx4wJxLsmNf7dKKZKC5HoY8qPRho+H9o9tHPNDkGMjrOyIra8NZY2q73UeGoH0S5ieZ/0zAUXkKb6ZEfafc3uiold0Dv6zFL2uW8vPlnPekx9oJ6m7Zg4C+mI1YRuSSfC6ZxvO/rI2QzA246erLOx6eayChUHeim0jhcZcvMZX58R66kajiFopoN2R56nw22IpEQtl+oudL9MKCENYh5bMvDDRvkjnEQliZkzgYGe+iibVwNEJ4TFkvvYO1lA1IoHg5JtPcySUlKgXO1SbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxF8iNO4ggMWSBP1bAdd8QmR7p5tDuddGhLTRtzDsA0=;
 b=ZncQ1m2PSwU4l7yE04kMGa/aU7DLNI5PMg4PGvkBBtVKkJ949Tcz8+AXrAoJDdQ+rfT5MZeyyslG3SeuxResJqOKz8PhTUkk4j09iqX7iBYntlp8A3qZMbooVVWnVE0dzWhnVFTSr24iVlpEn7Yq1WUho61wOjQDOXZj3Dyb7ejxTPNYEBghMLda4TRMv2Ustw0hddRS4lJFkGizXZxXkDnErki+/u+394pfCDgHglNI/9wwN4EiNc1iEEPxojBE86/XtoQgIrS7rq8cEfHlpZv77eLJYBvALcQCEYik/1uDk37sq4YtbH3CPHwr8/gc+sjJj/q99sbWgTwCatgjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxF8iNO4ggMWSBP1bAdd8QmR7p5tDuddGhLTRtzDsA0=;
 b=A/7NbQmgHwMrbfyb3kHqZ9BPWwKzCMpxPnB2FLW1uH5UPsKoi7ugPQxjOdR9iRBIRGNzA4cCqtFJMs30s+URoarZZnfWfeT0IH2SWNKi0K3a/ERtxMWuqN67LtYBUN1qKFfDAOrM3jmtYK8JvUdY0p10tPkExoy7jS+8QtDQTBqkIVaEWupPXDsg8IjzWKN/1rltverAxPGAWc0+DNQHCKQC/45ZhD2HS6/JNNwTmKWxbtZtQ1P9TIZsd61xOYo/U6PJ2ZQLRhVwWG06wJQuXYok3o0low2YGLhd/XGq3FqJ7J9ik68pGgT5MJWkVJXKNSMyFJ9BYy8b09wR+nSmww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB8811.eurprd04.prod.outlook.com (2603:10a6:20b:40a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 16:10:11 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.018; Mon, 17 Nov 2025
 16:10:11 +0000
Date: Mon, 17 Nov 2025 11:10:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eric@nelint.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/5] net: fec: remove struct
 fec_enet_priv_txrx_info
Message-ID: <aRtI2/RuIaZaeChX@lizhi-Precision-Tower-5810>
References: <20251117101921.1862427-1-wei.fang@nxp.com>
 <20251117101921.1862427-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117101921.1862427-4-wei.fang@nxp.com>
X-ClientProxiedBy: PH8PR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::20) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: aae4cc14-8c3c-4211-17a8-08de25f3c8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SCg1GYCYOi25A+MeEv8M6if913Xqb6UrlG+bdD+op7WMv3K4ZEi6N9zkFP3e?=
 =?us-ascii?Q?fAqfn78ZJ33zA2r1Z2khGC0UF8hQsyy1UT5PxPnrffx9PgTFz3ZnALd3JmTX?=
 =?us-ascii?Q?UzCclTxKzQW/a4g3Y76fXKGqO0FvYM+QJKqahFzMptEMBcFBlWUYAWG++f1Q?=
 =?us-ascii?Q?B3Hgrcg44HJXAAfQQ861IDSEgBwo8xnSutWBm/FHWsF4Hq0R67bcoplNoflr?=
 =?us-ascii?Q?5EO0Tq3W7rQr0k7f7x2MrCMgT+V7TtQSvJh0kLobiqxwkUQF7vlaELKqAU4c?=
 =?us-ascii?Q?T4L1idr5RZHPr1iVxkQ8Q3Sm8GF9zY+N099QFaY205wkyt9cP2k34U0wXSBn?=
 =?us-ascii?Q?6+sbGCTLABD3I5ZfXQ1uSakzzW9BaGmSmVLhw/hQwNJ7LIJYhAM1VHVycFzF?=
 =?us-ascii?Q?wmdppkco5mSMkNpa4oETA/aMiFoof7GX4r8faTCQI5UF2A7bXlc75kKDgjKC?=
 =?us-ascii?Q?F4nVZnLNTpspZZDxTmdPExZ4eK624oAytcVRCh1RXrAVfbDHoYTA0smQU22h?=
 =?us-ascii?Q?wes5CI3ZQBF5fHvS3d99tvVZdv9XqchwC4bDgMlAtm1pHVTwFxnzdWBrZUGr?=
 =?us-ascii?Q?3dRNGVi1aI9nu4AwIoLzorBjLJ/2Wm4L/4w0VFc/5zmOudlZCW8OeiiF7tKd?=
 =?us-ascii?Q?zRBTimwGFN6zYA2fx/nao+iCFjISe9zvSfW+IeyNbac2K3gV3UDfbVWreX/0?=
 =?us-ascii?Q?PSPPUMw/TcsvV9kbSHB7f3eRDkWqIzNJgftcBNhN3d9uO3LHZIOGDfziZsGy?=
 =?us-ascii?Q?cOCbP7Zc+h2fer1J74bz+v3vxtlZMJIYieJwspKKSTCiK4iVrDCBAeuxM96d?=
 =?us-ascii?Q?JpcTGu0rB0WNYXe6BIFa2fkNsYwhZuRJ6UvxE9+z+xr8ck+sfjjiP5moPZCk?=
 =?us-ascii?Q?usfvbYWrnmymjbJYwqKhXW7ad9iBMCUzjJUMbiG9/qCuH7pb57DlqEHjDTF3?=
 =?us-ascii?Q?zYqOC8s5DGgC7BWsBg2gq3R3TQ1zED3yDhlyE7AYMDvNC5h+gaD6IzDrSpAD?=
 =?us-ascii?Q?FkfHsSegNF8v1YRpYi1NNgbsQBOQo1AEz4ZfmvvReJWAISHwjFTfKBqhdayQ?=
 =?us-ascii?Q?CSxNadnCcXsf4CPUlgVssX/FGt01XOys6SiMhiRZ4wjEaTvaWteP8sHGkV8P?=
 =?us-ascii?Q?Bcg+t6RMwqELRGDiQv/XN767rpVzWaY7nLHjLQn/z/EmAzFWl4EAcf9TNR+M?=
 =?us-ascii?Q?V7wZsvKKbdQtdLMsY6P4JGSPgE7VuSswPjue6hOsujdyHhqA+PmT0J5agRvA?=
 =?us-ascii?Q?EEqXOS+V8+iKGAiaJSqGe+lspxHTMcJ3saiiLp+t2AI6lPCgQnFlt80Pgo+i?=
 =?us-ascii?Q?TupK9FqHWg6PJ6OryLsAf9ssaxJYxWvWj8/Cft1OADimoY6Qpcx+pdXwvPm3?=
 =?us-ascii?Q?kxZbpChSuNIcyH8tO4xS3CHWM6A3ESi3wbOP4jZqUuONfcWubaZKbT5cKYDj?=
 =?us-ascii?Q?lZV0k7QWHQNSW660MV+1sb+GC8W5W5b7NhiZ1hnMpj4Ptyglvhk47H0HN9ZB?=
 =?us-ascii?Q?oEJ5rnwYripE07QTPSYXh8RyPOMSLoGV1eKm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bHNeGj2grG1NlD3C0hr039rTlT0VmgtqxMcU2mMjxsrJEGiVsznITgxXEZKH?=
 =?us-ascii?Q?2V5fJt8SxweCbZjvjzavnXNyUc2LupsyKBGYbdcu5b3foWJhqvGr6UpSCkfi?=
 =?us-ascii?Q?p68yVw4FjS3mTpAdI0s5bAgk3D4NoSL89SMqBFY+U9ADQCJ5LB+b87UcXEtc?=
 =?us-ascii?Q?mU74K4Y7MIqEdKFqVJmS7oTE8kIt68cFSToRJkE1PMU/kkbXflvzDopsjdgl?=
 =?us-ascii?Q?swY1qp3LlPRswIgt/f/KikIA+f8Xx2uR4MoKFoPuD7KSHqDtWDcoYKJsyq+Q?=
 =?us-ascii?Q?KIsfKIsD1fEiTsVxG3Fqvg4nEfqNZwYt2oyaQ2DLDhCAdqKAAtMOXCpLUJHN?=
 =?us-ascii?Q?Y3Lz14GudN/qeS10NbbQbujkm8y9R/vh8My43pwDGf6vbERKVvqyS0yHR9kG?=
 =?us-ascii?Q?R0R3ljdJsbSKL0/Ix1FtV+NEPbCncKR6sGGpwzwFoSzKTUJjwNlX/eAjDK8m?=
 =?us-ascii?Q?nUA158oYrrfXNkAhQrdCyqa0w+EZ08i5GcdF8ACwQXIWLq1o4L5GE8MsFtqg?=
 =?us-ascii?Q?Srf4nHTHLkQSJz5coDX9oKcIgscIeB/ZF79lkty7Jd3sPQxOniXmk49PvBqC?=
 =?us-ascii?Q?qsnBJ3W+s15f6+7DMJM/mUT1vK/A9pZINlfIcDk0WwOl1xn5eMJhCW225cXC?=
 =?us-ascii?Q?zVjqH60SsMasg4fx0xNqfIE6VR+hvtJFrszRX+FSU1+aRtMM+okb4/oXwCV6?=
 =?us-ascii?Q?Qzwhbp9Bhw7OlKgdRkmF/lOzTyUqev2C0w1SruKyMbNP780Z1/69MjN5D/TG?=
 =?us-ascii?Q?mucxd3tjIbeV5kGijWtlvRs9J2XHNh2/E5uRB5GkuJhOMmJWc9N9QDh+oBJY?=
 =?us-ascii?Q?ZZRd982hxckfkzSM57P9rUHXOZihB5FwzQYmzN1KzRXQuA2Ak/TiC+dkfoAO?=
 =?us-ascii?Q?Nsgex0yVK+Dx1uenE+VDESO5cNj/LuwDFfkzqc/qx+Z3JtmvQAB3lRhtlDER?=
 =?us-ascii?Q?ojSklTLKL1A2k/oaq/OF9gmtZlKwGGqYeATlVV1ltimHV6hX5/CaAq9Kmxq2?=
 =?us-ascii?Q?tI/PDjiD7PATNTgdboEDpjn76tpPuhxq6vpxl7Fsvdzw7El9dC3hdT6s6chA?=
 =?us-ascii?Q?m9jAghB84WRM4kGL7CUzEuY+3VKdef0jE5nZLfww8yRblUGry7qkVgGCaIF6?=
 =?us-ascii?Q?rukfvuUFvTPpVGJRRP077d9L1kIZE7M/lRI84wZfHofBp2ZeSAoy37jmPlVh?=
 =?us-ascii?Q?iDIACB5N5wo2/fjD9IeoEYknpnKtCFN6VlFMdXSlpVEcUTMsD4p4g48eWqqz?=
 =?us-ascii?Q?Sb+3oe9Uy0IlFVDxYOX2OjcQgEwHH1eEHZsvsDTzkO2VxxagHrWKCrqKxnY/?=
 =?us-ascii?Q?BAG4rMpOzg+tbqVn1t89YecqPzSGdJDsFldUuAK+uGoonHJZrScMtvQH98Vu?=
 =?us-ascii?Q?WJHZK48eSuYsYmxURQ3Td27a0I7liV+Ff6HF10/rYbvFzu3x/8jWULy0iw3z?=
 =?us-ascii?Q?EzbxttBiC1noeH+UvsBejWrvqCnU+Eq4Iy+Oz7NLw4H1JdIRV72JGJRz888c?=
 =?us-ascii?Q?CqnH6S0/iVPoyXwWjd6j02sQgN7B3W2P6gVPF6UvXclX6vPSzbHpQnqyzsxC?=
 =?us-ascii?Q?b8RmNEPaTe/bMKRhabbq+5lAl1fCrNeD0Ot1fI70?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae4cc14-8c3c-4211-17a8-08de25f3c8a6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 16:10:10.8591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5lTNBWOnLTr6M/xMEATOoFq9Ajzojk3maLMDA3ZpsK+EG4xnfupk/Zh1TaNEOHm4KrPVFx/7pHHaGV0f4Pwww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8811

On Mon, Nov 17, 2025 at 06:19:19PM +0800, Wei Fang wrote:
> The struct fec_enet_priv_txrx_info has three members: offset, page and
> skb. The offset is only initialized in the driver and is not used, the
> skb is never initialized and used in the driver. The both will not be
> used in the future. Therefore, replace struct fec_enet_priv_txrx_info
> bedirectly with struct page.

directly?

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec.h      |  8 +-------
>  drivers/net/ethernet/freescale/fec_main.c | 11 +++++------
>  2 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 8e438f6e7ec4..c5bbc2c16a4f 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -528,12 +528,6 @@ struct bufdesc_prop {
>  	unsigned char dsize_log2;
>  };
>
> -struct fec_enet_priv_txrx_info {
> -	int	offset;
> -	struct	page *page;
> -	struct  sk_buff *skb;
> -};
> -
>  enum {
>  	RX_XDP_REDIRECT = 0,
>  	RX_XDP_PASS,
> @@ -573,7 +567,7 @@ struct fec_enet_priv_tx_q {
>
>  struct fec_enet_priv_rx_q {
>  	struct bufdesc_prop bd;
> -	struct  fec_enet_priv_txrx_info rx_skb_info[RX_RING_SIZE];
> +	struct page *rx_buf[RX_RING_SIZE];
>
>  	/* page_pool */
>  	struct page_pool *page_pool;
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 9cf579a8ac0f..1408e3e6650a 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1655,8 +1655,7 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
>  	if (unlikely(!new_page))
>  		return -ENOMEM;
>
> -	rxq->rx_skb_info[index].page = new_page;
> -	rxq->rx_skb_info[index].offset = FEC_ENET_XDP_HEADROOM;
> +	rxq->rx_buf[index] = new_page;
>  	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
>  	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
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

