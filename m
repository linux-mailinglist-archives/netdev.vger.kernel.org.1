Return-Path: <netdev+bounces-136376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E269A1891
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 04:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ED41C21FC3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 02:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE4640858;
	Thu, 17 Oct 2024 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fJqWbRI5"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE431EA6F;
	Thu, 17 Oct 2024 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729131881; cv=fail; b=s3l9utKfN4735wRU05R7+kf0uGh8cFUJ5s5NxHcFckdzUJiORljSkgARtcaPLHOmEt04YRmX3ZxKmUMI/Lzjy0gdpPAcVD6okpqyKfiRSS5Hm+3T08hYFopdtbPm3r4DKBa9iIth8Pb1pjqiiK9bE0XiMSG26WfRRG7ltueCvH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729131881; c=relaxed/simple;
	bh=TulYL5x0MOUBVTbIwDR/PCIq1wl9Do/zjjNzvecPgQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lPVVSirRVaWAuVihqr5yuXgdx+fF/Cn8cf0Zs36WE9OcffXlpdTaVIGOww5N05NHT5nrPxLjCpdt79PxwY78ELTPXOfTGbB/gKnHD3oX4LNCBVVw6fXraSccQCXuqzRdsnuDvTqkezgvv5uTNCrBN72J+cHqmAK3Xa6vHwrMnAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fJqWbRI5; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lms+X/htr1YcTAjS2mK5PrgVu9HgHDm2YaEWdng0NtSRDPwWHAoQXvvaPch1wEcuGDS9dqwzFbFW1dVVsCzhwyuSIrv2lfYMvDpzoJ1sBpOVH1pPwCYKXnUpS3ZQ+fPAuqaecMc/MDYiJBOe7/gkfMWg5lyEGWJEz/MmMg+7aJKK/RPanNZg8S+EYCkCNWR8V/DEZEkW/hmvTJ4FYsZyXDlQ0JmdfotmpQLKp6hxUWSXeaETEAEQzZhdor2SRszX0JA8GeQdFVZ4IqjqIvY7l6GM5+5vVmhqF/GppMKVVazldmaT5lLqw+WmXa/zc0BuNK/3+wM7DfN6OKEND4F9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erPS8w6uA9Uy8aj6IjLCDvmT0HR3sUP3YsQx8Xbu7kM=;
 b=do6I8Luq+WiOTP5r16rpVcTd9yqwSBk3CvlU2nreA8ycNqveDTvMvm3NJxWy3jsAupKkFRwTgDu99vK15QFjHgQubb4GXUCAMq9M3dA3LIda4awnHJ6sUYvQ6eZaXPjbFOiLpu6xnZZsAaefSsY0xOJ6jyDbEmDtHlO0Xr9H9rUg8DsotnUsXTYMpeWEq7tV+URmEQJYNpx3Mfw+3bzPiI4nYZvS8JMCCyw63jywLQlXtVmoSttyZrS654Z1cgBkQ8+zriQ9ydGZNGyVJuvIKMhDMLHnVb6btDlSLUQ/m78ysiBns9oiDYsKL7Lkt4dsZmbZ2Ar3IkbUAVITw4M08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erPS8w6uA9Uy8aj6IjLCDvmT0HR3sUP3YsQx8Xbu7kM=;
 b=fJqWbRI509WN/3uRQZIl5/xSGluoYcfM8v0y3awXv4yU78+lK0o/rPCKjmlsmqkbJX63MmIls7YwOOS4agTzXE/cOWYWt3gsoY98CgAVCKzJszgHtHxvJeoVunVQiZFPxuCGG7Z5mJhSQbSjet5HvAbWFhEUqocH2lSP3fXPeXH/4tMaL3fTr8iYeC3KHv9NbUFwWBcLnJOtxCAXv97NNbmaPFoJ/pR7pCgQ24eJZY6LwcK00jDKkL0ugPY98+0H5Fov0/I+1YE5eqvzHUvotKuNauxkYf3IdcAKpTxJ2WM0DAwa0iFaO6eDikKP+lDx4r+j1+lZ3XGCa80RrqDYiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 02:24:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 02:24:34 +0000
Date: Wed, 16 Oct 2024 22:24:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 08/13] net: fec: fec_probe(): let IRQ name
 reflect its function
