Return-Path: <netdev+bounces-133726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B31996CD2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD711F23BDF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AED51993AF;
	Wed,  9 Oct 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="GxjWblqR"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9D1917EB;
	Wed,  9 Oct 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482097; cv=fail; b=gMvn3sYYpCOWrQNpXlkJVcm4ReLmA/bRLO3xOwCBAyBR2DK0QGtiV6cccnknVD1ThKR9PBFMxgQJXVp9SaNON/OB+PkWi9SxPoorzQq53DAc11mPvtdT/04/GcbFEEIpguiyITeZ1M8jeBVp5cd3WIInEyShWfJERyNGT16EuPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482097; c=relaxed/simple;
	bh=UYuXdd3/yGWstlNU4ruXM9D3VEQUTJ0We3gAR7EcIH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+o8FMafKLE0jl6TALhqncVzQW8zRiUl2JxrshrtxK7EhTtsVAFQQE7zHJJOZe7HMtNylfiMUxPud7gedyZks7jaHw2B+LxAsv/mvtRM2SzJEEIN2uIawEXC8Vc2I2GOXQkqYwHkKdo5agiHXRB2ZqgvOl7tCdNH+241Di3wAE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=GxjWblqR; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcqJ7/v/yDegYOyYxV/Tjbi46bid8ESNZqIv6HXG/f83fV+ORzNBBOQPeJonnNBDyqo3xGSOEVR2cSbQHClNvCnshi4wtAVpomVdFyvzaWdN7CYbt/P8Kd3RQtoSnR5iZ4vfF5/KTN3zMD6wTmNXvkirAajR1srbjNDYPhTJPxoPviCwKsQEOrxPYDxcGxTXW+tZqZLK+GP4GJvvnrnUFxks7ltuNAPm20LrljaFwkci6stOslwvgV912LxaTuZlXlBiqNJ6vTyrnNOqvqENPIWMX6wN4uEmOqAj+EuUV/v/4T4+JTNLi1LZa7agtXREquvdJ3rWhAl8qLGoGBPV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSH5rm6dVfcyu3PPmfXpEnF6SUwW483NZflq+KrRxnI=;
 b=PMmAaCmShfPG4SjPHhl1GuT3EOp7kTORLIQgtojv/pwTFbUnLidmJ4OtPcdu3FwM2EZVRmakKhg4BpY0C59m6kaIdipOlwOZ4p5Vmy0NfJfVr8Mt5xmow28qooT5HrqfJmE1OU6nRRefDRGiqo4dyCq7zhLICKHPE4tccu/N+YOd7npmW6DhcnOI1MLZ1E1uZ1FBXj8eQAUdnUpu4QZyAHioLD8qSdXHfTEXZqLFl5PW3KxRAF7NKKGwH9TqwKR1nS7gjrtRziJ/nbZBjMoj1aPC1BcVqCSZth6kQ6lE1ZtZJEJ/8Nfc6G6e81PWgk7Afomn7LfwBczJno8eIi6abw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSH5rm6dVfcyu3PPmfXpEnF6SUwW483NZflq+KrRxnI=;
 b=GxjWblqRjdl+yQ9VcmtQJe3N9jB4JfVpYwD9rGCn2LfFan7IFjJo6afY6CiUSNbJUg1HdTUZLdiYk9SLMda9394XR3UdoiHd2X0XFmhcm+IfAQtdtQuvX3d85TlxKH1vmwCOA3QIsMrsqLjpTOeVmbkF+qZ3K6bUyckRqOIaW5c=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by PA1P189MB2640.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:465::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 13:54:51 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 13:54:51 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Dent Project <dentproject@linuxfoundation.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH net-next 00/12] Add support for PSE port priority
