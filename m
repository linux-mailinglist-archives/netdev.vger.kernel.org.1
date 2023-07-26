Return-Path: <netdev+bounces-21405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFAC763850
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0138281CA2
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C430E21D37;
	Wed, 26 Jul 2023 14:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A83BA4F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:06:28 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA0B211F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:06:26 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-112-KkXkjJA2ML2yoU63bn4xmA-1; Wed, 26 Jul 2023 15:06:24 +0100
X-MC-Unique: KkXkjJA2ML2yoU63bn4xmA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 26 Jul
 2023 15:06:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 26 Jul 2023 15:06:23 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>
CC: Paolo Abeni <pabeni@redhat.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH 1/2] Move hash calculation inside udp4_lib_lookup2()
Thread-Topic: [PATCH 1/2] Move hash calculation inside udp4_lib_lookup2()
Thread-Index: Adm/uWROjgkE4udKTdiQAS8haeW/0gABYaaAAAIc9cD///SBgP//7qOg
Date: Wed, 26 Jul 2023 14:06:23 +0000
Message-ID: <bde967f7aa5d401b8f968b15dc33acfd@AcuMS.aculab.com>
References: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com>
 <5eb8631d430248999116ce8ced13e4b2@AcuMS.aculab.com>
 <fce08e76da7e3882319ae935c38e9e2eccf2dcae.camel@redhat.com>
 <4deda035df8142a6977ce844eb705bdb@AcuMS.aculab.com>
 <CANn89iJ--FGA38nLJvZNKyZrqSdGAS1ktsmLULk8ZVRp8XScUg@mail.gmail.com>
