Return-Path: <netdev+bounces-67074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831F5841FEF
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2AA3B2A053
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7214067757;
	Tue, 30 Jan 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BgBDcv0E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E96772D
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607620; cv=none; b=TmiJ4crHxUVtdYpKeKsKeqk9NysUYgZnyZLw7rWkREDDEBsKw+D6skvxthLF+wcKwhk8UNAjruYo4OmHLRyb0r9eBn7nmfpxnwOIU++nKiBDh0okJNelfVL4AiH8HvDtH92TJqbHENOKnOW6OJiuDXJpIu6D9u/VehNAbH3w7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607620; c=relaxed/simple;
	bh=QSX07zW5fvuglueht1lcOzCbNuDZ3SqKK087lUn21SI=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IInfdMEoDjQL5w5cGbQ4Cy/USm69vBUoMuoa6cdpnr1ww8nRVIpqo83Tn0o+tZKEDNNHsK/bptl4vntQ7Zh/JeM6R3foU543IWWCBaX1AyeHvS70I+ofgarTwIMLCYhXpbrQKWTUOe0A8oPinlejyAdW41iN/c3VIBMgiGmSCn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BgBDcv0E; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706607620; x=1738143620;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=QSX07zW5fvuglueht1lcOzCbNuDZ3SqKK087lUn21SI=;
  b=BgBDcv0EVKqw7Pp9mZJGVkwMG21/lM1sxfYfP7UUhg4G9pJ45Oky3G2R
   ZzOnlpaA/NQjC/87ZQYfgb6NMsxcPqhn3e6QMn9zfPJtmxeeWMUbSEvR+
   dYisKTuc6/LptutRTnGEZu7hKuyMtrg4W/vckN+Bj6rrOZO4iB/kTDmt3
   g=;
X-IronPort-AV: E=Sophos;i="6.05,707,1701129600"; 
   d="scan'208";a="377655890"
Subject: RE: [PATCH v1 net-next 00/11] ENA driver changes
Thread-Topic: [PATCH v1 net-next 00/11] ENA driver changes
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:39:58 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id 70CDC811DC;
	Tue, 30 Jan 2024 09:39:56 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:17142]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.152:2525] with esmtp (Farcaster)
 id 68f5c6ed-15f5-4253-b64b-1cf8268fa540; Tue, 30 Jan 2024 09:39:55 +0000 (UTC)
