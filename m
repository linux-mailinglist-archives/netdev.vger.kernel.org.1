Return-Path: <netdev+bounces-102717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5619045E3
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BBCB22478
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F4E152533;
	Tue, 11 Jun 2024 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="A+TABI7s"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC315250A
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138569; cv=none; b=rmkKUfw7ITMT7swdfFK5qwYZrdXQhEvN6IXAN3+eCOXaBg7cWwq3bwfr7YV/a/+EsF+dQ6ycXsKgRFzKgjkwF94VURQuDI+2UUCBnSpWtc3ipuPuEsVR0/MmirhYEVSdQ0Eevr8Q6CsMnE4Sw3zdnwLahP6dIFhS+ekGGXUIFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138569; c=relaxed/simple;
	bh=dxtVQ9ghcpp7bsx3aChn8pSuHxgJySVYGM26ugBSVjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SMOJ++1iqEAK6hzMy5wEhOlVbVKrv2Fj1Y5UAssJlu/IvzNatZRWNmj4wEkJ20GtQSC7FbnP0fuCcT7is2N4FdKr6HYKJmbpBbZQ1LYqsqxsu22wy5tNeIG1M2DUUkm8wNsPxlirM9xdj5MP35js1qMNxAFDTEIqZk4taPD3Exg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=A+TABI7s; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2EA972C0980;
	Wed, 12 Jun 2024 08:42:44 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718138564;
	bh=dxtVQ9ghcpp7bsx3aChn8pSuHxgJySVYGM26ugBSVjM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=A+TABI7s7QXoJKk0UshzV7B2sy0UMidOCB1damG4YhBwVSNpQ/X0BqYz8p0OoZLmO
	 uVn0E7/T0LO+Q/hLQfcAYIqHzcrvyk0gn/ogU8ouRwgErXT11NwvW19JrPwkr24MSv
	 4zr2IJ0dxJr/JKfHMHchhbbdoetBgniBBUPEOcB2VC8Tlf/twOs6xvQEJD3kJ2kmB+
	 HLA7ci9YCvjc4EQuZbCg2ec1oiqzpqNMU9NeWJsZMOlTcMFOtkYObVuYl++WHqW2o/
	 A43LPPzmhj75MRDERl5jHbVjzhxjUVYGsXyOsr0iKMGvMbWu0V6fhqyUPNCz746QGX
	 x6Umh14y7ZbeQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6668b6c40001>; Wed, 12 Jun 2024 08:42:44 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Wed, 12 Jun 2024 08:42:43 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 12 Jun 2024 08:42:43 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Wed, 12 Jun 2024 08:42:43 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ericwouds@gmail.com" <ericwouds@gmail.com>, =?utf-8?B?TWFyZWsgQmVow7pu?=
	<kabel@kernel.org>
Subject: Re: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
Thread-Topic: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
Thread-Index: AQHau8ECnGOzFCFnUUe89YjWXGoxMrHCPySA
Date: Tue, 11 Jun 2024 20:42:43 +0000
Message-ID: <c3d699a1-2f24-41c5-b0a7-65db025eedbc@alliedtelesis.co.nz>
References: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4D44278CE5E0C44AA91A68C3D659BA3@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=6668b6c4 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=oaWfbxmcstGepVewQGkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

