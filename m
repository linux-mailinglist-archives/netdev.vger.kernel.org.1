Return-Path: <netdev+bounces-174752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EF3A602CE
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 21:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687383B18DF
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C701F4636;
	Thu, 13 Mar 2025 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="FLL7YZxX"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934C1F4621
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898243; cv=none; b=Tw0fgYjrJQefv5Imc9nenvysdiELZayBBti7zIyoruCrHbWo86IiTVeyuOrKMy1FzGwGzLkAtqPm9N1D2meJRJ9hE1XAKVpIsbfv1ItCEvRiP8OI6mjxog1vaA2uWgbSb+3mb0ILkSv/oSsewdO+ddtyHQ/35JfzJblKmjRVFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898243; c=relaxed/simple;
	bh=l+j0vvaZeVM2v7Ka3DYAJXzdNboINqUX/0oCRnIWjSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HClmMsuRe2aaDqhWF89DFsW0BqIyr4JI/hpf15dnttrT8WcNq8BNkOMyPlcLeOnwseUHJwrc0gnwAnWY4NZ6T3npGxIZ1J6CTEGRoePfJq6M/eEJiufdnECPSkKcWRgpnNanAF1AnvkTVNon8Br8TYSs8AIeo1mbT6awaKx4jRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=FLL7YZxX; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5587F2C04C6;
	Fri, 14 Mar 2025 09:37:18 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1741898238;
	bh=l+j0vvaZeVM2v7Ka3DYAJXzdNboINqUX/0oCRnIWjSU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=FLL7YZxXer/UklMBX6Bu5Zfqq/uGN1g0A49z4to72uMmHkxrgswa19wF7P0WVM3D8
	 mRI/IG8yPhVYrrkH0uuyNl51C9g48W4s4fU78s3FTY7e1/kb9VqB40vcMBN0QL1vlw
	 B7HTi8KWxxwnR0VzU3fBDU70fDNGU+5k4SdgGa4q72SRKdrSUyfGcf8xaCFmOX6XjX
	 k6mt0uVlNVYEk6TOo5AL4RRMqkFwLW3rvZDCPrhWF5P2Eiy9osiIRuawZmqXu6DYsY
	 x/t5cSWeOVVwVB0eQxqA0bDoPlpWMPBEHR3uxFGcWfX4mNSLQnVrA/Kqd2J/LQkhp4
	 EzyzyLWA3Y6LA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67d341fe0001>; Fri, 14 Mar 2025 09:37:18 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 09:37:18 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Fri, 14 Mar 2025 09:37:18 +1300
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
Thread-Index: AQHbk7RQMlEBwbSVuE+Te7ZjHwH5gbNwJygAgAB7A4CAAAtMgIAAAJ2A
Date: Thu, 13 Mar 2025 20:37:18 +0000
Message-ID: <539762a3-b17d-415c-9316-66527bfc6219@alliedtelesis.co.nz>
References: <20250313010726.2181302-1-chris.packham@alliedtelesis.co.nz>
 <f7c7f28b-f2b0-464a-a621-d4b2f815d206@lunn.ch>
 <5ea333ec-c2e4-4715-8a44-0fd2c77a4f3c@alliedtelesis.co.nz>
 <be39bb63-446e-4c6a-9bb9-a823f0a482be@lunn.ch>