Message-ID: <ZxB1WimVd6LpaSXR@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-8-de783bd15e6a@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fec-cleanups-v1-8-de783bd15e6a@pengutronix.de>
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 4333d088-2d88-4ccf-4e83-08dcee52d73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WDwghs2HF2bVGxX1QBOGILPMsIaT2Ujfj8hJoAMLi4637WPx0NncyXWXT2Vq?=
 =?us-ascii?Q?0k5+vkaZEF3Mfg5cE/x3Sdyc2upW+bbB00mGntZ2YGbknuDnty8uRDs/WTH+?=
 =?us-ascii?Q?7PwwFoOsA8ZDspF94puLcHeK5oaR5niY52RwFLJTlxnds+msi8ixwqZT3tRU?=
 =?us-ascii?Q?MvjwNGHsoCvUxHiH4BM/znL/VNglSnf7K9Jn9vCP2rPFLzK363p9lh2VXkeb?=
 =?us-ascii?Q?edQXIIC3VVR0RUppgRkGiVP8kadgMT35733xJx98zqzNjUI+F9q4NZOdAedX?=
 =?us-ascii?Q?cPxDNitWRf43KHhI/C8xeOC3A46RzlLP/ItO/UB8eMSwn5wphEtpfRIRA/DS?=
 =?us-ascii?Q?Mu+aVYPMGmDITZwusnyykq1XZeFYlMG/b9DF9/wvl5LePmVMikWBL9X+GQV7?=
 =?us-ascii?Q?jK5Xkg4FliWKROtvcGs++NpTOJupmu+jZ327Yx69t1M1pRGKmRRGsBmvqFTp?=
 =?us-ascii?Q?hYPBEF5zeEFCv4hpbtgqnr4jwHVf3btUOWeNKeOmRk/ve60IUkG7k7KpZNbn?=
 =?us-ascii?Q?pHYAfn+YCrJyLyZ5fYd7WIZmzgnE4pggSvnAxqgAZZIVt59Ppytdkdz6UFDT?=
 =?us-ascii?Q?6LqlKunOu/4HwuELONF32TGRet/MJ2gOa8pWkeclHVKSXlTlJDqbbK9O8LG6?=
 =?us-ascii?Q?fqiL6zoTN9XDXbl1/0srM9q/kFy0g30CvH3eKEHRxuyEV5Y3awUbDUOIwfn3?=
 =?us-ascii?Q?hCi+G+WFoLHgenXaDYVmlWJ00XcKR4uUqdxgPsDuwj7RSatZw5G0+c2cLbwu?=
 =?us-ascii?Q?pnMS+gLcXrpn24HbU6N4dUbK9FtHo8IbukLnEKJCUrYCB08QC3IiDazxcYmJ?=
 =?us-ascii?Q?IXfF/1tcENuM0qhSTKVXbsKiuDluYehPfpu4aM2reDYU1xv6w/1EeEAk+ihl?=
 =?us-ascii?Q?gk7HvmhDgiOKw/O0iSizIRRHrwusDz3FhZFubaibZRdWYzvzzs4OQc6vm/qY?=
 =?us-ascii?Q?8CDxIDdiccFy1BnVNwZVT2d2OyVr6UR9S7wBV6VMi0QUOuED0phANEGb2tYm?=
 =?us-ascii?Q?hmRZ9Ypu7BPM336R0FVpIsynVor8ATKjyB2yQ7ocyj4veWM8eUj68joSCABF?=
 =?us-ascii?Q?8qkekbV60zVm7ARBuXdu2cCTTtlgPDYo9+tl0omExsbzCQweQg2NzaIjlu0+?=
 =?us-ascii?Q?0hL5rDlYnflpvkVF3hmsYZixFMe1D8Y6CBXr2jGQI8H8OEPDPAUBv4c6kqgo?=
 =?us-ascii?Q?mCHQAzsAVn474x7L9T2fekfufX1UPT9Lu5llbKN5RORZJ3TMovmECapFOcxm?=
 =?us-ascii?Q?RvRIOL/kXFeCUizPuj+3L2QFt7e7DoCIYn0bGmeKBDJqC33jSfbbhWv21hKs?=
 =?us-ascii?Q?kny1Y37xF/uJSkA3vvsP/4S/QDpatmzuvNInvo/P+S0uj3ttg26PU+3/6xYa?=
 =?us-ascii?Q?lY74wlw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ca3LsiQ4pgf13IiFTap29GQ6wGIMeX+rq8Ha2zZre/mDoBK1SSe+Uvpj+G5?=
 =?us-ascii?Q?p8e/9arH7g/665ENxKmtYQQwJhiWy1mS7/WcxAT/VNOH/PbzSZ9RhkDXzGbg?=
 =?us-ascii?Q?0Cr445YWOexNKe6pjMV8fODpP4H4863zSmgZGrfCdRT7n4dhUTmM5s1wgm8J?=
 =?us-ascii?Q?IrGohlMs+d2dVJ2ztOYEfEiBVRd/kvRbl2YgbpJv+KIOYqszjgPB5R7RYy4q?=
 =?us-ascii?Q?PXLqPTLJMDGUfhf7oNh1mY/9NNwy/A0v7DqiZykqd6ILyt6ZqR/48tRRacUS?=
 =?us-ascii?Q?i/GGwoK1ujKGXcDLvOBnXhKkdGNz8C+nYPtSZtzOckJMH42FG59pVaf8m/ye?=
 =?us-ascii?Q?1sCJwqEmDWgJv7OVwi/y8ECPsD6D6Zz/IPspUsBzzze4ToXkJFyiWZ+BC2Ji?=
 =?us-ascii?Q?88MRCWrGsf8FkJpeOU16FHBJmU+7VkF+RBJjLodl26BZUyfEFtoNVohY6iYm?=
 =?us-ascii?Q?GgYHWy/FT3iP0VNtIliaWtJNo5fIZ2ouHopNx5G8bhxLRfIcSso1OnNSUHsw?=
 =?us-ascii?Q?0XwVO6WNL4j5NQjS/NjlZ81WipKW5wcQwCbVq1DZW6NpRqWRLSLnFVuWdDTb?=
 =?us-ascii?Q?aJHP4n7biVaz6pmtyICbZSADI4R8SpEABOv3ACpyrg7ZfwE28aXIYanfkpnd?=
 =?us-ascii?Q?TH0qthtG9Ke2i4e68euc92iTOLn+2gjyXEOuuvBuXl4mic+E1NOPJjOn1d3f?=
 =?us-ascii?Q?XswzSfHiE/0KWDP9C8+062qxy9sF6Buh2WUZGhfQ7Onta+JtapvjXYnj+KBc?=
 =?us-ascii?Q?SELSskY0Ekc5ZoRlqPzJ8Gpw717XP+mBRYoeqigalaVIyyY+H9QDbuycob71?=
 =?us-ascii?Q?70a8pJZNmzRjbsXT1Es9d41vsT7PjPpfPVlWmAOZXJmaOzNEIjV3muzA06kO?=
 =?us-ascii?Q?ryLANQbAzuhcUpUqam2ky3+QBVgEc4p/SwC0H9R5hs0g7coS+vVu/ReH9KgV?=
 =?us-ascii?Q?ndErs5sMtGSwWMshv5Iu7Rso/z45JpGMC+J2VZWEzGRYSFfn397wzcSgkVV5?=
 =?us-ascii?Q?Y/+JjrXqSH00n8AkypTwJeGFvd9egxHonreiUkWLBkc6IrdKnxJ6WEeXsKYY?=
 =?us-ascii?Q?JV3meekFOg+ZoDJO85fTjLqmZmZ81JHBKM9DA3+oPzeQTt8BDm/grxop7FRH?=
 =?us-ascii?Q?Cl3pg4mJxjN9LcTRny6XTG6cMbsq20jPvzIDcV6g+rW5nNGKUaIjOACz05Xb?=
 =?us-ascii?Q?zeErb/dpCwnZ2h20vClUX15DADqOAEC0mbSdIamVlk1RviqCZpUmgonCZBXv?=
 =?us-ascii?Q?VfnIUiO+evwi8Mjl00jTRIakSw91PPOU2gAhUTFrZziD2+h4ndbuExRAR0Dx?=
 =?us-ascii?Q?iEIvxqM3VNU22vQJL+ZIxnzgFYt4JKs3teQGWs4D0uKQ3UHdlYNxgg0hiDlD?=
 =?us-ascii?Q?aZHQJXqnpr8pGqwbkrk8ucZKjDrRU1GyWjr/bviIxyxoBQx6QrKAd5MX0tmi?=
 =?us-ascii?Q?W4XOXvIr/36TEN84D7ZR+vo6J06ZgmcnNvkvw+dKyt78A2jhzQ2gawNksqpn?=
 =?us-ascii?Q?7NKu0lv0AAzHFZRSnZAvMQA0y+tX0n61x8vgVGIP9XaBmRS1x1fl8Svpzolv?=
 =?us-ascii?Q?IGEEuZlw3SbFApoPx7aa1a5uGdFhj4ROeO1/+wOS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4333d088-2d88-4ccf-4e83-08dcee52d73a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 02:24:34.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcNU+ZwB70MPQvyAlKarUV3IdZMUwxtwxrPiDhzaCfC5cPkenJZt61d4uToPThDRoFGWmvJwTU7RmcAbwJBKqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

