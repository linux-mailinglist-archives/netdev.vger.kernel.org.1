Return-Path: <netdev+bounces-207770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D1B08814
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758F63BEE99
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B74827A445;
	Thu, 17 Jul 2025 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j/WwLeEp"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A9235C17;
	Thu, 17 Jul 2025 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741743; cv=fail; b=UExi7k3H0cgzsbL/tRlgo4Dhhsy/1xn4YB7sAW3bQVJYAygHAG+VdjKsovz0iO9U0oeykpJU9rruKLNH+MbQ7ZiJoLYTZghIS2/43vMWZ65uAMMQBAcmYj7zaU/3GmZ9DTXF+tWkJwwEL1TeZgDth3bEz6YUW53zqv+dLXyUvgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741743; c=relaxed/simple;
	bh=L0cbTaw2bTzEXl6VEU6lu+4hvc7j0NdyGht9YO9KVGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VxxPPW2eC9sgnZjRrx4/uQTAr6tzlsm+RSyf/NnLl3U+ydD3LVpRiECTXSCuJH/7AqYFZh/6FuHdRa2/GJ2o5BF4JGW2C1fUakFkA7uo1950FJafTGumCz4i8kL+jb7oMJoqJ1NuhPjf8H3Tc853y5my6apd3d51esT9iCYJhtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j/WwLeEp; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFgnHg6vdAG9tOMRZU3clc84lTD73+ouVSuhF5ovSmj6EBz7POs7AVmRK/p6cen71Jt67UFOUMNmRyVlTxq9//OIzwbEYO+j27iUfSrzPmriRw8F4dkg38krBitYpwIPKvvSiSYcDok/teWQCIZ4mPadfQ4iwmQPhrSaXeRw9I280fq1uTEvDVe7FPEsJr+7KmgVMZtdCZipo4VguqMd8CG/a/e806DdbTwS+Ix6H37C5BryNWv5IPE0UtAFJsKHaE23T4jordtuElUPv0zlOLIRNkpSqTutax+LaEr+/rfOD+P1myfiWGteR2cLGgZoycDxdqN/G9JuvTq1C6VFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azeofpjq490orUMgjMo4xgtffdHAQnJM9CRsPQd8E7U=;
 b=Sta0MGclBiLiqRuDAg24Huil8qopII35K/QZkVmMR8FwBAXIIrwQOTZSye5RZN5N21F73jY2+1JHtJo885jepWAfhRNKYfKKNcAbtD+hqGBnskSw3diCJmmTIHT0qcloh0zwhdzQT2T5T6DGgsq6U+7KBKKAA5VgM2ar/9Dk743fAWoDe0veIQRh9EocgLs30P236y7mP1v+iSwZesOuYobBWvLOgpWSc4YHyVfnjVhNqWCGkbA15uIVajvLTOFMVQTdupB8XTZX+Kvd2S0er1EBu2G8fCrcviChCPA4RAionHuYzNi0SKcFl7XIIbqqAez1jjK7O4oD4apLOxkImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azeofpjq490orUMgjMo4xgtffdHAQnJM9CRsPQd8E7U=;
 b=j/WwLeEpta7zfZi5sbI12POhyVTpr68ilXlMS1MbuduNu0viPlMPNkFDXY1Vo3z8g6iP32BuQi0fxt9zRgg6eeynKl45eagFv06xVQTYUe6p12eUp14Pv+WZP48RiAkV2ALlUG/VCf8cDFU7BggjYfRP3wjtDHMZH6hhDWYnpDemDP+0STlf+xtXFL0swfDOKLV3ObvKFbcDd6CavL4BMu/t4XnV9Pqd7VP11rB8v+6Woxz3Bx2ZlanQYvvisT/nn8V+u62kCtymrByCu0D0wnRl+Qq7+v8Tv19cXutJ+YEjd2T1SIp6zY1crATuExsODttAeVDbQ11WO1d21VtQyQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 08:42:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 08:42:15 +0000
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
Subject: RE: [PATCH v2 net-next 03/14] ptp: netc: add NETC Timer PTP driver
 support
Thread-Topic: [PATCH v2 net-next 03/14] ptp: netc: add NETC Timer PTP driver
 support
