Return-Path: <netdev+bounces-78478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32E0875469
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 17:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CCD282016
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBCC12FB26;
	Thu,  7 Mar 2024 16:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XGux2vwq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1012FF81
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829904; cv=fail; b=j82QV0M9v+WYpVvktUpIKE8zg4kGWvF+nJeDz8z8C8O8jEPc6hOo0tOQM6FnAM8iufhj2av3tpyFoyrhR8PBdEblAPcvvipwLTEgdjnWtm1vhRhXwk7hw8GadExkHJDpUePU+/+bzMU1C4G8fNP/iJQTyI09iP4oWIFZU1mpX9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829904; c=relaxed/simple;
	bh=M37oIrI55u0eMFnZGOb79adHzSWRY6Gz/4d7vH6mCP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xq3CQInMBxhvfTJmgGUrvbxFXDsUqHHH4VF2m0qea3JyLVLCOxyRnZa92wy8KHJUICh2uyybIzjoHnbOWD9KFNkk+FzK2v9D9FY+fIY2ep4sqLaOusaMgNQKycCbpK5C/3K9ljswPePcbI39aa2Q1UgGqy8jPL15TGaudO1tYHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XGux2vwq; arc=fail smtp.client-ip=40.107.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV6dmbgny+cKvWq70MHV85x+D8HJkzFcYhoFjALlfqud7HkXRC1Qh/DnRLeg9rMqCA2JiKwMCEoDIrwZvJrI0PnXkmeZXNXx6vA/0yPpd8fUWVKZMLMHQipZP65/sbaQKeAa8hYRlg/JfnW5CFMzx25QyTNa1ptOW+6H4lylatYGviOxLNKgcuoEp3GdVHzZl50fSGuAW/GRzemexfFFsXy1VTuYQr05gJwhZ5zodjbtk5ICPs3s7IsPqbsqJLPhZG9y/r1NejEUxLS0lsHDF7145nWfrtM/bveEq8vDLx5oOJ8J4PPTas1E8lj4u50oebYAH7UxIdCVe8q5JeY68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfL90XERuzHoV58hTsBx7leVDp0gZsVoAFVTbt0aU4A=;
 b=KqBWAEWSRoHk3TpvuoKzvXxJbVy/yhdRUDET2/P+WQ/5dFTuliqml1P48II9+FmvY/i2NotcfvvFuMTDftk5X9kqZiUjs8A2l0y0SqcHtToW35GQcDcj/WcWl6pn77SKO9buGfms/qqZn1c3AkYFozee4xFqJkDLC60OeStlL+FBYOfvxJnxYzMPhzDkiLCyOLF88dpSAjukPkeByh0zdbMXhuhk3+rRjkfhqv/qsc7kWCMtrqpGEF7LxoPHX777cT5hATWotmDOpDyAFmczdmAU1dU+CvxnqJNzwJj3yRtJ+eN3jDwpqigPYeS8+tTDNdlPE264LSidHzRrKmoFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfL90XERuzHoV58hTsBx7leVDp0gZsVoAFVTbt0aU4A=;
 b=XGux2vwqtGXUBruv/sHFmtgdgWZpNUUokTU7XlHn23vBg7/ZdWIs7GCiTvUS8ABIbpu81NQT37P/7EGoqeW4jTFdl85D69GlEWWCyvGlzM9ISt5zTHaOzQaopb7HJvtZj3PCwfGZzdBVjX4ZGylZiosBINx2LARoOOwAXwJwHJA=
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by AM7PR04MB7190.eurprd04.prod.outlook.com (2603:10a6:20b:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 16:44:59 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::b6dd:f421:80e4:8436]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::b6dd:f421:80e4:8436%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 16:44:58 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, "Jan Petrous (OSS)"
	<jan.petrous@oss.nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [RFC PATCH net-next] net: phy: Don't suspend/resume device not in
 use
Thread-Topic: [RFC PATCH net-next] net: phy: Don't suspend/resume device not
 in use
Thread-Index: AdpwpO6oyjLCya8IQ/aUYHLqJLKzwQABsguAAAApU5A=
Date: Thu, 7 Mar 2024 16:44:58 +0000
Message-ID:
 <AM9PR04MB8506A1FC6679E96B34F21E94E2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
References:
 <AM9PR04MB8506772CFCC05CE71C383A6AE2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <c5238a4e-b4b1-484a-87f3-ea942b6aa04a@lunn.ch>