In-Reply-To: <be39bb63-446e-4c6a-9bb9-a823f0a482be@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <0851C2E639F79C47B16845917206FBDB@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Ko7u2nWN c=1 sm=1 tr=0 ts=67d341fe a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=bmUEovISKhIOwPBmBJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gMTQvMDMvMjAyNSAwOTozNSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIFRodSwgTWFyIDEz
LCAyMDI1IGF0IDA3OjU0OjM5UE0gKzAwMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiArY2Mg
bmV0ZGV2LCBsa21sDQo+Pg0KPj4gT24gMTQvMDMvMjAyNSAwMTozNCwgQW5kcmV3IEx1bm4gd3Jv
dGU6DQo+Pj4+ICsJLyogUHV0IHRoZSBpbnRlcmZhY2VzIGludG8gQzQ1IG1vZGUgaWYgcmVxdWly
ZWQgKi8NCj4+Pj4gKwlnbGJfY3RybF9tYXNrID0gR0VOTUFTSygxOSwgMTYpOw0KPj4+PiArCWZv
ciAoaSA9IDA7IGkgPCBNQVhfU01JX0JVU1NFUzsgaSsrKQ0KPj4+PiArCQlpZiAocHJpdi0+c21p
X2J1c19pc19jNDVbaV0pDQo+Pj4+ICsJCQlnbGJfY3RybF92YWwgfD0gR0xCX0NUUkxfSU5URl9T
RUwoaSk7DQo+Pj4+ICsNCj4+Pj4gKwlmd25vZGVfZm9yX2VhY2hfY2hpbGRfbm9kZShub2RlLCBj
aGlsZCkNCj4+Pj4gKwkJaWYgKGZ3bm9kZV9kZXZpY2VfaXNfY29tcGF0aWJsZShjaGlsZCwgImV0
aGVybmV0LXBoeS1pZWVlODAyLjMtYzQ1IikpDQo+Pj4+ICsJCQlwcml2LT5zbWlfYnVzX2lzX2M0
NVttZGlvX2J1c10gPSB0cnVlOw0KPj4+PiArDQo+Pj4gVGhpcyBuZWVkcyBtb3JlIGV4cGxhbmF0
aW9uLiBTb21lIFBIWXMgbWl4IEMyMiBhbmQgQzQ1LCBlLmcuIHRoZSA+IDFHDQo+Pj4gc3BlZWQg
c3VwcG9ydCByZWdpc3RlcnMgYXJlIGluIHRoZSBDNDUgYWRkcmVzcyBzcGFjZSwgYnV0IDw9IDFH
IGlzIGluDQo+Pj4gdGhlIEMyMiBzcGFjZS4gQW5kIDFHIFBIWXMgd2hpY2ggc3VwcG9ydCBFRUUg
bmVlZCBhY2Nlc3MgdG8gQzQ1IHNwYWNlDQo+Pj4gZm9yIHRoZSBFRUUgcmVnaXN0ZXJzLg0KPj4g
QWggZ29vZCBwb2ludC4gVGhlIE1ESU8gaW50ZXJmYWNlcyBhcmUgZWl0aGVyIGluIEdQSFkgKGku
ZS4gY2xhdXNlIDIyKQ0KPj4gb3IgMTBHUEhZIG1vZGUgKGkuZS4gY2xhdXNlIDQ1KS4gVGhpcyBk
b2VzIG1lYW4gd2UgY2FuJ3Qgc3VwcG9ydCBzdXBwb3J0DQo+PiBib3RoIGM0NSBhbmQgYzIyIG9u
IHRoZSBzYW1lIE1ESU8gYnVzICh3aGV0aGVyIHRoYXQncyBvbmUgUEhZIHRoYXQNCj4+IHN1cHBv
cnRzIGJvdGggb3IgdHdvIGRpZmZlcmVudCBQSFlzKS4gSSdsbCBhZGQgYSBjb21tZW50IHRvIHRo
YXQgZWZmZWN0DQo+PiBhbmQgSSBzaG91bGQgcHJvYmFibHkgb25seSBwcm92aWRlIGJ1cy0+cmVh
ZC93cml0ZSBvcg0KPj4gYnVzLT5yZWFkX2M0NS93cml0ZV9jNDUgZGVwZW5kaW5nIG9uIHRoZSBt
b2RlLg0KPiBJcyB0aGVyZSBtb3JlIHRvIGl0IHRoYW4gdGhpcz8gQmVjYXVzZSB3aHkgbm90IGp1
c3Qgc2V0IHRoZSBtb2RlIHBlcg0KPiBidXMgdHJhbnNhY3Rpb24/DQoNCkl0J3MgYSBidXMgbGV2
ZWwgc2V0dGluZyBhdCBpbml0IHRpbWUuIFlvdSBjYW4ndCBkeW5hbWljYWxseSBzd2l0Y2ggbW9k
ZXMuDQo=

