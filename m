Return-Path: <netdev+bounces-183120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063BCA8AE9D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 05:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6CF7ABAFD
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916A6209F5D;
	Wed, 16 Apr 2025 03:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CED15B543;
	Wed, 16 Apr 2025 03:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775238; cv=fail; b=Wp9RbfVE6WBobv6GW6dE5Gdoity/RBnDuX1MzV2byJVLQkGRio+KsDhuGdZEVCEhoIjTcPewwN7ypPebpxXjA4bgAdGhOoOSrMeCfD/b82afoSuhYdtmKQy+CU4Du+FxTvRpwo48Wzwu2Ome6t+VdKdeQ2hra/eu5LjvTEAqUB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775238; c=relaxed/simple;
	bh=m5EJXj5KN6TCXQ6ttTAlBxui7/4xZiYsqc/swLU5ViM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXDG6yt0sY/6xZteoDtVy6VmtYlWZucJbScVvBZDUewsD1BVN/aE+JCmKmc5l+hSzZWaojdhhksOkwuH5Kx1TPgpUFVnSBGv9qzZmsDmSpuiZJnWqDuYnIDLK4AcJ6XABuVp9O/Sk18tnhIDRClMTJvvHHCxOchFYQp0n4vE/Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX3yNq9gySqLiQfruYXoZSz46NpM5DI72xnkTeAkvJ2ApSDihV1w7Cbu3jH3RKqdYUZ35H1yxm4q6scMVAn6xbTrqxag3r/pzq+5AiKUsGKMI4SdemjFyWHRv7HUXdnzZIxiuZh8M816DedRU8MNJJMTIPzrHbB97o/cPm0oX8UKXZKuYai24z0SopU9gAKsck/qDpYCusM//7hfhZhIjnrAO8yOSMzda9D9LyPaaEEroABwMjayXzMtcR1T5g/Afr/SlJ7ESfCEcYVxAyfWnwJ07T22h0e3JexfYYmbzMVpZQJP5Ort189zHB7vwv56ZBImqgRzwln/l4lQS4+S+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5EJXj5KN6TCXQ6ttTAlBxui7/4xZiYsqc/swLU5ViM=;
 b=Wa9JYHOC2M2o1LtnkQmSLV4vkv7arbdHZuG3pEmWN9dIccn+2kR1Xx/tM05szWLEn5mK0nwbfcJjoRER9dT54OuL4qNDe0FYABZ52pl8IhA4E8Ys4OAEJah7QWtTcT0v9KfR2n9tfCeK5ML1KHDwy5HFBZ3JiGvcagXmQZlgdjmsF55pjKjNv/ywrsBeu8u/idtPNp0rVe7V6h8tn/mZxUQi4ftloMuBhEasoDvZaGKuvgpk9wb2C5hJp5jsiU+PPhjVj73zW9BoivULeIO/ER79xeOIePzyanXqY+gUvUh3i5LNeRNFATJf2HhxkloQ52SeiegHeLUWQbZGZs4+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0536.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:15::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Wed, 16 Apr
 2025 03:13:08 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::f06:366f:7b4b:4c9]) by BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::f06:366f:7b4b:4c9%4]) with mapi id 15.20.8632.036; Wed, 16 Apr 2025
 03:13:08 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Paolo Abeni <pabeni@redhat.com>, Emil Renner Berthing <kernel@esmil.dk>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [net-next v1] net: stmmac: starfive: Add serdes PHY init/deinit
 function
Thread-Topic: [net-next v1] net: stmmac: starfive: Add serdes PHY init/deinit
 function
Thread-Index: AQHbqebhNuVSIJMgAUGsPuly4THmMLOkedsAgAEtSrA=
Date: Wed, 16 Apr 2025 03:13:08 +0000
Message-ID:
 <BJXPR01MB08551DB3FEDE0899B67B8DB7E6BD2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20250410070453.61178-1-minda.chen@starfivetech.com>
 <6851d6b8-109c-4de0-89a8-a56659c87cf4@redhat.com>
