Return-Path: <netdev+bounces-61593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B0D824598
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48066287843
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18BC249F5;
	Thu,  4 Jan 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="KvVaNo7G"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2092.outbound.protection.outlook.com [40.107.21.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335DE24217
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibm1LTF/TwgSsp6K7goSElMOakboBb1wKUzkWJakGfQZDa/xpm1YdyZRqwwNju3qvV901j4Hv7q3j58cShHIRpVM5BP9edIE/7e+yh4JBCqwp23Q3wnU2Af69ULCygiVBTEHkr5s0p2u/84gLulkNl9LoL4H3cCQ9lam7P4zIu4qyxpnZOip5bkRFNNH+kj3MNKd8QmHC4ONgPoHC+ObpXRGFeY2XmeoWs22eYUOmJN+UtNuVHe4oT8mFK3JenwQoEAdkfX+DHzk8fHzCmXO3XP+IVRraDB4vrWOTPHvfHy16xmgOxf0guQFEh5UNoCS2rB5DRKGQc9LMz8IuM1lPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Elb3WyqKBpT+9wzQMqr0AnIbgdh5OAQYnoqLFnZh0pU=;
 b=bjniRcgOYGdJdnaj9Bq7oimg6WSa89FYCGueND1fQWdGFGelshc3zv3hDNenua4pL/VBL3su124CvCUzfdIAwMgAn935izK4hOwM3gqLsf5n+vyK1sPV1CCyAYE3vsVxGKno4/wvDXU8pqd3LJkE4jhe2NtizCBWMTpopaL+iDGTTXWpi5lOXSSm6OM5z7zdjGGT2PaP/McCFJ6Nuhqn5NAQjJUBAi71JYvFglsQaxjl/gfJ9eF94fFqbFnheES1u20X1+7xrClLpwDIyATcfLbtKkLV1yzUKVWQ/uCI88CASAY36AhLcF3u7YizGl2z/kCQETFzBVlcRee1ShP0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Elb3WyqKBpT+9wzQMqr0AnIbgdh5OAQYnoqLFnZh0pU=;
 b=KvVaNo7GwTXfBJDEPjYGskVZq4CMI2zC6BWb2AVq94Ireddyzejkp6Oa+0PZ7RCIysERogjW9CJLHEuRwx6Y/o4EsZBy1BbALxBDfPKZ0ovqo4niKiK16GHdk9RklMeU0nkqJy6hY7tcDsDm//dp/HYdWutJjX3/KvNqYiG9dDo=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by AS8PR03MB6757.eurprd03.prod.outlook.com (2603:10a6:20b:292::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 15:59:09 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 15:59:09 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Luiz Angelo Daros
 de Luca <luizluca@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>, Hauke Mehrtens
	<hauke@hauke-m.de>, Christian Marangi <ansuelsmth@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 09/10] net: dsa: bcm_sf2: stop assigning an OF
 node to the ds->user_mii_bus
Thread-Topic: [PATCH net-next 09/10] net: dsa: bcm_sf2: stop assigning an OF
 node to the ds->user_mii_bus
