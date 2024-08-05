Return-Path: <netdev+bounces-115828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1AB947EF6
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199391F22E8A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3C15B0E5;
	Mon,  5 Aug 2024 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IM+SWoFP"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893651514E1;
	Mon,  5 Aug 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873935; cv=fail; b=VfULDmIxcjTh0CI6AYjbENeQCBi8e4VHW6/m9U5vR5r7PR+8mLzPhYSCFOx7wl5zkAFDwPh2nc+Pb/3cIkLXlzkLIhOdPKqs33bb+vmQnNGVHKzoLCrqMdN8Hyh/YoSeAk5A3J7kuZ8sdjXvKD2gX2g39XYo1uwNcgI154Yx8K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873935; c=relaxed/simple;
	bh=GZp29T9ewO629G9OQBz6lig16WeBcaSfJTMkUZLoPwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EtszocVo2eW9pWK6wQwksz/UTT5aueMR9+52+1SCe1GC5+Vbmf31SezjZp0ypLInxJorhws0vAO+g+QrDoYpy4Y2quMpohuKbohQ7BeV5a246C3JmwmWzc7qMi5xFGoM2i18QxK2eGTv1ucju2un3Xcp7iG9nE9Py+r5v7HOcgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IM+SWoFP reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgH8Dwq9vdqvzLIZs8vzfUdbvQZWZlQaeFakdZgymkY1HFTLgQn2bg1l3znAvygeVyMAswlXukMvA1JafFb/Cv33tozjynybLzNkXS2CPAr/jxuSSuLiCxeJO6EMcWKoq/8+2Hk7f8oa2afyUvsK7w57W4vTvsWvBqP2ofAjKDFP3eHBEI1GoG21Rrc6AzkdZ5qUog3z4Z3BNerxL8hzZjoD/HCDgVefcakBSPMTX//juGnrMbWMlGDZTBL/9fmE66sMLI6wldMjtCMq6gO1QmSZHxkl+9yvaUaY3Lvw73tE0tcCsRmVsbZInOXbFQKYL8w4/p3n1mCn04qhaugxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFRYROsoqTKkFIxxT57+1HKyvDwiohBNRdTVu1t0u4U=;
 b=gp5tTRgJz0BtZv3r/vsP4AzibIvffbXcQKemrXARboaWWA3osp6GsopGLLbVg3DWphPpFDPI70cLS+LvkBV5zqh1S71cD1AcPGVLRbX9IoAFiObLhX1KDqSTx3VphK1ChizoISrikK1ACqQDC3hT35aIzUHxlEmBTB7lKt+q9oQiN37+iFJf6jAZwSl8PCJSzgNhNtS9T/k5DOn3CVnA3JbsspCSoQPqQ/nOAg06wxvgez2ZxKR0utcO9A3rceYwnREgunUFq6inTQ5SFJGUm3ZVtbNGrqyGnNYa/q8Wzki77sJUyMkrVoS3Fh3xxtrx9oAKU84/qNH3dAo76RPCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFRYROsoqTKkFIxxT57+1HKyvDwiohBNRdTVu1t0u4U=;
 b=IM+SWoFPEUyIKX3SQ67ozbxU6rkR+slx4ICL8VGOKV/pDRJPvYwgEPM/354hd1D0MAiofMkB5jOK5EfZaPVl6ZNVy6h2Rn7H9du6rY3HffB/EZpzz0gqclVnHx1Bsx2TGSsBr985GPGvm71Ys2iHTW6s/KJDnnfqi0AHdW+qIMqWlEoXM8g+BTi5LfGn0Y1G4rMMeLV/mTaCjuc7CGVwEx7W3xVi8Pdyk9HcY9Po9svHI8Jl9n0NntOSD8RZE2dvNCSrn7rQSyhoeIg4+TCglOkF2GoNiZCiB2o0TeDPaOLpJNsJPuOiEf7h0UI5Gd7OX2CyCiUO41Yb8Z/PIq0bEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7503.eurprd04.prod.outlook.com (2603:10a6:102:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 16:05:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 16:05:29 +0000
Date: Mon, 5 Aug 2024 12:05:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH] net: fec: Remove duplicated code
Message-ID: <ZrD4QdO4Y20rKOgN@lizhi-Precision-Tower-5810>
References: <20240805144754.2384663-1-csokas.bence@prolan.hu>
 <ZrDwRBi8kS6xgReQ@lizhi-Precision-Tower-5810>
 <1b13b44e-54b2-4b83-9649-18f36ad3bf8b@prolan.hu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b13b44e-54b2-4b83-9649-18f36ad3bf8b@prolan.hu>
