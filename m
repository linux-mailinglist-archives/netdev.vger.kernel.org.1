Return-Path: <netdev+bounces-207587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA16BB07F48
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4024A6B2B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA10290BB4;
	Wed, 16 Jul 2025 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y+uY3W5S"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB028B3EF;
	Wed, 16 Jul 2025 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752699858; cv=fail; b=NM8XHgSWeYZi+kpgIb4pFRHgsL31lR+GqEbnMd/q1z8AfMciSd4tTrK+tfDDnWUSgNSp/BBFPlW47Wk/zsg0YJ9zhQh3vgA4+mi8uG7R36S26/nXK5cP8/2mIGTstnlpfMEVgCEKoy8lLbCZiHwWoBA58Fq+B8osKHVs2PtuZFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752699858; c=relaxed/simple;
	bh=MK6I2gkHoyd6uXvp9UcqMHnHy3ky1UIeoaZwy85RtlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TrH+bsAcN/txYtd3gsWsDSfOsW9hpaA+F049HC0UGdG8Dv7qKx/avQsyfyAWy/bh17dUCs1G9O0la7vf1Xs1AARqbOm7vpuCEDTPuTrBPdsny5Hnsb0IJwCtUdhjEdBKsbbco+9NAzkrrijUdNrEhOHdNyhoiJHDo1quqtZ53R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y+uY3W5S; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugZaxaJQ/WOQgRIUE+wy0aKyxt6FIvs0s3j/1znxQtL/Wk0qpGJzdv3mzpO8qmt2nQ6fc/bxlHbpPaTmczNFFxYj9Tk7pOWOiZ3HRQirAwNCCFU4ZEBkmFkf5JI+oHV6sjG7snwIQIFDqlQ/sMU/zssJuh7S6itugVY6uR4PTWux9VKG/IkkNNT00+LJH3RmtCdyV8AjO16Koy1FIqEkMivSQgqHg7taFPSUrtUPMQoYZqS3kDhQB9VJ/rE+k5/tj9H+0uKfLuD6CtLXmuN+BF3PZBcxpS7y589miS7Ro7LysUJPqTXd5czzjqfP/ZuEDnABvDEruqw/nfp5axxldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve1fzMI/2rYhl3gKupKTIrrYEmtniOtLYvrCXFi9MrM=;
 b=joqv4JwQl7ABwusFfE4hecn3wC7lKmsd1fgQpnPRdIUF/c9x1HHF6em0pznEyvEMJiktBlr5HUe0bHDB0Zk8WaGv47DI8nGuCBOZkzieq/gOA6jqXNzQrTpqIKKTlPSb6rB1j679dSVFIfnfuKgEMjCYXOb4QuycO7Ct7ZW1BdtHLConK2W17Lt11H2gW3HeXdrhDSVpYYBk4MH1lkXvWVus3vqlIxXpDZpcC6vvus0f445pSuAPXH+usKVGpgopyMjb53MaQkidWs8SZTsocKUCpWhYjkz5KublAsNImmrV4N8RXb+RKMCFG8V85V8dokwu66nV3TK9R+p0Op1JVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve1fzMI/2rYhl3gKupKTIrrYEmtniOtLYvrCXFi9MrM=;
 b=Y+uY3W5SqfP28AoSncApajoJawOHF780uVijOwt2kGOmYABlxoN9PJiitUx8u8kBQwixZCEfrUsABbCfPUeD3NswuDvd/pveZSgl5K1WeWlYlzrcoKdk4ItFoREodXeJiOsgKrMq+eih/i7o2jOWCG3BiNO2I5jn/4+QrqUSTVOcqXas00Se1iKSn5KLtqBtP6s0MKtK0X+6sUTrGjmvzXPpXfcgSjrH7TUGwETrBgfd1YQwISxR/Q1Oh6DWC4k9MPfPc1SuL64oX4qKVa5qFmDyAA0R8G7B/myYLdyFXpbGRq3WQiXw57ydxP8SD10pRRj8pQ5CKZ5H4DrYkDgi4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7040.eurprd04.prod.outlook.com (2603:10a6:800:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 21:04:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 21:04:13 +0000
Date: Wed, 16 Jul 2025 17:04:07 -0400
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
Subject: Re: [PATCH v2 14/14] arm64: dts: imx95: Add NETC Timer support
Message-ID: <aHgTx8g+XpNZGd2b@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-15-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-15-wei.fang@nxp.com>
X-ClientProxiedBy: AS4P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b638b7-d28b-4f8b-f065-08ddc4ac5140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/r0GkRWA5lcruuQv2z6rSlJLUaeQS4xAnB/XpHYxTlGn0R8SbLEenuBazZBz?=
 =?us-ascii?Q?keRKHBc5WhxWvQ2DYqdZ87mA9x++kPi2ysvOc2tT8YpkGWFIrOnXbjIkXOPW?=
 =?us-ascii?Q?ADleYhw4JiSlUSXXAJyZROf9wAnWyfxgVJLHjqjm4dlgJX5KJN28WhfYj3im?=
 =?us-ascii?Q?rN8CXdU7YlGJlebGqJVB+IDIQ/ucrCNS8Fea9pfO5YG2uRt/v30O+V38ZcEr?=
 =?us-ascii?Q?THPTslrlOFmR+Hy2wL3mz9Oao2ZhWlIqG5rWFpp/BCPaSaF4qjDDy4pdhboy?=
 =?us-ascii?Q?27qp/6yMW9AWJE6U7DpkrtlAlnhfgXMrzjMMNAM+dfb2RPxUpLtC7spx2j3Q?=
 =?us-ascii?Q?tAnmez+843N/MnOqu0v5IBKJ59ctiWtYKJUqDj3iUhVXTbiswHUcCyEckjGk?=
 =?us-ascii?Q?7fFm5YKoP4sDxGkxWsPn/XzXQhtkwneiB8tQAFUF8t8yL8tulZHb5hNriVen?=
 =?us-ascii?Q?j4MTa1SPgWrBbALpxM5WPFciFUKtN8GXnrHpoJbrD7P6ESRDZaZz6JIbdh2p?=
 =?us-ascii?Q?7ROORFESTO/ItjWPvGEQ+mwGNgSOoT8XMY/mkEUIFInLYV/4TTr0ImY2nSWQ?=
 =?us-ascii?Q?Glf/MqE4pp/Abb4gADbf7fmitUX5m0FbDPySa122JJclc76eAfIBZ9R34X3i?=
 =?us-ascii?Q?z4suVKX6L6Fs3P/83pYYls9DED1j8BViVWkCOxCGOA9x2boDpOnrS6t2tjZl?=
 =?us-ascii?Q?iHuZQYhD4xTQOpkZyeptoXmQSXd4zvWhnFmJmbJ1v8YsBdPF6a5Ke+hI+khn?=
 =?us-ascii?Q?QkIHxUAZil0UhO28OlhUcxrx00NTU3jrasRjMGb7R4BJ2g25JvthrAyeoEa5?=
 =?us-ascii?Q?PmPMIbR6nbimKrdMfYOIlHm+tqFNpS6hypTmtcNRmr3HhShdO9N109k6x8jb?=
 =?us-ascii?Q?CkugQTSHCNzy5TnCYTbqEJE4k+3wyuvZKMMZo179bKtpxzSjZXcOqdh1/BJ4?=
 =?us-ascii?Q?hJGzh6hbMbJ9iNn9NSY1/MR7goXNDiRvra4/6XP1G3EGcfvMzuicEskEPogh?=
 =?us-ascii?Q?HbHuSuR+nlQPjk8Pphi4KW4i6iaA1+zABYwGL2tFAEcUL+gHrLHzZPBIefO3?=
 =?us-ascii?Q?s5CEFv3eL8Ekowz7KoDVL0Xi7CHfJ1xQzuY1Z7WJf8UzvFlYhIb4y8payakG?=
 =?us-ascii?Q?BbM4BepPDsn1octUCNrGolhudEam7IRVS7g9RiNGS0z80WKCF9n164cClibG?=
 =?us-ascii?Q?92SxKU49A+bD1LI27Ghy4ppKM22Ei2Ep60SxRh9G0fjdYZH8gd40VFZA5qTD?=
 =?us-ascii?Q?8LnR2FuDXYj4QrPeU0AkhfiBBEpT8gfELPWguOtvMzIUMQ/ct1iSftzyGery?=
 =?us-ascii?Q?kM67dE7yp/jalJ6k7J+nbawf8MxxvHSFQsmnUxrDUSZHLPe6fHXQ14KT41t2?=
 =?us-ascii?Q?dQvEtvO+3Ta4QZrhkne+uFTp1Fgy+Ro1bBe9ubbH9aienbidQX1tmseCR4uO?=
 =?us-ascii?Q?thlFnUIsOCRx1vXUrCwAFgpkDskXnn+ew0hvhhkDk4DUqCx35hGzjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qLNYS9mdlnXXufsB2FV1JjN6oTfVYl20YMDGTowHn8Av6txvoBHweaBO4uyH?=
 =?us-ascii?Q?vuVat/BbYUDoZY0q1fO530FkRChmK5gebzsrC1EnikaHlDqTrTB5ssuwd1IQ?=
 =?us-ascii?Q?vb7pWjU2qmYBRafzi+ZKSuPZ/xldIbCqlwQqFWUJbKXQeGuTjOsok6XsaeSz?=
 =?us-ascii?Q?GAYoWpAUNC6Ks0IvyRCE3DqU1aiXGCjBbwQSviyyO3vO0S1otVRZDp+HS7ft?=
 =?us-ascii?Q?OaHoxoIlQxz1TE7tfX6n4AMBEmpdIVgA4la5HYUFv4gC3UODKx3nRZkzxq1x?=
 =?us-ascii?Q?NW/HxErCGTcjZ+mynLhbiQASKcVYuoz6mfbjjF+oXRpJFU//QqNg5wpTL94k?=
 =?us-ascii?Q?6DkUB03nadW/+0ChEPUjdg6Zy2qHSkZuoHbm0TnxGOJmbLZl+uTsM9ImdnQ6?=
 =?us-ascii?Q?jUIuc43IQ4dPTzkxq/jjYSoaxq26fjUaXEFq8rWIGmXld9m2YSP68/CSbq/M?=
 =?us-ascii?Q?GoPonw9fhoclq8Cex/oRxqzQDOFjH+EOkefTevhxBf7jtVk3mMWj5dmIq19e?=
 =?us-ascii?Q?SmymbF6bo2zfby1Hhl1JJ/10B0jPlKVX4xd37uP2DfzGJOZowUl3RuJq2noq?=
 =?us-ascii?Q?weUCEI14j9ENWBiiztH2rdTKLQvD+MxXLIJ/9kivNpXBXRcUwQonXtG2aFzZ?=
 =?us-ascii?Q?8D8Ngos2db1/nhcu3YBV9WTo7u+hTyuYkFM66bTnJPgt7dsfo82BavVBP7/A?=
 =?us-ascii?Q?K18i/A/Lc5wXBze9gNRtKcd9chWz5t/u7hf5PcHI4olUzVl6+4a+O/rnX/pp?=
 =?us-ascii?Q?GEJT5WE3RD2cI92i2v/JXqvHq57taabaHuSae76fZqiNula51aoA5VamYeTB?=
 =?us-ascii?Q?gX7fzKPtzAvApre6jQTZmxUB6tIp9AONlvni3iUTuFyIVE9SGiwz90j2Avq7?=
 =?us-ascii?Q?TRtkLw/o8Cxvt7HgHIL4SLGUZZmnTOWNkKWn72LIgrXamRoWPeeLuySCqbYF?=
 =?us-ascii?Q?j51sfkAG2Z0VllPHyQbVS0062aajPvry9IMJEeUS2d5HGJ0fO7ogpsv2xjb3?=
 =?us-ascii?Q?XJJzJqMgxFuNUQTVFa87kV9Cv++JqZB7rwiKV0Rl/wV8kxlpUp6GlesC7SJn?=
 =?us-ascii?Q?h//2xK64D8rMpte5bsOPDrfH5HkmTPJW2ie1ZNbeNGNSpCNQDKApke5F1lkI?=
 =?us-ascii?Q?INA8DGB3n7kpLWcx/ojPoYM7gIaK3gQwKY7nwnqzcjgdtD4+l9RQt9nsFpT0?=
 =?us-ascii?Q?kHxy4wSqJ7BI1je3lpkQZGYnKyIfyhoORu8B154x0EtBf0pGEulb72pbov20?=
 =?us-ascii?Q?ncVoVP6rd9yhy9i4HLtzHt4kPWIiBbyHuZ25jk1K4V32YG50SCvPUAZAQDRa?=
 =?us-ascii?Q?Y+KuhkcY3JKqEX9tfxSJpyPMJrhd97dcWplm59ZQsZVxj2jDpVHslP1dS3y6?=
 =?us-ascii?Q?jBSIrCqKTtWdqGcYMMKG9eLTU8cuLI4jDg+D0iuwI0jpxWlhbW+nQVFS9PgC?=
 =?us-ascii?Q?Dejxgh7xBMaSo4p/zYCty78kqPucn8FfDbznRC6l2ipDu3kejKnzuQkFuIRR?=
 =?us-ascii?Q?c+PQMGQkM1rsmdLchBycU5q0KcDfTDIfF28PJFC8LDdPPJnZ7+AOv3rqNbis?=
 =?us-ascii?Q?FYXFyaDUuttL2bhwGzVGRSLM9qYhScWywzZZWG4e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b638b7-d28b-4f8b-f065-08ddc4ac5140
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 21:04:13.4694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UKrRb4dLB6Nlkr7lD1X8eWSjmm5cKh9yIZIUWso+TomHqgkq+CR8hkVqJKoY6zIt8910k+8FE7smmC/jhKVQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7040

On Wed, Jul 16, 2025 at 03:31:11PM +0800, Wei Fang wrote:
> Enable NETC Timer to provide precise periodic pulse, time capture on
> external pulse and PTP synchronization support.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> ---
> v2 changes:
> new patch
> ---
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 4 ++++
>  arch/arm64/boot/dts/freescale/imx95.dtsi          | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index 6886ea766655..9a119d788c1e 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -418,6 +418,10 @@ ethphy0: ethernet-phy@1 {
>  	};
>  };
>
> +&netc_timer {
> +	status = "okay";
> +};
> +
>  &pcie0 {
>  	pinctrl-0 = <&pinctrl_pcie0>;
>  	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 632631a29112..04be9fb8cb31 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -1893,6 +1893,7 @@ enetc_port2: ethernet@10,0 {
>  				};
>
>  				netc_timer: ethernet@18,0 {
> +					compatible = "pci1131,ee02";
>  					reg = <0x00c000 0 0 0 0>;
>  					status = "disabled";
>  				};
> --
> 2.34.1
>

