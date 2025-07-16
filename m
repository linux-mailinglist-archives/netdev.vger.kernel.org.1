Return-Path: <netdev+bounces-207577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02167B07EEC
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAFA162DAC
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37C26FA4B;
	Wed, 16 Jul 2025 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kRZUrBp8"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD260273FD;
	Wed, 16 Jul 2025 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697840; cv=fail; b=ClxJ5bk4pWHZoJnmjYzo9CoGuC7yJ/vDvtMpnzQWkh2O+z8rfBM9/zCR1fEUxwXTA8Tkf5gGoChV1g1/fkASBSGnBgFa32Swc0Gtqjn5JUg0uN373jy6arWPzQ6g2CNJYoR54D77KIXokYT1UzY9WfxNl742oKqVw1Kprl3EhYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697840; c=relaxed/simple;
	bh=ZVVL2eaLNxq3DprS3iz3eKwGHqTe7Oq4Ew1T+pStQl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LfUZQ4ODxWuuy5EDwuiz7FJLcGBqW1Iwneb8uxT7tX/NIsmJnFHgBj30a1uUEOcbT/pB076VEJJDvNhT2targ3weUiEG5hiWtgOHiNlo2fzmAG7NQctffPQ5gAySqMkUwhn379xToeY0GUmyfX6QHWi3zm+eOqNveHXeSAqTtj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kRZUrBp8; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM+ihQID/Eqv7FfeSOMbmON65EKMpLyI8RBeepo7u4iydYUaTtbZaMOQxNkLNNXuzRsp6Wtf0HImBzglShhd+ZViFIy+kRkvnlKlcpB+H99R31ySHr/yXXUj8vu0AEdhCHLzpmUEoIwsInhkCqU0oGQOcgFEjszMQY80se0rimV6R9SgEUsvjTT+zQaWhF8zAxtO0YKW2qTz7Zlsn4dO347/JH9G+TcnwHOc2nGatBoPsuagnlqp/U1VwmLcuNM/04BxxnUeKMd0BkscOUwb3dfiT0K3+Z+SNq1QKnt0kNpuFiMGyvs3uaX13H0PSf+xADkVZ2oTwcI40Lgw76TTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pb6iJwqb56dk0rN9QGVZy44OR34IUY8svTLIomr28cM=;
 b=jBjsBAo2yU+rh0yWmz+GZU88RMIEwEjntid3bOCFBr1G+yNQ4tPpJFxY5des025Pq3Lehy9jR8pSWunK6ZdbxeMph+mGSTFGhQRAEMZIpYU5a4hGC9j/3eD8D4WmSx3SuYHZE5wOkJ6J0YgFiCwBsOzwwJuz8cqjDkGum3wTuacL0LPUviGbsijNrXokMyVhCpZyVShquo1zHhBvFwxOtCoLIoTWy7opcoNfmNxveHPiqswqPd1K5vt14dzFTnNBUf06j4CCJDZoF26Q431/xZSi3YYLcp7F5V+t6wW8JbkhcN4n6OWuZS18zbbWedkfTBDe/znFfQMBmD49Xw429g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pb6iJwqb56dk0rN9QGVZy44OR34IUY8svTLIomr28cM=;
 b=kRZUrBp85+pdCsuloyDoeptB336B72o7qSLpjwlIlAYLUOkWZR30z873coBuLCLowH5zuy6kBe1SBkQ6JRbnOT/NkV/4QYrmNRTlN9cFrJPWQsUjFe4hjSrs68IMYtcHWT99TAQdqTIqMRrYw7BJxMNWY38s6LgL9ZoZRn8n8TICof5PgvxOd7ARhlwmmeRpOdOE1epcm7nDHnj+7cvqPjJUXRkWG2+BzYnaDJmaL24pxzfpjxyB8zMo4Bu1aazuMDCJuH0eF/FA4yMHCzEDUEZMls2TUW+VzwelJ8N+bEbz/EqKhnATSlGAx3gY2Yw6xqzsKNuKIfk/9Ajo80UjxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9383.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 16 Jul
 2025 20:30:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 20:30:31 +0000
Date: Wed, 16 Jul 2025 16:30:25 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v2 net-next 06/14] ptp: netc: add external trigger stamp
 support
