Return-Path: <netdev+bounces-251074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9858ED3A90E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ACED30CC4B3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921935B120;
	Mon, 19 Jan 2026 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="N9QaNvM9"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9A35B140;
	Mon, 19 Jan 2026 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826079; cv=none; b=brSAoCc/N5YufctjbsJaGGLyvNQmKivj8DkeZ/ij31Yny8KSJgrtcySaHoFga4duSdm+3/Hug8G7vlid97p8q3LKH+xqP4v7wbAsDR1zf7mbI/1MuPxhxRZiSzowmHCZ8xVi4heBNn4xsnk4IGiSN8bvknSwflsDGCeJGisvHNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826079; c=relaxed/simple;
	bh=XFlK9F8mCmxc52EP9cPh0kMubVtKS5FFg+3+IrJ8Bt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5m/sQBn0/WTv8yvB5+wxWsCLlOX5TaCO47oIqb4U3mgqcPeIkZt2GnkUZVwh7YqJTEevWU6bwYqV5OY/lnB9rEZYwY+7/b28lpsfOksXtS7fijjbvHYlO0nzkA8XEhtBlf7pV+swkD5t+Gd0yfBTPa7WBMM1VasDlBkplfT3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=N9QaNvM9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60JCYFEk82926860, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768826055; bh=XFlK9F8mCmxc52EP9cPh0kMubVtKS5FFg+3+IrJ8Bt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=N9QaNvM99G/xV+3Rfkf7KlboCZK73jseCGlXw6XWVOiaRCIg+HrDwLuC/akvlXmAE
	 qiXKGvI/p9gml1Ks+9DwaY8WlYu4CotWxa+hUD1RZ9IsMRqCv1fStXQFr10tiHC7I9
	 4rIqpv21NGqSK6jprgCTFX7Y7f/czUOQ7SXQbeq1EWuxiMwTX0AX85w+oU2qlLQNk7
	 2zRpTOZQu6/1f9slgVGsnpXp02ABkih0GPCwpU9Y8i433jzUYvebq+KGNQ5lvDqP3K
	 sI06GycoT7wZaaJmKdVG14oeWdmyzkUU3+uh8wU2uPBVWlDjq0oYSaTsJmx+pv6teY
	 GR9GwmCvfx8yw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60JCYFEk82926860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 20:34:15 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 19 Jan 2026 20:34:16 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 19 Jan 2026 20:34:15 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5%9]) with mapi id
 15.02.1748.010; Mon, 19 Jan 2026 20:34:15 +0800
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
Thread-Index: AQHchQGLBs/iMEigv0CwXIii7EgMTLVRErBAgADcLoCAASPVoIAAd9qAgACSjYD//8agAIAE7krA//+/4oCAAOJ1wA==
Date: Mon, 19 Jan 2026 12:34:15 +0000
Message-ID: <cd80f6df5c184549a3705efa61d40d58@realtek.com>
References: <20260114025622.24348-1-insyelu@gmail.com>
 <3501a6e902654554b61ab5cd89dcb0dd@realtek.com>
 <CAAPueM4XheTsmb6xd3w5A3zoec-z3ewq=uNpA8tegFbtFWCfaA@mail.gmail.com>
 <1b498052994c4ed48de45b5af9a490b6@realtek.com>
 <CAAPueM65Y4zEb4UidMR-6UtCZVWYs+A7cHzYbBgJMmAZ2iLy5Q@mail.gmail.com>
 <f3fe05ea76794cd09774cd69e85623d8@realtek.com>
 <CAAPueM57HHjvyCtBf5TEy2rn6+1ab7_aeSpJ0Kv4xUYt+SfFtg@mail.gmail.com>
 <ae7e8fc22fcf415d9eb5e4d36ed74231@realtek.com>
 <CAAPueM6_GQLcqz+xxKVDOaUZZrDNOnYB_tQ2gaxrUKnDQSZ9cg@mail.gmail.com>
In-Reply-To: <CAAPueM6_GQLcqz+xxKVDOaUZZrDNOnYB_tQ2gaxrUKnDQSZ9cg@mail.gmail.com>
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

bHUgbHUgPGluc3llbHVAZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMTksIDIw
MjYgMjo1OCBQTQ0KWy4uLl0NCj4gPiBUaGVyZWZvcmUsIHdoYXQgbmVlZHMgdG8gYmUgZG9uZSBp
cyB0byB1cGRhdGUgdGhlIHRpbWVzdGFtcCB3aGVuIHRoZSBUWCBxdWV1ZSBpcyBzdG9wcGVkLg0K
PiA+IFVwZGF0aW5nIHRyYW5zX3N0YXJ0IHdoaWxlIHRoZSBUWCBxdWV1ZSBpcyBub3Qgc3RvcHBl
ZCBpcyB1c2VsZXNzLg0KPiBpZiAobmV0aWZfcXVldWVfc3RvcHBlZCh0cC0+bmV0ZGV2KSkgew0K
PiAgICAgaWYgKHNrYl9xdWV1ZV9sZW4oJnRwLT50eF9xdWV1ZSkgPCB0cC0+dHhfcWxlbikNCj4g
ICAgICAgICBuZXRpZl93YWtlX3F1ZXVlKHRwLT5uZXRkZXYpOw0KPiAgICAgZWxzZQ0KPiAgICAg
ICAgIG5ldGlmX3RyYW5zX3VwZGF0ZSh0cC0+bmV0ZGV2KTsNCj4gfQ0KPiBUaGlzIGNoYW5nZSBj
b250aW51b3VzbHkgdXBkYXRlcyB0aGUgdHJhbnNfc3RhcnQgdmFsdWUsIGV2ZW4gd2hlbiB0aGUN
Cj4gVFggcXVldWUgaGFzIGJlZW4gc3RvcHBlZCBhbmQgaXRzIGxlbmd0aCBleGNlZWRzIHRoZSB0
aHJlc2hvbGQuDQo+IFRoaXMgbWF5IHByZXZlbnQgdGhlIHdhdGNoZG9nIHRpbWVyIGZyb20gZXZl
ciB0aW1pbmcgb3V0LCB0aGVyZWJ5DQo+IG1hc2tpbmcgcG90ZW50aWFsIHRyYW5zbWlzc2lvbiBz
dGFsbCBpc3N1ZXMuDQo+IA0KPiBUaGUgdGltZXN0YW1wIHNob3VsZCBiZSB1cGRhdGVkIG9ubHkg
dXBvbiBzdWNjZXNzZnVsIFVSQiBzdWJtaXNzaW9uIHRvDQo+IGFjY3VyYXRlbHkgcmVmbGVjdCB0
aGF0IHRoZSB0cmFuc3BvcnQgbGF5ZXIgaXMgc3RpbGwgb3BlcmF0aW9uYWwuDQoNCkFsdGhvdWdo
IEkgdGhpbmsgYSBVUkIgZXJyb3IgYW5kIGEgdHJhbnNtaXNzaW9uIHN0YWxsIGFyZSBkaWZmZXJl
bnQsDQpJIGFtIGZpbmUgd2l0aCB0aGUgc2ltcGxlciBhcHByb2FjaCBpbiB2Mi4NCg0KQmVzdCBS
ZWdhcmRzLA0KSGF5ZXMNCg0K

