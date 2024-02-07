Return-Path: <netdev+bounces-70017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D804F84D5A5
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCB1B28E19
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D0E6BFB6;
	Wed,  7 Feb 2024 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="sqre3xCQ"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AED535BB
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343546; cv=none; b=bs/NraFI3S5FuFG0JaC9gDQXYngTGBtsgKhRWcmp2Tou8peKOTCezMvis8j7Rxm+c53IdhFeQzPjSOiWgS2lAfwv6iwg7VocYIj8WwoJSZhTY31mOl3ViciJOlCZan18Gh1sLGU2kxlEwL9BUCIQxoeePxuw9coEtuM+G0OhhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343546; c=relaxed/simple;
	bh=9AUxqsjYp21nVVo7TSlTfghqeIXfMOGAwOz+WexpO1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pjeXeMnPczZGSamktFReSbsCjio2Ih9z83EIQBPZGMY6lsPPKLNAxCPQwMLcM0kjvqProdqFTF1LUFHWr7QxL3DY2+txSzMtnQ6qNeQ1s9Wy0p11LSj2BGbwG/d0WsJwcnxLgZfBEvF2wBR+1MitA7yRJOVxIrYgs5mfEzWkxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=sqre3xCQ; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 31BB82C0230;
	Thu,  8 Feb 2024 11:05:36 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1707343536;
	bh=9AUxqsjYp21nVVo7TSlTfghqeIXfMOGAwOz+WexpO1E=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=sqre3xCQXZsGtHLRgtU1j7FBYvOmnVxLquG2Om+XM+cgFhjA/WpPIqHdceprBTjBb
	 mpL9T/jrsbF5gS5+7eeuOGoVyqIgZmNc/62s+2cYpdbzMZzWh+S4TIDHHZXq68SDcv
	 RVhY6ZYzkfMWjlNzPLKcTZTeJ5nzCq/lzCt+J1jv2jMaqwfCSsvaO2h/WI01RVnftL
	 NBGilbIKyrcGLDbb/dD5nmK/jO81GejscgPvtgcvQ2Qggt5B9hrM9bp/UWD6icI6Lx
	 ReGt2bRh8kSwfjXQ5OSy02KPJaW4/BYz7H3390EcB5EL+BEQfjvV2A6AgZaT11H3yc
	 wH7VjcMmh6C7w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65c3feb00001>; Thu, 08 Feb 2024 11:05:36 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 11:05:35 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Thu, 8 Feb 2024 11:05:35 +1300
