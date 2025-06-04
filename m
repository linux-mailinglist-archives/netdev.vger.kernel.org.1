Return-Path: <netdev+bounces-195054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155E5ACDA9C
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E918176D12
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 09:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD7128C5D1;
	Wed,  4 Jun 2025 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hbccwess"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136428C5C0;
	Wed,  4 Jun 2025 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028285; cv=fail; b=p6PY0lfToRvze3yWq+9UkW5OoZ33x+2Pi1KqMyPWqW6WPgd1rooeJvD3tImxnRGOrvY3AC3/gLpTCfDSWe5wDNuLW2hrBv7G+305OC4pagP7O2u/Kc1vB6ZLKeTSlPs0Uwm4X5dzel3rScZ0UFQYNkh3ANfH3wg6fjuzLsCw7hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028285; c=relaxed/simple;
	bh=gHycmTpFhFQMXDtIoNBrrQwCvsgIrqrqljjzJYf1P4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jCQ7o45COXKXj+3p3+b5gT2R6RQCldU/BD0ckiTlBwJxb/KGO85QR00TNCQRIjs3trJBXk9DhbxRBe8hN3A7WNXMUZ6Gk+FAAImqAMQIq/LRlves7eR3tOCsr9hn7zQmL7/ZWWEvHo8A66alOwGNBRy4GTNuE0Momy+m1bwFCjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hbccwess; arc=fail smtp.client-ip=40.107.159.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGWUJgm6co1rWyQbPCFk2myuinSCivjiWMFum4I+QwTlDMS7uVk3QWSgJdF8uRIhQxlMGkB8kR4R9mhg5Q1peOkwYsTiT5h04QeJ9GsiSpxLzMbbz3/zYpschqv/jmOCL/NrraWMiYZBvv0vOVyKt1kyj9l6VuNRAUFxpM1qTtPtHlLWtZySTTx5QA1G9NL3HcH4A7qZdb1DmUOGyvHRJdq3dOnJmgUbfr0bsIlAh5LmWqpzUs9ul2LisQsplyTc/JsUecH7EynuH7nWJjDCu63tHIAlPnqQ/UVXbGOaurk65H7JL5e1nwfc/xKspQs4Ek+u65mIPPZWx81h03upnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJlvia4hKSF+zZN5jjwNuYuxL1SPSWQM30qYj7SQ+rg=;
 b=tenXxZDyys7hO+AAo+z+Kbz6r7PwGd/iunD43NO9iPfRmy4VuC75np4cS/SNWV32pFo9502kGCunn2Up//AUeY+Bw9CbB8CgZ0N9uJW4eGjsuVD2C+mUAhnutSdRaOx+PIVKnPyK0XtHLfZ23aZXFpzhzSurQStWIpVSEi4FfWzuHgJHJPC9mS6wDAJ+cpNkXfILP1UImN94R+hrxbRJEeWFIUI1biOt/DWqobkisxTIwi6FnFCZTps5EoeiwaBbkqBXNPtTb+aiJzcTAJTlIzl+ZzPGCwGDHijzAIc72uy2DPCexl2SgecYzgE0pPf4+FlfrvsviTEYScI4tvJK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJlvia4hKSF+zZN5jjwNuYuxL1SPSWQM30qYj7SQ+rg=;
 b=Hbccwess3Ik8Nd8LEmDhBAXAx7/jI2YokOdHRGjrUmU3r5nj2phS8uEjnzePBY/aMhe5G9DqH7kT/XEaTDKbMGv4V3w7TZrcISj23dM8YOucwIQ1JrWiylUShYOJFyhz9S3ga9rMt292oSEhQtRcuK+bLKDUcPSI6qDfqz8ULfLUxoVxkFlfBvNnU6GZ7vTu95JW9rF89vnIn24syKxG6i531R4mUWiuVACbjyzDTcKwVRtsDaeO+Py0xNGgISMLJDFLbEhTfJK1FRJpvICh/7A1F+lVIOVgF2mTDa8YdDmyCOBs3z3oL4GAhp3feKkygTMt6jBqBmccgHr7yIHtxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10528.eurprd04.prod.outlook.com (2603:10a6:102:445::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 09:11:16 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 09:11:15 +0000
Date: Wed, 4 Jun 2025 12:11:11 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Wei Fang <wei.fang@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net] net: enetc: fix the netc-lib driver build dependency
Message-ID: <20250604091111.oo2o2xd2zeqqisaf@skbuf>
References: <20250603105056.4052084-1-wei.fang@nxp.com>
 <20250603204501.2lcszfoiy5svbw6s@skbuf>
 <PAXPR04MB85104C607BF23FFFD6663ABB886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <b2068b86-dcbb-4fee-b091-4910e975a9b9@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2068b86-dcbb-4fee-b091-4910e975a9b9@app.fastmail.com>
