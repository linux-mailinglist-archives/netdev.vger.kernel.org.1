Return-Path: <netdev+bounces-188484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2318EAAD0DD
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F641BC1D6C
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 22:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74E721638D;
	Tue,  6 May 2025 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dapYQJ37"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013033.outbound.protection.outlook.com [40.107.162.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CF157A6B;
	Tue,  6 May 2025 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569924; cv=fail; b=pxyWO1Df5ukJaOi1pJ483CRIX0fX8ZGGSLVPRwMn6zIhXEjKY/DK8TGqkua1H1nyf6GmUf+cQFcr2V+10X/D+YXcL61jqytQtIEsUoPgrt8Z0Z0556Dtb8x04mhbLWBGSIT835pyCB6n0S668vNoVcwAhBL/pydrckIHmTx3Lnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569924; c=relaxed/simple;
	bh=Vm3n2Krj7SGoYN6W5N9MW1CGRPcVtttNaJexs8/Q8SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YTqCTK+mQyMswy+zcx3QTJYTBy/EXmSLq7iiAyaTcxsv5xNihcKqQTCC/usB4sTEO6iOZSLc6tX8+NFeKjaCJ+BtBkK+1+lTRQX30nLiL90x4LSj+3H3aLI7zX5OsKDqtRQjPR1+ilFw5itPTtucT75Trgnq1u2gezq+xqRbPd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dapYQJ37; arc=fail smtp.client-ip=40.107.162.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ree+vVkRrlLRpszsFyjV/nsR4NcszkjaZ95+z45xBglD+uiae2vJfrugPEBZXpq72E6rYAykTC1Xwa4FBPI5Kf8pCl82+I/VefihmXwRzmMVe/SKGY3CBVTqKIotVXE4CgiJTbGsJmpmZHOjeJgsJjm0013FdCT5nNiyaTl7PkorhZ8gFRij/UzDuqrxWCuZTZhWKlpi715xUlWXzAj8WgncAUiOavFyfbJQTxdFyExECaEiGvxs09QSJ3RBtQhYpdpJXMrdZp2qMLFfR7KeixDUwC3tvh8QvCijNCEIY1U0CtWzjOAO7gqGgsou3zRcSgTffLtwiwDWgoxUapIcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ3Y0UP5+30xKw23aI0BmflkXsNMdFBSdUU3jpS2mmg=;
 b=NtEb7EyG3qbP405ceJH2h/mdWQLNNSta5N9/EmSUP364kypmaRoSxGY31q8P6fgWAx4lAEF3ozELhKbbjiRHaPaYLkRd3LbvbSgrvOEhty2bagSlLLK01V20zYz8jA0I16xTKpNpvpm5toB58JPsgSfyCcJmGZDA/w5Aw+SBrMawrlsmdarcV89jHhUTvGIbZwAIcsYkjtyqRrTiklVBf3vlKWO3e2kgN12On1aiZvhdSHJTKvWbudfBynrre1EO/6X13kRWk9fhQMwx9+XXFBy7hfAuMq2HJwRwDoFCVZ02HsdxGQmUi9D4D6w//K/YF4dkfQHozluq1dkR4X2NqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ3Y0UP5+30xKw23aI0BmflkXsNMdFBSdUU3jpS2mmg=;
 b=dapYQJ37KSjLF/eQW68Luo68UdgndcaMlR3V/ZFMcKk/B3egvgZ9yMHtetGntX5Dq6yrM/CTQ5fNWXbHm7pNVifEkmG0oDb8+QLOp7DuOiYOsXcPDlsQbVh3LcMvbs0nx0eiEnc+8nwSCvmNO+bGhfDek3NOl1RiKFqkRUckrQyW3t3IXPRXXnmbpHxQGu3XGs1lRFJXvHmzCwiD/Tru/fNtyU/0oDEeG2ht/489hzVDXoPm4ZzRzZWWRvg5GWUfoyylNCh1+CRn0gkr80X+1CLQndNDFI8cC9kmtauWMdCIaAmvh1l3PAOIYq02QU6CNhiJFr3x0n/no1Af6zBVnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM8PR04MB7747.eurprd04.prod.outlook.com (2603:10a6:20b:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 22:18:39 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 22:18:39 +0000
Date: Wed, 7 May 2025 01:18:34 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v3 05/11] net: pcs: lynx: Convert to an MDIO
 driver
