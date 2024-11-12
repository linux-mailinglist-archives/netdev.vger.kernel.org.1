Return-Path: <netdev+bounces-143998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825419C509E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A64283202
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B869320B81A;
	Tue, 12 Nov 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ET3D+G3t"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1043420A5E6;
	Tue, 12 Nov 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400117; cv=fail; b=nofNf1/ZhsPmRI1StLKm6G4IH3XbHCI+z2o2rjpuaAn1OocqjKd8ouF4t+OntCPGJmrNsoWhOHg829rHzyIfEX1p7nj/+R75WVH5oEEx4MtKEOGU5LD+FFEwuqQGzM3mZ7WSV6g1FplozODpqietuTZlUfa/64Gd3QVZHOTcUQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400117; c=relaxed/simple;
	bh=9imQmFXtdbh+9ONQPP/t5YQ8piNAU3ZE57pAq0UVRhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=alzM+Om2Ux3IbAj12w7BKXK2pRe8EEztgbaVUHV+S+vGv8YbOyAfEzDkLASQABDu9u4oWICpbI4o5lJykHLbZpcLp90htrbMs6ry2O55cyCqpbzkNwXmbmJhIbglOlToh8eapOnMzTiCZ5IlklMWuBMJEq3SOSAeiSmIzoZs1gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ET3D+G3t; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6qiw9jBp9IhOqSzZ5upkpF55dyAFO6NaTa28t72OQiR8AqJ7GD4Bmdo+r/vOGwucas3B8Yhae/53NEQ0WVNUJj6OkXY/jruZDvpn1E1sWMPQvok5LDUsVyG0rlvcvtWi1K5fX2s+gljI4kwpYuXmXaxqFg2PEK4noL62+7Y+xiQfdny4r+zrjzdq57AgSoPqMDbLGPFK1ke6gyjjOvP5HwFUctSocxoufDZ69X+Whwjkxzw4PiX0BE66O1elpZrZyQWw/cl8QXXllTl1XqNlaUlLXo3ZRiYSBGEYGeLuRFHbuIXBNBAgyNf8+iyYhoeVRZ6UfSyfm4fMwlv12NqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hKoRvFry4N11r6HAnIynQIxRpSTDrGCN7zqM5+8xLM=;
 b=lVIUvZ8KlN2RRDBAVWql4hs3jHxB1KD9fkLGLfXrycwj9MeXE3dMQJOPEOYn4E3oEu9eI6iAqP66Ngv075Rtnu1dmkfAxM5qNxZ4fySw1uyQbFmPUnLjskwQyBZI3drB/XAlv8/vXwRZyGCstHsYKWJ3wssmzy2hXbl65k3S91RUZWz5JMRYi+56F7tALufH8o1Zw0aIUmA4vxKp/puonkNN2Pf4B0Awj13VLC2EyqbsrWpqkLAdbtIiNZZNria7NnR4MKpyJf+gvLy7GEwTDZnIwSqwdxgKH6TlXnLG0PWQKtxP3Ya0LRjjZqS+Nc0Wmh33yTAYNsrL1RudlMQHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hKoRvFry4N11r6HAnIynQIxRpSTDrGCN7zqM5+8xLM=;
 b=ET3D+G3tm3NXPtVAUIgbFsYAfraz915L10MgDPse+n3basaVD7tRLTrsFGP5ahz96RmXU6OwriHY0YYIaLISEhtgIK2c8ZYl+4XrJumDujM1DCtbNb+ZZK/5U5W87z2ndUtsXYc98l8qN8ZKD1fIGPvmx5VDjn3nJHQP0FzUpdu7YCyg4YyLXCZVBRF1QubJHG48Gx/ZXgE1YY/4aPhXnfBpxuBY7digzcFXQ63IcPGvr7WI032YWSxT3C7TxsZKpmb0WOYfH5/PyTzKLv2ohpPEW1D4ej2XY5EUuNxMC49vUgQ3YPeVXXt+2m5o0a+qXxENeDYZNl1GnkKov5bvuA==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 08:28:32 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 08:28:32 +0000
