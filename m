Return-Path: <netdev+bounces-31900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C037914B6
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 11:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCE5280DC5
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 09:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A55517C9;
	Mon,  4 Sep 2023 09:27:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9F37E
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 09:27:43 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043F61AC
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 02:27:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-322-G_VhRZ08One8ghcukvLbBA-1; Mon, 04 Sep 2023 10:27:39 +0100
X-MC-Unique: G_VhRZ08One8ghcukvLbBA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Sep
 2023 10:27:28 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 4 Sep 2023 10:27:28 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
	syzbot <syzkaller@googlegroups.com>, Kyle Zeng <zengyhkyle@gmail.com>, "Kees
 Cook" <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: RE: [PATCH net] net: deal with integer overflows in kmalloc_reserve()
Thread-Topic: [PATCH net] net: deal with integer overflows in
 kmalloc_reserve()
Thread-Index: AQHZ3DpDqBe85QJ3kk2CYjFaBCIaHrAKXmHw///2hoCAABTPMA==
Date: Mon, 4 Sep 2023 09:27:28 +0000
Message-ID: <837a03d12d8345bfa7e9874c1e7d9156@AcuMS.aculab.com>
References: <20230831183750.2952307-1-edumazet@google.com>
 <d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com>
 <CANn89iJY4=Q0edL-mf2JrRiz8Ld7bQcogOrc4ozLEVD8qz8o2A@mail.gmail.com>
In-Reply-To: <CANn89iJY4=Q0edL-mf2JrRiz8Ld7bQcogOrc4ozLEVD8qz8o2A@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPg0KPiBTZW50OiAwNCBTZXB0
ZW1iZXIgMjAyMyAxMDowNg0KPiBUbzogRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAQUNVTEFC
LkNPTT4NCj4gQ2M6IERhdmlkIFMgLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBKYWt1
YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkNCj4gPHBhYmVuaUByZWRo
YXQuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZXJpYy5kdW1hemV0QGdtYWlsLmNvbTsg
c3l6Ym90DQo+IDxzeXprYWxsZXJAZ29vZ2xlZ3JvdXBzLmNvbT47IEt5bGUgWmVuZyA8emVuZ3lo
a3lsZUBnbWFpbC5jb20+OyBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz47DQo+IFZs
YXN0aW1pbCBCYWJrYSA8dmJhYmthQHN1c2UuY3o+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0
XSBuZXQ6IGRlYWwgd2l0aCBpbnRlZ2VyIG92ZXJmbG93cyBpbiBrbWFsbG9jX3Jlc2VydmUoKQ0K
PiANCj4gT24gTW9uLCBTZXAgNCwgMjAyMyBhdCAxMDo0MeKAr0FNIERhdmlkIExhaWdodCA8RGF2
aWQuTGFpZ2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogRXJpYyBEdW1hemV0
DQo+ID4gPiBTZW50OiAzMSBBdWd1c3QgMjAyMyAxOTozOA0KPiA+ID4NCj4gPiA+IEJsYW1lZCBj
b21taXQgY2hhbmdlZDoNCj4gPiA+ICAgICBwdHIgPSBrbWFsbG9jKHNpemUpOw0KPiA+ID4gICAg
IGlmIChwdHIpDQo+ID4gPiAgICAgICBzaXplID0ga3NpemUocHRyKTsNCj4gPiA+DQo+ID4gPiB0
bzoNCj4gPiA+ICAgICBzaXplID0ga21hbGxvY19zaXplX3JvdW5kdXAoc2l6ZSk7DQo+ID4gPiAg
ICAgcHRyID0ga21hbGxvYyhzaXplKTsNCj4gPiA+DQo+ID4gPiBUaGlzIGFsbG93ZWQgdmFyaW91
cyBjcmFzaCBhcyByZXBvcnRlZCBieSBzeXpib3QgWzFdDQo+ID4gPiBhbmQgS3lsZSBaZW5nLg0K
PiA+ID4NCj4gPiA+IFByb2JsZW0gaXMgdGhhdCBpZiBAc2l6ZSBpcyBiaWdnZXIgdGhhbiAweDgw
MDAwMDAxLA0KPiA+ID4ga21hbGxvY19zaXplX3JvdW5kdXAoc2l6ZSkgcmV0dXJucyAyXjMyLg0K
PiA+ID4NCj4gPiA+IGttYWxsb2NfcmVzZXJ2ZSgpIHVzZXMgYSAzMmJpdCB2YXJpYWJsZSAob2Jq
X3NpemUpLA0KPiA+ID4gc28gMl4zMiBpcyB0cnVuY2F0ZWQgdG8gMC4NCj4gPg0KPiA+IENhbiB0
aGlzIGhhcHBlbiBvbiAzMmJpdCBhcmNoPw0KPiA+IEluIHRoYXQgY2FzZSBrbWFsbG9jX3NpemVf
cm91bmR1cCgpIHdpbGwgcmV0dXJuIDAuDQo+IA0KPiBNYXliZSwgYnV0IHRoaXMgd291bGQgYmUg
YSBidWcgaW4ga21hbGxvY19zaXplX3JvdW5kdXAoKQ0KDQpUaGF0IGNvbnRhaW5zOg0KCS8qIFNo
b3J0LWNpcmN1aXQgc2F0dXJhdGVkICJ0b28tbGFyZ2UiIGNhc2UuICovDQoJaWYgKHVubGlrZWx5
KHNpemUgPT0gU0laRV9NQVgpKQ0KCQlyZXR1cm4gU0laRV9NQVg7DQoNCkl0IGNhbiBhbHNvIHJl
dHVybiAwIG9uIGZhaWx1cmUsIEkgY2FuJ3QgcmVtZW1iZXIgaWYga21hbGxvYygwKQ0KaXMgZ3Vh
cmFudGVlZCB0byBiZSBOVUxMIChtYWxsb2MoMCkgY2FuIGRvICdvdGhlciB0aGluZ3MnKS4NCg0K
V2hpY2ggaXMgZW50aXJlbHkgaG9wZWxlc3Mgc2luY2UgTUFYX1NJWkUgaXMgKHNpemVfdCktMS4N
Cg0KSUlSQyBrbWFsbG9jKCkgaGFzIGEgc2l6ZSBsaW1pdCAobWF4ICdvcmRlcicgb2YgcGFnZXMp
IHNvDQprbWFsbG9jX3NpemVfcm91bmR1cCgpIG91Z2h0IGNoZWNrIGZvciB0aGF0IChvciBpdHMg
bWF4IHZhbHVlKS4NCg0KVGhlIGZpbmFsOg0KCS8qIFRoZSBmbGFncyBkb24ndCBtYXR0ZXIgc2lu
Y2Ugc2l6ZV9pbmRleCBpcyBjb21tb24gdG8gYWxsLiAqLw0KCWMgPSBrbWFsbG9jX3NsYWIoc2l6
ZSwgR0ZQX0tFUk5FTCk7DQoJcmV0dXJuIGMgPyBjLT5vYmplY3Rfc2l6ZSA6IDA7DQpwcm9iYWJs
eSBvdWdodCB0byByZXR1cm4gc2l6ZSBpZiBjIGlzIGV2ZW4gTlVMTC4NCg0KCURhdmlkDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==


