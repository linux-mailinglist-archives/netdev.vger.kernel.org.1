Return-Path: <netdev+bounces-174745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500ACA601A2
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 20:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98BD8800B9
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998B81F4264;
	Thu, 13 Mar 2025 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="YCFHt6Gt"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB91F3D55
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895690; cv=none; b=esBL/+I/cQw2JPFxkaST78CQUHwz8TunXX5VGPwBBQTVq8LXkLpQKf551TaJD7pEsnVPJynWDnIHV0zHcE1MmsTr/2XUWOPiqbSL7jsWP3LeXZluuCvDp4KuqwuTQAHIybouQpNJysWGlEGQOPVZpNILR3UoYT2ooe1O0gRqd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895690; c=relaxed/simple;
	bh=CF1bSX3XlU4ChBISB+cYOWk0F+bA3NnjnVnuf/kjyh4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cz8Nvp9HBxsQUBnZ9PE9v0YwCj9W+pZpbvfXPeGDpGGIoRQGbno9x1viS6TlQ7r6/9Bk3Sqk70tt5F/TtkanYhrG1zcy+fnLwFlH5rbqaSWYC+w0kyCroHAxvoCnFuK99PP+if8yYh96lV+CRsXo7zMvkAnRYMWNcg0RlCMAOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=YCFHt6Gt; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B2FA92C0375;
	Fri, 14 Mar 2025 08:54:39 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1741895679;
	bh=CF1bSX3XlU4ChBISB+cYOWk0F+bA3NnjnVnuf/kjyh4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YCFHt6GtSuNsI9AVXX815U+BW8iQ5enkD/fTCNkfOEQJr6yttPSX/NMajdu27utke
	 i+XqgUB/L/xf38ac45wLpkh2IwR458EnBcO3VfKgK3gZz1uVTPjc4oCiE8gnQb6BUD
	 GbOwRG9NRP7X4Xfv0yhTvhRJHQljjaTlaq71rsoxfW1h4PX0ZOEOXcZIy4Gas1uP2K
	 T43YABQ8zVtbB+/1wng5YHzCtDygpUnW7x3fxIP4y5+qFsJd+14dJQh7T+Pv/R7xXO
	 YRlU0T5xaFX9hm7ZzR1k/w1zipgO731oYg91Z6pGeDMtbh5XC7/PKj3GJKZB1Hksvz
	 2Oj01o0B38t9w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67d337ff0001>; Fri, 14 Mar 2025 08:54:39 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 08:54:39 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Fri, 14 Mar 2025 08:54:39 +1300
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
Thread-Index: AQHbk7RQMlEBwbSVuE+Te7ZjHwH5gbNwJygAgAB7A4A=
Date: Thu, 13 Mar 2025 19:54:39 +0000
Message-ID: <5ea333ec-c2e4-4715-8a44-0fd2c77a4f3c@alliedtelesis.co.nz>
References: <20250313010726.2181302-1-chris.packham@alliedtelesis.co.nz>
 <f7c7f28b-f2b0-464a-a621-d4b2f815d206@lunn.ch>
In-Reply-To: <f7c7f28b-f2b0-464a-a621-d4b2f815d206@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6111809622E754CB108E822046D02FD@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Ko7u2nWN c=1 sm=1 tr=0 ts=67d337ff a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=GmB-G2GEk0dDs4bVDSMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

K2NjIG5ldGRldiwgbGttbA0KDQpPbiAxNC8wMy8yMDI1IDAxOjM0LCBBbmRyZXcgTHVubiB3cm90
ZToNCj4+ICsJLyogUHV0IHRoZSBpbnRlcmZhY2VzIGludG8gQzQ1IG1vZGUgaWYgcmVxdWlyZWQg
Ki8NCj4+ICsJZ2xiX2N0cmxfbWFzayA9IEdFTk1BU0soMTksIDE2KTsNCj4+ICsJZm9yIChpID0g
MDsgaSA8IE1BWF9TTUlfQlVTU0VTOyBpKyspDQo+PiArCQlpZiAocHJpdi0+c21pX2J1c19pc19j
NDVbaV0pDQo+PiArCQkJZ2xiX2N0cmxfdmFsIHw9IEdMQl9DVFJMX0lOVEZfU0VMKGkpOw0KPj4g
Kw0KPj4gKwlmd25vZGVfZm9yX2VhY2hfY2hpbGRfbm9kZShub2RlLCBjaGlsZCkNCj4+ICsJCWlm
IChmd25vZGVfZGV2aWNlX2lzX2NvbXBhdGlibGUoY2hpbGQsICJldGhlcm5ldC1waHktaWVlZTgw
Mi4zLWM0NSIpKQ0KPj4gKwkJCXByaXYtPnNtaV9idXNfaXNfYzQ1W21kaW9fYnVzXSA9IHRydWU7
DQo+PiArDQo+IFRoaXMgbmVlZHMgbW9yZSBleHBsYW5hdGlvbi4gU29tZSBQSFlzIG1peCBDMjIg
YW5kIEM0NSwgZS5nLiB0aGUgPiAxRw0KPiBzcGVlZCBzdXBwb3J0IHJlZ2lzdGVycyBhcmUgaW4g
dGhlIEM0NSBhZGRyZXNzIHNwYWNlLCBidXQgPD0gMUcgaXMgaW4NCj4gdGhlIEMyMiBzcGFjZS4g
QW5kIDFHIFBIWXMgd2hpY2ggc3VwcG9ydCBFRUUgbmVlZCBhY2Nlc3MgdG8gQzQ1IHNwYWNlDQo+
IGZvciB0aGUgRUVFIHJlZ2lzdGVycy4NCg0KQWggZ29vZCBwb2ludC4gVGhlIE1ESU8gaW50ZXJm
YWNlcyBhcmUgZWl0aGVyIGluIEdQSFkgKGkuZS4gY2xhdXNlIDIyKSANCm9yIDEwR1BIWSBtb2Rl
IChpLmUuIGNsYXVzZSA0NSkuIFRoaXMgZG9lcyBtZWFuIHdlIGNhbid0IHN1cHBvcnQgc3VwcG9y
dCANCmJvdGggYzQ1IGFuZCBjMjIgb24gdGhlIHNhbWUgTURJTyBidXMgKHdoZXRoZXIgdGhhdCdz
IG9uZSBQSFkgdGhhdCANCnN1cHBvcnRzIGJvdGggb3IgdHdvIGRpZmZlcmVudCBQSFlzKS4gSSds
bCBhZGQgYSBjb21tZW50IHRvIHRoYXQgZWZmZWN0IA0KYW5kIEkgc2hvdWxkIHByb2JhYmx5IG9u
bHkgcHJvdmlkZSBidXMtPnJlYWQvd3JpdGUgb3IgDQpidXMtPnJlYWRfYzQ1L3dyaXRlX2M0NSBk
ZXBlbmRpbmcgb24gdGhlIG1vZGUuDQo=

