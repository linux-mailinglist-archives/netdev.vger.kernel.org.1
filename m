Return-Path: <netdev+bounces-21403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB840763844
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1822A1C21269
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADEC21D33;
	Wed, 26 Jul 2023 14:02:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF270A927
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:02:48 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F672706
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:02:37 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-315-Lgw7yM95Px20x9RNkzwNfg-1; Wed, 26 Jul 2023 15:02:34 +0100
X-MC-Unique: Lgw7yM95Px20x9RNkzwNfg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 26 Jul
 2023 15:02:33 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 26 Jul 2023 15:02:33 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Paolo Abeni' <pabeni@redhat.com>, "'willemdebruijn.kernel@gmail.com'"
	<willemdebruijn.kernel@gmail.com>, "'davem@davemloft.net'"
	<davem@davemloft.net>, "'dsahern@kernel.org'" <dsahern@kernel.org>, "'Eric
 Dumazet'" <edumazet@google.com>, "'kuba@kernel.org'" <kuba@kernel.org>,
	"'netdev@vger.kernel.org'" <netdev@vger.kernel.org>
Subject: RE: [PATCH 1/2] Move hash calculation inside udp4_lib_lookup2()
Thread-Topic: [PATCH 1/2] Move hash calculation inside udp4_lib_lookup2()
Thread-Index: Adm/uWROjgkE4udKTdiQAS8haeW/0gABYaaAAAIc9cA=
Date: Wed, 26 Jul 2023 14:02:33 +0000
Message-ID: <4deda035df8142a6977ce844eb705bdb@AcuMS.aculab.com>
References: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com>
	 <5eb8631d430248999116ce8ced13e4b2@AcuMS.aculab.com>
 <fce08e76da7e3882319ae935c38e9e2eccf2dcae.camel@redhat.com>
In-Reply-To: <fce08e76da7e3882319ae935c38e9e2eccf2dcae.camel@redhat.com>
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

RnJvbTogUGFvbG8gQWJlbmkNCj4gU2VudDogMjYgSnVseSAyMDIzIDE0OjQ0DQo+IA0KPiBPbiBX
ZWQsIDIwMjMtMDctMjYgYXQgMTI6MDUgKzAwMDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBQ
YXNzIHRoZSB1ZHB0YWJsZSBhZGRyZXNzIGludG8gdWRwNF9saWJfbG9va3VwMigpIGluc3RlYWQg
b2YgdGhlIGhhc2ggc2xvdC4NCj4gPg0KPiA+IFdoaWxlIGlwdjRfcG9ydGFkZHJfaGFzaChuZXQs
IElQX0FERFJfQU5ZLCAwKSBpcyBjb25zdGFudCBmb3IgZWFjaCBuZXQNCj4gPiAodGhlIHBvcnQg
aXMgYW4geG9yKSB0aGUgdmFsdWUgaXNuJ3Qgc2F2ZWQuDQo+ID4gU2luY2UgdGhlIGhhc2ggZnVu
Y3Rpb24gZG9lc24ndCBnZXQgc2ltcGxpZmllZCB3aGVuIHBhc3NlZCB6ZXJvIHRoZSBoYXNoDQo+
IA0KPiBBcmUgeW91IHN1cmU/IGNvdWxkIHlvdSBwbGVhc2Ugb2JqZHVtcCBhbmQgY29tcGFyZSB0
aGUgYmluYXJ5IGNvZGUNCj4gZ2VuZXJhdGVkIGJlZm9yZSBhbmQgYWZ0ZXIgdGhlIHBhdGNoPyBJ
biB0aGVvcnkgYWxsIHRoZSBjYWxsZXJzIHVwIHRvDQo+IF9famhhc2hfZmluYWwoKSBpbmNsdWRl
ZCBzaG91bGQgYmUgaW5saW5lZCwgYW5kIHRoZSBjb21waWxlciBzaG91bGQgYmUNCj4gYWJsZSB0
byBvcHRpbXplIGF0IGxlYXN0IHJvbDMyKDAsIDxuPikuDQoNCkkgbG9va2VkIHRoZSBoYXNoIGlz
IDIwKyBpbnN0cnVjdGlvbnMgYW5kIHByZXR0eSBtdWNoIGFsbCBvZg0KdGhlbSBhcHBlYXJlZCB0
d2ljZS4NCihJJ20gaW4gdGhlIHdyb25nIGJ1aWxkaW5nIHRvIGhhdmUgYSBidWlsZGFibGUga2Vy
bmVsIHRyZWUuKQ0KDQpJdCBoYXMgdG8gYmUgc2FpZCB0aGF0IGlwdjRfcG9ydGFkZHJfaGFzaChu
ZXQsIElQQUREUl9BTlksIHBvcnQpDQpjb3VsZCBqdXN0IGJlIG5ldF9oYXNoX21peChuZXQpIF4g
cG9ydC4NCihPciBtYXliZSB5b3UgY291bGQgdXNlIGEgZGlmZmVyZW50IHJhbmRvbSB2YWx1ZS4p
DQoNCkknbSBub3QgZXZlbiBzdXJlIHRoZSByZWxhdGl2ZWx5IGV4cGVuc2l2ZSBtaXhpbmcgb2Yg
J3NhZGRyJw0KaXMgbmVlZGVkIC0gaXQgaXMgb25lIG9mIHRoZSBsb2NhbCBJUHY0IGFkZHJlc3Nl
cy4NCk1peGluZyBpbiB0aGUgcmVtb3RlIGFkZHJlc3MgZm9yIGNvbm5lY3RlZCBzb2NrZXRzIG1p
Z2h0DQpiZSB1c2VmdWwgZm9yIGFueSBzZXJ2ZXIgY29kZSB0aGF0IHVzZXMgYSBsb3Qgb2YgY29u
bmVjdGVkDQp1ZHAgc29ja2V0cyAtIGJ1dCB0aGF0IGlzbid0IGRvbmUuDQoNCldlIHdpbGwgaGF2
ZSBodW5kcmVkcyBvZiB1ZHAgc29ja2V0cyB3aXRoIGRpZmZlcmVudCBwb3J0cyB0aGF0DQphcmUg
bm90IGNvbm5lY3RlZCAoSSBkb24ndCBrbm93IGlmIHRoZXkgZ2V0IGJvdW5kIHRvIGEgbG9jYWwN
CmFkZHJlc3MpLiBTbyBhIHJlbW90ZSBhZGRyZXNzIGhhc2ggd291bGRuJ3QgaGVscC4NCg0KSWYg
eW91IGxvb2sgYXQgdGhlIGdlbmVyYXRlZCBjb2RlIGZvciBfX3VkcDRfbGliX2xvb2t1cCgpDQpp
dCBpcyBhY3R1YWxseSBxdWl0ZSBob3JyaWQuDQpUb28gbWFueSBjYWxsZWQgZnVuY3Rpb25zIHdp
dGggdG9vIG1hbnkgcGFyYW1ldGVycy4NClRoaW5ncyBzcGlsbCB0byB0aGUgc3RhY2sgYWxsIHRo
ZSB0aW1lLg0KDQpUaGUgcmV1c2VfcG9ydCBjb2RlIG1hZGUgaXQgYSB3aG9sZSBsb3Qgd29yc2Uu
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=