Thread-Topic: [PATCH net-next 00/12] Add support for PSE port priority
Thread-Index: AQHbFOg2kEXpUrWIdU6ri6RpZ6mROrJ+e8eA
Date: Wed, 9 Oct 2024 13:54:51 +0000
Message-ID: <ZwaLDW6sKcytVhYX@p620.local.tld>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|PA1P189MB2640:EE_
x-ms-office365-filtering-correlation-id: c3d5f4fd-e992-4443-805a-08dce869f244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Tn45R59A4sFyWi+9Imo2TVlcxVZrvPuXYq69pNvCaNzlTQGE7/pqJ+onQKyB?=
 =?us-ascii?Q?uD7A10Xza4Fpq8ZMxoQ3dnOIu2tukjyDzzLfqWXCnN0ErOjxDt4fWMU+Yxv9?=
 =?us-ascii?Q?+aAbOPrvLp7HdoQTrzFy4kwQ1T1rkUbcamRRRD9UUwCvHC5HAmy4qToBZ4xv?=
 =?us-ascii?Q?GVCxNWkBW6Xdk4dfNO62od31Xzg/93r3fsUXVJpSjALJOlljHXxWmaxtKf5B?=
 =?us-ascii?Q?3iYQAE8TYSTLbomnZybVFIvBQXmfObyyZaddpMk2udX9cM46U7sj+vpWu6Y8?=
 =?us-ascii?Q?1znEz6xo7n1ivsNnMbUS5BUa8XRgPUPEofKTSVzxXv5TYZF7IMDyiiv/Wt7f?=
 =?us-ascii?Q?u3cFVOGeqGSGgOhMPp0mkdGSNCRQes+aW7wdPb7RJreP1LPHo1F/iFu2FG9N?=
 =?us-ascii?Q?Xbp9wbeTKGcvm62aATtayAGKZa2FlChRphHtOQ14SyG3JJVK/LerAbYvtr2s?=
 =?us-ascii?Q?GXAgTL5/H1Rix4sfg5szxMEIZNncB+4kg8z/huZ6FzrpGpClyCjfYVbvR2fc?=
 =?us-ascii?Q?hef8AWos7/uCqSJj52gEGqTXgMsKEqZy8m3tPy2TyN9L7bAC9u5zeAQ1zrqW?=
 =?us-ascii?Q?1V5x77dZRzraXY4Crv/Jij+xc2akiyrYAd/CJAEalGIYOF4fwuXO+JyflQ+v?=
 =?us-ascii?Q?O16SGtJf5jp/FjiX0PJPS5WScMue00T7Inr7DjK3cFHCHt26j0Aik2XaDioH?=
 =?us-ascii?Q?gI2I/dx4aX7Kph9H2wMuOLzTB8tBggIZTuBz4pTi0zg2aEkal2skKPpYSdYL?=
 =?us-ascii?Q?J951AYO3JfzCjWVgAMHMzTNXNfDQ6EIDavfeEfBWOfVmz/eBtdAD2/P6cZoR?=
 =?us-ascii?Q?kzHwTj4Y2+3CB5CZ0QiGH1ZDVKw5NhfsjM4uolsev2x1wHPECpPZOQGCFhqk?=
 =?us-ascii?Q?LM9JZNIc5zAxnDcGNr39mjQ7SB0pLWup2qRe651hiH5PVapEvBoEFtasi/6o?=
 =?us-ascii?Q?ft0oPFgK8RARGdccI02vrCHbSxXt28Mb+lWnZr/C2s78r7x2sqfBk2Iok5Zv?=
 =?us-ascii?Q?ZFVzY29dNm7KQHuB2tULSDtAj4Nz3HWSqbG3HV8kWXzW+1wBoVA9cPK9Hc5N?=
 =?us-ascii?Q?B39MvLRVWVC9faqu7ZCksjcHxk1KM3a+fU7+XJMWtFDaTaNDodFSe7f5vQpF?=
 =?us-ascii?Q?IltgO6Eq/3bmEdiuzot37QcW3xaBOtlW+I9EDg+pI3yFXdF7JjekKRQliwsT?=
 =?us-ascii?Q?UCkjC5Tvs6JF28I9nlLFzf0mWJkbe+4VFWXlbbauv9fShoKBzq9FKspYfK7V?=
 =?us-ascii?Q?UfLQ42Ont08p3zYjJUs9bQDAH/1zXNx7fUH4LDHzZSquBicDGI8Y/oKtLKIV?=
 =?us-ascii?Q?BUtrJBEsVAKl6zAYnyyhXdxWSDNYVxXN8uBpOrZvo/M2Yw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ExcDGlgVLiqdX/GrwTS6hHEzq8ETAu+FvfJgplVp3PaNorxQc3ZUkZqwZcHA?=
 =?us-ascii?Q?ZuYPG4YMPIizM2UevDo0lIZAQMhBseC+DDuKr8/SHMug2WiM2hGrUM+/3SeL?=
 =?us-ascii?Q?x92BHDCmp0LIXJUbW+u2il6Oo7qs7misdtuxEH0Y4sWEi40wQF82jA6DIOpN?=
 =?us-ascii?Q?TbHEshZSnmvy62YxIKtFvUv5psMBw6kcxxFwRvTRREb3DLQSwu1Kb679Cqgw?=
 =?us-ascii?Q?GdLY0qgryR1EWhhgm4dIlb3veyRBy8XBwBGQK1vrSaqDmmhp0pU8Sf4JP0D+?=
 =?us-ascii?Q?Wb1tCJVRDqQcSAfcG0NCQXaRnuWKKUcRCeXzx44Wuo0wOwmRFIqhrEo9CNm1?=
 =?us-ascii?Q?zPCxt917QmSUNoG4k5TAYbSJj2OlRwHSA+h4CeXXVz1/50keuZzQI3egCCrC?=
 =?us-ascii?Q?4NyZdlyvm/eOOLa7vP4JrgkELzAG6N0oZFwF9hcmHW8VwBXWHU7rSYotc6pe?=
 =?us-ascii?Q?RUZ4JHduiunch08DtN9Uuc+V8muqsmM40UBCZ0mMpk/O5ZEH3tlAUSY1Pv/P?=
 =?us-ascii?Q?VL3czZv31oynkvnVOCuOEdg83HUjQJ7cEUgusa4d0iq8ExCAH9Db1AfpxZzf?=
 =?us-ascii?Q?1juZ8E/FN1aB9iHaIrOcFe0iKlZOhUtKR/+8PcvxZb04LQG682Pd0iWVkIT5?=
 =?us-ascii?Q?P39XqcnhP5uKzNk8Std2CuthgecIN57bWO7sdsdXG4VygiILr+YplB/Hnh/+?=
 =?us-ascii?Q?/dKUGmLqwBM1rKFgPOV4MLdY7AuVGB74qS1NlLA0GqYXWeg5NWKXgoUW8v8N?=
 =?us-ascii?Q?UrqMwEFgrSs7JaiSjbXMslXjn/YqMw8O0F/m0DVkC0ukY2JpOZdB2deTuQm+?=
 =?us-ascii?Q?WkRAuOLkwANDEqr2f78jI9AIyqA6OKNIMXhxkDwUYZB1QdSsLOyA/o8cu8QN?=
 =?us-ascii?Q?ewq61fAIMSYt4EWHA51mEthtYMZDGOupYEeHEPCpU8kOkpglMNdQIZ2lr6j0?=
 =?us-ascii?Q?MzDABHdsQ8eSAvJ6GaisAeok60zUPNqIrFV9giB/tPilvzTsogZHuPmLUEzK?=
 =?us-ascii?Q?+z1MgO3tyEp8ygICYtWOFTtNX5CXxJE5IF0q93gFNvekletI6Vpjo5Y4NgWM?=
 =?us-ascii?Q?DCqHAKCDTqOpNJ6xg2F5AOhLNRwpka7V71ViPCPCY81ONfd/fKkMQLwoRpHF?=
 =?us-ascii?Q?POe45biOgU7exqaV3TKV8ZJ2maXutr1L7+Bnkbnhg7lw8FEiFnJauSeAfxV7?=
 =?us-ascii?Q?PlSCW3o4p3xIwIHIQQyVY2u2/pZtSg3FkthDhMCLiXgHFl/gXozPclNj+Rz1?=
 =?us-ascii?Q?TSrVmLgPu3ICd6umQdAhslRr+fS3tQAedbTlQKfh8A24/Zw85JD5pO05G8R5?=
 =?us-ascii?Q?q8pe2Kxt9oK6aN6zrM0wibqllX+pZpAHMNbbAx3bd0Ak9ooFaD00/1Pol5if?=
 =?us-ascii?Q?FGOA91P6I7dT4g4skw9qGdNYSIy5uNPobxeeIkwpsLTuxQObjog72aPvRJ4n?=
 =?us-ascii?Q?a7c85w0qi9guCHMwfLjNV30AfBFhfURug2HnvgaSSZE71uYEj2b2l/KMG881?=
 =?us-ascii?Q?eVJNdb4Q813gR2Nk8J2T9Gt0rmec9P6cc65n2afoZzVYhYin+iOW40v2Hqmo?=
 =?us-ascii?Q?u5NY5kSlsi/v5rEfPZHHY1Owrl4l8cIz0kA/bR9R7lVX20bv4Pi+Asyfgdn/?=
 =?us-ascii?Q?eQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <338AF77CCFBC0343991750C78B42322C@EURP189.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d5f4fd-e992-4443-805a-08dce869f244
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 13:54:51.3286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOcM63p/OuhMg193f1vMCgTdV46OCBpVtC9QLrU4LNVM+H9QfFhClPkeaAn2SMeeg01yqZ+woRL0ncUULwmoxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB2640

