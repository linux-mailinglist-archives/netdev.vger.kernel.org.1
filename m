Return-Path: <netdev+bounces-213143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4366FB23DC5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D312E3B04CA
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7E519F41C;
	Wed, 13 Aug 2025 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bhig4kIV"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D97199934;
	Wed, 13 Aug 2025 01:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049141; cv=fail; b=hLn/gkTkgQ/hV0PA0yI+EyQj8GJqQ1L3mgSDLfZnzS/SYIgxWGFO+0xUAzXinqLUj33/7JDCH1r2jyF7gEQKOpJA4qEzaGFLLuzmNmpYU8t7mNSuXdX014kBlcI4oFZ4yIfPHfnKVDUUVVFwfKWMJvLSdxxJpyl8AUgmTV/sAFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049141; c=relaxed/simple;
	bh=BcfTrf7ON+5eTO1gaF9RzYQAUJqitbhYkPQFwOdhyP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ka4b9lMhVOEuB3cqNqaf/IfmmzixIvz4Fdoqp4g3t3lZODotWG0miE/xgdNaT4VPoSFJ0uwd2AIXFcRsHs6a0y5TjFrdfHq53EnyiV7reuriuZmebW3Vy+Dr7MMuuicVUwnOmG5WbDIIrx2Hp13//738I4eDNX2u1lmiAleUSJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bhig4kIV; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AF7dbhhGnJ8cabs0NqBzLM9SKeeVu/XscnsmROSVE9z8kAxe/yBnduQwmJGEQC8bK5c9pJO3EbtakPc6gO25tWIFwkjjX6HSUzAsK33l0Mdf58iYnhp4AtKhCIcnwhkTfhAj3Qinquaj1O0uqAgIupWzfPX4uJ8EGXVkfc4qYr3cAkUmCwWZDS5GoLo7veEJa0KbtrxEy0QrlR+GVQ7tYVg5go7mMwdgD7/tA/FrJ8WdEA8sHy/bAKOaam7KU2sZdEHX9Jr3tb8vpwdrGhO/CAxYiw3MTGcMr4PLjs6364aiNDuQ8Ahh6c8Lzbg1adKCT2G1khFVeF3/MDxLr3zOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/X1YFlGdcoyJG6BpqNllgYGtQMkmULuCquKsrQnof8=;
 b=AX2riAyKw8DDPT4QxlJ4NeWHhQhhoP5VZEIVD5Bo1LmgSjXWMD/v4oE2MhvNiTjrqVS9KORy3ZUqJjlf5l61pjkZq66kd2e2ix1+lbwv6RyI/gpBdj4k4pZdzngdpiZUbBgY+BpXrysh4ld1WNyHB3gRSHQ+s8/003eHsPiHL109jTGUWZDpcG1IA6QfkeVT/c3PelPo9b/NVXLBph9T3HBrByWbV5vpkpZcS248wiLQvMiOrPrPqEhgwkibILNAeFuha3yWBGaOr8pvdTTJP5TL7uxREaJeldvZhmrHBsYo6XhQ6DN7pAXVDcPOIYbnFD9GUhi8CrAYuoGwR1CEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/X1YFlGdcoyJG6BpqNllgYGtQMkmULuCquKsrQnof8=;
 b=bhig4kIVv9k9l6QFG0miBeSU3WWiugLiBT2fXSBR+Vm2W9zGvJmR8xbRkTAOvdN5dVToxqQbWH2FA8cXbc/LDjjYMuGc/mOge3lC9SIU7afd0tuXX+95mqOrvT/FZbT6HyYOdALMrNQGX/B8iazcUKbxGz9RwpqUzRVU4dsnCzLQlLFYyqQumhxMOoYjVS2vq8DxV8T3MQlTCjGVWtejGH4YfuQgkt7jYBGI7W9GxmrCXw1czABIUSGzYSIHeTNO7ezgbwJcXescwTWPSgkWqbfrEFlrvbni8tzhAlSpr4eas5S+SMpzyX89lBPHMXwVzBNOh4F5s30FFaNySUJ4tg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 01:38:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 01:38:55 +0000
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
Subject: RE: [PATCH v3 net-next 03/15] dt-bindings: net: add an example for
 ENETC v4
