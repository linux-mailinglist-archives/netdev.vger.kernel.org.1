Return-Path: <netdev+bounces-175616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5044BA66E25
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B361683CA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B661F418A;
	Tue, 18 Mar 2025 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Gxn4TP23"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372E11E8344;
	Tue, 18 Mar 2025 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286510; cv=none; b=TbZUXsCAhW8Pzaf8ZlcbaL+/Rubjm1JbuWlRDzEvfpdmlQTOrqqOkR2f+fMiK4K9vYF7YD2Q2SU8FVNJxTqg5vPlUUlk9ktLLIL+0M+CJGlmP7HzuQOUzO0nEsCCrc4ZwEudP/YtPMaguV5sWW+s/JIjcdnn1DfKI0bsUmH92yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286510; c=relaxed/simple;
	bh=CDiB/eZ+HOnWhcgTFstgP4zJqj01bVvjf3wKTzKOUC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DBRVaZL6Rh8RqENlIpDgKi7VagomYrOghR9d0XLSma8acuMPHaGOVbQsEic4vXrwAvB8+OGtVeIWHv9CfW+hdn/rt+fWpnPoX+iJ4lQiUpGJQyulx/gmyhoHCiiNoftThALmvdetE3+yZhqbTjBDjA6DnZpGzh1HJOIkgqAFaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Gxn4TP23; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52I8S0H402581256, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742286480; bh=CDiB/eZ+HOnWhcgTFstgP4zJqj01bVvjf3wKTzKOUC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Gxn4TP23Fl+OQqw0VVYOHHAN5OibD49QMcRv9lq1xq5dxUaW10934F7cOyQQo/J3H
	 Zo+ndmLqmDgYGCpszVMIbgwi4jlRKUUsa8Ouy8BdN7j9g2FVyRsxh0ZYa19vHo1v6v
	 AbH9S0A4OM3hLcxH8NqVtoL3ofyR3IpqRne/l3nDwQqX/7Bg5mgFJ9Fi8CVN8c4u71
	 L96aZRc4tFpI8Ma1XzwwKPgCxaazBlm7MLeyWHghZk0ylClnR+kU9eNqbOfc9KPf5U
	 +Qlo4Ga4ZMhfq0nO/moSvHooupREFEHUd4/uMQ/TV6jt1ThTI8ZrTF1EuAHsG5W+CH
	 8s6ntgKP3piAg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52I8S0H402581256
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 16:28:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Mar 2025 16:28:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 18 Mar 2025 16:27:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 18 Mar 2025 16:27:59 +0800
From: Hau <hau@realtek.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd <nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/2] r8169: disable RTL8126 ZRX-DC timeout
Thread-Topic: [PATCH net-next v2 2/2] r8169: disable RTL8126 ZRX-DC timeout
Thread-Index: AQHblxiRYH4CHyDj5kexwb8pyB4RDLN3SyIAgAFFt3A=
Date: Tue, 18 Mar 2025 08:27:59 +0000
Message-ID: <0fca76aeb8ac4b4c8d925b93fd622979@realtek.com>
References: <20250317084236.4499-1-hau@realtek.com>
 <20250317084236.4499-3-hau@realtek.com>
 <9cc1ed25-1244-4f4d-8e5e-fe5113a07fbe@gmail.com>
In-Reply-To: <9cc1ed25-1244-4f4d-8e5e-fe5113a07fbe@gmail.com>
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

