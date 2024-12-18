Return-Path: <netdev+bounces-152927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5793D9F657B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DA7162ADF
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0868219E96B;
	Wed, 18 Dec 2024 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e7UI2lzA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1800118E047;
	Wed, 18 Dec 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734523410; cv=fail; b=efjNFOuzMxhoZYj8sPl0uFldno4a874TNX+ECjRNKRZQQYTLQKvwjHEUHWEHdj3fnbd64JUQxDZ3MOx5oQhOeC6MaLxt5nNeLjQK4NxrF/8FOf5KVT8r95IL1cJAYi2zpgjnEDlsXvQfQWxXDicoVurztOY53U+N1z7zpijBGCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734523410; c=relaxed/simple;
	bh=VbG6TAjnDUn8KlYW+2YGpuBMHqgSvOGeoQxWRDkjVu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d1mC68e1STgUY4sbooR/d9fzA2SI7xasIPwmOX4+Y4abzkr25m8HU8No+WDkUL324E4kDNw+lqdsnThnMeHr15UCDCFI9BG9mVf1ymQBfHP2TKwFPUt6r29vJoYVF1l67y0oGzxFQMLNe/RytcU//v83e4Eehluktf8BIBTU98E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e7UI2lzA; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6B1M6GCM8v/JhOrN+uV2jK6wW1CtjNgiUAVqIR8ikTdb0MLIz09hKrtusUa1UngzoNu6uAi8CLPMKeXbddH3NovORBJvWCWEZ2SVsN1YbmDuGlE/EvDlxL7XtomgQ2wkSpLRTZf9qtY49CuZqkzAbWoVeYbMV4S+m0mBxOUcVN7A3TvsWb/1nbFikY8P+Yn02y/Q59Y0Bvb9MHhQuOwhScjqH+9d0LYXNTCip3op3jw/7obIMAiWIv2C4M6vM+GqYt/LGHP7EFRBWkCP/Zdble4Vo8wiWgM+pZbb4d7LP81KxsCf0a6Q9KizOSvQTgbjeQwMNKw64riLiq6BWAl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37ux/iQBD/wRLBwreHAqQeIMsnMOndaBK56mu5fjxHo=;
 b=Ek0OuQHVUSalxXVUGpE3Mi5QA7VGHDgNMrVixW45NdB64wIFDRy7LYUsOrni8LYfGcNv7gFUkA2SoWd9sqttsnu5WvhyalArkmDjY1WMOixKwa55vl9p59cOIhyl2oRoEQssjEoHRnQiHokSdcw2TXXcAbXy8ZKzGQg/9ftTiY0E6OwuAhkNm4+OHdHk5FlNp0DN26KiZ2CG+bj0Bo+MxNLu+avIa+CwtCQh15/SQ1Ylyt70OuztBF6ztpESLxQkaDSfUuPhk5N0k9KUPrt+hMAuw2hQCTR8td8VFTyCtBXz7PQPuJryFCAy2zPsVU43nyUbO/HnoIG6nor92DncsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37ux/iQBD/wRLBwreHAqQeIMsnMOndaBK56mu5fjxHo=;
 b=e7UI2lzAbxziuxjEvBN1QIuQa7w76j7XXi66X0vclEzSUTbV+z6N1BSMnecigdE8eAzhBEY1olct2T/I7uhBpQ7+eLKQmv5AwuJbLBLDhi2aVrwtRTpBr+xLR/g6FtK76xlxRJK7vtykGXSzU2sTuEOoEcmLh0yu/aNjv7E+vHc0nFzc9Iy4aas1rcdpZY4+bjEbCyXeG0H0SO5EmZW7p22JNNW+r63SWkQC3fIxOy9YUjK42ofmwaLQcLzPQlvOooheH2B4B0+Jvur7I5r0OkUehTQGv/CYTZcvGyXucawpKBv7/uRUNvyH7zQCOISna7peMwWDR3KgsedNT9YxYQ==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by DM4PR11MB6068.namprd11.prod.outlook.com (2603:10b6:8:64::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.12; Wed, 18 Dec 2024 12:03:25 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%4]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 12:03:25 +0000
