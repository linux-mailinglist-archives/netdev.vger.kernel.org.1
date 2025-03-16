Return-Path: <netdev+bounces-175142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D04A63754
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 21:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E94188D8D7
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6073E1D8A12;
	Sun, 16 Mar 2025 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="CtnrFBzY"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A1418C031
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 20:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742155900; cv=none; b=KK9zqS4bZy8sqfIy6/qttMvrZIZ+X1JVyyTnxI3M1LXoflbEfP78n5xPQrpLji6dYrJX8bE63qFFZMKjM4ClomWAE7+ERMjbrSViwLtkn0ujVZZizGWn6PGsrW7SsyVpxQgYD2Y0YnZGwlCeTbUFBkdMuadnpAdE9Ej7PdMlVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742155900; c=relaxed/simple;
	bh=0mUmMxXCX1cpxTz2Mz/moHeklg4+C/Cf9N36sstH51o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GIQfDDibJvvJdr39RRChWOLplWn51+2LaSxHeDOWDiAOoM6Ehyvz2gPjvY/oEhXlWvjHoaImKbZKJDnAWLVmGhufLJ3/SbLR60JUYsq2oQPuGwkRKEKpX1XABtCbQgqqpW6KS8tzIb4kmQHqwcJVrHdaep98WuxM8GAXFFM0wBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=CtnrFBzY; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 577972C0308;
	Mon, 17 Mar 2025 09:11:29 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1742155889;
	bh=0mUmMxXCX1cpxTz2Mz/moHeklg4+C/Cf9N36sstH51o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=CtnrFBzY7nvQRscJKjC36bAmd4MtrqDTMnrLNexLtcatatVglzko9AWo5emD/MpEZ
	 2wENMKBTgHZwFQyFgRzQrrRAuLxWa9bzX6i/xvXypIYHW3Zsg3WmksbmQ5HrxRg+vi
	 d9CGhBoGaXI3lAZIV23R7ZdnrXX8shTAIhoRYgImwI3vFhMqBy9me2BbBLp06IBSQW
	 T1EsZPPJ+iSHV9l5SUxgtK5LxApbD+kX4TOYpmkww0Uy0bNi84MvHvccis76NyOIgH
	 wVg/MegkkHseqx8xbUMFg/1iYlBWViZ9Rf0is8Bh2OYmOTNfa6som2inCbOGMA7oc8
	 LvpS2OBkb48qw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67d730710001>; Mon, 17 Mar 2025 09:11:29 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 09:11:29 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Mon, 17 Mar 2025 09:11:29 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"sander@svanheule.net" <sander@svanheule.net>, "markus.stockhausen@gmx.de"
	<markus.stockhausen@gmx.de>, "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v11] net: mdio: Add RTL9300 MDIO driver
Thread-Topic: [PATCH net-next v11] net: mdio: Add RTL9300 MDIO driver
Thread-Index: AQHblHD+sucKWV4o3UuKUqKx7BHBP7Nx6AeAgAN0XAA=
Date: Sun, 16 Mar 2025 20:11:29 +0000
Message-ID: <d260e3d1-20e9-42f6-89b6-e646b8107bc0@alliedtelesis.co.nz>
References: <20250313233811.3280255-1-chris.packham@alliedtelesis.co.nz>
 <bd1d1cb9-a72b-484b-8cfd-7e91179391d2@lunn.ch>
