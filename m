Return-Path: <netdev+bounces-207840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A354DB08C54
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239573A3ECA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D106629C33D;
	Thu, 17 Jul 2025 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BKo3G9s8"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9136429B8D2;
	Thu, 17 Jul 2025 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753575; cv=fail; b=WOOcmkZxOzgBand8SaQOSDsfbFmDGdIM2m+w55siV0cbVb65o+OjHPvFuvOh+ZiOYAW0cx0YCdtlPiu1KfA+LUkVZxNyw/wRsVng7UPFghLgeMZQwNh75l3OtSnP0JBxE4xLJO7eJr0M8gYrEytwKcmn4JXGXOetgo2FEh1n/5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753575; c=relaxed/simple;
	bh=m2+QE6Y9+th+6VITyyuMqfYQCbalYXebqsad3KLkgpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hGmej/xojAz7oXgW0FWpBAOfqT0UNSZJ2dwoOgjw2eRoMvfwjR24qie69tfzhQIPF2Gz2i55ZltxYY5q+xeoD0OaN/U/YlCJwXgUHsoMctKYt93et/Iyip2AQQW9hwxLOxFxOZ+BEp1+H2imfPQpLzUw6uEL3J182jJgxWmiXIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BKo3G9s8; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGM/elb6JY8R+VL2ATqH8VKXXtOLSJUg125lu+P0BZqWsC5KchXy249dH9H1NNc5cTSiQakkQVHKGHLXT0feXP0P/i/hO9zo9xFD3HJpQyUVPeLRmPRuzapDYhVrlw7gLqMMHBTX9+wippZTtco5iFajHynM7gqwpNwjeF47cwG9QHr60d1cpb3oB8ZQP/gRFYVJLHuqEtZJVuT0JUeaed6ag6qAEs9nsj/CJu6Ra7wRDeXGuxPzaKXXx3jQPsSQwtBn77NfpC2AWL/xpy7eUBXXB8l0D//f8aFRhBQJ9ajclNZzhdyo3I/z3ITyjsch+EdDe/LkGPrnR7IufjRYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lt3E8nPast8HPUf+DttA6X36TuYKGpcgFC6NFYJfZwI=;
 b=dh/VesgdjjGyHkC5f/lKtwENBqj6mL3eX4fNKzxWN2mEjY//gHMV1YsFX+TmB8iXwSr+HJ9/Aq0OaaBmZOXq7xULkKjCn2qkrbtxl+nRdHCjqMee1XDhF77wjsO+RAJAT7oaGYl+DmQFs1Y0++rasHjlo4cmMei6XrwnACeTnZ09LF/xrW42fHBha1qBNvMqiV6VVa+KlkKda6RlqxAByE7Zk+tuv1htpXPreWBaBd8wHNjkwmUMu2/iEFs17Wv1NIHSbKXU1oq41Qw/AbxONMXyPySe2mjX8PSIIQojmhdz+A6bD7hdFvT/KEUrb9O++dhJT9q/o1mnoj7ukyz5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt3E8nPast8HPUf+DttA6X36TuYKGpcgFC6NFYJfZwI=;
 b=BKo3G9s8n13iNFuaTqsD0lWOyzOm0cXCwu4CYzZt9AvpUGZ1uCwO5nfOuJkXPg8FYRs26+4hbDOrxVjH0m6v3VVxg3tCN6oHtTVt1W1ccBaEqBXNvIhpWRqMk1sEzRVrQ6+QA0m+YDxkcys63hHdOHz6kqzOleOLO3v+kctBWtsi9/Xd1Rc71PsDr+lEb8RlNH/rLbALSSbg+tNzcJLZ3IcerqVlc0tQAgaueIoTT6+8Z37MnPICOOcIVuxJtjFb2lgSkhgYOxr9V7jk9WKepePNS4qX1vluwuoFFVPDnmtjsXO7tVONFTIz7tsJzftBi+v43FARJGjXf07v3JgUxw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10399.eurprd04.prod.outlook.com (2603:10a6:102:452::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 11:59:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 11:59:30 +0000
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
Subject: RE: [PATCH v2 net-next 04/14] ptp: netc: add PTP_CLK_REQ_PPS support
Thread-Topic: [PATCH v2 net-next 04/14] ptp: netc: add PTP_CLK_REQ_PPS support
Thread-Index: AQHb9iZuKYxtnoJNJkq/rP1bHUAsm7Q1LcuAgAEJczA=
Date: Thu, 17 Jul 2025 11:59:30 +0000
Message-ID:
 <PAXPR04MB85101A40D9D866083BA88E6B8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-5-wei.fang@nxp.com>
 <aHgGJ6sia5Xe7AA9@lizhi-Precision-Tower-5810>
In-Reply-To: <aHgGJ6sia5Xe7AA9@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10399:EE_
x-ms-office365-filtering-correlation-id: 6807292d-f127-4a37-83b0-08ddc529630a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|19092799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vSG8TvDrphRYaRtWtVxnQT6/MxjZixs3mvno9s3gOIDvmHQCRs43YLBvZ581?=
 =?us-ascii?Q?t1X2E20HXqGJ+2kXLSuQECQ4z9EU/XpFa/ss4EVSMqwGpYJmBD9IkeeomDOI?=
 =?us-ascii?Q?ea/DHtpEqrQzUEyjadptDm/NaSBxtVi/U1qSPDp2yG6S+AZzT5GflX34vkGo?=
 =?us-ascii?Q?AjkUtKtzpl9h50Su8q8zqC6kSy1OQZKBJuWElgIEXzf5uYdpVwa45MjqQs+B?=
 =?us-ascii?Q?HnZT/fyHjwVrYFseHEmygnZAQW1EvYtBFbdhMtVQmdhmiZmcPaH6LIELD5/T?=
 =?us-ascii?Q?c4+1H3w3WcBpD5JkrDG97kSeNkA1qwyZR5Oy9t5fmBNM4b2KCGSrPTR34b9o?=
 =?us-ascii?Q?W4ORyCTRXD/tbmoXT4oJwFyW8ATQE7tsVzIQ6hlPCWIftfBc8HFdQUPOOouX?=
 =?us-ascii?Q?EQZCurs9ydGyv8cCBuYo+j2zgLkyNS+dt7lO5ZoIfNTLx0AYoWBJf4xq72Cd?=
 =?us-ascii?Q?WleplmZaZNHX2sI4CV+8MN3yUg+MAxMzf3AifFiKIUgH/KyUStXVXLPRDute?=
 =?us-ascii?Q?OD7QxjtACC7yMEn5Lgld1c2cCRRrIO7dzKUTsUNVVMbzsw+gZud9EDnUk1wb?=
 =?us-ascii?Q?NuqQyGH5r9l2tGG6LWstB80FP7PtQBt09ttUyJnKX7O1/SUsE7NfvjG1O1S0?=
 =?us-ascii?Q?6tWHsPsa50mvw/2ixQ6F/qnSRLhtG698WJQUPomfN/4mG7gRUlt8jprHkFj/?=
 =?us-ascii?Q?MAyu2PAHiktUzNKpU3Cjgawv5lCWGIWQ3FdnTznmqW4/qtha8+DfBsfuzZml?=
 =?us-ascii?Q?yAtjdW36CR8Z0UQOfAsJpF9vU24sLatx8ayIzbVVGYz7n1X1egONSGCJHb/2?=
 =?us-ascii?Q?82hCB8N3RzuhaP4lzRuipQNAP1bta2qeRL2eGJGK6Ll0YH2lx5EQPZ05zxQ8?=
 =?us-ascii?Q?YdAPBxlLPn2RN+9I649gbRkvXQnq3MMJ1OY9Wdb8GTDOEE81dMx0pbxWhHzJ?=
 =?us-ascii?Q?cLHhgzfNS3JZEr/aqGzEzjdvhmSCx4NBpfY3d9HaTOc5Fq4KS0Uq+Qf4ymrz?=
 =?us-ascii?Q?58y9Nq7Oi8teyFZxBlI86rto59DdvuA/ezAUtfNNHE4ga2pBrzBQoazeUE/t?=
 =?us-ascii?Q?2ozKjTB8A15gUmEBUGpgyBJdHz3Bqd6Vik+OrcPxNXA0SjNVjT4oNG+Ri4rm?=
 =?us-ascii?Q?ch7e5Fs0JGm5+zCyAeJHD6XXBDfDtrelfEmMz6foX/VmhiIh2P88jjszBRX5?=
 =?us-ascii?Q?W1kQPGmH4yC0+efWcLm6fva1ZmZ5nAA29tYXAykWPEPwZBhjjZHzCJSgItrs?=
 =?us-ascii?Q?RuEj4sh+eMRYzDFG5uZw0M27j5GKx28affE+bTjv/vjEtfFE0RfQqHlqNW9E?=
 =?us-ascii?Q?SzP80n/LjGsxbPvtvLKr7CqeuRTSvvcOWRaZsQzTp+oaDkqh6rWFXptEFZ3z?=
 =?us-ascii?Q?uSeuobDEPcjCRu9X+H3QIolM55SyDBNCsOm8eDNTBHxnE+jYy2QcHT7P0O2U?=
 =?us-ascii?Q?nVzU+/6eQgHGuFqwdDGutt+bFtGEkNSN/AABZxBoJk5CdzByDKIHXw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(19092799006)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZFQLrIu0w3sxLb2OcvXwZxMPZv9hTS9eXyZBz52Yzygg+vTph+tAzWz/LB5j?=
 =?us-ascii?Q?nok/bDEDE2RqV1vLsbgN0uMqtEEH5KfHVtysF62SHMIy2trOtIf1jOdIXa/T?=
 =?us-ascii?Q?wg4pr0X8pQyVqAPI3VlwQVSRtor3igmEzE5cUp8mi/pmhgu1lc8C42a6jL65?=
 =?us-ascii?Q?ESanGwzifC/yD08WCEkt0u01sQnn3YMGgKbAyajm+N3Z41D8Nd4iq8UP5n1L?=
 =?us-ascii?Q?EOayLzQI7u42RwaKp9sWNuOHjQea0ibX1uWsNgIDjs9Ya4DMPDXSySgXmAZU?=
 =?us-ascii?Q?q9Qww9kf6dgUkcMf0QfyY+6JWrzkmNYQaIv9Yi7meQRxV/stdxIeYLFlXNoX?=
 =?us-ascii?Q?l59E4eFB6Lwuz5OPfSSVPT6TVLgT6WVWHZUo/si/s7JBZOngtRdUb1pynn2I?=
 =?us-ascii?Q?GDJHv6dqOv+rncGGeKCHcI2JOCQHdaH07s5K9o/UlcCyAfSxaTTv3KtNUrCm?=
 =?us-ascii?Q?8tXpB8eWU7hwpabBId9I5hyolqBYXJutT2IPZoEpobWvhx8NeQHTCKW8/V/A?=
 =?us-ascii?Q?SfLhg1R5q0ZYrmRSkDXEXO5wDSj0K+tiOW+q1f1ZjHEISPVZwIqVGM9jTMef?=
 =?us-ascii?Q?2Vr0NL37WYAlgbRaVVAHBwcguWThz8U2uQ/1ij2HuAYSjg41TwxA/30vN2Um?=
 =?us-ascii?Q?qqBX8LKJUGWTEYBo7I2YkkakiwoKG/VRHPxE5oEuD4G1N/iGj91jYjQTVEkQ?=
 =?us-ascii?Q?3c5iPPCTCog/xQFjQDnF6Ss+Ts/XQh8zzin/RWuvTbXwa0kt+JT/774N5BGQ?=
 =?us-ascii?Q?QomfSvejkcpfYCT1rltzTFCkMFvIFNKSZBy1tac5SHtx2VA5UE2PEhZzTLQ/?=
 =?us-ascii?Q?AnqbN2/w8T+W+ENjMou26d3NSvs+RV9CD9L86nGQHH24a6rVxEpBzIKcZgWd?=
 =?us-ascii?Q?nLLeSTeF12wTqarOJaW3NBuzfGJOy68NEO31/M+2Cxtfudov1NiNKZn1dnAe?=
 =?us-ascii?Q?FjF3i5aWfTrC6LJYaAb4Gd34GgswOkfeKlI4RPu6fRB+wvSZy89DlIu6GW8Q?=
 =?us-ascii?Q?a0iTUr8DDENZPq117mmeqJ4ZcnedUwrrLKpuYk4r7coqiiXPb6rPArshKmgw?=
 =?us-ascii?Q?MeeAG6zxkD0+ahal7WdeeTFve93wD6nhYUOkmM4Kh4lza09vGvApVlNCONPx?=
 =?us-ascii?Q?zMl8kWOXHAys9gff/4fNSmD1zbaC1m6tilEwoDHJYQIEYNpRuEEPUnF97J+R?=
 =?us-ascii?Q?IR7TxemIdhT2Icrp+vp9CiqmD8gHzsXSazDNOo51sfXeRd9kjS6+vZ2jlJm1?=
 =?us-ascii?Q?v5A5LQIcQXjoPM4c+9PHx7KgSEeNr6hRiGhzgIOlVBD7BPhoJQEfsMVua65e?=
 =?us-ascii?Q?7GhnXizoJ8tCUXPTtwytjH0/KAomKuZOeGBxpXkYqKFulfqHrD+/deia/l9n?=
 =?us-ascii?Q?gItOZXwDCq14Bo/LKbZ3syzaQw7pdW9R6EVIiQ4iZ9uDIR7279KFx/Htt5Ov?=
 =?us-ascii?Q?sQxpXI1kDHT1SZ6qvhQmWQJ6uecM5im+hUKtCDZR9SWG7DHtPbHmlj47t3CG?=
 =?us-ascii?Q?aaTYb2gWU++HcZkgI9nfPCgWzdeQ3nshtTrbCMLnE4BP/8Rt1Dl0tpxM2Hk1?=
 =?us-ascii?Q?Ar7DxRYoN0XGxD+h5sA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6807292d-f127-4a37-83b0-08ddc529630a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 11:59:30.2348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9YMyEAMhCHR+HzGb8SNWoVHNtDis/I1EUQ7zVuqkE0IPS8l0JD5tTxZZvevmKHd64hGXYKmbd60ykpNud99JTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10399

> > +static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
> > +					 u32 fiper)
> > +{
> > +	u64 divisor, pulse_width;
> > +
> > +	/* Set the FIPER pulse width to half FIPER interval by default.
> > +	 * pulse_width =3D (fiper / 2) / TMR_GCLK_period,
> > +	 * TMR_GCLK_period =3D NSEC_PER_SEC / TMR_GCLK_freq,
> > +	 * TMR_GCLK_freq =3D (clk_freq / oclk_prsc) Hz,
> > +	 * so pulse_width =3D fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prs=
c).
> > +	 */
> > +	divisor =3D mul_u32_u32(2000000000U, priv->oclk_prsc);
>=20
> is it 2*PSEC_PER_SEC ?
>=20

No, it is 2 * NSEC_PER_SEC, NSEC_PER_SEC is 1000000000.


