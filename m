Return-Path: <netdev+bounces-35860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97E27AB67A
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 18:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7526D282140
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED05B41742;
	Fri, 22 Sep 2023 16:51:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E33CD0D
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 16:51:20 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2879A1
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:51:17 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-256-goU_KTbZNaKGBUaqwCog2w-1; Fri, 22 Sep 2023 17:51:10 +0100
X-MC-Unique: goU_KTbZNaKGBUaqwCog2w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 22 Sep
 2023 17:51:08 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 22 Sep 2023 17:51:08 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>
CC: David Ahern <dsahern@kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell
	<ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eric.dumazet@gmail.com"
	<eric.dumazet@gmail.com>
Subject: RE: [PATCH net-next 3/3] tcp: derive delack_max from rto_min
Thread-Topic: [PATCH net-next 3/3] tcp: derive delack_max from rto_min
Thread-Index: AQHZ7Lj4DlupxmlNYUWAxF0PuC9GrrAmnCSw////pYCAAG6I0A==
Date: Fri, 22 Sep 2023 16:51:08 +0000
Message-ID: <19f0c2696eb4419cad21e20fe6d54bcb@AcuMS.aculab.com>
References: <20230920172943.4135513-1-edumazet@google.com>
 <20230920172943.4135513-4-edumazet@google.com>
 <89a3cbd7-fd82-d925-b916-e323033ffdbe@kernel.org>
 <CANn89i+-3saYRN9YUuujYnW8PvmkyUTHmRDX3bUXdbYoGfo=iA@mail.gmail.com>
 <e4aeef69-9656-d291-82a3-a86367210a81@kernel.org>
 <CANn89i+bXkgHWSgkqYToAGofE4qdJC142MmSR4eV2uD4408nVA@mail.gmail.com>
 <26be5679fdae405f9a932bfc3f28c203@AcuMS.aculab.com>
 <CANn89iK_sMY1=OOqJ_XPuumJFBGesw964EJY1JbU9oGRUH1c0g@mail.gmail.com>
In-Reply-To: <CANn89iK_sMY1=OOqJ_XPuumJFBGesw964EJY1JbU9oGRUH1c0g@mail.gmail.com>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDIyIFNlcHRlbWJlciAyMDIzIDExOjUzDQo+IA0K
PiBPbiBGcmksIFNlcCAyMiwgMjAyMyBhdCAxMTo1OeKAr0FNIERhdmlkIExhaWdodCA8RGF2aWQu
TGFpZ2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogRXJpYyBEdW1hemV0DQo+
ID4gPiBTZW50OiAyMSBTZXB0ZW1iZXIgMjAyMyAxMzo1OA0KPiA+ID4NCj4gPiA+IE9uIFRodSwg
U2VwIDIxLCAyMDIzIGF0IDI6MzfigK9QTSBEYXZpZCBBaGVybiA8ZHNhaGVybkBrZXJuZWwub3Jn
PiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiA+IE15IGNvbW1lbnQgaXMgc29sZWx5IGFi
b3V0IG1pc21hdGNoIG9uIGRhdGEgdHlwZXMuIEkgYW0gc3VycHJpc2VkIHVzZSBvZg0KPiA+ID4g
PiBtYXhfdCB3aXRoIG1peGVkIGRhdGEgdHlwZXMgZG9lcyBub3QgdGhyb3cgYSBjb21waWxlciB3
YXJuaW5nLg0KPiA+ID4NCj4gPiA+IFRoaXMgd2FzIGludGVudGlvbmFsLg0KPiA+ID4NCj4gPiA+
IFRoaXMgaXMgbWF4X3QoKSBwdXJwb3NlIHJlYWxseS4NCj4gPg0KPiA+IEFwYXJ0IGZyb20gd2hl
biBpdCBnZXRzIHVzZWQgdG8gYWNjaWRlbnRhbGx5IG1hc2sgaGlnaCBiaXRzIDotKQ0KPiA+IChB
bHRob3VnaCBoYXQgaXMgdXN1YWxseSBjb25zaWduZWQgdG8gbWluX3QoKSkuDQo+IA0KPiBBcyBl
eHBsYWluZWQsIHRoaXMgaXMgbm90IGFuIGFjY2lkZW50LCBidXQgYSBjb25zY2lvdXMgZGVjaXNp
b24gSSBtYWRlLg0KPiANCj4gPg0KPiA+IEhlcmUNCj4gPiAgICAgICAgIHUzMiBkZWxhY2tfZnJv
bV9ydG9fbWluID0gbWF4KHJ0b19taW4sIDJ1KSAtIDE7DQo+ID4gd291bGQgcHJvYmFibHkgYmUg
c2FmZXIgKGFzIGluIGhhdmUgbm8gY2FzdHMgdGhhdCBtaWdodCBoYXZlDQo+ID4gdW53YW50ZWQg
c2lkZSBlZmZlY3RzKS4NCj4gPg0KPiANCj4gSSBmaW5kIG15IHNvbHV0aW9uIG1vcmUgcmVhZGFi
bGUuDQoNCkl0IGhhcyB0byBiZSBzYWlkIEkgZGlkbid0IHJlYWxseSBsaWtlIG1pbmUgZWl0aGVy
IDotKQ0KQSBiZXR0ZXIgYWx0ZXJuYXRpdmUgd291bGQgYmU6DQoJbWF4KChpbnQpcnRvX21pbiAt
IDEsIDEpDQp0byBtYWtlIGl0IGFic29sdXRlbHkgY2xlYXIgd2hhdCBpcyBnb2luZyBvbi4NCg0K
RmFyIHRvbyBtYW55IG9mIHRoZSBtaW5fdCgpIGFuZCBtYXhfdCgpIGFyZSBqdXN0IHVzZWQgdG8g
c2lsZW5jZQ0KdGhlIG92ZXItZW50aHVzaWFzdGljIHR5cGUgY2hlY2tpbmcgb2YgbWluKCkgYW5k
IG1heCgpLg0KU28gY29kZSBkb2luZyBzb21ldGhpbmcgZGlmZmVyZW50IG1pZ2h0IGJlIGJlc3Qg
bWFraW5nIGl0IG1vcmUgb2J2aW91cy4NCg0KRG9lcyAnaXAgcm91dGUnIHN0b3AgdmVyeSBsYXJn
ZSB2YWx1ZXMgZm9yIHJ0b19taW4/DQpVbnNpZ25lZCB2YWx1ZXMgd2l0aCB0aGUgdG9wIGJpdCBz
ZXQgbWlnaHQgY2F1c2UgJ2ludGVyZXN0aW5nJyBiZWhhdmlvdXIhDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=


