Return-Path: <netdev+bounces-209592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D67B0FEC6
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 04:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC935456BE
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 02:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DE219CC02;
	Thu, 24 Jul 2025 02:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ha75ZMXC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4642828F4;
	Thu, 24 Jul 2025 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324142; cv=fail; b=kqWzRMPZH6u1rgraJ5q9HyagEFCn0BoHaaLWRf7VPn7b7vw1U8/Fo8btmLFuDcgPIAeZpH4ZcFRrTsKKMvwWgQ3UXxc6Wrhu8enZosXv50Z2gy6CrdhL5XXtoJTJrjNmjIYZdOTrWMTEPyqMZtcccvZ+JNju4+9emXZKLODUUoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324142; c=relaxed/simple;
	bh=KkGVmf1ExsdtDl5Desn3IXMECXq967W/hJfM2VbISFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YynffiDAiFnyECcjEyn4P9YbwdEjrmZ+CKKlJqk5mckCt2I2c3bBwEv5C6EITpNwbcLwOjYeN2BLuNbQHg8scAIcllni867UuxaS715vIqec9WWH69t3YKCIg2G77IdoPDyjm6qY6SAsvSmntwHkXRahv21xeFwvu6x0tTMtW84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ha75ZMXC; arc=fail smtp.client-ip=40.107.96.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxOT5/+ndt8X6y4kwogBAlcE78T4jJy5r1LrPZrg5JmmtQXxvCX0w/jS6Smh1GEwIPs9IX3KbfrT1TzjYZ5txpbRynJhcJGqVPQ8q72BVFMW+WHTATRblFpLijfKeSrgbj8sCevRuvGsFRhYR5isqpiFLHmETraIe/FgTBaNhlPx53znF6f7PxuWfiXKbk5rEyehQ7W0ypTvkG1j6df10XFxpaP2/P4KJpBimPfcvGuM+aVrF5vKoF4IjmjoLcHxoYvum87sB19bpyw7jfdrhpTDhqippn7fIdPKdOnQuw7RS1wow61e7tOeiytvuUKhvU5+UJV1GVuOipfnIvHRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIU7e5uSOmRdNzll0lEZcN2/XcHVpL56uWRCogdHwBk=;
 b=yEmgJ1+8jmNGIObnOUYUl+YXyliW85+1qvrx6iouZnBTdbiiJxuvFkeAeJ7KnfR5PFpeBxVn/R5czh9LAF+gy2JmFI1IgwVkt7L+KI4MTvYBl9UKJOORsqffl1m9vs5OtW5RqQAQWNID01F4lv7CxpkVJZWLOi9R59aLkyO6eTyhLUWQIdeW68734wXdADPrkFPrBtw8IjPsGcX+g8qJ7ijI/Mb+sEojlCa9qV+TmFEkQ3XcaCBi2RrhVoC+gK6h2A42gJl1geBD0pW79A9S/gCmyiQJY2C6nMMCjTLSUatDGWr/RPtkqczxcX5b3svJov7k04BqcOOCvf6y5fEKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIU7e5uSOmRdNzll0lEZcN2/XcHVpL56uWRCogdHwBk=;
 b=ha75ZMXCwxcqW5tfP07zObe1VVOfYS7jZdk5qNdNDFkfFLUTXmNxRDcTN83Bbi49oOuEbofEKB22qJKQoN1o5doAsn6xK4mGaiVDbIKdW3hJCmmubnVK99PJyo1Fcut5WJsMvLsVK1jjmy1qJrIq1u8smpz4MWAxXWZWNDmEUgohm8rt5b7AlXpR0IEedE1d7tvK49U1yk8qnNshq00yaMvhM6BebR1dPODhfmlxEgAoFzcRGk8nhZEdFYO8LUe96qToGOroza50A7Ii/csfjaumKaGlZvjBQjcBc7GZoEea07dz1fafoLKVzmfeGeslzDorEIm7r781XNZ7222T6A==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 DM4PR11MB5294.namprd11.prod.outlook.com (2603:10b6:5:391::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Thu, 24 Jul 2025 02:28:56 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%5]) with mapi id 15.20.8901.028; Thu, 24 Jul 2025
 02:28:56 +0000
