Return-Path: <netdev+bounces-195715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02CCAD20CB
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F527A6BE4
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AB925D21A;
	Mon,  9 Jun 2025 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="DgvNXyOJ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2075.outbound.protection.outlook.com [40.107.247.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82525D1EE;
	Mon,  9 Jun 2025 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749478995; cv=fail; b=BkmL4HBLh/pdDoC9A4lDJZLpYjKCgn3LULWfEGFIf+e8dzjnzz6tjqt/XcTMVgoQrXwKQ0Rnoe5yKajopfmREpJY5Z47AC94HjhgUb24LCXnSLu5r3VuVKxJH7HTLu3qJGgMg804nNkZQWztyCcbEaigaWRm9fbBOs2w+kVOV9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749478995; c=relaxed/simple;
	bh=/iIL4ulye8NMouzDwcbYm0vkwbUZbxix6KnjoHDIMFU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I1gdOGtv3TJ3xa51vLZw2YS1ar0yfwnYIJl+WfCmuWdAkm9mmaVGU/v1+0g7o0uSh0jJuSoV/DOixgt6T3fzuHb5QcSqs1ZrEMivvmhWd4pIVqHZUvJxxszU8JeALDLXjuBAV6UvE3Lv/6JRQwrz2TURyYiVRLs+/E7KpshJgcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=DgvNXyOJ; arc=fail smtp.client-ip=40.107.247.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5r0ue8jG1NsHDq6pmWbZoZpaV1vMV5kaxNuHKz51qQ+GMbKKTiuHU+5fOa7ijspbs7a6P2OtI4sJUGE1/1mnkAz5HYmj918JZ1y/gZe/gPi4BU2HQo7jRSzhiUiOmbqb5uMppPtWykaaqP5K30RqIwSaenDwiu3bIpPrrED9FribWYRmsDkhrCjLfLmWUwVlx2IKIaZ18rNVw9OjwGjc/zSX49KU0OiH3aX6DEAAB30sgUgC3GSbfVzAERwQcGImgCzOuIXZjZMHpy2/g4DACIG0dwpeDna1MfaKs+SeQ8enfZqSfrN6teSWhuXYyu5DU04lVRmN0njY2rWEqxKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75r0/1Iqc7UFcmEgbt8fLxEhky1skI1vSRCtudfyhtY=;
 b=k8cK/IEpYEoP+Z3ANJLrfXzcTq64yjYGd2ZRcbvmTzQwV1jcfIZ/dvyOqq70oB+K+kN3VjeSqjJ1S5DnM3ezhQw0qRIK8hFeZnjdCtLMyjjvBfhIaQge5mz9bf+NyNTUdfLubAtFKJOHtRlKmIVE+2V+Alf5AeS1syDLw8r+k1XRy2XFVUYA6Zt0YDy+E+2CVdBkgtmmVX9XZeSniiGCzF4qjHCl4Q5o21ZAPfLNRIxJGfGUAlGCyak93bKDoBA0MUszrqFhDhzTDUyc8drrVowtaDg595rpeYnrqBSxG0fVuJnJM0yvZ5ILxCf8dIy6I+QO/rdNo5t+hhVobP6o0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75r0/1Iqc7UFcmEgbt8fLxEhky1skI1vSRCtudfyhtY=;
 b=DgvNXyOJppXHue2c3FW22YDttBDMhT6YZApGNl60/1fDsf0/3gxwT5X2X6D8h+ETBWx38rPCuuLTghHS2shkxyRDWFMM1mSX9KJ2rKTwZ6ZTQJjQJebJQkvdFK3gkR9S3m5yFbQ3+c5/qTHt6roulrcjrHmK3h1Kub6Cn870IIKSgv+QAxB1xJI1iO3wiJs+yvlKV07Ceu0HZCptu4izBMOxklps2EN8E043cG0VpPHIX4o+oVTqRJ5DyHarDfH5FY4D9EGHmF7Cwv6ghuVgMfvjt501YVjVFr/y1DOpBNJ6viL2ju/rGdRkKpxTo9Mi26m4dnTFn6ujaWzh1AEZ9A==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by GV1P189MB2243.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Mon, 9 Jun
 2025 14:23:08 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%4]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 14:23:07 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 2/2] net: pse-pd: Add LTC4266 PSE controller
 driver
Thread-Topic: [RFC PATCH net-next 2/2] net: pse-pd: Add LTC4266 PSE controller
 driver
Thread-Index: AQHb1NviPHYrTpIVGUy5BtiETVG4nrPyrpiAgAg7sQA=
Date: Mon, 9 Jun 2025 14:23:07 +0000
Message-ID: <aEbuK5FeOgj4qBHu@p620>
References: <20250603230422.2553046-1-kyle.swenson@est.tech>
 <20250603230422.2553046-3-kyle.swenson@est.tech>
 <aEAGNa38EUIVgByn@pengutronix.de>
