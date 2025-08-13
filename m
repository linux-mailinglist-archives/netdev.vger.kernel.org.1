Return-Path: <netdev+bounces-213163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6E1B23E2B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 04:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E671AA686A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669C71DFE09;
	Wed, 13 Aug 2025 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Duedh/1/"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6A1BCA0E;
	Wed, 13 Aug 2025 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755051674; cv=fail; b=he+dFjVP1x2UvmCWm82w4hLxmG9dMFtuGnAvLWr3WNiJuCALXV/gltVsssBRGb0M4keOqDYoG73glwFPtxMYoha3oCfvsP8edfiMfMhP4Ko4rBbx+OrDLFQ6OkFhMersIXOJWUAaQ91oRqK8Me/vTlSpqrVHmlMwsGfcrWtvew4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755051674; c=relaxed/simple;
	bh=d1/2+12AClB709owOaP3JSJBRiHm8vWbaryHkj1lwBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qwhrD/r7oyzHJYI/HhuxZmml1yfUK8KEjeyjCIQU+GymkDoThl0j5XYvySREHUWXj0qI9d3+M/9lWCHjY7K08Ar8/FEkOG+dz+KQ2HeROKS7pySgufu0KlOrPfnqJFNjVuEaRjotJ71HeR5KTX8Ye8HcLamiNWUOSIY9QpvWksY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Duedh/1/; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1BoScEAeSXJ/H5dpJecGbE5ZpoOvKtJT//iojHI3mE5MuuVl7+hjhv2tjt3xLyyEamQsvMWOiU77ZkYgWbQRBNu35IKQ+H6lcrW7NYi8E/xRq7+Q84/dhYUrYEHAanuxBAC+K3t8wPRkA4GJfnBWi27q2m9e8qwYrsYOUNU0LeoYr9YTW2BXjI6aQpyiTIsFBh5p405cQ0PPTDVGVf5V5twP3nysVh1/sVWH+F3oE7caZQIu5jLpSQSzEp+g/GSCnMujbDSRqnZ/Q2PMVKGRQu/18AisgUyjRn7W7iG7j/ohXAYQhoBaIUeKfvApY0hSFgdInp6nCSDmxbrSNrMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZGnJ2MESHWiGowOjwiQvYO5alguor7kC86AXOWtJGE=;
 b=K/PNE/R8kTh/uhIlv2nOlCEzEYtWAArxDGSH5+GzJ0HFE7J2NmKRn5j5m9bRdYoNdImrmtiNpnRWHXfCJq+0RbKE+K73tV7pXTaO8RdL2CHIrqPcKw8o5rN1b6NG48b39jsrMxJcogdvhuBM+tl6p9cW825U37BJxLwcjTV+Nm45jf7ss0gTFt2JdvTO4Hk6x5WupYP4Pnyr3hOAwVxbkWRKwCY6nFuhCmhSksgc86+Fc1mt/fzDp9Qt7ycl/xyIJVive8DXEebzfqylBsKPVwrZNIlA2rNqyl6lvGUqlMapKrjFs5IF8RO9HXFbLLy5iCY2a2miy9KKC7uJX9gPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZGnJ2MESHWiGowOjwiQvYO5alguor7kC86AXOWtJGE=;
 b=Duedh/1/FRK1QcGmKgnfJM4HHKj9WEn9EuzZiATkPXpCswetzqJYHWUolJic2GgPZxUqPAqRBYS3lTJ7DVzbRAAvYsH8+1V0wsIjOY9SHoE02Le62cAcZUCYXUUGuz3EZ+LTqlaV3Aj+BUF9jWjPmi6XgNP7wkruVzNRgoRmcc30aVzGd2AXUG1+6iVfTQqrw4bvzqfZ8+JW9eoXMCL/YHFDYRk/dH/BYFS4gXIvUlKjTuyKnAtJzIfCRUCTyAzEnHgl42b/xm2DjWM0xZ9qBm639aILl9197wd6O+ABTcCTWbMweC1TK3CTK1GGm59nZQpEgIKq8bGo/pkaVPuoXQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6842.eurprd04.prod.outlook.com (2603:10a6:10:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 02:21:09 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 02:21:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, Frank Li
	<frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v3 net-next 04/15] ptp: netc: add NETC V4 Timer PTP driver
 support
Thread-Topic: [PATCH v3 net-next 04/15] ptp: netc: add NETC V4 Timer PTP
 driver support
