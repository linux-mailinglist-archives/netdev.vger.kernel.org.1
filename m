Return-Path: <netdev+bounces-133942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D699787C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 00:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8571D1C226E8
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 22:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5A1E32C8;
	Wed,  9 Oct 2024 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="yRNEL+WA"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B319923C
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728512725; cv=none; b=m8VVQ4riSzELj0ke+3xWbMBIXNNbnOvWDekQsz74nTbZnwcU6gCvMcGVsaIJfUSET0ZQHi/lz1H2O4coBK72vp/nZ5RKj3L/BYUTMexpKTNN0BFqhaozvkaIH55sEwxrAircZTVv8XH4yBdh0kEtR6K0YB8ThrD5VIv1yeFS3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728512725; c=relaxed/simple;
	bh=+z8kJc3NOSE2F4JkCVtI19Gp8PZl3CNqofrsETOuxNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CigJrPIGZraDRtqBOl0WsXuUNelBIPU8qxyZQ17uzKV53SpIuLJUAcOKjk/McwSh0SYNkh8l88OKraMHtmkcXbtQxrl8V2+ZFmiq82wNWdeJiO5/jYA41XZOXGiUjK5sNc+fh5nS92d/1R8ydltIsI0VzjXI56PAu1mTHBZBie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=yRNEL+WA; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 32F682C012A;
	Thu, 10 Oct 2024 11:25:20 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728512720;
	bh=+z8kJc3NOSE2F4JkCVtI19Gp8PZl3CNqofrsETOuxNQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:Reply-To:From;
	b=yRNEL+WARSUOXuMiLnpg1wCWPZJHWc0r5XzWauEWUwyCnkcAWab4GlN/wnQVn+apm
	 jl0zHdWt1MfjPa3B93+EZhDtcxZ0qBTsG+lGqhPq3cBHHZsKjEC6ZglKTzAE0wsPrM
	 dUR08oLZtA/Mt1QQQIjo+q/xiCQpGqJ3CeOuf5eAZPVKgSQQKN1eHKKY91RsGEJ48y
	 6B2WCEpRRKxqNRgIrxQVufQYR7Lb1zshGyeM1cClp/xwchQ7miTQvQoEqu7z+UiqBG
	 nb/F+2FeaOxUgWwrLj7DQn3Ym+lb8VISg0ZjRy4GTukuzz/YGfdZj4RPFErpHawwq7
	 4h4HIAXtVf+5Q==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670702d00001>; Thu, 10 Oct 2024 11:25:20 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 11:25:19 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Thu, 10 Oct 2024 11:25:19 +1300
From: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v0] net: phy: aquantia: poll status register
Thread-Topic: [PATCH net-next v0] net: phy: aquantia: poll status register
Thread-Index: AQHbGDe0125GDRy5fU+t3W0xmCSaErJ8ixIAgAGez4A=
Date: Wed, 9 Oct 2024 22:25:19 +0000
Message-ID: <aa887fc2d0477418c9511a4698225a742b204086.camel@alliedtelesis.co.nz>
References: <20241006213536.3153121-1-aryan.srivastava@alliedtelesis.co.nz>
	 <5f4a8026-0057-48dd-b51e-6888d79c3d76@lunn.ch>
In-Reply-To: <5f4a8026-0057-48dd-b51e-6888d79c3d76@lunn.ch>
Reply-To: "5f4a8026-0057-48dd-b51e-6888d79c3d76@lunn.ch"
	<5f4a8026-0057-48dd-b51e-6888d79c3d76@lunn.ch>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <92A449C553707C45AECD710923EEA037@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670702d0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=w1vUsAckAk8A:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=42aPYgUVFb3LGEXNNI8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gVHVlLCAyMDI0LTEwLTA4IGF0IDIzOjQwICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToKPiBP
biBNb24sIE9jdCAwNywgMjAyNCBhdCAxMDozNTozNkFNICsxMzAwLCBBcnlhbiBTcml2YXN0YXZh
IHdyb3RlOgo+ID4gVGhlIHN5c3RlbSBpbnRlcmZhY2UgY29ubmVjdGlvbiBzdGF0dXMgcmVnaXN0
ZXIgaXMgbm90IGltbWVkaWF0ZWx5Cj4gPiBjb3JyZWN0IHVwb24gbGluZSBzaWRlIGxpbmsgdXAu
IFRoaXMgcmVzdWx0cyBpbiB0aGUgc3RhdHVzIGJlaW5nCj4gPiByZWFkIGFzCj4gPiBPRkYgYW5k
IHRoZW4gdHJhbnNpdGlvbmluZyB0byB0aGUgY29ycmVjdCBob3N0IHNpZGUgbGluayBtb2RlIHdp
dGgKPiA+IGEKPiA+IHNob3J0IGRlbGF5LiBUaGlzIHJlc3VsdHMgaW4gdGhlIHBoeWxpbmsgZnJh
bWV3b3JrIHBhc3NpbmcgdGhlIE9GRgo+ID4gc3RhdHVzIGRvd24gdG8gYWxsIE1BQyBjb25maWcg
ZHJpdmVycywgcmVzdWx0aW5nIGluIHRoZSBob3N0IHNpZGUKPiA+IGxpbmsKPiA+IGJlaW5nIG1p
c2NvbmZpZ3VyZWQsIHdoaWNoIGluIHR1cm4gY2FuIGxlYWQgdG8gbGluayBmbGFwcGluZyBvcgo+
ID4gY29tcGxldGUKPiA+IHBhY2tldCBsb3NzIGluIHNvbWUgY2FzZXMuCj4gPiAKPiA+IE1pdGln
YXRlIHRoaXMgYnkgcGVyaW9kaWNhbGx5IHBvbGxpbmcgdGhlIHJlZ2lzdGVyIHVudGlsIGl0IG5v
dAo+ID4gc2hvd2luZwo+ID4gdGhlIE9GRiBzdGF0ZS4gVGhpcyB3aWxsIGJlIGRvbmUgZXZlcnkg
MW1zIGZvciAxMG1zLCB1c2luZyB0aGUgc2FtZQo+ID4gcG9sbC90aW1lb3V0IGFzIHRoZSBwcm9j
ZXNzb3IgaW50ZW5zaXZlIG9wZXJhdGlvbiByZWFkcy4KPiAKPiBEb2VzIHRoZSBkYXRhc2hlZXQg
c2F5IGFueXRoaW5nIGFib3V0IHdoZW4gTURJT19QSFlYU19WRU5EX0lGX1NUQVRVUwo+IGlzIHZh
bGlkPwo+IApUaGUgZGF0YXNoZWV0IGlzIHF1aXRlIGJyaWVmIGFib3V0IHRoZSByZWdpc3RlcnMu
IFRoZXJlIGlzIGJhc2ljCmRlc2NyaXB0aW9uLCBidXQgbm90IG11Y2ggdG93YXJkcyBhbnkgbnVh
bmNlcyB0aGV5IG1pZ2h0IGhhdmUsCnVuZm9ydHVuYXRlbHkuCj4gPiDCoCNkZWZpbmUgTURJT19Q
SFlYU19WRU5EX0lGX1NUQVRVU19UWVBFX1hBVUnCoMKgwqDCoDQKPiA+IMKgI2RlZmluZSBNRElP
X1BIWVhTX1ZFTkRfSUZfU1RBVFVTX1RZUEVfU0dNSUnCoMKgwqA2Cj4gPiDCoCNkZWZpbmUgTURJ
T19QSFlYU19WRU5EX0lGX1NUQVRVU19UWVBFX1JYQVVJwqDCoMKgNwo+ID4gKyNkZWZpbmUgTURJ
T19QSFlYU19WRU5EX0lGX1NUQVRVU19UWVBFX09GRsKgwqDCoMKgwqA5Cj4gPiDCoCNkZWZpbmUg
TURJT19QSFlYU19WRU5EX0lGX1NUQVRVU19UWVBFX09DU0dNSUnCoDEwCj4gPiDCoAo+ID4gwqAj
ZGVmaW5lIE1ESU9fQU5fVkVORF9QUk9WwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAweGM0MDAKPiA+IEBAIC0zNDIsOSArMzQzLDE4IEBAIHN0YXRpYyBpbnQgYXFy
MTA3X3JlYWRfc3RhdHVzKHN0cnVjdAo+ID4gcGh5X2RldmljZSAqcGh5ZGV2KQo+ID4gwqDCoMKg
wqDCoMKgwqDCoGlmICghcGh5ZGV2LT5saW5rIHx8IHBoeWRldi0+YXV0b25lZyA9PSBBVVRPTkVH
X0RJU0FCTEUpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+
ID4gwqAKPiA+IC3CoMKgwqDCoMKgwqDCoHZhbCA9IHBoeV9yZWFkX21tZChwaHlkZXYsIE1ESU9f
TU1EX1BIWVhTLAo+ID4gTURJT19QSFlYU19WRU5EX0lGX1NUQVRVUyk7Cj4gPiAtwqDCoMKgwqDC
oMKgwqBpZiAodmFsIDwgMCkKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gdmFsOwo+ID4gK8KgwqDCoMKgwqDCoMKgLyoqCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBUaGUg
c3RhdHVzIHJlZ2lzdGVyIGlzIG5vdCBpbW1lZGlhdGVseSBjb3JyZWN0IG9uIGxpbmUKPiA+IHNp
ZGUgbGluayB1cC4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFBvbGwgcGVyaW9kaWNhbGx5IHVudGls
IGl0IHJlZmxlY3RzIHRoZSBjb3JyZWN0IE9OCj4gPiBzdGF0ZS4KPiA+ICvCoMKgwqDCoMKgwqDC
oCAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gcGh5X3JlYWRfbW1kX3BvbGxfdGltZW91dChw
aHlkZXYsIE1ESU9fTU1EX1BIWVhTLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1ESU9fUEhZ
WFNfVkVORF9JRl9TVEFUVVMsCj4gPiB2YWwsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKEZJ
RUxEX0dFVChNRElPX1BIWVhTX1ZFTkRfCj4gPiBJRl9TVEFUVVNfVFlQRV9NQVNLLCB2YWwpICE9
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTURJT19QSFlYU19WRU5EX0lGX1NUQVRVU19UCj4g
PiBZUEVfT0ZGKSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBBUVIxMDdfT1BfSU5fUFJPR19T
TEVFUCwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBBUVIxMDdfT1BfSU5fUFJPR19USU1FT1VU
LAo+ID4gZmFsc2UpOwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+IAo+IEkgZG9uJ3Qga25vdyBpZiByZXR1
cm5pbmcgRVRJTUVET1VUIGlzIHRoZSBjb3JyZWN0IHRoaW5nIHRvIGRvCj4gaGVyZS4gSXQgbWln
aHQgYmUgYmV0dGVyIHRvIHNldCBwaHlkZXYtPmxpbmsgdG8gZmFsc2UsIHNpbmNlIHRoZXJlIGlz
Cj4gbm8gZW5kIHRvIGVuZCBsaW5rIHlldC4KWWVzIEkgYWdyZWUsIHdpbGwgY2hhbmdlIHRoaXMg
dG8gdXNlICd2YWwnIHJlZ2FyZGxlc3Mgb2YgdGhlIHJldHVybiwKYW5kIGxldCB0aGUgc3dpdGNo
L2Nhc2UgZGVhbCB3aXRoIHRoZSBPRkYgc3RhdHVzIGFzIHJlcXVpcmVkLgo+IAo+IMKgwqDCoMKg
wqDCoMKgwqBBbmRyZXcKQ2hlZXJzLApBcnlhbgoK

