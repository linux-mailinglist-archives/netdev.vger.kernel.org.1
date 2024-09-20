Return-Path: <netdev+bounces-129095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F8D97D6CF
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 16:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EE1283AE3
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E917BB12;
	Fri, 20 Sep 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WNJSatBK"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84F1E521
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842275; cv=fail; b=X+97eTPYdgqW7QJNdwjqGhrIgkk1UCCeFzNeQibTIfabIp/Lr2wbfLIV2exDCZIPt4u1ZFj4t8LOGtSW0dVbZLtIiv/EVs1DjtfXbQ5WlCWpb5KutfOb9R9HJRq7Ipp+FC+76XssrHzEAD9KqJyuD6txsP4OJvGBHP4JWNJoSY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842275; c=relaxed/simple;
	bh=NAdgXQWNhjcsNac9Ij/gka87fWn4h3MFTGucCILAKK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=msaIxoZkRtANpTjdifIwKg94Ha1K/7nnLiZc2uyWL5DrXfMlMxiRQT6yZvbMr7YXYbZR+OvbE59MiktY/G/V5DtqpcRm0qycpTC1VbbOdwvevsBb+KibLRWB3Jw39PBmT/oqykc8eTZe4iAZf9cfE5aK5c53tacj2+wuHWzsTXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WNJSatBK; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjATmFZiM+8+aCxPHi76h8IkvjCOQjKGoz6WZdzTjeqEZ/5LA+Hfn9CwgShesQ+CJW4oemgAbME8rahQrn49njQ4ttnzE4WbGSWM/c5OYmqoqjE/xrnCglEX8Rhp7ANPjVGmqySORNg/GFiPH1cqxoi6wrft+RckudrUjB0bRGx7UC6og/24MlVcm+gAxBRU0YFgKq0bPy2HdH0N9yCAeyTAZsiW6NyKxXDMVTaI8c77HAzvgab8hwC83f5JQ/SXHJLu+bQF4OoLbzvjUf9r0xfk4JKmPiIhb+eJAy6wEd4alpWzv3v0D2HByOC8VVCO7p92R9T5MyLuC85ms3q/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMwqE/Mipg5aIEYhyE+TNNI9bhuHM91/yes8kRcO1XI=;
 b=tNwUHCMHsw3vjtglPgCHGrRkYjD0ZPRa6zpCOmwHE5aONGihOS82YGiNIkyOeCTBN3TbOfR/AqNcMLB4rvlx5jbmLX8BFKCY8Xx2TsTs4qhCaWGWYCR0HZpwDutNq4RTXnN1aes7kaQO1vjHrlwsHQPxxO373A0+NMjQQHGev10aR5ju6snnNG0rQTtGjo2mYGF8R1PbQpz9z1zSOK6y4/zOB7WG7ilRY7d4MCoSiLFKhW8VroY03Q6X0lAxMLJP4+Mja5o1mU7RrhMvo8kEsXPMY2xPxzib0QZrdjkYF9So4fkoIAVSbEvB8Vj/Xwol3ckipskYC+sNgcGUOVEYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMwqE/Mipg5aIEYhyE+TNNI9bhuHM91/yes8kRcO1XI=;
 b=WNJSatBK1/4KSS+6bEeXrCCq8ZfUY+P7Qoy0BEJNEGxt4mY2o9SSuAcYgJpzQ/hMUYqWGttIAOzd/XInoWRkkZeDdothvLGsGELCeeZP+HB4ROUl7/gh2aLSFsZvzQmCRLGqmLfHmvPiG1NAWY+QymNXbMECA8gkqOFy/cTggIlSG4pTYG1SMtF4oGTPE7yilFGdiaH7TRCy2Om4mh1yC1UovhPazu4oY5Cd0EzFb4YImlonRwyFFfunfhqtHwBH6Vz5E2cLMAKiZEdwK9no19RRbeWu/4nE2v2ITlStmShA4ksZz2rGH3oRXayXrjrmXVrBJ8VIrtQAwkkADIa9lA==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GV1PR04MB10080.eurprd04.prod.outlook.com (2603:10a6:150:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 14:24:30 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%3]) with mapi id 15.20.7939.022; Fri, 20 Sep 2024
 14:24:30 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Ong Boon
 Leong <boon.leong.ong@intel.com>, Wong Vee Khee <vee.khee.wong@intel.com>,
	Chuah Kim Tatt <kim.tatt.chuah@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2 net] net: stmmac: dwmac4: extend timeout for VLAN Tag
 register busy bit check
