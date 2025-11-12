Return-Path: <netdev+bounces-237806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37692C506EE
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 04:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83E6188CA3D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 03:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF7B1D5AC0;
	Wed, 12 Nov 2025 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="LF4ZfE/O"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023080.outbound.protection.outlook.com [40.107.44.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90335CBA3;
	Wed, 12 Nov 2025 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919131; cv=fail; b=s0DTzIuho/5HnAxfB5fIMlu6NXOg+FVR608MO3m2BH912cDGLi1hZnvWnVAWvpEJcXFlKhz97paFNG5g7ccKkKiGBqEiiQcUrlSoDe+JKlQuJkabnnjWGswBa0dWJMXChRm8B50FZ7jHZU7Jap6ge1rfIhHIOnFwUMP1w7Qyd88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919131; c=relaxed/simple;
	bh=J8X8OazPSPJggTjHLr9r86MYDNpp1kNrMkcskWrfEdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b6jRND3bQYEKMG+d110tRpt37JDchrPgzAH5Lj3U6FoOoc3L/um2UrpMCTOs/UR7CWwdr3czMe3BmeoX+0UxsFl9WHOkALJowvF1YzkAdC8KsEKI+MPO+7D5SHVKG/vytWnKDk85Gvvw2wgU98iE0W2HRRG+lIrcNM+neLtACIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=LF4ZfE/O; arc=fail smtp.client-ip=40.107.44.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSa7JJAI13j67PDi4Y+ds+C3ZB1Q4s24ATCfog90xMKqAj7uhHOh3t5rSKJlxQioa+MvxMn8sAqJ/OMSt4XQKBBOk2hajAtgtPhDPOaEiOIDZD53/EGwlC6WmFLmIn2VSc57LK5H5lLXfpPKFBY+M+57po7ZNSlFT0x1nlpllxrvlKD7gI346HGmnkPoIJOAZA20BhiqPsPHtAOaM8iimSIuftRUrkX8MCnECgQPcGl+plC821QxIDupXhM1wp4imEA6tgNHvD45GuuiYg5Fr7K06RD3M9oC/5k/zk6fQjo/lmKf30x+EmIBStJWJtscOHpKaaZD7NZm6UcKOf2nkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cQ5E/HjbHLANNGSa0Xiks5Ouj9LdjAKoH7zxdXDfIE=;
 b=Q2+XiVIyZwirSj9gz5pc67fxrdsFgS04xmnTsiLbcWbQwB5l/wzqrnVy5e4argb4+slqqZG/fgIn00zZcZJYXBqc2eGYmYExNQh3+kGiPcpQZJeMf1wsdfunzWvOID8B60y2bDSseH8I66iwbhgqmgkQsLKWCANHcAidD2kXURz70EULk4V8rEE5RsfweBpVX663Rp6DQl1zjnsuhmFrzseNFLJIv/4cl+/MMU/crkUyyEukDB7UXSBv5SOVEGaTlB/pyxSZe0uPlBFCjgttzmGlq3taVpXCegBIKF0eVmQb5gvaggiMiJkGuFLIlIpwTHo50Tfus4+nXkQ/vVuoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cQ5E/HjbHLANNGSa0Xiks5Ouj9LdjAKoH7zxdXDfIE=;
 b=LF4ZfE/O2wGTxS4GtiVn3Amub3NuFLNjxOJhvBybsXwHk9BHmMxFuPL5YIy1+Qcm5Vl8qZrEPVjLcns32lSGzv8PBJnSojKdj0ufD8w+UTHP697JX5o/DaQ2D2igHauLNm6QtCGo2mesq3P6GwS2FlBZifBOZipJeQtInDLmQnshmcN91CvZdrPGmX1gvmVd+apfeWWfn/nD7N6db/2rW0xYt6X3YSg88u9eUnJ4yJMNOlX09prrV+KRrEr2VwdJFSFS1LEAR2zf+nzWuJoanoPTDTn0Fm29LyQ6UDgSfu1QdYZX1m4vxc0OFgvLz4/DiKxtn977I/856UNq0cmmdw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB6088.apcprd06.prod.outlook.com (2603:1096:101:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 03:45:23 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 03:45:23 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support for
 AST2600
Thread-Topic: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Thread-Index: AQHcUjKRp/5wUPPeG0Wo2Pz9fS4A+7TsCtCAgAJeVpA=
Date: Wed, 12 Nov 2025 03:45:23 +0000
Message-ID:
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
In-Reply-To: <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB6088:EE_
x-ms-office365-filtering-correlation-id: 8f473c3a-84dc-43ea-d427-08de219de8dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8Je+0FVGvFLMRbHkMqPwmglCztHUb0Y2iZy8osQ215PwESZ4YuwyB3BhZ8jC?=
 =?us-ascii?Q?TqPvJll/W45H/HbE86gEnYHV8CrJ8i//EqUoBVJF5sn046q/y9UDSHc55E25?=
 =?us-ascii?Q?gEiikIZanKuo84ziADp2PAV3xX5HnoOzZJn4gpXTJULmAiAScUpGFCfVLmjj?=
 =?us-ascii?Q?0O/tBPAtZK6n3iFYcZK2FbVnPYke5XZvlRU8k4WCDe3ojV8+2z7dnulK+cVm?=
 =?us-ascii?Q?VibT+ruuPCPKVxjjS0WCqNo6Pi3LM2Tce6M+EpMZy7vI7/gzRXsZ3R6UjNmI?=
 =?us-ascii?Q?x1SMsdhUMsOl7Ibs/yM7bEwMk7ELBjJM2jBkQC5YMPlShQYyhvw+ZoSgAme7?=
 =?us-ascii?Q?4GrRvoK7nvAl38CivaOTd1B9xjsGLL5P5q9cu9q93OJlMmanmbUpILfpdrnZ?=
 =?us-ascii?Q?Olt46vDwst7CcvO6eTYHUWR1gFkfSbwtugAz993XZTloMwgpm9eD/hFPIMxq?=
 =?us-ascii?Q?4VN02bOzqXR+J3cDWWoKQyYbeY+6cG5OMa4wdtzzfIZKwHDev1/9DcAQEQvw?=
 =?us-ascii?Q?jzO8/vhTwjUyhqvvwmfbDTm7McCrjSpEt5TnLetg15Z2tgcJTLZnwgXMKcPa?=
 =?us-ascii?Q?bav8Rlvo/5gaBgRwz4q56Dq2HGziA2dr8h+4vtG7O5X8gb9E8LKzFXeOGUmq?=
 =?us-ascii?Q?Q7+AgwF6kuQlPVGg20EhxxU9QGUpNInbI+889fXRhJi2iIpbVUw+hBnS2v/8?=
 =?us-ascii?Q?GB1bt6DJEplvjUPNR1JGCzUmdEz4SbqOuKHH7hkKnSggzq541OlZaX4VsKWi?=
 =?us-ascii?Q?CLvOhGCLBrb0CfTQuBhAHPQHfXRv9AIc6tOhfJBiRjajcs8ppLU207v+iDLv?=
 =?us-ascii?Q?1zeLSAFFTT5BynSn1r49dtlGlqkcSY00rbvExAWHbsaFrKgGYDV0ChzupSpw?=
 =?us-ascii?Q?5IeIVR6mXFtafp4OWbkyBq0HIkK4iuQ14QHExlDHODhXZGzvsGzBLw0bf4LS?=
 =?us-ascii?Q?+yDjlSf11Y8MfM8Gtz1ro+lUfLFwb6CFukKeonqk2ANoGK2y1+8FXQr6Hf/i?=
 =?us-ascii?Q?/XIXL4ZqLJYajLQHxKAt0bJAsIhNja0d5bXUoyJDrcgELkrmFa5yUp8wjy+X?=
 =?us-ascii?Q?HyiAaPDvJtyHU582JNjjVIKD7ieOJQc9FOxoTHD3sQ/v87EOfuuTJGAUp1ib?=
 =?us-ascii?Q?o8zAHwNtTUIAO354s/kAuUMQMdmZe2yAI0yhYUNM8W/q+Lm3sncvWU42scyw?=
 =?us-ascii?Q?AhTJU6SulMkMNA6VisHz+ft86+ZWy3sFhb/pVifnioxDuIEhYODZofs81I6R?=
 =?us-ascii?Q?I/Nb6tyy6SvfhNxw1yD1t7XqIIgnv0F1GUW8Z66zmVc4fN2xyRefTs2S0OV/?=
 =?us-ascii?Q?0uwBgqS8Fu1BI2onqA+HDn3jzoiFyeNZUGUxYhTUk5t7S9RBEgpfpS6ZQfDr?=
 =?us-ascii?Q?nqfGhXJXluoVMj5tGV+aO58c1qCdeZvWKjp4A7lRl2JPxOZ5qrTFaBG8KSM2?=
 =?us-ascii?Q?T3TnFetbmeR80HMOdOVbB577ammlrpG4o/BjPdhs916VMQL5lUVy3FlQpjLe?=
 =?us-ascii?Q?yWmwtrPUwSDShGO37r1rN11REdxP3EQwCJjU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BXe9MwUTkPdqAUb46W8e4cXxcpo5YucZCiEL/lHG7n+7BhURvKfCTjQAOM1J?=
 =?us-ascii?Q?f/nSR6zjNWniLa4fcHyFjPBEcba8ERCbcOwv7L/Lk4nTlwalBumUaMnUmUK5?=
 =?us-ascii?Q?0oFHYkG4pUKEwsJmqtpj7qL2wp5HR1/zSQOxbi312ZsqeiDae+5MGC/DwMer?=
 =?us-ascii?Q?fMTWMeYteWLLN22kOD1/PyKymvXTgkYqWZIQhdhi++euGWDNo+3ZkLPKO9eV?=
 =?us-ascii?Q?cwEBRnQ/Z1I+hxGtzNGN3w0pVVP2wr6eaidSjyg+Jer+pWwvOMGg7y07Co12?=
 =?us-ascii?Q?8Q82axi4sCshEwUa36eDK9J55q3ZVXj51Z7o24XEDtFxvjbLQ2FMxnUqDpNl?=
 =?us-ascii?Q?kRbqZeE2WOPe0/He2mu4Bt8VC9OefD6yICVLodikG+0oASXnPPdN5KHN0fKS?=
 =?us-ascii?Q?imlg7mxc7jDx5MkzAv37E95VkydaF5k9d29viP79PPLS1cp4nj6CaCdnn7Ap?=
 =?us-ascii?Q?L9tiQrlrPbJyc8wy2mMLmkKIkoaArE+slP3PuZphRuDpRVe98fL3AHwRsn8n?=
 =?us-ascii?Q?r9E66Uzv2J3HiqdQk+5pd8lOihV7KBAYuUWxd2fyUa80NT+ZwX/dgWU8Mja7?=
 =?us-ascii?Q?ePV26bSBEiwvsQPNn9LILa3Ari7sWZMXFgUhVcYsoRLJc1xDZIKrKKC7yWh7?=
 =?us-ascii?Q?uLB7SvB/B3G64zfcZPFZUccFL9NWKjauNDczzzcuTHmKlB/e3uiAbygOjoQb?=
 =?us-ascii?Q?7fALs4dYIOzQhkjE3VfNLmk64LRqjqZNfbcdFUwYeFmAp+6Cx4boqOZNg8/p?=
 =?us-ascii?Q?s5jS7bcBoMCCHm47d1xTYpA9nnFa/NbMUxPquKnl/q3gINXDFknpQgkcdv8Z?=
 =?us-ascii?Q?9DSI3xxwsngYGb6r/cvsiLtrwvcMzhIqborO9QFzHViNol2umOAyHCo2OTYB?=
 =?us-ascii?Q?W9tQF1fYvNqmxEWsyKIpjlIxrU64ItLfdajleXhJSO4NemKGtNIB8zXR4uQN?=
 =?us-ascii?Q?15prZeF/nfuYOvKxcsnTcfbB8p1iN6uXeWP2vcKDz3J5UR0qwfE7yRpnIMtL?=
 =?us-ascii?Q?VzobaNMA9Zs060U3TGNa1GsYUt2xcdnToGcswrfQOTOMJ2diPwqbxCrUSRPI?=
 =?us-ascii?Q?QVGhwfoi++agGLp3DUqJkWic+QM/PipIgOwfGHVMMtTZqBAysgXkBxQEF3pL?=
 =?us-ascii?Q?4eqmGuE0nvOf5PKYzUWB811mghjWUKTF3h0Mwee/kqcp2FPcbPy8tKskmV42?=
 =?us-ascii?Q?/NyJHU1CJjviSCRHQeIKmbx94f69ZJXAhfiq4lv4MkAT0iLRHeCUGv1vVqgc?=
 =?us-ascii?Q?dFBS9mNyCuNmR2WDV4A1XWeiF3CYGgKXD88NyLDY1JwU5ayoFpa+qiyqTUhN?=
 =?us-ascii?Q?qLiYYRa5+NuUk0ajHDhndx1OdyrOo9ZobWHQy30hrfj9svKkiRk2pPvm94P3?=
 =?us-ascii?Q?skPR3WpsDh7BGDF+w0gWQN10QQUGXVLUE7mfhDzd6tIESqSXtpi5sJLM9Wji?=
 =?us-ascii?Q?7T4aWwwfnXlWjg4Eh3jXDYNxKjoTxcJYemG79a8fcxKeDtaRFtQ6x3kXcA3S?=
 =?us-ascii?Q?IGlYJI66DONzwxOm4VJ5bIH2XnTe/d9U044D3i/cSemk3APPBfsuOcP2lFS5?=
 =?us-ascii?Q?cDM+JT+LpAM8N0EWMLw/qCb7K0sFk1NspuIcJArB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f473c3a-84dc-43ea-d427-08de219de8dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 03:45:23.2984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNl4FaijuCtWz1GzwmzK0WDM+2Gr8JW6vHJiKLFEiQMP7OOjGlqmhEyA6CTBb5C8wdgUDPmAL/uNUfwihnGTmAHuZ0vZcHUr2fBd9jE7gg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6088

Hi Andrew,

Thank you for your reply.

> > +	/* Add a warning to notify the existed dts based on AST2600. It is
> > +	 * recommended to update the dts to add the rx/tx-internal-delay-ps t=
o
> > +	 * specify the RGMII delay and we recommend using the "rgmii-id" for
> > +	 * phy-mode property to tell the PHY enables TX/RX internal delay and
> > +	 * add the corresponding rx/tx-internal-delay-ps properties.
> > +	 */
>=20
> I would not say that exactly. Normally you don't need rx/tx-internal-dela=
y-ps. It
> is only requires for badly designed boards where the designer did not cor=
rectly
> balance the line lengths.  So i would word this such that it is recommend=
ed to
> use "rgmii-id", and if necessary, add small "rx/tx-internal-delay-ps" val=
ues.
>=20

Agreed.
I will update this comment in next version.

> > +	scu =3D syscon_regmap_lookup_by_phandle(np, "aspeed,scu");
> > +	if (IS_ERR(scu)) {
> > +		dev_err(dev, "failed to get aspeed,scu");
> > +		return PTR_ERR(scu);
> > +	}
>=20
> This is an optional property. If it does not exist, you have an old DT bl=
ob. It is
> not an error. So you need to do different things depending on what the er=
ror
> code is. If it does not exist, just return 0 and leave the hardware alone=
. If it is
> some other error report it, and abort the probe.
>=20

Based on this for next version, I want to move the "aspeed,scu" from dtsi t=
o dts.
Change it to optional and accord it whether existed to decide it is old or =
new DT=20
blob.

Thanks,
Jacky


