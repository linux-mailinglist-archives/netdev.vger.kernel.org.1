Return-Path: <netdev+bounces-215092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6A6B2D186
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0971BC8038
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDB4260587;
	Wed, 20 Aug 2025 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xtu9Raw1"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673925C833;
	Wed, 20 Aug 2025 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755654246; cv=fail; b=pxsnyumrzn3EH9qe3knhLaxAqwoaL2Ifc7Iuej0wp+P4Y0Cp+OcJfzh/WWt29hQxzqyXXiKlWErC1BtSbMJRod3bPrO0lUOmB50RhXUyAx3oDEx8ZMjNHe3i2kymtwgFmy6xWiHJiGhJBgXVNERZVrb1j56ATqlMIUdJD5CfZa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755654246; c=relaxed/simple;
	bh=8F+XqpKJdJZs37T0gQgI7wIY6BCZoZdGpsC9kKI8XEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=edyrfbXcGrORexRL6jsfMski1JXI/N55SDpuqR4Dt++0+dOcmVrRaXh9UNKbHU2Mgmuc5bmS/Zs9hTeKm/xAr6g38Olwg82zTnK1+Ugec1vhieSMO9EpJewiAvnzDe5oeWW1B41btAu+7zeXIo1seksKhZe2dD+NI3XHOwVlOMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xtu9Raw1; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjlYbzpidY/qoG4HjqSZfWafWogWUShS92wsGnnQpVaMHg65KIevzhQ3rUT/w1HQIZF+YVZNngcL66TFOJgkHpakIwVudtLJ5CVD9ZMOEPd4Ht5E6/xGzptdB2P4dAnrWjG494ArmlNbECJVmbs23rcKnorhPB6PWAUyjfoUjQGH5Oq4vExs1khgN/puZo/SAOmKSfedW6KLzcixtMUGOp+ai6aH3diup9abRGPJTww3eYZMQYolLCmCHYOusBTheB4OrD82s53szN0dnAGOvwFKUUtogZAl0PCrr3vtqmNJv/GGX1RF7YylT35dbV9wmFBzIJcdj+SQKY8wR0MxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCluMsrxU+zN0Fq3gXmi5nXiKqRmp89calBfjD45Yr0=;
 b=ZrIp59gZ0ALkAfx1ByPNMkEi3hw/dW/+MyninM6x0nqm5r1THEHzxceKqAAo53PAPdMog9zg5Hh9NQcuVUGgNa86OgVFrqPNtFOi6qcQmfQ+rrpM0kfwnQVAugBgHd+a7YUNFFyrS7XDm6qqtpBiuzxUIDJikYw5PBetp9EkGLYGt8PMbm9wYuUhxnUroj2lGyawydwEMvlX2I8D+co2v/kvkujrg+lhAxRvQ6ROZP0+vIj6xezaUOPGxdEYzAjcq0NZU9VnPGTOSaUYkmkzdl3B36cT8jCWPK1BClT2IUcUpi6wsJCIJrY2tFKzmMESKBl7sLX0m6kV/K0v9mHmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCluMsrxU+zN0Fq3gXmi5nXiKqRmp89calBfjD45Yr0=;
 b=Xtu9Raw12af0BBRVk/Vu5YooXZ8S6b2p+Ccio9xWPAQ8Ci3Fl3AudX73coRAouGS7bnmAAP+BIF0m7SRefyL6GbtsFiD66dpMxyrH9H2YOXaZGFuM+wRtAObwvsI/3sTj9+kZ11MIUsXn4koynqO8d3nihvzzQNLFnGz/ofhSABPJZmFo4dH5ZjBoOCzEmpLT/0wuUEwbyl2tblxcB3kcB+GdTqeMNz1jNBy7hK6+svp9QU8DJElYF+RBXi/Hsb1Kzk48Nh1hIsNRqMJvCLDm9R3+LLKBFSVDh+FtgjfjbnmrxgPMKiZ7wwVloo+SqPKtg78/wBuSc64o5IRf8lM8w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8620.eurprd04.prod.outlook.com (2603:10a6:20b:43b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 01:44:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Wed, 20 Aug 2025
 01:44:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
CC: "F.S. Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
Subject: RE: [PATCH v4 net-next 04/15] ptp: netc: add NETC V4 Timer PTP driver
 support
Thread-Topic: [PATCH v4 net-next 04/15] ptp: netc: add NETC V4 Timer PTP
 driver support
Thread-Index: AQHcEQj5CQ+mJcoNQkmqvF9R3wJl/7RqH0yAgAClNrA=
Date: Wed, 20 Aug 2025 01:44:00 +0000
Message-ID:
 <PAXPR04MB8510085298FE3B1839EF486A8833A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-5-wei.fang@nxp.com>
 <41651550-4e63-4699-b10f-ba2e8cfbc0a3@linux.dev>
In-Reply-To: <41651550-4e63-4699-b10f-ba2e8cfbc0a3@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8620:EE_
x-ms-office365-filtering-correlation-id: dd0e9615-0a02-43ad-8a7a-08dddf8b0924
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?U8LXd6C2JSD3v83kUJlbz47Cw39hghbSs6G1cPOlKtex9AY5i6S8T/0pwr/z?=
 =?us-ascii?Q?cYXjiKy/P2Xt2Rt1zMAySrtt0Si29Dl/uA0u+fbz9soW2nsjbPskB3HiVc8U?=
 =?us-ascii?Q?m6fimmOZefP/F5GnjzTtC1CQ9SP3frUwm8KAosVyMTwyXo/IpDNuLppRkss7?=
 =?us-ascii?Q?89C2JGmJDvd+Xmjo7MjkLXA716I9FUVJowPW2oTDEZTDkL2UP2OHyaItOcoy?=
 =?us-ascii?Q?fyDiXEkwqPWyVywCyBGUKNxN7kc41FTEPAs9nH+FOy/ll++0ayP7IkWJQJeS?=
 =?us-ascii?Q?t6Kz+soQElY28DzaJRuAGfTsxo3JeJT4jKh+XA9Qb/WyZ2tKvjw9jW4/BE6W?=
 =?us-ascii?Q?X38c3lMwzL67kRo90ZRSnC4M7eAsVeH73/fzdizSl/CjwLcmeKWilTMuawuI?=
 =?us-ascii?Q?yjGiKLARdZtQGZa3CiBL0PxxwI47uO576U6XhAgkBY8H+cdVPXrwCv9+TiF/?=
 =?us-ascii?Q?JS4G6I2XSY2kj1YoyBQjalZDi9lxAOwa5jMVq5xdfpSHgD2x+OzqVCZRJU1I?=
 =?us-ascii?Q?a6GpD4N+ndIfApecoO+bmSLfOMf8qqbLMKMkCPPrxt1IF6myQFQQ0Sh8Dz/u?=
 =?us-ascii?Q?HvX5FxXf6aVBeCJ1vdov7BBpHCpamalYB0HvNgQVn4SVrEfooYrEwQSicaJE?=
 =?us-ascii?Q?jFlaa5eVSjErFYVJu4QLXppSa1zLJLBXcPWs8CTpN/EVG7cVbWUpukUZQt3K?=
 =?us-ascii?Q?v7oL0Zt16PGVyJ1FDhxbnEiISOVPYEzALM4JAYpglN1H9+Ev5fAznnYpwlpy?=
 =?us-ascii?Q?2/d9alQCb325DcrVdLGtz2rX0V+ah5H2xL1i4+8et3W4vwTf5N/uiTvCpZOh?=
 =?us-ascii?Q?RtjAx98uaNTziNkyzijNNOLHFyz0KSta2zsp7OUlvPmQTdCUbF6dH41wYB+9?=
 =?us-ascii?Q?TiPaANjpkfRdA2BXvWiGxlyJWxb7V8eeGYeCTKApzvYq8n8iUteXQisMHbWh?=
 =?us-ascii?Q?+nWyt33PDYT6688+hOKYL3A85uu0jfIWpUHX+CAeAJxDiCnukEoMhffVZ2h3?=
 =?us-ascii?Q?mDCp85Tcupa6BTRs33Ys+dr3PqbCmRKaUMMoxFtExFQz39rGU5oHXkR8MdoU?=
 =?us-ascii?Q?37rx86vTHHpRWKtJRYkELJqPJ/71ibp6Gvo2lnm/BvxNWkdUOsgSnaFxtssY?=
 =?us-ascii?Q?PQ5wVrLKgHMu6S9iEGQfDJVNB7eD0609vEMRbvzAdSP/3dolKDWumRRsZDsi?=
 =?us-ascii?Q?shHW3VjFLW4kxipVwkMDxFzx4+CSAV218F2MfURWPuDOMsAsjcBM7eXCUUbq?=
 =?us-ascii?Q?OgAhIJMNEm4n/ylzoEScegkVWSYpDJ2GqTCgClyqk1imvcXB+s6KQoFyR1jj?=
 =?us-ascii?Q?tHFKlP1uJPzgcqHCfdVjZEkQvdxWdTKAcdizYkQ+LeslGMe8/y8WKats7Obt?=
 =?us-ascii?Q?vgRIm071ZZ5KqfwWLn8gnpjwR7uSjYGvEzw7AOuhpskmsTbY/RJ7G7exiQ8W?=
 =?us-ascii?Q?TjJexp8u9p5rJNN8Z3D9HtGgh5Sh+QS+G4aibRQNmHWd4/SLBRxUoTLUvj4G?=
 =?us-ascii?Q?E7g1+VG2LqWPzeo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gbvDb1xzwwbYqj3Fn2ipDMnRoCLPTuG12TwLhqOBearTP2wO075M0PDa7HQQ?=
 =?us-ascii?Q?J8d6DBb9c2hG2fug0g4ZzEifo5Ve5iB4yLx9aAE0LmS9xu/AQSqNf0rh3BvM?=
 =?us-ascii?Q?x4OHlKvRSW+Cls/gkpm3YfCk7VoRJIfFVlrKG2A8WucI+JhiPNN0t7FYY5Fb?=
 =?us-ascii?Q?X5T//7o+/xXHkMe/JWZTEuAqRY+5FTXkwo5nxx1xKdS6zsRwBR5F+dMHmnc9?=
 =?us-ascii?Q?+oycBaOR7cgDNTF3VHX7RWhzrOjU8J2h4FOpErSXXPOptmcrywD8GEZfy4Li?=
 =?us-ascii?Q?HSmLK7cD7lc13puf/cVWm8NNAScdQIfP/FVG6Veki7inwRQ6jZzBMWIahgtj?=
 =?us-ascii?Q?AB+dNdoRdy9DPjmZJ+JIE6xxOq8E6OWn0TYP+Vpl0XOVLwV6RIxmf7FtA60r?=
 =?us-ascii?Q?yP9uYsQGz/STfr+cOOK6tjBTpqxucCSOGt4u7BuHLfclUsHP64usA+sOn9FL?=
 =?us-ascii?Q?ugoej78ypBnMir5cUlpAYvTSSIhdjxLBUNsbyDeJbzhoeapzHizMxXRSOVV7?=
 =?us-ascii?Q?YljBiWITuUVQTBAS6Q81OtcrUCcodkEAoE+U5WErjFnYX/rVISmCmhU0hgBS?=
 =?us-ascii?Q?B9gPUzInSwSpKf4pOrELhOKTHLR0f2jDggVJbzyf0O+bzqcRAscKY650GQlZ?=
 =?us-ascii?Q?gUFEme6ZBBsbInyfkcN9LoJwthzq2dkxv6WNRsrSfSau5eU5NSsn0U/dKxVd?=
 =?us-ascii?Q?xLwVR9ODSz2oM7d9qHVgAqkltDu6svgqoEyBLkQWEeOSsLyBowZ4k/omXyjc?=
 =?us-ascii?Q?Ibkn9npkSlLH6266Ci+Vunpbn9ELimnSDDG27AHTvFBPj+KpGRzIl4MgglPz?=
 =?us-ascii?Q?NX2UFxmGGYS9mxIdpgYqIkg+Pw1/kIm43sACUc8Og49kP3tgZ/rS5akHCRfq?=
 =?us-ascii?Q?gtCvU2niR0wH8C0SX7ZmgKK8P9bUnAUeOfEgTPCVevKgov5pYtzUqFEvwYKK?=
 =?us-ascii?Q?Z6WphEcgkZk5WB/38eVlyyDeMn7SxSGL1eBSMcwij1oblNZZGdceyOArhMg9?=
 =?us-ascii?Q?rkFU6VnI5vQFqR/A7oLOBnU1Mgrm7TrCI8AQQr+s1HQ1JjT/lEg133+z11W0?=
 =?us-ascii?Q?m6OFwmoGI6KrcBF+xD18WhncLDppd9XN44dSt4WwC/lLsoL6+oTr070uDOZF?=
 =?us-ascii?Q?g7fji9NNTXndA0P2EbxB5XP+la+Ow+3U1z9E5MlT24kPrzcBokMWv94QhVfv?=
 =?us-ascii?Q?AViTc/Jnd4OLz7Tnp5gW5IL1+Ta6y/PEKVJiOzw1wc4GhHK39xW8JBxuz6Qw?=
 =?us-ascii?Q?tWrnbWDIwX5QKAov94EuU4yzcFDpFLt7DnQMhFj4JHl5e5DskyphOF3CoUhO?=
 =?us-ascii?Q?OQetcGgy58wzOSITSjp2We/twen/BRw/M6+bUmZMHppr/GBW45MyLO1gEW4L?=
 =?us-ascii?Q?sYI138+eT5xdpniz9kPXJFKN9o/uSEHBzX0VqmSN7EukE9rrgStDxWxGl9Hh?=
 =?us-ascii?Q?SouaUAY97YcrB0QmjAL1OS0YzIHZv0btm6swCMlOpJoOdKjFGCtjmgekBLuT?=
 =?us-ascii?Q?kkTWOU7jcb4xZfOtnVnQ5fAALGYIEM7rirANYFDqMlS0nSHR15PXgHgp4lqQ?=
 =?us-ascii?Q?A5vlJpBsgg0C25On2t4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0e9615-0a02-43ad-8a7a-08dddf8b0924
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 01:44:00.3247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5YJhRdz3IxPNaKdfFClyibSUDF3RpROAEp/XYUlpBfwbDSSVnOzaQOlxlUF4MamyV0KuY228Xdf29nPYVzHglg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8620

> On 19/08/2025 13:36, Wei Fang wrote:
> > NETC V4 Timer provides current time with nanosecond resolution, precise
> > periodic pulse, pulse on timeout (alarm), and time capture on external
> > pulse support. And it supports time synchronization as required for
> > IEEE 1588 and IEEE 802.1AS-2020.
> >
> > Inside NETC, ENETC can capture the timestamp of the sent/received packe=
t
> > through the PHC provided by the Timer and record it on the Tx/Rx BD. An=
d
> > through the relevant PHC interfaces provided by the driver, the enetc V=
4
> > driver can support PTP time synchronization.
> >
> > In addition, NETC V4 Timer is similar to the QorIQ 1588 timer, but it i=
s
> > not exactly the same. The current ptp-qoriq driver is not compatible wi=
th
> > NETC V4 Timer, most of the code cannot be reused, see below reasons.
> >
> > 1. The architecture of ptp-qoriq driver makes the register offset fixed=
,
> > however, the offsets of all the high registers and low registers of V4
> > are swapped, and V4 also adds some new registers. so extending ptp-qori=
q
> > to make it compatible with V4 Timer is tantamount to completely rewriti=
ng
> > ptp-qoriq driver.
> >
> > 2. The usage of some functions is somewhat different from QorIQ timer,
> > such as the setting of TCLK_PERIOD and TMR_ADD, the logic of configurin=
g
> > PPS, etc., so making the driver compatible with V4 Timer will undoubted=
ly
> > increase the complexity of the code and reduce readability.
> >
> > 3. QorIQ is an expired brand. It is difficult for us to verify whether
> > it works stably on the QorIQ platforms if we refactor the driver, and
> > this will make maintenance difficult, so refactoring the driver obvious=
ly
> > does not bring any benefits.
> >
> > Therefore, add this new driver for NETC V4 Timer. Note that the missing
> > features like PEROUT, PPS and EXTTS will be added in subsequent patches=
.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> [...]
>=20
> >   drivers/ptp/Kconfig             |  11 +
> >   drivers/ptp/Makefile            |   1 +
> >   drivers/ptp/ptp_netc.c          | 416
> ++++++++++++++++++++++++++++++++
> >   include/linux/fsl/netc_global.h |   3 +-
> >   4 files changed, 430 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/ptp/ptp_netc.c
>=20
> [...]
>=20
> > diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_g=
lobal.h
> > index fdecca8c90f0..763b38e05d7d 100644
> > --- a/include/linux/fsl/netc_global.h
> > +++ b/include/linux/fsl/netc_global.h
> > @@ -1,10 +1,11 @@
> >   /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> > -/* Copyright 2024 NXP
> > +/* Copyright 2024-2025 NXP
> >    */
> >   #ifndef __NETC_GLOBAL_H
> >   #define __NETC_GLOBAL_H
> >
> >   #include <linux/io.h>
> > +#include <linux/pci.h>
>=20
> What is the reason to include it header file? You need PCI functions
> only in ptp_netc.c, but this header is also included in a couple of
> other files (netc_blk_ctrl.c, ntmp.c).
>=20

oh, my bad, so sorry. I added netc_timer_get_phc_index() to the
header file before, and I removed it since v4, but I forget to remove
the pci.h. Thanks for catching this issue.

> >
> >   static inline u32 netc_read(void __iomem *reg)
> >   {
>=20
>=20


