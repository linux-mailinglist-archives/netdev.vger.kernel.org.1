Return-Path: <netdev+bounces-250548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D728ED32921
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDE1130B210B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F715336EF5;
	Fri, 16 Jan 2026 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BjsoWnPC"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010007.outbound.protection.outlook.com [52.101.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38861286405;
	Fri, 16 Jan 2026 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573332; cv=fail; b=VDZ311sjNzVkdiDFBasOoECYDl7Epc2OiV6cEBy6LUGvw9oCLsYDcx7WsyldNX3Qn1bfHRPd2isRMWF3SQDZr2n4UCE15WoF+k+7VBC/9OdKaoT0Ovmrpwx9pS2QkLuvIfnrK6aQdGbJta9IMN1XcWIrwxK8QK4QhpFeGdAlvBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573332; c=relaxed/simple;
	bh=vaFpRk6n4ePZXNWOIruUwUC9pCMaWa0JMAEKfaqZcko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R/iPwj03Yua6fzEaC9edikVty9swUJ4X4KDn054QPUodddpqspUyRW1+uEOpXeD5wQHTM8hqj9w6MfuTLp9iocOeOJqSaHjOeoT3N+8pGcvK02K6Eh9CxkRSiGSu0NcWVJ7CHshSQW9WbVGrJk/+OjdA6j8yBTVH6M43aecJpRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BjsoWnPC; arc=fail smtp.client-ip=52.101.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8yOjaG1qFi5Cd0Qbje/jWIo+nZNnVw2Lx5R7QER1u8wLaROaW+R5TTzee01ATYdizph9ijHB+8ocNwYZx8ePfo+sI+v9dgYUv+DjVCzLWVGkkvPK2f4sAepN45Q6DSY53/+2qKDXUN+59yRNI4dB14IFU5tVTbp9Tc45WnCvZNmU1zCPbzxq4EbGbQAypgqGYrrx8p7z5FrhTB0ev7sOpDHbL05DtWqI5u287CmB4TT52xILRe/KiolsR5tr80He6VTai9WtFsBmsazeB2mncfcLLhNQI2neBqemJTL0jwCiEOFsatglCQzZXxjqUEu1emC6PRUiC0db2RQOrvO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN68/2LhdntgNV6d9GfEeVBA/8GwTotBg7gNWFflUtY=;
 b=aknhZKXbZ0G1uX1kuq6iLUysiwReTHBGElI+dKEaJhJFF/I4O6nr/CUq5UrTk6pbQoR/i2DhuUufzC+pK7Y3hz9pZTxMQexUmEuWQWAAc4G0ooQQ/lRkOsfdh2E3lraG+uQNrfbRbRo8WbHBjOMeqD0f/e0M5H/ofx0PjUJyLPPI0W/Ffb5/EQjVIiInUnTolCr4aqfONW9SxcNEWo2P84/ue3ox0vemAbXt1mTRc9nL6kJayenll9bEsjuQGJ+huoQx76YAnHKgCDBZpXN98R7L0BZWg8UHOTOGQaEybXp0sA1S/lVuCUaeB9Z1qvXQLlZzcjF5MuQYnZT6Mb7xpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN68/2LhdntgNV6d9GfEeVBA/8GwTotBg7gNWFflUtY=;
 b=BjsoWnPC5eaCoTiiXhlYut9Im56ZxMcCLUVj/uup9ZZ8Ez/E3sqLQ7UwMuBoWHxa7ncJm4e3hXBKeVgIMMap+lj+DK4P8vvm89Y3oL50SRai00mfVLtpce0RN/cpxvpZVB9kGKpB3j2wGV+gXNQkjk+fbnsE6Q6KHGUCMCzma/v4fb6BuUfWvif9MKx2ZLBmk8ZH1DFJ+2Ljk2tpveafcLC92XGwmiq5aMBlBYfjMiV8wOC9XaGvypsY0U8wTJISoCzfIhnpYL39WNxq7LPBnY2F15nvxz2V1uc+0/FKj13+qZeSw9MzCe+gMF3SRMVUXrTFTl7Cdce7osWTBo4Cqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS1PR04MB9503.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 14:22:07 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 14:22:07 +0000
