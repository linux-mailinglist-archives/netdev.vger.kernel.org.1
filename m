Return-Path: <netdev+bounces-144639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36B99C800D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93593282D40
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003E4157A48;
	Thu, 14 Nov 2024 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kUnQP4E9"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B02746B;
	Thu, 14 Nov 2024 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548163; cv=fail; b=ssQSWLxxkOnAqv/q43yXc6YPtkHEg/E7lVHNkPyfesuh3cHxGZ/DQjQ6kT1KE1xSOmGpWACcPD4seVrCPjJF2JwGCqwna5JY/KoD4sCsXnt63h/mR0AZME/8lOlz9uINlCDmZihi5sU92A3aPy6UqjuSPuG9Gb8/dPaygeSMTq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548163; c=relaxed/simple;
	bh=0GOWvLLNbNP7jNK7WfOaskouc4GdiAc6PAahrEBp/q8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GIm0Q+g6aeIKHUHPncC8pGPLVoFXy2Y8X0WicJAZGzvwdmJyOIPcXyWEjGunwP2y0sg8KCMm2PNLYSuPfjEsJYoCeqcvpXGlHwYrxoZ4SyD02cA+I5NQcom4zxCX4UvCnA4wb3i+vu/FUYYs4Qdzesq3xUbLkS5Cj0PaYvdhusU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kUnQP4E9; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyJwhSGHXcP1Y1kMeBcgJCzFZjKzfunWJzIFjLpYn/ZlAjY9M/d9nA9AuS+auzkFmIGB0BpOk74GJ8BIFuvO4AYGJ7dEzHGhvH6pzaSkGxmN8znzAzyVa8pafzMCKxNIf93/M+oYkIjevl1u34tARoC/AiLbCiiAxdtOKFtx2lPRLByD2Y8SVUjJxyAa+1t2RG2O21OljYytw9PQmAzUxJvQpicM29NcB89J7PM0NDeH5kpBo1JQVsRHran5TeRN9r6ckAU/AuSVfjqtGfC6U9DAjZIchqIePAknE5APlHTbMLBErWcLTDkpgTsLSRh3zeDDtbBE9prY0wXYhqzgRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1s3KBKFqyyLeSjfYPEbIxrrmzLC1Ad/xBI94I3bEMY=;
 b=etx1a49eOHamI4cY6h/GHCNXJMM6QoOfe5PlOt2LRXYeJ+P5zTEaPdSbrA87Cf6RYZlo6JKFUzVDA5CNP0sHcUyuXh+sHP4O28dGDwHfaJ3r2353p4Rq+35DoUK7qNfzO6TzYc8655BuHmBQADx+LKYeJoKrDSstlg27pNae1wQXFGTE0gzIplZrlx3/iJwCUReUT8w76M88mNorXU+wdhC4yxV8ThM051Xeqt7qrk3FIwNne9w0tkp/gxrea41d3ySI7yIjde5yxkXPtN7qKPz0QPd7oUoDmT6gtMHxV7Samy7RSQ/g3y5hKPDyRJ4fZPVWcHQL4Ur0VmOPF1pl5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1s3KBKFqyyLeSjfYPEbIxrrmzLC1Ad/xBI94I3bEMY=;
 b=kUnQP4E9+LgDx6RFESgoLMGl/y+D85LesCqzLY1n1gNuohNkM7C/L7Xn7rT+v+iMhc9IZy2oJDd32wq07up9DlKzZ0D6+4NjCjx5Nm+t493YdF/QWgtqQYhbAESWDA14ie1hrty/ELQkvmPRATza8MiH3K2nM9X8CxTOEOtCKqdeHxRlgoSZSlDMgh4xwpDt1VrHFRfDNPYa/10BDYSND7EcfMvvWzWJmlQO6T7jN7zwTMJ59vkmyW0W5ZrqhMo1PWB0CAQljP9p1h5kxTOCqMCHfVXlwefSXsNY2OPff8PGna+T1ixA4r1sK8IcPBbhqOIf4VBX6nxI77HvxTHkhA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9795.eurprd04.prod.outlook.com (2603:10a6:10:4e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 01:35:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 01:35:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 net-next 4/5] net: enetc: add LSO support for i.MX95
 ENETC PF
Thread-Topic: [PATCH v3 net-next 4/5] net: enetc: add LSO support for i.MX95
 ENETC PF
