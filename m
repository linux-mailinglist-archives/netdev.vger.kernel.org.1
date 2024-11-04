Return-Path: <netdev+bounces-141395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB19BABEA
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 06:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649932819FD
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 05:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070031632E2;
	Mon,  4 Nov 2024 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="G92eTfPY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCA166F31
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730696410; cv=fail; b=O1DH0V+sdOMPqYoUXvcdSAEUgHtm8/Fg95OLrNCAk8DD7wzrLWuRkiENL05WJcZvhSGohFC6kGXf0WxzE/zsbrXbVmZf67GWU6zSvrfar8wGe0kdWwNszDwYLnyQ50zSv2LMUEpx4jmg7ydAxpwa85jLr8OJXF/ApQuybF47ZiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730696410; c=relaxed/simple;
	bh=zhVLyvikRRm7/mBL0p6wbus9JvJ74pDoeYfGx9zxr3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yo9xYFiMTb/WW07DHW8ky4V9GpcenZTmCrTWOq/YPELxHE5REYGFPHIG/MicI//A0D3Vw82Nmby9F1oHhLaEoAx01uzR5oEA6chlpVnQP5MFlj+8l4sxyXdTpbIzOeb/jI2OpgvMJyFsj4jaW/i+VbN2r/aVfw5dtltSWxgdS5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=G92eTfPY; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w72w9SZh4tR07HOAEzGnd/yFxUdMvmQwYiFwedgIMObsEtLCbElMslinZVbMmbEcgr+F+Vu/caEPQZwwgLaqZmKU5m50s/KPEZYDjxXwBfZrH7QNqdPN6U4ysCvN25iKSHkfKrw/pyTpYDg0m9ZDei4npbuKGDDnYRbED+s9YrY4e9eNnSJoNOENEOfZrHjBSw+4sCvU7CC+ZUjCmW07x9EfORqRdWdoP3cxbaV8/DZrA5InfiMQR5ooNdKxvOpZ+CxAgoWk3WbH2tG0sQN/7DRau7EchpqOC1CciZZN0ZQTmMlx8gOiIIqMaqb99kTaciSJonYQhNf3K5QBomWBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+8E9bwL2x0o/Puhkx2fw12r8Pd2rFBzsWRfzlb2YrU=;
 b=wmxv01zbTOR/LbHs1OMoYCYhGF7JO1TRE+c4Qc3IP5OVxN5K+mr6TpsiCJvlKealEqG6s40m4AJvmkE9gsnS81bMNNHrFZW9U9u00Ag/WnN6NR9gO7QRELRUdPItJiw7KCGjUq/Ad7yGK8pFBShlF4HKezLlbbcN8JSiH0VX+wqEnOLxct2iMfZPMM5l+cPZg5la/FCpIBWrVzEv5bTPazPbrVcQh+6IuoQLuKSxrrNrVjRM0+sZSldEsesdlv4oqBWaXLPG3AmF9lhklrDDgjcOUeIHAZBsBqAuuHzk1ZgMuBNpS+RdvVaaGkPVq3NUrgq2OMnsuuf8pO0K3MUeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+8E9bwL2x0o/Puhkx2fw12r8Pd2rFBzsWRfzlb2YrU=;
 b=G92eTfPYkJNzfRSalk8yGXDIBEeIhhG1nKw5xo5RtRDltaKnzpDaTuPljjfKgZzPrOuyi6lN8p32GHNINEkwRmu1sYtcXFvFRJeSfJhp/NnN7iusS9wQN6liDtPdjBi2UYTQKJlJe7K6l+5ZsrPIJj/FFa/ihwYo/2pk8hEUh77kWPkYgATl+736D06IfEszsPXUkEW+8sOv5Rrp47KQO2wsbBuxdKwHS+8v67f7cdDXWENxlG/rwvQ2fjCkWBMtig1KogbdmJ8HFfOUY/U4Zylk6F7qXYPuVUrJN/xGnGpMxzMcy2rXnEmqNUwVNy1kKFyXdJ0vHLy9qS3CK8NTCg==
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Mon, 4 Nov 2024 05:00:03 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::bcc7:4a98:f4cb:b3bb]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::bcc7:4a98:f4cb:b3bb%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 05:00:03 +0000
From: <Mohan.Prasad@microchip.com>
To: <mkubecek@suse.cz>
CC: <f.pfitzner@pengutronix.de>, <netdev@vger.kernel.org>,
	<kory.maincent@bootlin.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <Anbazhagan.Sakthivel@microchip.com>,
	<Nisar.Sayed@microchip.com>