Date: Fri, 16 Jan 2026 16:22:04 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20260116142204.fjpqvcbc2p72m255@skbuf>
References: <20251216162447.erl5cuxlj7yd3ktv@skbuf>
 <20260109103105.GE1118061@google.com>
 <20260109121432.lu2o22iijd4i57qq@skbuf>
 <20260115161407.GI2842980@google.com>
 <20260115161407.GI2842980@google.com>
 <20260115185759.femufww2b6ar27lz@skbuf>
 <20260116084021.GA374466@google.com>
 <20260116113847.wsxdmunt3dovb7k6@skbuf>
 <20260116132345.GA882947@google.com>
 <20260116140237.kfkegpkubzn7l63g@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116140237.kfkegpkubzn7l63g@skbuf>
X-ClientProxiedBy: VI1PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:803:64::49) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS1PR04MB9503:EE_
X-MS-Office365-Filtering-Correlation-Id: 8809aae6-b826-4b53-ab5b-08de550aa11b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JhY6EI2Ms3djCl8D6jMXA6m7sIO4qLDDxFN8dw98V/SzWMzG9y7jlfr0aAw/?=
 =?us-ascii?Q?8IkXYfFcpZar7SwFKm58hbjIggF7NrltIYbGbkgnfSK+oBm/Rot5FM4yaVzA?=
 =?us-ascii?Q?WyqP+L81NnJOw/5c9CI3TtJpJ/soTxn0s0Ktbu+cjNUuEwyWNbl1DSLAqQ39?=
 =?us-ascii?Q?T4aZp809f9+CYepWAlupF56YofCK1CA8tpLLLXmP8pnsSO1BEebhuO7coO4/?=
 =?us-ascii?Q?tf/sru0oHZMM1ZHESL4jehuH27kx35saEHTuudP904wvy9lunvnN/po4KpWJ?=
 =?us-ascii?Q?pZ74HOazFjCi4phVAcDxH57Bdv5/0+uItHJGJYbUy3wW0UMseX+wVQpthho+?=
 =?us-ascii?Q?vX8+zqhFCqr1cOfAvke5NR5FpHjvbPue0Kk/UkTBWQCnlZjloYPtMcs+D9lv?=
 =?us-ascii?Q?FO+ZpUQGVRKwB4amr6Qrp8w5f89p8Fbw4vRRXbXQyy1PWdssJt9pW4Vdnfxo?=
 =?us-ascii?Q?qnBR3U395cm6J+Z6meXCW4GCqntbNcPfRI8iOBs25LNalFbR89jHguHI4Wnj?=
 =?us-ascii?Q?OW53dLXY6h/Bedv6WxoJlOynDbr7azNcH5vv4eA7aeSLapp1p4GoipADR25W?=
 =?us-ascii?Q?C2z2M3NO7kUgkuli0JvjqfraOKfg9qJev2OgpDJER3VmgN0RR0a5vZ3pza0V?=
 =?us-ascii?Q?C/f9n2U9PalZ3aZ20CRQ80oQab+bQKIQm7gHK83Mn2yhdIC4kxE9wAmraXjf?=
 =?us-ascii?Q?yoGUQV4wF+UkEtBV5Aq3Ba8CRLc4+tYw47f9Xqp2uep39htAbO4UEgOvGJhP?=
 =?us-ascii?Q?ODdefKvSqnGtmbzPbr0TGa+WZJhNJK/K0UYYsYm9AL3Xtb1Kp+/bNnoL084v?=
 =?us-ascii?Q?Fdn6qAmJqwG/Y6nQg19SjjQ5wwNw5/kvDKy29dsixdPfxofhJ4yEN+WhGuDs?=
 =?us-ascii?Q?6Gf3bWYr1MPZB3RuzlegVfJcRLxxVjBKQmqP+UVbWHy/YKZXYQZ8ZIulZiMB?=
 =?us-ascii?Q?w6kxSJhuISR3fRvWil9ZIaPzgd2hnLFlO8aORFjtZ7eFsgiiArABXkMSPvQD?=
 =?us-ascii?Q?kfuw5vUe90ysndY/aGJIvHaMbBYI4zolS/UvW8dso2O8EKSIXIsLIKDdbOyP?=
 =?us-ascii?Q?sbt1c/QzSY0MLD2OeeRzJb4mdnQ2I6YwMk/k5H6RNMbQin+kVyXtDVFLBbFf?=
 =?us-ascii?Q?dOV5CNhppjSvneLnD1HQRRJyUwOvggxz7uVrypNIyPLGXoV4bobYGY00eVc0?=
 =?us-ascii?Q?X7POhGqnUH6Kqgy/O5DkEXnUfTvDHltheedJFH6qRz3MCVks25VuzIW6T/a4?=
 =?us-ascii?Q?1WSVJUqGmEm51iQYwqpttKxjZzlJpkRNRca0CkFcvtXyUv8Do2W/yevHk+sq?=
 =?us-ascii?Q?no7qo6x3NQDtN62ZXS93lcnUE4p56Ee1vHLbPAiD7TRXRpl71eLlKy2Y5AM2?=
 =?us-ascii?Q?mHdbHE02BIEKL2lsosVPMT3caqS/PLlTnbhWzm8gz2/TpyDDMSOhW3OqcW3t?=
 =?us-ascii?Q?5XPK6PnWxxa+WqQCKcPICWG4ZS0vPmgKsyr9JeI0SaOksGU/90QyGtmsJckR?=
 =?us-ascii?Q?pL5Cxa6oaWeiT5/SwhogMgATFvvThTTi9Hu593N8ZCMKJ+E5smtaR9USUWzg?=
 =?us-ascii?Q?kGbcNOIOna8K1+7qrrY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gc9Kg7MrGsfuYYyTHuGj2gC0lZjUx6TqBHIntMNUHGfXL5fxn7v25Z9MelYn?=
 =?us-ascii?Q?IbGYoweW25w/YtM9cAxFU/vHPy+RToX/iZbqVKVCEktgCiiVOC60YZB6PHkP?=
 =?us-ascii?Q?IGFBqXJ2NTR9mONZ8OC4BdpMGJ8Q3yVc4Ei/qQe/nKPRZFlfseOTYS8Qctnp?=
 =?us-ascii?Q?E6ViXGbVUwxEHRSLw67nAhvh6XzGwO3DvMWDWfpbWH0z1LPSNc41E7IhcbNv?=
 =?us-ascii?Q?Ab679b4zTNWSR4xLWmEmlT4twDn9NYadIfu0xiTLorgEiYKM/+8iqoC3sShL?=
 =?us-ascii?Q?XeJtgEwhZdbzD4sXXRw0IxdItJxehyCHLzr8UF+YsnI5J2H6yTU95q4V87a+?=
 =?us-ascii?Q?q/gkjvaXh0MWIT4Qn3cptKuViFKY18C/yAcqNBK+WOsTj2bJVZZaQQVtgNDS?=
 =?us-ascii?Q?Y6BJzTHYPVmVPdzso735SioQRas/ilLcg71yjA6t+s0QrvaUPhlsU6t7iAW2?=
 =?us-ascii?Q?v9u/8ihEUldG/VWZvJBVNZJfALfcAqveCLR5Y2hRKb4anqlL9hgbI4s4hItY?=
 =?us-ascii?Q?kYkbeSAfv4wRe4NPbnpMKG/f2D2aneveYue9X+aqRj1l3uoj2+uTUboM7qVz?=
 =?us-ascii?Q?8XIhJvwOYgRxN7osf9hSSJH7nl98aOprgWTeGfA9a/3tcQd8rIuTgS9Hnr09?=
 =?us-ascii?Q?XvL36MH6j+I7n+Sb9b1zJ5suqTOpX/L4QL7HKlXZmvaX8oMgtlsaa4thdmor?=
 =?us-ascii?Q?u746NuNMiftkzBD1rF9FZyir1VJRYIR9qxlMKm0gWLcbeIhvb/F6hS0b0LGu?=
 =?us-ascii?Q?XN648bEhCu57SJFnIfi9pFintSiCJ4JL/nS7YqGJ/zIcTshRoh6pdLvmc5tE?=
 =?us-ascii?Q?uX1OyTgV5OmSOS5KFWPapNhlgWATXZs6/QpSfAwr6w6Wel82GJxC/J63o2po?=
 =?us-ascii?Q?5BUXNHUxxmO66nR27He68fZ5TXClCZBZm16L9JnKdylvJNH2zmChLPej4xM6?=
 =?us-ascii?Q?oix4ObGQaK2C7inNm/NLYRxaT6KSKvOvgIwS9otrBX99uKDkLxPmgiglaGhV?=
 =?us-ascii?Q?Ug8rKsLZWJYS8X8AXwdFBOmnROXMa0htyGYe+sGyhbCaBrlpsEayieISbaxH?=
 =?us-ascii?Q?SXaMWuqEVcTckKeqK2L+nj4oqoRgwm+cRjTQ6Tl2hs5fD1XCzPv8drNVWDt7?=
 =?us-ascii?Q?vuwminS+RIloPhORvUuK9hcGHLtPFMqnZ9YuHgKR8yWUvY6NGqFuQtdwpM61?=
 =?us-ascii?Q?f0P6g1FMvLZj0pKpeXSgvFWf2b3gTFaM/m8Ve3w7tl4vFsQ7Lk5vETjcw7E/?=
 =?us-ascii?Q?GWcHqgdA295H1/uk7TFk/EAoKq+KBOYVLBkLBKD75N8eZFZdJqFpM3qa/rrz?=
 =?us-ascii?Q?e1cuA1P3gErdr/tIUpnBpdN+l/cx6siy65Q7jQL4NZfefvhJzkFAmyOmucuh?=
 =?us-ascii?Q?6M3Ux3VcFYmkxNhuuLIJJcn3jaAtMOvuPb9WNvHatcWrdO4FHbulQbMBPnP0?=
 =?us-ascii?Q?tT8gwNbLuB0BKO9IIkwgOhR8+bxonycFE4BVkr4SRCD2AHjlJtsXI6RSElRB?=
 =?us-ascii?Q?7IJxSh8D4Zy/RcizUUmfmN3t4/0grtxsNa6/9XpJWIJ0jHOw2GZ8bVChypmw?=
 =?us-ascii?Q?4Ho3S1QIyEGorTcNrCjAkBvK6/q/VfMxaP8pouwJZAMt1hNE1KqeuhkHubaP?=
 =?us-ascii?Q?6cMpZdG/KxtbWrHiGwvAgC2t2irbH4EN+G1JNftwkC25XpN5knXpX25ZjSlx?=
 =?us-ascii?Q?fydQ/yAHrExv6xbtpM7ImeMsryPRnDS8lyGfgdWwkHfINJlYYrfXGXiNHTYa?=
 =?us-ascii?Q?Rmi89AsVMgKIzJwXLIsa1B0XZqLv+NwAr0M9aVI72WOUTTttVmlV+LKuwK9g?=
