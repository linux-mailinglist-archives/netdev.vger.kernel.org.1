Return-Path: <netdev+bounces-214628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15358B2AAD9
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EF71BA2590
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DFC3570C7;
	Mon, 18 Aug 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aXSfhJ/f"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7233570C0;
	Mon, 18 Aug 2025 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526394; cv=fail; b=IYPANPU0j9LXOUOEuumJjh8xgjNqwMCB3Vuju3NrhGm40uoTPoMxTmHg07vHO5t3WBR5SeR9+6stgHhrMcSL5GTtLZmfyDRRo7sFtOchqYeecFix6PgU0umUytFAIgE7PSf60Cn+gmXGo08pUF8K3FnqSGN4G8jNb0k4Q1t5ndg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526394; c=relaxed/simple;
	bh=cilv50R7cmCVfF0zTSQ19gLNPCU8UmjfxOxNLS5I2SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=srUroPb5Uhy9G0JnsFYKtce8RSMINWfpHPnm8pCsuHOq/ABY/dM91SYZ6fCL4xj4mdOKy+O8RUCHl/Eh8b3CM36ksFas/+v4ikC8xOUYRrMDntDMNB9i/auzyKXWYKs7rLDapSWJJhOhF8cwf+e15nIMhYXxapYe70JW9CGxNFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aXSfhJ/f; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2l9SmA2S3XmfEBP02Kk3/MHvHYqHuJGbTXVw0stv8dyC54U4pcUr9+eRN2W27OZF+LN35J1My7wZM9LgHArDJ7jOedZrEFQVd4CKCsDJbvWOt09ho1DN1Re29ew/jcqKLSPAxjt3OMQmL3GWI5cuIQczO3XwF8Tw68gJLFCmg2x5I8+zcCgJtKy7Izy04bl19aaiNTiRrdwp0T1aqB+Dwy32JyOxWaVodmDGFs/qLA3X4pvObwJk5w4WSKSorRzD7RiRmJjLr/X4mcmokncPVFckumFgty67YbIrQX4LxL9VqUhkTNp9sL1WQp1X1Iqo03BfftdovE70TKUunTrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhciUseKUndTDlIqeO/VdCFsVpKUYkvqZepY1rnySMw=;
 b=JqyfAmnxScml4MeNGlFB0stJorSP+5sdYnKb6IIbHWttaCc0+9yurYm/tu1RfQUIA7LNVOQgNQOrd5s82dKfTYl+GvJZsM4wNNStVJWXm1jS5yxvZQcvf0EkDB5U2xmCFI69lvsHcEvb+a6e7xPP/cTYQLB2cPnAiNEbpP0LFcyIVS8j+e2/7aesKkF1YcWjsWMUNm4M+SyLzSyWnlEGvYX+hQZzdf7xaQ06OUNbCi8Mvg1GCahe+5Lo/GX89Ua4uU66zvc34gTsyPQ9STwI/iQopmTJfYGtluZCU++KeVlqN/Oi+HMzeeWy+nv93W5jBXmEeGLXXmZTOYJ+mphGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhciUseKUndTDlIqeO/VdCFsVpKUYkvqZepY1rnySMw=;
 b=aXSfhJ/fFRvqEDrtpDadCZL3uihCbMQcKQcygXcqZOJ/GIpxCdqUKgmXTG3yrqvcN4/+KdrpAhXKXnktcQ6EMQHnr8DxiknDIptVlw0kVYyuL5RNrXYP8lkRS7BMzP2ILuynyHFTVfLvXbx5CP7mmqKzNYJa7R/cVHlYqkRamnxmUFZVEHJQM8FtxQ+qOgrPH8EzFo+BSl06i/kdZJ4UIjn0TH0FXOj9pS39cHgyCSit7E5mpm9c75P7XfD6/dGyx3YMtR6JK3O57eNVRzf7foLQdveThjy+Onzi2YRt2v5DnEl//UBCNdB2eezMy3H5ZHPbWN7iC4tF0YyOVV1Rkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB8000.eurprd04.prod.outlook.com (2603:10a6:102:c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 14:13:09 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 14:13:09 +0000
