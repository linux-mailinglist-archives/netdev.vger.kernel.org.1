Return-Path: <netdev+bounces-161037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DADEFA1CEFF
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 23:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412FD166650
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 22:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DA67FBA2;
	Sun, 26 Jan 2025 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="VKXs/W+a"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9FC7081B
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737929258; cv=none; b=IcfC1+egM6vaV4n49GImWvRwxHdJBO5LZUxBe1TrcByTsTCUCLRfeKWfWs8Li15TPAXgwp7CCIfXcdnnH3HtgeIOXXpP/ae+2IepE2tavxs5X8iY2MamjO9UjlyjjNTMGLoK2FmqBwOLh2bfOzuFVXQh0YaxWtRXoJwTfgVSgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737929258; c=relaxed/simple;
	bh=umhorqtWCx5g4nlfJdHUqoe/RN5Us/QMYHDcz4oZ5XA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E5QheBYR1QPvDgSlZHkJOaiRGxIlFdwK1vIqUqANbjfMMzAsdj9KePUc6SLNlO8OzzehWlaBre4McT2vFjm37Qc85JkGLtXgzwsqricGRl2hWlHQIIWt8oy3my66dhYI0Evx73ZmMXLcaxTMleQT+mSzwH1kIZD5sQHylU61qzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=VKXs/W+a; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B411B2C03C9;
	Mon, 27 Jan 2025 11:07:26 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1737929246;
	bh=umhorqtWCx5g4nlfJdHUqoe/RN5Us/QMYHDcz4oZ5XA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=VKXs/W+aefV8OZM0uxrnFDSxWic/ds/TJsHMq6kFEd/D0YbOmdcQHwmbMFohsilp7
	 p/rqj+EWR5ZO5fZbbvJPb34KTW0wut/sBIZGY8776unQoUmV8ZmUuUEwcvems3TcKW
	 fYxCeagTfEkUWbjvdloUzuOTrEopo5BOfR292zsMe5+5Vm5irwBaBHdTmUI4FhPem1
	 sLnELAuiJQMxzxM9/gZ1Lt6CWURroxH0kxn2SpoxG29Di4O961cYdc+Aw0HaudW/hu
	 /xpAsp4Cci30sRve45zJ+8wczY2hrFxd7/U6ofZcwrPM46GWxwFDcNStQl3YEmpoFn
	 +31mU0be7sNAg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6796b21e0001>; Mon, 27 Jan 2025 11:07:26 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 27 Jan 2025 11:07:26 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.014; Mon, 27 Jan 2025 11:07:26 +1300
From: Elliot Ayrey <Elliot.Ayrey@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "netdev@kapio-technology.com"
	<netdev@kapio-technology.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix switchdev error code
Thread-Topic: [PATCH net] net: dsa: mv88e6xxx: Fix switchdev error code
Thread-Index: AQHbUD2xtG1ydR8I70mlF9+2IGd6KLLpWQeAgD+p7QA=
Date: Sun, 26 Jan 2025 22:07:26 +0000
Message-ID: <e546520005bfbdb09e66d7b9e823af1da796aae6.camel@alliedtelesis.co.nz>
References: <20241217043930.260536-1-elliot.ayrey@alliedtelesis.co.nz>
	 <ab85afaf-bd9d-416a-b54c-9c85062f3f3f@lunn.ch>
In-Reply-To: <ab85afaf-bd9d-416a-b54c-9c85062f3f3f@lunn.ch>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <0918241C8F407B4C82EE133986927683@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=6796b21e a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=nyesw9g_oEEA:10 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=674jiRR37RwTShUqOsAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gVHVlLCAyMDI0LTEyLTE3IGF0IDEwOjU0ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
SSBqdXN0IGhhZCBhIHF1aWNrIGxvb2sgYXQgb3RoZXIgdXNlcnMgb2YgY2FsbF9zd2l0Y2hkZXZf
bm90aWZpZXJzKCkNCj4gYW5kIGFsbCBidXQgdnhsYW5fY29yZS5jIGFuZCB0aGlzIG9uZSBkaXNj
YXJkZWQgdGhlIHJldHVybg0KPiB2YWx1ZS4gV291bGQgdGhhdCBiZSBhIGJldHRlciBmaXgsIG1h
a2luZyB0aGUgY29kZSBtb3JlIHVuaWZvcm0/DQo+IA0KPiAJQW5kcmV3DQoNCkhpIEFuZHJldywg
SSBhbSBoZXNpdGFudCB0byByZW1vdmUgdGhpcyBlcnJvciBhcyBpdCB3YXMgdmVyeSBoZWxwZnVs
DQpkdXJpbmcgZGV2ZWxvcG1lbnQgYW5kIGhlbHBlZCB0byBkaWFnbm9zZSBzb21lIHN1YnRsZSBp
c3N1ZXMgdGhhdCB3b3VsZA0KaGF2ZSBvdGhlcndpc2UgYmVlbiB2ZXJ5IGhhcmQgdG8gbm90aWNl
Lg0K