X-MS-Exchange-AntiSpam-MessageData-1: UbFsLelPbY5+bMefuGfPa2LUuXXYapwu/VU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8809aae6-b826-4b53-ab5b-08de550aa11b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:22:07.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfDnhRXFI3rLI1tVDdeRP40+z9fcNXxBEPzmfzTl+/tSLzd1TwzK51qeVA6jxiUfbU128CNdXkn0nHbl1j9/vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9503

On Fri, Jan 16, 2026 at 04:02:37PM +0200, Vladimir Oltean wrote:
> On Fri, Jan 16, 2026 at 01:23:45PM +0000, Lee Jones wrote:
> > Please send me the full and finalised DTS hunk.
>
> I gave it to you earlier in this thread, it is (2) from:
> https://lore.kernel.org/netdev/20260109121432.lu2o22iijd4i57qq@skbuf/
> (the actual device tree has more irrelevant properties, the above is
> just the relevant skeleton)
>
> With the mention that in current device trees, the "regs" node and its
> underlying hierachy is missing, and patch 14 from this patch set uses
> the of_changeset API to dynamically fill it in before calling
> mfd_add_devices().

I am a bit torn between not wanting to confuse you by providing
irrelevant information, and not giving the impression that those
properties are all that there is.

The ethernet-switch root node also has all DSA properties that can be
seen in the Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
example. The above properties are all overlaid on top.

