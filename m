Return-Path: <netdev+bounces-206493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B19B0347D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E13C3B0EA0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 02:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308031CEAD6;
	Mon, 14 Jul 2025 02:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OXa2yhVU"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012045.outbound.protection.outlook.com [52.101.71.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416A47E0E8;
	Mon, 14 Jul 2025 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460331; cv=fail; b=Xz3beIAotXxba9Hj00Z2of3X5Vd/NorH9vBCfO+PRPvWNAGUhhpwA9L35wc8TXc4Zv0IgvF3vZr3idkMtG5tvqpGRMBfrbwilia8Cbst/Ig0k/jX4ieGKC9tgrXOJh1xC+//hfuFHThcjh6h4rCIn/Ykh2vadJeaY1T0Pu0cj64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460331; c=relaxed/simple;
	bh=EcL4gzcpsTzRdBUylxt3fKbtQtvVb3KODFWGzU/Dwgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t00YQtZYvC77oAiAUaMTMsQ1AlArU9C4OnxmD3NEI1rm8kgqmG6cq9pSzoxBLfXmkkjYjj45PH5O+AqwP4TsJ97rJJ6IIRiwmLnxSuz7LX3T6UDu6/tbUPvvSZnQKUBoybxnVrm31hnEL94iGMYpRjS9gcPu3T+p4r1ON8FnqSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OXa2yhVU; arc=fail smtp.client-ip=52.101.71.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+NujD7vJ4ZiprfzF2sqO+hDOHtTZjDaUqvYSmpYwuvI83n4R/rWHhEAEhUd/LM3rJ5LatlOUoSdhy46Mfmbwi/V8gr31cSmeTIQump3axeXPQrx3nzoCmAUXqHtOAquUtGlsEgpy7Ekf+N/+9nqzc/wArJJPzQCYOZlCMS5LIO+rI2lUZckz6Gy9nispzN7b4Zg6k11VjKywCNHLyW8Q9HrsFaffJi+id62fMbGVDluiRGq8kMDt28wRgSI1Xy4Q1TAQUK2ZgB+ub0FcbODiYWuCjp5GiCwYvtRb/2kiNsav7MXL4sAOTmkE5tvwMhxBFvdhWfHA5h6FIP86IHqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEHq2bcYedZCMIzpkFqO5KUVZOZFQ+8qYI4po7ZbXO8=;
 b=dpQmysXLVp5SGhBKBHU45c5QBqBzp+72QUfVOAJZ3BwGMdpInGNhTBZUL4TBegfJICVFywnsEkcO8L/BqWMC93lpVb1Lt8eAd7FYeFUfKu6BcNKZMY+L+maT6GdKCJlIV39+mj67L2xkRWCRYPa+VRx+TFVw9E8Z5YM3q7hoS1C6+7VbUwO+tccd36s7F2SDMwlWzLNAsWsinXYDzvnZIHY7uzlpqQ0qSyRuwIyYWvr/XjsPDOJlgM1sQUHBfC7+pmLqe5CapHv/yZtcQsUoVNC0a1pt5x4LyQ8anaNQqOVgIOYv24NvoEbpMURa0wZDosiN1HdIgRYpeunyf9FFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEHq2bcYedZCMIzpkFqO5KUVZOZFQ+8qYI4po7ZbXO8=;
 b=OXa2yhVU7k2WJ4f2gZVRBP1zEDZWnuWSZCrKK4KnLUZ1YI5pLdopCoucvbzD96t7cO2Z/5P5L/kMvlA+djO8Q7XQSep9rge2nQ8h59UteSLXLSsrlt3KjEZQvKmFlnyvfetoy3EZ7HHemTuA51VtlofzWQTLwT+2BgN4y4NB/FnuwV/9gfjhIjgJUEpuV1rp8LHRvUYMLcBQGZxT0saSW/uwwII6Cb/kmKMhx7GKBeMHfiuzXK0IihEae8XgjoIxSl/HW6dLBBjNAd6IoohCQ9yBaGbbkz3Uo6OJOq4sjUFe4q0mbZGAy0LY8kcJJI/8TwgsOn41yooibd4i8sGdMg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7633.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 02:32:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 02:32:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "F.S. Peng"
	<fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Topic: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Index: AQHb8jPWk5neHXUn3Eeo02nqDOVTYbQs6sGAgAP/mVA=
Date: Mon, 14 Jul 2025 02:32:06 +0000
Message-ID:
 <PAXPR04MB851054B098F6413D3FE9321E8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-2-wei.fang@nxp.com>
 <fc6b76d6-d789-4c1d-854d-c2e2f2a66492@lunn.ch>