Thread-Index: AQHcC3Do+INtWX5a2U2G7TLOdSVPWbRfCPmAgADRQpA=
Date: Wed, 13 Aug 2025 02:21:08 +0000
Message-ID:
 <PAXPR04MB8510193754000AB8FE6E1C47882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-5-wei.fang@nxp.com>
 <20250812134931.fjtrmv6fmdgcagre@skbuf>
In-Reply-To: <20250812134931.fjtrmv6fmdgcagre@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB8PR04MB6842:EE_
x-ms-office365-filtering-correlation-id: 87848953-1330-4a9b-ce33-08ddda10103f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YPvCm3NaONFKMbdknheXOyBz691d84n4aVwuOzMBSdBHEZ9K2yp5bjMhv56v?=
 =?us-ascii?Q?V/gBDkTlUmVpYI/ywx5WLnproFFsEXkXKdUxJ0MuWG9GgPFkiXX38yYZtZaE?=
 =?us-ascii?Q?OXdoBeSxk5WoVsdQmMgh/v85HRLbG3f3GPs6osstwyqYT4gzLmWS++TAxzN7?=
 =?us-ascii?Q?y17iAg9n4oxEfyRTOZT9i9vNbn6ca20XApPVDe1zlaXLnHy24wCJBXAbfhsv?=
 =?us-ascii?Q?n2OI+7tNkTGGawX3llx4NPI04PxgbBTXnrQd80Th+iqIwA511iRTfPTs8Nrb?=
 =?us-ascii?Q?fwbJt+vaPlXogNDeXUjeCq4gPtEjLLcqMBtUpHst61AOL/5U2EiyWsPXbKvQ?=
 =?us-ascii?Q?AdRN8dsO9ak4OesIVgbY7a8xG173YNmTGhJ58tYND+gOSDl2JgHue2w2zZXW?=
 =?us-ascii?Q?+RgK1dZB9RnAf4iDPFGnG3Vha9GgWfgoyDJESgKOc25NoJhGcNurqkO4mjhh?=
 =?us-ascii?Q?yH7v9Rv6mi+oNd4UtJca0Zp07bBiT768/cURov2bKLO4MfjFziyPKDOops/+?=
 =?us-ascii?Q?z/Y7hVLEK+Lp41aX9HTeuVYVpQ0Efk0Uw3Bx1VxaxPhFC6HDBYttBcJgvJog?=
 =?us-ascii?Q?3NWyXqE4WE7pUDYQc12wt9g6Qc1dLUX1xjgaionKaJeCHrlC0X1XhTK5eLW6?=
 =?us-ascii?Q?fEvzC5iumOceFnzDtT5R3PaXVJK59hsfWVvf286v6NJSbh3lztBDPEwBxPfQ?=
 =?us-ascii?Q?MA7c4Gfmh0jbGRf07ELkOVjD2w0yp7H1hVxIoEgGDZ18Y4PGLICFQ8zDSF1d?=
 =?us-ascii?Q?imU2YAY6kj4fXX3oghxNxhsgsWIv1IXK5HI9I9Ux0J2Gj0xg9UJX1CxCoFhX?=
 =?us-ascii?Q?+S+g4ELaFtaGPajp8hec7D3oPOrCRQj0RlHeGgb2yiIOyla5USKWneGe52jm?=
 =?us-ascii?Q?C1aNIkUtEHd8PamSFtKNBlW5qkrDrhsZfF2LKPMGa9c7RvJgpPvBMXtJ0UrJ?=
 =?us-ascii?Q?KB9U86unp7HoMdoQsPmYvMAxdHatBFjrKIziWCnuShd1tZx+Bt9eAW91X2wx?=
 =?us-ascii?Q?+S7TlKGopq3iHE+A4gpaCLcTtJjCkyoMAinDXzUfIj47MzzH3zaEVvApWjNL?=
 =?us-ascii?Q?O2L5Pxr1InHvUnSl5E3si5WwGU1rbuTogWKD+kvr3ts/IWrV142DsgKTelaB?=
 =?us-ascii?Q?xo2QKPmGl/x53vlcEpEr16as0+MSICKiweD8ep709Rxv1QXj6aSOTYUHYvHs?=
 =?us-ascii?Q?8BSRzwVd/Hg1qb1LBwOTarM5fJiAYVAR2t00c2Em6ECDStGdrPt0tXqf/2wI?=
 =?us-ascii?Q?j5m+eEpmf4Z8Z1eUrsro+YjmejoHNmsbeg/lI9VvyoQZTT0dPal1lbgzkaym?=
 =?us-ascii?Q?l+6FhsEFsG1lBcW4n0GhnFtqzWtpaxxO3zfuLKsHpkFaTT3sbMtQZicNDWSW?=
 =?us-ascii?Q?XDduTqjIbew13xzSDwrWLxaCZdPBOpnpoUo+Z6IhKqsXyg/p5wwwPrFhxXWp?=
 =?us-ascii?Q?lWjKP+GNTuoNoXiwBBDZptsZLVCyHaYvZ1pkGMkN3azw3TYUHhIPpA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n2hHBhewfZ8XFDcx8VDAbMryddzW3v1MDjAZsIljUOI7iSoWGrKT6NBbQpSd?=
 =?us-ascii?Q?m2N8clsJc3bFZbPEFXUMJDZCQFbxIksALxOSNXO91uyUVhzgQNQcQkOhAeOL?=
 =?us-ascii?Q?VzMnmdpyUCMfv2zxVUvDBE9f4m+NxOhoCC2EjbZG7pi1Fn7OVQtUfqu1mEm9?=
 =?us-ascii?Q?IlvUFOa5iJz0ta5xAeUsRk8YwoTwi8E0lLFJuu548AH4KenRw/hc3LlkI9sR?=
 =?us-ascii?Q?xN/eaGtKrBPRLFAZG9TltQwc3IbeNR0DFxM7SAdb0PRfAqnHP2M09lKHkrgX?=
 =?us-ascii?Q?rSpOuoBlt4lpkAxS1vMVHF61Bk3vuZguy3bZ7IScMnDlduGLuSqJxWxQkdoB?=
 =?us-ascii?Q?BH8POWSMPBvzmQsB11hLWVY/qJpeobdJuXB6vm05bYgcMn3iqtzBjBfbQYr8?=
 =?us-ascii?Q?TG2WTsXF3u+vUQDxBHA4vj9iRe3t0brGula31vxFeMzKvLAeENjYVK43XY8B?=
 =?us-ascii?Q?ypsaMlRAiojYVqYf9WPDZyU8SnAHZeFpSUpb7SVfr12SIEF03qhA9gSP6X3h?=
 =?us-ascii?Q?sQ5rdKslA+MNZgqfjjm0cN5dW50Cdhwxr6d00XPb3mKKXPNwfZrOWKdgsbTD?=
 =?us-ascii?Q?3wrRnSQvWm760ginyl2/vWZWpReDVVdKLYCZx6G/JGv41wFLwTnoYeEjnusc?=
 =?us-ascii?Q?D0WTpqTg9SyZ6A/EWGDMwKE52xrATmZdfXyK1/JmcprPr4hGRleRY47Q5ZsF?=
 =?us-ascii?Q?YrAq0pkFohheYHJDw8ngGfznvSKYFCJvvTGppzWK3Th3slH5gmJtFnOsOHnk?=
 =?us-ascii?Q?3v/xFZQfEo80oDX6CkGuCeuM3z2o7xypXd6pDmdmfgZucRt8O29fgaen2XM5?=
 =?us-ascii?Q?tpnE2fyOUrXPYqMvjpS9hXwYyMMLVF5u/+YQvDxoJSE6nJZGgUozr2Bi3eQt?=
 =?us-ascii?Q?Jy4oYWRY0ze6K0nsaD2rLca5aHu3HT+bxXKLe+kx4yi2Pj/v23k1/+0WPekN?=
 =?us-ascii?Q?zhBvRYeWLssfJbMqb5XwQL/L/J6j1sK/wYhVe1uI8jQdOUq1yrRpjnlU/QE9?=
 =?us-ascii?Q?JYZB33F+d9wLcf/kuTfWWjwH1Z2JWUipoXjYYcl6yOgN6SGrtJR3d1PLjxgF?=
 =?us-ascii?Q?zQIOm8Ybf48yUX2k07OwhgTBUxbGHly5iegHR0HyxW7YyC2vu3JHbFldsXDK?=
 =?us-ascii?Q?mxpe/Y0KmO9PsJpPbS5Bq9re+Kdk4cmWlpVH0Nxn86CbFHmQv333Sjb1ZdXo?=
 =?us-ascii?Q?F61Pj9YPfo2hFkbexhnlJB/rDq7r1oVDZVoI0wJ6Emz77WuCgEiTxFcDiIJf?=
 =?us-ascii?Q?1ZTEQTVk3cSUaXjVaR0GH49Y3FzCI5CXMdXrsZPmRGit9ZFCA4OyGcYG3ou3?=
 =?us-ascii?Q?IHifU6ouYMMWCIFmx5fnTaWE8aGI/13e1orS7Ro8Rj1jt3RkgOQ8jx/IXrzD?=
 =?us-ascii?Q?5UUFPwlhQQ46ov6RRwc5xR+auieMLqPo5zYek7VCRhvd63TIt+/VETc0yyds?=
 =?us-ascii?Q?2uwBXE5v4fb7hOEBwmxkXTGZxZYinp15vskxyQbwAl45a5IGpEZ/O4M3xEfM?=
 =?us-ascii?Q?KD+Vf+jD/syiDPWuGD+Obzyz4q5vEM/ESiao8eQ22gpcd9tvnJFJWM9nZQtQ?=
 =?us-ascii?Q?FF/HuWC+aV94ZMBrzxw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87848953-1330-4a9b-ce33-08ddda10103f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 02:21:08.3196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBD1Ww03CF04Rt10+/kMpNgH0L6/dlgfY096IH3BjspBIy3hFE5ZEt8GNyiOwiLVHVa2hgsKNi/0WartqQtc8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6842