From: <Tristram.Ha@microchip.com>
To: <horms@kernel.org>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<kuba@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <maxime.chevallier@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v4 4/7] net: dsa: microchip: Use different
 registers for KSZ8463
Thread-Topic: [PATCH net-next v4 4/7] net: dsa: microchip: Use different
 registers for KSZ8463
Thread-Index: AQHb+Et23Zt1PEXlIkK/NsvHKZPcN7Q6zkiAgAABfwCABDF2wIAA6f4AgACpFhA=
Date: Thu, 24 Jul 2025 02:28:56 +0000
Message-ID:
 <DM3PR11MB87369E36CA76C1BB7C78CEB7EC5EA@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
 <20250719012106.257968-5-Tristram.Ha@microchip.com>
 <20250720101703.GQ2459@horms.kernel.org>
 <20250720102224.GR2459@horms.kernel.org>
 <DM3PR11MB873641FBBF2A79E787F13877EC5FA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250723162158.GJ1036606@horms.kernel.org>
In-Reply-To: <20250723162158.GJ1036606@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|DM4PR11MB5294:EE_
x-ms-office365-filtering-correlation-id: f995f6b2-aa2c-49cf-c2b2-08ddca59d6f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C7ZYnHSdTRbRXFb8xbcS+StBbgBj3izLXi9/GcleUmNVXyLQZ6ALhtc5P0Ga?=
 =?us-ascii?Q?EWTJVvyZpt7wG8kOUNhNdE5W+7DAcYmLgqvJBmJkOzbLPUHJQLYqsyEUi04p?=
 =?us-ascii?Q?jmnuufvJDSxJtacmGn6bEiEZ3pTIrmqj18lcg1no2iS88YGzMdA66lrkq/DA?=
 =?us-ascii?Q?p+7mLdsLyzXLRnAYaTNsoD6nMcKBFHSyp1sqTFOt7PqVZP3drWtAM218KVkw?=
 =?us-ascii?Q?6TxqWwcxCoi0oQreTeqdg3YWfuQoSN6qbGjmuZPbCtf+S8cdhNc4MWVlDCDW?=
 =?us-ascii?Q?VVvUvU+rgtaaUzYravUEu10dcWlmZEIlf7I8nsLpp6OFs4jaBlPvgxCjHrHC?=
 =?us-ascii?Q?VJCBtztCJacKbxgVHYTdD0KFW2HrRqW6DQPP/QL/mxIb1xXHGjqUOgUbCdn0?=
 =?us-ascii?Q?tmuU+9ir7iU8uzT+JUzFB+4vAWj6CXPk7cxOtLLpZHAgbOlFyIKcY8PTAxfC?=
 =?us-ascii?Q?RRvcnvVgF16/wGe4Ql/FYB40y1lVuj+SVS3kg/XXHGhgn6vJf48eoSue7eHd?=
 =?us-ascii?Q?J8rj49Nx1GYLuRaOgVqvMUaVRZievG0lcoZxjS5xjfv2nAefcJev8njtIQst?=
 =?us-ascii?Q?bw6w1Ue3xzx5pAQno7CwsJnn0zc20ci/tL0s5MYmsTndHR2XhtWfGrPuxhTA?=
 =?us-ascii?Q?JtU9RK2oMiiMFEGdMlzFlcX7yMsweRYNe4vM/RQklSeHI3I3Fw5F0mbWwAus?=
 =?us-ascii?Q?cx+cgGSmPHfO02RVFWp/o8LwbDEislNOw0C9nkHGp5zYUlOB04j2K7zP6fKM?=
 =?us-ascii?Q?8hjqFGKVWfYz4AREjUpsTWXTapWsM2JB1Vuz+77Q6cJTIFfJw1J9Qqqx8M2E?=
 =?us-ascii?Q?rGUzzGhCP2C5Kq0f8QebAGvZCYm2/h6apn81d8AFA/gzUhs5XfsrUAskD2PG?=
 =?us-ascii?Q?OqMwITZK/sBV94mRjTnWJwkVG2FMK30qtfEFDy+SWLICn3cB/knmyW/9Wt6B?=
 =?us-ascii?Q?wVUhOVDCRxbfDw58sGKCzJeYw8oMOgTmmb4zGDcmx9twr+0O/YwCyWvWdKv9?=
 =?us-ascii?Q?su8RJXt+U+7oX4DcqkpySr1Z9We0ku8nuA2srs6axLzXK9VSQz0HzsHdZtHf?=
 =?us-ascii?Q?hsXEAr3k11f8t6/D92hXdkjoAXe+vdM5r3rWwWwWcDhjd10gpgDbOR4Q9wso?=
 =?us-ascii?Q?vs01PLDFX1gGERpbAQzttTGNKB04/bYl3bOaUsfBTwMJFyPMoyK27UsIl7Ax?=
 =?us-ascii?Q?MnjxXo9h2upg7984VueM0F0GCSnyfGWumJtmoWLdxIRX5zRiD6Z8QZJadmk+?=
 =?us-ascii?Q?yg8nYMEqvd4ooqLIt4iqMeSAZoAxhBkhZ8uCYKC/dMTGnVT34hkIJLgAp9bY?=
 =?us-ascii?Q?TAubo3cYNC0JxTjmvaIfrW1cjB6kuoQvFWoCa4/1gxDd/FxrBTiiCFg/k2/y?=
 =?us-ascii?Q?85NeCqSw0ik/Q/icC6/80EpDR/1/mOJV5GhkPKimEHojbc+kiJv45Ac0aqrw?=
 =?us-ascii?Q?Rv7Cq8jzOE65TBb2MJKfFC2gB7xNF9gOXg6dD7uic134jj+PoIGygX/hBFqY?=
 =?us-ascii?Q?OT9uKd4IxXoHuwc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4KUGmxNB/5dEGyItZUCTgEtR5ZaOutbT4fJJYqxayeiVwANS5FGLfXbZmP8u?=
 =?us-ascii?Q?MHcMMJ+0CjRCjawHcWJFc+5Zf8kdSDQl4jtUnOWyMuuxPCHimbyI5i35od20?=
 =?us-ascii?Q?KKBlxNUcZExVq+eTjcrCzCvUUTmUaiS2VKU8gAJeRx05CQDqxBhvH2zuF8Qe?=
 =?us-ascii?Q?bLA2h+NYAyvgeKAkTmBofbXPd8i26W6sAxiNVwnrxzIpYrCfAQXaRYnNFXfl?=
 =?us-ascii?Q?b+kGA/4TAjP89JSmG9C3/YWNroW+EepsEtqMFa1y72chSfHnSXMTgyoyER1J?=
 =?us-ascii?Q?ehh0vAWBqESD7uDge3rW+XwelU3qb6kvMu/u9HA6mhYIuxIHUJkKOKEfkBYM?=
 =?us-ascii?Q?BGAIzKhIXv1mTD81ayShaMyAxYdHIUBt7YUBunWLHAtdR3o4viVqFbm9Av4P?=
 =?us-ascii?Q?e5W1bZ7KRrGM6OdwHkEdSIsp30mPN7hdLrjhqnIRsHH84SSjpMhltEhHgWrJ?=
 =?us-ascii?Q?/33EL+Aw6swdJEReMnu5lBe9EH+9LytHgQqZh0tvl1HCFwMpZ5vFekfF+prd?=
 =?us-ascii?Q?QpWpJgVywoaTMiPkApFPnSaTFBUWoNZwl3UnkZi420Btsv2/Z298WtjMYUYP?=
 =?us-ascii?Q?Y1/5a1+y7fO/ANMlRzGfY0uwuPcrnWxdf9SXygtARzmEGraiA6nRSwsTQgu0?=
 =?us-ascii?Q?TJ8PCViU5F7URWyDUUJCE0bdVaNeLSVdDtjr8e/DfF9f8wlMCIebTffTp0lT?=
 =?us-ascii?Q?ApvroiOWbhLZ1IZnIOwO9Z2A3a4bv3uZ5XnyI8geCuALPjszAgrAT2Vy7acn?=
 =?us-ascii?Q?N6EhJbA7b6Y4aK1wdicIgMtocFEusfgc59I4TeDFheKlIqPAXA6EdD/q/Ebb?=
 =?us-ascii?Q?yTw4rtZQH9Yz8qPMl0CZTqyXhm6SUz/S65Fz7H8sR1N9mFI8O62xg1fqdKbj?=
 =?us-ascii?Q?oIMg6+V5tTGHFgY9kq4QVuIVtbNC8p/NLMj30CzeiAeiUoSiy0k7XwnJJRpE?=
 =?us-ascii?Q?kMq7K5O65KZNAgeYN28RhBbZTkJ0EjVZ/x27H2EJvEd1OatlSOTruI6+tpl1?=
 =?us-ascii?Q?i/+l3l0MNip+r7yuknEgXh5HHoLFsequqOoa2YyT7DeB1/vDdudEHOqTivSM?=
 =?us-ascii?Q?mWam/2gWJaDF8OnU43xnyAGyNAefkM+F047uCtiOO8nNmXdftYjiOYgt3YyH?=
 =?us-ascii?Q?8vPkcoQLS/7odVdUTW2/oEXJ5wD7Ya0927bwWOpbuWEsOXG4ZxgqMjBa3lhh?=
 =?us-ascii?Q?1LHfcE1pKUlENPsYteXIIKKfGWYEKbnW98CetZwPs0H+j481zUj32vLyAsMt?=
 =?us-ascii?Q?dYqBI8awbQbLjGAgGzjwarH/u0LsbPtVTIAPys94CgJh+nzkKzhx75xQjpCa?=
 =?us-ascii?Q?6P/z/oOVcP8Nc9O8KXlYcoX8xH3B/zeztfMZq756M9QUgF+7L+wAvg6XksrP?=
 =?us-ascii?Q?y/RnWp+m+3gLTny4lQY+Wo7CJpLSldXlg/P8yYoZmhtX6mve79xXhiS2OSfL?=
 =?us-ascii?Q?mZ9Jfh9m7+oITD+8k6Ze753GmeV4y9pGPM6JWl6k9ijhTmb5CThTo0DrczCx?=
 =?us-ascii?Q?0Og/N4tmp+vpUrMefiijlAofr86yiFHbiEGXc4uBRupjS/aW08GIkfa8HVjm?=
 =?us-ascii?Q?zL/jTp2ObjeJs2S7ryJN2/paFH6kcGz8jbUjIP3u?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f995f6b2-aa2c-49cf-c2b2-08ddca59d6f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 02:28:56.3531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8CsqgWa5Hg5VSohl2Et6W+RBVmiiU3an6tZn5hwF4FvJLl+0VIpVBlj0ZSjLH0o8LGC+heG1FKDDmmt6rze7hv5HSAlxhiBqs+W00I1uso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5294