In-Reply-To: <fc6b76d6-d789-4c1d-854d-c2e2f2a66492@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB7633:EE_
x-ms-office365-filtering-correlation-id: c9e38725-272e-471f-26ea-08ddc27ea04a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XP72iC5MiC1VesqN83MnAJCpLdUaLsFv/q8qTsUDqzJt6kZypP0+NtqOeHzm?=
 =?us-ascii?Q?fVq+lYwGqGMyBQUgXmYyoqpzSZzYP6SZif4pODqEpeo00Ey1Q6QV817xxgTT?=
 =?us-ascii?Q?ebk+eLCOmJficlaDYs1y8sfq7+Z8IkVqq7BpuISbpt3C4GLJa6CHr/ruCEIO?=
 =?us-ascii?Q?nYCcN7HNKq1+7XFYHbewax50zKr0yOcQ/tozAJ+1dbieN8C510rHUeLv+W3P?=
 =?us-ascii?Q?xRDOCUs6v0zWKriNL7E4zjqloh4BrZZSot13dsDDrntWi0Xjx4B1q8xwcs5s?=
 =?us-ascii?Q?kyCl0v/Q8S84ESagQl9B1/pEWT3WQZbv/mvZRhyGKmpWARLuvjfHkJNjwHSp?=
 =?us-ascii?Q?N15niyw6KHPZ2uAzUvLihMHF4z8+vVK95ImvlI3oJwAGZfoBPGRgvjQ9XiXe?=
 =?us-ascii?Q?yU+cLECVGUGnPQpXjN3hO8P5EavqmN3qFQMA9+XjHqQB56Tw1yM+/LiZMABp?=
 =?us-ascii?Q?ZI6PiQ3X9yHuMK7tG2W0oPe8Oy5OBd2GdMC0LoB9f9BxxToY8WCjqClNLSoU?=
 =?us-ascii?Q?ulEu6bEallLzyLrKw0LloK0oqV5TfjxdENDBMIry7lWBCE877AzsXxOV45hQ?=
 =?us-ascii?Q?ZkhD/1pnPNaAUtP6dwcazAw1wMrHFxzPvJAV8TyhBBIYZY2lPeb7dhcx3z7E?=
 =?us-ascii?Q?OArbOj7uVycrixdImM0i4+2SlEMMGpAHVyP7cHZLcb1GPeSKmrxWNJW/7FQy?=
 =?us-ascii?Q?FoOuCSZKL+d96GtwPpq4h2P8ZAWl5miz5zwwE0gu34WcMw+aINNCfQHeEeTC?=
 =?us-ascii?Q?XXJHjzJkz9Qf/HJQhAINbKN40jdrjufpV6P1gog07x11uYjqqUm5XCbBH9gR?=
 =?us-ascii?Q?zKz2a0b7GXX/8ga6+ITdjmtYJ+9PTqb/L+ebzx56tZh4dFtAjLseNC+1qMxr?=
 =?us-ascii?Q?9hslDeOAUgJHsTs4/h4n47cWRG6YV60Wl4YzsGVFjuSbO6r/Ate9YT8oGRZh?=
 =?us-ascii?Q?0Hk7RaOPVFcM7ZWo+ifrw+bfuPPlljqbxC3TrslvCGttmdDSgaz/tr/juaUy?=
 =?us-ascii?Q?YR7qd02tY/qMsurIR7n0VkdC1AnekMDjbSXA+jYkVLG1YniStR6H/nEcrJnQ?=
 =?us-ascii?Q?tNSdzs09kh9jaHwBPbz3WnY0cR/TcA7e9SNMzWu5J1oufynbgXn6RHQGRPro?=
 =?us-ascii?Q?VtwKbPAk1pySlc9nqdpSjLO8WumTzQ5DoNrZBxUFL+GwfePO48/cPnKjJzdR?=
 =?us-ascii?Q?2NSjVXP0EUlAAnXjXCRU4IccTNaPkQVPqmhGJkW+mjxA8eLGkmd3aAqh/TmY?=
 =?us-ascii?Q?9ucAWJZPqF/o8Gcez6t8q991LRaAqsD2n/6jPrRiJ7aiw6OXvT01bExbMw5s?=
 =?us-ascii?Q?ZCKoVDnRuyl5WqAiNpRvPQuJcMLuKU/RF2SaERaf/TN8yJWH7++ZE4Cz6uT9?=
 =?us-ascii?Q?Cms+JLDrEgKEkOoHmj2XQOLF6V/py+HSLiP8wT49w5C64fR71lt/UIGY+mLk?=
 =?us-ascii?Q?3W+TgXi+wz3yMFc4BE88blHOFoZn0vZMIY2JmBD/3o2NxBG/dXRnJQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nRhtJGKWLgJjo6FIRTLY4+PARhLf5121Z5VTXPk2+IOe7NLBgqwFJQXPRr0E?=
 =?us-ascii?Q?mBWkRra+u1TimnhJjPaDyrZwokdqesdXKmX1jNI6DKn3lB02nOOWMPchhV1v?=
 =?us-ascii?Q?o9ZVAf8rnWaTn26VwsLMVrgMmLur74Q/e3YJ3k+4+YCF+NF5SGwaaNwHFELZ?=
 =?us-ascii?Q?SX4MJ4chRH8U+h8LC6jsbefb8eeBA6u22jDZQXqdi/QPuV8SkLWekcu/ih/5?=
 =?us-ascii?Q?1mjbj4O10nbrI1eY7Dq2MQTQPY4reA9RDr7H7/dT+DZCWTTdtETUu/Q6o9QU?=
 =?us-ascii?Q?r/c8OesFbRGbSrMgWGToj+fgDptegZyBiEocqw36l+eRmm03LAczPeLF7n5n?=
 =?us-ascii?Q?rqEoLEgak4GnPISfW9kwK+u8RZsKMMX693fTUdW7djAKEox9of2cMOlRs19u?=
 =?us-ascii?Q?vO3MpaMTqpWb+C0blqFw8vRtAhcTN2wwPX6UvmtgViBPzCZLG8+z6VfUHOO3?=
 =?us-ascii?Q?9K8Y3iOoR2d7W1L7J0ro1O2TRFp7cf/LqGNj6FxnoG51K4MmD9gqN2RwXlgT?=
 =?us-ascii?Q?3kkhfTlEw+Jo8fv1vinTWuToJcDuhqZ5oW544mUBG22FhjzsQz/mfkHNUqgJ?=
 =?us-ascii?Q?SUvqra/dh69PdQN8LQE7f/vIsxeNFaOlTqV7Tunzg3puBxOyKWwbsTJmuV0P?=
 =?us-ascii?Q?t+n73pHXEHaq+wrdkBjMZkex46x6PBlre2Z808qz6cpDbAJ6KlEeaOQ6lI3R?=
 =?us-ascii?Q?jG1k5ePgNpj2/C3P0u5zBlJL5+X4/tPcltEZKA+RT51puf3Nei30ZAP8cJ7J?=
 =?us-ascii?Q?eEin/2NOrE1g/1rVp/8Hb8Fm2SOIHoPZwV1sm6YdHU4FLL3IYQwbyTLzDXfN?=
 =?us-ascii?Q?CjSc3UhkqaDS0zaU5vtH4Pr67BvVH8xwzjsLiD7rBR5rteSncjEQIuem5OGV?=
 =?us-ascii?Q?OfXUpsQvIMkcq8U/0TLqa1CV4LYEWLmsgn42rQWjvOoiNmtTLSNgxA2xnjO5?=
 =?us-ascii?Q?oSI65XTV7KVQcY1S8hc/TBYxKE6u4/3opghzHAi531UDDs1DJ860lCGjcH6D?=
 =?us-ascii?Q?WJBTNc5+MV+U+pRcVqbbVkr3uxlFLBzizi2QGmCz8/Mfaj0KY54rm5AdGxxB?=
 =?us-ascii?Q?kcXdaNzt5Hy8fQy/Fi7Drhc0vqgCOab35UgGRerVCT7Fsc8yNvKMUseXCETe?=
 =?us-ascii?Q?8qyZqUbtTJh4l6hiwAgagpBkeFcyguLI8lYvDS7Dq2OuIt+0PJ6slL6qo5S1?=
 =?us-ascii?Q?d23t9g9I1j8vU3fbfu/7vGqVWFpQZjxMY1WGlZme1oiO1qaOS01+gy706d2F?=
 =?us-ascii?Q?gH6vGoViPlFBVXCDFvUqQXB3+ZQM4emeSP2iVyoB7WzFLWV5Ml4YUOsfrGvJ?=
 =?us-ascii?Q?BxWMeEXLAKJKMOGtCkEArke5zOkrSV1X2zrQ1jrnyzy2/T+PlFhRDqtbodK5?=
 =?us-ascii?Q?x/faj1S4FVBJL7UdG1MfT9XfiDByiPlSKLbTfE7SVUKs7OrYDnV9PAnpREJO?=
 =?us-ascii?Q?0jt7+VNF36DPMTmNcZJ6N2+2gHo0whXaxSlgBP5MYCOk7XTdNyuv/FFsmm8d?=
 =?us-ascii?Q?4WH5ALwjMUyNCwFbLPlZ1iQmPu22sNsQJym7rfMSHkP61U0emR1A/RyFCVzd?=
 =?us-ascii?Q?pBpuojyhe2Wj3WjmPW0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e38725-272e-471f-26ea-08ddc27ea04a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 02:32:06.6976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2agQsQhGfacVJLMrMWcEt9pKxHP0jLuWRS8BWEapHHepG+1WHr9Sl13oz1dYBYo/nk+XnP6k9XxEzCd2xIaGww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7633

> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    oneOf:
> > +      - enum:
> > +          - system
> > +          - ccm_timer
> > +          - ext_1588
> > +
> > +  nxp,pps-channel:
> > +    $ref: /schemas/types.yaml#/definitions/uint8
> > +    default: 0
> > +    description:
> > +      Specifies to which fixed interval period pulse generator is
> > +      used to generate PPS signal.
> > +    enum: [0, 1, 2]
> > +
> > +required:
> > +  - compatible
> > +  - reg
>=20
> Given that clocks and clock-names are not required, please document
> what happens if they are not present.
>=20

Sure, will add the description.


