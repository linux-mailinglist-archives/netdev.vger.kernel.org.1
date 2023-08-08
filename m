Return-Path: <netdev+bounces-25350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCE2773C5E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05CC281064
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D271C9E2;
	Tue,  8 Aug 2023 15:50:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECDA1C9E1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:50:04 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2061.outbound.protection.outlook.com [40.107.105.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201B7A5C9
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUsIkyTLxyShCUGvXZL0m+3Q3Td6kMCINUe2l8QvByFsMshlgaKvioEi3zmvZRQVSdaY2u0zTgCmbnG335uLd3aNK30sQ1Khpl8ohyUpujJpHXUwalPx3EQE8Mlp6krhlrml+cq0VQ5FFMuIUGy/bCwz9G6921PwsRKrgsdTHzyeShfhQpxphm5rpxU8y67HO7J8VgTlbpTMGrnwcGXAKeB20fsybQf1IXkuwYz3NLKTjzjl9Jb3djVe3NWgq7T2K7NP4rJqzarrSEZBroKCbLVAevOeYtIpdO0a9xp6rap23WoM1WvpDgF0OLTIxuSeEPGEOc1pj68CNh/tDoQplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26oo7cDs5jV+c3tuQhkFiz0LS7g9jKw2Lol8aK0ewdc=;
 b=gBkFRy+Rm81CfUPYmeya2wnVvyKpRmtdSROIv9ntJGCGM3GEU6/YPeipGExVUe9Wa9QvqJ3C+4dNucyt50HBOoDUe5NZ8tEr4+geiUxU3N7DawTMhbkoicnjQOh6snl/ZHAuY+Q+W5NHJAE5ElYgIsezksxNV+EjwIZPv4p7fBpaBPm5bfnb71JDzf1Mjzobafnve6KQFG/eeSrwh3f9yiihFcXgpzTF2q70TLhQCSkcg+pgtTXF+bFABSI2bHe7v9RDGgBWOAkCB7fccq56k3RuJ8LVG/DzKyMshKKjaw7xdKzV6RsK6Ogy/D5wFWaVpAycKGEqR0bPFojP0E3y6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26oo7cDs5jV+c3tuQhkFiz0LS7g9jKw2Lol8aK0ewdc=;
 b=ng6L19j3I2xnq/BcGUmya6Q8gIy4a7aoVJtaeT/4rLzzJg6XzE8uJ9cBPTbwwegWXFKSKFqaZqRVFaPvkj60Oq6UZP2z1pjkUk7bLfTgCTCwbbDFUujCXlA8N5cCmwAxdxKwY2uhtvbg31TOVD/MdVm8V7d5g5wiKrcwVgGwu68=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by PAXPR04MB8974.eurprd04.prod.outlook.com (2603:10a6:102:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 08:44:26 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 08:44:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marek Vasut <marex@denx.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>,
	Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Subject: RE: [PATCH] net: phy: at803x: Improve hibernation support on start up
Thread-Topic: [PATCH] net: phy: at803x: Improve hibernation support on start
 up
Thread-Index: AQHZxv1ZKz1KraSXKUS2W3fAHhGdoK/gFe9A
Date: Tue, 8 Aug 2023 08:44:26 +0000
Message-ID:
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20230804175842.209537-1-marex@denx.de>
In-Reply-To: <20230804175842.209537-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|PAXPR04MB8974:EE_
x-ms-office365-filtering-correlation-id: 46743d27-ecd8-4538-fc7c-08db97ebac06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 022KZGLugU56RUFAkmqW3Z5ClMxA2NoDtD7oiKP8cdKl7ktZhYYJSXvP9jJI6ey2L5LXidR2pNHonWI0PSRWJNovau1NF4B8KNA2+TwNZ5yZvAC0PTWS2zp0m07ie/K1JVlaSpAmOZfBT5fnNDrzsYPEj8il/7OAUD3JTmbVFwvmOeh9+P7aNvcpgX406GNTVD+nccvCFb7iXULFKyD52f7hpZ4jQuVfK/Wi2LpxLiTAgYrfXHtrt6RjoMXzygYN+G+AqoPcuiszSTAx/uCoOhk3bk2EaCaYijoIAIiZI2WpBUX884Jrj2jvgTDKBrZuzjF7JTqZNiL1t5fK5PMf5bmNyFX/a4Ol4z4SidEttMOCaonbIAjoIhfy8n23ynDRtBM3f4bZwsjfbu87XqjShUGF/hLyIuBmrsBczy9kbJjnb9LAsJWrqu/HDicthNbHT1HFYjbhLS9Oh1JFcjhkxdkqw4AAW1drqyvNpDlMOV3LBzCZKgZfyncxd81CmNgCErPEFciBPObLmcARETXd8Wj1+btdhvVczWMXxpzpf5GY/t+RUmaZu20Olk42papP10s7YLA6Gw4QM80fD5UonLnQKw386SAIJ2L7EmZoFs0R0v+aC0eSsnVFkJsl+YBR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(186006)(1800799003)(451199021)(83380400001)(2906002)(5660300002)(38070700005)(71200400001)(54906003)(110136005)(7696005)(66946007)(64756008)(66476007)(66556008)(76116006)(66446008)(122000001)(33656002)(9686003)(4326008)(55016003)(316002)(38100700002)(41300700001)(86362001)(44832011)(8936002)(8676002)(26005)(7416002)(6506007)(478600001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bKFi3/BoCsV1nypRILEZrmmLFQRUxRGy2ayWVdbQSEhha0XaTlGVzsKkZKAi?=
 =?us-ascii?Q?bz7dT24PTQYi+Ipx7fmdua2a4qZIruRhvM1RFlnWyI+qMXYWIAkGpiAIsQhk?=
 =?us-ascii?Q?zPaEYuMaBrmv9CFytuz1Q1xopJShJp/CsFwDhtJVp5tKLKz5zAQA57YJHIAm?=
 =?us-ascii?Q?cZzzD2k6YcjOmy4ojS4j6D8Llo0UGteZALVtezntA9MaKN/lDvK8mItifkHj?=
 =?us-ascii?Q?CuxoOUEzuo3ldJmXPMl3UNcmT485EXLGixR8cKUvjtC3QNnwJ15U3irz70c/?=
 =?us-ascii?Q?lacJeS2gZHG8MpZaTM/rbFVzb0ZZ27dOgyzkb+J0INizVza7t7wUwr+e915+?=
 =?us-ascii?Q?Ill8tFjLnF6XoezguwUBU9eQp7Gi95kpkd5jdM/yILAlCu3rdv5vXw4ZLksd?=
 =?us-ascii?Q?RYprJY0QqUxCFyS4cQCFMAZ9wPEpKk8053PzT0IuRNKVdN9D329nIPNSnI7I?=
 =?us-ascii?Q?FxGiG+9hBpBRYBopcGqJSUwLJwffql+LpiqMAo0hDfk2FHWn0MAEUU2ElMLC?=
 =?us-ascii?Q?5MLeRxpt+BgfSmYAedefieq+YtOOMvFgD+zeY5nx4oEZHAYnT/CaSH8ftmd1?=
 =?us-ascii?Q?g43RUQoea8wfoEUNnpknijN/TspHwQRhECkJFel2usbTFK640FWD5shdmlsq?=
 =?us-ascii?Q?TV4+PsfT3xHJcJeCSz7gtWb8V+m3D7G3oz+EREbs+RDJaXrWOtZN82pO16T9?=
 =?us-ascii?Q?yfnEViPRh32hOR4SnSgbFy/gG7eKCDtIrLvExteRfVAwCvc0g7ek1aYHVdzn?=
 =?us-ascii?Q?pqDaZOj2ZJ4ZCbULWvTdeqzmLNvFprvjepRniLoEgS5T8AS4AGdZx9eLteF/?=
 =?us-ascii?Q?jx63RXl7e6Qj/eIrgR6oZUTOuMUN2F9O0gLNErrEXdDhjzJEkEP3inDnKKdT?=
 =?us-ascii?Q?MCuFnJC3DxhViPqYW3QEDAzxt9k06m1OcwJuYZHKt10pK6Y9sklmxHigRz50?=
 =?us-ascii?Q?JOp4dsbJQJkEgz8yol8RTSzQnZVfOU77xkaAoBz1eKGz0dvZfXVsp98ZqhX6?=
 =?us-ascii?Q?mq4ecZY4PjmDF+kvrvHwZFgLgjHP6cuex9jXWb+2DNlPuQiyagD4vqMDz1vy?=
 =?us-ascii?Q?9bibkPKu+68V9ErSx2cvK/g5eZck9kfNDNeytbBmWqqjeXmw0ik6K621j838?=
 =?us-ascii?Q?8fHjwjok39wlSFYVpdS1leUQ7+5jyRAVPhY8wnMxMsGOc5csy7PNAaBO3QZa?=
 =?us-ascii?Q?rXzYKT/R4K4UcfpZzTshq2kS+1A1ImSn2/R2N3KEG5/LWoVhM33cf9WUT/zJ?=
 =?us-ascii?Q?/YYM7H4IpD+7n/HVGtg8wvONe1Dsc4UahA9wZTnSzwIIywPaWBB2WRJ05okZ?=
 =?us-ascii?Q?nSiiTsMreCMofVAduVx3QdmOsfU0CtqqzwbGWBEUQIu+EMI/XyHdyhwK160x?=
 =?us-ascii?Q?Skx6biCLEMF4iXivX5EPWkJNP9sH6bWDnHgwWCji3OIpXXANZxWBcVR2UhWP?=
 =?us-ascii?Q?VpclTzbeGYxb/VxUZAMDp7yrv3eiqI7Nqk1NZl1n0rxm7TB6ck98adxsrv8U?=
 =?us-ascii?Q?RUcqWlCvaPmOJb24561Lt0ihL0/tPzRjXCtlcAsNXPxoPWwA1I4X0KHXwor5?=
 =?us-ascii?Q?SeS4yLCLvegToqzNyLQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46743d27-ecd8-4538-fc7c-08db97ebac06
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 08:44:26.2131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27hNHOphRPvSjgJ/YF03vAPoBDpDCdd1aRBQEV8jKIXP7igHzIGLmqnrrOJKLNCYGhC6K/pdB0VG7X7Ggs2lKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8974
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Marek,

> Toggle hibernation mode OFF and ON to wake the PHY up and make it
> generate clock on RX_CLK pin for about 10 seconds.
> These clock are needed during start up by MACs like DWMAC in NXP i.MX8M
> Plus to release their DMA from reset. After the MAC has started up, the P=
HY
> can enter hibernation and disable the RX_CLK clock, this poses no problem=
 for
> the MAC.
>=20
> Originally, this issue has been described by NXP in commit
> 9ecf04016c87 ("net: phy: at803x: add disable hibernation mode support") b=
ut
> this approach fully disables the hibernation support and takes away any p=
ower
> saving benefit. This patch instead makes the PHY generate the clock on st=
art
> up for 10 seconds, which should be long enough for the EQoS MAC to releas=
e
> DMA from reset.
>=20
> Before this patch on i.MX8M Plus board with AR8031 PHY:
> "
> $ ifconfig eth1 up
> [   25.576734] imx-dwmac 30bf0000.ethernet eth1: Register
> MEM_TYPE_PAGE_POOL RxQ-0
> [   25.658916] imx-dwmac 30bf0000.ethernet eth1: PHY [stmmac-1:00]
> driver [Qualcomm Atheros AR8031/AR8033] (irq=3D38)
> [   26.670276] imx-dwmac 30bf0000.ethernet: Failed to reset the dma
> [   26.676322] imx-dwmac 30bf0000.ethernet eth1: stmmac_hw_setup:
> DMA engine initialization failed
> [   26.685103] imx-dwmac 30bf0000.ethernet eth1: __stmmac_open: Hw
> setup failed
> ifconfig: SIOCSIFFLAGS: Connection timed out "
>=20

Have you reproduced this issue based on the upstream net-next or net tree?
If so, can this issue be reproduced? The reason why I ask this is because w=
hen
I tried to reproduce this problem on net-next 6.3.0 version, I found that i=
t could
not be reproduced (I did not disable hibernation mode when I reproduced thi=
s
issue ). So I guess maybe other patches in eqos driver fixed the issue.

