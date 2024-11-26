Return-Path: <netdev+bounces-147334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E479D91DE
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 07:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F858165115
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 06:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3954C187FE0;
	Tue, 26 Nov 2024 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="noNjA/Wy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F436539A;
	Tue, 26 Nov 2024 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603430; cv=fail; b=W7FQJeBEW68L1Z41Cdhs5HR+IG7Ggj4NV9afhAAdoclAax/3V9qViPSoTj71BrByZKHpwM2AaOsNkC7NI0wqmgRDP1p9DuKDbQVuBu4s+sTxdk+VZPfOkcpb/xnNDCON8z/R4LlUh8r+6d5uOxCYMubi8EaT611WtPLqQynCi14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603430; c=relaxed/simple;
	bh=uf/VM7W+aCtHBm40rNlw+yPHJyNP0I40bqCPdeYqoWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=li3GxiKZXQu+BFsFIbCv2WTei2AMRyoLVcqxO7/gsg2BIBrfwULls6B97357wnlYba2o1WhdMG6/2J5Ubvqolf1jonbMrt+9bo5aAWV/lmqMH23IYlPyZf9JxyPx99ynwYg+W79ccc77o8JxvAaGaExEJqeBoKPLzqk+bhvBYw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=noNjA/Wy; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nyr9QmoR0enjP8DbKBKEaJZlmJUeAGAXoJ3lyrfgXpJCw00qPW6ZQHsCk9B4g/xMphS+PRdmzAM4LLils5se2miJr91g5izOqpPp6NkbjX4ugi3z3oNSLze2HleB0CUbMIs6wF/lkAMaIKiC5HwbQSIGQDPr/UVwQsrRJGhFe5QBrhQestiH4gRN8GHwuXteiuG4jdxhauTcLb2XBpTscIrBCYsnYfvhKo06egU3n6hSOJdyVpGKbmPXEN9Hiecxes2ytD5Pxs6rqWERf+/Vl0vJRSHgyKdIiamsWII0G9wJIkdJHzJ2IMhsRo2X74s/kNsRzghac+aq+vvU1i4umA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcPioCZUIQkWADevnPexL7kzJPEp5rzRjYxttPHLhfI=;
 b=SpoG31h3ujXGyvwZXwhVua9Vb7sSYbGqMz1XQQz6aXRBuYwJtsvjdkdPHpAM+Sl8PfiXOX/sbIl3jzL1Pg5cjmDBg98v1PJG1N5ZPlNtAM7n0LSQ6Vdo/svm2vlnFxUpatVE5ikzxx2ETcEMVTowTu0rKVW0KplkObk0hLI5d6cwzPh81mzmPY3VuS4r2TK+SUZLpviQFny+/34b1e13Rz5CtybMpbQmNqqpT+B3yQZaMxuxwIizWca05adURgbea4KDKfLmKIQ8FQncP8CzNyKOGPK2lp1zmtF+TEpSjAGmZYk1jL2p457C6CqQsZGfuBwrjpqU7/emQn6g12IRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcPioCZUIQkWADevnPexL7kzJPEp5rzRjYxttPHLhfI=;
 b=noNjA/Wyg+YdM3wINVV1y5Dr525lFVY3VpE6k3XvIxHVU76zNd8L7FBnEKTdH4ZT15vYfHERXxsG/B/mkmzFDKGh00oj9+46UiBMiV+63j2Nu/N+/tZGtrV6Z1lumECDY9abRAKxDNoAqppFLvBczgmC6MQLTRBLwMmU/4qG94uWzGBF6zzf79rAvp3ZTqT/NQGixuPv4S5FtmrD8I0kHAuuK+q2j5YH3pbJpGcG0jPcR6kgCnwjCE5VjBQv5x4JUfUaTsAeXN6Ml5RaCcvJ3lM1Z261xNwUAZkL5wJ7YSMYeqW5LgBN4uTNAWNWOdqd+gdjSHFYqEa7osy87Xsx2Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 06:43:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 06:43:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "florian.fainelli@broadcom.com"
	<florian.fainelli@broadcom.com>, "heiko.stuebner@cherry.de"
	<heiko.stuebner@cherry.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: phy: micrel: Dynamically control external clock
 of KSZ PHY
Thread-Topic: [PATCH net] net: phy: micrel: Dynamically control external clock
 of KSZ PHY
Thread-Index: AQHbPuQIBFQM+AYbJ0Oh2rCBjjIPrrLISHYAgADOSmA=
Date: Tue, 26 Nov 2024 06:43:43 +0000
Message-ID:
 <PAXPR04MB8510D7A400FB0CEAC786F524882F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241125022906.2140428-1-wei.fang@nxp.com>
 <Z0S56m1YIFEPHA/Y@lizhi-Precision-Tower-5810>
