Return-Path: <netdev+bounces-183115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A377A8AE6B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 05:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0F03BF7CE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707152AE66;
	Wed, 16 Apr 2025 03:31:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2104.outbound.protection.partner.outlook.cn [139.219.146.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C2A2DFA31;
	Wed, 16 Apr 2025 03:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744774287; cv=fail; b=dJIsQruhadvM1RVqRIPdLzyfGP/UgBOOPHWPpcZd2kQBhr0lYcg1J6x+w0VJ0EqYgV3e+MCc3dGiikmIJpqYbU8DbxfwDb1esEgv0KAzvEv5kHBbgyvzFPw5QN6KoKfeCc37L+l2ccb0aNin6iTT/zXJpZcuI880YbwmbECI1QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744774287; c=relaxed/simple;
	bh=nOjyEwwHMKBAwc2I3YFWjTEdVfmG53jOuXD6ZJeJiyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9btff/LuZ0e+kClquO6SH5e1aaqzINk6YnEsi2PfPuTCwGNxyrV/sImCtRAP8MmcvTW4kZqTIlEPl1N6XSaBjyuCxQQ+siFETJOn+DplnQlYCZI+PV5Fz9k81QEHqf4USf5jdY8TD6EQ7wO6zvlYan+J4ATHJY2Vs3p4p0wvQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYbVyB4O9UMJplbntfzRmIkZ7e2uIMjtT+NwkqLIx5OoBEjImkkfspCGjAkfj/7bUEs8fdto5ojp1b3si5Antzyf449STVO6vX5/qLtau1gf4tF7bNptFo0dN9Z5l3D1ieFwa8FjuAF84raDOnyKm4eTrfeiiJhOl6wA1xURKvsaKUDiO+bNxrYyPqJhj+JhPTpFLCWIAzT+GQXiWif5zpcrxX6A0qpqG1OBOtc0KSINLShDMUtp5ojvs0mKUkatI84kYM6z5Q2u45R6QKJGx6GSVPlXt8Nsd9ahnAaHWq2E3TVRg4N+Zg+NKsk9EK/46EfAwnZf+cBxrp7pSjoVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEQpyQ8vTr5hrp/ekoT9M9HCYjgSJUvwlK1e/MkH/9s=;
 b=g54Vdm/LiKTmdr9DPBhxeYHiAxQvpEKcLXsfeGuzX70RWvvpIMxFIhNuShiCLxnOr4xBAkG/vvJ2wLh0f9ONz9n9Zn5kz45fkKsdw2r4EVZ7wam4XSoeyMrUzZjlW7gXkSMYuyq4J2olAlt6rHrIW4+c/+7PgnV7PyuTg+oslhEL97IcKEWgMFkaW0GPsPFCzafSyDCOLqm02fIr89WfajJMjknN2BC1zVgRdenDrugosXeAvpAappv2Cpa1N3YN5D1flKbSoi7XJQXqaiqwAjvxAS4M4I3FvQICHm1bI7HtZH246Yz6WiCbsZYYgrprO7vkVyA+2JY8G8y1OTrlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0696.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 03:14:45 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::f06:366f:7b4b:4c9]) by BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::f06:366f:7b4b:4c9%4]) with mapi id 15.20.8632.036; Wed, 16 Apr 2025
 03:14:45 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Emil Renner Berthing <kernel@esmil.dk>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, Russell King
	<rmk+kernel@armlinux.org.uk>
Subject: Re: [net-next v1] net: stmmac: starfive: Add serdes PHY init/deinit
 function
Thread-Topic: [net-next v1] net: stmmac: starfive: Add serdes PHY init/deinit
 function
Thread-Index: AQHbqebhNuVSIJMgAUGsPuly4THmMLOkqoOAgAD9FmA=
Date: Wed, 16 Apr 2025 03:14:45 +0000
Message-ID:
 <BJXPR01MB085530E2951C3A18D79C75BFE6BD2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20250410070453.61178-1-minda.chen@starfivetech.com>
 <840346cf-52a3-4e40-bf38-9d66231366d7@lunn.ch>
