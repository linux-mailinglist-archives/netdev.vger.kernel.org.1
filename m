Return-Path: <netdev+bounces-131881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8A98FD5B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 08:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922951F2322D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 06:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B8813699A;
	Fri,  4 Oct 2024 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CTLjRYL0"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013065.outbound.protection.outlook.com [52.101.67.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582D132114;
	Fri,  4 Oct 2024 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728023468; cv=fail; b=WLJQpHovVx96LVt4HZwLHuHZ92tKnbQhTx8FtUsQZETu3HTkoS+/W9E7N2f6ETRTEuxwhyn9USzGF4WWjWOb6WaBU0JxhotIVL0owkmH/EV8F1aEeapeaL6Wrb3IJXaMFt8q2/JakoIvAKddy/0Uhy0daOao1NlCgfL6tyJXIyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728023468; c=relaxed/simple;
	bh=JekaVa2nPkTPq2rSEz94Ez//qaAVSf/pZwZfdlZOLSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DtwP7nfmPPTNWHAhzAHxPGGcmm8gEtOGtGDDgW44Ex9WeCt9X7hJUTH9t2mCm4BRmbVwGNnRXeoiljwCzpPXodD+RyAtRgwebYxn+qRqRBDa0caSXJKz/FwGqYqAf1tXDkzpj2gS26cEfYdyxUh9xsGUxBJcX5OgDVpDxbabxz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CTLjRYL0; arc=fail smtp.client-ip=52.101.67.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTzobGlhUe+t4jnetUtnW/gwml+6lLvtU9s288t7uW284JJdLSDEgt7RmoRuZVqqSMgO/65dO05JxM9wqU4or09+b+KkelBptOGYjohq+zhZkukglJLG4KWz7urEpZrZSTtJ1MEvWG16K58BLXmJKzXA9WibT6DuNEywu788j+4m5FmK8lAN4S6NKcKpY0TRuUs1wgA5zYyy5mOrzvDVS0DBYRcCTiGMdkf3HNerciNr5wK5Dlc+dbfCWFYwVU60lX5+yrZpf9J7DECMzTsriUDOw7XnL5tGnD5MG1f7LTylDYI12jE82oi82Dqu+lFBFHIqbfTN60XbwWjT3n8mhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ES442RDiph+RRzPBhDKfbVrQ9Rr3mKr/ZvnCWB8WcM=;
 b=QFEZTtKlhwVDmuBNtiKbxR3QK2NBclttsm9tJ6pSO4QlkiDW8xWT8mLegws9a3ypMQjUwjY3TCdzBiQpPXEIaeg2hoB+V90Of8oidTgaSP7/Ka0UrDSKI3pLmY/fS73j9eGaJk9tcXpEdo/LyZ7+M8s2hQXvT/58W+7kbEtL9ho17Y6sROEBlPJa9QE21JSd2qBlyIoqymmJtW4pp0Gn7prlIvW0CW/kFbrwVcGeiLtWFp8y8SvkROpyqzKn20T5QBXU17xvIDbf7xZ72cP6EzE684/iBNAaFpQDnXrhcdhEPJ9/B51YSf+DiHNzl7NW0tUozaezX7RfBJI4VMRe7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ES442RDiph+RRzPBhDKfbVrQ9Rr3mKr/ZvnCWB8WcM=;
 b=CTLjRYL0WUA5/NFzkHrtDVmJ19mq68CLtSUEERuiIY/vK+FV17gi5KgAuTCB7vQr0afp5aaaD5e73o7lKvv3R6ffyrd6ar8mp34d7Nf8mdfQQPaUlBpGvMBsKypu+aBfZCpA832rGdTHXhyREGqlmjTdrvAmfu63Od65tkFhYQC+oYyBsvUCPzWSgy7bLkfvWvC62AhsK3CwINgw0D/QrYNY928omOuwhhGtlQZk5YHXwVpenlPo9QOiQ8WgWOsMpgMI6s+tXYOwxktftaUJB1oYzNf8OZer253uPehmgGz4U07Q71x6FsJG6qWwAM2baIcxiDYJH9xov4Ds19dffg==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by VI1PR04MB7054.eurprd04.prod.outlook.com (2603:10a6:800:12d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 06:31:03 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%6]) with mapi id 15.20.8026.014; Fri, 4 Oct 2024
 06:31:03 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Rosen Penev
	<rosenp@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 3/6] net: gianfar: allocate queues with devm
Thread-Topic: [PATCH net-next 3/6] net: gianfar: allocate queues with devm
Thread-Index: AQHbFEf7FIuFJpZBukehd4Yqk11GkLJzD9uAgAMQjZA=
Date: Fri, 4 Oct 2024 06:31:03 +0000
Message-ID:
 <AS8PR04MB8849B58CD8CC440E7A9F6EAB96722@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241001212204.308758-1-rosenp@gmail.com>
	<20241001212204.308758-4-rosenp@gmail.com>
 <20241002092509.1b56b470@fedora.home>