Thread-Topic: [PATCH v3 net-next 03/15] dt-bindings: net: add an example for
 ENETC v4
Thread-Index: AQHcC3DkGmTUNwk2xESr59nb08m5z7RfFqQAgAC3jbA=
Date: Wed, 13 Aug 2025 01:38:55 +0000
Message-ID:
 <PAXPR04MB8510925387F9F72A8E99AB82882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-4-wei.fang@nxp.com>
 <aJtR4j9+w5fVsJL4@lizhi-Precision-Tower-5810>
In-Reply-To: <aJtR4j9+w5fVsJL4@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8621:EE_
x-ms-office365-filtering-correlation-id: c7311795-6543-4d61-8ec9-08ddda0a2a72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hRTx5DQadGnJE8Bu9+/lrge7eQWUV1j9xXqkVboKjwfQ2gF/lEwuCtQW0134?=
 =?us-ascii?Q?/NfmCRvKXWIs/v7ZIMRYi58tJyJnmMQzzArVn5Bezbmb0TL5U0taXv8ziu2s?=
 =?us-ascii?Q?sx2omLBY+kDWyk4+Rk+EkmSTxWPDYYMcSHk+1MzwZ0yEunbeq4XIgLmUuVdR?=
 =?us-ascii?Q?7I5eOVUWjLddQ878G0hdznKctS09SzTYHhiMKEYh7/3N8eR3i3dMRZhWaG62?=
 =?us-ascii?Q?Z1qxwWS9pn7K6bkyOLbgfFL9Hi+FbkqLf7qtFghSyfa5DZX2nYJfW+a2+bes?=
 =?us-ascii?Q?lJf/G/EHloQhK9f2OIy+bxsKintovrDT/WKADaBsMPWMBbbZeRbq39ajyux0?=
 =?us-ascii?Q?tuaC1/dmQ4GbKbFjPDdjlKgnfIFjoTGCKFMrEPUtZXRSUFdVnVrSnQGG+aMI?=
 =?us-ascii?Q?417oB4y5UvUhNMqCjTqrkqnIHApObdUaJbHBsYpGlwJsY4j88wYTSIKREfj4?=
 =?us-ascii?Q?BCDyBqSRFxXx5JpWYxyY2pwIJ6EfAv5wmqhAHlo6TN87jU1/KBFvZMOA/inl?=
 =?us-ascii?Q?Y2El6VLGOv526tQl2ZWYoO6gJ3zQOAR/zO5VUbe8b/5qsITUh58DtLqs9ec3?=
 =?us-ascii?Q?n9jnQHx4t6h0jMKb2ndNlDsEpHszZbAHHtxhSX0ihAjY30K0hR/cwb77fN1F?=
 =?us-ascii?Q?x8gBY++Bai7RGcWOaDMLqce6h3PHuARdenKMx7Bf2r0meGOJG1RnsIT4F7xv?=
 =?us-ascii?Q?9EkIz71u59wZo+3iLJQwj0PsZ6Dws+Flf+juao3kIop7urDwvd+QBhVPgIbq?=
 =?us-ascii?Q?5GtvRXiuT3+f5sMZUDhnPgJ87Prq+ZA5FMaS9zaPqighosyORG69mNyFYFXt?=
 =?us-ascii?Q?iINwyyRwDM28VSkwVnY6XnZtlWz2O5CXvkJMBiZzckGnm5ot88F5IdBwKzqJ?=
 =?us-ascii?Q?va7DOHR5IR6JzQasMBih+D1FxhPOTeF88CUUSJInBNPuyIU98Mky+hmUQENa?=
 =?us-ascii?Q?LrLkOOhdLAFRLxKudTJGSpxfQDuGeCyB/b5n1XbP7XiJuuy1rbiFErjVCY3Y?=
 =?us-ascii?Q?uKyWd1/C7nTtERHRIUTsyAgRXw6z1qqOwsGqFkxXeVeims4vmGkVCKi8xmgU?=
 =?us-ascii?Q?6fLm0PGcxu0mJYvH+a0YnZ7/XmkEO9NN30MD1sd+ij3TajMXOH2Jnj0hN4D4?=
 =?us-ascii?Q?6fqcX0b5FT/CY5lgqeHvmeqPwgY2W7CckNFmXbHOESnU1avvVS3ZdnZxTgT/?=
 =?us-ascii?Q?ryheuJWcezm4UC3XnKCsy84hBmpEfVQtz3VHDQ7MF9OQUEO7c8AdHjxYVVC1?=
 =?us-ascii?Q?tS/8hcTD6vqRRq2h78e5E/WHRIaUQo3SINVzTsJ1tmK1rx2fHlZ7Bjn2ydKI?=
 =?us-ascii?Q?lFaT3hE4vDLshc0MC0tYWXGbkRRdZDOFryAlLpy4cBFP4Ae4Vzq0GxWXrHNg?=
 =?us-ascii?Q?Ty70Y+u/4cNCcLYXQphrfnXKo20cj2WZGK6yFwmRDg8jTHjVK62TE38rwa/t?=
 =?us-ascii?Q?4dHKBbF7ihhU22P8+AdCt2KxkkkNsaPa11zU9gK/D2ujUzXHaZyGzA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DHdPZTk1RMvsX26hAm+oDAcB2uSahBxMRuGeyL3TmsL6LzZnpSpU3QefAmCE?=
 =?us-ascii?Q?NSptwPzWf24G+iOtMFijmTXuHk3OsN72pk7WRyYO1vLhceZO1Iu0ThiT7fUg?=
 =?us-ascii?Q?z5ucCTiAKUV/AyeiL6VvAAprywijfmmgbizoZid3ozL9j91LlqvMhNFSy2N5?=
 =?us-ascii?Q?9sICpk1cl6/bter+GW23R2LP+OLDTOUGf91eiGcCS2uN9ei0naE5xQ5QY3xz?=
 =?us-ascii?Q?dc2rRs4uYbtu7UvNeRrzBLbQUvsRdQ7yRV2mLlmEozT5v+OBdtKhk2TEeQCK?=
 =?us-ascii?Q?EF0huX6vsLKxHdJVXXXoGTpvjeGJH3dSXSWQIwyz/CeQ4sM9sulhYwlSe1SK?=
 =?us-ascii?Q?/q0IFIOWZraumqI2pm1EjKdf/9S7xarVgw20OqN7CFJiV198fkivA4UNTsOp?=
 =?us-ascii?Q?wPiYxwMdMvvGQ7D5JJPufHFoh5cAX9FaJ7uZc713T0BYkPEd6sCM4WaJPV77?=
 =?us-ascii?Q?SODphaoIdqYqy6tyoHcEKDimoETAF7esSWdLGCX1PoXSU0rxTSJXVPv4T+1g?=
 =?us-ascii?Q?T+fTvskbB7PKDd/U5Y6J81SCBKT9iJfoyE+JHva2oCv4F8tCKLdarYRfnsFn?=
 =?us-ascii?Q?gz6loyNkELaLgkAz9QcFfDWxI1WUy3WQFZFjuY0TfAF+8I5IoidiloKdooKf?=
 =?us-ascii?Q?EqnNomW6VHMCrZC6hV2oU1Vt/mFbNLuZdX15LerPqwHa/48yy6W9FCZVQdr2?=
 =?us-ascii?Q?Qy42UEXxlPem9C0ZIUEmrGbhPwyOjve5eDD0pdD008FuTv91UBy11amQvK/X?=
 =?us-ascii?Q?muSiBGVzC3FLEHUW0OIU3P+eUU4FIY96atsmit+jLvvZ7cIz8P20wEmjhZJm?=
 =?us-ascii?Q?oCvvry8dMjjRVnwd3iUXajqmRbeFJjZ51xZrf7+TN8T0PfsHwpR+PJl9/uYE?=
 =?us-ascii?Q?2Qe1ERmgua0vpHVdlLg8NbnCp/Vh4xiV5HoFwkL9DuW/2Z7Ntl/smHe0RIcn?=
 =?us-ascii?Q?bCs+RmSKLwzuHwJvorCHgXwhMPkMnLGN3bH7JfAq7PV2lORcsUYphpQmUzI8?=
 =?us-ascii?Q?dodHwDorczYYuvYZlW4vNoj8u6fZ6W8svp7Rz9fNK/JqbkVbyfPe50req7hZ?=
 =?us-ascii?Q?XALUkuTNuQTU26bQBZMKRYFvjiywE2XHrTmc6Z05qsiYLhHS70Ve+y663G0d?=
 =?us-ascii?Q?AnRT0GayxGmts07byN//EV+Mw3JjnX5X5mIpwIeok0QMa7SX/DDsHomeP9Oy?=
 =?us-ascii?Q?2h7Xb38JNC7xavKcir0A5twGKbbml2ypyG5Ao03pLFAjgH4Wn8NzdZoOkXMr?=
 =?us-ascii?Q?002PdmljxrB50ap8sNBHRG4LFoV5rs4OgxXO7ZI4X8xylLBd46ISuz2LP0QY?=
 =?us-ascii?Q?tRrGQLAWMrbi8SVrhbQaeuUSGv0NR14tQt2OZlOhtwTfbgDsDLaTWoMnnBPG?=
 =?us-ascii?Q?Lvm1mgeY5i3rJind4wswOPppGkB+8UBX16PlHE2/hAplDNemffzjbANOgH0F?=
 =?us-ascii?Q?9ji+PvN9Say9LcSsLFtePz/md1I3OFPZV4yZnvcgWPZQ1HPxC08EBg4VgyVF?=
 =?us-ascii?Q?vKGNcr2Zm6EM0KyMw6vR3BYJ4Dwb3/q2vE//C1kl5GlC9rTOvW9Kq4oFSA7L?=
 =?us-ascii?Q?hfZ359zfZHbeNkpIHwg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c7311795-6543-4d61-8ec9-08ddda0a2a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 01:38:55.2943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFsETJ/DiZ9zXjh9exOgNvtKiDmTaqh1bI8W206sHeNrua8SJ0hORasHUC2J0tmqtUU9Tlz+UKgz9aAkWo5Ydg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8621

