Return-Path: <netdev+bounces-207857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96369B08D09
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0761C20D18
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C02BE646;
	Thu, 17 Jul 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d5eMmlLG"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012035.outbound.protection.outlook.com [52.101.71.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D2B221FB1;
	Thu, 17 Jul 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755715; cv=fail; b=CN/URiyJ/EMEtyl/4MgpazAkoBgvPY2OYn1+B6bkhCQgXmbxVukqkK058xl0wZs+3XulWpcqUIMec3EqdnzcJ4JhkI1r3HR/mPn/yL7BoFvu75X+s3nd/EUGuxeEuzNdaxOU6sZehB2d/C+nEV4fJYcmesgEcopso4btfkLll2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755715; c=relaxed/simple;
	bh=SUB2s6Zvm6exiKrQjXJzp8wNs+lMkAUqLfOmIqtLa+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sh0deyJ/+5dsxb6FogopbIp9e+fvcJnOm0mmNdKXyerSlzSqfW2BuvqMhZIUq+mNyCJYeDJe7ToQleLObkmAVf9X3V7eg7AAggVaOfzA3Gr/Ui02bhIh/zvJaIx5+lcBEqObmdWFMdtamaGxBry7PF8UfQtsFuRaKgtQwjDBYhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d5eMmlLG; arc=fail smtp.client-ip=52.101.71.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDOeQb3wgmxEgbe89zuIuaXtUb8/uNKQfNnwQpngzIF8FCNQx3KRa+18dRBwwDxKpxykeCTwkVLEe+8m/Ez91e7BnyBYjRhIvxkvyBuSIYRmwN89LDR9lx56XCINKgYhpRQPBuuAr7qUQYlaBfSmunUg6yLKkfWy/Dj2cYcO4Ta/pcEMVucAcyfbgVr6+Qka7hnVxNAhK6kHOjMEOaueo/6FgJJNnJptadJJ+Xik1kPHUk1xiY3aK1VXHgU9XlH/VjRUnklQ2eBWSdAAThui76xpERiCvEplKvl+DRbiEXlkao3d7Jc0WhfpQT3Ho8UGzuAk9w5Z9tCl9MUadu9bqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mse9zzmecWFzs9FQLycuZQoQCwJ7ACLL0JySgMLtVuY=;
 b=wZHvXvE5JpoJ8yitBlyNf51Xq6rv6ET+re9CKKcRoLboJkYGiS7t7Yup3rdWnrKUSNdQHjOjLV9zff2HE2ot3nVHc6/KxGhd1uuzwzzgTlYm2ApG7YidjQdZjDJRlwx1T9n0f9UkwmnjYxQTF44oaAnRYfXDJJJMSyUcSECAQCV5jTcF4VE4TiD3une7reRuaUGDr0nKPyx5WJ351RrewdNe5fbTzS9lfCIUdAY4PUkUTfc3TKqtni6ym+nAndPXnbhhd0ql3AXbTQxY05BraScC1n1huLnE37BeVjWOIvzWmmd4ar0jl2hoLNjpwKFoMDJuPQ7ZpZKQks3DJvdibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mse9zzmecWFzs9FQLycuZQoQCwJ7ACLL0JySgMLtVuY=;
 b=d5eMmlLGJyoa5KsNxjv4mTlLN5kafC9WvLS8qJQaD3gS+kj1168/jDpW8eQJqJd1CiCMIllUuGe6PPGaBJ5rxoMrA60jXRarK6HzstrLY/DekoT8FyHalX9a8QiS01Sue/cAyLCMnFQeODAI2q979wfutOGQMh3QzG04xE3SRbb42IlVnbSvnF/4aNffgLvy2FRTXLm5i5MsGpK/Ycd/uCMJHN7TyzJ5S910uFoIzpXYWKcn+Cons4whufoMzbq6JDV3v5dmyUVbYcpjpXl52cBEteLYQK0ZnMNMZGZPiDQuiAiTsy3b241n+Q9iAnD9/t0AJeVrv2LXW3pNQv0/tA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8183.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 12:35:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 12:35:10 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "F.S.
 Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 net-next 12/14] net: enetc: add PTP synchronization
 support for ENETC v4
