Return-Path: <netdev+bounces-217337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A57B385A6
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8759B17BCED
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1047126F2B8;
	Wed, 27 Aug 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UYQ1L4DW"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013043.outbound.protection.outlook.com [52.101.72.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88A23B604;
	Wed, 27 Aug 2025 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306975; cv=fail; b=Tqn1VaaKp5kyUmOU6qzx9t+/DGXen3ItYWTsYECUHFVKKZ/TlXUh9ssRQ8ClgjE8ACgL/7AmY6UXmA0ka93tNGCzrYXpvXgX/nzHxUZeUoRopw9lE0DLAwP3s1onMpMJ43lkd11+btzoGDFFBER8o+eVhWaIlkpcifcAmWHFGeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306975; c=relaxed/simple;
	bh=kmVlkSBtBzbuMUeovhahu2YaKHQw0SV2isheuqvAOgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r1/Wr+CgWtttqTUoPbwvtAzQN+YRNhfoJbdrHLeRDw6S1OOYlbUysyIV5Vqr9mDmTUNV58r7zm156UqcH9kT/6Knup1LoN5xHyPk/nixmAE7eTsDWmWqThl4B56k7rBV7inzfSuRgtezQt5gmIrwXdxD743Wp4J2Q4TiaNYW4X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UYQ1L4DW; arc=fail smtp.client-ip=52.101.72.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=douUE2/oAVVYF2Waqu4/8LO7Pq+7uREexOEPE/rqzYMlKFuVsTzxQh7q6FpBskv0sVDMllU0Tt49eFE2v3Fg6P44YRK/GdWj7v5F6J5HpkfXjpYW8zQWKZ29aasanJ8TjIAHWWMO11G11iS2IKxHDPh5AIH11Ecg5pd8eiiNAwJHULSBD5Q+hsYSLc+JQK9AMuL/y5Ovop/pGNVv577MsUx8QGiFDxETrLRs1Prh6PGir4o5/ROjtEM/kUSsG5CWAxj84buVmln0xRp+Dj+wQfuCBY8zJn+hVY6MxbJfOMw2gBWV0WRX0cFTmGYBGk+djd0MZ6lvWAvGR4oBDG7+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVH5+YoUUW4Iag/wNTE+dAO9x8hgU8mGeKOn+UMK2jI=;
 b=PWVlr4mIbjVCZBA1MWsb6WVr8KNWsn9aiKvtOYjtzQAGJCnNdAlKvhsuVYQjJB0NayXF31VdzZs1wpzhUMMmW3HI+C9VjwvnGVzDnqxLIKRP5ZhON/5UmPmU2Jwnw2bjAnWkd/3ysspeUyC4n7u9vkqwAAnnBD/XRrkB4bDMb4Q8uOQL93CZ92pIXtJAYuddt2WzBD3EXUq8IduS2YomJTzqDf5UqwmeiSlc3D4pMtwCXoxtvE9gTGAijaUCZah9Yrppz/G/nH+aJam8HuUeottNkUQJZRbORE1HWrBvF5kwUeqvTUZSNyk7dyoDOLQq0OxDI3DEVDZjfbtKK1zrlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVH5+YoUUW4Iag/wNTE+dAO9x8hgU8mGeKOn+UMK2jI=;
 b=UYQ1L4DWLC4vPpMKgDZTJaDM0eZ29h3nu9l/iHHf+Ngknv4tXtCeVaIq84HsWThaXgAgipOvGa0wYlNM/hZl3dy0FSLjlryc8xR06WzT6u6oI8te0O1KCzGpdQy7u86uJHYfaWmszTIhCRR4FU4ZfMhK4xrw62+JfzHArNY4IIjMWm5Va4tMbwFwwC1xP/CY/wGNuOsX/zaDLjn8k6/AVZqWSQnELpztTKTNRhvQ7EHkNwwWHGx9vDNVQGhdMe5jQirTTT17HCUwljTnUBRF5irX0X2XOXEnpsqOGjjRK0fagjOt4XmeMTjpB38rKCLUQFaanwjJFx5r8dq1z6BwFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7781.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 15:02:50 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Wed, 27 Aug 2025
 15:02:50 +0000
