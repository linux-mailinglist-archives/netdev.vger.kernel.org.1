Return-Path: <netdev+bounces-195236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76977ACEF59
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 14:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70453AC6A8
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25181EEE0;
	Thu,  5 Jun 2025 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GgAW+7X6"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010027.outbound.protection.outlook.com [52.101.84.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91A98488;
	Thu,  5 Jun 2025 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127034; cv=fail; b=GhUa40tbo9Q2k0+GeOtonEWn0UyUzs2MfyCVO55LtSH3tv9qqNgV5vZr69yw0jVuy2RBDYfsOQ7ZY8YVHIqkU5FoOi2CMXiApWJuAzXW62U+honnhVySPYuBGPxDVA0CRexEtuVTb/xX6AsvJc1Ya0DZOjssUHwBOKENGh3oBB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127034; c=relaxed/simple;
	bh=jdOfCKmja19MbpNHlDs34uzOgNuvb6QKQgtKLZ78ruk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MczKJXBZmW+debSIbJdrWOMsULEkEHl3lUmvWmbnP0I6CjbuLkUzJrGGc01m/PYywUjUYB0XXlA/HrpUQbPjXaP0eVoIaBy7Xd1XAzvdaS1HmtHKjTYGXcwhgEo9Nenqzx6aqPJgY64b0aBaekBXUeE/enaIlRRlqwnj8PSvNKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GgAW+7X6; arc=fail smtp.client-ip=52.101.84.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqPlSP/ipQatX2zl1fiVNMRldfA+5wPLIhDo5y4omkq38wABsK5HqrX1h09+Ie2pCoNMPXc7M+kqGaIiVsKeuGyd3KOgQv7ALCZNmgKUxcxdvovteeeCIjxwXHWcl5TqXAW2v53+BNxWwSk5O5EaUssh2lxV9B1U8kx8oB+FC2dxSVGMIXuHZVBblFlWzyhWp2ykR/pojeh3BliTBO5915KXLt/Z8xO4YFop4DkLjJFFhgTW9/2m9nwE0SmMLAzQm05o4szcQlK7Q9YLxG2mG304MtNRB2u+08F1GP6q8x0BdGdQXmnYQ7s/UUFXQvbyhZ7MgFFbkSLI1I8+ITfnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8DZ8bE+k5wtKL17805Hu9YSFfIpj6+zpaVizy5pBrU=;
 b=Ca1/k5Adl+y/KY3m+uItuz7MFa3kXNpBHpdTUOAxW9t0tF1s98ub6yIr4JO3XqY+qRC8lqHQVWp+MLH4vM5h7cZzIy2zMzt+ELmCJ0ed08GD4exrgEPi+YmE9Ji/jvFDXkx80h2pI198uIjwJ7DMnB27qxe9spgMb8SykS/ijwzeB4BtDX8pa8tkP70Gyr5qcFXjcHQ4cxSWzR9q/WQbzgYzyZTPTHI0hzKDp3y4ARw7FrnRG2mTfFs/m3ik4+YzSPx68yWK5l3vx2WIZV7ayCaZSvrBM68s5JkQDpu8Fn+mRVIn2ujOe9esgB7fylDKyPtMLJmeoUyn2qt5WamX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8DZ8bE+k5wtKL17805Hu9YSFfIpj6+zpaVizy5pBrU=;
 b=GgAW+7X6eWLEXab6TdbhF4nNQVWPq81S+9Uz7Ip9HYuzisyPvaXX4+mUSU1kirELzGevB/ZIl+aH9eTHhTu5mq9SDXCx7BCGrzlPtci70bnUMjx/RDS8fEtKJsHjg50Vc0u/GJ+C0eGjREKhmkiF2Zh6ua5OzSLff/d6n935sW1UB0mfxQsUPi1tyiObZdQxTDugPiMsWFxB7OLd2PrWRngSiMhWs3QN7mihb7rAKuVMGQFC+R++a5L/Rogx/z07d1nb9JQodTjOhhhxQsK9uCoPHHrYyw8IwhwPsUheIBNDGX+z3xBAO9zmoGpjjBAVHphL2CoI0/NJe2Jr93epwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 12:37:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 12:37:08 +0000