In-Reply-To: <20241002092509.1b56b470@fedora.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|VI1PR04MB7054:EE_
x-ms-office365-filtering-correlation-id: a843bf66-d8ed-4106-0336-08dce43e1e90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?baL6arrBk9VrvH1nz7SqvP/Am13tnIPui4PVG9SWayCrSki+dlmmveVQts58?=
 =?us-ascii?Q?hK2gUx6D6b6FS144tGHjL4qEzHy36bKsokhguVAy01U15hTMywkSCRlajPxG?=
 =?us-ascii?Q?GT+c5zqeSlwW4fQainPeDbUauf5dnaJIf9zULOxcU7YSW+hek4O+kjLq+Rnq?=
 =?us-ascii?Q?eSfXT2StUD5VR0ofgC7DUbow+S4IG6a+WRqpX36MLcZTyx4I4Q7jUSlbmgLX?=
 =?us-ascii?Q?yVVfFtfzuyquZc/zJqK584lNnVojfTF6iFWU7YZchZ3IRMuAzFydBv4siSUY?=
 =?us-ascii?Q?GkSmP8sxNGnE1wCwztxNvXjEpHUUU7sTrvARkbH0vdl4VREI2xGmUgWW0mCK?=
 =?us-ascii?Q?W6wAD1j/1f3fhg4mnIcUcQqFO5fDC/XptN2/DMOOkKdXoybMDlBAbZ1fV5sl?=
 =?us-ascii?Q?6C31Cf2uwKSY7QRp/ZlhDVYxKXrgpyLnvINUH4Dcko4Wm/js47I+jqB7wCH2?=
 =?us-ascii?Q?brvG17qMOi25w1JolI/oX8Ek4zPXVN71HzukxJC6N9xv0i4lY87O2fZyttth?=
 =?us-ascii?Q?BnFVWtbZ1ENN4alrq/f95EFEKf0/ewkhhy6y1fZnMQkyUszBoWe2y4Ly2K4i?=
 =?us-ascii?Q?8sQdBvy0apzbQ7yitq84oeb761MBiREKHYr8M6UtQG8b0k99phWlYNwz8sik?=
 =?us-ascii?Q?DbRWCjgzpYJLqSoMFhtpwQfrrlm8QPz43zIRnGanqEGwPIII1oqXMRCZ8/xK?=
 =?us-ascii?Q?9T+lMS+tBi0J2bOCio7zcvF3CWfap/gmyns5RmK0cTlr0yuY7Qmf8/p6rA9X?=
 =?us-ascii?Q?IgBgG8NzTzQqaDta8phnMqwDps3QWdYda2wn59sv1jtAlL8oLoyPgIobddNI?=
 =?us-ascii?Q?ys36t8aT9UkMSYgOPFELBTsC8uCUE0lbSLg73WVvNJewGX9F8i965zAN4dXy?=
 =?us-ascii?Q?i+NEEJ3XbQOcniQkvessgWeAPHqVuM7BjMsAYgy9QBhKcDx5hyYI+g/Ahx8Y?=
 =?us-ascii?Q?aT1tDHW2GsLxWhftnOVgVdrD5aLzxd+M/62ay6dQMrG8pe66Fo775IVdar90?=
 =?us-ascii?Q?4ZbSGceYMSqDXM1yDVjJm2RU207a1g9+yxLxXpMAoTzGJaMSiW1Eu0NeWUbm?=
 =?us-ascii?Q?i/9HVkhTcdKhpuYEgmtiUYFQVcKxkTKRno3fJPmJpARGY6YbXGneZV22bk7Z?=
 =?us-ascii?Q?WzTkzGyvaB5KKxqbIvToEb/lFJcIEoDTfBrbpNwS7danjOSSnGTKqde27XLb?=
 =?us-ascii?Q?emtQzWBfiQy59OKJm2/iTjmoMX2fVdJ8cJRzaMuVG1vc1JJDOUmZUpM6X3H7?=
 =?us-ascii?Q?zsGZZYm2w/L1QM74a7jwg4Ij0LglTAjNwJIb0wJ4UdFLQFzFrM35zhSBNL9d?=
 =?us-ascii?Q?djzWnUp1YmOGCiUDzg+bvHX57Fjwetpuk04O5/VzrmGCQg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XwjMjYALsq2frmIN+ry8F9metESzxEahrUG2TJx2e24fL2O/W2MFCd0LoPQN?=
 =?us-ascii?Q?k8v7CPjspi9wd1PxPElo62Ciq0/HjFEFCyhdoPNl9DHc9vcBWsV//hWyRfVv?=
 =?us-ascii?Q?cCobPcEEIE/HCSQ6U7nMc+7K38o38eSjdNDxmy+2n8dxHT3QEhQXyUxkJuy5?=
 =?us-ascii?Q?NGdDGcu4nC4yDUDfpY5TscNCuia4wXo6p/sl3xXSTEYtA1iIxhKbHN7Xb6QH?=
 =?us-ascii?Q?78PFeJvZCIgFBk35I4BUZJoDIGSHPHH7P+NYWTbCQMP5tL5DCO1AxWf0IW3T?=
 =?us-ascii?Q?5ipVSWyIYUrXCaV+TB1pyes0FpFQuJAbN6MMPWEJ9VC+oTbO0ZfY1PjN7EUd?=
 =?us-ascii?Q?tiUsbPnyCPEbaEfBltcY0/oSRK2ldnD1lBZ/AVtXTU8pkzgkaATGXBYO3d9/?=
 =?us-ascii?Q?et3WemTIzgpaAEIeBHZHa7SUGz1ItcX9alpdzrP6z1bkzb44Tt3QjgNipEZ+?=
 =?us-ascii?Q?AdhJ6zwgoMxA+43A6ex7MD3MvwNfJeVDph16DXZzcpaJAtmD23KfBjnpBja1?=
 =?us-ascii?Q?Yqbqzy9rjx/exyUp1NXaEL55Svpvq9zu65KlzjY52WnoqMSC7n8XeHRY3XwY?=
 =?us-ascii?Q?bbgVTZosCHl2nd7DHR8Aqucaa0PDLpEqWo5FjZ1QofPP9aw8z1F0fbqss8jd?=
 =?us-ascii?Q?Rr3EjBG+s4QoTDJiuKgXnFvOwsO8tqRlIfkhZDomDHPzxoF5hHmmr3nAanPi?=
 =?us-ascii?Q?2vm8bPWm0t/N+ziyE4ka/USBl3ys22qzDYZYDB1/T6LLfkAU5BsZQfmqCJIS?=
 =?us-ascii?Q?Xolhy3U+Io+WfAeoaqVBCoz7CwsMOK743/ftN5LaN3033WRCJWkVTQjktb5U?=
 =?us-ascii?Q?EzDAQRAPwxghQ46pj3UQLWtHmfoiIcqr8+atZ09vv8xvWAGtHByGTfRF99rc?=
 =?us-ascii?Q?NhyAppb09tST2CKM0lpR4nIENFabXGVhiGEaaQK9Cb0Ln3cZ2ldy1g1w/1Rx?=
 =?us-ascii?Q?i5Ir92QQBHKX5AjY95fVW9R91TuFs41TZHYXo5b80SGB9lsQnCnk9U7Jw5A6?=
 =?us-ascii?Q?8IgbmVqADUIZSbkmOe0rcHbemraSwhc+OMR5FnZj++3CluqjXKI1NyYPBtgb?=
 =?us-ascii?Q?jtfNqxG4EuXbzLCB1ZfLojFTSsIt8gW4RAT47x7pFlTxYCDodO73djsh2lqM?=
 =?us-ascii?Q?vByd8poUi3e5C8dGvUcC13lES65G0FCH0haHr5gh8fhSxxNUhYUwCm/fa5RX?=
 =?us-ascii?Q?/Qha8ZCaNnwD0DV00kPMzDNTn7OEObUaPRqrrfYugH2Wh8gCqVnZ8+C734/r?=
 =?us-ascii?Q?V6YZRXDkX/fo1NEp1gQOlfNerTQabJaqSwJsy5FnHKb1MFwCkqWcu7cbggIM?=
 =?us-ascii?Q?/uqmseNaKhjyHuORcYRxb8txhQKZbdL0eOBC1uOaS/6QEaiWOe0/PvnOmYQr?=
 =?us-ascii?Q?HozPJr9FUzBknvi2snmWrtrnrG5dsHmoC+90ty6KE923v0JiP/LKaEVPPvMB?=
 =?us-ascii?Q?XIckgrtQSGbzvp8LhXCFaiuSbPwnKu4U6kHrGbBROVkaNhkw9mv1m/nkUrU/?=
 =?us-ascii?Q?5sTh49T2wbA1uS+0HClybUw7H9VGH2slf30d0uPf7hOpsoZAD6+p6Aye9g00?=
 =?us-ascii?Q?e0IbAi/odRPMR+37zlABHinIqRdXgYBBShlXCzWz?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a843bf66-d8ed-4106-0336-08dce43e1e90
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 06:31:03.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lVci3n/Xrd0T2u7v7JVu9m0XjMdFJYz6f23zEQVgecqoP+UId8p4hWKg/bCaPPdXV3snOPJf/8drii84BMmK5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7054

> -----Original Message-----
> From: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Sent: Wednesday, October 2, 2024 10:25 AM
[...]
>=20
> On Tue,  1 Oct 2024 14:22:01 -0700
> Rosen Penev <rosenp@gmail.com> wrote:
>=20
> > There seems to be a mistake here where free_tx_queue is called on
> > failure. Just let devm deal with it.
>=20
> Good catch, this looks good to me.
>=20

I like your enthusiasm, but there's nothing to catch here.
kfree() does nothing to NULL objects, however the 'constructor' allocates a=
n
array of objects so free_tx_queues() has to iterate over all objects, to fr=
ee those
allocated before failure.

I don't have a strong opinion regarding the usage of devm_*() API to alloca=
te resources
at device probing time, it saves some lines of code. However I see this as =
bringing limited
benefits for simple cases like device probe()/remove(), especially when con=
verting old drivers
like this one. And there's also the risk of falling into the trap of thinki=
ng that devm_*() takes
care of everything.

-Claudiu

