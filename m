Return-Path: <netdev+bounces-246191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CC3CE5696
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 20:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 113C03001FC6
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 19:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3BA2253AB;
	Sun, 28 Dec 2025 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NgBa2Tr7"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E67529CE9;
	Sun, 28 Dec 2025 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766950865; cv=fail; b=sjKmCaSCz0BOc3bkD9qev2OL8WJ1iVZtK3eIgZWbco9OPH6OGc48u9LL88ZiBbqSP45HxyMykjkLL0IfXxFf2ENbAeNVIf2WUiNQoYz1pGibPvAO3iuXCQZebirpRrx99Iu58X1ys8BxPTtSxPpyg2rmdyHQ/oOlP7n76mUs+n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766950865; c=relaxed/simple;
	bh=kZFXCN2jwH/9toiEB/ArJ6+cuJKFF9G3o3A/9afGPrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T3T320hgmsqSAZp6IZvPxq05FAp1rf6ZbwQtRCaM/aRs0ze3MKccab4Di5ut81SzPsF0ltEesfr68JSpKst57xgs3BrxS7kjXWp5fm9/MQj7KfkpzygfjpoeLXv9UxmKxtqMPzbtG4m2Yev6GLv6hk20fcDb+p5X+8hXZa9ryqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NgBa2Tr7; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oujNZF1VSes70zWFC+AJF3wlJW37rXgqiYNmYl0qcNRqGD8ykUkyR64J8QVHL575N6H6iCuZplhBsz2LjdXFSRYqV1q2q67Z+CfrJzTCbMtFc2zDG/ZSOZiG415o4/YedRbOUHZRJOaFXzh7zKXW5Hn2eEHCtDoOy5gz+jKYEkozjYlhjZ+zX0qvhrKtvm4ySBofVx/OZZVbZInK6K8RyQBq8D8z+vl/rTbjTUAzo1yymcdfpS3iVeAHUhvWNvMNLXjxV3Os0dr6XckGbjZYCpZ0bg8AoRH+cT9zjToj/cu3O2q6nyKlkYmPtD6bHDds8v2+BAKDRtp4CQkg3aRhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkv4H3guwrXHyAYQt7tXHDfSEGjRv+vrdOTXGh86Sic=;
 b=u6xM428nDxfKTeK9QzjmGJbDtpt59EU2NCgQvFqYEuwpXYQxUCJDrNrkQ3dXSQ4epfKL7WWDzYlOsul5f/FPx7OueoWMz/3mGZ/rd42EnCcaYL/kCpV6bzfp6FYDGpF1NbZfZ/+PEUXCWMr0yllyyPh2jsw1Ntw3UG/JweAF6+Ngv9DEyR9Nk4UC89Wanm5gkb/lvcTm4H0fnLteVW1gt1cETmj4xUwUR27ZQcAlS01TCG4iExWz813q2GOILXuh4zMUqGR1/69opgFlPAESSYbd61mK1KA+5365IzPPRyh3y8PMqE4DoktELbOEWGVg1BegcqmpRITC3J/CU/+sfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkv4H3guwrXHyAYQt7tXHDfSEGjRv+vrdOTXGh86Sic=;
 b=NgBa2Tr732CfXYokjv0AJ5Qapx+eFZVCjcW3GI6IZZn9SW+xi61zc1l+o1ZMIuLroDLhM2xcXLmRBk+9NsOM6wYMeR6ulPmbtqI45RpIxxlR5/vFY+Tbq/E6Es/NE1tN4QG7qPnhMropLb1updmjLksoF8L99IHGTNIi/Ddm71sVZ8Qp62OYzoz5JxDIMXS9p6/8JFXWxZepyN755ndtvljXZZkQALgqAtwn8NMkt2dItj1mDyDmYrM6h2ABnRUHPm5xhpkuWAUYz06BjNHv5C/ltgbz68HPec1Vu1CBesIadHSa1CP6boy2coF/w2tOMlXhGumvND7x5/8NZjmAyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by PA1PR04MB11335.eurprd04.prod.outlook.com (2603:10a6:102:4f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Sun, 28 Dec
 2025 19:41:00 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9456.008; Sun, 28 Dec 2025
 19:41:00 +0000
Date: Sun, 28 Dec 2025 21:40:57 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jerry Wu <w.7erry@foxmail.com>
Cc: UNGLinuxDriver@microchip.com, alexandre.belloni@bootlin.com,
	andrew+netdev@lunn.ch, christophe.jaillet@wanadoo.fr,
	claudiu.manoil@nxp.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v3] net: mscc: ocelot: Fix crash when adding
 interface under a lag
