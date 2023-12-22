Return-Path: <netdev+bounces-59889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD5A81C8D7
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 12:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE041F22ACD
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74157156D0;
	Fri, 22 Dec 2023 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="ef4Zaupu"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2101.outbound.protection.outlook.com [40.107.7.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A717984
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2TUs7lFwAswNgf0y+nOGq8weR18MmI8RCIzWWaZCvyTOxaJf6072M223cZyuOfb3qQWS+a9JaA0PS/1F68JKlISekijUm+cMtiuYyHecOn9OsGZmQmQNjEDAODBtJBCncI6V9GAkhzEp3rLtp6VE/4cGMCcdNsiNE50647+POuF8VKf+NtpaP6x8GwDjZ6ZGri6/nbWmZBzjhhP+iDulPxsia6Y4UUXNFsCNyTKRwD9Sy4OSnsQp+13bdQLn6MGKNfTevku6tLj+X16ndxXa/Fj0vairLzvwezdvT+rqzu10Bxf/OeRmIflFolbHk26E1wQrbSgV+y07r9xSln/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gJqpZHuXdf5ovqXjmR/2BFIAQCtNZXnj4oJAkjKVq0=;
 b=LCF0aV9G7vzBTwNgKk95dBg280JxdCr6Za4VXK5AOdlS/OrOhbiMvxZgMdo+KZAKRRtKGtkBGfbBTkDCPhmFJjT51DIbmWLouCg0mSlp6oQ/RpTprFLhmmehKTZ86tRn2WGbxmFOHCA07iK2LwpCG7El7lqdjyEoikZZlV+Nlm83ElzMC8+Y6fv/tjkBkU/u8d09HQ9nWtVPYEOqFI0cjpNSqAcSgvqk4eQ6oH4VDYO5iIJZ0AqQb7q8gsIXL71tOe9oxAzeGjnoYdv8QTK1p/ZqtmyXe39MFdH2cXSYtIuZnFZO8wYIErUpt+Te+JIxt4CsMDbBU2R0Lf1jp8zqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gJqpZHuXdf5ovqXjmR/2BFIAQCtNZXnj4oJAkjKVq0=;
 b=ef4ZaupuQKCkPJuR2WZomF/ClcpoLKJOeanl9IRY7VBBnwfwQpD5emNcQURf60lr0mb+Y/gstajoLxVjycynfQuP0w1vFUHWI5IP2hqz71dqr9CfsNLoLf3uNT9pCv+PsSU4LzR6Bz0rH/FUZkZeRJ5kxVURtT7XE8Kt8PDFFZ8=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AM9PR03MB7508.eurprd03.prod.outlook.com (2603:10a6:20b:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 11:13:12 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 11:13:12 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Vladimir Oltean <olteanv@gmail.com>
CC: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, Luiz Angelo
 Daros de Luca <luizluca@gmail.com>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
Thread-Topic: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
Thread-Index: AQHaMvzQSiO6n4HBFUSJaFCf73YRLrCxmkiAgAJrWgCAAA0pAIABEAmAgAAG5gA=
Date: Fri, 22 Dec 2023 11:13:12 +0000
Message-ID: <hs5nbkipaunm75s3yyoa2it3omumxotyzdudyzrzxeqopmnwal@z5zpbrxwfsqi>
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-6-luizluca@gmail.com>
 <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com>
 <20231221174746.hylsmr3f7g5byrsi@skbuf>
 <d74e47b6-ff02-41f4-9929-02109ce39e12@arinc9.com>
 <20231222104831.js4xiwdklazytgeu@skbuf>
In-Reply-To: <20231222104831.js4xiwdklazytgeu@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AM9PR03MB7508:EE_
x-ms-office365-filtering-correlation-id: 042e15fb-a086-4515-e46a-08dc02defce0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6div+NSAYISGhVIDdIIsUssuGa/nwLzsNWf1Gf3f8j2dyhbrzhG7ASe0Qhi6rn94GMa2RrJe8PRu4LHeXPbdlNgCtNjpc+Xc6zJ9C3dvhjcSob124+VKF3TP20hieqC8RZ7Pa7WGG6G+EjxCf9R4Vgv9ccm/kBQ7Mhbg3tBwROVIzq2dotg8sWLuNIkEf2++4Uy3G1G+1p5fAxwRcCjNugS2UvrmmilJ0MRbgTbppHZyC0VYU2Kd+6WyxD2v6SCDUYBReOsCzJigRt31Z52L5BM894vNjmxdo5Mlor8sRK7JoQpwxWOv6IK0jiOiYupiPsFY18pr71SIdPo8xhI0GXEPcCggUXRkmHTwAkR50JcxqeypR15zYxLQ6prvBR5FMe5xi/vsi6oTDF/e3swHR2hXPAxyX4z72adwfld+FSF0WfK0EhzxFfMOdwTg5JkADooVb12aMcv/EfN7MFO8os/d0ANKE2dlMTLJtJmKjorvl4H4boQRx0JuD2RD4LsmFZIbax4jZGcC74+8X+2FTatKzz+vLEdUpI+ATjjF4PXicwvCD2N+qZHRMzM0gzZOp5GJny5/wrd47Gi7xtvlvYmgmpfPkMxE6V9ri87D+6KjOx+0mp/5Vs6Wbv+Q1Wjn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(346002)(376002)(39850400004)(64100799003)(451199024)(1800799012)(186009)(66446008)(4326008)(122000001)(8936002)(8676002)(66946007)(76116006)(91956017)(66556008)(66476007)(6916009)(316002)(85182001)(54906003)(7416002)(85202003)(2906002)(33716001)(41300700001)(86362001)(64756008)(38070700009)(38100700002)(5660300002)(26005)(83380400001)(6486002)(478600001)(6506007)(6512007)(9686003)(53546011)(71200400001)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFRMR3BDK0ZvbjJDZ0pTa0l6QWRwTnY1Mi9QQWJ5cjVNR0hwL3RRR0pLQ21t?=
 =?utf-8?B?eit3QUVTTDdvd2Z4Sjljd01sejdUdUVFVnNGV2hJcEZjbDE0S3BnYjNJeWJv?=
 =?utf-8?B?cklndVRJT1UxUjBIV0t1bzBSaHplaGdmcllWblB3MUpXUy9jSENOZWNtYnNk?=
 =?utf-8?B?ci9rWldxRFB1dlZZZU9mS3dBYjRNMUlDOFdCNWNvVXdERkNTMTJyUzdXTnY1?=
 =?utf-8?B?aXUwbTVIcGFVNE0zOXRkTkJhaXU5WlJsWmRJbWVWMUI2Y1dxQkoweklEempa?=
 =?utf-8?B?RG96cFozYlJLd2RISHh2M2FBTVNYcVJUZ0FpR3BoVWZQZEtFRjM2bTY4VmZR?=
 =?utf-8?B?SDMrTzIvSTRVMERjS0VsSklod0tzY2REcEZqOVFzODVvTE1iTGZ0SWhxb3NG?=
 =?utf-8?B?VXRoZmVpbHNOQlNmRFNpeFRZMk9HMUpDZE8xdUI1VEdSTzVrN3dxdFM0aWsx?=
 =?utf-8?B?YWxScE9wWEtEWDNJbnl2dkh5TTN3R3dlbkpmYTFtQjZNMkpEMVJDeGhESGFG?=
 =?utf-8?B?YXRZUnV3L0wzcW5tMHc1UTN4RGxzN2pwdFAvZS80OTBmdEJQMW12Uk93UklC?=
 =?utf-8?B?d2xkdDZQVkl3M3JFRnpJaUZxSGc4SjYwQUVzTkdkRW9nZEtyRk00SGliVGp0?=
 =?utf-8?B?ZnE4NTEyd1Q2MDFrWmx5NEVJWTN3TFEzenRKMmx3UGMraGVqZUUxTkJVUVM2?=
 =?utf-8?B?QWQ4OTVqdmJaM3VoVHQwSStSRkp0QmFLZFlyRGZZNk1GTFp4aXR3a0RpTVlE?=
 =?utf-8?B?aW9PSFhMWXloQ3RyanVicC8wK0pmNGdMWTc4bFNCTDJUYWlNeFVXQktORzlF?=
 =?utf-8?B?TjdWbkcyMkp4L3BzNW83VU9iSHNwMTZKbkFJZ0o1ZjE3Y0FiZjllUWpyajhP?=
 =?utf-8?B?NWlZQlhFbHFKZHphL0JIbDF6NkNIZXlLTzlFdzhGaDB1WEhzOVFuMkIveElU?=
 =?utf-8?B?akZiWEdPVUpOWFVZT0dzM1FTczMvMHBmQnk0aFE4c3BQYU9vSTl4RVRIOXVW?=
 =?utf-8?B?djU3MmJHeWw1Qk9yTVRFTTM2NlNEMG0vQzdNRXBZU094R2JWM1R0VmRKc2RP?=
 =?utf-8?B?NDBCRjlVMnNyMXJaT0ZGNkFXd2ZKM0hkdVZkMUVrL3gwbVYwemdvQ1Bjcm5o?=
 =?utf-8?B?Z1NNelJOUE1QNHRra09Rd2tneWNkS0lEaHpDUnJtZlBQRnZaVUcvVjZONnFq?=
 =?utf-8?B?MHZYT0VyVkhTcGpjVmhoU3NXUmtqQzFvRDA0NURGTGFHRzdBeTBIa05DalVr?=
 =?utf-8?B?WUNzVEF0QTIxdStkd1dNU1JnaDN2T2hNcnRscDNWSThWNUZ0YnM4ZHFURVU3?=
 =?utf-8?B?aTdJemlRcnUwUVZJQVEreUdmNmpPdDZOUVZmdlJ1cWVZSkRlR2s5Ty83bFpJ?=
 =?utf-8?B?U3J5ZDhrcWpKVjFHUCtzcWZvOWRjNmR5M0ZnN244Ny9oOEcxNTIrZWlOeWFs?=
 =?utf-8?B?WTdIWGwyZSt0ZWFTK3BSYmxkM0NkTUhDNU1PMWRENlRLeWdCVHBiT1ZiaEww?=
 =?utf-8?B?OFJyRktNMjFDczdFY0hqQjFkQlBuVFU2NFEyd09GQk41UUNQdDFXYjZWTXV3?=
 =?utf-8?B?Y2VJQjZRUGs1MFdyU3dIK3RDelk1LzdFR2pLNjFaYjJZeFVCOEtVeFZLSkp0?=
 =?utf-8?B?NVFZejNieXNtRjBUaWxzT3VCcEFNVStrK1RlUi95TFpDS20yV2V4K1JKeGhs?=
 =?utf-8?B?T0h3RE1CSEJxQk80YWdJMVJBOThaMzBlNDFnWEd5V0I3dU9pR0FyYkdzc1c1?=
 =?utf-8?B?Y2tpVW9wWXpSSm1NbXNjb3B5T1pTTi85VFY2eUhhUDlvTzR2Mk1vRHJjdll1?=
 =?utf-8?B?dmc4T1RUV1ZhNDJKbjlwWFZvOVNoaTY0aGo0ZlJtdndyZ2xtNFc2cXJicUhT?=
 =?utf-8?B?R3d5b3N3Q1U1UUxpSWg2ZExaR0FiVWh3THByVTJIUndxZlgxNGV5QnduTzhT?=
 =?utf-8?B?QTBNaUdBTkNBZmE0MnJKUWtid0hNYXR0Y084UlNlR2xRWDZLdFB5Uk00N0Nk?=
 =?utf-8?B?aFZQYzJoaUQ1eDVZbGJMU2QyMmxtT3FJcEZOQjBUQzZpb1FVeTEveEI3ek4y?=
 =?utf-8?B?MFluZjdZTVB1SzdqNXNiZ0UxZEJFbmN6SkwybW9jODRFWCs0c2w0eko2ZGJJ?=
 =?utf-8?B?cW5Pa1llQ0tHRjV3OUJhRW11RE1XZ3VldXNRaW10QWpQSXpJZVZFUHpPVTNn?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00C414B706D2854DB09A470C592ED45D@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 042e15fb-a086-4515-e46a-08dc02defce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 11:13:12.7800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHUKarMwvoOAUpW9q8QwKkFsGSXoZxLA/RCIpCfq0kF/X0+Y45oD7+bohTaEn/64hJnUXRvJWGKrxKcsS/GvWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7508

T24gRnJpLCBEZWMgMjIsIDIwMjMgYXQgMTI6NDg6MzFQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBPbiBUaHUsIERlYyAyMSwgMjAyMyBhdCAwOTozNDo1MlBNICswMzAwLCBBcsSx
bsOnIMOcTkFMIHdyb3RlOg0KPiA+IE9uIDIxLjEyLjIwMjMgMjA6NDcsIFZsYWRpbWlyIE9sdGVh
biB3cm90ZToNCj4gPiA+IGRzLT51c2VyX21paV9idXMgaGVscHMgd2hlbg0KPiA+ID4gKDEpIHRo
ZSBzd2l0Y2ggcHJvYmVzIHdpdGggcGxhdGZvcm1fZGF0YSAobm90IG9uIE9GKSwgb3INCj4gPiA+
ICgyKSB0aGUgc3dpdGNoIHByb2JlcyBvbiBPRiBidXQgaXRzIE1ESU8gYnVzIGlzIG5vdCBkZXNj
cmliZWQgaW4gT0YNCj4gPiA+IA0KPiA+ID4gQ2FzZSAoMikgaXMgYWxzbyBlbGltaW5hdGVkIGJl
Y2F1c2UgcmVhbHRla19zbWlfc2V0dXBfbWRpbygpIGJhaWxzIG91dA0KPiA+ID4gaWYgaXQgY2Fu
bm90IGZpbmQgdGhlICJtZGlvIiBub2RlIGRlc2NyaWJlZCBpbiBPRi4gU28gdGhlIGRzLT51c2Vy
X21paV9idXMNCj4gPiA+IGFzc2lnbm1lbnQgaXMgb25seSBldmVyIGV4ZWN1dGVkIHdoZW4gdGhl
IGJ1cyBoYXMgYW4gT0Ygbm9kZSwgYWthIHdoZW4NCj4gPiA+IGl0IGlzIG5vdCB1c2VmdWwuDQo+
ID4gDQo+ID4gSSBkb24ndCBsaWtlIHRoZSBmYWN0IHRoYXQgdGhlIGRyaXZlciBiYWlscyBvdXQg
aWYgaXQgZG9lc24ndCBmaW5kIHRoZQ0KPiA+ICJtZGlvIiBjaGlsZCBub2RlLiBUaGlzIGJhc2lj
YWxseSBmb3JjZXMgdGhlIGhhcmR3YXJlIGRlc2lnbiB0byB1c2UgdGhlDQo+ID4gTURJTyBidXMg
b2YgdGhlIHN3aXRjaC4gSGFyZHdhcmUgZGVzaWducyB3aGljaCBkb24ndCB1c2UgdGhlIE1ESU8g
YnVzIG9mDQo+ID4gdGhlIHN3aXRjaCBhcmUgcGVyZmVjdGx5IHZhbGlkLg0KPiA+IA0KPiA+IEl0
IGxvb2tzIHRvIG1lIHRoYXQsIHRvIG1ha2UgYWxsIHR5cGVzIG9mIGhhcmR3YXJlIGRlc2lnbnMg
d29yaywgd2UgbXVzdA0KPiA+IG5vdCB1c2UgZHMtPnVzZXJfbWlpX2J1cyBmb3Igc3dpdGNoIHBy
b2JlcyBvbiBPRi4gQ2FzZSAoMikgaXMgb25lIG9mIHRoZQ0KPiA+IGNhc2VzIG9mIHRoZSBldGhl
cm5ldCBjb250cm9sbGVyIGxhY2tpbmcgbGluayBkZWZpbml0aW9ucyBpbiBPRiBzbyB3ZQ0KPiA+
IHNob3VsZCBlbmZvcmNlIGxpbmsgZGVmaW5pdGlvbnMgb24gZXRoZXJuZXQgY29udHJvbGxlcnMu
IFRoaXMgd2F5LCB3ZSBtYWtlDQo+ID4gc3VyZSBhbGwgdHlwZXMgb2YgaGFyZHdhcmUgZGVzaWdu
cyB3b3JrIGFuZCBhcmUgZGVzY3JpYmVkIGluIE9GIHByb3Blcmx5Lg0KPiA+IA0KPiA+IEFyxLFu
w6cNCj4gDQo+IFRoZSBiaW5kaW5ncyBmb3IgdGhlIHJlYWx0ZWsgc3dpdGNoZXMgY2FuIGJlIGV4
dGVuZGVkIGluIGNvbXBhdGlibGUgd2F5cywNCj4gZS5nLiBieSBtYWtpbmcgdGhlICdtZGlvJyBu
b2RlIG9wdGlvbmFsLiBJZiB3ZSB3YW50IHRoYXQgdG8gbWVhbiAidGhlcmUNCj4gaXMgbm8gaW50
ZXJuYWwgUEhZIHRoYXQgbmVlZHMgdG8gYmUgdXNlZCIsIHRoZXJlIGlzIG5vIGJldHRlciB0aW1l
IHRoYW4NCj4gbm93IHRvIGRyb3AgdGhlIGRyaXZlcidzIGxpbmthZ2UgdG8gZHMtPnVzZXJfbWlp
X2J1cywgd2hpbGUgaXRzIGJpbmRpbmdzDQo+IHN0aWxsIHN0cmljdGx5IHJlcXVpcmUgYW4gJ21k
aW8nIG5vZGUuDQo+IA0KPiBJZiB3ZSBkb24ndCBkcm9wIHRoYXQgbGlua2FnZSBfYmVmb3JlXyBt
YWtpbmcgJ21kaW8nIG9wdGlvbmFsLCB0aGVyZQ0KPiBpcyBubyB3YXkgdG8gZGlzcHJvdmUgdGhl
IGV4aXN0ZW5jZSBvZiBkZXZpY2UgdHJlZXMgd2hpY2ggbGFjayBhIGxpbmsNCj4gZGVzY3JpcHRp
b24gb24gdXNlciBwb3J0cyAod2hpY2ggaXMgbm93IHBvc3NpYmxlKS4gDQoNCkkgc3Ryb25nbHkg
YWdyZWUgYW5kIEkgdGhpbmsgdGhhdCB0aGUgZGlyZWN0aW9uIHlvdSBoYXZlIHN1Z2dlc3RlZCBp
cw0KY3J5c3RhbCBjbGVhciwgVmxhZGltaXIuIE5vdGhpbmcgcHJvaGliaXRzIHVzIGZyb20gcmVs
YXhpbmcgdGhlIGJpbmRpbmdzDQpsYXRlciBvbiB0byBzdXBwb3J0IHdoYXRldmVyIGhhcmR3YXJl
IEFyxLFuw6cgaXMgZGVzY3JpYmluZy4NCg0KQnV0IGZvciBteSBvd24gdW5kZXJzdGFuZGluZyAt
IGFuZCBtYXliZSB0aGlzIGlzIG1vcmUgYSBxdWVzdGlvbiBmb3INCkFyxLFuw6cgc2luY2UgaGUg
YnJvdWdodCBpdCB1cCB1cCAtIHdoYXQgZG9lcyB0aGlzIHN1cHBvc2VkIGhhcmR3YXJlIGxvb2sN
Cmxpa2UsIHdoZXJlIHRoZSBpbnRlcm5hbCBNRElPIGJ1cyBpcyBub3QgdXNlZD8gSGVyZSBhcmUg
bXkgdHdvIChwcm9iYWJseQ0Kd3Jvbmc/KSBndWVzc2VzOg0KDQooMSkgeW91IHVzZSB0aGUgTURJ
TyBidXMgb2YgdGhlIHBhcmVudCBFdGhlcm5ldCBjb250cm9sbGVyIGFuZCBhY2Nlc3MNCiAgICB0
aGUgaW50ZXJuYWwgUEhZcyBkaXJlY3RseSwgaGVuY2UgdGhlIGludGVybmFsIE1ESU8gYnVzIGdv
ZXMgdW51c2VkOw0KDQooMikgbm9uZSBvZiB0aGUgaW50ZXJuYWwgUEhZcyBhcmUgYWN0dWFsbHkg
dXNlZCwgc28gb25seSB0aGUgc28tY2FsbGVkDQogICAgZXh0ZW5zaW9uIHBvcnRzIGFyZSBhdmFp
bGFibGUuDQoNCkkgZG9uJ3Qga25vdyBpZiAoMSkgcmVhbGx5IHF1YWxpZmllcy4gQW5kICgyKSBp
cyBhbHNvIGEgYml0IHN0cmFuZ2UsDQpiZWNhdXNlIHRoaXMgZmFtaWx5IG9mIHN3aXRjaGVzIGhh
cyB2YXJpYW50cyB3aXRoIHVwIHRvIG9ubHkgdGhyZWUNCmV4dGVuc2lvbiBwb3J0cywgbW9zdCBv
ZnRlbiB0d28sIHdoaWNoIGRvZXNuJ3QgbWFrZSBmb3IgbXVjaCBvZiBhDQpzd2l0Y2guDQoNClNv
IHdoaWxlIEkgYWdyZWUgaW4gdGhlb3J5IHdpdGggeW91ciByZW1hcmsgQXLEsW7DpywgSSdtIGp1
c3Qgd29uZGVyaW5nIGlmDQp5b3UgaGFkIHNvbWV0aGluZyBzcGVjaWZpYyBpbiBtaW5kLg0KDQpL
aW5kIHJlZ2FyZHMsDQpBbHZpbg==

