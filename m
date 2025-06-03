Return-Path: <netdev+bounces-194852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE2ACD020
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 01:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833481896A50
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 23:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839B1A841E;
	Tue,  3 Jun 2025 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="lmSaT8v+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2068.outbound.protection.outlook.com [40.107.103.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48700AD51;
	Tue,  3 Jun 2025 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748991882; cv=fail; b=KiQhxb0qqCvTbTLuv5/kTOpFBTYsLZVpawdb3vjlvo3Htuhi+l0lqSFiru1yj/JR9Aw0vK+ZwqSwFcotC0UuEDkx3OWiYSJMUqYw61JG4arnVW46bbjyAfp4cwFPMaIlJLHAgt8u5DQurWCGPLgivw3CXHR2p1E4gSJ6niW8B/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748991882; c=relaxed/simple;
	bh=aobCdt8P+uudlV213Qph6DIHDk65yVuG5TLDusEp2u0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XCc/YyJ0gIgYRJZ6krFT9Hm+588PFUXYR73khIXihODYL1/SYjv2zNbcBDUR6it/4JOn3CwYFOHwcbnfpTIXosxM9MywNAAlNVwulEdgGRhu0tJHQ9w3b5bCdisdLPGUscTFB5Jh499fbp89uBDLN/pNM8pGJ7M8wl01gswc8v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=lmSaT8v+; arc=fail smtp.client-ip=40.107.103.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZzU416GYMc9/RFOR3obW0yStwkn2Woei2qqg++Sc/IA2VITN3AuEmk0Bn1dt1GQdkpDOzRLhcj9w6xV27qQCxFLUSykF92Qafla5shmmXqeiwKsLg3fkcLGOXXhR2ZFiLpmbn5lLtYLR3TfMBjcOkoolV+kox2Q4HQI/RO0EAu97VJPKvuorgGvFYSs9VIR1xX+ZZN+m5ReE8mCD9nFfBfSk5chOp/igSaghN8H3R6xbLSqdsrukda3KqpcoeSXhyDIB9vp3IFvik+TanrsuN1wyXpkpTfYfhM/hGgv/HOEw2rLBvrOcko6KXneDC1mHDdgZgjSHm0j46YpuOWdfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4JtBoGwQycNqWttumZOYhHsIJg5AgbT8FK1VHeJLGc=;
 b=GFzcPg2MOVZMv7g824FV/52OmfSsMFSSTInAgTePI5ACgHDPmxLJQ5G3n2uyDLjJPL0J/8lEHFkGErIclItUEMP+riUWWjMgiKdcvZKBMe99d5GZPC1NBIszeMv0zgtfHn6O+7fyLmTkRWjhfnIW6ileo5wqonzPESKJBvbsjLyzIupcLC4LHWPI65lIXANhqCoz/LZ8ydToDNCnxAt5N7Aq8yPYAignLEkl2oszc36rcDi9S+GKbacavBYyqXHWxVXE+Jdne/Df6m7Mwkecqe/oF4VMMaqrOSI82rZKREqI9ED+X2NaJplsE6W8H0V8t3Pm6+8FQTuDvmcYUwUWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4JtBoGwQycNqWttumZOYhHsIJg5AgbT8FK1VHeJLGc=;
 b=lmSaT8v+oxgkk6RQ3hkrz8rNOpYQR3c7Devum1RDr9PL8CJrz/RR1tD24yOXToKd+oOCWspOlCmC+RxOfzbxtD0C1ecqMIwLAk8VKNwCnlVDz8dY/ZBvluRQ+orWTk3DuHKg2Yr3vb9f2VGJbjxn+96RwOMsDwKzYuMWTjx3biXEo/6QhX88TkykUL1RFSIJEvnrZpj5SaOnWRWBgg2pby0HhWg9IZu8269buGvuiCZ2BMD9cBmRFTpeJhVTSfLuOUsU8srnu/hwWyXtAPGpNyRX/2yO5IWxB2LzqiLJAs5/6i01KR70FDvvIJJFMtskg3gaPnoVfcm2yW5D3OWdUA==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by GVXP189MB2104.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.36; Tue, 3 Jun 2025 23:04:35 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 23:04:35 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: Kyle Swenson <kyle.swenson@est.tech>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: [RFC PATCH net-next 0/2] Add support for the LTC4266 PSE Controller
