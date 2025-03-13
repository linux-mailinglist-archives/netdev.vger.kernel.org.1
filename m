Return-Path: <netdev+bounces-174431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD9A5E92E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 02:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73A11775FA
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 01:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6213AF2;
	Thu, 13 Mar 2025 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="BpBQVdQV"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12DD2B9AA
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741827889; cv=none; b=VMxRAXxXWOuVrUbYDcpk8gbtLEnAkgIEOs5m7+b28Q11iyHe10H1oHSQ+MXBtc+rcd74h6+omcD5q9CHKeXRRd3e93ocdGUp6vVb/+HavXNnDoYvQAt3JdVH1lrhrKTrn3B7D4/oqsVk8Rtp3bPA9h3bIUqK3Zh4hOF/+7Oy/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741827889; c=relaxed/simple;
	bh=NDwgGr8Uos52IXABhUsf8fEHtmfy49OOE1FSCA+lAvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dzch5JF9tW0QFSQn6Y4OcvtnV2B4O2WUPl6qnkfC+BnwCC3h7ajJA9/I2llou9NHqeVMFKa9RQtO+IM80c73YcjQFQkZgbgOXxc6jnKSVw1E6QY0SxE6p4kZNFiPKw/ChtSeKiyq4d0Wwpyi4btRulryvBPILAb7gq/9TXFaksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=BpBQVdQV; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 49E1A2C012B;
	Thu, 13 Mar 2025 14:04:43 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1741827883;
	bh=NDwgGr8Uos52IXABhUsf8fEHtmfy49OOE1FSCA+lAvw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=BpBQVdQVzeQDS6hRArzf9sDMEm43bXv65imSVwUEeE0Cid5QxseZZLkvGY8r1hgfl
	 V+OrQhHETL802THbYpswFKI05swwW8Vd2LoQvarzZY2T0DcbmHrfWTUXfg2BlKaV0C
	 QcfPLUOVjTeSl4/BHVKdsvGZCMTfTvn4xZ3CPhFG9YjX5fJ7YwAkjYDd/Zacrvz1TQ
	 0NExQW5DUy9M/hxLJiMXw4BWxcfyWVoUvkWhpUzqbCIzidC25GGcyYwHNL7dZqEI52
	 U3afC3+lb9Dt6EzOqtq0vsXXGUTT+tmlXkE6ferSqmxkxNEYe/YBQdvbYOsVSe+ZLt
	 pC5CnaXxLAfOw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67d22f2b0001>; Thu, 13 Mar 2025 14:04:43 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 14:04:42 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Thu, 13 Mar 2025 14:04:42 +1300
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
Thread-Index: AQHbkUqaaEyrxv0UqkuL40qCyNEej7Nqu8+AgAAKA4CAAN+0gIADxcQA
Date: Thu, 13 Mar 2025 01:04:42 +0000
Message-ID: <7269cf0f-21c6-45e1-a1f3-5463bdd9fd5c@alliedtelesis.co.nz>
References: <20250309232536.19141-1-chris.packham@alliedtelesis.co.nz>
 <Z85A9_Li_4n9vcEG@pidgin.makrotopia.org>
 <b506b6e9-d5c3-4927-ab2d-e3a241513082@alliedtelesis.co.nz>
 <Z88FBR7m1olkTXxR@pidgin.makrotopia.org>
In-Reply-To: <Z88FBR7m1olkTXxR@pidgin.makrotopia.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <4191EB1E68CFAE41BB0D6C75763B127C@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ccpxrWDM c=1 sm=1 tr=0 ts=67d22f2b a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=jdP34snFAAAA:8 a=0kGZVefVDAKX5x3kvTsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=jlphF6vWLdwq7oh3TaWq:22
X-SEG-SpamProfiler-Score: 0

