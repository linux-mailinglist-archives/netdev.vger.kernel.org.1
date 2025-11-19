Return-Path: <netdev+bounces-240047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCACC6FA8A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0640386770
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97A33EAE6;
	Wed, 19 Nov 2025 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KiG+s73b"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F312F6929;
	Wed, 19 Nov 2025 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565660; cv=none; b=X+erX94N1Yja51msGBXwOXgLubNE3LJEZo3jGzFjiTOIkiwP7Nb4U+Lv8DxkH8hqJFzFW7+Pq7nIImTwFnW6B7fTVwgOUsQpX40+HycA2KqnOy4YLSkpxtH2UUgggC7a3IcjxrdOWkQvFH0vLd2T9eB63RsaaPE1ykjIRCh8laI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565660; c=relaxed/simple;
	bh=2zppcITsFukXAmoH+VEKKgXj/124qFAZNQuXDrPllvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GAYvo3C+Z10Rl6OdRJ7KWojNzuvxB6uByNgxw9/XploN7dXIB7yIKLby0r7no9bIW3aX+DFR7T4FZKv1ZgTn6FqbbaOIjcVhlgimAlnSFXGqyJtiBfWdYAlXjoTNLP7PptwifWAwvmWGZl+wLUOll1vjdqlIWvlFfHMgrkMcc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KiG+s73b; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AJFK3Ab83802412, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763565603; bh=2zppcITsFukXAmoH+VEKKgXj/124qFAZNQuXDrPllvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KiG+s73b/SjvCvVfxOMON/OQ7rslYnemkteXUcTKxrud+kXBWtPmEMD7IxOmqqlQj
	 b1h8+mzdZeMjs5hWgn+ygiSjJ1vzWv/6nECe01mhe+KOJf3D8VbcaH1F6LurE1tZPV
	 Hnb2s7Wr2ipnwWsrFSaMuJoXmPYPt9e1Fbw7x13Fkzur10zXSapG6swXi/oqaC0a3u
	 I6b06Vj87X443/sVE/jPfb0Wp/TVhrvc6rYmNzEBc2W/D+AG/1+yENGDCKHNU/gurg
	 1xfASY7enytexJK/sPIBJzt3SqSSoDl0otr+bIpljDnUhJ31vgCaJDRbYp+jcKzuqA
	 oIvQgbED7TiQw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AJFK3Ab83802412
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 23:20:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 19 Nov 2025 23:20:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 19 Nov 2025 23:20:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Wed, 19 Nov 2025 23:20:02 +0800
From: Hau <hau@realtek.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
        "javen_xu@realsil.com.cn"
	<javen_xu@realsil.com.cn>,
        nic_swsd <nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] r8169: add support for RTL9151A
Thread-Topic: [PATCH net-next v2] r8169: add support for RTL9151A
Thread-Index: AQHcWPy6r7FL3uL8CUO9Eu+e0EWoTrT5Bb0AgAEVVtA=
Date: Wed, 19 Nov 2025 15:20:02 +0000
Message-ID: <b2abb57de093488c8bda9ba47ff3d3c5@realtek.com>
References: <20251119023216.3467-1-javen_xu@realsil.com.cn>
 <37faada7-1b21-4ccf-9ca5-78756231c2df@gmail.com>
In-Reply-To: <37faada7-1b21-4ccf-9ca5-78756231c2df@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpbmVyIEthbGx3ZWl0
IFttYWlsdG86aGthbGx3ZWl0MUBnbWFpbC5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1i
ZXIgMTksIDIwMjUgMjozNyBQTQ0KPiBUbzogamF2ZW5feHVAcmVhbHNpbC5jb20uY247IG5pY19z
d3NkIDxuaWNfc3dzZEByZWFsdGVrLmNvbT47DQo+IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3Jn
OyBwYWJlbmlAcmVkaGF0LmNvbTsgaG9ybXNAa2VybmVsLm9yZw0KPiBDYzogbmV0ZGV2QHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIG5ldC1uZXh0IHYyXSByODE2OTogYWRkIHN1cHBvcnQgZm9yIFJUTDkxNTFBDQo+IA0K
PiANCj4gRXh0ZXJuYWwgbWFpbCA6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
dGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90DQo+IHJlcGx5LCBjbGljayBsaW5rcywgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+IE9uIDExLzE5LzIwMjUgMzozMiBBTSwg
amF2ZW4gd3JvdGU6DQo+ID4gVGhpcyBhZGRzIHN1cHBvcnQgZm9yIGNoaXAgUlRMOTE1MUEuIEl0
cyBYSUQgaXMgMHg2OGIuIEl0IGlzIGJhc2NpYWxseQ0KPiA+IGJhc2Qgb24gdGhlIG9uZSB3aXRo
IFhJRCAweDY4OCwgYnV0IHdpdGggZGlmZmVyZW50IGZpcm13YXJlIGZpbGUuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBqYXZlbiA8amF2ZW5feHVAcmVhbHNpbC5jb20uY24+DQo+ID4NCj4gPiAt
LS0NCj4gPiB2MjogUmViYXNlIHRvIG1hc3Rlciwgbm8gY29udGVudCBjaGFuZ2VzLg0KPiA+IC0t
LQ0KPiANCj4gDQo+IFJldmlld2VkLWJ5OiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21h
aWwuY29tPg0KPiANCj4gRm9yIG15IHVuZGVyc3RhbmRpbmc6DQo+IEFueSBzcGVjaWZpYyByZWFz
b24gZm9yIHRoZSBkaWZmZXJlbnQgdmVyc2lvbiBudW1iZXIgc2NoZW1lPw0KDQpVbmxpa2UgUlRM
ODEyNWQsIGl0IGlzIGEgbXVsdGktZnVuY3Rpb24gZGV2aWNlLiBUaGUgTEFOIGZ1bmN0aW9uIGlu
IG9uIGZ1bmN0aW9uIDIuDQpUaGF0IGlzIHdoeSBpdCBoYXMgYSBuZXcgeGlkLg0K

