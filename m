Return-Path: <netdev+bounces-172948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64D6A56962
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4857AAE04
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C821ABA6;
	Fri,  7 Mar 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dC2bbFiz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF921ABA2;
	Fri,  7 Mar 2025 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355453; cv=fail; b=LkWWHkJQlWJTobUdaiPLOHuUbpga8nYx/yaVBGEsn6i6Q8IO4riSjIzysc062RFmoFzsTrkPu/IFBbQHIJcNYvo6+99pCS2ewP93y3n7kPwEUVPNxtrIzcFeQ9wjSMQx07wJt5npavf2SaBQS5jf48NOtIbAItbv6BPFowkp3MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355453; c=relaxed/simple;
	bh=3lX01sVOmaoNXZYPR6YPUjLJiJ8409rhSTk88ylIy70=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qj8VxWAokj3kjZi61qp0NFEuBC/7eBPI+B8Qrz3KfGCYkiYv1e9TQ+7iocLlNU0AA1SJqyA361Y2hk2inlsv6FOS7NeHpeAMSUotMmw+8yl8qMogHbazG0QQt0ENVBXkt3wVeoV78XPL93awrsT8UMV7ZPb2AFKlL5HwbFEFlEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dC2bbFiz; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxVIQYeAzeeNTDTtLGLW7/pG6Q4WfdGTeHWWNSLeW5sdi51mtdGe3b3TZeaowJBbLC3IyP9epSqw92FFw4X6EzaAxX3ID3bF/lhqIYNvs+GCdtx+hJEJ2lj3zVj+zHA8Gip4xnnNYhqW8PPRxJIV0XvMztZMPlBRX0Tzo8215NDGgFJ8XeeGPvuDGZq4KznxrGezI0KBrM82rKY5HR5CjEiWiRHIVO2YVv7WQncYvV5lplJ08p4C2Bw+0IH9AqrVFGca73VKql6NaobY3Nk99R03v+vnDaNBdjj9dipYH8x1Ri6BvC/bmVZwItMK9yhWlotZFuBTVXwCXVFljk2exw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+ccj5fF8H3yoZuAAIOHhzfqPv0I+sJooA2kFZ7fZvA=;
 b=Bdpc3JvsLkzmqudnqYEFVg9479pXIkgvYk5OE1T+UTijXufpLfOR/O3PxRmnf8ZOAfZ0LCl9mONx7H/SV1jgIU53yq3/Y5fQes3WhzHvJ4GX1UrCkRqvX1rXNhvjGLfY7G8LFwWSonGSIZR7v26tlHSfE6JOdF1b/51vhKtem2EqAfYeiPbsZfKi8XIzrbIiasj+cVMVA0U0q8MAE8P9+q7S2gA3d1EtneoVfjMBAlPS2+OA4AEveq68c0fwfP2CFMeUPQaqo6c7udD/S9fXLZomqkia+jgEo5ij1gwrNnmGqdnt7zGMzPuD4pDH2Xzzl375E3vZMWN0BCs/DT4D6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+ccj5fF8H3yoZuAAIOHhzfqPv0I+sJooA2kFZ7fZvA=;
 b=dC2bbFizfLkyaAC/Q4YyWeyCEs9v087ZYfiOKzo0GKppa1DFMdD2PVKM83ZGsqSZFqPlSgrycQXFXu2rRUhdebh/YDRfBCK8JjcidLGNAhshsUqSVMbzFgBZZ/zbbRAYSKgMQjwF8KHH54sv71RmahI6nvmx5WaN042n3ohv+Hl1jWNUxkHyl5u3+qH15a7CKj9LyZgh2luL31SH9Ug5IdpmAEpT8etoJ/CYNJ+B9Vk60ROklWN0M/XPGw3PXKcHWVZbksNcmQb1LXG5u5v+akU2Dk1c10BE1QCNkPG+gySLaCgiyaPj5u4LlJW0Q0BwP4vHImjJGjtppOAmrWhCCQ==
