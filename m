Return-Path: <netdev+bounces-234793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B325C2743B
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 01:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533694047C6
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 00:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3593F1D5CD4;
	Sat,  1 Nov 2025 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g+SAUALv"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA462581;
	Sat,  1 Nov 2025 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956688; cv=fail; b=gEL8Dl1dvvFaqhdenEfJjg8tMAjVJaMFLNVu6JD4nK5SDrW5jGeGNWdcd7moFRbtnH3ncgfhQ6NwjCIxMbOJEh59Ul39CjZZKNJEb6kCTTtb6wZHeeK/yUV5U1RiEIw6gL1neCKe4D+hDgTV5+WXjctct2A1Fs/SusLOJrR05h0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956688; c=relaxed/simple;
	bh=8XG8dWQfZxDTLHGx/Dl7Y1dLOtZrM0GySIfGpNGc8LE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kts+H9JmVQDoLLz89CvxdqgKs5/rG+3QXR/3jetu4jKVyNBNKHkPOirhbDgBWtm77lxKEwjWMMVCXr4szlBJov0dePJGcRCVdwSg7JDFkE/i2HuErnS0AMWBbgJfdONNbJyByANebBCzqZ3X8gbfIIm2hsC9p74t+DrczqCGCT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g+SAUALv; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8XqbWK4qUrbbjTcmW/52T9d8Q788ncamXxPeefZ7ZlQ9Jw72yorR9wkR91IVu2GdPULQU28SFRhGvsLrg4J0nm70C8bBISq1ZhNH+P7KyRCCK2iWc+6A0j5Eoa4BU/uVFNIUk63kf1qG/hufsRDBi+b6b2kkSPMZrOg8Jeh88wHRGnUjSOT7plJr3X1dY5EObA0B1WyuIheHmE3ZSb79DKK0VgB0ekri49cJkmXP0qcgy7HHfmhYCVaRUiW2ZTlwQqa89EcyZB6YMsJWDUNPnBPxwnDna3+K23hYiCW8J6mcqpgNla0WneWA0A2ex17sawolIhOA5+0c0itQS63kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XG8dWQfZxDTLHGx/Dl7Y1dLOtZrM0GySIfGpNGc8LE=;
 b=uMAjheSZ64km5P7nwzNeYbdXv2ZMXn3zTZfnLzvWCivCnNha2qID8sL0KMT6rMy1Hwkeq4jJWLFmr+Z9cQc1vX5gr/IWpQwQ57HKmnRGlTlHhoelLXLgycLLtdRjZXLFbe/Vy88sVHP4eAYW5MUY6wp9YpGJdqXZYF8EfW1P7tm6nrxUAuZZx/cEGOFGHKVEnuwkTCKgwTtjTu/crZBeLcT0gmGzgYIiMeFne28LcMElBKeZdloaZSeJkkUkeRxHx+w0Fzj24l0IbBcS0Gmh5oac7Of8ITAcHT9qBxV2IQ7FJ+e7+L0qMiP6GTiucJA0RSp+qzwB+xHjEjazkHa7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XG8dWQfZxDTLHGx/Dl7Y1dLOtZrM0GySIfGpNGc8LE=;
 b=g+SAUALvWN1iDRc1/pb17IlekiU6JruZEF75RIDc6JjP9H66ebg7qNF44ejJIuC764IItZWDR5H1u+P6V6PW6ME15i7Pc+Kqk9ry0IiLNUE74k8sL9A8LHPiWPkD+YqJ3yX9b6jh6sGYpnn37oa8agYaO3Z1H82hflTiJ3ocPN10vby0CoGsUSaqDpWx+ktVvQJFwjnb8ktc6S3pYbSuLq2+ZP5RcxvN1D6RNqF19O0PEskP3ZFD5xaCGLCsF8h21Zl+SK96lBUN2/BOxIwQY1BawVR+G368DzT2SUdBNjofIFANuDWL8uRIDrbNQbQMX6ahHqeahHTaBownTN5vvg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS5PR04MB10017.eurprd04.prod.outlook.com (2603:10a6:20b:67c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 00:24:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 00:24:42 +0000
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
Thread-Index: AQHcSYDXkRjFYTA/aU2GC/wHEDze/bTa9nwAgACBd7CAALmQAIAAv5Sg
Date: Sat, 1 Nov 2025 00:24:42 +0000
Message-ID:
 <PAXPR04MB85101E443E1489D07927BCFE88F9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251030091538.581541-1-wei.fang@nxp.com>
 <f6db67ec-9eb0-4730-af18-31214afe2e09@lunn.ch>
 <PAXPR04MB8510744BB954BB245FA7A4A088F8A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <fef3dbdc-50e4-4388-a32e-b5ae9aaaed6d@lunn.ch>
In-Reply-To: <fef3dbdc-50e4-4388-a32e-b5ae9aaaed6d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS5PR04MB10017:EE_
x-ms-office365-filtering-correlation-id: 11088bde-bc82-431b-9c5b-08de18dd0d67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZjuhIzedrnk0ZVOFXMounAT6xzkjfvO+UNvgaR6HoEh3p7lzkj0ycxLN9aGv?=
 =?us-ascii?Q?G4r+y3NB9Noj1Jbbgqn7C5uR45dSHrMglPPK8IB4VwvgCLW3dJQ/DOQ0DB/m?=
 =?us-ascii?Q?9ll+0bpLuBMqKflG6wBOJFRBEn5JRdwXr1jHrG0SPOZlsxXcW0iLKCZPstLb?=
 =?us-ascii?Q?jOZZ+DTdeRn7VLyWT2qbZWDJU3QltObPhCAH25r0W65dCpVNLRDAwA1vjEM2?=
 =?us-ascii?Q?csM7is0nyhmGEvjgrBt7511gFph79IJU+m5SKipHLAj/+KPxFel+DB8DvQ9T?=
 =?us-ascii?Q?/l/7uROSt7xZ2R7EqyQlzIw78ORCHnQFvfaSO06ahq+06Cim4bb2Tey5tSmC?=
 =?us-ascii?Q?2Nfn8eDQm1G+Ar709G1nl64PFcmc23F7AZfYc45kizGDSDaCf7wKEX+ADDW9?=
 =?us-ascii?Q?Tvx6EPaXUARUNhpEyUpBWQ81E24WB/uZJjYpLJ1GHx6+ah6ebT54sfHHk2FY?=
 =?us-ascii?Q?oZHUB97NZdYV216GuD6iBTfPT3VscZucUUa4NGJGmOCUgIfVNl6BRIV9a8GL?=
 =?us-ascii?Q?cBVTxHyvREgnBB2Z6szCKFMbJSSgz4ZsI0duk3C3f762bJXed9CdqWPnLHJG?=
 =?us-ascii?Q?N1EMLuU9EVSd3CRuLMsSHoP/K3sLcfmwaXxfnVCxnQ8X74nwpx1+exZTFxCN?=
 =?us-ascii?Q?lvRCbpz3zfhzf1W3Li8Fc4a3EzTqdNxT432HgWaaWjKA8SrV2VXqJGPUu71y?=
 =?us-ascii?Q?YMAaKY9axUnxIODcVxO4L1l2ro8WiqNMDBsVCOoiYXfl6Qpd6ekrE/WM+Nl0?=
 =?us-ascii?Q?BMSNrh88wXXHZ19vOKGdzvAjDSrYIcebK5abYgB1nCUR8M+bkIUUfvRI/Mn+?=
 =?us-ascii?Q?UxJSk1MuHRuZxfZj+1DAbCM+skWZEtKqnmm1ZfySaBqVq7Eiqj+8v5KwKhJV?=
 =?us-ascii?Q?GWoQXRPfI2xeU2HcytqJlEMxk1H1veMHa1whlmHGDpVZMSpb+0sb0A/BwsRW?=
 =?us-ascii?Q?6PsH1ncWBFBxkF/eAOipXB4eMVJI2uL/qWG0WIqBpfOA171Jii43oLz1OAm2?=
 =?us-ascii?Q?vcGQ3npd2SOC5tVQbaKFQYlGalhBcIUQMjreC7PA3gd1ht8km9ssNmTDiy3x?=
 =?us-ascii?Q?Tz/GQ79n2Z/oE3oYZoe+F1Z3RrHVrPHrVOm9saV6xm9KOoxwZwvJja7vedx7?=
 =?us-ascii?Q?w18ZMPaqpORuk842yO6SAczwwVw6YDwAb4Q5z+QwLTiOqsp7bx2TCPAqGCB/?=
 =?us-ascii?Q?Q+/N0SwqgjFuu5ZxX7xJnsodheofqLbEDrcaQR8vme5o21pUWZqHktj38+/y?=
 =?us-ascii?Q?GyBYqVFho2wT4QfjmaHjSDcRkexhc4JaFknumcSphaG4Qw93k7BZRvJRTL3A?=
 =?us-ascii?Q?YKlMq5w4rB1eyPr5z6hD8APcJLsPgKYd4AtJNQstCaULxuUlNoqdzVvaiO0B?=
 =?us-ascii?Q?5YVrl4nalAsSsKHJ8DaFTsq7syimjZ/UvwounbPu5Kff9XEQTWAAkEJkOQHJ?=
 =?us-ascii?Q?LcyqkpjGgQyRN8zpZbE4RSmlDmYSDS8kJN9rtmzoJ9gUe37onZBqbaiSk0NP?=
 =?us-ascii?Q?w72YPZPE7YyniNhEP0IYnYYDNu8NQRHoJW9N?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KevaPGumBpiXDqIopJc/JguqZY3Wy8rGq0Q+4UJsiErBFuvtUH+nck3rpOK1?=
 =?us-ascii?Q?ycVxrP2hPBAhwALKLaHV2NePN4lwBJ38iIwZA2VoEiEd14lNjcFs1ESJ9xfz?=
 =?us-ascii?Q?omfjMwIslMiQIXl8BApWFR5joU2nHsW8Nj7wcZfqRHnieabcpHgmcem5A08Y?=
 =?us-ascii?Q?D9sYbOA9RK0f6ubw+Giy3guqQNJPaiz9h1JvweH4yf6GJgpac9HOx4qBjBjk?=
 =?us-ascii?Q?SCXnVW1gXZyBPVOw9p+sEH+l7siDQwFwC61dStVSdsr2DaURtZnrXS5ICfbO?=
 =?us-ascii?Q?PKVwuTeEw+9YPw1y7mR/bHEdWDXoMUkSxFSWWd1016mxRF4TZv+SVETrHHcD?=
 =?us-ascii?Q?a4uEtdHY3YJih0uU3dLfqkFDwNleyand5u0gfKYQzMky7I7+f2HnErc4FS7d?=
 =?us-ascii?Q?SI3DH0lRS8asOXQwEKfdJe9rDBUbwErXn3zLKPEVnRe6RdEL5yhAFd7XXi4H?=
 =?us-ascii?Q?+w4VMGtRixqVZlKT/ZAfLoSchWPj3S54D8WI5ycCCS0nAEknvMKD8bGo1zuA?=
 =?us-ascii?Q?m+oGkqEXu7uA1TLp7tPGmMuEVnNv4yVIu/enbUHPkEdi/flqWWWtwOP3A8vi?=
 =?us-ascii?Q?c7YZ7jplOGKhEd+BbHvfDcaCSf2MPWZ9UwP9P/G8TnT5+br2X3pB4NDpwwF4?=
 =?us-ascii?Q?A1xL7FuztNf6jQGZ0zd9TPiaYPn63JLjAGz3ittBmzuXwH49Be7auMaKbtLZ?=
 =?us-ascii?Q?kGkyT/iuTo/FR0sJEYohhy5Y9rVnPFg5qwU2+GDajBxD+QTHgxqKP91FRH9X?=
 =?us-ascii?Q?DBvfLTL8irJC1u+Vv0lsdBckpc2pz8WOIKw6e6s600xBoxBJlxhKLnmFiajf?=
 =?us-ascii?Q?mf9XU9EqlPMUUaDYRClS5IuiDk+ffh/sQyF/UGsngj4RFqIkTNwaMZMLMu5t?=
 =?us-ascii?Q?3LOoU3tbkeIC6S7bNVxNukc1D7MKqCE3imT1kcKajjnyFVpPPZdocCiMUCKp?=
 =?us-ascii?Q?49a5HpULmORNdwd22nvhmsa0gq3rt5uY/+b/nqdzqyhOdg6NwdoCDg7AIa9j?=
 =?us-ascii?Q?WaHsMCXmoDmwfBoPSKcPkUCIaID52fKYelNxfzIuOgzKsHjdojbclJIWsWpM?=
 =?us-ascii?Q?2SMYhjK3ObRBS8srQd/98WA1M10PHikChQzYeLjcYHOToZDaM8vCBxzM4JRi?=
 =?us-ascii?Q?jLF5urxAlir9l3TmiNXQDxUDszu7Rg163OgY0gC4bp/+KvaVpCLcQ4RE3DyV?=
 =?us-ascii?Q?Yso5Eaur84oIJdWto2hB0XuefWYhiRrHcIChrObo9BsVCcJK3HIKkp0tM09K?=
 =?us-ascii?Q?AhuAYf6K4K9jbAX5y59jhW37prIJOx8zMUcVdfu67cEVdIzl+4RWbaeaJsXh?=
 =?us-ascii?Q?HOt/ePoNUCLmKiETrvb4CoKLQs1z9fcqDe7Kj9NyU5DcARsP4JgrE0w3vZMO?=
 =?us-ascii?Q?Aar/v1QQQgCEQGr2+uCB1SLexc7D1OroW/uf/qvJfi190vteuOVZ198456mB?=
 =?us-ascii?Q?r+catp5ln8/lI5PHKicwqbBqK3ljxy0LvdonXXIYWuNR1bfO8sjYkG7fhT34?=
 =?us-ascii?Q?KaWfnFzgPPLn+4tgvZBHm9fDqswuem6nxDlaGglzZClUfCIcfxGNfUN1RCjV?=
 =?us-ascii?Q?+tuRUjVxYl7lMeKL6/g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11088bde-bc82-431b-9c5b-08de18dd0d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2025 00:24:42.4517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFZVkrYiySDzGY7AkCZQxsI9P2L5e0Ezd9fexWgO6X5xVTqkIcW/xM/EDBXtaL548hQMZ/oYDK+AFmoHuzSmTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10017

> > What we get from the DT is the external PHY address, just like the mdio
> > driver, this external PHY address based on the board, ENETC needs to
> > know its external PHY address so that its port MIDO can work properly.
>=20
> So i don't get this. MDIO is just a bus, two lines. It can have up to
> 32 devices on it. The bus master should not need to have any idea what
> devices are on it, it just twiddles the lines as requested.
>=20
> Why does it need to know the external PHY address? In general, the
> only thing which needs to know the PHY address is phylib.
>=20

From the hardware perspective, NETC IP has only one external master MDIO
interface (eMDIO) for managing external PHYs. The 'EMDIO function' and the
ENETC port MDIO are all virtual ports of the eMDIO.

The difference is that 'EMDIO function' is a 'global port', it can access a=
nd
control all the PHYs on the eMDIO, so it provides a means for different
software modules to share a single set of MDIO signals to access their PHYs=
.

But for ENETC port MDIO, each ENETC can access its set of registers to
initiate accesses on the MDIO and the eMDIO arbitrates between them,
completing one access before proceeding with the next. It is required that
each ENETC port MDIO has exclusive access and control of its PHY. That is
why we need to set the external PHY address for ENETCs, so that its port
MDIO can only access its PHY. If the PHY address accessed by the port
MDIO is different from the preset PHY address, the MDIO access will be
invalid.

Normally, all ENETCs use the interfaces provided by the 'EMDIO function'
to access their PHYs, provided that the ENETC and EMDIO are on the same
OS. If an ENETC is assigned to a guest OS, it will not be able to use the
interfaces provided by EMDIO, so it must uses its port MDIO to access and
manage its PHY.


