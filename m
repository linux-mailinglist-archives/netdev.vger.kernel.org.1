Return-Path: <netdev+bounces-216536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BBFB3456A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84983AB6ED
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9102FB982;
	Mon, 25 Aug 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SOyQQBBC"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011032.outbound.protection.outlook.com [40.107.130.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6529D05;
	Mon, 25 Aug 2025 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135062; cv=fail; b=qkttGFwtbzr/5mNqXfWxefh3t7XyvT/QFu8ZHKY2ocJGrcff+efYfd0Qdwl68mn2X20OIbfzoWPyEUwzrEBuPFlF0x+px6YVSgLpXneXdm3kyGxV9W5jBhc/lGxmF7ou7wLwl46CnB/LZwAkQVM8TeXUZGFME9U1+cApj0GuT1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135062; c=relaxed/simple;
	bh=g95SCSkrqjgaslj4IoF3zhtRNNJbYSDZpaIAMVIGN40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t+cGQ1YQgrOVc4VAOV0p5wZYLI7yCram+ODr72/dlY8m5nvXLfs1OpOsOIDlFZdzWdxXmZiiuI0w6BPDtYXIhjn1fNuBQdJ8yeTf8wVzOJzCGSc7yjg+HyB9YDTrVnCyUQ1k1KK2K+hzw9V4qQsS6F2pf/bl3GvXL1O1dNw0GAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SOyQQBBC; arc=fail smtp.client-ip=40.107.130.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFoGwj5FFinmnwFQT3x8XVFsA/ZRf8nCS7UG7TCAyfAbXhlHel+thbo+sHQlbrClLNASMJqOCkNcDZwxrQVIge5vMDHJvX3dLUy3gfYrFfs2qHp5CimOw8bn5UnhdGDV81DM8toyeZZhJB6Dt83btDVCYwKSxBkoFUvxf4pfqKZLGUUukK3yoBO7rA64t1tcX41rvGV6TkF6Wx48rfdk9XwFX6suLtAH5EWNo/OxgFF5ALUJbJWWnaWZ8C3O+dWSJjXBS+SImGJ+AqzwQPazz3L6OaOcmZIAks1WBLV58AUfx89zarotDv/WhovIA27pjCI5nJlYDCQTplCK2DGO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g95SCSkrqjgaslj4IoF3zhtRNNJbYSDZpaIAMVIGN40=;
 b=SFD7DyJ4misHii+4oKqpGX+jBDOljza0RAd04f2wvPrXvc3wFg+5ji2U6wXjFcPGin3ZMDf7V6zKQ1Izduv0tQWNi577rawwypeZN9lv4z04YAHKDBHVN5MVVtkcEQu/hBVnx3kk20NZzMRStIUp39n00E2QulBbZpQy76nbTSG/OYroLOczk+gxeP9WF68ZMiRIse3QdXySbtZWz+0UZR6wogax9er9bm4pUNr464zpXi//rJfNysSwbw/gDOV+M8eCiJzW8oj7KPxdH4n4ooAlqpjKuR5Q+/w+5kaDE1EJhblBHBDGkYJLMGWK0hj0jwoJT9B5sN5dvhn/2ewTZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g95SCSkrqjgaslj4IoF3zhtRNNJbYSDZpaIAMVIGN40=;
 b=SOyQQBBCjbdrqIA3HJSn/ueD85LbvlPXfhPFTaSSFgRPbjw2W8NJj8CP66J+Tv8j6xJ7J349QQPoBnXhm/HZ88Y++rpag/dBMEjXO8Hvlz65LV6vlU6Xsve1Ab1dwFYqoXNwxE8gb0P3/e5xrzLn69OYibjHBuqPuxTkjmlmua0U5OgZOIXeAJ7lPLSPkPkjy5zn/pjENY4pwxzgA+MIgnbZwU72PCizK+ObY69K4rrOQPVuDmfVdxxq7t87pV5sYHYU74EdUNmtcz+t4HQiSq94kfq36kf8FFGzYA5DSDo+EOektRzEnAkHcMzGwuTYJxk8DwnSgPVSxN9y9Cm5xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GVXPR04MB9880.eurprd04.prod.outlook.com (2603:10a6:150:119::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 15:17:37 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 15:17:36 +0000
Date: Mon, 25 Aug 2025 11:17:27 -0400
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
Subject: Re: [PATCH v5 net-next 13/15] net: enetc: add PTP synchronization
 support for ENETC v4
Message-ID: <aKx+h+WEyjE23UwO@lizhi-Precision-Tower-5810>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
 <20250825041532.1067315-14-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825041532.1067315-14-wei.fang@nxp.com>
X-ClientProxiedBy: BY5PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:180::29) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GVXPR04MB9880:EE_
X-MS-Office365-Filtering-Correlation-Id: 824d7836-05b0-45be-56ea-08dde3ea8604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrw3KrTEuwqCZ59ObEf/q1/KRnrudKQB/kyI2S0Gsx+oyjQk9QsJMXMSDeNI?=
 =?us-ascii?Q?pP0NAFNMnja4v+l4WdXUy4C8AIFyhvd7Ky0Mn/ly47DdL9nBl54s6tLX00As?=
 =?us-ascii?Q?blc9zKDfKU0+uvX189x9iugRqZBYZX5ob2SEH2MvUrFF+4GAYsRc4xw8SQES?=
 =?us-ascii?Q?d1DBAzyNqFudb+mdBQ5g/jQlir5QkcFe5oU7H3dTMUWOMesiKUfXWbEvAnG1?=
 =?us-ascii?Q?jjXcj1+HznxewZZ5dPNwUHnnPouH9omAndlIsWFhqG58v6GpLzc/meSRLxl4?=
 =?us-ascii?Q?vYz6QLrnze/YAOwqHUBMbuot/O586W1juj0/lP1oDeyD7rYHLXnQxJ2b3hmN?=
 =?us-ascii?Q?qW365ks6DYIPJcoxCONebEbyOQlKeoZFZ6fhrWlAC3R/P2zcDZ3PUjZ1dySz?=
 =?us-ascii?Q?9XxlCy5q+9w57jJWlb3s4Ks7to3EIdSKM8dcbfpUQ9VDVvwwEz6kC0HEUCbu?=
 =?us-ascii?Q?OZJtZjZYfC4cFxdxt03r47819ZzwScF45vaNdr2frv1SKnajyUH0vv6advTL?=
 =?us-ascii?Q?8/d4Oi9zD6yHMMbtaMLzU71IXwbwWaY3ml4VAy6EviTVXMGRp3floVRYxGEY?=
 =?us-ascii?Q?1ZmxFNfBKHSOjqOOmL8LYtERR2k7GRKwJy/7PhmRHJKxByCRVq2I/5DC/wDd?=
 =?us-ascii?Q?acXRoq3xDp4xu+kzRES3/q5dOdyvl2raBnOCkKxah1rU9d36VAeFBHzzBp7j?=
 =?us-ascii?Q?DACAaJbDwj0gRuRVuVTAmJQ3Uyh3j78j+he8xydXylFi9v9LzRFH1DPpa68P?=
 =?us-ascii?Q?8ehxnhXk4HcOl/rX5XYQJ/mWMtpsHoUSey/3feZnzvPvA4MgTQY4BU2/26ni?=
 =?us-ascii?Q?xn4aPn2cHXaQb98plWGB7thLZ5ZrUMzdLE1Rz5jxdD8RpKQzk4R3IPeKawub?=
 =?us-ascii?Q?igNWSrdL52fo5k7e0SiDg3iSE3pScOzpGPSkoGjkv7izYYNjld/ORXQLzR+X?=
 =?us-ascii?Q?vgQaSDRG4qHjxHq6vilWDR8ARJTbDKBZKLZZ2bxIlBnzef9/9XLGI2eO82rS?=
 =?us-ascii?Q?IXy58uF3Qg5MVaGpdpCBBVJshFFz32Jilc6HpgOKzZKHfMG8Zh5f77OvvwvK?=
 =?us-ascii?Q?z7gMbNsqHHfq5uMmKXKlaRTDWzVDfAtKAHKHwKPXySkfLUbjtTaOwId5viuw?=
 =?us-ascii?Q?y94qzoiCCuW51Y4zKR3KM2/yAmL0fi8flrJ4+NrgNhR1PFt+KekAPqOEB57+?=
 =?us-ascii?Q?WcYaYQomiFIr4eukk7YtDajAKQWe9i4M218kk7g2m2gY7fdRxHlecEAF/lyg?=
 =?us-ascii?Q?tT5D2DfqkE3Q1t/wPilg9DLzX7x25eiKgtPAqaahQog0z2PVBc0KrPuPL2CZ?=
 =?us-ascii?Q?ivMS9ryzFFmlA2VwpojpbD1uahx3DbpzotwQcI58/YGBaj3xShtWVHyjL85t?=
 =?us-ascii?Q?hfPDsEo4Q0gA/0um4J+bdvqXqVmDHaxFixbexjerKtij+rdTJEwkbwuIoJXp?=
 =?us-ascii?Q?N42DEVtzU1tDP3CxieZgTxRaqAuwWiQlqOjb80++ItDo2dPfqdY6iQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ClTKfjzesW+x31PxjhPMqBHVb/GEJtShPeqkdatOsp4Pqscvbxwsnhj+Nv6O?=
 =?us-ascii?Q?G58S1QAoRlRJ8Jdv2CcfeNE8Hp3W16JmF1zhwT1jLTaENWrooJ7eMOWf2Woc?=
 =?us-ascii?Q?OMmmwWFnJPn8/Rzlh2Y7dbFQkefLQMBjJl8bur7rIiHpd0QTNn6y4N4iZGgo?=
 =?us-ascii?Q?Ybw6o69jsm1uWEaNTKwLSRRbfpvvUkcBHMuvGYVzkDUAcAEOljt7dqRIbVTj?=
 =?us-ascii?Q?7JQ0UbI1pIJHnNNc1/0+hwipfOWJmd+M+rmZeQa3+5s+KZbCPwO6m9AEwLtK?=
 =?us-ascii?Q?4prt+NsfDhW0jYKvuxBKExR3K20PUMfXhJJ16O2lI0Rqa7cFJXJ5H6JdiS2x?=
 =?us-ascii?Q?u4Mbxfiqr1a6sLAWK59G+IbXjcSrO4AmiQ9twOmHBYq1PDzMdgZ9o10CXfIE?=
 =?us-ascii?Q?tLNQIaXOYWhU5z7c7JzKsil9I3c8nVEm5gstrkFsV6HGWLgNWQjyzy4kkgJv?=
 =?us-ascii?Q?mKuvJyn/aYN4R773k3m3ogSruVue/50ErbVvSgxZyCybhQ1J/9193TIKr2RA?=
 =?us-ascii?Q?NvJymFfry+fCkWbu3BxnExK2hDi8DiiwULcgFeEr/IVUL/zEznhjyDo/rD0C?=
 =?us-ascii?Q?f6CPkqjAOp4JPTg2l71HxgW+yzIzFYNI/GZgTqpMv4yFOarZsbA2Yq1s9uJ7?=
 =?us-ascii?Q?O1VmEAaEuHWXbAu7Z9RbbHUowslcJ5BBaeEdFMZp3f75xBTFQLpmT1Vuu1ra?=
 =?us-ascii?Q?TjSebzw8YDd43oY/yJRNayPYJvMrvOCx1/1BXHnFiW5CxIlsXVXHuI5AS2Pk?=
 =?us-ascii?Q?2ximLFr5ErDMsbOjDEEDXSW5N2KEBawpt8zrPtP9xrmJ3oTBujIQnz3iDYDe?=
 =?us-ascii?Q?7EO980yBchmQpC5OK11GXRZdky4VFKU9zL+TJOmWs+wbwJnBC//bx4i+7S8P?=
 =?us-ascii?Q?GLDYZQ2pkTeswnvwI8JpITpORX3uYZMyJK/UyDWK8wViwJU/fouZF3JAxx6A?=
 =?us-ascii?Q?rAL+q4mBX9mn5RKD3K70EucKizVBff3evwG96vDYAOpOKhuwuOSvn2x7DMce?=
 =?us-ascii?Q?FtufrkmlzBT18/4LCGvBlHHVGI1nAASD8ry/LtSNbBfNa/aCx4HZkEx8xpJ1?=
 =?us-ascii?Q?JU2oQeycbwkHODGwhwb2rbtm+VR7OSaC16A6AVHgdVftaThNTrPAm0ebCMvf?=
 =?us-ascii?Q?e2n8177CYnYJNwW0mo5GpnhMlxznuBv8PNlDOYoQ4ofY7klfForIgUFJ5PeF?=
 =?us-ascii?Q?9oHd10D/1/c4OCabNiDDGdoVmhOf/tg56B3m6wn//xCKW1W6KAjscbiAy5A8?=
 =?us-ascii?Q?3hpiITWFJs0zaz227xaPQ+pQDXgqsiUd5cMwwVFKmhaeaVY5grT8QOeOMg+x?=
 =?us-ascii?Q?2vVz5TPEF0Bo+oQ037ttsAkN6ZM7a+G7QugFVsB7Ch1u2l33zf42ve2Uao55?=
 =?us-ascii?Q?LmrWMtCaURK9TDpVMzfoJv8PPERc+FIs0fPNzFBEzikQsQjMDhn+vDT4zidi?=
 =?us-ascii?Q?/MOKxbFxlN/oH9ijTM6PA21dxQepLGb1Q0gJOEMe2XmSC/jnjuUAZK5StHNw?=
 =?us-ascii?Q?0wUfECOmQG71r4fiF1V5R3IKCh2xzfmaBU1gzI3uk9DOZBTg3DT39Br/Z+SV?=
 =?us-ascii?Q?DaigZRZV9NO+A9j5BLg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824d7836-05b0-45be-56ea-08dde3ea8604
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:17:36.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V05oIjy2uf5mt5YY/AJRBigUN1E++wFw3rX+sSTpFkGlBYSjQlNpvm2Q+cwUcP79Bf2rYV5AkK3klZvxCIViMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9880

