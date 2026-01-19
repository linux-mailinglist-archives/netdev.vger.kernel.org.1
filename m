Return-Path: <netdev+bounces-250951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D2D39C98
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 03:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9256300724F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1F91DF273;
	Mon, 19 Jan 2026 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="t8BI+PZC"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FB71A316E;
	Mon, 19 Jan 2026 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768791121; cv=none; b=k1D0NQttXn1UrCxneKQ/xtnaSp+YE3heZtZ3erClmPH5DkFUXQqvM4q/N/uUn7jvt277uqhK9WxMFD5NXeiNUlNHDQmo2xIei0/jZrFh32nu7gn3Bfcevm+PhjPVz7SemMC/ifgFYl/i++LVrBIFuMpzToQmcAgV8wNpdFhJFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768791121; c=relaxed/simple;
	bh=K6KfJaaiSgAOm7E/gs+hobmXhUl7J70D6NJcX3cYIP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EEj+fh12WIvRvRhAGAfqPGsAHQSZmaN12nwtV/g/t+N5gLE89GxN+uFCPqyaPjmOS17Gg/zX7vEBs6xiHybxG3klCQtmoChUyh3KS0j6+M2LE3qESuCkuX1Zs2QVX1rQogssQGHsNIRj/U08/+m5AaCN8SB2+HqvWO9+yanfcgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=t8BI+PZC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60J2pYY712135983, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768791094; bh=K6KfJaaiSgAOm7E/gs+hobmXhUl7J70D6NJcX3cYIP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=t8BI+PZC9N8+qDXuC8GWMYX5vgwQAGaOfQOotLwZBHtp1NF187CpeACUjPrQwqU1h
	 BM09Dhwx1zhhnjEGkCK9bltBQo6ol2j68xwC3xSJyQFzp2f8BRwjsId3IELUOU5n5n
	 y9UgLVqHCwd9QVsG/snW1wYICvAq+wNFCgHXQunjy1HUgcjNESpfYIjY3ABb+TJAQX
	 vGW+v0DoNi7JWwuDh4Ckk5J9kBAUqYBhQME+4rojbwULoo7XorS2x6TQb0xGPZ/zd9
	 /Ru3eGO5KlpwqS8uECSXjp8SopkNDp6CtN+T0QAplwRNYuxl21Zs2XWx33TK+r0bnv
	 L7et+IHX8MPeQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60J2pYY712135983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 10:51:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 19 Jan 2026 10:51:33 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 19 Jan 2026 10:51:32 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5%9]) with mapi id
 15.02.1748.010; Mon, 19 Jan 2026 10:51:32 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: lu lu <insyelu@gmail.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        nic_swsd <nic_swsd@realtek.com>, "tiwai@suse.de"
	<tiwai@suse.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: usb: r8152: fix transmit queue timeout
Thread-Topic: [PATCH] net: usb: r8152: fix transmit queue timeout
Thread-Index: AQHchQGLBs/iMEigv0CwXIii7EgMTLVRErBAgADcLoCAASPVoIAAd9qAgACSjYD//8agAIAE7krA
Date: Mon, 19 Jan 2026 02:51:31 +0000
Message-ID: <ae7e8fc22fcf415d9eb5e4d36ed74231@realtek.com>
References: <20260114025622.24348-1-insyelu@gmail.com>
 <3501a6e902654554b61ab5cd89dcb0dd@realtek.com>
 <CAAPueM4XheTsmb6xd3w5A3zoec-z3ewq=uNpA8tegFbtFWCfaA@mail.gmail.com>
 <1b498052994c4ed48de45b5af9a490b6@realtek.com>
 <CAAPueM65Y4zEb4UidMR-6UtCZVWYs+A7cHzYbBgJMmAZ2iLy5Q@mail.gmail.com>
 <f3fe05ea76794cd09774cd69e85623d8@realtek.com>
 <CAAPueM57HHjvyCtBf5TEy2rn6+1ab7_aeSpJ0Kv4xUYt+SfFtg@mail.gmail.com>