Message-ID: <20250506221834.uw5ijjeyinehdm3x@skbuf>
References: <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
X-ClientProxiedBy: VE1PR08CA0017.eurprd08.prod.outlook.com
 (2603:10a6:803:104::30) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM8PR04MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f30819-5134-471f-2c66-08dd8cebf30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mkDlWvSLQU3PxozDHsre5Pxw4nCVGIPrQY2hl0QBS8mNsExYuh02/5g3twBY?=
 =?us-ascii?Q?4b5napycBm9c5z/hnZ3y7izCJJDvjIedC0FX3t2S1arQ/m3qaY6cQOtobzIL?=
 =?us-ascii?Q?8ruB7iCsHyCcPh+NVlxQGplyaeMoakgSskfD4owfu+9aei6lsXgE5O1/E905?=
 =?us-ascii?Q?dD1lG2Ta2tpGr2fYFvEwCnDZqbBu+ddBFocj+LpqIcE9oyNNTA1JoWpu2D6P?=
 =?us-ascii?Q?mrRLupUUPR38h0Kxej56gPHKG6nEw6b/ADfVX3Mh/UGPRxjeOKg2Iy5U6tbD?=
 =?us-ascii?Q?yFatcAbfatSwDg18kgLcqJhR+hHt5jddo+Kkp01ajYpd8mTBnEL8n3lGLu6o?=
 =?us-ascii?Q?MBGUsfr/EKhAAEbgu+NBfHEPqjykK4//pIcHWo9GucgNqvokQK5TQuYP8JWc?=
 =?us-ascii?Q?CgsliDr03OksnqquZvVRNn56W3rF0y8Y8iu3dQT8tDrgCsIQx9/g447g7oWN?=
 =?us-ascii?Q?sl+dLloeVssmEyUutH6vl6HbbmZG5p5C3Ntb7emM6WPqTLyx4Sr2kURL+ktA?=
 =?us-ascii?Q?hy/fg/i7KvutsAEarsPUnN59wQXlMRJP5XKAA/sZ5Mvm1ntN2yc3iBDpstfI?=
 =?us-ascii?Q?2GKT6Tid0nMNTGLYsWR1rycArnhWQ5q5Rtq8vlnEZ2unJjdcLCwWkEByDRH3?=
 =?us-ascii?Q?/UKTzzNe8mn2zFKw9WTIHxVwtDzOcaP7rF8l/lZpDzF2IHX6vryD6lXWTgWJ?=
 =?us-ascii?Q?v/u+RusofRHPHdP9m8y3VQmKTfuE1WkkGiWm5Hj8rpQHnHdUh2PI1JPtb+dl?=
 =?us-ascii?Q?0BOP737r16Lo8yNuTrzpJi/3s/BTJKW93Jj/QcbpZTgxCv3Hxkklx1+XDTmr?=
 =?us-ascii?Q?fSlVMmBkNmC33sFwNo61z72wgClpQltjV831FAmCNj5bTt4zJxlkZnCykHZj?=
 =?us-ascii?Q?D6aTVWTJfoUZWSjaFzrV/HDRmtaJ/dDqb6yBmxOsZtrU9B72dhdoN48SP9b7?=
 =?us-ascii?Q?bXu8wYeUh/Pdhwt4NuvKCXe3HmIdYJKBldiskww34uNc4BSBEaUZAwvK2CpS?=
 =?us-ascii?Q?IYbDpFLCmwTxZTmD6HuAhc7C5VpItPFIkRWY2mHaKE8hi8+W842jIf815vcW?=
 =?us-ascii?Q?Qn5ygmhx01BO6Gcd35ORvmsJyFdVzkpSpji/IZ8V+rz75xe/ETkVM7ywwdMb?=
 =?us-ascii?Q?fiCYq2I4LzmWXJyKkMVnAp9puh1V9UT61p6FdEDXMbegL1pIaBZSXvp45JE6?=
 =?us-ascii?Q?L2U6ToOArX1z0JRR5o5MxXblC84TDIVUsIqTwHLpXtKZpjYC+lr67mcOjdVg?=
 =?us-ascii?Q?pKMHtV1uLA8LxIiAFXUJsKWw80qqxTtd7hx1DZMHUyem34MsHJJxx2WhBWBY?=
 =?us-ascii?Q?qqIeOpJONxE0ynWoY8HwuZe0K5xyxeQeyjkkWQzF52vSaG7Qseeb8S6HmFgQ?=
 =?us-ascii?Q?6XnaPF7Yj7DhhEcTktfXm92YBwdQbi8TXW+U3NUFzlHEer/ODw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ypsu6fSsKUN8SzuCij7+CUWn7FuUE09izcYsLwE+bz3M43nByiaDuWxcZ7Dc?=
 =?us-ascii?Q?OtaF5UlBres2o7TsQBHVoZ9XDmCiC5djKBAGpPHZbarY6qod8Jyos1MeHABu?=
 =?us-ascii?Q?dwRfWMtsT+dAKDa2UGpNOPafrulWVMfWGgNlFH2riNktjG7Xix/WMOC3eT48?=
 =?us-ascii?Q?3Qudx9kmr/UdLDbQ+5J1Pwt5OKcseBNpF8G/hkYdLUFzM6Hg8raCL9aVsGwX?=
 =?us-ascii?Q?5+448znfcp0KpKhP7ZrvvnhRpDOZQfwNJ/6495lo9/e2DZWU5z+UO/X/+yFF?=
 =?us-ascii?Q?063SzOq2D9TYbYhePRSXfzgSc1agHVerUgUkQXy7Z8DZgUylZm/VEEqUKg8b?=
 =?us-ascii?Q?RBzaFOZUUAEXVAtFsfZQhe9itffraPNE6lIg6RapUmGr7DiJMqxpTUAOoxBf?=
 =?us-ascii?Q?MWQxKYaEIXOmg7I7UjmmMQcAt7eIHeZQVsPltQyplhGBZKl3IknIsKDNc/CJ?=
 =?us-ascii?Q?clqQVUQQToMlHpVy91LgNzmG1q1RwK2ca7eDQ9QdH10cIzEVeWKtx4pqwzde?=
 =?us-ascii?Q?XM0H4j/GNkg/DvadDoieBMwL8C1YPSnFaZd06rdeT6kkwGQY2AxPeuEfPG+h?=
 =?us-ascii?Q?dTk+aGw/IaqR7rqchaHOzwh2/UkPR8hv4euzhmw0CrP6DYs/dxCyOqhEm9Re?=
 =?us-ascii?Q?F7afgnjjJ3sAgaL7907y5N4CAxm7beaXCSblH7AWI90dJ72iK8NN9neCVSEd?=
 =?us-ascii?Q?sFU4MEKUAHBuAgAREb9/IALwJve4IWW9app/hd1rdqylrDVGtImbvkHUktje?=
 =?us-ascii?Q?eimD/ybyqFqR9xFeW3O99/KgTql66JmlmXvtVnyb4vRAZPVnvxAc1utVb4uO?=
 =?us-ascii?Q?C/O13vm5IP4VgVuuF1YQUIkoTEHrzl1+WLMIYYGKbYJ7U/Rp9EdayDFcu3QF?=
 =?us-ascii?Q?TzHzvWAu29LdcXfrHEX62PyilW/YGAggqPjhIzdkAMHHfEqtH4s2+krowdIf?=
 =?us-ascii?Q?UigY5LEVdxrS7b0tgwkKkVfBzPPUqSvqiGDDN68olvSY0UOn8Gf7UsrtPCZv?=
 =?us-ascii?Q?H2pkp6fsjhKYPr9ecVlaA8PkTf2QDcBhJjspCGGEabQkJkNfuwY3lMN+7vAb?=
 =?us-ascii?Q?WztAXul2n4wLJH1eVJ8A7Ms9AqpcnmTBYKzKHiisqEL38MvMMNHFyjoMu2Qi?=
 =?us-ascii?Q?07BkOJIidvw59kufjmDmqo8C2ZEassvQ0e5z6zvtYgVuDv4vYKZ9FykPdcPc?=
 =?us-ascii?Q?X+KLJw2ZAWZbaIxkf1hiaHFvJYtw9MGbDYoUBAw+c/JTxkzWfoIM2hVGalvq?=
 =?us-ascii?Q?hB9ArkL9szIoqE9qXUaxReT6Rf1VpApqgKLM77lFxjnknYBeTa3thRO7EHk8?=
 =?us-ascii?Q?mkFV5pI5TOz7MW97n1eLxlLXm17/ilchctFHKzT5MRV0SyJz2AiLRp4uHRr+?=
 =?us-ascii?Q?mysi57FItSsoNfQcLIk+cNGsKnss3z1dOelhW6Ir4NWIrsKb4ZvkH0ZFJc++?=
 =?us-ascii?Q?w1TZzOCBwMGa1oEXgZB7hLpadGMFayHt5jXr6pBg86sNofEces4d/W+Bm3Sp?=
 =?us-ascii?Q?qlIGa026sQbevnF/7PZQt9ElVQ0EyMsq49XvXUYDi5wDQZXN08BCMPhhTJI0?=
 =?us-ascii?Q?rx3zAYsTvh259+aCoV6QqX8Vxw+/OX9ySTKw0waZlq1xmvol9sSjBQkOfOUf?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f30819-5134-471f-2c66-08dd8cebf30f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:18:39.3084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MqsfiDotGrlp+RaClhoYfC9TNFQf5wjOTeQNQa7KDhMu6sojoV0RRyhbbSurZkldVvDLhaTSml3in3pqOQepQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7747