In-Reply-To: <6851d6b8-109c-4de0-89a8-a56659c87cf4@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0536:EE_
x-ms-office365-filtering-correlation-id: 84e0ad0a-9183-4d14-07a6-08dd7c949cee
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|41320700013|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 BnLul9cUcAj7GeF7VR9CruS6cWd1dnnVEz4oXq+zCJA7rnN6q3cMU05Dfy3D4dCnJf+GAMr3Q4wHEYH8wEARGVJPb8rVQWuLarGqQYHGOelDKO5AKoDq9wL5AkfhQhxalQ3AVEVMlAk3Y9AMGMBXOcHVqbWzcBN0jMcza4Y4S23aBSdQMcz7yCSlbi59cjC3SEIh2IsY8k3JwMsHlTK0+2qZ0B/LCGtmP7Ace3mfsYm4Qy4k7NutXEHqBBzVEXSm57noTXLyhEFE6J9XBoi+HQCujSa7AS3Eg5KyZfsMzS2QQECWyJ+NGwgv4lELmZ4sgrZkntWZCfcSn7WWZkMwpOEn1zkIWq5bqwBRQwgB+EGme9ykDB+GXlRrNlp6iHI54NhMCg1hVs9/FLgvyoNYI2Qe1AouwfNBTNgtyJi2PtL+vkaVxkHT2Z8OQ6ahzPRs806MjAuMMSBnKMoVsUM/dmAE9ak1P/71XoR+3O34mfKDUBwK8ml+fRpLvH1WlwzdFbfsAOPDCc6LeJDU/ZNIBX+x4msLFewF71rEOKT9WVtxAaZAqizjBfOzpEhDRghn/U+uhfwVgfZsH97gTIuu8bVUiQwiRtc/AQ6drFkz6C4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(41320700013)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkZTUmxHY2tsc0M0M3UrR1pBckZDTTIwZS9KdXRVTkF3WXdCd0hNLzZDUEJr?=
 =?utf-8?B?VjhQOVNQVXc3V2QyM0xKcnFPWlJrRnlSN0xZN0JvZ0s3TGJlWWVGL0JiVVVo?=
 =?utf-8?B?cmZvcVA1TWJaNkN3RjQ2c0JweXMybGFVTVZQcmNNazVsWHpLdUtRdTJHY2Vq?=
 =?utf-8?B?bEMwT0dUUUhNbitkUjd0a2p3Zml2aGgrRFRoeENWZEJuOUE1aG9WdlVrd2Uv?=
 =?utf-8?B?QjI1RTRBS282NFJYZG1aMGV6c2M4dGUrV3dHUnZpZVdhZDdxZ1ltbVFySi8z?=
 =?utf-8?B?N05MWXQ2T0I3bU5IRms4QS9sSnhsaHNoNTRId09Qc3Z4OG11VkhTQW9LdWdu?=
 =?utf-8?B?dFBrSkNZRm9DOXEwYVkwWFZuUGtqSXJ2amJDTm9MdnRrL1VaQlRPcXVUeTgv?=
 =?utf-8?B?VVE4NEN6UHlpS1hYWWh6YktpbVBsVHdnbWl3S25jUTJ6b0dBRjdoUUlSWnJh?=
 =?utf-8?B?dGxWV0pkN2VoVmZ4bFJOSjhPQjdNaEJCQmRnREZTckNMTTA5MTZTeVowa05C?=
 =?utf-8?B?Mkd4TWFNck5reisycUQyZFk4WEo5azVhaGFyQ2pVYytlcGJqLzJRY1c3Unhj?=
 =?utf-8?B?SmhpMjNtNG0yOEsveXNVdGdSaW1DY0lvNGxuWnAvTUxSMU5Sa3BpZUJPTk5a?=
 =?utf-8?B?TVJaeWhONko3ak4vRm1MNXYwSjJCcGczY0ZPRUVGTmtFVUsrYjN2U2FVbDAy?=
 =?utf-8?B?bDZtaytTYmxOWUl6V21YLzJKNE1PWkJ2aEVja1psTHRxbTlFSnVYZDJpS2lY?=
 =?utf-8?B?MnIrQXVLSEZkeDJZd0p3cGM1a1FVWkYwclRMY2pFK0M2eTQ1M0hwRHVoN3B4?=
 =?utf-8?B?Z3ZTb1NaWlpMR2kzYjlHc29SUTlJRFE2R1RmWDVvT3R4K3M3R1RjTWpwdXZt?=
 =?utf-8?B?VVlNcSt0cHhwamNYMytSNlVyQTFiZWw2R01IL0N4ZTVXTTFrSFV3ZHRXSzJS?=
 =?utf-8?B?NFhWSWF3RDA3MmJOdWVDZEIrajdKOXlPRDJyRzJjVFNGUUwwMkFGVG04SWVV?=
 =?utf-8?B?Y0hOYzZMbjdyUnBQdG9SMGJhWkRVSzkyQTJScTBDK2pHOWN2aDNvYWZnOVFi?=
 =?utf-8?B?ZWxKL0RCYk5JZnRVT2xNRWlFZXV0UFV4TnJ1c3BoSG9ReHdZV3kzcWo3bWs5?=
 =?utf-8?B?WUdjK0hnQzFzdCt0WEl5V0ZWVU9QaXBYSVFlMmJrcVFYdmZUaGEyNkdvcHUw?=
 =?utf-8?B?WmxGZEtDNGRxUEQrVFBXL2o3cFpWalZBOXRFUThNcVhMNkRoODIvdkI5TVFJ?=
 =?utf-8?B?NmpjS0taMDFvZURxS21oQjhMNE1zQmdoUEhURXQrUTlYR1BVajQrYnRRYWdQ?=
 =?utf-8?B?ekUrdklNV2x2VkhoK1c1N0hlMkJjVmpFTkRVc1hDcUV6bS9HWmFIaXJUeTVE?=
 =?utf-8?B?OXV4YjUzYi9zd1JuaEs3aXJXUHgrb1psY0VhVXh6M2FWOGhjTlRuODdzUVov?=
 =?utf-8?B?MjhhVTNlK0JkVVBqQXdvRWRROVZzTVhqY2dseWdWSkloZk5ROXcxVm1TZ3ZS?=
 =?utf-8?B?L3Fpd2l5cFZxS1ZDcEJCekY5dW9haHNHd3pudGJ5L2EwaTVubnE4bEJtQ1Bw?=
 =?utf-8?B?T0FybGpVV3diMGhlWFRwNktNS0gxNVpVVXNaNzJhQmhPN1dOaVVCZEpuNElS?=
 =?utf-8?B?VEJGNHFIcnJUeEpWZ3NOK0c4SjB2REVOM3hMQWZGZHFzMU1UNWVVb3BFcE40?=
 =?utf-8?B?ZWh2aXlGNnNybGtkOWNDTHZCL1NxYW1MRGtiTFFqTXFic1U5VVMzZGlja0Vy?=
 =?utf-8?B?NkYrLzByS1FFNkl2K3BwR2VXeCtUdzRqVithbjhyUlY0ZkVzY0JuY3d0MldI?=
 =?utf-8?B?L1ZTSEM4QndYdWNRU28xRDcvMW1WQ1VaVlpRazJFOEorekdxOFUyTDYreXo3?=
 =?utf-8?B?c21saERKdktTTFZHNGU2NzBhRS9RV1BWWk1iODRaK2xxWGcrUW8zL1lIY0hU?=
 =?utf-8?B?YkxQVnlRcFZ1TlpwQ2p1Q2trVFU5Q1g3SitqbVFsZ2JmRXg3d3FjcThJalRO?=
 =?utf-8?B?dG84eTlKb0JPZHFPeEtvSVJNemtpTWcyVktEaXR3TGlPKytiWDRDWDBDcGpO?=
 =?utf-8?B?K205V2pNclpwT0dJejlWdmdiWWdJN0hDSmdhOWhrRXpvYjc1RFN2UWs1dWJB?=
 =?utf-8?B?bHp4Nkp3dFNwb29QZWZiVGJYMDVoZ1EwS0RBbGtkVi9NZkVCVStLSTk0N3pa?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e0ad0a-9183-4d14-07a6-08dd7c949cee
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 03:13:08.5719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JChSW1DbqvNDZeKOgzWqlS2pltfZ8/PFtfQIFxLntbYPSNScX3NEopnzrG7Ajh9X6jpgzZ9cZOYWyp+YBKfzNenWZQQGyAm0itpe2GyVtRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0536