In-Reply-To: <aEAGNa38EUIVgByn@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|GV1P189MB2243:EE_
x-ms-office365-filtering-correlation-id: 6b139122-a657-4831-18b6-08dda76127d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?utivmtxR5rFxKaYkZhI3DL2bKmJcm1J6a1s9rNr3LSJDYCv9+dzG8U1R/E9c?=
 =?us-ascii?Q?o6pzltsUoYsMbjrhptSZbtwJ7WFuykQeG1AOGP+sz3WWLBFqsuktqm9KXkvN?=
 =?us-ascii?Q?lxjrZ3Kw/u1j8NwH/996iUJuiCpwSi1ty1GrCpDyV+P6YqYuQPO1V1LDlcks?=
 =?us-ascii?Q?gjVLOtKw6GfHrmjubGFiXPTGjK52t6nBhuclgyk1jM0qrW0FzaRJkXQ+5l/f?=
 =?us-ascii?Q?nNDcfjaUeoLmhB5JKgF1FlSE58WFSRzOWiazLsaG+AToXdeSEGuxHBioAE2M?=
 =?us-ascii?Q?U6jigH/ZgQ1DJlPz3eJZyXByxPeYQzD7NzPWJ3VOW0hZ0u1VTucxqcjSwB+V?=
 =?us-ascii?Q?x5F1viZGWHks/b5bt5DyQb87DW7UCmFaVWNYAXrtgk0/CTGiGDHzJ8++9KTX?=
 =?us-ascii?Q?bTS5+/xCavdfC6sxbVxJUV0AKniCaDAPr3QnN3gCCdvoaa1uXcdEciRQhdHR?=
 =?us-ascii?Q?u+M7AVTcfXQCxXQm7v01Yme2R276y8BJcTbxBAddo/xS81VlwjtZokpko2Wz?=
 =?us-ascii?Q?tpz2iRLd07uZl+j2vvZmHz1eKtoa/D6vrpnGfRmBplhS0E22v/gBafVLNYq+?=
 =?us-ascii?Q?9cmKVraFiK4wMoFGvJ5LfCK6X0s1/6cjlYt5kYbqxOZSzvGVNaFvgdrJ8C6/?=
 =?us-ascii?Q?9+B/A2FJd3bCyf2epz/dP5O2Kwew54wSqEe1wWDXcq304EQ4+1Cpn6elTj6H?=
 =?us-ascii?Q?2MPV6IXkZrI4wdbQ63/dZbhnAJCtHhfkz6m7yb1ANv3K3ALJlCmjAEQX1VOD?=
 =?us-ascii?Q?MvlcC6rRyt2nuY92VxjWPT0dqF6yT8hcerlqHhoaRpQ+5vn/ZMzczzgJwJMC?=
 =?us-ascii?Q?0Sa/5o2KkqPg/qYlP7hznc5WHiMVl9Qe8rWwkbsrvmAgknJOatvOWW7/QRoA?=
 =?us-ascii?Q?598TJe2kqAk8Cd5Hcd7qwGXlB68/5/kHwhKgg42ynjqij3aFggAJ487E81Je?=
 =?us-ascii?Q?yY4ycY3evzrrG7WE+qzdiZ+6T22mFgihde4ABACao5iwIKlhS3SeLDewR1oQ?=
 =?us-ascii?Q?gv9tCPQvxz72jgOdG8+cUqMvnXPzHZbezhtwWVHqgTFy33m3XffGevXd19zV?=
 =?us-ascii?Q?x6Mc9DkJvLg2Dq6SniqbynEbCUPmdo+RWrXumWVH5CXynXfwBo0pgOaiQ2zo?=
 =?us-ascii?Q?d3WeZjE861dpBM/jdAXy4+DJFtI311vIzDY9gjQqrRvnvpP1gJvOrd/5JHVZ?=
 =?us-ascii?Q?7p8Yl3BlxFhu0BfpgQ+jDP7QJXvIRrYFP9Rm2Y9BJ2WggXYKUfNVeTtmC1Mk?=
 =?us-ascii?Q?XCv/VVLW4Fadn9CErhZhBWDFW7DQpBoRpMMwDbzfWnJQuM4MqNkJKdXLVESR?=
 =?us-ascii?Q?7u0Hj2US2Uj+POJE3DDs7b6L16ZepAxmbxA3vobmEuKAJUglKkjPz6E0oqfN?=
 =?us-ascii?Q?5fY7AqtJzHAzgdjKgPo03L62BlL9sZ2dJfsGvd49K9XOTbSkLFDnZiNcq+Co?=
 =?us-ascii?Q?1DYAL6EeuZChPA1ks7UYU6PMChAq2U5uGzso1hqjYYohGHOLZrGv8w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?orKbbEj6ezJHTkb24KOUNusxvmT1CLK22DELYWnH1rrFxbWaryzW4pQjnHBb?=
 =?us-ascii?Q?NaHWywdlaFNmGWhqWx4GpuWrYJ9p82gvibNpSs8lyDWAN1CKryfGiBFGZDUr?=
 =?us-ascii?Q?4gDRtlFz7Ch01aZ3Ws6SeALP2tJQEqj01Iq6uqWZjOqAgEu3Gc0MncANg8ND?=
 =?us-ascii?Q?tLZ/8vth1rjPJ6YO1ogjNxrJP5YS+XlXDCzoN23MDkODTnaloI+/5w9SoncY?=
 =?us-ascii?Q?VoJP1Fgdm0SoOEU+wb+C5UnmciSRzJVwJUnKN9VCbFr0HZH5LKRbGBslwg9n?=
 =?us-ascii?Q?aFmoX3a651IMHanAccn6OtDdyYVdQRIxPdtHaXRwQY5PmdRJ3WfYyuBcmFDQ?=
 =?us-ascii?Q?ZNiNoD7k70sQErhzWBTvO8RU5PLaE0D9scUGUxDVCH2SMnEkAjrJNe/BfTJf?=
 =?us-ascii?Q?bf1Sf8+rYL4YKahd05/PGAXEavZf4xLhMrJHawXfv/CrXxRwXTlBJOYi6Ync?=
 =?us-ascii?Q?k+BRPVUAYYfUUImNvWFT8N726PRT7wFlroV4YQypA+uc6G/khpidzA0XF7PP?=
 =?us-ascii?Q?lqgydJ89LerDn8J+jCPdGfbwKTHM3QSOKt4U1ygnvK1hhF/LmiVXYvj9/c5U?=
 =?us-ascii?Q?UOV/NAsfnpCYJ7vK4hVuwYuDfQ3uJ9hC7E12rlExRkROIGOE2ZqRhIQLc9IB?=
 =?us-ascii?Q?CZbhvRJ7dOMXC2xLPushbDif/RumDHOokOdW38cax/YWbmYi6ReAbDa1lUsp?=
 =?us-ascii?Q?gfjLFRF2EBgq3Y6QOQm/TfPJXapwXWtMl199fdKrdClhiwYUbfLIUqmi3jzz?=
 =?us-ascii?Q?FHFE7gQWaJgatYkVeSvlseoGmLLtSr8D3iYArlcFDSafAPfGR6tt8jkb6fMa?=
 =?us-ascii?Q?z8hJdHmhy4OZfoMu+MMoJfxpC/CTb+TuISi7mcQz9oOh+yfmgoYaFjo4+iTg?=
 =?us-ascii?Q?zwCZgAaYEVp+AKqA+Yk8QtJJ+qZ2XmpvNhZu3LiX67nT6fvU/C9uDtApmxa9?=
 =?us-ascii?Q?HNTVoJHE2n9btU7sy0ORABh3Jn0wAiiBAr0Wgmja55ZcgFAcV0gc5YPlrlhN?=
 =?us-ascii?Q?EMwV2otN1z5jr0h9f/pPFPRdVvdq7Kzcq/3t9LGeRy+QlojRPSDi6zkIfu/1?=
 =?us-ascii?Q?82h4c5RockhQRFNgGPl+kKqcGnpiIOn7L+Id5DI1K0lBaWot4N6r/Dn4ld0B?=
 =?us-ascii?Q?JjW5AQFKIwNqivn+hj/vfR1r685zlItnEzGJssCp1TYZWSB2uAkfzdsCA5Ln?=
 =?us-ascii?Q?TZ2AvyiZuB9zR30IDAfyzYT5GpyHN9Ek+vKwwuW0amYnxyE5mM3TyNwJ0kfs?=
 =?us-ascii?Q?gsxGW2F70/XBid8BHQQU10UIOdiY443+mZEFWgm1ddvwXIw+ZCRIPTmV/HnZ?=
 =?us-ascii?Q?1u15L5EhqERDqtx7sGAfH3mtNngfMRsSIlUJZeMvTxbn7OAYAEcdCGeL1rkl?=
 =?us-ascii?Q?Cv+sHuo/wyWjvll93KDsFAuxA4IzLYFIcdxZGKXCoG8QjFJxg7OFhkvL37GP?=
 =?us-ascii?Q?NoLIVSIJXhKFpJzlM6fG1vHYMCRScLGYscvrbEZ98O0J+cVKG2f8d+R3qExA?=
 =?us-ascii?Q?TyOsJMvSoe+8kUfeZ8S8u1GueTnid09i/nOOGX9zn72kK2nU9qJejWrq5u0m?=
 =?us-ascii?Q?HN2wasgolZqxEHZ7/Zb19yJjPaPqar0xlD5AolGEH8uw37RVbfWHAP4IrsUv?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FF21EF998262045ADE774497283DDC1@EURP189.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b139122-a657-4831-18b6-08dda76127d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 14:23:07.8154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udvc7hA5V+5ay+biOTqQnrJmnGO3dmMYwwO6q9MoKo4hknAujWW2kQHot9dRMimMKlOxHLLLaXSRQoLG3V89ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2243

