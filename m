Return-Path: <netdev+bounces-21510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5B4763C04
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42FD1C20EC5
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656037994;
	Wed, 26 Jul 2023 16:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0F2AB34
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:10:16 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2040.outbound.protection.outlook.com [40.107.241.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966EAE69
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP2RbGCRni6SVj5qQmse0AlUqljWHZfDq5oa+alJl4dMUAcw1vjsgSNgX5SX1SAJS4xJA00AzrWZjmmlK3zbPXEAxbKjDCzuGgqHKbVctVBlWYV19U8kKoSniN/5R74SUiwX428YLyUIvgC6kOFhkOmJpSaWwoZioG0GLAXfl96i9xvXPtbZK+q1CzPZaDPfbflF0qQA5qKvPwbD/qgqirbQRcwFrVJfwbLiBHYMRl6vnjCRsV1unYKUiTB/97Q7sbdVtKuBWMnLmE9kp08aMHYi1IlnaQyyui798LB4ZzGTVJbgqRgqUUGhA64xADxScjrfR7cDQkEVwyuIIHf5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aH2N5j8G1WytfBqcn8rSwXLzVHCgcasa7/5SN8brTU=;
 b=M3i6mrWFH/iPyfyk4LyfMeAig24jP8MW/4T0H3NugPTn/i4vWPafR5Tw6tscb0TYPJ1TUMOCfz6SHeN+elbTEmtQuCEhSvDyBmyLo+vElXgJ7tfB9e7Nzt/VyOP+WDvyD84cITZj8GkVF72uTXYvVfNoKzucpCJKhrsC8bAOjYjKY+SmYkfmsEmfkwNkBdpTXQbeA+sPo3856/znwm9EuewWefBaztkT+ED/9M7d18f/M1Sa6vkP3lDWRGKSu30tbUQpd2ZJURcQz+MGTY3DTGxDNueQ3JBA6qTXxfwRnrFR2b26FIorg9u8kpcIguDljO4HI1Fj7iHzEBM/BuLhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aH2N5j8G1WytfBqcn8rSwXLzVHCgcasa7/5SN8brTU=;
 b=J1rjXLWV43BtXBAs5uLZSg5h3StkgyFUh9FVq8qRdsEqZ/jgnkN0poSog55/TIw5uJYEof0W0C8TKp18HF+Fe4RLZl9CLllAnUFYvYAWdgS7OGxb2MLRdvrB/dDenGYEAeUT1prm4sQmIicvKwwOKSk3IMde4NoBltmLHCldVao=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM9PR04MB8383.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 16:10:11 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 16:10:11 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Russell King <linux@armlinux.org.uk>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo
	<shawnguo@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Giuseppe Cavallaro
	<peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Frank Li <frank.li@nxp.com>
Subject: RE: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in
 fixed-link
Thread-Topic: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in
 fixed-link
Thread-Index: AQHZvzEtwr0cB5x9EUCXrQC85+we9K/K+NqAgAEqaxCAAASrAIAAD2LQ
Date: Wed, 26 Jul 2023 16:10:11 +0000
Message-ID:
 <PAXPR04MB9185A31E1E3DEBABE03C60F78900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <ZMA45XUMM94GTjHx@shell.armlinux.org.uk>
 <PAXPR04MB91857EA7A0CECF71F961DC0B8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZME3JA9VuHMOzzWo@shell.armlinux.org.uk>
In-Reply-To: <ZME3JA9VuHMOzzWo@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM9PR04MB8383:EE_
x-ms-office365-filtering-correlation-id: 5cd38ec8-c557-4044-dba0-08db8df2ca08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dOWTGy6xD6J4cGXRNvc6f+LQTCFz4BrJ0lqe5rfAHxql+IMLLT9mm2jCjvbh1IXnu1OzcZtU2jv4k91Uf4f+N5C4W+xslan4BNjUCxl0EeUcep9NvBOQs3+JFajR6oZ0UveFOMlsTnPYkVpmZexC42MpFi8MVmzNi8FPAFESA1nUUckJun/ULpfeiKy62UuRaXnx4EUaN1IoyC2hCbvC2wzbgpN51h3lzPorqISZp4wHeBFBpFbL10tMEog70YwDOOCrB83L8/wU9p/Q7+QPRezstvanh+M/4eq8aU3a/fPYMVLEQJF4JErC+mDKpCEsg4XSxoONI3ZAC53d9QJ0NqIa00wQqh1tZuW4LIDAqN+0DBT4JyiTTyHb+Hx8Gf1zU94GYZQUKei01FPpbXEDUswOyX3xK77u8c1X5QQm8ku9fykbDhdYpxQCOYVMX5Kj8/X7i4K4k17kNWhNpiDOWDyNcVJegfGVnzcC/AfgpGwKJPbih08lNR7apvCYgFoepT4QWvMDXAHqAKvsgLBqCBYJRjrPUhyBQlbW34SgaG7JTl/GqVi1Ns40Xh8sZz4yrQPZR3HFYOx06b6Rn7u0osxF0L8evgj5FlBQ843oirI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(2906002)(71200400001)(6506007)(186003)(26005)(316002)(122000001)(38100700002)(41300700001)(55236004)(83380400001)(5660300002)(52536014)(33656002)(66476007)(44832011)(66556008)(66946007)(53546011)(76116006)(66446008)(7416002)(8676002)(64756008)(8936002)(6916009)(38070700005)(86362001)(55016003)(54906003)(478600001)(966005)(7696005)(4326008)(9686003)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2pyDwBr0zsR+bvjheWRRLs5DZKPtRwQqO/aUtpv4oV6mWfwJOijjAIT/5m0p?=
 =?us-ascii?Q?opXiAcyhy8nXYW85QxXbPGnW5D0JbcAVvegzXFxae0CWmdyBXx1pVYbGctFL?=
 =?us-ascii?Q?lWTeGlkL7EnM7D1FPF/r79krQ4rroYNT+KuWsTfstS1CXBbleHFkW/NJP9yz?=
 =?us-ascii?Q?bahW+ZCWZNbfy1ya/pMw0nLiuwp6thR6/hkS4MSpSKPRZnnFLI3fbNit/ZNn?=
 =?us-ascii?Q?hAbLWVWImx1tPKWweGiSKjznrIekoUBhy3iwI7VvFEPnmcoNAeLyoO4K7KsT?=
 =?us-ascii?Q?T9ryyFN6QHuCJjdlU0VZedTUC066Bp89ObYf+qu9LOtHLjFHQzTx80+ejVTt?=
 =?us-ascii?Q?VAU9w7Pd51Xrp9fdjPunt0Q0hM8nWd9fcs/BVOJ2c2j2ki1CLgRgQ4eWEJFr?=
 =?us-ascii?Q?Q73tq2xqKyfLQJhwtc4nhkgu+GlNJtjA1YM8Ce+mEk5wa1HjmY6/U5SPMsFr?=
 =?us-ascii?Q?9cOLh+xQHfoIhhPO0m1CKBC0zKxnC7AdL0srJJnz7ZR8Io4eOxzJrxSIPTYA?=
 =?us-ascii?Q?podjWsH8Trmk8d6NNmL5OE6vyljQlo16GTZ6Jzm3pNz6wufiVic6oiT3YTYF?=
 =?us-ascii?Q?Ka5KbsHWA6KPbeLp82JWv8jlgHXksBAhctQoZPf436jXsEhNIe5hrnfxHsau?=
 =?us-ascii?Q?4Bd/orDp4dqLq7knmSLpd6TTrDJktVo5GI9EKfTmI1OY1D4a38yOtYfu1tHg?=
 =?us-ascii?Q?B5u3EqNTJUvbNX3EgEQ56izB+I0pKaJ81xpQq1a/K78oyeWQLd8p53vGXDnN?=
 =?us-ascii?Q?YLQVmZ7BehHIn+xeFiMjt+LQrwVqPVPZIhrjOcAvYo8D/tk+ktQHZe+awi7s?=
 =?us-ascii?Q?cehei9V0rlXXw+n0uI3qtdMrktZ7l4ALZOoD2u89bEBezul2A21cjxPkdbn0?=
 =?us-ascii?Q?ZKUnH37BSbAHf6LK2mWdLQT26fMKf2fCDmrTWbFcUp3a2EwX3TrjFeYqfuOA?=
 =?us-ascii?Q?OdnHqTx4VME+sOMhUTeR0pDPVE4UoAqVYLxiT5JffT/xvrRJUhGqZR/JyaA+?=
 =?us-ascii?Q?717B/aNenTIH5op9pUWMtSRYd1mwr1YtL7g9Y7DTLi9hGQ1AsdrQABSOiboz?=
 =?us-ascii?Q?gVKcltR0FvUi4xUXL3hSO9LYol/lGjfyRU6A0QO4aFDI8otU4glfqNHe7bl7?=
 =?us-ascii?Q?Ib8b9Ivn55xosL1nUIOTNGCaMcVzvE8WOLwmJGCyA2GLZa9lFYceMk9WThpW?=
 =?us-ascii?Q?7zpyEqMETJ2txCwoj6WtmsbsYXVANHgh4OV8KIU8/tc9seoaTPqEXFYBTS4B?=
 =?us-ascii?Q?dOT7jEH+yabilaFreu9ci52/nm5fGBd3o99icxon00QdF88FrAt0THo3xYiB?=
 =?us-ascii?Q?EcLG346wcItznIWzqU0m1FH1pEf8atDTU0x9GuBVy3JW6L/Gv8lRO/0oxeYG?=
 =?us-ascii?Q?vlWk7airLc0qZegxBFBa1HnfntUNq3vBONIjze2bJkmqEDyBNixT3RnGlA4i?=
 =?us-ascii?Q?ntiYrUhEkg/ONJ5sD7DHCD65Xs1sBPYCibnn2n9+nORahaJQ849QvyMDhRFh?=
 =?us-ascii?Q?U0H8rWi5DIvuI2jfkJ0vLct501p+5RFLSTfWfryx/hKAeIWHjHpMC2LLn59H?=
 =?us-ascii?Q?uhRe64VlXFiJYIS1A8iJ1GnkjjxEAGYmMpHiVsqi?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd38ec8-c557-4044-dba0-08db8df2ca08
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 16:10:11.3672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDkjcX47acw/kr/G3l1U/2tas4LBSyPUaSwTYBbdARSPfHx7eOmibd1E5W6h9kfHczT9VFIeLzN8ExupoMDw3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8383
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Wednesday, July 26, 2023 10:09 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> Shawn Guo <shawnguo@kernel.org>; dl-linux-imx <linux-imx@nxp.com>;
> Giuseppe Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>; Sascha
> Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-
> arm-kernel@lists.infradead.org; imx@lists.linux.dev; Frank Li <frank.li@n=
xp.com>
> Subject: Re: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC cloc=
k in
> fixed-link
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>
>
> On Wed, Jul 26, 2023 at 03:00:49PM +0000, Shenwei Wang wrote:
> >
> >
> > > -----Original Message-----
> > > From: Russell King <linux@armlinux.org.uk>
> > > Sent: Tuesday, July 25, 2023 4:05 PM
> > > To: Shenwei Wang <shenwei.wang@nxp.com>
> > > Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> > > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > > <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> > > Shawn Guo <shawnguo@kernel.org>; dl-linux-imx <linux-imx@nxp.com>;
> > > Giuseppe Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue
> > > <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> > > Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > > netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> > > linux- arm-kernel@lists.infradead.org; imx@lists.linux.dev; Frank Li
> > > <frank.li@nxp.com>
> > > Subject: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC
> > > clock in fixed-link
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > On Tue, Jul 25, 2023 at 02:49:31PM -0500, Shenwei Wang wrote:
> > > > +static bool imx_dwmac_is_fixed_link(struct imx_priv_data *dwmac) {
> > > > +     struct plat_stmmacenet_data *plat_dat;
> > > > +     struct device_node *dn;
> > > > +
> > > > +     if (!dwmac || !dwmac->plat_dat)
> > > > +             return false;
> > > > +
> > > > +     plat_dat =3D dwmac->plat_dat;
> > > > +     dn =3D of_get_child_by_name(dwmac->dev->of_node, "fixed-link"=
);
> > > > +     if (!dn)
> > > > +             return false;
> > > > +
> > > > +     if (plat_dat->phy_node =3D=3D dn || plat_dat->phylink_node =
=3D=3D dn)
> > > > +             return true;
> > >
> > > Why would the phy_node or the phylink_node ever be pointing at the
> > > fixed-link node?
> > >
> >
> > The logic was learned from the function of stmmac_probe_config_dt, and
> > it normally save the phy handle to those two members: phy_node and
> > phylink_node. But seems checking phy_node is enough here, right?
> >
> >         plat->phy_node =3D of_parse_phandle(np, "phy-handle", 0);
> >
> >         /* PHYLINK automatically parses the phy-handle property */
> >         plat->phylink_node =3D np;
>
> So, plat->phy_node will never ever be equal to your "dn" above.
> plat->phylink_node is the same as dwmac->dev->of_node above, and
> so plat->phylink_node will never be your "dn" above either.
>
> Those two together means that imx_dwmac_is_fixed_link() will _always_ ret=
urn
> false, and thus most of the code you're adding is rather useless.
>
> It also means the code you're submitting probably hasn't been properly te=
sted.
>
> Have you confirmed that imx_dwmac_is_fixed_link() will actually return tr=
ue in
> your testing? Under what conditions did your testing reveal a true return=
 value
> from this function?
>

We can't make that assumption. In my testing code, I had trace statements i=
n that
section to indicate the code was actually executed. You may get some clues =
from the following DTS:

+&eqos {
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_eqos_rgmii>;
+       phy-mode =3D "rgmii-rxid";
+       phy-handle =3D <&fixed0>;
+       status =3D "okay";
+
+       fixed0: fixed-link {
+               speed =3D <1000>;
+               full-duplex;
+       };
+
+       mdio {
+               compatible =3D "snps,dwmac-mdio";
+               #address-cells =3D <1>;
+               #size-cells =3D <0>;
+               clock-frequency =3D <2500000>;
+
+               phy0: ethernet-phy@8 {
+                       reg =3D <0x8>;
+                       max-speed =3D <100>;
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+
+                       phy1: ethernet-phy@9 {
+                               reg =3D <0x9>;
+                               max-speed =3D <100>;
+                       };
+               };
...


Thanks,
Shenwei



> --
> RMK's Patch system:
> https://www.ar/
> mlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=3D05%7C01%7Cshenwei.wang
> %40nxp.com%7C2793017863ea494fd07808db8dea50c3%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C638259809734982456%7CUnknown%7CTWF
> pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=3D1HZj6eDR1nNvep6S9OXlg%2BbhbekGKjS
> AWvw2LYEa9Ig%3D&reserved=3D0
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

