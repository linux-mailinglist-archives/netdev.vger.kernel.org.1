Return-Path: <netdev+bounces-55084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BA48094E8
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 22:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02BAF1C20B7B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F21840DB;
	Thu,  7 Dec 2023 21:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="j35b7ekv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA4F19BA;
	Thu,  7 Dec 2023 13:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701985719; x=1733521719;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=K169VXreRi6H4lnj1dEVrgLV13RhfHVhA/+/vZMR56I=;
  b=j35b7ekvAQIPgI5FBT+7uGLRFTPHNSHzN/RJu7hlyn0tYzfGeB4kHzj/
   BGqH+u5tirYnhND2zJW2t++ASJyNfEnZOs/hCbI7GLfSlx1DmwFhB2HAC
   OUj0XKYedVTVeOtwwXOpr18fqpkrYo5P2H0eY1ogZIfUIkl4VribKShBR
   k=;
X-IronPort-AV: E=Sophos;i="6.04,258,1695686400"; 
   d="scan'208";a="316204563"
Subject: RE: [PATCH v2] net: ena: replace deprecated strncpy with strscpy
Thread-Topic: [PATCH v2] net: ena: replace deprecated strncpy with strscpy
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 21:48:33 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 516A849827;
	Thu,  7 Dec 2023 21:48:30 +0000 (UTC)
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:57188]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.244:2525] with esmtp (Farcaster)
 id 122fada5-91a6-401d-b104-935b0fdf78da; Thu, 7 Dec 2023 21:48:28 +0000 (UTC)
X-Farcaster-Flow-ID: 122fada5-91a6-401d-b104-935b0fdf78da
Received: from EX19D006EUA003.ant.amazon.com (10.252.50.176) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 21:48:28 +0000
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19D006EUA003.ant.amazon.com (10.252.50.176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 21:48:27 +0000
Received: from EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d]) by
 EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d%3]) with mapi id
 15.02.1118.040; Thu, 7 Dec 2023 21:48:27 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: "justinstitt@google.com" <justinstitt@google.com>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Arinzon, David" <darinzon@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Thread-Index: AQHaKVVUExdEyzhvpEiCt53EwtaXNLCeWhlQ
Date: Thu, 7 Dec 2023 21:48:23 +0000
Deferred-Delivery: Thu, 7 Dec 2023 21:47:21 +0000
Message-ID: <6a877c080404447c8f715c614b276bef@amazon.com>
References: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>
In-Reply-To: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBqdXN0aW5zdGl0dEBnb29nbGUu
Y29tIDxqdXN0aW5zdGl0dEBnb29nbGUuY29tPg0KPiANCj4gYHN0cm5jcHlgIGlzIGRlcHJlY2F0
ZWQgZm9yIHVzZSBvbiBOVUwtdGVybWluYXRlZCBkZXN0aW5hdGlvbiBzdHJpbmdzIFsxXSBhbmQg
YXMNCj4gc3VjaCB3ZSBzaG91bGQgcHJlZmVyIG1vcmUgcm9idXN0IGFuZCBsZXNzIGFtYmlndW91
cyBzdHJpbmcgaW50ZXJmYWNlcy4NCj4gDQo+IEEgc3VpdGFibGUgcmVwbGFjZW1lbnQgaXMgYHN0
cnNjcHlgIFsyXSBkdWUgdG8gdGhlIGZhY3QgdGhhdCBpdCBndWFyYW50ZWVzIE5VTC0NCj4gdGVy
bWluYXRpb24gb24gdGhlIGRlc3RpbmF0aW9uIGJ1ZmZlciB3aXRob3V0IHVubmVjZXNzYXJpbHkg
TlVMLXBhZGRpbmcuDQo+IA0KPiBob3N0X2luZm8gYWxsb2NhdGlvbiBpcyBkb25lIGluIGVuYV9j
b21fYWxsb2NhdGVfaG9zdF9pbmZvKCkgdmlhDQo+IGRtYV9hbGxvY19jb2hlcmVudCgpIGFuZCBp
cyBub3QgemVybyBpbml0aWFsaXplZCBieSBhbGxvY19ldGhlcmRldl9tcSgpLg0KPiANCj4gSG93
ZXZlciB6ZXJvIGluaXRpYWxpemF0aW9uIG9mIHRoZSBkZXN0aW5hdGlvbiBkb2Vzbid0IG1hdHRl
ciBpbiB0aGlzIGNhc2UsDQo+IGJlY2F1c2Ugc3Ryc2NweSgpIGd1YXJhbnRlZXMgYSBOVUxMIHRl
cm1pbmF0aW9uLg0KPiANCj4gTGluazoNCj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRt
bC9sYXRlc3QvcHJvY2Vzcy9kZXByZWNhdGVkLmh0bWwjc3RybmNweS1vbi0NCj4gbnVsLXRlcm1p
bmF0ZWQtc3RyaW5ncyBbMV0NCj4gTGluazogaHR0cHM6Ly9tYW5wYWdlcy5kZWJpYW4ub3JnL3Rl
c3RpbmcvbGludXgtbWFudWFsLTQuOC9zdHJzY3B5LjkuZW4uaHRtbA0KPiBbMl0NCj4gTGluazog
aHR0cHM6Ly9naXRodWIuY29tL0tTUFAvbGludXgvaXNzdWVzLzkwDQo+IENjOiBsaW51eC1oYXJk
ZW5pbmdAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEp1c3RpbiBTdGl0dCA8anVz
dGluc3RpdHRAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gdXBkYXRl
IGNvbW1pdCBtZXNzYWdlLCBkcm9wcGluZyBpbmFjY3VyYXRlIHN0YXRlbWVudCBhYm91dCBhbGxv
Y2F0aW9uDQo+ICAgKHRoYW5rcyBBcnRodXIpDQo+IC0gY29weS9wYXN0ZSBBcnRodXIncyBleHBs
YW5hdGlvbiByZWdhcmRpbmcgaG9zdF9pbmZvIGFsbG9jYXRpb24gaW50bw0KPiAtIHJlYmFzZWQg
b250byBtYWlubGluZQ0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Iv
MjAyMzEwMDUtc3RybmNweS1kcml2ZXJzLW5ldC1ldGhlcm5ldC0NCj4gYW1hem9uLWVuYS1lbmFf
bmV0ZGV2LWMtdjEtMS1iYTQ4Nzk5NzQxNjBAZ29vZ2xlLmNvbQ0KPiAtLS0NCj4gTm90ZTogYnVp
bGQtdGVzdGVkIG9ubHkuDQo+IC0tLQ0KPiAgLi4uLi4uLi4uLi4uLi4uLi4uDQo+IEJlc3QgcmVn
YXJkcywNCj4gLS0NCj4gSnVzdGluIFN0aXR0IDxqdXN0aW5zdGl0dEBnb29nbGUuY29tPg0KDQpU
aGFua3MgZm9yIG1ha2luZyB0aGUgbmVjZXNzYXJ5IGNoYW5nZXMgdG8gdGhlIGNvbW1pdCBtZXNz
YWdlIEp1c3Rpbi4NCkxvb2tzIGdvb2QuDQoNCkFja2VkLWJ5OiBBcnRodXIgS2l5YW5vdnNraSA8
YWtpeWFub0BhbWF6b24uY29tPg0KDQoNCg==