Received: from BL0PR11MB2913.namprd11.prod.outlook.com (2603:10b6:208:79::29)
 by DS0PR11MB7632.namprd11.prod.outlook.com (2603:10b6:8:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 13:50:49 +0000
Received: from BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742]) by BL0PR11MB2913.namprd11.prod.outlook.com
 ([fe80::3bc1:80d8:bfa5:e742%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 13:50:48 +0000
From: <Woojung.Huh@microchip.com>
To: <o.rempel@pengutronix.de>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<Thangaraj.S@microchip.com>, <Rengarajan.S@microchip.com>
CC: <broonie@kernel.org>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <phil@raspberrypi.org>
Subject: RE: [PATCH net v1 1/1] net: usb: lan78xx: Sanitize return values of
 register read/write functions
Thread-Topic: [PATCH net v1 1/1] net: usb: lan78xx: Sanitize return values of
 register read/write functions
Thread-Index: AQHbj0l+IQ9WY62X3EqtrHc9qCVv6bNnsNEw
Date: Fri, 7 Mar 2025 13:50:48 +0000
Message-ID:
 <BL0PR11MB29131B7261357332CFAF2548E7D52@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20250307101223.3025632-1-o.rempel@pengutronix.de>
In-Reply-To: <20250307101223.3025632-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB2913:EE_|DS0PR11MB7632:EE_
x-ms-office365-filtering-correlation-id: 03db6167-2e93-4288-02a0-08dd5d7f1127
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VteDhBCeTrUapK1LEKQY2b7WJY/wwFbeKQKZ4V3yIVNb9LBx1HnZIxWXWAkE?=
 =?us-ascii?Q?t+5ji91yYnNgYjr2Gk/3SvkiyPSjd48JDKp7AyiO4Yz/UeKjqy0nsuETuyhM?=
 =?us-ascii?Q?LSKobcPiygm4cJjV640Iidj9WTAThIQEdOX5k1iw/XQfHspxBESO7fdM35Qd?=
 =?us-ascii?Q?1rivBIssZJJSJ4IvT8f1i4oas7g0aJkGyz8d3TliPMSag1JgWLXb/gS/D5cx?=
 =?us-ascii?Q?6oY8zxCZayjXn01VH29PS3ZBpgvV6cZ24EN50KOKrFinGqxBF1A93G5+wPCL?=
 =?us-ascii?Q?94QPyLM/KoFMvMfvbELnIrx+5V//0lpg51TpwzO12pLxpUrSCq3vESVnGo7p?=
 =?us-ascii?Q?eQMhJFrD7ZMJGCYPtH3kJLgNFalRZQX8GU5xz23JH5vR93g9/E183Bti8X5M?=
 =?us-ascii?Q?UWNysFsHPaVbYfnEsOqdMGBT+Dg763WJBbH3YwKRLdl1N/t9l3qKuLoG5uvF?=
 =?us-ascii?Q?UlP92y5sxuac9OsBtj0qwS/LCtq+lEir7aJyM+IxAVvjdmo8ks1d28a6RjVm?=
 =?us-ascii?Q?unrgajzHB7nTnDmzcoaB1okiBvHMIHg/SpZEiIX9zAfBMYmpSMjgqPtfHgwD?=
 =?us-ascii?Q?q9SGaZ5vpznDKZwzqIcloy9bvxA4A0jPlVmAxEZsFTBN/y4uFtwF+pXwAko1?=
 =?us-ascii?Q?68VyqbH45Nhl2f5tYshQbLH9BvlRPHlI+0Uqr+DiKwf2z5LSDb6wCA3HXUK+?=
 =?us-ascii?Q?j3Jw3mGbEw1srsTYZvgrr1VjYlFrGp0l3KImm4XdW5U9v590diS/t3Vgjr7w?=
 =?us-ascii?Q?CBveiwkB0jBGF65efUuPVJitY05PI0pyIM6JOUE7hl2tFIeqtW4Pkn3+DJ3z?=
 =?us-ascii?Q?pqpja4tIgPDOo7jy3pGHNlRfMvbOdPKn+LwOc5HN0lmIigvQI+6fUElTmPOx?=
 =?us-ascii?Q?B3VqbyNs/dHEYxtAPHL8jFE1wjwOl9+2Fn5QkaWrxmeE0iTE0cE3OBUBLpBU?=
 =?us-ascii?Q?jQeIz5BQM4xfzWIj0r39X74QRCjbQx584Hs1tpj0fdQnytH7QtjH6Sz0GjJU?=
 =?us-ascii?Q?62Z/NEF47WV0AbvqJQMHVD3DvThhJDJA4vssUHpDFpKQ/NHBaOK3ttN9hTFo?=
 =?us-ascii?Q?Cj6m19tUsu2DPBgwL7vqbfjpSK3pKzr7F5qCF6xctlZFeHkpyXVJfxqUsIhR?=
 =?us-ascii?Q?mT7eL80RO8JbHDHpdmGP0yDUJXAZvI5d92vhNkmWeUHeMyCUWkcdgTgHqVkm?=
 =?us-ascii?Q?/KHBNIr/Pah+J/NlhVeEap5YNDtbhdWz2thb7ZNiUv+hzqCt7dXsk2dsQkCz?=
 =?us-ascii?Q?Wf8Ka3wkl8ApBYKoxySi/FWZWXmDwLOY4H2aw9qGpHFg+QAtlYdYuWNNdcuj?=
 =?us-ascii?Q?/tDklR/Is5RolCgu3rThlDXly5uEfoneiDHHnci/BTLqlr3wqKvlNe4cmUJq?=
 =?us-ascii?Q?+ULzLMncdIsBnGujctUceom65HwhdIWH/JDR/ZcQhqgweAmVpg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2913.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/slJKbPThljfCTomuVoyI6vJ69Pb2lU59h0bsleCwy3O618+9adUjVNEh7oR?=
 =?us-ascii?Q?oK7p3X4Z5yBEXriMkOc1R3K5+7K9MzjmM0WVbTUCFX6iyVtpKEWTJk3bmkkn?=
 =?us-ascii?Q?jYPgykr8oMToDCxKKKLur9ev5aZAAGa1OOco8w+5M9GiQWc86CwLZHF/q18i?=
 =?us-ascii?Q?fqY5ub5PwKDV0cK03ZcGLJeYFFfikop3dTWeTpkaW/tuCFT8+sf+QoINjWxu?=
 =?us-ascii?Q?isWDNHcrIWgj2GMq2IDqEgNLccl9tFjaO9OEuegB01FhXp1SCo+BHnkdRkSe?=
 =?us-ascii?Q?VEg11oUIkIJWMSOlULPR55xWjPse6Wg7bxSp5+c60ihg+/WFYjdnbz3/GsYa?=
 =?us-ascii?Q?JNCWIFKxn5XmPyHUX2O/wBG5L0mrZAbQ+JcPLaP/OWGxwCVQDxo0UKiAC9dE?=
 =?us-ascii?Q?RExyNMHXxdPnVgK/A10mBH0vwT6IE0P6UfHhVgCd/v9TC3fmUZcsfgNJh0h8?=
 =?us-ascii?Q?DfpbG9WYtProoHlzBDamfXbALSqw5w+3RepPZhr+IhirTrWPxgLKvnZIvrQb?=
 =?us-ascii?Q?HXT0/yMAvPN+FjBGeawv9LUYXO1I2iyg9Z9V5DSt9bVRGJeR/BUDEcMPgtay?=
 =?us-ascii?Q?OakZwU71qPe3VSHkbgPgBk6P2lDeU4iuJgeGH3iyjs7Lu1NUV55NMy+SlXUu?=
 =?us-ascii?Q?1EXy8ov49wxEa2icUnIDcwhY2A2l3ngRXCF4yz+P5a/hy/7C4Mj3msc56a6b?=
 =?us-ascii?Q?l+T8hgWG42VgdkVrbDmJHjvkRII+cfwOQ6wYHqNUtfP9LgeEC0DzyZTaiNTS?=
 =?us-ascii?Q?tYuA+LllNtAVnNW+owoG9cJKLL+vGrN1ZKvxBfVwtJbYi4wAUyQKxyxEcXZI?=
 =?us-ascii?Q?ScSeluwIrf5MDGn4qMw8f9bemDPn6gPoeje0k3vvvy2kiBm8HtadliIdiLFj?=
 =?us-ascii?Q?ifHE+Qp2HoVXs9KPWvkbDc/XKi6ikxBQGQPQrStGB5EY/Gf1jkrlk1+qIiCr?=
 =?us-ascii?Q?OMPzWTLm3WPIVkfmgZeBHaagF/NKMIOGUeKXBp8AWQqjn+/xj3qwqMNq/aGy?=
 =?us-ascii?Q?N1jmvTAIPcAW/3FHwWHZkvEAjYA459f8ZJfrgzKYs7wPIhjDG6mX47HcA7qU?=
 =?us-ascii?Q?G09S9pgZ5LobTS+/UwiPaEfGHeiMCB+rpDnv0uHfY1yNbVxNFSyZ+TylAZ4x?=
 =?us-ascii?Q?9tbWwiRF+Yi/Ob9QuGlbMZVyL0rsnfXrA8QWQNKy7HwYoYpMtTDw0KQ1MV/3?=
 =?us-ascii?Q?FvwdQZ0teqgxdLbuxl2LgXQm1Qf+2/vXGS+3sEE5z+1/Wtom1k/ux3t2jc5u?=
 =?us-ascii?Q?pnH56a84yitnmWU5EUrLFY3eMPUEfob8tKGrS9AmwhkAtTwK9TCnzijnaikl?=
 =?us-ascii?Q?VW9Y28OJsuPRnVTTjuZNkTicDAvxhFIWEa+ZCRvmv51jgkc4dvrwI3uMahyI?=
 =?us-ascii?Q?ow3wSgYVb3D1zoiDIfKGpEu4PAuOdrxwweiJssyFCQe+yTCIQyVzixQRHLKW?=
 =?us-ascii?Q?WIi9RJoGe9+paP65qMEY4Nk6bPoRpbXPyhRA0HcXmeg/lrSfV0KvXSSKRNHW?=
 =?us-ascii?Q?uHnAdCdOqCmM5hEPOVmHaHAW7OYLRLa6a6OhxD8pam3Km18kQi0RWqK7aoHL?=
 =?us-ascii?Q?xXRW3LIZrh/9KV71LrUvCZ7onFCwIpqlWnOmsjkd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2913.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03db6167-2e93-4288-02a0-08dd5d7f1127
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 13:50:48.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OpeyvD6b2CJX09CHX4bIi8POLIaeUqUzvDB96aLva9mnObvNb6IC6xHSXqokC0OKa2caliWlagueZdgC/Dc7nKeXBZu+yymF20bqTY1V7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7632

Add proper maintainers in the list
Thangaraj Samynathan <Thangaraj.S@microchip.com>
Rengarajan Sundararajan <Rengarajan.S@microchip.com>

https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tre=
e/MAINTAINERS#n24528

> -----Original Message-----
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> Sent: Friday, March 7, 2025 5:12 AM
> To: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Woojung Huh - C21699 <Woojung.Huh@microchip.com>;
> Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; Mark Brown
> <broonie@kernel.org>; kernel@pengutronix.de; linux-kernel@vger.kernel.org=
;
> netdev@vger.kernel.org; UNGLinuxDriver <UNGLinuxDriver@microchip.com>; Ph=
il
> Elwell <phil@raspberrypi.org>
> Subject: [PATCH net v1 1/1] net: usb: lan78xx: Sanitize return values of
> register read/write functions
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> usb_control_msg() returns the number of transferred bytes or a negative
> error code. The current implementation propagates the transferred byte
> count, which is unintended. This affects code paths that assume a
> boolean success/failure check, such as the EEPROM detection logic.
>=20
> Fix this by ensuring lan78xx_read_reg() and lan78xx_write_reg() return
> only 0 on success and preserve negative error codes.
>=20
> This approach is consistent with existing usage, as the transferred byte
> count is not explicitly checked elsewhere.
>=20
> Fixes: 8b1b2ca83b20 ("net: usb: lan78xx: Improve error handling in EEPROM
> and OTP operations")
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/ac965de8-f320-430f-80f6-
> b16f4e1ba06d@sirena.org.uk
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/usb/lan78xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
> index a91bf9c7e31d..137adf6d5b08 100644
> --- a/drivers/net/usb/lan78xx.c
> +++ b/drivers/net/usb/lan78xx.c
> @@ -627,7 +627,7 @@ static int lan78xx_read_reg(struct lan78xx_net *dev, =
u32
> index, u32 *data)
>=20
>         kfree(buf);
>=20
> -       return ret;
> +       return ret < 0 ? ret : 0;
>  }
>=20
>  static int lan78xx_write_reg(struct lan78xx_net *dev, u32 index, u32 dat=
a)
> @@ -658,7 +658,7 @@ static int lan78xx_write_reg(struct lan78xx_net *dev,
> u32 index, u32 data)
>=20
>         kfree(buf);
>=20
> -       return ret;
> +       return ret < 0 ? ret : 0;
>  }
>=20
>  static int lan78xx_update_reg(struct lan78xx_net *dev, u32 reg, u32 mask=
,
> --
> 2.39.5


