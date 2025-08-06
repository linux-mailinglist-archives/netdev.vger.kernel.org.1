Return-Path: <netdev+bounces-211882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9BEB1C2B6
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 11:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB60918C144A
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 09:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798D28A416;
	Wed,  6 Aug 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kaOlbz0q"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109FA28A415;
	Wed,  6 Aug 2025 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470950; cv=fail; b=XCzFvtsbB4bv6f0sJV8R23AAmOV598zwmOkZtHbKZ2FmJXv+fQO2l+nLXMScqVUxTZniTGl2ojCBKuCighQhrkDj/efQjmBQP7bYbr8kltGOzD6x7CPAM0GD/wgN1c2EFy159jxJ61JEHLRDHeIkN3ULE35Gua94CyU3EBLdb6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470950; c=relaxed/simple;
	bh=vuY81Z47I1cjN1rXve/tr9MloZCWAtrPhd3HiAVT4/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IS2VIMT2maK/ZQsYjf53F/ZH4r/+/Z9vBCgTPkJg3A4rACYI8X5GBnO+xNK/EL3Kzh9OWv+UY2agH7NCpjg/Kh18v25+FORrJyeZAZDUss8FsP98ySZAwR5Mgi1wLQWilj8oJ0L11Fn6Bo9bQUaC+C39+0uXCVnMuIdQTn5UzzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kaOlbz0q; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v54UDOE9GlVIYNrLoEV4U+zVSTRfKrcT+cGqJ9M7R1PVGHo4Ka3KvLRm70d5E4RFgZEjh4y6clMFN3+kCWgM1iJFjmLxjPWKLoHIqUl2eSH8pt27bJH85A+o0kqxB18NNLuozlLexWVbBVflZk8EeNQvhOjLrNBaqlZAq08VFHV+r1AyOx3fIKEQE1hvAtcIyqzRBptME3rjodi1KEs1dpAov8XEW5jnXaVXNrY6UCo1sdGvft4XzdamCs4lT0E9G55zvs4IsDig1qr84CkSWEBaSgPKke3yWJfGHDhcLTGEXnGaUMPM1wroSrisl11arLIj9mqyimHflnhMLDCawQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2DI3MQoFdBRf9fBMgpvLLUqi9sXVBZb5O7uxDnR6E8=;
 b=OorHZU1PB00Y8WsKYwm36ob6Nb38yhgn55cL4zU1S4bvY7/5crL2DzHQBfcjiuJS+QyGcHWbvFvuKJLxMr8U41Tm9BEylakqiMHAkUMt0fQwjC+V6snQZwH3wlG8/q+PvHMzfKQUe8vX/tABcOo6UiG5Uv2RzwIqvZ46eMs8RwaowlJFnGSAi4we7JeMydYMgOlFGvM5wQYEHcqo130+IX+C4ca8xmGfMyOK4WQib/X7GnsLcCHnKOwMg0ZURddoi36UsqmW7YP4MYfzi2c8/zHDd0fNMnsIOHqRG77IcIBrrBA89d83VXgum/5WoLE7AkjYDN8JGVlkguoKkEJUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2DI3MQoFdBRf9fBMgpvLLUqi9sXVBZb5O7uxDnR6E8=;
 b=kaOlbz0qs/kapq3CpE9VJ9mJnp+FbNiRW+7QBYziO6DCNMb66zzjVdwOfxPrKP9uFKvZvEWos5HomzFD3nNf4RVftbavjn1R1mrrG2Y2JxiuZ3c/Y3eStbx8eKM/0AEqo0fkttoOS6n+E6xqazT6JrbsSCdMnZa43FwEU3qnolb+mRFKMY6TOdgNhIe/49YhqEdw5X1pz/SftOXS4/Gbtmu5FFmOuUUIcbZFODfK+ERch9Dh98xYYFYToKEyAnERm+NuAB80j4WAwC99O8s7mXV6jyNlbqoE6t9saEuhrX6198z1lDBrsVWc0PhCOyp5jujxW+6wn6AFWIVa0LrjAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM9PR04MB8956.eurprd04.prod.outlook.com (2603:10a6:20b:40b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 09:02:23 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 09:02:23 +0000
Date: Wed, 6 Aug 2025 16:56:58 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, o.rempel@pengutronix.de, 
	pabeni@redhat.com, netdev@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND] net: phy: fix NULL pointer dereference in
 phy_polling_mode()
