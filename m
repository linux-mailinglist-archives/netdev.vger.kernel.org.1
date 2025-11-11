Return-Path: <netdev+bounces-237757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A5BC4FF7E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 23:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91E654E10EF
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9678E2EC557;
	Tue, 11 Nov 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WC1+SKz7"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8A35CBA1;
	Tue, 11 Nov 2025 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762899880; cv=fail; b=qSa2q8RmatBHwfMOACwjOe0LxGbo7WZUXt5JMOb+C5ozYvELx58egpvARfXnnk1+CYPFJNn3q2g/K3DgdGdO0yCtuAYKqZwY+EjnNqpRMDNeIWydz2TR5BsSkf3fchRtN6wE6Dz4Jyvlrm3a22ckUEc0VCT09E5jY4mgUtu3BKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762899880; c=relaxed/simple;
	bh=tr+etrTLIL2K3Bj51g7Zhc2pTQhMrHKEjjz3CLy28xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ogIMxCuhe4r6SyyHsp9+Cax/2V/MyuArwliYwidzL/RTlurEd8GEbJqBQ0YCqTx31o0yn+t7VixMTAK2zwDji5URl2hQFOzYQiMXCeSAtsHhU1SL+iiPLciGowEbwnwkU4c17U7e/CSxs3lZM4tImu5vQeNs1JX2RnMTqO4cDNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WC1+SKz7; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhYGpPaKsxw3FuZODNFkM4IOs2xp9yUyuLH6PnDkcVEfBOhZuC5A9AoLP8CI14TqQGvvALusG0ybjfg1hstaIln0r/PecY3jsi1Oy07bhWITB16u7F3nXvpWwyUgW99SvltX6WcIy/TtXNC00YY1Xj9IsP64OKeYm10MJ8IBEZCtfPd9XdUtzpBo9COfoeHkCI6O6rDemTO0E1x4oKXLy7WXRtfRSO6Nb3ejIHa4G+BWAbv6/9gyhNfgurNJA9uaBgEZetJ1vcFhtBHGeHYpv3Vwg4hRswqX2N7c78JD1HWk/nQuOwjF3eWZvGJwLMZmN7LtSaTIjKZrdHZR4ydFBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hP34Hk/WrpCLUQgT4Ca6BbHDoMBZJ0taafDFseRVhhk=;
 b=UqaxSfV9qchoEE02vbo+NR28WSlHmtL58OGy5sWFSbwOaVmveBwdG2JNgstGT7DlGvLyJITeOW8SAWzYhkjt4x9zs4Vv4pQ6a+OyMzKC8iB+annCQgV/rXKuqCqis0VWMIJyPYSTNIuHGdx2rwdHQ5FootXdgROj6YbSYxXKDPHBPhfKrc6Kz8N991sey9UJWgbqgReszXgZulS8y0noVyTXBVoSXiW4q8Ece17bMr2QFmheLakau7wNY+4KB6tsOlMsVEQuPaynB0JVFNOsAFowWnNFKZwiFLDMDZBMBT1n6bGZNyCOBdBYnSvhDt4sdoJr1vIujBd2Wq2iBuWu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP34Hk/WrpCLUQgT4Ca6BbHDoMBZJ0taafDFseRVhhk=;
 b=WC1+SKz7PmHh5TNmzaK6IiA1fjVWFcss1WTVH5uRoo1vxTCr7U0riqNe2AVDlguSZejBwxXigF/eCWpU3+DlJcL88/HgiNcXJ67jeaZMB6rVFTyns6EZUALsEXBCRWHyBW8eGHqq8UxzxxlKjhGT0pX3CW3FdFLiDKySaI3jDxWDnStrQ5QiDmW2o0OJVAcWxGoxWY1RbL0g2o8gwhvNluYki8xGNjr8vtbwc984O164qrUy698Votkr9bEFXZEDOrtDPpOB49SfnQ6pkyw142mQj8zCYblQkImF7Tl2GDEIYd1N0ufJ/67qZjl2U1CXn0bRbm6RP1pB3amGtllnSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM8PR04MB8036.eurprd04.prod.outlook.com (2603:10a6:20b:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Tue, 11 Nov
 2025 22:24:35 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 22:24:35 +0000
Date: Tue, 11 Nov 2025 17:24:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eric@nelint.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] net: fec: simplify the conditional
 preprocessor directives
