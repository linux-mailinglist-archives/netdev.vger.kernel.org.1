Return-Path: <netdev+bounces-136835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FC39A32FF
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA92281341
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C5C7DA66;
	Fri, 18 Oct 2024 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xnAu5Yq/"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00450126C07
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729219804; cv=none; b=c+QK/qnEN/KK7uD6iK/5qf4WXZfqy54uCQNeVDXLIm2vtPaHcXa4IiVXuffjJ+DdaK/vwxUYqXyc0S9FnsMWpcoAO78onzIqN4l7voexhedlfwKn9VzyvRceqfPR5EV6nlq7haPWP/3fXHPGrYVpTsnp0oUmzPM5TeMLww1jVkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729219804; c=relaxed/simple;
	bh=pAfnonRQHebo5e9mghmYAi18qXw4bWXMOCZ9zJIhxUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t5MARcMOXPYFfbUBt+W8DJHADT0ReSWCPj8EAG/Gr1wHLBsuoJnlmeiTfRx6PQsOupB7aEnngzLS+InmHNXDTCQrRbyiVy8X0Z3bW8+elVHmO26MpO/t1/TI9bxi1eJ8UD/iNe+Zk3Gqf4PQeP1w4X/mlVrpuYpJTHmwjplCsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=xnAu5Yq/; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1B4302C011D;
	Fri, 18 Oct 2024 15:49:53 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729219793;
	bh=pAfnonRQHebo5e9mghmYAi18qXw4bWXMOCZ9zJIhxUk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=xnAu5Yq/IHOQCVxlWYnh0nKtPOB2vR7gBX4YeEkkXpW2pKhRm522vGjvHwzR4t945
	 m15eFOQHv3jdofeufn3Wlk4q5HHIuLsg5TKbKiqZ/XhXQ3nDlv0xS7PeZtnjQ3Itsa
	 RiiQow0EosHzNm3lKnuJr2ZEq3vjtTsIqgFYr+KLFPt1VdykZweLwAN7nttSmhggTx
	 D8tBpWsuH2UsSpFyp2BjEOdgvElimEbw/cuaSgBSIB/YA0b86ac/2Qn5YJGl6P2r8d
	 6lrQJCRwnjIvdjwan/xQYLgx0SBFvqhTAvwZZGCVP6uwgOwkEHnGUmBnYuASZPlhqC
	 tGgzeo9urO8+Q==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6711ccd00001>; Fri, 18 Oct 2024 15:49:52 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Oct 2024 15:49:52 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Fri, 18 Oct 2024 15:49:52 +1300
From: Paul Davey <Paul.Davey@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "daniel@makrotopia.org" <daniel@makrotopia.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: aquantia: Add mdix config and
 reporting
Thread-Topic: [PATCH net-next] net: phy: aquantia: Add mdix config and
 reporting
Thread-Index: AQHbIDd1vnPqHtWCDUqpqXlBKr+obbKJ/EYAgADIhgCAAAeHgIAAKh8A
Date: Fri, 18 Oct 2024 02:49:52 +0000
Message-ID: <858331af57bd1d9ab478c3ec6f5ecd19dcd205ef.camel@alliedtelesis.co.nz>
References: <20241017015407.256737-1-paul.davey@alliedtelesis.co.nz>
	 <ZxD69GqiPcqOZK2w@makrotopia.org>
	 <4e8d02f84d1ae996f6492f9c53bf90a6cc6ad32e.camel@alliedtelesis.co.nz>
	 <ec453754-3474-4824-b4e3-e26603e2e1d8@lunn.ch>
