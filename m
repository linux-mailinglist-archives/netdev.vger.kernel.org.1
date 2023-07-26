Return-Path: <netdev+bounces-21594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72869763F69
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DEF7281D3C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E31804D;
	Wed, 26 Jul 2023 19:18:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271DC141
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 19:18:03 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AC52127
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWXu6NIaDhiypKdVoCaXTvsE0LtUGCdZnSBvXL88KgLDMQZ3YczpN4v4MbNlbPtJPpaRfKH38OTERA3bYuxsG6KXnHHUuVBNQOYGKE+GMTFr/f9JHogMHmCpzW0t6ZZjrjuLynJadCpEM9YMXTixLcWHqh19NNyxp+LeW8GK+wbMw9cuBL8RaJfNiAE+3nAc6KiBEqSOHFxj+lWrwS6zXx4FKQUwtnMVhSxA8nLuNppa69smV5/NVV+TTxJq3TqGAH8ySX3xJLNSbcZXHXHjNZUySxbXUTn3lzoo+IxqCxXzRArKzEuImx8dU/GGL8qn15vUDKYXGDeksW5U6nLfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6KCAKqKMpdq/ZDDBi4tR6C9qbG+HR6ctApZyp94EUU=;
 b=JtSLfztm+3MJ+94TYT7U1PNRmMiTWS+V/g9nrqQ8iy0tIZH8glZF56Nai/ORioJhmdoeS9YAED8mKUp/W0pgUWUCvxxKP0MOOIqr0DJ7ldHS7V+Lwwle1AbQdclA02cL9r/zaEx1eN3M3ryj1saphTfipfISzr47EDaDzjE7rnX1OybGPxpb3flx7dhXiHtUWUTPG9ciemhM6wXi7815In43SpiyRF7BMkY9jksmogE4HTeDbWQYKK7foFSPGiYvQ+lsuNgO7VghoLaEzNSb1FPGRvrYq/Hjh6tkKE+QI7mjIx2G9uTZVe9vkIR3wgT5SIUgtnOPYnvyL72IuS+4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6KCAKqKMpdq/ZDDBi4tR6C9qbG+HR6ctApZyp94EUU=;
 b=O1ZJ3MjIAw4Xu73pHxfXenC3NvEY+zqnYpv95QRUSG0dB8ArtjSVYrhXH9PYl1yMnoWP+yMP7vLECUHEs9JqJqC7pnr6dPcRTohmp+DizgiHP8zsWCfi56pD92vkVHiLwslrjNjjK65KCNmObxM7Q9OOE7+TPO0ylJgcrDoNo7I=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 19:17:59 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 19:17:59 +0000
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
 AQHZvzEtwr0cB5x9EUCXrQC85+we9K/LNgwAgADv2GCAAAekgIAABiMwgAATfwCAABs2cIAABq2AgAACNGA=
Date: Wed, 26 Jul 2023 19:17:59 +0000
Message-ID:
 <PAXPR04MB91855E5990464A1B31058B508900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <20230726004338.6i354ue576hb35of@skbuf>
 <PAXPR04MB9185C1A95E101AC2E08639B78900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZME71epmSHYIB4DZ@shell.armlinux.org.uk>
 <PAXPR04MB91856018959FE0752F1A27888900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZMFRVtg5WQyGlBJ1@shell.armlinux.org.uk>
 <PAXPR04MB9185108CB4A04C4CD5AE29FC8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZMFtw0LNozhNjRGF@shell.armlinux.org.uk>
