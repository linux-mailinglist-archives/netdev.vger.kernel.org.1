Return-Path: <netdev+bounces-209079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873C1B0E372
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 20:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC80A3A8393
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E366828031C;
	Tue, 22 Jul 2025 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J+lQtlmh"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4820277814;
	Tue, 22 Jul 2025 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208742; cv=fail; b=SG0tEPq2g9MgcWLerQ8jlSUb0I32NcevtfKnvQvDsQqh+CGUiu5IW39xc/X3MddvnTjB5DABvDM5E0QNJXAnLFt5hkJ0n0ddpa8dwf+ILyoF/ePi1/z/NfxP5PRb1btV0C7OmddTT7/Bs8Op+hoO3sVEeXATVvmS0MyVJ6HTP18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208742; c=relaxed/simple;
	bh=U8IYJ5PgTudt/wREZy9Oy3Xpy7bJjti/pz/IMhiPANQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gBdyLLEAherQZmNJqL4vjhULERhR9Hx2mhF6Uka1B7oXWsBnyhtb6P0b2C3b71FdA/riAdkQfqtN5cgifJ3iunBthf1CAudg3kB5R7faE2snB09kEJ/nqT7KIsr0zy0+iSCb4kSQe40dYnElN78i7G7ykmMX+ReeyXGY27AaCoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J+lQtlmh; arc=fail smtp.client-ip=52.101.65.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1qogEADXa423yJmJPV9KRZ4ZzdBQpo9MfCd4k2U779KSsVbGkSE5NtwbQHEnACLuYzvAdAkqbHn9CTiBemXPkuqa2mI/wVn9dOY1xsudLrAI0i+YUZO9IFkdsmmenzFtkc3YMPIZZwputTzHUx4gtxCuINLeAKTOLd7MaxJq0epe9BURjX0iY19fQmlV7hqcoyrwEFZ787wdk+W51UFD8tRGE0rYna7+4WN4PrOPWAy6WG62ATHRYpNoly20kni1XoRV2F86M6Kog4NPaTzaXyj5wTb5DyvOsPneg6LrWY04a9VogmgNA2X31p2YEd5HAh6pbiZ15hs62Q1SExF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8IYJ5PgTudt/wREZy9Oy3Xpy7bJjti/pz/IMhiPANQ=;
 b=w1AqND63pcg4cXoFNCKbUYpFT0zBEt68AzgvIDjPZBJJJKZJru+3nBQRWZR9GKJjS9Qpf3RWGtCi5z7rRK2fdLX9btBGZgs+c6ouCi3ye/eaWDR0XpDBt1cTdHcAmUT2Kda6nJWb64NljateFBF/HsufO5zKFdME2hFCs7qUmB/g4BD5BpgIN+KibbH8EC0AsaR6OmNVYwcWacUxt4bzVpl9eD5e4ZCEJ6KKBBeeOpTbwcL2mNE5YTL1o61CASr0RsrtbN5Key4gzQSx2kHEvVqvE5oExnh5mnjU03jorKXwPfHHhv7kdnVKIUBiFxHA44v1jvVc7G2u2ID0eUF0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8IYJ5PgTudt/wREZy9Oy3Xpy7bJjti/pz/IMhiPANQ=;
 b=J+lQtlmhmiiP0TrtOMTbAdTeiTFKuwvgH7hkXTh3ljQUHEvQEz6eWBCFouveSzRfV7ewfhF9F25f71JsQaoeqqtBNRIZZLWApdyj1P2jE4cK9MX68mq3s6rGX4cYvfmcruKU+6hOVFF2kB9Cwcpj7+EUOBtvQDbDgNAKaNITlOAUdZa/bGJzDFvj9BKWNhEuucCU32fyBhPNlNavKOwZtou8kNw4S/3R45yh9Wzv/YDPew7hNEIErzDH4zaVvVfVbEFTvG2+qyG8BjvSTCsiA6xWtdlAG6jCyHteaNSuMTgOnS7Qsy3WvjS9o6omyhKZBCJJ7NnIVgmziux50TKumw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6785.eurprd04.prod.outlook.com (2603:10a6:208:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 18:25:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 18:25:38 +0000
Date: Tue, 22 Jul 2025 14:25:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <aH/Xm/TaJr0ZlvSw@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-2-wei.fang@nxp.com>
 <20250717-furry-hummingbird-of-growth-4f5f1d@kuoka>
 <PAXPR04MB8510F642E509E915B85062318851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717090547.f5c46ehp5rzey26b@skbuf>
 <PAXPR04MB851096B3E7F59181C7377A128851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717124241.f4jca65dswas6k47@skbuf>
 <aHkRbNu61h4tgByd@lizhi-Precision-Tower-5810>
 <20250722143638.av4nlnbqdhgueygx@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722143638.av4nlnbqdhgueygx@skbuf>
X-ClientProxiedBy: AM0PR01CA0126.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 50016bb9-c016-42b9-55e9-08ddc94d2821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ITpg2BOYptrvDzvd3wfnbHul66rbvA6GHgP2XzwZpLyDjnYEoFUWKFDkAhf?=
 =?us-ascii?Q?rPkMiNOM0X2Aw5W/tYD6XBtsX31GP76jZ7sUMOXcoV+TXmKsTlUowEOfgQ0+?=
 =?us-ascii?Q?dyxanaV05c4iNyljpMmUaiWqgtjA4wwfcV5HGlFh3vq9watIqoUpbBHwymgn?=
 =?us-ascii?Q?TtDvYdlgOmY18z3U/A6lPG6XbzbfOS569GqvaouxPJAOFMaVqj6AUox7pJVq?=
 =?us-ascii?Q?sgmsk/m5HYR0LZrZDHkL2AQgQxeCBVoYYBFkkTvR6qSTY04Ly2NNjKQFZAef?=
 =?us-ascii?Q?IKOPQmygmeCTN+qXloodEsIF53BuiFyA1drcCbdv8UHC5cJQtTOYTqhLG58K?=
 =?us-ascii?Q?rMWmgAypNrEDsD4qn/Lj37QGL7sLJSzNgfaZhfn8Yvim2TpTmIcDMR2S7k7n?=
 =?us-ascii?Q?UfjyvZ2fZ2AGeFBscvC4rXxDvOr1iUn2Fr7+e/khWyO1u6n5rW2HZSWyuoHG?=
 =?us-ascii?Q?HpZ3pFTco1jylurCxBsr7d+vzvQDfNMpb2mtn7BdIIeF4FGQuu3EPdjvztVd?=
 =?us-ascii?Q?n6ZvqvQGvYzyZY1UH2+2Hef5A8BZLc1cYxirIcuQBZAigV838/ArI9gFpcKS?=
 =?us-ascii?Q?u9+WlYoJFKlidM29AzoZrl2YjgnYxkW/KZOOJ8MOP9tj5MD3jZdZkuZw5yCv?=
 =?us-ascii?Q?UN7NVmlFNkukeiAI90A4PVZUK+8D/sq3bcvw6EuuntRsEqcYPhp4h9upE1ne?=
 =?us-ascii?Q?aWygjw0YXnHH2ujK4pUNMK9zvfM3GzjFTfzm1Fi4rpJxsKTGnff5D+gblGf9?=
 =?us-ascii?Q?E6wk/49r8yDLNwgfF/pSoOxP/ymG59/iZEo7mOva3lzd4j3HlcYJnb02Tlb6?=
 =?us-ascii?Q?eyGQi/KFzWzKlXLP79bhg0AiUSj9m5Nfo9VbHIib7/GEvrbyHQoYzdZHDLTE?=
 =?us-ascii?Q?WRn+lTzNDlg/DVdkFLFozad+8ZT14eECwY16+rnDmPQvpqGn1mwcgQPq1Xfa?=
 =?us-ascii?Q?Ncxf09VxdS9CwGtXle9WyM31Myf4F8drL68pk8LV7WiHO4YhS9fF+6J08KUF?=
 =?us-ascii?Q?8cHKRQBINp8YhjD062MWJ5LBGNCxNYx6FJxpVSt5n8dxGdakiEfZeqm2uGv/?=
 =?us-ascii?Q?z7BMnLO/DFlnARJBBghPNYM9Y6ScgXTx0YvYCzuMgJ9W/Bh76CkBWb3xxrwR?=
 =?us-ascii?Q?JUxWlwMQ4xeetzS1k1ff62/K0IOEp6pWMeXLsLJZp/urwSojlZehQYuyEVpl?=
 =?us-ascii?Q?W7DP3sZEJQH30oCdkgqWmdVl8lgcYR9KiUbd2SmIVZtmD06yi6vowv53r3Fz?=
 =?us-ascii?Q?BoALTgTHuaOpKpg3bCVePZad7RfMMZ8RTigKaduSqX+0vJLrkajGul5fXrFi?=
 =?us-ascii?Q?KtXixELAOoN6irimRzEi6i5h5VcfWGtMGwh8F7Yvlhycsfj9q6dq1UxO8uQc?=
 =?us-ascii?Q?zI1Cb99l54bWjyMAqxfhgJjWUKQKWrmrXmASDDsAfvfqmeSC+TJrGsHClwd9?=
 =?us-ascii?Q?bOwfzVWzOVtkwzRs1GjxP0ue0oO6IX9mvyCGi7TYbAfoXyNkZ4ock3sSUVjm?=
 =?us-ascii?Q?3oLVAutDKAvkO4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9z0n4kyoa9p3FH8MX2jNyQEysGDbejBCWaFvg+ytsMKLSP9eByPb9C/8uoLa?=
 =?us-ascii?Q?2oCFsGsPSJtzinN3S08s9eQNXw3fKptbRvvBMqgut0inufYaHzyZmjHTADxF?=
 =?us-ascii?Q?TcTliCpFw2IPnC420L+oczyFZNJrWmnzUGoq//XAn3NMbTXdFnQ4wu3NyIfG?=
 =?us-ascii?Q?d65743tgPuTvUt+TICmy3FYiq833R9iJ51TwFBzlhm8H157BU0kMKRvTlYq7?=
 =?us-ascii?Q?8nPCAEWFDvb2raHNu1FDkRtaFnJELIMJN0njasZi6/msqnJIBs1A2h/ALpS3?=
 =?us-ascii?Q?FhRioy+49ergTBuKliqaCq8yPtFLqy0GpCWklTowjHGu0Obw7jfFc79JqaxD?=
 =?us-ascii?Q?v3oHMU0RaeUjS+eKdJYRoo1KDtf3GKx/1TN0bSpi3Ab73qREV2BEBNwW87li?=
 =?us-ascii?Q?g/rKGSe2w4RaL4bPq5raZY0d6ORuZJHuQCWTUySbgs+R/eYgu5PqRl1eBjcn?=
 =?us-ascii?Q?MeQ2oVw7Pw4VwgEdT8mLSDCBYJ3I9YJCmn8kI2Tj3oM7I1Ou9FuJrj7tKZ1r?=
 =?us-ascii?Q?43Da+x2O63ve5vsuv2DkFVcd1CDs11xDP4qt8iWaT6KmwhETDIdHGEFNN9CC?=
 =?us-ascii?Q?u0qhmHmv9alTduBHSLEXTGy9NMOWfMePHk9daA+zTaAIFNQIZYWcsgWwaAzE?=
 =?us-ascii?Q?Rf9Vh9R9hbDmswnDXbeH/wyE7iTdSFc2k8xFNQ7tDjeGszghioQrihDJapH/?=
 =?us-ascii?Q?NKqmv6PJFnYUN3ISH7gTj3cD+s2WJSaYytwZ4U7wm4LAbix6AE94DhKmDJrh?=
 =?us-ascii?Q?2YlYZcOa3wNRtcaGXy5u+0XivmIC5suw34UnUUWe1Vq+VDKIdFut+0deztJZ?=
 =?us-ascii?Q?r6SEC35oDk/vmmMSFWecXwyJvmXKzVn4F8m5qQbn+jF0mVb3ZOV1VeAGC9uI?=
 =?us-ascii?Q?Hj8p24P9G/Pvdd9N3xK5N/v5+KcE5nrdLn7MIvVMy0j4PGBZIeVCEGli8EiZ?=
 =?us-ascii?Q?6tkt5VBBkWYA8ZRzniGQ0OJPAILUOhU2ir9JT+S3jdon/pba3hcIld15inWp?=
 =?us-ascii?Q?Ul07FIAcM6q5OLZvtN5PkJBSN3Qmy9qzPzJYQfpFzUplWyIvIYUKjMr9GhG3?=
 =?us-ascii?Q?eoxRWqDO++eAukDu2VUM/zNCfr7ftb0u3r0Xywy6euMN52+p2AKyE2pT0jDo?=
 =?us-ascii?Q?TgE49WztU9Ec/9wkWvZUNK8B6aH4wOPk52grNI7dG0qcuoLZ/fwpxOXtGNoU?=
 =?us-ascii?Q?MpNBk2CdL8+I+9naDc0Np9rIHHy7TLlTe6u4gAh93+3hQm2AxZVDhnoZe38J?=
 =?us-ascii?Q?CGsV13ADxwuxAWvv3wpA1DPp9BayZJKUiQWnYMiEaQpul6JkGSNV9m/ANFFQ?=
 =?us-ascii?Q?cAXD1uF1tKDon3srewZBA4OGA/QvmlOgSHsvTLdwXzBDSDngIHEbT4Cc2vs9?=
 =?us-ascii?Q?f+neMX/Q04KBpSCeD7vaH04COTY7Q1klOIH4E8ar08lypukJBAOYMTVG6tZX?=
 =?us-ascii?Q?Z51iuksKyVpTWflcodyecOsH2lIPw8b5bKrTcGV5KBfnmhBKdKDHvISI1ZrY?=
 =?us-ascii?Q?bOXW+2kE1m5+1vK22CX2WRBdyISX7o/aODLeKqvyxmg5vsWhjt8rI7AZajqy?=
 =?us-ascii?Q?OuUYloRPi9V65a8CVKdRHGrvcIaNf/QwSAyOp3sH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50016bb9-c016-42b9-55e9-08ddc94d2821
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 18:25:38.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+0eQwYrKSDeiBADp+zT3eV7j6R9YDjwxgeNLZdAtRRxIOqZoQKkGDVqk/P1dug/DEtoXcP8E5vpJw/EkeYfBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6785

On Tue, Jul 22, 2025 at 05:36:38PM +0300, Vladimir Oltean wrote:
> Hi Frank,
>
> On Thu, Jul 17, 2025 at 11:06:20AM -0400, Frank Li wrote:
> > On Thu, Jul 17, 2025 at 03:42:41PM +0300, Vladimir Oltean wrote:
> > > On Thu, Jul 17, 2025 at 12:55:27PM +0300, Wei Fang wrote:
> > > > > > "system" is the system clock of the NETC subsystem, we can explicitly specify
> > > > > > this clock as the PTP reference clock of the Timer in the DT node. Or do not
> > > > > > add clock properties to the DT node, it implicitly indicates that the reference
> > > > > > clock of the Timer is the "system" clock.
> > > > >
> > > > > It's unusual to name the clock after the source rather than after the
> > > > > destination. When "clock-names" takes any of the above 3 values, it's
> > > > > still the same single IP clock, just taken from 3 different sources.
> > > > >
> > > > > I see you need to update TMR_CTRL[CK_SEL] depending on where the IP
> > > > > clock is sourced from. You use the "clock-names" for that. Whereas the
> > > > > very similar ptp-qoriq uses a separate "fsl,cksel" property. Was that
> > > > > not an acceptable solution, do we need a new way of achieving the same
> > > > > thing?
> > > >
> > > > This an option, as I also mentioned in v1, either we have to parse the
> > > > clock-names or we need to add a new property.
> > >
> > > I think a new property like "fsl,cksel" is preferable, due to the
> > > arguments above: already used for ptp_qoriq, and the alternative of
> > > parsing the clock-names implies going against the established convention
> > > that the clock name should be from the perspective of this IP, not from
> > > the perspective of the provider.
> >
> > The similar problem already was discussed at
> > https://lore.kernel.org/imx/20250403103346.3064895-2-ciprianmarian.costea@oss.nxp.com/
> >
> > Actually there are clock mux inside IP, which have some inputs. Only one
> > was chosen. Rob prefer use clock-names to distingish which one is used.
> >
> > discuss thread in https://lore.kernel.org/imx/59261ba0-2086-4520-8429-6e3f08107077@oss.nxp.com/
> >
> > Frank
>
> Thanks for the reference. From the linked discussion you provided, I
> am not able to draw the conclusion "Rob prefers to use clock-names to
> distinguish which one is used". This seems to have been Ciprian Costea's
> preference, and Rob just stated "Really, you probably should [ list all
> possible clock sources ] no matter what, as you need to describe what's
> in the h/w, not configuration".
>
> Really, Rob just didn't object to the use of clock-names to identify the
> source, but I don't see him expressing a preference for it.

Thank you carefull read again. Previously there are many discussion about
clk-sel

https://lore.kernel.org/all/2d870984-fd5b-469b-8157-ca5ad52a0e01@oss.nxp.com/#t

It is quite common for device, which are mux inside IP. we can continue
to work with DT team to figure out direction if s32 rtc's method is not
good enough.

Frank

