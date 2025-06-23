Return-Path: <netdev+bounces-200301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F11AE47BC
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9391640C2
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BB2253F30;
	Mon, 23 Jun 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ez3DO0op"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012011.outbound.protection.outlook.com [52.101.71.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164318634F;
	Mon, 23 Jun 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690686; cv=fail; b=kTpVPQkoaoIoOYGZjmNoADdKBQRaOtYYxHRx4MQEgHyAEwCqCP//FvN014EdsitJGM6GlzE98+OZPhko7ECKTmplxlDl8DvVXUfw/Adc0MOjLIOe/PkjF2Fp8/odoTw0ZhTbQz31PS20sJO0NogFmc62o4d9Adw6PAAkKyLTRdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690686; c=relaxed/simple;
	bh=b7AgYSn6snFOg03UI0bu8w897bGUgLj7w5VjAOTQ1uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aR6tYE1TrT01QZByOgRpE9VQUBnJOgiGJ2i3WARRids83X5l7Wu3J/1fNyw85XbG060CVN5fOA7k/OB1Tllu8yUUXxJbcDEryW+7KnDxKjce5gcc0MkcYwdsykG/vqRhUXcizazg//wkh4vnPIn0QcoqRdXmcMKI6JPk54/cKu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ez3DO0op; arc=fail smtp.client-ip=52.101.71.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azyVjHyWgy1TYN5zZ5igVlfxJX1XHhTvJWVuECcIeegcw9m/2TNvurImCF5DRFP9gRgrZvkmXN4Onv8m6unrGVRgT+Umxr5z2no2U4utm3HcqUIDOloWyU0spQFlAiH6vB3sE45PuYruZ4be+vd0+jALKgvtzoEb6upGf1Cro89dorlnYllns/gvzTT8bUnQBO/G4tqEg3vOAAJp3AExH5KXhaJ5twH2vkvIqPuJ+mgAh5bIpr2cU78C1p8Mm4+0pMOD0oEMqnlOEf9ec9rq4JzQGNwUo9BEdwgT6U5DIdPwyyHmlXSdzYukVCmJXKLiKOoBfvK6ZCspo7YNhZDuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCPBwq2HKXi49MxwBB5S/RqN1UdJ6aXoIyIcpkVk3dM=;
 b=s/pR7ZbsjKFCSFglAagEXPMpO329+sqxjwPs1HfhUVZ5BYJhgl6Sv+v0ACcVYQaPtZklCV2qnxVkEv426QcemuRnSusuJRY44v5nSupkGAg+C1vpKYReLgiNWGA3jr+ckn77443uqnKeTkA3h7v6/fegbs9tunZFNmjfw8YfwQEn3Eukbj8TOrvLKARc6vvQLz6+DDIB4HjtZl6bdNJTS2hZjJkKIzwvw7ukmKzqQsYNWzqpDMkng8mb9sIpFwr49B6ZTbYW9ZI/00NbW87FWg7zmP9uFCDOGcHAlBXbIo8EjFftxNGjpxPT8h1YAgBzLW+dtV2o0XYwtYbnG5pfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCPBwq2HKXi49MxwBB5S/RqN1UdJ6aXoIyIcpkVk3dM=;
 b=Ez3DO0opC4ThzkMzrUlXEgnPOdFJM6EhsBVDzii4d8TqFK3c4qbTsaU7qGBoJSCD0Nl+EdSBZZR+uEmRC2KV8uy2YbHQOVxy3Es77h4E9pYAUY3FoRBfzHo4yjsFNJ3m01scbGfrey26R3reNPuqHpOPqyOd1HeJBionOgz8ct8+Si9+ca8fUojV+1wpRkJNAvpSVXt+JuM8gtU51FeSHSeOTsvEb++XLpT3G1em5rKyJWjWFMl/vqMcykVG8ZBWqdDHwWOHAz6RCMaHdWpoeqpMoW7qmaATM7MJMyX1j6DV/rzdyw8M0h5ciAQu3Zu5+akVBOk1/3FEXwovlMYgpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10420.eurprd04.prod.outlook.com (2603:10a6:800:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 14:58:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Mon, 23 Jun 2025
 14:58:00 +0000
Date: Mon, 23 Jun 2025 10:57:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de,
	catalin.marinas@arm.com, will@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, ulf.hansson@linaro.org,
	richardcochran@gmail.com, kernel@pengutronix.de, festevam@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-pm@vger.kernel.or, ye.li@nxp.com, ping.bai@nxp.com,
	aisheng.dong@nxp.com
Subject: Re: [PATCH v6 5/9] arm64: dts: freescale: add i.MX91 11x11 EVK basic
 support
Message-ID: <aFlraxSHCaPMDxd+@lizhi-Precision-Tower-5810>
References: <20250623095732.2139853-1-joy.zou@nxp.com>
 <20250623095732.2139853-6-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623095732.2139853-6-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10420:EE_
X-MS-Office365-Filtering-Correlation-Id: eedffcbe-555e-4e67-bb22-08ddb266587d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nhoX+DomRo+VeaMysF/9ypPAO3xAZO41SLevo6U+xeEneixMrhSYJtlGMioo?=
 =?us-ascii?Q?WUd1VLyfBHvZm8tqpyS9bUC1wJn18fGqf1NhLMDAQzKS6qbWpBm414aNYGnP?=
 =?us-ascii?Q?40rfHQalFZMzILl0KwJ3daXqlwiW1yE+kx2sAhi/n91j9ruO+XoQdg5mAWLK?=
 =?us-ascii?Q?MBlUVkXbHr9GbBvnAF0y2EXCNRCheCXdNWupnKF5VMVigq4UiWUI19aPkWBN?=
 =?us-ascii?Q?Z3laATg0m2K46sDSVdnozBTRWmYGW+ahYV+QyX6nb9UOdRdJZ7pX/z9bX9r3?=
 =?us-ascii?Q?4qyQ/nc42AWKR79hrVeJY3FVKExLW0xPTtcVzxUyS2F0gNEfxT5mld3QXBUP?=
 =?us-ascii?Q?lW4AIoLd9Abme5m7QufYVoZOt6MNbcpUS1RY0eq1dpP6lwjH0TGs30uHFSmR?=
 =?us-ascii?Q?rtvuIpZKohOTamNML9RL7cNXGbihMjFJjX2ul7qp0F1JF4yKHIenBUlQQBmL?=
 =?us-ascii?Q?1a5GWWqeviuhA7dlf414jEeSgXj09AJr5J/Adu9dCssGaFIbuF91RnyD6lhV?=
 =?us-ascii?Q?3RaBfhFz/Qm8OgbPV6T5EhfROdQgrIq/j7iez4RNwLLneQ++WPHDPWnC4hmK?=
 =?us-ascii?Q?rbMQf+0Vsy8XQhcf9M94wtERVRlOCTc98BJl3u+n8LZxX0WZqfdR4dgwNqxa?=
 =?us-ascii?Q?IWfMYt+jxt1+BefuIUk2kO78w4+XJ7TQVZPh/0Y3WIYtyLhGQWT6Tycoiqv0?=
 =?us-ascii?Q?kE/R3JA9ZgtKVWW3c9N56BBLy2QzFvDGfDnqMfpWYc0KKlYfuqA5osd86hOZ?=
 =?us-ascii?Q?fCXXV36T+kagI/n0zGBB4ly6l/LzJmatAeUlP+npRZRlW4E0VAN2zE6UVkcz?=
 =?us-ascii?Q?YHgecqKncQ+te9NO8pvCBPfBQN1S4egobgIt4Nx7gvpeLBwuwDaa3APWmoXv?=
 =?us-ascii?Q?BMd+ftWPMA3iVqtukJMLvCjw9ZRBzPElW4jhmrN/z6kmsA3Vsv4AciKCQ/Xi?=
 =?us-ascii?Q?zlFTrHEUdgyZaB/5hGZnbV8CElYyE2/PwUmaaaKzC/8NbNJtZQO1q9xzkdBi?=
 =?us-ascii?Q?Reth7GiiunY3/E3BvWxKEJZy08+7v1aSszSc6NHQX/cQu2/4KD+pBVbMR1dG?=
 =?us-ascii?Q?rkPmIPa7c+hFEpPGjy9RC6xKT5K+rrMngmR787XhwKew1XhOPjejjU0I+mI1?=
 =?us-ascii?Q?VxLfkQfUHSpwPRQeWmTPsgxBn7ta2aFp8ohB0i/D33P3MX49MlKHeg1QNZ67?=
 =?us-ascii?Q?MPVFrlzJ/IKWOCiGbv7ZpVQt9SWe4qzuGM+F+2Y9KodBRb+6V/XyndkOnXZW?=
 =?us-ascii?Q?Cat7YZjiGsYKZvuc7GmR6Bw/7nEHZuuaq6sNI5rMGXSOD4bQErCfydM4jFiP?=
 =?us-ascii?Q?eHEoSCdH75PrdqGRRqRVrFvKUWj0YXQTugAzA0OS6xJmyRpouo2EgnO9HOQW?=
 =?us-ascii?Q?2wKg0UOpR3pPqiTUGveRo/Sc4BYQlBi62TeWh3KxXtxn7eBriMRvjaVPsCPj?=
 =?us-ascii?Q?geZvCnCByzciinoGGAVyU6RAM5h1Zw87usbeAemC+nAXkkFDX5oYHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DfzZTAAhtLIsv8wemhwoEJ+sTMUYJ9wuXmYH+9JMLFjHSeufWz901iy9X66x?=
 =?us-ascii?Q?nY/TEC5kCSOqetwA6aw86jSa8x+CXSA5TiH9xOUHHX0ewQTAjQ5aJpmrIyOv?=
 =?us-ascii?Q?rkZYCfBGIZlJUvQYsZpWzYMe2bpzXiYLZWEM5e6/Ipte5cHVgk4rjl++2y7g?=
 =?us-ascii?Q?+/x2Ea8dT2qE1jWdVCmTLGwL0lX80T3wg5a0JLAAOzZoo7jGqo685/fxfQAJ?=
 =?us-ascii?Q?86cWr/szX482mvZtkg/K1ah2/LxLRY4XuoDbJYkuUgcY8AStifXB5bVi5OAs?=
 =?us-ascii?Q?gVmbriR3vbiA8VUVaVX8ovww+hAPMFJAtsHRAxYKfdCx0O9Co53CDtIzpjZX?=
 =?us-ascii?Q?KgPlZB+dF6ZI0xTNZn17yQPGoL2IeQX4I9W4NLBdRdkZhVECUidk5LXfzU92?=
 =?us-ascii?Q?dG9Ca8OMOZEGKyl+/yD1HaskTqnWVV2i6ENhCG24uBOyUsAiwj+oy5zVTQjc?=
 =?us-ascii?Q?ZQvtv0nDst6Aa941+hm+vpNNZtgw0c7fzJSsmKXg98Q3Ehc4h+zdzymSJWfx?=
 =?us-ascii?Q?TQ7WSN/xWOoQkItGe+xzaMpTznbN16Smt9GGk3FiOVKWvcVRo86P/Y9KVJXq?=
 =?us-ascii?Q?+GwtcEBnjPqMolzQl2QFgpsIIo2tFLfRavsq1KwPH7U6ZYrOC7XL9qWsdEG9?=
 =?us-ascii?Q?RMWd7M1IJ+7UF809JuO4gAcxY68XoyMavrdtyYUJVAooPeVgOnjz/MsTcbjP?=
 =?us-ascii?Q?5RtainvS4Pt0oTr7pMnbvm/ldqx9ox6FF+HhVmEzEAooJt6w3oUg99DOe7h1?=
 =?us-ascii?Q?SrIz0TcBIewyzqFbwqRQdtCLS0QAbomg3KEDnbYcZLdvDleChOvUp5NyCTbC?=
 =?us-ascii?Q?IZIb8Tosrt5u5QluD11UMv4SeG+Lzj4BQrAH025Ot+BALYyleRTAUDkt3KdP?=
 =?us-ascii?Q?uubLd9CBGVM0gWspsDBfHoLN0fCVCZ1LPqRK+R6Ir1S8aZvMVzPPXuSH44lc?=
 =?us-ascii?Q?YisUM7Ug3mUk1def2OGzFxrWN0nPnWGe0n5Vn8XhoPsBzAPsGz17TM+9tZpr?=
 =?us-ascii?Q?cGTOE7V6gQYP3S79EwHwTXZcXEUAvtt0Xbdjz/+Xl4ZU2q/rSdJJ7x6M/QVR?=
 =?us-ascii?Q?1rO1kPuz7fJwDyaDSSa81ygtTKoyzg6kDiiI2Ir5FqlGwbdCYusHKQWAkb22?=
 =?us-ascii?Q?z0MwCzBCIv+4jU8FMfKoYLjxqr1TKA3uoSwivIvSqMmaU0LoOVIKbvGgJj8e?=
 =?us-ascii?Q?R2lvLTTSXu7I4hZAqPWLOFO2C8ufsyYddVLsPi3pNadfkFyskCPmGU1//BlN?=
 =?us-ascii?Q?ue/mzs9ehAMAwTaiJuWwGEAxVJkHBYG6Hc9Syw8/ydYO+BCkA4xH5vMMYUxt?=
 =?us-ascii?Q?AqQ1j5BSOjIKb4YZXvY+UuyDVT2xij+8i7I8b5Ul0CtFBmAgufKz1QkhYb/6?=
 =?us-ascii?Q?PVrIyDK3LXIZ7ZlQRdTc9hUsZ55SXBmOoNtg0ZpieqHv/0AJFx7cH6EGj0V9?=
 =?us-ascii?Q?f6A2inGWyHEoHVNUJ7wK+De35/UNYVAE2i5NGHyQubdQ5MHpW/a2spafhMCZ?=
 =?us-ascii?Q?q7bqMJpQKCsSW4Q+HRpsKWJG2cfn/jW2eBKWeWK070/9VtLSBvMqGpcoEoeX?=
 =?us-ascii?Q?x3AZALYFpsz4HF/XIoU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedffcbe-555e-4e67-bb22-08ddb266587d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:58:00.0766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPKiJEWp3+qKG8qJG68nk44XQ98uzon8XFD7dl8F5DYREy7z4gc5LDGIW1pwxx1YkYd4SzAA8jXgpcguVuV7jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10420

On Mon, Jun 23, 2025 at 05:57:28PM +0800, Joy Zou wrote:
> Add i.MX91 11x11 EVK board support.
> - Enable ADC1.
> - Enable lpuart1 and lpuart5.
> - Enable network eqos and fec.
> - Enable I2C bus and children nodes under I2C bus.
> - Enable USB and related nodes.
> - Enable uSDHC1 and uSDHC2.
> - Enable Watchdog3.
>
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v6:
> 1. remove unused regulators and pinctrl settings.
>
> Changes for v5:
> 1. change node name codec and lsm6dsm into common name audio-codec and
>    inertial-meter, and add BT compatible string.
>
> Changes for v4:
> 1. remove pmic node unused newline.
> 2. delete the tcpc@50 status property.
> 3. align pad hex values.
>
> Changes for v3:
> 1. format imx91-11x11-evk.dts with the dt-format tool.
> 2. add lpi2c1 node.
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx91-11x11-evk.dts    | 666 ++++++++++++++++++
>  2 files changed, 667 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 0b473a23d120..fbedb3493c09 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -315,6 +315,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqps-mb-smarc-2.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
>
>  imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
>  dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb-i3c.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> new file mode 100644
> index 000000000000..0acd97ed14da
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> @@ -0,0 +1,666 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/usb/pd.h>
> +#include "imx91.dtsi"
> +
> +/ {
> +	compatible = "fsl,imx91-11x11-evk", "fsl,imx91";
> +	model = "NXP i.MX91 11X11 EVK board";
> +
> +	aliases {
> +		ethernet0 = &fec;
> +		ethernet1 = &eqos;
> +		rtc0 = &bbnsm_rtc;
> +	};
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	reg_vref_1v8: regulator-adc-vref {
> +		compatible = "regulator-fixed";
> +		regulator-max-microvolt = <1800000>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-name = "vref_1v8";
> +	};
> +
> +	reg_audio_pwr: regulator-audio-pwr {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "audio-pwr";
> +		gpio = <&adp5585 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		off-on-delay-us = <12000>;
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		pinctrl-names = "default";
> +		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-name = "VSD_3V3";
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reserved-memory {
> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			alloc-ranges = <0 0x80000000 0 0x40000000>;
> +			reusable;
> +			size = <0 0x10000000>;
> +			linux,cma-default;
> +		};
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply = <&reg_vref_1v8>;
> +	status = "okay";
> +};
> +
> +&eqos {
> +	phy-handle = <&ethphy1>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	pinctrl-1 = <&pinctrl_eqos_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			reg = <1>;
> +			realtek,clkout-disable;
> +		};
> +	};
> +};
> +
> +&fec {
> +	phy-handle = <&ethphy2>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	pinctrl-1 = <&pinctrl_fec_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy2: ethernet-phy@2 {
> +			reg = <2>;
> +			eee-broken-1000t;
> +			realtek,clkout-disable;
> +		};
> +	};
> +};
> +
> +/*
> + * When add, delete or change any target device setting in &lpi2c1,
> + * please synchronize the changes to the &i3c1 bus in imx91-11x11-evk-i3c.dts.
> + */

