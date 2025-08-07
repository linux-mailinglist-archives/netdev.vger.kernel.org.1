Return-Path: <netdev+bounces-212030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3DCB1D69F
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 13:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB7D3AFB8B
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 11:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C033F27814A;
	Thu,  7 Aug 2025 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oXJaDEr7"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754510957;
	Thu,  7 Aug 2025 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754566035; cv=fail; b=DbRJ4H+Vkqq4G21c+hZy7uUu3tBSfKI7kQ3ukTuubR445vHUgYsyhnCycH20FoefIHf3chElCxZvSBMh+XrNFEniBs9BevUxuy+WiCxibZ+YoQrvh64h8EV/ULVDrICSdiLH0bbYu1xudeSbb8JnMvYUea2gGBJotaXQl00UbWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754566035; c=relaxed/simple;
	bh=E/88ov/x223XIwbZ3mzYHUNcIl4GmP/M/LyrVHYhhB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kFrwjyqO0ByU9siDIUDXwLh/hHpz8D0kDiWRa97L/gpV+M1UfJjBt5p844naAbtJpaxGvGOr8QOYU6LD/HgXr45Cu5fLfe2Bc7KXYpQO2NwQ8g3H4gLBprq+ywVicu+5arCFAVED9ll3cttLdaQQNFFuYIgy+A7mbArxXORl9/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oXJaDEr7; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/dTOQzU7zL/XTc/5fOUlufV2ule3NhCcf6mX0Sn4DNDd4zpVuBp1LJ0cU60H6e71X6IfwBFp/3udSbylciX2/bQSQVjBVTxG7PrFkd5euViN63B8aBNBJrxn9MiIcIUyqpW6X8w+vpJPYwKOFAOtZi3FqyfgmUkjJf0WT8wVW2Iq/fdeWurq3hyNdz9ww4PomuZhc91pTkoyisp/pe7sWjLF7dsrufsI2h+unZC74M0SQN2nLKo2KfvKW9netRFWHSnVJo6JGnVTMPDv1Zd3xTcJEDaPqWyTfC9oDg36alV2EKhaFEcNiUkBkIj5zWt0xbHL/eUZaKXTPLnIN70Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQ25TxmlEDdIysoZhETNnsqcWy5ROS0ceUv5UG3TtnY=;
 b=k4c18cD4vGuFnsy46hNpM54RV4lK+omUcR8T3b6fBV6ZjaAhtFA04P+kPjAm1JeXqeIgvc7pINqnjkZ9nXduZSVD5bI3Wuby5Sssbb5b3NU3XGS1O5epalZfO3IYqQ80I4DlrvLXOA0pgYqNMmZoYLMX/md9p4tNNvQ74uwM8OANFKF0ps/9LsQHb9PrCRGsAgAvvvDuuppOLUqbBzPvQjkFK+4l09lUDZkFObZNIwrH7iD4ooWYFoF9K0GIxZcNdUEojXohsrkh7pXhF3s0W5YwxZ8+bMyv5DC8xSRVmgCYjYUWJFydc4cpJggy/jJ8iLt9CsOSg4kimMqnaXMJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ25TxmlEDdIysoZhETNnsqcWy5ROS0ceUv5UG3TtnY=;
 b=oXJaDEr7hAk7Lm0TOOAw0haHm7pSf/2q6Zz5FBK2aBqyZszXZUAVpSfiVIV8AMrJdGC3wdhDRQ6Oaepw8eFCNL2eXnn9eoJ2FmmpJ4ELefj+twPuiDk2TLCKzXQt4bZri7rjyi7jXvXVC+F/JX3l1ctdL1fqd0Hwrw25kI/vss3SZ9FK9KMO9OSqmegfo5wMR5+Kr2PNtpSDndqDfEYE0PElAVbM8u3NFCSUlQdG/gU08Ri8sdX9ucro3fc2PfRAZcYdZR0r6TFjDTbYHJBIrlLvxacINjpTgocRWBQqI873N5z2gIBuahTodaEXdvOmyNOAkUknp6OyG5KZQmmYew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB8020.eurprd04.prod.outlook.com (2603:10a6:20b:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 11:27:09 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 11:27:09 +0000
Date: Thu, 7 Aug 2025 19:21:46 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com, 
	o.rempel@pengutronix.de, pabeni@redhat.com, netdev@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <3mkwdhodm4zl3t6zsavcrrkuawvd3qjxtdvhxwi6gwe42ic7rs@tevlpedpwlag>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
 <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
 <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
 <aJNSDeyJn5aZG7xs@shell.armlinux.org.uk>
 <unh332ly5fvcrjgur4y3lgn4m4zlzi7vym4hyd7yek44xvfrh5@fmavbivvjfjn>
 <b9140415-2478-4264-a674-c158ca14eb07@lunn.ch>
 <aJOHObGgfzxIDzHW@shell.armlinux.org.uk>
 <2b3fvsi7c47oit4p6drgjqeaxgwyzyopt7czfv3g2a74j2ay5j@qu22cohdcrjs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b3fvsi7c47oit4p6drgjqeaxgwyzyopt7czfv3g2a74j2ay5j@qu22cohdcrjs>
X-ClientProxiedBy: AM0PR02CA0116.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::13) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM8PR04MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 26835cf7-f7bf-4a8c-163e-08ddd5a5587e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J8b9y4PogCnrT/03elsC3EjXsNbfGritsceLt5HCjYs+C8ldx4mZ7a2Emtxz?=
 =?us-ascii?Q?TXAi0tdEodA4UgkYkK52UKp5Cu6KQUul5dsOqTV2p6SvLuUGT9Y6ABfHunke?=
 =?us-ascii?Q?tr/EwvKuxZPU9bXU0KKK2ZPOIppMk1rZNEnCmOwlIAtr8+8cQoBUMXnRaVsg?=
 =?us-ascii?Q?aWiBWhcljhAe4+uPet7GKRG12dAIqKLCfC43jzf+Gpn5sbwUIvZ5wThYpPv1?=
 =?us-ascii?Q?9FmW5YtBXrUyxePtsE3uF7obNEREJnNvEETHpzSNoM3pzOy0h6FZpxbstzho?=
 =?us-ascii?Q?nVNTKocrIgDctBUxabwPCiLQTfppeXnsanU5GCtSeEbNuVGO7gW6Bkb7Ay8y?=
 =?us-ascii?Q?GrHHvlv+0B32jsow56LGVa/Ou4VM4XqEvWjfVE3NjC/A16J+aBB0u1/WroEq?=
 =?us-ascii?Q?UhKImRZlM1HoPxSdtAdSSbwSC02RgTpOLb9AMMbjXcKMprAH8mImZUzaFJhz?=
 =?us-ascii?Q?/QmXVDapaEa9sUBG9L+cW2reDsKuI15RVicUw9pKYzUO3nqAEw5e/FqtonpJ?=
 =?us-ascii?Q?Wo63r5KvdO0msdvyMS9E4K8EQ+XKipQDW9Wl497QG2ozU5gOce3G2At5BQBo?=
 =?us-ascii?Q?6jgfe9maf7zdp+3upv8C7wtL1PG//KGg1yrvTCu3ibRXTPePTAiCSznma5hd?=
 =?us-ascii?Q?DtlDD60IdzNjeoi52YJBoe4zRbO+GVCoT+5rVjRPI9JokXaZKlmolNauZ3e8?=
 =?us-ascii?Q?/hHJ5dDqSNjbZfdK8I/HhRZJvaPxxZV889RTHED7idvkktdgCtEEqi9ESvQf?=
 =?us-ascii?Q?ciptoydC8DibmTxbJ2z7ZyEJ6c3hK4WE3liC5v5DoZI7r6W65LEdm7DE8NMk?=
 =?us-ascii?Q?9V1Tcav9Fz3o+pqRxC4cmq1QZsdB+86Wf8KI8qOsieqKLKzY8ztUFub3FaSm?=
 =?us-ascii?Q?K5WYVmZ4mB4u9aljnSON7UD7GlO6hecwZUxsGFeW6ncagiYSqdzAYUhuglpQ?=
 =?us-ascii?Q?pUp3cS9ow4ZSn0Gyg7pb2mxguzmWLLv0SZQUKCYAc93EWq9S2qXep09IcaYr?=
 =?us-ascii?Q?0NSpsehmHmrXoiilZsoCJ4rOfFB/Ljak9zMZlyx2/5zx7ri0lA5rg+bhZ2J5?=
 =?us-ascii?Q?qR0DFTgLcjm8XEVmjmrV+2rBBjJEXrYeP68qXV2M4JXKW+VI3lS90fO6F5f0?=
 =?us-ascii?Q?nmXdaiixPSnew0eqcWfkhpSZLPNONsMzCYxOgaxaVmRuyPbQD5rKG5C63Krz?=
 =?us-ascii?Q?6HnxHg2+kaGGpq5mrnMhDdFXLtKev13RiKe/ujcxrIpiiChzqdLOFzgO2Fup?=
 =?us-ascii?Q?eztfbwz8QOjMCGRxqq3a/NdnZzhh00zQTwryd5I1V+iNj6kpbScFZ2mu9CwL?=
 =?us-ascii?Q?/h8YA8NHyHz+D2TpRJN83eUWLja6nT9T0wZisfZJNJsxMh6lZvDbIvB8ZNaY?=
 =?us-ascii?Q?HXziWheFsZFwGwHV2dXTpeBTLnp779AGn+Kc/dbXVSousPj4REVrHqyoP3Ez?=
 =?us-ascii?Q?tJfaC1JNTeI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?19az5Pn8hAuUbV9qRinTCKo06rpXw4i9aw1O2bEsWlzAq7xmWqZXKHl0becB?=
 =?us-ascii?Q?xhV5GupTSc5GisYhXEtIUj1QD1fQUsROrOpXSNmE0VdcTPIMlSXS+TGB7u+V?=
 =?us-ascii?Q?WlefOHlFdXd3CYryynPVEEwZQByVuCtkVXU7rRKefcsnaXt+WHzCy1bH8Ky0?=
 =?us-ascii?Q?lHvf2C8iGNe6mE12G0XcTtSQqzra9U5iS430sus/ozKvUEEEkC4V1oechhur?=
 =?us-ascii?Q?r7fmSySKkYdYhFrkhYDj2pAt+unmxte8R4MVVgO8ntr6yceFuHd511izKEpP?=
 =?us-ascii?Q?4EwmAspnLxSgNvmk/4HBYAPaUE3mmxrfgRBUROpUBGFDbt7NvmnYBgEx9lHd?=
 =?us-ascii?Q?tCGsc+6/9twtj50XPvZcWASFXioujPqzP1xd4OqAo7wQDOZV2ysOXOSqMtFt?=
 =?us-ascii?Q?+upyptXjKY+WkEwFRPodmKKf/cf4+7UY4P7fxcipYna2Q6BAhFNrCmERu3Or?=
 =?us-ascii?Q?bKOJz/9AaP2dNQ82BP3y26g9YBz7VJOwoOyTVFMAI3Bo5lh+QbE57IeD4d6f?=
 =?us-ascii?Q?0yTDoxt8lEdIMKxdRsw9W7T9MaNqAz9goW0ifihcwtGQaqhweYlKmWzm05sy?=
 =?us-ascii?Q?In4sm14y8ZlA7qbA3A6dFCoGo33YFpyrAmkcFIsYCkaz3y0oe0CxCtxObWJB?=
 =?us-ascii?Q?+2hZDPjxV8kEpARhe5rFJhfhOF7Da4gdKIoDQRoMr+SMTKBdramf5gv8ONxx?=
 =?us-ascii?Q?dNOFoUo8rCQm0WlGYgPqUctURnXlTRH7K8bRFOepGsIHR3ewG+Uk9JicaOxS?=
 =?us-ascii?Q?nVqkj9h2EEJwT3IfK/N3GMDa88L4+7wvROTen49TE6HawavvJxEPJFveghGC?=
 =?us-ascii?Q?/7hqRfMUVbh9LBG2s0oanLu8sDWAGPc4yaM9SfDRMOGRso665i+3K46+F8i0?=
 =?us-ascii?Q?/YEo6ErvbEEVAsT9QD+f1J3IzZ8tf/3MDVLGP3ch/m8XkZNAfD+ogIngP9j+?=
 =?us-ascii?Q?VrgUJtoPjMxzC0Bj9xgdlhLL6ChZWZGEtioUytGbIc+7Iqfz//CU9avh9Ysg?=
 =?us-ascii?Q?DQhF7SwEGPVpOvuwrspO73zdpZ8N4NRootrPOtwtxmFl8bY0jpacuS7dVMR0?=
 =?us-ascii?Q?RjTcn3xLvZvyvtrwAJsAcJXTljcUSwcJL1XO4SiE+HgqzUwCeWYUhB6E9anT?=
 =?us-ascii?Q?SVVSq5os8/9cajIJFCvBgUIhlvZu5V8DRa05bWHT3p971iNtK7RStM2b1TtX?=
 =?us-ascii?Q?y7W5ms3mCquPHgpnTsD+O7ccVI2NKxVV55yqrDzi1Apa+axG7VhFMJ+YiDe4?=
 =?us-ascii?Q?ds1/nMclziGK+M1RYMOr5tAP77OcbBWxtjXIS6QoMUyAJt7ThxA+enqdUWHp?=
 =?us-ascii?Q?uIxisy1yWmntuiBnyFVRA6z73wJLqbceDM9jTO1uot47luxws4v/7gGZzCBG?=
 =?us-ascii?Q?27Bu8d9BOKM9g9281FAii97Z4K/RpSQ4XDzMD2dYtGwvt9SeFqvyfMfYBhvS?=
 =?us-ascii?Q?DM/3zMaJswoHoLWuHL1EVAT7d5LUYp+yQim3jb74MLRluJML3wUa6oGAajqQ?=
 =?us-ascii?Q?g/6o16JB0vUBlHpLTqyLsJM9e3g0p5ZQtfraIRgfl8HwKy3L4o6BJYzP6Kls?=
 =?us-ascii?Q?SkS9dXpsQfbWDqxAhaTN37soIkfHSePklvukQorM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26835cf7-f7bf-4a8c-163e-08ddd5a5587e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 11:27:08.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvB9pDxWiEksOB79ifpSuMQQkezqa1niszwddoNncYE9Xy6dPPRd0wDHk489ZzgTPWkfyJNsKbe5znxc/e1qYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8020