K2NjIEVyaWMgVyBhbmQgTWFyZWsuDQoNCk9uIDExLzA2LzI0IDE3OjM0LCBDaHJpcyBQYWNraGFt
IHdyb3RlOg0KPiBUaGUgUmVhbHRlayBSVEw4MjI0IFBIWSBpcyBhIDIuNUdicHMgY2FwYWJsZSBQ
SFkuIEl0IG9ubHkgdXNlcyB0aGUNCj4gY2xhdXNlIDQ1IE1ESU8gaW50ZXJmYWNlIGFuZCBjYW4g
bGV2ZXJhZ2UgdGhlIHN1cHBvcnQgdGhhdCBoYXMgYWxyZWFkeQ0KPiBiZWVuIGFkZGVkIGZvciB0
aGUgb3RoZXIgODIyeCBQSFlzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxj
aHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+IC0tLQ0KPg0KPiBOb3RlczoNCj4g
ICAgICBJJ20gY3VycmVudGx5IHRlc3RpbmcgdGhpcyBvbiBhbiBvbGRlciBrZXJuZWwgYmVjYXVz
ZSB0aGUgYm9hcmQgSSdtDQo+ICAgICAgdXNpbmcgaGFzIGEgU09DL0RTQSBzd2l0Y2ggdGhhdCBo
YXMgYSBkcml2ZXIgaW4gb3BlbndydCBmb3IgTGludXggNS4xNS4NCj4gICAgICBJIGhhdmUgdHJp
ZWQgdG8gc2VsZWN0aXZlbHkgYmFjayBwb3J0IHRoZSBiaXRzIEkgbmVlZCBmcm9tIHRoZSBvdGhl
cg0KPiAgICAgIHJ0bDgyMnggd29yayBzbyB0aGlzIHNob3VsZCBiZSBhbGwgdGhhdCBpcyByZXF1
aXJlZCBmb3IgdGhlIHJ0bDgyMjQuDQo+ICAgICAgDQo+ICAgICAgVGhlcmUncyBxdWl0ZSBhIGxv
dCB0aGF0IHdvdWxkIG5lZWQgZm9yd2FyZCBwb3J0aW5nIGdldCBhIHdvcmtpbmcgc3lzdGVtDQo+
ICAgICAgYWdhaW5zdCBhIGN1cnJlbnQga2VybmVsIHNvIGhvcGVmdWxseSB0aGlzIGlzIHNtYWxs
IGVub3VnaCB0aGF0IGl0IGNhbg0KPiAgICAgIGxhbmQgd2hpbGUgSSdtIHRyeWluZyB0byBmaWd1
cmUgb3V0IGhvdyB0byB1bnRhbmdsZSBhbGwgdGhlIG90aGVyIGJpdHMuDQo+ICAgICAgDQo+ICAg
ICAgT25lIHRoaW5nIHRoYXQgbWF5IGFwcGVhciBsYWNraW5nIGlzIHRoZSBsYWNrIG9mIHJhdGVf
bWF0Y2hpbmcgc3VwcG9ydC4NCj4gICAgICBBY2NvcmRpbmcgdG8gdGhlIGRvY3VtZW50YXRpb24g
SSBoYXZlIGtub3cgdGhlIGludGVyZmFjZSB1c2VkIG9uIHRoZQ0KPiAgICAgIFJUTDgyMjQgaXMg
KHEpdXhzZ21paSBzbyBubyByYXRlIG1hdGNoaW5nIGlzIHJlcXVpcmVkLiBBcyBJJ20gc3RpbGwN
Cj4gICAgICB0cnlpbmcgdG8gZ2V0IHRoaW5ncyBjb21wbGV0ZWx5IHdvcmtpbmcgdGhhdCBtYXkg
Y2hhbmdlIGlmIEkgZ2V0IG5ldw0KPiAgICAgIGluZm9ybWF0aW9uLg0KPg0KPiAgIGRyaXZlcnMv
bmV0L3BoeS9yZWFsdGVrLmMgfCA4ICsrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsuYyBi
L2RyaXZlcnMvbmV0L3BoeS9yZWFsdGVrLmMNCj4gaW5kZXggN2FiNDFmOTVkYWU1Li4yMTc0ODkz
Yzk3NGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9yZWFsdGVrLmMNCj4gKysrIGIv
ZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsuYw0KPiBAQCAtMTMxNyw2ICsxMzE3LDE0IEBAIHN0YXRp
YyBzdHJ1Y3QgcGh5X2RyaXZlciByZWFsdGVrX2RydnNbXSA9IHsNCj4gICAJCS5yZXN1bWUgICAg
ICAgICA9IHJ0bGdlbl9yZXN1bWUsDQo+ICAgCQkucmVhZF9wYWdlICAgICAgPSBydGw4MjF4X3Jl
YWRfcGFnZSwNCj4gICAJCS53cml0ZV9wYWdlICAgICA9IHJ0bDgyMXhfd3JpdGVfcGFnZSwNCj4g
Kwl9LCB7DQo+ICsJCVBIWV9JRF9NQVRDSF9FWEFDVCgweDAwMWNjYWQwKSwNCj4gKwkJLm5hbWUJ
CT0gIlJUTDgyMjQgMi41R2JwcyBQSFkiLA0KPiArCQkuZ2V0X2ZlYXR1cmVzICAgPSBydGw4MjJ4
X2M0NV9nZXRfZmVhdHVyZXMsDQo+ICsJCS5jb25maWdfYW5lZyAgICA9IHJ0bDgyMnhfYzQ1X2Nv
bmZpZ19hbmVnLA0KPiArCQkucmVhZF9zdGF0dXMgICAgPSBydGw4MjJ4X2M0NV9yZWFkX3N0YXR1
cywNCj4gKwkJLnN1c3BlbmQgICAgICAgID0gZ2VucGh5X2M0NV9wbWFfc3VzcGVuZCwNCj4gKwkJ
LnJlc3VtZSAgICAgICAgID0gcnRsZ2VuX2M0NV9yZXN1bWUsDQo+ICAgCX0sIHsNCj4gICAJCVBI
WV9JRF9NQVRDSF9FWEFDVCgweDAwMWNjOTYxKSwNCj4gICAJCS5uYW1lCQk9ICJSVEw4MzY2UkIg
R2lnYWJpdCBFdGhlcm5ldCIs

