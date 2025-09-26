Return-Path: <netdev+bounces-226653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF99BA3972
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91657A8504
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80452E9EBE;
	Fri, 26 Sep 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fB/L69Sg"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013039.outbound.protection.outlook.com [40.107.159.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832410E3;
	Fri, 26 Sep 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889250; cv=fail; b=ki6QvTYMNtLgXoCS4TAaeaEKEfRW8Wl1Q/+vd06E/AeuJZyx29jtzpW2r/dkg/1RL0SGP/y3wXVPbTD3d+v0Q9SZUkJh2ygq+GUt2ikSYxphv4BEVIjh87d8AmErE6Lk6XIji6XzoP2WAr7jaSs7OAphHqNsl7tFa31EUsUNSLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889250; c=relaxed/simple;
	bh=JInkF35+cCDUBneADjylIB3PpZQlGeI5EEziX25i14A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eAm0JDz46Ayz4myWB4Or+7hExgGHoZ767MuuUQvpJDCML5fRXLRyZ3rroFF9loK29EDXsqfd+IyYDNmc3V0a+SHWPmva1y/9iX2BAqXG1NBuNthplwhLk/rVa1lXo1hcDoqwf44CLKyj3IX09G47iuVfJ0Lexe3q/12KLHnhUy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fB/L69Sg; arc=fail smtp.client-ip=40.107.159.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyuqCwO5E6bVXBl+o29wdhMWYIp38u4fQMUwnSpa26lshNfNTTkTutuMcz0UArouYoya9/gVO5YCauZeta/gehP529mPcrL5ThBWe+Z2J/lk9Ny0NSA7UKRDVSehM73AOTCxr1x3AiIwCClW6ukJm4DpuqmpDZVQMc8wveiXD9OFTJyT3hpXoWZfy7YkcOLitKKq7ZTpn581Xy96FzffbU/k8frJDkO0hD9R53PR5oklzTurVo24qXoYX4YD3EZp9B4pSSrPQjEcw8bCM1NDjXpjMmcByRmr6afllr27OQqbhzdKm/nz4T64EnprYXpryi27QqXXSVeiI+A8Dpx1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ/yvok1+7xHXCqDazardp6WMoijbjzv15917tOrjZA=;
 b=ABhDm101ov3tFtJH5HT4f4vz9Ah/7B4iQVkkxVJk7QugBUk8beG4gozW7ClSq5HQ50vGAgr47nqBHIGtSmS/S4GPGSDvK/eVKsijS/ij5+ChEsSVe1Oraqrgg/Riq/87H2DbWzyM600bafc6qNVCl2EVodEMwyxy64AZ6wC7DYatmvP6B4r8bip+BbMB1rP9ORPw8y2F2PkVQT3mR7qy6X4xTwvKaLzG7deLmwYYw2MPUYtqmFWlUrVeeIevU+W0PLg0CrfxJJqkTiffQ4KolZrB1OBH2sSEZI5ST1yYeorPRsi0GrK4zsaG3n0irRQlDd7rKq+tf0O9cu0ilOUm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ/yvok1+7xHXCqDazardp6WMoijbjzv15917tOrjZA=;
 b=fB/L69SgSNUEx7QbRqXDsNd0gKzaMH+QMU7WLFBs2BwCRkDgHHEHzr2Ly1qVqsW7wfL401QKVReX2Fpd5FiosRIMdod/WzEj8/cMKhD6yTQ+wAfiPgIcPXKvcXFZabTO5iuPIJn/YKfwDHIqluDwD2NU0GufoXStCzPUlVWi3whOSbCA0Q9ksUnThK9Kh6vCLuKhHfGklXsGaWHvf/m5odOBt2I8HrDO+S6MUeHJUawoYJ0weZz51iRMHkX61WmOifNVjVpiiw7IIUdmxE+eDB5NadNzQIiotWzO68X708A8TeBpTng0isxLf4KUNYOJUongOJUwn+fg6AprleLyIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB11038.eurprd04.prod.outlook.com (2603:10a6:150:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 12:20:41 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 12:20:41 +0000
Date: Fri, 26 Sep 2025 15:20:38 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Jakub Kicinski <kuba@kernel.org>, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, richardcochran@gmail.com,
	vadim.fedorenko@linux.dev, rmk+kernel@armlinux.org.uk,
	christophe.jaillet@wanadoo.fr, rosenp@gmail.com,
	steen.hegelund@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] phy: mscc: Fix PTP for vsc8574 and VSC8572
