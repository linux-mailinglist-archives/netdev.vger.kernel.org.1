Return-Path: <netdev+bounces-101156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032368FD823
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0731C253A8
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E6A15F3FB;
	Wed,  5 Jun 2024 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="NnvFfH1j"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156873C28
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621822; cv=none; b=U3eCgDCrn4dghR1t+ZrInH7OqWWrnJ0/r+4lM5m/ZKT/jhxuj6EOsCtGaHiNlD7Gj+/Rub1onVnJg2+eZgLArO9mqSulgSiXziu+rBv+BmB7j3mgxlQ4T19chS0UtDN0X5syGCH+n0BdOgJ99taL6oTwcGSipNlvQG00OHxMiI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621822; c=relaxed/simple;
	bh=Zpts+FQi0ipqbvJ6Ta+GeOn3EOSf4V8EhYcEC0P8JfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jvm8MRfR0607R8g1+zAhYFxu20c5qqoFN/9L2sGmg4Fpo+HlDXJUKjpSl1EnLSz9uwk/tLYDO7xUrhv8JKKAN7tK/2V50VdOw5qNCUTuOxJzQ1PF+3IpN9qqIc/EuWMfeeeNcH1kt5u2ocG2VOvIRWKsjTP0T9C/vHQFagoLqhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=NnvFfH1j; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 94AD12C03DE;
	Thu,  6 Jun 2024 09:10:10 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1717621810;
	bh=Zpts+FQi0ipqbvJ6Ta+GeOn3EOSf4V8EhYcEC0P8JfY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=NnvFfH1j7lUN/aRkfnglNwS1JVFajWIVRjZYXljWlKvLSRIdYjjPLHIsL+uscNChz
	 roWN09hSZhKr94xEnSqL/3J053zoJ2Hf0ynZkGcukAjzOOXBDLHmcVm7Jm0vWqy4/D
	 vOaa3jGeKilL2zcgcbirtgtNe0sHapzZLoga5ZEV3yAA3Cu+8KMpo6RA54+S/heT6Q
	 WzX4fKJc8MJvVSxZSYC9OXTX26gEBQAYBTK72FP/GldUOxGaXAnZLyykzEz+WKsL5d
	 Co2equ0L0FxW50k9EHhq+wlvAFpWOSv3cuW7O3Q0dNmNh1MWANFa+BySCGvQAgmsjJ
	 iF21q0S/nWpvg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6660d4320001>; Thu, 06 Jun 2024 09:10:10 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Thu, 6 Jun 2024 09:10:10 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Thu, 6 Jun 2024 09:10:10 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Thu, 6 Jun 2024 09:10:10 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Jacob Keller <jacob.e.keller@intel.com>, Jackie Jone
	<Jackie.Jone@alliedtelesis.co.nz>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] igb: Add MII write support
Thread-Topic: [PATCH] igb: Add MII write support
Thread-Index: AQHatiy8/IRPYuJPYUO9rw9qJEjE7LG43r0AgAAFPYA=
Date: Wed, 5 Jun 2024 21:10:10 +0000
Message-ID: <dce11b71-724c-4c5f-bc95-1b59e7cc7844@alliedtelesis.co.nz>
References: <20240604031020.2313175-1-jackie.jone@alliedtelesis.co.nz>
 <ad56235d-d267-4477-9c35-210309286ff4@intel.com>
In-Reply-To: <ad56235d-d267-4477-9c35-210309286ff4@intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F61B059D919A344858227565210CDD7@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=6660d432 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=YbpwbkzvB5h8nOF6__AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiA2LzA2LzI0IDA4OjUxLCBKYWNvYiBLZWxsZXIgd3JvdGU6DQo+DQo+IE9uIDYvMy8yMDI0
IDg6MTAgUE0sIGphY2tpZS5qb25lQGFsbGllZHRlbGVzaXMuY28ubnogd3JvdGU6DQo+PiBGcm9t
OiBKYWNraWUgSm9uZSA8amFja2llLmpvbmVAYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+DQo+PiBU
byBmYWNpbGl0YXRlIHJ1bm5pbmcgUEhZIHBhcmFtZXRyaWMgdGVzdHMsIGFkZCBzdXBwb3J0IGZv
ciB0aGUgU0lPQ1NNSUlSRUcNCj4+IGlvY3RsLiBUaGlzIGFsbG93cyBhIHVzZXJzcGFjZSBhcHBs
aWNhdGlvbiB0byB3cml0ZSB0byB0aGUgUEhZIHJlZ2lzdGVycw0KPj4gdG8gZW5hYmxlIHRoZSB0
ZXN0IG1vZGVzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEphY2tpZSBKb25lIDxqYWNraWUuam9u
ZUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ludGVsL2lnYi9pZ2JfbWFpbi5jIHwgNCArKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50
ZWwvaWdiL2lnYl9tYWluLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21h
aW4uYw0KPj4gaW5kZXggMDNhNGRhNmExNDQ3Li43ZmJmY2YwMWZiZjkgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYw0KPj4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9tYWluLmMNCj4+IEBAIC04OTc3LDYgKzg5
NzcsMTAgQEAgc3RhdGljIGludCBpZ2JfbWlpX2lvY3RsKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRk
ZXYsIHN0cnVjdCBpZnJlcSAqaWZyLCBpbnQgY21kKQ0KPj4gICAJCQlyZXR1cm4gLUVJTzsNCj4+
ICAgCQlicmVhazsNCj4+ICAgCWNhc2UgU0lPQ1NNSUlSRUc6DQo+PiArCQlpZiAoaWdiX3dyaXRl
X3BoeV9yZWcoJmFkYXB0ZXItPmh3LCBkYXRhLT5yZWdfbnVtICYgMHgxRiwNCj4+ICsJCQkJICAg
ICBkYXRhLT52YWxfaW4pKQ0KPj4gKwkJCXJldHVybiAtRUlPOw0KPj4gKwkJYnJlYWs7DQo+IEEg
aGFuZGZ1bCBvZiBkcml2ZXJzIHNlZW0gdG8gZXhwb3NlIHRoaXMuIFdoYXQgYXJlIHRoZSBjb25z
ZXF1ZW5jZXMgb2YNCj4gZXhwb3NpbmcgdGhpcyBpb2N0bD8gV2hhdCBjYW4gdXNlciBzcGFjZSBk
byB3aXRoIGl0Pw0KPg0KPiBJdCBsb29rcyBsaWtlIGEgZmV3IGRyaXZlcnMgYWxzbyBjaGVjayBz
b21ldGhpbmcgbGlrZSBDQVBfTkVUX0FETUlOIHRvDQo+IGF2b2lkIGFsbG93aW5nIHdyaXRlIGFj
Y2VzcyB0byBhbGwgdXNlcnMuIElzIHRoYXQgZW5mb3JjZWQgc29tZXdoZXJlIGVsc2U/DQoNCkNB
UF9ORVRfQURNSU4gaXMgZW5mb3JjZWQgdmlhIGRldl9pb2N0bCgpIHNvIGl0IHNob3VsZCBhbHJl
YWR5IGJlIA0KcmVzdHJpY3RlZCB0byB1c2VycyB3aXRoIHRoYXQgY2FwYWJpbGl0eS4NCg==

