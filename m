Return-Path: <netdev+bounces-150534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB69EA8E5
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B778A284020
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 06:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CFF22CBD1;
	Tue, 10 Dec 2024 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2JyoRKRv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F522617C;
	Tue, 10 Dec 2024 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733812982; cv=fail; b=JD4nUG7yASeWE2VyiGwVEjBScx8kghJ3nCXoWlOH4l7GexjO+7/q9H3IPd+NUtD9VNilo59kw8S5kr75m7RXUnVBO0AaAqGrQgCo371QnuGrqkZZDSj+atFip6d+Wksc9gRs9+2m/lhK5JST3DK2ECCMm+qdl6Vwg/7cLCoWGOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733812982; c=relaxed/simple;
	bh=0miV2gdXsARFjWCyRvO9eVhDOi3qQCKTrICBiFMP9Sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S6+sow1a7GT2GaZCvAl+WOrdhXaQiPfRsS0qPzlnN70laVyHxSExrdN927HmlYfkmdah0bhKA5f0HQSN6GD7Brbpog03ufh1jb50x11uhdv0wJBJytI+jRBNV+Z5n7Get9SIro6bgVFk3zTr/uBfW770f47+9Ftb0Aaw2K3LEew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2JyoRKRv; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ko5nvyLgS03jM84Z5PqQsTrvTAQgVopVjRevRUZsuMAj4bPzzZLwInPcFf1cBKTsOH7btsFkKNetsE85dkVRhRG+c1MIZ/Dij8puRyz1GbN5SSremYxC7r+cNhYEW98nsbkh923/au1iQWXRGhYILrYrYRBCwSawl+QUlte987P8DjLsGswUJbfVzK+3w3i2AtPuLd+uWH3HXI/pFs7WT1GVIguQn4Lf+jzYCVLph5j2f4KPblT8odfs32+x5WuBjQxDy5z4G9BZzGcuMPjyPqwU5y6xrcyAWZlLxUYOsiUC+Hn+b0i7I7rAtyScdLPHtrA0mxpB5MO/LS+Abkal8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztXvGoXnDQ+DcfgGDPK0tN/8ibKhQe83p/h+i/Nw4U4=;
 b=GJUjbgA1WpmacyKHiClC8ctuyjJczCoPdb8TUNYiIi1nnbE65M8OX0ZS8sHFc49GFSKHVF0iW5ssGEt8QXW2I6qcAH/d8iSmYztvAOK+s53I0r0mERrQ4OdTqMAmR0hp7uDs2ESW72hzZujm3kkhYb8QyRvxCqNEQLXmAj62jvVdfH0vUQ4WhAKT4FCK/n2FvnTB32oVwFCCnXVywFEOBwm1u2bfFbQ3vs9bXK96bXJSnFljoo44PfWNfXiUySaCIppJcySaDjrsbJe6EGV5CdcNZACJprJU/omkv7IdBKg+7HHrh+sxkUiARxvl3ZyU3dzFJmkL277tKwiZH0Trdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztXvGoXnDQ+DcfgGDPK0tN/8ibKhQe83p/h+i/Nw4U4=;
 b=2JyoRKRv2qJbKaUhJjfl0CkeZ3CEUybyz9s956K8alZY7PaWr1KIEKym2PQVNfTyYy78jnpV8/amSWolNrGma1cd9Cq/pr17RGTPONbYrGIIhI9Vg3gSptUocUNmxW3PGYRonMXVjuNzLg95ebO9F5tWUS9aP1PmgdtSdmkAzAKOPKWfWx1qd0QbqzwnF+iSRUmupZwhtpquwjWGCu5uJPgmBsXk0/McGtVjXdq+CIE53DjXb7Ys2ri1JAqpzZ+rNRyviIufPVfLpLWUHQKLwABAy5v4T3KKwukWQoYYIpRPrGSq8T5gexfUBa5GFcLnsZkn6usCGsyk6o9grNOPqw==
Received: from DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) by
 CO1PR11MB5201.namprd11.prod.outlook.com (2603:10b6:303:95::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Tue, 10 Dec 2024 06:42:54 +0000
Received: from DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5]) by DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 06:42:54 +0000
From: <Tarun.Alle@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] net: phy: microchip_t1: Autonegotiaion
 support for LAN887x T1 phy