Thread-Topic: [PATCH v2 net-next 12/14] net: enetc: add PTP synchronization
 support for ENETC v4
Thread-Index: AQHb9iaTMw7wWMBukEKvuK11OYCKQ7Q1PTuAgAEA5pA=
Date: Thu, 17 Jul 2025 12:35:10 +0000
Message-ID:
 <PAXPR04MB85104A1A15F6BD7399E746718851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-13-wei.fang@nxp.com>
 <aHgTG1hIXoN45cQo@lizhi-Precision-Tower-5810>
In-Reply-To: <aHgTG1hIXoN45cQo@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8183:EE_
x-ms-office365-filtering-correlation-id: 90b9b505-a84f-49a8-87c9-08ddc52e5e7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GunHkl3Q+gJQGudZjWLBUHclj3WIh//LPd5YTTMt3Qu8svczT+c+Ev5dG5ww?=
 =?us-ascii?Q?D3RORBdCQWJMZkiOcKKE8lTMfo5oJdVNtLqz11Ne2v/7HKaAy4W1ILFOV4RL?=
 =?us-ascii?Q?PFvCgadwgJT1I61GXIXtjrQB5XqwgTR//i4nPbFoV8AjU8HvpyryKMrT5sUz?=
 =?us-ascii?Q?iEG7L5vxQ2CyS/iR97l1IzCLdnIC4xhTnWlr2qOszvYNSlazLLgFIvo+FfF8?=
 =?us-ascii?Q?OJRu3T0lUG/EsQAbNVvW4H8mAVoa2Q6QORyiHECCMdeOuUSBKO6tvfEtNW0Y?=
 =?us-ascii?Q?q7Omi4PLfYD41qVgZyt04kWhxdHKCwh1FhlGnxrN3PXegHrpJqnQorJNyoEw?=
 =?us-ascii?Q?rF8aGf0liV/8dE6abooCACp9mHyDa2pw1T+YmkDuD0hRrHUPWQVbhH4Lb3o5?=
 =?us-ascii?Q?7ItYquxx6Ybd2TSIeKI59ILUA2Q+RxzqNF86p2ImWTcr/aRztUFgAfAnchBs?=
 =?us-ascii?Q?Skw2Ycf7hx9vcZvkUk2sLdmZ0Kk60V0j8SPubuUNzU5bM0dUTogQAxPscq1x?=
 =?us-ascii?Q?VMiwovCKc55Hrj8O2wqMHDI74dlN018g00L2yUePwqLKmowHlLSYtEkHBw8D?=
 =?us-ascii?Q?/AxMe8G0kuuPmrqPCsAguBCco98nJ7xrZiJzH0Ibvcs0l2zBWIyTzTniwtTl?=
 =?us-ascii?Q?5LyoJ+IhLeZ3W8JOc1XMJ3TsY92eQamz/RdKAcNg4DxILm0QOEpuVjvVR6i/?=
 =?us-ascii?Q?AXnEys3Q+Kf5AfkoQ/1NSCTGrN4LNrZXxFkQTNu9TCzsQhzP8AP9JCuxFeKT?=
 =?us-ascii?Q?o3roE7erPFNtbsfnhdz5v7YIPPCq8jBCa8TmA9KW1FAkpWMUiLKMV2dJkrBl?=
 =?us-ascii?Q?ayjHdFJ875v/2ct4LFleIWW6fiq7ViwsSY34C0zVhVEUFiCVlsTtGYE0/oYn?=
 =?us-ascii?Q?tKcLrf5F4heXAM4+nCHMUewV5+cVYNky3vfuyh1AGd/gCUpG2gIiCtIICDfP?=
 =?us-ascii?Q?SO1OpZQLHhEjc+mL65M4TeAWoYhtmjSADzL332W5VdnRjIs0IIqkAIkAkd2F?=
 =?us-ascii?Q?M+8AlJTmx5JFh2PzaLtPGeS85wWCXFILsz3akrjpJEd8S3+OlFFmL1n5MUcF?=
 =?us-ascii?Q?wZc3KpIVv5ehvQEZlJ29UAM4mzTrIHWZVpov/zipAhGYOmSb9NNW2va/zp8D?=
 =?us-ascii?Q?yEGuuRS8zmYFHX2BbtanQoDembQsr7yRhD8maQ0qrTvCpbt8DcYZURF1cK4K?=
 =?us-ascii?Q?Z6SUb4UvSIR+/Xwu86kgoJJfYBx1NKeOnAnXfB6jHMj3VOG74wYuvjU5qnex?=
 =?us-ascii?Q?nBAFKO6SemXMHRp0827Qc4JqAO2u/MkmpkxgceT3oaknPLzeEfzCVGnhOhZD?=
 =?us-ascii?Q?BsAmDAI1AeW2SavtK7dovrizt3Mzc51lHfQAqKv62AGRIJEcCqfFvQPbBPRc?=
 =?us-ascii?Q?nHOrIXsD756ukdrKx08u5STlk0kW87V3/c17tQgK5xwplxJHMCEhaf9Smx6L?=
 =?us-ascii?Q?ofLqZatMfRgihNBw5InD1EkCptLr0LkPnPCGvAqEGQU0ZPmbin8Pw1Prf1ke?=
 =?us-ascii?Q?4pn3eqnBvsuI/uk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7p0wKjixZ5qtqGD7YVG16ARAv5UIuwaBkjFBVmiMMFcqog4LmjulbWVLPNDD?=
 =?us-ascii?Q?ipA23PQgP5jesKZNeXzc1xyabdEjW/G3XcMLwyJRt9NN0Cquw/QMT8xs9gGp?=
 =?us-ascii?Q?D3qgiQrha03oru8IMz2ACBYgn/B5vPJ5fvY6Hly5tlUXV3+tf0DjFINIvQeu?=
 =?us-ascii?Q?lde9kwbg4l3JkMfNCWBHf8BHt34wKAyvhK8aDXT9Rd+ktFFtVkrklPONZLsN?=
 =?us-ascii?Q?AoHB6PfPsxLkEG3r1KLEOjDtaWx27/PPs5U3+/ws7ptVSOmtDvzo+bewY+So?=
 =?us-ascii?Q?5ebPa3F3QACvIHUh8qCt1oObDWhcCRY5bVk6j7OOkRqvU5Uii7VbA9oGkoPg?=
 =?us-ascii?Q?cSQYraXx5F64AUTdtegiWmWjlj9gsxM+H8JF0YnyrpwV0CUcmXubWI5gM5XG?=
 =?us-ascii?Q?FuAfMmGFyx94DRk0XrPvsDzeKuUpEM5USEql5pgfWU0yNZjdvKwMGz65+rKj?=
 =?us-ascii?Q?JzbOtdCmHe2Py69Tw4gUI49MPZ9omiHjM1VBj5D7sDXupTAD0zzpbclyW6DL?=
 =?us-ascii?Q?WmO3v5qDi0KMDS4k3ABdjkJolZ9InHawoGMwEIvtcJWoR6WAD8UsM3ab2RDu?=
 =?us-ascii?Q?uBiv6wuEkFCP9oOzTHFUX85ZFgKpOfbqlOR/dwFzx4ZR3Jk7NUbLT5wsY5GB?=
 =?us-ascii?Q?VSfYNPpqpFfcmh0iXAWlGBYrbbvAFdtEcmkU8brNjLIPZeztlCpfHLGYrabd?=
 =?us-ascii?Q?BovtA3L2HUkoDNEs75ytDLJqqYhDu6KvAfTCTeOAPsa76nE0iHfKJ+TDHge8?=
 =?us-ascii?Q?uFw6+0b/2GOjEB0zodns+aEuhvZR0Gmi5nvphtcVDSqvPXFvsHgHsBszI+9q?=
 =?us-ascii?Q?3LruQ+iaofq/BEWQpw9NKV/V2CZPUUBUA1JWFIxgAYJRy7DthKsupv2Vy1Tg?=
 =?us-ascii?Q?2g05M4FilSxjAz98emGGA8dK6k410vysuxqvhitd/zYbHGZzIV1aJOB0VpcD?=
 =?us-ascii?Q?kYfCK8DHddxl8D73Ak8PiLAb34C3g/RApmhywUiPXpP+psV0NW8NrkjmEwg4?=
 =?us-ascii?Q?zYCPt8dwzzp9pQvk4xq1RifDb+rPkEzrPs0blowkFUKOn7/jnwjlAztQ0fZP?=
 =?us-ascii?Q?xfKQpoaX5vv2gKSAqoHJShShlkxdZIidEJoFpsoUgx6QD0LtPOE/uq6Hic33?=
 =?us-ascii?Q?5yxqNkrJIUXgNC7ta10CzTCUuLLpdyjm2P70QVeVKeje/p0jpl0nlpnGIuoN?=
 =?us-ascii?Q?acQGzFpZaGhiQwEtxQXdCAY+lVTtshNQtbVJEBoB14K6gU0TyN/UMcDaeQWH?=
 =?us-ascii?Q?JCs/Dd8f+loatmfRNpeveYkHZaLQGzD5LlSagowFxGoNk2nx0/OtiIEmpPlS?=
 =?us-ascii?Q?8AphLzPh2zfReeWU3sChgj2cr1881CJCj9DaM9U7kyXzukuahJYhWqCCcifa?=
 =?us-ascii?Q?UeMKbCQAqgCSvJBieek7W4G4MAvVnHoFxyNZifUkD1Q1unhqQX3hJPMQ5Cer?=
 =?us-ascii?Q?PiSnJyDQNTLY6YUZsXMpLORNmsvaLGusB2/LuhYddezesUmHx4mNt+k0pXBb?=
 =?us-ascii?Q?L8tiFwRfiW9eTSROTq8Ky1X7ZNcfVWFH/BKta7+7PxWYsUP/E0gr5+8GYAtv?=
 =?us-ascii?Q?23WZzijJFdYsFiK8l+g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b9b505-a84f-49a8-87c9-08ddc52e5e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 12:35:10.0365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoA/sWSXZsLj4jN/WmKjux5JF0fK5mIQVkuSL1pZRSGABz5/LgTvHjhT6XSiM3CH+9UL2Iu8sVXUo8a96DP5ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183