On Wed, Jun 04, 2025 at 10:39:17AM +0200, Oleksij Rempel wrote:
> Hi Kyle,
>=20
> thank you for your work!
>=20
> Are there any way to get manual with register description? I would like
> to make a deeper review :)

Yes, but unfortunately I think you'll need to make an account on the Analog=
 Devices
website and go through the "Request Software" process for what they call
the "Software Interface" datasheet.

> On Tue, Jun 03, 2025 at 11:04:39PM +0000, Kyle Swenson wrote:
> > Add a new driver for the Linear Technology LTC4266 I2C Power Sourcing
> > Equipment controller.  This driver integrates with the current PSE
> > controller core, implementing IEEE802.3af and IEEE802.3at PSE standards=
.
[snip]
> > +#define LTC4266_TLIM_VALUE			0x01
> > +
> > +/* LTC4266_REG_HPEN, enable "High Power" mode (i.e. Type 2, 25.4W PDs)=
 */
>=20
> Type 2 Class 4? Probably not, datasheet claims:
> "Supports Proprietary Power Levels Above 25W"
Yes, Type 2 in this context means a Class 4 device.  I think the
comment in the datasheet is referring to the "4-Point PD detection
circuitry" but it's a little unclear.  That said, I've no intent in
supporting these proprietary power levels unless they're the same as
what's described in the IEEE spec.