Message-ID: <20251228194057.pct2a4n7pnpmmcfr@skbuf>
References: <20251220210808.325isrbvmhjp3tlg@skbuf>
 <20251220210808.325isrbvmhjp3tlg@skbuf>
 <tencent_75EF812B305E26B0869C673DD1160866C90A@qq.com>
 <tencent_75EF812B305E26B0869C673DD1160866C90A@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_75EF812B305E26B0869C673DD1160866C90A@qq.com>
 <tencent_75EF812B305E26B0869C673DD1160866C90A@qq.com>
X-ClientProxiedBy: VE1PR03CA0044.eurprd03.prod.outlook.com
 (2603:10a6:803:118::33) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|PA1PR04MB11335:EE_
X-MS-Office365-Filtering-Correlation-Id: d39f7b5a-4188-4346-03b7-08de4649074e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RS7BCq1Tge3Zq4skfTO8HyFOzUS3YjxDMUKR9haMVzy5cf9RtiGkD2EbGba8?=
 =?us-ascii?Q?JvUwWnlz42z8j2AwxHEuyLyrfsOs1JAnUbCSWMr2EMw3PQNecK3AsghW+ww8?=
 =?us-ascii?Q?Akfr/MKJf16/AomK/14Rc9+CXtX0FXgFrJ5EY7uOO9nHHUD96NUQFrkfORXQ?=
 =?us-ascii?Q?AdQpgZOv7hYiYDdVANqAEykcEYgaCi94WQnOO0kKfTqrdDzwO2L7FUEms8+u?=
 =?us-ascii?Q?RKiO+oZ3exgB3/SIEDZVfkyrxdLVbxb+I+f0ZFdfRfAFr4Mls79e8p4xD2/p?=
 =?us-ascii?Q?Dbs9CgUM5uT7Y7q4CvXz5VFSsSX2EtM2TdE+qi6ILY7NvMQ8w86CdqbhiBT+?=
 =?us-ascii?Q?tdFNhahwe3ueRNdBZeDGCD4hIPH31dscSCnKQK7NeUFFSUB3Knku/zJnaBC5?=
 =?us-ascii?Q?ixgkXtYjxiDOKvgxtsGgQebZvDePKLblBGJsVqCpWTfRIsq6D56oOfPtO8nY?=
 =?us-ascii?Q?pMAIvXc3rLa/mWmQ6Olth/U8Eh/hI69C9+IeyzJlrc8wyGi0NNTR33We88bb?=
 =?us-ascii?Q?6hlLgGjO939aD8nj2NrljeXcshzdHLZ//eY9P2pprp7/rCTfxfTxmARV4l1d?=
 =?us-ascii?Q?aS73jmiGgAFW7fG5eb5VaPMFennRUSOBjnOjs/yWabkyjNdtwsBw/8nMq//2?=
 =?us-ascii?Q?wm05dFUyen4eYT3+bK0zg6Pm5WbqU6mnQOUpxnn9IVNiBlnYr4txZDyT4Ryu?=
 =?us-ascii?Q?/XdCrC8feX65JsTujWHiUHBFasxGM857jF83dsCX0RLxM4LYO1dgsZbEv0zD?=
 =?us-ascii?Q?n8oyk7bcRDL7XyGAAC7rhu72rUWykmKh+lboQeD5Wv9/LqOmXkLex42tpwwE?=
 =?us-ascii?Q?zmLvMuWYnLisws4vi5ad6aGjhkw9zS07w/EA4zljGGsm2yveIUpm0mhPGx6r?=
 =?us-ascii?Q?ddZGFQAlzsajIEEwaHbgiD5QTduLJ5Rq+Et+OXhupB/XMiy/WMijRWO4r/px?=
 =?us-ascii?Q?owJrZ+Z7d/MFNiUvfmwMOp2Y8eTxgmJEhq07GQJv1rd5G995hDLGpUQE4tS9?=
 =?us-ascii?Q?VuxPgTQHPM0nH5oj/0D6vs8edMA/qj1MiT8W0jayh/NPQeie8F/O3XzH+Sj8?=
 =?us-ascii?Q?41NqOfJmm3oxf4mU2DZxknoIDuXaP34ZrE4Fy0suQ97Kp1ylHUEARKjgFReX?=
 =?us-ascii?Q?Z/BqoO5pYkC8O2YLI4cDTbea/ByEo5FJf16f/KqWOHDP6zw3Z0mHSyf5bWQR?=
 =?us-ascii?Q?Q9XJAWRHpq/k8Yht1CaGfj6QMAg0hAg65O2hqMB6cTkUGwWTVlTqnAKo5os4?=
 =?us-ascii?Q?1QVrmBEz/FObxyJw7bqJvCIAqVRgD22VggMELOl6zRHRk3K9Vn10bImxr7lb?=
 =?us-ascii?Q?fm66DyUJZ/Lz0JGnooUh37c5zOcZ+c00TriLqqBykpa6Yp3iSaxy2J2/03nO?=
 =?us-ascii?Q?zuD0hguc74KzdaeVbO74iad9/cDzQ3t8gtbrYPXWUmY2z851YwJ3rV0TXrnR?=
 =?us-ascii?Q?p67d92SySzEBUqXPb/5SE01h5i/18JaN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x8CNiyxIhoh1pMkgfmWBDVo076zBZYixx4FrErQK7l7v2i85PrxC8Kz1eV6T?=
 =?us-ascii?Q?L4+j7pzgcAPAL93jdWYr/V9+07xAWiN/Q4VZZdxhk3JxApoVvgeVUwPzEbNP?=
 =?us-ascii?Q?B+IHIOsqTPsusQe8TiXe4SCX+WuLqDcFLEH95XQkp6gA9JIGFVXGp/riGc8z?=
 =?us-ascii?Q?q2/g1LjSOBoP/JXxp462bUdrZCvaAfuKMhYSVun23oXNJ3nsq5AmQdn8MwUL?=
 =?us-ascii?Q?CDKhzIBEaM0zD8ArlkYhep3cshWbk+jUliT3QGQav6Fd6kuNNXUUxqPWUluA?=
 =?us-ascii?Q?TBLuaib7alc9zfgKnWMqKQfSgBYGxeklCUWhRNl/iAhac/d/sqNhnODEtIDG?=
 =?us-ascii?Q?9OLjxWIbX6My4AkseTn05tZqz7X9+Wfq0kS374nY7NTA42jJaQ/GieZ6OAVh?=
 =?us-ascii?Q?a7gsmlJLfy73dSyP0MJ4k9ye5QQCXH9le58pHhuFwTFf+2hYXV7/7/JmuY8+?=
 =?us-ascii?Q?ettcwCI1BIA1zGbHLdM3GvtwZoTmbpUx4fThvkbeiRKXG6cPhLyMp+Sopr/c?=
 =?us-ascii?Q?LQNj7ggbtPAF3wd95F2Y2au47Ga86xjDqrMF3qyPVPdDX8Wk/77K2oRALzSj?=
 =?us-ascii?Q?1jXvaw6BJrdmejQvbxKw1ezRwVrRer7pK8ynEgy3s0QNjATFmrqEbijrRFnR?=
 =?us-ascii?Q?GINqAWhlwjH5z7D+ZLWoJNti8AePOC3DqB9a2Mo04KK5WybMTJCXHWcSFwy/?=
 =?us-ascii?Q?1nUye0rddHo2ntZ9RGzlKNTbYSvxKuT0UVG3tOwI2QI+G5OX28ec8if4p/67?=
 =?us-ascii?Q?7/yzU0CpclgbrXV+ojAavCoosEw2CYfJvAwGYnQ5exuwYcayMgwur/L5U1NR?=
 =?us-ascii?Q?RUtibjEX6oI2AkPoM8jA19B26DV1Boy7muxSnd3PHvHyahDKReZyrCODGHbL?=
 =?us-ascii?Q?KfkkfEAHm8QaNktQbfd9rHKsSJOuBRjOfcO8/EMZ2YlQfpfDc+p18yW8w6Y8?=
 =?us-ascii?Q?S5I9v6tOpmptNZH3cpODMkPzb6hSQaZ3brhpUeF/nCZPLKeVc7tYRC2yP4hu?=
 =?us-ascii?Q?qEcFIGevb+P2GMfRPqy084Aj0/axpNEJVE2iAdJ/PAvdOoC7Z1CP4S06v8WA?=
 =?us-ascii?Q?IE52L6XdartRjiB63VOeXUgQCq/OKZUWBy7I+Q+K/r9575ZjmewQlNQ37WRj?=
 =?us-ascii?Q?B7h65pDVmMCrDy5pBmmDuFrmhtlfxnBmmQP1T7l7ZSgv+4k+pKyUQG8rFxfG?=
 =?us-ascii?Q?OTTY7aq8qRe10DwJJ/NXKedCARHd0KRNlulVcm4HXg+1f/z58+oiwZJ7dGYY?=
 =?us-ascii?Q?FkawGQMSCivnLHubgbQvpWj9N0MvglCz5BTUqivuG7Ygwsr+N6mZspAphqZd?=
 =?us-ascii?Q?O9lRzUTT3Vik6aFCrqHxNS16bA0dfsvCmL2CMcBrwziMf/ndeO/LCrivqHEJ?=
 =?us-ascii?Q?yhEcyCwFzLoJ657SDv4e26RzhU7HkgwW7AoBzMzMJBazaaD/vLxnF7uI1Wwu?=
 =?us-ascii?Q?qwreXYyObNtvtuT6v8YoJ9VGWoMzBIvdRS/HzHx/l68R1J5fZqPw2UJzm7XT?=
 =?us-ascii?Q?1wEjZEKnatojRS0CmoWgBVRjiH1jEY46+0AMOb84IwzlFUcKuznbI+a4wY5F?=
 =?us-ascii?Q?C5wbCKEXO//nV1PK/swIovncKfLKl0evGvj1RRoW6a4ONsaygk+Bwu1AS/wY?=
 =?us-ascii?Q?NGC2ZYfRdCeN8Ulnja4siSW0Gtdy+sp6j3Nifi+S59BTRDOyjmjVoI+Hl6Ww?=
 =?us-ascii?Q?ZPDuIFOprpkOkjnQJjYb004AzC/x5fQhymAaVCjlksBGRcYOxNO+iIADi4sF?=
 =?us-ascii?Q?WaBvLRf8ygKpd7Ce0hCfjP6SkTVIRkFyR4G7LoDL23oH58p7gqKGuiIh6Wma?=
X-MS-Exchange-AntiSpam-MessageData-1: /bzjueWf47EiuQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39f7b5a-4188-4346-03b7-08de4649074e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2025 19:41:00.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyySe3vi9z77wF0XD5FGETCA0ANGYUMyvjcbE/QAM6/04OnIKTJXTgbAPeIpIAkvQnvEXkmWV+PaoblmrEiZPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11335

On Thu, Dec 25, 2025 at 08:36:17PM +0000, Jerry Wu wrote:
> Commit 15faa1f67ab4 ("lan966x: Fix crash when adding interface under a lag")
> fixed a similar issue in the lan966x driver caused by a NULL pointer dereference.
> The ocelot_set_aggr_pgids() function in the ocelot driver has similar logic
> and is susceptible to the same crash.
> 
> This issue specifically affects the ocelot_vsc7514.c frontend, which leaves
> unused ports as NULL pointers. The felix_vsc9959.c frontend is unaffected as
> it uses the DSA framework which registers all ports.
> 
> Fix this by checking if the port pointer is valid before accessing it.
> 
> Fixes: 528d3f190c98 ("net: mscc: ocelot: drop the use of the "lags" array")
> Signed-off-by: Jerry Wu <w.7erry@foxmail.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks!

