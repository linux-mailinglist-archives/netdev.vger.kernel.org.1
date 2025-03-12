Return-Path: <netdev+bounces-174405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A787A5E79D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E093B53CC
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594531F0E26;
	Wed, 12 Mar 2025 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Q8ZqBJZs"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C91DE3A4
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741819279; cv=none; b=Taq9ubYyWpzKOgocB9jLVA8qb6jioI2slJNVtcFvee5emHSHofJqKIDT/HRsQSnAZyDwyxhvnWhYllfP/dBbUnSFWu6MBgc34dBfgb6lKrtxLxg7GT8/4SNL9YOSIIOTkHvn0BhFmydgZTqbVdzzW+qAsIJ1EgZBzg4UI3Jnrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741819279; c=relaxed/simple;
	bh=7DHy57CpyOxSr6hI4XZcYB+GF56qgoUeRs1OWO3ngOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RboOEf+Fknyv1Rf5oUJpjA7O9Swv46gzBKVxoJYfdrhy5kNQq+LPhwFJVeaAuAWsDCC/w2MDv6p3+s+01QdI1aoE0x9ov07H+xZfCrhV3zzzt741mgcRTXYxXK/v4Tt/vfjleDOVAxgXwi/Q6yPXvY3fgFcmK5c/xu/uys79l+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Q8ZqBJZs; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A15972C00BF
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 11:41:12 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1741819272;
	bh=7DHy57CpyOxSr6hI4XZcYB+GF56qgoUeRs1OWO3ngOk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Q8ZqBJZsCPKSrzgNWkDN8IE2N+r/hWMR8Rp9Z7obz8O2GN7VxMAKr37wxDWR8Gsbr
	 szHJf+IVfDZAQ1YY9cTTaCmr6fQnsTWY9WKZ1tuDkfmRtKOWyQm4mJCkZJCQbnmbDS
	 B/k8ygYNWytzzwvvStiuvAEjHl2z7iIWNHKli9iyilSTg+JKL6HCKfn48O63ClGowf
	 4XhckthbsZTi/tDSVeuzFgBT9DS+BgRROcez3jkKWqID+eqTNpAPcg4m9ixfLJPkt+
	 703VWiUVhSu0Zf0F9i9yxT1Pq/2XITVEQxAxYd0TWmwhJSJNIr4m8nQEBl2to0jtam
	 Y1ow+4NiRTXVg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67d20d880001>; Thu, 13 Mar 2025 11:41:12 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 11:41:12 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Thu, 13 Mar 2025 11:41:12 +1300
From: Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] igb: Prevent IPCFGN write resetting autoneg
 advertisement register
Thread-Topic: [PATCH net] igb: Prevent IPCFGN write resetting autoneg
 advertisement register
Thread-Index: AQHbkv4NyugObaZ6WE6A62N1bqpTJrNunxEAgACJA4CAABNUAIAABGMA
Date: Wed, 12 Mar 2025 22:41:12 +0000
Message-ID: <7d3012e870248ae3db4cde78983455d3ee52eebe.camel@alliedtelesis.co.nz>
References: <20250312032251.2259794-1-hamish.martin@alliedtelesis.co.nz>
	 <eae8e09c-f571-4016-b11d-88611a2b368f@lunn.ch>
	 <9455a623aaeb08999eec9202459d266f22432c00.camel@alliedtelesis.co.nz>
	 <0486c877-cbb4-411b-9bd6-9b10306c47a6@lunn.ch>
