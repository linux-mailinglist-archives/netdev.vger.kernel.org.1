Return-Path: <netdev+bounces-173396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F26A58A36
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 03:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B47A245D
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 02:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEF617A2E8;
	Mon, 10 Mar 2025 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="vt/KUrgO"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD8A935
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572452; cv=none; b=bh1h2zuZG7kwSDE74IzamIInqKubFvjiqKnJEa250efb2N2eQ89em082yj+RGCN3D0SxGJcn+OPWpFt9iZM//2gs36Y8BA1oORhV7kZODyrXIJz59ro+CsZRql/Rkt2gQZ1rdf4coIxap3Kn7QluZeTY58CA0hrRBX6itSE3KSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572452; c=relaxed/simple;
	bh=aD8GUTzbVNOwzccQaH9/7WMvc7yAu3LstpwAie3ywuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D6t8xC1daYPjxj5Xe0bkk93zekEj+hBlC75wC5Az4rKLdEvQBmVC/kbu1bkFrgPjJ9WU80TcW5nJsjOfdIs0rce2MbL2nBqadpGhuVNu3kw0snn5fPWx72LkVho+adQ5hFjT9Vt4z0tMezEMFWJtFGs69ZevwMXZuAI8FSmHpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=vt/KUrgO; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 902152C0503;
	Mon, 10 Mar 2025 15:07:26 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1741572446;
	bh=aD8GUTzbVNOwzccQaH9/7WMvc7yAu3LstpwAie3ywuo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=vt/KUrgOQjdiCMiSUrM1JiMBe6Dxd8fi5bRP128Jgc//MoJ6XTEHmh+bUv5ymuhqx
	 myzcsF9OkrQAr7vwe/50hjvBHy4h1IPYhmmhXe1i3aHLRZAaikKmNWRCp1QOQk5hcn
	 iZK3QhEqvaNDDsQ2A8+Qcym8Z7QaWbfqsgqQw2ucExHCEiP9myjoTLO3NCzgL9kTd8
	 h1nw8uOsc5NQYgiMUjzeU1Kd06/psSwDrCAu4TGt9GQG9fKb31e4WytJrqQe5T68Hq
	 LGhEwHfckrrGzjOFo4puvRlmzneVFbFtow9uNJxBWU405gGo+NmYeoJXWxVNfLk78e
	 f5vUwe8gOHYhw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67ce495e0001>; Mon, 10 Mar 2025 15:07:26 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 15:07:26 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Mon, 10 Mar 2025 15:07:26 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Daniel Golle <daniel@makrotopia.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "sander@svanheule.net"
	<sander@svanheule.net>, "markus.stockhausen@gmx.de"
	<markus.stockhausen@gmx.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v9] net: mdio: Add RTL9300 MDIO driver
Thread-Topic: [PATCH net-next v9] net: mdio: Add RTL9300 MDIO driver
Thread-Index: AQHbkUqaaEyrxv0UqkuL40qCyNEej7Nqu8+AgAAKA4A=
Date: Mon, 10 Mar 2025 02:07:26 +0000
Message-ID: <b506b6e9-d5c3-4927-ab2d-e3a241513082@alliedtelesis.co.nz>
References: <20250309232536.19141-1-chris.packham@alliedtelesis.co.nz>
 <Z85A9_Li_4n9vcEG@pidgin.makrotopia.org>
In-Reply-To: <Z85A9_Li_4n9vcEG@pidgin.makrotopia.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA3AA2C24FB57441B8315644EB9A92FA@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ccpxrWDM c=1 sm=1 tr=0 ts=67ce495e a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=jdP34snFAAAA:8 a=JlFAmtSrY9ouPlbKkEYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=jlphF6vWLdwq7oh3TaWq:22
X-SEG-SpamProfiler-Score: 0

