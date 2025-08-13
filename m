Return-Path: <netdev+bounces-213162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81892B23E1F
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 04:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7DB3BE9A9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE8E1A5B9D;
	Wed, 13 Aug 2025 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rw3jUJfO"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B029CC148;
	Wed, 13 Aug 2025 02:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755051472; cv=fail; b=I/dayYK+qQP30fqDNE6evU0Ob1ZOaFjOrdasl58NuzAC3+Lwdh+9beNiDIkGyFm7VpGvlKofCPboeE75emaN4chkUXIajJqTAnggOo5tKkIxCmQf2/vIz/MCcJ5NVJ6MPtpC7OO/NnbLVAHc72KyQ955GR5sa7jsiNSCzeLxCgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755051472; c=relaxed/simple;
	bh=kOxnix1WqLQ7gtKQwc2IjGzKABpf34gf/LQPQPgZZ9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fpMAUeQSln8dNhMhqOUbdJ9zsBcWri16upC6TLCTgvvp7jf/Bfz5O9PGgV2iAawk0QT8meFGzkb749Y9zkAqU0mOnCPt+bTFyfuFbNK6i68JzC/4dhE9ptT2DeHURPdeDn4EU0Jd9nNgKyn3yUxFnt2CkRhIzMKRfwxyMP0B75c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rw3jUJfO; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSxtovumNDPYboxrvflhSLmt+kQhATZ0MQVKhedQK1FFhK5hJFAh+HpgDqwKl4Vf8uS/1UnHd1TBxzOdU91DeLDAPKCcRq7RgoIFiUNLE51EOdukVo49Qjj+wuROF9oLSSCNRHL7A9H9CRYltYgcf5idwPf8Txrsf0T9tVYtWBssHagVrYlcsQlJxDynQHuWsx3N2hmz+8kQ+qjpfcWHTJTC23VuosjFpRb8/RjZdWKFfBlAzquxa0bM4sTsuGCrWEHfOssB+eu8uEWlJb7ulpzZuGhRO5E2MaHT3q3HV1vhcDim0tDYc2CHfVwdFsTQKQR67DWnuHOPYcr0IcnlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/EBctttZPQGBF73q3QGiOKpNlQfvpF1GZKNKJqgWzA=;
 b=Ib+dDEbkO7lNwFaNbPa71cH9RtcpgiV2eGqvPvPhqVMW6Lh+9czarowQcO0IW2kqVnxfpjFHH/HpCq+mz+8MLhrVSqX32wSWHcwuBiIQpxi8t+eWloAueQYcY7jk3UlBaSxmP6zEXaBL3RCoz7rlpQoi5tr7B2qFJ+mJtj/q39xlLZyu4i2mxwYwEcYlkeFHUwgNXi6/+wdtK1uMH/i3HO3kDrJOKP54P5vZ/JnBAYjVIFrPHPihAbz02wqUhFhSnRxm5gqiqVZgZGynXxxJJVb3dIvsRD6pMIson17s75VqbzK7xU1OU6vcwiy2uNKX/QjLdrTD0d7Oy+AyMFcp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/EBctttZPQGBF73q3QGiOKpNlQfvpF1GZKNKJqgWzA=;
 b=Rw3jUJfOyiOa4B+UEgdIqih7nVMTFI+GI+nG4TPHAUoYcJGy4pJaqXz5Da6j8a9OBZ+SIDki9kRSGnCGOkF3b9BSvj2U9Xtuw4GBacxnowzZUaApHMb49bAensSB4eXzgvYbiTzRxT4GqmJ1Xg6T9AZN3ZYlQVNwSHYWEs3e7IIT8QYCWaH+vEJwdbzp3gxIsGNsPl0yGn9KLGuC6mEgM5XeHfnhumMOwvhL13lZsMv1m3ZVabt8krQVLde+k8aivxb4ivpGTqCttLUv60nr/4fuPMJyFh8XuNSkJV1bvgCDz9XnKMd92jDOqtlUMbYDcv+zIfIp35RI4f1Qp9Wd8A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7980.eurprd04.prod.outlook.com (2603:10a6:10:1f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 02:17:46 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 02:17:46 +0000
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
Subject: RE: [PATCH v3 net-next 13/15] net: enetc: add PTP synchronization
 support for ENETC v4
Thread-Topic: [PATCH v3 net-next 13/15] net: enetc: add PTP synchronization
 support for ENETC v4
Thread-Index: AQHcC3EMte/viuW9jUOvTdhFvxWwhrRfLQAAgACphMA=
Date: Wed, 13 Aug 2025 02:17:46 +0000
Message-ID:
 <PAXPR04MB85104E9C3BFAAD7FC566AF7F882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-14-wei.fang@nxp.com>
 <aJtkpFbFTnmO1rbz@lizhi-Precision-Tower-5810>
In-Reply-To: <aJtkpFbFTnmO1rbz@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBBPR04MB7980:EE_
x-ms-office365-filtering-correlation-id: 82da0b69-f001-4c90-bc27-08ddda0f97da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fHeddagLhC4t9m679vy10+wnY6CMHburuRFguOuOmu1UKSydknDWIzSkI/vA?=
 =?us-ascii?Q?2fz/lUVAcuk19CbxgS9W9x296k/qio0S9jeiIsfnqYJVlSFUAl91hWmHvMIz?=
 =?us-ascii?Q?Uq20K3rFr52HvG+dQcoggIG2q5H2hiyvfm1jVzYFrH/Nbj8GnPcawXwiQwhO?=
 =?us-ascii?Q?LCXtaQCU9JE9HM5nW9vJZYEWw5Jy0PNDOriTYMtdjR0l071AdfINglGBMXgX?=
 =?us-ascii?Q?nvUrVe5/nAhNwM60l/AlbuYCEYKr73BBgQaZytpCx0XFQJAJegSA4yk9hoAt?=
 =?us-ascii?Q?NGjadYR7dFB6Av2vOi1/A4sGeIOXzUFsd0gkDvoB2Tg7gJkcY3U6FmaG3PZi?=
 =?us-ascii?Q?/6f7gZhPnpgo9sc8K64hIOWYJ7alYvvkJYZgFcT5uArgtZmsHSMK1mWHFxpP?=
 =?us-ascii?Q?uciAUg/tuFhff2Axm76pwtfWoQ/+lXReg2PTFqse/uBhuWW3tRxpCw/cUzCD?=
 =?us-ascii?Q?WKheir6JbP5R2J7R7dv2iJj5u69Bfca8CZcgmhn3/XCp2KsvjZQtvG5Sq3Xd?=
 =?us-ascii?Q?yOoNPCK3S9eQOR2vE5LOxqIZNMsoAf2uVptcdGLBgDEjQkhUwd4kho4S+Kba?=
 =?us-ascii?Q?0qjYiigyIiTdSnx550r71ighCVA2Tg9xRQZBSXfu01vWmXGchoQeBxxZewCB?=
 =?us-ascii?Q?QdSxUHCvR6i46d0Am89plJwq1GClLUu0O2nXp15eRNobqkoadFjWFo2VnWIf?=
 =?us-ascii?Q?A+kT5B6EaCJmcQgCalkpTY8hp0vj1t/EjdMrCNXS/IXQACENwBYFKAohY4X2?=
 =?us-ascii?Q?FOlEs2xDYBwWeDl6YqYPBc4ogVKbFWubKNTDhWzSUUXBLqp8hU/Nw/xLzyV4?=
 =?us-ascii?Q?WZy8f8/r/vkJjihkecwI3A/Y7bLsVrx/1psxkaNFmr+itU1ASwBe9RfjNqtz?=
 =?us-ascii?Q?33wtrnLTlJ/S4q7uy2QoiQi/QLNhQqVricfhoECiIdVxae/Gfv2IXe0oUwwz?=
 =?us-ascii?Q?fFCxj3hbeWWbdGrG4kbTowfYmeeK9YNMLV3WXDcUN4r5c1IQCu/yIITSQp+w?=
 =?us-ascii?Q?hS6C23IsFMVu6AwOrdkmS/OppXFP6kLV3Apb6KoPkCpoi8e6zYq1KvkrtagN?=
 =?us-ascii?Q?Ep2uCwRqjdzEXk+u2pjY97jnVQboGkIGvhmQ7QUiGDxupDsRNQsa1KJPbttj?=
 =?us-ascii?Q?1f9HO/2LB74i3IFu38uugrxRhztMqFMZHlvZFGJ9j8Wz1ksEARXTX0es2Z8i?=
 =?us-ascii?Q?o0UhRE4O4YgU0rm7LPxffPvMeu5pueJTmKPMyfI1i+e1GIYfXlbbfzOs/uut?=
 =?us-ascii?Q?eA5ozEmRR7yZyLiOaQYvZw596PfYyngD1MyzW/fO2ZD5Yr6kfZm5UHVtJYc8?=
 =?us-ascii?Q?50JMdyYJghqCFcF32uOKcQ3V7IzDNlhslJ7fWNhwjF7p0XOG+v/SdM+ZfvkF?=
 =?us-ascii?Q?RXpxjT2LDk0npfX0kaOaNcBm/lPYyJoKWU3cl8/hkmmnNzeYfW7KgFStqY2b?=
 =?us-ascii?Q?CC7ckY5+4lDpjt8f9MwWdWdnXyS8REgrFOJGmy/05IM46B6ihYnx7A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kwWFjIGevDqMeP5vvSSK4IVPh1Rh9GMXE1E0kEFjCCi4GCKJLzUO2sbah+qf?=
 =?us-ascii?Q?2nYysa7kut5facSKGqmjohhz+w44qoKClIg9xfGbwWAh3g6poCAykR7BZKsK?=
 =?us-ascii?Q?h5Us67HlyHaWKkafnfoBp/gyHMD//Oma1svaIsh082DNtXnDua7va+5KiDyz?=
 =?us-ascii?Q?pBGrgLk0QE9ub+n9YPdr/riUguEzIipSd/HOovGpBgrblUJyIGgvBn8DJ25r?=
 =?us-ascii?Q?gRvH6WNkIZebm0BhIBS6qQo21G7qkSNiRc14HQ5PfDzBxItldvYmL8pdcpXD?=
 =?us-ascii?Q?rLScUfNDrGWYg9EUn+ZtkPd53KXyN/5+aueK52vkoabQFKd61bmlYM72lLCC?=
 =?us-ascii?Q?SZtUxil1Vn0bjprL3K/VcqRSW5uiVeVAtkxCmIDiNmaKnTdSTm9iPwoJqwWK?=
 =?us-ascii?Q?536pNt9C5llOLX4VkzjQWbEtI5ZmEaHPM3td2q7I6ovRAts67OZX2yHflsg6?=
 =?us-ascii?Q?Lqrb35bhDMVtLjatRiV1YDN4edoCYxcZi3O3gnksAT7x6IvbuuX3QOsZ/R5f?=
 =?us-ascii?Q?7vgHzMT0hbKpRdOY4ek4VbgIOUnW2TXPfC3b2Limyk+RUxxRRxKoBo3ZjAbf?=
 =?us-ascii?Q?ztk6TJwdpVfr4DXskPyyDC69HdVCSKA06ZC2WILgJj2c/8Zp9jGMUzYN/ijx?=
 =?us-ascii?Q?Ty3S+JVeV//BU14fxWwMjCdj76quZY4BWUTwufoV0vEnT5qHmPHB/tJji/rX?=
 =?us-ascii?Q?NCUFluD2uTx+O64PFAMWiXBaV1Su4IwtpeFaUU8sXmY5vnEJv5SSnKK2zP1c?=
 =?us-ascii?Q?qq2ruXiOcfjeXUQaNeUTy71galrdWoVsBDMIU+LO0jMotWIKKMyBwHMWNaIF?=
 =?us-ascii?Q?0Yjq6L0v2TOyCKVJwftRsawtBpGNBtYQzgvDqL1pn+41tA2v9EcxaS2u+WKZ?=
 =?us-ascii?Q?/FNXQUmgJXoyZX/kqUZYEtazmKIOWbCO/V3W5mU9/QitwGugkzRUf02Mu6dF?=
 =?us-ascii?Q?TdZWolL/WjB2buGF/JYupCnAN6IDS6hsSzKzE58GJd3rPottc63U9Z4Ynjn1?=
 =?us-ascii?Q?wclEcx69/HY+GDroqlfQ+44jE7oN/UDGnbcAufYKQM/V91vWOzVGUH/jo5sp?=
 =?us-ascii?Q?sico0y6KgvoFdoVGNq+xoyX8suyqSRr5t0TPYjuujYei26HOmD3TjhlNx7ib?=
 =?us-ascii?Q?cEQR/iEa4F/MoZ6mwFcMdi3iaXLPhrNFUHuPwYCUp2eVzZothuSLLna4RcsL?=
 =?us-ascii?Q?+pIah9up4CQl2LJ+yxApZPFPsuMkySGRwAm+TEjAi2FpbXCHu3MXI4uxklRV?=
 =?us-ascii?Q?nGWLHeUANrMvolYNOVzIbDmF4axcb5VRFlYTyShsTZpixMr48/noQZB4YVY+?=
 =?us-ascii?Q?WYhgjIf7nXiCieqRAbNZsA89mYKvGWX8BSnsnqTLLGdGBGvm9Cujx8Tqltml?=
 =?us-ascii?Q?/O/qrwIrXOOBo5I6CkhUJi7pl3qE6qoQeznZhjoXx8MFEvs8NR5lvmi0or1T?=
 =?us-ascii?Q?VU1myPnQW/whQ8WGc6j8rc8pK6ryFWUgeco6s0SY7r76QXSTHtJB6NtzLlZZ?=
 =?us-ascii?Q?4/X1Fmag6UCUwuWI/IGZMHSxtWBhHVERPAAi7NXZnleS93xAvUtgiX+ANbP7?=
 =?us-ascii?Q?TR3jwk4R55j8W3ey3LM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82da0b69-f001-4c90-bc27-08ddda0f97da
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 02:17:46.3376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpR7eB1G4W2hjoxNEZvaDeP6ZK5GibWLJQDbsyNQKV8DMMr9fYF6Gb1RAUpzNXoQ6enUdhTgqNE/AMvryHCmGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7980

> On Tue, Aug 12, 2025 at 05:46:32PM +0800, Wei Fang wrote:
> > Regarding PTP, ENETC v4 has some changes compared to ENETC v1 (LS1028A)=
,
> > mainly as follows.
> >
> > 1. ENETC v4 uses a different PTP driver, so the way to get phc_index is
> > different from LS1028A. Therefore, enetc_get_ts_info() has been modifie=
d
> > appropriately to be compatible with ENETC v1 and v4.
> >
> > 2. The hardware of ENETC v4 does not support "dma-coherent", therefore,
> > to support PTP one-step, the PTP sync packets must be modified before
> > calling dma_map_single() to map the DMA cache of the packets. Otherwise=
,
> > the modification is invalid, the originTimestamp and correction fields
> > of the sent packets will still be the values before the modification.
>=20
> In patch, I have not find dma_map_single(), is it in enetc_map_tx_buffs()=
?
>=20

Yes, see below code snippet.

static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *sk=
b)
{
	[...]
	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
		do_onestep_tstamp =3D true;
		tstamp =3D enetc_update_ptp_sync_msg(priv, skb, csum_offload);
	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
		do_twostep_tstamp =3D true;
	}

	i =3D tx_ring->next_to_use;
	txbd =3D ENETC_TXBD(*tx_ring, i);
	prefetchw(txbd);

	dma =3D dma_map_single(tx_ring->dev, skb->data, len, DMA_TO_DEVICE);
	if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
		goto dma_err;

	temp_bd.addr =3D cpu_to_le64(dma);
	temp_bd.buf_len =3D cpu_to_le16(len);
	[...]
}

