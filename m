Return-Path: <netdev+bounces-143648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469419C37A6
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 05:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074F9281755
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 04:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE089145B16;
	Mon, 11 Nov 2024 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PPAkrrHN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4DB36B;
	Mon, 11 Nov 2024 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731300944; cv=fail; b=nrN//bcYgsVxpgbFnnvZZxiZjCySqnYvkv3iskbUYtEhQyx+YhAp7jzngiSttlTo1Alof+7RtOsu84CVrh9CvKTsS9wLCv51PnB3GoR5aOE0aOMU5BMPnIMAZurxmkjyc11gcF2Ke9MuUmj9ag1d+BKgYeRbR7BfZX3P7z2C2V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731300944; c=relaxed/simple;
	bh=vmgAZKSPPe1KHqF9Bbyw1cgbGMPAZxKrD9mF6oaHCaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mklX52gPIR30v4/mQIfqwN2hKfdOHO4VejXuV7omv46UozyRCAYvwo+J1Grq0BKRKHhnrgmaV/kBiQ5JZk3mLvqBtUXGdEaOh4xMbUzizpQZQdaTwP3eDFOZqTNsMcp3KKqNpoWVnxuVqCiP6YvSv5pOZnHuVgIjAD5tBDl/Q+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PPAkrrHN; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LioR9jW4x+H/FI1UhQrp26wng5oEmleSCiwukzSHnjRo4raPmOjTjlXn8wQHunT5tDEql0MaTa9K16ccZWEZJ5qDcOmOp55wOtIzpnUbza9fKzY1peqWCXBq5PnRM2kNBOJwGAEuKcr61Rg/eZycPI03FJeo0KJDPW+kpEXfsdfaBprSfH1GPN9Ep4y48z9YvUyYGM95QZJdlo1EGlV2neL+L4iue+u576gsyIbv0hHqnzADFiAbHqr4pwDOi0J/qk33wxLOlJ95N1aPtNAPQvNKAxdBDpHl3TP5VpwRbU4pTMXlD8/aQ3xZJR0p1K5je1vfW0Qma/x0Zmo5wwLUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAYIvcEKdJhbQUDt2bNmpShEQIVCTMJk21tGQ/Ppi90=;
 b=un6+lEMY18xqEMmmjXDxgHfA8XJIIo/lXx24KzrkqMYAp8S7goM9Tr2RP+fwZvHYqfCBhi+9Xn/DvQC3/HYoSXfxrthyaWMHC2nhXF052WfQm4WVQKjtkp06OzDrk0dUfYvDJfFUjK+x+7cuAaTopHeLZReFoB9S0sUwlnR/PgyVPBZnyYg70zdFG4D22/XZoxB29d/Fks5i0RvHH5OPdQ7psaCkEc56TQv/mKhsQlcWNNFdJAlmtSs+mdwoeVO/tnvpiCwGwnu20iRsB8xjerRA3xEXVOR122+SxqsBRPytDxwKfTdB92k0mSGYjKmxyACqxNi5H9sD2wMaLWX5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAYIvcEKdJhbQUDt2bNmpShEQIVCTMJk21tGQ/Ppi90=;
 b=PPAkrrHNlO46aJQrO5MYQGP4uXpKTUEreYrbLhBNVhfRLZKFwL+wMQyzFXXONDav5/JmeTwmFvvVKVNKmuF44BKwIW/JYrPf/XAXSC5Mcr91kSrBhgien8Em74eFlKJrDSE1G/gqwM9HKrtv3nPo2VH5lhuQz3Fzrt9kiIImmrku/0vjNgdaMn89NsTJN1fMimkafSghqvovyyOeG4LEE0dzX975aqc7HmmCDr/Ws/Goh8ZnILOaOPWdopu9hlP97fWZaiuCd7efCQynT6Fx+cxpAktYjjNnmWbcvdGv0YiKy5P5raPmNUyf0qLC9behQdiTGqHhZTmr6qxPR/mEIw==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by PH0PR11MB7709.namprd11.prod.outlook.com (2603:10b6:510:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 04:55:38 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 04:55:38 +0000
From: <Divya.Koppera@microchip.com>
To: <horms@kernel.org>
CC: <andrew@lunn.ch>, <Arun.Ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>
Subject: RE: [PATCH net-next 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
Thread-Topic: [PATCH net-next 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
Thread-Index: AQHbLpkWrdnKmSHQXUG8Le25x25K77Kr5v0AgAWnd/A=
Date: Mon, 11 Nov 2024 04:55:38 +0000
Message-ID:
 <CO1PR11MB477123139348E2384FAC4BAEE2582@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241104090750.12942-1-divya.koppera@microchip.com>
 <20241104090750.12942-3-divya.koppera@microchip.com>
 <20241107143404.GV4507@kernel.org>
In-Reply-To: <20241107143404.GV4507@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|PH0PR11MB7709:EE_
x-ms-office365-filtering-correlation-id: aad88e10-824e-47e6-f3d6-08dd020d15e1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DkCUaoUA4nTlLy7ZyAm8v/qqpUnwXJdaT+EBaKj4/AHQI4JVwhcq3lL/J3iw?=
 =?us-ascii?Q?fUslJTaxmOFYsmkCNlhMVUqWrl55k+BhIG3C7nBbQFoRLfm7DhBPqMGc3/UN?=
 =?us-ascii?Q?6dLlnK9UlJHWIZbAGtnhA4vAkRpa3h6VsrWDHtOQ7lkQBbu9k3CjGDwB78ij?=
 =?us-ascii?Q?U9fxiYjGnUFDrBmgKW6EikfvPrsHAj8XDH+0LGqpizBwoy+ZayFstc8Q86GQ?=
 =?us-ascii?Q?Sv7NKZ828FqMa2y2IrzxGZS1NmxQR0KMR6edSPqidypXFQ6wMnG8TOOp1COI?=
 =?us-ascii?Q?TFJhz+xCykAcszjxf8SOclLOiSxMcpEIrT8AJcPmxMe39nljwiJq+XmEtI3S?=
 =?us-ascii?Q?Y3qrM1kP9SI5r8SOG57+iUm+n9CdvIvs+c9MbidM9DBWMxz1EsdaoofA6CGg?=
 =?us-ascii?Q?6Bvh7FkIxVWbH+4FxvW5CMgy7wfiCPN1STg0d+aLINYkyKTMMn+7x6cImV5+?=
 =?us-ascii?Q?kd2uE8nLJJlJ/OkkF6ZQhtfow5faq/FPjnzpSTmeZu0ACGP9dAJdG/OdcBW9?=
 =?us-ascii?Q?Cy/wBVo2bLpE7PSpmCqvvKCfGwbxjqgLC458Ly49VMcZxo4ZkeOoi9+faQDp?=
 =?us-ascii?Q?55EqjdbPaoY+XFMHDp1lxoO/wSyF/murq0inK5SKOI9B7nrl+udh+sMkmSuU?=
 =?us-ascii?Q?cqs0S/QQdgITJADBu77wNEhQXcJ6FYzSfHowkSrbO26CPNSVKwozZkX5R5gB?=
 =?us-ascii?Q?/DM8vOERl0vtSvgx5b8tUkiIWCx+Wm3p0/uzTUzi27D/Jk56X4D2MK41n0Gu?=
 =?us-ascii?Q?DOyC5oTPb/I6atSvvBtcN51kus8Jx5almMTxN2siFdA+bJlLHwzMfbySK6hm?=
 =?us-ascii?Q?V5yiOiH3iwLsFxkKdePpqsEgx6SMWZOTv98Wpk37+SPO48VRu2tp5BRucUYV?=
 =?us-ascii?Q?bvfIm7vHPlsmFnR17sYQn5K7LAv80UTtPGQgtempbRmrlXiltmBCSjneuCiM?=
 =?us-ascii?Q?BHCi2YsASPdldsfE8KHh7507/FVG5ew9n6QttWIUBskTMe2M3OQKYWgkRjYD?=
 =?us-ascii?Q?w3H8+9VwI0VjB75DhWeoAWPKWlWk2Jewp2DgYehdVdSQT9Jl3GcXVdwru9Hb?=
 =?us-ascii?Q?Yf2Y+NPbZLKdlOaiqW1oRKffBlo2VLBSI7y5xIDPykxZBYSO/9aqxFdUx3pz?=
 =?us-ascii?Q?MDDGfEu0KhdIueVdS2sBCt3s/1hucssXLSL1ZUz2aWEmMJOeZzvfx7DeT7ka?=
 =?us-ascii?Q?tvfI/+4i//Ty2hOqBYc1ptLDwu9elI/M4obra1sUoVMVZyIkD9QvzlPObA+d?=
 =?us-ascii?Q?2IvsArfA9lrxaM2axg3W3YteEIFzO0LkDkhWJs4z9X8tyUleI1pFs8x30LoA?=
 =?us-ascii?Q?8it5hGpyTfmEBkG5r1+yJBNFB215gPdZ7Ns3Bw76N/EtNbRQSksQAsFOugfW?=
 =?us-ascii?Q?ZrB0UHQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?J4S+Axsay0gJblC/O443jRQt0HXryZSPRYJx3v8Obr+g01NXT6EGmFsdTYWc?=
 =?us-ascii?Q?a4OcHl/RyLWuHuIaTHoBLtsDNaGJLA2Sk7/3+nfLLg2tkG6/QGNGeNfj1Hip?=
 =?us-ascii?Q?6/Knqbw9gl71tn82IyM6z5KFZmzAkM13VZvjRKtfYXubLApsJUvxQcd7o7CK?=
 =?us-ascii?Q?2sayZtVgC+3R+ydxIPRykcWhnxC2ks2ZjI/F7vIxZOC5YWUcGDAXuv6LbAmg?=
 =?us-ascii?Q?+Aot29+Yc3VCLTDtjB19eRNnyRLoK07u6au2oROwZH5XPOyiaANx8DJlZPut?=
 =?us-ascii?Q?w2GXhKb383vw8ApdMibtsZFRRSlGz7DaXOHkE67C3xSSF/fMZJk4g3y+2OYs?=
 =?us-ascii?Q?UAz31OisNVRT/mtHaV/wASuwgRTq2dbdJTshnC6qtjRUDlvMtPUJusOokarl?=
 =?us-ascii?Q?3nKlTMiRl9A3WBsifbKdCV6e0MOk9netP+LVTYUacGFpOtK+/+QT9Y9sHfax?=
 =?us-ascii?Q?WAdcVQffJDZlFnL0oxWmztpKg7d56tXbUyfCO/9T/6K7pWO5AXSkuok1FkG+?=
 =?us-ascii?Q?BjZbIAsnYCWClDua7eb83yYQbD1ibhcLr4/LB9jFMv/JGdaymyAfMAnF+n4b?=
 =?us-ascii?Q?cqAz1RZ88/YGDNU6PKjLR7oAMOxuKdDW8p0pP5mJvFFnjxldCZwJ3ZONORxc?=
 =?us-ascii?Q?qqSRGL57dL97fkHvQufDKNDgoDiuNs1o79yTQSmxLPHLZM06YP7wSo3N5dg1?=
 =?us-ascii?Q?7sX7WzJ6dRL2m8uYRQ1hHRL/8krMCPFA8f09jz9l3c2npaf9PaMzb1jflvaq?=
 =?us-ascii?Q?mau//wmU1O2MtIe8Efg4luD8S7eR7bax1C+/hj7ywPAYlLyo6IcfyAgqQYPF?=
 =?us-ascii?Q?hs62MsfNVGya/nykmAEjqBzHY6PnhRZ7VJ9QEr4kdfVLAh/fCqNuPYmSFXmY?=
 =?us-ascii?Q?5XECvrKp6/Y0Wf59JD955mBz759BR/z80uFR5IjEfk3+ps5E/J7AaLAO9Lf3?=
 =?us-ascii?Q?ju42Er0v5ah+Qa5MeQ9dDqmGD2/moqKb0xl+Hgzd+bS/JDfFXrqPytg63VAK?=
 =?us-ascii?Q?lVsnZCES3omUxFF2X1w7uTzgYq9gJhBEaaEs0IkNmVpamsbp2Qw5soDAXMhh?=
 =?us-ascii?Q?Pj+M1R0gt/s+cq0QxidMI0W8PFDQaYNdU3OHq8x392TOdCitOwcTCG5MKRRm?=
 =?us-ascii?Q?Exsx7U8VH44K7d6mjWAU8nN0JSyZEcJ0nuO2z43ZBKBibbcZr2Xg8iqmrVjz?=
 =?us-ascii?Q?8Chzt17ogdvBMQ+Oun1KGnhDVp3YBUoIO4oxVzv3usxtAptnMcVVIxi8FVCW?=
 =?us-ascii?Q?XvGwzmf7xE9mgJaf9SNyL/NZWysHzVVZqjvYHGWs7SnvWdTZ7pRUyoRoMqVr?=
 =?us-ascii?Q?9RvHIaPHL9uJTa7DyvIU8F4DvgjhjQBDTbXxB6bRa9Wd3fJhtmVOT0y47Wh6?=
 =?us-ascii?Q?narhII/QzemxU1oC/OmpDXw7BGKs6vsv69O6twmydJm9SY1nMtvG6i9MmzST?=
 =?us-ascii?Q?P/8mob3PvaAYUaQePmNDWmnRFzq3J8a+p1vwhtg9scm1UCJtXsxYsNpN6QgL?=
 =?us-ascii?Q?PSxcsbj9Xe4Xupp191CQOws+K/DiQHPRkaOydly9OguifWzTNZEOfPphBafE?=
 =?us-ascii?Q?wEwQAxux4/T29Ja9+yd4EY32iMWCqBDkGyC05fuKKNuTJaneiRT3GcZmhN28?=
 =?us-ascii?Q?Dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad88e10-824e-47e6-f3d6-08dd020d15e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 04:55:38.1139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6Gjn4JBu5/hXq5Xkb2p05yK3RHuLN0f8b56vq2uVECktQlj1FVxQZHLN6hfptuWD2ckWrvca0P8Nebg+qwi45DHZqeNV1CY7uSfWu+SjjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7709

Hi Simon,

Thanks for your comments. I will take care all in next revision.

Thanks and Regards,
Divya

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Thursday, November 7, 2024 8:04 PM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: andrew@lunn.ch; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; richardcochran@gmail.com
> Subject: Re: [PATCH net-next 2/5] net: phy: microchip_ptp : Add ptp libra=
ry for
> Microchip phys
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Mon, Nov 04, 2024 at 02:37:47PM +0530, Divya Koppera wrote:
> > Add ptp library for Microchip phys
> > 1-step and 2-step modes are supported, over Ethernet and UDP(ipv4,
> > ipv6)
> >
> > Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> > ---
> >  drivers/net/phy/microchip_ptp.c | 990
> > ++++++++++++++++++++++++++++++++
> >  1 file changed, 990 insertions(+)
> >  create mode 100644 drivers/net/phy/microchip_ptp.c
> >
> > diff --git a/drivers/net/phy/microchip_ptp.c
> > b/drivers/net/phy/microchip_ptp.c
>=20
> ...
>=20
> > +static bool mchp_ptp_get_sig_tx(struct sk_buff *skb, u16 *sig) {
> > +     struct ptp_header *ptp_header;
> > +     int type;
> > +
> > +     type =3D ptp_classify_raw(skb);
> > +     if (type =3D=3D PTP_CLASS_NONE)
> > +             return false;
> > +
> > +     ptp_header =3D ptp_parse_header(skb, type);
> > +     if (!ptp_header)
> > +             return false;
> > +
> > +     *sig =3D htons(ptp_header->sequence_id);
>=20
> Hi Divya,
>=20
> The type of *sig is u16, a host-byte order integer.
> But htons() returns __be16, a big-endian integer.
> This does not seem right.
>=20
> Likewise, in the caller, and beyond, if these are big-endian integers the=
n
> appropriate types - probably __be16 - should be used.
>=20
> Flagged by Sparse.
>=20
> > +
> > +     return true;
> > +}
>=20
> ...
>=20
> > +static struct mchp_ptp_rx_ts *mchp_ptp_get_rx_ts(struct
> > +mchp_ptp_clock *ptp_clock) {
> > +     struct phy_device *phydev =3D ptp_clock->phydev;
> > +     struct mchp_ptp_rx_ts *rx_ts =3D NULL;
> > +     u32 sec, nsec;
> > +     u16 seq;
> > +     int rc;
> > +
> > +     rc =3D phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> > +                       MCHP_PTP_RX_INGRESS_NS_HI(BASE_PORT(ptp_clock))=
);
> > +     if (rc < 0)
> > +             goto error;
> > +     if (!(rc & MCHP_PTP_RX_INGRESS_NS_HI_TS_VALID)) {
> > +             phydev_err(phydev, "RX Timestamp is not valid!\n");
> > +             goto error;
> > +     }
> > +     nsec =3D (rc & GENMASK(13, 0)) << 16;
> > +
> > +     rc =3D phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> > +                       MCHP_PTP_RX_INGRESS_NS_LO(BASE_PORT(ptp_clock))=
);
> > +     if (rc < 0)
> > +             goto error;
> > +     nsec |=3D rc;
> > +
> > +     rc =3D phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> > +                       MCHP_PTP_RX_INGRESS_SEC_HI(BASE_PORT(ptp_clock)=
));
> > +     if (rc < 0)
> > +             goto error;
> > +     sec =3D rc << 16;
> > +
> > +     rc =3D phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> > +                       MCHP_PTP_RX_INGRESS_SEC_LO(BASE_PORT(ptp_clock)=
));
> > +     if (rc < 0)
> > +             goto error;
> > +     sec |=3D rc;
> > +
> > +     seq =3D phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> > +                        MCHP_PTP_RX_MSG_HEADER2(BASE_PORT(ptp_clock)))=
;
> > +     if (seq < 0)
>=20
> seq is unsigned; it can never be less than 0.
>=20
> Flagged by Smatch.
>=20
> > +             goto error;
> > +
> > +     rx_ts =3D kzalloc(sizeof(*rx_ts), GFP_KERNEL);
> > +     if (!rx_ts)
> > +             return NULL;
> > +
> > +     rx_ts->seconds =3D sec;
> > +     rx_ts->nsec =3D nsec;
> > +     rx_ts->seq_id =3D seq;
> > +
> > +error:
> > +     return rx_ts;
> > +}
>=20
> ...
>=20
> > +static bool mchp_ptp_get_tx_ts(struct mchp_ptp_clock *ptp_clock,
> > +                            u32 *sec, u32 *nsec, u16 *seq) {
> > +     struct phy_device *phydev =3D ptp_clock->phydev;
> > +     int rc;
> > +
> > +     rc =3D phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> > +                       MCHP_PTP_TX_EGRESS_NS_HI(BASE_PORT(ptp_clock)))=
;
> > +     if (rc < 0)
> > +             return false;
> > +     if (!(rc & MCHP_PTP_TX_EGRESS_NS_HI_TS_VALID))
> > +             return false;
> > +     *nsec =3D (rc & GENMASK(13, 0)) << 16;
> > +
> > +     rc =3D phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> > +                       MCHP_PTP_TX_EGRESS_NS_LO(BASE_PORT(ptp_clock)))=
;
> > +     if (rc < 0)
> > +             return false;
> > +     *nsec =3D *nsec | rc;
> > +
> > +     rc =3D phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> > +                       MCHP_PTP_TX_EGRESS_SEC_HI(BASE_PORT(ptp_clock))=
);
> > +     if (rc < 0)
> > +             return false;
> > +     *sec =3D rc << 16;
> > +
> > +     rc =3D phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> > +                       MCHP_PTP_TX_EGRESS_SEC_LO(BASE_PORT(ptp_clock))=
);
> > +     if (rc < 0)
> > +             return false;
> > +     *sec =3D *sec | rc;
> > +
> > +     *seq =3D phy_read_mmd(phydev, PTP_MMD(ptp_clock),
> > +                         MCHP_PTP_TX_MSG_HEADER2(BASE_PORT(ptp_clock))=
);
> > +     if (*seq < 0)
>=20
> Likewise, *seq is unsigned; it can never be less than 0.
>=20
> > +             return false;
> > +
> > +     return true;
> > +}
>=20
> ...

