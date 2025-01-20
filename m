Return-Path: <netdev+bounces-159672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D357A16589
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 04:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FE6168C67
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 03:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30F445979;
	Mon, 20 Jan 2025 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="fOcaIKPD"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046E71A260
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737342118; cv=none; b=LopUgWeB7ZBMqJDvdcLmT238Cde5acrJopTUesdMbORPXyEwlnCobmMD2W82V8ie3nU3/bEec85zm4X6Cyq1Wvy6FJx0gtG+h6AfBrgNQgCAprXGuIrpONyHkXqqU5U0Kas2DdKiuWKtGixoqQWtnfQQDb5iTJslLQhEKQGNmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737342118; c=relaxed/simple;
	bh=C82VAA97nN7sPGTfR12mMigRs8kUSqfdZHUq33ZZ5Ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gm50Cw0EHUc3JalEYSmuxNFmtA60dUvQD1mhj3M7Ve/h2BwkMS+3S27K39p9+1YVmwnv9HVhiQBjdOM+AKxCZYoU0RIThtOZExj8x7Smk9Xx+awgB1nzZxn9hzLUQ/5/SyUSxN3bFAsJ6gNxcsqmvJq3SZL/jy47syh3gIggudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=fOcaIKPD; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B682E2C083A;
	Mon, 20 Jan 2025 16:01:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1737342112;
	bh=C82VAA97nN7sPGTfR12mMigRs8kUSqfdZHUq33ZZ5Ac=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=fOcaIKPDXb+rqOgc/gBlQRvYV+CeBDTKMglqxazRHXlxg6+ec1lM0MZRWYGQA/Fk8
	 aqgVjJnaZ8MZJxfEZPWWIgtLaCXN5p48pLETVP5md8rOHmVPoxOw30lAVvQOIPtEa5
	 08W5XbZOVHieieBikmDjKKMb0Fwa+IgOrPLne0JKId18p5I+kMVbNox+ZahzJRMya7
	 7mZcbTBiAKnS5/huALbCHjwFhX0ZFSzYtTe6zWM5nUyjGlzR1xl9h2k2/3QwtESqK9
	 F1rTy5x1966of7JCAN9itSTAynvnzKI8gfTwPymUXFqURZ4Wo4V80pmvQIqLeTNNxR
	 Xj2LGf+FSQx6w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B678dbc9e0000>; Mon, 20 Jan 2025 16:01:50 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jan 2025 16:01:49 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Mon, 20 Jan 2025 16:01:49 +1300
From: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [RFC net-next v1 2/2] net: dsa: add option for bridge port HW
 offload
Thread-Topic: [RFC net-next v1 2/2] net: dsa: add option for bridge port HW
 offload
Thread-Index: AQHbatUxQfjmZDZH702s8g6egGdzMbMeGWgAgAAGS4A=
Date: Mon, 20 Jan 2025 03:01:49 +0000
Message-ID: <5d5cc80b20e878d01c3d7d739f0fc7e429a840ed.camel@alliedtelesis.co.nz>
References: <20250120004913.2154398-1-aryan.srivastava@alliedtelesis.co.nz>
	 <20250120004913.2154398-3-aryan.srivastava@alliedtelesis.co.nz>
	 <bb9cf9af-2f17-4af6-9d1c-3981cc8468c0@lunn.ch>
