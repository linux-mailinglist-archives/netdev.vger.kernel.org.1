Return-Path: <netdev+bounces-165143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8505A30ABB
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052D47A075A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614081F8AC5;
	Tue, 11 Feb 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="I0uQU/F2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE871F754A;
	Tue, 11 Feb 2025 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739274567; cv=none; b=oJkfZCQsEXNj8sn0+b/OT10ABkf3o8nu+x+iZN9P+bI8s/NQFuBhwjzQxxF4/6rjLw/GKjZq8kW+IwucIcVvD9Q4T87FIv666umY7OIjOhKCv4hhA4RxWg13VWV0m0RglUXawBZ97T56QwmVXvLIqkmAFYHqc4veDRq/I3EhapU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739274567; c=relaxed/simple;
	bh=RSrR31etPfWErYWuQDOoH5CdG8ajOEflXt5lHMpkXhI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BuEIp/1mlr4+uzmBFjSrvD6YYFCkjiH4us6nrPFcKV3JjkC/5y0CW1gFHZlE996ZGW3DhR4/izlluPboP8KuLQyhoFtLnfzgJ0L+OdAL4/ePK3lSbFa9MXabx77w2z6wwN61C2g2k6lu5n9fjbjw89HBiv+1SC9wwomVe+t6UEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=I0uQU/F2; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1739274566; x=1770810566;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=RSrR31etPfWErYWuQDOoH5CdG8ajOEflXt5lHMpkXhI=;
  b=I0uQU/F2yTvmAtnd2DrEOjBWSOFKtXtN0qsH++nvUL1yFe1eByiKtjeO
   gb3J2XVUXSz2ALEGODKygE37T4TLp1ME7vHv6ZBBhcmEEu1PzkG/nM5lQ
   kChX1Fz4dyAyPW5H+4aMt/RUzaXHKfrWF6Xk06VF9ZXdU2VNbVKOAtcZz
   s=;
X-IronPort-AV: E=Sophos;i="6.13,277,1732579200"; 
   d="scan'208";a="461536813"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:49:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:24326]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.31:2525] with esmtp (Farcaster)
 id 5ec35c9f-088f-4516-adef-c68c778defd9; Tue, 11 Feb 2025 11:49:16 +0000 (UTC)
X-Farcaster-Flow-ID: 5ec35c9f-088f-4516-adef-c68c778defd9
Received: from EX19D004ANA004.ant.amazon.com (10.37.240.146) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 11 Feb 2025 11:49:16 +0000
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19D004ANA004.ant.amazon.com (10.37.240.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Feb 2025 11:49:14 +0000
Received: from EX19D004ANA001.ant.amazon.com ([fe80::f099:cbca:cc6b:91ec]) by
 EX19D004ANA001.ant.amazon.com ([fe80::f099:cbca:cc6b:91ec%5]) with mapi id
 15.02.1544.014; Tue, 11 Feb 2025 11:49:14 +0000
From: "Iwashima, Kuniyuki" <kuniyu@amazon.co.jp>
To: Breno Leitao <leitao@debian.org>, Uday Shankar <ushankar@purestorage.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH net-next v2 2/2] net: Add dev_getbyhwaddr_rtnl() helper
Thread-Topic: [PATCH net-next v2 2/2] net: Add dev_getbyhwaddr_rtnl() helper
Thread-Index: AQHbfHr5TbFo5KdF2Umd+m4rD5vlBA==
Date: Tue, 11 Feb 2025 11:49:14 +0000
Message-ID: <9B3D8CD0-65DE-43FE-88BA-55902DE96496@amazon.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <629AC6E3330F8B459433207CFDFB63DF@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RnJvbTogQnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4NCkRhdGU6IFR1ZSwgMTEgRmVi
IDIwMjUgMDM6MzY6NDMgLTA4MDANCj4gPiA+ICtzdHJ1Y3QgbmV0X2RldmljZSAqZGV2X2dldGJ5
aHdhZGRyKHN0cnVjdCBuZXQgKm5ldCwgdW5zaWduZWQgc2hvcnQgdHlwZSwNCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpoYSkNCj4gPiA+ICt7DQo+ID4g
PiArICAgc3RydWN0IG5ldF9kZXZpY2UgKmRldjsNCj4gPiA+ICsNCj4gPiA+ICsgICBBU1NFUlRf
UlROTCgpOw0KPiA+ID4gKyAgIGZvcl9lYWNoX25ldGRldihuZXQsIGRldikNCj4gPiA+ICsgICAg
ICAgICAgIGlmIChkZXZfY29tcF9hZGRyKGRldiwgdHlwZSwgaGEpKQ0KPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICByZXR1cm4gZGV2Ow0KPiA+ID4gKw0KPiA+ID4gKyAgIHJldHVybiBOVUxMOw0K
PiA+ID4gK30NCj4gPiA+ICtFWFBPUlRfU1lNQk9MKGRldl9nZXRieWh3YWRkcik7DQo+ID4NCj4g
PiBDb21taXQgdGl0bGUgc2hvdWxkIGNoYW5nZSB0byByZWZsZWN0IHRoZSBuZXcgZnVuY3Rpb24g
bmFtZSBpbiB2Mi4NCj4gPg0KPiA+IFNlcGFyYXRlbHkgLSBob3cgc2hvdWxkIEkgY29tYmluZSB0
aGlzIHdpdGgNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNTAyMDUtbmV0
Y29uc29sZS12My0wLTEzMmEzMWYxNzE5OUBwdXJlc3RvcmFnZS5jb20vPw0KPiA+IEkgc2VlIHRo
cmVlIG9wdGlvbnM6DQo+ID4gLSBjb21iaW5lIHRoZSB0d28gc2VyaWVzIGludG8gb25lDQo+IA0K
PiBJIHdvdWxkIHN1Z2dlc3QgeW91IGNvbWJpbmUgdGhlIHR3byBzZXJpZXMgaW50byBvbmUuDQo+
IA0KPiBJIHdpbGwgc2VuZCBhIHYzIHRvZGF5IGFkanVzdGluZyB0aGUgY29tbWVudHMsIGFuZCB5
b3UgY2FuIGludGVncmF0ZWQNCj4gdGhlbSBpbnRvIHlvdXIgcGF0Y2hzZXQuDQoNCkkgc3VnZ2Vz
dCBCcmVubyBwb3N0IHYzIGZvciBuZXQuZ2l0IHdpdGggYXJwIGZpeCBhbmQgdGhlbiBuZXQuZ2l0
DQp3aWxsIGJlIG1lcmdlZCB0byBuZXQtbmV4dCBvbiBUaHVyc2RheSwgdGhlbiBVZGF5IGNhbiBy
ZXNwaW4uDQoNCklmIHRoaXMgaXMgcG9zdGVkIHRvIG5ldC1uZXh0LmdpdCwgdGhlIGZvbGxvd2lu
ZyBhcnAgZml4IG5lZWRzIHRvDQp3YWl0IGZvciB0aGUgbmV4dCBjeWNsZSBzbyB0aGF0IG5ldC1u
ZXh0LmdpdCB3aWxsIGJlIG1lcmdlZCB0bw0KbmV0LmdpdC4NCg0K