Thread-Topic: [PATCH v2 net] net: stmmac: dwmac4: extend timeout for VLAN Tag
 register busy bit check
Thread-Index: AQHbC2jO9KJDjF2N0Uyx2zNbResNBA==
Date: Fri, 20 Sep 2024 14:24:29 +0000
Message-ID:
 <PAXPR04MB91856DCDAB12C39631542E33896C2@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20240918193452.417115-1-shenwei.wang@nxp.com>
 <2ca9a20c-59a9-4b95-bfe1-5729e2361d70@lunn.ch>
In-Reply-To: <2ca9a20c-59a9-4b95-bfe1-5729e2361d70@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|GV1PR04MB10080:EE_
x-ms-office365-filtering-correlation-id: e9aafccb-6cf1-416a-381a-08dcd97ff092
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rK2mw2Z3c4T/ujUqZ20GHTSIZKZaJJyUHFsA2jJTAja8qXyh5kR3xSl5h59z?=
 =?us-ascii?Q?6yrxoybGsRMeuaSqETu/vgKy3r/nFYLbeDoLsZF3a7mgl+amWAlW3tl/++h6?=
 =?us-ascii?Q?s3m1wlzTWX6lapBMp8SMX8ngUnbTNMRmL92ZOd5Ur4PVgfWfLW99bvEI6QFG?=
 =?us-ascii?Q?gdj6aFPdGMbnqvTahRqjeiTMx6BmdVDQTN1MRt6H/WBAbzZ8SYOM8Kn/+bZh?=
 =?us-ascii?Q?7lMKXKMDZet4RD2FY6M5twhCoBXVR6bnNXixZJR/lwX6vgvYcPC28FUec7WQ?=
 =?us-ascii?Q?KNXtJTTmAbRWivXslIIDWojqPVEdmmcJbvsDiwOJJ1tCERujvU+Jo6+LkBA/?=
 =?us-ascii?Q?A87HXjBIOs4j4jB3kGgahyfxObgB9ie/iuGZD0Xj7v0vpiQCzzMnhBN/drFj?=
 =?us-ascii?Q?/bnNxc3rRx18pnF8BLnw3ps2BxBV3oVWelBk8vt9aGrPmiltWU2bKiHS51Dx?=
 =?us-ascii?Q?CCD6C1eAOKx8c4ghxgDg3o+RyKUufwcf1gFJ5Kgu2vzNEgPoSgP0W6i257z/?=
 =?us-ascii?Q?VOof/BzsOnaxCiahnLoFj23Qzqg9Ir2BDncc+vEEp18wERFFrbHivC45HD3Q?=
 =?us-ascii?Q?zb2V9OeTMtYL282zWNWf6m1jdIiVfnrZ1jyQ910DTYEwRYp0c19AvCsZrFQe?=
 =?us-ascii?Q?E/zlE8Wz09u2S4FPPm2BOian9XtuqRST0ve+IM0GM2OmStcrR8MTYmAkIPUE?=
 =?us-ascii?Q?IBU0C1SzAfaDbpf9qGkOX251yVKINEyNvOVPMDF4aTqGuGJks+52M/OGHTUf?=
 =?us-ascii?Q?MMyvw5nWuamWgkiY87H7dwWmYvi+WwZlwFtxg7xkepaYGnepRncl2HUHeuZd?=
 =?us-ascii?Q?XfyJtMvyF5B0IgCedg9/vZJvxRWHsmwix4ZOqx/km4wtz2ACPKn4kfX7bQY7?=
 =?us-ascii?Q?o8huibjGi5Reo+eMq866//r3ikuPkqJg/ppCoiM3PFNsMorf/e+CEikFIXTl?=
 =?us-ascii?Q?ATT6H26l2GU03xfyzvfaMlG0kbEm8TUQuwrvcnpfexUemGmZiALYmwD25Fzz?=
 =?us-ascii?Q?mGs0SLbkxyGWewCNvShtPEtHBLb48zYXNdmGeTIesgmyuYzGrQleuHve1LV7?=
 =?us-ascii?Q?laInOQ6rD3QEsEOnUyfoGbNM7UrelHMe3CPsAwBdbQ/yqefUpXVagZ4zbPAZ?=
 =?us-ascii?Q?bXyvbPGjYJTBdo43o/VoRDurJKo7nTRPoZXw5ouGXGglJD3+fLVRJAS2qgP1?=
 =?us-ascii?Q?rOjOLNmRUTxAiLXnNQTJzgV2HBrOC59SlfG2s3PP82rdoqXa8YNlY9g6qj5l?=
 =?us-ascii?Q?KWYDYKMAJfTAcdnDTZVsh9lLYRGaJUeWQvp7g++9fcD9htbBYIERuK9hUg2Z?=
 =?us-ascii?Q?9WVvmMalwboWc4L6Gqc4Lr2p/Dz8jVow/n4QpHLlwzj4xA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IMfWdEhoawNxqSfHLhruzDWHC1rFzrlEFXnyW6yMbThN4QoNRKTcepCIr3gk?=
 =?us-ascii?Q?66cqZquTPyEGDNQdL2D23OpThP3cYF8iTSxK76pLjptlwF4lJXCNCb2iRJcd?=
 =?us-ascii?Q?c6ahCeKJX4OMQDa42Es3SzpUFGyz2o4ZFaI70Mrs5V8xC16Xz0onVxZYl3Cr?=
 =?us-ascii?Q?hs3GyvY5MTbYJJ0GAC4R1ZTpi8sL2EZXHHMzltQhhZaZZyWEpf5sioGPWZ/x?=
 =?us-ascii?Q?4sBF2hv8kv7sghZ3V2BpnjdjyTs7QYX5dCjPa4jhC5fR+hsLK49qVU9rry12?=
 =?us-ascii?Q?ZyBcHhtf0uJwB+SZDCzvAddKozum0AdsJcLGQI9J+SWTvHutXdJrdpWgb2Na?=
 =?us-ascii?Q?8vmXmIXu3Z0AEc88cB7PoCJGzMAbxDkXEzJrZMnR8bkQtkJoHwTFYzkzrb2w?=
 =?us-ascii?Q?Q7nH17OWcFTdVWxyielI7Mqto9HhZpISrCL4mIPlespe2nQZUBMk0AmE0HPl?=
 =?us-ascii?Q?T/cZJCnufLqyYLhAYTnc2+BG3cngyI95lp4IFC+OyGEbVXIcwuCv/jAIOCW7?=
 =?us-ascii?Q?7j8ZJE7qZqHRDj0hfSzoSe2lRf273ZvKtN+LLuCvrYyjEPEk2H9878DTWPSM?=
 =?us-ascii?Q?AcmJO1ZwGMySdDllOjqsCIvY7dDw747IT9bBlMBQWmXR6KaC24IvSfB6TB/B?=
 =?us-ascii?Q?l+CRzhSpdH12OtdoE/71t2bc6sdxCKJTRh127nfNWs+hMpKttLkowcKYKjA1?=
 =?us-ascii?Q?pU2dbnfBGGUve+v/MD8Lhd/78VGZhXGNyt2aJ0Zb81z+gtt8RyN9mMKXYmKl?=
 =?us-ascii?Q?73is9KyE0YzJLlsaKtL9ryhVXJ0WKnjqA0/7qzFmZzHb6kuqtU8Ey+PVjfpE?=
 =?us-ascii?Q?vqEOzgbwM82zlBiVT+0XgxZoQblC3uNMFPP+1qV04/knE9N045YBL7hibdm2?=
 =?us-ascii?Q?FzwIuzFa6a0BMifj7h/BUHXozgtizJoS/5EO/Xb+X5lo0TmOmkTAJD1cb4UV?=
 =?us-ascii?Q?+bCvsoZ+qaGBqEYh54/xUD4f1NpQ8KIWitJ7UdcC3cr0ooXSu5f7v4ZVp35T?=
 =?us-ascii?Q?+z+TMYftjhE1KbKZYykVis4RNiIi+fKB1DnxLQw+uWFC/4wtdKU2Rjgpms8d?=
 =?us-ascii?Q?tZ9UYuvXsfPTQuOIhI4BvwqMw/jm843hJYgtkAL0U+Qg0PEbm85bJ6GPyBu4?=
 =?us-ascii?Q?lfTTrVx3VDz0W1zoG1QCdzlY30MrfC2BAxTkfDxcqhyfuvZMTkDG3unGkHeY?=
 =?us-ascii?Q?EXzm0TbUjASmmKnoPnD0UusXGKJyPEJ+Y96B35RJdg5y/yqWyxLWnV8ivXOb?=
 =?us-ascii?Q?p0rx7kzsdDX0Cdo36vIFLPubhCpsepYgxkRO9NpgNbuxxDxnlD9PBZJ5lKZB?=
 =?us-ascii?Q?jSAh65xr81QFOtygJ7oC/z/6zE6S5bFeucoPvEyO8c8uddWu7WQU0D/XB25h?=
 =?us-ascii?Q?DhVifwj+zh92RUeDz7HG3OIE0MT4fJP6MTi4QSN892aehwWwTQNVI5zYe8r0?=
 =?us-ascii?Q?nhKmDAC0CflumLvg/xnsQ+ByBMZCDnao206zMZuLKmOOj5QM1zwtslEbbG1f?=
 =?us-ascii?Q?phXYMLn/XhIO+XeiPTm0RU0OfQkle5MoFJUlhTj1PPdMuIoOgJTAqhlknOxv?=
 =?us-ascii?Q?PjnZS+SqLIeF+AEh/QI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aafccb-6cf1-416a-381a-08dcd97ff092
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2024 14:24:29.9871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGFjTS33cJe60DdNKGztgvM39ho2xnwVqX//pOHU7njsNEh0NB852Hc496MbMsDqN8cvrcsoDwaxfV9+cS6uSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10080



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, September 18, 2024 6:58 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> horms@kernel.org; Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose
> Abreu <joabreu@synopsys.com>; Ong Boon Leong <boon.leong.ong@intel.com>;
> Wong Vee Khee <vee.khee.wong@intel.com>; Chuah Kim Tatt
> <kim.tatt.chuah@intel.com>; netdev@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> imx@lists.linux.dev; dl-linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH v2 net] net: stmmac: dwmac4: extend timeout for
> VLAN Tag register busy bit check
> > Overnight testing revealed that when EEE is active, the busy bit can
> > remain set for up to approximately 300ms. The new 500ms timeout
> > provides a safety margin.
>=20
> Do you know what EEE has to do with VLAN filtering?
>=20

The exact design details are not available to me, but my understanding is t=
hat the Busy Bit is synchronized to the RX clock=20
supplied by the PHY. When EEE is active and the PHY enters LPI state, the R=
X clock is gated, preventing updates to the Busy Bit.

The question is the significant delay observed, especially considering that=
 the PHY transitions between active and LPI states=20
multiple times during this period. There should have a lot of chances to up=
date the Busy Bit sooner when it is in the active state.

> Could there be other registers which suffer from the same problem?
>=20

So far I think it only impact the VLAN status register because those bits a=
re driven by another clock instead of CSR clock.
Based on current observations, it appears that this issue primarily affects=
 the VLAN status register. The reason for this=20
is that the bits in the VLAN status register are driven by a clock source d=
istinct from the CSR clock.

Regards,
Shenwei

>       Andrew


