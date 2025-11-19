Return-Path: <netdev+bounces-239993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B893BC6EE42
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 32AB429743
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95393587C8;
	Wed, 19 Nov 2025 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pf2D2+4A"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013043.outbound.protection.outlook.com [52.101.72.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00943563F6;
	Wed, 19 Nov 2025 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763558930; cv=fail; b=ABTyU6GHCKFbYGLlDLSnEFpVGRFg3P0Wzv85y5zkDB3m3aXLyRVKsGn2Jon23XgbnrHaAJSBTZK/S666gjOxMgbKiauPBOH2/70T3H7myeIXeNefPwn+FxVyLgRsSh+cUrnC1+vE/Tj7ijWvvqUzrkAO6SbDyxB5oX/+dh1DQgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763558930; c=relaxed/simple;
	bh=tzhPp/wkJ79MDnLIeKh+SOHAxdscWwCvBUqMzcLfDt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TXCK+JmZYCjAk/JIjqygPjq4Xe0ic3JZiXFrabVJBr+E3PLwOKXLi8H38TElMcTL1dpAk9QcH+ML6slHYVE+KFIGjEgiiNbXpS7Ekp6oU+RD1JqvJI32NrzKD6JE6tEZgC7yADxufnKyvhNe6RC7u0/iXwMfJk2x8aMHlrUv5Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pf2D2+4A; arc=fail smtp.client-ip=52.101.72.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6OeOO8XsX1bik0Z1+njUzI0ocKNX/JABiDx0yIPLLQ+nz8LgfrWcJgy3/IbotqYdlNYAi6drEZ50Ilb/AxgX2bmRMz2yhCG/KowTRkZUk8qSEd6Ch8kfr0tjV1AGzeNYRJzBkM/CZdaSQc1YBLH2lgmpO+rsEQycYN0iPId4y3AGm3PDCn8MvblxbksJ9aoMtOtN/ilIx5xwNVyjfihQveg8ndUg/PBSEt68D04BhAlvTRQZv1d72XwV0o8w4bHGecTExFToSZQhl19Cq8nUHUcAbUOaBeU7ecyuAyTC7xPK8mBU3wt1Nu3QtISbw3r1vGQ9jVoWcGy7TFp13HrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eSlGGsGYrxRmjnSzRh6bLKjHntoQE2QIk1atT5BmgI=;
 b=ux6PNWtGK8+9nKjDylwvF9rsuFOm/dr/1PuP5Aem7j0vgNcnA7lUWi9fVF9Krl4/COBdE+rGe6gK+oXe/VqIzClZiYXMg8kdqfE1FCKm0yoDr98vVEUuFqcQJ92JXnF3S0aFY09p5sbzZh4UoY/LUdl4f+9zMH3+zEWsG1ImW0keAhroLTY7WvdYqjOI07vB+KqOiJng5zXGKlzguji9iTaY24dUaTb3Bg0tchre4rak4d0AnhMXm7HqtqVWVJ7Z9pW6IW6oazyDzeYGRDVOl5Hvhpwa9b27JmNLB1dv3Y2eKXFMAIb/QguVBFa2htQ97Hkb5IEIa4Jokh/b6F0CdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eSlGGsGYrxRmjnSzRh6bLKjHntoQE2QIk1atT5BmgI=;
 b=Pf2D2+4AGSLI942mlKW67bxWls6nIYg5OrRwRPZh6jwwes3WgIMEoU53TTaay6KIg5yN0tf5FkRIakS30D7gBwfMDfYP8sy1IaE5+lV7miw6xFChPFc7VucsvOz9jSYNtJtgStDedKqEZncmUfS50fE3V5Gdu82lNzcqnc2C0TE3J87rVTgrZdEZul70/a/1yV1yvS+FT02en7Yxxd4VJrK9WgpVqWc0/+1cMGsMEp2x6Tkrr7Q32998vaWziJz1Hm9TDg7CSAZBqmpk1rNBf0TVKSs6hhbH5BmJMnU2PdIz4RGC/Xv8ZLj7CCt+wr+OGRovuBTQmm38gJ4u6HsVRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by AM9PR04MB8779.eurprd04.prod.outlook.com (2603:10a6:20b:40a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 13:28:43 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 13:28:43 +0000
Date: Wed, 19 Nov 2025 15:28:40 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <20251119132840.ddw43kvhtybnihni@skbuf>
References: <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <202511191835.rwfD48SW-lkp@intel.com>
 <202511191835.rwfD48SW-lkp@intel.com>
 <20251119120111.voyy7rmy4mk444wo@skbuf>
 <aR2yEf04Pv-CZi1U@shell.armlinux.org.uk>
 <aR2yl-ZZ-QGnnmTV@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR2yl-ZZ-QGnnmTV@shell.armlinux.org.uk>
X-ClientProxiedBy: VI1PR0502CA0032.eurprd05.prod.outlook.com
 (2603:10a6:803:1::45) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|AM9PR04MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: d27d7d1a-1790-4669-c876-08de276f8f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sNSyrRyAkhaQET4o+AnRYU92uI5+54n6UiarEpgijYab0mQW2qFSgTr8ngXX?=
 =?us-ascii?Q?9Mu9WECCxMO7/8IpUmhA6NndVqBQrcEKY5k595mNFV1g2WSzR8es0oSigUT7?=
 =?us-ascii?Q?0elc9uQ6Vdl+D632zlyeY26xtQQ7sG3/5JYE1UwAyImlt813IZB77qRyI9x4?=
 =?us-ascii?Q?XcMN0u2xiUUbi10s1X9JlynZRqlj+biQUSQh1daPjzQ/iMc4ImuxluvlezUu?=
 =?us-ascii?Q?DxNy7boOFmE51daYpsOAd1WN4fmRB65q08SKqJRKaaFD2EjvGfh5oOjSbzeg?=
 =?us-ascii?Q?YvFYeeXhuVri13sBdP0zB+c1h8gcTmK+pRCiz1L2b0A50at47Mvff/CdXJ5h?=
 =?us-ascii?Q?6/xYOy9zlyDNxluh5QrL0bIPxQU871MoraNbkwdtgrNuqqYzmxr/xq7uPRlI?=
 =?us-ascii?Q?gA+OGRMZymk/SgZyBu4nGWXPpaSD6/anV5Gb2hwwcsaBFN3vvDOBlNhs09TP?=
 =?us-ascii?Q?oRXJYn+ryMVA73+2lRbgacfjm9FAj1w2PEuhaazYKeUlC1MFnZF7jImkLUW9?=
 =?us-ascii?Q?CwlS6oR8Ft1GnA8KECD/QPN6ziIbWUQMilT60qhnv35WUFFAdGmTWaJw0iDH?=
 =?us-ascii?Q?JRPnmAioSNoB/+x+t9ArPQudfS52kQr4eogu1hzybapcqzszdR0zMOvhPZF2?=
 =?us-ascii?Q?5TpKyDoaaLIQBTfH9Xrb1hwaqPcL5Hoeru0hl92VTK7lcyWkx9l0p9zzSH9s?=
 =?us-ascii?Q?TmTPRtgOjrKJ546EWtR7QX9MBF6dxe/dp2OVuvKPOB/DN/3QabWh7n0wsCOi?=
 =?us-ascii?Q?Gl9BuKN/d8vaERvjSc+bAo3C2SE+dZcp/mPjx3m6/XFCObDr+f83Deg1M66n?=
 =?us-ascii?Q?5I2+yJVST8i1YrD6Un8AYI8jLkCt5CbwS8spIh3PtUqstQPsPttLoiFRXWjW?=
 =?us-ascii?Q?V2c41loq/F3Xj7FVwW8+FruCXjyYYG6dsBB86mwcGuh20rN1BM9LTFzA2ifA?=
 =?us-ascii?Q?4OHMTt7i5q1iYMDOfXxL1On6xCgpdr4F54XK81R0MGD1RTerriyLl5pKAk08?=
 =?us-ascii?Q?EIE1xSPePFKZlhf0UhzlCvAvQGy/32ZuIAIIT1ue27mkKHpG3WehYKGnPqE8?=
 =?us-ascii?Q?xvAhKHW1VRIoa++QOTl44jlxkFH+tqBbFo5C4/XqRTXODXGEgO8Az34+5Ti4?=
 =?us-ascii?Q?76xQY3hWSS1TJTBXrBAdhJqCXviGlPf+QpDbL4nBxoamHI31X4iKzr/F2zU3?=
 =?us-ascii?Q?e5/WcKVQ+MYJFIWyGaFlxaH0DMjBNcvjMP0ru0QuEP/JJvDAjxn3KifjFJMC?=
 =?us-ascii?Q?z03VI4w3IID8GeCSxaPl2KrCiMQqzYS2tq4GgNcjBqHKo8enHBo7Y167tV1o?=
 =?us-ascii?Q?HFlRjMP96r621yrgTQGk6BLDp9XrgpZVMgqPciz/BptM6ljCHcT5K1gyHKU+?=
 =?us-ascii?Q?MOo51dMjUBJx1xPx3sx53AppiFOQAEAfOq8d1/bpjgRF/tdTkF0RBUPEICat?=
 =?us-ascii?Q?X2F7qJ7AfPpW8wYvwTI/BEMV1X4404tA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VdP+ZXXV1SoVhSwp25fp/llD8Qf/jZ9mSBT232eKHY7hvPQlPyZnjNkkVkbn?=
 =?us-ascii?Q?hDgEC5VWn2JM8vUrsDGKkRVIH+rXvATbuHNXUR3aARLTVXPlV2w0XDU+4T3H?=
 =?us-ascii?Q?LrngIrc+b+USZ/Js6pwo5/ClY/mwBkElyp6mXjOtw0lNyNkeNF/PRcpS/moc?=
 =?us-ascii?Q?uvk8BdSik6lM4F9AnzwprLM+07H3kbLSx0O8LkLyZ61aIZPy/5Ec3RuOQatN?=
 =?us-ascii?Q?zGKnqm4iHhiTMFbLv7jdCoB//vvqtzL1eEuzgjeAvyklu6JUHA8GFWHfDJ72?=
 =?us-ascii?Q?a0QZfy5ryfTRUNdAphkZYb8UMoxkKzvUuPkbUWBajm/N7TUevvZ/1huvR8Md?=
 =?us-ascii?Q?SBh6i8OliaeQjelFpbgvLh1V5XebeuL8HLAeiZCu6Guw3EloOfkDRzCwc4Wj?=
 =?us-ascii?Q?WUJdBrujzLwADAsecFMpgrfKeXv/uXCOH8QkLFXT3kxDlxX+QMEpP9LxWH3z?=
 =?us-ascii?Q?cuW8eIMRCbq7x8FnoIun7/VxDLxJ12gLpCvrISPq8n/iJMZ0WbBrB5S6Xjs/?=
 =?us-ascii?Q?QW8VQYZnOXOwOOv+jkUt1b4Rvrvl3oBKFghcOThnpNPsaSQlYttojjViIH99?=
 =?us-ascii?Q?yzC1g4fGEiQh8vgmf9rWJEKlZl0osL5JmHUwaOuxCwiZZiV7SOTzbh1ecrTM?=
 =?us-ascii?Q?X+bh4RfLZOkaSHB4SRK56qGsnldx5N7t1kCH0qAPlTPYf1m1tjg863h9poT4?=
 =?us-ascii?Q?XphRYCHsXJoM+X3eZBY+RCbWuMYbNLiwc0YkKtawWtjS+ntgfWyT99pbXzpD?=
 =?us-ascii?Q?hBxiiDj6f8eIQaV8A2Slq8Sb2pHUFt04uTUSeqhw+tJLd5tAUtBgniMQXT3L?=
 =?us-ascii?Q?RdrqsNQ0fq+iSX5JL5y0dds2YQ82NDvRJyQNpI3tjpJl1vVI8Xz36za1UTLP?=
 =?us-ascii?Q?r/4ezpJRdQFzy6gWNFG067GXQvdtWbe9wzrWBpE3XmOEv/+Yzx/X9F4CvxYj?=
 =?us-ascii?Q?XAhWoEWZQgMiN4F+7ZS1wdeT3k+8vCH1VqnmCEl0nXLdgbkv8sAcONXR0Ngt?=
 =?us-ascii?Q?Hu/Fck8GNubDywCHI8CyBW6rFBc8Ivgjo7/0kVZkuYlK1ZG0YK0xip9i2fZm?=
 =?us-ascii?Q?Aw5mmZrISWP9ch5MyCYz0nGNPNwdA+0ygaz/lc6nXPRC2eTOcpzsqDKvGgPo?=
 =?us-ascii?Q?wKA9E5GSbLZ9Fuyxr00ZWEPb8GUbtTf4Wskh/A9M8iKHoFibFk1zrijRvhc5?=
 =?us-ascii?Q?u6PxNvJELVV53Vh7XeW0p0ys4OAyscFev3sB5tALxcFllJ+NgilrbhAxpbQS?=
 =?us-ascii?Q?gT0xSKIlK/BjbP799+2w8G5aWfAqjaRUW7AeNz6tC+lPkuq/lFUbKYSGT/VJ?=
 =?us-ascii?Q?bwxuEI1OFL12l/fCkssjFuOD1aa1vLb3fBYnKkrLsUKbIlJzSeqylv0nLUTA?=
 =?us-ascii?Q?g7vNJt1AUfY/jCwbuoPTPs8acJh91nNTmQmNn/bqNvkK8NNx3v1NpZqPi75N?=
 =?us-ascii?Q?OAxx9ZQAGMOOQp8MYdxRT1thoatZ+eZzvbQ0Pkf+1xE1DBPKCI7OteL05jru?=
 =?us-ascii?Q?FIquv2JphYbsME+aRMETOCwzWvcu/5i3e1/8h6dTFeuJBLrMoy4IEd7MpNdp?=
 =?us-ascii?Q?jXCrTdEX4cpVKMDva3EqegoPokxjkw58ESqLetLuv7hrpjX0HnjelKJzfL9V?=
 =?us-ascii?Q?lDDcLFQZxMOEITI+Z9wddYcwtj6nyPdBKWMvJgLaoLqrw82vUZyke7KP+5Qs?=
 =?us-ascii?Q?qsFUiQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27d7d1a-1790-4669-c876-08de276f8f9c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:28:43.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F38SNDmD7lk8TJds2v7LEY7MKFCPUUMuZ/GIbVMh1HeSzAfxcKVtuf2Z6HtKq5f5JxhYuqesJDEmLn86G5UVtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8779

On Wed, Nov 19, 2025 at 12:05:43PM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 19, 2025 at 12:03:29PM +0000, Russell King (Oracle) wrote:
> > On Wed, Nov 19, 2025 at 02:01:11PM +0200, Vladimir Oltean wrote:
> > > I do wonder how to print resource_size_t (typedef to phys_addr_t, which
> > > is typedeffed to u64 or u32 depending on CONFIG_PHYS_ADDR_T_64BIT).
> > 
> > From the now hard to find Documentation/core-api/printk-formats.rst:

I really wasn't aware of this, and I was reading the inline docs from
lib/vsprintf.c all this time... Thanks!

> > Physical address types phys_addr_t
> > ----------------------------------
> > 
> > ::
> > 
> >         %pa[p]  0x01234567 or 0x0123456789abcdef
> > 
> > For printing a phys_addr_t type (and its derivatives, such as
> > resource_size_t) which can vary based on build options, regardless of the
> > width of the CPU data path.
> > 
> > Passed by reference.
> 
> Hmm, but I guess you don't want the 0x prefix. Maybe print it to a
> separate buffer and then lop off the first two characters?
> 
> Another solution would be to always cast it to a u64 and use %llx as
> suggested in the "Integer types" section.

Yeah, although I see the ePAPR section on node names doesn't disallow
the 0x prefix for the unit-address, it is just that the established
convention is without it.

By far the most unassuming option seems to be to do explicit type
casting to unsigned long long. I've started a new test build with the
changes made so far.

