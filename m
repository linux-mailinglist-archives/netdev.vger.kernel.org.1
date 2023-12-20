Return-Path: <netdev+bounces-59242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C11981A06C
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFE61C227E0
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B73374E4;
	Wed, 20 Dec 2023 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="MMfyZ25o"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2117.outbound.protection.outlook.com [40.107.22.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C373B2B7
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+lkp0Fcoexmnj+VIITHJ8/IimL+3TfLCpPCOY/8g2u4kBCfu0Gf2I1zrJ7PFeCRVrAnBgRkKD2suVz2H4ksZumC2TvWuezkuFRM1il6iOAEmDotoTEilM9XFRbCA3t9T1Abku9DZjvXsbv8d5v8tPQsjG6k85F9RFo30PAzO7DiS4ooi9cjD1D1qtgjMTget216HJAJ1B5gbl3o3xU4rghOEB5Vs2aUTSCn4t6o311jNYhBROVmVmiGj1p6sClbHlCo2BbjJu5LPocv69hm78nY0RjjINeos//xLIXuPv2vQ+J2h1Ei+Sinx44fo/4k3oA1Pn4mdrOvaZBcah302g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTYtvHpkVDUWVSkUtRqVEjYkKrJiJb4ORfC9OaMeaio=;
 b=m4DaW32NYOX5GGnP+qRAE3PNaadAGsSdZL3KeabN0HZe2/j9DtOM4LDAvxRDg846jfIWO387fVPft7d7rI2mnKch3pyuP9MwxAQAHcFkvThqpDZYgGuVfsLwVaZqtZDkXFr1cXuaJJ5TUibtlT2viGO8Ukkxzjce+YF24uwIrwPEwdjfghgGBPjHb7RX4bxcLToJ75K+ahhMZr/4r1Dt3C6fDmS85MDpp21S88SILLXo3Uwms9JoKFCl36cvdm/C4+T4pHeHfIuP/Z7Sezi3sSkgC3iyLOM2wVQl5i+anchWWJCJEyKbhIkX14fWEN5YQVI2ex2dY3oMeDaUSbC87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTYtvHpkVDUWVSkUtRqVEjYkKrJiJb4ORfC9OaMeaio=;
 b=MMfyZ25oXG1H82KYsCoVz6SoCIxpeCBnARnyxC4IyNOZ+CYp7GWL44fIrJbx+rP/4piCW4XeNVd2JPgU++pX+bq6tA9Xx3beR5UgXrn33cl9LKsGCTfNZngyQYeFdH1dy7oMTdvBvUFZfHPrUY2VyRZR7CLAHMAYaWFbkfp+Yuo=
Received: from VI1PR03MB3950.eurprd03.prod.outlook.com (2603:10a6:803:75::30)
 by AS1PR03MB8287.eurprd03.prod.outlook.com (2603:10a6:20b:476::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 13:57:41 +0000
Received: from VI1PR03MB3950.eurprd03.prod.outlook.com
 ([fe80::192c:39ce:80b8:fc2a]) by VI1PR03MB3950.eurprd03.prod.outlook.com
 ([fe80::192c:39ce:80b8:fc2a%3]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 13:57:41 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next v2 1/7] net: dsa: realtek: drop cleanup from
 realtek_ops
Thread-Topic: [PATCH net-next v2 1/7] net: dsa: realtek: drop cleanup from
 realtek_ops
Thread-Index: AQHaMvzGDp0XeS+svECBFEZw+tb/bLCyMw0A
Date: Wed, 20 Dec 2023 13:57:41 +0000
Message-ID: <w2xqtfeafqxkbocemv3u7p6gfwib2kad2tjbfzlf7d22uvopnq@4a2zktggci3o>
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-2-luizluca@gmail.com>
In-Reply-To: <20231220042632.26825-2-luizluca@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3950:EE_|AS1PR03MB8287:EE_
x-ms-office365-filtering-correlation-id: a4d83b16-2cfe-4103-d642-08dc0163a1fa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F7QDyIleYpxZ3ax5PWdbNSb5neHOSETaMDLjxZ873H3uuMv7WVSTioYyC8XTl+341OqouG02RWbiKOxeZJnwZQiRX3bQSvRmXvuQl4on1vHoOLobn5jOVJaV6AFKMxEi+qSteRbJpXBapKr6B0tfNwov23JYhFpdWqe1N2A+ojnV+QlptB8qy9oI+Q2xbTqPcOcYD6xOVwb2YeK8K9aopyROWa8kcW42SeQnONDO3AqyMJxF3t2c/U0wWUilbYTywm7GoabYndjmlF3ivsyvkgpF4OY8txnKSgsGw/cVyu/TuysWHcAEpXBLOkzYR3kB+XMG2XYc3YmH9sLizBz9NmV4plbAPp7iBkZvYcobrdNyGxpyK7KqsF+vsa+ie/NI5++u7QaCYew/Y/YgWimijj2sF0E1HthejtVDtajVqzHa7cX5pDjsAP6j/Rx9lpd+3U1x4UIlWv4KlNNktxeQN6c7H8osdP6ataREio/EnF55LzMtT0L2rsW/j9sJUICYxqx2D/YFRHWscvSO+1NINxUhyIww5l0ib5/uEzukuIklL9NcX1/dBnhk7YXWzhLEk8/UANZCKowWdsr9NDNZ1vRe6kJKt1ph1FhmnyRu0/aqiHJn3P7k72U7HDSiIVkb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3950.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(366004)(39850400004)(396003)(186009)(1800799012)(64100799003)(451199024)(33716001)(41300700001)(4326008)(9686003)(71200400001)(6506007)(8936002)(66574015)(6512007)(8676002)(6916009)(38070700009)(38100700002)(5660300002)(316002)(26005)(4744005)(7416002)(2906002)(85182001)(6486002)(122000001)(91956017)(85202003)(66476007)(66946007)(64756008)(478600001)(66446008)(54906003)(66556008)(76116006)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWVTSkdLUXNkQnlRQkwyWC9iaTBIYlA0RDBFL2pjbmQ3U2VoYkdtQStSdTBk?=
 =?utf-8?B?VzhDL09iVHo5VSt4WFdnWUFCK2dHQnJ6aW8zck5xZ1dEZm44K05iUmJ6TW0v?=
 =?utf-8?B?emEzZndzSys4MTBLV3Bqek4rWE1nM1BmSXB0K0xYRnVtU2N6djVUY0NTTlZE?=
 =?utf-8?B?UmFkZDkwWC9DTmpHZ1hueUpTUU4rZ0tETUJRTDhLZ3I2VGNqejlOWTNLR29t?=
 =?utf-8?B?RmJ3dkFIcWhCQ1hETWw5TnNZTW4yNmM4VFUvL3VOUGwvL0pYMVF5b2lUMjMy?=
 =?utf-8?B?dVdwUWdSV05hd0NZS2pyTk9SdDFEa1IyYllMU1RJMmkyNkdvTzRHVEFzOE1F?=
 =?utf-8?B?cWRZUkFIU1JMU240SXFtMUllWFFkRGhPVm5ISE5tRWFvSVY0WVRzL2N0UDVh?=
 =?utf-8?B?Q3FYTXR0V3J0SXY1VDE0N2h4MHI2QlNwSFQrTEI2S1FZQzN5VmU2QmFWT2FC?=
 =?utf-8?B?cHM5dTIweDFNZWtYT2x5NVQvYWRiZytyb3JoTGtlNUMxSk4ybXo0UkkzWGR0?=
 =?utf-8?B?TVdwMzYvYnpMbkdBRnJUSmw2OUMzV0JnbklkVytvSm1GdXBVODdTTVdnSEo2?=
 =?utf-8?B?eEV3dWg2Zm5Oejd5dmpHT3IyYzFRQ00vWmtkQzJwbHArWTR2NVhiaGtWWGpH?=
 =?utf-8?B?QlVZOGREMng5SWUyNitYcVlBL1FlQldxbE16c1NZTHJxNkcyOHVlL1MvZTFU?=
 =?utf-8?B?R2RJQ0Uyb3pONkMwdTN2cGk4Qnc0bDk3SUdiM1BnVlI5U1g0ODV1MXV0cE1W?=
 =?utf-8?B?c1BzRm43b1B4SmwyNzdLaVg3cFNMWGtiaWNkb0JFbWRsMUlUNFE5bEhpUUE5?=
 =?utf-8?B?NEZodkdpYlhuaUV6R0R3SDJLR2dLeC9LUTErWUdZYUFnQnRQLy81d3FQQWtk?=
 =?utf-8?B?eGFQalJ1Yk1HekNjSzZnWC9BR2F0dHpnTDFPNlRRRGV1VmxSd3dlUm1IRWpp?=
 =?utf-8?B?R3d2M1BRdjZRUld6aXZNVHVHQ2VpdjBJUHNaR0tlTjJVRnJDU1FyMTNXeXg0?=
 =?utf-8?B?S1BLTGVudmJlWnhpcFY1QU5ka2ZVYU5kYzhTOE5DV3Vmc0E1VFRudlhtSnBG?=
 =?utf-8?B?WnBHcWY1NVc5TFBUb1hZek9ZVFBtcFF1MXVOa2JVMU1JY0d0cmJWWmp3bUhX?=
 =?utf-8?B?bFo3SGhtTDlqN2hxZ1BEalYvdEZwa1FwWWZaZ3RnR05zOHBjL1hXcHFvNThM?=
 =?utf-8?B?TzluVGNKTVY2UzVvaHc1WjhRQWhuZHFVSUpxMVRzZExzb1YrUnRLV0hPSi92?=
 =?utf-8?B?N2hyL3RxMCtHeUtrWWU5WWpMOWxhU0tPQm9xNy9UTmpYVzZZclFqS0QwZENi?=
 =?utf-8?B?Ym1uaUxsTnoxTHRYSVJObHltUXVscWR6MjBSQlk2NGNsQ0xyT0NnbjlUYm1u?=
 =?utf-8?B?RStVL0RHMGpQWkMycHJGMjdZcmc4TnllUElmQ25ZUG5YbVhSblRxck5HaEw5?=
 =?utf-8?B?a3MrOW5zSVJpVGpyS2ZoVjg4OFlucHZtdmFmWVVhRU44aWdRQm5ETXZZTG1m?=
 =?utf-8?B?b3BwT0E5UnRsTktsM2VxNU5oVHl4TmtGSTNMZThkZ2Q5a01FYlBhc3ZiZEkv?=
 =?utf-8?B?NTZsenk4c2JOcExOMjhDd2dQUWoyUEV6by91bUtUZE5xVG9GKytsWGpmQTZi?=
 =?utf-8?B?WkJSZ1FLekFJNHVtVC9vVkllcFJJUU5VZzM5S1JOakEvdEorYytpWWkyWWVp?=
 =?utf-8?B?WDR2bGNuTVdtZHFZWU5VMTg2Nk1aRDFnVUs3dmdQandCcEd1YWxpanlnaG1D?=
 =?utf-8?B?YVYrKzBzdjE0MjB3ZUk0MGphMHBpU0JJRDBSWWxlSTlBVFNXSG9vS0VKRFBw?=
 =?utf-8?B?eDcxSVdJSFdzMWVaQXdSWnVGc3hXRDUvcm80NFZSZnJtY1NiUHdVMjlYM0ZV?=
 =?utf-8?B?aUtLWFlVcFJLUmZtRUx3Z085L3k4UlkzTFduTml5U2lwVXlOVmtDY1dyMjVm?=
 =?utf-8?B?WWRjRmY5ajBGR1IxdFAxR3lDYmFrdm5iTTdheGZhVEhEV1dRdkFPTkZHOGZN?=
 =?utf-8?B?ODB3bnQzREpqckNvRDVXUlBQR1hDMUJEV3YyQ0NpODZQa0hxdjAzY0pYcnVG?=
 =?utf-8?B?QzIzWkFDaUkzeDAwbnYvZ2JPZGN0UUswd0dqS3RZQ2gxdStRbEl5OWsvQ2tt?=
 =?utf-8?B?bGVSWXZCc0hYL0JJL1A2UXZPSitYRXVBOGsrSlNmenh5MTYwcjd1ZTcyVXla?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4383DF4ED8D0D4FA4F9C943EF70441C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3950.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d83b16-2cfe-4103-d642-08dc0163a1fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 13:57:41.0378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvfqLCVhi0H1nBZ4Xf3plM8Amd6ouWK2XGTrje/yVwCehkA3STiRryjsD50ZowWhIvG3K7FLD8V+cqw7zY52vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR03MB8287

T24gV2VkLCBEZWMgMjAsIDIwMjMgYXQgMDE6MjQ6MjRBTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gSXQgd2FzIG5ldmVyIHVzZWQgYW5kIG5ldmVyIHJlZmVyZW5j
ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWl6IEFuZ2VsbyBEYXJvcyBkZSBMdWNhIDxsdWl6
bHVjYUBnbWFpbC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5n
LW9sdWZzZW4uZGs+DQoNCllvdSBzaG91bGQgYWx3YXlzIHB1dCB5b3VyIFNpZ25lZC1vZmYtYnkg
bGFzdCB3aGVuIHNlbmRpbmcgcGF0Y2hlcy4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9y
ZWFsdGVrL3JlYWx0ZWsuaCB8IDEgLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9yZWFsdGVrLmggYi9k
cml2ZXJzL25ldC9kc2EvcmVhbHRlay9yZWFsdGVrLmgNCj4gaW5kZXggNzkwNDg4ZTljNjY3Li5l
OWVlNzc4NjY1YjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3JlYWx0
ZWsuaA0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9yZWFsdGVrLmgNCj4gQEAgLTkx
LDcgKzkxLDYgQEAgc3RydWN0IHJlYWx0ZWtfb3BzIHsNCj4gIAlpbnQJKCpkZXRlY3QpKHN0cnVj
dCByZWFsdGVrX3ByaXYgKnByaXYpOw0KPiAgCWludAkoKnJlc2V0X2NoaXApKHN0cnVjdCByZWFs
dGVrX3ByaXYgKnByaXYpOw0KPiAgCWludAkoKnNldHVwKShzdHJ1Y3QgcmVhbHRla19wcml2ICpw
cml2KTsNCj4gLQl2b2lkCSgqY2xlYW51cCkoc3RydWN0IHJlYWx0ZWtfcHJpdiAqcHJpdik7DQo+
ICAJaW50CSgqZ2V0X21pYl9jb3VudGVyKShzdHJ1Y3QgcmVhbHRla19wcml2ICpwcml2LA0KPiAg
CQkJCSAgIGludCBwb3J0LA0KPiAgCQkJCSAgIHN0cnVjdCBydGw4MzY2X21pYl9jb3VudGVyICpt
aWIsDQo+IC0tIA0KPiAyLjQzLjANCj4=

