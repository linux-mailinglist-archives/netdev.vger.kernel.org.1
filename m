Return-Path: <netdev+bounces-212022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C1CB1D4B4
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 11:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8A71725A2
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2932221FC7;
	Thu,  7 Aug 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S/zhnXxG"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF4B1400C;
	Thu,  7 Aug 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754558931; cv=fail; b=uBdNbG8sC3mJkCxyzagtu9lMI6uF5KCpGBTyw6OVZNlahzEgqqgssypV2BL01OPUE5IcXjz6/USa5Ekvl1AmAidL/uGEMLd3vcr+gqRx4S2DlDlzG9/TUYex37Gz6WaYxuj+6bNp8gYAArjlbab0oCpAZv3lkTS9qT4tKDgDXlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754558931; c=relaxed/simple;
	bh=AYwq58YUmVERRbEqror/h90G6ZDnD/e7Uq0+7onORXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R1qtLS1GKyLtyCs2WdXpfv8r0jgI5CqJDtpIJhnXNel6n9J3G6c0ecr2BflbK7SJBboKT9uKOXK96ssedoo596PGWKThfrISV/WFuBfuNBtAL6uZ0E2PkVJ/k6Nfe0wgVA+1s75nRLH8/9nRR4YJeiWJktDl13NsfQbSjA4fWls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S/zhnXxG; arc=fail smtp.client-ip=52.101.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDzvTFrMjQZp/04hw6ocs24ObwyTJN0HgWCQ7yR+LFSFXbhAbLU8/7Pq7wVuoQet42L77619A5xGQ5i7l7GY8oBNsjkMM2lCa08dnf//yjVMdbQdotqMbeE+yhUZewr3Yr2SQxEbeqlw0Yc1qm5kuH0lHBJ5sXNtyDZttuk387bGLlL9xBdoPE5If60o52YtGl+cw8HjoQpy+++8YMCMPv5Ue3ovM86ZvRTGlUISP0u4Jz4aDPxO88xATusrp0fGU3aDhmUSviXktOy3o3BQOLqp/Pjj51BbV6Kn+9On4v5hceesx4eRi7P/MX9ekIo8Rnbvd2ZXSzNQA0jFZ5bO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98O8n+BNOyDncmB5LcPswIpNNGSqyMfgwD8gxzbcsqk=;
 b=Y6ZRd8FaK2rbvPKj3A9TzE+xKAVD3sDM4TVEXpcw+MDG7fGtUYztlWwrahpA7ckIvjnkB+9I/6GsHuWzi5YFCtunw8Zt3nRBAGkpmrtnYTmItGgXIXuyGNQ4hErDpHBDvRWPPgFnyO75mBlAJum3KNYoZprbWpU7dzA4ylIqJLZeMbqxQ63KdbFfm0tKp9M2QDGCWDifBGVc5U0nVBs67kYDD3TFq1PIjDyHt9NjjVaPP0T+A/zGGH4YPV2I8eMV2YJer+BomxCi3qt5Kec6ixG0tDW2yLrNDzjtVcRJdhFjd3KZKOa3Jk23Vr/7REQRzNjojX39HegE/404A3RWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98O8n+BNOyDncmB5LcPswIpNNGSqyMfgwD8gxzbcsqk=;
 b=S/zhnXxGzMsGGXsxT+A8P4muOoaRqNfyiRqobJXdEzAZjVcx8UUCEn278JMj0uZ28Lsug5taFS1LzCpYYkYqBT2WG/UV1zVL/3IglXbwmZUxfAEG60SE/Qa+05v7Py9Vj4FOJS9sF7uOSO4WwPuQu2IqAXC3cKolBEPDGzDnG69vDuXYDV5WoVUsaThuUyD9lRv5D2Fhk6jDgFZ3IH0DGpJxLdDvOwCcPmz4DFvIN27HdGhuBiNIFcG30H1rPdR79DDVIqDzce0WqhvcGHPoSjeyY4h46RsjOr5FBGEy/N9qu9oX5jVKOw1qvI+gtSzdjIeh37eM4928p63Fw5C6iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 09:28:46 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 09:28:46 +0000
