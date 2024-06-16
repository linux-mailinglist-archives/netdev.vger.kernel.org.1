Return-Path: <netdev+bounces-103890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C153E909FE9
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 23:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519951F2161D
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 21:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A76F61FF8;
	Sun, 16 Jun 2024 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xe0BnzwX"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1645012
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718573099; cv=none; b=iW1L8LB6ci6hx7Xxkqz/Y2tiBDzC0pSye/E+0/ABjoADk5zwaX76KfdvQ0oPXqbgRWz8Z4IT5Ir5Uy5LsbVt19BPQSZS003zdvsGzFFQwUDcBZybXo2A8/rqvUO/B+/4Hf4n7xoD8xE3/wOn3k0BwsTTMOXl3wvFcjAND18QQqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718573099; c=relaxed/simple;
	bh=oed5q12Dnf+GZwEKoRPOF0JgztgySspTotVcChSH5rk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MXZz60dDk0KjCS/xSPQGnOHh4mCxNbWfYtx45gpoNTmoCPlO9Th+UstgfUWt+RMvDUwWRFDCQOsgE2jIXxGmkWU91vmpTubelH7VcR1hg4wWrKzRogf5w6yDGV8Y1/OwhRSSw1TNbPxhRhPt5q0fU4TSRqw5A9lTaTM4k+lTx/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=xe0BnzwX; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A5EC72C0715;
	Mon, 17 Jun 2024 09:24:54 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718573094;
	bh=oed5q12Dnf+GZwEKoRPOF0JgztgySspTotVcChSH5rk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=xe0BnzwXY8QBai4TE6xHLjOL+iTK/c5lNaYwHOKCXf4QJBSHdx29uSqA8o5+y1GX6
	 OSpxCIy2CVQ0xPxZUYdYwqAZq2pLJJBtmXPVtofFVTOoMZhZKlQxV34qpjR777fGQH
	 rZ4zj4va/TaqHNoVIn3eDxenE2wprsmMrybuLZef5ebvZvJILpiM5decRWoLwmycAq
	 mb0FNAZ3wNsfQloG8csPJLD3K8cNfrGIiwwRjqRShFbGFH9DH2/HThUmKezDGJ0Ft4
	 Q9RnDPkdWDFDrIBCzUr6jjQoSeA1CqgtIu0hEdKgaGK8MVU0KaQn7NMbUfjAgZDaGd
	 bWwKB1hLc7PWg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B666f58260001>; Mon, 17 Jun 2024 09:24:54 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Mon, 17 Jun 2024 09:24:54 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Mon, 17 Jun 2024 09:24:54 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Mon, 17 Jun 2024 09:24:54 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ericwouds@gmail.com" <ericwouds@gmail.com>
Subject: Re: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
Thread-Topic: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
Thread-Index: AQHau8ECnGOzFCFnUUe89YjWXGoxMrHCPySAgACudYCAAzivgIAAAgIAgAP+SoA=
Date: Sun, 16 Jun 2024 21:24:53 +0000
Message-ID: <e9a2b30f-71a1-4e3d-9754-a5d505ca6705@alliedtelesis.co.nz>
References: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
 <c3d699a1-2f24-41c5-b0a7-65db025eedbc@alliedtelesis.co.nz>
 <20240612090707.7da3fc01@dellmb>
 <fbf2be8d31579d1c9305fd961751fc6f0a4b4556.camel@redhat.com>
 <20240614102558.32dcba79@dellmb>