> On Tue, Aug 12, 2025 at 05:46:23PM +0800, Wei Fang wrote:
> > +int netc_timer_get_phc_index(struct pci_dev *timer_pdev) {
> > +	struct netc_timer *priv;
> > +
> > +	if (!timer_pdev)
> > +		return -ENODEV;
> > +
> > +	priv =3D pci_get_drvdata(timer_pdev);
> > +	if (!priv)
> > +		return -EINVAL;
> > +
> > +	return priv->phc_index;
> > +}
> > +EXPORT_SYMBOL_GPL(netc_timer_get_phc_index);
> ...
> > @@ -16,4 +17,13 @@ static inline void netc_write(void __iomem *reg, u32
> val)
> >  	iowrite32(val, reg);
> >  }
> >
> > +#if IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER)
> > +int netc_timer_get_phc_index(struct pci_dev *timer_pdev); #else
> > +static inline int netc_timer_get_phc_index(struct pci_dev
> > +*timer_pdev) {
> > +	return -ENODEV;
> > +}
> > +#endif
> > +
>=20
> I was expecting that with the generic ptp-timer phandle you'd also offer
> a generic mechanism of retrieving the PHC index, instead of cooking up a
> custom API convention between the NETC MAC and the NETC timer.
>=20

Good advice, I did not realize that, I will try to apply your proposal,
many thanks.