> > +#define LTC4266_HPEN(_p)			BIT(_p)
> > +
> > +/* LTC4266_REG_MCONF */
> > +#define LTC4266_MCONF_INTERRUPT_ENABLE		BIT(7)
> > +
> > +/* LTC4266_REG_STATPWR */
> > +#define LTC4266_STATPWR_PG(_p)			BIT((_p) + 4)
> > +#define LTC4266_STATPWR_PE(_p)			BIT(_p)
> > +#define LTC4266_PORT_CLASS(_stat)		FIELD_GET(GENMASK(6, 4), (_stat))
> > +
> > +#define LTC4266_REG_ICUT_HP(_p)			(LTC4266_REG_HPMD(_p) + 1)
> > +
> > +/* if R_sense =3D 0.25 Ohm, this should be set otherwise 0 */
> > +#define LTC4266_ICUT_RSENSE			BIT(7)
>=20
> LTC4266_ICUT_RSENSE_025_OHM
Ack.  I'll also fix up the indentation that's (now) obviously
misaligned.

> > +/* if set, halve the range and double the precision */
> > +#define LTC4266_ICUT_RANGE			BIT(6)
> > +
> > +#define LTC4266_ILIM_AF_RSENSE_025		0x80
> > +#define LTC4266_ILIM_AF_RSENSE_050		0x00
> > +#define LTC4266_ILIM_AT_RSENSE_025		0xC0
> > +#define LTC4266_ILIM_AT_RSENSE_050		0x40
>=20
> Consider renaming constants AF/AT mentions.
>=20
> Replace _AF_ with _TYPE1_ (e.g., LTC4266_ILIM_TYPE1_RSENSE_025)
> Replace _AT_ with _TYPE2_ (e.g., LTC4266_ILIM_TYPE2_RSENSE_025)
Sounds good, will do.

> The terms "Type 1" and "Type 2" are how the official IEEE 802.3 standard =
refers
> to the PoE capabilities and power levels that were introduced by the 802.=
3af
> and 802.3at amendments, respectively. Using "Type1" and "Type2" in your c=
ode
> will make it clearer and more aligned with the current, consolidated IEEE
> terminology, which is helpful since direct access to the original "af" an=
d "at"
> amendment documents can be challenging for the open-source community.
Ah, makes sense.  I'll change AF/AT related bits to Type 1 and Type 2.

> Do you have access to this amendments?
I don't have them currently, but I'll ask around my organization and see if=
 I can get access.

