Return-Path: <netdev+bounces-147088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F9F9D7859
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 22:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AA9162D05
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 21:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0316514F104;
	Sun, 24 Nov 2024 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ixkXvJ+C"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051E13A244
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 21:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732483926; cv=none; b=SKKKf8epMDk0hshwTufAeFMIeaKnI3oEkK59GlKOijQeJUg1e6izkI90bgwVMsuKsn4gO4eIwF4PkrXAyeSDaGwUXnolX2m5w1UAhoUVeeaWSY3zlQeZRVeD2sXHfh+G0TMqjtt6BeL4oyvy1EfDbmM0Y+AFgjT/Px3L+lFrVVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732483926; c=relaxed/simple;
	bh=lzYbUU/ushxXoHai7Sd104iHMLbEkoYoTmMEcAIko0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mhCJSBpd/Hk6ctSxc+8zVJa0Q+nB/9O5dH+AP1KVsru3EEHeu6joarhRe1iP4enUwFLwnoD8Ly1eTlmXCndoiaF8+t3juTli/yI28aCMlusB2OuZKkNMIyJL3qQ5/P23v2ArPsLVskyReWhlAFaPFTEuf0FbYSziH41aBkjdN9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ixkXvJ+C; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 925532C045C;
	Mon, 25 Nov 2024 10:32:02 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1732483922;
	bh=lzYbUU/ushxXoHai7Sd104iHMLbEkoYoTmMEcAIko0k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ixkXvJ+C5b8d0TJ9t5nxwC6K83nGf/sB4xhdXaPvV37+fkPX9QZsz1/xBzS2fa8oE
	 xGhHCZij4zNBEUGjeDmRPSMBNTEUyGHizOl0wBr2t6aF441I7aoUVaw4FyXsqcvYqH
	 ElJPr+aqbi6EhG3r6+VNcOfazpsZi2fi6sUwxog2h7IelQzWPGMj6vRvsVkkI8CvAS
	 RoaH52Fsk/br7hMyIal9LF4YiWi921ENybmekKjFBMBDEqhk2I3W9xtbaL1momV+A7
	 lRJxtwAh9cGFfqNZPxwJx0FmuVmpf7zT4mikkjnDfto67xJOA2bm6Ba3UbrlKCeVKG
	 YNWnWHcdPVi1w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67439b520001>; Mon, 25 Nov 2024 10:32:02 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Nov 2024 10:32:02 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Mon, 25 Nov 2024 10:32:02 +1300
From: Elliot Ayrey <Elliot.Ayrey@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "razor@blackwall.org" <razor@blackwall.org>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "bridge@lists.linux.dev" <bridge@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"roopa@nvidia.com" <roopa@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [RFC net-next (resend) 2/4] net: bridge: send notification for
 roaming hosts
Thread-Topic: [RFC net-next (resend) 2/4] net: bridge: send notification for
 roaming hosts
Thread-Index: AQHbMZIZlVCrlxg6kUq3+Q+3FOi2grKsivwAgBmoioA=
Date: Sun, 24 Nov 2024 21:32:02 +0000
Message-ID: <2a3e262f4aec34001f321916f232b62f6dd10f2c.camel@alliedtelesis.co.nz>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
	 <20241108035546.2055996-3-elliot.ayrey@alliedtelesis.co.nz>
	 <93e02466-b4a0-48fd-beb0-c93b1008ff08@lunn.ch>
