Return-Path: <netdev+bounces-195618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B080AD17D5
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 06:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32895168871
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 04:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE52419309E;
	Mon,  9 Jun 2025 04:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="UGrEeaVK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F913957E;
	Mon,  9 Jun 2025 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749443488; cv=none; b=SB/PRcL+Gkadf9BMvrYMXQEXYvtNPgVrJuqPkUdu65JcsXqKK4vFeo5UrcA9KhWKGy92IGyLOxGTGgozu9+ptAUxuJi2rng010u0LJH21bWLG5J59755vdYnXzU2FmbzwM9sJfoW7HIS3G5PIoSwQVGsSo3rnYrJKUIwmhHs9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749443488; c=relaxed/simple;
	bh=CKlXlMt6NoiAFVTxB2bXnrWWb7c0qqpm5sB/5ymLE2I=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HfpJnYULZs7bGiNnl8yI4WvISx80CaMxIB0MAMQCd+xaRQ85xd65IcxCQZAAD5UIkdDOUVht7h4XBpVyouzDQB1s/cLfkx3LRoZ21PlMhVoCcYsMkRG6h1qa6i/YAoGp1brz2Bklkkg7xePcNLwaE53hONE7Ckk4wAsN5+BM050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=UGrEeaVK; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749443488; x=1780979488;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=CKlXlMt6NoiAFVTxB2bXnrWWb7c0qqpm5sB/5ymLE2I=;
  b=UGrEeaVKcQYgXbkERLBvJOplxYSOIO43x8ZMCpsRYg5KJrhWoAh/wUBY
   5k+QLgrLUnWzBw1fvFJFsCo7ID0yX+QedgSSIsERDDnqB9uRmYwCEKXKg
   7svMDzyFCg1YgjYRYikT6JDPB6Z+Uja6/dUlEdHMKaPTmrrLK118egUo3
   NGVNrV1xQOh7BtLtt5VRcXMC2FYve2CClWZ8qQdD65DZlAxnO0C7hRfC+
   z7G19GPt+WoeaygVWcVmEOZEB5JR6UgPvl6rJtHaadsp5oyn32qfyLMCC
   79TrzCpbH+wtuxv6kuLg5mQlBjvGxJh1cMaf98kaaIYJtjH117UOZyaHB
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,221,1744070400"; 
   d="scan'208";a="306689532"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 04:31:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:41619]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.175:2525] with esmtp (Farcaster)
 id 4421e3d6-11e0-409f-bc9a-3144297fb406; Mon, 9 Jun 2025 04:31:22 +0000 (UTC)