> > +/* LTC4266_REG_INTSTAT and LTC4266_REG_INTMASK */
> > +#define LTC4266_INT_SUPPLY			BIT(7)
> > +#define LTC4266_INT_TSTART			BIT(6)
> > +#define LTC4266_INT_TCUT			BIT(5)
> > +#define LTC4266_INT_CLASS			BIT(4)
> > +#define LTC4266_INT_DET				BIT(3)
> > +#define LTC4266_INT_DIS				BIT(2)
> > +#define LTC4266_INT_PWRGD			BIT(1)
> > +#define LTC4266_INT_PWRENA			BIT(0)
> > +
> > +#define LTC4266_MAX_PORTS 4
> > +
> > +/* Maximum and minimum power limits for a single port */
> > +#define LTC4266_PW_LIMIT_MAX 25400
> > +#define LTC4266_PW_LIMIT_MIN 1
> > +
> > +enum {
> > +	READ_CURRENT =3D 0,
> > +	READ_VOLTAGE =3D 2
> > +};
> > +
> > +enum {
> > +	LTC4266_OPMD_SHUTDOWN =3D 0,
> > +	LTC4266_OPMD_MANUAL,
> > +	LTC4266_OPMD_SEMI,
> > +	LTC4266_OPMD_AUTO
>=20
> Please add explanations to this port modes
Will do, I see now the confusion this has caused.  Sorry for that.

> > +};
> > +
> > +/* Map LTC4266 Classification result to PD class */
> > +static int ltc4266_class_map[] =3D {
> > +	0, /* Treat as class 3 */
> > +	1,
> > +	2,
> > +	3,
> > +	4,
> > +	-EINVAL,
> > +	3, /* Treat as class 3 */
> > +	-ERANGE
> > +};
> > +
> > +/* Convert a class 0-4 to icut register value */
> > +static int ltc4266_class_to_icut[] =3D {
> > +	375,
>=20
> missing comment, index 0 is class 3.
Ack.

> > +	112,
> > +	206,
> > +	375,
> > +	638
> > +};
>=20
> May be we should have a generic function in the framework providing conve=
rsion
> from class to min/max Icut and Ilim, otherwise it makes additional work
> validation this values.
Sure, I'm open to something like this, even more so if other PSE
chipsets use a current limit instead of a power limit.

> > +
> > +enum sense_resistor {
> > +	LTC4266_RSENSE_500, /* Rsense 0.5 Ohm */
> > +	LTC4266_RSENSE_250 /* Rsense 0.25 Ohm */
> > +};
> > +
> > +struct ltc4266_port {
> > +	enum sense_resistor rsense;
> > +	struct device_node *node;
> > +	int current_limit;
> > +};
> > +
> > +struct ltc4266 {
> > +	struct i2c_client *client;
> > +	struct mutex lock; /* Protect Read-Modify-Write Sequences */
> > +	struct ltc4266_port *ports[LTC4266_MAX_PORTS];
> > +	struct device *dev;
> > +	struct device_node *np;
> > +	struct pse_controller_dev pcdev;
> > +};
> > +
> > +/* Read-modify-write sequence with value and mask.  Mask is expected t=
o be
> > + * shifted to the correct spot.
> > + */
> > +static int ltc4266_write_reg(struct ltc4266 *ltc4266, u8 reg, u8 value=
, u8 mask)
>=20
> If it is Read-modify-write type of function, it would be better to name
> it ltc4266_rmw_reg(). Or use regmap instead, you will get some extra
> functionality: register dump over sysfs interface, range validation,
> caching if enabled, locking, etc.
Oh, good call- I'll use regmap.

