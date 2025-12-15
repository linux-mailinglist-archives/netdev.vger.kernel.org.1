Return-Path: <netdev+bounces-244794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 647E7CBECA6
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0BE53000968
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6BB30B533;
	Mon, 15 Dec 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RmXEVmpL"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B86284B2F;
	Mon, 15 Dec 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765814231; cv=fail; b=FuBAhNOrfJ+JXEqMoTFiTJCO8LlmO7C7y8MFqa+E4B7z1qx08cRUkt3meob5xP5HBYqYD7AMsJOhn1ZQByh/lGDJpFvP4VbsBJGflePpBaZ2dqzcnlBVoiQ6LLsO7jDEcbV1AfdStzbD/sillNQ8W49EkmWmv4/UIzVN3r9i9uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765814231; c=relaxed/simple;
	bh=PMrAWQt9pldgvdXXP02YfvFJEST9nnxWjGOt5l+GpkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mMLCME7irWHk9Xcd1cNiq2edwqe+eL2KdXV+ASuRXR8zKFt1BBxbmFTPXhymyzA1A2Xm0DG8EVmtVRMqYl2e2F7dQyi4qriddMOr8hDBI/WqhPX/s6TT8s1xUYXbcM9FDY4ifOjwJxXV6M5KvDbCuXzQ0jgn8ybCG9+97Q+in+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RmXEVmpL; arc=fail smtp.client-ip=40.107.159.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk1d36ufB+tsRidUIuCY5ptA1UMFAGNaL9SbtRm2D9FUjM72alQ7Oo4me9JJGlM8ykZq7HKtS07KQ7i2pOZkK5MoGtlvHxh0h1ZzPNcOtccqczerR4vohHYVcldV/2a+PSdc7JW160H1oMq0pcYb4LTLCkzBBKXLoC8PThNsamZj9OU468i/abFxPfHddTWA3VfUaamLPf/1IKx7yf1m9LNCQCtn689x7OzIOdutroUbdQdsNbBwFvtSIa8oLhCB+gb0Qm1pvLN9YhpTBA73w7E8PMaTD8ng8x1UM1IW+5gXUzjLhgQJT1tQwYPyLo6qFn1j6DXZECkfpUZTUOyrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C09fmyMEduK1iyPZFMGELqRX5X/nS9NPR5cuFoMTXWo=;
 b=Lxap3lVvGiajEYq/7aHRmWjTgojdsYkHWWiIDVpYk4pX/toqF4IMBPD7i7ZuaBuZR+nlxkUOq6WDdT4Mgf3tyRLYjWv8FlwNgffRfdCW79YT5ssY++cvJJMfNkZwH8LCmktSlIkj87zVTWdavW0tpkd4HV5oVqFesvEj3CJJOn8Ttow3MSehGzVwDkndbp01UJUf34vi/rbGvQRIxZ0375e2U/3X/oX+f/hL+DCYVFxRnX2g87OFsixekyiASwWxDTfHktYAOqoB7FLxH3A4xvpeulMZoXf+ZjHPUOj35UJwLIUwkAVmIzAqev/jy8QXa5dZeSO5qTyNv3giF1yPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C09fmyMEduK1iyPZFMGELqRX5X/nS9NPR5cuFoMTXWo=;
 b=RmXEVmpLNAg703ipnQj8iWARjO1NwS5kIMnadTJ5YB5rPJ5UkrkMFT4icnSJUMaWQBMv+ftDcMoBnad9QFhEd8JUsgD1fG54OYiT+o6a5ADlyEm+DqKd3z5Ite841DeIwqHc+gbnO2BPnvgcE6YAXRJYVEdwh21wSDBq5GR8BfN1sW7t77mcjNDLCu/pCwns06NnKe3FQX04Q6Pe3fS4zGKpUHEzxRYofU6vo77DHomr2+zVNZZp27F4O0i8yIfP18S1hMwlpIYWPHWn1HoKJOEuM2X4mu4OJNIMLLQ2Gr9ibmBk0t3S1Q6BMeqMJJteNnmcUIX1TXiPvBXX9pEKQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI2PR04MB10859.eurprd04.prod.outlook.com (2603:10a6:800:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 15:56:58 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 15:56:58 +0000
Date: Mon, 15 Dec 2025 10:56:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chester Lin <chester62515@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <mbrugger@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, linaro-s32@linaro.org
Subject: Re: [PATCH v2 0/4] s32g: Use a syscon for GPR
Message-ID: <aUAvwRmIZBC0W6ql@lizhi-Precision-Tower-5810>
References: <cover.1765806521.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765806521.git.dan.carpenter@linaro.org>
X-ClientProxiedBy: PH7P221CA0075.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::26) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI2PR04MB10859:EE_
X-MS-Office365-Filtering-Correlation-Id: c323dff8-e811-4b9c-1319-08de3bf29419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vl0A1vSvJ+1R8pv++pkg9dS1ZpQTMJMvWEqcoZDU935nesgw3Z41gAEN51gG?=
 =?us-ascii?Q?aay91xvSQwsRpHEGUrrNAYnxNvoWTTEE9Ty3xzoHNaX/nM/MZ5/aD8zooZWc?=
 =?us-ascii?Q?2DVeIEblFfIoBHpD9gIu30b3YIU7MDp5yONNXHZEk5Vadojfkjldkuo4vj79?=
 =?us-ascii?Q?RbnbI5dBztPdEfZj7iNrm6z7Kjr1Hdh0yz6KrxoT8zRwKdEZEqAIIZRDVoXL?=
 =?us-ascii?Q?KCvEm06PvnFPfXGftaD3lKiWxw5sdps8lJRaazh/eA/5e7WIc5d2DiMhtH8A?=
 =?us-ascii?Q?XqXw5UwXLk6muoAOHk830lxEzBVZ0ez7yUr9GT6q/n4zJ/JkXDTEkZ7jB9RI?=
 =?us-ascii?Q?YsTAI5hi0z+pkyQFSsu0ZT7mDrCFToyFynpGKHSgGnedEdAVDJSGNNj6HoTv?=
 =?us-ascii?Q?PXZlB8uyXdPm2GmUGA7Cum2QaeEXuZIC0AHbhZCkHcpLcA3+jkhFNsPzVsfc?=
 =?us-ascii?Q?wtUtaOuWZCKLu+MaqTF0auF77Ush9KdBxJg/ne/s3ZAMtodbd55me8zSlJPE?=
 =?us-ascii?Q?y9g01C4jRMTZuuYefHkWCZtnbse3OEVP4P3aeZOhBIKvxhDWGawi2tuCfIt9?=
 =?us-ascii?Q?1FWNuS0JinAKnJc4Kwzrt+CT0J9zvL3OfIGXXm7Le2i4LR7lY2uizy1AnQyx?=
 =?us-ascii?Q?eVKfge6wWi61gC3zGARNwIIzsugTn2jyg5F7HQU828/FdH8EZYCiCmQjyDRl?=
 =?us-ascii?Q?Os2AGYS7d95urDLVHBg07XlpbWlp89BpW2551sZQOaI3y880ae7xCUQrAv9t?=
 =?us-ascii?Q?8cnweRowiDjP+IbUDNzCM1ofye8J1CfJomZye+bZYp9Qamlh+zO7pdtbPT8Z?=
 =?us-ascii?Q?0JavpQpi3CgpEerty3Ds6dsS24Ums6+VWomq70qd33BPi2UYdjHZcddX1HgD?=
 =?us-ascii?Q?RHK0l0nTY27qYdcX8bFNL7AG+O671mA6OZlDgYwAZIWM5S2e0aDB+FjtQ0aJ?=
 =?us-ascii?Q?wyYLihk7YXvbBsLOdBRY5XlefOcym5Mh6btvhEzaWtA6Xcm7oOxlmG6yNags?=
 =?us-ascii?Q?lP0lOmrcCvnMIt9Av6AqywZdpE/2BNUkoWTdSB00j8oUSxpknszmongLqyDQ?=
 =?us-ascii?Q?kpCv+iO2jAbWyfmLJHLlp9DoBiPOHwGDI84AxhaVARopP+6d1fqsIW8f/Qhb?=
 =?us-ascii?Q?58baAd7fa9Sx/+9B9EJiK6PLgGdGlx/oFgM+H/3pH66OCaxvo9kxim1CWlDo?=
 =?us-ascii?Q?ACefF7/82OW7E5q+vf9A49PwH9TOV5q1p4g/cUxLAzH8ZJHgIzjIZ0mjwoxF?=
 =?us-ascii?Q?szU6YO607oXLSQiZjwZC/AEfoNlRliUMxwdqh+mNwQz+BMLENBZM3e6Pq921?=
 =?us-ascii?Q?oy1y7MXjpQe7QGfMTUqG2cnEgLEbxen+pPlQY0tvw+CZTX5GnEmyTI3eV11L?=
 =?us-ascii?Q?EshWWNCDms3+MUa+I4z1SnF2Ksqx/GHAOOnkF6MgGHiRAjH/xLmSR30fpM1C?=
 =?us-ascii?Q?Pwn97ClNLTadVV9TnvMol/G1M3BPgal56IgP5QsLuWfQL28PrGywCQ6Khk2S?=
 =?us-ascii?Q?p6EpmsD0DIMDK/d1fOq4bIZC77LpWhc28v2j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jDKOrYFzViGVmo09s7A3kR9qtXW8u5/gs1mExuKEhJLlefSnrb9e7SpOpPPw?=
 =?us-ascii?Q?EM0lIldHuZfPiBW/X9CLraMk3G/olK6iY7wUewHt9s6wBM50m86NzfPemSgu?=
 =?us-ascii?Q?bXz2cOLG3JlqbfZS7NbPTQZs0pyAZe06XCzCeGmLMRbD+WxLPKZ6JUoFntiS?=
 =?us-ascii?Q?rhAeLewIFE6pyVMiWNbrj3GUjqdetsqb6/EAxEcfbENnMGzG8pcAhgzt0pnx?=
 =?us-ascii?Q?KzTXSYnsrLQM/JRsCVHf7OnQ3r1FqkfnD4+DqXjiXzFXlwrvW4QFNjbXMSoE?=
 =?us-ascii?Q?cKgqpoDuI6CWblULc3s9NQzlTkVeqXk0ipPRtG5YmGUZ+kybcR6UlF3QDIx/?=
 =?us-ascii?Q?U7amLrBZwE+jgaprnQx+vYsjTKXTbfiQH9FwNVzJFaNL0gPMCNnzwSNjYktu?=
 =?us-ascii?Q?QV0GeGo7U5D63l2sMI4b86VyNnGHL+E4DoxPjRWpQrICC4njqaKDGSo8Cftp?=
 =?us-ascii?Q?yFXjUZWyA91+WCneCOZ6zz054U9AyZjSeJCioRFN+4QlIlsWs378JQ6513HT?=
 =?us-ascii?Q?/5uShcKLao662HeTeNUkXQVQZ3ZCzaGP1zkQwh2VszuM09QESROav+HdJlpe?=
 =?us-ascii?Q?2BN6QJLnZb6gAxGCL4g4QYxQPaBMd7dFtlTgn0dU5ZSbkfVf5SqxxDCsgVEd?=
 =?us-ascii?Q?lZTfjNCLSaExIX/rVJAVRHVHZeUkohrQhg69XlEgyMYQH//9XBaQoOKudWCD?=
 =?us-ascii?Q?jbO15qXGCD/BDOdg7sQw3wH+r76SIachxc8V4BdjyIZTJMccjJcE6QfwrRqN?=
 =?us-ascii?Q?O4nWrLTawB0DUwRdQdsCtpQWyNXRDh3yKV3LcL4kHs0Wa0a03zRtk32qozFr?=
 =?us-ascii?Q?dGlZtSv+cNLf6F/4f9Cn3cCab0EsJBAQLAxr514TBiYizprPUXBozdxM5SRD?=
 =?us-ascii?Q?xYfG+TjxDwVHP0EragP2QV/dEThUio/3DPB0/LxoAACPmce3Knb5ssimkIfX?=
 =?us-ascii?Q?SCzoTPSvM+O0bipDnNZ5nps5a3caIPYIaY6j0zsQPnrUOoBgxD/fv1EKL5Fo?=
 =?us-ascii?Q?MnYq8rSPg41zRIZMieengjBsWIPTsVLvzt0y0M18NYLr+cJCDmL3qtU6TqGC?=
 =?us-ascii?Q?lEfnPKMTG5HtKlxqwfFyUKBWHYdvEMT9ZUkYjoT0FIKF7kOaov2hlSTi0Sow?=
 =?us-ascii?Q?MPbc/eIbJK2raIm222wnUJoUXBUY7CIA8QTULeaAZ6e8ezuH1qlapUcNtLx6?=
 =?us-ascii?Q?HbFu+E5YE2dJqhBqdsMHEIbHYFUs3rrtu8oDiORK36UdAZehFjHKXtvb8cFA?=
 =?us-ascii?Q?Ax/Xp4Yteho8rTTedAcfLAZGDu9OobhI5csiwnjPRhps4DUpDAQb5yYUdXVF?=
 =?us-ascii?Q?UtMB9lAmovu6tm2dJC8KVtVxCEul/D68zzXMnVWKR/+cYpsfxzW4ikAdGtJn?=
 =?us-ascii?Q?vjaBzHdngls3N08AbqJHM62ulmCgmWvBiuxcp9ziI1PqV1ijk/IX5WmoQB8F?=
 =?us-ascii?Q?f06EzJERPe5mxVcBB/L73UuqAfVUR8UDW65q1EOfqtnMfdcnkNcZjUoM4PiB?=
 =?us-ascii?Q?le1hCA1mnBH5xUdgj84LZEFkG07+vcSWq2jfF01JLEIIEDaSgFO/qjTStO1a?=
 =?us-ascii?Q?aFmkJcQTaq7elYzexAE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c323dff8-e811-4b9c-1319-08de3bf29419
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 15:56:58.7370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHFcZ8Ahw1aJ/PMdezcITfUSh2fWJJzZ5C1MzYRCH67Q6mHb5wGvTKZLlB+Jdi2ujt4Dl4LgqsKsGjzlIRq90w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10859