X-ClientProxiedBy: VI1P195CA0091.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::44) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10528:EE_
X-MS-Office365-Filtering-Correlation-Id: b03f4188-d01b-48bc-de2b-08dda347c1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xb2qyYMEQQpvZryaf5FGmgzERJ1p1Uv2HS3NOCmulrl4pztvjxJ1RciMzGP9?=
 =?us-ascii?Q?whSzY42Ntu8KRnbbzt1KxN6Odf8+lFTViOCY+zDDs1SFa1HxR3pbFZjuumHz?=
 =?us-ascii?Q?2omsYun+gFM/xqICjPcS7Ux0op/gVR5+06/tb/BnMcFXdJYTWvjJmozcWLvX?=
 =?us-ascii?Q?JxKVHWdY8ZviZymQVT6dlUqvoXQhOls1bWWoJB+ZkoU/o6z6EQk9mfFZf4Th?=
 =?us-ascii?Q?/gJPG0jwW4Z/1bUZm6EATlbRFVQQ76eDjmFnIVd0KL8YPgecMqtw952c0L5E?=
 =?us-ascii?Q?nV+TCeg2Oz5QNXMijiYJyH5ISFdH15FlSeH2ZHLf8ZWmt0rmz28wVwYgsv79?=
 =?us-ascii?Q?FBNngd9D2RsXcWrX+bhFm/EqNja3U/PJznh96i9SjS7OkG+V7DOdXyKpgH3n?=
 =?us-ascii?Q?9xp3hkF53RoQPs5N9F+sWB/C1HZWODEFK3UP+LT0N5As5lbzwvYCII1cTZev?=
 =?us-ascii?Q?RjxGg+R+qIvfWRdM7B7Mr9U7rGHWMhAJa25ILO6u36P7hoshztaP7eReFINl?=
 =?us-ascii?Q?bAAhR0k0v1GVYA2loCP7kvvj6+gTIyzR3QtA01mkFFaflONNq0SlWVFZ3Fwv?=
 =?us-ascii?Q?S3CVY303rpc0ac32yOe8zKhQwICR3BwZgQAgOQEwBacTjaJMzAIazfnbQ79D?=
 =?us-ascii?Q?pZX8r2p1UbytUc4j5jCPML5x1+wT3MShrjoeAC80J1A6lKrGp/dpRP36UxFH?=
 =?us-ascii?Q?ixGJNXr5wqT7pBLsBCinXoJ78W1Ati2WE2gyG5Xa5D/GpEqBahaHyhnwvhGg?=
 =?us-ascii?Q?XmLUieQZbz2EezEeY93GWBNg+M9Zv2XAr4Hk2IlNbpMs18BV0G3x1AAQkKoE?=
 =?us-ascii?Q?pUQRZJlueWRE1MyFmqmGjhfkoJEPBOVCWxVWfhPUN5u2Wb0D2RW43qpc8rVT?=
 =?us-ascii?Q?CClRPCCgvAOiQdlTKWpocZt832jYUFd7nwiqoe0IBJ/8pq6waH4jvH8CFcX5?=
 =?us-ascii?Q?v24RaB9WsxA33ivzsG3c0cy3RS0aBNjyd6jF6K1/Q7x33O2jHa9TLqC/3b2u?=
 =?us-ascii?Q?J1D3hNLhd7IK01XvOEkjHKZ86kmmDkhMXcZv33eojR/nLnjQxCcdTRuVcI/h?=
 =?us-ascii?Q?rA/qntjQsRAEYRxqulfy99JSwendE+2/XaUEoEHPM32JhEx/MeSvMK82akTa?=
 =?us-ascii?Q?Z98VoGDpgpzOEGHLitCgNTZ56RUjXEaBN5Eya1b/OoOU12elwCP9zm4KE5k5?=
 =?us-ascii?Q?tCvlQtsvqUZqh6q6Gg2+GXna3xjCLEzXmrTxlylu4YYoomS8Dkwe3NGAzL6w?=
 =?us-ascii?Q?N7V2T8FjxDxEP923j5EKQx1Lp0q6OUuo/aCjY9oOlFwBV1Wh5EwLgnyinIoN?=
 =?us-ascii?Q?rNhDU/QnFGbP45NNr5exGbQSBdIoLW6daadVS316iQo7PXRwEK8uu8UZGMuv?=
 =?us-ascii?Q?LrCY7wD5Rma+ySZEcrDxP2GW7z7I/hFpkaJAivj0YeCM/W7FmhnhdEXR2hn5?=
 =?us-ascii?Q?AyPimS181Eo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lbl54WVszFrw39mQgBm9bY+U5d9fz+JtUS/BId/gXAOq+T9JgZJm65+rN1ky?=
 =?us-ascii?Q?jTLDSC/Sqw5lgwtpDxcEXNd6a3M2FRRBRN1GRvc1U+wpCS6BBRQU9XgIxknv?=
 =?us-ascii?Q?URSclj0IAI3owPd7U+T5Zv0FXsHemhe6dqW1X/LW1wnTKUFDn6ONhsy3bOxM?=
 =?us-ascii?Q?gBtUIKtLtkpyeC1jTElBt0qratjGnRggVCcMLRDubDnAh4yBw+wZNvVYcsby?=
 =?us-ascii?Q?z1fTbMzkkV4IwPuZPbms8/pJBUmJ98zbZljy91ZVQGZ3PwZkCOwnViRkImSS?=
 =?us-ascii?Q?YSbpbzeaqL5Ts/pSeaClroVTaAc6ripjz5nU8peycDUkrLSXvcYsflT32ihF?=
 =?us-ascii?Q?MePzbeQ21Dn+F/oerlhTvCn3Os2Gx+2Q0w3pCXWnS4OSrid1tREPUhvTZXSX?=
 =?us-ascii?Q?am9LzQ8gdFC+cMjlZSjUF3I4ZD0fHb56NNDTHffND1oSEhxx81EtPTkaArCW?=
 =?us-ascii?Q?VlhoMf+xiK6I+nQp5aZBJ/DWuRMrNxCgz9kYd2kOsn/yVLIoyPvtoXFaPQdI?=
 =?us-ascii?Q?+poN4GIC9YyQpcxIoDTfF6daG3cPwHKrAGJad6aPmzuxOUch54ON8GupSWHd?=
 =?us-ascii?Q?O0HGepQf60w+DD+gTTAAc5dQdEWBOPDHmSplUdIiBf3H0/5Dydp82ZG0Vxjo?=
 =?us-ascii?Q?1CtrX33SyVEIMIKw9NYjm5MxrrQklM2qBzPQbQsxt7hCTXihecb9zAI/NKel?=
 =?us-ascii?Q?CV98s4A6ufgPm3nWBixme76T/191VcU6A0Mr9YYPvQC+W6aHs7iAK/QsbQgs?=
 =?us-ascii?Q?aIlkKv00ABwdaeyVofcigZVYzZDtc9DObFnij5lpL/BxLBP0EOEnj1V41lGN?=
 =?us-ascii?Q?yQTEWyTiMHiG5/aScWlt0O3zWX/6U3tCWUtMxp9e37lz11rtAPkfjokPUy1k?=
 =?us-ascii?Q?3Em62VUFq+XUV0RUMhuxz1rQxp5FM4pGLkzGTHxPtYgEVoakxxGpg0PE0NKG?=
 =?us-ascii?Q?qjyBv2dBmvF6B16HmoEpM7CyEuh3186+AKuelZOGLEOVTzMSQeKu59gGyP0N?=
 =?us-ascii?Q?t2cU2TFU+OwMSXCn6SP/ZKEN3YZzYRIdyXlY6ESASjaaDYRbymAN6bRKTVfc?=
 =?us-ascii?Q?fDbTRtrf5yxHPwIpdF1FuhfQBPYQmywjgxDXmQEkGQBSvmBEcaLbufxxBLrd?=
 =?us-ascii?Q?ZZQjKwz384GK063o3/twkbGUzMdiMdkswPSjrilSl49FK59lm+2J8uH0YJhS?=
 =?us-ascii?Q?YjWYYENyLTjNEtwgXhxJFNB6xaqUObitW3+Op6ELx7cS/10tMwDPSK7ijJQZ?=
 =?us-ascii?Q?0Y/jdGT+U3oLCgRzpfVQ5lnJCVbqgk4esrEQcTZGopGR+y6I6AMKo++IWQXB?=
 =?us-ascii?Q?kr+GCYlBO84E360a6UfkfKo7moyUjA5wmyqOQTondEzzzbgKwwy4lOpVtuG8?=
 =?us-ascii?Q?lmbW39AaIeAREjocSiQO1PMxD15/IhomvtE08yBwz0uZZdu+Rf0BrCskIM/0?=
 =?us-ascii?Q?ZMSsDwBcta458ekPB2P4sdNt80xDnFQFNkZBLA51y3y5E7oSpr80WU3RnVt7?=
 =?us-ascii?Q?rOeWolfj54c6dHGlqCuraevrPkRVV5QL8nyWbXrJ3yZ77KjIVO96XxBCfzCf?=
 =?us-ascii?Q?lTP95ic2DvHLvI7wYyyJSwdNO9JGyc2X7YNdXGmoKqAZAIIKv5poVr9L8VdT?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03f4188-d01b-48bc-de2b-08dda347c1d6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 09:11:14.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZsyCQ3f79pzuSvlUaPHSZO/nvjxJk7W8QN0jlEWarhGTsnC6gUaH8lLy4PBjfQPB4v+GEK8jwbHwXQvN4qrIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10528