In-Reply-To: <Z0S56m1YIFEPHA/Y@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB6813:EE_
x-ms-office365-filtering-correlation-id: 991bd2aa-494f-4438-d556-08dd0de5abfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XVirWes8qJtXUAOJu6xRVkIvIShmFfL77jmeG8BrFC+utxCKK2LZKh2rgPtH?=
 =?us-ascii?Q?JFx2+37V52BD1TRrQmY9o6GHm8qBGmERrv1KF7cDkRVwCmMXX0R2Xs6kaqI1?=
 =?us-ascii?Q?j8ecNzAP41c5sh8Wxajt1qkUluu//BKrTs0G3NEmFj7yb44tAp1xeo2XfKPj?=
 =?us-ascii?Q?UO4+Df2psVWhyzAJMSByyCYnuT8t6a0am0k0SQQdqDn/uZcHMrexdL66zZdJ?=
 =?us-ascii?Q?n4lPNF9/R3thurt5lzCSo1A0vO+dcur0X6a7Jztpkd47WtINHrD5hw/WrT23?=
 =?us-ascii?Q?Sr3UkPnv90WCMVL3Gkx0jeEQDtDxcqe6iBL4/tP3/w49TZt+pleuBWYFjcmt?=
 =?us-ascii?Q?AOfmoAtCjWSUpstoRpi4eAHC0Nvkl2/F37+RqHAfq+Z2WZMEro8F7pKSKItr?=
 =?us-ascii?Q?G/zASY9k2g1r7s+lzibPzz0GmBBkRU7viN4m32Aqs6vkYroR2K+LbWYgFwoa?=
 =?us-ascii?Q?NuIS38ecub3TggLLcuiIJ55eSQBHHAV7/oq7+TvoQTglwRKvmccUA2BiUYKj?=
 =?us-ascii?Q?FH/Xc2gAviyo95siJimr79Uw65IQPxihtkfmL8V3o+vIUnXsQBQw+8nJEUQ6?=
 =?us-ascii?Q?tshbyyiV1LoujzKtWgEw31CXuEqB21/wXlFHva9wIY5Bi5+nkrRdVXqcWOqQ?=
 =?us-ascii?Q?cHIfDHflh2giSKBtjFCpCNC4lOJEC9KozuW/min1qH2ZJCp+h74z89MDoYyQ?=
 =?us-ascii?Q?Gyo2Z6i0/K2heJhRaZsGgPrKvkM6wt2SzhGUZ6E8uABK43v6CpXXyagGC1Tf?=
 =?us-ascii?Q?3BgJNc5TVMIaMe5U5sN4G5FEUpA1NnGDQ2FXw6XrWMs2+1gsREfUnWhG4BCl?=
 =?us-ascii?Q?n5BRmTj0M4iEVfEhHcl5TYf4kXZA+1lHASzx4lyzknV2wl0Mg/n9cv2L0vVd?=
 =?us-ascii?Q?6fu8zaIJbhMYCGjtJkzSGXZRb4HoQSvnkPhGaCXbgOdD/7eUROOon6ETCaDo?=
 =?us-ascii?Q?HQ1s35Be9KZ08FLqebHhJUgeQMvoEljjztw7ZXPnYnfSyTCAJYP/j/K+j0cu?=
 =?us-ascii?Q?zmeTO8L59NBCR/eritXT14OtplNNbqmWibOTsIwA7hGKALUQrdaj/Tv1ZMdp?=
 =?us-ascii?Q?KDu/BWtB4F4sOABGYd7vQvqU1wo1tmji2DAwZTRd1JcsEo/5VqKsDJ97Ldpc?=
 =?us-ascii?Q?gBOOrW70DvnIkPcYtF2dR5+4QVCkEEwMeaBEyRkO+eLwJnjaeJKWVgf5HE4F?=
 =?us-ascii?Q?OOELST56tR/M8W8n6HzvTg1G4UTAAg6bQYK7B7nCIvIDjbYsZq9uMfND0XfV?=
 =?us-ascii?Q?C6dj9ZTXpzQXSWYzZoY3UXHyWJFnssEsXElVd+EB2wSwDcmJR5QI90ljzrYr?=
 =?us-ascii?Q?lSnQ6K8+Qr6Zd2g6DaRYG5A1qTlALMxohX4zKujeaVdf1QI6JjimWOYctgeq?=
 =?us-ascii?Q?cZb9+uizPDHJ5I0SBQcodK3WbomDZGV3FSuIvh3AiyKYYNs0gg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qZQ3JrhnQ4bkDO3TINjrFXmGP/Nv7/of39fXr1RTKSv69o/y8edBgfKU7Bn3?=
 =?us-ascii?Q?EwNktVj4Rt/XLjqpM1Im5E8TcpnB7O8GYzoq55+aVKthEGghDhYa1RiobTjK?=
 =?us-ascii?Q?/DoEm2onVQMcv2Spa8zRKD3dvPiYmAQYD/z9r1WoUcVN+rHaPvt8P5E66e9w?=
 =?us-ascii?Q?aumbNxg3Tf3De6x1F02PEXAO2cDcvey1prqEAd6bDRLEmw+mHDqWF+Y5UM7+?=
 =?us-ascii?Q?x75pZOzq1wYHj3hmDcxGutglGvOR5QvwHEUdPqQeav16Hwi7sgpOmuQGSrw9?=
 =?us-ascii?Q?+tgj/I6NFfoafCdJO6ecJfZngVJVHT3ar+VqHjZ8x5XoqR38XyUObtmZCkZj?=
 =?us-ascii?Q?SoIj1ILiU7Zc+gsE3Sg0cL+CymfpboQBcneafU/lpHdrfvc+GIxUMg5UYBb1?=
 =?us-ascii?Q?1pdmNFqzGNkYoUTB/66RbtolzjARaq1wo5qJ0u8q1W6obyAzU2y6FjzWVNTy?=
 =?us-ascii?Q?9xwZMhfVKtri5N7KgbOs2P2a7OxaYPo5D/O1aH86wFFUUfpfpnJUAoMYdcp6?=
 =?us-ascii?Q?B8RCVTAvpqI2Ym9+DYJYkyC/W2WTiBmAWiulkF12F6NqREpR9Kfpdyy3hlqK?=
 =?us-ascii?Q?XqV0GeKIjZCkMfwJDxO6S2I24iCFcyVM0HjF9PvBLp0H2wXMEY6RIpmlpM2/?=
 =?us-ascii?Q?2Xe6IRpTSsTNrU+DKHUwmGyrC6VINBhd10VjgnBrmW5528KnR9Hx8mH2/OTJ?=
 =?us-ascii?Q?Lj7lp6ua1ipHNomOo8T8fE7xEa2prmuDNKUo/mEMFxM9PGxJabK3IQ+rnZY7?=
 =?us-ascii?Q?AjZ/uIhl3MVCjp3qfLYMNrG8COT2ebFzOwl8wlc7khWeqGaO+ORiZ97TmTeV?=
 =?us-ascii?Q?Aq4XiB7+ZEJUFmsujT32SWNd1HGxdo1AAqI6qXDz3e011YjVPjtuIW7ijEj3?=
 =?us-ascii?Q?PD4sfAb5bNj91VRz3w3XzAVEkex+9HWew685cUHGL2ukmoZPmwexwBFMUshp?=
 =?us-ascii?Q?msL5j2w6x6bOh6uX2LACWvdBeNH0POaPuwR3sjIbfFo70ioPRPM/NtUzaF2Z?=
 =?us-ascii?Q?UrNu3C8TsCW+2FRalsYAkG4WYoy2bzb3oxWALOyTy6KNEEGySqtB2cp4YH3X?=
 =?us-ascii?Q?Dso84Ko+nxjSXWAN/6dVWfbzBuvWTEQOVXv4eMWIOrdED0Zw4E/qntBvxthH?=
 =?us-ascii?Q?sxlC7D3BXYyRWUhV5PBUQ8Kos1am9t8K68+6uUWooe8fYTPTdODeTAIv4Kf0?=
 =?us-ascii?Q?ejChpGiSv12GfpK0lD55DG0zM9ch7uJuxXLJE9WK8x4GHQef2D0cukLNQQT9?=
 =?us-ascii?Q?8UdbKpwY3ybhMIqDDe9kEGfpzWmIfnikcLCge7Ctze5ePibUn8qRGiD2UC7w?=
 =?us-ascii?Q?cPeUhgJYeM2jBV9/pB9rSJGI3bgwQKfYjTiZkxrw6zng6q4XQxUmhBaDZ8Zk?=
 =?us-ascii?Q?my7AntW5HB7h0dYk0nQCxA+8Y9KZRNoaF4KCvjtp7qW7cxJD+ST2MGVfm454?=
 =?us-ascii?Q?PIauXgzYWqnZ6KLCDk4eWtfgUaDr3w2WnWDGXKa1eeIlGNjLVPQunu4eylA6?=
 =?us-ascii?Q?KXU3Xe9PWB6QzMOuUfQ4t7EW2wUYjKjSRB1NPjEwdyBsXeNrv5UuMTQ3Lw4h?=
 =?us-ascii?Q?WrQiD8OBFLfF72sULJA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 991bd2aa-494f-4438-d556-08dd0de5abfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 06:43:44.0243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8pRTGO/UvS9xavS2GI3Ovk4JI/t2xpbOkXPmjlESEKvaSzHJmo2B/WM3Lty0DqR+SIMDXYQ+TD3WenxrndaHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813