In-Reply-To: <840346cf-52a3-4e40-bf38-9d66231366d7@lunn.ch>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0696:EE_
x-ms-office365-filtering-correlation-id: eabdc0ed-8479-4528-4baa-08dd7c94d6ec
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 nu4fcvMZIhU3jX7dHWhPAeZQ0LYYfegmxd28FHcCIfkd6VAn0q14hJsFvcoUzUM6SEYoufI2tSAijg75svifWoPk1XsycFuCj/QcGHq8ZKKr00rQLdAVctH4MMJCTcXvO40RMFjaI9XuHyCAKyru8zTq+32jf189oll7rJ7Zq4jlY6/f2jhbV+f+K1c6R3c+j+CUDAhUMrSIInY1akllJ+9cupGJAatxFonJFCn93n/3kBwXEEHKXF5dPTi1XBsOCoUuCak1yRE/4xax9kR5Qoqg58ifgbG2xSW+i+l+lIoDe6U9TlzeDlfyO8XVN+dRKladpwxJZjPyjAOjJaacAPrdxuWrJwjU/gmp9J0fNXv6ptKoQI/9p2SsOugF5Mx6f+Uif3laOssQK/p4Ydep/nYSSEiELpk3GsKmPJFxF8a0TaVg9S4ESCHiM0jsnyhpAcat/TDnVeiZLwklyVFFzRIRgWf4C6ZIhaMciIDanPPlNmAG3TS1j3RlIfFsCZBTmfophqzf0TQD4eVOuyLBTtlXqgKCacjbcEY1TwY7sX41GKf4z9dUKPUqN5LtZBBwd4Yu9fGwMo8QsgjGSXMq/MHXGydjYoD4Y5mogoP3rSM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MeSuECLRQiny3+VtaMXelFONWy3HwG7/iVcxxFwujrI7nDn6j3qZYVB7BBRa?=
 =?us-ascii?Q?Eq07ZOGmQs60dFiBP1xz8ALMwOMt6eOAlLQ1FtBzvp6t3LNJRj8t/nhCAhQi?=
 =?us-ascii?Q?1Y5VIoYksGYzERtgkS6mEyf/BYd36PSAGoq+oJ3s9hwEV5z+ka078p88hxJK?=
 =?us-ascii?Q?INAIJYHQTAu+TSi3UX4HnDkk0aIYoFJ8bmz2fil4NoFLh9E+cYcmOpaBUslE?=
 =?us-ascii?Q?xrSJylYVNrgG4O+0O+NOb2c5Xhbs9uCH/yCwKh9CzhBj5uDFH7b8ejJR+hLj?=
 =?us-ascii?Q?McpHMeMfSYmlp+149EUyLTCvB08hX42X78EacqMbCY5rdPwcCTJO8KEidsgJ?=
 =?us-ascii?Q?XqauTx8kBoZBXr93t36+fhFscjOd7lP4j1kZsgUw/+t6xeKPN5KN2kGCccL2?=
 =?us-ascii?Q?aDbkBz1k9fdjK7FcIdcjQJkAiqy2olpY3mhzoBVtl8rwItoNv54vVUhWxCWY?=
 =?us-ascii?Q?om3kDLaZBLTJsxp38kgiPoxUxWm+gBX/Lv/6+RsKc04odimgPNEf0zexJ/lh?=
 =?us-ascii?Q?LhabDLgh8dYqxjW6G1D9Au17fwSLgf1BYayOAtgZBBNUhoBM7olwg365QhU2?=
 =?us-ascii?Q?u5t3OmAl51Lbc6zse3ZF/VKPqa8r2xAu21xMoxDPA5x5PsGPsPOiRXUDmiSw?=
 =?us-ascii?Q?eo4xcjTDxOA9FUQ/6oqWkiSUVpBfKhDeGmsIMoKwn1fANw/JCkpQ7WfAht39?=
 =?us-ascii?Q?YqBg4I9K4wnWtoY+Lp8Cdly9xOzDwUj9X8Nv/598N8HRsdFIrdeFY9qbNJeB?=
 =?us-ascii?Q?S1fwBFZsh+7NAARbKye40u+d51S6D2kqPIzFip1n6YyRL8LU79M0BJaU6Q4b?=
 =?us-ascii?Q?87H0KRaPg3svV8YGg5u9Dhlw9EXRpIoYQWP2aKQP41LrZRG+3yRIfGJxXyWz?=
 =?us-ascii?Q?vBd3yg2V2SoNsXl9/cuMGh3hJB5B64e9gCS+t/y2e2VNXEAw/9XTX+PJdhDA?=
 =?us-ascii?Q?Gw7/AsMsLtRPcv86JjwX0+fK9VXHINCZ7A2yNwglZC8+6W6vuevKABVfRPOJ?=
 =?us-ascii?Q?Lm9cevEMkr+0rvmYa6VqzUyVl65uevk/J8UQK1ZKFnyvpYgYDVqO2Z0O6xRt?=
 =?us-ascii?Q?DeW5bWSR7sfyDezZzgt1JNgcPn0fkDikf8al4PMZIUeLW2dV4skhdGp8VKuF?=
 =?us-ascii?Q?IeuLVWb0tQ1sw2gd1+lBMD19VfrSf8BwAMPPORJAiZ88IMk/z73t0hdeyhig?=
 =?us-ascii?Q?ICq44p9aBmP5PaUqSBAvzzp8IQrcT/RUcyykhUkQbWckcLDiWFGOkBf3e3hy?=
 =?us-ascii?Q?WgyX4llaCAsZt2ybKdd3tP+/tJxTiliryUJaFJbyAEzqYcYpa+4tccY2InfH?=
 =?us-ascii?Q?u2CXvhRTUSU1JllT1Jg7WrwmTkB/gmbybKq/u13sIEh/YXD8Li1WbMMMBjxI?=
 =?us-ascii?Q?FTiNC+mbnyrAluwjy3WD8z+jcwc3atQz9anRkITUuYdiPCAFSjrhGh9lZ6Ii?=
 =?us-ascii?Q?I31NYb7fAH6ue8JUSRF/pKRxIWAU2I/uDwAL4kksJItPAva7erxHtK7X4+vc?=
 =?us-ascii?Q?eABepRYR72dlMkH2Q3+cRiyc+b0ofks+2MGfExdz8HI/jv6ylp4FY0sJj324?=
 =?us-ascii?Q?Al7JXHY0VO+dbSVefA5tJNkmGbnnEEPZI0I9yvE5j8iGpj3/OMHLdvR3hIm8?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: eabdc0ed-8479-4528-4baa-08dd7c94d6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 03:14:45.8765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYI0XgArPuN2nADRn4YkR3iEE3JQuaDyL0yGbU49AEX/GdvwNlxXpqKE5WLOsoMwts9QnzeywsxDFnKic2L3WYhvHnQtbbJLZycWtdo3lLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0696



