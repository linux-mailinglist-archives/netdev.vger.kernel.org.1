Return-Path: <netdev+bounces-237792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C7BC503EF
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84737188A580
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 01:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04A7296BBA;
	Wed, 12 Nov 2025 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iz0P4krz"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010007.outbound.protection.outlook.com [52.101.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425A293C44;
	Wed, 12 Nov 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912401; cv=fail; b=mNYTXWC4ECeazyMyrJiKRSXda4P1l+16CSFKlXss8BUtkJVHkVDoKWkp7lJg6QABsT6dSY2h07vNJtPQXAuU0oYkSpGBlVkFo+YCaFajdLybZmctKqIlCYcB9qNIFoWXVq9jH1JL3yd7B0T8iCm7slh7Nl5zCLLRGMflVgzbDP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912401; c=relaxed/simple;
	bh=SrlRbxI0yvHWSWgoA9yYvy/NG7mWj1+XN93wrii6z94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Euy5Wyu+pujEz214+mItVsQLghywf6bXuajoHa5qb4Wf/iqkDmcOi5KRQPL+43NkviVs9MPWI3D47TV+G++hMrw2FqMKXe+XnrCEtHqGuH0E3oHtid5C/w9gto1Qf6G5Ji2fO/vYOPBU1nxY1+x/3PC8YwbxONF0xjanwU5tNDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iz0P4krz; arc=fail smtp.client-ip=52.101.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NldcohB55LEjrQCbF2SreNcOYLZfKD1VVpwX8BSv9MeNyeLwR4EnPeZmVzHjjswc/XE6D39yyLxyEirSrORSj4F69bJVMZnTXAZG74Zp4GnvvEYR0OBZ35eArRFi1iNwRTEgugfVTckXH+3uKmsLdDG1Bjui7YPJFFNQtGwvPt7GNxkSoMr4GjZfBybKaXb1aBcY0S+XXpOdadWBpG4//oXu0v5Idx7lw7JjrIlU1vnHVKba4qst06jf2A9ceNEL7us/8StbpVUS+otwMJL/fIhyZFWYNO9QxzrKMYi0+qAMGe6QTw/YyOl8werwVxFT6pl8V5tR58UMPJZJySq/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bgber5tEUV9L5CxoJDAoVUtgzsOam8Nt5P1KGkJ8Co=;
 b=tDsPcwARDashinXZkPF6pV70ZSOR3ZegN2EtVYxiq/N+++4mnOcOHjqNBR8wtAUZ39fLuR5sP9pjsvWDXpfOlsrE5KECbNck9lejrrkwUQQdVRX5K8IjB008ug3V1pCq8LaSd2IKmWKm5VSQTg5z4T+8kNjOx2Y+c9sdXfY7MnzrS4tUHxWOiNZFXsm0iVPyByImsEs59gxkVFPqau0XYJtn+839fRFZOL89QEP9OXnxzog0t7QTHFL3rLqtGGyd9+zOcHuVoQOU2P/QaXLz342Z124X+PKz/hhWB42Gzz0br1oRu2JzpJd0FMb1pdxPSbaWUlWh6O88292eN+Y+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bgber5tEUV9L5CxoJDAoVUtgzsOam8Nt5P1KGkJ8Co=;
 b=Iz0P4krzF/5pEAlffiDYZan477GDgWjDxhBBSomnNOufyXLQ8nc4WiDlkhAl4je49cWZZ6buPdQskKbi8iCCKWw/bL2JJYikxDb+0OsXz5AvCLc/UYYq+/CF2uMkpPUckUKGaeVebtMe561AFo9BXGtxpnSXYcxH09Jdqbm6ptusf+RK+SxkQIIiCjE+jrrUMQVWZE0idN2ZW1tWSXHZZl668/0d7mdgeorYREqnHb6tn/uW0ledmJ4shhIWVB3/2DqiWVe1UwnMUVP6NxgXrtV88sSx1PcL0EKvX1Avu1lkw93OYDU4Wxc2UG/ki8aoO2rINvRMpDT82Y1vFwTfrw==
