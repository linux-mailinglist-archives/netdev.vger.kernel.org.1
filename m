Return-Path: <netdev+bounces-215093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AF5B2D18B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC401C22C73
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19727276045;
	Wed, 20 Aug 2025 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gU/EME4A"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17574317D;
	Wed, 20 Aug 2025 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755654419; cv=fail; b=dHJOEMj5PpOrZzY7X0ALy23II5sq5r3pB1XveNdiFFrPBAtiuIQKzaS0fADZd5qDXMNhEOHUyiti0XjK2v/tjIUELywJYd6+YWvMyb434AZNy84wbVW6LQG7XjmY5MhyEQa3aRwewlBoYfv3+1OK22wzJUzpj2yq4Hrhmm+qlEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755654419; c=relaxed/simple;
	bh=wFzWSP+qzIaWMpMPrDxeVJINSGWkzH/McHGpxMfR3Gk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sI3Za0TPTyiim1pSYXyc56c2xR+B21BUorna55y6gMpez7Oz2iYOBXzqMZTqsQucdaXvJ0VqubNfPGV7iMKxgaVaRcRGcucbefAiE1u7tE4UIe4jZbsM+oxaYyB0h+7ijWlpdKh39BKpSrR4h6EBf9bJFoVJpuZVZtH0qGuXsHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gU/EME4A; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDKsUjk3x6jugB1mDpNPEuoOsVcfRrdXQA9s1Xb/lYhE7fGNjYCtGvyT67KEL51pLcCvw+jAlqqvFaTbbQNFsM1iEASk+K2hkrMqH6+qXrUP+Ql7nLMfGem5yyv6/iZLPxOMh8meqY9usKqfkKxvexe+PX9jxH7v1S3qDl3tj/IgJXQ8RwLwboSfW/akwLLCJxi7QALt3/BHfh/Et0AEVlDce619+J0/nIvbXJSlypDyiYyT1Va2su+JxsEFxbyR5AF0kN6FSwBzgBT1++fnJuvSmwna1F4FPN3Yk3MqUqDo3OrMVwJSEIqJpvyiYHpmwHY/z1eIRUGoCqE5EYxrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8cKD6gXoTaq9pA5YbvcGBwGRZBFhDFtbE42zedFZfQ=;
 b=aSDwioSKAVos6YnlEhMBsjzPs/gUpkqgTJTYHhe39rLCdLRI745e/DLlEsbS0TMuD45XOGkb6KgEe97GTF9+u8GSM5gUN7JcFAX6FCrgC8VKDtrgQIb1AWfoELbUTTRd4jX1xhdr9vYmbVTEYZFhc33iMZyTd+GdxIMaAIvyOpn2tH6S1e7W+OqlpiUMSte7uWrT6ObZgHJbsrfZaf9gvJCDa+znn44wxrprlBsBGdJLxqf/GtodY9keVno9k78TGFfOgItlwdUJCiBB2bSPEm6BJmhWTLfBnBcOl7D6uUCSg7oV1GBQE7wcwxild0aN5PAS12YmTbwo75heMAzshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8cKD6gXoTaq9pA5YbvcGBwGRZBFhDFtbE42zedFZfQ=;
 b=gU/EME4AmdpBzs5//INwc5JdMo0qBxRNrE2ngoI/JhclpZkwT1xMic5l01OpeNvBrZKWo7aINtL+Tujjp8EsAgvK9BKuosB/qPRQAKXvR8v5YgSNKSgp4b7zsBenzzVjNn2Ts28wQBvABFjGs1FHg8VMiSt+Z7SmuDvp6KMQkLhX4OR3BpSCUOkq2Sjr3zXYE4jmv8mgzuGRsq5XQt6TLVB1zk+hG1y69EMNQD/GlQ0axALiU6m+j4ACiLFUy8nLH8Oyz98VnAy3/nwnO4fAWbRIl2tNycqtlkweYCtua938PdNysRDmd6GOlf8omQ49n1fRc4WOnXvGtJ0OMaNrjw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8620.eurprd04.prod.outlook.com (2603:10a6:20b:43b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 01:46:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Wed, 20 Aug 2025
 01:46:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "F.S.
 Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v4 net-next 13/15] net: enetc: add PTP synchronization
 support for ENETC v4
