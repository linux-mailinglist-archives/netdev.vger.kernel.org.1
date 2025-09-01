Return-Path: <netdev+bounces-218848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CDFB3ED5D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 19:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4AA2038DB
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9057F3064B4;
	Mon,  1 Sep 2025 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ugzpmu3V"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C615223336;
	Mon,  1 Sep 2025 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747603; cv=fail; b=MsbYqDdUJNU27GgoE0U43NrNpiWD//mbaQ2oln83tIOUid/pI630c+scDiRQx3iS6ZOuhWK6W/hkx/mrGEVEzB4bDj2CFhOEwc9I5fr29vjoRiIxwv08441GNZtUIJBCAPP2gNP1y40Y9QfvPoPyEI16RhSgESVHshiyI3OJMLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747603; c=relaxed/simple;
	bh=3D8R4/RvIghP/6Rt4Wfi/r09OWznJMoaCck8m7D7v1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tYCjhjZIibLwjcq3VuIz9FsjO9wl6uyN603yXy459khKfGCtS9djRDG/87PsgRTozL//OGdqjWt8mp1nD4+njIzC72kKJrEO2rWwa9Iu8Qxuol2bxoRa8wRPvNkrXz9lff7wCs0ntzrFDGaRQlMAwbm2SBNfZWXsLKEUp+NFp6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ugzpmu3V; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPhGfQoNMl9VzabdMZHXDSfbLEWIi75ArLtG4oE+s/3q0OW9FYb7CsHW41FMcU7ver5ZPjqLuZgADUubLSl1iMH7Q+LL56rKggMNsb2DInbSBXxPKJ5EhpkzxvKGN0d3mCXDDAq6VUbV+ZMwcVg4b5d31OWQ+PW9byERi4NL8v9jx+TDSfYuUgPGU+pPK5XIoA+j5rpb7FhabSdd1l84vg0+HBF9LJIy74pu08f1SF+3HBJ7nAJjUnx4MoSOKsUdWlN7GXiDyLN2SkkXFcKeqnkBV3pz8ikjNj1ehh8RmxyKquK99Ba3oHGG3ck2NmdCsypqdJZ12FKJlkkxgPlLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd+AvHv7YH6gveKzUXaC3A8PcJiNZ05adpcUQrXZevo=;
 b=pq+PZZcF7wobr3s598X5Tbuh3u3y1E3gFC7Ump15HwHAoCPnriVbFlFF/EZXFB31eYAxPN8vIkJ2PfYSL/qZVBDcwZcnruMDNKd0IEBIWjtgUwI84kNQiZCmmo16o+PeiXP90RKUvuvbKaR/JRHlz+7ZW+GWHCBvdloxsQYD1HmoRD/FenofIs7hAM+8wPnLveh4F2EZgQGwZOoYtSqO+AJMXV2vwY3JKo50hIgVQbyvt1/3Ok/qi/lIoO+R2vyNeBocpAnV/V86VIISO43N/mBckxDL2CREkXNLxvRP9pJzf0qv4OJTOntSJcEiHyloxAbCDfM3vHhG8DvAQQd79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd+AvHv7YH6gveKzUXaC3A8PcJiNZ05adpcUQrXZevo=;
 b=Ugzpmu3VNx20F+jUD38YRiSQDeetXaMpVvBeAiUYySgU/TzvlzyrGxK9a0VSl2osR430gDJQTFcw+vVHr4wN8encDyzHjGl+8nHBtqhLuq6bZZ/Rkl86NcLn3fZDGsWY6YJyxgmLnqdveR29K0D8RBZX4kEDU2joRnIfJbGcLvSKMxBBiSYNs4bbzqJnxwcYJZfEQ3iE4KWJVFpnwUE2caxFj1r+RPRtVqyvsBcXIglumYhWoxPC0QefNa9SVgGGV7hZyDV60pDJ9ZXoyrL3T80Y5/RxxcII4F+1bjZ6txKHTj/tMznn4sdqivMMEenhTfM29TAKpEyJHr8zi13SZQ==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GV1PR04MB11063.eurprd04.prod.outlook.com (2603:10a6:150:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Mon, 1 Sep
 2025 17:26:37 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 17:26:37 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v4 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v4 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcGryNyaJfAq21PkS7AgR37+MFibR95IEAgACwa0A=
Date: Mon, 1 Sep 2025 17:26:37 +0000
Message-ID:
 <PAXPR04MB9185E35E7B53836BD9261A298907A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250831211557.190141-1-shenwei.wang@nxp.com>
 <20250831211557.190141-5-shenwei.wang@nxp.com>
 <PAXPR04MB8510EA7CD915DE9340303B0F8807A@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510EA7CD915DE9340303B0F8807A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|GV1PR04MB11063:EE_
x-ms-office365-filtering-correlation-id: 99337cc9-03bc-4224-5e7f-08dde97cb4ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UMtVqrifbGrPqwcb9NFagHHeH2cGcA7hKZ8Ut+RZgXCL54tp/vTijNlU3E5M?=
 =?us-ascii?Q?SrGoM9qd9TnwUdoaaSQRFXAzuiw47Dxz08Yig8SEwpcwr6s8tNQDWqHEUXLy?=
 =?us-ascii?Q?XqRoEME9Oa3F9Nnji0A6pDK3U6hYNxGx9Q1hz8489Apawbf/8bbX725Pp9/d?=
 =?us-ascii?Q?9P0Kb51kAlyvWwP+ykK9YQcQkwYDEGntacY/5T9UZWVPT7jRl+RK//OY/lmo?=
 =?us-ascii?Q?pLN/lZTZAt3WH650nFDga9zHbQYPNTHT6vZlbtOx20j4aQztpKifsqfTVXWn?=
 =?us-ascii?Q?IJOMNCBZGJuVciM48pAwTNN/XHZHzuyzafLqGHJe32fJu+7XapySYZ9W7lYe?=
 =?us-ascii?Q?dFLca5rOakg9jspzEOR6+T1XMPQ8HaTKvWuQqoCQeQ8p6jwGftxg1aZsLsCv?=
 =?us-ascii?Q?0tfJ4t8lHi2coiwIt9dpY+9DbtcN2f9gbIGGw73ZsXiQn2fzQsy2RnIUx4FN?=
 =?us-ascii?Q?dWp5n5NudwzaNDhKvnlrgJ/4neO+48O+wZb9wTebCLFDFjba474gEpetkANA?=
 =?us-ascii?Q?0BGqkNJvGIAnbELLePKZo55l/VJmGJOXYaWQ0m5qgzVexrxfZPks158Rs0AH?=
 =?us-ascii?Q?s8qh8WD4vReIshRgiDUYxz6SCmN52pvbfR9h/pesID/MYRRZn8brbOHlf+f5?=
 =?us-ascii?Q?cKGe/Ls0jCLKrqv+3ZzcNg+WsnyDqD0eofGbZb1HHf4nfmmqc6cZcpAhzAQH?=
 =?us-ascii?Q?MVZOqglRusgQpWVrUDhenbBAPcE9Hcc3mPZJKpPBGnsa3F4/b57osXRsrwru?=
 =?us-ascii?Q?6piJnJX1yAmbb5CDfA97XA0NnrAy8m1We4oK/B6xBzIMrFxx3DQ+N49pQnAc?=
 =?us-ascii?Q?1oqkAnu6Su+M8nJW5VEM/dT1ThwUo3EBu/IZIqxUK69qa6++9v/I7vDyn4xE?=
 =?us-ascii?Q?cOkzDtssMYncOI5Z5Dn+uJTv9kkmJ1cS5NEboqbv0am0olrkC559AIQNfWvJ?=
 =?us-ascii?Q?SwZNY8A/IH6FnakHJykRAOK1MJ0KiWJWvaUxIBebQK3Id+IBlf3eadUywgw3?=
 =?us-ascii?Q?hplkLNL2t/YHj+VVnpO1Fr+x4dS9wq9Kqz3LWMHh5P87m1RJTuaoC8kbaAkT?=
 =?us-ascii?Q?W4yqGBcAQsf2LnmBeKWGm2+sw/TwZjiNkGLzUUwaDYNfmx19cQ96e2rweM1O?=
 =?us-ascii?Q?kQWxm6t79QGZ5p17UI6W+MZxBKn0CZByFsI3R6oydqCvq2pUVpPZa+/A3fYA?=
 =?us-ascii?Q?MoZLz8QFxfCRoJRuaJBAfQf39ABDQtoGpH5oIfUlIcvwZkMuLRHg6Jx2l2/m?=
 =?us-ascii?Q?gmSRvHCcr78Km1KLLpPBddLK50MWVch1YIIFRz4tIxhxO5jgf7VVD2Zx9I8P?=
 =?us-ascii?Q?AXLohqJZZxUePWpqMeR4WWtiXJR/6scvdyhuTYCh+TfAa6RP0O3WRK+298qc?=
 =?us-ascii?Q?6IDC6OPm4J1Lgk9EvHyKt6/8CboDeZhK3vmU941h4shnhXxpKdC4rgiccsYa?=
 =?us-ascii?Q?/BkcMfQTZkK5Il117mLazhoKcUKW8Y1eo9jx63JeozDjGMrwGhw3NA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?StRjpAm6Vxajgfa4kdNXTv6uLdZi2Rr7UGJ/GCh+hYkSNKyNAQ9Bf4CXxul3?=
 =?us-ascii?Q?Gop8tvkF4BMCk7b3OVdk9svBIggCHIW1iHCe6C4deqYxX29wDwJwQjPaCRet?=
 =?us-ascii?Q?v2H1iuezr76MRKE2H4ADen5p+QptSjkZmJO41Ek5AomVlVS6qmETxNn6VS8a?=
 =?us-ascii?Q?KFDbwZ46A1gnhFVSLvnEb0i5IY8q9sx7VUcIxbnuQ/FLYCcSOsIECkSCXEbw?=
 =?us-ascii?Q?HTIw4djZnIvxEAuH8oGaxiBcFdcKn20bCSVDPC+hWhyzLkkPBFfgHFerN5j0?=
 =?us-ascii?Q?UXMth9dKLIiQ1o1/QnCdUYmGJwefPQIf9RxeC7halg7Yu74MDgude6kM9eaT?=
 =?us-ascii?Q?KRg3/FJpsPPhm/a3cZ2NhiFhfM859I9siXy/HbctVzRZpBcYK+Q6v63RBWva?=
 =?us-ascii?Q?19cQes9ek2K5CbCh6M+9Iav7QET5RAhCww9bDYFtMlik/jge+deJPJDAryzz?=
 =?us-ascii?Q?MHxGPTAS0trxHwshzqekAX+kmpoebv/Egw0zXUXlws+ifqku9kd0mujxhBgf?=
 =?us-ascii?Q?EUlusFBDjEZ18UXKPRAVmXbYPXnN3jKJ0vXXlSmF3+90bCsirO1uIbNqLhhu?=
 =?us-ascii?Q?L8lgWV9ZGrWuKuisAMM57vH2Fb62dkfSkWjaGj/IoMwr6eGX7/qVaPnc1ams?=
 =?us-ascii?Q?TILMep/t2CcHQnhmWz6o4/ozKQ40CozAXKXcgUEDOBedq/SIlfeE7zcMylfa?=
 =?us-ascii?Q?qUamM77B2/nxYEUh6G9/CrCCXoLWCV05uXQG0M3hfJ3AG1WQbDGEE0ua+38B?=
 =?us-ascii?Q?nVXhuNph+FRi3wHx1flbD+uF3GHztBvnYUpDoIqYo1OVmFiSus3I9FPhbQzP?=
 =?us-ascii?Q?5ewjmxrO0eX+vhObYQ8cLw4yO+PGjSzJcSt4rySnWltvMEsrSU22Z5MTdtLq?=
 =?us-ascii?Q?i1MatY4ZT8P6xmfIFFsq2VH194qSiWESvnWBJKvwwZ2tAR+eXvB0WkDEhCRu?=
 =?us-ascii?Q?nH0Tqddqy4lS7nkSYl6DEn9yTqtqDpxdaIG1noVLE7wtb4M5XnvrVIiY91On?=
 =?us-ascii?Q?vTX8ehFfPxyeb9YYeoWCFESCcCpUkIN3Udt11DaAKiBCmEXqaerOhfoIAlz9?=
 =?us-ascii?Q?pr1kQeMHHUiduRXf2+RYt4hsDXewPXsDQYNO8gwqb1HAkJiPPwf8EgnnOoqG?=
 =?us-ascii?Q?KbZCiNbY/7/zdzaYeIn2T011SY9HljZ5KjTaKlaaTs24KBbQgXcUksHdP7HW?=
 =?us-ascii?Q?9txvPF6fW01P7GS7UxsuSqUYCDR4GX4XMMHBbOqv9cHinznUGJvtLutzrv8j?=
 =?us-ascii?Q?vQdFfxMwJf9HLYtCHpuSlKIrEJmJWVBkvP4cgMxyITtHin1OFAOigwIcbqBR?=
 =?us-ascii?Q?GGw5+UXw3hwGgPYHJLUXMbxV58G25y3aN1Tz12Cw55XmP1gSsOemhDA1teTv?=
 =?us-ascii?Q?+ag5hEtd+3wbgRCOQZqbIJtLyI3pt1G8od7rRe/LK1ejYazQzt5hEq8C8o6B?=
 =?us-ascii?Q?0iqaXOvx7K1ArzR89Tu6FKwtS6HI1Z9hp6XOyH9T63hxHHxDbsKng1eYQXU+?=
 =?us-ascii?Q?ZSc6OqdNHqX984DyrqizY4Ec12K0Bx8fNJqYnWp290ei0QrIgX/iFJNq2A/V?=
 =?us-ascii?Q?7BJGtVCmST/QbWP+NBIpgHI5I1iqcz3j2Ska9Njg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99337cc9-03bc-4224-5e7f-08dde97cb4ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 17:26:37.6920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQPoYwo5PhECUjG+yXFfh1iy6yrXgpiLOUHA3ma1cIrVaJRGSF1ws7kEoNF3XbDWE5TpGjcvOLxtN8DDoF2elw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11063



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Monday, September 1, 2025 1:53 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>; Stanislav Fomichev
> <sdf@fomichev.me>; imx@lists.linux.dev; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>
> Subject: RE: [PATCH v4 net-next 4/5] net: fec: add change_mtu to support
> dynamic buffer allocation
> > +	/* Stop TX/RX and free the buffers */
> > +	napi_disable(&fep->napi);
> > +	netif_tx_disable(ndev);
> > +	read_poll_timeout(fec_enet_rx_napi, done, (done =3D=3D 0),
> > +			  10, 1000, false, &fep->napi, 10);
> > +	fec_stop(ndev);
> > +
> > +	WRITE_ONCE(ndev->mtu, new_mtu);
> > +
> > +	if (fep->pagepool_order !=3D old_order) {
>=20
> If fep->pagepool_order is not changed, why need to stop TX/RX?
>=20

The purpose is to update the MAX_FL based on the new mtu.

Thanks,
Shenwei

> > +		fec_enet_free_buffers(ndev);
> > +
> > +		/* Create the pagepool based on the new mtu.
> > +		 * Revert to the original settings if buffer
> > +		 * allocation fails.
> > +		 */
> > +		if (fec_enet_alloc_buffers(ndev) < 0) {
> > +			fep->pagepool_order =3D old_order;
> > +			fep->rx_frame_size =3D old_size;
> > +			WRITE_ONCE(ndev->mtu, old_mtu);
> > +			fec_enet_alloc_buffers(ndev);
>=20
> fec_enet_alloc_buffers() may still fail here, the best approach is to add=
 a helper
> function that allocates new buffers before freeing the old ones. However,=
 this is a
> complex change, so I think returning an error is sufficient for now, and =
we can
> consider improving it later.

Yes, it needs a separate set of patches to re-organize the buffer managemen=
t flow.

Thanks,
Shenwei


