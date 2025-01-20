Return-Path: <netdev+bounces-159664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FDAA164B9
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 01:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792EF3A473E
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 00:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335EE1C27;
	Mon, 20 Jan 2025 00:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="d87MJTan"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563AE4C80
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 00:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737334141; cv=none; b=JFlWzgYAmU2RgPU1UnN4qq+B/ShjSvNMW97y/gJRjveiu2Ri2OMbWBoARGZQqJkkcz4BafXdoUg+Sx+ZxHzjPtVavWJYs+B9QnIf+aj4Qd+uwP+raOXHczK43IvvPwGAIZp25MTD/BbqT+CicAy1RSGpHL6h879Zk44NTuo+4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737334141; c=relaxed/simple;
	bh=OMdqCR+f5LV7yC0dbQ9UupbVOYQEZvdo5UhJ9grTj2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ptucGhf97J/CJAN1HMTT8DOlWxlHhG1zGqNgOlaW4TUs4NuaM5ixC0dAi17ahfuDd1d7a+q2lhJdmGOzO/zwRyP0HNiCwX/O6OysF1ICMX/Cm8J0jeNkMWbhIMr2KlCDXxAMC0ivh1vUgPlSLdrno1PIdWlB3n+Wtwbu31L4k/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=d87MJTan; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B3F692C0505;
	Mon, 20 Jan 2025 13:41:43 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1737333703;
	bh=OMdqCR+f5LV7yC0dbQ9UupbVOYQEZvdo5UhJ9grTj2M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:Reply-To:From;
	b=d87MJTanqj4Ib+dA8/ZN0SBNjWzJZOMvK75eudFOU0HWC9IsEy4F3nRB/B0N+B3El
	 XqUEDMON9PUO004GZvLVQ+IoKB1fO+NUkL2UyuwIyLkhVaM74A6YPe6Eu4sefQ7uQn
	 KhdkpljDaPw/5Tu49nQRhqkKRkLIvzLQ0MaSYnk/h/+StxhOdm1+C7AF8KjdD0iy4P
	 adM1zV/C9pUK+gOsJqtYA0YDQwMBW9rXZTiclZSfNTnpZKy8DGyG8ZhSZ29ME+BQx1
	 pEfdO/5IdVrHxdD0qIENi8mj3wtYQOFx17ZQx82WZHe6yyVTYfi24KV7obFWZ7Ah+t
	 kSKOzF9G8ijmg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B678d9bc50001>; Mon, 20 Jan 2025 13:41:41 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jan 2025 13:41:40 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Mon, 20 Jan 2025 13:41:40 +1300
From: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [RFC net-next v0 2/2] net: dsa: add option for bridge port HW
 offload
Thread-Topic: [RFC net-next v0 2/2] net: dsa: add option for bridge port HW
 offload
Thread-Index: AQHbM9mT6LgGWH2L/0mQJAwg4OVvK7KxXocAgG0H+wA=
Date: Mon, 20 Jan 2025 00:41:40 +0000
Message-ID: <eb1111f63fa0767b92ad22be82aeb3fe89bed085.camel@alliedtelesis.co.nz>
References: <20241111013218.1491641-1-aryan.srivastava@alliedtelesis.co.nz>
	 <20241111013218.1491641-3-aryan.srivastava@alliedtelesis.co.nz>
	 <928411af-4cf7-4b25-9a86-2cf3a5ae6e2a@lunn.ch>
In-Reply-To: <928411af-4cf7-4b25-9a86-2cf3a5ae6e2a@lunn.ch>
Reply-To: "928411af-4cf7-4b25-9a86-2cf3a5ae6e2a@lunn.ch"
	<928411af-4cf7-4b25-9a86-2cf3a5ae6e2a@lunn.ch>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C6BF9354E4751459AA80ABCCF0BC6AF@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=678d9bc5 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=w1vUsAckAk8A:10 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=PuI6fNucBTIlDNplZQwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gTW9uLCAyMDI0LTExLTExIGF0IDE2OjQwICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
T24gTW9uLCBOb3YgMTEsIDIwMjQgYXQgMDI6MzI6MTdQTSArMTMwMCwgQXJ5YW4gU3JpdmFzdGF2
YSB3cm90ZToNCj4gPiBDdXJyZW50bHkgdGhlIERTQSBmcmFtZXdvcmsgd2lsbCBIVyBvZmZsb2Fk
IGFueSBicmlkZ2UgcG9ydCBpZg0KPiA+IHRoZXJlIGlzDQo+ID4gYSBkcml2ZXIgYXZhaWxhYmxl
IHRvIHN1cHBvcnQgSFcgb2ZmbG9hZGluZy4gVGhpcyBtYXkgbm90IGFsd2F5cyBiZQ0KPiA+IHRo
ZQ0KPiA+IHByZWZlcnJlZCBjYXNlLg0KPiA+IA0KPiA+IEluIGNhc2VzIHdoZXJlIHRoZSBwb3J0
cyBvbiB0aGUgc3dpdGNoIGNoaXAgYXJlIGJlaW5nIHVzZWQgYXMNCj4gPiBwdXJlbHkgTDMNCj4g
PiBpbnRlcmZhY2VzLCBpdCBpcyBwcmVmZXJyZWQgdGhhdCBldmVyeSBwYWNrZXQgaGl0cyB0aGUg
Q1BVLiBJbiB0aGUNCj4gPiBjYXNlDQo+ID4gd2hlcmUgdGhlc2UgcG9ydHMgYXJlIGFkZGVkIHRv
IGEgYnJpZGdlLCB0aGVyZSBpcyBhIGxpa2VsaWhvb2Qgb2YNCj4gPiBwYWNrZXRzIGNvbXBsZXRl
bHkgYnlwYXNzaW5nIHRoZSBDUFUgYW5kIGJlaW5nIHN3aXRjaGVkLg0KPiANCj4gVGhpcyBkb2Vz
IG5vdCBtYWtlIG11Y2ggc2Vuc2UgdG8gbWUuIElmIGl0IGlzIHB1cmVseSBMMywgeW91IGRvbid0
DQo+IG5lZWQgYSBicmlkZ2UsIHNpbmNlIHRoYXQgaXMgb25seSBuZWVkZWQgZm9yIEwyLg0KPiAN
Cj4gSSB0aGluayB3ZSBuZWVkIG1vcmUgZGV0YWlscyB0byB1bmRlcnN0YW5kIHdoYXQgeW91IHJl
YWxseSBtZWFuIGhlcmUuDQo+IA0KPiDCoMKgwqDCoMKgwqDCoMKgQW5kcmV3DQpIaSBBbmRyZXcs
DQoNClNvcnJ5IGZvciB0aGUgYmVsYXRlZCByZXBseSwgSSB3aWxsIHJldXBsb2FkIHRoaXMgcGF0
Y2ggd2l0aCBhbiB1cGRhdGVkDQpjb21taXQgbWVzc2FnZS4NCg0KICAgICAgICBBcnlhbg0KDQo=