From: <Divya.Koppera@microchip.com>
To: <kuba@kernel.org>
CC: <andrew@lunn.ch>, <Arun.Ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: RE: [PATCH net-next v7 5/5] net: phy: microchip_t1 : Add
 initialization of ptp for lan887x
Thread-Topic: [PATCH net-next v7 5/5] net: phy: microchip_t1 : Add
 initialization of ptp for lan887x
Thread-Index: AQHbTVizfpCa/lSwW0WjLezgpmm6CrLrWveAgACAqnA=
Date: Wed, 18 Dec 2024 12:03:25 +0000
Message-ID:
 <CO1PR11MB47711E8775E5FB1E94EF664EE2052@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
	<20241213121403.29687-6-divya.koppera@microchip.com>
 <20241217191337.717be46a@kernel.org>
In-Reply-To: <20241217191337.717be46a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|DM4PR11MB6068:EE_
x-ms-office365-filtering-correlation-id: 13b2fb7c-013e-4035-0e8c-08dd1f5bf9f7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YogAjlW07CeLgt6/nTE+hvXwkL7rK4cQEeBfOFx0d24omkMzeee92KKvBPR+?=
 =?us-ascii?Q?Z+tKK+VwF6J3yovt6VsFdH/C/8mF7b55V2W+Kj1Ty+p8XJo2s3E2dYvPeGT6?=
 =?us-ascii?Q?m4zLgzENXMqqHQR+Aq3pBGh6jydt94XlgQYfdDL45pnfp4HWlSKTUEZ89plM?=
 =?us-ascii?Q?hiQ5ity60KiNEAEMKDDaYC0FmXjGLph5u7HffgQVAeRcT5BAfc66DrIT1eFt?=
 =?us-ascii?Q?fdKx9fXybAGYUz4CtjUj3aBChqEodqHPuL3ILkpvbgfY6z7v3HI+HGvNy2MZ?=
 =?us-ascii?Q?65R4MAyBgc/ffrP7EC86bH2fW1XqF8wUkM4yZtWiwWSfdZRApQugKGMlWRKy?=
 =?us-ascii?Q?RwtehTrEmvU+mq8WJRtYdtG/wQZwJ2W9UPH3zeCHi/xafoo+cTY5CTeZ54UO?=
 =?us-ascii?Q?jMyqOJJCuDQPmh1jDS6amlhRVRT9jtla+Hq8nFQ9bHqBiGfi625lY2cILWtW?=
 =?us-ascii?Q?S+d9capx9N9an9Ob4Ug2L4I5k0ic/SYxw+WDyShifxigw2RQMlkQsMcTUgQ+?=
 =?us-ascii?Q?Efi0IRj/1QQVWe4k+OcMZKjxMA9BsDqTCrkMhQdaDBH008YjuJXoe8HNZQ6g?=
 =?us-ascii?Q?QufE6FCqf0XyCcjs6jwKFEh7o1a8EmWwkZnNI0y9NYPNlRIAnn7CZdSM/kgN?=
 =?us-ascii?Q?c1XBQuKbK7WiKdD7FqY889eYPjeW8BbjG4b/Pkre+j2CRTUMRVjGP0OTUY4B?=
 =?us-ascii?Q?pgGGSYAwFOfTj6Q1wDjMSgbQIndUhlPwL0V0X49PKasLIV/kDFZ0eQ6dTh/V?=
 =?us-ascii?Q?sSSeA6c30yGAaf0AqZnBDE3FFayJauKVCxHRtwIZDPPAvYFuHbgWP7aMiGQl?=
 =?us-ascii?Q?mdirTFAgGafmI1G6t2MW1GT8Aib5jAQA021jJyNCPKRAncMTRxpzxW6Eoy/Q?=
 =?us-ascii?Q?1ry6e+2HbkJpdLtajUO6FNTEfHFtf+9RoS6IxGRuLnIAIZA6BzizpuFyiM5H?=
 =?us-ascii?Q?uoYdR93kkZSBIz4NCngGsSC3dtvwhxgAcrdbJgIYZMWmXDAgjZcAvQNpzOFu?=
 =?us-ascii?Q?mANrJTczccfzOTVN30pwzyF3LIPin9ckc6oQ9bABwAsrqeRo57jpa24rIvDd?=
 =?us-ascii?Q?2hffRCx+YstuS9pMr/Cv8pmrAGAYW1uLHeUq0eIV8+3n/u7eR+d4oX7u26Sk?=
 =?us-ascii?Q?9AkwuHMH3msqqiX4zzulMmOcTbn3xvbIUtwqRXCsukoCcYR8g1wXgETCWeKb?=
 =?us-ascii?Q?rNCvvlNqpDxsvvgVbnJPQsAiK0GJK/j4PvQkCm21I+ixFlNhXEdhwP3jD+xS?=
 =?us-ascii?Q?kkWdEqU4WmXZ7VmivSwxGnA0hU+KQz5gV8smLpU/hSmGStVP92GKPs0R4y9r?=
 =?us-ascii?Q?Yop+IdI6AxtMosgBZlaLYtJfgBPPZdfLjTJwoqhJDzQ1u3qr6x/1zMi/CJYu?=
 =?us-ascii?Q?cb8HrFUYosnQeYuoj6lysMPqAhkSPkCvt/F8UPPSinEvd+/DMBEIdvKq6bSs?=
 =?us-ascii?Q?/qIlq81cPyusn/iqouffG3wXBybYGA/3?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aPrcepM5BAq6uSQm8p3wjDME9jZkLBUpFYRe1nex1sSWfD8Yhi+ZFSZhOBPp?=
 =?us-ascii?Q?OG55+1R8Mq6dGTzLrzYI3QEmsM2IRSOrK3pqk3JM90N+PhMjtpaaUMFuYWZk?=
 =?us-ascii?Q?nu5Bc7s/ajw4BB1PlI30oRR1/DvAONgS1lnWwM17jvhrmthRetD7L5s5C0i/?=
 =?us-ascii?Q?ye52iwga6okoQWMkTe0ZuyXAtBBeU9pgbl0uDZ21QZQ/yQceQj3eTasde6Fs?=
 =?us-ascii?Q?r5JYjsX/ER1yKdf09LhkJ0ZkvBLZSWYAbtHp944PfYyQ1Tne9zOlEM/YamEo?=
 =?us-ascii?Q?FS4OytwHmbR5uDqyXziZBZLT4E5McCutSDRlemKn19XSR2RuIuDVkbphN7OM?=
 =?us-ascii?Q?tbU+yh8FCPX5I8/nlUgdR9T3mH5uCdfT5P4ld/H2k6BzB7FiPigTaH2ipe4c?=
 =?us-ascii?Q?+ZAP+pU0gyrYr5LrXB+SRTvbMsS3gqzX8p33jif0yE0brvN1jWKp57JqUJTi?=
 =?us-ascii?Q?16MUa1NYJ38NUCJvwPo9YmiAb+k53Zu6s1opi/IWTpeM7LYk8fVRoeMucALQ?=
 =?us-ascii?Q?7MbyFo0/YMVO/Kk7Z4Jh3zdPUIjcTs+2d1hcBJPF1wwnw9VlSC4fNJSw4MDL?=
 =?us-ascii?Q?GOEYDCyj8F+YtiXoui4crt9ipVZGS0DG1m6Ds7UQ17CDokoTm97L8Yq4Fy/r?=
 =?us-ascii?Q?FeNQLonWwfgkcfa3EFp31of+3Ow1xaBN9xn5ylV3kWsKy8KX1dDhJ2M8851a?=
 =?us-ascii?Q?wSJlaj2G3FaKuSutaLZfFsvl6xvFuYtriB2ZexKwNN719IELpEh6C3EFXFQh?=
 =?us-ascii?Q?Kn2gfMGW4b9EBzfi3DlPHsJoJFIAzHNaY766NqymYpzGQJ93lgEsrEMkHL8+?=
 =?us-ascii?Q?LTtbNTK35Y+NLyTGZpbFCYW/kgxmmQ2hMkJcnU5o4c+BPCANh0s3vho+aPxB?=
 =?us-ascii?Q?LtvIpGdfHSJdT8+YzgpBQTebFEpSrlwfGb9zBZmiMiH5+a2tPYADKAb/9nfr?=
 =?us-ascii?Q?vIGfyeK6W6GGdivxuATUdvp3x4QUGKyUQNVXL4MPLUpRW1s3M2HfDXYcDI5k?=
 =?us-ascii?Q?0NR2LXrIZSsVbFyizv4JB9NK+yImf0hs5xggti97uwIW21zqHLz+ODsO3CJx?=
 =?us-ascii?Q?1D6pGADs+Y+uogqTKPV/82zt1ib/RCyO6DlrnyyelmMZpHmk9TsXXjCzfzF0?=
 =?us-ascii?Q?0ZYR1R8F+VJcgkxeOquRRNn27j7U95iUfAqr00Gms/4nUwFO/iPwOmFrk4gt?=
 =?us-ascii?Q?k28zuxjGHhx8JD0xyX7hDDj+4V2OTl8nWAF2dzgDIn8NObJSVV593c5XMvib?=
 =?us-ascii?Q?7guIVnUWFrEMLy8xBE9GCATjkJIlSmDrKv77Dtm9AHwbF4VmBd179lyW9X+A?=
 =?us-ascii?Q?2lwdmfmnOoxyC8K+E547NYDJGZNB2i/IesiAeKf6UEGyxv+n1PbEBZR31CUF?=
 =?us-ascii?Q?ScQATKbLrpXHyuO7S0YNYx7EeHTe5cIrVR8Hc6TLXyBW88fCc4sEsdd7DnGa?=
 =?us-ascii?Q?fjdkT5HAY38mOmQahH3ZZVeCs4f2pWG7hkLk3DyaaKLFxuFz6XdpxiHNipWE?=
 =?us-ascii?Q?pvPe1oFcsuFc0RXv+M6co3hE/MP4X0v/TValpN3tpAEyPfjnCd2CTvT9Hs27?=
 =?us-ascii?Q?TWMatgNToJLEJSK+lCXVCvSzaQW+IAH+m9W1v/qAt5ixEW4XKtgVpJUTiqGn?=
 =?us-ascii?Q?jg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b2fb7c-013e-4035-0e8c-08dd1f5bf9f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 12:03:25.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zva+G1c9U9DqDcXM+dcaGU+zJ/P4iFvfC+KKvENRXusVc8JuygjDYFmh+JkeXQo6qSB4U34H/8RfHwSEA0yM4L0TmsoVJEyhI4AnhZGuG5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6068

