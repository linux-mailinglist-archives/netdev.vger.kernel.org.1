Return-Path: <netdev+bounces-212983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69939B22BAC
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F147AEFD6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8173C2F547B;
	Tue, 12 Aug 2025 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l74opd+a"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6112E2F1B;
	Tue, 12 Aug 2025 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012477; cv=fail; b=FOc3Vy8GmFXG8LyeYuLF7VtJZx7sPi+/CprDw873AgfJ+YvjS+J0LCHzn4KFpevsyZPut1dbYCA1Ijz75/ZSsXImfzvBcZ7DVaim+Ct8SnD3ZZKgeH82tj7byMeJAeMxEuiuFO4X9NgaO+9BmUlw8UKIi8INLKbvenI2+JsCHu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012477; c=relaxed/simple;
	bh=JRYd6k+JZaMO9F0uN1JE1qRKLKU+hS6wna8zPw7GCMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=chbYfTF9NY574SVG8gTluGoqw6FR3kHScd4JE1NKiWJ2g2ShoEkjH5aDzovVGZJo9JX6+mbUlMOodNRQgo0NcpAkv4+bKw/+y5XE2eQ1qaPzAFIKWGZhAELFhtQn6VmtRrUwx8Eq4DEIPrmkoE6AcOdPtUsJ1t3KO+tkBMEartk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l74opd+a; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xouWoTgCkKOi7fK7HIas3fTlhELSX3iQd35h/EKqV3HiNHwzvK2IHkINI+Jwp5NcVyqi7aNtGL5ns339oBBKILVOI4KzVpmvp5raCnrGkjYWo2yVr4Bo0UK6hvO//SRi2VhAvMwQJ+tL600XUGTVmlDt11+nlpys5TbQjbl0EhWwvZBUo6rSP6nd4mEob43DjMP0aIK34poF8p+9YH2+O7Ny32IdBlrnYC+Vya/uy2XQljeyu3/vbrrMlkXwBuY69o5Ct3K1Pg0mTayXewcENS+lmjPGIRh5/FWuAwAtt9k5UfG1WCj5DJMbdW8z3U96br3uARZG9SAkQ1IUQhtMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGjk4roT8Q4ALTMhc0OoFAno5pCF5QnSi01SIBDiq0I=;
 b=jPTO+rnpdTuTfovuxqtiIUsmoa5Vn/DVjKnCh3+bi/v59iD9dSPKMqXckyzauiFziEdyRztV2uz5AIyigjwrFgpIQp6j4Ocr71mU8M3HHGc2GO8KNhgVfToq/1Ft2Phb/rdgwMiK5rxZIGaDPNIm52uCZd1fE6W8byjwedrIxT3ipWiJOlIGe/fbb0t9nr4h5xLIzLi1uvfPbsVioMFQClx8+Kd8hgrnuhJmUsXyhQHhB0xKOTsOJG/HH2T0vzAOUYjRy+1rRLJvS11MRu5ZlBMHZ2iae3UECEs3ZewG90g44eJWb1oEWi3manYDVTo9/dnEtVvj+llDiq/yVOr5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGjk4roT8Q4ALTMhc0OoFAno5pCF5QnSi01SIBDiq0I=;
 b=l74opd+aHzUL8VZGQj4PfIGFn1corULOAZTPlzUAcCPZruOQTCCGhqGTSDS/6RMU4K9m5Af3XP6UWRHpZVkXZOkrpeWndNg4MVqRo1QNGBFJqY5iqdjWj2KY0Pc4T6fJeK7V80qH5KD8wcLA+1J0/toF9rW5WenFhBKicwb029CCjZIIaNOsqVoMCJXWg12mHx5W+VguULL6nQ8Uv867ccAoHgCuwz12S2goavIubcclXRXPnanCvuEyXqpMsbgqgV1zF06APL2B1mwSSXaTLg+9gT17R3Qa5wgJdqmx4NFWCURFEuCIqGq+WINh/nV2WNGwQJh1bEllZpG0OYOXIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9762.eurprd04.prod.outlook.com (2603:10a6:800:1d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.9; Tue, 12 Aug
 2025 15:27:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 15:27:50 +0000
Date: Tue, 12 Aug 2025 11:27:44 -0400
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
Subject: Re: [PATCH v3 net-next 07/15] ptp: netc: add external trigger stamp
 support
Message-ID: <aJtdcF3QkCBPyEp/@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-8-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-8-wei.fang@nxp.com>
X-ClientProxiedBy: AS4P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b06407-aff3-46ae-cfe3-08ddd9b4cc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dqPSlquLLrqkuDu24eP5TUKNQFTexeFSRRwPLS+I2nmW89dsA2yay9UioNny?=
 =?us-ascii?Q?UlHK5Yv4btVoEpPwXDYu180lEl3+J3x+Z83PZgk+7ByuhOtxb3x43nSKRXuY?=
 =?us-ascii?Q?Cx2GXcUkXx6/MlCZSb6K0XLsxnpSmyOjJ17N/6/cL1VwkHGrRswHKkHia3D6?=
 =?us-ascii?Q?rDw7Zpja+AWQa3QQM0WmMaFCfaabHWjE2TwETEQUy5wesfFEcUwMvpA/T/0E?=
 =?us-ascii?Q?KDyPEGgrem1JoVTUh+vtxKfQ3KqX/+gh1qRiP66YKXhkcPD1xWZxbIA1HpEO?=
 =?us-ascii?Q?dA5f0wkbmlvuOcziS8BwCNwoPAwmxQZoKxU0A8OJuO+65mZwLEHC6pz5c8Y8?=
 =?us-ascii?Q?t8h7JNjuPdPQW7X83eijrs4erZHdE4Zy3naAqUVnrL1qy68vby6gONNkclMD?=
 =?us-ascii?Q?hZ6k5VqpxszBhtkhwfnrXgViTZWqdApjHkeD8NdoeGkZAoOS5NMBEc2rF+rg?=
 =?us-ascii?Q?6kjvtVZsSjzYtJD0wppjofcYbh8Dckq/Zku0hLkpOUbpyrNJa5UCrY/AUGbz?=
 =?us-ascii?Q?WXlhGKH6Yq7MQ/Z8JgRl/KwAka/zD+Inzc6NEDU/Bzwihku9/fLOhH31EThb?=
 =?us-ascii?Q?UJ6VIXMBO0Mrn2TB2UcYDwFhS2mPcTU9zUxH7gDG84hGVO7fUFBTRXZKWwCF?=
 =?us-ascii?Q?e2X9JScLCBvKuebrnDdGOuJYXTmQU9ZICWBnbgVhp78Xoz2WFvjDJBRdCKW9?=
 =?us-ascii?Q?lG7A5w7v3+Dnq9n69U1JBqucOg4hTA71skOVu6c4YsX9YRyRoN/o3BVOX5q3?=
 =?us-ascii?Q?8LyhoO2hvLaHdyaYTP5Kce1UbcIzSK7wLmYpN8dfet4f98M/rYYfUnpuv9me?=
 =?us-ascii?Q?Pw7tABc9Mejqizui8bDT7zxuUXf2qwLwLMQReQi1M4vIDIKg22saFEbaQ8qs?=
 =?us-ascii?Q?D03EGO/pysarSJ+X6ee2FmbBIp7qcoiZeHFax/rugk+hMhWp9OV+iVZUUYob?=
 =?us-ascii?Q?sZaoswRwbSTffzCVYeQzs1bcrhK+Buz6dz5nF4wZiItX/lZ6ldyQXnY7JazL?=
 =?us-ascii?Q?VgwDBY2K+E83VoPqKoADMtlgUOQxIxN4rHTmyiVrTe4AdPz9OrzDe7HrY1qi?=
 =?us-ascii?Q?UjlcbQwPQ2u8IteOtygG61nm98uUovhvvX+mJgIPTShBI5rllK+ji2dqeJpw?=
 =?us-ascii?Q?07HbPaUIEr2ZP1aabtDjjs2BT40DVxsbvmFBs4SgrqEj3VKpLICJsx1amNVY?=
 =?us-ascii?Q?Yn2wPMVvGUpKtJlGCtNBsi3GwajZG0K/xpvoW0IXckOFY6WZn+Tr4XIciRyI?=
 =?us-ascii?Q?EfzTu0Oi6JOFGgjw7NQ0MVcvw695jpqxWLLIWfvuyeL2ZSLcDvhvlzcp3gmD?=
 =?us-ascii?Q?hsrOKUJ12+DASpPu/i6eyb4K0SsxGobhXAGAIyM8gTuL5m29FE7Puk0rv2gq?=
 =?us-ascii?Q?qoKlm8Uy5MN9XzVw0d6WiJicBXbddoqXAapMDi+od5MEKtv/20PG99K3uHTO?=
 =?us-ascii?Q?GDllJguPWN+dZLVUHImFowdo5yM0cQyR7/E0YzT8oQw1Vqdk1bL4Kg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4nYOlrc3/8rHLVjq2wqaxflsstclF7M0wTiT/uh1Bb/W0xsHfl97Vobz8yQK?=
 =?us-ascii?Q?ov+FB9FsAGBU49W1kYkFa9yYkSRozzyNbS4OMtGlwBEfF+wYsx+KcYzbEHot?=
 =?us-ascii?Q?H62Cuq/5eKWGwXfSESFXpBr3ysDI80He9mM38QwMVkPspW7wIxzndTSTRai5?=
 =?us-ascii?Q?U0LfnVmtrqxlSmwWK3C3FjBnycfC8r2nlEQA2tPxUNSQu9irQXM3W8HGp4Bq?=
 =?us-ascii?Q?GMySze0R86lMxPBDMpFsZqVpBoqLxy/4S4aIUbOb8ua0Iqvg9VZ4NN++xH4t?=
 =?us-ascii?Q?d5kncJHqyCAPiCnrrY0Q8IfUxYfedFpT6tTqG8i+zMI68/OlFthKHpEPRR46?=
 =?us-ascii?Q?Kc47UWczaD7kGOtt6UyjpzMfs7W5kbcpWBbxyG32rVK9A2FeMSALqxDc5BjF?=
 =?us-ascii?Q?ynkU66NiWHQU+aqzKmR/dSkbuFnS5VprjiiSFzP3dPS9wAzh6VzKByc4AZjp?=
 =?us-ascii?Q?kTGFjT4LokToZACUoEf6GF/e7zCBIHEL6EKhHp/Xbj0ZJlIwXLnP3aVCwMsI?=
 =?us-ascii?Q?eNnMF0T9/rYpISWGxFn8YtaS5rHGY4haGNKkYxPsSWzsBlfHPEEdoZqPcsCN?=
 =?us-ascii?Q?nvxoOfwUln0oLWQlQAfRuFy9q9zivF6I3Rfg7/6kqWOtKIN8Yo/elswJdm6w?=
 =?us-ascii?Q?G7xe+5bUaZTQC+2Wvyhn3OEXnS6xquOvW5QxcJM+UqAhCe0w2K6GgqiclyuP?=
 =?us-ascii?Q?B3jnUzoEO286GY8r1CVqvR5HQL/AYhDATyE8vay/xD7EYvkfckPZmqff/uw/?=
 =?us-ascii?Q?8lEirO9FFJYYMLGPdsOm09neQ/EDV8jzYE/8zQttlp2qwiBFbVY7C4ccRwYT?=
 =?us-ascii?Q?HuI0jIB14azYOLf3aWS82ZvIv8+tldQpeoX5QGVW9hVLQn/wvdiCVv7R9TFJ?=
 =?us-ascii?Q?RtmRKLa8wIY0Z3w52syRWUkVd01ILKBNfhlOAKil7m+mzUBRfhtohAVGN1Cx?=
 =?us-ascii?Q?wDWvryzkFkArbPoQZucEhxGwIJ1QEVyGofAq7hoyXJ8ZLB7KVXhVfLISgGbx?=
 =?us-ascii?Q?jNar2fhjquAec5ZHZfnVW0LrVUG50/c/Nd4MOU94RY0eDt8azIAOLJ53XspP?=
 =?us-ascii?Q?d0jLWGYex4MfZFmomv4ja6YQCIg/hekXh7bBHr6JmTJrdzmfXZM5P0hUw+wG?=
 =?us-ascii?Q?BIzZLP3/pCA5ux57HSEOCSXeEfvOtlajP/SQHQTUgvXwf2XKVfTO8IPkq7/J?=
 =?us-ascii?Q?OvAU23PU630WZC10Q2EaYo7V5NNtJ9C3K6Wc1hjKzS7j904/VQ2KKhghck6l?=
 =?us-ascii?Q?x/WL23GUg2A2sDf+kNURCOakAgH1Funbq3f/VgkXsF+oF1aQoDSWD91e7fEf?=
 =?us-ascii?Q?hsAg0xuJcO8184FsohrdwwDO8kTfUVM7a9KcGe83DhO0VnKpZnikNk/sGPri?=
 =?us-ascii?Q?oTNb5F+n0KPL1IFmZl3+gUUFZPC3fNa+1WFWzzZ/hYN25EGoOXINAVaU+ke+?=
 =?us-ascii?Q?Gc5cj2XgszjAO9R0qmvzyzIRze13f3OWdmEHu6iYOAUA+7pEKvu0CzVW33sf?=
 =?us-ascii?Q?MQYRt9ueNIHuspfDYgLeeDh5mPZfj7ZGGNbARLXhE0CvkWYpsGMWExQuQxf+?=
 =?us-ascii?Q?XbvXS3048JDDCQ+17vPS9LY3Qay9pLCgoe0ySsRq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b06407-aff3-46ae-cfe3-08ddd9b4cc56
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:27:50.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIi7ww9ZuASw9BKFVi20eZ2iytdRyux+q9iIRSMybCSRzFSLgq0SldeHB3W9ljCXsi1yatBkrhniUJz9DYvz3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9762

On Tue, Aug 12, 2025 at 05:46:26PM +0800, Wei Fang wrote:
> From: "F.S. Peng" <fushi.peng@nxp.com>
>
> The NETC Timer is capable of recording the timestamp on receipt of an
> external pulse on a GPIO pin. It supports two such external triggers.
> The recorded value is saved in a 16 entry FIFO accessed by
> TMR_ETTSa_H/L. An interrupt can be generated when the trigger occurs,
> when the FIFO reaches a threshold, and if the FIFO overflows.
>

Nit: when the FIFO reaches a threshold or overflows.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: F.S. Peng <fushi.peng@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v3 changes:
> 1. Rebase this patch and use priv->tmr_emask instead of reading
>    TMR_EMASK register
> 2. Rename related macros
> 3. Remove the switch statement from netc_timer_enable_extts() and
>    netc_timer_handle_etts_event()
> ---
>  drivers/ptp/ptp_netc.c | 85 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index aa88767f8355..45d60ad46b68 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -18,6 +18,7 @@
>  #define NETC_TMR_CTRL			0x0080
>  #define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
>  #define  TMR_CTRL_TE			BIT(2)
> +#define  TMR_ETEP(i)			BIT(8 + (i))
>  #define  TMR_COMP_MODE			BIT(15)
>  #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
>  #define  TMR_CTRL_FS			BIT(28)
> @@ -26,12 +27,22 @@
>  #define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
>  #define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
>  #define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
> +#define  TMR_TEVENT_ETS_THREN(i)	BIT(20 + (i))
> +#define  TMR_TEVENT_ETSEN(i)		BIT(24 + (i))
> +#define  TMR_TEVENT_ETS_OVEN(i)		BIT(28 + (i))
> +#define  TMR_TEVENT_ETS(i)		(TMR_TEVENT_ETS_THREN(i) | \
> +					 TMR_TEVENT_ETSEN(i) | \
> +					 TMR_TEVENT_ETS_OVEN(i))
>
>  #define NETC_TMR_TEMASK			0x0088
> +#define NETC_TMR_STAT			0x0094
> +#define  TMR_STAT_ETS_VLD(i)		BIT(24 + (i))
> +
>  #define NETC_TMR_CNT_L			0x0098
>  #define NETC_TMR_CNT_H			0x009c
>  #define NETC_TMR_ADD			0x00a0
>  #define NETC_TMR_PRSC			0x00a8
> +#define NETC_TMR_ECTRL			0x00ac
>  #define NETC_TMR_OFF_L			0x00b0
>  #define NETC_TMR_OFF_H			0x00b4
>
> @@ -49,6 +60,9 @@
>  #define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
>  #define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
>
> +/* i = 0, 1, i indicates the index of TMR_ETTS */
> +#define NETC_TMR_ETTS_L(i)		(0x00e0 + (i) * 8)
> +#define NETC_TMR_ETTS_H(i)		(0x00e4 + (i) * 8)
>  #define NETC_TMR_CUR_TIME_L		0x00f0
>  #define NETC_TMR_CUR_TIME_H		0x00f4
>
> @@ -65,6 +79,7 @@
>  #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
>  #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
>  #define NETC_TMR_ALARM_NUM		2
> +#define NETC_TMR_DEFAULT_ETTF_THR	7
>
>  /* 1588 timer reference clock source select */
>  #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
> @@ -475,6 +490,64 @@ static int net_timer_enable_perout(struct netc_timer *priv,
>  	return err;
>  }
>
> +static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
> +					 bool update_event)
> +{
> +	struct ptp_clock_event event;
> +	u32 etts_l = 0, etts_h = 0;
> +
> +	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index)) {
> +		etts_l = netc_timer_rd(priv, NETC_TMR_ETTS_L(index));
> +		etts_h = netc_timer_rd(priv, NETC_TMR_ETTS_H(index));
> +	}
> +
> +	/* Invalid time stamp */
> +	if (!etts_l && !etts_h)
> +		return;
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
> +	int index = rq->extts.index;
> +	unsigned long flags;
> +	u32 tmr_ctrl;
> +
> +	/* Reject requests to enable time stamping on both edges */
> +	if ((rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
> +		return -EOPNOTSUPP;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	netc_timer_handle_etts_event(priv, rq->extts.index, false);
> +	if (on) {
> +		tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +		if (rq->extts.flags & PTP_FALLING_EDGE)
> +			tmr_ctrl |= TMR_ETEP(index);
> +		else
> +			tmr_ctrl &= ~TMR_ETEP(index);
> +
> +		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +		priv->tmr_emask |= TMR_TEVENT_ETS(index);
> +	} else {
> +		priv->tmr_emask &= ~TMR_TEVENT_ETS(index);
> +	}
> +
> +	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
>  static void netc_timer_disable_fiper(struct netc_timer *priv)
>  {
>  	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> @@ -528,6 +601,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
>  		return netc_timer_enable_pps(priv, rq, on);
>  	case PTP_CLK_REQ_PEROUT:
>  		return net_timer_enable_perout(priv, rq, on);
> +	case PTP_CLK_REQ_EXTTS:
> +		return netc_timer_enable_extts(priv, rq, on);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -655,6 +730,9 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
>  	.n_alarm	= 2,
>  	.pps		= 1,
>  	.n_per_out	= 3,
> +	.n_ext_ts	= 2,
> +	.supported_extts_flags = PTP_RISING_EDGE | PTP_FALLING_EDGE |
> +				 PTP_STRICT_FLAGS,
>  	.adjfine	= netc_timer_adjfine,
>  	.adjtime	= netc_timer_adjtime,
>  	.gettimex64	= netc_timer_gettimex64,
> @@ -687,6 +765,7 @@ static void netc_timer_init(struct netc_timer *priv)
>  		fiper_ctrl &= ~FIPER_CTRL_PG(i);
>  	}
>  	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +	netc_timer_wr(priv, NETC_TMR_ECTRL, NETC_TMR_DEFAULT_ETTF_THR);
>
>  	ktime_get_real_ts64(&now);
>  	ns = timespec64_to_ns(&now);
> @@ -820,6 +899,12 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
>  		ptp_clock_event(priv->clock, &event);
>  	}
>
> +	if (tmr_event & TMR_TEVENT_ETS(0))
> +		netc_timer_handle_etts_event(priv, 0, true);
> +
> +	if (tmr_event & TMR_TEVENT_ETS(1))
> +		netc_timer_handle_etts_event(priv, 1, true);
> +
>  	spin_unlock(&priv->lock);
>
>  	return IRQ_HANDLED;
> --
> 2.34.1
>