Date: Thu, 5 Jun 2025 15:37:04 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"arnd@kernel.org" <arnd@kernel.org>
Subject: Re: [PATCH v2] net: enetc: fix the netc-lib driver build dependency
Message-ID: <20250605123704.iiavrsaz3pj4ursj@skbuf>
References: <20250605060836.4087745-1-wei.fang@nxp.com>
 <20250605085608.dyfp6zy37c6i3qnp@skbuf>
 <PAXPR04MB85105D979659D1B8D753FC94886FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85105D979659D1B8D753FC94886FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1P195CA0044.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 4326a772-3d9e-410c-323a-08dda42daf6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4LgqS+0EFj7H+428xFde0h8VBIppad05R3jXtPkYcX5wi6XJhMopb0GYLb1w?=
 =?us-ascii?Q?nNUQ0duk62UZZf6HeEGPML5wGMimBaPFxW3Nl6wiv8LvCT3rsavUw+RmhzcT?=
 =?us-ascii?Q?CN8945OcMd8H8H1kyxHiM2g5P3kU/ApND6TgpoRztBgn7YMNzrHYInACZjrr?=
 =?us-ascii?Q?VDl+kg+i1ATKA/kqkQ+NB/2m1vmxKRRi5h2YZHFGTnTtCLFHZQoR6EU6/FPU?=
 =?us-ascii?Q?pwvB0/q7dcPzP4Vx1O1t56eh8QNx3ZD0G2NjFx2lDlOX9WKM8OWQNuDUIWnK?=
 =?us-ascii?Q?1Skwc/+mJaB/MNTbTKYg2PYwRPXg0+ID43xRmmXk1ymmPTT+m6YWs5oaUWuw?=
 =?us-ascii?Q?gWn9DD8OfYqbsbIZof7zHN8OeuMYhjEOlrCdrW4xji3NFSyqZWbjowtOA92m?=
 =?us-ascii?Q?op5SxrYkwtXWm5FzRvpd5VBHnd1ThKD/8G2iSTkUslqQbZGJvmhrIMu6t2ey?=
 =?us-ascii?Q?nZ31+bU0a4ZDHCa0m6PgxGhP/u/O9hruCHIFifEsm3i0numW8C2wEI2V/L5U?=
 =?us-ascii?Q?9pPczi+pSR5dd6Vrah6pTa8PG2L4nXco1b3u/m/dW5yo7miMe5W3M5iJDjCA?=
 =?us-ascii?Q?l8tkXx8sBYv/fKbhQmT/C7Oxow39D3T/7ke9ZCi/1luN/m2OtFUnOZfxACzW?=
 =?us-ascii?Q?pxF0JKcXURMtCdNIg0g5uPJIYOtgjKksAtktDYCrz/8v4ONGDLH05Q9p6QZp?=
 =?us-ascii?Q?kYPI0ZL8UaHdeUIGpFA1AS8Sn+ZmTqCqtPKIhDT420HGOWPsD47o/9bgmsUt?=
 =?us-ascii?Q?MDWWTk1yZzR7Tly5Wg22rq5ZrXzm9LIw9zi065mVGBtstf48RSHD++wVHtaY?=
 =?us-ascii?Q?syo4jVighL5TibEmyQf4Dog1DjeIEtx80HDiD/sxQEOgWYtvLUqlH4GHVqIH?=
 =?us-ascii?Q?TDDg6vCbr9m130P3tl6MEa6BNIw3ifLt6X1M5snuGw4L4dmFYS4L37bE8Luf?=
 =?us-ascii?Q?OsMfkexQLfvA47jHRsdcxPtsoO5qj55B3k4MfZjw2fjjgQ24ukFjj9Gxu5v0?=
 =?us-ascii?Q?gqa/wFTp9sebMW7v+btvZ1olaEawVN6V3kP++/bEc+I6CZ42iBZUhRXtFD0I?=
 =?us-ascii?Q?VaA1x138WPwDu6r4YBh9LdhD5qBqOjZj3kF329k6lxwEhEIp7t7x7HzAQcfM?=
 =?us-ascii?Q?tPVrITdmcg8d7DyaX165qlIN6+ICdY7USb1lc8RK2YAWoR1lh6LXr+MggOgd?=
 =?us-ascii?Q?uDZfKOWPZCbFGhFmLGXLYyakLFZk/zOmyX4h7ufj0j5n2H09ACUZhl1VlWmD?=
 =?us-ascii?Q?mn7lwq4toBVuSn08qLxEqd2+uJ6iyR9s4AuPhIIK3qm0AYV4KT2hy1SXZf/9?=
 =?us-ascii?Q?qosBrBCOXECcSbTJRoWVV6N/iuKWvGu7jDkj+k2C8nKd1iXV2b+zgLEc1ORX?=
 =?us-ascii?Q?hSdWA14F5u9LgEioIRkxsUlnvqAvu7nuclFtAsOzcBd1f0zPihiITULL7uNF?=
 =?us-ascii?Q?WIdspYqFyMM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oNh63QqW5f0IJ+OlP1B7JGLQvQmKN4gBmNcqMtTsjDw+6Zu4eWiudZPJMzy2?=
 =?us-ascii?Q?6xEaPUrBZXhEY8a4Mg5MLsQAsTXKX1VkYu3s1mhDdoDOIpDnLRmmFPkBoGPx?=
 =?us-ascii?Q?xwRPtat809RLq+kn8Bn54ahqOzA2W45ZPwyz58vfvAXUHaOVIXPfDCNiJLgG?=
 =?us-ascii?Q?wkeCkLOl5+vg+U3fTF00ErUCWNnPHNLh7usJJ8+Tt6i1Cq3ULKOuWe14OpyR?=
 =?us-ascii?Q?JStv6sBVHNxfv6X76AJ24gbZhsEy0JJXhJCgGeapvYvj9ik6iEbbiExvhHW7?=
 =?us-ascii?Q?erQi7OR30AfllUOSB4iEpJ4OLh12FuTkMthsQ3CdBOHS1bogkbJpy/+dxXTX?=
 =?us-ascii?Q?zRbFCjq42b36T5qZOwgYuhICzfLtiYBPzgvVRYCacrBNLMM50hQ++pliE5dG?=
 =?us-ascii?Q?PeGuPI4tfeo2C9Nr68zM5kWoFwo5epraXj9T5pLW7VH2cX6BCDMC4qIZphJT?=
 =?us-ascii?Q?G93CfUfy/AmYVja3fRX3pXTwlbQrbu5+IeeucN9cko2WTFHmrArVIUgsGEgr?=
 =?us-ascii?Q?U2hhEmU7q+BHg31BAl2FL6UnO0sJQwSyOD0IgK4o77+IiE5908+yQJsarshq?=
 =?us-ascii?Q?8cgLn5hDY7hbzgypa+VF/HvsDr9IVD3iPN3rjbm230zl5+72GsioPu3Iz2GU?=
 =?us-ascii?Q?fPJ3pXb2w/cGLdGGjWzHLOiGWVG/0r8mhAE8kNBncRuu6pl8vdH4qfTDmZaG?=
 =?us-ascii?Q?gHM1pSirtV58CC0dwYO+ONrCrbHm7PNw52DZR6ol4HHIcoANFJHoLchlHQjS?=
 =?us-ascii?Q?WyS1iqul+2DkZBglZfnaagicZS5Z1ZUvegCIDflGUd/TTlbBE3BWETil6rQa?=
 =?us-ascii?Q?iR3Mig//AYTVyN8XrUAoy9rI3NNgQRXziiHVYPNvnbyvK1YPsMwuclo2fwQ4?=
 =?us-ascii?Q?b7i7whmqOVOn6INcLGG65CE3EDLNm3I/5j4KIdvgMYBI6s+G1HFLRBPu1+MB?=
 =?us-ascii?Q?44YWgyWsFmQp19txrRFCDlZbo4k+qWWNiZ3t0X98k0HGMmEqVYSOK07cFZzh?=
 =?us-ascii?Q?tyalfNP77GITDHazJwAx361PbByPtj8HzazMB4vIHfTJuh94QN32FED97MVl?=
 =?us-ascii?Q?3YjheYwls52bfb/n3tw/r/ltBMIWLMy2Sd1NyYWXAEiCLauYCAmaM93f7lLD?=
 =?us-ascii?Q?vHNTjlbGLoXWeHrgzGNfcSWsL52PZo/8RKwMOQGZfGTyoAEKZ0jFoQjDoWSA?=
 =?us-ascii?Q?z0FFNKJsZ4lniK/8YM3eSSUSfyXVpI4TBvWEN6NGaKgvMDkmbTW44CkzF28q?=
 =?us-ascii?Q?6Oz33K50zhl71P7PjhNPTCh5kxGeP+vrG6wcrZZ+xTNeeRnT26MPf+2zaZNr?=
 =?us-ascii?Q?9rTv/zSzhIF3JwwH9b5DAhooU1LmFDfa6onrJ8Tg9QXIxYl7Pf4voc89wR9X?=
 =?us-ascii?Q?BTgX34pOuHEo2ZHuo8KtAOzIDiDpVEeSS0b3RKjqtuC3lI6VnRaWnvtwaPhN?=
 =?us-ascii?Q?AbDENlaVzEDiMgsCk49UyugaV4BJgmhMzeJVqO4/NyGSyFbAp/D/Nsq7NmrZ?=
 =?us-ascii?Q?pzo1HuLeP7eVBGvjLPDMT7BNnZ0R6yYBaNhfo7V6OFn0J/txqpE+stmbn5Rf?=
 =?us-ascii?Q?xJeBodizs514f/TApE1ivAR3CFSLrkChBdP03R5Yhn2MSNLWddlDp3rL2bfj?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4326a772-3d9e-410c-323a-08dda42daf6c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 12:37:08.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UANri3Lo25yjeIhXAOk0TV1Qn7jcQf3jYjPgpx227RoQr2jKXncRTbgHViSVHCUqy1kY4mHyCUxPNwh+43YSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8418

On Thu, Jun 05, 2025 at 02:05:47PM +0300, Wei Fang wrote:
> > I think you slightly misunderstood Arnd's suggestion. NXP_NTMP was named
> > "NXP_NETC_NTMP" in his proposal, and it meant "does FSL_ENETC_CORE need
> > the functionality from NXP_NETC_LIB?".
> > 
> > The switch driver shouldn't need to select NXP_NTMP. Just NXP_NETC_LIB.
> > 
> 
> For the case :NXP_ENET4=n , FSL_ENETC=y and NXP_NETC_SWITCH=m, if the
> switch driver only selects NXP_NETC_LIB, then the netc-lib driver will be compiled
> as a module. So the issue will be reported again. And Arnd also said "The switch
> module can then equally enable bool symbol."
> 
> > I don't agree with removing "NETC" from NXP_NETC_NTMP, I think it helps
> > clarify that the option pertains just to the NETC drivers.
> 
> NTMP means " NETC Table Management Protocol", I don't know why we need
> to add a 'NETC' again, it does not make sense to me.

Understood, thanks for the example. It was me who misunderstood. In that case

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