In-Reply-To: <93e02466-b4a0-48fd-beb0-c93b1008ff08@lunn.ch>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D7988C3FD0B074DAEA83F431C72BA4C@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gam0nhXL c=1 sm=1 tr=0 ts=67439b52 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=nyesw9g_oEEA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=Ug6YLRTtm5M4TX1eZZ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gRnJpLCAyMDI0LTExLTA4IGF0IDE0OjQyICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
VGhpcyBzb3VuZHMgYSBiaXQgaGFja3kuIENvdWxkIHlvdSBhZGQgYSBuZXcgb3B0aW9uYWwgYXR0
cmlidXRlIHRvIHRoZQ0KPiBuZXRsaW5rIG1lc3NhZ2UgaW5kaWNhdGluZyB0aGUgcm9hbSBkZXN0
aW5hdGlvbiwgc28gdGhlcmUgaXMgbm8gbmVlZA0KPiB0byBwbGF5IGdhbWVzIHdpdGggdGhlIGFj
dHVhbCBwb3J0Pw0KDQpZZXMgdGhhdCdzIGFub3RoZXIgb3B0aW9uLg0KDQo+IEknbSBub3QgdG9v
IGRlZXAgaW50byBob3cgdGhlc2UgYWxsIHdvcmtzLCBidXQgaSBhbHNvIHdvdW5kZXIgYWJvdXQN
Cj4gYmFja3dhcmRzIGNvbXBhdGliaWxpdHkuIE9sZCBjb2RlIHdoaWNoIGRvZXMgbm90IGxvb2sg
Zm9yDQo+IEZEQl9OT1RJRllfUk9BTUlOR19CSVQgaXMgZ29pbmcgdG8gdGhpbmsgaXQgcmVhbGx5
IGhhcyBtb3ZlZCwgd2l0aA0KPiB5b3VyIGNvZGUuIEJ5IHVzaW5nIGEgbmV3IGF0dHJpYnV0ZSwg
YW5kIG5vdCBjaGFuZ2luZyB0aGUgcG9ydCwgb2xkDQo+IGNvZGUganVzdCBzZWVzIGEgbm90aWZp
Y2F0aW9uIGl0IGlzIG9uIHRoZSBwb3J0IGl0IGFsd2F5cyB3YXMgb24sDQo+IHdoaWNoIGlzIGxl
c3MgbGlrZWx5IHRvIGNhdXNlIGlzc3Vlcz8NCg0KVGhhbmtzIHRoYXQncyBhIGdvb2QgcG9pbnQu
IEknbGwgaGF2ZSBhIGxvb2sgYXQgbWFraW5nIGl0IGFuIGF0dHJpYnV0ZQ0KaW5zdGVhZC4NCg0K
PiBBbmQgZG8gd2Ugd2FudCB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gaXQgd2FudHMgdG8gcm9h
bSwgYnV0IHRoZQ0KPiBzdGlja3kgYml0IGhhcyBzdG9wcGVkIHRoYXQsIGFuZCBpdCByZWFsbHkg
aGFzIHJvYW1lZD8NCg0KVGhhdCBpcyBwYXJ0bHkgd2hhdCB0aGlzIHBhdGNoIGlzIHRyeWluZyB0
byBkbywgc2luY2UgYWN0dWFsbHkgcm9hbWluZw0KaG9zdHMgd2lsbCBhbHJlYWR5IHRyaWdnZXIg
YSBub3RpZmljYXRpb24gd2l0aCB0aGUgbmV3IHBvcnQuDQoNCkkgd2lsbCB0cnkgeW91ciBzdWdn
ZXN0aW9uIGFzIGl0IHNlZW1zIGJldHRlciB0aGFuIHdoYXQgSSBoYXZlIGhlcmUuIEkNCmFsc28g
dGhpbmsgbW92aW5nIGF3YXkgZnJvbSByZWx5aW5nIG9uIHRoZSBzdGlja3kgYml0IG1pZ2h0IGJl
IGdvb2QuDQpUaGlzIGJlaGF2aW91ciByZWxpZXMgb24gdGhlIHBvcnQgYmVpbmcgbG9ja2VkIGlu
IGhhcmR3YXJlIHNvIGl0IG1pZ2h0DQpiZSBtb3JlIGFwcHJvcHJpYXRlIGZvciB0aGlzIHRvIGJl
IHBhcnQgb2YgbG9ja2VkIGJlaGF2aW91ciBpbiB0aGUNCmtlcm5lbCBhbHNvPw0KDQo=

