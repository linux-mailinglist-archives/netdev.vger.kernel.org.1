Return-Path: <netdev+bounces-240046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D16C6F9DF
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B9D9628F51
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0515365A01;
	Wed, 19 Nov 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bVPXP8IQ"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010062.outbound.protection.outlook.com [52.101.84.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03D363C44;
	Wed, 19 Nov 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565614; cv=fail; b=ajxnCNTzQL+kVZFEoWoFsXcDcB+/8aH297CuGPggotopxxJ1DfXHHRgICiS+jptbadXlKd9DWOGO8UJ6lHsN6OAk7l/k8RVcKdfdKdn8p2EEycR1vxcqzVGWAj/0BoBZIgw3Y24PjZ+xjbv4uVV2vIkb7TCXGY8wQqNiJlGunaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565614; c=relaxed/simple;
	bh=lNJ3VQLs7PwycGjf/CMHJYsDBy1GuLjGrPzgbf6GqhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MwMNpmBLfRkDVvcvJiPGggqLwNi4Y334/SR26GN526/KjbwM66sVkwEki3wWjXBR/ArQrStTDMFQ1Qa+6sCsV+fGXT6jdwb5SjFOiHPxh9zX9w1EuxaCCLTYkqXUMQBWGLkPJZrPOIbASwvc6Zw9XeGtITPkZeH90y6c0UHjHnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bVPXP8IQ; arc=fail smtp.client-ip=52.101.84.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9ucX9n1kgiysA/YD2USipKw6TBSRyRKso+eSPERVC/KEoHqPVO95WACi39T8kZrrj/7oJvRWuURh9ijt60RabwmIrh2SOUA3MBprh+Kbw9mgp91qkbvHpmnLKsI9/Gc2bni6/Ef3LUEadKZRVj6oTe7WYpntJA1eJ9wtcXxxMOvyKA7ADfNPzY9oEPs0dON/+AiauBuiADzFRqJ5nhLTELqLKAyJkXIwjYiXtTpLKQerTpGxi8FBw9sgTUPRwm/jNNLIA1l0QlqOI1QJAWom4kynZp9afiCE5BROjSR9WBWos1bXjdARKQulHgYr1KtboG8VNIPs9TZhwAvZ6BnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNJ3VQLs7PwycGjf/CMHJYsDBy1GuLjGrPzgbf6GqhU=;
 b=m39+i4J3GQB2dtQVwX87d5yZ5T1ER+VPxXDaEYIxfnJEosmvmOF56Lx/GbsfF4GOMJEqPhqvrR36TZP0EkP/Gmi5z+II9Uu+p1WwbOP6XeczW5PmCfpqctXou/klNvIfZmrynulAejZFRtiDfLMeqIyMV25Jw4FDVqhh6lukOU7cpwsIRmwUa4n+4lcY1EdSahLZyK2lYpTgm+q8T9xEMKqPEDGFQu/Cqi20jbtgc7Xf1ksDNYRyldW/dwv6WppBVPcPvTxFakPpcyLFmBreZ7o3mkXbgSTlSgIZ9cEHEYHzxKbjeTHRLQzOw3/KraP35n/p1IjRwuBNLU0KdbCttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNJ3VQLs7PwycGjf/CMHJYsDBy1GuLjGrPzgbf6GqhU=;
 b=bVPXP8IQUM663be0THGQIjBAIq4iVvcXDuK0imhXYKBBdDZpZKgv8mmeZLW2mRGhZyXsoRicqOm0sXIwQ1Ot4sWpU7wP5sndr8SSvEue3+UXOFFnloMW/STcbueZ0+q0FoGMgqdrGyPn2yAr8S6lRDugtcwnpFAk5TYK4ubnBY+qTtOyGckv1wRw6w2ZGk8K/usSj2UFSD9wbUFAUKBT+J4mS53Xaa3hIWN36PixXvEeTE+iHiyaV9i1EfVvQoTfur7sCckogtSm39I4Vzd/Zte503WqpvKfENNwsLKsC7HhdkYZaNyP785Vic7PRNEud7Fx0bzzFRpaHpEMt1KLTQ==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by GV4PR04MB11425.eurprd04.prod.outlook.com
 (2603:10a6:150:299::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Wed, 19 Nov
 2025 15:20:00 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 15:20:00 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Aziz Sellami <aziz.sellami@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 2/3] net: enetc: set external PHY address in
 IERB for i.MX94 ENETC
