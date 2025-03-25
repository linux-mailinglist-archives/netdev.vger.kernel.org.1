Return-Path: <netdev+bounces-177605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A68EA70BAC
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF3D3B3550
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06D2266B41;
	Tue, 25 Mar 2025 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="NbR/yjgR"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED18242918;
	Tue, 25 Mar 2025 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935261; cv=fail; b=C2G7OOywbEocNHnem2lfo6iGDZcHwp3Tm9NniksuNqbXM2Tes8mXTrNFO/aLov0RGOwnji3dxvV/s5m3m0guIxANKd3hSMCoXh4treygBWRjl+5V+FNQAYrhXchgg2LFFcSz4w7VaAdSzI0z47O4FWfKpQVqq/JUQ8EW77Gpaeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935261; c=relaxed/simple;
	bh=CrXjIVDOuS7qzXYuK8Y6j/9p0arWRB2rCKnIGUV6d4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JCel1Ge03kW+50GfQQNVrBd6A6GOThQzZg8lSHWoMc7oyuSjZxJVq9FJ0g8LIPZEMtY57Cj5eqQwWG5vwWev6hUGgdX8nTRm5K1Uei0sopc/ugj4PUOuk3DXT+8aadxeD/mwz8ZmDFq+S4yC8aHLEhyxIq/tkwdDuYS6sg2VNoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=NbR/yjgR; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yy/Rl58+s+sHn+2Aoehb96TdipWUOy/P82B/l463UOYyKrNQymlxoesMMKGMlB4QjHLispGfbtKNl8sAe6iWS5+KEOOeWctHZ75Bsg6hTzSKgqNIH4t2YMYolA1cRZ+ySIUId6ufijzkjM3/Idbn1WychmuLbE3uQefYhtzWsKMFn++OEarjkh7AKmIKrSWPhcK3F8TlCSvC8DnZTWVeCnNc7rwIOqjTm+HyAbSc8m7I217SrraRNcGlW5jcNBRvhJrF5JuyueAC2S98YbgkH1fZnaVO9TPOF6W9KvbZfbRO6s4crqAlyvJEEUZgSO72bUy0zL/vLD2yAhLkHAi5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ep1sTsqNDc1QilnqyIXWHxPwPVDuKJXuBrfw+O4l0s=;
 b=NiWtToJ3m52sHxjCByBtnMy2JeKMgy83E2fm1ipFvHnXhyinC8CcpfjTsKxIh1TojDBmZX7m4Hcwp03LXrOICXjmuymFqJsJ64PSGtLgBG04NGs6G/6sqfNnaUMbplMFIMJFKp+x7TymiJf9xa6UAoSqPgfKLPakmIL0wctpB68gC1Bte1jnrnqO25/lrQNVlkQrLYYoP/CaPBq4SCuFcCcuZeODtLXpDBIoZbRMj5uKEy8AsJog8kBC6U9CCtH8wiG5m2ky6gtqV7Mv/ai8U16DTbplpnehLZUGunHILdc1pll7cXMok4QOes1tCVroUaoMkwB0r4mHL0jJWCC1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ep1sTsqNDc1QilnqyIXWHxPwPVDuKJXuBrfw+O4l0s=;
 b=NbR/yjgRkeRc0faJKCbpCXayKsSZA+LmyTF1bl88ZFj5yaQ9yRlOX0ndXNO0r6qxLj9VM6WzK+obC3wWGj7yD/S6HB3jX3u6wG2V0Nesdeq7f0sn6VlUi/2gFx5ymPVq/1jF5w3+yxQKRnh0RmcgzBXST8GH2Co6mozK28Z3EMWqjEsRZECB4GEd0a0rN811MVTqw73wwimC9Dl6DCWeCuD4SKreI+Jg6Tq/DXNVzmwyrrck/IHp1bJSe5Esh7Ae1IC7xfb+t3e276hO4vLc6Cm+pRuu7RFajj/HJNexPVmkB2MjM1EWGdlAXc1R63CueJgvwuagKfPIG38HtT2lqA==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by AM0P189MB0769.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:195::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 20:40:55 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%3]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 20:40:54 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
	<robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
	<horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Dent Project
	<dentproject@linuxfoundation.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Thread-Topic: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Thread-Index:
 AQHbjO8caskJTxThsESplQo7JHQUoLN3WbyAgAT4m4CABkpQgIAADxwAgADJeICAAKU0AIAAWBYA
