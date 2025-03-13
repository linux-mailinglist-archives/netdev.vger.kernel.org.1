Return-Path: <netdev+bounces-174754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE54A602E7
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 21:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EB3423109
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084451F4622;
	Thu, 13 Mar 2025 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="cC7ZJfFZ"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736F145A11
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898655; cv=none; b=IK2kLROkh+ZObjl2oZs5gjRXGzjj3ea98UMTtgWdz+u+oj+GJXraQIzwyO/KmAjIysNeAV+NBcNblT3QZy5WiEAPXy0An2kfPPxAzNsb84PjWu4nvbs7S0pnTKbOLxNgNbjM7rFTmuBv2/fci+E9/FfpnTH2oQwheYYiDVITf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898655; c=relaxed/simple;
	bh=QvftfQ+N31PDzhDFty5prLUokxwG9Cqc+YRRm3SobXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CX5k2YAO9h7rpl/KrvH62zFsOeXRJDVuYQvY5jVrzjS6GvdUtIBEA5/buNzytllI6tYuCLJafnit0ICUzCja+eyHrK56r/IAe4rPP8S/PUkBLy4TxVC1gZighkThf42kihrqNhDXSgJHeTJEpBzzRRWwH/OQ1lH8FOq4j1iu9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=cC7ZJfFZ; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4723F2C0375;
	Fri, 14 Mar 2025 09:44:11 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1741898651;
	bh=QvftfQ+N31PDzhDFty5prLUokxwG9Cqc+YRRm3SobXI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=cC7ZJfFZTtvR7hHeevBnSt9saC5nZ29KE23r3P/9E7wJdJYJnwgAEAwXfhqKCgrjN
	 oqk3AG7hsDKUnqFwW9AqrQ1YNc1qXT+agci/ID5JYch+1v0h5p5ogdRN2UfEZvYguc
	 mSIApCzVOZ0VxiLYhW0FWBrH2FMO0Nt4AEbPzA/QUD7GwrnjlBeB/Q1yIma4cP7JYZ
	 MxJLXy0jMtqx+fbT6LFwiTm5YjivTqpK7WQn5fmWH+OlYv4R9M2BRkoWfnq1cfmVDY
	 vsm6HqIzFrTUEFgM9wJYkbpvQ//eBkywOycrnfAartp1YuMf1rnWlyexVpo11nAc8n
	 cWOusbqsAk0GA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67d3439b0001>; Fri, 14 Mar 2025 09:44:11 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 09:44:11 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Fri, 14 Mar 2025 09:44:10 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "markus.stockhausen@gmx.de"
	<markus.stockhausen@gmx.de>, "sander@svanheule.net" <sander@svanheule.net>,
	netdev <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10] net: mdio: Add RTL9300 MDIO driver
Thread-Topic: [PATCH v10] net: mdio: Add RTL9300 MDIO driver
Thread-Index: AQHbk7RQMlEBwbSVuE+Te7ZjHwH5gbNwJygAgAB7A4CAAAtMgIAAAJ2AgAAA44CAAAEKAA==
Date: Thu, 13 Mar 2025 20:44:10 +0000
Message-ID: <6ae8b7c6-8e75-4bfc-9ea3-302269a26951@alliedtelesis.co.nz>
References: <20250313010726.2181302-1-chris.packham@alliedtelesis.co.nz>
 <f7c7f28b-f2b0-464a-a621-d4b2f815d206@lunn.ch>
 <5ea333ec-c2e4-4715-8a44-0fd2c77a4f3c@alliedtelesis.co.nz>
 <be39bb63-446e-4c6a-9bb9-a823f0a482be@lunn.ch>
 <539762a3-b17d-415c-9316-66527bfc6219@alliedtelesis.co.nz>
 <6a98ba41-34ee-4493-b0ea-0c24d7e979b1@lunn.ch>
