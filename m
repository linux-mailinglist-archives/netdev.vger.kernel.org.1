Return-Path: <netdev+bounces-224056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B0B8041B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30E9188F86C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A1F2F5339;
	Wed, 17 Sep 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SSpp6iKv"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE0225788;
	Wed, 17 Sep 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120563; cv=none; b=OxRzQMNTLatFxOM3s11f/pja0cQ4OekHgpENbky7yzPO9Y3fwQvHUdiToluYG0gZoFtkvZ5Hn99/fQCaqmjV2NLU+bhOYBysv3HJfFVCwFyYujLlJTs2xWK9GBhWgSxsEKf0ZSo+yL3hNFoie9RvDW+6A/xVf6OtW/2DvlsKvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120563; c=relaxed/simple;
	bh=PJY8Ckt9S3ILQBWFfse/dU+I5Vorj3rle3RX4w0mhfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GtFhS24GmpgVfBXe/8LOVobXuBSoJE5V3HVbx0U3qZ7D8gJErOq89hEDoIulxrsxY90ojgGGlmJtUU+zWePdiYUb/HYx/rzDgC5f0fNmmCnJRsPxRQkn+bxUxthkToKjSHDKN5E/vBsQfJpnSFnsgi3T9FzQYvSwpf1PjoQYNKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SSpp6iKv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58HEmg5cB384602, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758120522; bh=PJY8Ckt9S3ILQBWFfse/dU+I5Vorj3rle3RX4w0mhfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=SSpp6iKvxSQz2o5dA7IeLk07XOcEwUQVEu93AzGK4wm0MsliwOBfxb3CtBNjnC9Y3
	 TTwDLUX1avYzSH6Ji0UEtKLZHIiumamgHl7U0mOTkqAM8nJdJPsRuiEuaKcRUq6RdM
	 65/+/iDjU5eVlFOaUE7Bcvg+REkRYPARoRaqr+MYOPnZ0YO/1ObLPHujA5RblDhuuZ
	 1dyNB3N8bZmg4BqZ62XDoPl+T5f8VEvZ0SjNAOK53IQ+KasSc7f6RBvkfOMOq94TLF
	 GkWPwpwpgQgFjgfIn0X58fZ7gUc+14f3XgpRUzcZOHdp4Kgl9JAp8RYn3pogUKNurn
	 s2TSXyg9UXJiQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58HEmg5cB384602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 22:48:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 17 Sep 2025 22:48:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Wed, 17 Sep 2025 22:48:42 +0800
From: Hau <hau@realtek.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd <nic_swsd@realtek.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] r8169: set EEE speed down ratio to 1
Thread-Topic: [PATCH net-next] r8169: set EEE speed down ratio to 1
Thread-Index: AQHcHUE6wESi95i7Y0uNfg+X46GTibSEfc2AgBMKn0A=
Date: Wed, 17 Sep 2025 14:48:41 +0000
Message-ID: <a710550463da4b4281f9db1a8d0b29e1@realtek.com>
References: <20250904021123.5734-1-hau@realtek.com>
 <292e1b4d-b00d-4bb5-b55e-5684666c0229@gmail.com>
In-Reply-To: <292e1b4d-b00d-4bb5-b55e-5684666c0229@gmail.com>
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

PiANCj4gRXh0ZXJuYWwgbWFpbCA6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
dGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90DQo+IHJlcGx5LCBjbGljayBsaW5rcywgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+IE9uIDkvNC8yMDI1IDQ6MTEgQU0sIENo
dW5IYW8gTGluIHdyb3RlOg0KPiA+IEVFRSBzcGVlZCBkb3duIHJhdGlvIChtYWMgb2NwIDB4ZTA1
Nls3OjRdKSBpcyB1c2VkIHRvIGNvbnRyb2wgRUVFDQo+ID4gc3BlZWQgZG93biByYXRlLiBUaGUg
bGFyZ2VyIHRoaXMgdmFsdWUgaXMsIHRoZSBtb3JlIHBvd2VyIGNhbiBzYXZlLg0KPiA+IEJ1dCBp
dCBhY3R1YWxseSBzYXZlIGxlc3MgcG93ZXIgdGhlbiBleHBlY3RlZCwgYnV0IHdpbGwgaW1wYWN0
DQo+ID4gY29tcGF0aWJpbGl0eS4gU28gc2V0IGl0IHRvIDEgKG1hYyBvY3AgMHhlMDU2Wzc6NF0g
PSAwKSB0byBpbXByb3ZlDQo+IGNvbXBhdGliaWxpdHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBDaHVuSGFvIExpbiA8aGF1QHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiANCj4gUmV2aWV3ZWQt
Ynk6IEhlaW5lciBLYWxsd2VpdCA8aGthbGx3ZWl0MUBnbWFpbC5jb20+DQoNClRoaXMgcGF0Y2gg
c2VlbXMgaGFzIGJlZW4gcmV2aWV3ZWQuIEJ1dCBJIGRpZCBub3Qgc2VlIGl0IGJlZW4gYWNjZXB0
ZWQuIFNob3VsZCBJIHJlc3VibWl0IHRoZSBwYXRjaD8NCg==

