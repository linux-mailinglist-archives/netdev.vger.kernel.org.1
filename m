Return-Path: <netdev+bounces-116503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A294A957
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48FD3B287B3
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD352F62;
	Wed,  7 Aug 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oP4gUObH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BBE40875;
	Wed,  7 Aug 2024 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039483; cv=fail; b=MIz0VnWcNqLdGVJ3fKU38BmLnAP84PvyaiXlbdAh9YgnK+cxElfCPuEhItgB22VO8TX39QiUlkN3UDCIqSrqBU6t6cgSaFbgEC2Wu1YTcvC3Q6awA0gy7Yl3RpdcspOFaG6sb3CFZNm4uVwZtdQsA+cqgVsEb/Cx5TbMRHG4iAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039483; c=relaxed/simple;
	bh=7l9E5zMYzlTA6JpNphtsHrc6u3E+B2+vf8eW9kaRgXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NgNSNnHqTZAC/wl80EJj2MXb9P/cd4rkjzLI0tuXiadPUjf35qFLB7VFoOGxtnjO6w9/T+PQWFHmz/qZDnI9M1Wp3AdWq027+Zf9XM1Phz1XpaNmMJ1KpzRtANvFZg0JGRYQO+09rsSDBbIJDmrBYDvrnh1lrzeqb53ZcWAZ7c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oP4gUObH reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0JchCscPiS4qE5ljhPF0GHrZqR9d6YnZ+nDRS9fXEsuF0jwwaEk8YhpXGgWeU8mS71niAWqCCcf01yx0w2fIWnSK4R1MMJxCebZpmD6T5ZOSGt8q3b+pTR+1BJn+gh9Vij2A+LlYB2LI5KjVZiGa5O+1llj7J5GRzgxXnZARwPKwjqlfRBif9IrojvHjWHcsgJ/Fkd/eRIao/ge3YI6DF2UcQgkMGoA3nE2l+h7M0EYoNBsnlU9o9eml61jldw/ES4MG7KMmmOzoSgqv/PPBxsIsJT7Rm0tW5SJdRvIeumBpcCoBYsNs08wASp/gXkVKYDNIh0KUyTy0kOq7C8HgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/owP2YUA7BRlpU8TS0S7I7Ias0A9YuoG0XAoyhKqGs=;
 b=ImNaX+zdC6pdId02RIj2a6QRJAb+nv+q62ZZZig4+BPeH/XgII5snES9umU1yHDs/1lqHXjJ7vJN8iLX0ApU6N4o1mRkYZHuwFnBQGgoURCLyLQXebGwO9vbYsWTaRUgmWlpgGbgZtY887xLC+Czj+pMZSWsHTMCZclrtBJKuoaGLQ6Ss/CxzkANFZ+yLtHx+0d7rlSSDmRUGQ11MejHDb1r+O7hzGHNb9fgRUjH4HKj8jWh1fmmV3jVHFZSwOHONzg5XTsOLH7qLKnry2VuPccvMuFqTvMzOLIL3V5fGgnwz85wS94pldlIpoQ54PnLBLYBi4octA6+hPKlvkZWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/owP2YUA7BRlpU8TS0S7I7Ias0A9YuoG0XAoyhKqGs=;
 b=oP4gUObHQ+GvNyNsOFQXmI5qSOiy7b4UXTf51TAmpAoFrCUuP11PapTZQkYR4lp/6YpOLfSAe2N2D9oP9N51TPFUcQEZaAvNIp/FevOi7Y5ekTV7jTgrA4jW/p3AxcsAEKCv773HXyF3hzxut81+M01RhFjgO8nkCsfSQY5oSN+LoZRYPNyr7oSohMyn/SIjT12qQKKyrPgwLzIrapzcNcG/N6T35M+ggDSYIHscw3J534KnUr/mbu6EPKhClz5KJLryPi5Azz7kkAetsWNVCjXZlE9c1P4LnlwfOzB3qL1BHtuE2IA+x9EMMjcuVDXKlrHhLK1brQspEwbgslu66Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7328.eurprd04.prod.outlook.com (2603:10a6:800:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 14:04:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:04:38 +0000
Date: Wed, 7 Aug 2024 10:04:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: Fugang Duan <B38611@freescale.com>,
	"David S. Miller" <davem@davemloft.net>,
	Lucas Stach <l.stach@pengutronix.de>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH resubmit net] net: fec: Stop PPS on driver remove
