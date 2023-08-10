Return-Path: <netdev+bounces-26135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD23776E85
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 05:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487201C21454
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 03:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155DEA4D;
	Thu, 10 Aug 2023 03:28:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947B815
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:28:21 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80D21B6;
	Wed,  9 Aug 2023 20:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0n/H3ZEU90KKcotsSLWg1uy1S5LV8wc6KL9JI6WTARrlQHruX0oKkop+iyHJ+Z4x8+6UHZknFe1D3QMlWbRDt7E5IW7k9LuRKJQ3Q2lpJDt99GVKQOzkJuW4CLuhpaKEy0mXE4FeT5EVJygjYwNgpUugM5aJGk0yidCAByuqZHKJiObHBk9Ppvda4P43poj/FGwpSt1RfvSDD9dUor9q0aSTJoea27hXer+VKoF9XWxyRVjZeL+atbJPoaQe56QzbXGBbqNAYTUbZm2bbUGZm14vJq4V+Tg+t3quMbExKhwrHrlp8E4jnuqD0Vz5M4FlMs6vU3TbnE3SJiPpGI0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozzRlymuNibEtOm9f6yJ+spycaQWuzQw/zTxzUFYNuQ=;
 b=Srp29KHC0YcQ5cxKXgkPHFDwtBZWJko+N+K13kE0vLYBqPTxtgJhqb3oOPTgokmFO/ickamFCaplewfx4Zz1q4owKVmdoPxgMm7eCo0qHTPI87grhNGWhogEFVzSZU3Bd9P6/zm/CGGSSZnpntpgiTfHPyrSLDFOmVu8CyKKYVK7MSXHo3OIse11Skx1s0LxbvSvR0+BVCb7xRGGJ+H8otwCsNoqOLjFRbcvkiNRqj6TkO1dgGCt50V9d2Pmr8g87ob0ypcgu1litp1KHcQKvTDAU8zg7bZjaQgz8iaNydFDw/GKNFwk5na6gFnYpcEZ1WlI3FPgJwMAG4tb9LGy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozzRlymuNibEtOm9f6yJ+spycaQWuzQw/zTxzUFYNuQ=;
 b=GXPL4hG4IS1zmSHBTQEbmce/hdoMmxwTjcXywjklQ7YKb+PkF5VKEVxV4R1KyFbC3nlKg9QlsrE4jFhK94YHsTwZ0xl5WVGBMrwvuQz83aW2rxMojOPGBO05cEnSnOkDrcEYSnvNAJDuCE5IJKq7d9pIdV8hIYMp1dbKAv1WKfU=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AM9PR04MB8730.eurprd04.prod.outlook.com (2603:10a6:20b:43d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 03:28:14 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 03:28:13 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: Marek Vasut <marex@denx.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>
Subject: RE: [PATCH] net: phy: at803x: Improve hibernation support on start up
Thread-Topic: [PATCH] net: phy: at803x: Improve hibernation support on start
 up
Thread-Index:
 AQHZxv1ZKz1KraSXKUS2W3fAHhGdoK/gFe9AgACqzgCAAHgJ0IAAL1wAgAAHR2CAABJ5AIAABmlw
Date: Thu, 10 Aug 2023 03:28:13 +0000
Message-ID:
 <AM5PR04MB3139D7984B4DAADCB25597778813A@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
 <AM5PR04MB31392C770BA3101BDFBA80318812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809043626.GG5736@pengutronix.de>
 <AM5PR04MB3139D8C0EBC9D2DFB0C778348812A@AM5PR04MB3139.eurprd04.prod.outlook.com>
 <20230809060836.GA13300@pengutronix.de>
In-Reply-To: <20230809060836.GA13300@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AM9PR04MB8730:EE_
x-ms-office365-filtering-correlation-id: 130148da-0566-499b-7414-08db9951d45c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Rw7HavYEog1DsenW2hEggUehBgmJf9RG+ltUwaKzFI8nmtpHCU+p6ksH9jhgnQrMS7cBbaeWE8ef5GzKIJ76mI0aw2soZJWSz0AiauTbW1Gw6BGXnFG7HgItiOdy721VtTCPztMRENndZXrcGiy91cz9iYLeXw2u6Dvc0VC6ukW8zyKU/sr3cPrSHkCpiW7IrSFQL/WubHwKtMH9LuPZA35oqJcGSB32PUvLPk+oe9UdqU7vsvibKfy/jUYrJxIP4pqxTBBzF3N917qBu+H+RtprieSD7vLkYSoLYZTGbgFvXKdGvrIDI25j7CW+ptLitxvSiI2M0KipaZOMnlSJqlVpBGZXb/pRX/KbpYjM2xf5xI6pnMy4FY7KWp21/oCynERWTxZgwOFr2Nm5kUebup4+nfGiXd08CAqffJe+F4Dz/0vgnD5l9/iwPckBaSNu9q7lnIIuYsC2xSNzAFP5dIKT4BMPGNOfk0Bj8+6U8eiht9zlSDVsDKsgUyMil4Ib3zPMVlxuiqOCXmfImzbVBnJF04e/nqA9aUqgAZPIXYL0D+qQXz27qJq41aUDfTPnVTjnW8IAhcYRNv+J4Us/qhEbfMfF4Sc+E7CVweJgRovZGRIg3qbZByCCdQqfA+Mh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(186006)(1800799006)(7696005)(478600001)(86362001)(33656002)(38100700002)(54906003)(4326008)(66556008)(6916009)(66946007)(64756008)(66446008)(66476007)(9686003)(122000001)(2906002)(52536014)(76116006)(26005)(316002)(41300700001)(6506007)(55016003)(7416002)(83380400001)(71200400001)(5660300002)(8676002)(38070700005)(44832011)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NNpwzu2b2NB3X9CCR1BqGvcVIsKHrhLpBL5C0LFaZsT4p4gYlb5UqqVMi2/X?=
 =?us-ascii?Q?5vji6bwcI1AZQ9rRYJIN4315KMOJ3qzLm5IumBDtMI6MkU9Lt8Z+k04OppGX?=
 =?us-ascii?Q?7FBPduWc1LF/n6xjgXtHjXixcH6SVL2THBvXs5SYUcu2DbmeZ19+uD06z27/?=
 =?us-ascii?Q?EIauQ08/uCpeSQc/BxuSLk4wZq215jd5E8ilqujTeXsM8QeHuoycSDA9Kn6e?=
 =?us-ascii?Q?KeUxCbAGRNTPzwNhqAUo4DJpiHQn8Bi0ReOSHWIHSgP/VbsLlt9h8s4hz3O0?=
 =?us-ascii?Q?cFUJjQNh1lN5QA/61bpc/HJVd30kB3QX7WnOffXPRNnYrfH4EfgWFsh0JB3X?=
 =?us-ascii?Q?xZR9jqFzlQbrkV/ZaDt6sUr7MD2qH2w8pm4/jaZL684+y80H0qKl4VmeNuDg?=
 =?us-ascii?Q?c8xZrUjgrkDdF4QlxZKDDD78/Xv4vZO3fOMzr6hee0/oS7GPHTVx1cdughKB?=
 =?us-ascii?Q?lkY3LIcUMIvz3TuE9QNYkSgAyfDzaAhg/m1v6sUOpOSCTkaZYUhrHwQNXSxl?=
 =?us-ascii?Q?GlMH/sVqs3XSeba/7TvqibPMWVAgzhAm5r9lZonpSGQLJ2ANEzDaQWRoVocL?=
 =?us-ascii?Q?oVAEGjPFnFszou5GXpfJRTBbySJD2I+hwgGEZ5lxydLi/As0cKltwLGQ7icM?=
 =?us-ascii?Q?DJ4B4ftJwZ+YrfojKlAGNFV+ouKQPJpb7ARvCZfUmgyl1MyCuSCEcw4gE0Qm?=
 =?us-ascii?Q?tfBIsC22Bz6mUkUdNYbVaUJV6nUSbs27QajxjTYasXgNKSVryyS+ArWC+zAH?=
 =?us-ascii?Q?QwqeX2Y7Qz1K06J+f1dmtxAz85g2mYqiQ1BOCT3uLx4ie/tZXK0KYfU8qfEr?=
 =?us-ascii?Q?iqklP6zO8JAlsadW+plmRsWiT+CCjl3GiMhwndnfowkopPcltrD1mZURbqSF?=
 =?us-ascii?Q?ZO4V/I8TOX3S5T1gdnX19iGP/2gpIXo+INLMM4UQ+CEusfMMHS2UjhMhI+v0?=
 =?us-ascii?Q?ynkHQB4r1SucWN61OqEhKy68zj8/GHGdC8Y7rTVFxC6q1G1IDmvOiF7leBh5?=
 =?us-ascii?Q?RjbAP40//FO3DTTRtSbDIoUsOfef861TkmiCQoLy8JThjYglOMPCpGyh+y1T?=
 =?us-ascii?Q?yvr0YrGuRb/FFy4FVacCDZAnRJa5Bz7CXhbNsFPfT/G0PQIcVvMDiht9oLcL?=
 =?us-ascii?Q?PZm8GoZ8wCyh6leD+lVABInUlPmM0Ll6ImGZQKj0LhyVFbksKJ95NAZtmj81?=
 =?us-ascii?Q?4UVIliEXkykuG0cR/8nXyQkhy6uaZD6v8efFu8+fPELkODV2TQp7Jg0KIWJe?=
 =?us-ascii?Q?w5Pnght0DMYe1ekBLVGTPw7cYr/72bGLXPPk/QtxIqBJMccUn8xM7mic0fpY?=
 =?us-ascii?Q?cajz1an74HlXTTkaeEep7ZWMh4R23baCoPqRJY0uLfzQP6T7iNTwsB0nNCeX?=
 =?us-ascii?Q?TdC9cA5U7EUtD7ALmehrEbuLOzdPr8v0FwCAAxDg/3m6RGFYzKuANC3aiHXE?=
 =?us-ascii?Q?XF+2EplCieA/DUy+rX1qFyar7SdWyhqbEqMxG07uj1xsREZEj29SXv3c/YLe?=
 =?us-ascii?Q?D/NubbicDXCMERKQCN5MdKJL7KZD8OOpB2hmZ+g08eP7cybIxqXToGfaMpvv?=
 =?us-ascii?Q?/Lj8gRJOJogIQ5gFkWE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 130148da-0566-499b-7414-08db9951d45c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 03:28:13.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GS8mg3y6dsB8d1SLtYlzb//3XNsh/OvlkHvrhPK+Cy6ziCiliJrjdSX2JRYCWc05BJMe/6LbTxxEfzHYJSyQOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8730
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > Furthermore,
> > we would expect the hibernation mode is enabled when the ethernet
> > interface is brought up but the cable is not plugged, that is to say,
> > we only need the PHY to provide the clock for a while to make the MAC
> reset successfully.
>=20
> Means, if external clock is not provided, MAC is not fully functional.
> Correct?
>=20
The MAC will failed to do software reset if the PHY input clocks are not
present. According to the datasheet from Synopsys, the software reset
is for the MAC and the DMA controller reset the logic and all internal
registers of the DMA, MTL, and MAC.

One obvious error log can be seen from the console shows as follows.
[   26.670276] imx-dwmac 30bf0000.ethernet: Failed to reset the dma
[   26.676322] imx-dwmac 30bf0000.ethernet eth1: stmmac_hw_setup: DMA engin=
e initialization failed
[   26.685103] imx-dwmac 30bf0000.ethernet eth1: __stmmac_open: Hw setup fa=
iled

I believe other manufacturers who use the dwmac IP also have encountered
the similar issue and use other methods to resolve it, such as intel,
49725ffc15fc ("net: stmmac: power up/down serdes in stmmac_open/release ")

> What kind of MAC operation will fail in this case?
Below are the steps from Marek to reproduce the issue.
- Make sure "qca,disable-hibernation-mode" is NOT present in PHY DT node
- Boot the machine with NO ethernet cable plugged into the affected port
   (i.e. the EQoS port), this is important
- Make sure the EQoS MAC is not brought up e.g. by systemd-networkd or
   whatever other tool, I use busybox initramfs for testing with plain
   script as init (it mounts the various filesystems and runs /bin/sh)
- Wait longer than 10 seconds
- If possible, measure AR8031 PHY pin 33 RX_CLK, wait for the RX_CLK to
   be turned OFF by the PHY (means PHY entered hibernation)
- ifconfig ethN up -- try to bring up the EQoS MAC <observe failure>

But the situation I encountered on i.MX8DXL-EVK platform was not as
complicated as above. At that time, it only took 3 steps to reproduce
this issue. But now, the latest upstream tree cannot reproduce this
issue based on the following three steps. Something has been changed,
I think it should be feafeb53140a (arm64: dts: imx8dxl-evk: Fix eqos phy re=
set gpio).
- unplug the cable
- ifconfig eth0 down and wait for about 10 seconds
- ifconfig eth0 up

> For example, if stmmac_open() fails without external clock, will
> stmmac_release() work properly?
Actually, I don't know much about stmmac driver and the dwmac IP,
Because I'm not responsible for this IP on NXP i.MX platform. But I
have a look at the code of stmmac_release(), I think stmmac_release()
will work properly, because it invokes phylink_stop() and phylink_disconnec=
t_phy()
first which will disable the clock from PHY.

>Will we be able to do any configuration on
> an interface which is opened, but without active link and hibernated cloc=
k?
I don't know, but as far as I know, we can not set the VLAN filter successf=
ully
due to lack of clock. So there may be other configurations that depend on t=
he
clock.

> How about self tests?
>=20
> > Therefore, I think
> > the current approach is more simple and effective, and it takes full
> > advantage of the characteristics of the hardware (The PHY will
> > continue to provide the clock about
> > 10 seconds after hibernation mode is enabled when the cable is not
> > plugged and automatically disable the clock after 10 seconds, so the
> > 10 seconds is enough for the MAC to reset successfully).
>=20
> If multiple independent operations are synchronized based on the
> assumption that 10 seconds should be enough, bad thing happens.
>=20
> If fully functional external clock provider is need to initialize the MAC=
, just
> disabling this clock on already initialized HW without doing proper
> re-initialization sequence is usually bad idea. HW may get some glitch wh=
ich
> will make troubleshooting a pain.
>=20


