Return-Path: <netdev+bounces-234925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F455C29D82
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 03:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30ABA3AF788
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 02:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FD628031C;
	Mon,  3 Nov 2025 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JveC5ruZ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011010.outbound.protection.outlook.com [52.101.70.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59E27587E;
	Mon,  3 Nov 2025 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762135885; cv=fail; b=qWwTMnFqQfYZU9J9pSBrzxVBzKb4G2MlJkzxROOER/Nzxur/FGDYyyWo2PeGM/ehSbXAXb4I8S+GzIp2WcSxotGSOb4gqijAIkj2dopBwwPTftAqdQOyLPb7xK9K1J6GMOd75jO1RWTvw64eidmny9D969aDg5AIJI19TVyIL40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762135885; c=relaxed/simple;
	bh=iAw9k3lZinP9Zp/LEoRkQdCwVLrdVomOudqiM2K6i8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MaMBUy+GwOxpyHX55Q5HPQps55SpqAw9sDc6x0UdiUpkO7DqQIG3S4xCBjYCHMs2vSGuKnAWY47jDvcOpK07KTgUN2/mlFmhJ8j13IgXBQ/poPm/vvXbdpRw3aJpHTHTGvNtiDelk2vP0cuoyNTGpnfabKDlURt0WWcD7qsR9nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JveC5ruZ; arc=fail smtp.client-ip=52.101.70.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nbd+1ZUyzE2tDfv1iCmNFvWHp39c/JTX2CEXB7EW6nZdCff4W+qbGV+/+SHA4YXyU5ty8dX3w0NyCCrFCh/egXo94wAuxnRWFqnW8QX+LlAyUoXewA/3I1UqP+3aP1ZKlhNSdmjEIbZNl8l0xCTxbhtQexgVONNPGlqD8OZfV3Yjvm0IS/WkK15kLvcMXSILxhowHa7Y4rSwaR3ews+QO+J+ynxNW5GWYrM2HCjxK42yKOyceoMQJqYGs7XLh4XWdvw8HUs7vru1jx+yMKMccvGqZVW4u0J4OZ/8g2chRnicTOUL8qEQHbIIQEhAfk/6GTwKmBhoZDVvIDWAVIxwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAw9k3lZinP9Zp/LEoRkQdCwVLrdVomOudqiM2K6i8w=;
 b=ol9GJcJLOqgb1Fext4KqXik1Etp9MTsPqV4z2OuHcjVnkaU/No56QYj7MLyiO8Sfk6wkWTyp4m+kZerXxBZZX/Og7nfFobECFKaE6GSDnLfHmbzRav6X0dpLdMuvGLKtjThL+QEgg+XXECUvZDYcfmGzfEWvl4s470PK4zjzxIUZMflGMgKyfFTpbFiWwiPTGlndaqS8L4izPccP9fcw2EkrlpPAMzbTyP3QfFCGvJZ7Lvp3sNpRgz2ZD+iXlo2kvQ4NL68um+vxeMbM9eTNzFHBxONUmjF54UqMhZ3bOCMY8tVwmQjFWhSTLDc/RFI98W/fsZIwmf5MmerBXKX4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAw9k3lZinP9Zp/LEoRkQdCwVLrdVomOudqiM2K6i8w=;
 b=JveC5ruZ9VavxppH6Pw7grHcBiQ3qBmHh679S5oYJppbJmTFxDaGcKGPvsOp/S1FGi98EIfMqhDMHIf+mj+XPEiN8Bb2QDdlKm3fMPTAb8bW+XYnmc2zSiZ4V3wMvF55xM+3J+GM6uJ2WFt5OJsOQMSiCUVpsnKcCxZteZesSR4FdOOxrNUsSj724IcI2B23QxsoKOqD9MgUObEBUidWNYHm+IX2Az+sVZBoBKtqySaVbLS77YIRguta2wFQR/+z2D0QJeNFDzy4DBU/fVR4sJdCeFC+gUbuMzOdOZIjAdva/gSpO7VjWI04FhCJVlOGhE5ud9H/PpsrUtvquhm6Rw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7406.eurprd04.prod.outlook.com (2603:10a6:800:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 02:11:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 02:11:20 +0000
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
Thread-Index:
 AQHcSYDXkRjFYTA/aU2GC/wHEDze/bTa9nwAgACBd7CAALmQAIAAv5SggAD3rACAAkwcQA==
Date: Mon, 3 Nov 2025 02:11:19 +0000
Message-ID:
 <PAXPR04MB8510D431ACAF445F8E516A0288C7A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251030091538.581541-1-wei.fang@nxp.com>
 <f6db67ec-9eb0-4730-af18-31214afe2e09@lunn.ch>
 <PAXPR04MB8510744BB954BB245FA7A4A088F8A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <fef3dbdc-50e4-4388-a32e-b5ae9aaaed6d@lunn.ch>
 <PAXPR04MB85101E443E1489D07927BCFE88F9A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <157cf60d-5fc2-4da0-be71-3c495e018c3d@lunn.ch>
In-Reply-To: <157cf60d-5fc2-4da0-be71-3c495e018c3d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VE1PR04MB7406:EE_
x-ms-office365-filtering-correlation-id: 977c8239-47b2-4db1-de7c-08de1a7e476d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NJ9XQmmTWHnbEsFp6tCSjP8Pi1dlhwdOMydo6ky6nHrZkdWrVAKbicW0hUGn?=
 =?us-ascii?Q?z6gfk/r1xxMDpubZGZULsV7bVRVGBsc9fh9PdDqB8pF20gFUNA7H88wI0kbp?=
 =?us-ascii?Q?3c3NmezcIdZqhDljc2vEbtfPdcM04PNkKYooGph62aReas51QEcCfDPWqmXB?=
 =?us-ascii?Q?KhVPzf0hN1Arypy1utSwK+g3giYYtm1eLS76BFvcOVKs/iS05q65I6gZYFYd?=
 =?us-ascii?Q?mHIrqizN3u5iGI+LNvFFyZSqMN+Vi6W8TBoeCEtLpY3HEB125ngHIVQz2QRN?=
 =?us-ascii?Q?DsWUGGYTK326IrKx6yemPbwoOFgQ9/7+g5dCD4+6T/BfQthxAg9iTeIu4AFX?=
 =?us-ascii?Q?SmarMlLRp9sja6S/EGaaYdfaB/CfTCzjAEd6AyFZhAPz8UMQzlnCcw8T6Qsr?=
 =?us-ascii?Q?nByUq2gutQI76yLbSsgffXkO9yKPYFY6Zay7tO5NL5wotdRS98tKTImJFMqu?=
 =?us-ascii?Q?xuTKBhDbmPN091dA+u26JX0eR7NR0MF6kOak8DIDRLCR4PShlLS82toe0kZ8?=
 =?us-ascii?Q?+pXe4cRgHrosgWpQ8vL28ZSEdtSokuPZssbT48m6OYfFxjMm71lWRSLkZOxZ?=
 =?us-ascii?Q?tRSeAyiPMC9IQHIlzDNvclC4HLfPV7pdSzr5o8Zb/yj0WtXcJ0gp2Sq9u1K7?=
 =?us-ascii?Q?cSb7seZnMgv1U9yMcDMfk+0BvgN50Pg95Gg78IqyWxi56oOrwgW5GA5kEYbb?=
 =?us-ascii?Q?35qEPP7sW2tq6WWnKbs9twu62karf/QV+nXdgcjMsfaWQIxSdwnpz7ceFLY8?=
 =?us-ascii?Q?BByeH0i7ISnyOE5VJydI8tFQIegVxeHn1FOgKcWTPumm7HdwNfBJuZI0PqK9?=
 =?us-ascii?Q?xNdh4RrDIbUX/D9FeT7/5yac+VX+bwOrpNiDIsH/LNMgbOPal8uAhBba3bxi?=
 =?us-ascii?Q?SKDlr+eW+/UEjlg1Yw+hGA0sEV1kN4XlOJ0xG7F1Za2USpk90y1oDMsbR01g?=
 =?us-ascii?Q?JzO+qv2/LHs/qgVbndJcQTfDa2qHH3DEat2VeX9+uEycMsxaVxe3xU0mMA3Z?=
 =?us-ascii?Q?NCO6Mn2SHr1T96Gq4hFF182w4yklw6FulOCNw86EmX7y1+tXeNHxN2UIjARD?=
 =?us-ascii?Q?n+y7IudUGb0dW09bzGcMZKtB91dUU5ADyBvEdVTDFVE9mD+2RLfPGo6iAny3?=
 =?us-ascii?Q?A7gBErFUQgjV8cQm/RR/sWf6O8N1qi7BuT/fJnK9vqhlHwdXuJyvn9t9Yy5K?=
 =?us-ascii?Q?HjaTvhAFiuFO9arJjaCtzHXayCLAoou1ha2I7idBH6uuzvVmInpNiPERZqp8?=
 =?us-ascii?Q?DnhuPya7yPYR5g1OqBLXkRGZFnddIYwTLYNJPfykU2XrfjWkfrTVarEBYOxQ?=
 =?us-ascii?Q?LTlozoUA8paFi+cIbSHcFysbOtKPxV89dq/ODEgQauc7iyO1oUbt9nqfnnmE?=
 =?us-ascii?Q?tHLI3D2+/WvymQvbHGp9GdjFsCZ7aoxft7eTwrZdxAd216ihYKnmvvlgjuDY?=
 =?us-ascii?Q?tspFWKTUkE3O/XXzEZMbo9pep9b777v58mZmETiSDcjYz941OC8ZZzQfax0Z?=
 =?us-ascii?Q?GUZHD9VW/hO0cc/2jt0yBO8HTN4KksieLna0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ob0CYKeuj/5DMvj/+nANhrz/9jX+wWt5a6IahrDdOLmL6GhjFOY46zdky1Yx?=
 =?us-ascii?Q?jwkxw2/f2kCfqPgYvxnHM9thCSEPT7xyWVntU5r9b1duH8lGY/mS/iwVrQg3?=
 =?us-ascii?Q?/Pgr6240Nqe4xQYn7Y2MF4Md9uT6lRmSWSZVCJ+MzIACLDgAA91Hn+5qD/7p?=
 =?us-ascii?Q?XcwlNlKHWD8d6t+WmOWspDr+OOwx64L2B3gWE9NaTxuK1m/Ugy72e85TAovW?=
 =?us-ascii?Q?LxWaoHJ+axeOzn+4PoggYuav1vGvolU91JU0okdFWKkmEDMENIDcW/pPSRMo?=
 =?us-ascii?Q?WMQ2X9ZmJi9/9tt8kxujPwIn+eTuvDCfRmaMVXR+hNX8XBhulL6IKmFjBbxX?=
 =?us-ascii?Q?xzagt9qty+HWV1DV3Kl/Fw0qPuOVdbmXJd456czNEUCi+UUu+Od2HJHTQzvO?=
 =?us-ascii?Q?gOLL5+r9An+U5VenQcmMWjyp3FFuG7L0ExHfblIut0jq3d6Od1piYqaEZI9r?=
 =?us-ascii?Q?x44l2O4amyxJDFIQ+BUEzJT2qeTVyxr4Z6ytIjmw6rFq6rzEoKnnpeJugbQP?=
 =?us-ascii?Q?denIxJYhjaOekRwZ68ZktU2ImKXQqIMmqsDSGTPzRccWT5SZt1VA3JJB6+r2?=
 =?us-ascii?Q?K5vES/zxvrbvWAB905ULuuTC3ptYiDpmNdAGJTg06HOuLELzGDpPYFw7IbcT?=
 =?us-ascii?Q?HYxgbVcVy6olZP5BnVVCjfLPRW+sHJ5H6wyNQSysD0EZ9UyLHBze7Hw280PL?=
 =?us-ascii?Q?60chH+1cLzsVMJ1dM5VRvoH8/1TpMPe1qk3xJPjzVNzZE9if64ggywyfgd98?=
 =?us-ascii?Q?oUt3CQLKKWVCEzhsLcJUP1HjTEWGaWB53kAdYT8/5hTiQCrDPf5ZfYq3s3bv?=
 =?us-ascii?Q?F1GgMN0/W+OLQrmzHkf0A5C2QA5LIidUbD4sgXfdldexaF7R7jiJhRohnn9B?=
 =?us-ascii?Q?y8CRu6+NK39eUn9i7XcacfG0JQcC1FL5x8/BfdMYjqZ1uWZGqCCwGStmL36b?=
 =?us-ascii?Q?jaiOJHKjz+BHh4kONVvW6FGcr5UL/73486Wq/wPN+2OXTggkgT+f9AySpBAG?=
 =?us-ascii?Q?IOLxQPW4qXBbMX5EIl/HK4hZ2muPUvI0dS5APU4e9HZ2dE3B7JQWm4p71ayZ?=
 =?us-ascii?Q?q1+TUcrk8WyZ8Rw3HyvmhH37Q0+6rjTqHcgwXl8U9FvZvNLfSjFlNYLIoSOI?=
 =?us-ascii?Q?oUQMGJgMwbhw5zXOkznql9Vz5ZfCr67egEhaj1O9AN/VhzzBL5s19qtVbm/0?=
 =?us-ascii?Q?6udmBKF4zpREGLmZ86M6BFDNZIlKjpB+4G5cophLV3pcsm94eelC+rzJt1qU?=
 =?us-ascii?Q?ehYba2bciGvdgrkvgGF9GbBLH8wALWSpPfG61Vw3ZEdKvBEwaICq/CrpbhuB?=
 =?us-ascii?Q?hIpy6aPkw9ZzeoKPNDnGt8b4/rSQzMW6NRLAZaC9zpAhVwmRUjtksOj15coJ?=
 =?us-ascii?Q?X+XJHDjhVBdyQ0SvrTTfkA8ifySBFqv4DaaWu8Cxsf+Z02DJuyVCUTr+PWor?=
 =?us-ascii?Q?Cob2GSL+NAtJzafq7qacDqgNMb0kHnGWWyLrCaAvaErfCW6H2FjQo+BYNu8X?=
 =?us-ascii?Q?PEW+JEZ7xqEh1DkSmyXfUVFQ15tvYWEcyG95ymi7/zbJs0Bx4EKj89WPBtzy?=
 =?us-ascii?Q?m0ioI6AD31M+yy2PJp4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 977c8239-47b2-4db1-de7c-08de1a7e476d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 02:11:19.9608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hww0ThbxwzQKYgisvUVpcdlIwfUsRYG/9EVC9LUQjeOp2Xv7RwVIi6E/hFaVKnO9wmn4D6xB9jgdhRlMlUUoQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7406

> > > > What we get from the DT is the external PHY address, just like the =
mdio
> > > > driver, this external PHY address based on the board, ENETC needs t=
o
> > > > know its external PHY address so that its port MIDO can work proper=
ly.
> > >
> > > So i don't get this. MDIO is just a bus, two lines. It can have up to
> > > 32 devices on it. The bus master should not need to have any idea wha=
t
> > > devices are on it, it just twiddles the lines as requested.
> > >
> > > Why does it need to know the external PHY address? In general, the
> > > only thing which needs to know the PHY address is phylib.
> > >
> >
> > >From the hardware perspective, NETC IP has only one external master MD=
IO
> > interface (eMDIO) for managing external PHYs. The 'EMDIO function' and =
the
> > ENETC port MDIO are all virtual ports of the eMDIO.
> >
> > The difference is that 'EMDIO function' is a 'global port', it can acce=
ss and
> > control all the PHYs on the eMDIO, so it provides a means for different
> > software modules to share a single set of MDIO signals to access their =
PHYs.
> >
> > But for ENETC port MDIO, each ENETC can access its set of registers to
> > initiate accesses on the MDIO and the eMDIO arbitrates between them,
> > completing one access before proceeding with the next. It is required t=
hat
> > each ENETC port MDIO has exclusive access and control of its PHY. That =
is
> > why we need to set the external PHY address for ENETCs, so that its por=
t
> > MDIO can only access its PHY. If the PHY address accessed by the port
> > MDIO is different from the preset PHY address, the MDIO access will be
> > invalid.
> >
> > Normally, all ENETCs use the interfaces provided by the 'EMDIO function=
'
> > to access their PHYs, provided that the ENETC and EMDIO are on the same
> > OS. If an ENETC is assigned to a guest OS, it will not be able to use t=
he
> > interfaces provided by EMDIO, so it must uses its port MDIO to access a=
nd
> > manage its PHY.
>=20
> So you have up to 32 virtual MDIO busses stacked on top of one

Theoretically, there are up to 33 virtual MDIO buses, 32 port MDIO +
1 'EMDIO function'. The EMDIO function can access all the PHYs on
the physical MDUO bus.

> physical MDIO bus. When creating the virtual MDIO bus, you need to
> tell it what address it should allow through and which it should
> block?
>=20

Correct, ENETC can only access its own PHY when using its port MDIO.

> If what i'm saying is correct, please make the commit message a lot
> easier to understand.
>=20

Okay, I will improve the commit message.

> But this is still broken. Linux has no restrictions on the number of
> PHYs on an MDIO bus. It also does not limit the MDIO bus to only
> PHYs. It could be an Ethernet switch on the bus, using a number of
> addresses on the bus. So its not an address you need to program into
> the virtual MDIO bus, it is a bitmap of addresses.
>=20

No, as I aforementioned, the 'EMDIO function' can access all the PHYs
on the physical MDIO bus, so for a third-party switch, we can use the
EMDIO function to manage all the PHYs of the switch. Of course, this
requires that both the EMDIO function and switch be controlled by the
same OS.

For NETC switch, each switch user port also has its port MDIO, the switch
can use port MDIO or the EMDIO function to manage its PHYs.