> Something like below, completely untested:
>=20
> struct ptp_clock_fwnode_match {
> 	struct fwnode_handle *fwnode;
> 	struct ptp_clock *clock;
> };
>=20
> static int ptp_clock_fwnode_match(struct device *dev, void *data)
> {
> 	struct ptp_clock_fwnode_match *match =3D data;
>=20
> 	if (!dev->parent || dev_fwnode(dev->parent) !=3D match->fwnode)
> 		return 0;
>=20
> 	match->clock =3D dev_get_drvdata(dev);
> 	return 1;
> }
>=20
> static struct ptp_clock *ptp_clock_find_by_fwnode(struct fwnode_handle
> *fwnode)
> {
> 	struct ptp_clock_fwnode_match match =3D { .fwnode =3D fwnode };
>=20
> 	class_for_each_device(&ptp_class, NULL, &match,
> ptp_clock_fwnode_match);
>=20
> 	return match.clock;
> }
>=20
> int ptp_clock_index_by_fwnode_handle(struct fwnode_handle *fwnode)
> {
> 	struct fwnode_handle *ptp_fwnode;
> 	struct ptp_clock *clock;
> 	int phc_index;
>=20
> 	ptp_fwnode =3D fwnode_find_reference(fwnode, "ptp-timer", 0);
> 	if (!ptp_fwnode)
> 		return -1;
>=20
> 	clock =3D ptp_clock_find_by_fwnode(ptp_fwnode);
> 	fwnode_handle_put(ptp_fwnode);
> 	if (!clock)
> 		return -1;
>=20
> 	phc_index =3D ptp_clock_index(clock);
> 	put_device(&clock->dev);
>=20
> 	return phc_index;
> }
> EXPORT_SYMBOL_GPL(ptp_clock_index_by_fwnode_handle);