> On Wed, Jul 23, 2025 at 02:25:27AM +0000, Tristram.Ha@microchip.com wrote=
:
> > > On Sun, Jul 20, 2025 at 11:17:03AM +0100, Simon Horman wrote:
> > > > On Fri, Jul 18, 2025 at 06:21:03PM -0700, Tristram.Ha@microchip.com=
 wrote:
> > > > > From: Tristram Ha <tristram.ha@microchip.com>
> > > > >
> > > > > KSZ8463 does not use same set of registers as KSZ8863 so it is ne=
cessary
> > > > > to change some registers when using KSZ8463.
> > > > >
> > > > > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > > > > ---
> > > > > v3
> > > > > - Replace cpu_to_be16() with swab16() to avoid compiler warning
> > > >
> > > > ...
> > > >
> > > > > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > > b/drivers/net/dsa/microchip/ksz_common.c
> > > >
> > > > ...
> > > >
> > > > > @@ -2980,10 +2981,15 @@ static int ksz_setup(struct dsa_switch *d=
s)
> > > > >     }
> > > > >
> > > > >     /* set broadcast storm protection 10% rate */
> > > > > -   regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL]=
,
> > > > > -                      BROADCAST_STORM_RATE,
> > > > > -                      (BROADCAST_STORM_VALUE *
> > > > > -                      BROADCAST_STORM_PROT_RATE) / 100);
> > > > > +   storm_mask =3D BROADCAST_STORM_RATE;
> > > > > +   storm_rate =3D (BROADCAST_STORM_VALUE *
> > > BROADCAST_STORM_PROT_RATE) / 100;
> > > > > +   if (ksz_is_ksz8463(dev)) {
> > > > > +           storm_mask =3D swab16(storm_mask);
> > > > > +           storm_rate =3D swab16(storm_rate);
> > > > > +   }
> > > > > +   regmap_update_bits(ksz_regmap_16(dev),
> > > > > +                      reg16(dev, regs[S_BROADCAST_CTRL]),
> > > > > +                      storm_mask, storm_rate);
> > > >
> > > > Hi Tristram,
> > > >
> > > > I am confused by the use of swab16() here.
> > > >
> > > > Let us say that we are running on a little endian host (likely).
> > > > Then the effect of this is to pass big endian values to regmap_upda=
te_bits().
> > > >
> > > > But if we are running on a big endian host, the opposite will be tr=
ue:
> > > > little endian values will be passed to regmap_update_bits().
> > > >
> > > >
> > > > Looking at KSZ_REGMAP_ENTRY() I see:
> > > >
> > > > #define KSZ_REGMAP_ENTRY(width, swp, regbits, regpad, regalign)    =
     \
