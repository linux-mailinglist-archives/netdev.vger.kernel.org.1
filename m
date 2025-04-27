Return-Path: <netdev+bounces-186324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F91CA9E4A0
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 22:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCCF18921B0
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 20:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23CD201035;
	Sun, 27 Apr 2025 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="DSlQZ69X"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC9D256D
	for <netdev@vger.kernel.org>; Sun, 27 Apr 2025 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745787473; cv=none; b=nfsT0SGmEHUp3Ky2VevhW4BvEOOWYo+p7FLuaTuX7s78eB6pvr1R1qrymfurIdIST7rRpfGpP7i7zdbv1sgMSQbSSLcGMZt906m3hyiXzPDE0oKWap602KCG/8geDGMPLuLK9E95NV05gTXswBkHAgIdh05mGVwk2PJUlkFPa9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745787473; c=relaxed/simple;
	bh=0CoROoWMezV2WldkSB5hk7rHdS75uBGFyvD8USMvF1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kNp0vCStkbTb1jimbY8xyCJr9Pep7zBymMs9UdJ/8p7ELMg+mzKZO9Z7gB7YuZowSPOLKO25zZBMq9mC5Ewe2wDhtGRajeSVdzv2G4ZQ5q74OM8HjURb5pCmKSwY/DCBt4sde6ce0RqhkYyrgpSgDgGG4oRdMdni39Kj28DijEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=DSlQZ69X; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7B5ED2C02E1;
	Mon, 28 Apr 2025 08:49:37 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1745786977;
	bh=0CoROoWMezV2WldkSB5hk7rHdS75uBGFyvD8USMvF1M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=DSlQZ69X1LedqR0W2GxCXVnuYx4L7A6QirczksKg4bk40ouJEzKKwWJEWiEpQ7pFW
	 8e2wy3i6OFisw1VxSBX8TfHb7KzjTItsIwyzlwey417iWELEcPGXyWTjZdQIp8aOUu
	 UovMH7B0X+p19gohWew4By/WMqztWOaQLaeo7FFE9Lwf9rpIJWUN3DREteFu9P/7JX
	 9vDjHOWE8k6sn6X4EGDEhYASrEDqfQa6BTcwRGOCTKYxRBddwV3vBIZkXtdsewFlTY
	 QZOv6MdShrz4G4IMiNpIf/XWi2FRzhyrhCciMMouxWUu1HKj4kpBGUvoN7ONcCQvU9
	 V819wBkHGwvoQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B680e98610001>; Mon, 28 Apr 2025 08:49:37 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 08:49:37 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Mon, 28 Apr 2025 08:49:37 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>
CC: Arnd Bergmann <arnd@arndb.de>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	"Clark Wang" <xiaoning.wang@nxp.com>, Russell King <linux@armlinux.org.uk>,
	Frank Li <Frank.Li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mdio: fix CONFIG_MDIO_DEVRES selects