Thread-Index: AQHaPxaAk50xDxS06US7k1JkTMQhn7DJz7qA
Date: Thu, 4 Jan 2024 15:59:09 +0000
Message-ID: <3l5dqipd73vb3p2wrsycg2ft7cyqa6f7kumovakdpxqktga5ve@eegtzwv65d5f>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-10-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-10-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|AS8PR03MB6757:EE_
x-ms-office365-filtering-correlation-id: 361d03a2-ccaa-4b77-1fbf-08dc0d3e16a8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 q9zrC7qIwxzEV6ktMGGEr01EwufaCocbiEz/fH8pOd/6B8fPsTMlIu3bO6+u8JF9+GAHVrY3sx0O+DwCJNB1IXqaWYuHckCqPl6BBAGDoPcE1IRoSEou/64yJg9EbbbjBEEgGWJef0vB4pGm4TdZSBuOlDfjW9TotIA1D4MYr0I96y8D2bWUVM9ofZe8afP1hoC3pP4DnIfBhcCbkslDQ/dIDnL5KPkGtvKy6lpn00qX5E9LCuULFLi7CdwlDq5WSqlCRdti1mQJnngtCPGZghA6BVUsoVrGr2UJ7jE6KhF3Rv+H/ztwY1nJ18h7tjQ1XVh6kzmf+P95qE8IhvANKcwLjF/ADU8LoUx3HD+stjJrEbcdRkZmH0wG+yKEHnee4WyS5GzKUWNA+bvqQIWemjmUO1N0G0D/zNlxFiePDO9ywptovZ4SkFQpSpADrYrlJryAbIPCaXaW/7+BWjJJ0vjvS2BtCoyp7URMlYh622I+pViI085Q518pk3MR/Ch0blb/yO6EntDvTaK3G7fUPZ2aLOJS2H/9iVvYQUTgU/lj6rKXb3pSuEft7iYi9efqUZq4U1xgfEzH13fQ4gItM8G8HHBSSkG4GUdvtsYWt26haJj5SS/fWhlEvRRKpA2W
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(346002)(376002)(39850400004)(186009)(64100799003)(451199024)(1800799012)(5660300002)(2906002)(7416002)(8936002)(4326008)(316002)(8676002)(9686003)(66574015)(91956017)(66476007)(64756008)(66556008)(76116006)(6916009)(66946007)(54906003)(6512007)(26005)(83380400001)(41300700001)(38100700002)(66446008)(33716001)(122000001)(86362001)(85182001)(85202003)(6506007)(478600001)(71200400001)(6486002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHFaTzFTZnZRdEhRYklJYksyRUN4bWkyOVFpeUp1Um16bE5uMm9KSXlPNk5D?=
 =?utf-8?B?ZVlUSHdEZmtIcEFYNHNNRTZJWEhqK2NCK3FwQVp1ZSs0Z0NVRU00bjdoUVJp?=
 =?utf-8?B?bzNacWRRNlZoM3FMSkx0U0V4b1BpUFZ4dm9qMEdwbWhiY29qbEFCeGtCYzlq?=
 =?utf-8?B?aDJabXl2Zlc3R28zUTB5Rld6TFBkYUNYRmxkMVNHc2xhcXJza3p2TitXMlo5?=
 =?utf-8?B?dnhRSVI0QTcwOURLZzZvclF5cklrVTdmN3pQbjJvTEN6VlBnMDZUWTNtUWov?=
 =?utf-8?B?UEV2VGxMMVFRcnVSWnB0UVZuQkVBUy81NUx6aDZDbXcyWTRJRFFPUnF2Zjc2?=
 =?utf-8?B?UmREVVNPdzBwZEY2eUtmSU8xY3ZlU0VUYmVZYTQzVkJUYUIydUllRlNhZ3JW?=
 =?utf-8?B?cDFCdWZDVG02MWNaNGNpdGNsaE1TN1EyNGRreXprZ1hJZ3JramhGM09UQzgx?=
 =?utf-8?B?RUlZbnRwSERqOXpoaUhvVThIVEtlVHVmSjRKS2lEeEhjQjRJaG4vSG1US3Z1?=
 =?utf-8?B?VWpRbm13cnBobURjbmhnZ3dTU2lTZStPeEFKWkh1eUJSOXhuK3pNeDVDS3NX?=
 =?utf-8?B?NmoxQlF6dTdhdVlQL2ZLZ3JtYVlET1BuN3V6KzRuVytQZnhBL1ZTc1FDZHZ3?=
 =?utf-8?B?aE5MdWxXVnFjQk94cFNiSU1hSE1FZWtqMzJkcVZGL3pkUFdOajNOWEJPNWxK?=
 =?utf-8?B?TjBWRmhDdXVaRms1a3RjMitXZWJFZ0h3R1UxbG04enJtV2RvUFJGeE1MYXZC?=
 =?utf-8?B?dzRCZHlXdUpIQUQzL2xKNjNnV0VsRXF1QWc2YkVWdFVPdmVRMHdYU2l5T1o5?=
 =?utf-8?B?SmdTNjNBTWNDREdvSGdNT2dIRmRLbkNLeVNEZTB1NFVqWTlERitqbVBWWEZ1?=
 =?utf-8?B?R0dIL1NoN0JtZGk0eURUMUtZMERTZ0R5b3ZubXVsbGswWW9LVnlySTJTQ1hG?=
 =?utf-8?B?aHNVVlRXbDJYQVVWRHZRT2Nrc2xpd1IzUkU4K1VlY0lscC9PVzZjcDZZUy9n?=
 =?utf-8?B?WHVHY0pGa0dDVkdUTkR3Q04rVm5VZUJPQzhOMjBaYlVjL3BDZzdhZGhZVXhj?=
 =?utf-8?B?eG5xQ3hyWVFidzVOWVR0d211V0NSbUpKK3VFWDlpQU0yNEY3cE1RVlBtYWYz?=
 =?utf-8?B?clFVYTNOMjNFbXJEV0gxK2VNR1RvM081eTR4N2hmcE5xZGtURlZzMmV5VU1v?=
 =?utf-8?B?YXF4emc2VlpvZU5XOXhEbXhqWE8zU1RIOEZkY2VwbE13Ny90dW1qME9YelNi?=
 =?utf-8?B?aHVIUkRZVVpMMTJtNUF1RHBWNzg5YVpuS1Z4OTl6V0xYa1M4c2FLWUlSUHkv?=
 =?utf-8?B?NmYvS1k2TUhwWGY4RmYxOHZmaEgzZnArKy9oZnNFeThnckN3eUdRcnVkZDBB?=
 =?utf-8?B?Tmljc0tNWGhqMldVSEplV1lKLytvejdCSFo3MFJ6Z1F6T25SNU9STUdaTzRv?=
 =?utf-8?B?dEZiZGg4YUNKdUVzbkUzcWYyeWpTYTRrQldJNlRRZmVPR0hWV3kvYnk1YWFH?=
 =?utf-8?B?Vy9kTFdmVkYwazR6WmVubXZUKzF0bGx1aDdTS3V4aEZsN2cvUExNYVJYcFd6?=
 =?utf-8?B?d0FKZEwxYVFPYlEyMUUyZmV6WG9UMEIzQzB5UHVOQW1rSWw1bEJPTWNqb3lG?=
 =?utf-8?B?Qmp0eG5NbzRoaVhiWDVwc1JDem90OUR5WkEvdi9VQmRoOFFxTS9GUzM2M0FZ?=
 =?utf-8?B?ZHZ3YUtnQ09UVjNST2pmdHErZlRBTldtM0FUTjZ6V2RsNGhOVWpDMEkrMHVL?=
 =?utf-8?B?T0ZOKzdRcEJzTGY4Qi9pNWdNbXpFbDByR2FIcE5DNFlJQ1V0T0tkcVJDTWQ3?=
 =?utf-8?B?NDhIcldvN0gweG10SVA4NnR3eUNjWWRpOFlqOHllSlViN3FIZGRocTVUUTBQ?=
 =?utf-8?B?TmRkQThpcEl3OHFmZ1QzK2ZYN2szQ1o1WkFVZk9EU0d5bVRQVW1tYVNqb0ZO?=
 =?utf-8?B?b1ZXWm1lSkNwSUZzeC9mZXc1THZ1YmJYbUFmNSt6dUh5SjArTXhsV01qcW51?=
 =?utf-8?B?N1V0UHAyTlh5RU5mOC9nM3kwRjVKeE54REozblQ5ZGRaUE01Sk4rVDN2TjN4?=
 =?utf-8?B?RWo3eEkxUkkyS2wyT2FXQ2h0QXJ6TG92b0lQdzh5OWcrbkh4Z2Y0RSt2ZDFN?=
 =?utf-8?B?eFBNZUo0ZElyb20vQUF6SWJpbGxWUXNFT0xyanVYNzhzNlNkbk4zZ2JXRWk4?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F00E52AE53F75E4DB249BF61B90CA1ED@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361d03a2-ccaa-4b77-1fbf-08dc0d3e16a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 15:59:09.8955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7+u697xsJtcMM2bRr+89Z6QgJxYih9BBcqREhp+o7mCElS6+ePAdSnRJox14NGs1I9C94FJ2QtUUBXxMew3qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6757

T24gVGh1LCBKYW4gMDQsIDIwMjQgYXQgMDQ6MDA6MzZQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBUaGUgYmNtX3NmMiBkcml2ZXIgZG9lcyBzb21ldGhpbmcgc3RyYW5nZS4gSW5z
dGVhZCBvZiBjYWxsaW5nDQo+IG9mX21kaW9idXNfcmVnaXN0ZXIoKSB3aXRoIGFuIE9GIG5vZGUg
YXJndW1lbnQsIGl0IG1hbnVhbGx5IGFzc2lnbnMgdGhlDQo+IGJ1cy0+ZGV2LT5vZl9ub2RlIGFu
ZCB0aGVuIGNhbGxzIHRoZSBub24tT0YgbWRpb2J1c19yZWdpc3RlcigpLiBUaGlzDQo+IGNpcmN1
bXZlbnRzIHNvbWUgY29kZSBmcm9tIF9fb2ZfbWRpb2J1c19yZWdpc3RlcigpIGZyb20gcnVubmlu
Zywgd2hpY2gNCj4gc2V0cyB0aGUgYXV0by1zY2FuIG1hc2ssIHBhcnNlcyBzb21lIGRldmljZSB0
cmVlIHByb3BlcnRpZXMsIGV0Yy4NCj4gDQo+IEknbSBnb2luZyB0byBnbyBvdXQgb24gYSBsaW1i
IGFuZCBzYXkgdGhhdCB0aGUgT0Ygbm9kZSBpc24ndCwgaW4gZmFjdCwNCj4gbmVlZGVkIGF0IGFs
bCwgYW5kIGNhbiBiZSByZW1vdmVkLiBUaGUgTURJTyBkaXZlcnNpb24gYXMgaW5pdGlhbGx5DQo+
IGltcGxlbWVudGVkIGluIGNvbW1pdCA0NjFjZDFiMDNlMzIgKCJuZXQ6IGRzYTogYmNtX3NmMjog
UmVnaXN0ZXIgb3VyDQo+IHNsYXZlIE1ESU8gYnVzIikgbG9va2VkIHF1aXRlIGRpZmZlcmVudCB0
aGFuIGl0IGlzIG5vdywgYWZ0ZXIgY29tbWl0DQo+IDc3MTA4OWMyYTQ4NSAoIm5ldDogZHNhOiBi
Y21fc2YyOiBFbnN1cmUgdGhhdCBNRElPIGRpdmVyc2lvbiBpcyB1c2VkIikuDQo+IEluaXRpYWxs
eSwgaXQgbWFkZSBzZW5zZSwgYXMgYmNtX3NmMiB3YXMgcmVnaXN0ZXJpbmcgYW5vdGhlciBzZXQg
b2YNCj4gZHJpdmVyIG9wcyBmb3IgdGhlICJicmNtLHVuaW1hYy1tZGlvIiBPRiBub2RlLiBCdXQg
bm93LCBpdCBkZWxldGVzIGFsbA0KPiBwaGFuZGxlcywgd2hpY2ggbWFrZXMgInBoeS1oYW5kbGUi
cyB1bmFibGUgdG8gZmluZCBQSFlzLCB3aGljaCBtZWFucw0KPiB0aGF0IGl0IGFsd2F5cyBnb2Vz
IHRocm91Z2ggdGhlIE9GLXVuYXdhcmUgZHNhX3VzZXJfcGh5X2Nvbm5lY3QoKS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+DQoN
ClJldmlld2VkLWJ5OiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+DQoNCj4g
LS0tDQo+ICBkcml2ZXJzL25ldC9kc2EvYmNtX3NmMi5jIHwgMSAtDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBkZWxldGlvbigtKQ==

