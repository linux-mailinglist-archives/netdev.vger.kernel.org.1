Return-Path: <netdev+bounces-188696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A629AAE3CE
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183BC3B2314
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC13289E31;
	Wed,  7 May 2025 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c+4O9zwb"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82E289E1B;
	Wed,  7 May 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630288; cv=fail; b=av5BWZtwdRoAJNWEjb7/yeJIpZXqRrp8zx1EUIGQXJ0lW2An5D4KgcVOFw9UYG9t8CAuIEtSgTHB0SqK9nt0+rAKpRhElBfX2FR2R3wtnAs/OMXPW3uy0/59EMQ0FUOVtoxzUadl2JHDNW8F9/DO2pLv4srDux5Q+ie7UsqnXyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630288; c=relaxed/simple;
	bh=UN/yZTpJ917mRek50QvJDBgaNohxofBu+/TR4JbhMJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hREb/gC4jtHM0dMXB7T5Qm3Uq1KcZ1KoeWpbnjEXh6Wgnpq5gh/0OBgcPSWi/L4ECgxpfh2vNTX0kuUGXqvS7MnPPeK16scMYQwljuWgzGzqER9tVnlilCkgpilVwIhWoqnkitojfFuLgap/StQNC03yvOGGFtBr+LyScguvppg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c+4O9zwb; arc=fail smtp.client-ip=40.107.105.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4lMpw2su4rJ5gj6L6d6v6GkGLeweQ5eRdSuYICMiYtjALGSVq4aeVGqvAW9ezSYZrYQvl2pyRf6G0JoFgj9o5AZmlXzSl5/fA0pZRDSAwRSlK4AWnVLJK/ertV40mRyURNEJMCyWVaEd6Fui3q9FDEYGWtfdnuCuS3YerArrnmhB04vQHsgejFSMEQqUzNXdgYT7xorQAHp8U1HjLijHPG0SR1EaS3bGbG4cQ11G5M8KpVSdO+qCR5Nx3V9bPmAdqZfu8Kj+L7mrrnIK8p/CPt+HsrMvP9Otn9EMLaIhmipEnqUu/qpjc2nysTxX/GoC0YutcKN8ZTHDE2a8KlXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB1E8tiszGKdTEunYGHja1bFjSoMB536cHNpE+iPfpY=;
 b=ArgvPJlJhhGLqiVVpVgVil5rbmVKHcjq2aBfG15gcyWxsPyljR3w6KrIbbbNYZqP2ub2GoGv36G5WdQkKBVvnfRbG6jy624gtkBl+/MoSqCG5OppPeGm5ah8cmZvezHsc0anyfAr082vyvEqMIW7cU4FdPTSDMMJ4KM5o7Dj1CRyBJkZlUOMolYY4/W4Ro0i0iFBZsV9pt3F9lXewrlUG6w9fyw+kmzyBpV7kWgLwfBd5EPm8gfrlA3LTAt4Q01q2gzj4YYzKvjzHSCkQ83ZrsGnYQkPAu2kYLNtyW5D2lpWfmWpQsAVovKe7XR26HfM4VRdyCRtTsgG/i2M4ZgORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB1E8tiszGKdTEunYGHja1bFjSoMB536cHNpE+iPfpY=;
 b=c+4O9zwbbaxbWr1MglQ9iJ7E0MAHb+w6nLCX3dRl1D5JLGIo3+c+BySNG4RPcT6SM88csCXmYYnSM7XgEsx5kpZ515QxtM+15lJWszerand6l9ZVj295mkGfrUVi5smklAX2WSu+QBOGTyFIw9/tIplbJzMQx3C0oQeddIjn4oNFllAeEQYgD/WSiqoPhcpdlURUz6O3DYUU5ExFtVHalOKcduHUxNzNRK89LCOrsam4m1m6jBvhWmsIyiOTulvnS6hbwdEr7Mlj03FcOi0a9pokZ50M9ggKa5g3qEURJfj3A97PIaGgSUZdCZUa5hmySSf7dpyH48f8SNwKaRmVyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by VI2PR04MB11002.eurprd04.prod.outlook.com (2603:10a6:800:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 15:04:40 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 15:04:40 +0000
Date: Wed, 7 May 2025 18:04:37 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v3 05/11] net: pcs: lynx: Convert to an MDIO
 driver
