Return-Path: <netdev+bounces-144285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5239C671F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802B71F24DED
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FE1762D0;
	Wed, 13 Nov 2024 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eSz0yWxb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5597080E;
	Wed, 13 Nov 2024 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463965; cv=fail; b=RxAFfMUPd6nnmdmL1I2SOad1OabWdJy5tfziZtfDA5N5rMVSmOdAZFISfaw0LhLXkKwODKAWwYnJSlHOY1LyqA4grO7FhyCXYun4abulbkgMIVaMEX/zUcea4574UVU4o/CJQaH7K9O8gIX5m1cj/wOnMv25Z+WwSvU1bRGhqmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463965; c=relaxed/simple;
	bh=bji6t1Sfqb7kvZo3CxNObmDggXxarcHCuOmbXJMQ5CI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eClY5p6ewlxgD7NUFiDAlwkK7BLlUX1y3oPh109FH/izxd26HH//NpuABBJ3kFzIGfMyhyL+7HM6oc4Od1P7uF7jc38H5ZAIkpw9/gA6zd/qezq8+Mp8vlaoKJnA1wpxMtjGXlaBwjQsfQWv7L2HNNR+fsI0BVQcOEJs/DDiwZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eSz0yWxb; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F53O7Dvr2Tgv6PQsnzl3jCVLPl/ljBT6JI2qUBMmPJ7zxY2979lrq35+LakcrjRSY4BUDUbTaeEvkWxBg17FZZ1/N8TtXTZQyeiOvC3NLFncL7hYpz85rHsCZfrdkdPMv+MZB3dgDK8usDoG59lIZ4fULYcyzgbEUBElYBsdj5DAtxwTT9E4pPsYbSsKRj0XMVEeMdHQBg8FyZBS+cHVKuktn0jn9Llvbp3GZAgfA0kfcwmwbHbA2ljA30c7xxvKlMKpT67cKCsbwRbu5KlACjasLqFRLT4IlY2RMUoS6NMeu6f11Hvu5iMA+6EoOlM0gGJt34+XQ4cl00hz+CNoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egCzBng+c/hu2hAPMBIDdMpKHOpYbSgAuP/sVKD5B4Q=;
 b=RtP5jigQZSH5ZEN3ZXXF5MBKggpWh0KlUXgqGV8Zrh4uAZY1BQrKCKZsNyjzuG9UIc+sx1daiSn2q5ZriiQHuh4z5Rjabenz5F5wVpklZoRJ6bkAQuU3t/DQQ8ZfsNKxBC3l9kMQLRhE3yoF6uPSnoYAGzlX/EkZ6Uz/AjXaBzdVinJxkgekDeygG70dMhknne7j2NYXetnpui0QYnP/tH5vNj1zUibX6LOsoMP7x9fOQBpj2K3A1BFYrF0AdJhtzt5Fbi7DFN/n5sASCmjphQeLyfp22tqnWyG0iCmzoLumMPKesBnss9UmwG3h+9vUj9Hk381u5wpbYCJiL3G6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egCzBng+c/hu2hAPMBIDdMpKHOpYbSgAuP/sVKD5B4Q=;
 b=eSz0yWxby6/Q+s753Ob5iplZGm5KaFg7+FUcED/en1ldhfiCtrLJ1BSmcvqrvdgVEyZtCeXZFHjIsG7rV4sHmCiH1AB9yYW7O4ryrfxoWi6PeXscnn3en3ijDBotf6AaViSJxByah6oquBmx++u/1fRAW/yWr/FlowMIxQaqxt2hmIXCwvik0MElvw1wFD0Fub5dFY7k8EXAJKsElRs7NH9PDk6PiiQ5j9jKWNd4BvrqpdJ2nE/f24bU0qSX/xVpE/+yh+1ztlMhzJeNvNBAOTNqvoQ9MCLezMTc1smSu8xIa0eYKZ5Ei8TgVGDE0gNbtqPaSu/2WjytSE7wUyYZog==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 CY8PR11MB7875.namprd11.prod.outlook.com (2603:10b6:930:6c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.16; Wed, 13 Nov 2024 02:12:37 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8114.028; Wed, 13 Nov 2024
 02:12:36 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <Woojung.Huh@microchip.com>, <olteanv@gmail.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index: AQHbMkqiYUyxAMrEtEGHh8l2mClPuLKvD0EAgAPmaUCAALlcAIAAy2zQ
Date: Wed, 13 Nov 2024 02:12:36 +0000
Message-ID:
 <DM3PR11MB873696176581059CF682F253EC5A2@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-3-Tristram.Ha@microchip.com>
 <784a33e2-c877-4d0e-b3a5-7fe1a04c9217@lunn.ch>
 <DM3PR11MB87360F9E39097E535416838EEC592@DM3PR11MB8736.namprd11.prod.outlook.com>
 <700c326c-d154-4d21-b9d4-d8abf8f2bf33@lunn.ch>
In-Reply-To: <700c326c-d154-4d21-b9d4-d8abf8f2bf33@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|CY8PR11MB7875:EE_
x-ms-office365-filtering-correlation-id: d21c8cf9-f89d-4076-2160-08dd0388a499
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?a+CYSKPljdPtkhQYzObE1moCkGfwbXm0TBWY6KJ2dgsI3bXOsCb90JsLOaP1?=
 =?us-ascii?Q?Q86O68fMMk30ZlRDlbP8WcYTa4dPQeMLgO6w6GlaoT9hJaSgTZr9RlyBVD48?=
 =?us-ascii?Q?7YIUOTlMMBMSoPOSturyN5PLoToHE+Jki70pre6FklecWel6XMVrAxNrQr6Y?=
 =?us-ascii?Q?dB3rw7Ki/L4FEhdZ8RGHkget/Cj453KO2MXg7w55eMTxr3yI+no4pg0tgf59?=
 =?us-ascii?Q?jOW1gQH5M7iCzPeXzjuLIXWcRcxXmnVAExitymhUosA8y3XaB5X6hkXWJMIc?=
 =?us-ascii?Q?zfe1W1PGDztk8Li6KnC2i8FZ5/z5HRQWgDSCI2pFFNs2cGN/uyVtZpuFg1us?=
 =?us-ascii?Q?c64hBvB4fGOMx6eGohz7qt2GELch69DL0IQ8HzIxnM9151VwB+qGO27s4aM7?=
 =?us-ascii?Q?YKZDGasR80m4+OamgoWETAng/AwWcanPPxEBNmlb+M5pLk+vxW6HQq/19MNT?=
 =?us-ascii?Q?418VUQnfLIlVsfhtQ66At+OIJTGrCYp2dcBdTctGRLNPuUkQw31t0rnIaG5V?=
 =?us-ascii?Q?KMYPg5XF0z6pXOuLuxpnv0wWtyLP+lKellGFSia24noJ0ArCUoQZc6eqFd7+?=
 =?us-ascii?Q?N4xPmWlCWYEaumtcC+cCcmTam8HM6ene8neE1z1DtrszAJ2fDIBz6tBRMsow?=
 =?us-ascii?Q?hk9vi+4fLsWEc1uk8uFbmpQBcm2mUCDWNuLA1ZgkvmP1EFoB+qaR3P5laTFD?=
 =?us-ascii?Q?lGSwABIkmiHL3qqDiWkhb9faSx3MM76ziUL+Ng+Th/QT33mhckYbxVChRKT8?=
 =?us-ascii?Q?aqd2wKlSKn7Gi2F49yV12UDrSM/LlosO8J+X/uifNQ3ULBkVQqzw1suvJXw9?=
 =?us-ascii?Q?VGpNVzayGCFjgeLsjSMUtJtB88MiOoZPm3/oVlUXry2XwnT1BcViBaMGCGhh?=
 =?us-ascii?Q?ol9+S5l4dAKuP37NZRW/by0SE8z8erPtMnGQzelr25figlFUa/9jGHruxH8V?=
 =?us-ascii?Q?UzLS0bUl/6FpabPu+bfuiXYsuHXGcn8ggMm4ChAA444jfrWk0CstK7JeYjO6?=
 =?us-ascii?Q?Mmp+w0Fm0nlQbxfDTCf/hU5ay66LbU7vYPby9mBHuzbpcksceJ73/vvw0tWq?=
 =?us-ascii?Q?9uhNjsGuyU6WQlGDxslHnMIcalJ8EqJ74jUaScHaqWXirMDDr9xc2sJxv1Ma?=
 =?us-ascii?Q?sk+nVDe+PxWtKaB4anDz/UiP8vF654TefnBsDXm+XxWUrk0mRujkiHnnVBN2?=
 =?us-ascii?Q?KqQunVx0A3lKHSgd0oBUnKrtVGRZqi4j10dX2svsBw0G71pSdhEuYnQ2pbYZ?=
 =?us-ascii?Q?R6NYpODzD6UuVqUClhRmKTqJYP0nFIqrCU1G8+trSLQwoT4SQwssHJ/uI2/u?=
 =?us-ascii?Q?a+vzqCi//+1Rl9GrHfnRq/yuoYaxIbEhwlcONIF5uUytCtRFpEFtF+6Inbqe?=
 =?us-ascii?Q?EZDWxA8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jd/ZPvtFpcm2yEn+ZMDRm/2036S/axEhlXHbVFxHS1bPJ6A8Qf8RbkLB5Emn?=
 =?us-ascii?Q?rz/bIzGwZx4d7cQ6gSa45TNBSxZwfJ2+9/dA+ebpJVjW9A5z9+m2RMbjnT6D?=
 =?us-ascii?Q?Bq7dSwiMp+9Lq/ybTIpHQkDKH3/0/QBc7IHwanAHPn773RU8KCen5OM2XHwz?=
 =?us-ascii?Q?9Y4KpsuVi5MR8MX2e87vjsoQ/jFA/Grtq2rOv51BD2I9VRafbaUDXcqClo3d?=
 =?us-ascii?Q?F6krTGIduOkT//pUMcbsKV3eTMRH6DtfJis0aTzva7JnI54EVTmkrpjfu3r/?=
 =?us-ascii?Q?6w3HZ/zTcB/vJAjK/E/vvOZL75AFjpVsEa6Z4gXI7AiWzmDQh6T1MgghHTqi?=
 =?us-ascii?Q?9HZEiQ4WZhR8C2eT29MVZ62z2mvdUCppycoD0dYN5NEO4LNKE0gTyw/urN2g?=
 =?us-ascii?Q?QHsCpQq3ZVgUR4ZS6kLizofF/p7NN0QyyjHGaTy3gGgIJ17/KUrEzJoFfXWz?=
 =?us-ascii?Q?obfmw9AgnYg2EFsKE/fYNmqt3lsrykgT0uudJqXDlIVOwrk6d683U0ceqtlv?=
 =?us-ascii?Q?CICEldxUs5VwfOJ6bKuyDxKezHK2Tq5uLG23LDlUxbnyuhAAGX/pMB6mt4ml?=
 =?us-ascii?Q?VMJauu9jJk1NJ9Ews/ocr39LMsSZXGVfxwYOrzceHA0s9/kfY+AutFUPqRjn?=
 =?us-ascii?Q?sWuKmOLQWBHXheCpVjyPV3pdE7ntb89uM5v0kvgY3B+qmf7FIbiB/b8bb5rU?=
 =?us-ascii?Q?ZYUSELsxVEA9RzWCICNRlbRDbFL/i/DwfPyHc8uLiDzk0l4oSL7Jt1zghxPP?=
 =?us-ascii?Q?7c5a2JAmy3er4qXwQjVVbkVFsPnEzFfb2KryF+Ati4V+j0nP9eomUwIH67d+?=
 =?us-ascii?Q?VKl96mlT5UWsxP3VisWJ3NU5P4VwtzySKy7ABbIcIAWdleyOQ6HeziiIWisT?=
 =?us-ascii?Q?yYrTg+oavrMtcXDIeBmXsjQJZPMmOVlswvC5sEHLwNwC0eAqO7YaIsZ0nBR1?=
 =?us-ascii?Q?RgVGO/dFKXnIjkQ9eMMs6L1ZGB1NNUpyYUNE79/kVT6p0vtR2oCs4I5qU2cV?=
 =?us-ascii?Q?dY6Lt1Tf7FL6DncPb8ShoZ3izPcoHSI7zMpiQQMl6IEa5fH9i15AUeVAW0WB?=
 =?us-ascii?Q?vS6ScvVUY6HK617VfBCqwq0BKk3BWYkjup5fBX6iZ664h1x/AaHhe83EKji7?=
 =?us-ascii?Q?g+o+BK/ZLHTNJk8SeJ0BwWVQhptgvk+ByUD47QsdFjY/ND6/D6Ind8FQoquK?=
 =?us-ascii?Q?Hd8bDeXxv0x2QqPTXiP80EgFtPwcBiAPqqu/vTpye/IVrkrH+SAOgLv7ZsMu?=
 =?us-ascii?Q?s2REjOWTgCsVhFV6muVfh6qLW8GGBxlc/sunp8E2dkmm2HEX8fHSIZtEr0Zl?=
 =?us-ascii?Q?7nnq3Uvx8L8WOVZ8vSzVZzbZQuV4hP+tQfqabhwkNgfHThiC91azkHAtwdBk?=
 =?us-ascii?Q?s2CSYGoEQsM58Dhosb2Bt0i+m542jxyFujEhpbqZhaCXYwkqNXl7HIMupcSX?=
 =?us-ascii?Q?GnkqFaRt76xAGr0w1V6IDOkDy3SSJC5T+vSKi4481HC+Jnz9khevZaaNnEMm?=
 =?us-ascii?Q?ynmGaRvHskiLxwMpg7MbjU7ggpH0ACBwpXCoh77ai2lDFrSI4CaL2ieovGJ8?=
 =?us-ascii?Q?mhLIUhC4DreojwjC5UFccQr0TFlmAUGM1S15rrEw?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21c8cf9-f89d-4076-2160-08dd0388a499
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 02:12:36.8025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BMexCM6PWbpx1Qe27rtsVLZiqz+MGWEvutdYW04fgHpgK5OOB782FWmcZDHmqfZ+dDVHd4wM9Z29tnaEjIJACdQdfE7C/Kk6l8hNxWVZQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7875

> On Tue, Nov 12, 2024 at 02:55:29AM +0000, Tristram.Ha@microchip.com wrote=
:
> > > On Fri, Nov 08, 2024 at 05:56:33PM -0800, Tristram.Ha@microchip.com w=
rote:
> > > > From: Tristram Ha <tristram.ha@microchip.com>
> > > >
> > > > The SGMII module of KSZ9477 switch can be setup in 3 ways: 0 for di=
rect
> > > > connect, 1 for 1000BaseT/1000BaseX SFP, and 2 for 10/100/1000BaseT =
SFP.
> > >
> > > This naming is rather odd. First off, i would drop 'SFP'. It does not
> > > have to be an SFP on the other end, it could be another switch for
> > > example. 1 is PHY_INTERFACE_MODE_1000BASEX and 2 is
> > > PHY_INTERFACE_MODE_SGMII.
> > >
> > > > SFP is typically used so the default is 1.  The driver can detect
> > > > 10/100/1000BaseT SFP and change the mode to 2.
> > >
> > > phylink will tell you want mode to use. I would ignore what the
> > > hardware detects, so this driver is just the same as every other
> > > driver, making it easier to maintain.
> >
> > There are some issues I found that will need your advises.
> >
> > The phylink SFP code categorizes SFP using fiber cable as
> > PHY_INTERFACE_MODE_1000BASEX and SFP using a regular RJ45 connector as
> > PHY_INTERFACE_MODE_SGMII, which has a PHY that can be accessed through
> > I2C connection with a PHY driver.
>=20
> Not quite correct, i think. If MDIO over I2C does not work, it will
> still decide on 1000BaseX vs SGMII from the SFP eeprom contents. There
> are some SFPs where the PHY is not accessible, and we have to live
> with however it is configured.
>=20
> > Now when SGMII SFP is used the phylink
> > cannot be created because it fails the validation in
> > phylink_sfp_config_phy().
>=20
> Please stop using 'SGMII SFP'. It should just be SGMII. The MAC should
> not care what is on the other end, it could be a PHY, and SFP, or a
> switch, all using Cisco SGMII.
>=20
> > The reason is the phydev has empty supported
> > and advertising data fields as it is just created.
>=20
> Do you mean the phydev for the PHY in the SFP? Or do you have a second
> phydev here? I'm confused.

I am a little confused.  There may be regular PHY using SGMII with MDIO
access just like a RGMII PHY, but we are dealing specifically SFP here.
The KSZ9477 switch board has a SFP cage where different SFP can be
plugged in.  The SFP driver has to be enabled in kernel configuration
under Hardware Monitoring.  The driver then can read the EEPROM of the
SFP and access its PHY if available and provide support to the phylink
driver.

When the SFP EEPROM says it does not support 1000Base-T then the SFP bus
code does not consider the SFP has a PHY and skips creating a MDIO bus
for it and phylink_sfp_config_optical() is called to create the phylink.

When the SFP says it supports 1000Base-T sfp_add_phy() is called by the
SFP state machine and phylink_sfp_connect_phy() and
phylink_sfp_config_phy() are run.  It is in the last function that the
validation fails as the just created phy device does not initialize its
supported and advertising fields yet.  The phy device has the
opportunity later to fill them up if the phylink creation goes through,
but that never happens.

A fix is to fill those fields with sfp_support like this:

@@ -3228,6 +3228,11 @@ static int phylink_sfp_config_phy(struct
    struct phylink_link_state config;
    int ret;

+    /* The newly created PHY device has empty settings. */
+    if (linkmode_empty(phy->supported)) {
+        linkmode_copy(phy->supported, pl->sfp_support);
+        linkmode_copy(phy->advertising, pl->sfp_support);
+    }
    linkmode_copy(support, phy->supported);

    memset(&config, 0, sizeof(config));

The provided PCS driver from the DSA driver has an opportunity to change
support with its validation check, but that does not look right as
generally those checks remove certain bits from the link mode, but this
requires completely copying new ones.  And this still does not work as
the advertising field passed to the PCS driver has a const modifier.

> > I mentioned the SGMII module operates differently for two types of SFP:
> > SGMII and 1000BASEX.  The 1000Base-T SFP operates the same as 1000Base-=
SX
> > fiber SFP, and the driver would like it to be assigned
> > PHY_INTERFACE_MODE_1000BASEX, but it is always assigned
> > PHY_INTERFACE_MODE_SGMII in sfp_select_interface because 1000baseT_Full
> > is compared before 1000baseX_Full.
> >
> > Now I am not sure if those SFPs I tested have correct EEPROM.  Some
> > no-brand ones return 0xff value when the PHY driver reads the link stat=
us
> > from them and so that driver cannot tell when the link is down.  Other
> > than that those SFPs operate correctly in forwarding traffic.
>=20
> There is no standardisation of how you access the PHY in an SFP. So
> each manufacture can do their own thing. However, there are a small
> number of PHYs actually used inside SFPs, and we have support for
> those common ones.

Now back to the discussion of the different modes used by the SGMII
module.  I think a better term like SerDes can be used to help
understanding the operation, although I still cannot narrow down the
precise definitions from looking at the internet.  SGMII mode is
said to support 10/100/1000Mbit.  This is the default setting, so
plugging such SFP allows the port to communicate without any register
programming.  The other mode is SerDes, which is fixed at 1000Mbit.  This
is typically used by SFP using fiber optics.  This requires changing a
register to make the port works.  It seems those 1000Base-T SFPs all run
in SerDes mode, at least from all SFPs I tried.

The issue is then phylink assigns SGMII phy mode to such SFP as its
EEPROM just says 1000Base-T support and not 1000BASEX phy mode so that
the DSA driver can program the register correspondingly.  Because of that
the driver still needs to rely on its own detection to find out which
mode to use.
=20
> Have you set pcs.poll? phylink will then poll the PCS every
> second. You can report PCS status any time.

I know about PCS polling.  The SFP cage driver can provide link_up and
link_down indications to the phylink driver.  I thought this feature can
be used without activating polling and when interrupt is not used.  But
that link_up indication can result with the port not connected as I
mentioned.

Anyway the SFP driver has its own state machine doing polling, so it is
not like resources are not used.

One more issue is if a SFP is not plugged in eventually the SFP driver
says "please wait, module slow to respond."  It may look like an error
to regular users.  The next error message definitely looks like it:
"failed to read EEPROM: -EREMOTEIO."

Do you know if anything can be done like defining some GPIO pins like
setting up the tx_disable pin?