> > +{
> > +	int ret;
> > +	u8 new;
> > +
> > +	mutex_lock(&ltc4266->lock);
> > +	ret =3D i2c_smbus_read_byte_data(ltc4266->client, reg);
> > +	if (ret < 0) {
> > +		dev_warn(ltc4266->dev, "Failed to read register 0x%02x, err=3D%d\n",=
 reg, ret);
> > +		mutex_unlock(&ltc4266->lock);
> > +		return ret;
> > +	}
> > +	new =3D (u8)ret;
> > +	new &=3D ~mask;
> > +	new |=3D value & mask;
> > +	ret =3D i2c_smbus_write_byte_data(ltc4266->client, reg, new);
> > +	mutex_unlock(&ltc4266->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ltc4266_read_iv(struct ltc4266 *ltc4266, int port, u8 iv)
> > +{
> > +	int lsb;
> > +	int msb;
> > +	int result;
> > +	int lsb_reg;
> > +	u64 ivbits =3D 0;
> > +
> > +	if (iv =3D=3D READ_CURRENT)
> > +		lsb_reg =3D LTC4266_IPLSB_REG(port);
> > +	else if (iv =3D=3D READ_VOLTAGE)
> > +		lsb_reg =3D LTC4266_VPLSB_REG(port);
> > +	else
> > +		return -EINVAL;
> > +
> > +	result =3D i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_STAT=
PWR);
> > +	if (result < 0)
> > +		return result;
> > +
> > +	/*  LTC4266 IV readings are only valid if the port is powered. */
> > +	if (!(result & LTC4266_STATPWR_PG(port)))
> > +		return -EINVAL;
>=20
> We have two states:
> - admin enabled: admin enabled state
> - delivering power: PSE is actually delivering power
>=20
> Please use this words to clarify what is actually happening.
Will do.

> > +	/* LTC4266 expects the MSB register to be read immediately following =
the LSB
> > +	 * register, so we need to ensure other parts aren't reading other re=
gisters in
> > +	 * this chip while we read the current/voltage regulators.
> > +	 */
> > +	mutex_lock(&ltc4266->lock);
>=20
> please use guard* variants for locking.
Ack.

>=20
> > +
> > +	lsb =3D i2c_smbus_read_byte_data(ltc4266->client, lsb_reg);
> > +	msb =3D i2c_smbus_read_byte_data(ltc4266->client, lsb_reg + 1);
> > +
> > +	mutex_unlock(&ltc4266->lock);
> > +
> > +	if (lsb < 0)
> > +		return lsb;
> > +
> > +	if (msb < 0)
> > +		return msb;
> > +
> > +	ivbits =3D 0;
> > +	ivbits |=3D ((u8)msb) << 8 | ((u8)lsb);
> > +
> > +	if (iv =3D=3D READ_CURRENT)
> > +		if (ltc4266->ports[port]->rsense =3D=3D LTC4266_RSENSE_250) /* 122.0=
7 uA/LSB */
> > +			result =3D DIV_ROUND_CLOSEST_ULL((ivbits * 122070), 1000);
> > +		else /* 61.035 uA/LSB */
> > +			result =3D DIV_ROUND_CLOSEST_ULL((ivbits * 61035), 1000);
> > +	else /* 5.835 mV/LSB =3D=3D 5835 uV/LSB */
> > +		result =3D ivbits * 5835;
> > +
> > +	return result;
> > +}
>=20
> > +static int ltc4266_port_set_ilim(struct ltc4266 *ltc4266, int port, in=
t class)
> > +{
> > +	if (class > 4 || class < 0)
> > +		return -EINVAL;
> > +
> > +	/* We want to set 425 mA for class 3 and lower; 850 mA otherwise for =
IEEE compliance */
> > +	if (class < 4) {
> > +		/* Write 0x80 for 0.25 Ohm sense otherwise 0 */
> > +		if (ltc4266->ports[port]->rsense =3D=3D LTC4266_RSENSE_250)
> > +			return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(=
port), LTC4266_ILIM_AF_RSENSE_025);
> > +		return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(p=
ort), LTC4266_ILIM_AF_RSENSE_050);
> > +	}
> > +
> > +	/* Class =3D=3D 4 */
> > +	if (ltc4266->ports[port]->rsense =3D=3D LTC4266_RSENSE_250)
> > +		return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(p=
ort), LTC4266_ILIM_AT_RSENSE_025);
> > +	/* Class =3D=3D 4 and the sense resistor is 0.5 */
> > +	return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(po=
rt), LTC4266_ILIM_AT_RSENSE_050);
>=20
> May be something like this:
> /*
>  * ltc4266_port_set_ilim - Set the active current limit (ILIM) for a port=
.
>  * @ltc4266: Pointer to the LTC4266 device structure.
>  * @port: The port number (0-3).
>  * @class: The detected PD class (0-4).
>  *
>  * This function configures the ILIM register (0x48, 0x4D, 0x52, 0x57)
>  * of the LTC4266. The ILIM value determines the threshold at which the
>  * PSE actively limits current to the PD. The chosen values are based on
>  * IEEE Std 802.3-2022 requirements and typical operational values for th=
e
>  * LTC4266 controller.
>  *
>  * IEEE Std 802.3-2022, Table 33-11 specifies ILIM parameter ranges:
>  * - For Type 1 PSE operation (typically PD Classes 0-3):
>  * The minimum ILIM is 0.400A. This driver uses 425mA. This value fits
>  * within typical Type 1 ILIM specifications (e.g., 0.400A min to
>  * around 0.440A-0.500A max for the programmed steady-state limit).
>  *
>  * - For Type 2 PSE operation (typically PD Class 4):
>  * The minimum ILIM is 1.14 * ICable (or ~1.05 * IPort_max from other
>  * interpretations, e.g., ~0.630A to ~0.684A). This driver uses 850mA.
>  * This value meets the minimum requirement and is a supported operationa=
l
>  * current limit for high power modes in the LTC4266.
>  *
>  * The overall PSE current output must not exceed the time-dependent PSE
>  * upperbound template, IPSEUT(t), described in IEEE Std 802.3-2022,
>  * Equation (33-6). The programmed ILIM values (425mA/850mA) serve as the
>  * long-term current limit (Ilimmin segment of IPSEUT(t)) and are well
>  * within the higher short-term current allowances of that template (e.g.=
, 1.75A).
>  *
>  * The specific register values written depend on the sense resistor
>  * (0.25 Ohm or 0.50 Ohm) as detailed in the LTC4266 datasheet (Table 5).
>  *
>  * Returns: ...
>  */
> static int ltc4266_port_set_ilim(struct ltc4266 *ltc4266, int port, int c=
lass)
> {
> 	u8 ilim_reg_val;
>=20
> 	if (class > 4 || class < 0)
> 		return -EINVAL;
>=20
> 	if (class < 4) {
> 		/* PD Class is 0, 1, 2, or 3 (Type 1 PSE operation).
> 		 * Set ILIM to 425mA.
> 		 */
> 		if (ltc4266->ports[port]->rsense =3D=3D LTC4266_RSENSE_250) {
> 			/* Using 0.25 Ohm sense resistor. */
> 			ilim_reg_val =3D LTC4266_ILIM_TYPE1_RSENSE_025;
> 		} else {
> 			/* Using 0.50 Ohm sense resistor. */
> 			ilim_reg_val =3D LTC4266_ILIM_TYPE1_RSENSE_050;
> 		}
> 	} else {
> 		/* PD Class is 4 (Type 2 PSE operation).
> 		 * Set ILIM to 850mA.
> 		 */
> 		if (ltc4266->ports[port]->rsense =3D=3D LTC4266_RSENSE_250) {
> 			/* Using 0.25 Ohm sense resistor. */
> 			ilim_reg_val =3D LTC4266_ILIM_TYPE2_RSENSE_025;
> 		} else {
> 			/* Using 0.50 Ohm sense resistor. */
> 			ilim_reg_val =3D LTC4266_ILIM_TYPE2_RSENSE_050;
> 		}
> 	}
>=20
> 	/* Write the determined ILIM value to the appropriate port's ILIM regist=
er.
> 	 * The LTC4266_REG_ILIM(port) macro resolves to the correct register
> 	 * address for the given port (e.g., 0x48 for port 0, 0x4D for port 1, e=
tc.).
> 	 */
> 	return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ILIM(port)=
, ilim_reg_val);
> }
Wow, that is much more clear.  Thanks so much, I'll change accordingly.