Thread-Topic: [PATCH] mdio: fix CONFIG_MDIO_DEVRES selects
Thread-Index: AQHbtdUrdXWQmKPPO0Sd/nJjsikz9LO3NvAA
Date: Sun, 27 Apr 2025 20:49:37 +0000
Message-ID: <4ec48be5-9245-4e19-b704-59c8e0ac46d1@alliedtelesis.co.nz>
References: <20250425112819.1645342-1-arnd@kernel.org>
In-Reply-To: <20250425112819.1645342-1-arnd@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1F07CBF769C2649ACCE2A4BB7866852@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=W+WbVgWk c=1 sm=1 tr=0 ts=680e9861 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=qwV-1VxuFX9yBY0VpnMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgQXJuZCwNCg0KT24gMjUvMDQvMjAyNSAyMzoyNywgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4g
RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4NCj4gVGhlIG5ld2x5IGFkZGVk
IHJ0bDkzMDAgZHJpdmVyIG5lZWRzIE1ESU9fREVWUkVTOg0KPg0KPiB4ODZfNjQtbGludXgtbGQ6
IGRyaXZlcnMvbmV0L21kaW8vbWRpby1yZWFsdGVrLXJ0bDkzMDAubzogaW4gZnVuY3Rpb24gYHJ0
bDkzMDBfbWRpb2J1c19wcm9iZSc6DQo+IG1kaW8tcmVhbHRlay1ydGw5MzAwLmM6KC50ZXh0KzB4
OTQxKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgZGV2bV9tZGlvYnVzX2FsbG9jX3NpemUnDQo+
IHg4Nl82NC1saW51eC1sZDogbWRpby1yZWFsdGVrLXJ0bDkzMDAuYzooLnRleHQrMHg5ZTIpOiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBfX2Rldm1fbWRpb2J1c19yZWdpc3RlcicNCj4gU2luY2Ug
dGhpcyBpcyBhIGhpZGRlbiBzeW1ib2wsIGl0IG5lZWRzIHRvIGJlIHNlbGVjdGVkIGJ5IGVhY2gg
dXNlciwNCj4gcmF0aGVyIHRoYW4gdGhlIHVzdWFsICdkZXBlbmRzIG9uJy4gSSBzZWUgdGhhdCB0
aGVyZSBhcmUgYSBmZXcgb3RoZXINCj4gZHJpdmVycyB0aGF0IGFjY2lkZW50YWxseSB1c2UgJ2Rl
cGVuZHMgb24nLCBzbyBmaXggdGhlc2UgYXMgd2VsbCBmb3INCj4gY29uc2lzdGVuY3kgYW5kIHRv
IGF2b2lkIGRlcGVuZGVuY3kgbG9vcHMuDQo+DQo+IEZpeGVzOiAzN2Y5YjJhNmMwODYgKCJuZXQ6
IGV0aGVybmV0OiBBZGQgbWlzc2luZyBkZXBlbmRzIG9uIE1ESU9fREVWUkVTIikNCj4gRml4ZXM6
IDI0ZTMxZTQ3NDc2OSAoIm5ldDogbWRpbzogQWRkIFJUTDkzMDAgTURJTyBkcml2ZXIiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KDQpUaGFua3MgZm9y
IGNhdGNoaW5nIHRoaXMNCg0KUmV2aWV3ZWQtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2to
YW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9mcmVlc2NhbGUvZW5ldGMvS2NvbmZpZyB8IDMgKystDQo+ICAgZHJpdmVycy9uZXQvbWRpby9L
Y29uZmlnICAgICAgICAgICAgICAgICAgICAgfCA3ICsrKystLS0NCj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9LY29uZmlnIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL0tjb25maWcNCj4gaW5kZXggNmMyNzc5MDQ3ZGNkLi41
MzY3ZThhZjFlMWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9lbmV0Yy9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9l
bmV0Yy9LY29uZmlnDQo+IEBAIC03Myw3ICs3Myw4IEBAIGNvbmZpZyBGU0xfRU5FVENfSUVSQg0K
PiAgIA0KPiAgIGNvbmZpZyBGU0xfRU5FVENfTURJTw0KPiAgIAl0cmlzdGF0ZSAiRU5FVEMgTURJ
TyBkcml2ZXIiDQo+IC0JZGVwZW5kcyBvbiBQQ0kgJiYgTURJT19ERVZSRVMgJiYgTURJT19CVVMN
Cj4gKwlkZXBlbmRzIG9uIFBDSSAmJiBNRElPX0JVUw0KPiArCXNlbGVjdCBNRElPX0RFVlJFUw0K
PiAgIAloZWxwDQo+ICAgCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgTlhQIEVORVRDIENlbnRyYWwg
TURJTyBjb250cm9sbGVyIGFzIGEgUENJZQ0KPiAgIAkgIHBoeXNpY2FsIGZ1bmN0aW9uIChQRikg
ZGV2aWNlLg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvbWRpby9LY29uZmlnIGIvZHJpdmVy
cy9uZXQvbWRpby9LY29uZmlnDQo+IGluZGV4IDM4YTQ5MDFkYTMyZi4uZjY4MGVkNjc2Nzk3IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9tZGlvL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9u
ZXQvbWRpby9LY29uZmlnDQo+IEBAIC02Niw3ICs2Niw3IEBAIGNvbmZpZyBNRElPX0FTUEVFRA0K
PiAgIAl0cmlzdGF0ZSAiQVNQRUVEIE1ESU8gYnVzIGNvbnRyb2xsZXIiDQo+ICAgCWRlcGVuZHMg
b24gQVJDSF9BU1BFRUQgfHwgQ09NUElMRV9URVNUDQo+ICAgCWRlcGVuZHMgb24gT0ZfTURJTyAm
JiBIQVNfSU9NRU0NCj4gLQlkZXBlbmRzIG9uIE1ESU9fREVWUkVTDQo+ICsJc2VsZWN0IE1ESU9f
REVWUkVTDQo+ICAgCWhlbHANCj4gICAJICBUaGlzIG1vZHVsZSBwcm92aWRlcyBhIGRyaXZlciBm
b3IgdGhlIGluZGVwZW5kZW50IE1ESU8gYnVzDQo+ICAgCSAgY29udHJvbGxlcnMgZm91bmQgaW4g
dGhlIEFTUEVFRCBBU1QyNjAwIFNvQy4gVGhpcyBpcyBhIGRyaXZlciBmb3IgdGhlDQo+IEBAIC0x
NzIsNyArMTcyLDcgQEAgY29uZmlnIE1ESU9fSVBRNDAxOQ0KPiAgIAl0cmlzdGF0ZSAiUXVhbGNv
bW0gSVBRNDAxOSBNRElPIGludGVyZmFjZSBzdXBwb3J0Ig0KPiAgIAlkZXBlbmRzIG9uIEhBU19J
T01FTSAmJiBPRl9NRElPDQo+ICAgCWRlcGVuZHMgb24gQ09NTU9OX0NMSw0KPiAtCWRlcGVuZHMg
b24gTURJT19ERVZSRVMNCj4gKwlzZWxlY3QgTURJT19ERVZSRVMNCj4gICAJaGVscA0KPiAgIAkg
IFRoaXMgZHJpdmVyIHN1cHBvcnRzIHRoZSBNRElPIGludGVyZmFjZSBmb3VuZCBpbiBRdWFsY29t
bQ0KPiAgIAkgIElQUTQweHgsIElQUTYweHgsIElQUTgwN3ggYW5kIElQUTUweHggc2VyaWVzIFNv
Yy1zLg0KPiBAQCAtMTgxLDcgKzE4MSw3IEBAIGNvbmZpZyBNRElPX0lQUTgwNjQNCj4gICAJdHJp
c3RhdGUgIlF1YWxjb21tIElQUTgwNjQgTURJTyBpbnRlcmZhY2Ugc3VwcG9ydCINCj4gICAJZGVw
ZW5kcyBvbiBIQVNfSU9NRU0gJiYgT0ZfTURJTw0KPiAgIAlkZXBlbmRzIG9uIE1GRF9TWVNDT04N
Cj4gLQlkZXBlbmRzIG9uIE1ESU9fREVWUkVTDQo+ICsJc2VsZWN0IE1ESU9fREVWUkVTDQo+ICAg
CWhlbHANCj4gICAJICBUaGlzIGRyaXZlciBzdXBwb3J0cyB0aGUgTURJTyBpbnRlcmZhY2UgZm91
bmQgaW4gdGhlIG5ldHdvcmsNCj4gICAJICBpbnRlcmZhY2UgdW5pdHMgb2YgdGhlIElQUTgwNjQg
U29DDQo+IEBAIC0xODksNiArMTg5LDcgQEAgY29uZmlnIE1ESU9fSVBRODA2NA0KPiAgIGNvbmZp
ZyBNRElPX1JFQUxURUtfUlRMOTMwMA0KPiAgIAl0cmlzdGF0ZSAiUmVhbHRlayBSVEw5MzAwIE1E
SU8gaW50ZXJmYWNlIHN1cHBvcnQiDQo+ICAgCWRlcGVuZHMgb24gTUFDSF9SRUFMVEVLX1JUTCB8
fCBDT01QSUxFX1RFU1QNCj4gKwlzZWxlY3QgTURJT19ERVZSRVMNCj4gICAJaGVscA0KPiAgIAkg
IFRoaXMgZHJpdmVyIHN1cHBvcnRzIHRoZSBNRElPIGludGVyZmFjZSBmb3VuZCBpbiB0aGUgUmVh
bHRlaw0KPiAgIAkgIFJUTDkzMDAgZmFtaWx5IG9mIEV0aGVybmV0IHN3aXRjaGVzIHdpdGggaW50
ZWdyYXRlZCBTb0Mu