Date: Wed, 27 Aug 2025 11:02:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 net-next 15/17] net: enetc: add PTP synchronization
 support for ENETC v4
Message-ID: <aK8eETLyqEXKyc4V@lizhi-Precision-Tower-5810>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
 <20250827063332.1217664-16-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827063332.1217664-16-wei.fang@nxp.com>
X-ClientProxiedBy: BY3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:254::10) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 2281d5d6-6bfb-4fb7-e650-08dde57acaa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h5Tb/5m4XzlUaRAx5PGhTFXad2KfdrQFZq44fXgUXByygCN+r4Aj4osQa524?=
 =?us-ascii?Q?FI2ccqDAYN7jepPHImwNzgVyEHgbUc0ab78nEk08cSeIGhqkOAIAdsINufYA?=
 =?us-ascii?Q?5BcFgnwB9VUi1i+KKarj2JnCFwwraT+OFTT9cx1chsh8JSTqjl0dGHAP2af1?=
 =?us-ascii?Q?+Pc4EXUcknknaTsj6R9VJvmO7/hFXhzeiQouCplWmqP30AV94qRIzq4yGFPB?=
 =?us-ascii?Q?kgZz0pW/fqnbiQ+q6Fg0DoQm3VE2Ptl4HEzyQw5F+DJFHhLW9hk7iTET88kh?=
 =?us-ascii?Q?bQ/1031qk74MSvpY/TUarkwcqpWBlMc9nwMHMstZGVu8BdrTzr4cfhtnj1Yo?=
 =?us-ascii?Q?gxytaELBTbZY01wM3MRI/QF38yA6sW8vItw60jpg+ltiBxUOqz50OWHjfDKs?=
 =?us-ascii?Q?ZdGlITqdeQg5lFpjKQkyRM+FhKT8NcqFFHvgEDtEbT4bHlq0ACSS782uugoC?=
 =?us-ascii?Q?zpNvrlCUyJ50XL4uLohri9ZQFDSXorb6Mq2Xd1NIFko6ZGuLwEHMLz/rSYVI?=
 =?us-ascii?Q?pFP50y/7VAgtJg2o0sYzDFH0ijKYcDiP0kY8V8twXQaA+3qQBBXq1HVhyNwD?=
 =?us-ascii?Q?SHdA4tM0W/pOuqEO116dPAC9isXI7EzHmYsspjlF8rBOl4IPg9unC/fU/Sz/?=
 =?us-ascii?Q?BpntLOVgMhrPQunS6Xvvro/6e//yCOGKs1MpyU3IweCTfqlfmKJQ6uuDVR89?=
 =?us-ascii?Q?Vl6PiiLz0V6eQaQHwMP+6eZFs/uSE+pFQyrX+bQJ0nkhc1mnMA7M6WEsbcDk?=
 =?us-ascii?Q?U8HW226C3Sv9Au8YfGAN/WNbS/jR4wml6os4GLWolKjsuVhZ6FDcGEgfxLzK?=
 =?us-ascii?Q?Wto8i0HbQTSNhSDpR0l3d2td2J3oVGexbHjl/fzbFg2VkWwcDe6Bg6ohEjj5?=
 =?us-ascii?Q?rRaSqhEaVQ4dHJrjCDEyf0twZbhDkiiwbvCBL45pObDEh+Gfpaa+dtf8C+M8?=
 =?us-ascii?Q?1+sSP0Z9/YrvSzTDPO/FLOqhWSpsTjaEn0qQff94cloBUpDsKKpplktY+gTH?=
 =?us-ascii?Q?sKKGFyhT9YGlW8Y+1NlcPIQuvRZlBrpfaPxsHAOsvAliXGR19serC5XE32qg?=
 =?us-ascii?Q?WKm92OPg1qepFeSlJrO/Pgy+syFJ/GDRB07gfz0dvTDJAkvRFoxzinuTDjCL?=
 =?us-ascii?Q?Fn2P7tx1T0fb8GlEP5VVTORj1Q1BXpi66jUaGNL3gZcGAUaQMqNwe6Td4ApV?=
 =?us-ascii?Q?NQJHb0k3NrWKmY/nhJDqHRCN/9WxIxgpK4X5PzS5OZLFbpO7RNdDKFzurq3U?=
 =?us-ascii?Q?K++GFrfD7DvqRioE79pQhSLOSQrZGdZtSRELXn4ASBw55BQbc5gC22Xk7+TH?=
 =?us-ascii?Q?qMIVj6IYCz2XuDy4UTc2N0c4TXKq6aQL3ATrgp9KHIgu+8NHSUvmGT1L6h8g?=
 =?us-ascii?Q?3uaZqh7QZyaClTIaE2Q0MGuc5X9PSNQHouDzjOYmwQmSMWcRO1N9yEMjhies?=
 =?us-ascii?Q?sLozzFATmknH8onbcEEVMdzzlhAJuqpwWLZ4bxusgeSlXEjw6c9lQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I0J+wvwOa2wzQt7jK0v476Or+b8xdcnM4VvJWi5mgsIOcB7LvuhYWhU7vfn5?=
 =?us-ascii?Q?YHvgREa88fo/aakRJrVqcms94iKqWZ+WG/rKSCmm/BIrFQSXmIX8hFV+0kNw?=
 =?us-ascii?Q?aQ7LUBK6kurwFgf6WXMzpBguZPDI+Q8f4AUvl6N8XbSuBtOhaXOPsbykHHSu?=
 =?us-ascii?Q?yTafD7y/gH/cVNDQ9MHCzt4u8gZuyI7XVKoyDzJ6dcrEAcDjqYIJYybn35j1?=
 =?us-ascii?Q?Jkjp+Cgq9enzM6ptQKvye9b4dvuT8E3TZL0qNe1gy4d3xVzbLmiixsqCjZv0?=
 =?us-ascii?Q?opPvNffKNu/amemVUhr1FIGTdMuW0WCPHkqR2rA6W0H1+zS5YbRUKK/c1VE9?=
 =?us-ascii?Q?mXmjhVUO+eKyrVK7cnmyA48gW2ZjnbxErRRC9ua8Avd0BP7Cv9sfKuboruo7?=
 =?us-ascii?Q?kVE3AygeudIyxnlvctIKvjpNa0F6irPI5aM2zGOHWJZeIUfAsCvoas6M06N3?=
 =?us-ascii?Q?dS6y1avwNaO/fmFIXl6UkH59VWJguSX+PTlRTEu53mbrRvPedNNImwMgWi6/?=
 =?us-ascii?Q?bsJgN8N75VjlPTI8NXUJrr/3FMR/yPh97E42GFNhvf+NxqSK+KgjP2NuzTwB?=
 =?us-ascii?Q?izaZ93Y6R/+E7C2/loQgmmq/9CY26pAs2R+ApKoNTKzCQMQzDSf0hHXfXo10?=
 =?us-ascii?Q?Tt0stIPtt3wZQduzTOKlANITNDM1+G4rS/CnYLnJIzLReH54xpjd0VbjquG8?=
 =?us-ascii?Q?rcuzUBgEXXOK1i98z+HC3r2enhac02bPvdSwiAabT0sSlwotq0jP5Nb+yfOK?=
 =?us-ascii?Q?iz6ZGZat1wADw9/9rJtU4g0im4/xSV0ThqeUFM/Qe8wopgOfYbgxtK0ejg4q?=
 =?us-ascii?Q?N6E0m3GCE9XlG3pawBbSbbbZ/Ae2ZDdiyiJxI82UDR3TJi22axZhrWQWOSNN?=
 =?us-ascii?Q?Ma79v8LQmonW+txbWFH3HiZLl5HzcOHByXEePsn7lMKDqsbZ91WCulfTlBQX?=
 =?us-ascii?Q?WEJdc0SpJ/5/kYvLvH4RdpWkZIE86ccUdGnyDyxeM+Jk8q94yvlSxQCJF1NR?=
 =?us-ascii?Q?2Qkng7ZLZ5bRbBWKA3FRszKSPWSjl02dMr59yElmhv2Teabas86F8StJhtvI?=
 =?us-ascii?Q?3w+V1qXTxIj0zIR7CmLQbL3acZO3ghIegzJQCW8SZlCYqUGCyXMSctyRrOVl?=
 =?us-ascii?Q?kukAWEMRTUlrqV3hwAgQQWI4Fijw/TFkVhLEvjJ0yfDhQr4f/5XStN03A0Vt?=
 =?us-ascii?Q?jC3uY4Apq//G4zFkIWzJfuoyoZJIezFuEXn9fHHHKf+Mb6Dgxsk4c0t2EWme?=
 =?us-ascii?Q?w5TRurbzvdD8rahi2XFnMmr0lUQrM8ZgBwq5IaOwm6Sqe0QdxoZ+WacACx/K?=
 =?us-ascii?Q?U6MkD1XUiLCwZlcSwkVrDLhArOBGKXB4Gc+WztRoy3AwlKAneuHCjyrthHGq?=
 =?us-ascii?Q?i3o+Phw+S577HNxYY9svf1DMPg5dVDnGC9CuufCQO3j6K70MMY9Pg5kk4wrh?=
 =?us-ascii?Q?s503jUsTMjPVbdHOk6ezZtxcq1z97q2Z6i8U6NNL6AN5+9Tp3OoZcL3WjYzx?=
 =?us-ascii?Q?hFkcum/U5jaNeiEg1pbALe/eVGizLqAQOXCYqKFNMSyTXyzV8noJb2CJyftw?=
 =?us-ascii?Q?GhTabgqm6vMUCb6x7j4/fB25QS7BArV+/mR/pLF3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2281d5d6-6bfb-4fb7-e650-08dde57acaa9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:02:50.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENuTGUS8d6NsNzvfuD0BzDO63C2EPzl1i+dQSM5K6b3msT4r0/qPoVeSX6yWZnsao7V3xCBQIG6yRX+HYh7hyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7781

