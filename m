Return-Path: <netdev+bounces-137244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821AC9A51F5
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 03:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D291C2132E
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 01:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBD1747F;
	Sun, 20 Oct 2024 01:47:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail03.siengine.com (mail03.siengine.com [43.240.192.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329DA7464
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.240.192.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729388854; cv=none; b=L8N3p26J+BH/cXei4ItRSNOS5foU48+SrbOEtYD/j1VXjJBJ6KW/5tw26/e6Zsi00u5Z2bO7hZ1OKeEakVg2qXeAZ5YEH3C2AIG1iD8r2X9bpQzPbjouQ+88QMSw175STW6tPKk9vQPzqcmV1biZPyHpFIXM25N06klldAH3j7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729388854; c=relaxed/simple;
	bh=BujBYmnRAJp3XmojequG3tFaoSP+SIJxRFdXh3/k5SU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NIHY2GT1qyTlyaQF8nPyvhJOMAHluYPl8ZQSQruJ9RceckjOD3SC2amOuV1xf+lGYzpXuvqAijqtBqMSuLALlDCyM5ACZ/JRs/Zy12Ont9Mo8CDxBPwoMQ4SW0YzFpLxWoRkxrcbd+brII0bxTixYxAhjbzaWbT4lyDxYlP4TWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siengine.com; spf=pass smtp.mailfrom=siengine.com; arc=none smtp.client-ip=43.240.192.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siengine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siengine.com
Received: from dsgsiengine01.siengine.com ([10.8.1.61])
	by mail03.siengine.com with ESMTPS id 49K1jhgY057326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 20 Oct 2024 09:45:43 +0800 (+08)
	(envelope-from hailong.fan@siengine.com)
Received: from SEEXMB03-2019.siengine.com (SEEXMB03-2019.siengine.com [10.8.1.33])
	by dsgsiengine01.siengine.com (SkyGuard) with ESMTPS id 4XWLqp1QtLz7ZMSJ;
	Sun, 20 Oct 2024 09:45:42 +0800 (CST)
Received: from SEEXMB05-2019.siengine.com (10.8.1.153) by
 SEEXMB03-2019.siengine.com (10.8.1.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Sun, 20 Oct 2024 09:45:42 +0800
Received: from SEEXMB03-2019.siengine.com (10.8.1.33) by
 SEEXMB05-2019.siengine.com (10.8.1.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.9; Sun, 20 Oct 2024 09:45:41 +0800
Received: from SEEXMB03-2019.siengine.com ([fe80::23e0:1bbb:3ec9:73fe]) by
 SEEXMB03-2019.siengine.com ([fe80::23e0:1bbb:3ec9:73fe%16]) with mapi id
 15.02.1544.011; Sun, 20 Oct 2024 09:45:41 +0800
From: =?utf-8?B?RmFuIEhhaWxvbmcv6IyD5rW36b6Z?= <hailong.fan@siengine.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Simon Horman <horms@kernel.org>, "2694439648@qq.com" <2694439648@qq.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
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
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gbmV0OiBzdG1tYWM6IGVuYWJsZSBN?=
 =?utf-8?Q?AC_after_MTL_configuring?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG5ldDogc3RtbWFjOiBlbmFibGUgTUFDIGFmdGVy?=
 =?utf-8?Q?_MTL_configuring?=
Thread-Index: AQHbHfwmUFDRUPAmP0Op3UD8MH3slLKKOd6AgAF8NlCAAJYugIACmsmw
Date: Sun, 20 Oct 2024 01:45:41 +0000
Message-ID: <daf687938ae1413bbc556134b47d0629@siengine.com>
References: <tencent_6BF819F333D995B4D3932826194B9B671207@qq.com>
 <20241017101857.GE1697@kernel.org>
 <bd7a1be5cec348dab22f7d0c2552967d@siengine.com>
 <9a11c47e-0cd6-4741-a25b-68538763110a@lunn.ch>
In-Reply-To: <9a11c47e-0cd6-4741-a25b-68538763110a@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
Content-Type: multipart/mixed;
	boundary="_002_daf687938ae1413bbc556134b47d0629sienginecom_"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DKIM-Results: [10.8.1.61]; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:mail03.siengine.com 49K1jhgY057326

--_002_daf687938ae1413bbc556134b47d0629sienginecom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgDQoNClBsZWFzZSBmaW5kIG5ldyBwYXRjaCBpbiBhdHRhY2htZW50cywgdGhhbmtzLg0KDQoN
Ci0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogQW5kcmV3IEx1bm4gPGFuZHJld0Bs
dW5uLmNoPiANCuWPkemAgeaXtumXtDogMjAyNOW5tDEw5pyIMTnml6UgMTo1Nw0K5pS25Lu25Lq6
OiBGYW4gSGFpbG9uZy/ojIPmtbfpvpkgPGhhaWxvbmcuZmFuQHNpZW5naW5lLmNvbT4NCuaKhOmA
gTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJuZWwub3JnPjsgMjY5NDQzOTY0OEBxcS5jb207IGFs
ZXhhbmRyZS50b3JndWVAZm9zcy5zdC5jb207IGpvYWJyZXVAc3lub3BzeXMuY29tOyBkYXZlbUBk
YXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVu
aUByZWRoYXQuY29tOyBtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tOyBuZXRkZXZAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tOyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCuS4u+mimDogUmU6IOWbnuWkjTogW1BBVENIXSBuZXQ6IHN0bW1hYzogZW5hYmxlIE1BQyBh
ZnRlciBNVEwgY29uZmlndXJpbmcNCg0KT24gRnJpLCBPY3QgMTgsIDIwMjQgYXQgMDE6MTU6MzBB
TSArMDAwMCwgRmFuIEhhaWxvbmcv6IyD5rW36b6ZIHdyb3RlOg0KPiBIaQ0KPiANCj4gRm9yIGV4
YW1wbGUsIEVUSCBpcyBkaXJlY3RseSBjb25uZWN0ZWQgdG8gdGhlIHN3aXRjaCwgd2hpY2ggbmV2
ZXIgcG93ZXIgZG93biBhbmQgc2VuZHMgYnJvYWRjYXN0IHBhY2tldHMgYXQgcmVndWxhciBpbnRl
cnZhbHMuIA0KPiBEdXJpbmcgdGhlIHByb2Nlc3Mgb2Ygb3BlbmluZyBFVEgsIGRhdGEgbWF5IGZs
b3cgaW50byB0aGUgTVRMIEZJRk8sIG9uY2UgTUFDIFJYIGlzIGVuYWJsZWQuDQo+IGFuZCB0aGVu
LCBNVEwgd2lsbCBiZSBzZXQsIHN1Y2ggYXMgRklGTyBzaXplLiANCj4gT25jZSBlbmFibGUgRE1B
LCBUaGVyZSBpcyBhIGNlcnRhaW4gcHJvYmFiaWxpdHkgdGhhdCBETUEgd2lsbCByZWFkIGluY29y
cmVjdCBkYXRhIGZyb20gTVRMIEZJRk8sIGNhdXNpbmcgRE1BIHRvIGhhbmcgdXAuIA0KPiBCeSBy
ZWFkIERNQV9EZWJ1Z19TdGF0dXMsIHlvdSBjYW4gYmUgb2JzZXJ2ZWQgdGhhdCB0aGUgUlBTIHJl
bWFpbnMgYXQgYSBjZXJ0YWluIHZhbHVlIGZvcmV2ZXIuIA0KPiBUaGUgY29ycmVjdCBwcm9jZXNz
IHNob3VsZCBiZSB0byBjb25maWd1cmUgTUFDL01UTC9ETUEgYmVmb3JlIGVuYWJsaW5nIERNQS9N
QUMNCg0KV2hhdCBTaW1vbiBpcyBhc2tpbmcgZm9yIGlzIHRoYXQgdGhpcyBpcyBwYXJ0IG9mIHRo
ZSBjb21taXQgbWVzc2FnZS4NCg0KUGxlYXNlIGFsc28gZG9uJ3QgdG9wIHBvc3QuDQoNCiAgICBB
bmRyZXcNCg0KLS0tDQpwdy1ib3Q6IGNyDQo=

--_002_daf687938ae1413bbc556134b47d0629sienginecom_
Content-Type: application/octet-stream;
	name="0001-net-stmmac-enable-MAC-after-MTL-configuring.patch"
Content-Description: 0001-net-stmmac-enable-MAC-after-MTL-configuring.patch
Content-Disposition: attachment;
	filename="0001-net-stmmac-enable-MAC-after-MTL-configuring.patch"; size=4554;
	creation-date="Sun, 20 Oct 2024 01:43:57 GMT";
	modification-date="Sun, 20 Oct 2024 01:42:30 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1N2M5MzQ2M2NmNmJlM2ZkMDMwOTE4ZDg0NmVmM2Q2NWM3NTRkMjAxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiaGFpbG9uZy5mYW4iIDxoYWlsb25nLmZhbkBzaWVuZ2luZS5j
b20+CkRhdGU6IE1vbiwgMTQgT2N0IDIwMjQgMTE6MTk6MTYgKzA4MDAKU3ViamVjdDogW1BBVENI
XSBuZXQ6IHN0bW1hYzogZW5hYmxlIE1BQyBhZnRlciBNVEwgY29uZmlndXJpbmcKCkRNQSBtYXli
ZSBibG9jayB3aGlsZSBFVEggaXMgb3BlbmluZywKQWRqdXN0IHRoZSBlbmFibGUgc2VxdWVuY2Us
IHB1dCB0aGUgTUFDIGVuYWJsZSBsYXN0CgpGb3IgZXhhbXBsZSwgRVRIIGlzIGRpcmVjdGx5IGNv
bm5lY3RlZCB0byB0aGUgc3dpdGNoLAp3aGljaCBuZXZlciBwb3dlciBkb3duIGFuZCBzZW5kcyBi
cm9hZGNhc3QgcGFja2V0cyBhdCByZWd1bGFyIGludGVydmFscy4KRHVyaW5nIHRoZSBwcm9jZXNz
IG9mIG9wZW5pbmcgRVRILCBkYXRhIG1heSBmbG93IGludG8gdGhlIE1UTCBGSUZPLApvbmNlIE1B
QyBSWCBpcyBlbmFibGVkLiBhbmQgdGhlbiwgTVRMIHdpbGwgYmUgc2V0LCBzdWNoIGFzIEZJRk8g
c2l6ZS4KT25jZSBlbmFibGUgRE1BLCBUaGVyZSBpcyBhIGNlcnRhaW4gcHJvYmFiaWxpdHkgdGhh
dCBETUEgd2lsbCByZWFkCmluY29ycmVjdCBkYXRhIGZyb20gTVRMIEZJRk8sIGNhdXNpbmcgRE1B
IHRvIGhhbmcgdXAuCkJ5IHJlYWQgRE1BX0RlYnVnX1N0YXR1cywgeW91IGNhbiBiZSBvYnNlcnZl
ZCB0aGF0IHRoZSBSUFMgcmVtYWlucyBhdAphIGNlcnRhaW4gdmFsdWUgZm9yZXZlci4gVGhlIGNv
cnJlY3QgcHJvY2VzcyBzaG91bGQgYmUgdG8gY29uZmlndXJlCk1BQy9NVEwvRE1BIGJlZm9yZSBl
bmFibGluZyBETUEvTUFDCgpTaWduZWQtb2ZmLWJ5OiBoYWlsb25nLmZhbiA8aGFpbG9uZy5mYW5A
c2llbmdpbmUuY29tPgotLS0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3
bWFjNF9saWIuYyAgIHwgIDggLS0tLS0tLS0KIGRyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8v
c3RtbWFjL2R3eGdtYWMyX2RtYS5jIHwgMTIgLS0tLS0tLS0tLS0tCiBkcml2ZXJzL25ldC9ldGhl
cm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWFpbi5jICB8ICA2ICsrKy0tLQogMyBmaWxlcyBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjNF9saWIuYyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjNF9saWIuYwppbmRleCAwZDE4NWU1NGUu
LjkyNDQ4ZDg1OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1t
YWMvZHdtYWM0X2xpYi5jCisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFj
L2R3bWFjNF9saWIuYwpAQCAtNTAsMTAgKzUwLDYgQEAgdm9pZCBkd21hYzRfZG1hX3N0YXJ0X3R4
KHN0cnVjdCBzdG1tYWNfcHJpdiAqcHJpdiwgdm9pZCBfX2lvbWVtICppb2FkZHIsCiAKIAl2YWx1
ZSB8PSBETUFfQ09OVFJPTF9TVDsKIAl3cml0ZWwodmFsdWUsIGlvYWRkciArIERNQV9DSEFOX1RY
X0NPTlRST0woZHdtYWM0X2FkZHJzLCBjaGFuKSk7Ci0KLQl2YWx1ZSA9IHJlYWRsKGlvYWRkciAr
IEdNQUNfQ09ORklHKTsKLQl2YWx1ZSB8PSBHTUFDX0NPTkZJR19URTsKLQl3cml0ZWwodmFsdWUs
IGlvYWRkciArIEdNQUNfQ09ORklHKTsKIH0KIAogdm9pZCBkd21hYzRfZG1hX3N0b3BfdHgoc3Ry
dWN0IHN0bW1hY19wcml2ICpwcml2LCB2b2lkIF9faW9tZW0gKmlvYWRkciwKQEAgLTc3LDEwICs3
Myw2IEBAIHZvaWQgZHdtYWM0X2RtYV9zdGFydF9yeChzdHJ1Y3Qgc3RtbWFjX3ByaXYgKnByaXYs
IHZvaWQgX19pb21lbSAqaW9hZGRyLAogCXZhbHVlIHw9IERNQV9DT05UUk9MX1NSOwogCiAJd3Jp
dGVsKHZhbHVlLCBpb2FkZHIgKyBETUFfQ0hBTl9SWF9DT05UUk9MKGR3bWFjNF9hZGRycywgY2hh
bikpOwotCi0JdmFsdWUgPSByZWFkbChpb2FkZHIgKyBHTUFDX0NPTkZJRyk7Ci0JdmFsdWUgfD0g
R01BQ19DT05GSUdfUkU7Ci0Jd3JpdGVsKHZhbHVlLCBpb2FkZHIgKyBHTUFDX0NPTkZJRyk7CiB9
CiAKIHZvaWQgZHdtYWM0X2RtYV9zdG9wX3J4KHN0cnVjdCBzdG1tYWNfcHJpdiAqcHJpdiwgdm9p
ZCBfX2lvbWVtICppb2FkZHIsCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1p
Y3JvL3N0bW1hYy9kd3hnbWFjMl9kbWEuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8v
c3RtbWFjL2R3eGdtYWMyX2RtYS5jCmluZGV4IDc4NDBiYzQwMy4uY2JhMTJlZGMxIDEwMDY0NAot
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd3hnbWFjMl9kbWEuYwor
KysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd3hnbWFjMl9kbWEuYwpA
QCAtMjg4LDEwICsyODgsNiBAQCBzdGF0aWMgdm9pZCBkd3hnbWFjMl9kbWFfc3RhcnRfdHgoc3Ry
dWN0IHN0bW1hY19wcml2ICpwcml2LAogCXZhbHVlID0gcmVhZGwoaW9hZGRyICsgWEdNQUNfRE1B
X0NIX1RYX0NPTlRST0woY2hhbikpOwogCXZhbHVlIHw9IFhHTUFDX1RYU1Q7CiAJd3JpdGVsKHZh
bHVlLCBpb2FkZHIgKyBYR01BQ19ETUFfQ0hfVFhfQ09OVFJPTChjaGFuKSk7Ci0KLQl2YWx1ZSA9
IHJlYWRsKGlvYWRkciArIFhHTUFDX1RYX0NPTkZJRyk7Ci0JdmFsdWUgfD0gWEdNQUNfQ09ORklH
X1RFOwotCXdyaXRlbCh2YWx1ZSwgaW9hZGRyICsgWEdNQUNfVFhfQ09ORklHKTsKIH0KIAogc3Rh
dGljIHZvaWQgZHd4Z21hYzJfZG1hX3N0b3BfdHgoc3RydWN0IHN0bW1hY19wcml2ICpwcml2LCB2
b2lkIF9faW9tZW0gKmlvYWRkciwKQEAgLTMwMiwxMCArMjk4LDYgQEAgc3RhdGljIHZvaWQgZHd4
Z21hYzJfZG1hX3N0b3BfdHgoc3RydWN0IHN0bW1hY19wcml2ICpwcml2LCB2b2lkIF9faW9tZW0g
KmlvYWRkciwKIAl2YWx1ZSA9IHJlYWRsKGlvYWRkciArIFhHTUFDX0RNQV9DSF9UWF9DT05UUk9M
KGNoYW4pKTsKIAl2YWx1ZSAmPSB+WEdNQUNfVFhTVDsKIAl3cml0ZWwodmFsdWUsIGlvYWRkciAr
IFhHTUFDX0RNQV9DSF9UWF9DT05UUk9MKGNoYW4pKTsKLQotCXZhbHVlID0gcmVhZGwoaW9hZGRy
ICsgWEdNQUNfVFhfQ09ORklHKTsKLQl2YWx1ZSAmPSB+WEdNQUNfQ09ORklHX1RFOwotCXdyaXRl
bCh2YWx1ZSwgaW9hZGRyICsgWEdNQUNfVFhfQ09ORklHKTsKIH0KIAogc3RhdGljIHZvaWQgZHd4
Z21hYzJfZG1hX3N0YXJ0X3J4KHN0cnVjdCBzdG1tYWNfcHJpdiAqcHJpdiwKQEAgLTMxNiwxMCAr
MzA4LDYgQEAgc3RhdGljIHZvaWQgZHd4Z21hYzJfZG1hX3N0YXJ0X3J4KHN0cnVjdCBzdG1tYWNf
cHJpdiAqcHJpdiwKIAl2YWx1ZSA9IHJlYWRsKGlvYWRkciArIFhHTUFDX0RNQV9DSF9SWF9DT05U
Uk9MKGNoYW4pKTsKIAl2YWx1ZSB8PSBYR01BQ19SWFNUOwogCXdyaXRlbCh2YWx1ZSwgaW9hZGRy
ICsgWEdNQUNfRE1BX0NIX1JYX0NPTlRST0woY2hhbikpOwotCi0JdmFsdWUgPSByZWFkbChpb2Fk
ZHIgKyBYR01BQ19SWF9DT05GSUcpOwotCXZhbHVlIHw9IFhHTUFDX0NPTkZJR19SRTsKLQl3cml0
ZWwodmFsdWUsIGlvYWRkciArIFhHTUFDX1JYX0NPTkZJRyk7CiB9CiAKIHN0YXRpYyB2b2lkIGR3
eGdtYWMyX2RtYV9zdG9wX3J4KHN0cnVjdCBzdG1tYWNfcHJpdiAqcHJpdiwgdm9pZCBfX2lvbWVt
ICppb2FkZHIsCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1h
Yy9zdG1tYWNfbWFpbi5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3Rt
bWFjX21haW4uYwppbmRleCBlMjE0MDQ4MjIuLmMxOWNhNjJhNCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX21haW4uYworKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfbWFpbi5jCkBAIC0zNDM3LDkgKzM0
MzcsNiBAQCBzdGF0aWMgaW50IHN0bW1hY19od19zZXR1cChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
LCBib29sIHB0cF9yZWdpc3RlcikKIAkJcHJpdi0+aHctPnJ4X2NzdW0gPSAwOwogCX0KIAotCS8q
IEVuYWJsZSB0aGUgTUFDIFJ4L1R4ICovCi0Jc3RtbWFjX21hY19zZXQocHJpdiwgcHJpdi0+aW9h
ZGRyLCB0cnVlKTsKLQogCS8qIFNldCB0aGUgSFcgRE1BIG1vZGUgYW5kIHRoZSBDT0UgKi8KIAlz
dG1tYWNfZG1hX29wZXJhdGlvbl9tb2RlKHByaXYpOwogCkBAIC0zNTIzLDYgKzM1MjAsOSBAQCBz
dGF0aWMgaW50IHN0bW1hY19od19zZXR1cChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBib29sIHB0
cF9yZWdpc3RlcikKIAkvKiBTdGFydCB0aGUgYmFsbCByb2xsaW5nLi4uICovCiAJc3RtbWFjX3N0
YXJ0X2FsbF9kbWEocHJpdik7CiAKKwkvKiBFbmFibGUgdGhlIE1BQyBSeC9UeCAqLworCXN0bW1h
Y19tYWNfc2V0KHByaXYsIHByaXYtPmlvYWRkciwgdHJ1ZSk7CisKIAlzdG1tYWNfc2V0X2h3X3Zs
YW5fbW9kZShwcml2LCBwcml2LT5odyk7CiAKIAlyZXR1cm4gMDsKLS0gCjIuMzQuMQoK

--_002_daf687938ae1413bbc556134b47d0629sienginecom_--