> > +static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int
> > +offset) {
> > +	u32 val =3D ENETC_PM0_SINGLE_STEP_EN;
> > +
> > +	val |=3D ENETC_SET_SINGLE_STEP_OFFSET(offset);
> > +	if (udp)
> > +		val |=3D ENETC_PM0_SINGLE_STEP_CH;
> > +
> > +	/* the "Correction" field of a packet is updated based on the
> > +	 * current time and the timestamp provided
> > +	 */
> > +	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val); }
> > +
> > +static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int
> > +offset) {
> > +	u32 val =3D PM_SINGLE_STEP_EN;
> > +
> > +	val |=3D PM_SINGLE_STEP_OFFSET_SET(offset);
> > +	if (udp)
> > +		val |=3D PM_SINGLE_STEP_CH;
> > +
> > +	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val); }
> > +
> >  static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> >  				     struct sk_buff *skb)
> >  {
> > @@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct
> enetc_ndev_priv *priv,
> >  	u32 lo, hi, nsec;
> >  	u8 *data;
> >  	u64 sec;
> > -	u32 val;
> >
> >  	lo =3D enetc_rd_hot(hw, ENETC_SICTR0);
> >  	hi =3D enetc_rd_hot(hw, ENETC_SICTR1); @@ -279,12 +303,10 @@ static
> > u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> >  	*(__be32 *)(data + tstamp_off + 6) =3D new_nsec;
> >
> >  	/* Configure single-step register */
> > -	val =3D ENETC_PM0_SINGLE_STEP_EN;
> > -	val |=3D ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> > -	if (enetc_cb->udp)
> > -		val |=3D ENETC_PM0_SINGLE_STEP_CH;
> > -
> > -	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> > +	if (is_enetc_rev1(si))
> > +		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
> > +	else
> > +		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
>=20
> Can you use callback function to avoid change this logic when new version
> appear in future?

According to Jakub's previous suggestion, there is no need to add callbacks
for such trivial things.=20
https://lore.kernel.org/imx/20250115140042.63b99c4f@kernel.org/

If the differences between the two versions result in a lot of different
code, using a callback is more appropriate.

>=20
> >
> >  	return lo & ENETC_TXBD_TSTAMP;
> >  }
> > @@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  	unsigned int f;
> >  	dma_addr_t dma;
> >  	u8 flags =3D 0;
> > +	u32 tstamp;
> >
> >  	enetc_clear_tx_bd(&temp_bd);
> >  	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) { @@ -327,6 +350,13 @@
> > static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff=
 *skb)