Date: Thu, 7 Aug 2025 17:23:24 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com, 
	o.rempel@pengutronix.de, pabeni@redhat.com, netdev@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <2b3fvsi7c47oit4p6drgjqeaxgwyzyopt7czfv3g2a74j2ay5j@qu22cohdcrjs>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
 <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
 <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
 <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
 <aJOHObGgfzxIDzHW@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJOHObGgfzxIDzHW@shell.armlinux.org.uk>
X-ClientProxiedBy: AM0PR02CA0195.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::32) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 872c9f20-3587-4258-6699-08ddd594cf37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ox8seKhoi6FxxMX/w0Xh+TpahIdAKc8IputH+RT1csLFQk6hlHk181wITvGD?=
 =?us-ascii?Q?rleqMwi1dZ0NPBdFha1Mmu9xFUCmuHCR0V7NI0x/z+VX8CIJLhBcEkIM/TVY?=
 =?us-ascii?Q?EtfUhKD80FfvbtWKHWD9zqBOT8hKhmkiIUY5Y9N7YuaJuMSZyntKBKYa7Omi?=
 =?us-ascii?Q?k1MEPV6gxZ/nDXSnQjUWI58saYsLH52S9m/vgJgjF4QEqvjUx5xK1/kbGQ83?=
 =?us-ascii?Q?q8AeTVX7emosn6rrcFSN6Cg0gqyoMjzvFdZm5ksTQF6Pda/2+7rkec9cJWun?=
 =?us-ascii?Q?QmOwGxIPrVxoU7FCIAE4pamByOwGxZqvqjL+BsavhnJIDHCCIN6SzvNOdEtK?=
 =?us-ascii?Q?RCzp7DCLd6Ea5xwpyCjcxW/qjRHZDrNPmvydI+P21imfY1YjP4Sccix+GPm7?=
 =?us-ascii?Q?z3SSXtbkOwdNoC2TxSYxMqeaLHUq1+simUmzVRebG5AUW5mMjdUiRv8drG88?=
 =?us-ascii?Q?grhi4BR7b/Y8r/X4wW8BVTymG7vtU6zQHQNbYuzjcADjuri4qs50JjrpU9sh?=
 =?us-ascii?Q?/USa2aLqk3GNRJ4NHEYINxomsSTIdn5/fPY+DgwCdgLNmOPmfXZcMVt1VEBQ?=
 =?us-ascii?Q?4Fh8jBFCiMdPjcUPXiFmTtSvvlEBhNSVShft89MtjtOaMbX35yyIQTC06HAA?=
 =?us-ascii?Q?62CRnalqqHN5V8HGDqR9j74Gg5TTIqlUmBtIh5wE3T1x8Mch0IBpBwkEGItH?=
 =?us-ascii?Q?DJ/UEkYPLKmNLQQ6Sn1PwX5CS4RG4Enw8iP/IVkWv0mHM/nsCUqYk+vCZWZ+?=
 =?us-ascii?Q?5tqylAWXPmoYrIQficmFfUNO0mehbobxZexQiHN1xNG7H2gRXwIcT3jwP7AY?=
 =?us-ascii?Q?jfgenfHPLfyxlprccL87A0UR+xvI5jpATJzhAQ5H65QhP8zBWCseAFaEv/Eb?=
 =?us-ascii?Q?stDfK+wpED2lz+UcWL3IXf5BvW5iOAW2Hrln/kR1k3/Sk0wYD1rVlapRs2+K?=
 =?us-ascii?Q?bwXp+2XlfDN4sUCZje40QQxA6ARE6CdXyt7rbSU95OE3trHAX06JtmtgGBI8?=
 =?us-ascii?Q?ErVnaBgZVvnAaH8VLeiC3L+BjCP4pdXf0T0Jqhk55IM/GpSy0EBjHYFu+fkE?=
 =?us-ascii?Q?10dQbbhGT3tbYUVzJ3D6Y6HQvpzHVnaaCy9rCt+MS28k83WEx+ll5eFJ6nLU?=
 =?us-ascii?Q?i8GFUGmpqkIsTVShmOayEjktqd0atnYG1iHHW5xqRvKUc5m1NKsEVYqD73p8?=
 =?us-ascii?Q?1zTR7BRH1CWbUuuGJeqPOSIZipxrKcTQTl4EbHQNzej46eJIjKxV3LFcccof?=
 =?us-ascii?Q?G3iuiRVSPjd0/qyrPTMKG9gq2g3VtvwOevEbSqIazvg11rkuLLS79ps/GFp/?=
 =?us-ascii?Q?z7seQwTvmvzT/h5vJIRna+s+Mih1ZqHs017/+FUKvoEwgZx0k1+FAgxYDwA9?=
 =?us-ascii?Q?SukkPlGKx7SCo9PhbSuT1sZuip4O22BiIvEMU8INmZOLTKI5f6OO90kAL1bh?=
 =?us-ascii?Q?cIURlTCuzHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9zTAIw5Vj2tCvBMoRzdRIaxuGbIDXHWuKfe7shd7IgbSJ+m+/gh6v0JRqF0O?=
 =?us-ascii?Q?4quJW9RAklFyPP1dXxybS2HbvdsvItWqckQSTIebUmDJMFtYCDjSddTKb75p?=
 =?us-ascii?Q?ushab1dPS9e5iYIg2HYMWrYpbXecDAENgh+MO0Sa18hmxJkXJDrDaklHTgES?=
 =?us-ascii?Q?Xe4pac1ltVNgbOUHS67ZuPF7Pt/7pDYA4EH0s+wqeICUiydJO3o7MA5nCv7n?=
 =?us-ascii?Q?QXD+bx1W80ft197B0d2kgYLjgRujNmZlU3IE42FhRigaDX+qs9U2oBgXYADD?=
 =?us-ascii?Q?MEkzHaioqDWXXR3B7lXStf5zsGsvafNFJ/zjfRHJHoc/ttH/QbXUmTt3WDYX?=
 =?us-ascii?Q?XIHEcMsd0qhzrul1MGITNsLVuBkEXTT5SCKXQ5L9apoIlYTaqCtHuwmaDSxy?=
 =?us-ascii?Q?/1xTTJd3KR9tvBtXWG7wOEy4XhmR5apzKpfzL1Z8MIyS2yBRE6aaLT9cMmwi?=
 =?us-ascii?Q?mJbOtCTesAcxZY3qCaqgX8CPglns+IBv97MRQRID11YVKJhUqjSGZ31Cc7L5?=
 =?us-ascii?Q?h+hOwK/Ma2t7iD7G7NdL2vFzi6S3TgaVMZIkJ7EZYNiMSalc5x6rhSCEg3pF?=
 =?us-ascii?Q?+CdEe94oIhJZGilvOu4MPgDYDvcTzsZiHRou3K0wfbSMHvgZTHjc36vcnVgY?=
 =?us-ascii?Q?tfv9GnwYjJjvKlURMC7YriwJPYOfmk1O8et/eSVpHLxnvi042RhM1t7nz3wR?=
 =?us-ascii?Q?Uh8naT9LmLYgw8Nw7T29lA2hez+MbjJQNVkicWgpoO1vslU1noEjV1/72FL5?=
 =?us-ascii?Q?TI1/uDubJhfwqIBPINp+Z+QYzmEVaJa77kLwGAZ0Dp+6wqHLf0UBE3tBV3vw?=
 =?us-ascii?Q?onIVV+DLWUYCBTjpfO33yOmJYTUhN2bibx6uELJmTRqinnQCo37C9icPotVq?=
 =?us-ascii?Q?AFcyYEq984a+bnlCtEFjzmSH/i+e8uJX8dXEHnTLpbuXAktGVJ04Rtkib6Cg?=
 =?us-ascii?Q?pHgcM4qlgFyDteLadJKGBIbjUDoCEzStkawtu+Ex+h+GQSorxDmVlhqUFM89?=
 =?us-ascii?Q?/3IDTdD9ZavXLJZPd6MSdChkDKKyIaounQrxdl2NxK796C+PXvWwG21bmMh9?=
 =?us-ascii?Q?aJHItdkUQYu3hKugRgtvV3onQAD+KRU8/KJwtqH/Z3kjZc+Z1LrpN6PznEbf?=
 =?us-ascii?Q?EWDEyLvY8XDIfVIFzPpB64/9QHgirNwnIFsc6SSgApaWQrKAZImYVB9AQmTh?=
 =?us-ascii?Q?Qc+8fTsoJGi61lN+KPUbaC8XaeDq0r+DjQ+ia4EG/p8RQhEYAEUIChfiKaBQ?=
 =?us-ascii?Q?gzP9+2sGsIsk5YjF6z2JbBRxF7+1z+5kPYfX3h9WJRjaAED+VpyP7LaxAaa0?=
 =?us-ascii?Q?D29QYmACg8wnlYYrwChdOjX1kxEBkSdoY4MWMy1vhsJ3uXtOcbFbbBmKY2io?=
 =?us-ascii?Q?J+mq1UvwWZG9wDqp++eN2+84/5QH3v2hD2e2QmFwzoTVuzZ5cMXzdO4dmDRl?=
 =?us-ascii?Q?6Hkpse1jBsISnoYW5Uyf4R5LnO7zgjsVp9131jlfUHfHt9NyQEPoHYNYd00g?=
 =?us-ascii?Q?I088nvYO19SxlKI7JqxKWlqy0SxeILX88UBxwvgItq/7KKvii1nqysMCWToB?=
 =?us-ascii?Q?HmGmh1jd+dtEd3e6qfib8IpeSTZhWnGJZIBaGIo/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872c9f20-3587-4258-6699-08ddd594cf37
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 09:28:46.7098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CctuImaogZsU2FEbszyMc4NWSNxKzQ4zaCBah469cdlzp7wnvTD7sx+IGhCmARAEIk8+u9PrNVMmsapapyJsEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966