Message-ID: <aHgL4dM2TIeNSCCr@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-7-wei.fang@nxp.com>
X-ClientProxiedBy: AM8P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 459dc2cc-fdcf-4183-719e-08ddc4a79c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SjoSb8X1ZBgPamREAWaRG6/2vPa3Us39Tg8xrqxF+0gUUK9++njN+JNLg7Lu?=
 =?us-ascii?Q?2f7SfqfW/zPNMY6LuXyxRXh7Sy7AgRMJ9IRpHdSFt9T3qIHs0ElMYOW42q/2?=
 =?us-ascii?Q?/ShMoFvjNel8xeNfEsRIFv/oed8Z84KMBptrsykfXWCJ1j5+8cb3gJjZ2o9d?=
 =?us-ascii?Q?E6+3qVDDQkwHlre1XY6L+qgg6PJMPg7COstrQECmer8r9vHbxwYjZRiSiMFn?=
 =?us-ascii?Q?vn/9adgVYAwl+MlpF1zbSMR0Vwgbl5k6vRcA1xG21AMh7wkEIOxNcsH9am/b?=
 =?us-ascii?Q?1VWMiZuHEeUIDHEVQQP2CnG3lz3NP0ogtD/tkzQ7TQEG6MpMc4YJAzgRAJlK?=
 =?us-ascii?Q?JfieL+NJG+LcS4+hmmBwJV1hQOzfpEocUdhIiKvIoMKs2czd6Ss7pP4LsgB3?=
 =?us-ascii?Q?7KKohhv/kPsDSnngZiouG1IGOiijBcOfYpP3DhG52ojfC8jDtHQ07w/oijp3?=
 =?us-ascii?Q?SijQWIQ32gAPoG4H8hiB0QSI3VPaRRI8Ft/LS22yl9pdPEenMdckjtXYjXUx?=
 =?us-ascii?Q?2Vs+xZ3gdSC1coH/cKEpENkhupG1zShakdbwkoBto6LBdY+wpdsg98dp8Txn?=
 =?us-ascii?Q?q2mtZ5RQzNOYoUutouiEYP+LiJhN7b8skwlH70jrYjdPu6tXPgGhn6Na/ah8?=
 =?us-ascii?Q?e7/7nfvIMJvD2cMy+RJSKTF1/VoCOlleAN6r54Rmg/Sa5H19HZCrkLlDkeJL?=
 =?us-ascii?Q?3ZQ5y4R2S45dHv9l1wDqLXc6hfdOARiAykEEULJqkx63C3VW2Pr/gxkqusez?=
 =?us-ascii?Q?nq/aRXdjxJlsyVlVL6Sa9dg39fSw54z1+q9Rnf/qRTPaQ6SzBY+YBqX4prrD?=
 =?us-ascii?Q?b0Hizem7HjNtUhzcp8ezJMINyKPJIJnifk8wRHJjJBxc8B3ENDOz9AkJNOZA?=
 =?us-ascii?Q?j2o19CURSxl5LoctxoUJHCKg9oz8rwczRD7aI3ECDNB1Wy6hrjYSHe+e1qEl?=
 =?us-ascii?Q?ZrzDS9P29dITt9/e9TrOAXrxKIq6UsqDEfJu1eoUMy5eTQnrroRiWW56vFNg?=
 =?us-ascii?Q?yEKuCpGZVPrNKyfze+qr32Lz5ZAnyiYshBC4wY5abuuRaW2J6i3+AVpQiSop?=
 =?us-ascii?Q?S5seH6KZmkxGbboKPt5LpyHVMCL8cU//B5Z1XhHN7RiuelYclbcj2lr0n7Zz?=
 =?us-ascii?Q?7vpyDj8gSKB4i/zb0P5W/wr71BVzN5JVJEXByDK6ebEpQZrufZ1DhqmlWHrQ?=
 =?us-ascii?Q?GKt5N8eORtJNvKtuddsBmDcpfLXsEGFTfYLeDdSDlsCDrEm9wWIASnK8XQC1?=
 =?us-ascii?Q?bI4iytcF7fhxVB6Rrk9IyC3jMhhGF9akk45AY8/3osECgo0HcVil/ILfzcrt?=
 =?us-ascii?Q?02aekloBhn+QdfM7GAEwGFW6RNdnN5DnTm5wvbJBiJtYRS6wFhp1zi2PZBPH?=
 =?us-ascii?Q?eTaPlVInQMVR/RRba+L/U+9T/0NVek5rXk7ARVAEglBcWNf7Rqh3KUHB2vfc?=
 =?us-ascii?Q?VW1dVhzoGPWKOGHpSWezAF6i0/228zIEogh/6gixq+8FlvqtoIvJGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+SI7JrhHyMiAjtklIB9ivDDLEmtK3td+M/ZU77rPaFKUxPu2E5DYMBRmEVnb?=
 =?us-ascii?Q?6D2+D6VgjEB/4Ye8NJ9wLF0h2IJ37XBiYBR8Weq9EskqAik5CL6wdJBo7A23?=
 =?us-ascii?Q?KUXgJjB6QQopRnJ14FWYrHkTUdUuJ6xYofhNv3N4TZ78/1sl0JSr3v/3Pzme?=
 =?us-ascii?Q?BT1K+XpFw8nPtglenofS5jpwi68E1xe0GqKlz7JBefVEXlaiKbz0qw2xJg9O?=
 =?us-ascii?Q?GC0ske1kFqdvOxCxv50miTFh7NaAgmDMh0V2smg3NgUfNIUKWuYJsQchy7+x?=
 =?us-ascii?Q?1x8RcfRmNaKwZ7GZ0JNPWEw1IkseRbVaTljKbdwnUZVL3hyA0WBpwwEb9Vvh?=
 =?us-ascii?Q?A3SWJPkHSWA2g3GCcMZQr4Q1qFQkJx0Ctt8VFewO2AG4bH88S7r2j/gvY35V?=
 =?us-ascii?Q?Ncyyusz2WnljjssmJU46OoxQUhh9wAC7zxdXIhzhfORZ7nbp6Ly+sOBFEQWi?=
 =?us-ascii?Q?qZyjoL1uDLRmJ6rm4NofOfVkTfF9+BvJgWJpfNvdXtPE0BP1yEc264zsg0rY?=
 =?us-ascii?Q?EWBH0epkIZUUsF8CPLO0Ira68CPGH1RBWi/dZVoRcwCVOIoDW+En5B1BbyTA?=
 =?us-ascii?Q?SKJu7A/wBNrAvK1kfalfFRjVnM7wWWB/RBc6iHsj3bKIUlJm8eaW+cT6FZOc?=
 =?us-ascii?Q?k7DES/q73AK6fgS523nHKbnEn2AGdih6o/y7hQ7fhgxRkFr8wrF5PbYfNeP0?=
 =?us-ascii?Q?37Ii3Vqhyn/nr/kckXYYFOrcUSgAW53AAyZ6ongT43dvWWQphiVRksu2MD5K?=
 =?us-ascii?Q?GkQhGc2atQIzdgPlK/1TzFYgR+9vFZTZY7d6aBxvXBMgXGlmdw1omHQJFezn?=
 =?us-ascii?Q?mPPPO1004mXz6E3L1POpTuj5x3zzYizZtOu58hkBoAqXkpyYE0DAz/Rieuz3?=
 =?us-ascii?Q?rzG5hRn1T5DyTZuSFJ6wdaLlVzk8zwFFDdOSm2P7Tv97uyUb+F24hxpwt1iC?=
 =?us-ascii?Q?kbUzrEC6F5Xu8bUgTLimr1uRSicXK3kc0a0tkdsAVrhb99LUQTPjW2grdI3X?=
 =?us-ascii?Q?pxd45dROBuBcgq3WiOxG1WPnZN8P3BUF+/2pe6s/O2GkDwM7nkUYPnWzIiYi?=
 =?us-ascii?Q?WykpgY8UUcAtVdxq2H8dJwSst1RMXH70ktWQENwnQYiFpGQ8If2JjizJUPLl?=
 =?us-ascii?Q?zUgaz26Jvhu8OAiJe116yPn8tQHZkkMn35S0ApKDuRyxN4yXpawgYdhp5AHv?=
 =?us-ascii?Q?QhKHfii658PPlbxpiijz4MAh1WL1DYdwwnonOvSgd6dczWM94VxHN1QFAC8G?=
 =?us-ascii?Q?514sUEsP6SqeBa07y5fQ2CYyTz5MImJgY9mMca1D5pDLNmlmCYVTRZA7YBx5?=
 =?us-ascii?Q?fatrUnanhtx69j5E2a7UwiQ2kDmHuxN+zTCGZTxrjpp38tnOtSmU/Xf5ukk9?=
 =?us-ascii?Q?4yiNi7t2iXWuio/lWLYC34DLzmr6rxGjr0yQI22G4qLYPgdIGZ3XWKmXfaEN?=
 =?us-ascii?Q?GXfS+utgJzngbOl2y8ywYN52pfzwWoO5xF5wohjeA0n0fvuXc7/JwGR6Jt8v?=
 =?us-ascii?Q?UicSncs78Zne70IlWBtnZAXN5+2L3kP4W+8zv/fxstwN6lmqnyBHCNt6ge+2?=
 =?us-ascii?Q?zmB0CBfSKh6w1jImhAMqIyhGL3IoWBDSIsT+J2s1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459dc2cc-fdcf-4183-719e-08ddc4a79c0a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 20:30:31.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VKoK7TZn3Ol9Wz/U89chGoW834UDcK6OojU4CAlSZdG1XgkdkFvAzg7uAPyAaWdzzJRfl80g37oqQ5f3Lh1vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9383

