Return-Path: <netdev+bounces-67071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FD9841FD5
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117961C25EFB
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6B1605B4;
	Tue, 30 Jan 2024 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ivVsEtnk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95802657C3
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607558; cv=none; b=UQ0nQaYBb150AJiJaTV4UU0KdBgeUNIrbP/I0bRq5RWzk6s/U2lcu9n8LQSyheLg6euK/p/RqM+AuqPy9iO+s2fDA/sCYOFSKy3xWHbWCJH1kkTM//qiqqxaNRk/NqfQK/JG9ZnmFg+7IdfYeEhLnea6BTfTbaRld+gRdWB201o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607558; c=relaxed/simple;
	bh=9Y2aRNkVVK5hV/IBYGMkSi1qO6KsLUpwRmTK8Rcmt9I=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ngnJDAgsqAEs/fGen1RbRXRf/sWUS/M/z1IsYsiwyzzDi5Zn6fTfgfAsq3ZHaeWeA1rgpiaVzX/GUdDTD2SaLABXHEH6nFi0Y576dg2JCzEdFIEuJkz/pwZNlxX3l5pNyRHbjkcbaiQfX0HoBnZOumh73JuMXNl3KXWOy/CpNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ivVsEtnk; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706607557; x=1738143557;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=9Y2aRNkVVK5hV/IBYGMkSi1qO6KsLUpwRmTK8Rcmt9I=;
  b=ivVsEtnkil4xRphMFMka4io5S/2K1mExMHrXAn6l7WJmISpKFg6z1xV/
   Fu8NgbNalTvkfVPH7rQyWoXEE006fnulxvCiDyRSBNTWUPWnpRTKPjJfy
   nh2nt4dSG46KHr/eqY/oqYewuVAme1y2wM0lfFp/cIpe8SWIRhlkeP6B4
   o=;
X-IronPort-AV: E=Sophos;i="6.05,707,1701129600"; 
   d="scan'208";a="700752039"
Subject: RE: [PATCH v1 net-next 05/11] net: ena: Remove CQ tail pointer update
Thread-Topic: [PATCH v1 net-next 05/11] net: ena: Remove CQ tail pointer update
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:39:11 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 451A040A69;
	Tue, 30 Jan 2024 09:39:09 +0000 (UTC)
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:19937]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.158:2525] with esmtp (Farcaster)
 id a6611a73-d04e-4b3a-a6af-34a81c92e5d4; Tue, 30 Jan 2024 09:39:08 +0000 (UTC)