DQo+IA0KPiBPbiA0LzEwLzI1IDk6MDQgQU0sIE1pbmRhIENoZW4gd3JvdGU6DQo+ID4gVG8gc3Vw
cG9ydCBTR01JSSBpbnRlcmZhY2UsIGFkZCBpbnRlcm5hbCBzZXJkZXMgUEhZIHBvd2VydXAvIHBv
d2VyZG93bg0KPiA+IGZ1bmN0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWluZGEgQ2hl
biA8bWluZGEuY2hlbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZXRoZXJu
ZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtc3RhcmZpdmUuYyAgfCAzMw0KPiA+ICsrKysrKysrKysr
KysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYy1z
dGFyZml2ZS5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21h
Yy1zdGFyZml2ZS5jDQo+ID4gaW5kZXggMjAxM2Q3NDc3ZWI3Li5mNTkyM2Y4NDcxMDAgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHdtYWMtc3Rh
cmZpdmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3
bWFjLXN0YXJmaXZlLmMNCj4gPiBAQCAtOSw2ICs5LDggQEANCj4gPg0KPiA+ICAjaW5jbHVkZSA8
bGludXgvbW9kX2RldmljZXRhYmxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9k
ZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BoeS5oPg0KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvcGh5L3BoeS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcHJvcGVydHkuaD4NCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5o
Pg0KPiA+IEBAIC0yOCw2ICszMCw3IEBAIHN0cnVjdCBzdGFyZml2ZV9kd21hY19kYXRhIHsgIHN0
cnVjdCBzdGFyZml2ZV9kd21hYw0KPiA+IHsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRldjsNCj4g
PiAgCWNvbnN0IHN0cnVjdCBzdGFyZml2ZV9kd21hY19kYXRhICpkYXRhOw0KPiA+ICsJc3RydWN0
IHBoeSAqc2VyZGVzX3BoeTsNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMgaW50IHN0YXJmaXZl
X2R3bWFjX3NldF9tb2RlKHN0cnVjdCBwbGF0X3N0bW1hY2VuZXRfZGF0YQ0KPiA+ICpwbGF0X2Rh
dCkgQEAgLTgwLDYgKzgzLDI2IEBAIHN0YXRpYyBpbnQgc3RhcmZpdmVfZHdtYWNfc2V0X21vZGUo
c3RydWN0DQo+IHBsYXRfc3RtbWFjZW5ldF9kYXRhICpwbGF0X2RhdCkNCj4gPiAgCXJldHVybiAw
Ow0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBzdGFyZml2ZV9kd21hY19zZXJkZXNfcG93
ZXJ1cChzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwNCj4gPiArdm9pZCAqcHJpdikgew0KPiA+ICsJ
c3RydWN0IHN0YXJmaXZlX2R3bWFjICpkd21hYyA9IHByaXY7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+
ICsNCj4gPiArCXJldCA9IHBoeV9pbml0KGR3bWFjLT5zZXJkZXNfcGh5KTsNCj4gPiArCWlmIChy
ZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gDQo+IFRoaXMgaXMgY2FsbGVkIGFsc28gaW4gY2Fz
ZSBvZiBQTSBzdXNwZW5kL3Jlc3VtZS4gRG8geW91IG5lZWQgdG8ga2VlcCB0aGUgaW5pdA0KPiBo
ZXJlLCBvciBzaG91bGQgdGhhdCBtb3ZlZCBhdCBwcm9iZSB0aW1lIG9ubHk/IFNpbWlsYXIgcXVl
c3Rpb24gZm9yIHBoeV9leGl0KCkNCj4gYmVsb3cuDQo+IA0KPiBUaGFua3MhDQo+IA0KPiBQYW9s
bw0KWWVzICxUaGUgc2VyZGVzIFBIWSBjb2RlIGlzIHNpbXBsZS4gIEJ1dCBJIGFtIG5vdCB0ZXN0
IHdpdGggUEhZIGNvZGUNCkkgd2lsbCBzZW5kIG5leHQgdmVyc2lvbiB3aXRoIFBIWSBjb2RlLg0K
DQo=