SGkgRGFuaWVsLA0KDQpPbiAxMS8wMy8yMDI1IDA0OjI4LCBEYW5pZWwgR29sbGUgd3JvdGU6DQo+
IE9uIE1vbiwgTWFyIDEwLCAyMDI1IGF0IDAyOjA3OjI2QU0gKzAwMDAsIENocmlzIFBhY2toYW0g
d3JvdGU6DQo+PiBIaSBEYW5pZWwsDQo+Pg0KPj4gT24gMTAvMDMvMjAyNSAxNDozMSwgRGFuaWVs
IEdvbGxlIHdyb3RlOg0KPj4+IEhpIENocmlzLA0KPj4+DQo+Pj4gT24gTW9uLCBNYXIgMTAsIDIw
MjUgYXQgMTI6MjU6MzZQTSArMTMwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+Pj4gQWRkIGEg
ZHJpdmVyIGZvciB0aGUgTURJTyBjb250cm9sbGVyIG9uIHRoZSBSVEw5MzAwIGZhbWlseSBvZiBF
dGhlcm5ldA0KPj4+PiBzd2l0Y2hlcyB3aXRoIGludGVncmF0ZWQgU29DLiBUaGVyZSBhcmUgNCBw
aHlzaWNhbCBTTUkgaW50ZXJmYWNlcyBvbiB0aGUNCj4+Pj4gUlRMOTMwMCBob3dldmVyIGFjY2Vz
cyBpcyBkb25lIHVzaW5nIHRoZSBzd2l0Y2ggcG9ydHMuIFRoZSBkcml2ZXIgdGFrZXMNCj4+Pj4g
dGhlIE1ESU8gYnVzIGhpZXJhcmNoeSBmcm9tIHRoZSBEVFMgYW5kIHVzZXMgdGhpcyB0byBjb25m
aWd1cmUgdGhlDQo+Pj4+IHN3aXRjaCBwb3J0cyBzbyB0aGV5IGFyZSBhc3NvY2lhdGVkIHdpdGgg
dGhlIGNvcnJlY3QgUEhZLiBUaGlzIG1hcHBpbmcNCj4+Pj4gaXMgYWxzbyB1c2VkIHdoZW4gZGVh
bGluZyB3aXRoIHNvZnR3YXJlIHJlcXVlc3RzIGZyb20gcGh5bGliLg0KPj4+Pg0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28u
bno+DQo+Pj4+IC0tLQ0KPj4+PiAuLi4NCj4+Pj4gK3N0YXRpYyBpbnQgcnRsOTMwMF9tZGlvX3Jl
YWRfYzIyKHN0cnVjdCBtaWlfYnVzICpidXMsIGludCBwaHlfaWQsIGludCByZWdudW0pDQo+Pj4+
ICt7DQo+Pj4+ICsJc3RydWN0IHJ0bDkzMDBfbWRpb19jaGFuICpjaGFuID0gYnVzLT5wcml2Ow0K
Pj4+PiArCXN0cnVjdCBydGw5MzAwX21kaW9fcHJpdiAqcHJpdjsNCj4+Pj4gKwlzdHJ1Y3QgcmVn
bWFwICpyZWdtYXA7DQo+Pj4+ICsJaW50IHBvcnQ7DQo+Pj4+ICsJdTMyIHZhbDsNCj4+Pj4gKwlp
bnQgZXJyOw0KPj4+PiArDQo+Pj4+ICsJcHJpdiA9IGNoYW4tPnByaXY7DQo+Pj4+ICsJcmVnbWFw
ID0gcHJpdi0+cmVnbWFwOw0KPj4+PiArDQo+Pj4+ICsJcG9ydCA9IHJ0bDkzMDBfbWRpb19waHlf
dG9fcG9ydChidXMsIHBoeV9pZCk7DQo+Pj4+ICsJaWYgKHBvcnQgPCAwKQ0KPj4+PiArCQlyZXR1
cm4gcG9ydDsNCj4+Pj4gKw0KPj4+PiArCW11dGV4X2xvY2soJnByaXYtPmxvY2spOw0KPj4+PiAr
CWVyciA9IHJ0bDkzMDBfbWRpb193YWl0X3JlYWR5KHByaXYpOw0KPj4+PiArCWlmIChlcnIpDQo+
Pj4+ICsJCWdvdG8gb3V0X2VycjsNCj4+Pj4gKw0KPj4+PiArCWVyciA9IHJlZ21hcF93cml0ZShy
ZWdtYXAsIFNNSV9BQ0NFU1NfUEhZX0NUUkxfMiwgRklFTERfUFJFUChQSFlfQ1RSTF9JTkRBVEEs
IHBvcnQpKTsNCj4+Pj4gKwlpZiAoZXJyKQ0KPj4+PiArCQlnb3RvIG91dF9lcnI7DQo+Pj4+ICsN
Cj4+Pj4gKwl2YWwgPSBGSUVMRF9QUkVQKFBIWV9DVFJMX1JFR19BRERSLCByZWdudW0pIHwNCj4+
Pj4gKwkgICAgICBGSUVMRF9QUkVQKFBIWV9DVFJMX1BBUktfUEFHRSwgMHgxZikgfA0KPj4+PiAr
CSAgICAgIEZJRUxEX1BSRVAoUEhZX0NUUkxfTUFJTl9QQUdFLCAweGZmZikgfA0KPj4+PiArCSAg
ICAgIFBIWV9DVFJMX1JFQUQgfCBQSFlfQ1RSTF9UWVBFX0MyMiB8IFBIWV9DVFJMX0NNRDsNCj4+
PiBVc2luZyAicmF3IiBhY2Nlc3MgdG8gdGhlIFBIWSBhbmQgdGhlcmVieSBieXBhc3NpbmcgdGhl
IE1ESU8NCj4+PiBjb250cm9sbGVyJ3Mgc3VwcG9ydCBmb3IgaGFyZHdhcmUtYXNzaXN0ZWQgcGFn
ZSBhY2Nlc3MgaXMgcHJvYmxlbWF0aWMuDQo+Pj4gVGhlIE1ESU8gY29udHJvbGxlciBhbHNvIHBv
bGxzIGFsbCBQSFlzIHN0YXR1cyBpbiBoYXJkd2FyZSBhbmQgaGVuY2UNCj4+PiBiZSBhd2FyZSBv
ZiB0aGUgY3VycmVudGx5IHNlbGVjdGVkIHBhZ2UuIFVzaW5nIHJhdyBhY2Nlc3MgdG8gc3dpdGNo
DQo+Pj4gdGhlIHBhZ2Ugb2YgYSBQSFkgImJlaGluZCB0aGUgYmFjayIgb2YgdGhlIGhhcmR3YXJl
IHBvbGxpbmcgbWVjaGFuaXNtDQo+Pj4gcmVzdWx0cyBpbiBpbiBvY2Nhc3Npb25hbCBoYXZvYyBv
biBsaW5rIHN0YXR1cyBjaGFuZ2VzIGluIGNhc2UgTGludXgnDQo+Pj4gcmVhZGluZyB0aGUgcGh5
IHN0YXR1cyBvdmVybGFwcyB3aXRoIHRoZSBoYXJkd2FyZSBwb2xsaW5nLg0KPj4+IFRoaXMgaXMg
ZXNwLiB3aGVuIHVzaW5nIFJlYWxUZWsncyAyLjVHQml0L3MgUEhZcyB3aGljaCByZXF1aXJlIHVz
aW5nDQo+Pj4gcGFnZWQgYWNjZXNzIGluIHRoZWlyIHJlYWRfc3RhdHVzKCkgZnVuY3Rpb24uDQo+
Pj4NCj4+PiBNYXJrdXMgU3RvY2toYXVzZW4gKGFscmVhZHkgaW4gQ2MpIGhhcyBpbXBsZW1lbnRl
ZCBhIG5pY2Ugc29sdXRpb24gdG8NCj4+PiB0aGlzIHByb2JsZW0sIGluY2x1ZGluZyBkb2N1bWVu
dGF0aW9uLCBzZWUNCj4+PiBodHRwczovL2dpdC5vcGVud3J0Lm9yZy8/cD1vcGVud3J0L29wZW53
cnQuZ2l0O2E9YmxvYjtmPXRhcmdldC9saW51eC9yZWFsdGVrL2ZpbGVzLTYuNi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9ydGw4Mzh4X2V0aC5jO2g9NGI3OTA5MDY5NmUzNDFlZDFlNDMyYTdlYzVjMGY3
ZjkyNzc2ZjBlMTtoYj1IRUFEI2wxNjMxDQo+PiBJIHJlYWQgdGhhdCBjb2RlL2NvbW1lbnQgYSBm
ZXcgdGltZXMgYW5kIEkgbXVzdCBhZG1pdCBJIHN0aWxsIGRvbid0DQo+PiBxdWl0ZSBnZXQgaXQu
IFBhcnQgb2YgdGhlIHByb2JsZW0gbWlnaHQgYmUgdGhhdCBteSBoYXJkd2FyZSBwbGF0Zm9ybSBp
cw0KPj4gdXNpbmcgQzQ1IFBIWXMgYW5kIHRoYXQncyB3aGF0IEkndmUgYmVlbiB0ZXN0aW5nIHdp
dGguIFRoZSBDMjINCj4+IHN1cHBvcnQNCj4+IGlzIGJhc2VkIG9uIG15IHJlYWRpbmcgb2YgdGhl
IGRhdGFzaGVldCBhbmQgc29tZSBvZiB3aGF0IEkgY2FuIGdsZWFuDQo+PiBmcm9tIG9wZW53cnQg
KGFsdGhvdWdoIEkgY29tcGxldGVseSBtaXNzZWQgdGhhdCBjb21tZW50IHdoZW4gSSByZWFkDQo+
PiB0aHJvdWdoIHRoZSBkcml2ZXIgdGhlIGZpcnN0IHRpbWUpLg0KPiBZZXMsIHRoaXMgaXNzdWUg
ZXhpc3RzIG9ubHkgd2l0aCBDbGF1c2UtMjIgYWNjZXNzLCBDbGF1c2UtNDUgZG9lc24ndA0KPiBy
ZXF1aXJlIGFueSBvZiB0aGF0LiBBbHNvIG5vdGUgdGhhdCBPcGVuV3J0IGhhcyByZWNlbnRseSBz
d2l0Y2hlZA0KPiBpbXBsZW1lbnRhdGlvbiBmcm9tIGEgKG5vdCB2ZXJ5IHVwc3RyZWFtIGZyaWVu
ZGx5KSBhcHByb2FjaCByZXF1aXJpbmcNCj4gZGVkaWNhdGVkIHN1cHBvcnQgZm9yIHBhZ2VkIGFj
Y2VzcyB0byBNYXJrdXMnIG5ldyBpbXBsZW1lbnRhdGlvbiB3aGljaA0KPiBhbHNvIGFkZGVkIHRo
ZSBjb21tZW50Lg0KPg0KPj4+IEluY2x1ZGluZyBhIHNpbWlsYXIgbWVjaGFuaXNtIGluIHRoaXMg
ZHJpdmVyIGZvciBDMjIgcmVhZCBhbmQgd3JpdGUNCj4+PiBvcGVyYXRpb25zIHdvdWxkIGJlIG15
IGFkdmlzZSwgc28gaGFyZHdhcmUtYXNzaXN0ZWQgYWNjZXNzIHRvIHRoZSBQSFkNCj4+PiBwYWdl
cyBpcyBhbHdheXMgdXNlZCwgYW5kIGhlbmNlIHRoZSBoYXJkd2FyZSBwb2xsaW5nIG1lY2hhbmlz
bSBpcyBhd2FyZQ0KPj4+IG9mIHRoZSBjdXJyZW50bHkgc2VsZWN0ZWQgcGFnZS4NCj4+IFNvIGZh
ciB1cHN0cmVhbSBMaW51eCBkb2Vzbid0IGhhdmUgZ2VuZXJpYyBwYWdlZCBQSFkgcmVnaXN0ZXIg
ZnVuY3Rpb25zLg0KPj4gSXQgc291bmRzIGxpa2UgdGhhdCdkIGJlIGEgcHJlcmVxdWlzaXRlIGZv
ciB0aGlzLg0KPiBObywgdGhhdCdzIGV4YWN0bHkgd2hhdCBNYXJrdXMgaGFzIGltcHJvdmVkIGFi
b3V0IHRoZSBpbXBsZW1lbnRhdGlvbg0KPiBjb21wYXJlZCB0byB0aGUgcHJldmlvdXMgYXBwcm9h
Y2g6DQo+IFdlIHNpbXBseSBpbnRlcmNlcHQgYWNjZXNzIHRvIEMyMiByZWdpc3RlciAweDFmLiBG
b3Igd3JpdGUgYWNjZXNzIHRoZQ0KPiB0by1iZS1zZWxlY3RlZCBwYWdlIGlzIHN0b3JlZCBpbiB0
aGUgcHJpdiBzdHJ1Y3Qgb2YgdGhlIE1ESU8gYnVzLCBpbiBhDQo+IDAtaW5pdGlhbGl6ZWQgYXJy
YXkgZm9yIGVhY2ggTURJTyBidXMgYWRkcmVzcy4gQzIyIHJlYWQgYWNjZXNzIHRvDQo+IHJlZ2lz
dGVyIDB4MWYgY2FuIHJlYWQgYmFjayB0aGF0IHZhbHVlLCBhbGwgd2l0aG91dCBhY3R1YWxseSBh
Y2Vzc2luZyB0aGUNCj4gaGFyZHdhcmUuDQo+IEFueSBzdWJzZXF1ZW50IEMyMiByZWFkIG9yIHdy
aXRlIG9wZXJhdGlvbiB3aWxsIHRoZW4gdXNlIHRoZSBzZWxlY3RlZA0KPiBwYWdlIHN0b3JlZCBm
b3IgdGhhdCBQSFkgaW4gdGhlIG1lbW9yeSBhc3NvY2lhdGVkIHdpdGggdGhlIE1ESU8gYnVzLg0K
Pg0KPiBJbiB0aGlzIHdheSBwYWdlIHNlbGVjdGlvbiBpcyBsZWZ0IHRvIHRoZSBNRElPIGNvbnRy
b2xsZXIgd2hpY2ggYWxzbw0KPiBjYXJyaWVzIG91dCBwb2xsaW5nIGluIGJhY2tncm91bmQgKHNl
ZSBTTUlfUE9MTF9DVFJMKSwgYW5kIGNsYXNoZXMgZHVlDQo+IHRvIGNvbmdydWVudCBhY2Nlc3Mg
YnkgTGludXggYW5kIGhhcmR3YXJlIHBvbGxpbmcgZG9uJ3Qgb2NjdXIuDQoNCkFoIEkgZ2V0IGl0
LiBJdCdzIGFib3V0IHRyYWNraW5nIHRoZSBjdXJyZW50IHBhZ2UgZm9yIGEgcGFydGljdWxhciAN
CmRldmljZSBhZGRyZXNzIGFuZCB1c2luZyB0aGF0IGluc3RlYWQgb2YgMHhmZmYgaW4gDQpGSUVM
RF9QUkVQKFBIWV9DVFJMX01BSU5fUEFHRSwgMHhmZmYpLiBJJ20gbm90IHN1cmUgaXQncyBnb2lu
ZyB0byB3b3JrIA0KZ2VuZXJpY2FsbHkuIFJlYWx0ZWsgc3dpdGNoZXMga25vdyBhYm91dCBSZWFs
dGVrIFBIWXMgYnV0IEkndmUgc2VlbiANCnBsZW50eSBvZiBvdGhlciBQSFlzIHRoYXQgZG8gcGFn
aW5nIHZpYSBhZGRyZXNzZXMgb3RoZXIgdGhhbiAweDFmIA0KKE1hcnZlbGwgODhFMTExMSBmb3Ig
ZXhhbXBsZSB1c2VzIDB4MWQgZm9yIGl0cyBleHRhZGRyLCBzb21lIEJyb2FkY29tIA0KUEhZcyBz
ZWVtIHRvIHVzZSAweDFjKS4gSSdtIG5vdCBzdXJlIGhvdyBtYW55IHN5c3RlbXMgYXJlIG1peGlu
ZyB2ZW5kb3JzIA0KZm9yIEMyMiBQSFlzICh0aGUgWnl4ZWwgYm9hcmRzIHNlZW0gdG8gaGF2ZSBN
YXJ2ZWxsIEFRUiAxMEcgUEhZcyBidXQgDQp0aGF0J3MgQzQ1KS4NCg0KSSdtIGdvaW5nIHRvIHNl
bmQgdjEwIG91dCBzaG9ydGx5IHdpdGggdGhlIG1pbm9yIGFkZGl0aW9ucyBzdWdnZXN0ZWQgYnkg
DQpDaHJpc3RvcGhlLiBJZiB3ZSBjYW4gY29tZSB1cCB3aXRoIHNvbWV0aGluZyBzdWl0YWJsZSBm
b3IgdGhlIEMyMiBwYWdpbmcgDQppdCdzIHByb2JhYmx5IGJlc3QgZG9uZSBhcyBuZXcgY29kZSBv
biB0b3Agb2YgdGhhdC4NCg0K