In-Reply-To: <CANn89iJ--FGA38nLJvZNKyZrqSdGAS1ktsmLULk8ZVRp8XScUg@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDI2IEp1bHkgMjAyMyAxNTowNA0KPiANCj4gT24g
V2VkLCBKdWwgMjYsIDIwMjMgYXQgNDowMuKAr1BNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGFvbG8gQWJlbmkNCj4gPiA+IFNl
bnQ6IDI2IEp1bHkgMjAyMyAxNDo0NA0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgMjAyMy0wNy0yNiBh
dCAxMjowNSArMDAwMCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+ID4gPiBQYXNzIHRoZSB1ZHB0
YWJsZSBhZGRyZXNzIGludG8gdWRwNF9saWJfbG9va3VwMigpIGluc3RlYWQgb2YgdGhlIGhhc2gg
c2xvdC4NCj4gPiA+ID4NCj4gPiA+ID4gV2hpbGUgaXB2NF9wb3J0YWRkcl9oYXNoKG5ldCwgSVBf
QUREUl9BTlksIDApIGlzIGNvbnN0YW50IGZvciBlYWNoIG5ldA0KPiA+ID4gPiAodGhlIHBvcnQg
aXMgYW4geG9yKSB0aGUgdmFsdWUgaXNuJ3Qgc2F2ZWQuDQo+ID4gPiA+IFNpbmNlIHRoZSBoYXNo
IGZ1bmN0aW9uIGRvZXNuJ3QgZ2V0IHNpbXBsaWZpZWQgd2hlbiBwYXNzZWQgemVybyB0aGUgaGFz
aA0KPiA+ID4NCj4gPiA+IEFyZSB5b3Ugc3VyZT8gY291bGQgeW91IHBsZWFzZSBvYmpkdW1wIGFu
ZCBjb21wYXJlIHRoZSBiaW5hcnkgY29kZQ0KPiA+ID4gZ2VuZXJhdGVkIGJlZm9yZSBhbmQgYWZ0
ZXIgdGhlIHBhdGNoPyBJbiB0aGVvcnkgYWxsIHRoZSBjYWxsZXJzIHVwIHRvDQo+ID4gPiBfX2po
YXNoX2ZpbmFsKCkgaW5jbHVkZWQgc2hvdWxkIGJlIGlubGluZWQsIGFuZCB0aGUgY29tcGlsZXIg
c2hvdWxkIGJlDQo+ID4gPiBhYmxlIHRvIG9wdGltemUgYXQgbGVhc3Qgcm9sMzIoMCwgPG4+KS4N
Cj4gPg0KPiA+IEkgbG9va2VkIHRoZSBoYXNoIGlzIDIwKyBpbnN0cnVjdGlvbnMgYW5kIHByZXR0
eSBtdWNoIGFsbCBvZg0KPiA+IHRoZW0gYXBwZWFyZWQgdHdpY2UuDQo+ID4gKEknbSBpbiB0aGUg
d3JvbmcgYnVpbGRpbmcgdG8gaGF2ZSBhIGJ1aWxkYWJsZSBrZXJuZWwgdHJlZS4pDQo+ID4NCj4g
PiBJdCBoYXMgdG8gYmUgc2FpZCB0aGF0IGlwdjRfcG9ydGFkZHJfaGFzaChuZXQsIElQQUREUl9B
TlksIHBvcnQpDQo+ID4gY291bGQganVzdCBiZSBuZXRfaGFzaF9taXgobmV0KSBeIHBvcnQuDQo+
ID4gKE9yIG1heWJlIHlvdSBjb3VsZCB1c2UgYSBkaWZmZXJlbnQgcmFuZG9tIHZhbHVlLikNCj4g
Pg0KPiA+IEknbSBub3QgZXZlbiBzdXJlIHRoZSByZWxhdGl2ZWx5IGV4cGVuc2l2ZSBtaXhpbmcg
b2YgJ3NhZGRyJw0KPiA+IGlzIG5lZWRlZCAtIGl0IGlzIG9uZSBvZiB0aGUgbG9jYWwgSVB2NCBh
ZGRyZXNzZXMuDQo+ID4gTWl4aW5nIGluIHRoZSByZW1vdGUgYWRkcmVzcyBmb3IgY29ubmVjdGVk
IHNvY2tldHMgbWlnaHQNCj4gPiBiZSB1c2VmdWwgZm9yIGFueSBzZXJ2ZXIgY29kZSB0aGF0IHVz
ZXMgYSBsb3Qgb2YgY29ubmVjdGVkDQo+ID4gdWRwIHNvY2tldHMgLSBidXQgdGhhdCBpc24ndCBk
b25lLg0KPiA+DQo+ID4gV2Ugd2lsbCBoYXZlIGh1bmRyZWRzIG9mIHVkcCBzb2NrZXRzIHdpdGgg
ZGlmZmVyZW50IHBvcnRzIHRoYXQNCj4gPiBhcmUgbm90IGNvbm5lY3RlZCAoSSBkb24ndCBrbm93
IGlmIHRoZXkgZ2V0IGJvdW5kIHRvIGEgbG9jYWwNCj4gPiBhZGRyZXNzKS4gU28gYSByZW1vdGUg
YWRkcmVzcyBoYXNoIHdvdWxkbid0IGhlbHAuDQo+ID4NCj4gPiBJZiB5b3UgbG9vayBhdCB0aGUg
Z2VuZXJhdGVkIGNvZGUgZm9yIF9fdWRwNF9saWJfbG9va3VwKCkNCj4gPiBpdCBpcyBhY3R1YWxs
eSBxdWl0ZSBob3JyaWQuDQo+ID4gVG9vIG1hbnkgY2FsbGVkIGZ1bmN0aW9ucyB3aXRoIHRvbyBt
YW55IHBhcmFtZXRlcnMuDQo+ID4gVGhpbmdzIHNwaWxsIHRvIHRoZSBzdGFjayBhbGwgdGhlIHRp
bWUuDQo+ID4NCj4gPiBUaGUgcmV1c2VfcG9ydCBjb2RlIG1hZGUgaXQgYSB3aG9sZSBsb3Qgd29y
c2UuDQo+ID4NCj4gDQo+IE1heWJlIC4uLiBQbGVhc2Ugc2hvdyB1cyBwZXJmb3JtYW5jZSBudW1i
ZXJzLg0KPiANCj4gSWYgbGVzcyB0aGFuIDElLCBJIHdvdWxkIG5vdCBib3RoZXIgY2hhbmdpbmcg
dGhpcyBjb2RlLCBtYWtpbmcgZnV0dXJlDQo+IGJhY2twb3J0cyBtb3JlIHJpc2t5Lg0KDQpJIGRp
ZG4ndCA6LSkNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


