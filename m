Return-Path: <netdev+bounces-61596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171D18245BD
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B02285EF6
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB423760;
	Thu,  4 Jan 2024 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="hCA4tnUH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2120.outbound.protection.outlook.com [40.107.6.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EC24A0C
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce23KhmoSL39hXVDv7AqDzKSVz0PLBpcsqBxMuRS7hz9RM7h++lkvDVOcCJU0W6aK89ALRHHCg+8sNBxuQTHfAMBP5f5+7wF03kq3ET1sHe1ATjGX/AJ+Z0o8KV2qvlR0l0Ocuou9VXMSamWvWtTZD+CAawoHEq8G+0zDyHCXj5kDDoROAqnXgjjQT9fZx/i282zIHRqzDmXLqUmIJi2+x2xwTecc/dn8eXXc13YHL1lEB0b1Yz3HEYv+5sYIgC7mW53ZYykCRqEuPguQ632nsZ5x8Il3JOAJMTOuat0ayTygFAquVGzkIIUH54p+1Hy31fHz0JP7mVIG23U2J4u0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpzGvaStk3ybusetFV+94svBPUn0geRZfQmyge92cQc=;
 b=Y7XbIJ/4p88kzSIfod5/oAgo3DegsKSttp3V34zKmojqkL6yWOZIhTxQ+OIyuM/s4tfRHrxbhRDWVoaxttvVBtpLobQw+W7ZxGZLpmczqPfCxE1CkM3EgELXf7VXABL46S0G63JuruQd+h+dGBd0PmUFxhhF+ntAs3IXLABDB89hggZ4yiIc/2h6SK1EDTxV7lRBm2ZrwJ4vbe9G1tvMsHZXSWGPP8QpZzvWv2w1OrWz7wVx5qI3p+kvCn0lghbvLJJ2r+FRGfdZmOmTQgm6hY9YB4YfWQI+N/wfuwuTrQ+RV3IoCPXyWXk83UQnhKZHNzHlX4Et3/Yl7xxdgaKB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpzGvaStk3ybusetFV+94svBPUn0geRZfQmyge92cQc=;
 b=hCA4tnUHvRKoH59Hii6R8iMmQE+vJH1PqHhG4OWG3jQ97nQf2gI1/G6ebPYpGkswu3FqOqhCbGG2FibhqYuclME9JZydOSitAcF+lDtntcz9yVJabRFjtF+QKpoEC70sUTC0GkDvXWoPIUmnuWUTiAv9V8jTWrs6RpxR27bNlN0=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by DB9PR03MB7243.eurprd03.prod.outlook.com (2603:10a6:10:220::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 16:04:52 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 16:04:52 +0000
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
Subject: Re: [PATCH net-next 05/10] net: dsa: qca8k: skip MDIO bus creation if
 its OF node has status = "disabled"
Thread-Topic: [PATCH net-next 05/10] net: dsa: qca8k: skip MDIO bus creation
 if its OF node has status = "disabled"
Thread-Index: AQHaPxZ+Wr/T9RNNP0Kzcp2ZFGcdbLDJy7cAgAABTYCAAAROgA==
Date: Thu, 4 Jan 2024 16:04:52 +0000
Message-ID: <ci7d6dyxrcpxt4zng2bccr6ajehbo2ziowu2dqbr4gn6oxqtrg@ibveophqcpw3>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-6-vladimir.oltean@nxp.com>
 <ajlbpd63vpgkyvzflimq7qbzrdvgqizbg6qwj32qudd4ibgywm@ckdcvnsrm23u>
 <20240104154927.dq3bsbzu55qefsqo@skbuf>
In-Reply-To: <20240104154927.dq3bsbzu55qefsqo@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|DB9PR03MB7243:EE_
x-ms-office365-filtering-correlation-id: 92f2f7e9-2536-4c02-99fe-08dc0d3ee2d5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Rihhybn1Z8YIs6ZYhzFs9RvusQt2R0a8TTU/RqdkSrbFUH3lISA+8xYOaNtAClfAHLCcskl5MV5uD8TYGEzoZvXmeHEsqpKjYkg/eNWpCQp2QCxke++B5WffWRqHRJfG0MdPa64BT1W/02AOhSzEtBB2cs4M+/Y1hX9VnRCCLRXUY3gNoWnKiIoI6AdZn++kahaId66CKptBcKSa3UBVlo9tS19PQ/vRDWr7M8rzKVpsP5yY/wRGs529eX4h45N6iT6HCRGXTSBbn0LFVeSequ5F2kejBUZOECy1wtaAEL4HRhblxknRVD1BvZj2r1/WYOctXGK+eRNJeNoOl5hop10eekN2u+UHqGncLaO3ITytGAxYA+gTGMZDnfAWQYYJ+FzUL7gSAfZ3bO5liF99NbYt/ehQOoQRq+AETRyFnpikPtnwtXuAJa7UszSbM9Iyr+FjUmqcOJ0BAKNFgtF85rZj7J6W3x9WupCEVBjH5i++2IecLT0C18OyRA1OX0W5ejkgOmGbKmhKJYpX94+GS3BTAz2OepG30yVCT1VIkT+3WG9z3mXt6/E1c4ELpZYURgtLkFr/B8r8/c6yCDIOkYWnn4uYJwM8U09P4o8qlm403T18ej7LBIQRb6uA6TfU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(136003)(39850400004)(396003)(451199024)(1800799012)(64100799003)(186009)(66476007)(41300700001)(26005)(122000001)(66574015)(83380400001)(38100700002)(33716001)(5660300002)(54906003)(8676002)(7416002)(8936002)(316002)(478600001)(2906002)(71200400001)(4326008)(91956017)(38070700009)(64756008)(6916009)(6486002)(76116006)(6506007)(6512007)(66556008)(9686003)(66946007)(86362001)(66446008)(85182001)(85202003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjR2Mmw2RnRJMUFzQmsvTW9hdnRWbGZaMnFhNzd4djY4dHJhZEhNaFdWTFM2?=
 =?utf-8?B?QjVoSEY4VlNTODh3c3FMMWUzLzNEVnozQXZKVWxKQTZxc3JWUkFHVFZmbjZi?=
 =?utf-8?B?YlVRVGgrZ205bWs0cGJkQ3BvMWpLZGJyVVVoRytnMHdSVmkwbExsVmNYcjJK?=
 =?utf-8?B?aXVXS3A1MFM3RHBtUUlJSjIxZ01DVVU2WjgxREpZbkViUllYQWxHVW1zZE1G?=
 =?utf-8?B?VUxrZjVQODlDcFZaZmcwRGNkaXBGR1Y3L3hxalA3aHFkeFJ3MWVPZXpKeTFk?=
 =?utf-8?B?UWhQaWwxNXZmb0FOcWltTUpTY0F2TnFYbCtNQVRET0poaGJHa2FLQjBDZFdl?=
 =?utf-8?B?UDIyNlp1SWd5ekdKVWsrdFZmZ3JDb3cyWXZNM2dFRE1TM1FLM0JlM1VCOWtx?=
 =?utf-8?B?emZHZ01nSnlCelZEV240TnJWY0lUTUtoZ2tyY04yQ1dpTG0zL1N2ZmdMR21J?=
 =?utf-8?B?TFRvTGRESlJFZ2o5MTByNHY4Zlc1Y21KRktXbnp4N0lZcEN1a3NPcytPcTZo?=
 =?utf-8?B?MGEwcFpEWVNiZ2lwQUVGV00xYURDWTNONmFHNE1jSjZGMXVvYmF3VTROM3JG?=
 =?utf-8?B?TysycGk5NVpZRkFYN1gyQkZEclVuZWQreUh3bXZUcEM1Qm1lczk1SktHejkz?=
 =?utf-8?B?WTBQa3ZBcWMycmoxbDcxUndONDdld1ZVT05HaDd6RHZGYm5ENlQyWWU1RWY4?=
 =?utf-8?B?RkRtdlpJdDU0Mm5sUHYvVjlmQTRqekJDczZia3NFejhtOE1iOWZ3QUNPcGdy?=
 =?utf-8?B?Vk1OWW5MOGkvalY0bDRmWTNLWUhlUlZNayt3NFM0VnpYekZuazZOOTJIVVYw?=
 =?utf-8?B?RjFjMTJFaEdpQk5VTEZrQlo0bjRlQW8rQkk5T0tOSWVZL25DZnBzR2FQNVdD?=
 =?utf-8?B?WkdYUnc4UjVvZlpDYU9scWVCV0xIaE5wRjhwbUlZZUVHSU80TXVHdjhLNmVW?=
 =?utf-8?B?WkJBbHJNVUNkYm4vMCt3WkxOUStCNllWMXhYVUpQdjQvQXg4V3RFYnpTMHYx?=
 =?utf-8?B?Qjc5UzQwY3JIN2dTRmdqTVpVNXRqci9GczQrR1RHQitoMGp4NXZtakVmeWVt?=
 =?utf-8?B?SGdTWkNFcWR2cDZhMmJFcDZWSzlDV01RV001ZUJIT3V0a21QTnM1eUEzc0NW?=
 =?utf-8?B?clBIc1Vnc1VpSGl4emt1eWtIWmNhREZXRC9xZS9VQU1yOFcxTForbzNCdmsr?=
 =?utf-8?B?UUE4TzZScVRLSFI3WWpFY04wYkcwMUp6VUFlTTJUbi9zM1pVVWgrVE5PK2du?=
 =?utf-8?B?a29YakZ6Q05lUDRWRGdXUWUyRGFDcWlMSDVLN0VXZUFCSTBwb3VYSTJ3V1VR?=
 =?utf-8?B?YjBWYzdzQjNrS0VUTXlkeFcvL0tNa0RxZlZYZmhidUc0YmNTMzB4MFV5RkJq?=
 =?utf-8?B?bUlmS0VnZG04KzhTUWF5Qk9ZQy8wNUhuYWU5bGFPOUZjcWxMcCtnb2RhOE5s?=
 =?utf-8?B?QnphKzZVRkw3cWZQNVpSUjMraW9jbzBYS1FsSzZNQmFWbFJzK3FwQW95N21t?=
 =?utf-8?B?M2NHK01KczVoS2tOc0QxK2dYM29GSXhyUGloQmEranFVNXEzK3lqcVJ4RURV?=
 =?utf-8?B?SVBhNHdWS09KSzFHcVg3eVZERUdQREtQamdMOFR5VkRveXJnS2FoWTdBK0dC?=
 =?utf-8?B?ZzYzME5pdGZRQVVJejhwRWdEajFxR2VONURsVTZ1RXdUOUR1SVN0eERMRDh3?=
 =?utf-8?B?NnZQSCtUVk1MWkNGazVaM09RRGtzVFhPUnVuZ25WODlHK2xpNFhjM2VuaE84?=
 =?utf-8?B?dTRIOW5SNk1NVzd6eW5xc0dISCtZQ2JLK2J2SXBwZWczbHpTUG0vcm1hY00v?=
 =?utf-8?B?bVIwWGJMMDlUTllhWXU1MUJtNGpDMzF1TmJlNGxRZVYvL3U0QWNtaGNDVjQ1?=
 =?utf-8?B?TFpHQU1ZVERpQndKMWFFa25IeE52c1ZSbFY0MGxpaVJmY3VGNEh4bXFPSGFM?=
 =?utf-8?B?ekZKRmVKTnk1WmlhMG9vcWhkRE1PTytJUm4vMWdLL1hZeGI1NGk1SmQxQy9p?=
 =?utf-8?B?bG0wRVg1SmdIVHNQMXJ6SlY4d3JZM0tKMFpYbHBmNnY3M1A0RTFKNE9mYkRH?=
 =?utf-8?B?UmFxdm0xN0dpbnR2UGd2VGFPTXRtQ3hzRTZNcmNKcUVDczlNNzFnMGJPWEFC?=
 =?utf-8?B?c3RkMGhWcFE3M1RhYUN6dnJ3cUFHczUyd251ZEJGRzV6K0x6d2thU0ZCdU1p?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F00C80F0892E9144A172FDD24485B1B2@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f2f7e9-2536-4c02-99fe-08dc0d3ee2d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 16:04:52.4274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: honmw0ANh/MmUT2I9BVaWexhfTWAxg/LLhDJmxqzCIxott2Qs6PMSwjAiaBXjTmSS2oNZcxpxTW8OrFA3+rzwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7243

T24gVGh1LCBKYW4gMDQsIDIwMjQgYXQgMDU6NDk6MjdQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBPbiBUaHUsIEphbiAwNCwgMjAyNCBhdCAwMzo0NDo0OFBNICswMDAwLCBBbHZp
biDFoGlwcmFnYSB3cm90ZToNCj4gPiBPbiBUaHUsIEphbiAwNCwgMjAyNCBhdCAwNDowMDozMlBN
ICswMjAwLCBWbGFkaW1pciBPbHRlYW4gd3JvdGU6DQo+ID4gPiBDdXJyZW50bHkgdGhlIGRyaXZl
ciBjYWxscyB0aGUgbm9uLU9GIGRldm1fbWRpb2J1c19yZWdpc3RlcigpIHJhdGhlcg0KPiA+ID4g
dGhhbiBkZXZtX29mX21kaW9idXNfcmVnaXN0ZXIoKSBmb3IgdGhpcyBjYXNlLCBidXQgaXQgc2Vl
bXMgdG8gcmF0aGVyDQo+ID4gPiBiZSBhIGNvbmZ1c2luZyBjb2luY2lkZW5jZSwgYW5kIG5vdCBh
IHJlYWwgdXNlIGNhc2UgdGhhdCBuZWVkcyB0byBiZQ0KPiA+ID4gc3VwcG9ydGVkLg0KPiA+IA0K
PiA+IEkgYW0gbm90IHJlYWxseSBzdXJlIGFib3V0IHRoZSB1c2UgY2FzZSwgYnV0IEkgYWx3YXlz
IHRob3VnaHQgdGhhdA0KPiA+IHN0YXR1cyA9ICJkaXNhYmxlZCIgc29ydCBvZiBmdW5jdGlvbnMg
dGhlIHNhbWUgYXMgaWYgdGhlIG5vZGUgd2VyZQ0KPiA+IHNpbXBseSBuZXZlciBzcGVjaWZpZWQu
IEJ1dCB3aXRoIHlvdXIgY2hhbmdlLCB0aGVyZSBpcyBhIGJlaGF2aW91cmFsDQo+ID4gZGlmZmVy
ZW5jZSBiZXR3ZWVuIHRoZXNlIHR3byBjYXNlczoNCj4gPiANCj4gPiAgIChhKSBtZGlvIHVuc3Bl
Y2lmaWVkID0+IHJlZ2lzdGVyICJxY2E4ay1sZWdhY3kgdXNlciBtaWkiDQo+ID4gICAoYikgbWRp
byBzcGVjaWZpZWQsIGJ1dCBzdGF0dXMgPSAiZGlzYWJsZWQiID0+IGRvbid0IHJlZ2lzdGVyIGFu
eXRoaW5nDQo+ID4gDQo+ID4gV2FzIHRoaXMgeW91ciBpbnRlbnRpb24/DQo+IA0KPiBZZWFoLCBp
dCB3YXMgbXkgaW50ZW50aW9uLiBJJ20gbm90IHN1cmUgaWYgSSBhZ3JlZSB3aXRoIHlvdXIgZXF1
aXZhbGVuY2UuDQo+IEZvciBleGFtcGxlLCBQQ0kgZGV2aWNlcyBwcm9iZSB0aHJvdWdoIGVudW1l
cmF0aW9uLiBUaGVpciBPRiBub2RlIGlzDQo+IG9wdGlvbmFsLCBha2Egd2hlbiBhYnNlbnQsIHRo
ZXkgc3RpbGwgcHJvYmUuIEJ1dCB3aGVuIGFuIGFzc29jaWF0ZWQgT0YNCj4gbm9kZSBleGlzdHMg
YW5kIGhhcyBzdGF0dXMgPSAiZGlzYWJsZWQiLCB0aGV5IGRvbid0IHByb2JlLg0KDQpZZXMsIGdv
b2QgZXhhbXBsZSB3aXRoIFBDSWUuIFRoZSBjaGFuZ2UgbWFrZXMgc2Vuc2UgdGhlbi4gVGhhbmtz
IGZvciBjbGFyaWZ5aW5nLg==

