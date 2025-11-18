Return-Path: <netdev+bounces-239322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE6C66E74
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B6C7D28B14
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D0431354C;
	Tue, 18 Nov 2025 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oRg2zVmL"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B2A309F1B;
	Tue, 18 Nov 2025 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431204; cv=fail; b=AXJ51kgINHUQfXt//RukyuF136PlETMmMP5cEQepQQGZOMqNL/UtbKzo6oPNx737mKEMAjSL9y5cWCZ6J3Q/ryYBQYTZJS1MhW0tmoL8RAfXOSSTcw3hF6B8HIE8r7nL4RK1rF8RYcF7eNR27O51HdFUAH0Vuk+Vo/hlz2G8ir4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431204; c=relaxed/simple;
	bh=L6xjFYB9DKo+O3CxVV7YUToxbVDvJY0BHnxN8F8nbaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kji2zgbLNhuaX/++rsvPkyJ7N7CLNoXLkVJTKzqSrutuLgjsJY9XeI80cXUjP3m6Yxu8qX2earpYCedl4O8W6KdAgr+m/bL89yKxvSGouAkWoeP0R/20zOBKfBUYB4B+C6gObAVJ2OLnS+wW4SCMc01qPi6sUhJw4aAautOB36s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oRg2zVmL; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZy7hAkd9vMtKWVqprTnd8ty39DV5Cgyua3KKz78olbHlL57glhrDH1TYAp1KiFECZTy5ff9buSSEhqjx++PdLSCl/WlWK/mhQaEko+79lrgRCGDGE6h58+mnJBu5treuNpwqgin3/V0AD4QNdsLD7SBIuthiBVz392cJjn0wB5Dp1C5FQxKeznl8DqBuL0lYItq2zeqMYUtFVrPDq2+cS2tI9AvZLPZsnXKttUCtgcqWq2EkfpYqRGrMeUQlTfxkY9+5UkGcPDNig7jFXf4dWeQfE0FCl9+J0u5xzUcGiY7Y5uBDKlYeMGPVeDG+9H/ssLFUKoaZIc3jUtQEVBwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6xjFYB9DKo+O3CxVV7YUToxbVDvJY0BHnxN8F8nbaA=;
 b=vVN9m0sDJlseBspJdnxZsD+2MxK4xgMIw2atpSwIl9EY5nPHb96JX4H84vIsDGvMc38uKr4VN9gwJbOr0TvMrxBQA4qJL2JiEBal4+BK9SAVAmN3mVhUWuBX4/0hmHFIQiQnTy5qDulQjj9oPLEx+qpNrJe3NHwtqlqN6NSVHFkUJYY64N4mjs9tSsOuCZ5G7kZUWE8eAEhDS8qoJiAuvTq9XzY2AaCEvO/2udVmPoEHQKtsIh+3QGnSpHnGyWrq18rLjDMoSxrZ5U7hQdYlfzQFkBPZrgiOm90kdOWtXSm1x5KQ5an+RaE1r3X+sGdtH8kNEuEGzZt5RV0avKlozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6xjFYB9DKo+O3CxVV7YUToxbVDvJY0BHnxN8F8nbaA=;
 b=oRg2zVmL2L6q/KAp7U4PbPQ3B6LLv7Pih9N3SFprEgE1/icWXuSX+kjJeK3Sdv/eRsJ8HRGg+hoXn5GGevlMNmc6RlIscyIL6UCZNwP1EVGyT6p+bsgxbH3NN5LU9yu9rKHtsTxodID0a1rp3ZcpiPTyrAZblt7bfeEYeZEONTadjZ5D/oIPx5dfD9gyktPhteeRu9s2+qfSmPlfNXNPn8sr7Vekstkt47AX/CewrWd2RZVIkn9mpa51d9Xi9naXxjRuJckPTdtxrdL3Bl4vZkWJ55sRhyQH62YRCS8mMZS1jdqVQFzeBWRDHMOcNcDAPWGyLeiVGAOIONszKHkxfg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB11939.eurprd04.prod.outlook.com (2603:10a6:800:307::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 01:59:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 01:59:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 3/5] net: fec: remove struct
 fec_enet_priv_txrx_info
Thread-Topic: [PATCH v2 net-next 3/5] net: fec: remove struct
 fec_enet_priv_txrx_info
Thread-Index: AQHcV6uToShlbgv+DUmh1R5cI5WIcrT3CeyAgACkr2A=
Date: Tue, 18 Nov 2025 01:59:57 +0000
Message-ID:
 <PAXPR04MB8510819C0031952B303F05D088D6A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251117101921.1862427-1-wei.fang@nxp.com>
 <20251117101921.1862427-4-wei.fang@nxp.com>
 <aRtI2/RuIaZaeChX@lizhi-Precision-Tower-5810>
