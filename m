Return-Path: <netdev+bounces-32012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB722792107
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 10:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E58281049
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7EE1C2D;
	Tue,  5 Sep 2023 08:36:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053BA38
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 08:36:11 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE7CCC7
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 01:36:06 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-25-F_yjfLRlOpar-NpGCuySQg-1; Tue, 05 Sep 2023 09:36:03 +0100
X-MC-Unique: F_yjfLRlOpar-NpGCuySQg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Sep
 2023 09:36:00 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 5 Sep 2023 09:36:00 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>, Kyle Zeng <zengyhkyle@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
	syzbot <syzkaller@googlegroups.com>, Kees Cook <keescook@chromium.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: RE: [PATCH net] net: deal with integer overflows in kmalloc_reserve()
Thread-Topic: [PATCH net] net: deal with integer overflows in
 kmalloc_reserve()
Thread-Index: AQHZ3DpDqBe85QJ3kk2CYjFaBCIaHrAKXmHw///2hoCAABTPMIABM6qtgABQ1+A=
Date: Tue, 5 Sep 2023 08:36:00 +0000
Message-ID: <0669d0d3fefb44aaa3f8021872751693@AcuMS.aculab.com>
References: <20230831183750.2952307-1-edumazet@google.com>
 <d273628df80f45428e739274ab9ecb72@AcuMS.aculab.com>
 <CANn89iJY4=Q0edL-mf2JrRiz8Ld7bQcogOrc4ozLEVD8qz8o2A@mail.gmail.com>
 <837a03d12d8345bfa7e9874c1e7d9156@AcuMS.aculab.com>
 <ZPZtBWm06f321Tp/@westworld>
 <CANn89iJDsm-xE4K2_BWngOQeuhOFmOhwVfk5=sszf0E+3UcH=g@mail.gmail.com>
In-Reply-To: <CANn89iJDsm-xE4K2_BWngOQeuhOFmOhwVfk5=sszf0E+3UcH=g@mail.gmail.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDA1IFNlcHRlbWJlciAyMDIzIDA0OjQyDQouLi4N
Cj4gQWdhaW4sIEkgZG8gbm90IHdhbnQgdGhpcyBwYXRjaCwgSSB3YW50IHRvIGZpeCB0aGUgcm9v
dCBjYXVzZShzKS4NCj4gDQo+IEl0IG1ha2VzIG5vIHNlbnNlIHRvIGFsbG93IGRldi0+bXR1IHRv
IGJlIGFzIGJpZyBhcyAweDdmZmZmZmZmIGFuZA0KPiB1bHRpbWF0ZWx5IGFsbG93IHNpemUgdG8g
YmUgYmlnZ2VyIHRoYW4gMHg4MDAwMDAwMA0KDQprbWVtX2FsbG9jX3Jlc2VydmUoKSBhbHNvIG5l
ZWRzIGZpeGluZy4NCkl0J3MgcHVycG9zZSBpcyB0byBmaW5kIHRoZSBzaXplIHRoYXQga21lbV9h
bGxvYygpIHdpbGwNCmFsbG9jYXRlZCBzbyB0aGF0IHRoZSBmdWxsIHNpemUgY2FuIGJlIGFsbG9j
YXRlZCByYXRoZXINCnRoYW4gbGF0ZXIgZmluZGluZyBvdXQgdGhlIGFsbG9jYXRlZCBzaXplLg0K
VGhlIGxhdHRlciBoYXMgaXNzdWVzIHdpdGggdGhlIGNvbXBpbGVyIChldGMpIHRyYWNraW5nDQp0
aGUgc2l6ZXMgb2YgYWxsb2NhdGVzLg0KDQpTbyBpdCBtdXN0IG5ldmVyIHJldHVybiBhIHNtYWxs
ZXIgc2l6ZS4NCldoZXRoZXIgdGhlIHBhdGggdGhhdCByZXR1cm5zIDAgY2FuIGhhcHBlbiBvciBu
b3QNCnRoZSBjb3JyZWN0IGVycm9yIHJldHVybiBpcyB0aGUgb3JpZ2luYWwgc2l6ZS4NClRoZSBs
YXRlciBrbWFsbG9jKCkgd2lsbCB0aGVuIHByb2JhYmx5IGZhaWwgYW5kDQpiZSBjaGVja2VkIGZv
ci4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


