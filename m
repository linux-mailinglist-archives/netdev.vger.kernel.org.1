Return-Path: <netdev+bounces-55775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D89DD80C47E
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB6A1F210FE
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD9C21346;
	Mon, 11 Dec 2023 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="eAAyOhfm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2098.outbound.protection.outlook.com [40.107.241.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057C8FC
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 01:25:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSMJSANTNngNXSTaciiwZ2TQXWb+Pg6iWOWl4A0VzXNCTm7FNW7w4WTHkJACdp1gkDAAvLIXYavRpqwdGKXpIjsIsSMApQqzOtUj+ik2pT21KPxzTtcSzgbm1lsVjM8oo9ka1VHIaVr1vzsy9L0MNx60oZYwXaXzfsmrlEjjWm8qNzGDqPGx9F6JAZ7BnJDBtHSZCrq580SNw+rkafP3QNImQg32N0d5bQLiqzsvwvigVKvTSAlRMIFvA7txdrTNaJjKzTYrKU8hUPGCegO/wcNxGp9geCvjlqeyrwqbL1lp82iKPGfkrDQYZz3UAZ1pzA+P9wQQRnkmYvViOHTHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceKzzXhZKuPG9cxmqILh30mXuRpcB2G06jRyat+aQt4=;
 b=C9HRqguPUteQjhtyBkK3gzt+H4Y0LMtvRSXlcHW4p/DLmFmwO5OvohnpDXAUUNuLai74dTrWwOLL0huGl7XGR1h4kMq6GR3QyobMnETDZ0QZqPlZcS/U0MnF+iYQRWk9RpCRfw2mJsJJ5XaT7n4aF/lvJCu7ueJuFX45LSIiYv6wbCvJKp6l7ewywybheU0t8NyMmM04L8cQIAZt+0xdr+Y/ywt5OAXJokeBWfkaaNXQ/uL8TNA/+eCDPP8W3IPja1kSttKvcj1UM38u28ywkxPO+KsxUnFOcCgCj3Y6PFLDFAjOFqgjfCmUOCX77c4ghHtkxvPTbx3lVO9J5gXy5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceKzzXhZKuPG9cxmqILh30mXuRpcB2G06jRyat+aQt4=;
 b=eAAyOhfmtIW37hJAG6sZFEXxTjNgRjVBXFSWb0GaLn7bYVyG+xynv5mQ2TjiwGyAXoMsOSgLpF4mn4m8f1lLlWlJPdXjmYjda0pspDp91Z96txOeAmorBVV6VuSceT5/42b2cpyw7ywx+bW9vAbOuJYDE9O1pDsNfWOFi9mhr20=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by PAWPR03MB9714.eurprd03.prod.outlook.com (2603:10a6:102:2ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 09:25:37 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 09:25:37 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 5/7] net: dsa: realtek: merge interface modules
 into common
Thread-Topic: [PATCH net-next 5/7] net: dsa: realtek: merge interface modules
 into common
Thread-Index: AQHaKZJJVjrF4RIqR06ULJRkQds+DbCfN5sAgARW7gCAAEZRAA==
Date: Mon, 11 Dec 2023 09:25:37 +0000
Message-ID: <nouxv5jcrwuy3dyxgzjjs2fsnyhongh6rs5asrvnl2xkmf4vbb@tocsp6uf2wl5>
References: <20231208045054.27966-1-luizluca@gmail.com>
 <20231208045054.27966-6-luizluca@gmail.com>
 <foqrrb6oox3z4ptmm3n4bon457jyr25blk2f57itipdf4rppt3@5vpukw2pnucj>
 <CAJq09z5nyuzAPcsGcn+fOFmO4nAdvmX9rpFPPykHY7gZux8OCg@mail.gmail.com>
In-Reply-To:
 <CAJq09z5nyuzAPcsGcn+fOFmO4nAdvmX9rpFPPykHY7gZux8OCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|PAWPR03MB9714:EE_