> > > >         {                                                          =
     \
> > > >               ...
> > > >                 .reg_format_endian =3D REGMAP_ENDIAN_BIG,          =
       \
> > > >                 .val_format_endian =3D REGMAP_ENDIAN_BIG           =
       \
> > > >         }
> > >
> > > Update; I now see this in another patch of the series:
> > >
> > > +#define KSZ8463_REGMAP_ENTRY(width, swp, regbits, regpad, regalign) =
   \
> > > +       {                                                            =
   \
> > >                 ...
> > > +               .reg_format_endian =3D REGMAP_ENDIAN_BIG,            =
     \
> > > +               .val_format_endian =3D REGMAP_ENDIAN_LITTLE          =
     \
> > > +       }
> > >
> > > Which I understand to mean that the hardware is expecting little endi=
an
> > > values. But still, my concerns raised in my previous email of this
> > > thread remain.
> > >
> > > And I have a question: does this chip use little endian register valu=
es
> > > whereas other chips used big endian register values?
> > >
> > > >
> > > > Which based on a skimming the regmap code implies to me that
> > > > regmap_update_bits() should be passed host byte order values
> > > > which regmap will convert to big endian when writing out
> > > > these values.
> > > >
> > > > It is unclear to me why changing the byte order of storm_mask
> > > > and storm_rate is needed here. But it does seem clear that
> > > > it will lead to inconsistent results on big endian and little
> > > > endian hosts.
> >
> > The broadcast storm value 0x7ff is stored in registers 6 and 7 in KSZ88=
63
> > where register 6 holds the 0x7 part while register 7 holds the 0xff par=
t.
> > In KSZ8463 register 6 is defined as 16-bit where the 0x7 part is held i=
n
> > lower byte and the 0xff part is held in higher byte.  It is necessary t=
o
> > swap the bytes when the value is passed to the 16-bit write function.
>=20
> Perhaps naively, I would have expected
>=20
>         .val_format_endian =3D REGMAP_ENDIAN_LITTLE
>=20
> to handle writing the 16-bit value 0x7ff such that 0x7 is in
> the lower byte, while 0xff is in the upper byte. Is that not the case?
>=20
> If not, do you get the desired result by removing the swab16() calls
> and using
>=20
>         .val_format_endian =3D REGMAP_ENDIAN_BIG
>=20
> But perhaps I misunderstand how .val_format_endian works.
>=20
> >
> > All other KSZ switches use 8-bit access with automatic address increase
> > so a write to register 0 with value 0x12345678 means 0=3D0x12, 1=3D0x34=
,
> > 2=3D0x56, and 3=3D0x78.

It is not about big-endian or little-endian.  It is just the presentation
of this register is different between KSZ8863 and KSZ8463.  KSZ8863 uses
big-endian for register value as the access is 8-bit and the address is
automatically increased by 1.  Writing a value 0x03ff to register 6 means
6=3D0x03 and 7=3D0xff.  The actual SPI transfer commands are "02 06 03 ff."
KSZ8463 uses little-endian for register value as the access is fixed at
8-bit, 16-bit, or 32-bit.  Writing 0x03ff results in the actual SPI
transfer commands "80 70 ff 03" where the correct commands are
"80 70 03 ff."


