Return-Path: <netdev+bounces-207766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45FCB087EF
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CB33AB166
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA7C27A931;
	Thu, 17 Jul 2025 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d+vZ+0PD"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011052.outbound.protection.outlook.com [40.107.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48E1FAC4E;
	Thu, 17 Jul 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741021; cv=fail; b=W/xDsToI7csdgr1Rf/c8Rf6Vbvymrw9b1VgrDXUx0L3LqkhvkRcucnIftWOaCcMQND6ORht2K6LMp5ZGFAEq2coP0KYTQx1kjaekBELPvxU7JsgfEonJr2s71VxFQlsjz1NNWwbHVkxpUJOQDtzxpODztEFkgIG/yP3/kqVR6QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741021; c=relaxed/simple;
	bh=gQ8UfW+w0AnMHoUGBBTw7tpLpV9jHzbSTGJTBZhlhVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tqLwehB78lq5gbuz8StrxovK4wR4dgrHU0tr0+UTIcPgx8wvDA+ypY721d/Th8hQhglsn5TlyMYQjFRaXm5PS1X4xQWXbGJox+BpHlGTrXcBXGs1pnvsBr9pd6nrWaahMfLhKKIy5YOzZRN0iM8E557xBsgdb2finFT91H8gO3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d+vZ+0PD; arc=fail smtp.client-ip=40.107.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcgyAGbL+UmSyl1r+FoUORlV7goyDBEcbYZT38aAb584s7U0k27gLlcJGVX3qAxRdhVw9XUAFzXvXRn6+wTB8WxhsJtzHzoJevomkQD+/zTPm3CDYA0qme5dR/3S+C055oC22kkNHW7xK+TA1h8j8pkR6Pw9mRU6237DXnX/aCfozfEKSw5oVoYrojgQDNWKE1l7D/t6bnXbbs/JzM4fmtwsz1JtWi2tVbNRgGZf4ZnjQGk3GZqnXxIYp2hUurXydbAO72FAiosY7AcsuBBSip/dOlbufhx6Q4yomJ2k9+cflpyShB/Rb9l1ZvzHf3Q/+mRAxqjnnK1Apo9tvf5XtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V30GmcfnZc2yGIXCx4iWmeqjOvRq8ZcWpoGi4VUFg5I=;
 b=bLpdx0kFGKKdVpY86U2s7ppg1rfdQRw97mhPCKDnASdCQOgQOMcsOAdW5Y87HKGB1pDd1EHZtI4dmDbXb4MKMfNTIZ170u+f9azSlg8xzWa2FiEMkBquvKJZTY/00aoKN7m/qiLiMOzVIf9VC1vHJ5lTKwNntvbgpSTuglXa4RqyGaaoWBMR6LvJg1pAZk7GoYHYZ8oVjdvdg0kv2/RzfI7BvPAAu+6709CM0ct2bvzw0G42Do3BSsaJAa26HJp12+52checwEvdm4eBRCWczoERY39LAdKfE30hK31x8+KOH47IulElpZlY+hX2np+j3UgjDyRRyCYKJ88nGi5+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V30GmcfnZc2yGIXCx4iWmeqjOvRq8ZcWpoGi4VUFg5I=;
 b=d+vZ+0PDPHvc/Llvw2VSR1WGS5whfyGBGD+0ljjjPcfx/tU+QyDwmpCVlTZpsVKym9rbPqV8pdinuKqtp7tauib/m24pDwZShfVD0vktYBHNXFUpvKs/eO19Qd9Rm/SEoH2Muwpmv3CyeG7ACkFfpeVplr7hrWTFiby67gW+PY/QBNRTfa9kBIAw4vcAQKxP4bph5qX04aq6vPvEGnkfs5MvdWCmz5fF0or55aZQR7BBGJuWdaHAafTwFQq5+iE6nh3pZ9xIDU575EZ1xesQ4Xc5qEC0/Oj8OMzwjmPQA7pgTViM9/IwDhcjKU8AL1wgD5zwhFQ7pf4fal4LhdW5nA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS1PR04MB9682.eurprd04.prod.outlook.com (2603:10a6:20b:472::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 08:30:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 08:30:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, Frank Li
	<frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v2 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP
 clock
Thread-Topic: [PATCH v2 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP
 clock
Thread-Index: AQHb9iZhkd5V4Hmtg0ufc8muIqXiyLQ178gAgAAHnYA=
Date: Thu, 17 Jul 2025 08:30:14 +0000
Message-ID:
 <PAXPR04MB8510F642E509E915B85062318851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-2-wei.fang@nxp.com>
 <20250717-furry-hummingbird-of-growth-4f5f1d@kuoka>
In-Reply-To: <20250717-furry-hummingbird-of-growth-4f5f1d@kuoka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS1PR04MB9682:EE_
x-ms-office365-filtering-correlation-id: 25938e4e-3432-4ee9-cebb-08ddc50c2767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hYNjEnQI4D8qbfq+cJ22T3cKbXm46x5tmZEZuMVqKylLj6uofsL3LOS2lwgy?=
 =?us-ascii?Q?Ow/0xOPdmwZvWUHiTUq7FOigGmtJb+k1U++dDiWxytBTFji8K+GZHM8JLviC?=
 =?us-ascii?Q?PNqWGnYA0AtAKWB60kBdS7vg0dkPDWBncQALugDZydduXgy4/OfTeuqa+49J?=
 =?us-ascii?Q?wnYFBaSCFnPYJC3SB6V579IJtITt66QqBfSd7Z0KCoGoxZlkBqzE82eMfPjs?=
 =?us-ascii?Q?wOUydILKuvlDiRZJIFgyEGONlPbk1lnpmjV44so9bGjT239gh566Y+VnlOW4?=
 =?us-ascii?Q?N1bbctq4q2Iq3aWcosS9IvaQPnQsUQJ67jBTQau09F7KsxU174o3X/XZY/xx?=
 =?us-ascii?Q?pdY957GlfRcNF9KZmRu1hAjteux5cZwlg6UZgcva6y64el6p7LPHyePZdnmE?=
 =?us-ascii?Q?2vMmf82HEptq+kOY0iCLsZXIE1lnszgfS9UvLO1vFwymsOMEw3V1JoKgaF1L?=
 =?us-ascii?Q?K4iIqgkluo3fUD7+M26DQqsy3C8YvHbTCeXnSB5tgcRR/DWVCprTvr/ZHHyi?=
 =?us-ascii?Q?SFUQ0EzEbYMbO7tLNc3B1I81FAZsHaM3jFmPyuPF84UPEISeVvpUrsrqtsTS?=
 =?us-ascii?Q?KLGd8V4hR0tCXKbiJ4q5FWDqIX+W/wLXS1emxbvN7B03rJx6GFLcM4eLNKlp?=
 =?us-ascii?Q?tq/snlTOaxbHF49MUyBvD1IRJB90d9xqZ19LENTJYJ2czQnZIeDmsb2J+ODd?=
 =?us-ascii?Q?huOImXhm8m/NCKmzEkQ5sZ54q0fqQE3pfAENJLhqYrCkNAEAdu1VtaUlh5T9?=
 =?us-ascii?Q?Q2cl3gmISW1q7sjgulBxaOIEdxioqA+G+k/M0RaW3r6dSkmJr5gp93oQrTZr?=
 =?us-ascii?Q?4p+EIxu3HaDFaYxWFtgUNhJtxvfD/2gpcsUpAOYGFoVjwR2tpR9fins0oDa6?=
 =?us-ascii?Q?50hR8ce+FGAICq16ZFNcyrIPhZKySHZbTPc6B/lkm5WOgrhk+w4Js6RSGFfD?=
 =?us-ascii?Q?tcVZIP2elg7Wfq2+uB+GiYzoom8THyX7l5fcXCkp/LpnfBxDRElGWQuoOgbK?=
 =?us-ascii?Q?pmwB56hYf/o+Vkvqq7uRICuxIXIKdrXz9uoVr2PFJepicFPfGSadJrqitcE9?=
 =?us-ascii?Q?bJrwrhDi90yLckt+PwFqJGvxgXV2ezmUf0FhWv6+df6GcWi7mfn5v/xX09uM?=
 =?us-ascii?Q?zzdccCIaWko207F58grqfivAcG2KEsFMYKbO8DYJtXV5BwqYjinoyyAj4NmS?=
 =?us-ascii?Q?AxAn8yU3a3pLNvg9rdmlyUPvm3I1R+WawZfolHks0s8Tv0YR5QX0njIZ9FoQ?=
 =?us-ascii?Q?sx8ntV6DsughG6Tm8ECGmoHsjTP04eqSfwwGDZHoxvMrjg1gxvaucCijzOb+?=
 =?us-ascii?Q?MjXg2XaOX9cvBwH4Z6QV50uZV1MVIywq/7ncZEQXb0go6DDQ5XRTwzMo+X17?=
 =?us-ascii?Q?n/TStbhKTR5sD998OQmG64eG5TrsXijfJxVf7oZROwzYqN4uec40uTZcSrNs?=
 =?us-ascii?Q?IDNRPg7hh3lepC9PNnAtgWT1U5Az6aNVHFBRcX4eoAYvN0pxQCoAiA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pA2vPaUFF6kj8fyGLt8pk11fBt1T9C/UT/BEKgVXd8bO2Cgd3evYsctRhWYa?=
 =?us-ascii?Q?sPoam/C8ccm3xXAPHH2iLoOngMuLFiBjEafzuVIIg1gU709w8zMLTQiDipk6?=
 =?us-ascii?Q?+9TIUBUyvdXFU4Mxp2TikRDTSoT9MCDBJ2bIiQY3o5LGrrTfwn2txTtdVQrC?=
 =?us-ascii?Q?Jho++jxjItoNXHhncqb4akulRHf4kPNOw48Gf+eHKZLNLZ1kayG7H0/8xAcx?=
 =?us-ascii?Q?CyQ66ExrTATQzT4OzGFZxb/Iz0HzPTihK43NmhnVv9UAsWgjyryeRD/fDEu6?=
 =?us-ascii?Q?+6mGbDsmAK/scrHjYUjE3BZmKLHy8AmZmJceriDEIRGCTUfRmqnPvBotyeCe?=
 =?us-ascii?Q?aeaRxAT1X/8kWYcQkE32LBzJiHSB+k9JpN9wrdUeOBQ/mwcZy4kMtm3bl5vJ?=
 =?us-ascii?Q?HnQS5eoh9piLs99c24luTdv1fMZBKEeVUMRV710jI43IPPnKaWQY6CZLXL5L?=
 =?us-ascii?Q?n+ouCGW6A6tWc4zSDVfCtlushs/tTfJNJIL6EJpajZpvyx3G6oPQHk6U1cJs?=
 =?us-ascii?Q?dTgEMWl7f5nPfCqmkWDT52X/687JW0u2vs1XUxQgXlEa0YlDyKm383mLzjNt?=
 =?us-ascii?Q?ZbHV0kLt+pYIT9iE9xI1ClQCigHr7zsaDCqChZomQZsm+6PDckmknkvpUxZC?=
 =?us-ascii?Q?gcRbjGOddN0iwKFdBs/507wLvjy/miLxm4tqcw9tiK9Y4JZdFfo1zetx5L44?=
 =?us-ascii?Q?FvxWjHgbqB+aA1pbvo3wfEZynqW7YLHmEary14nMGF5HD7R4yGDX1QnH4UBd?=
 =?us-ascii?Q?APKJ+clto7AdXRiylvyDOAd1LKkxvOK0vkzVM0Vbdg+sqVmdSK5qSH9nzv5/?=
 =?us-ascii?Q?iOgvKI4yDoWRhSA/6KKHhvU3rimDUXi61MsVnKIYGjBGk1dv1hlEXZJJNDny?=
 =?us-ascii?Q?kDYTWaKTv819f+2MowVHOSq3oM9Vv62wavLWun13ayJ39UHGJ3hYyRidOlgx?=
 =?us-ascii?Q?7dCxdn2h7lSKTsGkKIM7B1A4C0mE97CvraQVeABcpbgTknHDi0iaH3RGwjqz?=
 =?us-ascii?Q?f0r2ybG/p929oXTsA80gFRvuoXU0r9HqJ/fLJZAB9ZsOETWGVN+F5MS/75G2?=
 =?us-ascii?Q?AUzz9UT3Jnd2gWsTjd4BIlWMLUpxY15RGIoqUnaQucBIplkVlAFsdElLTnBo?=
 =?us-ascii?Q?2uwx/ZB0Hq+aJc1DyPX3sZJi4HBt9VKTwdsNRgcaEsUatn8xnaaxNJw/DKcO?=
 =?us-ascii?Q?XT3WMxAGD1ppwdWBDY9XvJoBHcrqt+p0i6dWh6nzLSsukZuqfSWMWiEtHkMD?=
 =?us-ascii?Q?EiJy+fBxTohFqRR3F3M0NHUTuAgrQ2VoxOLD2tfCQ8zzIY+SsLBZy45JA9jY?=
 =?us-ascii?Q?2vevhYksU8qlvOfCDsAEfA//U7okQIu0vhM2FyznoWLAMSbJR5Wdk9snt1xq?=
 =?us-ascii?Q?AfoiWwoC8apQD+iUq9L9DR2b0xKc9srv1obvMh/VZf49/PMy2BqlQ6qpzSmE?=
 =?us-ascii?Q?3zPj61fU8+yTRI3uk+Xb0r3pXgucDiN/Q7P5GYSTJxwIeHEmONmaaWvccOTE?=
 =?us-ascii?Q?BunS65iROYEjsqS2suN6GBIDiSPtr17DMMtMGaKafiyH8VVrP6dfUh6fDB9b?=
 =?us-ascii?Q?oqjhOgfkTB41oRV9nug=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 25938e4e-3432-4ee9-cebb-08ddc50c2767
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 08:30:14.7242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBQI3omvZSDNElhHMhy0oNGEPL7lHMfQymgxyX9nWIXZqt321Dzr632gwbmJtVZob5hQ5+6WoBbV8q2j7Zlstw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9682

> On Wed, Jul 16, 2025 at 03:30:58PM +0800, Wei Fang wrote:
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - pci1131,ee02
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      The reference clock of NETC Timer, if not present, indicates tha=
t
> > +      the system clock of NETC IP is selected as the reference clock.
>=20
> If not present...
>=20
> > +
> > +  clock-names:
>=20
> ... this also is not present...
>=20
> > +    description:
> > +      NETC Timer has three reference clock sources, set
> TMR_CTRL[CK_SEL]
> > +      by parsing clock name to select one of them as the reference clo=
ck.
> > +      The "system" means that the system clock of NETC IP is used as t=
he
> > +      reference clock.
> > +      The "ccm_timer" means another clock from CCM as the reference
> clock.
> > +      The "ext_1588" means the reference clock comes from external IO
> pins.
> > +    enum:
> > +      - system
>=20
> So what does system mean?
>=20

"system" is the system clock of the NETC subsystem, we can explicitly speci=
fy
this clock as the PTP reference clock of the Timer in the DT node. Or do no=
t
add clock properties to the DT node, it implicitly indicates that the refer=
ence
clock of the Timer is the "system" clock.


