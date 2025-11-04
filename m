Return-Path: <netdev+bounces-235367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57347C2F50B
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 05:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC6444E3F63
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 04:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0138B27EC80;
	Tue,  4 Nov 2025 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="JC42vMf0"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022085.outbound.protection.outlook.com [40.107.75.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EB8BE49;
	Tue,  4 Nov 2025 04:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762231642; cv=fail; b=jXPS01UAQ8fyhSy8DUFuS76MSLtd2xTJQWxPBWJhOQ6b+PPDLT/o9RXDKmDBeHmdZH1jZN1EJX1UwCQtqE6n76CBt2a5dJ9s/79usdVaF4/qA/5AQQcvbF2iwwVUp/XziFAbbzD06ZxyGybcOSSXrJlVyRDG9HnvGP5sn/Rbor8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762231642; c=relaxed/simple;
	bh=wGncHtVBxTkPUChqGI5bGjAE5IKtB7UPuWiv2xfcwJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HcQPMUb6MqiqGbcU1itv3VSgiarudgJRyUC2XIi78cQ8a7/oH5S0e6MPVwtkHSeLT5EVf0/DK3897UQymnHBPXOGkipEpENP7VuG4zwf2NIDXEosTR5EUBw5u3Emh8AacnYC8gp+I7CzrQhZmb8EYgRZ43rBhRdZsR+7FpKtOmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=JC42vMf0; arc=fail smtp.client-ip=40.107.75.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m59Hm3yJeLN3KLiQhuJw2QPlWOZLD7XSTzgJv/7q1BcNceVs3dSc2zSuyZ/7x6NfeNFlCWOQDqYDi8Al3KI5KtypvcRR2SRrB4+GwJzUCjqwQ6tHco4S/9vocLHhf6kHxLmoGRLW6o3yOLo5/i+esrrcPKo5X2jeJVs8PwxMSHHQ/mISHYd0PpH/SSFIuttModsF+m1GShP91XlSIHjxPO7S6N/YSQLQn1W/k6yi1W6n2n/T8XpHog8M5fcXnR74p82Ni5uivD0ICczww0oXfMgFOhjfxwDmTj5qpjY/5EFIVBF2xqvm37UyfGyq2BEIAHqCR8IRF1mdUi8ysan4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTsPluCFG5HzpI5jIaed8Buk9Uo5aNf4+nrOss8xLfA=;
 b=xx6EudPt6ehsjtxg31xPZ4Bo4BcQtCN5bj2lhgMfJaPui2oIKuWO/4wWTQK/07Ad3u6h3NDIQnFPFslKi0da2ai/+ch4t/VxpYM4a2PtQPdxhSNw0EnPnZSzHIMddIuVqVvVPEPLdBpyjk6imyR0RRL9m5I/3sMJ9N5R29iu2m/r4lo2bvFoExZI2QZ4ih7LMxlIPWXVP1Vb/gYdmeVJkpMTmqKISN24JxfzLBZ4RluefeL3W7g3A0/ndd/aWupW6U7AefOgippiGPcD3Ou4yrkICU2EAVJ03bQ6FLI949mjLJCLWfGDIUhaWQZum+ak3Y3MuqjTiGiT1T2oyJPMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTsPluCFG5HzpI5jIaed8Buk9Uo5aNf4+nrOss8xLfA=;
 b=JC42vMf0nSe72+HvWv+9ubD/GjHdoTFlZWcSzU86bh98ubpOu3DBTRPbK2PwwgtIUTkgt/Awjs2VokTQQ953Fuu3Yo49Eheg1K1q/zRGjvnJBeMWG9BJaU9zvCEUIuxpIz7v5FdRI7+oulgbo44ns/ViW3V9EVvvWh/KnK4V7IQoRfZP6hp2o0nSpeQlS9y1+vs9mROY9RD2LAxRWMxWz4bLytEVzBjQ/68MLAIvtuQU0fxjigxGjhC33pKMcoqFjJDajiv48ojnl6g4rjJGNEOxtcFPC39aW390rMeok/tmfA6gQXykV04b8QdQZDw7GLFy4TUEMFwYViBmBVxUkw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYUPR06MB6218.apcprd06.prod.outlook.com (2603:1096:400:346::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 04:47:16 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 04:47:16 +0000
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
Subject: [PATCH net-next v3 4/4] net: ftgmac100: Add RGMII delay support for
 AST2600
Thread-Topic: [PATCH net-next v3 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Thread-Index: AQHcTJUB6g0+FeOHEECWJrxpnPRcJbTh5IKAgAAN2sA=
Date: Tue, 4 Nov 2025 04:47:16 +0000
Message-ID:
 <SEYPR06MB51340703A36D100C0BF7CC959DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-4-e2af2656f7d7@aspeedtech.com>
 <fc3f159a-0919-46d1-9fd8-8dc263391691@lunn.ch>
In-Reply-To: <fc3f159a-0919-46d1-9fd8-8dc263391691@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYUPR06MB6218:EE_
x-ms-office365-filtering-correlation-id: 379ebd8b-ae02-4823-30d9-08de1b5d3ade
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?op9vG1cLe8BZEGfHegapn2b84iwHQQpU0MkphUTwX4Gu4kxl+y1Z1L2/BvTx?=
 =?us-ascii?Q?z0rMGGvz/nUVnWDtAGypkWZ0f0RcLUqtxGZPW9ivaxRHpLd5FK11pQwCp82e?=
 =?us-ascii?Q?JsIgKp3/sRViN9iLkfR/umBeCRk7YeztqWaJt2O+MX+T381PWL+L/2xXMn9f?=
 =?us-ascii?Q?5VAxlEBt+4P42Ja01v7hUqH+CFBmKLjX5YPx/7L3njOoQvVZrE++BtadWNdg?=
 =?us-ascii?Q?pJvWhQdCTRifkI++XFIwKbHzS3PqdxXKNkFHYvqjAIzSS+dmYKjscRS7oaoZ?=
 =?us-ascii?Q?cd+LvXOpjLIGepznT+xBgMIVqj7LYegZs0A0z6VOL8DMkTcKPNpQcgG45oXO?=
 =?us-ascii?Q?H5zGph6j5BNLHhucma+a0xrOJdRX7B4JH+oFMfpXIvSrONT3VvWV4b6zcYaX?=
 =?us-ascii?Q?0vYLUul4U6WI0gwMzAN4RaqddiQTrUKKfjsgs0S3IhKPGxB6XGzw4SRlrDen?=
 =?us-ascii?Q?YofRSLZGNBfk6INlt5+yIODUkUq74yyygxGrKWjmmdMfJGARgG21C8dhIPyg?=
 =?us-ascii?Q?yk6lbQtLEKaTws/QlcO5tVnIcuNlX9mGAmjpypCmT3ZkdqixnyCVCCysS71h?=
 =?us-ascii?Q?V2ps/ywlzRRzszkdMSpDN8LdWuF+4AXS2AHtSDJcYPZsPV3e1jMMqz1UaERZ?=
 =?us-ascii?Q?gpCUswmpcNOK/iYEGLAfAK8MM1RZgoLXbFIUyFL/xhu8MWDS0rgZfUs39sww?=
 =?us-ascii?Q?kWJ/3IisHu+9FjYKaAR5DVOqPYMONSs1bafaf6NfTw92gaVBxjMTrN/7w67A?=
 =?us-ascii?Q?lAUkSZa5pHERukHRn8IWTgBI+WRFbCSxeMz5KSlx0E/8IbgfpdwhddlU8mO6?=
 =?us-ascii?Q?B8r/aGmXFsQZeiwDSuZXmiSv1PwgVo0C3BUX8cYCegs3pZ9L6BCBiX7Vn5nb?=
 =?us-ascii?Q?rRuzmxK2tEycjg3i6KcaDP8xu1mySwsQwO/PcREBQrnwRzpBcZZ6KxxJVUmX?=
 =?us-ascii?Q?KYAvJSkjKkp+k7dsch+S+Db0g30dPHj06wpZTxPyyZbLTTAeu0GKrRD6rwN5?=
 =?us-ascii?Q?BsCbllrGvXEslU8lTbpmSRBndRxfY478xgV2JkLhkpTwXIqj9O2zI8/mvUzA?=
 =?us-ascii?Q?bcZi+6Cfx5m39f+w5lGLoynMaRDiu8Cvq3zYj/DhsAvni+AyGObm32dJo7iw?=
 =?us-ascii?Q?c+6BhwAnBfK25v2nQl9wgNRzeLzMgk5OQOiBaLpQ5gOly2EibSAvzexz2qTq?=
 =?us-ascii?Q?Pp+YREq16VBkbH1p2nrTobixiayMxAQOztfGQkp/nTV3pkHfISB8zSf3Wl8n?=
 =?us-ascii?Q?grsoKYIC9GlFhk3kbNyMQBUJck9RlMo/NP4JgdSKyAxKsEe6Qm+VKMmlm/ZA?=
 =?us-ascii?Q?P5BvkUFuJle6iolLE0C5iI+eDsMVusLUF07DdH3tXUzBa9CwwE7gWs+y3McP?=
 =?us-ascii?Q?KCh27Dk5UrMZoNf4rcd+F0r5v8xqRwrA3oIIA4VkoLxtc6P7UIhpxxFM5TmC?=
 =?us-ascii?Q?kBNFDMgF1/fV09ha7FyeVe/Q8I0ou9yKk80960Y64tmE19plFpYasDR4g5Ub?=
 =?us-ascii?Q?/syfT9Zm/+bUJep2kpAafE70B0Zc1DZjgwar?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wT8vAcFVhaTiItJN8nIwDi4s3EYHKtUmVv6uuVE6dZlJQLxh478+vj6AHGg0?=
 =?us-ascii?Q?9VummBY9E4xsfyKLKhxBqN3Tfw+odHoMmxae7mYALFbB26SWB8An8eKe584i?=
 =?us-ascii?Q?iX1AIEToGJpF3uKdPhH+7iLidDCaBnSqxTfcCauI2vnnKBxgjM9vqPbeqrIK?=
 =?us-ascii?Q?YZ/tCZHovD7B6adMkSshQUAT5KPXfGqYjnPf9qLL2P3iSAIih4NX9+OKyZMa?=
 =?us-ascii?Q?D3fN5idcW3vxInY2MzkaKhfW08y3e8WJkBUJTuijK5fW6uPF9jiYJftH2Fed?=
 =?us-ascii?Q?v1wUevol92dt+KSMi/TOxz7OWzZ4p1bvMvsGMVsGobZt1hbBKiTAYrt2cKJa?=
 =?us-ascii?Q?nkqAJjX+QlNxOvZ9EMlznSCGBs0zuPfUG4NMC4CO6NPzkLUe6rib4w3zfxEv?=
 =?us-ascii?Q?nX6EiW9f1Y2gJGkWQPivQ67N3SqgqZeOEGURjmUSoGZuyzTLkZlsnYJOU8RW?=
 =?us-ascii?Q?LhjT15qDP0P08AUd5dD4O81GUdtGhk3cOj398EAErWs3/23Cg1MhHR5ycVYt?=
 =?us-ascii?Q?iNRxnUjdgFoOn5K/RjqtwiRwiKqNnoxy1/yYs7QdhxJuUGfHqyAffEZd7g1p?=
 =?us-ascii?Q?YQV/D4cV3nyzRghYONuJ2LC7kS/vMiY3/MP+ZmX97YweDRMEIR0ZavyqfG/V?=
 =?us-ascii?Q?TgSbAX5DxSp6/LK0bKeUSutClNqiLOao8amCj+OojEw69m+ugsFSgaiS10Xm?=
 =?us-ascii?Q?C4G9SlpSWM5GgUqHosaIvLyElqK+uTdkO5tAlbh6XMfX2eLcjyCwSzmU0pzl?=
 =?us-ascii?Q?UKjpzzAFsjtRDIFGrJNHAnRHqm4wFbUgeyAoQNRv5zQ+wZ0qBIekJeF+owiY?=
 =?us-ascii?Q?3wKP2A8CKjDDiN6iwTUn3oo5fuVgcCr4VL+TbKO/G1llXRXuyAXo2zLAttyC?=
 =?us-ascii?Q?sF/4/pKbr1IF0yf5JO4TD2FYJqGqwXD18LteUkQMMFFAHhWcNJkW5SHEBJxp?=
 =?us-ascii?Q?sZz8g0/OcBS00x1stTsgBPSQ2bC52VdII4rfZOwvDgVN2YmyUzZ/P8jOF6gQ?=
 =?us-ascii?Q?1/fuIBNUaXOVfTmVpQTgdqAXyoCDCrmq/78EwEr01mjGscBjDM1cO4jPGvqs?=
 =?us-ascii?Q?uxhB8mkS96B5J8WP6MQ5YocjKRMy1yuPYzq97Svruvt5Ivd8ptG05PTlDr7O?=
 =?us-ascii?Q?BvnKGAelb1HcbQw1b+7CpCQRTRYjP1eyPFLPZqeWJ9k5jTbaA1Q2YTHW2gUK?=
 =?us-ascii?Q?KIMraYsAaIsnnQzc29iRMxVYpwlKsas+KWv15CXneS9j1Sgqke1B5K9DjsuM?=
 =?us-ascii?Q?xFbFKPTX/SsiVdAM4i852BmGAgej7xUJFKp8JcRppy62+MVaF2mYQo3uSbR/?=
 =?us-ascii?Q?zEd4xls1/loIIPVgjHNAepaCWwyg9Vn1PbMpgR1ZF5/jIpZSepT+5MA5LGub?=
 =?us-ascii?Q?1vGLx1AiKbtoZIhsySPeyY3rrh4qsNo4+hK6OtJ9JEH6IWoFeFzUTC7VsE8V?=
 =?us-ascii?Q?8aaluGRue8J7rfpsHe2hHy0cFkyAzfY9iO1HJHYSjhM7SNKVBS01WSUDIk/a?=
 =?us-ascii?Q?8p3JqRz6HZ8xDj/ISHJHpqxHgUMy4irTjtZ0zCP7DqSirEX29/1RSuQ+9ejW?=
 =?us-ascii?Q?n9U1Wz9PBD1T5+5S1ahcjcNjNZLjGeAFvVqsdZ2A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 379ebd8b-ae02-4823-30d9-08de1b5d3ade
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 04:47:16.6225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3w/2jghCRPgWV3CQTjzEpsY/6h6sJjtBf+QhMmbqLw71OCX+ewnuDr8mOvMX8LhOS/OcdVpyelmG2+7HwsLxKmVoDgOORPiCi3GjZ3tLrPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6218

Hi Andrew,

Thank you for your reply.

> > +	rgmii_tx_delay =3D DIV_ROUND_CLOSEST(rgmii_tx_delay,
> rgmii_delay_unit);
> > +	if (rgmii_tx_delay >=3D 32) {
> > +		dev_err(&pdev->dev,
> > +			"The index %u of TX delay setting is out of range\n",
> > +			rgmii_tx_delay);
>=20
> The index is not really interesting here, it is not something a DT author=
 uses. It
> is the delay in ps in the .dts file which is too big.
>=20

Agreed - the "index" isn't meaningful to DT authors.
I'll modify the error message to display the actual TX/RX delay value in pi=
coseconds=20
instead of the internal index, so it's clearer which DT value is too large.

Thanks,
Jacky


