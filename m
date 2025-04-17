Return-Path: <netdev+bounces-183561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E554A910D3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 02:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700A95A3686
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4446145348;
	Thu, 17 Apr 2025 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="b39YbBfa"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D713AD3F
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 00:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744850208; cv=none; b=B7+AzBkXO32e9wRRMQiQnuvY2XWC6xWGJVGI5mAdLPXD1thAx57chG8lRXdYbMcjj4RnT9/wzJsVeQh9IFf9jk2mpOuGGHG7CgyUtQJvr4D2UL8OcLuWhzEGRSIyCwEp6we7TMPeSgTAFGk0RvR7oc7vMo8GlEdmqwD1S71MqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744850208; c=relaxed/simple;
	bh=lrhUAO2ZO0O7cddUmG8H+oajQEEq4UOcN2sxu6227eY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NvaSPBGQegiohGFOw+LhRRZ8PYkLwma6A1EkyeK6uKoMwYynbB/zcTNZgDO1bwX9dfwDJKYJeh/t6r8y2Q7E7jxuHBHiOKarhbqekL8ixtyUTR09otdrnsTDgUjzgOneDUwxbh0AW3g9lzA3dBL1XE3z8W7CHw1DwjZzfvuxViY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=b39YbBfa; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D7E982C03DC;
	Thu, 17 Apr 2025 12:36:43 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1744850203;
	bh=lrhUAO2ZO0O7cddUmG8H+oajQEEq4UOcN2sxu6227eY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=b39YbBfaqhM5YByQILxiMMtuTHBfeE5fYrQGsrpdipJ5cRIbaOY0OSNM5DBAZT4Bg
	 /yiXTSNDTEw7gGD8XpMuiv5UYll1d6D1gc1jSozcYls2QeJeC1CYhhzfI6WEBRnhEd
	 krXDGYlW9giRlWfJCx2KL37PGck0r8okEu9D1Dr7iHjjnPZ9s6JzbVDtvbgZNwmLCt
	 h0tZltUTlI5mus3RbBVsfJsP50R6Vah4YjpWg8fGNPmWicXUQk06dCF/jNgHffDI0o
	 wmEncIbjj14dtU5vIvdtXpFYLp532zc45CmUX6SMBwo1QAAhfB2z82xZZw+f+g13n5
	 O0kPomOqPMvXg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68004d1b0001>; Thu, 17 Apr 2025 12:36:43 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 12:36:43 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Thu, 17 Apr 2025 12:36:43 +1200
From: Rutger van Kruiningen <Rutger.vanKruiningen@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "horms@kernel.org" <horms@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v0] net: ethtool: Only set supplied eee ethtool settings
Thread-Topic: [PATCH v0] net: ethtool: Only set supplied eee ethtool settings
Thread-Index: AQHbrxyse1JWtHWT2USdHgkWBWpOW7OmGJ6AgAAhk4A=
Date: Thu, 17 Apr 2025 00:36:43 +0000
Message-ID: <19ffa505b6c4341e6c66370fb76f6447b820aacd.camel@alliedtelesis.co.nz>
References: <20250416221230.1724319-1-rutger.vankruiningen@alliedtelesis.co.nz>
	 <6694f2c8-cfc8-41ed-9ceb-3e0b10aec6b9@lunn.ch>
In-Reply-To: <6694f2c8-cfc8-41ed-9ceb-3e0b10aec6b9@lunn.ch>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DB9F8F088F3284C912CDE8C7AEAFF97@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=W+WbVgWk c=1 sm=1 tr=0 ts=68004d1b a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=-DMz-g34_tEA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=qZ8f-K6C4Mv00eEDbOsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gVGh1LCAyMDI1LTA0LTE3IGF0IDAwOjM2ICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
T24gVGh1LCBBcHIgMTcsIDIwMjUgYXQgMTA6MTI6MzBBTSArMTIwMCwgUnV0Z2VyIHZhbiBLcnVp
bmluZ2VuDQo+IHdyb3RlOg0KPiA+IE9yaWdpbmFsbHkgYWxsIGV0aHRvb2wgZWVlIHNldHRpbmcg
dXBkYXRlcyB3ZXJlIGF0dGVtcHRlZCBldmVuIGlmDQo+ID4gdGhlDQo+ID4gc2V0dGluZ3Mgd2Vy
ZSBub3Qgc3VwcGxpZWQsIGNhdXNpbmcgYSBudWxsIHBvaW50ZXIgY3Jhc2guDQo+ID4gDQo+ID4g
QWRkIGNoZWNrIGZvciBlYWNoIGVlZSBzZXR0aW5nIGFuZCBvbmx5IHVwZGF0ZSBpZiBpdCBleGlz
dHMuDQo+IA0KPiBJIHNlZSB3aGF0IHlvdSBtZWFuLCBidXQgaSdtIHNvbWV3aGF0IHN1cnByaXNl
ZCB3ZSBoYXZlIG5vdCBzZWVuIHRoaXMNCj4gY3Jhc2guIERvIHlvdSBoYXZlIGEgc2ltcGxlIHJl
cHJvZHVjZXI/IEkganVzdCBkaWQNCj4gDQo+IGV0aHRvb2wgLS1kZWJ1ZyAyNTUgLS1zZXQtZWVl
IGV0aDAgZWVlIG9uDQo+IA0KPiBhbmQgaXQgZGlkIG5vdCBjcmFzaCwgZGVzcGl0ZToNCj4gDQo+
IHNlbmRpbmcgZ2VuZXRsaW5rIHBhY2tldCAoNDQgYnl0ZXMpOg0KPiDCoMKgwqAgbXNnIGxlbmd0
aCA0NCBldGhvb2wgRVRIVE9PTF9NU0dfRUVFX1NFVA0KPiDCoMKgwqAgRVRIVE9PTF9NU0dfRUVF
X1NFVA0KPiDCoMKgwqDCoMKgwqDCoCBFVEhUT09MX0FfRUVFX0hFQURFUg0KPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEVUSFRPT0xfQV9IRUFERVJfREVWX05BTUUgPSAiZXRoMCINCj4gwqDCoMKg
wqDCoMKgwqAgRVRIVE9PTF9BX0VFRV9FTkFCTEVEID0gb24NCj4gDQo+IFNvIGl0IG9ubHkgcHJv
dmlkZWQgRVRIVE9PTF9BX0VFRV9FTkFCTEVEIGFuZCBub25lIG9mIHRoZSBvdGhlcnMuDQo+IA0K
PiDCoMKgwqDCoMKgwqDCoMKgQW5kcmV3DQpTb3JyeSBpdCBzZWVtcyB0aGF0IHRoZXJlIGFjdHVh
bGx5IGlzbid0IGEgcHJvYmxlbSBoZXJlLiBJIHRob3VnaHQgdGhlDQpidWcgSSBoYWQgd2FzIHJl
bGF0ZWQgdG8gdGhpcyBidXTCoGl0IG11c3QgaGF2ZSBiZWVuIGZvciBzb21ldGhpbmcgZWxzZQ0K
YW5kIHdhcyBmaXhlZCBhdCB0aGUgc2FtZSB0aW1lIG9mIGFkZGluZyB0aGlzIGNvZGUuDQoNCllv
dSBjYW4gZGlzcmVndWFyZCB0aGlzIHBhdGNoLg0KDQpUaGFua3MsIFJ1dGdlci4NCg==