Message-ID: <ZrN+7GtjxXa7tZ7g@lizhi-Precision-Tower-5810>
References: <20240805145735.2385752-1-csokas.bence@prolan.hu>
 <20240807080956.2556602-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807080956.2556602-1-csokas.bence@prolan.hu>
X-ClientProxiedBy: SJ0PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 72dfff4a-ee2f-4272-4605-08dcb6e9e03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?alpq0bBW8fl0RLJsKi7osHFwVvqWeSlHIbE+Cjr5SH3NJki6Gp1aOA2HlC?=
 =?iso-8859-1?Q?GvqXgW89/wkdLIDCwD9cefjpM7Ct6bwFdSTpqHmtjt1aK1yHiO3XyP9Cb2?=
 =?iso-8859-1?Q?Bhi8h5FXNawnn0i+WbSE9lYM4XOVToBFaFYGzsBokO2Cx7ScmAbblt4z6A?=
 =?iso-8859-1?Q?6MzTHDLnK64tZGOCu0TsGHOnuY7VcsrWufSSgivNksmzXRkDo07TqsFIUz?=
 =?iso-8859-1?Q?QxQZGoFvVbn47s0BUxBLyX0all/lXZW6/NtIAah2RP9LCvH2iu1FPpT8Ok?=
 =?iso-8859-1?Q?6+/OU28ZPLlJCG2ky6iH9uzaQZKCtO55OuruYVqG7EGQ77dGX+fsZKgM79?=
 =?iso-8859-1?Q?qCUsK4HQi605IW5YEBsZ8ET89ZwyKjj8ceyC//dipsSjoZRyM9LjBANjN/?=
 =?iso-8859-1?Q?kCyaEOZiwF2jg6rTz07yN58K/XWpvmK2jRPPv2rHr8cUcslunvwFKIGVZu?=
 =?iso-8859-1?Q?ggB92cUtvqw9UTTjgz0BJHkRzizX15FpsaBz2eey2nOMXWOAK23pcOqi75?=
 =?iso-8859-1?Q?2AGWC8bMCUkD6OgPTIFiQBuqOg0D2MmnvcAQEYDav3LRK43/bjr7E5nqmN?=
 =?iso-8859-1?Q?M+0mRmdyeU4Uk5YfmxnYuC2D07GPQoqMM5Vhh3CZQnRfb0gU8yCsO3BS5J?=
 =?iso-8859-1?Q?juiI3z3zK0N7TsaEvcz4vfarFQFHt1YPNyVPf1miuVxLUYWnLXdQAzbHJB?=
 =?iso-8859-1?Q?iq/aKri0AqLJbX3dzcuNOGMxRxKvriBGzfz6BnWExeGeisLrRSTNpr4AT5?=
 =?iso-8859-1?Q?h7LvgfGft3BfCJMuBMbe6HGfqaLyxOYXFuZl9bVCWaxWQmucNNHwCV0RUS?=
 =?iso-8859-1?Q?b+55PH7Xsz7++P4wlOepMnNzoSOefhf2F6V5t6AEweV8gm08UaRZpwpoc4?=
 =?iso-8859-1?Q?TSX8tOtl+RtoN0y2XWKkevaVXpgrWt8rL/InGUoCAdUTVFW9TbwHtnBSLo?=
 =?iso-8859-1?Q?0ndL6Ur5BzByKP+JZwq3kuAN2brWJofwOpa3IZ7HAe8/JS5M0odB1Efugn?=
 =?iso-8859-1?Q?mxXcbAZ+t6Kloo23jPIQjGrANDTSKLzAZZ8gjODwL4JTaY94k0BFDUS1+V?=
 =?iso-8859-1?Q?3o4I21WGtU86gkYYqkhUkWnu3hzgkDyFnJZENwsOk02h3KTQVKxLoyb4uQ?=
 =?iso-8859-1?Q?oI5QyTaASUow7/pEZtZP/yuY+yRXzg5QRyZxHdOlEozMEJgpXT2Bzf7As8?=
 =?iso-8859-1?Q?iAS56cK3IFoZ3SZN3P1tpBsi3TnZoFEsjkzHorKdoFjTMvuK9lY74uGz4f?=
 =?iso-8859-1?Q?16/RDhhEl2thHpg/OxDlcvGDV5mijGRRDe4YizvusS3mS3Ym/2UBPI3QxF?=
 =?iso-8859-1?Q?zKdY2I9kt4Hn5uZZTJpuOUhv4ImoAK44MKmfx7NJ0myg1tyFYkESH0clUE?=
 =?iso-8859-1?Q?Dm/senJQZOPIV8IHVHoO7UkuoPs0D9Hm2XGf3JrcMPb2orr3KPfg0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?dhulb1CuKNL4BYSLRpQGPG5l5egee2nAyptnNLRKbSVHB5n3V6swm/1rQ/?=
 =?iso-8859-1?Q?rafSARwOoWmOHtL8P9SZEugKUq5UGgLVyWOiQ0jwrX6rESmi+D3YxWlO21?=
 =?iso-8859-1?Q?Bjv2woTAvr/7+A6Zon89Efga0kiZ1A5WoDMbqBtXVvMr7XE6eZcVvZuIer?=
 =?iso-8859-1?Q?xnipGK+Dw8KPDMDMQtCIqTU/3Mspmj1wWaxdpbM1kbx8hAbnIvhg5A4nj3?=
 =?iso-8859-1?Q?hZocpecxA1mYKseNddLjSXy3N7WMW37HOndZ18DnHYePgEhH6Tf44DtH83?=
 =?iso-8859-1?Q?5kvG2mrM2aHNDDYT4yMm+GKpjG98c4bSPNZW8nBLtISYVIcL9C5TOYQBq2?=
 =?iso-8859-1?Q?rNC5VHwzhBM6EWwUczUaiVGcLp7zyHCYIlN76Q0JLsV3rZ50LjahxwUUkq?=
 =?iso-8859-1?Q?7sfcL5z5z9MrZ4FAcYcRpsgKl7wYVrccHEv2OimTUuHLmm+q8zkN5TcDfx?=
 =?iso-8859-1?Q?WDWnkE2aqla64GLoBNxuPAwNM6j5ZqwJnXj10NdCitJSPl7dyPolIA7ttJ?=
 =?iso-8859-1?Q?+pS0ivmOcLXCyEhUH5vCRpON5E1qINNFHy+jBuqpcNg6tIkkea9tetNiSg?=
 =?iso-8859-1?Q?ATOLRgMyV3eLkoRYX3kMeOECL9Yz5hYAGweiITXfxLLjtzCehOIxteyc1E?=
 =?iso-8859-1?Q?darVHnGRnu3668SGQlzM16fhiMe4TQEG0mAAPXvp6l/+oK5y4FSz7y/OyI?=
 =?iso-8859-1?Q?PaN/6dK3/x0qbaoJN6PBjDlG1e8+8gt9IbmryhRNCkEo/a05uCCvEDCJma?=
 =?iso-8859-1?Q?EiBecV4/bbqOWJv2Kr8Bl7wtIqpP37GRFAXIl0GX6GbVdHiwxXBhCFxQgr?=
 =?iso-8859-1?Q?3EhOSd6sHakANKeJTqWny83/bWyF6S3G6vMMapjy/iD2yM2R+xu60jrRG3?=
 =?iso-8859-1?Q?JerHPghcLK86O+U0rmqgBQzUX7cdFgkc/rx8bMGR4Y/W84k4Wo6kQUbjgK?=
 =?iso-8859-1?Q?FDvjjEDPUCuGPAeQ7dQtmCVd0QW0pEe0V7fS9Kz3tKntoStUqBcBPcuRcw?=
 =?iso-8859-1?Q?4Q4iyWTTU2RxSjc+EgyTDJupv1zGoOu0qrkBAqKhlesAR6v/0Hrm7JqPcU?=
 =?iso-8859-1?Q?9sFcKpEl0Lr7T5FNB0BjLfDPvR9LAFOLxj/xpHxGEMZ664hyTZDB7VZ12J?=
 =?iso-8859-1?Q?LxjCJ6/8V6zv0TcsSbELJeHYCf1kR/SPgS7Di+cl/LU0GJ7zjpPPcO1DY6?=
 =?iso-8859-1?Q?FpyZILbFih6SOQAifxozJnO10eMXwwEPaeX+HUIm1FiSjzE5rlU+NxS6x4?=
 =?iso-8859-1?Q?Z0jsmSCrCoviKOl2X4keeC7PMxI4bluhB+b81Hmg04ErHAlz5Xkl3mYI/5?=
 =?iso-8859-1?Q?V3IsSfUHJzNgTNbnwv9rslzBU3u92vm2PFqvt3/S5u3zqXim8STw8Ryi/d?=
 =?iso-8859-1?Q?rllNPhthO1d1OocgbrqneJ9tZZbjOi8BbIvmWXYiw/e4Cn2qnlYj0otLsq?=
 =?iso-8859-1?Q?KsVWe9q5ZcDKlg1RojZXBge1cpKyBQeh4Z9/aUJoilqYGvlzg5pyiN12Ck?=
 =?iso-8859-1?Q?1UDn/HhH/duR3eilZ0GYBuepkTOTMhkjJHnaQHCZGYDoQar+oFcr7Spk3F?=
 =?iso-8859-1?Q?hRclYhYbO/gmmC2kckwW2VK6JZ6NjGkYfQVRGplqG6Ot3cFAAUvwrSqYRW?=
 =?iso-8859-1?Q?LJ9u6+RLJDJG5qEKgKkl2vJ393Szf4tCGl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72dfff4a-ee2f-4272-4605-08dcb6e9e03c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:04:38.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkkJ37GlNxavLjO8/xyOiAdQC+xlWAEtNKavWYfQ+OGr3pF/BmZyx9/dGOoc5DabOLJErvWNilJJ/C7fVMt/BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7328

On Wed, Aug 07, 2024 at 10:09:56AM +0200, Csókás, Bence wrote:
> PPS was not stopped in `fec_ptp_stop()`, called when
> the adapter was removed. Consequentially, you couldn't
> safely reload the driver with the PPS signal on.
>
> Fixes: 32cba57ba74b ("net: fec: introduce fec_ptp_stop and use in probe fail path")
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Link: https://lore.kernel.org/netdev/CAOMZO5BzcZR8PwKKwBssQq_wAGzVgf1ffwe_nhpQJjviTdxy-w@mail.gmail.com/T/#m01dcb810bfc451a492140f6797ca77443d0cb79f
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index e32f6724f568..2e4f3e1782a2 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -775,6 +775,9 @@ void fec_ptp_stop(struct platform_device *pdev)
>  	struct net_device *ndev = platform_get_drvdata(pdev);
>  	struct fec_enet_private *fep = netdev_priv(ndev);
>
> +	if (fep->pps_enable)
> +		fec_ptp_enable_pps(fep, 0);
> +
>  	cancel_delayed_work_sync(&fep->time_keep);
>  	hrtimer_cancel(&fep->perout_timer);
>  	if (fep->ptp_clock)
> --
> 2.34.1
>
>