SGkgRGFuaWVsLA0KDQpPbiAxMC8wMy8yMDI1IDE0OjMxLCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
IEhpIENocmlzLA0KPg0KPiBPbiBNb24sIE1hciAxMCwgMjAyNSBhdCAxMjoyNTozNlBNICsxMzAw
LCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4gQWRkIGEgZHJpdmVyIGZvciB0aGUgTURJTyBjb250
cm9sbGVyIG9uIHRoZSBSVEw5MzAwIGZhbWlseSBvZiBFdGhlcm5ldA0KPj4gc3dpdGNoZXMgd2l0
aCBpbnRlZ3JhdGVkIFNvQy4gVGhlcmUgYXJlIDQgcGh5c2ljYWwgU01JIGludGVyZmFjZXMgb24g
dGhlDQo+PiBSVEw5MzAwIGhvd2V2ZXIgYWNjZXNzIGlzIGRvbmUgdXNpbmcgdGhlIHN3aXRjaCBw
b3J0cy4gVGhlIGRyaXZlciB0YWtlcw0KPj4gdGhlIE1ESU8gYnVzIGhpZXJhcmNoeSBmcm9tIHRo
ZSBEVFMgYW5kIHVzZXMgdGhpcyB0byBjb25maWd1cmUgdGhlDQo+PiBzd2l0Y2ggcG9ydHMgc28g
dGhleSBhcmUgYXNzb2NpYXRlZCB3aXRoIHRoZSBjb3JyZWN0IFBIWS4gVGhpcyBtYXBwaW5nDQo+
PiBpcyBhbHNvIHVzZWQgd2hlbiBkZWFsaW5nIHdpdGggc29mdHdhcmUgcmVxdWVzdHMgZnJvbSBw
aHlsaWIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hh
bUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4gLS0tDQo+PiAuLi4NCj4+ICtzdGF0aWMgaW50IHJ0
bDkzMDBfbWRpb19yZWFkX2MyMihzdHJ1Y3QgbWlpX2J1cyAqYnVzLCBpbnQgcGh5X2lkLCBpbnQg
cmVnbnVtKQ0KPj4gK3sNCj4+ICsJc3RydWN0IHJ0bDkzMDBfbWRpb19jaGFuICpjaGFuID0gYnVz
LT5wcml2Ow0KPj4gKwlzdHJ1Y3QgcnRsOTMwMF9tZGlvX3ByaXYgKnByaXY7DQo+PiArCXN0cnVj
dCByZWdtYXAgKnJlZ21hcDsNCj4+ICsJaW50IHBvcnQ7DQo+PiArCXUzMiB2YWw7DQo+PiArCWlu
dCBlcnI7DQo+PiArDQo+PiArCXByaXYgPSBjaGFuLT5wcml2Ow0KPj4gKwlyZWdtYXAgPSBwcml2
LT5yZWdtYXA7DQo+PiArDQo+PiArCXBvcnQgPSBydGw5MzAwX21kaW9fcGh5X3RvX3BvcnQoYnVz
LCBwaHlfaWQpOw0KPj4gKwlpZiAocG9ydCA8IDApDQo+PiArCQlyZXR1cm4gcG9ydDsNCj4+ICsN
Cj4+ICsJbXV0ZXhfbG9jaygmcHJpdi0+bG9jayk7DQo+PiArCWVyciA9IHJ0bDkzMDBfbWRpb193
YWl0X3JlYWR5KHByaXYpOw0KPj4gKwlpZiAoZXJyKQ0KPj4gKwkJZ290byBvdXRfZXJyOw0KPj4g
Kw0KPj4gKwllcnIgPSByZWdtYXBfd3JpdGUocmVnbWFwLCBTTUlfQUNDRVNTX1BIWV9DVFJMXzIs
IEZJRUxEX1BSRVAoUEhZX0NUUkxfSU5EQVRBLCBwb3J0KSk7DQo+PiArCWlmIChlcnIpDQo+PiAr
CQlnb3RvIG91dF9lcnI7DQo+PiArDQo+PiArCXZhbCA9IEZJRUxEX1BSRVAoUEhZX0NUUkxfUkVH
X0FERFIsIHJlZ251bSkgfA0KPj4gKwkgICAgICBGSUVMRF9QUkVQKFBIWV9DVFJMX1BBUktfUEFH
RSwgMHgxZikgfA0KPj4gKwkgICAgICBGSUVMRF9QUkVQKFBIWV9DVFJMX01BSU5fUEFHRSwgMHhm
ZmYpIHwNCj4+ICsJICAgICAgUEhZX0NUUkxfUkVBRCB8IFBIWV9DVFJMX1RZUEVfQzIyIHwgUEhZ
X0NUUkxfQ01EOw0KPiBVc2luZyAicmF3IiBhY2Nlc3MgdG8gdGhlIFBIWSBhbmQgdGhlcmVieSBi
eXBhc3NpbmcgdGhlIE1ESU8NCj4gY29udHJvbGxlcidzIHN1cHBvcnQgZm9yIGhhcmR3YXJlLWFz
c2lzdGVkIHBhZ2UgYWNjZXNzIGlzIHByb2JsZW1hdGljLg0KPiBUaGUgTURJTyBjb250cm9sbGVy
IGFsc28gcG9sbHMgYWxsIFBIWXMgc3RhdHVzIGluIGhhcmR3YXJlIGFuZCBoZW5jZQ0KPiBiZSBh
d2FyZSBvZiB0aGUgY3VycmVudGx5IHNlbGVjdGVkIHBhZ2UuIFVzaW5nIHJhdyBhY2Nlc3MgdG8g
c3dpdGNoDQo+IHRoZSBwYWdlIG9mIGEgUEhZICJiZWhpbmQgdGhlIGJhY2siIG9mIHRoZSBoYXJk
d2FyZSBwb2xsaW5nIG1lY2hhbmlzbQ0KPiByZXN1bHRzIGluIGluIG9jY2Fzc2lvbmFsIGhhdm9j
IG9uIGxpbmsgc3RhdHVzIGNoYW5nZXMgaW4gY2FzZSBMaW51eCcNCj4gcmVhZGluZyB0aGUgcGh5
IHN0YXR1cyBvdmVybGFwcyB3aXRoIHRoZSBoYXJkd2FyZSBwb2xsaW5nLg0KPiBUaGlzIGlzIGVz
cC4gd2hlbiB1c2luZyBSZWFsVGVrJ3MgMi41R0JpdC9zIFBIWXMgd2hpY2ggcmVxdWlyZSB1c2lu
Zw0KPiBwYWdlZCBhY2Nlc3MgaW4gdGhlaXIgcmVhZF9zdGF0dXMoKSBmdW5jdGlvbi4NCj4NCj4g
TWFya3VzIFN0b2NraGF1c2VuIChhbHJlYWR5IGluIENjKSBoYXMgaW1wbGVtZW50ZWQgYSBuaWNl
IHNvbHV0aW9uIHRvDQo+IHRoaXMgcHJvYmxlbSwgaW5jbHVkaW5nIGRvY3VtZW50YXRpb24sIHNl
ZQ0KPiBodHRwczovL2dpdC5vcGVud3J0Lm9yZy8/cD1vcGVud3J0L29wZW53cnQuZ2l0O2E9Ymxv
YjtmPXRhcmdldC9saW51eC9yZWFsdGVrL2ZpbGVzLTYuNi9kcml2ZXJzL25ldC9ldGhlcm5ldC9y
dGw4Mzh4X2V0aC5jO2g9NGI3OTA5MDY5NmUzNDFlZDFlNDMyYTdlYzVjMGY3ZjkyNzc2ZjBlMTto
Yj1IRUFEI2wxNjMxDQoNCkkgcmVhZCB0aGF0IGNvZGUvY29tbWVudCBhIGZldyB0aW1lcyBhbmQg
SSBtdXN0IGFkbWl0IEkgc3RpbGwgZG9uJ3QgDQpxdWl0ZSBnZXQgaXQuIFBhcnQgb2YgdGhlIHBy
b2JsZW0gbWlnaHQgYmUgdGhhdCBteSBoYXJkd2FyZSBwbGF0Zm9ybSBpcyANCnVzaW5nIEM0NSBQ
SFlzIGFuZCB0aGF0J3Mgd2hhdCBJJ3ZlIGJlZW4gdGVzdGluZyB3aXRoLiBUaGUgQzIyIHN1cHBv
cnQgDQppcyBiYXNlZCBvbiBteSByZWFkaW5nIG9mIHRoZSBkYXRhc2hlZXQgYW5kIHNvbWUgb2Yg
d2hhdCBJIGNhbiBnbGVhbiANCmZyb20gb3BlbndydCAoYWx0aG91Z2ggSSBjb21wbGV0ZWx5IG1p
c3NlZCB0aGF0IGNvbW1lbnQgd2hlbiBJIHJlYWQgDQp0aHJvdWdoIHRoZSBkcml2ZXIgdGhlIGZp
cnN0IHRpbWUpLg0KDQo+IEluY2x1ZGluZyBhIHNpbWlsYXIgbWVjaGFuaXNtIGluIHRoaXMgZHJp
dmVyIGZvciBDMjIgcmVhZCBhbmQgd3JpdGUNCj4gb3BlcmF0aW9ucyB3b3VsZCBiZSBteSBhZHZp
c2UsIHNvIGhhcmR3YXJlLWFzc2lzdGVkIGFjY2VzcyB0byB0aGUgUEhZDQo+IHBhZ2VzIGlzIGFs
d2F5cyB1c2VkLCBhbmQgaGVuY2UgdGhlIGhhcmR3YXJlIHBvbGxpbmcgbWVjaGFuaXNtIGlzIGF3
YXJlDQo+IG9mIHRoZSBjdXJyZW50bHkgc2VsZWN0ZWQgcGFnZS4NCg0KU28gZmFyIHVwc3RyZWFt
IExpbnV4IGRvZXNuJ3QgaGF2ZSBnZW5lcmljIHBhZ2VkIFBIWSByZWdpc3RlciBmdW5jdGlvbnMu
IA0KSXQgc291bmRzIGxpa2UgdGhhdCdkIGJlIGEgcHJlcmVxdWlzaXRlIGZvciB0aGlzLg0KDQo+
IE90aGVyIHRoYW4gdGhhdCB0aGUgZHJpdmVyIGxvb2tzIHJlYWxseSBnb29kIG5vdywgYW5kIHdp
bGwgYWxsb3cgdXNpbmcNCj4gZXhpc3RpbmcgUmVhbFRlayBQSFkgZHJpdmVycyBpbmRlcGVuZGVu
dGx5IG9mIHdoZXRoZXIgdGhleSBhcmUgdXNlZCB3aXRoDQo+IFJlYWxUZWsncyBzd2l0Y2ggU29D
cyBvciB3aXRoIG5vbi1SZWFsVGVrIHN5c3RlbXMgLS0gdGhpcyBoYXMgYWx3YXlzDQo+IGJlZW4g
YSBiaWcgaXNzdWUgd2l0aCBPcGVuV3J0J3MgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBhbmQgSSBs
b29rDQo+IGZvcndhcmQgdG8gdXNlIHRoaXMgZHJpdmVyIGluc3RlYWQgYXNhcCA7KQ0K

