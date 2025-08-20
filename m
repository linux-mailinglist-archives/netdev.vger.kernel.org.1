Return-Path: <netdev+bounces-215106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBBEB2D1E3
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F2F4E607D
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA89223816D;
	Wed, 20 Aug 2025 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KkYEB9xf"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFF2222A9;
	Wed, 20 Aug 2025 02:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755656977; cv=fail; b=cin5jtLdjOLpRK0f5LKIINcbkc0b3s7JR3Yh0bKrJbxWBxP7qi4qiuBrGHibyp4t78Gj/21fm7h2gNVNxldSiR+69E191JEwidBEZZl/40CHvPjy6maNlKnliubqC7gpdw8o8RDT5U0WGvjMu3u7NK8aGZeRLG2MyhymfofdRz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755656977; c=relaxed/simple;
	bh=vY+nsFQaCBjvhP8WsCbsyKcqLz9yAvciiEgoVWlBa9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YM+f+ul3X2cQvqlnJzBdSupMQKTW+6s4Y5gg7JOI10oxHWH2RnhdS0BkGZslc0G5v8S29ScyDkUyfQhOxKrl/v85jZvCnAffRZ2Nk4HfYFSs4OR9XpBB/hZqLL5qRxGOhukUPpq00eqT8wRrIDDw/S2mMVxFudMjOz1vmcBOoeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KkYEB9xf; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBqkO6oLi0ZMb7LrlAx/avwjlL6qbI/bSu75R1b0THm7AuuVA1Jp9bOF8qCQKMaQ7r9a2n4GPeibId5piSgTrloM38juiM0osKlsBg48xbtd70OPlsrTiwOx9WWTS3Ba/ZxXW5lowJJyRDnTlu5QRDMkTPXxJHfcG08wvMoIZNo8HmeYWUZ2HOqL/S0klWMWtFVH2N35jDMv5cquEQt8G2lg1e6NmksYMFfzFvp8vApLSStkWWCX2C5CDdcpzcG4PUzcuvJht7sp0/OjGlTPfE7Jef4+stcgWuoKsbRUHRQLvZox4q5vRNe+9PfkZCIeJ9Ro98Db6C2aDqsaWPwpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVsuZ7DMou0gw5juXlswwhx47twU7WyhKUMOFFhBs2g=;
 b=myZKtajZQ2yLgynPw0FX8HH3Mb+uBuDPbeMooE8FkFZ6tZnn7PCiLz8+sjZSKN0QOWBqMLRji3aUab8QVv8yVQxd/ibCtIiajqU5QjOljW0nEivgb/ZjTHI+MjagD/5ycO1+U8dno2t+TvPWM+k59yN9Zs6hQWOci7mzjyf08U/m7VNphU8dj830Yml3ZrMEyXB0lDw+dEbqreMLzXRQJNM0CP4WLO1i9OkP0w1Niv+i9udoEBL3bgYDs9wVNsDfzj9mIAYQetX1LvskKpLUpLlYRc66Fn2L4Phi3422LvL85UNH8Abj5SgB9wSkjjnakqkI3Z8cwMc2U8YWBVxRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVsuZ7DMou0gw5juXlswwhx47twU7WyhKUMOFFhBs2g=;
 b=KkYEB9xfkmAXM3/ZQyTxpjDSrwnOnEod4bw4CQdhaeJCfZwiLQBjCGnqb6PN4GMNyr+RwgC14ZEy2UmO/OyxyaTIfAp0EpJNRj72OCkdb9IvN/9KKHik1LZSrzxR8ijiNeJvqw15tqicOGM9n8fJ0Bg+AsUWuZpOHtToCVDiQWxu9wFQQYoxVJ4/+jrAoNyk+nd6R3tIS98hrjS7l+Oqje5cAzSjYrnRTotWSHETANVnWCjtFQTtXOQDZXMZuyG2Nle7MCsfDiAxsR+ahkfeiIqcUrIp26vAElAG8MrOZMHBn81fa7eo+vteRC7qiD5Enm77BWhsACCjbHgIB5nDxA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10633.eurprd04.prod.outlook.com (2603:10a6:150:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 02:29:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Wed, 20 Aug 2025
 02:29:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "F.S.
 Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v4 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Thread-Topic: [PATCH v4 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Thread-Index: AQHcEQj9ZVA32eWZW0C1teJI4Yst27RqGNkAgAC0GUA=
Date: Wed, 20 Aug 2025 02:29:30 +0000
Message-ID:
 <PAXPR04MB8510D5DCE81CD109FD4017C48833A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-6-wei.fang@nxp.com>
 <aKSXWumC80JpNqDt@lizhi-Precision-Tower-5810>
In-Reply-To: <aKSXWumC80JpNqDt@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10633:EE_
x-ms-office365-filtering-correlation-id: b369dee0-cf6a-4956-44d9-08dddf916442
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GmfypQt+Nap1Lomzn7gMyWulcX3KdXNwrx061Tv/DA/+UbKLjjK2seAdw6nJ?=
 =?us-ascii?Q?99z8ZGBSA3Cbs/ay3LAaCnFS4z7KPrGK9iBsRdBh6ONPKfaJGQmDCuzm+BZV?=
 =?us-ascii?Q?d5O3VRqUVZdXQ6Fxnf18M4hnComUjKFNArM4oqYYeKcB6nUccD6J4ur5A1pZ?=
 =?us-ascii?Q?IfIL+wPmmS5mcLep8MzAYF6zade+2sfyfDKeJpjhedO21hVQ/XnmIg5yFVdG?=
 =?us-ascii?Q?yg6q8DWtNXgaIATxo1GsQMldWPl+9Kky7Oso45RL+pCZU8/JYmAyl5GvofW+?=
 =?us-ascii?Q?lF5YaahXkA40q2TYTSnU07/Gail3VUqp/T0D0XxJj+tYibxxVbGjHkYuGJIn?=
 =?us-ascii?Q?6B6P7Wn2qnOJa9ybFazuEz7WUbqPIWxCElNrw+yVymKC+Tsyvk4PLNlyrB7q?=
 =?us-ascii?Q?ZV4wdRazDXrv2UoQ7L1A3Pwf8XDc6wWr7wRZe+4JW7HDP1yeK68B//a/F5rJ?=
 =?us-ascii?Q?VpQ02Y77ms8SBuLEqResnzyjbi46Q1+jFNxzhBeXAEe59Po48NdbizBwSL0F?=
 =?us-ascii?Q?FhcB7qT1t1Y7dr6Y9gW1QnbGTbD8bGhHEhkBE7azuz1kWjC7bIpB7ZPvZITU?=
 =?us-ascii?Q?48i/8DFowD1MkDhHl+Yo2vtt+r7RlCs+YZGlUtUyr6pQOozP5f0soW4poBAq?=
 =?us-ascii?Q?Vmwuo3Zbn+TXozr6KWYY0H/iJp2ydzgjGMue/idYdD46zFwAhA/LukGD+OZk?=
 =?us-ascii?Q?VWRtHbpLqO9Jnkm7P+d8mggbIYl56jdzywzHPUxB7xa0EiDtZsF/KqPTfyxK?=
 =?us-ascii?Q?b7jNUJrCmjJSUNBxM/a/QY4nh879NVYhHI81cKYityUUEOYT1dSUwHreDEia?=
 =?us-ascii?Q?4QDxwsxm+J5ZBEzkwGBmHJLCv2VBdJNA/s0HEYfh6e0h5MAPC80m6gA9VPDu?=
 =?us-ascii?Q?Vkn3+dFGIG22w2KGBhfj8jsWuauXgyWy8ft06qZJU2uCCWNgb3rJGmAlLkhb?=
 =?us-ascii?Q?676ileY2CYHFgnwTsfk3w7g243aqNA/RHu/ivuui1k6/ijprh63c+KNJnSRX?=
 =?us-ascii?Q?sYkQCLPH+2nz+4W9+BC8CJ7Bn8u8gK/6MbM0ul3RNTau4/kcMs97IHRymTN/?=
 =?us-ascii?Q?my4bNMDjOKtsS/Yk1oFse3gm6IzTdrCpkLPxkStegXov+EvBJDe4uDngWnTZ?=
 =?us-ascii?Q?YMxwAhxGRV8IL5UjVt9rqRrEsblkxulBsBYc/iNelgt+kURjq34JEm0hVe82?=
 =?us-ascii?Q?6vLVSTOqy2ywTQLG2Qvx8iG1eYFPHFRVlP5ijBLSiogVeV2/AK/lK08KgsOl?=
 =?us-ascii?Q?l/1vbGZ3udpE5S39WnlOVnqMsCqKpxPPsTrHkhOv0wvnCyGmod77Et20dtCS?=
 =?us-ascii?Q?TZysiWgIkCQTVxX+QVa8Qb86rPhT1ao4ts1B5oA02Imp5Fo7d/lS3Lal03gG?=
 =?us-ascii?Q?7GZPhoGjbpRenvZ1nR0Jpcnm9i/4iZ/lIQtPFtOTVwjnngIjGdMMiJ5HwO+C?=
 =?us-ascii?Q?IuvuNlhx8HA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DaA688tmoxNSXIzxV7S97i+fbJ3aMuy6srZN5fi8AAWiHFEnLl5Rva/gr6dV?=
 =?us-ascii?Q?BwOImKzbDZ+LnH3zQdcNbr++9pUwvikbg1U9wJ96jnVDUk1zKD5xa2uSVUcF?=
 =?us-ascii?Q?7udJXyYVP+q3I9t1/hDn44B51+s3+ibLNPkIEl2InzH/qFXHnhP52wtO3Euc?=
 =?us-ascii?Q?scVyPERHIEbXIdJQ+JOzmEKyQWSW78eXyTexf/Vlh0mXBC1073m/YnEzP4HV?=
 =?us-ascii?Q?4AUOymL9ImBfEUU8baLcdpc3CYJHrHXqnonCYgv7S7bDIJY6ggoBlauXoK0J?=
 =?us-ascii?Q?04FnnhDV7/ACv1fo0sIW1ui/7tSA+wa0AriOWRdt+Bo/ieOUmrCr1gmLp7M8?=
 =?us-ascii?Q?a4SLpQ2TGsG8YVdPryUafRn03S1UGxLtuC9fgLeyDe5WpOE4xMg6/+YxSL0C?=
 =?us-ascii?Q?GXQpzCwFD0J0NOlwjHW/BCnlubjvZD2f/zO+PKHoCGLLN4JP7L/ZmfEDp2AN?=
 =?us-ascii?Q?3hIPcdTukNW0cDmcjKjz91T9VAFBFUfAiX34SJNSLnfgXdKSZplIAuEdBRWP?=
 =?us-ascii?Q?yWiuC9Jq5b+mNmHCVxJdF8C3bEOuTpKN1LtdkAHcRHg6AlJ8ori5bBbWnLXU?=
 =?us-ascii?Q?sCmJN95ZPSbt+/jZu+8g83O8k6QngbHVJ2WzsNLHlXTgnNd9rr86rrwzuBmj?=
 =?us-ascii?Q?oUC21ZZHF5LaG2ue2ljhvb2KH2tBr1LGJKVGcSlnvBWjswpq5Px/CFubherC?=
 =?us-ascii?Q?7BPMMpOU3ms7OWWY0QlM/Q3SIjhKdDkL5cyON8FMCdyfpNTgkzTiPHVvPAII?=
 =?us-ascii?Q?bSu+2ZPeKFY8DB8kEeVHx289F/oVYfg2S7XPXgIxyedg/CC7LptdTxCgdJ07?=
 =?us-ascii?Q?pdGC6TM4cbBli9VVIMGIQ1bk69TtxLzCRU+W/kNEuBJ16CaI5tKu9WMAhbSZ?=
 =?us-ascii?Q?B1+Vwgo1WwTkRwqZD9xvP4jJu93PRiHsmOsJpKP5s2I/7xL1E0H3uYRpmDl4?=
 =?us-ascii?Q?UC4Nygw83jN40MXW7KAceoQVr03uCYiMmBak1jG1NV6GH+I204d2YRyBmDcw?=
 =?us-ascii?Q?mggMTr/rLGS6o1A8XThj6vmNhhj787CZFll53jE1pmLW8jJW7xSUpu4VLUUM?=
 =?us-ascii?Q?oCk2bpBtI3tv6xbQLn3A+3qMSx1Fa6dvIdI8QHUgsP9yvrWFsDs8KQ1EOx/k?=
 =?us-ascii?Q?gjriFTFjFt3X4No3ekGkD7EcNnZmvVIAT74Y35Ig4hVsFO0z1ovb4+EXmDVM?=
 =?us-ascii?Q?hrBXOPuehi3YsxnNdtc66R04pcaEWaw6lDPVpo6pXpwWxbnztUhUSkwvF6Yz?=
 =?us-ascii?Q?+odwhLzpW1tRsgxCszJi2SRW3hc7S23hywFJxLmYhV1J0UFFmLCaJJ540lpj?=
 =?us-ascii?Q?5dkTNFAqp2kAYZekki8BJYWTYlJMYxB/966Kmo2v/wZkF0PRwPZvxN1ZBO1M?=
 =?us-ascii?Q?DwC4bUe7kY51BENuPHEc3hLzVJIfI6ONS6IFCxuHN+Ki6xQsTzMqNI2tboPG?=
 =?us-ascii?Q?A03Clh86G4e2AERY4QN3cWC5ZGUoBp0DNxiPnfKxFGH/5ntK1gqltNG1Wd9N?=
 =?us-ascii?Q?z6aAdJzECKENr2rDIX9flcvM8NJt7XRdgzoVV7zMb2PrpETi2khSWPKxNHC9?=
 =?us-ascii?Q?gusrWM9LfyXm8eE608U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b369dee0-cf6a-4956-44d9-08dddf916442
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 02:29:30.1356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cchVdvCszGQqmyi/AQ0FKLWxnRUCkauKz69iPxJ3hDcUjOlo27b3xLKO2Fn6hy5u81w7FCi9pGx3wTRbUy7SUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10633

> > +static int netc_timer_init_msix_irq(struct netc_timer *priv) {
> > +	struct pci_dev *pdev =3D priv->pdev;
> > +	char irq_name[64];
> > +	int err, n;
> > +
> > +	n =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> > +	if (n !=3D 1) {
> > +		err =3D (n < 0) ? n : -EPERM;
> > +		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed\n");
> > +		return err;
> > +	}
> > +
> > +	priv->irq =3D pci_irq_vector(pdev, 0);
> > +	snprintf(irq_name, sizeof(irq_name), "ptp-netc %s", pci_name(pdev));
> > +	err =3D request_irq(priv->irq, netc_timer_isr, 0, irq_name, priv);
>=20
> https://elixir.bootlin.com/linux/v6.11.7/source/kernel/irq/manage.c#L2109
>=20
> request_irq can't copy irq_name, so irq_name is out of scope after
> netc_timer_init_msix_irq() return.
>=20
> cat /proc/interrupt will show garbage string for ptp timer.
>=20
> use devm_kasprintf().
>=20

Thanks, I will fix this issue.


