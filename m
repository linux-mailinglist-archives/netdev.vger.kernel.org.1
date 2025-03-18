Return-Path: <netdev+bounces-175746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BC9A675C8
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E06B3ABE27
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0A20DD57;
	Tue, 18 Mar 2025 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DQKqDLMs"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E08F207DFD;
	Tue, 18 Mar 2025 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306414; cv=fail; b=CB/3ICTCK6d5TadJm/nXF57LEoguakcyReH2hob9USlIj8P5Qwnntyz1IhcdlnqKRYQklm1cjTq7lXOx8ihhNX6dbs99YHV3BdxHHeR5CQZuNbH+3delhhpT0Mj7n/1yAIqWOHllUfGObAHqNJ+ni6P/O9AEaHNACH5NjdPs3F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306414; c=relaxed/simple;
	bh=JGTCCEk6o8sJ/ykj2WS+tTUPuoDLeY6pXe6lxPF7g14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KrzR/dRnNzyP27KXjZ+OQOPDG89RA4xWXV1wLc/81o9zDREJNXBe4ypYwJGcUb08CtdI7aJ/Bncr744G9CCreM+c0hPhY8xdDFE41ailFvKHPGB8BkgPpAo2Tya4j3bJN0RYFnhPV49EWpWpwDaN5x5xE8WNTXl65a+gUG12jVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DQKqDLMs; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJO/aLag2tLwTaCzEst8l1B5YzVg8LG+0NNFlLxqTJ/L/9cbew7zUPB1tfLPm0qsez6vx/sh5EwrdA+Cy9EUBw3q0YLhHiPeT4B50pHzNDyclbc6bwyx8xi2hE01O4Y2bAxNkhRMCnyvT25cIxD/J3gqUKYgpP7OBh9PqBTRmjaUnCw0xXM359tDdi8XOvNBNuRA0pDqis41Vm9i48156jjDyCDtFQs+/6oiFLs9nEnA3hwVhADABYPA6r7RPvn1Qkq/P70cMfK+T5DTnRXUicRuDo99ZzXVUXPmHq7k3UVc1/+tAwYLsK0Mw25IwdFxS1xqcm39vzdhpj1zLHnfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MOyRM094spLavero/c0q7XinVeDU8tftLFiW+NL9ig=;
 b=URTYdqmV+gXibyj5Ex70FJ1CdZsr4XNotGR3yuac5sib09QIvij7Vha4jU3Nvmp7OUDx7hAp/+9XPgWSeSo2nOF9ta1vfW7eNWh7Pjk9HJUP6CsU90dtKcLkacd2QuEWNSoKD06mOI2nkgHx1rQcv53G4wnN7PNvYkFjr9fbzcAh1i2xSsXLB+MrMGPdJepWQ6mQpTkjFTVULpH8a2dkmjOOv1mG3eq7lcJMrMJR4xSgKQxJs+6+hCqOqOm6UyE0JI1v7AbxHOi9dlj8CEtkpuIVfhRbp7UypvpIgX8heoNiBhobK1wpt+8IoVcyaOsMWR6XkxtwA2BZvSv854EHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MOyRM094spLavero/c0q7XinVeDU8tftLFiW+NL9ig=;
 b=DQKqDLMsQBdwnH4dFyCFOhiiefU32MERqUnMu1RyaGMjycm6F2YE1nzU3XlN4fdBEdcL4E//VPCvQLm7BHyCK0oym8MiGK45dwRppT8bevkrQklZPMHNi41qjIt5iNMHm5dOhpXEUNkht5VGte0PTYmrAcjePH4cMGvxa9SNxMRSlGufVXrJTFCkeWJG/daYKrtgubOee9+zyyP93FBKSr41XC4V8z38y24wFY1Z2BKKp62zZWV1OXMKFM3M+1CeVhTg1GDamXw2ayVEeryN3wCf/liZzeZ5U3bsIuB4d9CFGYZ9bxIO2zOZdFTNhY8Xk6sAemBugH0fdJq9YYQcuw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:00:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 14:00:10 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 net-next 08/14] net: enetc: add RSS support for i.MX95
 ENETC PF