X-Farcaster-Flow-ID: 68f5c6ed-15f5-4253-b64b-1cf8268fa540
Received: from EX19D028EUB002.ant.amazon.com (10.252.61.43) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:39:54 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D028EUB002.ant.amazon.com (10.252.61.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:39:54 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1118.040; Tue, 30 Jan 2024 09:39:54 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
	<zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Koler, Nati" <nkolder@amazon.com>
Thread-Index: AQHaUxqoMI2O9AAFL0mLJHsl8WYBz7Dx9COA
Date: Tue, 30 Jan 2024 09:39:53 +0000
Message-ID: <fab02eb3391341b3b63c5abf9ff74f47@amazon.com>
References: <20240129085531.15608-1-darinzon@amazon.com>
 <8ff8cd4e-294c-4b1f-8e83-c092132a2445@amd.com>
In-Reply-To: <8ff8cd4e-294c-4b1f-8e83-c092132a2445@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Precedence: Bulk

PiBPbiAxLzI5LzIwMjQgMTI6NTUgQU0sIGRhcmluem9uQGFtYXpvbi5jb20gd3JvdGU6DQo+ID4N
Cj4gPiBGcm9tOiBEYXZpZCBBcmluem9uIDxkYXJpbnpvbkBhbWF6b24uY29tPg0KPiA+DQo+ID4g
VGhpcyBwYXRjaHNldCBjb250YWlucyBhIHNldCBvZiBtaW5vciBhbmQgY29zbWV0aWMgY2hhbmdl
cyB0byB0aGUgRU5BDQo+ID4gZHJpdmVyLg0KPiANCj4gQSBjb3VwbGUgb2Ygbml0cyBub3RlZCwg
YnV0IG90aGVyd2lzZSBsb29rcyByZWFzb25hYmxlLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFNoYW5u
b24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPg0KPiANCj4gDQoNClRoYW5rcyBmb3Ig
dGFraW5nIHRoZSB0aW1lIGFuZCByZXZpZXdpbmcgdGhlIHBhdGNoc2V0Lg0KSSd2ZSBhZGRyZXNz
ZWQgc29tZSBvZiB0aGUgY29tbWVudHMsIHdoaWxlIHRoZSByZXN0IHdpbGwNCmJlIGZpeGVkIGlu
IHRoZSBuZXh0IHBhdGNoc2V0IHZlcnNpb24uDQoNCkRhdmlkDQoNCj4gPg0KPiA+IERhdmlkIEFy
aW56b24gKDExKToNCj4gPiAgICBuZXQ6IGVuYTogUmVtb3ZlIGFuIHVudXNlZCBmaWVsZA0KPiA+
ICAgIG5ldDogZW5hOiBBZGQgbW9yZSBkb2N1bWVudGF0aW9uIGZvciBSWCBjb3B5YnJlYWsNCj4g
PiAgICBuZXQ6IGVuYTogTWlub3IgY29zbWV0aWMgY2hhbmdlcw0KPiA+ICAgIG5ldDogZW5hOiBF
bmFibGUgRElNIGJ5IGRlZmF1bHQNCj4gPiAgICBuZXQ6IGVuYTogUmVtb3ZlIENRIHRhaWwgcG9p
bnRlciB1cGRhdGUNCj4gPiAgICBuZXQ6IGVuYTogQ2hhbmdlIGVycm9yIHByaW50IGR1cmluZyBl
bmFfZGV2aWNlX2luaXQoKQ0KPiA+ICAgIG5ldDogZW5hOiBBZGQgbW9yZSBpbmZvcm1hdGlvbiBv
biBUWCB0aW1lb3V0cw0KPiA+ICAgIG5ldDogZW5hOiBSZWxvY2F0ZSBza2JfdHhfdGltZXN0YW1w
KCkgdG8gaW1wcm92ZSB0aW1lIHN0YW1waW5nDQo+ID4gICAgICBhY2N1cmFjeQ0KPiA+ICAgIG5l
dDogZW5hOiBDaGFuZ2UgZGVmYXVsdCBwcmludCBsZXZlbCBmb3IgbmV0aWZfIHByaW50cw0KPiA+
ICAgIG5ldDogZW5hOiBoYW5kbGUgZW5hX2NhbGNfaW9fcXVldWVfc2l6ZSgpIHBvc3NpYmxlIGVy
cm9ycw0KPiA+ICAgIG5ldDogZW5hOiBSZWR1Y2UgbGluZXMgd2l0aCBsb25nZXIgY29sdW1uIHdp
ZHRoIGJvdW5kYXJ5DQo+ID4NCj4gPiAgIC4uLi9kZXZpY2VfZHJpdmVycy9ldGhlcm5ldC9hbWF6
b24vZW5hLnJzdCAgICB8ICAgNiArDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9hbWF6b24v
ZW5hL2VuYV9jb20uYyAgICAgfCAzMjMgKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gICBkcml2ZXJz
L25ldC9ldGhlcm5ldC9hbWF6b24vZW5hL2VuYV9jb20uaCAgICAgfCAgIDYgKy0NCj4gPiAgIGRy
aXZlcnMvbmV0L2V0aGVybmV0L2FtYXpvbi9lbmEvZW5hX2V0aF9jb20uYyB8ICA0OSArKy0NCj4g
PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2FtYXpvbi9lbmEvZW5hX2V0aF9jb20uaCB8ICAzOSAr
LS0NCj4gPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2FtYXpvbi9lbmEvZW5hX25ldGRldi5jICB8
IDE2MSArKysrKystLS0NCj4gPiAgIC4uLi9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfcmVn
c19kZWZzLmggICB8ICAgMSArDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9hbWF6b24vZW5h
L2VuYV94ZHAuYyAgICAgfCAgIDEgLQ0KPiA+ICAgOCBmaWxlcyBjaGFuZ2VkLCAyNTggaW5zZXJ0
aW9ucygrKSwgMzI4IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjQwLjENCj4gPg0K
PiA+DQoNCg==

