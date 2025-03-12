Return-Path: <netdev+bounces-174380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC6FA5E652
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B1A1891B92
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADFD1EC00C;
	Wed, 12 Mar 2025 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="JU85+wX6"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38231D6DC8
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814186; cv=none; b=LVADklUJAZt9p4NbA3KvQme6VylRNscXaWqeb+P9yeP5gwIcWCX+nFqon4tiEpLOy6LFGyP41Ow8gOiJusVAa3wgxigdCnafd+Fzf1j6ydfOM35SwdmH973OukN/wEC5iIeAT+1I+JidxU7rGBPdT6IIch9QpWrNE0hcGF4IipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814186; c=relaxed/simple;
	bh=95gP9x0gIV+8tJ7PSqJMluc3pg6aBPayZJybf6IhrNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R3d4ZqoFsQHFoNlovgt0pxND+7gFTGUH3FqRFJP9dihg9oNSTbHtloB4gGBmk1a9u4hSqpXT5961uCtdgqEoPYdF7AgqwXkArDXJ61eywM7ksmd1E5/MAVnxUDutR3L4A/N9LJHU9F/i4cdFAy8uLX/bi8xW8tPLGA8w1jSdxrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=JU85+wX6; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 44F4E2C012B
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 10:16:20 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1741814180;
	bh=95gP9x0gIV+8tJ7PSqJMluc3pg6aBPayZJybf6IhrNk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=JU85+wX6+L3EkydojvbWvyHxMJTNC9e+yw08ygnDLN8nlaGNHZdxFWlDcwNJzOmE4
	 Odz0yxJ0JM+apBwiFwEXyKLC9v9YH78AEwjvqTi+qNbQ02Zdf6ztzyeK13zlK3XUyS
	 ITevG0gFzpfPbC+1LXP/tAKPETl0mwJpmZdRFwh77l9X/AydmlgrmfeAfXNAMxqZrn
	 6S9jw58f/C7VTsKg7VFKE9+s8HdcC3L4FBCMKU6bmFBdNS1jUrcQMg/5Fb6u4ou9Vt
	 0fAIMQJnLdUf0utI32KkA7L0APItZYwvXpU5NgtY4DJSJfZLTL+YwCQColH3bo5nzo
	 ++pnLV4ba7NQA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67d1f9a40001>; Thu, 13 Mar 2025 10:16:20 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 10:16:20 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Thu, 13 Mar 2025 10:16:19 +1300
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
Thread-Index: AQHbkv4NyugObaZ6WE6A62N1bqpTJrNunxEAgACJA4A=
Date: Wed, 12 Mar 2025 21:16:19 +0000
Message-ID: <9455a623aaeb08999eec9202459d266f22432c00.camel@alliedtelesis.co.nz>
References: <20250312032251.2259794-1-hamish.martin@alliedtelesis.co.nz>
	 <eae8e09c-f571-4016-b11d-88611a2b368f@lunn.ch>