x-ms-office365-filtering-correlation-id: 9244a23e-f623-4d5b-91ef-08dbfa2b2282
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 h9KoYZUT0tP0+MY/GuUEouDMX1Y/c/fHtlRtCOkUMkzcNXXnJkWqEPtRBqHePph9oguwNu9G5L/6VB8Bl4D9lAWC8bbXwJc3B+lNyYfK9NZ1LmNr/S0XS6WLU4RRrlzynVAxcdnx9UJMm9ONslyUDcvS/zAVZd41B+yANejBNyX2pAvabBeJBfv/vug3qM67zYRpVIlrN2E1PirhTcGBy4MluB6DtAcvdnFfx8ds4MjTFJ4Tj+/I3gtnbZ7LS9+uYBUOZyMGhQmZrk1T/7VKhZNizb6uSZn/fhFNxklQj9qolpVm4cvr2C591S5ssOPUwpH1HPa4GoqaBjiW2xq7sXUlxf7noz24WvBFJfaAR0Z5Drw8EhsN7aCv0xROfKzGrR6mPIBRqDz+Ig/x8c2OhMlybJKva8DBHYukMC3ovYkFWm3yUBP7XlGEeKfthU+RgLKA0XOtN1orU7d+Ye7mbg4SZsDQCAKY7wETFEDiPdegBeYJxbbH9K6v4pZ2vPJNgt5OvbbHDJMxKiTHE1rZbzhttmdNfrja8JaNSif+v+N330zBxQwFjl+DWJvvZz34r9+MY4gI/tyA5uTD4Luyf/HDLv+Jv8dqOquUJRJXeNqCo3TZxTHekbEyxTKlBppP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(366004)(136003)(396003)(39850400004)(186009)(1800799012)(451199024)(64100799003)(66899024)(6486002)(478600001)(26005)(71200400001)(6506007)(6512007)(9686003)(38070700009)(38100700002)(122000001)(86362001)(85182001)(85202003)(41300700001)(33716001)(5660300002)(91956017)(76116006)(66946007)(6916009)(66476007)(64756008)(66446008)(54906003)(2906002)(7416002)(83380400001)(4326008)(316002)(8676002)(8936002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1dtTnZpK3VjQmRGK0FORndwQ0s2cHJWUjRGeVduUUUwdU5qb29BRDA0Ny9U?=
 =?utf-8?B?NDdIS21hSjBCcnU2YWpWUjFOWVlzWlRnd2RqWEtySGxZRzNwWi9YMG1yL1FI?=
 =?utf-8?B?VzQvNGtwMnhUT29OSnY2WVM5QXZYMnIwdDN4ZExWS0xMTmpBczg5TGhaMEow?=
 =?utf-8?B?aGppUTk1eVQwMk81UUovOTlONFNFL0dMemVVR0ZTZEhDSTVFK2g5OHgyNlFD?=
 =?utf-8?B?YW5yL25OT1NxSTIwTXI5ZEdTbW8wZFl0TmxwNi81eFI5RDMydnVMVGRxK2VC?=
 =?utf-8?B?Yi85dEVTMEpSbW9nWXhsV3pLZzQ0MlZEL2EyMjA3S0NVa3ZnREJNSDQ2ZFhR?=
 =?utf-8?B?amdpbUp4eGhicnZ2eHMvZUVaYUE0RkxaZ1NVSHUzRDFOS0k2Nk0rWVhTOUx3?=
 =?utf-8?B?ZmpCS3dzODQxTVRRRTBFUVhIOHpIRGU4NFNDSkpKaGlKbU5LUk9IVkdtdWow?=
 =?utf-8?B?WTh2VXZRaXFLcWMvT3RIVVNDcUxzM3RkY2dyd05UWWd1bGt4cTlwa3dwTkdK?=
 =?utf-8?B?ZWNkNjRtVmFDSmVpb0pPWVFCUFJxVzQvdXp2WlkxakNZQXNGd2dEVlZaTE12?=
 =?utf-8?B?RXo1YUwzbHllMU05YXpwODNyMjdjaS9wK0NDczBwTDUwRWtSRHpyVWlYazFK?=
 =?utf-8?B?V0xzZENJSU5SZHY4VWQrOVQyclN2Z1pNcXhPSG4wdXkxOWg2MGxtQjFNSndJ?=
 =?utf-8?B?eEFJWXBsUFFWRjhlbENwSEtjSTVxSlpwQkZmM2dWU1NVMXR6dFhSLzhWaGdm?=
 =?utf-8?B?NXBTZStGT2RuVFR6UHU4STdKdUx2QnJrWXNLS2F6L3pvcnk4citwVXRtRzhT?=
 =?utf-8?B?eko0U3JCUTlvZVJSOXF6UzV4N25yN2FvTmFPTytwRWhQMmZIVXhsYk9SV3Yz?=
 =?utf-8?B?dU52YVJNTzdFR3NCU296cjU0TW02ZEhnWHVlTzhnaDhadkE5UVlnSm15U1hB?=
 =?utf-8?B?YUR5bkdzVlc5UEY5YnNhUWRMVUxXUTMwaFNndmsvL2pyVmVwcWVOR2g4UG54?=
 =?utf-8?B?bEhqWXJ0RkRiTWF5ZHhYazYrSk9nOFpTek5ubjhkMC8rM1FHNW1rVlAzQy9w?=
 =?utf-8?B?bUYyUDNSaTV3NWxyeTNHUVB1MW9RcGxDbDFmeXgxUjZuUTNtUDZOR3dVSjYv?=
 =?utf-8?B?VTBwcS85NUV3RzBHYXlLOVowang3ZXExMU9YYVBGUE9sc0xJS21jK0kvREZP?=
 =?utf-8?B?M3k5QXJCaGlIMkZGU0hNNkwwakUyV1dPVVNNL05ML29XUHd4eldicUFiZ25Q?=
 =?utf-8?B?bURPWUQ2cHladTNrRHp3R00zOFdWQ1JMbDVncnN4UlVJcndVNVlSb3J3Z1lS?=
 =?utf-8?B?S2IvVTFVYWM1b3pFVUNXUVdIQUw4Zi9lQStHdHRrY1pIMnZYaHJPakdKaFRQ?=
 =?utf-8?B?bC9oTWFVMXhBVS9NOWYwZHVYa3hkOXQzbUZmajhldy9CMUxsVis3VjBIRlB0?=
 =?utf-8?B?VlJwZVdmWEcyZVNrKy9MM01BM2xFOWx6VUlDRldJQ0pMNU9aMGplVTBobEI3?=
 =?utf-8?B?WklIUzZJbytKbjRIUk4wQ1lJL1FKU0lsZnpMeFBnUElTajZkYWw2Y0MyN2g0?=
 =?utf-8?B?SkVlRDhhSzJzcWZQeWI4VDZlNHJodU5tUys0c2dMSG5NcmQ0Z3ZnZjRqclc3?=
 =?utf-8?B?ME9BQmZrWk1Uem4zL2xZUnViMEwxRzdtL2hOQkV0NkZEci9CVE1YV1ZVVnlP?=
 =?utf-8?B?a3Fvbzd3NVl4U2NkS3VZOUt1TURDRHU4Nlc3VTlyYTFGUG4yeG1ndkw3d3lo?=
 =?utf-8?B?MUc0WVpYRmdjS1NPNytyUlh6cjhpV1dpdWI1OTA2SythclBDUWZNTTE2VEN0?=
 =?utf-8?B?Qm5KVGtYZnlvTWNvVUpJaW5jaTVCTERiQXVWaGRqTE5sc0JkZ1lBVFdaQlRI?=
 =?utf-8?B?YlVqSW9NazdscGN3SjFKajErZnh2N29XY1M5RnA5OHhaTXVUR0ZYUzBtQTZt?=
 =?utf-8?B?MXdWWXh2dVdlZVRyVE81K3lXV1I2WFBXVXNxTUltbTFrdnJxVnVJRnpTUjV2?=
 =?utf-8?B?QzZrVks5QkdRTjFkcUpwOGlaRXNhNW4vTTdGNUE4Rk85aUhPNy9ac2pOVk1z?=
 =?utf-8?B?em91SUdoUUVhM1IwVUlOZGxrOWQ0QWNNZnAvdThFdTR6cmExaUVNaW5kY0dx?=
 =?utf-8?B?SDFQd05TbzVjK2kram5wRmNPNnRRdnQzRkxKbEVjcUtZaWRGNi9PMmFCbzMv?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36613A0A7FBFC64D85BA144FA29042B9@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9244a23e-f623-4d5b-91ef-08dbfa2b2282
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 09:25:37.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBBu5BdcxlyV7bfJ7y9FOIPDXoRH+5w9dakDn4irDBpK04dP3fRqRWAN9R1ZLTQir0Jhfc+SPcUDDdjU0YquOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9714

T24gTW9uLCBEZWMgMTEsIDIwMjMgYXQgMDI6MTM6NTZBTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gPiA+IEFzIGJvdGggcmVhbHRlay1jb21tb24gYW5kIHJlYWx0
ZWste3NtaSxtZGlvfSBtdXN0IGFsd2F5cyBiZSBsb2FkZWQNCj4gPiA+IHRvZ2V0aGVyLCB3ZSBj
YW4gc2F2ZSBzb21lIHJlc291cmNlcyBtZXJnaW5nIHRoZW0gaW50byBhIHNpbmdsZSBtb2R1bGUu
DQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTHVpeiBBbmdlbG8gRGFyb3MgZGUgTHVjYSA8
bHVpemx1Y2FAZ21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9uZXQvZHNhL3Jl
YWx0ZWsvS2NvbmZpZyAgICAgICAgICB8IDQgKystLQ0KPiA+ID4gIGRyaXZlcnMvbmV0L2RzYS9y
ZWFsdGVrL01ha2VmaWxlICAgICAgICAgfCA4ICsrKysrLS0tDQo+ID4gPiAgZHJpdmVycy9uZXQv
ZHNhL3JlYWx0ZWsvcmVhbHRlay1jb21tb24uYyB8IDEgKw0KPiA+ID4gIGRyaXZlcnMvbmV0L2Rz
YS9yZWFsdGVrL3JlYWx0ZWstbWRpby5jICAgfCA0IC0tLS0NCj4gPiA+ICBkcml2ZXJzL25ldC9k
c2EvcmVhbHRlay9yZWFsdGVrLXNtaS5jICAgIHwgNCAtLS0tDQo+ID4gPiAgNSBmaWxlcyBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9LY29uZmlnIGIvZHJpdmVycy9uZXQvZHNh
L3JlYWx0ZWsvS2NvbmZpZw0KPiA+ID4gaW5kZXggOWQxODJmZGUxMWI0Li42OTg5OTcyZWViYzMg
MTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9LY29uZmlnDQo+ID4g
PiArKysgYi9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9LY29uZmlnDQo+ID4gPiBAQCAtMTYsMTQg
KzE2LDE0IEBAIG1lbnVjb25maWcgTkVUX0RTQV9SRUFMVEVLDQo+ID4gPiAgaWYgTkVUX0RTQV9S
RUFMVEVLDQo+ID4gPg0KPiA+ID4gIGNvbmZpZyBORVRfRFNBX1JFQUxURUtfTURJTw0KPiA+ID4g
LSAgICAgdHJpc3RhdGUgIlJlYWx0ZWsgTURJTyBpbnRlcmZhY2Ugc3VwcG9ydCINCj4gPiA+ICsg
ICAgIGJvb2wgIlJlYWx0ZWsgTURJTyBpbnRlcmZhY2Ugc3VwcG9ydCINCj4gPiA+ICAgICAgIGRl
cGVuZHMgb24gT0YNCj4gPiA+ICAgICAgIGhlbHANCj4gPiA+ICAgICAgICAgU2VsZWN0IHRvIGVu
YWJsZSBzdXBwb3J0IGZvciByZWdpc3RlcmluZyBzd2l0Y2hlcyBjb25maWd1cmVkDQo+ID4gPiAg
ICAgICAgIHRocm91Z2ggTURJTy4NCj4gPiA+DQo+ID4gPiAgY29uZmlnIE5FVF9EU0FfUkVBTFRF
S19TTUkNCj4gPiA+IC0gICAgIHRyaXN0YXRlICJSZWFsdGVrIFNNSSBpbnRlcmZhY2Ugc3VwcG9y
dCINCj4gPiA+ICsgICAgIGJvb2wgIlJlYWx0ZWsgU01JIGludGVyZmFjZSBzdXBwb3J0Ig0KPiA+
ID4gICAgICAgZGVwZW5kcyBvbiBPRg0KPiA+ID4gICAgICAgaGVscA0KPiA+ID4gICAgICAgICBT
ZWxlY3QgdG8gZW5hYmxlIHN1cHBvcnQgZm9yIHJlZ2lzdGVyaW5nIHN3aXRjaGVzIGNvbm5lY3Rl
ZA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL01ha2VmaWxlIGIv
ZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvTWFrZWZpbGUNCj4gPiA+IGluZGV4IDVlMGMxZWYyMDBh
My4uODhmNjY1MmY5ODUwIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvZHNhL3JlYWx0
ZWsvTWFrZWZpbGUNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL01ha2VmaWxl
DQo+ID4gPiBAQCAtMSw3ICsxLDkgQEANCj4gPiA+ICAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wDQo+ID4gPiAtb2JqLSQoQ09ORklHX05FVF9EU0FfUkVBTFRFSykgICAgICAgICAg
ICAgICAgKz0gcmVhbHRlay1jb21tb24ubw0KPiA+ID4gLW9iai0kKENPTkZJR19ORVRfRFNBX1JF
QUxURUtfTURJTykgICArPSByZWFsdGVrLW1kaW8ubw0KPiA+ID4gLW9iai0kKENPTkZJR19ORVRf
RFNBX1JFQUxURUtfU01JKSAgICArPSByZWFsdGVrLXNtaS5vDQo+ID4gPiArb2JqLSQoQ09ORklH
X05FVF9EU0FfUkVBTFRFSykgICAgICAgICAgICAgICAgKz0gcmVhbHRla19jb21tb24ubw0KPiA+
ID4gK3JlYWx0ZWtfY29tbW9uLW9ianMteSAgICAgICAgICAgICAgICAgICAgICAgIDo9IHJlYWx0
ZWstY29tbW9uLm8NCj4gPg0KPiA+IFRoaXMgaXMgd2VpcmQgd2l0aCB0aGUgLSBhbmQgXy4gQWxz
byByZWFsdGVrLWNvbW1vbiBpcyBub3QgYSB2ZXJ5DQo+ID4gZGVzY3JpcHRpdmUgbW9kdWxlIG5h
bWUuIE1heWJlIHJlYWx0ZWstZHNhPw0KPiA+DQo+ID4gb2JqLSQoQ09ORklHX05FVF9EU0FfUkVB
TFRFSykgKz0gcmVhbHRlay1kc2Eubw0KPiA+IHJlYWx0ZWstZHNhLW9ianMteSAgICAgICAgICAg
ICs9IHJlYWx0ZWstY29tbW9uLm8NCj4gPiByZWFsdGVrLWRzYS1vYmpzLSQoLi4uX01ESU8pICAr
PSByZWFsdGVrLW1kaW8ubw0KPiA+IHJlYWx0ZWstZHNhLW9ianMtJCguLi5fU01JKSAgICs9IHJl
YWx0ZWstc21pLm8NCj4gDQo+IFllcywgSSdtIG5vdCBwcm91ZCBvZiBpdC4gVGhlIHJlYWx0ZWtf
Y29tbW9uL3JlYWx0ZWstY29tbW9uIHRyaWNrIGlzDQo+IGp1c3QgdG8gYnlwYXNzIHRoZSBmYWN0
IHRoYXQgSSBjYW5ub3QgbGluayBtdWx0aXBsZSBmaWxlcyBpbnRvIGENCj4gbW9kdWxlIHRoYXQg
aGFzIHRoZSBzYW1lIG5hbWUgYXMgb25lIG9mIHRoZXNlIGZpbGVzLiBCdXQgcmVhbHRlay1kc2EN
Cj4gaXMgZmluZSBhbmQgaXQgd291bGQgYXZvaWQgY29uZmxpY3RzIHdpdGggb3RoZXIgcmVhbHRl
ayBzdHVmZiBpbiB0aGUNCj4ga2VybmVsIHRoYXQgbWlnaHQgaGF2ZSBhIGNvbW1vbiBtb2R1bGUu
IEhvd2V2ZXIsIEkgd291bGQgaW50cm9kdWNlDQo+IHRoYXQgbmFtZSBhbHJlYWR5IGluIHRoZSBw
cmV2aW91cyBwYXRjaC4NCg0KT0sNCg0KPiANCj4gPiBBbHNvIHdoYXQgaGFwcGVucyBpZiBJIGp1
c3QgZW5hYmxlIENPTkZJR19ORVRfRFNBX1JFQUxURUsgYW5kIG5vdGhpbmcNCj4gPiBlbHNlLiBE
byBJIGdldCBhIG1vZHVsZSB0aGF0IGRvZXNuJ3QgZG8gYW55dGhpbmc/IE5vdCBzdXJlIGlmIGl0
J3MgYSBiaWcNCj4gPiBkZWFsLg0KPiANCj4gVGhlIGNvbmZpZyBsYW5ndWFnZSBtaWdodCBub3Qg
YmUgZ29vZCBlbm91Z2ggdG8gaGFuZGxlIHRoYXQgbmljZWx5Lg0KPiBUaGVyZSBpcyB0aGUgImlt
cGx5IiBrZXl3b3JkIGJ1dCBpdCBkb2VzIG5vdCBmb3JjZSBhbnl0aGluZy4gSSBkb24ndA0KPiBr
bm93IGhvdyB0byByZXF1aXJlICJhdCBsZWFzdCBvbmUgb2YgdGhlc2UgdHdvIGludGVyZmFjZXMi
IHdpdGhvdXQNCj4gY3JlYXRpbmcgYSBkZXBlbmRlbmN5IGN5Y2xlLiBJIHdvdWxkIGp1c3QgbGV0
IGl0IGJ1aWxkIGEgdXNlbGVzcw0KPiBjb21tb24gbW9kdWxlLiBCdWlsZGluZyB3aXRob3V0IHZh
cmlhbnRzIGRvZXMgbWFrZSBhIGxpdHRsZSBiaXQgb2YNCj4gc2Vuc2UgaWYgeW91IHdhbnQgdG8g
YnVpbGQgYSBuZXcgZHJpdmVyIG91dC1vZi10cmVlLg0KDQpBZ3JlZSwgSSBkb24ndCBrbm93IGEg
Z29vZCB3YXkgdG8gcHJldmVudCBpdC4gSSBkb24ndCB0aGluayBpdCdzIGEgYmlnDQpkZWFsLg0K
DQo+IA0KPiA+ID4gK3JlYWx0ZWtfY29tbW9uLW9ianMtJChDT05GSUdfTkVUX0RTQV9SRUFMVEVL
X01ESU8pICs9IHJlYWx0ZWstbWRpby5vDQo+ID4gPiArcmVhbHRla19jb21tb24tb2Jqcy0kKENP
TkZJR19ORVRfRFNBX1JFQUxURUtfU01JKSArPSByZWFsdGVrLXNtaS5vDQo+ID4gPiArcmVhbHRl
a19jb21tb24tb2JqcyAgICAgICAgICAgICAgICAgIDo9ICQocmVhbHRla19jb21tb24tb2Jqcy15
KQ0KPiA+ID4gIG9iai0kKENPTkZJR19ORVRfRFNBX1JFQUxURUtfUlRMODM2NlJCKSArPSBydGw4
MzY2Lm8NCj4gPiA+ICBydGw4MzY2LW9ianMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA6PSBydGw4MzY2LWNvcmUubyBydGw4MzY2cmIubw0KPiA+ID4gIG9iai0kKENPTkZJR19ORVRf
RFNBX1JFQUxURUtfUlRMODM2NU1CKSArPSBydGw4MzY1bWIubw0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3JlYWx0ZWstY29tbW9uLmMgYi9kcml2ZXJzL25ldC9k
c2EvcmVhbHRlay9yZWFsdGVrLWNvbW1vbi5jDQo+ID4gPiBpbmRleCA3NWI2YWEwNzE5OTAuLjcz
YzI1ZDExNGRkMyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3Jl
YWx0ZWstY29tbW9uLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3JlYWx0
ZWstY29tbW9uLmMNCj4gPiA+IEBAIC0xMzIsNSArMTMyLDYgQEAgdm9pZCByZWFsdGVrX2NvbW1v
bl9yZW1vdmUoc3RydWN0IHJlYWx0ZWtfcHJpdiAqcHJpdikNCj4gPiA+ICBFWFBPUlRfU1lNQk9M
KHJlYWx0ZWtfY29tbW9uX3JlbW92ZSk7DQo+ID4gPg0KPiA+ID4gIE1PRFVMRV9BVVRIT1IoIkx1
aXogQW5nZWxvIERhcm9zIGRlIEx1Y2EgPGx1aXpsdWNhQGdtYWlsLmNvbT4iKTsNCj4gPiA+ICtN
T0RVTEVfQVVUSE9SKCJMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+Iik7
DQo+ID4gPiAgTU9EVUxFX0RFU0NSSVBUSU9OKCJSZWFsdGVrIERTQSBzd2l0Y2hlcyBjb21tb24g
bW9kdWxlIik7DQo+ID4gPiAgTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3JlYWx0ZWstbWRpby5jIGIvZHJpdmVycy9uZXQv
ZHNhL3JlYWx0ZWsvcmVhbHRlay1tZGlvLmMNCj4gPiA+IGluZGV4IDRjOWE3NDRiNzJmOC4uYmI1
YmZmNzE5YWU5IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcmVh
bHRlay1tZGlvLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3JlYWx0ZWst
bWRpby5jDQo+ID4gPiBAQCAtMTY4LDcgKzE2OCwzIEBAIHZvaWQgcmVhbHRla19tZGlvX3NodXRk
b3duKHN0cnVjdCBtZGlvX2RldmljZSAqbWRpb2RldikNCj4gPiA+ICAgICAgIGRldl9zZXRfZHJ2
ZGF0YSgmbWRpb2Rldi0+ZGV2LCBOVUxMKTsNCj4gPiA+ICB9DQo+ID4gPiAgRVhQT1JUX1NZTUJP
TF9HUEwocmVhbHRla19tZGlvX3NodXRkb3duKTsNCj4gPiA+IC0NCj4gPiA+IC1NT0RVTEVfQVVU
SE9SKCJMdWl6IEFuZ2VsbyBEYXJvcyBkZSBMdWNhIDxsdWl6bHVjYUBnbWFpbC5jb20+Iik7DQo+
ID4gPiAtTU9EVUxFX0RFU0NSSVBUSU9OKCJEcml2ZXIgZm9yIFJlYWx0ZWsgZXRoZXJuZXQgc3dp
dGNoIGNvbm5lY3RlZCB2aWEgTURJTyBpbnRlcmZhY2UiKTsNCj4gPiA+IC1NT0RVTEVfTElDRU5T
RSgiR1BMIik7DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcmVh
bHRlay1zbWkuYyBiL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3JlYWx0ZWstc21pLmMNCj4gPiA+
IGluZGV4IDI0NjAyNGVlYzNiZC4uMWNhMmFhNzg0ZDI0IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJp
dmVycy9uZXQvZHNhL3JlYWx0ZWsvcmVhbHRlay1zbWkuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9u
ZXQvZHNhL3JlYWx0ZWsvcmVhbHRlay1zbWkuYw0KPiA+ID4gQEAgLTQ0Myw3ICs0NDMsMyBAQCB2
b2lkIHJlYWx0ZWtfc21pX3NodXRkb3duKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gPiAgICAgICBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBOVUxMKTsNCj4gPiA+ICB9DQo+
ID4gPiAgRVhQT1JUX1NZTUJPTF9HUEwocmVhbHRla19zbWlfc2h1dGRvd24pOw0KPiA+ID4gLQ0K
PiA+ID4gLU1PRFVMRV9BVVRIT1IoIkxpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJv
Lm9yZz4iKTsNCj4gPiA+IC1NT0RVTEVfREVTQ1JJUFRJT04oIkRyaXZlciBmb3IgUmVhbHRlayBl
dGhlcm5ldCBzd2l0Y2ggY29ubmVjdGVkIHZpYSBTTUkgaW50ZXJmYWNlIik7DQo+ID4gPiAtTU9E
VUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiA+ID4gLS0NCj4gPiA+IDIuNDMuMA0KPiA+ID4=

