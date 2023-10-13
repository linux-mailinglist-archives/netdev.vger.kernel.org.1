Return-Path: <netdev+bounces-40625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D053C7C8030
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 10:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3935F282AD2
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 08:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3954A107B8;
	Fri, 13 Oct 2023 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC3107AD
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:27:09 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C818E8
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 01:27:04 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-98-JBVSnzIeMf2mnzX9rNhn3g-1; Fri, 13 Oct 2023 09:27:01 +0100
X-MC-Unique: JBVSnzIeMf2mnzX9rNhn3g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 13 Oct
 2023 09:27:00 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 13 Oct 2023 09:27:00 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nicholas Piggin' <npiggin@gmail.com>, Aaron Conole <aconole@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dev@openvswitch.org"
	<dev@openvswitch.org>, Pravin B Shelar <pshelar@ovn.org>, Eelco Chaudron
	<echaudro@redhat.com>, Ilya Maximets <imaximet@redhat.com>, Flavio Leitner
	<fbl@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>
Subject: RE: [PATCH 0/7] net: openvswitch: Reduce stack usage
Thread-Topic: [PATCH 0/7] net: openvswitch: Reduce stack usage
Thread-Index: AQHZ/Koxu5HRuOq5lkWzn3IeIo3GabBHYm7Q
Date: Fri, 13 Oct 2023 08:27:00 +0000
Message-ID: <ff6cd12e28894f158d9a6c9f7157487f@AcuMS.aculab.com>
References: <20231011034344.104398-1-npiggin@gmail.com>
 <f7ta5spe1ix.fsf@redhat.com> <CW62DEF1LEWB.3KK4CQJNGIRYO@wheely>
In-Reply-To: <CW62DEF1LEWB.3KK4CQJNGIRYO@wheely>
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

RnJvbTogTmljaG9sYXMgUGlnZ2luDQo+IFNlbnQ6IDEyIE9jdG9iZXIgMjAyMyAwMjoxOQ0KLi4u
DQo+IEl0IGlzIGEga2VybmVsIGNyYXNoLCBzbyB3ZSBuZWVkIHNvbWV0aGluZyBmb3Igc3RhYmxl
LiBCdXQgSW4gYSBjYXNlDQo+IGxpa2UgdGhpcyB0aGVyZSdzIG5vdCBvbmUgc2luZ2xlIHByb2Js
ZW0uIExpbnV4IGtlcm5lbCBzdGFjayB1c2UgaGFzDQo+IGFsd2F5cyBiZWVuIHByZXR0eSBkdW1i
IC0gImRvbid0IHVzZSB0b28gbXVjaCIsIGZvciBzb21lIHZhbHVlcyBvZg0KPiB0b28gbXVjaCwg
YW5kIGp1c3QgY3Jvc3MgZmluZ2VycyBjb25maWcgYW5kIGNvbXBpbGVyIGFuZCB3b3Jsa29hZA0K
PiBkb2Vzbid0IGhpdCBzb21lIG92ZXJmbG93IGNhc2UuDQoNCkkgdGhpbmsgaXQgb3VnaHQgdG8g
YmUgcG9zc2libGUgdG8gdXNlIGEgRklORV9JQlQgKEkgdGhpbmsgdGhhdA0KaXMgd2hhdCBpdCBp
cyBjYWxsZWQpIGNvbXBpbGUgdG8gZ2V0IGluZGlyZWN0IGNhbGxzIGdyb3VwZWQNCmFuZCBjaGFu
Z2Ugb2JqdG9vbCB0byBvdXRwdXQgdGhlIHN0YWNrIG9mZnNldCBvZiBldmVyeSBjYWxsLg0KSXQg
aXMgdGhlbiBhIHNpbXBsZSAoZm9yIHNvbWUgZGVmaW5pdGlvbiBvZiBzaW1wbGUpIHByb2Nlc3MN
CnRvIHdvcmsgb3V0IHRoZSBzdGF0aWMgbWF4aW11bSBzdGFjayB1c2FnZS4NCg0KQW55IHJlY3Vy
c2lvbiBjYXVzZXMgZ3JpZWYgKHRoZSBzdGFjayBkZXB0aCBmb3IgZWFjaA0KbG9vcCBjYW4gYmUg
cmVwb3J0ZWQpLg0KDQpBbHNvIEkgc3VzcGVjdCB0aGUgY29tcGlsZXIgd2lsbCBuZWVkIGFuIGVu
aGFuY2VtZW50IHRvDQphZGQgYSBjb25zdGFudCBpbnRvIHRoZSBoYXNoIHRvIGRpc2FtYmlndWF0
ZSBpbmRpcmVjdA0KY2FsbHMgd2l0aCB0aGUgc2FtZSBhcmd1bWVudCBsaXN0Lg0KDQpNeSBzdXNw
aWNpb24gKGZyb20gZG9pbmcgdGhpcyBleGVyY2lzZSBvbiBhbiBlbWJlZGRlZCBzeXN0ZW0NCmEg
bG9uZyB0aW1lIGFnbykgaXMgdGhhdCB0aGUgc3RhY2sgd2lsbCBiZSBibG93biBzb21ld2hlcmUN
Cmluc2lkZSBwcmludGsoKSBpbiBzb21lIGVycm9yIHBhdGguDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


