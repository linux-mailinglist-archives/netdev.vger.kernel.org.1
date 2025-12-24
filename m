Return-Path: <netdev+bounces-245930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 651A3CDB01E
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 01:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D8BF301EFAD
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 00:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56A130E0D2;
	Wed, 24 Dec 2025 00:49:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0028A1E6
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 00:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766537340; cv=none; b=ZzkpSIaaKjoTNNjakwiItIjOx/ECWpQmtkNx/FFV+sH4obk8i/fY+41KyEw2NBH24/KpXB91o/XVLTvnMLJh3c62rs6UQ5C6qLrLWNh9ZJCG9UE4+aq9INRtqe/+zOmMXhSWufrcKUJGOtpVPv/8okz7sd8h59q+5VQZWl1Rhcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766537340; c=relaxed/simple;
	bh=27R/8EixYfFGEmnwRRpOv9VpmBtsnRRac/60veIk4sE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q3ubmyUAN12fbgsJtqX198CBuN06SlxxgK/wQVEmqyn/mpPm2xnskWm5ztyaF1MLPkPL2gkMmGZEyhLKtHTa6SahUKhzUr4O7JPGSUuhvFzjkZ/H2urzu0JSlclJKwmktxW17FUXQ6YCC1SsI6/qEW+1c9VIW7uBsd0cP/X5maw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4dbYCT2Jtfz1YQpmG;
	Wed, 24 Dec 2025 08:48:37 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4dbYCR5jBwz1YQpmG;
	Wed, 24 Dec 2025 08:48:35 +0800 (CST)