From: <Divya.Koppera@microchip.com>
To: <kuba@kernel.org>
CC: <andrew@lunn.ch>, <Arun.Ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>
Subject: RE: [PATCH net-next v2 4/5] net: phy: Makefile: Add makefile support
 for ptp in Microchip phys
Thread-Topic: [PATCH net-next v2 4/5] net: phy: Makefile: Add makefile support
 for ptp in Microchip phys
Thread-Index: AQHbNDl/oz65vmkd80q3/wN6dPij6rKyYL2AgADwVRA=
Date: Tue, 12 Nov 2024 08:28:32 +0000
Message-ID:
 <CO1PR11MB47718A7C7187211B9ED231FDE2592@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241111125833.13143-1-divya.koppera@microchip.com>
	<20241111125833.13143-5-divya.koppera@microchip.com>
 <20241111100739.362264fc@kernel.org>
In-Reply-To: <20241111100739.362264fc@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|MN6PR11MB8196:EE_
x-ms-office365-filtering-correlation-id: 68234fd3-5a46-4da9-cc15-08dd02f3fe57
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N/o9emWnWT8uJ7Lval4GM7frQK+pAcO3G2NXgPOGztrzZSIgf6LyZ2ifXRtr?=
 =?us-ascii?Q?9bmBMGmFjeJ9neTjVqMtZoT5THk/5MAyKiCNaV6Xu5wqCQBj9Jq3JxI4OKOI?=
 =?us-ascii?Q?7y8OT+bf3DU1WdMKWTIE1rpuhxYfvsCVGk2qfDPnrMvWGo/b+OqPdNpNacUn?=
 =?us-ascii?Q?tDayhY07/4J/balp/J3ArJcFVr5uh1K7YQ7dVKbqF9+Bqp2s4FCPeJrNrfsA?=
 =?us-ascii?Q?aFBk2SqMByXhxl2MrOKSxYTMbIzFsM852OX2L8zF/zUrcX3C0RMeX8MXnNmv?=
 =?us-ascii?Q?JWO3ZzScDerXfG4aCQah0o+6kK88Y8eBKK4Xz6ETrZPPU7Fk41bwv3X37UGR?=
 =?us-ascii?Q?7FTTxRYQ5hQ3dK/yJF5x74TXueCf3fQceUcNSGv9KWn1h69ughswQEvBMQf5?=
 =?us-ascii?Q?4Ho3IQfa0yEYUitIqVj7rjZlOxUsmeCD5WRn2r2KlyicFVAndPflj3hu4bW5?=
 =?us-ascii?Q?appnUWlt5dOoRWvN9mY2a5d2tm5zychdqLCWBlSC9VvbB+HmgH7O+E1W1LYY?=
 =?us-ascii?Q?8keQ/fGvNLUgio3op1jKDnjyJJBCYLbHumu8LGp62Ibs99XiylZtq0ssyJpy?=
 =?us-ascii?Q?aT1o2m0kWzpBRfzarCYiTjc+WXogm+Wjbyxf93Ijf8W/t34e5qFauXnw3Q4U?=
 =?us-ascii?Q?awbvSg0ywTAnAIOF5s8KGz8xrqnwJV2dy4I2+y4hBIPdv+qEcCa1XiKLIiwQ?=
 =?us-ascii?Q?MgwN5hwX7sGq2wut/ZRlOk6NIuTNsUO/E8S4qf6YIPUVBLP95oY5i2tixlYP?=
 =?us-ascii?Q?khU6BlpG1mWODD8l5Bz6vEZ5osdTssVAOGhTMIgHyuTiiOoG5Fa6RLUl5z2k?=
 =?us-ascii?Q?0hSx5q8Z92Is82qoFwRue9pyli98YO9GzciBnBMk92DMZ6KdnMzLHz/8Kqn+?=
 =?us-ascii?Q?BVvLnnpvsbsVXjgRCp3esoBVq2I002TJcg+thP715Oq3Wt1+5n1b8NAQk4qt?=
 =?us-ascii?Q?0qt4eLcFbRLSPMUmouXSkfUgNXmAiz5GpyfWyFxE/oMQsttMGvwyLvKjMzXY?=
 =?us-ascii?Q?dojCt15wvqBqFhRfchjlRczCsqgOj392grccOdNP3TSXw8kTSF8Gi6gfpexS?=
 =?us-ascii?Q?EYAOS56YJzqrci3QPIftNkiXjQIiSz7iUB7vOVpOtAgLJ8Aa1g5DUMM6SqLD?=
 =?us-ascii?Q?Hy8SGwDY82/0da1xzv0qtA26mbR3SJefkFEiGcWYnZn1pB05i3eC6rWiJLeV?=
 =?us-ascii?Q?XnCqlg/0m0eEPTrWzEsLvx3t/4fxXsJW2m0F8UXgEsC8ZS7pi6WyX2DPWMDs?=
 =?us-ascii?Q?vcvENEwdDEZMONjjbsmr/FfpxfTFsXwJeKIdBqFs9jljO0KaASP72ZKPS1AN?=
 =?us-ascii?Q?ipClKCPyqQHFdZ+PeqorSb67Sq67e1p9R3e7VufcpLn+9DWND529Ab9StHW9?=
 =?us-ascii?Q?xzrgwNk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?49QoObNwEhSSDOgEVRtvPySm+5rA5CoyhaZ79OTDQtN7yjuVaYQjmr8QugTu?=
 =?us-ascii?Q?RqlwHV+KmqTbTcQd78/EdwC05KfF4rVyBuZ7M3+nbBaD/fm07Tze0bj+Glmx?=
 =?us-ascii?Q?lkwTs7tEzedNLZ2cirv83JDkmnbShbbELVe8n3BQeNsfSdu6r9RUy/79sEgu?=
 =?us-ascii?Q?9xatZpwbsxgn+8dWRWVUFm0VP1mrtjM1dj+kSNa6wIHMZne8BdD6oFIw0ucF?=
 =?us-ascii?Q?R1OXln9jWmSEIu5B9nrVOp2JdbPv402tGFJ4MykHUZFLobi/ijY2fY/kzDAh?=
 =?us-ascii?Q?ZI6zYwZnUlI7zb0knv6g/pQN8YzQs7qNpozrb04c9h/pR8hQXw7X3kHNgFuh?=
 =?us-ascii?Q?CV6iuOVlOflN3PWW3Cvy0TAeH6SpRWiLcYea1E+72RSJPAdFh+HCZkGrCN9u?=
 =?us-ascii?Q?oLOeYXb7998Vd5Lq3eWf3vODqsBxeRE0EI4kGO7iv/Cbya65dz2RAy1InnsS?=
 =?us-ascii?Q?0KCtx91fU/K+Jus0g+Vjpm968ZmtrVRLdW3E3JqJDb5pBpKK1GOSIouUzni/?=
 =?us-ascii?Q?SZBuPUy4+1TCHM+PX/kBGejQnZ66cak1M0PHK360WoyiPAr0/8Q6fziVesFj?=
 =?us-ascii?Q?YbiAYoUknuWfv+lWsKdtiigk1NzxTIe/BF4mqemASpyQVS39cboV/LeVnkco?=
 =?us-ascii?Q?/gTzdCaQAq7EPOTv+jT87W+9iEiLMs727bdiADfEDqYV4TYWnznuZOvcQm5c?=
 =?us-ascii?Q?x1/LqQSrh8nUkeUfw5RzCwcknn7DWe5fFblc8hfqB1LvJ2fqcHcHhMgeLA1C?=
 =?us-ascii?Q?Our0xCaZPYjtzRWBH9q94HluNfk7ZnvRmAHqmXh/VsZuCNKauNv5NwpPRir7?=
 =?us-ascii?Q?Sgzdix9Q87GnHMfXnU4TL5D5hIAYfFS+VJfKYUa/gY7SGGE1SwXVL6q8h3xv?=
 =?us-ascii?Q?KwyNPjKf7XHfjdbSKmSHZcnzm86Vnv4VObpZshBEScAaI7HYje2+ToWFxm6D?=
 =?us-ascii?Q?tox4IYXqP0oMdrlzaM1fCqeTCfjdUZpmxHXcKzCGKuFm0Zi8VYi+ddUvT1/w?=
 =?us-ascii?Q?6Xjt8tXON5WOcX1notAdFYjB4qeTtw9MZyG1UF2FzaXjlTt9og6p7BMzQ7EC?=
 =?us-ascii?Q?pv0Q8+AqwiGp9/oh8Mh7+4bTrVRzy63IW+7ObiW1ZlKsPok5q7C+85VSfhFC?=
 =?us-ascii?Q?AUYMA+dG8QHCAmVwUk9CeDmwnG9Zyq8IcM7qNSiRdy6ILgbd2M50gXQYDvfr?=
 =?us-ascii?Q?o1VVysSqVLw9w4U8HwlyMkqq9CyJN234XLoa+u+Sf7QBSI3AOQYgJjw7KnBR?=
 =?us-ascii?Q?LNDSdoJhzhyCOVUPYlff63qB7xgcEQJOkyeg2T5QLDWLGxMN2bZjoHV+Bmhr?=
 =?us-ascii?Q?rgjiX4pt7TjLulgMFIxuPXyGPgfL4LMk2eyw+fmd3OMSfwghfvHXo3yxE6i0?=
 =?us-ascii?Q?fmf+BbD5CI1G6sEsZw/iR/4pOEEPo3+mECcDPovWrlZw3U/teBYXItpftHhK?=
 =?us-ascii?Q?C/SC8FWB+iDuIt7/lwrqwPv+dp+260FNzGOPM9oysLBlxX7vqBPCI/PwbVWK?=
 =?us-ascii?Q?rs1X16Vc0fu/0DoTiN7hgKmEkWSVknpJ2Ar6U0cycp6ImzQNDGxWr/phSMiV?=
 =?us-ascii?Q?exLorM8DbFYYANxCASUK2ro5FhZz6RXkhjbeY0TqcNjUWWxcPiZjbOzxuLZY?=
 =?us-ascii?Q?Bg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68234fd3-5a46-4da9-cc15-08dd02f3fe57
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 08:28:32.3708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrXsupSq94PoZIpzMRl4eSHRX7Rk/e6LjWhlqkmlLVMz6mCxxphR0oyHly3C6+chffNz9chSBdPiB5V64V5VFMO3Bjzi5aiL7LWHpoVqJr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196

