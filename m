Return-Path: <netdev+bounces-123593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B4A96574E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 08:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA6E1C22E5D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 06:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9413E14B081;
	Fri, 30 Aug 2024 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nh/oK4PJ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17CF14884F;
	Fri, 30 Aug 2024 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724997855; cv=none; b=tBmnQaQaQZZ17D/Q/E0f8lJw+OQS99Zke6BvsnJUSZvwOywXExCNwnhvn5pM490fLXTeYhRi4j4Eb86kZG47dANez1AXwEpCr8FZYT/VMO9k5ZhsCXdXCryfShf0BLdazTh72uxSAxllfe44QFqyVA28BCq5WZ0/hHNNUclaOFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724997855; c=relaxed/simple;
	bh=ghXveYyLPJmX7z11GB27xQoE+D89WFHLGgvYP9iSH8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hYbvZ1l+rQUMWUOHfrB1XWCNUhxAxOCmK8BuEXXBWmqv28jhjyRcKulcfXiLSrXZmyS1pEpvT2hVTf5Lwms1eFmKtlrscS4k2MeRpJRSk+6+XSjrgsrMKsClzMlQ0QWp1ZTEy+Z4K8tGqUjBn0qpwnxGSoRiiSZO1Tw8QUDe2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nh/oK4PJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47U63dj76359467, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724997819; bh=ghXveYyLPJmX7z11GB27xQoE+D89WFHLGgvYP9iSH8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nh/oK4PJBi+qoOZNc//+fcu7bC9873IZR4wrFz3Vy5t55w2+qFbdPAgyWlCjwKwgy
	 bLt/+TnEyGvAIc7Z1f8j1SkSy3Mc3/2ABUMTzVt5/jSPFj8HRv+qgP2Y+MWPgwpHh1
	 icdb2YUGR8BN6DUGvYBjxPGUJTZyOIneNPddHvp8dCXM3ZJS/LCmU8+7JWVVEVzXYK
	 sM8aztzwkvvWLQgiqf4OAWkQQ2g0oH64AReejcKsXHkSivI7h8CIakY6c4Vhiju+j9
	 Tb3YYvnuM3fn54/cUf6i7OdSnR6fFd/XtcDCG5PUfOMX8E9IJwlemT8oCBhWurTimT
	 WkVCvxd8ykPaQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47U63dj76359467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 14:03:39 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 14:03:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 30 Aug 2024 14:03:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 30 Aug 2024 14:03:38 +0800
From: Hau <hau@realtek.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd <nic_swsd@realtek.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] r8169: add support for RTL8126A rev.b
Thread-Topic: [PATCH net-next] r8169: add support for RTL8126A rev.b
Thread-Index: AQHa+oLe25e/1kPwh0uZ2N7oP2hFqbI+wVKAgACN8AA=
Date: Fri, 30 Aug 2024 06:03:38 +0000
Message-ID: <7dd4afc3ded14012a4b0ea2f34996c4d@realtek.com>
References: <20240830021810.11993-1-hau@realtek.com>
 <d2c681d6-2213-4cad-8b01-783ee5f864b0@gmail.com>
In-Reply-To: <d2c681d6-2213-4cad-8b01-783ee5f864b0@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpbmVyIEthbGx3ZWl0
IFttYWlsdG86aGthbGx3ZWl0MUBnbWFpbC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDMw
LCAyMDI0IDE6MzQgUE0NCj4gVG86IEhhdSA8aGF1QHJlYWx0ZWsuY29tPjsgbmljX3N3c2QgPG5p
Y19zd3NkQHJlYWx0ZWsuY29tPjsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbQ0KPiBDYzogbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0XSByODE2OTogYWRkIHN1cHBvcnQgZm9yIFJUTDgxMjZB
IHJldi5iDQo+IA0KPiANCj4gRXh0ZXJuYWwgbWFpbC4NCj4gDQo+IA0KPiANCj4gT24gMzAuMDgu
MjAyNCAwNDoxOCwgQ2h1bkhhbyBMaW4gd3JvdGU6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIFJUTDgx
MjZBIHJldi5iLiBJdHMgWElEIGlzIDB4NjRhLiBJdCBpcyBiYXNpY2FsbHkNCj4gPiBiYXNlZCBv
biB0aGUgb25lIHdpdGggWElEIDB4NjQ5LCBidXQgd2l0aCBkaWZmZXJlbnQgZmlybXdhcmUgZmls
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5IYW8gTGluIDxoYXVAcmVhbHRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjkuaCAgICAg
ICAgICB8ICAxICsNCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWlu
LmMgICAgIHwgNDIgKysrKysrKysrKysrLS0tLS0tLQ0KPiA+ICAuLi4vbmV0L2V0aGVybmV0L3Jl
YWx0ZWsvcjgxNjlfcGh5X2NvbmZpZy5jICAgfCAgMSArDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwg
MjkgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OS5oDQo+ID4gYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9yZWFsdGVrL3I4MTY5LmgNCj4gPiBpbmRleCAwMDg4MmZmYzdhMDIuLmUyZGI5NDRl
NmZhOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5
LmgNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5LmgNCj4gPiBA
QCAtNjksNiArNjksNyBAQCBlbnVtIG1hY192ZXJzaW9uIHsNCj4gPiAgICAgICBSVExfR0lHQV9N
QUNfVkVSXzYxLA0KPiA+ICAgICAgIFJUTF9HSUdBX01BQ19WRVJfNjMsDQo+ID4gICAgICAgUlRM
X0dJR0FfTUFDX1ZFUl82NSwNCj4gPiArICAgICBSVExfR0lHQV9NQUNfVkVSXzY2LA0KPiA+ICAg
ICAgIFJUTF9HSUdBX01BQ19OT05FDQo+ID4gIH07DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jDQo+ID4gaW5kZXggMzUwN2MyZTI4MTEwLi4z
Y2IxYzRmNWM5MWEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRl
ay9yODE2OV9tYWluLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4
MTY5X21haW4uYw0KPiA+IEBAIC01Niw2ICs1Niw3IEBADQo+ID4gICNkZWZpbmUgRklSTVdBUkVf
ODEyNUFfMyAgICAgInJ0bF9uaWMvcnRsODEyNWEtMy5mdyINCj4gPiAgI2RlZmluZSBGSVJNV0FS
RV84MTI1Ql8yICAgICAicnRsX25pYy9ydGw4MTI1Yi0yLmZ3Ig0KPiA+ICAjZGVmaW5lIEZJUk1X
QVJFXzgxMjZBXzIgICAgICJydGxfbmljL3J0bDgxMjZhLTIuZnciDQo+ID4gKyNkZWZpbmUgRklS
TVdBUkVfODEyNkFfMyAgICAgInJ0bF9uaWMvcnRsODEyNmEtMy5mdyINCj4gPg0KPiANCj4gSSBj
aGVja2VkIGxpbnV4LWZpcm13YXJlIHJlcG8sIHRoZSBuZXcgZmlybXdhcmUgaXNuJ3QgYXZhaWxh
YmxlIHRoZXJlIHlldC4NCj4gQXJlIHlvdSBnb2luZyB0byBzdWJtaXQgdGhlIGZpcm13YXJlIGZp
bGU/DQo+IA0KSSB3aWxsIHN1Ym1pdCB0aGUgbmV3IGZpcm13YXJlIGZpbGUuDQoNCj4gUmV2aWV3
ZWQtYnk6IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+DQo=

