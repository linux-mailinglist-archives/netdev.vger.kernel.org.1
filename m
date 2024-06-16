Return-Path: <netdev+bounces-103889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E83909FE2
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 23:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6FE1C20CC4
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258064EB37;
	Sun, 16 Jun 2024 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="bPQdGAts"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225778462
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718572456; cv=none; b=ch94cWXL3ql/b9VNPDrj0/jeXYOAFCLX9JYhXiWgsG9XCHF2ZMiuqYx2K531fiKCwkj3qr2P0QS/Fq0siPDjDEXxebnpi2yrAhAkkGxWn2biHDNRNYDtMt27Y0CBRa6MMsJkof0DpbctRzzU8sknM7iHSmCEB3PWFRlhfDA0h9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718572456; c=relaxed/simple;
	bh=RljPixz4LK3wOuIgx5zCj+X0kl/BwDaQMWxZHI/1eWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X5DJ16KVJJx/A4hCxvxipDdO/aBXBJY/OGHE7erGZXwhWZuNVEvwHPWR195AsjGspppOmQ3Po2rfg7jePNE09BwiCBQS96phPUnfKRh6EEby9Ny9mtv1vXmUQJvpYg5lKn94RFzaxzUVdS+3w07PWFA60RRNRGIG2i4BFwOGCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=bPQdGAts; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7BEC92C0715;
	Mon, 17 Jun 2024 09:14:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718572445;
	bh=RljPixz4LK3wOuIgx5zCj+X0kl/BwDaQMWxZHI/1eWc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=bPQdGAtsSX1zSlZVc/3Rdga/b9kAd7DCzHWJM18xW0/hInYKVR05U78L7TAxblUMx
	 UBVbO/VO0viFmxcSYoU8tZqdDTx/zD5mZgxuTrhK7HXm4ms4RV3MSE29ximiLo7Ogs
	 D0taFG6tgcmUW523mCr/MQp/iqVimO0fW98aTBY5IBjx/rO3UOqORnB2mj4CrTH/0I
	 tqgUoKpiYUdEoXysXfCeaRbdei0RNsrcz/qbmUVvQ+5PrkQQTv7fG0pckBZYtNR7fg
	 ka5KfXJ2N6MgA8bI3DjDkuoSt3CW3bup4L3YPYOoSnSdurRS64SO0ap5wInw1JlDFJ
	 CEx9I3GypOv7w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B666f559d0001>; Mon, 17 Jun 2024 09:14:05 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Mon, 17 Jun 2024 09:14:05 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Mon, 17 Jun 2024 09:14:05 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Mon, 17 Jun 2024 09:14:04 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Linus Walleij
	<linus.walleij@linaro.org>
CC: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, =?utf-8?B?TWFyZWsgQmVow7pu?=
	<kabel@kernel.org>, "ericwouds@gmail.com" <ericwouds@gmail.com>, David Miller
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "justinstitt@google.com"
	<justinstitt@google.com>, "rmk+kernel@armlinux.org.uk"
	<rmk+kernel@armlinux.org.uk>, netdev <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: net: dsa: Realtek switch drivers
Thread-Topic: net: dsa: Realtek switch drivers
Thread-Index: AQHavf0bnp2fEmABNEu2NcsQo6lz5bHGCICAgAD4MoCAAx5kAA==
Date: Sun, 16 Jun 2024 21:14:04 +0000
Message-ID: <891153fe-8f92-48b3-aa65-655a961448cc@alliedtelesis.co.nz>
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
 <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
 <CAJq09z6dN0TkxxjmXT6yui8ydRUPTLcpFHyeExq_41RmSDdaHg@mail.gmail.com>
In-Reply-To: <CAJq09z6dN0TkxxjmXT6yui8ydRUPTLcpFHyeExq_41RmSDdaHg@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <864FB839F84D7D44848F6AF08BF12C9D@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=666f559d a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=VwQbUJbxAAAA:8 a=l7AzUe4WSKfLcy4FgSgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=hPAN1OI7KfYA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0