On Tue, May 06, 2025 at 06:03:35PM -0400, Sean Anderson wrote:
> On 5/6/25 17:58, Vladimir Oltean wrote:
> > Hello Sean,
> > 
> > On Tue, Apr 15, 2025 at 03:33:17PM -0400, Sean Anderson wrote:
> >> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> >> index 23b40e9eacbb..bacba1dd52e2 100644
> >> --- a/drivers/net/pcs/pcs-lynx.c
> >> +++ b/drivers/net/pcs/pcs-lynx.c
> >> @@ -1,11 +1,15 @@
> >> -// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >> -/* Copyright 2020 NXP
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/* Copyright (C) 2022 Sean Anderson <seanga2@gmail.com>
> >> + * Copyright 2020 NXP
> >>   * Lynx PCS MDIO helpers
> >>   */
> >>  
> >> -MODULE_DESCRIPTION("NXP Lynx PCS phylink library");
> >> -MODULE_LICENSE("Dual BSD/GPL");
> >> +MODULE_DESCRIPTION("NXP Lynx PCS phylink driver");
> >> +MODULE_LICENSE("GPL");
> > 
> > What's the idea with the license change for this code?
> 
> I would like to license my contributions under the GPL in order to
> ensure that they remain free software.
> 
> --Sean

But in the process, you are relicensing code which is not yours.
Do you have agreement from the copyright owners of this file that the
license can be changed?

