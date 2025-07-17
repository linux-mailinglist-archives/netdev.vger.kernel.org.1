Return-Path: <netdev+bounces-207847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF50B08C8B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BED170CC7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9045729E0E3;
	Thu, 17 Jul 2025 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q+w4UShJ"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F061A288C12;
	Thu, 17 Jul 2025 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754288; cv=fail; b=sGIVmmeWkqSTXHJ8wiuZ6qMEnwTGlsPK9TB7LzzhvEaskko02jvc8wg3nJRqSzwJ5q4uVszK8i6HkbmVehcdDEO8WvJDbxK0AUUNxeGT/yVv4wvspkMFrTqL8rbcOcseDekQYUCQzDspYvP47VbzLQusO72PnH9P+dubhTRrHWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754288; c=relaxed/simple;
	bh=ClrNtiscXg1SkHEaPiDZEgPDZdKkXRk7/f9jXpdkqfw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=taW335pyFerW8NjuJli3HNNqcc45GRFZFBLD1iGPNZB3gpbt5kypG5eH78haBpStD34mAyKsatkKlTL9NWJBKv4rA1qSN+sRmDQLsKAoVMTNKwjl+HQivLYDd57cjTgL4EIvUe/t9IiWNYDB3TfONKsV0zJDHChaa+bd4F+rkIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q+w4UShJ; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQ3lwo2wJdTdcPhwxyBS15+rFbhyUJX15G9HI3GMnvh0JDqX6ykgmtwARoxJBIUsCT/MA95hVsVLcxc9WlH4PXMtO1QpivT0c/9j4Zx47RAUX4ZsHyUT+ORmav2C/OQG0s27kBxabHfCKtdT6bMy/WjPawMSs5zVMIYjIjYHP285JIPayfW+ZlUbsq32JV5zdMTGNipDVp1ymYmxquW1g3BSMzGZiF345pQXE8joRLtPtildFKeF+Q86hn+GwndC5ecIP2Yq6BKxHV1feHeWr7iTvaofEWFXdJ4/ZEi3tlfio6u0DS4Q9vlnZT9p8pNfW/u5koD2j1fJfvrAtyB9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj4+WVzTEf3wEyVz78qMGFOx6eNY5FZrs4WdMdLqOUw=;
 b=w83kkpJndYRMt/80Pv6+bTMYKPGQlU3S+VdG/220y0VVIlBpl7EKH9YrVdV/Nb01UfWXK1xIEXyBNe4PqPtFDBkwDwpVsTgIcv8EaMrCHdDAaA4WP96VPSTJptQnUxLMOMrbew+SQUayrsHMhIFqugJJaws7zRUd2pTiTQDIJqx+tX1+pfssYiLBzOYGWmNHCyFn1orxujcOzEnOWXcH2dmzlwnhgkJzA0qzHneldGh1AZ8t6i/r50zgD63S2NONxqUspuS07jyqlUtEjmnVcrr0G1Ayx5Xxp5w/TUJtRaWMW4UwDEdPtxBjgixiBRtiPaCAUVDvKUgMOnDNpwQeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj4+WVzTEf3wEyVz78qMGFOx6eNY5FZrs4WdMdLqOUw=;
 b=Q+w4UShJGcgFilVZnaZdrQ7mlqukCL83Seowr3iw7B77vYNgdbCxjq15jntdUBQ85k1367w/sbCHITjvAndTEuH9s+sA1ej6YfKXCdjLQsvi7iZoBYxPIRHD7x/iaUyL59JkwV7sPk/AndklOaBdGcTZ1k+qaM2m/RPLmX1l/T6XlFErjKvIbTbGHJ0c82WJrkWFlmsKc3THekkn4rwtDGQq+5dVm7KNX8Xxhnennu3otrnYFzpUNh4gCA6CszyAvLw18ISNYZzCNRTWPo6GuLUZ+8opgR+iWuj80vl1OT6dVuFayVqxWCsyDF+O328N1lYZZGoQVdBCn7tBFfUiEA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB7061.eurprd04.prod.outlook.com (2603:10a6:20b:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 12:11:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 12:11:20 +0000
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
Subject: RE: [PATCH v2 net-next 05/14] ptp: netc: add periodic pulse output
 support
Thread-Topic: [PATCH v2 net-next 05/14] ptp: netc: add periodic pulse output
 support
Thread-Index: AQHb9iZzwRwoskOMZUKjDaWLw+XZu7Q1M38AgAEE2qA=
Date: Thu, 17 Jul 2025 12:11:20 +0000
Message-ID:
 <PAXPR04MB85106E94B1E59B3C896ED30D8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-6-wei.fang@nxp.com>
 <aHgK8KL0Gxa3mmmE@lizhi-Precision-Tower-5810>
In-Reply-To: <aHgK8KL0Gxa3mmmE@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM7PR04MB7061:EE_
x-ms-office365-filtering-correlation-id: 392886d5-8b2c-47b2-b09a-08ddc52b0a73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/ID7BlOe+E88kewoY79bsARfznoFhCqxBMunP+loNlb1N9485lXKU4cFRGMV?=
 =?us-ascii?Q?npoBAXXQu7DogNzvz8XGhyfLjzMnxTQ3+ydeTIfzgLiuoAgz1HfJVPkHvjPx?=
 =?us-ascii?Q?zzaYiE3YLbap51YOFgyEEIhk5+GDwWIwATmnoGCUp7jY2kpxDIvWO5kyTXT5?=
 =?us-ascii?Q?nOD1Y8WOcp3fLJgvHIhYpRgLEeHUCGzjc3T8qrzU8kXu39ma7+LAQHdMC+no?=
 =?us-ascii?Q?0rJQYI2FDMTDn7tb9Rt1WADp7hd9klfH8/F320Ph2A2oUNBIUlYgIK3xuOXd?=
 =?us-ascii?Q?h2yBPksiPGqA3MYXOE2y2iGYlhj4GGi9Eae8GE0yQ9fbMyRyp+698AJ9tICI?=
 =?us-ascii?Q?DJ52l8RV+Hx+kJRZVNFW/Nf/am7zwYj384CoTJzw0llL1ZWBe/PULo7tJrFe?=
 =?us-ascii?Q?ucqnW9Ur0Gn6YVmCUpRQvOa5fQlzctb2e4dZFTSEZ9hcj/h+PWhnSynKqeF1?=
 =?us-ascii?Q?VQ3gsc3y+XsXe/pDKF35z1yARXI9ijGxvLjTM0Xgj08yPMGkYW3Q/ZxoIqHM?=
 =?us-ascii?Q?2lnIRRGwWQvVNInsCeqVOh93r0RH8eCxgs/Ag9NbOOb+zryZNCt4gysNZ4If?=
 =?us-ascii?Q?VkdpC1htTAXYXhYbCklwWyJ1tO0aZ3R8X8U3VV2dUHM/tim+MDdkPH2ygQjs?=
 =?us-ascii?Q?EXF1YBBR3hTAMm/VdCzQTYEWmXNQKhABQ1JKnWIkSP9FTGtvikQvd1bK0jIs?=
 =?us-ascii?Q?G8ceAUAmbgyRMDKvNU7NM7f+pD6Y32iPkj98t8+LjWQ4cUKcFIMZKkQdPStZ?=
 =?us-ascii?Q?yEvB8/CMYn+v2B9AES+lT6BIgNOIuqb4M0oXyTnO6EMbvr5j1didUVm1SAQx?=
 =?us-ascii?Q?FGv19BI97f5LNkQYSUDZQqCu0wErzQaWCwdm5fPJC235gdsVxNYXgVBodsv2?=
 =?us-ascii?Q?fzvAzs8ns7HjSwAExfV+x0wi4FQVYY2egY7bQ/kD6Pto6a1udomkvZmdL3v+?=
 =?us-ascii?Q?lyKjvTAGCSJJu5gKSfJlaFn7gt3tsDvPHttVEW/Ax7EVhOiz5cxbLglJDMU6?=
 =?us-ascii?Q?N8/UDp6LfwNoCyy/KX905e4SeRmzgwiuPoWRtLOlL3B0IwCXIfrCtQGmgnBO?=
 =?us-ascii?Q?cDiQtm9VuA8ZuL8fiIEjSaOSXvpdcNGKaIlJa9yGmYzK1FEKxuodlKelkA6+?=
 =?us-ascii?Q?zqJPwLWlXNKqadzE8MCJT7Q+HAGqWJKCrpWhx7Nqg1/PxA5dCUOB770IvVHX?=
 =?us-ascii?Q?d4yOx0LLRT2hugqfDgsq+0c+VnLGmjpvvtsW+Zh3pfcLNEvIQ/SNiRjVfuhC?=
 =?us-ascii?Q?li+2iBsz0SOZwkDuC9yjCZOS85yKD1g/4PPCkpBbPUU2db4D+esMCEigysPq?=
 =?us-ascii?Q?hsstiO67WIVWrDpcCctAMw/Rccp9rrzj6luDZjoOM0yNHNstRPS9as/Ko9DQ?=
 =?us-ascii?Q?bZHjjBLisDSdpko3TS9Vz3YSjdfI0iYJv5PHhOHub6BflX6w6kG6qMHIIHiW?=
 =?us-ascii?Q?h22V0atZX0nJrCf2ATLCsX6B5+eZVKAjBTVOvyA+h6rWirhwEUdw4A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X3//Ah/Ho0YJtw6wAr63sJSlldPFf3jIc/fw1PFQm7b/tXvvNBSSfvJnDdPE?=
 =?us-ascii?Q?Oq08PzuLjzrSPGpaZNsaVZ6PuNSfsoyZvLmTbyBcnLunGxnscq86/sJppHRj?=
 =?us-ascii?Q?qfzkOEHUGZIHQGZtiZtZv05in49OO2Lq+OHBGRfYWKCbIliB4AGqpJWWtXKY?=
 =?us-ascii?Q?/UtBRizmXe6MBNsi0A9PxumT9Mb78Bwm2AgtMLSKo/tUZ14PnxDiI9NeEFlr?=
 =?us-ascii?Q?SKcY3sYNJG6TLT0wxB6WaON8NQ1kVdq9woZ4RJkAv2cyp0dzSrfTr2FUik7x?=
 =?us-ascii?Q?LmD4XPijBdg/nlKmt5OiT6/Nd9z0NTf1K2jsRqqRcjCQ8lKchKj+r2Zjv+h1?=
 =?us-ascii?Q?jogSYlsaHM5XuMDogm/DSzoYjTooNG1bQfXJm5erM+t/owVzRW6o1HGwYlZ+?=
 =?us-ascii?Q?0x+EI7AqxXuiqlBX4/lQE0qAy4dLo9haW8E42Ona16xC4m5HlHYU7FunAQS4?=
 =?us-ascii?Q?lTwUClaHaZEuDOOFtUVuUPS7zioiws1gtrCQErkeFTETn/60VJSn7jC2YBaa?=
 =?us-ascii?Q?ltz6He1v/hDlMyBvetVIYcVSeRujiSJKgurFIQZGxU9X6t2xxk5JzeO+C+wm?=
 =?us-ascii?Q?ep/U8vhe6yvKLOqP+l4nw23ueD078VtZFo9pVgEkrWr4tboxAc717Mf6vljB?=
 =?us-ascii?Q?N1952eogQaStBEhyC5YGoJllfEU4c26gZmn6wITpT+8TeJZ2FVwVOW4b8GhH?=
 =?us-ascii?Q?cm6ckGeTDcm+oTvxC7/HNHU76RiC7Hl0FNADjJ6Mq6XWIdrfQY6T2nBoeQXi?=
 =?us-ascii?Q?1iyb36H56rWQZp91ddkEtRqZ1tt2c9LpoWoO8LYT9S7TDCEgqS/NxTUXxYGs?=
 =?us-ascii?Q?RnVFPgvtHRVQemWk9/9Rll6kf81SbZ0+mIZqYSRN7MYZ64QOlToKo9QjcDpS?=
 =?us-ascii?Q?Si9QbZcixBMPgpDlzIFC5BR307J1scXFokr1y25ITGvcTOd/WDw1hA95F4+6?=
 =?us-ascii?Q?g8dbsVp0ammEQe4ZViTPAIRTNny2FDoa43sE5z378pbcHfEY8zbY2g03NdCM?=
 =?us-ascii?Q?rmY1QwtSoOLEpq+By2Tf5tr24D+jk5+XG5zuNewksdbEjDKhtC0H33ggZV5G?=
 =?us-ascii?Q?ApwVsnMF+GHo8DWT0Cyn6qY1Kbx9PHgHNjTI43GJbtYMyCMjg/qM25K+D9Ip?=
 =?us-ascii?Q?m5IOp0Inu3+0gPIrxKLQBOF1mQzB08SBoxBWKtfvfK5DPPD6uLAVKwDYcqOX?=
 =?us-ascii?Q?SYTZ5YnzRuFPY+gqGs6GMbqB9XL7yL3ueXj1Ec4jXxQP7rQ635mcxLfhoOW3?=
 =?us-ascii?Q?DugINmbYQ7RtYTFGeS/1wCpC512IpyNDx8/3Jx8SQjDWsCtDLw2DX10u7Tfy?=
 =?us-ascii?Q?ng439Dchg/zpdBEpIypBCnEwUl9gieaAGLcfJUEYKrBPVclRY/b+zHx2rMlb?=
 =?us-ascii?Q?Yl+uqEwjN6TWe4F7Q1FSgvR6QhU57gLSMgqlecMY8AXXL0UecGJU1e2p+mdP?=
 =?us-ascii?Q?c1AOTLGx+eVG/r5UD9owoYc/fNIG3kJGBRl4VLAv7lbnproeiAuyaMdFzEpG?=
 =?us-ascii?Q?FOgtz0Y1dnZn7vru7BVSlkKkAeFZYOwde1hRG9Zm3CcaP4rXtBK/bdMNhwjp?=
 =?us-ascii?Q?+5ZTFFqiFGm4AjBUKQA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 392886d5-8b2c-47b2-b09a-08ddc52b0a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 12:11:20.5646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEaup1tnKH1qxrEAMuMTT0Fg4oL+NZxeiKzOuMlUw2EdAVAAo0fOI4JeFkX+epNzsalAkJb195CNidQYFmsVzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7061

> On Wed, Jul 16, 2025 at 03:31:02PM +0800, Wei Fang wrote:
> > NETC Timer has three pulse channels, all of which support periodic puls=
e
> > output. Bind the channel to a ALARM register and then sets a future tim=
e
> > into the ALARM register. When the current time is greater than the ALAR=
M
> > value, the FIPER register will be triggered to count down, and when the
> > count reaches 0, the pulse will be triggered. The PPS signal is also
> > implemented in this way. However, for i.MX95, only ALARM1 can be used f=
or
> > periodic pulse output, and for i.MX943, ALARM1 and ALARM2 can be used
> for
> > periodic pulse output, but NETC Timer has three channels, so for i.MX95=
,
> > only one channel can work at the same time, and for i.MX943, at most tw=
o
> > channel can work at the same time. Otherwise, if multiple channels shar=
e
> > the same ALARM register, some channel pulses will not meet expectations=
.
> > Therefore, the current implementation does not allow multiple channels =
to
> > share the same ALARM register at the same time.
>=20
> Can you simple said
>=20
> NETC Timer has three pulse channels. i.MX95 have one ALARM1. i.MX943 have
> ALARM1 and ALARM2. So only one channel can work for i.MX95. Two channels
> for imx943 at most.

Actually, i.MX95 have ALARM2 as well, but ALARM2 cannot be used as an
indication to the TMR_FIPER register start down counting. Let me think
how to refine the commit.

>=20
> Current (driver or IP) implementation don't allow multiple channels to
> share the same alarm register at the same time.
>=20
> > +static int netc_timer_get_alarm_id(struct netc_timer *priv)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < priv->fs_alarm_num; i++) {
> > +		if (!(priv->fs_alarm_bitmap & BIT(i))) {
>=20
> fnd_next_zero_bit()?
>=20
> or use ffz();
>=20

fs_alarm_num is 1 or 2, so fs_alarm_bitmap is u8 type, it fine
to use the current implementation, no need to change the type
of fs_alarm_bitmap to use the generic helper.


> > +			priv->fs_alarm_bitmap |=3D BIT(i);
> > +			break;
> > +		}
> > +	}
> > +
> > +	return i;
> > +}


