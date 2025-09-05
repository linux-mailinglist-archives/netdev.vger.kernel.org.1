Return-Path: <netdev+bounces-220366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BE9B45974
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 15:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C258B7B260B
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B299C352FDC;
	Fri,  5 Sep 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Dq5nXdwC"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6E2750F0;
	Fri,  5 Sep 2025 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079831; cv=none; b=BX0ZTVCfJQuYI4OF2afFyMFMOO5qp2wKQBHmTF9Y7FwCQnvMmwUOPUZd98dk0CiOQ+Db99Y4TrULYbvjwWIskla1qNbkz4gOqK4vVkPPdoSTVi1HbtM+tCNsi25hMLPf6tRbYLH5Nxitu9xPvSHOQETLhKQT3qWUpbrF4FsBiWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079831; c=relaxed/simple;
	bh=DuhvxwWyUPaZr2McmCmnJjWy64lCVEX3hJjx88uGEs4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ovztyWxgkEReyGy3YpXVdmjqHE9+32McZSa98xgUOZCqqjFcf8z+bhlEYxxVxkC/UoJj0Vb982jPKBjWCUjpUrI+cMWG3O2Gy1XjDDmde6fA6PmeuyRlb1eITannq3KW0w48TZ2v6tcJy9wVPiRbFW+CcMTH9iVFk04BitXe9Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Dq5nXdwC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 585Dh7RY11403849, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757079787; bh=DuhvxwWyUPaZr2McmCmnJjWy64lCVEX3hJjx88uGEs4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Dq5nXdwCBIdE5uOQmRG4fJRFJU9RkhM+c4RqUnWZ7j6SZYeu7WBS8X41nsS2fpHL4
	 79KZqI9a+VaIjGj6zDD9pvZbg7VwQ21qCNdxDYsZKLW178O1EG/zVlwx9NBl+tuo9O
	 mZKWYE2sj7RKHZMmZG7cd2Ze3H6os2kBx7kRtX3WNMjNLaPeg8wxqyfwwdvWTlsdhv
	 Ay0xGq9GHZQ3WWP92KskYXdepGbhtqOeX70Ix4exmPMXxkSJMP1Yd9GGTcQ7vdpQGE
	 MtADZyHhRC8G2p4vaAMCgqkqfhhyKy4FkcAdp4tb9CQUAeDOLnRVOVBde7FtbyVOlz
	 c8o9+wZabiC4g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 585Dh7RY11403849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 21:43:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 5 Sep 2025 21:43:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 5 Sep 2025 21:43:06 +0800
From: Hau <hau@realtek.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd <nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] r8169: set EEE speed down ratio to 1
Thread-Topic: [PATCH net-next] r8169: set EEE speed down ratio to 1
Thread-Index: AQHcHUE6wESi95i7Y0uNfg+X46GTibSCBioAgAKS+wA=
Date: Fri, 5 Sep 2025 13:43:06 +0000
Message-ID: <9d8e60df8e4b464cb28c7e421b9df45a@realtek.com>
References: <20250904021123.5734-1-hau@realtek.com>
 <d78dd279-54ed-46c3-b0b1-09c0be04557a@gmail.com>