In-Reply-To: <c5238a4e-b4b1-484a-87f3-ea942b6aa04a@lunn.ch>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|AM7PR04MB7190:EE_
x-ms-office365-filtering-correlation-id: 524c15fb-cdf3-4a5b-0cc4-08dc3ec5ed28
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yzM5hAuYUM9/K+o6jGkCBx4t3bR4gMrMjebkESsp4qdDWrGD6OIlp8U8v3wDYfRGI5wNFsBWQDEs2ML/PbEKupmHBtnS5iZ1QmpUnTgYWeZW4/NX22amQn7KhIvRReYCqBCk0H1aumfOeW7zCZbcSXT3Pe+Fdlj3ehqu0xvYNMRDoS1Z4R4y0ZUlaFVNhjbiSEmzOtWMJqMLf/WhbI+qCjfltVGyoCJsLU2pVxXp+UDkq7/vIVB/+vOPnqT4GpYEHBnAKKeJtohtVxtbg7Ksg0lRr/TD+T9w4ucAFVpcS119hbQs16ycxyQxH872/mY7klpnKWU3xMnsZmDFnowNF70XQ3S34cqi8jy3Gq+3ZJnkJpjpphTp0ImOdQrtqKBJJsJNNYrpndGGsp8qwmlVaZtDNqOlPTBnLpehK85X7BvXwx/sEFIQtKc3Q2VzY0Np3fEQL6q02Zmm66lQZHV/fk7iYxhsco6ha5IO3ru7Y4EVFv8pJEewdwPy5psXP1OJupQ7zDpstvp0N3GZx42ZRIWLP9S8biEnd0bJjKuYfL/INHaPgYpggrWpM5sQ/I5emYGezaPw1pC7tyCx+f9FmUQFm0Y+qo9hAGXT9dW15J7upB6Hx0lFqJuzWUIQdEpoN/Gpyy9Pi+0POFEH7seVU+6fS5/WXkds43mOp8zRTudPG466mXfS8CB0uRFgCng3KrIdpFedRE5HeIex7NYZBy/ZEc+Pd9agUbgFGleeL+o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nAAI4RcaTTaVJ/f8htrtWS+1AyBJThIQP578bV01GOljuA2ZhJSNmkpl3DNv?=
 =?us-ascii?Q?pKr3ohZLHnVna8/XIlTuGniNf4hoi5eXGXoG+hAuxwEXlgXL1zoaIi8TLDi+?=
 =?us-ascii?Q?jW4HJz8TLW8Be/NRR9EjOqU170/06/aCWsAUwjQWuAlpme7Sqi8n2l0t0xIT?=
 =?us-ascii?Q?ddcXMiAnj1QOwoVp0HofuV43g1zHHVllml/8gMsXCC/1A8J8GFEcE/hWKXme?=
 =?us-ascii?Q?X1yEbJuGu/K8SPQTHano+9YhjOu7RzN42WZCBbaVcNuEMgC+1acoyX6vV6CL?=
 =?us-ascii?Q?k6I6V7flIOND3NJPnSvIdkR0NsIYKHnL2o6B9b2sN4zFv1oIvqlFKz+QJXuz?=
 =?us-ascii?Q?1vxnta/OogF2g+2Ur6LlsJy1JwuKWgHtgBqvooXK8vpb5IbkSFbGAk7UAtlb?=
 =?us-ascii?Q?hV75aDICp7SRYPv7v0i0Org8x+PN0bVCrtI2Yx3/2le6qy2veJxQkuawK/nf?=
 =?us-ascii?Q?LgsPfroU72dUcZHiTpz8A/LjoN0HI6L0kaS/jZUzFKvuwxqK31k+WlyC6HUc?=
 =?us-ascii?Q?IDSW6Zpyx2QiBSUDrJJlTjNpCZ2sgPOE0g9e8D0rOVpReLz7B8abKuQtpRcs?=
 =?us-ascii?Q?YCr36t85BAdBJZolc49sJQgEmt8WzJnkehxIINCAyG1RNOHzr3yJC4ahk4uH?=
 =?us-ascii?Q?yXROWiZeKeTzG4v6ZJrWR0TTlC+cJ6bOVuZZyQw2QnFX4EJtrTc1DFCmOtOP?=
 =?us-ascii?Q?psAh7bqb+mW0FvXS4jiHjq2eJ4HRPdg50Z/ogyJRRrdnPbiBWhmprjviz+rJ?=
 =?us-ascii?Q?xPpLXAdPEHZo0BNQTyHkwjneNcv98sZ14VU1e4mJfTJqev26qBK3cBWYz6Sc?=
 =?us-ascii?Q?TE6Hihghouj/6Ekqj5+YmcgPZl7wx1fmWDIID2iBjDK7IOdfHvl8DTCrFvi6?=
 =?us-ascii?Q?ODRJpJxAfk295dqwQUR3T9E3yrPemRCDJuTi/MPPiRFXaJSOHqSpeBHhLfdl?=
 =?us-ascii?Q?2gld7/WqCkQptg0TZP8BgySfNX3APrAP3qrewu3SuMbnoK+HFoAQBtUExpog?=
 =?us-ascii?Q?IZmmz/sE8/RJ+MJoSUf8Px0UHaz9BJbKWFesaMZ/vh9fdqXnFStrNUei6OiY?=
 =?us-ascii?Q?freY+M0p7Oc7KpfnheqXZGbmLB0ayqrEGwdNOUALooFpLj6Smn61Qkr4w+QD?=
 =?us-ascii?Q?7qml6xJF9oJC6uJlQmBNqMSkXXTkFgtHbPpPEb2TFMH4wOjpgIcsoIvewP6f?=
 =?us-ascii?Q?gxtwj19/Ka/Z9vKt3mO5xLHrd/4q2eugM7Dz5kptY8XEjucL+JYeZCK9k1Og?=
 =?us-ascii?Q?B3lfrFTahnbe30jD+KpzxZHJ2WLvZeGr1jT+keT6hkknoGbgsEew0W4DUFBd?=
 =?us-ascii?Q?UQPFsv49SNI1DHRSBYOr2zdcEo2AIEIu9N49UJhsvYfX3bnqQZEj6c8AAWyW?=
 =?us-ascii?Q?44IBnxyGFtpnxxqD6DO60joejTblSEuNfUVoLfwEYszgircgdjMS5rD0aPi9?=
 =?us-ascii?Q?gBNQmi2/3EjQthwHlGjeCpJUwod85JhFXq6SCl6EthVmq/SjNEkx1Os9bzFj?=
 =?us-ascii?Q?aFrco8LbATxHBZlH1mp2Cyf5LqbRL8MJKhliecTRNlwLdaoFXUVp5int9KRA?=
 =?us-ascii?Q?IlGiQMAB5X+ukAWdzNi0fOz3ww82quGKwvWgPQyz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8506.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524c15fb-cdf3-4a5b-0cc4-08dc3ec5ed28
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 16:44:58.7770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pK7ppxtgWCBd+aNeuK9qHg3c/YXJd32ZZX1eRmaoz1GI3BWG5j/5QBefAJm1T0PfeAD1c3MRet5reJ2TZOd6sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7190

