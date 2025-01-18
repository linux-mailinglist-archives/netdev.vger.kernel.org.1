Return-Path: <netdev+bounces-159541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21E8A15B61
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 05:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB09D1888501
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 04:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ACE77102;
	Sat, 18 Jan 2025 04:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="olLK4/kx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCAE7FD;
	Sat, 18 Jan 2025 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737173265; cv=fail; b=cQpXKrD89r7JUr5ACdYAjp3hDY2UjfDPXRSmpd6kWvu/d/ofZWXdHt4z1sYlvCWVcYlujhyGqJFJ+JZE3ksHuP/t9wVsiSbSgbk2DY1VV4zq87cvJJcHvH1ymaMS6i+Z1bIWzDmauIMo7dvqC+J8Tc0EPTpITJrCjdB2hk7VItg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737173265; c=relaxed/simple;
	bh=8QRhdMEob50uAI774OdYavEj23yc3Ucka1FN6Naax1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AKd/uiulDRYxwo/+hMbLrGiJXKqJEhzDS29Ci4G7xzQzE4KYgKx+KubXzAzVDE3Lz9ILMCBUaO2BoBH2JjxAiQ/6ktAf/O3RjT7Ls3IhA+lSXzeVUy9Rn3QQunyW1glAdfcQxDe4nU5uMv+GmrJy6xqqcTUOQsMy+kBYNxy5DiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=olLK4/kx; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tc+WaXA0+Mf8z0u+7wUp76lJJVmBmn3mpSkMCpOb/inEDpNipnNDmuDIkEcDo1uNjUqDXYezFybLAtchn/r2aLDVDpxjAmsr0OnX6YlTZJ5o/A7U1LyGt94GwzDuEbcWahBi1TE8ac6kDUfnTuFl+d96TF/Ytz/Xq+KNMcLzn50Ryk6HdhYrBbZl3ooJn+qzG5cueDV/NdDqVcFiQvdGBNNslkeNqde6WwErI9TLe6MawH3kM3hkPzIs96B8JeKuv1QMwiPcP30UdKS+7qGBhnJJkj7mtF6bcPmOc8VPj4mxxj7aMSwzOpoi/ZLwtgmhw71kkGTGY015t+aS59bSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFz8xQtNSqYqPizxZCBMTAHpvcBxiib7SYN/hi+XBF0=;
 b=Bt+c0wpEYsM2N816gR21tVnK1NhYMtXPOl6TXbEWxAPZJ/Yqg2QCQXTA1c5D97H6TvoTxIB6mFHncNEXtNONNRg2iR63ZhIkRjYG8YzBmu+LlaG85NG3NCkiCUxsHeR6ru+60Xjp0n1xtPUYJo7ikpG7ULfDGUk85HwzR0xqTDwfsdueB6+nr/HhxEcc+KYZQfudz1AyXOiY3+HYe8GhlizOJ5eTOzGdbPirBkVCORA85Y0LxszhaWRN+t3hhsObXvO9Im9kSu8KqMlfJwjw6pJ0qDmMt0Qms3gS8d7coG3Hrml0BvW4XkyGaC+6gECsxD3LLJDYE7ystmylLlosyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFz8xQtNSqYqPizxZCBMTAHpvcBxiib7SYN/hi+XBF0=;
 b=olLK4/kxjvvpjF8eDzNFqksTCb+MVFTfOyWjcxuKq7QYW4viZ4hjopnf2E5G3RyNfo8c5d8oTRKzK+DKoI3Trd6Zy4aQ+E0Bsy/xNGg2ViBVZGFuGEApr7DZKjEYcHTt3bfNGrHBTL0kV3K1HEkHBOzmD9SgvaShycPDvvvQ7Tw+8MZO0BX9h8rMMKgIeUz7i1OAmOw7KLPHuOmms2HM1DoWDnhQb5iPjzwNjr4i9yRKOMovR4RSg/0Rfos4eQ5/neQlkC6s/w94vLKETuUh7T9WMtQ5A1KqClBjESgxVLZFkUmQ7GsrSeQmhHsEQC4kVEpKFeHzkTpbSxjTHBMJgg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Sat, 18 Jan
 2025 04:07:40 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 04:07:40 +0000
