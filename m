Return-Path: <netdev+bounces-19260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A21D875A0AB
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCD6281AA9
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B3922F17;
	Wed, 19 Jul 2023 21:38:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E822F0B
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:38:50 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9251FD5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:38:48 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-Rz-uIRDPNRGmb65ChaqQQA-1; Wed, 19 Jul 2023 22:38:45 +0100
X-MC-Unique: Rz-uIRDPNRGmb65ChaqQQA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Jul
 2023 22:38:44 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 19 Jul 2023 22:38:44 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "kuni1840@gmail.com" <kuni1840@gmail.com>,
	"kuniyu@amazon.com" <kuniyu@amazon.com>, "leitao@debian.org"
	<leitao@debian.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "syzkaller@googlegroups.com"
	<syzkaller@googlegroups.com>
Subject: RE: [PATCH v1 net 2/2] af_packet: Fix warning of fortified memcpy()
 in packet_getname().
Thread-Topic: [PATCH v1 net 2/2] af_packet: Fix warning of fortified memcpy()
 in packet_getname().
Thread-Index: AQHZuojKKXmXWzaE7kCaTSM9ZQwyvq/BnRaw
Date: Wed, 19 Jul 2023 21:38:44 +0000
Message-ID: <c391b7352213421da9771e5479d2a6ca@AcuMS.aculab.com>
References: <64b8525db522_2831cb294d@willemb.c.googlers.com.notmuch>
 <20230719212709.63492-1-kuniyu@amazon.com>
 <64b856d553b5b_2842f2294f0@willemb.c.googlers.com.notmuch>