> On Tue, Aug 12, 2025 at 05:46:22PM +0800, Wei Fang wrote:
> > Add a DT node example for ENETC v4 device.
>=20
> Not sure why need add examples here? Any big difference with existed
> example?
>=20

For enetc v4, we have added clocks, and it also supports ptp-timer
property, these are different from enetc v1, so I think it is better to
add an example for v4.

>=20
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> > ---
> > v2 changes:
> > new patch
> > v3 changes:
> > 1. Rename the subject
> > 2. Remove nxp,netc-timer property and use ptp-timer in the example
> > ---
> >  .../devicetree/bindings/net/fsl,enetc.yaml        | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > index ca70f0050171..a545b54c9e5d 100644
> > --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > @@ -86,3 +86,18 @@ examples:
> >              };
> >          };
> >      };
> > +  - |
> > +    pcie {
> > +      #address-cells =3D <3>;
> > +      #size-cells =3D <2>;
> > +
> > +      ethernet@0,0 {
> > +          compatible =3D "pci1131,e101";
> > +          reg =3D <0x000000 0 0 0 0>;
> > +          clocks =3D <&scmi_clk 102>;
> > +          clock-names =3D "ref";
> > +          phy-handle =3D <&ethphy0>;
> > +          phy-mode =3D "rgmii-id";
> > +          ptp-timer =3D <&netc_timer>;
> > +      };
> > +    };
> > --
> > 2.34.1
> >

