Return-Path: <netdev+bounces-67072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06B0841FD7
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687082926A4
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E032627F0;
	Tue, 30 Jan 2024 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EDBofFn5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429B65BA9
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607568; cv=none; b=Nl/HspkMLJBP5GSDSzQGeCP/3/Xd9Txq/StbofSCOTz30YtPFrMZEP8TMJd8vwQRGjhT78DmMWl5A0flpaJDDnsbsE62nAFT+hDe3fSMUc2vE5YdBY9u50H+pbKHQpl+QVy+UnnazCV4z7DF9UWVT6O2gqGqat18X263jLegHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607568; c=relaxed/simple;
	bh=xxmcdOENP9fjBD5GJ6DQW78bJ7sil6k3R/txB5zrohM=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gK1YWKIti2v/Su+w6R9+/jLTgb/zd5KyS8Y7BcZbUH2yyy0nY9DAGrLRgVKNPvgAhm/Q1beKy0ZdfVfMmdouDlEBogrIh4yFJER0BinLVQms3fh2F8jmrTBUF9FztjyRv3maRoBuSC4cYadP68/co5RBSTkLkmu7eTIlaYqgxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EDBofFn5; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706607566; x=1738143566;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=xxmcdOENP9fjBD5GJ6DQW78bJ7sil6k3R/txB5zrohM=;
  b=EDBofFn5SXir9EuV1YHCc9G5hpxQTxLXjpUuEFNp8/k/tTJrtEYiOVUP
   kL2lFZ+9N1rPBG+6LUufJxi1B979DkvKVFm3/fOHuSz+SfsyJ31yiBhC7
   KkaL+EXznoQgkR1hEEF80OvcWzl7RbC0Cpm1tTXk9rCMwIHc2QL6yMGTZ
   E=;
X-IronPort-AV: E=Sophos;i="6.05,707,1701129600"; 
   d="scan'208";a="62255946"
Subject: RE: [PATCH v1 net-next 10/11] net: ena: handle ena_calc_io_queue_size()
 possible errors
Thread-Topic: [PATCH v1 net-next 10/11] net: ena: handle ena_calc_io_queue_size() possible
 errors
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:39:24 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id 96844805DF;
	Tue, 30 Jan 2024 09:39:21 +0000 (UTC)
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:53121]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.17:2525] with esmtp (Farcaster)
 id cbd468f8-b445-4cfc-948e-458c66e33675; Tue, 30 Jan 2024 09:39:20 +0000 (UTC)