PiANCj4gRXh0ZXJuYWwgbWFpbCA6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
dGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90DQo+IHJlcGx5LCBjbGljayBsaW5rcywgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+IE9uIDE3LjAzLjIwMjUgMDk6NDIsIENo
dW5IYW8gTGluIHdyb3RlOg0KPiA+IERpc2FibGUgaXQgZHVlIHRvIGl0IGRvc2Ugbm90IG1lZXQg
WlJYLURDIHNwZWNpZmljYXRpb24uIElmIGl0IGlzDQo+ID4gZW5hYmxlZCwgZGV2aWNlIHdpbGwg
ZXhpdCBMMSBzdWJzdGF0ZSBldmVyeSAxMDBtcy4gRGlzYWJsZSBpdCBmb3INCj4gPiBzYXZpbmcg
bW9yZSBwb3dlciBpbiBMMSBzdWJzdGF0ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5I
YW8gTGluIDxoYXVAcmVhbHRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L3JlYWx0ZWsvcjgxNjlfbWFpbi5jIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0KPiA+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4gPiBpbmRleCAzYzY2M2ZjYTA3ZDMu
LmFkMzYwM2NmNzU5NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFs
dGVrL3I4MTY5X21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsv
cjgxNjlfbWFpbi5jDQo+ID4gQEAgLTI4NTIsNiArMjg1MiwyNSBAQCBzdGF0aWMgdTMyIHJ0bF9j
c2lfcmVhZChzdHJ1Y3QgcnRsODE2OV9wcml2YXRlICp0cCwNCj4gaW50IGFkZHIpDQo+ID4gICAg
ICAgICAgICAgICBSVExfUjMyKHRwLCBDU0lEUikgOiB+MDsgIH0NCj4gPg0KPiA+ICtzdGF0aWMg
dm9pZCBydGxfZGlzYWJsZV96cnhkY190aW1lb3V0KHN0cnVjdCBydGw4MTY5X3ByaXZhdGUgKnRw
KSB7DQo+ID4gKyAgICAgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0cC0+cGNpX2RldjsNCj4gPiAr
ICAgICB1MzIgY3NpOw0KPiA+ICsgICAgIHU4IHZhbDsNCj4gPiArDQo+ID4gKyNkZWZpbmUgUlRM
X0dFTjNfUkVMQVRFRF9PRkYgMHgwODkwDQo+ID4gKyNkZWZpbmUgUlRMX0dFTjNfWlJYRENfTk9O
Q09NUEwgICAgICAweDENCj4gPiArICAgICBpZiAocGRldi0+Y2ZnX3NpemUgPiBSVExfR0VOM19S
RUxBVEVEX09GRiAmJg0KPiA+ICsgICAgICAgICBwY2lfcmVhZF9jb25maWdfYnl0ZShwZGV2LCBS
VExfR0VOM19SRUxBVEVEX09GRiwgJnZhbCkgPT0NCj4gUENJQklPU19TVUNDRVNTRlVMICYmDQo+
ID4gKyAgICAgICAgIHBjaV93cml0ZV9jb25maWdfYnl0ZShwZGV2LCBSVExfR0VOM19SRUxBVEVE
X09GRiwgdmFsICYNCj4gPiArflJUTF9HRU4zX1pSWERDX05PTkNPTVBMKSA9PSBQQ0lCSU9TX1NV
Q0NFU1NGVUwpDQo+IA0KPiBUaGVzZSB0d28gbGluZXMgYXJlIHRvbyBsb25nLiBOZXRkZXYgYWxs
b3dzIG9ubHkgODAgY2hhcnMuDQo+IGNoZWNrcGF0Y2gucGwgd291bGQgaGF2ZSBub3RpY2VkIHlv
dS4NCj4gDQo+IEFwYXJ0IGZyb20gdGhhdCwgbG9va3MgZ29vZCB0byBtZS4NCj4gDQpJIHdpbGwg
Zml4IGl0LiBUaGFua3MuDQoNCj4gPiArICAgICAgICAgICAgIHJldHVybjsNCj4gPiArDQo+ID4g
KyAgICAgbmV0ZGV2X25vdGljZV9vbmNlKHRwLT5kZXYsDQo+ID4gKyAgICAgICAgICAgICAiTm8g
bmF0aXZlIGFjY2VzcyB0byBQQ0kgZXh0ZW5kZWQgY29uZmlnIHNwYWNlLCBmYWxsaW5nIGJhY2sg
dG8NCj4gQ1NJXG4iKTsNCj4gPiArICAgICBjc2kgPSBydGxfY3NpX3JlYWQodHAsIFJUTF9HRU4z
X1JFTEFURURfT0ZGKTsNCj4gPiArICAgICBydGxfY3NpX3dyaXRlKHRwLCBSVExfR0VOM19SRUxB
VEVEX09GRiwgY3NpICYNCj4gPiArIH5SVExfR0VOM19aUlhEQ19OT05DT01QTCk7DQo+IA0KPiBG
b3IgbXkgdW5kZXJzdGFuZGluZzogVGhlIGNzaSBmdW5jdGlvbnMgYWx3YXlzIGRlYWwgd2l0aCAz
MmJpdCB2YWx1ZXMuDQo+IERvZXMgdGhpcyBtZWFuIHRoYXQgYWxsIFJlYWx0ZWstc3BlY2lmaWMg
cmVnaXN0ZXJzIGluIGV4dGVuZGVkIGNvbmZpZyBzcGFjZQ0KPiBhcmUgMzJiaXQgcmVnaXN0ZXJz
Pw0KPiANCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgcnRsX3NldF9hc3BtX2VudHJ5
X2xhdGVuY3koc3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHAsIHU4DQo+ID4gdmFsKSAgew0KPiA+
ICAgICAgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gdHAtPnBjaV9kZXY7IEBAIC0zODI0LDYgKzM4
NDMsNyBAQCBzdGF0aWMNCj4gPiB2b2lkIHJ0bF9od19zdGFydF84MTI1ZChzdHJ1Y3QgcnRsODE2
OV9wcml2YXRlICp0cCkNCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBydGxfaHdfc3RhcnRfODEyNmEo
c3RydWN0IHJ0bDgxNjlfcHJpdmF0ZSAqdHApICB7DQo+ID4gKyAgICAgcnRsX2Rpc2FibGVfenJ4
ZGNfdGltZW91dCh0cCk7DQo+ID4gICAgICAgcnRsX3NldF9kZWZfYXNwbV9lbnRyeV9sYXRlbmN5
KHRwKTsNCj4gPiAgICAgICBydGxfaHdfc3RhcnRfODEyNV9jb21tb24odHApOw0KPiA+ICB9DQoN
Cg==

