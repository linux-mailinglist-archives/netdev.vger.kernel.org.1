Return-Path: <netdev+bounces-140379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D239B6437
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C2B1C20E27
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3711EB9F6;
	Wed, 30 Oct 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q14eZd7K"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE171EB9E3;
	Wed, 30 Oct 2024 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295253; cv=fail; b=pdVRCjZpHD+ogg3p5cNO5PNmXOI3bP9wOKbD3pDFOYa7QoLkZX0iWNRqacPs2863+LkdSOb/o1Kz7ndmo0VZ/RRuS0hfpKtXFaHWc1MhMKHjF2tKD6fkM4hnzsbMa7GrnXelJSiuzXoHVyCEJJAt77rJXb6MxyAsVOmHLJOX0zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295253; c=relaxed/simple;
	bh=KQtMz2pY+M7BZGiNYhwpIlcAECxswCRKyEDhY4yUU5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TlsUIyfm5ImS1/mTOtnnc0UEHNtt/9+IddAUenQZZUZL0E0L+oJ7gMkAgVYA3VH2NtFVu6kjmz0ybK6cx3ryjFp1FzfKOPqhf9h7zbO4k6oZ7UbEd3D5KwnhDorBLXqnGb2bQ1R++o3z3i2HMP+qm1J1WQqaRnMJIG03kHf0FjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=q14eZd7K; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wChiyd34kcKKoGDRmgKDxrGqcYIfS9CD1XVzA8vPitI2rvGyFFY/b0dgOFlg3N/KAIPJdePwO9ukkOexQI9Mv6fP9B50hzxwuWl+x6hlm2z4m6MSPasRMjX6+1SuinTiIYrx6CP1qiixTlpmoibvGCwcrf9pqAdEISLn0duPw9b8K7Rrf83GPNFM4YzbKrMxsOWzwXrTFVw3GB4+lwLt6KLlhXbD51VW53OBfMAjK/wPXLxlTgYDYKPAdnu2zWpX1bxu3kPTrcpHal0J+FlrgBfPdUfAZkOItt/H5etsJQ3Miih1uc5b+g6ZyNCasC8MvRenl+VzeE/BTS8UNMAIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLDpA0ePaKEkMnyQAEM9AXgIX6ys6pBISYzlVP6v0Wc=;
 b=JhPCBDM7lD33gAuoagN56RmTmWFhYD5ykrnQiRr61gSHoT1cJmPgZCNVwBcKa5mUJiwNCOdThWHKNJAFiXf7jM2tBrgGakLSk0DrulNOD1l9D+cOyeG/cvCwZIcAm8EojphhnUamhGDytPVvVi/ixNo1xkut7TKyZxqXIX4R3Rgylz0NeDUyt2jq4MY8OfQoKQ5uGfkeLJf1USv0/OEyhwMmo70k3Sw0YhSzhacQpqnqCuH7xCmaz8vrfbUoD5B9ySVt8jMbHiVICKRLgm3rVSTCh0uV1AfhwhdajurmNOlym+be0fvhZMoFePtP2BV9e9NIknqx9Oo9DPTx6wK8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLDpA0ePaKEkMnyQAEM9AXgIX6ys6pBISYzlVP6v0Wc=;
 b=q14eZd7KyPT8wMIc5OmPPnYDQFtxJDdNv0mcmb/j3TsCmFc/BUBTn3Xf77ewvtkES9pMNyq93/x8DU7pHa1BgxrZaM49G6OZL5D4zFMM4Ms02YKjxQb7qncUrHoo/7Dl91nDSCmnlwqjwMmxOTNfd4cVorO3l8KFZnAFSFsuhsjRDcAnllk8Qmw+JmJGWUs3eC9sovT+pl6TzjGRVujIvCteVG8rbX+RULmjRrmfCWfpHihYsVDOJZQbWtzECqHWQPLy9Nqe5ZqGCr4nfoWb/MsXTMpQL2Rjw1Is+JpkY7AufI9CxGPbWt6RrTyzQ6xz/7hSD/cU+9zSQxVcBlbErA==
