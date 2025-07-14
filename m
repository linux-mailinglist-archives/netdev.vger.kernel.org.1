Return-Path: <netdev+bounces-206669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E34B03FC0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDCF4A1B42
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9434125745F;
	Mon, 14 Jul 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ghmlNNbh"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08824EA90;
	Mon, 14 Jul 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499377; cv=fail; b=gHu4qfmYf+XyihPV/qMBjhEu63KUV50cs+1VIknS34FyRaMRlHGDqYqge7XL9CeNPscorUDadWEx6tzK2BK64yf/sx6PnSeOhNZFvXkFGk8Gyvmf+3FAkpJ+3TQ/tYJNh4XkeejZw3aVAiizA0qNXLeaqRzZmywCzrxvEVFmTrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499377; c=relaxed/simple;
	bh=lGqa6Z2goylAfib7ZnAMeIA7SFpxv/cWms68axMV+OY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H8OPBqDCTeirmTuJTwxMC5PzgyyFza0Eqxm0qiExjIpGb6OVrM9frF6H6//ZKBwZ3c4CwruaoImq8tqckONZJ1ld3suhnWl3ggkSP1FdmOiVSagJDvResh9Jvie6pJGvhE2u4EsX/awiAT3hdRO5OH2hD16NeqwcZhvG5k/ZxGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ghmlNNbh; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gq6VFUIgRqFBbOW9TONMRapLOmA61mgcjc/puAfyplP1Xw96vXXAwi8pdMje62aO7bx9yf1aS/QWgtsgLbNE6H0isq5u0CbUzsHbL2LfGVe2rCRG5Nf8rskFE2PwfOkyBCI0p8KYMpw1RLqJsVsVH0VlMIHIyDKHa60n6mTU9FWC3f4wvh7OBiWBrz0/2In44hunMzyhnbX8201w7p9LI6+luNATudgZ/v/tfPIxQIkojZd6D+dn0ngv7jZ/IlOBPxOOApj6QAQjoFozKYzAaFhSgjW5p8hX4UQ11ZXfoGKb9GCx6o6cNgeI4PNsb4Z/5pN4LsJwqcLlw4kozMMk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGqa6Z2goylAfib7ZnAMeIA7SFpxv/cWms68axMV+OY=;
 b=wWsmdDgROvn7mCPr3EF43aPLSv5Gwt2aVJ8KAoHxEmydLHXo8CxG97ONuM0FRuwc6RawQLNEn98NCqlDepDgVOuNYeuTCSkYoCT7FGVx09czGpBDNMjjEJZ/+Sk5J2TOLgoWrXxxVb6Y7bHIuafElJTCm9UoOBrCQnGbkWAnD1HHovKeV6Q9lgxGFHgu+szubiJEskfj549tMGxv7wIqmgAhZp+rPsKR4OP9k7O+8pHHCcBCkZQzAALgvDb2Q9WVsaJ2CPbtXYIvqN5eUu22ioxdmbrEhaFyMq9IWUuh8ELJ1uxgFPbVB4oOu+BxXJaQRC0MDhDkj81Flwnt5kkQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGqa6Z2goylAfib7ZnAMeIA7SFpxv/cWms68axMV+OY=;
 b=ghmlNNbhHrEXlg4SSAN4UyxqA47n/zxlY0iTWvE9boVKVXKA1IieIfjTz3w/KPrvzk8JaAImDMvnhSg0Nr9iGevMHS+92s8d8d/VuO1SF6hYONdViYNqiLELP2+Bupw2uY2E8XbI3EwjZn6JXOoV58NrZcmx6UsixbbtJLo90+s4D/eKCvYi1mGMcgJ9zoBnB4eAMI77+75MuQuZ9PXUaPOjyg5jia9oaxBcHhak1HEVRXPT2CXyt7Ubz+q20bNRNNMO8TvVFXd8FtHIc8DPXNWrYgn269RTcJ9kqzRuhM05zc+A8bisImn1we9t5V241wUK/GMIpIcdCn9NM86VJg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9277.eurprd04.prod.outlook.com (2603:10a6:102:2b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 13:22:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 13:22:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Topic: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Index:
 AQHb8jPWk5neHXUn3Eeo02nqDOVTYbQxImMAgAATMMCAAAm6gIAAFX1wgAAGKwCAAAFaQIAADfuAgAACM8CAAAPoAIAAAqbQgAAP8QCAABcf0A==
Date: Mon, 14 Jul 2025 13:22:51 +0000
Message-ID:
 <PAXPR04MB851072E7E1C9F7D5E54440EC8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <ce7e7889-f76b-461f-8c39-3317bcbdb0b3@kernel.org>
 <PAXPR04MB8510C8823F5F229BC78EB4B38854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
 <PAXPR04MB85109EE6F29A1D80CF3F367A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
 <PAXPR04MB8510CCEA719F8A6DADB8566A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714103104.vyrkxke7cmknxvqj@skbuf>
 <PAXPR04MB85105A933CBD5BE38F08EB018854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714113736.cegd3jh5tsb5rprf@skbuf>
In-Reply-To: <20250714113736.cegd3jh5tsb5rprf@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB9277:EE_
x-ms-office365-filtering-correlation-id: 7110bb17-e243-4e9d-5a53-08ddc2d9890c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NQOSwWApCr4yXp4K4xqm8MujHJitPAmThEVXOzNb/S6tz9PNc+U19UYtUTna?=
 =?us-ascii?Q?ggMQZ3YArNzBUkur7U8LABOFrZ3jUzKsVu9jiujj+HbIGaE+dqsk/HwHDj9O?=
 =?us-ascii?Q?q7lskLBpeANdW5NPsIYZu96L3lCziS7+Aule+rzAvIGjBzf6EPJUY+rVLw6p?=
 =?us-ascii?Q?otfW/H5bhxo6iKwdgG+W/a/wuPabI4jZdrUAxguXwkedbmm+0bhoCrBsjoG4?=
 =?us-ascii?Q?ksFd6o1ieE5EoRmQL2EJGFUlIbbE1gJOZfcoCe+djumjyds2BYmUwgUuOWiH?=
 =?us-ascii?Q?yEbDpkTackoAiRRH6fj9m1hwhbL0yGGkolUP8H5/9zHasTpEdIKuaJdtbuTU?=
 =?us-ascii?Q?jshugWSutEm8fwb6xyfTjjAinP++VSJSvHObi2HnRgJ3kHIGK1CBJqciu+pn?=
 =?us-ascii?Q?3EGEfsdXvVxmmSOYWX76AhNxzRuUKPrpD2Vyem3SL1uQEUpiYWukufIbp7KV?=
 =?us-ascii?Q?v4aCaXX/hPbWrt/xzQKq/ltTjWkfn7IKLOJxMnc5Hw8uKrU9aNTPnGv2rY3j?=
 =?us-ascii?Q?tGrko1hAtThqLLIDT0Py79ws7LCSYSzFqBGtG09vzR+P5V/V5MoVBzgpSura?=
 =?us-ascii?Q?JviDJV/QBjgy68l/biMYTYSgzLBjOBK7jXdlOeh+tUgGPxe4nMXoH0H4xY62?=
 =?us-ascii?Q?2/YmiPgI4m+zMQFViFSpxg0Eu1pE3tF1rIUiz4/DfnprAoZW/skvzpLavJka?=
 =?us-ascii?Q?y7Wzfu+B2ZarHQ0OM73u3gaTq0CVtQ6/2GSCkSmkovLXFEwqhquCLgTFfhff?=
 =?us-ascii?Q?eIVhEG4HUeNeeckZOL9ZEnxlXO3J36pMSrv7/EMmTOwqPKOKpUXLMyUKo/1v?=
 =?us-ascii?Q?G+URW6cVWipgQFEXkpmW0IsI7X60qtMoCRYO/56IkkTpHjb7IrrZnIVelREh?=
 =?us-ascii?Q?5RYoNuhAOKKRdMY241z9oTbf7COK/JITYHGUikVv4DMyTL40xv3ZCOI/jzcL?=
 =?us-ascii?Q?LMExS4cI16kjKgBWrQe6rmeJ5+up+PF2JpAm1XjLU+1O2l4B2tk0TrFY7+Wy?=
 =?us-ascii?Q?w37or0wWtdeNLFi3FStDpYeohygx6PwaYHB1vTJsCtfGdFlzbtcKgC1rOCC0?=
 =?us-ascii?Q?DoIyULmwIh7a4lQqdtWVIH7QQHVrMR29XkSB81C/IUZejv3Z2HXdTGGSTCt2?=
 =?us-ascii?Q?huy9V4uO61JncObk2ibPe9NMa8GWbLU0+PoqVqCy9VGZByRfTWa51ENOgLN0?=
 =?us-ascii?Q?Ett3NZ/CvQx5Sumy1aZfqKxW/edLJ22q/SA2pHc6y/P9HVu0ilM2VmXq0vfc?=
 =?us-ascii?Q?CppQBJhj5xeZej93qiXfHaNGH9Z7O20TrpBo26LQsUijZoOE8uZ3GK7/qbnJ?=
 =?us-ascii?Q?ZXdXSQt+zZ/OCD5rgRCMy/Yko8PCj+XCb7pl9AcVQyf395Eg4G57rq3XGucz?=
 =?us-ascii?Q?85/xCWcXQDxjI5avWHoOg5EOA0UhoLm78oOJew/cf1pRJ40tnuc3Vv55iwy4?=
 =?us-ascii?Q?JMTIjbk7fQ7ibJ3VWwDn/kpWBIqeZmi19s5z8bCIu2njs7nS7OhH4A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JGGXwRxkEYmcfENgrt1A5R8QJLA9aqL2pGD8ctls0bPisdjEUsOja0uQR1BB?=
 =?us-ascii?Q?DtZMyUf/I3p73IktF0lYaZe6MbsIrhXiWeImGFJgf/rxFZVX2BnOMUeQd0NT?=
 =?us-ascii?Q?bbs5Jb9w1R3PlbHmSD9UC44WPD+evluJ3rT4wWDBcY7iyBsOJj1RJgefctaa?=
 =?us-ascii?Q?O1sPjGqdNzC2kGPpJ56mXctYFNXAxh/Sxpyz4rKsza35wHHHqc8pQPagno8B?=
 =?us-ascii?Q?tMZnMWomNaRxOjNcI7SWO7rTjY+WLbVjnVEzUJkE+NtisrABIBvK6mDoXmtK?=
 =?us-ascii?Q?tmv+oHiJtMhsTAITOyfkSrphlYc/UmF9FgPcNDCHtL+XRVQWnKDLrSRaDY8O?=
 =?us-ascii?Q?o3iw/YLQrhpxFFYgxB2LNlEkRToksYQeMvokniRo2wtfaCAGHI6dzKaa2kLQ?=
 =?us-ascii?Q?8TK0kE+l1Ua0+eNoct9Bt59Sr+AD2I7spyGpr2t5Z9nnXgXECgYGEt76f6tg?=
 =?us-ascii?Q?Nf0JNyMjSwb8hPePGTplBj3n5qDuAX4cp9qXG9/k7DWoD6otQcFeu8OlSvR8?=
 =?us-ascii?Q?b/z+KHXiee8R4dD4yPuwmgo+QhwKas3YOFajL8qQR8y6P48h2DsY+6yr/b6s?=
 =?us-ascii?Q?ZEDoSNxSpkMC9nBt+8R3kJjra/NQZ5iMFqhYh88YHgjT1W2xPVOjWueyc7RR?=
 =?us-ascii?Q?CjIovfFSDiS9vVPWqND2CF8hjtq3WAcJr71taA8eXTz67JNYA2K71h25nEsH?=
 =?us-ascii?Q?AYEUz5UQ5wzvruu2XyeVfOQcIHxqMS1QMFdRcdmBtqRcm0S5z8TcjpciAYjD?=
 =?us-ascii?Q?w2qMZaHkOL8z+aGVFIDwlK10TdXSBddDqnWdk9bbpZOfoo+wdvVHE7j5o9nP?=
 =?us-ascii?Q?lhYJTZVzUdOCmn2/m/ntaFGY9YasCDbgNLQG93cyDZXjYihR30+Bmz06QJaj?=
 =?us-ascii?Q?2fJ85OEEw3FGqepTRyyhDuNrvkFUAeIbapLznmrJmZMr/WKNPP+e2tWsWI72?=
 =?us-ascii?Q?hToidfCuFsG9aY29simL0He5Dv1Wyq+xbjp7uWwgn8p5V0X0YcCARLrSGT4Y?=
 =?us-ascii?Q?+89RlHxzbB22Nc1Y80k0ZWmftrVNdNlNkVViTOYyJ2/GcqyzHeRgm6gUxGpe?=
 =?us-ascii?Q?asFhebCd36CW+S3yxp1lAUkoZw3ccU6Ai04aKxtSyTwjG5QqULM1tAGKil8G?=
 =?us-ascii?Q?eQ4UBPy+w/g8Hp+G1eTkcAWQXIj8XWHjq4naoaX9MDO+4rve7b4ggCgHUa5q?=
 =?us-ascii?Q?wnP7xxrGDxKUOWLk7vrRzgJrtMfVmZL/cEmNWjSONJOneeWCG8VQPuEaapOD?=
 =?us-ascii?Q?5DtLyHAXwqHLvMopIubKa0eKsYbboe0QIX2k88AyiDtEQZs85JtqQ5fG6ar1?=
 =?us-ascii?Q?IBTknm+pBDp3MgmyjY1VU+vNJNfZPdbuTdaBHYfZ7Dtxi8RqWenCrWByH4pm?=
 =?us-ascii?Q?KlKMOaYfic3MVzb28wD0nWeNtrcWNUBC/3PiEEAE62R2gGkWS9ZT4JCh7S1e?=
 =?us-ascii?Q?qhisrHgbAQkTYPEwlAiIhWamPbUmYwMp9na5DWYPbdzuhuZgFuEGsQEK9KsS?=
 =?us-ascii?Q?tGmtbKoI1shv+hVtexxj3PPNkMqV1oYngwXIis13kYTyUbc7ToGbiR+gWjVH?=
 =?us-ascii?Q?AeQIKMjWyBq+ExN6rrU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7110bb17-e243-4e9d-5a53-08ddc2d9890c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 13:22:51.9179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ty5ngmoe5CAIu1JT1OdV3qMIHdz11qsWvm06xV9LIBuqqAR0dF9sCVxny7RFxEHArVYXws7J2Qe5zrRYhGvUxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9277

> On Mon, Jul 14, 2025 at 01:43:49PM +0300, Wei Fang wrote:
> > > On Mon, Jul 14, 2025 at 01:28:04PM +0300, Wei Fang wrote:
> > > > I do not understand, the property is to indicate which pin the boar=
d is
> > > > used to out PPS signal, as I said earlier, these pins are multiplex=
ed with
> > > > other devices, so different board design may use different pins to =
out
> > > > this PPS signal.
> > >
> > > Did you look at the 'pins' API in ptp, as used by other drivers, to s=
et
> > > a function per pin?
> >
> > ptp_set_pinfunc()?
>=20
> You're in the right area, but ptp_set_pinfunc() is an internal function.
> I was specifically referring to struct ptp_clock_info :: pin_config, the
> verify() function, etc.

I don't think these can meet customer's requirement, the PPS pin depends
on the board design. If I understand correctly, these can only indicate
whether the specified pin index is in range, or whether the pin is already
occupied by another PTP function.

However, these pins are multiplexed with other devices, such as FLEXIO,
CAN, etc. If the board is designed to assign this pin to other devices, the=
n
this pin cannot output the PPS signal. For for this use case, we need to
specify a PPS pin which can output PPS signal.

>=20
> > > > The PPS interface (echo x > /sys/class/ptp/ptp0/pps_enable) provide=
d
> > > > by the current PTP framework only supports enabling or disabling th=
e
> > > > PPS signal. This is obviously limited for PTP devices with multiple
> channels.
> > >
> > > For what we call "PPS" I think you should be looking at the periodic
> > > output (perout) function. "PPS" is to emit events towards the local
> > > system.
> >
> > The driver supports both PPS and PEROUT.
>=20
> Ok, I noticed patch 3 but missed patch 4. Anyway, the role of
> PTP_CLK_REQ_PPS is to emit events which can be monitored on the
> /dev/ppsN char device. It shouldn't have anything to do with external
> pins.

Is there a doc to stating that PTP_CLK_REQ_PPS is not used for external
pins? As far as I know, some customers/users use PTP_CLK_REQ_PPS to
output PPS signal to sync with other timer devices, for example, a similar
property "fsl,pps-channel" was added to fec.yaml by others before.




