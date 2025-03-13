Return-Path: <netdev+bounces-174779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE322A604BD
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 836987A5E07
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4011F8922;
	Thu, 13 Mar 2025 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="s5lrVO8D"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD91F5821
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 22:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741906406; cv=none; b=JTHh2nFfCoakBpC5043lpNsIMKQFyPH0XWlZAZyuk47ZCrWmh1wz+ZCv+NRu7jp5Vm5VAyGEmOCT/+LvInKGz6alSQMscTAwuLwF7UXfReuKWD+GSD7Zqfl0lLDsIj4xJIBUfh68WndrjWoSM6ZboDexRJhm5AwgF5RnZPofcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741906406; c=relaxed/simple;
	bh=DI7iT4s8DR6UpR+PsTf1pe9iOHZdOcICaSSpD0kKwVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8DeYYfkLuRaGWpOeQWCU6BPDmRibucXpjbkGHn/edqOkq5o/a4eBievAdFm7AH7LHo/WNlrkD/P2QE1g2/KrhCQkZMyalWOEoGqkp6Z6u4F5tgZfVzq4KZLY5aR17eFgQUBf6vjM1Zs0ylj+xO7yqJFpd5FyYq2dMYN+rbLFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=s5lrVO8D; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 549A22C0375;
	Fri, 14 Mar 2025 11:53:21 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1741906401;
	bh=DI7iT4s8DR6UpR+PsTf1pe9iOHZdOcICaSSpD0kKwVs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=s5lrVO8DHABzSXINkyG5zSWGqNqPq4mH/6eXaEvizVbXlv0N3Hxad4LhTuYjXSTqe
	 XCf+kWoAghl5GMZtzL/3TpfaUrUgifUfz0dWZoeuKUhPJ4mxQ+qivZyh2FwnHGoQm0
	 4kEPJSAQY+lSiG1ECUdVNq/wNNKeVcj4RzXjQmaRCr5ZOQBxOP8Ua6p55rsEaOAv99
	 36fyk0x2A8NIQRmdGLL9wi57mqiKTbiBBA201mNPfsGAFN6Nwvn0iHGTN7lN9Zusr+
	 5riW9QrYJAox5tookjbVGyV7t618R5IDCI6g4G+YoerR73dzWSIl5jtNNRw/3xUIzI
	 fBXXiDypnC4kQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67d361e10001>; Fri, 14 Mar 2025 11:53:21 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 14 Mar 2025 11:53:21 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Fri, 14 Mar 2025 11:53:21 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "markus.stockhausen@gmx.de"
	<markus.stockhausen@gmx.de>, "sander@svanheule.net" <sander@svanheule.net>,
	netdev <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10] net: mdio: Add RTL9300 MDIO driver
Thread-Topic: [PATCH v10] net: mdio: Add RTL9300 MDIO driver
Thread-Index: AQHbk7RQMlEBwbSVuE+Te7ZjHwH5gbNwJygAgAB7A4CAAAtMgIAAAJ2AgAAA44CAAAEKAIAAF2aAgAAMsAA=
Date: Thu, 13 Mar 2025 22:53:20 +0000
Message-ID: <363bdb81-d26e-4f1a-969e-c5ee682cf044@alliedtelesis.co.nz>
References: <20250313010726.2181302-1-chris.packham@alliedtelesis.co.nz>
 <f7c7f28b-f2b0-464a-a621-d4b2f815d206@lunn.ch>
 <5ea333ec-c2e4-4715-8a44-0fd2c77a4f3c@alliedtelesis.co.nz>
 <be39bb63-446e-4c6a-9bb9-a823f0a482be@lunn.ch>
 <539762a3-b17d-415c-9316-66527bfc6219@alliedtelesis.co.nz>
 <6a98ba41-34ee-4493-b0ea-0c24d7e979b1@lunn.ch>
 <6ae8b7c6-8e75-4bfc-9ea3-302269a26951@alliedtelesis.co.nz>
 <f6165df5-eedb-4a11-add0-2ae4d4052d6a@lunn.ch>