Received: from DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22)
 by PA2PR04MB10088.eurprd04.prod.outlook.com (2603:10a6:102:40e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 13:34:04 +0000
Received: from DB9PR04MB8185.eurprd04.prod.outlook.com
 ([fe80::7cbd:347b:1bfd:fb35]) by DB9PR04MB8185.eurprd04.prod.outlook.com
 ([fe80::7cbd:347b:1bfd:fb35%5]) with mapi id 15.20.8093.025; Wed, 30 Oct 2024
 13:34:04 +0000
From: "Madalin Bucur (OSS)" <madalin.bucur@oss.nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Radu-Andrei Bulie <radu-andrei.bulie@nxp.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Breno Leitao <leitao@debian.org>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Sean
 Anderson <sean.anderson@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH net] net: dpaa_eth: print FD status in CPU endianness in
 dpaa_eth_fd tracepoint
Thread-Topic: [PATCH net] net: dpaa_eth: print FD status in CPU endianness in
 dpaa_eth_fd tracepoint
Thread-Index: AQHbKiACIOYFGw8GfUul9ckDno7PtbKfTBxA
Date: Wed, 30 Oct 2024 13:34:04 +0000
Message-ID:
 <DB9PR04MB8185A67AF6393BD2992818DFEC542@DB9PR04MB8185.eurprd04.prod.outlook.com>
