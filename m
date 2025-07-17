Return-Path: <netdev+bounces-207814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57AB089F9
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164EB18988C5
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C30291C30;
	Thu, 17 Jul 2025 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="atLZUgjb"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FEC289808;
	Thu, 17 Jul 2025 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746132; cv=fail; b=X86TdmxwNHGOsNGvZhGKbNrbhBc7zUG1a9+krFyykxDgNeRQgh8I84c2vKaa91arcKJVVRqA+KUJfin/sTA/sjaGHy8daui8XS7vX8OiDVXntEqrkHZRmF8gu3NNHWEikiJeXTPwa79Ewl2I4FY7xWVSBYOZsaFg9GWoQmT+IBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746132; c=relaxed/simple;
	bh=uoxGsRGw8hQilp1RbNODIvNL+AdeGh3CiNPS93w8cn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c3GTeWMMCmh6EO7Jvf3EABER7oWW9jkmbBr+bexMk0rC8tnm0Wz66DOGgFVUck54QrmmJypq2ZUyO9urS1QiQw05Gg0rk1oQxCEwijS/1nicbosUNmNcXUUNZpi7KPKeLpTYeBpSy6aSnACkzoWb2VH47FXsD2yJjvB7b1GJOqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=atLZUgjb; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmbuPBMrCOuO1zN/SDWhhX1cAjKJ/v+O1Pis3tWASPo4LCZ689NB9we6JjAqih6UrVJv008/5mfl15V1Hoz3AyuID5Aw9fHZXi4g2QVOlu3xrqUdT7x02op2oH+5NdGKCyKTGx8ir8hk3pnS3IsWsBEVt1chATteEyt7DXlerIWKG7AoQxEFgFg1BpAi1dJBS5ZPw63ALpFB8uxgSSOSlaAJ4p5KMbDVEXoMHISS2JBlbVMTju5VdWdeYUE0P4m+fJQixJgmG0PiWnMkLeENgfAXHxGGxwU1XN752NMfs5VpfFQkJLCAvINbFIdoYg5zmZFN9MGnksHtaElhP6oEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TE0Jfsgea3vtBesOG2n1aauV/JHEIZxe6lCGcaU/KE=;
 b=q26EZxDaOTFY2UyvKGzCTgqED1tVSvbslN+HoQQvQCdTX0vCFg4sjh2vDkCvQAysIuOlsC5M9Z/2MxE3VVqeW++U/sktluRSOsbvKDS4/bwSXzN9tXJTlkBnCorIijES+7EzzhgOWsLPBDTMBtSVyjiwolKM7I1kUli8eKJYoWd9iCZSdnTyUVpPLWYRr5zVr4sVXprAgtJDzbgH6u1KlsB/0iFovyBfklxPTts33D+Pu2wl7hgOVSs56eNK5285DjK3WnJDdaEoR5eHAryQllhMTuUnjJA27KmIo62Rx3gY9Xm2HclJpBQ7u++FfqHjc2JeL6UgaNWb3b1zspZ6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TE0Jfsgea3vtBesOG2n1aauV/JHEIZxe6lCGcaU/KE=;
 b=atLZUgjbam63kOBXOvR9AfYDZSQchEUU8YJ9H+uYt4244/aRangaZHmPLYbH5c7z/M5+X901Dr/wIMxPS205zMGeOx6THIZUWO2yOUYhLndmeS6EDM4KV0ZIKrng1TFcXhcmglYxfgzC76gn1amsrkYUsEGakc0/eCIuMy7dv6JjfMJAMemjaxcw/hX2oTzFLEGsYR+r+TQeXQJ1PIq0ja4ht15dm1wTqk444XvIBEQU/0dU/VFlo/vaHZlqTsxEAQF2k4Oi5EPIqgeToXYM3spOZ6u01GnMorMrWVnMYtKdnSifosRx/Npg1t5lZOhe9eIx0Q5UmOfa3Ayo8xMg4g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10441.eurprd04.prod.outlook.com (2603:10a6:102:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:55:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 09:55:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark
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
Thread-Index: AQHb9iZhkd5V4Hmtg0ufc8muIqXiyLQ178gAgAAHnYCAABBFgIAADJmA
Date: Thu, 17 Jul 2025 09:55:27 +0000
Message-ID:
 <PAXPR04MB851096B3E7F59181C7377A128851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-2-wei.fang@nxp.com>
 <20250717-furry-hummingbird-of-growth-4f5f1d@kuoka>
 <PAXPR04MB8510F642E509E915B85062318851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717090547.f5c46ehp5rzey26b@skbuf>
In-Reply-To: <20250717090547.f5c46ehp5rzey26b@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10441:EE_
x-ms-office365-filtering-correlation-id: 12f56428-e722-40c3-1a90-08ddc5180e8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y2MaY0E9tDayQ8H5ZD/8obEXC3bbDZ6YmXw1zJq/R587dNfolueVvt48tJ3O?=
 =?us-ascii?Q?L2hkrOYy6sN3hdX8yXR0o7uWV317k+UtVDE7NrelL9eVDTsJoQI5/GcmdRkw?=
 =?us-ascii?Q?1nda2jd6MMzfOtDXk9q5qCRt18KK3CWSd7gsOardju1mrG/RmxVzwHMksZQE?=
 =?us-ascii?Q?EILWicIPgWDdwpB1iRKZFX8peJ4vTh4kfXPJXOENmClW4uQhk63KsMMZu47x?=
 =?us-ascii?Q?Ht+nEZOn3/w2GYw8IzDdrZT5K6q3MrZ4uarunxkUrKtGFg2qZaUhPG0AUayA?=
 =?us-ascii?Q?lDxO2/a/5tFGk9ihB5aFMB9IE+8yzK9PCIgESKR6/pX4IkN2MpRxOZ6zflXG?=
 =?us-ascii?Q?ZXX/OnHkmCzJ+53RXy+LB5DVuagO/6uJWtXJN85jdcWIoah6P5B/BZjFBXZw?=
 =?us-ascii?Q?/YorCoSvwC0qJuUnToN0bVnMpVpPV6DQhfVez2ejkCz/PzHb/g9JIRaz+v8M?=
 =?us-ascii?Q?SAosrQGY0gCxp06xbZ42e1eNehfVScNW5VQRMCJmLp47qWBpBV/SsPBaIczW?=
 =?us-ascii?Q?2RpYgwWsp8Qc+ZWXXygICN04h/AqEA3gvi3EylGtHZjtKalGpT2+UrT56L/j?=
 =?us-ascii?Q?vDmpcbWWBNxaeG+LZJBPl5X3rDODXdvFc9HucwWrHC4t2FWCHLl+CuF8cSjX?=
 =?us-ascii?Q?CYowMLDJNvgpjRxjd5JPkpgyn5JiAoY9CpkI1FSXlTJvzs3cnCM1JtEyXmsZ?=
 =?us-ascii?Q?4pNvNxRkhknh2UuDjKIMfzAggvd/2yYkhPmxKoDxFfEgRfziiONekwGEJm55?=
 =?us-ascii?Q?FoNhic5Aid6JgVc3oUpXfUlzBXSrr3G2EY21PDrv/24LVe/IqbesFJh2Uouu?=
 =?us-ascii?Q?5BCcF4ZP9tIRtpYgCOj015GzsRU52dZwHeSfwNQB2w7m4MXbWV5dR+9qSR+N?=
 =?us-ascii?Q?goWD4tr2tF2Mop3Ir+aA/0NQbaiX4WvsGuQleODL3ylqqvCjHl6CRgfde8SB?=
 =?us-ascii?Q?av5QWTii8dLAEDPHSo8ZkIB4fyyGmTiQxeBdwJLMo0Ra1UfYDsbizJc5ch13?=
 =?us-ascii?Q?sIWcxwDUhVLZvkxfTABuAfaOyV7qdxh2PmsOBSD7Z9nnXvvYGnXtsfkOlMcF?=
 =?us-ascii?Q?1Utg/MAyA8HSbXrOBFHkdUBml1clKxxA/1vrzOGV7r8t21gWn6/h+2bhTXMd?=
 =?us-ascii?Q?5fAEyo3w0jByLkUdEiHZ0/Uo/L/zk7loEhLsPJPkjzb5b5n0pV0wrVw+o+Pa?=
 =?us-ascii?Q?kR3+9KOfqQuxeCfuDT+YJMvviuTifv+3/bUhhd7ZHDawWtmfA8ZSnYTbsZQA?=
 =?us-ascii?Q?9Vo8MkxYYFQII37XCbeGn/ygphajAOU0txMP0DNYbwN7BVTKMsNmlx9BJ9AB?=
 =?us-ascii?Q?HkXkoXV1/GXUjOgsb78cVlfbfiQn2+DnF2rFTa71aLR/6gzCXgqPzlf08KPy?=
 =?us-ascii?Q?c4WhQpoFNbCejC5icPrU2lmGVp91jk4mnrozYWHnI9UQZAknNv77qDsqfMQV?=
 =?us-ascii?Q?+8QvvZtTf13gUb2qYJyLveY4+Iz8lz6zmVnsdgWk7r6+3qQVGxlwJg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aQu8R69OKmEJDNPqeQk7cTDhDUlN6wcMEGVymWEGH4RqAj7lWu9IEq+IpKeL?=
 =?us-ascii?Q?WNQX2Vdx5vdmLyM9b5CnuBE6HPzoFyRTRuCismp52i4yhYkZTyZL16oD2Ls9?=
 =?us-ascii?Q?yJrv3Dg8GkN41V8OzHBt4kdxSO1ldQKtsXiwSLVB3HmFt2qTgm3DjJiPX1zM?=
 =?us-ascii?Q?N/uE0LFKGuJnftGGWHRhHKdzNGCtXFuN6NXWp7POmcaIXiI3x5TXiEry/aY6?=
 =?us-ascii?Q?G1VFPM10rXGd7n5mGGCQiqMHv4h4hRGiZV30OicVaXI3MS5I8B+0msu8ISbq?=
 =?us-ascii?Q?GIBcHzynlcYO+0zjh6Kf4br9WOfzgfE1TlW5TsF1hrTnxaIGLk2z8bM7+ASg?=
 =?us-ascii?Q?znTVmdwI2LTvxM5h/6qJaiGkxVa74bLSQjM7zKuMoCiFrgnUqSmPD84iqTko?=
 =?us-ascii?Q?77NiSuYNa6DVRNABM/vjNpXCgSe7hy4LytyrqzL3lJjoz+sED0Z9VTekyo+K?=
 =?us-ascii?Q?GahSMRBHwa6vyqftdALuABTqJaguCwDxupsBHgeiCklURMZE8mvaDfOIWPgs?=
 =?us-ascii?Q?NzubD+svTG0vKWEcrn/Pn/2muc2F8LaMJa+RCcThVPaV04Hbyo93OXM82jsr?=
 =?us-ascii?Q?ZzRAlIkanvUIGSH0mQnOEQk5ODIttSEVvaVNCiwnAKX1emSoelhTGCfX+tJO?=
 =?us-ascii?Q?s3SfqzMxLVYTPvbhozXo7EmHFHym7IuR8ZA3AhE8Bn91VdR1ChKuPbFVrv8F?=
 =?us-ascii?Q?XDATprKXFflRbFNbmTjJ1xXeKBA2pnY4wygo1S1HUMbJKQDueJmf54o9j7+V?=
 =?us-ascii?Q?WndC7eWaxRCFcyMf6dzDihjVA7q3C/CZ/tw1+Pp5QOLpqX8abo+V/YBvCix5?=
 =?us-ascii?Q?JbEoG0OtAmX51fJJ0S0DFVRLRqeErsuARBMwMFEAmsaFiThwQem2uy79ZMMy?=
 =?us-ascii?Q?Y4/LAabrcF20GJY39gT2m/UenOvSc6z6H6pqIl4KJxH6pUl59X+INZyUGQA0?=
 =?us-ascii?Q?Y44MHHmijkTW8ejx8MiYJhMy2FyV76NdNHMTZTyleDflEz0SFGtNMltQ2Wsx?=
 =?us-ascii?Q?4ldcktsno3qLIGPGZLjAWDrOjDIRUt6np94QcDohKouQONaO1ghfPYmzUZCH?=
 =?us-ascii?Q?7EUZDu1GQT5BftXh5PujEgwHXaT4ZIgGoQ+2SQMTpZUfMcK1M85w5DKYcq0l?=
 =?us-ascii?Q?9lU9F3z4cEdY0S2Au/J5+9Ds0vcJ3maDRsyqQWhIlNvY0hD0/AezGeeg4xbU?=
 =?us-ascii?Q?F3Ny7wZdiJgDqAwdRe/bMlkUvVJOqKRtb6l1pn6pE0S++hHHROXTrn5CU/G2?=
 =?us-ascii?Q?iDSWvHyqvtz9qMrQLxA1jjerr1Gi4uOuN5Sz7ZdWPxhcxn30yKHRWP6PYSPz?=
 =?us-ascii?Q?GFm3aqxPG0P8kP+PtMlO4KOEm2whxHEgBUfbuQovFnWbIcCmH/zzuPzhvZ0B?=
 =?us-ascii?Q?jIFqUak0r0BBzfDPAQSIWZL3O8rY5pUbj+MA3rbDuBZErzIOs9bySm9lEMzB?=
 =?us-ascii?Q?hdhgVU0dKQ9TtYJenvfXynxJyMnRYJTGKvPjNNTv9nm7vi+5mkRq4bnluaPM?=
 =?us-ascii?Q?JG9GL1Y8iCTn09M4Nqf4IT6FXep8j4vzAfVbq8r0HDX/56shq1bnabEXsZka?=
 =?us-ascii?Q?bGcrS+CEhqMmtdphLUE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f56428-e722-40c3-1a90-08ddc5180e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:55:27.0443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzWCWBmTZmBrDLsUWAvYPXRiiWLLY9GuYnKAuafc9Bq1XOLhq4jhbgQ9+puqG+V9vOYyh8p43mueSF0aGC+JAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10441

> On Thu, Jul 17, 2025 at 11:30:14AM +0300, Wei Fang wrote:
> > > On Wed, Jul 16, 2025 at 03:30:58PM +0800, Wei Fang wrote:
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - pci1131,ee02
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +    description:
> > > > +      The reference clock of NETC Timer, if not present, indicates=
 that
> > > > +      the system clock of NETC IP is selected as the reference clo=
ck.
> > >
> > > If not present...
> > >
> > > > +
> > > > +  clock-names:
> > >
> > > ... this also is not present...
> > >
> > > > +    description:
> > > > +      NETC Timer has three reference clock sources, set
> TMR_CTRL[CK_SEL]
> > > > +      by parsing clock name to select one of them as the reference
> clock.
> > > > +      The "system" means that the system clock of NETC IP is used =
as
> the
> > > > +      reference clock.
> > > > +      The "ccm_timer" means another clock from CCM as the referenc=
e
> clock.
> > > > +      The "ext_1588" means the reference clock comes from external
> IO pins.
> > > > +    enum:
> > > > +      - system
> > >
> > > So what does system mean?
> > >
> >
> > "system" is the system clock of the NETC subsystem, we can explicitly s=
pecify
> > this clock as the PTP reference clock of the Timer in the DT node. Or d=
o not
> > add clock properties to the DT node, it implicitly indicates that the r=
eference
> > clock of the Timer is the "system" clock.
>=20
> It's unusual to name the clock after the source rather than after the
> destination. When "clock-names" takes any of the above 3 values, it's
> still the same single IP clock, just taken from 3 different sources.
>=20
> I see you need to update TMR_CTRL[CK_SEL] depending on where the IP
> clock is sourced from. You use the "clock-names" for that. Whereas the
> very similar ptp-qoriq uses a separate "fsl,cksel" property. Was that
> not an acceptable solution, do we need a new way of achieving the same
> thing?
>=20

This an option, as I also mentioned in v1, either we have to parse the
clock-names or we need to add a new property.

> Also, why are "clocks" and "clock-names" not required properties? The
> Linux implementation fails probing if they are absent.

The current ptp_netc driver will not fail if they are absent, and it will a=
lways
use the NETC system clock by default, because the system clock of NETC is
always available to the Timer.


