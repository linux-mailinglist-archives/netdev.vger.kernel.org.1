Return-Path: <netdev+bounces-232181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EF6C0220F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 17:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 688944F126F
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ACB33C520;
	Thu, 23 Oct 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iLPZr8HO"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061D03148C1;
	Thu, 23 Oct 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233540; cv=fail; b=jJznCf+YI83wE9Mltq9lyWqrRkBQq4uAX0Wi6yF1uiM8JKZ8FB3o21g3hzO9wY/f69KgALQoNlvqw34KqUiEY5t6TyfLEti5hRpaQh/sYKzTDjPWhrQRa2XayoRGqbDpUxQPG/3K+Xs0rPIjm+81jbqJHgO4/2DwzLRViUgwT4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233540; c=relaxed/simple;
	bh=fV/crduRSv1MCrHDIX7tePsM9xb13ATGoccSFOKaooI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iBCnK1quEgG+0QhPr3drdm5wkLmLfxwoClCtLe+vYmN9DXGrn4xg/hw/9GolwWC5DAC5VJ9bXfpDTg8vKAHJ5zqisw0y0XsXwz6BxTRc43A3CT+2BVh8UAUp7UHhZzSiW6zK3PaOI/mMfZuT9WzC8TU9Kjkwk58gzDCUaIY+fMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iLPZr8HO; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZ0dQN9dvYkTqIiZgiTub+Ns/jPwa5UFGfAMi3Kyql2JNlagaaj1EaQLKOT6P0794Iuunqo1jgzDlLa1S0aiasdSTaJhfcIiH3AGkX70eblQY+SsBrDvgZYm96GIHIEI/sFGtlAnAHMZX7o5C9A5yXSReVuxd2kN4EKz3uB/+oTjq9lC48ufyQfjSJMxllrVUKl+WXOnGegwO0Kapn7ZLNKaGVM428Xp6Jubdqxp8Ph61ifGCgqX143nFccx54Xl3AwuizOJaOg2l002+nMGExEmCI/l31y5/80S5S5fITQIzpmfRBi6BT5O6s/Tj2ldwvRHUFud1Pvg5JiejO8GOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RW/BtmjJfZqcvS2ChsfCYopAaXYWGYJc+gLhihkKYo=;
 b=F9pyZd0fYlsYt+ItS9Q+2CK3kQHeBkxON6e5rBUv8+9mbjKOEdjJHF8w5YS1hbFLXpPi1Et1zIVogn9GM67bKyUe6kRasF+49xrz/1XIdR+1k+ApJSDLi+N6t65rTXY2sdy5+Zdg/oFSih+4w6pCC62vAAu8L7Ep5oFx+4IVdamlCXZ+vDMJewScDmtTvjVNSYKR9JgC/VT2zPxG3IIdvBJGXZXZkPnvNHpxMrY6nL9FPubhQlzdfqmh6ymHXJY/MssVw9i45nHgzaUvIREseDCGd1N8dI+urNGPQwJBsH0aWEfKlGoO4stpCtpZCyAxuIyObtLEgxJPeeQ4cw5oyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RW/BtmjJfZqcvS2ChsfCYopAaXYWGYJc+gLhihkKYo=;
 b=iLPZr8HOq2W3rI4b5k5WP79OMs0l0dA2glOWt9KnO6OOwrlcAAOJbkX3CsFgi1ABl9b93hB5PR2s6YpzfCLJ/4+PKjALxL5Cn8p/CxSWCd7VqBBbCnwLDKXMheCBP9cFPMWNlbl42v0JY1fRrJPDEhmbql6H3ICwqKIapWYAigqIL5XvBAOQTU4bc+OfbGHyqSegW6eiC2k2aP8q8z8ddTdBmZyZuYn1KdwbLCzd5bqgZRFZGpwNXaiC2u+uDvQJ6bzFt6pLN7a7VXSIepd3NyW/n6jySMPPv9vl/iqJx2RelJiUTaZTRryuMbtY3IMR0QVkAp7XNOwt6vOcGj/mRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7433.eurprd04.prod.outlook.com (2603:10a6:102:86::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 23 Oct
 2025 15:32:14 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:32:14 +0000
Date: Thu, 23 Oct 2025 11:32:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/6] net: enetc: add preliminary i.MX94 NETC
 blocks control support
