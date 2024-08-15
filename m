Return-Path: <netdev+bounces-118822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B3E952DAA
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605311F21DC8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCB41714C0;
	Thu, 15 Aug 2024 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vRX2bA4H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD47DA70
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723722042; cv=none; b=CMUXSE2jviAM7Zg7qkcK1s4s8fnHzQa4yOTbPjpEwgDmplYvA6xgkEyctGBnl50TKgfiBOTm7a7Qn9my+xl+gMrb7vgKreAgtT+xf7PkfCK/KpM/TuKPhq66hZ3T0ZhvaSmB8g+NGdY0JQJBEKab9sIS1DBPvwAH8o69/mY5eWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723722042; c=relaxed/simple;
	bh=kVCrIMobmP4Nbic0P011XUimqrdstzBHB+zvD2g4cl0=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FfMrs8hscJcj2pA+y8Dp+Stur0caqy3Vl48zep8B6MCsED/i9UN01uqdPdwcdb1yuCU3wlr5wSczmxApeB33x1whBW9cG6COlYUH6PmPj91ZaFa6yCmxkSaKAmJpeUn1lZis0sdKkJTKUx3uJvWlz+z7LqT/sb2LA8AlcNkYgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vRX2bA4H; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723722042; x=1755258042;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=kVCrIMobmP4Nbic0P011XUimqrdstzBHB+zvD2g4cl0=;
  b=vRX2bA4HaVNR61FMxki4QShxI402Z6N3kEBAEOI1xS3mPZ5t2/OXboC8
   zYaGsjzq6D1psMeSTLMHoM+VDk9p4v/LGzEsJNTTQ+eKB8K2QrnaiB+aE
   zyIWU5Kgbh1wCLAM43moZtiHh7Jrw1Qs4HKE2Q2YFBejItLGF+xHFn/ld
   k=;
X-IronPort-AV: E=Sophos;i="6.10,148,1719878400"; 
   d="scan'208";a="19102411"
Subject: RE: [RFC 0/3] ptp: Add esterror support
Thread-Topic: [RFC 0/3] ptp: Add esterror support
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 11:40:39 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:56808]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.173:2525] with esmtp (Farcaster)
 id dd8f31ff-a194-4560-a842-8546bca82efc; Thu, 15 Aug 2024 11:40:37 +0000 (UTC)
X-Farcaster-Flow-ID: dd8f31ff-a194-4560-a842-8546bca82efc
Received: from EX19D037EUB002.ant.amazon.com (10.252.61.93) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 11:40:37 +0000
Received: from EX19D047EUB004.ant.amazon.com (10.252.61.5) by
 EX19D037EUB002.ant.amazon.com (10.252.61.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 11:40:37 +0000
Received: from EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20]) by
 EX19D047EUB004.ant.amazon.com ([fe80::e4ef:7b7e:20b2:9c20%3]) with mapi id
 15.02.1258.034; Thu, 15 Aug 2024 11:40:37 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Vadim Fedorenko <vadfed@meta.com>, Maciek Machnikowski
	<maciek@machnikowski.net>, "kuba@kernel.org" <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, "Bernstein, Amit"
	<amitbern@amazon.com>
Thread-Index: AQHa7qv1iikdcHJy9EKoXFjOAK1UtbIoD6oAgAAO6ICAABN90A==
Date: Thu, 15 Aug 2024 11:40:37 +0000
Message-ID: <e61e087d636c44cba4aa94cc414e921c@amazon.com>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240814174147.761e1ea7@kernel.org>
 <38459609-c0a3-434a-aeba-31dd56eb96f8@machnikowski.net>
 <9a15379e-9c1e-4778-bda1-38474a8d9317@meta.com>
In-Reply-To: <9a15379e-9c1e-4778-bda1-38474a8d9317@meta.com>
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

