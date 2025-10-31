Return-Path: <netdev+bounces-234556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7D4C22EA7
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E3E34E3D73
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C5A25DAFF;
	Fri, 31 Oct 2025 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jcqAWkFE"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D3D253932;
	Fri, 31 Oct 2025 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875352; cv=fail; b=XH49XwHnTQwedEty+arIlF3QkN+qVQYpSrrbURM5kKt55zY/TC/T7lu/9lmUuANjZrjEHi9wnT5qS4Ff5wfUAmF81vf7mpcP+mztEXX/WxaxbrEg+xyDWcOrEZaHrzQGkUbngFNEmecS97UjoqgZB48wFdMp5+TSGTI53iM6T5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875352; c=relaxed/simple;
	bh=+H+khsNVkoCnj25Ppp51Z7Gi6Jo3q3tFU3RrT4XvkVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TS1VwVAP0CBaVdYEsF4dnPbkv1IhNiQ/CobLfpjMImrhA7w+/ReIi96yZ6D4ff2DyRR/+8Xu7kPNJr0uesNfgrCMYrxIMa6aYeJN1fgyE8sBYjr8HviyGMlNvFxsO1NSaq1Ghvl2fITJkvJ5CRK4mgk10E1bOrH7q6pWd/7ttMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jcqAWkFE; arc=fail smtp.client-ip=52.101.72.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDp8hyRU+ReUirZkTpMMdoIcCjr0ADFvlxC7oiASkDl0eWE1uKeVLy9By+I2dF4IETbeyEltkHLF35Ni58NwAvzEGCid/csMDz46pg+Vv+FmormzCblYvNygY9OJuXNUWRMqeyPbQfBaYmiuz6VOtjUIwNrtBemEeupETzVvbCnNZhGj45jMYi350N3gQ4lq5Ei5/lUGtUoq8mGgmf/TrDa6Yrt3U5SB5YouDuygcQwejFQtMfDefn1JX+CpgjdIuQul0cBS9Wrm0phaN7tJucFs8iet9w1N+8koNChEJwogA5ZqC2rGdOhaTyJCU2k1xv8F9JLl4P1ispiJIvd9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5KNqJoXxnu5RLa0mZd5j6+GMZZNgoS8uQuvEBY0jN8=;
 b=uyQcdwBGVmkEFQ9kh5eiq+Rkoq6Xb9duxJk9zAG5NnzWCw45LQgBFDlT95iEjblFj9pXaWE8BXpmQd9WvpOW30lAehgeSTjUdNYhfiKmI2sDCQnhbBAtMHA5a2FwQBKNzS8nebT4j9jtL0tmImm/7xLCSix0ujPigKxMINsaieV4SZzzsfgo2l/wtqNcZx//gmRCMwgJA76CqyFnb0MckrZJ1pQfoX23eF1QU1nK93kOvAfj9uxE4RaHACD5sxbS+KjA1Ft6I/3akcWpiQE6hjm5yc1i9qY3MJVvHsXFEtIYcxNuMotMBKgmcuIwHRc3oI8jCYLXcXHvFdolgKPdIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5KNqJoXxnu5RLa0mZd5j6+GMZZNgoS8uQuvEBY0jN8=;
 b=jcqAWkFE3G/Iycxuijxfml99WhOjj6NfgjqrNLIeC0y6S1KxavM8tepJunKfRcvSIB8IoI7zHTC0meC0w9IbYy8Rvs0bPHipdlsIcw05NgdUyqSfPtIJKksD/CpvjMofhhAhJXijpmr75qGtN/QEvmY64FDbn9HExLLX0SekA7+hoHQWDW8t1oe8ClKgSSGaz2oOHeSrTDMBMY0ORrGFU61zLzSjt3wxvwWvC9COYYmzko1Q5yPp7PkVfINquw+l3l9fzkE5sHAsW6bAEa/g369quCKhDnwvAn7jcKXf4Rncnmh2Oao2Sf/HIZs/Yd3dG0zWK1grE/lqh1kAG6VeVg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM0PR04MB6913.eurprd04.prod.outlook.com (2603:10a6:208:184::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Fri, 31 Oct
 2025 01:49:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 01:49:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Aziz Sellami <aziz.sellami@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 0/3] net: enetc: add port MDIO support for both
 i.MX94 and i.MX95
