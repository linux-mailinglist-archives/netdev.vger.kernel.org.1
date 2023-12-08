Return-Path: <netdev+bounces-55255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E6809FEC
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD4B1C20984
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B711CB9;
	Fri,  8 Dec 2023 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="T0XDuRC8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5CD2111
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 01:50:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyXchb3gVz97vVpECqpZoKtUWetd1c60dN8l6/v7ESo8BgtzjgGLLCvX20WpwckANjjR+gqmpAMWWBUGM+2aj+s4DHK0qzO/fjIunlxavm2Mz4eLY3hWShOuIeM4DOrPw5PEpQzE1KqKOuZI6I2w2pw4M7zXXTwDOTwm7xgbXJEwR0EBfbiOqB879jpl/xAJp63zlgV1w+cZNxVMDkcU+4IU5kOAU8enEPPspRBjqrsE/cAYVRNy/1hXkzunxg4wClL+FqhRDjJ1I7MOtUT1/Xgo/ORb2VOrJuanBr505eeMnB/5cuztOhUWWAf0H4IX5BBaee6xGlbCip97WnNhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++JsssLPL0xH64EXlZAxFv9LMPQc6ko8C4CEs42VqSA=;
 b=ElqDEYxNc4Ft1g9OXf27KI0pMsdUUcMMR0meMcRV0PxlPCKZ1u5JbAwf4HAi9JnoNhugIuGTWnkaHqsQTLujc05qcFMip3IbPErWAABRepsbc6gokxVYtNDgl7YScV8Nqfo03IEggqDhDUuFAI1U1B3e3c6GlTvkHHnw91qfprUEJSD2Q5q5w5COB/7FQnA4/xsXo+k3mLQhHDin7moCuUJf6Yo+9KHIQXcALyldfCqXo6jljiIPe/QYvWpJYsOZN7nvuE8V3xmtBv5nPzCqEW61mLZ0s/sZzaKcDnlEYwdFasVs7AAXSRS/iKkX92glI2J3s3CqChcRqSv97374Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++JsssLPL0xH64EXlZAxFv9LMPQc6ko8C4CEs42VqSA=;
 b=T0XDuRC8RZEVYte9ujiLKgOMMouz0FglylpBzedcA6+kb2fMn25eyTJlsAHA7tecCec0jH5HJtIa7+CgXCyMRP8QyQXTysO6ANu1Mz8IMboFDISMrUBBzOOjU2n7p9oxGQWKBIxiKZCKScxY5YmGFOAyueVMHSauq1jTGjFkKNw=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by GVXPR03MB10457.eurprd03.prod.outlook.com (2603:10a6:150:156::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 09:49:56 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 09:49:56 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 1/7] net: dsa: realtek: drop cleanup from
 realtek_priv
Thread-Topic: [PATCH net-next 1/7] net: dsa: realtek: drop cleanup from
 realtek_priv
Thread-Index: AQHaKZJAQ13LGzURI0uPwxy6UTd6+bCfJKgA
Date: Fri, 8 Dec 2023 09:49:56 +0000
Message-ID: <bu6dcg535ubgv2btvgwfnlqcqdtvlsgnwb3tttljdkug5isxbu@eim77zwy6jxl>
References: <20231208045054.27966-1-luizluca@gmail.com>
 <20231208045054.27966-2-luizluca@gmail.com>
