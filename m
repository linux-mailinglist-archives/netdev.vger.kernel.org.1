Return-Path: <netdev+bounces-68074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FFF845BF0
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A1B28EE13
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7607477A10;
	Thu,  1 Feb 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="O5wQEsbe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA175779F2
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802209; cv=none; b=Zqr/XWGRFxzx1a+gqvQUfPXJiunTwhKsy4zIFs/GBtrYlT0hPlAy/IE/OzqsfL4m8Kj4+qciU2PNG2tsGophUXEb3yzwZOpqdgwW7qQdPVWgGdjLhyR+gZC9S3Pq/i9QFXuq4XqqpAG/jHrQYu+i5ZhmHyDgIvqAz00rASazPfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802209; c=relaxed/simple;
	bh=Z29ZR/EjH8m9OY3E1I/2XD2rxvlo0AkZo4ZpeQEtEXY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bY301lBlBHIoELfgzHACbzHE1K7EDxRC8b847Y70q23x7q0gn9dsgbrioThdYuMtgElAoE/20/mi83UjSCCxfQefWlO90y/IqZDZk4bH2He+FoEXo6NztjRTeLV7MznnpLRLZOpiuGfqQsyoRdxslra37uYfNTPL+P5B8NZnXug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=O5wQEsbe; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706802207; x=1738338207;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=Z29ZR/EjH8m9OY3E1I/2XD2rxvlo0AkZo4ZpeQEtEXY=;
  b=O5wQEsbeJW+Ks6IUWBiqESfgspWOqsseu5dJYhLkQGHivC+OTxwldm8C
   Q/mlC3SkQpnHRbSxasb5KzCAq+pSLRACeSWnpcmwuZRS/1wL1ooozBcDj
   VtJa0dQl+wxDpnEETW/8mbOQcCfHt0lf0wIpqD/fpL3k+i2ewAPLjrjb+
   M=;
X-IronPort-AV: E=Sophos;i="6.05,234,1701129600"; 
   d="scan'208";a="62928904"
Subject: RE: [PATCH v2 net-next 07/11] net: ena: Add more information on TX timeouts
Thread-Topic: [PATCH v2 net-next 07/11] net: ena: Add more information on TX timeouts
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 15:43:25 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:2088]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.192:2525] with esmtp (Farcaster)
 id dc1be9c2-c1ee-4540-9131-54ba720031fa; Thu, 1 Feb 2024 15:43:24 +0000 (UTC)
