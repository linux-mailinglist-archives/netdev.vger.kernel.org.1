Return-Path: <netdev+bounces-208960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE51FB0DB22
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2873A3A48
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D692E9ED9;
	Tue, 22 Jul 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b1neTJiY"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F385224FD;
	Tue, 22 Jul 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191703; cv=fail; b=FpZQGH4aCZAx2H64WOl5fVlIB88VfzadyaPM6pKKxYqT0JD4AE878lwWLVPSNQGkxF6rATAy7h/IMdJIc827BismlxQrs5ZG5xcWpB47IWe6x2UwJS+3ZA8YSlNab16MHsUFEpkX3JQCUiplTpb70cBC4QBTXe8ghsaN38eP5Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191703; c=relaxed/simple;
	bh=BYNoY3C2Zb0iinS/jZzaMP6CwZnTScw2UR58EmMu/RM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hOAoXAjO9HxBWgF5Jdw9t15yXuw2ydYn0RYG/Kl9Es5lqu/wS3S+qC/7icoUmn0Vx7RMt6jqXBZADxLSZtOZOvol9Afq8GyBWB35VO76dj0o8njHDVFqhIR09KdoHcq+DVCMYpMspnTYZZwXRXC0eXi2e8dmGRn0eOlCDHVr8vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b1neTJiY; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxg2+dukllQlOql2DAhCFJDpgRXyVEvTIl3vLGd575rRjO1EzPh+kS1XzpFQIsKkL8sClG+21cgw0XYsycFA6c4ewA3iGzU4EU2VXabfQ4TQiaABKkvSXf+51iG0f8edN/AhjJb4JYbsmnAz0J3W1L+1i48rKqm8lqt6fqu0ZxUfINEOa3hBnjJVImJRgt2BGlclEz8dYF2z6/5soLgUtRlY0OnkWbggTWkojYfh5vBfk5ueN7AbG0UM8QN8ztOEZTps0CenRgAvqG4GkAWJVnWNyuZpeytAeB6m3OA7gM5mylOXCSiGFEHRQkfxZJAehoO9hL7EaWykVWZbZ49RFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EabwTGRe895rz0/wua2tm02g1iiKpq7b24ElH4mRNk=;
 b=UcHX5KAHQXcIjXqkmOPJdAQrp1YMe2D4x255IK9DxqdhJuUtNg3zhrPDrjU344ySB6ltdqs0JjIsQ22ngbr8Q6UMT+BxcHJ+21DphvvArQ2npJrpU3UNw3W42mDOdBUezCvbuxVyvaLYsWWiOXbcDulEzckCNvu1HoppOLAM14+bZNuzMBsZIDNpcmbCSjFTITQCQODxv4Vx47xg5jnU6wV5zlRpiJO03eQMQ/Rh1O0AJNT68x9P1NVAQP+WGYsY/q9yMKqOndEYwAwgNoxBwqS0wnI34y011rMcy2dThjX0ADY9EpNIZtfJznfkl0hGmVpkket/s8mVMExtOqMnnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EabwTGRe895rz0/wua2tm02g1iiKpq7b24ElH4mRNk=;
 b=b1neTJiYdP2Q+AdqlnGqeSoP+Fv6GSvQxqQ3n84WlZp/0PrzHNSu8REbmjBn8Q7/Tpp8HHM5rsXIf6iqK0sgqx9rOkGELN/Xozf8VMckxXecI2rDEvWMPpGYPrIczf2qrp+8jRRAI7ITA4wWyxZeTaC3TRE49ylx6JmFMLHneNeJJvFxM8b2mKah+z8KbCg3FcfVohzJ8qTepPQ2xVQ9hBXiw78Bmxj5x2QWQMjAJhbzYUVXKnkWkYDzlEQtoqf9QCRIitoNhP6tWfMtm90sdwqCf4PmE/DMXCOHy3u7nh11g2P/jlbH3b9sYcJlIHTRL4LJ3QfiJL0XUs2LANARtQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 13:41:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.042; Tue, 22 Jul 2025
 13:41:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Frank Li <frank.li@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "F.S.
 Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 net-next 12/14] net: enetc: add PTP synchronization
 support for ENETC v4