Thread-Topic: [RFC PATCH net-next 0/2] Add support for the LTC4266 PSE
 Controller
Thread-Index: AQHb1NvfnzczR5489k6/erC7mw35/w==
Date: Tue, 3 Jun 2025 23:04:34 +0000
Message-ID: <20250603230422.2553046-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|GVXP189MB2104:EE_
x-ms-office365-filtering-correlation-id: abfb62b4-dbd7-48bf-a3cd-08dda2f301fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?hrR+vC1p0HbDjeED58Beb6bjD+dv1+rqNcH4nWSR/pt6dVuBO0fYCN3H7y?=
 =?iso-8859-1?Q?IawzWwDBUcEqU+Cki43OYSkhu8z4ueobddUINyi3Fr6e4oGivyID3rwKaE?=
 =?iso-8859-1?Q?zpD2mIZWTHnVDTz4gm+5jAYy+p8g8NpAbLpikpXeHBJFnlTysSHVCKz5oT?=
 =?iso-8859-1?Q?Q25j2lsonL9xqcxhW4DUa0JKn1hC7nWdcQlSKoQnBKLSfukKjRz/4168Gs?=
 =?iso-8859-1?Q?+Gcga9uVsqC/c8YojRtC3Mkh1nqJBZ5ntAkDxHjgPVAwd8tLRoeAzqjJEI?=
 =?iso-8859-1?Q?z2XN7BRW3epAkVsNjfTjpzIXC/UmvokssThWkzoEyuQh6c9owGn1cz5wlZ?=
 =?iso-8859-1?Q?IYnKsLBomw2x/g/wbCv2uToV5hto5c8uQJKSaI91qLjTwBIUq53Kl1ZJEX?=
 =?iso-8859-1?Q?7HPoKUyCbSOP/h9w0uWod0fyNbSbZMXwk57ksx8n83ZEuT+htRF12Zghi0?=
 =?iso-8859-1?Q?3pNbd1bxK7qy4WJU1Ig8S74KRYQjZ3fN3L/BmnO+aRLZE0M8FKzFCW5XeQ?=
 =?iso-8859-1?Q?KazQB3r12sHRQ8E9JPBx8j+nakuUo5dkwi7owV1G1B+w8C0BEmSFAa2/Vy?=
 =?iso-8859-1?Q?h1zqzt/6E554ZnR5oJKkUsgdcy2eVls8P4QY62qi9MxAHflUA5vs5V+pNW?=
 =?iso-8859-1?Q?kzCEq6ca37fpT21xh0r5sq4bkhOp7nGX26x7ocVkSDUgzVN9lt5ppRORSK?=
 =?iso-8859-1?Q?n6cuj0saeKeHWSYQtxYuMJ66tmdmK8Zz9HLQrhYZttjCCo2SOS49JAWBe4?=
 =?iso-8859-1?Q?YhZzYtZhZYBbyK9ODOuqkyUfilWLRDcdNq5yTolIq47pvAsNUnRc4pyz4Z?=
 =?iso-8859-1?Q?hZ4mlmGM9ExfwiIPOCAH7lBX2vpdkkK1SqMcRy6HscqZAznlwhX13bnzph?=
 =?iso-8859-1?Q?KvwxKJGNVkn9OW4vA9Jv3Y6cIGk/mF8VXHvVOkh+EYFjx1jkBBIfrFZbMZ?=
 =?iso-8859-1?Q?q+U3BERLIwjIQeRa6O6LO7OVbeCXPwGa+R+TxKTrrx0FgyBAT4J3IokFA7?=
 =?iso-8859-1?Q?jkDsAdcqcCAi+MGgIKC+0xPhqPpOcyLCuJvH/7T9BXoFfe6KccFXqLSq6i?=
 =?iso-8859-1?Q?Z+C8pXW/JMrkwVE6+2m1JFaJAOpzvQM1apVBB4bGdqGz8IGB//BJaBXXaD?=
 =?iso-8859-1?Q?wP8Xd7Nafe9bqurP19cHAbHuFmZVDev8kyBrXjoDfpaC8N3yo99hYZK9PR?=
 =?iso-8859-1?Q?7ZSI8BouHl1wuzZEdDiEra5H7oKbGaeiksvS5cjIYdjlRcL2c/qqBRCvNe?=
 =?iso-8859-1?Q?O1ceAQFxUhAx+IhdqJXfvF17gqXFcln2KHjErJFCf7Z9+EPYR6E+m7iINb?=
 =?iso-8859-1?Q?7/7fwSukffj+gI47XB3ZqbEF4jhlnHO+wyG3bCrBcgMXMGBcY7rT8fDhT/?=
 =?iso-8859-1?Q?zyCv+XToFkSqCgrk+J2saMchgeHgF8EoC+7i5PMAwSen6YMFYAVvqpbyL9?=
 =?iso-8859-1?Q?WHC5/wxqKi734/NsLrA5we4yT7WGUw9JPVIk+fkQNOeE+sFotPHyAIxYvW?=
 =?iso-8859-1?Q?vfHoFsrW5cbq/iR5pb0Ej7bjJyDfIZLpj/LPgUqY8hhrdHq2PLhHYnTZKY?=
 =?iso-8859-1?Q?Cmir6jI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CUWrJTTLbENmdpcOX2V7s6qRbhb1IA3JUWLF/Ph7nrUMqZW6U4+lKWTKID?=
 =?iso-8859-1?Q?0Yk8fx2buQ8B9e1Qqate2lw8EC28/rJnrR5k7rEQH4I2NB+ZGERmMKgZ2n?=
 =?iso-8859-1?Q?7lur+yaxGnnh8eEt148M1cw8LTTspDozk3Pm6zTHlhlwSE1HExBj5RmbgJ?=
 =?iso-8859-1?Q?FBD0LeuH3qbdA8LLjZ++2om+m5GBYcd0Fh5Ag1KRdw7TX9Vn02El+JLQkD?=
 =?iso-8859-1?Q?OLUbXtGeuFT8g+PuCg41AvbT1YPo3G4cXQqJ5VBEye+gYfEe1Hbzuf5I1/?=
 =?iso-8859-1?Q?XLxFrfHedkt88wJXUeQsn4JpU8RS/NCGGDEGJhHCj6GO2mJuY3cUQGq89u?=
 =?iso-8859-1?Q?1s9tkFOdensjAlddHneW8o9YpP4JZVmLRFnKzE2JmBGIMDhcjkMZ67acDu?=
 =?iso-8859-1?Q?uZHA4WDYhw28ekgWD2HZftJRRNzkSu2X0gDt+6tXK9Vo1DmuX90/C5Zq2e?=
 =?iso-8859-1?Q?UZOoWCAvy3YzTrUEPJrHYoymY5yRfpGWmZR5pSCWD5ffzpDmIyiWrNBAz6?=
 =?iso-8859-1?Q?FfkCMzdWVOWJ3JxQ0t2QXZU02S+9xc7MSe+rLQDOK4bLDLHp6+K2P9EPWs?=
 =?iso-8859-1?Q?97aqMoqsgRn8E1COoPJSwQo7N/7/Z9FqDlBo4IWBJasDPIgCv791xs5MXC?=
 =?iso-8859-1?Q?rOBcVXlFig9waeQ0UuisYpawI0+Qkz3w8aVPcfa5xvrAXd1O9F7+cBG8UV?=
 =?iso-8859-1?Q?KtS4j7Lj9FetduWdUvkBkNXs0NCNIpS0tQWrreGAV6UnzLf6+3wA1oYBSI?=
 =?iso-8859-1?Q?zYQcUMqGdMDftVquockX54YZwa+45zWA/pWVhPvKZOdZp/1THATgEFft1k?=
 =?iso-8859-1?Q?iOtxNBJAqF5RWcNrZeEIC1dZL0a0nUr/kqA9Xib8vphmS2GICAEWff/OYw?=
 =?iso-8859-1?Q?BP+OUO7HDlMsmq0fa8EAnNm9/pMLeXjjA8rRkY6uEnQ9azHkVUQR+BVEs/?=
 =?iso-8859-1?Q?GZZ5LzamMrjFz34UW1K/YUJvbbUXO/OUeXQApo1wLy9TY2Ggff6utmBEtq?=
 =?iso-8859-1?Q?ng8z2LO2JUNAWHoRvLDKhGqVRyH3D+bHFxZNkbWLIv5EQsjcn6jCVlbFWf?=
 =?iso-8859-1?Q?oJcmCl6QGaMBJDD7wTkfYHb+oBB8Q7ZKy3F7+WdPAatvjd+bondDl8oCed?=
 =?iso-8859-1?Q?8v9KDy8/YDv+Ml9OTgc7nWnFDLTAl1AdXDGCbfp/LwhoNRhNHXD1PFcEol?=
 =?iso-8859-1?Q?M1tQhRDVd767ujSzyWHZVN6YbeWnR5TRfycsFFFjWpFjxkInmixSAATJih?=
 =?iso-8859-1?Q?UcMFJIxxr7Be8HhG/pkHeXazFG3UJII++N0CyMH6tGoeTI6Pn71MTw2gKE?=
 =?iso-8859-1?Q?GhiZvMIq/NZX3+1bdUtq3Ct8sp2OK58hkFrUiUrklUoIyijPP9K3DUYa7Y?=
 =?iso-8859-1?Q?KNTC5IXBys3T4Ss3tirKG8oAfuE+FSUvd1CO4T+4cM1WdkW2DmjzXkOoOO?=
 =?iso-8859-1?Q?QBMOKtNUoQf9BhNHJY9iVRpzu/HiBtvYd11qDtkoA2O0rAyUwmzeKVfoU1?=
 =?iso-8859-1?Q?mTSoXyNZ7x8KQUb1paQRsKIPeR57QYMxWpPu5v4MI9V3yhepNO+O7pd4yu?=
 =?iso-8859-1?Q?Rq2o61yfbDmNWaZKjSlvzCXMjpXk20JR/dCucfcYDuiZbtt62T0RQuoqTe?=
 =?iso-8859-1?Q?y+awKrhn3UTliNgsTP4QmGx9LDqxMAbOCoxthbyjD8hWGrO/mvgzmbMg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: abfb62b4-dbd7-48bf-a3cd-08dda2f301fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 23:04:35.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J609/KFeArnMmD9ojIBl0EBY3IG6weldEfPZP+HY7wPwxrd2Cr3nWMpKwTn9WiBMgfZmdIiJRC/K6jBshx+WqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2104

