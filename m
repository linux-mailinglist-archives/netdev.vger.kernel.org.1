Return-Path: <netdev+bounces-25680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4C9775248
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF47D1C20F9C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 05:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151A42117;
	Wed,  9 Aug 2023 05:37:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EC20EC
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:37:49 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2056.outbound.protection.outlook.com [40.107.105.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D861FCE
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pfg66G9MqYIEeDU6dbfq8T1emx3RzXyoGSmlJ+Hs3+ldvoRVyAmQXcU0278ZKrAFOkqPuAX18StLG9YdUlAakLSrQfuotvjprivJC2dFwKlDgEnLLdL2G/c5jB3dw6YjhwS8TuIakNYlgLA6CxozQPu+eHQSQMj9uzqDhuMs5EVb1GnLyMdihj3SOjt7oaZ+6Yzwxdn+0oovrsm9FzMHjRwNpDiczYiVrYF7Pj6gee5WbVrGX2Xb6l77pofzCl2MLOPk0yWs9guc5qjDqfO70Ut1Z1SBL9saDiOsx21SsiKn1UemqYbTAawTUDK01I5KwjBU1YEJfjvtFm6j3ZDa1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOnPAADj5t5RUPDpPPMcMwoTXkTL9BGWpAIA+x9LHSU=;
 b=BpLrEB8HJ0XKhSVVejOvAMNmbnPeZYiUQhKAGxGi4m+/Oi9avMhu2Fosf1DGYgmQABLywNA9ulnqXagtZpLImX3ZT418nOZ5p4SYFuCjaU05ls0/B3o+XPsMZnxlmNsgb/vIq4fcNYCFQx1vjCv3LZTPKKL/9IVgqG3RoHUtYHpe2IL2OHKBe/v6p96IL+Kx1J8Rfc3EmwFyDGJghHxIHy5xYtxYT6/1gpr3diz1ZB59MO7rz80XZKq7PXx6pH/bIGJ/Dnj1HfWOTRHVs0s8LzRIYj62noqpYE2ovKdhUa2VxzzjBE60QIoj9JCdVN0ZGGvdbYPg+mjqow2ioYGp7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOnPAADj5t5RUPDpPPMcMwoTXkTL9BGWpAIA+x9LHSU=;
 b=KIDeqhJVVAfodDGeZxF7Gwp++DI0igrKHMNwD0a+PGBuwPE+1vw5yVJm9h8AimUTsMDjfTb9wiwnHLACbQ0AI5DIXTpVHaM6ayv68DOwDkFXy1Um2+SWpfBGNcTTAdk46E7lmqMqpckmDPxBDO5tCMes1MN/HECVlRqj9SMYEd4=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS5PR04MB10042.eurprd04.prod.outlook.com (2603:10a6:20b:67e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 05:37:46 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 05:37:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: Marek Vasut <marex@denx.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel
	<linux@rempel-privat.de>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>
Subject: RE: [PATCH] net: phy: at803x: Improve hibernation support on start up
Thread-Topic: [PATCH] net: phy: at803x: Improve hibernation support on start
 up
Thread-Index: AQHZxv1ZKz1KraSXKUS2W3fAHhGdoK/gFe9AgACqzgCAAHgJ0IAAL1wAgAAHR2A=
Date: Wed, 9 Aug 2023 05:37:45 +0000
Message-ID:
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
In-Reply-To: <20230809043626.GG5736@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AS5PR04MB10042:EE_
x-ms-office365-filtering-correlation-id: e041f136-6210-4076-7aef-08db989ac25c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yDJQplS9AwxCMdV+3xkiLpdiZcMmT6V7IGeS1X66ApvBYZk8TD58HN9l2aQzAiQ7mWSgRrE75ejs16as9jaUhSwkIps2a/j0w3/7I44qT9ArqCxv0tV4tskXfsS0jjkMNxIHT0lpBm1t4Aa1BBlwwyf03bqQ1UXnlgxUtrjFzEc/ZZGDTAKpnZbRHvVw51kkNuztx/w/dPr82yH5fmB9Iy3B6ATd8D/p01U9AG7K1+lP8CRJEgIwFvby8lqVk93+QChad1JAdmAYlJC6LkjIhX9cGk700yJRRbSp5HEqo7DVzJr8AHffCnFauC7e3rtvZ0Q9+PgxGjmhxX81Gv3dD9Qktqqq8lGZOtjJIj17sf+x1G4fmnBfOPKcEXI9KFWVsHyyPa/RON4c3jYWg+tEEvmnTJM7yBVR7RS9zxznqogiPm48Uac5i1hDwF9TQeVgG87tFXIjHZypfUmJ6+YFyYouuaNmvlOQesFP6lze3yGqK9VE0RLMa235B8VyjPAEvVUbKrsFnxe50S255aZkBFrJiMYIOMesoU0Am8bF7UIE8+UCphGNrlU7aEbUm6sSnMHwE7arzjxVBUgU+X1r9Y6z55X0HdlsURrTsg34nMmJ6z4acUeKZl9FZLIy47pL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(186006)(1800799006)(316002)(83380400001)(44832011)(2906002)(122000001)(26005)(8676002)(8936002)(38100700002)(5660300002)(7696005)(7416002)(52536014)(55016003)(66476007)(66556008)(6916009)(66446008)(4326008)(76116006)(41300700001)(66946007)(64756008)(6506007)(54906003)(478600001)(33656002)(86362001)(71200400001)(9686003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Oyx+agnohLqIPpnNBAoS4iUVcIXEy3qPrgKHlMFqnB/27GmAgEdNNCa5bjnn?=
 =?us-ascii?Q?8xRXK6t+h2+z2Bx/vHqNITmsaaESaxLXpj7SmMT2bJwqHGlB1VyYE/tsadRE?=
 =?us-ascii?Q?yc0xUav3uiDj/4so0pjhXapDO9cjwEuOm7qNqEJ2N3zA7lkvZE0bK+GmJ4vl?=
 =?us-ascii?Q?gWE9G8RgJxIL5lQCL09sZpOLIY32kgg3kgyoVAaMHejXYaI9PO/+oKhSIICA?=
 =?us-ascii?Q?9sRHRZ9lbn0vDoN2XmV/rJJnFd2ldoo4nUtmGnX4tK0fn1ON6WIm9mNhz+WD?=
 =?us-ascii?Q?FolwPPkgjQ7YWiie/SWh21H14imVBzK2q0ypXZSIssLbxIc0d4fa2oIhD5P7?=
 =?us-ascii?Q?WR/CCWPS70DvqYQ27GkjGgXhAhnAxGZ9s4/ggPt3czoo0pWq3pRnqYSaZlLR?=
 =?us-ascii?Q?QTUf2C+8x9055rGccmvr3T+oH73vz7C2IqYDaNTHqeA2zTAXzmKy8qADcCig?=
 =?us-ascii?Q?bLPIwU2nx1l95Oh6zULfLoJgh9nCFivIoU6q+2Mm2pmSItnrCUTyvvcqQT03?=
 =?us-ascii?Q?JMExdbung4zVVBaLVasS3jROTe8t75XEmsFECrOloYyDP67PmZoBlHiauM9b?=
 =?us-ascii?Q?RWposonp7fD/ADE5AYMT+YRYurtGEyrKaqh+QeKnUMexC2rLK5ZcyNAV+lSD?=
 =?us-ascii?Q?M/aN5uzKUGLZyTygylaq+fxIaqx0fc4s3DMqH7+sjeTzZPFZ/fvTQ+2Dopur?=
 =?us-ascii?Q?RHn/czhBdYDFvCMGR4dVkhq1nWOLDZB41s05TfsycGoZRlEVPqEZROfScQEr?=
 =?us-ascii?Q?LHJJfzbsCK2RL/Dbdf+oy/TwF0kOgEBM52ZRpld3BbwUT86mUzy1Ac6twoxs?=
 =?us-ascii?Q?SDwtLe+gpIBL6I3AU21Ts5Z5BNfrjzKPUI9YODxuGy829A3Qt5DranmfgbpO?=
 =?us-ascii?Q?HzltADtcBdmlee6WutcGR3ib6iEQS30xLt48B2Kpv++tGvEY0brKatEwW+Pt?=
 =?us-ascii?Q?B+N+H2ZQbq3orD++BmXImOmrgymGVtaaIqgMBEZKmXOvFGNOE1DSaMus252q?=
 =?us-ascii?Q?gTrwE9oSIhkDsnwhnqgipcnpp6DcYBHe4KZu3jWiwzahZmIiD2ToJvhKmxz2?=
 =?us-ascii?Q?ksGjwEc/eS3cCq1g70OUxoFCPSy1V/7yuTvGH/l9AZmVGRxqIpYgIQiL8sJz?=
 =?us-ascii?Q?NKlpcKOphV6/r1A6h2pvG5RggS56bMRvfZP++zpUxanvJPe2xtIDInx4vuv0?=
 =?us-ascii?Q?MRtIhx4P2fpBimGIQYUQwsCGN4cQhS58trUwBqIsEN3nVWgkFRtFSlKfqRLs?=
 =?us-ascii?Q?5tto7plV1HxhsDfrmsvaO5gXLt5G+KkYq3+j/1aZ9arKmfV1NiCHRe17O53X?=
 =?us-ascii?Q?7oidX/i70zazX9ToLVm1WUz/330+XkosVBFm3mcDnR2H54x/jaLTmZhy5Lr6?=
 =?us-ascii?Q?FLtlYew9KMX5wY0jWBVtChxofReapwNo4VHlQ+2+Vp8/r6vH+0BAG3TzXB55?=
 =?us-ascii?Q?HRB4kRM0qH1vmXDrnARLTT+XUau1rb22N8RBhnU9vs7wOUhfsl3WPMR+XIRk?=
 =?us-ascii?Q?OUT3PG+T45b7L+P9R4L3eoUiAgSbfq7g4GlE11icmnOZZ5Po4kaJTkHrqOao?=
 =?us-ascii?Q?kctjFMfT/KPISkgSKOM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e041f136-6210-4076-7aef-08db989ac25c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 05:37:45.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRDS1pzt0I8iApzzhuXhOES44SEAbQI/BlROhZFMzTnT6QDc7+WEaXujUZBzl79UwVH/1wabPvqxrxlodthiLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > For the patch, I think your approach is better than mine, but I have a
> > suggestion, is the following modification more appropriate?
> >
> > --- a/drivers/net/phy/at803x.c
> > +++ b/drivers/net/phy/at803x.c
> > @@ -991,12 +991,28 @@ static int at8031_pll_config(struct phy_device
> > *phydev)  static int at803x_hibernation_mode_config(struct phy_device
> > *phydev)  {
> >         struct at803x_priv *priv =3D phydev->priv;
> > +       int ret;
> >
> >         /* The default after hardware reset is hibernation mode enabled=
.
> After
> >          * software reset, the value is retained.
> >          */
> > -       if (!(priv->flags & AT803X_DISABLE_HIBERNATION_MODE))
> > -               return 0;
> > +       if (!(priv->flags & AT803X_DISABLE_HIBERNATION_MODE)) {
> > +               /* Toggle hibernation mode OFF and ON to wake the
> PHY up and
> > +                * make it generate clock on RX_CLK pin for about 10
> seconds.
> > +                * These clock are needed during start up by MACs like
> DWMAC
> > +                * in NXP i.MX8M Plus to release their DMA from reset.
> After
> > +                * the MAC has started up, the PHY can enter
> hibernation and
> > +                * disable the RX_CLK clock, this poses no problem for
> the MAC.
> > +                */
> > +               ret =3D at803x_debug_reg_mask(phydev,
> AT803X_DEBUG_REG_HIB_CTRL,
> > +
> AT803X_DEBUG_HIB_CTRL_PS_HIB_EN, 0);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               return at803x_debug_reg_mask(phydev,
> AT803X_DEBUG_REG_HIB_CTRL,
> > +
> AT803X_DEBUG_HIB_CTRL_PS_HIB_EN,
> > +
> AT803X_DEBUG_HIB_CTRL_PS_HIB_EN);
> > +       }
> >
> >         return at803x_debug_reg_mask(phydev,
> > AT803X_DEBUG_REG_HIB_CTRL,
>=20
> Hm.. how about officially defining this PHY as the clock provider and dis=
able
> PHY automatic hibernation as long as clock is acquired?
>=20
Sorry, I don't know much about the clock provider/consumer, but I think the=
re
will be more changes if we use clock provider/consume mechanism. Furthermor=
e,
we would expect the hibernation mode is enabled when the ethernet interface
is brought up but the cable is not plugged, that is to say, we only need th=
e PHY to
provide the clock for a while to make the MAC reset successfully. Therefore=
, I think
the current approach is more simple and effective, and it takes full advant=
age of the
characteristics of the hardware (The PHY will continue to provide the clock=
 about
10 seconds after hibernation mode is enabled when the cable is not plugged =
and
automatically disable the clock after 10 seconds, so the 10 seconds is enou=
gh for
the MAC to reset successfully).