Message-ID: <aRO3nMEu/D/kw/ja@lizhi-Precision-Tower-5810>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111100057.2660101-3-wei.fang@nxp.com>
X-ClientProxiedBy: PH8P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::12) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM8PR04MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b35de5-5d32-4284-d626-08de2171183c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DBGmjixxG50Xuer4SnQWfjPi4X2jRvYlpWer5exTfLdm879WK9+YOnTV16BA?=
 =?us-ascii?Q?V/WJ0VbO2pehmKUEq0PZ7lGSGAq1fMqZB82FIGipqdkh4ah0qhTjzCIF1j99?=
 =?us-ascii?Q?UhF5ivWYN0KziGmpiPnoD5clRUfNEmTU7uHnvmLb2l9s7gB0W+/rJPiRZu9r?=
 =?us-ascii?Q?JHpGUJmYAMTPASmXA35yAFMkp7QSsUw9jCcwFPuD3jsrltxFW/YpsMaUOEeA?=
 =?us-ascii?Q?65E32C7r3hlu/lEpHrBhPgOtoPvgtvG4Ji0YhI/d0QFH/XHw4gzC/EVtmZg1?=
 =?us-ascii?Q?e23Zo/cvHHoO58gUim+Lgv3Z3VV99J5M6bOqOunEFo5wZEOitg1r7KqrO2KX?=
 =?us-ascii?Q?PkQeWr3sHYtPW2cr9SvvvUSuGElqpbN3KLniwbr9LmlCSRURMBj0Gq61t3Fm?=
 =?us-ascii?Q?wX5uaM+tTxeSk2Lfa66VAzdYbLJVdIK1u66yAGjPvZkAmxpQMs+aZ4IQ+IFk?=
 =?us-ascii?Q?Oiy70+rqiRJVrz8VBUBjJxLNWTzX7DQpbqry2JE9/6dd1A6iPximOoNOnXQA?=
 =?us-ascii?Q?DFpcAHUkT1hPC4AYsa+SQp7VxWJSiPYdxGnl19Zv1tAkbz6y+Ini7LpCQvwr?=
 =?us-ascii?Q?r9dR3itfaCEhTt7sJtsFCGcxJbKdh7EseN72dGpLYhgcBmYTCwNt+2NjpsR8?=
 =?us-ascii?Q?PHJenMZYvlwgeaQ492XHTbZ29sc679opjilNAcRRi7ec2QCvh05faGlgbkEn?=
 =?us-ascii?Q?02Bs3fczmkdvTwWAUjpwFHdfIGmm3DZaKD51pClsc2w3Svp4F/NLXp6upOOy?=
 =?us-ascii?Q?dhY2hWIgjmRWom8A8Eek8PAbh1I2tkuMTk0ur6xkVT5cCz8hS9kOecslUh2l?=
 =?us-ascii?Q?YNkZ9NzpXOr+J7dzreMz7xZ8Ktusor8uPIxo9QzmSJ2sjBSgmiZONQvi9hxg?=
 =?us-ascii?Q?MRf/iSxTmIrdk+yawEbyfvun01E9qacNg6ivZS7cU49BeKe61j/5R3jYtZBk?=
 =?us-ascii?Q?DgoBVWUmx1r7N7k3lElMQ6E5h0KEOkjeqjfev4184e5ecdeAHTKlwUsLNJFI?=
 =?us-ascii?Q?clmOFJNWRNI0CFj+14nC+LNBCZgu12mstNRB1NeqeJyXTjr5plawIC8CFCBP?=
 =?us-ascii?Q?D8vq1OPUAZhXZf19jA9DAkBDZzADEkXVF6eo5jA215T8d7yNk2DNV+A8shd6?=
 =?us-ascii?Q?/9mBxOOeGALFYNdUFzJCBVtqlKWGmuis7IdSer7L1ZnxNh0z25j5RVGxiAbD?=
 =?us-ascii?Q?LEWYJEqin66OXobcKlxXSdKU2ryAm5VCdYpnIoEkNgOh2N+E47tXwI4owNo3?=
 =?us-ascii?Q?AHzwxrVzuzDDKabkXSUdQNIFOe4+U8kuNzl9KSU1lxM4KCDCvPc8RGwnOhjE?=
 =?us-ascii?Q?xBFzSjBcEzhVW89tMm5wyzJF4lWswIKrNKKM+8xVYNbPV5yu7xz42IxLwTXf?=
 =?us-ascii?Q?0TMRyI67rYGJGCYUtMmU9n8KPCk3WDeDKl0d78wKuOx1MouSIRhCsbupEx2F?=
 =?us-ascii?Q?BK3Rhr3evoaVXkWkWLhg9jmZpvaVPs3+olctUsPstahcXGFO4y9jI3yelanr?=
 =?us-ascii?Q?sbrSBZjF3SadRywKY1q2jmD5SRbe+1vuoCLV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zEN1gt9VO8D3C96+QOWq6O89PHO71z0Pn32GXsyE/xmNsxMYTuU0gC8kUz4/?=
 =?us-ascii?Q?SHY00TZ2IyKb2VU/1Q0ivCvXtZTCDzXKtZD7OvaiwtkJtdW789OGpplxcUKe?=
 =?us-ascii?Q?XxTQr/RK3eF7sDdNakH5cMBpsxI9Ax3vQdQ6OaUDHcaGF8ATXTHbwzGGYfkC?=
 =?us-ascii?Q?iqbBhsmxu/TFYB/hAdOk0HwrR+sNeUGy4QMuu9mnnoyTpMrGAIjsjaUYVo9z?=
 =?us-ascii?Q?Ko4650ntIptEBHUNmdn8QpY66uwsIiy9RpYAOvqAobQZCTFjyXsiwgoeGrbv?=
 =?us-ascii?Q?IAhRp4Gc1ve9bJ9KUETIuO2L8qUtS93Fy64nQwUEgWWlI1S3HsTuzeG6ENkI?=
 =?us-ascii?Q?FEPrPOXfqU+1WXeSp2LW/o2BZimnalZcoD8mJGxB4++ke/j8EtubvvG/azfZ?=
 =?us-ascii?Q?T+QLjWIa98usljHIwm2Mdc7uEFCzqvtQ6YIRk2N3bZWcJ+5xoAsac/C/jea/?=
 =?us-ascii?Q?8naWPV7+z+bAV0Kqtn/s3KHK7Eih3rPMOmwWNKOY7PCqwkR3xjnTzgT7jjsm?=
 =?us-ascii?Q?KgNSafXuf4mw7MsJi+Kb1b0Cj/wix4p8WP5CEFccfXcA2MzXBwsRKw/Cy2oe?=
 =?us-ascii?Q?IadgnNehfKbTKB3vdv+VrEm4AGs8PVGxAu/2FAODUIQPIpDq29Bx8cnNSyJt?=
 =?us-ascii?Q?F659jWz8Y9yzDaKfABFetukIa1xxqLGzvz9h0y8Hq3OSPsWiVTam5WZ7fibo?=
 =?us-ascii?Q?Kbly16ZX6yOb3PFSnkDxKCYoGezxqyfdLHQvIL91geJ8iFZ7Jyd+mTiIJDYV?=
 =?us-ascii?Q?XlnyVcIw8JmxXlycI4YQ6dPGdSJgB7Zk1vz6nb5jvpTz9r0UB/xjMKU+t8ye?=
 =?us-ascii?Q?vKPJZdHo/g8gWcMwFg2TYgXtQW0psxw2hQEx048O0xhj31ygzwrbKy0gh8vV?=
 =?us-ascii?Q?MwFz/gEa0mFOJGj1y+FUTipbVTHLFj1pYWZdCpYm7iIJ2mshexcE0qD04Pls?=
 =?us-ascii?Q?Or9K/EJL1fx7Lh//6L3VdyuvHrKW1eB9PS31aJrhPlN531OzQgKFnkML4kzQ?=
 =?us-ascii?Q?NdnkizItLnl5In2myPV30ifEey10ZAOqTxRK769Z8p0/KqFVtQYN9HadX+ut?=
 =?us-ascii?Q?xRdwV5J8BfksiFjfWf9LelK2xy90IwSIlZ/PGVcyOnOEYwU8bODjZKyA4u8g?=
 =?us-ascii?Q?OD5VydD1dfmT6NRXKVAN/kJmIhmT5m+ydTTd5C3Qdnqon1mzMOzuzp6oeZ6v?=
 =?us-ascii?Q?ilJZysWxZDC7/Tm6aqbvsEsg1PQp0vEcR2KUwturAvEKduhIa1YrvHXZT3GO?=
 =?us-ascii?Q?DDPkrwjNIoAzFw0VHMQg5cSQsLpua0Z1/LxykWU8ZI6yTeE7wpJpXQ/YyxMh?=
 =?us-ascii?Q?Jsav80gIUoQ1f6pByl2h/oEniQWdq9x0TUG/e6svaJQeF1j7a0x37eIWKtaJ?=
 =?us-ascii?Q?B0Z83B8oV08QKI7UdCmZd6IbzufKibf/OYSmZZKe/YEe4GN1wkkGwh7Epdh8?=
 =?us-ascii?Q?vlT55oqwa33T2zrrJf7pZe8GHyp4NDCcjETouN7rCm2VjdEYzp1DuSnvLEm5?=
 =?us-ascii?Q?DW/+tncKFv+P7zN7cXNXIIzsqDwPi6HAM7mcNRYlo1F7I+2ejJ2ZTnicI/C0?=
 =?us-ascii?Q?w9VTsDUXdEvskgv0HXd2R19yOrXHHlhPxikI2SJu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b35de5-5d32-4284-d626-08de2171183c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 22:24:35.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkQUx4e9b7YRla46GFBJoqogoCHMObgU/zjH1f391d2cu4FY+KazfGo2ggP6khX+wlQxu4xyMnyDCKqM1C5Hcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8036