> > +static int ltc4266_port_set_icut(struct ltc4266 *ltc4266, int port, in=
t icut)
> > +{
> > +	u8 val;
> > +
> > +	if (icut > 850)
>=20
> It looks like board specific limit:
> From the LTC4266 datasheet:
> "Non-standard applications that provide more current
> than the 850mA IEEE maximum may require heat sinking and other MOSFET des=
ign
> considerations."
Yes, it is board specific but also sounded to me like above 850mA would
violate the spec.

> > +		return -ERANGE;
> > +
> > +	val =3D (u8)(DIV_ROUND_CLOSEST((icut * 1000), 18750) & 0x3F);
>=20
> I assume 18750 micro Amp, per step in the register value and 0x3f is the =
max
> mask for the bit field. In this case this register supports
> 0x3f * 18750 / 1000 =3D 1181mA
>=20
> Please use defines to make it readable.
Will do.  I'll do this for all the other current/voltage conversions as
well.=20

> > +
> > +	if (ltc4266->ports[port]->rsense =3D=3D LTC4266_RSENSE_250)
> > +		val |=3D LTC4266_ICUT_RSENSE | LTC4266_ICUT_RANGE;
> > +
> > +	return i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_ICUT_HP=
(port), val);
> > +}
> > +
> > +static int ltc4266_port_mode(struct ltc4266 *ltc4266, int port, u8 opm=
d)
> > +{
> > +	if (opmd >=3D LTC4266_OPMD_AUTO)
> > +		return -EINVAL;
> > +
> > +	return ltc4266_write_reg(ltc4266, LTC4266_REG_OPMD, TWO_BIT_WORD_OFFS=
ET(opmd, port),
> > +				TWO_BIT_WORD_MASK(port));
> > +}
> > +
> > +static int ltc4266_port_powered(struct ltc4266 *ltc4266, int port)
>=20
> delivering or enabled?
Delivering.  I'll change this per your earlier comment.

> > +{
> > +	int result =3D i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_=
STATPWR);
> > +
> > +	if (result < 0)
> > +		return result;
> > +
> > +	return !!((result & LTC4266_STATPWR_PG(port)) && (result & LTC4266_ST=
ATPWR_PE(port)));
> > +}
> > +
> > +static int ltc4266_port_init(struct ltc4266 *ltc4266, int port)
> > +{
> > +	int ret;
> > +	u8 tlim_reg;
> > +	u8 tlim_mask;
> > +
> > +	/* Reset the port */
> > +	ret =3D i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_RSTPB,=
 BIT(port));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D ltc4266_port_mode(ltc4266, port, LTC4266_OPMD_SEMI);
>=20
> Should we have disabled mode before all current limits configured?
Well, OPMD_SEMI means "Semi-Automatic" mode, which will detect and
classify connected PDs but not power them until instructed to do so by
software.=20

> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Enable high power mode on the port (802.3at+) */
>=20
> 802.3at+? "Proprietary Power Levels Above 25W"?. Here we will need a disc=
ussion
> how to reflect a Proprietary Power levels in the UAPI.
I don't know there is value in this discussion because a) I don't know what=
 the
