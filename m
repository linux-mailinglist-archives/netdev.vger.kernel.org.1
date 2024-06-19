Return-Path: <netdev+bounces-105078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DACD390F9B6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 01:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BFCB22098
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 23:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6A015B140;
	Wed, 19 Jun 2024 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="LKYSyWHU"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9515ADA4
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718839058; cv=none; b=QkKSlQwICoWxFJcZVfV6VovL+at6mMrQTnKco424oLWR9dPuMKyRntj7opzdn3TxnJpd1nfDIlyBPKchF9RL4m4H2CPL1LpgPoBCwpkiNjq7rveY3njtGPfsJNH5JUCV+fH05X+8ZSMr9Xlo0MMnazfxBszooqOvU/pUIdxccJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718839058; c=relaxed/simple;
	bh=/hoDkYheQkVDO56Am39e7Iec+lksxqdmJe6cBSua6/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tY9Qicil9zGrIpS8K3t6I6GXRfyyqV9fpO1tcwspGMtA1uqDfo6qyQ9zOY24QeZcaobnAAMkogNfRh3Ffhk+/LtTW8VG/qBSsrVZK4Ab/VBIlb+Wii3kCKAKP3kkDtCakqMfVd4aVUA15k2esVD8U53ebcOx8+FuwjU7z3iPnFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=LKYSyWHU; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 70C6E2C0358;
	Thu, 20 Jun 2024 11:17:27 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1718839047;
	bh=/hoDkYheQkVDO56Am39e7Iec+lksxqdmJe6cBSua6/Q=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=LKYSyWHUcxEq/VJ3KH33yV62981KVdBv+/2zDISuOyYCFEFWDHpiWX5lTpd0YDKfG
	 89ZEcfnOBcfotURqWd7wlsjqyD8PWliRg4BVGGvv2k1+SpggHudSCIHpzkNheYUg1n
	 SGh0vpnnU+i52p0YyjifaFkwM2ftQ4xlWv1biNBKFxaTMMJ+7PbZeijqakwaEYwihn
	 3ngtIEYkOOic4TrDgUYwJfdSR7KkIVgMV16blYhq2GG2m+oKhrLWFrx2RDZH9iar+k
	 2tnMVcfQkC04vNYKzf5U20jiK+3DinONIw4VAE2FrXuvr6VyiyS/ij+s+X9D+/jISh
	 GLI4kVzqYY6yg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B667367070001>; Thu, 20 Jun 2024 11:17:27 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1544.11; Thu, 20 Jun 2024 11:17:27 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Thu, 20 Jun 2024 11:17:26 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Thu, 20 Jun 2024 11:17:26 +1200
From: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v0] net: dsa: mv88e6xxx: Add FID map cache
Thread-Topic: [PATCH v0] net: dsa: mv88e6xxx: Add FID map cache
Thread-Index: AQHauvQhmGVs7ltcskSdPWkCQQQ/GrHAIwsAgA7blAA=
Date: Wed, 19 Jun 2024 23:17:26 +0000
Message-ID: <a79192718fad9e85bf336c7a6c8864c523456033.camel@alliedtelesis.co.nz>
References: <20240610050724.2439780-1-aryan.srivastava@alliedtelesis.co.nz>
	 <e850b74d-fac6-4680-b9d0-fc2c3e1aa848@lunn.ch>
In-Reply-To: <e850b74d-fac6-4680-b9d0-fc2c3e1aa848@lunn.ch>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <08AD3E1E2C3498468356D3A681CD15A0@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=66736707 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=w1vUsAckAk8A:10 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=5_Qu5RKfSxMH2C3omnkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgQW5kcmV3LA0KT24gTW9uLCAyMDI0LTA2LTEwIGF0IDE0OjIzICswMjAwLCBBbmRyZXcgTHVu
biB3cm90ZToNCj4gT24gTW9uLCBKdW4gMTAsIDIwMjQgYXQgMDU6MDc6MjNQTSArMTIwMCwgQXJ5
YW4gU3JpdmFzdGF2YSB3cm90ZToNCj4gPiBBZGQgYSBjYWNoZWQgRklEIGJpdG1hcC4gVGhpcyBt
aXRpZ2F0ZXMgdGhlIG5lZWQgdG8NCj4gPiB3YWxrIGFsbCBWVFUgZW50cmllcyB0byBmaW5kIHRo
ZSBuZXh0IGZyZWUgRklELg0KPiA+IA0KPiA+IFdhbGsgVlRVIG9uY2UsIHRoZW4gc3RvcmUgcmVh
ZCBGSUQgbWFwIGludG8gYml0bWFwLiBVc2UNCj4gPiBhbmQgbWFuaXB1bGF0ZSB0aGlzIGJpdG1h
cCBmcm9tIG5vdyBvbiwgaW5zdGVhZCBvZiByZS1yZWFkaW5nDQo+ID4gSFcgZm9yIHRoZSBGSUQg
bWFwLg0KPiA+IA0KPiA+IFRoZSByZXBlYXRlZGx5IFZUVSB3YWxrcyBhcmUgY29zdGx5IGNhbiBy
ZXN1bHQgaW4gdGFraW5nIH40MCBtaW5zDQo+ID4gaWYgfjQwMDAgdmxhbnMgYXJlIGFkZGVkLiBD
YWNoaW5nIHRoZSBGSUQgbWFwIHJlZHVjZXMgdGhpcyB0aW1lDQo+ID4gdG8gPDIgbWlucy4NCj4g
DQo+IEhvdyBsb25nIGRvZXMgdGhlIGZpcnN0IHdhbGsgdGFrZT8gUmF0aGVyIHRoYW4gaGF2aW5n
IGZpZF9wb3B1bGF0ZWQsDQo+IGkNCj4gd291bmRlciBpZiB0aGUgd2FsayBzaG91bGQganVzdCBi
ZSBkb25lIGluIG12ODhlNnh4eF92dHVfc2V0dXAoKSBvcg0KPiBtdjg4ZTZ4eHhfYXR1X3NldHVw
KCkuDQo+IA0KPiDCoMKgwqDCoMKgwqDCoMKgQW5kcmV3DQpJIGFncmVlLCB3aWxsIGltcGxlbWVu
dCB0aGlzLiBUaGUgZmlyc3Qgd2FsayBkb2VzIG5vdCB0YWtlIGxvbmcsIGJ1dA0Kd291bGQgYmUg
YmV0dGVyIHNlcnZlZCBpbiB0aGUgc2V0dXAuDQoNClRoYW5rcywNCkFyeWFuLg0K

