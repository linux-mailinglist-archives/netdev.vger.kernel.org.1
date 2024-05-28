Return-Path: <netdev+bounces-98479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8149F8D18D5
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19DC91F2456C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA116B749;
	Tue, 28 May 2024 10:44:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3EB16B743
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893065; cv=none; b=M0PrgTA/9y1aIFwn/SEzqRSj/1ZDWK4ernrvab2vue2f40wnr2dSygVAR0/CVomH6ZUyRrysjqls289y4ms2GiYn93NlcazxloCEDmvUJcFelbrYYlnSFTelSjoA/OEl0BwCrPWwNDWOJdx2Dpi/YfyeDg4RZSjGo8ofD4qS6CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893065; c=relaxed/simple;
	bh=MKPxkQlar6/BFyQWhPz1v4p3LUX1mhm2xVuIhSUAlKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=iug65B52l+ZLcqwfTsWVuejki5Bu219P4IWEZseQ4FC7MzlanAvZJw9z2oCnLZQ5/vwbSHXcKuI71EK4BsCbme+yUBTyFsUMNacUtVH9+amdwcY2V/bAMnZDiYRPnY9hexZydK3vOyC/ChEe0EXey2T+Z5OHZrVEDBHlOewe1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-259-9RTfNicaNXK_txfc3i4faw-1; Tue, 28 May 2024 11:44:18 +0100
X-MC-Unique: 9RTfNicaNXK_txfc3i4faw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 28 May
 2024 11:43:45 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 28 May 2024 11:43:45 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Paolo Abeni' <pabeni@redhat.com>, 'Eric Dumazet' <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Neal Cardwell <ncardwell@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>
Subject: RE: [PATCH net 2/4] tcp: fix race in tcp_write_err()
Thread-Topic: [PATCH net 2/4] tcp: fix race in tcp_write_err()
Thread-Index: AQHarhG4UVZJa4qebkuglJvcfSTwvrGsYx8AgAAFjICAABHYcA==
Date: Tue, 28 May 2024 10:43:45 +0000
Message-ID: <f0bfde4a89ab4550be05473411aed1d2@AcuMS.aculab.com>
References: <20240524193630.2007563-1-edumazet@google.com>
	 <20240524193630.2007563-3-edumazet@google.com>
	 <889fbe3feae042ada8d75a8a2184dbaa@AcuMS.aculab.com>
 <dfcb505c48ff1571734d7afeaf6b7f747d70d258.camel@redhat.com>
In-Reply-To: <dfcb505c48ff1571734d7afeaf6b7f747d70d258.camel@redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
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

