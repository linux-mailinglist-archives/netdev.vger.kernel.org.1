Return-Path: <netdev+bounces-102716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B0F9045DF
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977131F230A7
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 20:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA45CDF0;
	Tue, 11 Jun 2024 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="AizaDfic"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25962152503
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138506; cv=none; b=Dg5pM5VgVqq7UXLGQyGZ4TQXQQw/vyqMMIcEySDPTw6CaFV575srFXKyWacVkRPAsdkGBkrtXcsKpjJenL35PcNNRL46xakNtpatZI96QBvZAt8BDpxFI9LrEuuBApviwqcQVsVE+UrED2jdX/Zx579IletOWYOg+zmjLiBUp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138506; c=relaxed/simple;
	bh=1C1JVN7pV8bQ/ukxRKGwFFcRQWzZiVMRqNTNB3nnmYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BcbH70Iwu/xjU8BIik8RgG4apR87x0dl+1IM2alWGjyQ9SEv5I2BumEwzaW5JnSCRl6NbI0c1rzA+oXSAGD7K9qcydyhlbHnoM/WJexI2pOcg2gjrnC1ifUFb0K0tib/lTGwHDPToTBeEefCUN2WgQSByad6kmGScs+YXhdZmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=AizaDfic; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9EFC42C0659;
	Wed, 12 Jun 2024 08:41:40 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718138500;
	bh=1C1JVN7pV8bQ/ukxRKGwFFcRQWzZiVMRqNTNB3nnmYU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AizaDficE02ikCvs0EuYIZaM0Shi1sfLTFYFn+auleSMZAhl1grTGqdzmYUdsKQ7s
	 ZFBUF1GTVQzx3gggEn4lDwUaCNYjqMeEzegN2vRecpa6LqDWGDLXNNganE5vhrZ6y3
	 DcD9wJ6kqHgpLDdyjkwHXpi9MJDarpkxnn8Ri0XdiZRs03EzzJrEcGskwKuJIuVgzF
	 PB/M38NjlTMNG0FGwauOdxmdYr11Z1Epw0bOkA0eFLNG+Om+eglWIcCFLTIjCAMJow
	 f14B8gE04luFLYd3vBosikDHs0mJDbTdByW/CL5UBdq9UEZ7KmHjTa+bkbQzjGGFNt
	 90Asa5E4T833Q==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6668b6840001>; Wed, 12 Jun 2024 08:41:40 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Wed, 12 Jun 2024 08:41:40 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 12 Jun 2024 08:41:40 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Wed, 12 Jun 2024 08:41:40 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
Thread-Topic: [PATCH next-next] net: phy: realtek: add support for rtl8224
 2.5Gbps PHY
Thread-Index: AQHau8ECnGOzFCFnUUe89YjWXGoxMrHBw8CAgAB7GIA=
Date: Tue, 11 Jun 2024 20:41:39 +0000
Message-ID: <f6f82e0c-5cf5-4a1c-891c-9e772f2403d4@alliedtelesis.co.nz>
References: <20240611053415.2111723-1-chris.packham@alliedtelesis.co.nz>
 <243d5e27-522d-408d-a551-d11073cf330b@lunn.ch>