Received: from cncheex05.Hygon.cn (unknown [172.23.18.115])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 69D24363A1B8;
	Wed, 24 Dec 2025 08:44:06 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex05.Hygon.cn
 (172.23.18.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 24 Dec
 2025 08:48:36 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Wed, 24 Dec 2025 08:48:36 +0800
From: Zhud <zhud@hygon.cn>
To: Eric Dumazet <edumazet@google.com>
CC: Paolo Abeni <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jing Li <lijing@hygon.cn>, Zhiwei Ying <yingzhiwei@hygon.cn>
Subject: RE: [PATCH net] netdev: increment TSO only if TSO is not enabled on
 any slave device
Thread-Topic: [PATCH net] netdev: increment TSO only if TSO is not enabled on
 any slave device
Thread-Index: AQHcbmlNWOTIX90gx02lh/ymGCh5arUukjiAgACaXqD//6argIABLLoA
Date: Wed, 24 Dec 2025 00:48:36 +0000
Message-ID: <355e6f707b57413098af339d0bd6dcba@hygon.cn>
References: <20251216085210.132387-1-zhud@hygon.cn>
 <eae60389-27a5-4e8f-af49-7f75d4c116d8@redhat.com>
 <fe236a552f594780a4b2ead63b4bc329@hygon.cn>
 <CANn89i+p0UX1VW9Pm6_B5tJ-_b_iwJP5Dkk_Agnf+46FD2jY-g@mail.gmail.com>
In-Reply-To: <CANn89i+p0UX1VW9Pm6_B5tJ-_b_iwJP5Dkk_Agnf+46FD2jY-g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiANCj4gT24gVHVlLCBEZWMgMjMsIDIwMjUgYXQgMToyMOKAr1BNIFpodWQgPHpodWRAaHlnb24u
Y24+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPiA+IE9uIDEyLzE2LzI1IDk6NTIgQU0sIERpIFpodSB3
cm90ZToNCj4gPiA+ID4gVW5jb25kaXRpb25hbGx5IGluY3JlbWVudCB0aGUgVFNPIGZsYWcgaGFz
IGEgc2lkZSBlZmZlY3Q6IGl0IHdpbGwNCj4gPiA+ID4gYWxzbw0KPiA+ID4NCj4gPiA+IFRoaXMg
Y2hhbmdlbG9nIGlzIElNSE8gcXVpdGUgY29uZnVzaW5nLiBUaGUgY29kZSBkb2VzIG5vdCAnaW5j
cmVtZW50DQo+ID4gPiBUU08nLiBJbnN0ZWFkIGl0IGluY3JlbWVudHMgdGhlIGZlYXR1cmVzIHNl
dCB0byBpbmNsdWRlIEFMTF9UU08uDQo+ID4gPg0KPiA+ID4gUGxlYXNlIHJld29yZCB0aGUgY2hh
bmdlbG9nIGFjY29yZGluZ2x5Lg0KPiA+ID4NCj4gPiA+ID4gZGlyZWN0bHkgY2xlYXIgdGhlIGZs
YWdzIGluIE5FVElGX0ZfQUxMX0ZPUl9BTEwgb24gdGhlIG1hc3Rlcg0KPiA+ID4gPiBkZXZpY2Us
IHdoaWNoIGNhbiBjYXVzZSBpc3N1ZXMgc3VjaCBhcyB0aGUgaW5hYmlsaXR5IHRvIGVuYWJsZSB0
aGUNCj4gPiA+ID4gbm9jYWNoZSBjb3B5IGZlYXR1cmUgb24gdGhlIGJvbmRpbmcgbmV0d29yayBj
YXJkLg0KPiA+ID4NCj4gPiA+IGJvbmRpbmcgbmV0d29yayBjYXJkIC0+IGJvbmRpbmcgZHJpdmVy
Lg0KPiA+ID4NCj4gPiA+ID4gU28sIHdoZW4gYXQgbGVhc3Qgb25lIHNsYXZlIGRldmljZSdzIFRT
TyBpcyBlbmFibGVkLCB0aGVyZSBpcyBubw0KPiA+ID4gPiBuZWVkIHRvIGV4cGxpY2l0bHkgaW5j
cmVtZW50IHRoZSBUU08gZmxhZyB0byB0aGUgbWFzdGVyIGRldmljZS4NCj4gPiA+ID4NCj4gPiA+
ID4gRml4ZXM6IGIwY2UzNTA4YjI1ZSAoImJvbmRpbmc6IGFsbG93IFRTTyBiZWluZyBzZXQgb24g
Ym9uZGluZw0KPiA+ID4gPiBtYXN0ZXIiKQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEaSBaaHUg
PHpodWRAaHlnb24uY24+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgaW5jbHVkZS9saW51eC9uZXRk
ZXZpY2UuaCB8IDMgKystDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L25ldGRldmljZS5oIGIvaW5jbHVkZS9saW51eC9uZXRkZXZpY2UuaA0KPiA+ID4gPiBpbmRl
eCBiZjk5ZmU4NjIyZGEuLjJhY2EzOWY3ZjllMSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvaW5jbHVk
ZS9saW51eC9uZXRkZXZpY2UuaA0KPiA+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L25ldGRldmlj
ZS5oDQo+ID4gPiA+IEBAIC01MzIyLDcgKzUzMjIsOCBAQCBuZXRkZXZfZmVhdHVyZXNfdA0KPiA+
ID4gPiBuZXRkZXZfaW5jcmVtZW50X2ZlYXR1cmVzKG5ldGRldl9mZWF0dXJlc190IGFsbCwgIHN0
YXRpYyBpbmxpbmUNCj4gPiA+IG5ldGRldl9mZWF0dXJlc190IG5ldGRldl9hZGRfdHNvX2ZlYXR1
cmVzKG5ldGRldl9mZWF0dXJlc190DQo+ID4gPiBmZWF0dXJlcywNCj4gPiA+ID4NCj4gPiA+ID4g
bmV0ZGV2X2ZlYXR1cmVzX3QgbWFzaykgIHsNCj4gPiA+ID4gLSAgIHJldHVybiBuZXRkZXZfaW5j
cmVtZW50X2ZlYXR1cmVzKGZlYXR1cmVzLCBORVRJRl9GX0FMTF9UU08sIG1hc2spOw0KPiA+ID4g
PiArICAgcmV0dXJuIChmZWF0dXJlcyAmIE5FVElGX0ZfQUxMX1RTTykgPyBmZWF0dXJlcyA6DQo+
ID4gPiA+ICsgICAgICAgICAgIG5ldGRldl9pbmNyZW1lbnRfZmVhdHVyZXMoZmVhdHVyZXMsIE5F
VElGX0ZfQUxMX1RTTywNCj4gPiA+ID4gKyBtYXNrKTsNCj4gPiA+DQo+ID4gPiBORVRJRl9GX0FM
TF9UU08gaXMgbm90IGEgc2luZ2xlIGJpdCwgYnV0IGEgKGxhdGVyIGxhcmdlKSBiaXQgbWFzazsN
Cj4gPiA+IHRoZSBhYm92ZSB3aWxsIHlpZWxkIGluY29ycmVjdCByZXN1bHQgd2hlbjoNCj4gPiA+
DQo+ID4gPiAgICAgICBmZWF0dXJlcyAmIE5FVElGX0ZfQUxMX1RTTyAhPSBORVRJRl9GX0FMTF9U
U08NCj4gPg0KPiA+IFllcywgaXQgaXMgaW5kZWVkIG5lY2Vzc2FyeSB0byBzZXQgYWxsIHRzbyBm
bGFncyB0byBhdm9pZCBHU08gYXQgdGhlIGJvbmRpbmcgbGF5ZXIuDQo+ID4gSSB3aWxsIHJldmlz
ZSB0aGUgY29kZSBhbmQgaXRzIHJlbGF0ZWQgY2hhbmdsb25nLCB0aGFua3MuDQo+IA0KPiBXaGF0
IGFib3V0IHRoaXMgaW5zdGVhZCA/DQo+IA0KPiAgc3RhdGljIGlubGluZSBuZXRkZXZfZmVhdHVy
ZXNfdA0KPiBuZXRkZXZfYWRkX3Rzb19mZWF0dXJlcyhuZXRkZXZfZmVhdHVyZXNfdCBmZWF0dXJl
cywNCj4gDQo+IG5ldGRldl9mZWF0dXJlc190IG1hc2spICB7DQo+IC0gICAgICAgcmV0dXJuIG5l
dGRldl9pbmNyZW1lbnRfZmVhdHVyZXMoZmVhdHVyZXMsIE5FVElGX0ZfQUxMX1RTTywgbWFzayk7
DQo+ICsgICAgICAgcmV0dXJuIG5ldGRldl9pbmNyZW1lbnRfZmVhdHVyZXMoZmVhdHVyZXMsIE5F
VElGX0ZfQUxMX1RTTyB8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTkVUSUZfRl9BTExfRk9SX0FMTCwgbWFzayk7DQo+ICB9DQoNClllcywgSSBhbHNvIHdhbnQg
dG8gZG8gaXQgdGhpcyB3YXkuDQoNCg==


