Return-Path: <netdev+bounces-101160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263BF8FD911
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC2A1F21BC7
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899B01667FF;
	Wed,  5 Jun 2024 21:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="G+Ui53eo"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626241373
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623016; cv=none; b=EYGqjErCVNA2PEifbolZScJ7R9m3/5OhA293yZpubMproRTY5MCwCt/hA5ETUXhGG1tdOrvwlncsZxvj376ls0xSFkBDS+p3kU58+rktq/AsqO04RXgZnXiyNvwXNFH35QfNJA+7gRhnHSzPv+DvBoZTawSKy4dbV5JH8JsBaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623016; c=relaxed/simple;
	bh=KxTYCer4B2FidGGwLUIWfVVB28RPkGPyzNPIAfGR75w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SXwVLP3Y+RdRYw5FByJxUwAKAjOmTZTaRYSRXjQqKp+wafEmbY8lEwQRG6W6hKH0Sc08P43sQ3yxPseEqY4WOFZj0zKd/095Hy+3iJ/1fAaQJV1jQaYk1vxfyEmMpF+QfCaLZ7XdVAgEfc2HYqFkJN0ericPW0ZxNhunvYh/QuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=G+Ui53eo; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 448852C03DE;
	Thu,  6 Jun 2024 09:30:10 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1717623010;
	bh=KxTYCer4B2FidGGwLUIWfVVB28RPkGPyzNPIAfGR75w=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=G+Ui53eo69nOIYUHTwpOFSiYzKrqI6bvI+IGrJRydR+sopRVzaUfJL2Qwi79ln0WB
	 5pEOHupZuzHWwLgDa2exPW6u4RPNdI4Vf4GU1ZTRykBHJvbLaKfuWYJZj9j6UTuKEe
	 P7rpMzsWfYY+lrLOiW20YVaVbkRah8b1mLiOcOenLy2jIvY8KlM4cNH7qmKqmXhqkL
	 liUw/aZg+ooL8nXQ3YxHkCFvulWSQyU/A1qzrCCNWnOMh8cwXBqS/Qb06i8S1Kmvmn
	 aV9O3YveQXYWtk6fqTSbzbuExj1WoMAGnXWGa+EzJ+WIoEodDSS5XaYciRRMxDuxw8
	 zmoM+hoQK5LkQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6660d8e20001>; Thu, 06 Jun 2024 09:30:10 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Jun 2024 09:30:09 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Thu, 6 Jun 2024 09:30:09 +1200
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
Thread-Index: AQHatiy8/IRPYuJPYUO9rw9qJEjE7LG43r0AgAAFPYCAAAHagIAAA7yA
Date: Wed, 5 Jun 2024 21:30:09 +0000
Message-ID: <48b5cd5f-0613-4198-abfe-1f3297bb9c7e@alliedtelesis.co.nz>
References: <20240604031020.2313175-1-jackie.jone@alliedtelesis.co.nz>
 <ad56235d-d267-4477-9c35-210309286ff4@intel.com>
 <dce11b71-724c-4c5f-bc95-1b59e7cc7844@alliedtelesis.co.nz>
 <4f9af0e9-5ce0-4b76-a2cd-cbd37331d869@intel.com>