On Wed, Aug 06, 2025 at 05:47:53PM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 06, 2025 at 05:01:22PM +0200, Andrew Lunn wrote:
> > > > > Reproduce step is simple:
> > > > > 
> > > > > 1. connect an USB to Ethernet device to USB port, I'm using "D-Link Corp.
> > > > >    DUB-E100 Fast Ethernet Adapter".
> > 
> > static const struct driver_info dlink_dub_e100_info = {
> >         .description = "DLink DUB-E100 USB Ethernet",
> >         .bind = ax88172_bind,
> >         .status = asix_status,
> >         .link_reset = ax88172_link_reset,
> >         .reset = ax88172_link_reset,
> >         .flags =  FLAG_ETHER | FLAG_LINK_INTR,
> >         .data = 0x009f9d9f,
> > };
> > 

[...]

> 
> Notice that the following return the PHY 3 register 3 value, so
> I suspect for anything that isn't PHY 3, it just returns whatever
> data was last read from PHY 3. This makes it an incredibly buggy
> USB device.
> 
> Looking at usbnet_read_cmd(), the above can be the only explanation,
> as usbnet_read_cmd() memcpy()'s the data into &res, so the value
> in the kmalloc()'d buf (which likely be poisoned on free, or if not
> unlikely to reallocate the same memory - that needs to be verified)
> must be coming from firmware on the device itself.

I confirm it's returned by the device. I capture the USB transfer with
an USB analyzer too.

> 
> asix_read_cmd() will catch a short read, and usbnet_read_cmd() will
> catch a zero-length read as invalid.
> 
> So, my conclusion is... broken firmware on this device.

The data transfer function works fine on my side. And even if something
is wrong with this device, the linux system shouldn't be broken down
because of this.

Thanks,
Xu Yang

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