Thread-Topic: [PATCH v4 net-next 13/15] net: enetc: add PTP synchronization
 support for ENETC v4
Thread-Index: AQHcEQkhbqWyP+GLOU2FEaqlz9nmc7RqG1uAgACql+A=
Date: Wed, 20 Aug 2025 01:46:52 +0000
Message-ID:
 <PAXPR04MB85105F70285907766EA302508833A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-14-wei.fang@nxp.com>
 <aKSZdagM0mxKekP4@lizhi-Precision-Tower-5810>
In-Reply-To: <aKSZdagM0mxKekP4@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8620:EE_
x-ms-office365-filtering-correlation-id: 6a6b13ed-f50a-486d-2e62-08dddf8b6f90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LuI5ic5FPSjHwy8nGImUIc3bQWBRcJFHOxNfek3Qb/CpmD+D363qxMJYKJNW?=
 =?us-ascii?Q?Cg/bnf2DQih4MSpUwz0GcXwkCdfKTI1p5Mq+0YmteoGNkosE7h/WioQjsA/l?=
 =?us-ascii?Q?RgFsgIF4Ygei9CMyIGdtsR9z5LUPbhvD+4bq05MBEOzY5N526D9VB43S0q5Z?=
 =?us-ascii?Q?PPMEPlASiPnIS2/9VyGRRMyBNUtA3wv6ZLS4YEFlLV+ybf+/p1S7iJUYWKbR?=
 =?us-ascii?Q?dgoH/sUkk3JQoAnrcPs3W/WwpQcTcxHKkN/5pop74t/THQ74NDcrpttMuF4s?=
 =?us-ascii?Q?dt70Ae1NwNEB9a2ivBiGgUBm7wWZZG6so7TOKJ8UBj6MQ458YcAt80M9BHBu?=
 =?us-ascii?Q?7fvCZk/VefzQGaeuLhjBfxV5yl9uQdDqI0YTQknvlq5lWVHoReLmIz1x7Pgv?=
 =?us-ascii?Q?8kPraYBH2P/pEBRMCvSfe/nXpb+/pp6UKOpUs2jNr7j+UfIjD6Gm5dwG6HBY?=
 =?us-ascii?Q?r0cT/JIAWkDvA0UsBjOlVzkCrvjYSKRMv29kgtfnRnVupFi3p68TMSPj/Rtc?=
 =?us-ascii?Q?b9uJq0diEgfUd9Whp6ZsjqL8ZYQfg3IQQA/DCq3d+i097z1Qh+qw46uKP25c?=
 =?us-ascii?Q?PvW+8grSqq3QbyqT0uZjhLZK+1CzU3st+mqnsJBv62VI2FBHPtRGZ0AbRnMT?=
 =?us-ascii?Q?5TPLoVlKkX0dR2LyOqCEUZeXK+8Ymh0xn116RlTEUbxObZTs1jp+gpqsD2Au?=
 =?us-ascii?Q?X4xnuQQzvYrjmAHLqDvukr/y/+OkpvJceJQl98yxbQG4ouGm4UUK8amiQZbu?=
 =?us-ascii?Q?07PNdPkwrs172vp+QkKdrRh9YD4sn5TpQ/8zd5J6ZnNR+DCkv+wrj2FCvAeo?=
 =?us-ascii?Q?+ByNFw9lN/eIHWiA3v9JbkD8M3faPSn45s3PZKe1lLcNksxSwncrsdyZrtJQ?=
 =?us-ascii?Q?WQTUHtI6OWGZPwF/lfTV88L8jP/uq7wEMAQoajYf3QGvEorJsAEpgikldLsF?=
 =?us-ascii?Q?egub0v6vExXrukyg6os0WqYP6I8A5n5AW3t8+BZsiGHSTK+K5jKmRLw28P0j?=
 =?us-ascii?Q?6Ocvpg89Sb5av0urg6mJeMx/aEjpBlH1OByc2khkYlHqS/M6B+X+Mi3peys4?=
 =?us-ascii?Q?l87S0YcPNiBmkf4QxzhDUDUETufCpsXvMqt86P0j33AZ03aUq1mJFOfkaZCq?=
 =?us-ascii?Q?vkhOixdccosbjgyztVikQ+2xFP3ucgqWfz2z5ULWemS4g2GPeznF8Ly2Islr?=
 =?us-ascii?Q?DRT30M23VtOjEbr0GmTRfJyLMwYkFMhChPpxc9641ho7JrCF/4B2Pbj+C4yJ?=
 =?us-ascii?Q?tCOlZp1pZxp2NbjB8yNOcoun8QEh3kEHv04Ntnpn3ST8Ilzoey0S8q0W7gXc?=
 =?us-ascii?Q?yK/J0GXfuTRESY6NQXi+etBBDcUdzGYZxtrq02kpRlZ4hyJvxKHsnpcqHUAU?=
 =?us-ascii?Q?r+0iHoxBr/R9TuiYJkKC61I8zPW/h4+USczR4CI3Q3wpf59kP6gDSj5FD3Zq?=
 =?us-ascii?Q?AO7e4SAzR5Zm68mxrQZWNiMxMpt61b0HAvnxfbXl1vpHmiT9OdJbOg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GbLGnwDHJUFitnw/oKy/GfUGPAKDRsMYSauT7sMw6nMZs36Jmd8O6ItcY6yh?=
 =?us-ascii?Q?CbSQ6orcTVfu8ux5Gfq1h9iH/FPidSNQkhNQwaUKP+fxbp4y/oNNgrXTiiyT?=
 =?us-ascii?Q?M2DZ0T6emyR9BJWmgnyyOwbEZ3IK3y+0HRTYo+pdM7I1Lr0PkVtz8bGoovm9?=
 =?us-ascii?Q?aONpUO7gGUuC4kzFQJR+Cpgaz4BzXcME07Z099gY6VPjA8gu4T+zZRWqtKSR?=
 =?us-ascii?Q?s82uMuhNXi6HE1AmDdYqgVKLxsqGJ1JnUxxeAS3Wpccn0WYQQc4bV5Xo2YCu?=
 =?us-ascii?Q?jfEAWH7iQyRLSOi3p8k4EKUDTSX50hSVuQhkpAIoyYkWB35IATtyl4W2vdrH?=
 =?us-ascii?Q?gO+urrf4NbY1xzvkFdTyxA6gCCdp/ODFllmiGlbM1ipac73/ZA+mwIrrbn0b?=
 =?us-ascii?Q?hrJWqz0iDYybR1DjFOBNTRt55caN379Hl/G6+uCjWjgPpALB8wZM/nEhFwst?=
 =?us-ascii?Q?PCRMsLbFYhVNK93gG9PUPx0Jhox/25hklEm6i2gje5dvXdLU27VgdWWIRS6J?=
 =?us-ascii?Q?Hoh4kvGMPLQaksvjJd/Xi2iUxhQdqoAPA/1AEkXRYXMS/uEU59pOcSZllz0r?=
 =?us-ascii?Q?IfRVwkX8ue2JhJo29dp/A6XWOusRB7DgLj1jGoUWnYcWk2Yx0tPAKNduZcc4?=
 =?us-ascii?Q?fdOL5b6/Q1k6eNrFm8/X203wEwU/6CnUIO+D+hzX/Hg0ApqIUAQcqx1iAxcI?=
 =?us-ascii?Q?078XW2+n01kgBW+6xNLaJxlb9XNGZMezfF2fPaWmfOO4/1m20AFKNr7+MfXV?=
 =?us-ascii?Q?UpDiQT70Og5LJ9e/Ff2dznAqD/Txkm/NAJ7bkAUFbe9IYzmi8ALe1bvEfLDr?=
 =?us-ascii?Q?2lyAnntondLzyb8yeFfhslNAH7EwkT126lpDxME3yTZ6ffFTHhynjmWkdGv7?=
 =?us-ascii?Q?TaIFtR3lF0xpKqD8gUM12sx2ZASJboCPcxu71Fj1tB2KlvCQs+0yB4uXRCDT?=
 =?us-ascii?Q?YYbmp4R/VJJTyC6HKqbnEDmtJXy31SqkKfqjzLki/nSJHbrj7sUxV95H3t8s?=
 =?us-ascii?Q?7ef6ubKgt5do0FGa4Q2c0FarHECHsqaq5L1xJabCTCghEr9OcVmr8cBY2DYP?=
 =?us-ascii?Q?VFiR5bjhIzpLtxo+RBjrQCWLIpgd6jcgPussy5oDSVBX1nM/zVgATBTlq4Sr?=
 =?us-ascii?Q?JEuGXz8/iizp02EDqnlPpW9M2YLE0lchOc/0wnStO21I/iaz8gMeDZ7BihXR?=
 =?us-ascii?Q?Fvb0vCGSIgpBjL6JP5BW+hQiLA41SLQJ6gmT8byb8vP6D4++XWFdaMqXi2OZ?=
 =?us-ascii?Q?S0ozk0e2DXwjlNxDEcw7v/NXRjSk8iFrdqwmEezS4FEX6DhSC0ZoQs3fl/H6?=
 =?us-ascii?Q?jiWepoowsqxtSdJsyhkIiJgapBqte9D5H/a5YP0dgzuOJ7kXNiwZzRcGgzn4?=
 =?us-ascii?Q?aJsz2nyWh9ETUqiFgKWyO1rir1qN9fVJ7g9DuCqsJFBxLsboPAYqXISx6gKF?=
 =?us-ascii?Q?D0+2W4Cgr/8RS1M/O1rJa7k/uiuZQ0wsc5n/xUCeVPaEHF4UfwCrIlfhBe1z?=
 =?us-ascii?Q?OZh6E7kiLs1dr6F9IZF1XqZtb1tnVYJ5RAWTYaM8sQluh/aVIFNm1Bve370C?=
 =?us-ascii?Q?1vQne2SByoOHHjVR31I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6b13ed-f50a-486d-2e62-08dddf8b6f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 01:46:52.1108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OoTLJiZyGa38qqxs73tF0qEkMueS8lVaJfm/FfFY8exn/p3hFQoCqM2/6Kex4SdrvvdQHiS2OgJ8K+qtJn6O0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8620

