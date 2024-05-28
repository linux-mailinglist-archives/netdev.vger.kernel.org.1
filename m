Return-Path: <netdev+bounces-98444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFBD8D172C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC701C22FD5
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971824EB2E;
	Tue, 28 May 2024 09:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E971DA5F
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716888032; cv=none; b=QdMY9Zm4rwMiwLhb8m2m5NsoMECZerpzMXQVwFakscEfj7TD0ihutVWOLkONnRs5hML7rcOkrXftHE1DmDMAxujF/Ul9WSPfHjBdlbEubUAOKTVofE7skCeuAmVaLiHsSiQt+Bth5K7sE4QpYrS97aV5peU0tsv8LkgRQYCdiz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716888032; c=relaxed/simple;
	bh=Mf973evFBc27A+X/AnjFiPuMYdHGobo5IDxMnK62xRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=H/jvxW3mxAU3zKKWQKCCT58o+1wHmaZnQ9ufaD7FSwt4ogBkNoeq9R0st/C3NyRtEfbXkspPKsRnDJ+fLydNM8QpB9IB5KKP2ev8j7sPpOSJMTaZEIihKtISo6UQNNQZGVmCtD9HZYa1meHVZuJFQ94/CVhus4OGVWUpy8uuoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-275-hg5oxRZuP2yS-5OxNQA6Kw-1; Tue, 28 May 2024 10:20:24 +0100
X-MC-Unique: hg5oxRZuP2yS-5OxNQA6Kw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 28 May
 2024 10:19:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 28 May 2024 10:19:52 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Eric Dumazet' <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Neal Cardwell <ncardwell@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>
Subject: RE: [PATCH net 2/4] tcp: fix race in tcp_write_err()
Thread-Topic: [PATCH net 2/4] tcp: fix race in tcp_write_err()
Thread-Index: AQHarhG4UVZJa4qebkuglJvcfSTwvrGsYx8A
Date: Tue, 28 May 2024 09:19:51 +0000
Message-ID: <889fbe3feae042ada8d75a8a2184dbaa@AcuMS.aculab.com>
References: <20240524193630.2007563-1-edumazet@google.com>
 <20240524193630.2007563-3-edumazet@google.com>
In-Reply-To: <20240524193630.2007563-3-edumazet@google.com>
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

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDI0IE1heSAyMDI0IDIwOjM2DQo+IA0KPiBJIG5v
dGljZWQgZmxha2VzIGluIGEgcGFja2V0ZHJpbGwgdGVzdCwgZXhwZWN0aW5nIGFuIGVwb2xsX3dh
aXQoKQ0KPiB0byByZXR1cm4gRVBPTExFUlIgfCBFUE9MTEhVUCBvbiBhIGZhaWxlZCBjb25uZWN0
KCkgYXR0ZW1wdCwNCj4gYWZ0ZXIgbXVsdGlwbGUgU1lOIHJldHJhbnNtaXRzLiBJdCBzb21ldGlt
ZXMgcmV0dXJuIEVQT0xMRVJSIG9ubHkuDQo+IA0KPiBUaGUgaXNzdWUgaXMgdGhhdCB0Y3Bfd3Jp
dGVfZXJyKCk6DQo+ICAxKSB3cml0ZXMgYW4gZXJyb3IgaW4gc2stPnNrX2VyciwNCj4gIDIpIGNh
bGxzIHNrX2Vycm9yX3JlcG9ydCgpLA0KPiAgMykgdGhlbiBjYWxscyB0Y3BfZG9uZSgpLg0KPiAN
Cj4gdGNwX2RvbmUoKSBpcyB3cml0aW5nIFNIVVRET1dOX01BU0sgaW50byBzay0+c2tfc2h1dGRv
d24sDQo+IGFtb25nIG90aGVyIHRoaW5ncy4NCj4gDQo+IFByb2JsZW0gaXMgdGhhdCB0aGUgYXdh
a2VuIHVzZXIgdGhyZWFkIChmcm9tIDIpIHNrX2Vycm9yX3JlcG9ydCgpKQ0KPiBtaWdodCBjYWxs
IHRjcF9wb2xsKCkgYmVmb3JlIHRjcF9kb25lKCkgaGFzIHdyaXR0ZW4gc2stPnNrX3NodXRkb3du
Lg0KPiANCj4gdGNwX3BvbGwoKSBvbmx5IHNlZXMgYSBub24gemVybyBzay0+c2tfZXJyIGFuZCBy
ZXR1cm5zIEVQT0xMRVJSLg0KPiANCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUgYnkgbWFr
aW5nIHN1cmUgdG8gY2FsbCBza19lcnJvcl9yZXBvcnQoKQ0KPiBhZnRlciB0Y3BfZG9uZSgpLg0K
DQpJc24ndCB0aGVyZSBzdGlsbCB0aGUgcG90ZW50aWFsIGZvciBhIHByb2dyYW0gdG8gY2FsbCBw
b2xsKCkgYXQNCidqdXN0IHRoZSB3cm9uZyB0aW1lJyBhbmQgc3RpbGwgc2VlIGFuIHVuZXhwZWN0
ZWQgc3RhdHVzPw0KDQouLi4NCj4gIAlXUklURV9PTkNFKHNrLT5za19lcnIsIFJFQURfT05DRShz
ay0+c2tfZXJyX3NvZnQpID8gOiBFVElNRURPVVQpOw0KPiAtCXNrX2Vycm9yX3JlcG9ydChzayk7
DQo+IA0KPiAtCXRjcF93cml0ZV9xdWV1ZV9wdXJnZShzayk7DQo+IC0JdGNwX2RvbmUoc2spOw0K
PiArCXRjcF9kb25lX3dpdGhfZXJyb3Ioc2spOw0KDQpJcyB0aGVyZSBzY29wZSBmb3IgbW92aW5n
IHRoZSB3cml0ZSB0byBzay0+c2tfZXJyIGluc2lkZSB0aGUgZnVuY3Rpb24/DQpMb29rcyBsaWtl
IGl0J2xsIG5lZWQgYSBsYXJnZXIgY2hhbmdlIHRvIHRjcF9yZXNldCgpLg0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K