Thread-Topic: [PATCH net-next 2/2] net: phy: microchip_t1: Autonegotiaion
 support for LAN887x T1 phy
Thread-Index: AQHbSlZZlZ6PJbgtY0e39k2j/3+rdbLeI8WAgADkjwA=
Date: Tue, 10 Dec 2024 06:42:54 +0000
Message-ID:
 <DM4PR11MB623920FDDE3B5FCCAA9633058B3D2@DM4PR11MB6239.namprd11.prod.outlook.com>
References: <20241209161427.3580256-1-Tarun.Alle@microchip.com>
 <20241209161427.3580256-3-Tarun.Alle@microchip.com>
 <20d00e72-f342-4dac-ba4c-1a66c8b25ef6@lunn.ch>
In-Reply-To: <20d00e72-f342-4dac-ba4c-1a66c8b25ef6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6239:EE_|CO1PR11MB5201:EE_
x-ms-office365-filtering-correlation-id: e70a54be-8716-4599-f0bb-08dd18e5e01f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6239.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gv+iFdydqeSAtx00YuxmleseN5cyY2xeDNOgZrh4mgiIaO6B4wYz+o/gB3W0?=
 =?us-ascii?Q?n70nlEbGss2IyeR7UiFY3kezwcLQZIwIAOXqTki6VWXpUA1DiXla6LS61pNy?=
 =?us-ascii?Q?eEhjNsY+WGyNET9HFxJgLnwHPYIsvgwIDM0pZjmKTecJVLA1SxTekcL7H9q9?=
 =?us-ascii?Q?PjFQDsRw3sQdXgkqFtKluxN1Co5OjtZhr2c4K+2HYIA39Lyjg2Hcs8GgF2j+?=
 =?us-ascii?Q?PxF/ViQJv8ijvhcM6qLBbX7boOe52KCR9xeHcXAz+eekXhoSvB/fQvtm7MdM?=
 =?us-ascii?Q?d+zNYRBOatM8OwAljMiOBA8GPwtwd9LqwBRfmEuhLBYLIxbSP9y9PhtWIhOg?=
 =?us-ascii?Q?09groG6UWayKkrYx0ZPeaucDYbnUCgJSa2iGCMrxLZzN1/XGsHEI5tDNwq23?=
 =?us-ascii?Q?3b1uAsP0gyzM0B+9oT4+uFCsqXd/qJxIiZro576vxkE+6Qm0asZBjcVmhyWE?=
 =?us-ascii?Q?3wDiQqXGexKxhEoKNJraNp5vtF2I5Q1x8uxrlaU8sMSDSo4LeDTVqWD239f0?=
 =?us-ascii?Q?VszCgn2sZjlqvn5IUtqteFN6XxPB00abesdU7104oNjsvx9cT59HRdWE0hp+?=
 =?us-ascii?Q?6WwpXhqUpQQxnmei2yaSdG40yY63pc/SsI+ZXK55UBomLE4HbGzoLqcYdcjL?=
 =?us-ascii?Q?Ef8/ZBCJBLVmr/hiyEufoueBoCXbPMRjmyrayALz5QMqY9zggbCCMCGmuNCh?=
 =?us-ascii?Q?7/2tuHW6+ysTUAoXdnLjjqO5UUWTl41A3ZS/76MwnK2nD/R5WNZrQk9QWbrr?=
 =?us-ascii?Q?YV795IIGZ5e+Z6zIH/O5r5VHGMKb6PIEPnupG2JlTbMGe4/DTSmJXAklV3TB?=
 =?us-ascii?Q?pX1CB3dCQuTyhyM4+DEe1Q7MvlJhpXO06nDake/BGM5ee/hzWxJy3ta2tWaB?=
 =?us-ascii?Q?4+Ak9su2GPjNvhU1EJzkqwrw7UlyLxJdaHfUYFegEA0Ue07O6WlPlx9yU9sc?=
 =?us-ascii?Q?vj3koDmgjaGvgEHPkVytQOeF7VbOIzK/jX0PEe6FY1SL1CJ2+8Ih22ZtBenG?=
 =?us-ascii?Q?XELO92sSlh3gopG0hXlFIktNRM2pdfE5/7OTFixkjLhsi76x0tsQ9TSmsKFF?=
 =?us-ascii?Q?0RH6ioUwUYxmT55cagJUN8el13bQWfbsxmVKu6l4bWePiLO/pf6KTbsKQLRg?=
 =?us-ascii?Q?hs8w0kFsX32XyHmsEBm5Or9Po2GST8bR8TpOeoeE7WRJShNq2lx9CPQwxzeO?=
 =?us-ascii?Q?gdOEbcUs0dhBuwQzln2OomOWuDU0yBrdEYhOL82w5pQQ93gB0MQo8KvxPxJL?=
 =?us-ascii?Q?8xvmn+Hjt7vGjoYepO93md503fauWSOTBhySzQTUejk42kgIOCLcB2OM1BUR?=
 =?us-ascii?Q?uo9nKLkOoMseAGToVDaYPM8wDxk53tDSrOaPF8eRLaglIzhqfrDwiDzrXUcZ?=
 =?us-ascii?Q?IZb1ccfgoxeVRB9p+DjHL0LcABGjuJu7Ws61rtebLoRX6X7oaA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ADxNhV0zTgkvDnS7BgoGmyRXv84ZfWEE9lpGeeLJF/2bW/8MwMUuCT19qbqd?=
 =?us-ascii?Q?AD3WdDYGkiv20sOWjcyda4MswIo1pSdlbTHvxa0CqlEdzape5ujI/ShCLOJ/?=
 =?us-ascii?Q?GKe29ZatWUcFFahzIGdYrFrg/xPBVv1ju5PrKelOtsrN//YuqqtOpmip0tKi?=
 =?us-ascii?Q?dciEhMlMSq63JAjzaYpMNvtZJubhMk1P31GgjbUv1a2KWsv2ex+4B5pfuLQi?=
 =?us-ascii?Q?GLV39X55Z6s3HBoAXeAlEFJu0iDUW0AogeTenwkPBDjsjLfPNGW2lTJjYbIs?=
 =?us-ascii?Q?JDzCfS+i05XuGBq14Q8zb5l9HVXobelfTk9f5ZcTUh7LYdHvAFfCJCimKsCI?=
 =?us-ascii?Q?WHcVjRxOUprVcBpC8uR4EyYygQwndG5CZpeqBQAzb7itpivRRq4jLFSu0XK3?=
 =?us-ascii?Q?uppRV1PsMVGvCKDM2JZwuBTPbPGrzwJCEPUsZYJAVfVgppgdY7d0yhWcdXqd?=
 =?us-ascii?Q?aeptY85ijbHeTSroGp+mj4BDmop4QNXAUCjYQDTUJIRZOcuEn64+927QhKvo?=
 =?us-ascii?Q?yUpBPMtkzCLAA6EcHhgBrc9Izt7R7/NBEMYDj60uidfADt+sROmA0BFfdsIE?=
 =?us-ascii?Q?H8wGaC7qbcwP2XOeQCmWtkVEYi6+/z8ez9g3EtQF/Ui4FAka3Pv2LEpbTX46?=
 =?us-ascii?Q?zQ5RoJNcZBr8p6T0BINLoKmuHo7fGtUtnEVpBxRKQvcn2dGOY7jToABHVsAh?=
 =?us-ascii?Q?wfyPksXh75ciQhWggKuAZhbHrcPEm6ErTrbdkqjJv+KuX1PoFq1ou2RR2gOe?=
 =?us-ascii?Q?3nbqFW/kbpVxJLyXb8cuBC9UAm22dxGpZ4R0KI247O7Wag6z1KCqy+Uqx+1s?=
 =?us-ascii?Q?EsOjpTFslrNGg2ist0a+ebuyDNRy2XXsG0lpLMhbbmXEXXCiZPBKMg8LaFM0?=
 =?us-ascii?Q?QuSYMaNI6v+KFmKEKVw4KinXzuiWzQMjMyqcP2tu5UAqKu86fAzL7ddLq22F?=
 =?us-ascii?Q?UnjERtvpWrkW3jQvIvn0h69Iq8Lhdd03ocDE3PSR889qMux0afLfkFkZ7v6v?=
 =?us-ascii?Q?nJ7e0UvMKibRidKtIRR8wEhPIrPkvpxEsuGk5hZCdzLWJkA1vEO9SbN7c8u+?=
 =?us-ascii?Q?LPpOgSe88DVRbM9jUn0MkX1Ba9AbCoMVaDC10NdKVYukYXhxeyhVkCLVo/iA?=
 =?us-ascii?Q?Pl2vwWq5E113VUTAtRgGq/YdTHQHxbNA61KG/abc5kdgEbe0xKf6tIREeWQm?=
 =?us-ascii?Q?U97qv7oYDtcFU0VKZOjnJuqw123sOAy/aR/BD1GnP0Umi+2TufdSmjzlfjSh?=
 =?us-ascii?Q?cCuRty4g5KPXpJrS3AxHSwQMGL25qE3Ug/F3gADsY6gMi5baoawvO7FhdkYu?=
 =?us-ascii?Q?NvwtOy/eGhD5yzf+Yun2vqEyBSRoLfpq7fxdpcZwROB6DOzqj7Hhrm7+qZwB?=
 =?us-ascii?Q?ZJkwOec/utbBMU1GSuzacZSmw0K7+xHpR2iQO2bpjAE/Upe942TvydiRrY0f?=
 =?us-ascii?Q?ErJfrBT2nrR34tgTjNKGxSi4+5mIwoNxBtTysFXY1lk1JKZUf/QYWlfas+Tg?=
 =?us-ascii?Q?y3yCvwZLGGBNrF9rAYDh3uzM73eRRDgPrD16DZIhJtob8JB/cu7yuG22dQoU?=
 =?us-ascii?Q?HkKGzck5vmZGCJJtoNb/rbtqlCRmThiSFl1qWYWd?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70a54be-8716-4599-f0bb-08dd18e5e01f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 06:42:54.2948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +10FG0M+C0EHxFGCZOnQMdIOQ8+kg0ius3U434A1036eukdAHirZZnF6AQED1SajU5wjB0SOyOw2mfb4QNYy1lC/prANek30+v+bhMUXdyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5201

