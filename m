Return-Path: <netdev+bounces-250138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE11D2445B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79C24305351A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F142EDD70;
	Thu, 15 Jan 2026 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QD02b6F3"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EED37E307;
	Thu, 15 Jan 2026 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477371; cv=none; b=VJl6cZCYbJebjs34bib8SeyVp/5o7jtrnItIzisk3Ca4c1cqomjFVXTW72jSvmokmbmfqoK96cS5bFu3VXCGYGDthd5LFYevXa+jgosWLhxi1JwUeo1nsm434o0O7VwH2IJLesnm+A2GG1LxactNLuG/TVCgxCcO+R07/7M8eLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477371; c=relaxed/simple;
	bh=63dl3TNPU5nwdThJj/EBkKixN0LIH7NW8BAMlypNW+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YM2zmB4SDRyEiv7iritD3+6o8xLWf1WNQY61L7P4St80+U+wWCw/8DycZkdi34teaKhakPy9BSg0hqunhEjUPUASmJbz3IS1KKsw3MsAiehswjBPKuvGrNR5Ka1PQARTm2Pb4cOnfweudDV0vYv6vLqfUmCYnLvQKDXsYOMftf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QD02b6F3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60FBgLHS12959073, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768477341; bh=63dl3TNPU5nwdThJj/EBkKixN0LIH7NW8BAMlypNW+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QD02b6F3HVNB9WkRoVclfsLcaQtCsABc/bdOc+pqMvvChpW3W9t5MUiQQiY8LQUVA
	 EkNgb0/5TVG5WLFCdHo93emd5/KuQPM7L1FK1GfS+ivHuBkM6A+mMWiPiqvjZZI/36
	 xC24eDsJM98ryWbUWbD/aPlg2N1vXWfVUf4ksgrIoCDjgAQrUAL7XY+HiTZ4+PczQz
	 Om06AcZDh6jjFjjeA9f/B6BanQG97Uqwjsw7AYQIunHOOlYPfGZfZOaCSfbJwPjBtQ
	 mcTV7obWrCB+xFC4kTbgMGvIE4nrB6pdKvUA0aAmgo26kw4I9xavBYuTX3YZbRWEib
	 An3EvQ9oZBIRg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60FBgLHS12959073
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 19:42:21 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 15 Jan 2026 19:42:20 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5%9]) with mapi id
 15.02.1748.010; Thu, 15 Jan 2026 19:42:20 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: lu lu <insyelu@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        nic_swsd <nic_swsd@realtek.com>, "tiwai@suse.de"
	<tiwai@suse.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: usb: r8152: fix transmit queue timeout
Thread-Topic: [PATCH] net: usb: r8152: fix transmit queue timeout
Thread-Index: AQHchQGLBs/iMEigv0CwXIii7EgMTLVRErBAgADcLoCAASPVoA==
Date: Thu, 15 Jan 2026 11:42:20 +0000
Message-ID: <1b498052994c4ed48de45b5af9a490b6@realtek.com>
References: <20260114025622.24348-1-insyelu@gmail.com>
 <3501a6e902654554b61ab5cd89dcb0dd@realtek.com>
 <CAAPueM4XheTsmb6xd3w5A3zoec-z3ewq=uNpA8tegFbtFWCfaA@mail.gmail.com>
In-Reply-To: <CAAPueM4XheTsmb6xd3w5A3zoec-z3ewq=uNpA8tegFbtFWCfaA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