Message-ID: <aPpKdjWPhzHEDR3I@lizhi-Precision-Tower-5810>
References: <20251023065416.30404-1-wei.fang@nxp.com>
 <20251023065416.30404-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023065416.30404-4-wei.fang@nxp.com>
X-ClientProxiedBy: PH7PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:510:339::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 837267a2-7b55-4e9c-be65-08de12495733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RMEDkuayONqn5bSvKWc6YHjkqXNJnJ3/bmrqTcooSpnIRUs/3gKjlSkLLK2B?=
 =?us-ascii?Q?ay8gIn5k9XH7EDQBdBnwO5rmtINHCUcgVm/FTLo+twwDmggnEcaYqUP0BP4z?=
 =?us-ascii?Q?1jH5o2XhufAynccp3rgRjZ5Pg84HRdKXqRbdDTo4IJraALk6QaJPHCk+ZcD5?=
 =?us-ascii?Q?3gEeJmK6IDLe+5ukfYKudcM2psByPMW5d4IFfUyZ4qg+uQWngFPKdNX3i9Kc?=
 =?us-ascii?Q?Zo/2HUAAUUDrkhMNXJ3PF1JFVNLZoBvFmhlsIzxcNJgPXC8LjnGeyuP1z685?=
 =?us-ascii?Q?tT2vD84z6dVeM4nw4BqQbvV9HJmP3Ncq4kj0rAK/hpIB8wJwF3RK4GX4ATSd?=
 =?us-ascii?Q?gs/xql9leYaWyotYVqCAmZ8QjZ65e5imQN1FwSHGUQ9z9nkRNkK2BKW7e+kY?=
 =?us-ascii?Q?I70gYPaTeD+AkAtxJemAx6moUfKaH2PShdoPWY+cUTyA8t5/PB4gx/VqZdJz?=
 =?us-ascii?Q?oIFzfpX4++PoAMADO/7OBHEmEP2szPJJ9ISh6twC5tfysMjNz0BwRe0ovibz?=
 =?us-ascii?Q?+Er3T97mzppSnbcClSvEwInlCnpDETQ+20wTgka+518Mngc5rUlKZJhtL11s?=
 =?us-ascii?Q?14BA4y05OdtRJKkmMfO5ZyJHoXLj0AZA9nrP25hecm16qOQyAMzuu82/D6eN?=
 =?us-ascii?Q?0TpV4VcPnug1hni0itX/ladXCfbOPY43mbRVswtLWjZz55Q4+mEjOzNXmMcR?=
 =?us-ascii?Q?/OzFjBs8ZdrqBvARG++FICpWHRPR80gcQ95mRcrXN4GyjhG4pmxvzjz5plpD?=
 =?us-ascii?Q?khpP6uJRBvfZNxIVEKB9EQykTGuIRQ/FLdwtkPdvLuHbdc9mSFqWqQE/Sj7A?=
 =?us-ascii?Q?75xdwZKcYU47BwbLd09EM2ZQEbAzBYXaZiGR/GlKsDaIwdiisSXlKl2RMvDN?=
 =?us-ascii?Q?8dzQcKqUr39Qy4Yi8yQfUnFbGtDSZFmqd3YZyLqI9ySU4PK/t6XrqicEU/sj?=
 =?us-ascii?Q?nkqV6mvMRfMSYba+iysgGSpfFaJpHG2Tc4nqJ5gW9awHEg/Hw4OpQ+YhnQNo?=
 =?us-ascii?Q?GRcryd7CUCqaZV8nvn9xEWiA8bE69FIgiLM0+ngYRo1+iDXh1jnQ9FqarhaK?=
 =?us-ascii?Q?1+hH91IZYiiyyehQk10dumeZUN5JlelaruycEm1/PyVR+KQqMZQTPLuj7EhO?=
 =?us-ascii?Q?zqbcnaBDmQ0W4n+sRsZv3vSrkwo1ppxkaZY7MqgJnZPeZllBDMceXzjRtVoc?=
 =?us-ascii?Q?ogoZPUv6amuxt9fkVyOe0+XACje36R0MrDCT1AK69A4NYN3ug8+gJ4Brw6bc?=
 =?us-ascii?Q?C0R32A4AyB6DvEWtt/K+0eC6CRPJS1H4dQjGvQi/fFM/FxfIxNcncmbKQ0Xp?=
 =?us-ascii?Q?vBsK+JUltWmm79vBLrYJ3TIOCQDIgWNQnTtca7Ze2Hgah4c5V9k7mKWvVgAM?=
 =?us-ascii?Q?QX1qrSZ0nOvRBGNNvIunqwSeXySypYYEx8v5Wr0xFbDyqXR/K7dwkaYNC7F7?=
 =?us-ascii?Q?qGSyEwD/T0BGSXvy2/MTdDLWd/6v4syM9hYjwlE3O1cKtYpuYTEAdwz7v0Js?=
 =?us-ascii?Q?nFDNjdbyHiV8x4o5csEI7kBnSAEPpJu/vRVz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eafrowjelEEIV9OyhryEnLLHuIi/LrNIqdl1oRduX2UjM0Lsv3yyErQH76Cm?=
 =?us-ascii?Q?hnmOyiP6wOZzgbcAbC58fsF0wUTKLXEQUsTvSbNCfuGpCEi4rw4jQ1ty0Pb1?=
 =?us-ascii?Q?+FLHrIPJGIOs4yGqEzFlgp0aIIGhklIrPWxxLCA17OOFkPAEstYBgwSmiJCA?=
 =?us-ascii?Q?moNylLrwLy304BisKv3g++MbVE7H/G6ZpmnY9YzajU2nxjJ7EcPwzrzLnDss?=
 =?us-ascii?Q?ZVPtaltBPKM2jTbS9MtAiBGmBXvMGing/QqjQJUY1qwynbJPZlD0KiGDA23q?=
 =?us-ascii?Q?WSpmciM01saXw+s77eH8F3EY/KdOCbzR8l8iP1qhylMN3Lrtt6ojKXS3RSMM?=
 =?us-ascii?Q?tLakLvdN3Rr0rL1Q6bA2J7IySIqGylNwZaIqfLsuS2gyma8yStbOl2Qn8OPw?=
 =?us-ascii?Q?0P3KLCt1WvVtPLEi4pgV5TEtZxK6JLuH+HuVcFu7ila0woRMoXAowYp32p/B?=
 =?us-ascii?Q?5uuvrOd09LIAGYQqYK/0AfdnXgNVqDSdFB5Oe8cq7hBV+jMBxtJuqGHolE80?=
 =?us-ascii?Q?MqcFu2kbQ7wvCDXLd1q4O3GQYorlknsZQNqui5brhTc94W3g6Z8sff2QS+VT?=
 =?us-ascii?Q?g0TlcpusrKXuIxX2ZwK1M18Pw2X0iihUWsymzv1bvLTi+iVaCNqnH+jdF13K?=
 =?us-ascii?Q?MsRchxES9rTashVOf6trmoiw5jcvxj3jkGYbpsoVrzUtY0+3KwaGuH+kOZpS?=
 =?us-ascii?Q?3PY+tixPjsdWu/+Y7WJNMYmeXNh7dqAFBkhfccFpXEwG7qMQ2agpQdv0JS7p?=
 =?us-ascii?Q?cxZFRTroCuL++mOd2svEbO6yWBR681K8jhgTTzWouhTNr7xMyLWl7embFawt?=
 =?us-ascii?Q?sTzroJsf6PDFoF9nOKjQntqsj/Nl5MhbC6jcE/2ltJZykeXpNwGjGyRMrQn/?=
 =?us-ascii?Q?S17cq9b0xyMN2meLVsgJPuuOeyuPT7c4aqlH/Qz7mU1MphKSnN69q0Z8Lk2V?=
 =?us-ascii?Q?vcuMiLfpDo+iI7OVdZqJr/Ot5ncdsJJVblSx6PQ9t3c3bFbS+/8e+SkDP9ym?=
 =?us-ascii?Q?e+0kARmTf8/gm9K+HzZqvH4IGXJqp7f8YrTduzR64zg7asRvUO2UmFHk1Fgg?=
 =?us-ascii?Q?RLxhAPrbdDqxx71powGV1WO+YRvUUAJNivBOj1+HkzuHWVZXIkk2LbkeCq5X?=
 =?us-ascii?Q?eHKtajX3B4SGeCHqdrKdk12VanfpyxKF+aqJPCTZ+Ld6G2nlSOWkrmUBmZNO?=
 =?us-ascii?Q?4Wg/3uKZpQDRzBWSCIeVlq5sB1owQFQpAcnKqVdJ3kZ/tfQT1SIa5F/hbWE1?=
 =?us-ascii?Q?Xe0h9pWThAn6zy5xuR4k8DhytW5mA3xSCAtP0a91X+OfZFJFWpbiD3GROVht?=
 =?us-ascii?Q?R6rsM8KIqmEB7yl+ebLMxnv51hd0qpuVLW+W1y2HHT19wCwzCHBs0y0CKJjd?=
 =?us-ascii?Q?M8exs4404PaUx9/xRHSCtOkywyHgUa+WwjxqiLyXevBf00BffsgLCgdp7Vhy?=
 =?us-ascii?Q?tZV58OXd2BV4Y6+l6C0lJtawoT5RDHFX0/OXykZciir8j0DVuD8WQD6FkGsv?=
 =?us-ascii?Q?p0D/ZUgdi8dry761sOmSvLI9Z4gzOAryjnrXKJV4tOUriFvv+3TFvEPAhliU?=
 =?us-ascii?Q?tjKhL5K625bbAin5AZaV1LarSCId9tOU5rOHyPZr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837267a2-7b55-4e9c-be65-08de12495733
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:32:13.9529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4bwc9x2bXE4rAxrTTpHC4ceQ4kQaht45ZhH/21moX6VYDTo1Si673CZ3jyY94saZ/65bhi7pIztwSs0mZRbTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7433

