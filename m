Return-Path: <netdev+bounces-233725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C30C1788B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA18B354AF6
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C66281504;
	Wed, 29 Oct 2025 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bLoh9fLu"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44227B4F9;
	Wed, 29 Oct 2025 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697601; cv=fail; b=J7u6qoE+9L5pA6c0OIBXLZdxzFTve1xKC0QKRjEj4En2E9eK26pE18WFHdEuFoW6HCrZqfp3rw5bEbpqytUSCCHd7Wpn90eBixAEfF+NsVRk+r/EF3wbojHLZhu3Ma9OzU6gsBGJ6wtzXCWzTWx8S5MudkhIvsdXg2rf76HpNhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697601; c=relaxed/simple;
	bh=qBVVd5dtSM4XHWpUJT0KbjY7ZGkAyEBPu0v4L2Xl6OY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DdReDf+OyBSA4SE64yPYMcAyeDVZsfFSlNJZeUAvkZuG1CGVVc1ZpvGxGme3dQbb2A4XlpGLZrLt8fTKNQ5oNgm2/EllwS39lNiv758HqtN9z+EH85eTCOR4ISqdLfKCU0r7gWhZ6CCVjEQ7YUiiIPeJZpe/psHtIRtQnd1ysNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bLoh9fLu; arc=fail smtp.client-ip=52.101.83.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meJYQlVodssvPl8TKItGzx7sfTgMJoO6s475kLP7Pho816bz6jMn5f9rhpmcpJDAHlSP8bAkIHaCUP0RFJpbsEDo9kNsUix4fbGGo6HRitUkAM0TJUbA2IaYB/hL4ITTnVwjSdaUWZ5FyhmFFcO1T5q2CrR71BAyIyHdw1JN/EPTpHcVhE3LllD69eFVSRVcCI4MlEaRhH6uSPR6qcPCGSgBDeR79aFzGrnqq70jxArzo7PrahlTROLRPcUO16sENvR1lOYVCvlKHPLyIG08GEpdJlKT9NY5uqPE5Qvckgc8HOpT11VJdCGdR1xhzJwR0Ru1ekhZldoqOf8LxB4lQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBVVd5dtSM4XHWpUJT0KbjY7ZGkAyEBPu0v4L2Xl6OY=;
 b=FWYgj/ggZ+5oICjlTMKNstlGDItI9la8bTWQHwZxpSzK9VnEQltO+TJAO8mplMUSuUC4wKApT0/Y3ScXdmyKdTaVcfjB+A34B/OE8sR194ElXbFfUPikvqYd41wc2N+Xt/DEIAuU4y0Ozjf9yaEkCaWMS4KmKwpPLu6L2QXuii253UlfVaCevZ7zfqo1T9SkaG3PdBH1Jg/fG2hOJ6OVvBGjsGfWWWXU5+pz1ja/mA2ieG0rkUssDV+dmADy7OrrOxkoWtiG/q3s1W031jueu14WS+EDLOOH2jtpmtl1PVCuifKC8zskIkoQo+CHfnIiSaNwF+vldMsSlxmiCdqheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBVVd5dtSM4XHWpUJT0KbjY7ZGkAyEBPu0v4L2Xl6OY=;
 b=bLoh9fLu1qq83l4TRjug8SU4uLShQbxSufheJRVpl2/0iB34HqNYNl0wOTMQuT+e/Yo9GZCyu77E73ZL4o3e4X33brP7e4g1uauiIdvhAci9eOLhJphoxaC3gjGeEGFA1CeS7H3/3BEAcsnN38Nm+wD4jxLnsWR0oavPaAR9qr2J6lspxl4NhqXEdTKP2Q7wu+DI3mr2PiSZldgfLol3LAAObsXRT2WJa75LYW3VCGeafM9q9E8RgiWpS91TcJ28VismqVLo5ZGvnfakJ8B8dpLwmviQ0xE4HQvFeZLmXdfZfy3N6PFiYQjHgKre1JFx2tdCgjuvAxa0hwfoLEoG0g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB9133.eurprd04.prod.outlook.com (2603:10a6:150:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 00:26:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 00:26:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 0/6] net: enetc: Add i.MX94 ENETC support