From: <Tristram.Ha@microchip.com>
To: <olteanv@gmail.com>
CC: <andrew@lunn.ch>, <maxime.chevallier@bootlin.com>,
	<Woojung.Huh@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index:
 AQHbZi6jUsb5OQZHf0qguVy2R8e1urMWcOoAgAEuMACAAohtsIAA1aiAgAC9nfCAAAjZAIAALAdw
Date: Sat, 18 Jan 2025 04:07:40 +0000
Message-ID:
 <DM3PR11MB873610BA4FE0832FCB3CA5BAECE52@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250114024704.36972-1-Tristram.Ha@microchip.com>
 <20250114160908.les2vsq42ivtrvqe@skbuf> <20250115111042.2bf22b61@fedora.home>
 <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <91b52099-20de-4b6e-8b05-661e598a3ef3@lunn.ch>
 <DM3PR11MB873695894DC7B99A15357CCBECE52@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250118012632.qf4jmwz2bry43qqe@skbuf>
In-Reply-To: <20250118012632.qf4jmwz2bry43qqe@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|SJ0PR11MB5214:EE_
x-ms-office365-filtering-correlation-id: 1c7436a5-002e-47a6-c709-08dd3775a68f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NNQTg3uc0lBy7dssaRkTBjIVNbryBa+oAeM48+Qy2LUS8Ti9LUaqSzp5COSN?=
 =?us-ascii?Q?UUJYarH1s8VP0tUWM8ECjIiHW02lJnhIb1ywQPRfUJxY6/ijrsxYWfdjwfFP?=
 =?us-ascii?Q?Nktbqpsji6JsmnzFYCBlAyoTAUY9fqIBlWL8D24LkS32UfUULLpY0L2Gsrbl?=
 =?us-ascii?Q?zBgZpVWlPakcAIZW/nIUVEnK4BnG5+Y4ryhQNRYrgPirpNOyN0CxF58W26Nw?=
 =?us-ascii?Q?afKVmmFua+x095htZv4o0NnWxFrG4IG/8eMKAjIodU6QYCyCcI9ESUmVr3jY?=
 =?us-ascii?Q?/NC07+aeZbs5MPOVLgxYi93I3dxcI171lohd2jrBDB9iZlrhtQhyyhhxKCWB?=
 =?us-ascii?Q?rsHtQSJmNKkSLdiK2p/WfoSc5h2zzitiRiiD2B5iAeGZnxfQTrHPX6Thrk7V?=
 =?us-ascii?Q?F5s8aAgHf5xs87W9HfJtOeLqK4SE3NE+OSDWYfWLBk4sIy/4wwNkihICk/RD?=
 =?us-ascii?Q?j/4ErWsW/chvVykfm/hpuiKkYCAK980b4Jj0RuHVetPLresZziSTNIVz00N+?=
 =?us-ascii?Q?jpn84Mr/WRsm5l7uxUurFLKqVy/+o8ki1pOOXYRntGQvPd4T/ZFwMnbCgsPd?=
 =?us-ascii?Q?SAVUcTgibt3nK3XPIGqYWAZxb/foBkJ995QIb/1xaZ00wrWWBmDzF3GX4CFj?=
 =?us-ascii?Q?JRBMgBUjst6OPDCazESFhXFIeGJ96Al8svBhC4sR+4aTkwEw2F+uSL6C4RpP?=
 =?us-ascii?Q?FFxVK6SvrFI8SjWrCWkQ+C648X2lJ/f5mhWH8QhDm+cW8Eyr5hzwUymorum4?=
 =?us-ascii?Q?WyFeC3xlUhYGaiY6xJhKc0VLKzvh6Dk4HiwkneCwZO6hjYE8g34iO+pMPpvI?=
 =?us-ascii?Q?t4VOFpJefEhg34DxfcEoA55+DCfcBAEgNvTSE+c3k/vn1DtZD9nsN6Q/VzFj?=
 =?us-ascii?Q?XT+k1+VbdM87MtlN/WlKRTfqrIXW4uUNTQsuSMizgFK74Y8i9jOOJyKpzXyV?=
 =?us-ascii?Q?51j+GgkUa8j1CpMQwB3uAQ3bqKfbUz+Jb+gUiAQ0lFHruXM5WxxyoozY4iGB?=
 =?us-ascii?Q?3sh8tT8Gx0QNO9Fj2qX70uI/bIzglfwIqL4J/kghu/W/46QBgQ/vO3dtkylv?=
 =?us-ascii?Q?m5pzm8YIrAXZ7OCXi6ducnjEP7QFEKc7wB4bTzHjkmKtvfHulejrq53sB6uY?=
 =?us-ascii?Q?72PlptM8GSodVsEnCubP86Kh+doJzZ5/5puoDvHI3kZwUGtsjWTtWun1zR6s?=
 =?us-ascii?Q?cvIMmC+NbTAorC/zi0CcryEjcAo5+cfqhsF10ap5WIWGP34VewIUUCW1h2Uf?=
 =?us-ascii?Q?5amkFIPlchUB27mEp6ZYcH9os1Zc68WwWrUI5VAIgFoD+YvqG0w6RJX0UR3Q?=
 =?us-ascii?Q?fPxkgQyAWxKkcbyoO/E5/bUD2zEC9yTGMBgpiEHKfgoFQNPEu7eTlc85KCFe?=
 =?us-ascii?Q?9SkJSRY2zFC2359XgzYbGuIMq4/rh3jT4Aeo7AhL2s0prwQbFhyAlvneNLZR?=
 =?us-ascii?Q?GsunaxA5VDvEKXIolu4uVtfoHoisolmf?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?quIMOmJJZ0bn28myVvnRM9m18wYb1ioAUgMvlUkoZ3JwX3t2HnDXT4iC2d4T?=
 =?us-ascii?Q?ZV5op4MDYMkFVjEUd2S93DeSBA7tKnr1n6lQQSzY9K3UBFzPC0nEOA15JArN?=
 =?us-ascii?Q?VctZcHKvKWOdy21dvtlr+AJO67KmLkvxdJPRcI0eubrhzQU+U5GiAo3PfNDh?=
 =?us-ascii?Q?/CtwioeCUdW7uqyVsa/1PIEfaVrKn0ft9y/Qck5hpyX57xazv9i3vrb7qghu?=
 =?us-ascii?Q?pwdveovWFbTUhFFKaaYec5puCpKVd9b9LV/JuesWvKmV4gGHm20VMuiUyt5o?=
 =?us-ascii?Q?47uVUeJG80lYjyMq5xiDhbu+tND+Nsfims8sHmlcOsc7qc5fKAKuW8LOXDDv?=
 =?us-ascii?Q?WdfDxrWdAruuqNQtfP9Q8DjIXF0/x3XMUMI8m2Aj6RuS+zl26yqRZA6u4xco?=
 =?us-ascii?Q?PILPGcUCClH8zFXKyt8T7vYUJizC5Pefxd3ncJ8c/v77MIfA0FUmdON4akeR?=
 =?us-ascii?Q?A7OzYivo12RTNFEt+K4Mla7YXpKVmjmYM2BXmb+BcnSbIC458sJM6/pxcrWx?=
 =?us-ascii?Q?5U9o7tACq0k14xZey/Zs6+gbhBNgkr3DwRl8+IeSwhm5L/xBZ94zj1o0azNV?=
 =?us-ascii?Q?DQbLJyiAnq68Mu5k7aX+rm5tAqNCb95oz7wduURREjV/XOoSgJh7MFr6hGWP?=
 =?us-ascii?Q?R4qLJj41Rgrn7P8Xpd+LTi1cXEfTBap2wsAUr2uGO6THXagqP4HBvcKl7UKO?=
 =?us-ascii?Q?HwYQWqDCyGOcbn4CXLhB1xh3M3KjxBi+IjpRMdO8Y6Wa6NdBr3tizMEWSkhX?=
 =?us-ascii?Q?OymxQVkBRXzpc+sArOjQh/e08+v08Lj0qobUf3tvll5sY8xhgBOr/OpIRF/7?=
 =?us-ascii?Q?Mvr9EV+P3Aj/OxHORcwbJIsikCl6WBiXByaVczvVnwuTqpdPNSqh1L4A290r?=
 =?us-ascii?Q?lGSutRUPcNRoROcqqGsWGbMVTnGNj3VM9tzKdFCRvdafFMoGQPZ7K8nLJg90?=
 =?us-ascii?Q?MLjLIQyFNW2P86eEpa3L++Ig1tcQ6b5PNTjQCqQaE8HaRbkxte3o9vX+Y2D3?=
 =?us-ascii?Q?DozNdH4Pzrvtsio+Jt3mYyeIzcluxzvHSaY/Z68ldB1y7qRaNTHcJns/Tb7o?=
 =?us-ascii?Q?AhismPW7CRWGB+MvgTFvv4JNOOXYuBQ+nxxuagH5k3Satn34qPZOKPlm2m/o?=
 =?us-ascii?Q?MWA5oyKvblbSUahW8fjEYFXOyDTT2nvd2MjMl+XDsUt6YjBIN0uWF1siWSxT?=
 =?us-ascii?Q?JWHpIf/DGwTPqrl+qqa1sY+jBCC8bxIcBj1JsZ+13d/7MHVgsH+uuOiI0K7I?=
 =?us-ascii?Q?PUUI5k7qiUMzdyqCf/u6ZB/a3ojeKXtblpnD1ZbBABtvecASLCyX+oYg8pbi?=
 =?us-ascii?Q?t3UMXokLfR2b8Kh5HVUONvW3BsP9ljko+RX36uzgObYepdJCLafcKPwXStV7?=
 =?us-ascii?Q?H/jmlE6NG6tkWIcpB5H+ki2tmoGBHNiDbzvUpBQRb51x91hNZMYvewAxtSFh?=
 =?us-ascii?Q?OXsww9FE6bqIrGZF0+M3oZaFuSW6TXq+AMZW6fHbCNubolwURhpEQ7e6mtTq?=
 =?us-ascii?Q?1Y7qE8XIvyy8Di0sHC/reCXV0F4Bg6LyNzo1ggsQBGOWKPg2O8YW/WxpBdPH?=
 =?us-ascii?Q?h1g6+T5MSJOse5eCdIOjvS3eDPGoLvUzbopMIn0l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7436a5-002e-47a6-c709-08dd3775a68f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2025 04:07:40.1273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiX04zMQZxfA9etnrjiCCgJYFFZUB/rrWNrmmjqO2GI3XucHKU6JfBcd4mQWCdKHrlD6qvQNn7AosuO07lV/rOqF1a/M31NBx82YyPkXnAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5214

> On Sat, Jan 18, 2025 at 12:59:25AM +0000, Tristram.Ha@microchip.com wrote=
:
> > Some of the register definitions are not present in the XPCS driver so =
I
> > need to add them.
>=20
> Not a problem.
>=20
> > Some register bits programmed by the XPCS driver do not have effect.
>=20
> Like what?

Bit 9 (MAC_AUTO_SW) of 0x1f8000 is written in SGMII mode, but that bit
has no effect on KSZ9477, so it probably does not matter.

KSZ9477 does not need to update the 0x1f8000 register.

0x1f8001 needs to be written 0x18 in 1000BaseX mode, but the XPCS driver
does not do anything, and bit 4 is not defined in the driver.

The driver enables interrupt in 1000BaseX mode when poll is not set, but
it does not do that in SGMII Mode.  In KSZ9477 SGMII mode can trigger
both link up and link down interrupt, but 1000BaseX mode can only trigger
link up interrupt.  It requires polling to detect link down.


