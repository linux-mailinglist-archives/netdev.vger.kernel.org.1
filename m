Return-Path: <netdev+bounces-212149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7DB1E668
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 12:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6A5626204
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C04273816;
	Fri,  8 Aug 2025 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dnfWRxRD"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F32737E4;
	Fri,  8 Aug 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648607; cv=fail; b=h2pFXhgdUV3HBQrAJC+Dik87kGxz48ZmloZGSYjCy9YwJToh2TB650YiF+Z9MxNmrP1tV6mXTKhdpeDzM9jtJeaSlrlgaTf4dqRc/kAzj2L90HhYL9Z+wE9Y9ay0w9MAYGkQCKoX/1i8u5yJr4bz8p9FtkumEhdqBsfkPdNH3TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648607; c=relaxed/simple;
	bh=YyLSt3MNr0uSj8ROTlkqS0dY07ISzKZvPcn7fzAuMtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WOtaiv52qp6O3+pqnASaaX013ZIZFdLRaa0b4EtN/XY0ms/yj0/ypt4BL9AqUkzZ4YNmfynhKtcUCR6BJVkQNpYFu4MAbMqFN1WePloPlEnTgMe8Wy06AxUbu0qC5HWQN72kis/0NKp5MeAoH0zl6zD1V9wnflCb/GURapdGnfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dnfWRxRD; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbb1FY4yLgIjgt9qewVgcsfVwTDuoGNHLq2WbB+LKpHXXU1TfcQ5ageB8ao1GkPm9CgKpP1PjY6kLV+4lkhqPGO0MhRe1LcY8KapbzznlEXhj7T6K1LebM0dEIJl2TeA7b4EGzwgLIrOuTeK3EIxJr4q4vs1hACp6TjLEpX3HWQfZIQXeWGgcPjRhqz9vlNLqsHcCB7DfqAld1ViBfAF3j36x+Yl1Sz88tVW7hRATklFrrXVZyFuBne+fJoBHaQCxxEReX5GBARXtSjWKDKbYAuR35QonD9/t41McSw+ydl13DsACmrsD6rmAcOIBQKR9Icbl2ooBlsopBkNCZlDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eERn7tzeXllJ6ydylrN+4RDwxyrC28x7kFW06EucPE=;
 b=XpTbt3+y4Sq2C5Gp4fYQkyXsa6iOr0OuAyGW3CoIL+d85yemZInNoQU5GZyrD+u/YD1leE5DS2GChpeEVjrHvjHZzNc9p1wlTNPrRhAARC1FxeVM9pT64yBNsYZs3PZzCwl85TijtwWNjbHG8TziraS94XAftFkcfm23S086g2tMqCuYb4rLJm1jPPOFzY7MZNJqH8qxnZ0j8HffmH9FUy/FnAjo6XC2rsfoeZctW6L0+cchzRGfDHJvvBgLUVJrcPicClSsUHxAQs4zTioL8SHUr6aNty2HQtD2bEo3oTXy3EeSxIAPoDH3dL52B1aIC1J+6E6c5wEiq/1u3pX1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eERn7tzeXllJ6ydylrN+4RDwxyrC28x7kFW06EucPE=;
 b=dnfWRxRDucj15SnMJTpG470/GRIb9yYju8HduVx+Q8IDXcLHWBMbgOtCVLNi/6OAWvgzggzZRdtYseWl6HErAoRER06eTPSeBhdQV1wSzM1oXGMDRXOeBMoQvLRGOBoKaFzETuQhHRxZiZJPLvkJhaCaZBeOVPHmWdPWbH3HAjG2y1PlRlChhPiimr1MOUo+dPUwbOCijzp0VxR7X1PmcJBTpvfcS9PsLgaK6VsxrOPaXu6N9qHadnQnLgMIRvk10JtMfQdd7FNWMQjGWXlLkvaikuqMqcpWoSzNr9OfZohjinJ3c8/fUnGBBpZLVUpk5Bav1OvCTqWmwqBrQUcRyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8379.eurprd04.prod.outlook.com (2603:10a6:10:241::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 10:23:22 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 10:23:22 +0000
Date: Fri, 8 Aug 2025 18:17:58 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com, 
	o.rempel@pengutronix.de, pabeni@redhat.com, netdev@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <5zmi34vrapbrdq7tthv3u5ng4laaqgcvxsuev2urf6mxxae7lh@dwfu3xn6jaqq>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
 <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
 <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
 <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
 <aJOHObGgfzxIDzHW@shell.armlinux.org.uk>
 <2b3fvsi7c47oit4p6drgjqeaxgwyzyopt7czfv3g2a74j2ay5j@qu22cohdcrjs>
 <3mkwdhodm4zl3t6zsavcrrkuawvd3qjxtdvhxwi6gwe42ic7rs@tevlpedpwlag>
 <aJSSNg4aZNfoqqZh@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJSSNg4aZNfoqqZh@shell.armlinux.org.uk>
X-ClientProxiedBy: AS4P192CA0048.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::23) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: 678fb157-7783-4f0c-5ba2-08ddd66599e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8HK19Y4+PMoqflcLwtoRJnmCXMl/6JfUS5e961S4+2qqDRz53ZsKFCHxPrV3?=
 =?us-ascii?Q?XmVLbTgW2VoyGg6Nui3x2iPr1hfuoUWOATmGMu8haRkz2w+eA41A+fayA/Iz?=
 =?us-ascii?Q?fE+DOcTFP2MyJ1Dw23Ken4CLICJ4Fv9mlbawkgtRWothVCC+BldJnjMstPVw?=
 =?us-ascii?Q?JpTxDY3Dz3dtFn9hc/Y18Kvy1EwAuDgiQuIPUyFzDznmjHMnnSmLn9+ze70S?=
 =?us-ascii?Q?vvu9izjFph8IJhoF586iEFdHaLF1UbCOJ7JiTFvlEkzPWGjOYSShpIN0xUki?=
 =?us-ascii?Q?XQKA6JcSunHvF/ep9fAqWE/AHIhXOv7jvZu4/5eb1Zc2h3kgARfeKs6YDelG?=
 =?us-ascii?Q?e9KRrB6uPWWSWkXACD3S2M+F6rx/A75vZKSA5zznXHT+2Km0Tw2H46dmZY0M?=
 =?us-ascii?Q?fYK5uiIQgzHs+iIVkCn3Ia8I560iLLujRMo0agbZDN53/iMvfrxXDtZSqmkF?=
 =?us-ascii?Q?/lQZ9fwetnMTGHXhNCev+MLU1Tenkq2rwPtlb+PkphxGTpr+peGJ1IMhIzrC?=
 =?us-ascii?Q?oQwh55O/Z9Y0FUHDjUBG2dcNnggmfwN+Oh9fo3fyc6ilNG7r3w8aIxLwJFcT?=
 =?us-ascii?Q?PpwXz06DpS7lZKiosYui9ThmyJw51t0mYAjiqKKD2b0BK8cZSmGhN7o1bIC/?=
 =?us-ascii?Q?zS+pWPgevxbPo8t9N9r+w/CHVPXUIbvTVfGZN/xuwIdPDMSu8es1aBgnNHmj?=
 =?us-ascii?Q?wE+Ok3zO41Z3b7+MLw1JPDvQt0ICEkRL7Vs8+yPz3OyW3Rax2FreRFtKNNpE?=
 =?us-ascii?Q?3XjL2cgaH/f0dNKTQcuQs8SenMjdBowSsTQ2CWN9hAT9PRxKIhNi7/LCStSK?=
 =?us-ascii?Q?wq8WOEyMRWvXwpXEga+2vVtfEwyJ2GH4x+6PFzUsGje8SEh8R6GI2d4GTHRD?=
 =?us-ascii?Q?AkmQslk0rim5JfuzSjTLD/Rg86+0UKeuPWmPDSBj6t8rY2PWBuHMfVZFRwQN?=
 =?us-ascii?Q?OPkCqvlDYPpDPKoKhhI23f10YDqRHiQ82h9N58H1wylQQl9XSKym1y80W94V?=
 =?us-ascii?Q?DfRmmUEdYHHIZZVdGnuGon5kRqKgzj0vpb/GV3wQ9e5ps5Eu+vYicOgfYhqP?=
 =?us-ascii?Q?/SNJ2HnMONqAS3NQjkQprkPHqLDdbvjx81wNM2mhl3zZHL6XznIHTZoR0zgH?=
 =?us-ascii?Q?NvyitG71HSDxcRxwXDl+PagY72iJqXre4rZs+U2gO7n/ZJFJ4vTrQqgOWA/m?=
 =?us-ascii?Q?x3GuxHAtJBU/sGeV72vK+e77fZ24rgnMOQlRRhk7sWfz61z1R0+8OlBbvxpS?=
 =?us-ascii?Q?SSkxqfhXOUC8k/G+geDe5mkJacFY45YwTRukp62+CffKWCisLMuv30nKddNC?=
 =?us-ascii?Q?QtBAMgbt/bjXY3Ef4nbjO9gyP13LJ18XwnVNHoTQyBmVczjeZCMAgjUjIIJo?=
 =?us-ascii?Q?rtPkzCJb51HalVw2Wf8iu7Q+GspGb/gJ7kn3YhehVKMwkv/y4mjGeGN8Hxas?=
 =?us-ascii?Q?vwpyChMMtdo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2a9hFk3mcp+P65OC9QdRjBrWD24fbIgx5wD0oWKZoO45qQ1l8mIU0hsGAlOA?=
 =?us-ascii?Q?S1QAy20La7bdEI/MhWmJ90vB6ZxZH14PL3OLuAoGZNCsBdn2PE040BMT9jKr?=
 =?us-ascii?Q?b7HrEqyYBXV0u+FoGI3/0pbwTYHLapVcXvElDxYkl065kbjZElvOmHXAzaX+?=
 =?us-ascii?Q?J5zkDXRhZoUcRD0IPPoa9gwvT0VQJ8seGuv2/nEpVSQ7dJmsXUYn/d6Mbo/s?=
 =?us-ascii?Q?Paw0DB9SCz0512+I73DVdkdp9pekfRq9PntApPL5JF4KvDKPMFI/rZzmb0KN?=
 =?us-ascii?Q?JZwYHE5FsKQ/+f5pzWz71SVftByTxdNWgYK2xpNWmUU6cawmjCVkRB55P4/o?=
 =?us-ascii?Q?qmf5LMLn4lJs6S2JQ0+twwsMeX7JGXtZTQTj7nEqfz9OEQB5gogaPJdDLBi0?=
 =?us-ascii?Q?plFITUpaeL6v2ihlt5xmIadHH5G44iP88o6joJXzTn1pvfBzKeUNtlVQ/JFy?=
 =?us-ascii?Q?xHAPrea21/7c3gW5CHdblgvZk3FgORDuiyoBLDGDshRVTfGh7f82/0va2Cp3?=
 =?us-ascii?Q?iZ78uAmaDSKmtNKiuyF+G/qEMFHwaHlG0LDpiugBNr+iDSgkSier2eQDivzX?=
 =?us-ascii?Q?2JICrKAF/uN7LzqPTv/vtg6wg7rzjJVZnjGHSaKrqrpTABCHbtB/TASX0C27?=
 =?us-ascii?Q?SrR5pcq8HjufYHYFHqj9KLFT0TRSHS16FnQTnl6TFkZOZfGgk1xT7z4xVQbd?=
 =?us-ascii?Q?3q/XFvoyovc34nXNJVgAvXqaKHSIgfaoJa4zpUED/DSwPz411f7TIDL173cV?=
 =?us-ascii?Q?IZt7Lx7iZGf66+OJrDc1dL6DrGkYgCamaLZiXEH6FeyW9UHK4/bFpaq5k2tp?=
 =?us-ascii?Q?nrvoUpMPx5hUeYXK0KHBJXOYGYka4SbFBxPxlTWIr5Bx+fgzSN6jL1Uj2OYP?=
 =?us-ascii?Q?Q7J2cXnPILhNiPap+1KFytMRx70V79f/QeDIKljV2pzylMoo93SKLT8ljCAg?=
 =?us-ascii?Q?1UY8sWWafcXJ1jhy6PHIOeyc2zkNkcr454yU0UJGv7/j6/dWiCypfoYFVISX?=
 =?us-ascii?Q?lGn8dGR8Kke66gRaCLRc4im8xDeyQ6OBNCPUbo/nIuPtNDtE7lCrA+Xv7gbh?=
 =?us-ascii?Q?MnI7Up3u+V0FYakPgi/8Dz3OGT2axcS9Azoh+R2aD6bfTf8UDA9lt96JPyOD?=
 =?us-ascii?Q?PoLRIwqZybIBvfWqofhND92GUqqcuGQecoZgYfZ1B3CXJX2hLKFs2fxrQOWA?=
 =?us-ascii?Q?XLSPvT074HT+AaUfBRn4XBCvKbFKii0a/CZIYg/ADVPpPFpDqj3+uSAIAvtW?=
 =?us-ascii?Q?K/gFW5l/s+M5c0Mb220TeZjJBHvLb7JmItWVIbDbI++IjJ96TwTdFBVc+2YV?=
 =?us-ascii?Q?i4pF/e2yY5i0INOAfjTyG8JmYGQSJKQKzgfLkvFWTUzzwTNw46vIPBVsv4jD?=
 =?us-ascii?Q?GcTFmkfzDN17CJcmQcq7mWOHzD0Ay+MZWldAXjSCzD/b9WAf7Xli5SuaHCXn?=
 =?us-ascii?Q?eKVAXe0TmVY8vyv8OFdg7MMQZXVlDu26VC5t1Gdu5O1SNtwDLuqm8RKZfVEO?=
 =?us-ascii?Q?+T6BEbZtnWxQesGzOL8Y6X5rGkDlWZvPBouUMFrB7MslTvFfsgW0H0R8w7nv?=
 =?us-ascii?Q?K0cl3cmyh8SgnhtGqOCMWHj/XUf+va8WXvBDx0i9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678fb157-7783-4f0c-5ba2-08ddd66599e7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 10:23:22.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Why7u+kIxSMtf3qWrwSd3z8zri5yU1CNeTaAUpxmN12KNVoTU+ZJM4ntoi3X4Jglmn5KZkzesW24zRpYEWMH6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8379