In-Reply-To: <bb9cf9af-2f17-4af6-9d1c-3981cc8468c0@lunn.ch>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <20CECB40A5621841ADEFBC9BDE6CECF4@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=678dbc9e a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=w1vUsAckAk8A:10 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=ByVZZFbea3KVNN6ZEcIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gTW9uLCAyMDI1LTAxLTIwIGF0IDAzOjM5ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
T24gTW9uLCBKYW4gMjAsIDIwMjUgYXQgMDE6NDk6MTJQTSArMTMwMCwgQXJ5YW4gU3JpdmFzdGF2
YSB3cm90ZToNCj4gPiBDdXJyZW50bHkgdGhlIERTQSBmcmFtZXdvcmsgd2lsbCBIVyBvZmZsb2Fk
IGFueSBicmlkZ2UgcG9ydCBpZg0KPiA+IHRoZXJlIGlzDQo+ID4gYSBkcml2ZXIgYXZhaWxhYmxl
IHRvIHN1cHBvcnQgSFcgb2ZmbG9hZGluZy4gVGhpcyBtYXkgbm90IGFsd2F5cyBiZQ0KPiA+IHRo
ZQ0KPiA+IHByZWZlcnJlZCBjYXNlLiBJbiBjYXNlcyB3aGVyZSBpdCBpcyBwcmVmZXJyZWQgdGhh
dCBhbGwgdHJhZmZpYw0KPiA+IHN0aWxsDQo+ID4gaGl0IHRoZSBDUFUsIGRvIHNvZnR3YXJlIGJy
aWRnaW5nIGluc3RlYWQuDQo+ID4gDQo+ID4gVG8gcHJldmVudCBIVyBicmlkZ2luZyAoYW5kIHBv
dGVudGlhbCBDUFUgYnlwYXNzKSwgbWFrZSB0aGUgRFNBDQo+ID4gZnJhbWV3b3JrIGF3YXJlIG9m
IHRoZSBkZXZsaW5rIHBvcnQgZnVuY3Rpb24gYXR0ciwgYnJpZGdlX29mZmxvYWQsDQo+ID4gYW5k
DQo+ID4gYWRkIGEgbWF0Y2hpbmcgZmllbGQgdG8gdGhlIHBvcnQgc3RydWN0LiBBZGQgZ2V0L3Nl
dCBmdW5jdGlvbnMgdG8NCj4gPiBjb25maWd1cmUgdGhlIGZpZWxkLCBhbmQgdXNlIHRoaXMgZmll
bGQgdG8gY29uZGl0aW9uIEhXIGNvbmZpZyBmb3INCj4gPiBvZmZsb2FkaW5nIGEgYnJpZGdlIHBv
cnQuDQo+IA0KPiBUaGlzIGlzIG5vdCBhIHZlcnkgY29udmluY2luZyBkZXNjcmlwdGlvbi4gV2hh
dCBpcyB5b3VyIHJlYWwgdXNlIGNhc2UNCj4gZm9yIG5vdCBvZmZsb2FkaW5nPw0KPiANClRoZSBy
ZWFsIHVzZSBjYXNlIGZvciB1cyBpcyBwYWNrZXQgaW5zcGVjdGlvbi4gRHVlIHRvIHRoZSBicmlk
Z2UgcG9ydHMNCmJlaW5nIG9mZmxvYWRlZCBpbiBoYXJkd2FyZSwgd2UgY2FuIG5vIGxvbmdlciBp
bnNwZWN0IHRoZSB0cmFmZmljIG9uDQp0aGVtLCBhcyB0aGUgcGFja2V0cyBuZXZlciBoaXQgdGhl
IENQVS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBcnlhbiBTcml2YXN0YXZhDQo+ID4gPGFy
eWFuLnNyaXZhc3RhdmFAYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gPiAtLS0NCj4gPiDCoGluY2x1
ZGUvbmV0L2RzYS5oIHzCoCAxICsNCj4gPiDCoG5ldC9kc2EvZGV2bGluay5jIHwgMjcgKysrKysr
KysrKysrKysrKysrKysrKysrKystDQo+ID4gwqBuZXQvZHNhL2RzYS5jwqDCoMKgwqAgfMKgIDEg
Kw0KPiA+IMKgbmV0L2RzYS9wb3J0LmPCoMKgwqAgfMKgIDMgKystDQo+ID4gwqA0IGZpbGVzIGNo
YW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbmV0L2RzYS5oIGIvaW5jbHVkZS9uZXQvZHNhLmgNCj4gPiBpbmRleCBh
MGE5NDgxYzUyYzIuLjllZTJkN2NjZmZmOCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL25ldC9k
c2EuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbmV0L2RzYS5oDQo+ID4gQEAgLTI5MSw2ICsyOTEsNyBA
QCBzdHJ1Y3QgZHNhX3BvcnQgew0KPiA+IMKgDQo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBk
ZXZpY2Vfbm9kZcKgwqDCoMKgwqDCoCpkbjsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQg
aW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWdlaW5nX3RpbWU7DQo+ID4gK8KgwqDCoMKgwqDC
oMKgYm9vbCBicmlkZ2Vfb2ZmbG9hZGluZzsNCj4gDQo+IEluZGVudGF0aW9uIGlzIG5vdCBjb25z
aXN0ZW50IGhlcmUuDQpXaWxsIGZpeC4NCj4gDQo+IG5ldC1uZXh0IGlzIGNsb3NlZCBmb3IgdGhl
IG1lcmdlIHdpbmRvdy4NCkkgd2FzIHVuc3VyZSBhYm91dCB1cGxvYWRpbmcgdGhpcyByaWdodCBu
b3cgKGFzIHlvdSBzYWlkIG5ldC1uZXh0IGlzDQpjbG9zZWQpLCBidXQgdGhlIG5ldGRldiBkb2Nz
IHBhZ2Ugc3RhdGVzIHRoYXQgUkZDIHBhdGNoZXMgYXJlIHdlbGNvbWUNCmFueXRpbWUsIHBsZWFz
ZSBsZXQgbWUga25vdyBpZiB0aGlzIGlzIG5vdCBjYXNlLCBhbmQgaWYgc28gSSBhcG9sb2dpemUN
CmZvciBteSBlcnJvbmVvdXMgc3VibWlzc2lvbi4NCj4gIA0KPiANCj4gwqDCoMKgIEFuZHJldw0K
PiANCj4gLS0tDQo+IHB3LWJvdDogY3INCg0KCUFyeWFuDQoNCg==