References: <20241029163105.44135-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241029163105.44135-1-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8185:EE_|PA2PR04MB10088:EE_
x-ms-office365-filtering-correlation-id: 189141c2-3667-462b-0e77-08dcf8e78592
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HXs2j8gsCPGDzrBOpDzc5fKbTSgoGea+7kwGy8+I6SogkgQYfl97WrxMmguR?=
 =?us-ascii?Q?HTsnOVDrmNoUNo5/Kf7XFU0lzGLKoX9sHKrKFEwvMPlS9NRuvI64fL5PpFGF?=
 =?us-ascii?Q?ziojuFryV77IGtFAwv9A1OqBgfKlC0BO/WbyUy7Z2/AEGtiLgnzT1FcxAX/7?=
 =?us-ascii?Q?l55JX28CfUUdI+ULKJ5obVw4XgUe3Vl8mh2PJGvqHeN1QAIpTapR77nAEjZc?=
 =?us-ascii?Q?VVunYl07sXSkjEJiCaBejiYmR2DkHodsx6By7+lMP9M4u7YyGl8chqvrzf63?=
 =?us-ascii?Q?5ValCXGgG0jtzLz0dORz+b01qIMa3+Zohgbes0pab0sa46TcxsRzxcRFLrrn?=
 =?us-ascii?Q?uzwGxZk16K84wso5YgtDqGjYEkRzXIfo5wwWQFV2FsYynCOzUN17RB3K4jIO?=
 =?us-ascii?Q?yJ1hsNaXDwFtdVMt7scm55MOUp9O9fxb6faQExm0slr/JoNI5a+BAlm0rPvT?=
 =?us-ascii?Q?iFKZsHnb4Gu4KLz9oQll9bvIEeIkamZwcwo9PN/fBgzYb+deUBaunufD7Xzt?=
 =?us-ascii?Q?QKSWpS8yvRyexFVmlecMdi0lCxokHj5SQjuceUmjAeNHkstjDNmdQTPsJZtm?=
 =?us-ascii?Q?VUxoCuFWMS2LH1CzdIgh3UBLRvvKXXQZK37tUYT1wsCaS/eiLjZKnLQyaE2s?=
 =?us-ascii?Q?N9JrnjVyKbdKY8TzuUDKxylAhGuQGW4dRGSB98JZB7s5yhApiBS3obxzt8KD?=
 =?us-ascii?Q?wTA+TnBratLvwsFmcopTETqXOIrZ9SCZG0tLJx4BljAOJtwLi+QwmzR2vbLn?=
 =?us-ascii?Q?3WJ77uNjKCmkraT0QOHTTOXaIJgSRpq7hSa9Lh7lb6Q7x0kcoC6B7JDMgTX3?=
 =?us-ascii?Q?S57JVwUftPQdRiOtj5Nx9TibtWqmsx83LvLEG3s8PKAPYPmhWuxTVQjQzwrq?=
 =?us-ascii?Q?jQGmWHCHQzE/AELTGLJtY5/2D5oFFG6QAe4zQJBHdgyTWGpYIlgxotdWHc8K?=
 =?us-ascii?Q?Ntjp2TNB4IAc8ajvUEffuxo1/vyTaDso7hPKTHjGTb+1V/UBbfGGLh10IWkF?=
 =?us-ascii?Q?07NTErTwTInQMnrRSOgwsoYaAbwDYgtJdMO7djYDETc80t9/qUwWz9Qlrz1r?=
 =?us-ascii?Q?OreQ4g632orhfoal5azMsD67ZhWRkaKTZjXHvJqtZXp6jIV1c40z/JV26FGX?=
 =?us-ascii?Q?C+04ctxtordaIy5sjRLX0p3FaadVYe8syQC/5Tevm8oESug4ymxHzqSudHMN?=
 =?us-ascii?Q?O4/7Uu1ZMIj/w7zXdSMjCm++o9aEPWZrATkIgJeYsP9OFBlfNvqDPGHcFY4i?=
 =?us-ascii?Q?sHDeaRW6HvAvH/0/fPPNvTss+MV4/oCqqnOyf+k0ZURGdz3F2ifdn/06i39Q?=
 =?us-ascii?Q?F9W3L1LMnAHV9sEsNrP/3UDj+tXBMu+8Wjln6vbu/6DVlBnCmVmUv9hf5tPP?=
 =?us-ascii?Q?btWcio2FNTSDQh0+sUyGW9I7RSeV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?koWfCS87svAYmVDFnNW1csaVDZj5q0/cfKnfRsK85sepRUDx7hRwc6Pof2mp?=
 =?us-ascii?Q?6wHVdDfFJr6ASn959eBP8X3rRckz0vppzHXzEVjxIEfbNS8U9OUppYQNJRuU?=
 =?us-ascii?Q?jmo5grb6PhzzrR96rtvCXFCEMkoeaUnuXaKJIiNOo9J/KfJh0HCRKPvBBejH?=
 =?us-ascii?Q?zKhJPchnLLuCGrXJF8DExcerSb9YB15WkCao/WwDpPpZLXxvyNtf5BY+pBvs?=
 =?us-ascii?Q?lXg5hrIruZlxzaWvTyXD80AXLkeB72SijL8NPd/7nB+fTKH303//Q8nx6aI7?=
 =?us-ascii?Q?ZpLklqodwBmocEU+ngD0xWBGB/qAAjzZYBRRKZD5xloTMZxI2tVs9pMtHrQP?=
 =?us-ascii?Q?qdc8Y++aauCxuUt08GDKcVJZOfruDAMbopG2VJZrtEiCt/BmIUF0pJVZkwzI?=
 =?us-ascii?Q?ocwVi9ixT47gif6uQQbfcCCcY9YfVqt3JyqJx0bnihZHlM7vOq5xPOMCuzlO?=
 =?us-ascii?Q?kbrXBhFpEKOhwwmORcr/8PhRTWoIpW/YejcwFql+i2YJLNvJCyPdrBHqzb5E?=
 =?us-ascii?Q?WXyO1JxG0JW9cHdBBsk/ZVU2XLmO4pQID/d+Oh4Ot9T+O/RNOjtuhJ6sRlP4?=
 =?us-ascii?Q?VRu6uiSexK0268g934Olp+zFdpByI0Nv8+/IPfydN4RLJ99s5NynJPUd3ciM?=
 =?us-ascii?Q?4TReSSOf9639i63S3CHtlHB+sfDvW/BtJJG5B6qeUUPoqfPp8y/R1oGVuQg1?=
 =?us-ascii?Q?QIBxPQh7qTb6MAGW8vPw8k2YhgLEHLaOfv7PwvhHypdI66mM3Fmde+IQfRpa?=
 =?us-ascii?Q?u8BX5O8X/FG0rqACdqKeuSiOCYg89G0zD0YoXCV2xxsevFZzjSJxohn6ke4Q?=
 =?us-ascii?Q?Rk9/tyiX6ddEwuzntN/l3um/km+mvv1wu+jKlLS+MGwF7QwqVXi8/UZzRZlZ?=
 =?us-ascii?Q?U3ECRql4eiNmX4ZhkCtO9YOVRsF0nX6KGuU5hyBCzrCdP/549u+SrguMsDMF?=
 =?us-ascii?Q?MknVojcf4QrbAZezKoXGslLbwK9FXLwF3vgFWAQ89Txw84K/cGsU6xb/vR0e?=
 =?us-ascii?Q?iCbgY84mnWMSCZ5yzK+Hy6gkT3nD/rdChncnWI/jMlSRrmZqyuGHGM/ZR3kn?=
 =?us-ascii?Q?DvA4/DK+qxRMciRNzTBhEsG4m2RAbBpeJrZV4h0y172uWPKhU5SwHGuN+SlA?=
 =?us-ascii?Q?j+eQ727g2+5ELQzjKr0ID4DSchyknSsaafNwgqWwSt77t5koJvRHkOEpkVAt?=
 =?us-ascii?Q?dc3/+q99vdSWZ4zKqpaBo62bjq0hKQryPf8tm8pViqu4fkj+MfN7Kdl7N3hm?=
 =?us-ascii?Q?8fD92ixEkFYToCano5oCNqG0+UMdO2dElFSFKGBpVtbpe6IfQ8EmPSuu4qnq?=
 =?us-ascii?Q?VAuyzg467r5oYQxTynQGRPI9PzfiMyEHqYnilrU72DLgLnZQlNCX4PaRSPfK?=
 =?us-ascii?Q?3w4ziLtj7ToRpcUbXcgybUJd1zEFGx43hwNvJfPrXLLblrKyFd0MWpzFw++T?=
 =?us-ascii?Q?UwB/bsf/e1IGkKQ7u/q6X13Z+Uq6/AJFccMUHZGD3DfOiT9171L3bS6NP9Mq?=
 =?us-ascii?Q?JYRk/c3XTfgMLe12miVwPl4+VFQpAjDAZbaaCc5J4n4FfWNcFpYdpi8lOMg/?=
 =?us-ascii?Q?gDOHldWHmozOt/l07l50jP+8FSMyFktv1T3k7IHe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189141c2-3667-462b-0e77-08dcf8e78592
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 13:34:04.1663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCDCTQ3fDW+cSiYLq4ve+b07lcKXDolxQzW0vb+pA4Z4hfH2aN0Vrw5yqRx+zYR5yzexeS5HwCJ+yLkbKlj7TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10088

> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Tuesday, October 29, 2024 6:31 PM
> To: netdev@vger.kernel.org; Radu-Andrei Bulie <radu-andrei.bulie@nxp.com>
> Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Breno Leitao <leitao@debian.org>; Madalin Bucur
> <madalin.bucur@nxp.com>; Ioana Ciornei <ioana.ciornei@nxp.com>; Christoph=
e
> Leroy <christophe.leroy@csgroup.eu>; Sean Anderson
> <sean.anderson@linux.dev>; linux-kernel@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH net] net: dpaa_eth: print FD status in CPU endianness in
> dpaa_eth_fd tracepoint
>=20
> Sparse warns:
>=20
> note: in included file (through ../include/trace/trace_events.h,
> ../include/trace/define_trace.h,
> ../drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h):
> warning: incorrect type in assignment (different base types)
>    expected unsigned int [usertype] fd_status
>    got restricted __be32 const [usertype] status
>=20
> We take struct qm_fd :: status, store it and print it as an u32,
> though it is a big endian field. We should print the FD status in
> CPU endianness for ease of debug and consistency between PowerPC and
> Arm systems.
>=20
> Though it is a not often used debug feature, it is best to treat it as
> a bug and backport the format change to all supported stable kernels,
> for consistency.
>=20
> Fixes: eb11ddf36eb8 ("dpaa_eth: add trace points")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Context: https://lore.kernel.org/oe-kbuild-all/20241028-sticky-refined-li=
onfish-
> b06c0c@leitao/

Acked-by: Madalin Bucur <madalin.bucur@oss.nxp.com>