From: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>
To: "jansaley@gmail.com" <jansaley@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "a@unstable.cc" <a@unstable.cc>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [BUG] gre interface incorrectly generates link-local addresses
Thread-Topic: [BUG] gre interface incorrectly generates link-local addresses
Thread-Index: AQHaVCrRZ+x1H873S0iWHD4uCDBUpbD+oQUA
Date: Wed, 7 Feb 2024 22:05:35 +0000
Message-ID: <4af69c165836c2e22217341c4a64228bcd43a877.camel@alliedtelesis.co.nz>
References: <AS2PR09MB6293D2C85ABD5029AB9C69DAF37C2@AS2PR09MB6293.eurprd09.prod.outlook.com>
In-Reply-To: <AS2PR09MB6293D2C85ABD5029AB9C69DAF37C2@AS2PR09MB6293.eurprd09.prod.outlook.com>
Accept-Language: en-GB, en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <8980564157A9E341B99EB452D29E4F1F@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=CP-8VDb144vVogvyZAUA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGVsbG8sDQoNCk9uIEZyaSwgMjAyNC0wMi0wMiBhdCAxMzowMSArMDAwMCwg0JDQvdGC0LDRgNC4
0L4g0J/RgNC+0YHQv9C10YDQviB3cm90ZToNCj4gSGVsbA0KPiBJIHdhbnQgdG8gYnJpbmcgdXAg
dGhpcyB0b3BpYyBhZ2Fpbg0KPiBJcyBpdCBwb3NzaWJsZSB0byB1c2UgdGhlIGFkZHJfZ2VuX21v
ZGUgcGFyYW1ldGVyIGZvciBHUkUgaW4gdGhlDQo+IGN1cnJlbnQgdmVyc2lvbiBvZiBhZGRyY29u
Zj8NCg0KU2hvcnQgYW5zd2VyLCBuby4NCg0KPiBUaGVyZSB3YXMgYW4gZWRpdCBpbiB0aGUgZTVk
ZDcyOTQ2MGNhIGNvbW1pdCB0aGF0IGRldi0+aW50ZXJmYWNlIHR5cGUNCj4gc2hvdWxkIGJlIGVx
dWFsIHRvIEFSUEhSRF9FVEhFUiwgdGhlbiBhZGRyY29uZl9hZGRyX2dlbiB3aWxsIGJlDQo+IGNh
bGxlZC4NCj4gQnV0IGRvZXNuJ3QgdGhpcyBjb250cmFkaWN0IHRoZSBmYWN0IHRoYXQgYmVmb3Jl
IGNhbGxpbmcgdGhlDQo+IGFkZHJjb25mX2dyZV9jb25maWcgZnVuY3Rpb24sIHRoZXJlIGlzIGEg
Y2hlY2sgdGhhdCBkZXYtPnR5cGUgc2hvdWxkDQo+IGJlIGVxdWFsIHRvIEFSUEhSRF9JUEdSRSBv
ciBBUlBIUkRfSVA2R1JFPw0KDQpDb21taXQgZTVkZDcyOTQ2MGNhIGJyb2tlIHRoZSBhZGRyY29u
Zl9hZGRyX2dlbiBzeXNjdGwgdmFsdWUgZ2VuZXJhdGluZw0KYSBsaW5rIGxvY2FsIGFkZHJlc3Mg
Zm9yIEdSRSB0dW5uZWxzIHdoaWNoIG91ciB1c2Vyc3BhY2Ugd2FzIHJlbHlpbmcNCm9uLiBNeSBj
b21taXRzIDMwZTIyOTFmNjFmOSBhbmQgMjNjYTBjMmM5MzQwIGF0dGVtcHRlZCB0byByZXNvbHZl
IHRoaXMNCmJ5IG1ha2luZyBhZGRyY29uZl9ncmVfY29uZmlnIGdldCBjYWxsZWQNCmJ5IGFkZHJj
b25mX3N5c2N0bF9hZGRyX2dlbl9tb2RlIHdpdGggdGhlIG5ldw0KZnVuY3Rpb24gYWRkcmNvbmZf
aW5pdF9hdXRvX2FkZHJzIHdoaWNoIHdpbGwgY2FsbCBhZGRyY29uZl9ncmVfY29uZmlnLg0KDQpJ
IHRyaWVkIHRvIGtlZXAgdGhlIG5ldyBmdW5jdGlvbmFsaXR5IGZyb20gZTVkZDcyOTQ2MGNhIGlu
dGFjdCBzbw0KYWRkcmNvbmZfYWRkcl9nZW4gaXMgc3RpbGwgY2FsbGVkIG9ubHkgd2hlbiBkZXYt
PnR5cGUgPT0gQVJQSFJEX0VUSEVSDQp3aGljaCBtZWFucyB0aGF0IHRoZSB0eXBlIG9mIGFkZHJl
c3MgZ2VuZXJhdGlvbg0KKGVnIElONl9BRERSX0dFTl9NT0RFX1JBTkRPTSBvciBJTjZfQUREUl9H
RU5fTU9ERV9FVUk2NCkgaXMgbm90IG5vdA0KY29uc2lkZXJlZCB3aGVuIHRoZSB0eXBlIGlzIEFS
UEhSRF9JUEdSRSBvciBBUlBIUkRfSVA2R1JFIGluc3RlYWQgdGhlDQphZGRyZXNzIHdpbGwgYmUg
Z2VuZXJhdGVkIGJhc2VkIG9uIGFub3RoZXIgaW50ZXJmYWNlIHdpdGggYWRkX3Y0X2FkZHJzLg0K