In-Reply-To: <6a98ba41-34ee-4493-b0ea-0c24d7e979b1@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <63AC36120E64B04DA3BAC2ACB1FCD9C9@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Ko7u2nWN c=1 sm=1 tr=0 ts=67d3439b a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=tcDedsyIYY4bTMdrMOQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAxNC8wMy8yMDI1IDA5OjQwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4gT24gVGh1LCBNYXIg
MTMsIDIwMjUgYXQgMDg6Mzc6MThQTSArMDAwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IE9u
IDE0LzAzLzIwMjUgMDk6MzUsIEFuZHJldyBMdW5uIHdyb3RlOg0KPj4+IE9uIFRodSwgTWFyIDEz
LCAyMDI1IGF0IDA3OjU0OjM5UE0gKzAwMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+Pj4+ICtj
YyBuZXRkZXYsIGxrbWwNCj4+Pj4NCj4+Pj4gT24gMTQvMDMvMjAyNSAwMTozNCwgQW5kcmV3IEx1
bm4gd3JvdGU6DQo+Pj4+Pj4gKwkvKiBQdXQgdGhlIGludGVyZmFjZXMgaW50byBDNDUgbW9kZSBp
ZiByZXF1aXJlZCAqLw0KPj4+Pj4+ICsJZ2xiX2N0cmxfbWFzayA9IEdFTk1BU0soMTksIDE2KTsN
Cj4+Pj4+PiArCWZvciAoaSA9IDA7IGkgPCBNQVhfU01JX0JVU1NFUzsgaSsrKQ0KPj4+Pj4+ICsJ
CWlmIChwcml2LT5zbWlfYnVzX2lzX2M0NVtpXSkNCj4+Pj4+PiArCQkJZ2xiX2N0cmxfdmFsIHw9
IEdMQl9DVFJMX0lOVEZfU0VMKGkpOw0KPj4+Pj4+ICsNCj4+Pj4+PiArCWZ3bm9kZV9mb3JfZWFj
aF9jaGlsZF9ub2RlKG5vZGUsIGNoaWxkKQ0KPj4+Pj4+ICsJCWlmIChmd25vZGVfZGV2aWNlX2lz
X2NvbXBhdGlibGUoY2hpbGQsICJldGhlcm5ldC1waHktaWVlZTgwMi4zLWM0NSIpKQ0KPj4+Pj4+
ICsJCQlwcml2LT5zbWlfYnVzX2lzX2M0NVttZGlvX2J1c10gPSB0cnVlOw0KPj4+Pj4+ICsNCj4+
Pj4+IFRoaXMgbmVlZHMgbW9yZSBleHBsYW5hdGlvbi4gU29tZSBQSFlzIG1peCBDMjIgYW5kIEM0
NSwgZS5nLiB0aGUgPiAxRw0KPj4+Pj4gc3BlZWQgc3VwcG9ydCByZWdpc3RlcnMgYXJlIGluIHRo
ZSBDNDUgYWRkcmVzcyBzcGFjZSwgYnV0IDw9IDFHIGlzIGluDQo+Pj4+PiB0aGUgQzIyIHNwYWNl
LiBBbmQgMUcgUEhZcyB3aGljaCBzdXBwb3J0IEVFRSBuZWVkIGFjY2VzcyB0byBDNDUgc3BhY2UN
Cj4+Pj4+IGZvciB0aGUgRUVFIHJlZ2lzdGVycy4NCj4+Pj4gQWggZ29vZCBwb2ludC4gVGhlIE1E
SU8gaW50ZXJmYWNlcyBhcmUgZWl0aGVyIGluIEdQSFkgKGkuZS4gY2xhdXNlIDIyKQ0KPj4+PiBv
ciAxMEdQSFkgbW9kZSAoaS5lLiBjbGF1c2UgNDUpLiBUaGlzIGRvZXMgbWVhbiB3ZSBjYW4ndCBz
dXBwb3J0IHN1cHBvcnQNCj4+Pj4gYm90aCBjNDUgYW5kIGMyMiBvbiB0aGUgc2FtZSBNRElPIGJ1
cyAod2hldGhlciB0aGF0J3Mgb25lIFBIWSB0aGF0DQo+Pj4+IHN1cHBvcnRzIGJvdGggb3IgdHdv
IGRpZmZlcmVudCBQSFlzKS4gSSdsbCBhZGQgYSBjb21tZW50IHRvIHRoYXQgZWZmZWN0DQo+Pj4+
IGFuZCBJIHNob3VsZCBwcm9iYWJseSBvbmx5IHByb3ZpZGUgYnVzLT5yZWFkL3dyaXRlIG9yDQo+
Pj4+IGJ1cy0+cmVhZF9jNDUvd3JpdGVfYzQ1IGRlcGVuZGluZyBvbiB0aGUgbW9kZS4NCj4+PiBJ
cyB0aGVyZSBtb3JlIHRvIGl0IHRoYW4gdGhpcz8gQmVjYXVzZSB3aHkgbm90IGp1c3Qgc2V0IHRo
ZSBtb2RlIHBlcg0KPj4+IGJ1cyB0cmFuc2FjdGlvbj8NCj4+IEl0J3MgYSBidXMgbGV2ZWwgc2V0
dGluZyBhdCBpbml0IHRpbWUuIFlvdSBjYW4ndCBkeW5hbWljYWxseSBzd2l0Y2ggbW9kZXMuDQo+
IFdoeSBub3Q/IFRoZSBidXMgaXMgb25seSBldmVyeSBkb2luZyBvbmUgdHJhbnNhY3Rpb24gYXQg
YSB0aW1lLCBzbyB3aHkNCj4gbm90IHN3aXRjaCBpdCBwZXIgdHJhbnNhY3Rpb24/DQoNCkknbSBw
cmV0dHkgc3VyZSBpdCB3b3VsZCB1cHNldCB0aGUgaGFyZHdhcmUgcG9sbGluZyBtZWNoYW5pc20g
d2hpY2ggDQp1bmZvcnR1bmF0ZWx5IHdlIGNhbid0IGRpc2FibGUgKGVhcmxpZXIgSSB0aG91Z2h0
IHdlIGNvdWxkIGJ1dCB0aGVyZSBhcmUgDQp2YXJpb3VzIHN3aXRjaCBmZWF0dXJlcyB0aGF0IHJl
bHkgb24gaXQpLg0K