>=20
> > +static int starfive_dwmac_serdes_powerup(struct net_device *ndev,
> > +void *priv) {
> > +	struct starfive_dwmac *dwmac =3D priv;
> > +	int ret;
> > +
> > +	ret =3D phy_init(dwmac->serdes_phy);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return phy_power_on(dwmac->serdes_phy); }
>=20
> static int qcom_ethqos_serdes_powerup(struct net_device *ndev, void *priv=
) {
>         struct qcom_ethqos *ethqos =3D priv;
>         int ret;
>=20
>         ret =3D phy_init(ethqos->serdes_phy);
>         if (ret)
>                 return ret;
>=20
>         ret =3D phy_power_on(ethqos->serdes_phy);
>         if (ret)
>                 return ret;
>=20
>         return phy_set_speed(ethqos->serdes_phy, ethqos->speed); }
>=20
> Similar?
>=20
> > +static void starfive_dwmac_serdes_powerdown(struct net_device *ndev,
> > +void *priv) {
> > +	struct starfive_dwmac *dwmac =3D priv;
> > +
> > +	phy_power_off(dwmac->serdes_phy);
> > +	phy_exit(dwmac->serdes_phy);
> > +}
>=20
> static void qcom_ethqos_serdes_powerdown(struct net_device *ndev, void
> *priv) {
>         struct qcom_ethqos *ethqos =3D priv;
>=20
>         phy_power_off(ethqos->serdes_phy);
>         phy_exit(ethqos->serdes_phy);
> }
>=20
> Pretty much cut & paste.
>=20
> >  static int starfive_dwmac_probe(struct platform_device *pdev)  {
> >  	struct plat_stmmacenet_data *plat_dat; @@ -102,6 +125,11 @@ static
> > int starfive_dwmac_probe(struct platform_device *pdev)
> >  	if (!dwmac)
> >  		return -ENOMEM;
> >
> > +	dwmac->serdes_phy =3D devm_phy_optional_get(&pdev->dev, NULL);
> > +	if (IS_ERR(dwmac->serdes_phy))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->serdes_phy),
> > +				     "Failed to get serdes phy\n");
> > +
>=20
>         ethqos->serdes_phy =3D devm_phy_optional_get(dev, "serdes");
>         if (IS_ERR(ethqos->serdes_phy))
>                 return dev_err_probe(dev, PTR_ERR(ethqos->serdes_phy),
>                                      "Failed to get serdes phy\n");
>=20
>=20
> >  	dwmac->data =3D device_get_match_data(&pdev->dev);
> >
> >  	plat_dat->clk_tx_i =3D devm_clk_get_enabled(&pdev->dev, "tx"); @@
> > -132,6 +160,11 @@ static int starfive_dwmac_probe(struct platform_devic=
e
> *pdev)
> >  	if (err)
> >  		return err;
> >
> > +	if (dwmac->serdes_phy) {
> > +		plat_dat->serdes_powerup =3D starfive_dwmac_serdes_powerup;
> > +		plat_dat->serdes_powerdown  =3D
> starfive_dwmac_serdes_powerdown;
> > +	}
> > +
>=20
>         if (ethqos->serdes_phy) {
>                 plat_dat->serdes_powerup =3D
> qcom_ethqos_serdes_powerup;
>                 plat_dat->serdes_powerdown  =3D
> qcom_ethqos_serdes_powerdown;
>         }
>=20
>=20
> I assume you have seen all the work Russell King has been doing recently
> cleaning up all the copy/paste code between various glue drivers. Please =
don't
> add to that mess. Please consider how you can refactor the ethqos code to
> make is generic for any stmmac driver which has a generic phy.
>=20
>     Andrew
>=20
> ---
> pw-bot: cr
OK. I will move it to generic. And I will send the serdes PHY code in next =
version.