RnJvbTogUGFvbG8gQWJlbmkNCj4gU2VudDogMjggTWF5IDIwMjQgMTE6MzYNCj4gDQo+IE9uIFR1
ZSwgMjAyNC0wNS0yOCBhdCAwOToxOSArMDAwMCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEZy
b206IEVyaWMgRHVtYXpldA0KPiA+ID4gU2VudDogMjQgTWF5IDIwMjQgMjA6MzYNCj4gPiA+DQo+
ID4gPiBJIG5vdGljZWQgZmxha2VzIGluIGEgcGFja2V0ZHJpbGwgdGVzdCwgZXhwZWN0aW5nIGFu
IGVwb2xsX3dhaXQoKQ0KPiA+ID4gdG8gcmV0dXJuIEVQT0xMRVJSIHwgRVBPTExIVVAgb24gYSBm
YWlsZWQgY29ubmVjdCgpIGF0dGVtcHQsDQo+ID4gPiBhZnRlciBtdWx0aXBsZSBTWU4gcmV0cmFu
c21pdHMuIEl0IHNvbWV0aW1lcyByZXR1cm4gRVBPTExFUlIgb25seS4NCj4gPiA+DQo+ID4gPiBU
aGUgaXNzdWUgaXMgdGhhdCB0Y3Bfd3JpdGVfZXJyKCk6DQo+ID4gPiAgMSkgd3JpdGVzIGFuIGVy
cm9yIGluIHNrLT5za19lcnIsDQo+ID4gPiAgMikgY2FsbHMgc2tfZXJyb3JfcmVwb3J0KCksDQo+
ID4gPiAgMykgdGhlbiBjYWxscyB0Y3BfZG9uZSgpLg0KPiA+ID4NCj4gPiA+IHRjcF9kb25lKCkg
aXMgd3JpdGluZyBTSFVURE9XTl9NQVNLIGludG8gc2stPnNrX3NodXRkb3duLA0KPiA+ID4gYW1v
bmcgb3RoZXIgdGhpbmdzLg0KPiA+ID4NCj4gPiA+IFByb2JsZW0gaXMgdGhhdCB0aGUgYXdha2Vu
IHVzZXIgdGhyZWFkIChmcm9tIDIpIHNrX2Vycm9yX3JlcG9ydCgpKQ0KPiA+ID4gbWlnaHQgY2Fs
bCB0Y3BfcG9sbCgpIGJlZm9yZSB0Y3BfZG9uZSgpIGhhcyB3cml0dGVuIHNrLT5za19zaHV0ZG93
bi4NCj4gPiA+DQo+ID4gPiB0Y3BfcG9sbCgpIG9ubHkgc2VlcyBhIG5vbiB6ZXJvIHNrLT5za19l
cnIgYW5kIHJldHVybnMgRVBPTExFUlIuDQo+ID4gPg0KPiA+ID4gVGhpcyBwYXRjaCBmaXhlcyB0
aGUgaXNzdWUgYnkgbWFraW5nIHN1cmUgdG8gY2FsbCBza19lcnJvcl9yZXBvcnQoKQ0KPiA+ID4g
YWZ0ZXIgdGNwX2RvbmUoKS4NCj4gPg0KPiA+IElzbid0IHRoZXJlIHN0aWxsIHRoZSBwb3RlbnRp
YWwgZm9yIGEgcHJvZ3JhbSB0byBjYWxsIHBvbGwoKSBhdA0KPiA+ICdqdXN0IHRoZSB3cm9uZyB0
aW1lJyBhbmQgc3RpbGwgc2VlIGFuIHVuZXhwZWN0ZWQgc3RhdHVzPw0KPiA+DQo+ID4gLi4uDQo+
ID4gPiAgCVdSSVRFX09OQ0Uoc2stPnNrX2VyciwgUkVBRF9PTkNFKHNrLT5za19lcnJfc29mdCkg
PyA6IEVUSU1FRE9VVCk7DQo+ID4gPiAtCXNrX2Vycm9yX3JlcG9ydChzayk7DQo+ID4gPg0KPiA+
ID4gLQl0Y3Bfd3JpdGVfcXVldWVfcHVyZ2Uoc2spOw0KPiA+ID4gLQl0Y3BfZG9uZShzayk7DQo+
ID4gPiArCXRjcF9kb25lX3dpdGhfZXJyb3Ioc2spOw0KPiA+DQo+ID4gSXMgdGhlcmUgc2NvcGUg
Zm9yIG1vdmluZyB0aGUgd3JpdGUgdG8gc2stPnNrX2VyciBpbnNpZGUgdGhlIGZ1bmN0aW9uPw0K
PiANCj4gRG8geW91IG1lYW4gdGhhdCB0aGUgY29tcGlsZXIgb3IgdGhlIENQVSBjYW4gcmVvcmRl
ciB0aGUgV1JJVEVfT05DRSB3cnQNCj4gdGNwX2RvbmVfd2l0aF9lcnJvcigpPyBJIHRoaW5rIHRo
ZSBmdW5jdGlvbiBjYWxsIHByZXZlbnRzIHRoYXQuDQoNCk5vLCBqdXN0IHRoYXQgdGhlIGNvZGUg
d291bGQgYmUgZWFzaWVyIHRvIHJlYWQgd2l0aCAoc2F5KToNCgl0Y3BfZG9uZV93aXRoX2Vycm9y
KHNrLCBFVElNRURPVVQpOw0KcmF0aGVyIHRoYW4gcmVxdWlyaW5nIHRoZSBjYWxsZXIgZG8gYSBX
UklURV9PTkNFKCkgcHJpb3IgdG8gdGhlIGNhbGwuDQoNClRoaXMgbWlnaHQgYWxzbyBiZSBuZWVk
ZWQgaW4gb3JkZXIgdG8gZW5zdXJlIHRoYXQgYm90aCBQT0xMRVJSIGFuZCBQT0xMSFVQDQphbHdh
eXMgZ2V0IHJlcG9ydGVkLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


