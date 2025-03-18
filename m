Return-Path: <netdev+bounces-175592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0761AA668CF
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 06:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167431893E5E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 05:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CD21A8413;
	Tue, 18 Mar 2025 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YI302j7T"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A61C3039;
	Tue, 18 Mar 2025 05:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742274008; cv=fail; b=QYCBLZ1v4DLnX+ljDfwxePThf4P7HGI7dQ/MPPBu3aEnC5Km5/a+GVEZe81fToeAVh6d1ZtTqCPgN/JZkC7bAMk6MRPiBgQF1vqf8VlqgA3gX7DSM1gabyyZEtF2EiCBnPjAkcuR30V1vadOtiE5k1ouaVRqZofYIyMOpb63e5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742274008; c=relaxed/simple;
	bh=9Zc+F4qvLB/wi77J2au0w9On7sGfLJ88iS8a7x5eNik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AAaM/ddrle1OkVPx4Ri4Osr8TOeaTgJKQIiboBhxsTTFFxhQCIU14EsEwqerVQRPV4BXpO3wIda69IlJ9QmP5fNQpMHeRrKdS7tgMoDb8f7tHyzqVh3p/AhlXdRC9/f4q0ffuYAgzAw5sSUmv51cU+pSB6wmGpRModZeXewWKzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YI302j7T; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqJq7A5igf38wHzZRCo8ckE7ra6EphCcEr+5euCPDtbtjvIjWF5JQp7j7sbqdr9hK1iJNHtXyyFugIixCm+dN0SqMYuPxZU+zOEWap5goTVp4MVsYjcG6wYyYRhl2XunUP3LziaYM22Y78L7kmYYm9FTYFOZ6cEsRgd1nlXV9z4+0Uc+Mi7bjyZoG32eVC98ZRDEuxCI6W6N4n2SleetNJOWnIqwCWNBR2NEIsIv/KfzDU34OXJpa4+7lIWQJEQwYL7zMGothrL7QENgt5dTAHzCxIKQJ1zc/YZZZz1ppQfya9j/nhRB2wMimLRKxEH8lNnt10PQYWAge9J98EWk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bvp5Mt1d5ZkBKrihlgXMWN/BUgoKymEZneMrO5JGp04=;
 b=yBJDQ+sTBa8fdyTV2OQxo5MOQIDyDXHOaq8Q4/1ydwaFb+PRdkqNk5EYtd89FB69qId9KFlKabjd1iKqq8NiDmbmigIuiI2w1qvWzQDP6M1z7pUFk9jLUE2fYJZYmYFFWl704isDj7KMBSsVEc0quQjx70D9ZuCMkVGDI4QNRlvgI6dMwTQ6qUPuSj/FXBFSo8CPpCnhIo72BvsXJnZy2WQZ20FfyPMqQICHgkSy8nAwzqDBe8T9waEEusOj/OSkXxCg9qlp5XdMercs60FtVKKnqC6BoFuuGaik4oaG7bflFha+BB38okokTc3GGhf7k71DtvsHXfSl1bzmc744pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bvp5Mt1d5ZkBKrihlgXMWN/BUgoKymEZneMrO5JGp04=;
 b=YI302j7TkaOu07XQGlV5oEjZLt3JWJKeqjl/2D/fIu9BpqJOtfG1EOMw4IUIg5VoJLrkx8qlM1M3ZaChcj+orVZ1H1G6zyUbL+VORJWLmN0l2TTY+ml3wkD4WEcjP1TTKQ3ngZX9lqjCLbHBNn5POQZxlgljeXcN77vynowhY4Yfmql38UQ7jxrRnstAPr0+esSAzvmJknUXO/T5BiiEK3X4JtGQaWbOS5F4HtTiVVRan2QZ5fsWOlHLPvTXUAea8N9pq9WGrZkzH6MS9xhM4ce2pA6+gWmAoxYRMTkmSh3WcjpI8cDHOOrlUUa7ZHUCV/o1XbPHGFarG7iY0sawCA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9391.eurprd04.prod.outlook.com (2603:10a6:102:2aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 05:00:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 05:00:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 net-next 09/14] net: enetc: enable RSS feature by
 default