X-Farcaster-Flow-ID: dc1be9c2-c1ee-4540-9131-54ba720031fa
Received: from EX19D028EUB001.ant.amazon.com (10.252.61.99) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 15:43:24 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D028EUB001.ant.amazon.com (10.252.61.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 15:43:23 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1118.040; Thu, 1 Feb 2024 15:43:23 +0000
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
Thread-Index: AQHaVQiihfQLMBh6a0WU5j7lr2v9nrD1c0hAgAAauoCAABFHUA==
Date: Thu, 1 Feb 2024 15:43:23 +0000
Message-ID: <4e6160bad7144dbc8c98cac49dbe3891@amazon.com>
References: <20240130095353.2881-1-darinzon@amazon.com>
	 <20240130095353.2881-8-darinzon@amazon.com>
	 <1fd466f101f22db4ea57f2c912e1fa25803d233b.camel@redhat.com>
	 <b5ab983d43284d298fdc0d1268b33053@amazon.com>
 <1878748538c778a0f0d7fb23cafc4a661132097d.camel@redhat.com>
In-Reply-To: <1878748538c778a0f0d7fb23cafc4a661132097d.camel@redhat.com>
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

PiBPbiBUaHUsIDIwMjQtMDItMDEgYXQgMTM6MjEgKzAwMDAsIEFyaW56b24sIERhdmlkIHdyb3Rl
Og0KPiA+ID4gT24gVHVlLCAyMDI0LTAxLTMwIGF0IDA5OjUzICswMDAwLCBkYXJpbnpvbkBhbWF6
b24uY29tIHdyb3RlOg0KPiA+ID4gPiBAQCAtMzQwOCwyNSArMzQzNyw0NSBAQCBzdGF0aWMgaW50
DQo+ID4gPiBjaGVja19taXNzaW5nX2NvbXBfaW5fdHhfcXVldWUoc3RydWN0IGVuYV9hZGFwdGVy
ICphZGFwdGVyLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgYWRhcHRlci0+bWlzc2lu
Z190eF9jb21wbGV0aW9uX3RvKTsNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgICAgICAgICBpZiAo
dW5saWtlbHkoaXNfdHhfY29tcF90aW1lX2V4cGlyZWQpKSB7DQo+ID4gPiA+IC0gICAgICAgICAg
ICAgICAgICAgICBpZiAoIXR4X2J1Zi0+cHJpbnRfb25jZSkgew0KPiA+ID4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB0aW1lX3NpbmNlX2xhc3RfbmFwaSA9IGppZmZpZXNfdG9fdXNl
Y3MoamlmZmllcyAtIHR4X3JpbmctDQo+ID4gPiA+IHR4X3N0YXRzLmxhc3RfbmFwaV9qaWZmaWVz
KTsNCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWlzc2luZ190eF9jb21w
X3RvID0gamlmZmllc190b19tc2VjcyhhZGFwdGVyLQ0KPiA+ID4gPiBtaXNzaW5nX3R4X2NvbXBs
ZXRpb25fdG8pOw0KPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXRpZl9u
b3RpY2UoYWRhcHRlciwgdHhfZXJyLCBhZGFwdGVyLT5uZXRkZXYsDQo+ID4gPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRm91bmQgYSBUeCB0aGF0IHdhc24n
dCBjb21wbGV0ZWQgb24gdGltZSwgcWlkDQo+ICVkLA0KPiA+ID4gaW5kZXggJWQuICV1IHVzZWNz
IGhhdmUgcGFzc2VkIHNpbmNlIGxhc3QgbmFwaSBleGVjdXRpb24uIE1pc3NpbmcgVHgNCj4gPiA+
IHRpbWVvdXQgdmFsdWUgJXUgbXNlY3NcbiIsDQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB0eF9yaW5nLT5xaWQsIGksIHRpbWVfc2luY2VfbGFzdF9u
YXBpLA0KPiA+ID4gbWlzc2luZ190eF9jb21wX3RvKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIHRpbWVfc2luY2VfbGFzdF9uYXBpID0NCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgamlmZmllc190b191c2VjcyhqaWZmaWVzIC0gdHhfcmluZy0NCj4gPnR4X3N0
YXRzLmxhc3RfbmFwaV9qaWZmaWVzKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIG5h
cGlfc2NoZWR1bGVkID0gISEoZW5hX25hcGktPm5hcGkuc3RhdGUgJg0KPiA+ID4gPiArIE5BUElG
X1NUQVRFX1NDSEVEKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
aWYgKG1pc3NpbmdfdHhfY29tcF90byA8DQo+ID4gPiA+ICsgdGltZV9zaW5jZV9sYXN0X25hcGkg
JiYNCj4gPiA+IG5hcGlfc2NoZWR1bGVkKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC8qIFdlIHN1c3BlY3QgbmFwaSBpc24ndCBjYWxsZWQgYmVjYXVzZSB0aGUNCj4g
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICogYm90dG9tIGhhbGYgaXMgbm90
IHJ1bi4gUmVxdWlyZSBhIGJpZ2dlcg0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKiB0aW1lb3V0IGZvciB0aGVzZSBjYXNlcw0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKi8NCj4gPiA+DQo+ID4gPiBOb3QgYmxvY2tpbmcgdGhpcyBzZXJpZXMs
IGJ1dCBJIGd1ZXNzIHRoZSBhYm92ZSAidGhlIGJvdHRvbSBoYWxmIGlzDQo+ID4gPiBub3QgcnVu
IiwgYWZ0ZXIgY29tbWl0IGQxNTEyMWJlNzQ4NTY1NTEyOTEwMWYzOTYwYWU2YWRkNDAyMDQ0NjMs
DQo+ID4gPiBoYXBwZW5zIG9ubHkgd2hlbiBydW5uaW5nIGluIG5hcGkgdGhyZWFkZWQgbW9kZSwg
cmlnaHQ/DQo+ID4gPg0KPiA+ID4gY2hlZXJzLA0KPiA+ID4NCj4gPiA+IFBhb2xvDQo+ID4NCj4g
PiBIaSBQYW9sbywNCj4gPg0KPiA+IFRoZSBFTkEgZHJpdmVyIG5hcGkgcm91dGluZSBkb2Vzbid0
IHJ1biBpbiB0aHJlYWRlZCBtb2RlLg0KPiANCj4gLi4uIHVubGVzcyB5b3UgZG86DQo+IA0KPiBl
Y2hvIDEgPiAvc3lzL2NsYXNzL25ldC88bmljIG5hbWU+L3RocmVhZGVkDQo+IA0KPiA6KQ0KPiAN
Cg0KVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dC4gV2Ugd2lsbCBsb29rIGludG8gdGhpcyBm
dXJ0aGVyLg0KDQo+ID4gV2UndmUgc2VlbiBjYXNlcyB3aGVyZSBuYXBpIGlzIGluZGVlZCBzY2hl
ZHVsZWQsIGJ1dCBkaWRuJ3QgZ2V0IGENCj4gPiBjaGFuY2UgdG8gcnVuIGZvciBhIG5vdGljZWFi
bGUgYW1vdW50IG9mIHRpbWUgYW5kIHByb2Nlc3MgVFgNCj4gPiBjb21wbGV0aW9ucywgYW5kIGJh
c2VkIG9uIHRoYXQgd2UgY29uY2x1ZGUgdGhhdCB0aGVyZSdzIGEgaGlnaCBDUFUNCj4gPiBsb2Fk
IHRoYXQgZG9lc24ndCBhbGxvdyB0aGUgcm91dGluZSB0byBydW4gaW4gYSB0aW1lbHkgbWFubmVy
Lg0KPiA+IEJhc2VkIG9uIHRoZSBpbmZvcm1hdGlvbiBpbg0KPiBkMTUxMjFiZTc0ODU2NTUxMjkx
MDFmMzk2MGFlNmFkZDQwMjA0NDYzLA0KPiA+IHRoZSBvYnNlcnZlZCBzdGFsbHMgYXJlIGluIHRo
ZSBtYWduaXR1ZGUgb2YgbWlsbGlzZWNvbmRzLCB0aGUgYWJvdmUNCj4gPiBjb2RlIGlzIGFjdHVh
bGx5IGFuIGFkZGl0aW9uYWwgZ3JhY2UgdGltZSwgYW5kIHRoZSB0aW1lb3V0cyBoZXJlIGFyZSBp
bg0KPiBzZWNvbmRzLg0KPiANCj4gRG8gSSByZWFkIGNvcnJlY3RseSB0aGF0IGluIHlvdXIgc2Nl
bmFyaW8gdGhlIG5hcGkgaW5zdGFuY2UgaXMgbm90IHNjaGVkdWxlZCBmb3INCj4gX3NlY29uZHNf
PyAgVGhhdCBzbWVsbHMgbGlrZSBhIHNlcmlvdXMgYnVnIHNvbWV3aGVyZSBlbHNlIHJlYWxseSB3
b3J0aHkgb2YNCj4gbW9yZSBpbnZlc3RpZ2F0aW9uLg0KPiANCj4gQ2hlZXJzLA0KPiANCj4gUGFv
bG8NCj4gDQoNClRoYW5rcyBmb3Igbm90aW5nIHRoaXMuIEl0IGlzIHNvbWV0aGluZyB0aGF0IHdl
J3JlIGFjdGl2ZWx5IG1vbml0b3JpbmcgYW5kIGxvb2tpbmcgdG8gaW1wcm92ZS4NCg0KVGhhbmtz
LA0KRGF2aWQNCg0K