On Tue, Nov 11, 2025 at 06:00:54PM +0800, Wei Fang wrote:
> From the Kconfig file, we can see CONFIG_FEC depends on the following
> platform-related options.
>
> ColdFire: M523x, M527x, M5272, M528x, M520x and M532x
> S32: ARCH_S32 (ARM64)
> i.MX: SOC_IMX28 and ARCH_MXC (ARM and ARM64)
>
> Based on the code of fec driver, only some macro definitions on the
> M5272 platform are different from those on other platforms. Therefore,
> we can simplify the following complex preprocessor directives to
> "if !defined(CONFIG_M5272)".
>
> "#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || \
>      defined(CONFIG_M528x) || defined(CONFIG_M520x) || \
>      defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
>      defined(CONFIG_ARM64)"
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec.h      |  4 +---
>  drivers/net/ethernet/freescale/fec_main.c | 27 ++++++-----------------
>  2 files changed, 8 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 41e0d85d15da..8e438f6e7ec4 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -24,9 +24,7 @@
>  #include <linux/timecounter.h>
>  #include <net/xdp.h>
>
> -#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
> -    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
> -    defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
> +#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
>  /*
>   *	Just figures, Motorola would have to change the offsets for
>   *	registers in the same peripheral device on different models
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index e0e84f2979c8..9d0e5abe5f66 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -253,9 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
>   * size bits. Other FEC hardware does not, so we need to take that into
>   * account when setting it.
>   */
> -#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
> -    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
> -    defined(CONFIG_ARM64)
> +#ifndef CONFIG_M5272
>  #define	OPT_ARCH_HAS_MAX_FL	1
>  #else
>  #define	OPT_ARCH_HAS_MAX_FL	0
> @@ -2704,9 +2702,7 @@ static int fec_enet_get_regs_len(struct net_device *ndev)
>  }
>
>  /* List of registers that can be safety be read to dump them with ethtool */
> -#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
> -	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
> -	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
> +#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
>  static __u32 fec_enet_register_version = 2;
>  static u32 fec_enet_register_offset[] = {
>  	FEC_IEVENT, FEC_IMASK, FEC_R_DES_ACTIVE_0, FEC_X_DES_ACTIVE_0,
> @@ -2780,29 +2776,20 @@ static u32 fec_enet_register_offset[] = {
>  static void fec_enet_get_regs(struct net_device *ndev,
>  			      struct ethtool_regs *regs, void *regbuf)
>  {
> +	u32 reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
>  	struct fec_enet_private *fep = netdev_priv(ndev);
>  	u32 __iomem *theregs = (u32 __iomem *)fep->hwp;
> +	u32 *reg_list = fec_enet_register_offset;
>  	struct device *dev = &fep->pdev->dev;
>  	u32 *buf = (u32 *)regbuf;
>  	u32 i, off;
>  	int ret;
> -#if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
> -	defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARM) || \
> -	defined(CONFIG_ARM64) || defined(CONFIG_COMPILE_TEST)
> -	u32 *reg_list;
> -	u32 reg_cnt;
> -
> -	if (!of_machine_is_compatible("fsl,imx6ul")) {
> -		reg_list = fec_enet_register_offset;
> -		reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
> -	} else {
> +
> +#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
> +	if (of_machine_is_compatible("fsl,imx6ul")) {

There are stub of_machine_is_compatible(), so needn't #ifdef here.

Frank
>  		reg_list = fec_enet_register_offset_6ul;
>  		reg_cnt = ARRAY_SIZE(fec_enet_register_offset_6ul);
>  	}
> -#else
> -	/* coldfire */
> -	static u32 *reg_list = fec_enet_register_offset;
> -	static const u32 reg_cnt = ARRAY_SIZE(fec_enet_register_offset);
>  #endif
>  	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0)
> --
> 2.34.1
>

