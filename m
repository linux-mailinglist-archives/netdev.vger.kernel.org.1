Return-Path: <netdev+bounces-31892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF17913AB
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 10:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0627280E60
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 08:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EEC818;
	Mon,  4 Sep 2023 08:41:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899EC7E
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 08:41:16 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CBF126
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 01:41:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-146-e3PXNoDzPbGGH4Tbo7cimQ-1; Mon, 04 Sep 2023 09:41:12 +0100
X-MC-Unique: e3PXNoDzPbGGH4Tbo7cimQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Sep
 2023 09:41:01 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 4 Sep 2023 09:41:01 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, syzbot
	<syzkaller@googlegroups.com>, Kyle Zeng <zengyhkyle@gmail.com>, Kees Cook
	<keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: RE: [PATCH net] net: deal with integer overflows in kmalloc_reserve()
Thread-Topic: [PATCH net] net: deal with integer overflows in
 kmalloc_reserve()
Thread-Index: AQHZ3DpDqBe85QJ3kk2CYjFaBCIaHrAKXmHw
Date: Mon, 4 Sep 2023 08:41:01 +0000
Message-ID: <d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com>
References: <20230831183750.2952307-1-edumazet@google.com>
In-Reply-To: <20230831183750.2952307-1-edumazet@google.com>
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

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDMxIEF1Z3VzdCAyMDIzIDE5OjM4DQo+IA0KPiBC
bGFtZWQgY29tbWl0IGNoYW5nZWQ6DQo+ICAgICBwdHIgPSBrbWFsbG9jKHNpemUpOw0KPiAgICAg
aWYgKHB0cikNCj4gICAgICAgc2l6ZSA9IGtzaXplKHB0cik7DQo+IA0KPiB0bzoNCj4gICAgIHNp
emUgPSBrbWFsbG9jX3NpemVfcm91bmR1cChzaXplKTsNCj4gICAgIHB0ciA9IGttYWxsb2Moc2l6
ZSk7DQo+IA0KPiBUaGlzIGFsbG93ZWQgdmFyaW91cyBjcmFzaCBhcyByZXBvcnRlZCBieSBzeXpi
b3QgWzFdDQo+IGFuZCBLeWxlIFplbmcuDQo+IA0KPiBQcm9ibGVtIGlzIHRoYXQgaWYgQHNpemUg
aXMgYmlnZ2VyIHRoYW4gMHg4MDAwMDAwMSwNCj4ga21hbGxvY19zaXplX3JvdW5kdXAoc2l6ZSkg
cmV0dXJucyAyXjMyLg0KPiANCj4ga21hbGxvY19yZXNlcnZlKCkgdXNlcyBhIDMyYml0IHZhcmlh
YmxlIChvYmpfc2l6ZSksDQo+IHNvIDJeMzIgaXMgdHJ1bmNhdGVkIHRvIDAuDQoNCkNhbiB0aGlz
IGhhcHBlbiBvbiAzMmJpdCBhcmNoPw0KSW4gdGhhdCBjYXNlIGttYWxsb2Nfc2l6ZV9yb3VuZHVw
KCkgd2lsbCByZXR1cm4gMC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