Date: Mon, 18 Aug 2025 17:13:06 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	rmk+kernel@armlinux.org.uk, rosenp@gmail.com,
	christophe.jaillet@wanadoo.fr, viro@zeniv.linux.org.uk,
	quentin.schulz@bootlin.com, atenart@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250818141306.qlytyq3cjryhqkas@skbuf>
References: <20250818081029.1300780-1-horatiu.vultur@microchip.com>
 <20250818132141.ezxmflzzg6kj5t7k@skbuf>
 <20250818135658.exs5mrtuio7rm3bf@DEN-DL-M31836.microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818135658.exs5mrtuio7rm3bf@DEN-DL-M31836.microchip.com>
X-ClientProxiedBy: BE1P281CA0298.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::10) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec8f230-88c4-4312-2ab2-08ddde615be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WEIv8J0oLlyUZZCVlQilxQ5ybPffN1PE3I+agTVR0i7qY+aaf25E842b068U?=
 =?us-ascii?Q?ISQR5V3ESDvGWfrHRDvV7E+rC7kjZDg9iazf1VKPDXOndyfsXH/3ORXUNbki?=
 =?us-ascii?Q?3bFCH6YThyPbbaYpRkkR1bia2tBIY4CL0STDW6cmj6Lktmi9IB6ozpI2IsX6?=
 =?us-ascii?Q?khEWuP/htE+3EQghYCnlpFRz7O3L32dVBeE6GDZUzuJHVj/Pwg2Mgf0QZVn5?=
 =?us-ascii?Q?DBdNL1XAhHJvNVlRJJGpHXzO9cijuRCpwScLsOqodc2yos/DVOo5QXBNEOf9?=
 =?us-ascii?Q?5Ad6jX9t0goleJv0TlyRF2AohSq8UhFWM+WPM60S10Gvd/ofswXGRZMvAUEN?=
 =?us-ascii?Q?VwYTDPQNy9FB0/AnbBImjvzrzkmTU7vAHywoA7zPgrolElhR0b6Q85BPXWlh?=
 =?us-ascii?Q?VxBLAsNUep+qx0jvvtXw8QbsRGR7Iihmftemcw3QaAHFfNByEG/cTudWPnNh?=
 =?us-ascii?Q?Vwq2pI+w8oEDM78aOmNnAzFlaYvI1TktoJS/d3guSuOy1W+5wO4YU21QO1wj?=
 =?us-ascii?Q?RKryYp+y8251wMWRJtOGiwgrrZovfShg5byAlV87ryivU9qLJqG+bYyRV1Rf?=
 =?us-ascii?Q?2hleEpqvWIJzZjqpLRB01meg8KjwmmMozE4LmJEZxuTM4VT9ddJtG9l2cCP7?=
 =?us-ascii?Q?T1Oedt3H5YKY2v6HLn7U3NBkdo967j17zeSfG05yCVEvO2rufMuYf4EVfKCi?=
 =?us-ascii?Q?zp2IT87MNqV20UhtwnCw/XJMU0LSrx04hQ+jqkyvsL6Pkp3e32s88ELfO2Id?=
 =?us-ascii?Q?7NWZL9wL07PBlbmkDubJabbwIPXXpXaA2rI0PhZ5E+gCAVkHXkGLSz8IJ73K?=
 =?us-ascii?Q?9QkiyZfKhuxfENLV47A/R6fuxTYadamPr15FTreiI/fGAuMowfp3jnLWZBND?=
 =?us-ascii?Q?mUX3CJHwMGluBNZqxR3R4xBs6FK9L41bR+JfXVBprF7+Lp4JHlWiVQ4/KbFW?=
 =?us-ascii?Q?pmUZwM8olJbZLDh3SshwF+U/jCs67VyqS3XoGsWOOIApaLv1/YYErwRGLZgO?=
 =?us-ascii?Q?9/XcYNkiK99bA/0xSL+Uk51TLnqpgHlSSTIvKlzOQjAmm8AL2PJulUaIyMTr?=
 =?us-ascii?Q?k8T8mm/r4dMgj9oDijB8h0aOoVFMKyAaUrnFK7Cp28ECnnTH43KmnwJ1IA/2?=
 =?us-ascii?Q?uy78NJ4/tp564mTWR2E8Uvp/1Gz44o/S28wX8gzis/brin4am32l9zxxJFGn?=
 =?us-ascii?Q?g15F/Ag2GNmsd4u0chDBReJg7YJ3Hp0Cgu0OFhjrxsinVichyWGyzRkMwv70?=
 =?us-ascii?Q?u/NMMDM8yqjYImMYDxVVLaV1OU9v4U1/zAtoS5rNON1zNpUg465WYK/zL6P/?=
 =?us-ascii?Q?Lqrm+Oa8AZW7QKG/loFBsMGDVKUxTXTs63LrzDl94JNnZtH/UhCTrSGPVOB5?=
 =?us-ascii?Q?z8jpkL0jvS49wF+JaOuU4OtUeqrWg/3M7UrFB65X3TFUvLsqYx1PfY/1U7Xg?=
 =?us-ascii?Q?YsYgkgSVetA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TQN+Y7sqBvQCKO0iQfL2Ev7CyFoIbn9KzYVVil3FyDHCPt2lFpXTKWnqQ+KS?=
 =?us-ascii?Q?mmxIFBNO1aqKC02RJnWLLjtUMxhKTKZ+v+tADUDriS0Ra1bKiWEj4SrDpEf/?=
 =?us-ascii?Q?N4tx0YcWR2r97vgdpIvds+SwCn+nddjSjOPpV0u4hw7lZq7qKXcZMa73bYNN?=
 =?us-ascii?Q?yxmau/jShlJDEVPfLYFCDnmwk6QeByYUqwv8PsdF853CVrnvPquErUd/idue?=
 =?us-ascii?Q?n82GjJStf5ZMDlHcWOddFL/pru0MGDf7sRKOHd7f+gQJVnGAdArW6PR7FnqQ?=
 =?us-ascii?Q?Jh4asDdNh/yV43pHpuLXKXRTGFLcg/5ybR+O/sx+6wIyV7AkUAoMGG4/ggY8?=
 =?us-ascii?Q?NxMg1g6BA1F+XNN/BX5OwLy6ZHxZoPlxxhS6z9yVNL4ebjiku8Euf0ufd2PS?=
 =?us-ascii?Q?2ecbKteskU3pYoZCNpFh4XqpksrDLXLkbHHICiuOTOGV0MELrolTsm/HNvhM?=
 =?us-ascii?Q?vbK6f063gwLslKh1g3qrRlW2R/HCp0yWbqdMXBbdtf6MNdKDHFwaFQzqI2MV?=
 =?us-ascii?Q?74z00zhVpUHeFx4tXmBCQHUw0zRh12S6EezNOvKvOTKXWNvzXmwzVSkprmAG?=
 =?us-ascii?Q?bLGnw3D4D0TvR5EfXlyz2us0bgSZe788tkF/jIW8nk9DOJ3otmkLKck3mPh7?=
 =?us-ascii?Q?chOuo1mpOru0aJMyOvptiHZHR4gHmSzxkA6TbEAtI6ZH7Tct6Yq9cQNCJnmI?=
 =?us-ascii?Q?CUIodJtB/JETHtdIj+fQBns/0l/9ktMLENOrstOW28xoiIHn0gSbUfwKhc5z?=
 =?us-ascii?Q?GyHqAdNaN8ttoUfUV+yWxog4fVTGJHbeQE2m25/DAigspfBN3XYJmM8L/4tb?=
 =?us-ascii?Q?m9M/LwOCzWWuHypQPDi33nIAQv7dlBXduOpGUg5tB+HxbmeFbRcfrCz8Li38?=
 =?us-ascii?Q?0nbyaxQrEMnUrlScRCoauyDXTgVOo7q7MqWLp/4CcPBOIoYEz68BfWgdZVvK?=
 =?us-ascii?Q?hgN7cmZUd3QitPH2ybRgYo+SDV7H5RR4nvMZyFCmse049dpKtzu2gJsOJ9xu?=
 =?us-ascii?Q?Gc/kfklVQjCEKOq85eB+QOfmFf2vx24qlWVZ2SxDXYXAuvlfuauuxh8ErYvD?=
 =?us-ascii?Q?lFiimDZ8KR7PRERRcIsR5K1XPFH9XMEH4GpfguLMDEvC4qaB5urardXJRMId?=
 =?us-ascii?Q?BX842kGsWlvDW1jO0/5iKQKsxOHAyvQelXrY/E3PPkmc5v2IxbrJxSk9spoq?=
 =?us-ascii?Q?Nz8xSX+z2/e/qZWqu3txJ+wSBbdZgubpocgjjcNnUXPZpCpPsGBXo9/FEQOm?=
 =?us-ascii?Q?Pk60fkHe86VpFNU6ysq12US9soCSc02WD+EhxK4qD+RrU3zaqdbtO46PWdMs?=
 =?us-ascii?Q?mzSVhW+6JVOQXB39KuiSwiPEFkxS1GofOIKVJl2TWaeVVUww1FHu+mJ6sLwD?=
 =?us-ascii?Q?0vaPg6aJIgC9mew6Q+FdkvhgeTqg1Q+KwhHOXJ9239lIW8yVopnU90rw8Imj?=
 =?us-ascii?Q?BxP25Nh4Gv2JmwjlVPodlWbvI+TOACPRnIqxRWHwQOtxP2lmM6uFCQvz0GJv?=
 =?us-ascii?Q?Fpme+HSc+LzDDAeWCA9lLit1kGiOrukza+F/nioWFYx9q3OrP7ihaEJYnODc?=
 =?us-ascii?Q?IIDqK29PW0YUEuVwP3Zl1CrpY//X2koSsh95L0MGvAKjoxHu1CwmfZvWLsFb?=
 =?us-ascii?Q?5AKFjfPL9W3nEzen3rTcgs/IWhPmZGkCbhmI0GJZjsol+HFvSFIznO1DGjqU?=
 =?us-ascii?Q?Bqijqg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec8f230-88c4-4312-2ab2-08ddde615be5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:13:09.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tT2Y39Z9Pmx7wt6dL0udipcJmZ3cLTjbhTS2h2NXlItsDyRbMdsGLSSjaP9IA5/jJDIzwYyv//YQjaVEO05t5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8000

