Return-Path: <netdev+bounces-216350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81547B333ED
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577F21B203BF
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 02:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC180222562;
	Mon, 25 Aug 2025 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XbbaX4WC"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056541E8333;
	Mon, 25 Aug 2025 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756088765; cv=fail; b=Yv+GeAf+znXdFVjL+kUybros0LAAIDjPGh7Qd+9WzrCZBvWRsbJfcoahdTDU8YxCAlx2V72vOjDUAlHPq5BGGbUbZTMfi3vIDGQsFyO3RTsqTDiBk9RzKXT1TAbsomIR+XEEZTNoc2IpbFJP6M43GQ5vjfmgm8QEyfh1ase7hVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756088765; c=relaxed/simple;
	bh=LnKAg0q3Cjroc6FCDduGHJQL8yYCkV6Y4aL22X+gv+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AiJ7qz22JnJAV9elqaicd2rXVCLnwCjsctqHiB0ZDAoq4GDjys/xw5FfOjqQS8ieUlRqa8Zerhe7gY0Y8sSA13Qo7gs0k4n1vynQ8Ll7DuxLrQJDJOrzTbOHTZ2jxtYz0s8UWu5eTpxwF2JOIcQmMW9OTWw4waAzCnB4gXZxGwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XbbaX4WC; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUwgtZpfONBN+W1yIxVJSznt2v2hTtwdJx5tIJ/nZjdr+8UgV9GDnuJHtZ5aN3aBLeQ/9KI4WpR68A6HBt3qz2lV/5h4BntFiwqE40nEiVDOg88fTyuTxTzMUg4FENjNLInrbyWfJQy1ZwF1E44W6Yk0/Xoci5yx7ZzHF7x+BVBMMMNkENa6UWaKgGNR/kZrbZlBxWTVoEdc/pzvytSNagnDf/rRU8KKap/IlxjIJe0a5Vo6vz5TppmstNSFqKVhD0+MA7hECRzkwfDn9TDURRurt2LNw3O3Pa9AT89gX+xGznam+dpOOjuZRRDzNAemLwaJfSJkUgfSWsxMVoq0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoCuHGlMRtpPjzL9woePi0m1rRHo8VlufrZJEqAh2kA=;
 b=kk5t3vtlphJ/GGp7TV2N2qALehjcbhNSj1yKmXWt/5dJ/LtPKkAwHhMqqz7Az99xq4pGw4Y6kZz9YS9vqkW4Zbz4EkE+KG+QUAOD9r+pAKGdlbtMsMkR7s1gF6+ukZF3KTods4sOvlwD1eyiLl9DI1IZATrJCREs0Z9ZxJQ0Omo6yyPENO2PhR8cUNnV1k6S5lKEo2W4uzTw1WCDgChSA0FCUvQW0mIY83+oasJODbLbUKkOlxAs/A6NpVXljAsxFguk7+VjADMpg1eZJ/1U92jL+ZAtfy2/vHQTlhLC2tm3MmmuLMki7pgm4HfUrliOCo8A9gc+hwdU1SmbdZ/oqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoCuHGlMRtpPjzL9woePi0m1rRHo8VlufrZJEqAh2kA=;
 b=XbbaX4WC18AZf+9V6rWT0rTwTDeHpxtXZl70aHobahROvyeYTLEeKH3Ozcesxp6HDTXEGiZqAHYCzgKjLXXxbJ/jpc8k1lhzgsiSns5Vc204qnIHOz7TVClJSzHU/qKdw5a3qcg8o0lhrKivy3ignEftQurxb4Tfchrfse6/YlIaxuzPuDhz5sNIP2eTRs3DRv0f2OXnpgHvjDE3UK3HMD3zq5h/TH3tWkysxwz+rubFjYzjwDOrxd409Wf8a7wJuwMBT+Fa2raTbWh89ueNw1r0SvpfxbzN8MIbT5Ptw3t3/pXM/wGE3PY/onZcgVv6/bHQOatKhXUPlpByn+6NUQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 02:26:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 02:26:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support
 configurable RX length
