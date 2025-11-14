Return-Path: <netdev+bounces-238621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06551C5C178
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062803B3F1A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512C22FE045;
	Fri, 14 Nov 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RblnT/MU"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB812DDA1;
	Fri, 14 Nov 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110334; cv=fail; b=dGw6xp0DF1AQ/b61KNf7HNKQ75FyksTX3EYsB32WR/n7jItm0Bv2nLL4aZVrlrAm3Jce6OUXLQG4xrK7JHPpabcGTeFgFo/GKafUTQ58EMK3o6m079QPOThEqPVaSTdofnFtHVYgSygYg9qXJktNe2uWkmNAkXWcktodfdgOCz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110334; c=relaxed/simple;
	bh=dYMOXuF3YENZRkKgnkJb3TH+dwBNTxxf6sD1EBQu0IY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6Ic/rbM5JwFuFQC8rAsX6EVwsxdP0wgJu043/UU9fZC/IoIWdN185hd81j9td1oIgOejyR6GOaIOMOPCLqML5XssQiK5p8t9hUdt1FxQVPT1nlOIswo3++xejBuBW8FWSEHvLYSAPRJY7VWtPrSnXiCnO39/cLEUkJKKZHyaRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RblnT/MU; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbrolpuVniFYNVyxPjgeTWze1fJgsgWh4qqiwi5mH9IbIhO3Up1OXo4rqWAvNtgK0Q25ZPOtwaU0Ny3J5cVo9Vx7OaCGRE2wEyXrYx4blPtQCBl0VU+yRG6Btl9enu1ksm04LHK05h/laJiVAO7P6SjiTu4jlwD5OEuKoiZR5WY6XrROE37cvurFd+4rQ3Ym+/8Qf5xwhR9ra9wvQAxHMjQi4pMkL4Nn1TcmKzf+F6hpYPgKPHsd+9wdbLkys5gtKxaOpMgs9O6BpieWJapqjpWYno2SvBQ1UiDnmtAOek0iGo8Ds7AntLlzdrxwNkwZgJqVcZObeynYSoDurSOm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyWNgPupy4joVT4VYRmOMRXbF0ciFPIbhVL8uJaAMs8=;
 b=w9FtK3sjiQpdPLfAwlt5q//t0VSJrSSE3FAnrSaUJHoX/ebhzM+sp5U0Bly/aO/pijFl69X3M6Wtgy5P2Yk9Bc1I074VTGMQQc4puFwYCH6W1BSD2tBMqyVe12TT55+QsDLrd632Oy6X7ffrGiX2Hr0ur68HakmGXWTFwNGaocFSWDMlm2cewILEouIjxk9AOXi2iLhqzu2Q0f2W5jMSUc7QJI7/XVQrAo7Cq+EN8x0efWZhT6tBGALL6KwdzSOzfaNPJ+ojE8GCbwmkSefJAJyDRW8160GadeOGfu625PKtg9SalZWgvUvidI3rTgIqhlsUjQgDokAEKnw/8gJ2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyWNgPupy4joVT4VYRmOMRXbF0ciFPIbhVL8uJaAMs8=;
 b=RblnT/MUAAFQ9BBOzf0hJXrrSBmNSlbSRRJb9TrxZzm1tpVvzWzom6wUn80qCQPJ7rHPEjZGvNvn+Ccj9L9FuLVsWi0xwq/TmhozRF98j6PFH9YhH61zTFkDYHb8uteSKMky5DsXdsCL2cMeCMBu2D3iIP+ERQ25uEiHRFmL+DWnhFIctoSHs5V/1c2W5g3XTYrWSc40XPdqn+sInEtaGduvFxJOOS3zQlWp0WuiWCeUbiRbQRWvFzKj2PloDyMcb/hUeYx+o5+RRk1mvJoDVpcEsc6pRlHm4NWrgOYnvw8KoD6J3HmepY97bWOSMf7KRyytOY+D9TqBj5KCQcy6YA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB6888.eurprd04.prod.outlook.com (2603:10a6:20b:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 08:52:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 08:52:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Russell King <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "eric@nelint.com"
	<eric@nelint.com>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: phylink: add missing supported link modes for
 the fixed-link
Thread-Topic: [PATCH net] net: phylink: add missing supported link modes for
 the fixed-link
Thread-Index: AQHcVSdwds6G1+/pQkasdHEahsrlZbTx2CyAgAADDtA=
Date: Fri, 14 Nov 2025 08:52:07 +0000
Message-ID:
 <PAXPR04MB8510007477C858A7E952E8E988CAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251114052808.1129942-1-wei.fang@nxp.com>
 <aRbpKcrzF9xMicax@shell.armlinux.org.uk>
In-Reply-To: <aRbpKcrzF9xMicax@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM7PR04MB6888:EE_
x-ms-office365-filtering-correlation-id: 67b35172-9783-4428-ee5a-08de235b174c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Urn7g1IWxUmzCRz/vvdkEm9Ewf30qiLTQT31OF1wAjj487frC/+ctxuz9w5i?=
 =?us-ascii?Q?x/doNjk3zCNpl+MgacWh+CK1ZBXP5GqXsL8EONjzl2fcSfUhnxwLWpvtSlau?=
 =?us-ascii?Q?e1giili0oLOoXvAjouIaF7JM/rsIc3gbSSiW079EekZc5urjo+isZpovef3J?=
 =?us-ascii?Q?WsFCV5HbVbAOOc4i6A+Tf4/tovUbCgRRVQnqtMAlDn1duAJEADPWC+zZQDwv?=
 =?us-ascii?Q?m5qBbT5ZE3RJr2tPMX+w0qKjHEyLh/G0U+6G+lEd3Yys7BVm6yhdNaR1Clg0?=
 =?us-ascii?Q?6eSKodGTgU9wBHkMAW6lfeHyfh3TEc9ZfuVbSZz3GGcwR0Cgac0z1BAvfP4+?=
 =?us-ascii?Q?mG+YSO/Tdg0oivz4qHd0bMvuH/Wc1W96kwZoscErcvc7euqZ/03xsjLB2FNE?=
 =?us-ascii?Q?jkzZVOtPi+E+cK1pGtebJjocGXOXNWiABI9hh8EXx/8ktPYAlRQBIFUhZcnn?=
 =?us-ascii?Q?zJusUO1TopAwl+X6ptcensWmeNTvPm2Zsd5uKOtQVlWy1/iRH9u+1IpA0fA1?=
 =?us-ascii?Q?iZIeo2TZTw82xxNYNfcjNCli6jNqTzmWJY17Lj7vaOeCfnkXNvkYrgs/2sIB?=
 =?us-ascii?Q?M+MyCNCQgH0gnJkeKXrxVBt+O0GhQF4I3eHS6CZ8FZz5FuVo9VHKxdr+4ETk?=
 =?us-ascii?Q?ZnSGTwCJfunb/aKEzhR/fh5jVv4TLKVD0SsBbfZStvGezYNk0ePi4sVCKDjj?=
 =?us-ascii?Q?dxEU2ZTgfEzH4pIUkQUEujDheuebI5t2g/T6Rh00dDkr97IhcHQkQ4o23Sll?=
 =?us-ascii?Q?wQNAoRMx7nCd4boc+88sc7d4g51hXXaXo/jS+FXAG04Y9eQIto7lBJuPiRTG?=
 =?us-ascii?Q?xOrQMauj7O6kVMNjJ3TbG8cd9/Q0avKKNFgfAL1RHpha+7ZXwXQZmP5E+Xdp?=
 =?us-ascii?Q?3a/pfYonLv1o6bB3uPApUevtApBJGlzPhJsPD/EY2DaiH907srmn8MwtfD5Y?=
 =?us-ascii?Q?wTf1fJw6X4cWSUd6IzvN/1gE9YPbGZntSXb/Jrj8K6oI/xmlK+NaFOd1op9f?=
 =?us-ascii?Q?pnCjhfykMIqX5uWX3+UY/xJv//+LslUZKkSzAjHlr51WexoXSh2xvx4jl6y7?=
 =?us-ascii?Q?W6frKFrFv67k9VLyk2ApmCTObam4MrCztUgCHa/+C4yS0YCoBAKsD08QWDkb?=
 =?us-ascii?Q?EZyv7HZHfrFIur+bCsVInJ0wt96TQzzaJ8f3EqkLdlnIYcSXERNuiuE/SMw4?=
 =?us-ascii?Q?arnEh3JKcoyepYwzB8gsfD53eJ9NI4+arowXbJ1D4C2J7ib+ImD9kawhg2pp?=
 =?us-ascii?Q?kCgDMD/vrmokvtXhgSQf+8KpDvouPUoqaz8ZHt1vxVuzEsc0SMgEaDvhemxm?=
 =?us-ascii?Q?c825NJ16ZFeqw7jFkngZP6sXZPkpAL2g78JHlO14AD7QdgDTRLYAbMia4UhM?=
 =?us-ascii?Q?wRhxA5/Qa+qlk9foyFiIspzp0eWIbF7ZzOEyS33bUHy+uVVxmEPipSyUKTaT?=
 =?us-ascii?Q?3LBSPGsq8D5QiHt5IGUGCWImGTPhsl8xpgnROiaOW1Q9mQymWtFZLY+tus2x?=
 =?us-ascii?Q?0GX/TMP0Nm6b1MPBEbX1h8M1PbIBZxmUKkEc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VdNHu8BkydBXFnmKMXZ1I2ISyTn0L7FDbiebJGIqNiK/yCoYNaYPCW7mYEJn?=
 =?us-ascii?Q?PiJmxrFRpCT3mT5ly3udofe4+LjKT+qjhiYNkovKqrgwwn6KNIU5mym4bprM?=
 =?us-ascii?Q?u5iUBhWRPrCENmgPrj9NX0bpfDoIa2J5HhyFUUZvcu0AmoWo5zi3WkYFatsc?=
 =?us-ascii?Q?nMpxYgjDvJTbmupsFjICk8IJEdzPcxyf2o3Q2TyESyyLL61fPfa9QoszDCbz?=
 =?us-ascii?Q?Zo7QfE8RKcZR6xHN0YhC8IUFoGKFGRCX0CkBYXCX4wFn8oWY53YWgj1vfdOI?=
 =?us-ascii?Q?FsvIQ5CQGqX9jxJt9eHlVB4uTPcYWbn9vguKgtJJL3ZM4b7etSVR84347UGB?=
 =?us-ascii?Q?wmJ+TRkwK+N3J76vraF7bx7Lw2iP0DtM6oDN3+ObnDAymCwrByuxAhhy8gtX?=
 =?us-ascii?Q?0sNwkOpNoa5PjnDlptS1VO5FGkLtQbl+J8p0smYwSmVVtnsNimPhuKFFNld8?=
 =?us-ascii?Q?9SD17ZdxetqNsb1qJ6UxjPqg2+TJZ1J06bgV2kBi2dqTsXMP2V9JoKunqVNk?=
 =?us-ascii?Q?kdLD8MnAxn8h58lkBnOeYSL00kU4jFh0i8UxKPkbRnGT6c/CnXEyegDxQjMA?=
 =?us-ascii?Q?y8faMW4s0SoMLgjYwqoiodegLH2sap8AoWDH6msq3zhpyG64y1E1YRk7adyo?=
 =?us-ascii?Q?mrU7M3upfsTuCz3pk8sWIZOplSdhxSS3c/ppTPLAn3Xb//Gyag53b8Y3yUxQ?=
 =?us-ascii?Q?brXeHgYT1Hydl/XMOXGST4DQrw6NFDycsFKVA6eX8VluvdEmwnmeKGXPJjUn?=
 =?us-ascii?Q?wILUjio2eQXDHSTBPTrSMByfmdINJC0IFofH95Am4OK+enQjFOf1iE7qTuJX?=
 =?us-ascii?Q?osLRW/n/+PyaUr01ZUaZjPnvjgPeP5q8eJlZTW0XvedoXOgLOhgfRIXmWjez?=
 =?us-ascii?Q?aXha+L+IrNdp3RaHoCyt/1yKb0Fxy1H3oheUu5n7mVaRkYnOicsEFCEhsT8j?=
 =?us-ascii?Q?6HGaxtkbWwhhDNX2KxH2SYN3Hi2KG3YvHcnT09ylpeJliLISY3odT1bb4/K9?=
 =?us-ascii?Q?gKQY8lM5aTgZWzBA2X9EFvW6DSRSfWIPLvOLKwyCh+xHhgqRNK8EOOh01Fut?=
 =?us-ascii?Q?TpqkJlwfG3Sp9j8HMKnsw3o5mPF5YAmX+oaALKTv13K0zJVL38uBEXesCnlc?=
 =?us-ascii?Q?uRr1IFysMiVwu7gprehGio6o+s6+B7L9b2Peiity52w5cdQ1B4zSqaoxWeUh?=
 =?us-ascii?Q?gHzaE7AShi1DxPDdW/GrpII7ZACHv3uWUWCmGAduABvF0QmrkK0gZc6LrRGZ?=
 =?us-ascii?Q?o1C9NWVbFim3l+/0d3MwwkwHcDt9B+kW+fNBR1pnugR04vVlFIyCb8xVsTvp?=
 =?us-ascii?Q?HLwVyBEHkQ5dZFMGiMFAWsY0bhnOutw+TC8tUiEC27nwRRfiwhooJftsdGRt?=
 =?us-ascii?Q?FeWP+bgVndetG4SsfzgEbce0k0JQ6lqweD+J9QIV5N/K37J7uawB2A1/zJwz?=
 =?us-ascii?Q?xbiaBIfADtATOi8yj1/z7yZ+jFc9TbdV98N8wGCGLYTk5HYLMHb8Qayhyyzz?=
 =?us-ascii?Q?T0rjG7gr6LSKEfu6EFFvAJw+fG8b/IfkVyfsPJmxDnOZcJoRkjHDSmhDE23o?=
 =?us-ascii?Q?lSL8B2b8YaPH6g5hyEY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b35172-9783-4428-ee5a-08de235b174c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 08:52:07.2761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DaYaNBhm/U0ycmlzoDMYZSmptIDkbp/AY6VvbjpE5cUPl1xu1Ek+yXvZ4oofBnM7CbbGABwyinSQIrv23bp3rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6888

> On Fri, Nov 14, 2025 at 01:28:08PM +0800, Wei Fang wrote:
> > Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
> > initialized, so these link modes will not work for the fixed-link.
>=20
> What problem does this cause?
>=20

Our i.MX943 platform, the switch CPU port is connected to an ENETC
MAC, the link speed is 2.5Gbps. And one user port of switch is 1Gbps.
If the flow-control of internal link is not enabled, we can see the iperf
performance of TCP packets is very low. Because of the congestion
(ingress speed of CPU port is greater than egress speed of user port) in
the switch, some TCP packets were dropped, resulting in the packets
being retransmitted many times.

root@imx943evk:~# iperf3 -c 192.168.1.2%swp2
Connecting to host 192.168.1.2, port 5201
[  5] local 192.168.1.11 port 36558 connected to 192.168.1.2 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  51.2 MBytes   429 Mbits/sec  379   24.0 KBytes
[  5]   1.00-2.00   sec  50.2 MBytes   422 Mbits/sec  401   24.0 KBytes
[  5]   2.00-3.00   sec  50.0 MBytes   419 Mbits/sec  405   24.0 KBytes
[  5]   3.00-4.00   sec  41.4 MBytes   347 Mbits/sec  395   24.0 KBytes
[  5]   4.00-5.00   sec  43.9 MBytes   368 Mbits/sec  368   21.2 KBytes
[  5]   5.00-6.00   sec  42.8 MBytes   359 Mbits/sec  346   24.0 KBytes
[  5]   6.00-7.00   sec  35.4 MBytes   297 Mbits/sec  317   21.2 KBytes
[  5]   7.00-8.00   sec  54.4 MBytes   456 Mbits/sec  389   26.9 KBytes
[  5]   8.00-9.00   sec  45.4 MBytes   381 Mbits/sec  359   22.6 KBytes
[  5]   9.00-10.00  sec  47.6 MBytes   399 Mbits/sec  350   21.2 KBytes

- - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   462 MBytes   388 Mbits/sec  3709            sende=
r
[  5]   0.00-10.00  sec   462 MBytes   387 Mbits/sec                  recei=
ver

