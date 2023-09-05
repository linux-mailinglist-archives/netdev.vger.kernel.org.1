Return-Path: <netdev+bounces-32085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68747922C2
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 14:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84DE1C209A1
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 12:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF97D309;
	Tue,  5 Sep 2023 12:45:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD0D2FAE
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 12:45:04 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65781A8
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 05:45:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-306-nbhshI07N3SfbsUKBtrYwQ-1; Tue, 05 Sep 2023 13:45:00 +0100
X-MC-Unique: nbhshI07N3SfbsUKBtrYwQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Sep
 2023 13:44:56 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 5 Sep 2023 13:44:56 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>
CC: Kyle Zeng <zengyhkyle@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, syzbot
	<syzkaller@googlegroups.com>, Kees Cook <keescook@chromium.org>, "Vlastimil
 Babka" <vbabka@suse.cz>
Subject: RE: [PATCH net] net: deal with integer overflows in kmalloc_reserve()
Thread-Topic: [PATCH net] net: deal with integer overflows in
 kmalloc_reserve()
Thread-Index: AQHZ3DpDqBe85QJ3kk2CYjFaBCIaHrAKXmHw///2hoCAABTPMIABM6qtgABQ1+CAAEPtEYAAAlTg
Date: Tue, 5 Sep 2023 12:44:56 +0000
Message-ID: <9b5aa733ab86401c966092e1e5567e65@AcuMS.aculab.com>
References: <20230831183750.2952307-1-edumazet@google.com>
 <d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com>
 <CANn89iJY4=Q0edL-mf2JrRiz8Ld7bQcogOrc4ozLEVD8qz8o2A@mail.gmail.com>
 <837a03d12d8345bfa7e9874c1e7d9156@AcuMS.aculab.com>
 <ZPZtBWm06f321Tp/@westworld>
 <CANn89iJDsm-xE4K2_BWngOQeuhOFmOhwVfk5=sszf0E+3UcH=g@mail.gmail.com>
 <0669d0d3fefb44aaa3f8021872751693@AcuMS.aculab.com>
 <CANn89iJtwNuLA2=dY-ZgLVtUrjt-K3K2gNv9XSt5Hyd2tV6+eQ@mail.gmail.com>
 <CANn89iKL9-3RTBhtyg5gxOLfXZVyJoCK0A_K9ui5Ew-KdNtFhw@mail.gmail.com>
In-Reply-To: <CANn89iKL9-3RTBhtyg5gxOLfXZVyJoCK0A_K9ui5Ew-KdNtFhw@mail.gmail.com>
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

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDA1IFNlcHRlbWJlciAyMDIzIDEzOjM0DQo+IA0K
PiBPbiBUdWUsIFNlcCA1LCAyMDIzIGF0IDI6MjfigK9QTSBFcmljIER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVHVlLCBTZXAgNSwgMjAyMyBhdCAxMDoz
NuKAr0FNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+
ID4NCj4gPiA+IEZyb206IEVyaWMgRHVtYXpldA0KPiA+ID4gPiBTZW50OiAwNSBTZXB0ZW1iZXIg
MjAyMyAwNDo0Mg0KPiA+ID4gLi4uDQo+ID4gPiA+IEFnYWluLCBJIGRvIG5vdCB3YW50IHRoaXMg
cGF0Y2gsIEkgd2FudCB0byBmaXggdGhlIHJvb3QgY2F1c2UocykuDQo+ID4gPiA+DQo+ID4gPiA+
IEl0IG1ha2VzIG5vIHNlbnNlIHRvIGFsbG93IGRldi0+bXR1IHRvIGJlIGFzIGJpZyBhcyAweDdm
ZmZmZmZmIGFuZA0KPiA+ID4gPiB1bHRpbWF0ZWx5IGFsbG93IHNpemUgdG8gYmUgYmlnZ2VyIHRo
YW4gMHg4MDAwMDAwMA0KPiA+ID4NCj4gPiA+IGttZW1fYWxsb2NfcmVzZXJ2ZSgpIGFsc28gbmVl
ZHMgZml4aW5nLg0KPiA+DQo+ID4gWWVzLCB0aGlzIGlzIHdoYXQgSSBzYWlkLiBQbGVhc2UgcHJv
dmlkZSBhIHBhdGNoID8NCj4gDQo+IE9vcHMsIEkgdGhvdWdodCB5b3Ugd2VyZSBzcGVha2luZyBh
Ym91dCBrbWFsbG9jX3NpemVfcm91bmR1cCgpDQo+IA0KPiBrbWFsbG9jX3Jlc2VydmUoKSBpcyBm
aW5lLCBhbGwgb3ZlcmZsb3dzIG11c3QgYmUgdGFrZW4gY2FyZSBvZiBiZWZvcmUNCj4gcmVhY2hp
bmcgaXQuDQoNCkkgd2FzIHRhbGtpbmcgYWJvdXQgcm91bmR1cCgpDQoNCkknbSBpbiBhbGwgdGhl
IHdyb25nIHBsYWNlIHRvIGdlbmVyYXRlIGEgcGF0Y2guDQpBbmQgaGF2aW5nIHRvIHNlbmQgdGhl
IGVtYWlscyBmcm9tIHdpbmRvd3MgbWFrZXMgdGhlIHByb2NlZHVyZSBhDQpyaWdodCBQSVRBLg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K