Date: Tue, 25 Mar 2025 20:40:54 +0000
Message-ID: <Z-MUzZ0v_ZjT1i1J@p620>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
 <20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
 <Z9gYTRgH-b1fXJRQ@pengutronix.de>
 <20250320173535.75e6419e@kmaincent-XPS-13-7390>
 <20250324173907.3afa58d2@kmaincent-XPS-13-7390> <Z-GXROTptwg3jh4J@p620>
 <Z-JAWfL5U-hq79LZ@pengutronix.de>
 <20250325162534.313bc066@kmaincent-XPS-13-7390>
In-Reply-To: <20250325162534.313bc066@kmaincent-XPS-13-7390>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|AM0P189MB0769:EE_
x-ms-office365-filtering-correlation-id: d3cea2b8-c5d4-48b1-6ef1-08dd6bdd570d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QlxHOgKhDikwQ5ylfS4gvX9NGYW0Uc30BPtPacyJRlvcbfONytg39xMH4cZq?=
 =?us-ascii?Q?lRiJtEQHTgLP/QhiuopwM4hmQEsIO/DcI8hwMa91YoguJt0WKI5zfajserl1?=
 =?us-ascii?Q?qcebn7QhWK6omq/sYWqESeH4LkCiwFSqFu0qWp52CRpwN8zIJieUVm8sYvVv?=
 =?us-ascii?Q?2OXa7HF816thHrD42cCHrwWRRGpvrmEwbj63EkPy9ALt1tzlA4yTj4Z7Mdcj?=
 =?us-ascii?Q?jhG7qKxqgGPKFLGPoTtmoHSelzJrWBvI505x7amsQ+CXtX99XdyJmw4oXlpO?=
 =?us-ascii?Q?6w0h38hTVtv6WJgBVIhkFEvPmcPk7HwP853qa5bEB1yYoNGGEa6skphRamOq?=
 =?us-ascii?Q?NBj94lREo4qcMPrmYtya+zf5uJ4KQZuvNmbt9T8w2Eix+GfMrb+3FN7B78px?=
 =?us-ascii?Q?QjGkAM0gAMkgehHReJNiOdP2WS9xHDi0aSHMP8sAeQiHVuvM5ETHnLnp80QR?=
 =?us-ascii?Q?mD3uKwk3dzUn8hHonhnK8x+VI1X1NeW3bvMKgF7teEJVcDfsTHq/KDxZRKEc?=
 =?us-ascii?Q?sleKi7Tz1Ty7ldGm+3mL/5xysDZUJUa9/ZN2L0dQjVij7OBqJllurjW8BwTn?=
 =?us-ascii?Q?fUcoIPj+VgVnMYdvH3xewy0ythA3UfdwHYTVuHed7dpVbNmID30+7ScpvdVf?=
 =?us-ascii?Q?QwrINmHbwYgOGal3VRrwqnpWpMcQfeUYccRkVqTvXYw9jBrfRzDxpv1YQHEu?=
 =?us-ascii?Q?MzbmGAtTJh8nheI21cbq2wGD0KIpGGgZtdGDgdm0K2/wADXPdFR7oD1LCp1X?=
 =?us-ascii?Q?K+VUdE5k4ZZn5UUY1gYbcNGEcMKu1ZRcXhcR5UOiYcl3EhanEsCAS8sCD0SJ?=
 =?us-ascii?Q?Sgwhry4hFKeuisWNSJzX6gaqIjK6XJdHbLu2WsM+4LGuXmK7f3OMrlzLgH0e?=
 =?us-ascii?Q?CBoUyxX7YjHIcF2wyaZkNuFReDtmNv2pSma5bgG4h1ZDxiJqD4TL4K9QCU6S?=
 =?us-ascii?Q?84pK8bZD/p/tbDVSMP1Ruf1yFu8Pk8K5HLtLo8E7yyO3q8Ptx3OZ6og4HYzx?=
 =?us-ascii?Q?65FtXUcL+OX8Je68/CTCkpymmuR6vHTlCYefZM83joRWxi016v+UBrHvoV5N?=
 =?us-ascii?Q?5AdiYFG/0PH2WPx1fvHyW2i8gRJRvSpS8cfMQOfqtZz4uV7SYkG0Lx7CvSR+?=
 =?us-ascii?Q?ATv3u+yYlHr6sPU8WuyOyGDPMwNpr+QBMIqdT0M5gbEhJut8YjTRKWTiN/cS?=
 =?us-ascii?Q?jxShVykTltklVHeMIziV3yjYch5oe33Frd/DESinrWgUTBccpkKmixQnkn29?=
 =?us-ascii?Q?CHrumJP79JsWR9DiHn40+12AnRO6kSlSIE4gueHr98heTc+gHpXbxRnwfLeC?=
 =?us-ascii?Q?6rWC5c12Pzp7UYmSBwh8WNixe6SZwrWCRNFMS8Xz11hsMcaie5xaReC6zQMy?=
 =?us-ascii?Q?B0XBmsvHaT4P5Bb8VdVqTRfJuFxe6yWkD/Dq1msfFhKuyetaAycgzGEUVrV6?=
 =?us-ascii?Q?i/p1qqfHC+t/jWnc9wNcibK5SLl1T8qb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pjG6SaaMd4qIoI+/WXMgQWBTLwE8nWBZwX3dI1oyxULeYUpMj2U5m1S1rKkG?=
 =?us-ascii?Q?o44+1uwpuyPvJxSeFYbB3NaJ4N9PLG0rvNOANPNGTdUI53Dc12mp5WMa1wsn?=
 =?us-ascii?Q?NxUq6r9QryHmMSWiFk7CWaj9QK8FJg+FPoPoEsF8R0kxBjKeX8qJ+ZAUNo9T?=
 =?us-ascii?Q?omj+Lzasn+4gSG5vAbbcIHAhyjILZiCv0sH3YCJuho86ie7wVoWen45lgeKz?=
 =?us-ascii?Q?REE3+bY4Ry82BdExk9O0wnxPmVOZX9KunPnK1POJ5cNPHo06qBdCSyPBBmBo?=
 =?us-ascii?Q?Uc4sUNe2RgDE00kXw1mQRXX9P1PkWWsedVJ4FJ70+1VpP/rijA9l0hMgs+kU?=
 =?us-ascii?Q?4S7+7V2zaoItUCksdXuck6Q6ZLpaGnDIO6CiUJJZwagUlwHuqPed3V/gEq0G?=
 =?us-ascii?Q?M8Iywj8XgJnpzNvPawe8vsgTnIRXjYhMF4Tw5bYyIKA1R6avyG6vQjdgkiF2?=
 =?us-ascii?Q?Jpoq7D5h1cC1JEYwdV3z7sXEbgFqvh7CkDEkKUNX+vwBymK+qlJ7cFrzVKfu?=
 =?us-ascii?Q?dW9BUajE6HpHtOFAsgitwEXQZd8bD2Tf8BAfOMeKlO7LHvqWUORLRjdG/dKI?=
 =?us-ascii?Q?Lh/631XiQp2nwceKO647QkD/+kyT9DiPRelRZdgYbgW0CUIZ4If/2kyCIofs?=
 =?us-ascii?Q?vO4oBnimyDmzhdEbAusBv/7CNIWvaJiIyKihD2I8pDNRnSWO9t3EoqXBrZny?=
 =?us-ascii?Q?mCDCqYifHMtEweh44iLuE3cq2PMnDkP6bzVRYE8BTHjiaq+TZy9RCbUbdMhO?=
 =?us-ascii?Q?nYVMvXLfQ4hFsjagL4feaxkAm4lElcAgllinUchai8uPTh/AKexwgfCd8CcG?=
 =?us-ascii?Q?l3PEnUYU+lywc7d/22RPMxtKHugKVN5U/WCHXxyyepPLs1aK1onGKNOqdKq4?=
 =?us-ascii?Q?3G3Lvj+21ATIcYn/Llnu4WR6zN36pA68vFr2z3Idv/lS+Y1iv4kW6GwcSQEL?=
 =?us-ascii?Q?cCJ1fJX4gE9d+zTnU6Hg0BR9vUNWYGRBP/34cYyCNJcnqCWO2OF72XNVjy1t?=
 =?us-ascii?Q?9A5MA+dlH+pQHyFQlODjpajeVQ+ghgQnHkE8T7FZH+N39M+EmmAVqkDlY5lI?=
 =?us-ascii?Q?Fi2VtNPEx4Z21IadJx+THPmjC3kGZ78TFntyIhi2AoZCHskDGkUAstbDBh+V?=
 =?us-ascii?Q?QZ4uncgfgnnxZRscGuj5rKcnk+H0fMCWJJHUi0JsquJD7cL7XcsYSlRVXOmS?=
 =?us-ascii?Q?ou6khLOkKuQWCVhFk39Am4kADychNV9HvAejjeBJSIwIA/gZmp8BgAIexRen?=
 =?us-ascii?Q?adIKu+Hevj+Lcppx7pRJuFOZzn9Dn337DOCPuPCTgM8JZ35vDzYSu+45jsOb?=
 =?us-ascii?Q?2zkJaf7P6eaQIgMwhJpEroBD9ZD2nn5/qqxeZJKr24bJBLxTBJThVasrBGlx?=
 =?us-ascii?Q?q/+stikrpqglUCs21WxLE7tlRjvu3evjsGnicuG3Oo46eZFvUrCNwr6gTRTJ?=
 =?us-ascii?Q?hk07lmaqAQJ1KLGy5/cTF51+UUoEeo44y1fKGszWJCFWB9rUqpcURXlyKRHG?=
 =?us-ascii?Q?a0JUHca1lrBOK1dle5osZVdJEKLiywSwLckSy6h9lOXURFQ2bARgrlEehpv/?=
 =?us-ascii?Q?cWDrF4nPmWHWsyhIiktWeraaNTPBjCi92DjVnEqAzveGfJ/B451LR8VnCzrr?=
 =?us-ascii?Q?TQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F5F5629058E0746A45C372C7F03369D@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cea2b8-c5d4-48b1-6ef1-08dd6bdd570d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 20:40:54.8529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7PX+FIaYaCIkxf4CyeWLO/i3pMiuSRsky5/NMyr1T0pqW/y+VuSYboHkeP/SSCueiIgeE6j6Ue7Qj1qFCp5bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0769

