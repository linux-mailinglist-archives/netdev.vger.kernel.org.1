Return-Path: <netdev+bounces-102980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF7F905CEC
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 22:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9E6B21351
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 20:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD684D2C;
	Wed, 12 Jun 2024 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ki+tVRU6"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93B482FA
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718224788; cv=none; b=S6ptCdJAbyf4S0XWExWcAXLANsbyMKlnpNmzS0DrTKwJlAuVq8x4gUBMZRlfh+5zTqOHzZrM/Im9G6llVPUoWGNLwleEapdej7H8Tcwhl5HgS5v5lVQw4w5MEktJJt0CdpBV96SgZl6vOjTmT9pHgUZKKoPEBp6qyBxwFV5Hz/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718224788; c=relaxed/simple;
	bh=MBvZJBtPzLw/EBKRznQxfD/Rf2LONqVNSM90OIkC7kU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qlow7McHOAjWt42Ar8SFoLfnWEqXIZpWKxoJBNIQdxAVwkYs4s3EpKWzjG47gG4xy6+CRqYAElLWg+LgycZIYc108IeALJDUdmkhZMEejCPJdOM4sm1MK2i5qH+51tv0SPL4MyW23CNi+dJl2UArRwquUJwdyH8up/AdQVz7yEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ki+tVRU6; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B728D2C0343;
	Thu, 13 Jun 2024 08:39:37 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718224777;
	bh=MBvZJBtPzLw/EBKRznQxfD/Rf2LONqVNSM90OIkC7kU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ki+tVRU6RFVN7QCAZEv/SwCgpXRw8wafyAMzMU+DwxyLKYJN7M55eMDbXk6wPL/HZ
	 jRmCJ+Vnk21yRXeASZQbwRvdXaVc6LJARJSOfj4PuY05uhtQqRIbkN1X4y/kRBcxLY
	 88bBnYGo/AlMycXhsxm2OKZJDg4n8UsBtuWPAvdxsM7OJhbRlrx8uyP5I9vwzbTgAe
	 /ah0NQSoPRxTfS+ATgI+ABT8LmzSzr7GnFmZdgQeK+ZoH28GXVI4tdE5XRYPyopQm1
	 FJ9PGaIlHNicFA/DoF9M7Zs711RUWFLmOfED+b8kZUZMUk8AUoBKFUR7U9jNQfpYo2
	 JWjGIDNOMJgZw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B666a07890001>; Thu, 13 Jun 2024 08:39:37 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Jun 2024 08:39:37 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Thu, 13 Jun 2024 08:39:37 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ericwouds@gmail.com" <ericwouds@gmail.com>
Subject: Re: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
Thread-Topic: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
Thread-Index: AQHau8ECnGOzFCFnUUe89YjWXGoxMrHCPySAgACudYCAAOMCgA==
Date: Wed, 12 Jun 2024 20:39:37 +0000
Message-ID: <34d4b1e9-fb8a-4e50-acee-b089c168d164@alliedtelesis.co.nz>
References: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
 <c3d699a1-2f24-41c5-b0a7-65db025eedbc@alliedtelesis.co.nz>
 <20240612090707.7da3fc01@dellmb>
