Return-Path: <netdev+bounces-250412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 460D0D2A929
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 435D730275BC
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27032332EA7;
	Fri, 16 Jan 2026 03:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WR6PwYAk"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041E27B4FB;
	Fri, 16 Jan 2026 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768533127; cv=none; b=KLqjCqMsu67gGuiu56g0QS+fx3x7GrCGGVBPRmayzrHi3WkyGgk/9g3MOoyS6Bo+60Pxy8KRku2Rj5cJGyAucZtWPzdILsoyZTQJzW5eZnelBb1PHT20wvBVCZzh9E+yv5NdRa0vmJ5eob+LNS+NuS8492rQPeHe+kT4HhT0rk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768533127; c=relaxed/simple;
	bh=bnsGwCDKBv6HzBK3XhUL3qvZhY9CIEGoTsmEbd0F+qo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T67B6/TOzqebc0Cw6NdRLwu44ak4AhRr9XLg7MmazbKreiC7Hj9Yx8C6FtDcNUI2E5DveL9mKsVrftDpUKrc3ztB4K6xzYLzakjMEz65YqFy5T54qKIMu91qOq4X2eGNaq10NpQBQKhLteRnuDpjAQunuNqvFlTofTnLOaJ0IO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WR6PwYAk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60G3BgzrE224104, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768533102; bh=bnsGwCDKBv6HzBK3XhUL3qvZhY9CIEGoTsmEbd0F+qo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WR6PwYAkYfHpXWhwIHScSznyQB5rS3CxYtyNPGpbh7lDGQThdeiSkEiZKE2j1dWaZ
	 d8+urc3li/ZHRdHq1/Sx2MTpq8lJzAPTdrARsvXMcVq8h3XxlmTExHFMZTjDffPzgG
	 dbHiz6mzpMPCXsX2iaOT2wsdrDNlqw/gFI+ZRM5ZHIoiqdQ00IbK+dRmDZTS3O/4WB
	 2boJJvmziZiFW6itxsRYCcizGAwQ87NCX27D1YVXb2h/8A6532Kd1M+Hg5OKDaT3R6
	 9+o2SaNwdAg2Ka1cAygQWj6i+nFyx0En6oZT7MohtF7z5W03JTcohoHAvn6D48AWCm
	 2BZNmidD0DARw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60G3BgzrE224104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 11:11:42 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 16 Jan 2026 11:11:42 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5%9]) with mapi id
 15.02.1748.010; Fri, 16 Jan 2026 11:11:42 +0800
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
Thread-Index: AQHchQGLBs/iMEigv0CwXIii7EgMTLVRErBAgADcLoCAASPVoIAAd9qAgACSjYA=
Date: Fri, 16 Jan 2026 03:11:42 +0000
Message-ID: <f3fe05ea76794cd09774cd69e85623d8@realtek.com>
References: <20260114025622.24348-1-insyelu@gmail.com>
 <3501a6e902654554b61ab5cd89dcb0dd@realtek.com>
 <CAAPueM4XheTsmb6xd3w5A3zoec-z3ewq=uNpA8tegFbtFWCfaA@mail.gmail.com>
 <1b498052994c4ed48de45b5af9a490b6@realtek.com>
 <CAAPueM65Y4zEb4UidMR-6UtCZVWYs+A7cHzYbBgJMmAZ2iLy5Q@mail.gmail.com>
In-Reply-To: <CAAPueM65Y4zEb4UidMR-6UtCZVWYs+A7cHzYbBgJMmAZ2iLy5Q@mail.gmail.com>
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

bHUgbHUgPGluc3llbHVAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTYsIDIw
MjYgMTA6MTEgQU0NClsuLi5dDQo+ID4gICAgICAgICBuZXRpZl90eF9sb2NrKHRwLT5uZXRkZXYp
Ow0KPiA+DQo+ID4gLSAgICAgICBpZiAobmV0aWZfcXVldWVfc3RvcHBlZCh0cC0+bmV0ZGV2KSAm
Jg0KPiA+IC0gICAgICAgICAgIHNrYl9xdWV1ZV9sZW4oJnRwLT50eF9xdWV1ZSkgPCB0cC0+dHhf
cWxlbikNCj4gPiArICAgICAgIGlmIChuZXRpZl9xdWV1ZV9zdG9wcGVkKHRwLT5uZXRkZXYpKSB7
DQo+ID4gKyAgICAgICAgICAgaWYgKHNrYl9xdWV1ZV9sZW4oJnRwLT50eF9xdWV1ZSkgPCB0cC0+
dHhfcWxlbikNCj4gPiAgICAgICAgICAgICAgICAgbmV0aWZfd2FrZV9xdWV1ZSh0cC0+bmV0ZGV2
KTsNCj4gPiArICAgICAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgIG5ldGlmX3RyYW5z
X3VwZGF0ZSh0cC0+bmV0ZGV2KTsNCj4gPiArICAgICAgIH0NCj4gVGhlIHF1ZXVlIHdhcyBzdG9w
cGVkIGJlY2F1c2UgaXQgZXhjZWVkZWQgdGhlIHRocmVzaG9sZC4gQXR0ZW1wdGluZyB0bw0KPiBy
ZWZyZXNoIHRoZSB0aW1lIGF0IHRoaXMgcG9pbnQgaXMgY2xlYXJseSB0b28gbGF0ZS4NCg0KV2h5
IHdvdWxkIHRoaXMgYmUgY29uc2lkZXJlZCB0b28gbGF0ZT8NCkJhc2VkIG9uIFJUTDgxNTJfVFhf
VElNRU9VVCwgdGhlcmUgYXJlIGFib3V0IDUgc2Vjb25kcyB0bw0Kd2FrZSB0aGUgcXVldWUgb3Ig
dXBkYXRlIHRoZSB0aW1lc3RhbXAgYmVmb3JlIGEgVFggdGltZW91dCBvY2N1cnMuDQpJIGJlbGll
dmUgNSBzZWNvbmRzIHNob3VsZCBiZSBzdWZmaWNpZW50Lg0KDQpJZiB0aGVyZSBpcyBubyBUWCBz
dWJtaXNzaW9uIGZvciA1IHNlY29uZHMgYWZ0ZXIgdGhlIGRyaXZlciBzdG9wcyB0aGUgcXVldWUs
DQp0aGVuIHNvbWV0aGluZyBpcyBhbHJlYWR5IHdyb25nLg0KDQpCZXN0IFJlZ2FyZHMsDQpIYXll
cw0KDQo=

