Return-Path: <netdev+bounces-35753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE227AAF00
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 8B6A91F22818
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2201EA6E;
	Fri, 22 Sep 2023 09:59:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7B1E521
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:59:52 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7E991
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 02:59:50 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-313-fUFdf40GNxaBHAO9Ywxcgg-1; Fri, 22 Sep 2023 10:59:42 +0100
X-MC-Unique: fUFdf40GNxaBHAO9Ywxcgg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 22 Sep
 2023 10:59:41 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 22 Sep 2023 10:59:41 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>, David Ahern <dsahern@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Soheil Hassas Yeganeh
	<soheil@google.com>, Neal Cardwell <ncardwell@google.com>, Yuchung Cheng
	<ycheng@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>
Subject: RE: [PATCH net-next 3/3] tcp: derive delack_max from rto_min
Thread-Topic: [PATCH net-next 3/3] tcp: derive delack_max from rto_min
Thread-Index: AQHZ7Lj4DlupxmlNYUWAxF0PuC9GrrAmnCSw
Date: Fri, 22 Sep 2023 09:59:41 +0000
Message-ID: <26be5679fdae405f9a932bfc3f28c203@AcuMS.aculab.com>
References: <20230920172943.4135513-1-edumazet@google.com>
 <20230920172943.4135513-4-edumazet@google.com>
 <89a3cbd7-fd82-d925-b916-e323033ffdbe@kernel.org>
 <CANn89i+-3saYRN9YUuujYnW8PvmkyUTHmRDX3bUXdbYoGfo=iA@mail.gmail.com>
 <e4aeef69-9656-d291-82a3-a86367210a81@kernel.org>
 <CANn89i+bXkgHWSgkqYToAGofE4qdJC142MmSR4eV2uD4408nVA@mail.gmail.com>
In-Reply-To: <CANn89i+bXkgHWSgkqYToAGofE4qdJC142MmSR4eV2uD4408nVA@mail.gmail.com>
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

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDIxIFNlcHRlbWJlciAyMDIzIDEzOjU4DQo+IA0K
PiBPbiBUaHUsIFNlcCAyMSwgMjAyMyBhdCAyOjM34oCvUE0gRGF2aWQgQWhlcm4gPGRzYWhlcm5A
a2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gDQo+ID4gTXkgY29tbWVudCBpcyBzb2xlbHkgYWJv
dXQgbWlzbWF0Y2ggb24gZGF0YSB0eXBlcy4gSSBhbSBzdXJwcmlzZWQgdXNlIG9mDQo+ID4gbWF4
X3Qgd2l0aCBtaXhlZCBkYXRhIHR5cGVzIGRvZXMgbm90IHRocm93IGEgY29tcGlsZXIgd2Fybmlu
Zy4NCj4gDQo+IFRoaXMgd2FzIGludGVudGlvbmFsLg0KPiANCj4gVGhpcyBpcyBtYXhfdCgpIHB1
cnBvc2UgcmVhbGx5Lg0KDQpBcGFydCBmcm9tIHdoZW4gaXQgZ2V0cyB1c2VkIHRvIGFjY2lkZW50
YWxseSBtYXNrIGhpZ2ggYml0cyA6LSkNCihBbHRob3VnaCBoYXQgaXMgdXN1YWxseSBjb25zaWdu
ZWQgdG8gbWluX3QoKSkuDQoNCkhlcmUNCgl1MzIgZGVsYWNrX2Zyb21fcnRvX21pbiA9IG1heChy
dG9fbWluLCAydSkgLSAxOw0Kd291bGQgcHJvYmFibHkgYmUgc2FmZXIgKGFzIGluIGhhdmUgbm8g
Y2FzdHMgdGhhdCBtaWdodCBoYXZlDQp1bndhbnRlZCBzaWRlIGVmZmVjdHMpLg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K