Message-ID: <ywr5p6ccsbvoxronpzpbtxjqyjlwp5g6ksazbeyh47vmhta6sb@xxl6dzd2hsgg>
References: <20250806082931.3289134-1-xu.yang_2@nxp.com>
 <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJMWDRNyq9VDlXJm@shell.armlinux.org.uk>
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM9PR04MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 143c078e-8158-40fa-d167-08ddd4c7f4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tv/fztqBT2u90H6qvvACxFhCMud+PxBbX2w5neb+KuQ6XU8b+zslvWgu5cAt?=
 =?us-ascii?Q?1R5WRaq4EbmvZE9P1qbP4ptVfzx5YM3rvl4ZpCY1/TnF7E0yDJ+FozkXK3xH?=
 =?us-ascii?Q?YtMQuOFghM6YHLyLXluHSqkryTWHhR7TFj8UGZZzPC7d0nlYHtY8eXECSMOj?=
 =?us-ascii?Q?gdqWZGoFiP+QRNR9yyfU/+edwXWdQWTRdIYLV1qrt7k8t1NOoO9li3N5kNrO?=
 =?us-ascii?Q?fYRAAMoBTeiPt1wIcqY4RTrO1cv/V7N1PjB1hH4fKLsabKPoleV2fAbDIRX3?=
 =?us-ascii?Q?l6LdtFIjYl4QaNDLPcGKK35PQueUMwuLg6sI23KYou9TmRTTG6LMELpdhVkq?=
 =?us-ascii?Q?f5ZFVo/uR0y0YHsenuMg0MnVxY5sLV9qkgqZ3+I5vlSTXMmDykcP/1P9CH/M?=
 =?us-ascii?Q?PnBOrwMV52MH3FAlP/EHGcIJh+2ZjyhdcMjw3i6hUuLee3nVq+pxtQbvhHFG?=
 =?us-ascii?Q?vIWItu8C6bQcXQzjKY+8osi0w1AH2bwWp6jB+GDbockye9a+BN5uu1ed2cOp?=
 =?us-ascii?Q?auX0YghDJHr7EUrTXH+yIKorT0eL5arpO53AlTNeYGsyXdZ82QeCOgRkwNBI?=
 =?us-ascii?Q?pGnuGwaTyixkqg9PhlkfsavZyYW9Do0OAC5+kO5XMPwa4Wz+wjBmBZaohmpY?=
 =?us-ascii?Q?oYRpz6eGvxqbiEiWBggHe35Nkdoi6SKZT+S6NvR5UUUn8mcimaVcOrgxsnOM?=
 =?us-ascii?Q?yO8k1au/r5dpvPldgFFwlCD33AkFONvji+XKYEavtMdHllr3uiS1aIiJdGF+?=
 =?us-ascii?Q?qzk+usqdF4+37dFIYkgh0DaOvx1JuZjTz+TVmmEfOfch9SU083w0UP9jq4er?=
 =?us-ascii?Q?58XF2FfibojENtx1fhGzKNef41OY42C/vGdtW855DGKkPIVTLwqSIikHn0U9?=
 =?us-ascii?Q?imPds/GO/6+rIOXKDZfQlBgkTXZjlhyC1iJRqGQ2Ka0int7Sg3uzOqgAHKgg?=
 =?us-ascii?Q?0rIpaGIHLjLzEMQkA/ODCbmJoHJG7dS162w4nCBQNGP/6LUOmrjBQ7yjtH0o?=
 =?us-ascii?Q?Rv/JbtOhi52kJsGyXuC8EBTJm8Du3nmUToozN8lWbP+3abR8yLMUT0g2Uk1A?=
 =?us-ascii?Q?DuvqSIK82f95V/pYnTdLD4RGq3TtJHkF+FRICeJdF8y0sFunz2cRKSDQeAoW?=
 =?us-ascii?Q?omLJufUbWr/UKJTNplumGNSTwap7EQv4FEGNzlHY7U+Uu7J8TV2U2IM3Swaf?=
 =?us-ascii?Q?rzmXlRlJB4MbYCEn848l2Pb96lBKCc67mIEbdWVkacy5QkK9j3pBh5/JZYIu?=
 =?us-ascii?Q?uXO0BdmqGmlqKJsEBB6btKvrmb/tVo+jzbWOqR2fWo6GA8NDaHmX3I5SYkKm?=
 =?us-ascii?Q?bpeLWKerFEQE4FHvKHCIykddmoXmb3suYjUlGoqnR99rbqDPNSd68UnZw2iC?=
 =?us-ascii?Q?jrNrshpj02xxGySseAYU+0RVTykx3cZvAq2NAa6Szh6IRvfSdfxtB05nlCdk?=
 =?us-ascii?Q?MHDRCVUP6bI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7yk2ZQrQQNOaKpSMhmy5hu4z98Pe8Op55WcCEmbu+lmDXOLeJolFGUj0PhwV?=
 =?us-ascii?Q?/RTK6f26V2A78WDbylyxcJgxq+3uJ8l0mbsUGOqXXskJ62wUt92pzgbFO9m1?=
 =?us-ascii?Q?ros1XSiYTPXKbd9g0GjPHY33mqjg6GaQymSyOxhMFrlL5bkWIrXhvhialWph?=
 =?us-ascii?Q?yfNrlSWWDF1fL38IDP6m9VyQK5A2xr/V2beZFxT4Lw8WtHmsz/cY2NztIluJ?=
 =?us-ascii?Q?x5R44KYeGpESwZdYVEVYopiFU/dhuGKuwkin/k7rwYkXduiHMUgyc/rRee8x?=
 =?us-ascii?Q?Yj05sMFjCgLMper0b+88Mp+br0ee4vLJso6QUjPLhmniU/h48FKrJ/SI3PzN?=
 =?us-ascii?Q?A+DEzdQ5aTO5kqtRkifq0F+ybvd4uJG0WcY+L4gs7RDhaNSJCVXxW9FrCqi8?=
 =?us-ascii?Q?LxUcftvc/loKrp16LnNN6WhUEmH8x6SJm+KhRJhIHnaGKjmE8azKfkqgZrMk?=
 =?us-ascii?Q?7wMcL4XlFA33ZvD4GPBE6skNgiduMaeOR84Zlt9yHQT54QlfopqkdnJIH51b?=
 =?us-ascii?Q?B4QqwVNUGvWKNv1MDDNRI65yZjzdeH2rnx9Gr8SbKtpLJCK4yi2li/sj/7Br?=
 =?us-ascii?Q?ac19M6HiP+QrAdxlaueRZcmMDoqMhsZaugbrOfoetKoDmnE71oM//TAwnNXb?=
 =?us-ascii?Q?ygYhEEvoYvtS5AThELtyfoj4o7Nq7LjsN3xWytgKcT1937uD6OtPY9MFsG9g?=
 =?us-ascii?Q?1sxmfyYrdgChtu3uCZoc/sgDMQTUcURtYU0/UMjHPcO7Sf4oOdIHgaL86SH2?=
 =?us-ascii?Q?05ugBdtYJdv+q3cELj1nBy0UB1ZbMB11Zqpep5WCyR1ZJmNV7iC2bILVVt/8?=
 =?us-ascii?Q?zFggBKugVgAM1vU+JeNBZ15l7LMPzZCQ3Xuc15FlDLNyMYE0+/2EaWOZjsM8?=
 =?us-ascii?Q?ih8nyKw3Q0RzxN9o5aCPcsoBc+CBk+xwrADqM0BpyawLGnIMnVUPHi0ZlNqf?=
 =?us-ascii?Q?pUZBle9ggoNxxHpqBlpd8AVCUQfEHcmJoYfwh20DNtQGE3aVJR8/HkKuxHqm?=
 =?us-ascii?Q?FB6d3Cf47VAKOilBYtqYVBaCQJeJV+n4lGmaamHHmsoHB9BZh/DjY4y1aNjC?=
 =?us-ascii?Q?HAf7ggQLQAAkwmQGBsYLC60k3YsmbgrCXIUlukQl5N4FFSy7LmBbvdCz13QA?=
 =?us-ascii?Q?UWef1E128dQ5D4G8JS8ZRGIbIK8HhX4AnPkLP84tVAhqi/t98Ck5CHeGKFPO?=
 =?us-ascii?Q?86jHTDC4sYESbCjykLbuphJsyISB8+YzIfMKsl5Knj5R8Sz5LXO80ajHj4GM?=
 =?us-ascii?Q?UD3LeV/B5byE8dqAVXBqqClzb79sVUntuibbKmsq8bm2X0ECvCiBDBMmfmAG?=
 =?us-ascii?Q?06NXkX3xbzhZ6YlQVkIYssKPvWpcqInOpBDDY+fwa9Mjv3TJZAzmQoNDVkeh?=
 =?us-ascii?Q?A8fkJB0o4/8J2m1ITz+cQA3TRwv5/BB6SwGfkHQtB3k/p50FsXhnxYAyBA+T?=
 =?us-ascii?Q?zEdYIqgKLW+I8v4lj3YnTK8i35pJu1aP1o0ATBU76byb/SfmVZM/yRak5Eri?=
 =?us-ascii?Q?J6OoEW1LMQmnddT/3e7Mj2GyMHiFUrTYipcYenbTQs5vyqY8iFOX1g2/I/YG?=
 =?us-ascii?Q?MN8DoUBOFhzUyozO2hVoaxE75ZMyDrwiLLf7nRRF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143c078e-8158-40fa-d167-08ddd4c7f4ee
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:02:23.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGfhsxhRxt4odFTSFexxzeNrRY9Q2kZ/uEQ3DC/Q3f/Op6CGrJmFvFQnoXJeegPS1Cf/p7ezvwub+OC2VVg+kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8956

