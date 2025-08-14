Return-Path: <netdev+bounces-213551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D54CB25924
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 03:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CC31BC76EC
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 01:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB411E5B9A;
	Thu, 14 Aug 2025 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TxPa0XVF"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF14163;
	Thu, 14 Aug 2025 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755135278; cv=fail; b=V5CFQzk9KW1MtBjNgD6nsn+EG9wj9XWpUj7aN1mfvjGMwpy/5gv+d9gcyiGLWzVajrE7HlKCLLe8Uj/DVaEyOn/KpSS/iz6GMI4xSWueTgVioPmONXhL6/GYHHV1rQgvUzOByqOOWUB4NTqa1lSJ+UwLT0/c7/2LvaUTulaQCyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755135278; c=relaxed/simple;
	bh=SwxyPrwQ7TVpDm2uVNJ2GkMoJHbUKXoW1p6czDJllnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gSVzCVu4riaLjYrDFRZKlmoSdotk/D+tuV5f3IBs1+jHKRmasro/WJ8BXZoRRphArTgRM7GgyXyQzTzLUA5dpbAqULRJY4/y2wLJyxO8sCOFML+gBz20b0XePaPMUQqHPtSED1Q+mUvL2HbLqjYPPcpCayxHWHgWvkAcM099QkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TxPa0XVF; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqO5VZWU8ML3C+BN7suh76ku1eG9xjemVItGX3v4ZTz8sGFLBQ6dI8Xlpfd0HvT7bFM+QijszXoqriT+zVYL7fIUL/OOzF1P3DKaZbMXhq5KGc+htHYW/ZMGNZihS80fwzDl2UimsHGRnvb8t5pPUqmnu4R3X2MdpRRIlJbfHzKcmMCv9FnRLdCP8kJ5AjBrkDKX7PEb32FJAqBeFy5BbC5TlinRaR+smyFQWn4ajOKTYobFFR0wjRkEtlqG0FAWlkPtauUHf9VKL7XFUxZ86iky5Z3VJQo95HLdmshUrfGRxxgxYJms+9Waxoo8I7OHDxGctVe3lLOv8974jVxyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpDHu4OshJqNXbbORc8+kYFsA10o3vSd391WwxvWB1I=;
 b=X0wvX7181cAoJLiNr79HnxQI6KjhSzWE4wB4lsN9A0LTqe7m90KvbXLLd+EsLRLzmgoX5CiV89ZFmFbkAk+dzmOdnhnWdfwNM+Q+z0vlnfCK6uy7OIPyh9oQvPc1dKmD7F3YLLfwEoZp6w7XuaxuGsT+xsr6p5abkncgc52Rn32fBzpnh8NoRfUomTHzgRuu/D7QR7CRR1h1UAdhLWmgheQmsUZa10p4GpbEPdEzH7m1ESO5NBNO7DTqB3hhBLwAtE9XLH//bsnOZdKouzCSrKOyPAdLtsGX4YMCNYEBbh8EdJF9Uw4ThyWSSVO7v1ooZxQdMEk2kZWBv4TshCNX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpDHu4OshJqNXbbORc8+kYFsA10o3vSd391WwxvWB1I=;
 b=TxPa0XVFn4qkZDayLGtXHDFJvD1CVW9I//J7SD2U6+JQJLCdHPxifgnJjVh+POQ7RLfTIgbCT/UNa5yO7wpGTiYIZnAB1mS5Ff3UJHEXXOMjX0HcIWh63yXJ7NJ3C71HxF3jPRUc7E/LT7xP0V9W7alXUUtRNvWIkS8T+6v9Bv0QR+cGi7NKNVKKygkQ6gAfJnJZyA+AnqqWM8FJyrf0vMyL/tOMeKtOgU++zoBCAFYsSzA7tjPTQV0mFMOe4VSMWqgIA0wdFd1CsdZskY+jMgQY9CfuTAs51MA+nJw5S/iu1emOfx8QFuFpqmXdiOk7MrsTWRH9Itr3zmLMfPk3bQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10224.eurprd04.prod.outlook.com (2603:10a6:800:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Thu, 14 Aug
 2025 01:34:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 01:34:32 +0000
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
Subject: RE: [PATCH v3 net-next 03/15] dt-bindings: net: add an example for
 ENETC v4