Please remove this unused comments, there are not imx91-11x11-evk-i3c.dts
yet.

> +&lpi2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	audio_codec: wm8962@1a {
> +		compatible = "wlf,wm8962";
> +		reg = <0x1a>;
> +		clocks = <&clk IMX93_CLK_SAI3_GATE>;
> +		AVDD-supply = <&reg_audio_pwr>;
> +		CPVDD-supply = <&reg_audio_pwr>;
> +		DBVDD-supply = <&reg_audio_pwr>;
> +		DCVDD-supply = <&reg_audio_pwr>;
> +		MICVDD-supply = <&reg_audio_pwr>;
> +		PLLVDD-supply = <&reg_audio_pwr>;
> +		SPKVDD1-supply = <&reg_audio_pwr>;
> +		SPKVDD2-supply = <&reg_audio_pwr>;
> +		gpio-cfg = <
> +			0x0000 /* 0:Default */
> +			0x0000 /* 1:Default */
> +			0x0000 /* 2:FN_DMICCLK */
> +			0x0000 /* 3:Default */
> +			0x0000 /* 4:FN_DMICCDAT */
> +			0x0000 /* 5:Default */
> +		>;
> +	};
> +
> +	inertial-meter@6a {
> +		compatible = "st,lsm6dso";
> +		reg = <0x6a>;
> +	};
> +};
> +
> +&lpi2c2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	pcal6524: gpio@22 {
> +		compatible = "nxp,pcal6524";
> +		reg = <0x22>;
> +		#interrupt-cells = <2>;
> +		interrupt-controller;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		interrupt-parent = <&gpio3>;
> +		pinctrl-0 = <&pinctrl_pcal6524>;
> +		pinctrl-names = "default";
> +	};
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9451a";
> +		reg = <0x25>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent = <&pcal6524>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <2237500>;
> +				regulator-min-microvolt = <650000>;
> +				regulator-name = "BUCK1";
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK2";
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck4: BUCK4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK4";
> +			};
> +
> +			buck5: BUCK5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK5";
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-min-microvolt = <600000>;
> +				regulator-name = "BUCK6";
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <1600000>;
> +				regulator-name = "LDO1";
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <800000>;
> +				regulator-name = "LDO4";
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-name = "LDO5";
> +			};
> +		};
> +	};
> +
> +	adp5585: io-expander@34 {
> +		compatible = "adi,adp5585-00", "adi,adp5585";
> +		reg = <0x34>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		#pwm-cells = <3>;
> +		gpio-reserved-ranges = <5 1>;
> +
> +		exp-sel-hog {
> +			gpio-hog;
> +			gpios = <4 GPIO_ACTIVE_HIGH>;
> +			output-low;
> +		};
> +	};
> +};
> +
> +&lpi2c3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	ptn5110: tcpc@50 {
> +		compatible = "nxp,ptn5110", "tcpci";
> +		reg = <0x50>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio3>;
> +
> +		typec1_con: connector {
> +			compatible = "usb-c-connector";
> +			data-role = "dual";
> +			label = "USB-C";
> +			op-sink-microwatt = <15000000>;
> +			power-role = "dual";
> +			self-powered;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			try-power-role = "sink";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					typec1_dr_sw: endpoint {
> +						remote-endpoint = <&usb1_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	ptn5110_2: tcpc@51 {
> +		compatible = "nxp,ptn5110", "tcpci";
> +		reg = <0x51>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-parent = <&gpio3>;
> +		status = "okay";
> +
> +		typec2_con: connector {
> +			compatible = "usb-c-connector";
> +			data-role = "dual";
> +			label = "USB-C";
> +			op-sink-microwatt = <15000000>;
> +			power-role = "dual";
> +			self-powered;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			try-power-role = "sink";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					typec2_dr_sw: endpoint {
> +						remote-endpoint = <&usb2_drd_sw>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	pcf2131: rtc@53 {
> +		compatible = "nxp,pcf2131";
> +		reg = <0x53>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent = <&pcal6524>;
> +		status = "okay";
> +	};
> +};
> +
> +&lpuart1 {
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&lpuart5 {
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "nxp,88w8987-bt";
> +	};
> +};
> +
> +&usbotg1 {
> +	adp-disable;
> +	disable-over-current;
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	usb-role-switch;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	status = "okay";
> +
> +	port {
> +		usb1_drd_sw: endpoint {
> +			remote-endpoint = <&typec1_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usbotg2 {
> +	adp-disable;
> +	disable-over-current;
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	usb-role-switch;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	status = "okay";
> +
> +	port {
> +		usb2_drd_sw: endpoint {
> +			remote-endpoint = <&typec2_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usdhc1 {
> +	bus-width = <8>;
> +	non-removable;
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	bus-width = <4>;
> +	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	no-mmc;
> +	no-sdio;
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	status = "okay";
> +};
> +
> +&wdog3 {
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET1_MDC__ENET1_MDC                           0x57e
> +			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO                      0x57e
> +			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                  0x57e
> +			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                  0x57e
> +			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                  0x57e
> +			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                  0x57e
> +			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC                  0x5fe
> +			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL            0x57e
> +			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                  0x57e
> +			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1                     0x57e
> +			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                  0x57e
> +			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                  0x57e
> +			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK  0x5fe
> +			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL            0x57e
> +		>;
> +	};
> +
> +	pinctrl_eqos_sleep: eqossleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET1_MDC__GPIO4_IO0                           0x31e
> +			MX91_PAD_ENET1_MDIO__GPIO4_IO1                          0x31e
> +			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
> +			MX91_PAD_ENET1_RD1__GPIO4_IO11                          0x31e
> +			MX91_PAD_ENET1_RD2__GPIO4_IO12                          0x31e
> +			MX91_PAD_ENET1_RD3__GPIO4_IO13                          0x31e
> +			MX91_PAD_ENET1_RXC__GPIO4_IO9                           0x31e
> +			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8                        0x31e
> +			MX91_PAD_ENET1_TD0__GPIO4_IO5                           0x31e
> +			MX91_PAD_ENET1_TD1__GPIO4_IO4                           0x31e
> +			MX91_PAD_ENET1_TD2__GPIO4_IO3                           0x31e
> +			MX91_PAD_ENET1_TD3__GPIO4_IO2                           0x31e
> +			MX91_PAD_ENET1_TXC__GPIO4_IO7                           0x31e
> +			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                        0x31e
> +		>;
> +	};
> +
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET2_MDC__ENET2_MDC			0x57e
> +			MX91_PAD_ENET2_MDIO__ENET2_MDIO			0x57e
> +			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x57e
> +			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x57e
> +			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2		0x57e
> +			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3		0x57e
> +			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC		0x5fe
> +			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x57e
> +			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x57e
> +			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x57e
> +			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2		0x57e
> +			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3		0x57e
> +			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC		0x5fe
> +			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x57e


Can you align all these number to the same column.

Frank
> +		>;
> +	};
> +
> +	pinctrl_fec_sleep: fecsleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET2_MDC__GPIO4_IO14			0x51e
> +			MX91_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
> +			MX91_PAD_ENET2_RD0__GPIO4_IO24			0x51e
> +			MX91_PAD_ENET2_RD1__GPIO4_IO25			0x51e
> +			MX91_PAD_ENET2_RD2__GPIO4_IO26			0x51e
> +			MX91_PAD_ENET2_RD3__GPIO4_IO27			0x51e
> +			MX91_PAD_ENET2_RXC__GPIO4_IO23			0x51e
> +			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
> +			MX91_PAD_ENET2_TD0__GPIO4_IO19			0x51e
> +			MX91_PAD_ENET2_TD1__GPIO4_IO18			0x51e
> +			MX91_PAD_ENET2_TD2__GPIO4_IO17			0x51e
> +			MX91_PAD_ENET2_TD3__GPIO4_IO16			0x51e
> +			MX91_PAD_ENET2_TXC__GPIO4_IO21			0x51e
> +			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20		0x51e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins = <
> +			MX91_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
> +			MX91_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c2: lpi2c2grp {
> +		fsl,pins = <
> +			MX91_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
> +			MX91_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c3: lpi2c3grp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
> +			MX91_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_pcal6524: pcal6524grp {
> +		fsl,pins = <
> +			MX91_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_RESET_B__GPIO3_IO7                 0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX91_PAD_UART1_RXD__LPUART1_RX			0x31e
> +			MX91_PAD_UART1_TXD__LPUART1_TX			0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins = <
> +			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
> +			MX91_PAD_DAP_TDI__LPUART5_RX		0x31e
> +			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
> +			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK		0x158e
> +			MX91_PAD_SD1_CMD__USDHC1_CMD		0x138e
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x138e
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x138e
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x138e
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x138e
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x138e
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x138e
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK		0x15fe
> +			MX91_PAD_SD1_CMD__USDHC1_CMD		0x13fe
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK		0x1582
> +			MX91_PAD_SD1_CMD__USDHC1_CMD		0x1382
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x1382
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x1382
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x1382
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x1382
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x1382
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x1382
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x1382
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x1382
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK		0x158e
> +			MX91_PAD_SD2_CMD__USDHC2_CMD		0x138e
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK		0x15fe
> +			MX91_PAD_SD2_CMD__USDHC2_CMD		0x13fe
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK		0x1582
> +			MX91_PAD_SD2_CMD__USDHC2_CMD		0x1382
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x1382
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x1382
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x1382
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x1382
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__GPIO3_IO1             0x51e
> +			MX91_PAD_SD2_CMD__GPIO3_IO2		0x51e
> +			MX91_PAD_SD2_DATA0__GPIO3_IO3		0x51e
> +			MX91_PAD_SD2_DATA1__GPIO3_IO4		0x51e
> +			MX91_PAD_SD2_DATA2__GPIO3_IO5		0x51e
> +			MX91_PAD_SD2_DATA3__GPIO3_IO6		0x51e
> +			MX91_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
> +		>;
> +	};
> +
> +};
> --
> 2.37.1
>

