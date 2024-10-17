Return-Path: <netdev+bounces-136770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DD79A317D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6048EB21A89
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 23:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E52F1D5142;
	Thu, 17 Oct 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="iuPnIaGl"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923F20E302
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729209136; cv=none; b=tQFQ4nNogxN37Lpc8Nn3uceiZKIy4oGkFG1dDV1cFShyBybGoTn1EJ27UI9ShqUQvP07TnDGAoUA0F/G7CEv4vEEOw5y6vhQLOtjM8TDI2f7QN00eAX5YvmLQovV29Gr9ZlMc5ajO4SNhV2qTYoRPJR1pEIl442zXgmL2b/XMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729209136; c=relaxed/simple;
	bh=9AjUVLR8MvWk4PK7NdFZY960SUOBguDwGZJFV9WHZqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jyS3vIG/VdmM916DSqNxSrTixQ/38za3B5RyTKropxiO1SULnnYovSGWFHnzJxPv1EX3REHwvetiwGbC7lb/s4ZrT9cSPyFPcjHNZyN155K1+ryMAzi3cs4eOuixaqqS93SYahP4ETW/NDfTIQ+bS/hv+1KEFs99EJ0YDOKBmyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=iuPnIaGl; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AEAE82C04CE;
	Fri, 18 Oct 2024 12:52:10 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729209130;
	bh=9AjUVLR8MvWk4PK7NdFZY960SUOBguDwGZJFV9WHZqE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=iuPnIaGl464GVfK4j/dBfXXYJC821hE/zxSVSYwelbjQEy3xXolJ7qO0gTEdAtw9Q
	 XRz79zBOzTgE+5V0UbY/I9xEZ6f5VwimEEksj9wLD5nBhnG2Iqy/igjD4pfJjcho7B
	 v7eNnBq3x6/3wJAsH12F++ASaz49WPZWItidqoaVBA10thTEZgZVjDFhkuYXn9vM0J
	 TDtEJY94UKLRLTANexUVRJAP20UWJ8pNduQduOOqijKXJFC2GZEAJ5gPv7zSfdv106
	 6do3ZSozkp4sWr8ex/7ZdgMNT2kJxdG9Cc6p3u5wIpi+Pxx3+BQm04JDsXbuAmhDbC
	 ZBlAHynrbAQaA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6711a32a0001>; Fri, 18 Oct 2024 12:52:10 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Oct 2024 12:52:10 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Fri, 18 Oct 2024 12:52:10 +1300
From: Paul Davey <Paul.Davey@alliedtelesis.co.nz>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>
Subject: Re: [PATCH net-next] net: phy: aquantia: Add mdix config and
 reporting
Thread-Topic: [PATCH net-next] net: phy: aquantia: Add mdix config and
 reporting
Thread-Index: AQHbIDd1vnPqHtWCDUqpqXlBKr+obbKJ/EYAgADIhgA=
Date: Thu, 17 Oct 2024 23:52:10 +0000
Message-ID: <4e8d02f84d1ae996f6492f9c53bf90a6cc6ad32e.camel@alliedtelesis.co.nz>
References: <20241017015407.256737-1-paul.davey@alliedtelesis.co.nz>
	 <ZxD69GqiPcqOZK2w@makrotopia.org>
In-Reply-To: <ZxD69GqiPcqOZK2w@makrotopia.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DED75AD1D39864F8812A0CB2C79E165@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=6711a32a a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=3pNRdvVr4ggA:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=qgHlcU04hhCE_JbFRl0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gVGh1LCAyMDI0LTEwLTE3IGF0IDEyOjU0ICswMTAwLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
IE9uIFRodSwgT2N0IDE3LCAyMDI0IGF0IDAyOjU0OjA3UE0gKzEzMDAsIFBhdWwgRGF2ZXkgd3Jv
dGU6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIGNvbmZpZ3VyaW5nIE1ESS1YIHN0YXRlIG9mIFBIWS4N
Cj4gPiBBZGQgcmVwb3J0aW5nIG9mIHJlc29sdmVkIE1ESS1YIHN0YXRlIGluIHN0YXR1cyBpbmZv
cm1hdGlvbi4NCj4gDQo+ID4gWy4uLl0NCj4gPiArc3RhdGljIGludCBhcXJfc2V0X3BvbGFyaXR5
KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYsIGludA0KPiA+IHBvbGFyaXR5KQ0KPiANCj4gInBv
bGFyaXR5IiBpcyBub3QgdGhlIHJpZ2h0IHRlcm0gaGVyZS4gVGhpcyBpcyBub3QgYWJvdXQgdGhl
IHBvbGFyaXR5DQo+IG9mIGNvcHBlciBwYWlycywgYnV0IHJhdGhlciBhYm91dCBwYWlycyBiZWlu
ZyBzd2FwcGVkLg0KPiBQbGVhc2UgbmFtZSB0aGUgZnVuY3Rpb24gYWNjb3JkaW5nbHksIGVnLiBh
cXJfc2V0X21kaXgoKS4NCg0KSSB3aWxsIGZpeCB0aGUgbmFtZSBpbiB0aGUgbmV4dCB2ZXJzaW9u
Lg0KDQo+IFsuLi5dDQo+IEFjY29yZGluZyB0byB0aGUgZGF0YXNoZWV0IHRoZSBNREkvTURJLVgg
aW5kaWNhdGlvbiBzaG91bGQgb25seSBiZQ0KPiBpbnRlcnByZXRlZCB3aGVuIGF1dG9uZWdvdGlh
dGlvbiBoYXMgY29tcGxldGVkLg0KPiBIZW5jZSB0aGlzIGNhbGwgc2hvdWxkIGJlIHByb3RlY3Rl
ZCBieSBnZW5waHlfYzQ1X2FuZWdfZG9uZShwaHlkZXYpDQo+IGFuZA0KPiBwaHlkZXYtPm1kaXgg
c2V0IHRvIEVUSF9UUF9NRElfSU5WQUxJRCBpbiBjYXNlIGF1dG8tbmVnb3RpYXRpb24NCj4gaGFz
bid0DQo+IGNvbXBsZXRlZC4NCg0KSSB3aWxsIGFkZCBhIGd1YXJkIGJ5IHRoaXMuICBJIGRpZCBz
b21lIHRlc3RpbmcgYmVjYXVzZSBJIHdhcyBjb25jZXJuZWQNCndpdGggd2hhdCB0aGUgYmVoYXZp
b3VyIGlzIHdoZW4gZGlzYWJsaW5nIGF1dG8tbmVnb3RpYXRpb24sIGFuZCBoYXZlDQpjb25jbHVk
ZWQgdGhhdCBhdXRvIE1ESS9NREktWCBkZXRlY3Rpb24gZG9lcyBub3Qgb2NjdXIgaWYgYXV0by1u
ZWdvdGlvbg0KaXMgZGlzYWJsZWQuDQoNCkR1ZSB0byB0aGlzIEkgd29uZGVyIHdoZXRoZXIgdGhl
IG1kaXggY29uZmlndXJhdGlvbiBzaG91bGQgcmVqZWN0DQpFVEhfVFBfTURJX0FVVE8gaWYgYXV0
by1uZWdvdGlhdGlvbiBpcyBkaXNhYmxlZD8NCg0KPiBbLi4uXQ0KPiA+IA0KDQo=

