Return-Path: <netdev+bounces-169889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFD1A4642E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371923A4BD3
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D82224B00;
	Wed, 26 Feb 2025 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P2JMOYHo"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A729C2236FC
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582619; cv=fail; b=WhI465tHZl4l4c86uBjIQbO35Qq6GMT2r9bucE6Onuhai/m8lmIhI4UQ+NjW9YLyyjHEK4A2Dk3LcNNy4SElU/AaOk7ZueiKZc9RyF1CF0eWDCMbdYSedtGKB9eK6+BBN1gfaxBehquEvIeuZ3Q7+GYKCvPqUqhEjAIxw/o7vAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582619; c=relaxed/simple;
	bh=YHMco76jrO/eEtJ1XgKdg97gjYX8PhNiSKN6AdrFgAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FTk9dmt8mvG8CgX1pJ9ox8b3Xw6HoSRrtJ5K7pzi7FrEtYloe4b2slomDkSXSEl0Llp/N8U9sgMQ25l8siq4t7by8RNw40M6rood+A+Sq9CKFZ2oAGWi4JU4HS/6ia13LiGuA+YmGBrjhsUY3iR9F1I3wUfIGZZnrSEbJjxM/nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P2JMOYHo; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzBQYEkFt7EVSvKlaKUrIb0yAU7lhrQReeiJhc6Kn89Rm9j6pOgXHeToV/LwTwlOYMHguesa+Xf6putRc96mk+riUAIOHqs/CWwbxUhG06pWAkatnOhvI2RpKfKQCOIdMcmHvBKxwtUArzFP2vB0MP0qc3Jz9vit6YlRj2gMvK+0pZnUKi3JugGisYUbMvggZ+Pnlbae+7PQbvO+tN0ZFjELlNUSb2FjS2Kos7TgHeIrMz57Tk2K13xQT5rs4BXbD3UiPvrRgGiUiAIB+w14MXSXLqt4AlplXI1UogNLlOIXu4PWYoq18lk1F0Vd+y5HOpAmoQiP4xCRHEAbIapVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOrZ78t1QFXfK0hp0J2JpeThJ6hfjS5y5WcSGLsMhyk=;
 b=Ai9hZCOaZKwE1sibRyzdOxY2m6SsJZwWcTk4HWiPG0eyXNrIJWUSEDuVrt6WOB1LMU/9m+7iMIgntCQQZrc8JhaJgH9PvBnR+VEUzmGkUQGklUIvI5w48DAMr57nqiDoqrY6eTfpMS5sDy8ajt0MKRxMen4CZL0ufL9mjwV5FpGz1Xd8p2+GM0aAxHwZoOl2wEw1HdS4vF2Ilnrca6jhWHPljHVnjNvg+ye+3E6HFsAUWkiKP88iHdr4r0iMZ9Lva6t8yR2O4JjPPnALIO5J5QLAt5IV79E8cKYJXbXa/FxIJz/d/tpQl5Pj5z/fdMqvU20rdd9hFA0nLW3ij+vL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOrZ78t1QFXfK0hp0J2JpeThJ6hfjS5y5WcSGLsMhyk=;
 b=P2JMOYHoQiG5KC1pBYpk+jrlkQHLrM/5PMApQN75njvGeTkGNSryOLVrlVkD92taxGCXDpYf/r+ERQONuR0+ea6+QkLTj6BxHJqKjqYXRaVsNWUUWWoR8imnz65hFFITookWS0SXX0A+HNy6yHbOM7zxhH3dfMJ/fP38V2nkR2LG29qo2qBU2izsn7wBrrqqatnrONmvUrM5IJeWomNAZeuH0s5Ylc7b82Plz27u//RRKpD/zVExQvdDwInOsabfq/7fCegpM0p6qlUo6BIUMtC6B5HEU3ST1ar1mE8LAl8yq6NCTXbuh4k8tCGAdYq8yTX2OQ2ANpblo4ujCFRqUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by VI1PR04MB10001.eurprd04.prod.outlook.com (2603:10a6:800:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 15:10:14 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 15:10:13 +0000
Date: Wed, 26 Feb 2025 17:10:10 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
Message-ID: <20250226151010.u2jj5n6e3ofbed6p@skbuf>
References: <20250225214458.658993-1-shenwei.wang@nxp.com>
 <b85b14c1-611c-4002-8fc9-cf23bc849799@lunn.ch>
 <PAXPR04MB91856660FC7E8BF3A8356D7889C22@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB91856660FC7E8BF3A8356D7889C22@PAXPR04MB9185.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR07CA0140.eurprd07.prod.outlook.com
 (2603:10a6:802:16::27) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|VI1PR04MB10001:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eee3d85-c4ca-49e7-4662-08dd5677ab9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?isoIB3+xyuvxg11wXNtqBnGxuJXLsv7YgaqMKxoQ54WM5tPHf2Tn/EHGCjaU?=
 =?us-ascii?Q?vatzvQBb8ShUGis89ViYruJhYqXvdZWiLrUoNXlnB2K1+u5trN9vi/Lh1OyV?=
 =?us-ascii?Q?a1HaOW1NwVAN13KH27ewpOyiYL6TTIfRam8F5flXy8z3ZhsMxnLOu+HvQiCU?=
 =?us-ascii?Q?0MkfC8LgW94Aq3SZME/Wud4hFf+M8PGNLmyCfGwFuvhhcaDZsR+K31+RlB3X?=
 =?us-ascii?Q?wU24IUJv+ObopwsLxDs8nW0egUZWByORr9Krssg0KBJ8J9zaoK7l6Sk8sAq6?=
 =?us-ascii?Q?oJd3yOywm9PyrTgV23nJvmOc531JmU1XAn0h3BcomRFLGEr27Z62Jg4wPz5W?=
 =?us-ascii?Q?5CW8eN9Tn3jRdHJX9OSjJ70EZbW4Nwg2nGPrix/feV3CDdqaUSp5J6/9shOj?=
 =?us-ascii?Q?2l0WfHNsr4YdfFAkHt27b5UtnOeYWDjW47C/oUSq/Hl2nZmxU07NQmYo76Vo?=
 =?us-ascii?Q?/tAPtQhgdBtHvozZvX4cPIRdqA7iCGQYgKsdV/uo5ok7Iganf23J5YPuzo9z?=
 =?us-ascii?Q?ZqFyyLD6HCK5TkoRtKcm394GojuiyHpDeZUVyPXYndaIyC7/qZnqmzrC/Rd3?=
 =?us-ascii?Q?wVYLPymmI20Mi6UYaLTG/Op7rfDM3HbMwVfLbhEnFStn1LHvJXLsMwUH2O3G?=
 =?us-ascii?Q?qw1fhBM0SubYtZ4xI9faLr2OuQ1gg4jSPHxgtaxJXHtSbWF9Diw33QK41jk7?=
 =?us-ascii?Q?QDQXeOszYv8xNYk0p0HeKb9Ctrj4QeTCPdpBF3A2hXPwYsgemWZrkQnqNe/G?=
 =?us-ascii?Q?uVDvJLPJPwnaqJNrVvQNlwQYmtuwfmKjzkusbyyZJWrm+yTnAxq61JeJm/Zs?=
 =?us-ascii?Q?7vP+7tyjGihfbpKZ/J76H60Jquc3r4yNjO4Xkll8g2pEk6pE0hfEDM56Ro6e?=
 =?us-ascii?Q?WWUllFr5Yu6414lSzIV7YpWAp5PunxoGd4l/zHQh5yo+Qe9b6EwvILtYoAKd?=
 =?us-ascii?Q?Q1CmyuTSWULR7nkEWAHJRb4HQ1DAsedjGgjrLvUx9G78tA1csZ4UhzJ27XB/?=
 =?us-ascii?Q?FhYoci8PxhL/BVWlAqsb6MyMfE3Nsv4cALprQefRRFwY476Vw+wVhq6F0gON?=
 =?us-ascii?Q?wqrc+ljkS7deJ+1o0rVdgQsYMRfF6gGiQfhupZYOCCimD7Vtl3Kw8HP5deTY?=
 =?us-ascii?Q?53t6LnoP7M9WxQ15jBtE/cpoCTYZyT8HP/Y1B7TgBiToaley7pxcLvdrJXSu?=
 =?us-ascii?Q?iJjvs23aZ/cXH2I4TtPJk+KW5FWsuBIZQ3i0CXov+W0xznMK43+rEL0KC13m?=
 =?us-ascii?Q?trT2U3GiPtvv0gqGJ5EbgpkXctzUBf0OdE6AsOrGyNK3hqUjjHKzavSDms/S?=
 =?us-ascii?Q?XHUqsEwDrkFAkZq8LtSaE3qdicjv46LpexbiJvcbI9GP+dtlp/FHRvvsCbLn?=
 =?us-ascii?Q?gWg8fRMaXHeOnGzaOTDrzT+iWeyc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xQmMbcztIAYm2K5OtbE8veoHBgz3mKBTFs/6zbEylh01dD49D9j8gZDzbKTw?=
 =?us-ascii?Q?wjglQCsrdlzD+LV3J+dSwMqayFbe0XUkllcbod9FkyGlyZafN2T4PyAFsNR7?=
 =?us-ascii?Q?1MRtZ0Za3xVTYqyEynigBrHX2bifhGJUdFfxG7fxSTCVnmVvsNAsiGicN2lD?=
 =?us-ascii?Q?oT3naHmK0/0UgiljUG1xzYW4Wvw0O49c5kZFoegE/WChDfz3BDCN3llxqDQw?=
 =?us-ascii?Q?BxGXOkqe3YphcPz+uyBHiVdDIpFF9QJx2JNYZBGCP5WYR1RUwHYerFXQpr1U?=
 =?us-ascii?Q?s2LatdNIwOEu4ZEaXM9Qsi5+JVrw78rcpOa1yyBJaOcnaoyUZUJ7FDWT6XCm?=
 =?us-ascii?Q?X/U3NBpqqPPCKntwgVneD2zf9RWw67tLuUX5wFvyx7ek+YcQn7vsfzWcz5Gj?=
 =?us-ascii?Q?66wA6JHPd++zWjdFD+BhGw9V+1bIhvqKuXQwIWQfaGXbm2wM1YpY6YxDrG7h?=
 =?us-ascii?Q?rufEa9CQh5e7+QK7HUXVxtE036kYr2izK7Bro1r3W3nLqQ5sTE9z8WrNCHwW?=
 =?us-ascii?Q?XB1HQOXfv6u+wDK4AjXyVmGadCa/bJZj6y6yM0h6R0a6lHhNXHBt35qNUHHt?=
 =?us-ascii?Q?8BRjvaK6ZvdtAEz3d/I0fk2/Ypw4CMykFsPfFolDqyfZ+x+/nKiqsd1acHUB?=
 =?us-ascii?Q?DosO9VPfjt/oxFx5679zaZqmKuE9JbbVc5yIfaYHnrJIurIGGg07mYf5NKqt?=
 =?us-ascii?Q?tZrQ6HwkSno1GE0GjitNnHSV7AbkIdRodJ/ghPcB1qrS+rk8JpayGVnJ+J5y?=
 =?us-ascii?Q?gLF+k39atQYUq5H7WERSkbnC+E2CSg+FVbYV8GWg8JMmLlGAX6821zo0USet?=
 =?us-ascii?Q?82+g0a7eVpgFJ93qfoepuEUSb80uTz+9tbnRFt/bSEpPg/nQAxwosJV15Bmj?=
 =?us-ascii?Q?9UT2Kd9Mci95gOlKFkOPfVTcntprq8IGqWL/HYxwxc+eMZrZVmV6EF2dVaVh?=
 =?us-ascii?Q?ypzZUGy/ZTfx6CY95Uq+NxXjK1hbGoRaiDi1ZB2nlMw/6UTkLJ0rqZQdj8/7?=
 =?us-ascii?Q?9TqWyqHI6ucjoCUnzh4lrqcpBZQc7V39Cnp7/26eMMZ1jngAL7+hywW0rZO1?=
 =?us-ascii?Q?5eXkrrSpCXLnqTFvnPeQ2Wdk5ocCAZw8ZlP8HEgXF8WPKDyIViUlJC7OG0VM?=
 =?us-ascii?Q?NGJ/0smSZfgOj4cJZAt6GAf5XsrLO6wUrrePtJ5u0oMJ74taEGSc35LUKhQp?=
 =?us-ascii?Q?N9kR8q44bNF5wCqQw7rz6BR2+U5gSu+dgwi+VcR+XESesgI7/PmHwfddVj0N?=
 =?us-ascii?Q?nrk8bgjILXci9ihXTVFD/nv3YmMzsp98lsXGz8L3hadIcCIWHwE3BBt/EHsz?=
 =?us-ascii?Q?c5WtoTs8CtqN5AdPbzIlVpKJiUJDRgjfOfcdfBZ4D00yDEQXos4BuQSvdtEY?=
 =?us-ascii?Q?AsNZUvA9/6vD6mn7vkTgeoj2eJ0fJBR5ElqUtFGTGVMOBjDLoYtR09VKh26q?=
 =?us-ascii?Q?9NejVuBwGO0cAyvNzx4Czv774bS/kHAWzpQFxsuo5+EHcDKlPpUXwiicgWij?=
 =?us-ascii?Q?gzpj9nO4AUcRq5LWCgCRiAT4MrX/njm8Ikpv3/hBwoOkUaOtOG8o1u1yLyI4?=
 =?us-ascii?Q?ONQhzKChT5tKXNGmX8ZaH6QQQl/4q07JPwJHWRR1fqlKcXQ1r1aHHTwYcbzJ?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eee3d85-c4ca-49e7-4662-08dd5677ab9d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 15:10:13.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTlARd+z6RFXS+BHxafgFd8LxSa9tot0VDmO4rqj1Gg8bN2lv6XmlJXVKup39NDCXVNg85xZeZ8zqIOUbUVhJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10001