Hi Jakub,

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, December 18, 2024 8:44 AM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: andrew@lunn.ch; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> richardcochran@gmail.com; vadim.fedorenko@linux.dev
> Subject: Re: [PATCH net-next v7 5/5] net: phy: microchip_t1 : Add initial=
ization
> of ptp for lan887x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Fri, 13 Dec 2024 17:44:03 +0530 Divya Koppera wrote:
> >  static int lan887x_phy_init(struct phy_device *phydev)  {
> > +     struct lan887x_priv *priv =3D phydev->priv;
> >       int ret;
> >
> > +     if (!priv->init_done && phy_interrupt_is_valid(phydev)) {
> > +             priv->clock =3D mchp_rds_ptp_probe(phydev, MDIO_MMD_VEND1=
,
> > +                                              MCHP_RDS_PTP_LTC_BASE_AD=
DR,
> > +                                              MCHP_RDS_PTP_PORT_BASE_A=
DDR);
> > +             if (IS_ERR(priv->clock))
> > +                     return PTR_ERR(priv->clock);
> > +
> > +             priv->init_done =3D true;
> > +     }
>=20
> If this only has to happen once, why not call mchp_rds_ptp_probe() from
> lan887x_probe() ? If there is some inherent reason the function needs to =
be
> protected from multiple calls maybe it's better to let
> mchp_rds_ptp_probe() handle that case ?

Valid phy interrupt irq number will be available during phy init procedure.=
 Hence, we are calling ptp probe in phy init as
interrupts are mandatorily enabled for ptp to work.

Thanks,
Divya


