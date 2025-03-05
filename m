Return-Path: <netdev+bounces-171925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3976A4F729
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 07:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 222BC3A9C1A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 06:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8787E1CAA62;
	Wed,  5 Mar 2025 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JFZiB0Dz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2331C8623
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156431; cv=none; b=PYRtuFWqbhB7ZuHw24lpWLp7f2nOd1ulXJdQhPFMEU0VgL5j7NHLQ3vps+BvhucK8FG/IRm+J4oI39fS0p78WuQabodD3TrRV0RR9PzL+j/g7APzj0k9S+PlHfxsfWpAgIMPe8yqGCy/XaIoYaPYv/B5DmfdZQBbdXHFhu1jm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156431; c=relaxed/simple;
	bh=z+IF9No7OLHO4+qOVuScG0w9GnvVuYlNb/xLxk7jWj8=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SbwA5wWFMEvLFQ1Y3xyZ+h38ssnVbOKnCvYnu/jf7Ev8Zv1AGOpDy+LOO0aft2unmf31MWJ2fDKMKYX2r+Dn5Z1XDosc/TTEl84qaOvJNFSD1molReVRF0tBc7CkN7WYR70yqdUulPZLTPBRjxbc7eCPzn7V8/77EdKcJvW2puY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JFZiB0Dz; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741156430; x=1772692430;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=z+IF9No7OLHO4+qOVuScG0w9GnvVuYlNb/xLxk7jWj8=;
  b=JFZiB0DzO8UgsXWUJ16b64UJljMfGjMDaCj+pbiv+jKjxFiNXzOEFO9T
   q5qySatyXzQ5K6zTC/o44R5dyQCYl7RXl/vlMZ1b6QxkZw22XndC2kiGh
   gaG0WeOl5MRmf8M7bOmxEihleaZ8oEy+OyewCpQKNDSls1A+92VKoLPNo
   w=;
X-IronPort-AV: E=Sophos;i="6.14,222,1736812800"; 
   d="scan'208";a="383319909"
Subject: RE: [Intel-wired-lan] [PATCH net-next v9 2/6] net: ena: use napi's aRFS rmap
 notifers
Thread-Topic: [Intel-wired-lan] [PATCH net-next v9 2/6] net: ena: use napi's aRFS rmap
 notifers
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:33:45 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:23460]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.42.72:2525] with esmtp (Farcaster)
 id 75370888-b229-4ae1-be21-074879c943a9; Wed, 5 Mar 2025 06:33:43 +0000 (UTC)