On Mon, Dec 15, 2025 at 05:41:43PM +0300, Dan Carpenter wrote:
> The s32g devices have a GPR register region which holds a number of
> miscellaneous registers.  Currently only the stmmac/dwmac-s32.c uses
> anything from there and we just add a line to the device tree to
> access that GMAC_0_CTRL_STS register:
>
>                         reg = <0x4033c000 0x2000>, /* gmac IP */
>                               <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
>
> We still have to maintain backwards compatibility to this format,
> of course, but it would be better to access these through a syscon.
> First of all, putting all the registers together is more organized
> and shows how the hardware actually is implemented.  Secondly, in
> some versions of this chipset those registers can only be accessed
> via SCMI, if the registers aren't grouped together each driver will
> have to create a whole lot of if then statements to access it via
> IOMEM or via SCMI,

Does SCMI work as regmap? syscon look likes simple, but missed abstract
in overall.

You still use regmap by use MMIO. /* GMAC_0_CTRL_STS */

regmap = devm_regmap_init_mmio(dev, sts_offset, &regmap_config);

So all code can use regmap function without if-then statements if SCMI work
as regmap.

Frank


>where if we use a syscon interface we can write
> a driver to handle that quite transparently without modifying each
> individual driver which reads or writes to one of these registers.
> That code is out of tree for now, but eventually we'll want to
> support this.
>
> Changed since v1:
> * Add imx@lists.linux.dev to the CC list.
> * Fix forward porting bug.  s/PHY_INTF_SEL_RGMII/S32_PHY_INTF_SEL_RGMII/
> * Use the correct SoC names nxp,s32g2-gpr and nxp,s32g3-gpr instead of
>   nxp,s32g-gpr which is the SoC family.
> * Fix the phandle name by adding the vendor prefix
> * Fix the documentation for the phandle
> * Remove #address-cells and #size-cells from the syscon block
>
> Here is the whole list of registers in the GPR region
>
> Starting from 0x4007C000
>
> 0  Software-Triggered Faults (SW_NCF)
> 4  GMAC Control (GMAC_0_CTRL_STS)
> 28 CMU Status 1 (CMU_STATUS_REG1)
> 2C CMUs Status 2 (CMU_STATUS_REG2)
> 30 FCCU EOUT Override Clear (FCCU_EOUT_OVERRIDE_CLEAR_REG)
> 38 SRC POR Control (SRC_POR_CTRL_REG)
> 54 GPR21 (GPR21)
> 5C GPR23 (GPR23)
> 60 GPR24 Register (GPR24)
> CC Debug Control (DEBUG_CONTROL)
> F0 Timestamp Control (TIMESTAMP_CONTROL_REGISTER)
> F4 FlexRay OS Tick Input Select (FLEXRAY_OS_TICK_INPUT_SELECT_REG)
> FC GPR63 Register (GPR63)
>
> Starting from 0x4007CA00
>
> 0  Coherency Enable for PFE Ports (PFE_COH_EN)
> 4  PFE EMAC Interface Mode (PFE_EMACX_INTF_SEL)
> 20 PFE EMACX Power Control (PFE_PWR_CTRL)
> 28 Error Injection on Cortex-M7 AHB and AXI Pipe (CM7_TCM_AHB_SLICE)
> 2C Error Injection AHBP Gasket Cortex-M7 (ERROR_INJECTION_AHBP_GASKET_CM7)
> 40 LLCE Subsystem Status (LLCE_STAT)
> 44 LLCE Power Control (LLCE_CTRL)
> 48 DDR Urgent Control (DDR_URGENT_CTRL)
> 4C FTM Global Load Control (FLXTIM_CTRL)
> 50 FTM LDOK Status (FLXTIM_STAT)
> 54 Top CMU Status (CMU_STAT)
> 58 Accelerator NoC No Pending Trans Status (NOC_NOPEND_TRANS)
> 90 SerDes RD/WD Toggle Control (PCIE_TOGGLE)
> 94 SerDes Toggle Done Status (PCIE_TOGGLEDONE_STAT)
> E0 Generic Control 0 (GENCTRL0)
> E4 Generic Control 1 (GENCTRL1)
> F0 Generic Status 0 (GENSTAT0)
> FC Cortex-M7 AXI Parity Error and AHBP Gasket Error Alarm (CM7_AXI_AHBP_GASKET_ERROR_ALARM)
>
> Starting from 4007C800
>
> 4  GPR01 Register (GPR01)
> 30 GPR12 Register (GPR12)
> 58 GPR22 Register (GPR22)
> 70 GPR28 Register (GPR28)
> 74 GPR29 Register (GPR29)
>
> Starting from 4007CB00
>
> 4 WKUP Pad Pullup/Pulldown Select (WKUP_PUS)
>
> Dan Carpenter (4):
>   net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII
>   dt-bindings: mfd: syscon: Document the GPR syscon for the NXP S32 SoCs
>   dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
>   dts: s32g: Add GPR syscon region
>
>  .../devicetree/bindings/mfd/syscon.yaml       |  4 ++++
>  .../bindings/net/nxp,s32-dwmac.yaml           | 10 ++++++++
>  arch/arm64/boot/dts/freescale/s32g2.dtsi      |  6 +++++
>  arch/arm64/boot/dts/freescale/s32g3.dtsi      |  6 +++++
>  .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 23 +++++++++++++++----
>  5 files changed, 44 insertions(+), 5 deletions(-)
>
> --
> 2.51.0
>