Hello Kory,

On Tue, Mar 25, 2025 at 04:25:34PM +0100, Kory Maincent wrote:
> On Tue, 25 Mar 2025 06:34:17 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>=20
> > Hi,
> >=20
> > On Mon, Mar 24, 2025 at 05:33:18PM +0000, Kyle Swenson wrote:
> > > Hello Kory,
> > >=20
> > > On Mon, Mar 24, 2025 at 05:39:07PM +0100, Kory Maincent wrote: =20
> > > > Hello Kyle, Oleksij, =20
> > > ... =20
> > > >=20
> > > > Small question on PSE core behavior for PoE users.
> > > >=20
> > > > If we want to enable a port but we can't due to over budget.
> > > > Should we :
> > > > - Report an error (or not) and save the enable action from userspac=
e. On
> > > > that case, if enough budget is available later due to priority chan=
ge or
> > > > port disconnected the PSE core will try automatically to re enable =
the
> > > > PoE port. The port will then be enabled without any action from the=
 user.
> > > > - Report an error but do nothing. The user will need to rerun the e=
nable
> > > >   command later to try to enable the port again.
> > > >=20
> > > > How is it currently managed in PoE poprietary userspace tools? =20
> > >=20
> > > So in our implementation, we're using the first option you've present=
ed.
> > > That is, we save the enable action from the user and if we can't powe=
r
> > > the device due to insufficient budget remaining, we'll indicate that =
status
> > > to the user.  If enough power budget becomes available later, we'll p=
ower up
> > > the device automatically. =20
> >=20
> > It seems to be similar to administrative UP state - "ip link set dev la=
n1 up".
> > I'm ok with this behavior.
>=20
> Ack I will go for it then, thank you!
>=20
> Other question to both of you:
> If we configure manually the current limit for a port. Then we plug a Pow=
ered
> Device and we detect (during the classification) a smaller current limit
> supported. Should we change the current limit to the one detected. On tha=
t case
> we should not let the user set a power limit greater than the one detecte=
d after
> the PD has been plugged.

I don't know that we want to prevent the user from setting a higher
current than a device's classification current because that would
prevent the PD and PSE negotiating a higher current via LLDP.

That said, I'm struggling to think of a use-case where the user would be
setting a current limit before a PD is connected, so maybe we can reset
the current limit when the PD is classified to the classification
result, but also allow it to be adjusted after a PD is powered for the
LLDP negotiation case.

In our implementation, don't really let the user specify something like,
"Only class 3 and lower devices on this port" because we've not seen
customers need this.  We have, however, implemented the LLDP negotiation
support after several requests from customers, but this only makes sense
when a PD is powered at it's initial classification result.  The PD can
then request more power (via LLDP) and then we adjust the current limit
assuming the system has budget available for the request.

>=20
> What do you think? Could we let a user burn a PD?

This seems like a very rare case, and if the PD is designed such that
it's reliant on the PSE's current limiting ability then seems like it's
just an accident waiting to happen with any PSE.

Very rarely have we seen a device actually pull more current than it's
classification result allows (except for LLDP negotiation). What's more
likely is a dual-channel 802.3bt device is incorrectly classified as a
single-channel 802.3at device; the device pulls more current than
allocated and gets shut off promptly, but no magic smoke escaped. =20

Hope this helps!
Kyle=