> On Tue, Aug 19, 2025 at 08:36:18PM +0800, Wei Fang wrote:
> > Regarding PTP, ENETC v4 has some changes compared to ENETC v1
> > (LS1028A), mainly as follows.
> >
> > 1. ENETC v4 uses a different PTP driver, so the way to get phc_index
> > is different from LS1028A. Therefore, enetc_get_ts_info() has been
> > modified appropriately to be compatible with ENETC v1 and v4.
> >
> > 2. Move sync packet content modification before dma_map_single() to
> > follow correct DMA usage process, even though the previous sequence
> > worked due to hardware DMA-coherence support (LS1028A). But For i.MX95
> > (ENETC v4), it does not support "dma-coherent", so this step is very
> > necessary. Otherwise, the originTimestamp and correction fields of the
> > sent packets will still be the values before the modification.
> >
> > 3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
> > register offset, but also some register fields. Therefore, two helper
> > functions are added, enetc_set_one_step_ts() for ENETC v1 and
> > enetc4_set_one_step_ts() for ENETC v4.
> >
> > 4. Since the generic helper functions from ptp_clock are used to get
> > the PHC index of the PTP clock, so FSL_ENETC_CORE depends on Kconfig
> > sysbol "PTP_1588_CLOCK_OPTIONAL". But FSL_ENETC_CORE can only be
>=20
> symbol?
>=20
> run checkpatch --code-spell.
>=20