X-ClientProxiedBy: SJ0PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: f563d0f3-f3aa-443b-75a5-08dcb5686d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?TxQ80lOI3sSYXJC9jvW9AGN0qdo4gDq2iffLjuxW8rtZNaClEn0jEY9w0Q?=
 =?iso-8859-1?Q?ciIZ53BxPWih1dM/8h8HmnA2ZLHYVfAJFrp/1NHFmXRKZ5qKtptwlE1pJk?=
 =?iso-8859-1?Q?HiT9JqL0M5gW3eGV43qAttJ2AFBIdyal/dB9O8C5q9Jp5WOqUKhkPjEBZW?=
 =?iso-8859-1?Q?SG2ul74mVgpi57Tlim/NhkFlKXbCiiWUNge9fKW/9t2gtHBSYQTyVy3gXv?=
 =?iso-8859-1?Q?kgreceuLKrljnM6UOC9s9Tg5XDxR3SQudrUJGhVQDTBrxWCwCzBortqHqZ?=
 =?iso-8859-1?Q?wLeLnBUI4GXQ+GuVedSmTR9GpcH4w6HqqOmtEru8p2iPKNyDLM7tDjDstf?=
 =?iso-8859-1?Q?0PWFCamU4g7PvsMZNektq+qxt0yVYRpzNMSnIyBFnYAbNjoY8cCGafGOxS?=
 =?iso-8859-1?Q?HhOP7TmTDiqomJxBgZSyav8wx0y0ezSE2Zq74k2AN8KjQQwKcNIE+Q9wf9?=
 =?iso-8859-1?Q?sRcYNcLOYYP78FF1LGp9DUCchYw3dviWHnQK81O1VutRkP6j6eUj7Cb+iO?=
 =?iso-8859-1?Q?gMbHeDEQOEIaAYEulAVl24TWh/p26ZWEg0sO+vTHZ/bBa4igEj5hJ1Pe5C?=
 =?iso-8859-1?Q?JYF9zSFaeIYO5irXz14vNusLfLrmWg50Me8iEM+ba1PSUrkwxvVsRhCqD8?=
 =?iso-8859-1?Q?aZZpX8bU5hEbba2yrGvlcUYOAJJ0O6wAPQgUVg/i369ad/noEyaJj0YOyJ?=
 =?iso-8859-1?Q?ESJLc2k0Nt+oDfLKdTDXeNF/mVWFYNXs9uLG9IjvIbkyvL5D9rPtIpwyN+?=
 =?iso-8859-1?Q?ylWzvwncbuOJB1pRbu76nB0m+T1SJcZAyuFtDXKyg92xeS3fy7pjD0g4tF?=
 =?iso-8859-1?Q?6GUgTZcJK8knu8htgSSBuT1NKgpprEp2G2smS9inkj6Wjw6cEu4f1H2ZRY?=
 =?iso-8859-1?Q?B7o61PwHqXiYLTruDkRP3w43GLggs3PtWZFyw3UE4OKpw82Yz7YGgIPx9t?=
 =?iso-8859-1?Q?CriAzilTkqWT2kjy3fD4e7TFRfpFDa+AtX/UzguMVsyNhZL8laZ+hofjPz?=
 =?iso-8859-1?Q?vbImDaw+W0Q9rXdjoI6wgYIWyDKzt5UVC/9jRgXOM1uK+keCkZwym6XLzl?=
 =?iso-8859-1?Q?2gvbcDyBnwpHK/z2d4Dex8Z9VDKQBMZ6LD062FR1DM2SoN8Z/EPPQNp4Oj?=
 =?iso-8859-1?Q?fqKBZg2CKxYHvFP9Jq64FHBr0L+0ntq4+IVKPrDdBQzndMV9rJVJ9ivTXP?=
 =?iso-8859-1?Q?vKZY17ePDsa2hBkTpijdkqBvQaPdzF6pGV2RSRK8Sf54PQAhRO3yNKwvpP?=
 =?iso-8859-1?Q?1LJxW1o3vKXToK9zqmXDpv/5q2GAUM/KTthFKkgDiwVRV+oCKXOGqRkmlN?=
 =?iso-8859-1?Q?MyjfvbebwO/kkb8Y5/yHmduu1i2XnbapByjq+/h807nSCYKl5GzyinIFSY?=
 =?iso-8859-1?Q?mcHiKnYrJGDSi33n6L1/dnfAd/JpyODNOuVK3YqY8pJ7efcS8dX1uwDjJf?=
 =?iso-8859-1?Q?I+DnapRydDwuopkJ4f8PfVergxk/Tb3KpsvmkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?P78qVg6N5FCueMFdR64I9n5Y33zAxqF4qtTQUJVZpPGZjrQjZC/rdovKdg?=
 =?iso-8859-1?Q?xpCuQ+uG2BqXuiHdwwtK73RAACu7Zax9cSRMceh7we9SAz5+kRNG+6eVqD?=
 =?iso-8859-1?Q?gKDbV1cdlKbuPk8Gy6UsWuZVNcFnFxmXqoNEHoAwXShJ0MSEzlti94jY0Q?=
 =?iso-8859-1?Q?FEQZQiBrdAn+ivLJ4AyzAr1G0EqTIhAMioJ+EAL8g88eb7IEP5ZT2lnMTb?=
 =?iso-8859-1?Q?5ptedbkyWfO7M1BGakKip4NtccMKn2ikK9zvP1xGlbbN/R6ggwg+wX7kmF?=
 =?iso-8859-1?Q?XHs5gD/+M1oji6zWC8MS7peXQ0agbD0We4xaQa3cruhbATlVzDy+teU3Br?=
 =?iso-8859-1?Q?W2QOGp8kKt2UrfGPhAiQaSabCNbLKAaPZEbJsoexkQy8D7cyqVg8xWVpxJ?=
 =?iso-8859-1?Q?zrVQp4m25lNXOn9SfODhyBCJoNbs9IJRIx6l4FsQmLNu6YNukKH5tBS8mM?=
 =?iso-8859-1?Q?/4ae+iKp5dVXtAQTrxpoRTM6dUXIWwCtPKeSWMWrey0t/W+IHYHp3ymPU2?=
 =?iso-8859-1?Q?fEjolV98s8Jq9AXb3C2Os8xFXT17M2rjSrlc/btCckT2GDEfiNQkkc7/51?=
 =?iso-8859-1?Q?J3oh3/3UY2ykpEIdzEiKwtK7xkDbQM5qTH5Bjwm53c3RYmyVzVPMLHpKV1?=
 =?iso-8859-1?Q?6U2mMmTA4il+DM71xomN37HeKGXajcBzpPfMXrhobb66eAixgGjOPRlQfo?=
 =?iso-8859-1?Q?6wE/kOiZU6SOHZYaR4KN683I6cUWsCVwqT4UL9gvv3SHS2xbPuqJvjMjRb?=
 =?iso-8859-1?Q?9o4wRoWFglA4zEBvr0nVLXzP8T2OlHAO9Zulud4xTaYeZwx83OPhu+AHNI?=
 =?iso-8859-1?Q?e47Ja3ITcj/Xy/M6v8KXkZX3HwIz5GjGG+6iod9Iy0TsES56sJASBgorTD?=
 =?iso-8859-1?Q?/GpUkeE+V1M5uU4bsmdRo3nqTwjZqlJtzF6zNuctDQuVqEuplzcMDTZCvy?=
 =?iso-8859-1?Q?AdtEBfo4kU7X3qOH3kl3nzCFMfygCUOQYLQycIlahDeDb27ElQDcNgmFfl?=
 =?iso-8859-1?Q?frt7Get3r8Ljurj6hEfeQgsys7E+wLQZLXz93IDrYZ5m95/4w+x4AREXoA?=
 =?iso-8859-1?Q?IT1ev7RZhMpgGsFKYfj91S6Lai1rRAO5BKic1hA0dtX5y+rv7QgXLWP1Bg?=
 =?iso-8859-1?Q?6sWk7LzrjBY7elQ1iLDj4Kquo+4hJnwplbu84b2S8h4rDwnALVvXWa9hJN?=
 =?iso-8859-1?Q?tdh73BJHsKk0DPxTOtZGB8lPpJuw+IdcQ9ScRqzzglj6BPEo+9NGTpBhbm?=
 =?iso-8859-1?Q?pUoziS0eul/ZWADrqbakmbAkInMlse5Mw6rGBfFMKIEnP6FKMCD5k7rkiX?=
 =?iso-8859-1?Q?etf9heptsXq4CNzbkXM0DOA6z+bR5LwdPe80vdFoAfj/XyDb2BX0I0dYRF?=
 =?iso-8859-1?Q?QFvCTK4mt5O1EmRrC7tIJSrxGAT4ZXVckWpoSlT+wl6GNS81EA5Ici6DMG?=
 =?iso-8859-1?Q?FfOTBA3iZtJFrOB9ZKhN7Gy9neA3wzcQkCN4Q1paiAfV8l1Ytskwm5YtHF?=
 =?iso-8859-1?Q?/JanrnhizcJ+MPawLliYPWUcLg2U3TkG7wM8g8h7YSeiCUF5Cv6Hp5kdpv?=
 =?iso-8859-1?Q?Cz3xaXL+qizVZTAN2GKcgFMVl0Ot6HCVwWsRpBZQviMFz/VG7d3JcOIOgq?=
 =?iso-8859-1?Q?FlAbona+T8Fpo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f563d0f3-f3aa-443b-75a5-08dcb5686d46
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 16:05:29.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+oPnIOY5vpZsns52b0yZ4m8lAhhBXO53sOe5sXuNLOvaDBtjHvzXcGM9WRSVgMDuiSt4LMD/9hb5/AxeGF6oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7503

On Mon, Aug 05, 2024 at 05:36:49PM +0200, Csókás Bence wrote:
>
>
> On 8/5/24 17:31, Frank Li wrote:
> > On Mon, Aug 05, 2024 at 04:47:55PM +0200, Csókás, Bence wrote:
> > > -	ptp_hc = readl(fep->hwp + FEC_ATIME);
> > > +	ptp_hc = fep->cc.read(&fep->cc);
> >
> > why not call fec_ptp_read() directly?
> >
> > Frank
>
> It is defined later in the file. Using the struct cyclecounter was the
> solution for this we settled on in 61d5e2a251fb ("fec: Fix timer capture
> timing in `fec_ptp_enable_pps()`") as well.

Actually I prefer move fec_ptp_read() ahead. It is not big deal. Direct
call just little bit better because reduce a indirect call. Generally
->cc.read() supposed to be called only timercount.c otherwice, it should
provide an API call in timercount.h.

Sorry, I missed review 61d5e2a251fb.

Frank Li

>
> Bence
>

