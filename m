Return-Path: <netdev+bounces-21920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A827976547B
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A808E1C21653
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1704168DE;
	Thu, 27 Jul 2023 13:03:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7995168C7
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:03:55 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169DC1FFA
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 06:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FycEWn/AXSdMwJ7qZf4HVJ3xIliAyv8n72x4JYSgd2DrOdTJpXpHtjOxNTEjEXqv71HzUaj5pmO5dF3uuR0yvX+T+/8pE0kWILpwjNFRMo1xAInnALM4nRrOc2CMaEs5Rv3S+MecIjqG3RY5T09HSQM9ZVxFC1mAsmYQ/u2nwP6JCBlF5dIOdB273ju2nxEEvOecriDP/auTjjHm45PM8Zw99EI9+Ar/ervmLYZbuUmolziQ8CVR6ETnLpDNmpaCeLGGc/NNmGK01FZsC2pTki1iWvvEAbpcPntj/kfa7PVVrnG2yFMroUN7gYy18NmjlQlctJO9qdnxkoIahEt3rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do725Fiepu5OmUk/Z1tOeu5Hay3MCEG01AWJKETBCqY=;
 b=Pf6w5wRNk5gT+P6EYUyRx+K4fn5cFAqkAqQC+4cr7fLi0X6W/banUG0EbfxQKD4peoLQPJ+KovK0Iz/Pcp72rF9p1+pUwfR1xz/qhXfNiH+gxc2VR7no8z1sKnVBBx+YhQ+b10HmD4g0uOpIdS6v5x5oR+RpXbLGmxQ2pdBaqnIXXiCMAiqTiENh1iON4ntVma17jbH2BxU+S637p8dXkpmZUJRSYo0Umf/jGJl8Gh9kdIF59Ahe2Gpe0NzlgSGuguczAzVuEUCyZtChw/carpQAjTf7EQMpT2d/xg2yn/j5ec3HWFjnLFCb8UfF2VNMWO3QnhYRaspFnSE0Y5KgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do725Fiepu5OmUk/Z1tOeu5Hay3MCEG01AWJKETBCqY=;
 b=NMuTZb7zvNHo3YEh4V4RVLGsWeCgG44c4DUaydxZYY7iN1hc7I2ubv7A8CrIo0dw8Ftt32vloMJPUjh9kFU9D3C9N76Btoy4GgszaY+z6+jR81a7K8GM0tQtK63g4An/SFJnci5QpfBLedaXL1npQZeehNkbdean33OrHAvBL7M=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM8PR04MB7938.eurprd04.prod.outlook.com (2603:10a6:20b:24e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 13:03:50 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 13:03:50 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Russell King <linux@armlinux.org.uk>
CC: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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
 AQHZvzEtwr0cB5x9EUCXrQC85+we9K/LNgwAgADv2GCAAAekgIAABiMwgAATfwCAABs2cIAABq2AgAACNGCAAOd3gIAAQuuQ
Date: Thu, 27 Jul 2023 13:03:50 +0000
Message-ID:
 <PAXPR04MB91859AE9A323EA6929F1D02F8901A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <20230726004338.6i354ue576hb35of@skbuf>
 <PAXPR04MB9185C1A95E101AC2E08639B78900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZME71epmSHYIB4DZ@shell.armlinux.org.uk>
 <PAXPR04MB91856018959FE0752F1A27888900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZMFRVtg5WQyGlBJ1@shell.armlinux.org.uk>
 <PAXPR04MB9185108CB4A04C4CD5AE29FC8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZMFtw0LNozhNjRGF@shell.armlinux.org.uk>
 <PAXPR04MB91855E5990464A1B31058B508900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZMIxx2TkW2Ry4AoR@shell.armlinux.org.uk>
In-Reply-To: <ZMIxx2TkW2Ry4AoR@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM8PR04MB7938:EE_
x-ms-office365-filtering-correlation-id: a127d848-d52d-4c55-df21-08db8ea1ebf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mTI2WRxWdrkyyPKfleVI7sXV/NKnTuGlqPyyHK2dRHmbYMJ5xuFrrlaONh7Mue9STu8XTfpd5FR5BLAjpz4tACPV4q6ZM0+O6plKGbNdBAOfxzBkjBgxd3FwTaUdeNRZM5uwvPzWpgcUr+kOpis18f2DqkvLvXwZr1YuAaAOMp3hl2CDkHXYziOCruxdkItjy7vUcIgAPA/OtJ1iu2ripsmB5lIZ+mchIGkez75GITBoQgE7V9g3XA3uE4MovAsnA3WRy2Bm3AMWm8Txpm5HMenwQ+IP75pXPg9LNaqCNbjSF9Q5MxR4fq3mHLwkHQJ0DxtVZ3lKhSs4U3mMbyz1YtDEK1JbSBtpeaQ0H/EHPtFSKpBiE0MXjyv4wJ6tRvjyHHwvQ2gTzp8P/BGVeEa08NAZlEv++b3NpF49AV23M/ab8Op05cDIQLmDtdooBBl6M6CH/SE52j70pRk+MM+z4zCQGBVa4trwnI3yXVS5vujf6YEugL7dROdACjWoU4t96Vu/5TeObPa/QCm9I4E2WUC4fwpzXzJ4QhWbL8cjQ4X2TP+h3pZHMKUd5gx5fd1150QYbu1XIbxygisQjE4TvIz31dye0bLin1uUHy3Ai6w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(71200400001)(7696005)(45080400002)(478600001)(83380400001)(6506007)(26005)(53546011)(55236004)(9686003)(966005)(4326008)(64756008)(6916009)(66446008)(122000001)(54906003)(66476007)(76116006)(66946007)(66556008)(38100700002)(186003)(5660300002)(52536014)(44832011)(7416002)(38070700005)(316002)(33656002)(8936002)(8676002)(2906002)(41300700001)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5t5lqreEz1sBR15/2AtET2HRb7+WbzoLVc8+YfbyihZqWcYCCKvzlCe7gsOA?=
 =?us-ascii?Q?Bzhtn1EiYXLJewGJ7APQOeFFj+FjCPYjoQR7hT1BiBxiqphzucyiKWp9R8CM?=
 =?us-ascii?Q?3T6q9JQHC4MtGzSu2sx1zyIal0EAFGYD+iqfBGrBiYNLmozOn8Bq/bRpcOGE?=
 =?us-ascii?Q?gRyb5FYfiSF3V9elnVIiaRqSoKRR3nW4zXkgXTtyIALxUIPFfXb/UIyeEo3Y?=
 =?us-ascii?Q?7B3YD6Ej9jAut9xxPQtMDLj/fBMqKjcB878RNREqSvz558KeP26O4PxNj/YX?=
 =?us-ascii?Q?a4YmGqnOWEL2rh8eZApK+ysx22MLjzEVfLbpQf21cR4/m8zIXWOXz9RJcRWQ?=
 =?us-ascii?Q?J3Cqe/tZfTKxlviXifYMMt2MeBKtS0jQbl9wOO/J734tUdkve6vci5pEd5Yg?=
 =?us-ascii?Q?nnLQI/2ownuBAjnMCyPKekKb7a++tYKeQ0Abhng6XLEeno4QC7ISYRfLo5f1?=
 =?us-ascii?Q?7gFkCvHqDmGs4dhkF26N887NqBBnllUJFabBteL5QTM7I4VFkMGri2om3K5s?=
 =?us-ascii?Q?1SQKSlvgLsCbg2ETitc0Sx7fqO8ctsRUx1ltBTsSwJ1mEmZ++9dOxCV3z3Nm?=
 =?us-ascii?Q?DbuNh1zdMYkRMMthw1+boHuG91jqBW9uODWKfdojgxzIcXcUYO21HRDiD2uM?=
 =?us-ascii?Q?iaf6kAvq8I4uCoUbHErMy6SXjMSW7Luu4BnajhaX+NI0GBlf1kxAGXIjouM0?=
 =?us-ascii?Q?L+qYBDpgDYyJa2zqOyznx56Fa6vCP/pf/8nTwbLnsooYB/AGqFQYWu0PNb8B?=
 =?us-ascii?Q?vXULBXDhxPdbAGzuDQ9ZZijWUQidgCXTqnoLbUPtocp89JymCQvvXDARdJjf?=
 =?us-ascii?Q?TYhwwA7qy58pc8DPTTKuwyimPQAfwcb4i+gMiovWxn/yuKjW+GAsyGWYfPYA?=
 =?us-ascii?Q?/pFZHO2QPfHMqEke1YedpXqrzNX3lh1Kh6pMeLwQwowb0Njl1ByZTcILEXxA?=
 =?us-ascii?Q?ezoGD8RsxdgSxk3RCMvlcciaYAegHLPP/sgBx3p8R/WFILl7bVhJuzTxhroP?=
 =?us-ascii?Q?xRIPGRBRkTUwqUF2dj6vGulr/imEp2oy2anYJuHptMzyuOjizV7oSOaKiBBv?=
 =?us-ascii?Q?dDDXUdwm7Yx/kldLM+6FrQG/U161BO6u1/4K14tOCKzasSQc4dWHXSauTbsm?=
 =?us-ascii?Q?gTgQk7cvd5VG7YXOP/UcwQa60MFTOf/qWGQoWUYxg2WCl5UyC0iG4f6qBK8I?=
 =?us-ascii?Q?sXxZImQyauDqm9KkUUW1lfjn/xmnI+Ch/u6VeENCpIIh/jX4tfg/F0UyKl08?=
 =?us-ascii?Q?3lU3ZENh+oF3cnQq+gV1ByVpYg/7rvEuTO/H0+TplTcoPOe02T4QiaWCNYo+?=
 =?us-ascii?Q?WVWP1UKdzqPohRf04Sfvrq55XGiT8Z/VI0BumW4RQR8FltKuPVauORFo3h0Z?=
 =?us-ascii?Q?9VK8sAm4gvu9HS4jy+eBCFO6NWzogjW+yh241vf64EeSnsjaeDuIyiTbbdjx?=
 =?us-ascii?Q?QEUnNCMpNVhepAgV4YgiS/pHuo20A0zia6w3AYYuYr/ljh/PhYyNSTg0wxN0?=
 =?us-ascii?Q?frdaV/YpaGhT3uYxecDHecRO05xE3xS4Wk1Nx5QJpzFApiH7JGASqkWx9gBr?=
 =?us-ascii?Q?xiCiN+pUj/bBSWj2GwfnUDyKcVmlIiBpJi7d/1GR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a127d848-d52d-4c55-df21-08db8ea1ebf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 13:03:50.2398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dq19CfAo9i8X0Nurs14eQ/CCYd1B9z20K0J9YYBgcKvTMB9G6CqHB2KKbdZRlOndeKg+UXk3dwdRCcKLWpcPDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7938
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Thursday, July 27, 2023 3:59 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Vladimir Oltean <olteanv@gmail.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Maxime
> Coquelin <mcoquelin.stm32@gmail.com>; Shawn Guo <shawnguo@kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>; Giuseppe Cavallaro
> <peppe.cavallaro@st.com>; Alexandre Torgue <alexandre.torgue@foss.st.com>=
;
> Jose Abreu <joabreu@synopsys.com>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; netdev@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> imx@lists.linux.dev; Frank Li <frank.li@nxp.com>
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
> On Wed, Jul 26, 2023 at 07:17:59PM +0000, Shenwei Wang wrote:
> > > Because of_phy_is_fixed_link() has to chase various pointers, walk
> > > the child nodes and do a string compare on each, whereas you could
> > > just be testing an integer!
> > >
> >
> > I don't think It's worth the effort to change the definition of
> > fix_mac_speed across all platforms, because the function is only called=
 once
> when the interface is up.
>
> If you look at Feiyang Chen's patch set, then his first patch of his set =
adds a
> pointer to struct stmmac_priv to a whole bunch of callbacks used between =
the
> stmmac core and the various implementations.
>
> If you're not willing to do it, then I will send a patch instead.
>
> I don't see what the problem is.
>

Never mind. I will pull this off.

Thanks,
Shenwei

> --
> RMK's Patch system:
> https://www.ar/
> mlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=3D05%7C01%7Cshenwei.wang
> %40nxp.com%7C70e2358c209e47c8612608db8e7fb5cc%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C638260451379427007%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=3DKQCQ%2B6t%2BMz0EQsCAYOJ%2BY3Of
> OG68KqJB0%2FCLiGnULRo%3D&reserved=3D0
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

