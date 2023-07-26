Return-Path: <netdev+bounces-21429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDD276395B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB166281F42
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3101DA2E;
	Wed, 26 Jul 2023 14:39:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A51DA24
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:39:14 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F181990
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:39:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-247-jAUwimivOcOwYhs8uuszxg-1; Wed, 26 Jul 2023 15:39:08 +0100
X-MC-Unique: jAUwimivOcOwYhs8uuszxg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 26 Jul
 2023 15:39:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 26 Jul 2023 15:39:07 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>
CC: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH 2/2] Rescan the hash2 list if the hash chains have got
 cross-linked.
Thread-Topic: [PATCH 2/2] Rescan the hash2 list if the hash chains have got
 cross-linked.
Thread-Index: Adm/uYXsrlBDnyZsQsqXScrMcg4DhwABF66AAAI2u7D///q6AP//7Ymg
Date: Wed, 26 Jul 2023 14:39:07 +0000
Message-ID: <badeae889d4743fb8eb99b85d69b714a@AcuMS.aculab.com>
References: <fbcaa54791cd44999de5fec7c6cf0b3c@AcuMS.aculab.com>
 <c45337a3d46641dc8c4c66bd49fb55b6@AcuMS.aculab.com>
 <CANn89iKTC29of9bkVKWcLv0W27JFvkub7fuBMeK_J3a3Q-B1Cg@mail.gmail.com>
 <fc241086b32944ecae4f467cb5b0c6c7@AcuMS.aculab.com>
 <CANn89iLRDpAmaJVYCf+-F7mTTVkxSJMKfxZ+QhB8ATzYEi4X8g@mail.gmail.com>
In-Reply-To: <CANn89iLRDpAmaJVYCf+-F7mTTVkxSJMKfxZ+QhB8ATzYEi4X8g@mail.gmail.com>
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

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDI2IEp1bHkgMjAyMyAxNToyMg0KLi4uDQo+IENh
biB5b3UgZGVzY3JpYmUgd2hhdCB1c2VyIHNwYWNlIG9wZXJhdGlvbiBpcyBkb25lIGJ5IHlvdXIg
cHJlY2lvdXMgYXBwbGljYXRpb24sDQo+IHRyaWdnZXJpbmcgYSByZWhhc2ggaW4gdGhlIGZpcnN0
IHBsYWNlID8NCg0KV2UndmUgbm8gaWRlYSB3aGF0IGlzIGNhdXNpbmcgdGhlIHJlaGFzaC4NClRo
ZXJlIGFyZSBhIGxvdCBvZiBzb2NrZXRzIHRoYXQgYXJlIHJlY2VpdmluZyBSVFAgYXVkaW8uDQpC
dXQgdGhleSBhcmUgb25seSBjcmVhdGVkLCBib3VuZCBhbmQgdGhlbiBkZWxldGVkLg0KDQpUaGUg
J2Jlc3QgZ3Vlc3MnIGlzIHNvbWV0aGluZyB0byBkbyB3aXRoIGlwc2VjIHR1bm5lbHMNCmJlaW5n
IGNyZWF0ZWQsIGRlbGV0ZWQgb3IgcmVoYXNoZWQuDQoNCj4gDQo+IE1heWJlIHdlIGNhbiB0aGlu
ayBvZiBzb21ldGhpbmcgbGVzcyBkaXNydXB0aXZlIGluIHRoZSBrZXJuZWwuDQo+IChGb3IgaW5z
dGFuY2UsIHlvdSBjb3VsZCBoYXZlIGEgc2Vjb25kIHNvY2tldCwgaW5zZXJ0IGl0IGluIHRoZSBu
ZXcgYnVja2V0LA0KPiB0aGVuIHJlbW92ZSB0aGUgb2xkIHNvY2tldCkNCj4gDQo+ID4gVGhlIHBy
b2JsZW0gaXMgdGhhdCBhIHNpbmdsZSAncG9ydCB1bnJlYWNoYWJsZScgY2FuIGJlIHRyZWF0ZWQN
Cj4gPiBhcyBhIGZhdGFsIGVycm9yIGJ5IHRoZSByZWNlaXZpbmcgYXBwbGljYXRpb24uDQo+ID4g
U28geW91IHJlYWxseSBkb24ndCB3YW50IHRvIGJlIHNlbmRpbmcgdGhlbS4NCj4gDQo+IFdlbGws
IGlmIHlvdXIgYXBwbGljYXRpb24gbmVlZHMgdG8gcnVuIHdpdGggb2xkIGtlcm5lbHMsIGFuZCBv
cg0KPiB0cmFuc2llbnQgbmV0ZmlsdGVyIGNoYW5nZXMgKHNvbWUgZmlyZXdhbGwgc2V0dXBzIGRv
IG5vdCB1c2UNCj4gaXB0YWJsZXMtcmVzdG9yZSkNCj4gYmV0dGVyIGJlIG1vcmUgcmVzaWxpZW50
IHRvIHRyYW5zaWVudCBJQ01QIG1lc3NhZ2VzIGFueXdheS4NCg0KVGhpcyBpcyBiZWluZyBkb25l
IGZvciB0aGUgc3BlY2lmaWMgcGFpciBvZiBzb2NrZXRzIHRoYXQgY2F1c2VkIGdyaWVmLg0KRm9y
IHRoaXMgc2V0dXAgdGhleSB3ZXJlIG9uIDEyNy4wLjAuMSBidXQgdGhhdCBpc24ndCBhbHdheXMg
dHJ1ZS4NCkJ1dCB0aGV5IHdvdWxkIGJlIGV4cGVjdGVkIHRvIGJlIG9uIGEgbG9jYWwgbmV0d29y
ay4NCg0KUmVhZGluZyBiZXR3ZWVuIHRoZSBsaW5lcyBvZiB0aGUgY29tbWVudCBpbiBpcHY0L2lj
bXAuYw0KaXQgaXMgcmVhc29uYWJsZSB0byBhc3N1bWUgdGhhdCBJQ01QX1BPUlRfVU5SRUFDSCBi
ZSB0cmVhdGVkDQphcyBhIGZhdGFsIGVycm9yIChpZSBub3QgYSB0cmFuc2llbnQgb25lKS4NClNv
IHJlYWxseSB0aGUgTGludXgga2VybmVsIG91Z2h0IHRvIHRyeSBxdWl0ZSBoYXJkIHRvIG5vdA0K
Z2VuZXJhdGUgdGhlbSB3aGVuIHRoZSBwb3J0IGV4aXN0cy4NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