bHUgbHUgPGluc3llbHVAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAxNSwg
MjAyNiA5OjM3IEFNDQpbLi4uXQ0KPiBUbyByZWR1Y2UgdGhlIHBlcmZvcm1hbmNlIGltcGFjdCBv
biB0aGUgdHhfdGwgdGFza2xldOKAmXMgdHJhbnNtaXQgcGF0aCwNCj4gbmV0aWZfdHJhbnNfdXBk
YXRlKCkgaGFzIGJlZW4gbW92ZWQgZnJvbSB0aGUgbWFpbiB0cmFuc21pdCBwYXRoIGludG8NCj4g
d3JpdGVfYnVsa19jYWxsYmFjayAodGhlIFVTQiB0cmFuc2ZlciBjb21wbGV0aW9uIGNhbGxiYWNr
KS4NCj4gVGhlIG1haW4gY29uc2lkZXJhdGlvbnMgYXJlIGFzIGZvbGxvd3M6DQo+IDEuIFJlZHVj
ZSBmcmVxdWVudCB0YXNrbGV0IG92ZXJoZWFkDQo+IG5ldGlmX3RyYW5zX3VwZGF0ZSgpIGlzIGlu
dm9rZWQgZnJlcXVlbnRseSB1bmRlciBoaWdoLXRocm91Z2hwdXQNCj4gY29uZGl0aW9ucy4gQ2Fs
bGluZyBpdCBkaXJlY3RseSBpbiB0aGUgbWFpbiB0cmFuc21pdCBwYXRoIGNvbnRpbnVvdXNseQ0K
PiBpbnRyb2R1Y2VzIGEgc21hbGwgYnV0IG5vdGljZWFibGUgQ1BVIG92ZXJoZWFkLCBkZWdyYWRp
bmcgdGhlDQo+IHNjaGVkdWxpbmcgZWZmaWNpZW5jeSBvZiB0aGUgdHhfdGwgdGFza2xldC4NCj4g
Mi4gTW92ZSBub24tY3JpdGljYWwgb3BlcmF0aW9ucyBvdXQgb2YgdGhlIGNyaXRpY2FsIHBhdGgN
Cj4gQnkgZGVmZXJyaW5nIG5ldGlmX3RyYW5zX3VwZGF0ZSgpIHRvIHRoZSBVU0IgY2FsbGJhY2sg
dGhyZWFk4oCUYW5kDQo+IGVuc3VyaW5nIGl0IGV4ZWN1dGVzIGFmdGVyIHRhc2tsZXRfc2NoZWR1
bGUoJnRwLT50eF90bCnigJR0aGUgdGltZXN0YW1wDQo+IHVwZGF0ZSBpcyByZW1vdmVkIGZyb20g
dGhlIGNyaXRpY2FsIHRyYW5zbWl0IHNjaGVkdWxpbmcgcGF0aCwgZnVydGhlcg0KPiByZWR1Y2lu
ZyB0aGUgYnVyZGVuIG9uIHR4X3RsLg0KDQpFeGN1c2UgbWUsIEkgZG8gbm90IGZ1bGx5IHVuZGVy
c3RhbmQgdGhlIHJlYXNvbmluZyBhYm92ZS4NCkl0IHNlZW1zIHRoYXQgdGhpcyBjaGFuZ2UgbWVy
ZWx5IHNoaWZ0cyB0aGUgdGltZSAob3IgZWZmb3J0KSBmcm9tIHR4X3RsIHRvIHRoZSBUWCBjb21w
bGV0aW9uIGNhbGxiYWNrLg0KDQpXaGlsZSB0aGUgaW50ZW50aW9uIGlzIHRvIG1ha2UgdHhfdGwg
cnVuIGZhc3RlciwgdGhpcyBhbHNvIGRlbGF5cyB0aGUgY29tcGxldGlvbiBvZiB0aGUgY2FsbGJh
Y2ssDQp3aGljaCBpbiB0dXJuIG1heSBkZWxheSBib3RoIHRoZSBuZXh0IGNhbGxiYWNrIGV4ZWN1
dGlvbiBhbmQgdGhlIG5leHQgc2NoZWR1bGluZyBvZiB0eF90bC4NCg0KRnJvbSB0aGlzIHBlcnNw
ZWN0aXZlLCBpdCBpcyB1bmNsZWFyIHdoYXQgaXMgYWN0dWFsbHkgYmVpbmcgc2F2ZWQuDQoNCkhh
dmUgeW91IG9ic2VydmVkIGEgbWVhc3VyYWJsZSBkaWZmZXJlbmNlIGJhc2VkIG9uIHRlc3Rpbmc/
DQoNCklmIHlvdSB3YW50IHRvIHJlZHVjZSB0aGUgZnJlcXVlbmN5IG9mIGNhbGxpbmcgbmV0aWZf
dHJhbnNfdXBkYXRlKCksDQp5b3UgY291bGQgdHJ5IHNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dp
bmcuIFRoaXMgd2F5LA0KbmV0aWZfdHJhbnNfdXBkYXRlKCkgd291bGQgbm90IGJlIGV4ZWN1dGVk
IG9uIGV2ZXJ5IHRyYW5zbWlzc2lvbi4NCg0KLS0tIGEvZHJpdmVycy9uZXQvdXNiL3I4MTUyLmMN
CisrKyBiL2RyaXZlcnMvbmV0L3VzYi9yODE1Mi5jDQpAQCAtMjQzMiw5ICsyNDMyLDEyIEBAIHN0
YXRpYyBpbnQgcjgxNTJfdHhfYWdnX2ZpbGwoc3RydWN0IHI4MTUyICp0cCwgc3RydWN0IHR4X2Fn
ZyAqYWdnKQ0KDQogICAgICAgIG5ldGlmX3R4X2xvY2sodHAtPm5ldGRldik7DQoNCi0gICAgICAg
aWYgKG5ldGlmX3F1ZXVlX3N0b3BwZWQodHAtPm5ldGRldikgJiYNCi0gICAgICAgICAgIHNrYl9x
dWV1ZV9sZW4oJnRwLT50eF9xdWV1ZSkgPCB0cC0+dHhfcWxlbikNCisgICAgICAgaWYgKG5ldGlm
X3F1ZXVlX3N0b3BwZWQodHAtPm5ldGRldikpIHsNCisgICAgICAgICAgIGlmIChza2JfcXVldWVf
bGVuKCZ0cC0+dHhfcXVldWUpIDwgdHAtPnR4X3FsZW4pDQogICAgICAgICAgICAgICAgbmV0aWZf
d2FrZV9xdWV1ZSh0cC0+bmV0ZGV2KTsNCisgICAgICAgICAgIGVsc2UNCisgICAgICAgICAgICAg
ICBuZXRpZl90cmFuc191cGRhdGUodHAtPm5ldGRldik7DQorICAgICAgIH0NCg0KICAgICAgICBu
ZXRpZl90eF91bmxvY2sodHAtPm5ldGRldik7DQoNCkJlc3QgUmVnYXJkcywNCkhheWVzDQoNCg==