PiA+DQo+ID4NCj4gPiBPbiAxNS8wOC8yMDI0IDAyOjQxLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gPj4gT24gVHVlLCAxMyBBdWcgMjAyNCAxMjo1NTo1OSArMDAwMCBNYWNpZWsgTWFjaG5pa293
c2tpIHdyb3RlOg0KPiA+Pj4gVGhpcyBwYXRjaCBzZXJpZXMgaW1wbGVtZW50cyBoYW5kbGluZyBv
ZiB0aW1leCBlc3RlcnJvciBmaWVsZCBieSBwdHANCj4gPj4+IGRldmljZXMuDQo+ID4+Pg0KPiA+
Pj4gRXN0ZXJyb3IgZmllbGQgY2FuIGJlIHVzZWQgdG8gcmV0dXJuIG9yIHNldCB0aGUgZXN0aW1h
dGVkIGVycm9yIG9mDQo+ID4+PiB0aGUgY2xvY2suIFRoaXMgaXMgdXNlZnVsIGZvciBkZXZpY2Vz
IGNvbnRhaW5pbmcgYSBoYXJkd2FyZSBjbG9jaw0KPiA+Pj4gdGhhdCBpcyBjb250cm9sbGVkIGFu
ZCBzeW5jaHJvbml6ZWQgaW50ZXJuYWxseSAoc3VjaCBhcyBhIHRpbWUgY2FyZCkNCj4gPj4+IG9y
IHdoZW4gdGhlIHN5bmNocm9uaXphdGlvbiBpcyBwdXNoZWQgdG8gdGhlIGVtYmVkZGVkIENQVSBv
ZiBhIERQVS4NCj4gPj4+DQo+ID4+PiBDdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIEFESl9FU1RF
UlJPUiBjYW4gZW5hYmxlIHB1c2hpbmcgY3VycmVudA0KPiA+Pj4gb2Zmc2V0IG9mIHRoZSBjbG9j
ayBjYWxjdWxhdGVkIGJ5IGEgdXNlcnNwYWNlIGFwcCB0byB0aGUgZGV2aWNlLA0KPiA+Pj4gd2hp
Y2ggY2FuIGFjdCB1cG9uIHRoaXMgaW5mb3JtYXRpb24gYnkgZW5hYmxpbmcgb3IgZGlzYWJsaW5n
DQo+ID4+PiB0aW1lLXJlbGF0ZWQgZnVuY3Rpb25zIHdoZW4gY2VydGFpbiBib3VuZGFyaWVzIGFy
ZSBub3QgbWV0IChlZy4NCj4gPj4+IHBhY2tldCBsYXVuY2h0aW1lKQ0KPiA+Pg0KPiA+PiBQbGVh
c2UgZG8gQ0MgcGVvcGxlIHdobyBhcmUgd29ya2luZyBvbiB0aGUgVk0gLyBQVFAgLyB2ZHNvIHRo
aW5nLCBhbmQNCj4gPj4gdGltZSBwZW9wbGUgbGlrZSB0Z2x4LiBBbmQgYW4gaW1wbGVtZW50YXRp
b24gZm9yIGEgcmVhbCBkZXZpY2Ugd291bGQNCj4gPj4gYmUgbmljZSB0byBlc3RhYmxpc2ggYXR0
ZW50aW9uLg0KPiA+DQo+ID4gTm90ZWQgLSB3aWxsIENDIGluIGZ1dHVyZSByZWxlYXNlcy4NCj4g
Pg0KPiA+IEFXUyBwbGFubmVkIHRoZSBpbXBsZW1lbnRhdGlvbiBpbiBFTkEgZHJpdmVyIC0gd2ls
bCB3b3JrIHdpdGggRGF2aWQgb24NCj4gPiBtYWtpbmcgaXQgcGFydCBvZiB0aGUgcGF0Y2hzZXQg
b25jZSB3ZSAidXBncmFkZSIgZnJvbSBhbiBSRkMgLSBidXQNCj4gPiB3YW50ZWQgdG8gZGlzY3Vz
cyB0aGUgYXBwcm9hY2ggZmlyc3QuDQo+IA0KPiBJIGNhbiBpbXBsZW1lbnQgdGhlIGludGVyZmFj
ZSBmb3IgT0NQIFRpbWVDYXJkIHRvbywgSSB0aGluayB3ZSBoYXZlIEhXDQo+IGluZm9ybWF0aW9u
IGFib3V0IGl0IGFscmVhZHkuDQoNCkNDIEFtaXQgQmVybnN0ZWluIChBV1MsIEVOQSBkcml2ZXIp
Lg0K