On Wed, Jun 04, 2025 at 09:24:22AM +0200, Arnd Bergmann wrote:
> On Wed, Jun 4, 2025, at 04:44, Wei Fang wrote:
> >> Ok, so to summarize, you want nxp-netc-lib.ko to be separate from
> >> fsl-enetc-core.ko, because when you upstream the switch driver (also a
> >> consumer of ntmp.o), you want it to depend just on nxp-netc-lib.ko but
> >> not on the full fsl-enetc-core.ko.
> >> If the only reverse dependency of NXP_NETC_LIB, NXP_ENETC4, becomes m,
> >> then NXP_NETC_LIB also becomes m, but in reality, FSL_ENETC_CORE, via
> >> cbdr.o, still depends on symbols from NXP_NETC_LIB.
> >> 
> >> So you influence NXP_NETC_LIB to not become m when its only selecter is m,
> >> instead stay y.
> >> 
> >> Won't this need to change, and become even more complicated when
> >> NXP_NETC_LIB gains another selecter, the switch driver?
> >
> > The dependency needs to be updated as follows when switch driver is
> > added, to avoid the compilation errors.
> >
> > default y if FSL_ENETC_CORE=y && (NXP_ENETC4=m || NET_DSA_NETC_SWITCH=m)
> >
> >> 
> >> >  	help
> >> >  	  This module provides common functionalities for both ENETC and NETC
> >> >  	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common tc
> >> > --
> >> > 2.34.1
> >> >
> >> 
> >> What about this interpretation? cbdr.o uses symbols from NXP_NETC_LIB,
> >> so the Kconfig option controlling cbdr.o, aka FSL_ENETC_CORE, should
> >> select NXP_NETC_LIB. This solves the problem in a way which is more
> >> logical to me, and doesn't need to change when the switch is later added.
> >> 
> >
> > Yes, this is also a solution. I thought that LS1028A does not need the netc-lib
> > driver at all. Doing so will result in netc-lib being compiled on the LS1028A
> > platform, which may be unacceptable, so I did not do this. Since you think
> > this is better, I will apply this solution next. Thanks.
> 
> I think this version should work, and make logical sense:
> 
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config FSL_ENETC_CORE
>         tristate
> +       select NXP_NETC_LIB if NXP_ENETC_NTMP
>         help
>           This module supports common functionality between the PF and VF
>           drivers for the NXP ENETC controller.
> @@ -22,6 +23,9 @@ config NXP_NETC_LIB
>           Switch, such as NETC Table Management Protocol (NTMP) 2.0, common tc
>           flower and debugfs interfaces and so on.
>  
> +config NXP_ENETC_NTMP
> +       bool
> +
>  config FSL_ENETC
>         tristate "ENETC PF driver"
>         depends on PCI_MSI
> @@ -45,7 +49,7 @@ config NXP_ENETC4
>         select FSL_ENETC_CORE
>         select FSL_ENETC_MDIO
>         select NXP_ENETC_PF_COMMON
> -       select NXP_NETC_LIB
> +       select NXP_ENETC_NTMP
>         select PHYLINK
>         select DIMLIB
>         help
> 
> FSL_ENETC selects the feature it actually wants, and FSL_ENETC_CORE
> enables the module based on the set of features that are enabled.
> The switch module can then equally enable bool symbol. Not sure
> what the best name would be for that symbol, that depends on what
> you expect to get added to NXP_NETC_LIB.
> 
>      Arnd

Thanks, this seems to be the best proposal thus far. IMO it is also easy
to maintain and it also fully satisfies the imposed requirements. I checked
that when FSL_ENETC_CORE goes to m, NXP_NETC_LIB also goes to m, and
when it remains y, the latter also remains y. Note, FSL_ENETC_CORE only
goes to m when all its selecters are m. More importantly, when
NXP_ENETC4=n, NXP_NETC_LIB is also n. The drivers seem to build in all
cases.

Will you send a patch with this proposal, or should Wei do it with a
Suggested-by?