On Thu, Oct 23, 2025 at 02:54:13PM +0800, Wei Fang wrote:
> NETC blocks control is used for warm reset and pre-boot initialization.
> Different versions of NETC blocks control are not exactly the same. We
> need to add corresponding netc_devinfo data for each version. The NETC
> version of i.MX94 is v4.3, which is different from i.MX95. Currently,
> the patch adds the following configurations for ENETCs.
>
> 1. Set the link's MII protocol.
> 2. ENETC 0 (MAC 3) and the switch port 2 (MAC 2) share the same parallel
> interface, but due to SoC constraint, they cannot be used simultaneously.
> Since the switch is not supported yet, so the interface is assigned to
> ENETC 0 by default.
>
> The switch configuration will be added separately in a subsequent patch.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> index bcb8eefeb93c..5978ea096e80 100644
> --- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> @@ -47,6 +47,13 @@
>  #define PCS_PROT_SFI			BIT(4)
>  #define PCS_PROT_10G_SXGMII		BIT(6)
>
> +#define IMX94_EXT_PIN_CONTROL		0x10
> +#define  MAC2_MAC3_SEL			BIT(1)
> +
> +#define IMX94_NETC_LINK_CFG(a)		(0x4c + (a) * 4)
> +#define  NETC_LINK_CFG_MII_PROT		GENMASK(3, 0)
> +#define  NETC_LINK_CFG_IO_VAR		GENMASK(19, 16)
> +
>  /* NETC privileged register block register */
>  #define PRB_NETCRR			0x100
>  #define  NETCRR_SR			BIT(0)
> @@ -68,6 +75,13 @@
>  #define IMX95_ENETC1_BUS_DEVFN		0x40
>  #define IMX95_ENETC2_BUS_DEVFN		0x80
>
> +#define IMX94_ENETC0_BUS_DEVFN		0x100
> +#define IMX94_ENETC1_BUS_DEVFN		0x140
> +#define IMX94_ENETC2_BUS_DEVFN		0x180
> +#define IMX94_ENETC0_LINK		3
> +#define IMX94_ENETC1_LINK		4
> +#define IMX94_ENETC2_LINK		5
> +
>  /* Flags for different platforms */
>  #define NETC_HAS_NETCMIX		BIT(0)
>
> @@ -192,6 +206,90 @@ static int imx95_netcmix_init(struct platform_device *pdev)
>  	return 0;
>  }
>
> +static int imx94_enetc_get_link_id(struct device_node *np)
> +{
> +	int bus_devfn = netc_of_pci_get_bus_devfn(np);
> +
> +	/* Parse ENETC link number */
> +	switch (bus_devfn) {
> +	case IMX94_ENETC0_BUS_DEVFN:
> +		return IMX94_ENETC0_LINK;
> +	case IMX94_ENETC1_BUS_DEVFN:
> +		return IMX94_ENETC1_LINK;
> +	case IMX94_ENETC2_BUS_DEVFN:
> +		return IMX94_ENETC2_LINK;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int imx94_link_config(struct netc_blk_ctrl *priv,
> +			     struct device_node *np, int link_id)
> +{
> +	phy_interface_t interface;
> +	int mii_proto;
> +	u32 val;
> +
> +	/* The node may be disabled and does not have a 'phy-mode'
> +	 * or 'phy-connection-type' property.
> +	 */
> +	if (of_get_phy_mode(np, &interface))
> +		return 0;
> +
> +	mii_proto = netc_get_link_mii_protocol(interface);
> +	if (mii_proto < 0)
> +		return mii_proto;
> +
> +	val = mii_proto & NETC_LINK_CFG_MII_PROT;
> +	if (val == MII_PROT_SERIAL)
> +		val = u32_replace_bits(val, IO_VAR_16FF_16G_SERDES,
> +				       NETC_LINK_CFG_IO_VAR);
> +
> +	netc_reg_write(priv->netcmix, IMX94_NETC_LINK_CFG(link_id), val);
> +
> +	return 0;
> +}
> +
> +static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
> +				   struct device_node *np)
> +{
> +	int link_id = imx94_enetc_get_link_id(np);
> +
> +	if (link_id < 0)
> +		return link_id;
> +
> +	return imx94_link_config(priv, np, link_id);
> +}
> +
> +static int imx94_netcmix_init(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +	struct device_node *np = pdev->dev.of_node;
> +	u32 val;
> +	int err;
> +
> +	for_each_child_of_node_scoped(np, child) {
> +		for_each_child_of_node_scoped(child, gchild) {
> +			if (!of_device_is_compatible(gchild, "pci1131,e101"))
> +				continue;
> +
> +			err = imx94_enetc_link_config(priv, gchild);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	/* ENETC 0 and switch port 2 share the same parallel interface.
> +	 * Currently, the switch is not supported, so this interface is
> +	 * used by ENETC 0 by default.
> +	 */
> +	val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
> +	val |= MAC2_MAC3_SEL;
> +	netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
> +
> +	return 0;
> +}
> +
>  static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
>  {
>  	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
> @@ -340,8 +438,14 @@ static const struct netc_devinfo imx95_devinfo = {
>  	.ierb_init = imx95_ierb_init,
>  };
>
> +static const struct netc_devinfo imx94_devinfo = {
> +	.flags = NETC_HAS_NETCMIX,
> +	.netcmix_init = imx94_netcmix_init,
> +};
> +
>  static const struct of_device_id netc_blk_ctrl_match[] = {
>  	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
> +	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = &imx94_devinfo },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
> --
> 2.34.1
>