X-Farcaster-Flow-ID: cbd468f8-b445-4cfc-948e-458c66e33675
Received: from EX19D028EUB004.ant.amazon.com (10.252.61.32) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:39:20 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D028EUB004.ant.amazon.com (10.252.61.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:39:20 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1118.040; Tue, 30 Jan 2024 09:39:20 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
	<zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Koler, Nati" <nkolder@amazon.com>
Thread-Index: AQHaUxoNcgmlInxuYkOcz21PcCIzcLDx8kdw
Date: Tue, 30 Jan 2024 09:39:19 +0000
Message-ID: <2baee949f83d47a896a2752e7667a99a@amazon.com>
References: <20240129085531.15608-1-darinzon@amazon.com>
 <20240129085531.15608-11-darinzon@amazon.com>
 <8752f5ea-9e9d-4884-b472-445c711c7bf0@amd.com>
In-Reply-To: <8752f5ea-9e9d-4884-b472-445c711c7bf0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Precedence: Bulk

PiBPbiAxLzI5LzIwMjQgMTI6NTUgQU0sIGRhcmluem9uQGFtYXpvbi5jb20gd3JvdGU6DQo+ID4N
Cj4gPiBGcm9tOiBEYXZpZCBBcmluem9uIDxkYXJpbnpvbkBhbWF6b24uY29tPg0KPiA+DQo+ID4g
RmFpbCBxdWV1ZSBzaXplIGNhbGN1bGF0aW9uIHdoZW4gdGhlIGRldmljZSByZXR1cm5zIG1heGlt
dW0gVFgvUlgNCj4gPiBxdWV1ZSBzaXplcyB0aGF0IGFyZSBzbWFsbGVyIHRoYW4gdGhlIGFsbG93
ZWQgbWluaW11bS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE9zYW1hIEFiYm91ZCA8b3NhbWFh
YmJAYW1hem9uLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBBcmluem9uIDxkYXJpbnpv
bkBhbWF6b24uY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9u
L2VuYS9lbmFfbmV0ZGV2LmMgfCAyNA0KPiArKysrKysrKysrKysrKysrKy0tLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfbmV0ZGV2LmMN
Cj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FtYXpvbi9lbmEvZW5hX25ldGRldi5jDQo+ID4g
aW5kZXggOGQ5OTkwNC4uY2E1NmRmZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9hbWF6b24vZW5hL2VuYV9uZXRkZXYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2FtYXpvbi9lbmEvZW5hX25ldGRldi5jDQo+ID4gQEAgLTI4OTksOCArMjg5OSw4IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbmV0X2RldmljZV9vcHMNCj4gZW5hX25ldGRldl9vcHMgPSB7DQo+
ID4gICAgICAgICAgLm5kb194ZHBfeG1pdCAgICAgICAgICAgPSBlbmFfeGRwX3htaXQsDQo+ID4g
ICB9Ow0KPiA+DQo+ID4gLXN0YXRpYyB2b2lkIGVuYV9jYWxjX2lvX3F1ZXVlX3NpemUoc3RydWN0
IGVuYV9hZGFwdGVyICphZGFwdGVyLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IGVuYV9jb21fZGV2X2dldF9mZWF0dXJlc19jdHggKmdldF9mZWF0X2N0eCkN
Cj4gPiArc3RhdGljIGludCBlbmFfY2FsY19pb19xdWV1ZV9zaXplKHN0cnVjdCBlbmFfYWRhcHRl
ciAqYWRhcHRlciwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGVuYV9jb21fZGV2X2dldF9mZWF0dXJlc19jdHgNCj4gPiArKmdldF9mZWF0X2N0eCkNCj4gPiAg
IHsNCj4gPiAgICAgICAgICBzdHJ1Y3QgZW5hX2FkbWluX2ZlYXR1cmVfbGxxX2Rlc2MgKmxscSA9
ICZnZXRfZmVhdF9jdHgtPmxscTsNCj4gPiAgICAgICAgICBzdHJ1Y3QgZW5hX2NvbV9kZXYgKmVu
YV9kZXYgPSBhZGFwdGVyLT5lbmFfZGV2OyBAQCAtMjk1OSw2DQo+ID4gKzI5NTksMTggQEAgc3Rh
dGljIHZvaWQgZW5hX2NhbGNfaW9fcXVldWVfc2l6ZShzdHJ1Y3QgZW5hX2FkYXB0ZXINCj4gKmFk
YXB0ZXIsDQo+ID4gICAgICAgICAgbWF4X3R4X3F1ZXVlX3NpemUgPQ0KPiByb3VuZGRvd25fcG93
X29mX3R3byhtYXhfdHhfcXVldWVfc2l6ZSk7DQo+ID4gICAgICAgICAgbWF4X3J4X3F1ZXVlX3Np
emUgPQ0KPiByb3VuZGRvd25fcG93X29mX3R3byhtYXhfcnhfcXVldWVfc2l6ZSk7DQo+ID4NCj4g
PiArICAgICAgIGlmIChtYXhfdHhfcXVldWVfc2l6ZSA8IEVOQV9NSU5fUklOR19TSVpFKSB7DQo+
ID4gKyAgICAgICAgICAgICAgIG5ldGRldl9lcnIoYWRhcHRlci0+bmV0ZGV2LCAiRGV2aWNlIG1h
eCBUWCBxdWV1ZSBzaXplOiAlZCA8DQo+IG1pbmltdW06ICVkXG4iLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgIG1heF90eF9xdWV1ZV9zaXplLCBFTkFfTUlOX1JJTkdfU0laRSk7DQo+
ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsN
Cj4gPiArICAgICAgIGlmIChtYXhfcnhfcXVldWVfc2l6ZSA8IEVOQV9NSU5fUklOR19TSVpFKSB7
DQo+ID4gKyAgICAgICAgICAgICAgIG5ldGRldl9lcnIoYWRhcHRlci0+bmV0ZGV2LCAiRGV2aWNl
IG1heCBSWCBxdWV1ZSBzaXplOiAlZCA8DQo+IG1pbmltdW06ICVkXG4iLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgIG1heF9yeF9xdWV1ZV9zaXplLCBFTkFfTUlOX1JJTkdfU0laRSk7
DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiANCj4gTWF5YmUgRUlOVkFM
IGZvciB0aGVzZSB0d28/DQo+IA0KPiBzbG4NCj4gDQoNCkkgYWdyZWUgd2l0aCB5b3UsIEVJTlZB
TCByZXByZXNlbnRzIHRoaXMgZXJyb3IgbXVjaCBiZXR0ZXIgdGhhbiBFRkFVTFQuDQpXaWxsIGNo
YW5nZSBpbiB0aGUgbmV4dCBwYXRjaHNldC4NCg0KVGhhbmtzIQ0KRGF2aWQNCg0KPiA+ICsgICAg
ICAgfQ0KPiA+ICsNCj4gPiAgICAgICAgICAvKiBXaGVuIGZvcmNpbmcgbGFyZ2UgaGVhZGVycywg
d2UgbXVsdGlwbHkgdGhlIGVudHJ5IHNpemUgYnkgMiwgYW5kDQo+IHRoZXJlZm9yZSBkaXZpZGUN
Cj4gPiAgICAgICAgICAgKiB0aGUgcXVldWUgc2l6ZSBieSAyLCBsZWF2aW5nIHRoZSBhbW91bnQg
b2YgbWVtb3J5IHVzZWQgYnkgdGhlDQo+IHF1ZXVlcyB1bmNoYW5nZWQuDQo+ID4gICAgICAgICAg
ICovDQo+ID4gQEAgLTI5ODksNiArMzAwMSw4IEBAIHN0YXRpYyB2b2lkIGVuYV9jYWxjX2lvX3F1
ZXVlX3NpemUoc3RydWN0DQo+IGVuYV9hZGFwdGVyICphZGFwdGVyLA0KPiA+ICAgICAgICAgIGFk
YXB0ZXItPm1heF9yeF9yaW5nX3NpemUgPSBtYXhfcnhfcXVldWVfc2l6ZTsNCj4gPiAgICAgICAg
ICBhZGFwdGVyLT5yZXF1ZXN0ZWRfdHhfcmluZ19zaXplID0gdHhfcXVldWVfc2l6ZTsNCj4gPiAg
ICAgICAgICBhZGFwdGVyLT5yZXF1ZXN0ZWRfcnhfcmluZ19zaXplID0gcnhfcXVldWVfc2l6ZTsN
Cj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGlj
IGludCBlbmFfZGV2aWNlX3ZhbGlkYXRlX3BhcmFtcyhzdHJ1Y3QgZW5hX2FkYXB0ZXIgKmFkYXB0
ZXIsDQo+ID4gQEAgLTMxOTAsMTEgKzMyMDQsMTUgQEAgc3RhdGljIGludCBlbmFfZGV2aWNlX2lu
aXQoc3RydWN0IGVuYV9hZGFwdGVyDQo+ICphZGFwdGVyLCBzdHJ1Y3QgcGNpX2RldiAqcGRldiwN
Cj4gPiAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX2FkbWluX2luaXQ7DQo+ID4gICAgICAgICAg
fQ0KPiA+DQo+ID4gLSAgICAgICBlbmFfY2FsY19pb19xdWV1ZV9zaXplKGFkYXB0ZXIsIGdldF9m
ZWF0X2N0eCk7DQo+ID4gKyAgICAgICByYyA9IGVuYV9jYWxjX2lvX3F1ZXVlX3NpemUoYWRhcHRl
ciwgZ2V0X2ZlYXRfY3R4KTsNCj4gPiArICAgICAgIGlmICh1bmxpa2VseShyYykpDQo+ID4gKyAg
ICAgICAgICAgICAgIGdvdG8gZXJyX2FkbWluX2luaXQ7DQo+ID4NCj4gPiAgICAgICAgICByZXR1
cm4gMDsNCj4gPg0KPiA+ICAgZXJyX2FkbWluX2luaXQ6DQo+ID4gKyAgICAgICBlbmFfY29tX2Fi
b3J0X2FkbWluX2NvbW1hbmRzKGVuYV9kZXYpOw0KPiA+ICsgICAgICAgZW5hX2NvbV93YWl0X2Zv
cl9hYm9ydF9jb21wbGV0aW9uKGVuYV9kZXYpOw0KPiA+ICAgICAgICAgIGVuYV9jb21fZGVsZXRl
X2hvc3RfaW5mbyhlbmFfZGV2KTsNCj4gPiAgICAgICAgICBlbmFfY29tX2FkbWluX2Rlc3Ryb3ko
ZW5hX2Rldik7DQo+ID4gICBlcnJfbW1pb19yZWFkX2xlc3M6DQo+ID4gLS0NCj4gPiAyLjQwLjEN
Cj4gPg0KPiA+DQo=