In-Reply-To: <eae8e09c-f571-4016-b11d-88611a2b368f@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AE8EE968141F6499BC26C45B57FF850@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ccpxrWDM c=1 sm=1 tr=0 ts=67d1f9a4 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=G-b9TgLbWs4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=6JeRrGpNqYz-meT2EE4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gV2VkLCAyMDI1LTAzLTEyIGF0IDE0OjA1ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
T24gV2VkLCBNYXIgMTIsIDIwMjUgYXQgMDQ6MjI6NTBQTSArMTMwMCwgSGFtaXNoIE1hcnRpbiB3
cm90ZToNCj4gPiBBbiBpc3N1ZSBpcyBvYnNlcnZlZCBvbiB0aGUgaTIxMCB3aGVuIGF1dG9uZWdv
dGlhdGlvbiBhZHZlcnRpc2VtZW50DQo+ID4gaXMgc2V0DQo+ID4gdG8gYSBzcGVjaWZpYyBzdWJz
ZXQgb2YgdGhlIHN1cHBvcnRlZCBzcGVlZHMgYnV0IHRoZSByZXF1ZXN0ZWQNCj4gPiBzZXR0aW5n
cw0KPiA+IGFyZSBub3QgY29ycmVjdGx5IHNldCBpbiB0aGUgQ29wcGVyIEF1dG8tTmVnb3RpYXRp
b24gQWR2ZXJ0aXNlbWVudA0KPiA+IFJlZ2lzdGVyDQo+ID4gKFBhZ2UgMCwgUmVnaXN0ZXIgNCku
DQo+ID4gSW5pdGlhbGx5LCB0aGUgYWR2ZXJ0aXNlbWVudCByZWdpc3RlciBpcyBjb3JyZWN0bHkg
c2V0IGJ5IHRoZQ0KPiA+IGRyaXZlciBjb2RlDQo+ID4gKGluIGlnYl9waHlfc2V0dXBfYXV0b25l
ZygpKSBidXQgdGhpcyByZWdpc3RlcidzIGNvbnRlbnRzIGFyZQ0KPiA+IG1vZGlmaWVkIGFzIGEN
Cj4gPiByZXN1bHQgb2YgYSBsYXRlciB3cml0ZSB0byB0aGUgSVBDTkZHIHJlZ2lzdGVyIGluDQo+
ID4gaWdiX3NldF9lZWVfaTM1MCgpLiBJdCBpcw0KPiA+IHVuY2xlYXIgd2hhdCB0aGUgbWVjaGFu
aXNtIGlzIGZvciB0aGUgd3JpdGUgb2YgdGhlIElQQ05GRyByZWdpc3Rlcg0KPiA+IHRvIGxlYWQN
Cj4gPiB0byB0aGUgY2hhbmdlIGluIHRoZSBhdXRvbmVnIGFkdmVydGlzZW1lbnQgcmVnaXN0ZXIu
DQo+ID4gVGhlIGlzc3VlIGNhbiBiZSBvYnNlcnZlZCBieSwgZm9yIGV4YW1wbGUsIHJlc3RyaWN0
aW5nIHRoZQ0KPiA+IGFkdmVydGlzZWQgc3BlZWQNCj4gPiB0byBqdXN0IDEwTUZ1bGwuIFRoZSBl
eHBlY3RlZCByZXN1bHQgd291bGQgYmUgdGhhdCB0aGUgbGluayB3b3VsZA0KPiA+IGNvbWUgdXAN
Cj4gPiBhdCAxME1GdWxsLCBidXQgYWN0dWFsbHkgdGhlIHBoeSBlbmRzIHVwIGFkdmVydGlzaW5n
IGEgZnVsbCBzdWl0ZQ0KPiA+IG9mIHNwZWVkcw0KPiA+IGFuZCB0aGUgbGluayB3aWxsIGNvbWUg
dXAgYXQgMTAwTUZ1bGwuDQo+ID4gDQo+ID4gVGhlIHByb2JsZW0gaXMgYXZvaWRlZCBieSBlbnN1
cmluZyB0aGF0IHRoZSB3cml0ZSB0byB0aGUgSVBDTkZHDQo+ID4gcmVnaXN0ZXINCj4gPiBvY2N1
cnMgYmVmb3JlIHRoZSB3cml0ZSB0byB0aGUgYXV0b25lZyBhZHZlcnRpc2VtZW50IHJlZ2lzdGVy
Lg0KPiANCj4gV2hlbiB5b3Ugc2V0IHRoZSBhZHZlcnRpc2VtZW50IGZvciBvbmx5IDEwQmFzZVQg
RnVsbCwgd2hhdCBFRUUNCj4gc2V0dGluZ3MgYXJlIGFwcGxpZWQ/IEl0IGNvdWxkIGJlIHRoYXQg
Y2FsbGluZyBpZ2Jfc2V0X2VlZV9pMzUwKCkgdG8NCj4gYWR2ZXJ0aXNlIEVFRSBmb3IgMTAwQmFz
ZVQgRnVsbCBhbmQgMTAwMEJhc2VUIEZ1bGwsIHdoaWxlIG9ubHkNCj4gYWR2ZXJ0aXNpbmcgbGlu
ayBtb2RlIDEwQmFzZVQgY2F1c2VzIHRoZSBjaGFuZ2UgdG8gdGhlIGF1dG9uZWcNCj4gcmVnaXN0
ZXIuDQo+IA0KPiBQbGVhc2UgdHJ5IG9ubHkgYWR2ZXJ0aXNpbmcgRUVFIG1vZGVzIHdoaWNoIGZp
dCB3aXRoIHRoZSBiYXNpYyBsaW5rDQo+IG1vZGUgYWR2ZXJ0aXNpbmcuDQo+IA0KPiDCoMKgwqDC
oCBBbmRyZXcNCkhpIEFuZHJldywNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLiBJJ2xsIHRy
eSBhbmQgZ2l2ZSBtb3JlIGRldGFpbCBhYm91dCB3aGF0J3MNCmhhcHBlbmluZyB3aXRoIGEgY29u
Y3JldGUgZXhhbXBsZS4NCg0KSWYgd2Ugc3RhcnQgd2l0aCB0aGUgZGV2aWNlIGluIGEgc3RhdGUg
d2hlcmUgaXQgaXMgYWR2ZXJ0aXNpbmc6DQoxMDAwQmFzZVQgRnVsbA0KMTAwYmFzZVQgRnVsbA0K
MTAwYmFzZVQgSGFsZg0KMTBiYXNlVCBGdWxsDQoxMGJhc2VUIEhhbGYNCkkgc2VlIHRoZSBmb2xs
b3dpbmcgc2V0dGluZ3MgaW4gdGhlIGF1dG9uZWcgcmVsYXRlZCByZWdpc3RlcnM6DQowLjQgPSAw
eDBkZTEgKFBIWV9BVVRPTkVHX0FEVikNCjAuOSA9IDB4MDIwMCAoUEhZXzEwMDBUX0NUUkwpDQoN
CkVFRSBpcyBkaXNhYmxlZC4NCg0KSWYgSSB0aGVuIGFkanVzdCB0aGUgYWR2ZXJ0aXNlbWVudCB0
byBvbmx5IGFkdmVydGlzZSAxMDAwQmFzZVQgRnVsbCBhbmQNCjEwMGJhc2VUIEZ1bGwgd2l0aDoN
CiMgZXRodG9vbCAtcyBldGgwIGFkdmVydGlzZSAweDI4DQpJIHNlZSB0aGUgZm9sbG93aW5nIHdy
aXRlcyB0byB0aGUgcmVnaXN0ZXJzOg0KMS4gSW4gaWdiX3BoeV9zZXR1cF9hdXRvbmVnKCkgUEhZ
X0FVVE9ORUdfQURWIGlzIHdyaXR0ZW4gd2l0aCAweDAxMDENCih0aGUgY29ycmVjdCB2YWx1ZSkN
CjIuIExhdGVyIGluIGlnYl9waHlfc2V0dXBfYXV0b25lZygpIFBIWV8xMDAwVF9DVFJMIGlzIHdy
aXR0ZW4gd2l0aA0KMHgwMjAwIChjb3JyZWN0KQ0KMy4gQXV0b25lZyBnZXRzIHJlc3RhcnRlZCBp
biBpZ2JfY29wcGVyX2xpbmtfYXV0b25lZygpIHdpdGggUEhZX0NPTlRST0wNCigwLjApIGJlaW5n
IHdyaXR0ZW4gd2l0aCAweDEzNDANCihldmVyeXRoaW5nIGxvb2tzIGZpbmUgdXAgdW50aWwgaGVy
ZSkNCjQuIE5vdyB3ZSByZWFjaCBpZ2Jfc2V0X2VlZV9pMzUwKCkuIEhlcmUgd2UgcmVhZCBpbiBJ
UENORkcgYW5kIGl0IGhhcw0KdmFsdWUgMHhmLiBFRUUgaXMgZGlzYWJsZWQgc28gd2UgaGl0IHRo
ZSAnZWxzZScgY2FzZSBhbmQgcmVtb3ZlDQpFMTAwMF9JUENORkdfRUVFXzFHX0FOIGFuZCBFMTAw
MF9JUENORkdfRUVFXzEwME1fQU4gZnJvbSB0aGUgJ2lwY25mZycNCnZhbHVlLiBXZSB0aGVuIHdy
aXRlIHRoaXMgYmFjayBhcyAweDMuIEF0IHRoaXMgcG9pbnQsIGlmIHlvdSByZS1yZWFkDQpQSFlf
QVVUT05FR19BRFYgeW91IHdpbGwgc2VlIGl0J3MgY29udGVudHMgaGFzIGJlZW4gcmVzZXQgdG8g
MHgwZGUxLg0KDQpJZiB5b3UgcnVuIHRoZSBzYW1lIGV4YW1wbGUgYWJvdmUgYnV0IHdpdGggRUVF
IGVuYWJsZWQgKGV0aHRvb2wgLS1zZXQtDQplZWUgZXRoMCBlZWUgb247IGV0aHRvb2wgLXMgZXRo
MCBhZHZlcnRpc2UgMHgyOCkgdGhlIGlzc3VlIGlzIG5vdCBzZWVuLg0KSW4gdGhpcyBjYXNlIHRo
ZSBjb250ZW50cyBvZiBJUENORkcgYXJlIHdyaXR0ZW4gYmFjayB1bm1vZGlmaWVkIGFzIDB4Zi4N
ClRoaXMgc2VlbXMgaW1wb3J0YW50IHRvIGF2b2lkIHRoZSBidWcuDQoNCkl0IHNlZW1zIHRoYXQg
YW55IGNhc2Ugd2hlcmUgRUVFIGlzIGRpc2FibGVkIHdpbGwgbGVhZCB0byB0aGUNCnVuZGVzaXJh
YmxlIGJlaGF2aW91ciB3aGVyZSB0aGUgY29udGVudHMgb2YgUEhZX0FVVE9ORUdfQURWIGlzIHJl
c2V0IHRvDQoweDBkZTEuIFRoZSBrZXkgdHJpZ2dlciBmb3IgdGhpcyBhcHBlYXJzIHRvIGJlIGNo
YW5nZXMgdG8gZWl0aGVyIG9yDQpib3RoIG9mIEVFRV8xMDBNX0FOIGFuZCBFRUVfMUdfQU4gaW4g
SVBDTkZHLiBUaGUgZGF0YXNoZWV0IGRvZXMgbm90ZQ0KdGhhdCAiQ2hhbmdpbmcgdmFsdWUgb2Yg
Yml0IGNhdXNlcyBsaW5rIGRyb3AgYW5kIHJlLW5lZ290aWF0aW9uIiAtIHdoYXQNCkkgc2VlIGlz
IGEgbG90IG1vcmUgdGhhbiB0aGF0IGJ1dCB0aGVyZSBkb2VzIGF0IGxlYXN0IHNlZW0gdG8gYmUg
c29tZQ0KYWNrbm93bGVkZ2VtZW50IG9mIGEgcG9zc2libGUgbGluayB0byB0aGUgaXNzdWUgSSBz
ZWUuDQoNCkl0IHNlZW1zIHRoZSBpbnRlbnQgb2YgdGhlIGNvZGUgaW4gdGhlIGVsc2UgY2FzZSB0
aGF0IG1vZGlmaWVzIElQQ05GRw0KaXMgdG8gbWFrZSBFRUUgcmVhbGx5IHJlYWxseSAib2ZmIi4g
QnV0IHBlcmhhcHMgd2UgY291bGQganVzdCBhdm9pZA0KYWx0ZXJpbmcgSVBDTkZHIGFsdG9nZXRo
ZXIgaW4gdGhlIEVFRSBkaXNhYmxlZCBjYXNlIGFuZCByZWx5IG9uDQpjb250cm9sbGluZyBFRUUg
d2l0aCB0aGUgRUVFUiByZWdpc3RlciBvbmx5PyBJZiBJIG1ha2UgdGhhdCBjaGFuZ2UNCmluc3Rl
YWQgbXkgaXNzdWVzIGdvIGF3YXkuDQoNCldoYXQncyB5b3VyIG9waW5pb24gb24gdGhhdCBsZXNz
IGludmFzaXZlIGZpeCAoaS5lIHJlbW92ZSAiaXBjbmZnICY9DQp+KEUxMDAwX0lQQ05GR19FRUVf
MUdfQU4gfCBFMTAwMF9JUENORkdfRUVFXzEwME1fQU4pOyIgKT8gSXMgaXQNCnN1ZmZpY2llbnQg
dG8gcmVseSBvbiB0aGUgRUVFUiBzZXR0aW5ncyB0byBjb250cm9sIGRpc2FibGluZyBFRUUgd2l0
aA0KdGhlIElQQ05GRyByZWdpc3RlciBzdGlsbCBzZXQgdG8gYWR2ZXJ0aXNlIHRob3NlIG1vZGVz
Pw0KDQpUaGFua3MsDQpIYW1pc2ggTQ0KDQo=