Thread-Index: AQHbNOWFs11cXDZG6EWoMBCVoLZnrrK1SdCAgACzorA=
Date: Thu, 14 Nov 2024 01:35:56 +0000
Message-ID:
 <PAXPR04MB8510772A96D35CA8A6392D91885B2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
 <20241112091447.1850899-5-wei.fang@nxp.com>
 <4vfvfzegrk774qlo5fobie5qcleqxqaogphucpzlwlcnq3llqd@aspdtwwqbobn>
In-Reply-To: <4vfvfzegrk774qlo5fobie5qcleqxqaogphucpzlwlcnq3llqd@aspdtwwqbobn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DUZPR04MB9795:EE_
x-ms-office365-filtering-correlation-id: 7449ec82-81b2-497a-249a-08dd044cafb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C+qjAWjNxoGtLixOI2tAHMeeThHnPR8G2j6/VuDLXu4DIGH8HhZ/cIe1CQDs?=
 =?us-ascii?Q?2MJ+7e2czR0ehCnySqZjGNJNaWRGXR71uBKJO67xrJIWr2xXaHINgZDs5IJZ?=
 =?us-ascii?Q?GIAcTRkIUCoM34pcz8I/u8bywTTaFRBlDXuFGRjDMksETpVMk4+3YWDk0pTW?=
 =?us-ascii?Q?4H0/0gq5nDPMG+kgt0E0mQYRCfDikjbfF/VgzrjSTVS8nDp/BpPjcJufhiWd?=
 =?us-ascii?Q?zQbl/BXR+09IvjN7iBXiDYSxvIJgfmX4ywfJA7Bc+CL7V46Fq8qCXfKW7NB3?=
 =?us-ascii?Q?FkHVglN8zAt/ScU8zBygUSjs7XofvvjBgfJSx5lUfjhZhLY6xSOTHxEd6ZTw?=
 =?us-ascii?Q?5P3s4+j0+yHhlY9xBqcnxFgzHS4eM8qt3lGzAVKRxiVjFOjvrkcYFdQmcpA6?=
 =?us-ascii?Q?gxxFbyNUvLJV8tjFhfMwdj5Ud4Z2ksB4ws7wkP/lx7rva8KihDR4TIK0OWny?=
 =?us-ascii?Q?4nCp81UujdYUBNv+h5lIy2u/9/ux6gClX90EoEEIzXM7Z53tbkGA1QYSH5+x?=
 =?us-ascii?Q?1eIw9PyJ7XQtxET8QepXCxpgh4kEKb1hhH+T0L4/Fpf8MiPBx7bGc14uWsJb?=
 =?us-ascii?Q?TC3CUQ/npulqk9x1DBZ0tdS8pdvZFMKmUJ88WYfDMMTfjFfum5xBfX+yUw37?=
 =?us-ascii?Q?0JdTzliSFYdnwC5CnyueR+ebSzShpEZvPFhM+Dw9KLhK88aJtC8UBIl9GTfo?=
 =?us-ascii?Q?pWd2YPhillrToRToC6n+6CetVfQQg/IxCFxGzMmoBDb5UF55H00sFIBcKbWR?=
 =?us-ascii?Q?4jbeaPYG8Agjj79SqqUunKOT6TRQNYdHNkZcz49OmHj5kgJ+kpcdpgr58XlY?=
 =?us-ascii?Q?Aq7WC90+mZHhMFhwA5V6BOmwvX/E7y6rqVA6/fEIL4ioaoRtVi01LmZ/bnC9?=
 =?us-ascii?Q?GgjpcZxSZMEdiZJwk97Jsy1ZKnE2yAfH5MV9+FSHCmDTX7kaw+LfbJVxr/Xt?=
 =?us-ascii?Q?G+C8ZNm5kQDmKlhz/JZQOsF9Du7YXFRz+JCEIBfUuTp1tJeFQK2MN+Rejmi6?=
 =?us-ascii?Q?vx0wWd+1rMTahSHEd+bqxgRDuKWAxbnmhKK3CS5p7dN1l5W+bNMQDHYHNtoI?=
 =?us-ascii?Q?w9fKCco2MouHyhwBrZBoqJ3B6UWUkDPcrnaiMjSnMd97MAbH2TMlrw7o71cq?=
 =?us-ascii?Q?6oAhWlzn9kE1hebNXbUl709+GEhqKMIcqB/QDC8xKqaQv3CIEzFVyqNplRWi?=
 =?us-ascii?Q?XLKvvgvGDq5dGu+ohMsoRHH7aWr0A1monskEpsOdQ1+nGGd8KFXK0dK1wzYv?=
 =?us-ascii?Q?Y3gfvZm5jAIb7FuNqP5w/+n21243pZ4mN6deE5TISDC70Ng3cnoZwJNA/FTZ?=
 =?us-ascii?Q?Q138S7nW4l6tSW+I/yd+rRRdMxISUvd/tuQcM8JoZX9yqb/dsHxvg9lFGvTl?=
 =?us-ascii?Q?L3laZ44=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vt0vkqESxHOETIuDitkmgTuU3YFEwagUOX+1mCcI0Qnbm1IrOiDQpjSXCpDq?=
 =?us-ascii?Q?HWsWYWDT4aPOK/OxgvzmKpg3hvdhyHYD6jO3UTNq2JvRUQ6qoJJ6btG+VuQu?=
 =?us-ascii?Q?ooGBamzZhwCQVJUrffj7X3PshYkXpGzCYXraPsq5H88wK0z64wLZeJtjE4P2?=
 =?us-ascii?Q?Qt9/xmvAvqZnugK7FSOTRXLZUedDojJSICdLOJBLYYvsIscDme8Z+wW3ePgO?=
 =?us-ascii?Q?rNksVaWZWEEV6mYcLw3JdeD/2sOh87y/WCMRIAzqqBFywtoiD3qLrwPATwit?=
 =?us-ascii?Q?DE5HMEdwFe4oLJtEtqVB5tIDLWsbyqTxlvYovnBe+/xtlqMFR91eDHvZJr9M?=
 =?us-ascii?Q?vtkQWGRJUkeQ+al/coAg5VOBvCu0dUTVM9vpk1L/r51AmZEuoYvEfq+BU3i6?=
 =?us-ascii?Q?sVIzSagy4UJFUMDu/PflWK+/EjSM/3u+qlBlovfVBaoyYmevmR9hZIap6MdL?=
 =?us-ascii?Q?pSNwkxZdUmNI0K61NXrAmDvFuLsKcgUKsYXejOON/vhrtHFfnJdOs3JljecA?=
 =?us-ascii?Q?JJCxVpTzOUSA/bnpKllnpv1c1inMeROcYSkiajBqFkxCYZvM7Smk3ZQEBRYp?=
 =?us-ascii?Q?3ojg7XvGDWGnI+Jqs6Fw0xkdOFawsGrt2hrOz/kINX9zgVaHirw0Fc7t3cvF?=
 =?us-ascii?Q?3ko/YDnrlQcVjzT+FEJ4bJmNoCPPDft6RiGtq/5BhYLPXHg7Qw32IsDwGzQ4?=
 =?us-ascii?Q?RJJe6e/CfBd5ynNITYJBXgeivxm9qiJ161H06CcXJQQb0LJfklnxXphDRRdA?=
 =?us-ascii?Q?1JlTHcI/l15z6Jrq8F9nKtE9CYO1NAZftaycNUXA+Jh7LvFYyFsiit/+8PgS?=
 =?us-ascii?Q?xbtNWfMCs5KFIn+O7JbU2Rc98srZM3ttUNopYDDvesHwrGh2LSzn7ZIe/x27?=
 =?us-ascii?Q?mp+lshTkp++eYvMGpea66DzvPTsG5c8ypbcaJbEfLZL7k7F9HctrxqeFN7RO?=
 =?us-ascii?Q?ueGijppnI3WRJ5x7o7O53jExwxu1pPP+hO8EbWwfnL1rEi6vE8n4xUUHK6JI?=
 =?us-ascii?Q?lCY514FqzS4ZtyPJSV03w29jFUytJRCHs2xmZoMdnXTXbuSXSknxrzhz6gvI?=
 =?us-ascii?Q?I2nFYcSGW/8wwwKe93jJbGJl7zKKrwmRY2eY+J5hNYIgx7C+UN/oy3kj5cgu?=
 =?us-ascii?Q?NGMQUop3bc+z1Xfg29ljacurk/kldbQCZdjOjkHi11dd20LY6stOgBpEatHn?=
 =?us-ascii?Q?8rCtpKbBUrSXaepkgCH+CTQiMy1sb5G4mVDFT6zoAFU3fJ4HpmgV1qLx6WgC?=
 =?us-ascii?Q?RkzUSMKt+0QxW8mwbG8BKr2aPz73+8F6PIuGCYnRU2RmW3FkwbfSKkTbt+WP?=
 =?us-ascii?Q?2OGMgEefuDhXpoOQZT/H7Q/yd6oPTKOBipSsWGw87L/s1s3Kr3Y8Axt6osNb?=
 =?us-ascii?Q?vcZSN4zBYLgZ9oItBwbxv/BnVlLerDKSs9Md7EtM2KgUXQgBK3AIpmfJEHRT?=
 =?us-ascii?Q?KGrDFgnIiAlHgSAg7ipH7957SxRkvYfZ488YOjaJ+5YCwk3JhlC1QsYU77Eh?=
 =?us-ascii?Q?mCug6vpe6SajOKs+QZODPFCyPwW2iTiNoLnb++2fVV9shHhuCwPlNvsD3trD?=
 =?us-ascii?Q?yJIS15ucEVY9FurO420=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7449ec82-81b2-497a-249a-08dd044cafb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 01:35:56.7795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBMy3lYSpoqtgDiRama4FMhye0hOORZDHxD60Vi+x6iYcrfFwg3346KvxNlx/wJqrqferFpXzTMfrvTRtH2p+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9795