In-Reply-To: <20240612090707.7da3fc01@dellmb>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <F070FE5EE612334F97764E1F43CB3482@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=666a0789 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=kmH4_w4JlrKdn0nk7BcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAxMi8wNi8yNCAxOTowNywgTWFyZWsgQmVow7puIHdyb3RlOg0KPiBPbiBUdWUsIDExIEp1
biAyMDI0IDIwOjQyOjQzICswMDAwDQo+IENocmlzIFBhY2toYW0gPENocmlzLlBhY2toYW1AYWxs
aWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+DQo+PiArY2MgRXJpYyBXIGFuZCBNYXJlay4NCj4+
DQo+PiBPbiAxMS8wNi8yNCAxNzozNCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+PiBUaGUgUmVh
bHRlayBSVEw4MjI0IFBIWSBpcyBhIDIuNUdicHMgY2FwYWJsZSBQSFkuIEl0IG9ubHkgdXNlcyB0
aGUNCj4+PiBjbGF1c2UgNDUgTURJTyBpbnRlcmZhY2UgYW5kIGNhbiBsZXZlcmFnZSB0aGUgc3Vw
cG9ydCB0aGF0IGhhcyBhbHJlYWR5DQo+Pj4gYmVlbiBhZGRlZCBmb3IgdGhlIG90aGVyIDgyMngg
UEhZcy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2to
YW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+PiAtLS0NCj4+Pg0KPj4+IE5vdGVzOg0KPj4+ICAg
ICAgIEknbSBjdXJyZW50bHkgdGVzdGluZyB0aGlzIG9uIGFuIG9sZGVyIGtlcm5lbCBiZWNhdXNl
IHRoZSBib2FyZCBJJ20NCj4+PiAgICAgICB1c2luZyBoYXMgYSBTT0MvRFNBIHN3aXRjaCB0aGF0
IGhhcyBhIGRyaXZlciBpbiBvcGVud3J0IGZvciBMaW51eCA1LjE1Lg0KPj4+ICAgICAgIEkgaGF2
ZSB0cmllZCB0byBzZWxlY3RpdmVseSBiYWNrIHBvcnQgdGhlIGJpdHMgSSBuZWVkIGZyb20gdGhl
IG90aGVyDQo+Pj4gICAgICAgcnRsODIyeCB3b3JrIHNvIHRoaXMgc2hvdWxkIGJlIGFsbCB0aGF0
IGlzIHJlcXVpcmVkIGZvciB0aGUgcnRsODIyNC4NCj4+PiAgICAgICANCj4+PiAgICAgICBUaGVy
ZSdzIHF1aXRlIGEgbG90IHRoYXQgd291bGQgbmVlZCBmb3J3YXJkIHBvcnRpbmcgZ2V0IGEgd29y
a2luZyBzeXN0ZW0NCj4+PiAgICAgICBhZ2FpbnN0IGEgY3VycmVudCBrZXJuZWwgc28gaG9wZWZ1
bGx5IHRoaXMgaXMgc21hbGwgZW5vdWdoIHRoYXQgaXQgY2FuDQo+Pj4gICAgICAgbGFuZCB3aGls
ZSBJJ20gdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgaG93IHRvIHVudGFuZ2xlIGFsbCB0aGUgb3RoZXIg
Yml0cy4NCj4+PiAgICAgICANCj4+PiAgICAgICBPbmUgdGhpbmcgdGhhdCBtYXkgYXBwZWFyIGxh
Y2tpbmcgaXMgdGhlIGxhY2sgb2YgcmF0ZV9tYXRjaGluZyBzdXBwb3J0Lg0KPj4+ICAgICAgIEFj
Y29yZGluZyB0byB0aGUgZG9jdW1lbnRhdGlvbiBJIGhhdmUga25vdyB0aGUgaW50ZXJmYWNlIHVz
ZWQgb24gdGhlDQo+Pj4gICAgICAgUlRMODIyNCBpcyAocSl1eHNnbWlpIHNvIG5vIHJhdGUgbWF0
Y2hpbmcgaXMgcmVxdWlyZWQuIEFzIEknbSBzdGlsbA0KPj4+ICAgICAgIHRyeWluZyB0byBnZXQg
dGhpbmdzIGNvbXBsZXRlbHkgd29ya2luZyB0aGF0IG1heSBjaGFuZ2UgaWYgSSBnZXQgbmV3DQo+
Pj4gICAgICAgaW5mb3JtYXRpb24uDQo+Pj4NCj4+PiAgICBkcml2ZXJzL25ldC9waHkvcmVhbHRl
ay5jIHwgOCArKysrKysrKw0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykN
Cj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvcmVhbHRlay5jIGIvZHJpdmVy
cy9uZXQvcGh5L3JlYWx0ZWsuYw0KPj4+IGluZGV4IDdhYjQxZjk1ZGFlNS4uMjE3NDg5M2M5NzRm
IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9yZWFsdGVrLmMNCj4+PiArKysgYi9k
cml2ZXJzL25ldC9waHkvcmVhbHRlay5jDQo+Pj4gQEAgLTEzMTcsNiArMTMxNywxNCBAQCBzdGF0
aWMgc3RydWN0IHBoeV9kcml2ZXIgcmVhbHRla19kcnZzW10gPSB7DQo+Pj4gICAgCQkucmVzdW1l
ICAgICAgICAgPSBydGxnZW5fcmVzdW1lLA0KPj4+ICAgIAkJLnJlYWRfcGFnZSAgICAgID0gcnRs
ODIxeF9yZWFkX3BhZ2UsDQo+Pj4gICAgCQkud3JpdGVfcGFnZSAgICAgPSBydGw4MjF4X3dyaXRl
X3BhZ2UsDQo+Pj4gKwl9LCB7DQo+Pj4gKwkJUEhZX0lEX01BVENIX0VYQUNUKDB4MDAxY2NhZDAp
LA0KPj4+ICsJCS5uYW1lCQk9ICJSVEw4MjI0IDIuNUdicHMgUEhZIiwNCj4+PiArCQkuZ2V0X2Zl
YXR1cmVzICAgPSBydGw4MjJ4X2M0NV9nZXRfZmVhdHVyZXMsDQo+Pj4gKwkJLmNvbmZpZ19hbmVn
ICAgID0gcnRsODIyeF9jNDVfY29uZmlnX2FuZWcsDQo+Pj4gKwkJLnJlYWRfc3RhdHVzICAgID0g
cnRsODIyeF9jNDVfcmVhZF9zdGF0dXMsDQo+Pj4gKwkJLnN1c3BlbmQgICAgICAgID0gZ2VucGh5
X2M0NV9wbWFfc3VzcGVuZCwNCj4+PiArCQkucmVzdW1lICAgICAgICAgPSBydGxnZW5fYzQ1X3Jl
c3VtZSwNCj4+PiAgICAJfSwgew0KPj4+ICAgIAkJUEhZX0lEX01BVENIX0VYQUNUKDB4MDAxY2M5
NjEpLA0KPj4+ICAgIAkJLm5hbWUJCT0gIlJUTDgzNjZSQiBHaWdhYml0IEV0aGVybmV0Ig0KPiBE
b24ndCB5b3UgbmVlZCBydGw4MjJ4Yl9jb25maWdfaW5pdCBmb3Igc2VyZGVzIGNvbmZpZ3VyYXRp
b24/DQoNCkkgbW9yZSB0aGFuIGxpa2VseSBuZWVkIGEgY29uZmlnX2luaXQoKSBmdW5jdGlvbi4g
SSdtIHdvcmtpbmcgd2l0aCANCmluY29tcGxldGUgZGF0YXNoZWV0cyBzbyBJJ20gbm90IHN1cmUg
aWYgcnRsODIyeGJfY29uZmlnX2luaXQoKSB3aWxsIA0Kd29yayBmb3IgbWUgKGlmIGFueW9uZSBo
YXMgYSBjb250YWN0IGF0IFJlYWx0ZWsgSSdkIGxpa2UgdG8gaGVhciBmcm9tIA0KeW91KS4gVGhl
IE1BQy1QSFkgaW50ZXJmYWNlIG9uIHRoZSBSVEw4MjI0IGlzIHF1c3hnbWlpIGFuZCANCnJ0bDgy
MnhiX2NvbmZpZ19pbml0KCkgc2VlbXMgdG8gb25seSBjYXRlciBmb3IgMjUwMGJhc2UteCBvciBo
c2dtaWkgc28gSSANCnRoaW5rIEkgd2lsbCBuZWVkIGEgZGlmZmVyZW50IGNvbmZpZ19pbml0KCkg
YnV0IHF1aXRlIHdoYXQgdGhhdCBsb29rcyANCmxpa2UgSSdtIG5vdCBzdXJlLg0KDQpUaGF0J3Mg
YWxzbyB3aGVyZSBJIHN0YXJ0IHJ1bm5pbmcgaW50byB0aGUgYmFja3BvcnRpbmcgcHJvYmxlbSBi
ZWNhdXNlIA0KdGhlIHJ0bDgyMnhiX2NvbmZpZ19pbml0KCkgZGVjaWRlcyB0aGUgbW9kZSBiYXNl
ZCBvbiB0aGUgaG9zdF9pbnRlcmZhY2VzIA0Kd2hpY2ggZG9lc24ndCBleGlzdCBpbiB0aGUga2Vy
bmVsIEkgaGF2ZSBkc2EgZHJpdmVycyBmb3IuIEkgZG8gcGxhbiBvbiANCnRyeWluZyB0byBicmlu
ZyB0aGUgY29kZSBJIGhhdmUgZm9yd2FyZCBidXQgdGhlcmUncyBxdWl0ZSBhIGxvdCBJIG5lZWQg
DQp0byBzaWZ0IHRocm91Z2guDQo=

