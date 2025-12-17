Return-Path: <netdev+bounces-245112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7A9CC7018
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 11:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1174930C19E7
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0625733EAEC;
	Wed, 17 Dec 2025 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="o8lPRnoK"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022140.outbound.protection.outlook.com [40.107.75.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A9C345738;
	Wed, 17 Dec 2025 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965797; cv=fail; b=GwxThDCus1KL6YbBH3SiI8pxmT0KSsIAL6vHHI70GZUOWQdr5HMoDJg71KHvUkIK28tPfTALMpSpqC8cMDem280YUoEdMf3cVqawYlbjIxRxqVKhC4fi33c1OqC/TTYugptI/yOWp5Da7YpdQ8QOpxQQ/A+hFxZdSlnBlZphUPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965797; c=relaxed/simple;
	bh=/owkVYhFyv4BgSv/BTciEka+6kbKpOKm3ghO2Lkrrhs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mxfLzUQ/JwMmgH5E/wHXpOcOrO7bgJmMVlw1Fudq/sIF4OJgAqvg7HCfcjomZjl27UcLn/6ljW5AkHzM3CLVR8c+5zpGYAoXz249pPEcxGD+B54kNyzfAgnISR7CsoYicYRqIn5masWX3NuYKBaHFsGDyYYDAUHf7Ny2ftrxqE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=o8lPRnoK; arc=fail smtp.client-ip=40.107.75.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbTyC9HViQp48EUwjC+vTtGKfdOkb9wDu4Zj1pPLV9zTnVoJjtkJvWyRZDFcCxKryGUTUJcn7VBvMlPRCUwJy3kIvZ7CC7Js0GnwC4dreQdEpwEvjT4fZV5sgaYVyM8TSA3o/KgcAiR1qwiFzGoOjTdMt/tWew/x9w2VTIkGXZMVDVdmwBRLC/0pFxdp9vJfXV6KNx10/xbPvk9KO8BodWQkzb5Oz7kHVgQ+CPZVWA6TI3Me3xypa8jjZ7p30hw7Ox9WwkqSBHkydlG3TDxxXmiXOQpzzuDu+uBYdEgHKs98ZJ/80ryA/mJ8hPf3yltu5MO0Z1fsD/7pqJI3QuDjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Spo6+y5DVeqGZ1m75gGt9pYCYeYsuKocIQA5Y6Tq/7c=;
 b=ujwupdKN7gQqxCAIOa3BRfhbxluRYpNXt+iqYjsMAzi7bGCBVRBheHt/uCRloElihkmJ1wQnfm5mffEBeZ8CE1GyBoZNY54opB9ALi7kYxK/4T4rFyZLL38jXiBp5sItEe81vBy218MmwFscvprpy5wqybESLTWMWVbZhF1W83PS7UPMyBs9kil+cW7X1HdSCIkTuWzDe65YMBmqA3jWB7ELeEEX9EWh8yOrtR+ymmldiG5VNbo083ig23NY/vjcvzw/622VpS7Gl6SgxQXcHnNd/4hTru96WARBWXYagRqq/7JmqQ8kqDqg72YFjovkf3Ie/M4mB95KychT1mTSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spo6+y5DVeqGZ1m75gGt9pYCYeYsuKocIQA5Y6Tq/7c=;
 b=o8lPRnoKxt3kozZn+v6/tDjLZ0p2WDMs8FzsfArj/fndIKF+xPNyaeB2rQM9ZtttfOmJfmSxgClMQd8WjpE0hFYaJrfZvAelEpqyDlS0SCViXbVFHirzmUwSbIh4+vz1Z0unRE0G9SJmRqb46olDrnqQhlyQTolrWg3bta8CpR/XzCavIsMjoWbIF/UEVaPOvLK/ilo/z+inWD5Fxi40kDcZS9vtvFkQ5s+DGouE7uUc54oHRkY0L6v2ub9pCDc3WvuUEt74hDhX97rqefMH5Cc63iukyNByO6Wp3RJ8QbNI0qtk/RDxywmRpF2R8qsAHc0a6tbNujaM+xdFEsnEiw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by KL1PR0601MB5824.apcprd06.prod.outlook.com (2603:1096:820:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 08:28:57 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9412.011; Wed, 17 Dec 2025
 08:28:57 +0000
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
Subject: [PATCH net-next v5 3/4] net: ftgmac100: Add RGMII delay support for
 AST2600
Thread-Topic: [PATCH net-next v5 3/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Thread-Index: AQHcZcz+EkyleBdIVUyJ/jAx8mAZD7UU8TIAgBChGkA=
Date: Wed, 17 Dec 2025 08:28:57 +0000
Message-ID:
 <SEYPR06MB5134025EC9AD6DE6210F21ED9DABA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
 <20251205-rgmii_delay_2600-v5-3-bd2820ad3da7@aspeedtech.com>
 <8a991b33-f653-4f0c-bbea-b5b3404cdfe6@lunn.ch>
In-Reply-To: <8a991b33-f653-4f0c-bbea-b5b3404cdfe6@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|KL1PR0601MB5824:EE_
x-ms-office365-filtering-correlation-id: 8618a19b-12dc-4fb3-f8a3-08de3d465262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aJxbIlnjML28q3SXfvQ4xHOxYcI803met+6R9vOQsQWffwMVxlXJo0gNofvD?=
 =?us-ascii?Q?LKsx0gQAFdzp4EYRkeqDzxsIlvSsrvZaK0ks2l/uZfziNAOkURBezTdSDNCB?=
 =?us-ascii?Q?eK1/5VZQo7i3TDZtmSCpedoWS2Hs12n6283JAcA1ZHyf4vgbh2vx9ZnR5hfq?=
 =?us-ascii?Q?HWwdr5y3smr/vywcw5tG8jL7T6FK9xF/z3xKHLxWKA/T5XkbKaPYKBIFqX+9?=
 =?us-ascii?Q?AXjbuCio5PtrP//tuU6QUvNTIr+iUTJPMcvV0oQ3xOXZA4/NvMndb2OgP7FM?=
 =?us-ascii?Q?ibxohsGTSAuHJU4OsKSV+EH+vaKofG7oYMrsw5HTGjRwko7KQ0FXyRo+K+5M?=
 =?us-ascii?Q?vdb9Jmgfu8pVw49LqY18JnldE8y8PdqLZNumWG/52JFkOH1MXPP02yv60m0v?=
 =?us-ascii?Q?4uYt+3b7Absn4d1Clxz6ywhgVH0OFeLaoO2xoHE6FKgmjEEl9PqK5lgC46aj?=
 =?us-ascii?Q?ER/byO7JtI8D2nPtgV/p6onvjxQGpk14Aloy8lzG1GOOTGnIpnMe2joGq515?=
 =?us-ascii?Q?N3s/3t64fVcyV2MlIGrcJxWw606msFNRMKjnye0TFzUHaVcMM89kTU/fM8SY?=
 =?us-ascii?Q?LnsSyXGrz5Pk8/cE6Yow9mDVHQ9qDrbnE3/Zm8W0dm7YUzZ8ISWuL7y/Q2aK?=
 =?us-ascii?Q?I942fsuF4Jis6F+IkKv9oyErcX1aOny4cfkmUK+2xoJ65kUxl99rjavgpGZ3?=
 =?us-ascii?Q?RvjQhL6Rypq20b2/bIRxi5pAV6DkJlZfQSZSAgMj2V/A8O1pllrCTOnei4/Y?=
 =?us-ascii?Q?OCXVDXekOPe5+Mhp5vnBgtuudx2R4uO81xi5yF0fu5xXKg7lz7ncMGZ5RKld?=
 =?us-ascii?Q?jRBRUsoqJCMwku1dP3tnacg1Dmj8rr/AcuuaDhwU4wNv4UxqmNT9CT7IjgIc?=
 =?us-ascii?Q?5DTZi6jPbbpcB2Rw+dRG7WTJXi9Uxf+9f3HCM1Ck/xtonGrhC11D/UvljYse?=
 =?us-ascii?Q?05by18bXH7RWrxQ82X2fvz8vnO05ddwOCDKpAnag3h5aMsdWhpNGzIPW9s2Y?=
 =?us-ascii?Q?S/6U/sOFQwebcI/7oOlN8hgVRcdo3dKuDigy/TVIuUiqTFFpVlRyt53ASj7f?=
 =?us-ascii?Q?6uvMa89wel9g+5NJ+BtbrZfseMqNmg6NrJQTugiBXW3J7Wg994lu1Hz8Vgeq?=
 =?us-ascii?Q?73BHdPOppZWF0wMlN9w2QbcfPBDvMmYUS6gYBM/vpgoaooptizAYPV2QI0Y2?=
 =?us-ascii?Q?/hgGwZvKzDGeET2oarVLJTUu9AzsHaMqoUzbefLaf51vuL6+uQy0TSE7nwv4?=
 =?us-ascii?Q?Y1XA2C5fsbxqIpY7fci3ZvgOxtWX2xZCgZr0SJOuHqcEZTM7v3fNuO9gU/Kz?=
 =?us-ascii?Q?Yv75S1eJTcWG+9e2X7BSHPjJhrc6Fm/pUrLkIxC9jXynIcEoO3BiOa5DmSjq?=
 =?us-ascii?Q?gCV+gab2w+Ck17YpKjsaJCakmZYGiMSrAubWgzloFQfTGahQGiEWu2AEBuEL?=
 =?us-ascii?Q?dGxcwce9c1cvf17LSdbdCE7DNraKRhtjVnOOBceIBfllx8j876ZznptzQa0s?=
 =?us-ascii?Q?MjwC0SeL6nX068ot9lzeFd6pwrAuDhdWtKWK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8RcOPORmfqeacMZXzKrcjgez+QkaM3+AV9bkkXymANngz0fkBAEfODMqHo1p?=
 =?us-ascii?Q?IY8vSdJRZ3C6gIQtDK1rWbSTeC+QAbLrRBP9nz8q8SnOrEj1zgHABLEhaVta?=
 =?us-ascii?Q?Oe8Z14Q2cQMKyM+/wE6LermoNh8AIs8yVQ5cQlJmmLCBQq0qH/cngbr4qbJK?=
 =?us-ascii?Q?2PNo3QXN/w8q40i49SHWHKR7i+9PfJtnQFSfeFH2LAVVQFbVM2ArMNp0Uu9J?=
 =?us-ascii?Q?VZP/nUdnP7YXri94cJB6AHS+0dmcwIldNoIKw79exEgpY9DhZV+m4Q7B2Mf2?=
 =?us-ascii?Q?weGLXC3Nwax2u18LLEaLsQ55/zP/qRbDymcXdmmsOELYgeCFbvnj7tT/im3x?=
 =?us-ascii?Q?xxUWqwmXbRNzXnpQ0HFhN6qPzlWJSSscEAtOUfuqbWSr2NyrUnWK+FxLMUFt?=
 =?us-ascii?Q?znNa4dV7ydr9f1Tw5m5ZAU5b5ym1lGPgWr+9CD0S21jjLBVFJ45oUQVQj1M4?=
 =?us-ascii?Q?fYZoHWFYeOjWuZ2RfOq1oAkKIluLGGjANRkcP/Wc3wxYpsfz/kRcm4M4ek05?=
 =?us-ascii?Q?NR0YANHHI+AoiMdsL7i+70lBQ4p5F8FqgM1dg1MZGxQic0mcQ5kDA0xv+XBA?=
 =?us-ascii?Q?EEFDXi9pR8Qe4JUy2YedARu35tZEPxPQfPtg0Ovx0P9lL+ovStkSE/dUD2aK?=
 =?us-ascii?Q?MUqQ6b+deOynkfLLOFyyV3W2w8v2/DGvl5kQxfVZ+1pJk+wJhJzKK8qxY6j/?=
 =?us-ascii?Q?8jn5tUo0PdzCMNxwTo5a8NCELhSx4AvXdSSaxIp90NTWIJYTrQPkG2oLEqM5?=
 =?us-ascii?Q?/2SmYHXr8dkc1ARrPZJ207XNKwCWm0IYsftAjolkuVbfUQ1SB3P2jjmfWHGs?=
 =?us-ascii?Q?iGbmIfqOCZUf5G6of7iWLgzLhvWGcPl5CFG/6e1A7vyYqruZwks6aBk0Rlu5?=
 =?us-ascii?Q?DoNgY3Bwf9X0n/A61Z6neWOjwKgGnjzldnpOhMa+6NrsZ/MBEpZcYVAdwcm0?=
 =?us-ascii?Q?PgcFHQjP6wAn7uavCCwpCVun8/Tqy46IQ1cndh0gocV1LIUEcPo91B09rXxl?=
 =?us-ascii?Q?0abJt44z7I4cIRPe/+4GZaObK3NHISuHH8/wuPsBUTdW3PNtmKQWQFBC272W?=
 =?us-ascii?Q?O31PTRDBTE+Hfqt74a4ysF9c2qcXU0hV11q+YUfjOzN0ZtZ1VRoZZ9uMAXX+?=
 =?us-ascii?Q?axMZ4AOnG7H+SQoKmstxuCJaEl4tKn8mlkDUjAfHEmHMsfOTwNwrGH2jkpZY?=
 =?us-ascii?Q?1TEqQ1vHEl14wTH0CaNUrBmwMLQ5jp7wp8qam0NKxBgHWtGCqOEA/dGQ9L3f?=
 =?us-ascii?Q?cR7lU7KhVDgWR8PTeIJbf7OtH3abj4erwEErrnDq1BJ5oDUnlcQ48SeGKZ2s?=
 =?us-ascii?Q?lj+Xgl9K3/L97Fs2+xPH/tnemSJrLqyEOD20d3H9pe6wfXZ+9mv2iV2cEP6G?=
 =?us-ascii?Q?hcmdNmfdpDaS5RpheQtK1VXh95LeRCnhEkQZ9c66hT0+uNTw5ymgnJ/ra2Ri?=
 =?us-ascii?Q?6dM0OMQDjAlVI28q/pCx5vrftv3bsKcaoagNXuA9/fzPdT9Ff5wIxn7v7Omx?=
 =?us-ascii?Q?MDd8pVEs5re8a7nhy53PbHs73D9wvbuF0RGtUZpjqdFeAnRangBRiNvqZi3T?=
 =?us-ascii?Q?tD29J8AB9UhJNV34/Dqjd8Rfrckjf68LOXd5SfOc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8618a19b-12dc-4fb3-f8a3-08de3d465262
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 08:28:57.1860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+KYhjoyT1+EbUrA6N+Dozz5/wwKgJUtawz7hZtzhuAsVhxvRfFm8P1meG73c2h8Fb5IByDyJ4LUfGasSlzH71QQBWyattrXauKj5PHCBTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5824

Hi Andrew,

Thank you for your reply.

> > @@ -1907,6 +2179,10 @@ static int ftgmac100_probe(struct
> platform_device *pdev)
> >  		priv->rxdes0_edorr_mask =3D BIT(30);
> >  		priv->txdes0_edotr_mask =3D BIT(30);
> >  		priv->is_aspeed =3D true;
> > +		/* Configure RGMII delay if there are the corresponding compatibles
> */
> > +		err =3D ftgmac100_set_internal_delay(priv, &phy_intf);
> > +		if (err)
> > +			goto err_phy_connect;
>=20
> Thinking forward to when you add 2700 support, i really think you need to
> break the probe up into helpers for 2500 and before, 2600 and in the futu=
re
> 2700. You currently have a couple of tests on the compatible which you ca=
n
> reduce to one.
>=20
> In fact, this driver has 10 calls to of_device_is_compatible(). I think y=
ou should
> first refactor the code to list each compatible in ftgmac100_of_match[], =
and
> add a data structure which contains an enum of the MAC type. You can then
> transfer this to priv, and replace all the of_device_is_compatible() test=
s to just
> look at the enum value.
>=20

We will start to refactor the probe() in this driver.
We will also pause work on the RGMII delay patches until this task is compl=
eted.

Thanks,
Jacky


