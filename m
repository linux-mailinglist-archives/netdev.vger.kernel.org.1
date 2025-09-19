Return-Path: <netdev+bounces-224663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDA5B87AEC
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 04:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522E01781C4
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 02:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D35246BD5;
	Fri, 19 Sep 2025 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TRkvd92H"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66019E7F7;
	Fri, 19 Sep 2025 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247352; cv=fail; b=tTpfYDvTZJ3pRz062jUxCazfabAZqWPgEQl/sb+/9QWkteQaYcdWjqhQ9MG1eN2iKRAxq2UZNd72TI7UXqEMAzijw41LVtTssxcYbcxE8dMSaA9cxke70yGnr/nvws5DevvRxz7s83xhIV02LNfTAXHPqIgRNQA/1lxAJhO1tAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247352; c=relaxed/simple;
	bh=6qPlzijKm+BRGLqfj7M7HSRSIY1eg6d3aj6a+61QRsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BDjiQINRp0UhqB28SjnqAJsUWyEROfnk5928kw9ES+rwGcC/QV7byxyZy+KH0QjXNXLeHgq2cbO82NxujxSaLp1hgi24dmI8gvct07hOrrc92E+VYzUv0XmFiesVIxzYBY24R/dyfKwyVNaJo9qiklXGyhDu5A3SAU/keH7Zmxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TRkvd92H; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/W9yQwwbnk82kDeDHIlFykBLqWd4RqScxxNccUQEud/qnHA9LRmJqu+zgeZV3n5kPdfWGfe4Y+qyFFfdEVtPYy5qFouAEeofc4RFmxS2EA/TtJpnUK2H9r1TdQKFUmlquZcq5MT0+QfyKIxf2qe1+fvpguWysJ5/bE5LyqGsLC98AVttAma3+emlQcdh0J8cWia5WNdtHuUBtLoD9pe+CzX28mQ5d8pZ4DQ4aHlE+fvtu0nC8E3Y9W5UAbPaV3K9SRZPbrOlDjMaPiSoDEI1otXDQKdV/iU7/NUfwFAe6juEWHOV+2waHxT7ez/i9YfTuuwlAXbTkvxFt/vw++ujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9g5qrW81CwwxHZUF0/C6fxnRVjNXO7RTAVNLk/bOL8=;
 b=hH01MF+oVuL/gDfX3QAHGn9JMeVOiib3w/frl/OWhgqStYtxsHLHT8VwWc0pFj+ooXIpzY9aNrHD6zhVGuFPHXZUKqwtTp9bCJdbDqQElJFAcjrtNDWzXQpgXZ9Hp0hDcF23nFJVplxeADZF565t2TNwIuYC1N8Z7KFulH9ZKq+pTQ8Qj12H5OMc7DEBOZf3YFZ17CjFJ7yy7+zVF0tYiUk2XY/uQILA3liCJCnw4X3D9st5pUJGg0qf38ehA4yZkj4cRXNX/5uP8fMhV5KlUHNOgLqrvGHVOs/O+IlDw8DBHGdtCLgqrC1r3ET/bQhp6Z0hbZ+wUTJ+51wuxIlWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9g5qrW81CwwxHZUF0/C6fxnRVjNXO7RTAVNLk/bOL8=;
 b=TRkvd92Hmw5/Y+NAX151+3EqdqMNv+40tX7IG+RZCWGY4Nt9bouV8sAn51BZFw7rnIWyMJuLfU6hzD181mKjx+lkcjQjdh8kAoks9r0ABV/eq7/xE+o5Z4DgKG/Chmw1xPJUEiCJOWxF2iT8BKV22YKZDguj/evW77cBkzBGOZQxgN1Wg18/Jh1M9l99OhZ2Yzllm8D3Agl5grkRT84fB2V1ENnkaCHdioRxqsEJwsefwzRS56Q8F1zFiyjBKpKgAIErDCcGCKMbb/PQtWqk+r3WGjM7EcDX0qUVwGdagCm1OQfwvL7jine7g7YE2C50UkNYylZgedhnOyb+R54dEA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7292.eurprd04.prod.outlook.com (2603:10a6:102:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 02:02:24 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 02:02:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry_Maincent?= <kory.maincent@bootlin.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: enetc: use generic interfaces to get
 phc_index for ENETC v1
Thread-Topic: [PATCH net-next] net: enetc: use generic interfaces to get
 phc_index for ENETC v1
Thread-Index: AQHcKHMk1MYmn1GT1kyxTm+DYIWS7rSY5COAgAAJBPA=
Date: Fri, 19 Sep 2025 02:02:23 +0000
Message-ID:
 <PAXPR04MB851055F069DF8C17C9B367628811A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250918074454.1742328-1-wei.fang@nxp.com>
 <20250918124823.t3xlzn7w2glzkhnx@skbuf>
In-Reply-To: <20250918124823.t3xlzn7w2glzkhnx@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PR3PR04MB7292:EE_
x-ms-office365-filtering-correlation-id: dafe2da4-4c05-470c-8b44-08ddf720936c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?HqNR6rA0h1D7eSPEMx9RhOdq9wIKCDQfig3aZj7/LxweLxuFC6mO9x7lY2?=
 =?iso-8859-1?Q?FTKj7SnWQ4OxjbYT0AuWm0wOGdbFM/QthpIReeSNPljeEWLYpN454rreKX?=
 =?iso-8859-1?Q?4Jw6CUQM77wlu3Djs/gfrgGcWbYisyJQCCONXTtIR9cudJAvaeXc+hdZYC?=
 =?iso-8859-1?Q?P6vfrAIP+gDKDnjOkzTrXOzUBo6PP/zubsc/m2uD9uGEp17STAMn2IP7mZ?=
 =?iso-8859-1?Q?bpoXKojEn8K6eu7dxoKd6d00DsG+rDX3hx1Sf9mxk5CxbhPtJZDet5tvA9?=
 =?iso-8859-1?Q?FmqzX6gqagd0fY5ZZiLUPqnJcUAu9M9+tkQOVl4LO2gDbAwsDxL8wFRbzm?=
 =?iso-8859-1?Q?2THOqcklMRnaFjq/A60/8CniN3UQts2XJg9UCU7MVLvZ48h+40cJtkvtEU?=
 =?iso-8859-1?Q?97DRW489FMotAHiq12PjrLtlrUH6ewV75jflGz5Nt9jpcXrVg11YAtlZHv?=
 =?iso-8859-1?Q?Qj8nULoUWYCvjddH+pYvCGmwMFaxbVCw16G6VI3liVdacihTaADBC//oU6?=
 =?iso-8859-1?Q?K/OMWs07CPOrUKFPkkSMMMdzbuurNqFOEqJDMz+sH29Uf6zVwXtwI/RRmB?=
 =?iso-8859-1?Q?Hwgsr8HuNdUn/I1Cdij1tvO8CQGzwUuur3dpyE1vgIOx+s3uqlnZcrt7ZL?=
 =?iso-8859-1?Q?/IwqCVFW5YUtdLbO/xQDQEn68cpQv4jym6H8JqNJfvcloEyX/JIEPPrEUR?=
 =?iso-8859-1?Q?dxan8sNFh+mhlH1j4orSj8tT0kQmyV6XRdRFvkL1g5bYUIwB/nAmC84f8X?=
 =?iso-8859-1?Q?i9zgfh52ccfK7QVvuZjlHtrbmwYDoABVIDHCuZZxsJrEH0lc5JV2V8JwlQ?=
 =?iso-8859-1?Q?fXH9DLvCdwC4mVE4dI6MTGGHqr1dS5JvNXkyTh44SskdDP5RguvjTjBNlU?=
 =?iso-8859-1?Q?1GDfKvhOA+31JUitclPHYWy7Jtuoo2tDimwjf2bwi77dG1l8oGYgNout6R?=
 =?iso-8859-1?Q?h4r7fpcrsXS1gksU5fJS0BjW37SGYjG0jYE0/cF7yX6qBb1c1hk77C0KY/?=
 =?iso-8859-1?Q?9fH8l4EZ3ctAbucCdNfA30TubHJvslriyK8EiN0PoonaN+6fSYsRVNlCdL?=
 =?iso-8859-1?Q?KKsDHVbA6iuhPf8jxpGcaBitR9fUY3tXrWZouaqfYK1RQJ0veSC6qgJQi2?=
 =?iso-8859-1?Q?OmACmlM5R3ZLDs2QqZMm9OyRP+w2OMCBzvjY34Lluvk036ThFGQXCRIBMQ?=
 =?iso-8859-1?Q?j6xVtDtsVwyHSfjdemXNKBBxnSQHAJA840feXjmIHrkugJUMoX1IR/zIUu?=
 =?iso-8859-1?Q?MXJPx0exYrXde+bfAWlHaPkZpu4fj2jwTpGzj4Omr1qUh2sx7hVD5e9TmN?=
 =?iso-8859-1?Q?rTAK1xkMt+48ysUxWeYUzrmMioEju68fmb2dIIrAqNvInbuAyHjw2WtwdH?=
 =?iso-8859-1?Q?ievmGlVyriqP+upkeIwdsiPG8d+NwbyrTy2rDIkMUthhdV0Y/VNjH5V0IP?=
 =?iso-8859-1?Q?Or4+KO3300JHz/xla5hOefhI8tCvKQfBPRUa2h4G8b34PLzSOIwU3HR/VV?=
 =?iso-8859-1?Q?cydIqJ2xezW3psa8b1MHX572lhymroiYaMs7asxFoFQQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ABRiX3j42Dco2xLQatjHVUpbEnrmPksM3OOiVOoCssVJPj5mDD4LtkWGMD?=
 =?iso-8859-1?Q?6+PfxwLT1/hwwVvHwt4pMiY04vrBI6vtNu2QSx1K90iIP+9Ip/gd1uhIeH?=
 =?iso-8859-1?Q?YDymTo6OfLMQHv2SgM5AtdW7XSI7KI6tP3oSc3nLCljKa33I05NIwSYsj0?=
 =?iso-8859-1?Q?Ox2VHNG5qwPJtyypDO1SvWYma+UaMwdrr+f/WymwNMCg+rZ7FgaaBrfHEN?=
 =?iso-8859-1?Q?kIFremHS+qGax07FxE/eLj3HVYyH+QMAHnr9hYMYQPVtwUeFOdFU+lcs77?=
 =?iso-8859-1?Q?Xx8z2BYwlJoLTxNpDmoqtJCztwRdaeXZB6X7Rqi1YAFh1no6/bSw8Hdu4I?=
 =?iso-8859-1?Q?dicfHDYAeXOthoGEDNUodzAlcET7iy50c+J/LHEEHbX/dk/rSRpfHqhqTs?=
 =?iso-8859-1?Q?N1MohqanNly0oBt6H3EM1cSptLNBTuvX7PKHE3fj+m1nG2tqP+sP7Kthvc?=
 =?iso-8859-1?Q?oOp2IblcKwm7Nzw/CC7OGssxGPUy2Id0DRh0PyGKHD0/Ru2yxi5MVaPA6S?=
 =?iso-8859-1?Q?aZIVG5Yr2dHvqK9dCtMcxVLOpeuJL4BsYWpP1lMd6k4p+ibg0Fh1b+dF+i?=
 =?iso-8859-1?Q?osKAx2YVRsWocnyqrKm8B2pNApCPOiTBqYttIjxk4rL9w/6w3tSqLK21ze?=
 =?iso-8859-1?Q?V3G1Z1Sq1+cBTh+pWhEVsVghc/HUS+FOZqsUIpfin9UWlJsBsmtnHKHxQm?=
 =?iso-8859-1?Q?C40tpEoUGEFxoCWWtrZ7tWZPNCsSVyJJh2AStjqRdPasWaMlgrOZp6EtIS?=
 =?iso-8859-1?Q?dSxGuz4BxPZ0QPH7EyK5f38vWsBMQNSfp2Ln63Rs5xMPFAZ3MDB6OpZJvw?=
 =?iso-8859-1?Q?OLDUNcrBCgtRqxua/t6sug3DBpDKD5cd0cyJrlmFOjlV+v0MtlUMAJHCUK?=
 =?iso-8859-1?Q?iz2IvJD29yBkTzK22MhU+GHcH5I8LL0d2CHZvtOT1R6UnQexweY3q94YXn?=
 =?iso-8859-1?Q?8L+5VY3SRF6BpKTfx0y+gWC1LsRGX5JLBoWx28GaD4YXLY1mFyx4mR+yO4?=
 =?iso-8859-1?Q?YB1BdHEQJkaimAHtvEpYvclKYg+DauB6CMq0NlC4JSrAMEAe8lDvvAe0bG?=
 =?iso-8859-1?Q?C12ekgB8eDQXHACAHjrRwCA9fNUgMmsJ1BhDPJoC0dawaa3HF9OjyQ7k74?=
 =?iso-8859-1?Q?UU3eTIKBYsb4+s+4YDw2fdDUivLQhT1VNr6YVubR+oGQIhyZeyeldqdABD?=
 =?iso-8859-1?Q?Jzwphil0DnxV0zbaD/hf0Q84a0TPpAADQYcR0GNwGxcszSVHJnBvxNoJQE?=
 =?iso-8859-1?Q?bpJVLwuyP95e72ZsatmrPT6pBJ85h7gRyrugHOWzJ82iSfmIMKOCTlaS4d?=
 =?iso-8859-1?Q?ZEzfcIM7YA1z4boyeZ1xn04LXcvoKyiyHhzKw4p61S4knztbiiDd6xyl/K?=
 =?iso-8859-1?Q?BSLgpNCf6sduhWPOLEyKN3oNXN5brBxZx09yXWCdwIfrUo6UA1AXIBfja6?=
 =?iso-8859-1?Q?RUYlvnafHnsFOZmta7KasIa2ZvXn1AGeK4KDIBRXjwj7lnkMLMzCL986Gn?=
 =?iso-8859-1?Q?2++Bq6dgFC5iHNdxYNgf8rHDe6pyeyvk3Ct4jPxebYlymTf+fll2+RiYgm?=
 =?iso-8859-1?Q?M1XXL4YkpgntXe9gtw8hIVUG65imblkndHb43T6O0WbxSP6LFUYrXXOFku?=
 =?iso-8859-1?Q?QkLaTcJzWzvgc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dafe2da4-4c05-470c-8b44-08ddf720936c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 02:02:24.0542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HoP/VEtHVKyWwElsV3YNru+84VIt3AE2I0AdlYEEw1RjO9qJmdgv/fmHclqv4j/KH4HEMwe6X4uvLSi/3B/YUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7292

> On Thu, Sep 18, 2025 at 03:44:54PM +0800, Wei Fang wrote:
> > @@ -954,17 +957,9 @@ static int enetc_get_ts_info(struct net_device
> *ndev,
> >  	if (!enetc_ptp_clock_is_enabled(si))
> >  		goto timestamp_tx_sw;
> >
> > -	if (is_enetc_rev1(si)) {
> > -		phc_idx =3D symbol_get(enetc_phc_index);
> > -		if (phc_idx) {
> > -			info->phc_index =3D *phc_idx;
>=20
> phc_idx remains unused in enetc_get_ts_info() after this change, and it
> produces a build warning.

Oh, I missed the build warning, sorry.

>=20
> > -			symbol_put(enetc_phc_index);
> > -		}
> > -	} else {
> > -		info->phc_index =3D enetc4_get_phc_index(si);
> > -		if (info->phc_index < 0)
> > -			goto timestamp_tx_sw;
> > -	}
> > +	info->phc_index =3D enetc_get_phc_index(si);
> > +	if (info->phc_index < 0)
> > +		goto timestamp_tx_sw;
> >
> >  	enetc_get_ts_generic_info(ndev, info);
> >
>=20
> It looks like we have a problem and can't call pci_get_slot(), which
> sleeps on down_read(&pci_bus_sem), from ethtool_ops :: get_ts_info(),
> which can't sleep, as of commit 4c61d809cf60 ("net: ethtool: Fix
> suspicious rcu_dereference usage").
>=20

Thanks for catching this issue. CONFIG_DEBUG_ATOMIC_SLEEP was not
enabled in my config file, so I did not see this issue on both i.MX95 and
LS1028A. :(

The introduction of rcu_read_lock() in __ethtool_get_ts_info() makes
the device drivers cannot use any functions which might sleep, I do not
have an idea to fix this issue in the upper layer. Currently, I can use
pci_get_domain_bus_and_slot() to instead of pci_get_slot() to fix this
issue in the enetc driver.

> pw-bot: cr