Hi Jakub,

I will fix this in next revision.=20

Thanks,
Divya

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, November 11, 2024 11:38 PM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: andrew@lunn.ch; Arun Ramadoss - I17769
> <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> richardcochran@gmail.com
> Subject: Re: [PATCH net-next v2 4/5] net: phy: Makefile: Add makefile sup=
port
> for ptp in Microchip phys
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Mon, 11 Nov 2024 18:28:32 +0530 Divya Koppera wrote:
> > Add makefile support for ptp library.
> >
> > Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> > ---
> > v1 -> v2
> > - No changes
> > ---
> >  drivers/net/phy/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile index
> > 90f886844381..58a4a2953930 100644
> > --- a/drivers/net/phy/Makefile
> > +++ b/drivers/net/phy/Makefile
> > @@ -80,6 +80,7 @@ obj-$(CONFIG_MESON_GXL_PHY) +=3D meson-gxl.o
> >  obj-$(CONFIG_MICREL_KS8995MA)        +=3D spi_ks8995.o
> >  obj-$(CONFIG_MICREL_PHY)     +=3D micrel.o
> >  obj-$(CONFIG_MICROCHIP_PHY)  +=3D microchip.o
> > +obj-$(CONFIG_MICROCHIP_PHYPTP) +=3D microchip_ptp.o
> >  obj-$(CONFIG_MICROCHIP_T1_PHY)       +=3D microchip_t1.o
> >  obj-$(CONFIG_MICROCHIP_T1S_PHY) +=3D microchip_t1s.o
> >  obj-$(CONFIG_MICROSEMI_PHY)  +=3D mscc/
>=20
> sparse complains:
>=20
> drivers/net/phy/microchip_ptp.c:615:30: warning: cast from restricted
> __be16