> >  		}
> >  	}
> >
> > +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> > +		do_onestep_tstamp =3D true;
> > +		tstamp =3D enetc_update_ptp_sync_msg(priv, skb);
> > +	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
> > +		do_twostep_tstamp =3D true;
> > +	}
> > +
> >  	i =3D tx_ring->next_to_use;
> >  	txbd =3D ENETC_TXBD(*tx_ring, i);
> >  	prefetchw(txbd);
> > @@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  	count++;
> >
> >  	do_vlan =3D skb_vlan_tag_present(skb);
> > -	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> > -		do_onestep_tstamp =3D true;
> > -	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
> > -		do_twostep_tstamp =3D true;
> > -
>=20
> why need move this block up?

Because we need check the flag to determine whether perform PTP
one-step, if yes, we need to call enetc_update_ptp_sync_msg() to
modify the sync packet before calling dma_map_single(). ENETCv4
do not support dma-coherent, I have explained in the commit message.

>=20
> >  	tx_swbd->do_twostep_tstamp =3D do_twostep_tstamp;
> >  	tx_swbd->qbv_en =3D !!(priv->active_offloads & ENETC_F_QBV);
> >  	tx_swbd->check_wb =3D tx_swbd->do_twostep_tstamp ||
> tx_swbd->qbv_en;
> > @@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  		}
> >
> >  		if (do_onestep_tstamp) {
> > -			u32 tstamp =3D enetc_update_ptp_sync_msg(priv, skb);
> > -
> >  			/* Configure extension BD */
> >  			temp_bd.ext.tstamp =3D cpu_to_le32(tstamp);
> >  			e_flags |=3D ENETC_TXBD_E_FLAGS_ONE_STEP_PTP; @@ -3314,7
> +3337,7 @@
> > int enetc_hwtstamp_set(struct net_device *ndev,
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >  	int err, new_offloads =3D priv->active_offloads;
> >
> > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> > +	if (!enetc_ptp_clock_is_enabled(priv->si))
> >  		return -EOPNOTSUPP;
> >
> >  	switch (config->tx_type) {
> > @@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
> > {
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >
> > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> > +	if (!enetc_ptp_clock_is_enabled(priv->si))
> >  		return -EOPNOTSUPP;
> >
> >  	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) diff
> > --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > index c65aa7b88122..6bacd851358c 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > @@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct
> > enetc_si *si, int size,  void enetc_reset_ptcmsdur(struct enetc_hw
> > *hw);  void enetc_set_ptcmsdur(struct enetc_hw *hw, u32
> > *queue_max_sdu);
> >
> > +static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si) {
> > +	if (is_enetc_rev1(si))
> > +		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
> > +
> > +	return IS_ENABLED(CONFIG_PTP_1588_CLOCK_NETC);
> > +}
> > +
>=20
> why v1 check CONFIG_FSL_ENETC_PTP_CLOCK and other check
> CONFIG_PTP_1588_CLOCK_NETC

Because they use different PTP drivers, so the configs are different.