In-Reply-To: <bd1d1cb9-a72b-484b-8cfd-7e91179391d2@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0A573F589DFBC45AC03290BDD6EFDCB@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Ko7u2nWN c=1 sm=1 tr=0 ts=67d73071 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=-mZtVxzNVz2t5w4VDjUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAxNS8wMy8yMDI1IDA0OjI2LCBBbmRyZXcgTHVubiB3cm90ZToNCj4+ICtzdGF0aWMgaW50
IHJ0bDkzMDBfbWRpb2J1c19wcm9iZV9vbmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcnRs
OTMwMF9tZGlvX3ByaXYgKnByaXYsDQo+PiArCQkJCSAgICAgc3RydWN0IGZ3bm9kZV9oYW5kbGUg
Km5vZGUpDQo+PiArew0KPj4gKwlzdHJ1Y3QgcnRsOTMwMF9tZGlvX2NoYW4gKmNoYW47DQo+PiAr
CXN0cnVjdCBmd25vZGVfaGFuZGxlICpjaGlsZDsNCj4+ICsJc3RydWN0IG1paV9idXMgKmJ1czsN
Cj4+ICsJdTMyIG1kaW9fYnVzOw0KPj4gKwlpbnQgZXJyOw0KPj4gKw0KPj4gKwllcnIgPSBmd25v
ZGVfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgInJlZyIsICZtZGlvX2J1cyk7DQo+PiArCWlmIChl
cnIpDQo+PiArCQlyZXR1cm4gZXJyOw0KPj4gKw0KPj4gKwkvKiBUaGUgTURJTyBpbnRlcmZhY2Vz
IGFyZSBlaXRoZXIgaW4gR1BIWSAoaS5lLiBjbGF1c2UgMjIpIG9yIDEwR1BIWQ0KPj4gKwkgKiBt
b2RlIChpLmUuIGNsYXVzZSA0NSkuDQo+IEkgc3RpbGwgbmVlZCBtb3JlIGNsYXJpZmljYXRpb24g
YWJvdXQgdGhpcy4gSXMgdGhpcyBzb2xlbHkgYWJvdXQgdGhlDQo+IHBvbGxpbmc/IE9yIGRvZXMg
YW4gaW50ZXJmYWNlIGluIEMyMiBtb2RlIGdvIGhvcnJpYmx5IHdyb25nIHdoZW4gYXNrZWQNCj4g
dG8gZG8gYSBDNDUgYnVzIHRyYW5zYWN0aW9uPw0KDQpJdCdzIGp1c3QgdGhlIHBvbGxpbmcuIEkg
aGF2ZW4ndCBzZWVuIGFueSBzaWduIG9mIHRoZSBidXMgZ2V0dGluZyBpbnRvIGEgDQpiYWQgc3Rh
dGUgd2hlbiB1c2luZyB0aGUgd3JvbmcgdHJhbnNhY3Rpb24gdHlwZS4NCg0KPj4gKwlidXMtPm5h
bWUgPSAiUmVhbHRlayBTd2l0Y2ggTURJTyBCdXMiOw0KPj4gKwlidXMtPnJlYWQgPSBydGw5MzAw
X21kaW9fcmVhZF9jMjI7DQo+PiArCWJ1cy0+d3JpdGUgPSBydGw5MzAwX21kaW9fd3JpdGVfYzIy
Ow0KPj4gKwlidXMtPnJlYWRfYzQ1ID0gcnRsOTMwMF9tZGlvX3JlYWRfYzQ1Ow0KPj4gKwlidXMt
PndyaXRlX2M0NSA9ICBydGw5MzAwX21kaW9fd3JpdGVfYzQ1Ow0KPiBZb3UgYXJlIHByb3ZpZGlu
ZyBDNDUgYnVzIG1ldGhvZHMsIGluZGVwZW5kZW50IG9mIHRoZSBpbnRlcmZhY2UNCj4gbW9kZS4g
U28gd2hlbiBhY2Nlc3NpbmcgRUVFIHJlZ2lzdGVycyBpbiBDNDUgYWRkcmVzcyBzcGFjZSwgQzQ1
IGJ1cw0KPiB0cmFuc2FjdGlvbnMgYXJlIGdvaW5nIHRvIGJlIHVzZWQsIGV2ZW4gb24gYW4gTURJ
TyBpbnRlcmZhY2UgdXNpbmcgQzIyDQo+IG1vZGUuIERvZXMgdGhpcyB3b3JrPyBDYW4geW91IGFj
dHVhbGx5IGRvIGJvdGggQzIyIGFuZCBDNDUgYnVzDQo+IHRyYW5zYWN0aW9ucyBpbmRlcGVuZGVu
dCBvZiB0aGUgaW50ZXJmYWNlIG1vZGU/DQpJJ20gbm90IGFjdHVhbGx5IHN1cmUgaWYgSSBjYW4g
bWl4IHRyYW5zYWN0aW9ucyBidXQgaXQgZG9lc24ndCBzZWVtIHRvIA0KZG8gYW55IGhhcm0uDQoN
CkluaXRpYWxseSBJIHBsYW5uZWQgdG8gb25seSBzdXBwbHkgb25lIG9mIHRoZSBmdW5jdGlvbiBw
YWlycyBkZXBlbmRpbmcgDQpvbiB0aGUgbW9kZSBidXQgSSBsZWZ0IHRoaXMgaW4gYmVjYXVzZSBv
ZiB0aGlzOg0KDQpodHRwczovL3dlYi5naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5l
bC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVycy9uZXQvcGh5L3BoeS5jI24zMzcN
Cg0KSSd2ZSB3cml0dGVuIG15c2VsZiBhIGxpdHRsZSB0ZXN0IGFwcCB0aGF0IHVzZXMgU0lPQ0dN
SUlSRUcvU0lPQ1NNSUlSRUcgDQp0byBleGVyY2lzZSB0aGUgTURJTyBhY2Nlc3Nlcy4gSXQgdXNl
cyBTSU9DR01JSVBIWSB0byBsb29rIHVwIHRoZSBNRElPIA0KYWRkcmVzcyBvZiB0aGUgUEhZIGF0
dGFjaGVkIHRvIHRoZSBuZXRkZXYgYnV0IGJlY2F1c2Ugb2YgdGhhdCANCmZhbGx0aHJvdWdoIGxv
b2tpbmcgdXAgdGhlIFBIWSBhZGRyZXNzIGZvciBhIEM0NSBQSFkgd2lsbCBmYWlsIHdpdGggDQot
RU9QTk9UU1VQUC4NCg0KSSd2ZSBzcXVpbnRlZCBhdCB0aGF0IGNvZGUgYW5kIGNhbid0IGRlY2lk
ZSBpZiBpdCdzIGEgYnVnIG9yIGludGVuZGVkLiANCkl0IHNlZW1zIHRvIGJlIHRoZXJlIHRvIHZh
bGlkYXRlIGlmIHRoZSBQSFkgaXMgYWN0dWFsbHkgcHJlc2VudCBhbmQgd2lsbCANCndvcmtzIGZv
ciBDMjIgYmVjYXVzZSBtaWlfZGF0YS0+cmVnX251bSB3aWxsIGNvbWUgdGhyb3VnaCB0aGUgaW9j
dGwgKG9yIA0KYmVjYXVzZSAwIGlzIGEgdmFsaWQgcmVnaXN0ZXIpIC4gSXQgd29uJ3Qgd29yayBm
b3IgQzQ1IGJlY2F1c2UgDQpTSU9DR01JSVBIWSBoYXMgbm8gd2F5IG9mIHN1cHBseWluZyB0aGUg
TU1EIGRldmljZS4NCg0KDQo+DQo+IAlBbmRyZXc=