Oh, sorry, actually I have already added '--code-spell' to the git pre-comm=
it
script, but it didn't report this error. :(

I will fix this typo, thanks for catching this.

> > selected, so add the dependency to FSL_ENETC, FSL_ENETC_VF and
> > NXP_ENETC4. Perhaps the best approach would be to change
> > FSL_ENETC_CORE to a visible menu entry. Then make FSL_ENETC,
> > FSL_ENETC_VF, and
> > NXP_ENETC4 depend on it, but this is not the goal of this patch, so
> > this may be changed in the future.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> > ---
> > v2 changes:
> > 1. Move the definition of enetc_ptp_clock_is_enabled() to resolve
> > build errors.
> > 2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
> > Timer.
> > v3 changes:
> > 1. Change CONFIG_PTP_1588_CLOCK_NETC to CONFIG_PTP_NETC_V4_TIMER
> 2.
> > Change "nxp,netc-timer" to "ptp-timer"
> > v4 changes:
> > 1. Remove enetc4_get_timer_pdev() and enetc4_get_default_timer_pdev(),
> > and add enetc4_get_phc_index_by_pdev() and enetc4_get_phc_index().
> > 2. Add "PTP_1588_CLOCK_OPTIONAL" dependency, and add the description
> > of this modification to the commit message.
> > ---
> >  drivers/net/ethernet/freescale/enetc/Kconfig  |  3 +
> > drivers/net/ethernet/freescale/enetc/enetc.c  | 55 +++++++----
> > drivers/net/ethernet/freescale/enetc/enetc.h  |  8 ++
> > .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
> > .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
> > .../ethernet/freescale/enetc/enetc_ethtool.c  | 91 ++++++++++++++++---
> >  6 files changed, 137 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig
> > b/drivers/net/ethernet/freescale/enetc/Kconfig
> > index 54b0f0a5a6bb..117038104b69 100644
> > --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> > +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> > @@ -28,6 +28,7 @@ config NXP_NTMP
> >
> >  config FSL_ENETC
> >  	tristate "ENETC PF driver"
> > +	depends on PTP_1588_CLOCK_OPTIONAL
> >  	depends on PCI_MSI
> >  	select FSL_ENETC_CORE
> >  	select FSL_ENETC_IERB
> > @@ -45,6 +46,7 @@ config FSL_ENETC
> >
> >  config NXP_ENETC4
> >  	tristate "ENETC4 PF driver"
> > +	depends on PTP_1588_CLOCK_OPTIONAL
> >  	depends on PCI_MSI
> >  	select FSL_ENETC_CORE
> >  	select FSL_ENETC_MDIO
> > @@ -62,6 +64,7 @@ config NXP_ENETC4
> >
> >  config FSL_ENETC_VF
> >  	tristate "ENETC VF driver"
> > +	depends on PTP_1588_CLOCK_OPTIONAL
> >  	depends on PCI_MSI
> >  	select FSL_ENETC_CORE
> >  	select FSL_ENETC_MDIO
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 4325eb3d9481..6dbc9cc811a0 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct
> enetc_bdr *tx_ring, int count, int i)
> >  	}
> >  }
> >
> > +static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int
> > +offset) {
> > +	u32 val =3D ENETC_PM0_SINGLE_STEP_EN;
> > +
> > +	val |=3D ENETC_SET_SINGLE_STEP_OFFSET(offset);
> > +	if (udp)
> > +		val |=3D ENETC_PM0_SINGLE_STEP_CH;
> > +
> > +	/* The "Correction" field of a packet is updated based on the
> > +	 * current time and the timestamp provided
> > +	 */
> > +	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val); }
> > +
> > +static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int
> > +offset) {
> > +	u32 val =3D PM_SINGLE_STEP_EN;
> > +
> > +	val |=3D PM_SINGLE_STEP_OFFSET_SET(offset);
> > +	if (udp)
> > +		val |=3D PM_SINGLE_STEP_CH;
> > +
> > +	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val); }
> > +
> >  static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> >  				     struct sk_buff *skb)
> >  {
> > @@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct
> enetc_ndev_priv *priv,
> >  	u32 lo, hi, nsec;
> >  	u8 *data;
> >  	u64 sec;
> > -	u32 val;
> >
> >  	lo =3D enetc_rd_hot(hw, ENETC_SICTR0);
> >  	hi =3D enetc_rd_hot(hw, ENETC_SICTR1); @@ -279,12 +303,10 @@ static
> > u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> >  	*(__be32 *)(data + tstamp_off + 6) =3D new_nsec;
> >
> >  	/* Configure single-step register */
> > -	val =3D ENETC_PM0_SINGLE_STEP_EN;
> > -	val |=3D ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> > -	if (enetc_cb->udp)
> > -		val |=3D ENETC_PM0_SINGLE_STEP_CH;
> > -
> > -	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> > +	if (is_enetc_rev1(si))
> > +		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
> > +	else
> > +		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
> >
> >  	return lo & ENETC_TXBD_TSTAMP;
> >  }
> > @@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  	unsigned int f;
> >  	dma_addr_t dma;
> >  	u8 flags =3D 0;
> > +	u32 tstamp;
> >
> >  	enetc_clear_tx_bd(&temp_bd);
> >  	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) { @@ -327,6 +350,13 @@
> > static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff=
 *skb)