Thread-Topic: [PATCH v4 net-next 08/14] net: enetc: add RSS support for i.MX95
 ENETC PF
Thread-Index: AQHbkkpbosg+I5pSyEimx2zUNxYPxbN3hVPcgADCsDCAAIlIAIAAJYog
Date: Tue, 18 Mar 2025 14:00:09 +0000
Message-ID:
 <PAXPR04MB851099502FD17128BDC13A2A88DE2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-9-wei.fang@nxp.com>
 <20250311053830.1516523-9-wei.fang@nxp.com>
 <20250317155501.4haweyhlrfozg7zr@skbuf>
 <PAXPR04MB8510DE829523749E9FB5E20B88DE2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250318114316.2st2ylxuu7srloqc@skbuf>
In-Reply-To: <20250318114316.2st2ylxuu7srloqc@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM7PR04MB7013:EE_
x-ms-office365-filtering-correlation-id: cc3bff54-4e8b-4c53-7672-08dd6625324a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?f5pG9ijHb87/b9rICrPUnNzX1UlLsAVBuL9Abqz3eMhIXeUs/CmjgP4NhLD9?=
 =?us-ascii?Q?WU/3IqpGPSMsPRwKPfn0qI6I7JcOXhmttkQIYJzx/RMiCqXVPGJlWN562uLv?=
 =?us-ascii?Q?8BsSNbrNZqBB2vDftRVcsDWkbiWSRyPqZeiVo3QGYyF36NIycjoaxIMZtmUk?=
 =?us-ascii?Q?4AVeHqZYi4twwPDmtWuU31uzK3KpFWEOVBGIlNxHtVuVfJclhd+jebUoS30D?=
 =?us-ascii?Q?cuzT2/xALgmym2EMkxHJrtG3L57btOtoAIznSMy9twwJ3tzw838KGtBG0Tkj?=
 =?us-ascii?Q?2IuZjtx3zvOjkfbHoVHPgRQolWivcbrXFcWJZ0L4whVdento4gUkD8zlrmnd?=
 =?us-ascii?Q?sXmlgVb8IRzCCZP5QqpJXySn+4LPEDybO/cVRLwK4CVJxhxiYenNW7oavATV?=
 =?us-ascii?Q?LmZLTxKKdBchX8dwgh8/22R0ZJn7a2wVSxEP5GONXmFOtBi6QjPSmf8orzpx?=
 =?us-ascii?Q?GlV7At3XF8a4i477ybDRpCyZkXiugleEABXYRK94kCpIUakuBrMMNKyO587t?=
 =?us-ascii?Q?DtUFbwRCmf3IYRGQBPbLzu+a/rMR9PaYBwjQJ/Eca/2zOaWbl2Q9n39+wWZt?=
 =?us-ascii?Q?4g8+Yeu+J81tp5T+/PCh8q4zma0CS9HYtbIA03nBtAWepV9dytvtJGbCmfme?=
 =?us-ascii?Q?hxPt9bh05j7zJ2W6q0iiaVEdbDNRR0QX8tm/ES7m3hzW2vFPm0N/+9g6MToQ?=
 =?us-ascii?Q?hl7vswixH7Ie1cUeWK05FF40w6RPmGAPdyyvD0mZ1j4di/Efxrb3KvVHbOH2?=
 =?us-ascii?Q?lmznzbECz/0YoJUNRBUA0lILT8/Tfgk/nvq2VC/YYoMj+Jn10oYq+/kWFHQV?=
 =?us-ascii?Q?bnj7hmvYmMjiAfZurchh+Vj/rsOhhLACOBKf4ObcTTjSLZB31EM7I54bDTW3?=
 =?us-ascii?Q?NLCzESfgoKNmv00fbrijSQAPr5OnlIS0iY/VPscrzsutV6CinW/uXyrAXmqF?=
 =?us-ascii?Q?I1Ud2DGtlXdXz/oB1Zo4wIYbwnOlXmz3wGZfBqRyh3Gexy2WnucjYFyWXQlZ?=
 =?us-ascii?Q?kkAciPGNNefpecYDjSa6z/RRFYi5zENs+xrtmac78UrQuPcyb8iEKqQlHOjJ?=
 =?us-ascii?Q?G8HHCv6Zndrpc6wVrCOFkqywKCPC/MLzYisYZ+VPmLKgncOtmHOsAAKYTd5r?=
 =?us-ascii?Q?FBTanSVdDFli1Qa00o8VFbnrmXGRrkiLadjIZmVw/ldV9osMVSWXlXW9qUlD?=
 =?us-ascii?Q?LjWImWEzeefN8zqOlWFrKRNjc4pY5so+Y89eOgF1H/4KsEqoANcdDVU+2Zgr?=
 =?us-ascii?Q?l+hbqK0o4XY/ifQMbMDDDjlehFWeoZQ9APb/mclCY4ZoTVA/oX66fTBccOlD?=
 =?us-ascii?Q?UUkFELw9L/U9FTVrU5Nmds8fMdtRPraslbUSpKiH6eOgWZmRAgWgCPDJqOPM?=
 =?us-ascii?Q?R3DZMtGRXmqilu9zTLQgc6fXG4xIzpA+ys8oWJv+fGKpdo3iQQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?of8fFSEQDOleTg/etxADAAYcawIaxXNz1/y6/sktZXnEKpjLeuXZ5lI2hnQE?=
 =?us-ascii?Q?kTNe4fXzhgFauJ8TmuIPe4zxQbGyf5F2tMxMJ116zK1ZIB3o47FhCdHBJxMk?=
 =?us-ascii?Q?hcaMIU23J9Mfno0Z0aNMD1vkt7PVGpXf7WUvDr3cPohGeqC1hLzu3CppU1aq?=
 =?us-ascii?Q?Xpv1E6TX7l/ld5LcaXslV76fjcfM17Om88nHHPbFb+Rx0GuHfSpGLrQpFF5X?=
 =?us-ascii?Q?4IzBkBB8KUgF5jUhjJRRwcmlgJWhWYbc9m6PsjkoEMoDbNVSgCQN5LBlJ3S4?=
 =?us-ascii?Q?Yh4zef6oi9QemUEoPZSGrCrqFInFNjYyQWfTmc/gNdvgKx0wEgc4BP8XRCqT?=
 =?us-ascii?Q?AItIMCAAxrhrOyUeW5vmEyECZxWipc5/SnJ+6iHEzPIQiCJsh9Gb3ix4zZsd?=
 =?us-ascii?Q?Bn45duoGOVDVjPfCz9x9SfkvIW3/SPJNC68czOYoAKk7w4rWJJ4bukMeULgO?=
 =?us-ascii?Q?bh6a0+7SkJz667le7gTCZNSSvwBaXMm/zUleSjy31D3tSVrimotPq9vxwUAj?=
 =?us-ascii?Q?ubAnHF0U4yMzLk5mOVKeDgQaHM8RbGdojw3PtRdG69XCjPTS/unj9lt7OdGQ?=
 =?us-ascii?Q?TZXLl/26vd/rdNchwyTFeieJqmrykyCqBVycsflNeMGUJnZmjESeqhb6YBAN?=
 =?us-ascii?Q?XZdF9Q7EXPXOJ5dPtaugDxkd6yup7FcNa38nkgxWpcX2tB1i8YUvO0IWEAzh?=
 =?us-ascii?Q?ElGRQSVqtdfjeteQY+2fSo5pIuiCTt4/QgHapNdMB67iSwHahyidC+UEgHNI?=
 =?us-ascii?Q?VootSIh6q3u74lW9uf+O+uQvEA7j1e4wBdPs/uOr2xir2xGdGOCT8d4Bf/oo?=
 =?us-ascii?Q?P5P97wGB0TseDBneAMSE8/pJwklmQFbuKxkwd7XIu5iUaK8qpE1uzETOvq6j?=
 =?us-ascii?Q?CU6JMEV4O47gNRx8ViWgZKQWzfQ6t8r2cQeLMHaJm1Gw/OzqruSycYyJ5510?=
 =?us-ascii?Q?qmqrakY4SgqUXvFRuhopS3Npsc7tJMf2RplxwlyagvHG3wwJkBSEfhUjmFol?=
 =?us-ascii?Q?xY8Czu5rEtdZUi6d+inrnwSrPU7HAG1km2cf4sWahpjrgcWYhTPHBr1eWv0L?=
 =?us-ascii?Q?nEFRfO88O0jDBLJewo9qiLqjyco+3ht01r9YLiDj/Wz6RAJLR30597LKTvcy?=
 =?us-ascii?Q?oy+jmgVhQ2CP8WC/bxqk/AtVOUB4xVpZbIQwNzsPB/88kv+B9i0vfAArtqPb?=
 =?us-ascii?Q?Pfrv7F8mcd1/DxkUPWkGsud54hougQh1enjkTxDIgiUw7VMrLPWAFY0rfHnb?=
 =?us-ascii?Q?f8HNDiOoU4M4uRW+NyoNcXIQUCbWkUAXr8S6yv1LLsYR/hPjHKVWNMfnrflo?=
 =?us-ascii?Q?qkM8AYIVr3XnCvnf6ZBfrQasbvtT+aU0fmQQZcxw88U77aPJdxDqb33Svidu?=
 =?us-ascii?Q?XXh5crn+hRaq8UOYTRdU53W3T55+Q9xPnrkVbqxfE0vpb1Tn3Pg5EV2HT4fU?=
 =?us-ascii?Q?N4czCaRdaT9yA2+8W8qJzPE1flukoyLxqWCQMmQh91wwYWCSgIdrUP8+0Fbg?=
 =?us-ascii?Q?wx1AzWG7Innuhcdeyt91wle99TDV+ADW3i9ORaKBrr/LtjoaC0SRhM87ONkd?=
 =?us-ascii?Q?YXIse+qYw3OjNTrdA4A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3bff54-4e8b-4c53-7672-08dd6625324a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 14:00:09.9942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EaXmolRocSchaT3ZHzcXbCbi0kYPkYqFSmYlUS2toxjZdnaZglP2nKngY6KtSMsxgE1j+oVUqFm6ICKdqtarIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013

> On Tue, Mar 18, 2025 at 06:47:11AM +0200, Wei Fang wrote:
> > > These rxnfc commands seem implemented identically to the correspondin=
g
> > > subset from enetc_get_rxnfc(). Rather than duplicating those, could y=
ou
> > > rather return -EOPNOTSUPP for the unsupported ones on NETC v4, and
> reuse
> > > enetc_get_rxnfc()?
> > >
> >
> > I have explained it to Jakub in v2:
> >
> https://lore.kernel.org/imx/PAXPR04MB8510B52B7D27640C557680B4881A2
> @PAXPR04MB8510.eurprd04.prod.outlook.com/
> >
> > So I don't want to reuse it for ENETC v4 PF.
>=20
> A detail of the review process, written in
> Documentation/process/6.Followthrough.rst,
> is that "Andrew Morton has suggested that every review comment which does
> not result in a code change should result in an additional code comment
> instead; that can help future reviewers avoid the questions which came
> up the first time around."
>=20
> [ personal mention: it doesn't have to be a code comment but can also be
>   a sentence in the commit message ]
>=20
> I believe that it would be good if you could apply that suggestion for
> future submissions (not only for this particular comment).

Okay, good to know this info, I will add a comments here.