Message-ID: <20250926122038.3mv2plj3bvnfbple@skbuf>
References: <20250917113316.3973777-1-horatiu.vultur@microchip.com>
 <20250918160942.3dc54e9a@kernel.org>
 <20250922121524.3baplkjgw2xnwizr@skbuf>
 <20250922123301.y7qjguatajhci67o@DEN-DL-M31836.microchip.com>
 <20250922132846.jkch266gd2p6k4w5@skbuf>
 <20250923071924.mv6ytwtifuu5limg@DEN-DL-M31836.microchip.com>
 <20250926071111.bdxffjghguawcobp@DEN-DL-M31836.microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926071111.bdxffjghguawcobp@DEN-DL-M31836.microchip.com>
X-ClientProxiedBy: VI1PR09CA0177.eurprd09.prod.outlook.com
 (2603:10a6:800:120::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB11038:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df3bcbd-b087-461c-7907-08ddfcf71beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ecS1PcEP4clq1/8l7WNTrUEW/hMfiQ6Bi5cQ/PFR+KvSMjQCOSwTwKSDfMVE?=
 =?us-ascii?Q?mfK1WymQnsLDmZmIqkxol9MGVF1oFmGNqsUYfyr1FLOo1DpdAOMnKfMvsy5Q?=
 =?us-ascii?Q?f1lxY6MVgOcW1n9B5FBGshMJVJFcUTtYUmCjyB+lsDQdLZSU9OptYAlpr+kf?=
 =?us-ascii?Q?ieTZn0RJbm+DLWFy0/xHCErh/S2N4gAeAAdBxEZioeOS4rSiI1/Ot1ukgVoa?=
 =?us-ascii?Q?8QZYGb6kW9p3BAPMBgENx6g2G6M/xpgPpYIlunRkVtgOpgPb42cdzCDpMkBp?=
 =?us-ascii?Q?WwkIdK1HQMfFwKzrX4Z+KIu+SGju4GSuGxKReqyNkFKkGZtORLeQyuW18uL+?=
 =?us-ascii?Q?2LT+HWANbVxXKVGu4WLMbweDI2ztohfYmUMzfy5SNuo6uakClRbeCBD+lFzz?=
 =?us-ascii?Q?zjmIV1qstTNfrPaNHZ9XYexHo97HVRNqpizjoj28kO0LeoJzo9L//X5QyStd?=
 =?us-ascii?Q?0oPl+gu4xOb8lqvh7PnXfYvGfl0rUpFPwTdvdtqeS1/lzBqZJF4LPih6mWiD?=
 =?us-ascii?Q?cWI7rYXw0Y0wOyjx414t4hrTJY1nbKylkiNs9tsN9qPVkrY0HnOfN+xg5ZSX?=
 =?us-ascii?Q?kF2Rc8YN39jTg74Bl45qh7TNt4wTywwuhhGiNXijHMAHjCSrnlEEVXh/VbDL?=
 =?us-ascii?Q?9NHNbEV5L/DnRmX0Bx4B3N9AxoUlvoyz8p+o4RPp2AjWryof2AVvkQiKh7LV?=
 =?us-ascii?Q?QNn5nu4DFIDmacfykgM6KAmSql1l+nI5VGzuOiEuA2MsduvKohLCN15JF8aj?=
 =?us-ascii?Q?spV6a29j79FBb5UO244+nnfNM42tcMU3ak8LuI8PQL11ycarXitN4v3bHeqx?=
 =?us-ascii?Q?0aR349zwxpq68EZdWYJ3e7Od7zDdY/js2xfhuWqdTSkmiHL4VyVYxuuXi93i?=
 =?us-ascii?Q?Rh1uQ1oHM3J4nL8s4U+9FnLdhm3GXnWaLYPKT/eiCYD9EDDaTjIqNOyNHTIB?=
 =?us-ascii?Q?aBrd/V2FWNZo2pojYAficuveuor48iebv61HYOiBmRYzToMkG4KE7ndQULKh?=
 =?us-ascii?Q?eTJ7kZamoAsj3yUB40oq/m4NLh0t+SUBTTUAHT18kyhhU0AhqN7ZYwmQrWOA?=
 =?us-ascii?Q?XJK8iD2ctkPcY6WiamXQqlbpwVJDLiczV929opatxaLTiojDN0yO41NeN7nf?=
 =?us-ascii?Q?ilx5ylJr/yNRjAnwVTy5jCIYr8hFlbYGGAqkEE750OOXzUyNA3zv8g9A2AZD?=
 =?us-ascii?Q?zHyr0UaoDJ9YHAAyIor/uhvp2HkWLbgYaDJilM9lOdPPVzC816TJRHgG5FKt?=
 =?us-ascii?Q?2pWPqsrx4FQdn4O34XsiJOBcyG3LmMTGAt236gNPB0+7mEuThckgCBtm7Cd0?=
 =?us-ascii?Q?tyKekM+y0ddCAmunkIJiO/5WCj4sgSDgULwghpAmHaDDtWlqr5ETAsJbLVYy?=
 =?us-ascii?Q?S5qNGksC4Bni5daIaeOVzhmoJlWmBEDLeeBEIvY6cfLMkVZ/JnzmMNL8dVQl?=
 =?us-ascii?Q?H5UA1EpoTQSMEu6kP1hCiX0UwjpSBk9P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V3Ai+iAIeLeWsF3fxUdXngzxy2nI/gkTytx5CqoFXGGngWKgX3tgYggavvjJ?=
 =?us-ascii?Q?AdgNwJqbDovzMScXkRmonsPkW6/hMhXHAJUGlCQmxwcgUvuu7kHySjPe6tMa?=
 =?us-ascii?Q?AcrbkAEKZPFPAyXoqaf9Kp51QoCs6r1RDPeqsP3ClDW1nbbW0iVlcne0eUvy?=
 =?us-ascii?Q?TeaYmf08DGFea6yqoTOfDCHXc0gn1zHfTq6RE5aB33C4g1jiNC7/S2PGhx9u?=
 =?us-ascii?Q?l7KcKk9zA4fG9izu7urGuFHr1jTucDPXluANYPLMeGWIxbtFA3Y3rsMolS1q?=
 =?us-ascii?Q?YPBf4FWLsJ9EaDI+yS9JtZI9zKThy/V7Wr8K1dI7NKEqjLYXFBSDen3wVUMa?=
 =?us-ascii?Q?Gii8DLqOsRN70bFVWECbWCg773/YhcPT/r825NkhTLYvS/pMBDzCLS5vEcYN?=
 =?us-ascii?Q?y1/MhDro3v7N9z2aqWI6f8G3haQwPUe0eo6u07dWuTcbQFN2mXk0YJNNDEBf?=
 =?us-ascii?Q?n2KLDR04FmwwTWReyEabYIgOYk8FWEGmxP0po+d22/zUBMpxBEuw/1oaXJTW?=
 =?us-ascii?Q?ZZbaWf+t7AkMa/dY0puq8d9sfCyKsQQpLAooYqT5iFRvW6uhBwF6XDQElLxG?=
 =?us-ascii?Q?JY6CRoMcmAb2649x6Q94Z4i3vZ/Kv92tJfn2EnSyPrzcA62qEIqkp+Pbc5Lg?=
 =?us-ascii?Q?aj2K+LembHCbgiLpRe1/3+eTih2ZW9OfdX0T3ht9CUmA4wK7QKzjAZW50fzv?=
 =?us-ascii?Q?Cbv6aGCIEDFvQVDgwHdVpapwXgqWVDLcX6zuyxaUfiIjLX1mmkdT7VfogY0B?=
 =?us-ascii?Q?G0UG1CK9YAySGrYCyezLXwJ+obqLQLlCBhPWSYsqUP3Q70qRo5xV8xJJ617y?=
 =?us-ascii?Q?wA4k5OTWCXw0J4itcM11VUO8peFqKRYcYJnitnmbGU51dUVaSUPAA/cSpgzD?=
 =?us-ascii?Q?EnWZUb5gNLgLJFC0irkP9lhya823qQyDzpBScxveKOnmOZt0xyD3IxIgekCR?=
 =?us-ascii?Q?S4HhO9JOVaHdzey/IJuUkfiMeRtNrtnI9VFpBpeUufFOBXZAukt7Pyz1zgQw?=
 =?us-ascii?Q?a3QOZvS6nBUBsETUjz8LJL52kVb6UoVBNMgK6eTwY7510MmrXEdzFGz87mrU?=
 =?us-ascii?Q?V7Mdl/INzY+KyswB+LO+v+ibWWN2Zweyzw0KWNkS9fgnAmT1na3U9RRwwS/g?=
 =?us-ascii?Q?v1lp3MEbhU7lJaF2jBOiY5xhkDuSqqS+mJbiEvJORctmnqsnC5Hxd8TRgfK/?=
 =?us-ascii?Q?MzQBuVa/7IVtGYd68xxL0MtWVUyt+ifQa1FEfV3bwR2dquazoYPekuasDSXA?=
 =?us-ascii?Q?GFc9lVDNx5W7FHlBUIA8+ioSMNZw26va4+gDgK8wpc+WCU2pzzWCiTYJm4Xj?=
 =?us-ascii?Q?w8sUED1buMcVvT90bBaWeuzxQ7HREI1XPOYvejbkNWxPwqZN2H2W0G5lfSWG?=
 =?us-ascii?Q?qQrl0LxVlrzeZQlTahqv0wt0qa6hRsCCmOZdsik5AKNek+sO/3vkhG2fXXUY?=
 =?us-ascii?Q?FBjksO/Z3s4tEO4wAccvKf/95GvkEx4E/LAu3AQNbDhcsoQxI2Mb8h5pnR1P?=
 =?us-ascii?Q?V5PAedfkpnH8SgUgCyhzRXiKTE8RjiAXtB9OfTPCWoCy7jbRGO4eCHkixt9s?=
 =?us-ascii?Q?XfIUdq2p3lTMbBOOD/6oDeEUQ6u03NvEuGUbYr9KV5IWo6aaLUvEmfwEetL5?=
 =?us-ascii?Q?JvaYJQ8aDr6fT1/f8AUybwnrmVBPYcsKeULld6QX84r2vaSgSEZdZCei4PlR?=
 =?us-ascii?Q?NqfHvA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df3bcbd-b087-461c-7907-08ddfcf71beb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 12:20:41.4098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQqTKHX/Hpqb80y3Xct8+1t2d5y97Mk/aSqpIdhBsPJLeE9fQsQAvObVHyorJM+Ug/UrFIscksgMLcZelXWOOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11038

On Fri, Sep 26, 2025 at 09:11:11AM +0200, Horatiu Vultur wrote:
> I have been asking around about these revisions of the PHYs and what is
> available:
> vsc856x - only rev B exists
> vsc8575 - only rev B exists
> vsc8582 - only rev B exists
> vsc8584 - only rev B exists
> vsc8574 - rev A,B,C,D,E exists
> vsc8572 - rev A,B,C,D,E exists
> 
> For vsc856x, vsc8575, vsc8582, vsc8584 the lower 4 bits in register 3
> will have a value of 1.
> For vsc8574 and vsc8572 the lower 4 bits in register 3 will have a value
> of 0 for rev A, 1 for rev B and C, 2 for D and E.
> 
> Based on this information, I think both commits a5afc1678044 and
> 75a1ccfe6c72 are correct regarding the revision check.
> 
> So, now to be able to fix the PTP for vsc8574 and vsc8572, I can do the
> following:
> - start to use PHY_ID_MATCH_MODEL for vsc856x, vsc8575, vsc8582, vsc8584
> - because of this change I will need to remove also the WARN_ON() in the
>   function vsc8584_config_init()
> - then I can drop the check for revision in vsc8584_probe()
> - then I can make vsc8574 and vsc8572 to use vsc8584_probe()
> 
> What do you think about this?

This sounds good, however I don't exactly understand how it fits in with
your response to Russell to replace phydev->phy_id with phydev->drv->phy_id
in the next revision. If the revision check in vsc8584_probe() goes away,
where will you use phydev->drv->phy_id?