> On Tue, Nov 12, 2024 at 05:14:46PM +0800, Wei Fang wrote:
> > ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
> > and UDP transmit units into multiple Ethernet frames. To support LSO,
> > software needs to fill some auxiliary information in Tx BD, such as
> > LSO header length, frame length, LSO maximum segment size, etc.
> >
> > At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
> > CPU performance before and after applying the patch was compared
> > through the top command. It can be seen that LSO saves a significant
> > amount of CPU cycles compared to software TSO.
> >
> > Before applying the patch:
> > %Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si
> >
> > After applying the patch:
> > %Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > v2: no changes
> > v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c  | 266
> > +++++++++++++++++-  drivers/net/ethernet/freescale/enetc/enetc.h  |
> > 15 +  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
> >  .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 +-
> >  .../freescale/enetc/enetc_pf_common.c         |   3 +
> >  5 files changed, 311 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 7c6b844c2e96..91428bb99f6d 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -527,6 +527,233 @@ static void enetc_tso_complete_csum(struct
> enetc_bdr *tx_ring, struct tso_t *tso
> >  	}
> >  }
> >
> > +static inline int enetc_lso_count_descs(const struct sk_buff *skb) {
> > +	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
> > +	 * for linear area data but not include LSO header, namely
> > +	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
> > +	 */
> > +	return skb_shinfo(skb)->nr_frags + 4; }
>=20
> Why not move this static inline herper into the header?
>=20