X-Farcaster-Flow-ID: a6611a73-d04e-4b3a-a6af-34a81c92e5d4
Received: from EX19D030EUB001.ant.amazon.com (10.252.61.82) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:39:08 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D030EUB001.ant.amazon.com (10.252.61.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:39:07 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1118.040; Tue, 30 Jan 2024 09:39:07 +0000
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
Thread-Index: AQHaUxoYoGo2b69jC02rPl7PqEv/47Dx7rSQ
Date: Tue, 30 Jan 2024 09:39:07 +0000
Message-ID: <6e041187f6284c78bda53bdc7abc46ca@amazon.com>
References: <20240129085531.15608-1-darinzon@amazon.com>
 <20240129085531.15608-6-darinzon@amazon.com>
 <b4e44b37-8a0a-491d-a248-0b50f6668e17@amd.com>
In-Reply-To: <b4e44b37-8a0a-491d-a248-0b50f6668e17@amd.com>
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
VGhlIGZ1bmN0aW9uYWxpdHkgd2FzIGFkZGVkIHRvIGFsbG93IHRoZSBkcml2ZXJzIHRvIGNyZWF0
ZSBhbiBTUSBhbmQNCj4gPiBDUSBvZiBkaWZmZXJlbnQgc2l6ZXMuDQo+ID4gV2hlbiB0aGUgUlgv
VFggU1EgYW5kIENRIGhhdmUgdGhlIHNhbWUgc2l6ZSwgc3VjaCB1cGRhdGUgaXNuJ3QNCj4gPiBu
ZWNlc3NhcnkgYXMgdGhlIGRldmljZSBjYW4gc2FmZWx5IGFzc3VtZSBpdCBkb2Vzbid0IG92ZXJy
aWRlDQo+ID4gdW5wcm9jZXNzZWQgY29tcGxldGlvbnMuIEhvd2V2ZXIsIGlmIHRoZSBTUSBpcyBs
YXJnZXIgdGhhbiB0aGUgQ1EsIHRoZQ0KPiA+IGRldmljZSBtaWdodCAiaGF2ZSIgbW9yZSBjb21w
bGV0aW9ucyBpdCB3YW50cyB0byB1cGRhdGUgYWJvdXQgdGhhbg0KPiA+IHRoZXJlJ3Mgcm9vbSBp
biB0aGUgQ1EuDQo+ID4NCj4gPiBUaGVyZSdzIG5vIHN1cHBvcnQgZm9yIGRpZmZlcmVudCBTUSBh
bmQgQ1Egc2l6ZXMsIHRoZXJlZm9yZSwgcmVtb3ZpbmcNCj4gPiB0aGUgQVBJIGFuZCBpdHMgdXNh
Z2UuDQo+ID4NCj4gPiAnX19fX2NhY2hlbGluZV9hbGlnbmVkJyBjb21waWxlciBhdHRyaWJ1dGUg
d2FzIGFkZGVkIHRvICdzdHJ1Y3QNCj4gPiBlbmFfY29tX2lvX2NxJyB0byBlbnN1cmUgdGhhdCB0
aGUgcmVtb3ZhbCBvZiB0aGUgJ2NxX2hlYWRfZGJfcmVnJw0KPiA+IGZpZWxkIGRvZXNuJ3QgY2hh
bmdlIHRoZSBjYWNoZS1saW5lIGxheW91dCBvZiB0aGlzIHN0cnVjdC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNoYXkgQWdyb3NraW4gPHNoYXlhZ3JAYW1hem9uLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBEYXZpZCBBcmluem9uIDxkYXJpbnpvbkBhbWF6b24uY29tPg0KPiA+IC0tLQ0KPiA+
ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfY29tLmMgICAgIHwgIDUgLS0t
LQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfY29tLmggICAgIHwg
IDUgKy0tLQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfZXRoX2Nv
bS5oIHwgMjQgLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQv
YW1hem9uL2VuYS9lbmFfbmV0ZGV2LmMgIHwgIDUgKy0tLQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvYW1hem9uL2VuYS9lbmFfeGRwLmMgICAgIHwgIDEgLQ0KPiA+ICAgNSBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FtYXpvbi9lbmEvZW5hX2NvbS5jDQo+ID4gYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9hbWF6b24vZW5hL2VuYV9jb20uYw0KPiA+IGluZGV4IDlhOGE0M2Iu
LjY3NWVlNzIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2Vu
YS9lbmFfY29tLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9hbWF6b24vZW5hL2Vu
YV9jb20uYw0KPiA+IEBAIC0xNDI3LDExICsxNDI3LDYgQEAgaW50IGVuYV9jb21fY3JlYXRlX2lv
X2NxKHN0cnVjdCBlbmFfY29tX2Rldg0KPiAqZW5hX2RldiwNCj4gPiAgICAgICAgICBpb19jcS0+
dW5tYXNrX3JlZyA9ICh1MzIgX19pb21lbSAqKSgodWludHB0cl90KWVuYV9kZXYtPnJlZ19iYXIN
Cj4gKw0KPiA+ICAgICAgICAgICAgICAgICAgY21kX2NvbXBsZXRpb24uY3FfaW50ZXJydXB0X3Vu
bWFza19yZWdpc3Rlcl9vZmZzZXQpOw0KPiA+DQo+ID4gLSAgICAgICBpZiAoY21kX2NvbXBsZXRp
b24uY3FfaGVhZF9kYl9yZWdpc3Rlcl9vZmZzZXQpDQo+ID4gLSAgICAgICAgICAgICAgIGlvX2Nx
LT5jcV9oZWFkX2RiX3JlZyA9DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgKHUzMiBfX2lv
bWVtICopKCh1aW50cHRyX3QpZW5hX2Rldi0+cmVnX2JhciArDQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgY21kX2NvbXBsZXRpb24uY3FfaGVhZF9kYl9yZWdpc3Rlcl9vZmZzZXQpOw0KPiA+
IC0NCj4gPiAgICAgICAgICBpZiAoY21kX2NvbXBsZXRpb24ubnVtYV9ub2RlX3JlZ2lzdGVyX29m
ZnNldCkNCj4gPiAgICAgICAgICAgICAgICAgIGlvX2NxLT5udW1hX25vZGVfY2ZnX3JlZyA9DQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICh1MzIgX19pb21lbSAqKSgodWludHB0cl90KWVu
YV9kZXYtPnJlZ19iYXIgKw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9h
bWF6b24vZW5hL2VuYV9jb20uaA0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2Vu
YS9lbmFfY29tLmgNCj4gPiBpbmRleCBmMzE3NmZjLi44ZjkwYzNjIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2FtYXpvbi9lbmEvZW5hX2NvbS5oDQo+ID4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfY29tLmgNCj4gPiBAQCAtMTA5LDggKzEw
OSw2IEBAIHN0cnVjdCBlbmFfY29tX2lvX2NxIHsNCj4gPiAgICAgICAgICAvKiBJbnRlcnJ1cHQg
dW5tYXNrIHJlZ2lzdGVyICovDQo+ID4gICAgICAgICAgdTMyIF9faW9tZW0gKnVubWFza19yZWc7
DQo+ID4NCj4gPiAtICAgICAgIC8qIFRoZSBjb21wbGV0aW9uIHF1ZXVlIGhlYWQgZG9vcmJlbGwg
cmVnaXN0ZXIgKi8NCj4gPiAtICAgICAgIHUzMiBfX2lvbWVtICpjcV9oZWFkX2RiX3JlZzsNCj4g
DQo+IFlvdSdsbCB3YW50IHRvIHJlbW92ZSBvbmUgb2YgdGhlIHN1cnJvdW5kaW5nIGJsYW5rIGxp
bmVzIGFzIHdlbGwgc28gYXMgdG8gbm90DQo+IGVuZCB1cCB3aXRoIG11bHRpcGxlIGJsYW5rcyBp
biBhIHJvdy4NCj4gDQo+IHNsbg0KPiANCg0KR29vZCBjYXRjaCEgVGhhbmtzIGZvciBub3RpY2lu
ZyBpdC4gV2lsbCBmaXggaXQgaW4gdGhlIG5leHQgcGF0Y2hzZXQuDQoNCkRhdmlkDQoNCj4gPg0K
PiA+ICAgICAgICAgIC8qIG51bWEgY29uZmlndXJhdGlvbiByZWdpc3RlciAoZm9yIFRQSCkgKi8N
Cj4gPiAgICAgICAgICB1MzIgX19pb21lbSAqbnVtYV9ub2RlX2NmZ19yZWc7IEBAIC0xMTgsNyAr
MTE2LDcgQEAgc3RydWN0DQo+ID4gZW5hX2NvbV9pb19jcSB7DQo+ID4gICAgICAgICAgLyogVGhl
IHZhbHVlIHRvIHdyaXRlIHRvIHRoZSBhYm92ZSByZWdpc3RlciB0byB1bm1hc2sNCj4gPiAgICAg
ICAgICAgKiB0aGUgaW50ZXJydXB0IG9mIHRoaXMgcXVldWUNCj4gPiAgICAgICAgICAgKi8NCj4g
PiAtICAgICAgIHUzMiBtc2l4X3ZlY3RvcjsNCj4gPiArICAgICAgIHUzMiBtc2l4X3ZlY3RvciBf
X19fY2FjaGVsaW5lX2FsaWduZWQ7DQo+ID4NCj4gPiAgICAgICAgICBlbnVtIHF1ZXVlX2RpcmVj
dGlvbiBkaXJlY3Rpb247DQo+ID4NCj4gPiBAQCAtMTM0LDcgKzEzMiw2IEBAIHN0cnVjdCBlbmFf
Y29tX2lvX2NxIHsNCj4gPiAgICAgICAgICAvKiBEZXZpY2UgcXVldWUgaW5kZXggKi8NCj4gPiAg
ICAgICAgICB1MTYgaWR4Ow0KPiA+ICAgICAgICAgIHUxNiBoZWFkOw0KPiA+IC0gICAgICAgdTE2
IGxhc3RfaGVhZF91cGRhdGU7DQo+ID4gICAgICAgICAgdTggcGhhc2U7DQo+ID4gICAgICAgICAg
dTggY2Rlc2NfZW50cnlfc2l6ZV9pbl9ieXRlczsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9hbWF6b24vZW5hL2VuYV9ldGhfY29tLmgNCj4gPiBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2FtYXpvbi9lbmEvZW5hX2V0aF9jb20uaA0KPiA+IGluZGV4IDM3MmIyNTku
LjRkNjVkODIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2Vu
YS9lbmFfZXRoX2NvbS5oDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2Vu
YS9lbmFfZXRoX2NvbS5oDQo+ID4gQEAgLTgsOCArOCw2IEBADQo+ID4NCj4gPiAgICNpbmNsdWRl
ICJlbmFfY29tLmgiDQo+ID4NCj4gPiAtLyogaGVhZCB1cGRhdGUgdGhyZXNob2xkIGluIHVuaXRz
IG9mIChxdWV1ZSBzaXplIC8NCj4gPiBFTkFfQ09NUF9IRUFEX1RIUkVTSCkgKi8gLSNkZWZpbmUg
RU5BX0NPTVBfSEVBRF9USFJFU0ggNA0KPiA+ICAgLyogd2UgYWxsb3cgMiBETUEgZGVzY3JpcHRv
cnMgcGVyIExMUSBlbnRyeSAqLw0KPiA+ICAgI2RlZmluZSBFTkFfTExRX0VOVFJZX0RFU0NfQ0hV
TktfU0laRSAgKDIgKiBzaXplb2Yoc3RydWN0DQo+IGVuYV9ldGhfaW9fdHhfZGVzYykpDQo+ID4g
ICAjZGVmaW5lIEVOQV9MTFFfSEVBREVSICAgICAgICAgKDEyOFVMIC0NCj4gRU5BX0xMUV9FTlRS
WV9ERVNDX0NIVU5LX1NJWkUpDQo+ID4gQEAgLTE3MiwyOCArMTcwLDYgQEAgc3RhdGljIGlubGlu
ZSBpbnQgZW5hX2NvbV93cml0ZV9zcV9kb29yYmVsbChzdHJ1Y3QNCj4gZW5hX2NvbV9pb19zcSAq
aW9fc3EpDQo+ID4gICAgICAgICAgcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiAtc3RhdGlj
IGlubGluZSBpbnQgZW5hX2NvbV91cGRhdGVfZGV2X2NvbXBfaGVhZChzdHJ1Y3QgZW5hX2NvbV9p
b19jcQ0KPiA+ICppb19jcSkgLXsNCj4gPiAtICAgICAgIHUxNiB1bnJlcG9ydGVkX2NvbXAsIGhl
YWQ7DQo+ID4gLSAgICAgICBib29sIG5lZWRfdXBkYXRlOw0KPiA+IC0NCj4gPiAtICAgICAgIGlm
ICh1bmxpa2VseShpb19jcS0+Y3FfaGVhZF9kYl9yZWcpKSB7DQo+ID4gLSAgICAgICAgICAgICAg
IGhlYWQgPSBpb19jcS0+aGVhZDsNCj4gPiAtICAgICAgICAgICAgICAgdW5yZXBvcnRlZF9jb21w
ID0gaGVhZCAtIGlvX2NxLT5sYXN0X2hlYWRfdXBkYXRlOw0KPiA+IC0gICAgICAgICAgICAgICBu
ZWVkX3VwZGF0ZSA9IHVucmVwb3J0ZWRfY29tcCA+IChpb19jcS0+cV9kZXB0aCAvDQo+IEVOQV9D
T01QX0hFQURfVEhSRVNIKTsNCj4gPiAtDQo+ID4gLSAgICAgICAgICAgICAgIGlmICh1bmxpa2Vs
eShuZWVkX3VwZGF0ZSkpIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBuZXRkZXZfZGJn
KGVuYV9jb21faW9fY3FfdG9fZW5hX2Rldihpb19jcSktDQo+ID5uZXRfZGV2aWNlLA0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIldyaXRlIGNvbXBsZXRpb24gcXVldWUg
ZG9vcmJlbGwgZm9yIHF1ZXVlICVkOiBoZWFkOg0KPiAlZFxuIiwNCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGlvX2NxLT5xaWQsIGhlYWQpOw0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgIHdyaXRlbChoZWFkLCBpb19jcS0+Y3FfaGVhZF9kYl9yZWcpOw0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGlvX2NxLT5sYXN0X2hlYWRfdXBkYXRlID0gaGVhZDsNCj4g
PiAtICAgICAgICAgICAgICAgfQ0KPiA+IC0gICAgICAgfQ0KPiA+IC0NCj4gPiAtICAgICAgIHJl
dHVybiAwOw0KPiA+IC19DQo+ID4gLQ0KPiA+ICAgc3RhdGljIGlubGluZSB2b2lkIGVuYV9jb21f
dXBkYXRlX251bWFfbm9kZShzdHJ1Y3QgZW5hX2NvbV9pb19jcQ0KPiAqaW9fY3EsDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTggbnVtYV9ub2RlKQ0K
PiA+ICAgew0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9hbWF6b24vZW5h
L2VuYV9uZXRkZXYuYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFf
bmV0ZGV2LmMNCj4gPiBpbmRleCAwYjdmOTRmLi5jZDc1ZTVhIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L2FtYXpvbi9lbmEvZW5hX25ldGRldi5jDQo+ID4gKysrIGIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfbmV0ZGV2LmMNCj4gPiBAQCAtODU2LDcg
Kzg1Niw2IEBAIHN0YXRpYyBpbnQgZW5hX2NsZWFuX3R4X2lycShzdHJ1Y3QgZW5hX3JpbmcNCj4g
PiAqdHhfcmluZywgdTMyIGJ1ZGdldCkNCj4gPg0KPiA+ICAgICAgICAgIHR4X3JpbmctPm5leHRf
dG9fY2xlYW4gPSBuZXh0X3RvX2NsZWFuOw0KPiA+ICAgICAgICAgIGVuYV9jb21fY29tcF9hY2so
dHhfcmluZy0+ZW5hX2NvbV9pb19zcSwgdG90YWxfZG9uZSk7DQo+ID4gLSAgICAgICBlbmFfY29t
X3VwZGF0ZV9kZXZfY29tcF9oZWFkKHR4X3JpbmctPmVuYV9jb21faW9fY3EpOw0KPiA+DQo+ID4g
ICAgICAgICAgbmV0ZGV2X3R4X2NvbXBsZXRlZF9xdWV1ZSh0eHEsIHR4X3BrdHMsIHR4X2J5dGVz
KTsNCj4gPg0KPiA+IEBAIC0xMzAzLDEwICsxMzAyLDggQEAgc3RhdGljIGludCBlbmFfY2xlYW5f
cnhfaXJxKHN0cnVjdCBlbmFfcmluZw0KPiAqcnhfcmluZywgc3RydWN0IG5hcGlfc3RydWN0ICpu
YXBpLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgRU5BX1JYX1JFRklMTF9USFJFU0hfUEFD
S0VUKTsNCj4gPg0KPiA+ICAgICAgICAgIC8qIE9wdGltaXphdGlvbiwgdHJ5IHRvIGJhdGNoIG5l
dyByeCBidWZmZXJzICovDQo+ID4gLSAgICAgICBpZiAocmVmaWxsX3JlcXVpcmVkID4gcmVmaWxs
X3RocmVzaG9sZCkgew0KPiA+IC0gICAgICAgICAgICAgICBlbmFfY29tX3VwZGF0ZV9kZXZfY29t
cF9oZWFkKHJ4X3JpbmctPmVuYV9jb21faW9fY3EpOw0KPiA+ICsgICAgICAgaWYgKHJlZmlsbF9y
ZXF1aXJlZCA+IHJlZmlsbF90aHJlc2hvbGQpDQo+ID4gICAgICAgICAgICAgICAgICBlbmFfcmVm
aWxsX3J4X2J1ZnMocnhfcmluZywgcmVmaWxsX3JlcXVpcmVkKTsNCj4gPiAtICAgICAgIH0NCj4g
Pg0KPiA+ICAgICAgICAgIGlmICh4ZHBfZmxhZ3MgJiBFTkFfWERQX1JFRElSRUNUKQ0KPiA+ICAg
ICAgICAgICAgICAgICAgeGRwX2RvX2ZsdXNoKCk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2FtYXpvbi9lbmEvZW5hX3hkcC5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9hbWF6b24vZW5hL2VuYV94ZHAuYw0KPiA+IGluZGV4IGZjMWM0ZWYuLjMzN2M0MzUgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYW1hem9uL2VuYS9lbmFfeGRwLmMN
Cj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9hbWF6b24vZW5hL2VuYV94ZHAuYw0KPiA+
IEBAIC00MTIsNyArNDEyLDYgQEAgc3RhdGljIGludCBlbmFfY2xlYW5feGRwX2lycShzdHJ1Y3Qg
ZW5hX3JpbmcNCj4gPiAqdHhfcmluZywgdTMyIGJ1ZGdldCkNCj4gPg0KPiA+ICAgICAgICAgIHR4
X3JpbmctPm5leHRfdG9fY2xlYW4gPSBuZXh0X3RvX2NsZWFuOw0KPiA+ICAgICAgICAgIGVuYV9j
b21fY29tcF9hY2sodHhfcmluZy0+ZW5hX2NvbV9pb19zcSwgdG90YWxfZG9uZSk7DQo+ID4gLSAg
ICAgICBlbmFfY29tX3VwZGF0ZV9kZXZfY29tcF9oZWFkKHR4X3JpbmctPmVuYV9jb21faW9fY3Ep
Ow0KPiA+DQo+ID4gICAgICAgICAgbmV0aWZfZGJnKHR4X3JpbmctPmFkYXB0ZXIsIHR4X2RvbmUs
IHR4X3JpbmctPm5ldGRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgInR4X3BvbGw6IHEgJWQg
ZG9uZS4gdG90YWwgcGt0czogJWRcbiIsDQo+ID4gLS0NCj4gPiAyLjQwLjENCj4gPg0KPiA+DQoN
Cg==