In-Reply-To: <20231208045054.27966-2-luizluca@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|GVXPR03MB10457:EE_
x-ms-office365-filtering-correlation-id: b843535d-3905-4b78-409a-08dbf7d30940
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VXTgwMBpq/qReslRLnUoFEekhtvVfgQBUAI+N28AQlReUyTTPUuZcbOYC+RynhAl+4xr6AytyiBCE43rtoSer+8pnz0NzEhaoY4I8x7mk0JDbFwwZhzJEZ+UtqwTWyHEMcry0CuBwgIIiP44e98rsB60hLkBcM+UyOcZMxfN+gC9qUzNHDS7N/VgnWrl7x+xvRGh/C9b9wqnste/ixVYy13TCLe4QIcCUaBOTbJv26BYQx+JbEqOT5q+8hFIfXPwIExHEXu0pzvVMl9XNhOnBilkFb8El5pp6mpkvty52jhj7J3BWfDfU/TY7FZ7SClKbArU9w4kjWLpgIsZyuoMgs0PyvGwATs+H6UVMpN/2tE2WUmtFGIHsCmPH6pGleAIuPEDEK7yhnOz688eI4TkTQvIDEzAEjOHBewt3PHRQHjqvxpV4G/wEwPbwD4G3VO9e7W/EVOApWke6SBi++IkWY79W62CiDTNXFgKBvYolmg/ia1J0DR0EHVE4gyZYI6oArckA9uOU945t0/gBH5G9Gf/afFKukmLmlb1k9twpUPcTz0f1sGmMq2NjlhWEbyxFSo7ixR2YbdofCqElOOY7NosnAM/W44WsdaKIK/2MeYnQkZx69sUeX6hW7C/0CxX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(396003)(39850400004)(136003)(376002)(1800799012)(451199024)(186009)(64100799003)(5660300002)(85182001)(4744005)(2906002)(7416002)(4326008)(8936002)(8676002)(86362001)(38070700009)(41300700001)(85202003)(66574015)(83380400001)(9686003)(6512007)(26005)(91956017)(6916009)(66446008)(64756008)(66946007)(76116006)(66476007)(54906003)(33716001)(66556008)(316002)(38100700002)(71200400001)(6506007)(122000001)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGY1c25HQTV6VWNTWmRqcEE2aFZrM09oRStiUU5jSGd6Q3ZVNHRtOTc2NTZu?=
 =?utf-8?B?cnluMWJiQ3gveU5CK05yUXhIaGlqK1dSdjViYnBtcnZHd3lHaUpmZnpzUnIw?=
 =?utf-8?B?Q0V4cFRxaXd3TkV5MTliaS9HTHQvbUZ6K0hDcWI0cjNESUJUeWMvOTdta1lD?=
 =?utf-8?B?dlIxemRSM0RUWWxJaGI5cVBFWjltcUZPME1CK2s2bHY0MVN0dWZZb2MzT3F1?=
 =?utf-8?B?d2swZDQ0blV3Sm5lUWYvckN5aHYyRkJZZHR2cEdTSUlkUkNtMGRxamRZOU1w?=
 =?utf-8?B?UTRwQ2dyTUQwQ2Z1YVduUUdBejQxSzNoLzBEbjM1amdxcG9Fa0tlNys0aWlm?=
 =?utf-8?B?dmVEN2FpSjhtaG0zNE9WcEttOUtpU2xQZXU3MWxIbU92T3oyRXlQZ3VzOFdk?=
 =?utf-8?B?aklXVjNJVXJKUUNMZlF0S0pJSEN5SGxhYW56dUgwWDYxaFZ1cVlKZW13N0hH?=
 =?utf-8?B?bWt4K3g3UlpvTmd4VE05b0hxc0twN1FrbFlXL2tUcmMwMDV5bDhrQUMrMnpZ?=
 =?utf-8?B?NFk5YjB4U3NuakU4RDR0NXRnaldNTlUvakRVVVM3bFAwaURnS2Y2cm12NjBm?=
 =?utf-8?B?VlcrS3MxenFHS0YzelE4aVNqNEF4UFpTU1AwYnhUbzdZTkhFWVdkTjYrV1JF?=
 =?utf-8?B?S1VVRFhGQlpvSGhVbGl3WkFxaUJKalVQeGo5dHp6VGw3S3lpaXFaYUdQMDVx?=
 =?utf-8?B?MFZKVkpvaElRT1FpWHJUZzlZOTQ0NFBNUUgwb1p5LzRJc0dZTUNFamlhaDBB?=
 =?utf-8?B?bmlQWFhmbjdrNUlvVW9aZ2Q5NFJNczR0VGJZTWdCWDBQQlc0d1dyUjdiTXFj?=
 =?utf-8?B?Y1FmTlpwdFFGbHc0MHJDQnVGazUyYlRjbjRzeXVxcDZkV2RtalVnelZnSDJx?=
 =?utf-8?B?d2d3OTEvWUpzL0ZvdWRuUElub29yMDZIZWt3dUE3cG1FcDhPeXFZdHljeVZi?=
 =?utf-8?B?aEZ0QmpLZXlpNGFBbmk2T0RSOEZYQkN0bm93SktHcnd6YnVNc0hSL29kdHh5?=
 =?utf-8?B?TzNONjErTlpva3RYdmJQckh6ekphUDFhVldReXdiYnZxTkt2OHZmMXBtWE4z?=
 =?utf-8?B?NzBmd09KZDk1eER6TE9kSDJOaFlCWWZqQVdpMEk3RmdTL25MU1hvdjcvemVr?=
 =?utf-8?B?dm9GTmZpY2JlTGlrVDRqY1dKRzVnNUZrU0FLdG9tUk40K0l3UW5kNUxLYjUw?=
 =?utf-8?B?SXVNWlZrKytrQi8wQTNUb2hLZyttbDRVYmk0SjIzOW9ZUTBlUWo5ZTdCSVRz?=
 =?utf-8?B?T0o2TE5PRVlNZk5HRm5RMTZKemE1bG9UVDUycWlKSnhydGVxaE1PL3IvczJp?=
 =?utf-8?B?R0ZFUFpPdUgxMEpHcnFiUzNBUWI2eW5NeEJMSzJuMjZTTHBLRXZhVk84VTda?=
 =?utf-8?B?OVB2MGFxdFk2OWFuVmZYb3JqZjRYWTN6eWhsR0hWNEo2bzBPMXNZSGJ1c3p3?=
 =?utf-8?B?MkJsNlRMaVNtdk5penhrK2hnYlg4UFB0SnpsVXg5bGZCd1ZzRlV0eGw2NTI4?=
 =?utf-8?B?L0tScHMvbDN6STJxLzdSTlRlZUZrck4vOVh1dFNlekFyNDFWWE95Vy9HYTZQ?=
 =?utf-8?B?WXFFemxsKzZxdHU0M2NkL0hWOFJPbUo0dGUyNEVHZG9qVUdETUVGNWZvMm9B?=
 =?utf-8?B?akNFSHh3SjJVVWlhT2ZZWm5uOTlxck9xWC91MEN0QWtpdzBBQnBuQ0tQcWdh?=
 =?utf-8?B?SzVaU0VRdjg3azZ2MFFQKzNhc0xSZUUzbVhNOUFFNllBVVBhOGN6ZWJGOS9M?=
 =?utf-8?B?akJiS09vdXMxV0t5aXNZWVIzc1lVeVJqbERDZmNyVjdLZnpNaGRsREpzLzJM?=
 =?utf-8?B?QnhRbzZGcXo3bUFIck83T01xSFZhYmFtNWRqVFhCM1RUTGlTTnAzZUtSS0tj?=
 =?utf-8?B?dTVoYkJjUnIzUUVaVVFiVjBlVTg1SkJtWkhhbEdTNUJkK1BLU24wcVJ1TlJD?=
 =?utf-8?B?RUFoOUUvYzg5Q1lMTEpxaG4wMGhDNE1yazdJaHNwU0VDdG03Y0VwZnNjUU11?=
 =?utf-8?B?cTNyRjRHTUVVZUxhVUc1ZHhlYVBHSmJHbldnRHoyM0pJN0hXOFpEUHNtaTZY?=
 =?utf-8?B?a0hWRXp0V3dBNXhSNkJHMnV0Y0YybzduU2F2WFZQRm0wc0YzeTlpVythSkE5?=
 =?utf-8?B?TjZPOXA2VnhnckVsSWJsRU00L3pGM0tub1AyeGdxYUVWZ0c5aUt2Qi9FWSsx?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5BA834D2584CD408F9EBDBC2DCDA3E6@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b843535d-3905-4b78-409a-08dbf7d30940
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 09:49:56.8226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PGbSqPOgJ8X5Xqmnzrq10Qq66SkFRW3EQLUOZh2id9Qfhmw2SmW2pDgbba9AQOJwZklQbTC50dDz+k7Y3UpRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10457