enetc_lso_count_descs() is only referenced in enetc.c, IMO, there is
no need to move it to enetc.h or or other header files.

> > +
> > +static int enetc_lso_get_hdr_len(const struct sk_buff *skb) {
> > +	int hdr_len, tlen;
> > +
> > +	tlen =3D skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr=
);
> > +	hdr_len =3D skb_transport_offset(skb) + tlen;
> > +
> > +	return hdr_len;
> > +}
> > +
> > +static void enetc_lso_start(struct sk_buff *skb, struct enetc_lso_t
> > +*lso) {
> > +	lso->lso_seg_size =3D skb_shinfo(skb)->gso_size;
> > +	lso->ipv6 =3D enetc_skb_is_ipv6(skb);
> > +	lso->tcp =3D skb_is_gso_tcp(skb);
> > +	lso->l3_hdr_len =3D skb_network_header_len(skb);
> > +	lso->l3_start =3D skb_network_offset(skb);
> > +	lso->hdr_len =3D enetc_lso_get_hdr_len(skb);
> > +	lso->total_len =3D skb->len - lso->hdr_len; }
> > +
> > +static void enetc_lso_map_hdr(struct enetc_bdr *tx_ring, struct sk_buf=
f
> *skb,
> > +			      int *i, struct enetc_lso_t *lso) {
> > +	union enetc_tx_bd txbd_tmp, *txbd;
> > +	struct enetc_tx_swbd *tx_swbd;
> > +	u16 frm_len, frm_len_ext;
> > +	u8 flags, e_flags =3D 0;
> > +	dma_addr_t addr;
> > +	char *hdr;
> > +
> > +	/* Get the fisrt BD of the LSO BDs chain */
>=20
> s/fisrt/first/

Thanks, I I was not aware of this typo, I will correct it.