Thread-Index: AQHb9iZqIKdSDIDCCUCMd3Bsvy9xQrQ1K62AgAChxwA=
Date: Thu, 17 Jul 2025 08:42:15 +0000
Message-ID:
 <PAXPR04MB85101EBA548F05B21D87A7218851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-4-wei.fang@nxp.com>
 <aHgEYZmv+sMYu6/I@lizhi-Precision-Tower-5810>
In-Reply-To: <aHgEYZmv+sMYu6/I@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB8PR04MB7177:EE_
x-ms-office365-filtering-correlation-id: cfdb190a-4a29-4f7a-ae13-08ddc50dd508
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kpvYs3WNZR0eG6yj5D914tL13WfB0n1Ttj/q5olImRi5KNMnsoa3ofVQ0Eeg?=
 =?us-ascii?Q?Kt3Su526uy1cwNsf71bhYXXla5htakTVDEnsbMc4Z75KZgAlqnIOwWoX5g41?=
 =?us-ascii?Q?spQMYnmsF+BpLbJNrZTqOB3HikhlkLyf2e8B+oFwPlsuTKrrfjrUy8SVDe9V?=
 =?us-ascii?Q?C8LAw8gxyVsAx52Bg6WUDB66pMYsUhys3c17BC8QuEh430kaKnuc9SMZL9Nf?=
 =?us-ascii?Q?VBtFFLjDN4RH7/Ic5GefOTP7U6Pb19gaIFRhQMDzY6xjocLuAAk2X3cJulXb?=
 =?us-ascii?Q?g/lVO8nVszPSYxE4/0gz/k+9HF6lkIryvyijZ+kc+5fMspphAchjUvPcqW5G?=
 =?us-ascii?Q?FMC1z4ViO2rNlY1NAu6iGCeKWnRHPRBxBreqjSqUqLnX3ggrfMgjeLbm2PZG?=
 =?us-ascii?Q?H1g4201qwG3ZJy2X8fr+ysOwDAmvJ49WeEXlSKuh6xWqcR5+R/DDw7n2S770?=
 =?us-ascii?Q?S4qjZCP9DvKzx2ptGcfw7jwC8sdNIVbFMo/NUrQ+4JtPaA1tZE5TwYcRQf/6?=
 =?us-ascii?Q?UXWW21RepS4zuWr8YwDt2j9m6JLEJ+pPlhAq2mYL0iSiEogQpZ15HYigKPZy?=
 =?us-ascii?Q?5avWO0jRiFqBscIsMmSIBdAObX+U/Ad2ID8621hU9n/OT5RT+d4ZCJqQlq59?=
 =?us-ascii?Q?kBfGiT1l5N5w0Hs3u/6RaZwgXEIE5eh24rgBagwuozTjpiybaBfmg9pT3vPs?=
 =?us-ascii?Q?oZ/g/g+tVeBmx+nwXuCPKhqwgPTKvvFxkaHU5kF1NN+I7lJ60Ic7BDDJCevT?=
 =?us-ascii?Q?//S+VpO0hoFuyzzqK1pEE7ydM374rT96RsXz5cK+RxxNzomyVow92W3ehgVv?=
 =?us-ascii?Q?+rqPLdbr6oLK52oRg4HNO+QT0PrOXQsLE6g4rbZlGIt+0Gs+qbgCMs6P/HhK?=
 =?us-ascii?Q?cKv93fl/gDSJSAxscN7tU30FMEJGR970MsxWqxsOGcznLINWp/HAljbhodGM?=
 =?us-ascii?Q?Wj+uD3k8komULRr8nC/WyLK5Og55C07xkox4GNCLWVJYEnC3Zq5PZlCK7QHM?=
 =?us-ascii?Q?MGayc7S/q7iuMWgtxNhTfKrq+NKBjYFGKi7b76CTPo46vZ1QYl6SP1baM+1b?=
 =?us-ascii?Q?GMqyLjzerwyDZoDjzvKmYxMydxIECF5AhA1djjoVxDhXe3a1JE1ZF/uQFdd4?=
 =?us-ascii?Q?NAbedAT4R8Q3zjrOe0sF8xmBS2XoQfRwKbVipfmbN1CuffIPJ6KsSTviuGG5?=
 =?us-ascii?Q?bKynDjZ09/uX2A2SMlxqnGfzMEjewf0zg9vbFfPtnzyYrb9T5F6BxBfbEQw9?=
 =?us-ascii?Q?XycRkl9wmVjW/nP1KYQ1iv5DO0eHS2ex4D3/5FGlrGYlouRuZpcF98zOMO1Z?=
 =?us-ascii?Q?YiHYjpEKCNFVRzGKjGcHVwNldQGBxeHYMAx6tzXCmwGvJpy8M77eLtDiBUcy?=
 =?us-ascii?Q?nyhZunvR0gZ7BqsFDivnnRW1iP+84S8WO/yRnDgf7TMYdIM0hj1VcGAx7zXn?=
 =?us-ascii?Q?ov+BYMtfHzU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MtBi4NSzyNxiR5HrUR+0sQfWrvlX3ick8wAnPlh86OkcdKz7Am9VoigKQXs/?=
 =?us-ascii?Q?TYgNJ/4e7ZjdCs1EXECUKxZUcbAJJMiqYeqfdf+PCd+dnMz2SzSWwbSYxt7J?=
 =?us-ascii?Q?z60zFHyc+2mo0ysI+Mj0YivsdVviDfuXo6uTDM7AVeIqRBT1hR9ahEuQRsxO?=
 =?us-ascii?Q?iyLDwpgXAmRcpcWJafNH6UNSCFnhk9TMmsUJNDitJC4blbIJePhF3GtUXGQI?=
 =?us-ascii?Q?/P5nWZsXAncYFDas0SD6uwfZKMe0Ah3HPx/neXIBFl+pVxC5TN/2HhVMThq7?=
 =?us-ascii?Q?WUloxoh00dR7BuikDzLq1opcTtqv/ugM20p2wsaVH7SbtaThD4AS31pVaLyO?=
 =?us-ascii?Q?GeB1ae7vc0K5HP8v395pY3svQIo46zbtk2/G13PBtXa+teLsleIvHOIUaFSH?=
 =?us-ascii?Q?EGTCaygrHGcESR8BbWH8PU9a0pnjAMq7sABCNMTIScpuguYleZBkPMOxfg/a?=
 =?us-ascii?Q?uzm8ro+OPtzxFTMmzU0lHM08i4OWaI8gLaD0YR/wXko7TzRKu79g4KKGKFnl?=
 =?us-ascii?Q?UpVmnns5fJep9LCb8YSoxjcjmBFZW3camfbBEDneLkeYdRedpn61Ximx+QnO?=
 =?us-ascii?Q?RYFuqZvzo9GQ8FdoWxkgqMcFf5tbE+4Xjf7UMWAShKYQLsR0v2IA7TcCVHch?=
 =?us-ascii?Q?LJ96hRQ+GH0knY8cPG1RfvY8n4lbOTPS3RAQSm3AvuDhMSuzVSzP/WUtFHIA?=
 =?us-ascii?Q?7Cj88NSduIViysqg17w49rRCCjzrLC/0hbgtdsHSKg0O1JCx2IXiFB6lm9fq?=
 =?us-ascii?Q?mZSBMp+qaaeUS2mlQNj5j5Oh/jmY2cC/PmcsTyJpVhV0iCQ4OShEMT2XXPjx?=
 =?us-ascii?Q?mznJvNWYOIFJu3dyE4oTGUwTcOlcnC5MS7aSSXR50Ri9kDrPZBf/BljWQkvF?=
 =?us-ascii?Q?V36fT329HGJIXyHU6G+Aa9gnCJGIVvLyoR5VwJHwCRvBcZS/mQXWa5kin7VL?=
 =?us-ascii?Q?0rwSd815u207x79QirGeV2ok2uVNHm8eGFO3aIpR8FKDvX/A2hRdhBFOaH5Z?=
 =?us-ascii?Q?gO0DqC5LHAzZC1qh/WyBebXrZ50WTAk8d7OGbb1xhazGtcrPStZTuIkjGHlC?=
 =?us-ascii?Q?7cbYNT49tJYobDL2NwDfLY22+fUYBA/lfVOqcRC044VzsmaeJXfnak8ML1YB?=
 =?us-ascii?Q?VuoSZdxA7K8qyRORy+WS4Nf8uNmxFR+V0Kv/gohc+VUGm2LZC2FKMaU3x9nG?=
 =?us-ascii?Q?yGhkM54zGm54K3iKLzC8v81+5gAbuoi8LN9cmCtKWGOkg5U1NgeuGd7lVofL?=
 =?us-ascii?Q?u37hZnZPhzK3Dlnl5mfdJ2JzngTgr+K5E1rBUb09cnvzeZ/6bQo6m/DuN3MV?=
 =?us-ascii?Q?cnUnDiZQ9adhN3FQ+OKJgG3yK6rO2bwaexcc6rDRlHUgpblH36COg2GIZWph?=
 =?us-ascii?Q?jGZ8sy73Q8FR5gtWlF5i72qRXZ5uTAuyIM7WgDvNKB+9NGHvvSq+4Uh4yvJn?=
 =?us-ascii?Q?FnEkZpvJ9tugWyycbnlPYSEjRD7vao5IzywGrPuamShq9e3Vz2XFDgwqYLCl?=
 =?us-ascii?Q?IckUKZmqNoPnAkYtcLQzQAVUsKpkzbuDC5QuFhVcDm5wLpGUK60n3RUDD8Nt?=
 =?us-ascii?Q?gq2koVR9IqR3pAQJvnc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdb190a-4a29-4f7a-ae13-08ddc50dd508
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 08:42:15.5745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaLQgd+DI7ruVWhTt8plO8gUXvo2V7cMFmIDrQS2Hx7qwGmPeKLBJMkBpv1VJk3Qza3xr1q6RzltEkEw/LUUPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177