In-Reply-To: <20240614102558.32dcba79@dellmb>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EE4D973FE2838408817F70612CA035E@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=666f5826 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=20KFwNOVAAAA:8 a=o0eJSq36658fNMJjsx8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAxNC8wNi8yNCAyMDoyNSwgTWFyZWsgQmVow7puIHdyb3RlOg0KPiBPbiBGcmksIDE0IEp1
biAyMDI0IDEwOjE4OjQ3ICswMjAwDQo+IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4g
d3JvdGU6DQo+DQo+PiBPbiBXZWQsIDIwMjQtMDYtMTIgYXQgMDk6MDcgKzAyMDAsIE1hcmVrIEJl
aMO6biB3cm90ZToNCj4+PiBPbiBUdWUsIDExIEp1biAyMDI0IDIwOjQyOjQzICswMDAwDQo+Pj4g
Q2hyaXMgUGFja2hhbSA8Q2hyaXMuUGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56PiB3cm90ZToN
Cj4+PiAgICANCj4+Pj4gK2NjIEVyaWMgVyBhbmQgTWFyZWsuDQo+Pj4+DQo+Pj4+IE9uIDExLzA2
LzI0IDE3OjM0LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4+Pj4gVGhlIFJlYWx0ZWsgUlRMODIy
NCBQSFkgaXMgYSAyLjVHYnBzIGNhcGFibGUgUEhZLiBJdCBvbmx5IHVzZXMgdGhlDQo+Pj4+PiBj
bGF1c2UgNDUgTURJTyBpbnRlcmZhY2UgYW5kIGNhbiBsZXZlcmFnZSB0aGUgc3VwcG9ydCB0aGF0
IGhhcyBhbHJlYWR5DQo+Pj4+PiBiZWVuIGFkZGVkIGZvciB0aGUgb3RoZXIgODIyeCBQSFlzLg0K
Pj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1A
YWxsaWVkdGVsZXNpcy5jby5uej4NCj4+Pj4+IC0tLQ0KPj4+Pj4NCj4+Pj4+IE5vdGVzOg0KPj4+
Pj4gICAgICAgSSdtIGN1cnJlbnRseSB0ZXN0aW5nIHRoaXMgb24gYW4gb2xkZXIga2VybmVsIGJl
Y2F1c2UgdGhlIGJvYXJkIEknbQ0KPj4+Pj4gICAgICAgdXNpbmcgaGFzIGEgU09DL0RTQSBzd2l0
Y2ggdGhhdCBoYXMgYSBkcml2ZXIgaW4gb3BlbndydCBmb3IgTGludXggNS4xNS4NCj4+Pj4+ICAg
ICAgIEkgaGF2ZSB0cmllZCB0byBzZWxlY3RpdmVseSBiYWNrIHBvcnQgdGhlIGJpdHMgSSBuZWVk
IGZyb20gdGhlIG90aGVyDQo+Pj4+PiAgICAgICBydGw4MjJ4IHdvcmsgc28gdGhpcyBzaG91bGQg
YmUgYWxsIHRoYXQgaXMgcmVxdWlyZWQgZm9yIHRoZSBydGw4MjI0Lg0KPj4+Pj4gICAgICAgDQo+
Pj4+PiAgICAgICBUaGVyZSdzIHF1aXRlIGEgbG90IHRoYXQgd291bGQgbmVlZCBmb3J3YXJkIHBv
cnRpbmcgZ2V0IGEgd29ya2luZyBzeXN0ZW0NCj4+Pj4+ICAgICAgIGFnYWluc3QgYSBjdXJyZW50
IGtlcm5lbCBzbyBob3BlZnVsbHkgdGhpcyBpcyBzbWFsbCBlbm91Z2ggdGhhdCBpdCBjYW4NCj4+
Pj4+ICAgICAgIGxhbmQgd2hpbGUgSSdtIHRyeWluZyB0byBmaWd1cmUgb3V0IGhvdyB0byB1bnRh
bmdsZSBhbGwgdGhlIG90aGVyIGJpdHMuDQo+Pj4+PiAgICAgICANCj4+Pj4+ICAgICAgIE9uZSB0
aGluZyB0aGF0IG1heSBhcHBlYXIgbGFja2luZyBpcyB0aGUgbGFjayBvZiByYXRlX21hdGNoaW5n
IHN1cHBvcnQuDQo+Pj4+PiAgICAgICBBY2NvcmRpbmcgdG8gdGhlIGRvY3VtZW50YXRpb24gSSBo
YXZlIGtub3cgdGhlIGludGVyZmFjZSB1c2VkIG9uIHRoZQ0KPj4+Pj4gICAgICAgUlRMODIyNCBp
cyAocSl1eHNnbWlpIHNvIG5vIHJhdGUgbWF0Y2hpbmcgaXMgcmVxdWlyZWQuIEFzIEknbSBzdGls
bA0KPj4+Pj4gICAgICAgdHJ5aW5nIHRvIGdldCB0aGluZ3MgY29tcGxldGVseSB3b3JraW5nIHRo
YXQgbWF5IGNoYW5nZSBpZiBJIGdldCBuZXcNCj4+Pj4+ICAgICAgIGluZm9ybWF0aW9uLg0KPj4+
Pj4NCj4+Pj4+ICAgIGRyaXZlcnMvbmV0L3BoeS9yZWFsdGVrLmMgfCA4ICsrKysrKysrDQo+Pj4+
PiAgICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9yZWFsdGVrLmMgYi9kcml2ZXJzL25ldC9waHkvcmVhbHRl
ay5jDQo+Pj4+PiBpbmRleCA3YWI0MWY5NWRhZTUuLjIxNzQ4OTNjOTc0ZiAxMDA2NDQNCj4+Pj4+
IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9yZWFsdGVrLmMNCj4+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0
L3BoeS9yZWFsdGVrLmMNCj4+Pj4+IEBAIC0xMzE3LDYgKzEzMTcsMTQgQEAgc3RhdGljIHN0cnVj
dCBwaHlfZHJpdmVyIHJlYWx0ZWtfZHJ2c1tdID0gew0KPj4+Pj4gICAgCQkucmVzdW1lICAgICAg
ICAgPSBydGxnZW5fcmVzdW1lLA0KPj4+Pj4gICAgCQkucmVhZF9wYWdlICAgICAgPSBydGw4MjF4
X3JlYWRfcGFnZSwNCj4+Pj4+ICAgIAkJLndyaXRlX3BhZ2UgICAgID0gcnRsODIxeF93cml0ZV9w
YWdlLA0KPj4+Pj4gKwl9LCB7DQo+Pj4+PiArCQlQSFlfSURfTUFUQ0hfRVhBQ1QoMHgwMDFjY2Fk
MCksDQo+Pj4+PiArCQkubmFtZQkJPSAiUlRMODIyNCAyLjVHYnBzIFBIWSIsDQo+Pj4+PiArCQku
Z2V0X2ZlYXR1cmVzICAgPSBydGw4MjJ4X2M0NV9nZXRfZmVhdHVyZXMsDQo+Pj4+PiArCQkuY29u
ZmlnX2FuZWcgICAgPSBydGw4MjJ4X2M0NV9jb25maWdfYW5lZywNCj4+Pj4+ICsJCS5yZWFkX3N0
YXR1cyAgICA9IHJ0bDgyMnhfYzQ1X3JlYWRfc3RhdHVzLA0KPj4+Pj4gKwkJLnN1c3BlbmQgICAg
ICAgID0gZ2VucGh5X2M0NV9wbWFfc3VzcGVuZCwNCj4+Pj4+ICsJCS5yZXN1bWUgICAgICAgICA9
IHJ0bGdlbl9jNDVfcmVzdW1lLA0KPj4+Pj4gICAgCX0sIHsNCj4+Pj4+ICAgIAkJUEhZX0lEX01B
VENIX0VYQUNUKDB4MDAxY2M5NjEpLA0KPj4+Pj4gICAgCQkubmFtZQkJPSAiUlRMODM2NlJCIEdp
Z2FiaXQgRXRoZXJuZXQiDQo+Pj4gRG9uJ3QgeW91IG5lZWQgcnRsODIyeGJfY29uZmlnX2luaXQg
Zm9yIHNlcmRlcyBjb25maWd1cmF0aW9uPw0KPj4gTWFyZWssIEkgcmVhZCB0aGUgYWJvdmUgYXMg
eW91IHdvdWxkIHByZWZlciB0byBoYXZlIHN1Y2ggc3VwcG9ydA0KPj4gaW5jbHVkZWQgZnJvbSB0
aGUgYmVnaW5uaW5nLCBhcyBzdWNoIEknbSBsb29raW5nIGZvcndhcmQgYSBuZXcgdmVyc2lvbg0K
Pj4gb2YgdGhpcyBwYXRjaC4NCj4+DQo+PiBQbGVhc2UgcmFpc2UgYSBoYW5kIGlmIEkgcmVhZCB0
b28gbXVjaCBpbiB5b3VyIHJlcGx5Lg0KPiBJIGFtIHJhaXNpbmcgbXkgaGFuZCA6KSBJIGp1c3Qg
d2FudGVkIHRvIHBvaW50IGl0IG91dC4NCj4gSWYgdGhpcyBjb2RlIHdvcmtzIGZvciBDaHJpcycg
aGFyZHdhcmUsIGl0IGlzIG9rYXkgZXZlbiB3aXRob3V0IHRoZQ0KPiAuY29uZmlnX2luaXQuDQoN
CkkgZGlkIGxvb2sgaW50byB0aGlzLiBUaGUgU0VSREVTIGNvbmZpZ3VyYXRpb24gc2VlbXMgdG8g
YmUgZGlmZmVyZW50IA0KYmV0d2VlbiB0aGUgUlRMODIyMSBhbmQgUlRMODIyNC4gSSB0aGluayB0
aGF0IG1pZ2h0IGJlIGJlY2F1c2UgdGhlIA0KUlRMODIyMSBjYW4gZG8gYSBmZXcgZGlmZmVyZW50
IGhvc3QgaW50ZXJmYWNlcyB3aGVyZWFzIHRoZSBSVEw4MjI0IGlzIA0KcmVhbGx5IG9ubHkgVVNY
R01JSS4gVGhlcmUgYXJlIHNvbWUgY29uZmlndXJhYmxlIHBhcmFtZXRlcnMgYnV0IHRoZXkgDQph
cHBlYXIgdG8gYmUgZG9uZSBkaWZmZXJlbnRseS4NCg0KSGF2aW5nIHNhaWQgdGhhdCBJIGRlZmlu
aXRlbHkgZG9uJ3QgaGF2ZSBhIHN5c3RlbSB3b3JraW5nIGVuZCB0byBlbmQuIEkgDQprbm93IHRo
ZSBsaW5lIHNpZGUgc3R1ZmYgaXMgd29ya2luZyB3ZWxsIChhdXRvLW5lZ290aWF0aW5nIHNwZWVk
cyBmcm9tIA0KMTBNIHRvIDIuNUIpIGJ1dCBJJ20gbm90IGdldHRpbmcgYW55dGhpbmcgb24gdGhl
IGhvc3Qgc2lkZS4gSSdtIG5vdCBzdXJlIA0KaWYgdGhhdCdzIGEgcHJvYmxlbSB3aXRoIHRoZSBz
d2l0Y2ggZHJpdmVyIG9yIHdpdGggdGhlIFBIWS4NCg0KSSdkIGxpa2UgdGhpcyB0byBnbyBpbiBh
cyBpdCBzaG91bGRuJ3QgcmVncmVzcyBhbnl0aGluZyBidXQgSSBjYW4gDQp1bmRlcnN0YW5kIGlm
IHRoZSBiYXIgaXMgIm5lZWRzIHRvIGJlIDEwMCUgd29ya2luZyIgSSdsbCBqdXN0IGhhdmUgdG8g
DQpjYXJyeSB0aGlzIGxvY2FsbHkgdW50aWwgSSBjYW4gYmUgc3VyZS4NCg==