> >  		}
> >  	}
> >
> > +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> > +		do_onestep_tstamp =3D true;
> > +		tstamp =3D enetc_update_ptp_sync_msg(priv, skb);
> > +	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
> > +		do_twostep_tstamp =3D true;
> > +	}
> > +
> >  	i =3D tx_ring->next_to_use;
> >  	txbd =3D ENETC_TXBD(*tx_ring, i);
> >  	prefetchw(txbd);
> > @@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  	count++;
> >
> >  	do_vlan =3D skb_vlan_tag_present(skb);
> > -	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> > -		do_onestep_tstamp =3D true;
> > -	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
> > -		do_twostep_tstamp =3D true;
> > -
> >  	tx_swbd->do_twostep_tstamp =3D do_twostep_tstamp;
> >  	tx_swbd->qbv_en =3D !!(priv->active_offloads & ENETC_F_QBV);
> >  	tx_swbd->check_wb =3D tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
> > @@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  		}
> >
> >  		if (do_onestep_tstamp) {
> > -			u32 tstamp =3D enetc_update_ptp_sync_msg(priv, skb);
> > -
> >  			/* Configure extension BD */
> >  			temp_bd.ext.tstamp =3D cpu_to_le32(tstamp);
> >  			e_flags |=3D ENETC_TXBD_E_FLAGS_ONE_STEP_PTP; @@ -3314,7
> +3337,7 @@
> > int enetc_hwtstamp_set(struct net_device *ndev,
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >  	int err, new_offloads =3D priv->active_offloads;
> >
> > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> > +	if (!enetc_ptp_clock_is_enabled(priv->si))
> >  		return -EOPNOTSUPP;
> >
> >  	switch (config->tx_type) {
> > @@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
> > {
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >
> > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> > +	if (!enetc_ptp_clock_is_enabled(priv->si))
> >  		return -EOPNOTSUPP;
> >
> >  	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) diff
> > --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > index c65aa7b88122..815afdc2ec23 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > @@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct
> > enetc_si *si, int size,  void enetc_reset_ptcmsdur(struct enetc_hw
> > *hw);  void enetc_set_ptcmsdur(struct enetc_hw *hw, u32
> > *queue_max_sdu);
> >
> > +static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si) {
> > +	if (is_enetc_rev1(si))
> > +		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
> > +
> > +	return IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER);
> > +}
> > +
> >  #ifdef CONFIG_FSL_ENETC_QOS
> >  int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
> > int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > index aa25b445d301..a8113c9057eb 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > @@ -171,6 +171,12 @@
> >  /* Port MAC 0/1 Pause Quanta Threshold Register */
> >  #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
> >
> > +#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
> > +#define  PM_SINGLE_STEP_CH		BIT(6)
> > +#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
> > +#define   PM_SINGLE_STEP_OFFSET_SET(o)
> FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
> > +#define  PM_SINGLE_STEP_EN		BIT(31)
> > +
> >  /* Port MAC 0 Interface Mode Control Register */
> >  #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
> >  #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > index 38fb81db48c2..2e07b9b746e1 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > @@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops
> =3D {
> >  	.ndo_set_features	=3D enetc4_pf_set_features,
> >  	.ndo_vlan_rx_add_vid	=3D enetc_vlan_rx_add_vid,
> >  	.ndo_vlan_rx_kill_vid	=3D enetc_vlan_rx_del_vid,
> > +	.ndo_eth_ioctl		=3D enetc_ioctl,
> > +	.ndo_hwtstamp_get	=3D enetc_hwtstamp_get,
> > +	.ndo_hwtstamp_set	=3D enetc_hwtstamp_set,
> >  };
> >
> >  static struct phylink_pcs *
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > index 961e76cd8489..6215e9c68fc5 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > @@ -4,6 +4,9 @@
> >  #include <linux/ethtool_netlink.h>
> >  #include <linux/net_tstamp.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/ptp_clock_kernel.h>
> > +
> >  #include "enetc.h"
> >
> >  static const u32 enetc_si_regs[] =3D {
> > @@ -877,23 +880,54 @@ static int enetc_set_coalesce(struct net_device
> *ndev,
> >  	return 0;
> >  }
> >
> > -static int enetc_get_ts_info(struct net_device *ndev,
> > -			     struct kernel_ethtool_ts_info *info)
> > +static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
> >  {
> > -	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > -	int *phc_idx;
> > -
> > -	phc_idx =3D symbol_get(enetc_phc_index);
> > -	if (phc_idx) {
> > -		info->phc_index =3D *phc_idx;
> > -		symbol_put(enetc_phc_index);
> > +	struct pci_bus *bus =3D si->pdev->bus;
> > +	struct pci_dev *timer_pdev;
> > +	unsigned int devfn;
> > +	int phc_index;
> > +
> > +	switch (si->revision) {
> > +	case ENETC_REV_4_1:
> > +		devfn =3D PCI_DEVFN(24, 0);
> > +		break;
> > +	default:
> > +		return -1;
> >  	}
> >
> > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
> > -		info->so_timestamping =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> > +	timer_pdev =3D pci_get_slot(bus, devfn);
> > +	if (!timer_pdev)
> > +		return -1;
> >
> > -		return 0;
> > -	}
> > +	phc_index =3D ptp_clock_index_by_dev(&timer_pdev->dev);
> > +	pci_dev_put(timer_pdev);
> > +
> > +	return phc_index;
> > +}
> > +
> > +static int enetc4_get_phc_index(struct enetc_si *si) {
> > +	struct device_node *np =3D si->pdev->dev.of_node;
> > +	struct device_node *timer_np;
> > +	int phc_index;
> > +
> > +	if (!np)
> > +		return enetc4_get_phc_index_by_pdev(si);
> > +
> > +	timer_np =3D of_parse_phandle(np, "ptp-timer", 0);
> > +	if (!timer_np)
> > +		return enetc4_get_phc_index_by_pdev(si);
> > +
> > +	phc_index =3D ptp_clock_index_by_of_node(timer_np);
> > +	of_node_put(timer_np);
> > +
> > +	return phc_index;
> > +}
> > +
> > +static void enetc_get_ts_generic_info(struct net_device *ndev,
> > +				      struct kernel_ethtool_ts_info *info) {
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >
> >  	info->so_timestamping =3D SOF_TIMESTAMPING_TX_HARDWARE |
> >  				SOF_TIMESTAMPING_RX_HARDWARE |
> > @@ -908,6 +942,36 @@ static int enetc_get_ts_info(struct net_device
> > *ndev,
> >
> >  	info->rx_filters =3D (1 << HWTSTAMP_FILTER_NONE) |
> >  			   (1 << HWTSTAMP_FILTER_ALL);
> > +}
> > +
> > +static int enetc_get_ts_info(struct net_device *ndev,
> > +			     struct kernel_ethtool_ts_info *info) {
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > +	struct enetc_si *si =3D priv->si;
> > +	int *phc_idx;
> > +
> > +	if (!enetc_ptp_clock_is_enabled(si))
> > +		goto timestamp_tx_sw;
> > +
> > +	if (is_enetc_rev1(si)) {
> > +		phc_idx =3D symbol_get(enetc_phc_index);
> > +		if (phc_idx) {
> > +			info->phc_index =3D *phc_idx;
> > +			symbol_put(enetc_phc_index);
> > +		}
> > +	} else {
> > +		info->phc_index =3D enetc4_get_phc_index(si);
> > +		if (info->phc_index < 0)
> > +			goto timestamp_tx_sw;
> > +	}
> > +
> > +	enetc_get_ts_generic_info(ndev, info);
> > +
> > +	return 0;
> > +
> > +timestamp_tx_sw:
> > +	info->so_timestamping =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> >
> >  	return 0;
> >  }
> > @@ -1296,6 +1360,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops =
=3D {
> >  	.get_rxfh =3D enetc_get_rxfh,
> >  	.set_rxfh =3D enetc_set_rxfh,
> >  	.get_rxfh_fields =3D enetc_get_rxfh_fields,
> > +	.get_ts_info =3D enetc_get_ts_info,
> >  };
> >
> >  void enetc_set_ethtool_ops(struct net_device *ndev)
> > --
> > 2.34.1
> >

