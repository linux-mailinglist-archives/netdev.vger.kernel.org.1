Return-Path: <netdev+bounces-216246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5A3B32BAE
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0048A1895EAB
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A418E241667;
	Sat, 23 Aug 2025 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MOUsA2eM"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A51D90DF;
	Sat, 23 Aug 2025 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755977661; cv=fail; b=O2OcD/taOKS3zBQ9wjnlEWnzyIo0pXJI2qjQk4d4GMJ/5BOLct1+Sy/Nc+wC356bhsv+vCrfojFySs5U6pm2XnHXE3kf5fntsJ75GiJvXZ1s8ohac4Mjp3KWgkzu8nlcK2Z9eECt6o+8XgKF8O1DlY9Uuqylfxb766u8UCI84AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755977661; c=relaxed/simple;
	bh=OgbBlgfsHxHkLo8r+3vSwlgMdcRzesVa79xLPTWgzN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pkrFeHUOhA49OEd3XkibJV/Fxu1RHrMfRplGWn1nlujyKmBrbfwn92KgEeTdvWE9PK5tXODYQm0zzuRkJOIFOdZWVBL49WqSZgOjk9X2cfJdWWK/pHnu0KzVLOH6i0fhwMuIsdSa1iM4A/K2JtE34rrWV/DIidpsN6jPgm0O3wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MOUsA2eM; arc=fail smtp.client-ip=52.101.83.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJuuOqD0bcRTNVBBsbKceZ3cYtejagp7909q1z7gF8bWkxeVq5eyjIM7f0DlUpCLkcgiawl5RyMGgbIYoOqfcbsFu3riMpBfb6TMaiFQD+B4Sd095qKxjZBgdI5vrWjD2B7PieTQHMCO3ANaUmFNjEdXuqMnYCES0f+s+Bpo52zA9tdTXpZIUUrvTYn/bJmHHekIFS05CkP9GlXsbeZjkpvU6LneAUPl3Oo5Q6ZjeUxF6Vje/yChbtmZ84rDq8OMT5JsLxjfNp9o9SzQF9RZ+BVjjW1difbP4lXUYTAnoZyuwGA/rYBzif6s6mVmWMGABSCuHu4Mknqz2bEIch00VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6Qj6tlJbleZWR61akD1jcKlpaShje8W1CaL6lO22rE=;
 b=I5SxwvqjjWnMHRmegPBQwdyTh/3S+QUFgA/0/VVL4d82dO+lMFL4MsuSbCcdSBrRvml3douH+IXP1/RlhJKUwS3dZwCTAC2dqOulGQr5WUwL9Zp+b/xfsLVcBQLOtXFfBWo24omva62wfbyVr46TacKDs4fxvY1+ZcK2pwhm4EHKyZ/nLLkuhdSGbtF2d8BWcMfXCtgAGWYndBKNaxHi0r+13x5QNOv7gRsKqPnJ+xbgtfuvlczzK1eEwf5d2e+mrAQrnPhA1Q20cmhNNVjpfZnlJbysiJan5YgyGk/nB087I8w9UA28rhoT5KDqE+6kvzUoDQpHE60IQ31WbJ5V3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6Qj6tlJbleZWR61akD1jcKlpaShje8W1CaL6lO22rE=;
 b=MOUsA2eMV+AmahZCKTzj1Z+QNH4c9K7Jtl3MXTNsnS4qxjiyV7EYLaWkgAJXoRxU8H4xjoxKV4PIrTKbfTkBVTmR2qwFZD4+sd7TzI6m/PbJ0KDYY4j50XDdNecvpUzKfSdo6eq3rvS0sSM6RzGudcTmLHtyiazGyIayeM7t6zSIK7mHApzpkuQ5OeKLMr4SZYybJOCGkgP47HH4Q9CHuv8jqdW6nIp/U9ztMJ76Z2+DmmXxN8eV8LK3de4eAniXuGeaZqjIJ/v6NMAa4vBuevGBB3JZC851ZF3MT0pzeFLEytfFtmqjpzUMwwTb3XRGZF8t7w3PV85FSOIfQY6pMA==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM8PR04MB8003.eurprd04.prod.outlook.com (2603:10a6:20b:240::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Sat, 23 Aug
 2025 19:34:16 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 19:34:16 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v3 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcFGTp//lbd6FT7E6db+OdPQ06/w==
Date: Sat, 23 Aug 2025 19:34:16 +0000
Message-ID:
 <PAXPR04MB9185A88FCCBA757077DD521D893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-5-shenwei.wang@nxp.com>
 <221027d6-a3b1-4608-8952-16ae512e63a5@lunn.ch>
In-Reply-To: <221027d6-a3b1-4608-8952-16ae512e63a5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM8PR04MB8003:EE_
x-ms-office365-filtering-correlation-id: 0e279a2f-36f5-44d6-4a44-08dde27c0c2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?obr7L6ua4ckAbBLSGm+Pd2UyogxvgUo+9ptKpb2bc3BAZDOl1jLLv4yClYPW?=
 =?us-ascii?Q?B+6pOMJNgVztkDfkKtuS4VMNPBbKLqFe+k4GO/NVSQITd2jXaebdnfpj/rCB?=
 =?us-ascii?Q?SEmiWDVeC7qPIZht+aAkd5FcGHiOzrIgo6nIxKGLasnn32SlQ/7MUizD1Q4i?=
 =?us-ascii?Q?3DB0afXFQ4wEjBMV59oKyguZrAekShkiYGd1N/GAYOW1ejrM3DVznBo6a3TC?=
 =?us-ascii?Q?FXa5oqbvyhNjIWXNAsFY2YTqeYONo4x8Izax8FS6GG3/762BAt4FNqitJZYZ?=
 =?us-ascii?Q?oJzaUQpngOoESj8bLKoeZdvKjzVVOd5uDUXoMe8AfRi0oRLietMwBUgG7XDe?=
 =?us-ascii?Q?KRPPRuB0WsujspHkBbmhsJSFU0xBAAmnjRJcjfG4JXtHAZGcx3qK3pYGQ6BE?=
 =?us-ascii?Q?VN1iNR3R9G4ANSh57BSR5LnJ9YvCq0bwCD2aNLVnb096QrB0zeRFJbJoZqIR?=
 =?us-ascii?Q?54dTPu/B4xB/Gt+7FyQdUa1qTyVtPqGlH/RwKJ55Y0NoL9B/agcIjUKTjkiI?=
 =?us-ascii?Q?epAovyS/VX6P41BNfNcnjIgwXnnOKXx/Ju2NMlB0u57tO6YHwK0/19zE3adW?=
 =?us-ascii?Q?FhssV4DOfDUr3EKEsKyd5eQyOfKMN4/2OH+M+l3ffRd3wKrLHp2yFf+IoyQM?=
 =?us-ascii?Q?X3ZKFz/UOBRsNDigxlfuaqVl+fOGYIsZ0N8zdn23qXSj+j4fd5YRUnaf0gFY?=
 =?us-ascii?Q?P6KibtOHxx6aXGlgOrLNY612KzCWlpiJiH/WHoKkLEbEzzkKg0jv/Qw14+Na?=
 =?us-ascii?Q?oZqIZx3klKXDQxwiEJT1kSbt3ZFVUdQQvMPWSKGbWw37VTnr1P4kVSLpgmhi?=
 =?us-ascii?Q?cwaqUq9DXfTuS/SaEz0cpl25PyHD1hvEHHynkXlvNTLr/rnlnb2lFJZYPr7S?=
 =?us-ascii?Q?4VuDM48jx6Zh6lGRZj7+Rzpgo5idGt0tsIkS+FZkza3nDz5BWRTu8IktGmTM?=
 =?us-ascii?Q?XzRxLZxBmMChLL2ViQ1rxyb0azW5vJjUBNGO8aPD/CfyZ5+3vN5dGFK67lwv?=
 =?us-ascii?Q?5qpEUGw+cevxsIklVPHbL+n2zGE/Z+s06sQ0nlXmdxcTemnxd8ALiEa+o++R?=
 =?us-ascii?Q?nNWLyiBlk94ig8z++y1upu15jxzz21stGvrWA7fnAvi8XLmcVw5vmH7MqtO7?=
 =?us-ascii?Q?aXvvQWO3UR21qTyw2sL1aONwhfWFuWIwSNufoZSmoPi6wBTHdItGVSR30Vee?=
 =?us-ascii?Q?kNZ0ey0W4ds7JOD3x1Hpr69d0am4VTgzLsTkyEuaHVAU2M7pi+HIpOc2uvTo?=
 =?us-ascii?Q?xNp3lCqt1/27QiUPNqTfnMGvQNMTyMdWORzB/UO6HiyItbC6N9NZYxvbat3+?=
 =?us-ascii?Q?AwNyCHi+kyztXjsv0adgGtvEvR1Uew28VHN73tNyUXvnl7p6pfeVRLPlB4JG?=
 =?us-ascii?Q?n8pgtHt2iHKlXNp0X08NXDNJWSCz6xVD+bPbOnSy44aGAZwaswc6Jebvrb98?=
 =?us-ascii?Q?bWltdyLSnSLwFJYYt01h00VAN2Jm5oUBK+XuJv1dYB9Wr+mSpliWyg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7K/lTwESdmbPJMMAWTEJJNZmMlsskD6Wn1UJlFixPmo+6dgR3QYhVxVGUkV1?=
 =?us-ascii?Q?COsNK8xr3I6fnhw7IQnWiF7z5TPOAztommy7GXEQxbhPAODLppkS0NfcF7wM?=
 =?us-ascii?Q?dbGGV60qkRppsKxjEEYcZeetXsC6RDx/kyhiNfWx1L3Y2n6VBhR1RiUytgAP?=
 =?us-ascii?Q?s9hnJgG1fE6ujyeqm+bk0r+BkTbfvMWcyt1c/hLlJb7OACC25fFLxAM16C1R?=
 =?us-ascii?Q?c6PkHhkoDZnr4H6WLC4Qc22pxkUISrX+NGkYkA1YhcKPQjFLsLzBREurFdgt?=
 =?us-ascii?Q?3jIq97fhCDPdByUkyd0cAjLrEXPOSaRrTc7znFww9vXm5/QtzAqmJOJ4ngEK?=
 =?us-ascii?Q?U9RU6t5r3LCKYUy5uSK6C6ZI4avVJ/mzTMVfH3PgwPdqKTh0+ixg2mzxIwJP?=
 =?us-ascii?Q?DM2y+TiDdCFZ6qKZH1ulRXRbtLhmshxJE0b1BQGyzyvwxQd01ADH+f1HLlV0?=
 =?us-ascii?Q?7F1mROD4WUbrSl48C/x38j7NrYswbmjTcDNWKhNX9xE+2YYuW0bv9Jh4Uoai?=
 =?us-ascii?Q?MraHsQxDL/5NViDXwxzZZTbzr5ny+NfDZmNTzWjGKPyLK5uwMs7aZKnPm46d?=
 =?us-ascii?Q?9+QCwWw62kGKOE0D1dCDOIXTDIOJgoOtdKZ59K0dqJp32oySd3d8WR+bpbnI?=
 =?us-ascii?Q?xkKuppnHk+2zsblrI9evc3DzyUV0yylmoHohrtuI5PdyHPq2TWCzzz0NKO4Y?=
 =?us-ascii?Q?jua8EinAUK2jNKmgB1L3CDPSzr1i40KpssEofSC4yXBrN6ficQDEr9PsJq1f?=
 =?us-ascii?Q?VMCZn+8A2Z0E7cqX3GYUBanpeVnsEC6m88B64XOoz5/WqoSRbh5KYxN4eplw?=
 =?us-ascii?Q?bLpqbHHi2YEdhXSW/+PxubmHNh1/n2jI9KFjytJVEkjDVLl/CXESyDaVDN8s?=
 =?us-ascii?Q?fl0QdaBOYLXVnpn5keta9gad7RIsZ/H1iYQGWq0l5L8E7M8AwF/3pXeJzv8p?=
 =?us-ascii?Q?C18IxNpvMnbqzt490ep3fb9RmysTHrZEEmQrXGw7JrxrdBh7jA3+X0dr0ZJV?=
 =?us-ascii?Q?e5Nph1mli6RHV0NtJG6J0XrmHJJ9h3BzloG1bE10e444zupEkeGRKXzy/GZo?=
 =?us-ascii?Q?zLVlEyjxoAgJ1uuxqC2t4GUayCYd31pNMDUNIUm+pBsSgWzBNE0RFzbVQIoQ?=
 =?us-ascii?Q?/xEaM1mYKVijrXAcqmJ5s5yk/cE4tDBQZITGedpdGRqBMJSxoKy9tSpGbdOQ?=
 =?us-ascii?Q?H8rsajo/NYTLlYvkEefYHOYrknz2wszrvUCvZxqeB8/mpU3hARx7KkMQh/ai?=
 =?us-ascii?Q?KIgUshsE+2FncepcJ+kLaNrZ1oIyHmpYgc0ay2g+Nc/DYX2Ii4tGZvR9xJ9J?=
 =?us-ascii?Q?b7fALHOfWzIXndvmHftSygvLub6GyzGNp9rzntCYTsBdNFDWwa9vUVQ9J3si?=
 =?us-ascii?Q?nm/kwjk42zfr3GYjv7xmmGNGy9xRA6i80WzmEM7ECkQr1OZ/tgtEmhZxqjeN?=
 =?us-ascii?Q?ZzexQtTDUtHq1riWrKKwpnPLhPKlO5FcaQoxwZxkIx9H0w06VaHBS7N3ex93?=
 =?us-ascii?Q?rcagS93REPLyaS2Et6aS5leBedvQGAYkInwK+hOr569WWxsqOVqA3KgPbQcN?=
 =?us-ascii?Q?Ze9wjs3vfHJc387m9tc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e279a2f-36f5-44d6-4a44-08dde27c0c2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 19:34:16.4210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/i82iY/1zI5MGCeze2TheiRk1b40dNgHsAjWHWFbUeQWsxfl5B/JFTeg+PKXDHt4zSnl/lgSwebf2/iacAXjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8003



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Saturday, August 23, 2025 2:17 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel Borkmann
> <daniel@iogearbox.net>; Jesper Dangaard Brouer <hawk@kernel.org>; John
> Fastabend <john.fastabend@gmail.com>; Clark Wang
> <xiaoning.wang@nxp.com>; Stanislav Fomichev <sdf@fomichev.me>;
> imx@lists.linux.dev; netdev@vger.kernel.org; linux-kernel@vger.kernel.org=
; dl-
> linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH v3 net-next 4/5] net: fec: add change_mtu to su=
pport
> dynamic buffer allocation
> > +
> > +     WRITE_ONCE(ndev->mtu, new_mtu);
> > +
> > +     /* Create the pagepool according the new mtu */
> > +     if (fec_enet_alloc_buffers(ndev) < 0)
> > +             return -ENOMEM;
> > +
>=20
> This is the wrong order. You need to first allocate the new buffers and t=
hen free
> the old ones. If the allocation fails, you still have a working interface=
 using the
> smaller buffers, and the MTU change just returns -ENOMEM. If you free the
> buffers and the allocation of the new buffers fail, you interface is dead=
, because it
> has no buffers.
>=20

I've considered that. I was wondering-if there's no available memory, shoul=
d it still be=20
treated as a critical issue for the system in this case?

The current API doesn't support allocating memory first and freeing it only=
 upon success.=20
Supporting such behavior would require a redesign of the buffer management =
flow.

As an alternative, we could attempt to fall back to allocating buffers of t=
he original size if the=20
operation fails. However, this still doesn't guarantee success.

Regards,
Shenwei

>         Andrew