In-Reply-To: <CAAPueM57HHjvyCtBf5TEy2rn6+1ab7_aeSpJ0Kv4xUYt+SfFtg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGx1IGx1IDxpbnN5ZWx1QGdtYWlsLmNvbT4N
ClsuLi5dDQo+IGlmIChuZXRpZl9xdWV1ZV9zdG9wcGVkKHRwLT5uZXRkZXYpKSB7DQo+ICAgICBp
ZiAoc2tiX3F1ZXVlX2xlbigmdHAtPnR4X3F1ZXVlKSA8IHRwLT50eF9xbGVuKQ0KPiAgICAgICAg
IG5ldGlmX3dha2VfcXVldWUodHAtPm5ldGRldik7DQo+ICAgICBlbHNlDQo+ICAgICAgICAgbmV0
aWZfdHJhbnNfdXBkYXRlKHRwLT5uZXRkZXYpOw0KPiB9DQo+IFRoZSBmaXJzdCB0aW1lIHhtaXQg
c3RvcHMgdGhlIHRyYW5zbWl0IHF1ZXVlLCB0aGUgcXVldWUgaXMgbm90IGZ1bGwsDQo+IGFuZCBp
dCBpcyBzdWNjZXNzZnVsbHkgd29rZW4gdXAgYWZ0ZXJ3YXJkIOKAlCBPSy4NCj4gVGhlIHNlY29u
ZCB0aW1lIHhtaXQgc3RvcHMgdGhlIHRyYW5zbWl0IHF1ZXVlLCB0aGUgbmV0d29yayB3YXRjaGRv
Zw0KPiB0aW1lcyBvdXQgaW1tZWRpYXRlbHkgYmVjYXVzZSB0aGUgdHJhbnNtaXQgdGltZXN0YW1w
IHdhcyBub3QgcmVmcmVzaGVkDQo+IHdoZW4gdGhlIHF1ZXVlIHdhcyBsYXN0IHJlc3VtZWQg4oCU
IEZBSUwuDQo+IFRoaXMgc2NlbmFyaW8gaXMgbG9naWNhbGx5IHBvc3NpYmxlLg0KDQpUaGlzIHNp
dHVhdGlvbiBzaG91bGQgbm90IGhhcHBlbiwgYmVjYXVzZSB0cmFuc19zdGFydCBpcyBhbHNvIHVw
ZGF0ZWQgd2hlbiB0aGUgZHJpdmVyIHN0b3BzIHRoZSBUWCBxdWV1ZS4NCg0KaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTguNi9zb3VyY2UvaW5jbHVkZS9saW51eC9uZXRkZXZp
Y2UuaCNMMzYyOQ0KDQpBIFRYIHRpbWVvdXQgb2NjdXJzIG9ubHkgaWYgdGhlIFRYIHF1ZXVlIGhh
cyBiZWVuIHN0b3BwZWQgZm9yIGxvbmdlciB0aGFuIFJUTDgxNTJfVFhfVElNRU9VVC4NCkl0IHNo
b3VsZCBub3Qgb2NjdXIgaW1tZWRpYXRlbHkgd2hlbiB0aGUgZHJpdmVyIHN0b3BzIHRoZSBUWCBx
dWV1ZS4NCg0KVGhlcmVmb3JlLCB3aGF0IG5lZWRzIHRvIGJlIGRvbmUgaXMgdG8gdXBkYXRlIHRo
ZSB0aW1lc3RhbXAgd2hlbiB0aGUgVFggcXVldWUgaXMgc3RvcHBlZC4NClVwZGF0aW5nIHRyYW5z
X3N0YXJ0IHdoaWxlIHRoZSBUWCBxdWV1ZSBpcyBub3Qgc3RvcHBlZCBpcyB1c2VsZXNzLg0KDQpC
ZXN0IFJlZ2FyZHMsDQpIYXllcw0KDQo=

