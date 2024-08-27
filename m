Return-Path: <netdev+bounces-122227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833699607CD
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66E31C22448
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD5919DF58;
	Tue, 27 Aug 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ShlApHpa"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE2B674;
	Tue, 27 Aug 2024 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755656; cv=none; b=hpzWqYuuwXIiR6PMfHXgLhwiXWbAJNyGBB5eWlOalXHeFb3wO/9zV6h+DGecvLWIlNIzsoLVsReoUb0foNla9XrAAKpvRVE43u1zVRfLv/TpE6LnN3EjSvj+BHm6UtHnNNUGhAEuaYdxOnmkQBR7sCAAgC2B8SitmiHE05ZlI1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755656; c=relaxed/simple;
	bh=SmhHwuuQyrzcMnahqot7kRJoEME562bGHyRJZsIm/bY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ndwL7VySZfJKo11LdAs1HssO05o7b1uZ12TYwt7fLoCXdTgRTv9u9pR/B+o9e/yJyP0p89mr6HUVKXa2D4cwei6G53DUP1m5L5uCSKrOYGnoC0W7PTkKF42CG00QBn6wD2Xg9CR0FZFdWNPlzd6CpccEbmd4p3HpykUA7I/7z/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ShlApHpa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47RAkiJ13918725, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724755604; bh=SmhHwuuQyrzcMnahqot7kRJoEME562bGHyRJZsIm/bY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ShlApHpaV1kBPzHNvJrTZ5qS49IX3a8GGsHrjxThIxmRzLzRocyBXE/ehyTFiGWfW
	 luhEVy8vJlrqkHGa+nf1IXSWLV/+oLg1VlRfFfxu9+oElh3SUKRg8vZwvP/4spiZ8Q
	 TMWGiD8xypNNBIOYBzSYy7byODr4vbt7+5PimKvqtr2r4U9ZppCagL919C28Dwio2+
	 VWRx5T7aROhcTQx5fA4z+MwQBGTS9YrPlyVvTy0CdQ9+tWUYmqWf6MCiXuhZ3wOh9X
	 O2Ek+93nMAxrycLUtOVkPoxhwMGanW1VjY7+x7MMdOxapP18g1lo8biVpjV2A9Yqcd
	 SukY0ik1sE0vw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47RAkiJ13918725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 18:46:44 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 18:46:44 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Aug 2024 18:46:43 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f]) by
 RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f%2]) with mapi id
 15.01.2507.035; Tue, 27 Aug 2024 18:46:43 +0800
From: Larry Chiu <larry.chiu@realtek.com>
To: Paolo Abeni <pabeni@redhat.com>, Justin Lai <justinlai0215@realtek.com>,
        "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org" <horms@kernel.org>,
        "rkannoth@marvell.com" <rkannoth@marvell.com>,
        "jdamato@fastly.com"
	<jdamato@fastly.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: RE: [PATCH net-next v28 07/13] rtase: Implement a function to receive packets
Thread-Topic: [PATCH net-next v28 07/13] rtase: Implement a function to
 receive packets
Thread-Index: AQHa9HdUAPRW/0+ZOk+rNOW44eTUqLI6XwUAgACSvbA=
Date: Tue, 27 Aug 2024 10:46:43 +0000
Message-ID: <1036b59d9aa541db9b59a0cdc5868d9c@realtek.com>
References: <20240822093754.17117-1-justinlai0215@realtek.com>
 <20240822093754.17117-8-justinlai0215@realtek.com>
 <c38c1482-1574-4cc9-9ebf-aa5ad30d627a@redhat.com>
In-Reply-To: <c38c1482-1574-4cc9-9ebf-aa5ad30d627a@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgc2tiID0gYnVpbGRfc2tiKHJpbmctPmRhdGFfYnVm
W2VudHJ5XSwgUEFHRV9TSVpFKTsNCj4gPiArICAgICAgICAgICAgIGlmICghc2tiKSB7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIG5ldGRldl9lcnIoZGV2LCAic2tiIGJ1aWxkIGZhaWxlZFxu
Iik7DQo+IA0KPiBJJ20gc29ycnkgZm9yIHRoaXMgbGF0ZSBmZWVkYmFjaywgYnV0IHRoZSBhYm92
ZSBtZXNzYWdlIHNob3VsZCBiZQ0KPiBkcm9wcGVkLCB0b28uDQo+IA0KPiBBcyBwb2ludGVkIG91
dCBieSBKYWt1YiBpbiB0aGUgcHJldmlvdXMgcmV2aXNpb24sIHRoaXMgYWxsb2NhdGlvbiBjYW4N
Cj4gZmFpbCwgYW5kIHRoZSBjb3VudGVyIGluY3JlYXNlIGJlbG93IHdpbGwgZ2l2ZSBleGFjdGx5
IHRoZSBzYW1lIGFtb3VudA0KPiBvZiBpbmZvcm1hdGlvbiwgd2l0aG91dCBwb3RlbnRpYWxseSBm
aWxsaW5nIHRoZSBkbXNlZyBidWZmZXIuDQo+IA0KPiBGV0lXLCBJIHRoaW5rIHRoZSBhYm92ZSBp
cyB0aGUgbGFzdCBpdGVtIHBlbmRpbmcuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBQYW9sbw0KDQpU
aGFuayB5b3UgZm9yIHRha2luZyB0aGUgdGltZSB0byByZXZpZXcuDQpXZSB3aWxsIHJlbW92ZSBp
dCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpMYXJyeQ0K