On Wed, Feb 26, 2025 at 05:07:15PM +0200, Shenwei Wang wrote:
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Wednesday, February 26, 2025 8:58 AM
> > To: Shenwei Wang <shenwei.wang@nxp.com>
> > Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir Oltean
> > <vladimir.oltean@nxp.com>; Wei Fang <wei.fang@nxp.com>; Clark Wang
> > <xiaoning.wang@nxp.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> > Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > imx@lists.linux.dev; netdev@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: [EXT] Re: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
> > On Tue, Feb 25, 2025 at 03:44:58PM -0600, Shenwei Wang wrote:
> > > Retrieve the "ethernet" alias ID from the DTS and assign it as the
> > > interface name (e.g., "eth0", "eth1"). This ensures predictable naming
> > > aligned with the DTS's configuration.
> > >
> > > If no alias is defined, fall back to the kernel's default enumeration
> > > to maintain backward compatibility.
> > 
> > GregKH and others will tell you this is a user space problem. Ethernet names have
> > never been stable, user space has always had to deal with this problem. Please
> > use a udev rule, systemd naming, etc.
> 
> Thanks Andrew.
> Does it mean the ethernet aliases defined in the dts are no longer recommended or supported?
> 
> Thanks,
> Shenwei

Aliases are recommended at least for U-Boot fixups of any kind (MAC
addresses, but not necessarily). You never want to perform a fixup based
on a hardcoded node path.