In-Reply-To: <ec453754-3474-4824-b4e3-e26603e2e1d8@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <732484395BDCD84893D1FC36BFD63E39@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=6711ccd1 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=3pNRdvVr4ggA:10 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=PFUYQPNK4-5iWQNOrAEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gRnJpLCAyMDI0LTEwLTE4IGF0IDAyOjE5ICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
PiBEdWUgdG8gdGhpcyBJIHdvbmRlciB3aGV0aGVyIHRoZSBtZGl4IGNvbmZpZ3VyYXRpb24gc2hv
dWxkIHJlamVjdA0KPiA+IEVUSF9UUF9NRElfQVVUTyBpZiBhdXRvLW5lZ290aWF0aW9uIGlzIGRp
c2FibGVkPw0KPiANCj4gSG93IGRvZXMgTURJWCBhY3R1YWxseSB3b3JrPyBJcyB0aGVyZSBhbnl0
aGluZyBpbiA4MDIuMz8NCj4gDQo+IEZvciAxMEJhc2VULCBvbmUgcGFpciBSeCwgb25lIHBhaXIg
VHgsIGkgZ3Vlc3MgeW91IGNhbiBmaW5kIG91dCBieQ0KPiBqdXN0IGxvb2tpbmcgYXQgdGhlIHNp
Z25hbC4gQnV0IGZvciA0IHBhaXJzPw0KPiANCjgwMi4zIENsYXVzZSA0MC40LjQgQXV0b21hdGlj
IE1ESS9NREktWCBDb25maWd1cmF0aW9uIHNwZWNpZmllcyBzb21lDQphc3BlY3RzIG9mIGhvdyBB
dXRvIE1ESS9NREktWCBjcm9zc292ZXIgZGV0ZWN0aW9uIHdvcmtzIGZvciAxMDAwQkFTRS1UDQoN
CkZvciAxMDAwQkFTRS1UIChhbmQgYWJvdmUpIHdpdGggNCBwYWlycyB0aGUgTURJLVggc3RhdGUg
Y3Jvc3NlcyBvdmVyDQpib3RoIHBhaXJzIEEvQiBhbmQgcGFpcnMgQy9ELiAgVGhvdWdoIHNvbWUg
UEhZcyBoYXZlIHN1cHBvcnQgZm9yDQpkZXRlY3RpbmcgcGFydGlhbCBjcm9zc292ZXIuDQoNClRo
ZSBjcm9zc292ZXIgaXMgcmVxdWlyZWQgZm9yIGF1dG8tbmVnb3RpYXRpb24gdG8gY29tcGxldGUg
c28gdGhlDQpBdXRvbWF0aWMgTURJL01ESS1YIHJlc29sdXRpb24gaGFzIHRvIG9jY3VyIHByaW9y
IHRvIGF1dG8tbmVnb3RpYXRpb24uDQoNCkkgYmVsaWV2ZSB0aGUgZGV0ZWN0aW9uIHdvcmtzIGJ5
IHNlbGVjdGluZyBhIHByb3Bvc2VkIGNyb3Nzb3ZlciBjb25maWcsDQp0aGVuIHdhaXRpbmcgYSBw
ZXJpb2QgdG8gZGV0ZWN0IGVpdGhlciBhdXRvLW5lZ290aWF0aW9uIGZhc3QgbGluaw0KcHVsc2Vz
IG9yIGFuIFJYIGxpbmsgZGV0ZWN0aW9uLiBJZiBpdCBkb2Vzbid0IGZpbmQgb25lIGl0IHVzZXMg
YQ0KcHNldWRvcmFuZG9tIHByb2Nlc3MgKGFuIExGU1IgSSBiZWxpZXZlKSB0byBkZWNpZGUgd2hl
dGhlciBpdCBzaG91bGQNCnN3YXAgdG8gdGhlIG90aGVyIGNyb3Nzb3ZlciBzdGF0ZSBvciByZW1h
aW4gaW4gdGhlIGN1cnJlbnQgb25lLiAgVGhpcw0KaXMgdG8gZW5zdXJlIHR3byBsaW5rIHBhcnRu
ZXJzIHBlcmZvcm1pbmcgdGhpcyBwcm9jZXNzIGRvIG5vdCBnZXQgc3R1Y2sNCmJvdGggdHJ5aW5n
IHRoZSB3cm9uZyBjcm9zc292ZXIgYW5kIHRoZW4gc3dhcHBpbmcgYXQgdGhlIHNhbWUgdGltZSB0
bw0KdGhlIG90aGVyIGNyb3Nzb3Zlci4gIEZyb20gdGhlIHN0YXRlIG1hY2hpbmUgZGlhZ3JhbXMg
aXQgYXBwZWFycyB0aGUNCmluaXRpYWwgY3Jvc3NvdmVyIGNvbmZpZyBpcyBNREkuDQoNCkFzIGF1
dG8tbmVnb3RpYXRpb24gaXMgcmVxdWlyZWQgZm9yIDEwMDBCQVNFLVQgKGFuZCBoaWdoZXIgc3Bl
ZWQNCnR3aXN0ZWQgcGFpciBtb2RlcykgdGhlIHF1ZXN0aW9uIG9mIHdoZXRoZXIgQXV0byBNREkv
TURJLVggZGV0ZWN0aW9uDQpvY2N1cnMgd2hlbiBhdXRvLW5lZ290aWF0aW9uIGlzIHR1cm5lZCBv
ZmYgaXMgb25seSByZWFsbHkgcmVsZXZhbnQgZm9yDQoxMEJBU0UtVCBhbmQgMTAwQkFTRS1UIGJl
aW5nIGZvcmNlZC4NCg0KV2hlbiBJIHdhcyB3b25kZXJpbmcgaWYgbWRpeF9jdHJsIGJlaW5nIHNl
dCB0byBFVEhfVFBfTURJX0FVVE8gc2hvdWxkDQpiZSByZWplY3RlZCBpZiBhdXRvLW5lZ290aWF0
aW9uIGlzIGRpc2FibGVkIEkgbWVhbnQgZm9yIHRoaXMgc3BlY2lmaWMNClBIWSBkcml2ZXIgYXMg
aXQgZGVmaW5pdGVseSBkb2VzIG5vdCBhcHBlYXIgdG8gcGVyZm9ybSB0aGUgQXV0bw0KTURJL01E
SS1YIHJlc29sdXRpb24gc28gaWYgdGhlIHdpcmluZy9jYWJsaW5nIGJldHdlZW4gYW5kL29yIGNv
bmZpZyBvbg0KdGhlIGxpbmsgcGFydG5lciBkb2VzIG5vdCBtYXRjaCB0aGUgZGVmYXVsdCAoTURJ
IEkgdGhpbmsgZm9yIHRoZSBBUVIpDQp0aGVuIHRoZSBsaW5rIHdpbGwgbm90IGVzdGFibGlzaC4N
Cg0KVGhhbmtzLA0KUGF1bA0K

