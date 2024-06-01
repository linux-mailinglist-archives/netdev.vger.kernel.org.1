Return-Path: <netdev+bounces-99926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9848D707F
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 16:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D1EB20F67
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 14:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567D615219A;
	Sat,  1 Jun 2024 14:57:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F031DFF7
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717253821; cv=none; b=G15gS9z6vtqxw+Mlx2GWiNzVAF8SVrsTKdA4ovqigEa60tgSw0Jz1TVR7rpbqANwSbYNgmN3xt5DaAfuNdicQJWt7rvyGhHU4BlWIGSYXIrSPqJPA5uHB5ATRsjHgmnvakCQq29FU+IN9+cNEoQJOzNfflQt21bB/BiAvEtLzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717253821; c=relaxed/simple;
	bh=HZnCo3wQtaIf2ahKEccUfI911Z9m8a2s+qtmS/jVSOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ZJrDwlOCatK2ZEbvTvm10rNXqbRTttJu7X/J87/gYKLzv334juN+ZqOSTbgb+zyJnKWTghfeXqJPldrfs2MM9nY2UkPI+BTLEidOUm+ItPBqlFM+V56AnZVya4iUwcXDSfbphTyTyOsjf5ALhrq8p+l/pKoCAxDTSx1I1aFClDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-91-t18LWRC-PjmfC68e6WkWXg-1; Sat, 01 Jun 2024 15:56:50 +0100
X-MC-Unique: t18LWRC-PjmfC68e6WkWXg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 1 Jun
 2024 15:56:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 1 Jun 2024 15:56:17 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kevin Yang' <yyd@google.com>, David Miller <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "ycheng@google.com" <ycheng@google.com>,
	"kerneljasonxing@gmail.com" <kerneljasonxing@gmail.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
Subject: RE: [PATCH net-next v2 1/2] tcp: derive delack_max with tcp_rto_min
 helper
Thread-Topic: [PATCH net-next v2 1/2] tcp: derive delack_max with tcp_rto_min
 helper
Thread-Index: AQHasqb0w6/IyFZHd0G3GBnIxbYel7GzAZwg
Date: Sat, 1 Jun 2024 14:56:17 +0000
Message-ID: <160254f0fe9e4c829dfbe9420b704750@AcuMS.aculab.com>
References: <20240530153436.2202800-1-yyd@google.com>
 <20240530153436.2202800-2-yyd@google.com>
In-Reply-To: <20240530153436.2202800-2-yyd@google.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogS2V2aW4gWWFuZw0KPiBTZW50OiAzMCBNYXkgMjAyNCAxNjozNQ0KPiBUbzogRGF2aWQg
TWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29n
bGUuY29tPjsgSmFrdWIgS2ljaW5za2kNCj4gDQo+IFJ0b19taW4gbm93IGhhcyBtdWx0aXBsZSBz
b3VjZXMsIG9yZGVyZWQgYnkgcHJlcHJlY2VkZW5jZSBoaWdoIHRvDQo+IGxvdzogaXAgcm91dGUg
b3B0aW9uIHJ0b19taW4sIGljc2stPmljc2tfcnRvX21pbi4NCj4gDQo+IFdoZW4gZGVyaXZlIGRl
bGFja19tYXggZnJvbSBydG9fbWluLCB3ZSBzaG91bGQgbm90IG9ubHkgdXNlIGlwDQo+IHJvdXRl
IG9wdGlvbiwgYnV0IHNob3VsZCB1c2UgdGNwX3J0b19taW4gaGVscGVyIHRvIGdldCB0aGUgY29y
cmVjdA0KPiBydG9fbWluLg0KLi4uDQo+IGRpZmYgLS1naXQgYS9uZXQvaXB2NC90Y3Bfb3V0cHV0
LmMgYi9uZXQvaXB2NC90Y3Bfb3V0cHV0LmMNCj4gaW5kZXggZjk3ZTA5OGYxOGE1Li5iNDRmNjM5
YTlmYTYgMTAwNjQ0DQo+IC0tLSBhL25ldC9pcHY0L3RjcF9vdXRwdXQuYw0KPiArKysgYi9uZXQv
aXB2NC90Y3Bfb3V0cHV0LmMNCj4gQEAgLTQxNjMsMTYgKzQxNjMsOSBAQCBFWFBPUlRfU1lNQk9M
KHRjcF9jb25uZWN0KTsNCj4gDQo+ICB1MzIgdGNwX2RlbGFja19tYXgoY29uc3Qgc3RydWN0IHNv
Y2sgKnNrKQ0KPiAgew0KPiAtCWNvbnN0IHN0cnVjdCBkc3RfZW50cnkgKmRzdCA9IF9fc2tfZHN0
X2dldChzayk7DQo+IC0JdTMyIGRlbGFja19tYXggPSBpbmV0X2NzayhzayktPmljc2tfZGVsYWNr
X21heDsNCj4gLQ0KPiAtCWlmIChkc3QgJiYgZHN0X21ldHJpY19sb2NrZWQoZHN0LCBSVEFYX1JU
T19NSU4pKSB7DQo+IC0JCXUzMiBydG9fbWluID0gZHN0X21ldHJpY19ydHQoZHN0LCBSVEFYX1JU
T19NSU4pOw0KPiAtCQl1MzIgZGVsYWNrX2Zyb21fcnRvX21pbiA9IG1heF90KGludCwgMSwgcnRv
X21pbiAtIDEpOw0KPiArCXUzMiBkZWxhY2tfZnJvbV9ydG9fbWluID0gbWF4X3QoaW50LCAxLCB0
Y3BfcnRvX21pbihzaykgLSAxKTsNCg0KVGhhdCBtYXhfdCgpIGlzIG1vcmUgaG9ycmlkIHRoYW4g
bW9zdC4NClBlcmhhcHM6DQoJCT0gbWF4KHRjcF9ydG9fbWluKHNrKSwgMikgLSAxOw0KDQo+IA0K
PiAtCQlkZWxhY2tfbWF4ID0gbWluX3QodTMyLCBkZWxhY2tfbWF4LCBkZWxhY2tfZnJvbV9ydG9f
bWluKTsNCj4gLQl9DQo+IC0JcmV0dXJuIGRlbGFja19tYXg7DQo+ICsJcmV0dXJuIG1pbl90KHUz
MiwgaW5ldF9jc2soc2spLT5pY3NrX2RlbGFja19tYXgsIGRlbGFja19mcm9tX3J0b19taW4pOw0K
DQpDYW4gdGhhdCBqdXN0IGJlIGEgbWluKCkgPz8NCg0KCURhdmlkDQoNCj4gIH0NCj4gDQo+ICAv
KiBTZW5kIG91dCBhIGRlbGF5ZWQgYWNrLCB0aGUgY2FsbGVyIGRvZXMgdGhlIHBvbGljeSBjaGVj
a2luZw0KPiAtLQ0KPiAyLjQ1LjEuMjg4LmcwZTBjZDI5OWYxLWdvb2cNCj4gDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