Thread-Topic: [PATCH v3 net-next 0/6] net: enetc: Add i.MX94 ENETC support
Thread-Index: AQHcRuZ0y9m5nB8EmkOfic9FRb60u7TYP5CAgAAC4oCAAAMAAIAAAUpA
Date: Wed, 29 Oct 2025 00:26:34 +0000
Message-ID:
 <PAXPR04MB85105CFFA6BBA48855CEF50E88FAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251027014503.176237-1-wei.fang@nxp.com>
	<20251028165757.3b7c2f96@kernel.org>
	<PAXPR04MB8510AC62551ABD89E75EB97188FAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20251028171900.5f0ba82c@kernel.org>
In-Reply-To: <20251028171900.5f0ba82c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB9133:EE_
x-ms-office365-filtering-correlation-id: bba07280-e75b-4bb7-f848-08de1681d0c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lvdL5RgK/ky4yjoilcserU/kd4+EdEInSRWjb7XujwhkqfzahZRaKMdoqrmW?=
 =?us-ascii?Q?pOTrhbh7p1yobNjW202dTZi3Cy5OhcaVdFVbSKhJLvrwI4f9AhQCJOiuvPJz?=
 =?us-ascii?Q?pX7Qs2CkrZTRVXmK3X0cHLE0MzeoxjRfHVzYbWLqkdc3B41KPzGtQLmuPUYW?=
 =?us-ascii?Q?1KrzpF92EPsdu1AQF/tXtezWpjhD1qslqIFQWmfpsqvCK2EkyXMAL4BHqFPr?=
 =?us-ascii?Q?ADYFwWSDO0XEOl6CvqJvFyq4LBz78dHuf9wWHicV9cwJBiNtciefy5HF2SO4?=
 =?us-ascii?Q?UhqKD1BI3MZXiULiuGjzT+0TYH609TuYnEHGfb1/av+RJCawMQ+g7MgcFg0H?=
 =?us-ascii?Q?HNpV2zmk5AFO1BmXgkfU4PDXCA6j/qMw94ZZPUHJRbA31MUvh2Hq99viD0Pj?=
 =?us-ascii?Q?tiOF46eAqumH4BilVJCVDGNyuVirBjX0Aa2cmMW2QdaL3gP7qEyyI7W98fMD?=
 =?us-ascii?Q?EThe8syqPAj3lYfCRwlwGP0fgiZvCdHmNBZ+Tjt6knO56q89BHtJM06JI3fr?=
 =?us-ascii?Q?+41HK5Z3wFfsU8X/T4zyBGOFsKSxGFf28+/un1LJwZsisCvay+cGaHQOyS7b?=
 =?us-ascii?Q?TirEMc2j+p/31P5Ir0d64sKwB57pdL5SjaYXY/apsCvo3lvVhwCstrU6p66E?=
 =?us-ascii?Q?P/9LBMbe3Scf2Ez4N//MW7p2jFdtp7nX4n2LqKKZoTQ5nFtqVk+G2xeyk/q3?=
 =?us-ascii?Q?FijQwwh3CNcqL1DPQKxJ5v+rQWSByHl0uP2/nIlDMMwX5Z/xbRiXpM83t3Jo?=
 =?us-ascii?Q?SzBy/byoX9dM3zHSBdNUZpl9UkfrWgN672/plEo4M2/nW41UsFYxGMoFq0A+?=
 =?us-ascii?Q?XAvVeufbxHpekOZysHAw6r/8/1XcaK99rNNrUs9+OPWa1SggjpK27Kvfk9Yv?=
 =?us-ascii?Q?+BwUjQz8Su/WDl/JLd7FSoSE5cI8p/jA++/XLC8mFrgRUX8MOOHdNMTP9Hm/?=
 =?us-ascii?Q?+zT4DYzXNl3K8JqAc+JnmpSWHO9tqmdLyrMDbFRgZeLBNd1EaLYD1IJ734n6?=
 =?us-ascii?Q?SdEXmGVDlYHv7/DzawMUoWKDi9x41D4xZojOz1v+EEbqkajRB39fLV5LlEHD?=
 =?us-ascii?Q?7lEdXDJUhnoAexdwsK32/WSyAXN9n4Itj+BfAdRi4UYH9n/cHqE78ixU5+nA?=
 =?us-ascii?Q?HDzsexlnLTRaIDX5aDW+waAGwT6Nmvuv9V/xV2FaNNiMuLU1JEHLQSUqCcyz?=
 =?us-ascii?Q?Uz/oe2+ieMBrjSjPt/FlmV4m7neN8mbvDsAlDrEtnCA8Le4XHm0VF2Lbqa01?=
 =?us-ascii?Q?e66QJc6RYm0zkohdJTx4d8Pe6fJwqiav8OwECZmklQFepIx6VswxHm1iXEF8?=
 =?us-ascii?Q?LJlmQGd8CBV/mugSqYrqmjcRZWssgaPhS0Y0gAJseIYJLrM0ZIVORlELNHcC?=
 =?us-ascii?Q?JGlZ7oQPxURG/DDU8FISt1wPbyGYrjQ0XfFIL3BHB1Ktx7tHC6D39sYyDlEU?=
 =?us-ascii?Q?Nd4OqXeizHp2BI8GGhIlxMRO2Sh//OnrrWdGorq0P9zQZAprhZ9mTWk2ax2J?=
 =?us-ascii?Q?KridJn9NGOEZcfzDqm78dx3ddD7Ag3oGv4CO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WXULmXH7+0bIdgOAoWlJVaxBFzj/cfUYczR3lZSFtaqIbFy2LNaaX+HOuO3l?=
 =?us-ascii?Q?8UIc3Q8vBCxk6gefjWeVGljzyglVWaGcaoB5/gwLMIqBO7XSMpn7Qm8YqtK2?=
 =?us-ascii?Q?bJjljDXgjMAN6BhxvrLX6MkjJ/7tLf4T3EbPJluhx3+/3OsgGtzir2bApnn8?=
 =?us-ascii?Q?HO57co/FZzRcAp0B75wsqpt3RJmMonyT4yCgjwzZ7p3w9JeWHRTgsgiJid1u?=
 =?us-ascii?Q?Y4SAXPX7N18Hbk33HWQucNWgCiDfy/vHlX+d4FqFvUkHtkbh/S0VNsqX8L7S?=
 =?us-ascii?Q?QcUrMyFklwkL+jhsncglWh1AMHyxcCQNnFa4OtQxmK6dC/1sVuAi9buoEaty?=
 =?us-ascii?Q?Zlzra48Eg+hJc/1IusyQVCwfvIpCWxW0n8Qdp3TzzsgyBnw4LN30UVdkBQAE?=
 =?us-ascii?Q?q+PAM1VAj2qDSz0rdfcdCcWNGkzrekalWwUZW8CltFpHzwAfEmfZ4btmU6C/?=
 =?us-ascii?Q?VChK47e8/sOJ0TFzVUSl5zg44Z4qpC+BzqKDRODhZeZZD4nstVzrQCD/ZWwN?=
 =?us-ascii?Q?MONdIotdSPb6kfa7R6FoGcfyHdaHCEGUDBt18R2a+8m+Ddm+TFuFTiDs5Wzs?=
 =?us-ascii?Q?xoA26BrqcXfG9Lmwsg2Gg4py594OhC7h1+dXgjdXApCDWiSgR320uxMJNV/y?=
 =?us-ascii?Q?2TZYs25Tw3dAQ4dnTBOEHlYyAMKs1rI4puASZSR8e+Z71INqq0RhYJQW2GJO?=
 =?us-ascii?Q?wXSH4N0XSVQVzqQ4p1jZ5Ybh9HR8VgIixtNxBZnBONSHj4qRdfnPRceJRZta?=
 =?us-ascii?Q?Q0Pw5f7x9ceGebZlaZUVvWEa29sGSv0/ZScSt1W/WFEeAxpe+hZRRSPIJ9+d?=
 =?us-ascii?Q?5AxAeqCmWGzm4gyuWsK5V2MMV8JHnsieT2dleGaIfc+3Ml0+2nd+G3g/SnX4?=
 =?us-ascii?Q?GTdFL1J+ejWEV5evx7G0uKDEa5yuQPTanDzSnTL4bAiYOFooCTu6cRN4x3fD?=
 =?us-ascii?Q?Y4qtLwJKEehKBYhcrTIKObMLVdAJLPwJ93xLpOtkGe/++i1OVVquFW5bEZCQ?=
 =?us-ascii?Q?+ocASxs2+buZLSfb7soMN0n1QR49fk/7QgfVWRbSHG0nrAGf8jAkpnabFSLC?=
 =?us-ascii?Q?caX9ZHgMWD/3uUAtbeBh+VuHhPeWzakdHs1d4yK0pVXvxzMqrqXmQ9RKjIEU?=
 =?us-ascii?Q?LG/gYy1oKWuVWuMCUpd3x8L6OdBvYgNBSwFeMZL1eOQAX2VcRaHEpbgQmTys?=
 =?us-ascii?Q?evCAXI5A5o+FfAItrZIqrMHtiw2I8uPGnpuG1Smf92TxeVEKLtQ2SpLfe67K?=
 =?us-ascii?Q?UvYWogncNNO+nqLxlRMg5fdl4xsL78TT4K1lJuMOXSZaRkUaxiYHJXWj8uzm?=
 =?us-ascii?Q?IT0T1RkPcAfPVs89z+ez2juiwG2eeiGjFf6frBee3qQJJt93dXL6NDkZPsJQ?=
 =?us-ascii?Q?NKSrm4RumKXLQVBNYeN+k8Z+c5WpGVZ9TYMvHs9Rsb3Ya86vwpSMx2DcqTJW?=
 =?us-ascii?Q?7fwVoAXOs65n/yOjY2SRSTD/K33ytyCXilUdDkyQ47t8ypZkm1KUdGwSg9+l?=
 =?us-ascii?Q?gE56BH0Zh+Q80+BO3UD37Ihjs3PYGKAaCXPh/IsJsvXXTXqHS4cYVgWkCP/V?=
 =?us-ascii?Q?UhBzzmKEBGxeqLw4cvA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba07280-e75b-4bb7-f848-08de1681d0c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 00:26:34.2161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xktKgsCkqWKBB6VuGF1evYzjn5bfBfht4PoQMMV5nyx4Bf6WyoD1Ddeh+3ENUwneDImwVSM6IiYsFJ8CLFbIEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9133

> On Wed, 29 Oct 2025 00:13:14 +0000 Wei Fang wrote:
> > > On Mon, 27 Oct 2025 09:44:57 +0800 Wei Fang wrote:
> > > > i.MX94 NETC has two kinds of ENETCs, one is the same as i.MX95, whi=
ch
> > > > can be used as a standalone network port. The other one is an inter=
nal
> > > > ENETC, it connects to the CPU port of NETC switch through the pseud=
o
> > > > MAC. Also, i.MX94 have multiple PTP Timers, which is different from
> > > > i.MX95. Any PTP Timer can be bound to a specified standalone ENETC =
by
> > > > the IERB ETBCR registers. Currently, this patch only add ENETC supp=
ort
> > > > and Timer support for i.MX94. The switch will be added by a separat=
e
> > > > patch set.
> > >
> > > Is there a reason to add the imx94 code after imx95?
> >
> > Actually, i.MX94 is the latest i.MX SoC, which is tapped out after
> > i.MX95 (about 1 year).
>=20
> I see, so there is some logic behind it.
>=20
> I'm not sure this will still be clear 10 years from now to the people
> who come after us. 1 year is not a long time. But up to you..

I think I can add this info in the commit message, so it will be more
clear to others.