In-Reply-To: <ZMFtw0LNozhNjRGF@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DU0PR04MB9345:EE_
x-ms-office365-filtering-correlation-id: 67ae2589-5287-44ad-0240-08db8e0d061a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WNF1Igf4NphUyMUxdma5ICwpnQ3lA11SWzbA2x4J7kceu93n3R2kTMHJtfSKQ4/w7w8FJ6lGxpnWZMu1ldo5gGPH7iDSNzYCW6uCjKrS09cXCONXvMdiOdL/jVOBk9SFZ3qqBDtey96kpAPW5yiW0o3KuAOkKmoaIFac8hCDhud5robuPvUQS73lgArU/j/aSiN4LgjLnMLDjKpkjP15pJYg0G0HTftahE9DkKAThtJK44OHE4UGlnsYyaIvE109/gxUkPXc/XvGAo/7dIgzJDqji9PodIqLyYXWGUit1a5saTupSBnOGqn3X1674OI/d9Nk4Q8CiKcYAEw3J4SHN4O/EMljshVkInkiuQEv8oa5wMvYj4qUD/FOj5LhWacs3mpgWry5Q9qbsGm8x4QROCC1OJVPGXvZw7lpjHij1OkEXkcfNQL7MBYQSHlRXnWiZPlxxlt9SF6DsxD53v3rLM1sok+RDzua8rdsmYZkPvaSFDp7LRnZdZJsDZ7AewkxTE9IMLOB0RIXIcHHKtRG9OPgozsDvnfONDKKWD5DXgi4SD18iqfOLsFGQiRkaEGEgnfdlRrgLOMfWmhfR5BGbz0LY9GS42Y0dRs2Cb8km/U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199021)(54906003)(66476007)(66556008)(76116006)(66446008)(64756008)(66946007)(38070700005)(83380400001)(55016003)(86362001)(45080400002)(33656002)(38100700002)(122000001)(9686003)(478600001)(966005)(53546011)(26005)(55236004)(186003)(71200400001)(7696005)(6506007)(41300700001)(5660300002)(6916009)(316002)(2906002)(4326008)(8936002)(7416002)(8676002)(44832011)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GGkRN0R3zGRAAHS15/7dk8K9hNrjNgKmuU8yMq+Pd6Lfd+FuttjlawKkwHY8?=
 =?us-ascii?Q?jI63EqbyfRdbZZFdJS2LlsJJi0/AMZmFqKmN1stqzM4EhAbxeU7AOFfTbpZ1?=
 =?us-ascii?Q?YnYUONGkc3zIqDmqEbOtCLPhCefN5jisLIgm4gDGRKObyxHeVbzueARDBehi?=
 =?us-ascii?Q?Z/vRDSBTOsLOrwVUEY7n0ZQRK8FTL/P87XukPDRMK+WRuZ6ikfwa9oBPQJEq?=
 =?us-ascii?Q?aFdr7qLArZEPySAld7n8v37f/EFcKR7joNnlYpWfZSpHIVXd9tJnHZcZE6/x?=
 =?us-ascii?Q?jX8tisAfNy6yTGTSFAJ/ZFTYcozNisS629uozx00XpwsjwvYX7ySDlQ0jbht?=
 =?us-ascii?Q?dFit0lvxyjVCPngf0/YPqflQBBm3/bWmCaA+LmbhUbDXIEvpeD6VI6IFYu/r?=
 =?us-ascii?Q?9lX05dzY4jCGRSp8HkDBTEW1OdMK/ry4lO2YW5XjIM28i1xz/nB+AXgko/hg?=
 =?us-ascii?Q?rveedAkNO6Iy1r6n6hJCehRM6hIBzYKtlqg1R0kA2gyEl8gXTgm9/UL4DCY4?=
 =?us-ascii?Q?WdQYjGypF1cFpuUr3T/yRlVp2dIbj/HVWJEPugI2w9hPtVWL30srC1TXSeOr?=
 =?us-ascii?Q?zO1CWq9NzD719qK7T1xHl395mOIMqaP//kbLwEs0ETYozKAEb7781KkzCGpp?=
 =?us-ascii?Q?Y3PGSguu0n3Gz3buqlDqIv8I1fwKI49nbkjqOp7dttHCvSQH4M4ypfZs28hE?=
 =?us-ascii?Q?BIsF5cvqR6QNDx7YZEKDF08IYNVS1rEd0l3Yb9VCPfrHmUlJ6yUWKrCvRBzd?=
 =?us-ascii?Q?IFVDAruSO6K1ExR8yYL3iAhWXC2cKhlFhin3TQAHQF49/0Sub/4FeidQmvpX?=
 =?us-ascii?Q?qoHYvBMuobCW2MwrQcz1rL8Ra33hRw484YH8GfLXKostIJGBlh1KUnOoA+xa?=
 =?us-ascii?Q?lnexpQW2l4JejpuIQ1bNkM8uGskt0yjmHUwiE98kg1DiQTWuP178PRNGPzoc?=
 =?us-ascii?Q?6+GaNI6T7UvwjKV3z3WgfrKH6JhzItcX4GqAcoP9Tpv07Si/kKIOQQTIu4Zx?=
 =?us-ascii?Q?4Epw9TI4M7/nVv6nL8ntTX6Tl4KuVp9Cw4pxLj9/kLzMTo8BlKLyDwRltFCQ?=
 =?us-ascii?Q?kCoeub9hds0zl7RAP0an8wLc9BoLURPMHj7yN1GYDJGB9inAhQUr6biwftoc?=
 =?us-ascii?Q?dZsje4GkIgHzXFZ3Wbb2eFuiNezL9+4BOVJ6PEVegJc/HoGXEvUd8sAyLSKj?=
 =?us-ascii?Q?VfmIe3YVRy4HVLyX+/DzLiNFyVMvg39uWclODMPJYm4pqNK1ezXC0LN2AjxD?=
 =?us-ascii?Q?pCvGdLG494lBnj8ltzuxDbolEfOzgyMFrtjP6FSMPUDzkbMjBCzbHcOvRUSr?=
 =?us-ascii?Q?G4OP6LAKUPTAGFNaW0Axei9OUtwJSbGbgVFrO7nIrLglYG+YC/bGF7bJgvse?=
 =?us-ascii?Q?nKLtsDvFSWuufG2OXUjzaPt1TuzL6CUl8Nu73XEuoeUiYzg7a5gPWd5u/HxT?=
 =?us-ascii?Q?L8/s2U2sCg2WQGzGb49mYi9qs4l4aKTg2ZBywF4fnkmE8uqVb87foVxLdJ+a?=
 =?us-ascii?Q?7CDG1VTf/CUwW+rkZImpnjmb7tcKmn9b77Qr5K5dvkTGzSF1Vgk36K4MNNtU?=
 =?us-ascii?Q?52ORyykXx+2BjT7omDLAg6+T/bsR6/z2TBAxyWvE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ae2589-5287-44ad-0240-08db8e0d061a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 19:17:59.0850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xG2tBJPZ4F/pz1MyM/HQzSBrVp9i4buPzNc9vtkfMkMTbm6amaXLfeTsMiKSotcXEvu4fd/3vgxbKlLto4T2nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Wednesday, July 26, 2023 2:02 PM
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
> >
> > Then, the way this phylink driver behaves makes the rest of the
> > discussion kind of pointless for now, because I don't actually need
> fix_mac_speed to give me any interface info now.
> > The basic of_phy_is_fixed_link check does the job for me.
> >
> > Not sure why you think it's inefficient - could you explain that part?
>
> Because of_phy_is_fixed_link() has to chase various pointers, walk the ch=
ild
> nodes and do a string compare on each, whereas you could just be testing =
an
> integer!
>

I don't think It's worth the effort to change the definition of fix_mac_spe=
ed across all platforms,
because the function is only called once when the interface is up.

Thanks,
Shenwei

> --
> RMK's Patch system:
> https://www.ar/
> mlinux.org.uk%2Fdeveloper%2Fpatches%2F&data=3D05%7C01%7Cshenwei.wang
> %40nxp.com%7C682cfc4392cc4e4b539508db8e0ae172%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C638259949620016392%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=3DsJy6gzd1LBe%2Bikz1lL3Pq4fK30ehMY%2
> BJKQMJbkOFp4I%3D&reserved=3D0
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

