Return-Path: <netdev+bounces-200315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52967AE47FE
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCDCE7A7E3D
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7F326F477;
	Mon, 23 Jun 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QGBQiaE6"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010056.outbound.protection.outlook.com [52.101.69.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E457E214A7B;
	Mon, 23 Jun 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691449; cv=fail; b=HOUlO8oRp8udXavkEPFBc6ViF0iJwDSz22tOWwJVyYIAAMwMmX635EbVdWfsm1u/wFLxyti6RQRluxRwTDjuWPKUz+zq90KGCKKesoM3p4BM5Czh7U/GBfIcY2TNC2Kk059PoDpzdXY8e/rNYzGZRlSkqYaDOZHcjSGlrzZ8reg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691449; c=relaxed/simple;
	bh=Fk8dhuP/FlcR935hZQkB5J0LkGsbfcGHIyjIrNCFyj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OGGQfeE8M9XnfSh4DurLIfVewCdpgAJ4RG0GGRjntJM1wnUO9Q96nTnQXkv+zypps0Q5aHSUaFOWDgL2CM3NeNM3qr+KYHZqGf0s9B8LVWCr75DoYazHKORQBAo6BgsZpMGG/ihP3Iy4e1yU16hATWTgzg5zEFIZ/Ab8iGzWduE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QGBQiaE6; arc=fail smtp.client-ip=52.101.69.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnWl11gZOxjo5IbNluBS42r35vJR+NjNI4UDoX9hvBk19HVT0ZDeh87VOB+IZslkpi8DlyX1Lx+/yD72f150HiFpJfYh0JqfQELfLGfiK3ZJdq3SRjU3jlvHiMxQQ/VSnRnu4c2ATPvpRZ1fE/7+89BwF2J5J8ff6lR/lzJOVBB4wRzpvIDZbOmGBD7qukqcX8snWrawfyYivQ4CJwWt1261ARHmcupkHmdLFu6SrmkoYplFYCmd+fZDyjlsiwwRiSrt8ZG1iMvv82X40c1CZCxYLUelwwUUX8aNrSHRbsAGkril8ebTqB+9+Ht2L0K5NLSkS8ZBuIdPMiIEwCreHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/wh8z2DALyVb/yP6dQQfNa16xMYFQ7v3LTGbThDhzM=;
 b=yl/YWnzq4z+gOKPzrD9RPheHZaL8wnITTWRLpDCPFFENE4Pa08xu9OCmHVof+ji8+bX7XS87fHY6WkTMjURptC0/1wM676gDTSusQ3MyDsDoE/IQD12OvoiDL74CJCI25x/Lz5LCCS8nJyK+eH/rgh+YKj8nKU5QTe2iLUOkTyKlRqKvay/w0Ef9xtLI1wpIoXgSP4R5WuYEs9S9BUNHGGzkqgDpmVHpP4piccO/gmDs3CEN0MG4dpDhQj/fK6hAcZD4kcDCjp5Siu/VRUrHf9GV+Mqm2wJU94GCV1f+P18bo9Z1V1LX2CY/S6KwrR2SzDhpMZTazP/ySG8JfoS9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/wh8z2DALyVb/yP6dQQfNa16xMYFQ7v3LTGbThDhzM=;
 b=QGBQiaE6kEOm4JOA0O6MVx7LnmskJyQHqJ/ExED9qVerFjRlNHtWrR5hIjzI0x8goUqykiQIJJAfA8K7CG3mnn+9/RwolCCRhFi4/rzF7Vc/cr0DDFEiJaZWcLzkIQ8Io6FRxih6K8swfiVgrBKYgsJwnVlVR2bcnSZ0T+OJelVbHbsLDtot2S6opsQSa7nCugUdPyASAc1Gjz2LRFEtr5PEHMwpwdKEkV+Vnbt+vTRsHbTP07HWJ06/eLa85C61bp+dUDSHL5thxyPBJIc0aMFoIX1KHpypTboXLZKjq9ABUxFQYc+dgQIdp8DBVksdM5BeppJGNo0nnuabTXpwKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8479.eurprd04.prod.outlook.com (2603:10a6:10:2c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 15:10:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Mon, 23 Jun 2025
 15:10:42 +0000
Date: Mon, 23 Jun 2025 11:10:30 -0400
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
Subject: Re: [PATCH v6 6/9] arm64: dts: freescale: move aliases from
 imx91_93_common.dtsi to board dts
Message-ID: <aFluZqo7BckrlhY2@lizhi-Precision-Tower-5810>
References: <20250623095732.2139853-1-joy.zou@nxp.com>
 <20250623095732.2139853-7-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623095732.2139853-7-joy.zou@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a03:505::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd1c65d-cd09-4b2b-c2b6-08ddb2681ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Ioj4KYv72RPI/KUJFXC51BeCkog4LwhM0s+E/3/+zG7EF4IXoV5UzOt721V?=
 =?us-ascii?Q?IyFyDEqsizZjKhaHJjXSwXsJsKA4Ng+pbZr4wnyre2fCvK2Cuci+K8ftX471?=
 =?us-ascii?Q?WePGuOZDPEu9qbbh0501oirDs/a4TZa7y8o2M0/pwCB9mFu41z4pfBIe/HSc?=
 =?us-ascii?Q?S7CLCPLfBnB1/A0sJOaQhaBgSedgAHBx3qFRTX8XRuYv+gIWO3qsMzVvZ9Mg?=
 =?us-ascii?Q?ypqFQ9eRpoYRogt/CAoB9rVdiEXi5IOIHXSTAnf6uF6hk4QBph4JEFEGpUhj?=
 =?us-ascii?Q?Ll6kz1IY2ELb4IdZsUbU3tHlXDtwZTAvRuqYhhjLFLHgFj+S9+j2TCNN2g/W?=
 =?us-ascii?Q?5xvmHqpXyGvHZnQv3gQOl1b0UOOLsN8N64EBiJCsgSsz+rPN5HZIOh0Yxwj4?=
 =?us-ascii?Q?eNimfwgN6lw0Ql/w7y5HdkRQ2tY0ul5PE2f9/HvCIpyFCkm6nyCA3E/uPjOw?=
 =?us-ascii?Q?9IxfZlK6CbpRLose/1nEA3H+PE7h2snYtXjXV9U81q9xIft3StL83d247CQu?=
 =?us-ascii?Q?l+cMWim+3ndZWAD9Oqhc9c77mI8Z710K0ByfMRgkOwq6Xg/i4yI/eZUUIX6Y?=
 =?us-ascii?Q?AOX3hReOE3U+1PaLgOaaYRi1zQaOUaYr3Hlq8prO9CMLQOw1zT2rHRWU6aJv?=
 =?us-ascii?Q?E0piym3/ry2X3thZ9dZPWnjXWR6fGjuHmYmtpszvYJ/9iVY7pAhasDJhYcjI?=
 =?us-ascii?Q?aJF2lSq+YgQvOcm0iOcrYVA5PlQsMAQoJvhweHTlBMREu/UO2bXC+xAfszGS?=
 =?us-ascii?Q?OQlvUTVEzcxqJ566BBLe47gPojAuGEnlOCjN7CEuPwmNgw7CDfkfudan1Px7?=
 =?us-ascii?Q?erMt/+WCyOR/UD97MHXdwauw1hFd8ta/KLzO2PiJjSA63+qegMGpFz90ViDf?=
 =?us-ascii?Q?ermHStBM7xN3FWlo3/n/Qd6P7QNlsxyQd6UjG9b5Rpt/tdSrSqHc8aCNitzy?=
 =?us-ascii?Q?VyxDqkKNvhzejz3t3Ad9o2so9XtugGR3Ij2GyNlMK5HnLBkbOMfNuMqzh0FN?=
 =?us-ascii?Q?X23Cj7+9uNaz5r9hCNNMkJQgnSxviCI5MEhkeyaTIN9gwBf2Ogx9Nwze/Tnx?=
 =?us-ascii?Q?kl33O5DCZp9Qa73qlEOEp5tzCO++crJI9V+bZk0moqei3nI3N++9JxNG2DdM?=
 =?us-ascii?Q?IQyPUZVovoloqoUuhMv/f4Utw+4m3tI/E1e69wbyFmysBno9V32MwdG4pU12?=
 =?us-ascii?Q?XY03TufL5B0g/CrtSGGpkLgnvEIhivwsC90NpvbdoocBBve1rmKm+oK2InmE?=
 =?us-ascii?Q?EHybvX9UVrY4oZGW6e0FbILr7rhxVLcTQfrIPzlr2CzYjcdyS7GgaCWt+5Pt?=
 =?us-ascii?Q?SKNpNIp7mWnemQWAbAHnLpItXeG84Z2rWwr72HNk5c2IDG9TY8A2XO9zixZu?=
 =?us-ascii?Q?SDUL8ofd0Kt2CkWic1pZDPmBy+pi5kg3Hmx6F77/lkprDrcB7NyFE+H2/mPF?=
 =?us-ascii?Q?3XMeXKkvdO49g1Kdd1mftKnCdvw4Kcam4gqabMeZgxMblKR6D8w1mGbD/+Rm?=
 =?us-ascii?Q?scEZUcKzsXI6U4E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ikZ8bjyTINqL2MQ2w7I8Et0kMZMk5KMwAEfkOl6ChPL0D+QvNOQybyMoXO6N?=
 =?us-ascii?Q?+SQzrO3OFBig/M6BOewZ+ryppYEAhWRLDaFaQZLqlbPIqy0KRfgHupRHus+b?=
 =?us-ascii?Q?5DZgKgWTnk4l4LcNLehzVwdhSdL40qE2t8rZijn3zQi0XY/xfvRpNb8aw7IJ?=
 =?us-ascii?Q?V0PFpkrUGtF723O55PCev0F5hTosO7oXseK1+NmdNg4EsDHT3LeKLpFLj3w6?=
 =?us-ascii?Q?Vw5DkldiyfEtYW7Ze7z4hw7yMqLqflcUpcW+DYBhP9zkOrB9DMc3E9iZrLSA?=
 =?us-ascii?Q?lFMCO+ijZFGARsbgNWLdsDFZcsjJQkxc4F8pKYO9LuMe2ATrVoJYx9+08EGO?=
 =?us-ascii?Q?QdO4s21dQbeCq7ZCctv8QXGEH26l9hzs5UGFtl6d2ISjSd/doJuFs7zgQcXa?=
 =?us-ascii?Q?A+g4XShiM85EMZZO41VvbCztW8QYbdgHzulxSEzhrg6SoOBPaphT65zN9QId?=
 =?us-ascii?Q?RlB9hghDTB9jURQ5p4Hwb10srEqxjkUUyvkfFLCwwg81qNo2q5vNtqWz1Fqd?=
 =?us-ascii?Q?/6D6LA/BueuCA9BieYpl5123b+cYn2aOk/KSMtJ6l1RDnIADduCYFyyT2k98?=
 =?us-ascii?Q?0JBqNFN91omcsFFv2k8ReSjKZE1OLmyuZonQgZP/zwvvul6kQ8V+KND5zNZY?=
 =?us-ascii?Q?79f7M/fgkKREbkxQ4QllhbZNSHULNH+KZLPjZpJYS7t2i0xCqa26Qz9OC6Gl?=
 =?us-ascii?Q?5lkJ6pkd9iXs9RipYvJabUTGpPFnn58rmI2Te6QjsJ1CfaFF51U9DBEoRcCN?=
 =?us-ascii?Q?IBSzaYtDin3flcKloU1/cBt/+YZuuVkQ5ripxjDGKHtzLBlZXeOpwZSFGJxF?=
 =?us-ascii?Q?+1gdVnmkEOvBG+D9Z+9N5plFQYGDICN+G3tK5bc55AFuWDU4jWQ+RK1Soy+T?=
 =?us-ascii?Q?YrGWlLaGtP31IjfKWyXDV7NOYZQ2TKpM5t5GV38Po2VcWAPieVzI1KYrikWe?=
 =?us-ascii?Q?zYZR+OjyPT45yKJC0ngI8gzjTDhq1M2V7wgPHAGPjxJ90263SyZ1pBTBg3WF?=
 =?us-ascii?Q?InyyDpamj5R50mNKJbvu4FfI4q5ynS2iw5h01akQIIg9EJFVS8plHCzlT5s9?=
 =?us-ascii?Q?DXighohKXak5QovDxba+8Yw14nwPA7q0wo+XzlN3p5t8pA3C2P8gL6Vzflfz?=
 =?us-ascii?Q?xwcF0kcyWcuhFMw9xk3BNJeqt0zEaoDlBIGJ423Qbb3BN+oPKzJjb1pIZMPK?=
 =?us-ascii?Q?fdp4wWMWUaFapGEppU2l+t3LvzS6n7TcqMj3r1NGL4BR8ASf2RAuW2wU7Jlv?=
 =?us-ascii?Q?rK6xrdUv2OOR6ZgZiMlVjE4hH16ESrAVlDuZkHgkKUQZiJXs+s3efwKECdjO?=
 =?us-ascii?Q?aITvRGb7SMWaQ3YZN1dXZLCwS4S0uU8yCdNlfqHjDH+DY5lBUK0x0hlY7PhO?=
 =?us-ascii?Q?Oii56OSuGnKDEdMRB55qssCMsiu1ZYD2O1ZbPmAHy0I9JpTT5a4BU5Vo77zx?=
 =?us-ascii?Q?mMV/hrQYlzbLomtILVp020dH8z/HvSQRGuw0/o1DIqCHA3I5tsxmcA/kftPq?=
 =?us-ascii?Q?LOtq08pTpKR8ExIZgj8ZDGcwozrEu1qN3WHakHYHx3bEkTOq1HBEyOENnvT6?=
 =?us-ascii?Q?Xw67Fga8lj9U9XVfdM4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd1c65d-cd09-4b2b-c2b6-08ddb2681ea2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:10:41.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP4EuxHzZdK4uB7u/cGiRF4Be5jcYG0yxx9QkaMIdMj3o14efH5xZ8fOn2PZz1VQgyaPaXqmXP8YEcs+RQXjmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8479

On Mon, Jun 23, 2025 at 05:57:29PM +0800, Joy Zou wrote:
> These aliases aren't common and need to drop in imx91_93_common.dtsi.
> The part aliases are moved from imx91_93_common.dtsi to imx91-11x11-evk.dts
> and imx93-11x11-evk.dts for the convenience of customers.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes in v6:
> 1. add new modification for aliases change.
> ---
>  .../boot/dts/freescale/imx91-11x11-evk.dts    | 13 +++++++
>  .../boot/dts/freescale/imx91_93_common.dtsi   | 34 -------------------
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 19 +++++++++++

There are 10 imx93 boards at upstream kernel.

Krzysztof Kozlowski:

	In https://lore.kernel.org/imx/4e8f2426-92a1-4c7e-b860-0e10e8dd886c@kernel.org/
You provide comments about "no common aliases".

	Consider there are 10 imx93 boards. Do you think it is worth to
move it to 10 boards' dts file?

Frank

>  3 files changed, 32 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> index 0acd97ed14da..52b3f57ba347 100644
> --- a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> @@ -15,7 +15,20 @@ / {
>  	aliases {
>  		ethernet0 = &fec;
>  		ethernet1 = &eqos;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
>  		rtc0 = &bbnsm_rtc;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart3;
> +		serial3 = &lpuart4;
> +		serial4 = &lpuart5;
>  	};
>
>  	chosen {
> diff --git a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> index 2a2ed0266c1e..7c8c68151b14 100644
> --- a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> @@ -18,40 +18,6 @@ / {
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>
> -	aliases {
> -		gpio0 = &gpio1;
> -		gpio1 = &gpio2;
> -		gpio2 = &gpio3;
> -		gpio3 = &gpio4;
> -		i2c0 = &lpi2c1;
> -		i2c1 = &lpi2c2;
> -		i2c2 = &lpi2c3;
> -		i2c3 = &lpi2c4;
> -		i2c4 = &lpi2c5;
> -		i2c5 = &lpi2c6;
> -		i2c6 = &lpi2c7;
> -		i2c7 = &lpi2c8;
> -		mmc0 = &usdhc1;
> -		mmc1 = &usdhc2;
> -		mmc2 = &usdhc3;
> -		serial0 = &lpuart1;
> -		serial1 = &lpuart2;
> -		serial2 = &lpuart3;
> -		serial3 = &lpuart4;
> -		serial4 = &lpuart5;
> -		serial5 = &lpuart6;
> -		serial6 = &lpuart7;
> -		serial7 = &lpuart8;
> -		spi0 = &lpspi1;
> -		spi1 = &lpspi2;
> -		spi2 = &lpspi3;
> -		spi3 = &lpspi4;
> -		spi4 = &lpspi5;
> -		spi5 = &lpspi6;
> -		spi6 = &lpspi7;
> -		spi7 = &lpspi8;
> -	};
> -
>  	cpus: cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index 8491eb53120e..674b2be900e6 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -12,6 +12,25 @@ / {
>  	model = "NXP i.MX93 11X11 EVK board";
>  	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
>
> +	aliases {
> +		ethernet0 = &fec;
> +		ethernet1 = &eqos;
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		i2c0 = &lpi2c1;
> +		i2c1 = &lpi2c2;
> +		i2c2 = &lpi2c3;
> +		mmc0 = &usdhc1;
> +		mmc1 = &usdhc2;
> +		rtc0 = &bbnsm_rtc;
> +		serial0 = &lpuart1;
> +		serial1 = &lpuart2;
> +		serial2 = &lpuart3;
> +		serial3 = &lpuart4;
> +		serial4 = &lpuart5;
> +	};
> +
>  	chosen {
>  		stdout-path = &lpuart1;
>  	};
> --
> 2.37.1
>

