Return-Path: <netdev+bounces-207767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BCCB087F7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD541AA37F6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED786263F5E;
	Thu, 17 Jul 2025 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VEE6M2u8"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2223B0;
	Thu, 17 Jul 2025 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741164; cv=fail; b=E38fkafpmT8iL8z3gSMD2bwLlnw/48Ll+n8/tg9ZwneJtY7MqhNfEwAPwPxHU4vj/DhGPQ4UipKcX1lXOwtZepfLASEvlpS3R+EZTXvXG0txVLdTuh0dDBTwAbnoE/DJ1MT28rWMZinRi5DZ6nGWmaZo2nC/ug99Wf8NSdqpC+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741164; c=relaxed/simple;
	bh=IdbkNE4i++744ZuqNPOdGvcSnhzMgExP3rtRQW/OrBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VZa58lAx665Va9iObpEEyWGsHFWVK/lPt4i4Ofv4xcu6ZNpm7vrpseiXITRFK8Uwy9HFGyAr1QlzHLbRRcF0DNMLzjrSKY4PbtDXgIk4X7B0gXfEBiO3TDiUbqAwlv8xSfLhR8xphpr7+CvRaGvlsz1T7xJVUR58xy4/LiQFmNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VEE6M2u8; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmfUVzq2TYTcp+zW2FwuLXeF27GXZIfYHkp6m864ip3TgSg4oapZRLqL+17pNeG6ZshIqQX3bKCKxJ6rJ9wAbSkPQQtufsamT3p+iQTqL2Yatkr+S1eb/hjzXGTe8Y4+exIsrqT7vJFy0ueUgZbIcPQ7pAgm1tAVf9og0Hj/Ol0PBWqmppej6Pdi5CpqZxgzjEcTGY44nuDLlQAu7+Ytl2Mn0laj8XFh3Oyou4PDCA/2cXJYdQjIxMNMg7DzMuZCnVXvxN3DOphQy6yhF8eOo7zr6hw25FPZBkAPRI38VGgPnNlpBiwiXe15aAE6q7EEC8jlTEHgylpy96HepalD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJHsCHVdqFKjJEpLDmi+P0cPSiG32SDnPEDaenlWpbk=;
 b=u+EZrWNWLG4O3akAXJoFaYn+zHUDbkWqptu7WDqIBtRXGIodpr7xv9fSvBeZi2+l4GZ9ZCl4QcjX6/KzlURxfKOShwQ5iBtvWlJne9C28um5L3chPKX8UL2BYRwUo8tjZjGuhYa9QEJfIuLmhE9nFxAudJsa0VJ507yknnNXh9RXIw8UUH8QAJOWiXhoTWyeEo9XRMW1I9dZsFy3GaP2zQ6bGXMwhXs7DmT+CIO524XlO4lWaIL/Jwi1EdYLNk6n8/4ElweHd58W5b1HEwbMoecdrvw+16ELpQDe5O4LTsKqEZIplo1zFyT3d0A9H/jAtnumiYQuwX2t7zbrknQztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJHsCHVdqFKjJEpLDmi+P0cPSiG32SDnPEDaenlWpbk=;
 b=VEE6M2u8A0d2oJXUI+6epbQ/dSgR1Dthg3sitxU07eZ/GhOC99fTCbEmFWLJ+tBt1/xtB1xdvN6sekevCSqP5gZlcWuF8Tk8oaxP/vqBn139n/WUjeIzWaVthp9yDo1osL/PY1RNHceyAWLmdbzBzJ0nqXIH64V0aKxBmxAkXnZjiyixyNtlJ5ARtFHhgffA8v4u9sNBBOQLGbOhNj5/xSROdyUa0GEiAVltGvN85ZJaaZtErUfzfeOvGLnJQ9Pk9xirMClxwlKiY+6zLBK1w5ptewnXeOpZnKCgOr2I4p8qlMt/nUhxt0MrPadmOZ7ILXNHhPxcoyrsTJLpqJsDQw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7403.eurprd04.prod.outlook.com (2603:10a6:102:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 08:32:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 08:32:38 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, Frank Li
	<frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Thread-Topic: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Thread-Index: AQHb9iZmm/EQyWHMi0uUtvbMzlnJDrQ18GUAgAAJ0BA=
Date: Thu, 17 Jul 2025 08:32:38 +0000
Message-ID:
 <PAXPR04MB8510EB38C3DCF5713C6AC5C48851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-3-wei.fang@nxp.com>
 <20250717-sceptical-quoll-of-protection-9c2104@kuoka>
In-Reply-To: <20250717-sceptical-quoll-of-protection-9c2104@kuoka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PR3PR04MB7403:EE_
x-ms-office365-filtering-correlation-id: 04812b0b-e97d-46a0-1a7d-08ddc50c7d01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZDgVl1lr1rTUYNqsAsExPJ9ahc7jET2bKcCXAwMSjby9rmxfvoLpm9R/Kaa+?=
 =?us-ascii?Q?Vd51m8X9b9Pom7bG5IdQw1AXCkKP9Ij38IeQh+dQqfvmIsm7Uwq/k+8g15i+?=
 =?us-ascii?Q?XUUt3hJ70isEjbM9pqZUaL00lLYWVcYUVsnh5oAQ3hEcruguOfe0qbDX17ug?=
 =?us-ascii?Q?0Oj105kKVyk/P1BmeBcIprlMQ0uFVD16wTZCevD7JDUVqCoSibvKe5jGZvmU?=
 =?us-ascii?Q?d0E7RAIakBnsDA8aPNc4cPAyvXiTqUAMpVFHBbP2GcDB5uVVBQCaSb+aNj4G?=
 =?us-ascii?Q?MsgpkvbBeoR2TyokWBA4XAIbNAultWnZO6eQAsv1pl3XO2SGgQkETHv9jVNj?=
 =?us-ascii?Q?OH2hZTt7iQjU4qXJuxIGeNUC5LGVhzMY9iFPE+WnK9BQD+DQafvZjxb5q0u9?=
 =?us-ascii?Q?Wc7eSdRZnUWsl9fDeqcL4liwN13P7/2AHn1jO/vcJmff/aED6u5zOAEqyW89?=
 =?us-ascii?Q?urpr4NQ17u/E0xFGx3NMreOrD+HiJwMoU7oQ350tKnLc19qKJRyC9hgL7v3w?=
 =?us-ascii?Q?cBBATVv4BqHi7sB23ZKI0UgQ+BXmPP9NyZdnlK6YfR7CNAVDGm+2R9wg5gxL?=
 =?us-ascii?Q?XifnnNH5jMULQcq3gYMpgGyn8lq5N+wqmc7+07/8yxHPpLDUpsEglcVs16o5?=
 =?us-ascii?Q?5nE39wEL5FN20jm2kfVC0fs+k2pn1ifdRFIrn13YFOJ5LDYpojKAm0l/vOx+?=
 =?us-ascii?Q?DG4zRgP5Y1naWPTi/SjBMisAJ4NFZ/YN3lOL4h34sh1toawWMQEd3lkVu0QC?=
 =?us-ascii?Q?UD2QA8ACF38+dz2ULL2yrEOwgtmU5wrZncoC9eWvM2GhbYEEINiHuOXei3nt?=
 =?us-ascii?Q?BjJBg17E8thOOAsM8RBGaazEP8nU7vkEft+fZQG1o9PAGj2+wZ/TEd25BawD?=
 =?us-ascii?Q?gRxBgZjT4Peg+cfToBnoWn+nXJb2CDsf+MLnAo1JD5o02vjz8aQ+YA1KWRov?=
 =?us-ascii?Q?8X6LZlAqhKeYh1eoYWXu03FzYlqNcF+AWXHILM/fZFh5nmgsZRZI0docKMJI?=
 =?us-ascii?Q?b1n6XHqCPH3+OYKxPyS5KkaczNdK5q1wJl+1FmxSvAaxTEfM3XWeSdU/ePjI?=
 =?us-ascii?Q?UxXSh6qzrFu4iHYyGeuM654nlx60Turs4Z2bGeufxwF7l01lRsBEahyIPnUB?=
 =?us-ascii?Q?UZBaOmUv56R5Tp60Of6Z2exKh4lXXckxqTw1Y0ciEygf9NrJ2dI4NAY/WmSa?=
 =?us-ascii?Q?oVcukQwUQsYDbPqbE6EniEJ2GG97JQuyewT1DsiD396808fNwNxK+Qncjwl4?=
 =?us-ascii?Q?wv1rQO/NpevuWEv8XU1fB6EHRAkaRuTmDVR0JOUnK3xZ/FfVeuu7igP/YQLs?=
 =?us-ascii?Q?wT3408BxqHx07OREvKklNCVlCx+zezjb2MBu8Y6/WQNoPxBbhnRduojfa3Nu?=
 =?us-ascii?Q?K/FKMD9REQuZo514Tb++hSVYFC82dtkIoukSXGQ+rUYec2yqpyAmVwHXx687?=
 =?us-ascii?Q?Zfw13c+m1kHZtXD4rmFCdXyyZCvjKS+0tVL75jbs2PISZth1Sz6tJA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TPq5LfCg/8fDAduplH8zM3pMjrOtwoysqCAo27f5DI3D+Pj4QGufJFPCEXgu?=
 =?us-ascii?Q?xUQ5+Bnn8zCAmS48h8SHRXl9BLGPDShiZIp2qUJ8ckmWAERgijAdWi6uAxIj?=
 =?us-ascii?Q?9+dEfnSnLOrXoz3o9fZqNGY/RNPyuUd4U3BXOoIXPoC1S+kfPg2s9DABUMZZ?=
 =?us-ascii?Q?OckAT4oFmzDqh/PC3v7QpmROS+XCoPvC38n2Oog27iv3zCcjbgkONnTC1eFt?=
 =?us-ascii?Q?5c1dxk+ASCSMo+RYCJs/FR8cF+XShq/qVjp/7fYWT/1gAAwl+yCis9J/DC1U?=
 =?us-ascii?Q?RpG3ekJJt0RiRxVw9rDVnSyPuxYhMHkebeCZGbxVOGmkLM3I07I218mFUrbc?=
 =?us-ascii?Q?TR5mM5UzCmXqhg+W1qNVMfwSK2BE/qzCE07hzLP0do/fOKicRrTfXJJtRUje?=
 =?us-ascii?Q?DWIBh843MypYm2IPf2ffIYXvGwUmt0me5TBiObhR8kkTqchkzIvtjFx0tIV+?=
 =?us-ascii?Q?PpskKw8HQU076vKsvvAh4x2Es5PG3z/j8IHQ9aIOYMzw2XRha9vxGqBUU2hO?=
 =?us-ascii?Q?0vUhH+5t+oiztVpEcUWPseIiXFTLIC9vCQbCvGKSdaozzgaARhES1hK9HG/w?=
 =?us-ascii?Q?VXpAJyBEabMHLAZkE1OWyAfBImxgZzQwsomjXGA5gv07mka+1xG8jexV9ArN?=
 =?us-ascii?Q?bjefCdh8w/94ldpIuUUgscsG5noWtNmr9B1VIh12dXj9BKljEBYhMLumDvBR?=
 =?us-ascii?Q?ge6GBIaOW3n8K+hZ47IptmliYa436Wx3zm8Z7mfzfqwbwJgpdb3Oczc1Z/P8?=
 =?us-ascii?Q?IEA1WHy7dlkTB3CnX3KBAJb6iacLvRrhmTQsOJ6D84JuAYurW2F9N/8ZEdG8?=
 =?us-ascii?Q?yjdOGxH5ij/PCWpSMtQlYhA74vuW42AVBJfvgB68YSwkiswCV3wlrQQquahd?=
 =?us-ascii?Q?+VdZ9tetVCNu8qV/fnDoI63ilf44hySvWlTKin1NLxE7FlgiQ+S8pkFcTO9O?=
 =?us-ascii?Q?XtDoGmN0zTEuUqCMlFBh7dps/wR+pp7sQOqFmLJ6a+mRX9RFWJcondDIJ0tV?=
 =?us-ascii?Q?3BAZ3dbBAM42E2xMszbZOmN0rjpdWPWgvv2kwAMKkfyu0ZLzWbMGQiq4qEpN?=
 =?us-ascii?Q?I2YH7HuapJPUmATEFimtG/O+J80oouGtS9OqUvMydaeJSm6120cm/fLKg/qj?=
 =?us-ascii?Q?SDF/Krq4+IRkvKQxovmRIJKnZrCPKxHqKV8rtBc9hYe7vbIZPMuMVz8/WyRM?=
 =?us-ascii?Q?m5FUeD20AsSU/NQT+mOdv2bI5TDaKzVUHvknfRB0+3FD4da23jLPLFesjGPt?=
 =?us-ascii?Q?TPj9lflxvmX1+yp0OI58yJalweW7+ZKD61lYt4JCdqsI0Eo2MagX2N6cyRCD?=
 =?us-ascii?Q?Y+vWY3q7GmBe0Ii3Ee3jo+ogMl0SHuLaDN5LXwwFU3itThMKkjfVbkNGJ0Ah?=
 =?us-ascii?Q?LOdoeYUCty9nKFGaMPUGyeN5HOEt+aXU+y3w+5AnMUMqoGhpEWFM36+P/sAa?=
 =?us-ascii?Q?wqgBETCmFwmQC+MzsBww4e1Pz3qne80jCEj9KdIK1wNEkn4hR1O7RsZqACG2?=
 =?us-ascii?Q?9rxBgMLYW/9Iu6nV+oakoj7AUR8POjx2yPbmpixwdSvMABnuCYl9edtsMDWk?=
 =?us-ascii?Q?nnnj3dj22VF28t93w+I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04812b0b-e97d-46a0-1a7d-08ddc50c7d01
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 08:32:38.3728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rL93G0D4V7M4IxijUc2/1qOfyx9DoVovCTAmhEo2O8mt9SGKRigqX1D+t7QXy4vNwQzSIA+fxs9GboLLbK0p0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7403

> On Wed, Jul 16, 2025 at 03:30:59PM +0800, Wei Fang wrote:
> > NETC is a multi-function PCIe Root Complex Integrated Endpoint (RCiEP)
> > that contains multiple PCIe functions, such as ENETC and Timer. Timer
> > provides PTP time synchronization functionality and ENETC provides the
> > NIC functionality.
> >
> > For some platforms, such as i.MX95, it has only one timer instance, so
> > the binding relationship between Timer and ENETC is fixed. But for some
> > platforms, such as i.MX943, it has 3 Timer instances, by setting the
> > EaTBCR registers of the IERB module, we can specify any Timer instance
> > to be bound to the ENETC instance.
> >
> > Therefore, add "nxp,netc-timer" property to bind ENETC instance to a
> > specified Timer instance so that ENETC can support PTP synchronization
> > through Timer.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> > ---
> > v2 changes:
> > new patch
> > ---
> >  .../devicetree/bindings/net/fsl,enetc.yaml    | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > index ca70f0050171..ae05f2982653 100644
> > --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > @@ -44,6 +44,13 @@ properties:
> >      unevaluatedProperties: false
> >      description: Optional child node for ENETC instance, otherwise use
> NETC EMDIO.
> >
> > +  nxp,netc-timer:
>=20
> Heh, you got comments to use existing properties for PTP devices and
> consumers. I also said to you to use cell arguments how existing
> bindings use it.
>=20
> You did not respond that you are not going to use existing properties.
>=20
> So why existing timestamper is not correct? Is this not a timestamper?
> If it is, why do we need to repeat the same discussion...
>=20

I do not think it is timestamper. Each ENETC has the ability to record the
sending/receiving timestamp of the packets on the Tx/Rx BD, but the
timestamp comes from the Timer. For platforms have multiple Timer
instances, the NETC hardware supports binding the specified Timer
instance to the ENETC instance, and this binding is implemented by setting
the registers in the NETC IERB. Therefore, this new property is added to
indicate which Timer instance is bound to the current ENETC instance.


