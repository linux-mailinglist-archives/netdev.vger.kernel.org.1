Return-Path: <netdev+bounces-21554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36C2763E59
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5760B281E77
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F80C18055;
	Wed, 26 Jul 2023 18:24:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A71AA88
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:24:50 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911BD2126
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSmeBZ2NjksLLL1J9uVdm6l3/dRtMjFn+R+bG1LT8sCrrazUa2GSd+3cqXFiWcpdHjlarnj/yetuBgg873oKD3l5U6feyvniKzwENZ3h6S1BlIAOs0q2mMOaJ4K/ySkTNlK0v+aTVomauEyouMjiySNwTjJhCFij2S+3PWt0MNciPAtsk+WpdEYQkk8g/3+YMDSAUZxB31GoLUkOO/9ZgrGmwPG4JbnQgcSOvWzbDGwPkgWeYrOexdj2Yde3k41qdoz38pbs0I36Vw5DzhwSVYqbGuH26TiWvyp/+1xIBohGNe75kS+2p0PQ81YpH3oBvLV6YWLSF9nfy+TMmdBgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHErfa6wQex9sRXYAFL9CC+2/cZMCWi3zjXgISHjpc4=;
 b=G627YDdsXt7oi5NzikCproQMbO/zNX2wK5MK15ZP1qQlJT/E4fZ8UKHH6m4PoESKlxD77/8jUrGJRF06Tyn/kjgrZZMwAYrBs8Oomxzt3UZdQjOpWDH6jpCuCcs7Tzo+9uIEIb6aHPdfduH8yd/3FB9APoDPQLQo1KjiSXKQnzaOg8HIrEzq85AZKBO275hdk6aKj+bvnQZzkcl2CH5mE6Jfoq0n9NlhHYZKVFG2mzU5PfmNipgQB6lshKgR/JkExrbQijPXaVplHDRZHFb+4MwGDklR9xG/A49u7+Mp/1ykNXFpE4lW3mi0FiQITxHM0xx0GNfOvtqKYafaXAMEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHErfa6wQex9sRXYAFL9CC+2/cZMCWi3zjXgISHjpc4=;
 b=qka6onK7Yz4tlE3e4OInXmNjlIimjDWV3gp6gQqtEgfwJQxcdKYuwgdXTULSL2QTJyu+rpNvu+Ir2uxo48z8LehDr4Z8ZFqHjHBERZPV0uECKlxrEgZr3GbcK99hrt+Ejq1s6jeZcIjlXui+XlnMqm4W0stvUl3XxhJcVF2AK18=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM8PR04MB7988.eurprd04.prod.outlook.com (2603:10a6:20b:24e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 18:24:42 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 18:24:42 +0000
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
Thread-Index:
 AQHZvzEtwr0cB5x9EUCXrQC85+we9K/K+NqAgAEqaxCAAASrAIAAD2LQgAAG/wCAAB4pkA==
Date: Wed, 26 Jul 2023 18:24:42 +0000
Message-ID:
 <PAXPR04MB918588615923BBE76EFAD4048900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <ZMA45XUMM94GTjHx@shell.armlinux.org.uk>
 <PAXPR04MB91857EA7A0CECF71F961DC0B8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZME3JA9VuHMOzzWo@shell.armlinux.org.uk>
 <PAXPR04MB9185A31E1E3DEBABE03C60F78900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZMFJ6ls0LHrUWahz@shell.armlinux.org.uk>
In-Reply-To: <ZMFJ6ls0LHrUWahz@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM8PR04MB7988:EE_
x-ms-office365-filtering-correlation-id: 39e0d9f2-255d-4b9e-903a-08db8e0594df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5hdu9IsKOGhNGswffiAF5IpYc+oBkCPtoY/O0FTRFKNoSdqrLecXj3J5D/Ul8pdysNUvTcWKpQG3gxLgjY6ZkQ+1gCPXptQDCyypU32uhk8wJU6+aBGfi93ahGpf6CI3eJQ8oLILKyoL3hZcgoZOkJxnRdjY1Bjg8Yr7hMzZ6S9U/CQVXrdJvPVWXMkJRPjirUX+jIButohj9EGZD8SjzIbdbdQ/emQbt91lJGVOpAhjJaU1FFkMHUbOUSzYyIijl4OIJEci70ZIEvhymHto7orRGksOAQEC79GAx+Z0jJ9k+Enu2LjmrJXB4LElZZtFfiM0+0suCeBsu3o47mKN+rZh5Tj086ciSiCTrnjztYL9hKJOziY5a/8o+DWpHav2rD858V3l6BKcHfmcolC90+7huTo+POALuzs9QsXLMHv9PIPMTu+cKkrSrs8hi7VcC4FglFGN6MUOwE4nNPJ/ZjNlZULotLScLaNpC5jq1ztaoIdn9wiyZEMs/4EK0LBjeQ+Rnmhs8X6uqS8TghSeJSiBNbOo/lQR2lzEHUm54svzRoOvP/tjqRYq8xO/sFooeZbZgu2meAad55CaW3AK6bBNoohKCnb5pfs3NXA0LBU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(66556008)(54906003)(66446008)(26005)(55236004)(186003)(53546011)(6506007)(66476007)(66946007)(4326008)(6916009)(64756008)(7696005)(38100700002)(316002)(76116006)(83380400001)(478600001)(122000001)(8676002)(8936002)(5660300002)(7416002)(44832011)(52536014)(38070700005)(2906002)(86362001)(41300700001)(33656002)(45080400002)(71200400001)(966005)(9686003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hN/qoamsIsge3JEnQA7eiismT6NqIvHpn5+Yky7sLAOO+nUwVlJCPvrZEUHI?=
 =?us-ascii?Q?GEbD9AX2+4De2qAzSuvNV4PBVOWkjyjj/soWjqmi0sq4lKegU76FpCB5Z9Kg?=
 =?us-ascii?Q?QQLxg8Tp8myjUF4oho3hj3PxzI9s2xBk4Ybj0RmHP0R6/Z4ZT3/9H1iv1L2Q?=
 =?us-ascii?Q?tFiH7Mw/Z5FqXVZgPuR6NRgP6LqJcKfHBzFSsZrHdDpFSsODPOIj/fRCZcc7?=
 =?us-ascii?Q?59/ZMd7ku56gzyAyTXdyNSHxiW7hvZrsOALOlYFCh5My0lYGzuDEksV5g8GE?=
 =?us-ascii?Q?3GBB4SJ4Fiv1oKiVlt9/7+Zi1+XTqxD7IEC1NBzQnxQTIUGsrK+s1EKtjlKB?=
 =?us-ascii?Q?kD1N5DHZYMbJoZtUucBa27HgdGqxHkPEnFWaRex7y9DBPgD2kT8OGzrMNWGg?=
 =?us-ascii?Q?jBuZWH8jGPVG+4oDE3k4NLMEd3joer4fhIz+8ZP21S/gxdxjsapvk+u83ndn?=
 =?us-ascii?Q?OFch4Szqq9gSSmD9pFjFf1y5Msd+wbQOwXt0C6KxuYxeR27eTR4PjJxJrwkd?=
 =?us-ascii?Q?mOtAXWw4K5z6kDdaGnHGYiCO0EQucWZr7cXO5nmpaKChY9MYpaMQ2bhs6Lvf?=
 =?us-ascii?Q?KT82CJ8EDE62ppW8/TcoyyMNKSgZ2iKdHrOPSbgt5pgKK9EiBH5WCt2ZeP5Q?=
 =?us-ascii?Q?5F8OPrrxbIe6qvn+xUVsQkNtzfuYNk9oo8DoCYdjBo/Vepx16EOymCW+tc9a?=
 =?us-ascii?Q?uNLl1RPKsM2En1zYhcq6pxFgCtzT4WRxLuKDMgxUDZxmN5mXcmMQxmUdeYFD?=
 =?us-ascii?Q?QHcyoJqonSYLco66j8IxoSin4UaxMdWIgJOTDhUzEpZP5P2UUKfiIOZ9Xsxj?=
 =?us-ascii?Q?236q4Xh56BgHxDZ1pr9g0EQ58ZRS2ulXOnyUIfHaPujE/kl+ylXAoMYrOGz+?=
 =?us-ascii?Q?JvOt+2qf5BWhN94Bdq3gLc66CiIuZlCUaExLhUvSGhJudExPDOCDwYViU6t+?=
 =?us-ascii?Q?IydKBAQmKX/uDGiZSPEm+DnRlHKZjG6Cc2sk9onIgdoKE82ns20ZgGfGRBXi?=
 =?us-ascii?Q?h4F/7zrekLCBIVoyKur5jwuyAhuP3y8BWFOfCbJcfyJAaYZUpTE3OnNlp3M0?=
 =?us-ascii?Q?GmmYp+tsZqS4xaMfqixYAs8oVPaQl+uNST4sOG2SFcAjP9iBx7q5FCHlSXdV?=
 =?us-ascii?Q?9aziedwcvcrRiCN2xsf2NAQqI2e+pjsE3PBbUVZF+hLh0bk2NGKm/U4YcSCz?=
 =?us-ascii?Q?K6Pyv+Qosas30UErDJSHYoBw9FS2w+1hLjGkMkd4uKAVS/+Wodi8aljA87Ln?=
 =?us-ascii?Q?vnTSzX7qh+wuLw1qd7QxKR5bm8l1JmMBm2NW+P6WL2yHx1QhyI3AhcLqnP3a?=
 =?us-ascii?Q?H07s1g/4sztAwwBO/GeCSMMZKEEqG5n/Hdr8Mj6K1u0fzypfsfmY8yoaE5lW?=
 =?us-ascii?Q?TR218mhPVlcLNFvWuv+iTpewT/pPksVuxB/Bt7+I+kBFhp3Jeqz0/baowC82?=
 =?us-ascii?Q?ksOV9b7RccDCZjMq7mbd2LaYILGHCaSPm+7AxrxQ7rLj74ryoBEmUwzSLyvH?=
 =?us-ascii?Q?PKhbpBJTiQ5RdpKHru9HMoarhtfAwyINEQsvVcyqEPDZklTYS1zPJPsFdqVt?=
 =?us-ascii?Q?fBOuzN9lgVwU2g0X3quGZIjruK9oRP5GrTB4P8gP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e0d9f2-255d-4b9e-903a-08db8e0594df
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 18:24:42.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpaZK5gdog6meTnxyGezozaG8xpNBOL1AU4/JLVvHfG3AiG3xsQNVDBGxIieajMd9u6xxiCKKe75zz+3IU8blQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7988
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Wednesday, July 26, 2023 11:30 AM
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
> On Wed, Jul 26, 2023 at 04:10:11PM +0000, Shenwei Wang wrote:
> > > So, plat->phy_node will never ever be equal to your "dn" above.
> > > plat->phylink_node is the same as dwmac->dev->of_node above, and
> > > so plat->phylink_node will never be your "dn" above either.
> > >
> > > Those two together means that imx_dwmac_is_fixed_link() will
> > > _always_ return false, and thus most of the code you're adding is rat=
her
> useless.
> > >
> > > It also means the code you're submitting probably hasn't been properl=
y
> tested.
> > >
> > > Have you confirmed that imx_dwmac_is_fixed_link() will actually
> > > return true in your testing? Under what conditions did your testing
> > > reveal a true return value from this function?
> > >
> >
> > We can't make that assumption. In my testing code, I had trace
> > statements in that section to indicate the code was actually executed. =
You
> may get some clues from the following DTS:
> >
> > +&eqos {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_eqos_rgmii>;
> > +       phy-mode =3D "rgmii-rxid";
> > +       phy-handle =3D <&fixed0>;
> > +       status =3D "okay";
> > +
> > +       fixed0: fixed-link {
> > +               speed =3D <1000>;
> > +               full-duplex;
> > +       };
>
> This is just totally botched up.
>
> "fixed0" is _not_ a PHY, therefore you should NOT be referencing it in ph=
y-
> handle. Please see the DT binding document:
>

If there is a hidden rule here, it should be added to the CHECK_DTBS schema=
 target.
That way, users would get a warning or syntax error when running the tools,=
 reminding
them to follow the undisclosed rule.

Thanks,
Shenwei

>   phy-handle:
>     $ref: /schemas/types.yaml#/definitions/phandle
>     description:
>       Specifies a reference to a node representing a PHY device.
>
>   fixed-link:
>     oneOf:
>       - $ref: /schemas/types.yaml#/definitions/uint32-array
>         deprecated: true
> ...
>       - type: object
>         additionalProperties: false
>         properties:
>           speed:
> ...
>
> As I said, fixed-link is _not_ a PHY, and thus phy-handle must *not* be u=
sed to
> point at it.
>
> The mere presence of a node called "fixed-link" will make this "eqos"
> device use that fixed-link node, and the phy-handle will be ignored.
>
> So sorry, but as far as your patch goes, it's a hard NAK from me right no=
w until
> the DT description is actually correct.
>
> --
> RMK's Patch system:
> https://www.ar/
> mlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=3D05%7C01%7Cshenwei.wang
> %40nxp.com%7C2396bc12c0524d7e006e08db8df58103%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C638259857794101296%7CUnknown%7CTWF
> pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=3D6VRey8tkgXhSaXSrf%2B0JVhwUivzVFPK
> QDzte0oKrIck%3D&reserved=3D0
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