Thread-Topic: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support
 configurable RX length
Thread-Index: AQHcEsoyoJ7sYfSghkG8db/Gx4Jg+bRucgcQgAA6/YCAA/kJ0A==
Date: Mon, 25 Aug 2025 02:26:01 +0000
Message-ID:
 <PAXPR04MB851035376B94859B359C3A05883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-4-shenwei.wang@nxp.com>
 <PAXPR04MB85106B9BAA426968D0C08678883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB918588241A96C60E7E7E4FE2893DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB918588241A96C60E7E7E4FE2893DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PR3PR04MB7322:EE_
x-ms-office365-filtering-correlation-id: 50a97753-b3da-4c50-cb68-08dde37ebbb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O08pvPSIK52r+XzRsBGbZypdVUaT55XjMz8X2LJmRy9M9hwj8AXMZjqcaEP8?=
 =?us-ascii?Q?aA5Hhfz9YQvdfCk5SeMxS0bl1MB6ECQCwbJq5+cQe4gFMW1Fck7HeF+mgYcB?=
 =?us-ascii?Q?PQzZ0QEOIel7F1GzolKTKrddFAAefzvQL83dOLDnTxV85gW8/hIQXTtcjh4B?=
 =?us-ascii?Q?JcqYDQ20wvwKjCv4aYJ/X0mtWDiWzv94UR4IOIL8nUIwcg9++bRxI4lRm6Cc?=
 =?us-ascii?Q?zEeY6sj0erle1Zqp76i8bXTC5JOHIDxj8vJNbPLMQFJafRzYiRzuFWb619Ix?=
 =?us-ascii?Q?HkmvTvCiLxo3UuuafGAp1Gpx52dMKkJhSOpoDWmM5uvf1/RqVWElgC1cWooJ?=
 =?us-ascii?Q?maGFd/ocwZOUTu51TQodYdm7WaRCEyeO4xfLAW1z+CZOt+phr/p8WIZYH7eY?=
 =?us-ascii?Q?oG6BmfxKYTecQBg/6DaKAfGJt7PzEBtrawUFwt2CjOUVM4ajvkqjhdOF/gtH?=
 =?us-ascii?Q?yTMtKGKqNBGHSX0pBYDBs7+6eNUvB59F6BXK021iwmc/9zL4k0wpzU7H6z3E?=
 =?us-ascii?Q?S69XRK6RvnRM04+gpVnr8Hk9So+i+99k2YFn2kiamHZ+E6T8pWcMHIJhNqA2?=
 =?us-ascii?Q?dK2cd/AnbacLxjkIeJU9WbJovKlgGGsHvXEZv2E2iXcTWsULSaNVz1Haq7Qi?=
 =?us-ascii?Q?GJkPQw2VyjVggrj9ib39Qud28snVS1HaQ06JgxGU9NHOG30OEjj44YWsyBLR?=
 =?us-ascii?Q?Gt+FjzZkHTMcJL5xpXG9TKSOnoYStDxYAUAudhrHOKHTMDAHL+TEeBRCK+ZH?=
 =?us-ascii?Q?am212jkLheowr1D3LJBV18V9dGueBg4WbEnEgVJcM6eUTL/5x2h3Ik/Qbz7B?=
 =?us-ascii?Q?psooXfF+CtdCQb+HEdi5zQExvpO+tidEqYnXqQA7hhAKbIAr6DpPkdIdE7hc?=
 =?us-ascii?Q?BMbnEVa7q4lDYIFLeXNKgQMuW7Y3nZDkRCd9LZsF7K8J/5oMSZxM71NtVe2v?=
 =?us-ascii?Q?3aB/jdu30yQKkpVsbpm8BWkZs2qPocTLxu7GNIehRwS2ezeS8DThh21vDAnb?=
 =?us-ascii?Q?Fv+qPAGBubc3DdU41uAPRnl9g+mrA+6Q+3KgCgE2g5r1SwE1nVtZr0rbgyZy?=
 =?us-ascii?Q?XJmuiOQov0AHGDplcoJ+4gmK9wW/eQCeDeBzBGonf8o2dWircReenlOQIO1C?=
 =?us-ascii?Q?e4m6fugRtUWd4G6zedIwQZCa+TriPV/0wwxsqzirpsjXZM0ZHLMeQkP7V6KL?=
 =?us-ascii?Q?Xb2hhPzPIwfKrNTb3Djuf1GOYTtzo3QSADmz80Y6EXwFtychQ85X7pnFGTfs?=
 =?us-ascii?Q?ohnLThQcWnVttR1Aj+oY51rWxw5G9cz6pSJvfa0pAD82TjWJelfpvnj4gpKZ?=
 =?us-ascii?Q?zbkJneUOHPvVPetTTIDCICAygvSH8wHI4ECLmAIZGbiQtn8d2RpEIHfaaPP9?=
 =?us-ascii?Q?sVdVdZ2i/M5NFeGSaCktxgJbS0a7IvG2CkhSVFojBJNffgklgjY8s1Mcdkul?=
 =?us-ascii?Q?au0xU86aa+S5XMX5VjRfT7hQsf8eZUtAAftcf/hqQPICSyS2jxcGrg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b2Jnj4SM6mUv9Sh1Asckwoy8LV1wo1Nv/TEpzR5K8u6Nw2c0xpYueZpLx+Lt?=
 =?us-ascii?Q?8tP1r53k5n/UzIZt4l2AT+QArZs/GpvwkX684V2d3IhEgis35LNF2NRx6fLE?=
 =?us-ascii?Q?z+y/SG3dvi5t0+A4njt66mMZNE/Ow55qYCufNYmtT7iknK0EU2Za1oBf9uwF?=
 =?us-ascii?Q?K1w6e6dhX7WN9FOhsHjK4vZPMD/VZyK0xynC5o3VcY9V7yzBPH2POzQh8oDb?=
 =?us-ascii?Q?bs8aQF8l+XTd5WU3kWQo37RBgveLVqhsWjNizM9K2w4Oi150CRWKmNYwNSW7?=
 =?us-ascii?Q?Xd8qTCVVHNV1JQ+qDgozeM45QRzC+mmZlssI2WxBEiXMzEQLmTQaK8p1ceNy?=
 =?us-ascii?Q?AwN05/XlEFeE4qUNGSrog4jz2coaRv7Ek+NugxZ5yabSJmH8ww1zgUN+RhXF?=
 =?us-ascii?Q?+1XeSlE49OENRg2jZxf5RYAjT/nWbSXqGZzDBi0qZFV1Wt6k8MS2BlYmLgz5?=
 =?us-ascii?Q?7mGnTJ5eCMT0x7o4ub8WSEB2NaMS2iD2oIjE3aoA56JsT4Wz3OaACre6GPFe?=
 =?us-ascii?Q?Bzr3KqGufkl1cgLRfRtvvfgeIpbjY8fLvezUirxoIA/02pXkEPjmLaUBJmvH?=
 =?us-ascii?Q?yKd4x/ID4GCPAQuzKpvhQ+7T84f8IM8TGjDa+VxZ29cHG7v6JnIzjSZekeYd?=
 =?us-ascii?Q?3auacvWlP2Rqp8ABsxfCYwrTpxI9Y8c4gLipm+BFqH73fgxjP8+xLg2bx0X+?=
 =?us-ascii?Q?BZDIaxZzWnG0i4DszGTFtxYZZyiOmvccUD1nC2mM3NnhpfUqBroyHdOeZ84s?=
 =?us-ascii?Q?bplnQ8iNcNZXb0tqSG9WxRllIetCozFFbNSzXzTGtjUHhZmfDcJQkAeckiWc?=
 =?us-ascii?Q?YiAPZxhiJ7O7jOBpoTSCpUawPOmQ8VycD7wARKn29JO4aH4JruoX8btf4V4l?=
 =?us-ascii?Q?umH5vOdFr28abQSZvAmKoMPI/uYihp/RDF98mN6G6CdSDQoLje222y7kJRR5?=
 =?us-ascii?Q?sQ+7Xx8lr5Qeu/YbFxCo9xKK/Avzp92O4AykhmJQ4q9f4rRLctNsunhiMLAf?=
 =?us-ascii?Q?1BLSrH2h191+zJXVH0rSedOi7mx76LFTvRlKW3dzKsENxiIw6KKFjtA1Dr6H?=
 =?us-ascii?Q?5CNkUyG/U8+svEEp2iS5RDvE3y4EuyLkbQ4U+MVsx/IVXROt2KHuAQKnANc6?=
 =?us-ascii?Q?3Zf98qUqZkr8yX1usrxP0PzZNSdTYzkuN9H5rIsnurB9KgjCqbW2eUkje9YY?=
 =?us-ascii?Q?7UGEez0VWC4IfZmKulYwpjkMhII4l6G6AxBWFWscM3zjDgqqZ61PBobLkY7Q?=
 =?us-ascii?Q?/8ReN/Mf9mo0Ar8jHBM3nFgQtOaAtE1nTqdgyixsqqLB/LM0GNQ5Y2znh6BC?=
 =?us-ascii?Q?0LJhB6CaOfo2uqEuhBtA19PtdsDaUpun41IH6cl+NWHCZDJ/j9MofLaah1Ch?=
 =?us-ascii?Q?8Pmdp9ZSSX05ykZ72t3fddUoa658ZVJ5sEbjxy8KhxdO6SDqqySFU6X2FDgV?=
 =?us-ascii?Q?mWfhpjaTB74kek2W252Kfnb4agUaDJNZbFziRdt4D4RRl81sw7DFKbPIhDNF?=
 =?us-ascii?Q?HZksjs1QmUcAqTE6Vq8z3VXucI2DFfQ+nt1e5tE9u3trWmpEQElUBVno0d09?=
 =?us-ascii?Q?N468D9GFJxaah93Lfx0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a97753-b3da-4c50-cb68-08dde37ebbb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 02:26:01.0856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlO0unquhBMK1np2Q1uN2Ryf0vXqeAlzJCZAeiXNhmT8C+u0mRqQiSXdQbd1Pp2FXyLcc6Tyw4yybcEerU6gmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322