Thread-Topic: [PATCH v3 net-next 03/15] dt-bindings: net: add an example for
 ENETC v4
Thread-Index: AQHcC3DkGmTUNwk2xESr59nb08m5z7RfFqQAgAC3jbCAAOOvAIAArjeQ
Date: Thu, 14 Aug 2025 01:34:32 +0000
Message-ID:
 <PAXPR04MB85100738E2AD741CA5C8E9648835A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-4-wei.fang@nxp.com>
 <aJtR4j9+w5fVsJL4@lizhi-Precision-Tower-5810>
 <PAXPR04MB8510925387F9F72A8E99AB82882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <aJyq2h+y+KBjqmsr@lizhi-Precision-Tower-5810>
In-Reply-To: <aJyq2h+y+KBjqmsr@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10224:EE_
x-ms-office365-filtering-correlation-id: 964b26ab-0288-494f-6b4e-08dddad2b822
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BtSojcYyHJ1wJgwDiWsStI57d8dXCtbjITm8xT4viJFjx3Qi/bl7nHUiWXTV?=
 =?us-ascii?Q?Iz5MTZjwSmvkG6vyuJo96eOxErRB9gZtOlkZq0ZnBOpKWU3+9JZztBISBk0z?=
 =?us-ascii?Q?yjkuT8S7iLc/yBO5KzqC7k8fbx7RT0pfBNcoZCo320AbJlZFjLn9PXpmRPQy?=
 =?us-ascii?Q?5GO42hNdu1GABbwj34YdD9aHIqrXvf5wDmn5tDEe2b3lZCYvPPSlQHI2fijs?=
 =?us-ascii?Q?bpA67Yta0Z6a4LEpJLTNzGBeIzw03WzSQnQSN7t6VtSs/iUSmchTiXPHhKdO?=
 =?us-ascii?Q?fplPg7efkhUuhlui/w6x5itbxrPQdgGcoPgum2GbcFjuq/fj9wzKLOQX59JE?=
 =?us-ascii?Q?IlHSp4gVGoBEV216+kSdChe3b37eqmcEizd/2ROJQUsYl6BLKH3OTsqdVS7D?=
 =?us-ascii?Q?3iBfJe9uEKCcUtpu27aUAbzi2gP5PNhMS1TX48YROleBOewW1e2sMMiSJNL1?=
 =?us-ascii?Q?+v0uu2OtkEB4ZHTqeKrDmKs4DzzhJM9cYqWG1Ve202tTkq2aPyr4s2J4Nnk0?=
 =?us-ascii?Q?rHLS/qGWhAMBYHP1/QEB5KDWEPLa90a+5QrA+2XOm9Wp3dP0Sbs5MAjvxp+0?=
 =?us-ascii?Q?DFr11i4vCqjQMCZ7p2wGP8s9X/xCAo9MNWPwpI7E5+mAzdap8Y1IBJ59pbkf?=
 =?us-ascii?Q?0NX0PjS45PhCLUjEF6sZrqb9gk+TJveugZhWo46ieSo5zNzNdVphomTOGY8R?=
 =?us-ascii?Q?lg2gfMQhrhVaQtL0D4pY+Jgb8kzr2aO8SIelllqFy/QOK8uTToBCkmscDfZI?=
 =?us-ascii?Q?CIsnCoP8C6TH7bzxYgpTQqULoLRyDwJAUXj4EdySMoXqfDSpQjdU5BEu52md?=
 =?us-ascii?Q?4T6M0rJfvH5NcJ9wOgc5NJwMr/Ewj2yYVrHXkfpQvnn1NWd2QVMWUO147vS7?=
 =?us-ascii?Q?kNbSRphAuROl/6o4c/mnTl1sNgRFPmkDyPpaIPG35lNqJLuVj3MaVmGt6yBB?=
 =?us-ascii?Q?4Yqn1ryvy3zg0pLlnwPAh6ccbtSZnpe/U3KuuxxCbe4uWI5X9uvVPMbF4zd/?=
 =?us-ascii?Q?l4+YRQylY0NijKjpKAOOmLlehZH5fjzAbY5e50daDh32zYxmy3vl9ffmnDtD?=
 =?us-ascii?Q?2Ww9VBDIYMtbW9vm1vWqs5GDnr3hlmqUOhvaNG6/EhpsdhYEebA6IHNBW8Kc?=
 =?us-ascii?Q?0qnb0onaAPm1gO/qW4aSvVJp+KfK0Q4Ca6ihDZDAuDEZ2vzz5XrIwCNJ6AVY?=
 =?us-ascii?Q?Q58rO5ReKh3i+r8rk9Pxvneg4kCjErzICh/FP0XrZtpMt+KldHPedoUCR8p9?=
 =?us-ascii?Q?5QcoBPnWmLxgVkq4XyHBd8ePEpQQbuHf5C3h5qgg39QogEbL3p8W5eIMVpoG?=
 =?us-ascii?Q?WHHydw+QESpg1C5/0BvyFROnUK9XzUJE3o8ZPKf5s7rZGjYo+9ILM/uB5IRj?=
 =?us-ascii?Q?ayx97IHxIcVajb8Qy3ooJMUnvilWF6tO0cGgWSyJgrveyCX3RcjD2FjAM4ef?=
 =?us-ascii?Q?BJGkBr1axkbgXAby/BRmNMFdLyYw/mR+91b3Ge7awxinJ9QbY0Kr8w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dT3QBu/tNjDBcCliyKGjBmHWQjy63PNtDl6QLgfXLDih1Rh9myO6gyJUnhKO?=
 =?us-ascii?Q?Ppqz7BZ/MYqLgGiiB5hxXZfZpxOcD3OFRKHmM25A8a+dBq8XCdsSyBmtvWOZ?=
 =?us-ascii?Q?IKPlRIg3Zm4YZdMoUqE9CuTxYC48brbjTONHFiFFYCu9UAjO247BNG2lik7V?=
 =?us-ascii?Q?u+BlotK6WAwBlbCLf7oV5U6pzqtHwyfkJnaHt+PZdBB+1nRiCiL7JnXO1eTe?=
 =?us-ascii?Q?e3uj1CAqjw/Fb+JK9UspNcgBIlNOsmucDqjNmCIcfe+2Zkjv3CZpNZrEac9U?=
 =?us-ascii?Q?jZ0NIX+xHDkdrfv5bvoaxfs6erKiuJIMj46ivwEV1s2F7NvTKdESk+23eYVS?=
 =?us-ascii?Q?fjNvdBGMkyC8cVZAi8BD5oqwW5WkPCdBk4wAEKPPfaZFB+RM5sLTvJQ+nEbk?=
 =?us-ascii?Q?GYEMfqqcLdZMv0ac3mMZZ5lIgsdsM89SVLg/9faeufJHoa2Y0Hji3KAxW1q9?=
 =?us-ascii?Q?DFoBNqBUHuSh0qaXhgPcADHKQrtEIFiwpLfcq83kdY5AKGUTYFhEKEg60pIy?=
 =?us-ascii?Q?jcbP7nxBXOwG6h4u1UG8kGTdQ4n8oOSe4RVA9e9URFbGzMDvagd2eMzT8vba?=
 =?us-ascii?Q?pKAOp2zdrEOb6vkKjZTYxcYeh1Xy5jR8bbMKKAsRTUoCoZpvZfaLMAFsY176?=
 =?us-ascii?Q?wFMC8XZUQzAlcGD4n0b/PCdWAR9XpQl3QmLddAKMGjR9YY8yVvqbwW+T1yYX?=
 =?us-ascii?Q?HiwRkTfernlqBrya/jIE5qnfaelD/XlC6HBNJiri4qhz86ftdBV6zo0EaiIK?=
 =?us-ascii?Q?oNzEEn7xv3YHCxfGuEl5AxAeRMOxZGlSHkN4U+cAIhlCgWy2Siz6Dg+LYfkP?=
 =?us-ascii?Q?7UWd/Egcp1P/6yAwBsrkAvqped1aG8Vzsr5KjepSgHvB8V4coaku8a8UIVJ3?=
 =?us-ascii?Q?eS5xG19lUEoXg/X9XvGI4IbZP89R4RsqqlnkM/Q8O0jYQCr5hupV48bZfGPM?=
 =?us-ascii?Q?ujnC9wrSYYPsNjxFyoDLb0Z5OccE5qXMG5L9tfVcDv2mL9I5nZEhHGujSG7z?=
 =?us-ascii?Q?vZncbij+CKSf9C2LE2PjMxHqOxrLBimmI8X0lGcoMlLqhZ+sjGCwhm+2sEeI?=
 =?us-ascii?Q?nI8gOrYl2jpTDN7ZmR6R51l/bnUqsp780Z74iKXzTUbiwuK6xa8AP9sPnwJ4?=
 =?us-ascii?Q?RSYgYjHZzLHoVqapV1g4SBAjLKl2nu+qjnPronJGVYZ+XWB0D/Uh2tnaU0/Y?=
 =?us-ascii?Q?CmK4VyWQenYIo6kn1CU58jw1fw6aY0kqavfTFoCC0SnZnamnid+gXCmgNHNV?=
 =?us-ascii?Q?2+fn9m36VT1ijd4N96hctCva5YRU3dEJzatCE1WwHIO0emvASFvJxkY6jsK3?=
 =?us-ascii?Q?yH8WcEwueha9QlNwOlWmQFRnaBSt3xjTxmnsUREjeT4ydDYU00SqNu5CVyLS?=
 =?us-ascii?Q?Z0wovz5XrRXOS+IZ6PGExOSfbV2Qoh4ImxDesP72LxOSVqierGcLQWxpVngp?=
 =?us-ascii?Q?eolb38Xp7YtU18t/g6Z016j1cnCA7dlgWEGFdEyOCMKbrV6gb8mqZb9hUmN9?=
 =?us-ascii?Q?f7avxaUPT3v6r0dToMK1GdgVoUAaxi5g32miM3mfDeHUQaQ8XSqi5NBdKWxj?=
 =?us-ascii?Q?6Jb2tGsIwrjxgYq8SME=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 964b26ab-0288-494f-6b4e-08dddad2b822
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 01:34:32.3393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9XD5m+U5W4kD33FjCo35itQovRBseElfMa1VQ2z7D+w7WMpD/9ZCgDRu776JMSFcaaIg6EE5V1u6HQpiRZcOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10224

