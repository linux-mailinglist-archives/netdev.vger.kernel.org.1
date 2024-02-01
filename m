Return-Path: <netdev+bounces-67988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C98458C5
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D643FB28CE5
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F811A27A;
	Thu,  1 Feb 2024 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hiCeCig4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474086658
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793716; cv=none; b=ElXh8LR5RFNDLuYMCWjZ7DHVy47uwKDkRHJpUg8ffufMDTFstOhrKnpmiA1zZ/zmrHHhTj71QD585+y8Z0AFSl/1fatlqYWCgvXHsN4i7h1XgDw0wtjJqu+fTFtQajGzt5VgMMTf2FURb5dMtyxgmTiJi/wrgjaQVepPVnNUzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793716; c=relaxed/simple;
	bh=Rzy+zuth/OHi9jeBfu5Ejh9vR1sAHPlvAYyHg3oaLug=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bgrbF9QbO8F7gksd19l/ygdgIsIJm2gRwAfAl2p9L5DGzD3vdGz523nQ5+QSmfjB4pPQphWAEOS/SnENyBTUXnW1bswZPDq5gaZn/AxVVvX43AG26OWC19hImowSR0qwlvxneXikKvDn2rZMxsWq1DkTIsrZJuVNsIzdHS3z5tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hiCeCig4; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706793716; x=1738329716;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=Rzy+zuth/OHi9jeBfu5Ejh9vR1sAHPlvAYyHg3oaLug=;
  b=hiCeCig4x8Z4LhENwG0Mfq1DeZklilxI4ivKzmzgF4p4rzM7B1oQVcdD
   ZCbVHAFbMpIrnW+mk1W+5moVnx8CmQ3SZRi5huv4fm1sQ+pPNewJ3WyZr
   85wLb81MxF/S97hVCfOJ+XdElh6x4kWDX34m8B+eFUCvSG9e1I02nvuaF
   g=;
X-IronPort-AV: E=Sophos;i="6.05,234,1701129600"; 
   d="scan'208";a="271109955"
