Return-Path: <netdev+bounces-147085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1329D782D
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 22:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EA72817ED
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 21:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10D113FD72;
	Sun, 24 Nov 2024 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="kAV3pBeW"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B012B17C
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732482119; cv=none; b=O50NFN8DZqvHxaaYQ0ew2ZsCBgBpzk/oZ+CBMY5zKH9J2FoADryzBgynuDbxewAhMKcBx7qnO3WA5AXQBMxDlB3r/CuG1oIBDY61wTSwC8/PQ79kuE8TP7+iMzusG1CR2Hk+pUWswaFX/bx6xIBOoOR5zZuIW4uJDKKQV72YZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732482119; c=relaxed/simple;
	bh=M5bPiZeOmBrChTqvSHaOiMEbBYpudFThZKygFWy/+sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tl+7v5kjo9vDXvrBXALivmdjzBFEQhOJc6FWjRtxTi+QFgsA2aMh8cxglWVviOZhLgYMrr8ApoQsjtFCgLkz71bws9GM44LC5xcEWVVDDYAXsTc/5ToFtraZxxMIuccHrmDR/j42nMSwD6wHIWbgHJEs+C5lG5csKY1yONFCD3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=kAV3pBeW; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C78132C045C;
	Mon, 25 Nov 2024 10:01:54 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1732482114;
	bh=M5bPiZeOmBrChTqvSHaOiMEbBYpudFThZKygFWy/+sk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=kAV3pBeWLWUHWn/q1gPuXly75Ja5LcZxYe48jz3QqRfJd0vEDexLThR7N9genwlu8
	 7ivYugmG4Go66OQHtwNAsgHTzTVoNSiJZaMt5O+ZCn4uIJbHHWmtvkMkMw81pz9I6e
	 bG/DNGQBngW3n5tAuT+T12Jgqq8x3hQ8TVfTR12tHnWDaNKEAdHz6+nXbttxg2diZ1
	 FzEVAtmYwtpVnTJQJQ6rxPOl1sdbA8D9LrYxYG9E+UKUm4/QIvPEbbLhlIM5mB6hn3
	 St0RfEc+Ql0q1Vc/wLaxRAzMDClf58vI65XLybow6JFHvY6kg/FO5D3gjybkNnA6pG
	 5TIXkJap97zbw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B674394420003>; Mon, 25 Nov 2024 10:01:54 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 25 Nov 2024 10:01:54 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Mon, 25 Nov 2024 10:01:46 +1300
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
Subject: Re: [RFC net-next (resend) 1/4] net: bridge: respect sticky flag on
 external learn
Thread-Topic: [RFC net-next (resend) 1/4] net: bridge: respect sticky flag on
 external learn
Thread-Index: AQHbMZIgNpj0gGtP+ECOfxmdRflJ/rLGKxGA
Date: Sun, 24 Nov 2024 21:01:46 +0000
Message-ID: <f2ac33e7b8ec0fefa48fe7cd3b1004abab67dcb1.camel@alliedtelesis.co.nz>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
	 <20241108035546.2055996-2-elliot.ayrey@alliedtelesis.co.nz>
In-Reply-To: <20241108035546.2055996-2-elliot.ayrey@alliedtelesis.co.nz>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC2C1C6F51691843A76849C4B3840E84@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gam0nhXL c=1 sm=1 tr=0 ts=67439442 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=nyesw9g_oEEA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=iWpVzneqSnGDNxmlfzsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-SEG-SpamProfiler-Score: 0

T24gU2F0LCAyMDI0LTExLTA5IGF0IDE1OjMyICswMjAwLCBOaWtvbGF5IEFsZWtzYW5kcm92IHdy
b3RlOg0KPiBTbyB5b3UgaGF2ZSBhIHN0aWNreSBmZGIgZW50cnkgYWRkZWQsIGJ1dCBpdCBpcyBz
dGlsbCBhbGxvd2VkIHRvIHJvYW0NCj4gaW4gSFc/DQoNCk5vIHRoZSBoYXJkd2FyZSBoYXMgaW5m
b3JtZWQgdXMgYSBob3N0IGhhcyBfdHJpZWRfIHRvIHJvYW0uDQoNCkFzIEkgdGhpbmsgYWJvdXQg
dGhpcyBtb3JlLCB1c2luZyB0aGUgc3RpY2t5IGJpdCBhbG9uZSBwcm9iYWJseSBpc24ndA0KdGhl
IGJlc3QgaWRlYSBhbmQgaXQgbWlnaHQgYmUgYmV0dGVyIGlmIHRoaXMgbWVjaGFuaXNtIHdlcmUg
cmVsYXRlZCB0bw0KYSBwb3J0IGJlaW5nIGxvY2tlZD8gQWZ0ZXIgYWxsIHRoZSBwb3J0IGJlaW5n
IGxvY2tlZCBpbiBoYXJkd2FyZSBpcw0Kd2hhdCBnZW5lcmF0ZXMgdGhpcyBldmVudC4NCg==

