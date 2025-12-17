Return-Path: <netdev+bounces-245216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F030FCC9009
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 18:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D626303EF98
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0845349AE7;
	Wed, 17 Dec 2025 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="i7r3G11Q"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022103.outbound.protection.outlook.com [40.107.75.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D033890B;
	Wed, 17 Dec 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991381; cv=fail; b=Q3mdfO/a+AYV9qHVGGVud4hg27zrGhBASihVJf9UdkFUhCsYqeS4mb5nUU/pP9gYVbg4gguOPfGuw4EplufJ92wILvusmSNW0JWW9Dxp59gobOeW21gBQvwe3W6ai3Q7w7LgiCer8zmwOSzdhmK9tuxhNUYxM6SQMIhM7vOmP8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991381; c=relaxed/simple;
	bh=Rpaje25tAttgYut0BgtKOpeTegDbiRBJ7I7vAK1FVkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ULDEg9DDFl35uIaJocw4iQsEcear0RZ1a+oX9LBR7P3f2ddcKCAhg6oIrhaTWpe+GIgEs9cjK0Ij6RULu7ZQWG+bhgzniRhhHE7mSz2NXFGWMXBiXyfPQS8DcE0HHi2WoBO6UOEmB1uclCWHVGbCWBTzOjwZwcsAgmC2/Tm8mH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=i7r3G11Q; arc=fail smtp.client-ip=40.107.75.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ea6j9kiv8aZOJX5Tu9Nlb9kQByr0TxFiZZHouuUlEA+MtQK6R4NCi4mPqDG3eIWttkC8SvEB1k9MEOgrQS2ysg7VnM2PNc4p5LJja1SXCDHL+i4DBKUWzZloZWWNYy7ZLr82EKDWUoasbRlzQdzKHP3Fo3Uu1t7sJG9+vTDxNGJTNIIEmVWzJbKXXG+L2tk/GFcIi05Rsl8aBHIWsyUE22d94OJmJLlXEBZ4CUnR2ThSZUkO+FSFpf7kvZ2ItutjAyPjeOyELMYhFQNzGhaY8GKtWZN6MdsRmtF0JkQWdDe2HYF/OBif6eb9Uqq9WMU//32OzGuOJ2t0pGRlhZsxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0T/hT65G/v6zpXfgNvpzg3Gn/KRBabbEJRcpcl9jKg=;
 b=mghkngqKbV34nQVCOboPktcPBtLdEOX1kTD3HNhvJNq/orvkfCOsPft5FxXAlF+pp9YFUxirHUTMgAr5KASdYRyUS5y5lhZLyJCDBA/n7nAefxVrtp9WRiFoIPF0zu64xxNbF4ut3vYnoCvoqZZL0ZHwnFw+8mfogj1BUh4DxYaPT5JQuev+ApJw+v/yXTOCCLLpIANyyg0NjB2JeN1jWlxFb4f7TEyGoJbxPSNAx86XhvgW0jrSg13ewRafSgoU7d27+SYcKqt2wCdqgoOQMvmAH+pWlNoIWzELY1vxIy00eCjfOGtusJNWc19tu7BZf8GQEydTyqkxz5h5Ss/BCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0T/hT65G/v6zpXfgNvpzg3Gn/KRBabbEJRcpcl9jKg=;
 b=i7r3G11QWcfa4GfUPVsB9EO78xj0QpHNejyQmmf2ytmNPBWnig1gaCI3vIvKIn1mBUBH7xQO1w4pwT1IOeaduRSuQ23XlALusUqvaZ8o5gRt+2rcB6J+nqOdZT8Y4fPMxmjQnmOQungtM9yo9SwdfcfAfH+myTdJO9rVlOm/Ta/DzFTPmFCv52oRE1f7m429tf0yNQRwoyzaeaWNbDi8qofFVX7eWnicl27zxS40STBCyLLbusU9jSuL+DfiA0g9SLo5z3EyGylRrR8OMfyEoijq8Tw7RRB8ogTXc8/SIiL3vetemczdFkscL5rGG7fiPrqqhSjx88YkZFTUk2Xrcw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEZPR06MB7263.apcprd06.prod.outlook.com (2603:1096:101:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 08:35:58 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9412.011; Wed, 17 Dec 2025
 08:35:58 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Po-Yu Chuang
	<ratbert@faraday-tech.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v5 3/4] net: ftgmac100: Add RGMII delay support for
 AST2600
Thread-Topic: [PATCH net-next v5 3/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Thread-Index: AQHcZcz+EkyleBdIVUyJ/jAx8mAZD7UU8TIAgATeIQCAC8U2wA==
Date: Wed, 17 Dec 2025 08:35:58 +0000
Message-ID:
 <SEYPR06MB51340B307868D8D6AD1ECFAD9DABA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
 <20251205-rgmii_delay_2600-v5-3-bd2820ad3da7@aspeedtech.com>
 <8a991b33-f653-4f0c-bbea-b5b3404cdfe6@lunn.ch>
 <20251209205034.GB1056291-robh@kernel.org>
In-Reply-To: <20251209205034.GB1056291-robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEZPR06MB7263:EE_
x-ms-office365-filtering-correlation-id: cecbc3d4-fe6f-492c-a20b-08de3d474d87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OObZr7xbTNSQwqgroiuNuHvwMEB4dxlT+DYuUfbFz8uwAarG2vsjk91jwvJd?=
 =?us-ascii?Q?p6PiOAeJY3UpwYp1ZvruIXp6wz2KDVwEcTy0NioSoxHFdlREfziQZZJTYzIX?=
 =?us-ascii?Q?m6nM0zA9gOR04nsH9Hv6fFyta6HTc0kHZq/YmcvSr2jnkGdSDQiSXYPBE0UP?=
 =?us-ascii?Q?T6mmuqqSSs5aO9vBoyEG4qINtxLz3wdxTKcBZG8jbVw3fFlmewVLHgF+IVo4?=
 =?us-ascii?Q?VhupLbDWfdmyH21h46/sbuZePymkuSB1+eBT1TRHeq0jmr2ce2gxMfveUq17?=
 =?us-ascii?Q?RWHNuFc2wl6dhtpD1unDdv+2RIyoKYD4cfNtzMxFx2uTdKtnEgqy5pj47cxM?=
 =?us-ascii?Q?Y2J3TtQIjl1xzAvMklsBMWV+4WC0Uxvhx+qPSX1AnzLqZCRmgk0HqajvdZjY?=
 =?us-ascii?Q?b9NGDC629xokV4861FAZ5+mS3eW7zVl6iBpV4OsHeUk6nhzwVJAQVw57nsz5?=
 =?us-ascii?Q?0EygXAP0d7lfpykOBHiDM5zcy5C3+put9Q8vf47ggWd2JBq9Vz/VJk8bqYjc?=
 =?us-ascii?Q?I4oUAbt65tXa0xYR204MYFVs4s6eGtV5sgqWE6HyUbkv7Qc+qIBYV2B1Mz9O?=
 =?us-ascii?Q?ntn1W31FOUp+mbGrXOLRqOvD5dfGegj+UZoBGcRNV9SuVJiQbU/438qYObnW?=
 =?us-ascii?Q?VSXS7UAJ3GvnE7g4r4RlpNEPuvUiY5RXV8r95kP9HIrF7a3muiXIoKfkrDLF?=
 =?us-ascii?Q?fsVI7RL8N8rETvARg0bw9UiNLJYGt6gXJWBGZ9P5jrqQFEkaPlk7Z1MJTUIy?=
 =?us-ascii?Q?PUlwm+ROknUsxc12xXqZZfgI8BDixuUbUute7QUYLMQAfnadweAwh/LbiHX/?=
 =?us-ascii?Q?si4D3NfZbPp9tnL2IYFQPbjTuJhrvCbW+wbY9uI7n8sNUVtxTz6DSUzS8zZO?=
 =?us-ascii?Q?WdOGBXRG6GisofG4MZxjSszgiWYx2QEBqzI3yzsU7xyLbdscIEdRsNMXfmlT?=
 =?us-ascii?Q?hAOjzvVjnYPNmFn2bjvtbJydlcW/k3kPyQuiW8lA3GREGmjUpDPDVKvWURcC?=
 =?us-ascii?Q?/8QjUk3fYQC76e/HEvv57G+4abzOfvYvbbvwJ2DevWb+psxvPko8Xse9Vi+H?=
 =?us-ascii?Q?s8p5/qwwtxlGqPCLP+8Abn+Y8oJRpGZzRPTMMYX4930pNCRcMFBhDdfl1DsD?=
 =?us-ascii?Q?9koYW5yZVDvhC+/oCLs1pCVlg5Hl4Njuq4SYmJORMcVGoewdfuoo0HxQ3Z6m?=
 =?us-ascii?Q?ZeqcOdMQ+oHROCrFn+3kcRrYnH38bE3QcQ/hcgcmniCkTE0+jEwaqn4ll2E4?=
 =?us-ascii?Q?evy02+x9alPxYpNCc5wPKj0oIXiTJot4aQa111vVzeyORQzPMcqfz5+kRHnB?=
 =?us-ascii?Q?YA/9VQimbxlRBovAKAuDzkt1w3v+pZU7pbRb/Q16QVGfRGFTv3R5Wg4K0lRb?=
 =?us-ascii?Q?bBk6/SxcwRjL1MJhVgMCq3neY25cZMT40BnakUaygUTlS4NBvSMXTKmYxNeH?=
 =?us-ascii?Q?CtsNAQafjeG0hOUvLKj6OCozHoI4CSgFyGONtlcw7qmpx23J/L3i0aNw9jpQ?=
 =?us-ascii?Q?NAWx2cFvBk0ea6TIITBSvD7uWi1zzejqUvdK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?V8hDnwo38c49x2FoZ/8JHHIJt7eqwBETLZhojm51plRW/QVKkohm0EOg/6GQ?=
 =?us-ascii?Q?EBIF9mQvf3azg50PcboFAfKd4KPFhXMKHxq33TxVbs7uiYYhk3vry5WmTDWl?=
 =?us-ascii?Q?0laO8K4b5Z238TiIN0P44R4yUBExNWp7GdQ/FhU8wDUy5NXxtHLrCHs50c2x?=
 =?us-ascii?Q?PDFnJIH+06bYcSuNWeteXCVbkCalQPhvuYXu2yBXpS3z18zhkGYjY2MvTjxk?=
 =?us-ascii?Q?9RoEsjRyegssLECyMFNJ9GKkrZUuUcw++R2swA5YO9X61y9OSZ7LD0dElb+3?=
 =?us-ascii?Q?aBLd/QxW9r2pnta0GwA0E8x/nq7aRemaeUwv8809wLGmFU1m0a71TKC1mfUo?=
 =?us-ascii?Q?axgIOtOhbRpq5OBnAGlrVCmo6mREQc0EXT5QMgFKau3Ev2dMt7ApgwWmQHGX?=
 =?us-ascii?Q?Nrio+ECmi2BsQpK0uVJSsUmF3Ci7E6f9sXgzGRfT89p0/wxUz8n/mUT5Ax6H?=
 =?us-ascii?Q?e/14L/53DDLskdAYvlq7uxezBdsnSxVgPi83o23MiwnMPOakjvXlpyG9owSc?=
 =?us-ascii?Q?/rib76t96ZNZgQ9B49f3NvywKkkFwQCKeThL7+4GjAYW7yFE0cUKWkDWJhY+?=
 =?us-ascii?Q?+bP4XWOn/tPu8VS2GBeOfdEHqdGZwEfINEZJj7Q/IfZjYAGwpHXUqJrJ1eI3?=
 =?us-ascii?Q?SGvlnVRSucTSviXSa523vzF8oleF59PkmxG8LweR0EK4/M8gc/mrhyJ0iczq?=
 =?us-ascii?Q?3OC2FbEDTt0fHwSALqqaWMfIEUozbz1R4+u4pbmjXNP28Y+w17sRBc2Karer?=
 =?us-ascii?Q?wTZ9NKclpGW6gxPko5434RNCQqQbPUhISaXZ3V97GRykrzc3TfWWJ6qGzYHu?=
 =?us-ascii?Q?CpIylJqcKlaXAvGBVUStF4INzNesxKHaxP5ohF3PrvgDz21YLEOeJiur8aws?=
 =?us-ascii?Q?ykRz5axijKDX5KsfVNQw2skBQQYQZFpRMZDv4WmYq/o55CZ0THu8cq9XDUon?=
 =?us-ascii?Q?c+XTgNXmrF+/wanSSeoDpQfKywvUBK9SQu1Oj6li3rQ7jWlb12nuR03PIPyl?=
 =?us-ascii?Q?0akGZjiDqmvC4+kX2S3grMnYez4l2W06clfDM2apeIYwaSQ2nY3mEOlgJ5zR?=
 =?us-ascii?Q?+RhTym48AY04zr/0IZwlrXhKYR5tWpTyY72gF3Y6y3I3PB+6r/d9Q/hLdLxb?=
 =?us-ascii?Q?muoGGNAIJK+9PrkNneCiWLSwznkZWfu321RM5Uff03Wz0TL4tEUG3opA71f6?=
 =?us-ascii?Q?rgEYuxpZ6BwfeNkKAVdXDNF45Wu9pKwPZf9j7c4Fl7U3HW5cCmhh3xO0OmQx?=
 =?us-ascii?Q?GoeqX6JenUDLnAULCP5j0XR6jckXS5PJcWCD9k3QOzgN2yF7ozZTaZJAlWpS?=
 =?us-ascii?Q?VIGNNlSe2JBcMsJgJIEHa0RjVtHo60p1U7vukDT5lNgBy6LydoOtxn2AyUwJ?=
 =?us-ascii?Q?jGC5GGabBImPUZfEtkR3aj1srIXwHxab8HGdbi1Jkb0SGwNqKImRB74wXu1a?=
 =?us-ascii?Q?3Za6zf1693OQEj0kDZi+6sKZWfi1R4X8MemX7qsaxFymK+Dnob4k2QB8qN23?=
 =?us-ascii?Q?vhjRwRSEN4Acn9yJeqr/8yjgszdYbPRL0wtFn0SGTEZsSoYmktmtcd4mV3uU?=
 =?us-ascii?Q?ZmKhg9Otm1CPJzKV3MdBbkpfiRoZLLqPyTunvqJ/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cecbc3d4-fe6f-492c-a20b-08de3d474d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 08:35:58.0900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vV36+fbEOotN4GQBpc75CID64XIqv/zMw4TUP3Hn/IryP+jJmjzGFLVbS0E4K3Zh2bwOIIFaZPd8kC6aBMCb5B/x0e2BCQ54SyjCwo3c7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7263

Hi Rob,

> On Sat, Dec 06, 2025 at 07:30:30PM +0100, Andrew Lunn wrote:
> > > @@ -1907,6 +2179,10 @@ static int ftgmac100_probe(struct
> platform_device *pdev)
> > >  		priv->rxdes0_edorr_mask =3D BIT(30);
> > >  		priv->txdes0_edotr_mask =3D BIT(30);
> > >  		priv->is_aspeed =3D true;
> > > +		/* Configure RGMII delay if there are the corresponding
> compatibles */
> > > +		err =3D ftgmac100_set_internal_delay(priv, &phy_intf);
> > > +		if (err)
> > > +			goto err_phy_connect;
> >
> > Thinking forward to when you add 2700 support, i really think you need
> > to break the probe up into helpers for 2500 and before, 2600 and in
> > the future 2700. You currently have a couple of tests on the
> > compatible which you can reduce to one.
> >
> > In fact, this driver has 10 calls to of_device_is_compatible(). I
> > think you should first refactor the code to list each compatible in
> > ftgmac100_of_match[], and add a data structure which contains an enum
> > of the MAC type. You can then transfer this to priv, and replace all
> > the of_device_is_compatible() tests to just look at the enum value.
>=20
> Better yet, define a structure which defines the different settings direc=
tly. Such
> as:
>=20
> priv->rxdes0_edorr_mask
> priv->txdes0_edotr_mask
> priv->is_aspeed
>=20
> And anything else needed...
>=20

Thanks for the feedback.
We'll take your suggestions into account and adjust the structure according=
ly if needed

Thanks,
Jacky