On Wed, Aug 27, 2025 at 02:33:30PM +0800, Wei Fang wrote:
> Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
> mainly as follows.
>
> 1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
> different from LS1028A. Therefore, enetc_get_ts_info() has been modified
> appropriately to be compatible with ENETC v1 and v4.
>
> 2. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
> register offset, but also some register fields. Therefore, two helper
> functions are added, enetc_set_one_step_ts() for ENETC v1 and
> enetc4_set_one_step_ts() for ENETC v4.
>
> 3. Since the generic helper functions from ptp_clock are used to get
> the PHC index of the PTP clock, so FSL_ENETC_CORE depends on Kconfig
> symbol "PTP_1588_CLOCK_OPTIONAL". But FSL_ENETC_CORE can only be
> selected, so add the dependency to FSL_ENETC, FSL_ENETC_VF and
> NXP_ENETC4. Perhaps the best approach would be to change FSL_ENETC_CORE
> to a visible menu entry. Then make FSL_ENETC, FSL_ENETC_VF, and
> NXP_ENETC4 depend on it, but this is not the goal of this patch, so this
> may be changed in the future.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
...
>  	tristate "ENETC4 PF driver"
> +	depends on PTP_1588_CLOCK_OPTIONAL

Not sure if select PTP_1588_CLOCK_OPTIONAL is better.

>  	depends on PCI_MSI
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_MDIO
> @@ -62,6 +64,7 @@ config NXP_ENETC4
>
>  config FSL_ENETC_VF
>  	tristate "ENETC VF driver"
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	depends on PCI_MSI
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_MDIO
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 25379ac7d69d..6dbc9cc811a0 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
>  	}
>  }
>
...

>  #ifdef CONFIG_FSL_ENETC_QOS
>  int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
>  int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> index aa25b445d301..a8113c9057eb 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> @@ -171,6 +171,12 @@
>  /* Port MAC 0/1 Pause Quanta Threshold Register */
>  #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
>
> +#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
> +#define  PM_SINGLE_STEP_CH		BIT(6)
> +#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
> +#define   PM_SINGLE_STEP_OFFSET_SET(o)  FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)

missed alignment

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +#define  PM_SINGLE_STEP_EN		BIT(31)
> +
>  /* Port MAC 0 Interface Mode Control Register */
>  #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
>  #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 38fb81db48c2..2e07b9b746e1 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops = {

...
>
>  void enetc_set_ethtool_ops(struct net_device *ndev)
> --
> 2.34.1
>