> > +static u64 netc_timer_cnt_read(struct netc_timer *priv)
> > +{
> > +	u32 tmr_cnt_l, tmr_cnt_h;
> > +	u64 ns;
> > +
> > +	/* The user must read the TMR_CNC_L register first to get
> > +	 * correct 64-bit TMR_CNT_H/L counter values.
> > +	 */
>=20
> Need comment about there are snapshot in side chip. So it is safe to
> read NETC_TMR_CNT_L then read NETC_TMR_CNT_H, otherwise
> NETC_TMR_CNT_L may change, during read NETC_TMR_CNT_H.
>=20

Okay, I will improve the comment.

> > +static int netc_timer_pci_probe(struct pci_dev *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct netc_timer *priv;
> > +	int err, len;
> > +
> > +	pcie_flr(pdev);
> > +	err =3D pci_enable_device_mem(pdev);
> > +	if (err)
> > +		return dev_err_probe(dev, err, "Failed to enable device\n");
> > +
> > +	err =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +	if (err) {
> > +		dev_err(dev, "dma_set_mask_and_coherent() failed, err:%pe\n",
> > +			ERR_PTR(err));
> > +		goto disable_dev;
> > +	}
>=20
> Needn't check return value for dma_set_mask_and_coherent() when mask >=3D
> 32
> It is never return fail.

Okay, I will remove the check.

>=20
> use devm_add_action_or_reset() to avoid all goto here. then dev_err =3D>
> dev_err_probe().
>=20

hm..., netdev does not encourage the use of auto-clean APIs such as "devm_"=
.
https://elixir.bootlin.com/linux/v6.16-rc6/source/Documentation/process/mai=
ntainer-netdev.rst#L391

I can use helpers like devm_kzalloc() and devm_clk_xx(), but for me, using
devm_add_action_or_reset() does not bring much benefit.
> > +
> > +	err =3D pci_request_mem_regions(pdev, KBUILD_MODNAME);
> > +	if (err) {
> > +		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
> > +			ERR_PTR(err));
> > +		goto disable_dev;
> > +	}
> > +
> > +	pci_set_master(pdev);
> > +	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
>=20
> devm_kzalloc()
>=20
> > +	if (!priv) {
> > +		err =3D -ENOMEM;
> > +		goto release_mem_regions;
> > +	}
> > +
> > +	priv->pdev =3D pdev;
> > +	len =3D pci_resource_len(pdev, NETC_TMR_REGS_BAR);
> > +	priv->base =3D ioremap(pci_resource_start(pdev, NETC_TMR_REGS_BAR),
> len);
> > +	if (!priv->base) {
> > +		err =3D -ENXIO;
> > +		dev_err(dev, "ioremap() failed\n");
> > +		goto free_priv;
> > +	}
>=20
> pci_ioremap_bar()?
>=20

Great, thanks.

> > +static int netc_timer_get_reference_clk_source(struct netc_timer *priv=
)
> > +{
> > +	struct device *dev =3D &priv->pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	const char *clk_name =3D NULL;
> > +	u64 ns =3D NSEC_PER_SEC;
> > +
> > +	/* Select NETC system clock as the reference clock by default */
> > +	priv->clk_select =3D NETC_TMR_SYSTEM_CLK;
> > +	priv->clk_freq =3D NETC_TMR_SYSCLK_333M;
> > +	priv->period =3D div_u64(ns << 32, priv->clk_freq);
> > +
> > +	if (!np)
> > +		return 0;
> > +
> > +	of_property_read_string(np, "clock-names", &clk_name);
> > +	if (!clk_name)
> > +		return 0;
>=20
> Don't perfer parser this property by youself.
>=20
> you can use devm_clk_bulk_get_all() clk_bulk_data have clock name, you
> can use it.
>=20
> or use loop to try 3 time devm_clk_get(), first one return success is wha=
t
> you want.
>=20
> > +
> > +	/* Update the clock source of the reference clock if the clock
> > +	 * name is specified in DTS node.
> > +	 */
> > +	if (!strcmp(clk_name, "system"))
>=20
> strncmp();
>=20
> "..." maybe longer than len of clc_name.
>=20
> > +		priv->clk_select =3D NETC_TMR_SYSTEM_CLK;
> > +	else if (!strcmp(clk_name, "ccm_timer"))
> > +		priv->clk_select =3D NETC_TMR_CCM_TIMER1;
> > +	else if (!strcmp(clk_name, "ext_1588"))
> > +		priv->clk_select =3D NETC_TMR_EXT_OSC;
> > +	else
> > +		return -EINVAL;
> > +
> > +	priv->src_clk =3D devm_clk_get(dev, clk_name);
> > +	if (IS_ERR(priv->src_clk)) {
> > +		dev_err(dev, "Failed to get reference clock source\n");
> > +		return PTR_ERR(priv->src_clk);
> > +	}
> > +
> > +	priv->clk_freq =3D clk_get_rate(priv->src_clk);
> > +	priv->period =3D div_u64(ns << 32, priv->clk_freq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int netc_timer_parse_dt(struct netc_timer *priv)
> > +{
> > +	return netc_timer_get_reference_clk_source(priv);
> > +}
> > +
> > +static irqreturn_t netc_timer_isr(int irq, void *data)
> > +{
> > +	struct netc_timer *priv =3D data;
> > +	u32 tmr_event, tmr_emask;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	tmr_event =3D netc_timer_rd(priv, NETC_TMR_TEVENT);
> > +	tmr_emask =3D netc_timer_rd(priv, NETC_TMR_TEMASK);
> > +
> > +	tmr_event &=3D tmr_emask;
> > +	if (tmr_event & TMR_TEVENT_ALM1EN)
> > +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> > +
> > +	if (tmr_event & TMR_TEVENT_ALM2EN)
> > +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
> > +
> > +	/* Clear interrupts status */
> > +	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
>=20
> clean irq status should be just after read it (before "tmr_event &=3D tmr=
_emask;)
>=20

we only need to clear the status bits of enabled irqs (tmr_event &=3D tmr_e=
mask),
Interrupts not enabled by tmr_emask will not generate interrupt. I can move
the clear irq status after " tmr_event &=3D tmr_emask;"

> otherwise the new irq maybe missed by netc_timer_alarm_write()


>=20
> > +
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int netc_timer_init_msix_irq(struct netc_timer *priv)
> > +{
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
> > +	if (err) {
> > +		dev_err(&pdev->dev, "request_irq() failed\n");
> > +		pci_free_irq_vectors(pdev);
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void netc_timer_free_msix_irq(struct netc_timer *priv)
> > +{
> > +	struct pci_dev *pdev =3D priv->pdev;
> > +
> > +	disable_irq(priv->irq);
> > +	free_irq(priv->irq, priv);
> > +	pci_free_irq_vectors(pdev);
> > +}
> > +
> > +static int netc_timer_probe(struct pci_dev *pdev,
> > +			    const struct pci_device_id *id)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct netc_timer *priv;
> > +	int err;
> > +
> > +	err =3D netc_timer_pci_probe(pdev);
> > +	if (err)
> > +		return err;
> > +
> > +	priv =3D pci_get_drvdata(pdev);
> > +	err =3D netc_timer_parse_dt(priv);
> > +	if (err) {
> > +		dev_err(dev, "Failed to parse DT node\n");
> > +		goto timer_pci_remove;
> > +	}
> > +
> > +	priv->caps =3D netc_timer_ptp_caps;
> > +	priv->oclk_prsc =3D NETC_TMR_DEFAULT_PRSC;
> > +	priv->phc_index =3D -1; /* initialize it as an invalid index */
> > +	spin_lock_init(&priv->lock);
> > +
> > +	err =3D clk_prepare_enable(priv->src_clk);
>=20
> use devm_ function
>=20
> > +	if (err) {
> > +		dev_err(dev, "Failed to enable timer source clock\n");
> > +		goto timer_pci_remove;
> > +	}
> > +
> > +	err =3D netc_timer_init_msix_irq(priv);
> > +	if (err)
> > +		goto disable_clk;
> > +
> > +	netc_timer_init(priv);
> > +	priv->clock =3D ptp_clock_register(&priv->caps, dev);
> > +	if (IS_ERR(priv->clock)) {
> > +		err =3D PTR_ERR(priv->clock);
> > +		goto free_msix_irq;
> > +	}
> > +
> > +	priv->phc_index =3D ptp_clock_index(priv->clock);
> > +
> > +	return 0;
> > +
> > +free_msix_irq:
> > +	netc_timer_free_msix_irq(priv);
> > +disable_clk:
> > +	clk_disable_unprepare(priv->src_clk);
> > +timer_pci_remove:
> > +	netc_timer_pci_remove(pdev);
>=20
> devm_add_action_or_reset() to simpify goto and netc_timer_remove().
>=20
> > +
> > +	return err;
> > +}
> > +
> > +static void netc_timer_remove(struct pci_dev *pdev)
> > +{
> > +	struct netc_timer *priv =3D pci_get_drvdata(pdev);
> > +
> > +	ptp_clock_unregister(priv->clock);
> > +	netc_timer_free_msix_irq(priv);
> > +	clk_disable_unprepare(priv->src_clk);
> > +	netc_timer_pci_remove(pdev);
> > +}
> > +
> > +static const struct pci_device_id netc_timer_id_table[] =3D {
> > +	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR, NETC_TMR_PCI_DEVID) },
> > +	{ 0, } /* End of table. */
>=20
> just { }
>=20
> needn't /* End of table. */
>=20
> Frank
> > +};
> > +MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
> > +
> > +static struct pci_driver netc_timer_driver =3D {
> > +	.name =3D KBUILD_MODNAME,
> > +	.id_table =3D netc_timer_id_table,
> > +	.probe =3D netc_timer_probe,
> > +	.remove =3D netc_timer_remove,
> > +};
> > +module_pci_driver(netc_timer_driver);
> > +
> > +MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
> > +MODULE_LICENSE("Dual BSD/GPL");
> > diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_g=
lobal.h
> > index fdecca8c90f0..59c835e67ada 100644
> > --- a/include/linux/fsl/netc_global.h
> > +++ b/include/linux/fsl/netc_global.h
> > @@ -1,10 +1,11 @@
> >  /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> > -/* Copyright 2024 NXP
> > +/* Copyright 2024-2025 NXP
> >   */
> >  #ifndef __NETC_GLOBAL_H
> >  #define __NETC_GLOBAL_H
> >
> >  #include <linux/io.h>
> > +#include <linux/pci.h>
> >
> >  static inline u32 netc_read(void __iomem *reg)
> >  {
> > @@ -16,4 +17,13 @@ static inline void netc_write(void __iomem *reg, u32
> val)
> >  	iowrite32(val, reg);
> >  }
> >
> > +#if IS_ENABLED(CONFIG_PTP_1588_CLOCK_NETC)
> > +int netc_timer_get_phc_index(struct pci_dev *timer_pdev);
> > +#else
> > +static inline int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
> > +{
> > +	return -ENODEV;
> > +}
> > +#endif
> > +
> >  #endif
> > --
> > 2.34.1
> >