Thread-Topic: [PATCH v4 net-next 09/14] net: enetc: enable RSS feature by
 default
Thread-Index: AQHbkkpeKbgUVFzd0EKK2KTlDzFIKrN3kByQgADPtPA=
Date: Tue, 18 Mar 2025 05:00:03 +0000
Message-ID:
 <PAXPR04MB851013FE0ED69502EEB2175988DE2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-10-wei.fang@nxp.com>
 <20250311053830.1516523-10-wei.fang@nxp.com>
 <20250317163337.4ii2bmourroiaryl@skbuf>
In-Reply-To: <20250317163337.4ii2bmourroiaryl@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB9391:EE_
x-ms-office365-filtering-correlation-id: 90717fda-c0f8-4f63-fc51-08dd65d9be3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?j6abYlHEyRrAVLMirbmVdzPO1w6Q7DzUxZtsMBydrRBOZ4barJyEAq4aqjmr?=
 =?us-ascii?Q?E9uEfC3WnpVXhtYMwAcZmWqY3xjxA9B+iELUXpnHxqZIt22a2g+8hZgtr16A?=
 =?us-ascii?Q?sVgxyu0j5fS8gbLjftCNRlbvyRFa1Osk/axXrBcxwPRhAb48TCulzQnc9QPW?=
 =?us-ascii?Q?QUTEjXAHX+c/VMFDPc3L2AzHLJrYLdkmvzNX5iX/tFRUYeJC3MlpS/rxsCrZ?=
 =?us-ascii?Q?Shykgs1wS+S/40w8GA6GPCl948VqON/mxCfiRniURcu8TMx8/Lgl1XF5+2Cw?=
 =?us-ascii?Q?ObHTtHS/h65i4q5tlxXUD96hC7nbryvdi2LYsD6J9SxXXgFbJg/gZBuX7gvE?=
 =?us-ascii?Q?ua6ov0K/JzwUR5B+Qs1tQcmyjITu5Fd9/G0DZT+VQzwYrUV3DJgyOqI2dl2O?=
 =?us-ascii?Q?yrTYz8L//NZA5pBQ39eyIhpDkZyCK+zPvw6cv4Jr85X/feTka6b+ZHoXyhKU?=
 =?us-ascii?Q?Hi5Efhlzn0CPw6IEe63K4wKbgm8JHp9K1S/curY+IkYFrAjcjmbMDD+fsQu9?=
 =?us-ascii?Q?M8IQHQONgLDpxK6K156ZeENwG7MbSbMSTaACXKtd/R0fkywZxdijrrj6mCWs?=
 =?us-ascii?Q?BAKEdmHETWgB4v9J1qbDNpttJ8GpJPsvFgMTRI/GfkcZQqhVUlHqM+q1gb0a?=
 =?us-ascii?Q?Ay8/qZDAb8qid+cA5JhDNMPRo+hj/1pIPqB4YMgY2ytWIkaPtRKZZiI2kzaC?=
 =?us-ascii?Q?HrsB4Kw/domnslLP9n0+bjLhZg63uE8xX/hYnSmTSNJTN3VmLR7emYTTlJIY?=
 =?us-ascii?Q?AYTvgwBfae7ZYiRUJwrXi2/+DF4uipnP//84Qvry35QrfCVWR4dWazzi6KGP?=
 =?us-ascii?Q?k8lk3d1tJkp2TnEISmtWp7HUyDoMeV1t/HS9JCiY4vq1ZPDpN5vD9gMiqFfF?=
 =?us-ascii?Q?3cAjpudB1C9fff9+ThpkFcCHf4sge1VSZXNWhDZlc00OQGfeihNGv9lXgJVH?=
 =?us-ascii?Q?07W5hl/+Atwd+OsMVmcxMzMNmOrGViWdnei5AmmraigayPbPxRJrzFOkUWwY?=
 =?us-ascii?Q?qB4M7EIslTh54zU9FO1FJLypVkE4wvmUH4+G3uhv4Dy+S9w9XsMrtZN2TRXm?=
 =?us-ascii?Q?7BlGiAfuAGDmHHWbRNXhIchR94692mJM8zsPzNf2k8j3sQiQFzKkVDlNeayx?=
 =?us-ascii?Q?pcfwBDcFSa4t9mMLilp4J2ocy+B7aAOKaQQsVG+N0cTVp7cKL0iMato+eqfC?=
 =?us-ascii?Q?fj2qZCJzU/Igor0lT4ArBXEI57Lve8O5iomcHqLkh+3BW9hBxjIO1ISOT3tC?=
 =?us-ascii?Q?fzk9/+isBlOJzmvd6I+ud4EUZJmFrjka7DLgh1erf6qZ4SKZALBVXAOr172O?=
 =?us-ascii?Q?2x20qsBv5j6nEnqOTglaVRmCQJLQKmBr/aKjU/7M86emM4mvtTSprLqgLJJ3?=
 =?us-ascii?Q?bw/gBg/eegkSxzggdm1JQI2wmdqgnifK1jO3uvm4mU8M25GGgHTbnDuhQRbn?=
 =?us-ascii?Q?ws1Jj6Ep+TJ9AEaqNoFC71z/Ad6KRr4z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c5RudSOUE41Ogss7P3W2bM75CIs3uofng3wqzh6VMLctiWhbvN9Qti2xQhhS?=
 =?us-ascii?Q?34CFMo1w1QS1Ij171FqLwexqcu19mJEW50Jew8tv/3ALxZ+jrqhQujPPzGAj?=
 =?us-ascii?Q?IuS0JeTPNjwecMfS8iv5zMQsze0i9e9zGz0nQHY2ogJUthcLBQI7yo1s/f3W?=
 =?us-ascii?Q?gN2oIW1AUUqPxaHMbkriMw11NA/f890CPcFWiov8C/5CzU3KicXbiwKNSM6C?=
 =?us-ascii?Q?NdzyU2q3JCBEJ/7dkYGAQD4CFDX1LwwHmMVSqgouSkzrJLyo00MgauGsZ7yx?=
 =?us-ascii?Q?J6pps/WAm2X0y4KICWmvi9NS71oEv1TgwEkIlXKvDSgStV5Fl7czbdAiQ4Me?=
 =?us-ascii?Q?27aBZLrAh17OKPwJN+M0A62619iNpBbZq34a1w/HmMbYHNhNdI5JlB84S6Y+?=
 =?us-ascii?Q?3a4tfVy287KZnVMJCedV1J6qKGyDzKFqJhSya+dcBWqswMcRU0O0c6KtGoX8?=
 =?us-ascii?Q?296VgcrP3Vad2d+m/010U2OESENmKma1A5EF+GFMU3RF3Xnw/XSdJv/w3cVx?=
 =?us-ascii?Q?Yli94o2y5mhsPre43WP/+fA2JzN70UFJi4cF36yhGPOYpbVr/wzpBTRNTV0E?=
 =?us-ascii?Q?oDRqjHNnL/JeqcMMuLRKR/ood4mhxwS68gI89/Vv3r+q0vqkR3yid8z5rG7b?=
 =?us-ascii?Q?tcGxmbeO8j7wFwL0l021TLX6kzT3JyyD1kOJbB0lEtmlr5EFlyFxwnVeDYbP?=
 =?us-ascii?Q?xn8jHza+fhrsP9HCBs08Afefg23jnR611H7YYaPVcL7HZO7zry61vk7pe5kC?=
 =?us-ascii?Q?aFtE5XfA1SUQK2ey7mHmlpOUoHA4VVwtRXJXXhSjUCPmyI0FHKuabqrWR6MX?=
 =?us-ascii?Q?EPr3EFKgNTTmU5Lg3aw08fLSwV+lQF+SsL1EWHt4Tp1mNqkb8vwm1yQddwIC?=
 =?us-ascii?Q?ZN0zxk8/za8Zel1Y1wOQdjn1aiv/uSwstbzV6bH5GXdGwObCQmoNQXm5XDPE?=
 =?us-ascii?Q?q/sceR8wi/UvJaZys6S0lSsGTCmGyfUMmk0jw64wExcQVo4GGRtT6nLMxvW5?=
 =?us-ascii?Q?tTLAidybksgM+2B2Sr6tvimUU0s6NdBKsYmxDWoViMHRuxru/Qi68+u+6A6X?=
 =?us-ascii?Q?xoxn9QUWtjPvluYtNwpUSXDZo58kYezcOzF1+8zEv/r/2sJRMdrLFQIv5CqS?=
 =?us-ascii?Q?Yel+ko3ujAlWUYJxgBN0bJbifc0HTlEGeUoRzwxHvznUrS83tBF7za22vwc8?=
 =?us-ascii?Q?4O6RtT0VPHqbCzPmyNmk/YWgk/A54lf8sK5Ih6iX3vwKZ9P9CBQrW43iUEbd?=
 =?us-ascii?Q?uxCAwp9W0dBoq5J8aJCW8/3G4uAe06/DoGzUM4af8XvTecQKEc4r+IaUveE1?=
 =?us-ascii?Q?R7XDvjaQl5JTFDkjPt0gxB1y1ArfYBO3g3fXPHfh2uG9swb4ypGE05T9tiA6?=
 =?us-ascii?Q?OzebcF4Y0sH3/F9PRXRqZVsBV5+rfwNyKmj35UTfajw2h9a1HDMBKW67eWwt?=
 =?us-ascii?Q?OVJFKOvFnmIyjXm+TnnzySJxW/4lOuRdN2dlYJH2atfcTR8y8UwC0pi4rchr?=
 =?us-ascii?Q?JZeCOIG5YjYM/PiTJSeqbDlbGxw+/iR0y3rlFZS8BfFj7xh/1NG37BVsCzfO?=
 =?us-ascii?Q?zKUfNAxubimkOyBEuWk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90717fda-c0f8-4f63-fc51-08dd65d9be3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 05:00:03.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8GtJO4LlcWQrjktKXgF4ZK7FE5VjW7Cveocs0vS0obBCEdwIwvCpGlhbJOZ4dCO3c7sgodtukYUUrWtQIOoWbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9391

