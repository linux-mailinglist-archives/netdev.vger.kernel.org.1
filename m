Return-Path: <netdev+bounces-217580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9BB39180
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4625E17BE16
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E5E24678E;
	Thu, 28 Aug 2025 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c297iUeJ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E373A1DB;
	Thu, 28 Aug 2025 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347024; cv=fail; b=fAZD9oBCHvHjN/PefOU6jidNBkshNXEkCzk+RcOoMMfUj5ctkshXeTvKbHOELVRt75SVXdnkifRzPEY/ZECqOtKo4MNojx+W899a8QxwrhGIcMGomUJOgbWPqtEfUbmU6qxhQ9ON0TKq+zw9FZW8gcPiSso98hmtkb5KkTBEiwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347024; c=relaxed/simple;
	bh=KM6tNTO/2nSQWtVdTV592vi9UIAK1LYO2s8P5gyN5Kc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uoch81xmbbeFSfKtuUD9gbNdtQDu/QD5I9eh0U7iVbFbNh1xknLeOwlZMssvVXetE/JxzfCt6me1JhnBpk5j6kPWu2A3ag2lAE4k6ZvHXoaFpHvsSgtFVSv2TzTfIC/3ub6rt7c0hHIkMBz/dg3m5lbcOK+LD1gpIhtUqtgyCeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c297iUeJ; arc=fail smtp.client-ip=52.101.69.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGrNKxOwvF4UHlpEiXOSi2n+S9V41emaJcBao7wgCL9MTXkJIjy0yQbKBQWnXK9AwLFB4govN2KkVrepdXHBGq6JsnDAmHyJEZMMLeRR6TB6t58twziPBgtx+cQ3HAmG3aN93g0jkjaP5nMQLC7SLzUNYNZkbLnFq2iHgLYg1dsNzQqd86wSNhjUsa5bd8cGmFUgwr0vX1VbkS/7K9sW9IYLfEq4J/yTgoMhz5M3Ej7QXyf6scDknWIPiKowjignMZ+MUG8X/jkby3R+dU3R1QxTPqlAPK79VH6I5088E5ofQKo5qqBPQWWQ2sgnJX2ov/Vka20KkT+cAH4E6YCcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KM6tNTO/2nSQWtVdTV592vi9UIAK1LYO2s8P5gyN5Kc=;
 b=eM0JpobdW1Ue2S4n2dMWxmQ7zRfYG9fovqhXc/VwBrnCVrVC97wu3fUCTzQ68ACf8Vd0G9HuXZ94ZFNbtKy8TgohjgLNFt0lRHi7biIN4gasX0fjNT6hBIxJMjvTG+WN5f+PKbPRecRY8XTqBCcTt1jpirK5ObxafbfkJDYNk0E3XC41Hi5WllGYaQBT9QBTXTxAvvlihRHIUMPNauVVL3FPtB22b5YUA2IsMOJrwd3ilAToHjPYIkeaPV4dZVGyNhVooulmRujS+h8wQu2n50P904PuE0JgpWd/B5d3HMuYvjqoR8xvxDgcTjnSTfyXX3Y0xneL+pX/RS42/+0JZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KM6tNTO/2nSQWtVdTV592vi9UIAK1LYO2s8P5gyN5Kc=;
 b=c297iUeJAWqhdh72XV+W8yCk1QkOumXUaToACweeT4zSHAW9p+8wzulXmLdYC/k4TL0iEliPIB1XKm4O+CybzynMdpUunoCWjnUlRCxbfg/9talyZv35wS8Ishdi2exzwHYJHnMZf4qK38gNMQT0wzykDS4eIwZE2r7zUfXif2/THuX2YHzcfvfQhO3eX2ingWpEHTpLlJPjoOP8EXRKLTox+bSvysCLfvOpnb9RR/pt9SmhXAlWFzBgmuqlTBU9KmhJM/fTsJSvoUk/xhpADZUC5GYd4xYtddGE1hb01uXQrL7o5W1Njdo11vUjwyQYKsbd2aYh8oofAela4NluAw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9781.eurprd04.prod.outlook.com (2603:10a6:10:4e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Thu, 28 Aug
 2025 02:10:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 02:10:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	Frank Li <frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"F.S. Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v6 net-next 04/17] ptp: add debugfs interfaces to loop
 back the periodic output signal
Thread-Topic: [PATCH v6 net-next 04/17] ptp: add debugfs interfaces to loop
 back the periodic output signal
Thread-Index: AQHcFx+Knn/pg3+vN02ZJpsUqQe/U7R3LzqAgAAi8JA=
Date: Thu, 28 Aug 2025 02:10:19 +0000
Message-ID:
 <PAXPR04MB8510C81A25673E40A1C2CBFC883BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
	<20250827063332.1217664-5-wei.fang@nxp.com>
 <20250827170017.455aa59f@kernel.org>
In-Reply-To: <20250827170017.455aa59f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DUZPR04MB9781:EE_
x-ms-office365-filtering-correlation-id: ebd207a1-5398-4a37-df3e-08dde5d809ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|19092799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oow7LmK1I+zEhbO0tcBL2y6Ecxk+1xdvjqKtBMjPVDzDXR9sn+W7JKQNGr9J?=
 =?us-ascii?Q?Hi4DnYd3V/G0IZwwTihaFhEg3VPL7/XIXITYU5PXOYrxkNyPsRqZ7DUYVLuM?=
 =?us-ascii?Q?X5U9/AZcKVWpiIDWa+UdJTXjpmSA3BPtOYc5rmLTSu9WfXSg+QF2ea7LeRIy?=
 =?us-ascii?Q?1Qo1fOLZWfadnbXbmp8Bphvr21g098ZajMmvkiQPQC5lR8ycxJcZvn7HoJaj?=
 =?us-ascii?Q?zFuMRCvxdVBv1oh7ahlBGnyINOo+Cohli4gL48/wqJpAkOPBkLfKKAD3+XIu?=
 =?us-ascii?Q?80HhbMZK2WjGdlrvhq6EBZ36f5kAYZIKv+mKoqO0SjZSmu+OAs4oLEhlD1Rm?=
 =?us-ascii?Q?UK0GoAdhi9uxeK99hxyDM752WUzOJ+F5RDt+XmBel+X0uOW/IxqPMBHJc9MB?=
 =?us-ascii?Q?uRlFALETPOOGdurlk2dgGizRf8aB33cEOKlCXbFkjKaLDo650Wea/1GHCL/4?=
 =?us-ascii?Q?fQgBseoUDMyA2CUd9tdZcKxPT4QxagyLt6qJDjpG1Vc/mRjN/W4k4Xv9wDGE?=
 =?us-ascii?Q?an72G3grToiWkxg+uH8rQnY3sedldXWn1/5nrCkPIVA9N/wEL1HzuMKycvyx?=
 =?us-ascii?Q?mGr8tp7VVyeN2OTKzQrOS6NBaYOq3ZbnwGR/i4dmGXjhZs6+sCuq5jxFVa/a?=
 =?us-ascii?Q?U+zAwdg9UXifvitjEgfb2ILBnfWjf8kNBz6lNuusl4wlY5R61ehGxSYll66H?=
 =?us-ascii?Q?bjwetBxcP3vuf1WDUdh8m96NYYY+L14WdIsel0y9aHi59/iwC9LnQroYgsWt?=
 =?us-ascii?Q?AXnjJWerVpKly4SPtjNNXsNvAvc432C4ZngzYUK6D1SCeZ3IY1vnYBO4MNGY?=
 =?us-ascii?Q?58BBhIF65hMIkSDA3hh8TOlpw3x1TZ3AhxXVGBNnUPB5bSSsaFFAMKf7rg53?=
 =?us-ascii?Q?dgF1iI5n0aLOGnnMhNv4AM64wngJjFpfDLrpTc4xUpWlBEmAcSnREEw0SoQF?=
 =?us-ascii?Q?0BOousPLdYLsW5mR5lY2fYNApYapqku5qud35t59GNUDK2w9KqkX8wfAhx4b?=
 =?us-ascii?Q?s/mFs/72jOtQDgcbsJp2Nmp5yqZp7Zt9LTM1TwdG3P37NFSNCYG802apP5lx?=
 =?us-ascii?Q?/cznyXvCCXilBVJBMRDPnlIGlWczlzScDPzL0ia5yVNygU4SaKeQUkK4s8Q3?=
 =?us-ascii?Q?7vAUgxNmeBbHzyaUo2Wn7KnAjdfJMdWCV+P3sZGDJqbrolwv63oI/tAFI9Ub?=
 =?us-ascii?Q?KRFh0DFOh8cz9IW0/ilFX13l4lR0aJZ2LxGVP2r+2jPAzcVc6WlU7j3W6wPr?=
 =?us-ascii?Q?s/0c6qisQRlqNBRUCR2Zx7EWpJHEyok976ejEiwLHh74fpHY6PGSsNJdF48u?=
 =?us-ascii?Q?Btc1Xfua7lb8w6v/0A+YOhXEva7a8s2yBM9vAZ+lF1UdFi6WLja7G8q3oyWU?=
 =?us-ascii?Q?R0vtVFbGmIa9aAouFN2BLQlSyPMgfvKLET3aoi9ZvS+leQaT/GIONcDaTGHN?=
 =?us-ascii?Q?ejMmLjNJZXXsAYWfd5/yrRIyACkDFTaUqLmn/m49WSz8gkMXUH63vg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(19092799006)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?y4gvNZaF9aTv/P1LKKUqIeVQGYsGKvF8jr2jc7S2JojnN9V1nWshIeeHQ/Sc?=
 =?us-ascii?Q?NE4pHo0DM1uXkPrrnzqe6T8ftKBYHVVXkgv6v2CbhPvxKAtTP918K8133nY1?=
 =?us-ascii?Q?rp2RQEzGHCO21DDJJ8nJzppcK3QqvL8EBPzjuSQnzqg0tJrFNZ4NVwK4Qaq+?=
 =?us-ascii?Q?wqoxlqqAbld2Q+sE1/BQ9zBKatrOntsPwbWKBl6MtU2/VprjIAEI9ffBOuds?=
 =?us-ascii?Q?M9n8btxJ2XrRr2gUs2yvCtR/nXciOvrMS1+MGH1AhVo4jvbeZNvwFP0sFn/9?=
 =?us-ascii?Q?IvgltLzxdflYDe/R84TQoHYsuH0a9yH/dOsX37a0IgxJ+cxMEUKp8ctLPTpU?=
 =?us-ascii?Q?a9CpSYo03XmTa5d57F1K2RvwASInpuON3kMGzkXpU+mzYlFBOU7nnDBvDPxb?=
 =?us-ascii?Q?kfP4rCVLP35LSsw3T+anUszjqIjb1rWYNkq5YOTltTCSEjHMcjCuNuOCELWF?=
 =?us-ascii?Q?z0oB79EmB8N6Rd4qjkCAlRu77sP0FP56dJgc2veWetUbkkQuNuIZ4uXlyaLc?=
 =?us-ascii?Q?JWTBDpgMhCTvp5vIy/lRp4Np1/WMkma4/OzgfBkZR95g6ccBJC9K/KFLSv9Z?=
 =?us-ascii?Q?EADerWAr1NeIXgHqgPeKN5VD3IL75ptLD1yi0lGdHaAlvA0zmS2u/oWiuF0o?=
 =?us-ascii?Q?VxTahmBQztxKS2FFp8q7UBBhXOWd0qMDcyWRe9/1aKuy24OgZEx589f84Jsa?=
 =?us-ascii?Q?zMcufYDRD8X19vx7RnZdqKVdTELbt+D13/xbDev4Zq0TzVWn4uevTN/N9pF+?=
 =?us-ascii?Q?Ar6gm8w7ne2upRTrNf8Ao7V1s1uUxck4MFi6QxiDOwwmNBYsx/QeCfNOCXuW?=
 =?us-ascii?Q?uwjzFGAlMGDfGaZpLCoT715bbUHkQZXOiFqF5SlO58KF4eTE+WTThJhTg1GG?=
 =?us-ascii?Q?MeSZrmsymmBzaSGJXN6fYlJJY6qZWxkXt2VUXqDTCC8CPIWqdYX3atOZGTN0?=
 =?us-ascii?Q?+uB9eWUfCUc1mUJ15rJguUTmoja8+dBq1YwInKUuRSn+em7TjLf5beYT3Ozd?=
 =?us-ascii?Q?BurSC9+RuT1O4xR6+e37qiEDnDMZEC+kdQHbWBgKqY9j8yLvjQ4IFuvuiMzn?=
 =?us-ascii?Q?3ryKF7bsK7TekPJXBB3HVqpuZ9rjM7YixV414x28/3f5OP2CHXEQWPsRfeLB?=
 =?us-ascii?Q?G4jjkUxt1o+WJlRqZxdQTeqmk9UipdXEjvXLgab6+dJutDs2aC9peEfFuBs+?=
 =?us-ascii?Q?77ucwgSE358N8i2qESwWkX51cNX4DRtKnahG60n4jTlQWW+4rQQ2+M/zLPMQ?=
 =?us-ascii?Q?fOf6YKwPPh0al+ks5q4Pt6z1ByViV/nYnBI6btKOB5KdgD4nIyvwcV84C6ge?=
 =?us-ascii?Q?9h5jKftQEATt+27Q2zq5TEBsyUEwu8DlKsfOWYklvVmLpw/J+Qs4b/rUIdq9?=
 =?us-ascii?Q?Lw1S8Dkigekd5C27roipGSGWV7GN+EtO+t2RJGJfcuwIqMZd3x5q74eRUe/N?=
 =?us-ascii?Q?aO+2TjWmmyPa2yFpwQ/CFMgpW+rkMaZdwN2A62JuCMNWU15eYg1d1lvztXhS?=
 =?us-ascii?Q?uWKp33honeYTnWzZ4YjfAL2lj0Y/Kjc76rTNYiJsW5IhWFFhgxqR0i/3j4Cr?=
 =?us-ascii?Q?AYudmwIQILhppuTmfYQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd207a1-5398-4a37-df3e-08dde5d809ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 02:10:19.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +GVEHYefR9ptl4w1sfq2hyJwuv6ufT+ybiQUJdUephcw3zRTt8wuHqtzZNrqT9g1GZqMH1fNlXux/G0Qg7Bfkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9781

> Please drop this patch and patch 17 from the series.
> This one because it's controversial, and 17 because it's not for
> net-next. This way you'll be under the limit of 15, per:

Okay, I will drop this patch, patch 9 and patch 17. Will resend them
in a new thread after this patch set is applied.

> --
> pw-bot: cr