In-Reply-To: <aRtI2/RuIaZaeChX@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB11939:EE_
x-ms-office365-filtering-correlation-id: c0faf426-dfcf-4faf-07ed-08de26462d0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T+GzekVFvHZRFsTYnzQaE6EW9ue985IlhQUzuFnoVzEzjrQN14tDvi44jAwp?=
 =?us-ascii?Q?UnMO6/UaKTFYS4pl1K7gOkal5AKMZOP3pV5otnG7e2UaViFwROPqvq/X8CGR?=
 =?us-ascii?Q?Fo591eCoTapeXyAYSyo/mWizUkb7UZfEhAVZ8hc0+3uUhg2eSt/d1X588HUK?=
 =?us-ascii?Q?938z6f8FgQ+wNlOUhPwkfcGjmxC57fgnsxnIRdut4x4b448HKvQxyyUOA+5G?=
 =?us-ascii?Q?hh21YcxBW+gk+htNuMe8YFLj0wcKTUO6YL0rAE8GPQRhBVlYF5mikFpBA1kZ?=
 =?us-ascii?Q?2BK0PXeXv5S5BgFgstZGNrAxn/zST1Pfh03erWmUp5buu4P3EjvjGfMOmAnz?=
 =?us-ascii?Q?6YT9l6zU92ZMNAdrEJe/akJKd95kTDuMVQB+aRa3eT4HP7lp1/LflYEyvsMe?=
 =?us-ascii?Q?/i6C9NfkP1o+n1WSclA5CkGk0a7JsyFQ2gyV2pFkudTNw7jx0JewmgOdeeAt?=
 =?us-ascii?Q?uByZdTkxdFdrTcEsTAr5f4ivIU1H651vwi9+G5E3YB92zneaWXocaS0Gn2eh?=
 =?us-ascii?Q?dWf8fatvwiHhYsP8dwPAMXkQ+0HxlzwKD7xDX2LZjRS8QvMgBch3+RGnOU7P?=
 =?us-ascii?Q?Co8WjmPKk0hG/RGTop5/ODqhj8k4zN/LfbOCY5+z+8p/RqDq4g4cmty08nyT?=
 =?us-ascii?Q?Ks0bDXdw8R6uaUIVTAYmNx7zuXMmWrsjchQe6RRtffC4ZhnZyBbnsOcZpnZn?=
 =?us-ascii?Q?VFkJFG9pJt3JG6Vp3VNjcQzze3j4uzf0GXM47Q3GHO5cFZUXrfQlCZqt4bQW?=
 =?us-ascii?Q?RWsuufyEeAlxGm7EqGBBvcBmx6lnsKwUzc8n3pDTh1n+BRLin+Ly7/nmSJwm?=
 =?us-ascii?Q?bE7q3/RuZ7Y+09mWI36A8zuT3rLY+u6q/0fuVULuJ4e24WEH5cIxpfSL6I9c?=
 =?us-ascii?Q?MvFLddkqSd/rloNNWdEQb7cg50PRzmOEaruXFfoGF0WDvOlO8pTTC2Grr8GI?=
 =?us-ascii?Q?F/NkXJkMKyFLv3+SvkGWXQi1rohF6ltr6WwSDjY041LfMzUavI3+2ZcVQj47?=
 =?us-ascii?Q?4jog5tD8L34Cy3sf3guO16F0gplMEOqE3kgYDaNaXJrk9qmFaCeexy53EAgV?=
 =?us-ascii?Q?qSuA1fWNv2f2uirlEqdhxlBRJyLhDIgl8nM7TgOV1xPU6iRaRfDIjyiD8g3G?=
 =?us-ascii?Q?zEIjV7yTg+XYBnv2XF+LTAkxP+DXiW3/V1+ou4S1whBFsr8aPUTAvwOXpNzl?=
 =?us-ascii?Q?qlPN9vdCtGLci0v8DShiG3IO2QOk+mlRBnYcQ+lO2VcrGfqcNGXkNqpvePEz?=
 =?us-ascii?Q?yylj66KVH2gIMZK7O8AHnqOUUMdvDvb0BHjSt2XTpnkjyiSxSZ31b38J3ubu?=
 =?us-ascii?Q?qsfMiBCiR6eU8mqe/L7D6+sTq/rzHbCr5yJggyRrb4uySHBipUCAtjzjWEFL?=
 =?us-ascii?Q?0RBrm2bzn6sjn45sgA/lkZd+s8WyRAOn7QMof91/qSI8ZpDYbmUE5PUPg4mS?=
 =?us-ascii?Q?S/EeLcXuqRMr68ErZkSuL/BbARzgUTMyXo0QfvigXDxLUj4QzCXx6i/C/ZAZ?=
 =?us-ascii?Q?oqU8EjtffdkRrrHEYnSg4jTaw7CBMjcwZbzl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n84Yb8Ku3nU+jLLLChtrXNAr12/k3e5YMsJKKWbiOq0reQU0bKzxseoWFNax?=
 =?us-ascii?Q?LyEU81YPRh4HM9jpXb1J+CAUdInNgHZjjdOJG1hcShhVKkh++R2d17UJq7cA?=
 =?us-ascii?Q?//qaAD6XuO4jsm8C4a3zhknlEx4wvhVSHuVjJm+A4F1MzyFgH7vjGRTQkrk6?=
 =?us-ascii?Q?cdCm5kmtCoixEFjeznIELhP1UCDV2vOKdDMfw+Y/kTACc4KtsHv+pzUW1Zt0?=
 =?us-ascii?Q?LU0mTRl7h0/uMyjxST4x2oLPd3SCuwQNreO1FUuPgkCllDF75Bz1X8qqgmv0?=
 =?us-ascii?Q?2eygRFstZqqBu5j8+Ad4+Bh/foSCzd5BjJnpLqXdyqJ6C31mWopVdIRp5D3g?=
 =?us-ascii?Q?kBf7QQzPRksUqr00AIKQ3U6eW/X97MbNS+SxQkgEY7csBG/GmW0/63tLn/2j?=
 =?us-ascii?Q?oTVpojWw2PNJrW+XdDfUfJOHfSxsAh3RABrPeFLSF0oqPoTXYAokv8zt/fn5?=
 =?us-ascii?Q?bHVu9BwcOhqcrk+MADYrVLSGZ4KWiN9n3v2iS/tKxXIwbLMlekgoPB08JjEt?=
 =?us-ascii?Q?lbGlhV5tckg3lKcSZtXjy/glvuWPZtUryKL22MZBP4+4FrqPRNmqeBHCqa8L?=
 =?us-ascii?Q?NODuaSEX0oBKSD24h1ABK46qcznbId8nufEQj4om3icfOi48/Akujh/0jMzm?=
 =?us-ascii?Q?sQt13WJz3yN8PhwSXq2h888NmvmIIkIVWPurdoQnTW/ayy10lw5Dg7qXykg7?=
 =?us-ascii?Q?QCxkb1q1SoFcHGjmcsVCCrCZCFfLHWooB2TZh1Bm5xd8Rh0u8mbBOm7Br/ho?=
 =?us-ascii?Q?tawtp77VZmg2Q6Jd5tJx1paoB28oa6C9K/awFMUBVdCeo0VRNWJwl3NA4vaS?=
 =?us-ascii?Q?g9Yxwcgd/2r8JEz7+l/DyAPbbD+Bv8CApTB8mj6jqVUAzJ84Tz0uQBAvjmIu?=
 =?us-ascii?Q?lupk62kfDxmWs9zfD9ZrVnK2h2U+gjn4UkIszseOnxdxtp9DoT4R1Tf9SaMb?=
 =?us-ascii?Q?PT8uzJzxfWq0SGUHuG+2gbaUrhOVyvQsH5HyfjhEroTNjSCAZ+eq0NQ8low7?=
 =?us-ascii?Q?93zkjYCtDe9R+lGE1QmVsjmAn6fH1wFkLM88aZ/p4SJAZQwOr5oabLIGQvQ3?=
 =?us-ascii?Q?fKYxoxE5nSSvagRq0uEXYY5EkK+jD5lkFWdSo8Z5mgya09p9tZrQLDVpT2v3?=
 =?us-ascii?Q?BUhOIAHXbnw72LMqJ//IfbxIVolwad76J0Ol8WlEM/EMZJDTDdzLEDG6SbUO?=
 =?us-ascii?Q?rLKDsswDuX8+4ZRjZ60jFMefWnL1Hpr9yEN95L5067AVmW2KMdCQ8BdHfMoF?=
 =?us-ascii?Q?dZHQ3iEvrsTanLigNrF3vyLotrgdn2Q01EKu04ePtCBt4bIM+38z9L7NchUO?=
 =?us-ascii?Q?2YSB6KMrCicPVVP2igrohDP/zHFY3lPeQ2k7MWTx9njG9kHp0xzksIzKklIi?=
 =?us-ascii?Q?P/vfdareTTY9VTIXU/rjcnTMMTjCbcGrAF/mlqEexafI5mii+IPAMp7VxyhX?=
 =?us-ascii?Q?EA4NgwRIGwC0wwJTtv1mRzBOrD0wIC89Vn7VtA4PnVk+cVoxds67qSQqPvus?=
 =?us-ascii?Q?75vQe3WQk3z9iH3eFW3lS0qhQDBc4+GJm9hI6zof70BwBlv1l1606Usg7caI?=
 =?us-ascii?Q?fkpwLr5qu6AaxsKtt8Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0faf426-dfcf-4faf-07ed-08de26462d0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 01:59:57.8261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0e8BLvMWKoV4hHkPCPSCt1yWdl+B63zo8HlcBJlpqC6b39x+kjxeaumhEJVpHI4eRDz6fkD7l/5hBbUo6oT8xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11939

> On Mon, Nov 17, 2025 at 06:19:19PM +0800, Wei Fang wrote:
> > The struct fec_enet_priv_txrx_info has three members: offset, page and
> > skb. The offset is only initialized in the driver and is not used, the
> > skb is never initialized and used in the driver. The both will not be
> > used in the future. Therefore, replace struct fec_enet_priv_txrx_info
> > bedirectly with struct page.
>=20
> directly?

Thanks for catching this, I will fix it.

>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>=20


