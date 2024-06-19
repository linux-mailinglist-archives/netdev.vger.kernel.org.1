Return-Path: <netdev+bounces-105079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F7C90F9B9
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 01:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D92282C5E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 23:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AB115B147;
	Wed, 19 Jun 2024 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Sc2OoXd3"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041EC15B143
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718839356; cv=none; b=uVGwlYWppahspB1pHTdx0IO4lnx+oNOx0tehY/Lru05y22MCPfPGjCTzDb07FSBKK5AWah+KXNw/+P+A3JMA5Njc8KKdLRbPjIle8oCOsFgnMP1eeOEgYCuis97QgIohqsha0oU+MFoEsdlhfP2qOarBihC7ASkLgUc9SC7sYH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718839356; c=relaxed/simple;
	bh=UPtcJ2P5VqehkUvKRnSQOFjnk7eiXDn8Pd3nWQ8N5cg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P0/ipdSxQDP87lqrIR/Q44lTcuuhvI4agzRd+q9O2FwG9B5UP2j383fR3sedyor0do/QE/3vCsnKoGWMMHUSE4d/1ntItLI0aLkW4tpytcMQVoOHO+g6Z6KI/uCGK9Rz6PtIKlLOHcx2ClLPmJlGMB3bW+5HlAk+ckFoII9syDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Sc2OoXd3; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3DF9B2C0240;
	Thu, 20 Jun 2024 11:22:32 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718839352;
	bh=UPtcJ2P5VqehkUvKRnSQOFjnk7eiXDn8Pd3nWQ8N5cg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Sc2OoXd3PSW1ZwupTCgR5Mjm+76I5pca2BZb606LV06JY6PBeAhMK9Vz1x9lTvBq+
	 F47ZkQB4NVP1Fp+dWfH3uSz/R60OcWm7KPVKGlBXjbw83u3uzQOHi5lwh1Mb/W9q6K
	 1mlikmhpsf7snaGt+vRM4EJZa4yVe/Ickw3VbpDeYnVEJAqgqCVsSl2wlmA5ZDgHQe
	 d+OaEdzL4/QAPoB2lWob0MNVxO75b5iRdnLYWHqW2k+s6yEJxCJ73MqqbI91D7GnJU
	 fxRvScFjRbpBmxRLXyVfh6Srcz+O+9cOwQSyljwRYlt5oVtOISzc0ALsZKqDlsOa+l
	 /BaVOHKrJDvJg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B667368380001>; Thu, 20 Jun 2024 11:22:32 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Jun 2024 11:22:31 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Thu, 20 Jun 2024 11:22:31 +1200
From: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
To: "kabel@kernel.org" <kabel@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: Re: [PATCH v0] net: dsa: mv88e6xxx: Add FID map cache
Thread-Topic: [PATCH v0] net: dsa: mv88e6xxx: Add FID map cache
Thread-Index: AQHauvQhmGVs7ltcskSdPWkCQQQ/GrHBaOwAgA2XHoA=
Date: Wed, 19 Jun 2024 23:22:31 +0000
Message-ID: <56e57cf68444b80562e2ee652b58dc11be03ff01.camel@alliedtelesis.co.nz>
References: <20240610050724.2439780-1-aryan.srivastava@alliedtelesis.co.nz>
	 <20240611095016.7804b091@dellmb>