> This move should be fix, even dma-coherent, it also should be before
> dma_map_single().  just hardware dma-coherent hidden the problem.
>=20

There are no visible issues with enetc v1, if it is considered a fix, it is=
 only
a logical fix and have no effect on v1 . So this patch is fine to target to
net-next tree.

> >
> > 3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
> > register offset, but also some register fields. Therefore, two helper
> > functions are added, enetc_set_one_step_ts() for ENETC v1 and
> > enetc4_set_one_step_ts() for ENETC v4.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> > ---
> > v2 changes:
> > 1. Move the definition of enetc_ptp_clock_is_enabled() to resolve build
> > errors.
> > 2. Add parsing of "nxp,netc-timer" property to get PCIe device of NETC
> > Timer.
> > v3 changes:
> > 1. Change CONFIG_PTP_1588_CLOCK_NETC to CONFIG_PTP_NETC_V4_TIMER
> > 2. Change "nxp,netc-timer" to "ptp-timer"
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c  | 55 +++++++----
> >  drivers/net/ethernet/freescale/enetc/enetc.h  |  8 ++
> >  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  6 ++
> >  .../net/ethernet/freescale/enetc/enetc4_pf.c  |  3 +
> >  .../ethernet/freescale/enetc/enetc_ethtool.c  | 92 ++++++++++++++++---
> >  5 files changed, 135 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 4325eb3d9481..6dbc9cc811a0 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -221,6 +221,31 @@ static void enetc_unwind_tx_frame(struct
> enetc_bdr *tx_ring, int count, int i)
> >  	}
> >  }
> >
> > +static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, int o=
ffset)
> > +{
> > +	u32 val =3D ENETC_PM0_SINGLE_STEP_EN;
> > +
> > +	val |=3D ENETC_SET_SINGLE_STEP_OFFSET(offset);
> > +	if (udp)
> > +		val |=3D ENETC_PM0_SINGLE_STEP_CH;
> > +
> > +	/* The "Correction" field of a packet is updated based on the
> > +	 * current time and the timestamp provided
> > +	 */
> > +	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val);
> > +}
> > +
> > +static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int =
offset)
> > +{
> > +	u32 val =3D PM_SINGLE_STEP_EN;
> > +
> > +	val |=3D PM_SINGLE_STEP_OFFSET_SET(offset);
> > +	if (udp)
> > +		val |=3D PM_SINGLE_STEP_CH;
> > +
> > +	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val);
> > +}
> > +
> >  static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> >  				     struct sk_buff *skb)
> >  {
> > @@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct
> enetc_ndev_priv *priv,
> >  	u32 lo, hi, nsec;
> >  	u8 *data;
> >  	u64 sec;
> > -	u32 val;
> >
> >  	lo =3D enetc_rd_hot(hw, ENETC_SICTR0);
> >  	hi =3D enetc_rd_hot(hw, ENETC_SICTR1);
> > @@ -279,12 +303,10 @@ static u32 enetc_update_ptp_sync_msg(struct
> enetc_ndev_priv *priv,
> >  	*(__be32 *)(data + tstamp_off + 6) =3D new_nsec;
> >
> >  	/* Configure single-step register */
> > -	val =3D ENETC_PM0_SINGLE_STEP_EN;
> > -	val |=3D ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> > -	if (enetc_cb->udp)
> > -		val |=3D ENETC_PM0_SINGLE_STEP_CH;
> > -
> > -	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> > +	if (is_enetc_rev1(si))
> > +		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
> > +	else
> > +		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
> >
> >  	return lo & ENETC_TXBD_TSTAMP;
> >  }
> > @@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  	unsigned int f;
> >  	dma_addr_t dma;
> >  	u8 flags =3D 0;
> > +	u32 tstamp;
> >
> >  	enetc_clear_tx_bd(&temp_bd);
> >  	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > @@ -327,6 +350,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  		}
> >  	}
> >
> > +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> > +		do_onestep_tstamp =3D true;
> > +		tstamp =3D enetc_update_ptp_sync_msg(priv, skb);
> > +	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
> > +		do_twostep_tstamp =3D true;
> > +	}
> > +
> >  	i =3D tx_ring->next_to_use;
> >  	txbd =3D ENETC_TXBD(*tx_ring, i);
> >  	prefetchw(txbd);
> > @@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  	count++;
> >
> >  	do_vlan =3D skb_vlan_tag_present(skb);
> > -	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> > -		do_onestep_tstamp =3D true;
> > -	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
> > -		do_twostep_tstamp =3D true;
> > -
> >  	tx_swbd->do_twostep_tstamp =3D do_twostep_tstamp;
> >  	tx_swbd->qbv_en =3D !!(priv->active_offloads & ENETC_F_QBV);
> >  	tx_swbd->check_wb =3D tx_swbd->do_twostep_tstamp || tx_swbd->qbv_en;
> > @@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  		}
> >
> >  		if (do_onestep_tstamp) {
> > -			u32 tstamp =3D enetc_update_ptp_sync_msg(priv, skb);
> > -
> >  			/* Configure extension BD */
> >  			temp_bd.ext.tstamp =3D cpu_to_le32(tstamp);
> >  			e_flags |=3D ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
> > @@ -3314,7 +3337,7 @@ int enetc_hwtstamp_set(struct net_device *ndev,
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >  	int err, new_offloads =3D priv->active_offloads;
> >
> > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> > +	if (!enetc_ptp_clock_is_enabled(priv->si))
> >  		return -EOPNOTSUPP;
> >
> >  	switch (config->tx_type) {
> > @@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device *ndev,
> >  {
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >
> > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> > +	if (!enetc_ptp_clock_is_enabled(priv->si))
> >  		return -EOPNOTSUPP;
> >
> >  	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> b/drivers/net/ethernet/freescale/enetc/enetc.h
> > index c65aa7b88122..815afdc2ec23 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > @@ -598,6 +598,14 @@ static inline void enetc_cbd_free_data_mem(struct
> enetc_si *si, int size,
> >  void enetc_reset_ptcmsdur(struct enetc_hw *hw);
> >  void enetc_set_ptcmsdur(struct enetc_hw *hw, u32 *queue_max_sdu);
> >
> > +static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)
> > +{
> > +	if (is_enetc_rev1(si))
> > +		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
> > +
> > +	return IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER);
> > +}
> > +
> >  #ifdef CONFIG_FSL_ENETC_QOS
> >  int enetc_qos_query_caps(struct net_device *ndev, void *type_data);
> >  int enetc_setup_tc_taprio(struct net_device *ndev, void *type_data);
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > index aa25b445d301..a8113c9057eb 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > @@ -171,6 +171,12 @@
> >  /* Port MAC 0/1 Pause Quanta Threshold Register */
> >  #define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
> >
> > +#define ENETC4_PM_SINGLE_STEP(mac)	(0x50c0 + (mac) * 0x400)
> > +#define  PM_SINGLE_STEP_CH		BIT(6)
> > +#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
> > +#define   PM_SINGLE_STEP_OFFSET_SET(o)
> FIELD_PREP(PM_SINGLE_STEP_OFFSET, o)
> > +#define  PM_SINGLE_STEP_EN		BIT(31)
> > +
> >  /* Port MAC 0 Interface Mode Control Register */
> >  #define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
> >  #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > index b3dc1afeefd1..107f59169e67 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > @@ -569,6 +569,9 @@ static const struct net_device_ops enetc4_ndev_ops
> =3D {
> >  	.ndo_set_features	=3D enetc4_pf_set_features,
> >  	.ndo_vlan_rx_add_vid	=3D enetc_vlan_rx_add_vid,
> >  	.ndo_vlan_rx_kill_vid	=3D enetc_vlan_rx_del_vid,
> > +	.ndo_eth_ioctl		=3D enetc_ioctl,
> > +	.ndo_hwtstamp_get	=3D enetc_hwtstamp_get,
> > +	.ndo_hwtstamp_set	=3D enetc_hwtstamp_set,
> >  };
> >
> >  static struct phylink_pcs *
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > index 961e76cd8489..b6014b1069de 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > @@ -2,8 +2,11 @@
> >  /* Copyright 2017-2019 NXP */
> >
> >  #include <linux/ethtool_netlink.h>
> > +#include <linux/fsl/netc_global.h>
> >  #include <linux/net_tstamp.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> > +
> >  #include "enetc.h"
> >
> >  static const u32 enetc_si_regs[] =3D {
> > @@ -877,23 +880,49 @@ static int enetc_set_coalesce(struct net_device
> *ndev,
> >  	return 0;
> >  }
> >
> > -static int enetc_get_ts_info(struct net_device *ndev,
> > -			     struct kernel_ethtool_ts_info *info)
> > +static struct pci_dev *enetc4_get_default_timer_pdev(struct enetc_si *=
si)
> >  {
> > -	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > -	int *phc_idx;
> > -
> > -	phc_idx =3D symbol_get(enetc_phc_index);
> > -	if (phc_idx) {
> > -		info->phc_index =3D *phc_idx;
> > -		symbol_put(enetc_phc_index);
> > +	struct pci_bus *bus =3D si->pdev->bus;
> > +	int domain =3D pci_domain_nr(bus);
> > +	int bus_num =3D bus->number;
> > +	int devfn;
> > +
> > +	switch (si->revision) {
> > +	case ENETC_REV_4_1:
> > +		devfn =3D PCI_DEVFN(24, 0);
> > +		break;
> > +	default:
> > +		return NULL;
> >  	}
> >
> > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
> > -		info->so_timestamping =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> > +	return pci_dev_get(pci_get_domain_bus_and_slot(domain, bus_num,
> devfn));
> > +}
> >
> > -		return 0;
> > -	}
> > +static struct pci_dev *enetc4_get_timer_pdev(struct enetc_si *si)
> > +{
> > +	struct device_node *np =3D si->pdev->dev.of_node;
> > +	struct fwnode_handle *timer_fwnode;
> > +	struct device_node *timer_np;
> > +
> > +	if (!np)
> > +		return enetc4_get_default_timer_pdev(si);
> > +
> > +	timer_np =3D of_parse_phandle(np, "ptp-timer", 0);
> > +	if (!timer_np)
> > +		return enetc4_get_default_timer_pdev(si);
> > +
> > +	timer_fwnode =3D of_fwnode_handle(timer_np);
> > +	of_node_put(timer_np);
> > +	if (!timer_fwnode)
> > +		return NULL;
> > +
> > +	return pci_dev_get(to_pci_dev(timer_fwnode->dev));
> > +}
> > +
> > +static void enetc_get_ts_generic_info(struct net_device *ndev,
> > +				      struct kernel_ethtool_ts_info *info)
> > +{
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> >
> >  	info->so_timestamping =3D SOF_TIMESTAMPING_TX_HARDWARE |
> >  				SOF_TIMESTAMPING_RX_HARDWARE |
> > @@ -908,6 +937,42 @@ static int enetc_get_ts_info(struct net_device *nd=
ev,
> >
> >  	info->rx_filters =3D (1 << HWTSTAMP_FILTER_NONE) |
> >  			   (1 << HWTSTAMP_FILTER_ALL);
> > +}
> > +
> > +static int enetc_get_ts_info(struct net_device *ndev,
> > +			     struct kernel_ethtool_ts_info *info)
> > +{
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > +	struct enetc_si *si =3D priv->si;
> > +	struct pci_dev *timer_pdev;
> > +	int *phc_idx;
> > +
> > +	if (!enetc_ptp_clock_is_enabled(si))
> > +		goto timestamp_tx_sw;
> > +
> > +	if (is_enetc_rev1(si)) {
> > +		phc_idx =3D symbol_get(enetc_phc_index);
> > +		if (phc_idx) {
> > +			info->phc_index =3D *phc_idx;
> > +			symbol_put(enetc_phc_index);
> > +		}
> > +	} else {
> > +		timer_pdev =3D enetc4_get_timer_pdev(si);
> > +		if (!timer_pdev)
> > +			goto timestamp_tx_sw;
> > +
> > +		info->phc_index =3D netc_timer_get_phc_index(timer_pdev);
> > +		pci_dev_put(timer_pdev);
> > +		if (info->phc_index < 0)
> > +			goto timestamp_tx_sw;
> > +	}
> > +
> > +	enetc_get_ts_generic_info(ndev, info);
> > +
> > +	return 0;
> > +
> > +timestamp_tx_sw:
> > +	info->so_timestamping =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> >
> >  	return 0;
> >  }
> > @@ -1296,6 +1361,7 @@ const struct ethtool_ops enetc4_pf_ethtool_ops =
=3D {
> >  	.get_rxfh =3D enetc_get_rxfh,
> >  	.set_rxfh =3D enetc_set_rxfh,
> >  	.get_rxfh_fields =3D enetc_get_rxfh_fields,
> > +	.get_ts_info =3D enetc_get_ts_info,
> >  };
> >
> >  void enetc_set_ethtool_ops(struct net_device *ndev)
> > --
> > 2.34.1
> >