> On Wed, Aug 13, 2025 at 01:38:55AM +0000, Wei Fang wrote:
> > > On Tue, Aug 12, 2025 at 05:46:22PM +0800, Wei Fang wrote:
> > > > Add a DT node example for ENETC v4 device.
> > >
> > > Not sure why need add examples here? Any big difference with existed
> > > example?
> > >
> >
> > For enetc v4, we have added clocks, and it also supports ptp-timer
> > property, these are different from enetc v1, so I think it is better to
> > add an example for v4.
>=20
> If there are not big change, needn't duplicate one example at yaml file,
> the content should be in dts file already. Pass DTB_CHECK should be okay.
>

Okay, I can remove this patch in next version

=20
> >
> > >
> > > >
> > > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > >
> > > > ---
> > > > v2 changes:
> > > > new patch
> > > > v3 changes:
> > > > 1. Rename the subject
> > > > 2. Remove nxp,netc-timer property and use ptp-timer in the example
> > > > ---
> > > >  .../devicetree/bindings/net/fsl,enetc.yaml        | 15
> +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > > b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > > index ca70f0050171..a545b54c9e5d 100644
> > > > --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > > @@ -86,3 +86,18 @@ examples:
> > > >              };
> > > >          };
> > > >      };
> > > > +  - |
> > > > +    pcie {
> > > > +      #address-cells =3D <3>;
> > > > +      #size-cells =3D <2>;
> > > > +
> > > > +      ethernet@0,0 {
> > > > +          compatible =3D "pci1131,e101";
> > > > +          reg =3D <0x000000 0 0 0 0>;
> > > > +          clocks =3D <&scmi_clk 102>;
> > > > +          clock-names =3D "ref";
> > > > +          phy-handle =3D <&ethphy0>;
> > > > +          phy-mode =3D "rgmii-id";
> > > > +          ptp-timer =3D <&netc_timer>;
> > > > +      };
> > > > +    };
> > > > --
> > > > 2.34.1
> > > >