Hi Russell and Andrew,

On Thu, Aug 07, 2025 at 05:23:24PM +0800, Xu Yang wrote:
> On Wed, Aug 06, 2025 at 05:47:53PM +0100, Russell King (Oracle) wrote:
> > On Wed, Aug 06, 2025 at 05:01:22PM +0200, Andrew Lunn wrote:
> > > > > > Reproduce step is simple:
> > > > > > 
> > > > > > 1. connect an USB to Ethernet device to USB port, I'm using "D-Link Corp.
> > > > > >    DUB-E100 Fast Ethernet Adapter".
> > > 
> > > static const struct driver_info dlink_dub_e100_info = {
> > >         .description = "DLink DUB-E100 USB Ethernet",
> > >         .bind = ax88172_bind,
> > >         .status = asix_status,
> > >         .link_reset = ax88172_link_reset,
> > >         .reset = ax88172_link_reset,
> > >         .flags =  FLAG_ETHER | FLAG_LINK_INTR,
> > >         .data = 0x009f9d9f,
> > > };
> > > 
> 
> [...]
> 
> > 
> > Notice that the following return the PHY 3 register 3 value, so
> > I suspect for anything that isn't PHY 3, it just returns whatever
> > data was last read from PHY 3. This makes it an incredibly buggy
> > USB device.
> > 
> > Looking at usbnet_read_cmd(), the above can be the only explanation,
> > as usbnet_read_cmd() memcpy()'s the data into &res, so the value
> > in the kmalloc()'d buf (which likely be poisoned on free, or if not
> > unlikely to reallocate the same memory - that needs to be verified)
> > must be coming from firmware on the device itself.
> 
> I confirm it's returned by the device. I capture the USB transfer with
> an USB analyzer too.
> 
> > 
> > asix_read_cmd() will catch a short read, and usbnet_read_cmd() will
> > catch a zero-length read as invalid.
> > 
> > So, my conclusion is... broken firmware on this device.
> 
> The data transfer function works fine on my side. And even if something
> is wrong with this device, the linux system shouldn't be broken down
> because of this.

Thanks for your review!

With more debug on why asix_devices.c driver is creating so many mdio devices,
I found the mdio->phy_mask setting may be missing.

When I add mdio->phy_mask setting, only one mdio device is created and the NULL
pointer dereference issue is gone too.

root@imx95evk:~# ls /sys/bus/mdio_bus/devices/
usb-001:003:03

root@imx95evk:~# cat /sys/bus/mdio_bus/devices/usb-001:003:03/phy_id
0x02430c54

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 9b0318fb50b5..9fba1cb17134 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -676,6 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
        priv->mdio->read = &asix_mdio_bus_read;
        priv->mdio->write = &asix_mdio_bus_write;
        priv->mdio->name = "Asix MDIO Bus";
+       priv->mdio->phy_mask = ~BIT(priv->phy_addr);
        /* mii bus name is usb-<usb bus number>-<usb device number> */
        snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
                 dev->udev->bus->busnum, dev->udev->devnum);

Is this the right thing to do?

Thanks,
Xu Yang

> 
> Thanks,
> Xu Yang
> 
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