Thread-Topic: [PATCH v2 net-next 12/14] net: enetc: add PTP synchronization
 support for ENETC v4
Thread-Index:
 AQHb9iaTMw7wWMBukEKvuK11OYCKQ7Q1PTuAgAEA5pCAAKP7AIAAQxZwgAb+2wCAAAtUUA==
Date: Tue, 22 Jul 2025 13:41:37 +0000
Message-ID:
 <PAXPR04MB851029B1395CFB3E89EEAE2D885CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-13-wei.fang@nxp.com>
 <aHgTG1hIXoN45cQo@lizhi-Precision-Tower-5810>
 <PAXPR04MB85104A1A15F6BD7399E746718851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <aHl0KvQwLC9ZCdtM@lizhi-Precision-Tower-5810>
 <PAXPR04MB8510D86B82F03530769569958850A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250722125728.qut45qn5uia6pj4f@skbuf>
In-Reply-To: <20250722125728.qut45qn5uia6pj4f@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8070:EE_
x-ms-office365-filtering-correlation-id: 5798d489-abf4-4e2a-4a52-08ddc9257b8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6AGuKeLdnbZJfOq1MZLTm6y0tssQV3PJf8cGG9JFXSd9EZWc3uOt4JDUtTTK?=
 =?us-ascii?Q?sqvWo/h4zAY7LRRNMk9L+eoOu8VelPS+P9M37w3sNmknQyqzIW5ZkQYYtUo+?=
 =?us-ascii?Q?x7sDjfY4ZdcUtevK6Uiq5Q7O54YZ99sHlo/Ts6QKlskQrYHAi3AwiiZA0pod?=
 =?us-ascii?Q?UKesYwMDmdV6b1FjCTA6Oy9vp4vLbOPjknrRa0zu2VmIRCaIH5JVUFEjqfqw?=
 =?us-ascii?Q?tX+E4FB/xK9KPavJ3qfpotkxY/nHoBfuwTSAncwYeeucfxv2ObKV4R27gAGH?=
 =?us-ascii?Q?VHOSSiuXiRpYdN9fOYCXFEuAB0s3gPR49d/yi58LUXBM+yt47oyOFv+usx+r?=
 =?us-ascii?Q?TYiGbW115p6mlrW3m/syG9JdsVXG1xeNr/dA1Dip7fOXNbcuTuU+NuqI6dLn?=
 =?us-ascii?Q?Sa3J1ZJww7TtP4auxFRG+xF8P+3ZcoJgYOvwE8LH2v5eLp3+B+Wv86Ev4lwk?=
 =?us-ascii?Q?a0+l8fLZC+b+iyNi4YiHiqLTwcaRUXVYXqjBXQwzsBcFVjugAh7MOUGoF6nS?=
 =?us-ascii?Q?pyDoIHMCN/XLyz/iLa+Q5t0El/FWK2LnfoUn9yGcp7DQSRUC1B0bA0nbu3yU?=
 =?us-ascii?Q?cA2Il3shF4mrD7MBrNV8KGft0dcFSFzwhmC5XwMBQzz7fLCKr4N1C+yG/d26?=
 =?us-ascii?Q?LASLzNwFvDDONagcNapSLjS22vje2L1I3LzB2FedAwgdPUNfFxv2+QN05o8i?=
 =?us-ascii?Q?DbewnJwmmxLFadnnz+GUtwmPVG3iFs9Iilf3IjckMJTW6kSg2WE7ujOUbSdl?=
 =?us-ascii?Q?OuHh+8R8ifaz1WASeTqJIsrTtzPXUwfBLeB7JfhuxKF+aahGXtOp46YhwxHc?=
 =?us-ascii?Q?M5GxqjoO5oPxGaJysJTYCYwi3Qs7FglWk2xItuo/99co7hNI5fG0hfUr4Nq0?=
 =?us-ascii?Q?i5mGZa1tUQc0TJ9Ko3B31GTZ/XtT+FAZ8QW5xeUj45a8puLNGpSthlpnG08i?=
 =?us-ascii?Q?FYiY93lMHKonLFAQ6tjT5+1MVSPp7ji8yoIWBhuDd81DIIsbt9X010wxQOtF?=
 =?us-ascii?Q?Yd5pCfbdOoG41Rl0Kew4Ise8s4byFkg7O3vaRpDpP/u1tCP/sSnHlcgsSKcQ?=
 =?us-ascii?Q?U5pecHL0Sia2geFSDW4nGVKSrcRk3zQmS7Os6rM6c+KSLOVajuoN3vWqFMbC?=
 =?us-ascii?Q?nWbPc03y3FmivZXNW521HQoiBiYksaUMf3tWRsAAvXg2OQEMPX1i9lf3lXwO?=
 =?us-ascii?Q?z01mslWNSV6//MRBzxyIQ0iGvY+Zwa1q/SpDRiiSAayqslsJJmixBmaSRrL3?=
 =?us-ascii?Q?E51y9ocBKQzlapGE8HHzTL3ZzoPR2H6pPbLy3ri472ZghV1OB+F7A+I0YWAk?=
 =?us-ascii?Q?mSWJN8oxhSAxHpPdB7svEUOgJ43s2fcq27PP4jp2HDMM3AKFon9f3Tt/X7wc?=
 =?us-ascii?Q?TEF00oYiBzzl5Disu7aiRhi0M6Nab5lvv3MCJWDhz2ZVD54rCktMyo1mtds4?=
 =?us-ascii?Q?ZeJYYch4WqLDr4i3w6x7P+iQzCkQB9gFfdv3znKN5yp2Ta3v9RqNyw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K5Nd0c5bRNGs0bOyODZWn+A5MA880+MEXO/X7F8BSjLuiwM4MjLUIxDhMFOV?=
 =?us-ascii?Q?an1A58JabwAfPd7Wyp+rOprV6ohQEX0/4/4lteuGphPzq7nHK9vfyI+m7lt7?=
 =?us-ascii?Q?F1uu3dLrVWCQoh2DQ9vlehvaxlUDVJjRIjsqvm3rqux7tKwSrlKIduAYN7II?=
 =?us-ascii?Q?Sat52MG39AHGy6i1jGw7AWCUe1QkYKnhrbPYNv9L2frV8zYabMuhZFmNlnCO?=
 =?us-ascii?Q?NmHvXLwqHLdTuTDlzc458hWBCVFYmPyjzKITA3ExiYQ+fVkhHZ9i8x0j1/u1?=
 =?us-ascii?Q?8nCkJUCpY0lJjHZUru7Hfqjwbogrtdr9kVcLgWONWQGa2p5Y7fnE3GQhLZNy?=
 =?us-ascii?Q?7NqeIOIoFojEKnru4bYbuuUfKJIz/Ry7DaJkzxiT+h6JT1lJNmzmJspg8VO6?=
 =?us-ascii?Q?EIDZnhE1/RjAxvkzCa1v0xe530IUgVrOqZwJKVgqGehXFvpgS+FCDGemabfU?=
 =?us-ascii?Q?YYK+OG/fTzi4qM0i9dPskIHxUV8MWMdeG1wMlNYydrn3bPn8eC02jrj8WQoq?=
 =?us-ascii?Q?XiMT8ocKtpuVE4nArX6M42X7zpWLmxnWY4PJIQD2ywtMHSRMDQyqAFYVmMbx?=
 =?us-ascii?Q?mm7S+k1zYxnSBJXiXx6w0L3yyWodQYc5dYhBMX3Xs4RU9QGF55LHpImp55o2?=
 =?us-ascii?Q?KsXU+/3DHe5K3oOqh/ZhjmNArSEsCsp+M3xLxer1NlJlEkf6B9IIT9hmlNX4?=
 =?us-ascii?Q?xV1hvR35wcF06w1dCsb1W+/cLjcp2E3AiH48LqGGWtm0J41aDiEQabIX1GQ+?=
 =?us-ascii?Q?RsHWHLv4FO7NkHzSdHP0c2P9zoSOLJBZ/RGmTH5NCdSG88NCanRFkfyIUoJj?=
 =?us-ascii?Q?C+moCfyJGbscv4+YHqM9GIBX8bcrS1wOnwtEFC1FY8bA5WMEAlL6RAy0IuIS?=
 =?us-ascii?Q?L/F/SmOYKbjOkHj/LCVKDbfv1LhbmiETGn89SsSmDviiYC1GSgQe3Nc9DQgY?=
 =?us-ascii?Q?hIhBIGXBVsHovZ6b/JUuKc+djpK4X9n4RDRe69GhO0JLkbEVKHteqLl4HYAB?=
 =?us-ascii?Q?3oZeT8B1vvZzyRPXCbG8hG7cRjMPx7fhSrvGNM9aCD3geLMO7apFuqVaYiRD?=
 =?us-ascii?Q?kmmTDwV1uCWWCDuhjIMPTEoUoj2pfMLy53FaKYAoGKY8Pyg21BNMbeqw3bMc?=
 =?us-ascii?Q?KyZG2IhEhC+OzK3GmZrEgxiELiD5JubAvyKqRR/0Z31BxM2RPKa0wi2hgfJn?=
 =?us-ascii?Q?x3DdfO0a3HbzB3guVuENNSBUn1+5/u/j4YTwrYWbSHgxtGyXoq5zUCIvVUn0?=
 =?us-ascii?Q?w9cuKPtopKYPnEyu5ZenpTsLEvHF6n6C2HzbN6lkpZcvFcYjm22hjnVHsFZL?=
 =?us-ascii?Q?Yc0qaX8nG75jnjqKvm2Og6a+cOrbIFqlf4xc19IixdGHdkyFYU4inSW0hY6Z?=
 =?us-ascii?Q?9MhH56xgOZoBP6xJw44cSvbEGPDTVgKsf9Whg81exRsW+YqIO0tDrstFwSTB?=
 =?us-ascii?Q?ps9tjlSwWtxgkMwGz4u/hyJiObiCG4GO4NnZSTl/ODFC2549uJcIY4X5pYVS?=
 =?us-ascii?Q?dQcF0cfYEpGx99IsVFu0jFU9mZuB6W9r8o6dqQpk1hm2YDTWFc0/Yr+p4Th+?=
 =?us-ascii?Q?HUPkrixFIoBo8Ra122E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5798d489-abf4-4e2a-4a52-08ddc9257b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 13:41:37.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yE9rCTxeB/FtsKMGXSGD+2KFm/pg1HL6ZJz/rzxzAVnJf3ogefBwaExYi0tsdCtMekLAbcTRrKOR2XMk0rbjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070

