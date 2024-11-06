Return-Path: <netdev+bounces-142137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE309BDA07
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B44D2840CB
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB59AA47;
	Wed,  6 Nov 2024 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="DX7RVRYF"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1C636D
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730851311; cv=none; b=YKjvtERrre5Ftb5UyuWIJZ9eM6EgTG2MhgjJpTw6andEF5JRTR+GfhtT2X1IdXSRxfv2FqgRO/ePNlI5c/suap6KmUAchzv3YYclXyHqge8fhCLbDJCHK6PWzmm+g4Ic3STyfevOLClGqDUy4YaTOVTyDQFdjGgPA6oCxgJzPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730851311; c=relaxed/simple;
	bh=sFxnz39WGedOqQ3vTENfHmBcp2jjrx/GR6vP8Y4591U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NciKFO7kghPiU8t4On925wpRWj+8r3lqwtvl4nRJ+ugBuY47HcWddjr2AzU3ZGx3l3gupTm0amPdg7m9yjwcriCy2pfV6SQiM0nQyjP2keBJaoJl1Hla8OVqMiO/EFgfvHrGHAmbCVFg8Fvmx3W3Wh4Frr8Qtgnq3Hbz1cE8pho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=DX7RVRYF; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 497942C0452;
	Wed,  6 Nov 2024 13:01:46 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1730851306;
	bh=sFxnz39WGedOqQ3vTENfHmBcp2jjrx/GR6vP8Y4591U=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=DX7RVRYFkTYbTKl4UwFMGag5AG3TajsbgZVu3r3dXebQqr9LUTSZ3R9UyaOHUoM27
	 k1iaaOz7t4O0/7DS4Ccf1ov7NPFjFzzb5M+vuZSCcZ73qF2mxRQLMWJXHBPjc7ybWO
	 VKW4FVPvttIr5YEpaO/VjHQkSQLV1P4o/8AhHAe4iwLxChtMCsWPBAU3mLpwRtgiM0
	 u7hDRlUeo4/DN6ZXl0ZnFr/dPA/3bmz2Mv1stEAGZgSNKbaKJ8jt8gcOVxBuJLMuNp
	 cDhqJcvTJj4n3AXZiMgHf02xPSwGLM063GDTzIg2wc8ylkRxzSEYDIn+h21I+yl1bJ
	 cz3u/aJ+VOw1A==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672ab1ea0001>; Wed, 06 Nov 2024 13:01:46 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Wed, 6 Nov 2024 13:01:46 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Wed, 6 Nov 2024 13:01:33 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Wed, 6 Nov 2024 13:01:33 +1300
From: Paul Davey <Paul.Davey@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "daniel@makrotopia.org" <daniel@makrotopia.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: aquantia: Add mdix config and
 reporting
Thread-Topic: [PATCH net-next] net: phy: aquantia: Add mdix config and
 reporting
Thread-Index: AQHbIDd1vnPqHtWCDUqpqXlBKr+obbKJ/EYAgADIhgCAAAeHgIAAKh8AgADzOQCAHLoMgA==
Date: Wed, 6 Nov 2024 00:01:33 +0000
Message-ID: <c69eb0c307346bce51ccb3f990a26d79e942c9e2.camel@alliedtelesis.co.nz>
References: <20241017015407.256737-1-paul.davey@alliedtelesis.co.nz>
	 <ZxD69GqiPcqOZK2w@makrotopia.org>
	 <4e8d02f84d1ae996f6492f9c53bf90a6cc6ad32e.camel@alliedtelesis.co.nz>
	 <ec453754-3474-4824-b4e3-e26603e2e1d8@lunn.ch>
	 <858331af57bd1d9ab478c3ec6f5ecd19dcd205ef.camel@alliedtelesis.co.nz>
	 <804d1825-8630-4421-925c-16e8f41f9a58@lunn.ch>
In-Reply-To: <804d1825-8630-4421-925c-16e8f41f9a58@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <654828E68D8F704CB88BF6DE9867E615@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=672ab1ea a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=3pNRdvVr4ggA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=odbzjE8n2zWvv2dw42YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gRnJpLCAyMDI0LTEwLTE4IGF0IDE5OjIwICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
DQo+ID4gV2hlbiBJIHdhcyB3b25kZXJpbmcgaWYgbWRpeF9jdHJsIGJlaW5nIHNldCB0byBFVEhf
VFBfTURJX0FVVE8NCj4gPiBzaG91bGQNCj4gPiBiZSByZWplY3RlZCBpZiBhdXRvLW5lZ290aWF0
aW9uIGlzIGRpc2FibGVkIEkgbWVhbnQgZm9yIHRoaXMNCj4gPiBzcGVjaWZpYw0KPiA+IFBIWSBk
cml2ZXIgYXMgaXQgZGVmaW5pdGVseSBkb2VzIG5vdCBhcHBlYXIgdG8gcGVyZm9ybSB0aGUgQXV0
bw0KPiA+IE1ESS9NREktWCByZXNvbHV0aW9uIHNvIGlmIHRoZSB3aXJpbmcvY2FibGluZyBiZXR3
ZWVuIGFuZC9vciBjb25maWcNCj4gPiBvbg0KPiA+IHRoZSBsaW5rIHBhcnRuZXIgZG9lcyBub3Qg
bWF0Y2ggdGhlIGRlZmF1bHQgKE1ESSBJIHRoaW5rIGZvciB0aGUNCj4gPiBBUVIpDQo+ID4gdGhl
biB0aGUgbGluayB3aWxsIG5vdCBlc3RhYmxpc2guDQo+IA0KPiBXZWxsLCBhcyB5b3Ugc2F5LCAx
MDAwQmFzZS1UIG5lZWRzIGF1dG9uZWcsIHNvIHRoZXJlIGlzIG5vIG5lZWQgdG8NCj4gcmVqZWN0
IEVUSF9UUF9NRElfQVVUTyBmb3IgdGhhdCBsaW5rIG1vZGUgYW5kIGFib3ZlLg0KPiANCj4gSXQg
c2VlbXMgbGlrZSBmb3IgbG93ZXIgc3BlZWRzLCBFVEhfVFBfTURJX0FVVE8gY291bGQgd29yayB3
aXRob3V0DQo+IGF1dG9uZWcuIFNvIHRvIG1lLCB0aGlzIHZhbGlkYXRpb24gaXMgbm90IGEgY29y
ZSBmZWF0dXJlLCBidXQgcGVyDQo+IFBIWS4NCj4gUGxlYXNlIGZlZWwgZnJlZSB0byBpbXBsZW1l
bnQgaXQgZm9yIHRoaXMgUEhZLg0KPiANCkhhdmluZyBicmllZmx5IHRyaWVkIGl0IHRoZSBfcGh5
X3N0YXRlX21hY2hpbmUgY29kZSBkb2VzIG5vdCBsaWtlDQpwaHlfY29uZmlnX2FuZWcgcmV0dXJu
aW5nIGVycm9ycywgc28gSSB3aWxsIGxlYXZlIHRoZSBjb2RlIGFzIGlzLg0KDQpJIHdpbGwgc3Vi
bWl0IGEgdjIgcGF0Y2ggc29vbiB3aXRoIHRoZSBvdGhlciByZXF1ZXN0ZWQgY2hhbmdlcy4NCg0K
VGhhbmtzLA0KUGF1bA0K