Message-ID: <20250507150437.hlinls22ibxjvvax@skbuf>
References: <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <20250506221834.uw5ijjeyinehdm3x@skbuf>
 <d66ac48c-8fe3-4782-9b36-8506bb1da779@linux.dev>
 <20250506222928.fozoqcxuf7roxur5@skbuf>
 <39753b36-adfd-4e00-beea-b58c1e5606e3@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39753b36-adfd-4e00-beea-b58c1e5606e3@linux.dev>
X-ClientProxiedBy: VI1PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::34) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|VI2PR04MB11002:EE_
X-MS-Office365-Filtering-Correlation-Id: c81fdd9b-0643-4a4b-e460-08dd8d787df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SJdH0rdteDXnIegU/TkHT3nI8Zaz1Hdx6ULjT42Ukn5iRWTgqRVl8UvZvVC/?=
 =?us-ascii?Q?exX+lyv1ixqtC+4XVM5Ys29vf9CvjJO3/wu8vw9DSAYZu5FT0pAhG8UfmQ8P?=
 =?us-ascii?Q?8sK6jbVcsmQxMchajzdfOgh0HEdPt//IyqPTqRewHZlJbctPHEQWgUmQk7eQ?=
 =?us-ascii?Q?TKcE8cO9iH+T0YjHygjLKrT9sUGI+pb0YYyTXhoTYTpWp7ddymnqgEd3V4/U?=
 =?us-ascii?Q?IPBkzg/Gwv6b2EfmW+qGeJIIxHa59j2Zdoj95iDDCbRkzFl2sKKvzDOkIzTB?=
 =?us-ascii?Q?XhYkHi6QMQpgRXE/mShXiCfpLZzAMWVw0642BBwX0jn46D6qGeE4lyImSIRG?=
 =?us-ascii?Q?WOE/cRP7sG2Oa67NCfGFccJxp5P6YYmYZgtReAzjJYB6AxVT4b0w3CvS6MGJ?=
 =?us-ascii?Q?mTUh20Nsy23cSl+3NN1WtNhcVjVEGPi7ktF6EKjbd6Ib7CZntFhbWt6M3x8t?=
 =?us-ascii?Q?f0qaVwRxa6n6Xfga5Zor3nocLgIj9ggcSvWZJor3broIY8m3XVZ+YtlBMKzU?=
 =?us-ascii?Q?ZVTECwWPPBKCQrGW5752/grxv/ctpv5txE/4vehq9JsdOrSySipumaUSfD26?=
 =?us-ascii?Q?cSAT9H4sdwLg7vgAPvJqzTR2DkElk33GQG8gOPVqWnVue1PL6DA/sHl/V9/6?=
 =?us-ascii?Q?tVza+wyhpU9g696+k83hod26+YFLm+veSMI2mkSz8daGilEo8X23DkFALCZ6?=
 =?us-ascii?Q?qax6886m7XghGuuq7IeGzDQtdtecJLG6IHtS5kH+FDQmiAAzW//kj+TJOHGp?=
 =?us-ascii?Q?3AUp16sSu+cp0GDq8/Qwugw2iSuIS2MDy4MbStlSXPs5e45I4cahFDe21YX3?=
 =?us-ascii?Q?wAkCm3RQS/fB/4Ul+xwsc4n9mg7ZpuQBViUCDzvbUS3+b5dM2iOwWlDmqp9i?=
 =?us-ascii?Q?b8xJ+MDfFUwSMBPYJN3quUTZXAAQRbE5czM90Q4QeC2KoAxodH746GXhFf7i?=
 =?us-ascii?Q?xIxpmgyYw2ENScmSlrGjxhgPvzzAhoYD+szXfh5gK+R0zBLhT4XTQsE7A98H?=
 =?us-ascii?Q?LDZlXQ1f4XPSMcnHlaGqfb0DE6iFImKGUxEsH0ykrJrOREsgE81w0RJByxiG?=
 =?us-ascii?Q?4kJyt3JoRdWfGepdM1/jd/igkEZhNZD3I/uoWnuuNUd8MmCvNv0IhBXnIpP+?=
 =?us-ascii?Q?GN8uzocpFwB4KNB8gd+PYLyDyzF85ZCYunOttfdhTp75ZgURftufat83XgG7?=
 =?us-ascii?Q?C9rZBsT3LtYOlN9ogYKKKUmiEtggy/jUmTZcFan4h1hzTsKRyfKb4buQ7u45?=
 =?us-ascii?Q?Z4zCSOOq6B2spxu3O1v8q8OP7gsBN0ZXO+ZBfZPeGj/MPsNCmmi2Esh8eO7h?=
 =?us-ascii?Q?3fAG0sKOxWMie0cx4b6xItXhWfJhxtgZbUSBYLlCOVh7Y6dCu1y1hy/sFZO0?=
 =?us-ascii?Q?+Oh10+6gLDIiNpMsPMWY6/zeMwzGBZ/vdR3k2qAfsKyLkoNsOECwAztghZnr?=
 =?us-ascii?Q?ZCSFxxJeE7w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3le8EviJjDq0mqwae8hB0zqEDm+vTRPkP2l9sd6v9G2PhA02GBwqnYOhAl1?=
 =?us-ascii?Q?YqeSog3S7JShVjBQU36seq5oBUgBtXIdtHghtXkZ4hp/hV0IywoHdtdWlvkB?=
 =?us-ascii?Q?bbW2ukV67OyxktYlqOsoBhz4P7bmYq6HOLjbNNRjpJggTj/xCEN/93307sFD?=
 =?us-ascii?Q?o/C0AHuUeFZ1MvC3/UaX//B8fGyjZvbO2Eao5cUcC5KU1gtvS0FDcEIAoPuA?=
 =?us-ascii?Q?CcPLIlnJERPKaNjxgT1sR50PTHIAEATlJ8DkoNbUiOUyVdIv7819Yu6fOU5v?=
 =?us-ascii?Q?ruEohWRhuijc8Ey3xBkhxH7DwfsCSmETIUi+YoeoVIqUyCXjISOlpEBdOWG1?=
 =?us-ascii?Q?e0bPgT/tF0HaKDF429pAQzCu/Zwmz8rD07ewfppnV6PGelBWkATaVWNlS89u?=
 =?us-ascii?Q?8OHIpr2DMJ/C8uyhFb0qSfvz+wmsizBaAp3IyM1lAhOT7mhH88fiDa/HR8I8?=
 =?us-ascii?Q?8zAzQDMw5x6XxyoSGWjh+ExQ4g2oA/ZIuiQ9b5FUeLtU3KEAOT/TpJI19WQH?=
 =?us-ascii?Q?HpNWe+7QvX04e40gOjBrX4UqlPpcHcntC8ljDn3qfu9WDsuDzaR/C91fzMQv?=
 =?us-ascii?Q?YTQB8G438z+wpR0/7BaFDqOM5K6NySfVFuacDSL2tvT1q22BNfcaqIyq/uIb?=
 =?us-ascii?Q?UMRrGKeGC581KDP6UTxIiYex9JC3esw9DNgVI+vbBXMh95KIB/CNToYPGVG8?=
 =?us-ascii?Q?HNIsXo6ZN91VEFe94vOiAryiO659CRHcTzNv2xY9UuBJZWE9IJU/OvD03+J9?=
 =?us-ascii?Q?0ERWxL4evvoOGd8GqVIaNTwST4W1wPT7vp4w1TAnyK1ZMVcbjSXHhQm8Wa0h?=
 =?us-ascii?Q?cHK3DNgoLT7H4ST7SGaNmlxB35pKmHjJ0UHKyUgpZSxufssdvYK2coSg3y3a?=
 =?us-ascii?Q?J/vsy/S40CiMym/ePoAqldD2L6gxez3oAH4dWGoAI0VDhpYt3wTvtub0nEzA?=
 =?us-ascii?Q?AuZwyp2g02UXTi8KxvnU5T1CJAihbyw+MNMBF2ZKi767Zs6X+/fQTHxyTBH8?=
 =?us-ascii?Q?H4+sBa1qq9YEapOL7UUuUgF69utsr0MXYzLw+7+jqbvXw5BwPo9zDRydiOEM?=
 =?us-ascii?Q?DVJUdNxYQDAEQYGU5IyVcAZ7LmVep2no0ZTQYtEhGsLBDKxLcIVC8iNC5+Ag?=
 =?us-ascii?Q?f7tVx7GWsraBVCK4vT4FrZxUyYw/9GHVMZxEZuhtFDD71yl0sdwTOIUKr5ef?=
 =?us-ascii?Q?gfHY5CKRZgHdPpKbVoiRuZvyx6aF+VjGKiuwnwvUjDkCzUyZCMXGJGQMiDqE?=
 =?us-ascii?Q?438LQB0HB1gRdPugDQxLWGSEkkQURQeOrAeAPMawI2jreKtnIM7Zt/djyoEK?=
 =?us-ascii?Q?yIP06ORjbJ/+PwG60+hl32GeDpuswDXeRxCGQaK9L4ZbiTe0pX3j3HFaUN0I?=
 =?us-ascii?Q?NikKgB8hc1YC2z/08s6GyaP5k0Jd5ON6EFI0zo7Lnx9Br4pFUp8SOGpfNU8m?=
 =?us-ascii?Q?SAh0SeNGEIVEh/4TTF0nfzz4xqN4TU3twNCLkd2VLugMKToJPC+hxKc7HwCP?=
 =?us-ascii?Q?oh8yTxvE4jmXYjd11oXXRHwAeKH7J+Fim+uFzg59BC4mDAXYMK3vNHqrepYn?=
 =?us-ascii?Q?B/0mNqcKEMzERBViIhz4X8Uheh5nmU6AG/EtJz6wBWYinry0SaSeoL/IQFdK?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81fdd9b-0643-4a4b-e460-08dd8d787df3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:04:40.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XR8Ee2/ZPDT40WEg9RwNr/4C0lEbvBv2edj4QFrQHu2c9GQvTpnMnyykUCfOPCecvOxeMC15PRRn7glxOngJCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11002