Subject: RE: [PATCH ethtool] netlink: settings: Fix for wrong auto-negotiation
 state
Thread-Topic: [PATCH ethtool] netlink: settings: Fix for wrong
 auto-negotiation state
Thread-Index: AQHbH7og/HHJ0FUIW06Hmt24LvS6WLKma9gAgABBgsA=
Date: Mon, 4 Nov 2024 05:00:03 +0000
Message-ID:
 <DS0PR11MB80508EB3EDB6C342CE1D7AB983512@DS0PR11MB8050.namprd11.prod.outlook.com>
References: <20241016035848.292603-1-mohan.prasad@microchip.com>
 <uzwfeeltnozvbdxigpu2mshrr7yjxgkbyrjeyfeavasue63cgn@w3ju2lpjq2ln>
In-Reply-To: <uzwfeeltnozvbdxigpu2mshrr7yjxgkbyrjeyfeavasue63cgn@w3ju2lpjq2ln>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8050:EE_|IA1PR11MB6241:EE_
x-ms-office365-filtering-correlation-id: 09b99960-c329-49aa-de40-08dcfc8d8af9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9bKSVa6xI3HOApXG8jhH6ah/fihg4ILrg7slIMy6Grhjv/zuEhFr9CMB/5l6?=
 =?us-ascii?Q?X72OhqMeHbCcoInzT1wx7nolpCgVD8Gd6Fbi6svOxStB6PBzwV2Nh0XphZrf?=
 =?us-ascii?Q?EXWjULOfIkZhB45Fgw223QMlx4TTbarAg/Oe/7rB4Pb7TmGSEypRDlb4J8zY?=
 =?us-ascii?Q?exRgC2XgCYj+FXSOYN6+0HU3VRtbE2Mf/VGbtyrG2ER35yuHw2we3QJh5y36?=
 =?us-ascii?Q?da1WQtGOU8EvF31Oulx65HI0jucHxZDqDC8mxaSaatnulcE1+88TsdxqPxHA?=
 =?us-ascii?Q?DHtdqQB4e6miEe/E/j2ekPyHQPR3UkARy2tVz3DBtwiusga1zB/BpixMhAJY?=
 =?us-ascii?Q?erdZcHVWFhMOFsl3psTcjFhsXAMeT/quU8DaQyjlpcFgMwMZq5Vl+BIQNj7L?=
 =?us-ascii?Q?Uparh/P3TtsjTwMcWAhvPro74LdOh+jC2emIOvZcnlp9aLTN6OkYBvMqR06J?=
 =?us-ascii?Q?2UHi/rv+hmaHZO9Y5lzBKA3vck0AQi7Dp5CFvfMKWIo3oz4jJQSza80Ld3I2?=
 =?us-ascii?Q?O9kl2KZg/er4DrF19AhlEZnmRhS0rXuXpaYpgdrfxADGb4uv3OZakYo3YxwY?=
 =?us-ascii?Q?hCi76CjfSeqQi6VU873nkeQaaYqd/NtzKUg+5pHGRTMUcuI14Fm0eN/3T3y9?=
 =?us-ascii?Q?OaZnffv1kYJa/PVvrhiB7QrT9sP9METs3ImISXRdWGJzINxEQzWn0O4Lhbxe?=
 =?us-ascii?Q?U5pKIecR8cEJsSONJkOULogefeOYbijt0urCGkZXeitaEUYS4iIY70f0p6+Y?=
 =?us-ascii?Q?SPA/MDKlGIob8jGLcUs5I9m/cSch0BWGBhR3tU/pnlV1GSV7GuXj9kiOcp7r?=
 =?us-ascii?Q?sxGewBUpD9+wY9aX5mAiiJbHEoWVcNO0g6xnAfF3qMManSh9w7UuXuFDlrtj?=
 =?us-ascii?Q?WRj/SSd0p4hBqi78DC9Sb9TIsiPVpSa9pzql0PQMHLNOLfS9oGrFCvg/RzSs?=
 =?us-ascii?Q?1H/CXyaYCPaX2AHoDcMKdqnQvhOSvovaCKOCjo77E/LwvbZBCXYo7gIQZEP8?=
 =?us-ascii?Q?lxptJiEcygZG/EM7d7xdNMnycxIH2ZTY2sYbyxJ29/DdaMTJDci38dqdTTRF?=
 =?us-ascii?Q?JTQWlk5fcq+F9wJcv0HsoYYS7b5SyFMeDkEne+ewlDf4OdHzK+H0WsIT/HGN?=
 =?us-ascii?Q?pN8CkVopLYfTMNxvM7zyJg0tu71+C4l0dgk2rHhG24/UmnbCWP0BkuDPIo+n?=
 =?us-ascii?Q?9fQ1ZUGa+vmXfRdZk9SGTCytOWX8drFpeB9i3zcLaOjzbDIGVzp8dDYX13vD?=
 =?us-ascii?Q?yKGGxfkf7xNPsAUxMaG0EqRCDuJ0svEoe+KQVUODwFPlup/eZEICt/2a3A/+?=
 =?us-ascii?Q?7kBEaEAdbGa421xTKCrjdOGLhfxsg7Jl7BIwII9T054rnZjpr/HE978G/j34?=
 =?us-ascii?Q?R29cEMA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BYTzLQSIPb9568SaCehWvnVgAmrjdCQvj0T8zOyjjvCWRdjwQZMe3BaTfB61?=
 =?us-ascii?Q?3sNVllugymqdhft+i7Slv7gkVBqV15dVItrDn8ssg5ITX9UVRbbCSj/I7sgS?=
 =?us-ascii?Q?+18kLGRDMlRqdtGCQ4u+h/zN1URJ7VOkL5dONMKUoR6zIPxeY471bXUCTJbP?=
 =?us-ascii?Q?p3Gq6+TRQ8gtdHE5w6r8lgLqQ4hq3UxPE3YQbXS7TjnTgLWyh5VZnLAT2p4T?=
 =?us-ascii?Q?WCCh5ilCtLTrQPeADTc9WrxMSHJYzJOGbz2blgpcGtC2Z1Pf4M+Yb5/eH59C?=
 =?us-ascii?Q?IBSeFcdSMJMqg0kqNXQ9TdrIpKMBcQKvlVgoLojY8fFOTU2cjz2mp2fXNy9J?=
 =?us-ascii?Q?Eq9MH2ZoiHPep0TvP7TEpFKelIv77WG/nhyx1GNAxzfelbgOmUhUcmGCyvhI?=
 =?us-ascii?Q?MFjCkxTtNduy0FLwexhuJGjklpwHx31xq1EOlRhBxQbjSL1AK1pQ2DYekKH8?=
 =?us-ascii?Q?TO219af78VrATNIpIldAj4XJkyCgpojiFcYYEKrDSNv5yJX9r7xVoo4GxE5Q?=
 =?us-ascii?Q?8vS0Ee3J3EqNRHnaVjC3pLYEHcQlryGdiV9BMYMmiS2eYQHD6f1gIdn2QG49?=
 =?us-ascii?Q?+yi8kJm68nINIr8IbdS7RUgeg9PrCAcZ6IaZOWlMuQf4WEb7uEi5KpwbY4XD?=
 =?us-ascii?Q?frwV6Xw1j1IepqQJrUyX5pUBLxyT5OH2tEtF95UjjQQEsKp41sK+BnWAND/W?=
 =?us-ascii?Q?DhTWmWNkkmxMij1UPj+ROnot1kurcrivxaS/yqd9sZ0WRl+BqisuaZoooeVX?=
 =?us-ascii?Q?8czb9DiaUpkfLHcN/ndav6dwwucVs+TrqVoj/TY4qC4ZEcPKfzrAxTeJJsDb?=
 =?us-ascii?Q?t58e36Ky7szNPeQnrhvi1bvah8R5LBc71TCt00Dfh/BXeyyrjqddgWDb869q?=
 =?us-ascii?Q?mAKf7PnRGpHd/RxeMEn5+669x//kld+bzlp10UJTwL3gHHBrQUtuyxA0EKky?=
 =?us-ascii?Q?uGKM5l5UZfiv8jrwt87j8nSEJr7WVPlwstz4HdRtA7X2I90/b2DzjevaZpLd?=
 =?us-ascii?Q?MT5C572gaMRRJbxCWqt2eWoaYhfYzZ8mCQfaVhw/H4KOZhsb/u58zLxhLdiq?=
 =?us-ascii?Q?YvJGBtTRumMc1G8RtN94GBJuy3wJt8MMkaIUVUHcq/THz56I+HDh2pHJ+OXA?=
 =?us-ascii?Q?LXoBAhn0D7EjG+9aw0+6P1tOqOp4v1GHZQWts9iDdccdkHLBDLXk5ViyI/vn?=
 =?us-ascii?Q?DTij/gKbx3v9H/0d+p+NA3ZFn9crHhyW50RH93pRjwzcyTVxl12A7GUerdLx?=
 =?us-ascii?Q?7Up21tAIMvsY6fFuxGQniaF+QieEwvqGOHHCpKN7DOq+xn90CJ3OOCJB2EiW?=
 =?us-ascii?Q?VZYZWf4QoB9cQjGjWwJV1FJNrzPA5vk1a8E3jCBJSBv8SqJKAoZzfahFC7Vy?=
 =?us-ascii?Q?/wi+fEK+g+bWI9AN+so8kawb88HLsnaiuT5WSKXKp7nwlWGNNFrsNUCfG9ur?=
 =?us-ascii?Q?G0WfwOFO5hGQJma3hMG5qERzJXtl/q6bskFGha8EOHx1dY4zCFbIucbpeMjL?=
 =?us-ascii?Q?SqmNQUoXlrpawgAzsSavc+bVRCiDyPVsU0V8XvY05oCWUO39dmAWS5BqaoVM?=
 =?us-ascii?Q?wYv21OqNzVszJyHVFHVEgAmLsk2aD/8Po919iH0d?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b99960-c329-49aa-de40-08dcfc8d8af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 05:00:03.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPoD2DApSVe3dMUu0ugDB0KbTD0yOHo3UVu/pSwO1g5UultDx1l8t9ZJfuFrZ8Lmisc3bMuduVsASV26+ylYpbeijtCJYplGNQNoF+hTmzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6241