In-Reply-To: <243d5e27-522d-408d-a551-d11073cf330b@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6330DE92D0E9DB4A877E219CC31048C1@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=6668b684 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=tzSt9rU13RPaQMf4fiUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAxMi8wNi8yNCAwMToyMSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIFR1ZSwgSnVuIDEx
LCAyMDI0IGF0IDA1OjM0OjE0UE0gKzEyMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBUaGUg
UmVhbHRlayBSVEw4MjI0IFBIWSBpcyBhIDIuNUdicHMgY2FwYWJsZSBQSFkuIEl0IG9ubHkgdXNl
cyB0aGUNCj4+IGNsYXVzZSA0NSBNRElPIGludGVyZmFjZSBhbmQgY2FuIGxldmVyYWdlIHRoZSBz
dXBwb3J0IHRoYXQgaGFzIGFscmVhZHkNCj4+IGJlZW4gYWRkZWQgZm9yIHRoZSBvdGhlciA4MjJ4
IFBIWXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hh
bUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiBZb3UgcHJvYmFibHkgc2hvdWxkIENjOiBFcmljIFdv
dWRzdHJhIGFuZCBNYXJlayBCZWjDum4gd2hvIGhhdmUgYm90aA0KPiB3b3JrZWQgb24gMi41RyB2
YXJpYW50cyBvZiB0aGlzIFBIWS4NCj4NCkhtbSBnZXRfbWFpbnRhaW5lci5wbCBkaWRuJ3QgcGlj
ayB0aGVtIHVwIGJ1dCBkb2VzIHdpdGggdGhlIC0tZ2l0IA0Kb3B0aW9uLiBEaWQgc29tZXRoaW5n
IGNoYW5nZSB3aXRoIHRoYXQgcmVjZW50bHk/IE9yIG1heWJlIEknbSBqdXN0IA0KcnVubmluZyBp
dCB3cm9uZy4gSSdsbCBhZGQgQ2MgdGhlbSBvbiB0aGUgb3JpZ2luYWwgcGF0Y2ggYW5kIGluY2x1
ZGUgDQp0aGVtIGlmIHRoZXJlIGlzIGEgdjIuDQoNCj4+IE5vdGVzOg0KPj4gICAgICBJJ20gY3Vy
cmVudGx5IHRlc3RpbmcgdGhpcyBvbiBhbiBvbGRlciBrZXJuZWwgYmVjYXVzZSB0aGUgYm9hcmQg
SSdtDQo+PiAgICAgIHVzaW5nIGhhcyBhIFNPQy9EU0Egc3dpdGNoIHRoYXQgaGFzIGEgZHJpdmVy
IGluIG9wZW53cnQgZm9yIExpbnV4IDUuMTUuDQo+PiAgICAgIEkgaGF2ZSB0cmllZCB0byBzZWxl
Y3RpdmVseSBiYWNrIHBvcnQgdGhlIGJpdHMgSSBuZWVkIGZyb20gdGhlIG90aGVyDQo+PiAgICAg
IHJ0bDgyMnggd29yayBzbyB0aGlzIHNob3VsZCBiZSBhbGwgdGhhdCBpcyByZXF1aXJlZCBmb3Ig
dGhlIHJ0bDgyMjQuDQo+PiAgICAgIA0KPj4gICAgICBUaGVyZSdzIHF1aXRlIGEgbG90IHRoYXQg
d291bGQgbmVlZCBmb3J3YXJkIHBvcnRpbmcgZ2V0IGEgd29ya2luZyBzeXN0ZW0NCj4+ICAgICAg
YWdhaW5zdCBhIGN1cnJlbnQga2VybmVsIHNvIGhvcGVmdWxseSB0aGlzIGlzIHNtYWxsIGVub3Vn
aCB0aGF0IGl0IGNhbg0KPj4gICAgICBsYW5kIHdoaWxlIEknbSB0cnlpbmcgdG8gZmlndXJlIG91
dCBob3cgdG8gdW50YW5nbGUgYWxsIHRoZSBvdGhlciBiaXRzLg0KPiAgICAgICANCj4gSSBkb24n
dCBzZWUgdGhpcyBhcyBiZWluZyBhIHByb2JsZW0uIEl0IHNob3VsZCBub3QgYmUgcG9zc2libGUg
dG8NCj4gY2F1c2UgcmVncmVzc2lvbnMgYnkgYWRkaW5nIGEgbmV3IGRldmljZSBsaWtlIHRoaXMu
IElmIGl0IHR1cm5zIG91dCB0bw0KPiBiZSBicm9rZW4sIHlvdSBjYW4gZml4IGl0IHVwIGxhdGVy
Lg0KPg0KPiAJQW5kcmV3