X-Farcaster-Flow-ID: 4421e3d6-11e0-409f-bc9a-3144297fb406
Received: from EX19D004ANA004.ant.amazon.com (10.37.240.146) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 9 Jun 2025 04:31:21 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D004ANA004.ant.amazon.com (10.37.240.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 9 Jun 2025 04:31:19 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.1544.014; Mon, 9 Jun 2025 04:31:17 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, "Iwashima,
 Kuniyuki" <kuniyu@amazon.co.jp>, "kuznet@ms2.inr.ac.ru"
	<kuznet@ms2.inr.ac.ru>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "sashal@kernel.org" <sashal@kernel.org>,
	"yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
Subject: RE: [PATCH] net/ipv4: fix type mismatch in inet_ehash_locks_alloc()
 causing build failure
Thread-Topic: [PATCH] net/ipv4: fix type mismatch in inet_ehash_locks_alloc()
 causing build failure
Thread-Index: AdvY9wJYSlvxky1DZ0ar7syXPxglhQ==
Date: Mon, 9 Jun 2025 04:31:17 +0000
Message-ID: <d5c2130c18b74a57bb23c4f37b901d2c@amazon.com>
Accept-Language: en-US
Content-Language: en-US
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

PiBGcm9tOiBLdW5peXVraSBJd2FzaGltYSA8a3VuaTE4NDBAZ21haWwuY29tPg0KPiBEYXRlOiBT
dW4sICA4IEp1biAyMDI1IDEzOjExOjUxIC0wNzAwDQo+ID4gRnJvbTogRWxpYXYgRmFyYmVyIDxm
YXJiZXJlQGFtYXpvbi5jb20+DQo+ID4gRGF0ZTogU3VuLCA4IEp1biAyMDI1IDA2OjA3OjI2ICsw
MDAwDQo+ID4gPiBGaXggY29tcGlsYXRpb24gd2FybmluZzoNCj4gPiA+DQo+ID4gPiBJbiBmaWxl
IGluY2x1ZGVkIGZyb20gLi9pbmNsdWRlL2xpbnV4L2tlcm5lbC5oOjE1LA0KPiA+ID4gICAgICAg
ICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9saXN0Lmg6OSwNCj4gPiA+ICAgICAgICAg
ICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvbW9kdWxlLmg6MTIsDQo+ID4gPiAgICAgICAg
ICAgICAgICAgIGZyb20gbmV0L2lwdjQvaW5ldF9oYXNodGFibGVzLmM6MTI6DQo+ID4gPiBuZXQv
aXB2NC9pbmV0X2hhc2h0YWJsZXMuYzogSW4gZnVuY3Rpb24g4oCYaW5ldF9laGFzaF9sb2Nrc19h
bGxvY+KAmToNCj4gPiA+IC4vaW5jbHVkZS9saW51eC9taW5tYXguaDoyMDozNTogd2FybmluZzog
Y29tcGFyaXNvbiBvZiBkaXN0aW5jdCBwb2ludGVyIHR5cGVzIGxhY2tzIGEgY2FzdA0KPiA+ID4g
ICAgMjAgfCAgICAgICAgICghIShzaXplb2YoKHR5cGVvZih4KSAqKTEgPT0gKHR5cGVvZih5KSAq
KTEpKSkNCj4gPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+
DQo+ID4gPiAuL2luY2x1ZGUvbGludXgvbWlubWF4Lmg6MjY6MTg6IG5vdGU6IGluIGV4cGFuc2lv
biBvZiBtYWNybyDigJhfX3R5cGVjaGVja+KAmQ0KPiA+ID4gICAgMjYgfCAgICAgICAgICAgICAg
ICAgKF9fdHlwZWNoZWNrKHgsIHkpICYmIF9fbm9fc2lkZV9lZmZlY3RzKHgsIHkpKQ0KPiA+ID4g
ICAgICAgfCAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+DQo+ID4gPiAuL2luY2x1ZGUvbGlu
dXgvbWlubWF4Lmg6MzY6MzE6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhfX3NhZmVf
Y21w4oCZDQo+ID4gPiAgICAzNiB8ICAgICAgICAgX19idWlsdGluX2Nob29zZV9leHByKF9fc2Fm
ZV9jbXAoeCwgeSksIFwNCj4gPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXn5+fn5+fn5+fg0KPiA+ID4gLi9pbmNsdWRlL2xpbnV4L21pbm1heC5oOjUyOjI1OiBub3Rl
OiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYX19jYXJlZnVsX2NtcOKAmQ0KPiA+ID4gICAgNTIg
fCAjZGVmaW5lIG1heCh4LCB5KSAgICAgICBfX2NhcmVmdWxfY21wKHgsIHksID4pDQo+ID4gPiAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn4NCj4gPiA+IG5ldC9p
cHY0L2luZXRfaGFzaHRhYmxlcy5jOjk0NjoxOTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3Jv
IOKAmG1heOKAmQ0KPiA+ID4gICA5NDYgfCAgICAgICAgIG5ibG9ja3MgPSBtYXgobmJsb2Nrcywg
bnVtX29ubGluZV9ub2RlcygpICogUEFHRV9TSVpFIC8gbG9ja3N6KTsNCj4gPiA+ICAgICAgIHwg
ICAgICAgICAgICAgICAgICAgXn5+DQo+ID4gPiAgIENDICAgICAgYmxvY2svYmFkYmxvY2tzLm8N
Cj4gPiA+DQo+ID4gPiBXaGVuIHdhcm5pbmdzIGFyZSB0cmVhdGVkIGFzIGVycm9ycywgdGhpcyBj
YXVzZXMgdGhlIGJ1aWxkIHRvIGZhaWwuDQo+ID4gPg0KPiA+ID4gVGhlIGlzc3VlIGlzIGEgdHlw
ZSBtaXNtYXRjaCBiZXR3ZWVuIHRoZSBvcGVyYW5kcyBwYXNzZWQgdG8gdGhlIG1heCgpDQo+ID4g
PiBtYWNyby4gSGVyZSwgbmJsb2NrcyBpcyBhbiB1bnNpZ25lZCBpbnQsIHdoaWxlIHRoZSBleHBy
ZXNzaW9uDQo+ID4gPiBudW1fb25saW5lX25vZGVzKCkgKiBQQUdFX1NJWkUgLyBsb2Nrc3ogaXMg
cHJvbW90ZWQgdG8gdW5zaWduZWQgbG9uZy4NCj4gPiA+DQo+ID4gPiBUaGlzIGhhcHBlbnMgYmVj
YXVzZToNCj4gPiA+ICAtIG51bV9vbmxpbmVfbm9kZXMoKSByZXR1cm5zIGludA0KPiA+ID4gIC0g
UEFHRV9TSVpFIGlzIHR5cGljYWxseSBkZWZpbmVkIGFzIGFuIHVuc2lnbmVkIGxvbmcgKGRlcGVu
ZGluZyBvbiB0aGUNCj4gPiA+ICAgIGFyY2hpdGVjdHVyZSkNCj4gPiA+ICAtIGxvY2tzeiBpcyB1
bnNpZ25lZCBpbnQNCj4gPiA+DQo+ID4gPiBUaGUgcmVzdWx0aW5nIGFyaXRobWV0aWMgZXhwcmVz
c2lvbiBpcyBwcm9tb3RlZCB0byB1bnNpZ25lZCBsb25nLg0KPiA+ID4NCj4gPiA+IFRodXMsIHRo
ZSBtYXgoKSBtYWNybyBjb21wYXJlcyB2YWx1ZXMgb2YgZGlmZmVyZW50IHR5cGVzOiB1bnNpZ25l
ZCBpbnQNCj4gPiA+IHZzIHVuc2lnbmVkIGxvbmcuDQo+ID4gPg0KPiA+ID4gVGhpcyBpc3N1ZSB3
YXMgaW50cm9kdWNlZCBpbiBjb21taXQgYjUzZDZlOTUyNWFmICgidGNwOiBicmluZyBiYWNrIE5V
TUENCj4gPiA+IGRpc3BlcnNpb24gaW4gaW5ldF9laGFzaF9sb2Nrc19hbGxvYygpIikgZHVyaW5n
IHRoZSB1cGRhdGUgZnJvbSBrZXJuZWwNCj4gPiA+IHY1LjEwLjIzNyB0byB2NS4xMC4yMzguDQo+
ID4NCj4gPiBQbGVhc2UgdXNlIHRoZSB1cHN0cmVhbSBTSEExLCBmOGVjZTQwNzg2YzkuDQpGaXhl
ZCBpbiBWMg0KDQo+ID4gPiBJdCBkb2VzIG5vdCBleGlzdCBpbiBuZXdlciBrZXJuZWwgYnJhbmNo
ZXMgKGUuZy4sIHY1LjE1LjE4NSBhbmQgYWxsIDYueA0KPiA+ID4gYnJhbmNoZXMpLCBiZWNhdXNl
IHRoZXkgaW5jbHVkZSBjb21taXQgZDUzYjVkODYyYWNkICgibWlubWF4OiBhbGxvdw0KPiA+DQo+
ID4gU2FtZSBoZXJlLCBkMDNlYmE5OWY1YmYuDQpGaXhlZCBpbiBWMg0KDQo+ID4gQnV0IHdoeSBu
b3QgYmFja3BvcnQgaXQgdG8gc3RhYmxlIGluc3RlYWQgPw0KPg0KPiBJIGp1c3QgY2hlY2tlZCB0
aGUgNS4xMC4yMzggdGhyZWFkLg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9zdGFibGUvMjAy
NTA2MDQxMi1jdXJzb3ItbmF2aWdhdGUtMTI2ZEBncmVna2gvDQo+DQo+IC0tLTg8LS0tDQo+ID4g
PiBGb3IgYm90aCBvZiB0aGVzZSwgSSdsbCBqdXN0IGxldCB0aGVtIGJlIGFzIHRoZXkgYXJlIG9r
LCBpdCdzIGp1c3QgdGhlDQo+ID4gPiBtZXNzIG9mIG91ciBtaW4vbWF4IG1hY3JvIHVud2luZGlu
ZyBjYXVzZXMgdGhlc2UgaXNzdWVzLg0KPiA+ID4NCj4gPiA+IFVubGVzcyB0aGV5IHJlYWxseSBi
b3RoZXIgc29tZW9uZSwgYW5kIGluIHRoYXQgY2FzZSwgYSBwYXRjaCB0byBhZGQgdGhlDQo+ID4g
PiBjb3JyZWN0IHR5cGUgdG8gdGhlIGJhY2twb3J0IHRvIG1ha2UgdGhlIG5vaXNlIGdvIGF3YXkg
d291bGQgYmUgZ3JlYXRseQ0KPiA+ID4gYXBwcmVjaWF0ZWQuDQo+ID4NCj4gPiBZZWFoIHRoYXQn
cyBhIHJlYXNvbmFibGUgcmVzb2x1dGlvbiwgSSB3aWxsIHRyeSB0byB0cmFjayBkb3duIHRoZSBt
aXNzaW5nDQo+ID4gcGF0Y2hlcyBmb3IgbWlubWF4Lmggc28gd2UgYXJlIHdhcm5pbmcgZnJlZSBm
b3IgdGhlIHN0YWJsZSBrZXJuZWxzLg0KPg0KPiBJIHRyaWVkIGluIHRoZSBwYXN0LCBpdCdzIG5v
bi10cml2aWFsLiAgV2hhdCB3b3VsZCBiZSBlYXNpZXIgaXMgdG8ganVzdA0KPiBwcm9wZXJseSBj
YXN0IHRoZSB2YXJpYWJsZXMgaW4gdGhlIHBsYWNlcyB3aGVyZSB0aGlzIHdhcm5pbmcgaXMgc2hv
d2luZw0KPiB1cCB0byBnZXQgcmlkIG9mIHRoYXQgd2FybmluZy4gIFdlJ3ZlIGRvbmUgdGhhdCBp
biBzb21lIGJhY2twb3J0cyBpbiB0aGUNCj4gcGFzdCBhcyB3ZWxsLg0KPiAtLS04PC0tLQ0KPg0K
PiBTbyB0aGlzIHNob3VsZCBiZSBmaXhlZCB1cCBpbiB0aGUgYmFja3BvcnQsIGFuZCBJIGd1ZXNz
IHRoaXMgcGF0Y2gNCj4gdGFyZ2V0ZWQgdGhlIHN0YWJsZSB0cmVlcyA/DQpUaGlzIHBhdGNoIGlz
IGZvciB2NS4xMC4yMzguIE5ld2VyIGtlcm5lbHMgZG9uJ3QgbmVlZCBpdC4NCg0KPiBJZiBzbywg
cGxlYXNlIGNsYXJpZnkgdGhhdCBieSBzcGVjaWZ5aW5nIHRoZSBzdGFibGUgdmVyc2lvbiBpbiB0
aGUNCj4gc3ViamVjdCBhbmQgQ0NpbmcgdGhlIHN0YWJsZSBtYWlubGluZyBsaXN0Og0KPg0KPiAg
IFN1YmplY3Q6IFtQQVRDSCA1LjEwLnldIHRjcDogLi4uDQo+ICAgQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcsIC4uLg0KRG9uZSBpbiB2Mg0K