Hi Russell,

On Wed, Aug 06, 2025 at 09:45:01AM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 06, 2025 at 04:29:31PM +0800, Xu Yang wrote:
> > Not all phy devices have phy driver attached, so fix the NULL pointer
> > dereference issue in phy_polling_mode() which was observed on USB net
> > devices.
> 
> See my comments in response to your first posting.

Thanks for the comments!

Reproduce step is simple:

1. connect an USB to Ethernet device to USB port, I'm using "D-Link Corp.
   DUB-E100 Fast Ethernet Adapter".
2. the asix driver (drivers/net/usb/asix_devices.c) will bind to this USB
   device.

root@imx95evk:~# lsusb -t
/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=ci_hdrc/1p, 480M
    |__ Port 001: Dev 003, If 0, Class=Vendor Specific Class, Driver=asix, 480M

3. then the driver will create many mdio devices. 

root@imx95evk:/sys/bus/mdio_bus# ls -d devices/usb*
devices/usb-001:005:00  devices/usb-001:005:04  devices/usb-001:005:08  devices/usb-001:005:0c  devices/usb-001:005:10  devices/usb-001:005:14  devices/usb-001:005:18  devices/usb-001:005:1c
devices/usb-001:005:01  devices/usb-001:005:05  devices/usb-001:005:09  devices/usb-001:005:0d  devices/usb-001:005:11  devices/usb-001:005:15  devices/usb-001:005:19  devices/usb-001:005:1d
devices/usb-001:005:02  devices/usb-001:005:06  devices/usb-001:005:0a  devices/usb-001:005:0e  devices/usb-001:005:12  devices/usb-001:005:16  devices/usb-001:005:1a  devices/usb-001:005:1e
devices/usb-001:005:03  devices/usb-001:005:07  devices/usb-001:005:0b  devices/usb-001:005:0f  devices/usb-001:005:13  devices/usb-001:005:17  devices/usb-001:005:1b  devices/usb-001:005:1f

4. but only usb-001:005:03 is bind to genphy drivers.

root@imx95evk:/sys/bus/mdio_bus# ls drivers/'Generic PHY'/
bind  uevent  unbind  usb-001:005:03

5. just do system suspend and resume test, a lot of kernel dump happens.

Thanks,
Xu Yang

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