In-Reply-To: <f6165df5-eedb-4a11-add0-2ae4d4052d6a@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EFF73A1567E854EAEEEE3C04ABE2FF1@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Ko7u2nWN c=1 sm=1 tr=0 ts=67d361e1 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=wcnP0_QFKWXw4tE0R6IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAxNC8wMy8yMDI1IDExOjA3LCBBbmRyZXcgTHVubiB3cm90ZToNCj4+IEknbSBwcmV0dHkg
c3VyZSBpdCB3b3VsZCB1cHNldCB0aGUgaGFyZHdhcmUgcG9sbGluZyBtZWNoYW5pc20gd2hpY2gN
Cj4+IHVuZm9ydHVuYXRlbHkgd2UgY2FuJ3QgZGlzYWJsZSAoZWFybGllciBJIHRob3VnaHQgd2Ug
Y291bGQgYnV0IHRoZXJlIGFyZQ0KPj4gdmFyaW91cyBzd2l0Y2ggZmVhdHVyZXMgdGhhdCByZWx5
IG9uIGl0KS4NCj4gU28gd2UgbmVlZCB0byBnZXQgYSBiZXR0ZXIgdW5kZXJzdGFuZGluZyBvZiB0
aGF0IHBvbGxpbmcuIEhvdyBhcmUgeW91DQo+IHRlbGxpbmcgaXQgYWJvdXQgdGhlIGFxdWFudGlh
IFBIWSBmZWF0dXJlcz8gSG93IGRvZXMgaXQga25vdyBpdCBuZWVkcw0KPiB0byBnZXQgdGhlIGN1
cnJlbnQgbGluayByYXRlIGZyb20gTURJT19NTURfQU4sIE1ESU9fQU5fVFhfVkVORF9TVEFUVVMx
DQo+IHdoaWNoIGlzIGEgdmVuZG9yIHJlZ2lzdGVyLCBub3QgYSBzdGFuZGFyZCBDNDUgcmVnaXN0
ZXI/IEhvdyBkbyB5b3UNCj4gdGVhY2ggaXQgdG8gZGVjb2RlIGJpdHMgaW4gdGhhdCByZWdpc3Rl
cj8NCg0KVGhlIGhhcmR3YXJlIHBvbGxpbmcgZm9yIEM0NSBQSFlzIGlzIHJlYXNvbmFibHkgY29u
ZmlndXJhYmxlIHNvIEkgdGhpbmsgDQp5b3UgY2FuIGRlZmluZSB3aGljaCBNTUQgZGV2aWNlL3Jl
Z2lzdGVyIHRvIGxvb2sgYXQgYW5kIHdoYXQgYml0IG1hc2tzIA0KdG8gYXBwbHkgdG8gZGV0ZXJt
aW5lIHRoZSBsaW5rIHN0YXR1cy4gSSB0aGluayB3aGVuIHdlIGdldCB0byBhIGNvbXBsZXRlIA0K
c3dpdGNoIGRyaXZlciAoaG9waW5nIGZvciBzd2l0Y2hkZXYgYnV0IGNvdWxkIGJlIGRzYSkgaXQg
bWF5IG5lZWQgdG8gDQprbm93IHNvbWUgZGV0YWlscyBhYm91dCB0aGUgc3BlY2lmaWMgUEhZIHRo
YXQgaXMgYXR0YWNoZWQgYW5kIGhhdmUgc29tZSANCndheSBvZiB0ZWxsaW5nIHRoZSBtZGlvIGNv
bnRyb2xsZXIgYWJvdXQgdGhpcy4NCg0KUmlnaHQgbm93IEknbSBmb2N1c2luZyBvbiBhIHBsYXRm
b3JtIHRoYXQgaXMgUlRMOTMwMCArIFJUTDgyMjQgKGNsYXVzZSANCjQ1KSBzbyB0aGUgZGVmYXVs
dHMgbW9zdGx5IGp1c3Qgd29yay4gSSBkbyBoYXZlIG9uZSBvZiB0aGUgWnl4ZWwgYm9hcmRzIA0K
d2l0aCBhbiBBUVIgUEhZIGJ1dCBoYXZlbid0IGJlZW4gYWJsZSB0byByb290IGl0IHlldCAoTWFy
a3VzIGdhdmUgbWUgDQpzb21lIHRpcHMgZm9yIHRoYXQganVzdCBoYXZlbid0IHRyaWVkIHRoZW0g
eWV0KS4NCg==