In-Reply-To: <0486c877-cbb4-411b-9bd6-9b10306c47a6@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB72F08C9C216C4C8A5CF7CF464FE2E5@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ccpxrWDM c=1 sm=1 tr=0 ts=67d20d88 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=G-b9TgLbWs4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=ErtXPwngb1x9mck47YQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gV2VkLCAyMDI1LTAzLTEyIGF0IDIzOjI1ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
PiBIaSBBbmRyZXcsDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLiBJJ2xsIHRy
eSBhbmQgZ2l2ZSBtb3JlIGRldGFpbCBhYm91dA0KPiA+IHdoYXQncw0KPiA+IGhhcHBlbmluZyB3
aXRoIGEgY29uY3JldGUgZXhhbXBsZS4NCj4gPiANCj4gPiBJZiB3ZSBzdGFydCB3aXRoIHRoZSBk
ZXZpY2UgaW4gYSBzdGF0ZSB3aGVyZSBpdCBpcyBhZHZlcnRpc2luZzoNCj4gPiAxMDAwQmFzZVQg
RnVsbA0KPiA+IDEwMGJhc2VUIEZ1bGwNCj4gPiAxMDBiYXNlVCBIYWxmDQo+ID4gMTBiYXNlVCBG
dWxsDQo+ID4gMTBiYXNlVCBIYWxmDQo+ID4gSSBzZWUgdGhlIGZvbGxvd2luZyBzZXR0aW5ncyBp
biB0aGUgYXV0b25lZyByZWxhdGVkIHJlZ2lzdGVyczoNCj4gPiAwLjQgPSAweDBkZTEgKFBIWV9B
VVRPTkVHX0FEVikNCj4gPiAwLjkgPSAweDAyMDAgKFBIWV8xMDAwVF9DVFJMKQ0KPiA+IA0KPiA+
IEVFRSBpcyBkaXNhYmxlZC4NCj4gPiANCj4gPiBJZiBJIHRoZW4gYWRqdXN0IHRoZSBhZHZlcnRp
c2VtZW50IHRvIG9ubHkgYWR2ZXJ0aXNlIDEwMDBCYXNlVCBGdWxsDQo+ID4gYW5kDQo+ID4gMTAw
YmFzZVQgRnVsbCB3aXRoOg0KPiA+ICMgZXRodG9vbCAtcyBldGgwIGFkdmVydGlzZSAweDI4DQo+
ID4gSSBzZWUgdGhlIGZvbGxvd2luZyB3cml0ZXMgdG8gdGhlIHJlZ2lzdGVyczoNCj4gPiAxLiBJ
biBpZ2JfcGh5X3NldHVwX2F1dG9uZWcoKSBQSFlfQVVUT05FR19BRFYgaXMgd3JpdHRlbiB3aXRo
DQo+ID4gMHgwMTAxDQo+ID4gKHRoZSBjb3JyZWN0IHZhbHVlKQ0KPiA+IDIuIExhdGVyIGluIGln
Yl9waHlfc2V0dXBfYXV0b25lZygpIFBIWV8xMDAwVF9DVFJMIGlzIHdyaXR0ZW4gd2l0aA0KPiA+
IDB4MDIwMCAoY29ycmVjdCkNCj4gPiAzLiBBdXRvbmVnIGdldHMgcmVzdGFydGVkIGluIGlnYl9j
b3BwZXJfbGlua19hdXRvbmVnKCkgd2l0aA0KPiA+IFBIWV9DT05UUk9MDQo+ID4gKDAuMCkgYmVp
bmcgd3JpdHRlbiB3aXRoIDB4MTM0MA0KPiA+IChldmVyeXRoaW5nIGxvb2tzIGZpbmUgdXAgdW50
aWwgaGVyZSkNCj4gPiA0LiBOb3cgd2UgcmVhY2ggaWdiX3NldF9lZWVfaTM1MCgpLiBIZXJlIHdl
IHJlYWQgaW4gSVBDTkZHIGFuZCBpdA0KPiA+IGhhcw0KPiA+IHZhbHVlIDB4Zi4gRUVFIGlzIGRp
c2FibGVkIHNvIHdlIGhpdCB0aGUgJ2Vsc2UnIGNhc2UgYW5kIHJlbW92ZQ0KPiA+IEUxMDAwX0lQ
Q05GR19FRUVfMUdfQU4gYW5kIEUxMDAwX0lQQ05GR19FRUVfMTAwTV9BTiBmcm9tIHRoZQ0KPiA+
ICdpcGNuZmcnDQo+ID4gdmFsdWUuIFdlIHRoZW4gd3JpdGUgdGhpcyBiYWNrIGFzIDB4My4gQXQg
dGhpcyBwb2ludCwgaWYgeW91IHJlLQ0KPiA+IHJlYWQNCj4gPiBQSFlfQVVUT05FR19BRFYgeW91
IHdpbGwgc2VlIGl0J3MgY29udGVudHMgaGFzIGJlZW4gcmVzZXQgdG8NCj4gPiAweDBkZTEuDQo+
IA0KPiBUaGFua3MgZm9yIHRoZSBhZGRpdGlvbmFsIGRldGFpbHMuIFRoZXNlIHNob3VsZCBnbyBp
bnRvIHRoZSBjb21taXQNCj4gbWVzc2FnZS4NCk9LLCBJJ2xsIHVwZGF0ZSBpbnRvIGEgdjIgYXQg
c29tZSBwb2ludC4NCg0KPiANCj4gPiBJZiB5b3UgcnVuIHRoZSBzYW1lIGV4YW1wbGUgYWJvdmUg
YnV0IHdpdGggRUVFIGVuYWJsZWQgKGV0aHRvb2wgLS0NCj4gPiBzZXQtDQo+ID4gZWVlIGV0aDAg
ZWVlIG9uOyBldGh0b29sIC1zIGV0aDAgYWR2ZXJ0aXNlIDB4MjgpIHRoZSBpc3N1ZSBpcyBub3QN
Cj4gPiBzZWVuLg0KPiA+IEluIHRoaXMgY2FzZSB0aGUgY29udGVudHMgb2YgSVBDTkZHIGFyZSB3
cml0dGVuIGJhY2sgdW5tb2RpZmllZCBhcw0KPiA+IDB4Zi4NCj4gPiBUaGlzIHNlZW1zIGltcG9y
dGFudCB0byBhdm9pZCB0aGUgYnVnLg0KPiANCj4gWWVzLCBpdCBkb2VzIHNlZW0gbGlrZSB0aGUg
UEhZIGlzIGJyb2tlbi4NCj4gDQo+ID4gDQo+ID4gSXQgc2VlbXMgdGhhdCBhbnkgY2FzZSB3aGVy
ZSBFRUUgaXMgZGlzYWJsZWQgd2lsbCBsZWFkIHRvIHRoZQ0KPiA+IHVuZGVzaXJhYmxlIGJlaGF2
aW91ciB3aGVyZSB0aGUgY29udGVudHMgb2YgUEhZX0FVVE9ORUdfQURWIGlzDQo+ID4gcmVzZXQg
dG8NCj4gPiAweDBkZTEuIFRoZSBrZXkgdHJpZ2dlciBmb3IgdGhpcyBhcHBlYXJzIHRvIGJlIGNo
YW5nZXMgdG8gZWl0aGVyIG9yDQo+ID4gYm90aCBvZiBFRUVfMTAwTV9BTiBhbmQgRUVFXzFHX0FO
IGluIElQQ05GRy4gVGhlIGRhdGFzaGVldCBkb2VzDQo+ID4gbm90ZQ0KPiA+IHRoYXQgIkNoYW5n
aW5nIHZhbHVlIG9mIGJpdCBjYXVzZXMgbGluayBkcm9wIGFuZCByZS1uZWdvdGlhdGlvbiINCj4g
DQo+IFdoaWNoIGlzIHdoYXQgeW91IHdvdWxkIGV4cGVjdCwgc2luY2UgRUVFIGlzIG5lZ290aWF0
ZWQuIEJ1dA0KPiBpbXBsaWNpdGx5IGNoYW5naW5nIHRoZSBsaW5rIG1vZGVzIGFkdmVydGlzZWQg
aXMgbm90IHdoYXQgeW91IHdvdWxkDQo+IGV4cGVjdC4NCj4gDQo+IEJ5IHRoZSB3YXksIHdoYXQg
UEhZIGlzIHRoaXM/IEkgZG9uJ3QgcmVtZW1iZXIgc2VlaW5nIGFueSBlcnJhdGEgZm9yDQo+IExp
bnV4IFBIWSBkcml2ZXJzIHJlc2VtYmxpbmcgdGhpcy4NClRoZSBwaHkgaXMgaTIxMC4gSSd2ZSBh
bHNvIGNoZWNrZWQgZXJyYXRhIGFuZCBzZWUgbm90aGluZyBldmVuIHZhZ3VlbHkNCnJlbGF0ZWQg
dG8gdGhpcyBiZWhhdmlvdXIuDQoNCj4gDQo+ID4gV2hhdCdzIHlvdXIgb3BpbmlvbiBvbiB0aGF0
IGxlc3MgaW52YXNpdmUgZml4IChpLmUgcmVtb3ZlICJpcGNuZmcNCj4gPiAmPQ0KPiA+IH4oRTEw
MDBfSVBDTkZHX0VFRV8xR19BTiB8IEUxMDAwX0lQQ05GR19FRUVfMTAwTV9BTik7IiApPyBJcyBp
dA0KPiA+IHN1ZmZpY2llbnQgdG8gcmVseSBvbiB0aGUgRUVFUiBzZXR0aW5ncyB0byBjb250cm9s
IGRpc2FibGluZyBFRUUNCj4gPiB3aXRoDQo+ID4gdGhlIElQQ05GRyByZWdpc3RlciBzdGlsbCBz
ZXQgdG8gYWR2ZXJ0aXNlIHRob3NlIG1vZGVzPw0KPiANCj4gSSBhY3R1YWxseSB0aGluayB5b3Ug
bmVlZCB0byBkbyBtb3JlIHRlc3RpbmcuIEFzc3VtaW5nIHRoZSBQSFkgaXMgbm90DQo+IGV2ZW4g
bW9yZSBicm9rZW4gdGhhbiB3ZSB0aGluaywgaXQgc2hvdWxkIG5vdCBtYXR0ZXIgaWYgaXQgYWR2
ZXJ0aXNlcw0KPiBFRUUgbW9kZSBmb3IgbGluayBtb2RlcyB3aGljaCBhcmUgbm90IGFkdmVydGlz
ZWQuIFRoZSBsaW5rIHBhcnRuZXINCj4gc2hvdWxkIGlnbm9yZSB0aGVtLiBJdCB3b3VsZCBiZSBn
b29kIGlmIHlvdSB0ZXN0ZWQgb3V0IHZhcmlvdXMgRUVFDQo+IGNvbWJpbmF0aW9ucyBmcm9tIGJv
dGggbGluayBwYXJ0bmVycyBzaWRlcy4NCk9LLCBJJ2xsIGRvIHNvbWUgbW9yZSB0ZXN0aW5nIG9m
IHRoaXMgYWx0ZXJuYXRlIHBvdGVudGlhbCBmaXggYXJvdW5kDQpFRUUgYmVoYXZpb3VyIGFzIHlv
dSBzdWdnZXN0Lg0KDQo+IA0KPiBIb3dldmVyLCBzZXR0aW5nIEVFRSBhZHZlcnRpc2VtZW50IGFu
ZCB0aGVuIGFsd2F5cyBzZXR0aW5nIGxpbmsgbW9kZQ0KPiBhZHZlcnRpc2VtZW50IGRvZXMgc2Vl
bSBsaWtlIGEgZ29vZCB3b3JrYXJvdW5kLiBJdCB3b3VsZCBob3dldmVyIGJlDQo+IGdvb2QgdG8g
Z2V0IHNvbWUgc29ydCBvZiBmZWVkYmFjayBmcm9tIHRoZSBQSFkgc2lsaWNvbiB2ZW5kb3IgYWJv
dXQNCj4gdGhpcyBvZGQgYmVoYXZpb3VyLg0KWWVzLCBJJ20gaG9waW5nIFRvbnkgTmd1eWVuIGFu
ZC9vciBQcnplbWVrIEtpdHN6ZWwgZnJvbSBJbnRlbCBtaWdodCBiZQ0KYWJsZSB0byBzaGVkIG1v
cmUgbGlnaHQgb24gdGhlIHVuZGVybHlpbmcgcHJvYmxlbS4gSSdsbCB3YWl0IGZvciB0aGVtDQpv
ciBhbnlvbmUgZWxzZSB0byB3ZWlnaCBpbi4NCg0KVGhhbmtzLA0KSGFtaXNoIE0NCg0K