In-Reply-To: <20240611095016.7804b091@dellmb>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E3BDC2F02351B48A086E610F5734B96@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=66736838 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=w1vUsAckAk8A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=EtaIxLg5aHDWm9ZvbzEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgTWFyZWssDQpPbiBUdWUsIDIwMjQtMDYtMTEgYXQgMDk6NTAgKzAyMDAsIE1hcmVrIEJlaMO6
biB3cm90ZToNCj4gT24gTW9uLCAxMCBKdW4gMjAyNCAxNzowNzoyMyArMTIwMA0KPiBBcnlhbiBT
cml2YXN0YXZhIDxhcnlhbi5zcml2YXN0YXZhQGFsbGllZHRlbGVzaXMuY28ubno+IHdyb3RlOg0K
PiANCj4gPiBBZGQgYSBjYWNoZWQgRklEIGJpdG1hcC4gVGhpcyBtaXRpZ2F0ZXMgdGhlIG5lZWQg
dG8NCj4gPiB3YWxrIGFsbCBWVFUgZW50cmllcyB0byBmaW5kIHRoZSBuZXh0IGZyZWUgRklELg0K
PiA+IA0KPiA+IFdhbGsgVlRVIG9uY2UsIHRoZW4gc3RvcmUgcmVhZCBGSUQgbWFwIGludG8gYml0
bWFwLiBVc2UNCj4gPiBhbmQgbWFuaXB1bGF0ZSB0aGlzIGJpdG1hcCBmcm9tIG5vdyBvbiwgaW5z
dGVhZCBvZiByZS1yZWFkaW5nDQo+ID4gSFcgZm9yIHRoZSBGSUQgbWFwLg0KPiA+IA0KPiA+IFRo
ZSByZXBlYXRlZGx5IFZUVSB3YWxrcyBhcmUgY29zdGx5IGNhbiByZXN1bHQgaW4gdGFraW5nIH40
MCBtaW5zDQo+ID4gaWYgfjQwMDAgdmxhbnMgYXJlIGFkZGVkLiBDYWNoaW5nIHRoZSBGSUQgbWFw
IHJlZHVjZXMgdGhpcyB0aW1lDQo+ID4gdG8gPDIgbWlucy4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBcnlhbiBTcml2YXN0YXZhDQo+ID4gPGFyeWFuLnNyaXZhc3RhdmFAYWxsaWVkdGVsZXNp
cy5jby5uej4NCj4gPiAtLS0NCj4gPiDCoGRyaXZlcnMvbmV0L2RzYS9tdjg4ZTZ4eHgvY2hpcC5j
IHwgMjUgKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiA+IMKgZHJpdmVycy9uZXQvZHNhL212
ODhlNnh4eC9jaGlwLmggfMKgIDQgKysrKw0KPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9kc2EvbXY4OGU2eHh4L2NoaXAuYw0KPiA+IGIvZHJpdmVycy9uZXQvZHNhL212ODhlNnh4
eC9jaGlwLmMNCj4gPiBpbmRleCBlNWJhYzg3OTQxZjYuLjkxODE2ZTNlMzVlZCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvbXY4OGU2eHh4L2NoaXAuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbmV0L2RzYS9tdjg4ZTZ4eHgvY2hpcC5jDQo+ID4gQEAgLTE4MTUsMTQgKzE4MTUsMTcgQEAg
aW50IG12ODhlNnh4eF9maWRfbWFwKHN0cnVjdCBtdjg4ZTZ4eHhfY2hpcA0KPiA+ICpjaGlwLCB1
bnNpZ25lZCBsb25nICpmaWRfYml0bWFwKQ0KPiA+IMKgDQo+ID4gwqBzdGF0aWMgaW50IG12ODhl
Nnh4eF9hdHVfbmV3KHN0cnVjdCBtdjg4ZTZ4eHhfY2hpcCAqY2hpcCwgdTE2DQo+ID4gKmZpZCkN
Cj4gPiDCoHsNCj4gPiAtwqDCoMKgwqDCoMKgwqBERUNMQVJFX0JJVE1BUChmaWRfYml0bWFwLCBN
Vjg4RTZYWFhfTl9GSUQpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqBpbnQgZXJyOw0KPiA+IMKgDQo+
ID4gLcKgwqDCoMKgwqDCoMKgZXJyID0gbXY4OGU2eHh4X2ZpZF9tYXAoY2hpcCwgZmlkX2JpdG1h
cCk7DQo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKGVycikNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIGVycjsNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoIWNoaXAtPmZp
ZF9wb3B1bGF0ZWQpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0g
bXY4OGU2eHh4X2ZpZF9tYXAoY2hpcCwgY2hpcC0+ZmlkX2JpdG1hcCk7DQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChlcnIpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gZXJyOw0KPiA+IMKgDQo+ID4gLcKgwqDC
oMKgwqDCoMKgKmZpZCA9IGZpbmRfZmlyc3RfemVyb19iaXQoZmlkX2JpdG1hcCwgTVY4OEU2WFhY
X05fRklEKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2hpcC0+ZmlkX3Bv
cHVsYXRlZCA9IHRydWU7DQo+ID4gK8KgwqDCoMKgwqDCoMKgfQ0KPiA+ICsNCj4gPiArwqDCoMKg
wqDCoMKgwqAqZmlkID0gZmluZF9maXJzdF96ZXJvX2JpdChjaGlwLT5maWRfYml0bWFwLA0KPiA+
IE1WODhFNlhYWF9OX0ZJRCk7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmICh1bmxpa2VseSgqZmlk
ID49IG12ODhlNnh4eF9udW1fZGF0YWJhc2VzKGNoaXApKSkNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5PU1BDOw0KPiA+IMKgDQo+ID4gQEAgLTI1MjksNiAr
MjUzMiw5IEBAIHN0YXRpYyBpbnQgbXY4OGU2eHh4X3BvcnRfdmxhbl9qb2luKHN0cnVjdA0KPiA+
IG12ODhlNnh4eF9jaGlwICpjaGlwLCBpbnQgcG9ydCwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9ydCwgdmlkKTsNCj4gPiDCoMKgwqDCoMKg
wqDCoMKgfQ0KPiA+IMKgDQo+ID4gK8KgwqDCoMKgwqDCoMKgLyogUmVjb3JkIEZJRCB1c2VkIGlu
IFNXIEZJRCBtYXAgKi8NCj4gPiArwqDCoMKgwqDCoMKgwqBiaXRtYXBfc2V0KGNoaXAtPmZpZF9i
aXRtYXAsIHZsYW4uZmlkLCAxKTsNCj4gPiArDQo+IA0KPiB3b3VsZG4ndCBpdCBtYWtlIG1vcmUg
c2Vuc2UgdG8gZG8gdGhpcyBiaXQgc2V0dGluZyBpbg0KPiBtdjg4ZTZ4eHhfYXR1X25ldygpIGFu
ZCBjbGVhcmluZ2luIGEgbmV3IGZ1bmN0aW9uDQo+IG12ODhlNnh4eF9hdHVfZGVsZXRlL2Ryb3Ao
KSA/DQpUaGUgcmVhc29uIEkgZGlkIG5vdCBkbyB0aGlzIGlzIHRvIGVuc3VyZSB0aGF0IHdlIG9u
bHkgY2xlYXIvc2V0IHRoZSBTVw0KYml0IGlmIHRoZSBIVyBvcHMgcGFzcywgaS5lLiBJIHdhbnQg
dG8gbWFrZSBzdXJlIGNhbGxzIGxpa2UNCm12ODhlNnh4eF92dHVfbG9hZHB1cmdlIGFuZCBtdjg4
ZTZ4eHhfZzFfYXR1X3JlbW92ZSBwYXNzIGJlZm9yZSBlZGl0aW5nDQp0aGUgU1cgY2FjaGUuDQoN
ClRoYW5rcywNCkFyeWFuLg0K