Thread-Topic: [PATCH v3 net-next 2/3] net: enetc: set external PHY address in
 IERB for i.MX94 ENETC
Thread-Index: AQHcWUIcMXVbSQiH00uAZ67yeoWNrbT6HHUQ
Date: Wed, 19 Nov 2025 15:20:00 +0000
Message-ID:
 <GV2PR04MB1174071C79AC14657B83E289696D7A@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20251119102557.1041881-1-wei.fang@nxp.com>
 <20251119102557.1041881-3-wei.fang@nxp.com>
In-Reply-To: <20251119102557.1041881-3-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|GV4PR04MB11425:EE_
x-ms-office365-filtering-correlation-id: fbe7c45d-d387-45f9-33e8-08de277f1b13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7/WlAtOkXlc0lQRD5QuWKWU/M3+/+jmx3B3yXqgMWcCi5IyxO255t9zRpcei?=
 =?us-ascii?Q?yaGWo/BCBwM6VbzgjW/xyVxriaJ1RGEWFe1U2u7jRe3hjmyNWKgITseqocsD?=
 =?us-ascii?Q?DYMV54fox2+pqbjLD/MmXokDYykK00ezZ9DsYZj+a7JhGa4pZXqmX+v9/8Vy?=
 =?us-ascii?Q?wDsKkMeEgrGMcdWhJYAPPon/Njlft2zzajTFkfN8c5QHP8/XYBJnXEfCxYn9?=
 =?us-ascii?Q?uO8wlELIeM4fnkf/piuvSXwHjHzvwTUaK+dDHOyhS5ZrwLBE2mvcZwj6rVAD?=
 =?us-ascii?Q?RvOI4AHzDI791WkLOABJx+yQfNGz/OljSTCr0qRh1x02ybqe44NtoA/KEh13?=
 =?us-ascii?Q?1yP85iLrkVHtdM9ja/8SI5XnDJGqzTiZDUzzJGncAAfwEev//MtJeV1W12Yo?=
 =?us-ascii?Q?xHOXP2mYELKCB48eaxoD+nKIwdNaSq5p0o+M6gN+QIIMAuMi38BLYFaTPugH?=
 =?us-ascii?Q?9H2fREKNCh6XpC5BAA8/TZbed7MBmHHGoHafe+pQaD467oKOno93WHYpfnlc?=
 =?us-ascii?Q?P89KdNOzbVDrSRAGQr3tv6AqEWJNhMil1USGgxeQcpU28mJz3nttsyORgAgj?=
 =?us-ascii?Q?j9Jmdw2zhNbsLK9Q+TsiHFi8SgrqlBalZ6ZMaSovbmTGASwtslS1lRAsMlp/?=
 =?us-ascii?Q?8ZAaVjTAMrhOi4lryAzkaTZOgf5nDb3vRHUe7tOhPYTBcKhelvzQeHtKD75Y?=
 =?us-ascii?Q?r96mnJrwux8PRf1f4GfiSWvgRcSKq0h9d/XEzXu2hWjiO2J4e6Uhz/VNzN0h?=
 =?us-ascii?Q?bNpdO4YR1jyE4CwA58YIy3FJDhnoYQqhdrW910xl2Z/hrsvAmg6+h3JLnyUv?=
 =?us-ascii?Q?j/MGvz4B9ldev+dxXaJTH1UCveIR53IIddWBYz/NBe628vgK+91EPzSJjS3W?=
 =?us-ascii?Q?/XkpHdTBFWdMAT93Ukl1D83CZucWeDObktCW6aXpTUQX2tyxYpu38EtGXEbt?=
 =?us-ascii?Q?ISEbvEluo6Nh03111vGdGnZ7AmDci093YU5wJE72V8mnFbu6q7hK45s9Wd4W?=
 =?us-ascii?Q?bg+/K4S6bfZt7ICcydcGPM5zx+yYhsKyo8X2Nk9dfsRoWQE4OmTCsxKav/hv?=
 =?us-ascii?Q?hQXFwLEPlyrzuw7YZjinHAeLkEdPsW7fccWHWnDUoN5F+0V+kCSUXKSkFirQ?=
 =?us-ascii?Q?vbSnJnflXFD6tiFF+AgGa+qRwDPEiRNCAjcQbZBo0Avaq5EwxQRkQWEqAf4j?=
 =?us-ascii?Q?PEmEgIx8hTlENaV3/gl+GEwzq5DfQZAaI5sYDQYrKWnQToVQMcNamQLsk1Fq?=
 =?us-ascii?Q?6hc2mA5yNCzXCnu+vWK+EmrCBJ1hY9wy1fvIZp+kCi+MNT8un2nb9PKUUD5K?=
 =?us-ascii?Q?O/pB0eYUAXAIWBfkyeT8LXraJd2oteLRDuXcq+RU5RlqVF2d6KmQiyI/h1j7?=
 =?us-ascii?Q?8d8VLL6cI/I6Kd1d3TMoqVbngtNVJfZbmK3eNjZUseB2e8kZ2Q6AkyEBdFhG?=
 =?us-ascii?Q?mYF6bjok/ZZfhp6GKhY4y5y4Sat+AJbEHX+4p67BkDUUMWLA4S5/Wx8l8sT6?=
 =?us-ascii?Q?6eHymvZ5p+Yycf7C4NM5uXRN41t+/18BAMOD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6ykpo8VOSOu00L+aEiscKasR4wk8iM66rLAtbzBHKCR8S6m+cdKlye81xM6u?=
 =?us-ascii?Q?52MaEYbKcGdbY0l7cc/7EkqzQS/W//Pt7VHg45Ka6gZabWkHlzepKNwOY70M?=
 =?us-ascii?Q?sumpnEVi58tCYO64ZGzU7ifa6GcT5Sh1BaG3TXaXaU97ubPEwmACX5vD8G2L?=
 =?us-ascii?Q?AHjL1r3XWFufl8LW/ljwL66Z76wkQjgrPS58hbIn3n4nTI9TomjPywpw+3oX?=
 =?us-ascii?Q?cZ6j1rWdYU/1l76Ht10cPEmdGwLY1xUnifU3bilw6tgETJGIb55yJhrZAVZN?=
 =?us-ascii?Q?zqv7jxQmAH/aYKr8/jJc1kzsZ90GXORdGO70m4Ua0gID0dWyrSC0p392OQeg?=
 =?us-ascii?Q?xMXTqtlYPIXMp69Ydqo/vIamDIjpNnNd1nwGA7dn1mf9iKlSLRiL7AjpGCAT?=
 =?us-ascii?Q?iEz7esak+CJYyuNIPsiJp8MYth0Lhqa3audMI2fbbhYfDg4NfFR8dTzgLvO6?=
 =?us-ascii?Q?tV8djTcOmax1ea4w3zKHoQUPCxMUvZJoWaLMrHaVW0SRthLkejxDhVLvy5tp?=
 =?us-ascii?Q?MidlR9uTzbtKEC/eQLcpowNWgUKN0moYS34RNWR4q4l1vTWlhN+k9Qh/NI8l?=
 =?us-ascii?Q?EgjbxMeRLlwwXQ8Xq4gZtpycLFS3ynv2wIrol3DMR5Q+LwnEJ1bOEHtMIPxW?=
 =?us-ascii?Q?/KBJgEgjyt1AqSpSMzl5z/HbEAppYLOFUBZX+uqRtThocvMzwV2fSMJ6Yzxv?=
 =?us-ascii?Q?Ig3ad+J3kChJtZs9Hk7beNPUCia/i6OnrdKeaqMCPJ/+EL/QYqGdcZbDvcWH?=
 =?us-ascii?Q?t6TG43r6Cy8MVES+bENMuhDJzl3m7WbpSZxHr9LZBK5d5Ty+KqIGzWkDr81v?=
 =?us-ascii?Q?faW6H4WHPUZ9JsOkJ8B8Fk4grzo9sUn0QNBNosxbfx6pXZPRP6hWII5mn//D?=
 =?us-ascii?Q?SeBlhOCzlbJETO6MH65fGzQ4CMSRnkTiqdex0ZT1iPXOirjLGV9x6/xFXyGD?=
 =?us-ascii?Q?rUZR3gIDKUwgKcuPMRZybOo40ocI2PshahDIm1ecDcCzseEz2kUqrWdUBz43?=
 =?us-ascii?Q?aHKBg7UJg7/ju1KFV+VntYNodH6ykWPTbFyw2LCRQm6cmNFIn0C0Km5+usDG?=
 =?us-ascii?Q?MbDjAMgWgb0FYeykGF7oAQro7nFhtA18UKiGWK6/cZ+Nllu9GRLixg8d55yL?=
 =?us-ascii?Q?Epm5/Vbtptm1+1QjSGqARHI9ykaUJnHufdAs0Z59lPdCYmd8D3tzuglTBrbz?=
 =?us-ascii?Q?atBiWorxjlQnkvTTR+NZSzfaaZjd5vt5zG8OuAOJGkvmpaf1zqcUbib8bt+L?=
 =?us-ascii?Q?OJVm4gk1w68gftSSCvqYuWEbVwk45G9vgBGhtbn7i3TsMpv/+BKtP7reug+a?=
 =?us-ascii?Q?XPmHncdX0GOhvS1bx0mcJh1H0nSYNUvWs/xWCylTD+F8XX3+CogG1/TX1RrE?=
 =?us-ascii?Q?KDNfanNKMutgEI8hfQ+g+2EMBt7thOh5qn/UqXsPBBKAXswvmMAsEGSK76JP?=
 =?us-ascii?Q?PKF3Ejlo/bdCnLJZhQnpICDiO81XK8kALng83WQLfhOZaqVEM/TWqKf2Jioj?=
 =?us-ascii?Q?0b+vhYUnz7mk8+RisZ1k62pbU2KmVu1FvHRuJ4lGtYnJTCgZ88JpTZbBtHiM?=
 =?us-ascii?Q?Cbkbc7pEpB9o1LiesUUK49kUpRLtS70T5RIv9an5?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe7c45d-d387-45f9-33e8-08de277f1b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:20:00.1706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8mHAyS1ZOaYJP3Qy9n+zVp3dbxyPOEa7CUTC8BjSkQj0uJeIB60Fq7r8SGs66AGcZ5QUJh1SuashYFS6Yz/Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11425

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Wednesday, November 19, 2025 12:26 PM
[...]
> Subject: [PATCH v3 net-next 2/3] net: enetc: set external PHY address in =
IERB
> for i.MX94 ENETC
>=20
> NETC IP has only one external master MDIO interface (eMDIO) for managing
> the external PHYs. ENETC can use the interfaces provided by the EMDIO
> function or its port MDIO to access and manage its external PHY. Both
> the EMDIO function and the port MDIO are all virtual ports of the eMDIO.
>=20
> The difference is that the EMDIO function is a 'global port', it can
> access all the PHYs on the eMDIO, but port MDIO can only access its own
> PHY. To ensure that ENETC can only access its own PHY through port MDIO,
> LaBCR[MDIO_PHYAD_PRTAD] needs to be set, which represents the address
> of
> the external PHY connected to ENETC. If the accessed PHY address is not
> consistent with LaBCR[MDIO_PHYAD_PRTAD], then the MDIO access initiated
> by port MDIO will be invalid.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

