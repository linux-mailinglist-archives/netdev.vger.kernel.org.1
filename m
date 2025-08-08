Return-Path: <netdev+bounces-212150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D55B1E67F
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 12:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD58F587656
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B6B2749C5;
	Fri,  8 Aug 2025 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z8ORgdgO"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD322741C6;
	Fri,  8 Aug 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754649123; cv=fail; b=n2FobwqLCoJtCdX2DvwWyxAlAC0i6KT1o8ROgoMsKmEMJsC/wYaeqv/SkMC/T1NH5w7sBECCjRsVuxhwb2W/ycUtdKqfvOaVe1voUGmuKSB5x7O3KWfq0pKL0emE/g5a1Fr27co1eiZJ+RoLPZ1pImSy8Ds2LapvxABHe/lNmTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754649123; c=relaxed/simple;
	bh=CZyzIo2JW+yMH4ErTQmx+X+69I64LiSBcTOwtwpYCnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ANZTAQQIJP/boLBSsSB3oJB5EGiRRIvTLk0mMEqwIeEGDee0JSJCtmH3Vej+m7w3kX6KHc9FbNwA+gXshnBw/5y4/bmoUfqs9WuLqi5V42812Ly4tKC52TcIw6uPQdnyssszW8KmFuO1fhivWrjTFM47rTuSQ1O1mx65TKfLYXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z8ORgdgO; arc=fail smtp.client-ip=52.101.66.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeV8AbTvoHlakJwojdeC7g+Pcqrm/y4/H49otw9aSJI/HSCrwc0G4atTmuWucJYNT0P1Z5JaK8CTDaSH04yfwCtcJs2OStsI1M4zThytQ021cn3FC7donolUrTRO7Z2oTjGH003S1MfVEiW4XLlCT+cbMrT+7qYXKVGHP4ZVQNKkMAHnIXfb8okIck/PVX9X89Y6R3vK1aJA6/OHZdHGnadUrn5Cm27gBgSvtDa+uX1Kht/voCsppsmtYxjTOmDEbowuqgbMIG0cJlu1ir8qG3MTn/ij9oR1KaZQYIFzdOksrhv6SgY+bR9UJRG+/1ErTlnfpdm9Nwi5Tv1oomCzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74cQ1iU8btzicszilK4EVNcpTKhgu9oWfU8w9NGflpM=;
 b=vMLs+/WaTtyB901LKfOQeozjHY1izgkmk9cvg/3ylWpi8TfDfA16F3fQ6Z+g31wnn5eiuktscY8J7nC5ZwGEFlfJb7Z3eXfF5E9Y4VAKW21c4D6zyj4e5QBhfH03fZ7YJFFES9aYydhCJHKmz3W9x68rPAcvK5QKhRaxEyylEkPYbP89Q1Ji9ryRADWbBKjOmXBqlSFbuxEXTRvXJ5ZtNDmqal7Gg394I/8vZ+BKHSaL1V6jBYfMwImnKANCtndCawRVevPZZ/EJ23jAPuWeaidxZL0KiGcPJWxbfPYkoQ+Icx1jzipk5ZNi2dg2UDb66UynWQn7VyYWkm7zAX57TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74cQ1iU8btzicszilK4EVNcpTKhgu9oWfU8w9NGflpM=;
 b=Z8ORgdgO1QgAsGilbSQLMXZ0xy7yFe++7Ge3ENQiPEZbjbgXPuEabHY+OLiZ8ZdfUYyRRPQhqmIGeyOmT+VAnaX2zfPM9r3R0fUZP5k/wcPAnX1eaiW3YxvYl3eIqP8/nup++2aay3ZnidRx0MSXgRnjGFzUmO55HRKiKEFuM6tk8YLBXnXMwm+IRE4dniqCMcu9NP15aONrfACoLl1O87Qostf8ZKIBxMCPdoRx/i9siconwQ9iDBIY3pPgl32K/zUiQ3vgVpXpCfH/BPS1Ut1Vw0s2YSg3v5UeRnAqOn/fxw6b2Qs/yisGGomz7udxdN9KpAb86xjeDL8JKmsCvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PR3PR04MB7433.eurprd04.prod.outlook.com (2603:10a6:102:86::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 10:31:56 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 10:31:56 +0000
Date: Fri, 8 Aug 2025 18:26:33 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <mzygklzyku2nfcpakl2xl5aywedts3gee2xxcc7vgssmasjnvq@qznnq2zgkjfq>
References: <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
 <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
 <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
 <aJOHObGgfzxIDzHW@shell.armlinux.org.uk>
 <2b3fvsi7c47oit4p6drgjqeaxgwyzyopt7czfv3g2a74j2ay5j@qu22cohdcrjs>
 <3mkwdhodm4zl3t6zsavcrrkuawvd3qjxtdvhxwi6gwe42ic7rs@tevlpedpwlag>
 <aJSSNg4aZNfoqqZh@shell.armlinux.org.uk>
 <aJSf0JaBl4cKphFi@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJSf0JaBl4cKphFi@pengutronix.de>
X-ClientProxiedBy: AM0PR01CA0106.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::47) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PR3PR04MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 3258e7a3-0699-4d6c-97b0-08ddd666cc4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ncTGjWo1CvSW/YjfOVaxDvnd6TxPIX48nhj62JrzxNfnRTEAbBYzXtcxpfK?=
 =?us-ascii?Q?JzZw/FngfdoVxhcLkB4gTha4/8wm4ZfKgR0TyQseCO9P99Jj1SgAvj2GhFr2?=
 =?us-ascii?Q?lqG/naOch4mLNzaPY0J21pmkGuY1i6+uAMf+SEDwsHkABt2V8s5zZAqoAF8S?=
 =?us-ascii?Q?r+ArPEyImxjEpOcUldvqbLDMNkkPwYpJBmHrrNZ/6UyxH0X2+cHFRi7ZYBLH?=
 =?us-ascii?Q?afFeXXMc3vXBPfm7iR6kRRAjdPLIU5UyDH0jVJnBSTzAN81UmT+cunB7pGwl?=
 =?us-ascii?Q?LBkmG0ijZPEvjHLajr0LKLIN7B9osaiF0A6p5L8AlKMF5NrC52FR+iPWateG?=
 =?us-ascii?Q?znY0mdXQAjFqkUp23wRvmvdCaoPEGMcCBJfky16Edm8hBIsGybYTS1HZdOVV?=
 =?us-ascii?Q?mhU3/wJshtdO+XAsz9LBN3DvaMmnQZ1eK3YGzT0E5/yHGkzk3Sogrta0zQst?=
 =?us-ascii?Q?sHRRxruk5jISvx2RQvjEskGMah3k8J/NN+dNdkM4Yyt6V0wQycR7lttDDTQv?=
 =?us-ascii?Q?N4lJWZS4PiA/tYpjZ1oQFkNsy+RkQq4pXiPQjHRX6e9ifhfbJrI8ANOhaVrZ?=
 =?us-ascii?Q?TxwBwns8Uh+bD9yd2jH5PsBmgMhDClZ+aNH5UTTTVWCBplclm78WBRBbERLV?=
 =?us-ascii?Q?MTMip6Gl3olduQP5Y7QAmKSkyMpc5xzGUZ5BFH9TCPJk5rEyS3zHbfUqop+q?=
 =?us-ascii?Q?rxIRNicIybmgBe+PZSk0E2KSxccavErjYvykKreISI6eU2KB940CsYUeqyLr?=
 =?us-ascii?Q?K/Ai4+4OKq2JynD/a1g6LYWuOo7WUuaN6HZhb0sAYU/k6El0FdgtiVJ2nUeR?=
 =?us-ascii?Q?h2F42LUCc5LHBApkHnicwcwGPrMw2hDxR81mAklKJjcENzThAx3kbzNcmxK5?=
 =?us-ascii?Q?gcLoggE236uIF7SlLjRjOoz5S1zQ71Y+ok/6VR+OVkqkW2T85mX9IEksOlcW?=
 =?us-ascii?Q?zKfoGMvW7evPBzpecZn2ZF8+C4LZCol35QazqjPsbKXVZr7ZKggi0ACynO8m?=
 =?us-ascii?Q?rIAhmVBR1Q0RoH9IV72960B5aw8nmUg0AhVvqJX7WWjQjDUejUC5Aw9DSCDy?=
 =?us-ascii?Q?6d2Ba6ag6HwblooBlPXROEj5UiRyQuX3TWjgqne/Z9CLFfK4Klfm5rzw+r0e?=
 =?us-ascii?Q?DsEizo1ddgJHwzAE2z+IgoucYSqVT47BPZNZZ8lj0wsWNu4jBRdzrN33ncGi?=
 =?us-ascii?Q?gv7mOkLrJROHUi+sOH7FG++cLJJjO1CBF3S3qp3bNqu0w+b9swTwRQAoIhIb?=
 =?us-ascii?Q?6JgIwURprxZlInDeRCv8FITy70xUl5bVjaZ6AGlf6O8lVJ+URKOgeZ2E1e6b?=
 =?us-ascii?Q?DEFWsVwV/4I285vK77/JmDYxqOu2+Q1F/ptmwQnmpGQnWJmSJVLHLSAWXO5/?=
 =?us-ascii?Q?cX4Wdr5mqgRZpEdERU8u8346NVMbgb+g/FnYS8KQ40cb/hgzgXLWYwJY2kYY?=
 =?us-ascii?Q?xAkR1eC4vUQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CIUdZF3VzJS1NzpTzx14KFRLe02Ym3bIpjBJ5JAm83b+aT/a2WcndCjQpLTS?=
 =?us-ascii?Q?lzygufDGPvVYjBjcXrXGyGxOHxG3pEljS1/v5jKrcDBif95FJZDz3jfh5aR/?=
 =?us-ascii?Q?8BNW4tTaFxedKyhCYW689diup4evQxy9J6dLBFktamKD5dSCdM/NB66yipRR?=
 =?us-ascii?Q?ZD3GNJR7eQyhPTLysX/oxWQoGXypbFRkGkCKU+fvbtZyRVKwuYkwUtHdxj1N?=
 =?us-ascii?Q?G9DGvip5gK3AMG/nTZuTvz62kwfo5DXNfvTPvv/Rj9vov7aREU8g7VF5tgAl?=
 =?us-ascii?Q?SzjJHi7QYhYdxt6f/bGoPQBkTrfbqT8X9Hg4qX3mXWiaKvAzPPjhrvBpJb9y?=
 =?us-ascii?Q?WKpAuPwsGxYhF3hYXkyboUj0/nVwYQFexBrZrxPYCC6GJ3Susd46xQJyIWyD?=
 =?us-ascii?Q?QfySE+2lg2vtbva0/2Il2XZh214Ly8H6UovsJFKOAPfPgpjzUiMq915yc7NK?=
 =?us-ascii?Q?ehw2JywTGiCEBIIPUlPBIbdmXa3v4UNS90lYXGCJlNXQokwDMqOUlrKGyfTP?=
 =?us-ascii?Q?xxOXqYL44uqfM/sWGUxCv/9QTka/pqeSY2qg6hcpvF1m0Ce2faXE/7WNHbkC?=
 =?us-ascii?Q?/4dK95sP5dKmmCI1Q0TWDOjF79C3gzwunNfakYRqqo+JyiNElFH582fPW/q8?=
 =?us-ascii?Q?cwN7I0pkf51u1kond7SlXrAVuFKyvbb380vboQjTqiFhIkdceyHhXI6omS7o?=
 =?us-ascii?Q?q8/3KOmd2S4f59WAZ0Hfi9GmqGfN4AkTpGYj01/qjaE/Mj00rPcAZC/mdGZW?=
 =?us-ascii?Q?i58t5+wUAjcGY/EdLEWBrAM/fVwn1GW3rgLAO8cC4KPHuN0A+FvOom66bsU8?=
 =?us-ascii?Q?LblxhSk5ksHdAHlHOcab7e5sS1y6SKwyLdTPiUFe/4L4osoJe4zIVC1abTyJ?=
 =?us-ascii?Q?ji7WwZmjjebJ5CyZ8xdoydxcLuGLtK84WOZLq108I7yIX6cTe+/YoPys/la9?=
 =?us-ascii?Q?92St8hQQRTzLrdEPLnBtAm2b5zUg2KQZV49YpiYCLzgNOqrjYuBnhFQVdskm?=
 =?us-ascii?Q?9T9VadhVRxxpeKB515C9YuS3xisiKCgyfjwXVhDO00N25b5DF8oyhZmC4ALw?=
 =?us-ascii?Q?ovBdFM0/rcjzJin6M2dvi5Z+6xgO8WPmUk1e4A+a+2wIghvulKAnuX+SMxli?=
 =?us-ascii?Q?Du/zqWLRiVBvyWQqFEUJvRcpA9ZKyARxrXdVT5FmvglxASAk+VE2ZPN257Y+?=
 =?us-ascii?Q?Y8D4Hb4VHLjUSdQVkrFVh1FdkQAKKhm7E1gGwIhfxEqGm9lwQk0gJIzmpGev?=
 =?us-ascii?Q?WrdGvDQVay2wgeudhhZ8UiW2JtdnMUNdwFyZ4qAtLCUGcyte4YadZuBWB64U?=
 =?us-ascii?Q?hweHAlo1YAxA3EgCC52J8W6VUhUgF5TjtRDYyuZq4GdIjBTnRNm85iY/svTY?=
 =?us-ascii?Q?wPhBf4ltU/cU0Wq1W/TRGy6kkni4DWRxGsMUXYmvIu2N3t6M+CDzfwEcrj2W?=
 =?us-ascii?Q?Feu5QoQHSYCOw/VX5TIGG6+14z8pMP1DU0dslKQd8Ot5ehJomsgLFUdccmE0?=
 =?us-ascii?Q?g4BKK0XMB57MMPJuudG+kn4fXJ3dHCFPV8YVErcVsTlCJX6KQ9QxT5TDEbcv?=
 =?us-ascii?Q?rsysCFdoXaUdLGhA/BZpEr8pTr2RVfxe3/Sv2dku?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3258e7a3-0699-4d6c-97b0-08ddd666cc4f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 10:31:56.0825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75UctlaVxpXjF1iPnZ25eOnak3s2hSUIsrfyIVe9DaLoJl7fYukobtBwAcY0Dtr51s3hcoQ3O3+UcF+AaQcJdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7433