Hello Kory,

On Wed, Oct 02, 2024 at 06:27:56PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> This series brings support for port priority in the PSE subsystem.
> PSE controllers can set priorities to decide which ports should be
> turned off in case of special events like over-current.

First off, great work here.  I've read through the patches in the series an=
d
have a pretty good idea of what you're trying to achieve- use the PSE
controller's idea of "port priority" and expose this to userspace via ethto=
ol.

I think this is probably sufficient but I wanted to share my experience
supporting a system level PSE power budget with PSE port priorities across
different PSE controllers through the same userspace interface such that
userspace doesn't know or care about the underlying PSE controller.

Out of the three PSE controllers I'm aware of (Microchip's PD692x0, TI's
TPS2388x, and LTC's LT4266), the PD692x0 definitely has the most advanced
configuration, supporting concepts like a system (well, manager) level budg=
et
and powering off lower priority ports in the event that the port power
consumption is greater than the system budget.

When we experimented with this feature in our routers, we found it to be us=
ing
the dynamic power consumed by a particular port- literally, the summation o=
f
port current * port voltage across all the ports.  While this behavior
technically saves the system from resetting or worse, it causes a bit of a
problem with lower priority ports getting powered off depending on the beha=
vior
(power consumption) of unrelated devices. =20

As an example, let's say we've got 4 devices, all powered, and we're close =
to
the power budget.  One of the devices starts consuming more power (perhaps =
it's
modem just powered on), but not more than it's class limit.  Say this devic=
e
consumes enough power to exceed the configured power budget, causing the lo=
west
priority device to be powered off.  This is the documented and intended
behavior of the PD692x0 chipset, but causes an unpleasant user experience
because it's not really clear why some device was powered down all the sudd=
en.
Was it because someone unplugged it? Or because the modem on the high prior=
ity
device turned on?  Or maybe that device had an overcurrent?  It'd be imposs=
ible
to tell, and even worse, by the time someone is able to physically look at =
the
switch, the low priority device might be back online (perhaps the modem on
the high priority device powered off).