On Mon, Aug 25, 2025 at 12:15:30PM +0800, Wei Fang wrote:
> Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A),
> mainly as follows.
>
> 1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
> different from LS1028A. Therefore, enetc_get_ts_info() has been modified
> appropriately to be compatible with ENETC v1 and v4.
>
> 2. Move sync packet content modification before dma_map_single() to
> follow correct DMA usage process, even though the previous sequence
> worked due to hardware DMA-coherence support (LS1028A). But For i.MX95
> (ENETC v4), it does not support "dma-coherent", so this step is very
> necessary. Otherwise, the originTimestamp and correction fields of the
> sent packets will still be the values before the modification.
>

I think it is wonth to create seperate patch for it, put it before this
patch.

> 3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
> register offset, but also some register fields. Therefore, two helper
> functions are added, enetc_set_one_step_ts() for ENETC v1 and
> enetc4_set_one_step_ts() for ENETC v4.
>
> 4. Since the generic helper functions from ptp_clock are used to get
> the PHC index of the PTP clock, so FSL_ENETC_CORE depends on Kconfig
> symbol "PTP_1588_CLOCK_OPTIONAL". But FSL_ENETC_CORE can only be
> selected, so add the dependency to FSL_ENETC, FSL_ENETC_VF and
> NXP_ENETC4. Perhaps the best approach would be to change FSL_ENETC_CORE
> to a visible menu entry. Then make FSL_ENETC, FSL_ENETC_VF, and
> NXP_ENETC4 depend on it, but this is not the goal of this patch, so this
> may be changed in the future.

select PTP_1588_CLOCK_OPTIONAL in kconfig will simple this?

Frank
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v5 changes:
> Fix the typo in commit message, 'sysbol' -> 'symbol'
> v4 changes:
> 1. Remove enetc4_get_timer_pdev() and enetc4_get_default_timer_pdev(),
> and add enetc4_get_phc_index_by_pdev() and enetc4_get_phc_index().
> 2. Add "PTP_1588_CLOCK_OPTIONAL" dependency, and add the description
> of this modification to the commit message.
> v3 changes:
> 1. Change CONFIG_PTP_1588_CLOCK_NETC to CONFIG_PTP_NETC_V4_TIMER
> 2. Change "nxp,netc-timer" to "ptp-timer"
> v2 changes:
> 1. Move the definition of enetc_ptp_clock_is_enabled() to resolve build
> errors.
> 2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
> Timer.
> ---
...

> --
> 2.34.1
>