>=20
> > Because such device didn't go through attach process, internal
> > parameters like phy_dev->interface is set to the default value, which
> > is not correct for some drivers. Ie. Aquantia PHY AQR107 doesn't
> > support PHY_INTERFACE_MODE_GMII and trying to use phy_init_hw()
> > in mdio_bus_phy_resume() ends up with the following error caused
> > by initial check of supported interfaces in aqr107_config_init():
> >
> > [   63.927708] Aquantia AQR113C stmmac-0:08: PM: failed to resume: erro=
r -
> 19']
> >
> > Signed-off-by: Jan Petrous <jan.petrous@oss.nxp.com>
> > ---
> >  drivers/net/phy/phy_device.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.=
c
> > index 3611ea64875e..30c03ac6b84c 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -311,6 +311,10 @@ static __maybe_unused int
> mdio_bus_phy_suspend(struct device *dev)
> >  {
> >         struct phy_device *phydev =3D to_phy_device(dev);
> >
> > +       /* Don't suspend device if not in use state */
> > +       if (phydev->state <=3D PHY_READY)
> > +               return 0;
> > +
> >         if (phydev->mac_managed_pm)
> >                 return 0;
>=20
> If nothing is using it, suspending it does however make sense. It is
> consuming power, which could be saved by suspending it. It makes the
> code asymmetrical, but i would throw this hunk away.

Yes, I also thought about still having possibility to suspend it, even not =
used.
I'm ok with removal the hunk.

>=20
> >
> > @@ -344,6 +348,10 @@ static __maybe_unused int
> mdio_bus_phy_resume(struct device *dev)
> >         struct phy_device *phydev =3D to_phy_device(dev);
> >         int ret;
> >
> > +       /* Don't resume device which wasn't previously in use state */
> > +       if (phydev->state <=3D PHY_READY)
> > +               return 0;
> > +
>=20
> This is the real fix to your problem. phy_attach_direct() also does a
> phy_resume(), so if the device does come along and claim the PHY after
> the resume, it looks like this should work, without the matching
> suspend.

Well, I like symmetry, this was the reason I checked both PM directions.
But you are right, it works for me with resume hunk only.

Thanks.
/Jan