On Wed, Oct 16, 2024 at 11:51:56PM +0200, Marc Kleine-Budde wrote:
> The FEC IP core in the i.MX7 and newer SoCs has 4 IRQs. The first 3
> correspond to the 3 RX/TX queues, the 4th is for processing Pulses Per
> Second. In addition, the 1st IRQ handles the remaining IRQ sources of
> the IP core. They are all displayed with the same name in
> /proc/interrupts:
>
> | 208:          0          0          0          0     GICv3 150 Level     30be0000.ethernet
> | 209:          0          0          0          0     GICv3 151 Level     30be0000.ethernet
> | 210:       3898          0          0          0     GICv3 152 Level     30be0000.ethernet
> | 211:          0          0          0          0     GICv3 153 Level     30be0000.ethernet
>
> For easier debugging make the name of the IRQ reflect its function.
> Use the postfix "-RxTx" and the queue number for the first 3 IRQs, add
> "+misc" for the 1st IRQ. The postfix "-PPS" specifies the PPS IRQ.
>
> With this change /proc/interrupts looks like this:
>
> | 208:          2          0          0          0     GICv3 150 Level     30be0000.ethernet-RxTx1
> | 209:          0          0          0          0     GICv3 151 Level     30be0000.ethernet-RxTx2
> | 210:       3526          0          0          0     GICv3 152 Level     30be0000.ethernet-RxTx0+misc
> | 211:          0          0          0          0     GICv3 153 Level     30be0000.ethernet-PPS

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 9 ++++++++-
>  drivers/net/ethernet/freescale/fec_ptp.c  | 5 ++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index f124ffe3619d82dc089f8494d33d2398e6f631fb..c8b2170735e599cd10492169ab32d0e20b28311b 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -4492,8 +4492,15 @@ fec_probe(struct platform_device *pdev)
>  		goto failed_init;
>
>  	for (i = 0; i < irq_cnt; i++) {
> +		const char *dev_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-RxTx%d%s",
> +						      pdev->name, i, i == 0 ? "+misc" : "");
>  		int irq_num;
>
> +		if (!dev_name) {
> +			ret = -ENOMEM;
> +			goto failed_irq;
> +		}
> +
>  		if (fep->quirks & FEC_QUIRK_DT_IRQ2_IS_MAIN_IRQ)
>  			irq_num = (i + irq_cnt - 1) % irq_cnt;
>  		else
> @@ -4508,7 +4515,7 @@ fec_probe(struct platform_device *pdev)
>  			goto failed_irq;
>  		}
>  		ret = devm_request_irq(&pdev->dev, irq, fec_enet_interrupt,
> -				       0, pdev->name, ndev);
> +				       0, dev_name, ndev);
>  		if (ret)
>  			goto failed_irq;
>
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index 8722f623d9e47e385439f1cee8c677e2b95b236d..0ac89fed366a83bcbfc900ea4409f4e98c4e14da 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -749,8 +749,11 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
>  	 * only the PTP_CLOCK_PPS clock events should stop
>  	 */
>  	if (irq >= 0) {
> +		const char *dev_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +						      "%s-PPS", pdev->name);
> +
>  		ret = devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
> -				       0, pdev->name, ndev);
> +				       0, dev_name ? dev_name : pdev->name, ndev);
>  		if (ret < 0)
>  			dev_warn(&pdev->dev, "request for pps irq failed(%d)\n",
>  				 ret);
>
> --
> 2.45.2
>
>