Merged together, they would look like this:

spi {
	#address-cells = <1>;
	#size-cells = <0>;

	sw1: ethernet-switch@0 {
		compatible = "nxp,sja1110a";
		reg = <0>; // means "SPI chip select"

		ethernet-ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port@0 {
				reg = <0>;
			};

			port@1 {
				reg = <1>;
				pcs-handle = <&sgmii1_pcs>;
			};

			port@2 {
				reg = <2>;
				pcs-handle = <&sgmii2_pcs>;

				fixed-link {
					speed = <1000>;
					full-duplex;
				};
			};

			port@3 {
				reg = <3>;
				pcs-handle = <&sgmii3_pcs>;
			};

			sw1p4: port@4 {
				reg = <4>;
				pcs-handle = <&sgmii4_pcs>;
			};

			port@5 {
				reg = <5>;
				phy-handle = <&sw1_port5_base_t1_phy>;
			};

			port@6 {
				reg = <6>;
				phy-handle = <&sw1_port6_base_t1_phy>;
			};

			port@7 {
				reg = <7>;
				phy-handle = <&sw1_port7_base_t1_phy>;
			};

			port@8 {
				reg = <8>;
				phy-handle = <&sw1_port8_base_t1_phy>;
			};

			port@9 {
				reg = <9>;
				phy-handle = <&sw1_port9_base_t1_phy>;
			};

			port@a {
				reg = <10>;
				phy-handle = <&sw1_port10_base_t1_phy>;
			};
		};

		mdios {
			#address-cells = <1>;
			#size-cells = <0>;

			mdio@0 {
				compatible = "nxp,sja1110-base-t1-mdio";
				#address-cells = <1>;
				#size-cells = <0>;
				reg = <0>; // 0 has no physical meaning other than "first bus"

				sw1_port5_base_t1_phy: ethernet-phy@1 {
					compatible = "ethernet-phy-ieee802.3-c45";
					reg = <0x1>;
				};

				sw1_port6_base_t1_phy: ethernet-phy@2 {
					compatible = "ethernet-phy-ieee802.3-c45";
					reg = <0x2>;
				};

				sw1_port7_base_t1_phy: ethernet-phy@3 {
					compatible = "ethernet-phy-ieee802.3-c45";
					reg = <0x3>;
				};

				sw1_port8_base_t1_phy: ethernet-phy@4 {
					compatible = "ethernet-phy-ieee802.3-c45";
					reg = <0x4>;
				};

				sw1_port9_base_t1_phy: ethernet-phy@5 {
					compatible = "ethernet-phy-ieee802.3-c45";
					reg = <0x5>;
				};

				sw1_port10_base_t1_phy: ethernet-phy@6 {
					compatible = "ethernet-phy-ieee802.3-c45";
					reg = <0x6>;
				};
			};

			mdio@1 {
				compatible = "nxp,sja1110-base-tx-mdio";
				#address-cells = <1>;
				#size-cells = <0>;
				reg = <1>; // no physical meaning other than "second bus"

				ethernet-phy@0 {
					reg = <0x0>;
				};
			};
		};

		/* The portion above is established binding. The portion below isn't */

		regs {
			#address-cells = <1>;
			#size-cells = <1>;

			/* The bindings of these PCS devices all come
			 * from Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml,
			 * they are not defined by me.
			 */
			sgmii1_pcs: ethernet-pcs@705000 { // Physical meaning: untranslatable switch address space
				compatible = "nxp,sja1110-pcs";
				reg = <0x705000 0x1000>;
				reg-names = "indirect";
			};

			sgmii2_pcs: ethernet-pcs@706000 {
				compatible = "nxp,sja1110-pcs";
				reg = <0x706000 0x1000>;
				reg-names = "indirect";
				rx-polarity = <PHY_POL_INVERT>; // THIS LINE is what the entire effort is for.
			};

			sgmii3_pcs: ethernet-pcs@707000 {
				compatible = "nxp,sja1110-pcs";
				reg = <0x707000 0x1000>;
				reg-names = "indirect";
			};

			sgmii4_pcs: ethernet-pcs@708000 {
				compatible = "nxp,sja1110-pcs";
				reg = <0x708000 0x1000>;
				reg-names = "indirect";
			};
		};
	};
};

