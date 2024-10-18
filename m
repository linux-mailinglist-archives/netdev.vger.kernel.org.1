Return-Path: <netdev+bounces-136795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1309A3210
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDEE1C22E05
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191385478E;
	Fri, 18 Oct 2024 01:29:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail03.siengine.com (mail03.siengine.com [43.240.192.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675236BFCA
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.240.192.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214946; cv=none; b=WZ5FQ+Aa5UNaOOC2i4g7ndwaKTUX3CiNZGP6fuL8axeMHXokq54PqkQpLmgNiSqm4NgofzKeFjqp5uaYW8cFrDVDwqInMePUVKoEtzukbIhIOmiOZR72W01mkvwx/5drluwmZqeApbFU0ylD7RhLjH0KphKuaVpX9YwIeDeAU+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214946; c=relaxed/simple;
	bh=6egk/wFq6egniZ2yGI8GeemNFFrUmTTATLYt4oscR84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VMmTwvfZbx3QCw27YXMOKX2/6v/Oq+j3Z2xsyurKQ/N8oTm34DgVrvj18LCKm1AM+6XRWSqtFZWK8qHlaSX1fDQqQF1MsRSft6TmAZLQLpfvdWiB25rjaYy1HcIMFrUzq6F1S88Y8hdyaBEUvi0oaWeCdV/2nLGzh8lnUEa2xws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siengine.com; spf=pass smtp.mailfrom=siengine.com; arc=none smtp.client-ip=43.240.192.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siengine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siengine.com
Received: from mail03.siengine.com (localhost [127.0.0.2] (may be forged))
	by mail03.siengine.com with ESMTP id 49I1H8vU006121
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 09:17:08 +0800 (+08)
	(envelope-from hailong.fan@siengine.com)
Received: from dsgsiengine01.siengine.com ([10.8.1.61])
	by mail03.siengine.com with ESMTPS id 49I1FVqT006042
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 18 Oct 2024 09:15:31 +0800 (+08)
	(envelope-from hailong.fan@siengine.com)
Received: from SEEXMB03-2019.siengine.com (SEEXMB03-2019.siengine.com [10.8.1.33])
	by dsgsiengine01.siengine.com (SkyGuard) with ESMTPS id 4XV6Ft0KLLz7ZMv9;
	Fri, 18 Oct 2024 09:15:30 +0800 (CST)
Received: from SEEXMB03-2019.siengine.com (10.8.1.33) by
 SEEXMB03-2019.siengine.com (10.8.1.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Fri, 18 Oct 2024 09:15:30 +0800
Received: from SEEXMB03-2019.siengine.com ([fe80::23e0:1bbb:3ec9:73fe]) by
 SEEXMB03-2019.siengine.com ([fe80::23e0:1bbb:3ec9:73fe%16]) with mapi id
 15.02.1544.011; Fri, 18 Oct 2024 09:15:30 +0800
From: =?gb2312?B?RmFuIEhhaWxvbmcvt7a6o8H6?= <hailong.fan@siengine.com>
To: Simon Horman <horms@kernel.org>, "2694439648@qq.com" <2694439648@qq.com>
CC: "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBuZXQ6IHN0bW1hYzogZW5hYmxlIE1BQyBhZnRlciBN?=
 =?gb2312?Q?TL_configuring?=
Thread-Topic: [PATCH] net: stmmac: enable MAC after MTL configuring
Thread-Index: AQHbHfwmUFDRUPAmP0Op3UD8MH3slLKKOd6AgAF8NlA=
Date: Fri, 18 Oct 2024 01:15:30 +0000
Message-ID: <bd7a1be5cec348dab22f7d0c2552967d@siengine.com>
References: <tencent_6BF819F333D995B4D3932826194B9B671207@qq.com>
 <20241017101857.GE1697@kernel.org>
In-Reply-To: <20241017101857.GE1697@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DKIM-Results: [10.8.1.61]; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:mail03.siengine.com 49I1H8vU006121

SGkNCg0KRm9yIGV4YW1wbGUsIEVUSCBpcyBkaXJlY3RseSBjb25uZWN0ZWQgdG8gdGhlIHN3aXRj
aCwgd2hpY2ggbmV2ZXIgcG93ZXIgZG93biBhbmQgc2VuZHMgYnJvYWRjYXN0IHBhY2tldHMgYXQg
cmVndWxhciBpbnRlcnZhbHMuIA0KRHVyaW5nIHRoZSBwcm9jZXNzIG9mIG9wZW5pbmcgRVRILCBk
YXRhIG1heSBmbG93IGludG8gdGhlIE1UTCBGSUZPLCBvbmNlIE1BQyBSWCBpcyBlbmFibGVkLg0K
YW5kIHRoZW4sIE1UTCB3aWxsIGJlIHNldCwgc3VjaCBhcyBGSUZPIHNpemUuIA0KT25jZSBlbmFi
bGUgRE1BLCBUaGVyZSBpcyBhIGNlcnRhaW4gcHJvYmFiaWxpdHkgdGhhdCBETUEgd2lsbCByZWFk
IGluY29ycmVjdCBkYXRhIGZyb20gTVRMIEZJRk8sIGNhdXNpbmcgRE1BIHRvIGhhbmcgdXAuIA0K
QnkgcmVhZCBETUFfRGVidWdfU3RhdHVzLCB5b3UgY2FuIGJlIG9ic2VydmVkIHRoYXQgdGhlIFJQ
UyByZW1haW5zIGF0IGEgY2VydGFpbiB2YWx1ZSBmb3JldmVyLiANClRoZSBjb3JyZWN0IHByb2Nl
c3Mgc2hvdWxkIGJlIHRvIGNvbmZpZ3VyZSBNQUMvTVRML0RNQSBiZWZvcmUgZW5hYmxpbmcgRE1B
L01BQw0KDQpzdG1tYWNfc3RhcnRfcngvdHggYW5kIHN0bW1hY19zdG9wX3J4L3R4IHNob3VsZCBv
bmx5IGhhbmRsZSB0aGUgRE1BIG1vZHVsZSB0byBhdm9pZCBjb25mdXNpb24NCg0KDQoNCi0tLS0t
08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+IA0K
t6LLzcqxvOQ6IDIwMjTE6jEw1MIxN8jVIDE4OjE5DQrK1bz+yMs6IDI2OTQ0Mzk2NDhAcXEuY29t
DQqzrcvNOiBhbGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tOyBqb2FicmV1QHN5bm9wc3lzLmNv
bTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwu
b3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgbWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbTsgbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgbGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNv
bTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBGYW4gSGFpbG9uZy+3trqjwfogPGhhaWxvbmcuZmFuQHNpZW5naW5lLmNv
bT4NCtb3zOI6IFJlOiBbUEFUQ0hdIG5ldDogc3RtbWFjOiBlbmFibGUgTUFDIGFmdGVyIE1UTCBj
b25maWd1cmluZw0KDQpPbiBNb24sIE9jdCAxNCwgMjAyNCBhdCAwMTo0NDowM1BNICswODAwLCAy
Njk0NDM5NjQ4QHFxLmNvbSB3cm90ZToNCj4gRnJvbTogImhhaWxvbmcuZmFuIiA8aGFpbG9uZy5m
YW5Ac2llbmdpbmUuY29tPg0KPiANCj4gRE1BIG1heWJlIGJsb2NrIHdoaWxlIEVUSCBpcyBvcGVu
aW5nLA0KPiBBZGp1c3QgdGhlIGVuYWJsZSBzZXF1ZW5jZSwgcHV0IHRoZSBNQUMgZW5hYmxlIGxh
c3QNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGhhaWxvbmcuZmFuIDxoYWlsb25nLmZhbkBzaWVuZ2lu
ZS5jb20+DQoNCkhpLA0KDQpJIHRoaW5rIHRoYXQgc29tZSBtb3JlIGV4cGxhbmF0aW9uIG9mIHRo
aXMgaXMgcmVxdWlyZWQuDQpJbmNsdWRpbmcgaWYgYSBwcm9ibGVtIGhhcyBiZWVuIG9ic2VydmVk
LCBhbmQgaWYgc28gdW5kZXIgd2hhdCBjb25kaXRpb25zLiBPciwgaWYgbm90LCBzb21lIGJhY2tn
cm91bmQgaW5mb3JtYXRpb24gb24gd2h5IHRoaXMgYWRqdXN0bWVudCBpcyBjb3JyZWN0Lg0KDQpJ
IGFsc28gdGhpbmsgc29tZSBleHBsYW5hdGlvbiBpcyByZXF1aXJlZCBvZiB0aGUgcmVsYXRpb25z
aGlwIGJldHdlZW4gdGhlIGNoYW5nZXMgdGhpcyBwYXRjaCBtYWtlcyB0byBzZXR1cCwgYW5kIHRo
ZSBjaGFuZ2VzIGl0IG1ha2VzIHRvIHN0YXJ0IGFuZCBzdG9wLg0KDQouLi4NCg==

