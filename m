Return-Path: <netdev+bounces-147558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5619DA2D5
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 08:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A7316764E
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 07:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFBC13D89D;
	Wed, 27 Nov 2024 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nvLG0U9N"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94E13CA8A;
	Wed, 27 Nov 2024 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691358; cv=none; b=Vkl8UwwfA5GjglfWuGdqo2cNWJO7DATpHSZrBZ9mSZ2PfHq8EvUMx02pSCG0Qf/Cgrr/Gfc7sV4D8NjfOMGdSTS2OhO5caNhrcqsrVrw1fTLTv5hWSFHDYeXZ25Sy1c4fdt+oLrvxB3ynsfqgkNe3b0x/0MDq17qzGYCR6N4HVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691358; c=relaxed/simple;
	bh=vJ58Dpra2MGOeK4I9oO7NAxoULtFQc+ZviUUJCf3YBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hcAydHvrM4OAhFwc6QwJdaUg+2thtQWdF2H7TKRCvliKrj4/XoFQ+ERRy+EilpgTxz1hehoeMiD6yxvzuxK7bo+TjPoltbFMEHWHE7DOjCXufWq52qY9u7QDHRkqjXKamz+otn6pNV+iv6DwWKysmbw4rhrMW1fKujqedRXaQeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nvLG0U9N; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AR78ZJT02339266, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732691315; bh=vJ58Dpra2MGOeK4I9oO7NAxoULtFQc+ZviUUJCf3YBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nvLG0U9N0JvKjUtGm+splyk5NCBSvoiZXVpv325Oa9mOJt9w6sZmcmzqiA055L01X
	 pEr5NnnirU9JejY+C8vJ4YUbPrR9qDpFc7jN+9btzOky+SJPkGhs1rdMEWJ5SZ1uJC
	 wBN/bHDNxvNTboIsCidnazwT6kM9Trs1hu8LDkmRai5pWHlqpp2j/SoxCzJ1QyNDPu
	 MNCv9Gs7Jg67HH2ExPCoWNR5JTlVM36BySNwcPQjQWMb88ly+3buJdR6q62pbPXZjj
	 NuP/v3niJB4Tc8lxjbJTcWYtHUpSRSfbIWQS0R+uayOeG4Oi7PAJOdUAm/TNbZUak7
	 RsNMZW8uoH8bw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AR78ZJT02339266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 15:08:35 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 15:08:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Nov 2024 15:08:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 27 Nov 2024 15:08:35 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Paolo Abeni <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "michal.kubiak@intel.com" <michal.kubiak@intel.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net v5 3/3] rtase: Corrects error handling of the rtase_check_mac_version_valid()
Thread-Topic: [PATCH net v5 3/3] rtase: Corrects error handling of the
 rtase_check_mac_version_valid()
Thread-Index: AQHbOyITSFKY4UdyzkmiNf+1FwEQY7LIyjQAgAH1gIA=
Date: Wed, 27 Nov 2024 07:08:35 +0000
Message-ID: <6d3ca2183d864f71b1ee1f8fc10527f8@realtek.com>
References: <20241120075624.499464-1-justinlai0215@realtek.com>
 <20241120075624.499464-4-justinlai0215@realtek.com>
 <29d8c41d-ea21-4c35-9ec7-e7d5ef8aa55c@redhat.com>
In-Reply-To: <29d8c41d-ea21-4c35-9ec7-e7d5ef8aa55c@redhat.com>
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

PiANCj4gT24gMTEvMjAvMjQgMDg6NTYsIEp1c3RpbiBMYWkgd3JvdGU6DQo+ID4gUHJldmlvdXNs
eSwgd2hlbiB0aGUgaGFyZHdhcmUgdmVyc2lvbiBJRCB3YXMgZGV0ZXJtaW5lZCB0byBiZSBpbnZh
bGlkLA0KPiA+IG9ubHkgYW4gZXJyb3IgbWVzc2FnZSB3YXMgcHJpbnRlZCB3aXRob3V0IGFueSBm
dXJ0aGVyIGhhbmRsaW5nLg0KPiA+IFRoZXJlZm9yZSwgdGhpcyBwYXRjaCBtYWtlcyB0aGUgbmVj
ZXNzYXJ5IGNvcnJlY3Rpb25zIHRvIGFkZHJlc3MgdGhpcy4NCj4gPg0KPiA+IEZpeGVzOiBhMzZl
OWY1Y2ZlOWUgKCJydGFzZTogQWRkIHN1cHBvcnQgZm9yIGEgcGNpIHRhYmxlIGluIHRoaXMNCj4g
PiBtb2R1bGUiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEp1c3RpbiBMYWkgPGp1c3RpbmxhaTAyMTVA
cmVhbHRlay5jb20+DQo+IA0KPiBOb3RlIHRoYXQgeW91IHNob3VsZCBoYXZlIHJldGFpbmVkIHRo
ZSBBY2tlZC1ieSB0YWcgcHJvdmlkZWQgYnkgQW5kcmV3IG9uDQo+IHYzLg0KPiANCj4gTm8gbmVl
ZCB0byByZXBvc3QsIEknbSBhcHBseWluZyB0aGUgc2VyaWVzLCBidXQgcGxlYXNlIGtlZXAgaW4g
bWluZCBmb3IgdGhlIG5leHQNCj4gc3VibWlzc2lvbi4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IFBh
b2xvDQoNCk9LLCBJIHVuZGVyc3RhbmQuIFRoYW5rcyBmb3IgdGhlIHJldmlldywgSeKAmWxsIGZv
bGxvdyB0aGlzIGFwcHJvYWNoIGZyb20NCm5vdyBvbi4NCg0KSnVzdGluDQo=