Hi Andrew,

Thanks for your review comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, December 9, 2024 10:33 PM
> To: Tarun Alle - I68638 <Tarun.Alle@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>;
> hkallweit1@gmail.com; linux@armlinux.org.uk; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next 2/2] net: phy: microchip_t1: Autonegotiaion
> support for LAN887x T1 phy
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> the content is safe
>=20
> > -     if (phydev->master_slave_set =3D=3D MASTER_SLAVE_CFG_MASTER_FORCE
> ||
> > -         phydev->master_slave_set =3D=3D
> MASTER_SLAVE_CFG_MASTER_PREFERRED){
> > -             static const struct lan887x_regwr_map phy_cfg[] =3D {
> > -                     {MDIO_MMD_PMAPMD,
> LAN887X_AFE_PORT_TESTBUS_CTRL4, 0x00b8},
> > -                     {MDIO_MMD_PMAPMD, LAN887X_TX_AMPLT_1000T1_REG,
> 0x0038},
> > -                     {MDIO_MMD_VEND1,  LAN887X_INIT_COEFF_DFE1_100,
> 0x000f},
> > -             };
> > -
> > -             ret =3D lan887x_phy_config(phydev, phy_cfg, ARRAY_SIZE(ph=
y_cfg));
> > +     if (phydev->autoneg =3D=3D AUTONEG_DISABLE) {
> > +             if (phydev->master_slave_set =3D=3D
> MASTER_SLAVE_CFG_MASTER_FORCE ||
> > +                 phydev->master_slave_set =3D=3D
> > +                 MASTER_SLAVE_CFG_MASTER_PREFERRED) {
> > +                     ret =3D lan887x_phy_config(phydev, phy_comm_cfg,
> > +                                              ARRAY_SIZE(phy_comm_cfg)=
);
> > +             } else {
> > +                     static const struct lan887x_regwr_map phy_cfg[] =
=3D {
> > +                             {MDIO_MMD_PMAPMD,
> LAN887X_AFE_PORT_TESTBUS_CTRL4,
> > +                              0x0038},
> > +                             {MDIO_MMD_VEND1, LAN887X_INIT_COEFF_DFE1_=
100,
> > +                              0x0014},
> > +                     };
> > +
> > +                     ret =3D lan887x_phy_config(phydev, phy_cfg,
> > +                                              ARRAY_SIZE(phy_cfg));
> > +             }
>=20
> It might be better to pull this apart into two helper functions? That wou=
ld
> avoid most of the not so nice wrapping.
>=20

I will implement helper functions for each case.

>         Andrew

Thanks,
Tarun Alle.