In-Reply-To: <4f9af0e9-5ce0-4b76-a2cd-cbd37331d869@intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3805CB0DC3F0A429FA223C3CCF8182D@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=6660d8e2 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=TP2Coi8AN2xbl7mVpYUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiA2LzA2LzI0IDA5OjE2LCBKYWNvYiBLZWxsZXIgd3JvdGU6DQo+DQo+IE9uIDYvNS8yMDI0
IDI6MTAgUE0sIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBPbiA2LzA2LzI0IDA4OjUxLCBKYWNv
YiBLZWxsZXIgd3JvdGU6DQo+Pj4gT24gNi8zLzIwMjQgODoxMCBQTSwgamFja2llLmpvbmVAYWxs
aWVkdGVsZXNpcy5jby5ueiB3cm90ZToNCj4+Pj4gRnJvbTogSmFja2llIEpvbmUgPGphY2tpZS5q
b25lQGFsbGllZHRlbGVzaXMuY28ubno+DQo+Pj4+DQo+Pj4+IFRvIGZhY2lsaXRhdGUgcnVubmlu
ZyBQSFkgcGFyYW1ldHJpYyB0ZXN0cywgYWRkIHN1cHBvcnQgZm9yIHRoZSBTSU9DU01JSVJFRw0K
Pj4+PiBpb2N0bC4gVGhpcyBhbGxvd3MgYSB1c2Vyc3BhY2UgYXBwbGljYXRpb24gdG8gd3JpdGUg
dG8gdGhlIFBIWSByZWdpc3RlcnMNCj4+Pj4gdG8gZW5hYmxlIHRoZSB0ZXN0IG1vZGVzLg0KPj4+
Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKYWNraWUgSm9uZSA8amFja2llLmpvbmVAYWxsaWVkdGVs
ZXNpcy5jby5uej4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2lnYi9pZ2JfbWFpbi5jIHwgNCArKysrDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2lnYi9pZ2JfbWFpbi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9t
YWluLmMNCj4+Pj4gaW5kZXggMDNhNGRhNmExNDQ3Li43ZmJmY2YwMWZiZjkgMTAwNjQ0DQo+Pj4+
IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jDQo+Pj4+ICsr
KyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYi9pZ2JfbWFpbi5jDQo+Pj4+IEBAIC04
OTc3LDYgKzg5NzcsMTAgQEAgc3RhdGljIGludCBpZ2JfbWlpX2lvY3RsKHN0cnVjdCBuZXRfZGV2
aWNlICpuZXRkZXYsIHN0cnVjdCBpZnJlcSAqaWZyLCBpbnQgY21kKQ0KPj4+PiAgICAJCQlyZXR1
cm4gLUVJTzsNCj4+Pj4gICAgCQlicmVhazsNCj4+Pj4gICAgCWNhc2UgU0lPQ1NNSUlSRUc6DQo+
Pj4+ICsJCWlmIChpZ2Jfd3JpdGVfcGh5X3JlZygmYWRhcHRlci0+aHcsIGRhdGEtPnJlZ19udW0g
JiAweDFGLA0KPj4+PiArCQkJCSAgICAgZGF0YS0+dmFsX2luKSkNCj4+Pj4gKwkJCXJldHVybiAt
RUlPOw0KPj4+PiArCQlicmVhazsNCj4+PiBBIGhhbmRmdWwgb2YgZHJpdmVycyBzZWVtIHRvIGV4
cG9zZSB0aGlzLiBXaGF0IGFyZSB0aGUgY29uc2VxdWVuY2VzIG9mDQo+Pj4gZXhwb3NpbmcgdGhp
cyBpb2N0bD8gV2hhdCBjYW4gdXNlciBzcGFjZSBkbyB3aXRoIGl0Pw0KPj4+DQo+Pj4gSXQgbG9v
a3MgbGlrZSBhIGZldyBkcml2ZXJzIGFsc28gY2hlY2sgc29tZXRoaW5nIGxpa2UgQ0FQX05FVF9B
RE1JTiB0bw0KPj4+IGF2b2lkIGFsbG93aW5nIHdyaXRlIGFjY2VzcyB0byBhbGwgdXNlcnMuIElz
IHRoYXQgZW5mb3JjZWQgc29tZXdoZXJlIGVsc2U/DQo+PiBDQVBfTkVUX0FETUlOIGlzIGVuZm9y
Y2VkIHZpYSBkZXZfaW9jdGwoKSBzbyBpdCBzaG91bGQgYWxyZWFkeSBiZQ0KPj4gcmVzdHJpY3Rl
ZCB0byB1c2VycyB3aXRoIHRoYXQgY2FwYWJpbGl0eS4NCj4gT2sgZ29vZC4gVGhhdCBhdCBsZWFz
dCBsaW1pdHMgdGhpcyBzbyB0aGF0IHJhbmRvbSB1c2VycyBjYW4ndCBjYXVzZSBhbnkNCj4gc2lk
ZSBlZmZlY3RzLg0KPg0KPiBJJ20gbm90IHN1cGVyIGZhbWlsaWFyIHdpdGggd2hhdCBjYW4gYmUg
YWZmZWN0ZWQgYnkgd3JpdGluZyB0aGUgTUlJDQo+IHJlZ2lzdGVycy4gSSdtIGFsc28gbm90IHN1
cmUgd2hhdCB0aGUgY29tbXVuaXR5IHRoaW5rcyBvZiBleHBvc2luZyBzdWNoDQo+IGFjY2VzcyBk
aXJlY3RseS4NCj4NCj4gIEZyb20gdGhlIGRlc2NyaXB0aW9uIHRoaXMgaXMgaW50ZW5kZWQgdG8g
dXNlIGZvciBkZWJ1Z2dpbmcgYW5kIHRlc3RpbmcNCj4gcHVycG9zZXM/DQoNClRoZSBpbW1lZGlh
dGUgbmVlZCBpcyB0byBwcm92aWRlIGFjY2VzcyB0byBzb21lIHRlc3QgbW9kZSByZWdpc3RlcnMg
dGhhdCANCm1ha2UgdGhlIFBIWSBvdXRwdXQgc3BlY2lmaWMgdGVzdCBwYXR0ZXJucyB0aGF0IGNh
biBiZSBvYnNlcnZlZCB3aXRoIGFuIA0Kb3NjaWxsb3Njb3BlLiBPdXIgaGFyZHdhcmUgY29sbGVh
Z3VlcyB1c2UgdGhlc2UgdG8gdmFsaWRhdGUgbmV3IGhhcmR3YXJlIA0KZGVzaWducy4gT24gb3Ro
ZXIgcHJvZHVjdHMgd2UgaGF2ZSBiZWVuIHVzaW5nIHRob3NlICJoYW5kZnVsIG9mIGRyaXZlcnMi
IA0KdGhhdCBhbHJlYWR5IHN1cHBvcnQgdGhpcywgdGhpcyBpcyB0aGUgZmlyc3QgZGVzaWduIHdl
J3JlIHdlJ3ZlIG5lZWRlZCANCml0IHdpdGggaWdiLg0KDQpUaGVyZSBpcyBvZiBjb3Vyc2UgdGhl
IGFsdGVybmF0aXZlIG9mIGV4cG9zaW5nIHRob3NlIHRlc3QgbW9kZXMgc29tZSANCm90aGVyIHdh
eSBidXQgdGhlbiB3ZSBuZWVkIHRvIHN0YXJ0IGVudW1lcmF0aW5nIHdoYXQgUEhZcyBzdXBwb3J0
IHdoaWNoIA0KdGVzdCBtb2Rlcy4gU29tZSBvZiB0aGVzZSBhcmUgZGVmaW5lZCBpbiA4MDIuMyBi
dXQgdGhlcmUgYXJlIHBsZW50eSBvZiANCnZlbmRvciBleHRlbnNpb25zLg0KDQpPbmUgYmVuZWZp
dCBJIHNlZSBpbiB0aGlzIGlzIHRoYXQgZG9lcyBhbGxvdyB1c2VybGFuZCBhY2Nlc3MgdG8gYW4g
TUlJIA0KZGV2aWNlLiBJJ3ZlIHVzZWQgaXQgdG8gZGVidWcgbm9uLVBIWSBkZXZpY2VzIGxpa2Ug
dGhlIG12ODhlNnh4eCBMMiANCnN3aXRjaCB3aGljaCBoYXMgYSBtYW5hZ2VtZW50IGludGVyZmFj
ZSBvdmVyIE1ESU8uIFRoZXJlJ3MgYW4gaW4ta2VybmVsIA0KZHJpdmVyIGZvciB0aGlzIG5vdyBz
byB0aGF0IHNwZWNpZmljIHVzYWdlIGlzbid0IHJlcXVpcmVkIGJ1dCBJIGJyaW5nIGl0IA0KdXAg
YXMgYW4gZXhhbXBsZSBvZiBhIGRldmljZSB0aGF0IHNwZWFrcyBNRElPIGJ1dCBpc24ndCBhIFBI
WS4gV2hldGhlciANCnRoaXMgaXMgYSByZWFsIGFkdmFudGFnZSBvciBub3QgbWlnaHQgZGVwZW5k
IG9uIGhvdyB5b3UgZmVlbCBhYm91dCANCnVzZXJsYW5kIGRyaXZlcnMuDQo=