DQpPbiAxNS8wNi8yNCAwOTozNiwgTHVpeiBBbmdlbG8gRGFyb3MgZGUgTHVjYSB3cm90ZToNCj4g
SGVsbG8gQ2hyaXMgYW5kIExpbnVzLA0KPg0KPj4+IEknbSBzdGFydGluZyB0byBsb29rIGF0IHNv
bWUgTDIvTDMgc3dpdGNoZXMgd2l0aCBSZWFsdGVrIHNpbGljb24uIEkgc2VlDQo+Pj4gaW4gdGhl
IHVwc3RyZWFtIGtlcm5lbCB0aGVyZSBhcmUgZHNhIGRyaXZlcnMgZm9yIGEgY291cGxlIG9mIHNp
bXBsZSBMMg0KPj4+IHN3aXRjaGVzLiBXaGlsZSBvcGVud3J0IGhhcyBzdXBwb3J0IGZvciBhIGxv
dCBvZiB0aGUgbW9yZSBhZHZhbmNlZA0KPj4+IHNpbGljb24uIEknbSBqdXN0IHdvbmRlcmluZyBp
ZiB0aGVyZSBpcyBhIHBhcnRpY3VsYXIgcmVhc29uIG5vLW9uZSBoYXMNCj4+PiBhdHRlbXB0ZWQg
dG8gdXBzdHJlYW0gc3VwcG9ydCBmb3IgdGhlc2Ugc3dpdGNoZXM/DQo+PiBJdCBiZWdhbiB3aXRo
IHRoZSBSVEw4MzY2UkIgKCJSVEw4MzY2IHJldmlzaW9uIEIiKSB3aGljaCBJIHRoaW5rIGlzDQo+
PiBlcXVpdmFsZW50IHRvIFJUTDgzNjZTIGFzIHdlbGwsIGJ1dCBoYXZlIG5vdCBiZWVuIGFibGUg
dG8gdGVzdC4NCj4+DQo+PiBUaGVuIEx1aXogYW5kIEFsdmluIGp1bXBlZCBpbiBhbmQgZml4ZWQg
dXAgdGhlIFJUTDgzNjVNQiBmYW1pbHkuDQo+Pg0KPj4gU28gdGhlIHN1cHBvcnQgaXMgcHJldHR5
IG11Y2ggd2hhdCBpcyBzdGF0ZWQgaW4gdGhlIERUIGJpbmRpbmdzDQo+PiBpbiBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2RzYS9yZWFsdGVrLnlhbWw6DQo+Pg0KPj4gcHJv
cGVydGllczoNCj4+ICAgIGNvbXBhdGlibGU6DQo+PiAgICAgIGVudW06DQo+PiAgICAgICAgLSBy
ZWFsdGVrLHJ0bDgzNjVtYg0KPj4gICAgICAgIC0gcmVhbHRlayxydGw4MzY2cmINCj4+ICAgICAg
ZGVzY3JpcHRpb246IHwNCj4+ICAgICAgICByZWFsdGVrLHJ0bDgzNjVtYjoNCj4+ICAgICAgICAg
IFVzZSB3aXRoIG1vZGVscyBSVEw4MzYzTkIsIFJUTDgzNjNOQi1WQiwgUlRMODM2M1NDLCBSVEw4
MzYzU0MtVkIsDQo+PiAgICAgICAgICBSVEw4MzY0TkIsIFJUTDgzNjROQi1WQiwgUlRMODM2NU1C
LCBSVEw4MzY2U0MsIFJUTDgzNjdSQi1WQiwgUlRMODM2N1MsDQo+PiAgICAgICAgICBSVEw4MzY3
U0IsIFJUTDgzNzBNQiwgUlRMODMxMFNSDQo+PiAgICAgICAgcmVhbHRlayxydGw4MzY2cmI6DQo+
PiAgICAgICAgICBVc2Ugd2l0aCBtb2RlbHMgUlRMODM2NlJCLCBSVEw4MzY2Uw0KPj4NCj4+IEl0
IG1heSBsb29rIGxpa2UganVzdCBSVEw4MzY1IGFuZCBSVEw4MzY2IG9uIHRoZSBzdXJmYWNlIGJ1
dCB0aGUgc3ViLXZlcnNpb24NCj4+IGlzIGRldGVjdGVkIGF0IHJ1bnRpbWUuDQo+Pg0KPj4+IElm
IEkgd2VyZSB0byBzdGFydA0KPj4+IGdyYWJiaW5nIGRyaXZlcnMgZnJvbSBvcGVud3J0IGFuZCB0
cnlpbmcgdG8gZ2V0IHRoZW0gbGFuZGVkIHdvdWxkIHRoYXQNCj4+PiBiZSBhIHByb2JsZW0/DQo+
PiBJIHRoaW5rIHRoZSBiYXNlIGlzIHRoZXJlLCB3aGVuIEkgc3RhcnRlZCB3aXRoIFJUTDgzNjZS
QiBpdCB3YXMgcHJldHR5DQo+PiB1cGhpbGwgYnV0IHRoZSBrZXJuZWwgRFNBIGV4cGVydHMgKFZs
YWRpbWlyICYgQW5kcmV3IGVzcGVjaWFsbHkpIGFyZSBzdXBlcg0KPj4gaGVscGZ1bCBzbyBldmVu
dHVhbGx5IHdlIGhhdmUgYXJyaXZlZCBhdCBzb21ldGhpbmcgdGhhdCB3b3JrcyByZWFzb25hYmx5
Lg0KPj4NCj4+IFRoZSBSVEw4MzU2TUItZmFtaWx5IGRyaXZlciBpcyBtb3JlIGFkdmFuY2VkIGFu
ZCBoYXMgYSBsb3QgbW9yZSBmZWF0dXJlcywNCj4+IG5vdGFibHkgaXQgc3VwcG9ydHMgYWxsIGtu
b3duIFJUTDgzNjcgdmFyaWFudHMuDQo+IEkgcGxheWVkIHdpdGggUlRMODM2N1IuIEl0IG1vc3Rs
eSB3b3JrcyB3aXRoIHJ0bDgzNjVtYiBkcml2ZXIgYnV0IEkNCj4gd2Fzbid0IGFibGUgdG8gZW5h
YmxlIHRoZSBDUFUgdGFnZ2luZy4gQWx0aG91Z2gNCj4NCj4+IFRoZSB1cHN0cmVhbSBPcGVuV3J0
IGluIHRhcmdldC9saW51eC9nZW5lcmljL2ZpbGVzL2RyaXZlcnMvbmV0L3BoeQ0KPj4gaGFzIHRo
ZSBmb2xsb3dpbmcgZHJpdmVycyBmb3IgdGhlIG9sZCBzd2l0Y2hkZXY6DQo+PiAtcnctci0tci0t
LiAxIGxpbnVzIGxpbnVzIDI1MzgyIEp1biAgNyAyMTo0NCBydGw4MzA2LmMNCj4+IC1ydy1yLS1y
LS0uIDEgbGludXMgbGludXMgNDAyNjggSnVuICA3IDIxOjQ0IHJ0bDgzNjZyYi5jDQo+PiAtcnct
ci0tci0tLiAxIGxpbnVzIGxpbnVzIDMzNjgxIEp1biAgNyAyMTo0NCBydGw4MzY2cy5jDQo+PiAt
cnctci0tci0tLiAxIGxpbnVzIGxpbnVzIDM2MzI0IEp1biAgNyAyMTo0NCBydGw4MzY2X3NtaS5j
DQo+PiAtcnctci0tci0tLiAxIGxpbnVzIGxpbnVzICA0ODM4IEp1biAgNyAyMTo0NCBydGw4MzY2
X3NtaS5oDQo+PiAtcnctci0tci0tLiAxIGxpbnVzIGxpbnVzIDU4MDIxIEp1biAxMiAxODo1MCBy
dGw4MzY3Yi5jDQo+PiAtcnctci0tci0tLiAxIGxpbnVzIGxpbnVzIDU5NjEyIEp1biAxMiAxODo1
MCBydGw4MzY3LmMNCj4+DQo+PiBBcyBmYXIgYXMgSSBjYW4gdGVsbCB3ZSBjb3ZlciBhbGwgYnV0
IFJUTDgzMDYgd2l0aCB0aGUgY3VycmVudCBpbi10cmVlDQo+PiBkcml2ZXJzLCB0aGUgb25seSBy
ZWFzb24gdGhlc2UgYXJlIHN0aWxsIGluIE9wZW5XcnQgd291bGQgYmUgdGhhdCBzb21lDQo+PiBi
b2FyZHMgYXJlIG5vdCBtaWdyYXRlZCB0byBEU0EuDQo+IFRoZXNlIGRyaXZlcnMgeW91IGxpc3Rl
ZCBhcmUgbW9zdGx5IGZvdW5kIGluIG9sZCBvciBsb3cgc3BlYyBkZXZpY2VzLg0KPiBUaGVyZSBp
cyBsaXR0bGUgaW5jZW50aXZlIHRvIGludmVzdCB0b28gbXVjaCB0aW1lIHRvIG1pZ3JhdGUgdGhl
bS4gRm9yDQo+IHJ0bDgzNjVtYiwgaXQgc3RpbGwgbGFja3Mgc3VwcG9ydCBmb3IgdmxhbiBhbmQg
Zm9yd2FyZGluZyBvZmZsb2FkLiBTbywNCj4gdGhlIHN3Y29uZmlnIGRyaXZlciBzdGlsbCBtYWtl
cyBzZW5zZS4NCj4gVGhlcmUgaXMgYWxzbyBhIHBlcmZvcm1hbmNlIHByb2JsZW0gd2l0aCBjaGVj
a3N1bSBvZmZsb2FkaW5nLiBUaGVzZQ0KPiBzd2l0Y2hlcyBhcmUgdXNlZCB3aXRoIG5vbi1yZWFs
dGVrIFNvQywgd2hpY2ggbWlnaHQgbGVhZCB0bzoNCj4NCj4gIkNoZWNrc3VtIG9mZmxvYWQgc2hv
dWxkIHdvcmsgd2l0aCBjYXRlZ29yeSAxIGFuZCAyIHRhZ2dlcnMgd2hlbiB0aGUNCj4gRFNBIGNv
bmR1aXQgZHJpdmVyIGRlY2xhcmVzIE5FVElGX0ZfSFdfQ1NVTSBpbiB2bGFuX2ZlYXR1cmVzIGFu
ZCBsb29rcw0KPiBhdCBjc3VtX3N0YXJ0IGFuZCBjc3VtX29mZnNldC4gRm9yIHRob3NlIGNhc2Vz
LCBEU0Egd2lsbCBzaGlmdCB0aGUNCj4gY2hlY2tzdW0gc3RhcnQgYW5kIG9mZnNldCBieSB0aGUg
dGFnIHNpemUuIElmIHRoZSBEU0EgY29uZHVpdCBkcml2ZXINCj4gc3RpbGwgdXNlcyB0aGUgbGVn
YWN5IE5FVElGX0ZfSVBfQ1NVTSBvciBORVRJRl9GX0lQVjZfQ1NVTSBpbg0KPiB2bGFuX2ZlYXR1
cmVzLCB0aGUgb2ZmbG9hZCBtaWdodCBvbmx5IHdvcmsgaWYgdGhlIG9mZmxvYWQgaGFyZHdhcmUN
Cj4gYWxyZWFkeSBleHBlY3RzIHRoYXQgc3BlY2lmaWMgdGFnIChwZXJoYXBzIGR1ZSB0byBtYXRj
aGluZyB2ZW5kb3JzKS4NCj4gRFNBIHVzZXIgcG9ydHMgaW5oZXJpdCB0aG9zZSBmbGFncyBmcm9t
IHRoZSBjb25kdWl0LCBhbmQgaXQgaXMgdXAgdG8NCj4gdGhlIGRyaXZlciB0byBjb3JyZWN0bHkg
ZmFsbCBiYWNrIHRvIHNvZnR3YXJlIGNoZWNrc3VtIHdoZW4gdGhlIElQDQo+IGhlYWRlciBpcyBu
b3Qgd2hlcmUgdGhlIGhhcmR3YXJlIGV4cGVjdHMuIElmIHRoYXQgY2hlY2sgaXMNCj4gaW5lZmZl
Y3RpdmUsIHRoZSBwYWNrZXRzIG1pZ2h0IGdvIHRvIHRoZSBuZXR3b3JrIHdpdGhvdXQgYSBwcm9w
ZXINCj4gY2hlY2tzdW0gKHRoZSBjaGVja3N1bSBmaWVsZCB3aWxsIGhhdmUgdGhlIHBzZXVkbyBJ
UCBoZWFkZXIgc3VtKS4gRm9yDQo+IGNhdGVnb3J5IDMsIHdoZW4gdGhlIG9mZmxvYWQgaGFyZHdh
cmUgZG9lcyBub3QgYWxyZWFkeSBleHBlY3QgdGhlDQo+IHN3aXRjaCB0YWcgaW4gdXNlLCB0aGUg
Y2hlY2tzdW0gbXVzdCBiZSBjYWxjdWxhdGVkIGJlZm9yZSBhbnkgdGFnIGlzDQo+IGluc2VydGVk
IChpLmUuIGluc2lkZSB0aGUgdGFnZ2VyKS4gT3RoZXJ3aXNlLCB0aGUgRFNBIGNvbmR1aXQgd291
bGQNCj4gaW5jbHVkZSB0aGUgdGFpbCB0YWcgaW4gdGhlIChzb2Z0d2FyZSBvciBoYXJkd2FyZSkg
Y2hlY2tzdW0NCj4gY2FsY3VsYXRpb24uIFRoZW4sIHdoZW4gdGhlIHRhZyBnZXRzIHN0cmlwcGVk
IGJ5IHRoZSBzd2l0Y2ggZHVyaW5nDQo+IHRyYW5zbWlzc2lvbiwgaXQgd2lsbCBsZWF2ZSBhbiBp
bmNvcnJlY3QgSVAgY2hlY2tzdW0gaW4gcGxhY2UuIg0KPiBTZWU6IGh0dHBzOi8vZG9jcy5rZXJu
ZWwub3JnL25ldHdvcmtpbmcvZHNhL2RzYS5odG1sDQo+DQo+PiBCdXQgbWF5YmUgSSBtaXNzZWQg
c29tZXRoaW5nPw0KPiBJIGd1ZXNzIENocmlzIGlzIHRhbGtpbmcgYWJvdXQgdGhlIHJlYWx0ZWsg
dGFyZ2V0IHRoYXQgdXNlcyBSZWFsdGVrDQo+IFNvQyAodGFyZ2V0L2xpbnV4L3JlYWx0ZWsvZmls
ZXMtNS4xNS8pLiBUaGF0IGlzIGEgY29tcGxldGVseSBkaWZmZXJlbnQNCj4gYmVhc3QuDQoNCkNv
cnJlY3QuIE15IGludGVyZXN0IHJpZ2h0IG5vdyBpcyBhcm91bmQgdGhlIGludGVncmF0ZWQgUlRM
OTMweCBhbmQgDQpwb3NzaWJseSB0aGUgUlRMODM4eC4gVGhlc2UgaGF2ZSBpbnRlZ3JhdGVkIG1p
cDMyIENQVXMuIFRoZXJlJ3MgYSANCmNvbGxlY3Rpb24gb2YgcGVyaXBoZXJhbCBkcml2ZXJzIGlu
IG9wZW53cnQgdGhhdCB3b3VsZCBuZWVkIHVwc3RyZWFtaW5nIA0KdG8ganVzdCBzdXBwb3J0IHRo
ZXNlIGFzIGdlbmVyYWwgQ1BVcy4gSSB0aGluayB0aGF0J3MgZ2VuZXJhbGx5IGRvYWJsZSANCmJ1
dCB0aGVyZSB3b3VsZCBiZSBhIGZhaXIgYml0IG9mIGJhY2sgYW5kIGZvcnRoIHRvIGdldCB0aGUg
ZHJpdmVycyBhbmQgDQpkdGJpbmRpbmdzIGluIHNoYXBlLg0KDQo+IEFsdGhvdWdoIGl0IG1pZ2h0
IHNoYXJlIHNvbWUgKG9yIGEgbG90KSBsb2dpYyB3aXRoIGN1cnJlbnQNCj4gdXBzdHJlYW0gZHJp
dmVycywgaXQgaXMgd2F5IG1vcmUgY29tcGxleC4gSXQgbWlnaHQgcmVxdWlyZSBhDQo+IG11bHRp
LWZ1bmN0aW9uIGRldmljZSBkcml2ZXIuDQoNCkZvciB0aGUgZHNhIHBhcnQgSSdkIHByb2JhYmx5
IHdhbnQgdG8gc3RhcnQgYnkgYWRkaW5nIGEgcmVhbHRlay1tbWlvLmMgDQpuZXh0IHRvIHJlYWx0
ZWstc21pLmMgYW5kIHJlYWx0ZWstbWRpby5jIGFsdGhvdWdoIG1heWJlIHJlZ21hcCB3b3VsZCAN
Cm1ha2UgdGhhdCByZWR1bmRhbnQuIEFzIEx1aXogbWVudGlvbnMgdGhlIG5ld2VyIHNpbGljb24g
aXMgbXVjaCBtb3JlIA0KY2FwYWJsZSB0aGFuIHRoZSBSVEw4MzB4L1JUTDgzNnguIFNvIHRoZXJl
IHdvdWxkIGJlIGEgbG90IG9mIHdvcmsgDQpicmluZ2luZyBpbiBuZXcgc2lsaWNvbiBmYW1pbGll
cyB3aXRoIG1vcmUgY2FwYWJpbGl0aWVzLg0KDQpJIGRvbid0IHRoaW5rIHdlJ2QgbmVlZCBhIE1G
RCBhdCBsZWFzdCBub3Qgd2l0aCB0aGUgaW50ZWdyYXRlZCANCnBlcmlwaGVyYWxzIHRoYXQgYXJl
IGFjY2Vzc2libGUgd2l0aCBNTUlPLg0KDQo+IEFueXdheSwgdGhlIGN1cnJlbnQgcmVhbHRlayBT
b0MvdGFyZ2V0DQo+IGRyaXZlcnMgbmVlZCBzb21lIGxvdmUsIGxpa2UgdXNpbmcgcmVnbWFwLCBp
bXBsZW1lbnQgZnVuY3Rpb25zIHVzaW5nDQo+IGFuIGFic3RyYWN0aW9uIGxheWVyIChhbmQgbm90
IGlmIG1vZGVsIGEgaW5zaWRlIHRoZSBjb2RlKSwgZ2V0IHJpZCBvZg0KPiBhbGwgbWFnaWMgbnVt
YmVycyBhbmQgcmVwbGFjZSB0aGVtIHdpdGggbWVhbmluZ2Z1bCBtYWNyb3MsIGNyZWF0ZSBhDQo+
IHByb3BlciB0YWdnZXIgKGFuZCBub3QgdHJhbnNsYXRlIGEgZ2VuZXJpYyBvbmUganVzdCBiZWZv
cmUgZm9yd2FyZGluZw0KPiBpdCkuIEluIE9wZW5XcnQsIGEgY29kZSB0aGF0IGdldHMgdGhpbmdz
IGRvbmUgbWlnaHQgYmUgYWNjZXB0YWJsZSBidXQNCj4gdGhlIHVwc3RyZWFtIGtlcm5lbCByZXF1
aXJlcyBzb21ldGhpbmcgbW9yZSBtYWludGFpbmFibGUuIFNvLCBpZiB5b3UNCj4gd2FudCB0byB1
cHN0cmVhbSB0aG9zZSBkcml2ZXJzLCB5b3UgY2FuIHN0YXJ0IGJ5IGltcHJvdmluZyB0aGVtIGlu
IHRoZQ0KPiBvcGVud3J0Lg0KDQpJJ2xsIHNlZSB3aGF0IEkgY2FuIGRvLiBJJ20gc3RpbGwgZ2V0
dGluZyB1cCB0byBzcGVlZCB3aXRoIGRldmVsb3Bpbmcgb24gDQpvcGVud3J0LiBUaGVyZSBkbyBz
ZWVtIHRvIGJlIGEgbG90IG9mIHBhdGNoZXMgdGhhdCBhcmUganVzdCBiYWNrLXBvcnRzIA0Kc28g
bWF5YmUgSSBjYW4ganVzdCBwb2ludCBpdCBhdCBhIGJsZWVkaW5nIGVkZ2Uga2VybmVsIHRvIGFw
cGx5IHdoYXQgDQp0aGV5IGhhdmUgb24tdG9wLg0KDQpJIHBlcnNvbmFsbHkgcHJlZmVyIGdvaW5n
IHVwc3RyZWFtIGZpcnN0IGJ1dCBhcyB5b3Ugc2F5IHRoYXQgcmFpc2VzIHRoZSANCmJhciBhIGJp
dCBoaWdoZXIuDQo=