In-Reply-To: <64b856d553b5b_2842f2294f0@willemb.c.googlers.com.notmuch>
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogV2lsbGVtIGRlIEJydWlqbg0KPiBTZW50OiAxOSBKdWx5IDIwMjMgMjI6MzQNCj4gDQo+
ID4gPg0KPiA+ID4gPiBUaGUgd3JpdGUgc2VlbXMgdG8gb3ZlcmZsb3csIGJ1dCBhY3R1YWxseSBu
b3Qgc2luY2Ugd2UgdXNlIHN0cnVjdA0KPiA+ID4gPiBzb2NrYWRkcl9zdG9yYWdlIGRlZmluZWQg
aW4gX19zeXNfZ2V0c29ja25hbWUoKS4NCj4gPiA+DQo+ID4gPiBXaGljaCBnaXZlcyBfS19TU19N
QVhTSVpFID09IDEyOCwgbWludXMgb2Zmc2V0b2Yoc3RydWN0IHNvY2thZGRyX2xsLCBzbGxfYWRk
cikuDQo+ID4gPg0KPiA+ID4gRm9yIGZ1biwgdGhlcmUgaXMgYW5vdGhlciBjYWxsZXIuIGdldHNv
Y2tvcHQgU09fUEVFUk5BTUUgYWxzbyBjYWxscw0KPiA+ID4gc29jay0+b3BzLT5nZXRuYW1lLCB3
aXRoIGEgYnVmZmVyIGhhcmRjb2RlZCB0byAxMjguIFNob3VsZCBwcm9iYWJseQ0KPiA+ID4gdXNl
IHNpemVvZihzb2NrYWRkcl9zdG9yYWdlKSBmb3IgZG9jdW1lbnRhdGlvbiwgYXQgbGVhc3QuDQo+
ID4gPg0KPiA+ID4gLi4gYW5kIEkganVzdCBub3RpY2VkIHRoYXQgdGhhdCB3YXMgYXR0ZW1wdGVk
LCBidXQgbm90IGNvbXBsZXRlZA0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDE0MDkyODEzNTU0NS5HQTIzMjIwQHR5cGUueW91cGkucGVyc28uYXF1aWxlbmV0LmZyLw0KPiA+
DQo+ID4gWWVzLCBhY3V0YWxseSBteSBmaXJzdCBkcmFmdCBoYWQgdGhlIGRpZmYgYmVsb3csIGJ1
dCBJIGRyb3BwZWQgaXQNCj4gPiBiZWNhdXNlIHBhY2tldF9nZXRuYW1lKCkgZG9lcyBub3QgY2Fs
bCBtZW1jcHkoKSBmb3IgU09fUEVFUk5BTUUgYXQNCj4gPiBsZWFzdCwgYW5kIHNhbWUgZm9yIGdl
dHBlZXJuYW1lKCkuDQo+ID4NCj4gPiBBbmQgaW50ZXJlc3RpbmdseSB0aGVyZSB3YXMgYSByZXZp
dmFsIHRocmVhZC4NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyMzA3MTkw
ODQ0MTUuMTM3ODY5Ni0xLWxlaXRhb0BkZWJpYW4ub3JnLw0KPiANCj4gQWggaW50ZXJlc3Rpbmcg
OikgVG9waWNhbC4NCj4gDQo+ID4gSSBjYW4gaW5jbHVkZSB0aGlzIGluIHYyIGlmIG5lZWRlZC4N
Cj4gPiBXaGF0IGRvIHlvdSB0aGluayA/DQo+ID4NCj4gPiAtLS04PC0tLQ0KPiA+IGRpZmYgLS1n
aXQgYS9uZXQvY29yZS9zb2NrLmMgYi9uZXQvY29yZS9zb2NrLmMNCj4gPiBpbmRleCA5MzcwZmQ1
MGFhMmMuLmYxZTg4N2MzMTE1ZiAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvY29yZS9zb2NrLmMNCj4g
PiArKysgYi9uZXQvY29yZS9zb2NrLmMNCj4gPiBAQCAtMTgxNSwxNCArMTgxNSwxNCBAQCBpbnQg
c2tfZ2V0c29ja29wdChzdHJ1Y3Qgc29jayAqc2ssIGludCBsZXZlbCwgaW50IG9wdG5hbWUsDQo+
ID4NCj4gPiAgCWNhc2UgU09fUEVFUk5BTUU6DQo+ID4gIAl7DQo+ID4gLQkJY2hhciBhZGRyZXNz
WzEyOF07DQo+ID4gKwkJc3RydWN0IHNvY2thZGRyX3N0b3JhZ2UgYWRkcmVzczsNCj4gPg0KPiA+
IC0JCWx2ID0gc29jay0+b3BzLT5nZXRuYW1lKHNvY2ssIChzdHJ1Y3Qgc29ja2FkZHIgKilhZGRy
ZXNzLCAyKTsNCj4gPiArCQlsdiA9IHNvY2stPm9wcy0+Z2V0bmFtZShzb2NrLCAoc3RydWN0IHNv
Y2thZGRyICopJmFkZHJlc3MsIDIpOw0KPiA+ICAJCWlmIChsdiA8IDApDQo+ID4gIAkJCXJldHVy
biAtRU5PVENPTk47DQo+ID4gIAkJaWYgKGx2IDwgbGVuKQ0KPiA+ICAJCQlyZXR1cm4gLUVJTlZB
TDsNCj4gPiAtCQlpZiAoY29weV90b19zb2NrcHRyKG9wdHZhbCwgYWRkcmVzcywgbGVuKSkNCj4g
PiArCQlpZiAoY29weV90b19zb2NrcHRyKG9wdHZhbCwgJmFkZHJlc3MsIGxlbikpDQo+ID4gIAkJ
CXJldHVybiAtRUZBVUxUOw0KPiA+ICAJCWdvdG8gbGVub3V0Ow0KPiA+ICAJfQ0KPiA+IC0tLTg8
LS0tDQo+IA0KPiBJIGFncmVlIHRoYXQgaXQncyBhIHdvcnRod2hpbGUgY2hhbmdlLiBJIHRoaW5r
IGl0IHNob3VsZCBiZSBhbg0KPiBpbmRlcGVuZGVudCBjb21taXQuIEFuZCBzaW5jZSBpdCBkb2Vz
IG5vdCBmaXggYSBidWcsIHRhcmdldCBuZXQtbmV4dC4NCg0KSXQgaXMgcG90ZW50aWFsbHkgYSBi
dWcuDQpUaGVyZSBpcyBubyByZXF1aXJlbWVudCB0aGF0IHRoZSBjb21waWxlciBhbGlnbiAnY2hh
ciBhZGRyZXNzWzEyOF0nLg0KU28gdGhlIGFjY2Vzc2VzIGNvdWxkIGZhdWx0IGxhdGVyIG9uLg0K
DQpJbiBwcmFjdGlzZSBpdCB3aWxsIGJlIGFsaWduZWQgLSB1bmxlc3MgdGhlIGNvbXBpbGVyIGlz
IGJlaW5nDQpwZXJ2ZXJzZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