> > > @@ -4563,6 +4563,7 @@ fec_probe(struct platform_device *pdev)
> > >  	pinctrl_pm_select_sleep_state(&pdev->dev);
> > >
> > >  	fep->pagepool_order =3D 0;
> > > +	fep->rx_frame_size =3D FEC_ENET_RX_FRSIZE;
> >
> > According to the RM, to allow one maximum size frame per buffer,
> > FEC_R_BUFF_SIZE must be set to FEC_R_CNTRL [MAX_FL] or larger.
> > FEC_ENET_RX_FRSIZE is greater than PKT_MAXBUF_SIZE, I'm not sure
> whether it
> > will cause some unknown issues.
>=20
> MAX_FL defines the maximum allowable frame length, while TRUNC_FL
> specifies the threshold beyond
> which frames are truncated. Based on this logic, the documentation appear=
s to
> be incorrect-TRUNC_FL
> should never exceed MAX_FL, as doing so would make the truncation
> mechanism ineffective.
>=20
> This has been confirmed through testing data.
>=20

One obvious issue I can see is that the Rx error statistic would be doubled
the actual number when the FEC receives jumbo frames.

For example, the sender sends 1000 jumbo frames (8000 bytes) to the FEC por=
t,
without this patch set, the Rx error statistic of FEC should be 1000, howev=
er,
after applying this patch set (rx_frame_size is 3520, max_buf_size is 1984)=
, I
can see the Rx error statistic is 2000.