> On Fri, Jul 18, 2025 at 05:08:09AM +0300, Wei Fang wrote:
> > > > > > +static inline bool enetc_ptp_clock_is_enabled(struct enetc_si =
*si) {
> > > > > > +	if (is_enetc_rev1(si))
> > > > > > +		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
> > > > > > +
> > > > > > +	return IS_ENABLED(CONFIG_PTP_1588_CLOCK_NETC);
> > > > > > +}
> > > > > > +
> > > > >
> > > > > why v1 check CONFIG_FSL_ENETC_PTP_CLOCK and other check
> > > > > CONFIG_PTP_1588_CLOCK_NETC
> > > >
> > > > Because they use different PTP drivers, so the configs are differen=
t.
> > >
> > > But name CONFIG_FSL_ENETC_PTP_CLOCK and
> > > CONFIG_PTP_1588_CLOCK_NETC is quite
> > > similar, suppose CONFIG_PTP_1588_CLOCK_NETC should be
> > > CONFIG_PTP_1588_CLOCK_NETC_V4
> > >
> > Okay, it looks good
>=20
> The help text is also very confusing, nowhere is it specified that the
> new driver is for NETCv4, the reader can just as well interpret it that
> the LS1028A ENETC can use this PTP timer driver.
>=20
> +         This driver adds support for using the NXP NETC Timer as a PTP
> +         clock. This clock is used by ENETC MAC or NETC Switch for PTP
> +         synchronization. It also supports periodic output signal (e.g.
> +         PPS) and external trigger timestamping.

Thanks for pointing out this, let me improve the description in the next
version.