datasheet is referring to about these "Proprietary Power Levels" and b)
I'm not really interested in adding support for any proprietary power
levels because I can't test them.  The LTC4266 can power Type 1 and Type
2 PDs.  There is a support for high-capacitance devices (seen in really
old Cisco IP Phones), but this support I left (or intended to) disabled
because I can't test that, either.
>=20
> > +	ret =3D ltc4266_write_reg(ltc4266, LTC4266_REG_HPEN,
> > +				LTC4266_HPEN(port), LTC4266_HPEN(port));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Enable Ping-Pong Classification */
>=20
> This is probably "2-event classification" described in Clause 33 of the
> IEEE Std 802.3-2022.
Yes, this is exactly that.
>=20
> > +	ret =3D ltc4266_write_reg(ltc4266, LTC4266_REG_HPMD(port),
> > +				LTC4266_HPMD_PONGEN, LTC4266_HPMD_PONGEN);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (ltc4266->ports[port]->rsense =3D=3D LTC4266_RSENSE_250)
> > +		ret =3D ltc4266_write_reg(ltc4266, LTC4266_REG_ICUT_HP(port),
> > +					LTC4266_ICUT_RSENSE, LTC4266_ICUT_RSENSE);
> > +	else
> > +		ret =3D ltc4266_write_reg(ltc4266, LTC4266_REG_ICUT_HP(port),
> > +					0, LTC4266_ICUT_RSENSE);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (port <=3D 1)
> > +		tlim_reg =3D LTC4266_REG_TLIM12;
> > +	else
> > +		tlim_reg =3D LTC4266_REG_TLIM34;
> > +
> > +	if (port & BIT(0))
> > +		tlim_mask =3D GENMASK(7, 4);
> > +	else
> > +		tlim_mask =3D GENMASK(3, 0);
> > +
> > +	ret =3D ltc4266_write_reg(ltc4266, tlim_reg, LTC4266_TLIM_VALUE, tlim=
_mask);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Enable disconnect detect. */
> > +	ret =3D ltc4266_write_reg(ltc4266, LTC4266_REG_DISENA, BIT(port), BIT=
(port));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Enable detection (low nibble), classification (high nibble) on the=
 port */
>=20
> This seems to correspond to ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED=20
Yes, the combination of OPMD_SEMI, PD Detection enabled and PD
classification enabled corresponds to ADMIN_STATE_ENABLED.
>=20
> > +	ret =3D i2c_smbus_write_byte_data(ltc4266->client, LTC4266_REG_DETPB,
> > +					BIT(port + 4) | BIT(port));
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	dev_dbg(ltc4266->dev, "Port %d has been initialized\n", port);
> > +	return 0;
> > +}
> > +
> > +static int ltc4266_get_opmode(struct ltc4266 *ltc4266, int port)
> > +{
> > +	int ret;
> > +
> > +	ret =3D i2c_smbus_read_byte_data(ltc4266->client, LTC4266_REG_OPMD);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	switch (port) {
> > +	case 0:
> > +		return FIELD_GET(GENMASK(1, 0), ret);
> > +	case 1:
> > +		return FIELD_GET(GENMASK(3, 2), ret);
> > +	case 2:
> > +		return FIELD_GET(GENMASK(5, 4), ret);
> > +	case 3:
> > +		return FIELD_GET(GENMASK(7, 6), ret);
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> > +static int ltc4266_pi_is_enabled(struct pse_controller_dev *pcdev, int=
 id)
> > +{
> > +	int ret;
> > +	struct ltc4266 *ltc4266 =3D container_of(pcdev, struct ltc4266, pcdev=
);
> > +
> > +	ret =3D ltc4266_get_opmode(ltc4266, id);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (ret =3D=3D LTC4266_OPMD_SEMI)
> > +		return 1; /*  If a port is in OPMODE SEMI, we'll just assume admin h=
as it enabled */
>=20
> From HW perspective, every mode except of LTC4266_OPMD_SHUTDOWN can be se=
en as
> admin state enabled. LTC4266_OPMD_MANUAL - is forced mode controlling
> power delivery manually.
In V2, I'll add a lot more information in comments and such that
describe these modes a little better, but until then:

OPMD_SHUTDOWN means that port is off and will not run any detection or
classification cycles regardless of other configuration.

OPMD_MANUAL means the port will run a single detect cycle after the
corresponding bit is set;  additionally, it will run a single
classification cycle after that bit is set.  The problem with
OPMD_MANUAL is that there is no state enforcement in hardware, meaning
software could instruct the PSE to apply power to a port that doesn't
have a valid PD attached, and will apply power regardless of the result
(if any) from detection/classification.  Frankly, OPMD_MANUAL scares me
and I see supporting it as only adding risk with no value.

OPMD_SEMI means the chip will detect and classify PDs on enabled ports
and will wait until software sets the corresponding bit to power on the
port and (critically) only will power on a port with a valid detection
and classification result.

OPMD_AUTO requires the chip be powered on with the "auto" pin high, and
will automatically detect, classify, and power any valid PD.  I don't
have a board with this configuration so I've not included that support.
It's a little unclear to me what is possible to configure from software
when the chip is in this mode.

>=20
> I need to make stop here, i'll try to review the rest later.
Thanks so much for the amazing review thus far, I think I've got more
than enough to adjust for a V2. =20

> Regards,
> Oleksij

Thanks again,
Kyle=

