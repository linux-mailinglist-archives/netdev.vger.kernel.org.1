Return-Path: <netdev+bounces-216767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EE7B3513A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206003B18F5
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E738420125F;
	Tue, 26 Aug 2025 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="McjQKNF3"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D481EEA5D;
	Tue, 26 Aug 2025 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756173012; cv=fail; b=B561WPd33lkQmXDOW554dNQ1YpRIfV3uLOMls6jd8TtzgBeF0v3Oa/UgQxreRahNNlx+YmXluFdDgr3Fp/iTlObFA52PLkZ7t6KFGyfOpe2ggMvasG4AK98cRutX7rgg1GkI+jeiw6v/Dj3XfDxXpIInmab0HaspqElJrtSRA/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756173012; c=relaxed/simple;
	bh=lXYNlz4ktRATGGIn2hB0dEl71mlBFnWWAMKoz4vZkbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YdZh6Yt7JdQ1cmPJc4LUXLX6kUwFLDJxXeYYAtHt/phwI5xO0rm3W0tcR2unDlfwGWafGGu/Lw5L/9kKWUxNJJr4esg6+6e2ZCYwBXOWcTpeTo9UhXx+0Ea9WKAPLufuKop+r+1cNgI4hptgKzOHvlK3ux+01nPg2PPtLQs+2RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=McjQKNF3; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtmyDG9F/gBlYnNuGENcDOU95zkRtcneVRNjs4R6KR//RDLWxnntPgMH5egJCe2L3AsNtDNOmyRIorAdK+cxqFhFKSGXN28YNWKzrauzDXGgZWw4OiHQ6zhK+Yn8MMKUL6uCuOMO5iIp2yCcqHD278YuXLTaToXq07ByxiVtDucyuDOtOIrhKOwAghbIm9FUB+W3UT68HPF231x1Zs6/1TZRqOB/OCZmekJR+zzLOnY5Bxy85MrrUU6egg2S8hreF/9NKBzhO2OswBTtgtNK9s9izRUc2p/3P0c++3t6gBKc5e3GtPGn2ZDzNcsBp9kAfyBWm4cCbx3yOR5qDmEtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXcutSGMYsCkEE8NHiu38EeoEyPKuVyQhasGW6b7t8A=;
 b=Wrd4HD7qDfga0j3ywSmswCMxLUd4CTCmukCg8kIveZTXNa0yNceB9fQ+01AMo3PRJ9LpzCYEAN/niiYvbMXgG5mPCi8GAsaOJg7MqEeW2UXLAYFXRvLxIytBVYJUlGLMZtTeWaGP5b00sgshBnk68arOQkelQ9Kku5qa8v3FHpYzPEb8itBioAjVW73tqHXxOPYkwhF6xQjQzWZWuEhGOlIW5U/jzbp27tyqmWhxuLagZtV1NQmoFmld9B0dmbq4goTzrpf1T9KylGfWKchvx3fxbQIoEUhwX0qItJLD7LIzXpJ564n1+Z9JIKHDJu1fUGFpehtxTlZQpkkuVWViWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXcutSGMYsCkEE8NHiu38EeoEyPKuVyQhasGW6b7t8A=;
 b=McjQKNF3fDfFzmDKQGGlO7CxkARN807Xq4T4zqqV1yWNxOVBzHAI0fgzXvKueGQ/k87kzZQI/REviU52Msnu9GhNHFX4d+V1i0YgYm5morHYj2jc+jyRmMpig0JQ+rr1n24DTPmlFZnl5BwBKUzUrqcP1BJqXiXZGFl6dAy6vW1xQsw2LpkjIal835EIDJUcm1emHJciS7iqXP2eov4w0BuETyvtg4aA7mdKprD/4JUn5w3lV6h3/RaF8aUT8AjIRr9cIlI1Y1AABuXiD3oGO0WVeShwYWHvd4IzOBbXetLrMj8eC3O07wXx23kviEV4eKgA3nxSDoSY6zjnr7ybSw==
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by GVXPR04MB10612.eurprd04.prod.outlook.com (2603:10a6:150:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Tue, 26 Aug
 2025 01:50:06 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%7]) with mapi id 15.20.9052.011; Tue, 26 Aug 2025
 01:50:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Subject: RE: [PATCH v5 net-next 08/15] ptp: netc: add debugfs support to loop
 back pulse signal