On Tue, May 06, 2025 at 06:39:43PM -0400, Sean Anderson wrote:
> On 5/6/25 18:29, Vladimir Oltean wrote:
> > On Tue, May 06, 2025 at 06:20:32PM -0400, Sean Anderson wrote:
> >> On 5/6/25 18:18, Vladimir Oltean wrote:
> >> > On Tue, May 06, 2025 at 06:03:35PM -0400, Sean Anderson wrote:
> >> >> On 5/6/25 17:58, Vladimir Oltean wrote:
> >> >> > Hello Sean,
> >> >> > 
> >> >> > On Tue, Apr 15, 2025 at 03:33:17PM -0400, Sean Anderson wrote:
> >> >> >> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> >> >> >> index 23b40e9eacbb..bacba1dd52e2 100644
> >> >> >> --- a/drivers/net/pcs/pcs-lynx.c
> >> >> >> +++ b/drivers/net/pcs/pcs-lynx.c
> >> >> >> @@ -1,11 +1,15 @@
> >> >> >> -// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >> >> >> -/* Copyright 2020 NXP
> >> >> >> +// SPDX-License-Identifier: GPL-2.0+
> >> >> >> +/* Copyright (C) 2022 Sean Anderson <seanga2@gmail.com>
> >> >> >> + * Copyright 2020 NXP
> >> >> >>   * Lynx PCS MDIO helpers
> >> >> >>   */
> >> >> >>  
> >> >> >> -MODULE_DESCRIPTION("NXP Lynx PCS phylink library");
> >> >> >> -MODULE_LICENSE("Dual BSD/GPL");
> >> >> >> +MODULE_DESCRIPTION("NXP Lynx PCS phylink driver");
> >> >> >> +MODULE_LICENSE("GPL");
> >> >> > 
> >> >> > What's the idea with the license change for this code?
> >> >> 
> >> >> I would like to license my contributions under the GPL in order to
> >> >> ensure that they remain free software.
> >> >> 
> >> >> --Sean
> >> > 
> >> > But in the process, you are relicensing code which is not yours.
> >> > Do you have agreement from the copyright owners of this file that the
> >> > license can be changed?
> >> 
> >> I'm not relicensing anything. It's already (GPL OR BSD-3-Clause). I'm
> >> just choosing not to license my contributions under BSD-3-Clause.
> >> 
> >> --Sean
> > 
> > You will need to explain that better, because what I see is that the
> > "BSD-3-Clause" portion of the license has disappeared and that applies
> > file-wide, not just to your contribution.
> 
> But I also have the option to just use the GPL-2.0+ license. When you
> have an SPDX like (GPL-2.0+ OR BSD-3-Clause) that means the authors gave
> permission to relicense it as
> 
> - BSD-3-Clause
> - GPL-2.0+
> - GPL-2.0+ OR BSD-3-Clause
> - GPL-2.0
> - GPL-2.0 OR BSD-3-Clause
> - GPL-3.0
> - GPL-3.0 OR BSD-3-Clause
> - GPL-4.0 (if it ever happens)
> 
> I want my contributions to remain free software, so I don't want to
> allow someone to take the BSD-3-Clause option (without the GPL).
> 
> --Sean

Bottom line, I've checked and I don't think any of our planned future
contributions to this driver is going to be impacted by the removal of
the dual license option, thanks for asking.

