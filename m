Return-Path: <netdev+bounces-147086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782AC9D784B
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 22:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0C2162CC8
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 21:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2298F13D52B;
	Sun, 24 Nov 2024 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0sreF3vB"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306E558BA
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732483402; cv=none; b=hT+IgfO5YUjEFfMnXx9qsm587LGazYw0bRofJr6Qe+eUf7W9XxMeviSbx2s0Scl7uUofPWOuaeOjpJC3RIk5tAKf3sUKO9XgyHK8RSL7DGM9e2C28zwTj/hf87qVd3zgtxWcIMpGTB+RrqzL9u4OqIOpSeAo17RKAtYuhf2FrzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732483402; c=relaxed/simple;
	bh=4e6MPzgtJsRDKZgBnv8M2opvpBvfQiqs64JOtuAYc9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZdOSu9LGdMT9M3PMjso9wc0jMzgO8BgrXp1rlRrb1imFN/TF5mW0Dyrcuw7OxiRcbTz5afWsUqu69hII4oyi165tgkKS95QeWmWKquTRFrfRjObv+nF7rNJgKUYqbZzKB/wb0zEmgcJbIFR2kEMC61j5v/9W15UzCEQt1mFQRuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=0sreF3vB; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7DA192C045C;
	Mon, 25 Nov 2024 10:23:17 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1732483397;
	bh=4e6MPzgtJsRDKZgBnv8M2opvpBvfQiqs64JOtuAYc9A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=0sreF3vBwJrCqwjfhnioLObdzsHzcuBAqdrlYs0SlJE8rDGt/EvNJbsm7LJsBnYxL
	 j3ga2Zk2YfNqzlAYbdonzunFONQNAe48rWVpRhHWC9y1f41sh4/pv55MOm7bHmoFDW
	 4EoiGJJ91oVlTmSsXeFdl2dthrgy/leTE8OUVs5kRlyzEFI43p09PVZBBpZ6HaQPn1
	 4XDAnSmyE0ZGGQ8c8bVomBTZkbFWyuh9AckKKdAlfqaxuDgYSoqgUIxOuTM/7oYxKu
	 bpuKEhxYZ/QZIj2UawcsMG+leJGx8+qCA3IgIIW2+bqdGqJacRXyWiK92uKkXk9ahN
	 RS7ChqtLrWY0w==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B674399450001>; Mon, 25 Nov 2024 10:23:17 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Nov 2024 10:23:17 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Mon, 25 Nov 2024 10:23:17 +1300
From: Elliot Ayrey <Elliot.Ayrey@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"razor@blackwall.org" <razor@blackwall.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "roopa@nvidia.com" <roopa@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bridge@lists.linux.dev" <bridge@lists.linux.dev>
Subject: Re: [RFC net-next (resend) 2/4] net: bridge: send notification for
 roaming hosts
Thread-Topic: [RFC net-next (resend) 2/4] net: bridge: send notification for
 roaming hosts
Thread-Index: AQHbMZIZlVCrlxg6kUq3+Q+3FOi2grLGMRQA
Date: Sun, 24 Nov 2024 21:23:17 +0000
Message-ID: <e562704277f5d64a37ea67789b8e7d13d2cb12a4.camel@alliedtelesis.co.nz>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
	 <20241108035546.2055996-3-elliot.ayrey@alliedtelesis.co.nz>
In-Reply-To: <20241108035546.2055996-3-elliot.ayrey@alliedtelesis.co.nz>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5B4FE4F8FF2354DB977C4CC45D591B8@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gam0nhXL c=1 sm=1 tr=0 ts=67439945 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=nyesw9g_oEEA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=czF_dnlavrRpCoVLzgYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gU2F0LCAyMDI0LTExLTA5IGF0IDE1OjQwICswMjAwLCBOaWtvbGF5IEFsZWtzYW5kcm92IHdy
b3RlOg0KPiBObyB3YXksIHRoaXMgaXMgcmlkaWN1bG91cy4gQ2hhbmdpbmcgdGhlIHBvcnQgbGlr
ZSB0aGF0IGZvciBhIG5vdGlmaWNhdGlvbiBpcyBub3QNCj4gb2sgYXQgYWxsLiBJdCBpcyBhbHNv
IG5vdCB0aGUgYnJpZGdlJ3Mgam9iIHRvIG5vdGlmeSB1c2VyLXNwYWNlIGZvciBzdGlja3kgZmRi
cw0KPiB0aGF0IGFyZSB0cnlpbmcgdG8gcm9hbSwgeW91IGFscmVhZHkgaGF2ZSBzb21lIHVzZXIt
c3BhY2UgYXBwIGFuZCB5b3UgY2FuIGNhdGNoDQo+IHN1Y2ggZmRicyBieSBvdGhlciBtZWFucyAo
c25pZmZpbmcsIGVicGYgaG9va3MsIG5ldGZpbHRlciBtYXRjaGluZyBldGMpLiBTdWNoDQo+IGNo
YW5nZSBjYW4gYWxzbyBsZWFkIHRvIEREb1MgYXR0YWNrcyB3aXRoIG1hbnkgbm90aWZpY2F0aW9u
cy4NCg0KVW5mb3J0dW5hdGVseSBpbiB0aGlzIGNhc2UgdGhlIG9ubHkgaW5kaWNhdGlvbiB3ZSBn
ZXQgZnJvbSB0aGUgaGFyZHdhcmUgb2YgdGhpcw0KZXZlbnQgaGFwcGVuaW5nIGlzIGEgc3dpdGNo
ZGV2IG5vdGlmaWNhdGlvbiB0byB0aGUgYnJpZGdlLiBBbGwgdHJhZmZpYyBpcyBkcm9wcGVkDQpp
biBoYXJkd2FyZSB3aGVuIHRoZSBwb3J0IGlzIGluIHRoaXMgbW9kZSBzbyB0aGUgbWV0aG9kcyB5
b3Ugc3VnZ2VzdCB3aWxsIG5vdCB3b3JrLg0KDQpJIGhhdmUgY2hhbmdlZCBteSBpbXBsZW1lbnRh
dGlvbiB0byB1c2UgQW5kcmV3J3Mgc3VnZ2VzdGlvbiBvZiB1c2luZyBhIG5ldyBhdHRyaWJ1dGUN
CnJhdGhlciB0aGFuIG1lc3Npbmcgd2l0aCB0aGUgcG9ydC4gQnV0IHdvdWxkIHRoaXMgYWxzbyBi
ZSBtb3JlIGFwcHJvcHJpYXRlIGlmIHRoZQ0Kbm90aWZpY2F0aW9uIHdhcyBvbmx5IHRyaWdnZXJl
ZCB3aGVuIHJlY2VpdmluZyB0aGUgZXZlbnQgZnJvbSBoYXJkd2FyZT8gSWYgbm90DQp0aGVuIGRv
IHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyBmb3IgZ2V0dGluZyB0aGVzZSBraW5kcyBvZiBldmVu
dHMgZnJvbSBoYXJkd2FyZQ0KdG8gdXNlcnNwYWNlIHdpdGhvdXQgZ29pbmcgdGhyb3VnaCB0aGUg
YnJpZGdlPw0KDQoNCg==