> On Mon, Nov 25, 2024 at 10:29:05AM +0800, Wei Fang wrote:
> > On the i.MX6ULL-14x14-EVK board, when using the 6.12 kernel, it is
> > found that after disabling the two network ports, the clk_enable_count
> > of the enet1_ref and enet2_ref clocks is not 0 (these two clocks are
> > used as the clock source of the RMII reference clock of the two
> > KSZ8081 PHYs), but there is no such problem in the 6.6 kernel.
>=20
> skip your debug progress, just descript the problem itself.
>=20
> >
> > After analysis, we found that since the commit 985329462723 ("net: phy:
> > micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"),
> > the external clock of KSZ PHY has been enabled when the PHY driver
> > probes, and it can only be disabled when the PHY driver is removed.
> > This causes the clock to continue working when the system is suspended
> > or the network port is down.
> >
> > To solve this problem, the clock is enabled when resume() of the PHY
> > driver is called, and the clock is disabled when suspend() is called.
> > Since the PHY driver's resume() and suspend() interfaces are not
> > called in pairs, an additional clk_enable flag is added. When
> > suspend() is
>=20
> Why  resume() and suspend() is not call paired?
>=20

For the MAC drivers which use PHY Library, when the network interface
is up (net_device_ops:: ndo_open() is called). The phy_driver:: resume()
will be called twice:

net_device_ops:: ndo_open()
	--> of_phy_connect()
		--> phy_attach_direct()
			--> phy_resume()
				--> phy_driver:: resume() #1
	--> phy_start()
		--> __phy_resume()
			--> phy_driver:: resume() #2

But phy_driver:: suspend() is called only once when the network port
is down (net_device_ops:: ndo_stop ()).

net_device_ops:: ndo_stop ()
	--> phy_stop()
		--> phy_suspend()
			--> phy_driver::suspend() #1

For MAC drivers which use phylink also have the same situation.

net_device_ops:: ndo_open()
	--> phylink_of_phy_connect()
		--> phy_attach_direct()
			--> phy_resume()
				--> phy_driver:: resume() #1
	--> phylink_start()
		--> phy_start()
			--> __phy_resume()
				--> phy_driver:: resume() #2

net_device_ops:: ndo_stop ()
	--> phylink_stop()
		--> phy_stop()
			--> phy_suspend()
				--> phy_driver::suspend() #1

>=20
> > called, the clock is disabled only if clk_enable is true. Conversely,
> > when resume() is called, the clock is enabled if clk_enable is false.
> >
> > Fixes: 985329462723 ("net: phy: micrel: use
> > devm_clk_get_optional_enabled for the rmii-ref clock")
> > Fixes: 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic
> > ethernet-phy clock")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/phy/micrel.c | 103
> > ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 95 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c index
> > 3ef508840674..44577b5d48d5 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -432,10 +432,12 @@ struct kszphy_ptp_priv {  struct kszphy_priv {
> >  	struct kszphy_ptp_priv ptp_priv;
> >  	const struct kszphy_type *type;
> > +	struct clk *clk;
> >  	int led_mode;
> >  	u16 vct_ctrl1000;
> >  	bool rmii_ref_clk_sel;
> >  	bool rmii_ref_clk_sel_val;
> > +	bool clk_enable;
> >  	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
> >  };
> >
> > @@ -2050,8 +2052,27 @@ static void kszphy_get_stats(struct phy_device
> *phydev,
> >  		data[i] =3D kszphy_get_stat(phydev, i);  }
> >
> > +static void kszphy_enable_clk(struct kszphy_priv *priv) {
> > +	if (!priv->clk_enable && priv->clk) {
> > +		clk_prepare_enable(priv->clk);
> > +		priv->clk_enable =3D true;
> > +	}
> > +}
> > +
> > +static void kszphy_disable_clk(struct kszphy_priv *priv) {
> > +	if (priv->clk_enable && priv->clk) {
> > +		clk_disable_unprepare(priv->clk);
> > +		priv->clk_enable =3D false;
> > +	}
> > +}
>=20
> Generally, clock not check enable status, just call enable/disable pair.
>

Yes, but for PHY driver, the situation is different, resume() is called onc=
e
more than suspend(). So we need to ensure clk_prepare_enable() will
not be called repeatedly.