Hi Oleksij,

On Thu, Aug 07, 2025 at 02:45:04PM +0200, Oleksij Rempel wrote:
> On Thu, Aug 07, 2025 at 12:47:02PM +0100, Russell King (Oracle) wrote:
> > On Thu, Aug 07, 2025 at 07:21:46PM +0800, Xu Yang wrote:
> > > Hi Russell and Andrew,
> > > 
> > > With more debug on why asix_devices.c driver is creating so many mdio devices,
> > > I found the mdio->phy_mask setting may be missing.
> > 
> > mdio->phy_mask is really only a workaround/optimisation to prevent
> > the automatic scanning of the MDIO bus.
> > 
> > If we know for certain that we're only interested in a PHY at a
> > certain set of addresses, then it's appropriate to tell the MDIO/phylib
> > layer not to bother scanning the other addresses, but this will mean
> > if the driver uses e.g. phy_find_first(), it will find the first PHY
> > amongst those that phy_mask allows to be scanned, rather than the first
> > on the bus.
> > 
> > In other words... it's dependent on the driver.
> > 
> > > diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> > > index 9b0318fb50b5..9fba1cb17134 100644
> > > --- a/drivers/net/usb/asix_devices.c
> > > +++ b/drivers/net/usb/asix_devices.c
> > > @@ -676,6 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
> > >         priv->mdio->read = &asix_mdio_bus_read;
> > >         priv->mdio->write = &asix_mdio_bus_write;
> > >         priv->mdio->name = "Asix MDIO Bus";
> > > +       priv->mdio->phy_mask = ~BIT(priv->phy_addr);
> > >         /* mii bus name is usb-<usb bus number>-<usb device number> */
> > >         snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
> > >                  dev->udev->bus->busnum, dev->udev->devnum);
> > > 
> > > Is this the right thing to do?
> > 
> > If we're only expecting a MDIO device at priv->phy_addr, then I
> > guess it's fine. Looking at the driver, I don't understand the
> > mixture of dev->mii.* and priv->mdio->*, and sadly I don't have
> > time to look in depth at this driver to work that out.
> 
> Hm, I guess, with this change there will be a subtile regression.
> In case of an external PHYs the ax88772_init_phy() is using PHYlib to
> suspend the internal PHY.
> 
> May be:
>   priv->mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR));

I test it and it works. I think this one could be the final solution.

If phy_addr is external phy addr, then the driver need create external and
internal phy device.

So mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR)) applies.

If phy_addr is internal phy addr, then the driver need only create internal
phy device.

So mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR)) is equal
to mdio->phy_mask = ~BIT(priv->phy_addr).

Thanks,
Xu Yang

> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