> On Tue, Mar 11, 2025 at 01:38:25PM +0800, Wei Fang wrote:
> > Receive side scaling (RSS) is a network driver technology that enables
> > the efficient distribution of network receive processing across
> > multiple CPUs in multiprocessor systems. Therefore, it is better to
> > enable RSS by default so that the CPU load can be balanced and network
> > performance can be improved when then network is enabled.
>=20
> s/then network/the network/
>=20
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c  | 35 ++++++++++---------
> >  .../freescale/enetc/enetc_pf_common.c         |  4 ++-
> >  .../net/ethernet/freescale/enetc/enetc_vf.c   |  4 ++-
> >  3 files changed, 25 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 5b5e65ac8fab..8583ac9f7b9e 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -2420,6 +2420,22 @@ static void enetc_set_lso_flags_mask(struct
> enetc_hw *hw)
> >  	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
> >  }
> >
> > +static int enetc_set_rss(struct net_device *ndev, int en)
>=20
> Can you please add a preliminary patch which converts this function's pro=
totype
> to:

Okay, I can add such a patch in this patch set.
>=20
> static void enetc_set_rss(struct net_device *ndev, bool en) ?
>=20
> After you do that please feel free to add my tag and keep it in future pa=
tch
> submissions:
>=20
> Acked-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>=20
> I don't see downsides to enabling RX hashing by default.