Thread-Topic: [PATCH net-next 0/3] net: enetc: add port MDIO support for both
 i.MX94 and i.MX95
Thread-Index: AQHcSYDXkRjFYTA/aU2GC/wHEDze/bTa9nwAgACBd7A=
Date: Fri, 31 Oct 2025 01:49:07 +0000
Message-ID:
 <PAXPR04MB8510744BB954BB245FA7A4A088F8A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251030091538.581541-1-wei.fang@nxp.com>
 <f6db67ec-9eb0-4730-af18-31214afe2e09@lunn.ch>
In-Reply-To: <f6db67ec-9eb0-4730-af18-31214afe2e09@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM0PR04MB6913:EE_
x-ms-office365-filtering-correlation-id: c800dda1-bbd6-464d-0b13-08de181fadee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Gg+do5iEOVAWhHLUKMq8SAz/y0Oij+q6GX6EDk0jDpfMAEM1ZGb3RTiwpnLX?=
 =?us-ascii?Q?6YAaM2oC3N8bCVS5/iDz5TV59C300I6Jek/mNYETaQQM8nKD81uvLRat7eEj?=
 =?us-ascii?Q?2l5dceGon5NjHqlGleNnHO0QPKyRTFSOqmFMxhyAsXTZ90UNBqJp5ouP34/Z?=
 =?us-ascii?Q?2NKI3SXCLflWCz7eC24uYQ+w4NV9ViMSqXnZOx8UwP2UqZsQa4LdP6y7HnUu?=
 =?us-ascii?Q?v3OHsK9+otDRDucSEJpPCk/f8l3tl7RDlXCB2asCQse1BDqqs90Xx9Oe1tS3?=
 =?us-ascii?Q?o6hhDvMEXpmY7EOxilHoEFmmLq9WFXQgOKD5pj7ZmmrG18eX5y5gSND4O1e+?=
 =?us-ascii?Q?mieiReQzCjzyMgASXLDQe2BqBf1Nw3u5gFOgLgxo8dy5yDH860CfWvCX4E9k?=
 =?us-ascii?Q?R7g7/aTK9/kODSE3+rpV9sJb7H6F5HVI57Xt/CH0agDRHxvsGg/2bh4OFUfM?=
 =?us-ascii?Q?9tQ/3/CSisYNHILlDqJ33Tu7KY5H4nFgzQqZzf7uO9U/g0z9mIkiRtKQNH/u?=
 =?us-ascii?Q?SUm1dW37Ntc4mDY99JA8xH+CEL5QEXWrKejdzm9JDvvlOMzF4jN56hmvBm2o?=
 =?us-ascii?Q?1RXWLHABjgMqNHx/5NaMeKPgs/V4ZQREPUP4cV5yEPhq/u/lq6KafGaA81NE?=
 =?us-ascii?Q?ScYn1Fhb2Jzh0ImGY56tOE5VownsTBFVRhCXCwdnmHWIjma3S1Q++Tu95dc2?=
 =?us-ascii?Q?A4W7Nv5yuysCZ4YQbhctoatuwPzdXmsRtIvcdiTpyV9fvJqKkRXsoBHElXxa?=
 =?us-ascii?Q?3vo6HMxfrbvDPKNmhj34d0joQ/7PjUUtI2MfZujKqMbFrA9BeYfD6DoMh83d?=
 =?us-ascii?Q?6QAICUS3+LQnsrlkvf3zMGpHNfF/Fw18LqIuhiV7bLMres2i3wGAztaB7w2k?=
 =?us-ascii?Q?MR13nJnfueqt1WzF3pMNFGfRtEBc6aeMn9IjZ4z4FsLtZAgkh5fOIKUZacrR?=
 =?us-ascii?Q?1I4MP1OcaS2tohCIl76Qc1XZp963zKH1NL1ha2xLxA+gjwuUIh3zSvIu/H1X?=
 =?us-ascii?Q?gpe+Npsqz7WrKD/2xrqgbYk8iOIjO7i1YF4MY6NBIp7kDhLzzvNTB6+xmT5A?=
 =?us-ascii?Q?UDeotIksHNT3+81izqY2aFPr8TNF+2cjNyd+ljK0ZFlWLvHQU/EH4lTC/4uY?=
 =?us-ascii?Q?NzFajfv1YrbitxiSEX1/p5XryPudrkNYtzL7nB+6UiBl5FFsQ5CFO5mELkki?=
 =?us-ascii?Q?Hd3JdG1IIjgQnLxbqcywJ3AjJ8vuK1q60RDB/wLahgzjqQ7rjZMBT4YDu0H9?=
 =?us-ascii?Q?io+Svo3PQd6pQ8abA2ZqYVNpZzNw6d8PuhmUrD8joybIeCmJfcthuvBMe1Tp?=
 =?us-ascii?Q?QjtfF+Wb9qTymXAnDBIOsh5RnebUxHKS2oE3Nl3b9+BG2dtjbkhg76yLErLU?=
 =?us-ascii?Q?h8FArfIjQNK6gDQfQEY3MBqBMR6Auqx0qh50Kx/2N3M65Kk/ZDI2LLa9eqFW?=
 =?us-ascii?Q?1G8kY+9g/QARulvjMn3fK9djnBToYOZre3nPldbn+a50X933y9tjMzf2QOFG?=
 =?us-ascii?Q?YlmEVpvOCVznZdoUKR57yFGLtKeidbHQvdB5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6jW2sVuKBrKQi0eWdaUAV9iGPploTN9Cr9lFPcPZEPII2fbAy3zKjRXrsxwD?=
 =?us-ascii?Q?/cY6QnsIP8r+Y1ULJpiCP2AJCNI99uVwiAuxG6uinUtLD7iBo+6VpkZapfpt?=
 =?us-ascii?Q?h1OgDur2yi1Cpmwsuj8aJgyEMPhbgN6RIExCrVW+aftDcGdEqGhmbaG+xHKx?=
 =?us-ascii?Q?Hwhzi3cmnqbsWhKMuP8jMiK0drD/hpkM5235chigEUooyW3eHiDJoWZpAamu?=
 =?us-ascii?Q?mN2SRDVvcO18jEohvMDl5T1FOZCvDBc65H2O4Rjm0VSSODJ7RrU7N/Dlt78j?=
 =?us-ascii?Q?9P2KVF/KDkoLjZXC3rwrUx/kiBJhFzQ/Q6x+uy9/F/bV+DlbDZi8kxQKGnyd?=
 =?us-ascii?Q?6qWvH4Bt4ypAN1hqPEroMXf5vm4SnDvIL5b3y0MvTEZLxW9nnagejl5+iV0A?=
 =?us-ascii?Q?iRh8XDs1UYceowt0OUdDuqd552qOTfbcdWhnLLVoOuVI7DIRQu42rsMB7lEp?=
 =?us-ascii?Q?/CsipJYKqTygpFXgWMxOyIORDg9etdCYVCp3xZqEEbaIcYofi7DGydZgX34V?=
 =?us-ascii?Q?SkKt3Z0tHrbEnyMumK0GNix0wB8KtZW3xQ2gV/PjWzep/L26eT0wqPvt5dmy?=
 =?us-ascii?Q?k0pUWioYb+KexC9OCKB/5G9vD+VEtfeVJau15XcJtk7ncA1K0an4v9S5ugS0?=
 =?us-ascii?Q?kfnSzoI0qFuZYq9b7lUFhk9UUPqipCIpZEYbVFH86ioRW8IJo6SnmYqV7ksT?=
 =?us-ascii?Q?Zn2jq4T9DwH/roYAi1E2zdlA+NOLON9p3cFd3TG16A2/zIjHTEmNzOQaKTdS?=
 =?us-ascii?Q?KL7zWW7JCEO8wi1Sxja9S0v5W6T2FFGEi6b5kog0pbkZ0HZpcJ39fr46OaR3?=
 =?us-ascii?Q?8XhhiNHJprU+ihM5NX1EzXjwtsrIuGuHwT7Jk5Y51EQFDQwshx1cOc58H3HH?=
 =?us-ascii?Q?j5t73Jw7tV357T2TjUAsEjeptW1wiDJmJAACoP6ELQotMLxgll17EWajiAyc?=
 =?us-ascii?Q?A5SbqZJzOxOoP5h9d2O/ZyuWU3izfgr3BO2pyeX9EsMlBdJ05PXqN+Hwlrqe?=
 =?us-ascii?Q?Jn7wRruxxXdXQodL0cZ3D924ZxFyyZBrMn3JZ+CHy1PW0X6nxYFw7RVa9Zlt?=
 =?us-ascii?Q?p55CpiHhXtHyciCBSgoVWY5czzL05ULtQTROACeY19AF+0Q873BBFCIjBrEt?=
 =?us-ascii?Q?rpWl1ACn8J1F75FmNZbHqubKULm23vHawekKRQQzxCZ3u6eBGxfMMCgEZkJf?=
 =?us-ascii?Q?H8TliG29fIicX8OZk5x++4EdtkqjWv7vDel5pwK9fA1R0AFHZU1CypfhWdAP?=
 =?us-ascii?Q?4u1unUdCByWYSO3eHdWsEAlDhzTN8s2XgOU42a0YqDILcQOyGXJNzrxD35/W?=
 =?us-ascii?Q?uhQoUlxVWoGsE5cXtbpBZDEea1+T0yZDNVWQSxlZhmifg+h8IWdAIfEAu/R8?=
 =?us-ascii?Q?CRN9JOD8KhL102biwlfDmrLeySpwDqd/9ESQFM7NcJdgTqujWigEeco0sNDk?=
 =?us-ascii?Q?lkWHtgkQEQfnGAz8e/GpoDV8UL6Jd5zX6AnMk1pLBfX1HU/VOh6KLiVejgP8?=
 =?us-ascii?Q?8jTla+HzVfPsGNyLGZ0kRiNmv7cJzcUsTVwhjB5EDy9C4raHjZQrKLZ9DfNT?=
 =?us-ascii?Q?D45USH9/DoiIOr77spM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c800dda1-bbd6-464d-0b13-08de181fadee
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 01:49:07.3703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRzBXE2pfYP0lNQeYcbaVMJbyjs82xMN7Y8y3h3dtc9wrR6XzKurGa5HqnAPpSxviKSYRk8kqV7p1org4TFaYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6913

> > Similar to the external MDIO registers, each ENETC has a set of interna=
l
> > MDIO registers to access its on-die PHY (PCS), so internal MDIO support
> > is also added.
>=20
> Any reason to not just hard code it to 0?
> What is the reset default?
>=20

For internal MDIO interface, the PHY address is fixed and we do not
get the internal PHY address from the DT. The only part of this patch
set related to internal MDIO is changing the base of the IMDIO register.
See patch 3:

-       mdio_priv->mdio_base =3D ENETC_PM_IMDIO_BASE;
+
+       if (is_enetc_rev1(pf->si))
+               mdio_priv->mdio_base =3D ENETC_PM_IMDIO_BASE;
+       else
+               mdio_priv->mdio_base =3D ENETC4_PM_IMDIO_BASE;

> DT describes hardware, not configuration. So getting this from DT
> seems wrong.
>=20

What we get from the DT is the external PHY address, just like the mdio
driver, this external PHY address based on the board, ENETC needs to
know its external PHY address so that its port MIDO can work properly.
So I do not think this is a configuration.