On Mon, Aug 18, 2025 at 03:56:58PM +0200, Horatiu Vultur wrote:
> The 08/18/2025 16:21, Vladimir Oltean wrote:
> 
> Hi Vladimir,
> 
> > 
> > On Mon, Aug 18, 2025 at 10:10:29AM +0200, Horatiu Vultur wrote:
> > > diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
> > > index 37e3e931a8e53..800da302ae632 100644
> > > --- a/drivers/net/phy/mscc/mscc_main.c
> > > +++ b/drivers/net/phy/mscc/mscc_main.c
> > > @@ -2368,6 +2368,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
> > >       return vsc85xx_dt_led_modes_get(phydev, default_mode);
> > >  }
> > >
> > > +static void vsc85xx_remove(struct phy_device *phydev)
> > > +{
> > > +     struct vsc8531_private *priv = phydev->priv;
> > > +
> > > +     skb_queue_purge(&priv->rx_skbs_list);
> > > +}
> > 
> > Have you tested this patch with an unbind/bind cycle? Haven't you found
> > that a call to ptp_clock_unregister() is also missing?
> 
> I haven't tested unbind/bind cycle. As I said also to Paolo[1], I will need
> to look in this issue with missing ptp_clock_unregister(). But I want to
> do that in a separate patch after getting this accepted.
> 
> [1] https://lkml.org/lkml/2025/8/13/345
> 
> -- 
> /Horatiu

Ok, is there anything preventing you from looking into that issue as well?
The two problems are introduced by the same commit, and fixes will be
backported to all the same stable kernels. I don't exactly understand
why you'd add some code to the PHY's remove() method, but not enough in
order for it to work.