Hello Michal,

Thank you for the comments.

> On Wed, Oct 16, 2024 at 09:28:47AM +0530, Mohan Prasad J wrote:
> > Auto-negotiation state in json format showed the opposite state due to
> > wrong comparison.
> > Fix for returning the correct auto-neg state implemented.
> >
> > Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
> > ---
> >  netlink/settings.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/netlink/settings.c b/netlink/settings.c index
> > dbfb520..a454bfb 100644
> > --- a/netlink/settings.c
> > +++ b/netlink/settings.c
> > @@ -546,7 +546,7 @@ int linkmodes_reply_cb(const struct nlmsghdr
> *nlhdr, void *data)
> >  						(autoneg =3D=3D
> AUTONEG_DISABLE) ? "off" : "on");
> >  		else
> >  			print_bool(PRINT_JSON, "auto-negotiation", NULL,
> > -				   autoneg =3D=3D AUTONEG_DISABLE);
> > +				   (autoneg =3D=3D AUTONEG_DISABLE) ? false :
> true);
> >  	}
> >  	if (tb[ETHTOOL_A_LINKMODES_MASTER_SLAVE_CFG]) {
> >  		uint8_t val;
>=20
> The fix looks correct but isn't
>=20
> 	(autoneg =3D=3D AUTONEG_DISABLE) ? false : true
>=20
> just a more complicated way to say
>=20
> 	autoneg !=3D AUTONEG_DISABLE
>=20
> (and harder to read)?

You are right. (autoneg !=3D AUTONEG_DISABLE) would be more simpler and eas=
y to read. I will update it in the next version.

Thanks,
Mohan Prasad J