Received: from AS8PR04MB8497.eurprd04.prod.outlook.com (2603:10a6:20b:340::17)
 by PAXPR04MB8427.eurprd04.prod.outlook.com (2603:10a6:102:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 01:53:16 +0000
Received: from AS8PR04MB8497.eurprd04.prod.outlook.com
 ([fe80::24f6:444b:9e8d:6aec]) by AS8PR04MB8497.eurprd04.prod.outlook.com
 ([fe80::24f6:444b:9e8d:6aec%5]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 01:53:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/5] net: fec: simplify the conditional
 preprocessor directives
Thread-Topic: [PATCH net-next 2/5] net: fec: simplify the conditional
 preprocessor directives
Thread-Index: AQHcUvIHSjOTg72StEO1LGc2qBglv7TuDf4AgAA5wiA=
Date: Wed, 12 Nov 2025 01:53:15 +0000
Message-ID:
 <AS8PR04MB8497494755B820A2D33ED39488CCA@AS8PR04MB8497.eurprd04.prod.outlook.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-3-wei.fang@nxp.com>
 <aRO3nMEu/D/kw/ja@lizhi-Precision-Tower-5810>
In-Reply-To: <aRO3nMEu/D/kw/ja@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8497:EE_|PAXPR04MB8427:EE_
x-ms-office365-filtering-correlation-id: d33aaec6-8d29-423d-2db0-08de218e3efc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?a0kWKCBr7jRcc6Wtbv+VueIVpwDQdN06qpJMYJ8/IZMB3FSH4dwXnIXUT2I3?=
 =?us-ascii?Q?hc5zPsSRKr4BvAOty7iNXecisvVohbIYw7ge67vR0YxVtLusVzhOo48K1Q27?=
 =?us-ascii?Q?7MNtSbZ7yIjFU6BpUeq/mC9DiUDg7h+nag1Hp/fL/3U9U6FhBql7vRiru41H?=
 =?us-ascii?Q?eBHW34eaCBhTISuCTobBABoQ4wUpg7B0EMeN259TlS9T0u1jjGGjV9W4Fnp9?=
 =?us-ascii?Q?0lN2ykPE+7Dwmr3+ksnxM8XUuZWYggmSNV4Q1At7v3XAU8rW1tmikpvbZJr9?=
 =?us-ascii?Q?jbbf5nTK2hZR9cwPZIAuHOgFX7JFqEWbl8myzu6EL1EYQITq4t4WtW6vjZVP?=
 =?us-ascii?Q?30OgzbLF9JAifXYgvT73NUScCG66Clw5aKxZTZRR9kI0XNNCFg1jDOGcOeh4?=
 =?us-ascii?Q?eqZuwYfEUG0ByzK2QgQc1/nsvZq5forWPMkuGRXUpM/ZheP8K70Isd+ELVA8?=
 =?us-ascii?Q?vbUBS3AUPT0/8/hMaX1fvEoDT+bdTFWWKG3SfVjdoSUGIGsUG2JkQOQ6SFch?=
 =?us-ascii?Q?9tordtqKsTqBrexien94XwFGSqRE8cd1QUWnAW81mDrsXnwIS7qHZtzu6idh?=
 =?us-ascii?Q?7jHEmcAVmQTYZD1YFI0PPBfcM0Xcu0CrtFneUCY+5U/Q0gXt4BQytl/sC1NO?=
 =?us-ascii?Q?fApsJd+OehxIe65JceMDDaehYKni/2Kz/DO8OFgbO3oiIB8ZTcUWdYR1IDBy?=
 =?us-ascii?Q?5fAMCiaS8F2L7Z5O5h3jmvt9YPi98Txf2Onb1AnaUJhWH/bQVO+bzNebACsD?=
 =?us-ascii?Q?nWT7zPcPxK7CvXROJX6zqeq79i5O1yHZYQfPjTQviI7HnHLDpNsJZf206Az0?=
 =?us-ascii?Q?R+m+5IpzZM1XXvhpMJaIwmvLS0pC+yIVWF4z/v89Q8M4Dj314XpE3zG2guQc?=
 =?us-ascii?Q?TOtshsv5rWRe/NdECE4lOsbo0ZW/5aZEYwN8yHh190LVXqfk4Mt0kZdyqpXd?=
 =?us-ascii?Q?KLGbyRJProwZNVt/eBJCv/lpJu8jnh/bKAFvYjwKES8Byg5CZdwrXFKRe/c+?=
 =?us-ascii?Q?BiZC6IVnFFTMUY7eBCHYYdCmXn+HE4qdfIFzPtbM5+eS40RMnKb1sT3dliNj?=
 =?us-ascii?Q?9d6Y6zVZoeaabZhItX7IhmwW/znyGV+Mf4Slv6LQvxrsYaYSaiatF0kgXE5v?=
 =?us-ascii?Q?3aIMtcWk0KtdGLrAASYLyY3Htm+G23/lMzqSZ2ArXi6FB5nlq/X76+OLdHEQ?=
 =?us-ascii?Q?k8KLZ+6/jiZc3qrQbaDZ9nIWlFQhpqpTGemYCZoJY8PU8Pm1iuZhGyprVC7/?=
 =?us-ascii?Q?WUpQQ5bRipB8Te4AaVQG+hM80veNTt7QDFkrzVDU+CuMSlInFQocn3gbLkIT?=
 =?us-ascii?Q?0SWvtfA6FhTf4Q4uUVWWSJEzpCvh7yOZwmIEu1g4IDX+NPK1p/BxKn5pfnp8?=
 =?us-ascii?Q?oqEktmv7cGqZ01N68p00cdD7VL/KKpuCXxYPOIbYi1ClF8I1NVgkYp5z81+W?=
 =?us-ascii?Q?jZ4zR0I1vUi7ziJ69/aJSd6J6wKl7qmqQ6tibA7vlNMyv07QAdCdHC8mENz0?=
 =?us-ascii?Q?PhGFef0HJ3nLeIiGXdUzgoJ0yoWOHXh8GAO3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HyXvUxZW39ueUT3NfNQgdfEb96YqjxCVdFI1SRkU92oAtjQcSQCl44nZE6c6?=
 =?us-ascii?Q?HDjb2S2IfgsNQyCpMytYT5e4c2K8S2OOvW+LQCpZuogV3029asqnpiP0Luwv?=
 =?us-ascii?Q?zZ+T/A7tqwQ65Xwgg7WEGRWYqBAx+M3NN5SMh15dghpH8nrqIdOhfpN9yyhx?=
 =?us-ascii?Q?s485DyxVRNbKZUsKsRQoc1FyWwBW2VNC/4oeqsQrGSY8rb3saNDvCkpzl+jX?=
 =?us-ascii?Q?xfmYGO92Dd4HMlp4oVYvHkB7O+LkLaNaDVnY22tPO7ZMz28lTwBstRSqdU/8?=
 =?us-ascii?Q?6YME7ATwjrUBJHEToIoA16nWMg3LbMBG6DEmfFGjNtK/7rL9YronQTdlMCPw?=
 =?us-ascii?Q?4CJ+xhxJ4wUX3b79MwbREB+WiLv3qrNwKOhlynzCCn4k1JiurGPyeaM7JMY6?=
 =?us-ascii?Q?oMNU7gUYY+MV7XsepVuhTBlRw1mwiZxbCyjP7T9BvhYOj3DXDi1D2S4AUjOZ?=
 =?us-ascii?Q?Kf/6NIsiKJwEMz54RGq8WlSrHZEhEKxWCH6DnDuSxBFN0G2B6TIJtayqNpw5?=
 =?us-ascii?Q?UPGKhSXMQ1uLyAwfwp3FTObkYkk7RsOc5e/FyEMmAPcBVZXJRY1aecs1Gh3S?=
 =?us-ascii?Q?sze/Fxd820e9zdqDfYWhg7VCYRZRmhh1tCbgXxmRmQNf0BOwsubTCRQTuZSR?=
 =?us-ascii?Q?JXWqWbtaefP8k+Tv8FY9aAINKTF7GegW6gLBf6x5a77p3skoafT4FsLYOf/s?=
 =?us-ascii?Q?jtH/g47kt6FXxTApT8iMk/Ts5tCC5mvWf+VY415yW4M2khAsmtIOhnXjZKHr?=
 =?us-ascii?Q?qhWXWSpeFwB+upxvB1qemNawPPIgDgTsJdy3VWi1SKLpQS3wSZBAmQk7emh7?=
 =?us-ascii?Q?MjxGw1YYt7IEntEQwGvJa4HyX1pPzcuiK6Vbtaddos2PgtoPj/bSZAl5RtD6?=
 =?us-ascii?Q?MCgA6rnEwZoSdlOF/qoviTQlvRToW7wiulRIxuObzjRGdfIaEGUMidATrsJv?=
 =?us-ascii?Q?Im8eW7DsTX764aqeciZQQEBJr6TF/qbLxiU+kynvQZkfkePtUWLjL9iBW2ke?=
 =?us-ascii?Q?qrTE94DQIp9ry7JrZlL9W2pQItFzhBnXBVyxT8aDcf/KB8If4BXT4g5/uCxl?=
 =?us-ascii?Q?8RxAmOHrqKwzJsG5S878GkiRi9aj8yjxEexkX3tr9Q2CWhQ2px7gvbc0SlLz?=
 =?us-ascii?Q?ANKbF2zTkbjEdDuKTI1GX7IQvdsjNdHxDjlhFHXWBKlrUS37x+2L9pwtXhK7?=
 =?us-ascii?Q?8zvJ7LepMqfxCZEnQaeqidiEtRM7aXZgAqtghozwoK67Kn0H3j2COXi+BdwK?=
 =?us-ascii?Q?RVCE19yauxwhkVxaUqCrMDbOrWF8i5+aGlQ3HwmqNu+JPIDREplWbwJFGyhS?=
 =?us-ascii?Q?GLTFOq/ctJApbQJE0xhU4n6pshJP0uSYRMSgpQab09CRWQUb1E+AH7ay/lyq?=
 =?us-ascii?Q?vkAAp28rL2OmmfJSRbW/ZBaDwyfmGPXcqN0DQpwsu4ALWVoyMoUfVgO/JVCa?=
 =?us-ascii?Q?wEDyxz7FNQZEZJoycXFPZoKDGd6TWYZ8gKAX+tgHLzEKiNMvnY0ms4SR5vhK?=
 =?us-ascii?Q?ADTO7ZhhMVPfUJvvY+t4qxRi4hbXEjyrrH2nWPzCaVZC2gZSAE6NA6kJ3565?=
 =?us-ascii?Q?m7/Hdn77jFcrsVxZ3+8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33aaec6-8d29-423d-2db0-08de218e3efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 01:53:15.8285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4/qUmtITun/VLF/ClpgKyYryvrGFQvDhweANjD81N3/BUZSzEDq2AjthRQWv7BzZj/k08Q3H1jLtLvSS+etuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8427

> > -	if (!of_machine_is_compatible("fsl,imx6ul")) {
> > -		reg_list =3D fec_enet_register_offset;
> > -		reg_cnt =3D ARRAY_SIZE(fec_enet_register_offset);
> > -	} else {
> > +
> > +#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
> > +	if (of_machine_is_compatible("fsl,imx6ul")) {
>=20
> There are stub of_machine_is_compatible(), so needn't #ifdef here.
>=20

fec_enet_register_offset_6ul is not defined when CONFIG_M5272 is
enabled, so we still need it here.

> >  		reg_list =3D fec_enet_register_offset_6ul;
> >  		reg_cnt =3D ARRAY_SIZE(fec_enet_register_offset_6ul);
> >  	}
> > -#else
> > -	/* coldfire */
> > -	static u32 *reg_list =3D fec_enet_register_offset;
> > -	static const u32 reg_cnt =3D ARRAY_SIZE(fec_enet_register_offset);
> >  #endif
> >  	ret =3D pm_runtime_resume_and_get(dev);
> >  	if (ret < 0)
> > --
> > 2.34.1
> >