On Thu, Aug 07, 2025 at 12:47:02PM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 07, 2025 at 07:21:46PM +0800, Xu Yang wrote:
> > Hi Russell and Andrew,
> > 
> > With more debug on why asix_devices.c driver is creating so many mdio devices,
> > I found the mdio->phy_mask setting may be missing.
> 
> mdio->phy_mask is really only a workaround/optimisation to prevent
> the automatic scanning of the MDIO bus.
> 
> If we know for certain that we're only interested in a PHY at a
> certain set of addresses, then it's appropriate to tell the MDIO/phylib
> layer not to bother scanning the other addresses, but this will mean
> if the driver uses e.g. phy_find_first(), it will find the first PHY
> amongst those that phy_mask allows to be scanned, rather than the first
> on the bus.
> 
> In other words... it's dependent on the driver.

Understand.

> 
> > diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
> > index 9b0318fb50b5..9fba1cb17134 100644
> > --- a/drivers/net/usb/asix_devices.c
> > +++ b/drivers/net/usb/asix_devices.c
> > @@ -676,6 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
> >         priv->mdio->read = &asix_mdio_bus_read;
> >         priv->mdio->write = &asix_mdio_bus_write;
> >         priv->mdio->name = "Asix MDIO Bus";
> > +       priv->mdio->phy_mask = ~BIT(priv->phy_addr);
> >         /* mii bus name is usb-<usb bus number>-<usb device number> */
> >         snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
> >                  dev->udev->bus->busnum, dev->udev->devnum);
> > 
> > Is this the right thing to do?
> 
> If we're only expecting a MDIO device at priv->phy_addr, then I
> guess it's fine. Looking at the driver, I don't understand the
> mixture of dev->mii.* and priv->mdio->*, and sadly I don't have
> time to look in depth at this driver to work that out.

Okay. Thanks a lot for your input and time!

Best Regards,
Xu Yang

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