Subject: RE: [PATCH v2 net-next 07/11] net: ena: Add more information on TX timeouts
Thread-Topic: [PATCH v2 net-next 07/11] net: ena: Add more information on TX timeouts
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 13:21:53 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:20831]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id 3cda90a5-ed92-4dc4-8a18-64bb254f83b5; Thu, 1 Feb 2024 13:21:51 +0000 (UTC)
X-Farcaster-Flow-ID: 3cda90a5-ed92-4dc4-8a18-64bb254f83b5
Received: from EX19D030EUB002.ant.amazon.com (10.252.61.16) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 13:21:45 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D030EUB002.ant.amazon.com (10.252.61.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 13:21:45 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1118.040; Thu, 1 Feb 2024 13:21:45 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Paolo Abeni <pabeni@redhat.com>, "Nelson, Shannon"
	<shannon.nelson@amd.com>, David Miller <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
	<zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Koler, Nati" <nkoler@amazon.com>
Thread-Index: AQHaVQiihfQLMBh6a0WU5j7lr2v9nrD1c0hA
Date: Thu, 1 Feb 2024 13:21:44 +0000
Message-ID: <b5ab983d43284d298fdc0d1268b33053@amazon.com>
References: <20240130095353.2881-1-darinzon@amazon.com>
	 <20240130095353.2881-8-darinzon@amazon.com>
 <1fd466f101f22db4ea57f2c912e1fa25803d233b.camel@redhat.com>
In-Reply-To: <1fd466f101f22db4ea57f2c912e1fa25803d233b.camel@redhat.com>
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

PiBPbiBUdWUsIDIwMjQtMDEtMzAgYXQgMDk6NTMgKzAwMDAsIGRhcmluem9uQGFtYXpvbi5jb20g
d3JvdGU6DQo+ID4gQEAgLTM0MDgsMjUgKzM0MzcsNDUgQEAgc3RhdGljIGludA0KPiBjaGVja19t
aXNzaW5nX2NvbXBfaW5fdHhfcXVldWUoc3RydWN0IGVuYV9hZGFwdGVyICphZGFwdGVyLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICBhZGFwdGVyLT5taXNzaW5nX3R4X2NvbXBsZXRpb25fdG8p
Ow0KPiA+DQo+ID4gICAgICAgICAgICAgICBpZiAodW5saWtlbHkoaXNfdHhfY29tcF90aW1lX2V4
cGlyZWQpKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIGlmICghdHhfYnVmLT5wcmludF9v
bmNlKSB7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGltZV9zaW5jZV9sYXN0
X25hcGkgPSBqaWZmaWVzX3RvX3VzZWNzKGppZmZpZXMgLSB0eF9yaW5nLQ0KPiA+dHhfc3RhdHMu
bGFzdF9uYXBpX2ppZmZpZXMpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1p
c3NpbmdfdHhfY29tcF90byA9IGppZmZpZXNfdG9fbXNlY3MoYWRhcHRlci0NCj4gPm1pc3Npbmdf
dHhfY29tcGxldGlvbl90byk7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbmV0
aWZfbm90aWNlKGFkYXB0ZXIsIHR4X2VyciwgYWRhcHRlci0+bmV0ZGV2LA0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRm91bmQgYSBUeCB0aGF0IHdhc24n
dCBjb21wbGV0ZWQgb24gdGltZSwgcWlkICVkLA0KPiBpbmRleCAlZC4gJXUgdXNlY3MgaGF2ZSBw
YXNzZWQgc2luY2UgbGFzdCBuYXBpIGV4ZWN1dGlvbi4gTWlzc2luZyBUeA0KPiB0aW1lb3V0IHZh
bHVlICV1IG1zZWNzXG4iLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB0eF9yaW5nLT5xaWQsIGksIHRpbWVfc2luY2VfbGFzdF9uYXBpLA0KPiBtaXNzaW5n
X3R4X2NvbXBfdG8pOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICB0aW1lX3NpbmNlX2xhc3Rf
bmFwaSA9DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgamlmZmllc190b191c2Vj
cyhqaWZmaWVzIC0gdHhfcmluZy0+dHhfc3RhdHMubGFzdF9uYXBpX2ppZmZpZXMpOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBuYXBpX3NjaGVkdWxlZCA9ICEhKGVuYV9uYXBpLT5uYXBpLnN0
YXRlICYNCj4gPiArIE5BUElGX1NUQVRFX1NDSEVEKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIGlmIChtaXNzaW5nX3R4X2NvbXBfdG8gPCB0aW1lX3NpbmNlX2xhc3RfbmFwaSAm
Jg0KPiBuYXBpX3NjaGVkdWxlZCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC8qIFdlIHN1c3BlY3QgbmFwaSBpc24ndCBjYWxsZWQgYmVjYXVzZSB0aGUNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKiBib3R0b20gaGFsZiBpcyBub3QgcnVuLiBSZXF1aXJl
IGEgYmlnZ2VyDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogdGltZW91dCBm
b3IgdGhlc2UgY2FzZXMNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4g
DQo+IE5vdCBibG9ja2luZyB0aGlzIHNlcmllcywgYnV0IEkgZ3Vlc3MgdGhlIGFib3ZlICJ0aGUg
Ym90dG9tIGhhbGYgaXMgbm90IHJ1biIsDQo+IGFmdGVyIGNvbW1pdCBkMTUxMjFiZTc0ODU2NTUx
MjkxMDFmMzk2MGFlNmFkZDQwMjA0NDYzLCBoYXBwZW5zIG9ubHkNCj4gd2hlbiBydW5uaW5nIGlu
IG5hcGkgdGhyZWFkZWQgbW9kZSwgcmlnaHQ/DQo+IA0KPiBjaGVlcnMsDQo+IA0KPiBQYW9sbw0K
DQpIaSBQYW9sbywNCg0KVGhlIEVOQSBkcml2ZXIgbmFwaSByb3V0aW5lIGRvZXNuJ3QgcnVuIGlu
IHRocmVhZGVkIG1vZGUuDQpXZSd2ZSBzZWVuIGNhc2VzIHdoZXJlIG5hcGkgaXMgaW5kZWVkIHNj
aGVkdWxlZCwgYnV0IGRpZG4ndCBnZXQgYSBjaGFuY2UNCnRvIHJ1biBmb3IgYSBub3RpY2VhYmxl
IGFtb3VudCBvZiB0aW1lIGFuZCBwcm9jZXNzIFRYIGNvbXBsZXRpb25zLA0KYW5kIGJhc2VkIG9u
IHRoYXQgd2UgY29uY2x1ZGUgdGhhdCB0aGVyZSdzIGEgaGlnaCBDUFUgbG9hZCB0aGF0IGRvZXNu
J3QgYWxsb3cNCnRoZSByb3V0aW5lIHRvIHJ1biBpbiBhIHRpbWVseSBtYW5uZXIuDQpCYXNlZCBv
biB0aGUgaW5mb3JtYXRpb24gaW4gZDE1MTIxYmU3NDg1NjU1MTI5MTAxZjM5NjBhZTZhZGQ0MDIw
NDQ2MywNCnRoZSBvYnNlcnZlZCBzdGFsbHMgYXJlIGluIHRoZSBtYWduaXR1ZGUgb2YgbWlsbGlz
ZWNvbmRzLCB0aGUgYWJvdmUgY29kZSBpcyBhY3R1YWxseQ0KYW4gYWRkaXRpb25hbCBncmFjZSB0
aW1lLCBhbmQgdGhlIHRpbWVvdXRzIGhlcmUgYXJlIGluIHNlY29uZHMuDQoNClRoYW5rcywNCkRh
dmlkDQoNCg==