This behavior is unique to the PD692x0- I'm much less familiar with the
TPS2388x's idea of port priority but it is very different from the PD692x0.
Frankly the behavior of the OSS pin is confusing and since we don't use the=
 PSE
controllers' idea of port priority, it was safe to ignore it. Finally, the
LTC4266 has a "masked shutdown" ability where a predetermined set of ports =
are
shutdown when a specific pin (MSD) is driven low.  Like the TPS2388x's OSS =
pin,
We ignore this feature on the LTC4266.

If the end-goal here is to have a device-independent idea of "port priority=
" I
think we need to add a level of indirection between the port priority conce=
pt and the
actual PSE hardware.  The indirection would enable a system with multiple
(possibly heterogeneous even) PSE chips to have a unified idea of port
priority.  The way we've implemented this in our routers is by putting the =
PSE
controllers in "semi-auto" mode, where they continually detect and classify=
 PDs
(powered device), but do not power them until instructed to do so.  The
mechanism that decides to power a particular port or not (for lack of a bet=
ter
term, "budgeting logic") uses the available system power budget (configured
from userspace), the relative port priorities (also configured from userspa=
ce)
and the class of a detected PD.  The classification result is used to deter=
mine
the _maximum_ power a particular PD might draw, and that is the value that =
is
subtracted from the power budget.

Using the PD's classification and then allocating it the maximum power for =
that
class enables a non-technical installer to plug in all the PDs at the switc=
h,
and observe if all the PDs are powered (or not).  But the important part is
(unless the port priorities or power budget are changed from userspace) the
devices that are powered won't change due to dynamic power consumption of t=
he
other devices.

I'm not sure what the right path is for the kernel, and I'm not sure how th=
is
would look with the regulator integration, nor am I sure what the userspace=
 API
should look like (we used sysfs, but that's probably not ideal for upstream=
).
It's also not clear how much of the budgeting logic should be in the kernel=
, if
any. Despite that, hopefully sharing our experience is insightful and/or
helpful.  If not, feel free to ignore it.  In any case, you've got my

Reviewed-by: Kyle Swenson <kyle.swenson@est.tech>

for all the patches in the series.

Thanks,
Kyle Swenson