On Wed, Jul 16, 2025 at 03:31:03PM +0800, Wei Fang wrote:
> From: "F.S. Peng" <fushi.peng@nxp.com>
>
> The NETC Timer is capable of recording the timestamp on receipt of an
> external pulse on a GPIO pin. It supports two such external triggers.
> The recorded value is saved in a 16 entry FIFO accessed by
> TMR_ETTSa_H/L. An interrupt can be generated when the trigger occurs,
> when the FIFO reaches a threshold, and if the FIFO overflows.
>
> Signed-off-by: F.S. Peng <fushi.peng@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/ptp/ptp_netc.c | 118 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index 289cdd50ae3d..c2fc6351db5b 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -18,6 +18,8 @@
>  #define NETC_TMR_CTRL			0x0080
>  #define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
>  #define  TMR_CTRL_TE			BIT(2)
> +#define  TMR_ETEP1			BIT(8)
> +#define  TMR_ETEP2			BIT(9)
>  #define  TMR_COMP_MODE			BIT(15)
>  #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
>  #define  TMR_CTRL_FS			BIT(28)
> @@ -28,12 +30,26 @@
>  #define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
>  #define  TMR_TEVENT_ALM1EN		BIT(16)
>  #define  TMR_TEVENT_ALM2EN		BIT(17)
> +#define  TMR_TEVENT_ETS1_THREN		BIT(20)
> +#define  TMR_TEVENT_ETS2_THREN		BIT(21)
> +#define  TMR_TEVENT_ETS1EN		BIT(24)
> +#define  TMR_TEVENT_ETS2EN		BIT(25)
> +#define  TMR_TEVENT_ETS1_OVEN		BIT(28)
> +#define  TMR_TEVENT_ETS2_OVEN		BIT(29)
> +#define  TMR_TEVENT_ETS1		(TMR_TEVENT_ETS1_THREN | \
> +					 TMR_TEVENT_ETS1EN | TMR_TEVENT_ETS1_OVEN)
> +#define  TMR_TEVENT_ETS2		(TMR_TEVENT_ETS2_THREN | \
> +					 TMR_TEVENT_ETS2EN | TMR_TEVENT_ETS2_OVEN)
>
>  #define NETC_TMR_TEMASK			0x0088
> +#define NETC_TMR_STAT			0x0094
> +#define  TMR_STAT_ETS1_VLD		BIT(24)
> +#define  TMR_STAT_ETS2_VLD		BIT(25)
>  #define NETC_TMR_CNT_L			0x0098
>  #define NETC_TMR_CNT_H			0x009c
>  #define NETC_TMR_ADD			0x00a0
>  #define NETC_TMR_PRSC			0x00a8
> +#define NETC_TMR_ECTRL			0x00ac
>  #define NETC_TMR_OFF_L			0x00b0
>  #define NETC_TMR_OFF_H			0x00b4
>
> @@ -51,6 +67,10 @@
>  #define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
>  #define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
>
> +#define NETC_TMR_ETTS1_L		0x00e0
> +#define NETC_TMR_ETTS1_H		0x00e4
> +#define NETC_TMR_ETTS2_L		0x00e8
> +#define NETC_TMR_ETTS2_H		0x00ec
>  #define NETC_TMR_CUR_TIME_L		0x00f0
>  #define NETC_TMR_CUR_TIME_H		0x00f4
>
> @@ -67,6 +87,7 @@
>  #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
>  #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
>  #define NETC_TMR_ALARM_NUM		2
> +#define NETC_TMR_DEFAULT_ETTF_THR	7
>
>  /* 1588 timer reference clock source select */
>  #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
> @@ -450,6 +471,91 @@ static int net_timer_enable_perout(struct netc_timer *priv,
>  	return err;
>  }
>
> +static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
> +					 bool update_event)
> +{
> +	u32 regoff_l, regoff_h, etts_l, etts_h, ets_vld;
> +	struct ptp_clock_event event;
> +
> +	switch (index) {
> +	case 0:
> +		ets_vld = TMR_STAT_ETS1_VLD;
> +		regoff_l = NETC_TMR_ETTS1_L;
> +		regoff_h = NETC_TMR_ETTS1_H;
> +		break;
> +	case 1:
> +		ets_vld = TMR_STAT_ETS2_VLD;
> +		regoff_l = NETC_TMR_ETTS2_L;
> +		regoff_h = NETC_TMR_ETTS2_H;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	if (!(netc_timer_rd(priv, NETC_TMR_STAT) & ets_vld))
> +		return;
> +
> +	do {
> +		etts_l = netc_timer_rd(priv, regoff_l);
> +		etts_h = netc_timer_rd(priv, regoff_h);
> +	} while (netc_timer_rd(priv, NETC_TMR_STAT) & ets_vld);
> +
> +	if (update_event) {
> +		event.type = PTP_CLOCK_EXTTS;
> +		event.index = index;
> +		event.timestamp = (u64)etts_h << 32;
> +		event.timestamp |= etts_l;
> +		ptp_clock_event(priv->clock, &event);
> +	}
> +}
> +
> +static int netc_timer_enable_extts(struct netc_timer *priv,
> +				   struct ptp_clock_request *rq, int on)
> +{
> +	u32 ets_emask, tmr_emask, tmr_ctrl, ettp_bit;
> +	unsigned long flags;
> +
> +	/* Reject requests to enable time stamping on both edges */
> +	if ((rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
> +		return -EOPNOTSUPP;
> +
> +	switch (rq->extts.index) {
> +	case 0:
> +		ettp_bit = TMR_ETEP1;
> +		ets_emask = TMR_TEVENT_ETS1;
> +		break;
> +	case 1:
> +		ettp_bit = TMR_ETEP2;
> +		ets_emask = TMR_TEVENT_ETS2;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	netc_timer_handle_etts_event(priv, rq->extts.index, false);
> +	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
> +	if (on) {
> +		tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +		if (rq->extts.flags & PTP_FALLING_EDGE)
> +			tmr_ctrl |= ettp_bit;
> +		else
> +			tmr_ctrl &= ~ettp_bit;
> +
> +		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +		tmr_emask |= ets_emask;
> +	} else {
> +		tmr_emask &= ~ets_emask;
> +	}
> +
> +	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
>  static void netc_timer_disable_fiper(struct netc_timer *priv)
>  {
>  	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> @@ -505,6 +611,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
>  		return netc_timer_enable_pps(priv, rq, on);
>  	case PTP_CLK_REQ_PEROUT:
>  		return net_timer_enable_perout(priv, rq, on);
> +	case PTP_CLK_REQ_EXTTS:
> +		return netc_timer_enable_extts(priv, rq, on);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -638,6 +746,9 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
>  	.n_pins		= 0,
>  	.pps		= 1,
>  	.n_per_out	= 3,
> +	.n_ext_ts	= 2,
> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_FALLING_EDGE |
> +				 PTP_STRICT_FLAGS,
>  	.adjfine	= netc_timer_adjfine,
>  	.adjtime	= netc_timer_adjtime,
>  	.gettimex64	= netc_timer_gettimex64,
> @@ -670,6 +781,7 @@ static void netc_timer_init(struct netc_timer *priv)
>  		fiper_ctrl &= ~FIPER_CTRL_PG(i);
>  	}
>  	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +	netc_timer_wr(priv, NETC_TMR_ECTRL, NETC_TMR_DEFAULT_ETTF_THR);
>
>  	ktime_get_real_ts64(&now);
>  	ns = timespec64_to_ns(&now);
> @@ -822,6 +934,12 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
>  		ptp_clock_event(priv->clock, &event);
>  	}
>
> +	if (tmr_event & TMR_TEVENT_ETS1)
> +		netc_timer_handle_etts_event(priv, 0, true);
> +
> +	if (tmr_event & TMR_TEVENT_ETS2)
> +		netc_timer_handle_etts_event(priv, 1, true);
> +
>  	/* Clear interrupts status */
>  	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
>
> --
> 2.34.1
>

