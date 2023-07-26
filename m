Return-Path: <netdev+bounces-21437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485957639C6
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D663281E4A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590D01DA47;
	Wed, 26 Jul 2023 15:00:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EB11DA3E
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:00:55 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2049.outbound.protection.outlook.com [40.107.14.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49995CE
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCfoOPvCMrNNcuBktvN1xK3pgfnh4RCSP72MKHkcguMnKPAhNNgIHPFO/SddolvmB8NzEPthJi/csocwDdinjf6MEUySxPQ2GxarYqvly9qxf1xZDP4vY9b0sbfShoauWkVAuDwVEfENc4wtjP+bYas2vpWUdyWWq+AJmW28ouuu0TLRBQJMvPU1VBdcI5UVbgmbQuSjRuXlmCnTvAXzp9xfEdosJ9NVwNPztxhOqRx+qkx5Avj8hF0DWIS55FSxZHZydNESdd7ko2/WXjpnzCqt+8gvm/xFYbboKANcCnr8e+m3m2fuCLYR0wBhYqjHj2MXN760G9sYKpV4QhKfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwS0P9AFgb4pxb8y6ZAQZa3OS+wndRrVVkyZKDpnMLY=;
 b=F7UY0ailveSBDQNnpgQSalltJ+duYy0TO4B5sZaU8euNS7jDzTOTRz3qxXYph6L5Y3uGU1+SZhzP24Orl2HMHNG3dr2gliBmWlURH0/RDB5KcWmm90X5b1AEr1U0IfjNPjmxVibdVr6WAZpgNATNH/pDMQjaW+w6LnCwjr/6sXBUsiu7R7xhwBEVsvNEEF4L5oZZCF6yrXzK2GI7R6PouIRtONgIcIeSTz8igWB4ho9QjKSDgbsI5W4oBJC+tFyRFZpd6qrRKdHMHy4KWQ8l47ZYpKGcXWX4MuxMEUuIU4chx+f3iVW8piGYuA1gKahi/qF4bblrRPLEqzpj4wJfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwS0P9AFgb4pxb8y6ZAQZa3OS+wndRrVVkyZKDpnMLY=;
 b=NW5r4XIf1DBGaqvDNvJixnOGqPCQukPJaXYGZb776RBVdFAB+ypeRHyVkPFMkPtkBKT0gRphuJwW1yTteWiPYv4pMSHJ5quxAg9OUQhjeM7cnrr7LnXnq1vxqxaA4hdciuvJN9MoI2ERtBfOb+ID3C5M8WJGAjGB1Q9hJ3gsMLQ=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAWPR04MB9888.eurprd04.prod.outlook.com (2603:10a6:102:385::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 15:00:49 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 15:00:49 +0000
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
Thread-Index: AQHZvzEtwr0cB5x9EUCXrQC85+we9K/K+NqAgAEqaxA=
Date: Wed, 26 Jul 2023 15:00:49 +0000
Message-ID:
 <PAXPR04MB91857EA7A0CECF71F961DC0B8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <ZMA45XUMM94GTjHx@shell.armlinux.org.uk>
In-Reply-To: <ZMA45XUMM94GTjHx@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PAWPR04MB9888:EE_
x-ms-office365-filtering-correlation-id: f4c93cd3-3b03-46b5-f1de-08db8de91934
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iLAPyuaamXlZHmdBV9MENcxo8b0nRcxP8ud3e4Pa4WVj1z+G0UZmHAp+pvAAXPmb4Ul1Og4Y9SZAJnfrvgGbKYtTes5etyeE9WpP1I3lqMI2HgrhTdlsnxA7Ad05cITdCFSymnxnTeNYFldtioXpG/Q6uCrvcIkkMYr7BqV7ULK/A7ERjDIE8otA1k/TpmviagwMol2V55W1jW7+WVZ4jzMVO9Gi/4YXDYcXQXJerbi/Kv7xTFJAhREFR8WI4BBYv4HCpmtSSaG0uZqeksq5LDOhU7L6LOr1wfW+GaOibVd7xIVgKA/bZd3hxx7lEZMk1HjhKtm/s+Nr3jcIjojPw986onjOCtgHHJNsgBqLDunWIoJk+L2ZoXtaD+jRsQpesjuyl/T4RU8Q/i8RupkAaQsIzGVdPr4E/BNxRn+5HmM2n/vbkVqgefuVHGhXzwRqL4chBBw0M98jcRApMqKKyTNCxV6sPBq/HtZ/dn8C9CVQfhwZTNR26nSYztHnbgRfGFNGAHlYXtOc4jfL+q04XFEdpAzemjBeLXSg9weWIcdufQMsZ+3q03IKnus1xdDInYrgrW6CFcydNDiuPsY7apFflNFbbrUoVdqb2PiSa60=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(2906002)(122000001)(54906003)(52536014)(7696005)(71200400001)(45080400002)(5660300002)(478600001)(8936002)(8676002)(44832011)(64756008)(38070700005)(66446008)(66556008)(76116006)(66476007)(66946007)(6916009)(4326008)(316002)(55016003)(7416002)(38100700002)(41300700001)(55236004)(53546011)(26005)(6506007)(33656002)(186003)(86362001)(83380400001)(966005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uX5xaqRCqOHnkNRofSxpvCHG+MO2NIH0gnew1lPvf94M4IIxvswUb/L2rmHJ?=
 =?us-ascii?Q?jvksyR2NYGtitIttRcUigfxH99ZJODSKDafqsgGsRRpBGPSeTZ4XkDKkxVb7?=
 =?us-ascii?Q?I9SccDhL3GrlJad+cgvmOCTsykhXgt8H/xtBOWy2Ckz76Sn1Q8ECBURpvEpl?=
 =?us-ascii?Q?r960zYBuSgNURlrY9UZE5f9o0p2nMfHZAXMRrCjfdjXomSVta523IdGSLs1E?=
 =?us-ascii?Q?I3Qe4aFIp81nyYwxTwGMKloy0LA9bbsLPq4mD5hmmN8TIr6HFuohOQTjhDK3?=
 =?us-ascii?Q?M3IGAaTIhsUZpEnqBMxPr+xEJCARwFmr9Wg1jQoJS9r5/3fdrqB3KngH96Kq?=
 =?us-ascii?Q?cuFA5W2niCX4+lLSiDv5JNLYX6djcR4s2aeJTPTkHMR6+L5/1fk2nI+nH8B3?=
 =?us-ascii?Q?eqDk6s+k241vu8p5IXSPA/fyiYRiVr+x7y5Pcc2h3nIe29h9naZ54e+TYMnH?=
 =?us-ascii?Q?x2jt4XUreISUvTkjKxe0TwlRhn1E6E5ZOad/O2Oaqmwsqt2TtAOshsQsPurU?=
 =?us-ascii?Q?0w0RJVQ61/OInO/pyqoaxk3s9A7znkoaR8xvsMIFD1WxMzug+5zbRPw8dOug?=
 =?us-ascii?Q?CJcc6rbordxF4Qu/vm4chB3CJJTXh/2E1XSfcM5lRlT5Q1m9srr7qvMeFmQv?=
 =?us-ascii?Q?gpuaMGehdYykLxGFC+rI8uQbrpGJP680yL0NSmn0CNRQgaX1XprQsJ0+nUKR?=
 =?us-ascii?Q?0uxM23m5rR6itWsS0e/l/WFBftdHs+fznrkhOQ6DcON/w4JMeZEDl3hE+LkS?=
 =?us-ascii?Q?OjJuOqOW6TTLOlaslTNkL0INZEUN6Awv/93yhyepjnL4NDsituDTMbAjCxaz?=
 =?us-ascii?Q?jhSWo2q9QhYXKOc2YlYqukzT/z2PVLvMNQUuEwVk1aGgi/PR8oOcbg448oYK?=
 =?us-ascii?Q?QBhxvOmtxMuFJviYv8xr7nZhBdpdEehvjuXa2J2+oTZaRJ9LeCeKZ0bk6/m+?=
 =?us-ascii?Q?CzX8Xaqo66egZXA1n9RK2fYzziG/awSfwpj7fZWbk++70o3jHb8Erqd/6zVU?=
 =?us-ascii?Q?BFn87/0UBwCm9yD+C1BBDi9GEojdlSsHFLOl7bWYzRWEzoxxb7CKZ5cBKuUV?=
 =?us-ascii?Q?nn24yo99PGTDl9z1a7SKcP8cH+qqegZfNDUxUKRKvd2HMLwc3Eui0kcVNm6A?=
 =?us-ascii?Q?Zh1M+fJTifDnjISNBwhrrANdiuiG/M3DJLfCtm7Zs/gahM4B52mYlLI/4dzg?=
 =?us-ascii?Q?HTgRhSrJ/bXT5aiNTC0RwKwqnaw0s4KyLf2JDRxNJCj/IS3/N3rXCQelWsv7?=
 =?us-ascii?Q?Q0cx1RILfh/snxM+gibinxnAqF7k1QuNbH+G+DNj/ge+hsUaqkkydzolubpQ?=
 =?us-ascii?Q?lSRH/jajuEuekXKIDJrGfI36Z6NEa9cbjK1l1bhcHOkO/VaGxt4LgCxb31yp?=
 =?us-ascii?Q?/lOLhQDGGznMGiioMyuLvdMeYMX3BUDO9nux7UjrglRQXTXTiwNUDxsfUSoV?=
 =?us-ascii?Q?3TOLm1a1MyEAoJ65Ox+s9qV28fJXV0XxltU3QrdTDPmJhU09ATOR+8s0Rkug?=
 =?us-ascii?Q?Sd9w5syjqtppZmpJ+c27p7PSTyfRFjD1uGnkkdIfz/+WRWumX2T+OhgoI+Cj?=
 =?us-ascii?Q?Z4SM7DJRwZN1TZqBI/BvvvtayhB0FiTCdO5WeZfi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c93cd3-3b03-46b5-f1de-08db8de91934
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 15:00:49.2435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5N5zoqjy9b8V6fzkFFetFqX6a1PiHDsh8QKscl4UYt7vCD0sDaPJ5ZMQf/PEMbq4hNtAvQObDBOSOtakMF7KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Tuesday, July 25, 2023 4:05 PM
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
> Subject: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in
> fixed-link
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>
>
> On Tue, Jul 25, 2023 at 02:49:31PM -0500, Shenwei Wang wrote:
> > +static bool imx_dwmac_is_fixed_link(struct imx_priv_data *dwmac) {
> > +     struct plat_stmmacenet_data *plat_dat;
> > +     struct device_node *dn;
> > +
> > +     if (!dwmac || !dwmac->plat_dat)
> > +             return false;
> > +
> > +     plat_dat =3D dwmac->plat_dat;
> > +     dn =3D of_get_child_by_name(dwmac->dev->of_node, "fixed-link");
> > +     if (!dn)
> > +             return false;
> > +
> > +     if (plat_dat->phy_node =3D=3D dn || plat_dat->phylink_node =3D=3D=
 dn)
> > +             return true;
>
> Why would the phy_node or the phylink_node ever be pointing at the fixed-=
link
> node?
>

The logic was learned from the function of stmmac_probe_config_dt, and it n=
ormally
save the phy handle to those two members: phy_node and phylink_node. But se=
ems
checking phy_node is enough here, right?

        plat->phy_node =3D of_parse_phandle(np, "phy-handle", 0);

        /* PHYLINK automatically parses the phy-handle property */
        plat->phylink_node =3D np;

> For one, phylink expects the fwnode being passed to it to be pointing at =
the
> _parent_ node of the fixed-link node, since it looks up from the parent f=
or
> "fixed-link" node.
>

Yes,  the above line of code passes the parent node to phylink_node.

Thanks,
Shenwei

> --
> RMK's Patch system:
> https://www.ar/
> mlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=3D05%7C01%7Cshenwei.wang
> %40nxp.com%7Cd5a4b8372a4a4e5092b008db8d52c6ce%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C638259158876867949%7CUnknown%7CTWF
> pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=3DXPNpTlv7jbmOfeiQL5w0A6M2c3p5AOiT
> UOGg73ijFb8%3D&reserved=3D0
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

