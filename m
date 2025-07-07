Return-Path: <netdev+bounces-204475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DE1AFAB69
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7785C189DB77
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 06:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C6127146F;
	Mon,  7 Jul 2025 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cct4Qx3v"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012067.outbound.protection.outlook.com [52.101.71.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D297D155757;
	Mon,  7 Jul 2025 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751868217; cv=fail; b=qGZSoESqZYkyygdPX59NFgstbvAUiRC4ckHcXgX8Jgfhdp12hRBpATLEec2W0NvLoR2MROrSLHERZ5mvoZjoweB0k5iARegb8KALGx8Zeu56YWTut+paNgi0LP74Xk8f2ftIgWeufNXJ/3vMhbwjDIHpGI7hpkxeY4ZNgoN6vfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751868217; c=relaxed/simple;
	bh=HeISLKieU1IZFN7d6Df3+bpsUvEKAX/eDD+j0APsFT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HuUJfJKWxfMLfwpaGFyxRsAT5dD9j7zVgO7lq8EdIFVP0qjiE0YUinbF+XggP1ecw1wSoVZfOfEDzoz18yLINTfzWMAN9r3MRkg9ZURDVG4gLrdnyJlJnHjaVudOwFmqQNL/ubZjW79Tvc2t2RZyhtl+5s6C82YD+xbICCuAT7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cct4Qx3v; arc=fail smtp.client-ip=52.101.71.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nP8fuB8UXg34o5SnwiiYj7pvTBjwxFe/1J8wcbCG1kvMvFHWc+9Zkjrg4B5VxdDe3BBThGtfkB4DkLEAdgUbWdhjOj90vAkaOCz/NQCwDv1lc7YsOVIgi3yTGh+899ZZEt86AevCPWgiI+dZ6ITlKiC4bdHC5VaX9pWnqmJBEvpq4DqraDCSWLRGB8m+I5EW1qOk0XOvY390OgL5ogx64pOIagrghLNsGfx2t/sD8NMNssdSIf7Z5D2fN+hU/oUjLHvLXK1NIFe1bDvyoLDHWE+YAL8zAcuMB1eDjwoNpvoW205uJFTNr1RjS/7ISZ9ZwGIj4SqDtMVzA/Y2f2gS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeISLKieU1IZFN7d6Df3+bpsUvEKAX/eDD+j0APsFT8=;
 b=Flb90ahCrwv0uw1i6RbME55trNayFS15/82bNBCKi8tR1qsrsMrrvGBxd9RtsGUIT9ba8szPWW43R/JHHdYjZYNYCuk01KtMwuOoIjjq5tWgVx01eb5bceesndnbBN+tIUlZjLG3+IVnQU9Kw5CNg5QY6pU4kXSHKvvZXzjlv2r79rzyBACjcZI2nok26KD7wPCHyxtBWO7z++BW8wBsTDxzM4JgiCkBrCJYVYbKqWn+LcrI/CAsmpYXGOHwtzlRySFQtwjrQyBQ+YFRDv5sWWeKLy2WIAwxyJVbIA2DAzzWTtcq4eM7rEb7vrTKRbKPlS21+DCkp7GVxC8QMSDxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeISLKieU1IZFN7d6Df3+bpsUvEKAX/eDD+j0APsFT8=;
 b=cct4Qx3vNmzfPPX5Hv7UJkDHdENFJstyXtEQy3+3V3M7L2705ey0BIyXFE1Qi1kBkP00oq8XYFj2vuXTs4BaHmPrlaKZv8VeqSsoHjpeJHr0pPG+p+cenOqMExG0KOsq1gU0qlwyWKrmZxVS+4SbWOO183QvefKWgdlaxWscYbvshFDlJCZaEdrvTf+/wFiCC9tGhV7RWJoLLy9abTZXyt9G1igMfPpqLJLeHKduDZ/2GFset3if9vyzn9EyMKT0IiKBwRjQlJn1vTTRqBR1OTvqX1bpbjPadilcJCCh8xgwtQhnic2T0lrvbvJUg+Ihm6Umr+jTXXZFhB35WGkvWA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB6981.eurprd04.prod.outlook.com (2603:10a6:20b:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Mon, 7 Jul
 2025 06:03:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 06:03:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Sarosh Hasan
	<quic_sarohasa@quicinc.com>
CC: "andrew @ lunn . ch" <andrew@lunn.ch>, Russell King
	<linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, "hkallweit1
 @ gmail . com" <hkallweit1@gmail.com>, "davem @ davemloft . net"
	<davem@davemloft.net>, "edumazet @ google . com" <edumazet@google.com>, "kuba
 @ kernel . org" <kuba@kernel.org>, "pabeni @ redhat . com"
	<pabeni@redhat.com>, xiaolei.wang <xiaolei.wang@windriver.com>, "linux-kernel
 @ vger . kernel . org" <linux-kernel@vger.kernel.org>, "imx @ lists . linux .
 dev" <imx@lists.linux.dev>, "netdev @ vger . kernel . org"
	<netdev@vger.kernel.org>, Prasad Sodagudi <quic_psodagud@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Sagar Cheluvegowda
	<quic_scheluve@quicinc.com>, Girish Potnuru <quic_gpotnuru@quicinc.com>,
	"kernel@oss.qualcomm.com" <kernel@oss.qualcomm.com>
Subject: RE: [PATCH net v1] net: phy: Change flag to autoremove the consumer
Thread-Topic: [PATCH net v1] net: phy: Change flag to autoremove the consumer
Thread-Index: AQHb6/kN0injehpluUaqlKVQgcr4zbQh5G8AgARHLRA=
Date: Mon, 7 Jul 2025 06:03:31 +0000
Message-ID:
 <PAXPR04MB851010CF7B11F7C992CFEF81884FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250703090041.23137-1-quic_sarohasa@quicinc.com>
 <20250704142138.3f1a4ec1@fedora.home>
In-Reply-To: <20250704142138.3f1a4ec1@fedora.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM7PR04MB6981:EE_
x-ms-office365-filtering-correlation-id: b3ec5cad-116e-488a-f3ba-08ddbd1c005b
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JpKfDm/Lr5zQgPPSryFep5j/+EJqkv3XK5VzTXQicIXyBevPGsHNXxpQ4m+Z?=
 =?us-ascii?Q?j0P3b2dzQqZEpOaa/8EKmFnWix3RhtiOQBaqGyCnP4k6uK46DmVE9Ii9TOMK?=
 =?us-ascii?Q?tOLWaZXeKoHEFBhJOhosKgMdxK7JmG6XJhsb/d7aJxXeVK9w4aGVWjM0LqIo?=
 =?us-ascii?Q?aoNbixWW5q5IUb3IWFxDwQMuKEjCgYBvEcn2JXy2/LgRqv6T9MOk/LLYy0QL?=
 =?us-ascii?Q?DvgIKLd2+QwOpKqB6SjOWQoGzL0DuQIpVk3/WOoURwhJhIK7YSmg+gTiSQQ9?=
 =?us-ascii?Q?ggPjYs6vrGYFGdH4EQr0qldI5zV1tlMGyqfFmQG06gJQfIe4q2qJq3piki45?=
 =?us-ascii?Q?OQ/I5O+3gy3gcsOotHISSDN57hMOyteaNO9FEFWh9/sGcMJr7mBB4e7Iieyv?=
 =?us-ascii?Q?KA4SNJmXBpyBzntnJRGLkh78gnuaquAy0slClV06jNyOV5VB5sDraMyPE5wv?=
 =?us-ascii?Q?ncoinws/EmMsIE53quWA2rkxm46h35/4an5Hq1wnfWGTZO8U4cMwqx9/DFIP?=
 =?us-ascii?Q?ed7LS7exs0gH7rYgF7ozoiNouk1TdGPImj+IuQSsDpJjp9pCchM+xnSkCkGX?=
 =?us-ascii?Q?vVKOG51iSJfr3GF01thEKlqQ90sicrSLJfaWPX5V6Da4zsksWHb1xRDamIVZ?=
 =?us-ascii?Q?NGHvIF1ln+A/qhC7tpWDuviARdbqrMbLZeifxIgBB4P5u/b4c9EWyGAshb5E?=
 =?us-ascii?Q?p+uoJZKQ2jfX+N2jJRdYOjIgTiV0jyoCpQDyQeiKBJnisd7v0F1O373+++73?=
 =?us-ascii?Q?zwYjnjFwWLnU3mb+1vKfSRr27YLXXTm78oiSUCSnVxRz9USVj/q6dKPuH6uF?=
 =?us-ascii?Q?3IDmyKPGw3XDTPNpRomA65H+9YYAiRbaxxC8mDGdklp+lOpsW93bpzV6KkZF?=
 =?us-ascii?Q?f6Py8CXbOxRqrpC3E+/JDypqfa9m8qi8zF2ft3GoYScvW8Rnx3ifeDb6KrDE?=
 =?us-ascii?Q?tCJy5mdAXUNwcQ3aqscCp+xgg0/cR5No2RQ2TpRt7x80bBoDDekVs/RNMaff?=
 =?us-ascii?Q?4WnvWU0jX29yiz+BoIEH/0iGlwFMbvXH4Zy7WdN0AsdFjTGbVErtouUycVVv?=
 =?us-ascii?Q?IyaWEdkXP7Ry4jPZJT6az5OvG2GicCn9Rv6wxBwQM4ydMGRwIgqldBe5kklm?=
 =?us-ascii?Q?UwATiA9I39KuCzcZbOvzNNTNjETt4GIOEfnXQjvCpdQzbCzIbpyM7RIs/TsD?=
 =?us-ascii?Q?Qw3GMBlMGF1PFWjpCHsRytU+fAfZtuVS+JEgMZHdDfN1tB5KC7obCgKK8j4Q?=
 =?us-ascii?Q?jRANR/HOFRjoX2S2u/xXpj7m7LnTCM7wi+Tq85WnkGn24FTlg0lutaDBOZlI?=
 =?us-ascii?Q?aovPl/CJd8etEQ/KVkvs2906eI1HgR31oWcFKY9m+dWW0nTTsNux4hH21d5Q?=
 =?us-ascii?Q?OrxfiFCxO+nYFr+R0j4TBxz4+EH/KeThiw07iNctckHnSRJ6IkZ7vsV0u3d1?=
 =?us-ascii?Q?cIGkE9aUwJNi2ZgxBiILMOqXLm7JsLkFZcynsTHukQ7pz7lTFOOMSg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i9hrONGIV5cHLyI+lpg5kLFxLJ/I3UYrf/kApk1VWHK5iaysyATFFQHO8soT?=
 =?us-ascii?Q?/qEv6Ia/Y/hDM14v3kWT/emWRzgxWOzHs7rLLzagTA0uMYgBgzxddnMgUcS0?=
 =?us-ascii?Q?bIhfnLxacRhBPs3gI0XIsgP7VUvoyDd8/QoDhWcAWXOsFVRReTPimflI76YP?=
 =?us-ascii?Q?qyxWn27yjvnkgfR3bfpyux065sRTrUGI/AzNiU9pdKs0D61e9MPA1jAPcsHB?=
 =?us-ascii?Q?zVh3SxMjGcPLfMyfi56bwIfr0HECR6b1IyI3ajCFHG+eWpyXaP3xaow1GbkL?=
 =?us-ascii?Q?wr9yZhFhw5eHbbuSDlYeht48BtAzCmnVF0n4gJc+ctPRHhVNW8lVq3MufOrk?=
 =?us-ascii?Q?xTne59bochtoRmZbpKl6ykr7urmEP2egiV9G1Fb5VEml8bf961vzFBV19cHe?=
 =?us-ascii?Q?5A4vKBu6gC1zHggT6ejeydAvkjS6trRRh1tpc1JFOEPCXbdJ+nQvr6EMabXU?=
 =?us-ascii?Q?m4W/dWIhaD8op1zNkGQfZgRVXHxgvCj3p4k3z51pwzJegAk09rdDU016ENrI?=
 =?us-ascii?Q?+WaHQudNiqbaVA5YdNfl/NeCvlmhXaoy1DLUpT+it5dPWdLYJXy6j+oAnkhP?=
 =?us-ascii?Q?QHephkbz1rFbbFfA6a7Vhg5kJ7uOzBCY3oCxoenBu2bBihpieuzXGsNnNuRt?=
 =?us-ascii?Q?zOnsaa6SZVKgJAqkaA7DUVC7KcV5nMhDvp9xHLypweBpaBfjY2V/j1/xAM0l?=
 =?us-ascii?Q?fpA4IJpfY9Xc7wQdhSw3EaW3Nv52SIiJ+/AiPUbjlJV5ulWFcRgBHVgKK4iH?=
 =?us-ascii?Q?XWeHEVLs9rgAgstqoq3C0XuKtuYR42plI3toPclyvM2+/V1JARLgLxJsf2yn?=
 =?us-ascii?Q?Do/P/o80nKWcJFJjhJilxnTRe73Zgc74CpRb5TVxG7K+s46354ngBZ/KdjKA?=
 =?us-ascii?Q?JHvA3KAANK6c7Fwvt/p5j8svJeCOJPiXo05guyicfKTfXLHTnORSoNhDQJTg?=
 =?us-ascii?Q?337xPcb+5UTmAAeGTioj+Ooup0zMEory84BiEv7PIcfUZrW1hy+XgjaXC4Y7?=
 =?us-ascii?Q?Pg9bIBi88kA21xDfsDxErU0NONZIoOOQ1C4UYw167sfKg4JqmQAVZs4TqSv7?=
 =?us-ascii?Q?hy+G0/mWMI3G8u7/2Ud5yVRc5lSqjwS8tBCqgvhwAHDAleMDN43ikgszoiwv?=
 =?us-ascii?Q?fKNinJRk4UpRZ3SMFZdTuwaNhqZ9P8Q47bCHjYqxsTLTrVMlumxlExykJrOc?=
 =?us-ascii?Q?+mKnhFcvae3xXFtLTsozxRgxYAxr+HeCUylWvuNPT3d4NBsqjkiFc4eKh/xe?=
 =?us-ascii?Q?M6ulwsmbrSuGExuohcWohFmclOfHaCvwoIBnXrjlj7iuy54vpdM+AqY/XIR1?=
 =?us-ascii?Q?VqVvkkJG80bLankRVNb/g8JVZmG23h8m9Q84tis1ujGAYLczZBIteAu6Dj35?=
 =?us-ascii?Q?yf9/omOSruzsYLIsr2e5/DjgFpyj5Jgo5Oj2hutor+1RXE16efw5hu7Hj6tW?=
 =?us-ascii?Q?MkglPS80GJD5eueSQHDCzFVibm/UQNrYrZiiVJ0acGT6T75ygUeqOwKzqMGz?=
 =?us-ascii?Q?1G6NGKNA6Bwxprx39feSlM9Sh5c/Mmbc4WXoOleG9iUOjnMhP6LJl9KQ/KWG?=
 =?us-ascii?Q?4O6rmcHPlWxb3NWa/mI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ec5cad-116e-488a-f3ba-08ddbd1c005b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 06:03:31.8633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w26ytkbiYLZtfds15//Q9BhGDmkq0/hFJ7xUMYUl5mSp2xkRCINScThNcLmYMXN1MNyvqxbV/sqkk+NijkAgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6981

> > phy_detach() is not called when the MDIO controller driver is
> > removed. So phydev->devlink is not cleared, but actually the device
> > link has been removed by phy_device_remove()--> device_del().Therefore,
> > it will cause the crash when the MAC controller driver is removed.
> > In such case delete link between phy dev and mac dev. Change the
> > DL_FLAG_STATELESS flag to DL_FLAG_AUTOREMOVE_SUPPLIER,so that the
> > consumer (MAC controller) driver will be automatically removed
> > when the link is removed.
>=20
> This doesn't work unfortunately, PHY devices can be hot-swappable, e.g.
> when the PHY is in an SFP module. In that case, we must not
> automatically remove the MAC controller driver when the PHY goes away.
>=20
> I gave this patch a quick test on a Macchiatobin, which has an SFP
> module, and indeed when you unplug the module while the link is up, the
> system hangs completely when running a command like "ip a" afterwards.
>=20

Hi Sarosh,

Sorry, I didn't realize there are hot-swappable PHY devices. Given this
situation, there are two proposals.

Solution 1 is to set phydev->devlink to NULL after device_del() in
phy_device_remove(). But I think this solution is not perfect. For the use
case that multiple MAC controllers share the same MDIO bus, if the driver
of the main MAC controller (which has the shared MDIO bus) is removed,
other MAC controller drivers will not be able to use the MDIO bus, which
may introduce some problems. For example, the 'ifconfig ethx down/up'
command may cause a crash.

Solution 2 is to add a devlink between the MAC controller and the MDIO
controller instead of adding a devlink between the MAC controller and
the PHY device. This solution needs to be verified whether it will introduc=
e
other problems.