Thread-Topic: [PATCH v5 net-next 08/15] ptp: netc: add debugfs support to loop
 back pulse signal
Thread-Index: AQHcFXnupsutikaYzkuyKhdvIsZEv7RzTtCAgADcFdA=
Date: Tue, 26 Aug 2025 01:50:06 +0000
Message-ID:
 <AM9PR04MB85057F4330081C86176805E78839A@AM9PR04MB8505.eurprd04.prod.outlook.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
 <20250825041532.1067315-9-wei.fang@nxp.com>
 <13c4fe5a-878c-4a08-87df-f5bb96f0b589@lunn.ch>
In-Reply-To: <13c4fe5a-878c-4a08-87df-f5bb96f0b589@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8505:EE_|GVXPR04MB10612:EE_
x-ms-office365-filtering-correlation-id: c4ee722a-5a94-49b0-1701-08dde442e1a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Q22T1o5fh2f490i8fi+8M3av0ikMoM75yeeaIMdcHBDsMvPQMIhaMiLBigSZ?=
 =?us-ascii?Q?qXM0plHuuqmNadVoERwAei5k1OlnVEC/rI35pZsst07rdlLHqvgcSEXf5cET?=
 =?us-ascii?Q?rBNwgBcKVTydeM3mSc+JV+DlVVoTCdKtNEehxJnpGHBJcLlYZsDRDdMKbFUn?=
 =?us-ascii?Q?gJSJB6mt2tm8o2VMGRC0YdFEBraH4GrBv3Ae3gD9R/RLpIxxubbkc8uhWOt7?=
 =?us-ascii?Q?7WjevmbeFZbMhSf3578YwfZ4qMTrGzRoYEnBOEgTZYhlSHzunvt3/+e46GzQ?=
 =?us-ascii?Q?ediiRs1/SYVCa9UYtmonoIoXf5e7QwQmuaM2SXnJ+PdBFsi2Q4KrPWmtckrR?=
 =?us-ascii?Q?hcPKNIMOZ6hq5zcwBRi6+f1/Q4xTti+wmi3j3VitKp8yM0EaDcj+AL4rMJH4?=
 =?us-ascii?Q?lcovyscXc60Cw9jnRt5LrtwiFzuAO9WKL1iVvpR9Ine4K4GGSKuOrOeH6BEn?=
 =?us-ascii?Q?lyCIGWVo/ryj3yjhERPXdl1BDiD8GLmCLC0/+WWdgqvZTk8tnAkT723WEPaj?=
 =?us-ascii?Q?CdXRGYacpwTlUEBqHr2EeKLGOAABv/gigVNnNk1XVji8qaw0puAvX8t+72Fo?=
 =?us-ascii?Q?BQg3ELn9CJXjaPq+zlr58lTlUoS1HZ7I91Te4LdgEg+9xtDF5Zs8ibrZtRFO?=
 =?us-ascii?Q?YVxKgFdxfopJV6EsUMazbVdmAhDteP5uvZnJ0n+YFl15qYICH1br5jzsZtwd?=
 =?us-ascii?Q?iZUo00v+wKb8RMyGiMbrCArEiRbYf1w6fNgUelo99v3E/Vng8p/UYQBssBqD?=
 =?us-ascii?Q?OEnAGeIgA7gCIvm4SbLfdqTyXLlx1EW7/nEvH6uy9svdPNOCBAwcBJee/Tgq?=
 =?us-ascii?Q?rpEZtKh8nRv+Lt4pZqIVyK8b4VPNrFtwNafzuMcm6feGGPfEsOdekUf+nXcd?=
 =?us-ascii?Q?amvJD+Vk36C2i+M6GqTofuz3WrKzzwDxXM9Yiam2ABmsaV9Hf/fdzGOYdp20?=
 =?us-ascii?Q?KyUHGdMiE0KR7uR+MS+/T+1vk9PJ4w33KMCZQuTwXZgGS6ob1Yu4/+JLw+sP?=
 =?us-ascii?Q?w7QWgkdJiJnl67/EraJs6RlG5py1WE38bEhstE1DQleZQuKTd0bccLigTbP2?=
 =?us-ascii?Q?I+GXs29irmIWNeMtFjFaydThvP8twEeX4NhLvHiJBRoO+d5BSTCIOQGXx3gi?=
 =?us-ascii?Q?UoSvhfEp0XPIufpsL84S16jCD1rU2GwHRG/zR5A1AS3f69mLhPSVErwaMxNT?=
 =?us-ascii?Q?mtMS4PsdbXpO78U6Z0H4N1XDy11cxhrxNCmODlYsX9OQQhNqS9IlfhiGiCgs?=
 =?us-ascii?Q?a56zyWtk7deRrf3fWAYRd6vNnmDhiONoKV9sCmsY850P4jXAWlSzYp6vBr0r?=
 =?us-ascii?Q?P6+wj1ijUsTZwTzieikuybHM29zmB40xAnhUa1c4jUww95QHHsFEPA+1TCDI?=
 =?us-ascii?Q?bC2Yi0K+aEgufw4LDkn0vXaX0QgEAty6Sd139vPyh6Ysu35O3BORe5kgRZUb?=
 =?us-ascii?Q?7C0GQTmxufvboGmYIihlZ3Vx6RtlRc99UbXAwMt678Lpv64lU2nkZw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UlEqMhk/GlRdFctznq9+JayfTCx8i8vAlVLZJRWLta3X5hC17anJ0WcxqrW4?=
 =?us-ascii?Q?zwkuGDo/x2ifBJMrYLg4/2eZ4xquQEqpVcIylXCvcNL5Fb7DEM9HaCPR9BQp?=
 =?us-ascii?Q?HWhJyrySrg5I3u+f8h0MAQVmvmT1mYWLyIJD8rOlYcaoCFQKkMpWOKBNnEVX?=
 =?us-ascii?Q?bQ1Vv5HD/XHQko5tBupM27JRlFT2r2DOE/XKaOertIScuHar65pAaAHuU+sQ?=
 =?us-ascii?Q?Ez4AG2V617j/Z90SsJY4kc7Wi0l9lRiCiNo/+kY/6xKLBKNR9tn/oSoieFks?=
 =?us-ascii?Q?j3De+RDFBtXWyBazXsQBqNbhHnDC4dNlkM1xmd7vES+3cwQ/w/df9DSdpJzM?=
 =?us-ascii?Q?GwZrPd0AfFga9KOvEHGSr53ZAo5VtZGKjpiPanlgF1/6/+o9G4bvHhan298r?=
 =?us-ascii?Q?5+Q6k28QZdkL8nHhCX2i1LHziUqjRqNWwyo+TyGwUqSjlvuo3xAUp1jB24Tf?=
 =?us-ascii?Q?7o9fjd1NhV94pqgbFbuChO0e9TEy2ujEX9YVrEKOsDyA35d0N8R4Bxs85BtR?=
 =?us-ascii?Q?r7Rejsa+ha3OO2wa+e7KHf+jJxkB8sQC6DN0ASdWw3ITNtzu8jaLa9O8cwqR?=
 =?us-ascii?Q?8gIdjQUl9U2oDZ/lXU17AmeDf3FUGvtsLJAsOj0Ad2+9RWZ/T6sUD+MYM6sl?=
 =?us-ascii?Q?3anhGwuoWcJKR0nD5jUyQpB/Ivx5d8AFTJkJ0fbnhwcNZBAlXohgUgLE1QjY?=
 =?us-ascii?Q?iTbJgQw5CUr7Ncf0WpHT52tFLzxc8r5seOQZKyKF11WjqO+iCN5eTROrD92A?=
 =?us-ascii?Q?GpXqZoUrdG9ykZNOky5lJL1Fv4FUTzdCZuhwu8Yzg2nj5WB4d+hgqEO//56/?=
 =?us-ascii?Q?8KufavuVg1B84BcXlKGXOt0Tmwb/+70ArZcVE/IDuR2yamJXSOeHha7iSQVV?=
 =?us-ascii?Q?40oydjy9xlvEIH47uTFCCGhVEYLi1rdBTasy/lPgcxbWdbYR5h512u6LuBiK?=
 =?us-ascii?Q?ZsNtg1KdGE1onC+0DouOisTuCGdHDWONCvZjC09TW9apfpNk+3j2PnuzPF1k?=
 =?us-ascii?Q?VY64itxJcLJhzmfR/zpb5FfvfBUlM1JgO8/ZWLjt80TQR3C3zIUbtD058qmR?=
 =?us-ascii?Q?NQFi/K1f4iI5J9b9DiaNzn7I9YQMox/RVb6rC3S9XkEdATv8jVCDuywT/M7Q?=
 =?us-ascii?Q?fteoyOSqlx1xNReq+h+Ooottj851JCYYJd/W/TNw0AKBVocMNtNDp1qJuVnY?=
 =?us-ascii?Q?2K/Q3tPREcTNku5nVq/HKATtEMh9V2Um+9Ew1sKviQIhLoTKAiSCTqsevj5W?=
 =?us-ascii?Q?hTKUvEYTow7f7K0V84KWam/GAhqQdqUCKmHdMe5CP7D9n5Hs8EfrNBDum/2C?=
 =?us-ascii?Q?LDscgMJvs/8dhAS0ih+9jp5Jj0vJfQQRGi23Inr80RIT1/UVAX53byJYHTLq?=
 =?us-ascii?Q?Nc3Xbx5sgNzAGUQ4nXLc2prAGXzT0FP9vjjiQt7ZFxGndaaOJAi1njIMpmUL?=
 =?us-ascii?Q?J8Elvg7dV5EzTHyEyfc/CfHjTET1U6/iaXtZSAs6VW5DNXObkperE3AWmnnM?=
 =?us-ascii?Q?kXJlwa6w5F1lCYea7WYuJlOyPrIReTssEbEaNltt9tTQ7KKivn6lUHnmQmwG?=
 =?us-ascii?Q?Xca8ootT+M6/Yu13ZMg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ee722a-5a94-49b0-1701-08dde442e1a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 01:50:06.0490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hiFoqyiCxjZVtWIIvmjEtTvTHr46jv4vFwgFDE5OQJLeB7HebUq4tMnkV7Qj/En2Pxoxh8A421b2/eiq+uzqEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10612

> On Mon, Aug 25, 2025 at 12:15:25PM +0800, Wei Fang wrote:
> > The NETC Timer supports to loop back the output pulse signal of Fiper-n
> > into Trigger-n input, so that we can leverage this feature to validate
> > some other features without external hardware support.
>=20
> This seems like it should be a common feature which more PTP clocks
> will support? Did you search around and see if there are other devices
> with this?

Actually, the NETC v4 Timer is the same IP used in the QorIQ platforms,
but it is a different version, and the ptp_qoriq driver is not compatible
with NETC v4 Timer, I have stated in the patch ("ptp: netc: add NETC V4
Timer PTP driver support").

>=20
> Ah:
>=20
> ptp_qoriq_debugfs.c:	if (!debugfs_create_file_unsafe("fiper1-loopback",
> 0600, root,
> ptp_qoriq_debugfs.c:	if (!debugfs_create_file_unsafe("fiper2-loopback",
> 0600, root,
>=20
> Rather than hiding this in debugfs where each vendor will implement it
> differently, i'm just think it might make sense to have an official
> kernel API for it.
>=20