In-Reply-To: <d78dd279-54ed-46c3-b0b1-09c0be04557a@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiANCj4gT24gOS80LzIwMjUgNDoxMSBBTSwgQ2h1bkhhbyBMaW4gd3JvdGU6DQo+ID4gRUVFIHNw
ZWVkIGRvd24gcmF0aW8gKG1hYyBvY3AgMHhlMDU2Wzc6NF0pIGlzIHVzZWQgdG8gY29udHJvbCBF
RUUNCj4gPiBzcGVlZCBkb3duIHJhdGUuIFRoZSBsYXJnZXIgdGhpcyB2YWx1ZSBpcywgdGhlIG1v
cmUgcG93ZXIgY2FuIHNhdmUuDQo+ID4gQnV0IGl0IGFjdHVhbGx5IHNhdmUgbGVzcyBwb3dlciB0
aGVuIGV4cGVjdGVkLCBidXQgd2lsbCBpbXBhY3QNCj4gPiBjb21wYXRpYmlsaXR5LiBTbyBzZXQg
aXQgdG8gMSAobWFjIG9jcCAweGUwNTZbNzo0XSA9IDApIHRvIGltcHJvdmUNCj4gY29tcGF0aWJp
bGl0eS4NCj4gPg0KPiBIaSBIYXUsDQo+IA0KPiB3aGF0IGtpbmQgb2Ygc3BlZWQgaXMgdGhpcyBy
ZWZlcnJpbmcgdG8/IFNvbWUgY2xvY2ssIG9yIGxpbmsgc3BlZWQsIG9yIC4uPw0KPiBJcyBFRUUg
c3BlZWQgZG93biBhIFJlYWx0ZWstc3BlY2lmaWMgZmVhdHVyZT8NCj4gDQo+IEFyZSB0aGVyZSBr
bm93biBpc3N1ZXMgd2l0aCB0aGUgdmFsdWVzIHVzZWQgY3VycmVudGx5PyBEZXBlbmRpbmcgb24g
dGhlDQo+IGFuc3dlciB3ZSBtaWdodCBjb25zaWRlciB0aGlzIGEgZml4Lg0KPiANCkl0IG1lYW5z
IGNsb2NrIChNQUMgTUNVKSBzcGVlZCBkb3duLiBJdCBpcyBub3QgZnJvbSBzcGVjLCBzbyBpdCBp
cyBraW5kIG9mIFJlYWx0ZWsgc3BlY2lmaWMgZmVhdHVyZS4NCkl0IG1heSBjYXVzZSBwYWNrZXQg
ZHJvcCBvciBpbnRlcnJ1cHQgbG9zcyAoZGlmZmVyZW50IGhhcmR3YXJlIG1heSBoYXZlIGRpZmZl
cmVudCBpc3N1ZSkuDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bkhhbyBMaW4gPGhhdUBy
ZWFsdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9y
ODE2OV9tYWluLmMgfCA2ICsrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9y
ZWFsdGVrL3I4MTY5X21haW4uYw0KPiA+IGluZGV4IDljNjAxZjI3MWMwMi4uZTU0MjdkZmNlMjY4
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFp
bi5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMN
Cj4gPiBAQCAtMzQwOSw3ICszNDA5LDcgQEAgc3RhdGljIHZvaWQgcnRsX2h3X3N0YXJ0XzgxNjho
XzEoc3RydWN0DQo+IHJ0bDgxNjlfcHJpdmF0ZSAqdHApDQo+ID4gICAgICAgICAgICAgICByODE2
OF9tYWNfb2NwX21vZGlmeSh0cCwgMHhkNDEyLCAweDBmZmYsIHN3X2NudF8xbXNfaW5pKTsNCj4g
PiAgICAgICB9DQo+ID4NCj4gPiAtICAgICByODE2OF9tYWNfb2NwX21vZGlmeSh0cCwgMHhlMDU2
LCAweDAwZjAsIDB4MDA3MCk7DQo+ID4gKyAgICAgcjgxNjhfbWFjX29jcF9tb2RpZnkodHAsIDB4
ZTA1NiwgMHgwMGYwLCAweDAwMDApOw0KPiA+ICAgICAgIHI4MTY4X21hY19vY3BfbW9kaWZ5KHRw
LCAweGUwNTIsIDB4NjAwMCwgMHg4MDA4KTsNCj4gPiAgICAgICByODE2OF9tYWNfb2NwX21vZGlm
eSh0cCwgMHhlMGQ2LCAweDAxZmYsIDB4MDE3Zik7DQo+ID4gICAgICAgcjgxNjhfbWFjX29jcF9t
b2RpZnkodHAsIDB4ZDQyMCwgMHgwZmZmLCAweDA0N2YpOyBAQCAtMzUxNCw3DQo+ID4gKzM1MTQs
NyBAQCBzdGF0aWMgdm9pZCBydGxfaHdfc3RhcnRfODExNyhzdHJ1Y3QgcnRsODE2OV9wcml2YXRl
ICp0cCkNCj4gPiAgICAgICAgICAgICAgIHI4MTY4X21hY19vY3BfbW9kaWZ5KHRwLCAweGQ0MTIs
IDB4MGZmZiwgc3dfY250XzFtc19pbmkpOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+IC0gICAgIHI4
MTY4X21hY19vY3BfbW9kaWZ5KHRwLCAweGUwNTYsIDB4MDBmMCwgMHgwMDcwKTsNCj4gPiArICAg
ICByODE2OF9tYWNfb2NwX21vZGlmeSh0cCwgMHhlMDU2LCAweDAwZjAsIDB4MDAwMCk7DQo+ID4g
ICAgICAgcjgxNjhfbWFjX29jcF93cml0ZSh0cCwgMHhlYTgwLCAweDAwMDMpOw0KPiA+ICAgICAg
IHI4MTY4X21hY19vY3BfbW9kaWZ5KHRwLCAweGUwNTIsIDB4MDAwMCwgMHgwMDA5KTsNCj4gPiAg
ICAgICByODE2OF9tYWNfb2NwX21vZGlmeSh0cCwgMHhkNDIwLCAweDBmZmYsIDB4MDQ3Zik7IEBA
IC0zNzE1LDcNCj4gPiArMzcxNSw3IEBAIHN0YXRpYyB2b2lkIHJ0bF9od19zdGFydF84MTI1X2Nv
bW1vbihzdHJ1Y3QgcnRsODE2OV9wcml2YXRlDQo+ICp0cCkNCj4gPiAgICAgICByODE2OF9tYWNf
b2NwX21vZGlmeSh0cCwgMHhjMGI0LCAweDAwMDAsIDB4MDAwYyk7DQo+ID4gICAgICAgcjgxNjhf
bWFjX29jcF9tb2RpZnkodHAsIDB4ZWI2YSwgMHgwMGZmLCAweDAwMzMpOw0KPiA+ICAgICAgIHI4
MTY4X21hY19vY3BfbW9kaWZ5KHRwLCAweGViNTAsIDB4MDNlMCwgMHgwMDQwKTsNCj4gPiAtICAg
ICByODE2OF9tYWNfb2NwX21vZGlmeSh0cCwgMHhlMDU2LCAweDAwZjAsIDB4MDAzMCk7DQo+ID4g
KyAgICAgcjgxNjhfbWFjX29jcF9tb2RpZnkodHAsIDB4ZTA1NiwgMHgwMGYwLCAweDAwMDApOw0K
PiA+ICAgICAgIHI4MTY4X21hY19vY3BfbW9kaWZ5KHRwLCAweGUwNDAsIDB4MTAwMCwgMHgwMDAw
KTsNCj4gPiAgICAgICByODE2OF9tYWNfb2NwX21vZGlmeSh0cCwgMHhlYTFjLCAweDAwMDMsIDB4
MDAwMSk7DQo+ID4gICAgICAgaWYgKHRwLT5tYWNfdmVyc2lvbiA9PSBSVExfR0lHQV9NQUNfVkVS
XzcwIHx8DQoNCg==

