Return-Path: <netdev+bounces-214610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BD2B2A97F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBC36E1BB5
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEA03375A1;
	Mon, 18 Aug 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HTBoYuUS"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3712E2287;
	Mon, 18 Aug 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525675; cv=fail; b=Fa1zDhZiK7BQ8tXoz6Hob8xNAcl0ttYhF3oAVF5G0D7gMN3pwkJeiHUh+R+vK5/anm8071blcaxApVX1Z9zJWHT/N0QfktWMyaBQZjyE+RsGl1Woi5q57uZpube2bQpY6ciSOyENrPcl30usy7R1KMa4BvA4USuBFLQmETHS23Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525675; c=relaxed/simple;
	bh=HkcUEcejRWu8skGLPdrCTBNMRDQ0XshEn9bLcIKo6Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P+1KIK1o/o/8JwYsIjvkHX8vxZgExSCx6pV07Ow1ZsSMM0exuOEtg2wZScoDk3a9GA5x9DYl1p7ozYtWtw28IGorglloYdUoGkCyvjHU+ObPNhjcbN4iL8nakr17+HbeuAXEXjLo1jr98eBNRkjv1plXOe9uIUsvy8PVUZtVTXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HTBoYuUS; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbgIdEuPcJaDIgM8jpZlrqT2smh3IE/6/yCqQI+w2M4gmhcy+03S9ij2swVS6j68rUpsg3e/Pzd7nDyDb0xLHD7cK67HVCAZrfLievv9vCAjTx3WZm4Hf/KI0hmeeSgErSWdh70mfknF2EQ2WIYXy/n9Hzkce6GIimuC6K0ZZvllaunmpaC/+9YTs0t5La1VccKNYW9BdMTDSAris6ZvRyyefVLj7hAUTmrUvskGIUcwnm8sE/wMkg8ylTFf72YdRwHU8jNj2GigNleCsq4rS7NJavNpzswaszT13KOfRhXoherS1IVyipItdZfA8ZXUyGMt/WIr/IYnDTnaUrOuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzoKHlicgfsWgilVS/HpjH0Dm8oITx/LF2LObkikRaI=;
 b=XTHCJed6pM9q4WAtkV5hLwg8WOzYX8qEH6QWomR7/YS1FhAtUhIA3ZhNcFdcqxJBobyrsgSLtJ589qcEgBOsUybl6BZZKvgEu6RJqa4vteGbBNO9Hy2qIcGxPcpBBorWyZCUcgZGnz9G5kAuIB8o3hv6ECW4u1klNotIW1XCNEyJHwQl8q3zjwiWItvGucK+M4PpYsi4lrjBfMDyq2ODwTcp2GnS51rnqbMJRp4Tuk+48r5MG7I0b804XqCpro/r3hZYjd5CxjXK0b/cOi1wszwYJhJgTwi5AzJS4t5H30iL11IjMQc/zpQc+nrMf4gFUpN/K6n7oUs3EGerrUdYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzoKHlicgfsWgilVS/HpjH0Dm8oITx/LF2LObkikRaI=;
 b=HTBoYuUSeOEkYd0eHLh+DgUrDLYG2flnn+Xg2ebbVTKrwSejZNqLTd1RIK2Fcmva8RC/Fd+qCUONQ5fxWrf00k3Q52lPp7uI7R/iUbCsOERoQcO2TrX0fbl3T2fCWfrsB7CEcOLrvQ1qhhoy4SaEbWN2ufqh20X8s+ND4/11wV56Va0u3Alen09vjZZ06P7a/nLtX1aLQjVMx3Nz0Y1XQKRZu3C3Ke5n8dYpLaPsViJBGIuwovZV5RmMxx5aeWx7JqwanZ0ZsYs/QjMAV7UskwIdOc2QqhhdhUrH9YKwXf9OVqtbu9Ywc2/XmPZDMRQ2z/I5we+rRmIIDd/tojFuIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB8000.eurprd04.prod.outlook.com (2603:10a6:102:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 14:01:11 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 14:01:09 +0000
Date: Mon, 18 Aug 2025 17:01:04 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, andrew@lunn.ch,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, rmk+kernel@armlinux.org.uk,
	rosenp@gmail.com, christophe.jaillet@wanadoo.fr,
	viro@zeniv.linux.org.uk, quentin.schulz@bootlin.com,
	atenart@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250818140104.n43xkl7dunfml6mt@skbuf>
References: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
 <20250818132141.ezxmflzzg6kj5t7k@skbuf>
 <be442867-109f-42fe-8af4-7e5ab4210662@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be442867-109f-42fe-8af4-7e5ab4210662@linux.dev>
X-ClientProxiedBy: BE1P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::14) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: d815e312-fb7e-476e-ce31-08ddde5fadb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|19092799006|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ITSErwBJv6qz68pwEEAkLki0QcluWlbHlwMCpaq5V8+ZJIB15s7n7FSMSo7x?=
 =?us-ascii?Q?RhOuGwcfyzYAOaNlsue5qd91fD2/5Otdj7F3ryVkjEJnEcDaBUpFr/9E0jh8?=
 =?us-ascii?Q?00IFtxndyr8NPZgvPCt3t4BpXmA0aJuKMy4nYBflwabYPmFmbVwbUlDvjTm6?=
 =?us-ascii?Q?ObuvyYTCwfu3ayZF4k2xVxTAou3rXwCEvHeG8d5t4w7BSoo9TL8IW61Kbdxw?=
 =?us-ascii?Q?ikfKZsB9U+Yup2EtDcnTS4F8vu5GGFkgQcZXS/PmtRtiEhhT06Pip8Zbc7IF?=
 =?us-ascii?Q?l0E4+Ru7bVwo7iWVNVwKznYtgNJKpsbSJIqxc2lUcmzhrU8fuKzG6e9IZElI?=
 =?us-ascii?Q?vmZ1UqyTZxq5G9O3mL6GCgpVxRzRDo1XLawd9fp1Rb2RZtnWX0/1rve80wbJ?=
 =?us-ascii?Q?l3/1KRcmmHKVDUvkOJtqEUj3YFGJt+TXsdL+dTD1oJwfOD9ELTen3z7j9Txt?=
 =?us-ascii?Q?IH9Lh/kB+nF9S6nJhtL5grw6sfTk+rmmYEPDlCLD25yBumIm6lQ3L1Cmusvj?=
 =?us-ascii?Q?2ZrUpWjM27/ymuwkHPEXX3UTIAcB47x+4pEgfQFR5GyyaNVrM4c7IQtfBDgB?=
 =?us-ascii?Q?kYbee3J8y4APcJBvWwM7H5awR5h3v2GgBWDQBOCJn0yjlGtH3C6Avqw5gHu+?=
 =?us-ascii?Q?Dxlks7e3M0kXsn1mt3q2RBqv71vnBA7SKQyy3IDWzHOIhayAv9+mGXxfws7m?=
 =?us-ascii?Q?ZVPL2iUOq2L/WCuSnkYC9tywhxyosTNQOazHKx8sFwVL8igUmLXrQ6OSOsxp?=
 =?us-ascii?Q?+ejPDDyTpYHLb3QlMmc+THSso/3b0NKLgUszVS7W2EjyGRFv+iePql84RWw5?=
 =?us-ascii?Q?qcAnB9EIC1s8CTZ64JFACJNu/944uc9xY8NADHrRyaBQp5gamnhys0HQ1KOI?=
 =?us-ascii?Q?/vVd33C7n4wB2O50/yXaJmkDmi+xnel1yyRBjuvUw+WmP19e42CPVLqZ3MCA?=
 =?us-ascii?Q?D2C4AwE6gjlYJbaXll3kHT6HBgHu01Zcj92kR+SCaXJlmgB+xz/Y85o6WdET?=
 =?us-ascii?Q?c4+WmZz/5ml2eSxg3bTPtOSQBmp6QP5jlkNGLFnhailQE8P8fAVfICsEDBFy?=
 =?us-ascii?Q?fAIqAT8JB/5omrtJzOiUKkJHn0xnVpxo+5ddaTYfYRfjLw59iENHPKeWJrL7?=
 =?us-ascii?Q?fdQwPTENbGiMrZ9MlWtzlj0O4hkcYYELlZshQwkhRyMfDb1CY2XNNHyP9nwm?=
 =?us-ascii?Q?PvlJHrwrZ4vOftoeBBKSSUbuhnLMkRwudrRultWhfcL7tEa2+RsQxtTM8pnp?=
 =?us-ascii?Q?lhyM/GPs38ZjUnxjeEBPre+FUKUzRwzGo/9Pj63PVPbfAZmIjVRuTmohnf5G?=
 =?us-ascii?Q?FJHsMK9ewUVhMdIJ4mxkLgDzY0JHb+CKhtJkXl4NLfIZnvbjW4yAuQD0FsV9?=
 =?us-ascii?Q?NcRsHc4SMaf3ztFViJmPzJk0U46VNrhOFimqS4WP0Q+ECpzQs9+Z0KT1lCPv?=
 =?us-ascii?Q?vgwDFdoXmI0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(19092799006)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g2CYWHd4CcgRWWqZzWn4DYzLZfv62fXdmTGzUhpSmrzYpWPLOdg/1AjD/IWE?=
 =?us-ascii?Q?4qpA+Xf4AIHdf3PWtqewG/KbyRHP/tdRJi3CjqXKX3U+2iklwnFCfJvE4KrD?=
 =?us-ascii?Q?a705Vt4UMhjFsYi7Aag3IaSLroEXrA7NuesFVe4LiIjEWgfcIN1p9ZjxbDuk?=
 =?us-ascii?Q?HJq0vkt1HoMPUBEO9iV0ekU6nClPnkPODLnBYLstrGkYhuvcCatZ2FnYD0dj?=
 =?us-ascii?Q?adAELp6yFRXSTbfjrwhZ/LyJriFuju6CeepdBvgTtjBajWlFuI3W9g8QdULS?=
 =?us-ascii?Q?lS4peIl+fUgqZecs5/MO/iIQtAu5mv67Blu6AjRJA1wI/JUHYtosbgbc/WfG?=
 =?us-ascii?Q?nydZvfIxjCdBh7d2hOHOk/VGcK1SJreRjMwl+1MrnDTX/bSeqEntihyvelny?=
 =?us-ascii?Q?IyLvWMraywmsYUkzPKbtOrmz7mFvV+bSPR3r/p5/ND3z0R5eiVxW1Xt5rk06?=
 =?us-ascii?Q?IFdQm74ngir/5du/Jk4kmrEUOFS5m+PqU/asHLbhQ9FpKEyTFJq6XQE3RY9P?=
 =?us-ascii?Q?9SF8HX3hW6kyjsDNPvP9wqXrScU5JUO7l7y+EPPya+xKtLoxBtx6oxQA78nZ?=
 =?us-ascii?Q?NQdiBwgX5PBIXeTdnohL/c3OpaC4HkTWCU8Tzzta9Se5HWnvDGY6A+1hTmcG?=
 =?us-ascii?Q?H6U+O5hxuuOZHalAde05iDQaYZHU57dNipg2YgxGijFpGLvqnZlz3Wz+eP3F?=
 =?us-ascii?Q?vT0BI3UNPeRyXGR4+Qt74OY118QV+LZewpgpG6Maq21tRboRkUMc1BktiRSj?=
 =?us-ascii?Q?nbgHs1w/w0cCuakBU67BdatvVHtRkWC4Vt6rjltn+H4J+ptvX6i4KVwVjEva?=
 =?us-ascii?Q?NiAcffbHM+Qakevc+bsDkVw4gEGaSgjc2fMH3Gu4fMau6KRc/3TgBROJuBzb?=
 =?us-ascii?Q?JnjldHo59qV8kW/qLWFSBOHctjLuiblzXmgaDazB1oN4HMy/tYpBLv0pJVJE?=
 =?us-ascii?Q?I48UnDeIcAvsSEPb7y99WuVrEUg/Igxjkffj70KSAKglTCyzuBjYR8j0xq/i?=
 =?us-ascii?Q?pmMGCSPe/cf3PFPEGPPXWWwjEoLF3xIcwmyNWllTzIznTm6aeofJ2FuiZdqv?=
 =?us-ascii?Q?0UmePLN4oXM2xBtiwfDETlYDdmj2uic6oI4rBFM9cLZi4zYilUaPHQYvuHXn?=
 =?us-ascii?Q?qXIsGXYEftDitVCubIPTqo2ZcNktL0TfZn3+JvkXgeIpgmVhmJpEZOc3K0mt?=
 =?us-ascii?Q?evqfaiJhqPofCVH2OwwfUWhcg3XxS7nHswjbUvxgdF09cIw5g30Pnc+fX+rN?=
 =?us-ascii?Q?bbFkKXM3xlVQswFQ6FmJhJeuvpTG8JizErBuKh2rQd2g/6DTePWDKlmVTzIB?=
 =?us-ascii?Q?j0SR/ODD/JBjyypu4fQTbKD9i+h5ESKzwZGHVLA4DOu2cp+dVC96QKg2Sk2q?=
 =?us-ascii?Q?LVoCv3IKEKZ4Ff+BLy5xxX4L33ca2WuIC3QtJi8PxHbPLeLTBt435EYl21aN?=
 =?us-ascii?Q?uTBMJV6qZBuppVEHCaFxjOcW1ewOZRm1a1Weh42H1cPV54EkiqE9cARiqW6/?=
 =?us-ascii?Q?CQv801JAoYQfMcqg07S334zRj/jf84S4VmKwifMzwiS4BP8DSMTw+IuSB1lM?=
 =?us-ascii?Q?qMquOB23YxF9wRLwcHire5fkmqmvJgFQ4Y2tPvbXJ9e3uKKKkso7q/cKjQ7n?=
 =?us-ascii?Q?C/sF/EIIPrvhvdni0FtLI/JwZt/zyZ7mxtnfSBgVAX9aoY3Py0PLgHYSJoyy?=
 =?us-ascii?Q?DN//eA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d815e312-fb7e-476e-ce31-08ddde5fadb3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:01:09.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mI4JY2/26KgpDexFYWxtvtSc1ZhjT4AJ1FUUVwmm75Ls/1Ze9bmCh94B+ZF4kevysuF36B5o1WG8QFP44fyDRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8000

On Mon, Aug 18, 2025 at 02:53:22PM +0100, Vadim Fedorenko wrote:
> On 18/08/2025 14:21, Vladimir Oltean wrote:
> > On Mon, Aug 18, 2025 at 10:10:29AM +0200, Horatiu Vultur wrote:
> > > diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
> > > index 37e3e931a8e53..800da302ae632 100644
> > > --- a/drivers/net/phy/mscc/mscc_main.c
> > > +++ b/drivers/net/phy/mscc/mscc_main.c
> > > @@ -2368,6 +2368,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
> > >   	return vsc85xx_dt_led_modes_get(phydev, default_mode);
> > >   }
> > > +static void vsc85xx_remove(struct phy_device *phydev)
> > > +{
> > > +	struct vsc8531_private *priv = phydev->priv;
> > > +
> > > +	skb_queue_purge(&priv->rx_skbs_list);
> > > +}
> > 
> > Have you tested this patch with an unbind/bind cycle? Haven't you found
> > that a call to ptp_clock_unregister() is also missing?
> 
> It was missing before this patch as well, probably needs another patch
> to fix this issue

Sure, separate patch, but the addition I highlighted is pretty obviously
untested.