T24gRnJpLCBEZWMgMDgsIDIwMjMgYXQgMDE6NDE6MzdBTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gSXQgd2FzIG5ldmVyIHVzZWQgYW5kIG5ldmVyIHJlZmVyZW5j
ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWl6IEFuZ2VsbyBEYXJvcyBkZSBMdWNhIDxsdWl6
bHVjYUBnbWFpbC5jb20+DQo+IC0tLQ0KDQpSZXZpZXdlZC1ieTogQWx2aW4gxaBpcHJhZ2EgPGFs
c2lAYmFuZy1vbHVmc2VuLmRrPg0KDQo+ICBkcml2ZXJzL25ldC9kc2EvcmVhbHRlay9yZWFsdGVr
LmggfCAxIC0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcmVhbHRlay5oIGIvZHJpdmVycy9uZXQvZHNh
L3JlYWx0ZWsvcmVhbHRlay5oDQo+IGluZGV4IDc5MDQ4OGU5YzY2Ny4uZTllZTc3ODY2NWIyIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9yZWFsdGVrLmgNCj4gKysrIGIv
ZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcmVhbHRlay5oDQo+IEBAIC05MSw3ICs5MSw2IEBAIHN0
cnVjdCByZWFsdGVrX29wcyB7DQo+ICAJaW50CSgqZGV0ZWN0KShzdHJ1Y3QgcmVhbHRla19wcml2
ICpwcml2KTsNCj4gIAlpbnQJKCpyZXNldF9jaGlwKShzdHJ1Y3QgcmVhbHRla19wcml2ICpwcml2
KTsNCj4gIAlpbnQJKCpzZXR1cCkoc3RydWN0IHJlYWx0ZWtfcHJpdiAqcHJpdik7DQo+IC0Jdm9p
ZAkoKmNsZWFudXApKHN0cnVjdCByZWFsdGVrX3ByaXYgKnByaXYpOw0KPiAgCWludAkoKmdldF9t
aWJfY291bnRlcikoc3RydWN0IHJlYWx0ZWtfcHJpdiAqcHJpdiwNCj4gIAkJCQkgICBpbnQgcG9y
dCwNCj4gIAkJCQkgICBzdHJ1Y3QgcnRsODM2Nl9taWJfY291bnRlciAqbWliLA0KPiAtLSANCj4g
Mi40My4wDQo+