X-Farcaster-Flow-ID: 75370888-b229-4ae1-be21-074879c943a9
Received: from EX19D028EUB001.ant.amazon.com (10.252.61.99) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 5 Mar 2025 06:33:39 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D028EUB001.ant.amazon.com (10.252.61.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 5 Mar 2025 06:33:38 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Wed, 5 Mar 2025 06:33:38 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jdamato@fastly.com" <jdamato@fastly.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>, "tariqt@nvidia.com"
	<tariqt@nvidia.com>, "anthony.l.nguyen@intel.com"
	<anthony.l.nguyen@intel.com>, "przemyslaw.kitszel@intel.com"
	<przemyslaw.kitszel@intel.com>, "jdamato@fastly.com" <jdamato@fastly.com>,
	"shayd@nvidia.com" <shayd@nvidia.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Allen, Neil" <shayagr@amazon.com>
Thread-Index: AQHbjVYVdX12rl0kQ0S2hhy8miKGdrNkCHJA
Date: Wed, 5 Mar 2025 06:33:38 +0000
Message-ID: <abc6a4b765f84eb09efd7b10a62c4391@amazon.com>
References: <20250224232228.990783-1-ahmed.zaki@intel.com>
 <20250224232228.990783-3-ahmed.zaki@intel.com>
 <c531f3a202e746e39faf27211b80aa69@amazon.com>
 <54f50b81-7361-4140-8b88-acd765fd8f49@intel.com>
In-Reply-To: <54f50b81-7361-4140-8b88-acd765fd8f49@intel.com>
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

PiBbUkUtU0VORF0gSSBqdXN0IHJlYWxpemVkIEkgc2VudCB0aGlzIG9ubHkgdG8gaXdsLCBzb3Jy
eSBmb3Igc3BhbW1pbmcuDQo+IA0KPiANCj4gT24gMjAyNS0wMy0wMyAxMDoxMSBhLm0uLCBBcmlu
em9uLCBEYXZpZCB3cm90ZToNCj4gPj4gVXNlIHRoZSBjb3JlJ3Mgcm1hcCBub3RpZmllcnMgYW5k
IGRlbGV0ZSBvdXIgb3duLg0KPiA+Pg0KPiA+PiBBY2tlZC1ieTogRGF2aWQgQXJpbnpvbiA8ZGFy
aW56b25AYW1hem9uLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQWhtZWQgWmFraSA8YWhtZWQu
emFraUBpbnRlbC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2Ft
YXpvbi9lbmEvZW5hX25ldGRldi5jIHwgNDMgKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQyIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfbmV0ZGV2
LmMNCj4gPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9hbWF6b24vZW5hL2VuYV9uZXRkZXYuYw0K
PiA+PiBpbmRleCBjMTI5NWRmYWQwZDAuLjZhYWI4NWE3YzYwYSAxMDA2NDQNCj4gPj4gLS0tIGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfbmV0ZGV2LmMNCj4gPj4gKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfbmV0ZGV2LmMNCj4gPj4gQEAgLTUs
OSArNSw2IEBADQo+ID4+DQo+ID4+ICAgI2RlZmluZSBwcl9mbXQoZm10KSBLQlVJTERfTU9ETkFN
RSAiOiAiIGZtdA0KPiA+Pg0KPiA+PiAtI2lmZGVmIENPTkZJR19SRlNfQUNDRUwNCj4gPj4gLSNp
bmNsdWRlIDxsaW51eC9jcHVfcm1hcC5oPg0KPiA+PiAtI2VuZGlmIC8qIENPTkZJR19SRlNfQUND
RUwgKi8NCj4gPj4gICAjaW5jbHVkZSA8bGludXgvZXRodG9vbC5oPg0KPiA+PiAgICNpbmNsdWRl
IDxsaW51eC9rZXJuZWwuaD4NCj4gPj4gICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4+
IEBAIC0xNjIsMzAgKzE1OSw2IEBAIGludCBlbmFfeG1pdF9jb21tb24oc3RydWN0IGVuYV9hZGFw
dGVyDQo+ICphZGFwdGVyLA0KPiA+PiAgICAgICAgICByZXR1cm4gMDsNCj4gPj4gICB9DQo+ID4+
DQo+ID4+IC1zdGF0aWMgaW50IGVuYV9pbml0X3J4X2NwdV9ybWFwKHN0cnVjdCBlbmFfYWRhcHRl
ciAqYWRhcHRlcikgLXsNCj4gPj4gLSNpZmRlZiBDT05GSUdfUkZTX0FDQ0VMDQo+ID4+IC0gICAg
ICAgdTMyIGk7DQo+ID4+IC0gICAgICAgaW50IHJjOw0KPiA+PiAtDQo+ID4+IC0gICAgICAgYWRh
cHRlci0+bmV0ZGV2LT5yeF9jcHVfcm1hcCA9IGFsbG9jX2lycV9jcHVfcm1hcChhZGFwdGVyLQ0K
PiA+Pj4gbnVtX2lvX3F1ZXVlcyk7DQo+ID4+IC0gICAgICAgaWYgKCFhZGFwdGVyLT5uZXRkZXYt
PnJ4X2NwdV9ybWFwKQ0KPiA+PiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4+
IC0gICAgICAgZm9yIChpID0gMDsgaSA8IGFkYXB0ZXItPm51bV9pb19xdWV1ZXM7IGkrKykgew0K
PiA+PiAtICAgICAgICAgICAgICAgaW50IGlycV9pZHggPSBFTkFfSU9fSVJRX0lEWChpKTsNCj4g
Pj4gLQ0KPiA+PiAtICAgICAgICAgICAgICAgcmMgPSBpcnFfY3B1X3JtYXBfYWRkKGFkYXB0ZXIt
Pm5ldGRldi0+cnhfY3B1X3JtYXAsDQo+ID4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcGNpX2lycV92ZWN0b3IoYWRhcHRlci0+cGRldiwgaXJxX2lkeCkpOw0KPiA+PiAt
ICAgICAgICAgICAgICAgaWYgKHJjKSB7DQo+ID4+IC0gICAgICAgICAgICAgICAgICAgICAgIGZy
ZWVfaXJxX2NwdV9ybWFwKGFkYXB0ZXItPm5ldGRldi0+cnhfY3B1X3JtYXApOw0KPiA+PiAtICAg
ICAgICAgICAgICAgICAgICAgICBhZGFwdGVyLT5uZXRkZXYtPnJ4X2NwdV9ybWFwID0gTlVMTDsN
Cj4gPj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJjOw0KPiA+PiAtICAgICAgICAg
ICAgICAgfQ0KPiA+PiAtICAgICAgIH0NCj4gPj4gLSNlbmRpZiAvKiBDT05GSUdfUkZTX0FDQ0VM
ICovDQo+ID4+IC0gICAgICAgcmV0dXJuIDA7DQo+ID4+IC19DQo+ID4+IC0NCj4gPj4gICBzdGF0
aWMgdm9pZCBlbmFfaW5pdF9pb19yaW5nc19jb21tb24oc3RydWN0IGVuYV9hZGFwdGVyICphZGFw
dGVyLA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBl
bmFfcmluZyAqcmluZywgdTE2IHFpZCkNCj4gPj4geyBAQCAtMTU5Niw3ICsxNTY5LDcgQEAgc3Rh
dGljIGludCBlbmFfZW5hYmxlX21zaXgoc3RydWN0IGVuYV9hZGFwdGVyDQo+ICphZGFwdGVyKQ0K
PiA+PiAgICAgICAgICAgICAgICAgIGFkYXB0ZXItPm51bV9pb19xdWV1ZXMgPSBpcnFfY250IC0g
RU5BX0FETUlOX01TSVhfVkVDOw0KPiA+PiAgICAgICAgICB9DQo+ID4+DQo+ID4+IC0gICAgICAg
aWYgKGVuYV9pbml0X3J4X2NwdV9ybWFwKGFkYXB0ZXIpKQ0KPiA+PiArICAgICAgIGlmIChuZXRp
Zl9lbmFibGVfY3B1X3JtYXAoYWRhcHRlci0+bmV0ZGV2LA0KPiA+PiArIGFkYXB0ZXItPm51bV9p
b19xdWV1ZXMpKQ0KPiA+PiAgICAgICAgICAgICAgICAgIG5ldGlmX3dhcm4oYWRhcHRlciwgcHJv
YmUsIGFkYXB0ZXItPm5ldGRldiwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICJG
YWlsZWQgdG8gbWFwIElSUXMgdG8gQ1BVc1xuIik7DQo+ID4+DQo+ID4+IEBAIC0xNzQyLDEzICsx
NzE1LDYgQEAgc3RhdGljIHZvaWQgZW5hX2ZyZWVfaW9faXJxKHN0cnVjdCBlbmFfYWRhcHRlcg0K
PiA+PiAqYWRhcHRlcikNCj4gPj4gICAgICAgICAgc3RydWN0IGVuYV9pcnEgKmlycTsNCj4gPj4g
ICAgICAgICAgaW50IGk7DQo+ID4+DQo+ID4+IC0jaWZkZWYgQ09ORklHX1JGU19BQ0NFTA0KPiA+
PiAtICAgICAgIGlmIChhZGFwdGVyLT5tc2l4X3ZlY3MgPj0gMSkgew0KPiA+PiAtICAgICAgICAg
ICAgICAgZnJlZV9pcnFfY3B1X3JtYXAoYWRhcHRlci0+bmV0ZGV2LT5yeF9jcHVfcm1hcCk7DQo+
ID4+IC0gICAgICAgICAgICAgICBhZGFwdGVyLT5uZXRkZXYtPnJ4X2NwdV9ybWFwID0gTlVMTDsN
Cj4gPj4gLSAgICAgICB9DQo+ID4+IC0jZW5kaWYgLyogQ09ORklHX1JGU19BQ0NFTCAqLw0KPiA+
PiAtDQo+ID4+ICAgICAgICAgIGZvciAoaSA9IEVOQV9JT19JUlFfRklSU1RfSURYOyBpIDwNCj4g
Pj4gRU5BX01BWF9NU0lYX1ZFQyhpb19xdWV1ZV9jb3VudCk7IGkrKykgew0KPiA+PiAgICAgICAg
ICAgICAgICAgIGlycSA9ICZhZGFwdGVyLT5pcnFfdGJsW2ldOw0KPiA+PiAgICAgICAgICAgICAg
ICAgIGlycV9zZXRfYWZmaW5pdHlfaGludChpcnEtPnZlY3RvciwgTlVMTCk7IEBADQo+ID4+IC00
MTMxLDEzICs0MDk3LDYgQEAgc3RhdGljIHZvaWQgX19lbmFfc2h1dG9mZihzdHJ1Y3QgcGNpX2Rl
diAqcGRldiwNCj4gYm9vbCBzaHV0ZG93bikNCj4gPj4gICAgICAgICAgZW5hX2RldiA9IGFkYXB0
ZXItPmVuYV9kZXY7DQo+ID4+ICAgICAgICAgIG5ldGRldiA9IGFkYXB0ZXItPm5ldGRldjsNCj4g
Pj4NCj4gPj4gLSNpZmRlZiBDT05GSUdfUkZTX0FDQ0VMDQo+ID4+IC0gICAgICAgaWYgKChhZGFw
dGVyLT5tc2l4X3ZlY3MgPj0gMSkgJiYgKG5ldGRldi0+cnhfY3B1X3JtYXApKSB7DQo+ID4+IC0g
ICAgICAgICAgICAgICBmcmVlX2lycV9jcHVfcm1hcChuZXRkZXYtPnJ4X2NwdV9ybWFwKTsNCj4g
Pj4gLSAgICAgICAgICAgICAgIG5ldGRldi0+cnhfY3B1X3JtYXAgPSBOVUxMOw0KPiA+PiAtICAg
ICAgIH0NCj4gPj4gLQ0KPiA+PiAtI2VuZGlmIC8qIENPTkZJR19SRlNfQUNDRUwgKi8NCj4gPj4g
ICAgICAgICAgLyogTWFrZSBzdXJlIHRpbWVyIGFuZCByZXNldCByb3V0aW5lIHdvbid0IGJlIGNh
bGxlZCBhZnRlcg0KPiA+PiAgICAgICAgICAgKiBmcmVlaW5nIGRldmljZSByZXNvdXJjZXMuDQo+
ID4+ICAgICAgICAgICAqLw0KPiA+PiAtLQ0KPiA+PiAyLjQzLjANCj4gPg0KPiA+IEhpIEFobWVk
LA0KPiA+DQo+ID4gQWZ0ZXIgdGhlIG1lcmdpbmcgb2YgdGhpcyBwYXRjaCwgSSBzZWUgdGhlIGJl
bG93IHN0YWNrIHRyYWNlIHdoZW4gdGhlIElSUXMNCj4gYXJlIGZyZWVkLg0KPiA+IEl0IGNhbiBi
ZSByZXByb2R1Y2VkIGJ5IHVubG9hZGluZyBhbmQgbG9hZGluZyB0aGUgZHJpdmVyIHVzaW5nDQo+
ID4gYG1vZHByb2JlIC1yIGVuYTsgbW9kcHJvYmUgZW5hYCAoaGFwcGVucyBkdXJpbmcgdW5sb2Fk
KQ0KPiA+DQo+ID4gQmFzZWQgb24gdGhlIHBhdGNoc2V0IGFuZCB0aGUgY2hhbmdlcyB0byBvdGhl
ciBkcml2ZXJzLCBJIHRoaW5rDQo+ID4gdGhlcmUncyBhIG1pc3NpbmcgY2FsbCB0byB0aGUgZnVu
Y3Rpb24gdGhhdCByZWxlYXNlcyB0aGUgYWZmaW5pdHkNCj4gPiBub3RpZmllciAoVGhlIHdhcm4g
aXMgaW4NCj4gPiBodHRwczovL3dlYi5naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvbmV0ZGV2L25ldC1uZXh0LmdpDQo+ID4gdC90cmVlL2tlcm5lbC9pcnEvbWFuYWdlLmMj
bjIwMzEpDQo+ID4NCj4gPiBJIHNhdyBpbiB0aGUgaW50ZWwgY29kZSBpbiB0aGUgcGF0Y2hzZXQg
dGhhdCBgIG5ldGlmX25hcGlfc2V0X2lycSg8bmFwaT4sIC0xKTtgDQo+IGlzIGFkZGVkPw0KPiA+
DQo+ID4gQWZ0ZXIgYWRkaW5nIHRoZSBjb2RlIHNuaXBwZXQgSSBkb24ndCBzZWUgdGhpcyBhbnlt
b3JlLCBidXQgSSB3YW50IHRvDQo+IHVuZGVyc3RhbmQgd2hldGhlciBpdCdzIHRoZSByaWdodCBj
YWxsIGJ5IGRlc2lnbi4NCj4gDQo+IFllcywgaW4gZW5hX2Rvd24oKSB0aGUgSVJRcyBhcmUgZnJl
ZWQgYmVmb3JlIG5hcGlzIGFyZSBkZWxldGVkICh3aGVyZSBJUlENCj4gbm90aWZpZXJzIGFyZSBy
ZWxlYXNlZCkuIFRoZSBjb2RlIGJlbG93IGlzIGZpbmUgKGFuZCBpcyBiZXR0ZXIgSU1PKSBidXQg
eW91DQo+IGNhbiBhbHNvIGRlbGV0ZSBuYXBpcyB0aGVuIGZyZWUgSVJRcy4NCj4gDQo+IA0KDQpU
aGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiBTb21lIGJvb2sta2VlcGluZywgYXMgdGhpcyBj
aGFuZ2UgZml4ZXMgdGhlIGlzc3VlLg0KVGhlIG5lZWQgdG8gdXNlIGBuZXRpZl9uYXBpX3NldF9p
cnFgIHdhcyBpbnRyb2R1Y2VkIGluIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDI0
MTAwMjAwMTMzMS42NTQ0NC0yLWpkYW1hdG9AZmFzdGx5LmNvbS8sDQpCdXQsIHRlY2huaWNhbGx5
LCB0aGVyZSB3YXMgbm90IG5lZWQgdG8gdXNlIHRoZSBjYWxsIHdpdGggdGhlIC0xIHVudGlsIHRo
ZSBpbnRyb2R1Y3Rpb24gb2YgdGhpcyBwYXRjaC4NCklzIG15IHVuZGVyc3RhbmRpbmcgY29ycmVj
dD8NCg0KSWYgaXQncyBjb3JyZWN0LCB0aGVuIHRoZSBmaXggaXMgZm9yIHRoaXMgcGF0Y2guDQoN
CihBbHNvIGFkZGluZyBKb2Ugd2hvIGF1dGhvcmVkIHRoZSBtZW50aW9uZWQgcGF0Y2gpDQoNCj4g
Pg0KPiA+IEBAIC0xNzE2LDggKzE3MTYsMTEgQEAgc3RhdGljIHZvaWQgZW5hX2ZyZWVfaW9faXJx
KHN0cnVjdCBlbmFfYWRhcHRlcg0KPiAqYWRhcHRlcikNCj4gPiAgICAgICAgICBpbnQgaTsNCj4g
Pg0KPiA+ICAgICAgICAgIGZvciAoaSA9IEVOQV9JT19JUlFfRklSU1RfSURYOyBpIDwNCj4gPiBF
TkFfTUFYX01TSVhfVkVDKGlvX3F1ZXVlX2NvdW50KTsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAg
ICAgIHN0cnVjdCBlbmFfbmFwaSAqZW5hX25hcGk7DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAg
ICAgaXJxID0gJmFkYXB0ZXItPmlycV90YmxbaV07DQo+ID4gICAgICAgICAgICAgICAgICBpcnFf
c2V0X2FmZmluaXR5X2hpbnQoaXJxLT52ZWN0b3IsIE5VTEwpOw0KPiA+ICsgICAgICAgICAgICAg
ICBlbmFfbmFwaSA9IChzdHJ1Y3QgZW5hX25hcGkgKilpcnEtPmRhdGE7DQo+ID4gKyAgICAgICAg
ICAgICAgIG5ldGlmX25hcGlfc2V0X2lycSgmZW5hX25hcGktPm5hcGksIC0xKTsNCj4gPiAgICAg
ICAgICAgICAgICAgIGZyZWVfaXJxKGlycS0+dmVjdG9yLCBpcnEtPmRhdGEpOw0KPiA+ICAgICAg
ICAgIH0NCj4gPiAgIH0NCj4gPg0KPiA+IFsgIDQ4NC41NDQ1ODZdICA/IF9fd2FybisweDg0LzB4
MTMwDQo+ID4gWyAgNDg0LjU0NDg0M10gID8gZnJlZV9pcnErMHg1Yy8weDcwDQo+ID4gWyAgNDg0
LjU0NTEwNV0gID8gcmVwb3J0X2J1ZysweDE4YS8weDFhMCBbICA0ODQuNTQ1MzkwXSAgPw0KPiA+
IGhhbmRsZV9idWcrMHg1My8weDkwIFsgIDQ4NC41NDU2NjRdICA/IGV4Y19pbnZhbGlkX29wKzB4
MTQvMHg3MCBbDQo+ID4gNDg0LjU0NTk1OV0gID8gYXNtX2V4Y19pbnZhbGlkX29wKzB4MTYvMHgy
MCBbICA0ODQuNTQ2Mjc5XSAgPw0KPiA+IGZyZWVfaXJxKzB4NWMvMHg3MCBbICA0ODQuNTQ2NTQ1
XSAgPyBmcmVlX2lycSsweDEwLzB4NzAgWyAgNDg0LjU0NjgwN10NCj4gPiBlbmFfZnJlZV9pb19p
cnErMHg1Zi8weDcwIFtlbmFdIFsgIDQ4NC41NDcxMzhdICBlbmFfZG93bisweDI1MC8weDNlMA0K
PiA+IFtlbmFdIFsgIDQ4NC41NDc0MzVdICBlbmFfZGVzdHJveV9kZXZpY2UrMHgxMTgvMHgxNTAg
W2VuYV0gWw0KPiA+IDQ4NC41NDc3OTZdICBfX2VuYV9zaHV0b2ZmKzB4NWEvMHhlMCBbZW5hXSBb
ICA0ODQuNTQ4MTEwXQ0KPiA+IHBjaV9kZXZpY2VfcmVtb3ZlKzB4M2IvMHhiMCBbICA0ODQuNTQ4
NDEyXQ0KPiA+IGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweDE5My8weDIwMA0KPiA+
IFsgIDQ4NC41NDg4MDRdICBkcml2ZXJfZGV0YWNoKzB4NDQvMHg5MCBbICA0ODQuNTQ5MDg0XQ0K
PiA+IGJ1c19yZW1vdmVfZHJpdmVyKzB4NjkvMHhmMCBbICA0ODQuNTQ5Mzg2XQ0KPiA+IHBjaV91
bnJlZ2lzdGVyX2RyaXZlcisweDJhLzB4YjAgWyAgNDg0LjU0OTcxN10gIGVuYV9jbGVhbnVwKzB4
Yy8weDEzMA0KPiA+IFtlbmFdIFsgIDQ4NC41NTAwMjFdICBfX2RvX3N5c19kZWxldGVfbW9kdWxl
LmNvbnN0cHJvcC4wKzB4MTc2LzB4MzEwDQo+ID4gWyAgNDg0LjU1MDQzOF0gID8gc3lzY2FsbF90
cmFjZV9lbnRlcisweGZiLzB4MWMwIFsgIDQ4NC41NTA3ODJdDQo+ID4gZG9fc3lzY2FsbF82NCsw
eDViLzB4MTcwIFsgIDQ4NC41NTEwNjddDQo+ID4gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2Zy
YW1lKzB4NzYvMHg3ZQ0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IERhdmlkDQoNCg==