Hello,

This RFC series is intended as a starting point for adding support for the
LTC4266, an older PSE (IEEE 802.3at+) chipset from Linear Technology.

This chip has four individually controllable ports, each with its own
detection, classification and current-limiting abilities.  Currently, this
series integrates with the PSE controller core and supports enable/disable,
current and voltage reporting, classification results and will power up a v=
alid
IEEE 802.3at or IEEE802.3af powered device.

It also (poorly) supports the power-limiting functionality in the PSE core.
The complexity here is that the LTC4266 only supports limiting the current,=
 and
so deriving a "current limit" from this power limit while staying compliant
with the IEEE 802.3at/af specifications is tricky.  I'm curious if folks ha=
ve a
better idea than the linear approximation I've used here.

It is RFC because I want to clarify some confusion I have around the
system-level flow for a port's power allocation.  It's very likely I've mis=
sed
something, but it appears as though the port needs to be delivering power i=
n
order to set the power limit on the port.

Thanks for your time,
Kyle

Kyle Swenson (2):
  dt-bindings: net: pse-pd: Describe the LTC4266 PSE chipset
  net: pse-pd: Add LTC4266 PSE controller driver

 .../bindings/net/pse-pd/lltc,ltc4266.yaml     | 146 +++
 drivers/net/pse-pd/Kconfig                    |  10 +
 drivers/net/pse-pd/Makefile                   |   1 +
 drivers/net/pse-pd/ltc4266.c                  | 919 ++++++++++++++++++
 4 files changed, 1076 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/lltc,ltc42=
66.yaml
 create mode 100644 drivers/net/pse-pd/ltc4266.c

--=20
2.47.0

